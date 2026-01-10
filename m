Return-Path: <linux-fsdevel+bounces-73136-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E583DD0D922
	for <lists+linux-fsdevel@lfdr.de>; Sat, 10 Jan 2026 17:30:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 05D383025588
	for <lists+linux-fsdevel@lfdr.de>; Sat, 10 Jan 2026 16:30:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 853E81F03D2;
	Sat, 10 Jan 2026 16:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="YiED6Shy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEF52225397
	for <linux-fsdevel@vger.kernel.org>; Sat, 10 Jan 2026 16:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768062636; cv=none; b=f5lupBMy4IMJbbX9Cvfh7aXsWL5mRsiDKK8ELp59gGslmezikQV78wT4Fctg32x177uDK6vhHw74gjEA8NG7VaMFKIcvCbR3cjBPQqlakHwO1dH0GwtGBH9N3NOBiPoRx4HOnBLSEPIrFF73wy5vUgXPtlhyJhIYo5rb1CMW0yg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768062636; c=relaxed/simple;
	bh=ozbJZp4+0mIbMyfnt5QOg/HiZ9oYTBoj41aDI8WgpYQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iN3NytbMA6ucJdZo6oTXL3SvMFWNJ5RV6brxlB3O5oPG8btO7eXcs7iP7kU2j39r6A3oAwxDfsags4dA9RKvcVvTxN8OI+U/EPxCdD3g+Vp22CLqy4ViK5wHMgmjnyF+wt5B7Urnlj9iwQfwbtZPZhYk+ER8PX+CPC4G+eOc+bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=YiED6Shy; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=UKdNQinLdfkQ5ZjIhnHbKnawUimweEFVSRdn+zzu4Ck=; b=YiED6ShyrW/Jomgy26B8DzLXHP
	E7TYHMotPXdP8MCQ32/eMItOuyzLZhWnTnn/PxvUsiVVjr7Fnzi4tmKNcJ3lfSRuAeY0IosQShC2g
	+tYAncMiSoMUGVg2Shm+JRv4YOdYKQDcMLx/CBmrOyD3G4Bl7TJLdSabaa07LXYYPVWku2RmfDac7
	+nERb8LxtuajjysfONvYqXcnwPaN/+BB9MNrBKsbUVBpH4vil0kaejDgJai5PJRMo7QfpTYDYDZZk
	BwhKhknhJrntXyvk0gUBdKFZ/poaHj+Z73UAbndNVaeUZmr0YV+scrOFAKsqoSyYo4xBZqyIkrE1V
	vRFK8jQA==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vebrA-00000000pLa-1too;
	Sat, 10 Jan 2026 16:30:28 +0000
Date: Sat, 10 Jan 2026 16:30:28 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Bernd Schubert <bernd@bsbernd.com>, Jan Kara <jack@suse.cz>
Cc: Joanne Koong <joannelkoong@gmail.com>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Horst Birthelmer <hbirthelmer@ddn.com>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>,
	"David Hildenbrand (Red Hat)" <david@kernel.org>
Subject: Re: __folio_end_writeback() lockdep issue
Message-ID: <aWJ-pHIY8Y8sjLeC@casper.infradead.org>
References: <9b845a47-9aee-43dd-99bc-1a82bea00442@bsbernd.com>
 <b7b72183-f9e1-4e58-b40f-45a267cc6831@bsbernd.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b7b72183-f9e1-4e58-b40f-45a267cc6831@bsbernd.com>

