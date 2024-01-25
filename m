Return-Path: <linux-fsdevel+bounces-8935-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DF7D083C787
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jan 2024 17:08:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 26B851C24D73
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jan 2024 16:08:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D02E8612D;
	Thu, 25 Jan 2024 16:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="dha1tkqj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FC40823CC;
	Thu, 25 Jan 2024 16:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706198879; cv=none; b=S71izDFYIzvAbW/p235uoN7Vhv+XFM1n6aZi61OsyRDl98bYyoQA2F40RF1ybHL00ag2S3vq3ufuQr3teWiNCq7Ncmgx2W3EmALeuWvEyHZwRDorl4rr1O8mht67r5YJXmOygsHw9Vq/1iM3ZJCLujvyc2xEE9c17DLKBvXGyB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706198879; c=relaxed/simple;
	bh=YCUmjEgMGuqxp9wVbE5NvYlF652L0MO1U4OkW5uHl0I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ooYlfnHU/WT1/wcSsDTP3FuEv0o16HjnSqemB1U6DlJhB1bvTsC5LxJJXEvaQrM7F/h+UgRDSx8UAp9w85axsM5KrVHUxuDoyMXEFryGWHH4VV085Zl1u/inBdn9DQ8dTAWjQh5F/yExMPB9nqPUaHngybdGrbSsJXX10et+tE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=dha1tkqj; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=GAtLrE1yDQhilWj7LTmlK/kPbxtcNvFE+sjhfNTr6b4=; b=dha1tkqjhljHDn77EMLnH8mKRI
	xw1gEI2UiNf7U9JKU9WAvk6UenCmESOwA2Ik9Lo/UHfrTDUP0a8LUoa4CvXZrPUb8qjUqP3bnRvaM
	+mekS4LNQ8HsY1ALFNUZWtbcyt+Vv9lagDn17TAWLix7E900qXdvXz/5st09vAi+QPKeVGrLPfWte
	gBG+ydwlsaYLP2xyJ9U2uUZdbvyx8dFmSSI6EjVQaof59U6yN8ik1kRQuMhp+Ba1jP1bLY55oVS9W
	XiMlQNfU8U+aumSQVqKkQ2sT7HsRMlnCIH76dPwvPl94kaNdAcnKxt+iOq543mj27YHBLMuSyhX93
	wLolTLvA==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rT2Gc-0000000ARU3-1WDb;
	Thu, 25 Jan 2024 16:07:50 +0000
Date: Thu, 25 Jan 2024 16:07:50 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Neal Cardwell <ncardwell@google.com>, netdev@vger.kernel.org,
	eric.dumazet@gmail.com, ZhangPeng <zhangpeng362@huawei.com>,
	Arjun Roy <arjunroy@google.com>, linux-mm@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH net] tcp: add sanity checks to rx zerocopy
Message-ID: <ZbKHVt_wkIfjKJXB@casper.infradead.org>
References: <20240125103317.2334989-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240125103317.2334989-1-edumazet@google.com>

On Thu, Jan 25, 2024 at 10:33:17AM +0000, Eric Dumazet wrote:
> +++ b/net/ipv4/tcp.c
> @@ -1786,7 +1786,17 @@ static skb_frag_t *skb_advance_to_frag(struct sk_buff *skb, u32 offset_skb,
>  
>  static bool can_map_frag(const skb_frag_t *frag)
>  {
> -	return skb_frag_size(frag) == PAGE_SIZE && !skb_frag_off(frag);
> +	struct page *page;
> +
> +	if (skb_frag_size(frag) != PAGE_SIZE || skb_frag_off(frag))
> +		return false;
> +
> +	page = skb_frag_page(frag);
> +
> +	if (PageCompound(page) || page->mapping)
> +		return false;

I'm not entirely sure why you're testing PageCompound here.  If a driver
allocates a compound page, we'd still want to be able to insert it,
right?

I have a feeling that we want to fix this in the VM layer.  There are
some weird places calling vm_insert_page() and we should probably make
them all fail.

Something like this, perhaps?

diff --git a/mm/memory.c b/mm/memory.c
index 1a60faad2e49..ae0abab56d38 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -1871,6 +1871,10 @@ static int insert_page_into_pte_locked(struct vm_area_struct *vma, pte_t *pte,
 
 	if (!pte_none(ptep_get(pte)))
 		return -EBUSY;
+	if (folio->mapping &&
+	    ((addr - vma->vm_start) / PAGE_SIZE + vma->vm_pgoff) !=
+	    (folio->index + folio_page_idx(folio, page)))
+		return -EINVAL;
 	/* Ok, finally just insert the thing.. */
 	folio_get(folio);
 	inc_mm_counter(vma->vm_mm, mm_counter_file(folio));

