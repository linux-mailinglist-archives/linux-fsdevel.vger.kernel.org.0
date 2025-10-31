Return-Path: <linux-fsdevel+bounces-66647-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BFF97C2739E
	for <lists+linux-fsdevel@lfdr.de>; Sat, 01 Nov 2025 00:52:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3CAAF3A8056
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Oct 2025 23:52:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B51A632F773;
	Fri, 31 Oct 2025 23:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="GyqbO6Mr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013036.outbound.protection.outlook.com [40.93.196.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 425232D94B8;
	Fri, 31 Oct 2025 23:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761954759; cv=fail; b=C+B/Uv9WEIl7DWHXzvmONBTOZtR4pQRVY23FwftmBCpQN6Fd+Pf9cOX0FLSbYUp/0QDQ0c7wxv1vJd2JKu3wfLLHqSSP1VniMcN5LAG/immEjtU+66SiNDFRTVGGV5JxkKFBOjV86Syu0OusT77qNAIsnlF2c85m+WjRy3XU0tU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761954759; c=relaxed/simple;
	bh=FACUm8ttdmZXRUTSU1JF5M8X9OCJYcUH8on6812y6cQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nKj47+cAU3HsfvsIkYsr6f6rEp19E51CJ5MZoHERaBw0dqa4TV8K4/oDzaYLXdQUn4tELtRlcusqU8KNtl1wtv6GDWOsVvkHx6oAbwZGGLxuS2WwkUo+6ERC1NrVxCetXwDsWAN/Rbzv6wFyqL75asoZOIltxWiRDJafBxmF18Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=GyqbO6Mr; arc=fail smtp.client-ip=40.93.196.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PC+f5MJ17n+TUmMzbFtUsz6dEyXdfhf5Ba7IK5twpy2b/krZCxLxEaGxYI7r2G9MpGqhVLYlk0uMHw7LZOZCgiyF5mITshyVRtq8eaLQrz8yLfXu+Qd9Q0ckVGtczrFbMQuzO7BJH9Sw8dlkdcIO5VWAahsMNtGOacofFyvgu0FKYJ5ZNSnHaZktRA+sn1NwuvPUF2G62S9x43F7cmsYHSOV0tWyf5nZBivVl6n+meeTQJlV1FU0eMIMTf4ooNqVJbFSDnBaxBa7/85oKGH3vsW/+3vbGBfCqAXB+7aZX9fKWR2yCW1HdsLqD8K6eSOmwPsiQgHxThWc1VSPi1tRfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e3JXCRbRWGJa1wiwrSAR91RoNAo5KZkpz1+9GLCeSbM=;
 b=e/CGshAwxU5kuYm8TVgYiibmqjCYxwBfPRid3lrfm6xG+/lGkpr0NRCe+xz3VR30NB+l+cgP5EUNqwNgMwkzPsmnIB0D04D34oDP2MzaBilMrkerrsJs/zwBxxkJceONRY1KB8e3/xueuUanprJkfwc3cfj/F+CtM+GWq8rLpUVuTOUY6nZujhRt+Um2gI/K1mu7l8eWaR/azmCSjVWzPaUPdzyNKwPbmQMubegwEyoJLCiZXtDDevVpbSpHa8TuEaiYmWu2yMq/EacgnOywmSkneG/McrsuXms5aC2oPa21FeEbIEpgcf/uhlAqW0IBK7Scf43SRpeL6dntNTyZGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e3JXCRbRWGJa1wiwrSAR91RoNAo5KZkpz1+9GLCeSbM=;
 b=GyqbO6MrZ6QMou+Q1uMIc+juXgDYtchqRfthBkoKkiMACHJ6o7NuL7xNWTwFycc7NCjDESko5W4S3tCx8r0YVVJqclBigvBxf+35+UMEeWkakNZMlNUroOJrvxs2/ADqZ3MhnAiowXlH2A1uDTKtWLSO/nD45nUi5kcMSOKeMw7wvJxoz7f8PfPYhS1f2fjjMZGCjjyYuU8w8NX6edVFllphAsLnf9WFlXWZBbygPpp1c+g8DYnpBGOOAijxai2eMg2HdKCr/CgE8c4R4CdSqgzTw/08MZm0cuAYlo55Qtca740l8QAH3V3zzvrUCSylLg5Cnf8oy/ymduL/2GPHlQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 DM4PR12MB5722.namprd12.prod.outlook.com (2603:10b6:8:5d::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9253.19; Fri, 31 Oct 2025 23:52:32 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%5]) with mapi id 15.20.9275.013; Fri, 31 Oct 2025
 23:52:32 +0000
