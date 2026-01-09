Return-Path: <linux-fsdevel+bounces-73096-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F184AD0C5AA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 09 Jan 2026 22:42:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 321A53069D45
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Jan 2026 21:40:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9D3833C534;
	Fri,  9 Jan 2026 21:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="cRnbtg6n"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B402733DED6
	for <linux-fsdevel@vger.kernel.org>; Fri,  9 Jan 2026 21:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767994848; cv=none; b=lSInY2X8V5b6DP/wKqe576fwmrSjUAWjVZvAj3SG4AaUHWZ97sAVE5W9B4pTfDwkrfoCMGoB79MGL+mTRvOeSvmhSF+VghQ32Ny9/eA+crd0qPl0rywTX5BIL4XxJipgnQ3MkBbDB0xitlR5E/wb9RIDhjEHPgCtFyxsF2K57R0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767994848; c=relaxed/simple;
	bh=rokgdpNlEFvXSrJ3DO0WB3cNAjfaaYjpYXIICls+Z14=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lG3NXNv1Jexw0HSaj5sZLYzybdIw463DhDRajamUAcVzAdKIqADU5E7uwooSeVQXZgrfDVHhtIxd6F2pKzA9bSFVRoNRLuY0t0hL4AoQ1VkRjxxhfAQJFgHjqsb07avppTmplcI/i/zRGU4LcF1g/PoFe450YUNIvidoaYvyT9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=cRnbtg6n; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-8b25dd7ab33so357501685a.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 09 Jan 2026 13:40:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1767994843; x=1768599643; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1T5Jfe8diqm3ahhuEtgg+KQ26xQUqcKW5qWJWdj6z0g=;
        b=cRnbtg6nxRxHPymwel7ryQQxFzD0V6RnfH41PZcSiqDg2O9KwY8mDVQ0kO4e1XRZUK
         BUwYPE7HarDmXSHC2FcUZtKs5Zp2ot0eQzcfjicbBhbNFBCTK6jQnfEn0F03R0PUsRIU
         FtvJhxG9J92W69pmFEBaS366yjx7JPFp4j2UislvqbVR2NcOBWYBhnkSLYHr8jqHbN+d
         sTp6YJ3fo4tnomCPzAdFMjLXZLiI0rDXJETC7D4eWVgjktTo20nf4cz/eHR/6n0/kjsy
         jszyg24DdEVK3X4fIQRpDBaEqaukJO3d52pNWOEaNnsfsk55ulCJfTybBSi/6rA1WcQZ
         /hbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767994843; x=1768599643;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1T5Jfe8diqm3ahhuEtgg+KQ26xQUqcKW5qWJWdj6z0g=;
        b=Pp/lZJNgaZebMvp03FYT1KLWZ1EYvaLuYoYOmGEu3yPIO5Loj9rG1AEbAqsHcgDthS
         x2kEp6ZRQhNCg5qcWsRqbwJoDZyw6yikhLQwzOeDWAovqTyfd+4oujiJcuOLPi7sqfB/
         KJQiQhsP1TOv1AfyYsRbyTeOst5/02y3HfrH8PBC9OoEjdAQHTnX3UZbg5YpVF2YA5+n
         WJNkN0YdYp+7Mz9EVM/i1NbYgwsosPkqx7oZ2fsZvX6IjJfKs78xOIfT5H35JbSeNRTr
         GbvAs7b+YhBL9f5hjTSQYWK5l2axKCTBGrqsv2yD3TzHy0Qgjm6ik0Bok8HlDAeeNtE3
         5AXQ==
X-Forwarded-Encrypted: i=1; AJvYcCU2/niG4onVIkgDw67dMy1c+OEXRT7rxrMGB0xHSECQeUxfc+pVUkxCVSWAzb5Do14Bf3WnVKw/5ZKI5LBp@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5uTG/RlyWKgeMKpLggmoQcipZenjBiXD1J/w+MjL5wXhH3PPh
	MmSnTjwbcBY+1ZHIxidVQ74+C2muAxbBPMuYDjAhd2KzNv40h+Iulows64pAVtdTI0k=
