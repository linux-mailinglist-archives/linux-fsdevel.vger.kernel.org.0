Return-Path: <linux-fsdevel+bounces-65752-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B0CFCC0FDF6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Oct 2025 19:15:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A37E619A5607
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Oct 2025 18:16:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8F4D2D5925;
	Mon, 27 Oct 2025 18:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LiOkil6K"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B415229E11B
	for <linux-fsdevel@vger.kernel.org>; Mon, 27 Oct 2025 18:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761588934; cv=none; b=VbMTN7IHmdSDsib7yUm5F9YQRTq8ASpdznHfRw7ZA7zpcPI+C3AsqqiXiLGz3CQo9ST3oorHjf4Mtkk3V6fLGuLqUdWo0Ji8rRRXqlTF8Xp6Is4TYEu+DNN00dxunewrTnm7ZAf19Dr0FTwc2NNe7jr8sPyd09vJfoXu/sjX8HY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761588934; c=relaxed/simple;
	bh=qf5mZXRJB/Ml/ez4I77Xj9dNkrjjc3K/ZQL94A4HegM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hG3JDlz1m5pJAORFv3YyKvY0hfsYktJsatwZT3B2JBj+hSQk8e1bwRm9SVIzUyMni2NyxBUWHG+SW9dK4V2Q1PuPBV7mDfIiwYMjcVm0pCDD7yAfj9681eUW9TP4V+FqbSki99bulBdHEuO2tUiTk1wdf9d20ICPTuYoQu2jxD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LiOkil6K; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-7a26ea3bf76so6644758b3a.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 27 Oct 2025 11:15:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761588932; x=1762193732; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VtUaZrhL/bfjDk0nNCKdG5tI+MxsmiHujIMbttxPGKw=;
        b=LiOkil6KHR0IC6sjMt6mheUjln/z3P1OjYf27LScP+j8A8lNPZcK6j6WcjjX2NHZPG
         3n69TcUwe87JDSNCUaQNV/TMY4EqxaopeNk5Ggat7+yaVIsqrW6iIlKsvXW9kMw0WG9n
         9zUQNDJRl1oF/jrot67YrRES9tzp3qMzsd8BnxQICbq3H7CSiD61Yc+yfFFbcMxHfSW8
         aZtm0FHL1qvjHzskstOWqJKwOjgT2S73zV6k7qFrw3r+U2KfYnvH1P0+W4t3UX5063d4
         1/Cg/EzxT25Dh5Rj3I1zKtydcy0G+qsVJUvpytKoUgsitqw+K4JW+iMWOc6N9iVbuHEV
         OaTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761588932; x=1762193732;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VtUaZrhL/bfjDk0nNCKdG5tI+MxsmiHujIMbttxPGKw=;
        b=NqHY/LNJsfbiOXygG6mWDl7+iaaCUaVzDnRHd2iKyf0Rguu0ADcVtOEONe0TprO8Z+
         E9kLsKeQdFLNSb9cQeEvMthjBMsNoB9HkbDKfAgLNp2MhBSzMqqeCIc2frZPKNhddRWC
         v/TUpzlsE7c2tcYT6x9BAyYtHkuQeQO6NLMVGFuP6HAl+nb76WZJG4SKjwEkV+3JiKP2
         UR5gQRSan8GSiD6liWxoKTkQkNik3x1g98jTOtAViFWRMoK00gtS4mPR+tay4QGE4JV9
         OZYeNAccVjNP83wOx8V+nnSvStk7kqzRHkccg5yQrHP+GdKmdp4xIVxBs9LFyXNQ8vF9
         LoHA==
X-Forwarded-Encrypted: i=1; AJvYcCUW4VzkN9WcEUwDBz7SPzFToFIvcpiIvjinKBvcTUuRj6Mt8WkX8/qFe/Lhg4as3RQpNrSrpL9CS+Mo6rWj@vger.kernel.org
X-Gm-Message-State: AOJu0YzN18TBZA5pFbD7oucJKqeRdGZXvKO6vhXsxfBPVFn15YqjZOo2
	wk6buYgY+LcJMP6EXhNxx/J2PhjZoH6+AxGNNcnl4ucaSNspisN4q/qq
X-Gm-Gg: ASbGnctJ2w63xxdDv2dwOhwn6GZUZsSF+Qupp9U8/8XPXpAxCPIEpjGWmlVVg9NJxhQ
	VGBPVdfkdOp1Tn/23YayD/xaNNJqweP6cE4LBvtXw+QbspKRAGn3MeZpl6u0FfvtpyVUdttK+IY
	cROnKDyL634BazNQFUoShF57O0uWJX9TZnNff8mzlMeIwG7SWhBeqYZ+Dq10GRlsaM7FZO5NjbY
	dPCStJJbQCtCBopgsL9fKIx2oP4la9HRYEUHa1fT8++LBb8vwaux7mrH3c+MzraM0xhL7IT8Ys1
	na6NR1yI70f6xxNSvbk5yoDkrz7W32gndrNrAD3YSXX9YmQXo0Bx4nhvpsHRLgytqVVo6oAiWly
	94x/PORQ0JOO1TzKeM2hoChadxIuHOOBy1PjXSIooBAG5a/QA208gJsSlpwKujaIXPImrGziDYH
	P6sbGSrmBrKBBU18I+OC4INf+YgdOGItmgcOBEtQ==
