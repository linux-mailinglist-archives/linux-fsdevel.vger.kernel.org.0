Return-Path: <linux-fsdevel+bounces-1126-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2641B7D6046
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Oct 2023 05:10:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D80E6281C55
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Oct 2023 03:10:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9313B1FD0;
	Wed, 25 Oct 2023 03:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="A6XRhLbq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8076B17C6;
	Wed, 25 Oct 2023 03:10:16 +0000 (UTC)
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BEEF130;
	Tue, 24 Oct 2023 20:10:10 -0700 (PDT)
Received: from epcas2p4.samsung.com (unknown [182.195.41.56])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20231025031006epoutp02b38c159fd5af1c70e3bad80da0e9eb31~ROwArRlwP0962609626epoutp025;
	Wed, 25 Oct 2023 03:10:06 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20231025031006epoutp02b38c159fd5af1c70e3bad80da0e9eb31~ROwArRlwP0962609626epoutp025
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1698203406;
	bh=061GBfB3P9i/mD/gOuTh2X8nxbFYgXRoYHXGupcYxu0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=A6XRhLbq309ISyXwoXIxqgLAl/ervYalJ+U/9yAjLQwSvoFiinDeUJJVqnZt/xmfj
	 k6VSlvJt9kVmPsEQ4RP8QZZrwplK6vrbBHKi4EQHO2uJM7C9zxIPSp8QBAXqz8st6d
	 l4hEAlIyJsmUsR6Y77bU3r/G2vdj3slAJysCI414=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
	epcas2p3.samsung.com (KnoxPortal) with ESMTP id
	20231025031006epcas2p32b09471689fbab53a7f6554760764f44~ROwAbd5TV2253822538epcas2p3I;
	Wed, 25 Oct 2023 03:10:06 +0000 (GMT)
Received: from epsmgec2p1-new.samsung.com (unknown [182.195.36.98]) by
	epsnrtp1.localdomain (Postfix) with ESMTP id 4SFYnn46PBz4x9Pr; Wed, 25 Oct
	2023 03:10:05 +0000 (GMT)
Received: from epcas2p3.samsung.com ( [182.195.41.55]) by
	epsmgec2p1-new.samsung.com (Symantec Messaging Gateway) with SMTP id
	81.F1.18994.D0788356; Wed, 25 Oct 2023 12:10:05 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas2p4.samsung.com (KnoxPortal) with ESMTPA id
	20231025031004epcas2p485a0b7a9247bc61d54064d7f7bdd1e89~ROv-OFo5L2998429984epcas2p48;
	Wed, 25 Oct 2023 03:10:04 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20231025031004epsmtrp1dc484ac716100694aa3aef0842be1055~ROv-LX8vm0396003960epsmtrp1V;
	Wed, 25 Oct 2023 03:10:04 +0000 (GMT)
X-AuditID: b6c32a4d-743ff70000004a32-79-6538870da163
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	48.25.08755.C0788356; Wed, 25 Oct 2023 12:10:04 +0900 (KST)
Received: from tiffany (unknown [10.229.95.142]) by epsmtip1.samsung.com
	(KnoxPortal) with ESMTPA id
	20231025031004epsmtip13d2bb4576f2c565f2e66681d12912bd7~ROv_3LYkz0841108411epsmtip1U;
	Wed, 25 Oct 2023 03:10:04 +0000 (GMT)
Date: Wed, 25 Oct 2023 11:59:32 +0900
From: Hyesoo Yu <hyesoo.yu@samsung.com>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: David Hildenbrand <david@redhat.com>, Alexandru Elisei
	<alexandru.elisei@arm.com>, will@kernel.org, oliver.upton@linux.dev,
	maz@kernel.org, james.morse@arm.com, suzuki.poulose@arm.com,
	yuzenghui@huawei.com, arnd@arndb.de, akpm@linux-foundation.org,
	mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com, rostedt@goodmis.org,
	bsegall@google.com, mgorman@suse.de, bristot@redhat.com,
	vschneid@redhat.com, mhiramat@kernel.org, rppt@kernel.org, hughd@google.com,
	pcc@google.com, steven.price@arm.com, anshuman.khandual@arm.com,
	vincenzo.frascino@arm.com, eugenis@google.com, kcc@google.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	kvmarm@lists.linux.dev, linux-fsdevel@vger.kernel.org,
	linux-arch@vger.kernel.org, linux-mm@kvack.org,
	linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH RFC 00/37] Add support for arm64 MTE dynamic tag storage
 reuse
