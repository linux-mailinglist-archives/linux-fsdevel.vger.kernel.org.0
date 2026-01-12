Return-Path: <linux-fsdevel+bounces-73313-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 57DA6D1564F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jan 2026 22:14:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0A9353029E90
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jan 2026 21:13:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1257D318B9B;
	Mon, 12 Jan 2026 21:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="rIJaUqIg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B908F31691A
	for <linux-fsdevel@vger.kernel.org>; Mon, 12 Jan 2026 21:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768252435; cv=none; b=UcozL96mYPwBIeU+Q8XJbwy9E23GAygpXkxkbKPKGvksRyODcpgSeV5WotPNvhHeeKs0Q/JPZ9/69MmNrk15FtcZRYEDsPgmPZ8gD0hlnTbOeBsAlxgocbokpQ9ZYRfhCAAC5YIgXSZVBhyNr/0rrxvUEbbwbKvdegSkSyvoGHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768252435; c=relaxed/simple;
	bh=ggG5otyr6hrHjCUwnIZsxSdaH42ASz9soK9i2TalIrw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JlIAwYIfSRp69NATHsyXENgbau4QVlQ+HOdTiK7LZ2ouRgeIcH6q2p4MTvPGYJunrvTdNakdO/WBGDh6owXhhjU43lNaoxYZ3/ViitvRqn3vwxm/JSEv+UdieDMt15OfbMfKaIrY6gMbFJ4iLZhTR2FHdMQeVCeXOpnKFyFoDqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=rIJaUqIg; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Mon, 12 Jan 2026 21:13:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1768252421;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sxPTgY1hS6x3WN8fauxCi7vpyRV4r7loXaP/CZeSb+8=;
	b=rIJaUqIgDAVioiRw4U9QgiumQcnjPGjKJ9/mbByHkJAw9oZ943bySHt7+JysGEPB1McR7d
	tYyBINte+eUsXxuu7yaBc+L1H2NtxuZujoTwUKMbSudAAQTfhunwyqGYidXNFtJ+dgKtBM
	eV+5UBDmFHCd59rZOGjVHyLYwZj/9LQ=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yosry Ahmed <yosry.ahmed@linux.dev>
To: Gregory Price <gourry@gourry.net>
Cc: linux-mm@kvack.org, cgroups@vger.kernel.org, linux-cxl@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	kernel-team@meta.com, longman@redhat.com, tj@kernel.org, hannes@cmpxchg.org, 
	mkoutny@suse.com, corbet@lwn.net, gregkh@linuxfoundation.org, rafael@kernel.org, 
	dakr@kernel.org, dave@stgolabs.net, jonathan.cameron@huawei.com, 
	dave.jiang@intel.com, alison.schofield@intel.com, vishal.l.verma@intel.com, 
	ira.weiny@intel.com, dan.j.williams@intel.com, akpm@linux-foundation.org, 
	vbabka@suse.cz, surenb@google.com, mhocko@suse.com, jackmanb@google.com, 
	ziy@nvidia.com, david@kernel.org, lorenzo.stoakes@oracle.com, 
	Liam.Howlett@oracle.com, rppt@kernel.org, axelrasmussen@google.com, yuanchu@google.com, 
	weixugc@google.com, yury.norov@gmail.com, linux@rasmusvillemoes.dk, 
	rientjes@google.com, shakeel.butt@linux.dev, chrisl@kernel.org, kasong@tencent.com, 
	shikemeng@huaweicloud.com, nphamcs@gmail.com, bhe@redhat.com, baohua@kernel.org, 
	chengming.zhou@linux.dev, roman.gushchin@linux.dev, muchun.song@linux.dev, 
	osalvador@suse.de, matthew.brost@intel.com, joshua.hahnjy@gmail.com, 
	rakie.kim@sk.com, byungchul@sk.com, ying.huang@linux.alibaba.com, 
	apopple@nvidia.com, cl@gentwo.org, harry.yoo@oracle.com, zhengqi.arch@bytedance.com
Subject: Re: [RFC PATCH v3 7/8] mm/zswap: compressed ram direct integration
Message-ID: <4ftthovin57fi4blr2mardw4elwfsiv6vrkhrjqjsfvvuuugjj@uivjc5uzj5ys>
References: <20260108203755.1163107-1-gourry@gourry.net>
 <20260108203755.1163107-8-gourry@gourry.net>
 <i6o5k4xumd5i3ehl6ifk3554sowd2qe7yul7vhaqlh2zo6y7is@z2ky4m432wd6>
 <aWF1uDdP75gOCGLm@gourry-fedora-PF4VCD3F>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aWF1uDdP75gOCGLm@gourry-fedora-PF4VCD3F>
X-Migadu-Flow: FLOW_OUT

