Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F27E134EFE3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Mar 2021 19:40:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232307AbhC3Rj2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 30 Mar 2021 13:39:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231701AbhC3RjD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 30 Mar 2021 13:39:03 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CD79C061762;
        Tue, 30 Mar 2021 10:39:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:To:From:Date:Sender:Reply-To:Cc:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Aj3BBiJGkMf9HQ1Ip4ML4I8G/ZaA3wduTiGOb+gCee4=; b=UWmFxra5Xj/fLJEA/MZltsl/vV
        pQdMwQ9XpRSj4OLTmMYOJ4UoEyTBaUiyGKX1b7EUd5JyCWYinTlcQi+kvm4HgnWmRhO3xaJ8EfnL/
        CyVKNTOUD8hWpm+rfFDvi/uq6l0L9UXyXwh/cUz6KSPWu1dsN4MCq8C++YpGWNs3ZKJp5A4mjBh+a
        h5lwtxmjhXDbSlXcTetAoPC5uk8idmYCVMtbQr0aR0JAMvfQLeMbYj6c9w/53dES/WJobtqarNcGb
        Q1kMV3QE2NcwiBY51Mt642yFXqh1jsI5GHh7AIpjNMZkyIAlkJW9SKLRhx1MiwYIUr7v9DgkXoJrd
        vD9h8SfQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lRIKN-003NRv-0M; Tue, 30 Mar 2021 17:38:55 +0000
Date:   Tue, 30 Mar 2021 18:38:54 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] btrfs: Use readahead_batch_length
Message-ID: <20210330173854.GP351017@casper.infradead.org>
References: <20210321210311.1803954-1-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210321210311.1803954-1-willy@infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

ping?

On Sun, Mar 21, 2021 at 09:03:11PM +0000, Matthew Wilcox (Oracle) wrote:
> Implement readahead_batch_length() to determine the number of bytes in
> the current batch of readahead pages and use it in btrfs.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>  fs/btrfs/extent_io.c    | 6 ++----
>  include/linux/pagemap.h | 9 +++++++++
>  2 files changed, 11 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index e9837562f7d6..97ac4ddb2857 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -4875,10 +4875,8 @@ void extent_readahead(struct readahead_control *rac)
>  	int nr;
>  
>  	while ((nr = readahead_page_batch(rac, pagepool))) {
> -		u64 contig_start = page_offset(pagepool[0]);
> -		u64 contig_end = page_offset(pagepool[nr - 1]) + PAGE_SIZE - 1;
> -
> -		ASSERT(contig_start + nr * PAGE_SIZE - 1 == contig_end);
> +		u64 contig_start = readahead_pos(rac);
> +		u64 contig_end = contig_start + readahead_batch_length(rac) - 1;
>  
>  		contiguous_readpages(pagepool, nr, contig_start, contig_end,
>  				&em_cached, &bio, &bio_flags, &prev_em_start);
> diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
> index 2cbfd4c36026..92939afd4944 100644
> --- a/include/linux/pagemap.h
> +++ b/include/linux/pagemap.h
> @@ -1174,6 +1174,15 @@ static inline unsigned int readahead_count(struct readahead_control *rac)
>  	return rac->_nr_pages;
>  }
>  
> +/**
> + * readahead_batch_length - The number of bytes in the current batch.
> + * @rac: The readahead request.
> + */
> +static inline loff_t readahead_batch_length(struct readahead_control *rac)
> +{
> +	return rac->_batch_count * PAGE_SIZE;
> +}
> +
>  static inline unsigned long dir_pages(struct inode *inode)
>  {
>  	return (unsigned long)(inode->i_size + PAGE_SIZE - 1) >>
> -- 
> 2.30.2
> 
