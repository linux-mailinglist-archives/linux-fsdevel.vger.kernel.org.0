Return-Path: <linux-fsdevel+bounces-68600-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 36FCFC60EEF
	for <lists+linux-fsdevel@lfdr.de>; Sun, 16 Nov 2025 03:10:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 83531352D37
	for <lists+linux-fsdevel@lfdr.de>; Sun, 16 Nov 2025 02:10:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E225214813;
	Sun, 16 Nov 2025 02:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="QCUYpSch"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012049.outbound.protection.outlook.com [40.93.195.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5526E17A316;
	Sun, 16 Nov 2025 02:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763259008; cv=fail; b=iQMnSGzxowii+u0x7WCvMxTHKs/lX3Tb4hCez9zY9/qNz61lznrxEoZyHAVARtYmJb4DMCrLmvX8y9DY7NhImZxunei9qVLbHCUy/lsS9ESM1URdP/wKoJkz3tw9hpKlYE5JvgjLVbjAmUd6Jb8wZqPJ7llLOCuN6FoWcCfBegE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763259008; c=relaxed/simple;
	bh=rrbTqC9Jv+WDXO8BPeqzI+5sGhmUXXXR5i3HO7/hWWw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Wdy31Q2KpOkonSF8lhTQWmruG6206q+k5tfupoY3lCJWAlkqkVWjrfcVAW+WsFme1qki6ovEM4yeqUCUY8nBfVOUemaDEuHiUaN/gjRJKLHMPM9AHIJIuYnL0+TFOAIFpIYMjqmKEqCPJv4Iie/OsskxrPBKiaFgliVwijkP/gQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=QCUYpSch; arc=fail smtp.client-ip=40.93.195.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GuoBf+B+1+e1jgKfYUSEPUJ7e5KTDFJ5ABg3N18DH0xh7HOEExWkXDxbQnMtm2d0Oy1Zv6evm+MKMO8WrDiG5GQLfACs2/hAvZEUesnNJM3W1jodD2ZfNutQJE6FUizfAudTKrarZ1k+KagqKxEjnmOttERsAdGo4FTAY6nemNZpW8wEj2hVmdNBeSbok5A/3cf3ubZnz68d9vO9+CGvhivwHKF9OMSOWETDe4dKKUfRaiMauMDOvL4720EUtCBRf1OqsPpQAlTtYK4rrqmEmkjMZ3vCwc+jKgNyxIF1+/S4j0Z91ffe2y6v19QyRtHNweNbbjGAhuhfrt5TXuDE4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E0p67oxgYIiBvmWBwcs+ACJ9DIigd70/6iWKrQuQ1dg=;
 b=sMeZ63es4Mjtef+1TFO89dq607/6ZxqeUHFzjCIuLSy5EXg/zsIDL+HZyfgQyAvuDXz6uqOu+bXHei3mnoN3ljJHo9sIg+Xodc4hGaYXkIEYFzVyDLARHF2MaVWxfKyAtYA3QAib0pgF3O9UbpqLRCWWKfBybN/b4WGUjakPugNe0Mqvj0gzc1L2qRJzvpo1g/GlxLJ6S9Cl0wPBHTPB5H5RaTzX6PWDd/r8Xi9W04XXJ+/oCseova8e6ocM+5wLYd6XMVru+8ZmMg7nT1VXhOjxu50LNcbzMLJnM74hRMJdHDhIufB1ZY7VItgwVzVLi/vU7Lh+4EeawfXpYgxkJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E0p67oxgYIiBvmWBwcs+ACJ9DIigd70/6iWKrQuQ1dg=;
 b=QCUYpSchzdG2LVuQQH82V0DgXD56WLYaZwOdp6BIhLHUhhvLJhkko1Gg1KGGEAocLCSV+0uke5vRZWmuGMopBhY+I0y0L8lN4Xnf0JId4XOJSuhDmejCqsQ+jNTuLz/avBUnX5FuhxHZXGs6kd303QakkaOum8mc8ohAyKN8dM3vByQVHZ9uPuLFsThs2siw9T0j6dtq4Cs/8XloIYe4J/o2bVHxUUjxSm861yVJG3VPMd5QJg1dtSM34NFw5proYSskMsY/kKr01uSeEE08z+bA5XMJWNE2DRdGyQNwYEkN20xEGdnTbtbbIf7+SNJfyiv/f10YhD0EtpsD9qg7gw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 SJ1PR12MB6267.namprd12.prod.outlook.com (2603:10b6:a03:456::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.17; Sun, 16 Nov
 2025 02:10:03 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%5]) with mapi id 15.20.9320.018; Sun, 16 Nov 2025
 02:10:03 +0000
