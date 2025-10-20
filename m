Return-Path: <linux-fsdevel+bounces-64709-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id ABE71BF1BED
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Oct 2025 16:11:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 81C1D4F68EF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Oct 2025 14:08:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D3B0C2FB;
	Mon, 20 Oct 2025 14:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="aKNns40I"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011036.outbound.protection.outlook.com [40.93.194.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0A1C31986F;
	Mon, 20 Oct 2025 14:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760969293; cv=fail; b=UnaiMMsY8uqnN1Gnem2KBCKVaiGpmRfj5l8oI4rFnFW+MJysrMWfe9OJ9Ka1+KecAsw3RqzYA2u32M8Cz7nqNdgL/sW+lFeEFV1QRPEN60keBnWH0Z6YOhy9Khq8oAWPdpbPdOGpGoJj8siPdeBz1nRYDBqnmRSK2IV/qpShO4Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760969293; c=relaxed/simple;
	bh=bOlRKr1YV1vk1xySFrv1vHuTjhKNoGOo3N5hrS3+wl4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=nUk/q8WjIMrJPUqxvAvxXRPJ4vjvJ/WWUckMNL4lCh4OD//q99O2xlRH3U6p6HMMl2npcusmlx2xG9oQhr08+5OLG3i3ewdLQiI00py2EAyLG7+PSG7uVAQu9avjsXQGww/W75/gfLCOpuxRpJnaTxGlHaJde8ChcxRO0VhaCqM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=aKNns40I; arc=fail smtp.client-ip=40.93.194.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y82TM+Uzi8aBznkHMFFC0EOhxIl7xrqeOnEWIlUvAg2x/3qBUrdRkoxsO60BKrl5aMGxzNGwF5CzjQt1TR4I+3n7FS7ZdCCIYjhjiJMd7BuGgUeKNb3tA8WQ0U1uTWhE/vR/T4WvoFcRR8ua25isMMa1ruMwf7v7/GxwbYz1BjWy571OxwMjJhnAaNywKxcZw/SE38wklw+NBDmoIl+ATRNx6jiHmYP8IlUnRqOuAz6CGYeSryNFN+Mxxtb9Ayil76lnpAcei6zqTxHAI0vf+j9CiIFGAHcVwo3Jx2a24cx1BKpHJ5d+RjshvVIRtwbVSdLeIxrv5bzI3rkx/SIMMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ffE3S7eV2NquZuNccTOETeouskHDSr644Vrofs7AGE8=;
 b=I7ZbYVJKg9oiGJrjYFtu70VwMrRt2sLZPYUlgf+QCJEK3LpA6eVYRpcQbEMZkzB5nlejMw2ye0x3wcsh7Nisc024yduYDNjj2D+jSSGy1satIOJGJ0Klk8P1A2z0vhebWzCqIh6ddl2NBh40rclXfOgB+smgFY4GBMiVgHmvyJEVhym2P/rOZZF2P2kSC9iDQcabBZfjcNv7EcU6SdOUO/3PW1/V2eY6BlntCNXWIrGEwTX/aG8Kq8e6L0crzeHcNp5SrJl5NllWaA6cbMAm8IZJJkWd+R0CQyqBe752o5TEBB6wiBuTPKoNTurutiJp1/D/e2JrLT7NWbGHmNwpwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ffE3S7eV2NquZuNccTOETeouskHDSr644Vrofs7AGE8=;
 b=aKNns40IbjNcK2iIfuJKgt0IpngNmcBDVKtUoQ+rnbDtP0bgv7wNw6Z/dcd9Z9JrqhrF4b6nxCXkM28jR8ucwE7qsZIIVFQZZudhi3BQ3tWXMuTSEPGqpytE1cijZotiHyAndFZ2I2irRUWznnVC81hQlDfILuqV/2T/8OT1tU70PWkG6ftoCGV+w1L445ATb1RYxyQbDKr/Ldy1aAuG/qPQIfeu3dFUD6ep5/7SQqwAGZ85E8TB3oT/fly7zWn1nhCFz1M6c6fUnz9TeRMwtVflQXLDa40jJBdOEcp3O5CnCm3qIoo0k6JmZnvL9VoVPMiJSGB3swQ4JxMOCozkOg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3613.namprd12.prod.outlook.com (2603:10b6:208:c1::17)
 by CH3PR12MB9315.namprd12.prod.outlook.com (2603:10b6:610:1cf::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.16; Mon, 20 Oct
 2025 14:07:58 +0000
Received: from MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b]) by MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b%4]) with mapi id 15.20.9228.015; Mon, 20 Oct 2025
 14:07:58 +0000
