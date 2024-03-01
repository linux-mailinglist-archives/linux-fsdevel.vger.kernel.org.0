Return-Path: <linux-fsdevel+bounces-13285-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3783286E2E9
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Mar 2024 15:01:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DFBDA280DBE
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Mar 2024 14:01:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FB5F6F514;
	Fri,  1 Mar 2024 14:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="XmUiHa/M"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2087.outbound.protection.outlook.com [40.107.95.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 008DB6F06C;
	Fri,  1 Mar 2024 14:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709301640; cv=fail; b=dJb+0SLhNOagqgx5amXbwXiYkQQlnnDGyD+9hCucUQjbaGFC3U1/JpSScr8ck67McFao47TroIruDBa2kJbHQzsYeTH40aGZuq9GB5TgmqF1z0C5Uxk+ssAOA+xLvnpDoLpKbAVW5Gt+e6C5+Us/6FzHNarpSRIhnAGBXn9fI+8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709301640; c=relaxed/simple;
	bh=Wxi1uj1RB5mWSEa1yjlMGVl3WeO3lXdzn3eLgh/BJkU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ljta4xVmtgwMaFSNX7S97U26mwj4So48+K25WNvb8UMGBVrsHFOi6lm2xAKtaXj07q8SnqqaW5fgqOS8CyQa8XxjnDUnXfYNa3vci1fBC2omn7FTL20TNqiXMprCwwGAmIuvxiCNPj3PjxeYyWsfFflquNMOTyJ9K+C+XOzbXvI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=XmUiHa/M; arc=fail smtp.client-ip=40.107.95.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KeXJhmBBiY9a3GJUzytlMZlijRhuDzIdrhT1sS2uzgODa0ctT7IT2KBy0c/V09m5qtZAly3mt3Lo73ksNPvmZ5JlUOYNhrDyIIWtBMxEFgU4SsE2+rx28T7Tp+Ni1zCKVMpg3s6MREysptqIw3I2NRQ4izN/vu0fP/WCqWGq5dJs0z7gnGZzIT7LaOoLLUrtJV4Vd8BrHctWbW+ybUQGSiC9fa7iVHo1jlnY1pgTNvrc3S34uDs3NDkB/oEcgW4rfX5EWKr0IZVDon8rphdPkWueX0WI+c60xLkJrD9vb3hu6mp31v1Gfa+hWniFPfZaCu8xX8FQJDg7sZ4WFpu49A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QhubtjR5YhDRRIOMUyRXY2eCk22CB3ZtNmJMhE2vjuY=;
 b=fEs4t8obfuewOXC9VBCAFeIlGA+juq5l/LvJpFUFg143ek7iewO60GaAZ+eGpuO29sgvS6HyeoWXcEMKphaGXw00lZI2TONRcbXKsBetaPjN5jVzbQ/nOOuNSvDuGVSdps/L6pB8lg9dzkNHqJ7FJTR7X9sO8s/tki52afQQHbdvyt2JRIoXcm++GCu9+DNNAaCaFX4qU5+2caMiBr3wsv+tFDFFeb6PdXHDw6td0RQWqF4ov4TmceIy0CIlzyiO89jJdxfwameJfVkdIS8nl8UALsmNy9foMU5J9SIXpgCIoyBtuXlh16g39dBFruClZrfwPK2hNj/Ci80i4OrrFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QhubtjR5YhDRRIOMUyRXY2eCk22CB3ZtNmJMhE2vjuY=;
 b=XmUiHa/Mfs/VB0crw9i4xcS5U0CN/C5wJAly3hZkC0pwB7IzwsZxCLH9QySl37Is8AKY8zTCeEwJVKSmj2DgpgHJJIxjT7fyYXDWqf6vDfUgoCy2qhcH2ehBNd+QdDkn2BkvKK2OJSZKOFZGlPlIkr41mPNCBh+c6Ag7UtpZ97LOCP6/48G0BBxsStyXGW6NARS8TSVGUtDjKxRRXNFWB8U07RTzw6+vL99VwW2g9mzkhUJM46QYPxGkZAqlfP/H07IGm0BdwJ5aoADXi/pVfad26MfkxK01V4LEHRgr7kqE3y0Jhx9t0WzMrjq3S5SlZ+SwbJjdPaVnUDTQn6BISA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB5744.namprd12.prod.outlook.com (2603:10b6:8:73::18) by
 SN7PR12MB6929.namprd12.prod.outlook.com (2603:10b6:806:263::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.41; Fri, 1 Mar
 2024 14:00:36 +0000
Received: from DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::dc5c:2cf1:d5f5:9753]) by DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::dc5c:2cf1:d5f5:9753%6]) with mapi id 15.20.7339.033; Fri, 1 Mar 2024
 14:00:35 +0000
