Return-Path: <linux-fsdevel+bounces-23384-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 04C5D92B9F4
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Jul 2024 14:50:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2754B1C21545
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Jul 2024 12:50:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01C2215EFC8;
	Tue,  9 Jul 2024 12:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="G2PnfT3Z"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2053.outbound.protection.outlook.com [40.107.100.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE60E15D5A1;
	Tue,  9 Jul 2024 12:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720529392; cv=fail; b=tiUqMtLz6FErS5REH5akCgp1YnN3M/YzZeltKSTkkLWkvpzxp7quqZWVn1RpGcGBErJEHldo3osA96XioaEVQErk7gk/2Z9IdHHdCz+xnAubaKFay69VPtQdrxzKJ5U1zblnwMK7/ZXT5pluJWbyXVctboMxtoUEypW0W9WvpIo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720529392; c=relaxed/simple;
	bh=dxtSLTk9WD+qKG1PXO88J+bz7kl9K9KGW75tKR6Fl5U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qChP2/uBUkW5yrSJJItL4P+YDaP5uvWTy0qPqp59D9dRUp9EQx2DRt9l5F8bjixwNwOQ7pBPBaam3BGWUa2zUkil2liJ9yUHWD6s87JmEmMUMyZTWl/MlUgBZilQuf1FjBY+cjFnwTskVex9Enjj8OHLnZB+XlnUburvUx3oLCE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=G2PnfT3Z; arc=fail smtp.client-ip=40.107.100.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bBekvk8Ta8EldSWT881LlviQ3CBjCMMWWJDJNw5L0NOqqBauIwQt4+kfZh7xNJeWdW74sjTwBaIRsJcOk2Q3oc2rY4A/SVEQPuMQXGdcf+u1a2sO4Ixaly2PZpzPaXoGTQWTb+ll4Dm9VF02TWWX8as22MuGDYD6zxFGqfzklEYimZ3IrAVROW8zwIPt8GlBTpVaxtWQ4ivVFzbBwWGbd5lBjvCdmDEuDl4+DBojiPSQ2vyKCnRZM5IgweqFq9ThmC7fZfzPOJnArJY1ASXXOVHWQN4ZbFrFac4mzMJeja6z3Il5yUHKUXNKuzkYTScaKVe0/ox1hGTw2dabuH68ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S6U9aRoY9L1FmnLGFs540OOAPSwUszlHPGmWL3wBmjo=;
 b=WjbvxSt4RA1NBZV5W/u7CjvinhdxjCtq3QPYBBRpy+ml2kgxRjAzBnEWqA/xGe+M3Z1ukI3Sh3VpctkhIBMfOvhKINaEqUComk/0kuLYEcIhQj7x3v6o872nVthrmgTQKEnCef0auq0Oxy80QhqIunX+zbLGM3jNiE3u4YeNd08h3g1yoORz4DrYsTd+4QvyJIxLai5RfAfxEcWIRqNu0+Ak/uhHL3kY9ARqrplFSO0gr8G++AgXwzG9+kCE7tAkaP85DO0VIz/JsvRK/d4q7gCcJn/NiAEht+wgX97jZNOv0DeS0TT6ibuMGEruDqz46S1vABmBZC4bgYZWwwBN5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S6U9aRoY9L1FmnLGFs540OOAPSwUszlHPGmWL3wBmjo=;
 b=G2PnfT3Zb/zuc6xTUyzbezZCrmYuSS9XGxDpPp8x+LJc/PY+PBXygOGNpMl6ez7IWgN4J4X6F0waI1eygNyHmlgOBCL5WCcYzDEsWfE/LDiditvomOL8XPIzAB8wQAxBDZy02gBCxdc2I9VO2ee18t7p75Iv6OyTBmIIUeTsdFNZvthkTRd9T0ZoBZLwSrOBKNT120vZUP3mLQHvvnmU7cgPzkEQvLVzg8ecIuz1fYioCTSVQMX0c7RA05F436mtUJFY77NyPj/haNjJ6PNgceteO3SS9oZqAwGBsx2w5zMKvSRQWH9fZagZXBFRPX9pjH7b6+1a3ZjHmNY8j4H3Sw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB5744.namprd12.prod.outlook.com (2603:10b6:8:73::18) by
 PH8PR12MB6724.namprd12.prod.outlook.com (2603:10b6:510:1cf::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.29; Tue, 9 Jul
 2024 12:49:46 +0000
Received: from DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::f018:13a9:e165:6b7e]) by DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::f018:13a9:e165:6b7e%4]) with mapi id 15.20.7741.033; Tue, 9 Jul 2024
 12:49:46 +0000
