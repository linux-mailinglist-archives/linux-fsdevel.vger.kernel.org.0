Return-Path: <linux-fsdevel+bounces-47638-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25632AA1B00
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Apr 2025 20:58:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 08B155A0F57
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Apr 2025 18:58:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAF77253F25;
	Tue, 29 Apr 2025 18:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="gM26QAy9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BEC01F4736
	for <linux-fsdevel@vger.kernel.org>; Tue, 29 Apr 2025 18:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745953132; cv=none; b=CKfZwZ2jVsIOyVq3F5Z72PkBfzp3CTV77zhGg88lpNmCjdblUN8Ep05WwOKNqrdPLJv6NX1ks/cDXHGCMm1KmPXULQEmb4zxs7QAfHePyzOkb77LNrhTPLLaW7dnnRtRPd8yLwvQr5nC27HxBN7OTN6NuoP+XD9bnNVHOW+jK9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745953132; c=relaxed/simple;
	bh=8DWUkgowi58Q+C6KSwBRblI0nmvZQfHYlZ0o/INoJlQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HcDH3pGmgl1oz/T+B0PN/7BCVc42TNchRgWdtbPlQCrFe6x9+rSsyOq564hSPwcoMMynRkbdOBfp9DceF6JfP1hcpYtkCNZQvPvTBK9i81GEpB7b0B8zzDzPkVn60S7SCre+pyJeKVQ++h6v0FsflFK9/k4tR8rGQDbhTLhYDo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=gM26QAy9; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-43cfe63c592so66166585e9.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 29 Apr 2025 11:58:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1745953127; x=1746557927; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mJ5gLIKdEnlHfp/ZM9aOKHXL04cwNu47lJLmXXaF2II=;
        b=gM26QAy9PFPVm0t2wYMjzl6cRHjV9vLdBez/1mkvChOBElSY8hLmeBOZFeBryMplf1
         3E61LQR9LXd/OJ+PGjeah+7n2elVhTl/B5NLh2Pfq3Kx3GaB4c9cmV1n56Moyyd5ohzq
         GuJnrOPXnJr98ci7GzaFY1cwUdIR+pmqML6fC/sbKFNWathDmCqpfW6axtX+iR5loYUa
         SS+HhnI/6Rka0V0zS3OyXOFOPDqdL+rYDa89p1hx69vopna0/fIdhpkz76KEk1z6pEJY
         zI3GmzTXngjzuKjQIuV2lK0aK47uWjXDWv5JNtVE4cpZghxFjkwu7pPfb9EF0aGpVjIh
         HyEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745953127; x=1746557927;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mJ5gLIKdEnlHfp/ZM9aOKHXL04cwNu47lJLmXXaF2II=;
        b=BSSmk7ronPjRoDItt7bh0M2aQVT/Dz1YHfX+tfpZj0FrUgYJd7Qtc8Vuz6/F/p+ojN
         i8svKZo04cdI3iCXlnFjqaVFGXqqlghUc89srVGPRMHk0yFKea9WCXAp1RRL73iyL1+0
         Xnw7FPKSEO8q9frMvqWnxxBG5lBtSLsoFYmi6jc81DjWHbjPzjX5aGHoZcsANiiOINti
         ieNm61/a8UStfksOC8su00s1oWcV/0jzD7Mxb82mWEOR4NMe3ptHzzpSvqidNffBqqfZ
         e1TGTUx//Swx+4YPWcs2HWCia/kJIs1lHPzkBMAAHBxkpQBbkxvwDgHrVuCWHYRYSwjX
         O25g==
X-Forwarded-Encrypted: i=1; AJvYcCUulSgShh0p72n7tWNN3qrDRrZZ47BL/t2vE/JexHgyBlqqHFVEuu9XSXmuWOvhvW3z+jG1KfXrfkFOIBwD@vger.kernel.org
X-Gm-Message-State: AOJu0YznQ9GM7YS1g2rCuDjDzESDwa+GnCau4B1PVGP46caCG/YgxI8j
	ZaKp4XTUHr6ZWi4aNb0UXYQY14nNB0uqjtzHuYHkwfwAteyEsZ9qKZHS/OvXaig=
