Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DB8B2FB3D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Apr 2019 16:18:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726415AbfD3OSM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 30 Apr 2019 10:18:12 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:60538 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726053AbfD3OSM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 30 Apr 2019 10:18:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=CqsMVVyOES0C4odcCbtz73DyIJWx76MxEFym4dDPzfc=; b=CNMgBQRU/iVW37e8/PFU8IM1b
        LgC+BEq9Qi1DHL6NkXZcPW1wazFINWWQr+V/Dt/e9lc8nJxlYUoOzjd3YeQm/dApuvaa5Hjgl0jDV
        +Z/32RruzQKUeppiPYiF7wo5pFGGOif+hJTM17xq/Z0DUWlTdiJkkX89Hc1LY6Kzxk7G29BCQOn1q
        hXqgXhNF1XCmpID0+5MmhNVlupkFNa4anBX2yCTcyDvM8awLC42rwzTuxZwehxqAVmsmQVk8gHeD9
        +18TEXoY3qMZ/Av+TKHWaglGwCeTtxNX/nNfgz+jr1d8ePptWgpwBDPTeRehSUf8anLZMSZDOFstB
        K/p49i2DQ==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hLTaF-0004Jn-3h; Tue, 30 Apr 2019 14:18:11 +0000
Date:   Tue, 30 Apr 2019 07:18:10 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: [PATCH] io_uring: avoid page allocation warnings
Message-ID: <20190430141810.GF13796@bombadil.infradead.org>
References: <20190430132405.8268-1-mark.rutland@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190430132405.8268-1-mark.rutland@arm.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Apr 30, 2019 at 02:24:05PM +0100, Mark Rutland wrote:
> In io_sqe_buffer_register() we allocate a number of arrays based on the
> iov_len from the user-provided iov. While we limit iov_len to SZ_1G,
> we can still attempt to allocate arrays exceeding MAX_ORDER.
> 
> On a 64-bit system with 4KiB pages, for an iov where iov_base = 0x10 and
> iov_len = SZ_1G, we'll calculate that nr_pages = 262145. When we try to
> allocate a corresponding array of (16-byte) bio_vecs, requiring 4194320
> bytes, which is greater than 4MiB. This results in SLUB warning that
> we're trying to allocate greater than MAX_ORDER, and failing the
> allocation.
> 
> Avoid this by passing __GFP_NOWARN when allocating arrays for the
> user-provided iov_len. We'll gracefully handle the failed allocation,
> returning -ENOMEM to userspace.
> 
> We should probably consider lowering the limit below SZ_1G, or reworking
> the array allocations.

I'd suggest that kvmalloc is probably our friend here ... we don't really
want to return -ENOMEM to userspace for this case, I don't think.
