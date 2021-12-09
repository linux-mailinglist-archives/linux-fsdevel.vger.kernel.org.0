Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1C0E46EBB3
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Dec 2021 16:37:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240436AbhLIPk7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Dec 2021 10:40:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240116AbhLIPkk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Dec 2021 10:40:40 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 671BAC061A32;
        Thu,  9 Dec 2021 07:37:05 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 12124B82504;
        Thu,  9 Dec 2021 15:37:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56115C341C3;
        Thu,  9 Dec 2021 15:37:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639064224;
        bh=dRP1FoTA7cxftbLAZzCxu5fxWo+DYeYwl6YPcqCnY9A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FtiSOKQPiwb0q0dElGDrtFZ9YA4ok+H4psKR/WenAw3OTQ3KjtA2Gtki69YB/h8Hx
         aegSu9chiaTsBbTOOEpChBgaHm4shmrD/vhtwM+xVL6oqohSFS6fIcia0MmROwoWsu
         6iU8XhvIS6J9/K2CPUF+Sk+SoWbhzYqYEHAfhLpOEpE4S2rk07rw9OAojiUeCdiRXD
         DO+3jBOfuW8orhNaM0BofBnarc0Ci3/6frSBJvPmGi5UZn4rk96fHFZ1poUmZldLrL
         FTN1h+IPglkR5EYIYlivLuOsBoWbSe+BklIYI0wLTYrtnJeiKBsa6cL/28u3PHQCD2
         YkXcetm0Utfug==
From:   Jeff Layton <jlayton@kernel.org>
To:     ceph-devel@vger.kernel.org
Cc:     linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 22/36] ceph: add support to readdir for encrypted filenames
Date:   Thu,  9 Dec 2021 10:36:33 -0500
Message-Id: <20211209153647.58953-23-jlayton@kernel.org>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211209153647.58953-1-jlayton@kernel.org>
References: <20211209153647.58953-1-jlayton@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add helper functions for buffer management and for decrypting filenames
returned by the MDS. Wire those into the readdir codepaths.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/ceph/dir.c   | 62 +++++++++++++++++++++++++++++++++++++++----------
 fs/ceph/inode.c | 38 +++++++++++++++++++++++++++---
 2 files changed, 85 insertions(+), 15 deletions(-)

diff --git a/fs/ceph/dir.c b/fs/ceph/dir.c
index 7977484d0317..f8812c976ba0 100644
--- a/fs/ceph/dir.c
+++ b/fs/ceph/dir.c
@@ -9,6 +9,7 @@
 
 #include "super.h"
 #include "mds_client.h"
+#include "crypto.h"
 
 /*
  * Directory operations: readdir, lookup, create, link, unlink,
@@ -241,7 +242,9 @@ static int __dcache_readdir(struct file *file,  struct dir_context *ctx,
 		di = ceph_dentry(dentry);
 		if (d_unhashed(dentry) ||
 		    d_really_is_negative(dentry) ||
-		    di->lease_shared_gen != shared_gen) {
+		    di->lease_shared_gen != shared_gen ||
+		    ((dentry->d_flags & DCACHE_NOKEY_NAME) &&
+		     fscrypt_has_encryption_key(dir))) {
 			spin_unlock(&dentry->d_lock);
 			dput(dentry);
 			err = -EAGAIN;
@@ -313,6 +316,8 @@ static int ceph_readdir(struct file *file, struct dir_context *ctx)
 	int err;
 	unsigned frag = -1;
 	struct ceph_mds_reply_info_parsed *rinfo;
+	struct fscrypt_str tname = FSTR_INIT(NULL, 0);
+	struct fscrypt_str oname = FSTR_INIT(NULL, 0);
 
 	dout("readdir %p file %p pos %llx\n", inode, file, ctx->pos);
 	if (dfi->file_info.flags & CEPH_F_ATEND)
@@ -340,6 +345,10 @@ static int ceph_readdir(struct file *file, struct dir_context *ctx)
 		ctx->pos = 2;
 	}
 
+	err = fscrypt_prepare_readdir(inode);
+	if (err)
+		goto out;
+
 	spin_lock(&ci->i_ceph_lock);
 	/* request Fx cap. if have Fx, we don't need to release Fs cap
 	 * for later create/unlink. */
@@ -360,6 +369,14 @@ static int ceph_readdir(struct file *file, struct dir_context *ctx)
 		spin_unlock(&ci->i_ceph_lock);
 	}
 
