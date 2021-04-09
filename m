Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6ACE2359CCC
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Apr 2021 13:13:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233874AbhDILNV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 9 Apr 2021 07:13:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:52009 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233865AbhDILNQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 9 Apr 2021 07:13:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617966783;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=h+1Qagx3cCVaJ1jjRtz1b0edzM/KgZZ0z6+9UTqjcSQ=;
        b=gz/iTsKHs4uVhONQ4rfqcshVn+JhChV7jdXFRw7dMOSgen0QbQx2H0/AluIMHCPVE1JIV4
        Mc0TBe8u6qHIxecSlCU/osfsBDlTqPDPFvqZ33xXOfNyB+wKmA7WRH/JkWB4BgAKYgBcrp
        dDqXEK+2EwvI3Wd30IiN4NV0JViLG3o=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-531-82R4uKS4MZ6_k9bzWflmNg-1; Fri, 09 Apr 2021 07:13:02 -0400
X-MC-Unique: 82R4uKS4MZ6_k9bzWflmNg-1
Received: by mail-ej1-f72.google.com with SMTP id jt26so2056766ejc.18
        for <linux-fsdevel@vger.kernel.org>; Fri, 09 Apr 2021 04:13:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=h+1Qagx3cCVaJ1jjRtz1b0edzM/KgZZ0z6+9UTqjcSQ=;
        b=tueO0cg7CyWhkS0U2ihurbJdn4QpAraRZmbwNtno82ht/hxXApYXPBxY1Snnz3fJTM
         1hQCP/mgjR3nRu2K91Qoj2HW/pxaG2QCQ9gJ9DZLDQtvs/THPFL6zk6Sxs6oLPpCkHqx
         d7bBKJuEHobhbOxDqE4ypXhGJziD+KomN/1KBmfxBq6Z4e9aMjSeN58OxDXSy3Iak4+Y
         +DQbImyAfikkIVoQ0OdSYhgoEw27X9Jvn/mn7i5JvB39sXTpRzq4rkmcfTjdF/t3ToGS
         5bbX/CRl+Q4WiEVCD9GcPwIBXiO4JoUieQrhKWthNoFZgKkey4JnK0SGZMhLxL4zNFT0
         Ladg==
X-Gm-Message-State: AOAM531LHLt5HkxmK1qC29xdIzjedDjcX+DNdF0W5q5dGrjYiCIX2F88
        7IiFOL0TnzsNS5uD8LHpP1vRC2DsnnVLLmu5mTQk4+/maFh5ol2CS92l4OHvmIccrK5Ug9SehmG
        OevLJDuwszFc9k7W9GV9LHnZ8og==
X-Received: by 2002:a05:6402:22a6:: with SMTP id cx6mr17073389edb.55.1617966779811;
        Fri, 09 Apr 2021 04:12:59 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwOx9dti750S+dQZ55+1hkSSmP2GiVKcoTej1xkJFMYAzjjCzdV/dvzrQwmr5xFkeLHGynV3w==
X-Received: by 2002:a05:6402:22a6:: with SMTP id cx6mr17073373edb.55.1617966779592;
        Fri, 09 Apr 2021 04:12:59 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8308:b105:dd00:277b:6436:24db:9466])
        by smtp.gmail.com with ESMTPSA id w18sm1046854ejq.58.2021.04.09.04.12.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Apr 2021 04:12:59 -0700 (PDT)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-btrfs@vger.kernel.org, Paul Moore <paul@paul-moore.com>,
        Olga Kornievskaia <aglo@umich.edu>,
        Al Viro <viro@zeniv.linux.org.uk>,
        David Howells <dhowells@redhat.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH 1/2] vfs,LSM: introduce the FS_HANDLES_LSM_OPTS flag
Date:   Fri,  9 Apr 2021 13:12:53 +0200
Message-Id: <20210409111254.271800-2-omosnace@redhat.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210409111254.271800-1-omosnace@redhat.com>
References: <20210409111254.271800-1-omosnace@redhat.com>
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
   doing for its subvolume support. Setting FS_BINARY_MOUNTDATA (to
   prevent VFS from eating away the LSM opts) and FS_HANDLES_LSM_OPTS
   (to prevent an extra security_sb_set_mnt_opts() call) on the outer
   layer and none of them on the lower layer allows to leave the LSM
   option handling entirely on VFS as part of the vfs_kern_mount() call.

