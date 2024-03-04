Return-Path: <linux-fsdevel+bounces-13480-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D65448704A4
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Mar 2024 15:58:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95CD92822A3
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Mar 2024 14:58:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C71AC46450;
	Mon,  4 Mar 2024 14:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="gYdXVTTo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2050.outbound.protection.outlook.com [40.107.94.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CD8FBE4C;
	Mon,  4 Mar 2024 14:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709564315; cv=fail; b=QZrs+IWsz5wWnZYxpORQy2v4OyyP1AXg1V0c9qpye0LmVIcG4KaElIUk4jQMciwrTokWgbYv5W6nwUs4mHDZBEueKz8HgpYghVr2XUgrUQVwEbJYVeZhAT9Q2JBj6YyzTtrKbiUSkdJ57ETYlGVOj2+M+vGBBerxmbDG12HaK6I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709564315; c=relaxed/simple;
	bh=w9Q2JMbJ94fEdVeVrgLB2cKkMJftxYsyUYvXp2WSBXA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Pzlu4fEIj2a0dvgKVtH8ilyXR5YNTFA8F/O/1aPS5Cahb7u48SZ4Svgvn7zQwpVB6k7kQvoCEcHeXl3gXcLA7kOYqwS4KmfNaHmetycDmY6dOsQ2zvLWi1zRMCyDEAcHTkZ3s4AtvejNiESfn4eVZJ+Tdmbw3mi640Xn8d5Pz1k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=gYdXVTTo; arc=fail smtp.client-ip=40.107.94.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AcoIA6HP3nfmM8LDW7WU8qlEDmBmkkx7wVHVKym27Jz0hTnT4tYbTBa6Q6M2/ROfh4o/pCbbIVhMvm8ofPDzUZS7E6s8w2OOkUwvXwdxOpKfm6dmuL7fELxdfIVEeCEF0o0APFBw/9usfd6GqMNjJeLyWxvwVrtx6URHMB5QxaSo0lUBWqpvgkxFi4vj9fyBjrl+seFJNz1RmOTc27BvBQfg1+taMXwqn4efl4qivX52AyHiRdHRIE/kK4fzVKeqoMIIOKo8RIEua9dSCgXwOmZgmWgULPepVYDQr3/gXC8hynNKA/ac+L8bYtHWeAbrQb4tb6n8ae16srjrsxSqVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N4NSrZuHTXnlgE17NK3DNEpsXeINXHPPpCRMhtWZpOs=;
 b=G8wFFfLwY2xz/1Sq8BKc8vQOM7++d2oeYE6mjCtDwF0HFcOr5WJJNoV/9c0u+kJOQzBkhDeDbWQ4J2nHq4xxafJlM8ATM8N8t/RBuWMyitLLhcln0OFPybVKpHsYp5fmu6Mv7xUwKe6GZ5mtBgiDpRs1fftLTApZ+dan7uPmby8GQ6EAIHZebVKJaKPVLCAahYG2bTwIJNhE1xrBuzNPhfOATa9O+Yx5HGuSf8MCDw7yUhkgx8GMOTVBIk8uTcLy+XKOT9wx7gjmjlGQUYKwTSBP0SWfCHij7GZVpMZBJJIkC1v6pGd4+RcSU3YSCP8QEucdhHhz/+Yq1YCZemdq9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N4NSrZuHTXnlgE17NK3DNEpsXeINXHPPpCRMhtWZpOs=;
 b=gYdXVTToePdIQMbyDHI80theWkYrSP43KJauPDhhK+HzfZEBLXeO/LChJknsyn3Gx3zL8XyVpzCFPRXtKZLuTt8ZtUEZgMKokLz1Egt4m9jUoMtr/LKEsz8ztqdxmxvmnDXsKwl2AZtkDBnR1z1yfgC6kYOcpboA1VWLdCyPE/fhpS58Zz2NDVKcHvKQmVf4M+gWfTVq3Fh2LROeqqRhzMv98Pk73dOMC55A9LYebdWdRrg2Gt8R443cH8xKi3BSXYF3X+j8q2zdKCxlwuODK7aDfrBZSXZBuX/yaQ6p68bkd3+ei3WNBAEyIaTnZiwsvDPdaxUzV4+6JUVg65spig==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB5744.namprd12.prod.outlook.com (2603:10b6:8:73::18) by
 SJ2PR12MB7941.namprd12.prod.outlook.com (2603:10b6:a03:4d3::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.38; Mon, 4 Mar
 2024 14:58:30 +0000
Received: from DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::dc5c:2cf1:d5f5:9753]) by DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::dc5c:2cf1:d5f5:9753%6]) with mapi id 15.20.7339.035; Mon, 4 Mar 2024
 14:58:30 +0000
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
Date: Mon, 04 Mar 2024 09:58:26 -0500
X-Mailer: MailMate (1.14r6018)
Message-ID: <1829EABB-7966-4686-A5E0-F6B6D26C510E@nvidia.com>
In-Reply-To: <0be630f0-ce8e-4a80-b42f-697ea603cfc6@arm.com>
References: <20240226205534.1603748-1-zi.yan@sent.com>
 <20240226205534.1603748-9-zi.yan@sent.com>
 <082e48c8-71b7-4937-a5da-7a37b4be16ba@arm.com>
 <A111EB95-0AF5-4715-82A4-70B8AD900A93@nvidia.com>
 <7E498B77-6CC9-4FC6-B980-D79EEC548CD0@nvidia.com>
 <0685EC19-CDB8-4CD3-BC39-82DE59B5D10C@nvidia.com>
 <0be630f0-ce8e-4a80-b42f-697ea603cfc6@arm.com>
