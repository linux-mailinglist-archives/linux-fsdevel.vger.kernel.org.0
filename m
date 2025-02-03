Return-Path: <linux-fsdevel+bounces-40629-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5008DA2600E
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Feb 2025 17:31:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BF77B7A1654
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Feb 2025 16:30:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7EEC20B204;
	Mon,  3 Feb 2025 16:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="xS0XDYZJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93D132B9BB
	for <linux-fsdevel@vger.kernel.org>; Mon,  3 Feb 2025 16:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738600287; cv=none; b=o2DUmS4VoCKXPKMPMQyDZ8I91Bwz/RVBHZBI+PvEbt+MRoEzeLSrt720Q5zXDlODN49HeSXVo0OHwEIGRlNtQIMlp+EfzFh3ooJOroJ0MBPwBls3ei/qn/VNkNp8ubsCQfqAAetsQUgsYLlKe8Si2ot+FDfHj0X/05pP7ZNy8gA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738600287; c=relaxed/simple;
	bh=FfOsgqQUbrqMBseqWoxvdeHMXbEwUwBb1lrRINWoyNY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F4YlBHYHaNQZ9QvOr6Ucrn8GlN/VosHSP3/Atsw9fxjV9jeRHQK+yDYX4nsYXKBdjx3p/ICELibCClyv8/khvMrZlf29jEJ7vArond3fAQJz2lSmQ0b8xNElnYkgK/gnRBbU+JhAP/VPht7DzPRu0pica5NQfz5VYaRhUa0yDX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=xS0XDYZJ; arc=none smtp.client-ip=209.85.166.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f47.google.com with SMTP id ca18e2360f4ac-844e12f702dso116215939f.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 03 Feb 2025 08:31:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1738600285; x=1739205085; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W4mLZ0JfeLifQ8U+aoK/TU8xkbtkVLx+Q+iBJc1yFPs=;
        b=xS0XDYZJGSQsc1jmdPJAujMEG29Ae0LJe6kTyP0wXMeX1DCf7UQ0kOb09f9L1Dh2W7
         OfuzcbgvEtwEHKXE3Bymam7SStC3PV89f92xizEtv8JutTDGFujpIs8hr7FzmZiG5YKY
         TEHaUkqtuB6p6vrHufGWMGFrPmX/niFSrc0uQTwipB08mtJMxEx+f2WQItDqy0NQu6xl
         1FH+zF7AWO7jArUQ/YUN/TEpBvPCv/NMlZY9fukVLdzFZJWoToQEKczNxWWxOjgEFGNt
         p31nj7EVGjWhhsf+mD/aFLLbOJlBXlOYfPDaT/rW0pRXSwUJOoY4nz9jq4H2Owscaj6w
         MTCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738600285; x=1739205085;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W4mLZ0JfeLifQ8U+aoK/TU8xkbtkVLx+Q+iBJc1yFPs=;
        b=aztBqwmPUN77TFWJOcIFNIr75E3f8hXDJbcVoYiUpFfPCfKB1GHxHhA9EfIOW2YuW1
         HMRazKn4p8tFwep8ZspiU1pYBHfk/51XMsRiy29FbPgzh40bnf5Az1phRUEI1ZVkYd/y
         JYF5acxkHEKyz09MKXSSA19AAbA7jrPYSBicRysOItuT20U9SWhuD2S1nVMAQMkplpx2
         u0LkI8LqRUNHBXjFrz+eWYjadgJ1+jEhlGaCAxV+USbq9t3oN4CrKigFmQ9BDHonbqbY
         M3qM74ppNI8SdSmtO2L4sJmIDaUo9OQyeqL0tpmodAJO/cugesMfN1lpbB7/6NAEu9nn
         y1HA==
X-Gm-Message-State: AOJu0Ywu75a7UtPLBuHfVeilclYTB5ivRrOm1WfSzkOj+LlNEaL12pC+
	MYIMpsiqIvsRx3aSKUWRdiafptbXgPC3gddJ8hALLwe3hK9sT5NV/4bOUuJvL8OXR7PLh8QqodW
	rwZg=
X-Gm-Gg: ASbGnctwfdHPLwFKnm8qjgvcszV1mKYqM9uLvidYjg5Zy92zLLMth1WyydRNsYLT9Yv
	H73yG8G0Dl5CPqme5b2iaQMqJc81N4rY85wne0cAVPh4uhFiIIAzHqOHTsnRuxzySgYnxQCML/0
	uNzg8G4JWOJPryy7EhmSavYOOVHBLtneZXZMkzeLnm1bTlJr9SR+hAfvnSlIB+1qRVR0zdQKDbW
	55Wkm4Lf3ze3fmF9iWJRQ1pru9Dg5j2SujlQv3/tVyB32vCa2+kMkNhppStdMIxQc2upd6tD7+i
	YjNMgp6AuGeD+d5u20U=
X-Google-Smtp-Source: AGHT+IETQZ/yuBJk5CL2/5U1LafOvbuk9WK74Yfijq5HcWNEsU4+WLjYmeWSufJ5PT3mU+sEDNWO3Q==
X-Received: by 2002:a05:6602:4183:b0:84a:5201:41ff with SMTP id ca18e2360f4ac-85427de977emr2164108339f.3.1738600284728;
        Mon, 03 Feb 2025 08:31:24 -0800 (PST)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-854a16123c6sm243748139f.24.2025.02.03.08.31.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Feb 2025 08:31:23 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: io-uring@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org,
	brauner@kernel.org,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 3/9] eventpoll: abstract out ep_try_send_events() helper
Date: Mon,  3 Feb 2025 09:23:41 -0700
Message-ID: <20250203163114.124077-4-axboe@kernel.dk>
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

In preparation for reusing this helper in another epoll setup helper,
abstract it out.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 fs/eventpoll.c | 28 ++++++++++++++++++----------
 1 file changed, 18 insertions(+), 10 deletions(-)

diff --git a/fs/eventpoll.c b/fs/eventpoll.c
index 01edbee5c766..3cbd290503c7 100644
--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -2016,6 +2016,22 @@ int epoll_wait_remove(struct file *file, struct wait_queue_entry *wait)
 	return -EINVAL;
 }
 
+static int ep_try_send_events(struct eventpoll *ep,
+			      struct epoll_event __user *events, int maxevents)
+{
+	int res;
+
+	/*
+	 * Try to transfer events to user space. In case we get 0 events and
+	 * there's still timeout left over, we go trying again in search of
+	 * more luck.
+	 */
+	res = ep_send_events(ep, events, maxevents);
+	if (res > 0)
+		ep_suspend_napi_irqs(ep);
+	return res;
+}
+
 /**
  * ep_poll - Retrieves ready events, and delivers them to the caller-supplied
  *           event buffer.
@@ -2067,17 +2083,9 @@ static int ep_poll(struct eventpoll *ep, struct epoll_event __user *events,
 
 	while (1) {
 		if (eavail) {
-			/*
-			 * Try to transfer events to user space. In case we get
-			 * 0 events and there's still timeout left over, we go
-			 * trying again in search of more luck.
-			 */
-			res = ep_send_events(ep, events, maxevents);
-			if (res) {
-				if (res > 0)
-					ep_suspend_napi_irqs(ep);
+			res = ep_try_send_events(ep, events, maxevents);
+			if (res)
 				return res;
-			}
 		}
 
 		if (timed_out)
-- 
2.47.2


