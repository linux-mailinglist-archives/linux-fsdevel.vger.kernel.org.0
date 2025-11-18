Return-Path: <linux-fsdevel+bounces-68811-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id BFA39C66B29
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Nov 2025 01:47:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id 5EE5129579
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Nov 2025 00:47:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 495D016F265;
	Tue, 18 Nov 2025 00:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d6Qku0qN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 290952E7F39
	for <linux-fsdevel@vger.kernel.org>; Tue, 18 Nov 2025 00:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763426842; cv=none; b=r/dM0Ym0X/bZD4FeK69tpar/lmPYkzaDuvne6JwijpiDQ6WOrRWToQuMebH/fcDnJeAPKfqwqpp0x7DI2UFcew8s2HFAnJW1w3vFbzvBkMQYYqM2Z834ZiKzlTIu2GeGAx6Q2cS3VDesSzWneIT5MY+cowgWMbQOx7sCAGvCKWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763426842; c=relaxed/simple;
	bh=ig+MKCY3aFg0uQec5jes1CHpK+KSCmV1XW7ST41n+hk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XW07HgmJiM+3WUJmnztAd0Zo6gVA4pMpJT+RtgbAet+tg3nWM6HceN5fokiP8zgGo8Vy1IgJOkTmsvOH2mCfBqLbT4wyByaRwfvc9N4sEZtlv2rzE2HKWuNSzz5knzkOx9WJsj/thJtaZpYroWma3/v3cJnGg8k+Nsyy6xoAPes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d6Qku0qN; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-297ec50477aso35616905ad.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 17 Nov 2025 16:47:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763426840; x=1764031640; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=a1iVMzAXavtGP6F6utTdab/Su78C+Ibf5Rocm4LyE3M=;
        b=d6Qku0qNbK/Vw3yrDxyRxM8dn+4UjefgAAqkdq5h0kLYsGPGwOj4jbKWQChyJip4Ek
         8oJNiBXFHy49Xs5cclfpjRJO1Ie0jCQDngT5UeQsVYi2E6S/D0iDSuA0jMPG8scTxPNE
         9brJl65dnVLnnaAsH9rRQIovTNZCEkQzynn5JB1t9R4DqMnDUK/UMnOXLuS27LNuAQHV
         ZzjTC9sJwKQV13DeLJdfVpsgfeAfuOYVDTRlexLVvLnYwogIXyt8Az4erLmw8Z28wcMk
         WgFcqAgPStW7YrRvWM+9IkAtN6gTn03935recvBH2eC4prKQYlXzH21ILiIain4D+JbA
         a/vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763426840; x=1764031640;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a1iVMzAXavtGP6F6utTdab/Su78C+Ibf5Rocm4LyE3M=;
        b=jAyt0i8nNw/9l5KJGiCVLy3sjrThColB2yEH6zf+rj30CvvU4zxwd6EKgUB8YAUA/F
         OlFiq/Wg7GmaipAq03kjU+TVnuP/aAFDnH7KfWYZcyiYgYE2Ta7MFqPBl/bftAfAviMk
         BipY7edRDyUGTqVVNbdaVACRFcRPtvhPY/QkyPM6WhJpPtVIodl/iU8s26Q9Xbb05Oht
         N7HW44roIS8B5IarMvs8ejANTkXF0EICHNwLnI4gDMXCMbSvMqjc8qd/afmbcDuyre1w
         xJ7R+gvS3HvNN10YBGaNm09405PK1laBAmMWSGD0hO40pjTe7/Ps8EpGwzAohxUcLhN6
         IKZg==
X-Forwarded-Encrypted: i=1; AJvYcCXrwIzg5ejjhLI460brltnSdoaZ0rlW00C2VWX2kGQMiFvBWuCXqDVtVmuo/DocjV1W+l2vU1wdn3xKQy4Q@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/tWiYUiprWqCn7wmN3ruC8T6Rs5ESnDDdiGCX4Op8mqlllKuk
	YBj3T4xXM2fg+FCyw27jYgxqHRgwJDMhKhZlg8a0eOZHAgvEfe0gIPJom6rcZw==
X-Gm-Gg: ASbGncsAfAJ+DWCxs7LAShA7uM+UfxzSas7g2Y6Bq2SEIehPKYq28vZJaBawkdwruhF
	WDUtoPWmi2sKXSoHtwhMTXniZXomPXNzUqK2d+8nKOGHcAdq5cNZ3lsbTZKfLeoKNZCBIWWK2xq
	8Iiu7i2XuAqVowuYfq+wggn28q/x97lsn2MUwqqR/lhorjyxZ3VSvlNdpleN3A2lEPcJRhnWKFQ
	k9PWm1IR15aHtcvWval2wOOgJ/6AmlV8WbsTw2ecEBDhUhOEMjqVtnbCXem7839WQlgzi91PKiO
	B49bYL93PZHicUduGMJiM7pvqsAmYPcbnj35QzXDeG6+9ni5QttpNHilREqds0nAmZHnIOkGTGs
	gKGouQwjH4vCOt4WNTaDpORUQlxBhJIQ2wX8d3Sx6pDmR8HZji9aJ5OWG8ipuiEoIBFRnqUfBsr
	1dR/9akrKEqotw0hIKPA==
