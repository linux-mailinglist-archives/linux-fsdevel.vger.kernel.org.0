Return-Path: <linux-fsdevel+bounces-40627-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EFA8A2600B
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Feb 2025 17:31:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF238166DDD
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Feb 2025 16:31:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0B4D20B1FA;
	Mon,  3 Feb 2025 16:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="rS1BziiW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD2442B9BB
	for <linux-fsdevel@vger.kernel.org>; Mon,  3 Feb 2025 16:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738600284; cv=none; b=qV3dFmIQNGTmp9sTHs8SiPDMRLaNoJlK1AeM9smOVrharl9tG/yNgV09+t1nsYdkEF6pNoxYrqP765cknLp7v9k2gGqEhg1DjVWOr5YtWunce04novte0tNZFyiZs0tcGnI081vQOx7t0sVPFyxia8vuq1LILTVE4+s2cpeGJYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738600284; c=relaxed/simple;
	bh=eGiwkNWqVn4n6sELTRMgfaMcoF7E583l9mfCxaa+7q8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GecuO9q/8445BPTzCgYffaFFWW2x2KHsEqa/+BSSJj7Dlb2TPZb0UyR3d9xEw2yKHnveqmys3MCnEobgyTPAI9WHT13k1Ea/z4cOtRFr9ldXqYjikdAwVj8c/1eACsT9dpLIJP7YOucUjfZQa4LC3CPs5MZXDYV1tKvjH4ZiaPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=rS1BziiW; arc=none smtp.client-ip=209.85.166.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f51.google.com with SMTP id ca18e2360f4ac-844e7bc6d84so137847839f.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 03 Feb 2025 08:31:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1738600282; x=1739205082; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=enKCXdT18Z+amYe4hyaD8mGmZru39ch23j+4VBK1x/o=;
        b=rS1BziiWAgGhu11kKhVQo47FFq/EvFRuqK7n86uUQ7zwxw/xn8mz5e8qZscCkE7VF1
         SSLAwjIvlWje7nVPnfCv1WYxdQuFbfO4jaoyIg9v9Lz2J6aLBvQEDaSMXuIYVoOsIqoa
         z5zKTKzl0SsBM1otLXwaOiaOZLQ23wnIGoQWsauuFZROQyXKP0zDLto3Vw28ZkZgcKRd
         x8z18umkodR4EIZK1R5ptxGxBPTctNDXEpPBVQGU5QGY7xdmWSS2fPedlNAn2WRPAt07
         lYtf2yx1K02kEat8yCQDi3b8fxQ/oNLGoiUYScFSgwko3kmsdO+8Ri0QDNsFh6/jUxLm
         Gwgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738600282; x=1739205082;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=enKCXdT18Z+amYe4hyaD8mGmZru39ch23j+4VBK1x/o=;
        b=WJDuA3uNs9TKndvikLcCJAHbLetMMqjb4HJHhl7AHp48NRSr015jDpcWoaowDy78uR
         iiVMgcSALerEqc5zh789v+IHK1sz+tmHvCFxnb3+1HTymI1q2vMVF8mX6gDOPQRVc5BE
         VSSOVKr79+ihtKjNzVPOPXjgihX5vqLa2Q4YAsMyQwB3ddTlWJ4diGfx/LEGX8DI9+Eg
         qZlVhDb9wA7hqYZoHLQ83RBrJaJ4I+NXLSMtGu27BnR+YUCnTsASrBJcKipVh/i95iBJ
         RaO0tFlrxop0iKJpyXNs2+f5q3OgMLIEOFGXI6rDOrYz7UjjK5Vxe8ybxnEvHUDofb2J
         175A==
X-Gm-Message-State: AOJu0YyJFiB6uj2/LB9d78TU+zjJUSLcsF+ry/o8A00n8ELXB1bPDI5m
	AveL2nQnnqlFFV+9mWrcSo7uZ/KD2/KCgGEkMr9VX8umB1j5X83N0kVJVxS89z8=
X-Gm-Gg: ASbGncuIxfaHcA7k0TyYXr62VdahuHSJByc/nsH1BA5Rwt90MpQ1FXuRaLXgu8kLFSh
	ZR21ldr2QxUmEqfx3yEx7BN88nKQTs9OvSlV0P9BERgaNnECI6TYAhyx2k/xFEb/FJZ5UCQr5L3
	ZlTZ0IBPJydh5w/Fv5NbOg/oxjJUzwr162u9jEEM8Fra6Jw+vzDG2RsUcsvXtMbqELB3VgxeZTU
	zXC/yYjFl65alFuPD5Wmkz1b+E2Kg4L/PSN1SNSpU5W7libtha97Yby9kM5vRWBseyotIZcA54U
	srsKeKeXVobnWM988fs=
