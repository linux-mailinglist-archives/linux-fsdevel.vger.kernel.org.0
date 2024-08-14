Return-Path: <linux-fsdevel+bounces-25909-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2840B951A50
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Aug 2024 13:46:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ABB631F23407
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Aug 2024 11:46:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB3F61B8EA2;
	Wed, 14 Aug 2024 11:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="Mq2+gTyL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A2971BA86B
	for <linux-fsdevel@vger.kernel.org>; Wed, 14 Aug 2024 11:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723635708; cv=none; b=ffvVvSIbTljexBTUVhSay1cmy456erzWMqivs7WYmomws5SQ1oSu1EtVQ2dO08qZ0z8VmhGdJA8FUZoXZDPAWD9XcVKNkcE50bWB7TWAcjgUc+jUM7rovEZb3vYTG076/LyTFBkc597f7gpFEMJVjYzgrLSBMCkU6+VVsezaDQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723635708; c=relaxed/simple;
	bh=Nu3JnzracDB30usuIQ+vj3dQwpeU56RAKyxTWUIz45g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CtBxty2piXVOWa+/kh4VpQTwuRnoRZWkA19DEyKG1bg/54TVIaEw17FtDnnzPhtQ7Ubs1OyYbhTtQXntG7c9/FTVm1iSphOBUX0TS1GRxVTJhOiUDqoqaDY5ByD8eLpL+2iD725h8qCd7UavM6Crj1lk2nCmDol69pXR4IBnzHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=Mq2+gTyL; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com [209.85.218.69])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 87983402E8
	for <linux-fsdevel@vger.kernel.org>; Wed, 14 Aug 2024 11:41:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1723635704;
	bh=KD9NzSm5+MMz93MQtyiG/0y5v89JycwxOffT6YGByAg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version;
	b=Mq2+gTyLGqPeBpOgRLIH5AKqn2oBHrvAZk3M7xtH+F4Sirzh6zBB05xHa7uxwtxQZ
	 nzv/rbE6eZhb8tPch/JhCzB/UuJVSFVv0vPgTSDtnGJGdeStpLn7/yIuRA+xGoianI
	 n2CoB/TlBKBLAo6w3hrBtdkx1LJAXvdDpUgw5X9isBLIBsgjccMQexHwj42kCa7nug
	 ED2ud/T4gSx6tcTl+QKoE6sRwnEqtryXJlAjCrxjuOOSQwFekApcsZi31J3ptwU0IH
	 Mp6VkXCeNpk2/uugHOnOlSNceOM3fo7dHtgdKW/4G6GpGlrUTgoLyvM+83Sv32ABpV
	 4TWubTLx8aFUg==
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-a7ab644746eso481146166b.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 14 Aug 2024 04:41:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723635704; x=1724240504;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KD9NzSm5+MMz93MQtyiG/0y5v89JycwxOffT6YGByAg=;
        b=u8+1tja8gcvnjkMyRr6eeRJuH6afU566TmpvZeqyabpnETtxvKAukDN3rxLF1Hx5l6
         WwExNxFAaG3GvveeD9SXok4q1BkLNJFluM2iCd6cGPFkoqCOc6xiN4+c4eIp3jUo5B1Y
         kb1NpTfPzO/zWIoEqdl8qaLqNQgGWw5AR/N0Dop292XZfV54bOGyy4l8J3uJJvbuUeI6
         InbPApjuqyh9w6af+mD7mezuK3Sxo7uaU2V0OPTmEgT70Nz4NeXTSfplXEkbQYwBI4Wm
         N9UrR/ukw5pJJju1yShhIlPRGCcPWaP2Yd/VTnc3BiGh3hgfUD/r8ZHirdOWgCJmOt5R
         YK3g==
X-Forwarded-Encrypted: i=1; AJvYcCUHOxiMr4TsEwrGmrkX47d89YRiq7aVOde8W+Y/lC/j7w2nrK6meD4uf2A0yyOWcR/QrHRLorLpza6B2VXpEBE6pr7305uBzitrruqtPg==
X-Gm-Message-State: AOJu0YwMkdlhbzfpN9oJDLZIFCSUeRxGAuRsX+HgLk9FTkZLiHeJUCBH
	PTdTdm0iAdvafiFQoz53BTeLshFWJMbEBFra1vs8Ryx0RGE5VqxWw9JK40d+0FTwG8FFEQKTWe0
	kaqaxX1ZKdB2DCo5eJ4WBzu+0Fvfckn6IG4LXz2nbS1pEx1KIls/kj7lrf68EM6Sy8DsAP/Vv38
	Xd//s=
