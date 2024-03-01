Return-Path: <linux-fsdevel+bounces-13336-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0277286EAEC
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Mar 2024 22:10:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 859F21F24570
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Mar 2024 21:10:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9182157301;
	Fri,  1 Mar 2024 21:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="IIJDkKl+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2066.outbound.protection.outlook.com [40.107.220.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1168020DCD;
	Fri,  1 Mar 2024 21:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709327434; cv=fail; b=au2Xebcw+5OXKVHbXpeFQDOGLSgT9Nrg72liULW7h0TE+qTuekuC2UyRcYDzDqd3s4FkIgcfCNZNCpVjQaNBLQVpCSuu6hZaiSnci0rl7Xq8YC0aFpeGMuC4yA3XesMMIv4xjqO908RiwWrOJ8MAVivc/gITEplyyFenf0Q74Kg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709327434; c=relaxed/simple;
	bh=uNMsFw7iBAC0uN0gKBc/h/7Zx8Yekr3S3Z5Qi4F1noc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=g818LzSe+wdeMV4PteQ1YoH440FdRE/ZlmMGy8GFgkGGaWqWB1DoProPABusrdcVIYXQP7ekpJl/fQ6QnynSeW6uM5lRlDRmny+TUsiFsHRhUoopD61gd8B8fNT54Dg6aph6sUtyMytIPTieUPekvEBlY/tkZ3adRB0IBOGshZ4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=IIJDkKl+; arc=fail smtp.client-ip=40.107.220.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DCpVDbLUdndU4K5tDAJtYb8II9Ybwk+kvaofUh2ES1yRXFoCAT46LZJE3jw6bmI/Qm8+Seoe/XlBU6FWgRzUXeSDWwKpCV/FlG/ow7RtzDNR/+ZVxlId0JXmjBsvTP+d12J+2k33YORJcyqsf8HjS1UjyxNqMyCgPDJDsqkHRZK37QZiXOGJL9H8aN4hLXk49wHr48RERVg53YTtOn7CcaxPjydb5W+wj0h+MGaaExipULjxcLm4X8+D1ALF8Hw0xfYr/jsTTriFKu6DPcoHjv1a98fuZCR7tBQFoOxBIRKPkQPjivDqc6GoaYowcCiCxKqbhAdXKGuCPJTRmYO2wA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=70X9/T2wNE2BSopYdjY6CPgYV9iJ8eQdprpIFaFZdwo=;
 b=Kao+xBn+qeo/WQjHtVYQst5lJr+sDLXV+l++uA4emk2ioirUxdDjpCWvoF+nbRJe6qz7kmAzTj0f+VcO4wnHY/xbOFSgQd0qUKJ92bCENchRHNFeQeTQK2BbCuQ3S96CVbU6WMTOZBej7XF5P2ghoumXjH5Fo7x+mSY39QeP6s/fsUjXaJG6ziZ5xnExpxpcY/BMWDO/GZLcrAk37rDRyjPeDHhpCam9dIl2oPTYBldS12QQxidviLObTB/S8L6lHksuarKX1nTmcxqtBkJyCCnSbtP1Sb8khH3mo9Cdpzqzq7oUToxW5BdfFcK8LTWJZHIfXU14nj+70Mn1Iveb7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=70X9/T2wNE2BSopYdjY6CPgYV9iJ8eQdprpIFaFZdwo=;
 b=IIJDkKl+RsOQipakchnyN2md7C0UeCb3FLqKP5FXb7FuirnEeMTQ3JZm2Kch/fhOogv8to06y7eDBgPEYgC5XltY+daNyncnU8u3u/E5ltEKHqYjoojpGTMiShCgzbo07ofwmCScdzbkigvX7/41g9HU39Z08Tc4h7K7KPyocb0JHIpvLQDavEuLN9haeSSagjkCUrKinFBRTgDMoO/Ubc0NABD5cjw9oDrX1EXlOq7QY4lpbh11++Z58tzOsg17ivYPP3s8Ix0p0kCIGZ3SHTq8J82T+S1V8u1r02WAoR0XD1qp/h51bcXpwYn7H1x8uCu03d7vMR0FDwe5jZVTFw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB5744.namprd12.prod.outlook.com (2603:10b6:8:73::18) by
 MN2PR12MB4373.namprd12.prod.outlook.com (2603:10b6:208:261::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7339.34; Fri, 1 Mar 2024 21:10:29 +0000
Received: from DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::dc5c:2cf1:d5f5:9753]) by DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::dc5c:2cf1:d5f5:9753%6]) with mapi id 15.20.7339.033; Fri, 1 Mar 2024
 21:10:29 +0000
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
Date: Fri, 01 Mar 2024 16:10:26 -0500
X-Mailer: MailMate (1.14r6018)
Message-ID: <0685EC19-CDB8-4CD3-BC39-82DE59B5D10C@nvidia.com>
In-Reply-To: <7E498B77-6CC9-4FC6-B980-D79EEC548CD0@nvidia.com>
References: <20240226205534.1603748-1-zi.yan@sent.com>
 <20240226205534.1603748-9-zi.yan@sent.com>
 <082e48c8-71b7-4937-a5da-7a37b4be16ba@arm.com>
 <A111EB95-0AF5-4715-82A4-70B8AD900A93@nvidia.com>
 <7E498B77-6CC9-4FC6-B980-D79EEC548CD0@nvidia.com>
