Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 485BA48B6EA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Jan 2022 20:17:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350830AbiAKTRR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Jan 2022 14:17:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350580AbiAKTQz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Jan 2022 14:16:55 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA919C03400E;
        Tue, 11 Jan 2022 11:16:25 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9D04B61786;
        Tue, 11 Jan 2022 19:16:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9706BC36AEF;
        Tue, 11 Jan 2022 19:16:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641928585;
        bh=MixxEqsS5D5D0FdwucF6DCgRvjW3PrFS61eI5ek2BWI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ae2y+HWpfifuuN6epsu2C00KjZtOmdCyTbQQL/F+7WLosRhI1dxG0ug4heIuoz1qF
         K2NaQ/qNCjz3N6Cmbez5/UaB7fJfDquX4xFPQ/tUV9AmmgUa6F/nLMnwNOYadvquJY
         qccsCHGbakZfDsItArzpm7LttI8J/vtOPur1lpnd84QUDSwvfRE/zwKulq3jsUspXW
         9pkKPHQ8V0BDGyOuehvspQap7j+tTbh4WEynm5+3qj5ynTbQRoCyiKGrEj8G34hvsK
         amvVrLjuXXFzkAiMv/PKCScz3u5eyjJSqGX6sUlFb7mFhS7A700VySS34q3dJqYoYn
         BBVWBYBjoXArg==
From:   Jeff Layton <jlayton@kernel.org>
To:     ceph-devel@vger.kernel.org, linux-fscrypt@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, idryomov@gmail.com
Subject: [RFC PATCH v10 20/48] ceph: add fscrypt support to ceph_fill_trace
Date:   Tue, 11 Jan 2022 14:15:40 -0500
Message-Id: <20220111191608.88762-21-jlayton@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220111191608.88762-1-jlayton@kernel.org>
References: <20220111191608.88762-1-jlayton@kernel.org>
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
index 55e23e2601df..28a5b70e5521 100644
--- a/fs/ceph/inode.c
+++ b/fs/ceph/inode.c
@@ -1397,8 +1397,15 @@ int ceph_fill_trace(struct super_block *sb, struct ceph_mds_request *req)
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
@@ -1406,8 +1413,20 @@ int ceph_fill_trace(struct super_block *sb, struct ceph_mds_request *req)
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
@@ -1422,9 +1441,15 @@ int ceph_fill_trace(struct super_block *sb, struct ceph_mds_request *req)
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
@@ -1436,6 +1461,7 @@ int ceph_fill_trace(struct super_block *sb, struct ceph_mds_request *req)
 				dput(dn);
 				goto retry_lookup;
 			}
+			ceph_fname_free_buffer(dir, &oname);
 
 			req->r_dentry = dn;
 			dput(parent);
-- 
2.34.1

