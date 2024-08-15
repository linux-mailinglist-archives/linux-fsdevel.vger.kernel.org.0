Return-Path: <linux-fsdevel+bounces-26051-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63759952C26
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Aug 2024 12:31:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 898E01C23668
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Aug 2024 10:31:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 231EC21C16B;
	Thu, 15 Aug 2024 09:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="X7pteKxh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1920B2139B0
	for <linux-fsdevel@vger.kernel.org>; Thu, 15 Aug 2024 09:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723713914; cv=none; b=FMM+QlVVfvuoSHuJJ+f6I6tb4WdABhhcuP9HcOLUrKHhuF+YlJa8lnNYdZlrEI4EtIGVCWhlDJ88ZQYFpCZ4fkTNvuTkSjqvYs07AqDSP/hV9Og4ryU6H3X4ENqK1rhQ+lTQLFW4Flh/B/nBhoJl8edX9ZWmUSiwNEwHSH7dIgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723713914; c=relaxed/simple;
	bh=Uvo6a5h0Mq4wDc4UKZj3kSS6IHIbPsNpdHtWtHYTJrE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mAgajzgataRQoLQ6l65RTNsAddRUbh3chFb7K3Vnp5mJstj+vixTz0y5kAxHkRdqB0Cho0uUyEZfKRHMQ9g2TzopyUvQvv+K9I72EF4IHshBqPTlxLO+OFErlZZaJyykwTQkgEQGbh8oPbj3XfP/J/3dGda43ZYLZFO0GDe7VAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=X7pteKxh; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com [209.85.218.71])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 9484B3F322
	for <linux-fsdevel@vger.kernel.org>; Thu, 15 Aug 2024 09:25:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1723713911;
	bh=63Iup0ra8rDQZw3AHJfX27OH/U8X3fJMxHpyqnCbE2I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version;
	b=X7pteKxhTQdg6dDKuM17Z4/hWR5DvkQhqHozDJFSmU9/1oUypHAs26OiJNOJm5DC0
	 TOWIwK54ndx+agaNEg0AiHWha6fj2NSWEW7SwuUXA2q6ByUfGHazkBpugUqYmDuxnY
	 jDyfzKph3kDXJZi4nDQFGWNeWOSCV/DofyxCiR7E7VmGOkuK9uViyz1qhwGzkxsj4t
	 nazEqdWOWTsB+GE5JiJ+AW70DhORI+kzlc1RaKGYtnqzdn+TmVepReAQPa0oI4QnAi
	 J7E/jIl4TNIyuZ0jKuDTyxZ/s6sNaNbzf8gg906Rxj6fb4Tm6y1nxgyYiHtetUx3mX
	 Zi0fukupu1LQg==
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-a79c35c28f1so71969866b.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 15 Aug 2024 02:25:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723713909; x=1724318709;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=63Iup0ra8rDQZw3AHJfX27OH/U8X3fJMxHpyqnCbE2I=;
        b=vNr0MfS+FUl9uU0IQ/mOHaFEbNLmfo4oijM7ZVddVFj/MZWJx2uNb5uEPd0zEH6F3d
         0QtP1Spxk0YxNoDEPYv+eRTzoQu/W40g4UD2/glDHAsVSegcvmru3bAPw+bl+CG88Zwk
         BrpA5gBv8+UbsmiKvyMnI0JxU7QhmuTlSKb6CIdcHO2A6Hp/Gv3yz/oT7c/5YAOXz5gl
         WCNPRX6VHc626VbUKDLDQgUjn+OXdYjNEMhv2o/yeC8Dop/XKIF+7pcHsjeZ+yStdaRp
         6ChCJSYvIZ/ivCXK5bGfZcr8xobDjLHAK1BLGj5Lgnn1b1YK85t5OjRFhBrO1yIbL7cg
         Cyqg==
