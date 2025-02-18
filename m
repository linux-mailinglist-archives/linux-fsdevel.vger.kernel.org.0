Return-Path: <linux-fsdevel+bounces-41913-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32CF9A39190
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Feb 2025 04:57:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C9731727C2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Feb 2025 03:57:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 719141B0F17;
	Tue, 18 Feb 2025 03:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="P/8pswMF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2055.outbound.protection.outlook.com [40.107.96.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F9071AF0CE;
	Tue, 18 Feb 2025 03:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739850968; cv=fail; b=YRYzX6FxhBUaJRQMxmdhlfXCOi3hXc37mBgn5lutz0hnAGiNUzpVCvP161W8W7B+gFYE9PHdM/3CfUgB3YFccktLoc5OjB9Qo+jRah08o7mh1BPpvvSpBvh4/q2djCVL8bP8RgxcRu4Fmw7dBFN5ODHLsp0htncRNgzzRSJJzHY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739850968; c=relaxed/simple;
	bh=fDSywCfgizQaLiDGv7l77PjHQ67OkX0IFGbBktcJVH0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qf3CCI3wAP+jbOceoEpCVvH8/x2ytWKv1R6n7pVjzZ3vHepDsyNJH5LT+8pnrz9XYwg+b7tVIpc59lk81tqnfwgVvncoajqStfwWDq6x4Fajec1ay2xbzm9dwNUHMNGX8gAV8owINEvrLzzbGK2YUf8etdfnP4P2YV6UiNEx1d4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=P/8pswMF; arc=fail smtp.client-ip=40.107.96.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hE8MlQs5LLb5P2BWZelf9h0f49H6zn6CN5JhHQU3FV8XXcZ0WA3BlwfvosDIsoSfvKq6UELHzMO8rbugTQUf04aZbRqGV0FW6uj/A1InD5uM3mWR6Lg9msCds7jD4Ft8kYnEaS8PeyG6jLTolLarlVvSFlt1qfa+OsccXLjStYiJocuYQPWpAEWkxhAuOyRzh0IXrjD4robnYzjdiTpRLyP4s5+qc1TznqnJYTnWycHy0imDMSWXKe5cq5Y5O8YcyM3OG/g9g1i+jyECQ9GaP/LuaRXg3RBE+0oO8D09dCU5CJBeu2paHnSmcR0+Lj8TPkN729sryZOH5wyvMF7yjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P0+55lF1ewPGjHL4a+DdtnQpGk+9xCAh01YxiyDIjWQ=;
 b=G13KLKo7m8518FrVRiKZAIZpZfEJ5BzwZ58TNTiZ94PXlzjhad8xg0Z2uWbwLtlKSW02V1DK+M8xG9UeI0j2+KdTM1o94BJTkinmzIuqNeHOYm/WE6u3vP+kwZDWmAaF/kpRzXT5YE77PB9WCE8UyPS/uJ0Zy+2KZdHIuBZU2QKmat6hr0e85FJB8xdL8uWKHt420C1opdUK4Ry0t/FN/HmwEiqsyfJ+4Df+cL3RFUHzk84UdPhJVdVUC6wIulptNvG2eBUzWV29qURRvkeAUM1/kUq3N/xb5tDsoW2dGU+iDoPeMwAAj5Dhfz/dchvZF65xgp4WACBdUJCC5T9PtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P0+55lF1ewPGjHL4a+DdtnQpGk+9xCAh01YxiyDIjWQ=;
 b=P/8pswMFmWo+IqE7JTkZAASDC2rXltFKzy/Fe8TGzSK1Q2vHxC17qQ/wMO6LR5rz3VKilboFl4MF1dY2Hcos/+Khd4UJWXfWhP6kKdeHVU5ewnG51Q/nFomEPug0CSe17/+SPDIw3nX9oAjCuGZLwyGQCjmH8A++ZrbJlawUgHcbbwGOhQml4MMmRctaBzg2WW7VePKVv5Zjp0ruzV8jXTT9/RP673jO18m9/I/48sOZ+IdjZblwBtxd8M/V8bEzFQcTPDpasM5U72Yb8QZHe37qzSwRom2VOu7XypuUComD788HszmlWCgBkgCrSJ/8MRCxKZXarQ4BlYuP3dmR4Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6) by
 SN7PR12MB6789.namprd12.prod.outlook.com (2603:10b6:806:26b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.11; Tue, 18 Feb
 2025 03:56:04 +0000
Received: from DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe]) by DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe%7]) with mapi id 15.20.8445.017; Tue, 18 Feb 2025
 03:56:04 +0000
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
Subject: [PATCH v8 03/20] fs/dax: Don't skip locked entries when scanning entries
Date: Tue, 18 Feb 2025 14:55:19 +1100
Message-ID: <b11b2baed7157dc900bf07a4571bf71b7cd82d97.1739850794.git-series.apopple@nvidia.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.a782e309b1328f961da88abddbbc48e5b4579021.1739850794.git-series.apopple@nvidia.com>
References: <cover.a782e309b1328f961da88abddbbc48e5b4579021.1739850794.git-series.apopple@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SY5PR01CA0072.ausprd01.prod.outlook.com
 (2603:10c6:10:1f4::8) To DS0PR12MB7726.namprd12.prod.outlook.com
 (2603:10b6:8:130::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7726:EE_|SN7PR12MB6789:EE_
X-MS-Office365-Filtering-Correlation-Id: e925002d-6ced-43ac-8cb3-08dd4fd02a7e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?NfeXD93d5vqKUBlOwHRoogIxL8enNW5nCdAUyWA3T5wojV+zguMDMMjAIKT2?=
 =?us-ascii?Q?h28kwNiDawqZvNi3NECDyGIKPW0byZaGBOs+1R1qUnXJyHpTQ4hKWueILe8a?=
 =?us-ascii?Q?SS9QB4dtQKehVe/JbQXV+rA9Pb8PA5L8njUbIMFHYqryEKATZYwolXYY8w7J?=
 =?us-ascii?Q?abQm98ClJeaycI5QdV5c5BKK9hWrWnjv35s9Ms0LSyg7lDy8ex08UCt7R273?=
 =?us-ascii?Q?RgRr2YYiub2AmzuRLPBhAwDdgk/8u8w80ImOyEjJeb5K9ESQaVlrZfYdaLVE?=
 =?us-ascii?Q?rULIOH/Y+vEC0Lb6IYRJe+DPzrF1pQtQxt194YcXB8dDVZAjO/WWkqo3kYks?=
 =?us-ascii?Q?GNeQBJVsPI3lHtQJpY9ESg34nykCjoJqsuvqWAyHVgc2PB2TxW6bb4Z79jEx?=
 =?us-ascii?Q?uC0PnH1Cy9LWc/PXqw5Y8KaiUcQnKYLlrXHQULXYeWyxzsj8r8F0l60tUfz9?=
 =?us-ascii?Q?tSjIlBCKzngHAts/YacxqXwrqot6YlBm2Kp3ydQ1pTSL2X2LSQzBrUR5rnbS?=
 =?us-ascii?Q?FYUChMaB1NR8mSd4+teGVIUwDhMzUDQB5uUs2iTUTSfiVspew0PnRY5/O/0q?=
 =?us-ascii?Q?EFnFV4ORBwsU5w0V4qjov0GKvShkN9e4dcpjOEjzgR9A9FuN6Ta3teGqt+g2?=
 =?us-ascii?Q?1akUHIVawRU5xDm320DVOWCDSIAXd102yyq37gm9egOupyfz2UGjduNSlr9k?=
 =?us-ascii?Q?3QuljjQxiiB9O3jdW9/GQnHrMEaUBJkevbLTiGq/oNZSnc+G4jhVzNcfFuzY?=
 =?us-ascii?Q?iu6YVISF8h5lJITfoSg7MJ70PXXY0ZjbQs5vrPOWeOM0lzOrFPgmsayAjCOu?=
 =?us-ascii?Q?p5aW9ZP4wGsSkdIBpFgu+mpK3YFIse5p+5RqZP+Ee7GjoKAxsG8hWSxVzI2W?=
 =?us-ascii?Q?KdFnr5lmc+096RmFl3HNA7RBp+LXJiH5KsmRL5t2pH0OMOd9g0ZWQh7QoO2n?=
 =?us-ascii?Q?xJaKmDNYIYpDOrg2Qh2PrtgZUchgfAFwe4gADZyDcuBRQPsfkjdBzLxY28FV?=
 =?us-ascii?Q?RJTQLMW0EbelEt5su4VGwKAwovU1ue2ocTlCcYtnRmpR70/ySm37s6R53vXS?=
 =?us-ascii?Q?j/A0GFc0ML3YBLOW8AwMdKub5nIsK09CSNDv5QCVOtWNelrPkN71Z7rRgR7Y?=
 =?us-ascii?Q?o8NLwyk5okIO15L5PyDp5tE+pKXe8M8oJsGjkqSgGTyIOd/QSuqyeIEdy6+Y?=
 =?us-ascii?Q?wQjM7feEtdTjqv78V1fMDHL83GrmAhR27jsjxVk8Ewfb5yZcaswI8Dxe3h+4?=
 =?us-ascii?Q?XFncrhyE3MrTWi8qGTCI9BhAgk3wnCsmT3rOFls7uQycZ972ZMwkoP9fmQX0?=
 =?us-ascii?Q?1D8tiSCLvFUMXrvC+5Qx6mEMOVLFKzDTF1j0dlVYaIoH4ACVBvIxdeDV66Dm?=
 =?us-ascii?Q?ScbeQdY8K1P84SEnrIKFv/GpmjWN?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7726.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?aoSjW1xmiQCkcLpEyO0m6Q00us6Sj+9bWHS/USw+gdW3fRkzmxtLJ91WpuKN?=
 =?us-ascii?Q?WTQnFubrt6tbLGOp2tFhbqymmXqro/DnkReErEDrKy8luNF4rlIhATgroT7T?=
 =?us-ascii?Q?SLXeNcMe7htGI9vTgOrtyITQdKzx0UY1ZzJj130rqmVLOej5yNnuPPGi8HZm?=
 =?us-ascii?Q?EThZbpZWUL4JsNTLMuaqfR6HIh+RqYtLI3mHZiSJZyDnPJLli93Rh0GoZ3pQ?=
 =?us-ascii?Q?pRf5AWsyZn0qIMNPOLEi/33w5BWX0TLw7uUs22GpbQoMZouCLAZSz+WozeXN?=
 =?us-ascii?Q?hys5LdFgZ43Ck4YM2Zo8W42D3ERQqsRq9hyaDtF9DH2Fk8Gs+K3twNz2YhIj?=
 =?us-ascii?Q?+8vzDRaRrvDKkwUN00NjPs25C9OaRl+XshTLv9IZ4xg00rB69gHTrb9h8/0W?=
 =?us-ascii?Q?/Ju0/vVVJdlDS6whYVNnxGbwMRc398AYsOzvOhCVDiLSaB3GVwAKEEIe+i4B?=
 =?us-ascii?Q?tZEyHdKo52Er2yWlQKE0Nle6GFi5lAPYZVvnscmRX+pQ22jHooPtmnTti8dZ?=
 =?us-ascii?Q?zASKMzhF77y4WWyWVwMCXIZ925+A/M8UU63ZhM3/CrMFSCtT75AY5pJgc+p6?=
 =?us-ascii?Q?rFNauX/w3P3UNKrtnG391fRzWtlvRNKfxPE+t5F7PYQlq7+0+2sPlnv/m4qY?=
 =?us-ascii?Q?nJ63g/yKOcttPHC5w3S37nKH6Y5MIfuvkjG5MRS0Cfj519OT3GJsO6SJpnZe?=
 =?us-ascii?Q?UiIn8IQV0VAVa5JHjSuZbT+ggk/CsJlHSIiYHJMnRAcehqdOV3FoQS8J+CXh?=
 =?us-ascii?Q?BXkgo5fkUkQxQQog9fXCR4gOvDEFPBo5+mldwatio9CgjzpUBbYkWPDksNYZ?=
 =?us-ascii?Q?u5tCdaXfjnsuGMwMDffcbP5wd/14W8ZWc3lqeVE8PEbVJ984v9XIcZ9yE5VP?=
 =?us-ascii?Q?7Ib4Z00NXtDlHef6gIFIs8HC5G7zDyygIKJib0yoxC20NrcODHXAVDCKu+U4?=
 =?us-ascii?Q?bcc87Qajq0AEI/Nekzg14xzUKalYCoX+Jb+fhLS6bZMfuKTG38fi+T6W94co?=
 =?us-ascii?Q?b7HDCqqvA+waz1iq9UJy/UcEeJRXr8gHyEbN6889pAEibH36/bBtrqYmsliy?=
 =?us-ascii?Q?lr4BICVxBryCD2hOSgcYz9IzHeEmdg4DEczUaOKyrIo/kl+1H+obZ/ByA0fQ?=
 =?us-ascii?Q?wGx3pzQERqBRXWVYipFHl+pW5eS/NAXSrUfnGGc0XAnd/z51948kdkGcHnQ+?=
 =?us-ascii?Q?SI9MtdCWLwHYUVq14bY7Cp/RCcN6Z5BsQXEWqts35gYHLwEp5Z9JXbQMJwjI?=
 =?us-ascii?Q?+7S8MTBP4b/Yo6RCdSnjYiV9xr0f70Sbeq/ibY3N8DKmvETJalPhWh0QX5YE?=
 =?us-ascii?Q?A40V2wrHf36GlquG4pgQB4uQ5pEzkL/+hhykzPGtc9w4OWFLYIWDm9gPJSIZ?=
 =?us-ascii?Q?K2nxnYTjF8OnVipl4EXrx91BFeF8u5z6s18SzN0QxIuq/CcpCqajI3RaQy7i?=
 =?us-ascii?Q?okhI64/kiRKxc9EzUcUgj9VVUlpOIVq554nfideH6JlGw/3AKo8Tyr+V9p2T?=
 =?us-ascii?Q?FjZz4p/+5ZK7d9FFbEjZgxZV8cuZt9sd6tA0bCUgdLcG4fdSSjSNnXT6+N0W?=
 =?us-ascii?Q?uj9xUfJGoQkMcHwbAn3KDLPwkQj2KHfE3OsqqCn/?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e925002d-6ced-43ac-8cb3-08dd4fd02a7e
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7726.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2025 03:56:04.4018
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4/q7/2UNWs4qDxKLzra0Dhb9gzjDyBNnaus/nLBPmVRF2wpV4KamoZrNiXHSiLBIs0COEEbM5JYA8d1sZcLRpg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6789

Several functions internal to FS DAX use the following pattern when
trying to obtain an unlocked entry:

    xas_for_each(&xas, entry, end_idx) {
	if (dax_is_locked(entry))
	    entry = get_unlocked_entry(&xas, 0);

This is problematic because get_unlocked_entry() will get the next
present entry in the range, and the next entry may not be
locked. Therefore any processing of the original locked entry will be
skipped. This can cause dax_layout_busy_page_range() to miss DMA-busy
pages in the range, leading file systems to free blocks whilst DMA
operations are ongoing which can lead to file system corruption.

Instead callers from within a xas_for_each() loop should be waiting
for the current entry to be unlocked without advancing the XArray
state so a new function is introduced to wait.

Also while we are here rename get_unlocked_entry() to
get_next_unlocked_entry() to make it clear that it may advance the
iterator state.

Signed-off-by: Alistair Popple <apopple@nvidia.com>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
---
 fs/dax.c | 50 +++++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 41 insertions(+), 9 deletions(-)

diff --git a/fs/dax.c b/fs/dax.c
index b35f538..f5fdb43 100644
--- a/fs/dax.c
+++ b/fs/dax.c
@@ -206,7 +206,7 @@ static void dax_wake_entry(struct xa_state *xas, void *entry,
  *
  * Must be called with the i_pages lock held.
  */
-static void *get_unlocked_entry(struct xa_state *xas, unsigned int order)
+static void *get_next_unlocked_entry(struct xa_state *xas, unsigned int order)
 {
 	void *entry;
 	struct wait_exceptional_entry_queue ewait;
@@ -236,6 +236,37 @@ static void *get_unlocked_entry(struct xa_state *xas, unsigned int order)
 }
 
 /*
+ * Wait for the given entry to become unlocked. Caller must hold the i_pages
+ * lock and call either put_unlocked_entry() if it did not lock the entry or
+ * dax_unlock_entry() if it did. Returns an unlocked entry if still present.
+ */
+static void *wait_entry_unlocked_exclusive(struct xa_state *xas, void *entry)
+{
+	struct wait_exceptional_entry_queue ewait;
+	wait_queue_head_t *wq;
+
+	init_wait(&ewait.wait);
+	ewait.wait.func = wake_exceptional_entry_func;
+
+	while (unlikely(dax_is_locked(entry))) {
+		wq = dax_entry_waitqueue(xas, entry, &ewait.key);
+		prepare_to_wait_exclusive(wq, &ewait.wait,
+					TASK_UNINTERRUPTIBLE);
+		xas_pause(xas);
+		xas_unlock_irq(xas);
+		schedule();
+		finish_wait(wq, &ewait.wait);
+		xas_lock_irq(xas);
+		entry = xas_load(xas);
+	}
+
+	if (xa_is_internal(entry))
+		return NULL;
+
+	return entry;
+}
+
+/*
  * The only thing keeping the address space around is the i_pages lock
  * (it's cycled in clear_inode() after removing the entries from i_pages)
  * After we call xas_unlock_irq(), we cannot touch xas->xa.
@@ -250,7 +281,7 @@ static void wait_entry_unlocked(struct xa_state *xas, void *entry)
 
 	wq = dax_entry_waitqueue(xas, entry, &ewait.key);
 	/*
-	 * Unlike get_unlocked_entry() there is no guarantee that this
+	 * Unlike get_next_unlocked_entry() there is no guarantee that this
 	 * path ever successfully retrieves an unlocked entry before an
 	 * inode dies. Perform a non-exclusive wait in case this path
 	 * never successfully performs its own wake up.
@@ -581,7 +612,7 @@ static void *grab_mapping_entry(struct xa_state *xas,
 retry:
 	pmd_downgrade = false;
 	xas_lock_irq(xas);
-	entry = get_unlocked_entry(xas, order);
+	entry = get_next_unlocked_entry(xas, order);
 
 	if (entry) {
 		if (dax_is_conflict(entry))
@@ -717,8 +748,7 @@ struct page *dax_layout_busy_page_range(struct address_space *mapping,
 	xas_for_each(&xas, entry, end_idx) {
 		if (WARN_ON_ONCE(!xa_is_value(entry)))
 			continue;
-		if (unlikely(dax_is_locked(entry)))
-			entry = get_unlocked_entry(&xas, 0);
+		entry = wait_entry_unlocked_exclusive(&xas, entry);
 		if (entry)
 			page = dax_busy_page(entry);
 		put_unlocked_entry(&xas, entry, WAKE_NEXT);
@@ -751,7 +781,7 @@ static int __dax_invalidate_entry(struct address_space *mapping,
 	void *entry;
 
 	xas_lock_irq(&xas);
-	entry = get_unlocked_entry(&xas, 0);
+	entry = get_next_unlocked_entry(&xas, 0);
 	if (!entry || WARN_ON_ONCE(!xa_is_value(entry)))
 		goto out;
 	if (!trunc &&
@@ -777,7 +807,9 @@ static int __dax_clear_dirty_range(struct address_space *mapping,
 
 	xas_lock_irq(&xas);
 	xas_for_each(&xas, entry, end) {
-		entry = get_unlocked_entry(&xas, 0);
+		entry = wait_entry_unlocked_exclusive(&xas, entry);
+		if (!entry)
+			continue;
 		xas_clear_mark(&xas, PAGECACHE_TAG_DIRTY);
 		xas_clear_mark(&xas, PAGECACHE_TAG_TOWRITE);
 		put_unlocked_entry(&xas, entry, WAKE_NEXT);
@@ -941,7 +973,7 @@ static int dax_writeback_one(struct xa_state *xas, struct dax_device *dax_dev,
 	if (unlikely(dax_is_locked(entry))) {
 		void *old_entry = entry;
 
-		entry = get_unlocked_entry(xas, 0);
+		entry = get_next_unlocked_entry(xas, 0);
 
 		/* Entry got punched out / reallocated? */
 		if (!entry || WARN_ON_ONCE(!xa_is_value(entry)))
@@ -1950,7 +1982,7 @@ dax_insert_pfn_mkwrite(struct vm_fault *vmf, pfn_t pfn, unsigned int order)
 	vm_fault_t ret;
 
 	xas_lock_irq(&xas);
-	entry = get_unlocked_entry(&xas, order);
+	entry = get_next_unlocked_entry(&xas, order);
 	/* Did we race with someone splitting entry or so? */
 	if (!entry || dax_is_conflict(entry) ||
 	    (order == 0 && !dax_is_pte_entry(entry))) {
-- 
git-series 0.9.1

