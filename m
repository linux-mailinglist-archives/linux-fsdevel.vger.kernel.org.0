Return-Path: <linux-fsdevel+bounces-42036-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0828DA3B098
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Feb 2025 06:06:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 841E17A5BEA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Feb 2025 05:05:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFD8A1BD9F2;
	Wed, 19 Feb 2025 05:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="HCZYV9fG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2046.outbound.protection.outlook.com [40.107.236.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82E8D1B21BA;
	Wed, 19 Feb 2025 05:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739941538; cv=fail; b=Akti91oXUoMTb5CRJO+mfv0iVvwSsw6tiVvB/ITMQzdGUJcHrF1H/aNexxEnGhK6K4frvbyCsq9BuPpRD65hqxXGIob/QO4yQ6WLNpFbM+Gh5jjdEVxHPPpzyRS2iXUHyU5v0ARv3fIVUv08Ff6sOiieYshmKpeyuy/u39lOwy8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739941538; c=relaxed/simple;
	bh=3v/620T4q5VMX3NjX0TDQE451+eZEd9kWYcrsMwInlE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TlKRTo+TJtyba4ThnNQeqlJKBu8DPaL6UriLM6gzeAiDQ411j8hEQLgRq9FW0QOdIGLmUjNBIIR/C73Dljv7nZrmKDtda4KgqdhJD7XRF6J9Wu+8pQQW3F5BCXJ+YylmApX9cv+TGm4OmjTrEPnQWb7l2U2wmlRrsOhiQSYNxg8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=HCZYV9fG; arc=fail smtp.client-ip=40.107.236.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YD+r+gRnFh4sRDzZvCJPMWX0MI/gcJb7xueu540n4t0/E/FqTd6otpyODAxCBCpDtZPlz2arRWgABm0txEHN68wdsyTl+RqnzWqU5ti36cENvMsZgxDKBkzK4aYoKqmGbkDZZXX2XXHo8u+i7+Ta6xM1+zFOi9Edc/xo9f3xYA+63sSNkFs8RWB5gBVzx6/3QdECREB0dg1mhHd4TM2vv64efkkOJ4Sugpa7C/tKASEuu7L1p80vFy9kmUV6sw79HKBuoIrZX+AB1DT+MIKJpiewiiYq7WlwU3nSqL/bIJaY0QGgXpaXYTWJEkeZoGB7uu9OEKatw5lpZZLTupud2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PqW5wbkwqvV5B3nuu4dEDF+ITb6K9Bba+lcHfcAQKM8=;
 b=flVtR7Sc0jrJUt95UUxCxrB3g4AcZu94TIKyltDzw28l3gC6L2hv0wOc/XMk6VltuNFLPzevSfiAeE+fNREX0LrBEsdlqBQKiMv+CXUMqi5oelsS29ULyaitJ95wbNM2hWupeOYSlOT+ewspKt8wp055dzrtE2QyK5Qp4Hv5rLSfOeu/2LYKIKauaaSTUJ1DbxyFae4ZOjwHy0aAD5H4ecVS2ijeixk18v1byY7a78ZDyp+ADw+RbTJMalHEjBFMsVg5AZZN2+/rSE8B9BQefSfzc59FHRdkukLatKUvVWn2ehZGdiFXrb7O1dvMVKX1+Vb/TknLLCX9HGTxlE51pQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PqW5wbkwqvV5B3nuu4dEDF+ITb6K9Bba+lcHfcAQKM8=;
 b=HCZYV9fGXr5fXY2/EOwE0VfG/zat4Fg0Bm+65aMl0SaOB5NBCKl4/qX3dPXNGYOo4VBNJ+SYDUTufEESYIIL4YpLE5NgVQcG+MQJP/s4YpAhNdmv9oN/GR+hThSrJQVDgcjIAowuOZJAfpdrPqXvygGoeIX5nk4NPICCOzyP5071i+Kvc4kKFwd4e3HH7uKIQz8/DY/ATV/MzkKBgf8dK4qXyajUj8P+Hp3+EiomLY3zhwl9NV7P41I5u1hP8pHYHH2062I/CZt/HhIORylG0IlATACqv2h+VxWyVlV3EaunSlviAQ94t0x+5kwfaPM2a/snSZLix/jyAm88akfe6g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6) by
 SJ2PR12MB8875.namprd12.prod.outlook.com (2603:10b6:a03:543::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.14; Wed, 19 Feb
 2025 05:05:34 +0000
Received: from DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe]) by DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe%7]) with mapi id 15.20.8445.017; Wed, 19 Feb 2025
 05:05:34 +0000