X-Google-Smtp-Source: AGHT+IE+/Ly9uGMX1dXoTTNsBcIWamNYpswbdfikyDTw/f71r7yEWo4FphmoVn9Iqomb/zqiMGDXpQ==
X-Received: by 2002:a05:6602:4189:b0:84c:d479:e5a6 with SMTP id ca18e2360f4ac-8549fa3ebcdmr1542939539f.1.1738600281594;
        Mon, 03 Feb 2025 08:31:21 -0800 (PST)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-854a16123c6sm243748139f.24.2025.02.03.08.31.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Feb 2025 08:31:20 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: io-uring@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org,
	brauner@kernel.org,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 1/9] eventpoll: abstract out main epoll reaper into a function
Date: Mon,  3 Feb 2025 09:23:39 -0700
Message-ID: <20250203163114.124077-2-axboe@kernel.dk>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250203163114.124077-1-axboe@kernel.dk>
References: <20250203163114.124077-1-axboe@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add epoll_wait(), which takes a struct file and the number of events
etc to reap. This can then be called by do_epoll_wait(), and used
by io_uring as well.

No intended functional changes in this patch.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 fs/eventpoll.c            | 31 ++++++++++++++++++-------------
 include/linux/eventpoll.h |  4 ++++
 2 files changed, 22 insertions(+), 13 deletions(-)

diff --git a/fs/eventpoll.c b/fs/eventpoll.c
index 7c0980db77b3..73b639caed3d 100644
--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -2445,12 +2445,8 @@ SYSCALL_DEFINE4(epoll_ctl, int, epfd, int, op, int, fd,
 	return do_epoll_ctl(epfd, op, fd, &epds, false);
 }
 
-/*
- * Implement the event wait interface for the eventpoll file. It is the kernel
- * part of the user space epoll_wait(2).
- */
-static int do_epoll_wait(int epfd, struct epoll_event __user *events,
-			 int maxevents, struct timespec64 *to)
+int epoll_wait(struct file *file, struct epoll_event __user *events,
+	       int maxevents, struct timespec64 *to)
 {
 	struct eventpoll *ep;
 
@@ -2462,28 +2458,37 @@ static int do_epoll_wait(int epfd, struct epoll_event __user *events,
 	if (!access_ok(events, maxevents * sizeof(struct epoll_event)))
 		return -EFAULT;
 
-	/* Get the "struct file *" for the eventpoll file */
-	CLASS(fd, f)(epfd);
-	if (fd_empty(f))
-		return -EBADF;
-
 	/*
 	 * We have to check that the file structure underneath the fd
 	 * the user passed to us _is_ an eventpoll file.
 	 */
-	if (!is_file_epoll(fd_file(f)))
+	if (!is_file_epoll(file))
 		return -EINVAL;
 
 	/*
 	 * At this point it is safe to assume that the "private_data" contains
 	 * our own data structure.
 	 */
-	ep = fd_file(f)->private_data;
+	ep = file->private_data;
 
 	/* Time to fish for events ... */
 	return ep_poll(ep, events, maxevents, to);
 }
 
+/*
+ * Implement the event wait interface for the eventpoll file. It is the kernel
+ * part of the user space epoll_wait(2).
+ */
+static int do_epoll_wait(int epfd, struct epoll_event __user *events,
+			 int maxevents, struct timespec64 *to)
+{
+	/* Get the "struct file *" for the eventpoll file */
+	CLASS(fd, f)(epfd);
+	if (!fd_empty(f))
+		return epoll_wait(fd_file(f), events, maxevents, to);
+	return -EBADF;
+}
+
 SYSCALL_DEFINE4(epoll_wait, int, epfd, struct epoll_event __user *, events,
 		int, maxevents, int, timeout)
 {
diff --git a/include/linux/eventpoll.h b/include/linux/eventpoll.h
index 0c0d00fcd131..f37fea931c44 100644
--- a/include/linux/eventpoll.h
+++ b/include/linux/eventpoll.h
@@ -25,6 +25,10 @@ struct file *get_epoll_tfile_raw_ptr(struct file *file, int tfd, unsigned long t
 /* Used to release the epoll bits inside the "struct file" */
 void eventpoll_release_file(struct file *file);
 
+/* Use to reap events */
+int epoll_wait(struct file *file, struct epoll_event __user *events,
+	       int maxevents, struct timespec64 *to);
+
 /*
  * This is called from inside fs/file_table.c:__fput() to unlink files
  * from the eventpoll interface. We need to have this facility to cleanup
-- 
2.47.2