Content-Type: multipart/signed;
 boundary="=_MailMate_66DFA667-0A53-41D6-BBC8-0952C7B6C472_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: BL0PR1501CA0033.namprd15.prod.outlook.com
 (2603:10b6:207:17::46) To DS7PR12MB5744.namprd12.prod.outlook.com
 (2603:10b6:8:73::18)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB5744:EE_|MN2PR12MB4373:EE_
X-MS-Office365-Filtering-Correlation-Id: be4fd299-1500-4908-2a7b-08dc3a340616
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	uTyUP0AO4+NiEX3cwGBqxg5H3br4E3uduy/tVGmJVKt5j1AcnKYow/kwUQWiNO3Xl2uKSQrpxPl8E4qXcpAFQB26XX03NDrSL8sUEUFt4Jbq/1mi0SMXqGYnNChKQPkRE1ymkIQAvdOiJg+ewwChfteFcAnmI6yoVcDviR/UBaqRZcRCZyLUYvzyRISR5EBJXSm1hP87yPdV4sfS9RBMpG74DNGs6UadQyT+4cZlKZpdGemr3ip4iC0FQau7XZ0PQzl60klvqRz5HPAhkYFBKKtwV5hU0Iw/sKS8HAQmGSpMRsmhsrHq/Gy4ElRNJ5c7xWyL3sUWH6fOlMnVCedSIKkjqEpF6k4KDwirvsM14JpD1baWHfi8/MCRGXGuUdhT1b6gIi2MELufWFaQNU4p3XExm5q2M4KgOC6T94JoWt15Z/icYB1hbGpnETIPJiWbWrA4Q9HelEHfFTU+tcoitifQZPGY6rWPjN7G5tkevmdHo5EsLewvq7yVOXqFqr7JTkkXkzQy8+PVQtfBmXx42tj3mTDXQSia+URe6YxXpatCx1Fbdhvgrh4ULc5MradBPa6vSEYRCa9WcztQWNROfRs0cAXwy99o/H7wHenIVjYO8wfcc/MOjZG+SF/TBj6bLiPNitnnflsSnR/0NGSC8Q==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB5744.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3h41bv0tjri2fp1c9/nY/ttla3EI/cKzMTiSnwVt+XpYVdF4eL4C5gTAdxqe?=
 =?us-ascii?Q?DHjgHWQyXXIjkMTprX5Nl1gU8a8kASpMddK4vAsHyFtntdLGN3V8ayi/NI8u?=
 =?us-ascii?Q?GRwDbhFbftpNwPKl0l+4N5eFivKawJlGSAQ3FtKsDh+g2DNaaARO+ZSkkPPE?=
 =?us-ascii?Q?jDRx0cnTbmuvR8zxlY0PaTb5X7gcSB1Qz0GH4SHFOH2ktRMlPNJpQgIfx/mo?=
 =?us-ascii?Q?eGyPvjWPA+W+zcmnqEoc1esxFAqVDBzB2Aum+URSR4EBE2Q3g/0EpNtsUnva?=
 =?us-ascii?Q?5DT6GLwY46sjq78Cp/Zav1D51X+8XchG6lLrqgR1N8KTxB4gOuBWw/4MFu7f?=
 =?us-ascii?Q?Cl+APRWSPztnPkunHMAQVsOfQ8tlDqlSE2CZViUzMyLzvorm7V75eezFMNTc?=
 =?us-ascii?Q?gfVAcFRmhEcNgMenBeGDv1hbiH68/T9fCKXQXr8aHYWUjYbpMmq4kNbcGDgu?=
 =?us-ascii?Q?TmlTe0aBk2XNZeFVLNlzni+P3gRMpil1OEJw32zhmA1TO6maTAc3DrTJt1B5?=
 =?us-ascii?Q?lMfsoSjgXBu4Z1WYphOaEZbI6PG+t4J8dc3QXxPyHI4H6MiSquC30nJ1GEPw?=
 =?us-ascii?Q?J6SZaD3zeYMibalmwVNkhTqQWbMBnVLHYjrc1K49Wj7rPiH9zcHez/QQKYVu?=
 =?us-ascii?Q?J46FWKBdhYUEqRdvu5QMmN/6HptjumG6NbCCmp/3VZe15gQBdbrUU7YadU2o?=
 =?us-ascii?Q?DqcMMtQUxBINCXY6+kIx4yCbhSqTTYI+pvSF3DKi5yumklczpZVH2cUWfZAq?=
 =?us-ascii?Q?cB21TWRbxEmXHB8Dq6lx2YXA18jPW6s3R1YuM3aLlka1ZZRazCjuUdn7L8nP?=
 =?us-ascii?Q?BIw0LanoRwV1YMaJn5UfDM3AduWuNGlxqFbUg1mooM4M9okgKYGQ+HIrYu81?=
 =?us-ascii?Q?c2Du/7rtNPlVvTEfTp/Ekjp0Nl0iCzQevnUmccSFZLuLwXlRPbrc9MPxrYjq?=
 =?us-ascii?Q?ck5mHjm9jz07r6ZKkKQ5m2dawghdFIwV+b4NwMBP725tnKwctbA5Vk/r9bpY?=
 =?us-ascii?Q?yhh4srPAzosoo9E61NgugPqW74kKT/wO5f7Y7LahVgaTvQNjNKZfx8G/WGwz?=
 =?us-ascii?Q?Gb8tFk2XjJLE43eMd2RVE1HuKlyR3vdCWBQwPs80FTJSY2FRK7EJoU3RDqgv?=
 =?us-ascii?Q?3cyi31qbeSIN482A+2Qp9fXZ3dAwGIEmAPRz5Oi4wFUaDC8243w3NmiSml6k?=
 =?us-ascii?Q?9q15nELEsSvM5DTQYYBOrTyrUMWWC8eKwTABm6m4xQbbeHHbHZydmgpKCfa3?=
 =?us-ascii?Q?goeiG8Kr4/osWGYXbh+B+sFCG6ikgHwZ9yh6Y3UtDhbhtfco6Zt91R/1mb1M?=
 =?us-ascii?Q?xUobkNv3f80yTmI3V8dTb0crl5iVmbgSlo9WXqFCgDs7kYoMvfRjq3zTH9vn?=
 =?us-ascii?Q?1XIuHgEel3iOp6XcaVhdlGSxdA9/+EY+1GApMTYnViOroJV8x9ARIyL2/tQ0?=
 =?us-ascii?Q?oKRVU9anbQiCbpZb0qj87U0cxeQfraLI25fWdEoxvVKstxMS7W7Pcunsx6oV?=
 =?us-ascii?Q?zeo5RiRkmkerNLJHhRLTwFvYDMaEv+KaDrY9fKVOI0vwY9f4tRr94lWPKjZY?=
 =?us-ascii?Q?gb7i5feVwE2ejhPvbj5P63K1JjxkNmAdQyk08piM?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be4fd299-1500-4908-2a7b-08dc3a340616
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5744.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2024 21:10:29.6080
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LBazU9XjPs8hH0eV2sN0UAnt8yL7SESsbEhWjP/XVPBusTHu4gl7MKRzbfKcjEJE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4373

