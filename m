Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB27462B2F4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Nov 2022 06:47:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232148AbiKPFrD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Nov 2022 00:47:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232066AbiKPFqx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Nov 2022 00:46:53 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 944F813F7E;
        Tue, 15 Nov 2022 21:46:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=8V0IP0Q1zd7NAy2EUGvsK/hhbASCjuEOFpMfbZU7rKc=; b=IqgkINI0lkyxOYd2ElfETnYIVr
        LIfSZeE3+sNgoco0A8lbTB1pLJARFA5RwoclL09EF/twp1NH7JVjOGNhOK16nHsMwDuXoCRP4CwMp
        rCnGlz6N6zRBznv0xB/mLXQz1nlsmDYPSjYIEsD7sQpoKJPIjqAM/1gagfWY3PWbTFNzJznFqVH8A
        Xc9yhAqn/NtAQtysuLX0HMdeA3JEM14hlX6CKrC4JNHNSYYtyr27CnDOjHYzZncO1DSsk8AXFPgTy
        IK1A6Zdc4nGNLVl2zWwNPhrUqWDNDb0/fn5DSKBcTkn2ubNKDEZ5YiZXtHCRQ7OZgX8wove4RiJxL
        dyI2eOYQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ovBG6-0006ne-PW; Wed, 16 Nov 2022 05:46:50 +0000
Date:   Tue, 15 Nov 2022 21:46:50 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     "Darrick J. Wong" <djwong@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH 6/9] xfs: xfs_bmap_punch_delalloc_range() should take a
 byte range
Message-ID: <Y3R5SpYJWsMlg452@infradead.org>
References: <20221115013043.360610-1-david@fromorbit.com>
 <20221115013043.360610-7-david@fromorbit.com>
 <Y3NRfgxWcenyCe+i@infradead.org>
 <Y3Qhbi0aGDe+QG22@magnolia>
 <20221116005723.GA3600936@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221116005723.GA3600936@dread.disaster.area>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Nov 16, 2022 at 11:57:23AM +1100, Dave Chinner wrote:
> The fact that Christoph NAK'd exporting mapping_seek_hole_data()
> this time around is just Plain Fucking Annoying.

Thank you so much, I love you too.

> He didn't say
> anything in the last thread about it after I explained why I used
> it, so I had assumed it was all OK.

Quote from the last thread:

"So, the whole scan for delalloc logic seems pretty generic, I think
it can an should be lifted to iomap, with
xfs_buffered_write_delalloc_punch provided as a callback."

> I've already been playing patch golf all morning now to rearrange
> all the deck chairs to avoid exporting mapping_seek_hole_data().
> Instead we now have an exported iomap function that wraps
> mapping_seek_hole_data, and the wrapper function I added in patch 4
> is now the callback function that is passed 3 layers deep into the
> iomap code.
> 
> Hence the xfs_buffered_write_delalloc_punch() function needs to
> remain - we can't elide it entire like this patch does - because now
> we need a callback function that we can provide to the iomap code so
> we avoid coupling internal XFS implementation functions to external
> VFS APIs.

Which was roughly was the intention all along.