X-Forwarded-Encrypted: i=1; AJvYcCUdAQ4mDTqEauOHCe0ZNUeyO/1lDVDLHsdnYSbk1apf4eRBDLAYQZ5LphVThxcO3yLrfx79gtEgDbHE38VM2rcfgF6adCfxWVGCIwjOLQ==
X-Gm-Message-State: AOJu0YzGbCO1Iwqr67Vp4x8ElizjS67iUcGjn+0d/cwoWhZ2XMYW0vSB
	cMiCt+nly+OGefU0MBMybsbkI5xf21296a+tVcSqtnnvzzxTTCfJ5oKiBs14NpSG8Q6emOZM1MS
	Mp+rwiwbBNpbJGHktbghjBioeGAEqE7aeVVJWogFdDNltgrEG8GtBzyeAH12hpAak3n73B9BhIf
	c8484=
X-Received: by 2002:a17:907:ea5:b0:a80:bf0f:2256 with SMTP id a640c23a62f3a-a8366c1e7a1mr381458966b.8.1723713909245;
        Thu, 15 Aug 2024 02:25:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IETTIDQ9OzhDD4lLGreLHiYuvXvyqwtTitrGMl+Ajjnib3jCTcBF7RJUjWTevOZFresikXBrg==
X-Received: by 2002:a17:907:ea5:b0:a80:bf0f:2256 with SMTP id a640c23a62f3a-a8366c1e7a1mr381457466b.8.1723713908704;
        Thu, 15 Aug 2024 02:25:08 -0700 (PDT)
Received: from amikhalitsyn.. ([188.192.113.77])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8383934585sm72142866b.107.2024.08.15.02.25.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2024 02:25:08 -0700 (PDT)
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
Subject: [PATCH v3 10/11] fs/fuse: allow idmapped mounts
Date: Thu, 15 Aug 2024 11:24:27 +0200
Message-Id: <20240815092429.103356-11-aleksandr.mikhalitsyn@canonical.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240815092429.103356-1-aleksandr.mikhalitsyn@canonical.com>
References: <20240815092429.103356-1-aleksandr.mikhalitsyn@canonical.com>
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
v2:
	- simplified and get rid of ->allow_idmap global VFS callback
v3:
	- now use a new SB_I_NOIDMAP flag
---
 fs/fuse/inode.c           | 14 +++++++++++---
 include/uapi/linux/fuse.h |  5 ++++-
 2 files changed, 15 insertions(+), 4 deletions(-)

diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index 6c205731c844..b840189ac8be 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -1345,6 +1345,12 @@ static void process_init_reply(struct fuse_mount *fm, struct fuse_args *args,
 				fm->sb->s_export_op = &fuse_export_fid_operations;
 			if (flags & FUSE_OWNER_UID_GID_EXT)
 				fc->owner_uid_gid_ext = 1;
+			if (flags & FUSE_ALLOW_IDMAP) {
+				if (fc->owner_uid_gid_ext && fc->default_permissions)
+					fm->sb->s_iflags &= ~SB_I_NOIDMAP;
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
@@ -1569,6 +1576,7 @@ static void fuse_sb_defaults(struct super_block *sb)
 	sb->s_time_gran = 1;
 	sb->s_export_op = &fuse_export_operations;
 	sb->s_iflags |= SB_I_IMA_UNVERIFIABLE_SIGNATURE;
+	sb->s_iflags |= SB_I_NOIDMAP;
 	if (sb->s_user_ns != &init_user_ns)
 		sb->s_iflags |= SB_I_UNTRUSTED_MOUNTER;
 	sb->s_flags &= ~(SB_NOSEC | SB_I_VERSION);
@@ -1981,7 +1989,7 @@ static void fuse_kill_sb_anon(struct super_block *sb)
 static struct file_system_type fuse_fs_type = {
 	.owner		= THIS_MODULE,
 	.name		= "fuse",
-	.fs_flags	= FS_HAS_SUBTYPE | FS_USERNS_MOUNT,
+	.fs_flags	= FS_HAS_SUBTYPE | FS_USERNS_MOUNT | FS_ALLOW_IDMAP,
 	.init_fs_context = fuse_init_fs_context,
 	.parameters	= fuse_fs_parameters,
 	.kill_sb	= fuse_kill_sb_anon,
@@ -2002,7 +2010,7 @@ static struct file_system_type fuseblk_fs_type = {
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


