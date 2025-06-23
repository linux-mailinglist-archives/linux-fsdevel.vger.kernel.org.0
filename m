Return-Path: <linux-fsdevel+bounces-52600-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D6A4AE4727
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jun 2025 16:43:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0BC89447A5E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jun 2025 14:33:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7591925E449;
	Mon, 23 Jun 2025 14:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="CjFWokDv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2084.outbound.protection.outlook.com [40.107.220.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D3FB25DCE2;
	Mon, 23 Jun 2025 14:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750689229; cv=fail; b=TTYXksE3xSIzspGJct9xtkCRnvOMb+47LNoqL9Kz+w7j+iybNK+KPht/1VSdPHApqIpZLIK4rVfeRf5x0aZlFZd0roEUoWTFeTLFt9DQUd0P3MkLn6wgC5k1VBQiQhecqSy4TBxJQcHwAlEafXUpPgA8bPmRXbVsZlRJ4hL/vUY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750689229; c=relaxed/simple;
	bh=akM3xzt6IOpXlva+vXRrmb85xUlUjkKyA0tcFLsFzI4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OdFYZIYuT2xE/0xYp4EnKOo1O5hjf9hXNzFOaoYVjKpt0RZMCHF5BkqdiaA95pipKgaLBqgzljrBuvIhoCtKtQvVywE4k6Ldg0dUGmVpdelfpZsrNa74sroXuGSXzQ2rgGna79dTah9QOCwaf1YdhjXKO/DTB3vvdQEHSo33MxQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=CjFWokDv; arc=fail smtp.client-ip=40.107.220.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vCYNGNEMl0BTcwuPBwaaGHAIY1FclwzCQjeh3G9m+zRC13/UZ7lwAhnRwIMZ8weylrsHt9yfWMTZ2jGQ0NBnvnZwtYkf0xW1CWULZ9FMPbMglK1dgz64dnggCb5Z1atbD2emcKlNkeURnhqme70FPUFb/pDU7k9XvKIS5/4i4eJ2qswcEkFkUM9uKZ6QjVeSPtqfDSU1WQMIkdFhHalcf2k10LudpvvaKTqxqX9T8MhEB3il5Y6xnEeWx7OazF8AyJ7M30FU3Y/Qe2MruDL0hPIrwAUtNqAsVizkZVEh3mvTCTb1NJk8sSkfwFjoezmbZEZeocj+4hUEdD1QGohk7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2TZk/QtAnUGfl3LNIfs2PUj/eoUlz/vWbadDcXbLjtQ=;
 b=l0KZPN11bg4ZSLEqAKaNc9JF7te0gvNFuOCdr1cGP0ltcAWLKeDxMuMEEesE1R8Es/VTRZhBZmExd7z2+MxKRYkKW6lv/n54ib6CgE0PGhLieg6JxGRNy0jet9ZnqAPKvRYBSz1HDQXWBUD626z7gsW2vwtoL6BzLKspruYqPoQkcaWHnyncFqY+mY5wdabOobLeZFCFfSR/ETqXFCQu8sC+R/UgIZ8NROUoOT+/MPZTM4WwBbuAsDkX8rAtNAm+5q7lxdbMwi8sbuZTHOzXhzO2qMBkUSJkshhO+r0l/F/cuPQknrkbzlpUcAbPLPxvtdGaZGTEKE9P1k4Sk9xHMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2TZk/QtAnUGfl3LNIfs2PUj/eoUlz/vWbadDcXbLjtQ=;
 b=CjFWokDvIp8aNJP34mXq25eOsX4l7SO7tPWQMkVxVjyBNILPTjgdMI4FyYfszbRmYgdIH48ouqupd9BxOwdlDHznTdHWMynN8D6Ju/lqBeo+lUU7l6N39HEN/ZPJPUtbwLP+IQqeTlF+JFb+H2p28uHvNeilWS6oUQm09x+dAgGs5TNM/VOYFL+49PRZzEKz7P1G8QDRffg7XAKUwOxGQFWwpLdFSdczhinCKVTqUh0uhhSI3zsq5kNeQGjVY/363RPBlH9i2Ut4/1sntbHENrv3ChepBG5ECPEjdkfW3mUAN2dYzDQmuNoo422SheAvgxwPvonmB+1IQseyKn4KLA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 IA0PR12MB7750.namprd12.prod.outlook.com (2603:10b6:208:431::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.28; Mon, 23 Jun
 2025 14:33:44 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%5]) with mapi id 15.20.8835.037; Mon, 23 Jun 2025
 14:33:44 +0000
