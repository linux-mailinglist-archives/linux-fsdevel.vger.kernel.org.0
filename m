Return-Path: <linux-fsdevel+bounces-51731-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BD129ADAF67
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Jun 2025 13:59:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4CC68188D90D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Jun 2025 11:59:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51FCD2ECE89;
	Mon, 16 Jun 2025 11:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Uh21tQVc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2069.outbound.protection.outlook.com [40.107.92.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E99392EACE3;
	Mon, 16 Jun 2025 11:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750075124; cv=fail; b=k22TYyRsNbDmpVmX+8ArK2VLTeFIYD9rLZSuvwgkQw1oSI6xTTnFKOCug+qEFAGs9IANeVfI6qAAi5aE6iAcVSjvt8u1UNoqfKuR207lWD4fsfmc6d8a89rKw5RtVM6aPj+I0ltdC7+UGyCIw9L2+ZRGWxcl3hd4ySlJqZaXRxg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750075124; c=relaxed/simple;
	bh=LNSCO2ilxxRrkfTAnBxCVkCPSb5dDcQvVz5IbEVCH4M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=oLL9sqla1I2MudejXAwP7FjyijBAKKplLtEtiDvym6U8AW3jOhzCaXmbi5MxaSK1evVOzXPeSqqDq+p5bzfMW2rZtKMABrWkrYIQZbBNZkqbLdpB+ihyhOEGL2lAakiSntwuXN68wlFXuRqScpdDtqk444sk/RIYTe9rV021O/o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Uh21tQVc; arc=fail smtp.client-ip=40.107.92.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tXVSfezJmZ+9hHVOpGcYSOgzcJJ794kJhDmlEpHcnDv1hlPOp4IyLjhSEVa8Mz0p7wWAfR1w8BRmfpMmBTtaH6z9LVk3W+CMLWfMUM/SY88uUxOTay6p75HAEcI0uNlLUCeRSUQ8r7KeC2xXSjXTlMpsOrKY4VkcTm/w0XcwBRhYZgnlHJ67CZg+x6kX1jnzweULKS2f62gp79L+5nEtOTmFpfNhU6ECsz/prKTk0Lb0GwwTl3mqk2v6bFFDNXQZOxhCDunNkn5EJCckUdAGKYFbyW37qXFZyG4FNGgbdjclH6gN75BRFXi/MSpL74Pv8ErprYYUBbHPSuDdDrWhCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CMgd0xOQkv+zE+7LeKzc0tgrkL155V7bPRmq0gl4jLw=;
 b=QRO7XY5nZWtX8Xp8zIVpaeg2B5aebRWlxydVQ3Y1g4V8xJXvzJAXAmjHxVCY4O+8r2e6lZPqiKWgC02OBB8sh27YdrfbIb5yhxL2AmNo1rNI5FjxjUni7vZlzKJ/RQvkU2XUBGFQSi0D3MJ+JrirfVPJNO/wN1Bt+ipv+3f4TbpHvj0z98qSHMn1txICXuz5uWx2UPBcPTIlwq8qEgSNOzhEKOSIKaUtA2xZQeNAwVaTCTvtilXWrvbx3312F7fj55GS/SgnH2rtCanjgffcFjQANSsHF+b6h/v15qD9Rvf79QrfeYJqnp0lyFtI8+71cyOLizkqV5504dcaBfJQXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CMgd0xOQkv+zE+7LeKzc0tgrkL155V7bPRmq0gl4jLw=;
 b=Uh21tQVc06wtbeAa8+ZkwMYs5om5OUgngvRusn6blIN/jWtyI24q7NNIbnc4zoXG/dvkRpG/t6zrRemV0kdFFiEbIBYSn7qWxgt6m6Sra8W0q8JC49jYjXhG/Z/O6NBDLp7dQMHC2WyH1PiQzAcgEw9/GrinmBnxaGkJNJz8WwEH5C29bqdX7HeN01ZkvLlbScVFQV0tnUZ80tgXTVmG9A4XFaoUBvsv6Vwrxsokazw7IT6I/YCpTyVBy7MmNPaFaSik1UNhjVEI+aWm+w93QLr4ZJYQA0UtOQeRZKNWWcV+FRWcFXjpzjsf/5mMhqEm2aA5senFgzl8Z+d4I/pVQA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY8PR12MB7705.namprd12.prod.outlook.com (2603:10b6:930:84::9)
 by CH2PR12MB9517.namprd12.prod.outlook.com (2603:10b6:610:27f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.29; Mon, 16 Jun
 2025 11:58:40 +0000
Received: from CY8PR12MB7705.namprd12.prod.outlook.com
 ([fe80::4b06:5351:3db4:95f6]) by CY8PR12MB7705.namprd12.prod.outlook.com
 ([fe80::4b06:5351:3db4:95f6%5]) with mapi id 15.20.8835.026; Mon, 16 Jun 2025
 11:58:40 +0000
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
	m.szyprowski@samsung.com,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: [PATCH v2 01/14] mm: Convert pXd_devmap checks to vma_is_dax
Date: Mon, 16 Jun 2025 21:58:03 +1000
Message-ID: <361009510f346090fad328c53ec228d99bb955ee.1750075065.git-series.apopple@nvidia.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <cover.8d04615eb17b9e46fc0ae7402ca54b69e04b1043.1750075065.git-series.apopple@nvidia.com>
References: <cover.8d04615eb17b9e46fc0ae7402ca54b69e04b1043.1750075065.git-series.apopple@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SYBPR01CA0093.ausprd01.prod.outlook.com
 (2603:10c6:10:3::33) To CY8PR12MB7705.namprd12.prod.outlook.com
 (2603:10b6:930:84::9)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR12MB7705:EE_|CH2PR12MB9517:EE_
X-MS-Office365-Filtering-Correlation-Id: be1a7e51-df1e-477e-a92a-08ddaccd2258
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+T0Xws0xdr13fBQ/kdvU6Ly4iaAewEw2PhnZy6JmNeGcsGzqwSfS4QCm+sHo?=
 =?us-ascii?Q?vFDtnAnMsyWnkny52B/repsXsnBgylwFpEsrf6kqzSEiY5e1/JE8824Oj85i?=
 =?us-ascii?Q?St+Y8aryI30RhdxTuywgUeKGwMTSgCIkj6y/DSUe6PPXfLxRxgYe4Jm8v0rq?=
 =?us-ascii?Q?De2P8GXq8cOoMVRw1/Zyg3vgX75OAjnH7A5ERFQIILHnDwUf5IX9Eb9AMmog?=
 =?us-ascii?Q?Vuu3lV09a/E+1J3UvxemeB3ddxB3omy6VVjPbiTx4KmAsBTX+EngyUGH1CXX?=
 =?us-ascii?Q?LZFt0+VUeqkP/XQu3dmU+vfXSYwmsupHhKxfsJ9GDwg48Hxdqtt26PPb9eLF?=
 =?us-ascii?Q?OzAHyWrN2hNpWjNIBNUftcPjZN25Q1MslGe/cUt6KwRa/ozA88kt5gDt98vO?=
 =?us-ascii?Q?nNOtG35/qpHHZLr6+3yr9IT54t34x2U13DWbkbD2U6eiv3jgSOjmpszRvqH7?=
 =?us-ascii?Q?se2Z63EHBCWjOQM2OrRUlMKu1Bea9Waei54HesaEY+BOI6V2GxgFA98/ClpO?=
 =?us-ascii?Q?wbfc7ZKFKLSKE/kNLzB/HmHEb53WUd995J363geNM/F8aJbHvjxCXH9G7X4O?=
 =?us-ascii?Q?MId5T7kjW8/whTSYnFTFpMt3U0vNdG+BvMXMffOzI7t9cd5r+mmeqZBgb4QA?=
 =?us-ascii?Q?4/zszjafD0HTedk2aptakyxISuaVY+gXVbdk0aWfaujIIH/Ij48KyLsypPHB?=
 =?us-ascii?Q?rgKGUZFLwasuXm+ywDC6HaJkuv8eQIuG9geby53C+Obo4c9ec8EkiQbUpCbm?=
 =?us-ascii?Q?JiqAvUybRujzikpFPoux75hNE5p+6nwNVNQmJjY8eOpGGeBcupLPBaAgml8F?=
 =?us-ascii?Q?RM1lqSvMW/e/1FAmaUzdIADpV77mxO8vSERarRX7SpqSH4s8y3j1EBGpq1Od?=
 =?us-ascii?Q?IfurcCsXlbdtfq9QFeO+1pb88yyDaODxyN7zySytRUjiGSjylinH6OmjdegX?=
 =?us-ascii?Q?eQKaj51zQd9nrktErvwUg/0jcnAuzaOib7gBJ2MCw8y35UoFkWnWGScjgvX/?=
 =?us-ascii?Q?zpvrRVhfxfKnMqejHV/j8IqAfyI7iUlRSueTEPGaM6jFUvmjAGeso0ZiHIBL?=
 =?us-ascii?Q?Ug0fwscu3m6Dll5RPlWHk9zOjXL4fgd4AkM0M/RXxytqrZV2vU39KP6nc4OR?=
 =?us-ascii?Q?XGTsKyv3HxoLCnXmzk0IHZAbi1rV5MrfIaSrNoHL9ha/41L+N5GpB52WFLyJ?=
 =?us-ascii?Q?bCpz5VtwlvuFUXTvcWJM5hSdpo9qbmSJXyoToA6+wxmxcCzY4s2PR0XdUOgU?=
 =?us-ascii?Q?AEuXJTQrDoSyBduDEDUgjBXk63L3xUKhtZtuEk4cXWOeNJ0HFnRLDgP0iZTB?=
 =?us-ascii?Q?ob/Cj1PwEhNjrAeJ28kMU3hUvLT7/27PYZHrZwo0kLlhPglipBBEen0ZjoJ6?=
 =?us-ascii?Q?vaKSflGdvx9JtDJt2luSLFT68S/HOpObto4TJZYIz6vYUXsnynSM2XWLt4WF?=
 =?us-ascii?Q?Wd/TQNa0eZo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR12MB7705.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?h03+vvlx1gx8t/XCmRLRhWaTKxoTLR7OlHEEzZZPNN0S2pUf7ZSOHei44yJv?=
 =?us-ascii?Q?7aQzr0kuGyDp24E4p5+fplmRUovWWvH46Lw2C228XwYJ3KzsWBitRckM0eC4?=
 =?us-ascii?Q?q2gWmmYUOV+ML0uZppPIfIpgaxPUK7t2ywDjc1/CmIwcJZpCgbvXnF/kV/9F?=
 =?us-ascii?Q?FAPb/LsXeox570Qai0eT8v3tF6CYhXToNpVe6GrU/iqjDBHGPd6f8aWNT5hV?=
 =?us-ascii?Q?5eXpfV4d/PMsHudmsfxi6dbPRBfWN5zZwJR779DBCE13glZj6673XieHKOn3?=
 =?us-ascii?Q?3jhwJ6mnYEnr5Yg35Ey8r8VujSMpQeerIIXrBInKCggZkfaMhikWg3bArMf2?=
 =?us-ascii?Q?bTCV0TKXaZbgB+PyPPIKquW6qIauuIkmZusH3s9rB3gir1Ac6iGV/Xis28/y?=
 =?us-ascii?Q?98TTqP8QV/Jn1kkzl5CY6vrvkE0aI2jCTsjEkIDa5+OAp7wO89SMokIXQPFx?=
 =?us-ascii?Q?cWRd5LZ5FzWD9nsRmOSsbgDn2YNsKJhlLM3XjBLqwttBW7S27lnxMTG1tgcl?=
 =?us-ascii?Q?8Gglu/TGP0MmhxOlTvetDE4c70AjhyjPXEfeIHxbEsas4hay1aMUlHapZsjW?=
 =?us-ascii?Q?TgCHmEDGHHhPLMt/wk5H9kFbKLOYF9LzWoZM0HnJ0i73/318BtYAIRwpOL/E?=
 =?us-ascii?Q?OLCl9il3EwRCGPX3g3jx7c/1Veh0xIXUL1mDbbGpBLpZ9xz8O870qZcnn03Z?=
 =?us-ascii?Q?cwbx6o4TGrzUMeBkPC1jOkX30FTbIs4QMXXA9E8ONa3ml+TDIu85ypCGCYct?=
 =?us-ascii?Q?WbowCdN15UNKZS14kexsqg/B40LfVlWUIv7YfZQbfoDKf5bNYYXik+3qWc3D?=
 =?us-ascii?Q?VXEJ20inTsk3XjZmWwQUeVwU6wKKUyP+yJiGMi3Rq3XfHBBDtJQzFp1uVjD8?=
 =?us-ascii?Q?U9XGIOG5peeUK9tT7hC9wxqT3GeU2NKcXi3D75v7ISx1+yz8iyaFXvfXzoEr?=
 =?us-ascii?Q?6dnikYpG2NafPFc+UjsK+0HeHpy+uVFLT/rDSLdYebSEuETopeKSlvO0Yah0?=
 =?us-ascii?Q?kBtIQ2ISF2GvA1pY1fbugORCI5Gb5BK0ROnQcZ+RdYck1HYcPHw+9uaASZB8?=
 =?us-ascii?Q?RyQK8pznayvEtTQg3COFt67kSN4UwwAmsKR6/vF5MrOqoT78b7yIykquhGBn?=
 =?us-ascii?Q?VLTWVZ2p1qqhfkucrN+0TiEw6BV79TG4QXXRPZryCzkPCrXUhph8gI0Z8IKY?=
 =?us-ascii?Q?6h/9oZ//jOX1VQBW/E21mzz7uv7z/tTFRDqIrOA6neMlhbdckQLhflgOXna2?=
 =?us-ascii?Q?GGVptZYXoOGZwPvv+pn3Y410oFGJkSEGBbRbcXjDukVg41PItwjOaedvONhF?=
 =?us-ascii?Q?D4h9rbLb8A5ehZdUWb5bISDhiBtm89ruL2Ezx98MbJh4HQhOhbYfjGTS8LLN?=
 =?us-ascii?Q?+5CZ+PuWtSQC9RZmdriawj/Nb4aUu9Zr+4ULBy0i1bDyOehDHvNQQG4hTBYm?=
 =?us-ascii?Q?B7/WxeUOGtzd92Ad/1AwoykhluvtSZwzXxdcqt2FrDAdlr/Hru1Xy/wv0Ipk?=
 =?us-ascii?Q?ahsq4SHXKF0JFvV/aJtUGRQJH+uNXZA0k4YJP/2CsyjruIHNNAyOICFeZen5?=
 =?us-ascii?Q?V03q4irn8gjhXkDpI7g/JQRJ1yM5LVe4JMPIPxP5?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be1a7e51-df1e-477e-a92a-08ddaccd2258
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7705.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2025 11:58:40.4414
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wB7YsTzifoLFZTeYSoidZPGSsrz7ueyHNcIRcHEtC3fINxPg+Ivt0DeW8yRw3xt82XGaQuB95cafABTLVpqt3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB9517

Currently dax is the only user of pmd and pud mapped ZONE_DEVICE
pages. Therefore page walkers that want to exclude DAX pages can check
pmd_devmap or pud_devmap. However soon dax will no longer set PFN_DEV,
meaning dax pages are mapped as normal pages.

Ensure page walkers that currently use pXd_devmap to skip DAX pages
continue to do so by adding explicit checks of the VMA instead.

Signed-off-by: Alistair Popple <apopple@nvidia.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>

---

Changes from v1:

 - Remove vma_is_dax() check from mm/userfaultfd.c as
   validate_move_areas() will already skip DAX VMA's on account of them
   not being anonymous.
---
 fs/userfaultfd.c | 2 +-
 mm/hmm.c         | 2 +-
 mm/userfaultfd.c | 6 ------
 3 files changed, 2 insertions(+), 8 deletions(-)

diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
index ef054b3..a886750 100644
--- a/fs/userfaultfd.c
+++ b/fs/userfaultfd.c
@@ -304,7 +304,7 @@ static inline bool userfaultfd_must_wait(struct userfaultfd_ctx *ctx,
 		goto out;
 
 	ret = false;
-	if (!pmd_present(_pmd) || pmd_devmap(_pmd))
+	if (!pmd_present(_pmd) || vma_is_dax(vmf->vma))
 		goto out;
 
 	if (pmd_trans_huge(_pmd)) {
diff --git a/mm/hmm.c b/mm/hmm.c
index feac861..5311753 100644
--- a/mm/hmm.c
+++ b/mm/hmm.c
@@ -441,7 +441,7 @@ static int hmm_vma_walk_pud(pud_t *pudp, unsigned long start, unsigned long end,
 		return hmm_vma_walk_hole(start, end, -1, walk);
 	}
 
-	if (pud_leaf(pud) && pud_devmap(pud)) {
+	if (pud_leaf(pud) && vma_is_dax(walk->vma)) {
 		unsigned long i, npages, pfn;
 		unsigned int required_fault;
 		unsigned long *hmm_pfns;
diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
index 58b3ad6..8395db2 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -1818,12 +1818,6 @@ ssize_t move_pages(struct userfaultfd_ctx *ctx, unsigned long dst_start,
 
 		ptl = pmd_trans_huge_lock(src_pmd, src_vma);
 		if (ptl) {
-			if (pmd_devmap(*src_pmd)) {
-				spin_unlock(ptl);
-				err = -ENOENT;
-				break;
-			}
-
 			/* Check if we can move the pmd without splitting it. */
 			if (move_splits_huge_pmd(dst_addr, src_addr, src_start + len) ||
 			    !pmd_none(dst_pmdval)) {
-- 
git-series 0.9.1

