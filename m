Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7F0D34AD92
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Mar 2021 18:33:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230406AbhCZRdO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 26 Mar 2021 13:33:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:48336 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230247AbhCZRck (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 26 Mar 2021 13:32:40 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C976061999;
        Fri, 26 Mar 2021 17:32:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616779960;
        bh=6xZpBiTnoHtIJkNEIvaZxzupy5U2KaTOn2huDHMP6ag=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oZ4VgQe18k+LrEELidgorJk3IkMRImwz+4Db6O05AGqr1A32VpMQDQFfFyVuSHtqR
         OaSwWGI+opoi4IbmV8f0o7EPJ+V4f3+spCodVKAJBQEzWNv5u/BgHbI57csDHdYcEs
         /7a4kd4sp9XQNauRcWXQ7pTsiX6Iq2daXRCXwamvpJCv2tuLJIkOLjxpYGLuImLXLC
         1syJjFOqGHK1RJ1CvvAFaq2wkJmiiK5uGZyb2d0aN+lwHug+WmvUCfGsgwqLi68ehC
         gPR2JwXvt6pHNn1CJyK41zOnCbwzc2iwkwa0PADbaMVUib2scqCZWWYhEvJlbBgtv2
         7d/b/sTjVQG9A==
From:   Jeff Layton <jlayton@kernel.org>
To:     ceph-devel@vger.kernel.org
Cc:     linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [RFC PATCH v5 16/19] ceph: add fscrypt support to ceph_fill_trace
Date:   Fri, 26 Mar 2021 13:32:24 -0400
Message-Id: <20210326173227.96363-17-jlayton@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210326173227.96363-1-jlayton@kernel.org>
References: <20210326173227.96363-1-jlayton@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

When we get a dentry in a trace, decrypt the name so we can properly
instantiate the dentry.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/ceph/inode.c | 30 ++++++++++++++++++++++++++++--
 1 file changed, 28 insertions(+), 2 deletions(-)

diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
index 64cdc4513c8a..39f4c0dfa071 100644
--- a/fs/ceph/inode.c
+++ b/fs/ceph/inode.c
@@ -1381,8 +1381,15 @@ int ceph_fill_trace(struct super_block *sb, struct ceph_mds_request *req)
 		if (dir && req->r_op == CEPH_MDS_OP_LOOKUPNAME &&
 		    test_bit(CEPH_MDS_R_PARENT_LOCKED, &req->r_req_flags) &&
 		    !test_bit(CEPH_MDS_R_ABORTED, &req->r_req_flags)) {
+			bool is_nokey = false;
 			struct qstr dname;
 			struct dentry *dn, *parent;
+			struct fscrypt_str oname = FSTR_INIT(NULL, 0);
+			struct ceph_fname fname = { .dir	= dir,
+						    .name	= rinfo->dname,
+						    .ctext	= rinfo->altname,
+						    .name_len	= rinfo->dname_len,
+						    .ctext_len	= rinfo->altname_len };
 
 			BUG_ON(!rinfo->head->is_target);
 			BUG_ON(req->r_dentry);
@@ -1390,8 +1397,20 @@ int ceph_fill_trace(struct super_block *sb, struct ceph_mds_request *req)
 			parent = d_find_any_alias(dir);
 			BUG_ON(!parent);
 
-			dname.name = rinfo->dname;
-			dname.len = rinfo->dname_len;
+			err = ceph_fname_alloc_buffer(dir, &oname);
+			if (err < 0) {
+				dput(parent);
+				goto done;
+			}
+
+			err = ceph_fname_to_usr(&fname, NULL, &oname, &is_nokey);
+			if (err < 0) {
+				dput(parent);
+				ceph_fname_free_buffer(dir, &oname);
+				goto done;
+			}
+			dname.name = oname.name;
+			dname.len = oname.len;
 			dname.hash = full_name_hash(parent, dname.name, dname.len);
 			tvino.ino = le64_to_cpu(rinfo->targeti.in->ino);
 			tvino.snap = le64_to_cpu(rinfo->targeti.in->snapid);
@@ -1406,9 +1425,15 @@ int ceph_fill_trace(struct super_block *sb, struct ceph_mds_request *req)
 				     dname.len, dname.name, dn);
 				if (!dn) {
 					dput(parent);
+					ceph_fname_free_buffer(dir, &oname);
 					err = -ENOMEM;
 					goto done;
 				}
+				if (is_nokey) {
+					spin_lock(&dn->d_lock);
+					dn->d_flags |= DCACHE_NOKEY_NAME;
+					spin_unlock(&dn->d_lock);
+				}
 				err = 0;
 			} else if (d_really_is_positive(dn) &&
 				   (ceph_ino(d_inode(dn)) != tvino.ino ||
@@ -1420,6 +1445,7 @@ int ceph_fill_trace(struct super_block *sb, struct ceph_mds_request *req)
 				dput(dn);
 				goto retry_lookup;
 			}
+			ceph_fname_free_buffer(dir, &oname);
 
 			req->r_dentry = dn;
 			dput(parent);
-- 
2.30.2

