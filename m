Return-Path: <linux-fsdevel+bounces-21647-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 911E990753A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Jun 2024 16:34:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1B651B22ADC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Jun 2024 14:34:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0313A145A1A;
	Thu, 13 Jun 2024 14:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BaSHju8R"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE2E813D607
	for <linux-fsdevel@vger.kernel.org>; Thu, 13 Jun 2024 14:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718289280; cv=none; b=n8q9CIqU2P4LW7CsFTXNtHe3eOdjgqFew1kptN3xc4eY/1QBkoorB8pK51zqE10Cn+aJrbHFdPKjGYKwjrbZfCFWglyKniNKINVFq7vVDl0ulm8XWdWGASvCWipouezqdOiqvdSR5qlmvaFOtdPHXb5F6DTztxRI87CRKhT8Vd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718289280; c=relaxed/simple;
	bh=1GvzaJmYhr/v9fiS4GiqGNq8mR0s0kuyVdl55JSOen4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=oJx8vBUErd9KYxUtYdh9YHqq+DsyS4fhzAnMavOy+BG9h9OogN+6vuz/pZdz096RkLbinr8e8+8oS0JpaesHAleT6UgEhEXdaed4BU370zed9zDA6aywcpqWD/1meOVxiLElog6btfcdejUepq3Y17EQoaAJuAQ+ZmLqFV9molY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=BaSHju8R; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-421757d217aso12696945e9.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 13 Jun 2024 07:34:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718289277; x=1718894077; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GUu841f04EncWFMYW6vBBiSV3HmVz/jOjkpdY+qxO/w=;
        b=BaSHju8RJ87dvsBH5YigoNxfASTiHaUAkuOFEXXDiqjbE8vXg7AjidOq0VWTlPfPhC
         Vz5wbtv9eFd0WoehGQberbdP83nin+vMdgaQqB+rkR7DUT9R8JslsbSi3arwsz+AWj+0
         6EgjqeDd0DXr6fKdeUUKaTHG8Ma+rWIzb7fVdxtw99TEps6M/iYq/yCUKn2PsqDke7pK
         eyL0Sm1yvlIfcqQjIqkYwFDU1wWnpg//+TqSemWQB4AaRWijFW3AHn8iYcLSzaAP8DfX
         EFm1XNYxMl6IPzu/2VWpE7KJLJ0mA54yb+LGD8fB5XWMBbtj/skYpGu6Iw8cU2BZmQTr
         Si5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718289277; x=1718894077;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GUu841f04EncWFMYW6vBBiSV3HmVz/jOjkpdY+qxO/w=;
        b=H4pTGSzFbqcquIWtRMg8rxGgJQ78X9V3yHHgVS6uw/axCh2zu9IxpMNMsicns7S544
         GwaQPZHl38LTOmXpPmUTcZxG8y+uPCd4HkAsu6du91uiiGB1jdLSkKZrP2Y83Q+okLn5
         /yGDGrw5kR/DEoMBknwyNeHEAet6Vax+xMapfNchReyheTB8ld2koY9jbuzUqd3fGESU
         SByFszxTM0pBsBspCRqYCvqOfCX2a2oKvwp10dPHhJxoynyjOtMmFogNXK+PN+ZDVnfY
         ED+WzICa74n+JYBlsACtvFmlW/H1lKbll+Z63uyEF5meyNM+uT7E7z0VHIqNT5nhoB/p
         3RKg==
X-Forwarded-Encrypted: i=1; AJvYcCUSbxcNIHShkHfpK8zEexJ7IwGtAOhhh1EYH4AtxbP45uglX4ySlnv0IpNChz+YPYyWaMvYpHaaMO8Pr/Cqtic0GluczFP8UtUE6wdwHg==
X-Gm-Message-State: AOJu0YwChF3EYda24SNkmdXL1e56iU1ow1Ap1Gs9NSijTj6Jahe52fuF
	DSjSbI389h57hLmLoyrJcTlsdb2fBEAoL+mIzxHmwsh9hrMQgwF7MTxu/CEXVo0=
X-Google-Smtp-Source: AGHT+IF5rNvhSil91ql7BawniRIsmEGSLhXkLYJko0c4ZjkyuqNa9z81o9B9fbYWSGMBCYVzDaCyqw==
X-Received: by 2002:a05:600c:42c4:b0:422:6755:17de with SMTP id 5b1f17b1804b1-422867c90f9mr50286365e9.41.1718289277293;
        Thu, 13 Jun 2024 07:34:37 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42284d1130esm27960335e9.0.2024.06.13.07.34.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jun 2024 07:34:36 -0700 (PDT)
Date: Thu, 13 Jun 2024 17:34:33 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: David Hildenbrand <david@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Matthew Wilcox <willy@infradead.org>,
	Muhammad Usama Anjum <usama.anjum@collabora.com>,
	Andrei Vagin <avagin@google.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Hugh Dickins <hughd@google.com>,
	Kefeng Wang <wangkefeng.wang@huawei.com>,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH] fs/proc/task_mmu: fix uninitialized variable in
 pagemap_pmd_range()
Message-ID: <9d6eaba7-92f8-4a70-8765-38a519680a87@moroto.mountain>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

The "folio" pointer is tested for NULL, but it's either valid or
uninitialized.  Initialize it to NULL.

Fixes: 84f57f8b8914 ("fs/proc: move page_mapcount() to fs/proc/internal.h")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 fs/proc/task_mmu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index 631371cb80a0..6ed1f56b32b4 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -1492,7 +1492,7 @@ static int pagemap_pmd_range(pmd_t *pmdp, unsigned long addr, unsigned long end,
 		u64 flags = 0, frame = 0;
 		pmd_t pmd = *pmdp;
 		struct page *page = NULL;
-		struct folio *folio;
+		struct folio *folio = NULL;
 
 		if (vma->vm_flags & VM_SOFTDIRTY)
 			flags |= PM_SOFT_DIRTY;
-- 
2.43.0