From: Zi Yan <ziy@nvidia.com>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Russell King <linux@armlinux.org.uk>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 "David S . Miller" <davem@davemloft.net>,
 Andreas Larsson <andreas@gaisler.com>, Jarkko Sakkinen <jarkko@kernel.org>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, "H . Peter Anvin" <hpa@zytor.com>,
 Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 Kees Cook <kees@kernel.org>, Peter Xu <peterx@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>, Nico Pache <npache@redhat.com>,
 Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>,
 Barry Song <baohua@kernel.org>, Xu Xin <xu.xin16@zte.com.cn>,
 Chengming Zhou <chengming.zhou@linux.dev>, Hugh Dickins <hughd@google.com>,
 Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 Rik van Riel <riel@surriel.com>, Harry Yoo <harry.yoo@oracle.com>,
 Dan Williams <dan.j.williams@intel.com>,
 Matthew Wilcox <willy@infradead.org>, Steven Rostedt <rostedt@goodmis.org>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Jason Gunthorpe <jgg@ziepe.ca>, John Hubbard <jhubbard@nvidia.com>,
 Muchun Song <muchun.song@linux.dev>, Oscar Salvador <osalvador@suse.de>,
 Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>,
 Johannes Weiner <hannes@cmpxchg.org>, Qi Zheng <zhengqi.arch@bytedance.com>,
 Shakeel Butt <shakeel.butt@linux.dev>, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 kvm@vger.kernel.org, sparclinux@vger.kernel.org, linux-sgx@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, nvdimm@lists.linux.dev,
 linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] mm: update core kernel code to use vm_flags_t
 consistently
