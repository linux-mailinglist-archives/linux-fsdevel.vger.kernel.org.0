Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2867C6D2470
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Mar 2023 17:54:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232429AbjCaPyN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 31 Mar 2023 11:54:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231766AbjCaPyM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 31 Mar 2023 11:54:12 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2087.outbound.protection.outlook.com [40.107.102.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB3676E98;
        Fri, 31 Mar 2023 08:54:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VOoLZ0gBhuEd1qoZ30rxfTUVOViUH7ODHBHV64MA6FfBRrY1PhBjY4i1zlj+wPwSB8eDcSbfi+50oB8CnSAdKNZfPW/BhAQGCQsqo/4jkRrJfWlqmzxjcS7IsWAnJf/Y+LDQUzSV+g1c7TfULN+icKBPStz7yGyxra9TUbhswu5eOUdj79P95Ma58/h5ZP2sWJoeg4hdiI7r1sHcl6p9pAfrrZJ8PAcP0Nk1eHdfLrlPy5tM6pN6AfX2J9FlxA95jaHrWtqibdyvFC9rdNnNdOAfnEU/ruv4p4yWvoZ0KgiSqTM3GbeH1MzHLDxwrQJvErTY1IOJ+7rbJ8LlbY+3mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wJKcr0lNbXn4tFl/Fi7gofbQm0Rp9/pmrlx6WW+uDsw=;
 b=JhEpC0NdT1uIl+gsE0rv1zwaE1RhT+6qRpaJcbzTuwAGR4Llh/xIunz8adiANJdUb0LFri8BWq/wLOl9YoYVmzXdXNlgjV4VZ6vl0dsnxmyc65/fKMtTPtSXK6tSQo85D4v3r89aaYPUhgHSAxW3vmuNokaX+9Jbzsxjg+t5LyiDepRlo6A320llQnNms62Rf08aWHvzFAR08pgvcea3j0MrFNaFs1Znxi7XwW2bMgmosdMx4M+uR91Zv1Dbr70EfdUyYdCYHOrOW+CLs2Jros1KkgHuzDy1T1VTl27YohzxXh7+kXOUpSWoPMupjMeYM4r8fUcoA+QdvGhPvG/hgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=memverge.com; dmarc=pass action=none header.from=memverge.com;
 dkim=pass header.d=memverge.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=memverge.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wJKcr0lNbXn4tFl/Fi7gofbQm0Rp9/pmrlx6WW+uDsw=;
 b=JRNo2gADQDoQqBEjX8cd96SE7CuJt2uYBxTs3BAlCiCeCczwQxAbNy3Z1rjpcXentoQLGPh5puHEbsDckddDe6+SJbtRjWo7QvgKiso6WW5Q5Ug15Egrasm20/3/bCT0b0RKZbSGsKZ216qG8aby0/VB3v6cYdy8ItmRul+gA04=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=memverge.com;
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com (2603:10b6:a03:394::19)
 by SN7PR17MB6458.namprd17.prod.outlook.com (2603:10b6:806:353::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.22; Fri, 31 Mar
 2023 15:54:00 +0000
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::7b97:62c3:4602:b47a]) by SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::7b97:62c3:4602:b47a%5]) with mapi id 15.20.6254.024; Fri, 31 Mar 2023
 15:54:00 +0000
Date:   Fri, 31 Mar 2023 11:53:50 -0400
From:   Gregory Price <gregory.price@memverge.com>
To:     Kyungsan Kim <ks0204.kim@samsung.com>
Cc:     lsf-pc@lists.linux-foundation.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-cxl@vger.kernel.org,
        a.manzanares@samsung.com, viacheslav.dubeyko@bytedance.com,
        dan.j.williams@intel.com, seungjun.ha@samsung.com,
        wj28.lee@samsung.com
Subject: Re: RE: RE(4): FW: [LSF/MM/BPF TOPIC] SMDK inspired MM changes for
 CXL
Message-ID: <ZCcCDuotjUr7fPLN@memverge.com>
References: <ZB2pugK9Vu+nINSV@memverge.com>
 <CGME20230331113417epcas2p20a886e1712dbdb1f8eec03a2ac0a47e2@epcas2p2.samsung.com>
 <20230331113417.400072-1-ks0204.kim@samsung.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230331113417.400072-1-ks0204.kim@samsung.com>