X-Google-Smtp-Source: AGHT+IHjEZpeRlWqzflusmvmb5+Yj1chzPrQ6Fv2Z8LJ+bRrRLwyNRHXxwTzuIB1XMR4VyzmSvMkfg==
X-Received: by 2002:a17:903:1448:b0:299:d5a5:7e with SMTP id d9443c01a7336-299f5587d6dmr14246465ad.15.1763426840419;
        Mon, 17 Nov 2025 16:47:20 -0800 (PST)
Received: from localhost ([2a03:2880:ff:47::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2985c2bf158sm154560445ad.91.2025.11.17.16.47.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Nov 2025 16:47:20 -0800 (PST)
From: Joanne Koong <joannelkoong@gmail.com>
To: brauner@kernel.org
Cc: djwong@kernel.org,
	hch@infradead.org,
	linux-fsdevel@vger.kernel.org,
	willy@infradead.org
Subject: [PATCH] iomap: fix iomap_read_end() for already uptodate folios
Date: Mon, 17 Nov 2025 16:44:21 -0800
Message-ID: <20251118004421.3500340-1-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There are some cases where when iomap_read_end() is called, the folio
may already have been marked uptodate. For example, if the iomap block
needed zeroing, then the folio may have been marked uptodate after the
zeroing.

iomap_read_end() should unlock the folio instead of calling
folio_end_read(), which is how these cases were handled prior to commit
f8eaf79406fe ("iomap: simplify ->read_folio_range() error handling for
reads"). Calling folio_end_read() on an uptodate folio leads to buggy
behavior where marking an already uptodate folio as uptodate will XOR it
to be marked nonuptodate.

Fixes: f8eaf79406fe ("iomap: simplify ->read_folio_range() error handling for reads")
Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
Reported-by: Matthew Wilcox <willy@infradead.org>
---
This is a fix for commit f8eaf79406fe in the 'vfs-6.19.iomap' branch. It
would be great if this could get folded up into that original commit, if it's
not too late to do so.

Thanks,
Joanne
---
 fs/iomap/buffered-io.c | 37 +++++++++++++++++++------------------
 1 file changed, 19 insertions(+), 18 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 0475d949e5a0..a5d6e838b801 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -455,29 +455,30 @@ static void iomap_read_end(struct folio *folio, size_t bytes_submitted)
 
 	if (ifs) {
 		bool end_read, uptodate;
+		size_t bytes_not_submitted;
 
 		spin_lock_irq(&ifs->state_lock);
 		if (!ifs->read_bytes_pending) {
 			WARN_ON_ONCE(bytes_submitted);
-			end_read = true;
-		} else {
-			/*
-			 * Subtract any bytes that were initially accounted to
-			 * read_bytes_pending but skipped for IO. The +1
-			 * accounts for the bias we added in iomap_read_init().
-			 */
-			size_t bytes_not_submitted = folio_size(folio) + 1 -
-					bytes_submitted;
-			ifs->read_bytes_pending -= bytes_not_submitted;
-			/*
-			 * If !ifs->read_bytes_pending, this means all pending
-			 * reads by the IO helper have already completed, which
-			 * means we need to end the folio read here. If
-			 * ifs->read_bytes_pending != 0, the IO helper will end
-			 * the folio read.
-			 */
-			end_read = !ifs->read_bytes_pending;
+			spin_unlock_irq(&ifs->state_lock);
+			folio_unlock(folio);
+			return;
 		}
+
+		/*
+		 * Subtract any bytes that were initially accounted to
+		 * read_bytes_pending but skipped for IO. The +1 accounts for
+		 * the bias we added in iomap_read_init().
+		 */
+		bytes_not_submitted = folio_size(folio) + 1 - bytes_submitted;
+		ifs->read_bytes_pending -= bytes_not_submitted;
+		/*
+		 * If !ifs->read_bytes_pending, this means all pending reads by
+		 * the IO helper have already completed, which means we need to
+		 * end the folio read here. If ifs->read_bytes_pending != 0,
+		 * the IO helper will end the folio read.
+		 */
+		end_read = !ifs->read_bytes_pending;
 		if (end_read)
 			uptodate = ifs_is_fully_uptodate(folio, ifs);
 		spin_unlock_irq(&ifs->state_lock);
-- 
2.47.3