+	err = ceph_fname_alloc_buffer(inode, &tname);
+	if (err < 0)
+		goto out;
+
+	err = ceph_fname_alloc_buffer(inode, &oname);
+	if (err < 0)
+		goto out;
+
 	/* proceed with a normal readdir */
 more:
 	/* do we have the correct frag content buffered? */
@@ -387,12 +404,14 @@ static int ceph_readdir(struct file *file, struct dir_context *ctx)
 		dout("readdir fetching %llx.%llx frag %x offset '%s'\n",
 		     ceph_vinop(inode), frag, dfi->last_name);
 		req = ceph_mdsc_create_request(mdsc, op, USE_AUTH_MDS);
-		if (IS_ERR(req))
-			return PTR_ERR(req);
+		if (IS_ERR(req)) {
+			err = PTR_ERR(req);
+			goto out;
+		}
 		err = ceph_alloc_readdir_reply_buffer(req, inode);
 		if (err) {
 			ceph_mdsc_put_request(req);
-			return err;
+			goto out;
 		}
 		/* hints to request -> mds selection code */
 		req->r_direct_mode = USE_AUTH_MDS;
@@ -405,7 +424,8 @@ static int ceph_readdir(struct file *file, struct dir_context *ctx)
 			req->r_path2 = kstrdup(dfi->last_name, GFP_KERNEL);
 			if (!req->r_path2) {
 				ceph_mdsc_put_request(req);
-				return -ENOMEM;
+				err = -ENOMEM;
+				goto out;
 			}
 		} else if (is_hash_order(ctx->pos)) {
 			req->r_args.readdir.offset_hash =
@@ -426,7 +446,7 @@ static int ceph_readdir(struct file *file, struct dir_context *ctx)
 		err = ceph_mdsc_do_request(mdsc, NULL, req);
 		if (err < 0) {
 			ceph_mdsc_put_request(req);
-			return err;
+			goto out;
 		}
 		dout("readdir got and parsed readdir result=%d on "
 		     "frag %x, end=%d, complete=%d, hash_order=%d\n",
@@ -479,7 +499,7 @@ static int ceph_readdir(struct file *file, struct dir_context *ctx)
 			err = note_last_dentry(dfi, rde->name, rde->name_len,
 					       next_offset);
 			if (err)
-				return err;
+				goto out;
 		} else if (req->r_reply_info.dir_end) {
 			dfi->next_offset = 2;
 			/* keep last name */
@@ -507,22 +527,37 @@ static int ceph_readdir(struct file *file, struct dir_context *ctx)
 	}
 	for (; i < rinfo->dir_nr; i++) {
 		struct ceph_mds_reply_dir_entry *rde = rinfo->dir_entries + i;
+		struct ceph_fname fname = { .dir	= inode,
+					    .name	= rde->name,
+					    .name_len	= rde->name_len,
+					    .ctext	= rde->altname,
+					    .ctext_len	= rde->altname_len };
+		u32 olen = oname.len;
 
 		BUG_ON(rde->offset < ctx->pos);
+		BUG_ON(!rde->inode.in);
 
 		ctx->pos = rde->offset;
 		dout("readdir (%d/%d) -> %llx '%.*s' %p\n",
 		     i, rinfo->dir_nr, ctx->pos,
 		     rde->name_len, rde->name, &rde->inode.in);
 
-		BUG_ON(!rde->inode.in);
+		err = ceph_fname_to_usr(&fname, &tname, &oname, NULL);
+		if (err) {
+			dout("Unable to decode %.*s. Skipping it.\n", rde->name_len, rde->name);
+			continue;
+		}
 
-		if (!dir_emit(ctx, rde->name, rde->name_len,
+		if (!dir_emit(ctx, oname.name, oname.len,
 			      ceph_present_ino(inode->i_sb, le64_to_cpu(rde->inode.in->ino)),
 			      le32_to_cpu(rde->inode.in->mode) >> 12)) {
 			dout("filldir stopping us...\n");
-			return 0;
+			err = 0;
+			goto out;
 		}
+
+		/* Reset the lengths to their original allocated vals */
+		oname.len = olen;
 		ctx->pos++;
 	}
 
@@ -577,9 +612,12 @@ static int ceph_readdir(struct file *file, struct dir_context *ctx)
 					dfi->dir_ordered_count);
 		spin_unlock(&ci->i_ceph_lock);
 	}
-
+	err = 0;
 	dout("readdir %p file %p done.\n", inode, file);
-	return 0;
+out:
+	ceph_fname_free_buffer(inode, &tname);
+	ceph_fname_free_buffer(inode, &oname);
+	return err;
 }
 
 static void reset_readdir(struct ceph_dir_file_info *dfi)
diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
index 6b2e639827ef..37cb0d334cf2 100644
--- a/fs/ceph/inode.c
+++ b/fs/ceph/inode.c
@@ -1735,7 +1735,8 @@ int ceph_readdir_prepopulate(struct ceph_mds_request *req,
 			     struct ceph_mds_session *session)
 {
 	struct dentry *parent = req->r_dentry;
-	struct ceph_inode_info *ci = ceph_inode(d_inode(parent));
+	struct inode *inode = d_inode(parent);
+	struct ceph_inode_info *ci = ceph_inode(inode);
 	struct ceph_mds_reply_info_parsed *rinfo = &req->r_reply_info;
 	struct qstr dname;
 	struct dentry *dn;
@@ -1745,6 +1746,8 @@ int ceph_readdir_prepopulate(struct ceph_mds_request *req,
 	u32 last_hash = 0;
 	u32 fpos_offset;
 	struct ceph_readdir_cache_control cache_ctl = {};
+	struct fscrypt_str tname = FSTR_INIT(NULL, 0);
+	struct fscrypt_str oname = FSTR_INIT(NULL, 0);
 
 	if (test_bit(CEPH_MDS_R_ABORTED, &req->r_req_flags))
 		return readdir_prepopulate_inodes_only(req, session);
@@ -1796,14 +1799,36 @@ int ceph_readdir_prepopulate(struct ceph_mds_request *req,
 	cache_ctl.index = req->r_readdir_cache_idx;
 	fpos_offset = req->r_readdir_offset;
 
+	err = ceph_fname_alloc_buffer(inode, &tname);
+	if (err < 0)
+		goto out;
+
+	err = ceph_fname_alloc_buffer(inode, &oname);
+	if (err < 0)
+		goto out;
+
 	/* FIXME: release caps/leases if error occurs */
 	for (i = 0; i < rinfo->dir_nr; i++) {
+		bool is_nokey = false;
 		struct ceph_mds_reply_dir_entry *rde = rinfo->dir_entries + i;
 		struct ceph_vino tvino;
+		u32 olen = oname.len;
+		struct ceph_fname fname = { .dir	= inode,
+					    .name	= rde->name,
+					    .name_len	= rde->name_len,
+					    .ctext	= rde->altname,
+					    .ctext_len	= rde->altname_len };
+
+		err = ceph_fname_to_usr(&fname, &tname, &oname, &is_nokey);
+		if (err) {
+			dout("Unable to decode %.*s. Skipping it.", rde->name_len, rde->name);
+			continue;
+		}
 
-		dname.name = rde->name;
-		dname.len = rde->name_len;
+		dname.name = oname.name;
+		dname.len = oname.len;
 		dname.hash = full_name_hash(parent, dname.name, dname.len);
+		oname.len = olen;
 
 		tvino.ino = le64_to_cpu(rde->inode.in->ino);
 		tvino.snap = le64_to_cpu(rde->inode.in->snapid);
@@ -1834,6 +1859,11 @@ int ceph_readdir_prepopulate(struct ceph_mds_request *req,
 				err = -ENOMEM;
 				goto out;
 			}
+			if (is_nokey) {
+				spin_lock(&dn->d_lock);
+				dn->d_flags |= DCACHE_NOKEY_NAME;
+				spin_unlock(&dn->d_lock);
+			}
 		} else if (d_really_is_positive(dn) &&
 			   (ceph_ino(d_inode(dn)) != tvino.ino ||
 			    ceph_snap(d_inode(dn)) != tvino.snap)) {
@@ -1922,6 +1952,8 @@ int ceph_readdir_prepopulate(struct ceph_mds_request *req,
 		req->r_readdir_cache_idx = cache_ctl.index;
 	}
 	ceph_readdir_cache_release(&cache_ctl);
+	ceph_fname_free_buffer(inode, &tname);
+	ceph_fname_free_buffer(inode, &oname);
 	dout("readdir_prepopulate done\n");
 	return err;
 }
-- 
2.33.1

