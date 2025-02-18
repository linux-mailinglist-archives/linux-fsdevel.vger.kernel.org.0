Return-Path: <linux-fsdevel+bounces-41917-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8A42A391B4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Feb 2025 04:58:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE060163E96
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Feb 2025 03:58:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAD091BEF97;
	Tue, 18 Feb 2025 03:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="qRwSeiW1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2049.outbound.protection.outlook.com [40.107.236.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 523371B6D1C;
	Tue, 18 Feb 2025 03:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739850991; cv=fail; b=dEYaWp/H1WOYb7c+FK67ivM/jlYfHc0RpAA+iWhxpg192IzUekKoG1284p9G46JGGug9+XI6bmqx6YFdet1HaoPOw0aw3vQFrwSOct/H8vrTfrzBUyfHHFvgKr5F9V9iQwIlaTUrBq0ypPFImyQsn8qyAFQO/gzmRR+8NoujW+g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739850991; c=relaxed/simple;
	bh=ZFl0bMSvkYnGwGxulzK2Wx03/HzXumTTTPwKcq3OAEc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XW7UeF0/0ksOJvODS56SouX+11cHUKJEMoTXsQnjr9F5GoYzG4QUYfHGGeDkgeGCZB2ygSNy0hv1IujvcI71xqgCPYgpQ6TpRG4RJ2lJzSwljhZiJ+yRQD+AGpI0pSNrhrnhMGHEesLXf3ChxPXLLe6oCW/Kq5bWeZdzNxB6OY0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=qRwSeiW1; arc=fail smtp.client-ip=40.107.236.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j6tXNo1JAz2ABbsAJ7s6uxWpWvPaHsSLLeaVZk7JVE1M9EJsk1YtYkdHHNpE1B3KHWO6Vvsov8PbTuWVfeHfWDDGIwvX9f0F06Jjrzq5kVNrnMDdUVI1gOiGG4S1nwRNlcGHb9IJKmMq+uT0EsRXNtOQL0eDinqzK3M28WdH4baRa88vosaiPU1iCNmwYjzWAMCTSdPgOjz+ecUhGZ/Dbf2eU9h+De7S7WaW8r5HNpaWjU4rdE22bW6yDLQ+9ah9N94VxI83wvCporh7BsEiV+lQwxWe0ifqWse+HVotj1h+WkLXf1WNNb3Wfi/q+fDbDsJrWpSEWu8Y7ckKL5BZHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9tvVmUd8MTa61zBY6TluXmKwkBsI5wuLIycCgCcsc2Q=;
 b=k8lQgavUv5pFUoOAvLxw348bp8wPj68ZPLqqQwZeJkCOIYdap5Kwdgv7qfF1eKxmWCUkiUg1+48t+E2hlvsFR127CeWP0EjFjWjC4XE1X0G3R3sRdJ2yJaxaiTtJSl6emNcToKOf7rEjHWOCEudQUr4D/xI+eg/MaiIj+wNU/eJNRFvM0JNN/fLcFhY3gK1MTCnZFFSTIGL4fcrY9zBrNfEhbh7Eyg48zQEa0E+FAkVkJoT6a3vTthjL0w3YHiV5M5h9yBSCPacV3HINKaU1sNISDXsOG2qRF1QTBP3YuoHrlAI/ycyRLxY1+Oo5IC44K+KLmjHbPDI6CGiK23tqpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9tvVmUd8MTa61zBY6TluXmKwkBsI5wuLIycCgCcsc2Q=;
 b=qRwSeiW1hQQbWdP5e76p3eybbckwAjsqbnSwMhmvrP+BNbTAoCsG+P7btnZ3Q+Ex1SOle+KMTbv0xWOLVDTQljBSPmaY6vSOyfXUjNSAwH22sCy3V5SKYo69YP338064AfI4VNlIaJtuIBSU1wH6NYRQSOG5V/ReaNx4hHBN3a191QR21Cnw3AAlkM7eXPft26dzkIaRHvNJEflyTw9QvCNkdMh5skltKeQbNZwvxgrw7Kq/s8Pn730wmSSYCRxmKok0H2yoCBMslvSHGJnbmUoDqHrvsFOw5HygoRCjMedlwwfH/3EneFBzBPPfXu/J6OCvPAyP0LC7AshgTua86A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6) by
 CH3PR12MB7593.namprd12.prod.outlook.com (2603:10b6:610:141::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.19; Tue, 18 Feb
 2025 03:56:25 +0000
Received: from DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe]) by DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe%7]) with mapi id 15.20.8445.017; Tue, 18 Feb 2025
 03:56:25 +0000
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
Subject: [PATCH v8 07/20] fs/dax: Ensure all pages are idle prior to filesystem unmount
Date: Tue, 18 Feb 2025 14:55:23 +1100
Message-ID: <2d3cf575bbd095084993154be2f0aa7442e5cd28.1739850794.git-series.apopple@nvidia.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.a782e309b1328f961da88abddbbc48e5b4579021.1739850794.git-series.apopple@nvidia.com>
References: <cover.a782e309b1328f961da88abddbbc48e5b4579021.1739850794.git-series.apopple@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SY6PR01CA0140.ausprd01.prod.outlook.com
 (2603:10c6:10:1b9::15) To DS0PR12MB7726.namprd12.prod.outlook.com
 (2603:10b6:8:130::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7726:EE_|CH3PR12MB7593:EE_
X-MS-Office365-Filtering-Correlation-Id: 9347dcfc-8b9a-4d99-c5df-08dd4fd03729
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?EjpSiqSrY6xJe6K6tKhAihGyRZm2LPyogubHX9MBm2S8idt6bu87pZvcrY40?=
 =?us-ascii?Q?ZClQ4CYR+xkB7WHzb+Oj5Eyw9RXrdtcrZe642o6YwkpZsoej7N3sj+BUF9rA?=
 =?us-ascii?Q?nfWZKfR2URmxdqBZ09ixE7qkDjZ27grGzdlBCDj0cG/dj2P+Ny/Uu0vEf8KV?=
 =?us-ascii?Q?4WYm/iktwBX229yaMC/gddU/3sHCepqj3FFWmGQ9fASCfwOhcrg1EcWMgItP?=
 =?us-ascii?Q?rtid2Z/98onysv51OZM/Xc2e4ethzSJvtJQLwAum4zxVqkx1E+OX6kpWUOVc?=
 =?us-ascii?Q?0fToxTT3vIYaF4DtDYQ1Ivbm2OeGIwK6o2Atikx9m4C286Mr4Nclikbi//kv?=
 =?us-ascii?Q?QCGt2lcw13iNqOahXZXEZbjROzk9Puc01PoBoxUzcpXPpIeiRYZqUyYxxwyM?=
 =?us-ascii?Q?TdRcmsqWXUA+HBX3Q7uuekKu/+gF/T1uyWi4GpfzgTyc4ZqYHbTofrXVhryF?=
 =?us-ascii?Q?l8kUcfZmzDKxHQ/2w5q4146AGTCphCsJvH0s758WasGQSNviA52oQAVVm9nJ?=
 =?us-ascii?Q?p7AXGJoz+lz+etQl7RnZyxG9F25t+X2MCX6tBTU778eQJArPW7OaVkZ9ae/+?=
 =?us-ascii?Q?Al8ApXM1flNAeSA1oZaT6p3MtW2p+DgkTty6aw3LVw3D+u+nel0syua/f4P6?=
 =?us-ascii?Q?dF2wSC+RKBemw5sQ+ltbTkgDZzDzNWI73q/xjlj9u3TKhTWj4QrOHU8XYLLb?=
 =?us-ascii?Q?LGX7dFe7WSJXW9pnu8t5vtyTFTNNcOZQZgoD5PQqydKWoZ2i8EBJuzxP0UgP?=
 =?us-ascii?Q?MU6MOEC2N/cCM8TtvCdDQzGWRTYq9NvlQdCHpG75RrEZGGcXxxKc5RUCQoGE?=
 =?us-ascii?Q?fP4bfButw3Wp+og7wZEqtq/30IDcVlYsnQQONXWuRmH6IAcTPUG2fvYLivzq?=
 =?us-ascii?Q?J8LOHCpmJY5S1BcJDF7c8iiCBq/hh4Lp6v+sqz4msbce16NCx5afHAH0QCwz?=
 =?us-ascii?Q?pGlpdGlj/PvDTrB6hu6zozq+X2IXRyvTq7NyIh48D3wYw3qJs0Lc2HYX3rOd?=
 =?us-ascii?Q?te5ONTDkVsTO1KlDBpKVdd/uhYbGWeR/givpAcRAkDiAS3l3BU06BVVnEK2a?=
 =?us-ascii?Q?rwmA7XPQM0fOilV7RCvXoaFg++tYgyFBAz1VbjBgBsvYj7DhkbInIiYaZwX+?=
 =?us-ascii?Q?+9mjMGYMUn6Jf7Q/1+3UgqoypbjZdJikKinAJDmv6nRpKdglwU+X64ZOct1a?=
 =?us-ascii?Q?vVLFuBpkg+44ZTcemtfgNlpIzTHnSx6niGG2q1DfTD/ouvWJw9SWRkHMoRXI?=
 =?us-ascii?Q?pSmohFXhm3lC6jrPhOnObyqb6h3zG/0SSJO9rLfeAIi9JrGO+9Bf1sScLx+V?=
 =?us-ascii?Q?ggP8weWIpiVwVlEmBHFcVnfqp05Z6my1boZmQvPGeipESZPtAhHW1Tm2L4Y9?=
 =?us-ascii?Q?zqGpg42JfSoNjjKFOFKX2ZAQ0t21?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7726.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2Z4gVizkErRuq+LLVsdgVduoPVwW69hz/Enj0UxQ/RsFJy7M4mWCnuLe/LUB?=
 =?us-ascii?Q?5hFOIaqYKsrgNfuO6LGzEL97aMPna9bTu6pOuhbvyBh94itJTBjJmgHDo3jQ?=
 =?us-ascii?Q?1C0OZc02U8mFV/kwWygjDos3tI3AFtNNyJePWLiozQSo7PkHKwlbpNZuvbgD?=
 =?us-ascii?Q?6t18idPqFvZzPAkXXY0dANT/lyrJbqsT9tgE7VdxhDMtIxe+h0a++oMtrLjN?=
 =?us-ascii?Q?5yKrIWeQBZBRFT48C2tQq8dbupsoxsIULm1UEqhwdbUWQV66Tkr06zyBGCZs?=
 =?us-ascii?Q?ky2X3at0X6XQfiO70Puvdf0T3+30UkH+LV2eJzq6NnpE+Cj/Xrbazk2MKrV+?=
 =?us-ascii?Q?Jo+BqtHs80YaufA9j/JYyS1n1EMlRsJCFQodb6MvADaebhH7qET6eyk15iZO?=
 =?us-ascii?Q?EVX98q3oSbof+zsOUmQJjp+WtSRKZ2XH5uwJSi2hew/uZOTDbImnHXgT3TNL?=
 =?us-ascii?Q?K0LJDv+haqbL57LhdPiiMK7mETyc6m9JYMdp8rQYvjwa2LqpoWH9LvgM4wdW?=
 =?us-ascii?Q?krRRfjLluPzZMieEG6XF6F9c6VXufn1kjlbEsyfSq54aL6xEjwtkLnYcOZOH?=
 =?us-ascii?Q?UgLrFm2QwNxejZX96/VstL3X+2hj/xAiYrrltwYD/HnA+wC/q6WYGRLOG+6w?=
 =?us-ascii?Q?OG37eDknzfCtLOhTbg2930vLORdZcM17m5Ul9oLHZ8SNk3i6qv2UWbnR70s+?=
 =?us-ascii?Q?pwGMZejUBRWj3R5Y0SlHW/srsGM6a1iuNtM780mM9cplH+xvhNkRIR1SyVOW?=
 =?us-ascii?Q?/mGMjzHkuFpYsmKJcP2coCRJj03Yf8BcMMAtwN/oPA8jbjrel9v+UWh+iuNG?=
 =?us-ascii?Q?Z9NMqg4l0iusparbbg9GDDibqC4erpzuPUyZ0o/UFYZDvCJuXrsS/Z0RgFjR?=
 =?us-ascii?Q?T/7T/5KcPX2MJbpGTbhDLVkFqzYKUyEGXowW4FhCH0nd8ZWLfKsKX5v5Nlxz?=
 =?us-ascii?Q?FDxNVOmwDzbkyKwjIOUnixYIHwDpBTJcx8g1c6vqS6tv6wJMccd4pr99IKDK?=
 =?us-ascii?Q?nnfE6JF0vRp4sWH8YKfBokEj4oQ9+j1SB/38FXo35gNZYU+3JKCVo2LtNfYR?=
 =?us-ascii?Q?gfeKnfBvcRoX9NsLtswlHgtNAx6N64aVYNcWZHArT/QnBXsAH2KIcGOg/yTF?=
 =?us-ascii?Q?IxNQJpUqnTGe0S6FDUpacP0h1qKe6WdrF2a6GzXJyBkJErlBi9lnJNH3DOYB?=
 =?us-ascii?Q?FzKc31S9QrWTb5PEs5+9H0GCKucZjOA+PTWmdu8TiT/4HSvUatGbVha/Xnf7?=
 =?us-ascii?Q?gM0EgWD4lrdG5qGewZcnYLyfZDxED8vIMVlVtKJoELuJ/T6vq5DPasj6Aqkm?=
 =?us-ascii?Q?zXlipAo+YwWfqO+xpeVjUFXVwHNqzgmZfpQ4xzCupQyCfULD8ySzsEfvy9WD?=
 =?us-ascii?Q?bgf08dYjOUS9Q4e+byvYEH0AEjJW0PSitlVOdVaoLgt3Z1ENctyVyM6cILF5?=
 =?us-ascii?Q?ByUxbeq7rA+D1XskUkMc35KFKj3Em/PYdBzlAIxnLCuWroNGTf9uKJ5eNIlU?=
 =?us-ascii?Q?uO28rweOkSYuBDK0ZRe/hfaRpVbIvKP+mPPPPmmQZw8/NaIymtnXqXMViL8f?=
 =?us-ascii?Q?UjbRbhlBXBLW7qUDVN5ipaXdFhKelB/zn34z264N?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9347dcfc-8b9a-4d99-c5df-08dd4fd03729
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7726.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2025 03:56:25.6611
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3nn7A9KsOFW+Y9PY1nQ8+q0G9YjrF9F9NA4bRcNhDmCGtObJkGeru2hVuhPHl2C0BnnaYgxXtBwXhVzemlV1BQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7593

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
index 14fbe51..bc538ba 100644
--- a/fs/dax.c
+++ b/fs/dax.c
@@ -884,6 +884,13 @@ static int wait_page_idle(struct page *page,
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
@@ -919,6 +926,26 @@ int dax_break_layout(struct inode *inode, loff_t start, loff_t end,
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

