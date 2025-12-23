Return-Path: <linux-fsdevel+bounces-71986-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B530CDA2E2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Dec 2025 18:57:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 869BE3003DAD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Dec 2025 17:57:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DBC734C838;
	Tue, 23 Dec 2025 17:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dh/eGOfA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F11934C154
	for <linux-fsdevel@vger.kernel.org>; Tue, 23 Dec 2025 17:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766511566; cv=none; b=Gtopv3cOxM8DXwNUAoqvXT1Ev0jXBSrfW4Pgd9awBtVLPseHr5MmyJ3D4XcKQ3LUeOoN4tJViHd1CP/QPb3F98kCB2NNMAOH+6icprbIiO2krduawjTFh8KqDL1OAUjX+hnR0L5CPx9tSxN8bB9Ij2tMGV9pZjfBROU5JEpZdhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766511566; c=relaxed/simple;
	bh=lh5UxtMI4n6lSjsHeO6WA255moNt2pva8ID0kdKL0Fg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=piTZl23jmsfSjh1ki2tr1yeFK6tA3ToZ6fUuEbSrvE146j8eVGgwi/MuhXD3GIvqPrMOBDZkbCCXL+NqLlWfufmLbj8zAbLCsl1GedRs8S/tnYWcZSckPSx930jxG6HcsZ6dv08h9oljoA3qdCkaG3worrRNRbnuEOggEfiz8yk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dh/eGOfA; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-430ff148844so2463542f8f.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 23 Dec 2025 09:39:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766511562; x=1767116362; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/4iaP4edOtBplWS78T5/vqsGo3RVpJ9d21smi9Hz1+8=;
        b=Dh/eGOfAjzcTU9xRKu38ToDMSVzcGEv0jCeWhno4K5HMoBE9G2Sk//RnbX0StaoVdN
         sRpFxgCgy/y9mb6eJVUmxfSKBpfN9ZzWNvm77RB2q5VCB/OJhGvTHis44l8VOHUyuxXR
         MM71HVf3G7nIoaK6oAtBqbe55CzKIK6ggZwN7JBI5t77JcGkapE9Ti82bq4ZpvO3DtJv
         UmZXa/LhAFDm1frd9necM5JlwbnqYNvNsThWqcRgV3+SU558RHRuxAZv878u/KMVsLJi
         lk8ZFIDbu0PzFIzrRSuBiwVnIpew7kR5voq97FkEecRQ1vv2OoqKp5Tywp4LTRlFKNKS
         McjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766511562; x=1767116362;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/4iaP4edOtBplWS78T5/vqsGo3RVpJ9d21smi9Hz1+8=;
        b=Wd0KoAYDusJqaYoHr4DPUJY2PSLseP5arJh2iH73QlZXzX18fz0tDICLLz/n+0hbFQ
         tpO8nTjbORCyaevolW367BpPdVu2LcFvY8a9p3Na7D5/Acr0fCQWU7S0Ry3K+qeoqn0A
         69REI80rjVmZjmxzyJoG4ERKBo9UA0VXxtWw8tPr9B/8eWxLYUeCepVumnkUiPAK7/gb
         tS+gbWZ/RRv6Y9Yht5leDf9lVdBKQTNhuYuuKTuW6E8xlgW3MkojgGJYGjNiqqFb/fyt
         gjLIad0DQYYD28CEO6mdTZMMsJLBNfCg/HwQGFCY48EAMP2ZHISkpl7RH5mrDFIqw2ME
         Y0VQ==
X-Forwarded-Encrypted: i=1; AJvYcCWGnhrqtxGIC4v/uZzFG5dns0/DVJlZ+4H9ydyovQ6fSb5HA2Urn5KWIsU+sYeIKa5PCJaHExQeCaKdU+aF@vger.kernel.org
X-Gm-Message-State: AOJu0YwM3mSP3+UU0qQYfG4W4JTo4yra8e06E22vajNDyhMvs7HBDtAb
	CX/4Zt0D1b2KTcHyqwltqUtf/L97PzsNvk8P5mNiBQgnAIG8L9ecxD2t88qHZhnQgRc=
