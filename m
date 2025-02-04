Return-Path: <linux-fsdevel+bounces-40799-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BE81A27BDC
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Feb 2025 20:48:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 78FBE1885E60
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Feb 2025 19:48:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27B60218ADD;
	Tue,  4 Feb 2025 19:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="zteLo+n2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC466158558
	for <linux-fsdevel@vger.kernel.org>; Tue,  4 Feb 2025 19:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738698501; cv=none; b=mog4PHK83X3jpFhqSt2cHNesu5m6GWwG2e8c3AAuVtvNroBLO4dkfiRIGKDc/GFrpTAIM14E9HrDsy/r5EvhfJvbD4myVvfK8m62pSP/XmAGOlse9czVkAnX8Cq6IKnbV4zbCpUelOzaXa6mHe5liWCjfsn8H0rx0fYgkPNDc98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738698501; c=relaxed/simple;
	bh=eGiwkNWqVn4n6sELTRMgfaMcoF7E583l9mfCxaa+7q8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HJDjwU7Ap5M/hNen+0vmtRSTvjQL+QMKhG83te/XehVynpw4rhLhQWjUyi6oK45gHx4iuXcxgRJxG8+gUF+M5mg8/0Z5syf7E/LNP7D7RvCcJpn7ySduUEhywCx8Ox7xtSEmh5N91exBKvx0Od6q2lCizYuSp3Z2q4abQg4YXeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=zteLo+n2; arc=none smtp.client-ip=209.85.166.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-3ce76b8d5bcso50554165ab.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 04 Feb 2025 11:48:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1738698499; x=1739303299; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=enKCXdT18Z+amYe4hyaD8mGmZru39ch23j+4VBK1x/o=;
        b=zteLo+n2FC35FIPsZDSxuqqv4X6FZ/zA5Mxf6HtHr+rS5PsAH2Tc9nPPjhUclGQyk1
         9U0y/s3dVfs8BlPJBi5rQQx7VYwzwJ6HsqnvAy8+x8TFvZ7HmFOFI3MlUD994UpkSgW6
         WJwoNdaCgSe2cBqOkIdT+a616L+9l8KbQ5r3sJswZ8j6qXO4nneZ25artKEClg5Ax4ab
         ErQ+37NTO04TCoiOwPhcnxixR30NVqD6cxRRoipQmhwDOvXu/WKcDa4EejIEubY43MKM
         j1CeKrAYpIDpTzfPoLwu8MbzocMHs+YX+6vo/5CAZwUtRA8ReDpz4OM/2kWvNTic5i8p
         huFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738698499; x=1739303299;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=enKCXdT18Z+amYe4hyaD8mGmZru39ch23j+4VBK1x/o=;
        b=Uap8Fs1DPaDyhtD6GfHRa1aKKI6sS4EW5udifzzS0mUv+8OJKLLdDUdUoW3sjhHyKx
         m0P8unYGCcyKdWrB+Uj1o5FzpExFZMLJliDiczyjCeGcxzchGws7ulZSfqzx99m74BHm
         13NZWIpCC2mYJTJCOxgcWekeUgwktEQL+mO5MnyXEHOfQURxhbFYomFZc9PLiWcxeteh
         s22Bw3na/II4+0l3C1qqznz3kyE65OLbR5S6igvXFXbz5mD1fEIq0wd4JpNucU+i7bio
         tzC6StdT6zgLT4/O31DLjolJKicQD4xN/vzKbsXNE3OTcfFU3sMbD27wIvqG12Ym7slL
         sq0g==
X-Gm-Message-State: AOJu0YzI2gnHAVB0HBtRJN232z+Pm8FedfuKYulmTQ6tZOIzJI9BYqcT
	3Vh9CyuNd23dP0Xr/rQHr0TfPmGp8pWGrEFkus6jVjEwR9VUVxG/v5+ZQ9WiUmw=
X-Gm-Gg: ASbGncsF/kUoblSDs2/nSZdo7qQU32t042nwpT28pfY2oGHi683ZI+1EEwGyrRpi0F7
	TaL5yCgqsMrFz8Sxe1WZRff/JA4l9+6j/U689vbvBYa52w8VUpHEuBwuhVR1BwDTxRr0ovj6Afq
	7I/TKvMzICQZkl1DZj1JRS9AGrduLnnW7xuI3oNMFePjiHhj2b3+YWRIiTGU9qmufTFdW6uBtMF
	C+uakJ45j/wcRah5m+y7/oqWeGvvU9oO0dGvd0oEghOc7JGq9fbPOb5vcWIHnMfFGVTHRjvD/bZ
	HCptcadGbPOhSbVV3tY=
X-Google-Smtp-Source: AGHT+IHPAymKEUBTBKdzksMiXR6c5ug44eAf4HMNGF1lBWnftCR85DIzydMrvesVJgCfTmEerFHJ2Q==
X-Received: by 2002:a05:6e02:1545:b0:3d0:405d:e94f with SMTP id e9e14a558f8ab-3d04f917886mr1410995ab.17.1738698498799;
        Tue, 04 Feb 2025 11:48:18 -0800 (PST)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4ec746c95c4sm2841466173.127.2025.02.04.11.48.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Feb 2025 11:48:17 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: io-uring@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org,
	brauner@kernel.org,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 01/11] eventpoll: abstract out main epoll reaper into a function
Date: Tue,  4 Feb 2025 12:46:35 -0700
Message-ID: <20250204194814.393112-2-axboe@kernel.dk>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250204194814.393112-1-axboe@kernel.dk>
References: <20250204194814.393112-1-axboe@kernel.dk>
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