From: Zi Yan <ziy@nvidia.com>
To: Jiaqi Yan <jiaqiyan@google.com>
Cc: nao.horiguchi@gmail.com, linmiaohe@huawei.com, david@redhat.com,
 lorenzo.stoakes@oracle.com, william.roche@oracle.com, harry.yoo@oracle.com,
 tony.luck@intel.com, wangkefeng.wang@huawei.com, willy@infradead.org,
 jane.chu@oracle.com, akpm@linux-foundation.org, osalvador@suse.de,
 muchun.song@linux.dev, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v1 2/2] mm/memory-failure: avoid free HWPoison high-order
 folio
Date: Sat, 15 Nov 2025 21:10:01 -0500
X-Mailer: MailMate (2.0r6290)
Message-ID: <CD886E34-9126-4B34-93B2-3DFBDAC4C454@nvidia.com>
In-Reply-To: <20251116014721.1561456-3-jiaqiyan@google.com>
References: <20251116014721.1561456-1-jiaqiyan@google.com>
 <20251116014721.1561456-3-jiaqiyan@google.com>
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: BLAPR03CA0151.namprd03.prod.outlook.com
 (2603:10b6:208:32f::15) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|SJ1PR12MB6267:EE_
X-MS-Office365-Filtering-Correlation-Id: c57dee58-e3d8-4dfd-e3a1-08de24b540e1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?coEQdaQibAATQPzoqshPMSrlBmKAfp7z3x53jyuhntYClqjZLmP5iHAV469G?=
 =?us-ascii?Q?yRxtF1dEldYUB62CFDI+vX58FLc2kORjstSrSZaMpf1CDJ1HULXlGecXsh2w?=
 =?us-ascii?Q?vk4RIikfYWCorSXP0+FxhMeCDJwD/IhafSgimIxgXkP357GDwMAo9hhuZUrG?=
 =?us-ascii?Q?Cbo4fD4BwZNeZejlvJQQbYAcDvkRoeaWkFDA4pP8FBLqGc4WhSP+4CwhvkNk?=
 =?us-ascii?Q?uFfgn8HjKEdbYyGaNuNsUkWmcBxDzQ+tCZ2aX3rFsaRoUJ1WLbOR1+ch2sdK?=
 =?us-ascii?Q?6JRxCls9KV2Ru/DZPC7SXVWe18wX1lzBFSalWcy9yBojgNZXNE8WIa/9jRYo?=
 =?us-ascii?Q?HmtGQ3NNIJWkhRJFj41UgwG0GjMCiceo8Eft54jHMdehGn0rdDKRc1JCx0K1?=
 =?us-ascii?Q?biYHW2VTBI+7pGY5Hgn8V2KbsYjCqa9uRIbafiLKkZRLzTXaywcRwo2Kp6eb?=
 =?us-ascii?Q?wHuykoCNSltj2YW/dXt57q8nKAibMsU6YNuhxOTwgmSjfOTsyNrncs4kHFT2?=
 =?us-ascii?Q?6obtcjKvEKuMmpB8hMRrB+ZjIDb9pr904jRy3G5QwvIO1LIV3VoD6RjAwUVX?=
 =?us-ascii?Q?PkTfZQKLCWLCu0adWivp5Be3RPmMuY9GaVO2YzIVX54DBfqTxOwIOTJbS0E6?=
 =?us-ascii?Q?DlTOme5ZPWE4LUb4UFdD9YuUVS5mxCuIdQ/n00KQG8gMGzCZBkbY0TK0G8Hx?=
 =?us-ascii?Q?6vid/bw/etyB6AjXeNopv7rJQCXgb2CZEDL7BPhzJQaJeCtK4MW5tf0HOPk0?=
 =?us-ascii?Q?MLKkyjCaghixo9QnCw0QjF6avauysfxXiZs9Dm4OP41JR5ZOhqj9xXURVRe2?=
 =?us-ascii?Q?nSwTa3rAlPf9HDXwv3a/1Pyl4bcWh20wrOM5h7xkE2OILAPd5p0Kn/xYfujS?=
 =?us-ascii?Q?IwMGCG0PmzhxHZibhN9D9KNUfTNzJok+TXmDwl+adO3159JDX96EQG7wP1Z1?=
 =?us-ascii?Q?zcSFySint51pocp2Ls8+mrHM6/Wv+6hgeB4stAhPXN9DjDjJKV8NXnL66baH?=
 =?us-ascii?Q?j9xhp/Cr8fz22bg4eLeuX+ebWjaM1RawFGayALrjlY6lTV7kAOv6mnkxqyEf?=
 =?us-ascii?Q?bymxKc5k6xQnt1VTKSN100dg80TqpgxkLmZXF+9IX9fWI2rMFia5Ep7CXI/k?=
 =?us-ascii?Q?E/qA0VvUh/KN8BJ/wIFJ3ZQM+nIue1INY4OwpV+I9X8K6O1uC5TLMbtnEMzi?=
 =?us-ascii?Q?FKKPruE7/uapDKP7WprjUhnVSY+Km/pKO/y3Ttt99foMIkQKeaZ9B0Kq4zeC?=
 =?us-ascii?Q?NJ0AyoeeLmW8k+21SmU6OHyvpe6bySOoFFh9+8jKF5zorg6bVburO5moHmrU?=
 =?us-ascii?Q?NnZaKFbxKftYofzFqyb1IbIwv9eTJWn3WBIe/yzx9kuDVcyx1Wv/Ej8b2vY/?=
 =?us-ascii?Q?8ZnIwi8fja//AkQGTorwoCRb/CNlitLNyg0MTpiU0xop9GviAknufG5BFGOV?=
 =?us-ascii?Q?r6PECPqx9oXO3qlSZp01zmJAS/mf8/ctUSNpIAVR8rgpP2HU7Vkk0Q=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9Smf5U89gV1jZEL0ztScD45mBszXdZnTyQ9zVNZ2vlr/VEXlh88nSnnre4Zs?=
 =?us-ascii?Q?RlpFYCDjj8FGBqU7Ix9x+2tAdU8SlnLNtlPNh/oXDVt5X4cux+jNqV5Lx3mH?=
 =?us-ascii?Q?k+0sO4Frreb3ZKE4DXNnrvxJFHHkBjMy0kUjupoHMzs/fHwZDelQ6f6j0/fd?=
 =?us-ascii?Q?FauAOrmYEjP6m0glFT9j7S1bci3UogqkxkNY+h8qtRrjapnURJG3PUINqf4P?=
 =?us-ascii?Q?m0KHn7wA82KcSKt9ALW6Z4RlXEF9l1cx3mMRMI+jnTNDcJpKRBddoVMWjPxt?=
 =?us-ascii?Q?y0A89zKgH6Jix8pEIeK2OLca+rQ733r4pqNT/d3ZMNrpQQlkxx14D5oOfZki?=
 =?us-ascii?Q?VyGYeZH/0kO9nHeDJGwM2Uj+fWR/IqqoMWueIHUHzwSrrBwUPlthAEp6Xiuv?=
 =?us-ascii?Q?j+e3AbaF9Ki/eoG5xSBMzNIzKiG/iu12FdYVAnp8pNmBlruKxlUv7XSUFtw/?=
 =?us-ascii?Q?9gB4J1ZCi4m1eWtMZKozTSDkM1PpMcOnjLI3WOZKjKPvXrflL+Ol7oAT7dmf?=
 =?us-ascii?Q?ekwyDkTyk7CPBXASO35uf6cm98eUpA7UWJzoaX1tUv0sYy2VBv5biVrLwpiy?=
 =?us-ascii?Q?dRzVrXgZVcv2l5vn3f/H7/ZZtluvCD6q2+mmbsDW1WHZSXfsdPWvOzvtPJyM?=
 =?us-ascii?Q?2Bq11E06gKU+onzn3eeHgQDLp0ACMyBkgAGFqOu54owfPwhLTRB5RPxCmQNX?=
 =?us-ascii?Q?IPbmGgwXW0mK5EqhznCGRpu+w0VQMw9B2VM6nP4dIOOWDr+qRaI9yxvS7soz?=
 =?us-ascii?Q?5z2a9BYiPOG+iibL4eu61cSTg6u0pCDjthPUihFHEuelO8sqnREmCcTf7IWl?=
 =?us-ascii?Q?mRAXBfU4LpBESMvLvjfaKgumdiS1ouNTH0GTqMVmzaqmeoYdYsQHJn5OXeH0?=
 =?us-ascii?Q?4WgQkBXtofUW5miBIkpH1fHO4c48+saOYlvKm2TWFoc0HV4pLTv+q3KoTEBe?=
 =?us-ascii?Q?df4TG0u31KFKFajilIoWyujFkU6Mybj9ODVe01SvWwDueI/XvuntducctBP0?=
 =?us-ascii?Q?/LeddsGgNBmbjzL4TuBeAIg0et7XWHZUv7lv+R5j3v2/YwNVnL+bFTf9tFEh?=
 =?us-ascii?Q?elcUSsgE+FWNuqD/yoeC01yND/S0VTHQ29tzZDHWTy92XqX4NO+etPaHCfPU?=
 =?us-ascii?Q?E7xdn7qULgShNUZ5ZvKbN+k8goswK2QhHusLmdG4sU52GVl+D2mqtlQW7llQ?=
 =?us-ascii?Q?EVAWw3RrIX2b4fJwofAt+IDexiCn4Q3gOrF2KSU6UGK0HmMC/rnYDX6wUZ8n?=
 =?us-ascii?Q?2f102kR56MkNJL6oItyfYUa5LAeGCAzNQmbtgNopJ/TDj2D2el2nBnkK+gjm?=
 =?us-ascii?Q?k/aku42wXstpijCkd+Bs0a8xoYb73cSyiTmTlmMvw/CVFbNi+0yT4apT7Adn?=
 =?us-ascii?Q?i3jchcUZ6y6d0VN57w1WxVNOaRv093DkyoXqREUFP5r6C0xS/gZQn4oHWi9R?=
 =?us-ascii?Q?7OOeBX0bDdW0ji621wZPz6hOM39l+ry7zBjhlmEiQe+ODBNg75uNdisqK3Jm?=
 =?us-ascii?Q?Gu/00QwdiYXVOHryBiPW+5Ye6+zlnWBTc8lVq0t3S3qShi3qQ4UBlzGgnL35?=
 =?us-ascii?Q?UvX/Awxht8A81Fsfb3swalF1sXPyM/OCWL3mI+Zt?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c57dee58-e3d8-4dfd-e3a1-08de24b540e1
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2025 02:10:03.0593
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B9m952cA+Efci73PJqIiZoX+8yXWH3lEK4rc6iQ3wsFSBQLQEkDm/9Y/m2FSsU8q
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6267

