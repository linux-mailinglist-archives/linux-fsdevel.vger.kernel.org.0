Return-Path: <linux-fsdevel+bounces-65624-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id BE56EC09293
	for <lists+linux-fsdevel@lfdr.de>; Sat, 25 Oct 2025 17:22:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3911A4E521B
	for <lists+linux-fsdevel@lfdr.de>; Sat, 25 Oct 2025 15:22:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25B19302173;
	Sat, 25 Oct 2025 15:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="RuNiqrYt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012049.outbound.protection.outlook.com [52.101.43.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F36272153D3;
	Sat, 25 Oct 2025 15:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761405721; cv=fail; b=IPPZjU9TVSWt/R2w/WvFZk4RnxdC7p3B/Nqr5n69ye36UYmsi2XyL5HYJLylcQ4YOGdR+6jS6OeApW462ozRV3fAbQLZaR++aO/VIZpIQ4qjGX9006Z5YmFxA1Bm3im9IFpsA0qeKPUiyl6JwS2zkyDbMCt4tDS/55gzt7OgStI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761405721; c=relaxed/simple;
	bh=P+27ki1RZI7MPTpuVCbjuGJ01c5jNc0QW+zVKJs0vKk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NzbgJXCMPS4VxEz7syUhJ6xAH3/vlJ7y3rJxmYSYxuAgjXLqMmWqTwz1x/xX9gb/TNpyiz5CT8+OSAbWBOBWmV+vhDfhVpboWWsakD+XLTzVfUL6VLcv5ZQDDkaP+nIluinOmttg7GKyk+yLhkQITFU1tvrgitaHna6AOECrHuc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=RuNiqrYt; arc=fail smtp.client-ip=52.101.43.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iXX0ZHoMT1SbrHXJrtTHOt3AFgZjVC8LadSbJ9HgDelHOK2RtClueiwTlsD2o1GIBiy84iAeXeP60Hzx7ZBwkHJOrAaUPM5/xs2n+CIyxR5cuk3J/sZYXgta5WU9HQF9yNN6xIv7AHbYDmndXXnTwJZaoXyHOzJt6Gpm2rZUSD/htSWkqjRdBYKRRd//AJRzC6Lm1Fla6/ezW0b/vcNnK6/KNjXrHj4Ca7aOr7gWEjmDLsRAOd6/jvYCYLJ3z56v992QgAEO7ti1SCep1FlcHyGL32X8gPuQLV7YDL+qMcJOs+4WlqGbc+mZfm35flNMZ2LLoA3At5NF83t3+VqbbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P+27ki1RZI7MPTpuVCbjuGJ01c5jNc0QW+zVKJs0vKk=;
 b=Dky3TZGeZxM6ohAujJZlkr6ekWvH82l2fNZAEw1fm75Mrc9zyPjMo/BJgou+sy2NGIwgPCLZnxYfJL3/irhz+uYdMcGqxH8RwxrtYw3kPOD+6I1KtaXJCi288oCsy6ZooN31xfw7Scfg79a3eUtwr//dMx8pHJW9YNK++cyOV2HJ1uxdMVEzmBbEM6UHM8xlVbAIVm5sAsBLeYJbMQbyOqeiXdTIfvwxYAvHnRdsU6uaDEvhGciKsxwewHcvP+fN7lD9KcaM/PuRaIdzxt7QB97DKu268FT9Gsxg7ak4dfkp4tV5rNvq22wvyLyqJahaPYkTdmp0d02Cq4FlLdaFLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P+27ki1RZI7MPTpuVCbjuGJ01c5jNc0QW+zVKJs0vKk=;
 b=RuNiqrYtWh5HW2Z9IDZjjZqwzO81VizbkB6w9drUL16l5uATH0vmpaEbNIO2UIiv3ASzq5pVg1fw+1TI6TJ/DvnYDk964SNo5I1lDl2aWU/43qsOvT1ijR6bsezlv1yI1GRIr8RCFleTGx5C6lGSYgW8Lcg7TXKeSKz2oFKzV3uH+4STsLOHbZKntDSsGyvtmrZ3uy/119sjW/2dqh6bXRh17BITJ6II71FfVwsntYNBXyK7VRKEThMht+9JhJNFOsK2K5Vvagc/K9P1Xtxr+kAUXiimlmODYUQsKykd9fdKhWcVokrz8TFrH9fmWnWG76T6wpEVK9mnj2jdiUqmkw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 BL3PR12MB6476.namprd12.prod.outlook.com (2603:10b6:208:3bc::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9253.13; Sat, 25 Oct 2025 15:21:57 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%5]) with mapi id 15.20.9253.011; Sat, 25 Oct 2025
 15:21:57 +0000
