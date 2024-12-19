Return-Path: <linux-fsdevel+bounces-37820-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 092159F7F2D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Dec 2024 17:16:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4667A1890457
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Dec 2024 16:16:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D749227571;
	Thu, 19 Dec 2024 16:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="SgG3zJb6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2081.outbound.protection.outlook.com [40.107.220.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4440E227568
	for <linux-fsdevel@vger.kernel.org>; Thu, 19 Dec 2024 16:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734624894; cv=fail; b=eyCL1BPv0yx6e3VWB1LuzHpKTdch9QUUqsW9z9DYw7SwKaaV4T73jbLFVo0n15UlCrnHi0TIGR2Tik4R93n4wqSRm8wfezUtGuUUQzmo4k1GKKR0ND/vShlL2D1aXIigPyUfbt+ZcOpYEGv2LQSSX9BRcJVdeH1gJMONTPU7eUQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734624894; c=relaxed/simple;
	bh=cNqWOSmnywvGg9GX+/8hvwA4mvXfxBFlK2g1tCjONVA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kfXIG52tiYxvMmS16UVo8QnqEED5fGdCxh0AH5WJ2iTkkNDdjem7aBSc65KU6uphXiuAGXldgxjcMzh+wc1zrQkWrY7jYM+NCdsJWl1oQbhA+kE8T01IkAfglJJpcxWdpXi8V9xJaa9lB0JFE42MW1QPg4Gg3kW31iZj3udVHDE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=SgG3zJb6; arc=fail smtp.client-ip=40.107.220.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FSrLsopTROL7zMhyDZYLCLS2G2zEThqWtR5Wgx1/0P43okuyyYNFnZRCax8he85LneOyHYKOrDcNo7zlDWHrwWGGRrCB5OfyHmM7AkHXVhsiZMrSKzc3E8PQ3yLV0oqutq9HbrB8Bubxn+Jzl+76HInjTBUjJpOtFx0qTGjTIHM21jX7+JYp11H+LYCfh39IcHoPHoTBR9vL1aycDjlNjut7jl6vDjC499yiUu2m6JtlZq0RwZz5lky4e7ycvl2xHRbiOG0HDIKlA6r/NY/rZH7TCWlRV4lZ0YLmJFfvrYh7Q407Nj2c2iY4WyDggEy8uXGqYv4T25PQ0XPT+RJy1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cWakocvwdetk7lop1epZks50YoP46m7VJGkdNIiowlo=;
 b=KnLLvqVBf8X8fVSqPr5C12iSSsuWtRIR8tvK4H64ci+gnFVG9MxLyNYIcjLaMAT5um9Bxpwogt39FpI1cxTFYfmbMu55Xzrh5Tufevi9GXwlZ0HOmmfKRnp9JE2smsWyB8r4A2YpH5WfrDzGdeQUz5M1W97cy1nsdn0fL8naMGAK2Db9/1qT7lpFPh7bfqnly03UGGdOhgyZ6ZfIskO7pkn+TmEu7VjeHgofhGs76W5TdFcP87fIqNS8g3EGJkcE/dLvVDpV+gX6SlFBeA8NJadF2xM/Evzss73B8wPn+2LvdPOYgo6KDo7JRm9M4JEdxpnWcTmIhhMW9zvmNpTqsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cWakocvwdetk7lop1epZks50YoP46m7VJGkdNIiowlo=;
 b=SgG3zJb6f/T5+MbvlCdO3i4DD9CxSiqOmoBdmblptVp/XeixTaEp7mho6wGgZ7ihtyy4FHNEpHtc0keDxcT3sEbLODl8W3MFSpiM+Q4LLNOv2TEs4bActGURxPt4G8GhZ9meJo35WpYwlfJjEX3/5J0RsdYMnmZkhormzfwizI/s6rCI71ej4H04MfMYUDTF2SXlP0ZN2uXzDJD5shiTQqVSwZbbJ3EAc0kX5G2RUWXfOna9k5v7cc/h7OfH9PSfMUR3RLcgXc7KvMbkbyXAw7kPKg73hK841RrhIPWgjLqw9pGGwGovZiWu5N21ygoNGGi8PUmqMNKUfYzHrDz8bg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL4PR12MB9478.namprd12.prod.outlook.com (2603:10b6:208:58e::9)
 by DS0PR12MB9423.namprd12.prod.outlook.com (2603:10b6:8:192::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.13; Thu, 19 Dec
 2024 16:14:50 +0000
Received: from BL4PR12MB9478.namprd12.prod.outlook.com
 ([fe80::b90:212f:996:6eb9]) by BL4PR12MB9478.namprd12.prod.outlook.com
 ([fe80::b90:212f:996:6eb9%6]) with mapi id 15.20.8272.013; Thu, 19 Dec 2024
 16:14:50 +0000
From: Zi Yan <ziy@nvidia.com>
To: Bernd Schubert <bernd.schubert@fastmail.fm>
Cc: Shakeel Butt <shakeel.butt@linux.dev>,
 David Hildenbrand <david@redhat.com>, Joanne Koong <joannelkoong@gmail.com>,
 miklos@szeredi.hu, linux-fsdevel@vger.kernel.org, jefflexu@linux.alibaba.com,
 josef@toxicpanda.com, linux-mm@kvack.org, kernel-team@meta.com,
 Matthew Wilcox <willy@infradead.org>, Oscar Salvador <osalvador@suse.de>,
 Michal Hocko <mhocko@kernel.org>
Subject: Re: [PATCH v6 4/5] mm/migrate: skip migrating folios under writeback
 with AS_WRITEBACK_INDETERMINATE mappings
Date: Thu, 19 Dec 2024 11:14:49 -0500
X-Mailer: MailMate (1.14r6065)
Message-ID: <6FBDD501-25A0-4A21-8051-F8EE74AD177B@nvidia.com>
In-Reply-To: <ec2e747d-ea84-4487-9c9f-af3db8a3355f@fastmail.fm>
References: <20241122232359.429647-1-joannelkoong@gmail.com>
 <20241122232359.429647-5-joannelkoong@gmail.com>
 <c9a76cb3-5827-4b2c-850f-8c830a090196@redhat.com>
 <hltxbiupl245ea7b4rzpcyz3d62mzs6igcx42g7zsksanbxqb3@sho3dzzht3rx>
 <f30fba5f-b2ca-4351-8c8f-3ac120b2d227@redhat.com>
 <gdu7kmz4nbnjqenj5vea4rjwj7v67kjw6ggoyq7ok4la2uosqa@i5gxpmoopuii>
 <C34102A1-F571-4700-8D16-74642046376D@nvidia.com>
 <ec27cb90-326a-40b8-98ac-c9d5f1661809@fastmail.fm>
 <0CF889CE-09ED-4398-88AC-920118D837A1@nvidia.com>
 <722A63E5-776E-4353-B3EE-DE202E4A4309@nvidia.com>
 <ec2e747d-ea84-4487-9c9f-af3db8a3355f@fastmail.fm>
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: BN9PR03CA0459.namprd03.prod.outlook.com
 (2603:10b6:408:139::14) To BL4PR12MB9478.namprd12.prod.outlook.com
 (2603:10b6:208:58e::9)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL4PR12MB9478:EE_|DS0PR12MB9423:EE_
X-MS-Office365-Filtering-Correlation-Id: e84e1ee2-098d-44b5-37ed-08dd204843e0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+zpaqz+imozTpr2Lnyo0t3mIY3GjMary2gVGfn39kH7nB6reqHOvaLDpgXkE?=
 =?us-ascii?Q?NwdShJ9Rvuf7J7ieD3ffz6H9bIDkLXhs5acYPHozZpa7RBOp2XZa1e5CtPNb?=
 =?us-ascii?Q?Dn5+ER+/orWOQg09AXA4k5Kquu75cYCLe40KnYryjL6ML0/0D27XOVzg7Pfk?=
 =?us-ascii?Q?3Z88VnOLvGvjNU9mpnAeROayUqEeFHdAYXGPXdKpCdG0SMECeuj36/hcwD5p?=
 =?us-ascii?Q?mguVA6N0GRrCl3SIrRVOOFKJjabGhR0I7Y4YPhmCbHV56YAzIV4WoYt4hfRw?=
 =?us-ascii?Q?0ZbTSlHQlFDA55P/y+2ftcmholmp8V3jVV6sgECmJ36DLf0yQFOSwnnWt3IN?=
 =?us-ascii?Q?SKfbmF2v6k7S0UHhs5xXmiX6oAnvKNYm4//U/cIT03xmPFUYTMFspQSvW7wY?=
 =?us-ascii?Q?Xm9aGuV1LPERalg7YVzSPpWDk7Y+FAhY5JVKhrSGjZZZrXrc0xnVYbNOjYxz?=
 =?us-ascii?Q?p8yaaEbwY1pBrKhebPQE0xMLleu4ew7Yz7WZp2l33Zm35cEKKInG/jHej5H5?=
 =?us-ascii?Q?RoaXl6mx4g2ATjuSueGLU+O8g9R+BK4YYtl6Zh5MH1sEMuq4fKoO8l/G9orI?=
 =?us-ascii?Q?Q8eqC27tYjxJjkohBZkxKMR8AhFB24bAPR3yJiTvzRCTg1buCA0XCpdD872G?=
 =?us-ascii?Q?/qYmgd29g8ptvIo0w0uUkTSf8cSlQIqPHUSY8nwgctYJ+fg1iVDQmpPvSlr7?=
 =?us-ascii?Q?MYNwoElNo21A2lk32K57VBCqBrRC1+txExvQ0Eg8CheQ2CDG6WHGRmaXeoqW?=
 =?us-ascii?Q?+7IR1rVDjmnN/rcE/aT/UbE0DVrdnqv14pTh/qHVraxA/UhFa3nVqaR0Pxsw?=
 =?us-ascii?Q?O2aV/xsE93shvuYss6G8HhsJCjQaSu7civItFGmnLjdy7Of4L3z+Qec7lhgV?=
 =?us-ascii?Q?dthT+8J4GmPrt0GjUvI+X25tRJLwdx3e9t1qi/NyV2WW6rExv6B3p0jOPoVk?=
 =?us-ascii?Q?W6sz9riUKsV46AXV3pnJ9N/l0c3FYX2DOFRIHM5k6jrmUBV8DPQtbqexeOvE?=
 =?us-ascii?Q?BjSOEKovMKALIfhkmtx4mWi/i56/A49qjxPCBlrjk6XI0c1S6uAsWz8yw+e4?=
 =?us-ascii?Q?vgcxWF9tJ5r6262JnCOwI1/92m1q2b54AhPBB8RW53g2SAtSCoKYP77DQoQM?=
 =?us-ascii?Q?Tu7mTuKOcP/qHaoUdA0K/n6RFnidhCFcFRiUwQXuYLUn3v9cpn9Kt1BNJSvV?=
 =?us-ascii?Q?rv97bRaiNCK8aiZAmeIOSGuEkTqXyG66pkJiUnCHhnTBd90O50q8aLREWWLy?=
 =?us-ascii?Q?vFV6PpiLF2uD9Qqxhy/m3Q0pfrCHi5iyoJKJzFerJiQq6dkH7YNaYUCwsaVe?=
 =?us-ascii?Q?zzAqUD/QHDbK3WutMJNKr7Y3DazGOHXQSnYuuQ0X8l3OwSM0YP18wTEMY9sl?=
 =?us-ascii?Q?vBvT+2DziukH8LTjecFe7BnoPLPk?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL4PR12MB9478.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?izvtnyCEDoDZqGeqyCEvV8LCwSbllf85PSLZEf0B0LsoWCvdivAoaFpbuTiI?=
 =?us-ascii?Q?44W3tJSM74erLvPB9iBh9lor2ysk8wa4tI/+cCD5I4eFT0mSrqh0uFgQfMkp?=
 =?us-ascii?Q?aGrJFenw4jQP6C7JLTpCdTItfAxAHcS7hkNKcixKVVCOsJSYHFxieQeEtsp7?=
 =?us-ascii?Q?QDNqjtcdS/3Hhq/EaH9gdj1QqVuaiqbqhNBIEDthIPY8b7/24cBtiamwPn6X?=
 =?us-ascii?Q?4qVgHBFN+HVqGlaV/VVko5RrhieZUSNnF6Bv1452KFXj+uZsekzcrJ/DHPjJ?=
 =?us-ascii?Q?EOnbAKO74zy1rDn/0pVb9uAKTqChCIXtx3RsxYDPh16fYvBG7Fk1OrGWLto9?=
 =?us-ascii?Q?WfT84n/EP/PGuc5w0qFTVOTs2Y6Cvp/3QanZc4YyIsKHnay6WjUJHe5qata1?=
 =?us-ascii?Q?cxUASNEPhX94xkJ019E7y41ucViY1FGciRsEiYpMi7hoDfPailDokv+/Cmoz?=
 =?us-ascii?Q?ekEWJqUvDBNCIUEfJIWr4Xb6KXThNAyEGswTkW5Ym7lJfjU3pKrScegkRTd5?=
 =?us-ascii?Q?M7y9xWUzlq3CIc8YpHf9AJIk83zdNRmezt5rnEnpCKctXC+2qi3G1kXmoKCp?=
 =?us-ascii?Q?X2UZtibx/K/fgBmMqwZHN3z3BaIWGVafefDdxY7tZvu2nowSqGpJWg2jDoFT?=
 =?us-ascii?Q?785/GaOihlgQ0dAbOtGJVC2LpJbgyiXUe3itCIQUAO2G+oQVzKr1Q37D5GvH?=
 =?us-ascii?Q?v4KuIfhTQmz2AiGzC38RpAs7Ch4u4ItFAwM+YYXjtsfqCCtNcBpTS+ebgNJS?=
 =?us-ascii?Q?RYjE2n5hRQ2QletxHbr+BHcbngp85kc7EpDm55ThAGoWAs112RS4VLzTy89m?=
 =?us-ascii?Q?Iw2kJDfITABNTn5pgv7Ej85I9olFNcG+TDyUZTge0poBSt/T+PtUEMTEaVtZ?=
 =?us-ascii?Q?F/w3zSVBfN0PD/PUsWdEZ7T9yiIBVX8HW7NdiQlKYRIh2LaPq3hp/ViTiMqa?=
 =?us-ascii?Q?jImlJAoQcCxukRuYT9mn5T/V1xm9ITsKzrB/XTvNNuxV1SsJSody+KxBCwkc?=
 =?us-ascii?Q?mMvJg6S5RRFoaVdEr14On49W9beIquxzdn7LL7NttZF3tiLGV+zcWwN3LMXs?=
 =?us-ascii?Q?lmWvUXiNNQiNO1TT81+eqz76ALGgwuqv9cDB6JddfcYNTt4soyJ+jBSaKL1B?=
 =?us-ascii?Q?m3A+RSbChe12XKERax28yzwcWXcSew74WJLuNEn1c9iXFqW27LJ9msRbVvMY?=
 =?us-ascii?Q?MNlOZSP4xCP/74L54MHJ6ZyGmfQDVDQwgFXlRKHjr/kXsfs1cNYX1LkrGX47?=
 =?us-ascii?Q?vE4rIJMXBCuKN220Px9VLUH+bokgOsXFouaMFoGJXiH44weSdENay6S8Iyx7?=
 =?us-ascii?Q?/claozIVnFmpHNJ83PY5hMwMW9cGzXBkv1oM5OxiTSRuMgce2EV0QxmIvVsX?=
 =?us-ascii?Q?EQ5lM0VmaBaSxMCpj1C1YcitwOM/3VsypzAe23lfxwahSxGBBTX0Rh5Trdne?=
 =?us-ascii?Q?0ZJoEfgejth31o9a0Nn3W26PscqHwx7l668/xXKPTxtKJnZglk3pJmibuser?=
 =?us-ascii?Q?4LDYHWu4MAEHrO4xY520jVZqLyeUyZ3htc6Oi8tIGaUsx85GhTRGQLdEp+WE?=
 =?us-ascii?Q?NYrqDw79JKd5nOFtoY4=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e84e1ee2-098d-44b5-37ed-08dd204843e0
X-MS-Exchange-CrossTenant-AuthSource: BL4PR12MB9478.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2024 16:14:50.6299
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dOM7qsRHVl90TNtRFY7gLG558pfqkj37/ZjNCd33rYgl9EMXL9GH/bjbb+t5VvUd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9423

On 19 Dec 2024, at 11:09, Bernd Schubert wrote:

> On 12/19/24 17:02, Zi Yan wrote:
>> On 19 Dec 2024, at 11:00, Zi Yan wrote:
>>> On 19 Dec 2024, at 10:56, Bernd Schubert wrote:
>>>
>>>> On 12/19/24 16:55, Zi Yan wrote:
>>>>> On 19 Dec 2024, at 10:53, Shakeel Butt wrote:
>>>>>
>>>>>> On Thu, Dec 19, 2024 at 04:47:18PM +0100, David Hildenbrand wrote:=

>>>>>>> On 19.12.24 16:43, Shakeel Butt wrote:
>>>>>>>> On Thu, Dec 19, 2024 at 02:05:04PM +0100, David Hildenbrand wrot=
e:
>>>>>>>>> On 23.11.24 00:23, Joanne Koong wrote:
>>>>>>>>>> For migrations called in MIGRATE_SYNC mode, skip migrating the=
 folio if
>>>>>>>>>> it is under writeback and has the AS_WRITEBACK_INDETERMINATE f=
lag set on its
>>>>>>>>>> mapping. If the AS_WRITEBACK_INDETERMINATE flag is set on the =
mapping, the
>>>>>>>>>> writeback may take an indeterminate amount of time to complete=
, and
>>>>>>>>>> waits may get stuck.
>>>>>>>>>>
>>>>>>>>>> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
>>>>>>>>>> Reviewed-by: Shakeel Butt <shakeel.butt@linux.dev>
>>>>>>>>>> ---
>>>>>>>>>>    mm/migrate.c | 5 ++++-
>>>>>>>>>>    1 file changed, 4 insertions(+), 1 deletion(-)
>>>>>>>>>>
>>>>>>>>>> diff --git a/mm/migrate.c b/mm/migrate.c
>>>>>>>>>> index df91248755e4..fe73284e5246 100644
>>>>>>>>>> --- a/mm/migrate.c
>>>>>>>>>> +++ b/mm/migrate.c
>>>>>>>>>> @@ -1260,7 +1260,10 @@ static int migrate_folio_unmap(new_foli=
o_t get_new_folio,
>>>>>>>>>>    		 */
>>>>>>>>>>    		switch (mode) {
>>>>>>>>>>    		case MIGRATE_SYNC:
>>>>>>>>>> -			break;
>>>>>>>>>> +			if (!src->mapping ||
>>>>>>>>>> +			    !mapping_writeback_indeterminate(src->mapping))
>>>>>>>>>> +				break;
>>>>>>>>>> +			fallthrough;
>>>>>>>>>>    		default:
>>>>>>>>>>    			rc =3D -EBUSY;
>>>>>>>>>>    			goto out;
>>>>>>>>>
>>>>>>>>> Ehm, doesn't this mean that any fuse user can essentially compl=
etely block
>>>>>>>>> CMA allocations, memory compaction, memory hotunplug, memory po=
isoning... ?!
>>>>>>>>>
>>>>>>>>> That sounds very bad.
>>>>>>>>
>>>>>>>> The page under writeback are already unmovable while they are un=
der
>>>>>>>> writeback. This patch is only making potentially unrelated tasks=
 to
>>>>>>>> synchronously wait on writeback completion for such pages which =
in worst
>>>>>>>> case can be indefinite. This actually is solving an isolation is=
sue on a
>>>>>>>> multi-tenant machine.
>>>>>>>>
>>>>>>> Are you sure, because I read in the cover letter:
>>>>>>>
>>>>>>> "In the current FUSE writeback design (see commit 3be5a52b30aa ("=
fuse:
>>>>>>> support writable mmap"))), a temp page is allocated for every dir=
ty
>>>>>>> page to be written back, the contents of the dirty page are copie=
d over to
>>>>>>> the temp page, and the temp page gets handed to the server to wri=
te back.
>>>>>>> This is done so that writeback may be immediately cleared on the =
dirty
>>>>>>> page,"
>>>>>>>
>>>>>>> Which to me means that they are immediately movable again?
>>>>>>
>>>>>> Oh sorry, my mistake, yes this will become an isolation issue with=
 the
>>>>>> removal of the temp page in-between which this series is doing. I =
think
>>>>>> the tradeoff is between extra memory plus slow write performance v=
ersus
>>>>>> temporary unmovable memory.
>>>>>
>>>>> No, the tradeoff is slow FUSE performance vs whole system slowdown =
due to
>>>>> memory fragmentation. AS_WRITEBACK_INDETERMINATE indicates it is no=
t
>>>>> temporary.
>>>>
>>>> Is there is a difference between FUSE TMP page being unmovable and
>>>> AS_WRITEBACK_INDETERMINATE folios/pages being unmovable?
>>
>> (Fix my response location)
>>
>> Both are unmovable, but you can control where FUSE TMP page
>> can come from to avoid spread across the entire memory space. For exam=
ple,
>> allocate a contiguous region as a TMP page pool.
>
> Wouldn't it make sense to have that for fuse writeback pages as well?
> Fuse tries to limit dirty pages anyway.

Can fuse constraint the location of writeback pages? Something like what
I proposed[1], migrating pages to a location before their writeback? Will=

that be a performance concern?

In terms of the number of dirty pages, you only need one page out of 512
pages to prevent 2MB THP from allocation. For CMA allocation, one unmovab=
le
page can kill one contiguous range. What is the limit of fuse dirty pages=
?

[1] https://lore.kernel.org/linux-mm/90C41581-179F-40B6-9801-9C9DBBEB1AF4=
@nvidia.com/

--
Best Regards,
Yan, Zi

