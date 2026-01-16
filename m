Return-Path: <linux-fsdevel+bounces-74241-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 03CA4D3879B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jan 2026 21:34:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C4004301D971
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jan 2026 20:34:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 170A7296BB7;
	Fri, 16 Jan 2026 20:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jfhrfm6I"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A46342049
	for <linux-fsdevel@vger.kernel.org>; Fri, 16 Jan 2026 20:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768595644; cv=none; b=lEgq5bedUcu6OW9U4X67XylKf5kyhVX+IjSQt9aaxU4EN9P0veJs+4mmlvnhzE1TBs5jXOpIHpv9LQa6ZBAvAsoOKLiN7LpBc/38/kjWDWFeoDvBYplMibmXz7FQgFuxGK1Asb3RPkr7tB69SXFlvsyyFHXJG5Ke12aqPeuuhbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768595644; c=relaxed/simple;
	bh=BsBQN+Ios4Y89dqC5BjR8hgch1jxby5WSXZqBcSQDJM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AIfgkWmybUMuRsKYo+6C9N/t+elP2kIGC+1L54d2gZrPHSMxixUpeLm0LoNF+BnuDEGCGJSdTZgIArnlFxgtz3TidXyk79hUhZIlf8mGl2aLrqptYTdl5fwjQ4aizfkZ0D16+620mhmX/y2sA/AChka6XS0j1rFdzwcT5CVhk/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jfhrfm6I; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-81e98a1f55eso1291564b3a.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 16 Jan 2026 12:34:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768595643; x=1769200443; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=U5ZjuNMNK+XBHMn8ib3k1M/0uwZwGvAP9gMnJv4IuvA=;
        b=Jfhrfm6I+sGQbwwzdR++N5avWua0LtGqGUU5iujrPaKMVGLr9JnnvODdp5b4bl7fst
         cvQqkjPyMOjyOkTe6XP45ELng4skvI3O60Q/RepH2qpZBcAEBQVrjap2NPr+R7zRIgqn
         T6OFLjjDeSI+D+5ici8ouTGMClucZZy85KhJW45AoTfdVbCufiLpyZotXNTwnyXPIppv
         7MzLh3wV5tI2mASVLyASDTaP5IvgaVYDjmZL6bFjWDDHqkhT4T0bd3BM6h1XEYTVKebL
         V7F6YvymOU6wO/spMvUEzU2D9DNzTrfXEcr35A+nm1GAan+pP7V73CFx2l91UHHB4j8R
         iBHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768595643; x=1769200443;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U5ZjuNMNK+XBHMn8ib3k1M/0uwZwGvAP9gMnJv4IuvA=;
        b=VSOsdhtNtyyixico2sw66IxWkWYRtYIbQTJ0yRHXJNoHgxl93RG/bz59S7QxxkZMUL
         dSXgRdWL1a+nlgNPjMDu9uOzWqtSrrOgYJv/BKcPmg/vL5mb5U6bzzOWzw7A92u/0tAE
         Q6PLjVioxD7mKTQRgYC0Hk9wykfeszAhJC0Z5eYgVr1tKzCwcQaAvgmtwZtSf/f3/rxr
         sCCpZTip+M69j8b8SY6BUR07djHEeEFm8dBKevAFnQEpI4uWZNNdlXX7zn+qGmkglNMJ
         aM6NEqhc8Lpjkg/2thmZdKlnIdmQlzBRNeAOqejIGLVxPMZ3ZsdimM2qyl2GRCl+zSSL
         1RKg==
X-Forwarded-Encrypted: i=1; AJvYcCXMpL/ukebJi682S4brcZou9GQdCzcd7wDSRNzghTpxtka9RdbrVOaPQf6vr8/oArTMU0qoEnBPbZV4ihF2@vger.kernel.org
X-Gm-Message-State: AOJu0YzM3MDkwaCOMWyyfvJ4hKf/KVlWB2Lf3aLYmFbbzn/iOn8cpEeF
	47W5dpMEc04ihQhPCj5qh6bDfRTkPYJw9ZBbMRH0VllV+X5zrWLdC8S5
