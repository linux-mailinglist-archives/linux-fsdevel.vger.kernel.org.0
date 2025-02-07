Return-Path: <linux-fsdevel+bounces-41236-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ABF2A2CA4E
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Feb 2025 18:37:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF68216B143
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Feb 2025 17:37:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CEC919B3EC;
	Fri,  7 Feb 2025 17:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="IEsG3nTz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6AB01957E2
	for <linux-fsdevel@vger.kernel.org>; Fri,  7 Feb 2025 17:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738949806; cv=none; b=PPGf2WH2qfz2JZZH95CmplK9abckygWFeRQLCsr9wittP+7I6/sWc3ptpuASmP00tCNnf8qneBThblecXXO9c3gbo08XC5myp9rUVVbhdHnsQJIFMPUykRFbBHZH8i9sVHTVhmNzZHI4ezwZAFvbXx7UiTkWFb9jNlesH74T5Qw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738949806; c=relaxed/simple;
	bh=DuDffcRazxoqdMbIXpn7+EyJfMiPkF/egp+v1oEJbYo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TAJfHUgb9FrQs5hRadFS5AunF+mO/3B2BiQf9JjthPFDok6tIG5MuO2CthBg/63ollb46ykqe+4uUSovI1Igrd7pqfV5+lL14n4D1tCbv9jCSrz6rlYEq9CqWryY8VYHL0VBVssVJItr5asW1KjogLMMkoiipNPq1uzCwj0wsv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=IEsG3nTz; arc=none smtp.client-ip=209.85.166.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f171.google.com with SMTP id e9e14a558f8ab-3d14811cabfso1566375ab.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 07 Feb 2025 09:36:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1738949804; x=1739554604; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=buVgqb/rrfd7qjVWy9KC8hfJsXJN99hoK7Ry2+u0vJ0=;
        b=IEsG3nTz3F6aeEo9oDmNacLXyXHNlV8rDaMEhSOWiPsvQa5+/CUoQ5NyXyJiODPE4A
         5DHhfHJ3zPHNwbYisRm1PNZ9+szzsgO6nmUJdnRwCezhAV6AVenua3GwxmdEicVjB4sL
         Y/hOLo1Ru8ia2NEx0shLv2RrUDsDZMpfCAsZ+tRYtPSUsb1h/g89DbMHsQko5nyU1meM
         4Ed25Oy6DXxMepYO+tO4kNa5tB6qZ+APY9U2BZxj9TGmpA6qcr6SUZJCWxV+AreYddX8
         0R6J9va5icsPROShVbXbJGiTg5prHuG8DqEZsfM5QgtwQtveXS53nMOOSkZc26xV1u3T
         9ehA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738949804; x=1739554604;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=buVgqb/rrfd7qjVWy9KC8hfJsXJN99hoK7Ry2+u0vJ0=;
        b=KNiiKK76Trv/F8Lx3sC6P6VS8yrei1pXSxxxSHaow+vQVZsZNo2OjD9wfW0sumsTfc
         UNHGDjhOy/vpTIsGnbKEGrV51BXG4QpTBHWrkGpmkOMacaPVbLvw9vVoWZFSbxlyTFxy
         pwZF5eg7iUTTMsWq5JlLSnJLQ/cdBsRksgDLzBEC9cvD797oNSDOifv07mjhTJkpfvoE
         /AGeWbbT6HtZdZT9idc42Lb5NWo9tLlxlqT7jiQ6aVcwibyE4w453AZGf5je+kshWeyA
         GwAo5buAe699gF6tSBxONObRvcfq8syGafa3h5XCET9UAC9kP9nYNfZuDV8JPWEbzmID
         dEUA==
X-Gm-Message-State: AOJu0YyZNY5O6/GkBksbpYslW3DnfXelZqgCZv9qL4oCJwSUmTFWDkT0
	ybpEN4xeyz0RPWaAUTbmN/6dU1iF/cw7sCemUNOTGAk0Npe/yI4Vyg8Jz1FZ4tSm+k9/gg5Qdpj
	R
X-Gm-Gg: ASbGncvHNTvjjTKqAIN23CQ723dqOW1jrBj+2gHmd9QM7U/C41Ac8bhZSkFBp7zkKHS
	ZTA5GZO1yDhXWUCjUP9VcKodkfpyK984CNYgFdC5myrNWrpUxGn4BZgcTRhE2rebof0FP0nlDwq
	V30GrrqN//FxZsxrIAmtBOexYsZmqaZoZRAv/6gwHkEp5Yt+wIBs+PMmV3p1JOCrNYK4fAJ/dJs
	hSFfBJtM4w/PmDHA1Ik+5ljy3BWVdEh+RLP82pOWKAFw9L0t/5T4JMkfDEfZlzv7erL++XDp7wk
	CMrZCwGYlgkE35xqNyw=
X-Google-Smtp-Source: AGHT+IH38njmpGOj3YxkEMJe5TX+OtPLNpsOMIhwPC104gcD+CbCCGR51nFfPMBz+iu5SQLer100dw==
X-Received: by 2002:a92:c241:0:b0:3cf:c85c:4f60 with SMTP id e9e14a558f8ab-3d13dd4ba6amr31410065ab.11.1738949803847;
        Fri, 07 Feb 2025 09:36:43 -0800 (PST)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4ece0186151sm206241173.111.2025.02.07.09.36.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Feb 2025 09:36:42 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: io-uring@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org,
	brauner@kernel.org,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 1/7] eventpoll: abstract out ep_try_send_events() helper
Date: Fri,  7 Feb 2025 10:32:24 -0700
Message-ID: <20250207173639.884745-2-axboe@kernel.dk>
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

In preparation for reusing this helper in another epoll setup helper,
abstract it out.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 fs/eventpoll.c | 28 ++++++++++++++++++----------
 1 file changed, 18 insertions(+), 10 deletions(-)

diff --git a/fs/eventpoll.c b/fs/eventpoll.c
index 7c0980db77b3..67d1808fda0e 100644
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