From: Zi Yan <ziy@nvidia.com>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: linmiaohe@huawei.com, david@redhat.com, jane.chu@oracle.com,
 kernel@pankajraghav.com, akpm@linux-foundation.org, mcgrof@kernel.org,
 nao.horiguchi@gmail.com, Baolin Wang <baolin.wang@linux.alibaba.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Nico Pache <npache@redhat.com>,
 Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>,
 Barry Song <baohua@kernel.org>, Lance Yang <lance.yang@linux.dev>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Wei Yang <richard.weiyang@gmail.com>, Yang Shi <shy828301@gmail.com>,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org
Subject: Re: [PATCH v3 1/4] mm/huge_memory: preserve PG_has_hwpoisoned if a
 folio is split to >0 order
Date: Sat, 25 Oct 2025 11:21:54 -0400
X-Mailer: MailMate (2.0r6272)
Message-ID: <8BA9B714-9C9E-4F95-B832-3DA62D0C3FBD@nvidia.com>
In-Reply-To: <c09e3282-46aa-4b53-aade-f63324b66d3f@lucifer.local>
References: <20251022033531.389351-1-ziy@nvidia.com>
 <20251022033531.389351-2-ziy@nvidia.com>
 <c09e3282-46aa-4b53-aade-f63324b66d3f@lucifer.local>
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: MN2PR03CA0006.namprd03.prod.outlook.com
 (2603:10b6:208:23a::11) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|BL3PR12MB6476:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c843fd8-9363-42e0-c457-08de13da3c52
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?bZNJOajvAH7vRY6RCMDzFMGA/vQmobOn6WiqOePYDB7I6QOAy9bAbBjrXkTR?=
 =?us-ascii?Q?CTpZ8Z6KyMzC4jmWMa83ba9ghyWm/2mkAju4exqOoEPR/fbRCwk/ZvdLEFkp?=
 =?us-ascii?Q?4OHDvnEolIQFAzo3T9mrKFhqiyHKnQMvUGXlDs08hVNfPkM0MSXRYPMPiqOq?=
 =?us-ascii?Q?UMzJoGrR6EzSMwOcZb2keNPa+EucamhtygZONgVQ4p8YWkgTkYqScX2NmD9s?=
 =?us-ascii?Q?QlLGJnCvjwP/A+Cbu8llpabq71JSO2x0eKirdsbt4944rI2xa+1agkOk9VIs?=
 =?us-ascii?Q?A4D3JewRu/nSsH9z0wvBR/NkCUrWLxxFrstLh55u8XeDvr1THc2c7PFY1mXp?=
 =?us-ascii?Q?CaE92etxLiaBGURTrGGPAW3Em88haIcDpvb6vmj+eH4hI9HsF9mBHIkuxGms?=
 =?us-ascii?Q?mWSrUs222usR65/jcXvuq7fJXUJjupNMrQPckwATUlMt6oyeivsyMKu1IbsT?=
 =?us-ascii?Q?MDPmJe+uvdaDKxIS+s9knQghoXWRQ0vT0tJ1N9+N4dK+gClhkKI7Rui0oDhR?=
 =?us-ascii?Q?B+mKPN8x6n/BfrcgJETwJTmoJEEFsLmrnLvLuRslV/gPI9VW28CpwBryeNvT?=
 =?us-ascii?Q?X2WR5XHZRksub72ErZHQEZneZpngGBWeqLVBpBOwD3q0ZGiEsqUs/4Zu7egx?=
 =?us-ascii?Q?lPxTN2omCU/30wZYMNfpllp9nhLbBB9J7BhGAE0v7eGIt/Rmt5ZTJCFq7L+A?=
 =?us-ascii?Q?Ggoiy2SdiFzyU/PAO7alHh9QIe6Z+sBillt61R/gZvl8jDX0UtW+dfXYh0Jg?=
 =?us-ascii?Q?M0wAwf1IprysUmue9qsL+8RYYVNoR7Itl0oi0bDSigwxAa4G6psMdxYk2iCr?=
 =?us-ascii?Q?IeMz0sv+LadTPCFAhvSIrWEQdNAG1Riiswm8OsiXoK1sAxQJWkaM7qGkpkf3?=
 =?us-ascii?Q?pFVWJNIDwQseMGQ1wzqxQLZ6HbK6QHjc48j/i7aTD8Udfq55TZLUP8DsgFvr?=
 =?us-ascii?Q?qOkC3ZGCkuFrjHE5daLEAP2UTVymW2gLdM3m2Zhv38LSgA/EUe57J+5xphzY?=
 =?us-ascii?Q?81TTjaICqU5F8JHAEJwxHce3rfcGS9JlucbkL39qIewKc2e6zj9sYxX7uVEO?=
 =?us-ascii?Q?RZcz5vj0/nM0PEVjKjMWGNDagnLgOv7rton8y2+5iSC7/gUwnybvo1d8Q/Y/?=
 =?us-ascii?Q?FYVX+CN8xBLoCY3u+vB2FWEkVEI54RG3qZxXZcagxNM69tbokg7Vubpb73A/?=
 =?us-ascii?Q?vtIRPNJsWjtCXgO/mC+vPExG745Rr5Yly8g3rkTmdw8MFawQIuREbhXc1QKQ?=
 =?us-ascii?Q?Ty7LoKK9qhcLR3SJDMQ5l9MK0TRFM7YMpSjBNNYVme+CfSsNPxVGzqCWPB9x?=
 =?us-ascii?Q?emMvvsAE4qIKjXVKZR/vAWjjzlOXBM4lUD/vAAnN534LPy3tPDVUH0NuJJMA?=
 =?us-ascii?Q?Qn6Yu63rkMq4lYxHGyZwzhvwdoLWHLRflKZWO+m4/yADBgUqWtxFQNj688S0?=
 =?us-ascii?Q?vV4rNxpVzE8V1HXshcK8RmrVV50ywVtoL7GWSznoFVO2v+EctGofQQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?UyxRvfXxOIjJqpagCbeDJlfQyRIOhZUP6BMJF6uSEZZ5RlTlLHHRu7/0eO/p?=
 =?us-ascii?Q?ypa0rIMipo9m0zIu42lGqc5n6mQeTiFf0h7Sd2SKoPh3yXxjBYwZSgpG6ePm?=
 =?us-ascii?Q?Qp2JdCGKPJl8kUHTuCFH6ZVjblS26nyuiD+L2Bba1v9Tq8NjbYemN/5QsaHT?=
 =?us-ascii?Q?dOFxyta+WPlOAC8iYoAqI1r/T6uM16NBAppk6dIZCtwy1uFSQmFJ5dgtSjCC?=
 =?us-ascii?Q?97KlSI8iO8pHhKx62ATsHSW4tOAPxGx7Frp9f+1iY2xDCKWv/PNIdDrjWh06?=
 =?us-ascii?Q?L8a8LT7BGZ98XYFfjp8d0COwrER/tsnJ6cXMskP/88bwZvzH1pNeZUY0qf6J?=
 =?us-ascii?Q?dleid3jueC98gnwL1KwEuG/3GeNnDbXAhmuvLIkyKflHQAwLiYqk+Ksb4H0P?=
 =?us-ascii?Q?PSZRnDpDtSBvpS2LIshbA+uzojX3C7J3Si2fxOSKJTexefo2C8Fr/Sh7+0YZ?=
 =?us-ascii?Q?kbwlo+QSmx3KLnmTblWfZZL9ZYJt1tCPUaLZ16GxcfUQlLdpL1OEpiCRky/0?=
 =?us-ascii?Q?yl6alk72qW6CsJq2NC+ta3aJ/1/FaUPIj+kuRnB+DRG7vprUS4PXap9lhRKA?=
 =?us-ascii?Q?giPZW47IjIYRFAT8oNkoxV4P/IvUrwD88cSgLZ9RKT4c8YnA2CVAQ4Fp8RA5?=
 =?us-ascii?Q?wQp4pwn15KI75BcueBkkf5wdXr1w0mBHpTzscjxmFGjuxtcN46IIVAIB9wGV?=
 =?us-ascii?Q?UCGNWbM6rlagEqWtJ67lDCXI7HwtZfCwF1mUhBRdl3Y/poXm33wXnVZt/7E+?=
 =?us-ascii?Q?zWOAO1JDwPInLxEKb6rJdKg9Keqk3GgqmqjdZPiRY1IXzs0B6LVQ4o1dM+mU?=
 =?us-ascii?Q?MS9CoQrdwGKHP0s4EaQpf07tiRK5JxVavBeBtsjairJojVviWS2+Ihi54PX9?=
 =?us-ascii?Q?sSL49a1lHXkSWxW8vyhwF4ns5ik+pitY1rGBRHuUM/BVgcYzOg2fgSNnOGg/?=
 =?us-ascii?Q?Re/Ij0b7i4hur1h/0tGu9pwPGcLSynQffPEAGzILNpXI8aXMlWuUpWQgNsp/?=
 =?us-ascii?Q?g3u9G6ZAAlhc1QZDbyvRQGqPW6kU3kjB9m8Smdn+F/ubKlLI/Yuz7AJZhprU?=
 =?us-ascii?Q?nMQhf4UEw77rftExzOho/TeMH2B2bndalHrHlH0o2L8g2M28kCAcrP0Zh0lr?=
 =?us-ascii?Q?zo4ek60/7/87FVHPPVW8Ak9EUNfRHa5I36DuUboh9r0ZvZFmGzWvtfT5CkTe?=
 =?us-ascii?Q?gy8USiurNxE1w0J2DXaEPbxx93IXKNhCMd4Jr2ybQ9bS0517Bz1stI3JOCMf?=
 =?us-ascii?Q?6QE62gsjRyoZgJktVPt5Gq6CD64P+1HMlx84ClbWQA6IvsM+Fy2W9Vfd05go?=
 =?us-ascii?Q?wkUbQMNuDK/g8amZDtBcyTVXdKj7krI5U6Ju6lFc9g6l5o1CxTGg9od+qAU4?=
 =?us-ascii?Q?t1vc/Pf5BbFlq/kmbpTIF9DrgSNP8GAcC6zWdzTy/ikcwDxtQkgqO8J8GUI1?=
 =?us-ascii?Q?RiUIQuVMyQAppvKDJAm+ZlbK8hS1PFm5in4jMLBjnUg9t+u5dnB6VXBdn3g6?=
 =?us-ascii?Q?JDIwTU10tQI1uSPinfFxjsLQ3vVeQlPmiixnslwd40AEroYJRf4QX62fLn96?=
 =?us-ascii?Q?/OZ0N0REAgAsVAYstF8N0dHx0GQjvS8xCBNUNd8f?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c843fd8-9363-42e0-c457-08de13da3c52
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2025 15:21:57.0073
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J7v0EzCxlKEgfEDcR6vago/72UKYBjRVZ+O34/szHhWyHK43wh+ooPeq90Ibflsd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6476

