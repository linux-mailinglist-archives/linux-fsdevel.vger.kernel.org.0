Return-Path: <linux-fsdevel+bounces-40803-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35402A27BE3
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Feb 2025 20:48:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B3614163B8F
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Feb 2025 19:48:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C768C219E8F;
	Tue,  4 Feb 2025 19:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="u8fDDmQL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7DED219A8E
	for <linux-fsdevel@vger.kernel.org>; Tue,  4 Feb 2025 19:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738698506; cv=none; b=QtC1sUItlmSA6eWCSLeGGGzpTL+NkpilVYON64yLGYpFWrqldxR7NuCQwHGsZXCy5sOou1S/cxc07obc3AMEi0T+bSucTRnki+wAEGnPLXxhmzLsKRBVgwMIeAGty3aCnczw09dC/g/xJswC8DdXlPzrqjfEjRGQbE1R9w8f0hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738698506; c=relaxed/simple;
	bh=ayD177cZGh9bhC4WV7iQTen+4xZyD0WE3g92TyrwJnY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KDjbkEJDV9J924c5ByKnxnM8d6HyeFe3GuO5LeuW3p2VMEcYER8DETeTV9XeDrvftrAgg7DJLvho42He6QjP66HLWBJBbjOiQtBcgzoEF1eTzoluWS8E1vT5EYcLrEpMybq608tZl0rjsh4y/RExFmO7KHhRtpd0cfqMKVetKuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=u8fDDmQL; arc=none smtp.client-ip=209.85.166.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f45.google.com with SMTP id ca18e2360f4ac-844eac51429so448532539f.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 04 Feb 2025 11:48:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1738698504; x=1739303304; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mCWW/DHnmpnY+C0n2fbNEGbgNNkUYylpMG8Oip3AQsg=;
        b=u8fDDmQL7S1VYlCJPIfJ2aKUY8hDEL4Iqyndt8ycWgiD3+2/XyClbeQlitSIwJF1Po
         dIcv6tAvHUuyL+SWToIfnCl7uqNDWCDovzTvV/vfms3GMTcejFXWt+3tVeU+K1DiAL5H
         p8tz7V/Uk3NUjLxWrH3fHfpDYPogxvK6q2sTyrRdKSvpvKmMHGEJSBhbh5BAcjthG/Yp
         fhuf+ZwULFcH+hJhrQ/DjExnNu+PKzEmIDbNYtrIi/u4S+FWauqnqzDTntEfCmvGf7i9
         znI9CqNai9ijOByKXCGFe7Zir1mWV3IE0yy74BrVuKZjBcmiBqBl/Go55NJoS42Oercd
         OPtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738698504; x=1739303304;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mCWW/DHnmpnY+C0n2fbNEGbgNNkUYylpMG8Oip3AQsg=;
        b=m8bMjquBqtySA/9JaMnp34+4hnvazIb/fJGj5tfvSk50jvJ0xLlMG1L1CQCBSETBnz
         CLcG1/1qqbM7CKYEKPHaZppoR2+GoMerNUWWd3pgTVVum4cDyXDQyCovTGP50o+uolsL
         iGoTrTXy8DHUlX/TfZ6Qo0Cr4qaWk8ULctZ19vHgr1xsMbk24S+CfpxKUn79j0RLCtKx
         3nPPdVZcgvNxqrT9OCYg8bHM/QRcMrcC37FrjcN0MiIPzjsKfeYHlWzMv7nxgC5sou77
         N8zarHJT8z7LeMlQI4+bny9HAAlcpoQMhuLHTWPC8OcXgHsLbZzBiKBjO4EenY2zNkmu
         8jEg==
X-Gm-Message-State: AOJu0YwY5EGFn5FdziOkNHkFuw5p7ZooXQrZxapq40UufBXMyDwb2UD/
	1V1i4UCAVZdQNsIo6yQkau5UuS88Uwrs3VclP0zg5SeP/sdX4FGe7UzJEw/EMK0=
X-Gm-Gg: ASbGncu7Pb6Xi6BBU7zx2vQNfjTI31hsxlqPoQ50F/5gK1km/t6CmiBH0nMXmsKjpcb
	KkHvCTh3E90XGpDzYnnuxGHozY8tk2M4Q82wI8UUldqOPVGfjTPKgZZlRZpI747Dk195NrcEbA8
	nNwu1ncJzekKT5zgwn82pof/Fgk5gf022F9bjM7zzgdh1P5JMh+ByZ0HVSoNV1hHK0JLIsTPXv/
	T4ep9A1NvhdpVqCN1gfO6vQBJwIJOD11VhBxBtR0cJm0Pq6RBSOlDFpKXQ46IUb0XxNGP0nWUiv
	4jH8hYxLUvc6r0eJxYY=
X-Google-Smtp-Source: AGHT+IF7dUsRk254fowl2HD6TqYE+4+YaIYbCM0ktGhfBv+SkQBsJEtqt76l4Q1QMeTr6rPavpxGEg==
X-Received: by 2002:a05:6602:3689:b0:84f:5547:8398 with SMTP id ca18e2360f4ac-854ea50fbfdmr28213839f.11.1738698503845;
        Tue, 04 Feb 2025 11:48:23 -0800 (PST)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4ec746c95c4sm2841466173.127.2025.02.04.11.48.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Feb 2025 11:48:22 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: io-uring@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org,
	brauner@kernel.org,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 05/11] eventpoll: add ep_poll_queue() loop
Date: Tue,  4 Feb 2025 12:46:39 -0700
Message-ID: <20250204194814.393112-6-axboe@kernel.dk>
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


