Return-Path: <linux-fsdevel+bounces-52173-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CFC98AE00BF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Jun 2025 10:59:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C3123BAB75
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Jun 2025 08:58:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05DD8278754;
	Thu, 19 Jun 2025 08:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="BN9vD1A2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2067.outbound.protection.outlook.com [40.107.101.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C305D26E705;
	Thu, 19 Jun 2025 08:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750323514; cv=fail; b=JCh+WKQ1G5C46jcyMu0u6WtqzVsaNaAf70XU0HEN77QJ+fUhm2LU4GpHks9AKm2gNegp5ORgsnnZnBYAoPad30Rs2EiT3EPGQDz324OpjAzyEPczspyw3fDr1dOvTBF4sPF1GbEbm0T7vLP+sN3L7vu7k5iKOx1e3f+mBy4tSTg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750323514; c=relaxed/simple;
	bh=Um3OmBeNV3VwvI/PuqiRWNgteifR5shseFa6/osLO3o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CjltCbNA3DobNcpWgGeADeHpWTAaTp3ErAqFfFqrm0Ws5KpJnMTzitmuG7OOV6lN2LQBewWU4mUn2mpzEF+jG/Q8VMh8JsDo5a8r2/L1naF5XfTJAjRGrvJiLTsJ6crYY2NrB8L242lcvWNu6JVNMnHls0BjBM6HGhozYLvcFIs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=BN9vD1A2; arc=fail smtp.client-ip=40.107.101.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MVtxaRIauSc2c5S92fuSMLk+65A0fnALguRQ6/tmbjq3+j4X6Ust6rIUTTHzzpxQvgwlZMZnrjGSt9cBiq+lhY/DvSZkjMX0MXEAstDdZ259Ha50FPEX87t+ms1NXT6zNz8IXXQDvFJAbJJn5mERrJhQMDmhLax9OYpnuHbBjGYXHbyrzaoz7kIjEgxxTAwaU6vH6FEulWK8RI++sIK4fF82tYMayDeBmMLrpjIlKKLiEcChmZvzTTEvQCdFhFCu8+nCgkyZ84vRADVPLfDYJlxzOu93Kgg8Jkmy4cWOilRMfr1VaMySUVp6vv8VKg9sjklpvpZP2poyWY0tePrbhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zdwyebds3i61Jll53Y1nG5j45HHyTNUhIvLWZJfQprU=;
 b=yQjnrv6Hq/g4C5M1HMfB66/lsYROVfnCFCCBArmd8OCxgUy6uJphfpsqfQxR7j2Fo+xHJCNHPTtVQ3GOYqPuAGrOU2XD3O8boBO8nc0ySb8/OPHxf4H8am1vdPookmzhybBU/tRX8K5o0Zi6a2Ef/N7NEIqnze9jlO9nOKrV+gGq12YwhdJ4t0jV7PTw1khA7COtTI7+gj90nm428NWEtofCuJXCfs7wKzzJ0EXEGOYzINi+7bDPFT4Wv350N+Jd43azBiW35ckulubC0DymNUCqvQQfM9FM0j7+xJyC0Ig+aSTlqz6XbQpv1AX9mW1dxYlMRyf0hT/NhOJZgckBRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zdwyebds3i61Jll53Y1nG5j45HHyTNUhIvLWZJfQprU=;
 b=BN9vD1A2kzRj7893I1Kld17aTa8tBB8FzuE1EVdDXqjswUB97a59/02nwezQnWfeMQsmAe5u2s7mhdoCwCZre/88EmUIL67ykfrPzbJ/HEOSCfUcD9NpRMNSSDYd6pA+2mLQYxxhTaDSRYHnE/yrYT2R91Ytd2Iio1zkMuLvYX0oDeMeHoKFaWP0jZJ7QFT0SzZDRkooZwseHbjCZaMbTnfc37SlfkPAksit8+AjQUbtE5cUDtdSAAjS7xTLyOVfTtNKizlWbLwe4xFaF/TRIL/l1USTJE5u987TxvRpJi3K1UBYBOGRl+QRsdJSNyTLkwHzTWhIiX+76Br0u29XXw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY8PR12MB7705.namprd12.prod.outlook.com (2603:10b6:930:84::9)
 by SN7PR12MB7956.namprd12.prod.outlook.com (2603:10b6:806:328::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.25; Thu, 19 Jun
 2025 08:58:29 +0000
Received: from CY8PR12MB7705.namprd12.prod.outlook.com
 ([fe80::4b06:5351:3db4:95f6]) by CY8PR12MB7705.namprd12.prod.outlook.com
 ([fe80::4b06:5351:3db4:95f6%5]) with mapi id 15.20.8835.026; Thu, 19 Jun 2025
 08:58:29 +0000
From: Alistair Popple <apopple@nvidia.com>
To: akpm@linux-foundation.org
Cc: linux-mm@kvack.org,
	Alistair Popple <apopple@nvidia.com>,
	gerald.schaefer@linux.ibm.com,
	dan.j.williams@intel.com,
	jgg@ziepe.ca,
	willy@infradead.org,
	david@redhat.com,
	linux-kernel@vger.kernel.org,
	nvdimm@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	jhubbard@nvidia.com,
	hch@lst.de,
	zhang.lyra@gmail.com,
	debug@rivosinc.com,
	bjorn@kernel.org,
	balbirs@nvidia.com,
	lorenzo.stoakes@oracle.com,
	linux-arm-kernel@lists.infradead.org,
	loongarch@lists.linux.dev,
	linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org,
	linux-cxl@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	John@Groves.net,
	m.szyprowski@samsung.com
Subject: [PATCH v3 02/14] mm: Filter zone device pages returned from folio_walk_start()
Date: Thu, 19 Jun 2025 18:57:54 +1000
Message-ID: <4ecb7b357fc5b435588024770b88bbb695c30090.1750323463.git-series.apopple@nvidia.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <cover.176965585864cb8d2cf41464b44dcc0471e643a0.1750323463.git-series.apopple@nvidia.com>
References: <cover.176965585864cb8d2cf41464b44dcc0471e643a0.1750323463.git-series.apopple@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SY5P282CA0080.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:10:201::12) To CY8PR12MB7705.namprd12.prod.outlook.com
 (2603:10b6:930:84::9)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR12MB7705:EE_|SN7PR12MB7956:EE_