From: Zi Yan <ziy@nvidia.com>
To: Aishwarya TCV <aishwarya.tcv@arm.com>
Cc: "\"Pankaj Raghav (Samsung)\"" <kernel@pankajraghav.com>,
 linux-mm@kvack.org, "\"Matthew Wilcox (Oracle)\"" <willy@infradead.org>,
 David Hildenbrand <david@redhat.com>, Yang Shi <shy828301@gmail.com>,
 Yu Zhao <yuzhao@google.com>,
 "\"Kirill A . Shutemov\"" <kirill.shutemov@linux.intel.com>,
 Ryan Roberts <ryan.roberts@arm.com>,
 =?utf-8?q?=22Michal_Koutn=C3=BD=22?= <mkoutny@suse.com>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 "\"Zach O'Keefe\"" <zokeefe@google.com>, Hugh Dickins <hughd@google.com>,
 Luis Chamberlain <mcgrof@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
 cgroups@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v5 8/8] mm: huge_memory: enable debugfs to split huge
 pages to any order.
Date: Fri, 01 Mar 2024 09:00:33 -0500
X-Mailer: MailMate (1.14r6018)
Message-ID: <2ED5C25C-FDB2-490F-B740-E413E8186C12@nvidia.com>
In-Reply-To: <082e48c8-71b7-4937-a5da-7a37b4be16ba@arm.com>
References: <20240226205534.1603748-1-zi.yan@sent.com>
 <20240226205534.1603748-9-zi.yan@sent.com>
 <082e48c8-71b7-4937-a5da-7a37b4be16ba@arm.com>
Content-Type: multipart/signed;
 boundary="=_MailMate_733E91E2-3397-4C86-9CED-883987CDD269_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: BL1PR13CA0004.namprd13.prod.outlook.com
 (2603:10b6:208:256::9) To DS7PR12MB5744.namprd12.prod.outlook.com
 (2603:10b6:8:73::18)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB5744:EE_|SN7PR12MB6929:EE_
