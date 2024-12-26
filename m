Return-Path: <linux-fsdevel+bounces-38138-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B6A89FCB81
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Dec 2024 16:11:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CAED3160C1A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Dec 2024 15:11:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BD1B433B3;
	Thu, 26 Dec 2024 15:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="pGYgc+nT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2065.outbound.protection.outlook.com [40.107.102.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90B0C23DE
	for <linux-fsdevel@vger.kernel.org>; Thu, 26 Dec 2024 15:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735225902; cv=fail; b=fSvpbMNCGB6IJQmZmHLUkZ8PoFArVN7v5xlS6ioOmFnk9OoQ5kBE325phYLFNooP1Bj9MiGOogAgdA+SvOgRSvCkKIjNtoJw8CEwEC5+veekHKKXIPNSy+V2IBmbFMp7YBc+goqm4VXdDkfGr2d5GEzPV5sSpPn8KwxOlxr2PTM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735225902; c=relaxed/simple;
	bh=hIdpCI+NVXgd3l2tC5MNQn4MMakt/VC4j/HT2PqeY1U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=clYbaK8igf75EaiXKOcsJKn44ir+xwhilwXAvXYkiB04JydPH/0mrENTb5n6IknxYzYydxGjd9gdOtmzZbYzO6I20CmZJxuoOPE37u0j3CXyLqGJN3Q5g4gEVAmCZy/rFl/lRnXAm8vWzcPAYs+rsuQEksCe7x1ZtHYrK/Fygi4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=pGYgc+nT; arc=fail smtp.client-ip=40.107.102.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fGoZUK76nYhXF3RmwNV/hROuxfxboJE5kevq9clMXrkdLwlTYu5B0yJ1mB71YkUifnk0Hz2saTKQgyXhnxH4lvjBrGhCAz9Mphhf5EbgjhdYfBAtgS7l+HJSeWHVVketZifiIoB2Il4DOnwtLZIiGc2WG5HP+iZ1TNNIsJhqjjVO+57yHkD/h1xMSABynGH6cUxsLmlZK9S0cYqNjs2mNUpwS6ojqWFaenLkdde8u9IIxNwpUUJJGOiIFrCKOOTF5nkPE9JFKSvivXWqOqgR0tfS5VCvJYHhxMJCAfNfjavTzzOrSgCaY4xz/AtqUkG3vOgODzn7VyCvYF3Luuw8dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hIdpCI+NVXgd3l2tC5MNQn4MMakt/VC4j/HT2PqeY1U=;
 b=A22dIUSckGnv3MxTU5CJgtdnx4HfH36696cMxz2BQR5xKVrN+vleUuy7LKfHxx/bt52ahNhcw++Az5e1zM8efAG8iziuHtMYXcqH1bbecWZZXetJJBnOPHGov/hcPxHGgdhngwTLv8ovLB2c+37IlbsKGRCpN54i1I9Xc/jgDAlr6HEwYJtnP36GAuo69a1EKtMpFoAanY7LN7mljefD+wdU6wSm8uaTuKakQzK3TK2l4IW3c+2PQ4ZLw95bq8KjlxCyxxLqfa8zR8BT8LGyZPczyFUwltnd4moYM09a0QNsBQU6fOhsjxG7j/RuY61X8dyZSC/I996cenfrFqy17Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hIdpCI+NVXgd3l2tC5MNQn4MMakt/VC4j/HT2PqeY1U=;
 b=pGYgc+nTzX0ARO0rW5GlVY0QWVShdQ7F3Zy1FUvuwpiv3+DPsKGWTFfyW41x2PIiQLWFvKnY/b85Xn7Z5Y7is56eabwBoP1rQ9hZJc5pDfD+j3F3D4wkB0iHi8r0dLx1dNhKrBSxJz5LzzMGKWHWebtEamJiipg2lrrx2mzqRYc0ix0PDDedkPJXlA9ooS0icomNu1tn6aXrTxTN5b+EhSwHY1p1LLOnvCEfrzhKjUPo9VM8qFTveYYe0VZWfJV4qvrZ06X0CsmkyxLVTTRNIBUMrvWzN5lk6Xt5aoLhlvkSwgM4SmHq7mdnJY/JVo4xsc1VouV2RclKRg+DK/+6wQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 CH3PR12MB9026.namprd12.prod.outlook.com (2603:10b6:610:125::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8293.14; Thu, 26 Dec
 2024 15:11:33 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%3]) with mapi id 15.20.8293.000; Thu, 26 Dec 2024
 15:11:32 +0000
