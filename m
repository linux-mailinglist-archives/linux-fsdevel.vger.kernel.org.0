Return-Path: <linux-fsdevel+bounces-13284-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A950A86E2C8
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Mar 2024 14:53:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 306C81F25529
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Mar 2024 13:53:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D84A6EB7A;
	Fri,  1 Mar 2024 13:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="N/CdCukL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2072.outbound.protection.outlook.com [40.107.102.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 900C75F84C;
	Fri,  1 Mar 2024 13:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709301193; cv=fail; b=OFMlp6UNR7M94ZmacyuvbFemCAtzLS422QHl5Qm9bAUpjqugvWYh7zQINck+nhkww4gnQe1yeB6o6ClxyoIUp0DS2B5g+t64cIg1vkMmGDH57WP6L8tTe74AAgXBCmwxpI6e+ujbjQ/dazE2HKN+jpcOzm5/9V/A2vGrEIvYSt4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709301193; c=relaxed/simple;
	bh=H2f6lO1cOLy3gCSmiLTE1LrRbCXJOzoscDPyjC7UCHM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZzP4hWuJoBZnRH1OUHf83WULE/wGRvj478+wl5crAxRPEKQwlyeLButZMj22dBGcJvv4tDU2LW/Ek3VC2Ig0hv94592tRbmCzZ1F4MTh5ldZ5csGA6z9rUVDZ0jWVSg+/W/wsQQw09phrpCXytmaOvUURshEmcy1iVasb3hRlGk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=N/CdCukL; arc=fail smtp.client-ip=40.107.102.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OpoL/ZvqSzYzUq9Lp/WP3lDHjOqaHlY0/n+FbiBcG7VeoTv9dSwJdgbl5KrcF1zUqOun93X9YE5DugovJKM47ARIaAmZA806RwnGFzTxPS6qSc71vZt0I24mwiy+CtuCuF6ohNfPJxJBicjAownTUnMD+h0c+JDNHlff95/awJOpL9K+hpdomtGuA+ppwkEW3oc7/j15++fFHlgzvGlhPwUiv0i6vvJM4wgYBDk964JAZ9NwmaocBQGZCdHXmNcV+TPAirbL6OrfUdmimq6LET8hJszqtP6KVnlIXZQsZBp0hWs9X/6nZPQGvUGvv7JOmx3JU3KMWheQQlBSU3T2dA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qwJ2VWhQT4Ew5KWJivFONBbR7z5k5C3uFTfwiWcNnzA=;
 b=PYW6pb6TTGQxNHI9Yc2leQc+6WF/P4Wt3ZL5CPeHSF4eo67D03i6AyGZMx5cQasuelb/yJJV819lM51YP8EG/v2hGJ4L/b25CobxdYqtGckXeJ5f3IxzThdTlRfIWHSvosilloANaEjKCUkDfhsUQw30H/F7Mb7PRX7aNaq651jH/mjixtAzw9lqsPdB4jbB9WfW2IFh9KXOKE36An1sl9rFtm7f5tZKdQuhK8LlWuxRx9BCxyRfZzYYtkBigUSJXmpisZrZB7RYiu+fCmCdH+HyH+KIWhRhU46uzDwYrNG9tneg8BtdFHh0RU/QCkn75pnKKFPmCiI8H/SbvXlIVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qwJ2VWhQT4Ew5KWJivFONBbR7z5k5C3uFTfwiWcNnzA=;
 b=N/CdCukL6407VsU2C+pznrZItrHHBl1ziRtGuuLAZyw6FYRIV33pclRaGMJg1bXlmTXsrFeFaxUqbeWLVy1B3O/gjvRJV80EoLleI+ym0fTQv0hVV+F/2L08St+OivPthEoFpPrBNV76tEh6MqZNCAHpuQhJdSPdgNw6LSxszaepmoNqcov08eSMnEJV/Aj+8jMdTQ32cS+yDYB05ajPVy+G74lTnPmP0hI/U+Kgb6Re8WOV9E3MrBqWKg4J3ZaS8MuNaTZuuY9h4RPLpv1VXeVy8ntHIOhmnblp8n3Fgi4g1jycpshXxKS33xtkmCOCRjmcr0gDPOZAhtJD/TuI2A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB5744.namprd12.prod.outlook.com (2603:10b6:8:73::18) by
 DM3PR12MB9436.namprd12.prod.outlook.com (2603:10b6:8:1af::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7316.46; Fri, 1 Mar 2024 13:53:09 +0000
Received: from DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::dc5c:2cf1:d5f5:9753]) by DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::dc5c:2cf1:d5f5:9753%6]) with mapi id 15.20.7339.033; Fri, 1 Mar 2024
 13:53:08 +0000
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
Date: Fri, 01 Mar 2024 08:53:05 -0500
X-Mailer: MailMate (1.14r6018)
Message-ID: <3D5A5D18-0A20-4BB3-B667-0CB5799BA665@nvidia.com>
In-Reply-To: <f7a3d07d-290b-46d6-884e-fa288901c3c6@arm.com>
References: <20240226205534.1603748-1-zi.yan@sent.com>
 <20240226205534.1603748-9-zi.yan@sent.com>
 <082e48c8-71b7-4937-a5da-7a37b4be16ba@arm.com>
 <0dab0c69-2eac-4e65-9efe-e0b037499abc@arm.com>
 <08703C70-DD6E-446A-9ABC-BC2C8E33B8CD@nvidia.com>
 <f7a3d07d-290b-46d6-884e-fa288901c3c6@arm.com>
