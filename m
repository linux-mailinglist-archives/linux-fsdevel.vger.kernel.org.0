Return-Path: <linux-fsdevel+bounces-71200-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 500F1CB9788
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Dec 2025 18:44:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3D2D33083301
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Dec 2025 17:44:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C00A2EE60B;
	Fri, 12 Dec 2025 17:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QwLzpY6V";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="sv+OqOEf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F97829A31C
	for <linux-fsdevel@vger.kernel.org>; Fri, 12 Dec 2025 17:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765561452; cv=none; b=rDO8OzMe8jS6ogbr5trL8JkqrPpK1/eEazv9qChOQ9AhvsC7xbz07CfeQxoBp14ogBtn1Gmu3ulUnytWnngcPR5ikSyPL3IbrqMSxtPDkhircQVGCHrjX+tEOLK6PPLxTPKQ7D4PfoweEuUldSqRQTd2Ot7fiidZqrKe2sUlw14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765561452; c=relaxed/simple;
	bh=/BrfePL0WggZDyN8AP8GMAuMzflIr0zbOfIi5qp60Tw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RKdys5aJ+9311s/FSAH4pzVa6F05KOwtXOJQb4FBYpqqeT8fK3l47Tcr1buqLbYruyp/fLDZJMitqwh25QWWebZCf1QvKvERGn6XDTJ0l6q5OKhP5avbTNaRyRAqyxT4olT50jvPlJWZpZXSiKxNbvrJFnCVhVJW+a2vFk96TiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QwLzpY6V; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=sv+OqOEf; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1765561449;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=+L2Ri3tCiCHMXqdoivqjyE/vSiPrT+c4oaetlwyrpzU=;
	b=QwLzpY6VHEz4FGYp4ZQgTWWVBbYq/TBwJWEUnwA1I4eKYzkKfixJCairhJZJIY0oeivsR2
	mdcXBKwa17G1kHeGFXfEaHBBn9RQ9bNVvnFNaODvhUBUbVBavMj2wV3kHpCiwrqK/i2B2J
	6p5fMUrFRMGhaBS5zvtbDfhf5a1aJXg=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-48--fjhHJj4OsK2DeK0Uk9_kA-1; Fri, 12 Dec 2025 12:44:07 -0500
X-MC-Unique: -fjhHJj4OsK2DeK0Uk9_kA-1
X-Mimecast-MFC-AGG-ID: -fjhHJj4OsK2DeK0Uk9_kA_1765561447
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-8b22d590227so221533385a.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 12 Dec 2025 09:44:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1765561447; x=1766166247; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+L2Ri3tCiCHMXqdoivqjyE/vSiPrT+c4oaetlwyrpzU=;
        b=sv+OqOEfT9SrumVCU8GVxgiD31/so2npCY8UpEkQ31C5KBs/iStOPDQ5ksvch5oCss
         wISmeZYKUiSms//AGgWPEPxvAG1NvILAmnbxbxlmEgCpJOqDPdcCYslsyOQ4sbwv3pLD
         /F+OlZD9qQUYxmIzePX22D6RCPALBn/WPNzrFVdxdd8I0Dg1LvOc3Ex/Uvv1gv+HPSC5
         ZaIMCr661wdD0ViwgJxQejdhVt2XYlgwXDe4lFz9uDyWgABGwAlbFWoMrqFEyiL6SIsL
         NLNgURJI7OOfCQ87spPmTZSEE3gnydQ560vQNh61l45y3FB15E4uWCI/BMxQDmRGupNS
         V+CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765561447; x=1766166247;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+L2Ri3tCiCHMXqdoivqjyE/vSiPrT+c4oaetlwyrpzU=;
        b=jXpTOuWQRn3fGhNkwsq/DanYgT2XooujnteOhz8KU7tBEj8eRhRuDZzwjjVSU889Rb
         o5uEE2AfCVn978utxT0EWztNnGLx9ao6kA5CDFQybpU/yzdWBQwVzjcXtj+sWMGgfSGL
         07ygl7B2UQ52N4SECs4/cqrKvFDw3o3wJ5EOAdp2p7q0YCKKEVtTR5xpNPOXSykSp0fw
         3tJl+y8kDGVCOEMtLflxK/5YN9ia4RzeVu7IPgOV93DIGd/fgEQ0TIVVpyxZVhcFDAxF
         +O2hm8Ta3EChnP3xKShxKws/lGbFYEh3xNFv4I1rNca6lTEu+EnEnAQFIPSm+V3m0nIa
         Syxg==