--=_MailMate_66DFA667-0A53-41D6-BBC8-0952C7B6C472_=
Content-Type: multipart/mixed;
 boundary="=_MailMate_144E51E7-D085-4541-BC72-FA5719E89265_="


--=_MailMate_144E51E7-D085-4541-BC72-FA5719E89265_=
Content-Type: text/plain

On 1 Mar 2024, at 15:02, Zi Yan wrote:

> On 1 Mar 2024, at 14:37, Zi Yan wrote:
>
>> On 1 Mar 2024, at 4:51, Aishwarya TCV wrote:
>>
>>> On 26/02/2024 20:55, Zi Yan wrote:
>>>> From: Zi Yan <ziy@nvidia.com>
>>>>
>>>> It is used to test split_huge_page_to_list_to_order for pagecache THPs.
>>>> Also add test cases for split_huge_page_to_list_to_order via both
>>>> debugfs.
>>>>
>>>> Signed-off-by: Zi Yan <ziy@nvidia.com>
>>>> ---
>>>>  mm/huge_memory.c                              |  34 ++++--
>>>>  .../selftests/mm/split_huge_page_test.c       | 115 +++++++++++++++++-
>>>>  2 files changed, 131 insertions(+), 18 deletions(-)
>>>>
>>>
>>> Hi Zi,
>>>
>>> When booting the kernel against next-master(20240228)with Arm64 on
>>> Marvell Thunder X2 (TX2), the kselftest-mm test 'split_huge_page_test'
>>> is failing in our CI (with rootfs over NFS). I can send the full logs if
>>> required.
>>>
>>> A bisect (full log below) identified this patch as introducing the
>>> failure. Bisected it on the tag "next-20240228" at repo
>>> "https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git".
>>>
>>> This works fine on  Linux version 6.8.0-rc6
>>
>> Hi Aishwarya,
>>
>> Can you try the attached patch and see if it fixes the failure? I changed
>> the test to accept XFS dev as input, mount XFS on a temp folder under /tmp,
>> and skip if no XFS is mounted.
>
> Please try this updated one. It allows you to specify a XFS device path
> in SPLIT_HUGE_PAGE_TEST_XFS_PATH env variable, which is passed to
> split_huge_page_test in run_vmtests.sh. It at least allow CI/CD to run
> the test without too much change.