Message-ID: <20231025025932.GA3953138@tiffany>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <ZQHVVdlN9QQztc7Q@arm.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA02Te1BUVRzHOXvv3rswLXMFqcNSBFeUIBdYYOEY0pihXQdqKNQZbBpY4Q6v
	ZXfdXcT0j7B4GgLxiGCAcJBnJAygFALKS8CECgIHeWjhQrwFRQOEWnbXxv8+v+/5fX/n/H6/
	OTzMbJgU8CJkalYpk0hpwgS/1uHgKeQnIdZlq02ACmqqCZRbOUig1p4QtJl5i0QDk0NaaeY8
	jpbKUgFarVnHkCbjKobaihdxpFlJw9H91nIOGk/PwVHj1AIHzTZ04Ci5aRVHdZPDXNTc0ouj
	waYCAk1U/8tFnTV9OPq5oJeLshanACop34MGbhZzUM7aPIHSx+4SqPviTQ5qTX7A0eY2ctD5
	ziUC5Y2OApTc+RRDLVtrOLra9YxE8WNiNFJaSx7YzVQXVQNmYz0TMPGt90imuC6Gie9c4DL1
	FY5MXVUKwdStZJLM2HAzwfR8t4Ezl+JyMKb+8hfM3/V5gFlqHSKY+l/OMY/rrP2pE1H7w1lJ
	KKu0YWUh8tAIWZg37RsQ9H6Q2MNFJBTtQ560jUwSzXrTPn7+wsMRUu0waZvTEmmMVvKXqFS0
	87v7lfIYNWsTLlepvWlWESpVeCqcVJJoVYwszEnGqt8Rubi4irWJwVHhbY8qgSLrwJmt/Aws
	Dky6XgDGPEi5w/mvLnMuABOeGdUM4HreNNAHKwAOl6fg+uApgOXT8cQLS2Nqr+GgBcCF0kFD
	oAGwv2VOG/B4OLUbVvR9tG0gKHvY01AGtnknJYS/JWbr8jHqCQHHfxjSVTWnjsKxZ9teYx6f
	coKakUID74C9eQ91bKwttHh7Rvc+SKWZwNrGbqB/kg8cXe7B9GwOZ7sbSD0L4Ex6ooGj4Phy
	hqEFNbxyJ86gu8H8qSRdHYwKh5eGKrDtBiC1C3bew/WyKUzu2CT1Mh8mJ5rpnbvgjbIiXM+W
	8K8fk7h6ZuDDsVTDTOYx2FKURWYA6/yX2sl/6TY974XF11eIfO0VGGUFy7d4enSANU3OxYBb
	BQSsQhUdxoa4KkRCGRv7/5ZD5NF1QPfBHD/8CczVbDq1Aw4PtAPIw+id/EA/xJrxQyWfn2WV
	8iBljJRVtQOxdj/fYAKLELn2h8rUQSL3fS7uHh4iT1exiyf9Gn8ioTDUjAqTqNkollWwyhc+
	Ds9YEMfh0kluXx7yKLXwmqKqA17N+eT3EnZpLlcc5NxxxLLK7m4J96DoQkMiHfn24X/+rGh/
	HnjD3yLXhztxyud0rfp747eIV0KtV7dMT4615n+wZPr1xbQttIGt9vaLI89Mpd3qDXpTan8i
	fC3h3G3U/9nxLqtIJeePVKmV0dnh44mxC77BsUbH/Pqm76sHMhrdCoW1TRp0aHbB95p5WGx2
	y+tWGlFwiq3RBPr4yBsPvASn7BKJO7YnK7pI2z120b8uRo5U5jTHcI2DZVWkxadNccumdnbP
	U9dLvn1cyemyr626UhC9rkl4z+4o3WGRTe5l80h2xMHp2KOAjECHVUuv60/sd1RF0bgqXCJy
	xJQqyX8Uz4qA6QQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sf0wTdxjG/d5d764NjBuSecpgWTN/0MwKy9je/XDRZUtuzhGXkAW3JdjA
	BRAotRVFSDbI6sYPoVipQMOwzg0UO3EFrEVsBCqlmyRIQ9dqRQmUUIWCMnQidqPgMv978jyf
	533+eWk8sk6wjs6S7+eVclmOmBQRF3rFsZvDfgA+vqI1DhpajSTUnnGSYO1Pg6faPgqGxoaX
	LH8JATNNRxDMty7g4KvuwKHbECDA96CKgNvWZgxuaXQEmCemMbjb3ktAaec8AaYxlwC6LjsI
	cHY2kDBi/EcAttYBAiwNDgEcC0wgONW8AYauGDDQPZ4iQeP9kwR75RUMrKV3sCXWjEGJbYaE
	+ps3EZTaHuJwOfiYgI6rjyhQexPB88t5att6zthoRNyTBS3i1NYbFGcw5XNq27SAazst4Uwt
	ZSRneqClOK+ri+T6654Q3MliHc61/fwtN9lWj7gZ6zDJtf1RxM2ZYncxX4reT+dzsg7wyi0f
	7BFlHr/fTiicWwvOjwewYtQVX46ENMu8yZqPOIhyJKIjmUuI9V+qxVaCtax+zvFMr2Zvq22C
	FWgMsb6pDrIc0TTBrGdPDySFGJLZyPa3N6GQjmI2s4Pf1ywfxZmHJGu/dZYKBauZZNb76B4R
	0uGMlPV5fny2bMDZQWs3WgleZB3148sQzkhYd9CPhcZwJpptDtIhW7g0Fvjdj6oRo3+uoX+u
	of+/YUB4C1rLK1S5GbmqBEWCnD8oVclyVfnyDGlaXq4JLT+PJO4iMrfMSnsQRqMexNK4OCp8
	907gI8PTZYcKeWVeqjI/h1f1oGiaEK8JXzNZmR7JZMj289k8r+CV/6UYLVxXjCXZPkzIPLR4
	96j+qmW7riTH67kwaheOfvr1vqBmUcGmHI6ZjqAr5AF/VeOxs8kVJ04Igt1K58up5ybd5z7+
	TmMf78v/NZCHBj85PL9q5PMzNt/xTUU/WeqTVnGeuIm/s9BuT2eM5KLUkOjeod3b/3pftnph
	1rn47vawpveGEjWbKBf+wkdl068UQkenzXF0S/K9t64PiOeufWMZc9Fllqg0u/tA7xfW5oV3
	essKuH2u6L06Z8tXbzzd0HQjdXhP5cmaUfmrQ9yd32o/owoEOwqVSW8XOabCamKvG/Ftorqd
	pq1/aasiUkoiUhrj88ykUH5/40vZszWjVObIwWuvxbira8WEKlOWIMGVKtm/7PhHN6sDAAA=
