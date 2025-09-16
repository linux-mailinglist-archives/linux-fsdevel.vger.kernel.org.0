Return-Path: <linux-fsdevel+bounces-61815-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05DFDB5A02E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 20:09:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4B7658179F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 18:09:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 359A02D2383;
	Tue, 16 Sep 2025 18:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="XcLrphLJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011023.outbound.protection.outlook.com [52.101.62.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 000B928505C;
	Tue, 16 Sep 2025 18:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758046148; cv=fail; b=Jm79sf4XXEoad+GlNnhlGtY9kp0y/u/Yw1m40ZcbdykuYWWGDKepXq7s+xyU9lvU4Yim/JnkHNRlJ+/3vxYNcL29M/z6wgODnpJ2406ZySIq55eHBe6BBNHcqPyowjAN4zVkrEd+knR7uLOEqOAu30uX38NiuYBFPqUw8W11mII=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758046148; c=relaxed/simple;
	bh=QfMJq6VRRfI25wVvR96+tsUMGivGCPnReAwB4nQW7jU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=S1pRpsZFZvpjuDMptIlUYOTyJ33TkcdB4Opv7JUZoxUAOUHfCgD0+RXNl35z/OJAXu7o1tkPYWv1f6b8hm9nkxWSAFoRGoimAZ9w1g8dZGown0Tv7MlIzA+pDd5mC/cflScQiHVvJP+Nwoyy8ZrgP7xHPgvrVE2ypsw5zR0/HqU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=XcLrphLJ; arc=fail smtp.client-ip=52.101.62.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tflhO0OiPrmJ8aMsBbcPA0WTkLVCrmPIzg70jmrggAOc7ixsXN1H79Zby6C6caajXXxydrZUwFsi2G3ZlbYT2/fCcdxuzJlqN/9Ar09pLlGBAWR4xflig4AWlVj9nn8B3c3wakU6M7/IczQB4DQrYxxoMn+DqENUQRix1iAUyMS87zA0LhnZJlXTiBM654Xme5WADjG10jVtDdfecsTdK/lGfc4syQMMz+GNTiLwk3wdOVKDnMQ1BEczAa+0ZGdn3ZWHdC/KudPQXkv/EvpcTgKQO1t5CAH0N7dCz43z0ndxRjLXtYBnluFuY6cASubpXf23GTVVlSyEhYxO+7BXWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eJbs56PiGkpOK5+9sKNM0bbDf5X9UPIzyxQBTUs+5vQ=;
 b=nemgzA1Il3kTAcy2Vcd7NRN3eUxlzamFAdNOh4MyFQ7IaMNirETb3Bp8CKCDA5ywv2je/7pcmR5caoKDQWpustMnK/9gRKQp/xnZUG0kTnLk7MiqFK/Ab7cMkUTB+hknku0SZL4RrZBVH6AYktqTQ77fHwWcmx2dxNEumd8awlublT8K94xga0BPLZlWaOjr+yqilz7qSGhm6woH0cKtmv3wyOk+BclfNilwvzvfLrxKtHmhRExlhHSEI657goo0o0hpYJljRFjnw+wzGCztQgTTyvief1TeoRbxWiGNc6ztsysDG7MgmY6yBjQrcgZuoCyXW3a3gwoW+ZzdW8ofXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eJbs56PiGkpOK5+9sKNM0bbDf5X9UPIzyxQBTUs+5vQ=;
 b=XcLrphLJvoJqU3u99yzvV6gYUw37wEDxumTEWB4J4xqaj6nJwxWd/Gzx2kWelpyVjVuosmgTzJgpDrrT+hcNuGDPyzdoWqwXHDN1Odt/Yb8EbutaL/2JfiG1MqKRMSH3XPwtvbUPNXE2PAbooOfUD6Ur9QFQs6Iaj3NA8DGQQqWT7MYSATAFrsw6djG8jaSBR0KWnR97z2zDyD+ixAuIV/fArxsaZnITb/MyF1/zkCREwF8rK4BWnSOFyTLzLCEdHcNHCFtUhqOp04mju50NO6qeAQTGTvp5ybAEvkv2pKYdk40WO6HnyXx840JelwZRLOW0Br7l8PyKTZUXzqccHA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH7PR12MB5757.namprd12.prod.outlook.com (2603:10b6:510:1d0::13)
 by CY5PR12MB6084.namprd12.prod.outlook.com (2603:10b6:930:28::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.22; Tue, 16 Sep
 2025 18:08:56 +0000
Received: from PH7PR12MB5757.namprd12.prod.outlook.com
 ([fe80::f012:300c:6bf4:7632]) by PH7PR12MB5757.namprd12.prod.outlook.com
 ([fe80::f012:300c:6bf4:7632%2]) with mapi id 15.20.9115.022; Tue, 16 Sep 2025
 18:08:56 +0000
Date: Tue, 16 Sep 2025 15:08:54 -0300
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
	Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH v3 08/13] mm: add ability to take further action in
 vm_area_desc
