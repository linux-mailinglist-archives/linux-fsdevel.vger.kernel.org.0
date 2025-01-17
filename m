Return-Path: <linux-fsdevel+bounces-39457-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7674A1478D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Jan 2025 02:28:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D8BF3A2E02
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Jan 2025 01:28:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD3374D8CB;
	Fri, 17 Jan 2025 01:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Qt32DNzx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2044.outbound.protection.outlook.com [40.107.220.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A9128C11;
	Fri, 17 Jan 2025 01:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737077314; cv=fail; b=WFLMck2PHwleYMOLxVHvlYlXHN7/ddis/yARBVbCyaRXEmu2AZQ7U1i30yWRreCYT2/E3O4IHM6D9fP5aojkS2kjlUxEMkjrBNA/1Fiv/QFh1+aRJ9DMEfHO5eJDrmFBMICsR50a1UBOCiHMLlQNAGXCqhawifAymtylTy0aP10=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737077314; c=relaxed/simple;
	bh=U+30oC+5u0jCMap3lV0o0Bml4j+NhqCicZIkAjH128U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=IQkexHazgbIMPW3uvnuSJuCPTFcBLVY6RLw1aUGiZ5mK6U+rr3bcK8HDXCcPRLHMe2HHUKndk//c+lw3Cnx0zuU8z9ew7gkxCB6hY3fQNn2KS0XWpF2YsdVT5H44HBiyWHrgcZ4Gb+C0A1JPuGcHd7mcHzurp2d1bOUzXyo5j4E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Qt32DNzx; arc=fail smtp.client-ip=40.107.220.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wL2gVHiRNgR/N8cqelv8qOQv3bfqzsOGoD+wt0K5uJJmTsnIcy/VvJm5RUxiNP/OQZMteIjUklb5CKHD1GQGX6Mq4nuFNUzkkaozx3MJUIjsTpendjkXqiFSf7/OXYJ5QdZCzmsEmCnWLxcdedgu9acIpvJBQDk7p2ltC5cP1lTral8aSo5XJ7rbEQtacebDqJpaVPIYD3XKKlUTFq5baDn/s/jQJ0X/WJMkC2tjzQ6N3X9MrXSP8JfOpJjeFlfE23RzUQs8OaTWigQPxIeRtc5Ry73NCGxu0XZFfGUN9dVqn90yNtZpAbap3dZx7x6nvD25zlaR1EEKbudhZP3bgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VsHTPUwwBH9IlsLVs8S1LgQjHlaiMATljTdmqBjc7cM=;
 b=hujRJ8U4x6ISd0SkszQ23yPgX28Y/4QeA7GYtwFyxsG1vZWoODW5sjBxGS4BZxRGrKrwVeS0so3mWbF/cCb2sYqu2Bu7tMCeVPGzqNh4ce4FGNOYzbJMJI3JTV380MBqXFPvUYGIq3IV8ShGRLBxraDXU+H00K2/H0Cuh6y6EBuck7gsIaSxpEBaktYsI2xf3DW6dPbGwHowz1fBbEWPqnaSmDjAJWqDthUwrY7pHaj6owmsqmfb/KeJdDctXPiSA5H6hviZH23hK3UN74kPdwfuhY35n7WtLhp1tri1ksMqbCFeti2+vAsfkfLtDRbG96hItBTosvw3nFyKIsoMfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VsHTPUwwBH9IlsLVs8S1LgQjHlaiMATljTdmqBjc7cM=;
 b=Qt32DNzxGCIHGtP6WYlW0zuQhwEyRovsQ8u+sdU9TkpD2KOeQkAi1Sp0Ahs9HnrFOMM/5mmbuwCK6gl9336p+F9T+BStw2KccLGq9BMukX7ghcsicxu3sDp8cx+JWdNzKm+tNuddDN89D7q3kzdUjVZ3XO+X5raezZVY7gV/BsE/Zpg2vfyewG/6J4dhBH7t2myWWNpAQEMktD1YCS6INpXOr2bgPfg1oIhiXx5a2NWstCPoZA5VKCYNa+OidOyDu90oUhws3RZm8F+Kt9grH9jht0RcmBCZXaiNoNZqxR/+DqXplmoXm3NKhnWeNY+N9hpPW1w+8XepyemNsmU6mg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6) by
 MW3PR12MB4489.namprd12.prod.outlook.com (2603:10b6:303:5e::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8356.16; Fri, 17 Jan 2025 01:28:29 +0000
Received: from DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe]) by DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe%7]) with mapi id 15.20.8356.010; Fri, 17 Jan 2025
 01:28:29 +0000
