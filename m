Return-Path: <linux-fsdevel+bounces-49907-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43EF9AC4FCF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 May 2025 15:33:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B51A16E7CC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 May 2025 13:33:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EA7029A9;
	Tue, 27 May 2025 13:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="24PigdeB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64A15242D79
	for <linux-fsdevel@vger.kernel.org>; Tue, 27 May 2025 13:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748352782; cv=none; b=tjAlDGBuK2JZhTwygNW3wi3qo0NjJrT89Fdy/3QjqVnlagzl95oC7WOovOpZ6lDyxnqNw6IdkRBpY+1QRkawZBvmVrEAfp04pqbN0BXS21YPcyOLuPxalFss5BZ/2LVqIwKGk0m0TriDwCRHMBHbJSSRPvP4Y8UarL92e+IBI5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748352782; c=relaxed/simple;
	bh=Ta0o493G8dZQ9exOXUgb0qjqzgnesEWUiLmRzB7kuto=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hSqxBy5cS+EhIj6unsQ9Mp2k/GVQ4n9A3NVsoh/kCZiVxJoLQqhUFk0AvK+E7X4tJztSYbQaL2uzqMenTKs8pYTd5VkH12WeFZjh9eVsEpAmEX2pZ/jT1svyfKluMtqbdBIyFxbwKNWkUg/lfL+kFvnTrr+pDmnLdcizyDnAJo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=24PigdeB; arc=none smtp.client-ip=209.85.166.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f170.google.com with SMTP id e9e14a558f8ab-3dc729471e3so10374025ab.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 27 May 2025 06:33:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1748352780; x=1748957580; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/ebJZEHhwjhHTIP/mcxILxjWWkcG3pg6+COKM6quTvE=;
        b=24PigdeB78/rqeekF24/pKyUXiXfsjz/BXK7Rrax5/XRQy7SBj+Y1TmILoLtrqXYYW
         Miru/4xjzGEBZVcAC91OJjj6VdegYkE00RyXJVj8a1wmIIRklobiunSL0wfCZ8uHi5l5
         fGbyqy/IRnXc1JZSJ/InLt6rD2pkwLwHHV0f1e3TmKHngHdcIZVVCd3ovLgWiyPsKRyq
         f+d/ehwl+RkAZyx1jf11X+3gN0/DFnIqKl5LGVuZCMj9HuUtFfP4c6arkV+db+2HKgA6
         1DFSV0X8js6zxlbyriXPGzAUp4vjFtO50+4lgs431oBI8xNqRsvNC050rgo7pB2mAMU/
         B4bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748352780; x=1748957580;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/ebJZEHhwjhHTIP/mcxILxjWWkcG3pg6+COKM6quTvE=;
        b=oSVnQRddDd8UwJe8peFvyOot2OymbShPdk/RuED/QnkSgd81N/s5vMYpuGor/Ala7J
         98Dbp3yWuGYaRyMyQhGoFu0PxOml+xaoW4cYExbWEA+dufhcgGYlQMGN0bS8njQpQwLK
         /bOaLM97ONgC1B52zgv6xpwhIa2NYrA1tpZ9OC3Ihu2550rFuyzStExUeLDnfDxhOexI
         knaXzlwVHeeBDsFV9UEdY/J917PuwRcawjdoYlC6SfFKCnx2ZzZk6LyrYeHnrfBqVidk
         knJHUsKHw9AfokWFbcHQiJ9TAzcpSygmSya5H9x09Ov4QFlXMsgpn6KmgcJEc1Rz9u8T
         rCew==
X-Gm-Message-State: AOJu0YyEJGA0DV81K0DvXSz6896cKHOVcyNN0TDsdu9igsZaXiVcgo18
	KOrIx+tc99a9YDcBRdomDrWdspuu1SDASw6PmQScM212Cfb8kqsi3onOPDI3688hfZXw6nsmmAk
	42sGF