X-Received: by 2002:a17:907:e69e:b0:a6f:dc17:500a with SMTP id a640c23a62f3a-a8366c346e8mr193024566b.23.1723635703970;
        Wed, 14 Aug 2024 04:41:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGCtDuBcjhSjqmuN/1KTcbSpwd8Zoqt9Rg7qDsLMEgubihtTvt9UxHmb+ZDmB/MWTEeXYYmHg==
X-Received: by 2002:a17:907:e69e:b0:a6f:dc17:500a with SMTP id a640c23a62f3a-a8366c346e8mr193021966b.23.1723635703569;
        Wed, 14 Aug 2024 04:41:43 -0700 (PDT)
Received: from amikhalitsyn.. ([188.192.113.77])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a80f3fa782csm162586166b.60.2024.08.14.04.41.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Aug 2024 04:41:43 -0700 (PDT)
From: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
To: mszeredi@redhat.com
Cc: brauner@kernel.org,
	stgraber@stgraber.org,
	linux-fsdevel@vger.kernel.org,
	Seth Forshee <sforshee@kernel.org>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Amir Goldstein <amir73il@gmail.com>,
	Bernd Schubert <bschubert@ddn.com>,
	Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 9/9] fs/fuse: allow idmapped mounts
Date: Wed, 14 Aug 2024 13:40:34 +0200
Message-Id: <20240814114034.113953-10-aleksandr.mikhalitsyn@canonical.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240814114034.113953-1-aleksandr.mikhalitsyn@canonical.com>
References: <20240814114034.113953-1-aleksandr.mikhalitsyn@canonical.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now we have everything in place and we can allow idmapped mounts
by setting the FS_ALLOW_IDMAP flag. Notice that real availability
of idmapped mounts will depend on the fuse daemon. Fuse daemon
have to set FUSE_ALLOW_IDMAP flag in the FUSE_INIT reply.

To discuss:
- we enable idmapped mounts support only if "default_permissions" mode is enabled,
because otherwise we would need to deal with UID/GID mappings in the userspace side OR
provide the userspace with idmapped req->in.h.uid/req->in.h.gid values which is not
something that we probably want to. Idmapped mounts phylosophy is not about faking
caller uid/gid.

- We have a small offlist discussion with Christian around adding fs_type->allow_idmap
hook. Christian pointed that it would be nice to have a superblock flag instead like
SB_I_NOIDMAP and we can set this flag during mount time if we see that filesystem does not
support idmappings. But, unfortunately I didn't succeed here because the kernel will
know if the filesystem supports idmapping or not after FUSE_INIT request, but FUSE_INIT request
is being sent at the end of mounting process, so mount and superblock will exist and
visible by the userspace in that time. It seems like setting SB_I_NOIDMAP flag in this
case is too late as user may do the trick with creating a idmapped mount while it wasn't
restricted by SB_I_NOIDMAP. Alternatively, we can introduce a "positive" version SB_I_ALLOWIDMAP
and "weak" version of FS_ALLOW_IDMAP like FS_MAY_ALLOW_IDMAP. So if FS_MAY_ALLOW_IDMAP is set,
then SB_I_ALLOWIDMAP has to be set on the superblock to allow creation of an idmapped mount.
But that's a matter of our discussion.

Some extra links and examples:

- libfuse support
https://github.com/mihalicyn/libfuse/commits/idmap_support

- fuse-overlayfs support:
https://github.com/mihalicyn/fuse-overlayfs/commits/idmap_support

- cephfs-fuse conversion example
https://github.com/mihalicyn/ceph/commits/fuse_idmap

- glusterfs conversion example
https://github.com/mihalicyn/glusterfs/commits/fuse_idmap

Cc: Christian Brauner <brauner@kernel.org>
Cc: Seth Forshee <sforshee@kernel.org>
Cc: Miklos Szeredi <miklos@szeredi.hu>
Cc: Amir Goldstein <amir73il@gmail.com>
Cc: Bernd Schubert <bschubert@ddn.com>
Cc: <linux-fsdevel@vger.kernel.org>
Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
---
 fs/fuse/fuse_i.h          |  3 +++
 fs/fuse/inode.c           | 13 ++++++++++---
 include/uapi/linux/fuse.h |  5 ++++-
 3 files changed, 17 insertions(+), 4 deletions(-)

diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index 883151a44d72..b2780ab59069 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -848,6 +848,9 @@ struct fuse_conn {
 	/* Add owner_{u,g}id info when creating a new inode */
 	unsigned int owner_uid_gid_ext:1;
 
+	/* Allow creation of idmapped mounts */
+	unsigned int allow_idmap:1;
+
 	/* Does the filesystem support per inode DAX? */
 	unsigned int inode_dax:1;
 
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index 6c205731c844..ed4c2688047f 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -1345,6 +1345,12 @@ static void process_init_reply(struct fuse_mount *fm, struct fuse_args *args,
 				fm->sb->s_export_op = &fuse_export_fid_operations;
 			if (flags & FUSE_OWNER_UID_GID_EXT)
 				fc->owner_uid_gid_ext = 1;
+			if (flags & FUSE_ALLOW_IDMAP) {
+				if (fc->owner_uid_gid_ext && fc->default_permissions)
+					fc->allow_idmap = 1;
+				else
+					ok = false;
+			}
 		} else {
 			ra_pages = fc->max_read / PAGE_SIZE;
 			fc->no_lock = 1;
@@ -1392,7 +1398,8 @@ void fuse_send_init(struct fuse_mount *fm)
 		FUSE_HANDLE_KILLPRIV_V2 | FUSE_SETXATTR_EXT | FUSE_INIT_EXT |
 		FUSE_SECURITY_CTX | FUSE_CREATE_SUPP_GROUP |
 		FUSE_HAS_EXPIRE_ONLY | FUSE_DIRECT_IO_ALLOW_MMAP |
-		FUSE_NO_EXPORT_SUPPORT | FUSE_HAS_RESEND | FUSE_OWNER_UID_GID_EXT;
+		FUSE_NO_EXPORT_SUPPORT | FUSE_HAS_RESEND | FUSE_OWNER_UID_GID_EXT |
+		FUSE_ALLOW_IDMAP;
 #ifdef CONFIG_FUSE_DAX
 	if (fm->fc->dax)
 		flags |= FUSE_MAP_ALIGNMENT;
@@ -1981,7 +1988,7 @@ static void fuse_kill_sb_anon(struct super_block *sb)
 static struct file_system_type fuse_fs_type = {
 	.owner		= THIS_MODULE,
 	.name		= "fuse",
-	.fs_flags	= FS_HAS_SUBTYPE | FS_USERNS_MOUNT,
+	.fs_flags	= FS_HAS_SUBTYPE | FS_USERNS_MOUNT | FS_ALLOW_IDMAP,
 	.init_fs_context = fuse_init_fs_context,
 	.parameters	= fuse_fs_parameters,
 	.kill_sb	= fuse_kill_sb_anon,
@@ -2002,7 +2009,7 @@ static struct file_system_type fuseblk_fs_type = {
 	.init_fs_context = fuse_init_fs_context,
 	.parameters	= fuse_fs_parameters,
 	.kill_sb	= fuse_kill_sb_blk,
-	.fs_flags	= FS_REQUIRES_DEV | FS_HAS_SUBTYPE,
+	.fs_flags	= FS_REQUIRES_DEV | FS_HAS_SUBTYPE | FS_ALLOW_IDMAP,
 };
 MODULE_ALIAS_FS("fuseblk");
 
diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
index d9ecc17fd13b..b23e8247ce43 100644
--- a/include/uapi/linux/fuse.h
+++ b/include/uapi/linux/fuse.h
@@ -221,6 +221,7 @@
  *  7.41
  *  - add FUSE_EXT_OWNER_UID_GID
  *  - add FUSE_OWNER_UID_GID_EXT
+ *  - add FUSE_ALLOW_IDMAP
  */
 
 #ifndef _LINUX_FUSE_H
@@ -256,7 +257,7 @@
 #define FUSE_KERNEL_VERSION 7
 
 /** Minor version number of this interface */
-#define FUSE_KERNEL_MINOR_VERSION 40
+#define FUSE_KERNEL_MINOR_VERSION 41
 
 /** The node ID of the root inode */
 #define FUSE_ROOT_ID 1
@@ -427,6 +428,7 @@ struct fuse_file_lock {
  *		    of the request ID indicates resend requests
  * FUSE_OWNER_UID_GID_EXT: add inode owner UID/GID info to create, mkdir,
  *			   symlink and mknod
+ * FUSE_ALLOW_IDMAP: allow creation of idmapped mounts
  */
 #define FUSE_ASYNC_READ		(1 << 0)
 #define FUSE_POSIX_LOCKS	(1 << 1)
@@ -473,6 +475,7 @@ struct fuse_file_lock {
 /* Obsolete alias for FUSE_DIRECT_IO_ALLOW_MMAP */
 #define FUSE_DIRECT_IO_RELAX	FUSE_DIRECT_IO_ALLOW_MMAP
 #define FUSE_OWNER_UID_GID_EXT	(1ULL << 40)
+#define FUSE_ALLOW_IDMAP	(1ULL << 41)
 
 /**
  * CUSE INIT request/reply flags
-- 
2.34.1