X-MS-Office365-Filtering-Correlation-Id: 68c06149-b59d-4ccd-e551-08ddaf0f759c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3RpSAHyTokIMUyuq5tNIpGVdjDPC7mHdFvhR7SOtYTpn9abWm9p7jdE0Rctl?=
 =?us-ascii?Q?VZp/f8Irt5ccVOGJhP13tIJwpoZRI/luQKR8sQ1eY/GJK/nOKGackf9Fp0jc?=
 =?us-ascii?Q?wuVlEg8qWMN91ayuwVsuOJ3kOWUEd1ByIYrD78un+NHs1/410Yb8FfLUttW1?=
 =?us-ascii?Q?NdOhG9IEUTUVomGfYWqD5MCC/j+KD490/u4pRzmdudMLimp40Fws3DClTVOg?=
 =?us-ascii?Q?VLfy4++pzwZDpqLfCOZl54+X3z63/cVIQXeQvfCzm6z/Ds5zbwHQKG1y78xN?=
 =?us-ascii?Q?beIAww6svJXcWPC1v/kmAnC9ki6yHptRM09H+v7kQE7UnzLrcCJAlWntSEGn?=
 =?us-ascii?Q?RPOk6stY5yZizyqVniMZtDsoe4R02Oo1fHNzq2Z8UDDwlWeamq2YbhvzYwF9?=
 =?us-ascii?Q?FYzB0ReAbev7NnexE+uOrQZMrEJp3f/NW0dcZe2CG72cfYQS/dDlANiJcz/C?=
 =?us-ascii?Q?+m1LxMVtJl8zTfvIeIRYvppSkc9hSuipcuJEthU82BsqvaFhIBP/mBa0BHMU?=
 =?us-ascii?Q?JSyR5jv/ghFi7/77ffTelcuzAlAqvWPNhMcQb8AmFC2k7BXbzBFoR+DMF9Zi?=
 =?us-ascii?Q?txFOIZFN1QDWzC95Yg8A3HNnUJEeNpK8M7RkzUyEgXzKVK5vSkIpXsqnrX6z?=
 =?us-ascii?Q?zAVy7NKo479HNFJutFeHG2+/m6ROy8PCb+eginejCX0qHFZXMGzrZ9Z8mqCi?=
 =?us-ascii?Q?JK7WzXq/IWIeAiwsKOm9PfK82+f26r4Uv20wodeEOA4VjBBgWrE/ZOUFrJr4?=
 =?us-ascii?Q?R8E7z1no0J8hZ/0JVNgJmxPRV0Xh46Ubrvw3jWmzeyNbivHP0FlBhrPXGH/z?=
 =?us-ascii?Q?72pMCmKq6x0FqKR/fAvpuDE1FAZ+cH7jw9g4PJBpcNfNlRcIblJ0+yvICl7j?=
 =?us-ascii?Q?P01x+JiAqy6j1KX+KBb11HaHDJDlSZmuJig5AyW4uRMaKWiNpUao+bKnu/Nv?=
 =?us-ascii?Q?y3fT1pyc1F6swLSw4FvfdBfd3uLT5XS/tIqojxrfNWJ10PVTzFd2O4Y+2Jct?=
 =?us-ascii?Q?I3gIUztumBICSI8Jt59LiaNFWrYW7L1/TD/b6PRFookuAWI/OLsCINwI/hQ4?=
 =?us-ascii?Q?mZdRnuEdhK4FqZ7KUoFc3fFSwbiWUYLMihp9vEihy9WRxAXyLt+lvuBVFXGc?=
 =?us-ascii?Q?8djN44xIwaRwrtGTAkMLcfNOwmndB82PYXLxxvwSs1OpsZ9taYWppUlEHlc3?=
 =?us-ascii?Q?ELRxzhehjzkwJggpo5F7zqGq5X0RD7D0sr1rqgyA4AoKFf4x2MmV2NszPl+k?=
 =?us-ascii?Q?eblhSQ0Q07D2QZL8LCgy2D3511cuR2dgslNfuAMKs4XzuQVylYnHMIvkt0m6?=
 =?us-ascii?Q?ckUwEfxMoTqBhircJUH190a5bHQubQKthXa8doTN3SdZU/EZpCH/gxeAOAxT?=
 =?us-ascii?Q?kNK3PZx9Nmhvhn1DDVAZ17M324HUbiSur/PpY+lWXKH6Z1ep0LdfltFIdNta?=
 =?us-ascii?Q?8GM3obdEmLo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR12MB7705.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zUQIlVxsjFWMujUCa2xlwUpAUY2V/Yf6/f77vICGLiykpZwwzOw6qcnVQz1z?=
 =?us-ascii?Q?vnT713OxmNqOX9t0b4sZ1TSXAbF5n/nUr52Cmo8R9LoJb1L6RA3wjJR8kb9D?=
 =?us-ascii?Q?6PX/fV4cNINAmVsaRGiI+HWQaDgmFvnrBHzTWi/5TkeZbp5fLa2FsSYhkyNV?=
 =?us-ascii?Q?FujQLll8eG1Ocp5hTUcSoRrhMlmStZm0uDyjpq5l9A+5X8wxcjVvhLd342QX?=
 =?us-ascii?Q?uCsk1Durz9TKV+VD8+2YsBhC4JqxfzrcUApISUp1baqUlZM/z36W0Cgwwu9E?=
 =?us-ascii?Q?CFbmvUyXWc4CedCnMfLv0eqnHO+v+WoQSNItFaoFU/SrOov0t0uA20XEPxtc?=
 =?us-ascii?Q?1VzG+e42rx0VYtOp7Ec0PFgaOa/frQPTWnny8gSHo8KvWBU1V+eT0F6Uucob?=
 =?us-ascii?Q?U43Kfd/xbL8Y/nJPE2HsGv34UuxaplSpDpVRGpc9I/d5qj2lVhHXHDDGI+Gq?=
 =?us-ascii?Q?yPvBsbE4JG6eK2wNsjesrNyUwWfOJirDbh5gQonEmfsfuIUeSBQ0pvi22f44?=
 =?us-ascii?Q?8b3l4csRa0A6SMwC8dHBz1bE93PWQ+45sc/ihOJp6tzlcvUrZaYkBrACGFTN?=
 =?us-ascii?Q?HdOsjiDZnLMnc2cRRpveqx/hYEM3sC7o8hMyiE8EiJ07tC50vJkahtBjYbfA?=
 =?us-ascii?Q?l0FOMya7rbSiHE/O+7JBFbhI1h9j/FlQE7t3fxiu2788UAjyzvWWD0+b4jeI?=
 =?us-ascii?Q?zQAqe2zEs4kgHZPS0EeZG6tfUeNutYM4FonTQekEfGl+RPQilsT3VSCvu8Fu?=
 =?us-ascii?Q?OHdNoiTF/DJyfnkbSQ/kCcid3fpjbaaXTCYsK56BitOemOOWQe1Owo/kB6F6?=
 =?us-ascii?Q?/B/hHL0NyAwM8V8OEvHkkhGwfc1VU/nGjO7HG2Hpy3mlnD/dQspx32zMj4F1?=
 =?us-ascii?Q?rtxzf1zZYOJzPIFJuB/nVaIpDBYn8tu+Zv4a7ypFuRiQyy0O3rmkbFahpBbk?=
 =?us-ascii?Q?CHgUCl79n7EuqyF5MgOt5UBJF+b33K3In+xXa7AQDnE76dZWcqQNKfVjrK0W?=
 =?us-ascii?Q?Rk7x5jyZuP36zIntaozCTwK+RFbnnDrv+JwDc8JvGGMgpzrW+Y2G+RVix0Wk?=
 =?us-ascii?Q?oNwePw1wq6OnGMQL0mrzmGMecl6dQ34HnCu5fZIFQQz+EL2JlxMNptduZRYT?=
 =?us-ascii?Q?QDx/B/Ym6kNicZJQkOg4FO1N0LD0iQ69P6vqCXm96nLznM2TnoNPznzypNdh?=
 =?us-ascii?Q?AwcHikqMI++Mrc3iTH/I8rD4RH0SKMTNI2ELfzTI/O1KQX+ja0K/Mk84JDwK?=
 =?us-ascii?Q?7B1UJtI6jC8n+53Ew6XoqC5PWj8hQtIiopi5/QovUXJY0qWoNvTp8AE8ZcY4?=
 =?us-ascii?Q?AYCo0Aq4ADlT0dk3xLucL8TjuexVxUW9aCfONUJ6+lbJh5fx237YlqtmT73f?=
 =?us-ascii?Q?H38nmVIvLxvA8kEXvzuJFPjljquOIhxDeX/9N63M2QQqwAmXWEAl+gbcfnZP?=
 =?us-ascii?Q?nUiVCg8lcvCD+Z6as/GSbK9GO41pXeAyZ5rNTIKSkM4wACGr5zOcZVrGJfzq?=
 =?us-ascii?Q?jDDBHUY7FEZ7TvElbRC90KJqS/h1WWveqy6oK6pV1QRI5dyT4996KrZ4Ybbo?=
 =?us-ascii?Q?i5p1mu1bHQxQbuxrCbAjk7xcOGl5Q3ZIdwxPL6Mp?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68c06149-b59d-4ccd-e551-08ddaf0f759c
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7705.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2025 08:58:29.2120
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k83aCR2DDVwVKNVzJQXaBaD4XLQrHLOswPc2qKh1E6AxaLZ8sGkeWCLw2sJdnn6/BQWHwq8zG3RstlTxoMZ4ig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7956

