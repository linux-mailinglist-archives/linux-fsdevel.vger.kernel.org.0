Return-Path: <linux-fsdevel+bounces-22569-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AED6919C4D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jun 2024 02:57:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5BFC28356D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jun 2024 00:57:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64E3F36B0D;
	Thu, 27 Jun 2024 00:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="eiXixoTO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2043.outbound.protection.outlook.com [40.107.95.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6C542B9C8;
	Thu, 27 Jun 2024 00:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719449715; cv=fail; b=tteU0+VOY3yYdjUZ6MPCsp0lxYhTsXbNZEenjzGuOBx502ywE63XeSkbHiBUgs/LMbqwrY07sHKY0Re5ZhTBD8H6RXvJyq2Z0OnboCbIFpJW/4CUOQd0FDl5U9wUHLr2Mou1+niq2zgJPzaYM0rhapwqbQzta3OL7DIwpmV8riY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719449715; c=relaxed/simple;
	bh=WP9ph9eAke3h3Vx/GZVD/A5z0hYLMdiBCyuSnftEsM4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=aA9cx5erQPdNzz1uYY6x5U2sLJhU9eykptk38mzVi9HUafdzz2R8ihsjPYS22DRXdtXbvg3+5XYo4/dARgKRKXQmH1N8BvmWP6lHTZ8hW88TsM/tZQwjU1qlUoWaygjvuXLklpY8LSZVKjPAfT3Cegy3GFcLvVtK6bDiYYpil9U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=eiXixoTO; arc=fail smtp.client-ip=40.107.95.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SNcUpF88Y4rEAdYcsUr5Ib9KGWajskSOzBPzKlQidlJAyE425/ZuA7ivVpjxBU5rssvgjc4KnFlTiWWilc+7v4uA0AslTiTHid9mDVokDEByj/e3ICrHmLOwFWxy0QvxJgjQoH3yMgc1+v6IWlhcsHNsn6JZIyz9HhP8qpgbnSMrYmRcoVcmJEDf5RH1g+02nrLaeSLal29v8tVaw2HTLZdQC0F/Z+oaUiLqepA/GwmDKVlh+Md0uAEfu8VjQdNiMieTQY1vkbDpNDIc88NhWlGSPkLS7lRduJD2aVYc0S74xdxcGQ6g5l1Bj4A8r+ukJo5EN4vfZ5HSMwFThrFf1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y4HSHp37qCtA/VWcs3e6LcRoHar3qq9hdLZVRN2dDn0=;
 b=PebZMnc78+hTnDwnP7KzkSYmQRD6Vv0ag6sRha1e26PXwbdvS7SsLMClhZOkiSGMCHz9Y5xpvH1LTINiQ7PfFuMbHDnuBcFdOMz+/YA8C1OrWD92SPTWKlm0BTL1TY1mH6r0xGb3EV67jrH6uXp6NOXwDB4RKn8Hhbtmt4QysVRRRWRI4QvC44GVS0fhDyLthmomJBsx3r5ZWIrthOKE+Tdv8FHBY3J7xUOcasWDz7K0zbJVcYzwJcZGPDH6e3iMTDfCMYi5wl30vZx9/VaKvetTPYIpVnhrLHnKA+oy5oJ0x9l0VayymTl1QW79khnOyJdd7mplf0+KgGHPpz1TNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y4HSHp37qCtA/VWcs3e6LcRoHar3qq9hdLZVRN2dDn0=;
 b=eiXixoTOxfrJyf+EpoEiyPUuwDFOoY9CxumkHnCC/k661PJW8cbLDdghgXgOEJxQZ6pW6Dg0ZcOGwvaZkw6xJKrjxz5qtKuNKI5IgZOty0c8WqySLl/ww9dQvLW9fhzVdIHSdAq3jXqxvm38NocuNalIvvrQa9B9mWfuyt/kCHk7+x0cd1o0ASAobdL1gRWyQTxLGf1xEs1oTZCoSM6Yt5dBb364inHi7byzESFPlCZ0lWtNT5rRjSqjYSZCsS2HGNrPH7AaMbinAs1EFlR1BYByNCilCL6i91Ssz1D0W3m9hBI1fmp4oNAQkv3Sm2oaZgDN+kLPDyw3juGm4i5mAQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6) by
 MW6PR12MB7071.namprd12.prod.outlook.com (2603:10b6:303:238::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7698.32; Thu, 27 Jun 2024 00:55:10 +0000
Received: from DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe]) by DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe%6]) with mapi id 15.20.7698.025; Thu, 27 Jun 2024
 00:55:10 +0000
