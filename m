Return-Path: <linux-fsdevel+bounces-65948-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93CF3C1668F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Oct 2025 19:14:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F339C3B006D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Oct 2025 18:14:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3409C34F241;
	Tue, 28 Oct 2025 18:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AqonL6hR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D7B830B501
	for <linux-fsdevel@vger.kernel.org>; Tue, 28 Oct 2025 18:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761675104; cv=none; b=UrVNuKZmfl0siI3me1KDKpUtCDTSRh5fI+ZS18uRDJmxNp/wZKxyJz/GH9FWgfjeOBqdNLw8gElBiAf00T9I/74CV8OnSvy2N7Ec5DooNySnMKbahbwHRdTgrzTe+g3kFCTrPHZWnITU//AWpH6bosyU7NOPIi5dX5i9/7VE224=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761675104; c=relaxed/simple;
	bh=zLH7EYhjLIWXNWL+X25TVB/im5y0W/24yvLdT0pCoqQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NXxc5+1U63qE6Js4Sm3IWZUu0/3FM4/7X1BYWrcqXxM+QhEvhh3KLnvsfXKmdyVmnLxaUqSv1heVc7XM2cpblCV252O7fx0xJBcUCtqwaCwJI05XeagfExbWvPYpTl24cLT/pV8s6FwPnR+xJ/EcknZe9WELZW/+OyuD68lXP4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AqonL6hR; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-7811a02316bso4632733b3a.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Oct 2025 11:11:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761675102; x=1762279902; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ix/euiCYVfNzssNXJhKzggPmv9cyU60qB3vzDeKf/LQ=;
        b=AqonL6hRicLJxQ219Q+KASqXD6IULagFZDdymBQGNfkr5A8ZhfACtfEeq23w3SeHrP
         P4K3Nb1rHVArS42K9vYHzFzbIYkakFz7NmZG+2q94rvCOMYmE43kFDrQDs3sOA3o2KHP
         sdzPFSa87pgvs+Kqm5uQnlzSok1rrBuFycLppaGTo0ttzGiwiFwZ7C/hjQbluz/TpvGr
         87uZ6HS2q+kr46xJQYIuh7kz//yfmVp3Cyt4iIdblCzhjywrbhH8Mu8ubZYcABb/Zj3u
         snVUL5qNQTPMKMWxdpkIQ2nm+fEHeLWgMWjvYQZHXaW979zSMPK4Km/ag+S1CGIggXAd
         fYmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761675102; x=1762279902;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ix/euiCYVfNzssNXJhKzggPmv9cyU60qB3vzDeKf/LQ=;
        b=qPzLD4MCedAHhT4IHllo3yjxviMooCo99X4qOqtUmSXHcgw/236XYvtK9alydn7Kn3
         oMd4QHbJKevOteteJYHqpNaviBixd3/Y5QagkWoUKyFh8WHNTXiMiC464fjMIO1vdXH1
         fSSMzg4q8vSfEkvSHR2+bFf/iWqX/+1HwwPaRJYzBfg8pXwhfzEeqzKL7BAftjdL2aDu
         s+1ZIx2xPn0yC3SoJ9tEjFnI5EkWgjBQrReqTFPlHH318k/JQ7jYFj5YTQN4+XYBDQuv
         M1uabmdazOzldlRneJxjoW5E9Fwt2L68jqSdWIjP2TiqUXi8RGhWdKSCkR+KVXRWgCcq
         wNHQ==
X-Forwarded-Encrypted: i=1; AJvYcCU501CoP3KU3FS+ymKh64XWaHvzBees4CUoTO7xvy85sdYxq//J5JhA4sj0wVmor2yO+o/x15TEkQqmvATp@vger.kernel.org
X-Gm-Message-State: AOJu0YwQb+W8mxOPsTF3Tm9/a2fUHuyiTbplRW+YJhF1VMybZZgY4KGS
	rRrgc7Jx9E45VsjcvTUDmomqGPzO8X7+hZ9qyC++LJ8ylMMTY2Vou2yZ