X-Gm-Message-State: AOJu0YyNEhP1IWA5k+tME+14dZF0x1QT2bvoqb65lYFHHRvSZyEncGpL
	v3In9mtG09d5dU/VKp5PvuPDaESGdZ0b+fQbXWFtX3FCuUrpwzq3FC0VHtJVmWyX3UdoT+MueE9
	W8Q8pkxQMB1l01IhgaEsfoU3MCT8KbbG6He9ug5iQ7vY1h1IaFbIWdQkz6NiJ7Zz50ghzOYVgcB
	wa/MVpOY2RFEpnmeM6cAU1yiucVKYvDNgQ746mbCxJvGs/9qV7sg==
X-Gm-Gg: AY/fxX6HJK1vnEB0ZjQ22SPUG1264xr3eq8STfNrH5FDSDm1qNcnoiQh8u7gf6wxCE6
	31aZfk/p8qbq/CbnrsbXGs03cZkk+KoOConEUwWgtrG9Ix2x6Kf80UbLVttmccTUiYdMois6L1j
	MMMnZHVL6HzJ+LD/3Y/CliVV4v2W1GSKZN+xKM0SiRYP2ncYy9WlAMejYWkYoxxacDqtKUUTJ0T
	rX1UOqWkbviHUNAsNr2xAxNHrDwcqAXlOQBDZ6xgrF0UmPFQqHsgiDF8QqyX+PyS7tUx/ywRSem
	ZFD/R0P1IJG4+206hOiuSWGT49YQbFlnDA3YXpm/3YuijhEbq6hGKUaR0EWdQNfBKA1vBfVN4pw
	xyvN9GknIUcF2iauDJWSxyyuaf2bc6myeeBV2ljR0bau4SjASCJnxvE8=
X-Received: by 2002:a05:620a:45a6:b0:8b2:767c:31cb with SMTP id af79cd13be357-8bb3a397913mr398605585a.87.1765561446663;
        Fri, 12 Dec 2025 09:44:06 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG+lEjTtQ+Fip2mhh5s0Ybcy547sf93BVo0AT0rVZEyHQEJNb8w5j0c+VOGi1NPtmF1ZaQcXA==
X-Received: by 2002:a05:620a:45a6:b0:8b2:767c:31cb with SMTP id af79cd13be357-8bb3a397913mr398599085a.87.1765561445911;
        Fri, 12 Dec 2025 09:44:05 -0800 (PST)
Received: from big24.xxmyappdomainxx.com (97-127-77-149.mpls.qwest.net. [97.127.77.149])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8bab5665ff3sm507370885a.15.2025.12.12.09.44.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Dec 2025 09:44:05 -0800 (PST)
From: Eric Sandeen <sandeen@redhat.com>
To: linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	brauner@kernel.org,
	dhowells@redhat.com,
	viro@zeniv.linux.org.uk,
	Eric Sandeen <sandeen@redhat.com>
Subject: [PATCH] fs: Remove internal old mount API code
Date: Fri, 12 Dec 2025 11:44:03 -0600
Message-ID: <20251212174403.2882183-1-sandeen@redhat.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now that the last in-tree filesystem has been converted to the new mount
API, remove all legacy mount API code designed to handle un-converted
filesystems, and remove associated documentation as well.

(The code to handle the legacy mount(2) syscall from userspace is still
in place, of course.)

