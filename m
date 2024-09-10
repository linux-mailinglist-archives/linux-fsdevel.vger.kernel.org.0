Return-Path: <linux-fsdevel+bounces-28981-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 06E95972824
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Sep 2024 06:19:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7CF581F22248
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Sep 2024 04:19:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73578191F82;
	Tue, 10 Sep 2024 04:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ZPk/crcO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2055.outbound.protection.outlook.com [40.107.236.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ACEC19067C;
	Tue, 10 Sep 2024 04:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725941746; cv=fail; b=P+wkXG0C2vtXTI6fLGn+hgoSGeGNJSoS3TYTclAtheaTswxhEYREVhSNQL7cdMoWi1qjos7B6yXw2XE4zIeulgzMFLFIdTJNfMl34SNsWnItIR21bAP5sziA+BQ11gve79VvzjTyu5IGLeqvq1JL8enQAM0sQk/rktS7kiKsyyU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725941746; c=relaxed/simple;
	bh=8W044OLZm3ALC5/sg3Oqz8bwVK13cS+oWh1yt743ByE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OYn/3QTdIEn9JMDvrBIVZ8m0J8LrZ2uQTV5czvB8cYDSFdzQD7nvFOFCwt4HAL6V+0Gbr3IcFAb8o59HJWR0w0NVXx/RQSDRlrOsaTtxlPdA3VkVaKTfkVvD/l8NvZGIlm3f3CqNOOsitMcBBe/f+fJ38TpC1q6U9ZmLZemtawY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ZPk/crcO; arc=fail smtp.client-ip=40.107.236.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MXI1xaJfqIvkKMabg2YvEFD9cegZN5DLWoR441UhNNXEggfAWCdNCtDWo8gTOcwr44m+CnFKbE2wREg4XUaoR7lwjUKM8KI7NKUjj/7pOwGYTdeYGIxxhyWv5bdH2cpR8VmB+kS/DS/9G+HWOZv64OD3H0afFZRWGpyPRV/DGoVA4cpHIZyUojwwwdorxzshb34W0Gb7DSnNAIRIEdJqWTPcwL/N71V3RiB9GRipWMODrLi8zwZwmlXJfXfLdMUVpA6wqT56aVp2jWko3R+lOKwU1EQIVqQ6Q9HJLAljWG6MYOj3z0E84ErWs3SD/uRQ85VNS+ZT50NTP4Aybdo72g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oV3RuJwb+sRS9SntpWvyzIKrNy8Tuttg1UxdDOww1Ro=;
 b=LWc7Dn0S4HZl5pPJOTpM8oSGiMvpw7toO0C2Pzj1IGwi4uEbTTDezhLZY7e/7flsVepnvugBKhly8HCiHyadh1SbVlw7DnsSlcf3FXTqfjEtOSbdz4SABmsK0O42YKOGb1rkBEz8oL48xzQGCBBm1my3RCz+XqEbEZH3P7NGCgUE866Ifr2Tchl2qnQ7NZZ3U0oqKfxlfgtnLyFR3Lz/vCmCtAA1ljMGe/Jwlw/FvosnnR0k/GMcl1P6GdRxhIBeucA6ZGN7OjZErLpxrnhdM6IjcMH5c/+t/ajyUQqGF1OpiCRPJIYLLVRtnPRa4PROnCRhdzUAO47ZtmdhckjkdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oV3RuJwb+sRS9SntpWvyzIKrNy8Tuttg1UxdDOww1Ro=;
 b=ZPk/crcOCvT2mHOf3/9FCx7Fam/l0kGA4CPjvFozGz48KeLxkrnScEokFEpQFwoU0mCy6SSQqiZ2lVdF8T25SGJ1cie/kywHjq49PDfBlBxLgvMbRlyM5XDPqaAFUaSQbYvxIMOS9aIokksEl3+LAMJrVe/iBgIwaSCiiX1235+rC0IogacgX6U6S2L61w+1SC6vSa2Q4FnvSPdHLoz2WnZ+m9rnXruIvvvNHcBJRGISPFr5m23zdBnq1xAFrXdKHj6tTDuW/VGmLyrbF5lgbD0kSB77AJLvnbccz1c6qtAmtvE9zMoFyV+UkLEdmeTCbJN0MHYEdw/4ttnSSvzQhA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6) by
 IA0PR12MB8088.namprd12.prod.outlook.com (2603:10b6:208:409::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7918.27; Tue, 10 Sep 2024 04:15:41 +0000
Received: from DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe]) by DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe%3]) with mapi id 15.20.7918.024; Tue, 10 Sep 2024
 04:15:41 +0000