X-CMS-MailID: 20231025031004epcas2p485a0b7a9247bc61d54064d7f7bdd1e89
X-Msg-Generator: CA
Content-Type: multipart/mixed;
	boundary="-----O4JN58fMyNpah7pQKdLET.c7fax0r10d8J.dTh_o3pAlz-8=_691b3_"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20231025031004epcas2p485a0b7a9247bc61d54064d7f7bdd1e89
References: <20230823131350.114942-1-alexandru.elisei@arm.com>
	<33def4fe-fdb8-6388-1151-fabd2adc8220@redhat.com> <ZOc0fehF02MohuWr@arm.com>
	<ebd3f142-43cc-dc92-7512-8f1c99073fce@redhat.com>
	<0b9c122a-c05a-b3df-c69f-85f520294adc@redhat.com> <ZOd2LvUKMguWdlgq@arm.com>
	<ZPhfNVWXhabqnknK@monolith> <ZP7/e8YFiosElvTm@arm.com>
	<0cc8a118-2522-f666-5bcc-af06263fd352@redhat.com> <ZQHVVdlN9QQztc7Q@arm.com>
	<CGME20231025031004epcas2p485a0b7a9247bc61d54064d7f7bdd1e89@epcas2p4.samsung.com>

-------O4JN58fMyNpah7pQKdLET.c7fax0r10d8J.dTh_o3pAlz-8=_691b3_
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline

On Wed, Sep 13, 2023 at 04:29:25PM +0100, Catalin Marinas wrote:
> On Mon, Sep 11, 2023 at 02:29:03PM +0200, David Hildenbrand wrote:
> > On 11.09.23 13:52, Catalin Marinas wrote:
> > > On Wed, Sep 06, 2023 at 12:23:21PM +0100, Alexandru Elisei wrote:
> > > > On Thu, Aug 24, 2023 at 04:24:30PM +0100, Catalin Marinas wrote:
> > > > > On Thu, Aug 24, 2023 at 01:25:41PM +0200, David Hildenbrand wrote:
> > > > > > On 24.08.23 13:06, David Hildenbrand wrote:
> > > > > > > Regarding one complication: "The kernel needs to know where to allocate
> > > > > > > a PROT_MTE page from or migrate a current page if it becomes PROT_MTE
> > > > > > > (mprotect()) and the range it is in does not support tagging.",
> > > > > > > simplified handling would be if it's in a MIGRATE_CMA pageblock, it
> > > > > > > doesn't support tagging. You have to migrate to a !CMA page (for
> > > > > > > example, not specifying GFP_MOVABLE as a quick way to achieve that).
> > > > > > 
> > > > > > Okay, I now realize that this patch set effectively duplicates some CMA
> > > > > > behavior using a new migrate-type.
> > > [...]
> > > > I considered mixing the tag storage memory memory with normal memory and
> > > > adding it to MIGRATE_CMA. But since tag storage memory cannot be tagged,
> > > > this means that it's not enough anymore to have a __GFP_MOVABLE allocation
> > > > request to use MIGRATE_CMA.
> > > > 
> > > > I considered two solutions to this problem:
> > > > 
> > > > 1. Only allocate from MIGRATE_CMA is the requested memory is not tagged =>
> > > > this effectively means transforming all memory from MIGRATE_CMA into the
> > > > MIGRATE_METADATA migratetype that the series introduces. Not very
> > > > appealing, because that means treating normal memory that is also on the
> > > > MIGRATE_CMA lists as tagged memory.
> > > 
> > > That's indeed not ideal. We could try this if it makes the patches
> > > significantly simpler, though I'm not so sure.
> > > 
> > > Allocating metadata is the easier part as we know the correspondence
> > > from the tagged pages (32 PROT_MTE page) to the metadata page (1 tag
> > > storage page), so alloc_contig_range() does this for us. Just adding it
> > > to the CMA range is sufficient.
> > > 
> > > However, making sure that we don't allocate PROT_MTE pages from the
> > > metadata range is what led us to another migrate type. I guess we could
> > > achieve something similar with a new zone or a CPU-less NUMA node,
> > 
> > Ideally, no significant core-mm changes to optimize for an architecture
> > oddity. That implies, no new zones and no new migratetypes -- unless it is
> > unavoidable and you are confident that you can convince core-MM people that
> > the use case (giving back 3% of system RAM at max in some setups) is worth
> > the trouble.
> 
> If I was an mm maintainer, I'd also question this ;). But vendors seem
> pretty picky about the amount of RAM reserved for MTE (e.g. 0.5G for a
> 16G platform does look somewhat big). As more and more apps adopt MTE,
> the wastage would be smaller but the first step is getting vendors to
> enable it.
> 
> > I also had CPU-less NUMA nodes in mind when thinking about that, but not
> > sure how easy it would be to integrate it. If the tag memory has actually
> > different performance characteristics as well, a NUMA node would be the
> > right choice.
> 
> In general I'd expect the same characteristics. However, changing the
> memory designation from tag to data (and vice-versa) requires some cache
> maintenance. The allocation cost is slightly higher (not the runtime
> one), so it would help if the page allocator does not favour this range.
> Anyway, that's an optimisation to worry about later.
> 
> > If we could find some way to easily support this either via CMA or CPU-less
> > NUMA nodes, that would be much preferable; even if we cannot cover each and
> > every future use case right now. I expect some issues with CXL+MTE either
> > way , but are happy to be taught otherwise :)
> 
> I think CXL+MTE is rather theoretical at the moment. Given that PCIe
> doesn't have any notion of MTE, more likely there would be some piece of
> interconnect that generates two memory accesses: one for data and the
> other for tags at a configurable offset (which may or may not be in the
> same CXL range).
> 
> > Another thought I had was adding something like CMA memory characteristics.
> > Like, asking if a given CMA area/page supports tagging (i.e., flag for the
> > CMA area set?)?
> 
> I don't think adding CMA memory characteristics helps much. The metadata
> allocation wouldn't go through cma_alloc() but rather
> alloc_contig_range() directly for a specific pfn corresponding to the
> data pages with PROT_MTE. The core mm code doesn't need to know about
> the tag storage layout.
> 
> It's also unlikely for cma_alloc() memory to be mapped as PROT_MTE.
> That's typically coming from device drivers (DMA API) with their own
> mmap() implementation that doesn't normally set VM_MTE_ALLOWED (and
> therefore PROT_MTE is rejected).
> 
> What we need though is to prevent vma_alloc_folio() from allocating from
> a MIGRATE_CMA list if PROT_MTE (VM_MTE). I guess that's basically
> removing __GFP_MOVABLE in those cases. As long as we don't have large
> ZONE_MOVABLE areas, it shouldn't be an issue.
> 