X-Gm-Gg: AY/fxX5L+cBZgvKs8VOYjycTwtnTCppXC2qFz5K2hufsW1JSXAf4ACuxFtd38+DrOHn
	Q0rf5IX1ah+FTvwSc1p6UrbgVeuU1UKKLSILy3RIbbhmuy1Sx0lMaQkWaeZ5cQG89H/EP33SZRM
	hQKxsDgKNshKhO0N1TRVolMvuK7baZWce82vPTXnUi5/got7cRpnZ0dxCdpBHqKWuZqBJ/xu/n6
	8hx3I/Ym1onylzlImsf1PB1iXtFWhrBtbK2uCH6TTPGPkoUmeUbIH4gRrYZcXb83Jh5yMBcdVFP
	acS1dsNk5eLG7gZ6Vhomx5sJ4nuMFTdFdLsR2UG993Y/SgR2v3mOW5UAVn1J0PMiR+TVVXEy1LB
	hZ/QoNVc5za75Q8blXUL4RIpqK9cP48FqXrPkzQWkKoxfDkcRyNP93HbvLWW5cMxPOFzuez7VdX
	THsKS3bYk5hcJxXXAwNQYxbtMiLL8Q5d6uVdvneXxvuytuWP52VVFP8EMUU35KcbNka8j7Yg==
X-Google-Smtp-Source: AGHT+IECZ50vj1hnAePHBzinDlZDGYs+7/mlvEWHygZHTAQz3MseJ7eUXnsVQ1HRY8SD8qWK1C+CIw==
X-Received: by 2002:a05:620a:1709:b0:8b2:a0cd:90f1 with SMTP id af79cd13be357-8c3893de7c3mr1525931485a.61.1767994843351;
        Fri, 09 Jan 2026 13:40:43 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c37f4ccdf8sm924975985a.23.2026.01.09.13.40.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jan 2026 13:40:42 -0800 (PST)
Date: Fri, 9 Jan 2026 16:40:08 -0500
From: Gregory Price <gourry@gourry.net>
To: Yosry Ahmed <yosry.ahmed@linux.dev>
Cc: linux-mm@kvack.org, cgroups@vger.kernel.org, linux-cxl@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, kernel-team@meta.com,
	longman@redhat.com, tj@kernel.org, hannes@cmpxchg.org,
	mkoutny@suse.com, corbet@lwn.net, gregkh@linuxfoundation.org,
	rafael@kernel.org, dakr@kernel.org, dave@stgolabs.net,
	jonathan.cameron@huawei.com, dave.jiang@intel.com,
	alison.schofield@intel.com, vishal.l.verma@intel.com,
	ira.weiny@intel.com, dan.j.williams@intel.com,
	akpm@linux-foundation.org, vbabka@suse.cz, surenb@google.com,
	mhocko@suse.com, jackmanb@google.com, ziy@nvidia.com,
	david@kernel.org, lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com, rppt@kernel.org, axelrasmussen@google.com,
	yuanchu@google.com, weixugc@google.com, yury.norov@gmail.com,
	linux@rasmusvillemoes.dk, rientjes@google.com,
	shakeel.butt@linux.dev, chrisl@kernel.org, kasong@tencent.com,
	shikemeng@huaweicloud.com, nphamcs@gmail.com, bhe@redhat.com,
	baohua@kernel.org, chengming.zhou@linux.dev,
	roman.gushchin@linux.dev, muchun.song@linux.dev, osalvador@suse.de,
	matthew.brost@intel.com, joshua.hahnjy@gmail.com, rakie.kim@sk.com,
	byungchul@sk.com, ying.huang@linux.alibaba.com, apopple@nvidia.com,
	cl@gentwo.org, harry.yoo@oracle.com, zhengqi.arch@bytedance.com
Subject: Re: [RFC PATCH v3 7/8] mm/zswap: compressed ram direct integration
Message-ID: <aWF1uDdP75gOCGLm@gourry-fedora-PF4VCD3F>
References: <20260108203755.1163107-1-gourry@gourry.net>
 <20260108203755.1163107-8-gourry@gourry.net>
 <i6o5k4xumd5i3ehl6ifk3554sowd2qe7yul7vhaqlh2zo6y7is@z2ky4m432wd6>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <i6o5k4xumd5i3ehl6ifk3554sowd2qe7yul7vhaqlh2zo6y7is@z2ky4m432wd6>

On Fri, Jan 09, 2026 at 04:00:00PM +0000, Yosry Ahmed wrote:
> On Thu, Jan 08, 2026 at 03:37:54PM -0500, Gregory Price wrote:
> 
> If the memory is byte-addressable, using it as a second tier makes it
> directly accessible without page faults, so the access latency is much
> better than a swapped out page in zswap.
> 
> Are there some HW limitations that allow a node to be used as a backend
> for zswap but not a second tier?
>

