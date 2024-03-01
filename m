Return-Path: <linux-fsdevel+bounces-13330-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FC9686E9B0
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Mar 2024 20:37:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5478F286A4A
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Mar 2024 19:37:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6D3C3B298;
	Fri,  1 Mar 2024 19:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="B3hBGGBo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2071.outbound.protection.outlook.com [40.107.244.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C84A15C4;
	Fri,  1 Mar 2024 19:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709321852; cv=fail; b=aATrSNnAtz/yLBfCbGBvrem5AitWMWvZZzabaay1NtvCewqnohatBXnKWWuirbW5UFk2d2Azu16GuHc4YtQGE91JO11MzomKlFzVIxOTbsSTfVWmauT3/HVZeennHjnESZ68IOOUVVj63MbDFy8bkgm4C5jego1yz9H5QWgMShs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709321852; c=relaxed/simple;
	bh=lG6dfqM8HiD8IozFCBNIg8DgVsLtzQmgJAnUttlWnkU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HI4KHQ3qZiiLpTT3/uaubeBkEpSXTvYTyL/j1rML9/mU4oMeMrtaKr8J3nWiFhtoNc8aHwaOV7T5XXujuWGO6LeLEHab96u470C0Bm7EYkishHvmOgO7nu8MJ8Jfz8bukOnrAzxeJJdVufidKVG6A/GK7E7DmA1V7bSeZhGPaMY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=B3hBGGBo; arc=fail smtp.client-ip=40.107.244.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LfCBTeZhyANyMkCNj9F8dJq8OlxaNQkY7dsD0ZHtvcS/Jg3If71nsWLCOh3y/9IILS+ZBqAMJHp1ikkXxe4LuXPmq5/SynknSTbw9KOYI6hIvwbXSw6/l0d3E/4DX/1/kT2l7ixRnyeohEvVg+HZMjMSXAGdUxNSVQvdDsf6l+OCzHMKITscaksqeqIGqhyUr39HirLKSY8sUKDD7afjH7Mdac9i+qT/1YFMtv9rtmmRtqfQpuvpkm/2uh9uKHcS806tI03ho1+SfFbfV0Bp4SZ2flvmbdZOy595AKGQw/uFsbnzn8b4j1qsep9ITBZgSK5X3XNuWcDhj7fPZDKlkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8tI66F1uK0z5XsMAj/YSaN5DwKCxnC7vCFiEVaB76d8=;
 b=nvBvzEsslcAKYkWWVtTTMz/2A1XpDlOWLR++C+F0K3YIiERmO3WmhUNXr8aLmh0tQP/DDbNo1xeK6RXci30FOo9fYTqGrhXz5ghdJvjCdVGAygzA8dUYUWasM1vYoR3wNftr3TIDRXf+3iUUs8ph6tn1VyjenwoVqUxx1czkBHrfVmiXEdFGPhJyph+0csT5KcqXwO/fqpsm+81DNiDrUIbOzzPvLQUu3kgNfjJxnBgzCDIamr/pMAYsDQzuHCvLWMj0rxFshpSpqkFk2q1cpCgSbiJUNfAieEmwnq7kfXoKI6CymjWU0yFLIXjmykEtez6h2FE4K8x+tHUZZVIJTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8tI66F1uK0z5XsMAj/YSaN5DwKCxnC7vCFiEVaB76d8=;
 b=B3hBGGBoT1mKGasT1y9x7Rb7N2xBCbpBSABz/TahOcgKPXY7eu4ZvHJwmXLVBxl7iRfZlKagnGW68w+TC34HRgYwz0OtwVJQc9CizU0I2Z/hfXjEam2rgZdD1L2qSjkahNVtHEII/dZJvbIIL9HZ08KugvaAOcZhCYQmqdntnB5KkAOZb4fIWsbKF45VB/aCyfFhIn+j1Qc2lWU7IXa1zHtx4exjOuwRiDpiAkVuGuZG+clZNHFjdiXBerSkv71svJzth37dOFg9YJGxTCb14VeMXK44bko2zrF813skP7stSNS6+1W9wDjDWsrBnymiQTh9CZhjMMJorEsJDxEJmA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB5744.namprd12.prod.outlook.com (2603:10b6:8:73::18) by
 SJ0PR12MB6685.namprd12.prod.outlook.com (2603:10b6:a03:478::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.41; Fri, 1 Mar
 2024 19:37:26 +0000
Received: from DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::dc5c:2cf1:d5f5:9753]) by DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::dc5c:2cf1:d5f5:9753%6]) with mapi id 15.20.7339.033; Fri, 1 Mar 2024
 19:37:26 +0000
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
Date: Fri, 01 Mar 2024 14:37:22 -0500
X-Mailer: MailMate (1.14r6018)
Message-ID: <A111EB95-0AF5-4715-82A4-70B8AD900A93@nvidia.com>
In-Reply-To: <082e48c8-71b7-4937-a5da-7a37b4be16ba@arm.com>
References: <20240226205534.1603748-1-zi.yan@sent.com>
 <20240226205534.1603748-9-zi.yan@sent.com>
 <082e48c8-71b7-4937-a5da-7a37b4be16ba@arm.com>
