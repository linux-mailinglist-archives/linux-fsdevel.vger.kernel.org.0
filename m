Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EF2E355C81
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Apr 2021 21:44:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245005AbhDFToo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 6 Apr 2021 15:44:44 -0400
Received: from mx2.suse.de ([195.135.220.15]:43156 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229890AbhDFToj (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 6 Apr 2021 15:44:39 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id D7061B317;
        Tue,  6 Apr 2021 19:44:28 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id F0482DA732; Tue,  6 Apr 2021 21:42:16 +0200 (CEST)
Date:   Tue, 6 Apr 2021 21:42:16 +0200
From:   David Sterba <dsterba@suse.cz>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH] btrfs: Use readahead_batch_length
Message-ID: <20210406194216.GP7604@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
References: <20210321210311.1803954-1-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210321210311.1803954-1-willy@infradead.org>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Mar 21, 2021 at 09:03:11PM +0000, Matthew Wilcox (Oracle) wrote:
> Implement readahead_batch_length() to determine the number of bytes in
> the current batch of readahead pages and use it in btrfs.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Thanks, I'll take it through my tree as btrfs is probably the only user
of the new helper. The MM list hasn't been CCed, I've added it now but I
think the patch is trivial enough and does not need another ack, so it's
just for the record.

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

--
