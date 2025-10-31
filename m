Return-Path: <linux-fsdevel+bounces-66604-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DDE30C26129
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Oct 2025 17:20:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 612ED351DEE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Oct 2025 16:20:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40FEF28D83E;
	Fri, 31 Oct 2025 16:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="RVeFHtgk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010005.outbound.protection.outlook.com [52.101.61.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7EA025334B;
	Fri, 31 Oct 2025 16:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761927577; cv=fail; b=d2eaeXOMBRaVuxqU1p+meMsp+2+XQrWWtK+3DcM1InloS/8VtctQfky7YM6tETbmELdonII5rXQay7HHPFizyMhLAoNn/UmF4D83+f/lXDSIwABOA/Bo7CbNsA2uPi7vzyoDWLkOObj+sNf8jQsHZj4La0+vEuM9v1qlRgjQ4VQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761927577; c=relaxed/simple;
	bh=n+ZJszNqzQwE/kKGj/sq5jTE2bwJaKCbWzNRxx5QRTs=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=MyxHQ70LlMiXTlIKjAA0M2pIYhYE6M6frtBjpwNByAgd15ROyv3E+yS+6k5nDaX+TWFkKPerprykxFoL6FjRvB3yso89eaRCz9S5uqC6+Z8AetCTLgnEiybyDTcRUBrChyvkcn5BUydHT/0kM8C8/5t2Xvr0uVn2cltiUVrzcZs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=RVeFHtgk; arc=fail smtp.client-ip=52.101.61.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wnCOepv5XmpmGle9wfpDLPI5u9IKhTRGmoN4PtKDAudTF6tKZNTBSsopEvI5KqxNunzgUlM7kSIUP8YaqkpMuSl3WlTO//B8d4qYgkgWJrfLmfwHOJkk3oLmxwkcVybN88RsJeTg29VnjhTj8Lx6Sa5XVvZSrg2T27z9JU6SDQAU3770pWJI5ks7fbxegDNto679iLB8rjSufPNnAjV8WkIB0nfqDnArXaSnWAvobGcysgh1GlcSIbX39BKp7CUj4myLG/0Yc70z+1Qk+NeEJvpa3go3od3UoC5qYe2c3RWHFTiHecvqq4okYXdW7PMokxkePbUHr1gbVJKZkdeDHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B0owgORCxAgiUBrgTGnNI6IPdQS0LhWBrTv+cInHmrw=;
 b=l28K1xg2KA7B8qd3izBvW5yE0nWh51ccqemWV/FwKzIHgbbbiFvrStIGqG4JGHKnOBeBSoNwsz3+LK+zCTtdhutERqLtvTsD5HHpMz+BR9MGhAh0vG2ULP503bWef08zcVVgyqOKwBvR6YZCYAgWdTTr95NHsPrx3MSzvqnqVe1IVYkB7QM/eK6mSYMLTJapBmllHmuajRG0vhjXPE/FvEcu4i1SxDRRKJsLSM5UjGDDaEsIq7HEG65exEq0wWJ6UReNLCaXbJqiXq0l93COvV3YMnxDG6IPW3c8/J5/nQ++wfqKJeoNsjoQ0o3XNP3+p/DrGPfda3homL0ammWF1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B0owgORCxAgiUBrgTGnNI6IPdQS0LhWBrTv+cInHmrw=;
 b=RVeFHtgk5kcXqrJ3yw1gnXs8shpl+0oiK55MrSJb5BzHtvlXnL1Mn8dT3E7Qx9qI9P69FbSDRIZ/0em4Ftb2B3m0KvPIzCn/JF6FHdarFKYnE0G5b6CADuhp64To8VhFvwdulQWVUisZwdZ0kxBYhx3Xy9hFF7ClJ1R9edGmIl2vNTVRRg5nWfTWHnb9pbFfMhpd4yvw5LFYEskDV49mcLFtygVrR4QHpi+XcTumNsengn2bDjC0ZmuY0R3pw3gDSA9UiNO5v6JW8MM+1AvKEIZPZbxPlUhp8xd8OgmuefrXVSEjDC1zqnqfa26Pnfwq3hQ1PiWUG5AQz8kJRI4aEQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 PH7PR12MB8428.namprd12.prod.outlook.com (2603:10b6:510:243::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.14; Fri, 31 Oct
 2025 16:19:30 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%5]) with mapi id 15.20.9275.013; Fri, 31 Oct 2025
 16:19:30 +0000
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
Subject: [PATCH v5 0/3] Optimize folio split in memory failure
Date: Fri, 31 Oct 2025 12:19:58 -0400
Message-ID: <20251031162001.670503-1-ziy@nvidia.com>
X-Mailer: git-send-email 2.51.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0320.namprd13.prod.outlook.com
 (2603:10b6:208:2c1::25) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|PH7PR12MB8428:EE_
