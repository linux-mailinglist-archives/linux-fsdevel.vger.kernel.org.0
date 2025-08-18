Return-Path: <linux-fsdevel+bounces-58172-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B19D6B2A89F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Aug 2025 16:07:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC24E2A0E4D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Aug 2025 13:55:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42AB227F727;
	Mon, 18 Aug 2025 13:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="J42GqNK4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2054.outbound.protection.outlook.com [40.107.220.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A48627BF84;
	Mon, 18 Aug 2025 13:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755525316; cv=fail; b=W31I2/kHUAslqILdhdmOo+hvyZ+huI3GrmZo3JWDWpjAc3SIShI0Juqo1uw0yyhizVsakPRqLz6wJdSUroRMUNNKgnkoPLxNUfyPsyi1pYbD9mwa7kx1jtZR+i2LPEu1xMACyt8rbzWEMNtM6/1AFGhloGn1C12V+VKZIdf/UE4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755525316; c=relaxed/simple;
	bh=GLVttyAec2BomIywVC7uYR4tJftZYRB4+zCTnuajy44=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=bz1YoNQ3ORBHUNPDFHqB4URbCg0z0oy7092bK4uAeb5Ol5Gp9ZzScFXYfjagbLhLuA1QOH2ZJtgUwUcrjWyqS0B5Pv1XweJTZ3VBsOmUAbHzJtpZ6ZcRPp80PQlWj8qvW/bkMYGp3DPlTFEVHVPUsHo81J430iBCPRHflztuekY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=J42GqNK4; arc=fail smtp.client-ip=40.107.220.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GqiVcUIiWULDdDdwToFG5TePDjdMhlvu7F+2INyQnmSxpUN/pcZiSAQZTcHopMswq/G2gAx6hoQ/nDRLIvplrQAHeKrTKX0zPxsFPbJqBMhl55EOgag1Xcl5PyNHMFqDy6Zokf74ec9DK6GQ4ox2xnQbegiyLsDOjYIRgzXr2nOkE/DIc6VqdE4k4MnbiCIaYLKcZ8D9wYriubyjHWfygdhKbirnfunpWnmouqs392lnsQhXjoH0Sc0qZ74zcWqYFl4Cd9/2JS6ZIncoZaLZGrH/+LrsPY1M0exBmTZgS4LRXWcvXdiZlCpNqtUXJL4SbcLjUa/cfTlFfpLp2a4+5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fXuwZHaPD8ErL4USrctAkqmnoAkbrX6RxrXIriX4VqM=;
 b=wwOKWBEaebcrGdj9MohwcjRwK4Ib/J2okPbZB6YX9ef21DS6XwDaWvjXOs1zHcVlNzjHWfxJ0+MN6Fn7xbsUjJH3ZwlUVyz1a4KsIwoyMQt7KfI2NLX8Z+3Pa9AeTgQ3sNyaR7p14Fl3/L5aUESI+4IcojXiK/0s8LEEy48nCpNdojHo49sS7Aqu94cCbcyRUlfpcbJjGvsF70Ie9Yc8Ue+hPjl8MB/cVm3jOa6KgEexJp4rruHncr7RZ7OtfJsQuVJs4qb9zorMGJHcRo4VeJAz0xDEA6wJbZZ/mrb3hkdgZw4IYxyvWeTs1PXZWsF/UCScman4Pm0dnBFNWe2U3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fXuwZHaPD8ErL4USrctAkqmnoAkbrX6RxrXIriX4VqM=;
 b=J42GqNK43D6BEQwOzRb7ZDSbKzYdh4U6Fgec5aEIQnFl0L/h5pgassu/joYbB6eDT/Q7fMFCk9Bbl8t7/KpglzYXmjoGY+sBIziCPe/4yZK2xZnKXrZcjzmKd+nQWX1/SWr/aXhBRzqdZrah3YceL0hHSF1GFfjX9fxiNbDrhmgq2krZKJVqmajPtmY9sZAC3EuLq2ZW3YNz3MI8Xez9jSTruofAKrOD5Nuolh+fFJ8F9OgTuR61qY/totSdpERnGyEDt6bUy8iKxXCfIke2xpkuizk0YYZk+TR2B8ME8IGsB1HuefshSbgXK9qkjzN6b1kiC1bhDvef6I2rSd9lmQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by CH3PR12MB7764.namprd12.prod.outlook.com (2603:10b6:610:14e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Mon, 18 Aug
 2025 13:55:11 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.9031.023; Mon, 18 Aug 2025
 13:55:11 +0000
Date: Mon, 18 Aug 2025 10:55:09 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Mike Rapoport <rppt@kernel.org>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>, pratyush@kernel.org,
	jasonmiu@google.com, graf@amazon.com, changyuanl@google.com,
	dmatlack@google.com, rientjes@google.com, corbet@lwn.net,
	rdunlap@infradead.org, ilpo.jarvinen@linux.intel.com,
	kanie@linux.alibaba.com, ojeda@kernel.org, aliceryhl@google.com,
	masahiroy@kernel.org, akpm@linux-foundation.org, tj@kernel.org,
	yoann.congal@smile.fr, mmaurer@google.com, roman.gushchin@linux.dev,
	chenridong@huawei.com, axboe@kernel.dk, mark.rutland@arm.com,
	jannh@google.com, vincent.guittot@linaro.org, hannes@cmpxchg.org,
	dan.j.williams@intel.com, david@redhat.com,
	joel.granados@kernel.org, rostedt@goodmis.org,
	anna.schumaker@oracle.com, song@kernel.org, zhangguopeng@kylinos.cn,
	linux@weissschuh.net, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-mm@kvack.org,
	gregkh@linuxfoundation.org, tglx@linutronix.de, mingo@redhat.com,
	bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
	hpa@zytor.com, rafael@kernel.org, dakr@kernel.org,
	bartosz.golaszewski@linaro.org, cw00.choi@samsung.com,
	myungjoo.ham@samsung.com, yesanishhere@gmail.com,
	Jonathan.Cameron@huawei.com, quic_zijuhu@quicinc.com,
	aleksander.lobakin@intel.com, ira.weiny@intel.com,
	andriy.shevchenko@linux.intel.com, leon@kernel.org, lukas@wunner.de,
	bhelgaas@google.com, wagi@kernel.org, djeffery@redhat.com,
	stuart.w.hayes@gmail.com, ptyadav@amazon.de, lennart@poettering.net,
	brauner@kernel.org, linux-api@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, saeedm@nvidia.com,
	ajayachandra@nvidia.com, parav@nvidia.com, leonro@nvidia.com,
	witu@nvidia.com
Subject: Re: [PATCH v3 07/30] kho: add interfaces to unpreserve folios and
 physical memory ranges
Message-ID: <20250818135509.GK802098@nvidia.com>
References: <20250807014442.3829950-1-pasha.tatashin@soleen.com>
 <20250807014442.3829950-8-pasha.tatashin@soleen.com>
 <20250814132233.GB802098@nvidia.com>
 <aJ756q-wWJV37fMm@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aJ756q-wWJV37fMm@kernel.org>
X-ClientProxiedBy: BL0PR02CA0131.namprd02.prod.outlook.com
 (2603:10b6:208:35::36) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|CH3PR12MB7764:EE_
X-MS-Office365-Filtering-Correlation-Id: e2263c24-9d73-48a1-d365-08ddde5ed93c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qqlsPz2ATyqjSe2h2YUoZTApYq/48IHKPxijtHQSg9cS1vrlMiTelhuYG5m3?=
 =?us-ascii?Q?S1PCEMoEjO0D/ZVS2TrWeriuyodAIGmDEnuAFlLAFIDgoivd9yRSw6G4IDnJ?=
 =?us-ascii?Q?JjJ84/ZtUmx0sjP9NAJOmxuaeIM1ayuujh0hfRhtaIqjqZr/UTGW8x9wST6B?=
 =?us-ascii?Q?xkDjIREBiaA9W/4Wk/kctAOZZ1pRfogbk0ggWL4DMd1TZw3ncuss4HI0l/Bx?=
 =?us-ascii?Q?9jRF5MhEq4XxI+Z7HItOGGk9J0voJY2Ysw4euTaxMHaQKDAs6lo+8muU/Am6?=
 =?us-ascii?Q?/hZBN7n+ipihCj0J0M+GOUorTvp2QjF+GNIL+JoI0eyIQsEEYymCCkNskGvN?=
 =?us-ascii?Q?JO38L48s5qI6seBxuvlJ+Qp3bXtK3ZP0lU+tlW/RUvl1iJh1MQjlBDhFdXHJ?=
 =?us-ascii?Q?3pNvzbVfRghHnWY/87s3B6MpppE4rxurogdx7EK6FSl12vTZXWdoZ14JdzPI?=
 =?us-ascii?Q?5B88Hl0HqdIBRfiemtRvaSLBIJ7eHWTnHtciwDXCzmY9CNWDiamm+q/5LTSX?=
 =?us-ascii?Q?rAuQtUG3qGPHOgLDCGfguc3tmhVEP0JQG9helWYwJre9wpa3jIC/JYOOgIUL?=
 =?us-ascii?Q?vnxva49woPB+XN/Q4+oiR8kE0elOWzMHvK3WGGD5uuAMsxRxrq3zvc3bTxAw?=
 =?us-ascii?Q?ppGny56raPEDM+xXTyriqmm76k0ACXij4P/4KmKVMfDZ183sBuHktgLZNQAP?=
 =?us-ascii?Q?0fctWw1mxVB2JbwgvpTH+EKvpHR2aa0mC84yxg2iPxP4qNnznI0tQ0n/X8mY?=
 =?us-ascii?Q?qaOTHa9jldAjwQQwE9r3qL5IsmwOgLLNVhphtYbeXPurccx9lJZrO5YlJNKq?=
 =?us-ascii?Q?ITZ0EEP054pHopbQcISsAFhoxzoHDK9aki+u3IJh+ll1WeiOwhDXR3wW0Sgi?=
 =?us-ascii?Q?bkZ4k1MMThellUZGKubj5NiXK2UEY/hhm4gg6prBWm2DL2GtsiykdzHBL3x4?=
 =?us-ascii?Q?s/ZdcaEEBrCIYVg/BY7qvlE1wIqIEQ1oLJPjxPUq3rF5/h8fdCWty1FJY/7s?=
 =?us-ascii?Q?0ig5xBTgN7sb27pkRVWaUgmQPaKoEBLAJD5IQ3bT7T+O+RE18Xw47olSyVej?=
 =?us-ascii?Q?BSlVhXLgPRy01miyOrQiEhlmrN5YW5jftLJJTQFA48N4FA3fzFLtB+D+N63H?=
 =?us-ascii?Q?IVuiTsx0/gp5CpL7f8KucZqzT7BEMfwFg1TT0+hpfWGJ0fCSxqKwBkdhW0mF?=
 =?us-ascii?Q?oJjeiNjoIKTF5xd+08GPmahiqYwWKI+MnRF+eCa/+woFe+qwEuAIAT8m1J4a?=
 =?us-ascii?Q?y/Fdmf7f37lp2s9Egkyeeect0tvjfC6qrLdqdkfMYn8mnVMB9NRmCfcdPvCa?=
 =?us-ascii?Q?gYDBm9LWFx7Y+VMLIesZCSvnDhqS3YbigjLYWiJrB8rMVRiQo71NLs2zqIXO?=
 =?us-ascii?Q?9Zv1KKCUBjqAJ5jrXE+fzzj0l49NnwtAKiCgPbcxXB+vlliyKQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kedtl8OYLGvsO1a5sVU03d0dlY/Fuchm8GXDD9uS6qsiMX5aSCyaaLIq4Pbh?=
 =?us-ascii?Q?pNS+PMlrYi8toda1MQgrhJXavoauGw1ZzSiyzwOxRlYQ3I/8m+VT+jgYQbwZ?=
 =?us-ascii?Q?y7CJAJXpaoCtcomG0Q8U/pmT+3e3AM1Q+0pUUOI+uGo3eHABhcMvpi4R1lln?=
 =?us-ascii?Q?oLAm7lVH5ZDfCTN7vKn/NxKWjcnT5BsrAvkgEefuJEwa4AqM4jW96TfwiCrM?=
 =?us-ascii?Q?OH/yW0CTWpwpo0DbyW8rAMRgct1vgBJNVymX30eofDsHn9HDcK0yHMYqRQnp?=
 =?us-ascii?Q?U8/Evug+4xJzC33nFFSWocmcHb147Sux1JbMD2pUb+fJ+F48+J1VKlB+/RQz?=
 =?us-ascii?Q?pG2jcpcIp/bL52LAte6XTIoxbNoMD8CNCkdV5uSoo3yyqPvBcHoxJCKd/8T/?=
 =?us-ascii?Q?QIO1Trk/aSlXECLrVHx3wC19Ye36ISS9/OV0xUXbFgVzTyP7vNHsO+LF4Co2?=
 =?us-ascii?Q?bkg4hUvWrOGciMZC3ETerfh5uhWNQVQnwaY9EZ3dnbT8GCwMEVmeZ88MJ/6i?=
 =?us-ascii?Q?B+h1faVRq7/J6/YGwuCsIjD+8M7V/D36VDSszyAKfn1n+b3YdSEZyqwyqNac?=
 =?us-ascii?Q?ftMsiLZkIuCvUrguHMnWA+guxG348xdJdtabAO7lFGLLMC+37V5B1+gljyK7?=
 =?us-ascii?Q?JvPq4E560NIekXUQ14X67wDa3yTeN9GuGA2fCDhBGVu0St/8pmQzibYIfTiB?=
 =?us-ascii?Q?hplmtXxaJ6MTyoJh8UAGI+k2267vXWk+KaxCvg5ucxuV/NA937pmPmSGpkNH?=
 =?us-ascii?Q?WzNrgEmBP4UslTtQgZUGhRdFG6ZATQhK3LGJ6c/YfiFor7E7alMbV3CggOYS?=
 =?us-ascii?Q?iGd11MJcpaWEBMnjzeuS7WCqLIxKkkUGGQ6sTQvcx5WrmiOtwHwRhohJsQEx?=
 =?us-ascii?Q?TY6wuvCvERWfCLxRyrqfHXm4ejyv2g4f6Sk6goVR0Jy1Kha1yT+puatULlwQ?=
 =?us-ascii?Q?T2ezVUazx9wu9NkdRfcrWWrwPEYYEKTbnQJseY2w7en7rXPLXan+PaLTzGRY?=
 =?us-ascii?Q?7b3re7odAhReI28Frs6GV1MrDq6AU1WeCu2TGLVNxOlhZZ6js6jdAtRrwXJX?=
 =?us-ascii?Q?TWfi9yZwfWOlizeITIhkdGLzLx7cS5Z7f+t/JeYWYrIHbfJBuvi6va1MiIZp?=
 =?us-ascii?Q?xwvemJkhEL+eyLUe/L099dtKkfDX7LnPdBHXihb2HgHP7VBTifTbyuduPsPo?=
 =?us-ascii?Q?aRoYdXHdRenrf6PLixlc9YLrulGgHJnX7Y5Hy84K1ohfR9Z8ao5abBCu6hLa?=
 =?us-ascii?Q?LH4yaq4++C6jrRxdKnzVWZsfP8pMbKfqt7e1LGucJJVVWRi8mp6y+vD4ojqM?=
 =?us-ascii?Q?Oh3tmjgjdAiTgzRiNC99Dxl4TfaM81jDXmDMc1ffhSUnLBPRwVeM9Gtni5H7?=
 =?us-ascii?Q?d8mYtWP0deC/ix1Fy14EgRwHzxZcarA8NYCwe2xH6w6UdB7LzcafetQr8QsW?=
 =?us-ascii?Q?Z/QoiyAZBmXO+lRg1KAMhwLqx8C0iFz5X9rLSvH0i2MB93aWznjpd2EdhweE?=
 =?us-ascii?Q?ekxUcigng94UThJePzGui+M24nkJ5O2/TuPkYRRjqrLi8XDlasWgNf9+A0Qy?=
 =?us-ascii?Q?N2tGMlIC0QeieWYZ6H9041TW9bjj+LwHKtSwvwoU?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2263c24-9d73-48a1-d365-08ddde5ed93c
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2025 13:55:11.2925
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NMoqcknRCrBdw3BXglkeAsBzzIM5xiHnuc2NMOewKC+V6bpq4JBaHcyJljexVZ46
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7764

On Fri, Aug 15, 2025 at 12:12:10PM +0300, Mike Rapoport wrote:
> > Which is perhaps another comment, if this __get_free_pages() is going
> > to be a common pattern (and I guess it will be) then the API should be
> > streamlined alot more:
> > 
> >  void *kho_alloc_preserved_memory(gfp, size);
> >  void kho_free_preserved_memory(void *);
> 
> This looks backwards to me. KHO should not deal with memory allocation,
> it's responsibility to preserve/restore memory objects it supports.

Then maybe those are luo_ helpers

But having users open code __get_free_pages() and convert to/from
struct page, phys, etc is not a great idea.

The use case is simply to get some memory to preserve, it should work
in terms of void *. We don't support slab today so this has to be
emulated with full pages, but this detail should not leak out of the
API.

Jason