Date: Mon, 23 Jun 2025 10:33:40 -0400
X-Mailer: MailMate (2.0r6265)
Message-ID: <9F6ABF80-EABC-45B1-ABEB-F3FA8D8B6B11@nvidia.com>
In-Reply-To: <d1588e7bb96d1ea3fe7b9df2c699d5b4592d901d.1750274467.git.lorenzo.stoakes@oracle.com>
References: <cover.1750274467.git.lorenzo.stoakes@oracle.com>
 <d1588e7bb96d1ea3fe7b9df2c699d5b4592d901d.1750274467.git.lorenzo.stoakes@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0189.namprd13.prod.outlook.com
 (2603:10b6:208:2be::14) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|IA0PR12MB7750:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d8478cc-be33-4301-3cbe-08ddb262f4fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?53XuHe/mashn1hG9Gxz6/K72t78PKWoGPU/cTO5lX/X1mXrg1wGWLTgTP89o?=
 =?us-ascii?Q?+CuEu3ZmBM7veL6gC3dEbC0iTaThcnzr7qv9trTq6MC8bbW0N0sMQmrWZxB3?=
 =?us-ascii?Q?HO6nxT7RlueTZnEC51YJG5MonV2o0OYBHmSjTaAUTXifoSexfl1XpPy73Oeu?=
 =?us-ascii?Q?gaQ+aD9iESZ5wvRQ7qpRPZuWSwpbgnZc8BbzksFfMJv7EnPHheEeYrynLWyR?=
 =?us-ascii?Q?GhWd+057nFQ/INui1sRSNrs5StOEnoqkAu0pb4KqNXfX0Czr/6ZMDupIyKno?=
 =?us-ascii?Q?q123n8g9BYJSt1/ih9/9Qp1UtxQgb/auH9D4J5n0gx1VHWr4LW66zxSMfZ8c?=
 =?us-ascii?Q?kbWpp7saV8OujGMZJ93a/r3eM3pxMVPHvP4szCmI9wtoiPHa+XJp+qRTEv5G?=
 =?us-ascii?Q?fTxy6/+uGpP7lKYdOMoCu55f8OfVgOsuwmSj1Kib/AGbH86rFuLLSOvNTicO?=
 =?us-ascii?Q?VW0gm0Az6p70qtfYkqpGscl9SyauVq9jToqIIW3mO+7mrkmKjyHu6FTT9iAl?=
 =?us-ascii?Q?ZvKD5c9J9XoB2Jsy/zKyBSRmOwznA0RniJ+rgIvUBtMz5pCPo+qIV8n9nUuB?=
 =?us-ascii?Q?c4AK02UBsOPmw1ZW8/wSUvB7HiAqgNlgTrHh9sVopZ10aUgrwTtOA1pIt9Q9?=
 =?us-ascii?Q?tM0dYw4KDEAxSSDERQXOY8sV3+DVgCJY8vZ3L+Z7jUE5aDvKq2raHmHjeh1Q?=
 =?us-ascii?Q?UTrjnwshRZK64Raz9XDsH9qkqKFgae+oqQz2aUzBbrkYyaIYiwKXRbL853uF?=
 =?us-ascii?Q?MbXPCo298CLgmZtaCXykhEfG/+59zNorZBuIS3DsUgsY21Vv+XBTNVst1SD5?=
 =?us-ascii?Q?NC8zgGWW8ENh9wOwUFWanPbns/5pZQDLbtNHU/lWRg7cUUSiRGMuOl7nzAkj?=
 =?us-ascii?Q?x8aZRlUvdtQjk9o11s/C4zxOKcjV09tmgl3sUPro8QaA93B9QMwd/X0NmHqA?=
 =?us-ascii?Q?rmG114nsErs52hdDnNB6IXQTtFmd/smP0U42wyaPdx18TqD/wY+aPlC/j8q9?=
 =?us-ascii?Q?6MbsACeKfumV3xkQpWfxiy02k8RTPOFmAy6qhtvO1BUUKDSsTavoTkYcDNNA?=
 =?us-ascii?Q?aJl+i72PR/woZHKjfq2v3LLKbw1UGcSjgCqMYNmFtKRmTXlpy1ay1an8ASxE?=
 =?us-ascii?Q?f5iQpBPtvPUqCKOpgg4scn+YwZ4bZI5TILMQPOxYOF8HKggXge69wkEugl45?=
 =?us-ascii?Q?Nm1l1ig1g2FXnGRZl9guqL71+YJk2kjlxtN/QxnpKB0dLmlSpwcTExJ3Dk4N?=
 =?us-ascii?Q?ZpYHqaIkrET9aePOT3KcZjHv41sXqLdIrLJS6t4EgaWQ9nJqf1hHhNr6jU3s?=
 =?us-ascii?Q?fmVPZqiO5GTh1UGXr+PZRwW/7zmqmtX2SR110hJFPnVZvozkHZ/GvB3lWgpQ?=
 =?us-ascii?Q?B9tjw4v3Yt6sqXZmoITLS7zJdq2Cnv9RJNeKaVJa1mLrx8Fgicrtiop/YI5A?=
 =?us-ascii?Q?pqWTrKtAcWw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?tdS9BTI4ILFTgOEea6jZKYxV2I3IW8pTDlImRPo/TwbLhCUkCZ2U1H2Vhlhy?=
 =?us-ascii?Q?+mhCdriLyzpyU3BUSD6W6NyjPNKONTLaRHCD13MgYcCzkiZY4oTlPG90KTb5?=
 =?us-ascii?Q?/46fEYDLsq16vCEigNcbwao3MPs1qP24+ng1tOm4acby77L9F8K0lo/cqJwV?=
 =?us-ascii?Q?LDOm53I6RD6C2e+eJWjYa4YNxWr7UMnrmky0V17Jqcy0IRGC8Dcl657YTgYD?=
 =?us-ascii?Q?pifT6u50VDZ4l3rcFK8UeQe6ALxw+aSGIvkx1f56z0ut7PjPm0wVz3no1U0E?=
 =?us-ascii?Q?gTPWGnKHCi3hQ15Gb6/RUWp1THKs0FkZHcPp0qJko7n9Wc5+TmMf1CYmIx63?=
 =?us-ascii?Q?mna5GapCQvOtT1XjbUiiK7yfErzazHqcBAVlLk5v6eDcGftGqUCjHiT21jHx?=
 =?us-ascii?Q?Rfia/v5dsyamRpUGDXPYG4+HcLLp2nAKH278/yRoXJGRKnBbGzS/DvZrHJi8?=
 =?us-ascii?Q?5OQsvtMrA2edtA6XyVMnBWkIOQ219NFk+cLdpnK3KJEaUiVnVRVZtxY+dKBW?=
 =?us-ascii?Q?RoGuhu+41zW6HBlBuWChOhZVGCchFuo+K7md16IvI+8PYLgXoAkt01N7HrsQ?=
 =?us-ascii?Q?wXPqcahZVjEvm5NNelaZGyL/jySNmZS0gui98mNCcmlykUx/GQAF1oa3f7or?=
 =?us-ascii?Q?n3lSRMK66hsP/mBpG5PCStng/v/+t1y1QFZrVIbJ85cVQfOuGarf++YHKABd?=
 =?us-ascii?Q?w0CbUvKmJGW2Ipfsb6pFGZ9iWo4iVcnDk5jbo4bJvvmr1exBXeMegiCcjl2H?=
 =?us-ascii?Q?GBB9lt8mxzrFJb9Ve7FXGBmIyVQqeOEGgyK/MJWCLR1BVlkE2/ijquTjgCuw?=
 =?us-ascii?Q?FxilnMNawa7XDE/Ii3ToZ+5vVrG/qPQIRpCpqhmRuRi+dGfqJ+JICuMCdhTk?=
 =?us-ascii?Q?OnLE8hXHwQ+XhLnwt1jqF8sNu7RZF8owM01PUb6dzaqLHpoefAI5xIJkpVHW?=
 =?us-ascii?Q?k8Ph7XupnfQi0Wgws75i8D0DkC20lJM/ov+F0lRpPkkuvTLwZR7pwxbTG1a9?=
 =?us-ascii?Q?mJs+LbkvueNAswaLIkTC42I7lElA/GSygKZjTDz6tYHIqKVAa20KpkYe1vz6?=
 =?us-ascii?Q?F4oHjyHW68Yl1HBsVwZjPlnJCR+sMxdKdISgkqtfr6P0t+rrtWarchNvesoV?=
 =?us-ascii?Q?l59B6+S1lwSYrZ9/WFk/R8iUdd8suk+uMjdhRpX0TPZVk2zW92srdE72zkQK?=
 =?us-ascii?Q?NEzIv0wJlyD54WWRNgnbSFjurOXnJSjwF12Ctpcmu/ABLGZsqic00WrqsbZz?=
 =?us-ascii?Q?US5WdRJLN+SvU5Mbv4R3uL5gHLd9iDWLDDnB5bXLVqgJLS2yut4GeNLODlbb?=
 =?us-ascii?Q?q0OLFjYXxfbafLsdZcKjh4MK2g11/7SN+XSczj06xe7CsvNNlMoYgGULIsRR?=
 =?us-ascii?Q?PIwKQUXDCUsoTjvwAEhq6litEMF1UFnRQPIDUX6OxBKpYui2Q9xHlJnZyHuU?=
 =?us-ascii?Q?3yVz6uSqIV412TKjaTGi/vrmQdokE/SwC9YqEFlnyfJttAMpTfv7zzmndy5w?=
 =?us-ascii?Q?Ekm5WZ+0Wkj4J0Nu1JkkVZRny6HHduioOUh/ZEyOID0iuPBK36Sv57bhItPL?=
 =?us-ascii?Q?1lx4sXiiUO2iISD39kaqDqG1TWFW+bRT7VCfxKOn?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d8478cc-be33-4301-3cbe-08ddb262f4fc
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2025 14:33:44.5759
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8EgYimbkU2NPOC4MapqHaEUGGfBUAPzTf2U0NZwQRT88HgeJrxYEaW2wMHUz1UuF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7750

