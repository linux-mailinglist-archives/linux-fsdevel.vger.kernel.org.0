Return-Path: <linux-fsdevel+bounces-41238-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 65372A2CA51
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Feb 2025 18:37:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2CEA6188BE88
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Feb 2025 17:37:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 349D91A2380;
	Fri,  7 Feb 2025 17:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="bf/bvzxv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B249719F12D
	for <linux-fsdevel@vger.kernel.org>; Fri,  7 Feb 2025 17:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738949809; cv=none; b=NXp9yzI5BjjEhxBuvG0uluHgDYbycttMvOkfgikV4cfIqDajtBYxNTNv+ttFmBHpXRKV1kkuPqOfVE5W9n1XsQhZqCsgGW3RxdR9OExEnSbnHgvvHri3RxEE6tQOcxE4fU2I4T9uUKDiuls8tI+QRrxKpmRRt5xrNMG6l1GVs4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738949809; c=relaxed/simple;
	bh=neCFR3srUdC4BqNDJJ/puIB0s8g+B8z5na5WmH02VcE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MPdIxljg54wjtEdm8JkB9lARw32Fw4TBT3pJoxlhe/2ikGmNIglugeYk9MXZ90zHL0fqfLMfqd75wwoHOQDfuKfXVoWOjW0fRAH0YbOzm/dAtX70c9Pk0t3ZdjsBDWlWTVQP5N7QaDJxD8gTKBq8w9iq7rQIbPCEkiXUFbeWh1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=bf/bvzxv; arc=none smtp.client-ip=209.85.166.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f46.google.com with SMTP id ca18e2360f4ac-844e10ef3cfso175631339f.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 07 Feb 2025 09:36:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1738949807; x=1739554607; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vQh1Zg0+2EnqTz66Y3o6QdpwBDhvVYS6NGGQhGbGVOA=;
        b=bf/bvzxvCJL3LfwHEaARfeVRtt1Earg3XhvXyEHIX4/JOckqigTdFPcI7Z2/czvsO5
         NbSKZxkzIX/oe5E4PAXnoWI1hDDtbhAfGVj5eXIA8eHbOA3sPyQfS5IqU78qDnop5U8K
         KACVJizSXUiUNbnt3eX6sU2pqEtz+5cOTvevcQG/ln/cD6nj86uTldwpTshPKUW4Qf2X
         F5T+bh781dCyNMDMj+85GpVvheI3Pg4xeHklPGZSDheZdpvztc3+kNfDz/I8bHuVqYVn
         s/6dsJtvVX86V/THj2lfH2ge/Lgkn5tvi5S24RzerbTW7olP6tyTE84/vry+v4CWdADA
         MzsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738949807; x=1739554607;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vQh1Zg0+2EnqTz66Y3o6QdpwBDhvVYS6NGGQhGbGVOA=;
        b=Ov6H6BxKe5ZK4TmUhGXZSDMT9Twl7wJMI+jMjLC2IlxVHGpKMLqis2RPWDMqTwClVp
         mktOtwcUGt/HN0lvVyokptjV8RG+Gh/zO8TF50ObHRT2XOK6y9GE+QukxrD0OVxrvD+v
         etSr4a2ULPovIbWOkj7mWEWU8dhTHfthvZ/wvtD4R4R6IxWt3fk8VV+NhGZjdeKe+DQB
         VAtcQd0jjp78du5jkCRJZDZqKJ6gfta++IGPNkh7S31gGKD3R+rzJraVAsY3YfmXv0Hn
         kXMEnOFZT+oE8xUE2/XfFwFQNOlwTNn2eLKMOp09A2D9oSv7ksTwqtria+9NTZunjfna
         Ak3Q==
X-Gm-Message-State: AOJu0YyKD9Ce6hL5CKeubH0sj6ULsRq8ahQeo8wSXHBlKHcBEWm5KH/k
	BmFDrvPlCam58wlGqGFRDONXP7ALdyiCAChiUlJ881gz9m/jKiCwbPn7pC+5WGw=
X-Gm-Gg: ASbGncsoo6ZmCaub8OXu0LsJZBpQ7yThXfMxcAIozsKkquWl+pKNsVJ8fD+NZt3TlB2
	zwL80dsB7KpdDUO6uFMtlpqvn70XaO72Ly2xYRNOY+V5T3tMf4fPBBUWWHGnOIjo8oBq86YkXxw
	Smuq8Y3I9i0r1jqGm5X12vXX6bVf2Bb60KbDhFq0tR7hx0gW4zf4aJ7HpVdHXzhjomCdoKrZDOH
	NhzUhBCuDawxyTY9/eKPFLpQ485WXDigiJcDwGXY1n+0U3CBhWJAQOs4Ug/INxCO+ttU0J3Jq1x
	ctH9hbXmqIhSLgez5tQ=
