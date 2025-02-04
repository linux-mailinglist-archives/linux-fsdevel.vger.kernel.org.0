Return-Path: <linux-fsdevel+bounces-40830-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BE5DA27E6F
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Feb 2025 23:48:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C27797A2F15
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Feb 2025 22:48:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B224721C183;
	Tue,  4 Feb 2025 22:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="D0MuUF8M"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2085.outbound.protection.outlook.com [40.107.244.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0AE9204F94;
	Tue,  4 Feb 2025 22:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738709322; cv=fail; b=mBTrkUdg14WeFQmKuLbZW2t7jhOl7kraGShKXZbeMN5yCdWNFGGxrVrzkQ9HkV+1Y4D9ATf68nWzi46sBAc9+/Av6/RQrUzmvllDtAex98wcKfC3jKZA501afIGFz3SmlQhRROxGYTdY4tiY04S975IiZVyq5W4wQhQFbjTuG4E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738709322; c=relaxed/simple;
	bh=t+6w2tveyPUumkvTjjXS7+U0bXQrTX59hzkoG3+0eu8=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=b5AKDkD3RiSvseqp8uuhHT9/6vrLvqFaVeLL8VUrbpIRvbWPCdPJPnkQAICt32awzuXcINoctmbdyjcNx4Yf7uMAOrJQ3+Ul7YFwU/kgKpHM3EUdM/DkVIcNQhsEiMVDjojQO13PTPh0yPXcq9x984B8YZ/jovSfOc5LdCGA6PE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=D0MuUF8M; arc=fail smtp.client-ip=40.107.244.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jW77qfl/QX1aZc9MkCKee1phtTr+pVCS17sc3Tw/AGg6rgVsrsEAFsQkCqYBAwbFZeZcGQNg6OvKxi92LuaoMm9xSdbBAIP4gwJ2wzNYoguPcWiNc0zeLRTGNMvZQxNkpx/zAv1QVK3+4BzNOCByDbLl7GvgajgolGgBHNuGPjgXWqlrxoVMoT7qIxGHeoUu7DD99Pe184O6ZNoU6PaQSSF+1yyH0M5WLmkM1xWbecO+EwlMo3ykhNxJbfNJMpgjuso0fqve9EVuUrs7xK/aMTMJYbPZ11/paDoaDz0FUKYucbhUbHyj8hIbSx/HLgbZ+QwfXJTmiqHUsTmb+oKCGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/inoTJc8+o3l+uK0gQvsLcVvksP0uxxGSEzxeEINIRs=;
 b=Y9suDxSseHbSFgzyd8entujf8xRlNjCwExioC/H5L04mJsIMafXBAirR9Jm9WsAaZtuTCgfhK8SyUmWxvVUww7Scf3igl5mxef+5zXa8XIESadz+7ZUaNjBIUSUrLzVivvsZZ0xnZfqI5EFmEC6BQQCMVgCEXuUmS/fIxg9WxFojVYcyejnioTfzPGPcwswjTu12kKqPbB1e6TIxNB9SfDCXTtSiCZhnnQVcUQ/b1dk459vbcty5dk7/aPTQbNPwfA0S422qNmB2Z6W1KEJ19GQ6wGDRCb3iTiS0adWTqHDu9qAnSIdyweS9VtpjFLfNCxVG48JFROVcN4XObG/Psw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/inoTJc8+o3l+uK0gQvsLcVvksP0uxxGSEzxeEINIRs=;
 b=D0MuUF8MxMJUS+pujYgrqP5HK1+4pblxGfUPYnjWbfejuY92JEbBEw86Zs7UYwpxl1yenNSrpg5DdHIWjPvQ9PDDU2lutlDiso365n7cBiyvcuvxd3WxeQO8up6OLZKoPJ4dqxMaJTZwj7xJ44B9kivwsciyMI6PkFv1R1I5BmljlbO4lCe88yhU4rBcy2c0Jf4fTOW5wS0WnOdFGxxi3e7365zuXRrYNvtAUMuFMxChExNL1Nb8W5ISz6GpIte149hoVsafheoL9RWfOmLVacp2X3xyz/UytMvaJSqy/HGuiVJLitTkG5N1l728g9CbYt+OlznpbrVoIunJ1ImRcg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6) by
 IA1PR12MB8537.namprd12.prod.outlook.com (2603:10b6:208:453::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.22; Tue, 4 Feb
 2025 22:48:36 +0000
Received: from DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe]) by DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe%7]) with mapi id 15.20.8398.025; Tue, 4 Feb 2025
 22:48:36 +0000
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
Subject: [PATCH v7 00/20] fs/dax: Fix ZONE_DEVICE page reference counts
Date: Wed,  5 Feb 2025 09:47:57 +1100
Message-ID: <cover.472dfc700f28c65ecad7591096a1dc7878ff6172.1738709036.git-series.apopple@nvidia.com>
X-Mailer: git-send-email 2.45.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SY5P282CA0048.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:10:20a::7) To DS0PR12MB7726.namprd12.prod.outlook.com
 (2603:10b6:8:130::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7726:EE_|IA1PR12MB8537:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a7c6803-6fa5-4b58-d504-08dd456e0f49
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?iCtgNngXBxYqULW8lBAQ0JnFhGVRvCBTQvncRHFBS+swV4PHz+91qHWYKmpK?=
 =?us-ascii?Q?qAvOi3qjJ9veTN7RTdOx4wnac4jWvTFbus5EOc48176ptiick3MIrBiFbCtM?=
 =?us-ascii?Q?oSx/oFSz8wHRGgICfrdadBF4Rc+or4rNn4RbytIz1rNerWe2wi3lkD7PPBs6?=
 =?us-ascii?Q?YJV5SSxSjnPKfsVvrdrbTxltv9jtvwQz+N9O7r+BC2dz6StOIYeW9E74ZIQw?=
 =?us-ascii?Q?c7QNngNricpizkaKjHq/tDJ2ntCAgp5rObj9CNElHVpQIEH4945C5DXZuUv0?=
 =?us-ascii?Q?wRyO611suT5b93jJLYo9JWVHJmJSpjBZhl3BPpBgva7FgMMuF4HmsFh2ktl4?=
 =?us-ascii?Q?BbFL15/1UeYycTtlu4KvLlalMEiU+mKOcDg39OUU61OpHZFF62uwqiMFojST?=
 =?us-ascii?Q?HGv9IKV9io8psNmtQOp+fBuxXvzcE5uLvUwJ+Bgz8q6CitYDChEHrRbjVh9Q?=
 =?us-ascii?Q?dEJEN1oIGECx8ETnsiXzgO8BPT6dPXtwH7VZSIFc8jWXUA0cUC8Ygpd+htU1?=
 =?us-ascii?Q?/W6oUsFGiLy+PFAqNKMswefCSS2Fqi8y5RMakJhSXgs/aJO31w+z3dCe1vgp?=
 =?us-ascii?Q?gjxNtzHea7yPODdwya5blGxUEc0tmmrvlk9agSoWYz7V22pC3FEU4KMyS4Rb?=
 =?us-ascii?Q?vWVJ0OYYpS3stIVbjBwY1krdKaNOKIKQnhcwO6+a35ZL1nAT6sm88uAx609U?=
 =?us-ascii?Q?LzPU0fzQ3gbniNNdH0jFqm7f1sa1VyPxKqw8vxW93w2BAo5mBsU8RE/HG7Te?=
 =?us-ascii?Q?bQDwtHTP4vVRLx5WNMt7GxOdq1Al/vR2IoNdFZDaGRNf5MDgjv1quGo+Ove/?=
 =?us-ascii?Q?jinyn2hWqxwtPrEa8G8KDWdJtwl5McsG0aXdCbSvkN4TqIs9vS2zUVLDFf1P?=
 =?us-ascii?Q?+RcvmNUe0HvzeR7Uj2myUog8tnDMKq6pAyZq52nj3sf+VF0r0+GBE/i2ifZO?=
 =?us-ascii?Q?ZA0NtNRqpQxhoPrbbjeXpVgRIqd9D8gGo/yS8/J5ufx2eXDQT+jeGzcpVOXe?=
 =?us-ascii?Q?blZc/G0Ziw8TceQjfzJYqLgJ/dThKRHFMFXGGLbxIYvE/268ssC9yxYVkmqG?=
 =?us-ascii?Q?qQsHNr1oQTrpLowO/sk5WXNO6qOVxN0aB1WD+1ibyKu6PYRm/GBiJ0wYCXuI?=
 =?us-ascii?Q?NdDWSSGtFSC9KFCeasIg3XxbQlbIicZ74QSg4T1e8p6n03Pa9DJ4lT9/lrGf?=
 =?us-ascii?Q?mMubI4ab7dkXy5nEcR0XHjYrlXZJ1rGv3Y1l0jbAODrMYGWd1O0vvvUEXrwB?=
 =?us-ascii?Q?+VbyZUNAZqwNrjUkpdPy2Awe9PS8Nx8M0ek+lmJz5cDAi8QgNpNDaQHDqnWJ?=
 =?us-ascii?Q?4MK7qHzlMOhiTY3+dZAtb9fIcB4lvzAcnwf2/YI4EYVH9vCyHAOCNaXc4lR3?=
 =?us-ascii?Q?Peso+7VCa8liiZUZX5SC/BrUbQCR?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7726.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9CxnnNVH/t7Vziwc6daDzseOdXEvCn1V6Kj8vNDlAz5hE/oRUbJJBZnKTCMe?=
 =?us-ascii?Q?vlgbhBFNL4JRUJ5dHLbE1nyF/W6P82PKqu7/QHrGLKoJZLXwTlF2v+1hjS1N?=
 =?us-ascii?Q?eWwmF+FzjKXnL2p+fhkiCFWHqoSw6/qPRCn6FvJY2F91Ky556LOuF5Ba8nqh?=
 =?us-ascii?Q?pQoKOTTmOI/jOXmVkAhWI5HUGpPVHrF6jTR1ODFV2zoxZgMuzQOb/Lq2wozm?=
 =?us-ascii?Q?FDSSvoNudJKdLk4ZTlC4fMsul2MNTI0IF6WjFV3yv6FZFraTWxFNfTwuAv6H?=
 =?us-ascii?Q?yrTv6tMkxlDvt9sXJMhlcyWxKH2PFMesY6tHOJV8OO6MJRlPrKpL50c1axnz?=
 =?us-ascii?Q?dVaPIf/+m2Mvb1TAF18WHbeCThcjVXZ9/Z+K1BLvE0DyBE7bi2Ki7ExsGTPY?=
 =?us-ascii?Q?wy4J599icNsD28DZddzOwat5v5sFjWpkvBJw+UBJXeEXEjykOj8QII6YOQzI?=
 =?us-ascii?Q?VZ6X6qjBRiF2QOPSA0teeYOtUedMysX1aGvxDoAspRP4mVFz0CTFhnb9MuJs?=
 =?us-ascii?Q?T/bK5e7AGDRXgMfUWAThNaKmtNwKyvomwVxIR36RLg7T6AisUdbCKGV/SMO6?=
 =?us-ascii?Q?/lrcr13KYrnR3b+qPGbrgpz6Q6ckA//hym7vFRZwU2abAVHa8uKujd8oXO23?=
 =?us-ascii?Q?yZKs6H37RKLcOl/y+lSpC69owb44aEcWdjbR4iUjjt0Tl3TgEpiuClSc4Czw?=
 =?us-ascii?Q?hCtCr7PDf3V0k22zk7v6lsedYwo7zKCB85cjv4KTPbp1ZHHQKsjzwDIwmYI6?=
 =?us-ascii?Q?14piD6Hg2QdrX4KFB+6xxJjmEJ8FerTRAaxlPhYRT/f0444HB6N/70KdzcAk?=
 =?us-ascii?Q?yBmCVc/ntpQihByxnqvVYEABUPrOyeZsF4h8P+O7orF+ACC/aGoOU178xjY5?=
 =?us-ascii?Q?LGFvcW+p4FkCoN30Ga3u2anP1TyAKLE8kYArJvuhETkQAcZNCaQtza4oeNsA?=
 =?us-ascii?Q?Nr85hTEev3PvKw+pnfAhyiRPFrU9EXhwLLppCij26cmIZphdll1SReHGPIeT?=
 =?us-ascii?Q?UW3LE2WZPfSJkuTxXYTdDxG/smuA/3nxpcd1/L6VqUw/8SY44gECPURrFtr2?=
 =?us-ascii?Q?wQuRuMewfNRKmkAYJJCXfRoLJMqcUxXpucDBaB7fkxwsFRz3LrOLwT4V4d4z?=
 =?us-ascii?Q?r7B/SgJZqv5+5amLddDoWOhCdosW/l6HKOi7bGPrcyTMDpY2TMIBlabum7r+?=
 =?us-ascii?Q?rm+5WXukcJ8M5/jYD66zl0MSJIMHf8wXoRmxNG+Z0kKUvyBOEM1hsQFcRwNG?=
 =?us-ascii?Q?DTC4iidlb0jMyP9hifcbzFKGXjdnIRYZ2IJJSwR96kMMszGIYNaLHfbuuzwc?=
 =?us-ascii?Q?jmK+3I/Cps4eqBNJoZK/g3BYggA7spG55RozK8H7MuFHTNME3gmeTm2tGDcR?=
 =?us-ascii?Q?GNV4TyfUGr+TBYjIjx00N99p2vgstfUsob/pmtuzdPAMe4yQKVWJIfY//fti?=
 =?us-ascii?Q?lI8iWmjnTsI1l22QBwWgi7fA/5BDw3f7qMJYs5WMuRF4x+Q0F9uXanjsuXDx?=
 =?us-ascii?Q?IHptOZghLWg3kfBHTm9tHgQp6aQ57km9HUzbJlz1xP+El/ANAsxfmoL5cOop?=
 =?us-ascii?Q?Hbz9BC/lwFaN7x1+sJSVzItGF9D6znP07XoNp6dI?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a7c6803-6fa5-4b58-d504-08dd456e0f49
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7726.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2025 22:48:36.3946
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C1qNUVHOrWXDppDui7ihHP8ef8EyQ4NquqOy9kcbA+lsN++hXRgoYCQMEl+uuMEfzmfEfdGlHxdzj5d2ljq35g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8537

Main updates since v6:

 - Clean ups and fixes based on feedback from David and Dan.

 - Rebased from next-20241216 to v6.14-rc1. No conflicts.

 - Dropped the PTE bit removals and clean-ups - will post this as a
   separate series to be merged after this one as Dan wanted it split
   up more and this series is already too big.

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

Alistair Popple (19):
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
  mm/gup: Don't allow FOLL_LONGTERM pinning of FS DAX pages
  fs/dax: Properly refcount fs dax pages
  device/dax: Properly refcount device dax pages when mapping

Dan Williams (1):
  dcssblk: Mark DAX broken, remove FS_DAX_LIMITED support

 Documentation/filesystems/dax.rst      |   1 +-
 drivers/dax/device.c                   |  15 +-
 drivers/gpu/drm/nouveau/nouveau_dmem.c |   3 +-
 drivers/nvdimm/pmem.c                  |   4 +-
 drivers/pci/p2pdma.c                   |  19 +-
 drivers/s390/block/Kconfig             |  12 +-
 drivers/s390/block/dcssblk.c           |  27 +-
 fs/dax.c                               | 367 +++++++++++++++++++-------
 fs/ext4/inode.c                        |  18 +-
 fs/fuse/dax.c                          |  30 +--
 fs/fuse/dir.c                          |   2 +-
 fs/fuse/file.c                         |   4 +-
 fs/fuse/virtio_fs.c                    |   3 +-
 fs/xfs/xfs_inode.c                     |  31 +--
 fs/xfs/xfs_inode.h                     |   2 +-
 fs/xfs/xfs_super.c                     |  12 +-
 include/linux/dax.h                    |  28 ++-
 include/linux/huge_mm.h                |   2 +-
 include/linux/memremap.h               |  17 +-
 include/linux/migrate.h                |   4 +-
 include/linux/mm.h                     |  36 +---
 include/linux/mm_types.h               |  16 +-
 include/linux/mmzone.h                 |  12 +-
 include/linux/page-flags.h             |   6 +-
 include/linux/rmap.h                   |  15 +-
 lib/test_hmm.c                         |   3 +-
 mm/gup.c                               |  14 +-
 mm/hmm.c                               |   2 +-
 mm/huge_memory.c                       | 163 ++++++++++--
 mm/internal.h                          |   2 +-
 mm/memory-failure.c                    |   6 +-
 mm/memory.c                            |  69 ++++-
 mm/memremap.c                          |  59 ++--
 mm/migrate_device.c                    |   7 +-
 mm/mlock.c                             |   2 +-
 mm/mm_init.c                           |  23 +-
 mm/rmap.c                              |  67 ++++-
 mm/swap.c                              |   2 +-
 mm/truncate.c                          |  16 +-
 39 files changed, 795 insertions(+), 326 deletions(-)

base-commit: 2014c95afecee3e76ca4a56956a936e23283f05b
-- 
git-series 0.9.1

