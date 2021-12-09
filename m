Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A75146EBBD
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Dec 2021 16:37:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240241AbhLIPlI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Dec 2021 10:41:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240246AbhLIPkn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Dec 2021 10:40:43 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A7A1C061746;
        Thu,  9 Dec 2021 07:37:09 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id E8B68CE267B;
        Thu,  9 Dec 2021 15:37:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA240C341C3;
        Thu,  9 Dec 2021 15:37:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639064226;
        bh=o286TTVP0aCJfYdYFotnaBXTipFImyN49DabvTAjyE8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CDMad8YJdPxVP++sWlRwmOzCvzRMm4dhOaVXAE7MNNQorfr0F2X1IVv1xptsx3z6c
         f6+2R4LIbMYKoIFxZpMc7uHbYogFtkPJYqyUuAr2IHFW6UzzDi2ItyGhpW467rhtGu
         UUUF6l7JsdYYGPR6XrQIFRAhKdE10fzz9uy5P0tc7AiRBFXngT+9gzlHYQfLZ+ypf/
         ch3aMt3/JXdnUh7P4BOX6zqWp3Rx5MU6nZspMo+burn5Cin087h/dME1yLfQwC2ZDm
         JjkBGsJ9PAA2UUw7U5Xg+3MxPjMrNa8xWdC7/8tocr1StnhPoCqYVMt2kNf1pfFMwj
         hqb+2dDsBb7rQ==
From:   Jeff Layton <jlayton@kernel.org>
To:     ceph-devel@vger.kernel.org
Cc:     linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 24/36] ceph: make ceph_get_name decrypt filenames
Date:   Thu,  9 Dec 2021 10:36:35 -0500
Message-Id: <20211209153647.58953-25-jlayton@kernel.org>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211209153647.58953-1-jlayton@kernel.org>
References: <20211209153647.58953-1-jlayton@kernel.org>
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
 fs/ceph/export.c | 44 ++++++++++++++++++++++++++++++++------------
 1 file changed, 32 insertions(+), 12 deletions(-)

diff --git a/fs/ceph/export.c b/fs/ceph/export.c
index e0fa66ac8b9f..0ebf2bd93055 100644
--- a/fs/ceph/export.c
+++ b/fs/ceph/export.c
@@ -7,6 +7,7 @@
 
 #include "super.h"
 #include "mds_client.h"
+#include "crypto.h"
 
 /*
  * Basic fh
@@ -534,7 +535,9 @@ static int ceph_get_name(struct dentry *parent, char *name,
 {
 	struct ceph_mds_client *mdsc;
 	struct ceph_mds_request *req;
+	struct inode *dir = d_inode(parent);
 	struct inode *inode = d_inode(child);
+	struct ceph_mds_reply_info_parsed *rinfo;
 	int err;
 
 	if (ceph_snap(inode) != CEPH_NOSNAP)
@@ -546,30 +549,47 @@ static int ceph_get_name(struct dentry *parent, char *name,
 	if (IS_ERR(req))
 		return PTR_ERR(req);
 
-	inode_lock(d_inode(parent));
-
+	inode_lock(dir);
 	req->r_inode = inode;
 	ihold(inode);
 	req->r_ino2 = ceph_vino(d_inode(parent));
-	req->r_parent = d_inode(parent);
-	ihold(req->r_parent);
+	req->r_parent = dir;
+	ihold(dir);
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
2.33.1