Coming back around - presumably any compressed node capable of hosting a
proper tier would be compatible with zswap, but you might have hardware
which is sufficiently slow(er than dram, faster than storage) that using
it as a proper tier may be less efficient than incurring faults.

The standard I've been using is 500ns+ cacheline fetches, but this is
somewhat arbitrary.  Even 500ns might be better than accessing multi-us
storage, but then when you add compression you might hit 600ns-1us.

This is besides the point, and apologies for the wall of text below,
feel free to skip this next section - writing out what hardware-specific
details I can share for the sake of completeness.


Some hardware details
=====================
The way every proposed piece of compressed memory hardware I have seen
would operate is essentially by lying about its capacity to the
operating system - and then providing mechanisms to determine when the
compression ratio becomes is dropping to dangerous levels.

Hardware Says : 8GB
Hardware Has  : 1GB
Node Capacity : 8GB

The capacity numbers are static.  Even with hotplug, they must be
considered static - because the runtime compression ratio can change.

If the device fails to achieve a 4:1 compression ratio, and real usage
starts to exceed real capacity - the system will fail.
(dropped writes, poisons, machine checks, etc).

We can mitigate this with strong write-controls and querying the device
for compression ratio data prior to actually migrating a page. 

Why Zswap to start
==================
ZSwap is an existing, clean read and write control path control.
   - We fault on all accesses.
   - It otherwise uses system memory under the hood (kmalloc)

I decided to use zswap as a proving ground for the concept.  While the
design in this patch is simplistic (and as you suggest below, can
clearly be improved), it demonstrates the entire concept:

on demotion:
- allocate a page from private memory
- ask the driver if it's safe to use
- if safe -> migrate
  if unsafe -> fallback

on memory access:
- "promote" to a real page
- inform the driver the page has been released (zero or discard)

As you point out, the real value in byte-accessible memory is leaving
the memory mapped, the only difference on cram.c and zswap.c in the
above pattern would be:

on demotion:
- allocate a page from private memory
- ask the driver if it's safe to use
- if safe -> migrate and remap the page as RO in page tables
  if unsafe
     -> trigger reclaim on cram node
     -> fallback to another demotion

on *write* access:
- promote to real page
- clean up the compressed page

> Or is the idea to make promotions from compressed memory to normal
> memory fault-driver instead of relying on page hotness?
> 
> I also think there are some design decisions that need to be made before
> we commit to this, see the comments below for more.
>

100% agreed, i'm absolutely not locked into a design, this just gets the
ball rolling :].

