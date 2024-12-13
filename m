Return-Path: <linux-fsdevel+bounces-37336-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D44A09F119F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Dec 2024 16:59:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B514E1885985
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Dec 2024 15:58:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A16AA1EF0B0;
	Fri, 13 Dec 2024 15:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="VY3watQ2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91A081EE00F
	for <linux-fsdevel@vger.kernel.org>; Fri, 13 Dec 2024 15:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734105378; cv=none; b=g+zmbhz/gOqi7EHhl4EulK6VpSyAYlQX9yEiZ2DMepgQLUF4bNNLKfdvBLR7zD/tFLj2yWu5rgA98N/4WM4UdGlghl+5g7E0Zx5pq3hqh4xJDH2QlgvY8RM/Uj1JmSYJRcDkpnPJWCR8RGtkl0Ru6E2rbWMYJbQ3wjnNVWaeiTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734105378; c=relaxed/simple;
	bh=ZeMsDsphln50o1XFtLmHIP6lHmPNtmzQzlZFWxh1ZaQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cbS5wY7hBKZQ5/RCFnkJ+xjAs2BEmGOpGdu7zMehtCDoQRzP8L6/tIRowc/KwLgMcuUwfQ7ip58Bs0ezpTtfMj4iXZLBSCVWRREI3CBX/HN1aMtVOlqWg3sL2s+NF1FSGBu7u5mnbBG5tgYKXJYA8C7Lbdf8bBe1OraOOVg1i4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=VY3watQ2; arc=none smtp.client-ip=209.85.166.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f170.google.com with SMTP id e9e14a558f8ab-3a9cb8460f7so14039715ab.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 13 Dec 2024 07:56:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1734105376; x=1734710176; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eL7TH1+psm5CeVquxo+D9Ecvv3+RlpadAVoxegN1mFk=;
        b=VY3watQ2NR6jGnPZ6XQYSClGFKgxvsCoMHMZGD/dDEHNkXkum2+pHmho6aFmqJhf6h
         ehfSPV74UjBpmV85H8x0IbLd8VJCG2oLkYJctyquH7XYpePbvIZT5Vcyf6Rkm8Uw4LAH
         i25IJI0J1mFgRzMLo8fVstBkRzjnfxZCzu2PYl0pyTsNIBYlhMYqRwk1djlTCgWzZ6rk
         sFyMW/rBmnfw0yeawjS3wohXuRO/BKMJrRQqNaO+I0/ksVNiK9MKc/E4ofzGy5oAiuwO
         tHaCZKxU0TbTHUwDSt8rceIU2ttCHKamjds4J9/M3DRYMIlOljSUYiaUADvvqBbJMUZy
         sySA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734105376; x=1734710176;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eL7TH1+psm5CeVquxo+D9Ecvv3+RlpadAVoxegN1mFk=;
        b=kDm3KkeCqeLTEv3NUSvq5to9fNiykKEdcl1qWEolJxIAv6TWkmFNYGDv3zKjTcKKNc
         nwH0MSoRu46d5DMbz5WBVw8HXz2xpYeMgQsC4lfTVGO2BqmPO75KFYmsWh1l+4MUP3BC
         5+GN053mYyMBYb+HqhxhJ94AcLO49m+31tHYebhsQuE7YAVkhsKazg81RBIYAFCREYbI
         bEnfXFobgajqA4uBjtHA+RoeTIg4lhaS5FBIujRYyjAPRdH1ot7I/e3I0VipbECfpJf4
         h/X6yRh3bly1hseLACBPaNjl1FsjthN+iX46u6FdcZ9XImwxbCAO4AwcxGHv0p3K9RA1
         X/Xg==
X-Forwarded-Encrypted: i=1; AJvYcCUASonfxQVyQIFcAo0alOsw5yPDNTK6YweBVQscsB1v7sQHlWJqrYS5ry/IuAAR7ezlxc0EpYuJ5idlLvlE@vger.kernel.org
X-Gm-Message-State: AOJu0Yxo5tz0jhT9i98VYlZDG7Q2qEwNlsl+63kbGauIlhz1Msg7eQ+K
	digvLv5WCQM+qfloJvIgZmuP3oX9zUrKFPqByopJK+iyQgjiST4DDkDT2XnatJU=
