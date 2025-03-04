Return-Path: <linux-fsdevel+bounces-43060-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BECDA4D8E8
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Mar 2025 10:42:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9DB827A8AAA
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Mar 2025 09:41:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 605D81FE471;
	Tue,  4 Mar 2025 09:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Amd2FO/r"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0B201FE463
	for <linux-fsdevel@vger.kernel.org>; Tue,  4 Mar 2025 09:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741081285; cv=none; b=d7bCA1Rw8QsnC+C4+YihVD3uXjVMSdlhCLkv6Uyo5kTkYGzT58fp85X+0/CTWRnZ3P6uPLGEK+9eOjcrD7SZ3efn/6GTcZOxL21/4IC4TuYAuK8iUBJ/aVjgAOX77Ybx34NyxjXxPlikZjXvnuYMv/fu0Eo3Xq3U4NJyTqTetCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741081285; c=relaxed/simple;
	bh=5UJ5+NEk52qrd6NpAEn4HqD7lO+VX1y3AJVnvn5cRms=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gSSRjbpq8IWedcRmE+xT22Gy0oEBceZ8EEWcQMphxYubegz9qUOAb1ly7D5hoDypGy15ZP9f0gsmSf0G4dPrjqtRl8LhF/Bs0lby/VumBJ9sPOmUwtEfLfNY+6otoHJgCM/vIyFpTHG0guVNoldarUlNKlhVJmZ/moG2PISGzPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Amd2FO/r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAC68C4CEE9;
	Tue,  4 Mar 2025 09:41:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741081285;
	bh=5UJ5+NEk52qrd6NpAEn4HqD7lO+VX1y3AJVnvn5cRms=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Amd2FO/rPqYXYe/UksFl2uS52iDkatuJBVY5P0rAxy5/OVX96w+a05Cr2CIjblhfV
	 ztlT1bQ9aVqsN9a4p+p5niUdzCl/vlOArHwWGzPhFPIKdYwoqouS+9jaoZEwGY/64Y
	 Ttdfox4/xN+lkRM2XpdMWXmgGdtQpgCJ5tUOfwsb8sy1SwBmK/RUWS3YtTtYl4fM9x
	 9RYliOx0lxd39jK0Rg6lP5AHW9Pgrr4TALVCfiewnajBPkuq1VkxpBSdkcL4pVDI91
	 uJjy2XUFzls58woQqS5pymozLEHjGdaAHssHTlPCW1bgVRePo+TvJUuDca5PZbaI2X
	 pinWyKhBXlXyA==
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 04 Mar 2025 10:41:04 +0100
Subject: [PATCH v2 04/15] pidfs: add inode allocation
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250304-work-pidfs-kill_on_last_close-v2-4-44fdacfaa7b7@kernel.org>
References: <20250304-work-pidfs-kill_on_last_close-v2-0-44fdacfaa7b7@kernel.org>
In-Reply-To: <20250304-work-pidfs-kill_on_last_close-v2-0-44fdacfaa7b7@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>, 
 Lennart Poettering <lennart@poettering.net>, 
 Daan De Meyer <daan.j.demeyer@gmail.com>, Mike Yuan <me@yhndnzj.com>, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-42535
X-Developer-Signature: v=1; a=openpgp-sha256; l=2257; i=brauner@kernel.org;
 h=from:subject:message-id; bh=5UJ5+NEk52qrd6NpAEn4HqD7lO+VX1y3AJVnvn5cRms=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaQfO7VLqFSrfFFy0lU2PdcL8pdUlKK2Xpv927SBqzbVc
 8XkI8bbOkpZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACYSU8DIcOOh89zPVf33lsfp
 7zisJ86uv6d7eclVFvU5nPaGUX4KmxgZTp65ZBFvMZ9bm0vYVuif4do3XNIXLh5I/v78YU25Yic
 /CwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/pidfs.c | 52 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/fs/pidfs.c b/fs/pidfs.c
index ecc0dd886714..eaecb0a947f0 100644
--- a/fs/pidfs.c
+++ b/fs/pidfs.c
@@ -24,6 +24,27 @@
 #include "internal.h"
 #include "mount.h"
 
+static struct kmem_cache *pidfs_cachep __ro_after_init;
+
+/*
+ * Stashes information that userspace needs to access even after the
+ * process has been reaped.
+ */
+struct pidfs_exit_info {
+	__u64 cgroupid;
+	__u64 exit_code;
+};
+
+struct pidfs_inode {
+	struct pidfs_exit_info exit_info;
+	struct inode vfs_inode;
+};
+
+static inline struct pidfs_inode *pidfs_i(struct inode *inode)
+{
+	return container_of(inode, struct pidfs_inode, vfs_inode);
+}
+
 static struct rb_root pidfs_ino_tree = RB_ROOT;
 
 #if BITS_PER_LONG == 32
@@ -492,9 +513,29 @@ static void pidfs_evict_inode(struct inode *inode)
 	put_pid(pid);
 }
 
+static struct inode *pidfs_alloc_inode(struct super_block *sb)
+{
+	struct pidfs_inode *pi;
+
+	pi = alloc_inode_sb(sb, pidfs_cachep, GFP_KERNEL);
+	if (!pi)
+		return NULL;
+
+	memset(&pi->exit_info, 0, sizeof(pi->exit_info));
+
+	return &pi->vfs_inode;
+}
+
+static void pidfs_free_inode(struct inode *inode)
+{
+	kmem_cache_free(pidfs_cachep, pidfs_i(inode));
+}
+
 static const struct super_operations pidfs_sops = {
+	.alloc_inode	= pidfs_alloc_inode,
 	.drop_inode	= generic_delete_inode,
 	.evict_inode	= pidfs_evict_inode,
+	.free_inode	= pidfs_free_inode,
 	.statfs		= simple_statfs,
 };
 
@@ -704,8 +745,19 @@ struct file *pidfs_alloc_file(struct pid *pid, unsigned int flags)
 	return pidfd_file;
 }
 
+static void pidfs_inode_init_once(void *data)
+{
+	struct pidfs_inode *pi = data;
+
+	inode_init_once(&pi->vfs_inode);
+}
+
 void __init pidfs_init(void)
 {
+	pidfs_cachep = kmem_cache_create("pidfs_cache", sizeof(struct pidfs_inode), 0,
+					 (SLAB_HWCACHE_ALIGN | SLAB_RECLAIM_ACCOUNT |
+					  SLAB_ACCOUNT | SLAB_PANIC),
+					 pidfs_inode_init_once);
 	pidfs_mnt = kern_mount(&pidfs_type);
 	if (IS_ERR(pidfs_mnt))
 		panic("Failed to mount pidfs pseudo filesystem");

-- 
2.47.2


