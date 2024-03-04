Return-Path: <linux-fsdevel+bounces-13489-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 109BC87064A
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Mar 2024 16:57:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3E3B284B87
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Mar 2024 15:57:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8AE7481D1;
	Mon,  4 Mar 2024 15:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="uoR1sT8W"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2055.outbound.protection.outlook.com [40.107.93.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 327AA47A7A;
	Mon,  4 Mar 2024 15:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709567854; cv=fail; b=PWkDeFhgSUXV937+WTC1eAwndfV4L+RjcMXVbxS9R3gaA/ydoS2Dd6UUT28Ip5+91vMBcco29lZJNPZU05carAbRnL46y6YmI2Q0tseMM4gbyIPCsTbcSLCYOOfG+pTEqq0I0PcJlp8nBoYPZbJ3++2Q6FEfdYqDesa1Zv7uLJg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709567854; c=relaxed/simple;
	bh=wsi9UQJmXW57uXgh9ItBV/hk2YkwNAO6wDtJawbUeRE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=i159RSqzLGvZcXYiSsvn70xn4Uz3uCljrufi2YLR15uRL8k6z3nhh+0Q5Hqsu4r7WTeaoTOxWqi7rZB0rm7z55/QvX3cy+E0hKVYGgPUHcaxQqpwAoaY7Ms6JosOwsLHfSlgdJ6NTgfqLHyAZj6+JyoubzMI+b+9ZaIkesjlK1Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=uoR1sT8W; arc=fail smtp.client-ip=40.107.93.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZfocQvUqwjOiOX2TPYc8raDA/xQ38NrwKHNZkMXg/8EBKgYFuGMQJUYHODFWPa2ChhWnFJdx4biTupjSRhel1ookNONzvstBWr90/4ARIVJhDyrxu68Bw+Qp5nZof9F/OMmv0Ci2m5Sdufn3J4GWfpDn/skpkRGnhS8eTElHqosSlo4p5rR2MxwU312aGwjT8aX2r0qNqSbi6ahuuwOt7e+E92J0QTEo9cuRRS//XzsRXm9cqq9yGrW2UCm5VyD3pj5cm4NDlqAhGfX8cFbdiGD4RWm5klNCSVwRa/hwZyRYep8B0iFMYj8aAWewRdKTyOcely59vPhrt3Mp1G1YCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IzIeHxFcjyEvaiobSu9mVgznAXyWihSv53mAz3d1kLk=;
 b=lzpjkQD5nQSoQ0yv9+5utE462OsFm4xGOJfZ4b7LxP4aYPbpvRMsLWAmTZJMBHRTxf60/qTc7XVdbCEdq3MvHGGG7SFr71DAgd5x5Q6q/zFRYsK0x6vVSTptJnmMAoR/xpcjd8l1vyOIAidx25vxCyZ8+jCi+noFMCVk1ze6uKssv48Q9FulItUN8RcORsoJRLucLUcVD3rzSOqFb0Y/bqj1S5uoXvfbHYWlUzZTHwVk1Rr+L9QKM+tTsXXWtlO1B+Yta2IMWSdogKrklcCzF/iIPTbjGZM6z69lQl0reKryFJL3rELJgZIVy1BBIbP4dgpUjDYEFhQ4agvL5v0hFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IzIeHxFcjyEvaiobSu9mVgznAXyWihSv53mAz3d1kLk=;
 b=uoR1sT8W1eM3EH2e62TXRND61eKHWkkBt2lQEZuLsggaqbeilFd3Z+8hzHE0mf7sw1udgPujlWmyqA/9X4unX3eUP2EDMiupWS74YUwcbA9MCxynsTQOgKoobr+lJrFj9ue0BxoBoSVeEA859hXmUXLRylbGMg+l0rpK0v5Dn9Nrh94+bG3JyEENhBC4CVXA+9bCbRzFwy19Naw0dQ4i0OmIrHKt7w82p7czghZN6Hlj20jKodHxwPIBslFnOgUbdgcNPaqVY+9SOIzNoSTBbE30l7+VCenflhIJqyyzND1DYuhpkC76ne5AQueZ8a9GoZypit5GsQTFGm2LafNvKg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB5744.namprd12.prod.outlook.com (2603:10b6:8:73::18) by
 CH2PR12MB4326.namprd12.prod.outlook.com (2603:10b6:610:af::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7339.39; Mon, 4 Mar 2024 15:57:29 +0000
Received: from DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::dc5c:2cf1:d5f5:9753]) by DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::dc5c:2cf1:d5f5:9753%6]) with mapi id 15.20.7339.035; Mon, 4 Mar 2024
 15:57:28 +0000
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
Date: Mon, 04 Mar 2024 10:57:25 -0500
X-Mailer: MailMate (1.14r6018)
Message-ID: <262E4DAA-4A78-4328-B745-1355AE356A07@nvidia.com>
In-Reply-To: <bd51b366-60b3-4ca5-9634-95dfbc3d1829@arm.com>
References: <20240226205534.1603748-1-zi.yan@sent.com>
 <20240226205534.1603748-9-zi.yan@sent.com>
 <082e48c8-71b7-4937-a5da-7a37b4be16ba@arm.com>
 <A111EB95-0AF5-4715-82A4-70B8AD900A93@nvidia.com>
 <7E498B77-6CC9-4FC6-B980-D79EEC548CD0@nvidia.com>
 <0685EC19-CDB8-4CD3-BC39-82DE59B5D10C@nvidia.com>
 <0be630f0-ce8e-4a80-b42f-697ea603cfc6@arm.com>
 <1829EABB-7966-4686-A5E0-F6B6D26C510E@nvidia.com>
 <bd51b366-60b3-4ca5-9634-95dfbc3d1829@arm.com>
