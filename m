Return-Path: <linux-fsdevel+bounces-33538-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 10FA79B9D41
	for <lists+linux-fsdevel@lfdr.de>; Sat,  2 Nov 2024 06:15:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B094D1F250F0
	for <lists+linux-fsdevel@lfdr.de>; Sat,  2 Nov 2024 05:15:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FE6214F9F3;
	Sat,  2 Nov 2024 05:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="JXadlhVs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C7CE1B0F39;
	Sat,  2 Nov 2024 05:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730524125; cv=none; b=NOpLz9q33wn3rv3kYzN7dK0z+w7D4ciWIj98pQ6++xtm4JBQyJFWwDB1fckiQz3v7sR630sBX3XmKwKeLTN7Wmpa8naxWNnny7xsdj/CVCRMFVx4jJ3QptFOX2txc/leodOUuNtV1q7PAnzNJ+GmuXPQ6CTxVlKXuDwfMHcInp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730524125; c=relaxed/simple;
	bh=gtp1ZSBxeGU9Vblx1bRvUwKk8xMGTtqyOTSc5GYHTGQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k1kiNWLEtuNcmk/w8cAo6q46zzr35YbhiYjnUvje7Bm4hR65T9fvlKDMbYsAuVFHjhGGDorYPdrYTLymCyvLtYmE43BPpV33FqXfjZXOG22K6jfY8CF8oG7DTpdeuiizaj5fynK3lPJ1dxslNkn4HHRmaN/nmbV3o55IXv6F0+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=JXadlhVs; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=Dtt4wbggeVpgtxxdtCeoe0mu4Teq0ZJP7xJzTP09Hdc=; b=JXadlhVs2vcFA11ht9ZnXlT1+5
	iRGJmaXUUx8TJ6LaQfzvVxPNU/zlNCPnjUZD+/JC3ocbKssz2BIqWVE3fILnBMdnJSlYB18OM+iBL
	Nu0JAanGjBHPN5AdNQGPaqmK4GspRPzkKnZ+pYagC1hedFvFnbkMUEumvLSTbF5wNrKpqecS/jaoP
	g5t3vA14ShAbWG9JyLHafNZEstjd6g4R4gI/dkC9uw/xc9P1v82iAy9G5ri7NLSL1J2IMY1zPvhae
	AokjapiUKc5JBJThL1xiEqwU7BhRM76Eemaag81RyGKEDuw/I6kP9dhAj1Y3hJa56dceuBjGdg3Xd
	yGiMWCKw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1t76N9-0000000AHm6-2BF7;
	Sat, 02 Nov 2024 05:08:27 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	cgroups@vger.kernel.org,
	kvm@vger.kernel.org,
	netdev@vger.kernel.org,
	torvalds@linux-foundation.org
Subject: [PATCH v3 03/28] timerfd: switch to CLASS(fd)
Date: Sat,  2 Nov 2024 05:08:01 +0000
Message-ID: <20241102050827.2451599-3-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241102050827.2451599-1-viro@zeniv.linux.org.uk>
References: <20241102050219.GA2450028@ZenIV>
 <20241102050827.2451599-1-viro@zeniv.linux.org.uk>
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

Reviewed-by: Christian Brauner <brauner@kernel.org>
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
2.39.5


