Return-Path: <linux-fsdevel+bounces-29142-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 43E1097654C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Sep 2024 11:16:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C92801F2325A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Sep 2024 09:16:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E52E1925A2;
	Thu, 12 Sep 2024 09:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DWBYgdcR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4883618EFF3
	for <linux-fsdevel@vger.kernel.org>; Thu, 12 Sep 2024 09:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726132562; cv=none; b=S2/gh0UlzcCRnP9AFcb+QQMsF+wUvBmHOUVvUYFqRBKvrX3ItYBNJfM+bqqYUXq245T2cGYfTUtLXspEeUTd9YTImbVowBhIm16OoM2/PSvyD7ko1nqaeHFzcBodsbHxamH9hi3Vkba1sOc//jK82kluaPLoNRnsGJcvIcXXcHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726132562; c=relaxed/simple;
	bh=+Ep5hPipzQop62EQBrp5tEOzNUuFgZZhfl9XgqJVSVc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=GG+suulQ4ZD5Kwoq1rWKMedL5Wd2Qas4yL7D2+btqgqy9TbT632PGEp2gCX2/Y2GBEVn4X6Q0RNqpgUlWUQtm6DdC1kLcUJOtdjQfXdnpKQx5w/EyA63SA4g6IqcTtE5k8yggcRin/Bp+AvdSbyaJMJX3sClLKjPvN9pv1ZF1yg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DWBYgdcR; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-206e614953aso8047555ad.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 12 Sep 2024 02:16:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726132560; x=1726737360; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mdQNdz9H3PIk3crOM07e8sZz3/4JT6D4XQg51USArCM=;
        b=DWBYgdcRjw98P4bclIVVBvLkafw+Nt1HrzcENXxoz96rZsJKn7y1ARxj/G8oHuReVU
         rkRMF7dcv9yujT+uxPueIZk/IW5AD7Zx/2F1UdwJPneLshSEFH3LcJ3A4E8eMWcxqSzB
         waU++BVoJp1ADRHMdnz1PKgIoz+G7GiFuo5XAmCigY+L/3r2EIsZOA5SCnjXUHVNw5IG
         OhyjcKKI0xpdZ7/jKJN3j0cPIzvJ454Aqnltc9fXFpKdhTpyNYvZfhR9uaP9YNK6U4OJ
         pV9dUUltL+S6r2bG6liprIqjwUJZ6MXK/pIASKyFDyQFoul2F+azCUcaQYli5q2ty6Bi
         tscA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726132560; x=1726737360;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mdQNdz9H3PIk3crOM07e8sZz3/4JT6D4XQg51USArCM=;
        b=EOHYLrEnvyF4CZDkXZmmjnDfEUz3bm3VJo8rFbtyPzo8WEehmfKi/cp+Iu04VfUhJ4
         p4iZkqsQbdqle/bFZJSov9Iz7smMyrGNxgFS8A/S4gpsB6QquKxJXjKD680/rle48ONU
         YF4ZuXttyabxBTRpDh5hl7lWhhb/TDLIAzITxN+mweD242MtXsXqkicORuV1hTzkxylT
         Eas+QINIbHffJhyYl0YsoSNLv5EHFqpEhbULspzNval82pT96Z/K9ZhcTG5bjkpYaHnC
         W4SV+YMEUACw/OWzJM2gHJ+HXsItdntu3sEfyJWwmIqs1Txf3gYZ4zQtk3HqA53VR2/c
         y2HQ==
X-Gm-Message-State: AOJu0YymS0doYjjGEkMQa0dNeueJj6+/9J8NJ0a3INy2Tc5iykj+ZT5U
	ZIWy7folcO6dinG5WT1s8oCSTLpksaVMhr0UNWSeMjtObmJbTV1w
X-Google-Smtp-Source: AGHT+IHohGuEQXcp6pqk/f0q9mRrAXhmAv/ocDwEnDKbYQIlNa//W8KhWplMzEqIN7u8qkRaPshjRQ==
X-Received: by 2002:a17:902:d50c:b0:207:1708:734c with SMTP id d9443c01a7336-2076e31f979mr30591405ad.11.1726132560298;
        Thu, 12 Sep 2024 02:16:00 -0700 (PDT)
Received: from localhost.localdomain ([223.104.5.108])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2076af478cesm11029035ad.116.2024.09.12.02.15.56
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 12 Sep 2024 02:15:59 -0700 (PDT)
From: Yafang Shao <laoar.shao@gmail.com>
To: torvalds@linux-foundation.org,
	viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz
Cc: linux-fsdevel@vger.kernel.org,
	Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH RFC] vfs: Introduce a new open flag to imply dentry deletion on file removal