X-MS-Office365-Filtering-Correlation-Id: 234eba21-aa3b-4deb-d3b1-08de1899451a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?JqsRRyW9x9AZDQ6xogKOwKf3DM1phsHEvgxr4t0qdHyjfhl1357jB4is8PnH?=
 =?us-ascii?Q?El7ZGBd7Ntrro9pOZCrm4OerC9+OWmrT3pSMj8IMN4hML+SJJ9OMGUJiX6D4?=
 =?us-ascii?Q?GLcxUn/nFFXyqdtNRcKawGUkpEiyH2IkgAsmcEwRE29jZcuAiFWIUNxodkNY?=
 =?us-ascii?Q?THwdR5YnMipXqzUGtewKiqVuEkrXb0D2nzhIt/BMCB+hcPNfSJwhG3O6b4MR?=
 =?us-ascii?Q?awJLqTVRoEUjB7NRnVIt0YB/daFo9/Bq3z/L/Rr1MyJq0/JOLGUR42kQNEdp?=
 =?us-ascii?Q?iVxqfpIrdhA/2YLBUou+yLe6R/9R0WcPHT6kfIA2tdIH/03v82r2oCW/Ncej?=
 =?us-ascii?Q?RV0hek5KCREUQNpU5CUXSJq76uKiwQ+DGT/BgyPCodWvmHZKTjBJ7x5LGitE?=
 =?us-ascii?Q?JUrs/k9Hv1VP8ixOQiv5U4s/UrgVKVnyFHQidP7wRUg6yTesULIIz5PiWkyJ?=
 =?us-ascii?Q?t0E5qWW8SseZ+Y9ZXBmO1Uy6kx2cET4mBo6dYQRlpO+6Vq9WFhqKXkvQTBAf?=
 =?us-ascii?Q?pRz9u+OFxAtkt0Ik/zlW/u+kOqIQ5ZcuBv84bAOxobKXGHb2Ak+JOqHb7FEg?=
 =?us-ascii?Q?eBUF1V0CK5KlP2JQmefVkSo9fHU3TLBhC+iiaB0sMzhVKFL+mh2ey+aSWVqj?=
 =?us-ascii?Q?DDnYxcXJIog1gvTtNaL8vXnxm0GwmlxuU0UZO496FhNYUspCRYqVs2RZjZYH?=
 =?us-ascii?Q?q41bmgRtdChTtI8KHsNPjGvLLGtKsCxfMwOlVHVARAN0moth4Jxys78wxdMY?=
 =?us-ascii?Q?bZM9+YTjun7jUU2XaoDRYbhQ+RSM9DGbKKo5Re705e8gkwRNJ6M5fH1Y5QZz?=
 =?us-ascii?Q?Kv8odao+pxKavGCGAfch9spjNonbKl+yWaBpCX/UqLxiD7H3UH3EV51TGQHx?=
 =?us-ascii?Q?FYxUMbnjjF/oIYpN1rQk+d351CMzZ8520UGnTzvCYcrbFuZo0UsYRDVj4+rL?=
 =?us-ascii?Q?Yx+t0UsN71W/ryowwL/Pr9MCRfhozC9VoXt2Xpp4Zla9kz4rjrQ+8WkpMhd0?=
 =?us-ascii?Q?AEZpbE9sDBhuddatl7YKNcQ/naGQfaywNSnP/wh4jYczJi6hYRWVIz3J2l83?=
 =?us-ascii?Q?hatqGtIcio7ScTWbXVVSA8OtG7ahORkULavyadiq+BAG9iTPfAL/C1t1b4At?=
 =?us-ascii?Q?OH3jUzR3YCkTZtMvObM3291izpXa2oZrrmp16wijPVOYIVQArT3a0zxNXW4A?=
 =?us-ascii?Q?vwTFBjDXVBvZvhPt8jTv82FFlQpmNcC2oa4JoMSXJYC+Men2wIgDplzRUavv?=
 =?us-ascii?Q?ARSKLHiov3rjVoOiWhMehQ7vkMtjugNVt02ALV3aDB9+Nmf5t4Pocnr2V2qE?=
 =?us-ascii?Q?mP0D/prqALLs9qVsWgrOCIwTv+0+Nor7c4eeyydw++/B6eqkLRCQh/dP+ZdL?=
 =?us-ascii?Q?3yL3GUigObp05EnI6aux08J/XjdiB77K/+62tvYY/LsxkZuoIQp56ZO3O1ss?=
 =?us-ascii?Q?Urm3mPye918/ew9g6vWmww4rPvA3WwCbFFb9I6C2qUzi6T4pxE10Ig=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?K9PLRukXK8uHBIGNYVA2gdlWruOrH2+m5pzmotopFLYSr+gCsfgsZd4bvGF2?=
 =?us-ascii?Q?DNs0f0jJgjRFNqBtn260cuH07IAd/Hjiv1akuDR0uwXaFlokXoGchgSCvgbb?=
 =?us-ascii?Q?JsjUoC/LOgn1zcVbmfQFFgmVynZfXFcB+NbKEJrZfX4dutaI7S986sjiXD/q?=
 =?us-ascii?Q?tdzRDlhfIKrhWyZVThhntHPiGSgAwacm/fQfwCCInN0HCBE1sQ07XR9A5eUy?=
 =?us-ascii?Q?4jrgwT8ZhLtRHQ3E+oxVpaHCKnfp0l5nc7IoK6onSDYJ/laHhf0s+RvJbxvc?=
 =?us-ascii?Q?DfJNfHcxPwCXboy96UKunnbH2vizluj9N2WkLnjgG62+kBkIOXOpZz32gbwe?=
 =?us-ascii?Q?xO9hCya6NKWcX+lOF7b2yZYdQqUAlkxzLWcQaP2bISxtn2bBd6E7cn3ErebL?=
 =?us-ascii?Q?Q3skvuj5hP+34fGd1PAPb04eJDybxPXPot7ws0518OdSdgV0N73WXLSZCHAj?=
 =?us-ascii?Q?b7j+c3H46+6CgIx0ed1E3GqRvFuJjfsol4R9NsIyX/wqcc3u08CTCszzqCh9?=
 =?us-ascii?Q?nUQRHJ/m13FsR9dgj+ZfRaG9N+vcW+SmT8fXbkBSdhzrw1CPLt19UWlAT+jE?=
 =?us-ascii?Q?xrUUIKczWRA+wKZHu1oCY5qMP72R/mSw9AEpNKu79jP324WKfsYz9prIJyNo?=
 =?us-ascii?Q?1Z6lSVYbGAfj5qhl9oWjyrqljNDBe8hZk0qsfzh4lQBtIP9pNMibGc2KB2sI?=
 =?us-ascii?Q?P9+oVX4R6pYxi3pwhw/ydU8b6tYk8mCJ4T/ZEArQyyThYG2bTHRngpf/7PVD?=
 =?us-ascii?Q?YENqQ55S5aXNTX03CB5Fvgpy3Oad2arDsBH2dDRZFuSwvtyFlXJs2dJ7T139?=
 =?us-ascii?Q?jawSjsVK2aeNZ+KdIf8jow+i2MbnzfGoQRlunjmUk4Fruu9DfOeS5VHZlD/h?=
 =?us-ascii?Q?cEQLNd+wzMhopDtqQA0McId726/6j6vQC1zwCFPuSdi2S8c6jpDVpHWuF6PQ?=
 =?us-ascii?Q?SHBnlBC8Lf4Qb4giwNGYszMV5o8sibm4qVx5v0t/NrofXQfFLW9vDU3GEmoC?=
 =?us-ascii?Q?gsx+KaiNNzs2+FP5L7mhyGEOaSTYnoQOYEzVv6WrvJP92xwD1gVOga4x8xwz?=
 =?us-ascii?Q?1bimXvM3DPoeRQQ6OIU8czR8iFNpnV+LdLfe9OhBYFTJRWWKlLvl0lxBNfao?=
 =?us-ascii?Q?1enVMX2POHkrKJi7UzDzNBjAqVs6F4X7UQG/20xXjCB315M6TJrcb2ccdzb4?=
 =?us-ascii?Q?vPwuE+IN+QV5f7koQyrrSUwQWDdVVs312aWdjkgHgG+0mQleTpBK0C+X1Zaq?=
 =?us-ascii?Q?K1tYwwkdxNn3h84rqQwiVd3qa6njEkT6yCxGieXFp3BMqQAhcolk5TAmpA1n?=
 =?us-ascii?Q?DfxpBLhwZDpRib1daEQEQCGQYyInxUIcmwcZHlB7RU0qP5zjib7KLJkVnCTB?=
 =?us-ascii?Q?1BJd5gyDwQqpNeYxxDvNHZhj0GxNLKkgUklHLIxmc3u5OKcU4XFV8TLraHCh?=
 =?us-ascii?Q?JhqmWZT2r6ZcfGG+ajV1boGDqImy6AG9YE8UHKi6YaFliIxXJp7TmEY2ilak?=
 =?us-ascii?Q?q0ZeVL2g7w1HD+/B9q4bRhCKPYI1hV/sYz7ou+Q8cbXWMabZLxkqHBoKl0iL?=
 =?us-ascii?Q?tRSVaATm3ntR5p6t/VtQVegKGJXTEg2O3flvHCKE?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 234eba21-aa3b-4deb-d3b1-08de1899451a
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2025 16:19:30.3007
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Hxb/+cfCrDOU78ymktO8Uz1bvpps8BdVmeTZM4fDKrBzSwA56CE4I8dP6hXZRYDN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8428

