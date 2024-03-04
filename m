Return-Path: <linux-fsdevel+bounces-13510-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FABE87099C
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Mar 2024 19:31:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F17A51F27124
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Mar 2024 18:31:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A091B7175E;
	Mon,  4 Mar 2024 18:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Wm8MZp+f"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2061.outbound.protection.outlook.com [40.107.92.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A9AC70CD3;
	Mon,  4 Mar 2024 18:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709577088; cv=fail; b=bYwBEWkvxzFVSmW5Uacg6IjYzdRZOsC1jx5OWdrtOuYuXuA7inkNRbgYNQWybFr2uHcMEZC5XR6QYhKsvQm/xqs1O58AxreJE1dAGh3GQCc6QAYZC/0a0MjEx6axojgzl2PhUnVlVYZbVFRy8jBDBOrEcd963x9+6C1ync8JJZ4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709577088; c=relaxed/simple;
	bh=+PzyvvDrvH4RSzKMTqvwoHRfKhHvYL1phpW7b3V3L64=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tRrnDhtzG6Es6cuw951XE//Km7nB3bVeOhLUju7wyf6dw5OKBXi2JTT+4Nvvb5Tt+OI/HTyMzSap8svGKLOSnWrmrNbd/qWK8LHE/bnI3tqX1u275G1djp9eqSFEhOpUXBzUov4SmH3Sjo25Y5bX0hy11WdMZMgIEjvMDBbGLfY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Wm8MZp+f; arc=fail smtp.client-ip=40.107.92.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W3TsepMy6jdz3l3YE9RSG1G+ECJJaM1yxfL6TEq25P8vn3ru+1UGmu0mJNVhymuV67vWE1CS1T978xL5+3qys4jDDk4K9UNgf9Oc/ZFiviOIUrEL84MYgzy0PmxgDePufSLLEbr3WjvsiSJ6gaCGzGbrjQpfUjVt0dxujVHK8eseWtfrqYo90wdr6zGllpZnlzCcdaT5+qvTX++SLxCNSAr9RGP8ISAVBBt4sFVsYNgVN2LhzX1YLFgMTQC9uAgQiKpy+wtatuGFUJSg+sMvoVKTWfa96ooP+EYfOpYY6B5EqMWbsynBTVppLTN3c0dNKRSxpqs8Z0c5WjwmqT4r9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E7q0f1AZbiTbJPDmE+Da8Nr2NmypCFx+0cvi/066Sg4=;
 b=WDhndoJ3BJNs7Xg96FKh3/2uu6n6PUwY6pyoBj22w6jLwqwsONflwB0TzX8Z0anE1P5oc3BcCunvdynohec0ZTssMrlPP1tOMK+TCKnJthz5VZEg72hyr1arIrQYcEYtVIMV0wHps77bcVQBP7G1eUX0eXQlCVPEKKFXARVe0IqzHbKhg+A8pZu4ZLNME/PBzsMoLxlMjncaYwr59G43etHWNIFnIf4GnN3RD5J1NAXTluBM4LVSUV18PPJanlFpUzIW2Co//VPEuCzoXmVSPB3UNTKmJ6A8UNad93yAdcw+onLzgtjJQOjRJAiPRgvaIeK+mgHvqbNDT4ddGXT7ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E7q0f1AZbiTbJPDmE+Da8Nr2NmypCFx+0cvi/066Sg4=;
 b=Wm8MZp+f3oXaw0Wg44naTEPI+st47GDWUD4Dd+WU4f+4JmJFmV+famHMP/m5VEEL88c3eg2I2E6M7d3+wG7XTt8uCg77uJgVbAa2CQe2mZb6uUBY85qgrm3nyNVmiZkwknGTI+ygpRlnnkYdW4eAVP9DVfhFbPjCJP3HGHyT5q34xB6vz7Y7FxwAvZbEzfY6Zdj9mQ7BTjuRShejNOGq3cD1vzbb5ehYNlJroBIsgXtw+Bs7HTxCSKgpvR/0wuEn7AdKqCwyQAkRhLtWZUAUbrEqUdayLkhIkmK6mzvRphnsyqFZ6MyiihOEWH6BFh2Y360TGbLYeSykipNy15DlRA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB5744.namprd12.prod.outlook.com (2603:10b6:8:73::18) by
 MN0PR12MB5882.namprd12.prod.outlook.com (2603:10b6:208:37a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.38; Mon, 4 Mar
 2024 18:31:22 +0000
Received: from DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::dc5c:2cf1:d5f5:9753]) by DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::dc5c:2cf1:d5f5:9753%6]) with mapi id 15.20.7339.035; Mon, 4 Mar 2024
 18:31:22 +0000
