Return-Path: <linux-fsdevel+bounces-69025-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D412AC6BB1B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Nov 2025 22:13:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BDDDE4EA5A6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Nov 2025 21:12:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 999A630DD14;
	Tue, 18 Nov 2025 21:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JedZWDcn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 940152BD5B4
	for <linux-fsdevel@vger.kernel.org>; Tue, 18 Nov 2025 21:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763500315; cv=none; b=GfwYYJpS/xZ6Po979aND4J9gT1k9BLGyJxtgad7o1j0201oHFMh1bgkjWyEe4KeKV+RA9tQyiO/Xw7MeVJE7F+IdGVi0OcHYZQ0JgtrQtNvP1tDrzFVSzm8aS99CuHhuNiAfaDx1LOigb55CG6YdiFJfT3931ZVcAwbaACxNh1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763500315; c=relaxed/simple;
	bh=26wBnooncZQKo5L/uZaKF5j0nDJmMyKOpI8/5yH6kH8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UEy9qVdzUz8Jhp4F4UE4KtAh+/d0bCkY4g+6at7yqcSGJF+TgW6li2P5oPb51OzwKfeJ0RBXmRbLyTJAuGCVRk5kseBZVtQ9MawY+GZnwa3GV94j27vIMCq2SJ7cIRg5IYzUMTPCpIV+oC30X8rU6MdLuBG74+ifQrIIyHUPxsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JedZWDcn; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-7b9c17dd591so4854643b3a.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 18 Nov 2025 13:11:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763500313; x=1764105113; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A2eAjcM9LTYLilVSy/qKTWK1paDLV0NXgjq4WeSrFLM=;
        b=JedZWDcnddpY2N4+7vCUMNVbbVkIREoJ4wLmzYAkhnJMaRxRIiYHkxEDhQVsLNmsle
         DwD6sw79nIVEd+jwIMjiQl+G5pi2LmIqNCTGn33yq73qAIhodyvIAHASCkFs07QspMWd
         J4ERpQ+j6j62GcskQEf8Zdc3PcCy3Pds7s46D0UgrJWkj8gymwmA+ZUjQ8oymMjDPxwR
         AjbsGMWBfW68Q6w3niEpXU+xhlIl9sZZWysePR1Skjrj2tYfn4mnRQw8XhNj1yoG+FgD
         K/scXR3o34+l90Wh6r/dNanZKUkpytOgszVYmohLgcIS6d9GW9so0CWUgNogm1bw+b1e
         L+Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763500313; x=1764105113;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=A2eAjcM9LTYLilVSy/qKTWK1paDLV0NXgjq4WeSrFLM=;
        b=rFdx9xdZPYJovBzKLs8h0LPzskS2jwahlGDzGZ63vl4rIYy5XNnP+npn3mNi5V7Nth
         dv4lFw48U69pJx9JE/Jm0LGGw0ctCmk22gsklno9XJ86Y4kjyKCCowN8zVKgoyEJW8Wa
         hjhUXDY9dcbMYCp8uGNB1HmQQAmCXMOVo5kpQKiNcGDQL/hAiV+dgRH6kYwJ50DtqiZ4
         lR+00fP74My+7IxAYvqpFj6JenCIa1UTdycqR2OPJ/jKHQ+FQnCpcU0N8bU3B76ju5rv
         555zyvMSq/ZEGfgWYo2Lqmrh6Yys0kEGhA7P93/yDBtkPUkvQ3B2RoFP3RYCZw2/MPGq
         R2mQ==
X-Forwarded-Encrypted: i=1; AJvYcCWUVseSiD73szl1KUMwxnUrAwxpc8xSvieCb7cH7zHLLSfXoViLPfJOa78SBnzcNNxi770R9TZKItSPJrzE@vger.kernel.org
X-Gm-Message-State: AOJu0YxRzdHTylZQrHbSAQTgzAOQvZ0eVZipDGBH6oWQeGNBLX3yVqGT
	s9zsik+zlEYPUMUT9U/FfglIeXjYEdw2BLI1I/5Lp1SXh1427zzd3xFwBAacSw==
X-Gm-Gg: ASbGnctwvkGZZFWsWJTkHReBuz/USMdVFOwplbD8eRRVOyPGsYY4C3M9h9i7M5IdLdX
	+07PwVG2bCZPFoLPxiKhnVDREwv0y4DvW1mbugW3cFy+sME/OqGI0gO8lMZ6bdPjBEXbh5mrceA
	MIacsdF41PI+2sDG2ugtZIVKxG9odAm4bXG+gwfwBtp7WhZrrttIQksmlwnvhf6nH2371sHDuql
	pDdoTVeIKF3EnhaM5I81NM+hRv8il2IQHzYAVzDuC8C0F1o5pncmeIrpUrfcllQ+wd6tJhidIKa
	r9G0diZMEtWbJaV6lkwRIbSiy864F8GjvLzXF0f3MuthMa6bkimffB0jnrNEVRTnUWpr3BpgUmb
	QZgY5rY0Ls8Zyfg9Iu4zQwJHTDoHYT9ARKCJc16uP3xZ21XFdv6T8J/g88ZPRpdx37qwhDgpZuH
	ofxAOxV8pqGoRKHheJXntUgJSOWmWX
X-Google-Smtp-Source: AGHT+IF4GDJ3YCBthdF2kNICG5VcbAydXl/7tuwTSsJfKLK/6jg9unoYSABMxgz+vRm4fQ7nAog7xA==
X-Received: by 2002:a05:6a00:94d6:b0:7ba:153f:5a40 with SMTP id d2e1a72fcca58-7ba39dda733mr18093315b3a.9.1763500312673;
        Tue, 18 Nov 2025 13:11:52 -0800 (PST)
Received: from localhost ([2a03:2880:ff:44::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7b927151d38sm17341055b3a.40.2025.11.18.13.11.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Nov 2025 13:11:52 -0800 (PST)
From: Joanne Koong <joannelkoong@gmail.com>
To: brauner@kernel.org
Cc: djwong@kernel.org,
	hch@infradead.org,
	linux-fsdevel@vger.kernel.org,
	willy@infradead.org,
	Christoph Hellwig <hch@lst.de>
Subject: [PATCH v2 1/1] iomap: fix iomap_read_end() for already uptodate folios
Date: Tue, 18 Nov 2025 13:11:11 -0800
Message-ID: <20251118211111.1027272-2-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251118211111.1027272-1-joannelkoong@gmail.com>
References: <20251118211111.1027272-1-joannelkoong@gmail.com>
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
Reported-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Tested-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/iomap/buffered-io.c | 37 +++++++++++++++++++------------------
 1 file changed, 19 insertions(+), 18 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 0475d949e5a0..c3e73203809d 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -459,25 +459,26 @@ static void iomap_read_end(struct folio *folio, size_t bytes_submitted)
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
+		ifs->read_bytes_pending -=
+			(folio_size(folio) + 1 - bytes_submitted);
+
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


