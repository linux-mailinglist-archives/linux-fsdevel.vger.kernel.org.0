Return-Path: <linux-fsdevel+bounces-50032-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DE737AC78E3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 May 2025 08:34:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 892301C06D57
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 May 2025 06:34:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7EDB25B69D;
	Thu, 29 May 2025 06:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="dZQFh+N7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2049.outbound.protection.outlook.com [40.107.244.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EAE125A34B;
	Thu, 29 May 2025 06:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748500364; cv=fail; b=tpDm+glT7ZiZas9ajPB3rFGEPMdwUykFSCNhe43qzGxdaahrERa+O+xqiMn8tDyKQSosZXMmM/jmTW+nDGHEK3IIgZs0uqq/AcurPMpNgFKCaetfJVoVbsjQ+PsoarNa6NKIMgrp9CP/7uGLB58hvL0t/GHVV1SakLM3TKNGn2c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748500364; c=relaxed/simple;
	bh=zJPTI2wmsHiEIWEzciDAewvz75RntMg0E3mEiGZkrn0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UKUoHpQibh0bdIapjuO+GVvFlSj6R1cfpfJeMLoo5I85E0JIjw0Qd5Bq8ucafBfXHqCcrXLzQIAYxr6VRzjYlyX1g2nIMLYI85CjGKVeoz3r4RveRpRksyJP4rRnRRmRpojsbtlNLQIYga6GoVsGbXdDXCZHB6MoLgsolh2lVlk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=dZQFh+N7; arc=fail smtp.client-ip=40.107.244.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cT55hLRvgoEb0GHxJrHXOlbOVROr+qS8CPjFXFYg5dk2sX+xGAtTUOVd5qBglh8v1iisgh7EXoGg2Gi1tZUG8vLfiiaPSJZJdldiwcZ3iMaFdnxfr2Bm+1U5d0xBhgmU8UxhwbzxQ4HM0ri6l5k87eaX1ehMbbs56ylJYBTu+Tbd2dnQ4pWPqWDV/zq4iEYAY8nf66cAUaFGAhh6OjQ6NOLkaL+69Zc2XoMlWBTBmWZ+qnv3tKIzMNFRpBOWWynzFyoPCt1dX8rWrKOyltpmla5fljW8xvfQybjjexejQIP53V9flDLdffD5/XYL+DeQ+1tmxB5h/5Q3MpGsfy/kvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2NWPYn4j7gE2O3rUjWxvp+GQdDNzGfcJRJ1twC+ad8Y=;
 b=yvb+2nT+VkQ/+HLOoG48AiBK6phdORRyaZuNVmXKZLnSLrO0Iqt/GR0rfk/pNzykeBufeudp5VZ9Tcr3ZUn7nL9aZ1K2FfXS75UM/67F/kYnOBFw+XctoqGd2uglwOE5E+msNVDle3NRIE2YBd8SblV8KhCSCN6phZ2kCbVX21WxHOPiHF8TpFy79YeqbHNPrfM4UbOyPYo+XK4ThznfsdkQPNmQV5gkns1UoTu7lzJlwKMIkyQDxBGGvvWQrWxu5kfMSSQVHOmzDAkEQ0AdiOXZ0tLTikGXXX/IcbiWWhl2El67rxUMA7nwO4X09fNl6laEcMO5lYb1JL+q254+Ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2NWPYn4j7gE2O3rUjWxvp+GQdDNzGfcJRJ1twC+ad8Y=;
 b=dZQFh+N7mBJOm/04hudc5bqY9UmnESWqGsRZYdFGFGil3NAnMS4bUy8ftvI17LLU/11pRUijFfdGSuv3poXX7mvk1Dmg9xMpGjNXaSzrpJR5oeXu0KQAWVrunm34u1wilP88F1y1ZO1FDE4OxBmHI1Lyw8PGlAKWcRRMM+bi0Ifgdv+SMs3nO8ihXgeK3SC2cTNR3CeXRK6SwB+84ZSbn2ji5xploOWqbqosgr37x3GJu1IZKmzr2+wXroyqP1kM1kyiet3RXbxsQTLrxis7vcpWPPEsL7kgegDYjda+5FEaIKcsT4EblQEljMfdd+ZW6rz5MacYJqvI+xV56JMObQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY8PR12MB7705.namprd12.prod.outlook.com (2603:10b6:930:84::9)
 by IA1PR12MB6092.namprd12.prod.outlook.com (2603:10b6:208:3ec::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.26; Thu, 29 May
 2025 06:32:40 +0000
Received: from CY8PR12MB7705.namprd12.prod.outlook.com
 ([fe80::4b06:5351:3db4:95f6]) by CY8PR12MB7705.namprd12.prod.outlook.com
 ([fe80::4b06:5351:3db4:95f6%5]) with mapi id 15.20.8769.025; Thu, 29 May 2025
 06:32:40 +0000
From: Alistair Popple <apopple@nvidia.com>
To: linux-mm@kvack.org
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
	balbirs@nvidia.com,
	lorenzo.stoakes@oracle.com,
	linux-arm-kernel@lists.infradead.org,
	loongarch@lists.linux.dev,
	linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org,
	linux-cxl@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	John@Groves.net
Subject: [PATCH 04/12] mm: Convert vmf_insert_mixed() from using pte_devmap to pte_special
Date: Thu, 29 May 2025 16:32:05 +1000
Message-ID: <171c8ae407198160c434797a96fe56d837cdc1cd.1748500293.git-series.apopple@nvidia.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <cover.541c2702181b7461b84f1a6967a3f0e823023fcc.1748500293.git-series.apopple@nvidia.com>
References: <cover.541c2702181b7461b84f1a6967a3f0e823023fcc.1748500293.git-series.apopple@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SYBPR01CA0212.ausprd01.prod.outlook.com
 (2603:10c6:10:16::32) To CY8PR12MB7705.namprd12.prod.outlook.com
 (2603:10b6:930:84::9)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR12MB7705:EE_|IA1PR12MB6092:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e900b64-3bd6-4c44-9c5d-08dd9e7a9c27
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?mw0/fNiSbM3fSekM+OVG65jvdKvWTw3oQxyEU5h/FNXZxTgTQ4Wojami9Sny?=
 =?us-ascii?Q?zm909+5aSPjakDcvEgGWY54boBREaLoV+bK8NOmahWnAHnN1tcQpDYhKZYfO?=
 =?us-ascii?Q?obuXuSR+/KWEazsD1t9ceS9KAvXvWpVl/henOJCGHo0cOzzQU/SbTDnMaWfj?=
 =?us-ascii?Q?rlDMcX+i3a0v+hmJZINe/vkAUfkGk+5boM+wWL61BRsv6k+bLklfCW6FqjkC?=
 =?us-ascii?Q?0egzGibcYISLRRajLJKsS9tovyBvv4WWrxsuPjaVitFAGt6ALhru+Iyjwnv+?=
 =?us-ascii?Q?BZmCzilpuxdIJ+pBrZWn3ACuZ55VrPz7XhtWgXUS0jQdfNEm+n5zpbpA4wi/?=
 =?us-ascii?Q?ARu3whtyon9ddeXUhCYdE7aGNdiPrVFG/qnx1BQjwp86973uKbV2IboH8i5K?=
 =?us-ascii?Q?Ri0TVW1vwoHU4M/eHhCK90FAG/as+FFevpKUwBxTpjnRQtGua43YJkw9E68D?=
 =?us-ascii?Q?vH8zgMbGqK3/CO4ZzeK0b+7zy1yAgeyDrXtv8gHDlgvcE00p2bnG0GT3w4n+?=
 =?us-ascii?Q?y+3Owm2t9qtZE76hAha+EEqp/eId5AzZMvR4oQktVS6Jv7BIHB6TjUu+14HQ?=
 =?us-ascii?Q?hRI+djy86y/0D/lnAt+0V2XFmdzdTYHEM4DTs43bYjjL9jS3loXvbtL0hQVw?=
 =?us-ascii?Q?aOylLHciyqtCV+A/yv8cDROHfafCo5vFdtOS5OwpuchoX4gKSL6n18h+tQPA?=
 =?us-ascii?Q?g0B/9OD1NPwNvnyIXeS31Cnt2bDg6dHBVI0KaLExvFr7UPCuIeMLt9XpAwxZ?=
 =?us-ascii?Q?oJt8J0oqriNM6Sv3NXdd6Q9PIPqHxhn/MpjIxC3jqJhQ2yk7PL2+VFaDAcqL?=
 =?us-ascii?Q?yc1UKBQxRCOQS4KMMGJdYEuG2nvVW6RmLiC8Chct2jx57BgeRQsPEDNtcVly?=
 =?us-ascii?Q?vLQ+cCR8HXLTqILFN+Xm/BuEBsbWrX9YXieZSqNUP9l/2q+UneOftZ2Q1hPA?=
 =?us-ascii?Q?A5MpILE74tqv+uD1r/yud/uXhRQepoQfyywkHgTMYyeq0H4V/Lhi9E6KfSGQ?=
 =?us-ascii?Q?SevUHMQe6CozkFApIN3AMlXDHN6HCxf9AKso3Gx7ZvuKkT+JPPQLXg+hc9yG?=
 =?us-ascii?Q?x1nBKzbJZ8wtQkLaAaDTm5TDTXfZgXq5CnblGbU2XowMfaK4rabIx2M5azjT?=
 =?us-ascii?Q?F64HbMI+DcNemLWjJr6qY/X5b+Cxxl1OvVAliFFY6guElzeU/UcHvnZf+hPd?=
 =?us-ascii?Q?H4fVvbuMmSNecC/jvA0lL+HnfF8zQHkr3CbyG6DCOY9jLO8H71zpGfJv51HF?=
 =?us-ascii?Q?X0E0ZrODf9bagTigK3jPHCeP3D5PIOlhaGwFY8ZYyEiTkU02uf6d62d4QjaX?=
 =?us-ascii?Q?oEK7LmU9ZEz92hNZXgHe/0ztgdwR76OjzlAaVi/KGXN+oI6EOFAqPESpDJ6r?=
 =?us-ascii?Q?GlEjT4GPPOffTDffZiFjlp9aZndiovJnpZcV/1aeEVyRXmEYBg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR12MB7705.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?gyN9hVvoJ/E81tpbxb9OZhFbYcj6GE5UHMZGfcM5mkQ1xu/D8wEwjaKnRswP?=
 =?us-ascii?Q?t+LX8Yg8J41n2viZcib04wbceHtJ1WT5Zo46V6uSQbHzsiSPq4sT4AbwLoin?=
 =?us-ascii?Q?1ex/CEduq5EsMex8rXZks6MozjrQL9rS+9cziioyNKWTiwQA2Op/k93Vbrd2?=
 =?us-ascii?Q?1xOj0NcyrTuv81cPVOQps3F/ijqNjPVC1XjlC7GhRw47eEjGs9zIPNypaKH7?=
 =?us-ascii?Q?hRv3mTv/4vInKfE/fak0zfElDOB6+9oxrMAULMdJXNeJAm2T4ExgT/hY6AO9?=
 =?us-ascii?Q?ThccCDxoltaPWBAr18QXU+QxqSDbylNIEqbzYO5zh7M7FbtkKbAtyHWZNLBV?=
 =?us-ascii?Q?X2pH0BOhrRwuj2EMcvpagNjFl0TltBjnExYu+vH74YgFbq5DkTEoXBjEKBpx?=
 =?us-ascii?Q?FHU0Au6iRU1hFlt87zyOUZwj4C7Kfjc6tG9xUXQmFBtexgkLgaKaJV4TtxAS?=
 =?us-ascii?Q?FahXzg604mtmbwnCH/HxIIhR4uB4dfy1BI6VMudEid2vqaL591vaxMPH3r8v?=
 =?us-ascii?Q?ylkfT9s4dbsLmrrEjsqCoZVi2qBPP0ti+B+PW4c/ZYw48CNM3QcMXfYIZYip?=
 =?us-ascii?Q?ahDvYRLaij3NELZwv+OSlrY1WTdzJ48iPktT11EUGIoMLQXDGLFBsoVUOvW9?=
 =?us-ascii?Q?YRbLaWSTD6OnEJBoaT3dVpmNpAKFr36C0l8JUD9r22l7zIVqN/2k9bYPcQvP?=
 =?us-ascii?Q?5I1lsy4zgzRm/wyAPXpT3zVs3WD5btk5GmJB71lLjIOfhiEF0pdJuCjHpUb+?=
 =?us-ascii?Q?YSuT6OiImHVMS3ZYBEi2wO8mzfkw9Vd81gL4tXWEVMSecc5qd4EGszOS1Hz9?=
 =?us-ascii?Q?cZ+FbHXyrDXMOl32SVRJ5IQqxdwIMS3AdlTjcybP11bwS2n4VvJEpwUxyLLH?=
 =?us-ascii?Q?6WTJ74mf7xQ5v9KjM1wu9c6XqKtiayixyUrRN5/MLxhNmvjPl1yAaLqct0Jm?=
 =?us-ascii?Q?9+KOm+OMEoa84RMV9ocIV2ySlgd1Eje2VB7YreeU3IzphcxQGfTGPR6acHZL?=
 =?us-ascii?Q?85EVsJUgztCnFgyLBYjVWTgwkUOGDZXV/FpPhgpyFhvRXyBUciLrgxQ/MEtz?=
 =?us-ascii?Q?2IShe5rmzMlTVGGCYtdx3uyOOqnPjqfUuAK0cLi/yqPgOWmN0Sk5603YKFRU?=
 =?us-ascii?Q?Umsx9oSf33Egut5TsNgxtKZNoPL8BqnJHnO1VdlU+4FmLlwfGLF79OMy22+3?=
 =?us-ascii?Q?eFvAhwxNJYhD2/goPI97E0ybKGfB8THD4cblNaCtHZp+WR8BJvK1snzvFLOY?=
 =?us-ascii?Q?2rBtuFFcOI8zlyrcHf9emVE/95cSsyJYdOHEB1CWbjDjFwDd42QJgeaxyc47?=
 =?us-ascii?Q?tRTdv95DthsGvtGn7lHrI+vfnYX5tq2AhgE1VcwUrXbuBaxGUVebo0guIhGf?=
 =?us-ascii?Q?7E65AuZiyJNLdIm5laa6OYmdoXdMXcAFKFIUIBN4v8QHJ5GybUBVK7oqM7Kq?=
 =?us-ascii?Q?x4GrglBKQx8S2UgbCQhu0c59R7pSz35LKY1C9Bw1e9dO7BypanvxOZWezTYS?=
 =?us-ascii?Q?JDeYV6OJzstW1TCUMCAHXMZEgkvrom9r5LEYQNGbRnxJesNozjVoE5iCpSFb?=
 =?us-ascii?Q?kp5oC9otbFyr2HMY3b4DxzpupBnHSF7JJpOA7x97?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e900b64-3bd6-4c44-9c5d-08dd9e7a9c27
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7705.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2025 06:32:40.3676
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yv4Jur2uEAQMx08VSO1IBy5rDNXz/M4BcIGwpbkKK3nzv2UUruoscCTH4+/u3HwIHloUzHPtzQy6/eebesT02g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6092

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
index cc85f81..1a0c813 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -586,16 +586,6 @@ struct page *vm_normal_page(struct vm_area_struct *vma, unsigned long addr,
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
@@ -2453,10 +2443,7 @@ static vm_fault_t insert_pfn(struct vm_area_struct *vma, unsigned long addr,
 	}
 
 	/* Ok, finally just insert the thing.. */
-	if (pfn_t_devmap(pfn))
-		entry = pte_mkdevmap(pfn_t_pte(pfn, prot));
-	else
-		entry = pte_mkspecial(pfn_t_pte(pfn, prot));
+	entry = pte_mkspecial(pfn_t_pte(pfn, prot));
 
 	if (mkwrite) {
 		entry = pte_mkyoung(entry);
@@ -2567,8 +2554,6 @@ static bool vm_mixed_ok(struct vm_area_struct *vma, pfn_t pfn, bool mkwrite)
 	/* these checks mirror the abort conditions in vm_normal_page */
 	if (vma->vm_flags & VM_MIXEDMAP)
 		return true;
-	if (pfn_t_devmap(pfn))
-		return true;
 	if (is_zero_pfn(pfn_t_to_pfn(pfn)))
 		return true;
 	return false;
@@ -2598,8 +2583,7 @@ static vm_fault_t __vm_insert_mixed(struct vm_area_struct *vma,
 	 * than insert_pfn).  If a zero_pfn were inserted into a VM_MIXEDMAP
 	 * without pte special, it would there be refcounted as a normal page.
 	 */
-	if (!IS_ENABLED(CONFIG_ARCH_HAS_PTE_SPECIAL) &&
-	    !pfn_t_devmap(pfn) && pfn_t_valid(pfn)) {
+	if (!IS_ENABLED(CONFIG_ARCH_HAS_PTE_SPECIAL) && pfn_t_valid(pfn)) {
 		struct page *page;
 
 		/*
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 3783e45..61e6c44 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -3401,7 +3401,7 @@ static unsigned long get_pte_pfn(pte_t pte, struct vm_area_struct *vma, unsigned
 	if (!pte_present(pte) || is_zero_pfn(pfn))
 		return -1;
 
-	if (WARN_ON_ONCE(pte_devmap(pte) || pte_special(pte)))
+	if (WARN_ON_ONCE(pte_special(pte)))
 		return -1;
 
 	if (!pte_young(pte) && !mm_has_notifiers(vma->vm_mm))
-- 
git-series 0.9.1