X-Gm-Gg: ASbGncvQPGAyiwVRdmeJ9wSWAuYa4vwyzmb3w+eKDE0XvIeMbQWJbovkE72Z697IMWz
	wtRGK9OxjwJJOKWdximdZ7+rGDj4PEAa2mFcluqCj7VM2zUeeihG2iZo/HMg0fDhYfePpfxylnx
	TiHmZ876gtffSGT6PIFIFGz7/Dh/yah7buVfzQef1qkwgoUjGxN9GA/HFiZasFkYA0QCEnCUZIl
	k8jSSJEYa18eXTrkiAsiMr7qlSV5wzShBxdhFdoo+XL9wN7i28RuplKqjgP78MTgaMsL9w7FKC5
	5I75YJZuvOHzwBwvwduhrK1L8rhJwoz3hW6U9M2KncM5KptPJckM6h5ZdfB5zu+TGW6lDpaCt3D
	S5cxilL61S2Yyx69ri2Ab6vre4uRFotPnFKYCb/42
X-Google-Smtp-Source: AGHT+IEZMwWz0zdMJ9NDjk9O5Asf64JDL54V1y9NgXWNtSz5RkuH7RmJD1LO2QHqy0LDF2oJCsnupg==
X-Received: by 2002:a05:600c:540e:b0:43c:f44c:72a6 with SMTP id 5b1f17b1804b1-441b1f35c1dmr3839765e9.2.1745953127536;
        Tue, 29 Apr 2025 11:58:47 -0700 (PDT)
Received: from raven.intern.cm-ag (p200300dc6f46c100023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f46:c100:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-440a530a6e9sm165643035e9.16.2025.04.29.11.58.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Apr 2025 11:58:47 -0700 (PDT)
From: Max Kellermann <max.kellermann@ionos.com>
To: viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Max Kellermann <max.kellermann@ionos.com>,
	Joe Damato <jdamato@fastly.com>,
	stable@vger.kernel.org
Subject: [PATCH] fs/eventpoll: fix endless busy loop after timeout has expired
Date: Tue, 29 Apr 2025 20:58:27 +0200
Message-ID: <20250429185827.3564438-1-max.kellermann@ionos.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

After commit 0a65bc27bd64 ("eventpoll: Set epoll timeout if it's in
the future"), the following program would immediately enter a busy
loop in the kernel:

```
int main() {
  int e = epoll_create1(0);
  struct epoll_event event = {.events = EPOLLIN};
  epoll_ctl(e, EPOLL_CTL_ADD, 0, &event);
  const struct timespec timeout = {.tv_nsec = 1};
  epoll_pwait2(e, &event, 1, &timeout, 0);
}
```

This happens because the given (non-zero) timeout of 1 nanosecond
usually expires before ep_poll() is entered and then
ep_schedule_timeout() returns false, but `timed_out` is never set
because the code line that sets it is skipped.  This quickly turns
into a soft lockup, RCU stalls and deadlocks, inflicting severe
headaches to the whole system.

When the timeout has expired, we don't need to schedule a hrtimer, but
we should set the `timed_out` variable.  Therefore, I suggest moving
the ep_schedule_timeout() check into the `timed_out` expression
instead of skipping it.

Fixes: 0a65bc27bd64 ("eventpoll: Set epoll timeout if it's in the future")
Cc: Joe Damato <jdamato@fastly.com>
Cc: stable@vger.kernel.org
Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
---
 fs/eventpoll.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/fs/eventpoll.c b/fs/eventpoll.c
index 4bc264b854c4..d4dbffdedd08 100644
--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -2111,9 +2111,10 @@ static int ep_poll(struct eventpoll *ep, struct epoll_event __user *events,
 
 		write_unlock_irq(&ep->lock);
 
-		if (!eavail && ep_schedule_timeout(to))
-			timed_out = !schedule_hrtimeout_range(to, slack,
-							      HRTIMER_MODE_ABS);
+		if (!eavail)
+			timed_out = !ep_schedule_timeout(to) ||
+				!schedule_hrtimeout_range(to, slack,
+							  HRTIMER_MODE_ABS);
 		__set_current_state(TASK_RUNNING);
 
 		/*
-- 
2.47.2


