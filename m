Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23014606A81
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Oct 2022 23:52:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230074AbiJTVw2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 Oct 2022 17:52:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbiJTVw0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 Oct 2022 17:52:26 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3A9E1D4621;
        Thu, 20 Oct 2022 14:52:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=zl1+lgnFnP330eRmt/FInO+nQZKgIEnqURsYwYEVj0k=; b=f0KGmdPRzUiXAfJVP1+jaG4W9p
        9Gk0OGaoU0TjiebDXQpjBBzQqhO4FdnkjxRKdQs98J9RNFI7jqw4pm8IohKlTtIKjw8TxuPwD8GAb
        Zo3sMpulpOJfosELNuCvfnnQ9ctU+RD8QQ4JxIPNl3xc225z/Obc+R3DTJWUwAcNaCsXAEhX7Qbpx
        CfP1WpwyMg8CC3VLaJuEWDJsKCVDDmQqZ846EjkIy7Z0uwQuZDRFqDy4IV15k4bKqW0ufOu3bb7vr
        EfLEspRYeVlOb2G1akQLmQPg7QyTvJECA05oT+TEFlMmbTcjlwN+WI2FnUgksCmGxohUG47bGNJ5P
        CwitaE5w==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oldSY-00CgsI-20; Thu, 20 Oct 2022 21:52:14 +0000
Date:   Thu, 20 Oct 2022 22:52:14 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Zhaoyang Huang <huangzhaoyang@gmail.com>,
        "zhaoyang.huang" <zhaoyang.huang@unisoc.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, ke.wang@unisoc.com,
        steve.kang@unisoc.com, baocong.liu@unisoc.com,
        linux-fsdevel@vger.kernel.org
Subject: Re: [RFC PATCH] mm: move xa forward when run across zombie page
Message-ID: <Y1HDDu3UV0L3cDwE@casper.infradead.org>
References: <1665725448-31439-1-git-send-email-zhaoyang.huang@unisoc.com>
 <Y0lSChlclGPkwTeA@casper.infradead.org>
 <CAGWkznG=_A-3A8JCJEoWXVcx+LUNH=gvXjLpZZs0cRX4dhUJfQ@mail.gmail.com>
 <Y017BeC64GDb3Kg7@casper.infradead.org>
 <CAGWkznEdtGPPZkHrq6Y_+XLL37w12aC8XN8R_Q-vhq48rFhkSA@mail.gmail.com>
 <Y04Y3RNq6D2T9rVw@casper.infradead.org>
 <20221018223042.GJ2703033@dread.disaster.area>
 <Y1AWXiJdyjdLmO1E@casper.infradead.org>
 <20221019220424.GO2703033@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221019220424.GO2703033@dread.disaster.area>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Oct 20, 2022 at 09:04:24AM +1100, Dave Chinner wrote:
> On Wed, Oct 19, 2022 at 04:23:10PM +0100, Matthew Wilcox wrote:
> > On Wed, Oct 19, 2022 at 09:30:42AM +1100, Dave Chinner wrote:
> > > This is reading and writing the same amount of file data at the
> > > application level, but once the data has been written and kicked out
> > > of the page cache it seems to require an awful lot more read IO to
> > > get it back to the application. i.e. this looks like mmap() is
> > > readahead thrashing severely, and eventually it livelocks with this
> > > sort of report:
> > > 
> > > [175901.982484] rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
> > > [175901.985095] rcu:    Tasks blocked on level-1 rcu_node (CPUs 0-15): P25728
> > > [175901.987996]         (detected by 0, t=97399871 jiffies, g=15891025, q=1972622 ncpus=32)
> > > [175901.991698] task:test_write      state:R  running task     stack:12784 pid:25728 ppid: 25696 flags:0x00004002
> > > [175901.995614] Call Trace:
> > > [175901.996090]  <TASK>
> > > [175901.996594]  ? __schedule+0x301/0xa30
> > > [175901.997411]  ? sysvec_apic_timer_interrupt+0xb/0x90
> > > [175901.998513]  ? sysvec_apic_timer_interrupt+0xb/0x90
> > > [175901.999578]  ? asm_sysvec_apic_timer_interrupt+0x16/0x20
> > > [175902.000714]  ? xas_start+0x53/0xc0
> > > [175902.001484]  ? xas_load+0x24/0xa0
> > > [175902.002208]  ? xas_load+0x5/0xa0
> > > [175902.002878]  ? __filemap_get_folio+0x87/0x340
> > > [175902.003823]  ? filemap_fault+0x139/0x8d0
> > > [175902.004693]  ? __do_fault+0x31/0x1d0
> > > [175902.005372]  ? __handle_mm_fault+0xda9/0x17d0
> > > [175902.006213]  ? handle_mm_fault+0xd0/0x2a0
> > > [175902.006998]  ? exc_page_fault+0x1d9/0x810
> > > [175902.007789]  ? asm_exc_page_fault+0x22/0x30
> > > [175902.008613]  </TASK>
> > > 
> > > Given that filemap_fault on XFS is probably trying to map large
> > > folios, I do wonder if this is a result of some kind of race with
> > > teardown of a large folio...
> > 
> > It doesn't matter whether we're trying to map a large folio; it
> > matters whether a large folio was previously created in the cache.
> > Through the magic of readahead, it may well have been.  I suspect
> > it's not teardown of a large folio, but splitting.  Removing a
> > page from the page cache stores to the pointer in the XArray
> > first (either NULL or a shadow entry), then decrements the refcount.
> > 
> > We must be observing a frozen folio.  There are a number of places
> > in the MM which freeze a folio, but the obvious one is splitting.
> > That looks like this:
> > 
> >         local_irq_disable();
> >         if (mapping) {
> >                 xas_lock(&xas);
> > (...)
> >         if (folio_ref_freeze(folio, 1 + extra_pins)) {
> 
> But the lookup is not doing anything to prevent the split on the
> frozen page from making progress, right? It's not holding any folio
> references, and it's not holding the mapping tree lock, either. So
> how does the lookup in progress prevent the page split from making
> progress?

My thinking was that it keeps hammering the ->refcount field in
struct folio.  That might prevent a thread on a different socket
from making forward progress.  In contrast, spinlocks are designed
to be fair under contention, so by spinning on an actual lock, we'd
remove contention on the folio.

But I think the tests you've done refute that theory.  I'm all out of
ideas at the moment.  Either we have a frozen folio from somebody who
doesn't hold the lock, or we have someone who's left a frozen folio in
the page cache.  I'm leaning towards that explanation at the moment,
but I don't have a good suggestion for debugging.

Perhaps a bad suggestion for debugging would be to call dump_page()
with a __ratelimit() wrapper to not be overwhelmed with information?

> I would have thought:
> 
> 	if (!folio_try_get_rcu(folio)) {
> 		rcu_read_unlock();
> 		cond_resched();
> 		rcu_read_lock();
> 		goto repeat;
> 	}
> 
> Would be the right way to yeild the CPU to avoid priority
> inversion related livelocks here...

I'm not sure we're allowed to schedule here.  We might be under another
spinlock?
