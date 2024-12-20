Return-Path: <linux-fsdevel+bounces-37956-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B2F09F95C7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Dec 2024 16:50:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C4DA316EC31
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Dec 2024 15:49:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D95B21B1AB;
	Fri, 20 Dec 2024 15:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="Oc8efsLy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ECB021A423
	for <linux-fsdevel@vger.kernel.org>; Fri, 20 Dec 2024 15:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734709722; cv=none; b=UMiTGtsXQdNqJ5Z67GUf5qKTWc7n/06c5FfaHIoZHP2LUN20lC+dfrUjdYIhYovxsLKbAJ8M8kn3EWMpGUdg+xE4/3YHD+f36Cqb8o2tGynXMNmdJ6Yhv13t2i5935vkxcwAcj06Ghw6uJMkQ9atqcf6YnnHFbQDoPRi1iGi2lo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734709722; c=relaxed/simple;
	bh=JO6tsxSlP852WA3y5S797XWTlY9uJCLdRkQsjOqf/SY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IsbigaSKBTXajXOGcDnYLS1MkgZapn/Arok/om6IrEnX1zuKcaQ1WHsqX1V6KNUGfP3ar9zyeidTr+OEoEUX+PObKanVRXWM8WgBXep+u0XKSgSj+44iCxeV8jgGcC+0fTaQeA9MhtY4LwZ6MA95l5ysRVh1CLE5vQ3Ae+OfaNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=Oc8efsLy; arc=none smtp.client-ip=209.85.166.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f42.google.com with SMTP id ca18e2360f4ac-844e1020253so72383839f.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 20 Dec 2024 07:48:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1734709720; x=1735314520; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TZWY6vJPfqFGr1DBynm1KpCMDB4zdovTdnWkeolaIOo=;
        b=Oc8efsLyd512POrstMUgXa+FvteRc1oMKe9Ma51mEWEnjkPmq8lmhCK02N/JPMCUs5
         fFoKBE9OyTb6NPJr46dyQ3rprc68njEKgQqczl1/azIDQpmO1tLR8mE0N5aaDPkJ6jtk
         Dz6fi0Z+6HAOco6MZtXj8mmPgNOzU8dGSTXFKqhdIX1DCxfprvoES1r6czX0z4OuH1Gw
         rqbPn8gvjVcq55EFFL/GpuZ1wMUuq7Ma1qkoCi2gh+IqV+vLh8PDYSivfeP25WQnE/Po
         SYelfNI1xK8fcErXUkdstKmaALvH/us9Lt9J1WETzro/u/inGdlUmTWf8pU1PvH2nGl/
         EMCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734709720; x=1735314520;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TZWY6vJPfqFGr1DBynm1KpCMDB4zdovTdnWkeolaIOo=;
        b=weWOVpf4mNuPrev3jnS5TiFYQbMXFLC/gCKiFuDQibKGDiqNDRcYSKIRFY/ktfqmEt
         GnM64+JfFhrljYeboMNzLORXjV8cYozDreXvf1dZADSBO+ytqLgQMLcBuUvNLC/MZMRK
         gc/tOvLKsa3u1vcN2J0M66m195YWj+MOsZMygPwP+IhpnkJUa6L3jnyPuCqCuAscdezo
         tmCRWZ5A9rZIops47m5Lk3hvvkB49vVLALNbFhS7e36CpdBucAC0eTzXtWcKgpckLLYm
         AGTU3hxgzMD8VKvMA1HiTwBvJ6vIPJ73YwfQWFr3CaZ8ABqw0mY2xZaW4qhawvc1Yuc9
         Ym+Q==
X-Forwarded-Encrypted: i=1; AJvYcCWSJEOg6xwhRa1FwZkNwWTXypn94Crgix+LLoCwhncTQdEmjp+7IqBxYg7xMM9hhloYJnHj4tXTt0Ubaq9C@vger.kernel.org
X-Gm-Message-State: AOJu0YwPLooWDrGbKQKoi4svk1XTkKC2Y527V3JtrTs4Jm2JEXxBDCO9
	kqDYNLPGyfy5NVTkOLFjGbBnXMfRvgBEA0blGXjXBuR2Si+XKHLYEwomKhIjSVo=
