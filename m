Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB7FD60BC4F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Oct 2022 23:36:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231658AbiJXVgz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Oct 2022 17:36:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230260AbiJXVgh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Oct 2022 17:36:37 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D4572DF0B0;
        Mon, 24 Oct 2022 12:43:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=59TRiYUXIr5hwsRyZRrFskT3Jp1v+y3YCFk34nmAHUA=; b=RWaoMVk6BPHICeFJGa64P+TtYS
        lq+sEC3X3P6L3UTF8roXaBRlKW/dn6ZZSPv8sql0Bq94mmfKcGyd20heEGzrmKOPxJk3I3q5ocDIn
        rZQPq90/4mybKupKG3u4huHqxJCrrWGNEOuPBYM2rIb6H9WuW6yrLD6np+IyZE9bNS7zRunkvbrVS
        kGzoHEUY7j5v5JqpULdFDMYN3lKANNwQv8Kwkz7gBZ7ecSVjXla5q64p4LZsQu4fbmarbbcif9lXY
        o1WMbUkytqszHQgfmeS7hcb6y9ciIzemtb9F2l0G/ZP1Xp4kGUxgavPMMqfxbqbGFy/C6jzVp77bS
        Tdoa8djA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1on3LB-00FglR-TA; Mon, 24 Oct 2022 19:42:30 +0000
Date:   Mon, 24 Oct 2022 20:42:29 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-afs@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        ceph-devel@vger.kernel.org, linux-cifs@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        cluster-devel@redhat.com, linux-nilfs@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH v3 02/23] filemap: Added filemap_get_folios_tag()
Message-ID: <Y1bqpYNvnxmZL+KW@casper.infradead.org>
References: <20221017202451.4951-1-vishal.moola@gmail.com>
 <20221017202451.4951-3-vishal.moola@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221017202451.4951-3-vishal.moola@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Oct 17, 2022 at 01:24:30PM -0700, Vishal Moola (Oracle) wrote:
> This is the equivalent of find_get_pages_range_tag(), except for folios
> instead of pages.
> 
> One noteable difference is filemap_get_folios_tag() does not take in a
> maximum pages argument. It instead tries to fill a folio batch and stops
> either once full (15 folios) or reaching the end of the search range.
> 
> The new function supports large folios, the initial function did not
> since all callers don't use large folios.

Reviewed-by: Matthew Wilcow (Oracle) <willy@infradead.org>

> +/**
> + * filemap_get_folios_tag - Get a batch of folios matching @tag.
> + * @mapping:    The address_space to search
> + * @start:      The starting page index
> + * @end:        The final page index (inclusive)
> + * @tag:        The tag index
> + * @fbatch:     The batch to fill
> + *
> + * Same as filemap_get_folios, but only returning folios tagged with @tag

If you add () after filemap_get_folios, it turns into a nice link in
the html documentation.

> + *
> + * Return: The number of folios found

Missing full stop at the end of this line.

> + * Also update @start to index the next folio for traversal

Ditto.

> + */
> +unsigned filemap_get_folios_tag(struct address_space *mapping, pgoff_t *start,
> +			pgoff_t end, xa_mark_t tag, struct folio_batch *fbatch)
> +{
> +	XA_STATE(xas, &mapping->i_pages, *start);
> +	struct folio *folio;
> +
> +	rcu_read_lock();
> +	while ((folio = find_get_entry(&xas, end, tag)) != NULL) {
> +		/* Shadow entries should never be tagged, but this iteration
> +		 * is lockless so there is a window for page reclaim to evict
> +		 * a page we saw tagged. Skip over it.
> +		 */

For multiline comments, the "/*" should be on a line by itself.

