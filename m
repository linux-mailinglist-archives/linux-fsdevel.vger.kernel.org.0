Return-Path: <linux-fsdevel+bounces-46105-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 02C87A829AC
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Apr 2025 17:13:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A32EF17A47F
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Apr 2025 15:07:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69C3E26B0A2;
	Wed,  9 Apr 2025 15:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="DmCBfR6Q"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3FE926770E;
	Wed,  9 Apr 2025 15:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744210863; cv=none; b=c48ZBXEm6zdTbtMesO7U9lbbsv/kArKYvfe1DvDGlvVnC/m4Hxl/kv3T2yv+U1HAptjNH3p1JjIa6r1MBglif9rB/CmYS/0IZoS0QdIUmen7ZwTMlM9uvcADIpN88pX8d/w0onl0DIsqospHe/xILp4gJCWqXCOdsTf3S1mQTKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744210863; c=relaxed/simple;
	bh=jVNGTLzeD/GPFS0YZ/FaiOHvvNVvXKoxvsqsmFxbLns=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tR/CI+FdSr3Zioy/srTSnztNLmFtVRbh321cDnO4OPFhjgptQ/Gj2V1RTsntl/CFQWrM90GZM2cNmKYRYGkL1v7ENE9YzXm0wCwZvwMAdN3LfUG8r58IfD93pxxMU1/mYZ9H+X3rBnA1nV51wpvl1Sbx/logz+/msA6sw0XT2Uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=DmCBfR6Q; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=1cFw2FZbI8nH+C107hw+pJ1/vEWiDjdnIrrhccQpX9s=; b=DmCBfR6QXnFJa5WkKZ+3YBx3Bd
	f0rJQ+vdt1UD8GYCoM43X1KCun9EvoVldbJEqHMfblVLynvinpzQQpuYQfQg+pOLrXgw7OJT2i2u4
	YetqZvF7lYwbBCizQ1eDowz5UcKjq8tJoYcm3MDr9G91knDTeU7LPTsFa9G1G4hHGmS2u1os5Dg1n
	LB1H9LzOVjmB/Bb1UEDTGqt4Mgo10lCqkm0edlpIxiQ9fJYawrT0GFcy0baCJ5iETjXomJ2X6vrzU
	21izkKdUGzfniZ7518AVeXe7I2Cws0M9xCodjMKO7bL77AW1OSoAC3RKfUXDH+ZJo+H7wYpNHOxZI
	Ek+VavZA==;
Received: from [191.204.192.64] (helo=[192.168.15.100])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1u2Wv7-00EBVR-HN; Wed, 09 Apr 2025 17:00:53 +0200
From: =?utf-8?q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
Date: Wed, 09 Apr 2025 12:00:42 -0300
Subject: [PATCH 2/3] ovl: Make ovl_dentry_weird() accept casefold dentries
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250409-tonyk-overlayfs-v1-2-3991616fe9a3@igalia.com>
References: <20250409-tonyk-overlayfs-v1-0-3991616fe9a3@igalia.com>
In-Reply-To: <20250409-tonyk-overlayfs-v1-0-3991616fe9a3@igalia.com>
To: Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>, 
 Theodore Tso <tytso@mit.edu>, Gabriel Krisman Bertazi <krisman@kernel.org>
Cc: linux-unionfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 kernel-dev@igalia.com, 
 =?utf-8?q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
X-Mailer: b4 0.14.2

ovl_dentry_weird() is used to avoid problems with filesystems that has
their d_hash and d_compare implementations. Create an exception for this
function, where only casefold filesystems are eligible to use their own
d_hash and d_compare functions, allowing to support casefold
filesystems.

Signed-off-by: André Almeida <andrealmeid@igalia.com>
---
 fs/overlayfs/namei.c     | 11 ++++++-----
 fs/overlayfs/overlayfs.h |  2 +-
 fs/overlayfs/params.c    |  3 ++-
 fs/overlayfs/util.c      | 12 +++++++-----
 4 files changed, 16 insertions(+), 12 deletions(-)

diff --git a/fs/overlayfs/namei.c b/fs/overlayfs/namei.c
index be5c65d6f8484b1fba6b3fee379ba1d034c0df8a..140bc609ffebe00151cbb446720f5106dbeb2ef2 100644
--- a/fs/overlayfs/namei.c
+++ b/fs/overlayfs/namei.c
@@ -192,7 +192,7 @@ struct dentry *ovl_decode_real_fh(struct ovl_fs *ofs, struct ovl_fh *fh,
 		return real;
 	}
 
