Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CA2B6E4CC6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Apr 2023 17:21:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230361AbjDQPVf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Apr 2023 11:21:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230270AbjDQPVP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Apr 2023 11:21:15 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2062.outbound.protection.outlook.com [40.107.244.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68C62BB8B;
        Mon, 17 Apr 2023 08:20:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eIac4v0mjZKlFSHvyQfev+ENdAR69aRPKRoDE1TtWtaQ7OFBP+oykG1EfEnL9itCM8zRHueUTpmQvV4RX1RTWsY+N7f2V3dNTIb64EF0VAGDCCjOKpWrZb2mDDNrgotc3+d4jWVYa+obJdRcmbm/2dVc7OrQMZQSQhKl1e2FY5Hv1p7lPn5GNHh95Iy1cBY7L9bQEoPMlmMxKJRzbXXZ5FZbgJfwocdTQOVr29uRlEANfTgkFcjs/Y+mpCfHcF+x0VH+B5LqRP7loTN/bdq8FMTKtbLuT3e2tGdK2QJLdyn1r8iLQ2cYbF17UeI3/nlaPkRah6LXcf7SlL4HpNUV4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7efQR0ImsGvZWg1L4YVf+xYfL28MtoAmV611fey20v0=;
 b=LYlUNHjx7WynsjJkJHb9+OKR/ylBoTlRuMMCbPrAdSemAmbX4U7kIYsEQonuGQGuu9OKXjqecXquILCnJAMi7K5YxemW4dhRV9aMTcW3S/4rHRvrpBZW3st3I66b3R+Y6adF4Qujkkg7rXG3jdl4BSCKvi7/8o7x2eXWWZ+FyAJ5XORw/nCKY9gn+wIRrsk+v4uuy2+xTHLm6zcZrQ3ij6D9RKwDJXzJHYCv3hxpg2IKvsNuql2QNG8ILwhIIHliUIUqOTYqE28h5K3FYNibixqm0zDXzRhWvUXoNUaUCL8tzmw5aFQShIZ3qvhdPEaQxP8s09PtZoQzZrf8cPhQJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7efQR0ImsGvZWg1L4YVf+xYfL28MtoAmV611fey20v0=;
 b=TPnV8L9cM++HWhUKVSVdzEETQdShosjHLSjOTEN/Cqhf17SJqALKRuA/cTu6d8Sd3VKjyCkU3jF9iMoMbSqMtgrSMgyKguMCAqw8Z2r5REFKPZS590OoFOBJmXf/cp3LrVnQrWv2gPwcH1OfhMdyoDahmRwTzT45704NeYvQg2sA+JD93qbVt6d3WWET58B9+9xRbj7LSN5EuhyfGykX5q//Firo+vYO5JnaMW4/+wxJ4VehrsxAWDCzAGBQTkUdTqbCdFk0p+/TfRV9iQBVkDK//wcHx91MRv23XPqtTa455/FOX5N23DSWZ5Fb1yszfilt4yrbZE4J70tNJtE2EA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL1PR12MB5730.namprd12.prod.outlook.com (2603:10b6:208:385::9)
 by PH7PR12MB7114.namprd12.prod.outlook.com (2603:10b6:510:1ed::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.45; Mon, 17 Apr
 2023 15:20:33 +0000
Received: from BL1PR12MB5730.namprd12.prod.outlook.com
 ([fe80::80d4:b482:3e2f:ae9c]) by BL1PR12MB5730.namprd12.prod.outlook.com
 ([fe80::80d4:b482:3e2f:ae9c%5]) with mapi id 15.20.6298.045; Mon, 17 Apr 2023
 15:20:32 +0000
From:   Zi Yan <ziy@nvidia.com>
To:     Hugh Dickins <hughd@google.com>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Yang Shi <shy828301@gmail.com>, Yu Zhao <yuzhao@google.com>,
        linux-mm@kvack.org,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Ryan Roberts <ryan.roberts@arm.com>,
        =?utf-8?q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        "Zach O'Keefe" <zokeefe@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v3 6/7] mm: truncate: split huge page cache page to a
 non-zero order if possible.
Date:   Mon, 17 Apr 2023 11:20:31 -0400
X-Mailer: MailMate (1.14r5963)
Message-ID: <0AC0520E-1BD2-497E-A7ED-05394400BFC9@nvidia.com>
In-Reply-To: <9dd96da-efa2-5123-20d4-4992136ef3ad@google.com>
References: <20230403201839.4097845-1-zi.yan@sent.com>
 <20230403201839.4097845-7-zi.yan@sent.com>
 <9dd96da-efa2-5123-20d4-4992136ef3ad@google.com>
Content-Type: multipart/signed;
 boundary="=_MailMate_2F2466C6-2327-4132-B79B-A943398CFB0E_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: BL1P223CA0019.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:208:2c4::24) To BL1PR12MB5730.namprd12.prod.outlook.com
 (2603:10b6:208:385::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5730:EE_|PH7PR12MB7114:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d2d5207-56db-4ab8-cd4e-08db3f574940
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 26++3RtmjwUgmwjvyrGxduUfLDp+jS4tkPIG8dgK1lbICZsEa5TAbNfP3Qe1euD80MMUCn8ipST/ClPF+uD8OT75SlGiYNSm8rJTAWcQIy2G/QNHjFKq+I2iVhTTHxIdJaAjobv6vVd6uQgRsZtiRT1PqybDav16smFZIXuSdt1VgaFqNMew3N8VAsQ753JEHShRc01dAgRzULEnN5K6TMDx0fQz5Am18Z76EbKizfsmMMFx4oE1npZT3+SF7t2uKmIZcXUoi8KtlM8BXLw7UCFANUwCuFX8JR39/Cp8B+BJl1OWlsafBipo47BMV6LBJm6GU5wn/36Xp6OkgGuFo+OlLaTIGqVpOJuHeHfu2jdBt+Ft0s/+a245PlpY1NfrJEmE/G6XWJAXyXTRHK70troU1PaUTvJea+p7XiTRfmbDt35RQu9HrsIjduJezkWV7DkMs3E3c6WZoLV7Wqog8xnFnWwGdYp5lJtuQLvGqMT+SEtVHF5v1PjPE97VK8tcoJ2PnDH1DoqoE6bngbLcecuqrxiT4nK6/Vad7Z0uBbOqgCxxM3J798iNVzat6ycdx2G039wxDRr+sFTP2YRJg8eslTimHETZTZ4uT4pKugea5GHi3NAO1mqKI07s2lyaK1YfJ3O9v92EAfg1GqbfaF0+NjLMj387gFZePPXNQcc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5730.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(346002)(376002)(396003)(136003)(39860400002)(451199021)(53546011)(6512007)(6506007)(26005)(66899021)(41300700001)(186003)(316002)(33656002)(6486002)(478600001)(36756003)(54906003)(66946007)(66556008)(66476007)(86362001)(6916009)(4326008)(2616005)(7416002)(5660300002)(235185007)(38100700002)(8676002)(8936002)(2906002)(83380400001)(14583001)(45980500001)(72826004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8kMEhNhr7FdPgjeHIXgE/gcq4XYPwr7cU5YcZW/McKUasDZ6UWfjCG85WKaM?=
 =?us-ascii?Q?OcgK7xhdUT7zEiXV1vdZLyRD3yNHP3E24AhjJ9wb4IuU4sK9X1J1KsIk/Yi0?=
 =?us-ascii?Q?DSyaQp1xW6+j2Dh1tlNl582F2on+dLORcR4aJIuzodsRBREyUUq53cf8MeGa?=
 =?us-ascii?Q?TLY0stRvCiZG3IvbblggfvPXgjKHUIssqnVovQCysS3ZDZY9lPvO0NDi7vRd?=
 =?us-ascii?Q?iV+83axRnDbmhsaaJg5j4G+UxZG+0Bf4BDvwzDdg9bL5bPnlwf3vvkMhmjm1?=
 =?us-ascii?Q?Jh5hVFQNQJaZcMQfWuWg7pslyAfhI8qhJ0bpOBx+sXMnyMFv5GiWHXgOBCLy?=
 =?us-ascii?Q?7/1hJgb9i2+PXYic4gk5SFGWiUj7RxiRBaQIlNKiX7MVTHC7JmRyYkM87qUa?=
 =?us-ascii?Q?xJq/AlPoneoN8et6taLZG40usutI4euTHz5T6JKic1fGd4tC8mkr09EovZLz?=
 =?us-ascii?Q?jLWE9+Lv0ZBFqtWeDhD2vRBAnQzMeLpx42yHAZ2Alb/Z1SSK3bkZ5iEy4z4b?=
 =?us-ascii?Q?aGS4YUpYOBuJ9ny9p3LRKdDko3ieEMi8Et9/sKfJY3lOiymSn7GiQonEfxbN?=
 =?us-ascii?Q?EuIKmLXREvycTNkDatgEQ3TwjIe7XknyGfA1jl8odOaHnEXhI1aSYBPtffl/?=
 =?us-ascii?Q?fsfwadewe8oFfBOv+354HP3e3unHRgTmNfeP+ZArXxeJELxVIl2e/NcMwZr3?=
 =?us-ascii?Q?S4vVhx3MmDgiq2ZniY7u38EvIcxHwalpcd9CiMe7+pYbi8i+abEmG0gEZs+W?=
 =?us-ascii?Q?xOFkOA+MScNtjRffrIq06lQpF+U2jAhs673oZ0jR6U1jkd6sqYWycDJj436z?=
 =?us-ascii?Q?dEDwJcsjkPWv6n2AoMvIkasslSPODccrTYxoCecQSUgEeENqDaFJs6+3OtQ8?=
 =?us-ascii?Q?VYZ0rrBX+WBcBLA0XsIF3AnN9IHQCuWfIcPvvhQrn99q3tPlNQMlKXZqIYif?=
 =?us-ascii?Q?G2xP6CTFV0i40UXh10S8Ek3w2WRJqzZHcuILMSj4Xpk0JVYZ1R68wj7KfzZw?=
 =?us-ascii?Q?UwbQZYhSdsjbilqIuv7L375SAQYstO+AQqcYuu+UK7sOprA3rMASTXG2pWBe?=
 =?us-ascii?Q?Rn7FVHlBTg5EpJ2wFr01VNb3LIt/p6+6Tk83JKrFGSTLe7XEBjEyTN2MREag?=
 =?us-ascii?Q?qkTIKhqZ3pR3Sl2HSZ9uFgeevg+LCxHH6yo7wahGNssWMBG2WoS6Lroos/Kw?=
 =?us-ascii?Q?TsRLD1NPwrTNTeZL0jCnBcR6UY3pohgK9legBJZdJidH80VF6SNa7eC5HI8B?=
 =?us-ascii?Q?sOrq++M5PgdI3jKNWC52lP21iI8vXiGsSobS+QGo57eHTrWVkJzKjD6CzcYM?=
 =?us-ascii?Q?2IdgEQSV5QvDm5/DusGxIc8Fx8TR2QuuUycLm2iOue//FV0kHMmxrCrTf+Rj?=
 =?us-ascii?Q?PRJH0aa3Hz4mrZrYWTvjf2YSAZCSeN0Fyw5mRjHPyMsC0tf6lCd0LLjsLpxb?=
 =?us-ascii?Q?d8K9a7mI/IJVyTouhJGwi+FBRGSmuz461z197LbchkaO6PTCcZP9vkAvUTDV?=
 =?us-ascii?Q?MSAuZUBXYy4mQMuYnUcs+2jfce8bQVVzIGEaYELVhn0WOG/omQH6D2DKKxa0?=
 =?us-ascii?Q?/9AbYZyrskUwFI09EFg9GWW3VVFmNdBGxcm5vmHD?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d2d5207-56db-4ab8-cd4e-08db3f574940
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5730.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2023 15:20:32.8438
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iYfqIKJXu1ccrMdDe4UnAxQUcjV4t+xPG56GGyjZnUmpOvLweTfvebQLbMA05Yic
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7114
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

--=_MailMate_2F2466C6-2327-4132-B79B-A943398CFB0E_=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On 16 Apr 2023, at 15:44, Hugh Dickins wrote:

> On Mon, 3 Apr 2023, Zi Yan wrote:
>
>> From: Zi Yan <ziy@nvidia.com>
>>
>> To minimize the number of pages after a huge page truncation, we do no=
t
>> need to split it all the way down to order-0. The huge page has at mos=
t
>> three parts, the part before offset, the part to be truncated, the par=
t
>> remaining at the end. Find the greatest common divisor of them to
>> calculate the new page order from it, so we can split the huge
>> page to this order and keep the remaining pages as large and as few as=

>> possible.
>>
>> Signed-off-by: Zi Yan <ziy@nvidia.com>
>> ---
>>  mm/truncate.c | 21 +++++++++++++++++++--
>>  1 file changed, 19 insertions(+), 2 deletions(-)
>>
>> diff --git a/mm/truncate.c b/mm/truncate.c
>> index 86de31ed4d32..817efd5e94b4 100644
>> --- a/mm/truncate.c
>> +++ b/mm/truncate.c
>> @@ -22,6 +22,7 @@
>>  #include <linux/buffer_head.h>	/* grr. try_to_release_page */
>>  #include <linux/shmem_fs.h>
>>  #include <linux/rmap.h>
>> +#include <linux/gcd.h>
>
> Really?
>
>>  #include "internal.h"
>>
>>  /*
>> @@ -211,7 +212,8 @@ int truncate_inode_folio(struct address_space *map=
ping, struct folio *folio)
>>  bool truncate_inode_partial_folio(struct folio *folio, loff_t start, =
loff_t end)
>>  {
>>  	loff_t pos =3D folio_pos(folio);
>> -	unsigned int offset, length;
>> +	unsigned int offset, length, remaining;
>> +	unsigned int new_order =3D folio_order(folio);
>>
>>  	if (pos < start)
>>  		offset =3D start - pos;
>> @@ -222,6 +224,7 @@ bool truncate_inode_partial_folio(struct folio *fo=
lio, loff_t start, loff_t end)
>>  		length =3D length - offset;
>>  	else
>>  		length =3D end + 1 - pos - offset;
>> +	remaining =3D folio_size(folio) - offset - length;
>>
>>  	folio_wait_writeback(folio);
>>  	if (length =3D=3D folio_size(folio)) {
>> @@ -236,11 +239,25 @@ bool truncate_inode_partial_folio(struct folio *=
folio, loff_t start, loff_t end)
>>  	 */
>>  	folio_zero_range(folio, offset, length);
>>
>> +	/*
>> +	 * Use the greatest common divisor of offset, length, and remaining
>> +	 * as the smallest page size and compute the new order from it. So w=
e
>> +	 * can truncate a subpage as large as possible. Round up gcd to
>> +	 * PAGE_SIZE, otherwise ilog2 can give -1 when gcd/PAGE_SIZE is 0.
>> +	 */
>> +	new_order =3D ilog2(round_up(gcd(gcd(offset, length), remaining),
>> +				   PAGE_SIZE) / PAGE_SIZE);
>
> Gosh.  In mm/readahead.c I can see "order =3D __ffs(index)",
> and I think something along those lines would be more appropriate here.=

>
> But, if there's any value at all to choosing intermediate orders here i=
n
> truncation, I don't think choosing a single order is the right approach=
 -
> more easily implemented, yes, but is it worth doing?
>
> What you'd actually want (if anything) is to choose the largest orders
> possible, with smaller and smaller orders filling in the rest (I expect=

> there's a technical name for this, but I don't remember - bin packing
> is something else, I think).
>
> As this code stands, truncate a 2M huge page at 1M and you get two 1M
> pieces (one then discarded) - nice; but truncate it at 1M+1 and you get=

> lots of order 2 (forced up from 1) pieces.  Seems weird, and not worth
> the effort.

The approach I am adding here is the simplest way of splitting a folio
and trying to get >0 order folios after the split.

Yes, I agree that using "__ffs(index)" can create more >0 order folios, b=
ut
it comes with either more runtime overheads or more code changes. Like
your "1MB + 1" page split example, using "__ffs(index)", ideally, you wil=
l
split 2MB into 2 1MBs, then 1MB into 2 512KBs, ..., 8KB into 2 4KBs and
at the end of the day, we will have 1MB, 512KB, ..., 8KB each and two 2 4=
KBs,
maximizing the number of >0 order folios. But what is the cost?

1. To minimizing code changes, we then need to call
split_huge_page_to_list_to_order() 9 times from new_order=3D8 to new_orde=
r=3D0.
Since each split needs to unmap and remap the target folio, we shall see
9 TLB shutdowns. I am not sure it is worth the cost.

2. To get rid of the unmap and remap overheads, we probably can unmap
the folio, then do all the 9 splits, then remap all the split pages. But
this would make split_huge_page() a lot more complicated and I am not sur=
e
a good way of passing split order information and the corresponding
to-be-split subpages. Do we need a dynamic list to store them, making
new memory allocations a prerequisite of split_huge_page()? Maybe we can
encode in the split information in two ints? In the first one,
each bit tells which order to split the page (like order=3D__ffs(index))
and in the second one, each bit tells which subpage to split next (0 mean=
s
the left subpage, 1 means the right subpage). So your "1MB + 1" page spli=
t
will be encoded as 0b111111111 (first int), 0b1000000 (second int and
it has 1 fewer bit, since first split does not need to know which subpage=

to split).

What do you think? If you have a better idea, I am all ears. And if you
are willing to help me review the more complicated code changes, I am
more than happy to implement it in the next version. :)

Thank you for your comments. They are very helpful!

>
> Hugh
>
>> +
>> +	/* order-1 THP not supported, downgrade to order-0 */
>> +	if (new_order =3D=3D 1)
>> +		new_order =3D 0;
>> +
>> +
>>  	if (folio_has_private(folio))
>>  		folio_invalidate(folio, offset, length);
>>  	if (!folio_test_large(folio))
>>  		return true;
>> -	if (split_folio(folio) =3D=3D 0)
>> +	if (split_huge_page_to_list_to_order(&folio->page, NULL, new_order) =
=3D=3D 0)
>>  		return true;
>>  	if (folio_test_dirty(folio))
>>  		return false;
>> -- =

>> 2.39.2


--
Best Regards,
Yan, Zi

--=_MailMate_2F2466C6-2327-4132-B79B-A943398CFB0E_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEE6rR4j8RuQ2XmaZol4n+egRQHKFQFAmQ9Y78PHHppeUBudmlk
aWEuY29tAAoJEOJ/noEUByhUltQP/iHzaohQhNHX3dFij8oFo03N5i6YzNvIyDOR
iRse4krUQpMRSzHiaowDE+OC4cNDXfhKBiVFjxTn/LjTLX2ZAy0v6zjvGykkvP1k
OzT7aBjGUzPzH7HrUM+PnxyPSO3S4ipTpMIEidv/mXplOSI34YQjmh5SWQCiJfXk
fuUPnnrY81hicDhY9Sz63pM/Ne7ryngXvCnGQYxY6SZnie4odCGpT+Pmyv/igmxG
OtxkKgTtb/nSI6ZEFestcReUG1+ckLxSECRx/OHb3KKlxz3XnGIBwXFJ1S19R5xr
MzX9/nc0xqWRMAvpmhKhrtEFZ8P5dPNGG2uSPo1DMz9hP3lSp3Q+xjez6bVsgxig
2zEtzLX0fCDIW2VG8cbVHNlpo8NLGJpAkqpVMWpvFs6jIlHF1xTgC1Zg3FPBBX5b
+X/c50H6MRGTosl7bR6uI2d8uGSs2pXYu8t1cgnllOej6We1/I7DtGHFi/ncdBP1
1FihjzkR1911bmlOTzP/aiTopRH8yziQdnNCECDBku3HSyUIQ0nDE9cQt2RGbGiY
TrjM1+zBMgO7ZXXES8kepDl2Ly1W8QFU08GSJ/RdTQ05eDxL5zkW8H4mQh6v5RSY
ZeD5gYdbA/1LWupJ5F/u4K3Ugxg5Y+SLuq9xY7gSKLhwBjHAj3NS3v+GjaTJ/b14
sFRISmzO
=hjyY
-----END PGP SIGNATURE-----

--=_MailMate_2F2466C6-2327-4132-B79B-A943398CFB0E_=--