Content-Type: multipart/signed;
 boundary="=_MailMate_E1349896-8AFE-4A72-B234-23E8281EA51E_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: MN2PR13CA0036.namprd13.prod.outlook.com
 (2603:10b6:208:160::49) To DS7PR12MB5744.namprd12.prod.outlook.com
 (2603:10b6:8:73::18)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB5744:EE_|DM3PR12MB9436:EE_
X-MS-Office365-Filtering-Correlation-Id: 69b78ad6-218b-4957-1a06-08dc39f6ed4d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	LWlVHabEj0j0SK7LOjCulvy34Kq/LCgtrUBheSiN9UL3U9re3xtmorEB3YckSn6qRzri0C+rG/8+zJWn8+CSJq5XK2oKqbfx8aIH8sxbMBCWryZhs9b9GzHcg20nclp0L1LyFY8WnGsDHHfzNDwcgwl7YDTPi53wUX8s+FLMTcbkUUajAn7UOOQ47EZqXEZJgC8QPbjC+rIta+usNFqf69WPfwBdtjr3QUxYeHmXJPZYQk47H6LW0iOgTz0Y5xampGGc2IbIEzI9JZi/1nSiGrH65HO738BFRQ7/w/Py5DU9Rjq54t9nT+YtPEuFD9gK12OhJCxvylznb2BI+GJUQ61N8LZxABeYE9LreEku0qRRCwKCaAdXe5P/Ug+Tbuk3pIWXIxIhPqAHcIHGzLKYT5BCQ0g7m5eoVioMaxrw7t6/d5J7xyaHrePqMJu4dBFPGFMgwOyj3KQZ5hj3l3RYdCWBcCd9oObpaPg9XLoq0UuXxridwZB++ZMqXg+CBGIgUNJSk7DRSUOwq2ZXEVr9rB7IWQz+uyNXImqLLNRY0d/MS8TENzDpQ/g585oVwHw0TtJmgczr841ifIAq2Cgk1Y26EatQCn0VjX4qtarvFkAW+r3zA3fgApyOuj26V51UNK4Q55hDi+8D49btf/l63w==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB5744.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?s2AxthMD2ARfv1FZXwmKwk/4UGKK75YUnX3Ug/IXDLqvW9sn3xaRfljSAN7w?=
 =?us-ascii?Q?HPpORv7JWM2rZzq081YehkgPAuokpbqkucowvk1RQ+gwFioknk+ThBVdvfSD?=
 =?us-ascii?Q?HWTjmfI1oAWATJnS13Ad9fNsT5VkqcsPCKcprwUZolWVCxHsqFiiIfYmYaUF?=
 =?us-ascii?Q?XEa/lFdXyPqxjK1z7V1D2uotIWFvXcVqs1eAq/Z3rt/vwO2Zn3LI82Nqky+8?=
 =?us-ascii?Q?d3t+Kj3JBkh6MHqWxRXSwDEOGGx+fFzQb7GQYbECDp2Wi76LN3PnMZEaYmUV?=
 =?us-ascii?Q?/BCBKop+8dSd9zjF/oT0Ml+z3kEhirOqR3cmPXPN3AhZKAtAKj1HPmTKTV2j?=
 =?us-ascii?Q?z64vkkxwPEFGsy+0hw5LlFj7mzu7AmbnP+dqj5rsdG0oaBLmNXBd17D7cpm5?=
 =?us-ascii?Q?kOT/lfeDVSCfyihSO7GyizlP8zWgl1Tm86SfeBfMNKdGU3s81/NNu5jGbWHF?=
 =?us-ascii?Q?DG6IuXNIW6JEMiwbOiwCVyvwJBN1aT0dHBcWVpbD4oDFCFuXOvWIbmP0mYUN?=
 =?us-ascii?Q?3OZmDndEnOg+2xQI6CWhABfKTz8XTFVDGVa3mDZ7WevNVsKZjta84hh/mhHj?=
 =?us-ascii?Q?s10cOlcedIoNxh4HpoaLi1VkzOWCO/+gaHesZZDQGNvOZ+7YCkDpH2J2LcBg?=
 =?us-ascii?Q?9asvE0dn0qZOXkjeh4JaTq9yzhYMoBI8c1WYRfs65/N8wSuAA8w7ansINRBE?=
 =?us-ascii?Q?FNKa4qfFbi3nDkXCH/AS3PYJXDPNNpK6uC/o6qpZez12GVVxK1ryMPQ/rsQx?=
 =?us-ascii?Q?GlmWYsUl0EHQ5ddDbVmDnsb8YuszqwXcAV1PBRQxqn9m5iCK/+rriQ9G2e5p?=
 =?us-ascii?Q?s6/Y7Q3FnfjOAlkCPw9G3mMJHBak+7lt1cePF/h4hEfBzCqnBIYdC7+1roAY?=
 =?us-ascii?Q?GK6xHiiUBJVap5E43HA+cdKBHKmGylid9Zj8H5t+GRi3RfFBcnNkXoH2uOdt?=
 =?us-ascii?Q?KSLiIEp//Kx2eKi0tl/0pLJEsvzfVNLHqewkIqCzhsjSf/EI4ftAmGP+ResX?=
 =?us-ascii?Q?seU015f1+vTrBAyXGwaIE3PvsCf5dvBa1c83bIhDy9RWowXO+S1Z3BVdRWJz?=
 =?us-ascii?Q?F/FnEQFpJ8i7cIa5wcC6TD1QC9Jst1XEtpaxWG+j6nTaf+GCD7aVstoYWOlE?=
 =?us-ascii?Q?3x1oZm/4XS7JHfWjMVRoq0gwco8DM1HKfWydA3RfOgm6pEeg4ZlHZZy21Fgn?=
 =?us-ascii?Q?OaatDsvhBFUAykdOjg3RRqPu6yRCEoRs4/yXOjGqIOnI6zFcia/9u12BjxVu?=
 =?us-ascii?Q?MrYMoWsDqzci6nETCTDfhKIMT7+MITgJyJ4eqxSruzl43WgR0Xb8SO4ymL0P?=
 =?us-ascii?Q?6iSFmFZmyHVWFo2/HpQ1sT02IKthuO3kyiVgP72VJgNkTih4pS6BU48v3cK7?=
 =?us-ascii?Q?KFjETpemO81Ce3GTXldxiKxlgEOc/nw0q4cuBiCAbKCHnsY3H3q+/00Bww9S?=
 =?us-ascii?Q?WFr0npliBETXlrc/gTuViyF5oZULfgZ062NuelN7WTKFEsbT5OKdqbSIozs3?=
 =?us-ascii?Q?mi6MEhvBAtQE2IlG4HZ/OYs7gpMJNLcA0c8VaHF8rr4c6JFgh/7z1S5ETmA7?=
 =?us-ascii?Q?pB74JqFi8Ry1z73wDIq+paoYHCbxd3P0Az/BxMtx?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69b78ad6-218b-4957-1a06-08dc39f6ed4d
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5744.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2024 13:53:08.7536
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QHmuP3ZP1DtMrCKDr5cW/i8v9CDyvQ4IQyJu6aFtraWCLZc4hRJcEqo68IKGbtSX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9436