X-MS-Office365-Filtering-Correlation-Id: 07be0362-e9c9-45a2-89f2-08dc39f7f7da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	+rHgJQsXfjFSWhh5BKn8RmKmknq4J7s3EdC6WY+hfwuupxCSq3m6u94GNzlGue8WCyIkJJQK2t6lOaTSN+ZN9CREQrcKmVnU3zB3PFPH+k25KjOHmnUhzlO4OKA1mP+CkjvnKBmFQbMuLYrlNxdmd8MaxB/Czgb/7usPjYTb4ISpYSoFl4KWmBQPJ4cSuyYqtTZyKqVtaVIVLVCvbkWK/D0NmlzrrKeNFYRwrF6OEBNx/BOB8f5e9s6x7pSN2noB8LXjAI8VnFFINcMVz0rRtVXrlt7Rw6yvNobv9eCHFnKYZE0eNzWMXdtc4RHPMmCwQGrw6UU+onDxwguAiT37Ywu102NrK5KSo1Bdmt+rH0ipbPzICRioXOcU/L9ivTW/jvA7OGA+pqejChBwWW28JAopoMzN8xNEBKK8XDWWE/PN0XKfVW81aKaX7tc/lyzPMvu9uTqFGsapA7AHKZt7G/xDj+x3frPT1fP3GlQ9TrwcievtXT3JUq7FJapxVGnYYmhi32AkVDnpA3FldNePJt1v26NrJxEH17uHUsO7vm9sdvvioOYjPhgpsj/8z0IZISBhDMOKnVv8G4VRJoRNUbE9pLceLCjgqYnmnvpHj6g4eGn53yQJuKU01zV815aqTfpyfeNE4FRG2f3Sjr6k3Q==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB5744.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VlRtaGl5MVVNOGZNQ3pBY1JkTzAzUnJXL2M4RW9YMERWaEZTd3dLRE40NDl6?=
 =?utf-8?B?Mm1KYWVFQk5COVRSOUVCaXdycWtWK0NsMldMZi80QUx0elZZV2xzNDVZVTJI?=
 =?utf-8?B?N3dqZEw1TjE4QUFjdXR1UmFLR1RJUG1UTmh0aW9rQ2xrdGhkQk5vZHVRK0VI?=
 =?utf-8?B?UnlCOW92N2RCNTg5M3MxbUI2aDkvWndqV1M3VWpob1loSzhkZWlmUFdRTlVz?=
 =?utf-8?B?Rk1EK0NjN24wQTBWYUtDTkluZllRemZEaHB1ckFPaDdGSm4wWTJ0TFI0LzRn?=
 =?utf-8?B?Zis3NUN3QXJLYUNOSitndTdQbG1sYklwTmlmRkhnTTR3clh6dWVVMVYvc0Rh?=
 =?utf-8?B?ZWlQencyRnVpRDJxaFZpbFVLM3BNeGFsaklCeGxFWjdtSUNkOWdnRUR3cUR4?=
 =?utf-8?B?SGpXRmZxaWRPQnlLck5vTnphcTlrUXozNC9QbkJtaGlJQ0ZBaVNnUkJHdkRa?=
 =?utf-8?B?NU9FMGloUkF6NUdQQWF5Ri9xUlZHeHk2NEpCZ2VZNDdiRlZCaGlRaUY2TUtu?=
 =?utf-8?B?ZmlvbHlpUy9tOWtYVThSZGhNMFVPWmtHSWhRbkJtZGprSHpjbmlkSTc5TmtR?=
 =?utf-8?B?d3pJWmcyWHFnMjUvTEc2VVZpRUY5WiswNGhpb0RtZnQzYTZVNTl1K1FuVUtj?=
 =?utf-8?B?Y2NMa3EyWlBjcnpWcjVaRzJmeDZEK2RXeUZET1dXTXU2T3JpTWcrYzR6d21J?=
 =?utf-8?B?MVdCd1Q3TERweDlsUE1Jai81dDM1bjlpZStYdU1ZeUQ5VTVHRzU1RG1GYUJi?=
 =?utf-8?B?U2tJUkFBRmFwZk4zY29HeEM0UWt2Z2swSDYwWm12NENxSTZzNTdFYm1CdUhY?=
 =?utf-8?B?dUpTMjRhQkZkbFJCNVB6V1RtVisvQXNQS25rbzlWcjFhbkVoRDVGOUk1Wjkx?=
 =?utf-8?B?NVhnWFJnMVh1Zml1SU9JRncwWEpwMXVDYjN5Q01RTG4xNXZZMnFyd25XUDV0?=
 =?utf-8?B?MitaYXZobUMvMjJxbExmc2VwWm5BQlNKc2pBcVRvMkMvUDRKK0llTG5xN0Vh?=
 =?utf-8?B?NkFuRG9HbmV1c2MxV3crcG9kNWZ6Z0o1T1M0UFNNd1VtS3h5dVFaSWJBSS9E?=
 =?utf-8?B?bnM0R1grMmMrM3EwdUdmalUxK05NSE9hUjYrZGp0dk96YVNGVisxZytuUmJK?=
 =?utf-8?B?QWlFMHNQWk9HNmFsWUpOSkZGcmg3RVhtL1BrcVhiMzBkZEcyUXhzb1J4YkJO?=
 =?utf-8?B?RVZxZ0JwaXVHbDdjN3dnK3ZEbUd3dUduRXFSQXRVdG1YTGZhNkhSdlFvbVFo?=
 =?utf-8?B?NmxCa2hWeVp4L1pMNGN1K1V4MkhlUkZwL25PSm9TRXFsL1JiTG05TXdxZjBG?=
 =?utf-8?B?U1dYQkxHV2U3MWwwUVVZVTRmd1N4ZkxzbTgrRmxBTldSNDNhWHhaY1h0dE53?=
 =?utf-8?B?VEJKdU4zQUJETC85M0E1dzVScmZKWkFaVnhBbnFIU2dlN0RsTndNYStLSnBM?=
 =?utf-8?B?cHlmQjBWTk1nVlM2MmF6aE1GQ3JXVEQ0YUlOMUV4NEdTSDNSQzVWclU1REw2?=
 =?utf-8?B?d1hyQmM2eUNhZkhWU0tPWmRxNlFxb0hUWDIySWdzSnV5RWIwVVNPT1FUTTB6?=
 =?utf-8?B?Slg5TmV4QkcyR0xudFJIeVkvMEVmZVdTdWtHUnc5VHNha0ROOHp4RXJyV0VN?=
 =?utf-8?B?SUhQYTZ2VzRWZUo5TGpQL0NOd1F5QXNibW14YXR3UXRmcG5JamNXWmNJZlpw?=
 =?utf-8?B?dmVsbjhmcVZra290cEtubCt0RSs1RHVmanAyNWJ5TVU5MTZEN1p1R2UyRXN4?=
 =?utf-8?B?amVKY0NHVlNJNkJMaUJGallYVEdHa0hMY29iVDA2cW9qMHdCZEYzU0o1TXdj?=
 =?utf-8?B?TXdObU5QeFJYeWlVcW5EMFBDcHNDd0tUVWhyQklPak82SnlEQzVvUDFJa0NO?=
 =?utf-8?B?TThjWkNaL3N1VTZaVWl2MUtGbElhazdXdC83MWNiWENEbFB5WUxqUVNWbTJk?=
 =?utf-8?B?a3ZXTFN4TGhVa3BrWi9vZXNVVkRGZVVRS1Q4UWM3MVFzUDJQY3RtM1lzdSt5?=
 =?utf-8?B?blZCdDlHYXoxbzVYaFJwVTRxOEZwb2tteWt0anJkQ0pWQXRndlNnSXZEd3pq?=
 =?utf-8?B?SE5RTHA5Zkw0YjI0NURqZy91YzBlTkxDRDBqeUZRVWViclJiUjMvWTJ3eGRY?=
 =?utf-8?Q?EHLgcz+hLkxUEHWquK13d6Vxe?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07be0362-e9c9-45a2-89f2-08dc39f7f7da
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5744.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2024 14:00:35.8956
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s9k46kjN2BzTAqjhTyvd3/+xK971g7L43Cm7gJHJ/ICr2hgxbrdOdYEBZcqm/gya
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6929

