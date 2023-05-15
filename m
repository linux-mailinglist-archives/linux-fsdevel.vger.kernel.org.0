Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDA8A703109
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 May 2023 17:08:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242166AbjEOPIn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 15 May 2023 11:08:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242110AbjEOPIm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 15 May 2023 11:08:42 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D44C10F0
        for <linux-fsdevel@vger.kernel.org>; Mon, 15 May 2023 08:07:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684163277;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lAB1RqGJjv7PATcYU8PN0nreEXGtl3T5aJhXqT4yzo8=;
        b=iJGO+8gQIN6asMYI42vv2PrzJ5Yu/jeIKwvkcshkX54EOJ3GKaSx+s3bJ1yUhfn5R2Sdi9
        QEKeSAYyB3e9lJjBPbCUzmPitRtMAiiEmucWwbG3J+JFe9BVUltTdfnp65wioiVDh+TerV
        SnQLrNhi8/5XK2TkTmPZ6hvjMviqRtQ=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-15-Udix5qm7PjaaGZXlQcsWSg-1; Mon, 15 May 2023 11:07:56 -0400
X-MC-Unique: Udix5qm7PjaaGZXlQcsWSg-1
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-7577727a00eso3199872185a.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 15 May 2023 08:07:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684163275; x=1686755275;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lAB1RqGJjv7PATcYU8PN0nreEXGtl3T5aJhXqT4yzo8=;
        b=K4HPGLH19FhgdxXHsTzns3hPqiisbMSMQ+1ktzcCNvnSVOiPjgvxREDyQ89yC4cmRg
         5+mjdjKk5oqJg+VNkIBMnW2fAqGc8Zi+y/Q1FyclOIXXaWlEUNETLdg6lIS8R7SPSaUe
         lpw/OWWlLptwDUGGKuk6vclWFeS0Z095X/z9lCdiPoHjbhSrwfPfpx4B1t95dQNT6nDl
         RSSGUwFh2USvINRWj4M0poMeKru44WgoBmY76BM2irg8mgwokcwZSwgu60A/wXGzPxss
         jK5noSH3bvf9hs5im3VQzT1kQsQIVskLQPi6SaJh/VSrnSSqrMQU+qqUSuXbXeWf+9e+
         JuVw==
X-Gm-Message-State: AC+VfDxq87z0Nd6U1ic+M+EQ9q1d2CL77wdAaxNYcpgAkD1U9KkCEIgQ
        U6xFbyMd5Q0xMI33NvUV4qKO2QtVFoVCraUde9eAtcpy33dEqAdEwo81fB+aSkj3Q+qeLa/Ybgw
        TpERn3yq7P4C2ev6J6jgEwRLOPYGGZ0DdTQ==
X-Received: by 2002:ad4:5d44:0:b0:5fd:93b7:5a96 with SMTP id jk4-20020ad45d44000000b005fd93b75a96mr59124181qvb.26.1684163275202;
        Mon, 15 May 2023 08:07:55 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5fM0kDXOeCHFTDqAarNE23N9hNNNP5tvo5fd6QQkUS51uAPuJy+nC99z887hxJo0oAeeDkJQ==
X-Received: by 2002:ad4:5d44:0:b0:5fd:93b7:5a96 with SMTP id jk4-20020ad45d44000000b005fd93b75a96mr59124143qvb.26.1684163274928;
        Mon, 15 May 2023 08:07:54 -0700 (PDT)
Received: from bfoster (c-24-61-119-116.hsd1.ma.comcast.net. [24.61.119.116])
        by smtp.gmail.com with ESMTPSA id z24-20020ae9c118000000b0075935a24760sm1484836qki.136.2023.05.15.08.07.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 May 2023 08:07:53 -0700 (PDT)
Date:   Mon, 15 May 2023 11:10:21 -0400
From:   Brian Foster <bfoster@redhat.com>
To:     "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Matthew Wilcox <willy@infradead.org>,
        Dave Chinner <david@fromorbit.com>,
        Ojaswin Mujoo <ojaswin@linux.ibm.com>,
        Disha Goel <disgoel@linux.ibm.com>
Subject: Re: [RFCv5 3/5] iomap: Add iop's uptodate state handling functions
Message-ID: <ZGJLXcTkzdyHY25d@bfoster>
References: <cover.1683485700.git.ritesh.list@gmail.com>
 <5372f29f986052f37b45c368a0eb8eed25eb8fdb.1683485700.git.ritesh.list@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5372f29f986052f37b45c368a0eb8eed25eb8fdb.1683485700.git.ritesh.list@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, May 08, 2023 at 12:57:58AM +0530, Ritesh Harjani (IBM) wrote:
