Return-Path: <linux-fsdevel+bounces-65022-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 84595BF9D72
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Oct 2025 05:36:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2EB143BE530
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Oct 2025 03:36:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE97E2D0601;
	Wed, 22 Oct 2025 03:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="I2g3Lxz+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012016.outbound.protection.outlook.com [40.93.195.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79A56224893;
	Wed, 22 Oct 2025 03:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761104212; cv=fail; b=DKs1j6rUIP3FaxyfdDXh16qOXOYR3OGthaKX7UtqAwn4fA/0syVe9D/yTtnGI7nEYxzZ/URXlF2QRKnTHnk6FeiGf64InHKWr9p/0WLDt0U4qYhj57xvx37svzEyjEypEVqxB3joI+2qFIARMww1fVHIue+JeU4Z3rbeu/cHleo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761104212; c=relaxed/simple;
	bh=03hk7IioiEHBNN5j2joolpBVM+ofuCpgrlxPmxvErhk=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=kuNQ4JQQh66llu/kBOfubje3bfZAxz0YOGr6mEwtHKjl8EMIw0I3rPYY9T74r3+dPfp7PnHTfhv2/xTHCSM6iw/RRQtSAxwmoQQ4Uay/fZJTheZ8zuhsaQwX3yFu/+9Tnws9WQpyPrtr1dBDnbWwhd98Ej46bB4muBgdYupMaBE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=I2g3Lxz+; arc=fail smtp.client-ip=40.93.195.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kBBGCC3qv5jexES+keEBrNpivkPZ6WgXCAv/9k5W/Nb4lf4tD5oAsYOR0vtutGDfr4VUX+JCJM+k5SIilpll1+tWBq3e8XbAmezy4DqAlQPehtfdmkL+EJ3doHTvWuRD3cq0rQW9NJUfr5FA6KnKSqG6xKN2EaUZ78o0mwmGSi1w3hRmbynWSTwIuHqAGIjXZhUiVYVb8acEM037geThsZ/cZywtSKqLVcQXIm20tPpi5avtNy4KLT+1u3j1ER4pVloeWGpSwjslGuxn13OMmxlY5jpqo2TvhiO1Mw8xpjCkGrN1w7SRjUuFAYR73JTXG5oOnrYWV7NLofmpyh0uiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oTwND8+++uvBGRBgelmkoTvpzSSHL/8VaGjK2FOVtL0=;
 b=a7yDrEVTZtx0hNREa1Rnd63X0g04AUVFTTr3UItB0jQl3Vk2d2iO8OdvNrRdlXFhqknqNTVPsi+E7BnttTs4j+DwmnMYDNRCtcdSVYXIlM1C/18C4xzRvvNGyFxRd/oJ5u5xDW4HNrGq0iDUMg1ktI5OSVf5ciittWTbeU/xE0NapBp45ISDbFVWGA3aZzHvu3wiqMRrm5sBSO9fGr51a9H1o9KVTLMMHTmdm0Oozx62JixxE8X0ehh8jL2sB834853HdTi+HsBI5ff4zYvmtuUemZQckKgNHdEqSHBUYXdM5SW0DOSw8BKZxkkvStAHx4KTvKDRyBUDBOoqrMCzyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oTwND8+++uvBGRBgelmkoTvpzSSHL/8VaGjK2FOVtL0=;
 b=I2g3Lxz+7FS5PObO1qCOcngDF+65lObMKVXhO+CU6olf+B5yRZIXEJXPCtdlE+yW3oSMroYOD1UQX3xLDvPyU+oAMl4WaVIuTmeulF741BHEyiezZXgMxMSHtcVNytq+3gihv8eiCex40Niig1N5T8URGZIuf3GpwTkgH+MAvfwRx2a6We8gCITWwBEEpzMJjOsV1Jxk9RfH30ViYZSJwIW48EoOwW3irN9h5zfW5EfeDCOunxwFVd1CSl5TxHHY4+Dd3QFWD2tJNVm52bjPYPHQfv/cjljw0t1wuUf+mToxKRysJnIvn/gEGRMTjw05VOuE455UNv6jzXCBV4/Xrw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 SJ1PR12MB6268.namprd12.prod.outlook.com (2603:10b6:a03:455::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.16; Wed, 22 Oct
 2025 03:36:46 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%5]) with mapi id 15.20.9253.011; Wed, 22 Oct 2025
 03:36:46 +0000