Content-Type: multipart/signed;
 boundary="=_MailMate_96F1EC15-071C-4879-92F0-38A750F417D1_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: MN2PR15CA0010.namprd15.prod.outlook.com
 (2603:10b6:208:1b4::23) To DS7PR12MB5744.namprd12.prod.outlook.com
 (2603:10b6:8:73::18)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB5744:EE_|CH2PR12MB4326:EE_
X-MS-Office365-Filtering-Correlation-Id: 070dcb7d-fec4-45f8-1e40-08dc3c63cb12
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	wvx3H/W3GdNsRP5W2lH7g+UKeA7Csl6n6CAgLvYpQPtRXguUdFttvwEa7cO7y9ZaZiKjSniD5tbzEsc2aUyYgL+qQPHTWVHBbcG4xr59IBfkRzI2O2s8HM5RRITKyqUj3c57YXF2q3VdfBJZxldDpP8VaxXsk+toq7x6kuf/7GWov+vKW8JB60z41HS3sZFXboo6fWc/eHFooAF5Dk7AJ3aMykleo0yIIt5X97LbJ39UT1YSSsZkgucw3oC8oyXj/+1uL/B56ZEPblRZc1PlN3LGoscOWmzT8/dsK2DubMq2cUPdqGGYebp7hzDHoQueIJAZ1IoZgm47cXZHQhkRD7wfU1tZNMzmxiWAmtl70uSO3bHnaljB12xlIlaNIsxGLZY9Olrn9yE5JBPbMp/d7EdBNopaGv8yalGvcBJDGjGDU92FM0Q4lIWgzQ52mkmperPsPy6HbNIDH/PUnRAHYLOyi9egWhsj7p6FtJWoj1UQdNKPv9aVkkF9F70GjAXh6SfxZhTIXTN6GdJKheCqreVXdTIcrIyKVx0qPyPQNRhXvXpOkZhJWAMPE9x59aOz3oWfpO5f8ykAFkY4p9NXFhgtXEsN7cFtgCGShUi+p6MwVJrHjqhc9BfoNrIIG53Qh1AMWNfJ4vEDEzu2O/OPGq+odV1ky515AjqkkxyxvSI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB5744.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?iytzpVU1fPnC431QvGU79me4XqoX90DSXiSFbjaR7iywmqzSSko/r8bv3yDz?=
 =?us-ascii?Q?mPFX08aCh/xxOv0/vQ2FrH5OGFZ2UVldPTg4GF9vuBKCnCKXjJm7Ir6J2rxT?=
 =?us-ascii?Q?2IhornVQNR/5rvc+7kTd/FiMmWDkOM4ZV3pfQSZ190q997ZHlFTMM/9548vW?=
 =?us-ascii?Q?494/C4e0bBrTKACUjXITczEfXfjXneFRB9l0OvbsCJ5KBAUxwJMHaVGna85E?=
 =?us-ascii?Q?Emneh7V38+Mg3qfWK/BypIUPUuDRF7mV1Tj8QQ67EblWqpp+nipkN1L+dxhD?=
 =?us-ascii?Q?VUn/0UFAWaDwLUgEsOexGjis3Ij7V8UElVtos3eIWlsVRKYubCNK0mLb6ytS?=
 =?us-ascii?Q?WzV4n0lpmYzKUARHI5keoz33fRlnoQq4drG4SLYvyfvlD5LiNRwNyxeVUUjs?=
 =?us-ascii?Q?es2TtiYTmw005jpJEFWLOpehlxpbpKl5tIhJksw5YjsDO6p2wG6YIstm1FhD?=
 =?us-ascii?Q?AUf8VLcRjTWrfQcYgwExhQZIswfW/RypKfOSDQ+6rtPH6obh2iVJZAhdxaTp?=
 =?us-ascii?Q?385dGCPMGbCgiqTuiPEN/1ruWt9ZgTjFqPxC80tb87qBjDDFq25+1V4JG3O+?=
 =?us-ascii?Q?46bXcQ5HbNHZbcPJAzpahxyh+ZhMi7jGmL4BGf35QcVeROYpQSvNl3SDF++G?=
 =?us-ascii?Q?ihA2Yk0ZTStIhg500JnT9+XAIka6x6uT+pq+3tk0rXoXNWyE6DaeDVlpNvxX?=
 =?us-ascii?Q?q5oy6HkQRl1fhRosQ+Nj1p4OGZdlzJVHcGHrLyudhdgXA1tsDl7CGIGO3mra?=
 =?us-ascii?Q?ODi4VNN2tnfUvCKegBfTFd42yeK7RTsoyitXy1rXAuQ+3k9Cs3mIpp6N13Xd?=
 =?us-ascii?Q?RUpGtufOP2YNUIr3hkTlbTMYqXgEDxWc25grlOtzMjOH1+PJYsGUMyakr4Is?=
 =?us-ascii?Q?tRMh6avQc8P19JN9WDtNMc7/ivG6ML7I4hyBnj2dSq3GY15pe71f393Y6hVy?=
 =?us-ascii?Q?fC0K6dzw1M2qCc64uZAgPph5w/DOIC2AGl9rAsSz0KY3k0GWFN+7J7hVdgQL?=
 =?us-ascii?Q?2wxhrn+VlJn7zl0hGUDK4euW7WtgauAHI/kPSP0OBVBIvBq6oR3SDoUR0CcN?=
 =?us-ascii?Q?EaKNmRCWJgfPdyP6p+Ia/+HgdBh9u/qYfIGYf3ICrHVk1KfzOxn3fiaFo5ay?=
 =?us-ascii?Q?oqKoE4WKwFWwVPuB9OkZcUkbtWAh2C9JcclJFSkPAgQ3Pkk55VmUKNkW8UOW?=
 =?us-ascii?Q?Cysl0ddYYdIAQNqqcG2Iq9zrWib8LRehEQYIqHIE0IZj2kMeLEtWwaSdiwV2?=
 =?us-ascii?Q?aFRd3PQtqExv4k/Dxh2EaQ6wXlSupEPy5XL3X2kWy2IuJZJ2Il8Z3Rcua/wD?=
 =?us-ascii?Q?gFjjrKgsh8kMbobX852EOlsDi0Hn1Hhwi6CoSqMoxFnAkPmF8jp8FbB+O9wJ?=
 =?us-ascii?Q?RKlRowaZWYRj2iLpb6zHwTFLWzAEJ+NiFQoFuqOD8KJMxNkUl2W1C+nYtFSn?=
 =?us-ascii?Q?rIYvo6WcZroZWIQy+Q2VDKTpPx4RGy3ri6JZWcAqQyiTYHQrwXGxzvdP2iMI?=
 =?us-ascii?Q?DLxximdKOocGcGO+2KhY6i/Mrz5N/M8pm34R09L4LPLDXA5RZSL0OByI83x/?=
 =?us-ascii?Q?BXeZkwPRTKBK90ehuAmRYvShpFcLjBnlkEZvwisr?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 070dcb7d-fec4-45f8-1e40-08dc3c63cb12
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5744.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2024 15:57:28.8214
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nrLtawAckggSJORh6NGltngZTKXzsZsEyS/CM5f7agSnkIPg6e5N0uTDZLEN7rPG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4326

