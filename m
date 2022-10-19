Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F107604B76
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Oct 2022 17:31:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230158AbiJSPbZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 19 Oct 2022 11:31:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232274AbiJSPbA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 19 Oct 2022 11:31:00 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1522FEAE;
        Wed, 19 Oct 2022 08:23:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=qSLV6/G3opMlFWYdg85jnY9ptJFREWNDXEDAordoBI8=; b=wBU4yo3JmnqPFig6i8XwNBihfC
        WZe+ZAdLxr8dUWDYPTnsvKQ4JG0SLagLJ1wUST7J+tEry2ls8jkGWBrWTpiKMJmW4V5KumWiU1WuU
        jA0CCXvWbPne74Zy/1CHFgYh3vMX4yQItFrmIXnRZ9tAOl5Sa/l8VTgQP2i/WV7YjlH+/mpNsXtcE
        061ier6eaN/EGxPaYIdfiVziRwcYNSOuyLEsWaMW4yc2MyZz0if73bFN4kHxALNYMkRnnoLNbiuNi
        iYE+D3yHCI1hfxxeCPxX0wWslP9Ms1iFyT6t+USNMRqjo8+q8D3ZQFdt2elSDGbMJLkRL0hWdbmIl
        3caaetDg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1olAuU-00BeOp-3M; Wed, 19 Oct 2022 15:23:10 +0000
Date:   Wed, 19 Oct 2022 16:23:10 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Zhaoyang Huang <huangzhaoyang@gmail.com>,
        "zhaoyang.huang" <zhaoyang.huang@unisoc.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, ke.wang@unisoc.com,
        steve.kang@unisoc.com, baocong.liu@unisoc.com,
        linux-fsdevel@vger.kernel.org
Subject: Re: [RFC PATCH] mm: move xa forward when run across zombie page
Message-ID: <Y1AWXiJdyjdLmO1E@casper.infradead.org>
References: <1665725448-31439-1-git-send-email-zhaoyang.huang@unisoc.com>
 <Y0lSChlclGPkwTeA@casper.infradead.org>
 <CAGWkznG=_A-3A8JCJEoWXVcx+LUNH=gvXjLpZZs0cRX4dhUJfQ@mail.gmail.com>
 <Y017BeC64GDb3Kg7@casper.infradead.org>
 <CAGWkznEdtGPPZkHrq6Y_+XLL37w12aC8XN8R_Q-vhq48rFhkSA@mail.gmail.com>
 <Y04Y3RNq6D2T9rVw@casper.infradead.org>
 <20221018223042.GJ2703033@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221018223042.GJ2703033@dread.disaster.area>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Oct 19, 2022 at 09:30:42AM +1100, Dave Chinner wrote:
> This is reading and writing the same amount of file data at the
> application level, but once the data has been written and kicked out
> of the page cache it seems to require an awful lot more read IO to
> get it back to the application. i.e. this looks like mmap() is
> readahead thrashing severely, and eventually it livelocks with this
> sort of report:
> 
> [175901.982484] rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
> [175901.985095] rcu:    Tasks blocked on level-1 rcu_node (CPUs 0-15): P25728
> [175901.987996]         (detected by 0, t=97399871 jiffies, g=15891025, q=1972622 ncpus=32)
> [175901.991698] task:test_write      state:R  running task     stack:12784 pid:25728 ppid: 25696 flags:0x00004002
> [175901.995614] Call Trace:
> [175901.996090]  <TASK>
> [175901.996594]  ? __schedule+0x301/0xa30
> [175901.997411]  ? sysvec_apic_timer_interrupt+0xb/0x90
> [175901.998513]  ? sysvec_apic_timer_interrupt+0xb/0x90
> [175901.999578]  ? asm_sysvec_apic_timer_interrupt+0x16/0x20
> [175902.000714]  ? xas_start+0x53/0xc0
> [175902.001484]  ? xas_load+0x24/0xa0
> [175902.002208]  ? xas_load+0x5/0xa0
> [175902.002878]  ? __filemap_get_folio+0x87/0x340
> [175902.003823]  ? filemap_fault+0x139/0x8d0
> [175902.004693]  ? __do_fault+0x31/0x1d0
> [175902.005372]  ? __handle_mm_fault+0xda9/0x17d0
> [175902.006213]  ? handle_mm_fault+0xd0/0x2a0
> [175902.006998]  ? exc_page_fault+0x1d9/0x810
> [175902.007789]  ? asm_exc_page_fault+0x22/0x30
> [175902.008613]  </TASK>
> 
> Given that filemap_fault on XFS is probably trying to map large
> folios, I do wonder if this is a result of some kind of race with
> teardown of a large folio...

