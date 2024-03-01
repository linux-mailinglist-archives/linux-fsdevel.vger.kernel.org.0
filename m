Return-Path: <linux-fsdevel+bounces-13332-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D4A8886EA07
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Mar 2024 21:02:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E728288C18
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Mar 2024 20:02:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C9E63BB41;
	Fri,  1 Mar 2024 20:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="kydNAEjg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2055.outbound.protection.outlook.com [40.107.243.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BE7E8F5F;
	Fri,  1 Mar 2024 20:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709323364; cv=fail; b=FR6oBNVIzzlsV9CxKHzcrcUWy+llRtKA/JEXmuJHtoS+E8RkegNwhFq9b8zJ0SIcfNVZ8jDcUCyHjhJC3SdMJ+KxQVMjb6Jj2EpuzioMGoAdxdF2lqCjRc6zZyOoVCMpyQXwG1AKoKzAC0zOpkPXGUBxLyhAkEKE9UfRAsgGodY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709323364; c=relaxed/simple;
	bh=ypq8hQAnO8W/ihly+MMmV3yRHOPpEydpVgCDCjbipjs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Ca32sMfcjruhM6vjpixQBXzyTwIy4DdMuGQPfeTXKQVpZvROtX0XcRaQLhM67wIGHT5CsPMSaFUs0yCWjXHf1F7gkODfISrFaFosXxrzwIbyApmLFJ2RFqqtsP4N/Uw3JlifuWJTyKURmoZdWxj26FcJTD3M/PTsSZmuk/Wy5A4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=kydNAEjg; arc=fail smtp.client-ip=40.107.243.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a7wNsZAEP/4sjwtlB3R4I0edoUP2gQxDc/0XsVdOi6bG0c6X2HUlRGQTWpySZJ2I2pvgpWE8O6lNJVpu/ClngRk53FqnyC/Nf+kXR9ulgffS5DX0C6BrtOqFP+e95P0PhSoBlRhB2wXiiZbkpws9drOYnRuWTol8FAymDWo2RkF6mZW+o6gftjrckQpNrhdwHobjMroOrvl4ysUzssYzOc8MkKwK9ZZsbXg0Tjzku+g9Yu/4CAQR/79/sUbxiz1/sBEniqrAkAWudDVLVb50LiUX4o4th3n7cipEUP7WRh7oQQxgrbkfVsMWa7R10VY+KGBJsPL7YrqwkpN8CdHITg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gR5ATi6fqnHKbBmXoB1B7L/HfGr/FArU85SF8zhegbI=;
 b=efSC+Qbc/ye/Qff+3serzAaafkOTgh/a1RKX3IZxnZmgjbPP21HppeXV5kHlNRsM4Y/xY90fDOEXLcMpz7ElU/jclgDaPs+cfDWjOPgqznI/8hOWJrj1Tu4LmFws8n7+Prp4/NT+DHpsZeo3y5RciC2z9ON3kRG/4LTd5YtVx/4ebyH4gmcrckvTlbmfMqyCdsjuJpcROIXjvMDQPus6W8iOgD+yoFiFdQVZ/vzB4VvOpqCzJPqyh6dk5so352unp92tnCkvri9y1B0/HWVwKuUwrc3GDVXW7IRfCC9ntQo5OwQtEhQVWYBYYORvV0zqHHvVWx8eBrJkDHpQ4hmFFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gR5ATi6fqnHKbBmXoB1B7L/HfGr/FArU85SF8zhegbI=;
 b=kydNAEjgQWaNdyYVsU+/Q/0Vs/Jqhf13i3LVIdN4bSIP0iYbzw/xnx2nyRaalEs10QWz8T/dCQWIGpjsIog4VLeutK8xkHxULDrr2ED0eaST8T0UZa2/XxFPJdg0C6qvTNrx8YJ5TZABnq1RTh6wrsUqBIUxWegbpsKkDiNRIY9L3Gf+MmENKIpkGth3l7M9FdfzpzLdncIcGrYqHWjdS0PvucfB7ixcJSb/ULlZYww1W9uJ23l3gjBPXViUlo0x9+uUtG69mdaQuOjK0CKcnSkwhVaQm7GD/0sYPaqzRD239y34e1ClTMTHUKxRqTpXtVjoNt5GVRynVPOaeaaMQQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB5744.namprd12.prod.outlook.com (2603:10b6:8:73::18) by
 LV8PR12MB9270.namprd12.prod.outlook.com (2603:10b6:408:205::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.41; Fri, 1 Mar
 2024 20:02:38 +0000
Received: from DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::dc5c:2cf1:d5f5:9753]) by DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::dc5c:2cf1:d5f5:9753%6]) with mapi id 15.20.7339.033; Fri, 1 Mar 2024
 20:02:38 +0000
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
Date: Fri, 01 Mar 2024 15:02:35 -0500
X-Mailer: MailMate (1.14r6018)
Message-ID: <7E498B77-6CC9-4FC6-B980-D79EEC548CD0@nvidia.com>
In-Reply-To: <A111EB95-0AF5-4715-82A4-70B8AD900A93@nvidia.com>
References: <20240226205534.1603748-1-zi.yan@sent.com>
 <20240226205534.1603748-9-zi.yan@sent.com>
 <082e48c8-71b7-4937-a5da-7a37b4be16ba@arm.com>
 <A111EB95-0AF5-4715-82A4-70B8AD900A93@nvidia.com>