Date: Mon, 20 Oct 2025 11:07:56 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Matthew Wilcox <willy@infradead.org>, Guo Ren <guoren@kernel.org>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	"David S . Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Dan Williams <dan.j.williams@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Dave Jiang <dave.jiang@intel.com>, Nicolas Pitre <nico@fluxnic.net>,
	Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>,
	David Hildenbrand <david@redhat.com>,
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
	Baoquan He <bhe@redhat.com>, Vivek Goyal <vgoyal@redhat.com>,
	Dave Young <dyoung@redhat.com>, Tony Luck <tony.luck@intel.com>,
	Reinette Chatre <reinette.chatre@intel.com>,
	Dave Martin <Dave.Martin@arm.com>,
	James Morse <james.morse@arm.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>, Hugh Dickins <hughd@google.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Uladzislau Rezki <urezki@gmail.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-csky@vger.kernel.org,
	linux-mips@vger.kernel.org, linux-s390@vger.kernel.org,
	sparclinux@vger.kernel.org, nvdimm@lists.linux.dev,
	linux-cxl@vger.kernel.org, linux-mm@kvack.org,
	ntfs3@lists.linux.dev, kexec@lists.infradead.org,
	kasan-dev@googlegroups.com, iommu@lists.linux.dev,
	Kevin Tian <kevin.tian@intel.com>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Sumanth Korikkar <sumanthk@linux.ibm.com>
Subject: Re: [PATCH v5 03/15] mm/vma: remove unused function, make internal
 functions static
Message-ID: <20251020140756.GQ316284@nvidia.com>
References: <cover.1760959441.git.lorenzo.stoakes@oracle.com>
 <f2ab9ea051225a02e6d1d45a7608f4e149220117.1760959442.git.lorenzo.stoakes@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f2ab9ea051225a02e6d1d45a7608f4e149220117.1760959442.git.lorenzo.stoakes@oracle.com>
X-ClientProxiedBy: SN7PR04CA0017.namprd04.prod.outlook.com
 (2603:10b6:806:f2::22) To MN2PR12MB3613.namprd12.prod.outlook.com
 (2603:10b6:208:c1::17)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB3613:EE_|CH3PR12MB9315:EE_