Content-Type: multipart/signed;
 boundary="=_MailMate_B792ACDD-B8D3-4F56-8802-07C7D4F781BE_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: BL1P222CA0023.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:208:2c7::28) To DS7PR12MB5744.namprd12.prod.outlook.com
 (2603:10b6:8:73::18)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB5744:EE_|SJ0PR12MB6685:EE_
X-MS-Office365-Filtering-Correlation-Id: e53814d4-14e6-42fa-f3cf-08dc3a270618
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	oCjQ0k/hZh2PjHZsjwozGMLQ8kYotRIog01nH8jEp06mNxO3YMgU0nkar4VSoH5wvliVIMejW4vjiGVxQ8F/znOTEgItEU2fkdC34uNvjPP0xEfx1Jzajt0A0ZG+RxTkIQgsv3pUUanZ0Lq/C9BoNGsnrX82ZNaEOGANe1925eEqxc+0DYQc348Z5yEK+6jYPO5JQsEStN2Svu6TelDkDfk8ev/UoYZNNPtuyk7FMwXw63J/2RT5NQq+Jq6/ev73zv9tcdXeyClfW324TPMWCuqvRiUOuWPwXkbFEaeVfURLLXugpvifv870VBIqJev1qJD9b82XX5s+rqNAdVKAQL0Xr0gTW1mbFcv+JKnI7S7nQ/WuNIFK9dVXltvJ9epEeFYk1+X1EtvSY8rviFesULMN6vH6MxpLMc5ZezyzZWe/ueB3XzQAMYZ9lpzDMdMn49Mpy/fuI9sqs/MH/adYs1omwtWEtpDXd94OjXIO2W5njIPpCzfGQr2b/XpnZYMWVUairn9OawF55sKt8oiveVu/h8bC7e2iBG4QhPOzfqlpheC9IU3X7YfcGpom4iPWe1O9bOA3Rf2Rek30xzVo+ZlfT0m4XZYqKaSfzPYJZSXbmrWIbtVy6oJ+xkTRq/NUdB2S9UDX+8Bvkpyf/HKRRg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB5744.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?57mpKOK/Fi+YVt5eDi11eYNWsbUZnWItbceAqo/YQ5232al93FrP72CIT37Z?=
 =?us-ascii?Q?rkA6sn5e982CeIoZVZbgWeTNLGTmBqYMjGDKnOJsxdM0wyjH0nBnizqFW61N?=
 =?us-ascii?Q?kjodxW6Z8lO3yoUYMMPT085XSK/EekNSPxYqLMpC59wgshqsRZLDf+rBlV6N?=
 =?us-ascii?Q?HpCQmFXH8yMxtEk5YZqdwM8YtUkuVbw1NjXL8KX2hyjZApvbKAxTrZiWyxWF?=
 =?us-ascii?Q?/bbC+OCylVV5BeUwDN0CcSySb2ZTMPepp59DGEpoO1TY/5XTlhsnUFC6Mvt7?=
 =?us-ascii?Q?mH+13wz1vXWBA/oW3T1HT+KcvKTGKZHDa61DkamMvWg01mQff/0aieOI114m?=
 =?us-ascii?Q?JggN5bzLs+b/yffRn7NIog1ZcbCxGGhrJtm9Jg7tkCjWwPRfC/TxSZ0Hw4b+?=
 =?us-ascii?Q?SUBDsC4L0Krix58T6vo1agqABTRN+b+Rs8h2t/h7WRYel+9x7HfzSriZ0njv?=
 =?us-ascii?Q?v6DwmbzuQkscgoXlzHQZqP3+x62CMsS9qm9ciHxyAPffY1re+qAF4isoFvCW?=
 =?us-ascii?Q?67TorxsRRaz9tehLiW3DW52O7RIkkXa2XE7tVSanrcu+vh1VDIj/Dh72rFCi?=
 =?us-ascii?Q?5QW8lSN9r+CW9Km81DoaeiZsEc5bbwW5X9SJFTVn41NwRWjWml2odfqKWyBC?=
 =?us-ascii?Q?hrI5KDuMDkksuK8JUV9zgXWNg3x+S4oJ5sfTmPy3rXUTV1MAN12CdfPyt9rH?=
 =?us-ascii?Q?zMFVpbrjf3Cs9X0r2Lp8cn/4BSRLIUCO/9KNxvjtQ/8C2iqmzUjA7Q6kKNdt?=
 =?us-ascii?Q?3SSGhnfTNlViibfd7+6m9u7TkbAlzWld52xGwdhIQR36ubs1VcfQrOKJEy16?=
 =?us-ascii?Q?dtg4IZYu6lvm7gV+BK2wFITIjfykRrmRE1/sGv3pis7bxvDI9l7p5h9/2fqv?=
 =?us-ascii?Q?YJPVXqEGk6g4JhS7L50FjBXM4Emm/Z551Mj/hqzV2rQTmXboVzqil1O4swFv?=
 =?us-ascii?Q?c+XQKwNs0HyoYaBBaceU75lqIuCrHROiB1utn0+AhUJddkf1NlZF7sK8vyx+?=
 =?us-ascii?Q?jp26NBeL3VxD6Tg6NSjSryYudBKhEcJVIDLXBoRut+4rb3LssQTe+Uxw54eh?=
 =?us-ascii?Q?JIaZdJexDn7c9kM9KuDAwHZ2ZUby29WMG1nhyvTk15JIiiBf33TBsCmISMNE?=
 =?us-ascii?Q?tIzxJ7NTpu78D1JccZ9JsLvYargqOf21kAkWwIdiNIUw0GviI/su1lZELGBl?=
 =?us-ascii?Q?glx1BXUid3J62TWE/sGalOHY5H5kOD7Kr47KKCOgSyIvwVW9O7c/pWSzH01e?=
 =?us-ascii?Q?Y4CZGqHOcCo/r60GQ6WTbvteXHfgzv4ruBlhNWdnGLOc2m9B66rOwFfVnQH9?=
 =?us-ascii?Q?WZVh5f4rDtPatuSmSnYPw9bns4MlxW4LafKNZ4sF2cgWGAH1SpUJ1bTAbVgh?=
 =?us-ascii?Q?wpXtLQI3/yH5F0zw9w5d/2RXK9qiZo22nrdhndLWoZA/8B9JR/IwADihyQCr?=
 =?us-ascii?Q?OkTs6Ik5EaG85zDEvDVCthoI4hZj3FX2E5PbuSFf3Ff9xKZXU6+3/m3JTweq?=
 =?us-ascii?Q?scqNA0v2nGYYAStxCkPZd+8PPo0zvagueaW/TQwohOAbYjizUP2F+VGYAqlj?=
 =?us-ascii?Q?IbZKUoUI5b1Ttfi7a+k=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e53814d4-14e6-42fa-f3cf-08dc3a270618
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5744.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2024 19:37:26.2141
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xulL2ejy+CZTjygeAS+RRCFYxsqULnFBMwjixiNV1lqrBzAbb7dDVqQAuZsVOPIU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6685