Content-Type: multipart/signed;
 boundary="=_MailMate_E6B89F4F-A6CE-4D92-9F77-704DC444C51A_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: BL1PR13CA0253.namprd13.prod.outlook.com
 (2603:10b6:208:2ba::18) To DS7PR12MB5744.namprd12.prod.outlook.com
 (2603:10b6:8:73::18)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB5744:EE_|LV8PR12MB9270:EE_
X-MS-Office365-Filtering-Correlation-Id: 75f5d93e-b240-4274-7124-08dc3a2a8b99
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	KY0WFXdcuK3ZfagIk7G4PrtaZW69LjZqOxA4/Nyi0uTxkGlyVylPjnFAKOr6sb721zqlDmkOYGLMDH/c1PVI3lLpif4NYnYmiyK7LUC02wcjIFBr/f5febhZteA6ARbAvdUqNqGb1vFO/kXvFTYjBiWv2kk2H8IcuV858lSsrTLx+FPhBS9I0AP6ZUTGSF+iLlQhMWxu+Zv/Q686uU1t34/7BamerN97Glmj1P8kZq+9GIaVpduUUTqgiIZn4wvjAAaXpxBqawS79qXdWgE9EcMFm6KWF4iuoSzM8u/5HeSZzEZslR0EdJJReSgzdpiFFHlqnbI1yiW8B+2RA2Brcvuiw5SGT+6KoH047VjC0p1UG8XaUw9DKC3Bj988BHWBmEkAWcXmOoMAnNwXniDC3LxQpGeFDwGJ6AfB0LzJRUyB5i5zdD3gRYrAGW4YjtsF+5Fjt6ymp5pnAiVJ4O9R3hkNSXxs8tkqIqWFV140xknVs2Q7k6ObUdY+nieTbbEypp66Y8xk+aU06CTHRNK9SRkxVBlAGG+m4l2y6Ln0IwzBIIDCpKvXICI2WIotUdHGpF3T0555VyOOJcm3M53v89d/pyhQQBjTfzInF+o9X81Hz4zEFyk3vvxR1ijbw1BRGRBrKyY+CoSsb5U+MhHk+g==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB5744.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?XyhQIcWrKNYA0KVk4xm85dhujhxKL8z8CN+fSZ9CHw3fij4C1vWkPbBjgaqu?=
 =?us-ascii?Q?C5O9WM27+w2DuvVT79IuBo19MAlH+54NHpwIRuj3+Up4PWf7MPtESdHG5Abr?=
 =?us-ascii?Q?IeR40rnrz/Bqua7z3lPEtopY4GNJl1yaMps4easLa+hP9MpgzlNYuGXGGaeA?=
 =?us-ascii?Q?6nEDZjjPGOShMEXRAxC4NbKpeoasS0ppBW+3RnMFnm8SBaWQm1a1t3BQWQpc?=
 =?us-ascii?Q?2JgueAFD6fyYU3lbehkyZGFG7XBIQVZknOalKLOscDMKmVD6kctF6Bmgt0S2?=
 =?us-ascii?Q?TgomPXosXHTrmBzDOfnUxtKRCcKjMQuLSDYUV75diM+zxE/QyTH6fk5Fmbjw?=
 =?us-ascii?Q?SbYYpAhl+oCOfJ78WzEy16cyn8o+OyG8zoL8uQn/GvU1jdbU6urbiJ9FT6gG?=
 =?us-ascii?Q?s3lPrkfHL2tz/i3ddzPiC1mqleMAt65Amb9l0DeCfD8hvWN3NVEzZU84Zlj8?=
 =?us-ascii?Q?M8ky3ZFyg374x+jkNW4wfm5ZxqI+PyQ0XoZIqRfSJq1NPWpyfcVa7FyY97uv?=
 =?us-ascii?Q?XZ7aDJGRLNzNyzLtgraBHp/AV1s+4oxhFEFv5eiQpJefMOvsaqp6SEVjoujx?=
 =?us-ascii?Q?xMWolMdi4lnF0nZvxSIspmeExbAmOoBC3J/gGgCIj6bPMxCBkooWwkZ5Tboc?=
 =?us-ascii?Q?CGa0AJLXRnoKSvmtpNf7ugm4iOBZ+bg1vfxDeEFvb96yNbPcqD1pcmR1tT98?=
 =?us-ascii?Q?tCGCv3ZRtNYPIkWbDDnwj9f+3wxu9SpQhaL093XypOgYlHSSqFS8Vtnz5nfM?=
 =?us-ascii?Q?wH4anAB90TMvVhGpXBGTJViy3LKesAyQyiqBO7WjgdI4caMsZ1Z6jCUadMxD?=
 =?us-ascii?Q?7/uZB2lyBRazQlELTvP1TvDZ2c6p8G+ViIPG3Fj/UU5CGe/VaBBl0NPqHpVw?=
 =?us-ascii?Q?WswM7o0xK1uk6FeVMYB2TU70mJJ/ppQFf7mlj9SP8R/SDkIAJwI+00KFG7sJ?=
 =?us-ascii?Q?AjW3bWxmv37ZZUWK9hRBnmrsCCkBwcmwlTUOyQMbe9uv6pyWBECrT5FDdBoo?=
 =?us-ascii?Q?aTUXyQIY5OSaD8CUz3gNNtvr2A6bywtsCO6Q5pslhBalOHXAcQIX+uCHZrsn?=
 =?us-ascii?Q?0dBh0tGklSU8OoI+PbsZxXSce6OzHd5/a7QQ9Bu4IbDwGPqIXLzL/RYPnkRo?=
 =?us-ascii?Q?ioAcQw1eADEMc+NRyvCsS1fTOXGtOOtiGZ82FLinWz9jmxm+kAsbYOrKSCAC?=
 =?us-ascii?Q?PCzde16VeYRU1lmP/Cs60ASMTnlDtF8rKPdUDUWK1AoM9LxSkVl3USIMq7jI?=
 =?us-ascii?Q?TRRtaftkglZQoQKrkxS6CpPl8CdkVJrNkJHCcyz4Xt/SbnmKuQQUnRJNjqFB?=
 =?us-ascii?Q?tCtoDR443whDaL2m3tEbYR/1p+0MggpUgbit7oeGXMm/GleEkD6m9y70dsae?=
 =?us-ascii?Q?3GlhlOpjOvH9QNvTd74bgWU0eCnjUywWW+hSLs1TzWA8WS8ktlRdcvmgvhlE?=
 =?us-ascii?Q?GXzELni7m7R8WXWRmU0NEGoNsYaSQCThUn8sR/CrB3BgBL/YocW2+SyU4Eqf?=
 =?us-ascii?Q?ANc24FydrrSuMdaKSNLXKK6axtpDPGSxTynI2ZNqjUCXhZunkQmuKEyQpUR4?=
 =?us-ascii?Q?mGxGsjIkKeielM5PpRaR4GLF/4sNXd1928rNN5jj?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75f5d93e-b240-4274-7124-08dc3a2a8b99
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5744.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2024 20:02:38.6785
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5DG5qd0bLRwsVpCKRLZUfvwQva507nb8VP5CuBV2TL3FyMde1VZ4X4FsPfb3qWZ9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9270

