Return-Path: <linux-fsdevel+bounces-41237-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C0FDA2CA53
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Feb 2025 18:37:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D57BC3AB8F8
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Feb 2025 17:37:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67F7D19F462;
	Fri,  7 Feb 2025 17:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="QIq1ROp2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58F2E19E804
	for <linux-fsdevel@vger.kernel.org>; Fri,  7 Feb 2025 17:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738949807; cv=none; b=AphVo9jRSrkLFj+DhREJbNTDSTvcaeV9Vy4/n0Yjt7cy5RWLupVAOFF5ZfdGflhahCvn1L3ORimyHiXEUqjthKuH9WUxPgsPl+vex4X768RtexsmV+HB55efjk1jYNr8n947jSjagurXsvL6FcrTBuqxYZdeLy6RUdZWdlbYclA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738949807; c=relaxed/simple;
	bh=9CqAH+/+dru0tVXL9nfonyeHwVvUOEnm71GkeIjGvRA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OB895+sagmoJ5dmVv1ekUAyJBxn70whG03VvWThDVvnlQUyTXu6P6rrb27qpuiv1fRk6hq+FUSxtbDMAE82lCw4F3cSaAmNgLqeARcvoP7Ra4qJ6YdYlgIrHYWpRXMoo3Ra1KQOYe5MadwK1xB4i9PxZ6RcVJREQCULZf/Q8giQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=QIq1ROp2; arc=none smtp.client-ip=209.85.166.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f171.google.com with SMTP id e9e14a558f8ab-3d04d655fefso19737945ab.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 07 Feb 2025 09:36:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1738949805; x=1739554605; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K9Ti6y1QSLcy76M2w8lkpqmCcvr5mUocCPUpPmYueYw=;
        b=QIq1ROp2jPQ7vXDU0UDHMqpovJ+0bFWWAVB0jqVuKplQIv6Ms/n0gspR4LpFhqvxtz
         MVMoZU38S0KEV6mdVt6yPRZ5vhZI52FrK6z/lvmvz/Jt74JDQJq5U+F0RAxaKZFqi8MY
         eW04mjaDSR1FcDaTYH1QGz/82I3ALxjn9Vnqcb8t0cwDS64tdoS8dDt9mvQBK1bNDFZg
         Ibf19/R2F3whADMzvbM+nviLqQ+cvq+FHv7J8HAnS3FFJr6HlHJIdHfE2xCCHArjye/d
         K/TuIgIRyJTCUUETgDIFwAIDdpaKi8M/3IXQ6QLDt6rDCXMMG1yF2fx/Rm0YDAw7jerK
         9p7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738949805; x=1739554605;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K9Ti6y1QSLcy76M2w8lkpqmCcvr5mUocCPUpPmYueYw=;
        b=wZ77BdHbMoK+S2QENjwX2X6XkSklcoRX9pZ4jd/HF52YU7cnhIM3zRraFlpXJAqnb8
         hzdw6YT7iopGJ/odMqwMa/iOSBYrthrDbX9DCzlv+GwkBH+ohuU9nOQKU5UGnpq0MyMZ
         hILCjmoL6+kIgJTbq486HaviGEcNog8/TX0R+0JWS1si+6VNgUGIb6K32Iswyf7o9qlC
         /jtTG4vcCplrmK0ukgTX9ntecU1BSc1oppkapHEz6tuuedzjZ7Xmf7+PXDA4BuJplcaO
         3acWMdO8b/QlGjvBautqC5WKgBkSoocRigSXQsrlE9O0AKXm3+ZXpUpqPHTWHj+T2yBH
         LfCA==
X-Gm-Message-State: AOJu0Yy2gSbbZS2ZZ2gWDSdOVzCzfPfmfJZCjeypuHwABpo2Jv1/uPDK
	uY8xqE1QEP2w9q1S8wDfCSnhhQLBCy8p8/OuzjEt1YiGEqYtClTVIKwZTbOggyuO1dFttAGz1Gq
	V