OK. This hopefully will be my last churn. Now split_huge_page_test accepts
a path that is backed by XFS and run_vmtest.sh creates a XFS image in /tmp,
mounts it in /tmp, and gives the path to split_huge_page_test. I tested
it locally and it works. Let me know if you have any issue. Thanks.

--
Best Regards,
Yan, Zi

--=_MailMate_144E51E7-D085-4541-BC72-FA5719E89265_=
Content-Disposition: attachment; filename=selftest.patch
Content-ID: <5F4E1CC9-131B-409F-B501-01B12E37E49C@nvidia.com>
Content-Type: text/plain; name=selftest.patch
Content-Transfer-Encoding: quoted-printable

diff --git a/tools/testing/selftests/mm/run_vmtests.sh b/tools/testing/se=
lftests/mm/run_vmtests.sh
index fe140a9f4f9d..ffdec5dc0b03 100755
--- a/tools/testing/selftests/mm/run_vmtests.sh
+++ b/tools/testing/selftests/mm/run_vmtests.sh
@@ -412,7 +412,27 @@ CATEGORY=3D"thp" run_test ./khugepaged -s 2
 =

 CATEGORY=3D"thp" run_test ./transhuge-stress -d 20
 =

-CATEGORY=3D"thp" run_test ./split_huge_page_test
+# Try to create XFS if not provided
+if [ -z "${SPLIT_HUGE_PAGE_TEST_XFS_PATH}" ]; then
+    if test_selected "thp"; then
+        if grep xfs /proc/filesystems &>/dev/null; then
+            XFS_IMG=3D$(mktemp /tmp/xfs_img_XXXXXX)
+            SPLIT_HUGE_PAGE_TEST_XFS_PATH=3D$(mktemp -d /tmp/xfs_dir_XXX=
XXX)
+            truncate -s 314572800 ${XFS_IMG}
+            mkfs.xfs -q ${XFS_IMG}
+            mount -o loop ${XFS_IMG} ${SPLIT_HUGE_PAGE_TEST_XFS_PATH}
+            MOUNTED_XFS=3D1
+        fi
+    fi
+fi
+
+CATEGORY=3D"thp" run_test ./split_huge_page_test ${SPLIT_HUGE_PAGE_TEST_=
XFS_PATH}
+
+if [ -n "${MOUNTED_XFS}" ]; then
+    umount ${SPLIT_HUGE_PAGE_TEST_XFS_PATH}
+    rmdir ${SPLIT_HUGE_PAGE_TEST_XFS_PATH}
+    rm -f ${XFS_IMG}
+fi
 =

 CATEGORY=3D"migration" run_test ./migration
 =

