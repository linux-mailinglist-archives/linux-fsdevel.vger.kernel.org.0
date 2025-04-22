Return-Path: <linux-fsdevel+bounces-46950-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3916EA96DDE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Apr 2025 16:05:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 87DEF1898392
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Apr 2025 14:03:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A631A283CAC;
	Tue, 22 Apr 2025 14:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tmsaNYAy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 144A427C158
	for <linux-fsdevel@vger.kernel.org>; Tue, 22 Apr 2025 14:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745330568; cv=none; b=jwEpLZ6/UIhbhmXBgEXVz0WpW7Kgks2eHRUHyMOxCRSbHJ0SJklY8PYxXScGZlFA2UMcjI4A6liD0wXvkDlAGZWn2JY6lfj6B8k3jWGGy6q3DpuSocEcJzhdz/FMtFqdRzdRoEC31TCEoYF2joAzO2M1iKRxQ3KmtUOGvE4R5y8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745330568; c=relaxed/simple;
	bh=ULMuanv1mOQ+KgavRDkmnIW9XETVlZYpexhA0ZUTTeg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RIJa0RAwIF81MfDF8AiAVTntk2So4TvUP4xGVnXjlYO9h7BHqhFhX65mbQxpxxhVxdpmt+gN8JtlK2HR5MGX+ngUbwANqQsj22YsTCfopiIhA8ULxbEsHlD74/je3bHvKc8/taOe2FShZCes5W0QjjaZKIc3iK/x+4iTcxfLxCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tmsaNYAy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA311C4CEEE;
	Tue, 22 Apr 2025 14:02:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745330567;
	bh=ULMuanv1mOQ+KgavRDkmnIW9XETVlZYpexhA0ZUTTeg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=tmsaNYAyaFTCkkZlz+eMeCZ50rsMNl9JF851A2EhGmUNemhLgUiVa6urIJecvO3Dt
	 t2AKQxVQ+2Wlf+bU899MCzmXOQ7WtEmaR6zOFCJBot+sHXDeQxczqvnuC6/NJdd5Tx
	 ce625h5PMJvstG5iHz6cpF7EEiH70wDwQTNHAQI3A9jWNYUNFyAC/PoLtxwFReYSCD
	 qRDL8IXLsvjiYnurXNDbGf96VpfXXmLfLPmGvveC+Yt9GFLzZpyR3yN4SfDdmJd99n
	 U22cqUo//rcmq/1aM86kSI8FFuzQbAGnjGi7cStMc5WT1QblO60QJji+AzuZVACNM7
	 JUgorDci4m+Kg==
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 22 Apr 2025 16:02:33 +0200
Subject: [PATCH v2 2/2] inode: add fastpath for filesystem user namespace
 retrieval
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250422-work-mnt_idmap-s_user_ns-v2-2-34ce4a82f931@kernel.org>
References: <20250422-work-mnt_idmap-s_user_ns-v2-0-34ce4a82f931@kernel.org>
In-Reply-To: <20250422-work-mnt_idmap-s_user_ns-v2-0-34ce4a82f931@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>, 
 linux-fsdevel <linux-fsdevel@vger.kernel.org>
Cc: Mateusz Guzik <mjguzik@gmail.com>, Al Viro <viro@zeniv.linux.org.uk>, 
 Jan Kara <jack@suse.cz>, Jeff Layton <jlayton@kernel.org>, 
 Josef Bacik <josef@toxicpanda.com>, Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-c25d1
X-Developer-Signature: v=1; a=openpgp-sha256; l=4888; i=brauner@kernel.org;
 h=from:subject:message-id; bh=ULMuanv1mOQ+KgavRDkmnIW9XETVlZYpexhA0ZUTTeg=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSwL2zw+Cp+ta7Z6qnw+0rXhe3ykjWbpVpzl8pF6kUpr
 TU1y5LtKGVhEONikBVTZHFoNwmXW85TsdkoUwNmDisTyBAGLk4BmEjwCYb/XtHry1r+Jn8r6VjA
 H/DbZ6eNbdmcux3vLT9obvVjeszoysgwJTJGw29euEP+uYfappbrradEVi5fu/2BfolK2hVZ1nZ
 uAA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

We currently always chase a pointer inode->i_sb->s_user_ns whenever we
need to map a uid/gid which is noticeable during path lookup as noticed
by Linus in [1]. In the majority of cases we don't need to bother with
that pointer chase because the inode won't be located on a filesystem
that's mounted in a user namespace. The user namespace of the superblock
cannot ever change once it's mounted. So introduce and raise IOP_USERNS
on all inodes and check for that flag.

Link: https://lore.kernel.org/CAHk-=whJgRDtxTudTQ9HV8BFw5-bBsu+c8Ouwd_PrPqPB6_KEQ@mail.gmail.com [1]
Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/inode.c                    |  8 ++++++++
 include/linux/fs.h            | 23 ++++++++++++++++++++---
 include/linux/mnt_idmapping.h |  5 +++++
 3 files changed, 33 insertions(+), 3 deletions(-)

