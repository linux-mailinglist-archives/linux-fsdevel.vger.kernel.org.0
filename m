Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 990BD3BAF66
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Jul 2021 00:47:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229649AbhGDWu2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 4 Jul 2021 18:50:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbhGDWu2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 4 Jul 2021 18:50:28 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F999C061574;
        Sun,  4 Jul 2021 15:47:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=PE0+ltJ8CPW5GuVbl04kKwO5nyGlc0OLWCx1mWBJ6vY=; b=Rbliddu6MU+QRkogANLmJb+l+r
        R6Kjmh0imSvaunksE287DLPPfugYhRwYrzDV8gvy2mrbiMsxFU4O3DEsKZhVG1bohXn95sdnSNR3X
        YLvAKI6yhg0u9U3BWC/yizUJ4cAttqjHemcDcTZHfI3fQq3uhkn/lynnamGTt55Ry5uGqPBAC9Fod
        Jimutzm9ks7zYQa+Yf3RG+KjIKjeUSEI7UTGHKKPA9OId0uAn+DiffJev9hI4uhIiorSy+JySuHHG
        PxJSri0o80kSnT0jRex3jNJtxpMdcrwGw0jj8GuS57/s+Zq9LB2ve6Lo5rJoTOpdtlqGKFmGKyzcj
        hU3LB97A==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m0AtM-009eU1-4C; Sun, 04 Jul 2021 22:47:19 +0000
Date:   Sun, 4 Jul 2021 23:47:12 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Guenter Roeck <linux@roeck-us.net>, Christoph Hellwig <hch@lst.de>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Sterba <dsterba@suse.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Anton Altaparmakov <anton@tuxera.com>,
        David Howells <dhowells@redhat.com>,
        Pavel Begunkov <asml.silence@gmail.com>
Subject: Re: [PATCH] iov_iter: separate direction from flavour
Message-ID: <YOI6cES6C0vTS/DU@casper.infradead.org>
References: <20210704172948.GA1730187@roeck-us.net>
 <CAHk-=wheBFiejruhRqByt0ey1J8eU=ZUo9XBbm-ct8_xE_+B9A@mail.gmail.com>
 <676ae33e-4e46-870f-5e22-462fc97959ed@roeck-us.net>
 <CAHk-=wj_AROgVZQ1=8mmYCXyu9JujGbNbxp+emGr5i3FagDayw@mail.gmail.com>
 <19689998-9dfe-76a8-30d4-162648e04480@roeck-us.net>
 <CAHk-=wj0Q8R_3AxZO-34Gp2sEQAGUKhw7t6g4QtsnSxJTxb7WA@mail.gmail.com>
 <03a15dbd-bdb9-1c72-a5cd-2e6a6d49af2b@roeck-us.net>
 <CAHk-=whD38FwDPc=gemuS6wNMDxO-PyVbtvcta3qXyO1ROc4EQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whD38FwDPc=gemuS6wNMDxO-PyVbtvcta3qXyO1ROc4EQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Jul 04, 2021 at 03:44:17PM -0700, Linus Torvalds wrote:
> On Sun, Jul 4, 2021 at 2:47 PM Guenter Roeck <linux@roeck-us.net> wrote:
> >
> > How about the following ?
> >
> >         WARN_ON_ONCE(IS_ENABLED(CONFIG_MMU) && uaccess_kernel());
> 
> Nope, that doesn't work either, because there are no-MMU setups that
> don't make the same mistake no-mmu arm and m68k do.
> 
> Example: xtensa. But afaik also generic-asm/uaccess.h unless the
> architecture overrides something.
> 
> So this literally seems like just an arm/m68k bug.

We could slip:

#ifndef uaccess_user
#define uaccess_user() !uaccess_kernel()
#endif

into asm-generic, switch the test over and then make it arm/m68k's
problem to define uaccess_user() to true?
