Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A19C370E57
	for <lists+linux-fsdevel@lfdr.de>; Sun,  2 May 2021 20:00:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232411AbhEBSBF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 2 May 2021 14:01:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231788AbhEBSBE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 2 May 2021 14:01:04 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E42DC06174A;
        Sun,  2 May 2021 11:00:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ox1uG4hXSi3kmGSi8Ujj0SwwhYl/DRs1whuuY2NKW14=; b=g35IcNWK1Oxa2pWmr5AxOKI/Rk
        x8KN9LobeqzwQ0UigvVOIqQZarRaoU0r47ge155inBaMH/tMLYO8mJANvOCx9niPTT3OT7g7XmlLI
        3+ZdRnKtF8WpIdSkRECOyWp8oFqBPrLuiN9bvY1zuqgi4pYdnCA0oDCghaAFE+osKV4VHF19Vc4JE
        VTHa5Fe8z8JWgqhHOGKHuF2dGmL+dzUHChf8WyTEGcgFludBznxL74jKs73YBI9fMeERnh7IwIF1U
        MkafHODJ2BTt+B45VENmH44FrWOpOpTsfV8nvGEF4cQP1qPo1wKidZh/1MhHCcDbyInnLwwTAZXbr
        iZyQ0PnA==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1ldGNe-00E6DJ-TB; Sun, 02 May 2021 17:59:52 +0000
Date:   Sun, 2 May 2021 18:59:46 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [git pull] work.misc
Message-ID: <20210502175946.GY1847222@casper.infradead.org>
References: <YI4AwgZaFSGsTDR9@zeniv-ca.linux.org.uk>
 <CAHk-=whWm_a5hHr7Xnx8NNQPq5xjs6cS+APE5k_K1K6F8Wq7eQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whWm_a5hHr7Xnx8NNQPq5xjs6cS+APE5k_K1K6F8Wq7eQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, May 02, 2021 at 09:26:26AM -0700, Linus Torvalds wrote:
> On Sat, May 1, 2021 at 6:30 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
> >
> > Mikulas Patocka (1):
> >       buffer: a small optimization in grow_buffers
> 
> Side note: if that optimization actually matters (which I doubt), we
> could just make getblk and friends take s_blocksize_bits instead of
> the block size. And avoid the whole "find first bit" thing.
> 
> As it is, we end up doing odd and broken things if anybody were to
> ever use a non-power-of-2 blocksize (we check that it's a multiple of
> the hw blocksize, we check that it's between 512 and PAGE_SIZE, but we
> don't seem to check that it's a power-of-2).

I think we have checks that the hw blocksize is a power-of-two (maybe
just in SCSI?  see sd_read_capacity())

I don't see much demand in the storage industry for non-power-of-two
sizes; I was once asked about a 12kB sector size at Intel, but when I
said "no", they didn't seem surprised.  I see interest in going smaller
(cacheline sized) for pmem and I see interest in going larger (16kB
sector sizes) for NAND.
