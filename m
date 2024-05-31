Return-Path: <linux-fsdevel+bounces-20627-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F4A28D63DD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 May 2024 16:00:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DDDBF285CC1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 May 2024 14:00:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12F2315B975;
	Fri, 31 May 2024 13:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="dyo4c21p"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DBA4158DAA
	for <linux-fsdevel@vger.kernel.org>; Fri, 31 May 2024 13:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717163763; cv=none; b=aFeN8nSg112jrORImk8wCWeyjp0EDZ5Pwjk6wDLbInK8acNxnVSyKL+2/pA20pschCjSAqgGdggzfprQ074IEnnL1ojaa33YMs/eEU0qH1wiefKQPmjsRG+DF/4qU+urnOCsq/RxBDN3OzBGBFsy5GtUW5vE4ZxUUwg06KLuS6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717163763; c=relaxed/simple;
	bh=WsL3o3+MWJeRdy6mlc1F3IoI0R79X6T9RXYBYupgFMI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=roYH5aD1M3ql1ae+CsMI2LyG21PGqjGFH+H4bmJA/DiW5J7NTwxWhLnH2xBbKJEJrrR8l1UmyLHziggL+7BlUyGBMepNTidPl1E34RkFT5BxXz5OQMDBKhLhi2OdKnjHg7VjbOeHY4cZc2ur0NhZsVsk8QMRL5qiBTiI3H0YGEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=dyo4c21p; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=hOUDzBNArOYepgPXo1iBbPP69U/83MRMAzI9ClltqG8=; b=dyo4c21paVDca+eFQBC4DuhOYJ
	LTeU21aATKcrl3hz/Eg8cFbI2gUdm+HhwSEzjTDcL5v6TtrfdusHofTY7e2B2WbMv2+vp1DcBk5io
	dpNZm/JIKpcohiX5AQfvkzXlEYy2W8Brtj6XTbPkZWNoMDzyYGjKk5URQWxTISnLOQRYH9E01pwEn
	01WAfbf9VOG+qsETi3vINJ19k8tRXl2RzrxxrHpDxp7+h6cya5JuvXyD9fGS7veahJtNpNtMNpjKR
	8yKpAbbMLJfeE+h0sod77aWaNnEmphVLf8zLwIjjzSvZ51esr0Ea5704S0jqpESMutLWONUCvRZrF
	hZXuCyxw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sD2jh-0000000AQEH-1vt9;
	Fri, 31 May 2024 13:56:01 +0000
Date: Fri, 31 May 2024 06:56:01 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Bernd Schubert <bschubert@ddn.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>,
	linux-fsdevel@vger.kernel.org, bernd.schubert@fastmail.fm,
	Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org
Subject: Re: [PATCH RFC v2 06/19] Add a vmalloc_node_user function
Message-ID: <ZlnW8UFrGmY-kgoV@infradead.org>
References: <20240529-fuse-uring-for-6-9-rfc2-out-v1-0-d149476b1d65@ddn.com>
 <20240529-fuse-uring-for-6-9-rfc2-out-v1-6-d149476b1d65@ddn.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240529-fuse-uring-for-6-9-rfc2-out-v1-6-d149476b1d65@ddn.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Wed, May 29, 2024 at 08:00:41PM +0200, Bernd Schubert wrote:
> This is to have a numa aware vmalloc function for memory exposed to
> userspace. Fuse uring will allocate queue memory using this
> new function.
> 
> Signed-off-by: Bernd Schubert <bschubert@ddn.com>
> cc: Andrew Morton <akpm@linux-foundation.org>
> cc: linux-mm@kvack.org
> Acked-by: Andrew Morton <akpm@linux-foundation.org>
> ---
>  include/linux/vmalloc.h |  1 +
>  mm/nommu.c              |  6 ++++++
>  mm/vmalloc.c            | 41 +++++++++++++++++++++++++++++++++++++----
>  3 files changed, 44 insertions(+), 4 deletions(-)
> 
> diff --git a/include/linux/vmalloc.h b/include/linux/vmalloc.h
> index 98ea90e90439..e7645702074e 100644
> --- a/include/linux/vmalloc.h
> +++ b/include/linux/vmalloc.h
> @@ -141,6 +141,7 @@ static inline unsigned long vmalloc_nr_pages(void) { return 0; }
>  extern void *vmalloc(unsigned long size) __alloc_size(1);
>  extern void *vzalloc(unsigned long size) __alloc_size(1);
>  extern void *vmalloc_user(unsigned long size) __alloc_size(1);
> +extern void *vmalloc_node_user(unsigned long size, int node) __alloc_size(1);
>  extern void *vmalloc_node(unsigned long size, int node) __alloc_size(1);
>  extern void *vzalloc_node(unsigned long size, int node) __alloc_size(1);
>  extern void *vmalloc_32(unsigned long size) __alloc_size(1);
> diff --git a/mm/nommu.c b/mm/nommu.c
> index 5ec8f44e7ce9..207ddf639aa9 100644
> --- a/mm/nommu.c
> +++ b/mm/nommu.c
> @@ -185,6 +185,12 @@ void *vmalloc_user(unsigned long size)
>  }
>  EXPORT_SYMBOL(vmalloc_user);
>  
> +void *vmalloc_node_user(unsigned long size, int node)
> +{
> +	return __vmalloc_user_flags(size, GFP_KERNEL | __GFP_ZERO);
> +}
> +EXPORT_SYMBOL(vmalloc_node_user);
> +
>  struct page *vmalloc_to_page(const void *addr)
>  {
>  	return virt_to_page(addr);
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index 68fa001648cc..0ac2f44b2b1f 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -3958,6 +3958,25 @@ void *vzalloc(unsigned long size)
>  }
>  EXPORT_SYMBOL(vzalloc);
>  
> +/**
> + * _vmalloc_node_user - allocate zeroed virtually contiguous memory for userspace

Please avoid the overly long line.

> + * on the given numa node
> + * @size: allocation size
> + * @node: numa node
> + *
> + * The resulting memory area is zeroed so it can be mapped to userspace
> + * without leaking data.
> + *
> + * Return: pointer to the allocated memory or %NULL on error
> + */
> +static void *_vmalloc_node_user(unsigned long size, int node)

Although for static functions kerneldoc comments are pretty silly
to start with.

>  void *vmalloc_user(unsigned long size)
>  {
> -	return __vmalloc_node_range(size, SHMLBA,  VMALLOC_START, VMALLOC_END,
> -				    GFP_KERNEL | __GFP_ZERO, PAGE_KERNEL,
> -				    VM_USERMAP, NUMA_NO_NODE,
> -				    __builtin_return_address(0));
> +	return _vmalloc_node_user(size, NUMA_NO_NODE);

But I suspect simply adding a gfp_t argument to vmalloc_node might be
a much easier to use interface here, even if it would need a sanity
check to only allow for actually useful to vmalloc flags.


