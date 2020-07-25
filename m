Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00F6922D425
	for <lists+linux-fsdevel@lfdr.de>; Sat, 25 Jul 2020 05:12:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726701AbgGYDMA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Jul 2020 23:12:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726572AbgGYDMA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Jul 2020 23:12:00 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62631C0619D3;
        Fri, 24 Jul 2020 20:12:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=nRM0sIGCGRxAUXBd8PA9t5d1Gu/Y7fxFHR9tQbAmfZI=; b=WzQ3WE0yg7n62JCZeFpgBSIcH7
        D+YFVuWgsw9KrF5zkLYxsYTM6pFz+Z4au5EAUH4sApr/FCIPDevr30tCE28hYaw76iP8TxDsKfYRZ
        dePm5A5yrSnWt9FLlCIEYooZA36iHxeULuR1HW0q6fTwyDx83ukxjqf3cZtW2vHI+/aUBYd1tMEto
        kyf4HKiArtuxIojwv2IfyryAsGBmn+BuADLmt+MuCvhooGT7MOF+UcHD0K3reD9HmGe9eRt8lBk8l
        JLSmo/uCYLAXIc4/mbtKUPMB3Y94ReS/c1vWV4sWr1EjZv7SPt5FijT8YKVOaPvySOcEM7BWnqBro
        MuX24EuQ==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jzAbO-00028U-84; Sat, 25 Jul 2020 03:11:58 +0000
Date:   Sat, 25 Jul 2020 04:11:58 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Vito Caputo <vcaputo@pengaru.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, Dave Chinner <david@fromorbit.com>
Subject: Re: [QUESTION] Sharing a `struct page` across multiple `struct
 address_space` instances
Message-ID: <20200725031158.GD23808@casper.infradead.org>
References: <20200725002221.dszdahfhqrbz43cz@shells.gnugeneration.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200725002221.dszdahfhqrbz43cz@shells.gnugeneration.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jul 24, 2020 at 05:22:21PM -0700, Vito Caputo wrote:
> Prior to looking at the code, conceptually I was envisioning the pages
> in the reflink source inode's address_space would simply get their
> refcounts bumped as they were added to the dest inode's address_space,
> with some CoW flag set to prevent writes.
> 
> But there seems to be a fundamental assumption that a `struct page`
> would only belong to a single `struct address_space` at a time, as it
> has single `mapping` and `index` members for reverse mapping the page
> to its address_space.
> 
> Am I completely lost here or does it really look like a rather
> invasive modification to support this feature?
> 
> I have vague memories of Dave Chinner mentioning work towards sharing
> pages across address spaces in the interests of getting reflink copies
> more competitive with overlayfs in terms of page cache utilization.

It's invasive.  Dave and I have chatted about this in the past.  I've done
no work towards it (... a little busy right now with THPs in the page
cache ...) but I have a design in mind.

The fundamental idea is to use the DAX support to refer to pages which
actually belong to a separate address space.  DAX entries are effectively
PFN entries.  So there would be a clear distinction between "I looked
up a page which actually belongs to this address space" and "I looked
up a page which is shared with a different address space".  My thinking
has been that if files A and B are reflinked, both A and B would see
DAX entries in their respective page caches.  The page would belong to
a third address space which might be the block device's address space,
or maybe there would be an address space per shared fragment (since
files can share fragments that are at different offsets from each other).

There are a lot of details to get right around this approach.
Importantly, there _shouldn't_ be a refcount from each of file A and
B on the page.  Instead the refcount from files A and B should be on
the fragment.  When the fragment's refcount goes to zero, we know there
are no more references to the fragment and all its pages can be freed.

That means that if we reflink B to C, we don't have to walk every page
in the file and increase its refcount again.

So, are you prepared to do a lot of work, or were you thinking this
would be a quick hack?  Because I'm willing to advise on a big project,
but if you're thinking this will be quick, and don't have time for a
big project, it's probably time to stop here.

---

Something that did occur to me while writing this is that if you just want
read-only duplicates of files to work, you could make inode->i_mapping
point to a different address_space instead of &inode->i_data.  There's
probabyl a quick hack solution there.
