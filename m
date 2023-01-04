Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 023CD65DB63
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Jan 2023 18:40:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235327AbjADRkW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Jan 2023 12:40:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjADRkV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Jan 2023 12:40:21 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C80D39FB9;
        Wed,  4 Jan 2023 09:40:20 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CA997617AE;
        Wed,  4 Jan 2023 17:40:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 367CCC433EF;
        Wed,  4 Jan 2023 17:40:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672854019;
        bh=oxp/Cr7eBnm/fkJ0XG8CB8iaZWIlZwSJNK6IkH9kUkg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZAb/EZs3k+G6JEZUw2utoeQZ7xzLKwNtvwMhM960foUvai+Oib6hQAF/JtITbGBSL
         wntXJjRrumQrw2sp2ssNCs5e17N4JrwYtfO+HDttGMMYPWn6rMbVt50PLuQWumoGon
         jGdEpBiYOoHQvExCwqjmgdbVPWy8ySlB3Tuv7CiyIO04ucgVNzROEXrLlA7ytmwO2b
         v8V7UtrWwZdIAXQogTDGTqQBZiK8gQBCetseQIIPUBPzI/82/0hkWG1FTKKiKmtgEK
         hMTvX4mc2LgJH7hSghx9JEESpdshfwSpK/5F0ViD60JxwP/md7ScOMsxiE04X59ieK
         +5JKnlENkf2DQ==
Date:   Wed, 4 Jan 2023 09:40:18 -0800
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Andreas Gruenbacher <agruenba@redhat.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, cluster-devel@redhat.com
Subject: Re: [PATCH v5 2/9] iomap/gfs2: Unlock and put folio in page_done
 handler
Message-ID: <Y7W6AittyYB5/bok@magnolia>
References: <20221231150919.659533-1-agruenba@redhat.com>
 <20221231150919.659533-3-agruenba@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221231150919.659533-3-agruenba@redhat.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Dec 31, 2022 at 04:09:12PM +0100, Andreas Gruenbacher wrote:
> When an iomap defines a ->page_done() handler in its page_ops, delegate
> unlocking the folio and putting the folio reference to that handler.
> 
> This allows to fix a race between journaled data writes and folio
> writeback in gfs2: before this change, gfs2_iomap_page_done() was called
> after unlocking the folio, so writeback could start writing back the
> folio's buffers before they could be marked for writing to the journal.
> Also, try_to_free_buffers() could free the buffers before
> gfs2_iomap_page_done() was done adding the buffers to the current
> current transaction.  With this change, gfs2_iomap_page_done() adds the
> buffers to the current transaction while the folio is still locked, so
> the problems described above can no longer occur.
> 
> The only current user of ->page_done() is gfs2, so other filesystems are
> not affected.  To catch out any out-of-tree users, switch from a page to
> a folio in ->page_done().

I really hope there aren't any out of tree users...

> Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>

Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> ---
>  fs/gfs2/bmap.c         | 15 ++++++++++++---
>  fs/iomap/buffered-io.c |  8 ++++----
>  include/linux/iomap.h  |  7 ++++---
>  3 files changed, 20 insertions(+), 10 deletions(-)
> 
> diff --git a/fs/gfs2/bmap.c b/fs/gfs2/bmap.c
> index e7537fd305dd..46206286ad42 100644
> --- a/fs/gfs2/bmap.c
> +++ b/fs/gfs2/bmap.c
> @@ -968,14 +968,23 @@ static int gfs2_iomap_page_prepare(struct inode *inode, loff_t pos,
>  }
>  
>  static void gfs2_iomap_page_done(struct inode *inode, loff_t pos,
> -				 unsigned copied, struct page *page)
> +				 unsigned copied, struct folio *folio)
>  {
>  	struct gfs2_trans *tr = current->journal_info;
>  	struct gfs2_inode *ip = GFS2_I(inode);
>  	struct gfs2_sbd *sdp = GFS2_SB(inode);
>  
> -	if (page && !gfs2_is_stuffed(ip))
> -		gfs2_page_add_databufs(ip, page, offset_in_page(pos), copied);
> +	if (!folio) {
> +		gfs2_trans_end(sdp);
> +		return;
> +	}
> +
> +	if (!gfs2_is_stuffed(ip))
> +		gfs2_page_add_databufs(ip, &folio->page, offset_in_page(pos),
> +				       copied);
> +
> +	folio_unlock(folio);
> +	folio_put(folio);
>  
>  	if (tr->tr_num_buf_new)
>  		__mark_inode_dirty(inode, I_DIRTY_DATASYNC);
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index c30d150a9303..e13d5694e299 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -580,12 +580,12 @@ static void iomap_put_folio(struct iomap_iter *iter, loff_t pos, size_t ret,
>  {
>  	const struct iomap_page_ops *page_ops = iter->iomap.page_ops;
>  
> -	if (folio)
> +	if (page_ops && page_ops->page_done) {
> +		page_ops->page_done(iter->inode, pos, ret, folio);
> +	} else if (folio) {
>  		folio_unlock(folio);
> -	if (page_ops && page_ops->page_done)
> -		page_ops->page_done(iter->inode, pos, ret, &folio->page);
> -	if (folio)
>  		folio_put(folio);
> +	}
>  }
>  
>  static int iomap_write_begin_inline(const struct iomap_iter *iter,
> diff --git a/include/linux/iomap.h b/include/linux/iomap.h
> index 0983dfc9a203..743e2a909162 100644
> --- a/include/linux/iomap.h
> +++ b/include/linux/iomap.h
> @@ -131,13 +131,14 @@ static inline bool iomap_inline_data_valid(const struct iomap *iomap)
>   * associated with them.
>   *
>   * When page_prepare succeeds, page_done will always be called to do any
> - * cleanup work necessary.  In that page_done call, @page will be NULL if the
> - * associated page could not be obtained.
> + * cleanup work necessary.  In that page_done call, @folio will be NULL if the
> + * associated folio could not be obtained.  When folio is not NULL, page_done
> + * is responsible for unlocking and putting the folio.
>   */
>  struct iomap_page_ops {
>  	int (*page_prepare)(struct inode *inode, loff_t pos, unsigned len);
>  	void (*page_done)(struct inode *inode, loff_t pos, unsigned copied,
> -			struct page *page);
> +			struct folio *folio);
>  
>  	/*
>  	 * Check that the cached iomap still maps correctly to the filesystem's
> -- 
> 2.38.1
> 