From: Zi Yan <ziy@nvidia.com>
To: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
Cc: david@fromorbit.com, willy@infradead.org, chandan.babu@oracle.com,
 djwong@kernel.org, brauner@kernel.org, akpm@linux-foundation.org,
 yang@os.amperecomputing.com, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, john.g.garry@oracle.com, linux-fsdevel@vger.kernel.org,
 hare@suse.de, p.raghav@samsung.com, mcgrof@kernel.org, gost.dev@samsung.com,
 cl@os.amperecomputing.com, linux-xfs@vger.kernel.org, hch@lst.de
Subject: Re: [PATCH v9 04/10] mm: split a folio in minimum folio order chunks
Date: Tue, 09 Jul 2024 08:49:42 -0400
X-Mailer: MailMate (1.14r6038)
Message-ID: <9CD4A1A7-E378-49A5-85F8-4566B019231A@nvidia.com>
In-Reply-To: <20240709110423.wdteahoeufrt22jk@quentin>
References: <20240704112320.82104-1-kernel@pankajraghav.com>
 <20240704112320.82104-5-kernel@pankajraghav.com>
 <D2K7HHAVJDR9.8PR2HQZ00FXA@nvidia.com>
 <20240709110423.wdteahoeufrt22jk@quentin>
Content-Type: multipart/signed;
 boundary="=_MailMate_7EC282F1-4135-4793-A530-CAD341647E4E_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: MN2PR01CA0059.prod.exchangelabs.com (2603:10b6:208:23f::28)
 To DS7PR12MB5744.namprd12.prod.outlook.com (2603:10b6:8:73::18)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB5744:EE_|PH8PR12MB6724:EE_
