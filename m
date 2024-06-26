Return-Path: <linux-fsdevel+bounces-22475-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D330E91776F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Jun 2024 06:34:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4A3A5B23144
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Jun 2024 04:34:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F377013AD28;
	Wed, 26 Jun 2024 04:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="koPQBPRr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from m15.mail.163.com (m15.mail.163.com [45.254.50.219])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E0DA13A404;
	Wed, 26 Jun 2024 04:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.50.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719376430; cv=none; b=carOJMLEfYAbRlBfP+8se19E8Z0i3Pt94WUDstXuop1bngcQxHM6xz7aAb9VXaBA4tbW24+taslo/Ggl7l8ZSxDjpY9pU+5cDVnJSwu9T692Xfq9owY4/FUCeo9DARfVVdBuIOZAM6qZfhUWtP3t7+dUOLTVHLD5Frh+OmeFizI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719376430; c=relaxed/simple;
	bh=5FBDKrgKM4bBLhlI29ixgHfey9ibUTQTSdkgIvJzWeU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cRL6pgWQmPWxH+4nTS6JtQDq39hqN1OrDliQUlGDYIQ5q/q6mo8qs419PgOfFPw3437lTo8J6KpI98wSNMZv1F15e3SzRdj8uDne0P30GdOgxUkRFpYAmsF3Xi9XLIrXsZBJNZfSBjz+lh6K3h1mEqD9+4PN+8OlpEUyJh0wXN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=koPQBPRr; arc=none smtp.client-ip=45.254.50.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=ZLi/E
	p1EGjtsxREnkh4R2fNt0gBVDDmLr+/Dsf0yMRs=; b=koPQBPRrfCTOqxjhum2kl
	CsAU0Z3v5X6RZMemadmCTtbsuoy8uCrttQPc/+6Tk8As5Sq3AHhrvgmyPyxwXTQW
	AftaK2fDnl90WQiHgCVvNBt4Rofh4Z5cE7SFNxiVu/sysIqG1651k4oByHLdhdLz
	xk8Ub7WQjGfWgqYkTsV2Nk=
Received: from localhost.localdomain (unknown [193.203.214.57])
	by gzga-smtp-mta-g0-5 (Coremail) with SMTP id _____wD3fyTomXtmoLEPAg--.31175S4;
	Wed, 26 Jun 2024 12:32:41 +0800 (CST)
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
Subject: Re: [PATCH 2/2] kpageflags: fix wrong KPF_THP on non-pmd-mappable compound pages
Date: Wed, 26 Jun 2024 04:32:40 +0000
Message-Id: <20240626043240.1156168-1-ranxiaokai627@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <D29M7U8SPSYJ.39VMTRSKXW140@nvidia.com>
References: <D29M7U8SPSYJ.39VMTRSKXW140@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3fyTomXtmoLEPAg--.31175S4
X-Coremail-Antispam: 1Uf129KBjvJXoW7AF1kuFWrAw4xtF18KrWfKrg_yoW8ury5pr
	WrGasrAr4kKF98urn2qFnFyry0q3s8WF4Uta4ak3W3Z3ZrZr92kFWjvw1FkFnrZryxAws2
	va1DWFy2vas8ZaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0JUvksDUUUUU=
X-CM-SenderInfo: xudq5x5drntxqwsxqiywtou0bp/1tbiqRoKTGVOBGSxdwACs6

> On Tue Jun 25, 2024 at 10:49 PM EDT, ran xiaokai wrote:
> > From: Ran Xiaokai <ran.xiaokai@zte.com.cn>
> >
> > KPF_COMPOUND_HEAD and KPF_COMPOUND_TAIL are set on "common" compound
> > pages, which means of any order, but KPF_THP should only be set
> > when the folio is a 2M pmd mappable THP. Since commit 19eaf44954df
> > ("mm: thp: support allocation of anonymous multi-size THP"),
> > multiple orders of folios can be allocated and mapped to userspace,
> > so the folio_test_large() check is not sufficient here,
> > replace it with folio_test_pmd_mappable() to fix this.
> >
> > Also kpageflags is not only for userspace memory but for all valid pfn
> > pages,including slab pages or drivers used pages, so the PG_lru and
> > is_anon check are unnecessary here.
> 
> But THP is userspace memory. slab pages or driver pages cannot be THP.

I see, the THP naming implies userspace memory. Not only compound order.
 
> >
> > Signed-off-by: Ran Xiaokai <ran.xiaokai@zte.com.cn>
> > ---
> >  fs/proc/page.c | 14 ++++----------
> >  1 file changed, 4 insertions(+), 10 deletions(-)
> >
> > diff --git a/fs/proc/page.c b/fs/proc/page.c
> > index 2fb64bdb64eb..3e7b70449c2f 100644
> > --- a/fs/proc/page.c
> > +++ b/fs/proc/page.c
> > @@ -146,19 +146,13 @@ u64 stable_page_flags(const struct page *page)
> >  		u |= kpf_copy_bit(k, KPF_COMPOUND_HEAD, PG_head);
> >  	else
> >  		u |= 1 << KPF_COMPOUND_TAIL;
> > +
> Unnecessary new line.

yes, will fix.

> 
> >  	if (folio_test_hugetlb(folio))
> >  		u |= 1 << KPF_HUGE;
> > -	/*
> > -	 * We need to check PageLRU/PageAnon
> > -	 * to make sure a given page is a thp, not a non-huge compound page.
> > -	 */
> > -	else if (folio_test_large(folio)) {
> > -		if ((k & (1 << PG_lru)) || is_anon)
> > -			u |= 1 << KPF_THP;
> > -		else if (is_huge_zero_folio(folio)) {
> > +	else if (folio_test_pmd_mappable(folio)) {
> > +		u |= 1 << KPF_THP;
> 
> lru and anon check should stay.

thanks, will fix.

> 
> > +		if (is_huge_zero_folio(folio))
> >  			u |= 1 << KPF_ZERO_PAGE;
> > -			u |= 1 << KPF_THP;
> > -		}
> >  	} else if (is_zero_pfn(page_to_pfn(page)))
> >  		u |= 1 << KPF_ZERO_PAGE;
> >  
> 
> -- 
> Best Regards,
> Yan, Zi


