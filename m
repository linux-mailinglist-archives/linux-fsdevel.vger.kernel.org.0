Return-Path: <linux-fsdevel+bounces-26542-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4784B95A558
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Aug 2024 21:35:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D9EC283896
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Aug 2024 19:35:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2E06170822;
	Wed, 21 Aug 2024 19:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="i2MhATVc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E71BE16E895
	for <linux-fsdevel@vger.kernel.org>; Wed, 21 Aug 2024 19:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724268902; cv=none; b=CTucV2uEebAm+W0KqBLKz0rfhnhN6/Iegk73ygFYzlwnCpdifWbx3Y4tWsIjrD2i9UvNvzEtms2NZjcTGpM4WYomYSL4V9cWdj6ap9NYwM0O5e4GTXjg7bxszt/2rF3zgWCIbjnCJafjFyzABduyUNuvtI5Xj6d8dnRCM0wvjbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724268902; c=relaxed/simple;
	bh=O60Ye10YS1Hh5fAmnRaDhm2ZgP7wF4F0tt9akH31hfE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ozurFkR6A9vLz3g14vD+ZDzk8K6Ijc3vuVjcghKtjHxCbnmMwOkOS2F6DGYvavLfDh5jKT3kW8gXFMhC2YgqZJkT8JF5G7fPMsnQ1BGvhUF+wUB2LdsI4pEUeQlEHPukJsqkB5RfA6aBtraf9KuHzmrD0R5o1lAO7kTXlGjFm48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=i2MhATVc; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=Z1DuzeAr1D4ZoS8EJ71yYTgQwfxw4lV4F5mPx3QubfY=; b=i2MhATVc9Iivb+xtCGY94TQ6Zm
	7FRxDEnCniqrIenwJbxD8HymbGZeWIEBbT8UW7HfQkG1TCCmdHazSXeIzDRkTHOMN9oq5644o9BPj
	hSg1J0ZoRSA5ENZuS7GJITb36NyCvjm65bVZJGBIVWHst+kjQdl7mZwGSBkSGr0HLA0oraGuJI6s8
	zyuYwfDNvmJppUp+RuejqII6yyVZTdlrk7poknJ2jRb1WGb4War8zfLaXhdEfNsUfPsHmuVrvYsV6
	NpMx0s5Qmf6ZbN7zFPxy54ZxJlkF/PNiaDlRlensptJUSgEWvVZjLZOo/+D53bd5esqFL8T8/28G+
	BTFlyHqQ==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sgr6U-00000009cqd-3niY;
	Wed, 21 Aug 2024 19:34:46 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org,
	x86@kernel.org
Subject: [PATCH 02/10] mm: Remove PageSwapBacked
Date: Wed, 21 Aug 2024 20:34:35 +0100
Message-ID: <20240821193445.2294269-3-willy@infradead.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240821193445.2294269-1-willy@infradead.org>
References: <20240821193445.2294269-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This flag is now only used on folios, so we can remove all the page
accessors.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/page-flags.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
index 65171b8fd661..5558d35cdcc3 100644
--- a/include/linux/page-flags.h
+++ b/include/linux/page-flags.h
@@ -528,9 +528,9 @@ PAGEFLAG(XenRemapped, xen_remapped, PF_NO_COMPOUND)
 PAGEFLAG(Reserved, reserved, PF_NO_COMPOUND)
 	__CLEARPAGEFLAG(Reserved, reserved, PF_NO_COMPOUND)
 	__SETPAGEFLAG(Reserved, reserved, PF_NO_COMPOUND)
-PAGEFLAG(SwapBacked, swapbacked, PF_NO_TAIL)
-	__CLEARPAGEFLAG(SwapBacked, swapbacked, PF_NO_TAIL)
-	__SETPAGEFLAG(SwapBacked, swapbacked, PF_NO_TAIL)
+FOLIO_FLAG(swapbacked, FOLIO_HEAD_PAGE)
+	__FOLIO_CLEAR_FLAG(swapbacked, FOLIO_HEAD_PAGE)
+	__FOLIO_SET_FLAG(swapbacked, FOLIO_HEAD_PAGE)
 
 /*
  * Private page markings that may be used by the filesystem that owns the page
-- 
2.43.0