X-Google-Smtp-Source: AGHT+IGZ0U8B1F1i0hfqsUO2ZEiom6fQEhM/HOacE0WFyICjUEsvbzSnum3cX5y4ZIoP3qDLDLGPPQ==
X-Received: by 2002:a17:902:e845:b0:293:623:3246 with SMTP id d9443c01a7336-294cb3944e0mr8166645ad.13.1761588931630;
        Mon, 27 Oct 2025 11:15:31 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:4a::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498d0ac07sm89490835ad.43.2025.10.27.11.15.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Oct 2025 11:15:31 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: brauner@kernel.org
Cc: bfoster@redhat.com,
	hch@infradead.org,
	djwong@kernel.org,
	linux-fsdevel@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>
Subject: [PATCH v2 2/2] iomap: fix race when reading in all bytes of a folio
Date: Mon, 27 Oct 2025 11:12:45 -0700
Message-ID: <20251027181245.2657535-3-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251027181245.2657535-1-joannelkoong@gmail.com>
References: <20251027181245.2657535-1-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is a race where if all bytes in a folio need to get read in and
the filesystem finishes reading the bytes in before the call to
iomap_read_end(), then bytes_not_submitted in iomap_read_end() will be 0
and the following "ifs->read_bytes_pending -= bytes_not_submitted" will
also be 0 which will trigger an extra folio_end_read() call. This extra
folio_end_read() unlocks the folio for the 2nd time, which sets the lock
bit on the folio, resulting in a permanent lockup.

Fix this by returning from iomap_read_end() early if all bytes are read
in by the filesystem.

Additionally, add some comments to clarify how this logic works.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
Fixes: 51311f045375 ("iomap: track pending read bytes more optimally")
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reported-by: Brian Foster <bfoster@redhat.com>
---
 fs/iomap/buffered-io.c | 37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 4c0d66612a67..654c10a63dc1 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -358,12 +358,37 @@ static void iomap_read_init(struct folio *folio)
 	if (ifs) {
 		size_t len = folio_size(folio);
 
+		/*
+		 * ifs->read_bytes_pending is used to track how many bytes are
+		 * read in asynchronously by the IO helper. We need to track
+		 * this so that we can know when the IO helper has finished
+		 * reading in all the necessary ranges of the folio and can end
+		 * the read.
+		 *
+		 * Increase ->read_bytes_pending by the folio size to start.
+		 * We'll subtract uptodate/zeroed ranges that did not require
+		 * IO in iomap_read_end() after we're done processing the folio.
+		 * We do this because otherwise, we would have to increment
+		 * ifs->read_bytes_pending every time a range in the folio needs
+		 * to be read in, which can get expensive since the spinlock
+		 * needs to be held whenever modifying ifs->read_bytes_pending.
+		 */
 		spin_lock_irq(&ifs->state_lock);
 		ifs->read_bytes_pending += len;
 		spin_unlock_irq(&ifs->state_lock);
 	}
 }
 
+/*
+ * This ends IO if no bytes were submitted to an IO helper.
+ *
+ * If all bytes were submitted to the IO helper then the IO helper is
+ * responsible for ending IO.
+ *
+ * Otherwise, this calibrates ifs->read_bytes_pending to represent only the
+ * submitted bytes (see comment in iomap_read_init()). If the IO helper has
+ * already finished reading in all the submitted bytes, then this will end IO.
+ */
 static void iomap_read_end(struct folio *folio, size_t bytes_submitted)
 {
 	struct iomap_folio_state *ifs;
@@ -381,9 +406,21 @@ static void iomap_read_end(struct folio *folio, size_t bytes_submitted)
 	ifs = folio->private;
 	if (ifs) {
 		bool end_read, uptodate;
+		/*
+		 * Subtract any bytes that were initially accounted to
+		 * read_bytes_pending but skipped for IO.
+		 */
 		size_t bytes_not_submitted = folio_size(folio) -
 				bytes_submitted;
 
+		/*
+		 * If all bytes were submitted for IO then we're done, as the
+		 * IO helper will handle everything in their call(s) to
+		 * iomap_finish_folio_read().
+		 */
+		if (!bytes_not_submitted)
+			return;
+
 		spin_lock_irq(&ifs->state_lock);
 		ifs->read_bytes_pending -= bytes_not_submitted;
 		/*
-- 
2.47.3