From: Zi Yan <ziy@nvidia.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "\"Pankaj Raghav (Samsung)\"" <kernel@pankajraghav.com>,
 linux-mm@kvack.org, "\"Matthew Wilcox (Oracle)\"" <willy@infradead.org>,
 David Hildenbrand <david@redhat.com>, Yang Shi <shy828301@gmail.com>,
 Yu Zhao <yuzhao@google.com>,
 "\"Kirill A . Shutemov\"" <kirill.shutemov@linux.intel.com>,
 Ryan Roberts <ryan.roberts@arm.com>,
 =?utf-8?q?=22Michal_Koutn=C3=BD=22?= <mkoutny@suse.com>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 "\"Zach O'Keefe\"" <zokeefe@google.com>, Hugh Dickins <hughd@google.com>,
 Luis Chamberlain <mcgrof@kernel.org>, linux-kernel@vger.kernel.org,
 cgroups@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, Mark Brown <broonie@kernel.org>,
 Aishwarya TCV <aishwarya.tcv@arm.com>
Subject: Re: [PATCH v5 8/8] mm: huge_memory: enable debugfs to split huge
 pages to any order.
Date: Mon, 04 Mar 2024 13:31:19 -0500
X-Mailer: MailMate (1.14r6018)
Message-ID: <C18F1F9F-A4FC-4F37-9414-A7ED5233E913@nvidia.com>
In-Reply-To: <262E4DAA-4A78-4328-B745-1355AE356A07@nvidia.com>
References: <20240226205534.1603748-1-zi.yan@sent.com>
 <20240226205534.1603748-9-zi.yan@sent.com>
 <082e48c8-71b7-4937-a5da-7a37b4be16ba@arm.com>
 <A111EB95-0AF5-4715-82A4-70B8AD900A93@nvidia.com>
 <7E498B77-6CC9-4FC6-B980-D79EEC548CD0@nvidia.com>
 <0685EC19-CDB8-4CD3-BC39-82DE59B5D10C@nvidia.com>
 <0be630f0-ce8e-4a80-b42f-697ea603cfc6@arm.com>
 <1829EABB-7966-4686-A5E0-F6B6D26C510E@nvidia.com>
 <bd51b366-60b3-4ca5-9634-95dfbc3d1829@arm.com>
 <262E4DAA-4A78-4328-B745-1355AE356A07@nvidia.com>
Content-Type: multipart/signed;
 boundary="=_MailMate_75486190-527B-4A39-BF10-080618AA967A_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: MN2PR16CA0052.namprd16.prod.outlook.com
 (2603:10b6:208:234::21) To DS7PR12MB5744.namprd12.prod.outlook.com
 (2603:10b6:8:73::18)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB5744:EE_|MN0PR12MB5882:EE_
