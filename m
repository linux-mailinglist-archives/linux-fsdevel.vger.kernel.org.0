Return-Path: <linux-fsdevel+bounces-40846-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 08354A27EE7
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Feb 2025 23:55:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38A7F3A72E0
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Feb 2025 22:54:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA9A0226197;
	Tue,  4 Feb 2025 22:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="uBv/bHPh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2064.outbound.protection.outlook.com [40.107.244.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5328B21C174;
	Tue,  4 Feb 2025 22:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738709396; cv=fail; b=DcEBVmgWkzIY7TjGrYhsmpZMG+VAtNTjxFaaAjxN7g2rRpFceZ0Owl/jlukmxF9CzvLRCrsjreKDiHkY8KTkBLkMWM8nQAFURYRixLLNrblPDBRlXrzGECoxQ+cBENVbKwJHlmS0NEYYBWaTKew7FeVBY0G7vVDTvUcQQr9AfWo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738709396; c=relaxed/simple;
	bh=eWrwfYdC0UumsZ4p02V9YFbkMR3Pm2Dz7vyXZafv4J8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VojhngCqS8dYEzRXfaHfppj2n4i2FS0xJGMgbgj6m4iUxjwqVzT6VaF/RHj5eA96VmEP4O0VpN+1BVuPUQl7zOX9YeFey5WiH8Eih2Voj7T9xAxUcpG6y/ZxFn4xS1x558otXEBrRN45YE6IqjyAZY9npLJ0fwUbMKaI03dllnY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=uBv/bHPh; arc=fail smtp.client-ip=40.107.244.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Fky0KmSP1lp/kyEm/3m/poGB9Seb/cKw4hV4TZZY5E4lWlabakFvDJUxPByGztt1t0loBGPWJUCvaJG9fhw3HIWgpor/m/GFPgcS01W6H46o0U4KdtdvCbPGZygnV4immyfdxlxAQpT05YwrhZRbVC+Z+cL4LmbFra0C7qAf35w1vqwADxcDjx4HhFOWs00leC1DX7FD3jsy9VNASC4mSKqdvYW/0lGqNQkHNW1dzwERyU9zxRzlr5I80MPevNuVsvIt0Dppbv/U78raJAQe+2/4oEBRoNsY+g/kw7C+PYdZR5v+m/OMgQ1dTUBh8J2BGMWgstyjo+zdo9JA208iKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W1l7WOnCWjulZpMO6hDM9yKhadgqJOsZu6fT17lCqVU=;
 b=yfHEWqOKbyQtl8p5JtOb3/kEx1qGdadkG6eRgPGYNbZc9UgGYEi2w4gZRzInMLTNAgpARS2i+E7VA7fS8HdBvdAfXWUKjyqbkWZZowTlKOvBCifpDmAwampo94WM7z91IxRinX84vwtYsq0Z8avhUAWcBD5T1JPMgsP752dxg7QnQBaGzw1gl+ypo9CvcZMmRI7Q1dYKMZBq5vERkh4bREeDSHnzdTO03vPm0K6UC+phzSBVD43f0jOWUVgSVJgmssd6RUuOiTA0p9o4liist4DyANHtODgsri2OaGSxSQw024xO/+OysEUOI5AQpxvpyFtXGbh/jt6fB0OEbsZP1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W1l7WOnCWjulZpMO6hDM9yKhadgqJOsZu6fT17lCqVU=;
 b=uBv/bHPhuyCdXE/6z1Jj/1AN7VInHODXxgVMnrDNsVNVPI3L+4Ir6p6l6KjuncN+cA75ZRogOy++Mo2vO3JpW0pZRB5SI1cteqIMzFwGmPe9GWV+7S0RqMntVSbDQzTwyNdx9kzS5SK6KovUxrPLqnA3TxUvGft1VmB7g10PXfM3zIuK0kb2SJ612CKgl5usNjO/rNJJcVonzzVgJUNfCKaeZfvortQaLILNlGQCeiR05Ro/wI+jzPeBX885/Tc7ctCjEmnQ7eqT5hdckJQ4up3r87ZiP6zYnujDaLm/zBBqM52mtMhFEtGtt0fONVi2SksO19M+WvgURqxEBxn3PA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6) by
 CH3PR12MB9027.namprd12.prod.outlook.com (2603:10b6:610:120::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.25; Tue, 4 Feb
 2025 22:49:52 +0000
Received: from DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe]) by DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe%7]) with mapi id 15.20.8398.025; Tue, 4 Feb 2025
 22:49:51 +0000
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
Subject: [PATCH v7 16/20] huge_memory: Add vmf_insert_folio_pmd()
Date: Wed,  5 Feb 2025 09:48:13 +1100
Message-ID: <9f10e88441f3cb26eff6be0c9ef5997844c8c24e.1738709036.git-series.apopple@nvidia.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.472dfc700f28c65ecad7591096a1dc7878ff6172.1738709036.git-series.apopple@nvidia.com>
References: <cover.472dfc700f28c65ecad7591096a1dc7878ff6172.1738709036.git-series.apopple@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SY5P282CA0090.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:10:201::17) To DS0PR12MB7726.namprd12.prod.outlook.com
 (2603:10b6:8:130::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7726:EE_|CH3PR12MB9027:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c36f967-edae-48de-53b0-08dd456e3c3b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?FlD8+gQFNQJ+OjgIBjDgTu8+4ZSWAIojeFsGWl6TfvwA+JdOfF1EyUp2Ul1A?=
 =?us-ascii?Q?JZNWrIdWm++9dtxB2xZvxjSnQKJKZdDmJkuHoXuTNSrvw6ebIidERwU8P4Xu?=
 =?us-ascii?Q?xUnAwopb5wqX0/rokMEgigcyx0WJXH/47lSiky6u5Gea5hu/wOuGpfjRA43b?=
 =?us-ascii?Q?eaMUHtmVEr61fEQVA4EltGnumUY3oJV0as2OAcwH5y8BwwTL4lfazXmIJMkv?=
 =?us-ascii?Q?9HkBH/pUuDZoBdDz93surZtk/6MCVsIe5eZWal4BBNxhQF+mgtjogDco1zbt?=
 =?us-ascii?Q?OromT07YIkAbJEqkfNUsP3BVIK9/XDJn0gdHrA5yBh2hnh/XbZ3jVsQ631Ed?=
 =?us-ascii?Q?ZTyjeNxbPCtpzKPFHUdygfCsgwWiOksIhefpz8tjzYxqZExwfx8biLy0mk2D?=
 =?us-ascii?Q?tVzI6BOvz0C7g5MADjl4q++TiumQsBV6tfTYpjHTmqQGeIo2G2oV4aLbR3Ko?=
 =?us-ascii?Q?8Vh7R72bgrfHGoQASOUZWzTaStwVNuIZ1XbKh2+Kgz3kekxeNBpWQpczS/i1?=
 =?us-ascii?Q?ap9rPTXnqg497nnHTOKpzNMTKepEGS5WJGsGFRgcWhV8309Q//p8cGZyHp34?=
 =?us-ascii?Q?CZEQpa/KnUpmOEJAOPpMFSjHcihFlXDu6qCc/xkEkG00/IoEkqXTmqnAJoJ3?=
 =?us-ascii?Q?xe26z5zAexVSCsu9F9p2TnLU+ZVZ7HLYTktb1ZV61b+5l8NeOyw9H/NtLiKD?=
 =?us-ascii?Q?RWQBhZvP+sTktzwz8DDOBTRMVJBT+Zx5WFeuDL8qpqbvho2b9jUGJsd3ZPuO?=
 =?us-ascii?Q?wHXQsb6ZxuCmdHagrx7dMgfD7IQJEHR41DbQgkH7UK553/lGjgbe3xZmwRdA?=
 =?us-ascii?Q?jAGiS84xbHwRUdPpmFhBuWiX97YqPRnQB24SBkI+UdINA2VlCdJ6fCOZvD6U?=
 =?us-ascii?Q?K3XjU58LFXk4ky6PEFeCpV4mcMqOpu43KjoMRvXkxYIaNOgwLJXddF8NMqZI?=
 =?us-ascii?Q?AzKuIuxClw/fzpLWKTMybEv+Ex6HSqCVWRygpz95hS2XX84zp4bBYLDNRTq1?=
 =?us-ascii?Q?xqj5Hv1YeUDfIl0wWTKuvmcF63t2FWICFK2Rd07CeakPxdSvIBRMAs2IFXHY?=
 =?us-ascii?Q?vIPRS/2AkMPc97SQ0Uk9RmiecB8D2n5ig1RGaXNbDGizKaoncfAM3EEBOKn0?=
 =?us-ascii?Q?yKvI29FkhipoWcwv29li1L1V0p9zFj8c3/2CJHv8sdFG19jYFm+ETyPXO1pP?=
 =?us-ascii?Q?Z2KTxUOeymenAseQjyeNeNplmMOQFIR5IQ5KJ4e8/T557scw0cWL5aKolh87?=
 =?us-ascii?Q?vlYnmWf2uEn3VV8JmWSoxBzCxuEfheOOP35h0rkTMrG2Ig5r0Rno90pJHpGz?=
 =?us-ascii?Q?PjWVWHPHWPk8sgfa9CcITMqZCksOSCPsyf0XIjTu7GT9XPgQ7JlbhVL+CdgW?=
 =?us-ascii?Q?ChdAqUTPmxzqDImbuOUR1Q0ss8W7?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7726.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ITYZY3hRTCT2e1aQtjdicUtueo41yRQnTwipbRgmTC1w3EMkhEHPyJSag71f?=
 =?us-ascii?Q?70bQcsEdyCwnJRTvOY1rbhNJSnWnyyyq5n8ScsV3zx/c3+glO3R9aAYKGEdp?=
 =?us-ascii?Q?5J314xojrtd1tS7NvpuaJunUe5oSdCRsUprrUeMMYgtHxWi9juB4Jn+6r2Qk?=
 =?us-ascii?Q?k9wZTCBFDCEz+Qodrd0fjk/U1Y1A4NK1doty+djy6FtZKwi0VmuBE9n3lW5e?=
 =?us-ascii?Q?b0X1IMzfImPPnTQEC+m6OispeG9pjgXZzqmzBkkJqqPYPteG4YAjOzPbgawM?=
 =?us-ascii?Q?2Biol/1VSV+2DWED4ej55TtgjHEvwZIWT33SBxdmf0d8Gd7tJumSYwgPDOon?=
 =?us-ascii?Q?FclDu9q5ayodC7GqTWsRpBmdOMMoy5J1nrFuU7Ew6loY5AC4ksWarrByLwZe?=
 =?us-ascii?Q?G+OB8wZwc6ZlNi7RXKzVNSB72GZoSrqkTXj7gHzOynAEP2B12guiO+sDtLHQ?=
 =?us-ascii?Q?3xQP2+7ZcYTeRuU6C2O1vZ6jJt6huJlo9NDw2uvHfSDeFqcuGr1ehAiYL+pg?=
 =?us-ascii?Q?AjGubInMxOc/lku7MQ0fCFZ2+hTXlxsHXG4C1iNK14ye+qi10V1Hmp2NWtsX?=
 =?us-ascii?Q?1O0j9CkBSLtdOrQmcVGfQMiYrHVpsW56tJ6waPwB/ZlAt0ACI4LEc5gCUnqe?=
 =?us-ascii?Q?aqYtDc9QtyRSAYG+Lo0cSplmKEyZk69NWsfUkc2ZksZauz44GVwoPBxJscmx?=
 =?us-ascii?Q?WtgfkKp6n/xHQ1jFytS82jrPjG3eLG3TTPuTkQdoNU0CNLG7j763UOcGsSHe?=
 =?us-ascii?Q?WXa+kRQp0uHLLpRHI5/Cr6nf+kIwWnuj3s3R98xaorGv0G+eDbmL39qobLUo?=
 =?us-ascii?Q?pq+lElLbpt9uYA6rXs2TzwTnfwS1u13RWA1P6kySjhIpS1/FB85JsU9bLhMJ?=
 =?us-ascii?Q?L9UBUnRa/nLHM46pGfbr9UuufNivwG3Nq7OloFKrFDH8yUA3qwbSzAUH1TfI?=
 =?us-ascii?Q?HNqfhYNO7WNxKQFblgrb90K/qX3qOqdbVvEad+y9XkIQQygUdgJ8qYemZrEL?=
 =?us-ascii?Q?FuNxWHAQZGD5A/Wgxj6UWm5DJo5ChXVJ/P4jy0V9gLR6lLOsCmMhzZ2y+7mZ?=
 =?us-ascii?Q?sONKxsWcnvRHIP+Xn9uhUqDm0yP7IIruoDub9eYAgEIzRY9u7hpTU2CA7S4U?=
 =?us-ascii?Q?LMxg3dL3JF3/q+WIPyWuijQ/vDyFpw6/Li1nfHfZiDGE/ZsFkR6E2rek3zA4?=
 =?us-ascii?Q?bLO+UQVPx6mEGZ2ZUt1OOW94W+1z7aXxmK3YSuAEBXD8X5CbEtz+JEf7y9mi?=
 =?us-ascii?Q?wdQJbcXDrmeuc3gzgT7nVzy/CX0Jj/PC+510dnlBV3DEMZGzMW5q25pFn6MJ?=
 =?us-ascii?Q?XWvQ8gbVc5SbbjnOEgVOrxVvL5l+njhwd1vEaEr3bCozlkIAJtCf2TQ5hsAn?=
 =?us-ascii?Q?p4xEW1OM8Ri5vMzN02c3AKBHr3+ZnJ0SJkiINooFxR/XZoSpVmNTdKqaz9KV?=
 =?us-ascii?Q?YsoTJCyYMQ3nQMchk/Y+a6EmH4xOUw+IuKSULVodkmqSW1j4BsK+17MA0AXu?=
 =?us-ascii?Q?6L6UKVYvQP2Q3Dk6St/lhzZwOEFnnVC6+nthVWcHA18HsTXOnN9sor6ioiIb?=
 =?us-ascii?Q?zHa5uQ5xCrAMS2evobuhMFox7TTbk0c5evrd+3wy?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c36f967-edae-48de-53b0-08dd456e3c3b
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7726.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2025 22:49:51.8930
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mU1KW5DWb3KN7WP6OVwayra1mwsnhb3HY7KFlhdKf7fOrQdFYXEyIQKwBa4u8kgqrrA5zGG/GCTUrlRTFRMnzA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9027

Currently DAX folio/page reference counts are managed differently to normal
pages. To allow these to be managed the same as normal pages introduce
vmf_insert_folio_pmd. This will map the entire PMD-sized folio and take
references as it would for a normally mapped page.

This is distinct from the current mechanism, vmf_insert_pfn_pmd, which
simply inserts a special devmap PMD entry into the page table without
holding a reference to the page for the mapping.

It is not currently useful to implement a more generic vmf_insert_folio()
which selects the correct behaviour based on folio_order(). This is because
PTE faults require only a subpage of the folio to be PTE mapped rather than
the entire folio. It would be possible to add this context somewhere but
callers already need to handle PTE faults and PMD faults separately so a
more generic function is not useful.

Signed-off-by: Alistair Popple <apopple@nvidia.com>

---

Changes for v7:

 - Fix bad pgtable handling for PPC64 (Thanks Dan and Dave)
 - Add lockdep_assert() to document locking requirements for insert_pfn_pmd()

Changes for v5:

 - Minor code cleanup suggested by David
---
 include/linux/huge_mm.h |  1 +-
 mm/huge_memory.c        | 61 ++++++++++++++++++++++++++++++++++--------
 2 files changed, 51 insertions(+), 11 deletions(-)

diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index 5bd1ff7..3633bd3 100644
--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -39,6 +39,7 @@ int change_huge_pmd(struct mmu_gather *tlb, struct vm_area_struct *vma,
 
 vm_fault_t vmf_insert_pfn_pmd(struct vm_fault *vmf, pfn_t pfn, bool write);
 vm_fault_t vmf_insert_pfn_pud(struct vm_fault *vmf, pfn_t pfn, bool write);
+vm_fault_t vmf_insert_folio_pmd(struct vm_fault *vmf, struct folio *folio, bool write);
 vm_fault_t vmf_insert_folio_pud(struct vm_fault *vmf, struct folio *folio, bool write);
 
 enum transparent_hugepage_flag {
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index a3845ca..c27048d 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1375,20 +1375,20 @@ vm_fault_t do_huge_pmd_anonymous_page(struct vm_fault *vmf)
 	return __do_huge_pmd_anonymous_page(vmf);
 }
 
-static void insert_pfn_pmd(struct vm_area_struct *vma, unsigned long addr,
+static int insert_pfn_pmd(struct vm_area_struct *vma, unsigned long addr,
 		pmd_t *pmd, pfn_t pfn, pgprot_t prot, bool write,
 		pgtable_t pgtable)
 {
 	struct mm_struct *mm = vma->vm_mm;
 	pmd_t entry;
-	spinlock_t *ptl;
 
-	ptl = pmd_lock(mm, pmd);
+	lockdep_assert_held(pmd_lockptr(mm, pmd));
+
 	if (!pmd_none(*pmd)) {
 		if (write) {
 			if (pmd_pfn(*pmd) != pfn_t_to_pfn(pfn)) {
 				WARN_ON_ONCE(!is_huge_zero_pmd(*pmd));
-				goto out_unlock;
+				return -EEXIST;
 			}
 			entry = pmd_mkyoung(*pmd);
 			entry = maybe_pmd_mkwrite(pmd_mkdirty(entry), vma);
@@ -1396,7 +1396,7 @@ static void insert_pfn_pmd(struct vm_area_struct *vma, unsigned long addr,
 				update_mmu_cache_pmd(vma, addr, pmd);
 		}
 
-		goto out_unlock;
+		return -EEXIST;
 	}
 
 	entry = pmd_mkhuge(pfn_t_pmd(pfn, prot));
@@ -1417,11 +1417,7 @@ static void insert_pfn_pmd(struct vm_area_struct *vma, unsigned long addr,
 
 	set_pmd_at(mm, addr, pmd, entry);
 	update_mmu_cache_pmd(vma, addr, pmd);
-
-out_unlock:
-	spin_unlock(ptl);
-	if (pgtable)
-		pte_free(mm, pgtable);
+	return 0;
 }
 
 /**
@@ -1440,6 +1436,8 @@ vm_fault_t vmf_insert_pfn_pmd(struct vm_fault *vmf, pfn_t pfn, bool write)
 	struct vm_area_struct *vma = vmf->vma;
 	pgprot_t pgprot = vma->vm_page_prot;
 	pgtable_t pgtable = NULL;
+	spinlock_t *ptl;
+	int error;
 
 	/*
 	 * If we had pmd_special, we could avoid all these restrictions,
@@ -1462,12 +1460,53 @@ vm_fault_t vmf_insert_pfn_pmd(struct vm_fault *vmf, pfn_t pfn, bool write)
 	}
 
 	track_pfn_insert(vma, &pgprot, pfn);
+	ptl = pmd_lock(vma->vm_mm, vmf->pmd);
+	error = insert_pfn_pmd(vma, addr, vmf->pmd, pfn, pgprot, write, pgtable);
+	spin_unlock(ptl);
+	if (error && pgtable)
+		pte_free(vma->vm_mm, pgtable);
 
-	insert_pfn_pmd(vma, addr, vmf->pmd, pfn, pgprot, write, pgtable);
 	return VM_FAULT_NOPAGE;
 }
 EXPORT_SYMBOL_GPL(vmf_insert_pfn_pmd);
 
+vm_fault_t vmf_insert_folio_pmd(struct vm_fault *vmf, struct folio *folio, bool write)
+{
+	struct vm_area_struct *vma = vmf->vma;
+	unsigned long addr = vmf->address & PMD_MASK;
+	struct mm_struct *mm = vma->vm_mm;
+	spinlock_t *ptl;
+	pgtable_t pgtable = NULL;
+	int error;
+
+	if (addr < vma->vm_start || addr >= vma->vm_end)
+		return VM_FAULT_SIGBUS;
+
+	if (WARN_ON_ONCE(folio_order(folio) != PMD_ORDER))
+		return VM_FAULT_SIGBUS;
+
+	if (arch_needs_pgtable_deposit()) {
+		pgtable = pte_alloc_one(vma->vm_mm);
+		if (!pgtable)
+			return VM_FAULT_OOM;
+	}
+
+	ptl = pmd_lock(mm, vmf->pmd);
+	if (pmd_none(*vmf->pmd)) {
+		folio_get(folio);
+		folio_add_file_rmap_pmd(folio, &folio->page, vma);
+		add_mm_counter(mm, mm_counter_file(folio), HPAGE_PMD_NR);
+	}
+	error = insert_pfn_pmd(vma, addr, vmf->pmd, pfn_to_pfn_t(folio_pfn(folio)),
+			       vma->vm_page_prot, write, pgtable);
+	spin_unlock(ptl);
+	if (error && pgtable)
+		pte_free(mm, pgtable);
+
+	return VM_FAULT_NOPAGE;
+}
+EXPORT_SYMBOL_GPL(vmf_insert_folio_pmd);
+
 #ifdef CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD
 static pud_t maybe_pud_mkwrite(pud_t pud, struct vm_area_struct *vma)
 {
-- 
git-series 0.9.1