Date: Fri, 17 Jan 2025 12:28:25 +1100
From: Alistair Popple <apopple@nvidia.com>
To: David Hildenbrand <david@redhat.com>
Cc: Dan Williams <dan.j.williams@intel.com>, akpm@linux-foundation.org, 
	linux-mm@kvack.org, alison.schofield@intel.com, lina@asahilina.net, 
	zhang.lyra@gmail.com, gerald.schaefer@linux.ibm.com, vishal.l.verma@intel.com, 
	dave.jiang@intel.com, logang@deltatee.com, bhelgaas@google.com, jack@suse.cz, 
	jgg@ziepe.ca, catalin.marinas@arm.com, will@kernel.org, mpe@ellerman.id.au, 
	npiggin@gmail.com, dave.hansen@linux.intel.com, ira.weiny@intel.com, 
	willy@infradead.org, djwong@kernel.org, tytso@mit.edu, linmiaohe@huawei.com, 
	peterx@redhat.com, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, nvdimm@lists.linux.dev, 
	linux-cxl@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org, 
	linux-xfs@vger.kernel.org, jhubbard@nvidia.com, hch@lst.de, david@fromorbit.com, 
	chenhuacai@kernel.org, kernel@xen0n.name, loongarch@lists.linux.dev
Subject: Re: [PATCH v6 19/26] proc/task_mmu: Mark devdax and fsdax pages as
 always unpinned
Message-ID: <wojgk4ecfertc6zrb7diptbwmzruno72dq5c3xhl5ec4e2idl6@vkvhdkqr6hvi>
References: <cover.11189864684e31260d1408779fac9db80122047b.1736488799.git-series.apopple@nvidia.com>
 <d7a6c9822ddc945daaf4f9db34d3f2b1c0454447.1736488799.git-series.apopple@nvidia.com>
 <6785cbb7125bf_20fa29418@dwillia2-xfh.jf.intel.com.notmuch>
 <86efded9-c1d9-4efb-bf41-f67faa49bf69@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <86efded9-c1d9-4efb-bf41-f67faa49bf69@redhat.com>
