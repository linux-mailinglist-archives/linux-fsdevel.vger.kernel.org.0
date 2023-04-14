Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DE6E6E23FB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Apr 2023 15:06:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229721AbjDNNGq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 14 Apr 2023 09:06:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbjDNNGp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 14 Apr 2023 09:06:45 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9BD48F;
        Fri, 14 Apr 2023 06:06:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ov9Nv07vd2ONH43CkakQ5l8x67Im3l3yCqIZ1sqEEJk=; b=IwvUrl7tORipAsI0Ov77Oqy48t
        85/Ml2o5mzC0vuExBMNJhHiEtFWLdvxySaqlrkvZuE2a6iIlYk9wxgTr8uFu4XUOAkBwLWPZX27GJ
        NUnt7k2cBbT6k33Xzb6u4rmbsxTEHKxu/jdqdRjeBAGeNdKs21xjxyz/yddGIdnw4a/t1aQf0yN4F
        SgMWovBo/GBkoN0VgkzTSa7h38JrYMnI/8ORybSCZnZ4zFwENyxeXyrx1t+nnoY6Zi9bGrpfaHBXH
        2jirsa+RgpGByNJHSpE0ygsglhv/0Y0G/eaxGkmFa7N8Q2sjN+wbonmoOmZh2JwhYhQDRk0lami34
        Y7TF7/cw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pnJ8L-008lSJ-KC; Fri, 14 Apr 2023 13:06:33 +0000
Date:   Fri, 14 Apr 2023 14:06:33 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Pankaj Raghav <p.raghav@samsung.com>
Cc:     brauner@kernel.org, viro@zeniv.linux.org.uk,
        akpm@linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, mcgrof@kernel.org,
        gost.dev@samsung.com, hare@suse.de
Subject: Re: [RFC 2/4] buffer: add alloc_folio_buffers() helper
Message-ID: <ZDlP2fevtfD5gMPd@casper.infradead.org>
References: <20230414110821.21548-1-p.raghav@samsung.com>
 <CGME20230414110826eucas1p2c5afcbd64c536a803751b41d03eb9e99@eucas1p2.samsung.com>
 <20230414110821.21548-3-p.raghav@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230414110821.21548-3-p.raghav@samsung.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Apr 14, 2023 at 01:08:19PM +0200, Pankaj Raghav wrote:
> Folio version of alloc_page_buffers() helper. This is required to convert
> create_page_buffers() to create_folio_buffers() later in the series.
> 
> It removes one call to compound_head() compared to alloc_page_buffers().

I would convert alloc_page_buffers() to folio_alloc_buffers() and
add

static struct buffer_head *alloc_page_buffers(struct page *page,
		unsigned long size, bool retry)
{
	return folio_alloc_buffers(page_folio(page), size, retry);
}

in buffer_head.h

(there are only five callers, so this feels like a better tradeoff
than creating a new function)

> Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
> ---
>  fs/buffer.c | 59 +++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 59 insertions(+)
> 
> diff --git a/fs/buffer.c b/fs/buffer.c
> index 44380ff3a31f..0f9c2127543d 100644
> --- a/fs/buffer.c
> +++ b/fs/buffer.c
> @@ -900,6 +900,65 @@ struct buffer_head *alloc_page_buffers(struct page *page, unsigned long size,
>  }
>  EXPORT_SYMBOL_GPL(alloc_page_buffers);
>  
> +/*
> + * Create the appropriate buffers when given a folio for data area and
> + * the size of each buffer.. Use the bh->b_this_page linked list to
> + * follow the buffers created.  Return NULL if unable to create more
> + * buffers.
> + *
> + * The retry flag is used to differentiate async IO (paging, swapping)
> + * which may not fail from ordinary buffer allocations.
> + */
> +struct buffer_head *alloc_folio_buffers(struct folio *folio, unsigned long size,
> +					bool retry)
> +{
> +	struct buffer_head *bh, *head;
> +	gfp_t gfp = GFP_NOFS | __GFP_ACCOUNT;
> +	long offset;
> +	struct mem_cgroup *memcg, *old_memcg;
> +
> +	if (retry)
> +		gfp |= __GFP_NOFAIL;
> +
> +	/* The folio lock pins the memcg */
> +	memcg = folio_memcg(folio);
> +	old_memcg = set_active_memcg(memcg);
> +
> +	head = NULL;
> +	offset = folio_size(folio);
> +	while ((offset -= size) >= 0) {
> +		bh = alloc_buffer_head(gfp);
> +		if (!bh)
> +			goto no_grow;
> +
> +		bh->b_this_page = head;
> +		bh->b_blocknr = -1;
> +		head = bh;
> +
> +		bh->b_size = size;
> +
> +		/* Link the buffer to its folio */
> +		set_bh_folio(bh, folio, offset);
> +	}
> +out:
> +	set_active_memcg(old_memcg);
> +	return head;
> +/*
> + * In case anything failed, we just free everything we got.
> + */
> +no_grow:
> +	if (head) {
> +		do {
> +			bh = head;
> +			head = head->b_this_page;
> +			free_buffer_head(bh);
> +		} while (head);
> +	}
> +
> +	goto out;
> +}
> +EXPORT_SYMBOL_GPL(alloc_folio_buffers);
> +
>  static inline void
>  link_dev_buffers(struct page *page, struct buffer_head *head)
>  {
> -- 
> 2.34.1
> 
