Return-Path: <linux-fsdevel+bounces-13292-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD41D86E35A
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Mar 2024 15:33:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B41F21C224E4
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Mar 2024 14:33:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52B8523DE;
	Fri,  1 Mar 2024 14:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="WtDNOULp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2082.outbound.protection.outlook.com [40.107.100.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B686C394;
	Fri,  1 Mar 2024 14:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709303611; cv=fail; b=mBSLoIKmoJ4oBwveQBGqgeEKllnmdBApTTKcyi7qckbuHXjAb7sbXf4SD6NTZRv/DROjwrVAxlWx/hknLKxFfYpOybgwiBUUJ5RxEVeobUzlMsz8N5UtTwHNCjODoHJLOaAhVnzKXCCKbSZC6BsjfOFnJ4zFBJBWyhfyj/XXG50=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709303611; c=relaxed/simple;
	bh=EVtudqrX1ef5Q45Y0qQBI1//Q7UZ4UDaD5RvbCOVF9I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cVH/AveSv4ODL25E9CabI0FcQkz4OAufHA+3QuAN8/7KloPsXvAKGT4M81yJPVGUcjFn6cRCDc2RXe1t4fQhWSwQFf3xKe4FqICmyNxt6nCkk1S1EcCicOMVs5nYHqDl277SbH7ioULFBonf20Q15xGuWIAM9Z6XaI3XnAbPhvA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=WtDNOULp; arc=fail smtp.client-ip=40.107.100.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eTfmcMjBGpUoLw0ntHLqju3jLxyzvtraVxu+2FwOVJWqaf+IX4yth5l09q1PUtXwLJRxDD5fM1ZJNsd5DV/BQ9LfdaAIGxdhtY/HsEFFIVOyKoITprStc3pEPHV5t1h84Pw/2Kny9hixhchEdXY7uzW5Ry3XRHrPdj9uPSoJ7sDmrE6EsxzqD2w2+gPo/HZejvOCHFKmfKhPsDjsw2MC60jtTWufo9zz1ROMYS++pk1Bj+gDRhswzHfAfqRdcdoANPiweQQJIZHdudVfyu83uY1b2WjZlD6Xh1IA5aHQn1SGl/AKRZHym3SnlD6xhbpSt+m2TCysMKQgZON0t1MsEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5hylb8FxyKcx77WRZVuAD8yeM9GbwyMXGZ2d0GJ3+qo=;
 b=GkANJpjEhRXE0seU1w7mxtfiERz2Kief+LZNHPRaAfrayZdPjtVUFdcfzb1KFyYzcmkVfxhu4kaBjz8T4e3f9yi0OxaJgWhi3ydGYZ8DqbZ/XDEXnTdYreVYA/21Fg6l/Fo9Rp3a4A4E/87cOFzv5yBJao2ru1SlWtnbZtnHUwcJCnfMjnDMj0yp8tyc4ZmSavYhKwUz/RCW4Dd91t23RiUeOVhvm5hQgA+Un1ULwCYwGiM67NqYNQB2334s9PMWL1xfsF++90O20tZbZX+liYvSaN+EVT0E8dIi1g1H+AGT42fzLMJRQnZulncesoajOGKGCaFAk0ApgE5EMVPxzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5hylb8FxyKcx77WRZVuAD8yeM9GbwyMXGZ2d0GJ3+qo=;
 b=WtDNOULpngwxovU8L2bEU7g+hUXrDmIWpazASJIaYtaFwo3uVkyVhcn92i0Lxw5+ByiZCOiPndQACRy72nCMOOOXHqswN2xcGSRUEm55WP/B/Iy9OAamVVeVJ7mEbWHqBLk+6U+bW15b+jmilnF9bz83eAJRdhbc33wUYnmUdN5bJNfIduWk2OWUMDF6zyt4XqyVRfsg/flrZiF8LX268drs8LAPdBTdvjmTccUAsMX5xig01QNWpQohDggDnxrW9ABaQr76JDrGWfWkpsGIT06XM62SwZisMq+NJDT8BQR2vBjeKHaAAoY46d3ZHpypLTecT3Dkem3mc7J6x649aw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB5744.namprd12.prod.outlook.com (2603:10b6:8:73::18) by
 MW3PR12MB4492.namprd12.prod.outlook.com (2603:10b6:303:57::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7339.34; Fri, 1 Mar 2024 14:33:26 +0000
Received: from DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::dc5c:2cf1:d5f5:9753]) by DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::dc5c:2cf1:d5f5:9753%6]) with mapi id 15.20.7339.033; Fri, 1 Mar 2024
 14:33:24 +0000
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
Date: Fri, 01 Mar 2024 09:33:21 -0500
X-Mailer: MailMate (1.14r6018)
Message-ID: <03588DEE-18D4-4186-B56D-D76E254F724D@nvidia.com>
In-Reply-To: <6645287e-d069-4c37-823b-d1b814ec0efe@arm.com>
References: <20240226205534.1603748-1-zi.yan@sent.com>
 <20240226205534.1603748-9-zi.yan@sent.com>
 <082e48c8-71b7-4937-a5da-7a37b4be16ba@arm.com>
 <2ED5C25C-FDB2-490F-B740-E413E8186C12@nvidia.com>
 <6645287e-d069-4c37-823b-d1b814ec0efe@arm.com>