From: Alistair Popple <apopple@nvidia.com>
To: dan.j.williams@intel.com,
	vishal.l.verma@intel.com,
	dave.jiang@intel.com,
	logang@deltatee.com,
	bhelgaas@google.com,
	jack@suse.cz,
	jgg@ziepe.ca
Cc: catalin.marinas@arm.com,
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
	linux-mm@kvack.org,
	linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	jhubbard@nvidia.com,
	hch@lst.de,
	david@fromorbit.com,
	Alistair Popple <apopple@nvidia.com>
Subject: [PATCH 07/13] huge_memory: Allow mappings of PUD sized pages
Date: Thu, 27 Jun 2024 10:54:22 +1000
Message-ID: <bd332b0d3971b03152b3541f97470817c5147b51.1719386613.git-series.apopple@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.66009f59a7fe77320d413011386c3ae5c2ee82eb.1719386613.git-series.apopple@nvidia.com>
References: <cover.66009f59a7fe77320d413011386c3ae5c2ee82eb.1719386613.git-series.apopple@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SY8P300CA0020.AUSP300.PROD.OUTLOOK.COM
 (2603:10c6:10:29d::23) To DS0PR12MB7726.namprd12.prod.outlook.com
 (2603:10b6:8:130::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7726:EE_|MW6PR12MB7071:EE_
X-MS-Office365-Filtering-Correlation-Id: 98d895e4-4e19-4e64-caa8-08dc9643cb5d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/XEw5kcci8RbCOPgi6/1Mvc5Y+zu3BWglvtZhovBvLxdtQRFmQR4vmhXSe+l?=
 =?us-ascii?Q?E9VoqkOZIj1uG+qHLye/a1nDN6YKloB1AeXshqejjDQ8Q4LoLO/NqzwQl1Jd?=
 =?us-ascii?Q?W9VlIM6gEnTwSim19NeyMI0yJPPqzUStM56xdc2OEghfdrMl4a2GvEKSGkRH?=
 =?us-ascii?Q?HYmezUqa78O9hJiiQXv9YGz6IKNJJwb7VPyxOz9/SgZCY14rt3KgVtGVpIUq?=
 =?us-ascii?Q?9rFA4C6oiwn8LD06xouB/4DohStism9K/hqy/R4wFwU2Ob5uBKVIdt4O01we?=
 =?us-ascii?Q?NRzu22seyv+xqGymJwv9PHOHPaDX56B6Tf2N6MRg9Tj5bcmHSM9mgqKouX/m?=
 =?us-ascii?Q?+qV1qMKdO4I0z78xOEHFzjEKIUPyiMKlf6FnqH+EbnIOCzXX7kIpRkUdzvia?=
 =?us-ascii?Q?PkFZpWYMloOhFI6rSKDq1qR9GwtSPX83BFAsDKBsotqpY1sL90UGmMmrRf8R?=
 =?us-ascii?Q?hf7PsaXT2lf902kF3BHHUl9fANbpbI9oSdsOf0ZWdohZY0WqQ/c3Q/gl0T76?=
 =?us-ascii?Q?p65EDL/YU62i6t2eCCYaH4S5OO4RnHdz8wjAyXsyYuliSePw0aSl3txVX3YH?=
 =?us-ascii?Q?Aq7oX0DjJr0Ng+nS2WxbQnreMdSRp1AlRPuliXcF721zHbsGug4QLLstL55A?=
 =?us-ascii?Q?KStyl9CdtZaT7IECiB1PnjhDlovN5wdEqr7oxAF3onOFRYSfhDUOAyzd8Ub4?=
 =?us-ascii?Q?LMc+13W1N+si0qHtXBwsNTeHt/P08AzLvcd975n3SxuWP+Qv2t8zLv1wEOwW?=
 =?us-ascii?Q?rGGOnDPqDWTsZOdEYMnruE9clJGok3p2Hh68Ek2W0DnrK/fZRbydUgx08zQN?=
 =?us-ascii?Q?FnxcRb1x6h33FqqKgDjJCdmszvlXc9ITuUARu2gkwpgMvQ2oduXlf0nl1T77?=
 =?us-ascii?Q?1Hv7L2YNFYKSh56IZ9bKGyY5FL6bCNpRcTg5k1Afj5LD3FyjmqHv/m9ycTl4?=
 =?us-ascii?Q?e6UOXhAA5GHFZ6YShytKHEA1x68dAFKR6POKyVXJf97xMVvMjcwjRXEsR5/I?=
 =?us-ascii?Q?4WzxVk4+vvmzyG7WHgt6/Ha3uztDhBh8ZxxFGp7EwxFB7xbjIynvAXpKCacO?=
 =?us-ascii?Q?W+MV83AOc4U9FeB8TK9NrCdSRLziAQl4u1n2zxbilyHdFLYrgMwcjL9JmGlT?=
 =?us-ascii?Q?oGDIRYk78gYBSxGmXWrIOIHGjaUH98/Nd35EUG9t2ZtVZU+1WRdkkC3KE1Qj?=
 =?us-ascii?Q?1mlBM7M7y2rcKlJJl8HSy5wOg4wk8kLVHgQotxVPmDkKtBTDm872PW6EXYMk?=
 =?us-ascii?Q?UoykPlpozw53jtHE79xxqgCKPI0Vr2f4cWV3cIuUmSukyQdeLWTecbtzz1uE?=
 =?us-ascii?Q?Bkh5vNJFIo7DZLfwL8l2As4th0M1MvnJnklMn54owHdzsQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7726.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+/eZJhitVNCiazNaxxAnhP/Z7GJqM6EbedzvKe83MOHIuZsliHfWejaAQ406?=
 =?us-ascii?Q?sSkmJNne0zRA6MW94stsDybWirIF2m2nMBR9hSXTCzHZEA2eb9lqTFB/0xay?=
 =?us-ascii?Q?ODYRRD7f7QkFNgbRCf+TZ61834uHfcaDGkYMBNjUX20jOEL4YEqbPjltnjt1?=
 =?us-ascii?Q?DY1uuewIKXoRquh+Uz2lPxOjT+0UxgABY9HbSQY+oUQwAP4szecHdEwBe53p?=
 =?us-ascii?Q?lr09Gh3BiCWtk5fXTEvUTeQQLj+lt9Z5uZG6x3V+33HEa8HOPGahCgoskcAK?=
 =?us-ascii?Q?Z8SIzA77lwCUu93SDPgXBS0C5QWjIx8XAFr65LjUXU8148XD9aHgGMzp7/6l?=
 =?us-ascii?Q?iUA+Zz4/Lz7U9xLR76AYGx0W5XZBmY42LzxS5dqnLJhulo5Q/sDGRWNdC0lo?=
 =?us-ascii?Q?AjMIomqjvfz7uA7YAe4S5FQ0IAj7mb8lgdCoAGol3Jdsr/63ChIVez/7GqeS?=
 =?us-ascii?Q?5z8jO788myEHYpxFD6DpmGaIw+kpVUceUYPCvnN9vPAwgysXr8WIkxiNb3eG?=
 =?us-ascii?Q?QCWK0rLanBUjumHl2VM/KJyh1yeh6KcLq8IKEedBNWUecoeeJ/tpLgaj2Lgp?=
 =?us-ascii?Q?Ggt+yCCTMHWuTtOHVRuNzRQcD1Q3uII8WCu6C4/Iltwp3skHjj6K9mpLVyee?=
 =?us-ascii?Q?VXeMpsDMgRJ5TfSdZnPvxnRQp3JjD4syLthrDVz9cvWpWxlhCZLAjFmiJc8+?=
 =?us-ascii?Q?ZY9fLSGKlkmAgQG/ycVNe1vuEJ8Esd+F3rXm062Ktm1JYREOjRAG0aZKgyiE?=
 =?us-ascii?Q?WXCnZk1+XLsy8C+WUhgHwNsJv7jzLMUVO/jJfKIcL3T9reqKCMqxzxNjE7Dc?=
 =?us-ascii?Q?IQIEV1NpJ6iYAEjWPgBGoZkh3zNXvaDqH3LDb4UxpeUJfhQqc727tTyAaTfO?=
 =?us-ascii?Q?fHSHkEKES882G46T1MfbrOWThs43k9yMpgyxCNQg4wLryLu9DkDyMSoIG5qm?=
 =?us-ascii?Q?xLTK6GyIoL/DmaEqEsMAlqfSIYv1V+Jw0KSn1JLeKRyWshzpLUTiGKpoWnyR?=
 =?us-ascii?Q?80acwrOtZB9xoh44kmjo9Z452hp/j/w9Kd0I98GJ0U8udzklAWMKbSG9H6Bm?=
 =?us-ascii?Q?vwi9nRDJ4fhIUw9m47ohBC3+pyUYfi+w+oNMdP8lhUaa4dFf9WErcxfjLeMR?=
 =?us-ascii?Q?Eaj07vMtwvyGcUivIiPtiDe/CwV5ArIm7jG9mq7dDoEicu6p6wI89mz09sXd?=
 =?us-ascii?Q?mYAuc087L0VUf5d5Nk7Ud+3jAZOwpviB6c7rundMoZKNsinxayQiwbV24mZW?=
 =?us-ascii?Q?vMlKT/+rBhrtLpurRxycQMYRCqxDJPGDtjAwEaChBMRKREFjeYpRTQt3xdsP?=
 =?us-ascii?Q?EiwBQDVh5gGDwoIBI9Pjxb+BA4sWJEQwJZnW/WOR2OD4MvDzfS4R6qW6TNvc?=
 =?us-ascii?Q?2OtjlBeY8Xinf2DcsUNTx9UkAMSRaNdE0UhnbdRGEc4f6jl0Zsgilj/U848P?=
 =?us-ascii?Q?ms8jSTDTbsh7IGoqoEDHP+7hdOdGvQe6B04c0TxBkFEsSYy0c9UVJlXHjHlP?=
 =?us-ascii?Q?3EjHkNy1Sw4JTwM0ivZkR+dpm0xMaNOtIp3T/DBRfqdfBdgsVxG61gbTqB3T?=
 =?us-ascii?Q?3tTziqwR/ZdT2TdAPOg2Mnod7PRVb5hwTN5i9jn2?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98d895e4-4e19-4e64-caa8-08dc9643cb5d
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7726.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2024 00:55:10.0152
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BYfcMwGOWBQA08pLBQl0N8W+2bB167QZ2Zrzqkta3KCKs36XsnVDKHI6RNdt8zy5VzjYil5I34xcOHdHl4Dltw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB7071

Currently DAX folio/page reference counts are managed differently to
normal pages. To allow these to be managed the same as normal pages
introduce dax_insert_pfn_pud. This will map the entire PUD-sized folio
and take references as it would for a normally mapped page.

This is distinct from the current mechanism, vmf_insert_pfn_pud, which
simply inserts a special devmap PUD entry into the page table without
holding a reference to the page for the mapping.

Signed-off-by: Alistair Popple <apopple@nvidia.com>
---
 include/linux/huge_mm.h |   4 ++-
 include/linux/rmap.h    |  14 +++++-
 mm/huge_memory.c        | 108 ++++++++++++++++++++++++++++++++++++++---
 mm/rmap.c               |  48 ++++++++++++++++++-
 4 files changed, 168 insertions(+), 6 deletions(-)

diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index 2aa986a..b98a3cc 100644
--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -39,6 +39,7 @@ int change_huge_pmd(struct mmu_gather *tlb, struct vm_area_struct *vma,
 
 vm_fault_t vmf_insert_pfn_pmd(struct vm_fault *vmf, pfn_t pfn, bool write);
 vm_fault_t vmf_insert_pfn_pud(struct vm_fault *vmf, pfn_t pfn, bool write);
+vm_fault_t dax_insert_pfn_pud(struct vm_fault *vmf, pfn_t pfn, bool write);
 
 enum transparent_hugepage_flag {
 	TRANSPARENT_HUGEPAGE_UNSUPPORTED,
@@ -106,6 +107,9 @@ extern struct kobj_attribute shmem_enabled_attr;
 #define HPAGE_PUD_MASK	(~(HPAGE_PUD_SIZE - 1))
 #define HPAGE_PUD_SIZE	((1UL) << HPAGE_PUD_SHIFT)
 
+#define HPAGE_PUD_ORDER (HPAGE_PUD_SHIFT-PAGE_SHIFT)
+#define HPAGE_PUD_NR (1<<HPAGE_PUD_ORDER)
+
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
 
 extern unsigned long transparent_hugepage_flags;
diff --git a/include/linux/rmap.h b/include/linux/rmap.h
index 7229b9b..c5a0205 100644
--- a/include/linux/rmap.h
+++ b/include/linux/rmap.h
@@ -192,6 +192,7 @@ typedef int __bitwise rmap_t;
 enum rmap_level {
 	RMAP_LEVEL_PTE = 0,
 	RMAP_LEVEL_PMD,
+	RMAP_LEVEL_PUD,
 };
 
 static inline void __folio_rmap_sanity_checks(struct folio *folio,
@@ -225,6 +226,13 @@ static inline void __folio_rmap_sanity_checks(struct folio *folio,
 		VM_WARN_ON_FOLIO(folio_nr_pages(folio) != HPAGE_PMD_NR, folio);
 		VM_WARN_ON_FOLIO(nr_pages != HPAGE_PMD_NR, folio);
 		break;
+	case RMAP_LEVEL_PUD:
+		/*
+		 * Asume that we are creating * a single "entire" mapping of the folio.
+		 */
+		VM_WARN_ON_FOLIO(folio_nr_pages(folio) != HPAGE_PUD_NR, folio);
+		VM_WARN_ON_FOLIO(nr_pages != HPAGE_PUD_NR, folio);
+		break;
 	default:
 		VM_WARN_ON_ONCE(true);
 	}
@@ -248,12 +256,16 @@ void folio_add_file_rmap_ptes(struct folio *, struct page *, int nr_pages,
 	folio_add_file_rmap_ptes(folio, page, 1, vma)
 void folio_add_file_rmap_pmd(struct folio *, struct page *,
 		struct vm_area_struct *);
+void folio_add_file_rmap_pud(struct folio *, struct page *,
+		struct vm_area_struct *);
 void folio_remove_rmap_ptes(struct folio *, struct page *, int nr_pages,
 		struct vm_area_struct *);
 #define folio_remove_rmap_pte(folio, page, vma) \
 	folio_remove_rmap_ptes(folio, page, 1, vma)
 void folio_remove_rmap_pmd(struct folio *, struct page *,
 		struct vm_area_struct *);
+void folio_remove_rmap_pud(struct folio *, struct page *,
+		struct vm_area_struct *);
 
 void hugetlb_add_anon_rmap(struct folio *, struct vm_area_struct *,
 		unsigned long address, rmap_t flags);
@@ -338,6 +350,7 @@ static __always_inline void __folio_dup_file_rmap(struct folio *folio,
 		atomic_add(orig_nr_pages, &folio->_large_mapcount);
 		break;
 	case RMAP_LEVEL_PMD:
+	case RMAP_LEVEL_PUD:
 		atomic_inc(&folio->_entire_mapcount);
 		atomic_inc(&folio->_large_mapcount);
 		break;
@@ -434,6 +447,7 @@ static __always_inline int __folio_try_dup_anon_rmap(struct folio *folio,
 		atomic_add(orig_nr_pages, &folio->_large_mapcount);
 		break;
 	case RMAP_LEVEL_PMD:
+	case RMAP_LEVEL_PUD:
 		if (PageAnonExclusive(page)) {
 			if (unlikely(maybe_pinned))
 				return -EBUSY;
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index db7946a..e1f053e 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1283,6 +1283,70 @@ vm_fault_t vmf_insert_pfn_pud(struct vm_fault *vmf, pfn_t pfn, bool write)
 	return VM_FAULT_NOPAGE;
 }
 EXPORT_SYMBOL_GPL(vmf_insert_pfn_pud);
+
+/**
+ * dax_insert_pfn_pud - insert a pud size pfn backed by a normal page
+ * @vmf: Structure describing the fault
+ * @pfn: pfn of the page to insert
+ * @write: whether it's a write fault
+ *
+ * Return: vm_fault_t value.
+ */
+vm_fault_t dax_insert_pfn_pud(struct vm_fault *vmf, pfn_t pfn, bool write)
+{
+	struct vm_area_struct *vma = vmf->vma;
+	unsigned long addr = vmf->address & PUD_MASK;
+	pud_t *pud = vmf->pud;
+	pgprot_t prot = vma->vm_page_prot;
+	struct mm_struct *mm = vma->vm_mm;
+	pud_t entry;
+	spinlock_t *ptl;
+	struct folio *folio;
+	struct page *page;
+
+	if (addr < vma->vm_start || addr >= vma->vm_end)
+		return VM_FAULT_SIGBUS;
+
+	track_pfn_insert(vma, &prot, pfn);
+
+	ptl = pud_lock(mm, pud);
+	if (!pud_none(*pud)) {
+		if (write) {
+			if (pud_pfn(*pud) != pfn_t_to_pfn(pfn)) {
+				WARN_ON_ONCE(!is_huge_zero_pud(*pud));
+				goto out_unlock;
+			}
+			entry = pud_mkyoung(*pud);
+			entry = maybe_pud_mkwrite(pud_mkdirty(entry), vma);
+			if (pudp_set_access_flags(vma, addr, pud, entry, 1))
+				update_mmu_cache_pud(vma, addr, pud);
+		}
+		goto out_unlock;
+	}
+
+	entry = pud_mkhuge(pfn_t_pud(pfn, prot));
+	if (pfn_t_devmap(pfn))
+		entry = pud_mkdevmap(entry);
+	if (write) {
+		entry = pud_mkyoung(pud_mkdirty(entry));
+		entry = maybe_pud_mkwrite(entry, vma);
+	}
+
+	page = pfn_t_to_page(pfn);
+	folio = page_folio(page);
+	folio_get(folio);
+	folio_add_file_rmap_pud(folio, page, vma);
+	add_mm_counter(mm, mm_counter_file(folio), HPAGE_PUD_NR);
+
+	set_pud_at(mm, addr, pud, entry);
+	update_mmu_cache_pud(vma, addr, pud);
+
+out_unlock:
+	spin_unlock(ptl);
+
+	return VM_FAULT_NOPAGE;
+}
+EXPORT_SYMBOL_GPL(dax_insert_pfn_pud);
 #endif /* CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD */
 
 void touch_pmd(struct vm_area_struct *vma, unsigned long addr,
@@ -1836,7 +1900,8 @@ int zap_huge_pmd(struct mmu_gather *tlb, struct vm_area_struct *vma,
 			zap_deposited_table(tlb->mm, pmd);
 		spin_unlock(ptl);
 	} else if (is_huge_zero_pmd(orig_pmd)) {
-		zap_deposited_table(tlb->mm, pmd);
+		if (!vma_is_dax(vma) || arch_needs_pgtable_deposit())
+			zap_deposited_table(tlb->mm, pmd);
 		spin_unlock(ptl);
 	} else {
 		struct folio *folio = NULL;
@@ -2268,20 +2333,34 @@ spinlock_t *__pud_trans_huge_lock(pud_t *pud, struct vm_area_struct *vma)
 int zap_huge_pud(struct mmu_gather *tlb, struct vm_area_struct *vma,
 		 pud_t *pud, unsigned long addr)
 {
+	pud_t orig_pud;
 	spinlock_t *ptl;
 
 	ptl = __pud_trans_huge_lock(pud, vma);
 	if (!ptl)
 		return 0;
 
-	pudp_huge_get_and_clear_full(vma, addr, pud, tlb->fullmm);
+	orig_pud = pudp_huge_get_and_clear_full(vma, addr, pud, tlb->fullmm);
 	tlb_remove_pud_tlb_entry(tlb, pud, addr);
-	if (vma_is_special_huge(vma)) {
+	if (!vma_is_dax(vma) && vma_is_special_huge(vma)) {
 		spin_unlock(ptl);
 		/* No zero page support yet */
 	} else {
-		/* No support for anonymous PUD pages yet */
-		BUG();
+		struct page *page = NULL;
+		struct folio *folio;
+
+		/* No support for anonymous PUD pages or migration yet */
+		BUG_ON(vma_is_anonymous(vma) || !pud_present(orig_pud));
+
+		page = pud_page(orig_pud);
+		folio = page_folio(page);
+		folio_remove_rmap_pud(folio, page, vma);
+		VM_BUG_ON_PAGE(page_mapcount(page) < 0, page);
+		VM_BUG_ON_PAGE(!PageHead(page), page);
+		add_mm_counter(tlb->mm, mm_counter_file(folio), -HPAGE_PUD_NR);
+
+		spin_unlock(ptl);
+		tlb_remove_page_size(tlb, page, HPAGE_PUD_SIZE);
 	}
 	return 1;
 }
@@ -2289,6 +2368,8 @@ int zap_huge_pud(struct mmu_gather *tlb, struct vm_area_struct *vma,
 static void __split_huge_pud_locked(struct vm_area_struct *vma, pud_t *pud,
 		unsigned long haddr)
 {
+	pud_t old_pud;
+
 	VM_BUG_ON(haddr & ~HPAGE_PUD_MASK);
 	VM_BUG_ON_VMA(vma->vm_start > haddr, vma);
 	VM_BUG_ON_VMA(vma->vm_end < haddr + HPAGE_PUD_SIZE, vma);
@@ -2296,7 +2377,22 @@ static void __split_huge_pud_locked(struct vm_area_struct *vma, pud_t *pud,
 
 	count_vm_event(THP_SPLIT_PUD);
 
-	pudp_huge_clear_flush(vma, haddr, pud);
+	old_pud = pudp_huge_clear_flush(vma, haddr, pud);
+	if (is_huge_zero_pud(old_pud))
+		return;
+
+	if (vma_is_dax(vma)) {
+		struct page *page = pud_page(old_pud);
+		struct folio *folio = page_folio(page);
+
+		if (!folio_test_dirty(folio) && pud_dirty(old_pud))
+			folio_mark_dirty(folio);
+		if (!folio_test_referenced(folio) && pud_young(old_pud))
+			folio_set_referenced(folio);
+		folio_remove_rmap_pud(folio, page, vma);
+		folio_put(folio);
+		add_mm_counter(vma->vm_mm, mm_counter_file(folio), -HPAGE_PUD_NR);
+	}
 }
 
 void __split_huge_pud(struct vm_area_struct *vma, pud_t *pud,
diff --git a/mm/rmap.c b/mm/rmap.c
index e8fc5ec..e949e4f 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -1165,6 +1165,7 @@ static __always_inline unsigned int __folio_add_rmap(struct folio *folio,
 		atomic_add(orig_nr_pages, &folio->_large_mapcount);
 		break;
 	case RMAP_LEVEL_PMD:
+	case RMAP_LEVEL_PUD:
 		first = atomic_inc_and_test(&folio->_entire_mapcount);
 		if (first) {
 			nr = atomic_add_return_relaxed(ENTIRELY_MAPPED, mapped);
@@ -1306,6 +1307,12 @@ static __always_inline void __folio_add_anon_rmap(struct folio *folio,
 		case RMAP_LEVEL_PMD:
 			SetPageAnonExclusive(page);
 			break;
+		case RMAP_LEVEL_PUD:
+			/*
+			 * Keep the compiler happy, we don't support anonymous PUD mappings.
+			 */
+			WARN_ON_ONCE(1);
+			break;
 		}
 	}
 	for (i = 0; i < nr_pages; i++) {
@@ -1489,6 +1496,26 @@ void folio_add_file_rmap_pmd(struct folio *folio, struct page *page,
 #endif
 }
 
+/**
+ * folio_add_file_rmap_pud - add a PUD mapping to a page range of a folio
+ * @folio:	The folio to add the mapping to
+ * @page:	The first page to add
+ * @vma:	The vm area in which the mapping is added
+ *
+ * The page range of the folio is defined by [page, page + HPAGE_PUD_NR)
+ *
+ * The caller needs to hold the page table lock.
+ */
+void folio_add_file_rmap_pud(struct folio *folio, struct page *page,
+		struct vm_area_struct *vma)
+{
+#ifdef CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD
+	__folio_add_file_rmap(folio, page, HPAGE_PUD_NR, vma, RMAP_LEVEL_PUD);
+#else
+	WARN_ON_ONCE(true);
+#endif
+}
+
 static __always_inline void __folio_remove_rmap(struct folio *folio,
 		struct page *page, int nr_pages, struct vm_area_struct *vma,
 		enum rmap_level level)
@@ -1521,6 +1548,7 @@ static __always_inline void __folio_remove_rmap(struct folio *folio,
 		partially_mapped = nr && atomic_read(mapped);
 		break;
 	case RMAP_LEVEL_PMD:
+	case RMAP_LEVEL_PUD:
 		atomic_dec(&folio->_large_mapcount);
 		last = atomic_add_negative(-1, &folio->_entire_mapcount);
 		if (last) {
@@ -1615,6 +1643,26 @@ void folio_remove_rmap_pmd(struct folio *folio, struct page *page,
 #endif
 }
 
+/**
+ * folio_remove_rmap_pud - remove a PUD mapping from a page range of a folio
+ * @folio:	The folio to remove the mapping from
+ * @page:	The first page to remove
+ * @vma:	The vm area from which the mapping is removed
+ *
+ * The page range of the folio is defined by [page, page + HPAGE_PUD_NR)
+ *
+ * The caller needs to hold the page table lock.
+ */
+void folio_remove_rmap_pud(struct folio *folio, struct page *page,
+		struct vm_area_struct *vma)
+{
+#ifdef CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD
+	__folio_remove_rmap(folio, page, HPAGE_PUD_NR, vma, RMAP_LEVEL_PUD);
+#else
+	WARN_ON_ONCE(true);
+#endif
+}
+
 /*
  * @arg: enum ttu_flags will be passed to this argument
  */
-- 
git-series 0.9.1

