Return-Path: <linux-fsdevel+bounces-40801-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 619A7A27BE0
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Feb 2025 20:48:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CEFCF3A14C2
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Feb 2025 19:48:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72211219A70;
	Tue,  4 Feb 2025 19:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="deb31OxN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58B132185BC
	for <linux-fsdevel@vger.kernel.org>; Tue,  4 Feb 2025 19:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738698503; cv=none; b=ozdp+NCMc4o1ZMYaAliGRJlF7JK5F2UXdclJU63K8UeFieyMg1KPreCIAsO5y42fXGj4xoc25La1cBB14w4DG/Tbg9wWOHNod+kx4AnD2ii5o+IwkLbc+qARsTo1iZMm3S/6SxuaQVcKSNTpBxy5CaQF4toXrwMAqWUmwmKSqEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738698503; c=relaxed/simple;
	bh=FfOsgqQUbrqMBseqWoxvdeHMXbEwUwBb1lrRINWoyNY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VQ2vCmeQO7mPsL+F6bhBgy+ltwUDvt2Lg98lzA9XFQW7sMev1Y/W2iEKLnfBVPBhjO5lHkWr+BtuXU5x3BizbOL+pKqOwGBSWLKYwTX5H/t0wHEek+JbQTQpcHQ2lDrvIX8n9BS4XpWlINmRdUxdHQGhKAnEJw6onavQFtsLmAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=deb31OxN; arc=none smtp.client-ip=209.85.166.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-3d04fc1ea14so364255ab.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 04 Feb 2025 11:48:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1738698501; x=1739303301; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W4mLZ0JfeLifQ8U+aoK/TU8xkbtkVLx+Q+iBJc1yFPs=;
        b=deb31OxNU1FrYW9c2lj1rJc6b8gWtKbFVb5TKGPbva+mmxr0DaB/gl3FW32XO6Vd9P
         fv/Ofbej1UEoi9ntN2mhcq78ornCTfVBmTeswca4nbnzg+s1jgomg+22ZRSDQ1njaFeC
         0uqdXmH8wpLQ5wTcT5YY51on44ogrMFmVsuBIxSnO9xol6AiFlYRVLYVewRhZ5bM0qSb
         iTWxkO4IxMF4FpWngUQB2goF5hWWkLHJv7N5drCgG6LOfsmBA+VVBzOBw/gOFCfhnCnW
         qpaW6jhFf1B31wHrCK097hSORcOU+it22VuRG0wQCZ2zbtPTbRaZq2OA/ybGkIEdhqJv
         y74A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738698501; x=1739303301;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W4mLZ0JfeLifQ8U+aoK/TU8xkbtkVLx+Q+iBJc1yFPs=;
        b=NYFrxvMqASNIFvAYWDPM+CyJhZ4GNYHjzTtlNJVumXyzVBk7uHoh3ixVvBDtXF1aa0
         3BGO77fzGMk7OrrFKhABfXYPcVfjC3kJG1wP+zowLNP6tbJrk4kZwoOvoEl6Ls1v5sAV
         IvdF5rEulhumtuGgd1T0p+vjslIW1n2QHBaWE+cw8kQ3lr9E1Wn3nrHBkiGVziyVxCdd
         2q64K3zugUomwi0KL/CRbN1NhUzzwDMSyneJzDvmmdPdscAcbkOodzGbdS10JYm0vudc
         KIrbpp8OCbxwhAOC/N83pUqT2DnXg9Xx495nOkx1JKtuZ4Ucc/DhYx6igeUUNHrrjW93
         rKJw==
X-Gm-Message-State: AOJu0YzaRysjVTS5p2Yib3dxBkn4VlpJQ/N1MchDntm/ZnH0raXWbC4Q
	4ZIuqZv6pgd272OQOEnZVDVZYDlRea8TPJ8ri2aF/g6LDdEaDVV2gJ5EokfBUe4=
X-Gm-Gg: ASbGncuyPcNMnzbLv5hBJdtNUEyKxKCF244qErYlUfxaDj9MK5TCgEw759xSntzQ14E
	Ecq4CFki6+IyXG+/AT6QjvTCjzHS1dtRyCZVy4qmYcuALzfzobA/Rh3O9DCmklwYF5K/0r+2C9/
	8PODhatB/D8kMsRdeCNq20pAdq+AV2ykPV0LexR/0V94Tyry2vKHSPl5naacQN217WztkhLyna2
	dXJB52Ey6YPE2L5e1iXRKJrvxSpgZtU9ybV5ofotRAcSrBVQtd3X5aRvbMCJGMKgU1CgqVVjFkQ
	bLIbJ+nPIXmkSXM+smA=
X-Google-Smtp-Source: AGHT+IETLElqsMwzUMAfae/TCAVOpEGuh8jeYsJtvh7I5ZQpGcY/b5dQsufHQP1bMD6MomTu5+GjAw==
X-Received: by 2002:a05:6e02:1d1a:b0:3cf:fb97:c313 with SMTP id e9e14a558f8ab-3d04f8f6ee9mr1728975ab.18.1738698501376;
        Tue, 04 Feb 2025 11:48:21 -0800 (PST)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4ec746c95c4sm2841466173.127.2025.02.04.11.48.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Feb 2025 11:48:20 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: io-uring@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org,
	brauner@kernel.org,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 03/11] eventpoll: abstract out ep_try_send_events() helper
Date: Tue,  4 Feb 2025 12:46:37 -0700
Message-ID: <20250204194814.393112-4-axboe@kernel.dk>
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


