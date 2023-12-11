Return-Path: <linux-fsdevel+bounces-5496-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5839580CE3E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Dec 2023 15:21:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 891DA1C21263
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Dec 2023 14:21:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20198487BC;
	Mon, 11 Dec 2023 14:21:53 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 366931BF6;
	Mon, 11 Dec 2023 06:21:45 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2C2ECFEC;
	Mon, 11 Dec 2023 06:22:31 -0800 (PST)
Received: from raptor (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 613B73F738;
	Mon, 11 Dec 2023 06:21:39 -0800 (PST)
Date: Mon, 11 Dec 2023 14:21:36 +0000
From: Alexandru Elisei <alexandru.elisei@arm.com>
To: Hyesoo Yu <hyesoo.yu@samsung.com>
Cc: catalin.marinas@arm.com, will@kernel.org, oliver.upton@linux.dev,
	maz@kernel.org, james.morse@arm.com, suzuki.poulose@arm.com,
	yuzenghui@huawei.com, arnd@arndb.de, akpm@linux-foundation.org,
	mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
	bristot@redhat.com, vschneid@redhat.com, mhiramat@kernel.org,
	rppt@kernel.org, hughd@google.com, pcc@google.com,
	steven.price@arm.com, anshuman.khandual@arm.com,
	vincenzo.frascino@arm.com, david@redhat.com, eugenis@google.com,
	kcc@google.com, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, kvmarm@lists.linux.dev,
	linux-fsdevel@vger.kernel.org, linux-arch@vger.kernel.org,
	linux-mm@kvack.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH RFC v2 15/27] arm64: mte: Check that tag storage blocks
 are in the same zone
Message-ID: <ZXca8B6a3HPRrdNP@raptor>
References: <20231119165721.9849-1-alexandru.elisei@arm.com>
 <CGME20231119165900epcas2p3efd0f3ac19b7bcf7883e8d3945e63326@epcas2p3.samsung.com>
 <20231119165721.9849-16-alexandru.elisei@arm.com>
 <20231129085744.GB2988384@tiffany>
 <ZWh5S9BoO5bG5nQM@raptor>
 <20231208052739.GB1359878@tiffany>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231208052739.GB1359878@tiffany>

Hi,

