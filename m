Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C89A703106
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 May 2023 17:07:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242135AbjEOPHz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 15 May 2023 11:07:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242057AbjEOPHy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 15 May 2023 11:07:54 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40C84173E
        for <linux-fsdevel@vger.kernel.org>; Mon, 15 May 2023 08:07:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684163224;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=OXStdnSGuc4+z/dmbSB5l8N1nXZ+4nBcGjbIe9RKsXQ=;
        b=eOB3XmeTguraw5aEaC5GKcajo8b7VW2Y+sbXK1mm7qLZpi8G1j0KRWTYcI1U6sz6fbmbEy
        QZJ4SbvgFVgqmg9PgrAjDGtlykVEj8u8WvwIAidMt9o1u+hB6MOiA2TedlfLeUYy2vWk/D
        8JVUNAYZgsgExEu5EU/s9KAj2AMBzY0=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-38-cA0-cbRePhexHrfYiIeACA-1; Mon, 15 May 2023 11:07:02 -0400
X-MC-Unique: cA0-cbRePhexHrfYiIeACA-1
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-61abb7cd89cso71584506d6.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 15 May 2023 08:07:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684163222; x=1686755222;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OXStdnSGuc4+z/dmbSB5l8N1nXZ+4nBcGjbIe9RKsXQ=;
        b=djFrfNMY4iwmx5SoGvCMnkoUpX0QrBlptWSau7F1eKlXOsM+yj8L+dBpG/0KbnkVjV
         8ziiMGVg71Z7EBF2x7tLXyfnO3PbYeVGQk21o+MhDv4z6KB7gtOG3sx9fB6BhLUeo/Dj
         9mkqZUn7O6gUzg1MzYm1Pn3UjGRtfSxmfvfKmpNtLcbZKpy4r1JeYGXW/R5NRjIN4z2R
         Kdzzgh4KeypEObUFI2W/ijjEaSZqirWARQ2WuZejy31CGot1tqveGyIR8r8dLgEdO50v
         TqbL9Km1KjIeUi24ogRootdKYFTEZFbZwbRvoyk0UguDuu67sk9qPfNknFEC8ccuwPwL
         fBRA==
X-Gm-Message-State: AC+VfDye/AIlJlmxEXYnhFA697Q/G+RfE3B5QJns9PJLv+sN+cpa1gU4
        agclwF4unT+XkwHnNztiT53+EiY+D5iiaq6cGhWfeE3Ou/z1hJf6YCZYJ5ypb3PVI2IsTWnxMG9
        mKlEr92czf67Gp8YeEGEebfDbEg==
X-Received: by 2002:a05:6214:301a:b0:621:265e:f724 with SMTP id ke26-20020a056214301a00b00621265ef724mr38722743qvb.17.1684163222322;
        Mon, 15 May 2023 08:07:02 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ60fcNUekYah+Ftvuz0iB83ipDpW638HSzONzdaAq2qw9LCXULQ+MNRy9SPWKCd4QU41qkvyw==
X-Received: by 2002:a05:6214:301a:b0:621:265e:f724 with SMTP id ke26-20020a056214301a00b00621265ef724mr38722723qvb.17.1684163222023;
        Mon, 15 May 2023 08:07:02 -0700 (PDT)
Received: from bfoster (c-24-61-119-116.hsd1.ma.comcast.net. [24.61.119.116])
        by smtp.gmail.com with ESMTPSA id o16-20020a0cf4d0000000b006216809b9efsm3010665qvm.108.2023.05.15.08.07.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 May 2023 08:07:01 -0700 (PDT)
Date:   Mon, 15 May 2023 11:09:29 -0400
From:   Brian Foster <bfoster@redhat.com>
To:     "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Matthew Wilcox <willy@infradead.org>,
        Dave Chinner <david@fromorbit.com>,
        Ojaswin Mujoo <ojaswin@linux.ibm.com>,
        Disha Goel <disgoel@linux.ibm.com>
Subject: Re: [RFCv5 2/5] iomap: Refactor iop_set_range_uptodate() function
Message-ID: <ZGJLKdJeNzAtjSZb@bfoster>
References: <cover.1683485700.git.ritesh.list@gmail.com>
 <203a9e25873f6c94c9de89823439aa1f6a7dc714.1683485700.git.ritesh.list@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <203a9e25873f6c94c9de89823439aa1f6a7dc714.1683485700.git.ritesh.list@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, May 08, 2023 at 12:57:57AM +0530, Ritesh Harjani (IBM) wrote:
> This patch moves up and combine the definitions of two functions
> (iomap_iop_set_range_uptodate() & iomap_set_range_uptodate()) into
> iop_set_range_uptodate() & refactors it's arguments a bit.
> 
> No functionality change in this patch.
> 
> Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> ---

Hi Ritesh,

I just have a few random and nitty comments/questions on the series..

