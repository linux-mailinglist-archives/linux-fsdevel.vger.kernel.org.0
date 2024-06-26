Return-Path: <linux-fsdevel+bounces-22474-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BF68B917766
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Jun 2024 06:33:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB96E1C2120D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Jun 2024 04:33:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5117F15885E;
	Wed, 26 Jun 2024 04:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="DT6ENWHU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE20014F9E0;
	Wed, 26 Jun 2024 04:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719376277; cv=none; b=R6ffyLSxZx+G59Wj4yBQnFSh3lAP1k4e1vf0mn/MRfhWh0fp3wdDyvgtZg2iRxB6+lFWZb/sLiZG3ZHYNaM7+FFLME7STYnKLRGZ+49mMHT0319Q8111dpk108IlrJjcT6yV7Ash3OB67euJRD7oUFrjw9UJF0fpi09jX4ABpik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719376277; c=relaxed/simple;
	bh=RJOeGqax6JoYjAfq9DLPFiimUs5ZHcSto1H9DnAKfNw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WIR/7Pn8g746wce7drb3C2y8M140316E85vqeLSJmPz3ELO6mJzpNUHFkyI3wao+Ie9XzR5PAK6lq70JybHvOmwlCPWkM+ngdi7Sc9PoZjzsy2ON4nvAekN3mj6Fdh34OTQ8kr37WbZulF5UsYmzdBhOzBdFUFDQnVU/64z9OGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=DT6ENWHU; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=AFaTt
	yuJ68VmYg9yBKPjPkv3Q9fuc+z8xPwml6AHFaU=; b=DT6ENWHUDa2SOzgt1IuX0
	UnHTzzGhT/aaxYXllqIyF3TURBb4c70Mr/pe8BbpuITLdkLKXZMPU5QtqIRKQ5HS
	V/JkZPR6GZIKpkSNpzJQxdBfiIy28JAfMbhXILjHiWzxSdijpwomRiYGd/aLGpkO
	zGFM6oYTGIWcEpzYxEtl3o=
Received: from localhost.localdomain (unknown [193.203.214.57])
	by gzga-smtp-mta-g2-0 (Coremail) with SMTP id _____wDnr+ZSmXtm99EUAg--.42408S4;
	Wed, 26 Jun 2024 12:30:12 +0800 (CST)
From: ran xiaokai <ranxiaokai627@163.com>
To: ziy@nvidia.com
Cc: yang.yang29@zte.com.cn,
	si.hao@zte.com.cn,
	akpm@linux-foundation.org,
	baohua@kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	peterx@redhat.com,
	ran.xiaokai@zte.com.cn,
	ranxiaokai627@163.com,
	ryan.roberts@arm.com,
	svetly.todorov@memverge.com,
	vbabka@suse.cz,
	willy@infradead.org
Subject: Re: [PATCH 1/2] mm: Constify folio_order()/folio_test_pmd_mappable()
Date: Wed, 26 Jun 2024 04:30:10 +0000
Message-Id: <20240626043010.1156065-1-ranxiaokai627@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <D29MAAR3YBI6.3G6PVIR1SJACO@nvidia.com>
References: <D29MAAR3YBI6.3G6PVIR1SJACO@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDnr+ZSmXtm99EUAg--.42408S4
X-Coremail-Antispam: 1Uf129KBjvJXoW7Ar1fuF45GryfKw4rGr1xKrg_yoW5JF48pF
	yDCFn7tFW0krW5uryDta1IyryYq39FgFWjyFy7Kry7Jas8t3sF93Wq9w1YkFn3GrZ7CF1I
	ga17WFyYga4UJFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0JUk73kUUUUU=
X-CM-SenderInfo: xudq5x5drntxqwsxqiywtou0bp/xtbB0hYKTGWXym5ASQAAsd

> On Tue Jun 25, 2024 at 10:49 PM EDT, ran xiaokai wrote:
> > From: Ran Xiaokai <ran.xiaokai@zte.com.cn>
> >
> > Constify folio_order()/folio_test_pmd_mappable().
> > No functional changes, just a preparation for the next patch.
> 
> What warning/error are you seeing when you just apply patch 2? I wonder why it
> did not show up in other places. Thanks.

fs/proc/page.c: In function 'stable_page_flags':
fs/proc/page.c:152:35: warning: passing argument 1 of 'folio_test_pmd_mappable' discards 'const' qualifier from pointer target type [-Wdiscarded-qualifiers]
  152 |  else if (folio_test_pmd_mappable(folio)) {
      |                                   ^~~~~
In file included from include/linux/mm.h:1115,
                 from include/linux/memblock.h:12,
                 from fs/proc/page.c:2:
include/linux/huge_mm.h:380:58: note: expected 'struct folio *' but argument is of type 'const struct folio *'
  380 | static inline bool folio_test_pmd_mappable(struct folio *folio)

u64 stable_page_flags(const struct page *page)
{
	const struct folio *folio; // the const definition causes the warning
	...
}

As almost all the folio_test_XXX(flags) have converted to received
a const parameter, it is Ok to also do this for folio_order()?

> >
> > Signed-off-by: Ran Xiaokai <ran.xiaokai@zte.com.cn>
> > ---
> >  include/linux/huge_mm.h | 2 +-
> >  include/linux/mm.h      | 2 +-
> >  2 files changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
> > index 2aa986a5cd1b..8d66e4eaa1bc 100644
> > --- a/include/linux/huge_mm.h
> > +++ b/include/linux/huge_mm.h
> > @@ -377,7 +377,7 @@ static inline spinlock_t *pud_trans_huge_lock(pud_t *pud,
> >   * folio_test_pmd_mappable - Can we map this folio with a PMD?
> >   * @folio: The folio to test
> >   */
> > -static inline bool folio_test_pmd_mappable(struct folio *folio)
> > +static inline bool folio_test_pmd_mappable(const struct folio *folio)
> >  {
> >  	return folio_order(folio) >= HPAGE_PMD_ORDER;
> >  }
> > diff --git a/include/linux/mm.h b/include/linux/mm.h
> > index 9a5652c5fadd..b1c11371a2a3 100644
> > --- a/include/linux/mm.h
> > +++ b/include/linux/mm.h
> > @@ -1105,7 +1105,7 @@ static inline unsigned int compound_order(struct page *page)
> >   *
> >   * Return: The order of the folio.
> >   */
> > -static inline unsigned int folio_order(struct folio *folio)
> > +static inline unsigned int folio_order(const struct folio *folio)
> >  {
> >  	if (!folio_test_large(folio))
> >  		return 0;


