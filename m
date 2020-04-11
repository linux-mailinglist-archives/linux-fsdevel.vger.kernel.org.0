Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 33BA51A53E4
	for <lists+linux-fsdevel@lfdr.de>; Sun, 12 Apr 2020 00:06:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726708AbgDKWGD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 11 Apr 2020 18:06:03 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:48966 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726167AbgDKWGD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 11 Apr 2020 18:06:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ke5AHRgjKB6B5LshHHJpXc9QzzD0ma5nt/GmtfMBEXo=; b=MPplP1qZyTt37DjzlIf+sILbB+
        S75QjpllmJhSrLwkFp+9NkhFTWFmOy1rcLjkbyMM/NWVVyTwsZkN0/hec3BqUus0g35T8/rLg3BAh
        1pKOsq6BJ5JTXjT9Dij8hONSxrdtilOXHXNvPTI+csRTPBaWPW9msNuI0S+UnvHOMPhfbdZmqazMn
        w3SsF+cLogyaOAmOpgQpKrqkDx9a1br7C423/KsKprhg0HsX/kScHqNS3WholxLBxHuEklG/Rb6/e
        tt74IXJ7lSYvqgb6c//XMbge6uYYwNj6KDPZAB5CowirRb3rtNhDaQFi276rw1AQ6Tj6se3k37jmF
        V/nE2MpQ==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jNOGJ-0007NM-FQ; Sat, 11 Apr 2020 22:06:03 +0000
Date:   Sat, 11 Apr 2020 15:06:03 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL] Rename page_offset() to page_pos()
Message-ID: <20200411220603.GI21484@bombadil.infradead.org>
References: <20200411203220.GG21484@bombadil.infradead.org>
 <CAHk-=wgCAGVwAVTuaoJu4bF99JEG66iN7_vzih=Z33GMmOTC_Q@mail.gmail.com>
 <20200411214818.GH21484@bombadil.infradead.org>
 <CAHk-=wj71d1ExE-_W0hy87r3d=2URMwx0f6oh+bvdfve6G71ew@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wj71d1ExE-_W0hy87r3d=2URMwx0f6oh+bvdfve6G71ew@mail.gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Apr 11, 2020 at 03:02:40PM -0700, Linus Torvalds wrote:
> On Sat, Apr 11, 2020 at 2:48 PM Matthew Wilcox <willy@infradead.org> wrote:
> >
> > I wasn't entirely forthcoming ... I actually want to introduce a new
> >
> > #define page_offset(page, x) ((unsigned long)(x) & (page_size(page) - 1))
> 
> No, no, no.
> 
> THAT would be confusing. Re-using a name (even if you renamed it) for
> something new and completely different is just bad taste. It would
> also be a horrible problem - again - for any stable backport etc.
> 
> Just call that "offset_in_page()" and be done with it.

But we _have_ an offset_in_page() and it doesn't take a struct page
argument.  Reusing the name wouldn't be too bad because it would take
two arguments, so nothing would inadvertently apply cleanly.

Anyway, if you give me a decision on pgindex_t vs pgidx_t, I'll work
that up before -rc1 closes.