diff --git a/fs/inode.c b/fs/inode.c
index 99318b157a9a..8824e462800b 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -245,6 +245,8 @@ int inode_init_always_gfp(struct super_block *sb, struct inode *inode, gfp_t gfp
 		inode->i_opflags |= IOP_XATTR;
 	if (sb->s_type->fs_flags & FS_MGTIME)
 		inode->i_opflags |= IOP_MGTIME;
+	if (unlikely(sb->s_user_ns != &init_user_ns))
+		inode->i_opflags |= IOP_USERNS;
 	i_uid_write(inode, 0);
 	i_gid_write(inode, 0);
 	atomic_set(&inode->i_writecount, 0);
@@ -1864,6 +1866,12 @@ static void iput_final(struct inode *inode)
 
 	WARN_ON(inode->i_state & I_NEW);
 
+	/* This is security sensitive so catch missing IOP_USERNS. */
+	VFS_WARN_ON_ONCE(!(inode->i_opflags & IOP_USERNS) &&
+			 (inode->i_sb->s_user_ns != &init_user_ns));
+	VFS_WARN_ON_ONCE((inode->i_opflags & IOP_USERNS) &&
+			 (inode->i_sb->s_user_ns == &init_user_ns));
+
 	if (op->drop_inode)
 		drop = op->drop_inode(inode);
 	else
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 016b0fe1536e..eae1b992aef5 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -663,6 +663,7 @@ is_uncached_acl(struct posix_acl *acl)
 #define IOP_DEFAULT_READLINK	0x0010
 #define IOP_MGTIME	0x0020
 #define IOP_CACHED_LINK	0x0040
+#define IOP_USERNS	0x0080
 
 /*
  * Keep mostly read-only and often accessed (especially for
@@ -1454,7 +1455,13 @@ struct super_block {
 
 static inline struct user_namespace *i_user_ns(const struct inode *inode)
 {
-	return inode->i_sb->s_user_ns;
+	VFS_WARN_ON_ONCE(!(inode->i_opflags & IOP_USERNS) &&
+			 (inode->i_sb->s_user_ns != &init_user_ns));
+	VFS_WARN_ON_ONCE((inode->i_opflags & IOP_USERNS) &&
+			 (inode->i_sb->s_user_ns == &init_user_ns));
+	if (unlikely(inode->i_opflags & IOP_USERNS))
+		return inode->i_sb->s_user_ns;
+	return &init_user_ns;
 }
 
 /* Helper functions so that in most cases filesystems will
@@ -1493,6 +1500,8 @@ static inline void i_gid_write(struct inode *inode, gid_t gid)
 static inline vfsuid_t i_uid_into_vfsuid(struct mnt_idmap *idmap,
 					 const struct inode *inode)
 {
+	if (likely(is_nop_mnt_idmap(idmap)))
+		return VFSUIDT_INIT(inode->i_uid);
 	return make_vfsuid(idmap, i_user_ns(inode), inode->i_uid);
 }
 
@@ -1545,6 +1554,8 @@ static inline void i_uid_update(struct mnt_idmap *idmap,
 static inline vfsgid_t i_gid_into_vfsgid(struct mnt_idmap *idmap,
 					 const struct inode *inode)
 {
+	if (likely(is_nop_mnt_idmap(idmap)))
+		return VFSGIDT_INIT(inode->i_gid);
 	return make_vfsgid(idmap, i_user_ns(inode), inode->i_gid);
 }
 
@@ -1597,7 +1608,10 @@ static inline void i_gid_update(struct mnt_idmap *idmap,
 static inline void inode_fsuid_set(struct inode *inode,
 				   struct mnt_idmap *idmap)
 {
-	inode->i_uid = mapped_fsuid(idmap, i_user_ns(inode));
+	if (likely(is_nop_mnt_idmap(idmap)))
+		inode->i_uid = current_fsuid();
+	else
+		inode->i_uid = mapped_fsuid(idmap, i_user_ns(inode));
 }
 
 /**
@@ -1611,7 +1625,10 @@ static inline void inode_fsuid_set(struct inode *inode,
 static inline void inode_fsgid_set(struct inode *inode,
 				   struct mnt_idmap *idmap)
 {
-	inode->i_gid = mapped_fsgid(idmap, i_user_ns(inode));
+	if (likely(is_nop_mnt_idmap(idmap)))
+		inode->i_gid = current_fsgid();
+	else
+		inode->i_gid = mapped_fsgid(idmap, i_user_ns(inode));
 }
 
 /**
diff --git a/include/linux/mnt_idmapping.h b/include/linux/mnt_idmapping.h
index e71a6070a8f8..22e6e2f08d77 100644
--- a/include/linux/mnt_idmapping.h
+++ b/include/linux/mnt_idmapping.h
@@ -25,6 +25,11 @@ static_assert(sizeof(vfsgid_t) == sizeof(kgid_t));
 static_assert(offsetof(vfsuid_t, val) == offsetof(kuid_t, val));
 static_assert(offsetof(vfsgid_t, val) == offsetof(kgid_t, val));
 
+static __always_inline bool is_nop_mnt_idmap(const struct mnt_idmap *idmap)
+{
+	return idmap == &nop_mnt_idmap;
+}
+
 static inline bool is_valid_mnt_idmap(const struct mnt_idmap *idmap)
 {
 	return idmap != &nop_mnt_idmap && idmap != &invalid_mnt_idmap;

-- 
2.47.2