X-Gm-Gg: ASbGnctkOOqfrkv+uzJYTdfuQj7tdEXnq352CZUJExelu0J4WxUR8Y27JXUHAEUzsFU
	mM+pBytZibGxRhJPXqwaamt6Og0F1ZnITSnF+S1BcjosNzXgM0w1yBTeX88z5bHbGGz48ZIX1UW
	Tn6jVh9hXGmooiC7LoMXwxygIOL8p+ZAJuSL6uoLxnYTSN2TX8/heiGEdm6kgRpKpJjawk14es3
	TXcxeXkOyc0YagJlgZtAC4JHuI1bWNI4v0tAPprt7Iiwt2U/TJsCa037Tl6
X-Google-Smtp-Source: AGHT+IG5PcGGwL+OAF8BWXN0MfzrquLg0U95m3qvCvU2aqYiecyxUUHKeEBe+q/HNr+0PzMX/oeVbw==
X-Received: by 2002:a05:6e02:12e2:b0:3a6:c98d:86bc with SMTP id e9e14a558f8ab-3aff4619e11mr40735545ab.1.1734105375832;
        Fri, 13 Dec 2024 07:56:15 -0800 (PST)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3a9ca03ae11sm35258405ab.41.2024.12.13.07.56.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Dec 2024 07:56:15 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org
Cc: hannes@cmpxchg.org,
	clm@meta.com,
	linux-kernel@vger.kernel.org,
	willy@infradead.org,
	kirill@shutemov.name,
	bfoster@redhat.com,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 09/11] mm/filemap: drop streaming/uncached pages when writeback completes
Date: Fri, 13 Dec 2024 08:55:23 -0700
Message-ID: <20241213155557.105419-10-axboe@kernel.dk>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241213155557.105419-1-axboe@kernel.dk>
References: <20241213155557.105419-1-axboe@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If the folio is marked as streaming, drop pages when writeback completes.
Intended to be used with RWF_DONTCACHE, to avoid needing sync writes for
uncached IO.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 mm/filemap.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/mm/filemap.c b/mm/filemap.c
index 77290ac205dc..ec087bab1c97 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -1599,6 +1599,27 @@ int folio_wait_private_2_killable(struct folio *folio)
 }
 EXPORT_SYMBOL(folio_wait_private_2_killable);
 
+/*
+ * If folio was marked as dropbehind, then pages should be dropped when writeback
+ * completes. Do that now. If we fail, it's likely because of a big folio -
+ * just reset dropbehind for that case and latter completions should invalidate.
+ */
+static void folio_end_dropbehind(struct folio *folio)
+{
+	/*
+	 * Hitting !in_task() should not happen off RWF_DONTCACHE writeback,
+	 * but can happen if normal writeback just happens to find dirty folios
+	 * that were created as part of uncached writeback, and that writeback
+	 * would otherwise not need non-IRQ handling. Just skip the
+	 * invalidation in that case.
+	 */
+	if (in_task() && folio_trylock(folio)) {
+		if (folio->mapping)
+			folio_unmap_invalidate(folio->mapping, folio, 0);
+		folio_unlock(folio);
+	}
+}
+
 /**
  * folio_end_writeback - End writeback against a folio.
  * @folio: The folio.
@@ -1609,6 +1630,8 @@ EXPORT_SYMBOL(folio_wait_private_2_killable);
  */
 void folio_end_writeback(struct folio *folio)
 {
+	bool folio_dropbehind = false;
+
 	VM_BUG_ON_FOLIO(!folio_test_writeback(folio), folio);
 
 	/*
@@ -1630,9 +1653,14 @@ void folio_end_writeback(struct folio *folio)
 	 * reused before the folio_wake_bit().
 	 */
 	folio_get(folio);
+	if (!folio_test_dirty(folio))
+		folio_dropbehind = folio_test_clear_dropbehind(folio);
 	if (__folio_end_writeback(folio))
 		folio_wake_bit(folio, PG_writeback);
 	acct_reclaim_writeback(folio);
+
+	if (folio_dropbehind)
+		folio_end_dropbehind(folio);
 	folio_put(folio);
 }
 EXPORT_SYMBOL(folio_end_writeback);
-- 
2.45.2