Content-Type: multipart/signed;
 boundary="=_MailMate_FD5AA431-A00D-41BD-959B-5776C3AE19F3_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: MN2PR22CA0022.namprd22.prod.outlook.com
 (2603:10b6:208:238::27) To DS7PR12MB5744.namprd12.prod.outlook.com
 (2603:10b6:8:73::18)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB5744:EE_|MW3PR12MB4492:EE_
X-MS-Office365-Filtering-Correlation-Id: 6721e43c-3661-4b82-29ed-08dc39fc8d65
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	cNqa8kFQsYAQ4J7F8x3f9YG5evN8YWyMfsivjssdaYT8PB3F1Evk1lt71J5s5dNfkNBRKkQepuIfs3BcpqXhxySV6IDPNq9QCUzfXrdrvlAUg16S9gyet3K4TIb2LYyB9yrU37sqJYM64DcYmnSLSQ+zLM0XrEBGiv00U+dsIH8KHEe+0iuLUsYWc6kDE80mVR5b9nqWauf5is0ZUUW6cW0Hi/epC8ZVy+IfnyZafPPfEctVMjOaqG7qQR6dstAP4SG7YEtZQrW0DViduBXjyNPzcvQuHmNOH1tFymWcjy1xIh1nmqcY3yn1NDghOvnKU+c2zRGZyyB1VNxPXMq9RqoDoS1nXY30+wnVSgenN7ZxjCjje+5dLWdh6kv3l5assluiZIgeodFI3L6BGLt/U8ybpW3DF1CqGNGsN5tqZ4U7+m0PU6k+xLfJ3b+K9dUw5TdSk+N19M97GIHG7mFNU8eYItXf0kUFwsSpXA1j8OFeuEnIitsMJyQon7qtOQkbrluv3TGb9zW2KqDbXrbLmwQ1TcfmWRx33liajUi191Bd2epOMowVOjBxqiQtTQqLv2/uCjGx7yW3sF6Xw/XvXLSLg4zGjYHFU+x6xoOz6V6OrHA1BClfqkMmbO9FhLCfkhzqDtuP+PX65Xsqm/ld3g==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB5744.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OSsyOGtpREVxNkxqVzE5Tno2UzhQNzUzc1YzcGpBaDh6VWRjbm1zYmtHbW5S?=
 =?utf-8?B?NDVqUzdVNVI0Q3FTMFRXcjlNUjJ2UHpYTWJBWWNqeFhUUm41OGVoeHgrUFda?=
 =?utf-8?B?QkZZOXhzOHdIblk3ZGw4ZnNvNTN1SnpQaVh6akl2aHVmVTl5YWxicDlxNnNw?=
 =?utf-8?B?ZUZvTGxSV3N5OVA3Q1lvWm83cEFVWStlR0VFZFc2YUlSZjN3Y1FOUlJFQnhr?=
 =?utf-8?B?Y2JMNjZaeE1kS2xUZ1c3eTdKWWtXSWMyUjlLRkpUWjNYSTVPOHdkMHdkUFly?=
 =?utf-8?B?L094bzUrTnA0aXhuY3p5S3V1WGsyclgvWnc1bGt4ZENwaEQzV2pwSVpEK3RB?=
 =?utf-8?B?LzBlSEoxcFowUnRtc0xGK1oyVXRxQUowajdHWExCN1BRQzFuOU5EV1oxSkp0?=
 =?utf-8?B?a3diTnMrR2ltRzVBelc0NERGRHVuaWxJUTlmQklYNVY2Zmk2SjdjbFNWT1VN?=
 =?utf-8?B?bklRZnlGdHJFMmF6Vzl3SWxRajVuUVlHdHA4Q24zL2tUVFRkd3d3OGpFc3Jo?=
 =?utf-8?B?OUJteHZnTHlleVMzVTNBRHN0VjNFOEU3QmpCSnUraGJXNjU1NTM2UWdZY0x1?=
 =?utf-8?B?eHh3c3dhUng2TGVta1pHNDFiTlo1MTlNckNMbjNHVzVxc2wwMSsvb3dhS0s0?=
 =?utf-8?B?dG0xaWYxM0VkQVRwb1d6TE1DSHBnMERCaUlkdXJ4eEVhdHdyVU5VTjlOSDBJ?=
 =?utf-8?B?RTNrSm9NcmFXbVNsZFQzNUdWM3hxRjBheVpQYmw0amtiZHBKRk5rUi9abnVZ?=
 =?utf-8?B?VlFUSThQWnBHV1pXNytkYnZZT0hmZWs5ZU1CVDNUNUQwRWJOYlVMc0hRbGh1?=
 =?utf-8?B?dXpiWFVjVlFvSmFwMUZXZzlMSmppS1l0MVk4NHBvVnFaVlBtdzJYYVl1dVNS?=
 =?utf-8?B?M3dxQm9iZnBIYmdQQ0lYSll3WXkvK1ZhbksrWXZLRDlHSTEraWtqWnVRUGpr?=
 =?utf-8?B?T0dQQlFWVXZ0ZGpDMFgyU1Rqc0NLaFBnSWhpRFhZOGFQam5idERiMXlZUDhp?=
 =?utf-8?B?RVJkeVE0WmQrWG9ZMEtXeFMwd2RDTmtVR3crZnl2OVg4WGNyWHNWRGt4NFRi?=
 =?utf-8?B?Nk5HcmFyVWhyM1UyWlhPVG1RTkhZVGJ4bE5MM0M4TGRYWHhTY3hzR09mZ3h4?=
 =?utf-8?B?SFlud1E5dGJpaUE2eGJKT3NkMlhEbXVyUzMwcEY1aXplZExUVkE5ZTRKZldC?=
 =?utf-8?B?OVptQWYxd0lheUNiT3hjUmYxMlVkcHVUeC9HRXNlOU1RbW8vQ01aWDhiTEEx?=
 =?utf-8?B?K2d6Q05OOXhkTFlYZmpCbDlFWWtZM3JCbUpFak5KSy9oMHdmU3BQd0Y4cmtq?=
 =?utf-8?B?bUltazZKa0oyNWwwUmZOMW1PdFllQjIwbHFEQktJSW81MHNnU2VNMFpRejBB?=
 =?utf-8?B?d053aHVwaVN3VmNDRG5TYkRVY2NraTBaS2FOU1BwcnYyd0IyWS9xTThpeUdH?=
 =?utf-8?B?ekV3bUxtSncrbjVWUDVnMHNqUHJqeDhBK1FOLzBsckJmVmRneTJrMi9JZTdZ?=
 =?utf-8?B?aXhYNG1yUUwrVVRKQVJQY25tSmVkQkFmMGpIQzN5QnFMc0c0TkMvbTNTT3c2?=
 =?utf-8?B?MHFETERwdG5SM3B6cENLT0VsMy85L2p3YnZjdUlSM09BRmlNZHhsUXA1MnN3?=
 =?utf-8?B?NmJEZG5CbTQ1TXB0N1R0aHViSktxb2tyWnBhMHh3RmRKa1YxZWo0THh2cVYw?=
 =?utf-8?B?TTJyb21MdThJNUZUOWUrVEQ5ZFR6YmJCZ3M3ekEwYmhSRTJiancxNHVUbWl4?=
 =?utf-8?B?SjZINkJQS293VHM5ZmU3UVB1Nm1Edk5tamlGOHZaaHJYdEp3SE1NeHdzZ1RU?=
 =?utf-8?B?cmJGSXNqT3VQYW1mQ2ExYU90cUxkZ2pNOG5Jckp3cG93NEkyZ2I2Skk1am42?=
 =?utf-8?B?LzJwbjBnYWlYb1JzN1g5ZzRmM1BXeDJGZFY1L3g5a3paTEN6MEltanlzeTQ0?=
 =?utf-8?B?TFZrZHdnWXR5YnMvVWFwdThhSDJTbGZzM1I1ZUhaQVZaSStnQU9oWllIbDNL?=
 =?utf-8?B?WXNoelVxYThIaW5VeEJlaGJhQkpibzFlYkVnaEs0TGFGU21ZZ2YxVXFVL2RI?=
 =?utf-8?B?NTNqdUlUNlhPQjBpS2toOE4vS0xCVHd0WWduZ21oWFZlQUJaU2ZGSEw3ajRH?=
 =?utf-8?Q?7NBcX7FFzBy3wtpR6CTYLKhJS?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6721e43c-3661-4b82-29ed-08dc39fc8d65
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5744.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2024 14:33:24.7727
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FzQuW4FYNxHcU6HYtx/hYZexORZd0haezb8HrWTk6TwaG/PDflNdsVPsXGTq0Wno
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4492

