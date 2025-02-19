Return-Path: <linux-fsdevel+bounces-42095-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 86FFDA3C62B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Feb 2025 18:26:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 771DE3B88E6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Feb 2025 17:26:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFA49214A79;
	Wed, 19 Feb 2025 17:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="mTgOMfe9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D16B21423F
	for <linux-fsdevel@vger.kernel.org>; Wed, 19 Feb 2025 17:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739985970; cv=none; b=ZaOhg3bsecG2j1ZzDvw5fY73Uh4u1/iMS40HDVaxVlBQziLnH044eEdtdXJmp2txGdmvHGPfnTrlfVK18zrCm+2P/p+v1nAncpsfW9XGCMxbvIQuvVzHhc7YlnnXrNJH4yrqQO7py+1k5i9/8Rl2Y4hfdbf8k+HdDqRudN6ieXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739985970; c=relaxed/simple;
	bh=N/K1wXHto9EUav/plQ5H1Ct3sazV7rp7nIQXrrPuZM0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pFEtpN2fCiFH/7Zn30oaydtn1cfUSKa4yt2SzX5tBsv7YcmnKYHNfR/2kCZeSIUuE6aSTeCmhd/ApJIpTzmjGzPrk4biaflIEms9slsR0QPz2vkxd7vu8zjmP253e8PmL0eZTM9aJGerTxdheGoKrohXxUBydq4jA4cdl+ArNp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=mTgOMfe9; arc=none smtp.client-ip=209.85.166.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f51.google.com with SMTP id ca18e2360f4ac-85598a3e64bso3007239f.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 19 Feb 2025 09:26:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1739985967; x=1740590767; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3hLS+fhEeJItsy0qr9n/8T/ts3J225prk6HY4IC/ZoU=;
        b=mTgOMfe9wwXFATa4JuF9Fbk7zmVjBpQzVsvBlES10VGQAlzPC7PoNgM/egWxRo6WZW
         EOKGho6Inbo4gIRdRskyfHIVBOg+4PhyiKRQSQjKdSWEhjsH+Uq03XsMDac7U22VvZVe
         w1M+JF7IK3/DXHSXBjopLOv3aP3o2np3Qsoq7zkMHs9bKwv/uSUczFWa5sru7pTAgS9Y
         bUy0eXXxy+r6ZsN4KuBHpKcRvzBJ5Fwi5UbcLHtH4nm8DjsfIJfzFIFa0K3ku0LJkLUu
         YInwP9Wei2royHhI0knm92Th6pF1WzotToboXK4h8X369OlUm2DM1vw/Yy9/3+dc8ldW
         I6jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739985967; x=1740590767;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3hLS+fhEeJItsy0qr9n/8T/ts3J225prk6HY4IC/ZoU=;
        b=V0VDDoXkcJx5JnWUDOTCoVfYoc+GoxTyWmBrRVu1Sy+nAxYW/wbADbXSzSEHFALrnu
         0G7/E2NRwB3xVEJX8j8H4LkrJqvhKqgzvP1RPfy7zYITZWhBmfqEj7N8KZZukJNNvs61
         SxfqeWaqzcd6z7PiOuM8IxkYbDpJa14H9nHCb5Ev/2TZe05xZAxzrjwNv69P2lno14xN
         jG8170u7/A+jChiMjI4VfjthkzYIDgt+0bnBdjKZPp37RYPxKTDuwgDNrCtmj2485Nyd
         0HCHKJAPrsZQgmse487bP9LxQ47IcQxEQwEWfveiY41tFKTS2H9pSojBuzIpFwcAm9lU
         ohPg==
X-Gm-Message-State: AOJu0YyxhbVZSjB5kA7B/SsAHPoRns0+BwKrZimihW9kdEWzl/5l8KjX
	llOQOMjW17xUtKJCWPrKcb80XCHjNBy//BJ6GHaJcgDGPLEO/MiclATpH/Eov50=
X-Gm-Gg: ASbGncvaF5f/M4SPX2VpbCLhN8knzGgxdJnPLg4p2JcwFY8LrDENmdmGdlMZKcYsmdv
	9+E7v08Q/HuHbtM/C1nhjlJ6nm5tO+yrTwQ+qifXApxpZYFtD4NgaHmyqQvND/uebyQKdm14w+c
	dI2QJ1hCq+CX75q7sPNkXZKSvKFICkBtnF4AiFtAFN1bjpPo8E9FrR5ZHI7Qq/sZHJC3T9zQBrX
	O/AAiwWWpw1Rm6NXVBAibEExb2dO18WpmuhH0T1jgayQX84lT4RlOPFvs94K9++XRiG3x5QpEWr
	nwPCjrp2oFBEkO4Yyds=
X-Google-Smtp-Source: AGHT+IFu6pkBHN/jzNR4Yx3waXcQL0mHGqKfBL7pK3ptWaTbpFR05iOXURlc6k5WEDumbHgigo/mcQ==
X-Received: by 2002:a05:6602:150f:b0:855:a4a4:a938 with SMTP id ca18e2360f4ac-855a4a4a98bmr863821939f.2.1739985967617;
        Wed, 19 Feb 2025 09:26:07 -0800 (PST)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-8558f3ccdcesm142192839f.16.2025.02.19.09.26.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2025 09:26:06 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: io-uring@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org,
	brauner@kernel.org,
	asml.silence@gmail.com,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 3/5] eventpoll: add epoll_sendevents() helper
Date: Wed, 19 Feb 2025 10:22:26 -0700
Message-ID: <20250219172552.1565603-4-axboe@kernel.dk>
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

Basic helper that copies ready events to the specified userspace
address. The event checking is quick and racy, it's up to the caller
to ensure it retries appropriately in case 0 events are copied.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 fs/eventpoll.c            | 20 ++++++++++++++++++++
 include/linux/eventpoll.h |  4 ++++
 2 files changed, 24 insertions(+)

diff --git a/fs/eventpoll.c b/fs/eventpoll.c
index 14466765b85d..94b87aaad0f6 100644
--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -2474,6 +2474,26 @@ static int ep_check_params(struct file *file, struct epoll_event __user *evs,
 	return 0;
 }
 
+int epoll_sendevents(struct file *file, struct epoll_event __user *events,
+		     int maxevents)
+{
+	struct eventpoll *ep;
+	int ret;
+
+	ret = ep_check_params(file, events, maxevents);
+	if (unlikely(ret))
+		return ret;
+
+	ep = file->private_data;
+	/*
+	 * Racy call, but that's ok - it should get retried based on
+	 * poll readiness anyway.
+	 */
+	if (ep_events_available(ep))
+		return ep_try_send_events(ep, events, maxevents);
+	return 0;
+}
+
 /*
  * Implement the event wait interface for the eventpoll file. It is the kernel
  * part of the user space epoll_wait(2).
diff --git a/include/linux/eventpoll.h b/include/linux/eventpoll.h
index 0c0d00fcd131..ccb478eb174b 100644
--- a/include/linux/eventpoll.h
+++ b/include/linux/eventpoll.h
@@ -25,6 +25,10 @@ struct file *get_epoll_tfile_raw_ptr(struct file *file, int tfd, unsigned long t
 /* Used to release the epoll bits inside the "struct file" */
 void eventpoll_release_file(struct file *file);
 
+/* Copy ready events to userspace */
+int epoll_sendevents(struct file *file, struct epoll_event __user *events,
+		     int maxevents);
+
 /*
  * This is called from inside fs/file_table.c:__fput() to unlink files
  * from the eventpoll interface. We need to have this facility to cleanup
-- 
2.47.2


