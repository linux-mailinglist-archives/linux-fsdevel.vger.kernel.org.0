Return-Path: <linux-fsdevel+bounces-16056-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 601C9897633
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Apr 2024 19:18:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 92F39B25EE3
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Apr 2024 17:16:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3F26152DFF;
	Wed,  3 Apr 2024 17:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="XIiojhO5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8D11153835;
	Wed,  3 Apr 2024 17:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712164514; cv=none; b=psF7slTtBKI0gtnxEPv44+i6mPkufhzaFLdnxZd/eemMiYa1SDK439mQNBQep3WK0xFd0nXOaAD5SdBHVumvm3/TCptAiNezY81txfmwWMToCPNDBTFx1XGOyYSanIT4wNfef8rX2PuAseMcFMF2e77nl5VHHtvCSpDg8s7hlPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712164514; c=relaxed/simple;
	bh=H11WHqcBlIxImUk5M/UEO4V3G5vefIJgZH6ETCuIO/Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gQTS6msKT+lQaWwYgDJYK5X4D6VyS7WyQgNHFy7UHlHlIK9uRXVkfzobXgUu+BmCBSnw/p/Yf2g+N6twgL3fOML1hkFbii9b4iaEuB6MG2Ck3gUF2zEij5hZaWNSKPNVNhuR05jqjy0pSIMwXeqOeyUueSRggGeAZf1fHaU21Rs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=XIiojhO5; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=IpFAkuK5GrANAaP4NmnY/N+aubhDpK+1vnYlU3fSkMo=; b=XIiojhO5kzKUQnO5gfy73EzYel
	0j7bndeBs0u1ixlvz+U8c/CjkZKaeZcdS1Yn4d3z3Yx/vNi8C9kGdCTSPx/7zVtph/0VubBldtien
	voFklC2HAuIv4NW4WJr2ePYZF1CMGxWWZEt3mFtY7FTYmVhzXNT5wFpd10P5lxXXXBxTS2n9PPmHw
	820AXRPRR0Z9P3JIq6bqPesLm5g3t9g34W2I5FNcfMm+B4pgPTDu0aVL7Eba5ws7ZGdW4rBjWAGpF
	DxibgX4J9Z8low00bBHS+ItrUewlgDzRJcxz7GMZas7v5/vpM5XxiualDuXnfDcqosJ7dNoXpYWP6
	ZlyproiA==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rs4CQ-000000063wV-0ND5;
	Wed, 03 Apr 2024 17:14:58 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Andrew Morton <akpm@linux-foundation.org>,
	Christian Brauner <brauner@kernel.org>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 0/4] Use folio APIs in procfs
Date: Wed,  3 Apr 2024 18:14:51 +0100
Message-ID: <20240403171456.1445117-1-willy@infradead.org>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Not sure whether Andrew or Christian will want to take this set of
fixes.  We're down to very few users of the PageFoo macros, with proc
being a major user.  After this patchset and another patchset I have
for khugepaged, we can get rid of PageActive, PageReadahead and
PageSwapBacked.

This patchset has the usual advantages in its own right of removing
hidden calls to compound_head().  We have the page table lock, so
the mapcount & refcount are stable and there can't be any races with
folios suddenly becoming tail pages.

Matthew Wilcox (Oracle) (4):
  proc: Convert gather_stats to use a folio
  proc: Convert smaps_page_accumulate to use a folio
  proc: Pass a folio to smaps_page_accumulate()
  proc: Convert smaps_pmd_entry to use a folio

 fs/proc/task_mmu.c | 37 ++++++++++++++++++++-----------------
 1 file changed, 20 insertions(+), 17 deletions(-)

-- 
2.43.0


