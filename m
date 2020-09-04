Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B07D25DF21
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Sep 2020 18:06:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727969AbgIDQGc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 4 Sep 2020 12:06:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:51308 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727965AbgIDQFx (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 4 Sep 2020 12:05:53 -0400
Received: from tleilax.com (68-20-15-154.lightspeed.rlghnc.sbcglobal.net [68.20.15.154])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 47B6820795;
        Fri,  4 Sep 2020 16:05:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599235552;
        bh=90Pjn6niQISxMuTZw2qsWFhkmn8VzkRJzBny3pfcgr0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Wo3+ym1VH+1BCt3catzUZr2BZFJBtrQWU3YrefcJ0RhtFXzZTnahO8d6+a8uzD8/H
         gSSRFZDXP8kOoVUEfrT1Vmog44PEW3YbSt3VzIDWhJrsLYGoa/wGroPMhHcZsfWf6T
         M8lcCseF2cFWafZiawVfIjJB5BhgDgqFmIzVHgMU=
From:   Jeff Layton <jlayton@kernel.org>
To:     ceph-devel@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-fscrypt@vger.kernel.org,
        ebiggers@kernel.org
Subject: [RFC PATCH v2 17/18] ceph: add fscrypt support to ceph_fill_trace
Date:   Fri,  4 Sep 2020 12:05:36 -0400
Message-Id: <20200904160537.76663-18-jlayton@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200904160537.76663-1-jlayton@kernel.org>
References: <20200904160537.76663-1-jlayton@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

When we get a dentry in a trace, decrypt the name so we can properly
instantiate the dentry.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/ceph/inode.c | 24 ++++++++++++++++++++++--
 1 file changed, 22 insertions(+), 2 deletions(-)

diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
index 7d66f41a6592..e578e4cdcf30 100644
--- a/fs/ceph/inode.c
+++ b/fs/ceph/inode.c
@@ -1328,6 +1328,7 @@ int ceph_fill_trace(struct super_block *sb, struct ceph_mds_request *req)
 		    !test_bit(CEPH_MDS_R_ABORTED, &req->r_req_flags)) {
 			struct qstr dname;
 			struct dentry *dn, *parent;
+			struct fscrypt_str oname = FSTR_INIT(NULL, 0);
 
 			BUG_ON(!rinfo->head->is_target);
 			BUG_ON(req->r_dentry);
@@ -1335,8 +1336,20 @@ int ceph_fill_trace(struct super_block *sb, struct ceph_mds_request *req)
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
+			err = ceph_fname_to_usr(dir, rinfo->dname, rinfo->dname_len, NULL, &oname);
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
@@ -1351,9 +1364,15 @@ int ceph_fill_trace(struct super_block *sb, struct ceph_mds_request *req)
 				     dname.len, dname.name, dn);
 				if (!dn) {
 					dput(parent);
+					ceph_fname_free_buffer(dir, &oname);
 					err = -ENOMEM;
 					goto done;
 				}
+				if (IS_ENCRYPTED(dir) && !fscrypt_has_encryption_key(dir)) {
+					spin_lock(&dn->d_lock);
+					dn->d_flags |= DCACHE_ENCRYPTED_NAME;
+					spin_unlock(&dn->d_lock);
+				}
 				err = 0;
 			} else if (d_really_is_positive(dn) &&
 				   (ceph_ino(d_inode(dn)) != tvino.ino ||
@@ -1365,6 +1384,7 @@ int ceph_fill_trace(struct super_block *sb, struct ceph_mds_request *req)
 				dput(dn);
 				goto retry_lookup;
 			}
+			ceph_fname_free_buffer(dir, &oname);
 
 			req->r_dentry = dn;
 			dput(parent);
-- 
2.26.2