From: Zi Yan <ziy@nvidia.com>
To: akpm@linux-foundation.org, Wei Yang <richard.weiyang@gmail.com>
Cc: linmiaohe@huawei.com, david@redhat.com, jane.chu@oracle.com,
 kernel@pankajraghav.com, mcgrof@kernel.org, nao.horiguchi@gmail.com,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Nico Pache <npache@redhat.com>,
 Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>,
 Barry Song <baohua@kernel.org>, Lance Yang <lance.yang@linux.dev>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Yang Shi <shy828301@gmail.com>, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v5 3/3] mm/huge_memory: fix kernel-doc comments for
 folio_split() and related.
Date: Fri, 31 Oct 2025 19:52:28 -0400
X-Mailer: MailMate (2.0r6272)
Message-ID: <BE7AC5F3-9E64-4923-861D-C2C4E0CB91EB@nvidia.com>
In-Reply-To: <20251031233610.ftpqyeosb4cedwtp@master>
References: <20251031162001.670503-1-ziy@nvidia.com>
 <20251031162001.670503-4-ziy@nvidia.com>
 <20251031233610.ftpqyeosb4cedwtp@master>
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: BLAPR03CA0018.namprd03.prod.outlook.com
 (2603:10b6:208:32b::23) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|DM4PR12MB5722:EE_