On 15 Nov 2025, at 20:47, Jiaqi Yan wrote:

> At the end of dissolve_free_hugetlb_folio, when a free HugeTLB
> folio becomes non-HugeTLB, it is released to buddy allocator
> as a high-order folio, e.g. a folio that contains 262144 pages
> if the folio was a 1G HugeTLB hugepage.
>
> This is problematic if the HugeTLB hugepage contained HWPoison
> subpages. In that case, since buddy allocator does not check
> HWPoison for non-zero-order folio, the raw HWPoison page can
> be given out with its buddy page and be re-used by either
> kernel or userspace.
>
> Memory failure recovery (MFR) in kernel does attempt to take
> raw HWPoison page off buddy allocator after
> dissolve_free_hugetlb_folio. However, there is always a time
> window between freed to buddy allocator and taken off from
> buddy allocator.
>
> One obvious way to avoid this problem is to add page sanity
> checks in page allocate or free path. However, it is against
> the past efforts to reduce sanity check overhead [1,2,3].
>
> Introduce hugetlb_free_hwpoison_folio to solve this problem.
> The idea is, in case a HugeTLB folio for sure contains HWPoison
> page(s), first split the non-HugeTLB high-order folio uniformly
> into 0-order folios, then let healthy pages join the buddy
> allocator while reject the HWPoison ones.
>
> [1] https://lore.kernel.org/linux-mm/1460711275-1130-15-git-send-email-=
mgorman@techsingularity.net/
> [2] https://lore.kernel.org/linux-mm/1460711275-1130-16-git-send-email-=
mgorman@techsingularity.net/
> [3] https://lore.kernel.org/all/20230216095131.17336-1-vbabka@suse.cz
>
> Signed-off-by: Jiaqi Yan <jiaqiyan@google.com>
> ---
>  include/linux/hugetlb.h |  4 ++++
>  mm/hugetlb.c            |  8 ++++++--
>  mm/memory-failure.c     | 43 +++++++++++++++++++++++++++++++++++++++++=

