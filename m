Return-Path: <linux-fsdevel+bounces-69530-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77F8CC7E3A8
	for <lists+linux-fsdevel@lfdr.de>; Sun, 23 Nov 2025 17:34:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 301F03A4FA9
	for <lists+linux-fsdevel@lfdr.de>; Sun, 23 Nov 2025 16:34:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F6EC2D8399;
	Sun, 23 Nov 2025 16:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XLfDqphp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00F382D0C99
	for <linux-fsdevel@vger.kernel.org>; Sun, 23 Nov 2025 16:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763915632; cv=none; b=GX50/mwEfHmlLf5/Vtdnyg/bs+m1ipQYwsmd4nzo5ImcjdwvoTNjE+At5wv3D6dB8dKCPeGhl0bxFQ3gQOCJsx06lxmawsZOkX9zK4TngU70ga9MSMo0Qqhowzm6zCNPStzIfM/ODMYOSk1vA7VQBVdeRxSAXMvkLDGoZ72i2a4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763915632; c=relaxed/simple;
	bh=gBb+L/U6qqaTRKR6nKU4ENpvwe/eepmpbBKbAXESLxk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CoP1BlVTxwOkCEYGKsPwrvjgYLD0A6yh6LXlPep9YlM/O0L762Ezo4Mza2AWQUB1VXfAKS2Dl4wbvk5pr5qQefongdUGMzfiMoR5CF3r+5FoI31UTPIbWqNtbL5LM6gJq8z/u8sdT/eV/nJcDTNvE0wtoK+FRkIl926pTwdPIwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XLfDqphp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C022C113D0;
	Sun, 23 Nov 2025 16:33:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763915631;
	bh=gBb+L/U6qqaTRKR6nKU4ENpvwe/eepmpbBKbAXESLxk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=XLfDqphpC9o0iycYKq4BbScVsKlcFpgZZ/u85lqTEK0od/ozDGrPyldNi397TPWHs
	 iDnHfiTcLIibxI9LMVrJw6okRsRSLNLZ7kVUBpt4zWWFedN4SSXNIWLm0J4owjt1a9
	 E3DGQGc3UjgrSXIDv075fvU5vjyTBsHcRqThir0b8AIooFCo6MDqO/BUyWQdKsiY4d
	 ZSxXtvvAQIHal4eoP2UMic6IJNQ4O5xQNQmYwKkcnqW6UF21FvElOCGBgjbZUMUDiB
	 n9E8lV5Ul1eSJDhaKiZWZD9oRIVh8A9L5qTcX/s4rw8Q073gEZ6s2boT2rtjQ40SZG
	 gL+ngI9fqbdnQ==
From: Christian Brauner <brauner@kernel.org>
Date: Sun, 23 Nov 2025 17:33:26 +0100
Subject: [PATCH v4 08/47] fanotify: convert fanotify_init() to FD_PREPARE()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251123-work-fd-prepare-v4-8-b6efa1706cfd@kernel.org>
References: <20251123-work-fd-prepare-v4-0-b6efa1706cfd@kernel.org>
In-Reply-To: <20251123-work-fd-prepare-v4-0-b6efa1706cfd@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 linux-fsdevel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>, 
 Amir Goldstein <amir73il@gmail.com>, Jens Axboe <axboe@kernel.dk>, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3895; i=brauner@kernel.org;
 h=from:subject:message-id; bh=gBb+L/U6qqaTRKR6nKU4ENpvwe/eepmpbBKbAXESLxk=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQqm0cmhyy993Hr3ut8pRGC71+whxx4qPpNMqT6bP25g
 7tmJkte6ChlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZjIqi8Mf0W/J36+cizsdL9S
 uMhmzknMvz71rbC2mJWn82ySnf62mbcZGd6L3a99IWTk9q+CdfdB3k4zLuNOne4QvcAc2df/Or6
 lcgEA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/notify/fanotify/fanotify_user.c | 60 ++++++++++++++------------------------
 1 file changed, 22 insertions(+), 38 deletions(-)

diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
index 1dadda82cae5..be0a96ad4316 100644
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
@@ -1750,27 +1746,15 @@ SYSCALL_DEFINE2(fanotify_init, unsigned int, flags, unsigned int, event_f_flags)
 	}
 
 	if (flags & FAN_ENABLE_AUDIT) {
-		fd = -EPERM;
 		if (!capable(CAP_AUDIT_WRITE))
-			goto out_destroy_group;
-	}
-
-	fd = get_unused_fd_flags(f_flags);
-	if (fd < 0)
-		goto out_destroy_group;
-
-	file = anon_inode_getfile_fmode("[fanotify]", &fanotify_fops, group,
-					f_flags, FMODE_NONOTIFY);
-	if (IS_ERR(file)) {
-		put_unused_fd(fd);
-		fd = PTR_ERR(file);
-		goto out_destroy_group;
+			return -EPERM;
 	}
-	fd_install(fd, file);
-	return fd;
 
-out_destroy_group:
-	fsnotify_destroy_group(group);
+	fd = FD_ADD(f_flags,
+		    anon_inode_getfile_fmode("[fanotify]", &fanotify_fops,
+					     group, f_flags, FMODE_NONOTIFY));
+	if (fd >= 0)
+		retain_and_null_ptr(group);
 	return fd;
 }
 

-- 
2.47.3


