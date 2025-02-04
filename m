Return-Path: <linux-fsdevel+bounces-40837-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B2E3A27EAF
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Feb 2025 23:51:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EDF1C7A2DBA
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Feb 2025 22:50:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9355121CA03;
	Tue,  4 Feb 2025 22:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="m6ABzS1J"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2049.outbound.protection.outlook.com [40.107.244.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B28B204F94;
	Tue,  4 Feb 2025 22:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738709354; cv=fail; b=FDWBBTIyGlUf3Q18HDYoq1s9+ew6uF0hwR4Jy0H5hcU+9ulZ6uodQMdrgG0DqNvF0OMwEEdI/OrHpDWafKbhc0IJbXW+b7ESRr/l1kxdW3CIv0DxlYlENfGUmS286G/XMrA+K2FbbB6eLVe/yktH3CtnwOPYs6LRjXFiLPKIpus=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738709354; c=relaxed/simple;
	bh=N1GHgXps6zGRIcsBsOVOSMVLe/Tz8JoZA42DKs5deA0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=sAjWv6M8I+ll5I5BFlIj6rFJggjf4GufHzZowOFOFnWfBBr/hrcIaoA/iXX17s8er8IAO6m9hM8KkVcyGqKS/dWanVZP+2FSa6FJ4M0WQxoShN+RS/zvbrONxE2RelFACM2ZLnZb9nZ48mqqnTtV5mVDR6bGYXFwcj0cpnG2Gos=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=m6ABzS1J; arc=fail smtp.client-ip=40.107.244.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XhWReO8s9knTNbGRBm59KiIM3bdE9melqBQ5I2vQV2xdETOFpXmep2FyvMgmdK23rCVmqrZNSeiHn7qylVdOZqIkM7iGIONjKZ6KHN123x33u4fbr30uIqOi2ixJEz6R/lZ8wGgKyTKG9SnzJtb6zILAdkMOsX8uv7xnXFjvnGpYvdozUF8KmyCwY3oXUKWvvKyTJDYnIfpLICYuvb06gqOZgsChU+jRqfdKbAjzSnUagf4x5Kj+eDXgMdrJX32qcRvmgVmhAzCUGzMaIIfu1JT26ncMErkZVREvLcFIJWL7dpWLu9s6uOoC4tNwghjPBeOWTSA7zF6LoTKOIWsEJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XM5yDHM16usVYJCh1yvhe9uRrzl82mHCkAFuroELR0w=;
 b=C5veTR8vZEXTE37xpUudBGdlO0Zn+ItujCIRcvWBCdEi62ruM9fc5EYLjadxbU83+Bv+d6CUlrxoLFlIfySZADVqgAuApZaI42KPyz7pW/DrxItoNaVpkTnxBO/YNpHTFZD1Hv2/hxQzAWxkLXoWgEqI5cukrMk7krvb46bMywO+ykI60wOwKiBhqo1p/coPCvBzMz6LaPzOGhYgRmDHoyXIHUPxzPxR7S+Qv07UGFCu1+bVgSD6cn0bDmGCsyOl8T0PyjT0ND65MDZ+D2QhQL5Z4rIhsGh2Xw1TdCIdlk7UGG22AWr9PGWhCPFuvRwvUoKXBVxhxdiRGbUTFGNo6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XM5yDHM16usVYJCh1yvhe9uRrzl82mHCkAFuroELR0w=;
 b=m6ABzS1JUFLJV34FgaQBoyQyVDvgBwDPbJ8k/HQBkVG4iBNLNq8hyeX8mSGfy1dbriveJBVnE8Q+saaICqUnPoF582d6Lhumtxjoj2zFYh8WYDsD4p9RVMcGrKFe7Zvo1yKaCsOQUaq4WItTm7cv97SYrX+7gTYGiLmxbuR7rWIrC9Ai/dPDFn2L1UCidU0QAWBTux9YDFkZQM0g5aoFxUC7Bp/vhMzxVd2JmCm267durLfTLR5NBEU2bEtngs+MeLyjFTid/xFmD9/3vQSDHYWAKgD9sTvgFhQtbvC6yo/668g63caDZSCaTXcObh/zmiD23TiS4evO9rAk8bPixQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6) by
 IA1PR12MB8537.namprd12.prod.outlook.com (2603:10b6:208:453::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.22; Tue, 4 Feb
 2025 22:49:10 +0000
Received: from DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe]) by DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe%7]) with mapi id 15.20.8398.025; Tue, 4 Feb 2025
 22:49:10 +0000