X-Gm-Gg: ASbGnctZUAPGPMr+cxvcKFVdJOhqiod0WS6rmXguuDS9e1+kz0rZMf5pQcSHxwQFegk
	J4ast0nuKYqHHaR5jkmpDS+Ij6KiscyotkZCuqlNpZYjTOvFhDUkpeTTY07DO7mZUtxPolvfPCZ
	WndABlrHhToC1Y7QsEGPiqNeb1EbWGZaOGpGggOmlpFCxyvAAoR298t029eti4iwY28ruoBYrbx
	MNZtLZVvLbq5mo0eG183eVo+EEhREddGEGk8kY3c7ooiwnkfW2qj6/CBIhMp46GtAMrL7pNw7+D
	DY7jkhFdop5IIauqtgw=
X-Google-Smtp-Source: AGHT+IFPmeblSOGaVkG5w0Ux/nI58zc+Fqb2IC9VZwr48nevrVhclD4bfbjaJIUg0GayPfKZ5zroMg==
X-Received: by 2002:a92:c263:0:b0:3cf:f88b:b51a with SMTP id e9e14a558f8ab-3d13dcfce6cmr34571995ab.2.1738949805333;
        Fri, 07 Feb 2025 09:36:45 -0800 (PST)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4ece0186151sm206241173.111.2025.02.07.09.36.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Feb 2025 09:36:44 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: io-uring@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org,
	brauner@kernel.org,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 2/7] eventpoll: abstract out parameter sanity checking
Date: Fri,  7 Feb 2025 10:32:25 -0700
Message-ID: <20250207173639.884745-3-axboe@kernel.dk>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250207173639.884745-1-axboe@kernel.dk>
References: <20250207173639.884745-1-axboe@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a helper that checks the validity of the file descriptor and
other parameters passed in to epoll_wait().

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 fs/eventpoll.c | 39 +++++++++++++++++++++++++--------------
 1 file changed, 25 insertions(+), 14 deletions(-)

diff --git a/fs/eventpoll.c b/fs/eventpoll.c
index 67d1808fda0e..14466765b85d 100644
--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -2453,6 +2453,27 @@ SYSCALL_DEFINE4(epoll_ctl, int, epfd, int, op, int, fd,
 	return do_epoll_ctl(epfd, op, fd, &epds, false);
 }
 
+static int ep_check_params(struct file *file, struct epoll_event __user *evs,
+			   int maxevents)
+{
+	/* The maximum number of event must be greater than zero */
+	if (maxevents <= 0 || maxevents > EP_MAX_EVENTS)
+		return -EINVAL;
+
+	/* Verify that the area passed by the user is writeable */
+	if (!access_ok(evs, maxevents * sizeof(struct epoll_event)))
+		return -EFAULT;
+
+	/*
+	 * We have to check that the file structure underneath the fd
+	 * the user passed to us _is_ an eventpoll file.
+	 */
+	if (!is_file_epoll(file))
+		return -EINVAL;
+
+	return 0;
+}
+
 /*
  * Implement the event wait interface for the eventpoll file. It is the kernel
  * part of the user space epoll_wait(2).
@@ -2461,26 +2482,16 @@ static int do_epoll_wait(int epfd, struct epoll_event __user *events,
 			 int maxevents, struct timespec64 *to)
 {
 	struct eventpoll *ep;
-
-	/* The maximum number of event must be greater than zero */
-	if (maxevents <= 0 || maxevents > EP_MAX_EVENTS)
-		return -EINVAL;
-
-	/* Verify that the area passed by the user is writeable */
-	if (!access_ok(events, maxevents * sizeof(struct epoll_event)))
-		return -EFAULT;
+	int ret;
 
 	/* Get the "struct file *" for the eventpoll file */
 	CLASS(fd, f)(epfd);
 	if (fd_empty(f))
 		return -EBADF;
 
-	/*
-	 * We have to check that the file structure underneath the fd
-	 * the user passed to us _is_ an eventpoll file.
-	 */
-	if (!is_file_epoll(fd_file(f)))
-		return -EINVAL;
+	ret = ep_check_params(fd_file(f), events, maxevents);
+	if (unlikely(ret))
+		return ret;
 
 	/*
 	 * At this point it is safe to assume that the "private_data" contains
-- 
2.47.2


