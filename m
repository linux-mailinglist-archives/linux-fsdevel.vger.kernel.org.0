Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE3453FEFEA
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Sep 2021 17:13:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345725AbhIBPOZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 2 Sep 2021 11:14:25 -0400
Received: from mail-bn8nam12on2057.outbound.protection.outlook.com ([40.107.237.57]:13793
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229941AbhIBPOY (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 2 Sep 2021 11:14:24 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h6F1UExVo/wGE6lv8H65SNd2VZuwOwWVKQla8KaDyBgSw9G8unTdnI/DcVjKt4holZaA4vBohLNx7KyG3flLJdN2LzuCIhSAecat5wO31OWX/oBV8DKQpUYLZrYCSnSfTYY95tDMSKnM4d7lHjvJeSx0sZtCN9PCC/cMDcr0B+8YBDikMmC2BZXWwwB6bvDG+Dv+rqsF9TuUh40oUwQyC+aJ5ZCBy0fl4b72eLCx+JP1CmG6aSLwbe4rQW9XvuDuY9hhNKWNixqfk9j/e1Po6gtL5deWAXO8Up6j8+ctooj48P0/WWdOKhvA535GPaUQjVMEFMVDAtUXyVENzdz36Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=bpWiIlux74+R+Bgl17ru4GyBcQ5aRhvR+GusSwNvai0=;
 b=ktILo7Bp37d7FEGm+lQdGv/TkCm1DlhDAKqPXbXWx0Tg9Fkkb+VBOYLlW44AKEMTOEbU/AMmErBmhj7d0dqCu366hXc8DxUd1MvkRQrmBr/vzG1qeapGUcRI9S92zV3UQym6ln8Fqn+LXvHq0v62Gf5iyBCNTF5v18uzb03+g2KprywyCIvT82sGm63WCW9aIPxhhFH/ggRkH+u/NIX9Q9Oxx/IKG/BHAeQ202HtYTfYHhfnA43D1qE9aH0AmRgdGX68B3N3uh1yjs08ixXc312pDF9RA1sdZGPGEo9wZYT4tsFCbr687QdJJnzRbjnJSZxYU/vAuBiVEhYZ+lBb2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bpWiIlux74+R+Bgl17ru4GyBcQ5aRhvR+GusSwNvai0=;
 b=i9l/CSm1wOixqSoEOEueFP2fuDkfIc6D2ItpbcyfKJ7rBgZQj2WGb4RjXk4saOe53+VW/6dd8mhlowOygjphnpg/6ScN4D+PB96GUdifXkPvTUyw74J1vyk+DO1Tm59RPiVH6QROnQvOCSLy5cLiGO4zWyCd0Qc8+yBGdr8xO84s9CLuWac0fH4WhLf4A4o1zQzV5nAFCfKeyNRXLXYgoxx9a2pKd/w9X/D46X3WPmRo0BmLES9kBr3V4shZNjaE/22trVPqF/oahQ9r9UuAU2qaNO7vWV4dvdfL6KakAC5UkE9YNA2ULMBIzHKZCBj3SoBdXzYu74cu+GwmIFD01g==
Authentication-Results: cmpxchg.org; dkim=none (message not signed)
 header.d=none;cmpxchg.org; dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3823.namprd12.prod.outlook.com (2603:10b6:208:168::26)
 by MN2PR12MB4287.namprd12.prod.outlook.com (2603:10b6:208:1dd::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.17; Thu, 2 Sep
 2021 15:13:22 +0000
Received: from MN2PR12MB3823.namprd12.prod.outlook.com
 ([fe80::7965:aa96:5d5d:8e69]) by MN2PR12MB3823.namprd12.prod.outlook.com
 ([fe80::7965:aa96:5d5d:8e69%7]) with mapi id 15.20.4478.019; Thu, 2 Sep 2021
 15:13:22 +0000
From:   Zi Yan <ziy@nvidia.com>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Matthew Wilcox <willy@infradead.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [GIT PULL] Memory folios for v5.15
Date:   Thu, 02 Sep 2021 11:13:16 -0400
X-Mailer: MailMate (1.14r5820)
Message-ID: <D77FE2D5-E2ED-4590-95C5-142DF55922F5@nvidia.com>
In-Reply-To: <YS+7pzI7pttxtFHT@cmpxchg.org>
References: <YSU7WCYAY+ZRy+Ke@cmpxchg.org>
 <YSVMAS2pQVq+xma7@casper.infradead.org> <YSZeKfHxOkEAri1q@cmpxchg.org>
 <20210826004555.GF12597@magnolia> <YSjxlNl9jeEX2Yff@cmpxchg.org>
 <YSkyjcX9Ih816mB9@casper.infradead.org> <YS0WR38gCSrd6r41@cmpxchg.org>
 <YS0h4cFhwYoW3MBI@casper.infradead.org> <YS0/GHBG15+2Mglk@cmpxchg.org>
 <YS1PzKLr2AWenbHF@casper.infradead.org> <YS+7pzI7pttxtFHT@cmpxchg.org>
Content-Type: multipart/signed;
 boundary="=_MailMate_225917DC-37B2-487B-814D-C995BBAE5D6C_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: MN2PR19CA0014.namprd19.prod.outlook.com
 (2603:10b6:208:178::27) To MN2PR12MB3823.namprd12.prod.outlook.com
 (2603:10b6:208:168::26)
MIME-Version: 1.0
Received: from [10.2.56.206] (216.228.112.21) by MN2PR19CA0014.namprd19.prod.outlook.com (2603:10b6:208:178::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.19 via Frontend Transport; Thu, 2 Sep 2021 15:13:19 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 65f75867-d7da-4704-a385-08d96e24342c
X-MS-TrafficTypeDiagnostic: MN2PR12MB4287:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB4287D98F65AAA4386A0E3BC9C2CE9@MN2PR12MB4287.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1PcpRkPKOhTvcl1wSOSVVfN4M90I3opqOj2hvR9LVSIpGC2JX/SJwZ48tKLhA9huaQzzADcK4HSoHeCn5oCY71ccizq2Bwgw5SSqI8RasfGSMaGErBauzCzonL2QmNXa83tMoV5KA5RzwmQ3DSQtaWMxWG7o+6obpT0yN/rXUKoOOZoJ2Iv6CqVuNYJ4cWJvCp/6SlQqN1caHt3tZ4huFCqtDm1qQby4BLQj2Z1jMdqR3x0V1T8Yf/ZtagezvATArdTCG6yolZ++REMhubxx9+1/G158savI3SglJSWEl8OXgLWhbYlSqFXX+ztAlo84Et6aVilsxgXKpqSzklBtqCDwzTQzkExiHo5AuiSo7c5r/UywQrbvVsRhqP7A2JNJih+s9hai4pUs6xO9uK4JGhZ7roIW+Y+LXENtMNoqHvy0DMX/bmv6BHswUVE1Bt/DfZjopVstkmZXfqAlSWA8ACHwDGnX3Bvy5GjZFeLduy6RUQwhUEob2eApeYaD1njw2pU8s/2SfPlP6ZTdwQYUIsd5HXGg/OOW5pF5qGlR9UF1X9C4shsE+SHUEBLgDGT6m2JkG2GDAlbC+SA3RNm4vofg3VRucozbg340nnLj+f/213zs4C8rA7sNfLf+/lBFKnnLMxQB9yrQNQUQnSPhmbafBEiU/56AADq9r6/62lgzSd0olRjOgsACuA04dxq344al+h3jK6YX75sLndghYpZNR36coBxPLey+1uPtMjg09pE+qCah5J5qCH101IklytYWgaw9mZwPYwWPrnMLq4YYL3KWPacnRVYF8DPvTiAPocL9q2uc9vIn64Y6eXGW
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3823.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(346002)(366004)(136003)(396003)(39860400002)(2906002)(33964004)(6486002)(5660300002)(4326008)(966005)(33656002)(66946007)(66476007)(66556008)(86362001)(38100700002)(956004)(186003)(235185007)(2616005)(36756003)(8676002)(83380400001)(8936002)(478600001)(16576012)(6916009)(316002)(26005)(6666004)(54906003)(53546011)(21480400003)(45980500001)(72826004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TUE1YUtjcnhaOS9EdVpDSkp3b2VIOVJEcVJjN2JZelgvUEsyalAwamNkUXl1?=
 =?utf-8?B?Tmg5Rk9LWlNjbkxqc3pVU2NNTThVdTNZUmZLbVlMdFhDZk83N3c2MVJYSWRl?=
 =?utf-8?B?Ulk0SFQvd05uN2krdDRrYjg2Z0FJa3YwYTVHd2d4cWxjSHB5OHpYSHJ6Y1A5?=
 =?utf-8?B?aVNES1pWRmp1OUhBemNNMENkTWpPdWNZL2dlWEhIV3AvR285dWlqRXc2aTVu?=
 =?utf-8?B?Rk4ycSsxRjE0OEhrV1V0Vzc5ZHdKTE01QXN5QzFQY2cxOXlqT05OOEFueVlK?=
 =?utf-8?B?dHFxeExHOHNPeThzTzNZV0pxaEIzbmhaUkh6amh1SzRJQXY5ZENNZEI5eW9C?=
 =?utf-8?B?QVJ4NmRqb0tKSmJMRTB5VVRmTlY2YnlhZDk5dnBwNjdKd3FpcHA0dUxXTUda?=
 =?utf-8?B?TVRWSnpoRzFYdDNwc1NkVS80SUQwOW5vZ3UxODc0UlllRThZblFGeHRVaGVj?=
 =?utf-8?B?RkJpWHNmejNYNkJPMTNtQ1lnWUZkTGtTYXVKM2ZlaUY5ek9zTFFDNXByYWFB?=
 =?utf-8?B?c1VQajk1SitaNmVqNkNHT2hTTXY5S0dLZkRvbEcwMFBMeEwwckZFeUtNUjBE?=
 =?utf-8?B?NlQ0eTQveGgyMTNBc3gyV0l2SlU1TmV6MldGU2JTOWFQWXZCVWVjTHlkb2lG?=
 =?utf-8?B?WWxseHlaRGM2blJqbnZtL3FKbUJyMHZtT1hLZ2xPMUo4dEdDOEdrMEFJZHY2?=
 =?utf-8?B?VTVWZTJuMUlxSEZrMGg1QnhyMEVjbVRoNnZHY0hhdzNQYlhVYUpIQ042KzRF?=
 =?utf-8?B?WTI4NjdkcFQ5eWVXTERkKy9yTFE0eXhZc1FKelVoZmlUaUdLNkcvWHAzU2Vn?=
 =?utf-8?B?dXdkR0Z1Q0hSdnRuWkdWVXQ3Q0J1bXgrRFNpbVJFRFozOEpMTXFyL0lkaTN1?=
 =?utf-8?B?NFp4by84UmJNTmp4bGc5R2xHZkx6NE1oOGgzSjNRN3pIbEJRNldHbFVsT2wx?=
 =?utf-8?B?eUhGYktDUEpDZlFHK0xKUllVd28xRnc3OWV3bFBzSjJjOG14Z25JMGUvc0pM?=
 =?utf-8?B?MldtYXFkL3Btd1c0eHlibFVUMzhqcm43RFNiVXcraVJLZVdRd045bXorSEZp?=
 =?utf-8?B?RjZyM2xlSURkUzZtWmxKdTU4d3BvYkY3UnZDQ0RHSDhxWDV2bVRqMXZGZ3Jy?=
 =?utf-8?B?NnVwcTFVWFdwUnBYeDBjdkFKVlM4MmZ2bm90K3pWL2VqNzBoczJRSnR5MFRT?=
 =?utf-8?B?UjVKcnJnZ0gzTmNGSFR5MFREV1NSOGdJdjAxTU0vZEQ1WWZ5RWFFcGZvd3M3?=
 =?utf-8?B?bzVSd0dERmR3eS9NbE5lMHp1WmFoWEdqb0N0RzZPSXcwMXEvWlpQK0I3ZU5J?=
 =?utf-8?B?bGZnYktVUFZoK2dsTnFxOFpXcmYrNExlNkFXSk03Sm9qaisydTFYbWh3QUt3?=
 =?utf-8?B?cXptSVVycVR2VkRDeHZpUmpHcEhlTndtelpEQm16SGtDMm0wSjU4WHlxWjRC?=
 =?utf-8?B?YysvTTdGanlnMmp4RC80ZFFGQTdxTTlTY0FUa2d6dCtxa3A2KzVOOU0vQjJZ?=
 =?utf-8?B?VXFNT3FDcDRIc2ZGVDE4dWZLenBCbzQ2ZmN3OU1aK2RtOHRDMzN4UHJCV3ha?=
 =?utf-8?B?dmtBamNkZ1lCK1NORExURUVMYW9lU0oyM0RuTWYvZVVBRXJNUU45VERnUFds?=
 =?utf-8?B?MGFlcXdNQW5EMHVGUFlGaCtsSlhoNER5ZFphYWZ2SksyMytORm80ZWFTOVJX?=
 =?utf-8?B?WFVuM1RjWG16OThoQk1QZ0J4WjVScURuc1M3Mzk5UnR4V1FIcXhIV2tNWCtF?=
 =?utf-8?Q?m49w5xVd6P2p7GJY+i++WD0T+myQb4buW/fzTjm?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65f75867-d7da-4704-a385-08d96e24342c
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3823.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2021 15:13:22.6212
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: By5WiFgFI7sH1Dbh5KDwmrdLxTsIhNVDHk2poQZm/oo592r3Zc4J5jrFmr2EnUb8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4287
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

--=_MailMate_225917DC-37B2-487B-814D-C995BBAE5D6C_=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 1 Sep 2021, at 13:43, Johannes Weiner wrote:

> On Mon, Aug 30, 2021 at 10:38:20PM +0100, Matthew Wilcox wrote:
>> On Mon, Aug 30, 2021 at 04:27:04PM -0400, Johannes Weiner wrote:
>>> Right, page tables only need a pfn. The struct page is for us to
>>> maintain additional state about the object.
>>>
>>> For the objects that are subpage sized, we should be able to hold tha=
t
>>> state (shrinker lru linkage, referenced bit, dirtiness, ...) inside
>>> ad-hoc allocated descriptors.
>>>
>>> Descriptors which could well be what struct folio {} is today, IMO. A=
s
>>> long as it doesn't innately assume, or will assume, in the API the
>>> 1:1+ mapping to struct page that is inherent to the compound page.
>>
>> Maybe this is where we fundamentally disagree.  I don't think there's
>> any point in *managing* memory in a different size from that in which =
it
>> is *allocated*.  There's no point in tracking dirtiness, LRU position,=

>> locked, etc, etc in different units from allocation size.  The point o=
f
>> tracking all these things is so we can allocate and free memory.  If
>> a 'cache descriptor' reaches the end of the LRU and should be reclaime=
d,
>> that's wasted effort in tracking if the rest of the 'cache descriptor'=

>> is dirty and heavily in use.  So a 'cache descriptor' should always be=

>> at least a 'struct page' in size (assuming you're using 'struct page'
>> to mean "the size of the smallest allocation unit from the page
>> allocator")
>
> First off, we've been doing this with the slab shrinker for decades.
>
> Second, you'll still be doing this when you track 4k struct pages in a
> system that is trying to serve primarily higher-order pages. Whether
> you free N cache descriptors to free a page, or free N pages to free a
> compound page, it's the same thing. You won't avoid this problem.
>
>>>>> Well yes, once (and iff) everybody is doing that. But for the
>>>>> foreseeable future we're expecting to stay in a world where the
>>>>> *majority* of memory is in larger chunks, while we continue to see =
4k
>>>>> cache entries, anon pages, and corresponding ptes, yes?
>>>>
>>>> No.  4k page table entries are demanded by the architecture, and the=
re's
>>>> little we can do about that.
>>>
>>> I wasn't claiming otherwise..?
>>
>> You snipped the part of my paragraph that made the 'No' make sense.
>> I'm agreeing that page tables will continue to be a problem, but
>> everything else (page cache, anon, networking, slab) I expect to be
>> using higher order allocations within the next year.
>
> Some, maybe, but certainly not all of them. I'd like to remind you of
> this analysis that Al did on the linux source tree with various page
> sizes:
>
> https://lore.kernel.org/linux-mm/YGVUobKUMUtEy1PS@zeniv-ca.linux.org.uk=
/
>
> Page size	Footprint
> 4Kb		1128Mb
> 8Kb		1324Mb
> 16Kb		1764Mb
> 32Kb		2739Mb
> 64Kb		4832Mb
> 128Kb		9191Mb
> 256Kb		18062Mb
> 512Kb		35883Mb
> 1Mb		71570Mb
> 2Mb		142958Mb
>
> Even just going to 32k more than doubles the cache footprint of this
> one repo. This is a no-go from a small-file scalability POV.
>
> I think my point stands: for the foreseeable future, we're going to
> continue to see demand for 4k cache entries as well as an increasing
> demand for 2M blocks in the page cache and for anonymous mappings.
>
> We're going to need an allocation model that can handle this. Luckily,
> we already do...
>
>>>>> The slab allocator has proven to be an excellent solution to this
>>>>> problem, because the mailing lists are not flooded with OOM reports=

>>>>> where smaller allocations fragmented the 4k page space. And even la=
rge
>>>>> temporary slab explosions (inodes, dentries etc.) are usually pushe=
d
>>>>> back with fairly reasonable CPU overhead.
>>>>
>>>> You may not see the bug reports, but they exist.  Right now, we have=

>>>> a service that is echoing 2 to drop_caches every hour on systems whi=
ch
>>>> are lightly loaded, otherwise the dcache swamps the entire machine a=
nd
>>>> takes hours or days to come back under control.
>>>
>>> Sure, but compare that to the number of complaints about higher-order=

>>> allocations failing or taking too long (THP in the fault path e.g.)..=
=2E
>>
>> Oh, we have those bug reports too ...
>>
>>> Typegrouping isn't infallible for fighting fragmentation, but it seem=
s
>>> to be good enough for most cases. Unlike the buddy allocator.
>>
>> You keep saying that the buddy allocator isn't given enough informatio=
n to
>> do any better, but I think it is.  Page cache and anon memory are mark=
ed
>> with GFP_MOVABLE.  Slab, network and page tables aren't.  Is there a
>> reason that isn't enough?
>
> Anon and cache don't have the same lifetime, and anon isn't
> reclaimable without swap. Yes, movable means we don't have to reclaim
> them, but background reclaim happens anyway due to the watermarks, and
> if that doesn't produce contiguous blocks by itself already then
> compaction has to run on top of that. This is where we tend to see the
> allocation latencies that prohibit THP allocations during page faults.
>
> I would say the same is true for page tables allocated alongside
> network buffers and unreclaimable slab pages. I.e. a burst in
> short-lived network buffer allocations being interleaved with
> long-lived page table allocations. Ongoing concurrency scaling is
> going to increase the likelihood of those happening.
>
>> I think something that might actually help is if we added a pair of ne=
w
>> GFP flags, __GFP_FAST and __GFP_DENSE.  Dense allocations are those wh=
ich
>> are expected to live for a long time, and so the page allocator should=

>> try to group them with other dense allocations.  Slab and page tables
>> should use DENSE,
>
> You're really just recreating a crappier, less maintainable version of
> the object packing that *slab already does*.
>
> It's *slab* that is supposed to deal with internal fragmentation, not
> the page allocator.
>
> The page allocator is good at cranking out uniform, slightly big
> memory blocks. The slab allocator is good at subdividing those into
> smaller objects, neatly packed and grouped to facilitate contiguous
> reclaim, while providing detailed breakdowns of per-type memory usage
> and internal fragmentation to the user and to kernel developers.
>
> [ And introspection and easy reporting from production are *really
>   important*, because fragmentation issues develop over timelines that
>   extend the usual testing horizon of kernel developers. ]

Initially, I thought it was a great idea to bump PAGE_SIZE to 2MB and
use slab allocator like method for <2MB pages. But as I think about it
more, I fail to see how it solves the existing fragmentation issues
compared to our existing method, pageblock, since IMHO the fundamental
issue of fragmentation in page allocation comes from mixing moveable
and unmoveable pages in one pageblock, which does not exist in current
slab allocation. There is no mix of reclaimable and unreclaimable objects=

in slab allocation, right? In my mind, reclaimable object is an analog
of moveable page and unreclaimable object is an analog of unmoveable page=
=2E
In addition, pageblock with different migrate types resembles how
slab groups objects, so what is new in using slab instead of pageblock?

My key question is do we allow mixing moveable sub-2MB data chunks with
unmoveable sub-2MB data chunks in your new slab-like allocation method?

If yes, how would kernel reclaim an order-0 (2MB) page that has an
unmoveable sub-2MB data chunk? Isn=E2=80=99t it the same fragmentation si=
tuation
we are facing nowadays when kernel tries to allocate a 2MB page but finds=

every 2MB pageblock has an unmoveable page?

If no, why wouldn=E2=80=99t kernel do the same for pageblock? If kernel d=
isallows
page allocation fallbacks, so that unmoveable pages and moveable pages
will not sit in a single pageblock, compaction and reclaim should be able=

to get a 2MB free page most of the time. And this would be a much smaller=

change, right?

Let me know if I miss anything.


--
Best Regards,
Yan, Zi

--=_MailMate_225917DC-37B2-487B-814D-C995BBAE5D6C_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEEh7yFAW3gwjwQ4C9anbJR82th+ooFAmEw6gwPHHppeUBudmlk
aWEuY29tAAoJEJ2yUfNrYfqKUKEQAK/U7YaC5G0ZHKR2/C8pG7cYrrZyUfkEogK7
8qGZMJirTi1DgEbWZOn88KPv9oHNAUfK1uoQKkoNRNuyjI/CJLF1il7Q7Z0RJRkS
QGT/GcaJhvgfS1k72nD8J00+69SjQIkrNuVE0SRVN6vmbqU6AShyil+2MWNjP7Js
VSr4ln5rX5tnUWJyEw7rTqYBlDdhft/OogvOpUdcanwXZVR2WVZ/0Z5Y+KXCWcP9
EI4FO2PIBAZZrJol0BSfvyU2OAuH/+r1m+cfnZTooZzFidczr4YPAPrrcbv9UW/R
mC+xhDkHyjsREISikMhIp9J4kxWkrbOXEpwX/5s8Q0sN8S3KIIGj8T/xyR5lJtki
B5bBndvwLDFxHd5EVz2iGsBQR1uZWxDjSr42n499hS4ItQmHVdnPzauk9XZLWPAu
AAGimWCl2A7Z2TbkdYTdb9/5QXLpeFlXv4Scn+bFjxMDrJeAIDbROHPVJG2HZ+Vx
RhJV2j+B2Tr3TQPI4M9JDZYvUv8PFwcU0F3SzqW9w0VoNc9RrA/vfMc8HfQfZI5A
naAnQRKiQ31gSfyNfyx5zT0lPCF3u6WpknDPAazLvIwELZua3ZXhweIVGmr95suD
EgxhydNbnmoZ9eM5jYP9yywRbX85dcAa4rTfxuU4c/wbexfDukQ1WVNtxoyVeYF+
64r+UVyn
=qOLD
-----END PGP SIGNATURE-----

--=_MailMate_225917DC-37B2-487B-814D-C995BBAE5D6C_=--