From: Zi Yan <ziy@nvidia.com>
To: linmiaohe@huawei.com,
	david@redhat.com,
	jane.chu@oracle.com
Cc: kernel@pankajraghav.com,
	ziy@nvidia.com,
	akpm@linux-foundation.org,
	mcgrof@kernel.org,
	nao.horiguchi@gmail.com,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Nico Pache <npache@redhat.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Dev Jain <dev.jain@arm.com>,
	Barry Song <baohua@kernel.org>,
	Lance Yang <lance.yang@linux.dev>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Wei Yang <richard.weiyang@gmail.com>,
	Yang Shi <shy828301@gmail.com>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH v3 0/4] Optimize folio split in memory failure
Date: Tue, 21 Oct 2025 23:35:26 -0400
Message-ID: <20251022033531.389351-1-ziy@nvidia.com>
X-Mailer: git-send-email 2.51.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR05CA0028.namprd05.prod.outlook.com
 (2603:10b6:208:c0::41) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|SJ1PR12MB6268:EE_
X-MS-Office365-Filtering-Correlation-Id: fbcf07ba-333a-4a5c-cfc9-08de111c39bd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?QqJiWEdXPymiODWtzF0hmRuITrt/pv7M8p2jPGJ18Bc6zVSkC4iBBUashLG0?=
 =?us-ascii?Q?asqTgtFyobCEToQ2+ICXRmbT43Iw5VuMPs+BH4vbhu7y8Qizj5zc4vGjcZEv?=
 =?us-ascii?Q?ez75s2t5hE6kGQdC4bjC0yK7aIWuDIxR32ilHCEPepjE4h25LyG0gxyJnkOE?=
 =?us-ascii?Q?zQBdnb59nhn9kexjqCn7nkKg2sO7E19w/StW92mXjQ3eqLGAeoVB3Epp+6Cg?=
 =?us-ascii?Q?P0jzjqgIn2G3UwgP05CSL+vjBc188KwcFixRPbJWQtnf9DTJzx0TjMuTbVaj?=
 =?us-ascii?Q?es9onvBuXygvhLU7Hj7DwgwykH3b08FXbuOl2cohMsMJNh5CjyHwqpKFT4fu?=
 =?us-ascii?Q?4caQNdcgzi+SDV1TOqrQGYr1nrfpdLVBljtHyt5RIKo6Qy0mLBOpjMEnsip0?=
 =?us-ascii?Q?8L7077vWeKSKO2F43dpLIcbdHEBm45EUY0e3sdMTn4LBopCYseyq3nPYrlg6?=
 =?us-ascii?Q?3og0zU6xCRTMv9hmIhy4smbssdeX9djXTrg2foQQiDHs1iDYnNtFqfRsxdh2?=
 =?us-ascii?Q?HXFOsFFDoWSDdl6wTb6LhHMVJjpG0TipGqHna1WHYm5p44NhoFFjluimc2A6?=
 =?us-ascii?Q?XHTgAAE0k+AtKWqh1Utmo0u8IkJGdHNEoGeYm1LFNlERxtPilbk9luzTQ5x2?=
 =?us-ascii?Q?uumkFVWneWHuClDW0gcUiolsySSaHrVEGf8dLDD2wk5qGPk6Wi4YkxrZhnoo?=
 =?us-ascii?Q?3PLP3cWcqvB6Xo8P2I4RsMgGHdJ3PejPYeKK1EYC/IkLEvr9J0fif6188OGD?=
 =?us-ascii?Q?WaxmnBAO1/bJXCxHNzh4HuK8GJOO1WWwnMLLQNYfN/n9m4RRtVV11egIUaGK?=
 =?us-ascii?Q?fRFR0mrR2zsaCBARRTI3GK8dzaYdR5gINFGG1uCmW+UAoFg16zkAE+DQzlOu?=
 =?us-ascii?Q?HmSI1OSmKkmXuYWlQXiAY5YiusssfZgwu5oKIG1S0ZvgyxubggnQv7SXzZuq?=
 =?us-ascii?Q?xl903WQB7hcu5PAui8LAvKyJZmG8Pn78J35kjca04mgqUP8RDPjT9ZSCUG1Y?=
 =?us-ascii?Q?Jzr1wdrTBOVdqh/JswIuJZcqVBzb00E8M40ZAbMFUMdtOWuaPol816BMRF+C?=
 =?us-ascii?Q?veaQJ3orWaPYqzc6j1fXcP26F+1yNtm8qGZnIJv3M54EVY6UXe0Z3fCXgm97?=
 =?us-ascii?Q?ig/Fbe3OQ9CTldzF+BUQVoCdbxUbX9D8C8+DKPd7/OjW8v1NaWu4TFZCKvdh?=
 =?us-ascii?Q?5uTD1qkNNLCr6yVIdW3Pgz1Spo4ujiE4kFsfAJn38YO6UFAFhwYvZqYsrrlR?=
 =?us-ascii?Q?Y8qD13iNi3jD01XnPaARonfHbMCqxZUOXoLc5R917maCj6wDeATp6LJ6hTqP?=
 =?us-ascii?Q?R3nYGdJ4O/bi1pOMtBP4hHWWNc4d9v1nf3ddnli/55fFxygqOG/ZCpERDJ3i?=
 =?us-ascii?Q?ah72WkNsO2g8pZhhi6XxFTAfNBkS1Q6NlDbEMEtf/Py8U0NtbtR/7LF4+g/A?=
 =?us-ascii?Q?ZDsx87M40AVtUmN5pIBDqhirOpAugkLUyzXQCj9lInupqPzAIvmknw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?P3ZmFOEEewU5rqHzbqId8LtQxb/fVE77tsaZMn0osnh2YnhspUeq2xA/5YWE?=
 =?us-ascii?Q?IH+exUvBme0dzBzLcaipsbHcaXoXjtln4KVZssNHDkreW0LIuufG+Zqx78yP?=
 =?us-ascii?Q?rdUYWZB3/jMk/XZfdsTmLZD6S1nla6AahLyX/yVTZJ8g+UbbpTYf+qidt0P3?=
 =?us-ascii?Q?1y11dolE4ErDAreQLxUhYK4mlxqbhK3LfQahUJr0R1Lj2TBThwQsa9szvPu6?=
 =?us-ascii?Q?YW7zrqRUUNa4LAZCe70i9xukzqt72HGetaQCtouBh3NPDS7w5oTG2OSjLj5z?=
 =?us-ascii?Q?zvz1x7DWHlWMUSg/jEzHecJGELvQOOBQvq6qkQMp2REeQD88qjzDfKVLPOvV?=
 =?us-ascii?Q?vUeAg0QOaK/i101ETRBDv5grNxbmG+NRhOv6XQtRBnT7M9664xMDtBKlFKu5?=
 =?us-ascii?Q?cEjlG9KnnkweWiVGmydlWRDOsY7J3LQuL6IWjlwnZDOD5zDuHGeVGDZa0+Ke?=
 =?us-ascii?Q?XfNXY/p5vw8+TgUIByTR5AIHdSFJBCR3x+bvp8qDhgLe8q6RPgMmE7AvEPjZ?=
 =?us-ascii?Q?1pTrIDIw+gq3NdmhzUhR0pzC/ZoClpzZP8C+nuF9P0fo0al6z/BuaPyR6VQa?=
 =?us-ascii?Q?PwruPbsQ9G7cjI0sI2mGTisktB3RMbxi/639hqU5QD7rPxhr48RkuvQItkPY?=
 =?us-ascii?Q?Hyvc/CdwEL9aHpUEoKVJwv4uHdNMVf/jWYkliUhJNDQ24FDx9Em5hwCNFwg0?=
 =?us-ascii?Q?wCrxkmVI5kJwg7b0t40d3VBEkFKKCnbOczufVBbZ3u3iS2XVbJcX3C1s61/l?=
 =?us-ascii?Q?+NK4tXFoHh2EEb03ZrsLHkHnf0Fi0hmtZ76w2SyEZ8XJKlC0y48ezAk43JyO?=
 =?us-ascii?Q?1j41bTOsSMxVohJ8+Z1piDy9dqWHbygogD3mtlsAtC3yB2L1Lf9EH9MjsEa+?=
 =?us-ascii?Q?z7ZhV8CtQ7BcpU+lBfM+Yp9m2Y9A3s56HYv29gScIeQCRGKnluRgSt19+Bkw?=
 =?us-ascii?Q?c8s7092KFzRJffysXgWbKZz4NadiamjQYrlof7Oc1BM34Ilwy8RyL0nL/JXv?=
 =?us-ascii?Q?xF0x+OzWVpvtS3jkg/MUsQNFX9ChKo9l+TXQ9yLtunR0P2vh4/yh+o0H96fu?=
 =?us-ascii?Q?qnNbH8WItmikGd7MziDOiuMBDHJ2tygeTmdgz+jyMKeaU8N+daE1CguOYyRk?=
 =?us-ascii?Q?ByQmMBYx4yFL56pLTBeecyJ/YP7UrhD1VzodSA9H1nER+LwuvMEpGojqi37O?=
 =?us-ascii?Q?I90NVPlo8LKlSlLoBZnqxhqfi+In5AiZCBpsHAsHMCUBbJZiHEThnSfnfU0Z?=
 =?us-ascii?Q?8qHWWhyxW2H3qWTwCaOSzgyz4kqIqQbrLJUP2oyHZE2/6V1QC/FyFy91okJd?=
 =?us-ascii?Q?DtxGzoR6odOSAOwvh9m+vAqyLDkBgiBmgyPZJ8ove14OR1daMEoHWLAPamVh?=
 =?us-ascii?Q?6bSL33lLdXX0lg1Xz/bPeAagxQDRsiDgd472xPvx5w9E99RjUXepdF970FwH?=
 =?us-ascii?Q?RqNN6xDtgYOcNrNrAgoVN9T50N8B/vJiESaJXCDcXno/3ZdkUKfYzEt5/szB?=
 =?us-ascii?Q?RfJcHSUmmsYMwu4vQdxnXoTTmf0a2lUEkL5J+MZXzA962gsyIAvdyzsz/Z/E?=
 =?us-ascii?Q?t34Q+UXnitgYsXWeC5/2eOuJ/CHs/15iCzZh+u4l?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fbcf07ba-333a-4a5c-cfc9-08de111c39bd
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2025 03:36:45.9940
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LyS/8XkxEw7DrG7sjndAyJ5glrae+JPOkIMyRwKRdpfvi70ilEdd3IJf981M/MM2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6268