--=_MailMate_E6B89F4F-A6CE-4D92-9F77-704DC444C51A_=
Content-Type: multipart/mixed;
 boundary="=_MailMate_C1672DF9-8843-4915-92AE-5BBD0F2FC0F2_="


--=_MailMate_C1672DF9-8843-4915-92AE-5BBD0F2FC0F2_=
Content-Type: text/plain

On 1 Mar 2024, at 14:37, Zi Yan wrote:

> On 1 Mar 2024, at 4:51, Aishwarya TCV wrote:
>
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
>>
>> A bisect (full log below) identified this patch as introducing the
>> failure. Bisected it on the tag "next-20240228" at repo
>> "https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git".
>>
>> This works fine on  Linux version 6.8.0-rc6
>
> Hi Aishwarya,
>
> Can you try the attached patch and see if it fixes the failure? I changed
> the test to accept XFS dev as input, mount XFS on a temp folder under /tmp,
> and skip if no XFS is mounted.

Please try this updated one. It allows you to specify a XFS device path
in SPLIT_HUGE_PAGE_TEST_XFS_PATH env variable, which is passed to
split_huge_page_test in run_vmtests.sh. It at least allow CI/CD to run
the test without too much change.

--
Best Regards,
Yan, Zi

--=_MailMate_C1672DF9-8843-4915-92AE-5BBD0F2FC0F2_=
Content-Disposition: attachment; filename=selftest.patch
Content-ID: <A694A93E-BA63-4389-80AA-333F1C112AFB@nvidia.com>
Content-Type: text/plain; name=selftest.patch
Content-Transfer-Encoding: quoted-printable