From: Alistair Popple <apopple@nvidia.com>
To: akpm@linux-foundation.org,
	dan.j.williams@intel.com,
	linux-mm@kvack.org
Cc: Alistair Popple <apopple@nvidia.com>,
	Alison Schofield <alison.schofield@intel.com>,
	lina@asahilina.net,
	zhang.lyra@gmail.com,
	gerald.schaefer@linux.ibm.com,
	vishal.l.verma@intel.com,
	dave.jiang@intel.com,
	logang@deltatee.com,
	bhelgaas@google.com,
	jack@suse.cz,
	jgg@ziepe.ca,
	catalin.marinas@arm.com,
	will@kernel.org,
	mpe@ellerman.id.au,
	npiggin@gmail.com,
	dave.hansen@linux.intel.com,
	ira.weiny@intel.com,
	willy@infradead.org,
	djwong@kernel.org,
	tytso@mit.edu,
	linmiaohe@huawei.com,
	david@redhat.com,
	peterx@redhat.com,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linuxppc-dev@lists.ozlabs.org,
	nvdimm@lists.linux.dev,
	linux-cxl@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	jhubbard@nvidia.com,
	hch@lst.de,
	david@fromorbit.com,
	chenhuacai@kernel.org,
	kernel@xen0n.name,
	loongarch@lists.linux.dev
