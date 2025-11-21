Return-Path: <linux-fsdevel+bounces-69406-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 42374C7B31F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Nov 2025 19:04:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 4FF55355BD8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Nov 2025 18:01:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5343350D57;
	Fri, 21 Nov 2025 18:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OOg45RRS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EFD833BBB7
	for <linux-fsdevel@vger.kernel.org>; Fri, 21 Nov 2025 18:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763748069; cv=none; b=fJ7nnC2djp/Nu6y4dndGAvO3tHLR6ffkVT8jlzvDqCs9Dm5HZ9s6rAAcN92rTpMwwLXsaA25DkiHhmAiv3Y0yVg8qJFPrt3j/vZVDppofK8oZotZ0G8FPy4SOIuZWq7QL/vYI0iaHSa8mD+2WIhTpQGcouTyTPNhYG4GVHZ7rrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763748069; c=relaxed/simple;
	bh=CH0NxefnCg7j6gx50cqDcZlZuiegOd0f7aDRtb8XleI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gQLjkLrH9bGvEtCsC5oAnFsoq3PP4FFmQG+TWRm6ek8DmLFWqTfMjP+bRJpYC2llTsIdS5mjoOXDG1WkqNGqli89SQQJ5xFjJdIEfivfd+6tN+N/eBZENHYzB96NPt95P+QfJgY6+8Li+8QAFJ+CwTCjBZmkMJWP4MF5Q/Q6Upo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OOg45RRS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02928C16AAE;
	Fri, 21 Nov 2025 18:01:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763748068;
	bh=CH0NxefnCg7j6gx50cqDcZlZuiegOd0f7aDRtb8XleI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=OOg45RRSb7QzD2BMze0Pc2srKNiRbUeotZqiwZiCl2VBZaCvulWbhLye23ByjhLle
	 Kx4H8aO9c0FGA5hbKU0j2OPqWFoAK+dlxG0P22a5HWk+jMPSkhblZq5/fktBoIfQYw
	 WT9aPPGGqbRT6awO3qVaX+gz4RYUQN2MJXWnYg/WgM4FW8Q0um0kEA3TOOPRgCAJIr
	 vy9OfZXYwzfW4XTXTmkoWao1now6DXCh4AnvqkafeUTG06/XIaU63gXCYLRhWyYSOj
	 kaVApNsdnqGdeiuW0L2MAA+G/i4RUH+c9a49M4sfoJtYc/pQ8PpE0EDI9OHusrju3a
	 8n+eF1GsESsYA==
From: Christian Brauner <brauner@kernel.org>
Date: Fri, 21 Nov 2025 19:00:47 +0100
Subject: [PATCH RFC v3 08/47] fanotify: convert fanotify_init() to
 FD_PREPARE()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251121-work-fd-prepare-v3-8-2c6444d13e0e@kernel.org>
References: <20251121-work-fd-prepare-v3-0-2c6444d13e0e@kernel.org>
In-Reply-To: <20251121-work-fd-prepare-v3-0-2c6444d13e0e@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>, 
 Jeff Layton <jlayton@kernel.org>, Amir Goldstein <amir73il@gmail.com>, 
 Jens Axboe <axboe@kernel.dk>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=4047; i=brauner@kernel.org;
 h=from:subject:message-id; bh=CH0NxefnCg7j6gx50cqDcZlZuiegOd0f7aDRtb8XleI=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQqrDg/+b6+w82HSqwFYqeEc1U6P/jqb762QMVPa7tVr
 f+0E8+MOkpZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACby4BcjwzXpTRV7jsWttRK/
 Fqdq0ryA69asu1MqZzyoYgrsPf1F+BXDP5tnk+e6tr9Z7s2RrrexM+Fcv3iFi1WGiq9CYLBVJjs
 /BwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/notify/fanotify/fanotify_user.c | 63 +++++++++++++++-----------------------
 1 file changed, 25 insertions(+), 38 deletions(-)

diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
index 1dadda82cae5..80166aded1da 100644
--- a/fs/notify/fanotify/fanotify_user.c
+++ b/fs/notify/fanotify/fanotify_user.c
@@ -1597,16 +1597,20 @@ static struct hlist_head *fanotify_alloc_merge_hash(void)
 	return hash;
 }
 
