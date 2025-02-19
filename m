Return-Path: <linux-fsdevel+bounces-42093-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 134EDA3C627
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Feb 2025 18:26:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA4DF3B8921
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Feb 2025 17:26:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48C9F2147EE;
	Wed, 19 Feb 2025 17:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="hpTWkeuh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EC2F2144BE
	for <linux-fsdevel@vger.kernel.org>; Wed, 19 Feb 2025 17:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739985967; cv=none; b=fmT4JYMlvTYkRXHduNqHVbPOet3btezNeXZ8p9TqGWQicwy4Jgj7H7hS6qlnFR7StgtoQ0BvSZcyH2eXNRNJpORCnRpXgzPhNdnI2ZSBcYqTGTKOozR2GXdZsakqwBLMY09iLmLa8JXzty22xCXrX3OCMjA06QO/wy7vKE+l9s8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739985967; c=relaxed/simple;
	bh=ncIk5lZdtXMareZLLRLznXToBtthtk/Cr53z96DFIhE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rMxefQAw52xiv//T7lqkloouH/J1b1EvMBseUf6KlFRtecL7K+y8ERr7ncalKF9CbsShL+rC8EiJthub6VFgsGaxuylQy3Gc7GWS1kIDU8DnyX1VKMlqLCVbwg6wYT/hIXBRe6vPqcbFiFT9LjO6r6uC4nI4xTRQbr3TC+5W5yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=hpTWkeuh; arc=none smtp.client-ip=209.85.166.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f47.google.com with SMTP id ca18e2360f4ac-855b3e42c5bso790139f.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 19 Feb 2025 09:26:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1739985965; x=1740590765; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B0lcG2A37eoJmBm5Sthc9LwQizBsGAmnbEYmyOv84yU=;
        b=hpTWkeuhigZzu26F/jVaGSUM4d8OQOkOogJ1TW3UtqtNsN5h9GrW3HIBGqwkA49MEV
         U6/NWIxedO1TCL5gnPYP6ah/2K+Limag27Nq09AoTf0eTkJFKMR0MggZfTUQdYkBNcNM
         sGSHoHyJQ49g2o5keRuiYFkVaMrzyRPsmogkAVse/Y53duT8V/cTnYuxQF1HPLP8Xwqg
         CCnrNPMmv0GAVCIJjooqXOB8mbIOU72twwzqifKiBIkwQNCd7aRYSfTZm8zSJ/aOTcWR
         ZowSQ29Np4r4rfIE3ytdt9DiYBbLw/hpfCTuRrEiM5MHNmxhe5Fb+VtrG8J6qNYKhCeO
         5CLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739985965; x=1740590765;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B0lcG2A37eoJmBm5Sthc9LwQizBsGAmnbEYmyOv84yU=;
        b=MS8TEJ1qR7f+7WIDtzk4daHeh4X5StVQnTf8oOGKqUIf+VnpDBVyMQCOboIAIUeQhi
         hhnE6Keq+JTtU0mAuNxj16TG2hjx3XIaJQxae5VaYBVlYA8WBLbt23400EI54ixeocxn
         4EoLH0hm0g7EbqJVK5y91nP5NtcQfXEYU0CoYjL6rOgUAkc3pKVfKRpwzaq3ouA5uqCE
         C+wywasU1lJ68jscf76fHd/STiVpizxjImihy/GwtrKdDiunca+VzLFjH6CvjbX4EgiE
         VbYmGb7Lm2YvKpvQ+0Y25FdyRWXS/FmvejY2C6PeRTLX4MH+/bGePvH6VPYxFYxwxzmr
         tudQ==
X-Gm-Message-State: AOJu0YyHpOL79XCFlIMB2Vv0Lte0XZAltp7+dAXcOFSm6t9fTzjXX4Ty
	4EHmKyLg8+9YX11um9/Chm5jfvbvfOsnB3q8eOFRpoAhX90Ooab0An6rieRV4VLp6KskgQOlDTs
	o
X-Gm-Gg: ASbGnctvq+2gasYN8kYNN9NxfGmaYZTXOVbSWSvpHQBsMyNmvhoJr8NK613hcWnQ9sL
	ERdn7wJtM9dVgT2LgFlicz9bvguViUfM5ZRJVrDqRVSrW3FvzpvHMUyRwCfFJHL9ZdvR/4XFuE/
	CiCgZmpJU0lszoBUl48EmcgOBBOPHhcjlcy5XBhVK1V+IoA3rKyUQ34LFHEMqgHM78OdR9m/bsI
	eg9etReqYuTZq2AAWZ8e1wslIwfK+pK3MrEMXMAfRbB4qDO+WM3TnTNBX2ctsO/zB2Sjkbv42Dj
	866NeDfroWO41S/x38M=
X-Google-Smtp-Source: AGHT+IGYIPWi9eQLHYtKf1drbY2zK8Yd0TsYlqHyvQz2uzX5viGmpOXBKHoGJnimabLO1Cg8mKr3uA==
X-Received: by 2002:a05:6602:1346:b0:855:b8c0:8639 with SMTP id ca18e2360f4ac-855b8c08f1dmr326646939f.14.1739985965016;
        Wed, 19 Feb 2025 09:26:05 -0800 (PST)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-8558f3ccdcesm142192839f.16.2025.02.19.09.26.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2025 09:26:04 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: io-uring@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org,
	brauner@kernel.org,
	asml.silence@gmail.com,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 1/5] eventpoll: abstract out parameter sanity checking
Date: Wed, 19 Feb 2025 10:22:24 -0700
Message-ID: <20250219172552.1565603-2-axboe@kernel.dk>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250219172552.1565603-1-axboe@kernel.dk>
References: <20250219172552.1565603-1-axboe@kernel.dk>
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
index 7c0980db77b3..565bf451df82 100644
--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -2445,6 +2445,27 @@ SYSCALL_DEFINE4(epoll_ctl, int, epfd, int, op, int, fd,
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
@@ -2453,26 +2474,16 @@ static int do_epoll_wait(int epfd, struct epoll_event __user *events,
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