X-MS-Office365-Filtering-Correlation-Id: 11ef0979-ce77-4310-4257-08dc3c794a7e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	xSJT+WMLjhPCpMVWcGoct9WHmtQkHypvQQrjcW/Nw60XHFrkVSSM+hpsnY0OUgT8HQcUb7qttht7JVhhT8J78aV7R/1YUHoiqTBzwfEYntVfH9m4sebWXZhMld6vXW7oGoJQIhYYEKwhTET5U7V7qwFXCNcU4qL2GirRdVMobNZ+JK1Pr2mHIPpXus9NIrYGbSNRLB9b9R/f/nEGwGYzrjTlANiM6n8lMtb/+GJZdD9bjbON1KI1EoDE2IGy0vay5IP4Y9uOUUM5dJLGB8n8F5mYJe3fnmaulSKlXhbedRyoq7J5k346JA7NVVSPbz/L+eFj2JIrVLJ/5nxKm0TdubI/Gn9Z0w81I25Hzn+haH9b5Ewgry1hHbNZT4ntBy0gzhRpq0C0/6uke3aNajBeNaN5v06hW2QMEj1p+CIArGdqA0DzCC2VSjE9JH4D9oed0DsP6JHml3m1k/k/wNkyVBhMbCx4Ytgx8RQsPoRze95dpnfdYnQiMjI/Btqg6SGQXc01KGJ+jcrxRnU+db0Nyznd3Pqw9lH35CJuVWVPQeU+tGjvXI8tT8tI54zAO/CoGEaHbWh8nufsLMZL10muCYNwpt3rp20z2jj59HZ51fRRG2/yeLNlxWLwW5zQcmXno1WJCKhjC1M5CCt2LeVk5bM/+ATKLHqYd4RVKz9DOYU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB5744.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4q8YuqBttk3Mw/zivQ23A0AUs0KcJc8g+svVlA3Y/IxYJgz+70RsMqing98N?=
 =?us-ascii?Q?XY+RBjAO2/+ei+ualqlWzNfHFSS3YhjaQRYZw5D4dbxN+L2qI8yIxXuFauIW?=
 =?us-ascii?Q?ojVu6Mn2cvqplnuxjlBRvWc6ZQIz9yQEa5c1EDVJTF3dT9kj1cjoud5Luche?=
 =?us-ascii?Q?rkk2PyOxfwRaHOANbagyvm8cAK0KXU4fpHuFoTZQ/xJTGq9VRfWrmtS6oUMu?=
 =?us-ascii?Q?ogTDFLlT7FW+4GHiA5ribYZOdbwvwFonhRMNDjj+ke7pdDSx4ClJX8g8/OTL?=
 =?us-ascii?Q?eYUgENGVhmDX2b56/3rG7Xgt8pVX1/9AKfbuqZKrT6mzsB3VbDLir82O0OvL?=
 =?us-ascii?Q?I7DZirSW+8I1D4ZD4bnRILotQNGjsSDpyK+hqkwjR+Q53LYxAJr3qF1SmSEQ?=
 =?us-ascii?Q?w7dUY34OswBQCkcYIzKI+MSXCUgvYmCxI6BGhTjncuAY/Axe7Rsvu8apgX7L?=
 =?us-ascii?Q?hERwr4qB7X7i+OuZDF5ffysW9VUVt9xLSZwpNqviMHJN54hpLFb8BM2x343z?=
 =?us-ascii?Q?p/Zy2K5oHtsNMnqHARG7CJ6Tj61KBduRgb+9MVJ3ikh8kHu/VX/+Dh4pda0S?=
 =?us-ascii?Q?qriWWEqCRltq33fn9VChtuOCEmzJcW2iiGd4CImFnjbKlwRPqACQi4TjCR8E?=
 =?us-ascii?Q?+dhEHVE26XjZCLO7QCs0lR1scmCWGMlNMa/5+Ygh/7409/jTtqZAxG3IVJm5?=
 =?us-ascii?Q?oqqiAG7AAG0dXDh6u1A2FFGvLpdtpZijf+RwLuhoFKjdo9yYnoIlKI5Yojrh?=
 =?us-ascii?Q?sIoUfY8v0zdm8VaLP/XZE1IkTpGBM13c0I4wHysIsbRWu2isuAGRrIoj2yXu?=
 =?us-ascii?Q?KtyxlkVmwvLeErv5XRcQ84pw2r92m+dresOiHDNyE283sSjcyHyz8mG31383?=
 =?us-ascii?Q?t4AEjQ7lLKX7+QMXgP7Gg3WWBimdKndgORVLREz+lVcOO4MsFY7M3D/hJX4M?=
 =?us-ascii?Q?I1U67SbXcS4ECeoRXSj/madJLzZLJPaxZWQ2pT+pA3V37fygCiZHq7zZYl08?=
 =?us-ascii?Q?oLygxljFgGn6kVXESA2Aa/rHw/bUqpEzPQPxjBNuw5LIhnU3XyZvcPSQ133S?=
 =?us-ascii?Q?/fymz/iJo4wOJI87V2f6pXlJ1ECW9rZYPhEh2KMAZTHtma52ILArJprjHBVw?=
 =?us-ascii?Q?lTtTCaAQR8EmzyWyxNwE0IiC0mhaR559Mv2zbNeVI2nQCsC3jAMt5zy61GwJ?=
 =?us-ascii?Q?p5AIyju+N+jYDuhBgp60iPYcG8755/FozKXw9wlWchGdjJ4Fi69vceLSyrJU?=
 =?us-ascii?Q?5spIDDl2Z1jRwXrAjaeEUV8EeV2aK2k0qe5CbGFYk7vzVJtTG8ggIhC4fifX?=
 =?us-ascii?Q?owFu4q4Vz6fwrMHqk7QmxwGj69nmJ5DpMcT4kRgUDLO3bfeDdCOK29vQovxk?=
 =?us-ascii?Q?tI7g+zYQHaioX3JayACSPxMaFbqoR8GK3oKgOxl5XRCeaRZrH5Gnc8Pa+gsu?=
 =?us-ascii?Q?qFTOcJHwmqNmRbFCPRf/KJ+hT+nWx8mi/w+V798vxExffBTbGsPJh/Dzu+pr?=
 =?us-ascii?Q?RY+l9G8VcguSejRvot5mrCQnztDnBPLe66NwVQbpGulw06trsjoBjMXhSmTm?=
 =?us-ascii?Q?KAz55B0VcllGfc77LqVEmRaDnz8wlSazgvdTJPAN?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11ef0979-ce77-4310-4257-08dc3c794a7e
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5744.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2024 18:31:21.9372
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dRgsp0leHWm/oAdMALg3gWdWOVINL055iAkiyZGSceoMwUOFfB68VCYWmyOM+wqS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5882

