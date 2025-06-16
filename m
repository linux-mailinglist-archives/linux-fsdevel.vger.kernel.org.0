Return-Path: <linux-fsdevel+bounces-51737-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C0CA6ADAF9A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Jun 2025 14:02:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8EB6D174575
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Jun 2025 12:01:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93DF4292B2D;
	Mon, 16 Jun 2025 11:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ccuL3Vqo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2075.outbound.protection.outlook.com [40.107.212.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 998F2292B2B;
	Mon, 16 Jun 2025 11:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750075159; cv=fail; b=WxsYpOKX32+KE1iZAoTMjL54FlX9lrXn/uBiyHXRuuDvPIBsFyjAEsnsFbT+rPKofbimP9bvlfrqN4CLB6zOF2BRR20VXYV9Jo4IINILbWgRllP1bw5PJpkOvUKdMuDoytOit6yubaXvt/IvyvLcP5g/7WfX7DNAgbFQ8fizg0s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750075159; c=relaxed/simple;
	bh=hvacyAYZpJ29By5PHPL4iifK9X+Y14c6Eu7BQOD6MkM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tb1KO7pH4T/EWpKwNXXPboy6w/zLQDAkK4rhn3ycyCi8OBo12GBO/hCOkyh1PvagJLSloAJMvqf2yq5k7pMq/Yvd33I4DC6JOOdux9vC8OQ/rr4l0mH4IAPbGslgcN5z6xgA080qzat+JG4HjkgZoTtQANaAOobO754aye/9Pc0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ccuL3Vqo; arc=fail smtp.client-ip=40.107.212.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RYvSulzndSUTiKOfLUv3Z+y+z6I5rXX4o7eltwvBfoxFratpa7nVujq/8jpghDs4bNTz+2CM3flJC1DUXa2cHe3GlO4bvZpgUpc1qiYpIdGQ2QIMsXbOWl/tOpntDNIZs7TUyK0CHR5a5cBB6cSl9D6CJxdhZUbnCifD59xvJ41i0UJp0Z60JoINYugApwn2tjKPwQlbTiVIUKnXAQ1gD08HRYSfh3p5dtCIkEz701GLh6zBfW2YbXAOhq9xKEYtyKoz8FTEoN/nqwXcy3JOXHmqmYvZmOfaiwUUo+A8dF2TvvacpIxL0NGsUUeZnWHq/aCZuASsFRFuadOYRC+5NQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GOerLYyf1ImKN1bEKJEgYeNLH7L6bIor6Eo+vPUwheQ=;
 b=nXj6T2bDu6P0XKeeTRbnf+pYThEDhIefsrGzWn04BOypa20MgV9Si+0T5UiQQcQGUoJPykB9F/9ZXYMUDpB8sSI7ep4wYpbXkHDlzvH9J6jtEqKMrJCzG1Nq192Ut4zY0Z97w6ruL+wQTsdE04nS5G7rW+YOAqYdN9ssUBQSKmFp15YjZLNC/9IA9E0eJXrJWsbKMDw2mQo4qmFWqJIUW6Y3n05HLG1BCnW36eCk9c6lCEeP6OHpQGShExCDT2nIf2VqYwe/YkMr30IhwyKsGX0SF79YcfuiDo30rKxSXONugxWwySqnB3wKoYrR2DQOoFNZCWiLkQKMpf5xFdfEkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GOerLYyf1ImKN1bEKJEgYeNLH7L6bIor6Eo+vPUwheQ=;
 b=ccuL3VqoE6Q1Lc3CG6Jmg1AHL9Qi5PPfUBMMUk2eag/1yhpQE000qHVwdtjv7lUQqhscu9h6XZ1+kZNeLS05RID6akBxyoYB2bfCoanDHFKlgiBaEMwq2d8POqJsl7kU/CYMoZCAlj17NKR+HDQLQfGd2W7/LUKcFXi1pnjJSWcSIYHwTaHy5JuAAXfsVd+20kLhbzfArm9D9deU3SRkMF4YDmbZsnHFyoJKD9W/2BrsJ/1tY+cnZ87MilMZlfcyhqefijKSYjxjtTooPe1POp9guVWt/PC9Ra70jYo3pxmUpfQVuNG6UXo7tulKqY5CqLAQ4tmtbf9vy0UUfoI+kw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY8PR12MB7705.namprd12.prod.outlook.com (2603:10b6:930:84::9)
 by SA3PR12MB7878.namprd12.prod.outlook.com (2603:10b6:806:31e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.29; Mon, 16 Jun
 2025 11:59:12 +0000
Received: from CY8PR12MB7705.namprd12.prod.outlook.com
 ([fe80::4b06:5351:3db4:95f6]) by CY8PR12MB7705.namprd12.prod.outlook.com
 ([fe80::4b06:5351:3db4:95f6%5]) with mapi id 15.20.8835.026; Mon, 16 Jun 2025
 11:59:11 +0000
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
Subject: [PATCH v2 07/14] mm: Remove redundant pXd_devmap calls
Date: Mon, 16 Jun 2025 21:58:09 +1000
Message-ID: <e401105809fcdd3e82ff292f30c29403ecbd3982.1750075065.git-series.apopple@nvidia.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <cover.8d04615eb17b9e46fc0ae7402ca54b69e04b1043.1750075065.git-series.apopple@nvidia.com>
References: <cover.8d04615eb17b9e46fc0ae7402ca54b69e04b1043.1750075065.git-series.apopple@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SY5P282CA0008.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:10:208::7) To CY8PR12MB7705.namprd12.prod.outlook.com
 (2603:10b6:930:84::9)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR12MB7705:EE_|SA3PR12MB7878:EE_
X-MS-Office365-Filtering-Correlation-Id: c028d4dc-fb1b-4925-0e6d-08ddaccd3532
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?jAvslmT9NN3N/BdG2+R7dtr3CaWWgUAu2Ja6gDos/TSMtI/QYjOLGIfKs7ZN?=
 =?us-ascii?Q?TudHKHm6u83S65Q7uNCr+zHTZMKMogeJktAc3W/PRso0S07srnIahQbbJOkg?=
 =?us-ascii?Q?OLXgdRM5Mj1P9yqnn2RWKTKkN888pw9u2Z+HPOD20194ZJ/WKQYmt/j8bl0h?=
 =?us-ascii?Q?Uayi6as/Iygl7E6EGUZnEgbC/94oqtbac85Cm6pbPEPermNEiaPNbcG80Fys?=
 =?us-ascii?Q?ofdrip6ZLsYIshQRgD2MkBF/fiSjFs13UGT2pAcPi6/jGMfk0DxUVmpk5sPv?=
 =?us-ascii?Q?7FDnXk0d9v6C/XJKOkCU938MTpH+kaawP201hR1CxjV90dmGBlAzZ7w49Q3t?=
 =?us-ascii?Q?G+R91wBnugASy0jZz9GNq/13DutxREsfgMtcgewCTZIKu3rwt7idvTC04yoR?=
 =?us-ascii?Q?uJGjN6rnPPYMfz2BEkBp57vkysk2ReFrtbuDayRVAMYxD2zISsNpKECcYExB?=
 =?us-ascii?Q?KUjSTyJ3fBwL0Zh8ROvhlRz1BEHIA+U4pFP+TGLOTMYXhjoLR+MDlkkONX4b?=
 =?us-ascii?Q?GFT0DZo0p953d1Su68afN2aCbh2nHl86sXUTptyyrYqB5xYQCEnWivVghnam?=
 =?us-ascii?Q?NmC6vOKRkAlztay9zqTQ4eekf/OTAgizgrmPczUBLEh7JOQPUmKQNumowBSM?=
 =?us-ascii?Q?Tbo2cD/2R/V7MgQDOK+3rBvi/SMMfOOIXAoR61y3UJvXSrOS7eZu1pRw4Iks?=
 =?us-ascii?Q?4h8OxfFjy/OECo8R8c0KOGIi4151Muar/q49kgkDEnKfb+U59aqFGYTCkJzG?=
 =?us-ascii?Q?Cjhi4j5fqic8qxqv0uzrkGKrH+VKMCbdqZ1E1aGhTeIIzsLv99WCpVPnVEQN?=
 =?us-ascii?Q?82CUeYOZBRPIVyiEQEheLfvXtqFFxfiwJe5K/JJevbcMKeuE/6zLkKjCg9ED?=
 =?us-ascii?Q?kLWwI4FW65xlEZ6JcrX7fcn+I+crTFzJJlnBqfMRIMvEkv02LbL34UJKSmyC?=
 =?us-ascii?Q?N7181ESy9ANzUazAyeyyLY24yNcxUv4c6aqBd6BqBpZr+MDY6xHmOXNWA9e1?=
 =?us-ascii?Q?5wbMa8ZIur+/aKzCuSOUnHMhCAfm8JhpQKJMCys9jY8mrtVSM68PQESQni1T?=
 =?us-ascii?Q?FObU7X/ybZyXZtnlLORgrWHwGGsprs+ANPiNcaRcRI+bpEswuWs9GAH/kx52?=
 =?us-ascii?Q?IQmmak6ghP44hJIPHK7Gj5AdBLWm2XE1XATppUCTvnZuA9az/MRGX05JEGO9?=
 =?us-ascii?Q?3q5ZoUNZ1/5dWEbkmvbcM4t9awkRe6iuAhNZW/aaPl9YXVkWx+BTBHFMBX3q?=
 =?us-ascii?Q?7D7OsSa9CKcLvKlwc/lITLwoYp7GDN3aKW3PDpG8b5cQ1rRlJZjSKD1dz0RO?=
 =?us-ascii?Q?PnVRhW9q5NKjbFBav+Lj2n1n5u2CF1JIOIjDkxDIUjsc46Aqd2ujwc79GgeY?=
 =?us-ascii?Q?WhmK3lLLSSqSLOraldHN9YIsj7F8WXO40yvwmU9Oum/eoW8IqEBnclDJARyR?=
 =?us-ascii?Q?NpNQkz2oQVE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR12MB7705.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fQ/xrNR6VYUa3eNuLQxzO4zJFxVpBIImLkcczwP+OvFok4GTjQNNTxYpgdrR?=
 =?us-ascii?Q?fUp4EXcrC7n02FfsiaoRLKm3vRzAK/PuMqTKC2yqZwzDYVxM8fWOr7kG96Ag?=
 =?us-ascii?Q?FN/nMzaIvNRKCIFiHQIzf5IVE0LhpGTjn9pINbjoaLztVwMCho2xJjUZHDLO?=
 =?us-ascii?Q?sDJSuMqVgwaKToLFUI9CDawwaFdavvViGxkOsJZvTjgvzEc9K33P5yPwcZcG?=
 =?us-ascii?Q?PkoOgeuY/wAmRH2kRCbpQA5DZWnlHUZq65BXqT0ZWImgtiASb8RZalJhEpOU?=
 =?us-ascii?Q?EFTx+mZzsEL/Ezj7SWUR/ST+NHxZJF9SGKDzqZ54yc2HPXQ/6D8Y8I3m70EL?=
 =?us-ascii?Q?8CEzJ4Gmsxh50ncj3Hnkt+JUvLfvBPvLeQSUbiqyr9nHL1DbvmFkI+tPz1Ma?=
 =?us-ascii?Q?SjOfo3pXkb88MVFfmifnLMEjLsZvYH+KGcc58fSxCgd+WncuBbPi764WWg1G?=
 =?us-ascii?Q?gLtFyMBp8s0fnX/cIE4rsLuk8Cyt2CoLGC5EPyaQjghDpaZKHLx9vBCVdDLl?=
 =?us-ascii?Q?WjwSbgankF/VTQMJUN8hJuMb4MdSYb8RG8Yhkef7MLXAGQxFrV5HW7I7B6GA?=
 =?us-ascii?Q?GtnmK1rh+nj8tPfSOpv9OTVv9SaIY1Syb9nubAsnC5IbubK0D33Dwd/1CenZ?=
 =?us-ascii?Q?EwdWMSJkLvVIOeItmqQB2658Mhjg8FByFIlIlCSrgx0z0nfbgFUPplRbNMDL?=
 =?us-ascii?Q?OTVlLdwHzhlyJkLCuQqEL8f07Epog5dYdQQzFyYHB4FtQoojXWRx6zKmNBXu?=
 =?us-ascii?Q?tpzAVNljpO4EAD0bfoZCCzBIZug7BQ1jcnr8fPv54KCWz+4EpukHAg/DGCId?=
 =?us-ascii?Q?BzZi1VwCp7I7U6S5O2RI6eX9CunQt95U0wEKUE3V56g94ixzxLtEnRDl59Fl?=
 =?us-ascii?Q?J3T3Wqzau3Ha0dTgOM8ZntJjnlbB7xX7ct1DJYmMLhgAJVBlT2e8Xk/GGQTR?=
 =?us-ascii?Q?Wf6e276H7FMCEl9AtO/jW6XK5rF6gQbYsBsZCJMjNjPjdm4dTi3FQ5oChsu4?=
 =?us-ascii?Q?b5OS1yCDq0ZPivOd/DVVwZFOUcTFJk4ve1OQQv+4Ki968eS9HejpjqKJgoa/?=
 =?us-ascii?Q?BWh+P5CpYoNPvBKBuY0AVjGrODO/EG6wztDR0ajvfi/4kcK3RWrXF9O346e7?=
 =?us-ascii?Q?vcWC0/xEJLnOng8BKZ4YgQrzdbwjCFIEAIBRl4mrPA4l6OTYZscQctaSLdDp?=
 =?us-ascii?Q?tMQj6d3BqGxmTYEIxxciAFGOk3nkS16St2PKRI4EZvgUSy2yORtrHue2Y2+r?=
 =?us-ascii?Q?8GyyqRuywyDuPoKxV0PS+y4Wmf/yz8q/I0x0iNUVAFQ0aZrh0u1Ll+ssfBhd?=
 =?us-ascii?Q?I9gUATvhUozx61x7ZHFlgR9hj3AZMRG+/99Op882buYRV6/n3wP0EBVLAAj6?=
 =?us-ascii?Q?e8vhsONJcfuMjqTlRKc3yx2CCqiFNs5laSA9za6Hgm8nPeW/wcEy2tRCgCZQ?=
 =?us-ascii?Q?NeuM8GkZqc5mGslSC/yTvw4VlzFYCwvoeaT9irzRAYccOWm+sDW3Xdl+gj4y?=
 =?us-ascii?Q?51+QUfzhUBU/mZB3lLoaCkU65K4xq/ZmgDw2pn3eCjIPP/cQ8O6KI+KWKPmo?=
 =?us-ascii?Q?1KdvSt2nontImeP8Q0VbHc6gGnZ4tFuUKaVLA8ye?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c028d4dc-fb1b-4925-0e6d-08ddaccd3532
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7705.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2025 11:59:11.9223
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Gi/3WXPL4OlEjUNa1vAWybGqsp8qtllP6oyXkr9jhn0P7FJABx63GR2f9lFRWLmpz1zsOMqKNFEFbYGCAOJKWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7878

DAX was the only thing that created pmd_devmap and pud_devmap entries
however it no longer does as DAX pages are now refcounted normally and
pXd_trans_huge() returns true for those. Therefore checking both pXd_devmap
and pXd_trans_huge() is redundant and the former can be removed without
changing behaviour as it will always be false.

Signed-off-by: Alistair Popple <apopple@nvidia.com>

---

Changes since v1:

 - Removed a new pud_devmap() call added to __relocate_anon_folios().
   This could never have been hit as only DAX created pud_devmap entries
   and never for anonymous VMA's.
---
 fs/dax.c                   |  5 ++---
 include/linux/huge_mm.h    | 10 ++++------
 include/linux/pgtable.h    |  2 +-
 mm/hmm.c                   |  4 ++--
 mm/huge_memory.c           | 23 +++++++++--------------
 mm/mapping_dirty_helpers.c |  4 ++--
 mm/memory.c                | 15 ++++++---------
 mm/migrate_device.c        |  2 +-
 mm/mprotect.c              |  2 +-
 mm/mremap.c                |  9 +++------
 mm/page_vma_mapped.c       |  5 ++---
 mm/pagewalk.c              |  8 +++-----
 mm/pgtable-generic.c       |  7 +++----
 mm/userfaultfd.c           |  4 ++--
 mm/vmscan.c                |  3 ---
 15 files changed, 41 insertions(+), 62 deletions(-)

diff --git a/fs/dax.c b/fs/dax.c
index ea0c357..7d4ecb9 100644
--- a/fs/dax.c
+++ b/fs/dax.c
@@ -1937,7 +1937,7 @@ static vm_fault_t dax_iomap_pte_fault(struct vm_fault *vmf, pfn_t *pfnp,
 	 * the PTE we need to set up.  If so just return and the fault will be
 	 * retried.
 	 */
-	if (pmd_trans_huge(*vmf->pmd) || pmd_devmap(*vmf->pmd)) {
+	if (pmd_trans_huge(*vmf->pmd)) {
 		ret = VM_FAULT_NOPAGE;
 		goto unlock_entry;
 	}
@@ -2060,8 +2060,7 @@ static vm_fault_t dax_iomap_pmd_fault(struct vm_fault *vmf, pfn_t *pfnp,
 	 * the PMD we need to set up.  If so just return and the fault will be
 	 * retried.
 	 */
-	if (!pmd_none(*vmf->pmd) && !pmd_trans_huge(*vmf->pmd) &&
-			!pmd_devmap(*vmf->pmd)) {
+	if (!pmd_none(*vmf->pmd) && !pmd_trans_huge(*vmf->pmd)) {
 		ret = 0;
 		goto unlock_entry;
 	}
diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index 519c3f0..21b3f0b 100644
--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -400,8 +400,7 @@ void __split_huge_pmd(struct vm_area_struct *vma, pmd_t *pmd,
 #define split_huge_pmd(__vma, __pmd, __address)				\
 	do {								\
 		pmd_t *____pmd = (__pmd);				\
-		if (is_swap_pmd(*____pmd) || pmd_trans_huge(*____pmd)	\
-					|| pmd_devmap(*____pmd))	\
+		if (is_swap_pmd(*____pmd) || pmd_trans_huge(*____pmd))	\
 			__split_huge_pmd(__vma, __pmd, __address,	\
 					 false);			\
 	}  while (0)
@@ -426,8 +425,7 @@ change_huge_pud(struct mmu_gather *tlb, struct vm_area_struct *vma,
 #define split_huge_pud(__vma, __pud, __address)				\
 	do {								\
 		pud_t *____pud = (__pud);				\
-		if (pud_trans_huge(*____pud)				\
-					|| pud_devmap(*____pud))	\
+		if (pud_trans_huge(*____pud))				\
 			__split_huge_pud(__vma, __pud, __address);	\
 	}  while (0)
 
@@ -450,7 +448,7 @@ static inline int is_swap_pmd(pmd_t pmd)
 static inline spinlock_t *pmd_trans_huge_lock(pmd_t *pmd,
 		struct vm_area_struct *vma)
 {
-	if (is_swap_pmd(*pmd) || pmd_trans_huge(*pmd) || pmd_devmap(*pmd))
+	if (is_swap_pmd(*pmd) || pmd_trans_huge(*pmd))
 		return __pmd_trans_huge_lock(pmd, vma);
 	else
 		return NULL;
@@ -458,7 +456,7 @@ static inline spinlock_t *pmd_trans_huge_lock(pmd_t *pmd,
 static inline spinlock_t *pud_trans_huge_lock(pud_t *pud,
 		struct vm_area_struct *vma)
 {
-	if (pud_trans_huge(*pud) || pud_devmap(*pud))
+	if (pud_trans_huge(*pud))
 		return __pud_trans_huge_lock(pud, vma);
 	else
 		return NULL;
diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
index e4a3895..0298e55 100644
--- a/include/linux/pgtable.h
+++ b/include/linux/pgtable.h
@@ -1672,7 +1672,7 @@ static inline int pud_trans_unstable(pud_t *pud)
 	defined(CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD)
 	pud_t pudval = READ_ONCE(*pud);
 
-	if (pud_none(pudval) || pud_trans_huge(pudval) || pud_devmap(pudval))
+	if (pud_none(pudval) || pud_trans_huge(pudval))
 		return 1;
 	if (unlikely(pud_bad(pudval))) {
 		pud_clear_bad(pud);
diff --git a/mm/hmm.c b/mm/hmm.c
index 1a3489f..f1b579f 100644
--- a/mm/hmm.c
+++ b/mm/hmm.c
@@ -360,7 +360,7 @@ static int hmm_vma_walk_pmd(pmd_t *pmdp,
 		return hmm_pfns_fill(start, end, range, HMM_PFN_ERROR);
 	}
 
-	if (pmd_devmap(pmd) || pmd_trans_huge(pmd)) {
+	if (pmd_trans_huge(pmd)) {
 		/*
 		 * No need to take pmd_lock here, even if some other thread
 		 * is splitting the huge pmd we will get that event through
@@ -371,7 +371,7 @@ static int hmm_vma_walk_pmd(pmd_t *pmdp,
 		 * values.
 		 */
 		pmd = pmdp_get_lockless(pmdp);
-		if (!pmd_devmap(pmd) && !pmd_trans_huge(pmd))
+		if (!pmd_trans_huge(pmd))
 			goto again;
 
 		return hmm_vma_handle_pmd(walk, addr, end, hmm_pfns, pmd);
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 6514e25..642fd83 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1459,8 +1459,7 @@ vm_fault_t vmf_insert_pfn_pmd(struct vm_fault *vmf, pfn_t pfn, bool write)
 	 * but we need to be consistent with PTEs and architectures that
 	 * can't support a 'special' bit.
 	 */
-	BUG_ON(!(vma->vm_flags & (VM_PFNMAP|VM_MIXEDMAP)) &&
-			!pfn_t_devmap(pfn));
+	BUG_ON(!(vma->vm_flags & (VM_PFNMAP|VM_MIXEDMAP)));
 	BUG_ON((vma->vm_flags & (VM_PFNMAP|VM_MIXEDMAP)) ==
 						(VM_PFNMAP|VM_MIXEDMAP));
 	BUG_ON((vma->vm_flags & VM_PFNMAP) && is_cow_mapping(vma->vm_flags));
@@ -1596,8 +1595,7 @@ vm_fault_t vmf_insert_pfn_pud(struct vm_fault *vmf, pfn_t pfn, bool write)
 	 * but we need to be consistent with PTEs and architectures that
 	 * can't support a 'special' bit.
 	 */
-	BUG_ON(!(vma->vm_flags & (VM_PFNMAP|VM_MIXEDMAP)) &&
-			!pfn_t_devmap(pfn));
+	BUG_ON(!(vma->vm_flags & (VM_PFNMAP|VM_MIXEDMAP)));
 	BUG_ON((vma->vm_flags & (VM_PFNMAP|VM_MIXEDMAP)) ==
 						(VM_PFNMAP|VM_MIXEDMAP));
 	BUG_ON((vma->vm_flags & VM_PFNMAP) && is_cow_mapping(vma->vm_flags));
@@ -1815,7 +1813,7 @@ int copy_huge_pud(struct mm_struct *dst_mm, struct mm_struct *src_mm,
 
 	ret = -EAGAIN;
 	pud = *src_pud;
-	if (unlikely(!pud_trans_huge(pud) && !pud_devmap(pud)))
+	if (unlikely(!pud_trans_huge(pud)))
 		goto out_unlock;
 
 	/*
@@ -2677,8 +2675,7 @@ spinlock_t *__pmd_trans_huge_lock(pmd_t *pmd, struct vm_area_struct *vma)
 {
 	spinlock_t *ptl;
 	ptl = pmd_lock(vma->vm_mm, pmd);
-	if (likely(is_swap_pmd(*pmd) || pmd_trans_huge(*pmd) ||
-			pmd_devmap(*pmd)))
+	if (likely(is_swap_pmd(*pmd) || pmd_trans_huge(*pmd)))
 		return ptl;
 	spin_unlock(ptl);
 	return NULL;
@@ -2695,7 +2692,7 @@ spinlock_t *__pud_trans_huge_lock(pud_t *pud, struct vm_area_struct *vma)
 	spinlock_t *ptl;
 
 	ptl = pud_lock(vma->vm_mm, pud);
-	if (likely(pud_trans_huge(*pud) || pud_devmap(*pud)))
+	if (likely(pud_trans_huge(*pud)))
 		return ptl;
 	spin_unlock(ptl);
 	return NULL;
@@ -2747,7 +2744,7 @@ static void __split_huge_pud_locked(struct vm_area_struct *vma, pud_t *pud,
 	VM_BUG_ON(haddr & ~HPAGE_PUD_MASK);
 	VM_BUG_ON_VMA(vma->vm_start > haddr, vma);
 	VM_BUG_ON_VMA(vma->vm_end < haddr + HPAGE_PUD_SIZE, vma);
-	VM_BUG_ON(!pud_trans_huge(*pud) && !pud_devmap(*pud));
+	VM_BUG_ON(!pud_trans_huge(*pud));
 
 	count_vm_event(THP_SPLIT_PUD);
 
@@ -2780,7 +2777,7 @@ void __split_huge_pud(struct vm_area_struct *vma, pud_t *pud,
 				(address & HPAGE_PUD_MASK) + HPAGE_PUD_SIZE);
 	mmu_notifier_invalidate_range_start(&range);
 	ptl = pud_lock(vma->vm_mm, pud);
-	if (unlikely(!pud_trans_huge(*pud) && !pud_devmap(*pud)))
+	if (unlikely(!pud_trans_huge(*pud)))
 		goto out;
 	__split_huge_pud_locked(vma, pud, range.start);
 
@@ -2853,8 +2850,7 @@ static void __split_huge_pmd_locked(struct vm_area_struct *vma, pmd_t *pmd,
 	VM_BUG_ON(haddr & ~HPAGE_PMD_MASK);
 	VM_BUG_ON_VMA(vma->vm_start > haddr, vma);
 	VM_BUG_ON_VMA(vma->vm_end < haddr + HPAGE_PMD_SIZE, vma);
-	VM_BUG_ON(!is_pmd_migration_entry(*pmd) && !pmd_trans_huge(*pmd)
-				&& !pmd_devmap(*pmd));
+	VM_BUG_ON(!is_pmd_migration_entry(*pmd) && !pmd_trans_huge(*pmd));
 
 	count_vm_event(THP_SPLIT_PMD);
 
@@ -3062,8 +3058,7 @@ void split_huge_pmd_locked(struct vm_area_struct *vma, unsigned long address,
 			   pmd_t *pmd, bool freeze)
 {
 	VM_WARN_ON_ONCE(!IS_ALIGNED(address, HPAGE_PMD_SIZE));
-	if (pmd_trans_huge(*pmd) || pmd_devmap(*pmd) ||
-	    is_pmd_migration_entry(*pmd))
+	if (pmd_trans_huge(*pmd) || is_pmd_migration_entry(*pmd))
 		__split_huge_pmd_locked(vma, pmd, address, freeze);
 }
 
diff --git a/mm/mapping_dirty_helpers.c b/mm/mapping_dirty_helpers.c
index 2f8829b..208b428 100644
--- a/mm/mapping_dirty_helpers.c
+++ b/mm/mapping_dirty_helpers.c
@@ -129,7 +129,7 @@ static int wp_clean_pmd_entry(pmd_t *pmd, unsigned long addr, unsigned long end,
 	pmd_t pmdval = pmdp_get_lockless(pmd);
 
 	/* Do not split a huge pmd, present or migrated */
-	if (pmd_trans_huge(pmdval) || pmd_devmap(pmdval)) {
+	if (pmd_trans_huge(pmdval)) {
 		WARN_ON(pmd_write(pmdval) || pmd_dirty(pmdval));
 		walk->action = ACTION_CONTINUE;
 	}
@@ -152,7 +152,7 @@ static int wp_clean_pud_entry(pud_t *pud, unsigned long addr, unsigned long end,
 	pud_t pudval = READ_ONCE(*pud);
 
 	/* Do not split a huge pud */
-	if (pud_trans_huge(pudval) || pud_devmap(pudval)) {
+	if (pud_trans_huge(pudval)) {
 		WARN_ON(pud_write(pudval) || pud_dirty(pudval));
 		walk->action = ACTION_CONTINUE;
 	}
diff --git a/mm/memory.c b/mm/memory.c
index 97aaad9..f69e66d 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -675,8 +675,6 @@ struct page *vm_normal_page_pmd(struct vm_area_struct *vma, unsigned long addr,
 		}
 	}
 
-	if (pmd_devmap(pmd))
-		return NULL;
 	if (is_huge_zero_pmd(pmd))
 		return NULL;
 	if (unlikely(pfn > highest_memmap_pfn))
@@ -1240,8 +1238,7 @@ copy_pmd_range(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma,
 	src_pmd = pmd_offset(src_pud, addr);
 	do {
 		next = pmd_addr_end(addr, end);
-		if (is_swap_pmd(*src_pmd) || pmd_trans_huge(*src_pmd)
-			|| pmd_devmap(*src_pmd)) {
+		if (is_swap_pmd(*src_pmd) || pmd_trans_huge(*src_pmd)) {
 			int err;
 			VM_BUG_ON_VMA(next-addr != HPAGE_PMD_SIZE, src_vma);
 			err = copy_huge_pmd(dst_mm, src_mm, dst_pmd, src_pmd,
@@ -1277,7 +1274,7 @@ copy_pud_range(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma,
 	src_pud = pud_offset(src_p4d, addr);
 	do {
 		next = pud_addr_end(addr, end);
-		if (pud_trans_huge(*src_pud) || pud_devmap(*src_pud)) {
+		if (pud_trans_huge(*src_pud)) {
 			int err;
 
 			VM_BUG_ON_VMA(next-addr != HPAGE_PUD_SIZE, src_vma);
@@ -1791,7 +1788,7 @@ static inline unsigned long zap_pmd_range(struct mmu_gather *tlb,
 	pmd = pmd_offset(pud, addr);
 	do {
 		next = pmd_addr_end(addr, end);
-		if (is_swap_pmd(*pmd) || pmd_trans_huge(*pmd) || pmd_devmap(*pmd)) {
+		if (is_swap_pmd(*pmd) || pmd_trans_huge(*pmd)) {
 			if (next - addr != HPAGE_PMD_SIZE)
 				__split_huge_pmd(vma, pmd, addr, false);
 			else if (zap_huge_pmd(tlb, vma, pmd, addr)) {
@@ -1833,7 +1830,7 @@ static inline unsigned long zap_pud_range(struct mmu_gather *tlb,
 	pud = pud_offset(p4d, addr);
 	do {
 		next = pud_addr_end(addr, end);
-		if (pud_trans_huge(*pud) || pud_devmap(*pud)) {
+		if (pud_trans_huge(*pud)) {
 			if (next - addr != HPAGE_PUD_SIZE) {
 				mmap_assert_locked(tlb->mm);
 				split_huge_pud(vma, pud, addr);
@@ -6136,7 +6133,7 @@ static vm_fault_t __handle_mm_fault(struct vm_area_struct *vma,
 		pud_t orig_pud = *vmf.pud;
 
 		barrier();
-		if (pud_trans_huge(orig_pud) || pud_devmap(orig_pud)) {
+		if (pud_trans_huge(orig_pud)) {
 
 			/*
 			 * TODO once we support anonymous PUDs: NUMA case and
@@ -6177,7 +6174,7 @@ static vm_fault_t __handle_mm_fault(struct vm_area_struct *vma,
 				pmd_migration_entry_wait(mm, vmf.pmd);
 			return 0;
 		}
-		if (pmd_trans_huge(vmf.orig_pmd) || pmd_devmap(vmf.orig_pmd)) {
+		if (pmd_trans_huge(vmf.orig_pmd)) {
 			if (pmd_protnone(vmf.orig_pmd) && vma_is_accessible(vma))
 				return do_huge_pmd_numa_page(&vmf);
 
diff --git a/mm/migrate_device.c b/mm/migrate_device.c
index 3158afe..e05e14d 100644
--- a/mm/migrate_device.c
+++ b/mm/migrate_device.c
@@ -615,7 +615,7 @@ static void migrate_vma_insert_page(struct migrate_vma *migrate,
 	pmdp = pmd_alloc(mm, pudp, addr);
 	if (!pmdp)
 		goto abort;
-	if (pmd_trans_huge(*pmdp) || pmd_devmap(*pmdp))
+	if (pmd_trans_huge(*pmdp))
 		goto abort;
 	if (pte_alloc(mm, pmdp))
 		goto abort;
diff --git a/mm/mprotect.c b/mm/mprotect.c
index 88608d0..00d5989 100644
--- a/mm/mprotect.c
+++ b/mm/mprotect.c
@@ -376,7 +376,7 @@ static inline long change_pmd_range(struct mmu_gather *tlb,
 			goto next;
 
 		_pmd = pmdp_get_lockless(pmd);
-		if (is_swap_pmd(_pmd) || pmd_trans_huge(_pmd) || pmd_devmap(_pmd)) {
+		if (is_swap_pmd(_pmd) || pmd_trans_huge(_pmd)) {
 			if ((next - addr != HPAGE_PMD_SIZE) ||
 			    pgtable_split_needed(vma, cp_flags)) {
 				__split_huge_pmd(vma, pmd, addr, false);
diff --git a/mm/mremap.c b/mm/mremap.c
index 7a0657b..6541faa 100644
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -1237,8 +1237,6 @@ static bool __relocate_anon_folios(struct pagetable_move_control *pmc, bool undo
 
 			/* Otherwise, we split so we can do this with PMDs/PTEs. */
 			split_huge_pud(pmc->old, pudp, old_addr);
-		} else if (pud_devmap(pud)) {
-			return false;
 		}
 
 		extent = get_old_extent(NORMAL_PMD, pmc);
@@ -1267,7 +1265,7 @@ static bool __relocate_anon_folios(struct pagetable_move_control *pmc, bool undo
 
 			/* Otherwise, we split so we can do this with PTEs. */
 			split_huge_pmd(pmc->old, pmdp, old_addr);
-		} else if (is_swap_pmd(pmd) || pmd_devmap(pmd)) {
+		} else if (is_swap_pmd(pmd)) {
 			return false;
 		}
 
@@ -1333,7 +1331,7 @@ unsigned long move_page_tables(struct pagetable_move_control *pmc)
 		new_pud = alloc_new_pud(mm, pmc->new_addr);
 		if (!new_pud)
 			break;
-		if (pud_trans_huge(*old_pud) || pud_devmap(*old_pud)) {
+		if (pud_trans_huge(*old_pud)) {
 			if (extent == HPAGE_PUD_SIZE) {
 				move_pgt_entry(pmc, HPAGE_PUD, old_pud, new_pud);
 				/* We ignore and continue on error? */
@@ -1352,8 +1350,7 @@ unsigned long move_page_tables(struct pagetable_move_control *pmc)
 		if (!new_pmd)
 			break;
 again:
-		if (is_swap_pmd(*old_pmd) || pmd_trans_huge(*old_pmd) ||
-		    pmd_devmap(*old_pmd)) {
+		if (is_swap_pmd(*old_pmd) || pmd_trans_huge(*old_pmd)) {
 			if (extent == HPAGE_PMD_SIZE &&
 			    move_pgt_entry(pmc, HPAGE_PMD, old_pmd, new_pmd))
 				continue;
diff --git a/mm/page_vma_mapped.c b/mm/page_vma_mapped.c
index e463c3b..e981a1a 100644
--- a/mm/page_vma_mapped.c
+++ b/mm/page_vma_mapped.c
@@ -246,8 +246,7 @@ bool page_vma_mapped_walk(struct page_vma_mapped_walk *pvmw)
 		 */
 		pmde = pmdp_get_lockless(pvmw->pmd);
 
-		if (pmd_trans_huge(pmde) || is_pmd_migration_entry(pmde) ||
-		    (pmd_present(pmde) && pmd_devmap(pmde))) {
+		if (pmd_trans_huge(pmde) || is_pmd_migration_entry(pmde)) {
 			pvmw->ptl = pmd_lock(mm, pvmw->pmd);
 			pmde = *pvmw->pmd;
 			if (!pmd_present(pmde)) {
@@ -262,7 +261,7 @@ bool page_vma_mapped_walk(struct page_vma_mapped_walk *pvmw)
 					return not_found(pvmw);
 				return true;
 			}
-			if (likely(pmd_trans_huge(pmde) || pmd_devmap(pmde))) {
+			if (likely(pmd_trans_huge(pmde))) {
 				if (pvmw->flags & PVMW_MIGRATION)
 					return not_found(pvmw);
 				if (!check_pmd(pmd_pfn(pmde), pvmw))
diff --git a/mm/pagewalk.c b/mm/pagewalk.c
index a214a2b..6480382 100644
--- a/mm/pagewalk.c
+++ b/mm/pagewalk.c
@@ -143,8 +143,7 @@ static int walk_pmd_range(pud_t *pud, unsigned long addr, unsigned long end,
 			 * We are ONLY installing, so avoid unnecessarily
 			 * splitting a present huge page.
 			 */
-			if (pmd_present(*pmd) &&
-			    (pmd_trans_huge(*pmd) || pmd_devmap(*pmd)))
+			if (pmd_present(*pmd) && pmd_trans_huge(*pmd))
 				continue;
 		}
 
@@ -210,8 +209,7 @@ static int walk_pud_range(p4d_t *p4d, unsigned long addr, unsigned long end,
 			 * We are ONLY installing, so avoid unnecessarily
 			 * splitting a present huge page.
 			 */
-			if (pud_present(*pud) &&
-			    (pud_trans_huge(*pud) || pud_devmap(*pud)))
+			if (pud_present(*pud) && pud_trans_huge(*pud))
 				continue;
 		}
 
@@ -908,7 +906,7 @@ struct folio *folio_walk_start(struct folio_walk *fw,
 		 * TODO: FW_MIGRATION support for PUD migration entries
 		 * once there are relevant users.
 		 */
-		if (!pud_present(pud) || pud_devmap(pud) || pud_special(pud)) {
+		if (!pud_present(pud) || pud_special(pud)) {
 			spin_unlock(ptl);
 			goto not_found;
 		} else if (!pud_leaf(pud)) {
diff --git a/mm/pgtable-generic.c b/mm/pgtable-generic.c
index 5a882f2..567e2d0 100644
--- a/mm/pgtable-generic.c
+++ b/mm/pgtable-generic.c
@@ -139,8 +139,7 @@ pmd_t pmdp_huge_clear_flush(struct vm_area_struct *vma, unsigned long address,
 {
 	pmd_t pmd;
 	VM_BUG_ON(address & ~HPAGE_PMD_MASK);
-	VM_BUG_ON(pmd_present(*pmdp) && !pmd_trans_huge(*pmdp) &&
-			   !pmd_devmap(*pmdp));
+	VM_BUG_ON(pmd_present(*pmdp) && !pmd_trans_huge(*pmdp));
 	pmd = pmdp_huge_get_and_clear(vma->vm_mm, address, pmdp);
 	flush_pmd_tlb_range(vma, address, address + HPAGE_PMD_SIZE);
 	return pmd;
@@ -153,7 +152,7 @@ pud_t pudp_huge_clear_flush(struct vm_area_struct *vma, unsigned long address,
 	pud_t pud;
 
 	VM_BUG_ON(address & ~HPAGE_PUD_MASK);
-	VM_BUG_ON(!pud_trans_huge(*pudp) && !pud_devmap(*pudp));
+	VM_BUG_ON(!pud_trans_huge(*pudp));
 	pud = pudp_huge_get_and_clear(vma->vm_mm, address, pudp);
 	flush_pud_tlb_range(vma, address, address + HPAGE_PUD_SIZE);
 	return pud;
@@ -293,7 +292,7 @@ pte_t *___pte_offset_map(pmd_t *pmd, unsigned long addr, pmd_t *pmdvalp)
 		*pmdvalp = pmdval;
 	if (unlikely(pmd_none(pmdval) || is_pmd_migration_entry(pmdval)))
 		goto nomap;
-	if (unlikely(pmd_trans_huge(pmdval) || pmd_devmap(pmdval)))
+	if (unlikely(pmd_trans_huge(pmdval)))
 		goto nomap;
 	if (unlikely(pmd_bad(pmdval))) {
 		pmd_clear_bad(pmd);
diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
index 8395db2..879505c 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -795,8 +795,8 @@ static __always_inline ssize_t mfill_atomic(struct userfaultfd_ctx *ctx,
 		 * (This includes the case where the PMD used to be THP and
 		 * changed back to none after __pte_alloc().)
 		 */
-		if (unlikely(!pmd_present(dst_pmdval) || pmd_trans_huge(dst_pmdval) ||
-			     pmd_devmap(dst_pmdval))) {
+		if (unlikely(!pmd_present(dst_pmdval) ||
+				pmd_trans_huge(dst_pmdval))) {
 			err = -EEXIST;
 			break;
 		}
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 85bf782..b8a2889 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -3449,9 +3449,6 @@ static unsigned long get_pmd_pfn(pmd_t pmd, struct vm_area_struct *vma, unsigned
 	if (!pmd_present(pmd) || is_huge_zero_pmd(pmd))
 		return -1;
 
-	if (WARN_ON_ONCE(pmd_devmap(pmd)))
-		return -1;
-
 	if (!pmd_young(pmd) && !mm_has_notifiers(vma->vm_mm))
 		return -1;
 
-- 
git-series 0.9.1