Content-Type: multipart/signed;
 boundary="=_MailMate_0E4A5337-559B-4F0D-8587-2225B84783C8_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: MN2PR04CA0010.namprd04.prod.outlook.com
 (2603:10b6:208:d4::23) To DS7PR12MB5744.namprd12.prod.outlook.com
 (2603:10b6:8:73::18)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB5744:EE_|SJ2PR12MB7941:EE_
X-MS-Office365-Filtering-Correlation-Id: 140de327-70ee-451d-c920-08dc3c5b8da2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	CarvptaIiVdxch/vlwztkPnrNyNEk8Px4FDu2rc3kdhX+zLJJYOu77PZmxMBeJ1tTkrPhN9VXYSXqjZbyMQ+lcPFqqU5CYX6JtfHxgdF7ACez0fazEGRMBKpHL1y+vpJaRpOFwDXCiCcyhMNZ3TdelFrifwKSZ9hYLegRQ44TlK6AJsg9xhaf2i02KBXQmh8X63R325DNMeY5SVDjSS8hhLtajcPx29qXR9PNxpPGQVBUalIHXCHpoAxcSvZGYpwbmbcPbJPwzpWNieVeoyEcHVIjZHHILJ0Hj25W4RG8wqnPSzxzXadlEvSgfbgEXFGj6Dvs3c1OveLi6wPpj5/ueHoLgjAmgomW4AL2pN0bTpAxjQST5AJqAaddLT/Ae2KfF/WUvd89+/7NqLipSp2pfmhD0FOr8B0pWJH+tYCUAT6JcoHHcMz3YcLzSTgf+4G/sVcVxPLraDPg3OQp6X1jCSxge1fMhAH0U0MWyG1IFjJof+zPsMCN48yon6MJqcuVnC8wV0ZcLtHgtcoc+uRFBNdomo/RB+DTrDGq2r1QXi/tOvX1HBabLlGzPIPq0Ejx3wO37uW/NM0mqjCpZTznd+QC2a/EItDFaySHD+94yTAHxGh2GAffk34eAUSGLel9MrXm6DEY8EhetKv5mt96ewkJHeo2D152Rh/sHfBj8A=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB5744.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?JruCp0Wr/W8IMoIA1ldBRJc7GXY+SWhlUparEiWGk4d62j2ofKnYzaqIdnWk?=
 =?us-ascii?Q?pBt1szFjIgP8SOUMFSsr5SqffbcyViTbB+JM7RLU/jqNpjebqs9wszqIy3lm?=
 =?us-ascii?Q?c1gj820pecrcGoB2DdagWX+wjBGadxgco8zqo1End9nAC82lqBpECmYu0ce8?=
 =?us-ascii?Q?H5pYxLWpNSLpnlaRnBCFNmlLzCnqR3PP6Lx/2mLE29XfuyAybifb0HIK9KXt?=
 =?us-ascii?Q?FwouhxZrZbzH5IOAXNFEHrW2vGPqoIZy9suJugBHEEqfAUwy/jUSWJd4qsmY?=
 =?us-ascii?Q?Xit6IfDYYFDM3Doqu81VlfBOgDfLflubrnEu9PqY/1XrSRKI5Y3vat61Pqmf?=
 =?us-ascii?Q?8Htu/IW2qSkq+DSahHkvBpLQdlw1PjGuZR4nV1U9YS9XijiGKcjQpgw6t2Xs?=
 =?us-ascii?Q?ujrulmNSQxIznq3b5bMpIHRprIkhx1i9flo74W7Fe4934U9HdAa8Lp3Fbidm?=
 =?us-ascii?Q?7JbKbu7aOkEChHMOtbgxDni2MVdPfbx16uEc+OTTq/pLUicFi+BWGJDbgKww?=
 =?us-ascii?Q?R+w0tBYnTxvOrl07rw1qZb6KcNcZ6YhB333UGiTPb1xDZ2La2sWgW32O546o?=
 =?us-ascii?Q?R6M9ADzV8xGQtTrTvMK0e/OFWdcwxSlAIwRjfqQlv5+XW7GjAWs//ReP3z30?=
 =?us-ascii?Q?E1FBGHmLCDDz7bqc+xhEcTRPzZanP83LKlWfSYdB70wnlnHqIB0lGZV93U1r?=
 =?us-ascii?Q?rFA6G5x4Q5UXRURXHDSKfUMvwgm98o7W8KDBdrJI6Z97md+4gna5b1O/7wsB?=
 =?us-ascii?Q?EItAtqnpWIsc4Bi6GV+NBf0b2NNhYBw0YeXvE7D86l5LjrnU097zbcrdD3u+?=
 =?us-ascii?Q?SkWz534Z/lWi0t/qo3Y5LO/Vao0L3txDaEfDeg3crncTh8B8qAPYFDvtxxwu?=
 =?us-ascii?Q?BA1iwDCG5lvVaStPdDqcylnv9Qv4mC7uh9+8arycTNiYKeZIWw4zy4cMCN/7?=
 =?us-ascii?Q?HfumAfi/a/+inEFI7P5uR/IC/DSL6p2AdRkxWxzQ5C5SrrCTTBJxBo+cGNMF?=
 =?us-ascii?Q?3+TBqba1uuoYRSZ/wiw5Qv4TNqhruWACJmbpWhcV5zWgfGsWyvpW2bDzkC/n?=
 =?us-ascii?Q?48mf3nH+WOePAzS7r2KBGLqldzu/bbRjKmfaCLC7fWMuoCdEpfIOfu7D9ZJY?=
 =?us-ascii?Q?bf/0vwHTIi7r5EHFfgdGobMD2x5g4lRVG0j2ZQRNDvrtMfEiR7p9u+CNOByx?=
 =?us-ascii?Q?PuHYUosNRwEWRTxuWRDvLUbYlzuaGbVB15fJNTXNrwURz/kxQ8tfjM4qi3OI?=
 =?us-ascii?Q?saAMwK8OU2ATZNBWAruB4SR38fvvQcbjKYXx/PLREn1ZVvloMPe2/0at0czy?=
 =?us-ascii?Q?q5bwo9jXribsFIgDw1CXkl2ASiU2OrY2yXpe2C/uNQb8t44Bu3rXPzdpDhYZ?=
 =?us-ascii?Q?4HCqNOcav49WITh5sslVCAn8fnsSW++TfbwMLhXiMtERoZAFcWWPe8uZDiNL?=
 =?us-ascii?Q?Jsc4hJn4GB+qe7MRYNXsUgqeqEdUF2765JEbopNykMXYH/89wlKgwvV7LUDJ?=
 =?us-ascii?Q?AZCuFs65JZk4NxLJSG2i++u/kMhyC0n0nlCvOFL/nePexJy2MfrSQ8H1aP85?=
 =?us-ascii?Q?HJJdkmJ7qwIxzWNl6sM=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 140de327-70ee-451d-c920-08dc3c5b8da2
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5744.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2024 14:58:29.7972
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X2I6ocpT5nxVrv2MNBuSRZRIrK+gitnHlf4J9qAn5xsg3mfjxeK3dr2k63DGMD9f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7941