X-Google-Smtp-Source: AGHT+IEKzclYyCh3PyEzi+DF6BgOM8uthEYpdjl88V/12SKTf7VXtPAto5WeE4um2QNlQZDlP37OsA==
X-Received: by 2002:a05:6602:360b:b0:841:9b5c:cfb3 with SMTP id ca18e2360f4ac-854fd8f9424mr421162739f.10.1738949806755;
        Fri, 07 Feb 2025 09:36:46 -0800 (PST)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4ece0186151sm206241173.111.2025.02.07.09.36.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Feb 2025 09:36:45 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: io-uring@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org,
	brauner@kernel.org,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 3/7] eventpoll: add epoll_queue() interface
Date: Fri,  7 Feb 2025 10:32:26 -0700
Message-ID: <20250207173639.884745-4-axboe@kernel.dk>
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

Basic interface that takes a wait_queue_entry rather than post one on
the stack, which can be a persistent callback for when new events
arrive.

Works like regular epoll_wait(), except it doesn't block. If events are
available, they are returned. If none are available, the passed in
wait_queue_entry is added to the callback list. The wait_queue_entry
must be previously initialized, and the callback provided will be called
when events are added to the epoll context.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 fs/eventpoll.c            | 39 +++++++++++++++++++++++++++++++++++++++
 include/linux/eventpoll.h |  4 ++++
 2 files changed, 43 insertions(+)

diff --git a/fs/eventpoll.c b/fs/eventpoll.c
index 14466765b85d..d3ac466ad415 100644
--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -1996,6 +1996,33 @@ static int ep_try_send_events(struct eventpoll *ep,
 	return res;
 }
 
+static int ep_poll_queue(struct eventpoll *ep,
+			 struct epoll_event __user *events, int maxevents,
+			 struct wait_queue_entry *wait)
+{
+	int res = 0, eavail;
+
+	/* See ep_poll() for commentary */
+	eavail = ep_events_available(ep);
+	while (1) {
+		if (eavail) {
+			res = ep_try_send_events(ep, events, maxevents);
+			if (res)
+				return res;
+		}
+		if (!list_empty_careful(&wait->entry))
+			break;
+		write_lock_irq(&ep->lock);
+		eavail = ep_events_available(ep);
+		if (!eavail)
+			__add_wait_queue_exclusive(&ep->wq, wait);
+		write_unlock_irq(&ep->lock);
+		if (!eavail)
+			break;
+	}
+	return -EIOCBQUEUED;
+}
+
 /**
  * ep_poll - Retrieves ready events, and delivers them to the caller-supplied
  *           event buffer.
@@ -2474,6 +2501,18 @@ static int ep_check_params(struct file *file, struct epoll_event __user *evs,
 	return 0;
 }
 
+int epoll_queue(struct file *file, struct epoll_event __user *events,
+		int maxevents, struct wait_queue_entry *wait)
+{
+	int ret;
+
+	ret = ep_check_params(file, events, maxevents);
+	if (unlikely(ret))
+		return ret;
+
+	return ep_poll_queue(file->private_data, events, maxevents, wait);
+}
+
 /*
  * Implement the event wait interface for the eventpoll file. It is the kernel
  * part of the user space epoll_wait(2).
diff --git a/include/linux/eventpoll.h b/include/linux/eventpoll.h
index 0c0d00fcd131..8de16374b8fe 100644
--- a/include/linux/eventpoll.h
+++ b/include/linux/eventpoll.h
@@ -25,6 +25,10 @@ struct file *get_epoll_tfile_raw_ptr(struct file *file, int tfd, unsigned long t
 /* Used to release the epoll bits inside the "struct file" */
 void eventpoll_release_file(struct file *file);
 
+/* Use to reap events, and/or queue for a callback on new events */
+int epoll_queue(struct file *file, struct epoll_event __user *events,
+		int maxevents, struct wait_queue_entry *wait);
+
 /*
  * This is called from inside fs/file_table.c:__fput() to unlink files
  * from the eventpoll interface. We need to have this facility to cleanup
-- 
2.47.2


