Return-Path: <linux-fsdevel+bounces-37331-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C03069F118E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Dec 2024 16:56:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ABBA3164EB1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Dec 2024 15:56:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE1081E5702;
	Fri, 13 Dec 2024 15:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="obyOaWIl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f181.google.com (mail-il1-f181.google.com [209.85.166.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC9791E3DF4
	for <linux-fsdevel@vger.kernel.org>; Fri, 13 Dec 2024 15:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734105371; cv=none; b=G+JULgHIm1nEcGKsO7rjfXLIXS3V7CNiel0LsOrnMTB3fGcn0rsKoYQy1Ma/lc9p03dEKfU7+bj9kz3IuY9GQeeJL6/9INE9Um4pvRHHwl26dyBqfwcHCiX/GbP8BGLIQBjFlGfGqGu6YhQeE1Gt4oofk8K7XKRugBwAkSVmdJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734105371; c=relaxed/simple;
	bh=sPnR3qBnsWLGEr22pRK2TCMcNSO2RW9SlspmNOIT9ew=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ek+LzIUrAiT1jXOTns5m3HO0X1f4tAZ+srJGDLdEWwY86mW9JN4F2e0cun6tkLNefX2Ts/SjF+07RNTEfSe6786o+OHYAVWQ/xUCEF3VvZk8k8Ag8AUsVyn+xCyLM8lIzvjvPJRCaCemjnCDUxjgTYGm0/Zy2AjwCb75Sr321z0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=obyOaWIl; arc=none smtp.client-ip=209.85.166.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f181.google.com with SMTP id e9e14a558f8ab-3a77980fe3aso6265535ab.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 13 Dec 2024 07:56:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1734105369; x=1734710169; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HOQaUrSMrbMaSJ8tKHsfpEHyiDws1YYfXq+2bH3/e/Y=;
        b=obyOaWIlLgEsnjXV7gMx/G3rChEhT3ViesKVO0mDuP1ASnoUTdHT/MOdQLx6tFeFCS
         68sfgPX2jZBlKMS6C1TnsGBTyAlkwhdeL3L0rpJqF8gdynDHZGWrxPkH3Z0w+n2gyjuG
         AYUcKJFnFw4qGqcXUGxleGgzUSU9eaAtaubpt4iTHYuofBvbY9MU7xOPAkeV4kBcACny
         WpuiSxbjIxGn89SGOWcguKS7+2MN2HjdezPSoIzCp/88od/7d3eN0ImQtejzPHwvlb7B
         RHO9uDxi72CCUPgseMsdr+YW6Sqjrk22kbaCmHlG3X3OZBs91D1Bjd2tkQqWVvNqv/Py
         kpjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734105369; x=1734710169;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HOQaUrSMrbMaSJ8tKHsfpEHyiDws1YYfXq+2bH3/e/Y=;
        b=a7JaUuCLpOOJNEK9f9MuS9Fw6urcMu1qZ2RPaKaxQ8J7T5nEgfp8SYfP7NYw29eEty
         2wLbZqf41AKPM0pyktlNoAGM+OSfpEWpFBOTwshDW9qynnj9uKQ6DoKcynreNa8tBTLi
         YJctRQ47HVLiFCiKpBSdnu661DzQnNSQ58NNcIIHEUBpbWqoS6sQp3K/6UwEIjzTyZwD
         P/flvzl8ptTgeqTpX78/QjWg064LkvHhAe+4ylaMiUhvmSSOdEs/HPQGjPWLG2jwVq+H
         yxqu30D2pplo0UA35NWpEe8fFGPnPyURsF0uao3v1P/Bj+15geuQyj0XYozFn2K6Hd0r
         MJvA==
X-Forwarded-Encrypted: i=1; AJvYcCV5Kiif5rZdQ9tCZ8Rdi3O5XXviM0CrDj0AohAvLS7OBffSL1XqfNm7t0rxApkTbyyDhzA28RxmNtdlQx0o@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6kg9jNtsM6CsV29B4URyJkQV/XPuFo4kICcotLZK+plKorvnX
	oYkS73GUfDZawrcK0mCVf7tcvEh55GNcmFEgbXmIi5WAhATkjGag4ristLPJ4Lo=
X-Gm-Gg: ASbGncuO+BTKdvts0I5PrlJTrmoOoDPAn22Rd+e5g0XMikMY9j9Wk7D8ppiN0nNW+Z2
	+OOJeFonHqDvNfrdqb7V+5xkXX3rS/PLo0P3oe00u/rgtZRAVdz9lDRu6TDyifeS9i8JIJFbasH
	0SQHB/chYEuEQvU63ol+2ZOwMMqim3C9jxW/+BSN1AV1uHvBP20SfET3+KCYJsuxVo+mtx+7Ovs
	38nDBTKsTXBkfwHAfutrD2Nxxea0BsoT9n1AjBCoNtzlDCQ+H0gWzkxs5CY
X-Google-Smtp-Source: AGHT+IFBVlz5yZz/k+skWWprsCIycLK8jgnRkqf8RE4HqF0RJQv2gkIr0yeXfbClfRWoooTGgqlEcg==
X-Received: by 2002:a05:6e02:156f:b0:3a7:e8df:3fcb with SMTP id e9e14a558f8ab-3b02d788a63mr20845625ab.7.1734105369001;
        Fri, 13 Dec 2024 07:56:09 -0800 (PST)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3a9ca03ae11sm35258405ab.41.2024.12.13.07.56.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Dec 2024 07:56:08 -0800 (PST)
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
Subject: [PATCH 04/11] mm: add PG_dropbehind folio flag
Date: Fri, 13 Dec 2024 08:55:18 -0700
Message-ID: <20241213155557.105419-5-axboe@kernel.dk>
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

Add a folio flag that file IO can use to indicate that the cached IO
being done should be dropped from the page cache upon completion.

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