--=_MailMate_FD5AA431-A00D-41BD-959B-5776C3AE19F3_=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 1 Mar 2024, at 9:23, Ryan Roberts wrote:

> On 01/03/2024 14:00, Zi Yan wrote:
>> On 1 Mar 2024, at 4:51, Aishwarya TCV wrote:
>>
>>> On 26/02/2024 20:55, Zi Yan wrote:
>>>> From: Zi Yan <ziy@nvidia.com>
>>>>
>>>> It is used to test split_huge_page_to_list_to_order for pagecache TH=
Ps.
>>>> Also add test cases for split_huge_page_to_list_to_order via both
>>>> debugfs.
>>>>
>>>> Signed-off-by: Zi Yan <ziy@nvidia.com>
>>>> ---
>>>>  mm/huge_memory.c                              |  34 ++++--
>>>>  .../selftests/mm/split_huge_page_test.c       | 115 +++++++++++++++=
++-
>>>>  2 files changed, 131 insertions(+), 18 deletions(-)
>>>>
>>>
>>> Hi Zi,
>>>
>>> When booting the kernel against next-master(20240228)with Arm64 on
>>> Marvell Thunder X2 (TX2), the kselftest-mm test 'split_huge_page_test=
'
>>> is failing in our CI (with rootfs over NFS). I can send the full logs=
 if