Tested with an allmodconfig build on x86_64, and a sanity check of an
old mount(2) syscall mount.

Signed-off-by: Eric Sandeen <sandeen@redhat.com>
---
 Documentation/filesystems/locking.rst   |   8 -
 Documentation/filesystems/mount_api.rst |   2 -
 Documentation/filesystems/porting.rst   |   7 +-
 Documentation/filesystems/vfs.rst       |  58 +------
 fs/fs_context.c                         | 208 +-----------------------
 fs/fsopen.c                             |  10 --
 fs/internal.h                           |   1 -
 include/linux/fs.h                      |   2 -
 include/linux/fs/super_types.h          |   1 -
 9 files changed, 8 insertions(+), 289 deletions(-)

diff --git a/Documentation/filesystems/locking.rst b/Documentation/filesystems/locking.rst
index 77704fde9845..cc832074c8bb 100644
--- a/Documentation/filesystems/locking.rst
+++ b/Documentation/filesystems/locking.rst
@@ -177,7 +177,6 @@ prototypes::
 	int (*freeze_fs) (struct super_block *);
 	int (*unfreeze_fs) (struct super_block *);
 	int (*statfs) (struct dentry *, struct kstatfs *);
-	int (*remount_fs) (struct super_block *, int *, char *);
 	void (*umount_begin) (struct super_block *);
 	int (*show_options)(struct seq_file *, struct dentry *);
 	ssize_t (*quota_read)(struct super_block *, int, char *, size_t, loff_t);
@@ -201,7 +200,6 @@ sync_fs:		read
 freeze_fs:		write
 unfreeze_fs:		write
 statfs:			maybe(read)	(see below)
-remount_fs:		write
 umount_begin:		no
 show_options:		no		(namespace_sem)
 quota_read:		no		(see below)
@@ -226,8 +224,6 @@ file_system_type
 
 prototypes::
 
-	struct dentry *(*mount) (struct file_system_type *, int,
-		       const char *, void *);
 	void (*kill_sb) (struct super_block *);
 
 locking rules:
@@ -235,13 +231,9 @@ locking rules:
 =======		=========
 ops		may block
 =======		=========
-mount		yes
 kill_sb		yes
 =======		=========
 
-->mount() returns ERR_PTR or the root dentry; its superblock should be locked
-on return.
-
 ->kill_sb() takes a write-locked superblock, does all shutdown work on it,
 unlocks and drops the reference.
 
diff --git a/Documentation/filesystems/mount_api.rst b/Documentation/filesystems/mount_api.rst
index c99ab1f7fea4..a064234fed5b 100644
--- a/Documentation/filesystems/mount_api.rst
+++ b/Documentation/filesystems/mount_api.rst
@@ -299,8 +299,6 @@ manage the filesystem context.  They are as follows:
      On success it should return 0.  In the case of an error, it should return
      a negative error code.
 
-     .. Note:: reconfigure is intended as a replacement for remount_fs.
-
 
 Filesystem context Security
 ===========================
diff --git a/Documentation/filesystems/porting.rst b/Documentation/filesystems/porting.rst
index 3397937ed838..631eee9bdc33 100644
--- a/Documentation/filesystems/porting.rst
+++ b/Documentation/filesystems/porting.rst
@@ -448,11 +448,8 @@ a file off.
 
 **mandatory**
 
-->get_sb() is gone.  Switch to use of ->mount().  Typically it's just
-a matter of switching from calling ``get_sb_``... to ``mount_``... and changing
-the function type.  If you were doing it manually, just switch from setting
-->mnt_root to some pointer to returning that pointer.  On errors return
-ERR_PTR(...).
+->get_sb() and ->mount() are gone. Switch to using the new mount API. See
+Documentation/filesystems/mount_api.rst for more details.
 
 ---
 
