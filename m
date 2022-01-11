Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FBDF48B6E0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Jan 2022 20:17:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350659AbiAKTRM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Jan 2022 14:17:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350671AbiAKTQ4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Jan 2022 14:16:56 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1F83C03327E;
        Tue, 11 Jan 2022 11:16:27 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B487061785;
        Tue, 11 Jan 2022 19:16:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB057C36AE9;
        Tue, 11 Jan 2022 19:16:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641928587;
        bh=OYGuNUeRNJ4Tz32PHHkw4r0EK4D+qb9xhn9T5WcqY7U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mU1qWP9lSsPmrTYkFfnq76bm/XNm7ZpzZbaeoAXVynF2ZYNfkzUw169eRMBVbawCe
         JfZf39DksO169FHheB8XYAIRzYEfNWrV8ZDvBYnMIbz9Sluh8+FyA5lhNc69v9q3Xg
         OixCeZfZzXPls1fwQcsLbZ8jWB5tYMzskKfyl0cdZ0vmJGC8KiTqG9lSP7Y9Eo4W7W
         tqpn/91FYDDN0iZjJ4/ybAcpCAFCoiTkb3m2n6PsPid5PjGrVqLk+cZY4E3mLXM4N+
         RcVNoTmxiaIgOO0tsO701cSrfCZKHDYjGlJMgLenVG7iZ/9Ob9H7sWMreskDenQ7Rh
         ZIqlicHtpUlhw==
From:   Jeff Layton <jlayton@kernel.org>
To:     ceph-devel@vger.kernel.org, linux-fscrypt@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, idryomov@gmail.com
Subject: [RFC PATCH v10 23/48] ceph: make ceph_get_name decrypt filenames
Date:   Tue, 11 Jan 2022 14:15:43 -0500
Message-Id: <20220111191608.88762-24-jlayton@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220111191608.88762-1-jlayton@kernel.org>
References: <20220111191608.88762-1-jlayton@kernel.org>
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
2.34.1