--=_MailMate_0E4A5337-559B-4F0D-8587-2225B84783C8_=
Content-Type: text/plain

On 4 Mar 2024, at 4:50, Aishwarya TCV wrote:

> On 01/03/2024 21:10, Zi Yan wrote:
>> On 1 Mar 2024, at 15:02, Zi Yan wrote:
>>
>>> On 1 Mar 2024, at 14:37, Zi Yan wrote:
>>>
>>>> On 1 Mar 2024, at 4:51, Aishwarya TCV wrote:
>>>>
>>>>> On 26/02/2024 20:55, Zi Yan wrote:
>>>>>> From: Zi Yan <ziy@nvidia.com>
>>>>>>
>>>>>> It is used to test split_huge_page_to_list_to_order for pagecache THPs.
>>>>>> Also add test cases for split_huge_page_to_list_to_order via both
>>>>>> debugfs.
>>>>>>
>>>>>> Signed-off-by: Zi Yan <ziy@nvidia.com>
>>>>>> ---
>>>>>>  mm/huge_memory.c                              |  34 ++++--
>>>>>>  .../selftests/mm/split_huge_page_test.c       | 115 +++++++++++++++++-
>>>>>>  2 files changed, 131 insertions(+), 18 deletions(-)
>>>>>>
>>>>>
>>>>> Hi Zi,
>>>>>
>>>>> When booting the kernel against next-master(20240228)with Arm64 on
>>>>> Marvell Thunder X2 (TX2), the kselftest-mm test 'split_huge_page_test'
>>>>> is failing in our CI (with rootfs over NFS). I can send the full logs if
>>>>> required.
>>>>>
>>>>> A bisect (full log below) identified this patch as introducing the
>>>>> failure. Bisected it on the tag "next-20240228" at repo
>>>>> "https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git".
>>>>>
>>>>> This works fine on  Linux version 6.8.0-rc6
>>>>
>>>> Hi Aishwarya,
>>>>
>>>> Can you try the attached patch and see if it fixes the failure? I changed
>>>> the test to accept XFS dev as input, mount XFS on a temp folder under /tmp,
>>>> and skip if no XFS is mounted.
>>>
>>> Please try this updated one. It allows you to specify a XFS device path
>>> in SPLIT_HUGE_PAGE_TEST_XFS_PATH env variable, which is passed to
>>> split_huge_page_test in run_vmtests.sh. It at least allow CI/CD to run
>>> the test without too much change.
>>
>> OK. This hopefully will be my last churn. Now split_huge_page_test accepts
>> a path that is backed by XFS and run_vmtest.sh creates a XFS image in /tmp,
>> mounts it in /tmp, and gives the path to split_huge_page_test. I tested
>> it locally and it works. Let me know if you have any issue. Thanks.
>>
>> --
>> Best Regards,
>> Yan, Zi
>
> Hi Zi,
>
> Tested the patch by applying it on next-20240304. Logs from our CI with
> rootfs over nfs is attached below. "Bail out! cannot remove tmp dir:
> Directory not empty" is still observed.

