Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7804A54FBD6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Jun 2022 19:04:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231784AbiFQREK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 Jun 2022 13:04:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229794AbiFQREJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 Jun 2022 13:04:09 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FF1820BF6
        for <linux-fsdevel@vger.kernel.org>; Fri, 17 Jun 2022 10:04:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=FvuDBSJ8CzZ3D7vF9k2T7ak6AXfXFftSU2v+MXgoclc=; b=gGhL724LMwyZOP1RBmL5n8beBH
        Si4SvaYPFERsxPECe6dr/0EvYTBLcE1mKWkX5XBRM2cRivCAUlA+wDAwcTafm3LoCK7SFVmcU1uht
        shtDwUXDsiWa3xPW02p6GNEnLRIR3NhXitYMSuZUuHlRqVhhjzBIGwL4MSLGeRMCd8cMal0c9kV4x
        IQfkC2OXcFtcb66hZpaRSsyTmQ0YbUOm/B/3KeOHpwYpsep07ekD4Xwx3VSTCUzdQva1nyowILh5+
        7U0JZOZ3ekpUduwfMuIvvlBXOXK9JIi08Bm/GpoWoxlbEKGcUaQwYeGnEhM7V1gA42XNAEmoS5YFj
        6HWY6j6A==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o2FO8-002yv3-FZ; Fri, 17 Jun 2022 17:04:04 +0000
Date:   Fri, 17 Jun 2022 18:04:04 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Brian Foster <bfoster@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org
Subject: Re: [BUG] filemap_get_read_batch()
Message-ID: <Yqy0BBtA72WVgJtS@casper.infradead.org>
References: <YqyZ0gsIqiAzJfeU@bfoster>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YqyZ0gsIqiAzJfeU@bfoster>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jun 17, 2022 at 11:12:18AM -0400, Brian Foster wrote:
> Hi,
> 
> I've hit the filemap_get_read_batch() BUG [1] that I think I saw Dave
> had also recently reported. It looks like the problem is essentially a
> race between reads, pagecache removal and folio reinsertion that leads
> to an invalid folio pointer. E.g., what I observe is the following
> (ordered) sequence of events:

Oh, this is fantastic.  Thank you for explaining my bug to me!  I've been
racking my brains for weeks trying to figure out what it is.

> Task A:
> - Lands in filemap_get_read_batch() looking for a couple folio indexes,
>   currently both populated by single page folios.
> - Grabs the folio at the first index and starts to process it.
> 
> Task B:
> - Invalidates several folios from the mapping, including both the
>   aforementioned folios task A is after.
> 
> Task C: 
> - Instantiates a compound (order 2) folio that covers both indexes being
>   processed by task A.
> 
> Task A:
> - Iterates to the next xarray index based on the (now already removed)
>   non-compound folio via xas_advance()/xas_next().
> - BUG splat down in folio_try_get_rcu() on the folio pointer..
> 
> I'm not quite sure what is being returned from the xarray here. It
> doesn't appear to be another page or anything (i.e. a tail page of a
> different folio sort of like we saw with the iomap writeback completion
> issue). I just get more splats if I try to access it purely as a page,
> so I'm not sure it's a pointer at all. I don't have enough context on
> the xarray bits to intuit on whether it might be internal data or just
> garbage if the node happened to be reformatted, etc. If you have any
> thoughts on extra things to check around that I can try to dig further
> into it..

It's a sibling entry (you can tell because bit 1 is set and it's less
than 256).  It tells you where the real entry actually is.  See below
for an explanation.

> In any event, it sort of feels like somehow or another this folio order
> change peturbs the xarray iteration since IIUC the non-compound page
> variant has been in place for a while, but that could just be wrong or
> circumstance. I'm not sure if it's possible to check the xarray node for
> such changes or whatever before attempting to process the returned entry
> (and to preserve the lockless algorithm). FWIW wrapping the whole lookup
> around an xa_lock_irq(&mapping->i_pages) lock cycle does make the
> problem disappear.

Heh, yes, it would because you wouldn't be able to change the array
while the batch lookup was running.

I think there are four possible ways to proceed.  Let's say we're
looking up the range from 0x35-0x36, we get the single-page-folio at 0x35,
they're both truncated and replaced with an order-2 folio at 0x34.

Option one is that we could return the newly-added folio, so the
folio_batch would contain the old folio at index 0x35, then the new folio
at index 0x34.  Looking at the loop in filemap_read(), I think that would
work; it doesn't make assumptions that the folios are actually contiguous,
just that there's no gaps between folios.  This feels a bit weird though.

Option two is that we could notice we got a folio which overlaps some
earlier folios, go back and delete them from the batch.  So we'd return
only the new folio at 0x34.  This code is going to be moderately complex
to write.

Option three is that we abandon all work we've done to this point and
start the lookup from the beginning of the batch.

Option four is that we just return the batch so far.  So we return the
(now-truncated) folio at 0x35, then on the next call we return the
new folio at 0x34.  This is functionally the same at option one, but
doesn't have the weird feeling.  It's also the simplest to implement,
and for this kind of race, maybe simple is better.

+++ b/mm/filemap.c
@@ -2357,6 +2357,8 @@ static void filemap_get_read_batch(struct address_space *mapping,
                        continue;
                if (xas.xa_index > max || xa_is_value(folio))
                        break;
+               if (xa_is_sibling(folio))
+                       break;
                if (!folio_try_get_rcu(folio))
                        goto retry;



> Brian
> 
> [1]
> 
> BUG: kernel NULL pointer dereference, address: 0000000000000106
> #PF: supervisor read access in kernel mode
> #PF: error_code(0x0000) - not-present page
> PGD 0 P4D 0
> Oops: 0000 [#1] PREEMPT SMP PTI
> CPU: 72 PID: 297881 Comm: xfs_io Tainted: G          I       5.19.0-rc2+ #160
> Hardware name: Dell Inc. PowerEdge R740/01KPX8, BIOS 1.6.11 11/20/2018
> RIP: 0010:filemap_get_read_batch+0x8e/0x240
> Code: 81 ff 06 04 00 00 0f 84 f7 00 00 00 48 81 ff 02 04 00 00 0f 84 c4 00 00 00 48 39 6c 24 08 0f 87 84 00 00 00 40 f6 c7 01 75 7e <8b> 47 34 85 c0 0f 84 a8 00 00 00 8d 50 01 48 8d 77 34 f0 0f b1 57

The faulting instruction is "mov    0x34(%rdi),%eax",

> RSP: 0018:ffffacdf200d7c28 EFLAGS: 00010246
> RAX: 0000000000000039 RBX: ffffacdf200d7d68 RCX: 0000000000000034
> RDX: ffff9b2aa6805220 RSI: 0000000000000074 RDI: 00000000000000d2

RDI is 0xd2.  Shift it by 2 and you get offset 52 (0x34).  So you're
proabbly looking up one of the indices 53-55 (0x35-0x37).

