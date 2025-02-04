Return-Path: <linux-fsdevel+bounces-40841-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EFB6A27EC7
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Feb 2025 23:53:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 167E51887E80
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Feb 2025 22:53:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0138E224B18;
	Tue,  4 Feb 2025 22:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="abmiGkbf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2063.outbound.protection.outlook.com [40.107.243.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 417BA224AF5;
	Tue,  4 Feb 2025 22:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738709373; cv=fail; b=Dr23Mcn+ihl/EigCUFDK0DvW5RoDvKfSlizcHMuHtgMADDsK0nREkFCdJxGhTUbuMDZE6EYtR/pd3pNJ6I41Q/2jkFBREay3fe0bVfgaKDLMaBD8sTVNcPQUztn0IeUsK108r+0RbLyTvKsGVASZTgOs7LttrniAOm33jUBYLEI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738709373; c=relaxed/simple;
	bh=fna0TXojvfWPxkmZo/AWMyJTUi8/bNS6akAYVG+QKAY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=je7ouO15pbxoNB/yjesvL+9klgcBqmWQXtri1No1q8uEA5utwxBDP/DkNTfBoOCvvVxO6mW44A+pDO76pF8Ac/F/sf1CXwyq6oJaepT6fE98vUMbbPxCA28caJ/jQcOkPz5+RhwqLt99MMpAgNRTAp/TgA97HPnbzy8F8pYxcXA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=abmiGkbf; arc=fail smtp.client-ip=40.107.243.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xItHW9uEundPKanjCQ87lMdSY3XmlUCH7wO5TudZ+Yriemc0vz5+azC4TyC0SNdedcQJL09yU5z4k+5M5jmZm+8c3uIuJsIX37ZKzJPPso73F/ZFFNdm4+7UUSC8FR8O5/0zytfRMqHupEszUO1VjoFExQveCRGZcnUwc5V88BiRIjFCF9iGP7eJPNANjAR+pZk3PFv1pdzWHWhLmheFPB1Ogq+LIjJpvJ4QeJx3RII1QhZ1ENiO8vQ7iRN/6GNFT019P44IsXvuB+K1oO3eN7rNOTkzwA6B7h3Ad9eqEcdVVL7JpCPf67UPABE0B3iB2b/ySyHm7exRfXNboVaK8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OfAN34ITK9M55mbgWIkS9+MmZiKWpfuQqfC67BIaav4=;
 b=vdLcMm2bXfT7tEg/PTTaYi+maBKdideh65JP0+UAoKm9VsZ8sPZ9qE+11LV6xPU/IGWwlMGd9Js4Ot1bVVopyQ+7IYrSd7tp7ImNfCCOHVu4QAsoQi/5xdxEzqk7L1FA4bp2WzV2HWntnJKFItSENLUcN36mSWTJD4Te+HfT7sOjntZ5lL3ZBp7F3a1yTlAfGTR1LGKVmVdS1BNndg3+ynrJN142Ekm/J6eQXFTza+Y0KrV+Z+Fbx2zmivLmuoslCiskD2eKH13CYksPDpVbFnZnquCdtfU3AGmSVW11WC+1A5wAE/28aWVHi8AetOvJI/aTI5+1RPx1Sf1j7/Z6EA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OfAN34ITK9M55mbgWIkS9+MmZiKWpfuQqfC67BIaav4=;
 b=abmiGkbfU5TbJ4AU7qy/4FzaUH9V9Xbvn560ruyEpA8mCuzS+8IhwUhFQGNcqLR2vtk565gN1I0+nHYLivR8HmJwfH2/bkuzwbhoGz4jiCFPULZbUPcuT1kHGKKXx4D2R6HlMTMzW14Gq3AYoD4VFPu/5GrY5CVrahCOijq8nO5k8cYW0rfZzRTzkZpv2oXILmr5euHiwsSwuZ/0CwSMnFrtwYuHKwa9Sph21DF6twXQE8jMGQ6Fb7Gj4WR4HBChVcPvQNIAGAfv8qY8IueIKbAWmpaYpgLbqEE4IZKGd8xrlThzpPlO1KjPRKSfh0aOhzawTg7IBytFmWSI899Rmg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6) by
 IA1PR12MB8537.namprd12.prod.outlook.com (2603:10b6:208:453::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.22; Tue, 4 Feb
 2025 22:49:28 +0000
Received: from DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe]) by DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe%7]) with mapi id 15.20.8398.025; Tue, 4 Feb 2025
 22:49:28 +0000
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
	loongarch@lists.linux.dev,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: [PATCH v7 11/20] mm: Allow compound zone device pages
