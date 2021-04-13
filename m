Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6290D35E596
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Apr 2021 19:52:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347478AbhDMRvl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 13 Apr 2021 13:51:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:44992 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1347438AbhDMRv1 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 13 Apr 2021 13:51:27 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 34DE0613B6;
        Tue, 13 Apr 2021 17:51:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618336266;
        bh=jcDrx7LLRF97mNKTEOYiMBgIjq7/ymJfyMoNF9m9bl0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZJmqbaO5DHihf5MpdRYfSQnbXyibXDnohdbSP1AcH8hOW2scxcaWXQbuBwE5UeiKD
         BMB+uxiW0MfrODNeZyvhSUaWWXjbvo8zkUvv1x9z4m+k5cSe/WAkwNAtdwFyJfWZzG
         UsFbeejeoSA0U6X4cBxQ50nW31fQHkBgz9XGFOAC9wDlN5dFQHEhp/o8WJSvv+/YGT
         n1VK0v6doMTZawkPdHt9dtPw/oJHm1ohElsqsXT5v6F/A1GBRz3GV9u48hFZlu9NzG
         yJq/ACKeAYOgp4W4Ek2FxsfQE71STmvQUldOq/AqNywNwF7peS78HTsn3MFTkt43ir
         61P7GErVw2HEg==
From:   Jeff Layton <jlayton@kernel.org>
To:     ceph-devel@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-fscrypt@vger.kernel.org,
        lhenriques@suse.de
Subject: [RFC PATCH v6 19/20] ceph: make ceph_get_name decrypt filenames
Date:   Tue, 13 Apr 2021 13:50:51 -0400
Message-Id: <20210413175052.163865-20-jlayton@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210413175052.163865-1-jlayton@kernel.org>
References: <20210413175052.163865-1-jlayton@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

When we do a lookupino to the MDS, we get a filename in the trace.
ceph_get_name uses that name directly, so we must properly decrypt
it before copying it to the name buffer.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/ceph/export.c | 42 +++++++++++++++++++++++++++++++-----------
 1 file changed, 31 insertions(+), 11 deletions(-)

diff --git a/fs/ceph/export.c b/fs/ceph/export.c
index 65540a4429b2..c81af82568fd 100644
--- a/fs/ceph/export.c
+++ b/fs/ceph/export.c
@@ -7,6 +7,7 @@
 
 #include "super.h"
 #include "mds_client.h"
+#include "crypto.h"
 
 /*
  * Basic fh
@@ -524,7 +525,9 @@ static int ceph_get_name(struct dentry *parent, char *name,
 {
 	struct ceph_mds_client *mdsc;
 	struct ceph_mds_request *req;
+	struct inode *dir = d_inode(parent);
 	struct inode *inode = d_inode(child);
+	struct ceph_mds_reply_info_parsed *rinfo;
 	int err;
 
 	if (ceph_snap(inode) != CEPH_NOSNAP)
@@ -536,29 +539,46 @@ static int ceph_get_name(struct dentry *parent, char *name,
 	if (IS_ERR(req))
 		return PTR_ERR(req);
 
-	inode_lock(d_inode(parent));
-
+	inode_lock(dir);
 	req->r_inode = inode;
 	ihold(inode);
 	req->r_ino2 = ceph_vino(d_inode(parent));
-	req->r_parent = d_inode(parent);
+	req->r_parent = dir;
 	set_bit(CEPH_MDS_R_PARENT_LOCKED, &req->r_req_flags);
 	req->r_num_caps = 2;
 	err = ceph_mdsc_do_request(mdsc, NULL, req);
+	inode_unlock(dir);
 
-	inode_unlock(d_inode(parent));
+	if (err)
+		goto out;
 
-	if (!err) {
-		struct ceph_mds_reply_info_parsed *rinfo = &req->r_reply_info;
+	rinfo = &req->r_reply_info;
+	if (!IS_ENCRYPTED(dir)) {
 		memcpy(name, rinfo->dname, rinfo->dname_len);
 		name[rinfo->dname_len] = 0;
-		dout("get_name %p ino %llx.%llx name %s\n",
-		     child, ceph_vinop(inode), name);
 	} else {
-		dout("get_name %p ino %llx.%llx err %d\n",
-		     child, ceph_vinop(inode), err);
-	}
+		struct fscrypt_str oname = FSTR_INIT(NULL, 0);
+		struct ceph_fname fname = { .dir	= dir,
+					    .name	= rinfo->dname,
+					    .ctext	= rinfo->altname,
+					    .name_len	= rinfo->dname_len,
+					    .ctext_len	= rinfo->altname_len };
+
+		err = ceph_fname_alloc_buffer(dir, &oname);
+		if (err < 0)
+			goto out;
 
+		err = ceph_fname_to_usr(&fname, NULL, &oname, NULL);
+		if (!err) {
+			memcpy(name, oname.name, oname.len);
+			name[oname.len] = 0;
+		}
+		ceph_fname_free_buffer(dir, &oname);
+	}
+out:
+	dout("get_name %p ino %llx.%llx err %d %s%s\n",
+		     child, ceph_vinop(inode), err,
+		     err ? "" : "name ", err ? "" : name);
 	ceph_mdsc_put_request(req);
 	return err;
 }
-- 
2.30.2