Hi Aishwarya,

Do you have the config file for the CI kernel? And /tmp is also on nfs?
Any detailed information about CI machine environment? I cannot reproduce
the error locally, either on bare metal or VM. Maybe because my /tmp is
not NFS mounted?

>
>
> Test run log:
> # # ------------------------------
> # # running ./split_huge_page_test
> # # ------------------------------
> # # TAP version 13
> # # 1..12
> # # ok 1 Split huge pages successful
> # # ok 2 Split PTE-mapped huge pages successful
> # # # Please enable pr_debug in split_huge_pages_in_file() for more info.
> # # # Please check dmesg for more information
> # # ok 3 File-backed THP split test done
> <6>[  639.821657] split_huge_page (111099): drop_caches: 3
> <6>[  639.821657] split_huge_page (111099): drop_caches: 3
> # # # No large pagecache folio generated, please provide a filesystem
> supporting large folio
> # # ok 4 # SKIP Pagecache folio split skipped
> <6>[  645.392184] split_huge_page (111099): drop_caches: 3
> <6>[  645.392184] split_huge_page (111099): drop_caches: 3
> # # # No large pagecache folio generated, please provide a filesystem
> supporting large folio
> # # ok 5 # SKIP Pagecache folio split skipped
> <6>[  650.938248] split_huge_page (111099): drop_caches: 3
> <6>[  650.938248] split_huge_page (111099): drop_caches: 3
> # # # No large pagecache folio generated, please provide a filesystem
> supporting large folio
> # # ok 6 # SKIP Pagecache folio split skipped
> <6>[  656.500149] split_huge_page (111099): drop_caches: 3
> <6>[  656.500149] split_huge_page (111099): drop_caches: 3
> # # # No large pagecache folio generated, please provide a filesystem
> supporting large folio
> # # ok 7 # SKIP Pagecache folio split skipped
> <6>[  662.044085] split_huge_page (111099): drop_caches: 3
> <6>[  662.044085] split_huge_page (111099): drop_caches: 3
> # # # No large pagecache folio generated, please provide a filesystem
> supporting large folio
> # # ok 8 # SKIP Pagecache folio split skipped
> <6>[  667.591841] split_huge_page (111099): drop_caches: 3
> <6>[  667.591841] split_huge_page (111099): drop_caches: 3
> # # # No large pagecache folio generated, please provide a filesystem
> supporting large folio
> # # ok 9 # SKIP Pagecache folio split skipped
> <6>[  673.172441] split_huge_page (111099): drop_caches: 3
> <6>[  673.172441] split_huge_page (111099): drop_caches: 3
> # # # No large pagecache folio generated, please provide a filesystem
> supporting large folio
> # # ok 10 # SKIP Pagecache folio split skipped
> <6>[  678.726263] split_huge_page (111099): drop_caches: 3
> <6>[  678.726263] split_huge_page (111099): drop_caches: 3
> # # # No large pagecache folio generated, please provide a filesystem
> supporting large folio
> # # ok 11 # SKIP Pagecache folio split skipped
> <6>[  684.272851] split_huge_page (111099): drop_caches: 3
> <6>[  684.272851] split_huge_page (111099): drop_caches: 3
> # # # No large pagecache folio generated, please provide a filesystem
> supporting large folio
> # # ok 12 # SKIP Pagecache folio split skipped
> # # Bail out! cannot remove tmp dir: Directory not empty
> # # # Totals: pass:3 fail:0 xfail:0 xpass:0 skip:9 error:0
> # # [FAIL]
> # not ok 51 split_huge_page_test # exit=1
> # # ------------------
>
> Thanks,
> Aishwarya


