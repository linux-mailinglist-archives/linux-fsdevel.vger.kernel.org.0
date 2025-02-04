Return-Path: <linux-fsdevel+bounces-40800-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE23FA27BDE
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Feb 2025 20:48:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 68825163D08
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Feb 2025 19:48:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39D3E219A63;
	Tue,  4 Feb 2025 19:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="r+9bmMqR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f49.google.com (mail-io1-f49.google.com [209.85.166.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A298216E3B
	for <linux-fsdevel@vger.kernel.org>; Tue,  4 Feb 2025 19:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738698502; cv=none; b=NRf8vWDXaWgwyae5b5yGch3PUPGHuGF2OcNctg+UEPJHSEvqUMbDsmMhADj2HI2DB7bQnV9ep9OtI6rDnFf+hWBz3nUhNWVBgjjDyJ6EwpGcTxDbIvRFqmdMuACOyZCjGiXtCGBTMzbLS0pKI+BRlxBJW8Sc/r9rFpQStWayLCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738698502; c=relaxed/simple;
	bh=HCmSTkxKH/HdcO7Uglkp2F2gW3Sb8auKNqzvPdoBqxk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RTjmAmU1ty2dlZzOixkd1K7oAWshvfccoXF45LFVVqoF11MyGF5kRLdlss9EhICaMRET5dkO6Y0M2qwNhWXaeuywaX4PVdKkFXgpibGrsbabBIokZ7UmDd/4tlrt+G8qDAcWZwkAhaamNsMhU6LZfFHBlSsPMTDhIqygXeazsVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=r+9bmMqR; arc=none smtp.client-ip=209.85.166.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f49.google.com with SMTP id ca18e2360f4ac-844cd85f5ebso413346139f.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 04 Feb 2025 11:48:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1738698500; x=1739303300; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z+1svFbJCvXV9Zr5117Ph4lZhgiz5rV+2RtGExbCLLw=;
        b=r+9bmMqREeRvjz0JKPd01cJZECmzs/jCDM43H0wXvZ+1HdOKH5yjdtPrp986avfsIX
         21lBytDhIBQNX3bBMqegzYYLPcPq96YhEJTeXiprlUbYpV2gbjWBI1Ln3mctPafy4mMI
         nI0DTF+AMH2QBFu8ULUoKE8uwLvsU4Jkr6ogvxCG6gEyJ9mbSojYWjVg/2vfkuwm4w6L
         8UTIMkW/ppU5DVlxKku615GQEq3s5L03CtHu4DuRDuGxFmx5JZ5mCkABxteLe0+SXGg+
         /6pLlOfGm5tYc4k/NdkyB7X/lZQ9ERAHMaEbj8aRb7jJKqOO3c7a8qar1s5jATmYnpHf
         kreA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738698500; x=1739303300;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z+1svFbJCvXV9Zr5117Ph4lZhgiz5rV+2RtGExbCLLw=;
        b=tjzmlqOgzbe4dwl76DjApeCF0D5uoQ+YXRUQ4YuiURRwimyADfCBKRxC+2WZmPSgYY
         qbaW+7gBdxhlAbxpF51VW/SrhTiuN9pR1NhrKVknry/mUeOLLqRY7sziqFypTXiAe4b9
         rWwOnZSMcPyuMZQUFnQwFoH0hmbzXlW2jm42c/OmPuu1er7Rt8tRhDVqwrgYy2z3dIb8
         AJwx3y8DwGfuVN/RsSjAYh7kkM7Vj5wTKH9Fq42CeGjtpxSdKMJ+slzAv8JIVezgBFAg
         F3rWHcJSBGXYYH6sS5RgDYHNo8kzEcJUD5l/FDdJCAgTAHlcB/ATYy+gZ2YhLLBfWGEw
         1TzQ==
X-Gm-Message-State: AOJu0YwK1blzw97d3CAgt3Kc1218ogfCKTz6Yp1Wi8teXxx0iu/i6/d0
	chPY7iBfE/iT+b3rXZe4K3ilPw1TEdKsBBXd/57rpIDp+BWnj91FYFZOK1h4Osc=
X-Gm-Gg: ASbGnctkY6XasvPUg0k7s/50zdFm6IWGck8/R9x9TXf3qD0CSipuBqKqneuXoZrALDK
	1kLIzZ58i3WdY584kuz3dmZ0lZWAwqwWA5uQay1QH93bHuAicrvC0VtKZfdKxsBvxgvdApaSOqV
	ZSD8TNnpxmZ7c8A4JgAJFu90yBj9lqZNhDZPr3MP34Bmn+SBLYrLf4+zwddS3UtUWV26ZJiOJbS
	wQV63l/jaChfEoDeHc/uFCmUTEuTECQCM7H96B5O0Di/SMud+5Jr0Nz0xe24/3LnFbBqiL8EfNU
	UQ8kMgfmkqzfO7ln0yU=
X-Google-Smtp-Source: AGHT+IGyhMhWzZeNFelBaJa5XqWbciXoqrb56RQyl9GgEyL9hOLIOlPxlzAjAP9SCizEF/4ij6wYeg==
X-Received: by 2002:a05:6602:7210:b0:84f:2929:5ee0 with SMTP id ca18e2360f4ac-854ea50f874mr24700439f.10.1738698500067;
        Tue, 04 Feb 2025 11:48:20 -0800 (PST)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4ec746c95c4sm2841466173.127.2025.02.04.11.48.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Feb 2025 11:48:19 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: io-uring@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org,
	brauner@kernel.org,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 02/11] eventpoll: add helper to remove wait entry from wait queue head
Date: Tue,  4 Feb 2025 12:46:36 -0700
Message-ID: <20250204194814.393112-3-axboe@kernel.dk>
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
index 73b639caed3d..01edbee5c766 100644
--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -1980,6 +1980,42 @@ static int ep_autoremove_wake_function(struct wait_queue_entry *wq_entry,
 	return ret;
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
@@ -2100,27 +2136,7 @@ static int ep_poll(struct eventpoll *ep, struct epoll_event __user *events,
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
index f37fea931c44..1301fc74aca0 100644
--- a/include/linux/eventpoll.h
+++ b/include/linux/eventpoll.h
@@ -29,6 +29,9 @@ void eventpoll_release_file(struct file *file);
 int epoll_wait(struct file *file, struct epoll_event __user *events,
 	       int maxevents, struct timespec64 *to);
 
+/* Remove wait entry */
+int epoll_wait_remove(struct file *file, struct wait_queue_entry *wait);
+
 /*
  * This is called from inside fs/file_table.c:__fput() to unlink files
  * from the eventpoll interface. We need to have this facility to cleanup
-- 
2.47.2