Date: Thu, 12 Sep 2024 17:15:48 +0800
Message-Id: <20240912091548.98132-1-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Commit 681ce8623567 ("vfs: Delete the associated dentry when deleting a
file") introduced an unconditional deletion of the associated dentry when a
file is removed. However, this led to performance regressions in specific
benchmarks, such as ilebench.sum_operations/s [0], prompting a revert in
commit 4a4be1ad3a6e ("Revert 'vfs: Delete the associated dentry when
deleting a file'").

This patch seeks to reintroduce the concept conditionally, where the
associated dentry is deleted only when the user explicitly opts for it
during file removal.

There are practical use cases for this proactive dentry reclamation.
Besides the Elasticsearch use case mentioned in commit 681ce8623567,
additional examples have surfaced in our production environment. For
instance, in video rendering services that continuously generate temporary
files, upload them to persistent storage servers, and then delete them, a
large number of negative dentries—serving no useful purpose—accumulate.
Users in such cases would benefit from proactively reclaiming these
negative dentries. This patch provides an API allowing users to actively
delete these unnecessary negative dentries.

Link: https://lore.kernel.org/linux-fsdevel/202405291318.4dfbb352-oliver.sang@intel.com [0]
Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>
---
 fs/dcache.c                      | 7 ++++++-
 fs/open.c                        | 9 ++++++++-
 include/linux/dcache.h           | 2 +-
 include/linux/sched.h            | 2 +-
 include/uapi/asm-generic/fcntl.h | 4 ++++
 5 files changed, 20 insertions(+), 4 deletions(-)

diff --git a/fs/dcache.c b/fs/dcache.c
index 3d8daaecb6d1..6d744b5e5a6c 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -1667,7 +1667,10 @@ static struct dentry *__d_alloc(struct super_block *sb, const struct qstr *name)
 	smp_store_release(&dentry->d_name.name, dname); /* ^^^ */
 
 	dentry->d_lockref.count = 1;
-	dentry->d_flags = 0;
+	if (current->flags & PF_REMOVE_DENTRY)
+		dentry->d_flags = DCACHE_FILE_REMOVE;
+	else
+		dentry->d_flags = 0;
 	spin_lock_init(&dentry->d_lock);
 	seqcount_spinlock_init(&dentry->d_seq, &dentry->d_lock);
 	dentry->d_inode = NULL;
@@ -2394,6 +2397,8 @@ void d_delete(struct dentry * dentry)
 	 * Are we the only user?
 	 */
 	if (dentry->d_lockref.count == 1) {
+		if (dentry->d_flags & DCACHE_FILE_REMOVE)
+			__d_drop(dentry);
 		dentry->d_flags &= ~DCACHE_CANT_MOUNT;
 		dentry_unlink_inode(dentry);
 	} else {
diff --git a/fs/open.c b/fs/open.c
index 22adbef7ecc2..3441a004a841 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -1428,7 +1428,14 @@ static long do_sys_openat2(int dfd, const char __user *filename,
 long do_sys_open(int dfd, const char __user *filename, int flags, umode_t mode)
 {
 	struct open_how how = build_open_how(flags, mode);
-	return do_sys_openat2(dfd, filename, &how);
+	long err;
+
+	if (flags & O_NODENTRY)
+		current->flags |= PF_REMOVE_DENTRY;
+	err = do_sys_openat2(dfd, filename, &how);
+	if (flags & O_NODENTRY)
+		current->flags &= ~PF_REMOVE_DENTRY;
+	return err;
 }
 
 
diff --git a/include/linux/dcache.h b/include/linux/dcache.h
index bff956f7b2b9..82ba79bc0072 100644
--- a/include/linux/dcache.h
+++ b/include/linux/dcache.h
@@ -215,7 +215,7 @@ struct dentry_operations {
 
 #define DCACHE_NOKEY_NAME		BIT(25) /* Encrypted name encoded without key */
 #define DCACHE_OP_REAL			BIT(26)
-
+#define DCACHE_FILE_REMOVE		BIT(27) /* remove this dentry when file is removed */
 #define DCACHE_PAR_LOOKUP		BIT(28) /* being looked up (with parent locked shared) */
 #define DCACHE_DENTRY_CURSOR		BIT(29)
 #define DCACHE_NORCU			BIT(30) /* No RCU delay for freeing */
diff --git a/include/linux/sched.h b/include/linux/sched.h
index f8d150343d42..f931a3a882e0 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1649,7 +1649,7 @@ extern struct pid *cad_pid;
 #define PF_USED_MATH		0x00002000	/* If unset the fpu must be initialized before use */
 #define PF_USER_WORKER		0x00004000	/* Kernel thread cloned from userspace thread */
 #define PF_NOFREEZE		0x00008000	/* This thread should not be frozen */
-#define PF__HOLE__00010000	0x00010000
+#define PF_REMOVE_DENTRY	0x00010000      /* Remove the dentry when the file is removed */
 #define PF_KSWAPD		0x00020000	/* I am kswapd */
 #define PF_MEMALLOC_NOFS	0x00040000	/* All allocations inherit GFP_NOFS. See memalloc_nfs_save() */
 #define PF_MEMALLOC_NOIO	0x00080000	/* All allocations inherit GFP_NOIO. See memalloc_noio_save() */
diff --git a/include/uapi/asm-generic/fcntl.h b/include/uapi/asm-generic/fcntl.h
index 80f37a0d40d7..ca5f402d5e7d 100644
--- a/include/uapi/asm-generic/fcntl.h
+++ b/include/uapi/asm-generic/fcntl.h
@@ -89,6 +89,10 @@
 #define __O_TMPFILE	020000000
 #endif
 
+#ifndef O_NODENTRY
+#define O_NODENTRY     040000000
+#endif
+
 /* a horrid kludge trying to make sure that this will fail on old kernels */
 #define O_TMPFILE (__O_TMPFILE | O_DIRECTORY)
 
-- 
2.43.5