--=_MailMate_96F1EC15-071C-4879-92F0-38A750F417D1_=
Content-Type: multipart/mixed;
 boundary="=_MailMate_8066A7D7-F414-410B-BF26-B51E6FBD2B76_="


--=_MailMate_8066A7D7-F414-410B-BF26-B51E6FBD2B76_=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On 4 Mar 2024, at 10:44, Aishwarya TCV wrote:

> On 04/03/2024 14:58, Zi Yan wrote:
>> On 4 Mar 2024, at 4:50, Aishwarya TCV wrote:
>>
>>> On 01/03/2024 21:10, Zi Yan wrote:
>>>> On 1 Mar 2024, at 15:02, Zi Yan wrote:
>>>>
>>>>> On 1 Mar 2024, at 14:37, Zi Yan wrote:
>>>>>
>>>>>> On 1 Mar 2024, at 4:51, Aishwarya TCV wrote:
>>>>>>
>>>>>>> On 26/02/2024 20:55, Zi Yan wrote:
>>>>>>>> From: Zi Yan <ziy@nvidia.com>
>>>>>>>>
>>>>>>>> It is used to test split_huge_page_to_list_to_order for pagecach=
e THPs.
>>>>>>>> Also add test cases for split_huge_page_to_list_to_order via bot=
h
>>>>>>>> debugfs.
>>>>>>>>
>>>>>>>> Signed-off-by: Zi Yan <ziy@nvidia.com>
>>>>>>>> ---
>>>>>>>>  mm/huge_memory.c                              |  34 ++++--
>>>>>>>>  .../selftests/mm/split_huge_page_test.c       | 115 +++++++++++=
++++++-
>>>>>>>>  2 files changed, 131 insertions(+), 18 deletions(-)
>>>>>>>>
>>>>>>>
>>>>>>> Hi Zi,
>>>>>>>
>>>>>>> When booting the kernel against next-master(20240228)with Arm64 o=
n
>>>>>>> Marvell Thunder X2 (TX2), the kselftest-mm test 'split_huge_page_=
test'
>>>>>>> is failing in our CI (with rootfs over NFS). I can send the full =
logs if
>>>>>>> required.
>>>>>>>
>>>>>>> A bisect (full log below) identified this patch as introducing th=
e
>>>>>>> failure. Bisected it on the tag "next-20240228" at repo
>>>>>>> "https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.=
git".
>>>>>>>
>>>>>>> This works fine on  Linux version 6.8.0-rc6
>>>>>>
>>>>>> Hi Aishwarya,
>>>>>>
>>>>>> Can you try the attached patch and see if it fixes the failure? I =
changed
>>>>>> the test to accept XFS dev as input, mount XFS on a temp folder un=
der /tmp,
>>>>>> and skip if no XFS is mounted.
>>>>>
>>>>> Please try this updated one. It allows you to specify a XFS device =
path
>>>>> in SPLIT_HUGE_PAGE_TEST_XFS_PATH env variable, which is passed to
>>>>> split_huge_page_test in run_vmtests.sh. It at least allow CI/CD to =
run
>>>>> the test without too much change.
>>>>
>>>> OK. This hopefully will be my last churn. Now split_huge_page_test a=
ccepts
>>>> a path that is backed by XFS and run_vmtest.sh creates a XFS image i=
n /tmp,
>>>> mounts it in /tmp, and gives the path to split_huge_page_test. I tes=
ted
>>>> it locally and it works. Let me know if you have any issue. Thanks.
>>>>
>>>> --
>>>> Best Regards,
>>>> Yan, Zi
>>>
>>> Hi Zi,
>>>
>>> Tested the patch by applying it on next-20240304. Logs from our CI wi=
th
>>> rootfs over nfs is attached below. "Bail out! cannot remove tmp dir:
>>> Directory not empty" is still observed.
>>
>> Hi Aishwarya,
>>
>> Do you have the config file for the CI kernel? And /tmp is also on nfs=
?
>> Any detailed information about CI machine environment? I cannot reprod=
uce
>> the error locally, either on bare metal or VM. Maybe because my /tmp i=
s
>> not NFS mounted?
>>
>
> Hi Zi,
>
> Please find the details below. Hope it helps.
>
> Do you have the config file for the CI kernel?
> - We are using:
> defconfig+https://github.com/torvalds/linux/blob/master/tools/testing/s=
elftests/mm/config
>
> And /tmp is also on nfs?
> - Yes
>
> Any detailed information about CI machine environment?
> - We are running the test using LAVA device Cavium Thunder X2 (TX2),
> - We have very similar rootfs as - nfsrootfs:
> https://storage.kernelci.org/images/rootfs/debian/bullseye-kselftest/20=
240129.0/arm64/full.rootfs.tar.xz
> - We are using grub boot method over nfs
> - Additionally Ryan mentioned "Looks like it is failing because he is
> trying to delete the temp dir with rmdir() but rmdir() requires the
> directory to be empty, which it is not."

