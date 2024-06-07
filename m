Return-Path: <linux-fsdevel+bounces-21150-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 648328FF9D1
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Jun 2024 04:00:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 183CF284B4E
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Jun 2024 02:00:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0832A14A8B;
	Fri,  7 Jun 2024 02:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="TAUBF6ft"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4CCA14292
	for <linux-fsdevel@vger.kernel.org>; Fri,  7 Jun 2024 02:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717725603; cv=none; b=fwEE23OM+KomJDLgsts/yxEmRuZBxnkNRc1N2ZVDO+N/LHL8vND/hwfZFcplbjbqye6gNUFpIcF8J1iMpGMKiLYxcbywOh2ultkeofw4MUkl95kL8teJqc6PGbtsBnP6bj6uqXbkCf8V8eXR5Ji7VMS0uj8tuar2SWLP6re2kAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717725603; c=relaxed/simple;
	bh=T/Lzr9oM1oD2dt4gHPMtbKVVi+rnIdU1rD1wndY0L7c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jiOvRuhJ4DLVALgGPxcgnV9xhOv6EemtIKOR1UBkSJ4o7KYUm+9aLQ5o2m35UTfmEITAbiteQ6lw8IKAIAAKG/rTQsnBi/h5NXpiRUse+A4spwYAtlsmlArXArh2ynxA4NaZDaaL6OqCKwC2CaMyemGnraz+Lx3R4jQSue8V9dU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=TAUBF6ft; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=dx5lWTXGMQxG5gaZSHL1sYvOkvAozOBuDhhqK0lW3ys=; b=TAUBF6ftSWMcse1hpq1DS91h/n
	/I5ftIHaDmvv6TPkZO7aZbhkG2To3CWRQrjmVYTmrBO6yWHQ9LHKLQt4KaTAO0HOeHdtnIrEGrCAN
	1jSHz8MQ5CsguDIiWfPSV43aLr0nI5sZBnoRvOUuT8HC7DnwfXRiS15EmMBs6s6OWzt30qEkSu4Vu
	e58mUwbQD1fm0iaSzSdhN+GJSqCorYuqgTy1l2fSsf2gwMbrlsZKsp4ewwNjG+0KTXloNlt+IRfcs
	QkH7u0BR393ki8Y0BOZCWsZ+pYuHUhEvbospjcNxSVhWo8usr4JOrNxLmcNXRnJqgMO9yJoAhaQ9b
	+2g0fbxQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1sFOtc-009xCd-15;
	Fri, 07 Jun 2024 02:00:00 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: brauner@kernel.org,
	torvalds@linux-foundation.org
Subject: [PATCH 15/19] timerfd: switch to CLASS(fd, ...)
Date: Fri,  7 Jun 2024 02:59:53 +0100
Message-Id: <20240607015957.2372428-15-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240607015957.2372428-1-viro@zeniv.linux.org.uk>
References: <20240607015656.GX1629371@ZenIV>
 <20240607015957.2372428-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

Fold timerfd_fget() into both callers to have fdget() and fdput() in
the same scope.  Could be done in different ways, but this is probably
the smallest solution.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/timerfd.c | 38 ++++++++++++--------------------------
 1 file changed, 12 insertions(+), 26 deletions(-)

diff --git a/fs/timerfd.c b/fs/timerfd.c
index 137523e0bb21..a72f83ed2e69 100644
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
 
@@ -479,15 +465,15 @@ static int do_timerfd_settime(int ufd, int flags,
 		 !itimerspec64_valid(new))
 		return -EINVAL;
 
-	ret = timerfd_fget(ufd, &f);
-	if (ret)
-		return ret;
+	CLASS(fd, f)(ufd);
+	if (fd_empty(f))
+		return -EBADF;
+	if (fd_file(f)->f_op != &timerfd_fops)
+		return -EINVAL;
 	ctx = fd_file(f)->private_data;
 
-	if (isalarm(ctx) && !capable(CAP_WAKE_ALARM)) {
-		fdput(f);
+	if (isalarm(ctx) && !capable(CAP_WAKE_ALARM))
 		return -EPERM;
-	}
 
 	timerfd_setup_cancel(ctx, flags);
 
@@ -535,17 +521,18 @@ static int do_timerfd_settime(int ufd, int flags,
 	ret = timerfd_setup(ctx, flags, new);
 
 	spin_unlock_irq(&ctx->wqh.lock);
-	fdput(f);
 	return ret;
 }
 
 static int do_timerfd_gettime(int ufd, struct itimerspec64 *t)
 {
-	struct fd f;
+	CLASS(fd, f)(ufd);
 	struct timerfd_ctx *ctx;
-	int ret = timerfd_fget(ufd, &f);
-	if (ret)
-		return ret;
+
+	if (fd_empty(f))
+		return -EBADF;
+	if (fd_file(f)->f_op != &timerfd_fops)
+		return -EINVAL;
 	ctx = fd_file(f)->private_data;
 
 	spin_lock_irq(&ctx->wqh.lock);
@@ -567,7 +554,6 @@ static int do_timerfd_gettime(int ufd, struct itimerspec64 *t)
 	t->it_value = ktime_to_timespec64(timerfd_get_remaining(ctx));
 	t->it_interval = ktime_to_timespec64(ctx->tintv);
 	spin_unlock_irq(&ctx->wqh.lock);
-	fdput(f);
 	return 0;
 }
 
-- 
2.39.2