Previously dax pages were skipped by the pagewalk code as pud_special() or
vm_normal_page{_pmd}() would be false for DAX pages. Now that dax pages are
refcounted normally that is no longer the case, so the pagewalk code will
start returning them.

Most callers already explicitly filter for DAX or zone device pages so
don't need updating. However some don't, so add checks to those callers.

Signed-off-by: Alistair Popple <apopple@nvidia.com>

---

Changes since v2:

 - Drop filtering in s390 secure fault handling as suggested by David

Changes since v1:

 - Dropped "mm/pagewalk: Skip dax pages in pagewalk" and replaced it
   with this new patch for v2

 - As suggested by David and Jason we can filter the folios in the
   callers instead of doing it in folio_start_walk(). Most callers
   already do this (see below).

I audited all callers of folio_walk_start() and found the following:

mm/ksm.c:

break_ksm() - doesn't need to filter zone_device pages because the can
never be KSM pages.

get_mergeable_page() - already filters out zone_device pages.
scan_get_next_rmap_iterm() - already filters out zone_device_pages.

mm/huge_memory.c:

split_huge_pages_pid() - already checks for DAX with
vma_not_suitable_for_thp_split()

mm/rmap.c:

make_device_exclusive() - only works on anonymous pages, although
there'd be no issue with finding a DAX page even if support was extended
to file-backed pages.

mm/migrate.c:

add_folio_for_migration() - already checks the vma with vma_migratable()
do_pages_stat_array() - explicitly checks for zone_device folios

kernel/event/uprobes.c:

uprobe_write_opcode() - only works on anonymous pages, not sure if
zone_device could ever work so add an explicit check

arch/s390/mm/fault.c:

do_secure_storage_access() - not sure so be conservative and add a check

arch/s390/kernel/uv.c:

make_hva_secure() - not sure so be conservative and add a check
---
 kernel/events/uprobes.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index 8a601df..f774367 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -539,7 +539,7 @@ int uprobe_write_opcode(struct arch_uprobe *auprobe, struct vm_area_struct *vma,
 	}
 
 	ret = 0;
-	if (unlikely(!folio_test_anon(folio))) {
+	if (unlikely(!folio_test_anon(folio) || folio_is_zone_device(folio))) {
 		VM_WARN_ON_ONCE(is_register);
 		folio_put(folio);
 		goto out;
-- 
git-series 0.9.1

