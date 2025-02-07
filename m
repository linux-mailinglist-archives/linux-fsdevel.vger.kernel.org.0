Return-Path: <linux-fsdevel+bounces-41239-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A3E7A2CA57
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Feb 2025 18:37:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A8BB3AC285
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Feb 2025 17:37:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35D7F1A239F;
	Fri,  7 Feb 2025 17:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="0bZ8m5V9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F16DF19DF75
	for <linux-fsdevel@vger.kernel.org>; Fri,  7 Feb 2025 17:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738949810; cv=none; b=HGOLrPVPPz/sfEC3sYDRcoPOynzc4p+JC8j1B29REfHnvSd3MRBCWq2CWAzEXY9Tqzz8oK4AFYfbCYfEUm2WC+Rtv8e4XKcYkPP0Q+LjlKP7jNGBN4Q3huq6Am9I04VD1O+Czx6jVcZPOZNw3Kj8QaB7aIgst/yKksxpKCUJxvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738949810; c=relaxed/simple;
	bh=dyJDv1DYIwNakHlB93t6AK28i1AjFOufLyKR9k8IhYg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tAMLrOo6CFjBXn9WCBdXs0oRsOJe8k8NtcuxHZEPKHc3bkAA0A8jpoHO/dnRFtB+xj9tWAoW9gG1fft4KUxGffMvNwKudY0BmXjMx9TGJ9j/LSF5Dy/GvW8oX+j1RyE6+a4Jd/zuaFqEu5rv3/izdayLE3mBg3ctcCLzl/Q0gN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=0bZ8m5V9; arc=none smtp.client-ip=209.85.166.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f47.google.com with SMTP id ca18e2360f4ac-844ee43460aso155547239f.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 07 Feb 2025 09:36:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1738949808; x=1739554608; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dZUJaBdxvX3TYFAnJ+wUNjux1qeKKL9lzbYxbO/HoGo=;
        b=0bZ8m5V9pINo8eK4nUQtE/1BpjYxi/EAVnkRs3RKvO/uSmPPqVwkuGC42MhL1TIngd
         HPiDHIsDUJXKYyvtC3TL9VB36HhzQl4VvL9jeFUgzmhNIIKPcZQ1VjUi46UMcOlO/IAt
         JA3QlHzh+EVixegrBogkF+Wip5bCMX1eLo76qOrLxIzdt8WYpXnRfI7tVV3/ciMpoB8r
         52Yb8chfHyTxkwJfPIVngmRofW/EzRJXrjVb6i13HRJBUSSJbSQ22c8LwNlzU8a/yhE9
         EHPbPqYHHyMEalNU+Ip/kPiDuovn+duNjPJ/15D1L+JLwvJ6YMbhkE1AwsR5Tb4s2H7p
         ZjOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738949808; x=1739554608;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dZUJaBdxvX3TYFAnJ+wUNjux1qeKKL9lzbYxbO/HoGo=;
        b=ndo6EpihACXWz2Ktl9wrZuzl+v52zoIXq/SFKQo8oFh44Tjxsuld1zW4dBa8Dh5GDz
         b2kQuk6lWu2Kf/4YOL4I77satMy1AMT2GcEULN1kpRQHt8Mt0jTbftZoqhYlj3D9y2fc
         rsO4f0YZQ/tDpFNTkwrQMp9jMOnHtJJkbX6JWtneUAvCaOWLsej6fECQxLCDhiyLFJuW
         PYsdvnN7AhCr4YeUHOPwtqCYfyhpgioAydo+Eb8dPxvtE6jmE4UsczAj2ggdprkEIIRc
         9SMFzCMmqcpYtvtMHa1RBloXsDgEJPnTKsG35zb3pB/dgpKm5z9id61F4c/KXFECaEeb
         MZnA==
X-Gm-Message-State: AOJu0YxKjgwu4PcnqddljjjU8dV8lFwXg3P+fTChQPVC1ZCpg3VHbZ7S
	KLmSOwwsHCzHW+tfUpVpKRG8EI5YVUVR/zqujX046zqJ6+KegnIXSvHjrucmWlY=
X-Gm-Gg: ASbGncvMSaTBpw4pz7LAlIwCFi/gxTNEFYSkveWxtb6kGH12Q677D65LnwdnNrXCOWH
	S9GaTQxv6bOAA27OnZK1mqrT5iShnGDquqaS84PGOwIvzxqC+ieN0lmpnT+YVHC4n3puNOa1ZQK
	kdPqILlpU6YXOTkRfJjq6uQnkk0AlYhTZW+ZGH1I15YcGdwfpeSmHXXtr5BQufynLMsWS+ujiSu
	4on3uuXk/2dKURkBLqlGpSxgxuCAC6sXor96hUAIGlQXfHW957VwkfOqf7aCYq8/sr5CgDmy/XQ
	32xutQzVGKO0I0F6Nfc=