This patchset optimizes folio split operations in memory failure code by
always splitting a folio to min_order_for_split() to minimize unusable
pages, even if min_order_for_split() is non zero and memory failure code
would take the failed path eventually for a successfully split folio.
This means instead of making the entire original folio unusable memory
failure code would only make its after-split folio, which has order of
min_order_for_split() and contains HWPoison page, unusable.
For soft offline case, since the original folio is still accessible,
no split is performed if the folio cannot be split to order-0 to prevent
potential performance loss. In addition, add split_huge_page_to_order()
to improve code readability and fix kernel-doc comment format for
folio_split() and other related functions.

It is based on mm-new without V4 of this patchset.

Background
===

This patchset is a follow-up of "[PATCH v3] mm/huge_memory: do not change
split_huge_page*() target order silently."[1] and
[PATCH v4] mm/huge_memory: preserve PG_has_hwpoisoned if a folio is split
to >0 order[2], since both are separated out as hotfixes. It improves how
memory failure code handles large block size(LBS) folios with
min_order_for_split() > 0. By splitting a large folio containing HW
poisoned pages to min_order_for_split(), the after-split folios without
HW poisoned pages could be freed for reuse. To achieve this, folio split
code needs to set has_hwpoisoned on after-split folios containing HW
poisoned pages and it is done in the hotfix in [2].