Date: Wed,  5 Feb 2025 09:48:08 +1100
Message-ID: <9faf181c9e0d93607b6eb41ac89931730fe0749e.1738709036.git-series.apopple@nvidia.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.472dfc700f28c65ecad7591096a1dc7878ff6172.1738709036.git-series.apopple@nvidia.com>
References: <cover.472dfc700f28c65ecad7591096a1dc7878ff6172.1738709036.git-series.apopple@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SY6PR01CA0158.ausprd01.prod.outlook.com
 (2603:10c6:10:1ba::6) To DS0PR12MB7726.namprd12.prod.outlook.com
 (2603:10b6:8:130::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7726:EE_|IA1PR12MB8537:EE_
X-MS-Office365-Filtering-Correlation-Id: 016b4d51-ea95-47aa-b0d7-08dd456e2e32
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5kuBxeoA1S2XYach3+35DT0V1CbadVUpNFB6c5hGlt8Um+GQoVuLSaLT2w+v?=
 =?us-ascii?Q?43brzpiqKwIXFf2bKS/4O68tGekfc6tpp1/M62MZBHv5QQhSld4ygaWZxrdp?=
 =?us-ascii?Q?MkXA4rHJrToLQh2ZAv3Zo5EQh+Jc/alyAo0JFCOw8iQjtZ49mTHfYS1xblTU?=
 =?us-ascii?Q?JTCBVbGnvhVP5ibpKufg/sZWOTsCIYXg4Yg9gdgcHbzWp6MaRvMrDLmZ2MZD?=
 =?us-ascii?Q?d4TdP+vwktzjDiviS9CQQlV1DdTwtC7zN5I/2ZHXqgq4pMls5wG5ylhoDaf9?=
 =?us-ascii?Q?2h7MGKTz6XIcP7JHc5MXvdROmBYvvEVqfWtforcDR2xYnwZyWSxIQk1CopZb?=
 =?us-ascii?Q?dkZX1hM7Bu3bYLL23kqyjnVy9OLYbWfHRlImkp7DqjrwWf2Gop6xKRuBQqHr?=
 =?us-ascii?Q?r9OPpCCI1g4u3eHoKCJZuhs1NZviapHSidRdt8SvshRyJi+uPfcAVXzYBZru?=
 =?us-ascii?Q?nXp2myMsZRpzFpbbVq/6Yw5mgJAqBiuxQQEMci7r95UBK3cvzYl6FDRGi4T6?=
 =?us-ascii?Q?Lb8QD6Wmfhgyl8XMSH9tRoGt+HmP5OYFHCVL52pHXTYqTt4/Y2SgXtqFpJmZ?=
 =?us-ascii?Q?KKWSWsvpluW/AVNbKSTznSRZFXagFGRUsc0wrfrc9l4EneDBCyAXay58vMXr?=
 =?us-ascii?Q?MhpqRkHRRRaOIzn/6CUrsMrFgcBv7Zs8PLYaFqOC/0P8DwcNUl+Nis3BL4IQ?=
 =?us-ascii?Q?q0JDkLFamux0/Ba0pGB6+qKS3iZ5qyYEAWDSx8o9sddRSiAxfAPAwtuT+SU2?=
 =?us-ascii?Q?0iJAchnQDOP2ad1vral7+2Nv4RUcqjsjlG8ZK1nIVOZ6OD/h08fPSp8el/mD?=
 =?us-ascii?Q?MEz/EZKVI8leFqbmtjREoOjEA5S+3/Bf60is6gxzV4PCT6RlySu8nAoCnDMs?=
 =?us-ascii?Q?D43c3+izDgxRVpgg9wI7qgI4V58LzFQutVNsBwgs89jN5bHkbtqKRHK5daQd?=
 =?us-ascii?Q?35PvNA8XkRdDrvZE8j0T/rEaBJ6gDnz/mYd7sjcQoOfRzZGYFY5EezZ0aplj?=
 =?us-ascii?Q?A+QaeHv25HjXtz6IvcUKb3tf0VY8fnCzN9dsEfkQDsqu5UPBkS6eeC5iz8rh?=
 =?us-ascii?Q?zArRz1RjSarGZTJjI032LWLy4501de06XPUQEkWQDSfuYvAKm+AusyKFtvYo?=
 =?us-ascii?Q?++JER80n7ga3W+GDnebtEYOXTmFHpKnprympMKzehKw/yWV4FpjGLVnj5Fhn?=
 =?us-ascii?Q?vs2sRyE9ddbcfx+QmjI8YFmWL6DEjcyQ6j07Q5Cqx52ljZQE0twBQDsUJiyA?=
 =?us-ascii?Q?tkSgjwX6WUuqwrSS0n3e2n36xspB27qHMnYBNaLX4LHFn74ox9VydH7OQUtJ?=
 =?us-ascii?Q?+D+tXEDbkpMDTlwz2586eMNysgJPKBbpXtzeJWeiaeRAwfd4fr3X+iz7zhPX?=
 =?us-ascii?Q?vl3Xe1wpCjcsV7WV+dhiiMP69IFj?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7726.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?i3+k80RX9FsB7JlidN+vrdJ3rB2GB1+u9dInDrfL/MMMiZZsprN77/3pV1FA?=
 =?us-ascii?Q?y5OPVFavetyjeH8J/So/+vUspIfm6ZZkdDkRce6mh+HwUq8RSCre7BMPEKbB?=
 =?us-ascii?Q?vYWiGoS+UaKnFX+oaFC/DXhmFkM55KYJ0iHsqgLr1WqyW/dKitzxyqVGwrQz?=
 =?us-ascii?Q?BRXxKrsMNMC7MRer5tizcUIalQ3x2UxuLWhcPFsve+cTTepWj7miSMIQ9MMO?=
 =?us-ascii?Q?z0eQmjZNNWqrwU3Zs9dTCRT+lH/q/dWNcAz7foclhsLin0HKEUtrxYHpk8TK?=
 =?us-ascii?Q?cLn+mHYnaPtsh/B7M2GEYCgi9l0+r05VTPZstdC3UMDrUFVm6LTJCBJ4GBHn?=
 =?us-ascii?Q?p86EvzDXzgV6VSjR9rur2X97tbC29pMGWizP0Yp8Wm0KPkaGEoznC0GpDj95?=
 =?us-ascii?Q?n8LBie466dmm7YReZAK5PZCn7UGWY+z/3h+xt+feKruJoOh27Cq/bC+vt42S?=
 =?us-ascii?Q?NaNGleGCaXQaNxkp5J5BMyFenPwxKrgaKXkazdE9AAqo77YR+XG8jb8VLeW4?=
 =?us-ascii?Q?TNfRq3s4Stl+/WtbPqNgXwWihNKkWq48K1OWhRMu5LH+cr0ZJNuecN44n//0?=
 =?us-ascii?Q?9icfvRXTMUXaRb2iYl1CyODH0LbojcfLhMvFyalwRp66pn1QEuIOjW/PPyTT?=
 =?us-ascii?Q?6US++8/7mYLh/nna33m5C7eOr30b2xx7HIZfyLr7T6PwfHneDwvuyAI8fd3x?=
 =?us-ascii?Q?bhJv23eMpmd+QNl2xbqd8MIFh5pvQmWCeHW2fbuPDaBUSqVC/eoX9NqBcuvn?=
 =?us-ascii?Q?wg6BqZcxoGq4exCFjKyN+gwxKEyeo6tM/y/ojSz+Nj7XyV6xzzVPDYQOOAOk?=
 =?us-ascii?Q?GL3Y5olaj4Snu7xgGwIwTCSEdUOticWRiYlVUoXOQVbmmFdwDlGYmqwUiSvA?=
 =?us-ascii?Q?inSVRvtMtja91aWBNS1jpIOCzbv4khQUUCdOnoCuZqsT17v+NVl9m8DnBz6y?=
 =?us-ascii?Q?HVhDwc8sRks16utL7MFUxncaODVziB+8e1EYy7DOHq47Yu5ClEnN9Km0Y0Bu?=
 =?us-ascii?Q?EII/W/Llzo58rsjoW5G68ngWJT80a1KpnqhZryBt6qfBUtoU4H3oReLstwLU?=
 =?us-ascii?Q?n2TK/kxOmCGnGbFGakzbsCcCGyrjkdNiKQyGQhAkKcE6p3gGxj/CnMwuxPIu?=
 =?us-ascii?Q?VqF/YyH9nzF7e7H+XSyuvG4bz0l3du2KUNk5jgdiWPH+R3/cCygMT4lovfxi?=
 =?us-ascii?Q?bve8okfHe9pqUTD0z1XBdMbChMQpWJvXVMlMnjK5vTr7KkdrMwxWW+N1XwhQ?=
 =?us-ascii?Q?MU36BdpJCCfiakWoxjLjldqoUqwxG/UAQHT//G2eqZ452kT5PT71qSbnGGJ9?=
 =?us-ascii?Q?clnAsHuEEWfw1MgspZ6+pA8Eegth95cKpFhhFIqDwsUGcSpDKjQk00jAPpxG?=
 =?us-ascii?Q?8TNmHdE4TAYZ88MANuG+YbGA/ckNf2vVY8MazLF81vC/Oi1yYgSydVa0teTs?=
 =?us-ascii?Q?wrwHiZLt6Q1LFGUpeg9F435Ialz0vpuEbib5vdsQ2q6bXE6oRAGnzSzQwKtb?=
 =?us-ascii?Q?9zVXhpJWEya4DkB34w1QDkp2Vs0rFpTN8ZkNbK4qFd6T6ep5bFrLLRTnWAoJ?=
 =?us-ascii?Q?b8PhW5jAR4x/kP+pOi1KiDIdnG83oRkPt5hsSTms?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 016b4d51-ea95-47aa-b0d7-08dd456e2e32
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7726.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2025 22:49:28.3391
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WrLlpPBTl+CFJq/KyrutgIvpfZe/ndqQBbgqZjVjIh5/f6vbTaqN1K2wJIjLFeGnvDukVXekUBf8wyDKFrMHYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8537

Zone device pages are used to represent various type of device memory
managed by device drivers. Currently compound zone device pages are
not supported. This is because MEMORY_DEVICE_FS_DAX pages are the only
user of higher order zone device pages and have their own page
reference counting.

A future change will unify FS DAX reference counting with normal page
reference counting rules and remove the special FS DAX reference
counting. Supporting that requires compound zone device pages.

Supporting compound zone device pages requires compound_head() to
distinguish between head and tail pages whilst still preserving the
special struct page fields that are specific to zone device pages.

A tail page is distinguished by having bit zero being set in
page->compound_head, with the remaining bits pointing to the head
page. For zone device pages page->compound_head is shared with
page->pgmap.

The page->pgmap field must be common to all pages within a folio, even
if the folio spans memory sections.  Therefore pgmap is the same for
both head and tail pages and can be moved into the folio and we can
use the standard scheme to find compound_head from a tail page.

Signed-off-by: Alistair Popple <apopple@nvidia.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Acked-by: David Hildenbrand <david@redhat.com>

---

Changes for v7:
 - Skip ZONE_DEVICE PMDs during mlock which was previously a separate
   patch.

Changes for v4:
 - Fix build breakages reported by kernel test robot

Changes since v2:

 - Indentation fix
 - Rename page_dev_pagemap() to page_pgmap()
 - Rename folio _unused field to _unused_pgmap_compound_head
 - s/WARN_ON/VM_WARN_ON_ONCE_PAGE/

Changes since v1:

 - Move pgmap to the folio as suggested by Matthew Wilcox
---
 drivers/gpu/drm/nouveau/nouveau_dmem.c |  3 ++-
 drivers/pci/p2pdma.c                   |  6 +++---
 include/linux/memremap.h               |  6 +++---
 include/linux/migrate.h                |  4 ++--
 include/linux/mm_types.h               |  9 +++++++--
 include/linux/mmzone.h                 | 12 +++++++++++-
 lib/test_hmm.c                         |  3 ++-
 mm/hmm.c                               |  2 +-
 mm/memory.c                            |  4 +++-
 mm/memremap.c                          | 14 +++++++-------
 mm/migrate_device.c                    |  7 +++++--
 mm/mlock.c                             |  2 ++
 mm/mm_init.c                           |  2 +-
 13 files changed, 49 insertions(+), 25 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nouveau_dmem.c b/drivers/gpu/drm/nouveau/nouveau_dmem.c
index 1a07256..61d0f41 100644
--- a/drivers/gpu/drm/nouveau/nouveau_dmem.c
+++ b/drivers/gpu/drm/nouveau/nouveau_dmem.c
@@ -88,7 +88,8 @@ struct nouveau_dmem {
 
 static struct nouveau_dmem_chunk *nouveau_page_to_chunk(struct page *page)
 {
-	return container_of(page->pgmap, struct nouveau_dmem_chunk, pagemap);
+	return container_of(page_pgmap(page), struct nouveau_dmem_chunk,
+			    pagemap);
 }
 
 static struct nouveau_drm *page_to_drm(struct page *page)
diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
index 04773a8..19214ec 100644
--- a/drivers/pci/p2pdma.c
+++ b/drivers/pci/p2pdma.c
@@ -202,7 +202,7 @@ static const struct attribute_group p2pmem_group = {
 
 static void p2pdma_page_free(struct page *page)
 {
-	struct pci_p2pdma_pagemap *pgmap = to_p2p_pgmap(page->pgmap);
+	struct pci_p2pdma_pagemap *pgmap = to_p2p_pgmap(page_pgmap(page));
 	/* safe to dereference while a reference is held to the percpu ref */
 	struct pci_p2pdma *p2pdma =
 		rcu_dereference_protected(pgmap->provider->p2pdma, 1);
@@ -1025,8 +1025,8 @@ enum pci_p2pdma_map_type
 pci_p2pdma_map_segment(struct pci_p2pdma_map_state *state, struct device *dev,
 		       struct scatterlist *sg)
 {
-	if (state->pgmap != sg_page(sg)->pgmap) {
-		state->pgmap = sg_page(sg)->pgmap;
+	if (state->pgmap != page_pgmap(sg_page(sg))) {
+		state->pgmap = page_pgmap(sg_page(sg));
 		state->map = pci_p2pdma_map_type(state->pgmap, dev);
 		state->bus_off = to_p2p_pgmap(state->pgmap)->bus_offset;
 	}
diff --git a/include/linux/memremap.h b/include/linux/memremap.h
index 3f7143a..0256a42 100644
--- a/include/linux/memremap.h
+++ b/include/linux/memremap.h
@@ -161,7 +161,7 @@ static inline bool is_device_private_page(const struct page *page)
 {
 	return IS_ENABLED(CONFIG_DEVICE_PRIVATE) &&
 		is_zone_device_page(page) &&
-		page->pgmap->type == MEMORY_DEVICE_PRIVATE;
+		page_pgmap(page)->type == MEMORY_DEVICE_PRIVATE;
 }
 
 static inline bool folio_is_device_private(const struct folio *folio)
@@ -173,13 +173,13 @@ static inline bool is_pci_p2pdma_page(const struct page *page)
 {
 	return IS_ENABLED(CONFIG_PCI_P2PDMA) &&
 		is_zone_device_page(page) &&
-		page->pgmap->type == MEMORY_DEVICE_PCI_P2PDMA;
+		page_pgmap(page)->type == MEMORY_DEVICE_PCI_P2PDMA;
 }
 
 static inline bool is_device_coherent_page(const struct page *page)
 {
 	return is_zone_device_page(page) &&
-		page->pgmap->type == MEMORY_DEVICE_COHERENT;
+		page_pgmap(page)->type == MEMORY_DEVICE_COHERENT;
 }
 
 static inline bool folio_is_device_coherent(const struct folio *folio)
diff --git a/include/linux/migrate.h b/include/linux/migrate.h
index 29919fa..61899ec 100644
--- a/include/linux/migrate.h
+++ b/include/linux/migrate.h
@@ -205,8 +205,8 @@ struct migrate_vma {
 	unsigned long		end;
 
 	/*
-	 * Set to the owner value also stored in page->pgmap->owner for
-	 * migrating out of device private memory. The flags also need to
+	 * Set to the owner value also stored in page_pgmap(page)->owner
+	 * for migrating out of device private memory. The flags also need to
 	 * be set to MIGRATE_VMA_SELECT_DEVICE_PRIVATE.
 	 * The caller should always set this field when using mmu notifier
 	 * callbacks to avoid device MMU invalidations for device private
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 6b27db7..5e14da6 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -129,8 +129,11 @@ struct page {
 			unsigned long compound_head;	/* Bit zero is set */
 		};
 		struct {	/* ZONE_DEVICE pages */
-			/** @pgmap: Points to the hosting device page map. */
-			struct dev_pagemap *pgmap;
+			/*
+			 * The first word is used for compound_head or folio
+			 * pgmap
+			 */
+			void *_unused_pgmap_compound_head;
 			void *zone_device_data;
 			/*
 			 * ZONE_DEVICE private pages are counted as being
@@ -299,6 +302,7 @@ typedef struct {
  * @_refcount: Do not access this member directly.  Use folio_ref_count()
  *    to find how many references there are to this folio.
  * @memcg_data: Memory Control Group data.
+ * @pgmap: Metadata for ZONE_DEVICE mappings
  * @virtual: Virtual address in the kernel direct map.
  * @_last_cpupid: IDs of last CPU and last process that accessed the folio.
  * @_entire_mapcount: Do not use directly, call folio_entire_mapcount().
@@ -337,6 +341,7 @@ struct folio {
 	/* private: */
 				};
 	/* public: */
+				struct dev_pagemap *pgmap;
 			};
 			struct address_space *mapping;
 			pgoff_t index;
diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index 9540b41..8aecbbb 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -1158,6 +1158,12 @@ static inline bool is_zone_device_page(const struct page *page)
 	return page_zonenum(page) == ZONE_DEVICE;
 }
 
+static inline struct dev_pagemap *page_pgmap(const struct page *page)
+{
+	VM_WARN_ON_ONCE_PAGE(!is_zone_device_page(page), page);
+	return page_folio(page)->pgmap;
+}
+
 /*
  * Consecutive zone device pages should not be merged into the same sgl
  * or bvec segment with other types of pages or if they belong to different
@@ -1173,7 +1179,7 @@ static inline bool zone_device_pages_have_same_pgmap(const struct page *a,
 		return false;
 	if (!is_zone_device_page(a))
 		return true;
-	return a->pgmap == b->pgmap;
+	return page_pgmap(a) == page_pgmap(b);
 }
 
 extern void memmap_init_zone_device(struct zone *, unsigned long,
@@ -1188,6 +1194,10 @@ static inline bool zone_device_pages_have_same_pgmap(const struct page *a,
 {
 	return true;
 }
+static inline struct dev_pagemap *page_pgmap(const struct page *page)
+{
+	return NULL;
+}
 #endif
 
 static inline bool folio_is_zone_device(const struct folio *folio)
diff --git a/lib/test_hmm.c b/lib/test_hmm.c
index 056f2e4..ffd0c6f 100644
--- a/lib/test_hmm.c
+++ b/lib/test_hmm.c
@@ -195,7 +195,8 @@ static int dmirror_fops_release(struct inode *inode, struct file *filp)
 
 static struct dmirror_chunk *dmirror_page_to_chunk(struct page *page)
 {
-	return container_of(page->pgmap, struct dmirror_chunk, pagemap);
+	return container_of(page_pgmap(page), struct dmirror_chunk,
+			    pagemap);
 }
 
 static struct dmirror_device *dmirror_page_to_device(struct page *page)
diff --git a/mm/hmm.c b/mm/hmm.c
index 7e0229a..082f7b7 100644
--- a/mm/hmm.c
+++ b/mm/hmm.c
@@ -248,7 +248,7 @@ static int hmm_vma_handle_pte(struct mm_walk *walk, unsigned long addr,
 		 * just report the PFN.
 		 */
 		if (is_device_private_entry(entry) &&
-		    pfn_swap_entry_to_page(entry)->pgmap->owner ==
+		    page_pgmap(pfn_swap_entry_to_page(entry))->owner ==
 		    range->dev_private_owner) {
 			cpu_flags = HMM_PFN_VALID;
 			if (is_writable_device_private_entry(entry))
diff --git a/mm/memory.c b/mm/memory.c
index 539c0f7..17add52 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -4315,6 +4315,7 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 			vmf->page = pfn_swap_entry_to_page(entry);
 			ret = remove_device_exclusive_entry(vmf);
 		} else if (is_device_private_entry(entry)) {
+			struct dev_pagemap *pgmap;
 			if (vmf->flags & FAULT_FLAG_VMA_LOCK) {
 				/*
 				 * migrate_to_ram is not yet ready to operate
@@ -4339,7 +4340,8 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 			 */
 			get_page(vmf->page);
 			pte_unmap_unlock(vmf->pte, vmf->ptl);
-			ret = vmf->page->pgmap->ops->migrate_to_ram(vmf);
+			pgmap = page_pgmap(vmf->page);
+			ret = pgmap->ops->migrate_to_ram(vmf);
 			put_page(vmf->page);
 		} else if (is_hwpoison_entry(entry)) {
 			ret = VM_FAULT_HWPOISON;
diff --git a/mm/memremap.c b/mm/memremap.c
index 07bbe0e..68099af 100644
--- a/mm/memremap.c
+++ b/mm/memremap.c
@@ -458,8 +458,8 @@ EXPORT_SYMBOL_GPL(get_dev_pagemap);
 
 void free_zone_device_folio(struct folio *folio)
 {
-	if (WARN_ON_ONCE(!folio->page.pgmap->ops ||
-			!folio->page.pgmap->ops->page_free))
+	if (WARN_ON_ONCE(!folio->pgmap->ops ||
+			!folio->pgmap->ops->page_free))
 		return;
 
 	mem_cgroup_uncharge(folio);
@@ -486,12 +486,12 @@ void free_zone_device_folio(struct folio *folio)
 	 * to clear folio->mapping.
 	 */
 	folio->mapping = NULL;
-	folio->page.pgmap->ops->page_free(folio_page(folio, 0));
+	folio->pgmap->ops->page_free(folio_page(folio, 0));
 
-	switch (folio->page.pgmap->type) {
+	switch (folio->pgmap->type) {
 	case MEMORY_DEVICE_PRIVATE:
 	case MEMORY_DEVICE_COHERENT:
-		put_dev_pagemap(folio->page.pgmap);
+		put_dev_pagemap(folio->pgmap);
 		break;
 
 	case MEMORY_DEVICE_FS_DAX:
@@ -514,7 +514,7 @@ void zone_device_page_init(struct page *page)
 	 * Drivers shouldn't be allocating pages after calling
 	 * memunmap_pages().
 	 */
-	WARN_ON_ONCE(!percpu_ref_tryget_live(&page->pgmap->ref));
+	WARN_ON_ONCE(!percpu_ref_tryget_live(&page_pgmap(page)->ref));
 	set_page_count(page, 1);
 	lock_page(page);
 }
@@ -523,7 +523,7 @@ EXPORT_SYMBOL_GPL(zone_device_page_init);
 #ifdef CONFIG_FS_DAX
 bool __put_devmap_managed_folio_refs(struct folio *folio, int refs)
 {
-	if (folio->page.pgmap->type != MEMORY_DEVICE_FS_DAX)
+	if (folio->pgmap->type != MEMORY_DEVICE_FS_DAX)
 		return false;
 
 	/*
diff --git a/mm/migrate_device.c b/mm/migrate_device.c
index 9cf2659..2209070 100644
--- a/mm/migrate_device.c
+++ b/mm/migrate_device.c
@@ -106,6 +106,7 @@ static int migrate_vma_collect_pmd(pmd_t *pmdp,
 	arch_enter_lazy_mmu_mode();
 
 	for (; addr < end; addr += PAGE_SIZE, ptep++) {
+		struct dev_pagemap *pgmap;
 		unsigned long mpfn = 0, pfn;
 		struct folio *folio;
 		struct page *page;
@@ -133,9 +134,10 @@ static int migrate_vma_collect_pmd(pmd_t *pmdp,
 				goto next;
 
 			page = pfn_swap_entry_to_page(entry);
+			pgmap = page_pgmap(page);
 			if (!(migrate->flags &
 				MIGRATE_VMA_SELECT_DEVICE_PRIVATE) ||
-			    page->pgmap->owner != migrate->pgmap_owner)
+			    pgmap->owner != migrate->pgmap_owner)
 				goto next;
 
 			mpfn = migrate_pfn(page_to_pfn(page)) |
@@ -151,12 +153,13 @@ static int migrate_vma_collect_pmd(pmd_t *pmdp,
 				goto next;
 			}
 			page = vm_normal_page(migrate->vma, addr, pte);
+			pgmap = page_pgmap(page);
 			if (page && !is_zone_device_page(page) &&
 			    !(migrate->flags & MIGRATE_VMA_SELECT_SYSTEM))
 				goto next;
 			else if (page && is_device_coherent_page(page) &&
 			    (!(migrate->flags & MIGRATE_VMA_SELECT_DEVICE_COHERENT) ||
-			     page->pgmap->owner != migrate->pgmap_owner))
+			     pgmap->owner != migrate->pgmap_owner))
 				goto next;
 			mpfn = migrate_pfn(pfn) | MIGRATE_PFN_MIGRATE;
 			mpfn |= pte_write(pte) ? MIGRATE_PFN_WRITE : 0;
diff --git a/mm/mlock.c b/mm/mlock.c
index cde076f..3cb72b5 100644
--- a/mm/mlock.c
+++ b/mm/mlock.c
@@ -368,6 +368,8 @@ static int mlock_pte_range(pmd_t *pmd, unsigned long addr,
 		if (is_huge_zero_pmd(*pmd))
 			goto out;
 		folio = pmd_folio(*pmd);
+		if (folio_is_zone_device(folio))
+			goto out;
 		if (vma->vm_flags & VM_LOCKED)
 			mlock_folio(folio);
 		else
diff --git a/mm/mm_init.c b/mm/mm_init.c
index 359734b..8719e84 100644
--- a/mm/mm_init.c
+++ b/mm/mm_init.c
@@ -998,7 +998,7 @@ static void __ref __init_zone_device_page(struct page *page, unsigned long pfn,
 	 * and zone_device_data.  It is a bug if a ZONE_DEVICE page is
 	 * ever freed or placed on a driver-private list.
 	 */
-	page->pgmap = pgmap;
+	page_folio(page)->pgmap = pgmap;
 	page->zone_device_data = NULL;
 
 	/*
-- 
git-series 0.9.1

