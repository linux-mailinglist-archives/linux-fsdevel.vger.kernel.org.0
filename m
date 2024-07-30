Return-Path: <linux-fsdevel+bounces-24541-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 210E69406F2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jul 2024 07:17:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9FE7228138D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jul 2024 05:17:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FB40191F89;
	Tue, 30 Jul 2024 05:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tHK5Ef5O"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D2EC191F64;
	Tue, 30 Jul 2024 05:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722316495; cv=none; b=Y1HlzPgAIG0caDlhiTp5C0eX8kp9uXkOHWSmdbjZVjuEBNVhUZ7Gagnvu7xXA7OZ2aybpCxAeFcBJMnexRbk55yxdiTiXQhbLiXqFvF7pSSWq4gIayyjjSO7uFOttrIlX+/WjM7nJ+WSVWDs9zzEuSLUyfo80QVagA3HQGY56+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722316495; c=relaxed/simple;
	bh=o05Eu98MNjRSlAoBGS56NPu/HZTz+6t3hyKmpGPGYZ0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sSp/V8pQKRb4xxRGdGiMRfMZ27XnvasSfISHIYMBAx70d2dHeHJrX8ZrbDdE64RvnB63rQSktGWAhr53RJ95QGRAr10pvNkJFlTsE0zy3ikxFWKMMdHAn4jH0Mw8/WFhXVhyqgtzRGO5hEbfiKs4WTosR92OMfRxO8/jjR1Cu4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tHK5Ef5O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67B6FC4AF0A;
	Tue, 30 Jul 2024 05:14:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722316495;
	bh=o05Eu98MNjRSlAoBGS56NPu/HZTz+6t3hyKmpGPGYZ0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tHK5Ef5OB0r43/n3UUCZrfp31KD+Cl+khu0UCwv0ww42fDKR1Vt+g9kxz9zZ7C/eZ
	 mHM5uNjgcO01uqPgQOmDQnuyaH47f9HO2MB8jQgL3/hR92DPbnTboBk844TdwVuvvn
	 dfixmuuGg77GSG83JEmrz8sZZT9UG93tq/Ug/3AoCrGTYpxBLStXjHvP8e900jF+10
	 pK2hvoEcPtSAhU+gnvEU1iGL45Bri7FMlhcGTERFWk9m2FijzioQw34aReydrhbXy2
	 cPYolNkhoM+0bcd9332KEbhf7YFs7TESxkQUFOtpfHk6pjzJhLNCvaeZybWcnTeuIO
	 07AWs1gx0XblQ==
From: viro@kernel.org
To: linux-fsdevel@vger.kernel.org
Cc: amir73il@gmail.com,
	bpf@vger.kernel.org,
	brauner@kernel.org,
	cgroups@vger.kernel.org,
	kvm@vger.kernel.org,
	netdev@vger.kernel.org,
	torvalds@linux-foundation.org
Subject: [PATCH 09/39] timerfd: switch to CLASS(fd, ...)
Date: Tue, 30 Jul 2024 01:15:55 -0400
Message-Id: <20240730051625.14349-9-viro@kernel.org>
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

Fold timerfd_fget() into both callers to have fdget() and fdput() in
the same scope.  Could be done in different ways, but this is probably
the smallest solution.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/timerfd.c | 40 ++++++++++++++--------------------------
 1 file changed, 14 insertions(+), 26 deletions(-)

diff --git a/fs/timerfd.c b/fs/timerfd.c
index 137523e0bb21..4c32244b0508 100644
--- a/fs/timerfd.c
+++ b/fs/timerfd.c
@@ -394,19 +394,6 @@ static const struct file_operations timerfd_fops = {
 	.unlocked_ioctl	= timerfd_ioctl,
 };
 
-static int timerfd_fget(int fd, struct fd *p)
-{
-	struct fd f = fdget(fd);
-	if (!fd_file(f))
-		return -EBADF;
-	if (fd_file(f)->f_op != &timerfd_fops) {
-		fdput(f);
-		return -EINVAL;
-	}
-	*p = f;
-	return 0;
-}
-
 SYSCALL_DEFINE2(timerfd_create, int, clockid, int, flags)
 {
 	int ufd;
@@ -471,7 +458,6 @@ static int do_timerfd_settime(int ufd, int flags,
 		const struct itimerspec64 *new,
 		struct itimerspec64 *old)
 {
-	struct fd f;
 	struct timerfd_ctx *ctx;
 	int ret;
 
@@ -479,15 +465,17 @@ static int do_timerfd_settime(int ufd, int flags,
 		 !itimerspec64_valid(new))
 		return -EINVAL;
 
-	ret = timerfd_fget(ufd, &f);
-	if (ret)
-		return ret;
+	CLASS(fd, f)(ufd);
+	if (fd_empty(f))
+		return -EBADF;
+
+	if (fd_file(f)->f_op != &timerfd_fops)
+		return -EINVAL;
+
 	ctx = fd_file(f)->private_data;
 
-	if (isalarm(ctx) && !capable(CAP_WAKE_ALARM)) {
-		fdput(f);
+	if (isalarm(ctx) && !capable(CAP_WAKE_ALARM))
 		return -EPERM;
-	}
 
 	timerfd_setup_cancel(ctx, flags);
 
@@ -535,17 +523,18 @@ static int do_timerfd_settime(int ufd, int flags,
 	ret = timerfd_setup(ctx, flags, new);
 
 	spin_unlock_irq(&ctx->wqh.lock);
-	fdput(f);
 	return ret;
 }
 
 static int do_timerfd_gettime(int ufd, struct itimerspec64 *t)
 {
-	struct fd f;
 	struct timerfd_ctx *ctx;
-	int ret = timerfd_fget(ufd, &f);
-	if (ret)
-		return ret;
+	CLASS(fd, f)(ufd);
+
+	if (fd_empty(f))
+		return -EBADF;
+	if (fd_file(f)->f_op != &timerfd_fops)
+		return -EINVAL;
 	ctx = fd_file(f)->private_data;
 
 	spin_lock_irq(&ctx->wqh.lock);
@@ -567,7 +556,6 @@ static int do_timerfd_gettime(int ufd, struct itimerspec64 *t)
 	t->it_value = ktime_to_timespec64(timerfd_get_remaining(ctx));
 	t->it_interval = ktime_to_timespec64(ctx->tintv);
 	spin_unlock_irq(&ctx->wqh.lock);
-	fdput(f);
 	return 0;
 }
 
-- 
2.39.2