Hi all,

This patchset is a follow-up of "[PATCH v3] mm/huge_memory: do not change
split_huge_page*() target order silently."[1]. It improves how memory
failure code handles large block size(LBS) folios with
min_order_for_split() > 0. By splitting a large folio containing HW
poisoned pages to min_order_for_split(), the after-split folios without
HW poisoned pages could be freed for reuse. To achieve this, folio split
code needs to set has_hwpoisoned on after-split folios containing HW
poisoned pages.

This patchset includes:
1. A patch sets has_hwpoisoned on the right after-split folios after
   scanning all pages in the folios,
2. A patch adds split_huge_page_to_order(),
3. Patch 2 and Patch 3 of "[PATCH v2 0/3] Do not change split folio target
   order"[2],

This patchset is based on mm-new.

Changelog
===
From V2[2]:
1. Patch 1 is sent separately as a hotfix[1].
2. set has_hwpoisoned on after-split folios if any contains HW poisoned
   pages.
3. added split_huge_page_to_order().
4. added a missing newline after variable decalaration.
5. added /* release= */ to try_to_split_thp_page().
6. restructured try_to_split_thp_page() in memory_failure().
7. fixed a typo.
8. clarified the comment in soft_offline_in_use_page().


Link: https://lore.kernel.org/all/20251017013630.139907-1-ziy@nvidia.com/ [1]
Link: https://lore.kernel.org/all/20251016033452.125479-1-ziy@nvidia.com/ [2]

Zi Yan (4):
  mm/huge_memory: preserve PG_has_hwpoisoned if a folio is split to >0
    order
  mm/huge_memory: add split_huge_page_to_order()
  mm/memory-failure: improve large block size folio handling.
  mm/huge_memory: fix kernel-doc comments for folio_split() and related.

 include/linux/huge_mm.h | 22 ++++++++++++-----
 mm/huge_memory.c        | 55 ++++++++++++++++++++++++++++++-----------
 mm/memory-failure.c     | 30 +++++++++++++++++++---
 3 files changed, 82 insertions(+), 25 deletions(-)

-- 
2.51.0