On Fri, Dec 08, 2023 at 02:27:39PM +0900, Hyesoo Yu wrote:
> Hi~
> 
> On Thu, Nov 30, 2023 at 12:00:11PM +0000, Alexandru Elisei wrote:
> > Hi,
> > 
> > On Wed, Nov 29, 2023 at 05:57:44PM +0900, Hyesoo Yu wrote:
> > > On Sun, Nov 19, 2023 at 04:57:09PM +0000, Alexandru Elisei wrote:
> > > > alloc_contig_range() requires that the requested pages are in the same
> > > > zone. Check that this is indeed the case before initializing the tag
> > > > storage blocks.
> > > > 
> > > > Signed-off-by: Alexandru Elisei <alexandru.elisei@arm.com>
> > > > ---
> > > >  arch/arm64/kernel/mte_tag_storage.c | 33 +++++++++++++++++++++++++++++
> > > >  1 file changed, 33 insertions(+)
> > > > 
> > > > diff --git a/arch/arm64/kernel/mte_tag_storage.c b/arch/arm64/kernel/mte_tag_storage.c
> > > > index 8b9bedf7575d..fd63430d4dc0 100644
> > > > --- a/arch/arm64/kernel/mte_tag_storage.c
> > > > +++ b/arch/arm64/kernel/mte_tag_storage.c
> > > > @@ -265,6 +265,35 @@ void __init mte_tag_storage_init(void)
> > > >  	}
> > > >  }
> > > >  
> > > > +/* alloc_contig_range() requires all pages to be in the same zone. */
> > > > +static int __init mte_tag_storage_check_zone(void)
> > > > +{
> > > > +	struct range *tag_range;
> > > > +	struct zone *zone;
> > > > +	unsigned long pfn;
> > > > +	u32 block_size;
> > > > +	int i, j;
> > > > +
> > > > +	for (i = 0; i < num_tag_regions; i++) {
> > > > +		block_size = tag_regions[i].block_size;
> > > > +		if (block_size == 1)
> > > > +			continue;
> > > > +
> > > > +		tag_range = &tag_regions[i].tag_range;
> > > > +		for (pfn = tag_range->start; pfn <= tag_range->end; pfn += block_size) {
> > > > +			zone = page_zone(pfn_to_page(pfn));
> > > 
> > > Hello.
> > > 
> > > Since the blocks within the tag_range must all be in the same zone, can we move the "page_zone"
> > > out of the loop ?
> > `
> > Hmm.. why do you say that the pages in a tag_range must be in the same
> > zone? I am not very familiar with how the memory management code puts pages
> > into zones, but I would imagine that pages in a tag range straddling the
> > 4GB limit (so, let's say, from 3GB to 5GB) will end up in both ZONE_DMA and
> > ZONE_NORMAL.
> > 
> > Thanks,
> > Alex
> > 
> 
> Oh, I see that reserve_tag_storage only calls alloc_contig_rnage in units of block_size,
> I thought it could be called for the entire range the page needed at once.
> (Maybe it could be a bit faster ? It doesn't seem like unnecessary drain and
> other operation are repeated.)

Yes, that might be useful to do. Worth keeping in mind is that:

- a number of block size pages at the start and end of the range might
  already be reserved for other tagged pages, so the actual range that is
  being reserved might end up being smaller that what we are expecting.

- the most common allocation order is smaller or equal to
  PAGE_ALLOC_COSTLY_ORDER, which is 3, which means that the most common
  case is that reserve_tag_storage reserves only one tag storage block.

I will definitely keep this optimization in mind, but I would prefer to get
the series into a more stable shape before looking at performance
optimizations.

> 
> If we use the cma code when activating the tag storage, it will be error if the
> entire area of tag region is not in the same zone, so there should be a constraint
> that it must be in the same zone when defining the tag region on device tree.

I don't think that's the best approach, because the device tree describes
the hardware, which does not change, and this is a software limitation
(i.e, CMA doesn't work if a CMA region spans different zones), which might
get fixed in a future version of Linux.

In my opinion, the simplest solution would be to check that all tag storage
regions have been activated successfully by CMA before enabling tag
storage. Another alternative would be to split the tag storage region into
several CMA regions at a zone boundary, and add it as distinct CMA regions.

Thanks,
Alex

> 
> Thanks,
> Regards.
> 
> > > 
> > > Thanks,
> > > Regards.
> > > 
> > > > +			for (j = 1; j < block_size; j++) {
> > > > +				if (page_zone(pfn_to_page(pfn + j)) != zone) {
> > > > +					pr_err("Tag storage block pages in different zones");
> > > > +					return -EINVAL;
> > > > +				}
> > > > +			}
> > > > +		}
> > > > +	}
> > > > +
> > > > +	 return 0;
> > > > +}
> > > > +
> > > >  static int __init mte_tag_storage_activate_regions(void)
> > > >  {
> > > >  	phys_addr_t dram_start, dram_end;
> > > > @@ -321,6 +350,10 @@ static int __init mte_tag_storage_activate_regions(void)
> > > >  		goto out_disabled;
> > > >  	}
> > > >  
> > > > +	ret = mte_tag_storage_check_zone();
> > > > +	if (ret)
> > > > +		goto out_disabled;
> > > > +
> > > >  	for (i = 0; i < num_tag_regions; i++) {
> > > >  		tag_range = &tag_regions[i].tag_range;
> > > >  		for (pfn = tag_range->start; pfn <= tag_range->end; pfn += pageblock_nr_pages)
> > > > -- 
> > > > 2.42.1
> > > > 
> > > > 
> > 
> > 
> > 