Subject: [PATCH v7 07/20] fs/dax: Ensure all pages are idle prior to filesystem unmount
Date: Wed,  5 Feb 2025 09:48:04 +1100
Message-ID: <6f23832debd919787c57fc5ef19561a45c034bce.1738709036.git-series.apopple@nvidia.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.472dfc700f28c65ecad7591096a1dc7878ff6172.1738709036.git-series.apopple@nvidia.com>
References: <cover.472dfc700f28c65ecad7591096a1dc7878ff6172.1738709036.git-series.apopple@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SY5P300CA0026.AUSP300.PROD.OUTLOOK.COM
 (2603:10c6:10:1ff::15) To DS0PR12MB7726.namprd12.prod.outlook.com
 (2603:10b6:8:130::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7726:EE_|IA1PR12MB8537:EE_
X-MS-Office365-Filtering-Correlation-Id: 814998c4-00c4-4693-b241-08dd456e2355
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?2oNv5RZda0vYQ4l10Jy89wJyxQHdtZk8GA1v2O50xqsYJfJdsWq7pvo84LsE?=
 =?us-ascii?Q?kU9orD7VIb/O0Jp+k/cfJCIfmzrbLIDPu6ljM7DS8vmuVkR+wSWZUfwrF0Il?=
 =?us-ascii?Q?7jhJArfzIGUf5paw7rbHf78OGGcTo7n95DxqquMOHLgWVJKFzc6GgYMqlQ9O?=
 =?us-ascii?Q?S5Zgp9rCQ7uT6lKdvl7xgjAKZDkLK8pW8RzXVtT9CDAF8TpHVoC6FI5461V3?=
 =?us-ascii?Q?/Hsvq0Jsh4ilPK2H2Kz0K0aFY5s2WaDQP3Ns0O9vWmCWykJhWFtGLVxFU9eM?=
 =?us-ascii?Q?wysoRN5Dqq/L61u6DDwKQMXoeym7qh7ksGvywUaTAfdk3xOATli8RzPIsxLK?=
 =?us-ascii?Q?boD68CWQaAGaWtN7DrqUEfKPUDwIRC96tR6mOmcfMvOQGneWJIMz81/qdlOQ?=
 =?us-ascii?Q?fqquttpRp4vfxn0fpx4AfZgn/r+pF3mEBuEDnsx8ifSF6V2hrZc4pm3nHr9H?=
 =?us-ascii?Q?MW76tmbRfLj/JwaFUhq/roa1VL3FLwAw2a6GF5jdvPG3yiEPLumRrc/u0ChI?=
 =?us-ascii?Q?zxXlALjhC+tdvaiLyF1YyDmml47ZTMyx6jxYgS2yFTAaDu+Fhq/AObyS1OyP?=
 =?us-ascii?Q?4wIwrhpIX3SvDKgde7I6h4NZtEPQzX81sX/bbh2byuHCcWtsPi35COqolQyq?=
 =?us-ascii?Q?ugAnC4AQbYbaCwn/qIKNSxRz6sPdtNPQNlfDXF237XNyHwTcL0IzXdAsaIRW?=
 =?us-ascii?Q?6c+i3dx/lmZ17PK/XG46crn1hp9dRrirPE6BDjtmdsqY668bhjYWxcvqRsGb?=
 =?us-ascii?Q?7QvdKD41Mo+gldDlUxExGDHLBODrX/bNVgBaVCws4zFm8IzeDbF4NeIfMvh5?=
 =?us-ascii?Q?wnqaWNqqrFYd/gS6Ga2ePnnkTGv7f64LG2jPLR7exyy3ji6wEQ6sVQSJSr8L?=
 =?us-ascii?Q?lKY524JRwEk+X/PcA1eD2lEcs1Iz7H7jmV2ImorekbYKZkn7hl9lM2Q1lA3m?=
 =?us-ascii?Q?AybH8rs33WUcf8dafyV6JYl+xsvEkQYkcK9yDf5J1+ycQjtfCfbcuaJkA5rM?=
 =?us-ascii?Q?B0WoL9zUdh9wTmu3LYVtdk+Gnpio1/EYSGjB56gGng2dgzya3lw6QkqRN9rG?=
 =?us-ascii?Q?LhfOAimIH8+mhorXm/1JzI92CLDwEST9dGO7cHSBlKMOBFEK9SaRWri0Inqt?=
 =?us-ascii?Q?l/bPTkVZ8ctL/QFMzi4hUYad8SEcbn77EK9WaIuyxFGiEsv3JOwpZcYZfITV?=
 =?us-ascii?Q?EA9gUlNaxEJI5KHGc7eD08Y1/ukwJbJK1cPyhSyQogWbo55gEAbffhLxd4PY?=
 =?us-ascii?Q?Y8xC6vNwXT2XuGiXDeRJ7JU5+NyZVgRWXW6pm0V7d4hDLwbBCjomt/6SEwKZ?=
 =?us-ascii?Q?S0/kPBfEAy3MOvdUlRoEeS4d9kSaumUDgiEAeMaLdYrGOnoERAt4yOYG+sdD?=
 =?us-ascii?Q?ozzNswDMCWk43nPOXvlkLF0dSNRv?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7726.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?STL0pD0pdRNJn5EgPkBo694vVqpbHmPEI+L2I2O4TSwVPFDsoRD65V+Nnh+B?=
 =?us-ascii?Q?G20/pO4dyDDy6eU5cdkzFgFUjJn5qAkZhxhZDPKqWtMjIYA33MrnQJF3BUcr?=
 =?us-ascii?Q?eQf2eTxwgZtOoviAEgvk+IG4J1g0x8jvew2lT6VaPQj5TEm2fi2X8T5ZA1zt?=
 =?us-ascii?Q?CuMbBDEDKMVyLvz9Fvc7VJkuVj6vAa3jU+ZFCPvfojm4s6DKm0NKPSA85c4X?=
 =?us-ascii?Q?nWMhyY+4RXWANv7lB7Rj5hcp60FtXq/p+ISYH63AuCRCCCG3x86nfJO1+Wex?=
 =?us-ascii?Q?f9SgDyyF2aHkON/4KEUw0kTLGCFl97mzUCTT7XLITIMwlUIWQ4hEfR0c62J0?=
 =?us-ascii?Q?RK5fmrKPa9xVqOQfDvvVpVGbGUkfeqvtVmBZ2uxe5evgDgrNHVy0keegiORj?=
 =?us-ascii?Q?O81knAhRPQN3tmC8g23msWu8T0to8ZGDpUw13j99j3SIPgzd2wvACyiVckLj?=
 =?us-ascii?Q?1Dnv7bUZgOmHJDPrlpo+/eZhsS3qFkl808GP93YOg00HF3uEUQxMTi3AmIEk?=
 =?us-ascii?Q?kTm2W/S7AlzZduhgVUvfCn81nDt/TXJXHuCMnEicWRlXWQBN8H8Uj2DDRo1X?=
 =?us-ascii?Q?0K8wORsA1nu/gPEWNDnL1QWmFvG6J4jA6BAHWtiRzXN7mu4aDrRZDUJQmMcm?=
 =?us-ascii?Q?SxH7QT0t2pxQNMJNLm0Mz2jmLrfl4wVhOFfBqbm5jdTnQAHP9rW8XsaJ5/jS?=
 =?us-ascii?Q?iBZQVBYVCfODvNSqUOuf4dSEh5KQgWNxoiBFVq4eTqMAkY/nq+Yzf+sj0sIR?=
 =?us-ascii?Q?NLfnzWJAUEo2okWTEuHZBS0YEKXGB8SJk0autGyWzLH52JgPsTuzoQv+a7a4?=
 =?us-ascii?Q?XRQGOrq9GhuLUgV7ZuP8gZnbbWRYyFge8Z7Ez/9ochEsT8cFDk1ug/tu9p1Q?=
 =?us-ascii?Q?iNiv9hV1crvjOEL5soxztoNe8b7lEy2MgYE5+IRVwndzHaosB9ID7pib+glz?=
 =?us-ascii?Q?KvdbgFCp/jTwi8FW4S9XpJAKXafq03CvKmPV1MXDjkju6A2NtF81wklGfTOu?=
 =?us-ascii?Q?tjZ0bPf3tOjBK5wmXDf6/zDsupPbbdvK+ySgYHNUo6iEU0gESLgDhI+mWEri?=
 =?us-ascii?Q?i6Q5abHBetH31UFAwodqp8PlBjeKq/sJMIjdg+tXVnUaQ3BRLbQcs8PWPgYK?=
 =?us-ascii?Q?ZyyjvWeaPspd/8FXliLKuTcJ0cSO7BNiUDKiQzBIUPFKaQv0qm7qklj9lcnA?=
 =?us-ascii?Q?DzkDSdHLKUHQA1KwzMPZn43N2tLNCTmzjoY0s32BdBSFkVLdOGfnFsYB6C63?=
 =?us-ascii?Q?gwRhxgoi5ATHnILU8nbMTitBeu3zSFMLH6GQ0pf4vJsNHwlPV/bxRwteWSu/?=
 =?us-ascii?Q?K8Lx0YfjltNRCrorqe5E6UCUNT3LqSn206cWwc/sSYve30RiXpUk56UDuiMZ?=
 =?us-ascii?Q?I39enYtQYYW1wNe2nFuXiaB2WJEY0T0qmggw6aDbVqZui+v50otJ4G5GsvzI?=
 =?us-ascii?Q?waYAzMLAavFfpdtUwMykvQwPYQVhpBF46ITs+3Wx0W44RcjmmTyD+QDBNjlv?=
 =?us-ascii?Q?iv5g1mEGfgDIb6DvFhTPzQwaMNlRp6iT6n0nwqzXx/EQLyvChp9DPJ1zGaXp?=
 =?us-ascii?Q?LSVCiMw9GocURErB0t65q0mgvUphl1n5U5S5naGi?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 814998c4-00c4-4693-b241-08dd456e2355
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7726.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2025 22:49:10.1053
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cnzNA/2RpZT882KOFGSGZqcm3GQkrnv56SGwUl5wbKOYxU6PGiNEAwx7GtkpTDaKQvgt1SaylGOvZiGvVsO5Bg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8537

File systems call dax_break_mapping() prior to reallocating file system
blocks to ensure the page is not undergoing any DMA or other
accesses. Generally this is needed when a file is truncated to ensure that
if a block is reallocated nothing is writing to it. However filesystems
currently don't call this when an FS DAX inode is evicted.

This can cause problems when the file system is unmounted as a page can
continue to be under going DMA or other remote access after unmount. This
means if the file system is remounted any truncate or other operation which
requires the underlying file system block to be freed will not wait for the
remote access to complete. Therefore a busy block may be reallocated to a
new file leading to corruption.

Signed-off-by: Alistair Popple <apopple@nvidia.com>

---

Changes for v7:

 - Don't take locks during inode eviction as suggested by Darrick and
   therefore remove the callback for dax_break_mapping_uninterruptible().
 - Use common definition of dax_page_is_idle().
 - Fixed smatch suggestion in dax_break_mapping_uninterruptible().
 - Rename dax_break_mapping_uninterruptible() to dax_break_layout_final()
   as suggested by Dan.

Changes for v5:

 - Don't wait for pages to be idle in non-DAX mappings
---
 fs/dax.c            | 27 +++++++++++++++++++++++++++
 fs/ext4/inode.c     |  2 ++
 fs/xfs/xfs_super.c  | 12 ++++++++++++
 include/linux/dax.h |  5 +++++
 4 files changed, 46 insertions(+)

diff --git a/fs/dax.c b/fs/dax.c
index 39f1dc0..9c28eb3 100644
--- a/fs/dax.c
+++ b/fs/dax.c
@@ -883,6 +883,13 @@ static int wait_page_idle(struct page *page,
 				TASK_INTERRUPTIBLE, 0, 0, cb(inode));
 }
 