X-Gm-Gg: AY/fxX4uuT+ln/YiJmUSCuBlfGDJz6lUPrRMUZSaenPrJBtx8Bj7o7c13joWk3iRe75
	1inApev9ytXoXhV6hvcjV1l4Otg7QvGGiriP7Pl/MakUVK5m1yymZHLQoigEyRpgvtF/xABcCoR
	D4tXC1c+2EL1EAIDNEVPF1P28LauNQF1T5pMnu8z2yqaRKS8Tzb28RJBs/6VyJEoJvMtX2LJEqZ
	xJDruH2WcBYI/CW7V3nFBRCokbVzOwGNir77wgSQrtsXI1DDgrbBShkEyJeli6aRRcvqm5YksqM
	xvkqkiNAteqAp2hhEe9MK5IQ7qdNm5z3oiGPmAcvXF7LfZQexGkK4X/I7hQLElhUWXKKtUgxcGU
	rpvlqjlgr45i7ALquT4xawOlV43O1mWS43OARVa0kZ0EbFO2m6QiIrvFitpHws7i3Kumb5M+2pF
	ySTtekOg==
X-Received: by 2002:a05:6a20:d495:b0:366:14ac:8c75 with SMTP id adf61e73a8af0-38e00da9dd1mr3691218637.75.1768595642554;
        Fri, 16 Jan 2026 12:34:02 -0800 (PST)
Received: from localhost ([2a03:2880:ff:16::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-352677c90easm5255084a91.4.2026.01.16.12.34.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jan 2026 12:34:01 -0800 (PST)
From: Joanne Koong <joannelkoong@gmail.com>
To: brauner@kernel.org
Cc: willy@infradead.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH] pagemap: Remove __readahead_folio()
Date: Fri, 16 Jan 2026 12:31:46 -0800
Message-ID: <20260116203146.1578562-1-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 4ea907108a5c ("fuse: use iomap for readahead") removed the only
external user of __readahead_folio().

__readahead_folio() can be removed, with the logic in it subsumed into
the main readahead_folio() function.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
---
 include/linux/pagemap.h | 25 +++++++++----------------
 1 file changed, 9 insertions(+), 16 deletions(-)

diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index 31a848485ad9..cde854c12642 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -1419,7 +1419,15 @@ void page_cache_async_readahead(struct address_space *mapping,
 	page_cache_async_ra(&ractl, folio, req_count);
 }
 
-static inline struct folio *__readahead_folio(struct readahead_control *ractl)
+/**
+ * readahead_folio - Get the next folio to read.
+ * @ractl: The current readahead request.
+ *
+ * Context: The folio is locked.  The caller should unlock the folio once
+ * all I/O to that folio has completed.
+ * Return: A pointer to the next folio, or %NULL if we are done.
+ */
+static inline struct folio *readahead_folio(struct readahead_control *ractl)
 {
 	struct folio *folio;
 
@@ -1436,21 +1444,6 @@ static inline struct folio *__readahead_folio(struct readahead_control *ractl)
 	VM_BUG_ON_FOLIO(!folio_test_locked(folio), folio);
 	ractl->_batch_count = folio_nr_pages(folio);
 
-	return folio;
-}
-
-/**
- * readahead_folio - Get the next folio to read.
- * @ractl: The current readahead request.
- *
- * Context: The folio is locked.  The caller should unlock the folio once
- * all I/O to that folio has completed.
- * Return: A pointer to the next folio, or %NULL if we are done.
- */
-static inline struct folio *readahead_folio(struct readahead_control *ractl)
-{
-	struct folio *folio = __readahead_folio(ractl);
-
 	if (folio)
 		folio_put(folio);
 	return folio;
-- 
2.47.3


