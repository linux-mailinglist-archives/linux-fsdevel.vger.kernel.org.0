Return-Path: <linux-fsdevel+bounces-24536-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A35A19406D8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jul 2024 07:16:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ECEB6B21B98
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jul 2024 05:16:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EF2318FC77;
	Tue, 30 Jul 2024 05:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EHtUW2e+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77EEC18EFD4;
	Tue, 30 Jul 2024 05:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722316490; cv=none; b=C69SNdvI5VhYhLh0ybJFQCvSwqS7nE1K+JfgZ6WL4l1Azqdak0iM5d7pflWKXW41xOdjDGtnm35Aepaobb3J9PWkuwULBSBoSYiHulkBx2RTn+svbWxKSUxpy00tpXeIKhDqvbciEGlQpJd/2EQ6NKLHpnT3CTgzixMm0+o93MA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722316490; c=relaxed/simple;
	bh=HF2QRrJvE+iRPEKuWKbF3LRY1GdONcgnLw1FCITPROw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=te5uwnfBC95LXpt+Od7UL9GmDHwQqX+GhHClKg5S9SB+d0K69cfEZIANTpHOQLJ2A/1J5GrthmqhjmL2PlVq5iOgCkSi6+WYeH1LpOzzfVZ1Lx3LIAuAf6MlrZULQcoDtOD6NkSan4EunlOXLqDzr16rD/xbQL8r+XKPqZlqBvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EHtUW2e+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AB34C4AF0E;
	Tue, 30 Jul 2024 05:14:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722316490;
	bh=HF2QRrJvE+iRPEKuWKbF3LRY1GdONcgnLw1FCITPROw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EHtUW2e+I2nK/ZIP0SQReiWaEFLiF2E3/K0/o4/7Foxv2mNg1Spel/IzTvESWXUYW
	 24aWrvfLyYqQKA13kX4+enmaBYJDX3P8ZRY6XpeLudQ41m1R6AYTGVVWWi1Aq8mtAh
	 7aoTInll2pXpqyhZvNUObgUfQ3vrWd56kJ1BSP3zydlWgiapS4rSliz+IkOy0QDSFi
	 dcCInVgEXFyGfM147EbQVEOLxZDCJRrV/PQLilUsHXjC6lH46Lj381ipfrKlZuruHi
	 VUXlW7bRoVL6cYPwMTUppdhXndjT7gUXLCesXhyu+pEV4kRX7YthzU3bsAsp3zf9I+
	 bSCNNy9i275pQ==
From: viro@kernel.org
To: linux-fsdevel@vger.kernel.org
Cc: amir73il@gmail.com,
	bpf@vger.kernel.org,
	brauner@kernel.org,
	cgroups@vger.kernel.org,
	kvm@vger.kernel.org,
	netdev@vger.kernel.org,
	torvalds@linux-foundation.org
Subject: [PATCH 04/39] add struct fd constructors, get rid of __to_fd()
Date: Tue, 30 Jul 2024 01:15:50 -0400
Message-Id: <20240730051625.14349-4-viro@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240730051625.14349-1-viro@kernel.org>
References: <20240730050927.GC5334@ZenIV>
 <20240730051625.14349-1-viro@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Al Viro <viro@zeniv.linux.org.uk>

	Make __fdget() et.al. return struct fd directly.
New helpers: BORROWED_FD(file) and CLONED_FD(file), for
borrowed and cloned file references resp.

	NOTE: this might need tuning; in particular, inline on
__fget_light() is there to keep the code generation same as
before - we probably want to keep it inlined in fdget() et.al.
(especially so in fdget_pos()), but that needs profiling.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/file.c            | 26 +++++++++++++-------------
 include/linux/file.h | 33 +++++++++++----------------------
 2 files changed, 24 insertions(+), 35 deletions(-)

diff --git a/fs/file.c b/fs/file.c
index a3b72aa64f11..6f5ed4daafd2 100644
--- a/fs/file.c
+++ b/fs/file.c
@@ -1128,7 +1128,7 @@ EXPORT_SYMBOL(task_lookup_next_fdget_rcu);
  * The fput_needed flag returned by fget_light should be passed to the
  * corresponding fput_light.
  */