X-MS-Office365-Filtering-Correlation-Id: b358b162-0315-4ad1-4fb6-08dca0159c7b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?rDszvWM+eZ6mh6OPhJM2tarA/XEHYLLnsmDwm0HxRmLJatRLVGJ5g/QrgzSF?=
 =?us-ascii?Q?a0TsCDdn/TDzm7m8V2Kf+Wa3Uewtngg3A8qT6g+uJr1Z9WHpIe08wWTScSDJ?=
 =?us-ascii?Q?N5PXo0DjUlrBV1UQoU2AL0HKGm8AC7H3mPbFbiNeXmz0qjpONn5gKG4tg1fN?=
 =?us-ascii?Q?Ms22bDXpcZHHw/QctN8u8/VmQUNoLAJiJ19MEcfrrB7UQn5R6NB0wz5gPid8?=
 =?us-ascii?Q?ndvdQob23KzLVr5hvzgUL37ZXqsvCDhSBwoICh90ttUitRCKQIL/NYBt+mzG?=
 =?us-ascii?Q?rtxml1BqC4K24M/bEFLViddoeL612Ee4yLfIvzLR+JQPZtNPAlEviHHaAPaI?=
 =?us-ascii?Q?gGRqVI4TLR53+hnearJNEo/XDWtSNb+3UX9KaZbhomgloKAeZ7hq0hNRmsEu?=
 =?us-ascii?Q?PAWCNW0do8wq4Se1fMmPiJyaeyQfybeubzl1I0fAUbaGaDvyie2o6DgMy+tg?=
 =?us-ascii?Q?pMeoGaNspJ0qk1VR8zKmJDgzzwCZiWjLmrE2CFFQgWqcw5aEDC5g7hLM7Ha1?=
 =?us-ascii?Q?lCNmAnLUUITwKP0CxTn3Y+umLn4k7wtNi+87TuD8usUJgWrbZm+7rLoYF7XS?=
 =?us-ascii?Q?5kvRhIS903qbfptJN8EtCGL3GXP2PUQytJGlal8YRId8TCIvMzUlaO1bm1rm?=
 =?us-ascii?Q?yFa/5FPIkCQRGcTv+R2JTG+XIkjWh3qigf59FvbWegyaCMnQRyuBtwj+FMwm?=
 =?us-ascii?Q?rfOSalL9KJ1E3m4zUgyzcLa+b4cy3G8mzcpGvuYlg9djev5Ak2gGcoQUwt88?=
 =?us-ascii?Q?LNdVbtnVtfilopv+UJieR5KrPswthZLdy+o4xgjvykjPgzu3CnK90tihEpfA?=
 =?us-ascii?Q?AwVW8WMCCVbLggLxG37Dw8RsLzrv3Z1+wNYyuzKWjP44vhOCB7RDyiq/b/Zo?=
 =?us-ascii?Q?vRzYWdNafble+UmHXFa8b9URXizpKWW3RH4yb+WpQSRcjBZMAHlnvCluXYdr?=
 =?us-ascii?Q?VkANgIVf1ONdqiuHYsPV4mGhs9iXsQdSuL39oqOdg+XWI1ecs5Ge/9/NG4wG?=
 =?us-ascii?Q?JU8zHspyqan9saT2Qw5Eg30UiurbTJQHpC33c9RLVAK540cH1yZnPK617rhz?=
 =?us-ascii?Q?zRghvhbbxrPI8FZDKH0RFP0PV9JW9J1ptN5GO74NN2GA58EaIK7LA9eKLvNj?=
 =?us-ascii?Q?BjUKOEJ1ALKUMQpfYoX8Z7ZTohEFAdnPGfxCz+dlnHW19uyOnxGwe1ai7Ij1?=
 =?us-ascii?Q?l6COlBoOft4o3+oBfzYUmnvEbCnAl3FrhG3V2x9fmEQre14AwWT17Kt71Czy?=
 =?us-ascii?Q?5lzKGFgpGQwn4QcKQpP2loKKL31ycqPphdEH1poWCkwYYRPOTdzbA/1LZ4rR?=
 =?us-ascii?Q?CvYgPEy6JkvO9mHBVi51ib7OyjSWmxvSVz/CMggvqLo2Cg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB5744.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?QITfkPP5URusw8o/7xybONBlEJsLxt4gx1y5bfa6oI1tNRVFD9hvIAaf7aMu?=
 =?us-ascii?Q?6frYu6v4qZDHAywlxJDNju4r8zrmtZudlH5NnWGRd40VZlrhWfvEksQizp2x?=
 =?us-ascii?Q?jjXYWeC7NhJIAWiJyD4CX27XHR80nhq95SafRTvt8Gcy+iX0K3Ym37PrVsIo?=
 =?us-ascii?Q?EBCNIoIWmR8z3nSFiGfw17B4RQRvpA+7euEXWk/7yV7r8Soqo8utWvFDqcwM?=
 =?us-ascii?Q?cag/E+PoNo5WxbpyxeRRQTphg7QuuRQ+zEBx2IsfES0GOyhenNXvKMBm+S+D?=
 =?us-ascii?Q?abxe1uGp3NySQ4sCuxzKba3JtNKn0USp7Uks74TxydLvWhbUQVNqYKn/yqpE?=
 =?us-ascii?Q?6DHt9Jalz9POe/Kj9K35v8w2VY9x5LlzYhqkzQbY/nQNwh//iK5m/9TWJgZt?=
 =?us-ascii?Q?6gT3OP5nmVUKP1FoGYvO6aKAwPtPuIxIixaNuLQyBQheFeniHNxTo6goyiZc?=
 =?us-ascii?Q?3KyL3Q80Aa3GP1F+I2sQlAevZRoNnkiboFy439tlHiw/Lc0a8tamOGWp8Fru?=
 =?us-ascii?Q?Q6J81vBWAvirPibcY6BoCfcYRjVjY7FKr3uUZHqX/ZrXRuUWEEVdLbHrU2FY?=
 =?us-ascii?Q?+Lfc9IindoQfu9chRG1bV+dG24xeNEpmSMJz8MhoF/+RPLAxTOf0AyfXOODO?=
 =?us-ascii?Q?YdpfXp7jGh6/OkOPT21RG151unefh4Mk+4cNnmG+3ZYQ329PGuA0k61yQVvt?=
 =?us-ascii?Q?QSrbZ7x3y/miUdZPse2n52fXju1t/E+ubLST5v+BN3oNNABW7uZKavAxK4rs?=
 =?us-ascii?Q?H4i/yE55TMHFy9fLX1jdRgvhuZgjoYxwf19ltprBbghJjwgtr2dtU7TNpi2p?=
 =?us-ascii?Q?XlPuCmdpchYg5gYcB0b/RlnyDNiRf6ABxoCE4POj5ZZqg5Ynl8O0n2FgkHwn?=
 =?us-ascii?Q?TUha4vNO3zd4b6QFDo49abJh/Z9kLZGUA8n+o4m0ppYD6/KKeEW6QpDWSKN0?=
 =?us-ascii?Q?g5Vx4zOzlM3W03xxJkpKMJurSoCnFtUvo2i+xFBQB4wfJB8Ru4s83VO2QFp9?=
 =?us-ascii?Q?1rcLzVXsVhcZ1vJo4dcnsshIHiTFWJyTG3NGyBFJ16nUmROUu067YN79aqvf?=
 =?us-ascii?Q?H2D1FIbjA09nBg+WjBk+ahZ0N3qWrVQDVpsVc1y6evHuhp+bWC+nD0SE0UAR?=
 =?us-ascii?Q?94eEbUDlYCzOJAu+N7qmwTeb5+IXQ9JGq5zvufHjtWHFhJATU5aQyyG7BxVo?=
 =?us-ascii?Q?FCsGfuHzFveyoutKEfIKTW2P8RLxG1XMSj07dRsI89sfcd7Ny15Kr3EMUOhY?=
 =?us-ascii?Q?+ZxUj+Yh5+O1c6wJsQgogWu1AvMUW2m5zO692s7Z/g9W7FVTFH5QnTP/0k9a?=
 =?us-ascii?Q?3rReZSxARbB5uXRz1y8Pavq9GGHXFdlGNZtl879t0rliB2vLyqAi5QX50o4/?=
 =?us-ascii?Q?4uTPFk7Z6WaZA6KgOzYDzxo9cENToewCrnQoCgsQkatWMLfw8/0HS9PYe2bL?=
 =?us-ascii?Q?BNUFGs1Z6l4cmvGpojsqK0EjmmOrvIAV95rgKui7HFHvfE62kS1pYSog/iUY?=
 =?us-ascii?Q?KDTZMe1/WciQ8ad93wXUe7wQm9UZ5xmegky4ApXGSUOJ/emoakwylYYxFeQG?=
 =?us-ascii?Q?dzI8lZSqPQiUh+mVz1IiU8MceDwQbEv5b5B1xRd7?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b358b162-0315-4ad1-4fb6-08dca0159c7b
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5744.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2024 12:49:46.1742
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zHmd02Ks9JKTaH/uWZBeK6WN0mgY1321BAixyUSei70L/u78LNxleUylPfLq0PCB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6724

