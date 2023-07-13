Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 650B875177A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Jul 2023 06:31:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233486AbjGMEbw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Jul 2023 00:31:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232343AbjGMEbu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Jul 2023 00:31:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E31D19BE;
        Wed, 12 Jul 2023 21:31:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DA3E6619B0;
        Thu, 13 Jul 2023 04:31:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 441E2C433C8;
        Thu, 13 Jul 2023 04:31:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689222708;
        bh=qxsE+iYut+x6Bg1j3kCCv8tSKCCRxtkvURB6SLfZ+CI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GmQDI30wJHqY8ACaCidr6OApEw85T/fCm9nCc35glmvNt60nNqxEIRuE2xoOrl9RB
         AmHbTGNOVTY1kqNMSgYdj+LUsvGDfowMvOo4RFx/mrc/nTi6z74z5peNJaqPY45kY1
         RJpMir7WrLojN4lFV4bsQOKLiT2WuvcIk1jR0FvDCCuFbVARoHWKxoUHCgNYHj2HX5
         05Zok+uqsF2aqz9A2z8EJxDsSQDISizPx8JsO1Ix6f0ZMlBbjoTe/xhfJvTbIu/46/
         2zj7B+cQ5qrwwZfllgi/jvFRAFd04x6TeiE8W+um5TIzirgpbF+X1YgdMBxXDM0sXD
         4+l3RID8muToA==
Date:   Wed, 12 Jul 2023 21:31:47 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Matthew Wilcox <willy@infradead.org>,
        Christoph Hellwig <hch@infradead.org>,
        Brian Foster <bfoster@redhat.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCHv11 2/8] iomap: Drop ifs argument from
 iomap_set_range_uptodate()
Message-ID: <20230713043147.GB108251@frogsfrogsfrogs>
References: <cover.1688188958.git.ritesh.list@gmail.com>
 <d23a8d36820d1b5be0b2ffaa37ad07f816f73b01.1688188958.git.ritesh.list@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d23a8d36820d1b5be0b2ffaa37ad07f816f73b01.1688188958.git.ritesh.list@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Jul 01, 2023 at 01:04:35PM +0530, Ritesh Harjani (IBM) wrote:
> iomap_folio_state (ifs) can be derived directly from the folio, making it
> unnecessary to pass "ifs" as an argument to iomap_set_range_uptodate().
> This patch eliminates "ifs" argument from iomap_set_range_uptodate()
> function.
> 
> Also, the definition of iomap_set_range_uptodate() and
> ifs_set_range_uptodate() functions are moved above ifs_alloc().
> In upcoming patches, we plan to introduce additional helper routines for
> handling dirty state, with the intention of consolidating all of "ifs"
> state handling routines at one place.
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>

Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> ---
>  fs/iomap/buffered-io.c | 67 +++++++++++++++++++++---------------------
>  1 file changed, 33 insertions(+), 34 deletions(-)
> 
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index 2675a3e0ac1d..3ff7688b360a 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -36,6 +36,33 @@ struct iomap_folio_state {
>  
>  static struct bio_set iomap_ioend_bioset;
>  
> +static void ifs_set_range_uptodate(struct folio *folio,
> +		struct iomap_folio_state *ifs, size_t off, size_t len)
> +{
> +	struct inode *inode = folio->mapping->host;
> +	unsigned int first_blk = off >> inode->i_blkbits;
> +	unsigned int last_blk = (off + len - 1) >> inode->i_blkbits;
> +	unsigned int nr_blks = last_blk - first_blk + 1;
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&ifs->state_lock, flags);
> +	bitmap_set(ifs->state, first_blk, nr_blks);
> +	if (bitmap_full(ifs->state, i_blocks_per_folio(inode, folio)))
> +		folio_mark_uptodate(folio);
> +	spin_unlock_irqrestore(&ifs->state_lock, flags);
> +}
> +
> +static void iomap_set_range_uptodate(struct folio *folio, size_t off,
> +		size_t len)
> +{
> +	struct iomap_folio_state *ifs = folio->private;
> +
> +	if (ifs)
> +		ifs_set_range_uptodate(folio, ifs, off, len);
> +	else
> +		folio_mark_uptodate(folio);
> +}
> +
>  static struct iomap_folio_state *ifs_alloc(struct inode *inode,
>  		struct folio *folio, unsigned int flags)
>  {
> @@ -137,30 +164,6 @@ static void iomap_adjust_read_range(struct inode *inode, struct folio *folio,
>  	*lenp = plen;
>  }
>  
> -static void ifs_set_range_uptodate(struct folio *folio,
> -		struct iomap_folio_state *ifs, size_t off, size_t len)
> -{
> -	struct inode *inode = folio->mapping->host;
> -	unsigned first = off >> inode->i_blkbits;
> -	unsigned last = (off + len - 1) >> inode->i_blkbits;
> -	unsigned long flags;
> -
> -	spin_lock_irqsave(&ifs->state_lock, flags);
> -	bitmap_set(ifs->state, first, last - first + 1);
> -	if (bitmap_full(ifs->state, i_blocks_per_folio(inode, folio)))
> -		folio_mark_uptodate(folio);
> -	spin_unlock_irqrestore(&ifs->state_lock, flags);
> -}
> -
> -static void iomap_set_range_uptodate(struct folio *folio,
> -		struct iomap_folio_state *ifs, size_t off, size_t len)
> -{
> -	if (ifs)
> -		ifs_set_range_uptodate(folio, ifs, off, len);
> -	else
> -		folio_mark_uptodate(folio);
> -}
> -
>  static void iomap_finish_folio_read(struct folio *folio, size_t offset,
>  		size_t len, int error)
>  {
> @@ -170,7 +173,7 @@ static void iomap_finish_folio_read(struct folio *folio, size_t offset,
>  		folio_clear_uptodate(folio);
>  		folio_set_error(folio);
>  	} else {
> -		iomap_set_range_uptodate(folio, ifs, offset, len);
> +		iomap_set_range_uptodate(folio, offset, len);
>  	}
>  
>  	if (!ifs || atomic_sub_and_test(len, &ifs->read_bytes_pending))
> @@ -206,7 +209,6 @@ struct iomap_readpage_ctx {
>  static int iomap_read_inline_data(const struct iomap_iter *iter,
>  		struct folio *folio)
>  {
> -	struct iomap_folio_state *ifs;
>  	const struct iomap *iomap = iomap_iter_srcmap(iter);
>  	size_t size = i_size_read(iter->inode) - iomap->offset;
>  	size_t poff = offset_in_page(iomap->offset);
> @@ -224,15 +226,13 @@ static int iomap_read_inline_data(const struct iomap_iter *iter,
>  	if (WARN_ON_ONCE(size > iomap->length))
>  		return -EIO;
>  	if (offset > 0)
> -		ifs = ifs_alloc(iter->inode, folio, iter->flags);
> -	else
> -		ifs = folio->private;
> +		ifs_alloc(iter->inode, folio, iter->flags);
>  
>  	addr = kmap_local_folio(folio, offset);
>  	memcpy(addr, iomap->inline_data, size);
>  	memset(addr + size, 0, PAGE_SIZE - poff - size);
>  	kunmap_local(addr);
> -	iomap_set_range_uptodate(folio, ifs, offset, PAGE_SIZE - poff);
> +	iomap_set_range_uptodate(folio, offset, PAGE_SIZE - poff);
>  	return 0;
>  }
>  
> @@ -269,7 +269,7 @@ static loff_t iomap_readpage_iter(const struct iomap_iter *iter,
>  
>  	if (iomap_block_needs_zeroing(iter, pos)) {
>  		folio_zero_range(folio, poff, plen);
> -		iomap_set_range_uptodate(folio, ifs, poff, plen);
> +		iomap_set_range_uptodate(folio, poff, plen);
>  		goto done;
>  	}
>  
> @@ -582,7 +582,7 @@ static int __iomap_write_begin(const struct iomap_iter *iter, loff_t pos,
>  			if (status)
>  				return status;
>  		}
> -		iomap_set_range_uptodate(folio, ifs, poff, plen);
> +		iomap_set_range_uptodate(folio, poff, plen);
>  	} while ((block_start += plen) < block_end);
>  
>  	return 0;
> @@ -689,7 +689,6 @@ static int iomap_write_begin(struct iomap_iter *iter, loff_t pos,
>  static size_t __iomap_write_end(struct inode *inode, loff_t pos, size_t len,
>  		size_t copied, struct folio *folio)
>  {
> -	struct iomap_folio_state *ifs = folio->private;
>  	flush_dcache_folio(folio);
>  
>  	/*
> @@ -705,7 +704,7 @@ static size_t __iomap_write_end(struct inode *inode, loff_t pos, size_t len,
>  	 */
>  	if (unlikely(copied < len && !folio_test_uptodate(folio)))
>  		return 0;
> -	iomap_set_range_uptodate(folio, ifs, offset_in_folio(folio, pos), len);
> +	iomap_set_range_uptodate(folio, offset_in_folio(folio, pos), len);
>  	filemap_dirty_folio(inode->i_mapping, folio);
>  	return copied;
>  }
> -- 
> 2.40.1
> 