--=_MailMate_B792ACDD-B8D3-4F56-8802-07C7D4F781BE_=
Content-Type: multipart/mixed;
 boundary="=_MailMate_D15C6184-A7F8-48F1-93AC-CC0C520A5D2F_="


--=_MailMate_D15C6184-A7F8-48F1-93AC-CC0C520A5D2F_=
Content-Type: text/plain

On 1 Mar 2024, at 4:51, Aishwarya TCV wrote:

> On 26/02/2024 20:55, Zi Yan wrote:
>> From: Zi Yan <ziy@nvidia.com>
>>
>> It is used to test split_huge_page_to_list_to_order for pagecache THPs.
>> Also add test cases for split_huge_page_to_list_to_order via both
>> debugfs.
>>
>> Signed-off-by: Zi Yan <ziy@nvidia.com>
>> ---
>>  mm/huge_memory.c                              |  34 ++++--
>>  .../selftests/mm/split_huge_page_test.c       | 115 +++++++++++++++++-
>>  2 files changed, 131 insertions(+), 18 deletions(-)
>>
>
> Hi Zi,
>
> When booting the kernel against next-master(20240228)with Arm64 on
> Marvell Thunder X2 (TX2), the kselftest-mm test 'split_huge_page_test'
> is failing in our CI (with rootfs over NFS). I can send the full logs if
> required.
>
> A bisect (full log below) identified this patch as introducing the
> failure. Bisected it on the tag "next-20240228" at repo
> "https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git".
>
> This works fine on  Linux version 6.8.0-rc6

