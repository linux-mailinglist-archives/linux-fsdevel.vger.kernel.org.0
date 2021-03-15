Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3198633C6FA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Mar 2021 20:41:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233448AbhCOTlP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 15 Mar 2021 15:41:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233717AbhCOTlJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 15 Mar 2021 15:41:09 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15D17C06174A;
        Mon, 15 Mar 2021 12:41:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=12+6Ush9hX1Ewkklvi8wTA42vfuCkxo+PweocyhvKNY=; b=LSYjZJ1PS3v9Llm7VndY/q4cXy
        j0KkqBeKB7gNp9++92jjLflydlcCnykyajon27zQHRsSzRs/d0hmw4XgqvFPNS5OUI9H1zAgglEBv
        i7rwkWjTQ3h7xBr1H7pjCoaj9Q+b5DHmWOleFGfV5DEx4ktk0tSHlZrhE5LifZqCeSE4XhuRaCP81
        5jvejFphWh+xdcxIKMxBeBRidvye+FYk3PnOcESZgFGQLj5pkCT6rHlyUZRu6U5ugF+eEU2dFLE8u
        KMKI1lNZj/XgwsurcWNVijyf1S7lKzzBj/YC0a+OpqntC1BxLi0u25KCyPrpgnXrggwRXAkLzlNcp
        WSIfHVCw==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lLt4Y-000feN-QM; Mon, 15 Mar 2021 19:40:19 +0000
Date:   Mon, 15 Mar 2021 19:40:14 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Michal Hocko <mhocko@suse.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v4 00/25] Page folios
Message-ID: <20210315194014.GZ2577561@casper.infradead.org>
References: <20210305041901.2396498-1-willy@infradead.org>
 <20210313123658.ad2dcf79a113a8619c19c33b@linux-foundation.org>
 <alpine.LSU.2.11.2103131842590.14125@eggly.anvils>
 <20210315115501.7rmzaan2hxsqowgq@box>
 <YE9VLGl50hLIJHci@dhcp22.suse.cz>
 <20210315190904.GB150808@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210315190904.GB150808@infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Mar 15, 2021 at 07:09:04PM +0000, Christoph Hellwig wrote:
> On Mon, Mar 15, 2021 at 01:38:04PM +0100, Michal Hocko wrote:
> > I tend to agree here as well. The level compoud_head has spread out
> > silently is just too large. There are people coming up with all sorts of
> > optimizations to workaround that, and they are quite right that this is
> > somehing worth doing, but last attempts I have seen were very focused on
> > specific page flags handling which is imho worse wrt maintainability
> > than a higher level and type safe abstraction. I find it quite nice that
> > this doesn't really have to be a flag day conversion but it can be done
> > incrementally.
> > 
> > I didn't get review the series yet and I cannot really promise anything
> > but from what I understand the conversion should be pretty
> > straightforward, albeit noisy.
> > 
> > One thing that was really strange to me when seeing the concept for the
> > first time was the choice of naming (no I do not want to start any
> > bikeshedding) because it hasn't really resonated with the udnerlying
> > concept. Maybe just me as a non native speaker... page_head would have
> > been so much more straightforward but not something I really care about.
> 
> That pretty much summarizes my opinion as well.  I'll need to find some
> time to review the series as well.

If it's easier for you, I'm trying to keep
https://git.infradead.org/users/willy/pagecache.git/shortlog/refs/heads/folio
up to date.  Not all of those 111 patches are suitable for upstreaming,
but it might give you a better idea of where I'm going than if I only
posted the first 70-80 of them.  Stopping at
"mm/memory: Use a folio in copy_pte_range()" nets us almost 10kb of
text reduction for the UEK-derived config, about 3.3kb on an allnoconfig
(which is a little over 0.1% on a 2.4MB kernel).

The reason I didn't go with 'head' is that traditionally 'head' implies
that there are tail pages.  It would be weird to ask 'if (HeadHead(head))'
That's currently spelled 'if (FolioMulti(folio))'.  But it can be changed
if there's a really better alternative.  It'll make me more grumpy if
somebody comes up with a really good alternative in six months.

I would agree that the conversion is both straightforward and noisy.
There are some minor things that crop up, like noticing that we get
the accounting wrong for writeback of compound pages.  That's not
entirely unexpected since no filesystem supports both compound pages
and writeback today.
