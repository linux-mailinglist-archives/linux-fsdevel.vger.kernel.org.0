Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4F843F5EB2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Aug 2021 15:07:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237463AbhHXNH4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Aug 2021 09:07:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237310AbhHXNHz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Aug 2021 09:07:55 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9594FC061757;
        Tue, 24 Aug 2021 06:07:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=jLkQG8Fgfyd9gfCDln3QSQ2fMckOosUk5q/8rAW6dJ8=; b=Z7l6UVofQh63OLuJuVCFFfh55I
        zdGbUX3Lkr+4Wbuha4YwwgUtlqbsdSiNbkJzyBa0Faoj8mNvVYKxfapUcXLaqDGpVl9OYM1H+ayq5
        /WaLuE5HppZEPVzqlddoqTNurOSGbaUgtTyEbKPPCb7NtfDJ64jfilXvXNdlwanCbVYpUyDsfttpk
        6uUX0/sy/z70uyBZx1JIIxZkqT4vX3v4CVOKNuy2qt0r36cvUlgiAkdMR1XZba8+o9h4H2ydL0QK1
        2xE4jKVEeXay7RLhQzvoFiJrc28jtwQjR2/yt5ctvLEI2acv9eKxYLWMKnuORsnNnIpfZbu8/ifuQ
        cWPKR0ww==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mIW6q-00B4Us-Ak; Tue, 24 Aug 2021 13:05:34 +0000
Date:   Tue, 24 Aug 2021 14:04:56 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Linux-MM <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [GIT PULL] Memory folios for v5.15
Message-ID: <YSTueKUG67q6zxKu@casper.infradead.org>
References: <YSPwmNNuuQhXNToQ@casper.infradead.org>
 <YSQSkSOWtJCE4g8p@cmpxchg.org>
 <CAHk-=wjD8i2zJVQ9SfF2t=_0Fkgy-i5Z=mQjCw36AHvbBTGXyg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjD8i2zJVQ9SfF2t=_0Fkgy-i5Z=mQjCw36AHvbBTGXyg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Aug 23, 2021 at 03:06:08PM -0700, Linus Torvalds wrote:
> Yeah, honestly, I would have preferred to see this done the exact
> reverse way: make the rule be that "struct page" is always a head
> page, and anything that isn't a head page would be called something
> else.
> 
> Because, as you say, head pages are the norm. And "folio" may be a
> clever term, but it's not very natural. Certainly not at all as
> intuitive or common as "page" as a name in the industry.

Actually, I think this is an advantage for folios.  Maybe not for the
core MM which has always been _fairly_ careful to deal with compound
pages properly.  But for filesystem people, device drivers, etc, when
people see a struct page, they think it's PAGE_SIZE bytes in size.
And they're usually right, which is what makes things like THP so prone
to "Oops, we missed a spot" bugs.  By contrast, if you see something
which takes a struct folio and then works on PAGE_SIZE bytes, that's a
sign there's something funny going on.  There are a few of those still;
for example kmap() can only map PAGE_SIZE bytes at a time.