X-Gm-Gg: AY/fxX6YZmhWWw1zYReCQLKudCblC+AK6rltu/3fMhmC0xHqdf+N8z23Bhyzs0eXgZ7
	O/LOj8X8PwYDTunzlDt87fuDkuJ0c+rN+t1Is1rcI/BlDF4QeHEA7aExt4V75mwINLGcSgb5+a7
	j5Pw+VJVmbp2L6wjmdcQCVBs1HR5vOBC8rb6x7PECpD/lvZbNiOHcX1Zhwu7gOmyUAf/YqXGREG
	ehKMn6Er70oQYpQzOElzFCmgr99CUBWGcxmednu86omtCt6cTeY63ouHV0eiAVJQwvJCYFlVkol
	Dnmv1OADn/Pwsqa2pQVB6qpsSmpNyL6qCckt9/BgLlb/DlJKy9xBvHNKnXLX4sR5KujAfP+/Fjr
	J1BbYgpuCvc6NP2FcxZGDJaFUWBOqf/jY4u5V9RBvYKxkWAbsw7BYhFnLY6rTPGPwMxqI3jmoJG
	UcRbPtOfr0p1ZtFfeB26dafucTKpyvW4QElUAqKKslI77qFTP6QxUF8AH7LvQMhtP2YJsEkHFwu
	NRP+bvd4Gj8b8+H1OH0Kyb4c3sxLbXvIzM4XsG8tKQeT9ZdxA==
X-Google-Smtp-Source: AGHT+IFqHfJ8jF2fnYcTvBDI75jIgkEZirbsytQMRmyb1lvndDoLUUZamKuJYPEWwzF9RvTHYPqxYA==
X-Received: by 2002:a5d:5f53:0:b0:429:d3c9:b8af with SMTP id ffacd0b85a97d-4324e42eac2mr15907608f8f.25.1766511561647;
        Tue, 23 Dec 2025 09:39:21 -0800 (PST)