X-Gm-Gg: ASbGnctvQ7AqQuxI28n/U25O1VpdYWl4cu9Z90Ve9yhZqHwQFIvP2Dnk/sLJjwJclat
	CjbJpeNhHzMHChYIS1uSI4OGRO6thYf/0G9Bca1DMaUygGtvlyTzRdaEwOQ3lcHxwwQt0ms0T0f
	zP9HIeOYqFONhHPoVwz269/h/949edUOxsRY3HIJSouqRkDtoRG/MJZETSMuzYVUq3Wc57EAWYm
	VHLJZNeus84vl2Fe2VKjhIddmWANFkKbt0jUxUEmigkApMnHd3l4tSCh9CJ
X-Google-Smtp-Source: AGHT+IFvp8gxmeuG0px26ehs16GxVvbXtCVpdcyc+9Br4GzsJzwQZ198tT+fp2EHMgvEVKANcydJew==
X-Received: by 2002:a92:cda6:0:b0:3a7:a738:d9c8 with SMTP id e9e14a558f8ab-3c2d14d1839mr28931745ab.2.1734709720617;
        Fri, 20 Dec 2024 07:48:40 -0800 (PST)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4e68bf66ed9sm837821173.45.2024.12.20.07.48.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Dec 2024 07:48:39 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org
Cc: hannes@cmpxchg.org,
	clm@meta.com,
	linux-kernel@vger.kernel.org,
	willy@infradead.org,
	kirill@shutemov.name,
	bfoster@redhat.com,
	Jens Axboe <axboe@kernel.dk>,
	"Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCH 04/12] mm: add PG_dropbehind folio flag
Date: Fri, 20 Dec 2024 08:47:42 -0700
Message-ID: <20241220154831.1086649-5-axboe@kernel.dk>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241220154831.1086649-1-axboe@kernel.dk>
References: <20241220154831.1086649-1-axboe@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a folio flag that file IO can use to indicate that the cached IO
being done should be dropped from the page cache upon completion.

Reviewed-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 include/linux/page-flags.h     | 5 +++++
 include/trace/events/mmflags.h | 3 ++-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
index cf46ac720802..16607f02abd0 100644
--- a/include/linux/page-flags.h
+++ b/include/linux/page-flags.h
@@ -110,6 +110,7 @@ enum pageflags {
 	PG_reclaim,		/* To be reclaimed asap */
 	PG_swapbacked,		/* Page is backed by RAM/swap */
 	PG_unevictable,		/* Page is "unevictable"  */
+	PG_dropbehind,		/* drop pages on IO completion */
 #ifdef CONFIG_MMU
 	PG_mlocked,		/* Page is vma mlocked */
 #endif
@@ -562,6 +563,10 @@ PAGEFLAG(Reclaim, reclaim, PF_NO_TAIL)
 FOLIO_FLAG(readahead, FOLIO_HEAD_PAGE)
 	FOLIO_TEST_CLEAR_FLAG(readahead, FOLIO_HEAD_PAGE)
 
+FOLIO_FLAG(dropbehind, FOLIO_HEAD_PAGE)
+	FOLIO_TEST_CLEAR_FLAG(dropbehind, FOLIO_HEAD_PAGE)
+	__FOLIO_SET_FLAG(dropbehind, FOLIO_HEAD_PAGE)
+
 #ifdef CONFIG_HIGHMEM
 /*
  * Must use a macro here due to header dependency issues. page_zone() is not
diff --git a/include/trace/events/mmflags.h b/include/trace/events/mmflags.h
index bb8a59c6caa2..3bc8656c8359 100644
--- a/include/trace/events/mmflags.h
+++ b/include/trace/events/mmflags.h
@@ -116,7 +116,8 @@
 	DEF_PAGEFLAG_NAME(head),					\
 	DEF_PAGEFLAG_NAME(reclaim),					\
 	DEF_PAGEFLAG_NAME(swapbacked),					\
-	DEF_PAGEFLAG_NAME(unevictable)					\
+	DEF_PAGEFLAG_NAME(unevictable),					\
+	DEF_PAGEFLAG_NAME(dropbehind)					\
 IF_HAVE_PG_MLOCK(mlocked)						\
 IF_HAVE_PG_HWPOISON(hwpoison)						\
 IF_HAVE_PG_IDLE(idle)							\
-- 
2.45.2