X-Google-Smtp-Source: AGHT+IHESkWaXYphqvlRLTxkdoYMY8NNXw/bbXA1U4bM78mkr25yds7t2Z+or5Lwm4/xJAfCW9GsRw==
X-Received: by 2002:a05:6e02:1a2c:b0:3cf:c773:6992 with SMTP id e9e14a558f8ab-3d13dd66668mr34070995ab.12.1738949808113;
        Fri, 07 Feb 2025 09:36:48 -0800 (PST)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4ece0186151sm206241173.111.2025.02.07.09.36.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Feb 2025 09:36:47 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: io-uring@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org,
	brauner@kernel.org,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 4/7] eventpoll: add helper to remove wait entry from wait queue head
Date: Fri,  7 Feb 2025 10:32:27 -0700
Message-ID: <20250207173639.884745-5-axboe@kernel.dk>
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

__epoll_wait_remove() is the core helper, it kills a given
wait_queue_entry from the eventpoll wait_queue_head. Use it internally,
and provide an overall helper, epoll_wait_remove(), which takes a struct
file and provides the same functionality.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 fs/eventpoll.c            | 58 +++++++++++++++++++++++++--------------
 include/linux/eventpoll.h |  3 ++
 2 files changed, 40 insertions(+), 21 deletions(-)

diff --git a/fs/eventpoll.c b/fs/eventpoll.c
index d3ac466ad415..b96cc9193517 100644
--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -2023,6 +2023,42 @@ static int ep_poll_queue(struct eventpoll *ep,
 	return -EIOCBQUEUED;
 }
 
+static int __epoll_wait_remove(struct eventpoll *ep,
+			       struct wait_queue_entry *wait, int timed_out)
+{
+	int eavail;
+
+	/*
+	 * We were woken up, thus go and try to harvest some events. If timed
+	 * out and still on the wait queue, recheck eavail carefully under
+	 * lock, below.
+	 */
+	eavail = 1;
+
+	if (!list_empty_careful(&wait->entry)) {
+		write_lock_irq(&ep->lock);
+		/*
+		 * If the thread timed out and is not on the wait queue, it
+		 * means that the thread was woken up after its timeout expired
+		 * before it could reacquire the lock. Thus, when wait.entry is
+		 * empty, it needs to harvest events.
+		 */
+		if (timed_out)
+			eavail = list_empty(&wait->entry);
+		__remove_wait_queue(&ep->wq, wait);
+		write_unlock_irq(&ep->lock);
+	}
+
+	return eavail;
+}
+
+int epoll_wait_remove(struct file *file, struct wait_queue_entry *wait)
+{
+	if (is_file_epoll(file))
+		return __epoll_wait_remove(file->private_data, wait, false);
+	return -EINVAL;
+}
+
 /**
  * ep_poll - Retrieves ready events, and delivers them to the caller-supplied
  *           event buffer.
@@ -2135,27 +2171,7 @@ static int ep_poll(struct eventpoll *ep, struct epoll_event __user *events,
 							      HRTIMER_MODE_ABS);
 		__set_current_state(TASK_RUNNING);
 
-		/*
-		 * We were woken up, thus go and try to harvest some events.
-		 * If timed out and still on the wait queue, recheck eavail
-		 * carefully under lock, below.
-		 */
-		eavail = 1;
-
-		if (!list_empty_careful(&wait.entry)) {
-			write_lock_irq(&ep->lock);
-			/*
-			 * If the thread timed out and is not on the wait queue,
-			 * it means that the thread was woken up after its
-			 * timeout expired before it could reacquire the lock.
-			 * Thus, when wait.entry is empty, it needs to harvest
-			 * events.
-			 */
-			if (timed_out)
-				eavail = list_empty(&wait.entry);
-			__remove_wait_queue(&ep->wq, &wait);
-			write_unlock_irq(&ep->lock);
-		}
+		eavail = __epoll_wait_remove(ep, &wait, timed_out);
 	}
 }
 
diff --git a/include/linux/eventpoll.h b/include/linux/eventpoll.h
index 8de16374b8fe..6c088d5e945b 100644
--- a/include/linux/eventpoll.h
+++ b/include/linux/eventpoll.h
@@ -29,6 +29,9 @@ void eventpoll_release_file(struct file *file);
 int epoll_queue(struct file *file, struct epoll_event __user *events,
 		int maxevents, struct wait_queue_entry *wait);
 
+/* Remove wait entry */
+int epoll_wait_remove(struct file *file, struct wait_queue_entry *wait);
+
 /*
  * This is called from inside fs/file_table.c:__fput() to unlink files
  * from the eventpoll interface. We need to have this facility to cleanup
-- 
2.47.2


