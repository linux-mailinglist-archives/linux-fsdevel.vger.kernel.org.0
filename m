Return-Path: <linux-fsdevel+bounces-63834-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 888D8BCEFD8
	for <lists+linux-fsdevel@lfdr.de>; Sat, 11 Oct 2025 07:00:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C75519A3938
	for <lists+linux-fsdevel@lfdr.de>; Sat, 11 Oct 2025 05:00:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72B3919D087;
	Sat, 11 Oct 2025 05:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="aY7/mYYW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69BC83D76;
	Sat, 11 Oct 2025 05:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760158824; cv=none; b=gGfaSeMiUWI0k+bCCfJB9WEBsB+CB3cZxL2inLX1l1LTH8DQn093cMUbvmoXaplgekPHTlfwzxggR+jwkHQWXA1AUucnM7gVK4e1aUmDDfS54kScWvshUXzrme4M+nLEhhw4F4NYPk0xAhRG8+vdaZPLjZosA07+bUtI3/+LwFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760158824; c=relaxed/simple;
	bh=tIH5S6a1ICHHbegE8Tcn93ttLa5kXn6iPV7XigeqCVU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KzcyH1qn8AATUiZ2hPmvSgb3Qi8eu9J/CfaRYa0Rvxv3A2JcooXeb1haij8EXIZRV9+3H1gHgrIrV6WyyrCe8V5B/4WL0O8B98tGDNNJd0DUZw7EMPxuhwotRMBGbR376CD8DXiqiyqXJDqEUUyR+phlkVd2AsB0Egp4Fpzwbu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=aY7/mYYW; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=pwINF39Za9W8pbyNPLBBsYysgw3nmU4lLhfEgitfLP8=; b=aY7/mYYWJE1Se3knWIXulnfUBH
	38pOZI9Jll+gJU4XfLd5rZT4SKJhYqQZzHG7ZI7DVubGM5D9SjNnITFu8NkoyRntk2rNr+a7TK6e6
	0rpH/WVKrXb6nEZiXPV59WUMgQC9M4BJmPlyX9oVRWjE0TUAdHt5TRtLOpetJ3YDW7gIHljZIiUJU
	7gOuKGthrWssVBpGdkYHEm+Vl4nLRxLq3Z8FQTfV7Pz5XDLleu7h9OqDClKOk8Nkz9gjmkrLbjFtx
	rChjsrjAhCy5X5uK1lY6o0CFylZ/v7XLBxJu/aTvi+Z4DIewqlVdpNZ+MBIr4xr/2t4YJQqHknWn5
	vab37KZA==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v7Ri8-00000006OFe-0RbS;
	Sat, 11 Oct 2025 05:00:04 +0000
Date: Sat, 11 Oct 2025 06:00:03 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Miaohe Lin <linmiaohe@huawei.com>
Cc: Zi Yan <ziy@nvidia.com>, akpm@linux-foundation.org, mcgrof@kernel.org,
	nao.horiguchi@gmail.com,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
	Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
	Lance Yang <lance.yang@linux.dev>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, david@redhat.com,
	jane.chu@oracle.com, kernel@pankajraghav.com,
	syzbot+e6367ea2fdab6ed46056@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH 2/2] mm/memory-failure: improve large block size folio
 handling.
Message-ID: <aOnkUxWPODofUnRy@casper.infradead.org>
References: <20251010173906.3128789-1-ziy@nvidia.com>
 <20251010173906.3128789-3-ziy@nvidia.com>
 <934db898-5244-50b9-7ef7-b42f1e40ddca@huawei.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <934db898-5244-50b9-7ef7-b42f1e40ddca@huawei.com>

On Sat, Oct 11, 2025 at 12:12:12PM +0800, Miaohe Lin wrote:
> >  		folio_set_has_hwpoisoned(folio);
> > -		if (try_to_split_thp_page(p, false) < 0) {
> > +		/*
> > +		 * If the folio cannot be split to order-0, kill the process,
> > +		 * but split the folio anyway to minimize the amount of unusable
> > +		 * pages.
> > +		 */
> > +		if (try_to_split_thp_page(p, new_order, false) || new_order) {
> > +			/* get folio again in case the original one is split */
> > +			folio = page_folio(p);
> 
> If original folio A is split and the after-split new folio is B (A != B), will the
> refcnt of folio A held above be missing? I.e. get_hwpoison_page() held the extra refcnt
> of folio A, but we put the refcnt of folio B below. Is this a problem or am I miss
> something?

That's how split works.

Zi Yan, the kernel-doc for folio_split() could use some attention.
First, it's not kernel-doc; the comment opens with /* instead of /**.
Second, it says:

 * After split, folio is left locked for caller.

which isn't actually true, right?  The folio which contains
@split_at will be locked.  Also, it will contain the additional
reference which was taken on @folio by the caller.