+static void wait_page_idle_uninterruptible(struct page *page,
+					struct inode *inode)
+{
+	___wait_var_event(page, dax_page_is_idle(page),
+			TASK_UNINTERRUPTIBLE, 0, 0, schedule());
+}
+
 /*
  * Unmaps the inode and waits for any DMA to complete prior to deleting the
  * DAX mapping entries for the range.
@@ -918,6 +925,26 @@ int dax_break_layout(struct inode *inode, loff_t start, loff_t end,
 }
 EXPORT_SYMBOL_GPL(dax_break_layout);
 
+void dax_break_layout_final(struct inode *inode)
+{
+	struct page *page;
+
+	if (!dax_mapping(inode->i_mapping))
+		return;
+
+	do {
+		page = dax_layout_busy_page_range(inode->i_mapping, 0,
+						LLONG_MAX);
+		if (!page)
+			break;
+
+		wait_page_idle_uninterruptible(page, inode);
+	} while (true);
+
+	dax_delete_mapping_range(inode->i_mapping, 0, LLONG_MAX);
+}
+EXPORT_SYMBOL_GPL(dax_break_layout_final);
+
 /*
  * Invalidate DAX entry if it is clean.
  */
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 2342bac..3cc8da6 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -181,6 +181,8 @@ void ext4_evict_inode(struct inode *inode)
 
 	trace_ext4_evict_inode(inode);
 