From: Zi Yan <ziy@nvidia.com>
To: David Hildenbrand <david@redhat.com>
Cc: Shakeel Butt <shakeel.butt@linux.dev>,
 Bernd Schubert <bernd.schubert@fastmail.fm>,
 Joanne Koong <joannelkoong@gmail.com>, miklos@szeredi.hu,
 linux-fsdevel@vger.kernel.org, jefflexu@linux.alibaba.com,
 josef@toxicpanda.com, linux-mm@kvack.org, kernel-team@meta.com,
 Matthew Wilcox <willy@infradead.org>, Oscar Salvador <osalvador@suse.de>,
 Michal Hocko <mhocko@kernel.org>
Subject: Re: [PATCH v6 4/5] mm/migrate: skip migrating folios under writeback
 with AS_WRITEBACK_INDETERMINATE mappings
Date: Thu, 26 Dec 2024 10:11:29 -0500
X-Mailer: MailMate (2.0r6068)
Message-ID: <8ED50EFD-E8CE-419F-90C6-157F7CEC728D@nvidia.com>
In-Reply-To: <c91b6836-fa30-44a9-bc15-afc829acaba9@redhat.com>
References: <7b6b8143-d7a4-439f-ae35-a91055f9d62a@redhat.com>
 <2e13a67a-0bad-4795-9ac8-ee800b704cb6@fastmail.fm>
 <ukkygby3u7hjhk3cgrxkvs6qtmlrigdwmqb5k22ru3qqn242au@s4itdbnkmvli>
 <CAJnrk1bRk9xkVkMg8twaNi-gWBRps7A6HubMivKBHQiHzf+T8w@mail.gmail.com>
 <2bph7jx4hvhxpgp77shq2j7mo4xssobhqndw5v7hdvbn43jo2w@scqly5zby7bm>
 <71d7ac34-a5e5-4e59-802b-33d8a4256040@redhat.com>
 <b16bff80-758c-451b-a96c-b047f446f992@fastmail.fm>
 <9404aaa2-4fc2-4b8b-8f95-5604c54c162a@redhat.com>
 <qsytb6j4j6v7kzmiygmmsrdgfkwszpjudvwbq5smkhowfd75dd@beks3genju7x>
 <3f3c7254-7171-4987-bb1b-24c323e22a0f@redhat.com>
 <kyn5ji73biubd5fqbpycu4xsheqvomb3cu45ufw7u2paj5rmhr@bhnlclvuujcu>
 <c91b6836-fa30-44a9-bc15-afc829acaba9@redhat.com>
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: BLAPR03CA0180.namprd03.prod.outlook.com
 (2603:10b6:208:32f::10) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|CH3PR12MB9026:EE_
