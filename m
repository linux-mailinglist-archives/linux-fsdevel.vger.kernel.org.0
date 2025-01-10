Return-Path: <linux-fsdevel+bounces-38806-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 740DCA08726
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Jan 2025 07:01:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 251A11889ED2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Jan 2025 06:01:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6616A206F06;
	Fri, 10 Jan 2025 06:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="N431crZq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2049.outbound.protection.outlook.com [40.107.100.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2648E1AB6C8;
	Fri, 10 Jan 2025 06:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736488883; cv=fail; b=MGyWPR+5mCTdMY5WiF5VObgqEwLueRQOaXUbpt9JyriL49dFj4hDQG9Sf8KMCDRGPvxTTXMavczY1b0hsURM5KpqtN6fmNV6G4X2YsPM2hqZlDF8MRxl6xS+GukYloTj8/05OS7nCH93LDVfqUrJR8a0W8uCHTWWEVoROAwR8Co=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736488883; c=relaxed/simple;
	bh=iBEJMQGCBWTQisMeMLBm0jp4CfdSHYCL8TMgjVAUyxg=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=fGAglYMDi73QqtiHx16i1GHi6ER78s2AeSgyXmqQAwlqFSlJIj2e3j4fDBJ2ZxwYvCUWfmBX2pcYGR1c0Z9Bqp35l3B/5NfJot/PbIwaxHlKQVol/lVJOU1Ltf5o54/6IeRKBMGeN5e8AFQK+dQzrwd20I/UM6QXM/TOZ/h+kbs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=N431crZq; arc=fail smtp.client-ip=40.107.100.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UdRqWGWwrvs8cnCPShh3PCHVIYgPCYqkJi72C8OfAyQJ5gyAR6zFOn3csg/1tylUv4ZIDnvTTPZWh2xH+BgNIC35FngUOgUHXJtbprYtzGLtmxCrLqlkiyeHvzs+E89PVUwWQdCkIZcLlN229nzDRQzVUB+MIhlYGQj37sphZ/ldUuPlOmtya7kPelK34hb9a+fX9w5fjaIXHX5/czqp+OiWY+HwtTgvxm5cQLgTErazPEmzduD2YXyhM+nYmT1fT06hgwBPaZ/XKDvzM70LhXpEkyIzluREFluo1UkgPii2AAQIpgXE6LBN6MZ9QEWJYDd55ojZRQTuOfusBFC0UQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O+ETWHCw+kESvn8e/BiAqQ/rHRY+W9sQ0yNvEdshxTY=;
 b=Ta30VdLBH5b4KskN6BV4h3R+c4d4uH7U6l6JZz/9k2eMZ8fVQNtYkA0JGf9a9A5OqH4ES3PdAyPn4iJRR+9nD0TqENJyEfMow4TNKgZvJyZ27VlU3o/FAh2lC77P0Bdct40zVp59JADRamyy59TLQBEMDmEpZFszOaAI0qbdq+G3BVe50izLYN0EFYsnIm9DQRPELwwxUo+Ohu1oVnCpWvtkPlpApDxGd4HO3K53nZDvr849YWo0j7zZJZo7uSDSin4ZRPK22j7zCX/YQ3EIHvWLAPQj1ltd0a7Zqarzlmsjvu15d1DLNjByiJZEdt/3LjdbmTw04+7DBb1rmxcAiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O+ETWHCw+kESvn8e/BiAqQ/rHRY+W9sQ0yNvEdshxTY=;
 b=N431crZqsg6jiaAQiMqLe5LXSQBl18/kVEcyVKNBG0kqrW02gBrCuNFHCL3Yu1cncEhLklFvIfFrJDjNNq7hkhqNnAQo1gTl6lWZthhceGWjz9EFL60Td+qig2VHuEksYo3uFrY3jZUiVQdl80WIX1UItJ+S6w6j+bsp3+/2uw4hGwITJkYS1xCoxo71HsY/FY+ZGgfvEOXpaUssJVZF4gp8wJp5imdqdiav6T5Vt3Ffs9NBZSlsXo19Vs57Jnjesz7njjoBW8yyYkYvNkifsxPx37OnzgsVhykZTyUYW2nf3LXTaGmhHTP2hPBWe92EPrpvWrvLrv0kQZzoBJ6Wvg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6) by
 BY5PR12MB4132.namprd12.prod.outlook.com (2603:10b6:a03:209::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.10; Fri, 10 Jan
 2025 06:01:18 +0000
Received: from DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe]) by DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe%7]) with mapi id 15.20.8335.011; Fri, 10 Jan 2025
 06:01:18 +0000
