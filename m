Return-Path: <linux-fsdevel+bounces-43224-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C2C9DA4FB42
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Mar 2025 11:08:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3AFF716B462
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Mar 2025 10:08:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EACF205ABE;
	Wed,  5 Mar 2025 10:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NbfxsPcT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC5EE1C8612
	for <linux-fsdevel@vger.kernel.org>; Wed,  5 Mar 2025 10:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741169315; cv=none; b=Q/JAOyTgixI2CS/6IPmeJ3vhCPnJjjWuQxaCjYLIIpAUDO5Aq6V3cAXwkoYwNhaVCtYoK2z9+j3oSpyxfQiecsk6PouDI9Kb2t5G4u4HRl+2U14Oob+boe5ufMpCSdvdlMnxLJVQljX/tO8h3xCpPvqWczRVUUFWgxkqWwZyvj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741169315; c=relaxed/simple;
	bh=Qfnm8KKT/aeuFxG41rmiJmNnuIF6+nm0BOWV0KvIDHE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Hpir7tClRgVbTxZScd7k3lmupwQhoDzFPrW1P2T3gaG0rjS6f7ydfo7IqKF1Njbja7UCtXhakjWk/qkSmcFFned6cGgrypiKdiksIBhfHZvtZg6PAo6eUcJL6HZK4QfaSthC6HN+/+dl/FAKlPN5q2PJ5vnbIOR3vyR8F9RjYdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NbfxsPcT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78087C4CEEB;
	Wed,  5 Mar 2025 10:08:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741169315;
	bh=Qfnm8KKT/aeuFxG41rmiJmNnuIF6+nm0BOWV0KvIDHE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=NbfxsPcTgTUTrdpZ8cBPWDmixmNYMNdlpIiWGpsPLBbi0rByu2YGGFKX+Qt3w3Mve
	 Y8HpHFLXafweLDalr2FpOrse5uS57dm3PEDQLqFsrOCnSKL9VMBSF4rRIsEsSmxFNy
	 yj/T45jmeeBgwuaUpTX2Io2GzUSLjBNAKXCgbhj5BUqV4vBbsQdLk8FuHEufuM31xW
	 MR3kiypP+yE5BIBjldodzd17BWmvVqbrWD+gOAZtq/1GhuQeqp7nxqeCHq9uoIPnWP
	 Frdats2F717U1i5abpg3KHM776QC6I2HEUSTB/ypmdT8LOAdcm1kmQjWE54hSG8Khm
	 C3y7qB/YKa5rw==
From: Christian Brauner <brauner@kernel.org>
Date: Wed, 05 Mar 2025 11:08:14 +0100
Subject: [PATCH v3 04/16] pidfs: use private inode slab cache
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250305-work-pidfs-kill_on_last_close-v3-4-c8c3d8361705@kernel.org>
References: <20250305-work-pidfs-kill_on_last_close-v3-0-c8c3d8361705@kernel.org>
In-Reply-To: <20250305-work-pidfs-kill_on_last_close-v3-0-c8c3d8361705@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>, 
 Lennart Poettering <lennart@poettering.net>, 
 Daan De Meyer <daan.j.demeyer@gmail.com>, Mike Yuan <me@yhndnzj.com>, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-42535
X-Developer-Signature: v=1; a=openpgp-sha256; l=2747; i=brauner@kernel.org;
 h=from:subject:message-id; bh=Qfnm8KKT/aeuFxG41rmiJmNnuIF6+nm0BOWV0KvIDHE=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaSfUJrB/KB9o8p7keN14tdSbj4/mCgbmz0z4vaHP02hf
 +a9rdnH2VHKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAjARbQ+G/6VqASJXd0TFBmtz
 /r34PWhz5fP/PGwZDPrLZ/xuyT05sZzhn41L8opnHxmU7j2ayPbhKcOsE0+cZSs81D50XUz9sXa
 FByMA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Introduce a private inode slab cache for pidfs. In follow-up patches
pidfs will gain the ability to provide exit information to userspace
after the task has been reaped. This means storing exit information even
after the task has already been released and struct pid's task linkage
is gone. Store that information alongside the inode.

Link: https://lore.kernel.org/r/20250304-work-pidfs-kill_on_last_close-v2-4-44fdacfaa7b7@kernel.org
Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/pidfs.c | 52 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/fs/pidfs.c b/fs/pidfs.c
index ecc0dd886714..282511a36fd9 100644
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
+	__s32 exit_code;
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