On Fri, Jan 09, 2026 at 04:40:08PM -0500, Gregory Price wrote:
> On Fri, Jan 09, 2026 at 04:00:00PM +0000, Yosry Ahmed wrote:
> > On Thu, Jan 08, 2026 at 03:37:54PM -0500, Gregory Price wrote:
> > 
> > If the memory is byte-addressable, using it as a second tier makes it
> > directly accessible without page faults, so the access latency is much
> > better than a swapped out page in zswap.
> > 
> > Are there some HW limitations that allow a node to be used as a backend
> > for zswap but not a second tier?
> >
> 
> Coming back around - presumably any compressed node capable of hosting a
> proper tier would be compatible with zswap, but you might have hardware
> which is sufficiently slow(er than dram, faster than storage) that using
> it as a proper tier may be less efficient than incurring faults.
> 
> The standard I've been using is 500ns+ cacheline fetches, but this is
> somewhat arbitrary.  Even 500ns might be better than accessing multi-us
> storage, but then when you add compression you might hit 600ns-1us.
> 
> This is besides the point, and apologies for the wall of text below,
> feel free to skip this next section - writing out what hardware-specific
> details I can share for the sake of completeness.

The wall of text is very helpful :)

> 
> 
> Some hardware details
> =====================
> The way every proposed piece of compressed memory hardware I have seen
> would operate is essentially by lying about its capacity to the
> operating system - and then providing mechanisms to determine when the
> compression ratio becomes is dropping to dangerous levels.
> 
> Hardware Says : 8GB
> Hardware Has  : 1GB
> Node Capacity : 8GB
> 
> The capacity numbers are static.  Even with hotplug, they must be
> considered static - because the runtime compression ratio can change.
> 
> If the device fails to achieve a 4:1 compression ratio, and real usage
> starts to exceed real capacity - the system will fail.
> (dropped writes, poisons, machine checks, etc).
> 
> We can mitigate this with strong write-controls and querying the device
> for compression ratio data prior to actually migrating a page. 

I am a little bit confused about this. Why do we only need to query the
device before migrating the page?

Are we checking if the device has enough memory for the worst case
scenario (i.e. PAGE_SIZE)?

Or are we checking if the device can compress this specific page and
checking if it can compress it and store it? This seems like it could be
racy and there might be some throwaway work.

I guess my question is: why not just give the page to the device and get
either: successfully compressed and stored OR failed?

Another question, can the device or driver be configured such that we
reject pages that compress poorly to avoid wasting memory and BW on the
device for little savings?

> 
> Why Zswap to start
> ==================
> ZSwap is an existing, clean read and write control path control.
>    - We fault on all accesses.
>    - It otherwise uses system memory under the hood (kmalloc)
> 
> I decided to use zswap as a proving ground for the concept.  While the
> design in this patch is simplistic (and as you suggest below, can
> clearly be improved), it demonstrates the entire concept:
> 
> on demotion:
> - allocate a page from private memory
> - ask the driver if it's safe to use
> - if safe -> migrate
>   if unsafe -> fallback
> 
> on memory access:
> - "promote" to a real page
> - inform the driver the page has been released (zero or discard)
> 
> As you point out, the real value in byte-accessible memory is leaving
> the memory mapped, the only difference on cram.c and zswap.c in the
> above pattern would be:
> 
> on demotion:
> - allocate a page from private memory
> - ask the driver if it's safe to use
> - if safe -> migrate and remap the page as RO in page tables
>   if unsafe
>      -> trigger reclaim on cram node
>      -> fallback to another demotion
> 
> on *write* access:
> - promote to real page
> - clean up the compressed page

This makes sense. I am assuming the main benefit of zswap.c over cram.c
in this scenario is limiting read accesses as well.

[..]
> > So the CXL code tells zswap what nodes are usable, then zswap tries
> > getting a page from these nodes and checking them using APIs provided by
> > the CXL code.
> > 
> > Wouldn't it be a better abstraction if the nodemask lived in the CXL
> > code and an API was exposed to zswap just to allocate a page to copy to?
> > Or we can abstract the copy as well and provide an API that directly
> > tries to copy the page to the compressible node.
> >
> > IOW move zswap_compress_direct() (probably under a different name?) and
> > zswap_direct_nodes into CXL code since it's not really zswap logic.
> > 
> > Also, I am not sure if the zswap_compress_direct() call and check would
> > introduce any latency, since almost all existing callers will pay for it
> > without benefiting.
> > 
> > If we move the function into CXL code, we could probably have an inline
> > wrapper in a header with a static key guarding it to make there is no
> > overhead for existing users.
> > 
> 
> 
> CXL is also the wrong place to put it - cxl is just one potential
> source of such a node.  We'd want that abstracted...
> 
> So this looks like a good use of memor-tiers.c - do dispatch there and
> have it set static branches for various features on node registration.
> 
> struct page* mt_migrate_page_to(NODE_TYPE, src, &size);
> -> on success return dst page and the size of the page on hardware
>    (target_size would address your accounting notes below)
> 
> Then have the migrate function in mt do all the node_private callbacks.
> 
> So that would limit the zswap internal change to
> 
> if (zswap_node_check()) { /* static branch check */
>     cpage = mt_migrate_page_to(NODE_PRIVATE_ZSWAP, src, &size);
>     if (compressed_page) {
>         entry->page_handle = cpage;
>         entry->length = size;
>         entry->direct = true;
> 	return true;
>     }
> }
> /* Fallthrough */