+	dax_break_layout_final(inode);
+
 	if (EXT4_I(inode)->i_flags & EXT4_EA_INODE_FL)
 		ext4_evict_ea_inode(inode);
 	if (inode->i_nlink) {
diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
index d92d7a0..22abe0e 100644
--- a/fs/xfs/xfs_super.c
+++ b/fs/xfs/xfs_super.c
@@ -751,6 +751,17 @@ xfs_fs_drop_inode(
 	return generic_drop_inode(inode);
 }
 
+STATIC void
+xfs_fs_evict_inode(
+	struct inode		*inode)
+{
+	if (IS_DAX(inode))
+		dax_break_layout_final(inode);
+
+	truncate_inode_pages_final(&inode->i_data);
+	clear_inode(inode);
+}
+
 static void
 xfs_mount_free(
 	struct xfs_mount	*mp)
@@ -1215,6 +1226,7 @@ static const struct super_operations xfs_super_operations = {
 	.destroy_inode		= xfs_fs_destroy_inode,
 	.dirty_inode		= xfs_fs_dirty_inode,
 	.drop_inode		= xfs_fs_drop_inode,
+	.evict_inode		= xfs_fs_evict_inode,
 	.put_super		= xfs_fs_put_super,
 	.sync_fs		= xfs_fs_sync_fs,
 	.freeze_fs		= xfs_fs_freeze,
diff --git a/include/linux/dax.h b/include/linux/dax.h
index 2fbb262..2333c30 100644
--- a/include/linux/dax.h
+++ b/include/linux/dax.h
@@ -232,6 +232,10 @@ static inline int __must_check dax_break_layout(struct inode *inode,
 {
 	return 0;
 }
+
+static inline void dax_break_layout_final(struct inode *inode)
+{
+}
 #endif
 
 bool dax_alive(struct dax_device *dax_dev);
@@ -266,6 +270,7 @@ static inline int __must_check dax_break_layout_inode(struct inode *inode,
 {
 	return dax_break_layout(inode, 0, LLONG_MAX, cb);
 }
+void dax_break_layout_final(struct inode *inode);
 int dax_dedupe_file_range_compare(struct inode *src, loff_t srcoff,
 				  struct inode *dest, loff_t destoff,
 				  loff_t len, bool *is_same,
-- 
git-series 0.9.1

