Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9C066551B1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Dec 2022 15:56:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236425AbiLWO4U (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 23 Dec 2022 09:56:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229658AbiLWO4U (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 23 Dec 2022 09:56:20 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 467FA1A047;
        Fri, 23 Dec 2022 06:56:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=T0IzOuznf6jL2kGG15kuuaoVimSHPTfo71bEOOPjJZA=; b=YrW2NgDwKTrbrWOGs0aUyCmthg
        dnuyDQ5co4JncqoOjZq6C/PqP2cYfpc0fk/o38kq68yanbk+vSUrGn4t4JFmcWses3SMl3mgpVJlX
        g9N2WhR/neB3l0EN+WMaUg75aeODf6+6qtz9tNJPhR97MKY8esuoIBtqI9gsBaPyM24rydkv/Wm8b
        i9WR3hcB1wCHxhRpTqsjese7K49E+sIzwRDqi1iXgqQ5awmoKgXlOUN125D+wGkPnhRhxVlD/p8en
        UQNKFAqaJXKxFxyM1KohD3Tjb0GA3qVDkDB7u1qk9POnBcC5n/VLgUw+P4khYydw/uSmk0XDR4BM7
        8IS2WJhA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1p8jT1-0096pR-35; Fri, 23 Dec 2022 14:56:11 +0000
Date:   Fri, 23 Dec 2022 06:56:11 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Andreas Gruenbacher <agruenba@redhat.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, cluster-devel@redhat.com
Subject: Re: [RFC v3 1/7] fs: Add folio_may_straddle_isize helper
Message-ID: <Y6XBi/YJ4QV3NK5q@infradead.org>
References: <20221216150626.670312-1-agruenba@redhat.com>
 <20221216150626.670312-2-agruenba@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221216150626.670312-2-agruenba@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Dec 16, 2022 at 04:06:20PM +0100, Andreas Gruenbacher wrote:
> Add a folio_may_straddle_isize() helper as a replacement for
> pagecache_isize_extended() when we have a locked folio.

I find the naming very confusing.  Any good reason to not follow
the naming of pagecache_isize_extended an call it
folio_isize_extended?

> Use the new helper in generic_write_end(), iomap_write_end(),
> ext4_write_end(), and ext4_journalled_write_end().

Please split this into a patch per caller in addition to the one
adding the helper, and write commit logs explaining the rationale
for the helper.  The obious ones I'm trying to guess are that
the new helper avoid a page cache radix tree lookup and a lock
page/folio cycle, but I'd rather hear that from the horses mouth
in the commit log.

> --- a/fs/buffer.c
> +++ b/fs/buffer.c
> @@ -2164,16 +2164,15 @@ int generic_write_end(struct file *file, struct address_space *mapping,
>  	 * But it's important to update i_size while still holding page lock:
>  	 * page writeout could otherwise come in and zero beyond i_size.
>  	 */
> -	if (pos + copied > inode->i_size) {
> +	if (pos + copied > old_size) {

This is and unrelated and undocument (but useful) change.  Please split
it out as well.

> + * This function must be called while we still hold i_rwsem - this not only
> + * makes sure i_size is stable but also that userspace cannot observe the new
> + * i_size value before we are prepared to handle mmap writes there.

Please add a lockdep_assert_held_write to enforce that.

> +void folio_may_straddle_isize(struct inode *inode, struct folio *folio,
> +			      loff_t old_size, loff_t start)
> +{
> +	unsigned int blocksize = i_blocksize(inode);
> +
> +	if (round_up(old_size, blocksize) >= round_down(start, blocksize))
> +		return;
> +
> +	/*
> +	 * See clear_page_dirty_for_io() for details why folio_set_dirty()
> +	 * is needed.
> +	 */
> +	if (folio_mkclean(folio))
> +		folio_set_dirty(folio);

Should pagecache_isize_extended be rewritten to use this helper,
i.e. turn this into a factoring out of a helper?

> +EXPORT_SYMBOL(folio_may_straddle_isize);

Please make this an EXPORT_SYMBOL_GPL just like folio_mkclean.
