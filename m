Return-Path: <linux-fsdevel+bounces-3044-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E5167EF75B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Nov 2023 19:15:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 925E8B20B7A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Nov 2023 18:15:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 863EF433B3;
	Fri, 17 Nov 2023 18:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="pYyjBQyM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DE5CD5B
	for <linux-fsdevel@vger.kernel.org>; Fri, 17 Nov 2023 10:15:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=c88nVbuS+XNcf0hScLatSF9sACZVShvDbKMQHve3QZs=; b=pYyjBQyM5GMj22F8RdYrZtAsF/
	v17634ADBC/2wOv0eIiHXe83jamFxiXsLeuhq0xQIvUh0KS1FE4HNulwBXApfdwfHhvF47c/yEAki
	C14ExBtN4G0lvUKiKeIsqjeGbcYmEBw0Ub0GMZVBD4HWDlW0olgUvjz/7GJLlN6mj+EPPNpuSh87f
	fGOZ7DrWWXK86kGbOkKmMBNRZugk8pLdPR9UcFqDCnPqan8NO1SMyq/ZRWRA3EoQS2QO/Py2hYv+T
	q7hEtwSc7JGNImErgn0E/PDjA5GId9JlfWPDobim0paS5fkgoHH2Cqaj+qaAivc2ubKL3Iul8kuby
	zsmg/CXg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1r43Ml-00Ar31-OH; Fri, 17 Nov 2023 18:14:55 +0000
Date: Fri, 17 Nov 2023 18:14:55 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Naoya Horiguchi <naoya.horiguchi@nec.com>,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	Paolo Bonzini <pbonzini@redhat.com>,
	Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH 6/6] fs: Convert error_remove_page to error_remove_folio
Message-ID: <ZVetnzjkLO99gXNB@casper.infradead.org>
References: <20231117161447.2461643-1-willy@infradead.org>
 <20231117161447.2461643-7-willy@infradead.org>
 <20231117092833.f143fa4bbf0abfbd2e58661d@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231117092833.f143fa4bbf0abfbd2e58661d@linux-foundation.org>

On Fri, Nov 17, 2023 at 09:28:33AM -0800, Andrew Morton wrote:
> >  virt/kvm/guest_memfd.c                |  9 +++++----
> 
> virt/kvm/guest_memfd.c exists only in the KVM tree (and hence
> linux-next).  So I assume Stephen will use the change from this patch
> when doing his resolution.

Guilty of developing against linux-next ;-)  Sorry, I didn't notice it
depended on something else; thanks for alerting Stephen.

> This:
> 
> --- a/virt/kvm/guest_memfd.c
> +++ b/virt/kvm/guest_memfd.c
> @@ -267,7 +267,8 @@ static int kvm_gmem_migrate_folio(struct address_space *mapping,
>  	return -EINVAL;
>  }
>  
> -static int kvm_gmem_error_page(struct address_space *mapping, struct page *page)
> +static int kvm_gmem_error_folio(struct address_space *mapping,
> +		struct folio *folio)
>  {
>  	struct list_head *gmem_list = &mapping->private_list;
>  	struct kvm_gmem *gmem;
> @@ -275,8 +276,8 @@ static int kvm_gmem_error_page(struct address_space *mapping, struct page *page)
>  
>  	filemap_invalidate_lock_shared(mapping);
>  
> -	start = page->index;
> -	end = start + thp_nr_pages(page);
> +	start = folio->index;
> +	end = start + folio_nr_pages(folio);
>  
>  	list_for_each_entry(gmem, gmem_list, entry)
>  		kvm_gmem_invalidate_begin(gmem, start, end);
> @@ -303,7 +304,7 @@ static const struct address_space_operations kvm_gmem_aops = {
>  #ifdef CONFIG_MIGRATION
>  	.migrate_folio	= kvm_gmem_migrate_folio,
>  #endif
> -	.error_remove_page = kvm_gmem_error_page,
> +	.error_remove_folio = kvm_gmem_error_folio,
>  };
>  
>  static int kvm_gmem_getattr(struct mnt_idmap *idmap, const struct path *path,
> -- 
> 2.42.0