X-ClientProxiedBy: SJ0PR05CA0052.namprd05.prod.outlook.com
 (2603:10b6:a03:33f::27) To SJ0PR17MB5512.namprd17.prod.outlook.com
 (2603:10b6:a03:394::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR17MB5512:EE_|SN7PR17MB6458:EE_
X-MS-Office365-Filtering-Correlation-Id: baf1ced5-908a-405a-ffc2-08db32002498
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Y1VtgXwgUASsdsLcjN1Z/ZbSY9waYVWTaUX667lEQfmks4G/OpoqVMrknVmR/cmiKup4lg+otSFAnSXcv5PuyZT6eQDqQkUX2Xez3znDV6RD7ciFF4uh/YSNQYnrIFmZ5SpjHpPZYUgTTXWnpTksIRqHLkBO/g9k8EvTk1RUTt+GDXWIuQAFa6k5hldUxWHNXeT4G4F18Y6059ddrtrGNvp2UMFPqKdQjlY9SgZ/8pElFFzeGzB7AMRuVIMjTj7ojS1uWGfLMV6ksCqECHA+FZOVpx8nH7WwJZ70cnMQqXFl//X5jj7ca3X1aQX+Tx5h/J7N46EcXRNPlcT1Wm7f0yShZrtJsY8LDU97aGcw0HtUX6JBhYGpl2lENWESBum8OMwXPwbHDAidNabuzpq2XZxPYpKRDEZ2LrXLbxfIC9iZ4jo+WgLWj0ZTgYsv0XFVU4AJj2UEhterHwWIEhUTSB6cuieojfNG6mASEPNF4OqLnvKJ3NuBPVcGm8fGMTs1nIcYVtvdcPIcevLRoZWm0hIjy/z6Un16s2KZqDV/mJT5kO5eDhHR1gjJudLYpxoM
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR17MB5512.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(346002)(39850400004)(396003)(136003)(376002)(451199021)(6486002)(2616005)(186003)(83380400001)(6512007)(316002)(26005)(478600001)(6506007)(6666004)(2906002)(7416002)(44832011)(66556008)(6916009)(8936002)(38100700002)(66476007)(41300700001)(66946007)(8676002)(4326008)(36756003)(86362001)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Y1WYwaWLCmX5wNXDVGZxJjlXZ9lOtEfpAOktDaEH3RwY6Lkj+5dqhA8TpRzt?=
 =?us-ascii?Q?ry5PcTs8HLXtOaPxCtQK1quyUFeUZIFo8i1hEw7nutk1Cz6cDjb2OcaHwX/f?=
 =?us-ascii?Q?b1bKFI1NFTv0acyInC/bApr3FPesKZKTTDYo3no4bNx9769R8H7U4RffZ/51?=
 =?us-ascii?Q?v1bW9kZIfranftBWHyuHCwzHM+K8ySdoxjilyBIQxdwvKoTaWBSRuBPZlztT?=
 =?us-ascii?Q?hpD3iYbdt+jKZBnPUSfD+fhr/LNNp/pOImuGVj8WnTV6yF8CnR/KC6mlSQXb?=
 =?us-ascii?Q?aKwRPvK2bXRsrsdkUtl3kpozNAbwBjf56h9Adv1qAsb9Rxu6ID9jzqj087GI?=
 =?us-ascii?Q?RGCGitAEj1xU62r6BfnAkSAk8AyFgzq1Sl3QY1JMW/Co3Utwkm1mK3P56I3t?=
 =?us-ascii?Q?c2oVAuA0499E321TJdMtDGGX2H6KNhBcpgszwjWlLp6wC/b/BWzwh3VSxUnJ?=
 =?us-ascii?Q?lvNoBx1P/AINRfMSEuNbGBBoNYQ9vSHTm1hoAY0YW+hBZNvfWH5sJfJsiSiU?=
 =?us-ascii?Q?f2Mnrz9CW+6XVJnM6UvKwb5ek3iGEJ4XwBhfOZJGamyUPfeI3hgcaMS/hthu?=
 =?us-ascii?Q?ovvLZ0YBGUpoDT2eaiP151zWik1I7QlsYdp7H0Y5t0hRd1TQ7DPoFYfB5aQX?=
 =?us-ascii?Q?d2zzFUv+5h0u4rDlx8vQeP9ZQyRTfeKqck2iqZ98fzjpzxUb1DyRk09/zeYC?=
 =?us-ascii?Q?5D+QuecGwVsKC4v8ISjokDk/4dQKx9F9YCBE7a+ePWHn2g5tlcjxb6BEt3H1?=
 =?us-ascii?Q?tJ387Lr5vY0830i2PS1URGzNubQH0Od0NZeeunTst/o/BHh63RP2pzETYQ0C?=
 =?us-ascii?Q?9hXX8q43x0pI0FI+aU3qfW4GXQ+Irv5Z35Fb+mLSbqodd75Gge4eOFgJO9U6?=
 =?us-ascii?Q?SfROmQYfndbG5z1bMcGQdpLzfFhHFPMZntLds132eizMuV9kMICrpHITINYt?=
 =?us-ascii?Q?whq+kOg8piZkfLuBTOcg667SGXFkxKPHzDg/leR+bMxQIhk5u4JXVJyrEm7N?=
 =?us-ascii?Q?pBnAltVZJmUbIiqDZrfmgSAKUbkTySlh0bfvNzvyWdw7f+0J4ESw5RjkU4cT?=
 =?us-ascii?Q?m/re3ZVizJgqnmmKwnwcve36hnE+LhxO8s6ZKvuWIPTUs6nmnAcd60OD8/pg?=
 =?us-ascii?Q?9ZCKKh79uWU9mwpS121JGLAZ9DKRfU5Dfne2MZViiykehEr7AarDcwjoemNo?=
 =?us-ascii?Q?yr8/aJM1SP7bBzNzPo4zzYKQ5wdXkj8aoN8YtgXYt9JKsPqc1QqYM7/JE7Bn?=
 =?us-ascii?Q?fEtmncBj6Jc8T6IS0aos5GGG4Iixzub2AL0NH3fhEFhUYBx35lUCGZZU4qSG?=
 =?us-ascii?Q?zpo5fALbVWGOIfydnchH1BPkaRai9+CI6iK0kyG1ppTOGjejflcXzf4rZk1C?=
 =?us-ascii?Q?/HZ58S1pnDU9FO1o680Y66wX1z+rIrU/TNlocwRtnUI6kJh29/7Od7e9KHIE?=
 =?us-ascii?Q?GUn0ZxmKdTOWsu/XgFp3ToDM5Id4U8qD3C+MiBXmtagHfTNpBzoBCYllZY+i?=
 =?us-ascii?Q?Msuo3L2hUNLyTkdl8cHHir2wlg768Of8XQ3KBoI6kynlcAndQGnjuXm5oCub?=
 =?us-ascii?Q?4W1MHc7qQPiPI6xV4APXB5l2E0BdB3iHLc7Lb7zusSp8KfXMNeS64QQRjZCm?=
 =?us-ascii?Q?Vg=3D=3D?=
X-OriginatorOrg: memverge.com
X-MS-Exchange-CrossTenant-Network-Message-Id: baf1ced5-908a-405a-ffc2-08db32002498
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR17MB5512.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2023 15:54:00.1976
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5c90cb59-37e7-4c81-9c07-00473d5fb682
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MntYyM3vbj0JkcUpQhEUKVQsOaIz+Epf8MmLQx0hoWeEOu9tvYxgxzyHirwrh6YGg3IOOSZTIKS4YEJioWB5RGL44/TjomYkui5zOod/WG0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR17MB6458
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Mar 31, 2023 at 08:34:17PM +0900, Kyungsan Kim wrote:
> Hi Gregory Price. 
> Thank you for joining this topic and share your viewpoint.
> I'm sorry for late reply due to some major tasks of our team this week.
> 
> >On Fri, Mar 24, 2023 at 05:48:08PM +0900, Kyungsan Kim wrote:
> >> 
> >> Indeed, we tried the approach. It was able to allocate a kernel context from ZONE_MOVABLE using GFP_MOVABLE.
> >> However, we think it would be a bad practice for the 2 reasons.
> >> 1. It causes oops and system hang occasionally due to kernel page migration while swap or compaction. 
> >> 2. Literally, the design intention of ZONE_MOVABLE is to a page movable. So, we thought allocating a kernel context from the zone hurts the intention.
> >> 
> >> Allocating a kernel context out of ZONE_EXMEM is unmovable.
> >>   a kernel context -  alloc_pages(GFP_EXMEM,)
> >
> >What is the specific use case of this?  If the answer is flexibility in
> >low-memory situations, why wouldn't the kernel simply change to free up
> >ZONE_NORMAL (swapping user memory, migrating user memory, etc) and
> >allocate as needed?
> >
> >I could see allocating kernel memory from local memory expanders
> >(directly attached to local CXL port), but I can't think of a case where
> >it would be preferable for kernel resources to live on remote memory.
> 
> We have thought kernelspace memory tiering cases.
> What memory tiering we assumes is to locate a hot data in fast memory and a cold data in slow memory.
> We think zswap, pagecache, and Meta TPP(page promotion/demotion among nodes) as the kernelspace memory tiering cases.
>

So, to clarify, when you say "kernel space memory tiering cases", do you
mean "to support a kernel-space controlled memory tiering service" or do
you mean "tiering of kernel memory"?

Because if it's the former, rather than a new zone, it seems like a
better proposal would be to extend the numa system to add additional
"cost/feature" attributes, rather than modifying the zone of the memory
blocks backing the node.

Note that memory zones can apply to individual blocks within a node, and
not the entire node uniformly.  So when making tiering decisions, it
seems more expedient to investigate a node rather than a block.


> >Since local memory expanders are static devices, there shouldn't be a
> >great need for hotplug, which means the memory could be mapped
> >ZONE_NORMAL without issue.
> >
> 
> IMHO, we think hot-add/remove is one of the key feature of CXL due to the composability aspect.
> Right now, CXL device and system connection is limited. 
> But industry is preparing a CXL capable system that allows more than 10 CXL channels at backplane, pluggable with EDSFF. 
> Not only that, along with the progress of CXL topology - from direct-attached to switch, multi-level switch, and fabric connection -
> I think the hot-add/remove usecase would become more important.
> 
> 

Hot add/remove is somewhat fairly represented by ZONE_MOVABLE. What's I
think confusing many people is that creating a new zone that's intended
to be hot-pluggable *and* usable by kernel for kernel-resources/memory
are presently exclusive operations.

The underlying question is what situation is being hit in which kernel
memory wants to be located in ZONE_MOVABLE/ZONE_EXMEM that cannot simply
be serviced by demoting other, movable memory to these regions.

The concept being that kernel allocations are a higher-priority
allocation than userland, and as such should have priority in DRAM.

For example - there is at least one paper that examined the cost of
placing page tables on CXL Memory Expansion (on the local CXL complex,
not remote) and found the cost is significant.  Page tables are likely
the single largest allocation the kernel will make to service large
memory structures, so the answer to this problem is not necessarily to
place that memory in CXL as well, but to use larger page sizes (which is
less wasteful as memory usage is high and memory is abundant).

I just don't understand what kernel resources would meet the following
attributes:

1) Do not have major system performance impacts in high-latency memory
2) Are sufficiently large to warrant tiering
and
3) Are capable of being moved (i.e. no pinned areas, no dma areas, etc)