On 24 Oct 2025, at 11:58, Lorenzo Stoakes wrote:

> On Tue, Oct 21, 2025 at 11:35:27PM -0400, Zi Yan wrote:
>> folio split clears PG_has_hwpoisoned, but the flag should be preserved=
 in
>> after-split folios containing pages with PG_hwpoisoned flag if the fol=
io is
>> split to >0 order folios. Scan all pages in a to-be-split folio to
>> determine which after-split folios need the flag.
>>
>> An alternatives is to change PG_has_hwpoisoned to PG_maybe_hwpoisoned =
to
>> avoid the scan and set it on all after-split folios, but resulting fal=
se
>> positive has undesirable negative impact. To remove false positive, ca=
ller
>> of folio_test_has_hwpoisoned() and folio_contain_hwpoisoned_page() nee=
ds to
>> do the scan. That might be causing a hassle for current and future cal=
lers
>> and more costly than doing the scan in the split code. More details ar=
e
>> discussed in [1].
>>
>> It is OK that current implementation does not do this, because memory
>> failure code always tries to split to order-0 folios and if a folio ca=
nnot
>> be split to order-0, memory failure code either gives warnings or the =
split
>> is not performed.
>>
>> Link: https://lore.kernel.org/all/CAHbLzkoOZm0PXxE9qwtF4gKR=3DcpRXrSrJ=
9V9Pm2DJexs985q4g@mail.gmail.com/ [1]
>> Signed-off-by: Zi Yan <ziy@nvidia.com>
>
> I guess this was split out to [0]? :)
>
> [0]: https://lore.kernel.org/linux-mm/44310717-347c-4ede-ad31-c6d375a44=
9b9@linux.dev/

Yes. The decision is based on the discussion with David[1] and announced =
at[2].

[1] https://lore.kernel.org/all/d3d05898-5530-4990-9d61-8268bd483765@redh=
at.com/
[2] https://lore.kernel.org/all/1AE28DE5-1E0A-432B-B21B-61E0E3F54909@nvid=
ia.com/

--
Best Regards,
Yan, Zi

