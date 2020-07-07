Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53F442164D1
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Jul 2020 05:49:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727072AbgGGDtC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 6 Jul 2020 23:49:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726540AbgGGDtC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 6 Jul 2020 23:49:02 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32118C061755
        for <linux-fsdevel@vger.kernel.org>; Mon,  6 Jul 2020 20:49:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=XdAxoGBQyacwF5GaKjN4+airmAZlsFx/EW7oC/DCLQU=; b=sxeHK3sAD3ls06v9FzY0zXnHYT
        IdIKnllJMmQHd4Jn+I3D6+CPmN9Hu0tA/enToWJ8b9uygLP3pXo3SjlZBKXebpjKZX4uGxPiGCRj1
        q3Ng3R0cXv8BKUO7HZNXElvNMgoqiybo/W28qGDg97GjUgtJVPi3MF8eiZlkF+As87HijKlWOraMe
        fhIyV1PccLm5aJcBqjTWCQQXjxIUmBZqU7UfABsJT0nqGKIMN1oceGIgsaGG72+Y7VONNikovNzTS
        Z5wmNx0SEyVtdB1+IRfyNxRlGZc8FphVPq8Z8DYc+ihVo3TA/9OvfOn7R8a5GQxcu73niJNVLxZXn
        WWg1PjZA==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jsebM-0004RI-FD; Tue, 07 Jul 2020 03:49:00 +0000
Date:   Tue, 7 Jul 2020 04:49:00 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Hugh Dickins <hughd@google.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 0/2] Use multi-index entries in the page cache
Message-ID: <20200707034900.GG25523@casper.infradead.org>
References: <20200629152033.16175-1-willy@infradead.org>
 <alpine.LSU.2.11.2007041206270.1056@eggly.anvils>
 <20200706144320.GB25523@casper.infradead.org>
 <alpine.LSU.2.11.2007061946180.2346@eggly.anvils>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LSU.2.11.2007061946180.2346@eggly.anvils>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jul 06, 2020 at 08:21:54PM -0700, Hugh Dickins wrote:
> > and I have a good clue now:
> > 
> > 1322 offset 631 xas index 631 offset 48
> > 1322 page:000000008c9a9bc3 refcount:4 mapcount:0 mapping:00000000d8615d47 index:0x276
> 
> (You appear to have more patience with all this ghastly hashing of
> kernel addresses in debug messages than I have: it really gets in our way.)
> 
> > 1322 flags: 0x4000000000002026(referenced|uptodate|active|private)
> > 1322 mapping->aops:0xffffffff88a2ebc0 ino 1800b82 dentry name:"f1141"
> > 1322 raw: 4000000000002026 dead000000000100 dead000000000122 ffff98ff2a8b8a20
> > 1322 raw: 0000000000000276 ffff98ff1ac271a0 00000004ffffffff 0000000000000000
> > 1322 page dumped because: index mismatch
> > 1322 xa_load 000000008c9a9bc3
> > 
> > 0x276 is decimal 630.  So we're looking up a tail page and getting its
> 
> Index 630 for offset 631, yes, that's exactly the kind of off-by-one
> I saw so frequently.
> 
> > erstwhile head page.  I'll dig in and figure out exactly how that's
> > happening.
> 
> Very pleasing to see the word "erstwhile" in use (and I'm serious about
> that); but I don't get your head for tail point - I can't make heads or
> tails of what you're saying there :) Neither 631 nor 630 is close to 512.

Ah, I'm working with another 40 or so patches on top of the single patch
I sent you, which includes the patches to make XFS use thp, and make thps
arbitrary order.  In this instance, we've hit what was probably an order-2
or order-4 page, not an order-9 page.

> Certainly it's finding a bogus page, and that's related to the multi-order
> splitting (I saw no problem with your 1-7 series), I think it's from a
> stale entry being left behind. (But that does not at all explain the
> off-by-one pattern.)

I think I understand that.  We create an order-4 page, and then swap
it out.  That leaves us with a shadow entry which stretches across 16
indices (0x270-0x27f).  Then we access one of those 16 indices again
and store that page (whichever index we happened to be looking at) in
the page cache, but the XArray doesn't know that it's supposed to be an
order-0 store, so it helpfully replaces the 'head' page (at 0x270) with
this one for 0x276.  Usually, we'll go on to access the page at 0x277,
and instead of seeing no page there, we find the wrong page and bring
everything to a juddering halt.

So seeing the common pattern of page at index n returned for page at
index n+1 is merely an artefact of our normal access patterns.  If we
were accessing random addresses, we'd've seen no pattern at all.

I'm halfway through a dual solution; one that first attempts to use the
information about the shadow entry to bring in the entire thp (if it was
in use as a thp before being paged out, we should probably try to keep
using it as a thp afterwards), but then splits the shadow entry across
the indices if the page being added is smaller than the shadow entry.