--=_MailMate_E1349896-8AFE-4A72-B234-23E8281EA51E_=
Content-Type: text/plain

On 1 Mar 2024, at 8:09, Ryan Roberts wrote:

> On 01/03/2024 12:52, Zi Yan wrote:
>> On 1 Mar 2024, at 5:33, Ryan Roberts wrote:
>>
>>> On 01/03/2024 09:51, Aishwarya TCV wrote:
>>>>
>>>>
>>>> On 26/02/2024 20:55, Zi Yan wrote:
>>>>> From: Zi Yan <ziy@nvidia.com>
>>>>>
>>>>> It is used to test split_huge_page_to_list_to_order for pagecache THPs.
>>>>> Also add test cases for split_huge_page_to_list_to_order via both
>>>>> debugfs.
>>>>>
>>>>> Signed-off-by: Zi Yan <ziy@nvidia.com>
>>>>> ---
>>>>>  mm/huge_memory.c                              |  34 ++++--
>>>>>  .../selftests/mm/split_huge_page_test.c       | 115 +++++++++++++++++-
>>>>>  2 files changed, 131 insertions(+), 18 deletions(-)
>>>>>
>>>>
>>>> Hi Zi,
>>>>
>>>> When booting the kernel against next-master(20240228)with Arm64 on
>>>> Marvell Thunder X2 (TX2), the kselftest-mm test 'split_huge_page_test'
>>>> is failing in our CI (with rootfs over NFS). I can send the full logs if
>>>> required.
>>>
>>> Just to add, I took a quick eyeball and I think there a couple of potential issues:
>>>
>>>   - In create_pagecache_thp_and_fd() you do *fd = open(testfile, O_CREAT ...);
>>>     where testfile is /mnt/thp_fs/testfile. So if /mnt/thp_fs doesn't exist,
>>>     then the open will fail I think? I'm pretty sure that's what's happening on
>>>     our CI. Suggest the test needs to setup this dir itself. Is thp_fs a mounted
>>>     fs or just a dir? If the latter can you just mktemp()?
>>
>> The former. the page cache folio split tests require a file system supporting
>> large folio and I used XFS.
>
> OK got it.
>
>>
>>>   - Later in create_pagecache_thp_and_fd() you fail the test if you don't have a
>>>     filesystem that supports large folios. Can we turn that into a skip? That
>>>     would reduce noise on the CI.
>>
>> I can do that. But is this a new requirement that self tests have to be finish
>> in CI/CD environment? Can you provide a guideline for it?
>
> I'm not sure what's written down, but certainly anyone should be able to run the
> selftests with as little knowledge as possible, and they should only fail if
> they detect a real problem. By convention a test should be skipped if the
> environment (or kernel) isn't compatible. There are lots of examples of that in
> mm selftests (just grep ksft_test_result_skip). mm selftests also has
> run_vmtests.sh which does a lot of environment setup (e.g. reserving hugetlb
> pages, etc) before actually running the tests.