2. Removal of the ugly FS_BINARY_MOUNTDATA special case from
   selinux_set_mnt_opts().

   Applying (1.) and also setting FS_HANDLES_LSM_OPTS on NFS fs_types
   (which needs to unavoidably do the LSM options handling on its own
   due to the SECURITY_LSM_NATIVE_LABELS flag usage) gets us to the
   state where there exactly one security_sb_set_mnt_opts() or
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
 fs/btrfs/super.c         | 35 ++++++-----------------------------
 fs/nfs/fs_context.c      |  6 ++++--
 fs/super.c               | 10 ++++++----
 include/linux/fs.h       |  3 ++-
 security/selinux/hooks.c | 15 ---------------
 5 files changed, 18 insertions(+), 51 deletions(-)

diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index f7a4ad86adee..bdce18f8a263 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -1640,19 +1640,12 @@ static struct dentry *btrfs_mount_root(struct file_system_type *fs_type,
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
@@ -1662,10 +1655,9 @@ static struct dentry *btrfs_mount_root(struct file_system_type *fs_type,
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
@@ -1722,9 +1714,6 @@ static struct dentry *btrfs_mount_root(struct file_system_type *fs_type,
 			set_bit(BTRFS_FS_CSUM_IMPL_FAST, &fs_info->flags);
 		error = btrfs_fill_super(s, fs_devices, data);
 	}
-	if (!error)
-		error = security_sb_set_mnt_opts(s, new_sec_opts, 0, NULL);
-	security_free_mnt_opts(&new_sec_opts);
 	if (error) {
 		deactivate_locked_super(s);
 		return ERR_PTR(error);
@@ -1736,8 +1725,6 @@ error_close_devices:
 	btrfs_close_devices(fs_devices);
 error_fs_info:
 	btrfs_free_fs_info(fs_info);
-error_sec_opts:
-	security_free_mnt_opts(&new_sec_opts);
 	return ERR_PTR(error);
 }
 
@@ -1899,17 +1886,6 @@ static int btrfs_remount(struct super_block *sb, int *flags, char *data)
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
@@ -2359,7 +2335,8 @@ static struct file_system_type btrfs_fs_type = {
 	.name		= "btrfs",
 	.mount		= btrfs_mount,
 	.kill_sb	= btrfs_kill_super,
-	.fs_flags	= FS_REQUIRES_DEV | FS_BINARY_MOUNTDATA,
+	.fs_flags	= FS_REQUIRES_DEV | FS_BINARY_MOUNTDATA |
+			  FS_HANDLES_LSM_OPTS,
 };
 
 static struct file_system_type btrfs_root_fs_type = {
@@ -2367,7 +2344,7 @@ static struct file_system_type btrfs_root_fs_type = {
 	.name		= "btrfs",
 	.mount		= btrfs_mount_root,
 	.kill_sb	= btrfs_kill_super,
-	.fs_flags	= FS_REQUIRES_DEV | FS_BINARY_MOUNTDATA,
+	.fs_flags	= FS_REQUIRES_DEV,
 };
 
 MODULE_ALIAS_FS("btrfs");
diff --git a/fs/nfs/fs_context.c b/fs/nfs/fs_context.c
index a06d213d7689..f9c2aaeb5000 100644
--- a/fs/nfs/fs_context.c
+++ b/fs/nfs/fs_context.c
@@ -1529,7 +1529,8 @@ struct file_system_type nfs_fs_type = {
 	.init_fs_context	= nfs_init_fs_context,
 	.parameters		= nfs_fs_parameters,
 	.kill_sb		= nfs_kill_super,
-	.fs_flags		= FS_RENAME_DOES_D_MOVE|FS_BINARY_MOUNTDATA,
+	.fs_flags		= FS_RENAME_DOES_D_MOVE|FS_BINARY_MOUNTDATA|
+				  FS_HANDLES_LSM_OPTS,
 };
 MODULE_ALIAS_FS("nfs");
 EXPORT_SYMBOL_GPL(nfs_fs_type);
@@ -1541,7 +1542,8 @@ struct file_system_type nfs4_fs_type = {
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
index 8c1baca35c16..315e63873947 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -1519,10 +1519,12 @@ int vfs_get_tree(struct fs_context *fc)
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
index ec8f3ddf4a6a..306f09d846ca 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2332,7 +2332,8 @@ struct file_system_type {
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
index 92f909a2e8f7..1daf7bec4bb0 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -691,21 +691,6 @@ static int selinux_set_mnt_opts(struct super_block *sb,
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
2.30.2

