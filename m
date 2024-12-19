Return-Path: <linux-fsdevel+bounces-37802-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C04879F7DAF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Dec 2024 16:11:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 538F2188432A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Dec 2024 15:09:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4E5C226524;
	Thu, 19 Dec 2024 15:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="fRNz9rZS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2058.outbound.protection.outlook.com [40.107.236.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83349225784
	for <linux-fsdevel@vger.kernel.org>; Thu, 19 Dec 2024 15:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734620911; cv=fail; b=ukfETZx9ZHtNX2UZvhDGEZCuIn25Vv88sbXpUHMRkFfCUys18+uo1BD9aISMQfdwpleSfB22UzNMXqRZgR2uRYKgrYDUoza3AKKnHUzKxd5QChCST3ZMP99XOtQ3+EHvPTtIhc8UZflOYfL6bD/LnZ44trd4wyEDhJCvKiYfR+M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734620911; c=relaxed/simple;
	bh=jkXKX6XPLbCmScea+zZSMxJXgicFsGytWy9pNBl92Xw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ruV0+lWncZYPg1vw5yPw8ImBIZs3ApyWXQstYsLmZZAEaAk2bWDUNOTg/QN2g3sj8xo3hb00BgUPICn72VtPS8G+nOziPGQ6tmymy0a3El1OgKj0epD472x/6R/E2BxEEyIw3JYlJqT/vTit3Bb+AdMBO9p5oNCHs6DeoBsRFUM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=fRNz9rZS; arc=fail smtp.client-ip=40.107.236.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Dpb2Isgo2+jAP74hGecAahUoqda2mWcdQO0k7M001RA3mZtARc4zyP4N0TojBeNQCIaUwSJnELDrrUaHILkluv8IPaUroSXxlGIpXNdzAiavRIQ07ZCKqtLJyZTaMhI4y7ytI9cGYZJuOiz1PGK9Cih1MSG7/cemf8L5OaHJ6d0Hk68mpnGvC3lrULua6eoxetjzA8ysuQ0mpI6o1yoVUD1Y2rq2Ze2Wxa1c5/x4SeggA/Sq9aSApnS23VJbkQs9R7J0ynodmBO1ZeuqLbVegliRnQTlEWP/wayiMK6/jBjNcefxe8PY68YCdJR/+5uqEDMNde7pDdJQ2wPMTsK/qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2LLL+9d6bnLzcGIdHm2T2pzt77MEk/TFwnks3Noomw0=;
 b=Caa/JEuaJLbD9vU+Yl0sWzInrFg0YGzOOQh7f+wUlcMEetQQXqfJ8DHPX4urQByELVv+4Bhoyf68sS/WWlA9OYarbniU7GhuJNw+zFrhXdmhNisCsTuW9zCqaqWVMGf40zy4THxRiqzgBpGXuvgP3/d8WEggH4TnXXRvEBl/ct1/OEn/aoSmcfNH1PzgD1aGrexF8JHqDRUnIYW+ZA0HRb54Tcgf0MmCsGI9KllVp7e4y0fYLOZERSLgh8ojl65IZ0LxlTDae8fRYFgpqyCrTkaFb+z3Ykn4+j60uTZGgy6aYgoqzco+7hlLZLzRIjssUqV6MJOo6wNLM5KdbR7cCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2LLL+9d6bnLzcGIdHm2T2pzt77MEk/TFwnks3Noomw0=;
 b=fRNz9rZS7w+kJ5cjZ2sHTAz/tGIMrdYtnTx4PwS8x9eQP5gnXeGnaiL7SkykitFX37zc3fXFZQZ39U99Db7EK8NlF74uJ0aeTW73s8tIbNDYbApi3OYZqGHqdNFS5QwRxgRtYRKwk1mzkpozOmIGCn6aB3GL5i0I/gXSmpXJEaL042lOD+TDBTefyZSgl65bPaOWK311PloSTDHJpd8TfsEJdLh28lVq6WbIsEZUSpQWvXh5KGyG3f95cxUa2lVNyMclHqdRPmIr51QhuK0ye3nDEqCxMdThk0op3ubNiwW7YKBJN7nbFB0BoVeBJjN177eT36Jkk9ExcIukjKfuBw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL4PR12MB9478.namprd12.prod.outlook.com (2603:10b6:208:58e::9)
 by SJ2PR12MB8954.namprd12.prod.outlook.com (2603:10b6:a03:541::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.14; Thu, 19 Dec
 2024 15:08:22 +0000
Received: from BL4PR12MB9478.namprd12.prod.outlook.com
 ([fe80::b90:212f:996:6eb9]) by BL4PR12MB9478.namprd12.prod.outlook.com
 ([fe80::b90:212f:996:6eb9%6]) with mapi id 15.20.8272.013; Thu, 19 Dec 2024
 15:08:22 +0000
From: Zi Yan <ziy@nvidia.com>
To: David Hildenbrand <david@redhat.com>,
 Joanne Koong <joannelkoong@gmail.com>
Cc: miklos@szeredi.hu, linux-fsdevel@vger.kernel.org, shakeel.butt@linux.dev,
 jefflexu@linux.alibaba.com, josef@toxicpanda.com, bernd.schubert@fastmail.fm,
 linux-mm@kvack.org, kernel-team@meta.com,
 Matthew Wilcox <willy@infradead.org>, Oscar Salvador <osalvador@suse.de>,
 Michal Hocko <mhocko@kernel.org>
Subject: Re: [PATCH v6 4/5] mm/migrate: skip migrating folios under writeback
 with AS_WRITEBACK_INDETERMINATE mappings
Date: Thu, 19 Dec 2024 10:08:21 -0500
X-Mailer: MailMate (1.14r6065)
Message-ID: <90C41581-179F-40B6-9801-9C9DBBEB1AF4@nvidia.com>
In-Reply-To: <485BC133-98F3-4E57-B459-A5C424428C0F@nvidia.com>
References: <20241122232359.429647-1-joannelkoong@gmail.com>
 <20241122232359.429647-5-joannelkoong@gmail.com>
 <c9a76cb3-5827-4b2c-850f-8c830a090196@redhat.com>
 <485BC133-98F3-4E57-B459-A5C424428C0F@nvidia.com>
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: BL1P221CA0002.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:208:2c5::32) To BL4PR12MB9478.namprd12.prod.outlook.com
 (2603:10b6:208:58e::9)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL4PR12MB9478:EE_|SJ2PR12MB8954:EE_