X-MS-Office365-Filtering-Correlation-Id: d5ff2e7e-c4cf-441e-2dc1-08dd25bf9512
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?iUAFea5lZTmm2Ue61PnszYK6gQXX8+qK9rAKlFqOrmm8xRAx5PZqS+cxLWFl?=
 =?us-ascii?Q?GbSMoxaG6tXmFzWegJggRT2tImVSlTacSEpcAtZHUFH7OsLxxjUK35R5yp7e?=
 =?us-ascii?Q?ksTdaFfaq3B5vvvTxRQVBVmAKZv1bJgwqer5CO3trcwPMCwcITA0VL4Do2ea?=
 =?us-ascii?Q?yw+XihWeycgkx7cFGnbsPMybTh+RpGUbiG4EdvV22i34DeCfS1BND9lvr+dO?=
 =?us-ascii?Q?aET7TfrbVYsc/xFRQaeqM9Vi9xIWdOVFMdPPeo5G81vYQZFJMX+xkrsB+KGO?=
 =?us-ascii?Q?6l9Ge2NuO69HXa1TNlgGgFfswfys9/1RV0UPMYurxNHoQGZfVpyJUCfUoUTB?=
 =?us-ascii?Q?Ce1zyCyQnzVS3/CBF/yAd3xb/5godP7rzMAUy7pcuSkzqd6TvZFFf8yBkF31?=
 =?us-ascii?Q?qEh/sb+6JojBV2Qt1vrCuwN0Irqr/t4lzQiWnv+O7UKrpC+LQEX69LpWxwMC?=
 =?us-ascii?Q?hWm7ARee9bun13z+H9k8a2OGHOpsNW6VGdh9j2pkaHT2e7hv1c8c3nxWVH6i?=
 =?us-ascii?Q?7KzCWy5YatluMMCRCDq9lAPhgooSRUlH5iKejlRlkjI1OL95mDhL3UdqPLDa?=
 =?us-ascii?Q?2D+Uo0DQVv7+BsZJOubEdCCzi9wD664tt+o4ciFMkeMcmhHGr9+Z2geQDSeC?=
 =?us-ascii?Q?ta2d7AhS5TK8sbk/y7cQS8KnO0kLlCIzt29BKYA7rCeEieIyRJaMDiAy9aBA?=
 =?us-ascii?Q?55WUDQt9YRP0W5Ey6IjlgzMCjQXVuKADhwsh+z8Luq72KuObKP8ju2LDBlTS?=
 =?us-ascii?Q?vh80aYWeTLYozKqzvEJG2px+bC4KAdo2KFF1INy1+96KJ23cLu4APH6DnnLn?=
 =?us-ascii?Q?eVveSZaYuW6huVkRnKP1n7VXHaeY6qEtEeBMgkZ/EX5icUhQlRrlEzl7cebM?=
 =?us-ascii?Q?vi06m0svxeUmR6wGHB6LoQdoWbl/fmwp1rdbfttmFIJ7WWeHk3C6mBrE992D?=
 =?us-ascii?Q?Wh6exoVCEYBSy8cMhi/txRSyeh9wqPk1LQInOQ2hzT3ab7yBWI9CE3O9guJm?=
 =?us-ascii?Q?mLnzC3k/aWdibBfcjxwRF9RSwqG+Wu7N/j/FwUMLwYAZkhJcYVggMlAeW8hR?=
 =?us-ascii?Q?hv8CVJl1e3hEJo/AWqRYfjzECFGFTAxN3PBktqB3Dc5tJf3YjuKXjqAoInf4?=
 =?us-ascii?Q?jhJfBq+wc2f/Rb3VpUnDR12m6r9uSaHy6YkfGq+pIjGEuvMLWVAOHy/UfJvi?=
 =?us-ascii?Q?+ikad8NmU9TcklYxXoGZg2iJ/iA3dM24HKU0cqu8D1ES/auTfh61Q5AxceGF?=
 =?us-ascii?Q?U9N2R7iPBOyYab/OhQ4ueZi1lCLQJOq923ac3vsGnzo9Q7V7EezilCE3b0Tq?=
 =?us-ascii?Q?IwJWMwHbfgVGzSs84i5+mn99335DbvXd/VH20Xn9PywQpGfTrG6PMtJn6U/h?=
 =?us-ascii?Q?LSvZcwb4JswhgNYzShCSI8gws168?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9LyH69PCIlLpv6rEqY1pcjZ+sqOA00G7lWRv0xC7MY99oQUMDMuQELtvpJV5?=
 =?us-ascii?Q?dXsDZpnongoSyJJPtcLRktzhvZjTj4MsB5Ef2d1Q8OoRVCTv6DmEZ1v2pjGn?=
 =?us-ascii?Q?WAF0RHoFd1aRdvAxYpBnln40RMLwjlprsEykaNgcDHKGnRbjkWScb47GXcn3?=
 =?us-ascii?Q?Uc5osFmbg9Eg0GAUiOcnDBhh54Le6L8RSZmWz3Pahftno99lckP9iMMDmBsR?=
 =?us-ascii?Q?uyYD4sZaWDiVgpNEib3iiWOhBqy+GRs4Lh9jpNLfshde78rLmhO2w4CGFb9J?=
 =?us-ascii?Q?GlRajAA/x9b0lsE6AF82f6k/rEjf42HERS5YHmYMxT+7mClpJ13z/ADKTa1B?=
 =?us-ascii?Q?RybjePLDUPavqH+qeatLNidkcmhSwPY87ifMecl49cuY4DiJKiPWptrdjrAs?=
 =?us-ascii?Q?D7h9W9E6fHYtR9fAATN/t2dhL/9nh4r2KlqRVG1RQiqgkLeb7aETl2rdoQTh?=
 =?us-ascii?Q?IsKEMywfX32NbeGEu9ZU40d/XLw+19Y9BHNxltzFIRUv/Z/PBsi4HK9c2MiX?=
 =?us-ascii?Q?Xnpo/2i128hDYLDhdoMdQG58a3YwWNwaMsEdZNuYIR4hGBFlUjv73sZRa2c6?=
 =?us-ascii?Q?NlbQFErev4plZX8E8hq3Eg42eiKIPMR3zYrlPOcYkuxArjsMiaxlJxwqjBMV?=
 =?us-ascii?Q?G+75F8HPabcEXpcItENjiCIi05snSjClJAP+r19Y5e4HjydbOIGbvAKjIpgo?=
 =?us-ascii?Q?8A1pjH7eG1XfKIOS1nWbquH9vvHIUMfBsLL0anloV8uC8vbATWKdKIU/lv6H?=
 =?us-ascii?Q?+LfH1lCOQmLaFx7IkuHMYSWAl4IXVf3myA6cOzXJbolxhdGYKbnVY+5ckyZJ?=
 =?us-ascii?Q?61k1CWMN4NoyMm1vQhUDmqMXt9M537L/ghFVHu4KRGIT6XFgZRUv6stL9ILN?=
 =?us-ascii?Q?I+d3Hbp9Wt0I8OmPPs5YdrPtNoKuA6zAAvcX2mF99WV1q77mlOuNTAR+0N7r?=
 =?us-ascii?Q?mFj8Dk0FOGqF5AD2reYUuiwLytDomsV+gIsFvXyfIi1T2yDgJ5Q7ek5jHlnJ?=
 =?us-ascii?Q?fylWgkEn3EXXgff3bKScn0MZ/YDwY7UIajYWMSoZYpKSspEP8YUxh07HxPR+?=
 =?us-ascii?Q?5BAVANqCbd5fmEtOGBt//gQiVvIWFCpJ4zJUIisD9o22DmMvDBPHO/pUbSTX?=
 =?us-ascii?Q?Rtgv6B2mop5Wwna2NOHmLHVtsAndo86aGyCcwLCrC5TqZNIqmgPJG4iBFEno?=
 =?us-ascii?Q?IVPB4DwQiHAUgMr22TTFdE6UAN0Uo7GVRLrU0WBJ0l1cAVi5w1v2gAAvuQcm?=
 =?us-ascii?Q?1kT+uSStJJEDjTHgQrDko//D7fHbqGwoLRIyYy7ogQu6VJvkpPKNpy91a3Pe?=
 =?us-ascii?Q?hQZfAd1zzgliv4dNItzG0cja/oP6aIVi1N0exC1j6c1WK+ZqUL6TRZmBnEWG?=
 =?us-ascii?Q?vpr7guR8LTvyVDR7QBKy5jZqaol3Fvw+fm7aWt01BZ9r4IzntoGhHXxxiLg5?=
 =?us-ascii?Q?sOYVm8hIC8WPlV7NsWNZn+whs4Z1HHejRDAFKsYnO7t3sx0SbCjrbOkShcoN?=
 =?us-ascii?Q?d4YMOpl1wTiLPIWY1kaxOq2pEEhBC0OLB0MGWt+umME4/KYdhTDIImaujBqD?=
 =?us-ascii?Q?gAj+LZMux6NpquQW8hM=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5ff2e7e-c4cf-441e-2dc1-08dd25bf9512
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Dec 2024 15:11:32.7833
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NIr5VinErPskiYmZozrMma3bHP/dvdyhl/gbEYGobb0q277fQ3c/z6quGHWAZyn8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9026