On Sat, Jan 10, 2026 at 04:31:28PM +0100, Bernd Schubert wrote:
> [  872.499480]  Possible interrupt unsafe locking scenario:
> [  872.499480] 
> [  872.500326]        CPU0                    CPU1
> [  872.500906]        ----                    ----
> [  872.501464]   lock(&p->sequence);
> [  872.501923]                                local_irq_disable();
> [  872.502615]                                lock(&xa->xa_lock#4);
> [  872.503327]                                lock(&p->sequence);
> [  872.504116]   <Interrupt>
> [  872.504513]     lock(&xa->xa_lock#4);
> 
> 
> Which is introduced by commit 2841808f35ee for all file systems. 
> The should be rather generic - I shouldn't be the only one seeing
> it?

Oh wow, 2841808f35ee has a very confusing commit message.  It implies
that _no_ filesystem uses BDI_CAP_WRITEBACK_ACCT, but what it really
means is that no filesystem now _clears_ BDI_CAP_WRITEBACK_ACCT, so
all filesystems do use this code path and therefore the flag can be
removed.  And that matches the code change.

So you should be able to reproduce this problem with commit 494d2f508883
as well?

That tells me that this is something fuse-specific.  Other filesystems
aren't seeing this.  Wonder why ...

__wb_writeout_add() or its predecessor __wb_writeout_inc() have been in
that spot since 2015 or earlier.  

The sequence lock itself is taken inside fprop_new_period() called from
writeout_period() which has been there since 2012, so that's not it.

Looking at fprop_new_period() is more interesting.  Commit a91befde3503
removed an earlier call to local_irq_save().  It was then replaced with
preempt_disable() in 9458e0a78c45 but maybe removing it was just
erroneous?

Anyway, that was 2022, so it doesn't answer "why is this only showing up
now and only for fuse?"  But maybe replacing the preempt-disable with
irq-disable in fprop_new_period() is the right solution, regardless.

> So this?
> 
> mm: fix HARDIRQ-safe -> HARDIRQ-unsafe lock order in __folio_end_writeback()
> 
> __wb_writeout_add() is called while holding xa_lock (HARDIRQ-safe),
> but it eventually calls fprop_fraction_percpu() which acquires
> p->sequence (HARDIRQ-unsafe via seqcount), creating a lock ordering
> violation.
> 
> Call trace:
>   __folio_end_writeback()
>     xa_lock_irqsave(&mapping->i_pages)     <- HARDIRQ-safe
>       __wb_writeout_add()
>         wb_domain_writeout_add()
>           __fprop_add_percpu_max()
>             fprop_fraction_percpu()
>               read_seqcount_begin(&p->sequence)  <- HARDIRQ-unsafe
> 
> Possible deadlock scenario:
> 
>        CPU0                    CPU1
>        ----                    ----
>   lock(p->sequence)
>                                local_irq_disable()
>                                lock(xa_lock)
>                                lock(p->sequence)
>   <hardirq>
>     lock(xa_lock)
> 
>                    *** DEADLOCK ***
> 
> Fix by moving __wb_writeout_add() outside the xa_lock critical section.
> It only accesses percpu counters and global writeback domain structures,
> none of which require xa_lock protection.
> 
> Fixes: 2841808f35ee ("mm: remove BDI_CAP_WRITEBACK_ACCT")
> Signed-off-by: Bernd Schubert <bschubert@ddn.com>
> 
> diff --git a/mm/page-writeback.c b/mm/page-writeback.c
> index ccdeb0e84d39..ab83e3cbbf94 100644
> --- a/mm/page-writeback.c
> +++ b/mm/page-writeback.c
> @@ -2994,7 +2994,6 @@ bool __folio_end_writeback(struct folio *folio)
>  
>                 wb = inode_to_wb(inode);
>                 wb_stat_mod(wb, WB_WRITEBACK, -nr);
> -               __wb_writeout_add(wb, nr);
>                 if (!mapping_tagged(mapping, PAGECACHE_TAG_WRITEBACK)) {
>                         wb_inode_writeback_end(wb);
>                         if (mapping->host)
> @@ -3002,6 +3001,7 @@ bool __folio_end_writeback(struct folio *folio)
>                 }
>  
>                 xa_unlock_irqrestore(&mapping->i_pages, flags);
> +               __wb_writeout_add(wb, nr);
>         } else {
>                 ret = folio_xor_flags_has_waiters(folio, 1 << PG_writeback);
>         }
> 
> 
> 
> Thanks,
> Bernd
> 
> 
> 