--=_MailMate_7EC282F1-4135-4793-A530-CAD341647E4E_=
Content-Type: text/plain

On 9 Jul 2024, at 7:04, Pankaj Raghav (Samsung) wrote:

>>
>> This should be
>>
>> 		if (!folio->mapping) {
>> 			if (folio_test_pmd_mappable(folio))
>> 				count_vm_event(THP_SPLIT_PAGE_FAILED);
>> 			return -EBUSY;
>> 		}
>>
>> Otherwise, a non PMD mappable folio with no mapping will fall through
>> and cause NULL pointer dereference in mapping_min_folio_order().
>
> Ah, of course. I thought I was being "smart" here to avoid another
> nesting. Instead of triple nested ifs, I guess this is better:
>
> int split_folio_to_list(struct folio *folio, struct list_head *list)
> {
>        unsigned int min_order = 0;
>
>        if (folio_test_anon(folio))
>                goto out;
>
>        if (!folio->mapping) {
>                if (folio_test_pmd_mappable(folio))
>                        count_vm_event(THP_SPLIT_PAGE_FAILED);
>                return -EBUSY;
>        }
>
>        min_order = mapping_min_folio_order(folio->mapping);
> out:
>        return split_huge_page_to_list_to_order(&folio->page, list,
>                                                        min_order);
> }
>
> Let me know what you think!

LGTM. Thanks. With this change, feel free to add Reviewed-by: Zi Yan <ziy@nvidia.com>

--
Best Regards,
Yan, Zi

--=_MailMate_7EC282F1-4135-4793-A530-CAD341647E4E_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEE6rR4j8RuQ2XmaZol4n+egRQHKFQFAmaNMecPHHppeUBudmlk
aWEuY29tAAoJEOJ/noEUByhUAEEQAJtadgivftEDJs83GkaUzTRfN+aXOmIMHGpL
OA2o7DhzfwiPLEAvqVDTMkydE6fzLsgmQN5mJgUQka5rTQmo8SItjGXVVlt9oczi
1gJk8vnlpCTFtxpvBCK3UFnaN2PPBwYN3wbN02YRd+zVkq1vBvz0JjPxq+qjijyn
gPFB0n90lOauj0nBmPNUSiSzYls2hvAZATODpVttLSJ1F/oC7w2V9OCd9itQ0PJo
PlMOkhMyqA4xJhEkb6jYC8tWRAufhFKXLmC3/1YG4S6CGACNI4gmjcAGgnV9+gJf
/BVPTrnIMAiV8Mr16JNFj4EavScte7uLxOhTSGgRTef1VNexexFor356JOYOShxp
jhCRgaCOhMfiotYSb82A852pUlAEvmt5kRAJoBmShn1pf2KXO+Cjxkk4wZwCALxt
Bg1rFUX7dcoBsSKG+4wA3PNCC5dBV9luHC8mgv+ilifxxarsoOi+oXKnA4eA4+gk
OXiVz2YJRuhURBHZWqQxcm/cjrM+uKeRXtDGGHtrWUDofnlQNOybYwC2GMRSN2W1
qVOWIEo86pfZSIuL2SVXwwGpUt8r+p68OxluUGArhfnRo5JtcXLxdD/7rAmBDRCY
Vqg00QjwZHRfKXKcYaeNR29fcdbcgHGl6OkqBG2N7NuldEzW4efYcuVlMRuXlJeb
dSfBQHWb
=ZzS8
-----END PGP SIGNATURE-----

--=_MailMate_7EC282F1-4135-4793-A530-CAD341647E4E_=--