Got it. I will send a fixup to skip the page cache split test when the mount
is not ready, then send a separate patch to set up XFS in run_vmtests.sh and
pass it to this test.

>
>> Since I always assume
>> selftests are just ran by human who can set up environment.
>
> I believe kernelci have been running mm skeftests on x86 for a long time. We
> have started running them against arm64 on our CI for the last couple of months
> and it had found a number of real issues in the kernel in -next, so this is
> helping find and fix things early. So there is definitely benefit to keeping
> these tests clean and robust.

Got it. Make sense.

>
>> In addition, I do
>> not think it is realistic to make the test file to set up all the environment,
>> since everyone's machine is different. It is much easier to make the CI/CD
>> environment to make the mount.
>
> That's reasonable, but then the requirements should be documented and you
> probably would want to be able to optionally pass the mount on the command line.

Will do.

Thank you for the explanation.

>>>
>>> Thanks,
>>> Ryan
>>>
>>>>
>>>> A bisect (full log below) identified this patch as introducing the
>>>> failure. Bisected it on the tag "next-20240228" at repo
>>>> "https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git".
>>>>
>>>> This works fine on  Linux version 6.8.0-rc6
>>>>
>>>>
>>>> Sample log from failure against run on TX2:
>>>> ------
>>>> 07:17:34.056125  # # ------------------------------
>>>> 07:17:34.056543  # # running ./split_huge_page_test
>>>> 07:17:34.056839  # # ------------------------------
>>>> 07:17:34.057114  # # TAP version 13
>>>> 07:17:34.058564  # # 1..12
>>>> 07:17:34.156822  # # ok 1 Split huge pages successful
>>>> 07:17:34.214074  # # ok 2 Split PTE-mapped huge pages successful
>>>> 07:17:34.215630  # # # Please enable pr_debug in
>>>> split_huge_pages_in_file() for more info.
>>>> 07:17:34.225503  # # # Please check dmesg for more information
>>>> 07:17:34.225862  # # ok 3 File-backed THP split test done
>>>> 07:17:34.236944  # # Bail out! Failed to create a file at /mnt/thp_fs#
>>>> Planned tests != run tests (12 != 3)
>>>> 07:17:34.237307  # # # Totals: pass:3 fail:0 xfail:0 xpass:0 skip:0 error:0
>>>> 07:17:34.237620  # # [FAIL]
>>>> 07:17:34.246430  # not ok 51 split_huge_page_test # exit=1
>>>>
>>>>
>>>> Bisect log:
>>>> ------
>>>> git bisect start
>>>> # good: [d206a76d7d2726f3b096037f2079ce0bd3ba329b] Linux 6.8-rc6
>>>> git bisect good d206a76d7d2726f3b096037f2079ce0bd3ba329b
>>>> # bad: [20af1ca418d2c0b11bc2a1fe8c0c88f67bcc2a7e] Add linux-next
>>>> specific files for 20240228
>>>> git bisect bad 20af1ca418d2c0b11bc2a1fe8c0c88f67bcc2a7e
>>>> # bad: [1322f1801e59dddce10591d602d246c1bf49990c] Merge branch 'main' of
>>>> git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git
>>>> git bisect bad 1322f1801e59dddce10591d602d246c1bf49990c
>>>> # bad: [a82f70041487790b7b09fe4bb45436e1b57021d3] Merge branch 'dev' of
>>>> git://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git
>>>> git bisect bad a82f70041487790b7b09fe4bb45436e1b57021d3
>>>> # bad: [ce90480b9352ba2bebe8946dad9223e3f24c6e9a] Merge branch
>>>> 'for-next' of
>>>> git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap.git
>>>> git bisect bad ce90480b9352ba2bebe8946dad9223e3f24c6e9a
>>>> # bad: [5daac92ed3881fd0c656478a301a4e1d124100ee] Merge branch
>>>> 'mm-everything' of git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm
>>>> git bisect bad 5daac92ed3881fd0c656478a301a4e1d124100ee
>>>> # good: [acc2643d9e988c63dd4629a9af380ad9ac69c54a] Merge branch
>>>> 'mm-stable' into mm-unstable
>>>> git bisect good acc2643d9e988c63dd4629a9af380ad9ac69c54a
>>>> # good: [0294de8fe7d7c1a7eddc979cbf4c1886406e36b7] Merge branch 'fixes'
>>>> of git://git.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply.git
>>>> git bisect good 0294de8fe7d7c1a7eddc979cbf4c1886406e36b7
>>>> # good: [83e0c8f0e777a1ef0977b2f8189101765703b32d] Merge branch
>>>> 'mm-nonmm-stable' of git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm
>>>> git bisect good 83e0c8f0e777a1ef0977b2f8189101765703b32d
>>>> # good: [a739cbe236e0dd3b6ff26a01fa1d31c73d4fac93] mm: memcg: make memcg
>>>> huge page split support any order split
>>>> git bisect good a739cbe236e0dd3b6ff26a01fa1d31c73d4fac93
>>>> # bad: [efb520aa333b2f11daaaaa13f4a598b5ae4ae823] mm: allow non-hugetlb
>>>> large folios to be batch processed
>>>> git bisect bad efb520aa333b2f11daaaaa13f4a598b5ae4ae823
>>>> # bad: [2258bdebb55e3ad3d30fd3849ddb955ff36825de] mm/zsmalloc: don't
>>>> hold locks of all pages when free_zspage()
>>>> git bisect bad 2258bdebb55e3ad3d30fd3849ddb955ff36825de
>>>> # bad: [7fc0be45acf2878cbacc4dba56923c34c3fd8b1e] mm: remove
>>>> total_mapcount()
>>>> git bisect bad 7fc0be45acf2878cbacc4dba56923c34c3fd8b1e
>>>> # good: [d55fac55da2f87ad5a99178e107df09770bbc411] mm: thp: split huge
>>>> page to any lower order pages
>>>> git bisect good d55fac55da2f87ad5a99178e107df09770bbc411
>>>> # bad: [4050d591c1aaf9336c08511fa5984827186e9ad1] mm/memfd: refactor
>>>> memfd_tag_pins() and memfd_wait_for_pins()
>>>> git bisect bad 4050d591c1aaf9336c08511fa5984827186e9ad1
>>>> # bad: [c0ba89c29ef559c95273feb481b049f622c43c17] mm: huge_memory:
>>>> enable debugfs to split huge pages to any order
>>>> git bisect bad c0ba89c29ef559c95273feb481b049f622c43c17
>>>> # first bad commit: [c0ba89c29ef559c95273feb481b049f622c43c17] mm:
>>>> huge_memory: enable debugfs to split huge pages to any order
>>>>
>>>>
>>>> Thanks,
>>>> Aishwarya
>>
>>
>> --
>> Best Regards,
>> Yan, Zi


