Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 05A6FD7970
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Oct 2019 17:10:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733245AbfJOPJg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Oct 2019 11:09:36 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:60856 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726523AbfJOPJg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Oct 2019 11:09:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=BcDxNHsdLJjNZ3HrfFVCp2qVq0FOipn51EQF0RYAYXU=; b=Gc0t1DNqW5YGanCS6subr8Hr4
        ilCDL5GiG4w8WEKSirigBGadJZ1pc6lTH5nivEEDRvc4k8OCymshG4X30N2C13+FJj3bzlanlNXZn
        aUZSM8zZxs/JRn6TB7FKxFmXO7ObsecoUmPPBSeOdFt5aCk5WZ/iJNs1DrygwVypEuVPZrRzK452B
        4qYI9ZOlYXRSRiWPUw+OQMMj5wfupgxj1v2FssM27dAPenQVgdzc+r4bPoFmXvHcq/FFF5AwqcjyP
        0TNYEyoJbQiUmgBwdK3Nc6U9PMfQSOWyKAB1Gq3mnFCoqPjM/ivf2AmqXfQVSiXVjBEgYWXgNXOTP
        4VUiLSbAw==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iKOS5-00014K-7C; Tue, 15 Oct 2019 15:09:33 +0000
Date:   Tue, 15 Oct 2019 08:09:33 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Hannes Reinecke <hare@suse.de>
Cc:     Naohiro Aota <naohiro.aota@wdc.com>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: Project idea: Swap to zoned block devices
Message-ID: <20191015150933.GF32665@bombadil.infradead.org>
References: <20191015043827.160444-1-naohiro.aota@wdc.com>
 <20191015113548.GD32665@bombadil.infradead.org>
 <d9919d4e-4487-c0e5-c483-cebb5b8a4fc8@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d9919d4e-4487-c0e5-c483-cebb5b8a4fc8@suse.de>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Oct 15, 2019 at 03:48:47PM +0200, Hannes Reinecke wrote:
> On 10/15/19 1:35 PM, Matthew Wilcox wrote:
> > On Tue, Oct 15, 2019 at 01:38:27PM +0900, Naohiro Aota wrote:
> >> A zoned block device consists of a number of zones. Zones are
> >> either conventional and accepting random writes or sequential and
> >> requiring that writes be issued in LBA order from each zone write
> >> pointer position. For the write restriction, zoned block devices are
> >> not suitable for a swap device. Disallow swapon on them.
> > 
> > That's unfortunate.  I wonder what it would take to make the swap code be
> > suitable for zoned devices.  It might even perform better on conventional
> > drives since swapout would be a large linear write.  Swapin would be a
> > fragmented, seeky set of reads, but this would seem like an excellent
> > university project.
> 
> The main problem I'm seeing is the eviction of pages from swap.
> While swapin is easy (as you can do random access on reads), evict pages
> from cache becomes extremely tricky as you can only delete entire zones.
> So how to we mark pages within zones as being stale?
> Or can we modify the swapin code to always swap in an entire zone and
> discard it immediately?

I thought zones were too big to swap in all at once?  What's a typical
zone size these days?  (the answer looks very different if a zone is 1MB
or if it's 1GB)

Fundamentally an allocated anonymous page has 5 states:

A: In memory, not written to swap (allocated)
B: In memory, dirty, not written to swap (app modifies page)
C: In memory, clean, written to swap (kernel decides to write it)
D: Not in memory, written to swap (kernel decides to reuse the memory)
E: In memory, clean, written to swap (app faults it back in for read)

We currently have a sixth state which is a page that has previously been
written to swap but has been redirtied by the app.  It will be written
back to the allocated location the next time it's targetted for writeout.

That would have to change; since we can't do random writes, pages would
transition from states D or E back to B.  Swapping out a page that has
previously been swapped will now mean appending to the tail of the swap,
not writing in place.

So the swap code will now need to keep track of which pages are still
in use in storage and will need to be relocated once we decide to reuse
the zone.  Not an insurmountable task, but not entirely trivial.

There'd be some other gunk to deal with around handling badblocks.
Those are currently stored in page 1, so adding new ones would be
a rewrite of that block.