X-Gm-Gg: ASbGncuLbjJ4BcsJoYLYsrcx28fUxaZ+gBcGUlc1kkcWz0pe/XJuKtYwi5Jxat/gxfu
	/DOE4mllVsfegz3PTii5LSRMeN7p9IxFx4/XLuvvgp3cs+HnmGHEc+0LetSW+XuhsAFr9XH6RPG
	203AqkaqnOFMUZVfpxCtuOOpyvMIR7tmjJ9hr7J9aeRCxyl+V6Jr1avVGQW1euJdMyOa+dTl2kW
	oSgwZ4roWcZeQLbdh5woTahsvHua3Efg33CvAqlVbk/BfoiXtM4G+lMZojS6CUHczOKqrz1vRTF
	5gJUb2iCt6HcMkvKG/ZDOhIp54HxZFVEtsl7ZBuoLPCpArUHu8dcEa0=
X-Google-Smtp-Source: AGHT+IFp/X/5UUpH8g2DOmyJ2V3xTfVbLCQ8ySA0o44nnZboGRt19eNfMW7odE8piPyYyqztlkpc6Q==
X-Received: by 2002:a05:6e02:164a:b0:3dc:8e8b:42a8 with SMTP id e9e14a558f8ab-3dc9b70f7e8mr90997545ab.16.1748352779941;
        Tue, 27 May 2025 06:32:59 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3dc8298d8a2sm37404315ab.18.2025.05.27.06.32.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 May 2025 06:32:58 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-fsdevel@vger.kernel.org
Cc: viro@zeniv.linux.org.uk,
	djwong@kernel.org,
	brauner@kernel.org,
	torvalds@linux-foundation.org,
	trondmy@hammerspace.com,
	Jens Axboe <axboe@kernel.dk>,
	stable@vger.kernel.org
Subject: [PATCH 1/5] mm/filemap: gate dropbehind invalidate on folio !dirty && !writeback
Date: Tue, 27 May 2025 07:28:52 -0600
Message-ID: <20250527133255.452431-2-axboe@kernel.dk>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250527133255.452431-1-axboe@kernel.dk>
References: <20250527133255.452431-1-axboe@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It's possible for the folio to either get marked for writeback or
redirtied. Add a helper, filemap_end_dropbehind(), which guards the
folio_unmap_invalidate() call behind check for the folio being both
non-dirty and not under writeback AFTER the folio lock has been
acquired. Use this helper folio_end_dropbehind_write().

Cc: stable@vger.kernel.org
Reported-by: Al Viro <viro@zeniv.linux.org.uk>
Fixes: fb7d3bc41493 ("mm/filemap: drop streaming/uncached pages when writeback completes")
Link: https://lore.kernel.org/linux-fsdevel/20250525083209.GS2023217@ZenIV/
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 mm/filemap.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index 7b90cbeb4a1a..008a55290f34 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -1589,6 +1589,16 @@ int folio_wait_private_2_killable(struct folio *folio)
 }
 EXPORT_SYMBOL(folio_wait_private_2_killable);
 
+static void filemap_end_dropbehind(struct folio *folio)
+{
+	struct address_space *mapping = folio->mapping;
+
+	VM_BUG_ON_FOLIO(!folio_test_locked(folio), folio);
+
+	if (mapping && !folio_test_writeback(folio) && !folio_test_dirty(folio))
+		folio_unmap_invalidate(mapping, folio, 0);
+}
+
 /*
  * If folio was marked as dropbehind, then pages should be dropped when writeback
  * completes. Do that now. If we fail, it's likely because of a big folio -
@@ -1604,8 +1614,7 @@ static void folio_end_dropbehind_write(struct folio *folio)
 	 * invalidation in that case.
 	 */
 	if (in_task() && folio_trylock(folio)) {
-		if (folio->mapping)
-			folio_unmap_invalidate(folio->mapping, folio, 0);
+		filemap_end_dropbehind(folio);
 		folio_unlock(folio);
 	}
 }
-- 
2.49.0