From: Alistair Popple <apopple@nvidia.com>
To: akpm@linux-foundation.org,
	dan.j.williams@intel.com,
	linux-mm@kvack.org
Cc: alison.schofield@intel.com,
	Alistair Popple <apopple@nvidia.com>,
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
Subject: [PATCH v6 00/26] fs/dax: Fix ZONE_DEVICE page reference counts
Date: Fri, 10 Jan 2025 17:00:28 +1100
Message-ID: <cover.11189864684e31260d1408779fac9db80122047b.1736488799.git-series.apopple@nvidia.com>
X-Mailer: git-send-email 2.45.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SY2PR01CA0023.ausprd01.prod.outlook.com
 (2603:10c6:1:14::35) To DS0PR12MB7726.namprd12.prod.outlook.com
 (2603:10b6:8:130::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7726:EE_|BY5PR12MB4132:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ace6797-add2-4fc4-e082-08dd313c32f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?CBLVPcOYaYEJYbkSQ3VUQvJrJ9fKa8kjwxNV1uTtYlVNzP9gktOtNkN2H8ts?=
 =?us-ascii?Q?imUjkql6eKDdMXMEhwQracQRgsoN/ShOMP8g3FZ3otx0PyS/m3SR/tgOxDKh?=
 =?us-ascii?Q?v6ZaQ0YLXjoom8FaTlxqGl1rusZ701CnEKPwueK0CCrC6uSwSWFT87/miP9R?=
 =?us-ascii?Q?zKGdG+fY8FXhsLqQNgHwX8iNdwk2vpADhjhIhrcUEh/wZZHUmINJt5JODmgP?=
 =?us-ascii?Q?CDrDNuY1l7+oArLqndDanJ9+xDZpl8tN1zXmVDRbGRnXsmwR36g6oLZKqFwa?=
 =?us-ascii?Q?QdaaOfksBhAeiWDj3gmjktKQlH+j4CjkcCqUUv//UEsAA3OqwUgoTTniNNF6?=
 =?us-ascii?Q?ixr5aBCubxLYkXknx+cItoeCNQl0u0Jmy7p5p9puf2dmr/PJ8HVtlWlc5WmB?=
 =?us-ascii?Q?AfEWRXgQ9Z/QmCXqhzY5X4UwG2hOvw8bJEJr/06r0L1JurFp02okvnzUJiZj?=
 =?us-ascii?Q?MQbwKC9kvMK4zBETKfNNxQmtz87Wzi0eb0wjLHlygy4D9mi04pb8mDE/RDlX?=
 =?us-ascii?Q?DUorsKR5XVkU3Zjr5XOz4ymsf5OIRQo0xeRWbNYGj/z9S8m7QGBPebGtrYJ5?=
 =?us-ascii?Q?WoIk5fchzhpYP1j5J6cdo05HhvKcDSj3hKqV1lZQJvEPNmGz8KP+x8YjZod7?=
 =?us-ascii?Q?iDx7nWXk+8k6wSdg1DAn0P7rolU6yiJug94SSsM+ITMukkKuNPAO8dY0bRjb?=
 =?us-ascii?Q?VZXLpY5dkFRJofOEbqFyp669Oo9SJk6/JEF++F207joJA2Vt57tkV2WirFY9?=
 =?us-ascii?Q?cV8sV6fpQeYnyIoxLYt+DLHw3Fkun2NZCJ6KN9Ith2Aty+vl1FeQUod+x3t3?=
 =?us-ascii?Q?MGHv+9l9fnsHN6WIsUMu79OY/D+IIGako64ExC7F9WIrUwvoarg2dEHP+o0E?=
 =?us-ascii?Q?PVxYpp2nyTDi4DRTsQWoEMrwHkJhIrdNCXV3fMDnlSQxANc9Ou9oJCjo3SCQ?=
 =?us-ascii?Q?cgATuVsmtUftcyRx/iRsL8maODL67MolObJ7M2NI6BW0smjTh6szxZe9RDik?=
 =?us-ascii?Q?DHnsD8592vfp0lDSCWQZg4BakyQX/RFg6b8TVOuhD5EUK+0ZA8by1SKN8h5d?=
 =?us-ascii?Q?tA/jEnumKJ5c5PkqxbnrpsfdzB82EMKa5vVqPeRwwysq5uj25+gc9MJvsrSp?=
 =?us-ascii?Q?KwqJfDbpv4FNi1+CjSyWCOWv4V/N6til+VzIE3+6YA+rfu/qlQ52gQG/yPkh?=
 =?us-ascii?Q?FGzIxfSDbO2rJucIC3qoW+q1EsyzI6L9NEhNuUld7laP7VDt0SIXx+fFH+pq?=
 =?us-ascii?Q?OGhNinNyxt2LMS0MmAOgiN8vv7qUiUwruEiQw4LNhwmH1f+kKzUqF2LkP2PP?=
 =?us-ascii?Q?x47rcqzvSbtaAgQYnStEifmNfdFDYeJJUA84FfwOA7jYsDdahJi+nF/WFvJn?=
 =?us-ascii?Q?vgQkuNpg/l31SPTHRZJWccyq1kDt?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7726.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mzhGNZPsBssJ33djBOUuaZE5rcN4fffcLxJj+73YFogJ+/mnRZZRo1AKAZ0u?=
 =?us-ascii?Q?sIzz+CO+74OTqdjWEQh6/Y0pCi8V3WYn4Xnvl77MmBDIuzaUawAKFzG0u1Qg?=
 =?us-ascii?Q?aBb7NIQC5JkUsXBKW/K5/7Uw28LWVYnidAJ/ot0WqRnPpHa3AztrXq/hgI1n?=
 =?us-ascii?Q?aqWHhCiiFSj0LEvSbiCdhNngrzdRhxtd+w3mCtdILYLrOlCC5BRGS9YZyhuH?=
 =?us-ascii?Q?5fbSxLYlo1MOrbsCk8djpYjEU9qZB2CkB5xqDUsJkzxl/ZWyUVoVh0QTzGH2?=
 =?us-ascii?Q?TEs+Edewie9rDL9OJZzjmBTbwzBLMsTOZtOuI6rEuIw09N8pvXBeMqJ/WYFi?=
 =?us-ascii?Q?X+1oumlvhBXp8vqgPGu6JLTmxzKq+6DAy/Z4zx7tXnnU27dibpTxziPml9io?=
 =?us-ascii?Q?dRZUSB0x35Ih9fm4uVFqgonKkjLfsMwvs6WZSfUlFITSjlvaOxBHLXax2gxM?=
 =?us-ascii?Q?HBmQKb2y/yqGAgCIbi3DDgFD87J2WVWYG4aIo3tSYTtjC8sP2ZZMS0Q1QVwT?=
 =?us-ascii?Q?ZmcBVFgpZU3ESIIKGWnhe61SbVONSkGM3PsXnUmT1sQrMOcrrxlhO32D/cOo?=
 =?us-ascii?Q?O/9kSEtcXM0NL7Z3Q/0AXbjHJkumWg5PWfGXNvB/zgK8wjAaM3n3eUDq6Xwg?=
 =?us-ascii?Q?rn1POGGx4bAsVI6ROEwXrbRcw4NXpNL5LE4tfDqVOJaGRFtBm9k9uitgHa5p?=
 =?us-ascii?Q?8cwwK1UtdBxbyeG6KangMm3b4weRnwsu4Gc/p0rISR20WxGaqbgkO536x7F1?=
 =?us-ascii?Q?KslM7egv/8nwXg9YUf1Mz8ozktuFMUErmGSd0Yub0o7XpG4UVf0hHufUole9?=
 =?us-ascii?Q?NOWR0QZ1lC/1QKlgLVsTWBR+Y0p1++97oiEXzO3/8eL3o3s+ECYYmJBrUo2r?=
 =?us-ascii?Q?bLUSeqDZZd/We1fs+vS3yZQppSxlS+jUsKNmPLgPlSTjlr3PlNJYUO2zbFl2?=
 =?us-ascii?Q?Qn+c2BCjb4AP5jCn2njuBM4qM9XPFMH+QQCrCxrVk5pAu0S3HsbyW/gvDILO?=
 =?us-ascii?Q?p6zVA6MCZAMy8epLxGwKAYvXNmUVSZarNFOxukpIqeklZMGnlSCsIcNIeViq?=
 =?us-ascii?Q?5OrZG6FJ1Lshi1q8ANcUhaJelsZBcs6wPq2EkvxYbnxGftnUaYcZNt5uMzVq?=
 =?us-ascii?Q?Bw7XK3tMdLjmcKjyQrTo4MaA6aejSHzXNC6SP6TYWvmaa/MQygH2X97xWeOx?=
 =?us-ascii?Q?HqkXCNS9EksTkdtyAD7n1bTMBefThRnt3MCESIy2GxUJxObLNPdcvRTcGXoL?=
 =?us-ascii?Q?IJmPV66EWkoDPBNknOoUWxQFTpkqhDmO510LDR662Dpj4nSzL8V61dy5R69a?=
 =?us-ascii?Q?qE3dUiFeiIv576Uaa9IcVNyoVUWuSIMxkHB0ZEN4hayGd9G580BnEofsr/bL?=
 =?us-ascii?Q?GP/xZQVgOyO5EHzy6dMWz50J2qDv5u3zFut8CM4HLKlb3eEATxIXobdpvAKl?=
 =?us-ascii?Q?AvN7J4M+OHEYMn5jMphBwejij2z5YVDhs7pXsL8Vkat0e9Fo4vcedBwUppz4?=
 =?us-ascii?Q?lzEFXAH8IPlFJrlAKhEfsv+M5zRXI/oR5kTL4sS1bvoJMlP5FbWAn+oU3eRY?=
 =?us-ascii?Q?+Uc7lQHxyJc1j56FCdOGpC7PEWY5avLMDpWl73Cw?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ace6797-add2-4fc4-e082-08dd313c32f0
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7726.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2025 06:01:18.0876
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BYS11yP6/10kv6WUcPTb1COot2sZGnOIrJplwswS9h0J58vCizjgazUak9mxBbjfbIyb/y/O5tLYClx+JTKqxw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4132

Main updates since v5:

 - Reworked patch 1 based on Dan's feedback.

 - Fixed build issues on PPC and when CONFIG_PGTABLE_HAS_HUGE_LEAVES
   is no defined.

 - Minor comment formatting and documentation fixes.

 - Remove PTE_DEVMAP definitions from Loongarch which were added since
   this series was initially written.

Main updates since v4:

 - Removed most of the devdax/fsdax checks in fs/proc/task_mmu.c. This
   means smaps/pagemap may contain DAX pages.

 - Fixed rmap accounting of PUD mapped pages.

 - Minor code clean-ups.

Main updates since v3:

 - Rebased onto next-20241216. The rebase wasn't too difficult, but in
   the interests of getting this out sooner for Andrew to look at as
   requested by him I have yet to extensively build/run test this
   version of the series.

 - Fixed a bunch of build breakages reported by John Hubbard and the
   kernel test robot due to various combinations of CONFIG options.

 - Split the rmap changes into a separate patch as suggested by David H.

 - Reworded the description for the P2PDMA change.

Main updates since v2:

 - Rename the DAX specific dax_insert_XXX functions to vmf_insert_XXX
   and have them pass the vmf struct.

 - Separate out the device DAX changes.

 - Restore the page share mapping counting and associated warnings.

 - Rework truncate to require file-systems to have previously called
   dax_break_layout() to remove the address space mapping for a
   page. This found several bugs which are fixed by the first half of
   the series. The motivation for this was initially to allow the FS
   DAX page-cache mappings to hold a reference on the page.

   However that turned out to be a dead-end (see the comments on patch
   21), but it found several bugs and I think overall it is an
   improvement so I have left it here.

Device and FS DAX pages have always maintained their own page
reference counts without following the normal rules for page reference
counting. In particular pages are considered free when the refcount
hits one rather than zero and refcounts are not added when mapping the
page.

Tracking this requires special PTE bits (PTE_DEVMAP) and a secondary
mechanism for allowing GUP to hold references on the page (see
get_dev_pagemap). However there doesn't seem to be any reason why FS
DAX pages need their own reference counting scheme.

By treating the refcounts on these pages the same way as normal pages
we can remove a lot of special checks. In particular pXd_trans_huge()
becomes the same as pXd_leaf(), although I haven't made that change
here. It also frees up a valuable SW define PTE bit on architectures
that have devmap PTE bits defined.

It also almost certainly allows further clean-up of the devmap managed
functions, but I have left that as a future improvment. It also
enables support for compound ZONE_DEVICE pages which is one of my
primary motivators for doing this work.

Signed-off-by: Alistair Popple <apopple@nvidia.com>
Tested-by: Alison Schofield <alison.schofield@intel.com>

---

Cc: lina@asahilina.net
Cc: zhang.lyra@gmail.com
Cc: gerald.schaefer@linux.ibm.com
Cc: dan.j.williams@intel.com
Cc: vishal.l.verma@intel.com
Cc: dave.jiang@intel.com
Cc: logang@deltatee.com
Cc: bhelgaas@google.com
Cc: jack@suse.cz
Cc: jgg@ziepe.ca
Cc: catalin.marinas@arm.com
Cc: will@kernel.org
Cc: mpe@ellerman.id.au
Cc: npiggin@gmail.com
Cc: dave.hansen@linux.intel.com
Cc: ira.weiny@intel.com
Cc: willy@infradead.org
Cc: djwong@kernel.org
Cc: tytso@mit.edu
Cc: linmiaohe@huawei.com
Cc: david@redhat.com
Cc: peterx@redhat.com
Cc: linux-doc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linuxppc-dev@lists.ozlabs.org
Cc: nvdimm@lists.linux.dev
Cc: linux-cxl@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org
Cc: linux-mm@kvack.org
Cc: linux-ext4@vger.kernel.org
Cc: linux-xfs@vger.kernel.org
Cc: jhubbard@nvidia.com
Cc: hch@lst.de
Cc: david@fromorbit.com
Cc: chenhuacai@kernel.org
Cc: kernel@xen0n.name
Cc: loongarch@lists.linux.dev

Alistair Popple (26):
  fuse: Fix dax truncate/punch_hole fault path
  fs/dax: Return unmapped busy pages from dax_layout_busy_page_range()
  fs/dax: Don't skip locked entries when scanning entries
  fs/dax: Refactor wait for dax idle page
  fs/dax: Create a common implementation to break DAX layouts
  fs/dax: Always remove DAX page-cache entries when breaking layouts
  fs/dax: Ensure all pages are idle prior to filesystem unmount
  fs/dax: Remove PAGE_MAPPING_DAX_SHARED mapping flag
  mm/gup: Remove redundant check for PCI P2PDMA page
  mm/mm_init: Move p2pdma page refcount initialisation to p2pdma
  mm: Allow compound zone device pages
  mm/memory: Enhance insert_page_into_pte_locked() to create writable mappings
  mm/memory: Add vmf_insert_page_mkwrite()
  rmap: Add support for PUD sized mappings to rmap
  huge_memory: Add vmf_insert_folio_pud()
  huge_memory: Add vmf_insert_folio_pmd()
  memremap: Add is_devdax_page() and is_fsdax_page() helpers
  mm/gup: Don't allow FOLL_LONGTERM pinning of FS DAX pages
  proc/task_mmu: Mark devdax and fsdax pages as always unpinned
  mm/mlock: Skip ZONE_DEVICE PMDs during mlock
  fs/dax: Properly refcount fs dax pages
  device/dax: Properly refcount device dax pages when mapping
  mm: Remove pXX_devmap callers
  mm: Remove devmap related functions and page table bits
  Revert "riscv: mm: Add support for ZONE_DEVICE"
  Revert "LoongArch: Add ARCH_HAS_PTE_DEVMAP support"

 Documentation/mm/arch_pgtable_helpers.rst     |   6 +-
 arch/arm64/Kconfig                            |   1 +-
 arch/arm64/include/asm/pgtable-prot.h         |   1 +-
 arch/arm64/include/asm/pgtable.h              |  24 +-
 arch/loongarch/Kconfig                        |   1 +-
 arch/loongarch/include/asm/pgtable-bits.h     |   6 +-
 arch/loongarch/include/asm/pgtable.h          |  19 +-
 arch/powerpc/Kconfig                          |   1 +-
 arch/powerpc/include/asm/book3s/64/hash-4k.h  |   6 +-
 arch/powerpc/include/asm/book3s/64/hash-64k.h |   7 +-
 arch/powerpc/include/asm/book3s/64/pgtable.h  |  53 +---
 arch/powerpc/include/asm/book3s/64/radix.h    |  14 +-
 arch/powerpc/mm/book3s64/hash_hugepage.c      |   2 +-
 arch/powerpc/mm/book3s64/hash_pgtable.c       |   3 +-
 arch/powerpc/mm/book3s64/hugetlbpage.c        |   2 +-
 arch/powerpc/mm/book3s64/pgtable.c            |  10 +-
 arch/powerpc/mm/book3s64/radix_pgtable.c      |   5 +-
 arch/powerpc/mm/pgtable.c                     |   2 +-
 arch/riscv/Kconfig                            |   1 +-
 arch/riscv/include/asm/pgtable-64.h           |  20 +-
 arch/riscv/include/asm/pgtable-bits.h         |   1 +-
 arch/riscv/include/asm/pgtable.h              |  17 +-
 arch/x86/Kconfig                              |   1 +-
 arch/x86/include/asm/pgtable.h                |  51 +---
 arch/x86/include/asm/pgtable_types.h          |   5 +-
 drivers/dax/device.c                          |  15 +-
 drivers/gpu/drm/nouveau/nouveau_dmem.c        |   3 +-
 drivers/nvdimm/pmem.c                         |   4 +-
 drivers/pci/p2pdma.c                          |  19 +-
 fs/dax.c                                      | 363 ++++++++++++++-----
 fs/ext4/inode.c                               |  43 +--
 fs/fuse/dax.c                                 |  30 +--
 fs/fuse/dir.c                                 |   2 +-
 fs/fuse/file.c                                |   4 +-
 fs/fuse/virtio_fs.c                           |   3 +-
 fs/proc/task_mmu.c                            |   2 +-
 fs/userfaultfd.c                              |   2 +-
 fs/xfs/xfs_inode.c                            |  40 +-
 fs/xfs/xfs_inode.h                            |   3 +-
 fs/xfs/xfs_super.c                            |  18 +-
 include/linux/dax.h                           |  37 ++-
 include/linux/huge_mm.h                       |  12 +-
 include/linux/memremap.h                      |  28 +-
 include/linux/migrate.h                       |   4 +-
 include/linux/mm.h                            |  40 +--
 include/linux/mm_types.h                      |  16 +-
 include/linux/mmzone.h                        |  12 +-
 include/linux/page-flags.h                    |   6 +-
 include/linux/pfn_t.h                         |  20 +-
 include/linux/pgtable.h                       |  21 +-
 include/linux/rmap.h                          |  15 +-
 lib/test_hmm.c                                |   3 +-
 mm/Kconfig                                    |   4 +-
 mm/debug_vm_pgtable.c                         |  59 +---
 mm/gup.c                                      | 176 +---------
 mm/hmm.c                                      |  12 +-
 mm/huge_memory.c                              | 220 +++++++-----
 mm/internal.h                                 |   2 +-
 mm/khugepaged.c                               |   2 +-
 mm/madvise.c                                  |   8 +-
 mm/mapping_dirty_helpers.c                    |   4 +-
 mm/memory-failure.c                           |   6 +-
 mm/memory.c                                   | 118 ++++--
 mm/memremap.c                                 |  59 +--
 mm/migrate_device.c                           |   9 +-
 mm/mlock.c                                    |   2 +-
 mm/mm_init.c                                  |  23 +-
 mm/mprotect.c                                 |   2 +-
 mm/mremap.c                                   |   5 +-
 mm/page_vma_mapped.c                          |   5 +-
 mm/pagewalk.c                                 |  14 +-
 mm/pgtable-generic.c                          |   7 +-
 mm/rmap.c                                     |  67 +++-
 mm/swap.c                                     |   2 +-
 mm/truncate.c                                 |  16 +-
 mm/userfaultfd.c                              |   5 +-
 mm/vmscan.c                                   |   5 +-
 77 files changed, 895 insertions(+), 961 deletions(-)

base-commit: e25c8d66f6786300b680866c0e0139981273feba
-- 
git-series 0.9.1