diff --git a/tools/testing/selftests/mm/run_vmtests.sh b/tools/testing/se=
lftests/mm/run_vmtests.sh
index fe140a9f4f9d..22e45207cf6b 100755
--- a/tools/testing/selftests/mm/run_vmtests.sh
+++ b/tools/testing/selftests/mm/run_vmtests.sh
@@ -412,7 +412,7 @@ CATEGORY=3D"thp" run_test ./khugepaged -s 2
 =

 CATEGORY=3D"thp" run_test ./transhuge-stress -d 20
 =

-CATEGORY=3D"thp" run_test ./split_huge_page_test
+CATEGORY=3D"thp" run_test ./split_huge_page_test ${SPLIT_HUGE_PAGE_TEST_=
XFS_PATH}
 =

 CATEGORY=3D"migration" run_test ./migration
 =

diff --git a/tools/testing/selftests/mm/split_huge_page_test.c b/tools/te=
sting/selftests/mm/split_huge_page_test.c
index cf09fdc9ef22..047883473b84 100644
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
@@ -268,7 +267,45 @@ void split_file_backed_thp(void)
 	ksft_exit_fail_msg("Error occurred\n");
 }
 =

-void create_pagecache_thp_and_fd(const char *testfile, size_t fd_size, i=
nt *fd, char **addr)
+bool prepare_thp_fs(const char *xfs_dev_loc, char *thp_fs_template,
+		const char **thp_fs_loc)
+{
+	bool mounted =3D false;
+
+	*thp_fs_loc =3D mkdtemp(thp_fs_template);
+
+	if (!*thp_fs_loc)
+		ksft_exit_fail_msg("cannot create temp folder\n");
+
+	if (xfs_dev_loc) {
+		int status =3D mount(xfs_dev_loc, *thp_fs_loc, "xfs", 0, NULL);
+
+		if (status)
+			ksft_exit_fail_msg("Unable to mount xfs for testing\n");
+		mounted =3D true;
+	}
+	return mounted;
+}
+
+void cleanup_thp_fs(const char *thp_fs_loc, bool mounted)
+{
+	int status;
+
+	if (mounted) {
+		status =3D umount(thp_fs_loc);
+		if (status)
+			ksft_exit_fail_msg("Unable to umount %s\n",
+					   thp_fs_loc);
+	}
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
@@ -277,7 +314,7 @@ void create_pagecache_thp_and_fd(const char *testfile=
, size_t fd_size, int *fd,
 =

 	*fd =3D open(testfile, O_CREAT | O_RDWR, 0664);
 	if (*fd =3D=3D -1)
-		ksft_exit_fail_msg("Failed to create a file at "THP_FS_PATH);
+		ksft_exit_fail_msg("Failed to create a file at %s\n", testfile);
 =

 	for (i =3D 0; i < fd_size; i++) {
 		unsigned char byte =3D (unsigned char)i;
@@ -299,7 +336,7 @@ void create_pagecache_thp_and_fd(const char *testfile=
, size_t fd_size, int *fd,
 =

 	*fd =3D open(testfile, O_RDWR);
 	if (*fd =3D=3D -1) {
-		ksft_perror("Failed to open a file at "THP_FS_PATH);
+		ksft_perror("Failed to open testfile\n");
 		goto err_out_unlink;
 	}
 =

@@ -314,26 +351,37 @@ void create_pagecache_thp_and_fd(const char *testfi=
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

@@ -351,6 +399,7 @@ void split_thp_in_pagecache_to_order(size_t fd_size, =
int order)
 	}
 =

 out:
+	munmap(addr, fd_size);
 	close(fd);
 	unlink(testfile);
 	if (err)
@@ -360,8 +409,11 @@ void split_thp_in_pagecache_to_order(size_t fd_size,=
 int order)
 =

 int main(int argc, char **argv)
 {
-	int i;
+	int i, mounted;
 	size_t fd_size;
+	char *optional_xfs_dev_loc =3D NULL;
+	char fs_loc_template[] =3D "/tmp/thp_fs_XXXXXX";
+	const char *fs_loc;
 =

 	ksft_print_header();
 =

@@ -370,6 +422,9 @@ int main(int argc, char **argv)
 		ksft_finished();
 	}
 =

+	if (argc > 1)
+		optional_xfs_dev_loc =3D argv[1];
+
 	ksft_set_plan(3+9);
 =

 	pagesize =3D getpagesize();
@@ -384,8 +439,11 @@ int main(int argc, char **argv)
 	split_pte_mapped_thp();
 	split_file_backed_thp();
 =

+	mounted =3D prepare_thp_fs(optional_xfs_dev_loc, fs_loc_template,
+				 &fs_loc);
 	for (i =3D 8; i >=3D 0; i--)
-		split_thp_in_pagecache_to_order(fd_size, i);
+		split_thp_in_pagecache_to_order(fd_size, i, fs_loc);
+	cleanup_thp_fs(fs_loc, mounted);
 =

 	ksft_finished();
 =


--=_MailMate_C1672DF9-8843-4915-92AE-5BBD0F2FC0F2_=--

--=_MailMate_E6B89F4F-A6CE-4D92-9F77-704DC444C51A_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEE6rR4j8RuQ2XmaZol4n+egRQHKFQFAmXiNFsPHHppeUBudmlk
aWEuY29tAAoJEOJ/noEUByhUkb0P/RF0K1l4H7AKxP+74NW0vu0pct6Hb3dHxh6L
L0M/tgxx2hR6hOzqaW/FmHITpqVtmq4Uyvxt3Swx3pNO9gGXDX2nUmBxpWDbnElC
Bq+8Wh8Q4YEmTDKG6uFiAkfDrVcYlEfTQXg3ipGSO0ZRYe10ySg7BjAHwSNn3OWy
CIa3of4UEPU90RK+AIzDAIPIp13ahprZdL6dSCIhh5JpryA/vDi8TtJjz5o9CzpC
zqjFC5Fh9FfxL/cbfxfpylH7G9B5U8a2g+qa7vCkVe3fC2WTgGnW1RDHGrk59WLE
ncOWv+N+jHIiqYc7JCVtHxeIZ6TOiJSYtPZZMulLwvS4tW0/ikp/BhfyrIDRDaPs
WY9emlz9D4mSTbX4NFL+wmqeYLmnZH/aCzYUadOWsr9Q6J3oMVYqokpi4HWdWD3S
4GOMJI95oNBE4Qmxcq51WFpsLI0UKptsw6zm5kx/215YK7vOQZMZEqeabHUMT7WJ
H4s94oPhSKk0zwBI7LwWQLzeQDZRU/7LG014tu2NU7JKpE4kcferQRyProiVG9BW
BCEQNxvDcczf6GDO+VH8gvTvQXGOH61vgaMUDEQLArHRbJHzqXk5PN0Y1doZv6z+
I+OGEq3Rs7ryp7v4Vl7lC8Bi8jgg+vR/I/A8//KHtcV1GKA2ZAsLn4yZDY+NKMnf
vIRd6itE
=dzGr
-----END PGP SIGNATURE-----

--=_MailMate_E6B89F4F-A6CE-4D92-9F77-704DC444C51A_=--