It doesn't matter whether we're trying to map a large folio; it
matters whether a large folio was previously created in the cache.
Through the magic of readahead, it may well have been.  I suspect
it's not teardown of a large folio, but splitting.  Removing a
page from the page cache stores to the pointer in the XArray
first (either NULL or a shadow entry), then decrements the refcount.

We must be observing a frozen folio.  There are a number of places
in the MM which freeze a folio, but the obvious one is splitting.
That looks like this:

        local_irq_disable();
        if (mapping) {
                xas_lock(&xas);
(...)
        if (folio_ref_freeze(folio, 1 + extra_pins)) {

So one way to solve this might be to try to take the xa_lock on
failure to get the refcount.  Otherwise a high-priority task
might spin forever without a low-priority task getting the chance
to finish the work being done while the folio is frozen.

ie this:

diff --git a/mm/filemap.c b/mm/filemap.c
index 08341616ae7a..ca0eed80580f 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -1860,8 +1860,13 @@ static void *mapping_get_entry(struct address_space *mapping, pgoff_t index)
 	if (!folio || xa_is_value(folio))
 		goto out;
 
-	if (!folio_try_get_rcu(folio))
+	if (!folio_try_get_rcu(folio)) {
+		unsigned long flags;
+
+		xas_lock_irqsave(&xas, flags);
+		xas_unlock_irqrestore(&xas, flags);
 		goto repeat;
+	}
 
 	if (unlikely(folio != xas_reload(&xas))) {
 		folio_put(folio);
@@ -2014,8 +2019,13 @@ static inline struct folio *find_get_entry(struct xa_state *xas, pgoff_t max,
 	if (!folio || xa_is_value(folio))
 		return folio;
 
-	if (!folio_try_get_rcu(folio))
+	if (!folio_try_get_rcu(folio)) {
+		unsigned long flags;
+
+		xas_lock_irqsave(xas, flags);
+		xas_unlock_irqrestore(xas, flags);
 		goto reset;
+	}
 
 	if (unlikely(folio != xas_reload(xas))) {
 		folio_put(folio);
@@ -2224,8 +2234,13 @@ unsigned filemap_get_folios_contig(struct address_space *mapping,
 		if (xa_is_value(folio))
 			goto update_start;
 
-		if (!folio_try_get_rcu(folio))
+		if (!folio_try_get_rcu(folio)) {
+			unsigned long flags;
+
+			xas_lock_irqsave(&xas, flags);
+			xas_unlock_irqrestore(&xas, flags);
 			goto retry;
+		}
 
 		if (unlikely(folio != xas_reload(&xas)))
 			goto put_folio;
@@ -2365,8 +2380,13 @@ static void filemap_get_read_batch(struct address_space *mapping,
 			break;
 		if (xa_is_sibling(folio))
 			break;
-		if (!folio_try_get_rcu(folio))
+		if (!folio_try_get_rcu(folio)) {
+			unsigned long flags;
+
+			xas_lock_irqsave(&xas, flags);
+			xas_unlock_irqrestore(&xas, flags);
 			goto retry;
+		}
 
 		if (unlikely(folio != xas_reload(&xas)))
 			goto put_folio;

I'm kicking off an xfstests run to see if that causes any new problems.

> There is a very simple corruption reproducer script that has been
> written, but I haven't been using it. I don't know if long term
> running of the script here:
> 
> https://lore.kernel.org/linux-xfs/d00aff43-2bdc-0724-1996-4e58e061ecfd@redhat.com/
> 
> will trigger the livelock as the verification step is
> significantly different, but it will give you insight into the
> setup of the environment that leads to the livelock. Maybe you could
> replace the md5sum verification with a mmap read with xfs_io to
> simulate the fault load that seems to lead to this issue...

If the problem needs scheduling parameters to hit, then that script
isn't going to reproduce the problems for me.  But I'll give it a try
anyway.
