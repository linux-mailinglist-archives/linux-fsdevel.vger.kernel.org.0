Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E130450900
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Nov 2021 16:56:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232313AbhKOP7B (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 15 Nov 2021 10:59:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232638AbhKOP6C (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 15 Nov 2021 10:58:02 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2090C061766;
        Mon, 15 Nov 2021 07:54:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=db2lXi8gnwn6tU3pHgxax4Mn0NUGLpwDNzDr7J7Ow9M=; b=MhBn6yo+xcKyTfemdE8SGH40dL
        9m8fBrXUWdOnlTKyToFzMbiyRZjlZ/xkMbe5quXlkmhBhpSL44orkPj442lDPA9RzTLQJPtjUJ1z9
        vB9Qmqp2VQY4VJ+KZXpDnUtzxeEK7sEydhZPACnSWaJNf50n0bRqe2dQ3FJukRojtsXC8jlWSRFA3
        UBk3C2kaIfPcZcSu1W171bBrsDJkdL/WzbHlWaL327nrKyJRPVrDMKTBLllQX/R9HMii4CbsJ4NO8
        pSwLJD7yPqDIA1hwK/EbTQjrDbshJcFcv8zQmmg0Zm0TlG45k1HT2Bt3KGP8zzVyxQcQplhMtL8LR
        n+rUQaYQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mmeJj-005oh4-Hc; Mon, 15 Nov 2021 15:54:47 +0000
Date:   Mon, 15 Nov 2021 15:54:47 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     "Darrick J . Wong " <djwong@kernel.org>, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH v2 01/28] csky,sparc: Declare flush_dcache_folio()
Message-ID: <YZKCx1cwBXOZcTA4@casper.infradead.org>
References: <20211108040551.1942823-1-willy@infradead.org>
 <20211108040551.1942823-2-willy@infradead.org>
 <YYozKaEXemjKwEar@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YYozKaEXemjKwEar@infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Nov 09, 2021 at 12:36:57AM -0800, Christoph Hellwig wrote:
> On Mon, Nov 08, 2021 at 04:05:24AM +0000, Matthew Wilcox (Oracle) wrote:
> > These architectures do not include asm-generic/cacheflush.h so need
> > to declare it themselves.
> 
> In mainline mm/util.c implements flush_dcache_folio unless
> ARCH_IMPLEMENTS_FLUSH_DCACHE_FOLIO is set.  So I think you need to
> define that for csky and sparc.

There are three ways to implement flush_dcache_folio().  The first is
as a noop (this is what xtensa does, which is the only architecture
to define ARCH_IMPLEMENTS_FLUSH_DCACHE_FOLIO; it's also done
automatically by asm-generic if the architecture doesn't define
ARCH_IMPLEMENTS_FLUSH_DCACHE_PAGE).  The second is as a loop which calls
flush_dcache_page() for each page in the folio.  That's the default
implementation which you found in mm/util.c.  The third way, which I
hope architecture maintainers actually implement, is to just set the
needs-flush bit on the head page.  But that requires knowledge of each
architecture; they need to check the needs-flush bit on the head page
instead of the precise page.  So I've done the safe, slow thing for
all architectures.  The only reason that csky and sparc are "special"
is that they don't include asm-generic/cacheflush.h and the buildbots
didn't catch that before the merge window.

I'm doing the exact same thing for csky and sparc that I did for
arc/arm/m68k/mips/nds32/nios2/parisc/sh.  Nothing more, nothing less.
