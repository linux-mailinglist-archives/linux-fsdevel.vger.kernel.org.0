Return-Path: <linux-fsdevel+bounces-42847-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D494A499B0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Feb 2025 13:45:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 56B067AA09A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Feb 2025 12:43:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5903226D5DC;
	Fri, 28 Feb 2025 12:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kNigxmhC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD26E26D5A2
	for <linux-fsdevel@vger.kernel.org>; Fri, 28 Feb 2025 12:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740746668; cv=none; b=job4vT5e6cIfyUIezoFVQNYKVyKlVWzhCkZU8PRwxWRkmTUWcNJ5dkqJ8ABS0mOTBI7Y8o2cD1UqewAjKfMyawkjaZe5kEY2JBDr4vkJPEVktVmhyj0IqtChHWKxMQ83H9K/iR+TmTRl/V5BDc+EVE0wQNhy7t0ZTTzUev2qOBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740746668; c=relaxed/simple;
	bh=wVAvcrXUGKpuAyKdozZYrLB3mLVYGXlkalKOpFWdUjc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QGtNeLAI778rppIwJkoHVggHwBmLTlqrkOldovG13zWf4JNdbvaQ1ap/tTCipm4u/1BjvVKCA7VT/DM+FLGBJL3l4TBLyPzVwoU47d+yottE0UOvMFVPJFkEx3ci3ll1TZLArVqM+MmZQ5L3EmWAiFBnkFqnD3hNmoWUn2V3uLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kNigxmhC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 015E3C4CEE9;
	Fri, 28 Feb 2025 12:44:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740746668;
	bh=wVAvcrXUGKpuAyKdozZYrLB3mLVYGXlkalKOpFWdUjc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=kNigxmhCmg1Fq2iQbh0zFJEWvY6QTKfedHGCf/OkhFK3cu5/9uAFjmuJR25Ih3oqG
	 3mg7etJ7AcA/LHn9amnO4PjxVJRepgMedi47dkoCxhTWOmsdq/s/8tzlijzc7KBM35
	 /NzMWWO7NXl86nr5mGVOu9aXIFwbb4QOir6RNqcKyqhDYvfkINlqDPESql9F9ezU2S
	 NRQlz72VEDKfUhYPsHbQIHWhbdSRHSF0SE2zxHNlKDJ4u+OEh9dMLfsGSwTydVt5cR
	 Jfy/7r61uLpB824hrzmFTR8vWQOyDzxJVzGYrR9tNv+0hDzBwxB2dAC0JUtq85Nx08
	 GovToqGqQkuOQ==
From: Christian Brauner <brauner@kernel.org>
Date: Fri, 28 Feb 2025 13:44:04 +0100
Subject: [PATCH RFC 04/10] pidfs: add inode allocation
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250228-work-pidfs-kill_on_last_close-v1-4-5bd7e6bb428e@kernel.org>
References: <20250228-work-pidfs-kill_on_last_close-v1-0-5bd7e6bb428e@kernel.org>
In-Reply-To: <20250228-work-pidfs-kill_on_last_close-v1-0-5bd7e6bb428e@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>, 
 Lennart Poettering <lennart@poettering.net>, 
 Daan De Meyer <daan.j.demeyer@gmail.com>, Mike Yuan <me@yhndnzj.com>, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-42535
X-Developer-Signature: v=1; a=openpgp-sha256; l=2257; i=brauner@kernel.org;
 h=from:subject:message-id; bh=wVAvcrXUGKpuAyKdozZYrLB3mLVYGXlkalKOpFWdUjc=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaQfXL/o6ZZ0o+UVe+eltTz8/6V4ldKWEmmdb9Z174528
 MTcZGGO6ihlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZjIaQWG/8V8346xMM31qPB/
 /dzW6O/S+JvnOl2bCjrX6yw0VXosXM/wV6g3oVX5Y2ei1Mzg5G0HN17kuiagxqHVfivEZOWEU7X
 OXAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/pidfs.c | 52 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/fs/pidfs.c b/fs/pidfs.c
index 61be98f7ad0b..64428697996f 100644
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


