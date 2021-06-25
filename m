Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 127E93B4524
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Jun 2021 15:59:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232228AbhFYOBi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 25 Jun 2021 10:01:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:33130 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231946AbhFYOBM (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 25 Jun 2021 10:01:12 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id DF2BF61985;
        Fri, 25 Jun 2021 13:58:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624629531;
        bh=I2weRRalPkKeNX1MLKiOjId9hFrvSjCuQVQHPYNPKWs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EcY4AXnITyp4wXRao0fFs/HIN/4eOsZjqqqz3DPTY3uIBqi6erargJYxO7KAqaYit
         2nXWtd+oInXYRKDqn5twgQjlug7cqGJh5mu1yhx4P6aUSwHlrBxVcQY+G1OhCknNJ1
         tgRkvOzbS/+DAkOmq4Frz4KVSrQonJ0gDNTwQAWUIDUBC7Gioov998+/1bkrZd+QXh
         hQCZE7Di1HAS6KnCOVZNj90cZ6KG02wc1/jRs5IfNvVIHVe+xHsYX75QeBnaBBWY9n
         /BHT9XP9peBTSO+w0m0Xc0q0elaQAmjjM5IBvBA5G4ZIwi5+dnsIC7xOx3/ca1poMH
         pRoBotmZSG/Pw==
From:   Jeff Layton <jlayton@kernel.org>
To:     ceph-devel@vger.kernel.org
Cc:     lhenriques@suse.de, xiubli@redhat.com,
        linux-fsdevel@vger.kernel.org, linux-fscrypt@vger.kernel.org,
        dhowells@redhat.com
Subject: [RFC PATCH v7 20/24] ceph: add fscrypt support to ceph_fill_trace
Date:   Fri, 25 Jun 2021 09:58:30 -0400
Message-Id: <20210625135834.12934-21-jlayton@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210625135834.12934-1-jlayton@kernel.org>
References: <20210625135834.12934-1-jlayton@kernel.org>
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
index a0b311195e80..09f98b89ee1a 100644
--- a/fs/ceph/inode.c
+++ b/fs/ceph/inode.c
@@ -1401,8 +1401,15 @@ int ceph_fill_trace(struct super_block *sb, struct ceph_mds_request *req)
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
@@ -1410,8 +1417,20 @@ int ceph_fill_trace(struct super_block *sb, struct ceph_mds_request *req)
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
@@ -1426,9 +1445,15 @@ int ceph_fill_trace(struct super_block *sb, struct ceph_mds_request *req)
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
@@ -1440,6 +1465,7 @@ int ceph_fill_trace(struct super_block *sb, struct ceph_mds_request *req)
 				dput(dn);
 				goto retry_lookup;
 			}
+			ceph_fname_free_buffer(dir, &oname);
 
 			req->r_dentry = dn;
 			dput(parent);
-- 
2.31.1

