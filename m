Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EA76382DAD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 May 2021 15:42:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237457AbhEQNn2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 May 2021 09:43:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:22561 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237448AbhEQNn0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 May 2021 09:43:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621258929;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=twfsLPEKFgNum8AA5vaaUbq3d4tpMWc4MmkXXQv+4Yw=;
        b=LKwwxGmoTzaXybjjLiHDX+1OQFFJOseNrK+3Zdm5or54kYb53gcGxIxPT5FQ4HFe7RpiUr
        Y53MyhkUbbq8OCGUKZ28J/5ptHJhjnUTK86IUssPHPHzarI0FuA93XjXFDbQLXnBESl4Nw
        QPvLf0L6nb4kySGxCQ2PwRzBXL3reG8=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-155-P2GRv0puPUSWZYd9hhMhYw-1; Mon, 17 May 2021 09:42:07 -0400
X-MC-Unique: P2GRv0puPUSWZYd9hhMhYw-1
Received: by mail-ej1-f72.google.com with SMTP id bi3-20020a170906a243b02903933c4d9132so1057831ejb.11
        for <linux-fsdevel@vger.kernel.org>; Mon, 17 May 2021 06:42:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=twfsLPEKFgNum8AA5vaaUbq3d4tpMWc4MmkXXQv+4Yw=;
        b=pc9v9VMmNvtQCPQiEo1wSVbXahTQ6pc6SPnG2i/idRzWeMxk/a4DgaLmSpF0vyb3QO
         ZeXzoNYPLoiN9DwCPnyUP3PbqUKE0xxcwXEyeHNxLkD8w5clQu5rcU0JFyb6oDmHMtJC
         55deVihWBBJV8hK8A+7gbbVbGSA7pKmgyUpihhFjcNuVCSTQAbxD0R400G/DvhNM4EsN
         FmyOhJA9AvutLSi4OKuS8yN2Q6AaCL+TeHMNVcpgqAU4tHd0WmxhKjkqfUiv2a7TqN5r
         KRglcGHsqH40OasvWetZzksQ8er6qDkmDlp5VTqMvEyQz21qec0WB4Igdw42H9IKz/lA
         C88g==
X-Gm-Message-State: AOAM531AZj8rPqV3KXCkpY3MQBO84q5F7r04ARWBg1iVssLlTuyuQVZm
        mNfHleeTVo4OdAhyvVir3ZT4GbRfV78bN1eWGv5TTDLGDSSCHrNlsiN8xW8juDgMp72r+OcTTZw
        oZP/qs7HbarmA8tKZ7h6uF5VLYw==
X-Received: by 2002:a17:906:f42:: with SMTP id h2mr64182369ejj.317.1621258926501;
        Mon, 17 May 2021 06:42:06 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw/TXNfS7hrsXTejWGwZFUb7ADqFT+NBbJ8RGm5mhZDhJwKqzjaRjEb0LxdQjAcP74Co5oq5g==
X-Received: by 2002:a17:906:f42:: with SMTP id h2mr64182351ejj.317.1621258926237;
        Mon, 17 May 2021 06:42:06 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8308:b105:dd00:277b:6436:24db:9466])
        by smtp.gmail.com with ESMTPSA id f7sm11302466edd.5.2021.05.17.06.42.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 May 2021 06:42:05 -0700 (PDT)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-btrfs@vger.kernel.org, Paul Moore <paul@paul-moore.com>,
        Olga Kornievskaia <aglo@umich.edu>,
        Al Viro <viro@zeniv.linux.org.uk>,
        David Howells <dhowells@redhat.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Richard Haines <richard_c_haines@btinternet.com>
Subject: [PATCH v2 1/2] vfs,LSM: introduce the FS_HANDLES_LSM_OPTS flag
Date:   Mon, 17 May 2021 15:42:00 +0200
Message-Id: <20210517134201.29271-2-omosnace@redhat.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210517134201.29271-1-omosnace@redhat.com>
References: <20210517134201.29271-1-omosnace@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add a new FS_HANDLES_LSM_OPTS filesystem flag to singal to VFS that the
filesystem does LSM option setting for the given mount on its own, so
the security_sb_set_mnt_opts() call in vfs_get_tree() can be skipped.

This allows the following simplifications:
1. Removal of explicit LSM option handling from BTRFS.

   This exists only because of the double-layer mount that BTRFS is
   doing for its subvolume support. Setting FS_HANDLES_LSM_OPTS on the
   inner layer (btrfs_root_fs_type) and unsetting FS_BINARY_MOUNTDATA
   from both layers allows us to leave the LSM option handling entirely
   on VFS as part of the outer vfs_get_tree() call.

2. Removal of FS_BINARY_MOUNTDATA flags from BTRFS's fs_types.

   After applying (1.), we can let VFS eat away LSM opts at the outer
   mount layer and then do selinux_set_mnt_opts() with these opts, so
   setting the flag is no longer needed neither for preserving the LSM
   opts, nor for the SELinux double-set_mnt_opts exception.