> Firstly this patch renames iop->uptodate to iop->state bitmap.
> This is because we will add dirty state to iop->state bitmap in later
> patches. So it makes sense to rename the iop->uptodate bitmap to
> iop->state.
> 
> Secondly this patch also adds other helpers for uptodate state bitmap
> handling of iop->state.
> 
> No functionality change in this patch.
> 
> Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> ---
>  fs/iomap/buffered-io.c | 78 +++++++++++++++++++++++++++++++-----------
>  1 file changed, 58 insertions(+), 20 deletions(-)
> 
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index e732581dc2d4..5103b644e115 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
...
> @@ -43,6 +43,47 @@ static inline struct iomap_page *to_iomap_page(struct folio *folio)
...
> +/*
> + * iop related helpers for checking uptodate/dirty state of per-block
> + * or range of blocks within a folio
> + */
> +static bool iop_test_full_uptodate(struct folio *folio)
> +{
> +	struct iomap_page *iop = to_iomap_page(folio);
> +	struct inode *inode = folio->mapping->host;
> +
> +	WARN_ON(!iop);

It looks like an oops or something is imminent here if iop is NULL. Why
the warn (here and in a couple other places)?

Brian

> +	return iop_bitmap_full(iop, i_blocks_per_folio(inode, folio));
> +}
> +
> +static bool iop_test_block_uptodate(struct folio *folio, unsigned int block)
> +{
> +	struct iomap_page *iop = to_iomap_page(folio);
> +
> +	WARN_ON(!iop);
> +	return iop_test_block(iop, block);
> +}
> +
>  static void iop_set_range_uptodate(struct inode *inode, struct folio *folio,
>  				   size_t off, size_t len)
>  {
> @@ -53,12 +94,11 @@ static void iop_set_range_uptodate(struct inode *inode, struct folio *folio,
>  	unsigned long flags;
>  
>  	if (iop) {
> -		spin_lock_irqsave(&iop->uptodate_lock, flags);
> -		bitmap_set(iop->uptodate, first_blk, nr_blks);
> -		if (bitmap_full(iop->uptodate,
> -				i_blocks_per_folio(inode, folio)))
> +		spin_lock_irqsave(&iop->state_lock, flags);
> +		iop_set_range(iop, first_blk, nr_blks);
> +		if (iop_test_full_uptodate(folio))
>  			folio_mark_uptodate(folio);
> -		spin_unlock_irqrestore(&iop->uptodate_lock, flags);
> +		spin_unlock_irqrestore(&iop->state_lock, flags);
>  	} else {
>  		folio_mark_uptodate(folio);
>  	}
> @@ -79,12 +119,12 @@ static struct iomap_page *iop_alloc(struct inode *inode, struct folio *folio,
>  	else
>  		gfp = GFP_NOFS | __GFP_NOFAIL;
>  
> -	iop = kzalloc(struct_size(iop, uptodate, BITS_TO_LONGS(nr_blocks)),
> +	iop = kzalloc(struct_size(iop, state, BITS_TO_LONGS(nr_blocks)),
>  		      gfp);
>  	if (iop) {
> -		spin_lock_init(&iop->uptodate_lock);
> +		spin_lock_init(&iop->state_lock);
>  		if (folio_test_uptodate(folio))
> -			bitmap_fill(iop->uptodate, nr_blocks);
> +			iop_set_range(iop, 0, nr_blocks);
>  		folio_attach_private(folio, iop);
>  	}
>  	return iop;
> @@ -93,15 +133,13 @@ static struct iomap_page *iop_alloc(struct inode *inode, struct folio *folio,
>  static void iop_free(struct folio *folio)
>  {
>  	struct iomap_page *iop = to_iomap_page(folio);
> -	struct inode *inode = folio->mapping->host;
> -	unsigned int nr_blocks = i_blocks_per_folio(inode, folio);
>  
>  	if (!iop)
>  		return;
>  	WARN_ON_ONCE(atomic_read(&iop->read_bytes_pending));
>  	WARN_ON_ONCE(atomic_read(&iop->write_bytes_pending));
> -	WARN_ON_ONCE(bitmap_full(iop->uptodate, nr_blocks) !=
> -			folio_test_uptodate(folio));
> +	WARN_ON_ONCE(iop_test_full_uptodate(folio) !=
> +		     folio_test_uptodate(folio));
>  	folio_detach_private(folio);
>  	kfree(iop);
>  }
> @@ -132,7 +170,7 @@ static void iomap_adjust_read_range(struct inode *inode, struct folio *folio,
>  
>  		/* move forward for each leading block marked uptodate */
>  		for (i = first; i <= last; i++) {
> -			if (!test_bit(i, iop->uptodate))
> +			if (!iop_test_block_uptodate(folio, i))
>  				break;
>  			*pos += block_size;
>  			poff += block_size;
> @@ -142,7 +180,7 @@ static void iomap_adjust_read_range(struct inode *inode, struct folio *folio,
>  
>  		/* truncate len if we find any trailing uptodate block(s) */
>  		for ( ; i <= last; i++) {
> -			if (test_bit(i, iop->uptodate)) {
> +			if (iop_test_block_uptodate(folio, i)) {
>  				plen -= (last - i + 1) * block_size;
>  				last = i - 1;
>  				break;
> @@ -450,7 +488,7 @@ bool iomap_is_partially_uptodate(struct folio *folio, size_t from, size_t count)
>  	last = (from + count - 1) >> inode->i_blkbits;
>  
>  	for (i = first; i <= last; i++)
> -		if (!test_bit(i, iop->uptodate))
> +		if (!iop_test_block_uptodate(folio, i))
>  			return false;
>  	return true;
>  }
> @@ -1634,7 +1672,7 @@ iomap_writepage_map(struct iomap_writepage_ctx *wpc,
>  	 * invalid, grab a new one.
>  	 */
>  	for (i = 0; i < nblocks && pos < end_pos; i++, pos += len) {
> -		if (iop && !test_bit(i, iop->uptodate))
> +		if (iop && !iop_test_block_uptodate(folio, i))
>  			continue;
>  
>  		error = wpc->ops->map_blocks(wpc, inode, pos);
> -- 
> 2.39.2
> 