-	if (ovl_dentry_weird(real)) {
+	if (ovl_dentry_weird(real, ofs)) {
 		dput(real);
 		return NULL;
 	}
@@ -244,7 +244,7 @@ static int ovl_lookup_single(struct dentry *base, struct ovl_lookup_data *d,
 		goto out_err;
 	}
 
-	if (ovl_dentry_weird(this)) {
+	if (ovl_dentry_weird(this, ofs)) {
 		/* Don't support traversing automounts and other weirdness */
 		err = -EREMOTE;
 		goto out_err;
@@ -365,6 +365,7 @@ static int ovl_lookup_data_layer(struct dentry *dentry, const char *redirect,
 				 struct path *datapath)
 {
 	int err;
+	struct ovl_fs *ovl = OVL_FS(layer->fs->sb);
 
 	err = vfs_path_lookup(layer->mnt->mnt_root, layer->mnt, redirect,
 			LOOKUP_BENEATH | LOOKUP_NO_SYMLINKS | LOOKUP_NO_XDEV,
@@ -376,7 +377,7 @@ static int ovl_lookup_data_layer(struct dentry *dentry, const char *redirect,
 		return err;
 
 	err = -EREMOTE;
-	if (ovl_dentry_weird(datapath->dentry))
+	if (ovl_dentry_weird(datapath->dentry, ovl))
 		goto out_path_put;
 
 	err = -ENOENT;
@@ -767,7 +768,7 @@ struct dentry *ovl_get_index_fh(struct ovl_fs *ofs, struct ovl_fh *fh)
 
 	if (ovl_is_whiteout(index))
 		err = -ESTALE;
-	else if (ovl_dentry_weird(index))
+	else if (ovl_dentry_weird(index, ofs))
 		err = -EIO;
 	else
 		return index;
@@ -815,7 +816,7 @@ struct dentry *ovl_lookup_index(struct ovl_fs *ofs, struct dentry *upper,
 		dput(index);
 		index = ERR_PTR(-ESTALE);
 		goto out;
-	} else if (ovl_dentry_weird(index) || ovl_is_whiteout(index) ||
+	} else if (ovl_dentry_weird(index, ofs) || ovl_is_whiteout(index) ||
 		   inode_wrong_type(inode, d_inode(origin)->i_mode)) {
 		/*
 		 * Index should always be of the same file type as origin
diff --git a/fs/overlayfs/overlayfs.h b/fs/overlayfs/overlayfs.h
index 6f2f8f4cfbbc177fbd5441483395d7ff72efe332..f3de013517598c44c15ca9f950f6c2f0a5c2084b 100644
--- a/fs/overlayfs/overlayfs.h
+++ b/fs/overlayfs/overlayfs.h
@@ -445,7 +445,7 @@ void ovl_dentry_init_reval(struct dentry *dentry, struct dentry *upperdentry,
 			   struct ovl_entry *oe);
 void ovl_dentry_init_flags(struct dentry *dentry, struct dentry *upperdentry,
 			   struct ovl_entry *oe, unsigned int mask);
-bool ovl_dentry_weird(struct dentry *dentry);
+bool ovl_dentry_weird(struct dentry *dentry, struct ovl_fs *ovl);
 enum ovl_path_type ovl_path_type(struct dentry *dentry);
 void ovl_path_upper(struct dentry *dentry, struct path *path);
 void ovl_path_lower(struct dentry *dentry, struct path *path);
diff --git a/fs/overlayfs/params.c b/fs/overlayfs/params.c
index 6759f7d040c89d3b3c01572579c854a900411157..459e8bddf1777c12c9fa0bdfc150e2ea22eaafc3 100644
--- a/fs/overlayfs/params.c
+++ b/fs/overlayfs/params.c
@@ -277,6 +277,7 @@ static int ovl_mount_dir_check(struct fs_context *fc, const struct path *path,
 			       enum ovl_opt layer, const char *name, bool upper)
 {
 	struct ovl_fs_context *ctx = fc->fs_private;
+	struct ovl_fs *ovl = fc->s_fs_info;
 
 	if (!d_is_dir(path->dentry))
 		return invalfc(fc, "%s is not a directory", name);
@@ -290,7 +291,7 @@ static int ovl_mount_dir_check(struct fs_context *fc, const struct path *path,
 	if (sb_has_encoding(path->mnt->mnt_sb))
 		return invalfc(fc, "case-insensitive capable filesystem on %s not supported", name);
 
-	if (ovl_dentry_weird(path->dentry))
+	if (ovl_dentry_weird(path->dentry, ovl))
 		return invalfc(fc, "filesystem on %s not supported", name);
 
 	/*
diff --git a/fs/overlayfs/util.c b/fs/overlayfs/util.c
index 0819c739cc2ffce0dfefa84d3ff8f9f103eec191..4dd523a1a13ab0a6cf51d967d0b712873e6d8580 100644
--- a/fs/overlayfs/util.c
+++ b/fs/overlayfs/util.c
@@ -200,15 +200,17 @@ void ovl_dentry_init_flags(struct dentry *dentry, struct dentry *upperdentry,
 	spin_unlock(&dentry->d_lock);
 }
 
-bool ovl_dentry_weird(struct dentry *dentry)
+bool ovl_dentry_weird(struct dentry *dentry, struct ovl_fs *ovl)
 {
+	int flags = DCACHE_NEED_AUTOMOUNT | DCACHE_MANAGE_TRANSIT;
+
+	if (!ovl->casefold)
+		flags |= DCACHE_OP_HASH | DCACHE_OP_COMPARE;
+
 	if (!d_can_lookup(dentry) && !d_is_file(dentry) && !d_is_symlink(dentry))
 		return true;
 
-	return dentry->d_flags & (DCACHE_NEED_AUTOMOUNT |
-				  DCACHE_MANAGE_TRANSIT |
-				  DCACHE_OP_HASH |
-				  DCACHE_OP_COMPARE);
+	return dentry->d_flags & flags;
 }
 
 enum ovl_path_type ovl_path_type(struct dentry *dentry)

-- 
2.49.0