This patchset includes:
1. A patch adds split_huge_page_to_order(),
2. Patch 2 and Patch 3 of "[PATCH v2 0/3] Do not change split folio target
   order"[3],


Changelog
===
From V4[5]:
1. updated cover letter.
2. updated __split_unmapped_folio() comment and removed stale text.

From V3[4]:
1. Patch, mm/huge_memory: preserve PG_has_hwpoisoned if a folio is split
   to >0 order, is sent separately as a hotfix[2].
2. made newly added new_order const in memory_failure() and
   soft_offline_in_use_page().
3. explained in a comment why in memory_failure() after-split >0 order
   folios are still treated as if the split failed.


From V2[3]:
1. Patch 1 is sent separately as a hotfix[1].
2. set has_hwpoisoned on after-split folios if any contains HW poisoned
   pages.
3. added split_huge_page_to_order().
4. added a missing newline after variable decalaration.
5. added /* release= */ to try_to_split_thp_page().
6. restructured try_to_split_thp_page() in memory_failure().
7. fixed a typo.
8. reworded the comment in soft_offline_in_use_page() for better
   understanding.


Link: https://lore.kernel.org/all/20251017013630.139907-1-ziy@nvidia.com/ [1]
Link: https://lore.kernel.org/all/20251023030521.473097-1-ziy@nvidia.com/ [2]
Link: https://lore.kernel.org/all/20251016033452.125479-1-ziy@nvidia.com/ [3]
Link: https://lore.kernel.org/all/20251022033531.389351-1-ziy@nvidia.com/ [4]
Link: https://lore.kernel.org/all/20251030014020.475659-1-ziy@nvidia.com/ [5]

Zi Yan (3):
  mm/huge_memory: add split_huge_page_to_order()
  mm/memory-failure: improve large block size folio handling.
  mm/huge_memory: fix kernel-doc comments for folio_split() and related.

 include/linux/huge_mm.h | 22 ++++++++++++++------
 mm/huge_memory.c        | 45 ++++++++++++++++++++++-------------------
 mm/memory-failure.c     | 31 ++++++++++++++++++++++++----
 3 files changed, 67 insertions(+), 31 deletions(-)

-- 
2.51.0