X-MS-Office365-Filtering-Correlation-Id: aee44070-5705-4b56-1a43-08de0fe21265
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?I1G7H3QzzTzRzakzerfbdfgT6dxNneIlP8beVwcJEnU19TCF8+2rG/r3nxIO?=
 =?us-ascii?Q?JFe884TehnJAu9dFWXdna0sv1JW6jHJR1eOnVE7QK4lNodB8W84hmWdOJBVv?=
 =?us-ascii?Q?lNARyHXdu7FBWdy6hn/JY0JMF6FrfYjs7fJjkYGNElo3wsg/H8+sGWZPb5mm?=
 =?us-ascii?Q?r7opXUia8pSM3Z0fvIf13d3ksZwNwtvu68ucOzvAJqJTvuWBSzBxsUtQvjav?=
 =?us-ascii?Q?a060oRNAp5+q+hYMPXsCCHouUd4bFoxNocu7lAlfKEc42ZAgqy+linV26YyK?=
 =?us-ascii?Q?02Dhntuk4p7eVCeVJzoHYrXWwWbnn8mXrFjc7Quqjz6nf6JPD+Ju8B9JLcsU?=
 =?us-ascii?Q?3jy4f/8Iw0Ug+7y2nW0jrf5ZWKs0CfMDBe5wTc/PTg1ueSNkbofeZT1sqQaF?=
 =?us-ascii?Q?cpvGEK4T5nfGxwUmpUSgUHo9qhxKv1XIg6FrR29j6Vh8PHtPfAG54wG3DaiK?=
 =?us-ascii?Q?A+99q0qHDcEXfPT/n4Bv6gxNCJdZ9hGR+DA71JGsAS/HBGprHVKTMlByPPKR?=
 =?us-ascii?Q?fGcWN9Hln/vYI4b+OW4/Zg/1/fNWxPJz/CbNPgvt7lx8yvJo3p+TpknYuE+/?=
 =?us-ascii?Q?v/MKFnU9R2fYyafrpnonjBZc9K7NfQbmnHeVUXfGQCA2VlnpCg1kL06hEgDC?=
 =?us-ascii?Q?RVvRxQ77+2sGQvHX3JKp7joJepIe9OElGQ5jinD0OkRVefwUjTgw4j9X1o7p?=
 =?us-ascii?Q?IaAXOZRPa6CKQ9Gf7m9rFzxnrcADWnJB5ykV3xSitp/2mSa5TkYkMGKvAcUH?=
 =?us-ascii?Q?+AXvXOPxzsLEj1nu7OIkjHWg8h9ik/lBi2pZEcnS6zUYxJMoOKSDHWKUyCBr?=
 =?us-ascii?Q?fNzNC7A3DBHNUxUKBknOQxAZpUevAxZ+sDfoPTWs9lHsqP3aQ7HZThRYG0HT?=
 =?us-ascii?Q?LsI2IFPYwBv9fzM8tJqgpl0xZVmO8CkCyEff333vVhdGyXJkJ+ON7WQ4sssi?=
 =?us-ascii?Q?Crhr5ydDlk//NuIAjIApY5eNb6tcwQhYCa9Y8x8loL/388uitkenok4VD6yf?=
 =?us-ascii?Q?bcJVZBuCug/+3GwVs4/xJg9nXhDHXo+9PonetSVnB2OqHTFT+4O+AMoNy9ss?=
 =?us-ascii?Q?Nmfy8oxqrLaPJwp5U4pLHfuEOux4SNICMHpoY41CkjIm9ZeOBRxhDwtY0ZCD?=
 =?us-ascii?Q?rRAMw/9MflRkf1IgjiTHFxG23LiWZN6SqZ9tpxJ1WGmxLIphRlltWm1r8ytK?=
 =?us-ascii?Q?N7mGQukZbIEQVQluRqskOEw5GrwMYHx/54jQHsvqmX0TUV/yzp18c/xTS4J6?=
 =?us-ascii?Q?yfsc6VKFxhwN125UYp1+44jG2a6K4KRSuxF3wgcajM+tTK9AYSvutShzqVdX?=
 =?us-ascii?Q?xz3ypxgiJIbaJn3t0Th+8h7wqG2mlu2ApZlvAMeTpqbF3AVtfCv8QzalsaCK?=
 =?us-ascii?Q?6CCZR6vWgpkmsMlJTVmkE63KoCpdl2PvgApqZoMOkMDbpY7agPFDErYg04Ko?=
 =?us-ascii?Q?UwIVP48N/npOcg5fYkzRIW3sdRf6dmU6?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3613.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZibO+wB07mSnxnaDI/VyA4JQKAtB3rtb08Rw8wA2AGFu9nbTNo2B+0L1mO6a?=
 =?us-ascii?Q?xv47wl+o2jXscUBaq4Rad36qEA/QPSMu14lSDnJnuSdi4sD9hvNaA23Ig11I?=
 =?us-ascii?Q?6ArApgCvsOzZ+UtGwGsY4rwKKA6MnEW/rWE+x4DtBe6ELKh62S1NJ0iHtRge?=
 =?us-ascii?Q?Vpn09ljeCX8OIJsUoeXhcozEzd2jqCivWz8CqJGFQEjMgtmNBqagOJ3oFcQ2?=
 =?us-ascii?Q?NwppFFb2EXHQqxwdoyQXx+5aKVNmZfJ0N7tSOWRZI2p3TPesI+HHYyvdJjXy?=
 =?us-ascii?Q?bMVYYvhlJsmpf0lDWL7IiDL801MX3zS46jc0IsN14C52m5kp8Z7DgQhpVVnK?=
 =?us-ascii?Q?fOLgrTzTP5Ngo/OPZERQ6lsgaOSNqjbwf6uDu38Bq+xV+dA0FKVusC/pK8nO?=
 =?us-ascii?Q?MF7fJvbgfSjqULcNovil71Q1yI3uap+1B0RbRkLN21zaNAiOC86MsYNzeDV9?=
 =?us-ascii?Q?+js2nVZD/tQhoHn47HGn1EVZPxVpeiBt7jtja46FLwDwYlyt+XFzbd/0sk4p?=
 =?us-ascii?Q?31I25fDjgSRgdqGrBEecs983vbYePfbUTv+7N7ykHg8ImNsQuCFoMs0D/m5c?=
 =?us-ascii?Q?QDd/Z7AQ1SrqhbTLm1QATxGMKHHmcXiDIstrRV+fX9bII/rzWPrfIchGWa/i?=
 =?us-ascii?Q?hosLyAs+xZyDqOP50QXmf2HN8Svirhw1AC3FwxwddCfhZnP2sNIlBsGCmXso?=
 =?us-ascii?Q?SY43EmMxs1aRb6sCgJ4D6TMbQw/90mlGmwmpO1r6BS7utf7u7fNmlG94hp2E?=
 =?us-ascii?Q?mwx2X5HJ+VyiZycbnsBEofQNcGySYXdbu0JZN86ZDQ0WDdGdN0BDzl/FSnAO?=
 =?us-ascii?Q?EMe8IeI8P0qSCJj5okFAsJZyxUHaOeyBZ5JrAr1+sM6BgAsKX//HMxNpZcs2?=
 =?us-ascii?Q?biWNnHeMKwcyefnxP+O38kivdpDeaoHB6ocxM8H73C3LXO3FalnRP996BjuH?=
 =?us-ascii?Q?km3s0s6YLKDsNAjmQI4dzdjxQUty18+QMXLc3kWYZBxbUxk4XmFizamIfYKV?=
 =?us-ascii?Q?8m6mqSAaNYwlmyB37+Yr/B6GmjCKjcKVxyOdjtu6CyfwJ5yiUcSFnNrUWlwD?=
 =?us-ascii?Q?Fhn0MN+jSH4oM5W+pO5BnkrR4WM/nfGaXjtx4NIrqk+wdHoTYMB8t9QPadEY?=
 =?us-ascii?Q?c2pq8eLa9eKccx4tJgeVBBtnK8q+cqahlI6yrcVDfqZFycvOxjbwUQTQX5gG?=
 =?us-ascii?Q?lkHz6Oz0T1yMOEiQ5YRZcItllGMppLnAtKVKinhp3gAVeVMf5b0DwGq6rJhw?=
 =?us-ascii?Q?BL0uff0wAo+FuBj12k1goT97UDJsAHhGIa8EP6FjJ5iWovMXZwdGreV04F7k?=
 =?us-ascii?Q?nlZo0wqZtc5hskCrdg9zjKJ/wMNzcTkYNRwny7oIlB7Qvg8oEz8/EZIJC3TJ?=
 =?us-ascii?Q?9ca9NPT3TC32MdPiaHmy9CqGjqMLVSyMtJUZodxlRdQk/W4zLweHEr4bILyh?=
 =?us-ascii?Q?fSrYtPjxF5pglEPWeGc0Vl6cLJZRps0BX3b5i6Mzegr1Mx6Ccskp2AeZUNQI?=
 =?us-ascii?Q?Fp1meKrc9ehgCP7ZcVP8oIfWoJZ/zNI4/+/h0Gzqb19OkmPRHyo1BkWsom1L?=
 =?us-ascii?Q?L4YphHUdMz5Q0KmStgjOyRGN6VWGGboHeKg/xwx7?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aee44070-5705-4b56-1a43-08de0fe21265
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3613.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2025 14:07:58.8192
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vdPFpJwY6uqxYCYlmIkkyEChF0VLLh2rXtevOJUqGJmg8B/PbPJTRjlxcMJR1yVt
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9315

On Mon, Oct 20, 2025 at 01:11:20PM +0100, Lorenzo Stoakes wrote:
> unlink_file_vma() is not used by anything, so remove it.
> 
> vma_link() and vma_link_file() are only used within mm/vma.c, so make them
> static.
> 
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> ---
>  mm/vma.c | 21 ++-------------------
>  mm/vma.h |  6 ------
>  2 files changed, 2 insertions(+), 25 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason

