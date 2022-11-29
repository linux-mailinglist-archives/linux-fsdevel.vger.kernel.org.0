Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D06FD63C7E5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Nov 2022 20:14:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235960AbiK2TOS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 29 Nov 2022 14:14:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236088AbiK2TOP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 29 Nov 2022 14:14:15 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5E7068C74;
        Tue, 29 Nov 2022 11:14:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ZT8K1y0fomD3ovOrP25q9qXv8/nKa1NepgBkRGQnx/c=; b=P5TK2Cg/ft8uEaGWEYuJOx2nTq
        ++BNFtjzHpjkmt+xbZUJCENMP4R5NzonRN+VWLuix+EnM8rejebY5irBlL/lS7/8qJ4JwyL7mm6Gs
        Z95A632AvwDYz+7Tn2OT3VQF/DrUt32Mq0M6G00VDaVqx1aEoepS1pnx7ZWlQCKxp1ULw+zClGfna
        pZ9ewuMH+VcS13cN4AxOLfReKqlmfrysPRifXYSfYsE9d3fKQ9pgLpTO+1D8BEQDMLByyRV+p+4am
        zZbjZlYckPTU2LVb9gfIG0G8RjJfMNxmyXhZk1lhP13nNA8/S4+xUdQxOs/k4FANWCFTxbCvah0RJ
        mlwkiT4Q==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1p063Z-00E7rA-Hi; Tue, 29 Nov 2022 19:14:13 +0000
Date:   Tue, 29 Nov 2022 19:14:13 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Chao Yu <chao@kernel.org>
Cc:     "Vishal Moola (Oracle)" <vishal.moola@gmail.com>,
        linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-mm@kvack.org,
        fengnan chang <fengnanchang@gmail.com>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [f2fs-dev] [PATCH v3 14/23] f2fs: Convert
 f2fs_write_cache_pages() to use filemap_get_folios_tag()
Message-ID: <Y4ZaBd1r45waieQs@casper.infradead.org>
References: <20221017202451.4951-1-vishal.moola@gmail.com>
 <20221017202451.4951-15-vishal.moola@gmail.com>
 <9c01bb74-97b3-d1c0-6a5f-dc8b11113e1a@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9c01bb74-97b3-d1c0-6a5f-dc8b11113e1a@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Nov 14, 2022 at 03:02:34PM +0800, Chao Yu wrote:
> On 2022/10/18 4:24, Vishal Moola (Oracle) wrote:
> > Converted the function to use a folio_batch instead of pagevec. This is in
> > preparation for the removal of find_get_pages_range_tag().
> > 
> > Also modified f2fs_all_cluster_page_ready to take in a folio_batch instead
> > of pagevec. This does NOT support large folios. The function currently
> 
> Vishal,
> 
> It looks this patch tries to revert Fengnan's change:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=01fc4b9a6ed8eacb64e5609bab7ac963e1c7e486
> 
> How about doing some tests to evaluate its performance effect?
> 
> +Cc Fengnan Chang

Thanks for reviewing this.  I think the real solution to this is
that f2fs should be using large folios.  That way, the page cache
will keep track of dirtiness on a per-folio basis, and if your folios
are at least as large as your cluster size, you won't need to do the
f2fs_prepare_compress_overwrite() dance.  And you'll get at least fifteen
dirty folios per call instead of fifteen dirty pages, so your costs will
be much lower.

Is anyone interested in doing the work to convert f2fs to support
large folios?  I can help, or you can look at the work done for XFS,
AFS and a few other filesystems.