diff --git a/Documentation/filesystems/vfs.rst b/Documentation/filesystems/vfs.rst
index 670ba66b60e4..90c357b263fe 100644
--- a/Documentation/filesystems/vfs.rst
+++ b/Documentation/filesystems/vfs.rst
@@ -94,11 +94,9 @@ functions:
 
 The passed struct file_system_type describes your filesystem.  When a
 request is made to mount a filesystem onto a directory in your
-namespace, the VFS will call the appropriate mount() method for the
-specific filesystem.  New vfsmount referring to the tree returned by
-->mount() will be attached to the mountpoint, so that when pathname
-resolution reaches the mountpoint it will jump into the root of that
-vfsmount.
+namespace, the VFS will call the appropriate get_tree() method for the
+specific filesystem.  See Documentation/filesystems/mount_api.rst
+for more details.
 
 You can see all filesystems that are registered to the kernel in the
 file /proc/filesystems.
@@ -117,8 +115,6 @@ members are defined:
 		int fs_flags;
 		int (*init_fs_context)(struct fs_context *);
 		const struct fs_parameter_spec *parameters;
-		struct dentry *(*mount) (struct file_system_type *, int,
-			const char *, void *);
 		void (*kill_sb) (struct super_block *);
 		struct module *owner;
 		struct file_system_type * next;
@@ -151,10 +147,6 @@ members are defined:
 	'struct fs_parameter_spec'.
 	More info in Documentation/filesystems/mount_api.rst.
 
-``mount``
-	the method to call when a new instance of this filesystem should
-	be mounted
-
 ``kill_sb``
 	the method to call when an instance of this filesystem should be
 	shut down
@@ -173,45 +165,6 @@ members are defined:
   s_lock_key, s_umount_key, s_vfs_rename_key, s_writers_key,
   i_lock_key, i_mutex_key, invalidate_lock_key, i_mutex_dir_key: lockdep-specific
 
-The mount() method has the following arguments:
-
-``struct file_system_type *fs_type``
-	describes the filesystem, partly initialized by the specific
-	filesystem code
-
-``int flags``
-	mount flags
-
-``const char *dev_name``
-	the device name we are mounting.
-
-``void *data``
-	arbitrary mount options, usually comes as an ASCII string (see
-	"Mount Options" section)
-
-The mount() method must return the root dentry of the tree requested by
-caller.  An active reference to its superblock must be grabbed and the
-superblock must be locked.  On failure it should return ERR_PTR(error).
-
-The arguments match those of mount(2) and their interpretation depends
-on filesystem type.  E.g. for block filesystems, dev_name is interpreted
-as block device name, that device is opened and if it contains a
-suitable filesystem image the method creates and initializes struct
-super_block accordingly, returning its root dentry to caller.
-
-->mount() may choose to return a subtree of existing filesystem - it
-doesn't have to create a new one.  The main result from the caller's
-point of view is a reference to dentry at the root of (sub)tree to be
-attached; creation of new superblock is a common side effect.
-
-The most interesting member of the superblock structure that the mount()
-method fills in is the "s_op" field.  This is a pointer to a "struct
-super_operations" which describes the next level of the filesystem
-implementation.
-
-For more information on mounting (and the new mount API), see
-Documentation/filesystems/mount_api.rst.
-
 The Superblock Object
 =====================
 
@@ -244,7 +197,6 @@ filesystem.  The following members are defined:
 					enum freeze_wholder who);
 		int (*unfreeze_fs) (struct super_block *);
 		int (*statfs) (struct dentry *, struct kstatfs *);
-		int (*remount_fs) (struct super_block *, int *, char *);
 		void (*umount_begin) (struct super_block *);
 
 		int (*show_options)(struct seq_file *, struct dentry *);
@@ -351,10 +303,6 @@ or bottom half).
 ``statfs``
 	called when the VFS needs to get filesystem statistics.
 
-``remount_fs``
-	called when the filesystem is remounted.  This is called with
-	the kernel lock held
-
 ``umount_begin``
 	called when the VFS is unmounting a filesystem.
 