+DEFINE_CLASS(fsnotify_group,
+	      struct fsnotify_group *,
+	      if (_T) fsnotify_destroy_group(_T),
+	      fsnotify_alloc_group(ops, flags),
+	      const struct fsnotify_ops *ops, int flags)
+
 /* fanotify syscalls */
 SYSCALL_DEFINE2(fanotify_init, unsigned int, flags, unsigned int, event_f_flags)
 {
 	struct user_namespace *user_ns = current_user_ns();
-	struct fsnotify_group *group;
 	int f_flags, fd;
 	unsigned int fid_mode = flags & FANOTIFY_FID_BITS;
 	unsigned int class = flags & FANOTIFY_CLASS_BITS;
 	unsigned int internal_flags = 0;
-	struct file *file;
 
 	pr_debug("%s: flags=%x event_f_flags=%x\n",
 		 __func__, flags, event_f_flags);
@@ -1690,36 +1694,29 @@ SYSCALL_DEFINE2(fanotify_init, unsigned int, flags, unsigned int, event_f_flags)
 	if (flags & FAN_NONBLOCK)
 		f_flags |= O_NONBLOCK;
 
-	/* fsnotify_alloc_group takes a ref.  Dropped in fanotify_release */
-	group = fsnotify_alloc_group(&fanotify_fsnotify_ops,
+	CLASS(fsnotify_group, group)(&fanotify_fsnotify_ops,
 				     FSNOTIFY_GROUP_USER);
-	if (IS_ERR(group)) {
+	/* fsnotify_alloc_group takes a ref.  Dropped in fanotify_release */
+	if (IS_ERR(group))
 		return PTR_ERR(group);
-	}
 
 	/* Enforce groups limits per user in all containing user ns */
 	group->fanotify_data.ucounts = inc_ucount(user_ns, current_euid(),
 						  UCOUNT_FANOTIFY_GROUPS);
-	if (!group->fanotify_data.ucounts) {
-		fd = -EMFILE;
-		goto out_destroy_group;
-	}
+	if (!group->fanotify_data.ucounts)
+		return -EMFILE;
 
 	group->fanotify_data.flags = flags | internal_flags;
 	group->memcg = get_mem_cgroup_from_mm(current->mm);
 	group->user_ns = get_user_ns(user_ns);
 
 	group->fanotify_data.merge_hash = fanotify_alloc_merge_hash();
-	if (!group->fanotify_data.merge_hash) {
-		fd = -ENOMEM;
-		goto out_destroy_group;
-	}
+	if (!group->fanotify_data.merge_hash)
+		return -ENOMEM;
 
 	group->overflow_event = fanotify_alloc_overflow_event();
-	if (unlikely(!group->overflow_event)) {
-		fd = -ENOMEM;
-		goto out_destroy_group;
-	}
+	if (unlikely(!group->overflow_event))
+		return -ENOMEM;
 
 	if (force_o_largefile())
 		event_f_flags |= O_LARGEFILE;
@@ -1738,8 +1735,7 @@ SYSCALL_DEFINE2(fanotify_init, unsigned int, flags, unsigned int, event_f_flags)
 		group->priority = FSNOTIFY_PRIO_PRE_CONTENT;
 		break;
 	default:
-		fd = -EINVAL;
-		goto out_destroy_group;
+		return -EINVAL;
 	}
 
 	BUILD_BUG_ON(!(FANOTIFY_ADMIN_INIT_FLAGS & FAN_UNLIMITED_QUEUE));
@@ -1750,28 +1746,19 @@ SYSCALL_DEFINE2(fanotify_init, unsigned int, flags, unsigned int, event_f_flags)
 	}
 
 	if (flags & FAN_ENABLE_AUDIT) {
-		fd = -EPERM;
 		if (!capable(CAP_AUDIT_WRITE))
-			goto out_destroy_group;
+			return -EPERM;
 	}
 
-	fd = get_unused_fd_flags(f_flags);
-	if (fd < 0)
-		goto out_destroy_group;
+	FD_PREPARE(fdf, f_flags,
+		   anon_inode_getfile_fmode("[fanotify]", &fanotify_fops, group,
+					    f_flags, FMODE_NONOTIFY));
+	fd = ACQUIRE_ERR(fd_prepare, &fdf);
+	if (fd)
+		return fd;
 
-	file = anon_inode_getfile_fmode("[fanotify]", &fanotify_fops, group,
-					f_flags, FMODE_NONOTIFY);
-	if (IS_ERR(file)) {
-		put_unused_fd(fd);
-		fd = PTR_ERR(file);
-		goto out_destroy_group;
-	}
-	fd_install(fd, file);
-	return fd;
-
-out_destroy_group:
-	fsnotify_destroy_group(group);
-	return fd;
+	retain_and_null_ptr(group);
+	return fd_publish(fdf);
 }
 
 static int fanotify_test_fsid(struct dentry *dentry, unsigned int flags,

-- 
2.47.3