X-Gm-Gg: ASbGncvqjNgX0VtGOa865z5nBM9b80B+mraOsFxbb7+wtXgBV/Pu/+kzQU7Ctcttzni
	3PmnzUhgvIrso40pVQcObeMDUrQTD04X95g4NwEFHGTtycK9dZ+BU/LmG1CFpxaS8AYFy6ZOrnL
	jphnxNEuhk7zI7g3lO2pB1jB6b96VIxQUJe78sYoMcLL9ZGGHDPp3iUXYXrZj8Dnu2wgu11sc4B
	j3Sbe9UROj01VKU33LlQTcJCGuCTND4GDPXxiOdEyWYMnhNXmYJbFFlZnDsVVTeIH036EuSZopS
	QicCATr6s0vuw1KGt2ErlrFOjR95hPjrZau2ox++QofUqb3JpRQwo5HfhDKxx4g4LXnOJSeDKV8
	OaRJcVVAX8T9fIgz+0AxmuJwbDuhvklGnQconeHzIKZDerRFa4TgMwJktjtsNRNsCkFYcld0gVl
	3xxdTyeOslFO2yu2MxH4qWosWn/js=
X-Google-Smtp-Source: AGHT+IFEtokJ6CR5d+Cact2FVh9K6xZdQMhocC4OmRhn9/UB6eeNydZTTMo8MlvOpXc+BdVoyhLZ8Q==
X-Received: by 2002:a17:902:e802:b0:290:a32b:9095 with SMTP id d9443c01a7336-294deef68f1mr945685ad.54.1761675102235;
        Tue, 28 Oct 2025 11:11:42 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:4f::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498e41700sm123433105ad.95.2025.10.28.11.11.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Oct 2025 11:11:41 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: brauner@kernel.org
Cc: bfoster@redhat.com,
	hch@infradead.org,
	djwong@kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v3 2/2] iomap: fix race when reading in all bytes of a folio
Date: Tue, 28 Oct 2025 11:11:33 -0700
Message-ID: <20251028181133.1285219-3-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251028181133.1285219-1-joannelkoong@gmail.com>
References: <20251028181133.1285219-1-joannelkoong@gmail.com>
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

Fix this by adding a +1 bias when doing the initialization for
ifs->read_bytes_pending. The bias will be subtracted in
iomap_read_end(). This ensures the folio is locked when
iomap_read_end() is called, even if the IO helper has finished reading
in the entire folio.

Additionally, add some comments to clarify how this logic works.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
Fixes: 51311f045375 ("iomap: track pending read bytes more optimally")
Reported-by: Brian Foster <bfoster@redhat.com>
---
 fs/iomap/buffered-io.c | 39 +++++++++++++++++++++++++++++++++++++--
 1 file changed, 37 insertions(+), 2 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 4c0d66612a67..5d6c578338dd 100644
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
+		 * add a +1 bias. We'll subtract the bias and any uptodate/zeroed
+		 * ranges that did not require IO in iomap_read_end() after we're
+		 * done processing the folio.
+		 *
+		 * We do this because otherwise, we would have to increment
+		 * ifs->read_bytes_pending every time a range in the folio needs
+		 * to be read in, which can get expensive since the spinlock
+		 * needs to be held whenever modifying ifs->read_bytes_pending.
+		 *
+		 * We add the bias to ensure the folio is still locked when
+		 * iomap_read_end() is called, even if the IO helper has already
+		 * finished reading in the entire folio.
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
 static void iomap_read_end(struct folio *folio, size_t bytes_submitted)
 {
 	struct iomap_folio_state *ifs;
@@ -381,7 +411,12 @@ static void iomap_read_end(struct folio *folio, size_t bytes_submitted)
 	ifs = folio->private;
 	if (ifs) {
 		bool end_read, uptodate;
-		size_t bytes_not_submitted = folio_size(folio) -
+		/*
+		 * Subtract any bytes that were initially accounted to
+		 * read_bytes_pending but skipped for IO.
+		 * The +1 accounts for the bias we added in iomap_read_init().
+		 */
+		size_t bytes_not_submitted = folio_size(folio) + 1 -
 				bytes_submitted;
 
 		spin_lock_irq(&ifs->state_lock);
-- 
2.47.3


