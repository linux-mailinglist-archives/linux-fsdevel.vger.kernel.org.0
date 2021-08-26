Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC20F3F8BE4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Aug 2021 18:21:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243125AbhHZQV0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 26 Aug 2021 12:21:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:44914 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243156AbhHZQVW (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 26 Aug 2021 12:21:22 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 88B9361158;
        Thu, 26 Aug 2021 16:20:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629994835;
        bh=nuQtk0V9pCocll+wu2WF2Xhw6qg/B/2QFm/xZCRt9m8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=S9RKbnZBF8llJp19vHrzjUokXMSfXqPlaqSQVtDCWSpUBtHykIpztD3CUzGrIwx0H
         mBG+VVyE4nWVXfERvCzXC9Wj3dJqmsf7fgcvCDTmLLG26ms9Ng8qJTgr865DmNQUjE
         LDSfpaj+M1dLdHrJcqrmr2TYuvap2LeYRksnBCARgq3DwyRgnOcW46z26WyQ/xenSa
         frhUqm2tphPLrsGApgAmVZILJdb892T1iw3p/zdOcpiljXF3Z1M98Kc4+IBYZ1acmI
         nvy5q9rZzawcx3KHpqZNV5x73a5Z2IJ4HukKUN7XFue2FNFG6VBOxKhFrU3JqJilSu
         anMN8XEf/s6qg==
From:   Jeff Layton <jlayton@kernel.org>
To:     ceph-devel@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-fscrypt@vger.kernel.org,
        dhowells@redhat.com, xiubli@redhat.com, lhenriques@suse.de,
        khiremat@redhat.com, ebiggers@kernel.org
Subject: [RFC PATCH v8 20/24] ceph: add fscrypt support to ceph_fill_trace
Date:   Thu, 26 Aug 2021 12:20:10 -0400
Message-Id: <20210826162014.73464-21-jlayton@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210826162014.73464-1-jlayton@kernel.org>
References: <20210826162014.73464-1-jlayton@kernel.org>
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
index 3cb941fc334c..b8abbb0cdb83 100644
--- a/fs/ceph/inode.c
+++ b/fs/ceph/inode.c
@@ -1395,8 +1395,15 @@ int ceph_fill_trace(struct super_block *sb, struct ceph_mds_request *req)
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
@@ -1404,8 +1411,20 @@ int ceph_fill_trace(struct super_block *sb, struct ceph_mds_request *req)
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
@@ -1420,9 +1439,15 @@ int ceph_fill_trace(struct super_block *sb, struct ceph_mds_request *req)
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
@@ -1434,6 +1459,7 @@ int ceph_fill_trace(struct super_block *sb, struct ceph_mds_request *req)
 				dput(dn);
 				goto retry_lookup;
 			}
+			ceph_fname_free_buffer(dir, &oname);
 
 			req->r_dentry = dn;
 			dput(parent);
-- 
2.31.1