--=_MailMate_733E91E2-3397-4C86-9CED-883987CDD269_=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 1 Mar 2024, at 4:51, Aishwarya TCV wrote:

> On 26/02/2024 20:55, Zi Yan wrote:
>> From: Zi Yan <ziy@nvidia.com>
>>
>> It is used to test split_huge_page_to_list_to_order for pagecache THPs=
=2E
>> Also add test cases for split_huge_page_to_list_to_order via both
>> debugfs.
>>
>> Signed-off-by: Zi Yan <ziy@nvidia.com>
>> ---
>>  mm/huge_memory.c                              |  34 ++++--
>>  .../selftests/mm/split_huge_page_test.c       | 115 +++++++++++++++++=
-
>>  2 files changed, 131 insertions(+), 18 deletions(-)
>>
>
> Hi Zi,
>
> When booting the kernel against next-master(20240228)with Arm64 on
> Marvell Thunder X2 (TX2), the kselftest-mm test 'split_huge_page_test'
> is failing in our CI (with rootfs over NFS). I can send the full logs i=
f
> required.
>
> A bisect (full log below) identified this patch as introducing the
> failure. Bisected it on the tag "next-20240228" at repo
> "https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git".
>
> This works fine on  Linux version 6.8.0-rc6

Hi Aishwarya,

I am trying to fix the issue. When I am compiling selftests/mm, I encount=
ered
the error below when I run make under the folder. Am I missing any config=
uration?
Since you are able to run the test, I assume you know what is happening. =
Thanks.

vm_util.c: In function =E2=80=98__pagemap_scan_get_categories=E2=80=99:
vm_util.c:34:28: error: storage size of =E2=80=98arg=E2=80=99 isn=E2=80=99=
t known
   34 |         struct pm_scan_arg arg;
      |                            ^~~
vm_util.c:41:27: error: invalid application of =E2=80=98sizeof=E2=80=99 t=
o incomplete type =E2=80=98struct pm_scan_arg=E2=80=99
   41 |         arg.size =3D sizeof(struct pm_scan_arg);
      |                           ^~~~~~
vm_util.c:45:35: error: =E2=80=98PAGE_IS_WPALLOWED=E2=80=99 undeclared (f=
irst use in this function)
   45 |         arg.category_anyof_mask =3D PAGE_IS_WPALLOWED | PAGE_IS_W=
RITTEN | PAGE_IS_FILE |
      |                                   ^~~~~~~~~~~~~~~~~
vm_util.c:45:35: note: each undeclared identifier is reported only once f=
or each function it appears in
vm_util.c:45:55: error: =E2=80=98PAGE_IS_WRITTEN=E2=80=99 undeclared (fir=
st use in this function)
   45 |         arg.category_anyof_mask =3D PAGE_IS_WPALLOWED | PAGE_IS_W=
RITTEN | PAGE_IS_FILE |
      |                                                       ^~~~~~~~~~~=
~~~~
vm_util.c:45:73: error: =E2=80=98PAGE_IS_FILE=E2=80=99 undeclared (first =
use in this function)
   45 |         arg.category_anyof_mask =3D PAGE_IS_WPALLOWED | PAGE_IS_W=
