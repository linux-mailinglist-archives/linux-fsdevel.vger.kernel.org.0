Return-Path: <linux-fsdevel+bounces-66633-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 15D9CC26FCA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Oct 2025 22:13:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E3C71891629
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Oct 2025 21:13:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87A7D2F6169;
	Fri, 31 Oct 2025 21:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DJFqceMv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yx1-f52.google.com (mail-yx1-f52.google.com [74.125.224.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BC1D2F068A
	for <linux-fsdevel@vger.kernel.org>; Fri, 31 Oct 2025 21:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761945203; cv=none; b=mHdXy7r4y5DxF73KI1gaxowbiIwyN+U8PX1kOu9zpilXcGzA3b8BKUD+OAlDJzpfYHoQtrFZU63JQMhlqIf5xOWew/IsPtlbZqFSILrNYqbBz1a5lm6+r3oOlPPhPEj8RAvxR5wd5Kl43QeCzKFw25r+78NtAcCyVN/VKO8cCe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761945203; c=relaxed/simple;
	bh=Iu+heLrtt7XqBcLOOulCkg+etade3i2VCoY1icYzymc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rbinqWc1px6NeDnmwlmzHaM6ZdjcdlkD/732yrrhv7XyOsOnQIeACi5reZZ4eOieqjZ5ctmkvAxkMWrnvbUls7s+fedroUd0IT3yDjGPW7G+pXGTii9jmcGeBvF46vBs0TrGDi9UuXNqMgcuExcGPR24IErOuBpSGwBrCBkUj2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DJFqceMv; arc=none smtp.client-ip=74.125.224.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f52.google.com with SMTP id 956f58d0204a3-63f9beb26f7so814142d50.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 31 Oct 2025 14:13:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761945200; x=1762550000; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+AMapyyvG3yQttq6v2teK9nhMRhuFy71wrBOU0etvzk=;
        b=DJFqceMvEjxT7kxQgY+KLiCY9dskvEeeUG8Zp3QjZfTeHXPg+73qF5VQrMs/rTlypz
         ec9tRoRLJJPKLawpjrVi07mm/N1QyKlwbQBxva9meuKmPc9X8tnLbSwBWCknqsyzHE7p
         uY8Lxnf+yqkQCoQqhkQeuzd1I/+BSduh/Mhd+hSTvZ0EwR62Pt9Jv6x5RDn5EyYP7Pqa
         Gpmfas9xHkkgUpn6iCP9+x4S4SEYydead6SiGv/S3vN3K9Z17JMwd2cjL8PBHPisKlID
         mchGdwq1IK7iuyTZuf5k7d9gFfg6xhx/YRnFEKaibveg9EE8nQdtarZZhzlPyoQPgmWH
         9VCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761945200; x=1762550000;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+AMapyyvG3yQttq6v2teK9nhMRhuFy71wrBOU0etvzk=;
        b=YG51p2A/S3YiUpoFbx9WGUG/LqXdRyfDXrXl271MFXtWwUiaz5XLKz6VN+Q/IfLpkU
         zZ3hJmuq0g66M6ot+7ul5X3KY93xp6SxqRtdwemv4IBOQMAvxs2WV/Pk0Z+OVDNerBu6
         HMfIDwCJfEIqcBbNTjSGWrwi1xk8Q4XJM2hzYcmq2fEk7W7huLFJlOeMgNeiQQS08A3Q
         Etw86zP0+D7Ew3awMnx74jjUWVNlunkD+7A2shuaBH6ON49EE1bEujXnuzcHc/sIk3vx
         Q7nll+c1XT1if8rwbqZpZ8J9/BODStq83CpZJVL8WZvzmbMYkLAp8O6b6H6W7EdM36MM
         4SFQ==
X-Forwarded-Encrypted: i=1; AJvYcCXtuH3okFXIezwOc9eebq7p/vi/OtG18Q9KZpHmINGzT3LssznKpBLdC6hynkDfX5ftxxAimKS/mUqEgejW@vger.kernel.org
X-Gm-Message-State: AOJu0YwUvny19rwETwpTybBMIGBfFZm5Pom7Nl5jdda9YKQOS+D+25SB
	jW1mMY8TVf2CWmBU9+pVXjOJPrMR8R/CCw3H6ES2+KNVneKKmbEGGlWF
X-Gm-Gg: ASbGncvfokylr3FuXa8EK6T4hIYFBC1V05zgfXSq/q7irQcPbq8z5JLbn/taJfhPF+D
	aav9AsHy4meyVYa81136Ctb5s3cHXBZOjHEUngYgN8ryolx+veEBZWn6SrD4z0FCzSoXuaExq1/
	4s1Q7+pE4jKvb0cI7yajc/k+2m97MOIOmMCxRTmypd8psrWZvF1bR+14odcQSl8Vm0JYLmy/I9i
	0/wGRJBsvf4/zGXGrg9XVirTlyPh0nhAvWKOWsGxOo5j4O4lQzPBbxYOZIOts4Ity+fnqGdZ7/X
	cJN+d8gxeURmohDzT1CrWPnIr6D4hFPg/iXraOhOiRUt/4cFVTxIWW7fumZWUdtRUx+AOxchQBU
	T14Q3tIIqYH7cQpapRCuyfn/bou9H+GPQqFrFwaLFeczqedPBW9O2rxFa6ZeO8r4kStXEsz2ZMI
	WDqPXXb1nAyMgtJHsujwDE6rvvF8fe
X-Google-Smtp-Source: AGHT+IFLmSJyFrolT19Dl9bMpiEZzTR0VFIqMc5oK6i/3j68dVDFcsfnSfuKqfegmZ9D7vgzfzXbdg==
X-Received: by 2002:a05:690c:4c13:b0:783:796c:c1a8 with SMTP id 00721157ae682-786484dfac9mr76420087b3.39.1761945200118;
        Fri, 31 Oct 2025 14:13:20 -0700 (PDT)
Received: from localhost ([2a03:2880:21ff:2::])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-63f96a7b556sm792188d50.22.2025.10.31.14.13.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Oct 2025 14:13:19 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: brauner@kernel.org
Cc: bfoster@redhat.com,
	hch@infradead.org,
	djwong@kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v4 1/1] iomap: fix race when reading in all bytes of a folio
Date: Fri, 31 Oct 2025 14:13:09 -0700
Message-ID: <20251031211309.1774819-2-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251031211309.1774819-1-joannelkoong@gmail.com>
References: <20251031211309.1774819-1-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is a race where if all bytes in a folio need to get read in and
the filesystem finishes reading the bytes in before the call to
iomap_read_end(), then bytes_accounted in iomap_read_end() will be 0 and
the following "ifs->read_bytes_pending -= bytes_accounted" will aslo be
which will trigger an extra folio_end_read() call. This extra
folio_end_read() unlocks the folio for the 2nd time, which sets the lock
bit on the folio, resulting in a permanent lockup.

Fix this by adding a +1 bias when doing the initialization for
ifs->read_bytes_pending. The bias will be subtracted in
iomap_read_end(). This ensures the read has not been ended on the folio
when iomap_read_end() is called, even if the IO helper has finished
reading in the entire folio.

Additionally, add some comments to clarify how this logic works.

Fixes: 51311f045375 ("iomap: track pending read bytes more optimally")
Reported-by: Brian Foster <bfoster@redhat.com>
Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
---
 fs/iomap/buffered-io.c | 40 ++++++++++++++++++++++++++++++++++++++--
 1 file changed, 38 insertions(+), 2 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 36ee3290669a..6ae031ac8058 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -358,12 +358,42 @@ static void iomap_read_init(struct folio *folio)
 	if (ifs) {
 		size_t len = folio_size(folio);
 
+		/*
+		 * ifs->read_bytes_pending is used to track how many bytes are
+		 * read in asynchronously by the IO helper. We need to track
+		 * this so that we can know when the IO helper has finished
+		 * reading in all the necessary ranges of the folio and can end
+		 * the read.
+		 *
+		 * Increase ->read_bytes_pending by the folio size to start, and
+		 * add a +1 bias. We'll subtract the bias and any uptodate /
+		 * zeroed ranges that did not require IO in iomap_read_end()
+		 * after we're done processing the folio.
+		 *
+		 * We do this because otherwise, we would have to increment
+		 * ifs->read_bytes_pending every time a range in the folio needs
+		 * to be read in, which can get expensive since the spinlock
+		 * needs to be held whenever modifying ifs->read_bytes_pending.
+		 *
+		 * We add the bias to ensure the read has not been ended on the
+		 * folio when iomap_read_end() is called, even if the IO helper
+		 * has already finished reading in the entire folio.
+		 */
 		spin_lock_irq(&ifs->state_lock);
-		ifs->read_bytes_pending += len;
+		ifs->read_bytes_pending += len + 1;
 		spin_unlock_irq(&ifs->state_lock);
 	}
 }
 
+/*
+ * This ends IO if no bytes were submitted to an IO helper.
+ *
+ * Otherwise, this calibrates ifs->read_bytes_pending to represent only the
+ * submitted bytes (see comment in iomap_read_init()). If all bytes submitted
+ * have already been completed by the IO helper, then this will end the read.
+ * Else the IO helper will end the read after all submitted ranges have been
+ * read.
+ */
 static void iomap_read_end(struct folio *folio, size_t bytes_pending)
 {
 	struct iomap_folio_state *ifs;
@@ -381,7 +411,13 @@ static void iomap_read_end(struct folio *folio, size_t bytes_pending)
 	ifs = folio->private;
 	if (ifs) {
 		bool end_read, uptodate;
-		size_t bytes_accounted = folio_size(folio) - bytes_pending;
+		/*
+		 * Subtract any bytes that were initially accounted to
+		 * read_bytes_pending but skipped for IO.
+		 * The +1 accounts for the bias we added in iomap_read_init().
+		 */
+		size_t bytes_accounted = folio_size(folio) + 1 -
+				bytes_pending;
 
 		spin_lock_irq(&ifs->state_lock);
 		ifs->read_bytes_pending -= bytes_accounted;
-- 
2.47.3