diff --git a/tools/testing/selftests/mm/split_huge_page_test.c b/tools/te=
sting/selftests/mm/split_huge_page_test.c
index cf09fdc9ef22..0b367affaa0d 100644
--- a/tools/testing/selftests/mm/split_huge_page_test.c
+++ b/tools/testing/selftests/mm/split_huge_page_test.c
@@ -26,7 +26,6 @@ uint64_t pmd_pagesize;
 =

 #define SPLIT_DEBUGFS "/sys/kernel/debug/split_huge_pages"
 #define SMAP_PATH "/proc/self/smaps"
-#define THP_FS_PATH "/mnt/thp_fs"
 #define INPUT_MAX 80
 =

 #define PID_FMT "%d,0x%lx,0x%lx,%d"
@@ -268,7 +267,37 @@ void split_file_backed_thp(void)
 	ksft_exit_fail_msg("Error occurred\n");
 }
 =

-void create_pagecache_thp_and_fd(const char *testfile, size_t fd_size, i=
nt *fd, char **addr)
+bool prepare_thp_fs(const char *xfs_path, char *thp_fs_template,
+		const char **thp_fs_loc)
+{
+	if (xfs_path) {
+		*thp_fs_loc =3D xfs_path;
+		return false;
+	}
+
+	*thp_fs_loc =3D mkdtemp(thp_fs_template);
+
+	if (!*thp_fs_loc)
+		ksft_exit_fail_msg("cannot create temp folder\n");
+
+	return true;
+}
+
+void cleanup_thp_fs(const char *thp_fs_loc, bool created_tmp)
+{
+	int status;
+
+	if (!created_tmp)
+		return;
+
+	status =3D rmdir(thp_fs_loc);
+	if (status)
+		ksft_exit_fail_msg("cannot remove tmp dir: %s\n",
+				   strerror(errno));
+}
+
+int create_pagecache_thp_and_fd(const char *testfile, size_t fd_size, in=
t *fd,
+		char **addr)
 {
 	size_t i;
 	int dummy;
@@ -277,7 +306,7 @@ void create_pagecache_thp_and_fd(const char *testfile=
, size_t fd_size, int *fd,
 =

 	*fd =3D open(testfile, O_CREAT | O_RDWR, 0664);
 	if (*fd =3D=3D -1)
-		ksft_exit_fail_msg("Failed to create a file at "THP_FS_PATH);
+		ksft_exit_fail_msg("Failed to create a file at %s\n", testfile);
 =

 	for (i =3D 0; i < fd_size; i++) {
 		unsigned char byte =3D (unsigned char)i;
@@ -299,7 +328,7 @@ void create_pagecache_thp_and_fd(const char *testfile=
, size_t fd_size, int *fd,
 =

 	*fd =3D open(testfile, O_RDWR);
 	if (*fd =3D=3D -1) {
-		ksft_perror("Failed to open a file at "THP_FS_PATH);
+		ksft_perror("Failed to open testfile\n");
 		goto err_out_unlink;
 	}
 =

@@ -314,26 +343,37 @@ void create_pagecache_thp_and_fd(const char *testfi=
le, size_t fd_size, int *fd,
 		dummy +=3D *(*addr + i);
 =

 	if (!check_huge_file(*addr, fd_size / pmd_pagesize, pmd_pagesize)) {
-		ksft_print_msg("No large pagecache folio generated, please mount a fil=
esystem supporting large folio at "THP_FS_PATH"\n");
-		goto err_out_close;
+		ksft_print_msg("No large pagecache folio generated, please provide a f=
ilesystem supporting large folio\n");
+		unlink(testfile);
+		ksft_test_result_skip("Pagecache folio split skipped\n");
+		return -2;
 	}
-	return;
+	return 0;
 err_out_close:
 	close(*fd);
 err_out_unlink:
 	unlink(testfile);
 	ksft_exit_fail_msg("Failed to create large pagecache folios\n");
+	return -1;
 }
 =

-void split_thp_in_pagecache_to_order(size_t fd_size, int order)
+void split_thp_in_pagecache_to_order(size_t fd_size, int order, const ch=
ar *fs_loc)
 {
 	int fd;
 	char *addr;
 	size_t i;
-	const char testfile[] =3D THP_FS_PATH "/test";
+	char testfile[INPUT_MAX];
 	int err =3D 0;
 =

-	create_pagecache_thp_and_fd(testfile, fd_size, &fd, &addr);
+	err =3D snprintf(testfile, INPUT_MAX, "%s/test", fs_loc);
+
+	if (err < 0)
+		ksft_exit_fail_msg("cannot generate right test file name\n");
+
+	err =3D create_pagecache_thp_and_fd(testfile, fd_size, &fd, &addr);
+	if (err)
+		return;
+	err =3D 0;
 =

 	write_debugfs(PID_FMT, getpid(), (uint64_t)addr, (uint64_t)addr + fd_si=
ze, order);
 =

@@ -351,6 +391,7 @@ void split_thp_in_pagecache_to_order(size_t fd_size, =
int order)
 	}
 =

 out:
+	munmap(addr, fd_size);
 	close(fd);
 	unlink(testfile);
 	if (err)
@@ -362,6 +403,10 @@ int main(int argc, char **argv)
 {
 	int i;
 	size_t fd_size;
+	char *optional_xfs_path =3D NULL;
+	char fs_loc_template[] =3D "/tmp/thp_fs_XXXXXX";
+	const char *fs_loc;
+	bool created_tmp;
 =

 	ksft_print_header();
 =

@@ -370,6 +415,9 @@ int main(int argc, char **argv)
 		ksft_finished();
 	}
 =

+	if (argc > 1)
+		optional_xfs_path =3D argv[1];
+
 	ksft_set_plan(3+9);
 =

 	pagesize =3D getpagesize();
@@ -384,8 +432,11 @@ int main(int argc, char **argv)
 	split_pte_mapped_thp();
 	split_file_backed_thp();
 =

+	created_tmp =3D prepare_thp_fs(optional_xfs_path, fs_loc_template,
+			&fs_loc);
 	for (i =3D 8; i >=3D 0; i--)
-		split_thp_in_pagecache_to_order(fd_size, i);
+		split_thp_in_pagecache_to_order(fd_size, i, fs_loc);
+	cleanup_thp_fs(fs_loc, created_tmp);
 =

 	ksft_finished();
 =


--=_MailMate_144E51E7-D085-4541-BC72-FA5719E89265_=--

--=_MailMate_66DFA667-0A53-41D6-BBC8-0952C7B6C472_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEE6rR4j8RuQ2XmaZol4n+egRQHKFQFAmXiREIPHHppeUBudmlk
aWEuY29tAAoJEOJ/noEUByhU5OQQAJvqGnNYPeBOe4Puk/gYEe8roR0mxAUv2yHR
Bl9LedJmGIZv6M7l3nwJtD36kR184IGmqi9m3F1EqMuNFaV2/kQrz1milCywnv4S
tlE2L0DP5kSuBu08YnpcmO0M2xIczz7AwMkt4d+hoMt0zWHhcnlvXjW0wHBWr8Vf
UNTBrxHt/v2svNaq565AT9O+YvINKVVHclJirYfor3syA45ozPq4k4/mhqlPqyid
kIPdTQp3wcCapSkly1KC8O5ZusHfhxGqpZk1kOg0RQuFuQBxsff3LUrKzx4d8/09
3DxA9NfvrBZpvPPd8i9NU947DlTgdrDqyka3ALqp7qG5hs0fOlbOIIRRPkbc0xCa
zjEl3duMndnq5sHjpHDyffRMRNYYytejPDSKBa2blltoVU2b72vTF0J3gl5APcmt
Iy5/5QdpDrw3q5+VJEYbHe6q3mgL/GhdANWSH/57SWc9yqraBVawJFh/2n/RjnY6
9RyRGM4lj+7RnqSXQGB1olHkL7J82si0leYbWCZ/3i1wU1XfHhVKBTvmq8Qv2ieM
8PZ+QVBkOs0kWQPe4taA5gPKIcIU/6t8UbczqesdSCjVWbDroTjaAsHF4IkddvNd
zn8BHfjBb4EwNNIzuuT+J7x1pH8HHFpEQbszKI81TcZmxUgana4Xj77rqQPmpVQB
5/+U0Hl7
=mkXe
-----END PGP SIGNATURE-----

--=_MailMate_66DFA667-0A53-41D6-BBC8-0952C7B6C472_=--