--
Best Regards,
Yan, Zi

--=_MailMate_0E4A5337-559B-4F0D-8587-2225B84783C8_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEE6rR4j8RuQ2XmaZol4n+egRQHKFQFAmXl4ZIPHHppeUBudmlk
aWEuY29tAAoJEOJ/noEUByhUXzEP/iiQ7nzdiYwswAYzlikNg7xdo8ol94aDks0m
6N3gJ7RW8AQlYsNofqWpwmvIac02v9YS+9kMtKooVAX90OOEDmLFt/0rC7SyTTqH
uK21xTwbVHAoff4nmAcaUoNgLSMysDXahfLC+sz9APaEoFNFPy5Xo+WM+Z20yVOG
Nm+ChkiY0aksFUbsgiDwenAu5//gAF1sQEog9O8bJfw0cOhkZAPeJeSvGzGydJVT
r5trclr8D9XWHnXpmGP9I8tLYQQyTC5JAR5oz8pRabQbTllwyxDss9COMG+Q4445
jGjwFHoTVmJeVzedri4dHOJ9ig/7dmShnPDOGdHf00eMHQEXArYhjFtLF1Rqr80H
1G+r1dxSSRNuF2aC8cgnFvF90WvLjFvfKj7GN4sWgVZE9Pw71qOxpzF6D71cTMrk
vDVEsIVifUH6p2Cfm33ChXTJu0AhUzx+vlKRrotI9wzxvYbY7r8PF0uYizGMx01Q
OmtV2HuV1RfZnRh/Q+0dCU1KKh0UThVDii8LGoBnoHdG5cExBvr2DGeAHi9WwXUI
bzmtQXvtw3xwmul70UV8k1r0c/MDROKNGQlQK3fLeCiqkIBZxmk2CeUAP1REL3un
jWp3ipQP0S4tiN6SzkRYLBrxH2AEOm3BpaxrD4DttvET/7bxog5k6S20mTJkO6Sk
VFyrYNgu
=M0Km
-----END PGP SIGNATURE-----

--=_MailMate_0E4A5337-559B-4F0D-8587-2225B84783C8_=--

