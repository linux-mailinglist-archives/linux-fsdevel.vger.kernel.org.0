Return-Path: <linux-fsdevel+bounces-15919-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A9BDC895D65
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Apr 2024 22:13:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 478A2B290EB
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Apr 2024 20:13:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5219815D5C0;
	Tue,  2 Apr 2024 20:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="taugIkjc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46FA75C8E6
	for <linux-fsdevel@vger.kernel.org>; Tue,  2 Apr 2024 20:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712088778; cv=none; b=YbUWmf1KItb3MifUSZ0Jh0Tg7C8Sxe2Ulx3u2IAv1UcFF4hr4JGPYEUlk5E+T0rtZkEpsAO97Y64WwM9g+eBPZ5/YyMaGIQF8zi8ha0wiXB9gCJK+Uet5kWKvArsXqj5BKtXTOdBGDlECJo/3PyQnNQnz5LZsnV/spbW7Kwvj0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712088778; c=relaxed/simple;
	bh=B5VNmsDifySZAuHrpGWSzGdFc0wvmC2oSNPrPlwh79c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ftfa4izGZgXB2raaGFfe9HRMGzLHDKfMY+3d62TtPFqhJnyNtW25PexpPrGXewBcfBUL1lz1fYPsEyFAHK3o9v/haDHfYCJX9pb1mUql7FRUABR9/60MiKm0yTkINoJN8lnojfoZD9td5KrVAN4ERWR9l4AT2nP8nKkXKdzfKvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=taugIkjc; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=joUr8j94Nl3F8GfeLZkX0bpznKDL0IJXDpaW9Sh6Jk8=; b=taugIkjcHTH/CrDE2DvOwonKkY
	lz1EqnGQ1DArXcQjYx/pC4ZxYm4L8W/RBgWju9Lh0gLbFYevQcp+FA96vlIJmp/zkQDlj0H6lBhR1
	IDhPN2m7sTRUvEwuF9ztIXY+8RyykR+OavNVKvq3SzRgwC/C8O/WyGyw+iVQEBsa2ecSNP6M637JI
	j4oagHCtzMV7KjTG1CRtJlwrINnyXOyxCf9rZ2A37Z4t7aco4ME2ouV8imTG/Fq7XiPgqfbqHG6Iu
	Z2LgOHFeGAhxpuwgrdgELdJ9wfaQRm9C3k5j558MH1DqOTFNpWkgbbXjgM90xAaXwGkeJzVhM9aAB
	PijOOIKw==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rrkV5-00000003qe5-27eG;
	Tue, 02 Apr 2024 20:12:55 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 0/4] Remove page_idle and page_young wrappers
Date: Tue,  2 Apr 2024 21:12:47 +0100
Message-ID: <20240402201252.917342-1-willy@infradead.org>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There are only a couple of places left using the page wrappers for
idle & young tracking.  Convert the two users in proc and then we can
remove the wrappers.  That enables the further simplification of
autogenerating the definitions when CONFIG_PAGE_IDLE_FLAG is disabled.

Matthew Wilcox (Oracle) (4):
  proc: Convert clear_refs_pte_range to use a folio
  proc: Convert smaps_account() to use a folio
  mm: Remove page_idle and page_young wrappers
  mm: Generate PAGE_IDLE_FLAG definitions

 fs/proc/task_mmu.c         | 32 +++++++++++---------
 include/linux/page-flags.h |  9 +++++-
 include/linux/page_idle.h  | 62 ++------------------------------------
 3 files changed, 27 insertions(+), 76 deletions(-)

-- 
2.43.0


