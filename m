Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A6333F6FA4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Aug 2021 08:35:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239001AbhHYGgY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 25 Aug 2021 02:36:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239293AbhHYGgW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 25 Aug 2021 02:36:22 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2228C061757;
        Tue, 24 Aug 2021 23:35:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=2XLmr3mig5i7hFsrhfybeAZVxu1dPFwBTiqJmo2ZjDs=; b=Y/vL5A1XzYQGjecTWV5ZlubPWZ
        GTZIZXOm9XJO0Be7zs+Aj9ueGAGEfnmZxexw/PUD7kF5QYnOLhKGqh6ujtUIll2y3crONRFnfjkGn
        XEu2lb0XgzN21b5//QSf3Sv9zeguPFet/OyzEGBOr15LkzC0jf9WMzGNFJcV1sbUOfakeh/IJIu0t
        4vy3wCYV2ew5sq+yeoArOQi4ZTTkE3L1TxQPPwlnCJztnkkQ/YGQhC9FaGF6hdJlYrGnvNWebM0Ii
        RTsykyka9MLAs4Hll6kzSOxoIXa7sdJc6rVZLftLKAjjpWr85iqzHgOf5apapcyTgtQ7/qrAkuPm+
        4hrxNGVw==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mImSq-00ByML-7A; Wed, 25 Aug 2021 06:32:54 +0000
Date:   Wed, 25 Aug 2021 07:32:44 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        David Howells <dhowells@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Linux-MM <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [GIT PULL] Memory folios for v5.15
Message-ID: <YSXkDFNkgAhQGB0E@infradead.org>
References: <CAHk-=wjD8i2zJVQ9SfF2t=_0Fkgy-i5Z=mQjCw36AHvbBTGXyg@mail.gmail.com>
 <YSPwmNNuuQhXNToQ@casper.infradead.org>
 <YSQSkSOWtJCE4g8p@cmpxchg.org>
 <1957060.1629820467@warthog.procyon.org.uk>
 <YSUy2WwO9cuokkW0@casper.infradead.org>
 <CAHk-=wip=366HxkJvTfABuPUxwjGsFK4YYMgXNY9VSkJNp=-XA@mail.gmail.com>
 <YSVCAJDYShQke6Sy@casper.infradead.org>
 <CAHk-=wisF580D_g+wFt0B_uijSX+mCgz6tRRT5KADnO7Y97t-g@mail.gmail.com>
 <YSVHI9iaamxTGmI7@casper.infradead.org>
 <YSVMMMrzqxyFjHlw@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YSVMMMrzqxyFjHlw@mit.edu>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Aug 24, 2021 at 03:44:48PM -0400, Theodore Ts'o wrote:
> The problem is whether we use struct head_page, or folio, or mempages,
> we're going to be subsystem users' faces.  And people who are using it
> every day will eventually get used to anything, whether it's "folio"
> or "xmoqax", we sould give a thought to newcomers to Linux file system
> code.  If they see things like "read_folio()", they are going to be
> far more confused than "read_pages()" or "read_mempages()".

Are they?  It's not like page isn't some randomly made up term
as well, just one that had a lot more time to spread.

> So if someone sees "kmem_cache_alloc()", they can probably make a
> guess what it means, and it's memorable once they learn it.
> Similarly, something like "head_page", or "mempages" is going to a bit
> more obvious to a kernel newbie.  So if we can make a tiny gesture
> towards comprehensibility, it would be good to do so while it's still
> easier to change the name.

All this sounds really weird to me.  I doubt there is any name that
nicely explains "structure used to manage arbitrary power of two
units of memory in the kernel" very well.  So I agree with willy here,
let's pick something short and not clumsy.  I initially found the folio
name a little strange, but working with it I got used to it quickly.
And all the other uggestions I've seen s far are significantly worse,
especially all the odd compounds with page in it.