--
Best Regards,
Yan, Zi

--=_MailMate_E1349896-8AFE-4A72-B234-23E8281EA51E_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEE6rR4j8RuQ2XmaZol4n+egRQHKFQFAmXh3cIPHHppeUBudmlk
aWEuY29tAAoJEOJ/noEUByhU+XkP/3e1IoSgXnZajmLEruKIyjBsp4W8MSZ1Sw+8
3DTlO4xM6BGB2humwoaR0ofekzcPIE0BXWpI9Jus89sIs+SYSyv7Y0JAfGyUs3Pq
pRSVFpGpRqUVNztc71qVP/hhal0liO/WeNs6lzt1CQ8acVR+Z37ha/nZYQC5G/VJ
IM8BLpJ/+kuJVzeBlQtK0hM+TyA96JdPEqyNh9N1ouAEgApFrPsINiLVoqnwFNpy
+x8kQ5m+tqftaJ8kBC73zZ2bV+QP1cYibaWLKqBzc6Rfmdzm8IQFBNzZGHrd0jTP
1vLL7+1oRo2+B9ZSJFANuorqrZBXmVe6yav33UaIl0NNH0Byy0Q3PkrCH10cAzO4
jh4z7FSrOqOfKhGFU4Z1VAd6FNRb5+tDfiUxFkrfC12Dw2nxrT/2OCMtW37YpfOK
adegbsEV5sGSjj1l8N84w+pYcGRhOoV4qXcFaC3vVtzaD2BVeH9Rk8/SGG2+QYm4
duyqcIYc4yYvv2y5NJwpHHWUiGGPpcgaSi9oLEYmlolKVDiSS0RHyIrf8mof/eyV
MOi+wQhZKMiGP3Y/s3OrPA0RQEWmCQbfc4Cu02+UAPRvpSsrSj8KQW+XPBzmzTFS
YqDk5DDIrQ5Cz6GVGKc/CtHPDpDgr5q96TAR4QuTYKuHNoMHIzwD8TFAE0n49YxW
CKHA3/pk
=JfMx
-----END PGP SIGNATURE-----

--=_MailMate_E1349896-8AFE-4A72-B234-23E8281EA51E_=--

