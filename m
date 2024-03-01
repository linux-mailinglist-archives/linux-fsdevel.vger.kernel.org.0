Return-Path: <linux-fsdevel+bounces-13263-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 67FF786E156
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Mar 2024 13:53:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 88C3B1C224D4
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Mar 2024 12:53:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AC1940BE3;
	Fri,  1 Mar 2024 12:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Z5+D+dRq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2069.outbound.protection.outlook.com [40.107.92.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C07A1364;
	Fri,  1 Mar 2024 12:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709297575; cv=fail; b=W05Q6bapy3s7gKhETrRa4jp4tpPc15Hc2ei6b1JZQfwbZK2ywNadKGnVO8EPpW//6QmmtrVL5+WzYPB0TDB/KK57hISPQwb8XXuhJxSAHtYW6v4yKV+LTfuxWec/04cB2N+Z+dnBqY+MMfzvW7kYSX7ruYiTsOyrk+CVKcVA0k0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709297575; c=relaxed/simple;
	bh=kLFap9xCx7lt28UlWMs/Jl75sfXlLUP3UtUzKZNaewA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BlhR+/OUdA9kELlOmqk8TyMSKBd+bxMOBmgXnB6ebpngagyIRzt0Bq4uz68NZhk6DoxhS2L2rAeqBcbD5bQzVHJ3/6oVeU9JsYlABIJhj9B+xZZNLddK6c7Uc4cqyRDii5bdTkEAmX5eJh3XCgRNkXINCyOmq2BWrNa8tsGYZQY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Z5+D+dRq; arc=fail smtp.client-ip=40.107.92.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kHaD1VdifCvO3UB879hmODt4bHxm6pcLEOu09ojGb3gWYARSM1+qQkiDXk+RGQHK1UuhikKXnbx0l7qzltYaEPoph7tkrGxrq79ed4n7E8nthvItdfBT0IDXFbl9wDbFylsk6wSKBxRxIeEDOiwVRnKkMwNnEH5dQ4IQL2ZzfgLsl87pff/HwT/v1vGsv+DauVIz7iMjBfFJbvAWeh0ZsdpHg8TKDnx5CjhqYggn8k8vJaK4thx/9NEytpY9doZC1nJJF01KQSuwt+X5ECAPIljMO7WRxGgdNEXCudJsb50YMgZZTv8PT7+lWmLKPMu2VZ3VD5QhBDZskFiCR/xpng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=piBW6HjGKkUj5tXxspGkPDBRySH9VWXB8sBrFWf/mJ8=;
 b=dkPV0YE3ZHXSXb+UCaHGBDNihyPQl3ssmAiPtMRHUWpRlUDwDfM4QEdMnRXjs7V2BUrN5DCAcvU77+iAUczlZ34RHvgu+iCewjvqojbvABt9L7qtaATJblvsOUk11P3wP5WQsmErADiFGN++EZjaSAicbUTK8Pv93ee5uuWwQUqg2blkAoeFadsMLrCKfS6GB6OZMsBrJ1r9rcRF5cAYTuRyopk/1uzxAgeVgjQLE8XWwymCEoEM1byQ4mlHeAa7dHN6JXy1SMwWjcjvqiMUOIJtAnAomdR3C2Wu1yzC9au7uBXExtnMYjXWW4Wds7aSzfMMMdAGlUyFUoJCrFYWOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=piBW6HjGKkUj5tXxspGkPDBRySH9VWXB8sBrFWf/mJ8=;
 b=Z5+D+dRqjvJ+CdoV7moDbARIhFdjnEq02ikeUvU3b7HyJFx66Zr0P2xN0Q3gX+YvTRBvhDIDWVA1Acvnchkl32YYMjpevNlYR7vmPbtv59V8t8tQeeU/ydIxjVfSyMjpwW2BWDK3goY/eSAD8thbB77M/7g9cV/b5n2AL8Srba6+CURKuI6Wg7c4/TYam6a90vsHu8FuN51n6mMwGVN44yoMPVBJO3+0Lx00iyuae0ALjSVGC453iPBhETaRBUXUmfE+Aj+An7dhD46NjAJYK7EXrLSFrLJotHQily11e9+eIqiUhP3aMEGk0M1yNBgHRhvSs6NTAgd00b+baulMYQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL1PR12MB5730.namprd12.prod.outlook.com (2603:10b6:208:385::9)
 by MN0PR12MB5716.namprd12.prod.outlook.com (2603:10b6:208:373::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.41; Fri, 1 Mar
 2024 12:52:48 +0000
Received: from BL1PR12MB5730.namprd12.prod.outlook.com
 ([fe80::cfa4:f168:e9aa:9db1]) by BL1PR12MB5730.namprd12.prod.outlook.com
 ([fe80::cfa4:f168:e9aa:9db1%4]) with mapi id 15.20.7316.046; Fri, 1 Mar 2024
 12:52:48 +0000
From: Zi Yan <ziy@nvidia.com>
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: Aishwarya TCV <aishwarya.tcv@arm.com>,
 "\"Pankaj Raghav (Samsung)\"" <kernel@pankajraghav.com>, linux-mm@kvack.org,
 "\"Matthew Wilcox (Oracle)\"" <willy@infradead.org>,
 David Hildenbrand <david@redhat.com>, Yang Shi <shy828301@gmail.com>,
 Yu Zhao <yuzhao@google.com>,
 "\"Kirill A . Shutemov\"" <kirill.shutemov@linux.intel.com>,
 =?utf-8?q?=22Michal_Koutn=C3=BD=22?= <mkoutny@suse.com>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 "\"Zach O'Keefe\"" <zokeefe@google.com>, Hugh Dickins <hughd@google.com>,
 Luis Chamberlain <mcgrof@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
 cgroups@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v5 8/8] mm: huge_memory: enable debugfs to split huge
 pages to any order.
Date: Fri, 01 Mar 2024 07:52:46 -0500
X-Mailer: MailMate (1.14r6018)
Message-ID: <08703C70-DD6E-446A-9ABC-BC2C8E33B8CD@nvidia.com>
In-Reply-To: <0dab0c69-2eac-4e65-9efe-e0b037499abc@arm.com>
References: <20240226205534.1603748-1-zi.yan@sent.com>
 <20240226205534.1603748-9-zi.yan@sent.com>
 <082e48c8-71b7-4937-a5da-7a37b4be16ba@arm.com>
 <0dab0c69-2eac-4e65-9efe-e0b037499abc@arm.com>
Content-Type: multipart/signed;
 boundary="=_MailMate_3C9A0395-3E51-410F-87CC-F1244AC147F8_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: BLAPR03CA0038.namprd03.prod.outlook.com
 (2603:10b6:208:32d::13) To BL1PR12MB5730.namprd12.prod.outlook.com
 (2603:10b6:208:385::9)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5730:EE_|MN0PR12MB5716:EE_
X-MS-Office365-Filtering-Correlation-Id: beb6a631-b263-4f05-a8b1-08dc39ee7f6d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	XRH0E1LRO2CSivC51gViFBGXOgP5K9NcvXI7qI56RQLA1lWEwjDklfCrKP5xAjNOSxKJQ8Fz+SVmmw7nazCxjukE9qnpgsfm9SIFFmfHYPeYuVqB+PyYKe+EpxMuXHyTlHYuTenMRUnj8sr+xdJ8tgkF3YcpFpD8b8+p3ahJzxcgqr+OFWawNqF1sqMVTlGmh/dLTMcXWX4xqGNC9e7rjgXjHUrcUjQj0znlZfl6PFJnRzhIA6yTo+ISndMY18AZnfsYDmtufvJ1EYhPUhJF8Ed4Va+1Mt4Ab1freLYEnlL3O/rVXBxMsyxo5bVoxr/b4qJwpKJSX4KyAsiNmVn9rN5LCTJlSv1P+H4f53Hp0gKP0KkF3920DbXcUUjDp+fJCgChBuPedzL3G0Qr063puFZ9q7pAb1OY6rwnnYFBa4vPqTVIDz1oibXhAvHLci0a/VfSp+NIOFdrnNb5iiT6ZnU61Owcq3RGbmltxTc+Ry7CSiOCXE/JgBTt1SEmZwL00BoexwYMcB9PBpBzWg/o++UXJelioQNcARBhGXaGeF2VtHcMxB8aCSgu6QyW4pNi4Be+Ws7Mw+/+TT/b55x6tpXbk11T1UvQYURWeu4DOym5JvVieo255Tvrm9xmGxBs
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5730.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?OAIqrIZEpNqNCjGx4T7cLI8tdGajuAvjCUg9BkjCzfMHg1JcW2859vbbxZx8?=
 =?us-ascii?Q?sRUDN9yZpvL8Nd9izfn5rZICHrdUXRAnGxwqcJX6hIn9pK5N+GOaoyfB+wUQ?=
 =?us-ascii?Q?sPjG57IF7PQRGyJBAPfazMhKmjlCm/uM/KK4jjfpFoO27gqByGMG0LVK5LoY?=
 =?us-ascii?Q?vKXdwH4YPtIngDilGs+NbRoHwqV+nyJRDuJAwRMUHwi2jk+WJtre4Vsfqewd?=
 =?us-ascii?Q?SUB4fmz/RqPpJuDljJ6A6G5jA9WuUbzWktUypTUVkQhEoeorJDwM8+wLcIum?=
 =?us-ascii?Q?a9oiKd6+18hgrFCvWrNj1TJRhFxFhqkO9n/dgGLH4tWzEuOBoV+fK4SJpGAi?=
 =?us-ascii?Q?rS4ZkrfRB8WCTPChozuNOFZ4oUh3S+lB12D8W0J/KJqduy8obHoqyVoBMlzR?=
 =?us-ascii?Q?JPCVMbv71sCYy2pb+azVeX43/SFRsaAfD9qjqNEuamO5yj30/3d2K38zgx3m?=
 =?us-ascii?Q?cqPWD5HtmG8jfClc1sf9dqkHrzPONOIsTGZ0pIl+D1A9tqIpM9qvIggN2Mu8?=
 =?us-ascii?Q?W5GtK1Gq4iGZYCco/6d41VL+zG2nJxs0feLsKXtiKjx1Fd+76QYbIMpv4nJU?=
 =?us-ascii?Q?QynV1TVFTz2MD6VRhpftEAhPPTi3bDnLSp2xSCG+W7DoSWCWgsaHu9Ap1i82?=
 =?us-ascii?Q?HKDYkLnddUOW2d+DRZCny+4cAkDVh30jebzs6yFElsBrPSK3fkZ+SasenHED?=
 =?us-ascii?Q?dfgZO7hRPfZH3MEVwchug2/ARmbOGBn3v8HmhWyUrBHoJj+57zzPhz3ikna6?=
 =?us-ascii?Q?wXBJUT4OnpTFh2lznOkBs9lkTCyqgX1qTdFQTT3j/EsQTmrH6Rmzzth+WUkf?=
 =?us-ascii?Q?E4LtilUd02Mix3I7lFznbdFUhmeVs96gCn0ATPc2ngnT/2mcSwmqryqDNzQk?=
 =?us-ascii?Q?22q465GPPQMAtm2QiE8LmYkYtH1lfVe2Bpsllvff2xlublYmJIQJKhXVO+K7?=
 =?us-ascii?Q?S6pskxhpVs+NEij2xvFIBbTMx4dexqlkrLESnL9tbLMuSpM0jsCj1dhF1noL?=
 =?us-ascii?Q?TWqVhXwLAjFix+8Y1L7ceEUqrSCibBE719taBXMEvxluFZVDKyOLpiwJh+LM?=
 =?us-ascii?Q?67EFtNJzoJIqy1AInwT1r1MMrUmdAAeB2RCYNSbOKQS9CLC++YK1lG77HFBm?=
 =?us-ascii?Q?yHb/m70hcjzZ06CwageAPhu7m/lqhyMceGG4R5MN0HbU8n9lX1WzfV23vOAy?=
 =?us-ascii?Q?LGGj3m8YaPgkp75lof75e4SBoyiQanlfmPuUk2PHBWT03/x4mWihmyr7tz/R?=
 =?us-ascii?Q?Zuchn0+34c/uMMT5Bt5dnQiuO5yab1z7YUWosM+0nZS+agOtXr540zYUQHjs?=
 =?us-ascii?Q?UdJ0wUOPaQtjNwrcVFuw7FrGrPiVwirJaWqOhbG37yVt9X9QyhaqCqNfXt3W?=
 =?us-ascii?Q?cTjElHefbsJwcc1kMIrfBj+QbMda9B+wPS9vvVxd+D+t7neIL1DAu4dhZPca?=
 =?us-ascii?Q?u56i5PatG/DfOR+0eDZ22L3QnPgrGDCUIwOoWee5PbEJC66GEdrEG4i+Y9uY?=
 =?us-ascii?Q?h+S8eSlgYmizNAzvhjL2ojAUV5/0y0jPgdfjhQxnfGKE6cRJ8TuyXLHzxNYz?=
 =?us-ascii?Q?46iHVqITCxz+KZ+KIaE=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: beb6a631-b263-4f05-a8b1-08dc39ee7f6d
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5730.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2024 12:52:48.3880
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9i22GnPp8cSnBoI/74f0NNZdEueHcXQsaUUfVlsBPfD/a2QBot0NvFfx/TJlrQ5j
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5716

--=_MailMate_3C9A0395-3E51-410F-87CC-F1244AC147F8_=
Content-Type: text/plain

On 1 Mar 2024, at 5:33, Ryan Roberts wrote:

> On 01/03/2024 09:51, Aishwarya TCV wrote:
>>
>>
>> On 26/02/2024 20:55, Zi Yan wrote:
>>> From: Zi Yan <ziy@nvidia.com>
>>>
>>> It is used to test split_huge_page_to_list_to_order for pagecache THPs.
>>> Also add test cases for split_huge_page_to_list_to_order via both
>>> debugfs.
>>>
>>> Signed-off-by: Zi Yan <ziy@nvidia.com>
>>> ---
>>>  mm/huge_memory.c                              |  34 ++++--
>>>  .../selftests/mm/split_huge_page_test.c       | 115 +++++++++++++++++-
>>>  2 files changed, 131 insertions(+), 18 deletions(-)
>>>
>>
>> Hi Zi,
>>
>> When booting the kernel against next-master(20240228)with Arm64 on
>> Marvell Thunder X2 (TX2), the kselftest-mm test 'split_huge_page_test'
>> is failing in our CI (with rootfs over NFS). I can send the full logs if
>> required.
>
> Just to add, I took a quick eyeball and I think there a couple of potential issues:
>
>   - In create_pagecache_thp_and_fd() you do *fd = open(testfile, O_CREAT ...);
>     where testfile is /mnt/thp_fs/testfile. So if /mnt/thp_fs doesn't exist,
>     then the open will fail I think? I'm pretty sure that's what's happening on
>     our CI. Suggest the test needs to setup this dir itself. Is thp_fs a mounted
>     fs or just a dir? If the latter can you just mktemp()?

The former. the page cache folio split tests require a file system supporting
large folio and I used XFS.

>   - Later in create_pagecache_thp_and_fd() you fail the test if you don't have a
>     filesystem that supports large folios. Can we turn that into a skip? That
>     would reduce noise on the CI.

I can do that. But is this a new requirement that self tests have to be finish
in CI/CD environment? Can you provide a guideline for it? Since I always assume
selftests are just ran by human who can set up environment. In addition, I do
not think it is realistic to make the test file to set up all the environment,
since everyone's machine is different. It is much easier to make the CI/CD
environment to make the mount.

>
> Thanks,
> Ryan
>
>>
>> A bisect (full log below) identified this patch as introducing the
>> failure. Bisected it on the tag "next-20240228" at repo
>> "https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git".
>>
>> This works fine on  Linux version 6.8.0-rc6
>>
>>
>> Sample log from failure against run on TX2:
>> ------
>> 07:17:34.056125  # # ------------------------------
>> 07:17:34.056543  # # running ./split_huge_page_test
>> 07:17:34.056839  # # ------------------------------
>> 07:17:34.057114  # # TAP version 13
>> 07:17:34.058564  # # 1..12
>> 07:17:34.156822  # # ok 1 Split huge pages successful
>> 07:17:34.214074  # # ok 2 Split PTE-mapped huge pages successful
>> 07:17:34.215630  # # # Please enable pr_debug in
>> split_huge_pages_in_file() for more info.
>> 07:17:34.225503  # # # Please check dmesg for more information
>> 07:17:34.225862  # # ok 3 File-backed THP split test done
>> 07:17:34.236944  # # Bail out! Failed to create a file at /mnt/thp_fs#
>> Planned tests != run tests (12 != 3)
>> 07:17:34.237307  # # # Totals: pass:3 fail:0 xfail:0 xpass:0 skip:0 error:0
>> 07:17:34.237620  # # [FAIL]
>> 07:17:34.246430  # not ok 51 split_huge_page_test # exit=1
>>
>>
>> Bisect log:
>> ------
>> git bisect start
>> # good: [d206a76d7d2726f3b096037f2079ce0bd3ba329b] Linux 6.8-rc6
>> git bisect good d206a76d7d2726f3b096037f2079ce0bd3ba329b
>> # bad: [20af1ca418d2c0b11bc2a1fe8c0c88f67bcc2a7e] Add linux-next
>> specific files for 20240228
>> git bisect bad 20af1ca418d2c0b11bc2a1fe8c0c88f67bcc2a7e
>> # bad: [1322f1801e59dddce10591d602d246c1bf49990c] Merge branch 'main' of
>> git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git
>> git bisect bad 1322f1801e59dddce10591d602d246c1bf49990c
>> # bad: [a82f70041487790b7b09fe4bb45436e1b57021d3] Merge branch 'dev' of
>> git://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git
>> git bisect bad a82f70041487790b7b09fe4bb45436e1b57021d3
>> # bad: [ce90480b9352ba2bebe8946dad9223e3f24c6e9a] Merge branch
>> 'for-next' of
>> git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap.git
>> git bisect bad ce90480b9352ba2bebe8946dad9223e3f24c6e9a
>> # bad: [5daac92ed3881fd0c656478a301a4e1d124100ee] Merge branch
>> 'mm-everything' of git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm
>> git bisect bad 5daac92ed3881fd0c656478a301a4e1d124100ee
>> # good: [acc2643d9e988c63dd4629a9af380ad9ac69c54a] Merge branch
>> 'mm-stable' into mm-unstable
>> git bisect good acc2643d9e988c63dd4629a9af380ad9ac69c54a
>> # good: [0294de8fe7d7c1a7eddc979cbf4c1886406e36b7] Merge branch 'fixes'
>> of git://git.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply.git
>> git bisect good 0294de8fe7d7c1a7eddc979cbf4c1886406e36b7
>> # good: [83e0c8f0e777a1ef0977b2f8189101765703b32d] Merge branch
>> 'mm-nonmm-stable' of git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm
>> git bisect good 83e0c8f0e777a1ef0977b2f8189101765703b32d
>> # good: [a739cbe236e0dd3b6ff26a01fa1d31c73d4fac93] mm: memcg: make memcg
>> huge page split support any order split
>> git bisect good a739cbe236e0dd3b6ff26a01fa1d31c73d4fac93
>> # bad: [efb520aa333b2f11daaaaa13f4a598b5ae4ae823] mm: allow non-hugetlb
>> large folios to be batch processed
>> git bisect bad efb520aa333b2f11daaaaa13f4a598b5ae4ae823
>> # bad: [2258bdebb55e3ad3d30fd3849ddb955ff36825de] mm/zsmalloc: don't
>> hold locks of all pages when free_zspage()
>> git bisect bad 2258bdebb55e3ad3d30fd3849ddb955ff36825de
>> # bad: [7fc0be45acf2878cbacc4dba56923c34c3fd8b1e] mm: remove
>> total_mapcount()
>> git bisect bad 7fc0be45acf2878cbacc4dba56923c34c3fd8b1e
>> # good: [d55fac55da2f87ad5a99178e107df09770bbc411] mm: thp: split huge
>> page to any lower order pages
>> git bisect good d55fac55da2f87ad5a99178e107df09770bbc411
>> # bad: [4050d591c1aaf9336c08511fa5984827186e9ad1] mm/memfd: refactor
>> memfd_tag_pins() and memfd_wait_for_pins()
>> git bisect bad 4050d591c1aaf9336c08511fa5984827186e9ad1
>> # bad: [c0ba89c29ef559c95273feb481b049f622c43c17] mm: huge_memory:
>> enable debugfs to split huge pages to any order
>> git bisect bad c0ba89c29ef559c95273feb481b049f622c43c17
>> # first bad commit: [c0ba89c29ef559c95273feb481b049f622c43c17] mm:
>> huge_memory: enable debugfs to split huge pages to any order
>>
>>
>> Thanks,
>> Aishwarya


--
Best Regards,
Yan, Zi

--=_MailMate_3C9A0395-3E51-410F-87CC-F1244AC147F8_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEE6rR4j8RuQ2XmaZol4n+egRQHKFQFAmXhz54PHHppeUBudmlk
aWEuY29tAAoJEOJ/noEUByhUXg8QAIA/tXQQRXYzvg2K3/xq2hdCiUtljCgMTdJt
GZQYmZG60pFTA8jec6EfhjrDA6OJg3BD3Qjb42Jq9+ak0qsWeku/J50x0tuXVMZn
0jtW5u7hA+yqHsocXY6IqHa1VUuYMLy7C32i49XondfQhDlRsVHIGA0vf1Oi9YSa
P+PIUYonCBa3vKWT4irYmjE58wpZKevbgqueJ8y+ebOV1qS6Fpmdf6QLagaEk3BG
g4Z97tu5WIRvnhlyjCYMr1q0F3gViUxSmTbhocYkTUAO7cbMWUnQjp7QlC1troEX
cVXDC6kEmbDnY4ddPBCU3IEo+KlA9IhNCUjupeFSddOtRblAeRxfamzoOT5Gpia1
DqYg3TWY5tR8TBGuF1h+yzwRXDWO0Fwg7sjDyksR40XEjN8PvlAKQqS21jC1CYuj
Sz5OamZaPmpl3BcB1FOHoucdaEoiJ49m15YWDBwOFlYEauv1vt3BWGq7AeNAW0rA
6moMDIozSeNacrMCjmcASYqdQQRwfT3+EvdgNjlOrO0fdPsl+iG++MgjOZdA2Gbu
FnJaBkML73RQy9oNW+8OKL4M2bA59sB9SpWisE933k8casEV5e0lGlgrlevXqwzE
+UuXBD8pPDA4TXeXnpigTmkufhJfM2Yj69BRxt1hB+cCYKcKwXH2V08Svl46qmib
Y+jtq+WS
=uu3/
-----END PGP SIGNATURE-----

--=_MailMate_3C9A0395-3E51-410F-87CC-F1244AC147F8_=--