>>> required.
>>>
>>> A bisect (full log below) identified this patch as introducing the
>>> failure. Bisected it on the tag "next-20240228" at repo
>>> "https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git"=
=2E
>>>
>>> This works fine on  Linux version 6.8.0-rc6
>>
>> Hi Aishwarya,
>>
>> I am trying to fix the issue. When I am compiling selftests/mm, I enco=
untered
>> the error below when I run make under the folder. Am I missing any con=
figuration?
>> Since you are able to run the test, I assume you know what is happenin=
g. Thanks.
>
> for what its worth, I usually compile from the top level directory with=
:
>
> # make headers_install
> # make -C tools/testing/selftests TARGETS=3Dmm install INSTALL_PATH=3D~=
/kself
>
> Perhaps the below is due to the headers not being exported properly. Ba=
d things definitely happen if you omit the headers_install step.

It works. Thanks a lot!

>>
>> vm_util.c: In function =E2=80=98__pagemap_scan_get_categories=E2=80=99=
:
>> vm_util.c:34:28: error: storage size of =E2=80=98arg=E2=80=99 isn=E2=80=
=99t known
>>    34 |         struct pm_scan_arg arg;
>>       |                            ^~~
>> vm_util.c:41:27: error: invalid application of =E2=80=98sizeof=E2=80=99=
 to incomplete type =E2=80=98struct pm_scan_arg=E2=80=99
>>    41 |         arg.size =3D sizeof(struct pm_scan_arg);
>>       |                           ^~~~~~
>> vm_util.c:45:35: error: =E2=80=98PAGE_IS_WPALLOWED=E2=80=99 undeclared=
 (first use in this function)
>>    45 |         arg.category_anyof_mask =3D PAGE_IS_WPALLOWED | PAGE_I=
S_WRITTEN | PAGE_IS_FILE |
>>       |                                   ^~~~~~~~~~~~~~~~~
>> vm_util.c:45:35: note: each undeclared identifier is reported only onc=
e for each function it appears in
>> vm_util.c:45:55: error: =E2=80=98PAGE_IS_WRITTEN=E2=80=99 undeclared (=
first use in this function)
>>    45 |         arg.category_anyof_mask =3D PAGE_IS_WPALLOWED | PAGE_I=
S_WRITTEN | PAGE_IS_FILE |
>>       |                                                       ^~~~~~~~=
~~~~~~~
>> vm_util.c:45:73: error: =E2=80=98PAGE_IS_FILE=E2=80=99 undeclared (fir=
st use in this function)
>>    45 |         arg.category_anyof_mask =3D PAGE_IS_WPALLOWED | PAGE_I=
S_WRITTEN | PAGE_IS_FILE |
>>       |                                                               =
          ^~~~~~~~~~~~
