Return-Path: <linux-fsdevel+bounces-8937-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AAC583C792
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jan 2024 17:10:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 94E131C22490
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jan 2024 16:10:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61192129A65;
	Thu, 25 Jan 2024 16:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="rmGd0N8Z"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40ED81292EA;
	Thu, 25 Jan 2024 16:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706199000; cv=none; b=sf7KPwIykmxSxtgcFToKT5qYXygtWG+RI5QWUFxEK8FR3piUDWb/e5xDuuItME2VmAjxiqxzZeQr/Uyl6FlpjajBdYZj3d1zWNc+1tgf45iVuN4PrDD9PuZQt592yY0ftOw9ND49wZaCEZOELd980lSiwEzLXuuWOAyjzuNXjJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706199000; c=relaxed/simple;
	bh=VAcxAAUle0UP8LX4Kr6jwChcisFpxl7tZH9DWxwQQro=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xd7dOXn+QgscAnMA1GodWmu5tDmUZVf4n1MFyS997T6j01MudX8cJZe9VUipKtbSLhMlnFpXU2YpBkNf1GADiwYboptsL7jIO00bJAfrtnOIrlNUfqQMksCiO0qc1VScZtqnAxBd4te2cSYhe9m//6kE9N+8AlnztrdMpecEhJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=rmGd0N8Z; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=RQikkIm2QnxXvz3fgLK+M6KVic4QhqcU+a/nOw4Ko44=; b=rmGd0N8ZuxoU0orIOY0DvsvKHI
	vEsQrX6qIGcUW+dArNov8C5l6ql5HZTIZHoCUBU3VYWzbBx2g9hycWUHkvr0EiXuq23CuxyNR6Sfb
	VDSpYTpYD7v9M6Fx10VBrhW8SgTAEWAEHoaCDKtXTr0sx8vjQNccYWWM+fp5ZaJAvVAZYFp/2G0OA
	ZhmQp3LjcE6SIByY3fgzmF3+pFjetD7a7llX9AR6+pEPR82b1D/7zBPzkf8AApqLtFsgUyXJnv815
	9CkMg2hSlTGWi6lF06BLi05ctqj2eZx+Rwv4KkAPG6xCDTcppa/S4S2rGGAQzpc12rtBHy7KQq4U2
	QpskTG2w==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rT2Id-0000000ARmp-1ycD;
	Thu, 25 Jan 2024 16:09:55 +0000
Date: Thu, 25 Jan 2024 16:09:55 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Neal Cardwell <ncardwell@google.com>, netdev@vger.kernel.org,
	eric.dumazet@gmail.com, ZhangPeng <zhangpeng362@huawei.com>,
	Arjun Roy <arjunroy@google.com>, linux-mm@kvack.org,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH net] tcp: add sanity checks to rx zerocopy
Message-ID: <ZbKH04PDW7NhImjV@casper.infradead.org>
References: <20240125103317.2334989-1-edumazet@google.com>
 <ZbKHVt_wkIfjKJXB@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZbKHVt_wkIfjKJXB@casper.infradead.org>


Fixing email address for linux-mm.

On Thu, Jan 25, 2024 at 04:07:50PM +0000, Matthew Wilcox wrote:
> On Thu, Jan 25, 2024 at 10:33:17AM +0000, Eric Dumazet wrote:
> > +++ b/net/ipv4/tcp.c
> > @@ -1786,7 +1786,17 @@ static skb_frag_t *skb_advance_to_frag(struct sk_buff *skb, u32 offset_skb,
> >  
> >  static bool can_map_frag(const skb_frag_t *frag)
> >  {
> > -	return skb_frag_size(frag) == PAGE_SIZE && !skb_frag_off(frag);
> > +	struct page *page;
> > +
> > +	if (skb_frag_size(frag) != PAGE_SIZE || skb_frag_off(frag))
> > +		return false;
> > +
> > +	page = skb_frag_page(frag);
> > +
> > +	if (PageCompound(page) || page->mapping)
> > +		return false;
> 
> I'm not entirely sure why you're testing PageCompound here.  If a driver
> allocates a compound page, we'd still want to be able to insert it,
> right?
> 
> I have a feeling that we want to fix this in the VM layer.  There are
> some weird places calling vm_insert_page() and we should probably make
> them all fail.
> 
> Something like this, perhaps?
> 
> diff --git a/mm/memory.c b/mm/memory.c
> index 1a60faad2e49..ae0abab56d38 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -1871,6 +1871,10 @@ static int insert_page_into_pte_locked(struct vm_area_struct *vma, pte_t *pte,
>  
>  	if (!pte_none(ptep_get(pte)))
>  		return -EBUSY;
> +	if (folio->mapping &&
> +	    ((addr - vma->vm_start) / PAGE_SIZE + vma->vm_pgoff) !=
> +	    (folio->index + folio_page_idx(folio, page)))
> +		return -EINVAL;
>  	/* Ok, finally just insert the thing.. */
>  	folio_get(folio);
>  	inc_mm_counter(vma->vm_mm, mm_counter_file(folio));
> 