RITTEN | PAGE_IS_FILE |
      |                                                                  =
       ^~~~~~~~~~~~
vm_util.c:46:35: error: =E2=80=98PAGE_IS_PRESENT=E2=80=99 undeclared (fir=
st use in this function); did you mean =E2=80=98PAGEMAP_PRESENT=E2=80=99?=

   46 |                                   PAGE_IS_PRESENT | PAGE_IS_SWAPP=
ED | PAGE_IS_PFNZERO |
      |                                   ^~~~~~~~~~~~~~~
      |                                   PAGEMAP_PRESENT
vm_util.c:46:53: error: =E2=80=98PAGE_IS_SWAPPED=E2=80=99 undeclared (fir=
st use in this function)
   46 |                                   PAGE_IS_PRESENT | PAGE_IS_SWAPP=
ED | PAGE_IS_PFNZERO |
      |                                                     ^~~~~~~~~~~~~=
~~
vm_util.c:46:71: error: =E2=80=98PAGE_IS_PFNZERO=E2=80=99 undeclared (fir=
st use in this function)
   46 |                                   PAGE_IS_PRESENT | PAGE_IS_SWAPP=
ED | PAGE_IS_PFNZERO |
      |                                                                  =
     ^~~~~~~~~~~~~~~
vm_util.c:47:35: error: =E2=80=98PAGE_IS_HUGE=E2=80=99 undeclared (first =
use in this function)
   47 |                                   PAGE_IS_HUGE | PAGE_IS_SOFT_DIR=
TY;
      |                                   ^~~~~~~~~~~~
vm_util.c:47:50: error: =E2=80=98PAGE_IS_SOFT_DIRTY=E2=80=99 undeclared (=
first use in this function); did you mean =E2=80=98PM_SOFT_DIRTY=E2=80=99=
?
   47 |                                   PAGE_IS_HUGE | PAGE_IS_SOFT_DIR=
TY;
      |                                                  ^~~~~~~~~~~~~~~~=
~~
      |                                                  PM_SOFT_DIRTY
vm_util.c:50:26: error: =E2=80=98PAGEMAP_SCAN=E2=80=99 undeclared (first =
use in this function); did you mean =E2=80=98PAGEMAP_PFN=E2=80=99?
   50 |         return ioctl(fd, PAGEMAP_SCAN, &arg);
      |                          ^~~~~~~~~~~~
      |                          PAGEMAP_PFN

--
Best Regards,
Yan, Zi

--=_MailMate_733E91E2-3397-4C86-9CED-883987CDD269_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEE6rR4j8RuQ2XmaZol4n+egRQHKFQFAmXh34EPHHppeUBudmlk
aWEuY29tAAoJEOJ/noEUByhUkIoQAJVaEmpOlSOcfeJpEDI92YVEksQHkSmlCMy+
SFkfW7DjWABKWjhoY4sL/vv0Lt9mkX9TeHdDEXh7austZe2el7B2dEJUa2QL+5PX
Ltes2IRj9gRpLuANv6mUQvE6S78Tx/xtaFge8Vu75cLIgQqQ10pwnyoYWvmMX1sC
L9NlALQ9FyypJnUQRt8q4sKSCIEPWlJlcWwaNTjZeHI04IuxU31YdpxEknQ9uhj9
X8j6SSvbOraXitE+jbZcnXaLQwAn4xf+W1ZVID8wtPzSyFoC9IQTJCs2z/l/sOul
wseZYryqQtP5tJr8giDXlqRz603RZAfl95qiG2xtn2lit1SXy0BmTcg9AicdjvkL
J8zCdt7Uf1JWI+2zfBcwKNk5fe9urGrmuZUpXWIGtq/sizcxqM7AQnKZlqiTwRrI
10JvtLbmysfpu1/PReJPlSRhEfiB0Fxw3c48UGXygiHLipXFs2zWPlUszgjXs3JW
/A0O9oV3zpRDNL1PJrQKr9Yl4KYfkb1m+hurFWSeYkenvMXnCCwApHMvQnnc9rl2
UCLdJ7d9wG+tyjQaBTNXh+dpFgBwnIBrTbuYAS+zuKVdm7+9cT8a3EOO/AsyywOE
Gf6AWfVJs33roAw+iCXqvf9VMN3gBK3RhTEn5hzRCk9h5LJc9IbJQ+VvyKHssdUu
kuUFA5S7
=5Ey1
-----END PGP SIGNATURE-----

--=_MailMate_733E91E2-3397-4C86-9CED-883987CDD269_=--