On 18 Jun 2025, at 15:42, Lorenzo Stoakes wrote:

> The core kernel code is currently very inconsistent in its use of
> vm_flags_t vs. unsigned long. This prevents us from changing the type of
> vm_flags_t in the future and is simply not correct, so correct this.
>
> While this results in rather a lot of churn, it is a critical pre-requisite
> for a future planned change to VMA flag type.
>
> Additionally, update VMA userland tests to account for the changes.
>
> To make review easier and to break things into smaller parts, driver and
> architecture-specific changes is left for a subsequent commit.
>
> The code has been adjusted to cascade the changes across all calling code
> as far as is needed.
>
> We will adjust architecture-specific and driver code in a subsequent patch.
>
> Overall, this patch does not introduce any functional change.
>
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> ---
>  fs/exec.c                        |   2 +-
>  fs/userfaultfd.c                 |   2 +-
>  include/linux/coredump.h         |   2 +-
>  include/linux/huge_mm.h          |  12 +-
>  include/linux/khugepaged.h       |   4 +-
>  include/linux/ksm.h              |   4 +-
>  include/linux/memfd.h            |   4 +-
>  include/linux/mm.h               |   6 +-
>  include/linux/mm_types.h         |   2 +-
>  include/linux/mman.h             |   4 +-
>  include/linux/rmap.h             |   4 +-
>  include/linux/userfaultfd_k.h    |   4 +-
>  include/trace/events/fs_dax.h    |   6 +-
>  mm/debug.c                       |   2 +-
>  mm/execmem.c                     |   8 +-
>  mm/filemap.c                     |   2 +-
>  mm/gup.c                         |   2 +-
>  mm/huge_memory.c                 |   2 +-
>  mm/hugetlb.c                     |   4 +-
>  mm/internal.h                    |   4 +-
>  mm/khugepaged.c                  |   4 +-
>  mm/ksm.c                         |   2 +-
>  mm/madvise.c                     |   4 +-
>  mm/mapping_dirty_helpers.c       |   2 +-
>  mm/memfd.c                       |   8 +-
>  mm/memory.c                      |   4 +-
>  mm/mmap.c                        |  16 +-
>  mm/mprotect.c                    |   8 +-
>  mm/mremap.c                      |   2 +-
>  mm/nommu.c                       |  12 +-
>  mm/rmap.c                        |   4 +-
>  mm/shmem.c                       |   6 +-
>  mm/userfaultfd.c                 |  14 +-
>  mm/vma.c                         |  78 ++++-----
>  mm/vma.h                         |  16 +-
>  mm/vmscan.c                      |   4 +-
>  tools/testing/vma/vma.c          | 266 +++++++++++++++----------------
>  tools/testing/vma/vma_internal.h |   8 +-
>  38 files changed, 269 insertions(+), 269 deletions(-)
>

Acked-by: Zi Yan <ziy@nvidia.com>


--
Best Regards,
Yan, Zi

