Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEDD175177C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Jul 2023 06:32:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233655AbjGMEcM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Jul 2023 00:32:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232343AbjGMEcL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Jul 2023 00:32:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D2C6E4D;
        Wed, 12 Jul 2023 21:32:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0C11D6190F;
        Thu, 13 Jul 2023 04:32:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6860BC433C8;
        Thu, 13 Jul 2023 04:32:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689222728;
        bh=n6qRu89iBPmklNsYsnxnInzcxjnAjWDC1a0poFvggak=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GwCj10OinQbDtvxx8J9Ahky1Ev7dskgDsdEHMfKEG8yxYUjATdgfTtw58ngTwo1Th
         u5T4mnpRUj5iZ23iInMeg5bik6+ca7cX/az9a5CDpTfjwxptAaa/T2wv0Y0CEP5wxU
         jUqjBZ/lAsM0zhIFJKMGCXdmqY6BHnrqkIayMicE/ymPyRYhDIGH+2xSa96+5e4V5U
         AswR6ykMjwWFgDXsnX+MqdvRkVe7MF6a8HNqw184khtUDfzXmtuLnUhfqwYzUtEzPq
         7g6v88I/lkH0Z7Jex8kufozfhT9AYA5gU8UOmlJIw0xi03uimjw7dN2F8tlc+pQUhj
         DnBDZ+hXX7xdw==
Date:   Wed, 12 Jul 2023 21:32:08 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Matthew Wilcox <willy@infradead.org>,
        Christoph Hellwig <hch@infradead.org>,
        Brian Foster <bfoster@redhat.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCHv11 3/8] iomap: Add some uptodate state handling helpers
 for ifs state bitmap
Message-ID: <20230713043208.GC108251@frogsfrogsfrogs>
References: <cover.1688188958.git.ritesh.list@gmail.com>
 <04ba7f53e55649a908943b6c7c27ef333d47c71f.1688188958.git.ritesh.list@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <04ba7f53e55649a908943b6c7c27ef333d47c71f.1688188958.git.ritesh.list@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Jul 01, 2023 at 01:04:36PM +0530, Ritesh Harjani (IBM) wrote:
> This patch adds two of the helper routines ifs_is_fully_uptodate()
> and ifs_block_is_uptodate() for managing uptodate state of "ifs" state
> bitmap.
> 
> In later patches ifs state bitmap array will also handle dirty state of all
> blocks of a folio. Hence this patch adds some helper routines for handling
> uptodate state of the ifs state bitmap.
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>

Nice cleanup,
Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> ---
>  fs/iomap/buffered-io.c | 28 ++++++++++++++++++++--------
>  1 file changed, 20 insertions(+), 8 deletions(-)
> 
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index 3ff7688b360a..e45368e91eca 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -36,6 +36,20 @@ struct iomap_folio_state {
>  
>  static struct bio_set iomap_ioend_bioset;
>  
> +static inline bool ifs_is_fully_uptodate(struct folio *folio,
> +		struct iomap_folio_state *ifs)
> +{
> +	struct inode *inode = folio->mapping->host;
> +
> +	return bitmap_full(ifs->state, i_blocks_per_folio(inode, folio));
> +}
> +
> +static inline bool ifs_block_is_uptodate(struct iomap_folio_state *ifs,
> +		unsigned int block)
> +{
> +	return test_bit(block, ifs->state);
> +}
> +
>  static void ifs_set_range_uptodate(struct folio *folio,
>  		struct iomap_folio_state *ifs, size_t off, size_t len)
>  {
> @@ -47,7 +61,7 @@ static void ifs_set_range_uptodate(struct folio *folio,
>  
>  	spin_lock_irqsave(&ifs->state_lock, flags);
>  	bitmap_set(ifs->state, first_blk, nr_blks);
> -	if (bitmap_full(ifs->state, i_blocks_per_folio(inode, folio)))
> +	if (ifs_is_fully_uptodate(folio, ifs))
>  		folio_mark_uptodate(folio);
>  	spin_unlock_irqrestore(&ifs->state_lock, flags);
>  }
> @@ -92,14 +106,12 @@ static struct iomap_folio_state *ifs_alloc(struct inode *inode,
>  static void ifs_free(struct folio *folio)
>  {
>  	struct iomap_folio_state *ifs = folio_detach_private(folio);
> -	struct inode *inode = folio->mapping->host;
> -	unsigned int nr_blocks = i_blocks_per_folio(inode, folio);
>  
>  	if (!ifs)
>  		return;
>  	WARN_ON_ONCE(atomic_read(&ifs->read_bytes_pending));
>  	WARN_ON_ONCE(atomic_read(&ifs->write_bytes_pending));
> -	WARN_ON_ONCE(bitmap_full(ifs->state, nr_blocks) !=
> +	WARN_ON_ONCE(ifs_is_fully_uptodate(folio, ifs) !=
>  			folio_test_uptodate(folio));
>  	kfree(ifs);
>  }
> @@ -130,7 +142,7 @@ static void iomap_adjust_read_range(struct inode *inode, struct folio *folio,
>  
>  		/* move forward for each leading block marked uptodate */
>  		for (i = first; i <= last; i++) {
> -			if (!test_bit(i, ifs->state))
> +			if (!ifs_block_is_uptodate(ifs, i))
>  				break;
>  			*pos += block_size;
>  			poff += block_size;
> @@ -140,7 +152,7 @@ static void iomap_adjust_read_range(struct inode *inode, struct folio *folio,
>  
>  		/* truncate len if we find any trailing uptodate block(s) */
>  		for ( ; i <= last; i++) {
> -			if (test_bit(i, ifs->state)) {
> +			if (ifs_block_is_uptodate(ifs, i)) {
>  				plen -= (last - i + 1) * block_size;
>  				last = i - 1;
>  				break;
> @@ -444,7 +456,7 @@ bool iomap_is_partially_uptodate(struct folio *folio, size_t from, size_t count)
>  	last = (from + count - 1) >> inode->i_blkbits;
>  
>  	for (i = first; i <= last; i++)
> -		if (!test_bit(i, ifs->state))
> +		if (!ifs_block_is_uptodate(ifs, i))
>  			return false;
>  	return true;
>  }
> @@ -1620,7 +1632,7 @@ iomap_writepage_map(struct iomap_writepage_ctx *wpc,
>  	 * invalid, grab a new one.
>  	 */
>  	for (i = 0; i < nblocks && pos < end_pos; i++, pos += len) {
> -		if (ifs && !test_bit(i, ifs->state))
> +		if (ifs && !ifs_block_is_uptodate(ifs, i))
>  			continue;
>  
>  		error = wpc->ops->map_blocks(wpc, inode, pos);
> -- 
> 2.40.1
> 
