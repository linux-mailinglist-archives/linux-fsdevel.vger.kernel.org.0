Return-Path: <linux-fsdevel+bounces-38820-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4663FA087AC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Jan 2025 07:07:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 264123A369F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Jan 2025 06:06:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B112920B81D;
	Fri, 10 Jan 2025 06:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="fV++wdGT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2072.outbound.protection.outlook.com [40.107.236.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1266C207DEA;
	Fri, 10 Jan 2025 06:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736488960; cv=fail; b=gz8+sMeSy8ggB2nI1gS9md9j9GGoaJd4mbVvUaQh9hLz6mEhu7q6sU8zgUnIAGiPTf5v0LfbYFGwY9Wdp+yZ1Td41o9Rmzi4PD7zsNSR4qyJPAEbd3syQSxKTGRd8y31y9X7Gl6/IxEgaoDdgPVZXAIZO9qDZ2QxvryIIsktu6Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736488960; c=relaxed/simple;
	bh=xAoQYjlgKC+gGoXsIbdtsRrFj6DajE6i13QWHObWdYs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jEq2H0Wex+7itcQGSWyT+V+d7wo/Pu6HX3/k4jmbKa03bJNFNUlUDP7fHc7fCbVv3BilLsOuJr6VfT8J6kqHHLEFmW8KUoIG0vv+WBIjbDAerT0slMQhLqFCvEM9IEcninTggGN8mljVYbSnbwPyCvx7n1G8oriyyLpkKmcdhvA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=fV++wdGT; arc=fail smtp.client-ip=40.107.236.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ghqqWDBgMtfYZ54gyo7AZWjm52zJ7nRqvYKrnfFJ/BtAgB8T4JBt855OgC7a4VdvKWDSLeaBvcdmHQQa1LfyXhf7gw7a41z8NWsejEQFBd18F2Sw5fV43X2NrxyeeO8JclIVXH2BNyHJha80MrO1iGc3RdmFVRxBuZGsgKPr24y9+OToJKGeW4Q/e4FhTCr22tLC4Y5tNRc5MyOLv76Gz8iW08buMBa7iKHZjHpyYnMjBuUpqr+Q8bwRP0qIu75zAHfASWaI4aZJ+yb8QYvp+FOVBuHxrSv3hy3oTzki+VRfCm4ujn6C67qmEAETt789QugbapsZanH1nqWWTznlqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GNe7XDGDbv1m+aR4DuZGzWy033FQUl+UROnaiXiWGfw=;
 b=mBVomQISjPWicAMTzXwSFm7Dy4JgIa8UzwqB6yVa7IIw45B4jEdfUJrMT5quSmewahEKPftK6yRXU+uTwZ6xfx9qrXKFwSxLQVYdYDu2sgRnxsUnQwLr5f0ukM+i6B5c2pD2McGP09p3BAZUgs77egpg+AjVcn1ZEsOw9C+Xog4TK4/ayRubz8pYSDMMTmPkwBjazT/MJVVPvssZp0Dy+yYT+2J24tDzPmAG/oELgKI+a9jRCZyxXBVif+bGAES5flqRjyPywaAldlk/QNfV6+SBvLXnu7vfMGpqy/UgXKaAK42fGPjQZTXnSw+EHM2e9ZfDGNyj346vsM2uqJHSOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GNe7XDGDbv1m+aR4DuZGzWy033FQUl+UROnaiXiWGfw=;
 b=fV++wdGTZb9hyNAcyaZwJjZp1Q5POB5KEw/b5qXBCUEXBvmtOAq8H8Z2pHtpYrBm5rzMswyLS1IGndW4aym0/WXDqtm5bTFz7tlQhusaaqM4lYDlh7utVNdDTzBDYqImgovZCMdsOVjLBpGhKMlYNzH733mv7THMHeNixWu3hGbP67XjrGEwUclAqvFXjtOA+SMNoR6bdLhKhR3qLSq9QW4fHlEJj/KUvUMwkbLSX8Frl0KrD5YzhDI1axjxu/0icW0K11Tk9isobQzCtC7z4Zk7AA8k7qeb5wvQFDN//wNPWrFxdvj4zxb/MIDZFH9dBumGJszC5uPgZcT8Zmmo0A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6) by
 BY5PR12MB4132.namprd12.prod.outlook.com (2603:10b6:a03:209::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.10; Fri, 10 Jan
 2025 06:02:35 +0000
Received: from DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe]) by DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe%7]) with mapi id 15.20.8335.011; Fri, 10 Jan 2025
 06:02:35 +0000
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
Subject: [PATCH v6 14/26] rmap: Add support for PUD sized mappings to rmap
Date: Fri, 10 Jan 2025 17:00:42 +1100
Message-ID: <b70574dd75a9bf800bae1202f37fef203fd670b5.1736488799.git-series.apopple@nvidia.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.11189864684e31260d1408779fac9db80122047b.1736488799.git-series.apopple@nvidia.com>
References: <cover.11189864684e31260d1408779fac9db80122047b.1736488799.git-series.apopple@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SY5P282CA0143.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:10:205::15) To DS0PR12MB7726.namprd12.prod.outlook.com
 (2603:10b6:8:130::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7726:EE_|BY5PR12MB4132:EE_
X-MS-Office365-Filtering-Correlation-Id: fde5089f-e8c1-474f-899e-08dd313c60d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5jkk5jn5AumblCbchXydcHjV/HskSAvHdjXe753EGAGSfKQNPWUaRWNYdgsx?=
 =?us-ascii?Q?1ov5ZeDETdPbvFQYe1GLLibUogEStz+2v0mGOpm4l6MTFRMwjEnJvE/QKCg4?=
 =?us-ascii?Q?NtZNoeI9y1PhCeiEzIAFh8opo6BE81YaKeX+PwVLGiwvtDHZVJsnZsqjTNWH?=
 =?us-ascii?Q?/gTJMmvw2puVM7eRgH40Rzwb185j6TD7PSfIJK9EvIQNlXBK077rF1QzXPos?=
 =?us-ascii?Q?v0v7MRuxrWfW0FmTNupJ061evndIAKklcnqlebwRn+/azxih3laYdZ/gHO6Y?=
 =?us-ascii?Q?pfk2X8Xox3rP8es2f2yzn6y51RuJhznFNI3H1b0qvsr775XWzf44xKGx1tsB?=
 =?us-ascii?Q?4yerbq/zkE3V8nh243rBMcN4p1euzq9jzkKkmJ9Upj1HNsBXi4AVLhtfCiQY?=
 =?us-ascii?Q?mXOhNREm2mQ25KQ7GR4oOUbuwG60EvjZQye12j8U9ztA/IyhVbws7jOGHJG1?=
 =?us-ascii?Q?nVU2qdMFVhcUqNMfBSRuCUVamliDHqy5HYnV73FdJbEw4nsk6mQmJuOhzGxB?=
 =?us-ascii?Q?7fPpOJdb/ay07KXpQTUcwUsHxp9io6b2UbGU+a9fQek0APBVPfY3BEDXWQJt?=
 =?us-ascii?Q?CvCZ8fGY//wqOWgGP904oMWRAblaa3t/YYzi0Z8CQ9aqIY8nzaaH2fNj8DF4?=
 =?us-ascii?Q?sBXsOZulPpqG3z499fZnPn4NY7EQ724p9gwP5JTUPZ+yrm3gzoAC+X8pm9Ts?=
 =?us-ascii?Q?tgBM41MluvrAc5+YafScMsn7gWODS7ngwViPqfO+p1q3IX0PXbUuFmGEeGsn?=
 =?us-ascii?Q?dr629uCE7O97G2dUSOqdNcGa4vLoGRNLNAjzXg9AGoI8eWsEGIXOmJbYYpWB?=
 =?us-ascii?Q?z60rUJ80sMOi5iehdwUoriGmXWJN2W5Rv1GF7aw6LoM/7x5RJPntTDSVv/B5?=
 =?us-ascii?Q?5lraZ13R5w//+kYHsWU6FGpfa44EbM4fjc0O1/qzeyDlcuwdbzTYVE/JTYcz?=
 =?us-ascii?Q?+SjY/SBj0Ba99rMdm5ppLsrqr5PwCyT9BJLv/CmuLhQjbk9bO81QEYKrGoy5?=
 =?us-ascii?Q?cuJMwMeutMhw8Tx+Y7PXluxTwVENFhmtf1fhIE3OKP784vfN0vkztw0UM096?=
 =?us-ascii?Q?1p1ev+CR7DDeeW6nh+0n2RMhIlf2YpkhxglKRn/q7krjjkCysanwJQXvtt1l?=
 =?us-ascii?Q?xISzs3/OszTmjPyorUv7DyG7vh+sZGB9ToTvn3x5wfCMsCelmk8uH/Nk0nsL?=
 =?us-ascii?Q?w0VvCTL03BfUWAd98YaZrtaqXT46K3DlPdDIaEMGceoquOyJ1o9I3oJwCrEG?=
 =?us-ascii?Q?dZOix/MwYbqII/nXNTZbOGwkfl3H3DfIaMGFUFYNbmC/XH28/taxk25qS4Bq?=
 =?us-ascii?Q?bnvLZW+7xo9i/KXItAQ/WSMAE3f3EE4UWOq/LaYktrFLdElcq3hMmye/wAGO?=
 =?us-ascii?Q?UaSKLqo6W87Zw7WBbMkDI5iu+Yee?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7726.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?yfBQPK2876p23coNxQnLVkhpj0iuOwwywhHpy7dAvgFh6SrhGRDXYKCDzNP5?=
 =?us-ascii?Q?Ja1M/alhlU/CEQ18cIpvy/YTZv/zLC1r7xUT0w3VXv9FEI8InfFBBN/OgD5p?=
 =?us-ascii?Q?/3eYM7ZULYJD6mHbHYzrzuGzV/6Js0tpbx/nnEDTbPJP5rWGO4AgIse98q4R?=
 =?us-ascii?Q?qAyhtmtKLcDmPTwkcXLNyjckhZMBt8sfwQj2GwHmP70kELuVjEnWspXSVaSH?=
 =?us-ascii?Q?XaQQNIHftIWjE5g0iwQv0X/7UW7mtXIM/uLM68YsqC7lbuR709aiKkGTVegl?=
 =?us-ascii?Q?4MpSsDyzP0efEkP7Qd1vT+zke1xaMJtcOUuvsAhZe/mnslygCe4uedKpkcSu?=
 =?us-ascii?Q?9SUZIZE0rJEPMfE8MJQlh1t16SGnSUPZN1Z1yBXx9Ajs/+Cx9Ozw0GXK3CqX?=
 =?us-ascii?Q?D7ahaPqE6pETdCSXkBQajJ2Vc3Ju7pKDM5qhByRPrZOeqyjh5tBn6BRQ2J0X?=
 =?us-ascii?Q?tX7+G8wQ3iENfpDkPF5PAg3+eScs12Yg8yZRvdLXI1I2J0Xf8PPX2UW5wmGC?=
 =?us-ascii?Q?m333igRjJzorqaJDl4SpNeEzAl2uT5uOJKn25sgVMxrSWVhl0ETplB7zHJ+9?=
 =?us-ascii?Q?3xo1KPSHThSPGOLEB6s6He5ZTRf85wTCxfJ69H9+oxcEWjLySSzrXD2s1FPS?=
 =?us-ascii?Q?0UbM5lvVdetKOaj/W/6HK+w+JvdbdVUM4ZL1Ev3w76F8G61DmknR6DXceSAY?=
 =?us-ascii?Q?24Vx4lTopOe8dO0Ff40yoAAOjf6nm1lJsMywviaBd4Xs3YOLB/1SYO5xUbqT?=
 =?us-ascii?Q?BTUW3+xVnalSqMlehbSEFZgOVYp8vB/L3/Cf+5s5+PHaRUT7IO3GO5D9nEIy?=
 =?us-ascii?Q?3tiCUyPTwA4ttD6ZAXO1A+ZrxLC9oMqH6aI90SE/UL3gMrUaC1HCRVs8FcX0?=
 =?us-ascii?Q?j6xq57Lz3PYG/GYS5DUlLYq2Uf63ogYyFZH0XcVx03DOGXrKbo38IXXUqTYd?=
 =?us-ascii?Q?fU/9pyeq5mD/9Jb6Nv3ccJtD7wLkqytBjIx7HXvKof1i3Y2WuDPLRAa8r/qY?=
 =?us-ascii?Q?6WOI3OEzBpSL9/xN/msX1dxSLA4fa3gDsNHq9l2U2j/ytgljmT2jkS1zmR8d?=
 =?us-ascii?Q?kALu7/6sZVKiMkkm+eIHQt/1+tCbhRQJq+sRPNKJUEl5kCSIsHU1c1viGLLM?=
 =?us-ascii?Q?mcGTkBVyeRIkBi7FWeH9OnrEvTFO9yTnJaCwYcvR7anSX18ePgvoOBruUmer?=
 =?us-ascii?Q?kTs3qmCq5SDqQ8seHNdr1Ig0YlWjUBU+RA77WTP91capaThfWnJVoEWgSPTi?=
 =?us-ascii?Q?O0n964lDw69wNZZdWk1wlTTJNgF0XzPoXsH02PolcNdatr0jUaDANRBrdzXX?=
 =?us-ascii?Q?1EsVI+BTY6eNDgyt4sshdiLZffxW+APB5TfGKkGD2rHmZjL/cmSZR84RnoVw?=
 =?us-ascii?Q?5hS4BzBuLi7yXy3Bcx/X60y8Czpg+/FYzDhP62vZbaddXi5gppnXPIhdu1iU?=
 =?us-ascii?Q?G+NDsG1uXzlrLS+J2ZcOunREX7273w6sAN+nH6QLQnihtmEycxxB3uRXFPTX?=
 =?us-ascii?Q?RR2sGtI+GmEXPtE/VaZi48M4gKnRVuL7QFthilgvxhczE0ye7oEDSnd5HcVR?=
 =?us-ascii?Q?CEq2CdFS/ReKGma4kfy8CLoaLq0eDPKgweZ4dHZk?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fde5089f-e8c1-474f-899e-08dd313c60d8
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7726.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2025 06:02:35.0746
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7johwTfsWKByvBPve3dKs+5k2viqKU39dpeYwWwbxhDP46Tix+l26vt5s2aGIx1uKYzEpMMrHk1WXliYs2vIBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4132

The rmap doesn't currently support adding a PUD mapping of a
folio. This patch adds support for entire PUD mappings of folios,
primarily to allow for more standard refcounting of device DAX
folios. Currently DAX is the only user of this and it doesn't require
support for partially mapped PUD-sized folios so we don't support for
that for now.

Signed-off-by: Alistair Popple <apopple@nvidia.com>
Acked-by: David Hildenbrand <david@redhat.com>

---

Changes for v6:

 - Minor comment formatting fix
 - Add an additional check for CONFIG_TRANSPARENT_HUGEPAGE to fix a
   build breakage when CONFIG_PGTABLE_HAS_HUGE_LEAVES is not defined.

Changes for v5:

 - Fixed accounting as suggested by David.

Changes for v4:

 - New for v4, split out rmap changes as suggested by David.
---
 include/linux/rmap.h | 15 ++++++++++-
 mm/rmap.c            | 67 ++++++++++++++++++++++++++++++++++++++++++---
 2 files changed, 78 insertions(+), 4 deletions(-)

diff --git a/include/linux/rmap.h b/include/linux/rmap.h
index 683a040..4509a43 100644
--- a/include/linux/rmap.h
+++ b/include/linux/rmap.h
@@ -192,6 +192,7 @@ typedef int __bitwise rmap_t;
 enum rmap_level {
 	RMAP_LEVEL_PTE = 0,
 	RMAP_LEVEL_PMD,
+	RMAP_LEVEL_PUD,
 };
 
 static inline void __folio_rmap_sanity_checks(const struct folio *folio,
@@ -228,6 +229,14 @@ static inline void __folio_rmap_sanity_checks(const struct folio *folio,
 		VM_WARN_ON_FOLIO(folio_nr_pages(folio) != HPAGE_PMD_NR, folio);
 		VM_WARN_ON_FOLIO(nr_pages != HPAGE_PMD_NR, folio);
 		break;
+	case RMAP_LEVEL_PUD:
+		/*
+		 * Assume that we are creating a single "entire" mapping of the
+		 * folio.
+		 */
+		VM_WARN_ON_FOLIO(folio_nr_pages(folio) != HPAGE_PUD_NR, folio);
+		VM_WARN_ON_FOLIO(nr_pages != HPAGE_PUD_NR, folio);
+		break;
 	default:
 		VM_WARN_ON_ONCE(true);
 	}
@@ -251,12 +260,16 @@ void folio_add_file_rmap_ptes(struct folio *, struct page *, int nr_pages,
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
@@ -341,6 +354,7 @@ static __always_inline void __folio_dup_file_rmap(struct folio *folio,
 		atomic_add(orig_nr_pages, &folio->_large_mapcount);
 		break;
 	case RMAP_LEVEL_PMD:
+	case RMAP_LEVEL_PUD:
 		atomic_inc(&folio->_entire_mapcount);
 		atomic_inc(&folio->_large_mapcount);
 		break;
@@ -437,6 +451,7 @@ static __always_inline int __folio_try_dup_anon_rmap(struct folio *folio,
 		atomic_add(orig_nr_pages, &folio->_large_mapcount);
 		break;
 	case RMAP_LEVEL_PMD:
+	case RMAP_LEVEL_PUD:
 		if (PageAnonExclusive(page)) {
 			if (unlikely(maybe_pinned))
 				return -EBUSY;
diff --git a/mm/rmap.c b/mm/rmap.c
index c6c4d4e..fbcb58d 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -1187,12 +1187,19 @@ static __always_inline unsigned int __folio_add_rmap(struct folio *folio,
 		atomic_add(orig_nr_pages, &folio->_large_mapcount);
 		break;
 	case RMAP_LEVEL_PMD:
+	case RMAP_LEVEL_PUD:
 		first = atomic_inc_and_test(&folio->_entire_mapcount);
 		if (first) {
 			nr = atomic_add_return_relaxed(ENTIRELY_MAPPED, mapped);
 			if (likely(nr < ENTIRELY_MAPPED + ENTIRELY_MAPPED)) {
-				*nr_pmdmapped = folio_nr_pages(folio);
-				nr = *nr_pmdmapped - (nr & FOLIO_PAGES_MAPPED);
+				nr_pages = folio_nr_pages(folio);
+				/*
+				 * We only track PMD mappings of PMD-sized
+				 * folios separately.
+				 */
+				if (level == RMAP_LEVEL_PMD)
+					*nr_pmdmapped = nr_pages;
+				nr = nr_pages - (nr & FOLIO_PAGES_MAPPED);
 				/* Raced ahead of a remove and another add? */
 				if (unlikely(nr < 0))
 					nr = 0;
@@ -1338,6 +1345,13 @@ static __always_inline void __folio_add_anon_rmap(struct folio *folio,
 		case RMAP_LEVEL_PMD:
 			SetPageAnonExclusive(page);
 			break;
+		case RMAP_LEVEL_PUD:
+			/*
+			 * Keep the compiler happy, we don't support anonymous
+			 * PUD mappings.
+			 */
+			WARN_ON_ONCE(1);
+			break;
 		}
 	}
 	for (i = 0; i < nr_pages; i++) {
@@ -1531,6 +1545,27 @@ void folio_add_file_rmap_pmd(struct folio *folio, struct page *page,
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
+#if defined(CONFIG_TRANSPARENT_HUGEPAGE) && \
+	defined(CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD)
+	__folio_add_file_rmap(folio, page, HPAGE_PUD_NR, vma, RMAP_LEVEL_PUD);
+#else
+	WARN_ON_ONCE(true);
+#endif
+}
+
 static __always_inline void __folio_remove_rmap(struct folio *folio,
 		struct page *page, int nr_pages, struct vm_area_struct *vma,
 		enum rmap_level level)
@@ -1560,13 +1595,16 @@ static __always_inline void __folio_remove_rmap(struct folio *folio,
 		partially_mapped = nr && atomic_read(mapped);
 		break;
 	case RMAP_LEVEL_PMD:
+	case RMAP_LEVEL_PUD:
 		atomic_dec(&folio->_large_mapcount);
 		last = atomic_add_negative(-1, &folio->_entire_mapcount);
 		if (last) {
 			nr = atomic_sub_return_relaxed(ENTIRELY_MAPPED, mapped);
 			if (likely(nr < ENTIRELY_MAPPED)) {
-				nr_pmdmapped = folio_nr_pages(folio);
-				nr = nr_pmdmapped - (nr & FOLIO_PAGES_MAPPED);
+				nr_pages = folio_nr_pages(folio);
+				if (level == RMAP_LEVEL_PMD)
+					nr_pmdmapped = nr_pages;
+				nr = nr_pages - (nr & FOLIO_PAGES_MAPPED);
 				/* Raced ahead of another remove and an add? */
 				if (unlikely(nr < 0))
 					nr = 0;
@@ -1640,6 +1678,27 @@ void folio_remove_rmap_pmd(struct folio *folio, struct page *page,
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
+#if defined(CONFIG_TRANSPARENT_HUGEPAGE) && \
+	defined(CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD)
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