--=_MailMate_75486190-527B-4A39-BF10-080618AA967A_=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On 4 Mar 2024, at 10:57, Zi Yan wrote:

> On 4 Mar 2024, at 10:44, Aishwarya TCV wrote:
>
>> On 04/03/2024 14:58, Zi Yan wrote:
>>> On 4 Mar 2024, at 4:50, Aishwarya TCV wrote:
>>>
>>>> On 01/03/2024 21:10, Zi Yan wrote:
>>>>> On 1 Mar 2024, at 15:02, Zi Yan wrote:
>>>>>
>>>>>> On 1 Mar 2024, at 14:37, Zi Yan wrote:
>>>>>>
>>>>>>> On 1 Mar 2024, at 4:51, Aishwarya TCV wrote:
>>>>>>>
>>>>>>>> On 26/02/2024 20:55, Zi Yan wrote:
>>>>>>>>> From: Zi Yan <ziy@nvidia.com>
>>>>>>>>>
>>>>>>>>> It is used to test split_huge_page_to_list_to_order for pagecac=
he THPs.
>>>>>>>>> Also add test cases for split_huge_page_to_list_to_order via bo=
th
>>>>>>>>> debugfs.
>>>>>>>>>
>>>>>>>>> Signed-off-by: Zi Yan <ziy@nvidia.com>
>>>>>>>>> ---
>>>>>>>>>  mm/huge_memory.c                              |  34 ++++--
>>>>>>>>>  .../selftests/mm/split_huge_page_test.c       | 115 ++++++++++=
+++++++-
>>>>>>>>>  2 files changed, 131 insertions(+), 18 deletions(-)
>>>>>>>>>
>>>>>>>>
>>>>>>>> Hi Zi,
>>>>>>>>
>>>>>>>> When booting the kernel against next-master(20240228)with Arm64 =
on
>>>>>>>> Marvell Thunder X2 (TX2), the kselftest-mm test 'split_huge_page=
_test'
>>>>>>>> is failing in our CI (with rootfs over NFS). I can send the full=
 logs if
>>>>>>>> required.
>>>>>>>>
>>>>>>>> A bisect (full log below) identified this patch as introducing t=
he
>>>>>>>> failure. Bisected it on the tag "next-20240228" at repo
>>>>>>>> "https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next=
=2Egit".
>>>>>>>>
>>>>>>>> This works fine on  Linux version 6.8.0-rc6
>>>>>>>
>>>>>>> Hi Aishwarya,
>>>>>>>
>>>>>>> Can you try the attached patch and see if it fixes the failure? I=
 changed
>>>>>>> the test to accept XFS dev as input, mount XFS on a temp folder u=
nder /tmp,
>>>>>>> and skip if no XFS is mounted.
>>>>>>
>>>>>> Please try this updated one. It allows you to specify a XFS device=
 path
>>>>>> in SPLIT_HUGE_PAGE_TEST_XFS_PATH env variable, which is passed to
>>>>>> split_huge_page_test in run_vmtests.sh. It at least allow CI/CD to=
 run
>>>>>> the test without too much change.
>>>>>
>>>>> OK. This hopefully will be my last churn. Now split_huge_page_test =
accepts
>>>>> a path that is backed by XFS and run_vmtest.sh creates a XFS image =
in /tmp,
>>>>> mounts it in /tmp, and gives the path to split_huge_page_test. I te=
sted
>>>>> it locally and it works. Let me know if you have any issue. Thanks.=