>  fs/iomap/buffered-io.c | 57 ++++++++++++++++++++----------------------
>  1 file changed, 27 insertions(+), 30 deletions(-)
> 
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index cbd945d96584..e732581dc2d4 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -43,6 +43,27 @@ static inline struct iomap_page *to_iomap_page(struct folio *folio)
> 
>  static struct bio_set iomap_ioend_bioset;
> 
> +static void iop_set_range_uptodate(struct inode *inode, struct folio *folio,
> +				   size_t off, size_t len)
> +{

Any particular reason this now takes the inode as a param now instead of
continuing to use the folio?

Brian

> +	struct iomap_page *iop = to_iomap_page(folio);
> +	unsigned int first_blk = off >> inode->i_blkbits;
> +	unsigned int last_blk = (off + len - 1) >> inode->i_blkbits;
> +	unsigned int nr_blks = last_blk - first_blk + 1;
> +	unsigned long flags;
> +
> +	if (iop) {
> +		spin_lock_irqsave(&iop->uptodate_lock, flags);
> +		bitmap_set(iop->uptodate, first_blk, nr_blks);
> +		if (bitmap_full(iop->uptodate,
> +				i_blocks_per_folio(inode, folio)))
> +			folio_mark_uptodate(folio);
> +		spin_unlock_irqrestore(&iop->uptodate_lock, flags);
> +	} else {
> +		folio_mark_uptodate(folio);
> +	}
> +}
> +
>  static struct iomap_page *iop_alloc(struct inode *inode, struct folio *folio,
>  				    unsigned int flags)
>  {
> @@ -145,30 +166,6 @@ static void iomap_adjust_read_range(struct inode *inode, struct folio *folio,
>  	*lenp = plen;
>  }
> 
> -static void iomap_iop_set_range_uptodate(struct folio *folio,
> -		struct iomap_page *iop, size_t off, size_t len)
> -{
> -	struct inode *inode = folio->mapping->host;
> -	unsigned first = off >> inode->i_blkbits;
> -	unsigned last = (off + len - 1) >> inode->i_blkbits;
> -	unsigned long flags;
> -
> -	spin_lock_irqsave(&iop->uptodate_lock, flags);
> -	bitmap_set(iop->uptodate, first, last - first + 1);
> -	if (bitmap_full(iop->uptodate, i_blocks_per_folio(inode, folio)))
> -		folio_mark_uptodate(folio);
> -	spin_unlock_irqrestore(&iop->uptodate_lock, flags);
> -}
> -
> -static void iomap_set_range_uptodate(struct folio *folio,
> -		struct iomap_page *iop, size_t off, size_t len)
> -{
> -	if (iop)
> -		iomap_iop_set_range_uptodate(folio, iop, off, len);
> -	else
> -		folio_mark_uptodate(folio);
> -}
> -
>  static void iomap_finish_folio_read(struct folio *folio, size_t offset,
>  		size_t len, int error)
>  {
> @@ -178,7 +175,8 @@ static void iomap_finish_folio_read(struct folio *folio, size_t offset,
>  		folio_clear_uptodate(folio);
>  		folio_set_error(folio);
>  	} else {
> -		iomap_set_range_uptodate(folio, iop, offset, len);
> +		iop_set_range_uptodate(folio->mapping->host, folio, offset,
> +				       len);
>  	}
> 
>  	if (!iop || atomic_sub_and_test(len, &iop->read_bytes_pending))
> @@ -240,7 +238,7 @@ static int iomap_read_inline_data(const struct iomap_iter *iter,
>  	memcpy(addr, iomap->inline_data, size);
>  	memset(addr + size, 0, PAGE_SIZE - poff - size);
>  	kunmap_local(addr);
> -	iomap_set_range_uptodate(folio, iop, offset, PAGE_SIZE - poff);
> +	iop_set_range_uptodate(iter->inode, folio, offset, PAGE_SIZE - poff);
>  	return 0;
>  }
> 
> @@ -277,7 +275,7 @@ static loff_t iomap_readpage_iter(const struct iomap_iter *iter,
> 
>  	if (iomap_block_needs_zeroing(iter, pos)) {
>  		folio_zero_range(folio, poff, plen);
> -		iomap_set_range_uptodate(folio, iop, poff, plen);
> +		iop_set_range_uptodate(iter->inode, folio, poff, plen);
>  		goto done;
>  	}
> 
> @@ -598,7 +596,7 @@ static int __iomap_write_begin(const struct iomap_iter *iter, loff_t pos,
>  			if (status)
>  				return status;
>  		}
> -		iomap_set_range_uptodate(folio, iop, poff, plen);
> +		iop_set_range_uptodate(iter->inode, folio, poff, plen);
>  	} while ((block_start += plen) < block_end);
> 
>  	return 0;
> @@ -705,7 +703,6 @@ static int iomap_write_begin(struct iomap_iter *iter, loff_t pos,
>  static size_t __iomap_write_end(struct inode *inode, loff_t pos, size_t len,
>  		size_t copied, struct folio *folio)
>  {
> -	struct iomap_page *iop = to_iomap_page(folio);
>  	flush_dcache_folio(folio);
> 
>  	/*
> @@ -721,7 +718,7 @@ static size_t __iomap_write_end(struct inode *inode, loff_t pos, size_t len,
>  	 */
>  	if (unlikely(copied < len && !folio_test_uptodate(folio)))
>  		return 0;
> -	iomap_set_range_uptodate(folio, iop, offset_in_folio(folio, pos), len);
> +	iop_set_range_uptodate(inode, folio, offset_in_folio(folio, pos), len);
>  	filemap_dirty_folio(inode->i_mapping, folio);
>  	return copied;
>  }
> --
> 2.39.2
> 