Hi Aishwarya,

Thank you for the information and I am able to reproduce it on a NFS fold=
er.
The error comes from that the opened test files are not munmapped and the=
ir
file descriptors are not closed in the skip path. NFS creates .nfsXXX fil=
es
for them, making the temp folder not empty.

The attached patch cleans up properly and works on a NFS folder. Let me k=
now
if it works on your side. Thanks.

--
Best Regards,
Yan, Zi

--=_MailMate_8066A7D7-F414-410B-BF26-B51E6FBD2B76_=
Content-Disposition: attachment; filename=selftest.patch
Content-ID: <919761F1-0612-481D-BEA4-BCC4B8F7F076@nvidia.com>
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
index cf09fdc9ef22..856662d2f87a 100644
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

@@ -314,26 +343,39 @@ void create_pagecache_thp_and_fd(const char *testfi=
le, size_t fd_size, int *fd,
 		dummy +=3D *(*addr + i);
 =

 	if (!check_huge_file(*addr, fd_size / pmd_pagesize, pmd_pagesize)) {
-		ksft_print_msg("No large pagecache folio generated, please mount a fil=
esystem supporting large folio at "THP_FS_PATH"\n");
-		goto err_out_close;
+		ksft_print_msg("No large pagecache folio generated, please provide a f=
ilesystem supporting large folio\n");
+		munmap(*addr, fd_size);
+		close(*fd);
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

@@ -351,6 +393,7 @@ void split_thp_in_pagecache_to_order(size_t fd_size, =
int order)
 	}
 =

 out:
+	munmap(addr, fd_size);
 	close(fd);
 	unlink(testfile);
 	if (err)
@@ -362,6 +405,10 @@ int main(int argc, char **argv)
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

@@ -370,6 +417,9 @@ int main(int argc, char **argv)
 		ksft_finished();
 	}
 =

+	if (argc > 1)
+		optional_xfs_path =3D argv[1];
+
 	ksft_set_plan(3+9);
 =

 	pagesize =3D getpagesize();
@@ -384,8 +434,11 @@ int main(int argc, char **argv)
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


--=_MailMate_8066A7D7-F414-410B-BF26-B51E6FBD2B76_=--

--=_MailMate_96F1EC15-071C-4879-92F0-38A750F417D1_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEE6rR4j8RuQ2XmaZol4n+egRQHKFQFAmXl72YPHHppeUBudmlk
aWEuY29tAAoJEOJ/noEUByhUfhAP+gLkqkaoPx6ouANHZy8cBNwBGCrZ2O+2QQk2
FydAsz2uBrbtdelNQNVJUTp28Ul3wow8Xl4qP1k+UCH/ytQA9ggFBA0DeCPGtL1T
F4odraTPg5Ndjls5I39HnsSf0eQ6yXMHZVF5+0AbIjgpz2+9FTDWwj/WdF5qF62u
K9EJqlvkFMxgVVTUruBFXgXxfda+cmRTtTC1Rnrz1XRS1TEmZI31auVrbpc4V/wQ
frTY/vK1CSq59MsL6y1sutlcnkh3tOOFE/bxhZvNyD47yEf4qF7mdg+9ytd9KE+G
HG7GW8nyo025pfnJ/uWIlxcjQKEp4aOfMQg4Wg5n9EWpvu9LIQNxYSgDwzEq6YE2
47eSbGVrGjE5cQTTd4tNTgHF1RvzSdZ8e0vRTgdkHEXpT8sByAqaAzGy4t4ZdDdU
HySPd8qQHlhtMNG+RoTgtC3ywb/0cMXqwDP7/LZPmLjQ/jShtt5OZwsGwTJ2BOcZ
z4bMG79CMgPFy3yWZLxALBUKGpTYJq1vaZJG4r+MMFZ9BSWDXLEk34FBNAYIAk3n
9YMYvDKm+2IUGpRpCbWz8XIN4jsLMsZJYyLe7PVWP6umXxuIGxytvmNkd1nux64b
RHlU6RRNhi8JzWTaLqS56ABk+QTp2em8wLZiUGEmPGAeSsgoq6JAHnYILIwGl69q
+W80yO8J
=sZp2
-----END PGP SIGNATURE-----

--=_MailMate_96F1EC15-071C-4879-92F0-38A750F417D1_=--