X-MS-Office365-Filtering-Correlation-Id: 279e846e-b996-481e-956d-08de18d88eb0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?W3NHtgM07Syrqfleh0fPXxeWhArM7m3+u6vGiYoSUUpkQ7UuKEjw6c5KS169?=
 =?us-ascii?Q?rTQwvASutooq7iqSRAcHUh163HfoiQNWnzQkQJR9nOl/yxk4NLDYF+LTVVAW?=
 =?us-ascii?Q?UP7ZLX2h1HfO8fUYdvzfe+1Ynw6FoWHaQCn+QnPuXsp4jWj9hj8crAmUnjFt?=
 =?us-ascii?Q?7U/QrHLfcAwe4f/cqMsJP+LWOww+nDP4JyGsR2irDpmvmXztbWRtEBBDVTdv?=
 =?us-ascii?Q?DDYQnRcldJWpfSJdF6L+lR4IHnBDkV+kuxmi+q8t1wAj/7LH8GQua8jDZYIr?=
 =?us-ascii?Q?XuJGJzOeTZmqy9jcDWOyuNTzQ9UhcHLzmPXiGLyPDKCvfgX6oJDX1Ry8sDkR?=
 =?us-ascii?Q?Ab/SERGd6YfoDJ6aBJHi7oH81F01ASu+1J2CA0izUQi6aHywKmogiTgMeiKk?=
 =?us-ascii?Q?Pqnj12Ybd8uZ4GWNM+N+9JtyxL6iV5s+kbpvO1gIrjmpsvB83kJTwrisT/Fd?=
 =?us-ascii?Q?2iAAd68+25thoQo5EXNVImG+rV7qOtRe/oLVkpLgZ91a1IEH9VQEHLhQhFb/?=
 =?us-ascii?Q?PcxUri+4j59JZHg+FA7vJG/DSaDr2+jv6ppf257qqLDwxKvmAZ1zsoQcFq08?=
 =?us-ascii?Q?rX2FnEJ4vSKOcBlEWq75Qc1XP849njnVt+/W8UpPjwQq17+yUjh88awS9A0a?=
 =?us-ascii?Q?7O+onMrcf2G+TJSDnrg/GmjOIKxzIBAxvDXy1tLR8UUNaAuWgzTDuf8SLOx/?=
 =?us-ascii?Q?HCmroafNAMvSCu6HLXbm+nj4k3wHO8zlIheguV4ir4eI85Lb/imvpDxjTOgk?=
 =?us-ascii?Q?nfkNzFdW+Y398s70j2Eco8I5ldd6DYpKgDTK8taoIMXAQ1YFtYkvbecr1ekl?=
 =?us-ascii?Q?FKP5bwd34N0/ego9LCZIy+OpD4AfzFhD0RviPRlBaprEx5ow9BAnNJJCiim4?=
 =?us-ascii?Q?QnHzJoXGrH/kz4EjzfzAL4wa9wu9HQeOeHMLl6asuf0UeUXSKPSUJOp0KhO2?=
 =?us-ascii?Q?3OREdTSIICfYE/BhlZ10LZXlU9D3ExzRvJhzP7M+8zFq5pzf9tepN48uVpKa?=
 =?us-ascii?Q?L64NEvwJrSwzTkeeRhodpc4SqoKHSuR2QgbNvDtlaSh7ExaMa6rwJjcV6kMV?=
 =?us-ascii?Q?pwll3dPHvl4XbaFFl4bMSFsAr56lszzKiZ3zVTn5u/QFQ9if+V/skja0tQtw?=
 =?us-ascii?Q?m9myxwr0xL69sF+ym/7JLU/PpIBVY8uJ0JQESZvdIL8KhflATEusAfUvFV+F?=
 =?us-ascii?Q?p2rhlh/x4l4JMU8xagGC/ohT1cBHfXeE5qjKEEuKUDskN2KjqO4nvUqu2yQl?=
 =?us-ascii?Q?WiM8j2PVxkeRyQmulfrQ2CfJZDhBRcypemTzdHdxFuUlNFsKgw13vm+kZjNf?=
 =?us-ascii?Q?T4E6BfG74OjqdBR64pJMeJmu0FtZb2mtknnShgRDMbqfT7w4fRK733n3CyPc?=
 =?us-ascii?Q?mAmTK7uQMDjvKB4SZsTZxFzTQjGKSJ5G1dfIAi3XlvkG+dcHngbqkIhgBP4m?=
 =?us-ascii?Q?dqiWKysC5gPtIF5qzQGVaMA2bcKkQxt2?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kFowg67brAUEGL+DhgAu6xADzZZXfTuyLl8imHkyP6zZfSYvJ83Lh5o6wP72?=
 =?us-ascii?Q?oAXftD7YYk2T651zuSW/xEb7RiyUeLdi7Y021oYtixm3QPg7+5RFxy0x3wRV?=
 =?us-ascii?Q?5iMb2+oIEe1B2aoqtzLAX3fKrxkeKhQqRHNrEexs6n0lvu5fRzl3FIubM94r?=
 =?us-ascii?Q?yoHnTWT9l3a3Ct3GWBo8CEtruVURYTA4s2XvSeg50efz0bLxVZaITecXmpjJ?=
 =?us-ascii?Q?w9KPDnGdGYKK2NxdPduXfzWdgk6E2ktiIV6ghyy8ViR66YwtHKq9qOIAuSFC?=
 =?us-ascii?Q?suHyiiLCSQ6eRD2NyZbmGOpOKn7iA4HviAZrJM9UmVEb6n/S55+2FBUa7mo+?=
 =?us-ascii?Q?gI7ODKiK+KqbVdjqNG/LkSqGyAyn4+eLAGHs6aXAcq0e8UzpFXZ65mdzc+OV?=
 =?us-ascii?Q?WDuZUSh6ZQwppqjDukM17kVjbipFh931sfgnFlVVl8S30X2Pz7m0l5yDbld9?=
 =?us-ascii?Q?hjM3eFLoCO0VXh2i7X7fpySFLaMBvD6I/sEUukNaydEm0Bj6i/7NrkTwEBLQ?=
 =?us-ascii?Q?u5SW273xkhG9itfd0M3UQIa4AhMFHutJ1DMWUMghaMVCeyRD5xkJA8LZ92iE?=
 =?us-ascii?Q?sIs/BOhSkTOEbRkOtg4BuVG+M4YmSKDU86XUYENyd+GZ9lxb7Ky3pxaSBJco?=
 =?us-ascii?Q?tP7qr43iA4sd5uWdvN5st/OPGO+RfSLu5w800FYUD32ezEBfDE7mk35eqXP4?=
 =?us-ascii?Q?gyJFgLgTgQCoong9d5ua7ij4STz88Qopnr9BrjDtTcAL+GEjK7JpXPeWBAkl?=
 =?us-ascii?Q?qRGe48AfceUGOReksmnzIfLcDrKj4zsW+QhlxKiTDRdyqmh67yFd6e4/Cuqy?=
 =?us-ascii?Q?CUXDXTvnw+CjhkgL/E8F3LgMIFi7rwzdS23ldfoMO9weJrlEtfR/WAGQCVWw?=
 =?us-ascii?Q?bItLxpd2LeQeIThTo9lOr9SoH8pIxpd+931ItGlZTvGywRXVvX7gv45MlGQo?=
 =?us-ascii?Q?pvk0CQOjQ9muWj262Xxf3clAVcSaJbhALb+3PZeifPEhsuDWTeLA1Ct9OqH1?=
 =?us-ascii?Q?o8bAKrpMHfH/TbKDcYSNLDAm2folG9bUhbsqfc2E73RL/X0wh6kf5rzftcwg?=
 =?us-ascii?Q?+GoDVvVWdouS96q5toxRpPZXJY/2P04/9Yc3kt23Ka/W5VlOExMBL3iWt+kf?=
 =?us-ascii?Q?/1V+Waqs0pWM1RXEyew3DpY593ddBZMWeXcXO8H6aSno8b/EiP0Y23khvQLF?=
 =?us-ascii?Q?QEclzoYbJ3KAMikmk8nBM33B5PGNBG4Yu6prST9Y2n9c3gXgJDdcGUDbbdFp?=
 =?us-ascii?Q?nobXy4pTOoClq/3iTSqPbtaYp+iwFTG7h8jczgi1zBTM0ohHZXPELQvX2/NI?=
 =?us-ascii?Q?j41YFjT72+huITmZzxyIlITIcZ5GxghQ31kzWUxZeIi6PlxxlQPBQJlcYuVD?=
 =?us-ascii?Q?jidLRw+DQs6yzMBgb6Tt8IqIQ0xzgCjovnXnqvcbaOZJEMH1LT92IPwZUNQe?=
 =?us-ascii?Q?cN4NqD5mFq+ugoq5FJePHLLYz8lHjWG/y1RcCPLFoPY6CBHXkT2AM5Zr5kRn?=
 =?us-ascii?Q?n0Dh495DoQVdTpthA4ZWD0+4hAPyg0j82QLpDQutX2ej0YbqMbxNc5pHHV7z?=
 =?us-ascii?Q?E3bpT1WXeOjtSfjLJGcOABqlfX/s8IgkH+/TIC43?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 279e846e-b996-481e-956d-08de18d88eb0
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2025 23:52:32.0380
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z98cpkR5OTf7A7jJil0XKAFQ5C42FPanGHkTM1ZgYQeUG6+b+IcZRo9zhcNDwnYb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5722

