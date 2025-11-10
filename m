Return-Path: <linux-fsdevel+bounces-67649-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 455F9C45AF0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Nov 2025 10:40:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3D6604E64FD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Nov 2025 09:39:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB4593002CA;
	Mon, 10 Nov 2025 09:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MuMR35n5";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="7t2hDKDS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6DDC2E8E0E;
	Mon, 10 Nov 2025 09:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762767538; cv=none; b=meyd20iYom8ycAuevYHrcvaqxNlZ6VfSAALmL0Dyg1PL83EPMLlGA1FRXZzAFMfonCKCuz00PH6SvATBNXzBDLLq1hwPWtO/8ZtzceSA98jJRxjDZk+7Guaiyc+0cqQIkBG88BovNiPEuu/HAA0cS+a9Q8tUfRWlEtaTBYspxv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762767538; c=relaxed/simple;
	bh=kl5ayptKclPUrvSe72Vk4kjzbqNq2tDNre9EvwmuE5w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fXJyPhJpPPyLjXt8WtwNz3AuK+nUPZV/p81ZV/onAsyFTAEv5K6peCk2/t7Htjw6MPLqJ9WZsKEkYr9yGNMC7gMMBmUlhlFrf2MAaLAcWRRxM8aefHaHgWPzlKGlVgwDRI3QT2unqEY40i9nSJKUkbetf70b5Xu7ujGxXDExrVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=MuMR35n5; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=7t2hDKDS; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1762767534;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kt1M71tU+RfzI82BS83X5FU/6HsnGZ8EXP1vxqlq3Dg=;
	b=MuMR35n5lItmJvoQ/0DUXgk5VCGp8CKhLMyjkZ+o4FIicOD52SW+u8aACfORn4pC2t9Ubq
	Z7FnhZ/VFC5rrpfzhfOZPCecrAS7ZSNk1Ziyf/NfkXukl+7xikkUOSiiER3IlMNOKgld4i
	/+87FRVvzX9TeSegSY6MJLcUs59+rGP86IkUo87WywgXXsUisNRNL6NsOAX8rtBpwoo6cC
	XEyPrbsUtVJn6CaDpPG6ypwawG7uT8Ff8WK+PcMXbcTH0E6o+1ar9BLioFpJ7mvOsh6GnJ
	ts0T5oCshyFt2CuLdv8Trc71BAPxM/+R3Gy20RGKUzsBJw3ytHsRdq5ZGokRlA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1762767534;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kt1M71tU+RfzI82BS83X5FU/6HsnGZ8EXP1vxqlq3Dg=;
	b=7t2hDKDSD2stFRNn5ws6QU4ylWQGlzhr6GUpbIhicO3nwBNJE6I6OEojnKq7ciKomUiGsn
	F3/zVcBb4oU/siCQ==
Date: Mon, 10 Nov 2025 10:38:51 +0100
Subject: [PATCH 1/3] select: store end_time as timespec64 in restart block
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251110-restart-block-expiration-v1-1-5d39cc93df4f@linutronix.de>
References: <20251110-restart-block-expiration-v1-0-5d39cc93df4f@linutronix.de>
In-Reply-To: <20251110-restart-block-expiration-v1-0-5d39cc93df4f@linutronix.de>
To: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
 Peter Zijlstra <peterz@infradead.org>, Darren Hart <dvhart@infradead.org>, 
 Davidlohr Bueso <dave@stgolabs.net>, 
 =?utf-8?q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>, 
 Anna-Maria Behnsen <anna-maria@linutronix.de>, 
 Frederic Weisbecker <frederic@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1762767533; l=2328;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=kl5ayptKclPUrvSe72Vk4kjzbqNq2tDNre9EvwmuE5w=;
 b=U2gn1iYc2ZWI4UkQ30xUoSnxrrVzQfy3/Uo0qSY9PhqGZ8Gz4SI3nOweEe6wJ4Qv0q7yVL3Pi
 TirkiAU+G8IBb/mG5H8Fgq3rMR7KofYZO2jy1oUeIxub563ZHS8zRkQ
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

Storing the end time seconds as 'unsigned long' can lead to truncation
on 32-bit architectures if assigned from the 64-bit timespec64::tv_sec.
As the select() core uses timespec64 consistently, also use that in the
restart block.

This also allows the simplification of the accessors.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 fs/select.c                   | 12 ++++--------
 include/linux/restart_block.h |  4 ++--
 2 files changed, 6 insertions(+), 10 deletions(-)

diff --git a/fs/select.c b/fs/select.c
index 082cf60c7e2357dfd419c2128e38da95e3ef2ef3..5c3ce16bd251df9dfeaa562620483a257d7fd5d8 100644
--- a/fs/select.c
+++ b/fs/select.c
@@ -1042,14 +1042,11 @@ static long do_restart_poll(struct restart_block *restart_block)
 {
 	struct pollfd __user *ufds = restart_block->poll.ufds;
 	int nfds = restart_block->poll.nfds;
-	struct timespec64 *to = NULL, end_time;
+	struct timespec64 *to = NULL;
 	int ret;
 
-	if (restart_block->poll.has_timeout) {
-		end_time.tv_sec = restart_block->poll.tv_sec;
-		end_time.tv_nsec = restart_block->poll.tv_nsec;
-		to = &end_time;
-	}
+	if (restart_block->poll.has_timeout)
+		to = &restart_block->poll.end_time;
 
 	ret = do_sys_poll(ufds, nfds, to);
 
@@ -1081,8 +1078,7 @@ SYSCALL_DEFINE3(poll, struct pollfd __user *, ufds, unsigned int, nfds,
 		restart_block->poll.nfds = nfds;
 
 		if (timeout_msecs >= 0) {
-			restart_block->poll.tv_sec = end_time.tv_sec;
-			restart_block->poll.tv_nsec = end_time.tv_nsec;
+			restart_block->poll.end_time = end_time;
 			restart_block->poll.has_timeout = 1;
 		} else
 			restart_block->poll.has_timeout = 0;
diff --git a/include/linux/restart_block.h b/include/linux/restart_block.h
index 7e50bbc94e476c599eb1185e02b6e87854fc3eb8..0798a4ae67c6c75749c38c4673ab8ea012261319 100644
--- a/include/linux/restart_block.h
+++ b/include/linux/restart_block.h
@@ -6,6 +6,7 @@
 #define __LINUX_RESTART_BLOCK_H
 
 #include <linux/compiler.h>
+#include <linux/time64.h>
 #include <linux/types.h>
 
 struct __kernel_timespec;
@@ -50,8 +51,7 @@ struct restart_block {
 			struct pollfd __user *ufds;
 			int nfds;
 			int has_timeout;
-			unsigned long tv_sec;
-			unsigned long tv_nsec;
+			struct timespec64 end_time;
 		} poll;
 	};
 };

-- 
2.51.0