>>>>>
>>>>> --
>>>>> Best Regards,
>>>>> Yan, Zi
>>>>
>>>> Hi Zi,
>>>>
>>>> Tested the patch by applying it on next-20240304. Logs from our CI w=
ith
>>>> rootfs over nfs is attached below. "Bail out! cannot remove tmp dir:=

>>>> Directory not empty" is still observed.
>>>
>>> Hi Aishwarya,
>>>
>>> Do you have the config file for the CI kernel? And /tmp is also on nf=
s?
>>> Any detailed information about CI machine environment? I cannot repro=
duce
>>> the error locally, either on bare metal or VM. Maybe because my /tmp =
is
>>> not NFS mounted?
>>>
>>
>> Hi Zi,
>>
>> Please find the details below. Hope it helps.
>>
>> Do you have the config file for the CI kernel?
>> - We are using:
>> defconfig+https://github.com/torvalds/linux/blob/master/tools/testing/=
selftests/mm/config
>>
>> And /tmp is also on nfs?
>> - Yes
>>
>> Any detailed information about CI machine environment?
>> - We are running the test using LAVA device Cavium Thunder X2 (TX2),
>> - We have very similar rootfs as - nfsrootfs:
>> https://storage.kernelci.org/images/rootfs/debian/bullseye-kselftest/2=
0240129.0/arm64/full.rootfs.tar.xz
>> - We are using grub boot method over nfs
>> - Additionally Ryan mentioned "Looks like it is failing because he is
>> trying to delete the temp dir with rmdir() but rmdir() requires the
>> directory to be empty, which it is not."
>
> Hi Aishwarya,
>
> Thank you for the information and I am able to reproduce it on a NFS fo=
lder.
> The error comes from that the opened test files are not munmapped and t=
heir
> file descriptors are not closed in the skip path. NFS creates .nfsXXX f=
iles
> for them, making the temp folder not empty.
>
> The attached patch cleans up properly and works on a NFS folder. Let me=
 know
> if it works on your side. Thanks.

Hi Andrew,

Could you fold the patch from [1] to this one (i.e., Patch 8)? Let me kno=
w
if you want me to send it separately or resend the entire patchset. Thank=
s.

[1] https://lore.kernel.org/linux-mm/57259BE4-D4A1-4F57-8AEA-DE526C43DE44=
@nvidia.com/

--
Best Regards,
Yan, Zi

--=_MailMate_75486190-527B-4A39-BF10-080618AA967A_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEE6rR4j8RuQ2XmaZol4n+egRQHKFQFAmXmE3cPHHppeUBudmlk
aWEuY29tAAoJEOJ/noEUByhUZZ4QAJG+bs1nfanzdPMNhrPjE8hniTxe3LVvQk4b
TBVuCGAbYg9TN3/r0leb5fp5coVDy+dz8w0dt/ejWJ7rKFcbmADeBHYwozUG3zJc
c46zirWuiib8AsAgbPcE9vb5R0nRPW+Rrv+dvtq6tWFpx0R4gCkq/Fiub0xRei2L
o4h4+3o4RHxShiUzLM9Ju6f3QIJ9gQ8DJMyWaZz7RlYl7HVPPnyeYjFz3dRLIxwQ
h3L6+4QP/jLpsoz9xpOoeEicfI1Ic6ob4/lGbYBuE8bFnYEE+Mt2z8IngFi393kn
jpkO53WMdLp7KxeIpVltuaGTsY65E1RbHy9zHlYneUheOK2RxNd5XRsSyZBI3L3a
NUNslNbdh5DCiRUL8hu6J2oQim9b82wg4QGR36vGFK54CxBh1kstmGp/gAGAQzCn
BDcu2qTnyMYpSmx2DKx/Xw7bnA91ESYqClxzZWOkXyyWzHe0+JKPEV5xa2r8eTSy
dnP6d5CfH//apAZ8EC9mNnubL2Nw1EVIlLi2e19hID7DU13afQYXB+/WcxV677vK
ygSVxc2/5POqyoUi39oC5kSbB7z6GbqRucS93bzqsnqkrtf6x7rV8gJxrVmeSpQe
Wh3F5OPSvXqA7OkTYlLGkyr7TMXv8dYq1Lw1YupUH3PbrurqlJOiB9SmH9qR/Vks
oNqKHKIS
=fXyx
-----END PGP SIGNATURE-----

--=_MailMate_75486190-527B-4A39-BF10-080618AA967A_=--