From: Alistair Popple <apopple@nvidia.com>
To: dan.j.williams@intel.com,
	linux-mm@kvack.org
Cc: Alistair Popple <apopple@nvidia.com>,
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
	david@fromorbit.com
Subject: [PATCH 09/12] mm: Update vm_normal_page() callers to accept FS DAX pages
Date: Tue, 10 Sep 2024 14:14:34 +1000
Message-ID: <64f1664980bed3da01b771afdfc4056825b61277.1725941415.git-series.apopple@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.9f0e45d52f5cff58807831b6b867084d0b14b61c.1725941415.git-series.apopple@nvidia.com>
References: <cover.9f0e45d52f5cff58807831b6b867084d0b14b61c.1725941415.git-series.apopple@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SY5PR01CA0005.ausprd01.prod.outlook.com
 (2603:10c6:10:1fa::13) To DS0PR12MB7726.namprd12.prod.outlook.com
 (2603:10b6:8:130::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7726:EE_|IA0PR12MB8088:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d96d962-ecac-4a36-9c2f-08dcd14f3bbb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?p0/XSu+j6RC4amQIub1I+NvbR/EvWujIS4R49iplf0dgWgY29I8KiQVttazJ?=
 =?us-ascii?Q?oBkrxoGLPyml53b6bJ1gqCMw0FlE77JVFw5g+qhWlK7s9OG6K9uFI8ZX8DMv?=
 =?us-ascii?Q?j9BeFt4rsj9Xj2VJPpfqVtwSuzHWhee4WPsWnbTePWI65dqs5NyHTcDOMXxV?=
 =?us-ascii?Q?uTLmCUZfVyD+Q9s4n+dRb7ZenPhZe3aB/wuNu91ORvUJPhZ0qocJ2pdBE5LG?=
 =?us-ascii?Q?fmvdSeSim/xN7lRJ3Q3vJ5rfa8S+hdH6LgZ2lEAtgVz+CrrOBRVnMbdz9U01?=
 =?us-ascii?Q?drvYAztD95VSgzbXHvDemyXKY7nYr25dm6SpM+4KEw7BhvRisHrp0ne5aqtR?=
 =?us-ascii?Q?goS4pLAzzT+2Pf6lG12osuhiqyfVijzNUYrOmvbPAD5V8P3cTU2QFjn5pW1Q?=
 =?us-ascii?Q?/rda3eU8+F4MRYTzRVMrIRtFGMbtmz7gS6tyGuYeXa5ViA4nqFgemLkb0FAC?=
 =?us-ascii?Q?LtK3N7nNiLSwG4/jMm0VnfN5jolL/wJ6vB9qTSeb/85zct/QHpEctigmFZLN?=
 =?us-ascii?Q?llzvclZCu01w5ghKGowjgmQIQlV2lAW0iSSBoRdfGlkBlA+jkTirf0s/b/P/?=
 =?us-ascii?Q?pK8SKLdYMUsmyXlcv7z5YT7gT2l/osdBnMQlmNgpgj5YkvaTLtqag9xrtM9e?=
 =?us-ascii?Q?OEgnqK4JV04vo/cpN5yDiNUzirRHm/3ba8h4HcXC580QYclgNDEGKlO6Hcqj?=
 =?us-ascii?Q?FMCmHzcLKoDLCqIfhLZTxQ2FE05W43j5JnflqteswDo9dOT0eZX1j8WLXAed?=
 =?us-ascii?Q?YAPyleQrCp92BCehpoEq9kFKpy7r64c0k56CuhQm2fP8uF+4t+j976aH0sO/?=
 =?us-ascii?Q?UPrUMDXZq+bPqqkqKXzh/OryjL4VfpsAO2c99nRFNRytdtcJ6gZK8iY6uQy0?=
 =?us-ascii?Q?R62NXaviR5RdhCFEsuVtY9TzDYvohbHgG0BzoswvMF6zjwc/VP5/TyuXd/4Q?=
 =?us-ascii?Q?YZffBN2G+oO+9JOdXDwCPNB+oKzM8YGYRrgbM/230dkZMSZ/FA07JkQrheLV?=
 =?us-ascii?Q?OXGiMzwtwBb/uvHV3lRU0fHbBYRm+Z65vMg5oNuRJthLWWOA2XPFaakAbNh/?=
 =?us-ascii?Q?W21J538v/I0S4LuM1mWBhBeGuZI1bIBWwex5WOjGzP4t52Q1qNNdnqCM0e2x?=
 =?us-ascii?Q?y0cewCoqNxR8VOuDwNm7LlIY6uiEqqZ5/0Nh8cOwn0t27SojAdQkRSR3T0kg?=
 =?us-ascii?Q?5vThwHBk9uRnoDj0TrN4DyogtS6UYH4HPLeg4nalq4V1/p9hnjGF76ip3gSa?=
 =?us-ascii?Q?qhPAeICgKIMTLFtMOMJMx7LbzpfmGUrd8riPT7vfa9R0Wj/3ZfPkMKhada/C?=
 =?us-ascii?Q?2lFLb+imdLwoKTha62TGzKxvtDLcU3VyZxznCg/vTlrFfA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7726.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/pHOMGGcH0XJuO5Wsr+OtYTbWqAxzCvfpUql0taa19y8j8xA43gaFKaZf+ji?=
 =?us-ascii?Q?g6m7IA+g89wyglmxqBnQJDWfvrJUnbxJSTCuTm95nlhkTDk5XpntEnPtgpBR?=
 =?us-ascii?Q?AhoJXf9uQXsj6HZ8Jogl5pnI6pvhB0NiBjk5NXSpCu3OgUTEaYlEdVFhkJYt?=
 =?us-ascii?Q?eGmP8E8gL55Le5JhNEzRaJfhMYjgSYEKLFN7h7CCAYcp/AiYUSgtL59Nt9cX?=
 =?us-ascii?Q?246SglUrDpTSIc/aI7rU9gOZ67NeCL3GGW3uQyKFWOk7huxyItY54ggf7/k4?=
 =?us-ascii?Q?mRx+O0h953do6vnWbKjsLAoTAGwNkssJp9STNWyt8Z2wt8n+Q441PfzaruBt?=
 =?us-ascii?Q?tfHuzEvMiSsZPt7Qo0c2Zy2W4let81cKof+p9OJ+7xnnXMlnESgdg5I8Inu7?=
 =?us-ascii?Q?t412PnOyfjp+BchXSoAD2Bgt1RybN+IFBoEl+ia9D68JOSxl8P0/rrXK9kQX?=
 =?us-ascii?Q?k/Bwy813soeC+/MA+D4hkSieowEb+exoq0iWQyQMwplurYOXy1rlsLWX4jvW?=
 =?us-ascii?Q?Ax3jRs31QQr2pNE9YVGoF5ZL298JDJmdr1qG15ODoVQqVPTymc9DIMePtsRr?=
 =?us-ascii?Q?53YuqZXk0CQtJCk7qsD+dK4QSjXSZ88/G10Lzk/2CaJIK87mo5f33PRlpp4b?=
 =?us-ascii?Q?EMFBv2BVYLK51tQ2KNdoeED9PfDC0ZKqTGIQPcTnq9fnsqsyHpPCtO+nsp/W?=
 =?us-ascii?Q?rnhjqP6od1NatHdYjbO7v36YUkWfIovyKVJsakK9blPhcXjBbWgy++W33bCM?=
 =?us-ascii?Q?bSNJzaAA3uWTJe37OASyR9KJLZMopaYZLi2nJwFY3xrklQDKIIEaGgwVCPIW?=
 =?us-ascii?Q?rntPPzJodAHdKOwrX0XMzOBNAIHBi3WxNgu/TdY+McwVE17gCOdzLKyxqP2f?=
 =?us-ascii?Q?574B2kcsvoJC+J1bl5QPVupcNwvAUbNfBuNUt7b3OM2YTrigyFnjaIXOHCRe?=
 =?us-ascii?Q?jfPySagz/9eTdKo1NCu6EoSA3NcKQdMBNZPI4zA60LHxAV9jaNbWAvXRL/wp?=
 =?us-ascii?Q?r1iKv4JF/clcFT3k4tpuCbT3tKBch7d9S8KKzfDIwslM+R6IpB9jnvZVQkc8?=
 =?us-ascii?Q?Cz6A4qJ2Msm5HEpOd3sAwbxq34RNdgxu9P/f3ereyKbuae9tY574IPnawrXB?=
 =?us-ascii?Q?jNpo7szcktxcB8bRqc8A2BmLLlR0zLCDqb+NPQz56HBdV67t9pbIAwM/io99?=
 =?us-ascii?Q?O1EGSpI1WjgrJGQj/VuF/oSJGtK8fbXvHM/I50Hl3oKznkgMRuLveMKHfqV6?=
 =?us-ascii?Q?h+5ufOjfzMRNVx/GGPx8VtKqn1IbtkDWQLO9ZPpRdl4IeiVUDSc/ia7WBej4?=
 =?us-ascii?Q?+nVjXisUirGGZ7ZW9LbcbUAbHdNyM9aG31uFr703dJjBGC684kgdqtoR22K1?=
 =?us-ascii?Q?M7Bd6MMhZdItKa8872K/D4yNmhlGE2EeDdGENxbju4v89F6FI+R2IRQ69L8K?=
 =?us-ascii?Q?xuJfNUnFy55NKB1qnf1odz2cl782kN3JiNYleo3vI3247kWlSsT7QfyhhQjf?=
 =?us-ascii?Q?dZh9IXisJiLfrhptVkMVwG6efpJzqvA98qcZBDGi6DY8+orzhAQyFSRd+esa?=
 =?us-ascii?Q?5qbvBz7IVOYLLF0L6rt6nIM499dTW22cOyceY54b?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d96d962-ecac-4a36-9c2f-08dcd14f3bbb
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7726.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2024 04:15:41.7306
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V3dOcpNl6wWF+ecILF5shF8I1HGH/hLFOmqxI6ecYfW7ol7oG/75AmXfONWBAJ8yFnIrCYz7s1BGRbcYbH/GFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8088

Currently if a PTE points to a FS DAX page vm_normal_page() will
return NULL as these have their own special refcounting scheme. A
future change will allow FS DAX pages to be refcounted the same as any
other normal page.

Therefore vm_normal_page() will start returning FS DAX pages. To avoid
any change in behaviour callers that don't expect FS DAX pages will
need to explicitly check for this. As vm_normal_page() can already
return ZONE_DEVICE pages most callers already include a check for any
ZONE_DEVICE page.

However some callers don't, so add explicit checks where required.

Signed-off-by: Alistair Popple <apopple@nvidia.com>
---
 arch/x86/mm/pat/memtype.c |  4 +++-
 fs/proc/task_mmu.c        | 16 ++++++++++++----
 mm/memcontrol-v1.c        |  2 +-
 3 files changed, 16 insertions(+), 6 deletions(-)

diff --git a/arch/x86/mm/pat/memtype.c b/arch/x86/mm/pat/memtype.c
index 1fa0bf6..eb84593 100644
--- a/arch/x86/mm/pat/memtype.c
+++ b/arch/x86/mm/pat/memtype.c
@@ -951,6 +951,7 @@ static void free_pfn_range(u64 paddr, unsigned long size)
 static int follow_phys(struct vm_area_struct *vma, unsigned long *prot,
 		resource_size_t *phys)
 {
+	struct folio *folio;
 	pte_t *ptep, pte;
 	spinlock_t *ptl;
 
@@ -960,7 +961,8 @@ static int follow_phys(struct vm_area_struct *vma, unsigned long *prot,
 	pte = ptep_get(ptep);
 
 	/* Never return PFNs of anon folios in COW mappings. */
-	if (vm_normal_folio(vma, vma->vm_start, pte)) {
+	folio = vm_normal_folio(vma, vma->vm_start, pte);
+	if (folio || (folio && !folio_is_device_dax(folio))) {
 		pte_unmap_unlock(ptep, ptl);
 		return -EINVAL;
 	}
diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index 5f171ad..456b010 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -816,6 +816,8 @@ static void smaps_pte_entry(pte_t *pte, unsigned long addr,
 
 	if (pte_present(ptent)) {
 		page = vm_normal_page(vma, addr, ptent);
+		if (page && is_device_dax_page(page))
+			page = NULL;
 		young = pte_young(ptent);
 		dirty = pte_dirty(ptent);
 		present = true;
@@ -864,6 +866,8 @@ static void smaps_pmd_entry(pmd_t *pmd, unsigned long addr,
 
 	if (pmd_present(*pmd)) {
 		page = vm_normal_page_pmd(vma, addr, *pmd);
+		if (page && is_device_dax_page(page))
+			page = NULL;
 		present = true;
 	} else if (unlikely(thp_migration_supported() && is_swap_pmd(*pmd))) {
 		swp_entry_t entry = pmd_to_swp_entry(*pmd);
@@ -1385,7 +1389,7 @@ static inline bool pte_is_pinned(struct vm_area_struct *vma, unsigned long addr,
 	if (likely(!test_bit(MMF_HAS_PINNED, &vma->vm_mm->flags)))
 		return false;
 	folio = vm_normal_folio(vma, addr, pte);
-	if (!folio)
+	if (!folio || folio_is_device_dax(folio))
 		return false;
 	return folio_maybe_dma_pinned(folio);
 }
@@ -1710,6 +1714,8 @@ static pagemap_entry_t pte_to_pagemap_entry(struct pagemapread *pm,
 			frame = pte_pfn(pte);
 		flags |= PM_PRESENT;
 		page = vm_normal_page(vma, addr, pte);
+		if (page && is_device_dax_page(page))
+			page = NULL;
 		if (pte_soft_dirty(pte))
 			flags |= PM_SOFT_DIRTY;
 		if (pte_uffd_wp(pte))
@@ -2096,7 +2102,8 @@ static unsigned long pagemap_page_category(struct pagemap_scan_private *p,
 
 		if (p->masks_of_interest & PAGE_IS_FILE) {
 			page = vm_normal_page(vma, addr, pte);
-			if (page && !PageAnon(page))
+			if (page && !PageAnon(page) &&
+			    !is_device_dax_page(page))
 				categories |= PAGE_IS_FILE;
 		}
 
@@ -2158,7 +2165,8 @@ static unsigned long pagemap_thp_category(struct pagemap_scan_private *p,
 
 		if (p->masks_of_interest & PAGE_IS_FILE) {
 			page = vm_normal_page_pmd(vma, addr, pmd);
-			if (page && !PageAnon(page))
+			if (page && !PageAnon(page) &&
+			    !is_device_dax_page(page))
 				categories |= PAGE_IS_FILE;
 		}
 
@@ -2919,7 +2927,7 @@ static struct page *can_gather_numa_stats_pmd(pmd_t pmd,
 		return NULL;
 
 	page = vm_normal_page_pmd(vma, addr, pmd);
-	if (!page)
+	if (!page || is_device_dax_page(page))
 		return NULL;
 
 	if (PageReserved(page))
diff --git a/mm/memcontrol-v1.c b/mm/memcontrol-v1.c
index b37c0d8..e16053c 100644
--- a/mm/memcontrol-v1.c
+++ b/mm/memcontrol-v1.c
@@ -667,7 +667,7 @@ static struct page *mc_handle_present_pte(struct vm_area_struct *vma,
 {
 	struct page *page = vm_normal_page(vma, addr, ptent);
 
-	if (!page)
+	if (!page || is_device_dax_page(page))
 		return NULL;
 	if (PageAnon(page)) {
 		if (!(mc.flags & MOVE_ANON))
-- 
git-series 0.9.1

