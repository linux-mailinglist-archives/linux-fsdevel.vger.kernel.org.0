Return-Path: <linux-fsdevel+bounces-34076-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F1CB9C2451
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Nov 2024 18:56:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 082C51F27D5E
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Nov 2024 17:56:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F2F621FD8F;
	Fri,  8 Nov 2024 17:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="vARexW2p"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FD0417A5BE
	for <linux-fsdevel@vger.kernel.org>; Fri,  8 Nov 2024 17:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731087928; cv=none; b=Y5hsmJCKpbY7C3d5gU6RqBDaTKmE2LyNXgyTDF7H9JoNZ6/S9keFTeoV4A9Yrbm3SjgMc6VqK/3cdvAj+I8QcNRVXSYxknhg0ejGj1Dn+mUTNaAovD5YkqMsfuDFhvCYtPWv7XHqKjqCbERK+hM+fWn178hulrfIWqJ+Uc0uT8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731087928; c=relaxed/simple;
	bh=rnoMCl/wzF1Rdw/7LWpkKe6sGAyHqTjLz9AhJ+JYxUE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dEESsZwQty+RC90//k6+uuJFxn9zuTtj+nh7z76RABVnCz/maBQ6ze8+NXJg50HWZRAUG4lqg0LOEQMx9/gWGY9YljwViPzAAOwNweQF9prRKfs3erHJYfDG/STHy74SEiW7n3rUjaTtWqhgd4BOmM4qLOIxS2OG27PNosNJa18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=vARexW2p; arc=none smtp.client-ip=209.85.167.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-3e6075cba82so1465551b6e.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 08 Nov 2024 09:45:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1731087926; x=1731692726; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8Os07YYPQ7kZ+kUIdYmg3svY/CQbT8cCz0FxxTNIj/Y=;
        b=vARexW2pfrv6PWUi1sYj02+pH5jThAbg0j8BBW0Rd5hZgmJIId6r5Z63/A1tVYSKk/
         aEv60ttUDKkrJnunQZlglUyGpb9AhSiPuJXGuX/dCqnvRVXX2iM5lTgawdakRdkLuEbB
         GlLy4yZsDI0txpI5qtrNjwNyQ38hsw7XPkOZ15waCh56JdUMV+BMeafJ6gjVRMGCsv19
         WDoxouakQV7w6b1BbYxe8Vo5JijxNKj6PYHxK/oPriaKGcPyaIZjMcZ1t52N49smD0wU
         TrzVyxZRGuGPPX+PMb6tr8JurVBmjsEEMkaFOz5yxWLrOY3XKyMRC+g7OZtKoUi+TJQ2
         95qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731087926; x=1731692726;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8Os07YYPQ7kZ+kUIdYmg3svY/CQbT8cCz0FxxTNIj/Y=;
        b=wJMPBPiMndw9XwAmMDdBW22jBcKFhTvX2d0ebxcGG6TjJoUi79BQgCzQfiHwuMNPp2
         bape0RmlqeUVowC3bmQTItaQPLv4vCJPIWxpemVXqM3PsZQbHI4cBiTyYbhqMWCXoNLM
         f6byApjk/5x+97mJfdRoMwgHqv6zJPF+oyIo0GwLOKQYj7rcDyBj7Hwy4XCvnLelUyCH
         vhaGUguDFHisHmS4JROvNleTwasFMu2nb3BbkKxuCXfy2IySoAtw+hPea2Ll1VXQXAQ5
         YJbBUHLitE85lVn0Wy7PSBhlVYZ4N/6tSZD7j05p1/m9gZyDS2dTsy1C/vpWdoMN+HWP
         JR6g==
X-Forwarded-Encrypted: i=1; AJvYcCXPNqfsu/rJERI3e3IRTwLY/2yLESDEBaXzt32wlRYh6KRkExsT4RwDEWRmKJzm0ktlI39wJ/xTsuWpT6cv@vger.kernel.org
X-Gm-Message-State: AOJu0YxqBr55pWO44yv8YeBXIcdFh/xyS5aZZn/fb/TK1mkkgnCg19wO
	kaYde2uQ2J8b/z6nExpe7wTBjsklZhj+yrNBr7gfgJYVCKopdJMhdkTE4duFr7w=
X-Google-Smtp-Source: AGHT+IEK3I8pTmLVAcP1tiUKABdaXPcTEUhdzcwYlEN/XSWu4cE0qIXfxmg72hsMc3+DTSEsR4vUEg==
X-Received: by 2002:a05:6808:120e:b0:3e0:4db9:8c44 with SMTP id 5614622812f47-3e79470a35bmr4931161b6e.27.1731087926068;
        Fri, 08 Nov 2024 09:45:26 -0800 (PST)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3e78cd28f80sm780969b6e.39.2024.11.08.09.45.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Nov 2024 09:45:25 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org
Cc: hannes@cmpxchg.org,
	clm@meta.com,
	linux-kernel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 09/13] mm: drop uncached pages when writeback completes
Date: Fri,  8 Nov 2024 10:43:32 -0700
Message-ID: <20241108174505.1214230-10-axboe@kernel.dk>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241108174505.1214230-1-axboe@kernel.dk>
References: <20241108174505.1214230-1-axboe@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If the folio is marked as uncached, drop pages when writeback completes.
Intended to be used with RWF_UNCACHED, to avoid needing sync writes for
uncached IO.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 mm/filemap.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/mm/filemap.c b/mm/filemap.c
index 6f65025782bb..1e455ca872b5 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -1634,6 +1634,18 @@ void folio_end_writeback(struct folio *folio)
 	if (__folio_end_writeback(folio))
 		folio_wake_bit(folio, PG_writeback);
 	acct_reclaim_writeback(folio);
+
+	/*
+	 * If folio is marked as uncached, then pages should be dropped when
+	 * writeback completes. Do that now.
+	 */
+	if (folio_test_uncached(folio)) {
+		folio_lock(folio);
+		if (invalidate_complete_folio2(folio->mapping, folio, 0))
+			folio_clear_uncached(folio);
+		folio_unlock(folio);
+
+	}
 	folio_put(folio);
 }
 EXPORT_SYMBOL(folio_end_writeback);
-- 
2.45.2


