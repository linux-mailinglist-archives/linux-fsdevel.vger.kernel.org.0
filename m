Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17F1B3E14E3
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Aug 2021 14:38:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241406AbhHEMiY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 5 Aug 2021 08:38:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240412AbhHEMiX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 5 Aug 2021 08:38:23 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BAD2C061765;
        Thu,  5 Aug 2021 05:38:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=e5vYlUPIOBxPGz/O2JkivhT5pBDV17FiEahr25m94xo=; b=VDNG8Tb6wClCKpztYtmaSD7NEq
        SGQD7UcMobrslkmhg185QFnKUTpwyGPNwuGRrN9NXSDaOIycvUVH4S1GdYyGXDUQPFct5VRUnkOMY
        WDClNDfDjIUSzKGZ46rT1uMOx2aGIjFHxepx+psS9IGpDuWXrCrAmKbLBvH/SeheEF6i2FSP5DXbd
        XKSPmmIEZS4rukLqA6nkiMj28GoQ289Yemf7px5Qlp7JY5gVzI2U7rtl2dpLf/Jk15fkeZi8m52EX
        RWshljiw5A2IVuCYg8uKdn4EvvoVAwDTWUlu3aIW/rroiwN2prJL3LZiqk6HywaVRmpu2BcMV3RoB
        A7cNk2dA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mBccq-0070Ga-9X; Thu, 05 Aug 2021 12:37:36 +0000
Date:   Thu, 5 Aug 2021 13:37:28 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     David Howells <dhowells@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org, jlayton@kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        dchinner@redhat.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: Could it be made possible to offer "supplementary" data to a DIO
 write ?
Message-ID: <YQvbiCubotHz6cN7@casper.infradead.org>
References: <1017390.1628158757@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1017390.1628158757@warthog.procyon.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Aug 05, 2021 at 11:19:17AM +0100, David Howells wrote:
> I'm working on network filesystem write helpers to go with the read helpers,
> and I see situations where I want to write a few bytes to the cache, but have
> more available that could be written also if it would allow the
> filesystem/blockdev to optimise its layout.
> 
> Say, for example, I need to write a 3-byte change from a page, where that page
> is part of a 256K sequence in the pagecache.  Currently, I have to round the
> 3-bytes out to DIO size/alignment, but I could say to the API, for example,
> "here's a 256K iterator - I need bytes 225-227 written, but you can write more
> if you want to"?

I think you're optimising the wrong thing.  No actual storage lets you
write three bytes.  You're just pushing the read/modify/write cycle to
the remote end.  So you shouldn't even be tracking that three bytes have
been dirtied; you should be working in multiples of i_blocksize().

I don't know of any storage which lets you ask "can I optimise this
further for you by using a larger size".  Maybe we have some (software)
compressed storage which could do a better job if given a whole 256kB
block to recompress.

So it feels like you're both tracking dirty data at too fine a
granularity, and getting ahead of actual hardware capabilities by trying
to introduce a too-flexible API.