>  3 files changed, 53 insertions(+), 2 deletions(-)
>
> diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
> index 8e63e46b8e1f0..e1c334a7db2fe 100644
> --- a/include/linux/hugetlb.h
> +++ b/include/linux/hugetlb.h
> @@ -870,8 +870,12 @@ int dissolve_free_hugetlb_folios(unsigned long sta=
rt_pfn,
>  				    unsigned long end_pfn);
>
>  #ifdef CONFIG_MEMORY_FAILURE
> +extern void hugetlb_free_hwpoison_folio(struct folio *folio);
>  extern void folio_clear_hugetlb_hwpoison(struct folio *folio);
>  #else
> +static inline void hugetlb_free_hwpoison_folio(struct folio *folio)
> +{
> +}
>  static inline void folio_clear_hugetlb_hwpoison(struct folio *folio)
>  {
>  }
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 0455119716ec0..801ca1a14c0f0 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -1596,6 +1596,7 @@ static void __update_and_free_hugetlb_folio(struc=
t hstate *h,
>  						struct folio *folio)
>  {
>  	bool clear_flag =3D folio_test_hugetlb_vmemmap_optimized(folio);
> +	bool has_hwpoison =3D folio_test_hwpoison(folio);
>
>  	if (hstate_is_gigantic(h) && !gigantic_page_runtime_supported())
>  		return;
> @@ -1638,12 +1639,15 @@ static void __update_and_free_hugetlb_folio(str=
uct hstate *h,
>  	 * Move PageHWPoison flag from head page to the raw error pages,
>  	 * which makes any healthy subpages reusable.
>  	 */
> -	if (unlikely(folio_test_hwpoison(folio)))
> +	if (unlikely(has_hwpoison))
>  		folio_clear_hugetlb_hwpoison(folio);
>
>  	folio_ref_unfreeze(folio, 1);
>
> -	hugetlb_free_folio(folio);
> +	if (unlikely(has_hwpoison))
> +		hugetlb_free_hwpoison_folio(folio);
> +	else
> +		hugetlb_free_folio(folio);
>  }
>
>  /*
> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> index 3edebb0cda30b..e6a9deba6292a 100644
> --- a/mm/memory-failure.c
> +++ b/mm/memory-failure.c
> @@ -2002,6 +2002,49 @@ int __get_huge_page_for_hwpoison(unsigned long p=
fn, int flags,
>  	return ret;
>  }
>
> +void hugetlb_free_hwpoison_folio(struct folio *folio)
> +{
> +	struct folio *curr, *next;
> +	struct folio *end_folio =3D folio_next(folio);
> +	int ret;
> +
> +	VM_WARN_ON_FOLIO(folio_ref_count(folio) !=3D 1, folio);
> +
> +	ret =3D uniform_split_unmapped_folio_to_zero_order(folio);

I realize that __split_unmapped_folio() is a wrong name and causes confus=
ion.
It should be __split_frozen_folio(), since when you look at its current
call site, it is called after the folio is frozen. There probably
should be a check in __split_unmapped_folio() to make sure the folio is f=
rozen.

Is it possible to change hugetlb_free_hwpoison_folio() so that it
can be called before folio_ref_unfreeze(folio, 1)? In this way,
__split_unmapped_folio() is called at frozen folios.

You can add a preparation patch to rename __split_unmapped_folio() to
__split_frozen_folio() and add
VM_WARN_ON_ONCE_FOLIO(folio_ref_count(folio) !=3D 0, folio) to the functi=
on.

Thanks.

> +	if (ret) {
> +		/*
> +		 * In case of split failure, none of the pages in folio
> +		 * will be freed to buddy allocator.
> +		 */
> +		pr_err("%#lx: failed to split free %d-order folio with HWPoison page=
(s): %d\n",
> +		       folio_pfn(folio), folio_order(folio), ret);
> +		return;
> +	}
> +
> +	/* Expect 1st folio's refcount=3D=3D1, and other's refcount=3D=3D0. *=
/
> +	for (curr =3D folio; curr !=3D end_folio; curr =3D next) {
> +		next =3D folio_next(curr);
> +
> +		VM_WARN_ON_FOLIO(folio_order(curr), curr);
> +
> +		if (PageHWPoison(&curr->page)) {
> +			if (curr !=3D folio)
> +				folio_ref_inc(curr);
> +
> +			VM_WARN_ON_FOLIO(folio_ref_count(curr) !=3D 1, curr);
> +			pr_warn("%#lx: prevented freeing HWPoison page\n",
> +				folio_pfn(curr));
> +			continue;
> +		}
> +
> +		if (curr =3D=3D folio)
> +			folio_ref_dec(curr);
> +
> +		VM_WARN_ON_FOLIO(folio_ref_count(curr), curr);
> +		free_frozen_pages(&curr->page, folio_order(curr));
> +	}
> +}
> +
>  /*
>   * Taking refcount of hugetlb pages needs extra care about race condit=
ions
>   * with basic operations like hugepage allocation/free/demotion.
> -- =

> 2.52.0.rc1.455.g30608eb744-goog


--
Best Regards,
Yan, Zi