On 31 Oct 2025, at 19:36, Wei Yang wrote:

> On Fri, Oct 31, 2025 at 12:20:01PM -0400, Zi Yan wrote:
> [...]
>> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
>> index 0e24bb7e90d0..ad2fc52651a6 100644
>> --- a/mm/huge_memory.c
>> +++ b/mm/huge_memory.c
>> @@ -3567,8 +3567,9 @@ static void __split_folio_to_order(struct folio =
*folio, int old_order,
>> 		ClearPageCompound(&folio->page);
>> }
>>
>> -/*
>> - * It splits an unmapped @folio to lower order smaller folios in two =
ways.
>> +/**
>> + * __split_unmapped_folio() - splits an unmapped @folio to lower orde=
r folios in
>> + * two ways: uniform split or non-uniform split.
>>  * @folio: the to-be-split folio
>>  * @new_order: the smallest order of the after split folios (since bud=
dy
>>  *             allocator like split generates folios with orders from =
@folio's
>> @@ -3589,22 +3590,22 @@ static void __split_folio_to_order(struct foli=
o *folio, int old_order,
>>  *    uniform_split is false.
>>  *
>>  * The high level flow for these two methods are:
>> - * 1. uniform split: a single __split_folio_to_order() is called to s=
plit the
>> - *    @folio into @new_order, then we traverse all the resulting foli=
os one by
>> - *    one in PFN ascending order and perform stats, unfreeze, adding =
to list,
>> - *    and file mapping index operations.
>> - * 2. non-uniform split: in general, folio_order - @new_order calls t=
o
>> - *    __split_folio_to_order() are made in a for loop to split the @f=
olio
>> - *    to one lower order at a time. The resulting small folios are pr=
ocessed
>> - *    like what is done during the traversal in 1, except the one con=
taining
>> - *    @page, which is split in next for loop.
>> + * 1. uniform split: @xas is split with no expectation of failure and=
 a single
>> + *    __split_folio_to_order() is called to split the @folio into @ne=
w_order
>> + *    along with stats update.
>> + * 2. non-uniform split: folio_order - @new_order calls to
>> + *    __split_folio_to_order() are expected to be made in a for loop =
to split
>> + *    the @folio to one lower order at a time. The folio containing @=
page is
>
> Hope it is not annoying.
>
> The parameter's name is @split_at, maybe we misuse it?
>
> s/containing @page/containing @split_at/
>
>> + *    split in each iteration. @xas is split into half in each iterat=
ion and
>> + *    can fail. A failed @xas split leaves split folios as is without=
 merging
>> + *    them back.
>>  *
>>  * After splitting, the caller's folio reference will be transferred t=
o the
>>  * folio containing @page. The caller needs to unlock and/or free afte=
r-split
>
> The same above.
>
> And probably there is another one in above this comment(not shown here)=
=2E

Hi Andrew,

Do you mind applying this fixup to address Wei's concerns?

Thanks.

=46rom e1894a4e7ac95bdfe333cf5bee567f0ff90ddf5d Mon Sep 17 00:00:00 2001
From: Zi Yan <ziy@nvidia.com>
Date: Fri, 31 Oct 2025 19:50:55 -0400
Subject: [PATCH] mm/huge_memory: kernel-doc fixup

Signed-off-by: Zi Yan <ziy@nvidia.com>
---
 mm/huge_memory.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index ad2fc52651a6..a30fee2001b5 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -3586,7 +3586,7 @@ static void __split_folio_to_order(struct folio *fo=
lio, int old_order,
  *    uniform_split is true.
  * 2. buddy allocator like (non-uniform) split: the given @folio is spli=
t into
  *    half and one of the half (containing the given page) is split into=
 half
- *    until the given @page's order becomes @new_order. This is done whe=
n
+ *    until the given @folio's order becomes @new_order. This is done wh=
en
  *    uniform_split is false.
  *
  * The high level flow for these two methods are:
@@ -3595,14 +3595,14 @@ static void __split_folio_to_order(struct folio *=
folio, int old_order,
  *    along with stats update.
  * 2. non-uniform split: folio_order - @new_order calls to
  *    __split_folio_to_order() are expected to be made in a for loop to =
split
- *    the @folio to one lower order at a time. The folio containing @pag=
e is
- *    split in each iteration. @xas is split into half in each iteration=
 and
+ *    the @folio to one lower order at a time. The folio containing @spl=
it_at
+ *    is split in each iteration. @xas is split into half in each iterat=
ion and
  *    can fail. A failed @xas split leaves split folios as is without me=
rging
  *    them back.
  *
  * After splitting, the caller's folio reference will be transferred to =
the
- * folio containing @page. The caller needs to unlock and/or free after-=
split
- * folios if necessary.
+ * folio containing @split_at. The caller needs to unlock and/or free
+ * after-split folios if necessary.
  *
  * Return: 0 - successful, <0 - failed (if -ENOMEM is returned, @folio m=
ight be
  * split but not to @new_order, the caller needs to check)
-- =

2.51.0





--
Best Regards,
Yan, Zi