3. Removal of the ugly FS_BINARY_MOUNTDATA special case from
   selinux_set_mnt_opts().

   Applying (1.) and also setting FS_HANDLES_LSM_OPTS on NFS fs_types
   (which needs to unavoidably do the LSM options handling on its own
   due to the SECURITY_LSM_NATIVE_LABELS flag usage) gets us to the
   state where there is an exactly one security_sb_set_mnt_opts() or
   security_sb_clone_mnt_opts() call for each superblock, so the rather
   hacky FS_BINARY_MOUNTDATA special case can be finally removed from
   security_sb_set_mnt_opts().

The only other filesystem that sets FS_BINARY_MOUNTDATA is coda, which
is also the only one that has binary mount data && doesn't do its own
LSM options handling. So for coda we leave FS_HANDLES_LSM_OPTS unset and
the behavior remains unchanged - with fsconfig(2) it (probably) won't
even mount and with mount(2) it still won't support LSM options (and the
security_sb_set_mnt_opts() will be always performed with empty LSM
options as before).

AFAICT, this shouldn't negatively affect the other LSMs. In fact, I
think AppArmor will now gain the ability to do its DFA matching on BTRFS
mount options, which was prevented before due to FS_BINARY_MOUNTDATA
being set on both its fs_types.

Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---
 fs/btrfs/super.c         | 34 +++++-----------------------------
 fs/nfs/fs_context.c      |  6 ++++--
 fs/super.c               | 10 ++++++----
 include/linux/fs.h       |  3 ++-
 security/selinux/hooks.c | 15 ---------------
 5 files changed, 17 insertions(+), 51 deletions(-)

diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index 4a396c1147f1..80716ead1cde 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -1666,19 +1666,12 @@ static struct dentry *btrfs_mount_root(struct file_system_type *fs_type,
 	struct btrfs_device *device = NULL;
 	struct btrfs_fs_devices *fs_devices = NULL;
 	struct btrfs_fs_info *fs_info = NULL;
-	void *new_sec_opts = NULL;
 	fmode_t mode = FMODE_READ;
 	int error = 0;
 
 	if (!(flags & SB_RDONLY))
 		mode |= FMODE_WRITE;
 
-	if (data) {
-		error = security_sb_eat_lsm_opts(data, &new_sec_opts);
-		if (error)
-			return ERR_PTR(error);
-	}
-
 	/*
 	 * Setup a dummy root and fs_info for test/set super.  This is because
 	 * we don't actually fill this stuff out until open_ctree, but we need
@@ -1688,10 +1681,9 @@ static struct dentry *btrfs_mount_root(struct file_system_type *fs_type,
 	 * superblock with our given fs_devices later on at sget() time.
 	 */
 	fs_info = kvzalloc(sizeof(struct btrfs_fs_info), GFP_KERNEL);
-	if (!fs_info) {
-		error = -ENOMEM;
-		goto error_sec_opts;
-	}
+	if (!fs_info)
+		return ERR_PTR(-ENOMEM);
+
 	btrfs_init_fs_info(fs_info);
 
 	fs_info->super_copy = kzalloc(BTRFS_SUPER_INFO_SIZE, GFP_KERNEL);
@@ -1748,9 +1740,6 @@ static struct dentry *btrfs_mount_root(struct file_system_type *fs_type,
 			set_bit(BTRFS_FS_CSUM_IMPL_FAST, &fs_info->flags);
 		error = btrfs_fill_super(s, fs_devices, data);
 	}
-	if (!error)
-		error = security_sb_set_mnt_opts(s, new_sec_opts, 0, NULL);
-	security_free_mnt_opts(&new_sec_opts);
 	if (error) {
 		deactivate_locked_super(s);
 		return ERR_PTR(error);
@@ -1762,8 +1751,6 @@ error_close_devices:
 	btrfs_close_devices(fs_devices);
 error_fs_info:
 	btrfs_free_fs_info(fs_info);
-error_sec_opts:
-	security_free_mnt_opts(&new_sec_opts);
 	return ERR_PTR(error);
 }
 
@@ -1925,17 +1912,6 @@ static int btrfs_remount(struct super_block *sb, int *flags, char *data)
 	sync_filesystem(sb);
 	set_bit(BTRFS_FS_STATE_REMOUNTING, &fs_info->fs_state);
 
-	if (data) {
-		void *new_sec_opts = NULL;
-
-		ret = security_sb_eat_lsm_opts(data, &new_sec_opts);
-		if (!ret)
-			ret = security_sb_remount(sb, new_sec_opts);
-		security_free_mnt_opts(&new_sec_opts);
-		if (ret)
-			goto restore;
-	}
-
 	ret = btrfs_parse_options(fs_info, data, *flags);
 	if (ret)
 		goto restore;
@@ -2385,7 +2361,7 @@ static struct file_system_type btrfs_fs_type = {
 	.name		= "btrfs",
 	.mount		= btrfs_mount,
 	.kill_sb	= btrfs_kill_super,
-	.fs_flags	= FS_REQUIRES_DEV | FS_BINARY_MOUNTDATA,
+	.fs_flags	= FS_REQUIRES_DEV,
 };
 
 static struct file_system_type btrfs_root_fs_type = {
@@ -2393,7 +2369,7 @@ static struct file_system_type btrfs_root_fs_type = {
 	.name		= "btrfs",
 	.mount		= btrfs_mount_root,
 	.kill_sb	= btrfs_kill_super,
-	.fs_flags	= FS_REQUIRES_DEV | FS_BINARY_MOUNTDATA,
+	.fs_flags	= FS_REQUIRES_DEV | FS_HANDLES_LSM_OPTS,
 };
 
 MODULE_ALIAS_FS("btrfs");
diff --git a/fs/nfs/fs_context.c b/fs/nfs/fs_context.c
index d95c9a39bc70..b5db4160e89b 100644
--- a/fs/nfs/fs_context.c
+++ b/fs/nfs/fs_context.c
@@ -1557,7 +1557,8 @@ struct file_system_type nfs_fs_type = {
 	.init_fs_context	= nfs_init_fs_context,
 	.parameters		= nfs_fs_parameters,
 	.kill_sb		= nfs_kill_super,
-	.fs_flags		= FS_RENAME_DOES_D_MOVE|FS_BINARY_MOUNTDATA,
+	.fs_flags		= FS_RENAME_DOES_D_MOVE|FS_BINARY_MOUNTDATA|
+				  FS_HANDLES_LSM_OPTS,
 };
 MODULE_ALIAS_FS("nfs");
 EXPORT_SYMBOL_GPL(nfs_fs_type);
@@ -1569,7 +1570,8 @@ struct file_system_type nfs4_fs_type = {
 	.init_fs_context	= nfs_init_fs_context,
 	.parameters		= nfs_fs_parameters,
 	.kill_sb		= nfs_kill_super,
-	.fs_flags		= FS_RENAME_DOES_D_MOVE|FS_BINARY_MOUNTDATA,
+	.fs_flags		= FS_RENAME_DOES_D_MOVE|FS_BINARY_MOUNTDATA|
+				  FS_HANDLES_LSM_OPTS,
 };
 MODULE_ALIAS_FS("nfs4");
 MODULE_ALIAS("nfs4");
diff --git a/fs/super.c b/fs/super.c
index 11b7e7213fd1..918c77b8c161 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -1520,10 +1520,12 @@ int vfs_get_tree(struct fs_context *fc)
 	smp_wmb();
 	sb->s_flags |= SB_BORN;
 
-	error = security_sb_set_mnt_opts(sb, fc->security, 0, NULL);
-	if (unlikely(error)) {
-		fc_drop_locked(fc);
-		return error;
+	if (!(fc->fs_type->fs_flags & FS_HANDLES_LSM_OPTS)) {
+		error = security_sb_set_mnt_opts(sb, fc->security, 0, NULL);
+		if (unlikely(error)) {
+			fc_drop_locked(fc);
+			return error;
+		}
 	}
 
 	/*
diff --git a/include/linux/fs.h b/include/linux/fs.h
index c3c88fdb9b2a..36f9cd37bc83 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2469,7 +2469,8 @@ struct file_system_type {
 #define FS_HAS_SUBTYPE		4
 #define FS_USERNS_MOUNT		8	/* Can be mounted by userns root */
 #define FS_DISALLOW_NOTIFY_PERM	16	/* Disable fanotify permission events */
-#define FS_ALLOW_IDMAP         32      /* FS has been updated to handle vfs idmappings. */
+#define FS_ALLOW_IDMAP		32	/* FS has been updated to handle vfs idmappings. */
+#define FS_HANDLES_LSM_OPTS	64	/* FS handles LSM opts on its own - skip it in VFS */
 #define FS_THP_SUPPORT		8192	/* Remove once all fs converted */
 #define FS_RENAME_DOES_D_MOVE	32768	/* FS will handle d_move() during rename() internally. */
 	int (*init_fs_context)(struct fs_context *);
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index eaea837d89d1..041529cbf214 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -684,21 +684,6 @@ static int selinux_set_mnt_opts(struct super_block *sb,
 		goto out;
 	}
 
-	/*
-	 * Binary mount data FS will come through this function twice.  Once
-	 * from an explicit call and once from the generic calls from the vfs.
-	 * Since the generic VFS calls will not contain any security mount data
-	 * we need to skip the double mount verification.
-	 *
-	 * This does open a hole in which we will not notice if the first
-	 * mount using this sb set explict options and a second mount using
-	 * this sb does not set any security options.  (The first options
-	 * will be used for both mounts)
-	 */
-	if ((sbsec->flags & SE_SBINITIALIZED) && (sb->s_type->fs_flags & FS_BINARY_MOUNTDATA)
-	    && !opts)
-		goto out;
-
 	root_isec = backing_inode_security_novalidate(root);
 
 	/*
-- 
2.31.1