-static unsigned long __fget_light(unsigned int fd, fmode_t mask)
+static inline struct fd __fget_light(unsigned int fd, fmode_t mask)
 {
 	struct files_struct *files = current->files;
 	struct file *file;
@@ -1145,22 +1145,22 @@ static unsigned long __fget_light(unsigned int fd, fmode_t mask)
 	if (likely(atomic_read_acquire(&files->count) == 1)) {
 		file = files_lookup_fd_raw(files, fd);
 		if (!file || unlikely(file->f_mode & mask))
-			return 0;
-		return (unsigned long)file;
+			return EMPTY_FD;
+		return BORROWED_FD(file);
 	} else {
 		file = __fget_files(files, fd, mask);
 		if (!file)
-			return 0;
-		return FDPUT_FPUT | (unsigned long)file;
+			return EMPTY_FD;
+		return CLONED_FD(file);
 	}
 }
-unsigned long __fdget(unsigned int fd)
+struct fd fdget(unsigned int fd)
 {
 	return __fget_light(fd, FMODE_PATH);
 }
-EXPORT_SYMBOL(__fdget);
+EXPORT_SYMBOL(fdget);
 
-unsigned long __fdget_raw(unsigned int fd)
+struct fd fdget_raw(unsigned int fd)
 {
 	return __fget_light(fd, 0);
 }
@@ -1181,16 +1181,16 @@ static inline bool file_needs_f_pos_lock(struct file *file)
 		(file_count(file) > 1 || file->f_op->iterate_shared);
 }
 
-unsigned long __fdget_pos(unsigned int fd)
+struct fd fdget_pos(unsigned int fd)
 {
-	unsigned long v = __fdget(fd);
-	struct file *file = (struct file *)(v & ~3);
+	struct fd f = fdget(fd);
+	struct file *file = fd_file(f);
 
 	if (file && file_needs_f_pos_lock(file)) {
-		v |= FDPUT_POS_UNLOCK;
+		f.word |= FDPUT_POS_UNLOCK;
 		mutex_lock(&file->f_pos_lock);
 	}
-	return v;
+	return f;
 }
 
 void __f_unlock_pos(struct file *f)
diff --git a/include/linux/file.h b/include/linux/file.h
index bdd6e1766839..00a42604d322 100644
--- a/include/linux/file.h
+++ b/include/linux/file.h
@@ -53,6 +53,14 @@ static inline bool fd_empty(struct fd f)
 }
 
 #define EMPTY_FD (struct fd){0}
+static inline struct fd BORROWED_FD(struct file *f)
+{
+	return (struct fd){(unsigned long)f};
+}
+static inline struct fd CLONED_FD(struct file *f)
+{
+	return (struct fd){(unsigned long)f | FDPUT_FPUT};
+}
 
 static inline void fdput(struct fd fd)
 {
@@ -63,30 +71,11 @@ static inline void fdput(struct fd fd)
 extern struct file *fget(unsigned int fd);
 extern struct file *fget_raw(unsigned int fd);
 extern struct file *fget_task(struct task_struct *task, unsigned int fd);
-extern unsigned long __fdget(unsigned int fd);
-extern unsigned long __fdget_raw(unsigned int fd);
-extern unsigned long __fdget_pos(unsigned int fd);
 extern void __f_unlock_pos(struct file *);
 
-static inline struct fd __to_fd(unsigned long v)
-{
-	return (struct fd){v};
-}
-
-static inline struct fd fdget(unsigned int fd)
-{
-	return __to_fd(__fdget(fd));
-}
-
-static inline struct fd fdget_raw(unsigned int fd)
-{
-	return __to_fd(__fdget_raw(fd));
-}
-
-static inline struct fd fdget_pos(int fd)
-{
-	return __to_fd(__fdget_pos(fd));
-}
+struct fd fdget(unsigned int fd);
+struct fd fdget_raw(unsigned int fd);
+struct fd fdget_pos(unsigned int fd);
 
 static inline void fdput_pos(struct fd f)
 {
-- 
2.39.2