>> vm_util.c:46:35: error: =E2=80=98PAGE_IS_PRESENT=E2=80=99 undeclared (=
first use in this function); did you mean =E2=80=98PAGEMAP_PRESENT=E2=80=99=
?
>>    46 |                                   PAGE_IS_PRESENT | PAGE_IS_SW=
APPED | PAGE_IS_PFNZERO |
>>       |                                   ^~~~~~~~~~~~~~~
>>       |                                   PAGEMAP_PRESENT
>> vm_util.c:46:53: error: =E2=80=98PAGE_IS_SWAPPED=E2=80=99 undeclared (=
first use in this function)
>>    46 |                                   PAGE_IS_PRESENT | PAGE_IS_SW=
APPED | PAGE_IS_PFNZERO |
>>       |                                                     ^~~~~~~~~~=
~~~~~
>> vm_util.c:46:71: error: =E2=80=98PAGE_IS_PFNZERO=E2=80=99 undeclared (=
first use in this function)
>>    46 |                                   PAGE_IS_PRESENT | PAGE_IS_SW=
APPED | PAGE_IS_PFNZERO |
>>       |                                                               =
        ^~~~~~~~~~~~~~~
>> vm_util.c:47:35: error: =E2=80=98PAGE_IS_HUGE=E2=80=99 undeclared (fir=
st use in this function)
>>    47 |                                   PAGE_IS_HUGE | PAGE_IS_SOFT_=
DIRTY;
>>       |                                   ^~~~~~~~~~~~
>> vm_util.c:47:50: error: =E2=80=98PAGE_IS_SOFT_DIRTY=E2=80=99 undeclare=
d (first use in this function); did you mean =E2=80=98PM_SOFT_DIRTY=E2=80=
=99?
>>    47 |                                   PAGE_IS_HUGE | PAGE_IS_SOFT_=
DIRTY;
>>       |                                                  ^~~~~~~~~~~~~=
~~~~~
>>       |                                                  PM_SOFT_DIRTY=

>> vm_util.c:50:26: error: =E2=80=98PAGEMAP_SCAN=E2=80=99 undeclared (fir=
st use in this function); did you mean =E2=80=98PAGEMAP_PFN=E2=80=99?
>>    50 |         return ioctl(fd, PAGEMAP_SCAN, &arg);
>>       |                          ^~~~~~~~~~~~
>>       |                          PAGEMAP_PFN
>>
>> --
>> Best Regards,
>> Yan, Zi


--
Best Regards,
Yan, Zi

--=_MailMate_FD5AA431-A00D-41BD-959B-5776C3AE19F3_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEE6rR4j8RuQ2XmaZol4n+egRQHKFQFAmXh5zIPHHppeUBudmlk
aWEuY29tAAoJEOJ/noEUByhUp1UP/1LOMterfAFDWLhGJX8OoGHrUpj1OiWnkRbU
dU5PAW0SnljPqJIvLfMH+jaSF5OYih8KMAA/TgVCwsFgNqe22J8GGw+rjHULZWCO
BJgHjec+eril9JSqq6UgeCZJ5P8+JfjTqJ8twjsm3WGDHcrt/yjqGEcR4VUi9/E/
YCHq8nZrYEd9mZpz4WN1tduEctLf6xwzvjGsEy1SexQaxR7wqFDe6R8btMNnmtFt
VNTkFc+3ebhbVZv2OY2R9flRy9M8pu7pRVezk4+Cw2LmqHtBfH4Y6HG/6/eMiBEH
kO3ko1HIJkSCSqOuSr2DrHYo11VsxTwKDF0T0dmuGPFJ4fTn+4IlPvKsed+/OOct
C3yQemyoR7BbfIe9kwC9j07OlgLRWwU33FkN0wJyOYy6IGq0K7q3jZtA2gwEq0l9
BU0saiAs0IPn/IRF4D8fyNdq6yaAgi4+rwkrlBMmOSA+qaTgXPGPC9GBbdVVFnKz
1o05tHpTCcFh3Wad9moV6UxHtEBhm+nrude1A+Cas+ygr13fxyzSlKKG3xXWBNaZ
2ZKdFO0qznLMfx3OJ0RIPLh8GsxR7GcQV2TDLoX9a+QuMLINKrJ4TTOTZzyvHQ4A
0xCIMkodgQwSR9MJM+a5FZWTqDDYJGZ8eGJ75OX06BPRa+d27O3KlGr356b8UwbG
B0T48+qS
=wSNp
-----END PGP SIGNATURE-----

--=_MailMate_FD5AA431-A00D-41BD-959B-5776C3AE19F3_=--

