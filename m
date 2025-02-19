Return-Path: <linux-fsdevel+bounces-42094-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DEA69A3C626
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Feb 2025 18:26:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B606D1796F1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Feb 2025 17:26:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CC6C2144A9;
	Wed, 19 Feb 2025 17:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="enej1hDr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BA352144DC
	for <linux-fsdevel@vger.kernel.org>; Wed, 19 Feb 2025 17:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739985968; cv=none; b=ivktAayseSFmibxIhuArrQS4IIHHlxH9k1D2vrjlP11ojpPnuCd+PsBl7kCj/bsuyZWhLet5a5zAWkPdkPpY7oCXi84VmAxcXe91U7tlyGepLbJJ7Xhlc3M9tRqyxEc4c+N2frTCLTr/nawdx6IP06qh5dFNSkNGRpgahQXGI1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739985968; c=relaxed/simple;
	bh=t9VFdL/JGSkI1kK+B8jwU1v2EPjZm47f8WEHapLZ7wc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ghF2o/9Imq7rmmnRpYsn3d4a8uDX4/6xmnxSLW5RbYODuYdDeviu/uOtAf/YciUyOix6jhmR/1s2Z09OJr118ICfOJo72DTGIUcwnXT2vqn2MJgQGzMwG68qOKiNx4piN+syVLmCURvIFxX7Z5yGK8lAvCjXeEibRHyVKesMZ9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=enej1hDr; arc=none smtp.client-ip=209.85.166.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f53.google.com with SMTP id ca18e2360f4ac-855b3e42c5bso791039f.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 19 Feb 2025 09:26:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1739985966; x=1740590766; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1wj/NWWDbHBPUQsB02XJgoAK7FnxuSmVDgGIKejleZ4=;
        b=enej1hDrhmuIYdeMJy9bUwnuXUsVtUYDEenZZEF+QcABBK6YPAeQdNg+j7Liv4VfJX
         UwCTNtGWykuq1SpvuONFSwiddML7oRkhNELvDT3KM0WQ7DcYvejm7SHGjzw06OCs/pOF
         uXpNxrWzEd2lEVf+hM1HaRqnvtGe+F97FIWaU2G073LBJJSHgwgoI6FB6xHQhMddLb77
         WevOOj51aY2dT3S9GSVWQGJX7LT3d9DrkPgRVMRsviqWEixl3RcIF2jQ5dgxa6J3HWK9
         eLLK+MredZWWLudxj+bf7HVrS9tlBQmwbBmsfr++rLlCIVLW3AXfKP7u1JIUwsB3RUO2
         3g+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739985966; x=1740590766;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1wj/NWWDbHBPUQsB02XJgoAK7FnxuSmVDgGIKejleZ4=;
        b=dfvoBjOgZv1QNLJe8TbHl2jFc0E6opHz4nwqRRzMYOupdV8HP3Oxvp8LI/3ZszOuGK
         Ef9uCtpgzGS/au4EspX3UKI0oPHuw9E2QgsSJzARJCHV9xD/xhfnRnpe36X1wRGXB0Vg
         pqP4VbRPoaCxlikVXohUIaTS6RdevZubeLT1V8cBp93nHAkp12KKvIb4f9PghZEsyUn+
         YT6T6Filfu5TMUOFH8LKLNGXbkaIJxBYKquyUKQUYmF7spOMGo75T4R7mz5EX9faLQVS
         coo8tlnty+N0S3A/GO7Wr8itwAgxs/FRGZZhvVh8NyZ9j/x2RZ43VKxJWc47R4hHWr4C
         oIRQ==
X-Gm-Message-State: AOJu0YxVaQIFfxWshTe/95AAO8YYluxUE+mJ253r2ja3dsoa4vHC7Wxu
	RIIzrGHRI0fIcaTr1yNwLlKpgzVwK/zuJ2UPTX23zA9YWaVD/MzYfcwGsdwL4wU7Rt7TYcDncWg
	t
X-Gm-Gg: ASbGnctKUFQXlCR1HMvAGNgxeAqg/z9HKS6CxOgRyerDuwwzKrgTO2LGltVZnKvIHDX
	nV1buB1FvxwMCd+oL86se6MlpP9IvYAfds2jiuvxF4FifcCKw8jv5ul1izW4Vh4OXNMJPURgxFu
	p7yXBpiVYUNJs1ym179vZ0UbYetsbFnOThMfXHh5o7ilJ8nC2pCYCXcKTFu43MuJVIfEnMIsbzS
	2Kzikowe3o8G5PSUOMqTkYozP1icWnzBBWG9vwuH9scAdIHm2e7akMKMzUkjNNso06q0vugEq0d
	506iQkmTYA8Y+nmdX9g=
X-Google-Smtp-Source: AGHT+IFtaL9/XuB8qrh/MkYo4ESV+gFWdA1YcEjvsmOMak+8t8dipfJF4xY48fkZWILi3KWxQmI7cA==
X-Received: by 2002:a05:6602:6d8d:b0:855:b5fe:3fb7 with SMTP id ca18e2360f4ac-855b5fe4041mr283067439f.7.1739985966274;
        Wed, 19 Feb 2025 09:26:06 -0800 (PST)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-8558f3ccdcesm142192839f.16.2025.02.19.09.26.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2025 09:26:05 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: io-uring@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org,
	brauner@kernel.org,
	asml.silence@gmail.com,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 2/5] eventpoll: abstract out ep_try_send_events() helper
Date: Wed, 19 Feb 2025 10:22:25 -0700
Message-ID: <20250219172552.1565603-3-axboe@kernel.dk>
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

In preparation for reusing this helper in another epoll setup helper,
abstract it out.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 fs/eventpoll.c | 28 ++++++++++++++++++----------
 1 file changed, 18 insertions(+), 10 deletions(-)

diff --git a/fs/eventpoll.c b/fs/eventpoll.c
index 565bf451df82..14466765b85d 100644
--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -1980,6 +1980,22 @@ static int ep_autoremove_wake_function(struct wait_queue_entry *wq_entry,
 	return ret;
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
@@ -2031,17 +2047,9 @@ static int ep_poll(struct eventpoll *ep, struct epoll_event __user *events,
 
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