> >> Allocating a user context out of ZONE_EXMEM is movable.
> >>   a user context - mmap(,,MAP_EXMEM,) - syscall - alloc_pages(GFP_EXMEM | GFP_MOVABLE,)
> >> This is how ZONE_EXMEM supports the two cases.
> >> 

So if MAP_EXMEM is not used, EXMEM would not be used?

That seems counter intuitive.  If an allocation via mmap would be
eligible for ZONE_MOVABLE, why wouldn't it be eligible for ZONE_EXMEM?

I believe this is another reason why some folks are confused what the
distinction between MOVABLE and EXMEM are.  They seem to ultimately
reduce to whether the memory can be moved.

> >
> >Is it intended for a user to explicitly request MAP_EXMEM for it to get
> >used at all?  As in, if i simply mmap() without MAP_EXMEM, will it
> >remain unutilized?
> 
> Our intention is to allow below 3 cases
> 1. Explicit DDR allocation - mmap(,,MAP_NORMAL,)
>  : allocation from ZONE_NORMAL or ZONE_MOVABLE, or allocation fails.
> 2. Explicit CXL allocation - mmap(,,MAP_EXMEM,)
>  : allocation from ZONE_EXMEM, of allocation fails.
> 3. Implicit Memory allocation - mmap(,,,) 
>  : allocation from ZONE_NORMAL, ZONE_MOVABLE, or ZONE_EXMEM. In other words, no matter where DDR or CXL DRAM.
> 
> Among that, 3 is similar with vanilla kernel operation in that the allocation request traverses among multiple zones or nodes.
> We think it would be good or bad for the mmap caller point of view.
> It is good because memory is allocated, while it could be bad because the caller does not have idea of allocated memory type.
> The later would hurt QoS metrics or userspace memory tiering operation, which expects near/far memory.
> 

For what it's worth, mmap is not the correct api for userland to provide
kernel hints on data placement.  That would be madvise and friends.

But further, allocation of memory from userland must be ok with having
its memory moved/swapped/whatever unless additional assistance from the
kernel is provided (page pinning, mlock, whatever) to ensure it will
not be moved.  Presumably this is done to ensure the kernel can make
runtime adjustments to protect itself from being denied memory and
causing instability and/or full system faults.


I think you need to clarify your intents for this zone, in particular
your intent for exactly what data can and cannot live in this zone and
the reasons for this.  "To assist kernel tiering operations" is very
vague and not a description of what memory is and is not allowed in the
zone.

~Gregory