diff --git a/fs/fs_context.c b/fs/fs_context.c
index 93b7ebf8d927..81ed94f46cac 100644
--- a/fs/fs_context.c
+++ b/fs/fs_context.c
@@ -24,20 +24,6 @@
 #include "mount.h"
 #include "internal.h"
 
-enum legacy_fs_param {
-	LEGACY_FS_UNSET_PARAMS,
-	LEGACY_FS_MONOLITHIC_PARAMS,
-	LEGACY_FS_INDIVIDUAL_PARAMS,
-};
-
-struct legacy_fs_context {
-	char			*legacy_data;	/* Data page for legacy filesystems */
-	size_t			data_size;
-	enum legacy_fs_param	param_type;
-};
-
-static int legacy_init_fs_context(struct fs_context *fc);
-
 static const struct constant_table common_set_sb_flag[] = {
 	{ "dirsync",	SB_DIRSYNC },
 	{ "lazytime",	SB_LAZYTIME },
@@ -275,7 +261,6 @@ static struct fs_context *alloc_fs_context(struct file_system_type *fs_type,
 				      unsigned int sb_flags_mask,
 				      enum fs_context_purpose purpose)
 {
-	int (*init_fs_context)(struct fs_context *);
 	struct fs_context *fc;
 	int ret = -ENOMEM;
 
@@ -307,12 +292,7 @@ static struct fs_context *alloc_fs_context(struct file_system_type *fs_type,
 		break;
 	}
 
-	/* TODO: Make all filesystems support this unconditionally */
-	init_fs_context = fc->fs_type->init_fs_context;
-	if (!init_fs_context)
-		init_fs_context = legacy_init_fs_context;
-
-	ret = init_fs_context(fc);
+	ret = fc->fs_type->init_fs_context(fc);
 	if (ret < 0)
 		goto err_fc;
 	fc->need_free = true;
@@ -376,8 +356,6 @@ void fc_drop_locked(struct fs_context *fc)
 	deactivate_locked_super(sb);
 }
 
-static void legacy_fs_context_free(struct fs_context *fc);
-
 /**
  * vfs_dup_fs_context - Duplicate a filesystem context.
  * @src_fc: The context to copy.
@@ -531,184 +509,6 @@ void put_fs_context(struct fs_context *fc)
 }
 EXPORT_SYMBOL(put_fs_context);
 
-/*
- * Free the config for a filesystem that doesn't support fs_context.
- */
-static void legacy_fs_context_free(struct fs_context *fc)
-{
-	struct legacy_fs_context *ctx = fc->fs_private;
-
-	if (ctx) {
-		if (ctx->param_type == LEGACY_FS_INDIVIDUAL_PARAMS)
-			kfree(ctx->legacy_data);
-		kfree(ctx);
-	}
-}
-
-/*
- * Duplicate a legacy config.
- */
-static int legacy_fs_context_dup(struct fs_context *fc, struct fs_context *src_fc)
-{
-	struct legacy_fs_context *ctx;
-	struct legacy_fs_context *src_ctx = src_fc->fs_private;
-
-	ctx = kmemdup(src_ctx, sizeof(*src_ctx), GFP_KERNEL);
-	if (!ctx)
-		return -ENOMEM;
-
-	if (ctx->param_type == LEGACY_FS_INDIVIDUAL_PARAMS) {
-		ctx->legacy_data = kmemdup(src_ctx->legacy_data,
-					   src_ctx->data_size, GFP_KERNEL);
-		if (!ctx->legacy_data) {
-			kfree(ctx);
-			return -ENOMEM;
-		}
-	}
-
-	fc->fs_private = ctx;
-	return 0;
-}
-
-/*
- * Add a parameter to a legacy config.  We build up a comma-separated list of
- * options.
- */
-static int legacy_parse_param(struct fs_context *fc, struct fs_parameter *param)
-{
-	struct legacy_fs_context *ctx = fc->fs_private;
-	unsigned int size = ctx->data_size;
-	size_t len = 0;
-	int ret;
-
-	ret = vfs_parse_fs_param_source(fc, param);
-	if (ret != -ENOPARAM)
-		return ret;
-
-	if (ctx->param_type == LEGACY_FS_MONOLITHIC_PARAMS)
-		return invalf(fc, "VFS: Legacy: Can't mix monolithic and individual options");
-
-	switch (param->type) {
-	case fs_value_is_string:
-		len = 1 + param->size;
-		fallthrough;
-	case fs_value_is_flag:
-		len += strlen(param->key);
-		break;
-	default:
-		return invalf(fc, "VFS: Legacy: Parameter type for '%s' not supported",
-			      param->key);
-	}
-
-	if (size + len + 2 > PAGE_SIZE)
-		return invalf(fc, "VFS: Legacy: Cumulative options too large");
-	if (strchr(param->key, ',') ||
-	    (param->type == fs_value_is_string &&
-	     memchr(param->string, ',', param->size)))
-		return invalf(fc, "VFS: Legacy: Option '%s' contained comma",
-			      param->key);
-	if (!ctx->legacy_data) {
-		ctx->legacy_data = kmalloc(PAGE_SIZE, GFP_KERNEL);
-		if (!ctx->legacy_data)
-			return -ENOMEM;
-	}
-
-	if (size)
-		ctx->legacy_data[size++] = ',';
-	len = strlen(param->key);
-	memcpy(ctx->legacy_data + size, param->key, len);
-	size += len;
-	if (param->type == fs_value_is_string) {
-		ctx->legacy_data[size++] = '=';
-		memcpy(ctx->legacy_data + size, param->string, param->size);
-		size += param->size;
-	}
-	ctx->legacy_data[size] = '\0';
-	ctx->data_size = size;
-	ctx->param_type = LEGACY_FS_INDIVIDUAL_PARAMS;
-	return 0;
-}
-
-/*
- * Add monolithic mount data.
- */
-static int legacy_parse_monolithic(struct fs_context *fc, void *data)
-{
-	struct legacy_fs_context *ctx = fc->fs_private;
-
-	if (ctx->param_type != LEGACY_FS_UNSET_PARAMS) {
-		pr_warn("VFS: Can't mix monolithic and individual options\n");
-		return -EINVAL;
-	}
-
-	ctx->legacy_data = data;
-	ctx->param_type = LEGACY_FS_MONOLITHIC_PARAMS;
-	if (!ctx->legacy_data)
-		return 0;
-
-	if (fc->fs_type->fs_flags & FS_BINARY_MOUNTDATA)
-		return 0;
-	return security_sb_eat_lsm_opts(ctx->legacy_data, &fc->security);
-}
-
-/*
- * Get a mountable root with the legacy mount command.
- */
-static int legacy_get_tree(struct fs_context *fc)
-{
-	struct legacy_fs_context *ctx = fc->fs_private;
-	struct super_block *sb;
-	struct dentry *root;
-
-	root = fc->fs_type->mount(fc->fs_type, fc->sb_flags,
-				      fc->source, ctx->legacy_data);
-	if (IS_ERR(root))
-		return PTR_ERR(root);
-
-	sb = root->d_sb;
-	BUG_ON(!sb);
-
-	fc->root = root;
-	return 0;
-}
-
-/*
- * Handle remount.
- */
-static int legacy_reconfigure(struct fs_context *fc)
-{
-	struct legacy_fs_context *ctx = fc->fs_private;
-	struct super_block *sb = fc->root->d_sb;
-
-	if (!sb->s_op->remount_fs)
-		return 0;
-
-	return sb->s_op->remount_fs(sb, &fc->sb_flags,
-				    ctx ? ctx->legacy_data : NULL);
-}
-
-const struct fs_context_operations legacy_fs_context_ops = {
-	.free			= legacy_fs_context_free,
-	.dup			= legacy_fs_context_dup,
-	.parse_param		= legacy_parse_param,
-	.parse_monolithic	= legacy_parse_monolithic,
-	.get_tree		= legacy_get_tree,
-	.reconfigure		= legacy_reconfigure,
-};
-
-/*
- * Initialise a legacy context for a filesystem that doesn't support
- * fs_context.
- */
-static int legacy_init_fs_context(struct fs_context *fc)
-{
-	fc->fs_private = kzalloc(sizeof(struct legacy_fs_context), GFP_KERNEL_ACCOUNT);
-	if (!fc->fs_private)
-		return -ENOMEM;
-	fc->ops = &legacy_fs_context_ops;
-	return 0;
-}
-
 int parse_monolithic_mount_data(struct fs_context *fc, void *data)
 {
 	int (*monolithic_mount_data)(struct fs_context *, void *);
@@ -757,10 +557,8 @@ int finish_clean_context(struct fs_context *fc)
 	if (fc->phase != FS_CONTEXT_AWAITING_RECONF)
 		return 0;
 
-	if (fc->fs_type->init_fs_context)
-		error = fc->fs_type->init_fs_context(fc);
-	else
-		error = legacy_init_fs_context(fc);
+	error = fc->fs_type->init_fs_context(fc);
+
 	if (unlikely(error)) {
 		fc->phase = FS_CONTEXT_FAILED;
 		return error;
diff --git a/fs/fsopen.c b/fs/fsopen.c
index f645c99204eb..622ee3926cd5 100644
--- a/fs/fsopen.c
+++ b/fs/fsopen.c
@@ -404,16 +404,6 @@ SYSCALL_DEFINE5(fsconfig,
 		return -EINVAL;
 
 	fc = fd_file(f)->private_data;
-	if (fc->ops == &legacy_fs_context_ops) {
-		switch (cmd) {
-		case FSCONFIG_SET_BINARY:
-		case FSCONFIG_SET_PATH:
-		case FSCONFIG_SET_PATH_EMPTY:
-		case FSCONFIG_SET_FD:
-		case FSCONFIG_CMD_CREATE_EXCL:
-			return -EOPNOTSUPP;
-		}
-	}
 
 	if (_key) {
 		param.key = strndup_user(_key, 256);
diff --git a/fs/internal.h b/fs/internal.h
index ab638d41ab81..e333b105337a 100644
--- a/fs/internal.h
+++ b/fs/internal.h
@@ -44,7 +44,6 @@ extern void __init chrdev_init(void);
 /*
  * fs_context.c
  */
-extern const struct fs_context_operations legacy_fs_context_ops;
 extern int parse_monolithic_mount_data(struct fs_context *, void *);
 extern void vfs_clean_context(struct fs_context *fc);
 extern int finish_clean_context(struct fs_context *fc);
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 04ceeca12a0d..9949d253e5aa 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2274,8 +2274,6 @@ struct file_system_type {
 #define FS_RENAME_DOES_D_MOVE	32768	/* FS will handle d_move() during rename() internally. */
 	int (*init_fs_context)(struct fs_context *);
 	const struct fs_parameter_spec *parameters;
-	struct dentry *(*mount) (struct file_system_type *, int,
-		       const char *, void *);
 	void (*kill_sb) (struct super_block *);
 	struct module *owner;
 	struct file_system_type * next;
diff --git a/include/linux/fs/super_types.h b/include/linux/fs/super_types.h
index 6bd3009e09b3..4bb9981af6ac 100644
--- a/include/linux/fs/super_types.h
+++ b/include/linux/fs/super_types.h
@@ -96,7 +96,6 @@ struct super_operations {
 			  const void *owner);
 	int (*unfreeze_fs)(struct super_block *sb);
 	int (*statfs)(struct dentry *dentry, struct kstatfs *kstatfs);
-	int (*remount_fs) (struct super_block *, int *, char *);
 	void (*umount_begin)(struct super_block *sb);
 
 	int (*show_options)(struct seq_file *seq, struct dentry *dentry);
-- 
2.52.0


