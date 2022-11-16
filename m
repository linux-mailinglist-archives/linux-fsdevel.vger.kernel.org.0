Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12BC262B4B0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Nov 2022 09:12:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238363AbiKPIMT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Nov 2022 03:12:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238794AbiKPIL6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Nov 2022 03:11:58 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFF3A2CDCC;
        Wed, 16 Nov 2022 00:09:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=fC4LrdUtHicDNTrM6ZQCgkHgfF5J9bOlSVqabw6qkVo=; b=rgHGM2WtyE9J9xNTJOoLkyh0HU
        KA0SbPvfBG3eMMfXlW7Pn5OClY9qOSWpjp3XgCGpGFTzd1pb8NP7LHQqwqlK8wie7laXLNh22RNd6
        nWn9l5R1/1ZefPg8tiyaHKH6KtapubFM/WqW0FkRgUFyktm9TaFzwrExteT7suQ9y6WXYOWYzaqsB
        UHYLXV2irc3lUSgo04fxpZwR5cImwR5O8tfeuhA2yZDzxIGF5VfavMSfAClxNQS+pyuk9B2DGRYcP
        6e07LZ8Yule1wh4d/kvm3udoOWts/etIGcfSfowQFztBMQB1z1LiAVs5UhfDKUN/KJy3oqaMEQ+OQ
        NN3JvG/w==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ovDU2-00HAeo-2Q; Wed, 16 Nov 2022 08:09:22 +0000
Date:   Wed, 16 Nov 2022 08:09:22 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Cc:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-ext4@vger.kernel.org,
        akpm@linux-foundation.org, naoya.horiguchi@nec.com, tytso@mit.edu
Subject: Re: [PATCH 1/4] ext4: Convert move_extent_per_page() to use folios
Message-ID: <Y3SaskD7QurUVJFr@casper.infradead.org>
References: <20221116021011.54164-1-vishal.moola@gmail.com>
 <20221116021011.54164-2-vishal.moola@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221116021011.54164-2-vishal.moola@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Nov 15, 2022 at 06:10:08PM -0800, Vishal Moola (Oracle) wrote:
>  {
>  	struct inode *orig_inode = file_inode(o_filp);
>  	struct page *pagep[2] = {NULL, NULL};
> +	struct folio *folio[2] = {NULL, NULL};

I have a feeling that mext_page_double_lock() should also be converted
to use folios.  But this makes me nervous:

        int blocks_per_page = PAGE_SIZE >> orig_inode->i_blkbits;

and I'm not sure what will happen if one or both of the orig_page
and donor_page is large -- possibly different sizes of large.

Obviously ext4 doesn't allow large folios today, but it would be good to
get some reasoning about why this isn't laying a trap for later (or at
least assertions that neither folio is large so that there's an obvious
scream instead of silent data corruption).