On 24 Dec 2024, at 7:37, David Hildenbrand wrote:

> On 23.12.24 23:14, Shakeel Butt wrote:
>> On Sat, Dec 21, 2024 at 05:18:20PM +0100, David Hildenbrand wrote:
>> [...]
>>>
>>> Yes, so I can see fuse
>>>
>>> (1) Breaking memory reclaim (memory cannot get freed up)
>>>
>>> (2) Breaking page migration (memory cannot be migrated)
>>>
>>> Due to (1) we might experience bigger memory pressure in the system I=
 guess.
>>> A handful of these pages don't really hurt, I have no idea how bad ha=
ving
>>> many of these pages can be. But yes, inherently we cannot throw away =
the
>>> data as long as it is dirty without causing harm. (maybe we could mov=
e it to
>>> some other cache, like swap/zswap; but that smells like a big and
>>> complicated project)
>>>
>>> Due to (2) we turn pages that are supposed to be movable possibly for=
 a long
>>> time unmovable. Even a *single* such page will mean that CMA allocati=
ons /
>>> memory unplug can start failing.
>>>
>>> We have similar situations with page pinning. With things like O_DIRE=
CT, our
>>> assumption/experience so far is that it will only take a couple of se=
conds
>>> max, and retry loops are sufficient to handle it. That's why only lon=
g-term
>>> pinning ("indeterminate", e.g., vfio) migrate these pages out of
>>> ZONE_MOVABLE/MIGRATE_CMA areas in order to long-term pin them.
>>>
>>>
>>> The biggest concern I have is that timeouts, while likely reasonable =
it many
>>> scenarios, might not be desirable even for some sane workloads, and t=
he
>>> default in all system will be "no timeout", letting the clueless admi=
n of
>>> each and every system out there that might support fuse to make a dec=
ision.
>>>
>>> I might have misunderstood something, in which case I am very sorry, =
but we
>>> also don't want CMA allocations to start failing simply because a net=
work
>>> connection is down for a couple of minutes such that a fuse daemon ca=
nnot
>>> make progress.
>>>
>>
>> I think you have valid concerns but these are not new and not unique t=
o
>> fuse. Any filesystem with a potential arbitrary stall can have similar=