> >  /* RCU-protected iteration */
> >  static LIST_HEAD(zswap_pools);
> >  /* protects zswap_pools list modification */
> > @@ -716,7 +732,13 @@ static void zswap_entry_cache_free(struct zswap_entry *entry)
> >  static void zswap_entry_free(struct zswap_entry *entry)
> >  {
> >  	zswap_lru_del(&zswap_list_lru, entry);
> > -	zs_free(entry->pool->zs_pool, entry->handle);
> > +	if (entry->direct) {
> > +		struct page *page = (struct page *)entry->handle;
> 
> Would it be cleaner to add a union in zswap_entry that has entry->handle
> and entry->page?
> 

Absolutely. Ack.

> > +		/* Skip nodes we've already tried and failed */
> > +		if (node_isset(nid, tried_nodes))
> > +			continue;
> 
> Why do we need this? Does for_each_node_mask() iterate each node more
> than once?
>

This is just me being stupid, i will clean this up.  I think i wrote
this when i was using a _next nodemask variant that can loop around and
just left this in when i got it working.

> I think we can drop the 'found' label by moving things around, would
> this be simpler?
> 	for_each_node_mask(..) {
> 		...
> 		ret = node_private_allocated(dst);
> 		if (!ret)
> 			break;
> 
> 		__free_page(dst);
> 		dst = NULL;
> 	}
> 

ack, thank you.

> So the CXL code tells zswap what nodes are usable, then zswap tries
> getting a page from these nodes and checking them using APIs provided by
> the CXL code.
> 
> Wouldn't it be a better abstraction if the nodemask lived in the CXL
> code and an API was exposed to zswap just to allocate a page to copy to?
> Or we can abstract the copy as well and provide an API that directly
> tries to copy the page to the compressible node.
>
> IOW move zswap_compress_direct() (probably under a different name?) and
> zswap_direct_nodes into CXL code since it's not really zswap logic.
> 
> Also, I am not sure if the zswap_compress_direct() call and check would
> introduce any latency, since almost all existing callers will pay for it
> without benefiting.
> 
> If we move the function into CXL code, we could probably have an inline
> wrapper in a header with a static key guarding it to make there is no
> overhead for existing users.
> 


CXL is also the wrong place to put it - cxl is just one potential
source of such a node.  We'd want that abstracted...

So this looks like a good use of memor-tiers.c - do dispatch there and
have it set static branches for various features on node registration.

struct page* mt_migrate_page_to(NODE_TYPE, src, &size);
-> on success return dst page and the size of the page on hardware
   (target_size would address your accounting notes below)

Then have the migrate function in mt do all the node_private callbacks.

So that would limit the zswap internal change to

if (zswap_node_check()) { /* static branch check */
    cpage = mt_migrate_page_to(NODE_PRIVATE_ZSWAP, src, &size);
    if (compressed_page) {
        entry->page_handle = cpage;
        entry->length = size;
        entry->direct = true;
	return true;
    }
}
/* Fallthrough */

ack. this is all great, thank you.

... snip ...
> > entry->length = size
>
> I don't think this works. Setting entry->length = PAGE_SIZE will cause a
> few problems, off the top of my head:
> 
> 1. An entire page of memory will be charged to the memcg, so swapping
> out the page won't reduce the memcg usage, which will cause thrashing
> (reclaim with no progress when hitting the limit).
>
> Ideally we'd get the compressed length from HW and record it here to
> charge it appropriately, but I am not sure how we actually want to
> charge memory on a compressed node. Do we charge the compressed size as
> normal memory? Does it need separate charging and a separate limit?
> 
> There are design discussions to be had before we commit to something.

I have a feeling tracking individual page usage would be way too
granular / inefficient, but I will consult with some folks on whether
this can be quieried.  If so, we can add way to get that info.

node_private_page_size(page) -> returns device reported page size.

or work it directly into the migrate() call like above

--- assuming there isn't a way and we have to deal with fuzzy math ---

The goal should definitely be to leave the charging statistics the same
from the perspective of services - i.e zswap should charge a whole page,
because according to the OS it just used a whole page.

What this would mean is memcg would have to work with fuzzy data.
If 1GB is charged and the compression ratio is 4:1, reclaim should
operate (by way of callback) like it has used 256MB.

I think this is the best you can do without tracking individual pages.

> 
> 2. The page will be incorrectly counted in
> zswap_stored_incompressible_pages.
> 

If we can track individual page size, then we can fix that.

If we can't, then we'd need zswap_stored_direct_pages and to do the
accounting a bit differently.  Probably want direct_pages accounting
anyway, so i might just add that.

> Aside from that, zswap_total_pages() will be wrong now, as it gets the
> pool size from zsmalloc and these pages are not allocated from zsmalloc.
> This is used when checking the pool limits and is exposed in stats.
>

This is ignorance of zswap on my part, and yeah good point.  Will look
into this accounting a little more.

> > +		memcpy_folio(folio, 0, zfolio, 0, PAGE_SIZE);
> 
> Why are we using memcpy_folio() here but copy_mc_highpage() on the
> compression path? Are they equivalent?
> 

both are in include/linux/highmem.h

I was avoiding page->folio conversions in the compression path because
I had a struct page already.

tl;dr: I'm still looking for the "right" way to do this.  I originally
had a "HACK:" tag here previously but seems I definitely dropped it
prematurely.

(I also think this code can be pushed into mt_ or callbacks)

> > +	if (entry->direct) {
> > +		struct page *freepage = (struct page *)entry->handle;
> > +
> > +		node_private_freed(freepage);
> > +		__free_page(freepage);
> > +	} else
> > +		zs_free(pool->zs_pool, entry->handle);
> 
> This code is repeated in zswap_entry_free(), we should probably wrap it
> in a helper that frees the private page or the zsmalloc entry based on
> entry->direct.
>

ack.

Thank you again for taking a look, this has been enlightening.  Good
takeaways for the rest of the N_PRIVATE design.

I think we can minimize zswap changes even further given this.

~Gregory