X-MS-Office365-Filtering-Correlation-Id: 756955fd-2e3d-48e7-5da7-08dd203efae5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qwhMUPqM5DrsiK7Zv7rTE1BjkvkL4Etr6/vlXz04W5yshHS5BJZ/MXtL+OPh?=
 =?us-ascii?Q?In2VE70ldiZ0XqzoPax7GptBk5JzkwgAXhVQtQB7QuJzoE72rV6+EVCJJ0Jt?=
 =?us-ascii?Q?L87xUJDwH/GlMsl5uXMnecJx/mV8mWxTZilzG6TunliGYBPCowemrm8a2HoY?=
 =?us-ascii?Q?RJOAWDxxg8g9mWvOpL5lCGX2qwkiSFP8qYi7aicBF0FTcAuTr3glBvtHnKWg?=
 =?us-ascii?Q?/xBgNrMS9y93pRLbTZoWd/k6MlkCkCw/wml9XDhiQ6V+NTlOY4duVHK+mx0T?=
 =?us-ascii?Q?5Sz6d5JO7HSTinIHTGqEQgRFslEgKdyy0rgSoqjNei2Rd/VP4mhGGQMM4oxN?=
 =?us-ascii?Q?hQOwLSWte5ZcifVP9Evr7y6YHHMQjGt18QuP7eOBY6T+AYxJURQxB8T0D1n5?=
 =?us-ascii?Q?/xM1rLD6wTzadTrQioDakDL9hJbgMB/AUGXFD095k57cWICPyCn0e7gp+tZj?=
 =?us-ascii?Q?9TFe0ip1qleXrJcjPcCEZy90L5DgUaNZb0UJ79KiEutD7haI0XHG+J1xg13C?=
 =?us-ascii?Q?4NKh4w6iQ/PeLKM7+nh+ZJ3txwPWWrqUFfobZ8oJO8ej3urdW5cmUo/lKxym?=
 =?us-ascii?Q?eKG0Vww75R8Qe5q2zkiobDPb7r7wiztzsze/dgEw2W/NdhwZwy5cHnT8yKwz?=
 =?us-ascii?Q?3L5ygqa1f0A1OSQmqOanneL65IE9LYV+Ao5EB0BO7ot3qhyKSzrNUD1Eoego?=
 =?us-ascii?Q?SY40hw2wuSz60nk1lwiVWYdO/aVjPfn1Ile7D06dRiB5+xm0oBI9zw7VTa3R?=
 =?us-ascii?Q?3F/yU/fTXTXQVP1ZPXUUzSwbpI2jT3OH9xRYwUMpQh0EL9IvoOKkf/JWWFAU?=
 =?us-ascii?Q?2nm+i9j0aQk53lIqzMHY6IElYBLv5t9HX2JcKpptszQ473XgmJGX1J+zl8WB?=
 =?us-ascii?Q?+4ZmIkgkuRBxaod1vjsYRry98+Zbhmv3Rkm0INfAZUSY92R0XTzTq2mgl2XB?=
 =?us-ascii?Q?QIQR+47dkAhbvf93RjdWdZH5CojkuedYNIWMHPB3oAb9FNptlHT9TBUPCgBN?=
 =?us-ascii?Q?Bd5Zq9NVRdWMtue+8UP2H5rqig9lWDZxZDKG98M1L3RB8rhprv0qIcRS3cpm?=
 =?us-ascii?Q?y0iEDdlZOXVL64hhLTkE1bRQZUapo5wTsEpf7dnWgT2sNYAj7TH87HFyWgjG?=
 =?us-ascii?Q?W1TXfvYRgsUQTwTrlbBryTceM9UyRSgO/QyfzA3ZJDZVkpuHOlLO0sgPmOe+?=
 =?us-ascii?Q?SahUE4k2BgSx971qy5moLjnFxj6iAvgZnlERd8wxM/7dytj+6F299qUbbh0P?=
 =?us-ascii?Q?Py0MGckgNX28dGdRH9hB7WSwy7vWlNAcuJ7I1MA6zElzllCIquXR1ETcX477?=
 =?us-ascii?Q?02s9kJkq5aXkFcEKDcUoSvDBqpFMOszTHnrMjdahmdMULMBLID6pioenYYhJ?=
 =?us-ascii?Q?cAAnobV4cHUhp/QRCbzFbB+l3UNM?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL4PR12MB9478.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?sv8B//KJve6ush7sYT7pBBP5I+UeIE2cgwJ05jUeBCXG2yT2UQw8V2C7dIHU?=
 =?us-ascii?Q?mH7ylBG14T5iRUyrbYNP2T4KeBOQ3kZXaNKP1mPsQGxx6XOtdsi2LmV/IRBe?=
 =?us-ascii?Q?Rv/9PAo72goRDTSw/FVXEEM+tJ9aUJRBH/8DNRDSz7b84eWj9guYNKkixQ7x?=
 =?us-ascii?Q?18HwjVG6zcJDL3+dfeif06z77MIAbHSaGxuzA3x6TIaRtsO1PYG/K6KR1cuk?=
 =?us-ascii?Q?5dpPSRa6AkfJ8XuGSeg2YnuFRid5ST/dDY9YB0dIRi695zSocPcUAB287WhM?=
 =?us-ascii?Q?YKRbo8L6yGZU71jv3Zqqj+c74G5XKK/5En2iG/eDf8VlAwg5MdpJuBl96SJc?=
 =?us-ascii?Q?mJjDeuaIe6lUbwxF5uL2uTOdjKFLQlQhsvGNvkFPqF0LvhzzcdpVP41FpYEI?=
 =?us-ascii?Q?FgOqSR/CoC2nUCOLVECHAA+gfltTRE8Ux7DnAA4CMbCENNAgcPSrsonXfdXi?=
 =?us-ascii?Q?OSyyqT/zym+VGFT8opb1hBsOvppOoSjzZrH7R8HxM/9dtLeTQo+ka+SHciaQ?=
 =?us-ascii?Q?aDwG1ZN5r/AKM3B4mWmSEGXMPj8He71KbMq3NGfxKkX4pqGoaWNKJj9mRkUO?=
 =?us-ascii?Q?vwXcz8lHeRqpi4PoMRfl8YeiTzENZdsghfOm1HKIYYqb0dg6LeFuTP39vesJ?=
 =?us-ascii?Q?kT3JS0votv5jr+kY3+QAP2XZ7beFTAP1fPX4nAuv93ln2n29fVfk5RM+ept0?=
 =?us-ascii?Q?EZJ2acJ/hGo1QOz2RsOCBT4BICdQgOTvGuKxNqkDoZuNqwN11QPwgeshjQ98?=
 =?us-ascii?Q?c7eBm23YgSA3PYf04JccxmFu+PGGtUjE/wAxevfkrmEcaRaKjRwULsLFLzp8?=
 =?us-ascii?Q?Pdk2kQCEuyLUY0c+KznWMqMwLGFoFF3IdGyYp4q5xHoaf1Tbid14S4UrMgmz?=
 =?us-ascii?Q?tF5zaLeM5jM1+hr6L9FXXcNwoOO2qRuM31Vm0RsZ3iZ0eD3jJTYe1gO3Yok5?=
 =?us-ascii?Q?pFPPJzYVVoZCmHOjQOib5i88uG7HUxR6Nw/dVKBwm6ZUH/hVAlSFAdpfoFbZ?=
 =?us-ascii?Q?Ujyu+4vmVtRaoXsd4H0kOrWqX8NRrjkcUI/Ge0Iu2Yam5E/8+vtcTMLCP10X?=
 =?us-ascii?Q?+PfSPQSOcTtxMfttv6IKPVy980yWM7i1xklM2HUEgeZeE2XYxqoVAv67n1Gr?=
 =?us-ascii?Q?K4RaN+3kDUqQH/xyQ1StAWRtpqqeGPzQu4TYT5ewhnaUzE1sGL7quMHh2EOS?=
 =?us-ascii?Q?6sE1PUQeLxYH8WNVcuNmlAW93WrBs9ViYGAS5aDu2AuUWzcIuKl4UcEDBinU?=
 =?us-ascii?Q?NukbODFXpJ3HQ7050suZg3YoXDmedGfWJ1QfPx3QTzCvVZuFmhZS6ySRKUvs?=
 =?us-ascii?Q?+sDWL9aU6og0Z1kaLcJQaL+tba2yMWWtdPBHv+LpLWTv4vLXEZKcObNFYthV?=
 =?us-ascii?Q?fq+0MIrMQzhZHcuDpNavpDCfVOsHjPnKmDRHt7dFZpHKZrhh+0o7WLbFwShW?=
 =?us-ascii?Q?vKkhNZwibtH4BQSEW9mccKH78OXBRD4nbmDLKKEPJ879a+r1s9kMtsv05d/I?=
 =?us-ascii?Q?aoDz9Df9tnDMhWSV8cPT6Q8WDjirZc5342fljvZQ2Mmd1xiw7V67zwx8qPS3?=
 =?us-ascii?Q?n1lNBRlUS1o4xRgIhHg=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 756955fd-2e3d-48e7-5da7-08dd203efae5
