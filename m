Return-Path: <linux-fsdevel+bounces-40630-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30B79A2601B
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Feb 2025 17:32:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3F723A58F1
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Feb 2025 16:31:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C38820B7F1;
	Mon,  3 Feb 2025 16:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="f6v5Hc7O"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f43.google.com (mail-io1-f43.google.com [209.85.166.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2510320B205
	for <linux-fsdevel@vger.kernel.org>; Mon,  3 Feb 2025 16:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738600289; cv=none; b=BPrRLEE5fpp0D1BR+qP5UB7n4vdzzAcEUV2zL7gJM+JOkt4MAuHZ6vWJjqQhE4H5WStq9uCN+qM8aC5Dag4++yJBgb5RA7ywfiqwPVrEk7QodWc9sPxuL3xtoRsOzciOvUZc/gH45dd5Em2U0pwWHH6gr4URzkBWwPEv42H7iqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738600289; c=relaxed/simple;
	bh=ayD177cZGh9bhC4WV7iQTen+4xZyD0WE3g92TyrwJnY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=COxtCqnrMb06aK8GSJ00iKnrTDQzgBx051RPA0gt+o91O8ll03/7P8Gva+ukSaCcbMEfpAt63BnnINx1aX3FeHG3JJc5YURVgAGkFLsja5kni7IHWz67qAfwLE9kpt34bFPhkJGoZ4Ul1uZZrLopSDbNMyyzWmUVS48uiCa04Mc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=f6v5Hc7O; arc=none smtp.client-ip=209.85.166.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f43.google.com with SMTP id ca18e2360f4ac-844e9b8b0b9so314960739f.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 03 Feb 2025 08:31:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1738600287; x=1739205087; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mCWW/DHnmpnY+C0n2fbNEGbgNNkUYylpMG8Oip3AQsg=;
        b=f6v5Hc7O/DXa4nmyM4n9ODsNvkNmUs/Z5Z0a1h6WjIHB/SpnDvF2x6BgHefgbwPHz5
         7BPeKgaY89G6mrhzkF9Y+8O+qIL4Ud3HbblcnQWJ41SiG4DJJ3XxvuSxFm9+rcDBluqp
         iuZbCqidgWbM5/Srrya4xNe8gFOTK9e1k6CRlIyLrz4OSGOGupvAG7KIaLWSf4OTtaaf
         tdDN2t+OWo3jMjcYQWaT+H8Byvzp+2nUA0Lp1Q92jNsqBxhDO9TH5umgOCgvTJCsDNly
         biwBQoP931WR8/1+CIosOADUOANCE+ddm61Qsb0Z23jePnuBW5tB/B2GISErvk+D3+Jq
         X3vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738600287; x=1739205087;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mCWW/DHnmpnY+C0n2fbNEGbgNNkUYylpMG8Oip3AQsg=;
        b=lt0rRLPZmVOZ5hxf8UVEyL+1IPGLQv0dbcaAIHJ3ydT7vZzVJ6WDhVfk8TYkSOQxpV
         Wnj1p1uPwpP5B3Lz2g98AQb0iDswppaY3zXeF01+HLcrHVplZcrHycYSW7GEN3lrsMIa
         gXSXE+o0RMTFDQa8JqinxXxtc9mrMj35gL82+B9hhgqxuRDuvPId+BV///ZskYv7jehv
         GZ4xiTn/9WVFAD59SAkvWFcIIlQRj4OLZpkQqfW0Hw0e5eFHXzWRZkdoMWBITrzAqoq4
         zOlScN1qwsaTkEmVpgV0+57J4h2aPFyM1KObflSNx711Z1c8mxktLOevK44SNYOLdyu3
         K+gQ==
X-Gm-Message-State: AOJu0YwwLYPDkdengunZhj83wbTJuPPSSFuR+4yttEh1v0GqzASsdCdF
	PoOjLWGiNqHsKVbYWSYTgM2nv1yhfIMPVkn/Jvp8kzwPtAbTHev6F822qUHi80g=
X-Gm-Gg: ASbGnctRkl5YOGPR2Fjn5VaXowwgoiv1DghsM9X4PcsQxZWYPKuSCVM1GYpuXkpYiOW
	5EY/psnjiC8hYk3ygIgkqcUQPvwYSlS6l87+jSrn/XSKVHTKp8dx6+vQKMvWo2j9wY7USzHbsMY
	jXud3z52xWG9D4ufnuuBExs+FNAKV1hbS042xfV2AwQ734PApYopcLCtUxKw+Lt3ISLSH1ATg0y
	3WU85Hr1sSd+4+WMNO5xZWIAvVaUF2iPtk2D6F62I4JzDLQ1zX1fYnPyEY8RCXNquPPOxacWaMX
	V39RyaPQfyVloqr/Tho=
X-Google-Smtp-Source: AGHT+IFody0BekAT6IYbYLW3U7jHo0YoJOdClv9dRYiYiWYEAJytUXMyrnGF6J0B0Z1zwildYJdr0Q==
X-Received: by 2002:a05:6602:4806:b0:84f:44de:9c99 with SMTP id ca18e2360f4ac-85427e00ab5mr2210157139f.5.1738600287116;
        Mon, 03 Feb 2025 08:31:27 -0800 (PST)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-854a16123c6sm243748139f.24.2025.02.03.08.31.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Feb 2025 08:31:26 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: io-uring@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org,
	brauner@kernel.org,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 5/9] eventpoll: add ep_poll_queue() loop
Date: Mon,  3 Feb 2025 09:23:43 -0700
Message-ID: <20250203163114.124077-6-axboe@kernel.dk>
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

If a wait_queue_entry is passed in to epoll_wait(), then utilize this
new helper for reaping events and/or adding to the epoll waitqueue
rather than calling the potentially sleeping ep_poll(). It works like
ep_poll(), except it doesn't block - it either returns the events that
are already available, or it adds the specified entry to the struct
eventpoll waitqueue to get a callback when events are triggered. It
returns -EIOCBQUEUED for that case.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 fs/eventpoll.c | 37 ++++++++++++++++++++++++++++++++++++-
 1 file changed, 36 insertions(+), 1 deletion(-)

diff --git a/fs/eventpoll.c b/fs/eventpoll.c
index ecaa5591f4be..a8be0c7110e4 100644
--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -2032,6 +2032,39 @@ static int ep_try_send_events(struct eventpoll *ep,
 	return res;
 }
 
+static int ep_poll_queue(struct eventpoll *ep,
+			 struct epoll_event __user *events, int maxevents,
+			 struct wait_queue_entry *wait)
+{
+	int res, eavail;
+
+	/* See ep_poll() for commentary */
+	eavail = ep_events_available(ep);
+	while (1) {
+		if (eavail) {
+			res = ep_try_send_events(ep, events, maxevents);
+			if (res)
+				return res;
+		}
+
+		eavail = ep_busy_loop(ep, true);
+		if (eavail)
+			continue;
+
+		if (!list_empty_careful(&wait->entry))
+			return -EIOCBQUEUED;
+
+		write_lock_irq(&ep->lock);
+		eavail = ep_events_available(ep);
+		if (!eavail)
+			__add_wait_queue_exclusive(&ep->wq, wait);
+		write_unlock_irq(&ep->lock);
+
+		if (!eavail)
+			return -EIOCBQUEUED;
+	}
+}
+
 /**
  * ep_poll - Retrieves ready events, and delivers them to the caller-supplied
  *           event buffer.
@@ -2497,7 +2530,9 @@ int epoll_wait(struct file *file, struct epoll_event __user *events,
 	ep = file->private_data;
 
 	/* Time to fish for events ... */
-	return ep_poll(ep, events, maxevents, to);
+	if (!wait)
+		return ep_poll(ep, events, maxevents, to);
+	return ep_poll_queue(ep, events, maxevents, wait);
 }
 
 /*
-- 
2.47.2