How about unsetting ALLOC_CMA if GFP_TAGGED ?
Removing __GFP_MOVABLE may cause movable pages to be allocated in un
unmovable migratetype, which may not be desirable for page fragmentation.

> > When you need memory that supports tagging and have a page that does not
> > support tagging (CMA && taggable), simply migrate to !MOVABLE memory
> > (eventually we could also try adding !CMA).
> > 
> > Was that discussed and what would be the challenges with that? Page
> > migration due to compaction comes to mind, but it might also be easy to
> > handle if we can just avoid CMA memory for that.
> 
> IIRC that was because PROT_MTE pages would have to come only from
> !MOVABLE ranges. Maybe that's not such big deal.
> 

Could you explain what it means that PROT_MTE have to come only from
!MOVABLE range ? I don't understand this part very well.

Thanks,
Hyesoo.

> We'll give this a go and hopefully it simplifies the patches a bit (it
> will take a while as Alex keeps going on holiday ;)). In the meantime,
> I'm talking to the hardware people to see whether we can have MTE pages
> in the tag storage/metadata range. We'd still need to reserve about 0.1%
> of the RAM for the metadata corresponding to the tag storage range when
> used as data but that's negligible (1/32 of 1/32). So if some future
> hardware allows this, we can drop the page allocation restriction from
> the CMA range.
> 
> > > though the latter is not guaranteed not to allocate memory from the
> > > range, only make it less likely. Both these options are less flexible in
> > > terms of size/alignment/placement.
> > > 
> > > Maybe as a quick hack - only allow PROT_MTE from ZONE_NORMAL and
> > > configure the metadata range in ZONE_MOVABLE but at some point I'd
> > > expect some CXL-attached memory to support MTE with additional carveout
> > > reserved.
> > 
> > I have no idea how we could possibly cleanly support memory hotplug in
> > virtual environments (virtual DIMMs, virtio-mem) with MTE. In contrast to
> > s390x storage keys, the approach that arm64 with MTE took here (exposing tag
> > memory to the VM) makes it rather hard and complicated.
> 
> The current thinking is that the VM is not aware of the tag storage,
> that's entirely managed by the host. The host would treat the guest
> memory similarly to the PROT_MTE user allocations, reserve metadata etc.
> 
> Thanks for the feedback so far, very useful.
> 
> -- 
> Catalin
> 

-------O4JN58fMyNpah7pQKdLET.c7fax0r10d8J.dTh_o3pAlz-8=_691b3_
Content-Type: text/plain; charset="utf-8"


-------O4JN58fMyNpah7pQKdLET.c7fax0r10d8J.dTh_o3pAlz-8=_691b3_--