Received: from ip-10-91-41-136.eu-west-1.compute.internal (ec2-52-214-180-36.eu-west-1.compute.amazonaws.com. [52.214.180.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4324eaa477bsm29119568f8f.36.2025.12.23.09.39.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Dec 2025 09:39:21 -0800 (PST)
From: Andrei Topala <topala.andrei@gmail.com>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org,
	Andrei Topala <topala.andrei@gmail.com>
Subject: [PATCH] fs: allow rename across bind mounts on same superblock
Date: Tue, 23 Dec 2025 17:38:03 +0000
Message-ID: <20251223173803.1623903-1-topala.andrei@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

  Currently rename() returns EXDEV when source and destination are on
  different mounts, even if they're bind mounts of the same filesystem.
  This forces userspace (mv) to fall back to slow copy+delete.

  Change the check from comparing mount pointers to comparing superblocks,
  which allows renaming across bind mounts within the same filesystem.

  This also handles the case where source and destination mounts have different
  properties (idmaps, read-only flags) by checking both mounts appropriately.

Signed-off-by: Andrei Topala <topala.andrei@gmail.com>
---
 fs/cachefiles/namei.c    |  3 ++-
 fs/ecryptfs/inode.c      |  3 ++-
 fs/namei.c               | 39 +++++++++++++++++++++++++--------------
 fs/nfsd/vfs.c            |  3 ++-
 fs/overlayfs/copy_up.c   |  6 ++++--
 fs/overlayfs/dir.c       | 12 ++++++++----
 fs/overlayfs/overlayfs.h |  3 ++-
 fs/overlayfs/super.c     |  3 ++-
 fs/smb/server/vfs.c      |  3 ++-
 include/linux/fs.h       |  6 ++++--
 10 files changed, 53 insertions(+), 28 deletions(-)

diff --git a/fs/cachefiles/namei.c b/fs/cachefiles/namei.c
index e5ec90dcc..771f169cc 100644
--- a/fs/cachefiles/namei.c
+++ b/fs/cachefiles/namei.c
@@ -383,7 +383,8 @@ int cachefiles_bury_object(struct cachefiles_cache *cache,
 		cachefiles_io_error(cache, "Rename security error %d", ret);
 	} else {
 		struct renamedata rd = {
-			.mnt_idmap	= &nop_mnt_idmap,
+			.old_mnt_idmap	= &nop_mnt_idmap,
+			.new_mnt_idmap	= &nop_mnt_idmap,
 			.old_parent	= dir,
 			.old_dentry	= rep,
 			.new_parent	= cache->graveyard,
diff --git a/fs/ecryptfs/inode.c b/fs/ecryptfs/inode.c
index 397824824..1d59b8a2e 100644
--- a/fs/ecryptfs/inode.c
+++ b/fs/ecryptfs/inode.c
@@ -614,7 +614,8 @@ ecryptfs_rename(struct mnt_idmap *idmap, struct inode *old_dir,
 
 	target_inode = d_inode(new_dentry);
 
-	rd.mnt_idmap  = &nop_mnt_idmap;
+	rd.old_mnt_idmap = &nop_mnt_idmap;
+	rd.new_mnt_idmap = &nop_mnt_idmap;
 	rd.old_parent = lower_old_dir_dentry;
 	rd.new_parent = lower_new_dir_dentry;
 	rc = start_renaming_two_dentries(&rd, lower_old_dentry, lower_new_dentry);
diff --git a/fs/namei.c b/fs/namei.c
index bf0f66f0e..be9931d63 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -3867,7 +3867,8 @@ __start_renaming(struct renamedata *rd, int lookup_flags,
  * These references and the lock are dropped by end_renaming().
  *
  * The passed in qstrs need not have the hash calculated, and basic
- * eXecute permission checking is performed against @rd.mnt_idmap.
+ * eXecute permission checking is performed against @rd.old_mnt_idmap
+ * and @rd.new_mnt_idmap respectively.
  *
  * Returns: zero or an error.
  */
@@ -3876,10 +3877,10 @@ int start_renaming(struct renamedata *rd, int lookup_flags,
 {
 	int err;
 
-	err = lookup_one_common(rd->mnt_idmap, old_last, rd->old_parent);
+	err = lookup_one_common(rd->old_mnt_idmap, old_last, rd->old_parent);
 	if (err)
 		return err;
-	err = lookup_one_common(rd->mnt_idmap, new_last, rd->new_parent);
+	err = lookup_one_common(rd->new_mnt_idmap, new_last, rd->new_parent);
 	if (err)
 		return err;
 	return __start_renaming(rd, lookup_flags, old_last, new_last);
@@ -3964,7 +3965,7 @@ __start_renaming_dentry(struct renamedata *rd, int lookup_flags,
  * References and the lock can be dropped with end_renaming()
  *
  * The passed in qstr need not have the hash calculated, and basic
- * eXecute permission checking is performed against @rd.mnt_idmap.
+ * eXecute permission checking is performed against @rd.new_mnt_idmap.
  *
  * Returns: zero or an error.
  */
@@ -3973,7 +3974,7 @@ int start_renaming_dentry(struct renamedata *rd, int lookup_flags,
 {
 	int err;
 
-	err = lookup_one_common(rd->mnt_idmap, new_last, rd->new_parent);
+	err = lookup_one_common(rd->new_mnt_idmap, new_last, rd->new_parent);
 	if (err)
 		return err;
 	return __start_renaming_dentry(rd, lookup_flags, old_dentry, new_last);
@@ -5816,20 +5817,20 @@ int vfs_rename(struct renamedata *rd)
 	if (source == target)
 		return 0;
 
-	error = may_delete(rd->mnt_idmap, old_dir, old_dentry, is_dir);
+	error = may_delete(rd->old_mnt_idmap, old_dir, old_dentry, is_dir);
 	if (error)
 		return error;
 
 	if (!target) {
-		error = may_create(rd->mnt_idmap, new_dir, new_dentry);
+		error = may_create(rd->new_mnt_idmap, new_dir, new_dentry);
 	} else {
 		new_is_dir = d_is_dir(new_dentry);
 
 		if (!(flags & RENAME_EXCHANGE))
-			error = may_delete(rd->mnt_idmap, new_dir,
+			error = may_delete(rd->new_mnt_idmap, new_dir,
 					   new_dentry, is_dir);
 		else
-			error = may_delete(rd->mnt_idmap, new_dir,
+			error = may_delete(rd->new_mnt_idmap, new_dir,
 					   new_dentry, new_is_dir);
 	}
 	if (error)
@@ -5844,13 +5845,13 @@ int vfs_rename(struct renamedata *rd)
 	 */
 	if (new_dir != old_dir) {
 		if (is_dir) {
-			error = inode_permission(rd->mnt_idmap, source,
+			error = inode_permission(rd->old_mnt_idmap, source,
 						 MAY_WRITE);
 			if (error)
 				return error;
 		}
 		if ((flags & RENAME_EXCHANGE) && new_is_dir) {
-			error = inode_permission(rd->mnt_idmap, target,
+			error = inode_permission(rd->new_mnt_idmap, target,
 						 MAY_WRITE);
 			if (error)
 				return error;
@@ -5926,7 +5927,7 @@ int vfs_rename(struct renamedata *rd)
 		if (error)
 			goto out;
 	}
-	error = old_dir->i_op->rename(rd->mnt_idmap, old_dir, old_dentry,
+	error = old_dir->i_op->rename(rd->old_mnt_idmap, old_dir, old_dentry,
 				      new_dir, new_dentry, flags);
 	if (error)
 		goto out;
@@ -5996,7 +5997,7 @@ int do_renameat2(int olddfd, struct filename *from, int newdfd,
 		goto exit1;
 
 	error = -EXDEV;
-	if (old_path.mnt != new_path.mnt)
+	if (old_path.mnt->mnt_sb != new_path.mnt->mnt_sb)
 		goto exit2;
 
 	error = -EBUSY;
@@ -6012,9 +6013,16 @@ int do_renameat2(int olddfd, struct filename *from, int newdfd,
 	if (error)
 		goto exit2;
 
+	if (old_path.mnt != new_path.mnt) {
+		error = mnt_want_write(new_path.mnt);
+		if (error)
+			goto exit3;
+	}
+
 retry_deleg:
 	rd.old_parent	   = old_path.dentry;
-	rd.mnt_idmap	   = mnt_idmap(old_path.mnt);
+	rd.old_mnt_idmap   = mnt_idmap(old_path.mnt);
+	rd.new_mnt_idmap   = mnt_idmap(new_path.mnt);
 	rd.new_parent	   = new_path.dentry;
 	rd.delegated_inode = &delegated_inode;
 	rd.flags	   = flags;
@@ -6053,6 +6061,9 @@ int do_renameat2(int olddfd, struct filename *from, int newdfd,
 		if (!error)
 			goto retry_deleg;
 	}
+	if (old_path.mnt != new_path.mnt)
+		mnt_drop_write(new_path.mnt);
+exit3:
 	mnt_drop_write(old_path.mnt);
 exit2:
 	if (retry_estale(error, lookup_flags))
diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index 964cf922a..5ffcd279f 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -2154,7 +2154,8 @@ nfsd_rename(struct svc_rqst *rqstp, struct svc_fh *ffhp, char *fname, int flen,
 		goto out;
 	}
 
-	rd.mnt_idmap	= &nop_mnt_idmap;
+	rd.old_mnt_idmap = &nop_mnt_idmap;
+	rd.new_mnt_idmap = &nop_mnt_idmap;
 	rd.old_parent	= fdentry;
 	rd.new_parent	= tdentry;
 
diff --git a/fs/overlayfs/copy_up.c b/fs/overlayfs/copy_up.c
index 758611ee4..0f1df4fef 100644
--- a/fs/overlayfs/copy_up.c
+++ b/fs/overlayfs/copy_up.c
@@ -556,7 +556,8 @@ static int ovl_create_index(struct dentry *dentry, const struct ovl_fh *fh,
 	if (err)
 		goto out;
 
-	rd.mnt_idmap = ovl_upper_mnt_idmap(ofs);
+	rd.old_mnt_idmap = ovl_upper_mnt_idmap(ofs);
+	rd.new_mnt_idmap = ovl_upper_mnt_idmap(ofs);
 	rd.old_parent = indexdir;
 	rd.new_parent = indexdir;
 	err = start_renaming_dentry(&rd, 0, temp, &name);
@@ -804,7 +805,8 @@ static int ovl_copy_up_workdir(struct ovl_copy_up_ctx *c)
 	 * ovl_copy_up_data(), so lock workdir and destdir and make sure that
 	 * temp wasn't moved before copy up completion or cleanup.
 	 */
-	rd.mnt_idmap = ovl_upper_mnt_idmap(ofs);
+	rd.old_mnt_idmap = ovl_upper_mnt_idmap(ofs);
+	rd.new_mnt_idmap = ovl_upper_mnt_idmap(ofs);
 	rd.old_parent = c->workdir;
 	rd.new_parent = c->destdir;
 	rd.flags = 0;
diff --git a/fs/overlayfs/dir.c b/fs/overlayfs/dir.c
index ff3dbd1ca..cb988dfa3 100644
--- a/fs/overlayfs/dir.c
+++ b/fs/overlayfs/dir.c
@@ -135,7 +135,8 @@ int ovl_cleanup_and_whiteout(struct ovl_fs *ofs, struct dentry *dir,
 	if (d_is_dir(dentry))
 		flags = RENAME_EXCHANGE;
 
-	rd.mnt_idmap = ovl_upper_mnt_idmap(ofs);
+	rd.old_mnt_idmap = ovl_upper_mnt_idmap(ofs);
+	rd.new_mnt_idmap = ovl_upper_mnt_idmap(ofs);
 	rd.old_parent = ofs->workdir;
 	rd.new_parent = dir;
 	rd.flags = flags;
@@ -413,7 +414,8 @@ static struct dentry *ovl_clear_empty(struct dentry *dentry,
 	if (IS_ERR(opaquedir))
 		goto out;
 
-	rd.mnt_idmap = ovl_upper_mnt_idmap(ofs);
+	rd.old_mnt_idmap = ovl_upper_mnt_idmap(ofs);
+	rd.new_mnt_idmap = ovl_upper_mnt_idmap(ofs);
 	rd.old_parent = workdir;
 	rd.new_parent = upperdir;
 	rd.flags = RENAME_EXCHANGE;
@@ -504,7 +506,8 @@ static int ovl_create_over_whiteout(struct dentry *dentry, struct inode *inode,
 	if (IS_ERR(newdentry))
 		goto out_dput;
 
-	rd.mnt_idmap = ovl_upper_mnt_idmap(ofs);
+	rd.old_mnt_idmap = ovl_upper_mnt_idmap(ofs);
+	rd.new_mnt_idmap = ovl_upper_mnt_idmap(ofs);
 	rd.old_parent = workdir;
 	rd.new_parent = upperdir;
 	rd.flags = 0;
@@ -1230,7 +1233,8 @@ static int ovl_rename_upper(struct ovl_renamedata *ovlrd, struct list_head *list
 		}
 	}
 
-	rd.mnt_idmap = ovl_upper_mnt_idmap(ofs);
+	rd.old_mnt_idmap = ovl_upper_mnt_idmap(ofs);
+	rd.new_mnt_idmap = ovl_upper_mnt_idmap(ofs);
 	rd.old_parent = old_upperdir;
 	rd.new_parent = new_upperdir;
 	rd.flags = ovlrd->flags;
diff --git a/fs/overlayfs/overlayfs.h b/fs/overlayfs/overlayfs.h
index f9ac9bdde..4b7824761 100644
--- a/fs/overlayfs/overlayfs.h
+++ b/fs/overlayfs/overlayfs.h
@@ -374,7 +374,8 @@ static inline int ovl_do_rename(struct ovl_fs *ofs, struct dentry *olddir,
 				struct dentry *newdentry, unsigned int flags)
 {
 	struct renamedata rd = {
-		.mnt_idmap	= ovl_upper_mnt_idmap(ofs),
+		.old_mnt_idmap	= ovl_upper_mnt_idmap(ofs),
+		.new_mnt_idmap	= ovl_upper_mnt_idmap(ofs),
 		.old_parent	= olddir,
 		.old_dentry	= olddentry,
 		.new_parent	= newdir,
diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
index ba9146f22..86d164c05 100644
--- a/fs/overlayfs/super.c
+++ b/fs/overlayfs/super.c
@@ -582,7 +582,8 @@ static int ovl_check_rename_whiteout(struct ovl_fs *ofs)
 	if (IS_ERR(temp))
 		return err;
 
-	rd.mnt_idmap = ovl_upper_mnt_idmap(ofs);
+	rd.old_mnt_idmap = ovl_upper_mnt_idmap(ofs);
+	rd.new_mnt_idmap = ovl_upper_mnt_idmap(ofs);
 	rd.old_parent = workdir;
 	rd.new_parent = workdir;
 	rd.flags = RENAME_WHITEOUT;
diff --git a/fs/smb/server/vfs.c b/fs/smb/server/vfs.c
index f891344bd..f9e46b6e0 100644
--- a/fs/smb/server/vfs.c
+++ b/fs/smb/server/vfs.c
@@ -698,7 +698,8 @@ int ksmbd_vfs_rename(struct ksmbd_work *work, const struct path *old_path,
 	if (err)
 		goto out2;
 
-	rd.mnt_idmap		= mnt_idmap(old_path->mnt);
+	rd.old_mnt_idmap	= mnt_idmap(old_path->mnt);
+	rd.new_mnt_idmap	= mnt_idmap(new_path.mnt);
 	rd.old_parent		= NULL;
 	rd.new_parent		= new_path.dentry;
 	rd.flags		= flags;
diff --git a/include/linux/fs.h b/include/linux/fs.h
index f5c9cf28c..4b7a1fd23 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1774,7 +1774,8 @@ int vfs_unlink(struct mnt_idmap *, struct inode *, struct dentry *,
 
 /**
  * struct renamedata - contains all information required for renaming
- * @mnt_idmap:     idmap of the mount in which the rename is happening.
+ * @old_mnt_idmap:     idmap of the source mount
+ * @new_mnt_idmap:     idmap of the destination mount
  * @old_parent:        parent of source
  * @old_dentry:                source
  * @new_parent:        parent of destination
@@ -1783,7 +1784,8 @@ int vfs_unlink(struct mnt_idmap *, struct inode *, struct dentry *,
  * @flags:             rename flags
  */
 struct renamedata {
-	struct mnt_idmap *mnt_idmap;
+	struct mnt_idmap *old_mnt_idmap;
+	struct mnt_idmap *new_mnt_idmap;
 	struct dentry *old_parent;
 	struct dentry *old_dentry;
 	struct dentry *new_parent;
-- 
2.50.1


