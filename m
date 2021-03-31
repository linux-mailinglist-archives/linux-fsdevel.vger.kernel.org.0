Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A898350849
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Mar 2021 22:36:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236638AbhCaUfy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 31 Mar 2021 16:35:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:45336 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236613AbhCaUfX (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 31 Mar 2021 16:35:23 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4276861075;
        Wed, 31 Mar 2021 20:35:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617222922;
        bh=BgCOE323QK2JeVx28rknXxKqdm/ImMAtgrDBpemL8no=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WF9CCTP8J+73gVrlFLHMitELvkY3yVfYU9mBXUzK+WTZGz78JJuJCcGZTzU3QCfDY
         2EaDBEoA61zPwD6KI8rup0RpAa7WhrmgnVqRTe62jdBdamVVydzHyvKito21TI9nPb
         I6JJVNVmUdv5yjfUXya0h+9iZyOvZE1HcUdgFca88DrmcWlu9de70TKQN24g4dsrrS
         4aNirMuOcLzeXU+rVvzRsV7v2Aa3fy+/Zk888az1zxM9dxHA1NVyuk1mIYupqrusXz
         5vwyhHfXebmiIRu/RNt5mQvjP9g8w2+htlrK8tKMhFpsgeciV5Vj4gIv51WhLh9Gq/
         p7E7q2Fo+YmKA==
From:   Jeff Layton <jlayton@kernel.org>
To:     ceph-devel@vger.kernel.org
Cc:     linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [RFC PATCH v5 20/19] ceph: make ceph_get_name decrypt filenames
Date:   Wed, 31 Mar 2021 16:35:20 -0400
Message-Id: <20210331203520.65916-1-jlayton@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210326173227.96363-1-jlayton@kernel.org>
References: <20210326173227.96363-1-jlayton@kernel.org>
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

This patch is what's needed to fix the "busy inodes after umount"
issue I was seeing with xfstest generic/477, and also makes that
test pass reliably with mounts using -o test_dummy_encryption.

diff --git a/fs/ceph/export.c b/fs/ceph/export.c
index 17d8c8f4ec89..f4e3a17ffc01 100644
--- a/fs/ceph/export.c
+++ b/fs/ceph/export.c
@@ -7,6 +7,7 @@
 
 #include "super.h"
 #include "mds_client.h"
+#include "crypto.h"
 
 /*
  * Basic fh
@@ -516,7 +517,9 @@ static int ceph_get_name(struct dentry *parent, char *name,
 {
 	struct ceph_mds_client *mdsc;
 	struct ceph_mds_request *req;
+	struct inode *dir = d_inode(parent);
 	struct inode *inode = d_inode(child);
+	struct ceph_mds_reply_info_parsed *rinfo;
 	int err;
 
 	if (ceph_snap(inode) != CEPH_NOSNAP)
@@ -528,29 +531,46 @@ static int ceph_get_name(struct dentry *parent, char *name,
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

