Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6AA9A11C2CA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Dec 2019 02:56:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727563AbfLLB4P (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 11 Dec 2019 20:56:15 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:53024 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727504AbfLLB4O (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 11 Dec 2019 20:56:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=I5UsU67I10U8p0BYxrNMZR+/KpiEMW7RPdqeQzSS9a4=; b=FC0stfujHU0QXKM++ACD9PdZp
        ClLIfR8IEBlhLBIgAYdPg0fwZVxLfklermQri0rET3qpnMVcdBol4v5GGmwEiSnQvMJ4Tqdaof8du
        34i3vUSJdgIuHgjddtPpazocRhy/y5vpvQVuAoMrTlyICZkTdaGtBIFdo5/m9d7oL5NB2aM4vraZw
        Fvon0HMmzEt5NqKthMew0jnjX2E5wDwgsI4BIbZqE9hXKf60SU6wiQ4Fw/icU+iVq9vgvEzBowacT
        MTCuL0tptuK1k9L7vW0CjYhLJXieQ1+5O84+gnu4T6EC/VKELcAYvJ68iMQgf0EbcVPjofnbX4WEb
        X9IKD5vzw==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ifDi8-0000hU-Ja; Thu, 12 Dec 2019 01:56:12 +0000
Date:   Wed, 11 Dec 2019 17:56:12 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Jens Axboe <axboe@kernel.dk>, Linux-MM <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>,
        Chris Mason <clm@fb.com>, Dave Chinner <david@fromorbit.com>,
        Johannes Weiner <hannes@cmpxchg.org>
Subject: Re: [PATCHSET v3 0/5] Support for RWF_UNCACHED
Message-ID: <20191212015612.GP32169@bombadil.infradead.org>
References: <e43a2700-8625-e136-dc9d-d0d2da5d96ac@kernel.dk>
 <CAHk-=wje8i3DVcO=fMC4tzKTS5+eHv0anrVZa_JENQt08T=qCQ@mail.gmail.com>
 <0d4e3954-c467-30a7-5a8e-7c4180275533@kernel.dk>
 <CAHk-=whk4bcVPvtAv5OmHiW5z6AXgCLFhO4YrXD7o0XC+K-aHw@mail.gmail.com>
 <fef996ca-a4ed-9633-1f79-91292a984a20@kernel.dk>
 <CAHk-=wg=hHUFg3i0vDmKEg8HFbEKquAsoC8CJoZpP-8_A1jZDA@mail.gmail.com>
 <1c93194a-ed91-c3aa-deb5-a3394805defb@kernel.dk>
 <CAHk-=wj0pXsngjWKw5p3oTvwkNnT2DyoZWqPB+-wBY+BGTQ96w@mail.gmail.com>
 <d8a8ea42-7f76-926c-ae9a-d49b11578153@kernel.dk>
 <CAHk-=whtf0-f5wCcSAj=oTK2TEaesF43UdHnPyvgE9X1EuwvBw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whtf0-f5wCcSAj=oTK2TEaesF43UdHnPyvgE9X1EuwvBw@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Dec 11, 2019 at 05:41:16PM -0800, Linus Torvalds wrote:
> I too can see xas_create using 30% CPU time, but that's when I do a
> perf record on just kswapd - and when I actually look at it on a
> system level, it looks nowhere near that bad.
> 
> So I think people should look at this. Part of it might be for Willy:
> does that xas_create() need to be that expensive? I hate how "perf"
> callchains work, but it does look like it is probably
> page_cache_delete -> xas_store -> xas_create that is the bulk of the
> cost there.
> 
> Replacing the real page with the shadow entry shouldn't be that big of
> a deal, I would really hope.
> 
> Willy, that used to be a __radix_tree_lookup -> __radix_tree_replace
> thing, is there perhaps some simple optmization that could be done on
> the XArray case here?

It _should_ be the same order of complexity.  Since there's already
a page in the page cache, xas_create() just walks its way down to the
right node calling xas_descend() and then xas_store() does the equivalent
of __radix_tree_replace().  I don't see a bug that would make it more
expensive than the old code ... a 10GB file is going to have four levels
of radix tree node, so it shouldn't even spend that long looking for
the right node.