Yeah I didn't necessarily mean CXL code, but whatever layer is
responsible for keeping track of which nodes can be used for what.

> 
> ack. this is all great, thank you.
> 
> ... snip ...
> > > entry->length = size
> >
> > I don't think this works. Setting entry->length = PAGE_SIZE will cause a
> > few problems, off the top of my head:
> > 
> > 1. An entire page of memory will be charged to the memcg, so swapping
> > out the page won't reduce the memcg usage, which will cause thrashing
> > (reclaim with no progress when hitting the limit).
> >
> > Ideally we'd get the compressed length from HW and record it here to
> > charge it appropriately, but I am not sure how we actually want to
> > charge memory on a compressed node. Do we charge the compressed size as
> > normal memory? Does it need separate charging and a separate limit?
> > 
> > There are design discussions to be had before we commit to something.
> 
> I have a feeling tracking individual page usage would be way too
> granular / inefficient, but I will consult with some folks on whether
> this can be quieried.  If so, we can add way to get that info.
> 
> node_private_page_size(page) -> returns device reported page size.
> 
> or work it directly into the migrate() call like above
> 
> --- assuming there isn't a way and we have to deal with fuzzy math ---
> 
> The goal should definitely be to leave the charging statistics the same
> from the perspective of services - i.e zswap should charge a whole page,
> because according to the OS it just used a whole page.
> 
> What this would mean is memcg would have to work with fuzzy data.
> If 1GB is charged and the compression ratio is 4:1, reclaim should
> operate (by way of callback) like it has used 256MB.
> 
> I think this is the best you can do without tracking individual pages.

This part needs more thought. Zswap cannot charge a full page because
then from the memcg perspective reclaim is not making any progress.
OTOH, as you mention, from the system perspective we just consumed a
full page, so not charging that would be inconsistent.

This is not a zswap-specific thing though, even with cram.c we have to
figure out how to charge memory on the compressed node to the memcg.
It's perhaps not as much of a problem as with zswap because we are not
dealing with reclaim not making progress.

Maybe the memcg limits need to be "enlightened" about different tiers?
We did have such discussions in the past outside the context of
compressed memory, for memory tiering in general.

Not sure if this is the right place to discuss this, but I see the memcg
folks CC'd so maybe it is :)

> 
> > 
> > 2. The page will be incorrectly counted in
> > zswap_stored_incompressible_pages.
> > 
> 
> If we can track individual page size, then we can fix that.
> 
> If we can't, then we'd need zswap_stored_direct_pages and to do the
> accounting a bit differently.  Probably want direct_pages accounting
> anyway, so i might just add that.

Yeah probably the easiest way to deal with this, assuming we keep
entry->length as PAGE_SIZE.

> 
> > Aside from that, zswap_total_pages() will be wrong now, as it gets the
> > pool size from zsmalloc and these pages are not allocated from zsmalloc.
> > This is used when checking the pool limits and is exposed in stats.
> >
> 
> This is ignorance of zswap on my part, and yeah good point.  Will look
> into this accounting a little more.

This is similar-ish to the memcg charging problem, how do we count the
compressed memory usage toward the global zswap limit? Do we keep this
limit for the top-tier? If not, do we charge full size for pages in
c.zswap or compressed size?

Do we need a separate limit for c.zswap? Probably not if the whole node
is dedicated for zswap usage.

> 
> > > +		memcpy_folio(folio, 0, zfolio, 0, PAGE_SIZE);
> > 
> > Why are we using memcpy_folio() here but copy_mc_highpage() on the
> > compression path? Are they equivalent?
> > 
> 
> both are in include/linux/highmem.h
> 
> I was avoiding page->folio conversions in the compression path because
> I had a struct page already.
> 
> tl;dr: I'm still looking for the "right" way to do this.  I originally
> had a "HACK:" tag here previously but seems I definitely dropped it
> prematurely.

Not a big deal. An RFC or HACK or whatever tag just usually helps signal
to everyone (and more importantly, to Andrew) that this should not be
merged as-is.

> 
> (I also think this code can be pushed into mt_ or callbacks)

Agreed.

> 
> > > +	if (entry->direct) {
> > > +		struct page *freepage = (struct page *)entry->handle;
> > > +
> > > +		node_private_freed(freepage);
> > > +		__free_page(freepage);
> > > +	} else
> > > +		zs_free(pool->zs_pool, entry->handle);
> > 
> > This code is repeated in zswap_entry_free(), we should probably wrap it
> > in a helper that frees the private page or the zsmalloc entry based on
> > entry->direct.
> >
> 
> ack.
> 
> Thank you again for taking a look, this has been enlightening.  Good
> takeaways for the rest of the N_PRIVATE design.

Thanks for kicking off the discussion here, an interesting problem to
solve for sure :)

> 
> I think we can minimize zswap changes even further given this.
> 
> ~Gregory