X-ClientProxiedBy: SYBPR01CA0194.ausprd01.prod.outlook.com
 (2603:10c6:10:16::14) To DS0PR12MB7726.namprd12.prod.outlook.com
 (2603:10b6:8:130::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7726:EE_|MW3PR12MB4489:EE_
X-MS-Office365-Filtering-Correlation-Id: f15ca299-6d8b-46a4-dde0-08dd36963f4b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?oHOxNJXXFhhsxbl/av3A8k4Dz96xcVXs3xZ67M5bbF7uoUmA+9QJjd2929Sw?=
 =?us-ascii?Q?J2NJYmqEUSQGFXWUoq7v2aG9dgpmOJXB5MVoZDFMsdmn11KI9l5RXUh0T/Nb?=
 =?us-ascii?Q?mKAXYqUe6foLY/g0qoF2aPmPiRM8kE3i4fFBMJWrPwhbwfm93HFCBW7d8LFY?=
 =?us-ascii?Q?jrmGNnJDa9f1Z7SwbGh4nzzP8DUdIupj6xegqbyQZak5ZFc1B/qjKApfgKa/?=
 =?us-ascii?Q?Yl3ygR2GauIIl59CuR085EsWjE+CdFKyOD8CArYWbZTbPx8yS83SfY5DYGNw?=
 =?us-ascii?Q?RuQ+1O2gVM2Kyo6xo+mLdVULplw6WgohK1mxyUPF4+8WpBCUJ/RCHi6G8ppX?=
 =?us-ascii?Q?rHJjY3kkgWAXiGd6gjoz0DbphxL83n68psEPmmMS66ha02BFsMyAtCnmDKDG?=
 =?us-ascii?Q?1Vcv0RA7TacNuMU5e8KmvcG3T5xftHvLSUm8bAa0RyzG02gPBRpMr5NyGm/o?=
 =?us-ascii?Q?+1rZU8CRd0wenExCJAyPYDSS5Opu1VYHOouVsd/g3q4eqq0TnjTAQUYLrRPW?=
 =?us-ascii?Q?eV/2IPxLHvXYPnM/izQx3L8oop1R+SO4O/xe0V1uLtow25J3VStGNOuybm8S?=
 =?us-ascii?Q?g78YvvtEBC5IJLfYLISGoCg0mU56y7IEdwz9QN2neORG3Nyn7ndQHqoyluRk?=
 =?us-ascii?Q?vT7YWw/CpEOkbYRZoFnXtor6wAreF4HFLlFb0CHl3/KLjaCq3BDqMttYkxAt?=
 =?us-ascii?Q?CmQH/sjivqH8pNM+GJqETcSI23Xi3R4HupPU18JgYbjju0/4VHeZpn6rRaIs?=
 =?us-ascii?Q?donJdirfTv2cJBc1V0Ye+/mdhst9PVfCVH3a4L2zRc6UeUFwY6zYS6injhED?=
 =?us-ascii?Q?G76aIGqiBz4I/b4J2NxV3JreYYcNA6fdlHz6XpBmjByUbe9DFJFivSmi5zbF?=
 =?us-ascii?Q?Ufp8QA/IcIuPP5utgt4xhLwRffjvK7HPon99pP5uyfVrZOQCtN+i+ToJ8sEn?=
 =?us-ascii?Q?s/J3MCh690PieI2PyPy9MSYWmNIU4L1fKcSg61+lDa8VUqBO+LiKJyMVVGGI?=
 =?us-ascii?Q?OlzrVI1glxo+jQJK9x6wtajFxzNpf9MQMHmw1mbcrqI/BYEXzEVGSaAmYOF9?=
 =?us-ascii?Q?yTHccIl/H+F7qvJjAmpDZrYtDWzRmCWTaSi2DpCp9PjCH7jiZx4ZqlaJtXft?=
 =?us-ascii?Q?coVUf/T+rvGn+IWZ5P4TR4W2ozTUo4LaIuym6GZDbICCl+BL7wzE85CqfdJ7?=
 =?us-ascii?Q?JuI08s1Uzx1ADjTrJ74PdfNlSv21ZPwWfIfYb83pKp35AHjtCeTZf0wkh+M/?=
 =?us-ascii?Q?5lsNxTMZCASZhA5BHQ4QLCTA4Rj+XFN2Yop2JbMMYLSgyXZwY5fFA5RJl/pV?=
 =?us-ascii?Q?ERfOhD5J7V5lp7uk0daO2gEzOqkRxYEpLtTp7D57suxDzMHS+I0Mur4vmSyn?=
 =?us-ascii?Q?DMaqmUwNGp2WFY+wUDVD5sQVJaPV?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7726.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4HrK7AlAa6wIUVseKybwYgmcGZETrDy20LG6MbQu6MdePO9x1GlPe7jwzimD?=
 =?us-ascii?Q?2zZi3ct+raverXzZ90LLf+BQ2LX3BZgjo/JWw5bwUaWteAg4z6d7g8TV37EW?=
 =?us-ascii?Q?DmUnGgWDcKz4dX3JfVAlTN25265rmW2Yhi8Kb9xA9buSwnUINzjmCA7STaSg?=
 =?us-ascii?Q?L4MWr81BXYFWMeKTEI/z0ri5TBJj2VdNNUnooIrtSL7cd4CcxuduL95MzFMz?=
 =?us-ascii?Q?0CNMBMS5gQOVY/pCx4mYQJY/zTjG0/R0MFan9ys53fWptxtQEHVM37o6t5l8?=
 =?us-ascii?Q?ae2Xgo7fKEy0zoCSOKStkGYtA7jnNtY5eoyftxRqU4yKWwD7AUIUljNFYrng?=
 =?us-ascii?Q?QGyF7mdpE2Su5pQjMoPP4JfD2d2I/tCgcwee6WoEoZZA1OKHxggm05jZnVzX?=
 =?us-ascii?Q?MvficE9b/P3FrcXkjstvOuwFK3G6HuUEhG8kORgNWSF+vJ7+Qod49DNlF6pl?=
 =?us-ascii?Q?6LubGZXM9Qw0KQibeuiDDzdvl0W9kDnVqlIxqPLUwivJ4dGjI2lHsO7RkH3W?=
 =?us-ascii?Q?7mKDhrfEfFPHt9hGms2ObgzjauBezRK+3667ZsmB4USU/SpwJpf5Y2BKMOkJ?=
 =?us-ascii?Q?UIljDgbjXJtQU1DBGDXWfF5tDVV3DBp5UpngqGc8Fy0jSsuVEUizxmZV0qtv?=
 =?us-ascii?Q?s5SzxzVGvgbKiRiZulA9A95Sd8CN2PxEAlQIFJdMBeDhy0kBrBpw/RoNhFup?=
 =?us-ascii?Q?kuHF8G3Em/C5v8qYn+XlrQcQ6XBWKCSAOYj7YvNLhJPHWaGw/DbuZFX7yuMI?=
 =?us-ascii?Q?dl6o+VJ4RlkV8nnaGxLjOFkHpepfatxkB266YrAXKGUHxSM6GsJZIQNRcX7h?=
 =?us-ascii?Q?WCsivsRdNhOXJ9Sq0PU8RpS/8UWd2pi81zq61GF4AqXBfNUmVCONow3eohKv?=
 =?us-ascii?Q?Lb3Q7ql+CFXGFvQKpYfz571pSSPZ+rtHEfTGd9Szzv53z8ULqxT+V4Y7+q21?=
 =?us-ascii?Q?JRG4fROl1cqdW7kV3+685DIj88Cu4Z2Y55K7wfPZZdmrHjxaHJU0p0tXSK5L?=
 =?us-ascii?Q?9c4SgYwIfWsQyI5mKmp2L+8N9rOhSL2awbP0iX3yw4sXgr4u9nBA24frA0ks?=
 =?us-ascii?Q?GHgI+mkroMxzw2xjgfPwJLeAcy8GyBkCkDEkUZgE1tY2vGSdNQJYbp+VX5V8?=
 =?us-ascii?Q?9vqlORxnvTcrMksii+hJMZkNXDQjDuINy7RrFboQ6kSdFpCNS8N1PY6CFJ+N?=
 =?us-ascii?Q?zaTqkerppN4u6I3ILMInczXkSw5Z0Mkpa1YQ1UYGTJlDrPa4sWlWpMudJIlv?=
 =?us-ascii?Q?p6bGc6Ye1czivXoO/CGnu7LrpJ+2JhGC4ZUFhUzteMLIU0UMeVLXk3ILx1/b?=
 =?us-ascii?Q?C2v4AFBqvfoMT+bb8YlRJAyV4j8cJ0qkzbRoN49wmwgCVh4l4ZHKSuyvZ23S?=
 =?us-ascii?Q?mwJYc7qk0019KxsWJ9pQvlTyIy5XT34DplEsDEXAXFJJWn1KGIq0sFpy25JR?=
 =?us-ascii?Q?TSsaNyBMpwzdr24s+//Vkp8Zdsgwzu40yeqZE6jkcs+ew/lsoc8/82wZANfL?=
 =?us-ascii?Q?Z3cel+egI908dyZ6v1c5PynC9ceuwDnTHlHNVyeN8kN/YPEieDKiLZ7sJHuV?=
 =?us-ascii?Q?E8P4mF/IKJ+QsGus8E/oore78AXwYyVSMBKcrNkz?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f15ca299-6d8b-46a4-dde0-08dd36963f4b
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7726.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2025 01:28:29.2649
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aSo5l0Mf9nttmlAaVitgmWssd5uXTYQwGahXVMZMewVAMShAj5t9rCPiwmGT/E6quexpOmQyKMK3it9HGs2P+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4489

On Tue, Jan 14, 2025 at 05:45:46PM +0100, David Hildenbrand wrote:
> On 14.01.25 03:28, Dan Williams wrote:
> > Alistair Popple wrote:
> > > The procfs mmu files such as smaps and pagemap currently ignore devdax and
> > > fsdax pages because these pages are considered special. A future change
> > > will start treating these as normal pages, meaning they can be exposed via
> > > smaps and pagemap.
> > > 
> > > The only difference is that devdax and fsdax pages can never be pinned for
> > > DMA via FOLL_LONGTERM, so add an explicit check in pte_is_pinned() to
> > > reflect that.
> > 
> > I don't understand this patch.
> 
> 
> This whole pte_is_pinned() should likely be ripped out (and I have a patch
> here to do that for a long time).

Agreed.
 
> But that's a different discussion.
> 
> > 
> > pin_user_pages() is also used for Direct-I/O page pinning, so the
> > comment about FOLL_LONGTERM is wrong, and I otherwise do not understand
> > what goes wrong if the only pte_is_pinned() user correctly detects the
> > pin state?
> 
> Yes, this patch should likely just be dropped.

Yeah, I think I was just being overly cautious about the change to
vm_normal_page(). Agree this can be dropped. Looking at task_mmu.c there is one
other user of vm_normal_page() - clear_refs_pte_range().

We will start clearing access/referenced bits on DAX PTEs there. But I think
that's actually the right thing to do given we do currently clear them for PMD
mapped DAX pages.

> Even if folio_maybe_dma_pinned() == true because of "false positives", it
> will behave just like other order-0 pages with false positives, and only
> affect soft-dirty tracking ... which nobody should be caring about here at
> all.
> 
> We would always detect the PTE as soft-dirty because we we never
> 	pte_wrprotect(old_pte)
> 
> Yes, nobody should care.
> 
> -- 
> Cheers,
> 
> David / dhildenb
> 