From: Alistair Popple <apopple@nvidia.com>
To: akpm@linux-foundation.org,
	linux-mm@kvack.org
Cc: Alistair Popple <apopple@nvidia.com>,
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
	balbirs@nvidia.com
Subject: [PATCH RFC v2 04/12] mm: Convert vmf_insert_mixed() from using pte_devmap to pte_special
Date: Wed, 19 Feb 2025 16:04:48 +1100
Message-ID: <a642ce4101077e4493153f482639d1f34382d364.1739941374.git-series.apopple@nvidia.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.95ff0627bc727f2bae44bea4c00ad7a83fbbcfac.1739941374.git-series.apopple@nvidia.com>
References: <cover.95ff0627bc727f2bae44bea4c00ad7a83fbbcfac.1739941374.git-series.apopple@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SYBPR01CA0104.ausprd01.prod.outlook.com
 (2603:10c6:10:1::20) To DS0PR12MB7726.namprd12.prod.outlook.com
 (2603:10b6:8:130::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7726:EE_|SJ2PR12MB8875:EE_
X-MS-Office365-Filtering-Correlation-Id: 099570c7-cd6e-4c53-4472-08dd50a30a38
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?7GcTt6DlpUgff3/sl9TDk5PmNJHJNMMGlLdd5iMrK3dhXGwTXetn+0uvf6BV?=
 =?us-ascii?Q?DqAIYrLo8sXniWBwCpHBjmjCd+fc4cXhph1n68TSjPHCZ5im7icPOrdkCTvW?=
 =?us-ascii?Q?1UEUX+j8Cx703z+iXmuV3YdrCmwhR/2SmD61FWPjoI+72ITg0H6SndatTOt6?=
 =?us-ascii?Q?I+9Ap2K8+7DAL0YHQ4VtN+2Gh2oN3HU3Fsnu+ipxNCGbhZnKZUqXRRUJSIj4?=
 =?us-ascii?Q?rUp0TOa+x3S8zx5ccsiqRGXcQwuVdlXqyFYbJ/G/NZRIpzrNXM1yRiVcZbms?=
 =?us-ascii?Q?Fj+WQj4v+wywz64BelpJKTeeIf/bD+qE0LsRW+xQ+BEXsefEh/PJ7bQsQEPb?=
 =?us-ascii?Q?KuyyM8842hSzz/dmHaZDbduAMeIqL3qu/j9oCqsY2qmfs7iOMMD6qkRS6sTj?=
 =?us-ascii?Q?lVmMpgRHL1i0jqnNHO0oPMvAQpLnSt98igq8AZkUlATa+0TCJlk0XJnKLjuW?=
 =?us-ascii?Q?oWkJVolgvkNhT41PVbQa2/uuNt7CPzr96t+xzrVNS55+o6G7C2Q+4YC2eVOc?=
 =?us-ascii?Q?A8WULJ7bjlB7VNUbQlvvpuOurXhNOn4/XV/FaAEPPVl2RD3P8tTtvTOxKTAH?=
 =?us-ascii?Q?dTvQNFikKG7xBKizPFQibF+Zm6mkhxX8om8XrgLwcUFCunnaurh/crBKy3Xy?=
 =?us-ascii?Q?Z3KKRg20Mi+QxEpBnI50foleKk/e2oZf+GWFNq+WEApEVNf+GY39x5V+mOxz?=
 =?us-ascii?Q?GsrxfMazOe6RvfOz5bBIMD2Aj0sy/Zla6nS+G4UXEZ2g9CFM8OGAkPei4pDJ?=
 =?us-ascii?Q?kXw9IaUtyePuch0xTWPDe5gFwHGIcyzwSegGYwavK1SNN52MdtsnXGJLV+6v?=
 =?us-ascii?Q?pkwnlxaeoGNxtOdvgaGPIenrXWfqpBUFQQI5h6Da8UJh8nh4WxDy2b+9Qht0?=
 =?us-ascii?Q?Ez98o5ospOwEZ3Y8zlNbBbNi8hHuZNIRA8wHYxhHu5eDktjgWSCQITypfnE/?=
 =?us-ascii?Q?krDYPinhVV9fpA9jTBn7lV1bI20GhwYg+aBf6o8TIto94GS5LIIXPdlr0R26?=
 =?us-ascii?Q?FG6p2IC0mPwLcFPzTAXser2VTm3wW3aX5MimqVTOBOqeqPZmAexguOg8VCzP?=
 =?us-ascii?Q?2OQ8/pqHoZMK79Jhf+7v+Gak4TqSGE0UDL6lS14lekzUoScrH9Gn9hfoVgCS?=
 =?us-ascii?Q?IYLWlTSddzJCacuv6rhp9xEpNz21JYCInmY4EEIs85LLCNC6dEQLiO19DbQo?=
 =?us-ascii?Q?TRK81ys9YtZ1+CE9aS/5Ihb+mIxrlcEp9tdQLgs8jcZE1+Q4am7LR+rNe7VL?=
 =?us-ascii?Q?yIR+i+2YPmTa1j4KZtcSMY2BIrpRknboq0dU1h/sa5tX2bXn8tOP9IBKUCcX?=
 =?us-ascii?Q?sMBvMEeefuOrUzH1GoFuW5XhLBux3rWKt6sXGjTmy0Ifdau/uSC+8+jpF9qI?=
 =?us-ascii?Q?pqrHwg+PDIGMLM/8x3fSrUUNHlJS?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7726.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?F71iY8xr7F7d6DEwiEa9hLQzZ7uCLmXUXS+Ubf+wsDwpFlkAvpnXA7M4HoDT?=
 =?us-ascii?Q?4qddBXB4+SJX45/JbOHsG17er+evGrwoa5QPOn1xG+fbGrov6fvKH04RZUnb?=
 =?us-ascii?Q?rT9us3OPrwfM3B0dum9SPNHkVTc45q9FmKcAjQQ9MJFV5Ql4EUVLgC5m3BWG?=
 =?us-ascii?Q?WLwSI1F4LJ2EHanudX31WpGNowiGmajIjAVF8zlXDhKE3ady/HTGMy31o2cC?=
 =?us-ascii?Q?+R/hDTPnl1Pq4+BmYifvxgTdNKClop+avYEklrlgKT+Cbk/2pXafV5uXHb1s?=
 =?us-ascii?Q?GXaL6Cpm8gygPVDf8o7Gv88/jh6p2bPRfCTjWoAOK/w2kakOhZDiL6iCjeYE?=
 =?us-ascii?Q?bjJxi81nNmT68fU+XDyU+EQLY88HWWIasMkqjM68zoRi0NtoA6Pd+4ooTh7T?=
 =?us-ascii?Q?siTOou1ijORPOPGohvz5qmoSQ3PtN2Izognw4FHBNNZ6q6dgunVH4KsLHSGE?=
 =?us-ascii?Q?9Y59kluy8lJO8cPQ7kG2sRKwuqXp7sy4ioxQcKdOVYeMkoMh4FBj/cxcOgAj?=
 =?us-ascii?Q?uK0jadRIDQon4nUsvDX2XNgAjKa1pk3Dd+2+d60cDtfwXjR9sarnekmv5vaI?=
 =?us-ascii?Q?yiDYsRCc7CZmKVBUHkDdR062DFB4EB9ZI+X2IeV50/LsuDbFNoWCNxbWKSky?=
 =?us-ascii?Q?lzBkJfU37pePEvGJo8/BHdD8HGWZ+Yfc3ZRN3CIpluEKrwlU8TlT2vuhncDU?=
 =?us-ascii?Q?VAJ1f1sC0MIyaUBSqV7oFW6WkKcvgbQeE8Etn/Cgs9J2IBJ3WlZx7QKzdGy5?=
 =?us-ascii?Q?Dkq/JEQE10A+SNGLRjIYaDflpBf6P8u2LOCxiH0placZgx6H9kw1xDM1Eh3o?=
 =?us-ascii?Q?A3jZJdAz59TQCylGu2+ahlVHd5uFPIbtHnhhz1XY6LXohKJDAYgBez455FI5?=
 =?us-ascii?Q?9ANlb3xTrNtkWsIWHgid2QkI73aO4NIwNQvmevmr4nTHmRE7EzCsg180B+2V?=
 =?us-ascii?Q?1ZB6BcWGY4a23iVhEaSdr7ezzqb/UkTzyPF1vOJAxlZVcE4FAtBjqLkbhgAt?=
 =?us-ascii?Q?hFjp8tF9JS+OEAhp2LSmfSJFL3vqXqfadEegjPSdd3MV0NBayyNjFy38r4nY?=
 =?us-ascii?Q?ZcGpcayF/qitGILgvK8ED8MobCxQAXonjpJBvd7ZlFz2pqPx6mu1GN4to+Y1?=
 =?us-ascii?Q?GfayWvXzVkvc+G8SbUSiGG3YoS25hQPvzdqxLGveA18nX/8IFj+X+i1eJwj3?=
 =?us-ascii?Q?B+y+6nAq4Sx4mG9mL7nGZ3kvOT9MVz8kqWl3q39vUXgb+SHuNeu5iZTLz1Vz?=
 =?us-ascii?Q?5wch3odlQkLiDqnNqwqftmcEEULOLHZVOz0lzpi6ZSHUNg5rP/pv3QybjWSj?=
 =?us-ascii?Q?KvSIKInpj2+i9po+ROjInQ1JtidZ3h8sOq/b6/JdFn/x0ios25GUdWV/aBJl?=
 =?us-ascii?Q?3pm5F92P6J5dj5xz4WcFwnFjFYR43rdHadDxgS9MOq8rpcWzHdgwkleshOm5?=
 =?us-ascii?Q?DKHBL2X6f+zuPbSRxXqM9NBN6DBxX8XZHXXkzbDzGGoJ+IUoL2c+dNHOuiQ1?=
 =?us-ascii?Q?wzjPWSD20xnA7ERzPVdMl3lRkPfxu3NgouMWPMS7KxcLJ5DVdE4dfuSbCPSr?=
 =?us-ascii?Q?bT/NumdLRwn2688wvs8cqfFpFz98vmVtgdXGdT0s?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 099570c7-cd6e-4c53-4472-08dd50a30a38
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7726.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2025 05:05:33.9602
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W7SvnapCL/7OSv8VAMxay5auGMsBdtBDnbhwLiTCKiuB+BHo05Zcm777hVL+WmD0yvqlP0YKowVgUMo7b9tczw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8875

DAX no longer requires device PTEs as it always has a ZONE_DEVICE page
associated with the PTE that can be reference counted normally. Other users
of pte_devmap are drivers that set PFN_DEV when calling vmf_insert_mixed()
which ensures vm_normal_page() returns NULL for these entries.

There is no reason to distinguish these pte_devmap users so in order to
free up a PTE bit use pte_special instead for entries created with
vmf_insert_mixed(). This will ensure vm_normal_page() will continue to
return NULL for these pages.

Architectures that don't support pte_special also don't support pte_devmap
so those will continue to rely on pfn_valid() to determine if the page can
be mapped.

Signed-off-by: Alistair Popple <apopple@nvidia.com>
---
 mm/hmm.c    |  3 ---
 mm/memory.c | 20 ++------------------
 mm/vmscan.c |  2 +-
 3 files changed, 3 insertions(+), 22 deletions(-)

diff --git a/mm/hmm.c b/mm/hmm.c
index db12c0a..9e43008 100644
--- a/mm/hmm.c
+++ b/mm/hmm.c
@@ -292,13 +292,10 @@ static int hmm_vma_handle_pte(struct mm_walk *walk, unsigned long addr,
 		goto fault;
 
 	/*
-	 * Bypass devmap pte such as DAX page when all pfn requested
-	 * flags(pfn_req_flags) are fulfilled.
 	 * Since each architecture defines a struct page for the zero page, just
 	 * fall through and treat it like a normal page.
 	 */
 	if (!vm_normal_page(walk->vma, addr, pte) &&
-	    !pte_devmap(pte) &&
 	    !is_zero_pfn(pte_pfn(pte))) {
 		if (hmm_pte_need_fault(hmm_vma_walk, pfn_req_flags, 0)) {
 			pte_unmap(ptep);
diff --git a/mm/memory.c b/mm/memory.c
index bdc8dce..84447c7 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -605,16 +605,6 @@ struct page *vm_normal_page(struct vm_area_struct *vma, unsigned long addr,
 			return NULL;
 		if (is_zero_pfn(pfn))
 			return NULL;
-		if (pte_devmap(pte))
-		/*
-		 * NOTE: New users of ZONE_DEVICE will not set pte_devmap()
-		 * and will have refcounts incremented on their struct pages
-		 * when they are inserted into PTEs, thus they are safe to
-		 * return here. Legacy ZONE_DEVICE pages that set pte_devmap()
-		 * do not have refcounts. Example of legacy ZONE_DEVICE is
-		 * MEMORY_DEVICE_FS_DAX type in pmem or virtio_fs drivers.
-		 */
-			return NULL;
 
 		print_bad_pte(vma, addr, pte, NULL);
 		return NULL;
@@ -2454,10 +2444,7 @@ static vm_fault_t insert_pfn(struct vm_area_struct *vma, unsigned long addr,
 	}
 
 	/* Ok, finally just insert the thing.. */
-	if (pfn_t_devmap(pfn))
-		entry = pte_mkdevmap(pfn_t_pte(pfn, prot));
-	else
-		entry = pte_mkspecial(pfn_t_pte(pfn, prot));
+	entry = pte_mkspecial(pfn_t_pte(pfn, prot));
 
 	if (mkwrite) {
 		entry = pte_mkyoung(entry);
@@ -2568,8 +2555,6 @@ static bool vm_mixed_ok(struct vm_area_struct *vma, pfn_t pfn, bool mkwrite)
 	/* these checks mirror the abort conditions in vm_normal_page */
 	if (vma->vm_flags & VM_MIXEDMAP)
 		return true;
-	if (pfn_t_devmap(pfn))
-		return true;
 	if (is_zero_pfn(pfn_t_to_pfn(pfn)))
 		return true;
 	return false;
@@ -2599,8 +2584,7 @@ static vm_fault_t __vm_insert_mixed(struct vm_area_struct *vma,
 	 * than insert_pfn).  If a zero_pfn were inserted into a VM_MIXEDMAP
 	 * without pte special, it would there be refcounted as a normal page.
 	 */
-	if (!IS_ENABLED(CONFIG_ARCH_HAS_PTE_SPECIAL) &&
-	    !pfn_t_devmap(pfn) && pfn_t_valid(pfn)) {
+	if (!IS_ENABLED(CONFIG_ARCH_HAS_PTE_SPECIAL) && pfn_t_valid(pfn)) {
 		struct page *page;
 
 		/*
diff --git a/mm/vmscan.c b/mm/vmscan.c
index fcca38b..b7b4b7f 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -3377,7 +3377,7 @@ static unsigned long get_pte_pfn(pte_t pte, struct vm_area_struct *vma, unsigned
 	if (!pte_present(pte) || is_zero_pfn(pfn))
 		return -1;
 
-	if (WARN_ON_ONCE(pte_devmap(pte) || pte_special(pte)))
+	if (WARN_ON_ONCE(pte_special(pte)))
 		return -1;
 
 	if (!pte_young(pte) && !mm_has_notifiers(vma->vm_mm))
-- 
git-series 0.9.1