Message-ID: <20250916180854.GV1086830@nvidia.com>
References: <cover.1758031792.git.lorenzo.stoakes@oracle.com>
 <9171f81e64fcb94243703aa9a7da822b5f2ff302.1758031792.git.lorenzo.stoakes@oracle.com>
 <20250916172836.GQ1086830@nvidia.com>
 <1d78a0f4-5057-4c68-94d0-6e07cedf3ae7@lucifer.local>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1d78a0f4-5057-4c68-94d0-6e07cedf3ae7@lucifer.local>
X-ClientProxiedBy: SA9P223CA0024.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:806:26::29) To PH7PR12MB5757.namprd12.prod.outlook.com
 (2603:10b6:510:1d0::13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5757:EE_|CY5PR12MB6084:EE_
X-MS-Office365-Filtering-Correlation-Id: 9843905b-7372-4f4d-b237-08ddf54c1a6d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?zqe+j0H1PrmLyeCv47EBElzx653DxjCOGJmwCdrFPwi+DieR4O6tT3K+e2yl?=
 =?us-ascii?Q?whIJUVhK8ngLNfnGreVGUj4ZRyve5EIuBQEfMm/FXCNc78NF2HDsY+B8MRGK?=
 =?us-ascii?Q?pU5GzlmvvTFjGZ5A24d/Y8cItddSR/zHjJ20vVCbNzNQHRC9F1kr209KBgw5?=
 =?us-ascii?Q?8V5WlMU7w8cZl3UFpmkWHWh3490Wu3AC1L/ek9rpjgGot7Qox7/qDNLKr+rv?=
 =?us-ascii?Q?hZi6tcfRx77n1QpIM+laOAj0B45gHK5sgbZ232so/AOQZkGy3DYvxuvDoeW7?=
 =?us-ascii?Q?LyM42S3XRKHUIEV4QiVo5hYagbrPoEMbvFfGw2f5r3rx6Kps0K/jCeS2zHkj?=
 =?us-ascii?Q?qy3OA5oI/7PX0fiYoeo5ZA53aL3q6RWUcq8qQ7r/huwXOSaMCrWxUMcj8reV?=
 =?us-ascii?Q?9WFTe7ne0Lb71dKPjYDjoGv7ByOlEeFMGwjLs8eCohXdn9tb3LM/63XjdjY0?=
 =?us-ascii?Q?PEgnk6XYEouMgaC0j8JWJd9dOYf5XRxMBFmcIPw3e3JFGC5dkEIeLa30tH71?=
 =?us-ascii?Q?b9HffoQdA2qucrE/JgFSbw+0hgfx3FG32vaTu8CNMcTxY0HHS4XYMtIwXsg9?=
 =?us-ascii?Q?auYBp1gV53qIQl2lq3VKA3CCRhhfibvKQ8Fp+U5BhvYC7z0birQrFBCRJp4Z?=
 =?us-ascii?Q?AUgYNVnzsGbqStVLtvLcQAyMyFGcVstr1cfk+YqC3U1iXBtis9knEtIijVdt?=
 =?us-ascii?Q?MHsm/vD3MAR8uTQhSLJSMi4uxx2n4Y5GqmCqqA9swl8nAm/qfRbV/KzkzcOM?=
 =?us-ascii?Q?5LT4sjpudWdUMBCaJvIvfvTtZ5VivnpdCQAf1WhVSeGtMnAe1sGSQcMuI6Gr?=
 =?us-ascii?Q?qNVwz7fvNG4gvsYIu13pDU9qoESHyeirP+IiZ0A/qwstv1KaqvUYCnueyhgB?=
 =?us-ascii?Q?rVXoDMoI1fczBLs6OY0LmDBeV0XpG0NPsFr1sHcJ5gPj9mD9T8JRWMoP2c30?=
 =?us-ascii?Q?5qredbfvVNs05QToAaF1t2RzWKdAf+/5beuwG5Q75CpbuWcGY1KkHL0P9sZX?=
 =?us-ascii?Q?OHqEAxaTQWO5xUmNzxQ8KPKw53JhUo7tBtDByXjkx37SzRWbZAzkF3Tspu38?=
 =?us-ascii?Q?fnXVy/G58B1da2xcVVTlRrbHbPh/GJXAYZBsMjEa1Rv07GHHpJ5rs87kVWhm?=
 =?us-ascii?Q?fKO1bQyDnuv1rOnddPdfYzPnUWMFuliclrjd+7GHkYQxNLWdAW+WRZFOZj6J?=
 =?us-ascii?Q?goz/+d934SqE0XgRO0S2pfp/zhTFJGAjacROszevUblf2SQr7LAhbHfBbgw0?=
 =?us-ascii?Q?Xosb6DVh2N0uf02tgJtryQ/75G5hCS9LJeKXcE0zW0ZfwFikw60lb9djXegp?=
 =?us-ascii?Q?LL0xucJj1AgzHThQr72J/+pRO4OIF5SpRDAvGNzLGivYqTk5BcZMz/1hUBlj?=
 =?us-ascii?Q?+WriPK+eisSdaR2yOu3q7rAttEFvHdlSj84oC6UuYYlxcw2Yxi14M6Nqf894?=
 =?us-ascii?Q?pDeM8tONyWs=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5757.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?XZ0gQ+81uXsTH+88XZfaiYuL20GFILyHIwsfJxNPdVRiF+q21D2kIJbbsbUR?=
 =?us-ascii?Q?PzuYH1xP2EIhYuvpPXHcoWx62OpNKYNpAwjOP9K8Y+/Yd90caD/MSsIXaX6E?=
 =?us-ascii?Q?SuY6F7J+3LTFgOeYwZlhE3TKgul7wj62zJzYDZ1+hvEbyESeH2WjsVLfUdeC?=
 =?us-ascii?Q?Ab28n97axgwA0+KKDT0qCdFypXoq19ZhO6LUFCAjofgE2izjysfkE8LQA/6s?=
 =?us-ascii?Q?4B4wC7eOpt2pyhwyZnbiSrR7tFnJ/UY8v7EK209l5UP1s0Q0eBnHhG3l5gWU?=
 =?us-ascii?Q?/u9bFGiqwgXySN3AoIEOjRehCD7VWWTwC17GI/iRAut5eDfCm58CWplKy5i0?=
 =?us-ascii?Q?xyi90oh6eqsqXZQ6NCG/EDerGL1Fo4W0LywRjUMoFR9OezWdLxnA5Pt9LFxt?=
 =?us-ascii?Q?yK3d1dymFglnZKvtY1xXTBQcmXXM9gwL/GVYQkm8NOs0AVKKGcFLdpEbHqq+?=
 =?us-ascii?Q?BzwBGpI7S/9acS0l7KMZ54SwhWojPA+r7rnP/YqsovPtUfBxsB3jQaTJvzDw?=
 =?us-ascii?Q?zEATzfmgcbhQvGAjAY8wIpSeLfNYFe6Xd8yGLUl7sSkEnFDbD2AZBf/jRGne?=
 =?us-ascii?Q?m0CmZylELKwajIMRw+XJNW9OfhyhlJu+9d2LvHHuHBKoszr8d9dMKjWmn6Gr?=
 =?us-ascii?Q?GoREwWumZVtFcdptpXaj04qWpniqRs1Ux5z7zP6iFfcdbhb3g5L6ODEpkmI+?=
 =?us-ascii?Q?5iJjYzoGIxsY8uEfSb8Glj22XMnOfv2J+dwv6rpwZm8gvMVpLpO/SxD1/TTE?=
 =?us-ascii?Q?jtI5RlzwN+9cDZVNg1bMbhSgt76xfEljCdJKHc8XKvsDo9LZa6m2R1D/ZN6+?=
 =?us-ascii?Q?zn2rLC8RfeQDo5fwydVTTYYe96ka8t53P02XI7J2W0nYOsxxIajnRd8Uky3s?=
 =?us-ascii?Q?BmClM14Dq8IfK+nZiqGykT4/6rYv/2kvhX0q/SDQNAc9ewnWw7tstTnfh+KS?=
 =?us-ascii?Q?vsRhPgDnHLXhYpBhqqOnPVy8pt+cz0lisOAglGCZ414hStOuqa2Pq+Tvia3g?=
 =?us-ascii?Q?paYM6w5FzAGQh6l/Ufw0faZTk7nTHaNcOqIs3KobpNmGlQP0Ej1Bo+tTE+CC?=
 =?us-ascii?Q?/jdjhh92edF5VhOcRsPKf1fYktWhYrwfRfUJSqfhOAln/A613B5hfh/FmUSr?=
 =?us-ascii?Q?XqXNCEAjJWHnFHhysRrr0XZJHnRym+vNpw7g3n9xE6lYStRqSUP+1aLe2i6X?=
 =?us-ascii?Q?VcG791t0EeMN3ZzXJJT2X8Q+bKO5gnwFKPB4bUNRxiCQPjckcts+WKlsebfU?=
 =?us-ascii?Q?yFv3VlHMjkIvF3IrqtQNFkCAg6+6iS1O3yV/sH/r8Te+d88DRL9ZIhV8PZBb?=
 =?us-ascii?Q?YF4lRdJWaaCPeHMWz1V7IaPGh4Ch8KgWr8IRs/Tr6LtQF6Vb3R1rW3B5YADP?=
 =?us-ascii?Q?XXrfcH3LjVUDMnJxGQ9PhlcEp+8M0uHrYQfCkN7y5Nt3StVcE7XeLnqO7aWX?=
 =?us-ascii?Q?yZ2tHJnfU9mO4NXJDNcWmJwli7aZQG1ZAo625boTpcxcae0MshyRsCLgtKix?=
 =?us-ascii?Q?2nw7tMNf2tYEy3KTXiSvqE4nY7uDGZo7YdtlHX+RX8MwGlNE/m6rU+Civ/eP?=
 =?us-ascii?Q?RZkUS6rwPK95wMh9v7GvTR98YpjYY8n2xyb63StH?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9843905b-7372-4f4d-b237-08ddf54c1a6d
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5757.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2025 18:08:56.7902
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jD+g3iGDATEgOBQQcWfdrD3y7mCza8LbxSbt8VmMnU3JV0SnRV5GemxzZ5370arD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6084

On Tue, Sep 16, 2025 at 06:57:56PM +0100, Lorenzo Stoakes wrote:
> > > +	/*
> > > +	 * If an error occurs, unmap the VMA altogether and return an error. We
> > > +	 * only clear the newly allocated VMA, since this function is only
> > > +	 * invoked if we do NOT merge, so we only clean up the VMA we created.
> > > +	 */
> > > +	if (err) {
> > > +		const size_t len = vma_pages(vma) << PAGE_SHIFT;
> > > +
> > > +		do_munmap(current->mm, vma->vm_start, len, NULL);
> > > +
> > > +		if (action->error_hook) {
> > > +			/* We may want to filter the error. */
> > > +			err = action->error_hook(err);
> > > +
> > > +			/* The caller should not clear the error. */
> > > +			VM_WARN_ON_ONCE(!err);
> > > +		}
> > > +		return err;
> > > +	}
> > Also seems like this cleanup wants to be in a function that is not
> > protected by #ifdef nommu since the code is identical on both branches.
> 
> Not sure which cleanup you mean, this is new code :)

I mean the code I quoted right abouve that cleans up the VMA on
error.. It is always the same finishing sequence, there is no nommu
dependency in it.

Just put it all in some "finish mmap complete" function and call it in
both mmu and nommu versions.

Jason


