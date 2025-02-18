Return-Path: <linux-fsdevel+bounces-41923-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F9DAA391F6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Feb 2025 05:03:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A87343B5C8D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Feb 2025 04:00:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CB181DB14C;
	Tue, 18 Feb 2025 03:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Y2tXriTL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2066.outbound.protection.outlook.com [40.107.220.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFD071A254C;
	Tue, 18 Feb 2025 03:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739851022; cv=fail; b=JpknI19pMmvNBMmjV6DHM20LW1DX8dDsUgyA/nQPbKfHYX9pYie4Ff2SFrsJjiGMuJsvih7Bh2O4Wa1yVhPkK+Q5YtujAvNL4fDWH7T+IiYJ18vD7JIFpjFzi8Fq6XBD4nYr3yny77jfJziLAYmtA8hgQ7I/x4Qpv8/VVuU19a8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739851022; c=relaxed/simple;
	bh=hQ5O0kJ83wQCV/HMCjZEuZwvXhfQgf1kWbQXeU/5Vtk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PnO8hxuR3pUHFifjD32N6stMb6Y9MVPPwWZ3P9fJoq5yVyvSQf21At+DFkwSHeZ1V4qB7MeTe3judlWSPyo0094qF9pkDHN4QPnKLXsxFZ7XNrLkoso89Nwr3cybDsYldIDN1lAp1imCvxHfjDVDtsiZzow8/pJYRwz8qrZZjhw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Y2tXriTL; arc=fail smtp.client-ip=40.107.220.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JPSNeLkR7HTTWw0erVH3ZPpCGw6OHtuk0Dr8S0qSRnKDHLhbJoMqdJ3TrSZPl5rfZ1E1ItUYFidVaUFOAHfyVefVDTIvRH/cex4BQunNaCb5uaKWf9mjbF3oEq2hoX4kgghtVNIyEnaDFEEio5Jgb4AHaFhrSodPwir7X1bVCQeoprOvlWVL49dIY1Hv1o+MP8eFFH6L5I7ruWbrkUq4LSlN4Ie46QJnDEJKKxkzWMlTmlsXUYPwniKhnzTlRIDxiAtaC624yMSUQpax93vztVeENNKyEFF6l+6z/aG1O7M7EaNm9CphTUgDgET1SXLJnHN9AsQWgnPyc65syfu9OQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o9MotQOSY0LVsCQPw+Q39CqMR5NnyIi9vRj90M2RfZw=;
 b=Vtdkoxt2Oo+GAOSptuUfMpiDPPyXKvS2vO/95vAgLX7NpBqkfeI8FzBvJkkStVl2xAlGWSGFnJvAnjjbM1NYVYP0EmJD5+AEeDLgkMAKGo1kSC9rfGvdfYEWmVsDk5R3O3aTXBfwyHHEOemIuvR+eZp2jyhKs/zpIywjPMQ0j4697ji5nPiQFCUh+peoYRF9xZO9nI3sWShle3sJDAmPFh3iBNKHpAA7TuUuBgWvT2o2qFnAA3CuAHxDGs/+A4RY+/6/glwcIW8NLK0RJQNT/0psAt7hPqBEVh2OjYBtn6UhRBJ1B7NWzrpNsSIJZBKyu5dUWVaYdykfzbssxCC1fQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o9MotQOSY0LVsCQPw+Q39CqMR5NnyIi9vRj90M2RfZw=;
 b=Y2tXriTLdP4APGSKNBDdTZHmE3o/WD8YHBK6bvAla05ET0yLrKc8x0bnTQCnwPM5pIh2gHMKpbxDxa2wZNZsD2NlaGoUR8fQbn2deXyg6uxqoBI6mRCoCxkDza5BT5fS/ZJDmfTIu4MigYD+/DDT33lXuRodTkD1Xj1bLtIG8qN+6X+WUxEvCgPwLhPequv7kWZRSERuvoJnPjK6Urpdv75/sekbX9JKNU6elXm1/4JymXOGxDOfcMmelGYOu/uUruOE3F2U3gnMCOQYgXxEiKRVBK0LHoplBBiJIm51cRYy7e5zzoxlBFGIz50F937L7MWHd9SHpgCcojO/o8A1gg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6) by
 CH3PR12MB7593.namprd12.prod.outlook.com (2603:10b6:610:141::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.19; Tue, 18 Feb
 2025 03:56:58 +0000
Received: from DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe]) by DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe%7]) with mapi id 15.20.8445.017; Tue, 18 Feb 2025
 03:56:58 +0000
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
Subject: [PATCH v8 13/20] mm/memory: Add vmf_insert_page_mkwrite()
Date: Tue, 18 Feb 2025 14:55:29 +1100
Message-ID: <c936e2c5e569844a5f1e26968cd89fa348a31b09.1739850794.git-series.apopple@nvidia.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.a782e309b1328f961da88abddbbc48e5b4579021.1739850794.git-series.apopple@nvidia.com>
References: <cover.a782e309b1328f961da88abddbbc48e5b4579021.1739850794.git-series.apopple@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SYYP282CA0007.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:10:b4::17) To DS0PR12MB7726.namprd12.prod.outlook.com
 (2603:10b6:8:130::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7726:EE_|CH3PR12MB7593:EE_
X-MS-Office365-Filtering-Correlation-Id: 5571bf7b-c249-4052-5239-08dd4fd04ad8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?X/z4kdZ1g2Sl3AdUjw7Yu1L0TUkL0n41caOfprcqDo3e+sxzM2jqIgfHC8+m?=
 =?us-ascii?Q?1r/7cIxVP0KZe64Cd0b/98X25Tv67pV7D+kcFn0cA6FZBmVgKr5XLCGO+5VP?=
 =?us-ascii?Q?UJV7Xz1bz/8oOVt0ijRNb07LEWsD41v47477aiiUBe8nLLjgPasZgvjaVEBm?=
 =?us-ascii?Q?aFqEUW8g+DBzM88QIgLa1BwF9ADl2hLMmKifRDt9I27J2jeIPceEBXaZnvJk?=
 =?us-ascii?Q?WhP8X0oxY4gnHTPWjcvaNgtDm+XMneV2FhlYskLbMU7nu98hSwDFqdkTk6OC?=
 =?us-ascii?Q?icbE31TzrPHqvMwSW+S2WMf+S0Ptmnf0KPIPa10kom1WOKdifnaTaOiCDISM?=
 =?us-ascii?Q?esHtOaTp0CySOk4NV9c5Gh65ywCzUCJIaONq6gOd4qUti+MS1nVSxmWaGwW+?=
 =?us-ascii?Q?u1Bb/OQ1oIQar9RZfol/LUKM7ZbtDwppK+a6HMDDFC4orKVotwj9hj+mmgjH?=
 =?us-ascii?Q?YHNCS+Zz/Ruw6F8RNruvA1MbGvbReeVh4XIR0ozTqQqHWOpha2z8riqOza4D?=
 =?us-ascii?Q?jKE/idK1vu3+If8J4PTkZOM5gMkRRCQ1YThbUPDxvJG6oeTlQ+ZX1aYWyctk?=
 =?us-ascii?Q?KPqtneVNjqPM7DiWKoEt+92LJUy/65KMGpqePjx5Rnh9bTGmKQUNpJYecjjP?=
 =?us-ascii?Q?J2omhuun1HTOamhlNQFrAarFVtQRi9OEvtXrbajAkhH4gvwRIkyAdUK+BWdo?=
 =?us-ascii?Q?vvtr5QktfVztEaJ7kZaWghnNZWgyCCP5LkJKjpJS/wHY+CYrsjSTSi+0z4JH?=
 =?us-ascii?Q?h1cuBhIPGXlAx+/xjiPBAx9PBa+1p3Tii5KF7chNTRZbl8uJdMOJGP33wili?=
 =?us-ascii?Q?uvERvkwS3JbFDdR9ayZF95+t/JKOBTf03rXKc9BetRg+vT+30fIoEjzPQGHv?=
 =?us-ascii?Q?PfzCmX7K6A8QR+pVndHoAUM1F26q+hWE0SfwrEYRA9avzsusNIiRj2fb4FI7?=
 =?us-ascii?Q?VOlrbOHxbqPtvgupCC1t64jFRrVoZM4dVkfVUI5Mz3iEgihOhQt5VWGx+hbq?=
 =?us-ascii?Q?8HBRkw6gHCj7Z4Om8Kqg7wEC/GehpLM/lEIq+DKGHNfteBFjpZ7UZ4d90daW?=
 =?us-ascii?Q?Sa+qw5YslL3d8HV9eQxIN3pXm2Ngmf1GupXWmp3UvoYGJPptVnVNadwQ8N8F?=
 =?us-ascii?Q?JJitUcL98Hr9Bj7VXtLDhS8lj4+W2IxXkzyuO2lJ1xcUMMlwQCAmGc7CWLQJ?=
 =?us-ascii?Q?z1US1utgtR0kOj84HkzzDZXWL6QcPlC8KEdrItBebPhBmQwR1s18hnAaW3/s?=
 =?us-ascii?Q?+hO3UWfT66vTOgvBSSIfw7Nu/CNsicfjqNcuzvdV7ElZg3dPns6w5GQ72rH9?=
 =?us-ascii?Q?IGlZ/Qqe6uxKpUH4AsfXTK0904J8pJKIvSpNxwqJmhR88Wdw7qgrLUoYVGzh?=
 =?us-ascii?Q?h3pCkR4OTFIjcc8Pxrx7HX13xmnj?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7726.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?WwLGzU2KDgKiVnbqnfrYlsWaohNkO7ujcKd4x0HguWWCS5uExNVHNYfox5dD?=
 =?us-ascii?Q?LYTcJTtojJyNDmP2ZxOES/A9mYgNpYfxXiGr8rx2kTUK/ncf5rAKX9IisBdz?=
 =?us-ascii?Q?5+7rCufAUnQmfc9ZEsQF2aTqzIFj/aucAEDLRtcIrqBuoKwFx2rR52P8dtlE?=
 =?us-ascii?Q?o/az5rjqOB/+vR8esalgbt3QGTJru/+kuwIepv+GNozcIIFpFNM3IpOnrpuE?=
 =?us-ascii?Q?pQM7AQe8+8SekhlcPS8kscm3uTvrc/hx2vWXRIT2rghQwWrCCqU3gdTslpjr?=
 =?us-ascii?Q?18jyfgipiZEWNmFYA9hMp/UH1HP3nJOR9VxoRtL9NtOY78Gd3dQ4GVR2BZZ5?=
 =?us-ascii?Q?sEn+uMeemsMnB+9RW12dSErHhbmMMDflu4s9PwBlgrWGk2ofACOkYL5RZDCR?=
 =?us-ascii?Q?Ot/yRv4Td5sK5UtP14egqSHBQQ1NgKmcBvRNczwu3VY5KE7WanmqO0B3pdi8?=
 =?us-ascii?Q?8OjjSbcpN/KdoMxCefSZ4DF/oYbDKU0uJzq8/5MC0Fn38Ohp6eh3BSUls5R4?=
 =?us-ascii?Q?Fq2ANil2ppckX0ePClxQtw0BXYT3XOqDpedzsiI+niq1uJgzvk/u7nTC8CiP?=
 =?us-ascii?Q?TeKbsPSAUu3mLhltgWEJeqZpaMXyHgfA3AfQZsqFr8AxuwzFJz7hsdPIlOlR?=
 =?us-ascii?Q?IJmjnTNPsg8QmaD5NHvY03z2BPL3jZozEftKEM4v47qpz3oVpSg3OgVlu/qG?=
 =?us-ascii?Q?6AiIv8TVs0hiRft6oFgjia+oKIjZ4mu2zAievgvgG1zElN3cOdbdMXnfyxa0?=
 =?us-ascii?Q?4XBci3l+ITltVCFJg0f5MiKZP+Oq4BBF5nDNLi05tRrd6w0isnDJfOg7WREL?=
 =?us-ascii?Q?QMYcn7N5uqj0tgk2b9gQatpt2kA63AbbjRLI0BcoFc9EC8dH/RS8PbNHFbTS?=
 =?us-ascii?Q?LJZCleSmfWkHYnAOQTuJgQcMKRWM/PLzpAO6AwuaYC64m6ROyjMguvVRQV01?=
 =?us-ascii?Q?NuZFxWj9/JLO1Bf6TscMEJ39qdC7PtlrD1fxJU5huJG0KozapBJnjphqVBVI?=
 =?us-ascii?Q?8H+0VYkIQhSEOF3BKqE/uu3Si6MzymAPytAtmzg36VIXiFlesoKvxcma+htB?=
 =?us-ascii?Q?JQ6FhDiUtwatU99nrP3D58r0mKWBk7e0Gz4UNXWYvqcaCrQss2KbRxBlQbd4?=
 =?us-ascii?Q?QGd3R5GHKmhzCJEB0jKOkPdSbygrbl9KreRix8vOIjIV4qpBbJBSzh2t8L1Y?=
 =?us-ascii?Q?AZQUJB6VTJsmfH8LQ0J+8sDcJhPO5ZQo8+vOs4FI4t+zC+kr5Nm1Zs/08IyT?=
 =?us-ascii?Q?yF14SnQqNh4R5im8CVhCU84cwZKq3D/ZQLt15OjIJfAjhfl/r1RlHOTvFao2?=
 =?us-ascii?Q?6ZUbDrXKczFaWHi14s0IW0tvAgGxFs63YEGZ4bKtKteKOMIMXJPermcWll3g?=
 =?us-ascii?Q?xYYSnhcSbQAZ/zF7WJ7E/rMUeOOFCv963ZUCiJib8FhAamigu1X46p34716U?=
 =?us-ascii?Q?dNopDqaD2H3gkNdzwYm1gkEZHmcgrwbuRx8XKdUb5okS2dv4ll2zdFcIhwAp?=
 =?us-ascii?Q?MkkuqPY9m2Jy/yNDzTVx0RhMLGzVkZQm9swSXHDtHeNE+ATC8kxNSNMBDKw+?=
 =?us-ascii?Q?7eHmKW0V5/E8k/Z7sq+1EdBI4IPrDSKzouzrDQhN?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5571bf7b-c249-4052-5239-08dd4fd04ad8
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7726.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2025 03:56:58.6962
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DptbbPZ/TlwNcJ0z6osw7hp+dTWCoDJXWPoAry81T5BGe37ttDZy9Y4ZcRpVDGmtAXuueKqBy2aQpjdqYMsxzA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7593

Currently to map a DAX page the DAX driver calls vmf_insert_pfn. This
creates a special devmap PTE entry for the pfn but does not take a
reference on the underlying struct page for the mapping. This is
because DAX page refcounts are treated specially, as indicated by the
presence of a devmap entry.

To allow DAX page refcounts to be managed the same as normal page
refcounts introduce vmf_insert_page_mkwrite(). This will take a
reference on the underlying page much the same as vmf_insert_page,
except it also permits upgrading an existing mapping to be writable if
requested/possible.

Signed-off-by: Alistair Popple <apopple@nvidia.com>
Acked-by: David Hildenbrand <david@redhat.com>

---

Changes for v8:
 - Remove temp suggested by David.

Changes for v7:
 - Fix vmf_insert_page_mkwrite by removing pfn gunk as suggested by
   David.

Updates from v2:

 - Rename function to make not DAX specific

 - Split the insert_page_into_pte_locked() change into a separate
   patch.

Updates from v1:

 - Re-arrange code in insert_page_into_pte_locked() based on comments
   from Jan Kara.

 - Call mkdrity/mkyoung for the mkwrite case, also suggested by Jan.
---
 include/linux/mm.h |  2 ++
 mm/memory.c        | 20 ++++++++++++++++++++
 2 files changed, 22 insertions(+)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index fabd537..d1f260d 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -3638,6 +3638,8 @@ int vm_map_pages(struct vm_area_struct *vma, struct page **pages,
 				unsigned long num);
 int vm_map_pages_zero(struct vm_area_struct *vma, struct page **pages,
 				unsigned long num);
+vm_fault_t vmf_insert_page_mkwrite(struct vm_fault *vmf, struct page *page,
+			bool write);
 vm_fault_t vmf_insert_pfn(struct vm_area_struct *vma, unsigned long addr,
 			unsigned long pfn);
 vm_fault_t vmf_insert_pfn_prot(struct vm_area_struct *vma, unsigned long addr,
diff --git a/mm/memory.c b/mm/memory.c
index becfaf4..a978b77 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -2624,6 +2624,26 @@ static vm_fault_t __vm_insert_mixed(struct vm_area_struct *vma,
 	return VM_FAULT_NOPAGE;
 }
 
+vm_fault_t vmf_insert_page_mkwrite(struct vm_fault *vmf, struct page *page,
+			bool write)
+{
+	pgprot_t pgprot = vmf->vma->vm_page_prot;
+	unsigned long addr = vmf->address;
+	int err;
+
+	if (addr < vmf->vma->vm_start || addr >= vmf->vma->vm_end)
+		return VM_FAULT_SIGBUS;
+
+	err = insert_page(vmf->vma, addr, page, pgprot, write);
+	if (err == -ENOMEM)
+		return VM_FAULT_OOM;
+	if (err < 0 && err != -EBUSY)
+		return VM_FAULT_SIGBUS;
+
+	return VM_FAULT_NOPAGE;
+}
+EXPORT_SYMBOL_GPL(vmf_insert_page_mkwrite);
+
 vm_fault_t vmf_insert_mixed(struct vm_area_struct *vma, unsigned long addr,
 		pfn_t pfn)
 {
-- 
git-series 0.9.1