>> issues. The arbitrary stall can be caused due to network issues or som=
e
>> faultly local storage.
>
> What concerns me more is that this is can be triggered by even unprivil=
eged user space, and that there is no default protection as far as I unde=
rstood, because timeouts cannot be set universally to a sane defaults.
>
> Again, please correct me if I got that wrong.
>
>
> BTW, I just looked at NFS out of interest, in particular nfs_page_async=
_flush(), and I spot some logic about re-dirtying pages + canceling write=
back. IIUC, there are default timeouts for UDP and TCP, whereby the TCP d=
efault one seems to be around 60s (* retrans?), and the privileged user t=
hat mounts it can set higher ones. I guess one could run into similar wri=
teback issues?
>
> So I wonder why we never required AS_WRITEBACK_INDETERMINATE for nfs? N=
ot sure if I grasped all details about NFS and writeback and when it woul=
d redirty+end writeback, and if there is some other handling in there.
>
>>
>> Regarding the reclaim, I wouldn't say fuse or similar filesystem are
>> breaking memory reclaim as the kernel has mechanism to throttle the
>> threads dirtying the file memory to reduce the chance of situations
>> where most of memory becomes unreclaimable due to being dirty.
>
> Yes, likely even cgroups can easily limit the amount.
>
>>
>> Please note that such filesystems are mostly used in environments like=

>> data center or hyperscalar and usually have more advanced mechanisms t=
o
>> handle and avoid situations like long delays. For such environment
>> network unavailability is a larger issue than some cma allocation
>> failure. My point is: let's not assume the disastrous situaion is norm=
al
>> and overcomplicate the solution.
>
> Let me summarize my main point: ZONE_MOVABLE/MIGRATE_CMA must only be u=
sed for movable allocations.

Exactly this.

>
> Mechanisms that possible turn these folios unmovable for a long/indeter=
minate time must either fail or migrate these folios out of these regions=
, otherwise we start violating the very semantics why ZONE_MOVABLE/MIGRAT=
E_CMA was added in the first place.

Totally agree.

>
> Yes, there are corner cases where we cannot guarantee movability (e.g.,=
 OOM when allocating a migration destination), but these are not cases th=
at can be triggered by (unprivileged) user space easily.
>
> That's why FOLL_LONGTERM pinning does exactly that: even if user space =
would promise that this is really only "short-term", we will treat it as =
"possibly forever", because it's under user-space control.
>
>
> Instead of having more subsystems violate these semantics because "perf=
ormance" ... I would hope we would do better. Maybe it's an issue for NFS=
 as well ("at least" only for privileged user space)? In which case, agai=
n, I would hope we would do better.

Another issue with the proposed AS_WRITEBACK_INDETERMINATE approach is th=
at FUSE
used to use temp pages from MIGRATE_UNMOVABLE to write back dirty pages, =
which
confines these unmovable pages within certain pageblocks, but now any dir=
ty page
can become unmovable due to AS_WRITEBACK_INDETERMINATE and they can sprea=
d across
the entire physical space. This means memory can be fragmented much easie=
r, namely
with the same 512 dirty pages, previously, all could be confined in 1 pag=
eblock,
but now in the worse scenario they can appear in 512 pageblocks.

--
Best Regards,
Yan, Zi