X-MS-Exchange-CrossTenant-AuthSource: BL4PR12MB9478.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2024 15:08:22.6728
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WrMGtDSGKuE0Gzvy9/SlI7j6Kp5xrS+0n8awQz9gKTSJnbEL0jlGCrH5/GheQc7S
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8954

On 19 Dec 2024, at 9:19, Zi Yan wrote:

> On 19 Dec 2024, at 8:05, David Hildenbrand wrote:
>
>> On 23.11.24 00:23, Joanne Koong wrote:
>>> For migrations called in MIGRATE_SYNC mode, skip migrating the folio =
if
>>> it is under writeback and has the AS_WRITEBACK_INDETERMINATE flag set=
 on its
>>> mapping. If the AS_WRITEBACK_INDETERMINATE flag is set on the mapping=
, the
>>> writeback may take an indeterminate amount of time to complete, and
>>> waits may get stuck.
>>>
>>> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
>>> Reviewed-by: Shakeel Butt <shakeel.butt@linux.dev>
>>> ---
>>>   mm/migrate.c | 5 ++++-
>>>   1 file changed, 4 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/mm/migrate.c b/mm/migrate.c
>>> index df91248755e4..fe73284e5246 100644
>>> --- a/mm/migrate.c
>>> +++ b/mm/migrate.c
>>> @@ -1260,7 +1260,10 @@ static int migrate_folio_unmap(new_folio_t get=
_new_folio,
>>>   		 */
>>>   		switch (mode) {
>>>   		case MIGRATE_SYNC:
>>> -			break;
>>> +			if (!src->mapping ||
>>> +			    !mapping_writeback_indeterminate(src->mapping))
>>> +				break;
>>> +			fallthrough;
>>>   		default:
>>>   			rc =3D -EBUSY;
>>>   			goto out;
>>
>> Ehm, doesn't this mean that any fuse user can essentially completely b=
lock CMA allocations, memory compaction, memory hotunplug, memory poisoni=
ng... ?!
>>
>> That sounds very bad.
>
> Yeah, these writeback folios become unmovable. It makes memory fragment=
ation
> unrecoverable. I do not know why AS_WRITEBACK_INDETERMINATE is allowed,=
 since
> it is essentially a forever pin to writeback folios. Why not introduce =
a
> retry and timeout mechanism instead of waiting for the writeback foreve=
r?

If there is no way around such indeterminate writebacks, to avoid fragmen=
t memory,
these to-be-written-back folios should be migrated to a physically contig=
uous region. Either you have a preallocated region or get free pages from=
 MIGRATE_UNMOVABLE.

--
Best Regards,
Yan, Zi