Hi Aishwarya,

Can you try the attached patch and see if it fixes the failure? I changed
the test to accept XFS dev as input, mount XFS on a temp folder under /tmp,
and skip if no XFS is mounted.

Thanks.

--
Best Regards,
Yan, Zi

--=_MailMate_D15C6184-A7F8-48F1-93AC-CC0C520A5D2F_=
Content-Disposition: attachment; filename=selftest.patch
Content-ID: <D2E4B376-0928-40A3-8112-77F9B4B399AD@nvidia.com>
Content-Type: text/plain; name=selftest.patch
Content-Transfer-Encoding: quoted-printable

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


--=_MailMate_D15C6184-A7F8-48F1-93AC-CC0C520A5D2F_=--

--=_MailMate_B792ACDD-B8D3-4F56-8802-07C7D4F781BE_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEE6rR4j8RuQ2XmaZol4n+egRQHKFQFAmXiLnIPHHppeUBudmlk
aWEuY29tAAoJEOJ/noEUByhU6C0P/1AqSUq74Yp4r4mQc/3AZd09ei0KPLx6iK9y
c5eGkIZOsHiLk9FnqczsZTaxQsjXa5jkJeEmXhG1Tz4cRbhAulbkuOuEjRN2/NyB
whQyjDSMQeNMh05doTx8z2Q6+A5kbHKGBeiRLYQcOaCSBIv0d2eAvWjhtcl5uoWi
M5SK3EYeFSWb91skfsllhjkiGIGmNYbkjoxxUPR4Rlp14CEvCAJk72l2G5itO8cx
nmOmmVMcJtvDGoZgU0bg2G9xdEFnZe0rZxM9X0bwSKn8siRU1eg2nq0PLBMdRl/F
PVVT6ie26CkKJFSpho77jkUZfjTkvxyo/pVFtkYbt8CBjcIBMmazpx4GPoSu0Wb6
8rdMf3L057PnDl+Bvp4pR6SDitLvyz4n5j+nb3yUUgT7jghoigdjrlYgfVIc5JlH
i07fE+4tzJyye9WxWwmguWuNF5sLshrerkCi7Ac3ykrz4OfWsMyMGlIrwOkl4U+k
RPtHwqaleH4cHAYHvhN7r51l/YAJzDPCFXbBbB208xUwsqcvUV+FW9cZf8b1d54Y
vQsY+wjiSPxCqC67z9a70U3ZiBWFx+ytAqe5p1voE6pNY0rQrEs6RSQvWAKr0KEg
YwdTmkryI8agZ1paqiiu2FQSkT1JT4DS/X5sKGznO9tLHhge6qDyDCWEHWN4bgVB
aUd+rZQR
=qh3Y
-----END PGP SIGNATURE-----

--=_MailMate_B792ACDD-B8D3-4F56-8802-07C7D4F781BE_=--

