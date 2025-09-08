Return-Path: <linux-fsdevel+bounces-60548-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE525B4926F
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Sep 2025 17:05:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 541497A39DF
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Sep 2025 15:03:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 990ED30F7E6;
	Mon,  8 Sep 2025 15:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Q2MzGcEC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2074.outbound.protection.outlook.com [40.107.220.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C15E30CDA1;
	Mon,  8 Sep 2025 15:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757343851; cv=fail; b=gOpf3yQOaEAfvy1jPJjgvPtP/CpUGMEzzRjpaZ8Ww/ArDilcLYj/HEZkCz4TkMwwbnfPO1qAPAJ47fDnbESIhQf53BQOOxmmmJhMsGj5r/37j0mOVDI3RVb7pgSn7hbu5cnLL85hg4ukkfsLeaPith0T/Q2tJz2wZ9LPXdkvdcI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757343851; c=relaxed/simple;
	bh=1sOevtywV07Nn/cnvmqi6Q0B5NMG0jl1R3BEWTuPuo0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=IDg0SgGFjCz+37IB0U8YO8Yr79ZXSuI5v0qRS8uqN6OmkV6cmFSvp5CHS7r9Zoe4pELX9d+iO9oFDd6QhQ+tVV2g0dgw9xFxOJdbsFGLSKeUKcG1lrPs6H4c02lHn2rLJLwjdC5b310UKrNPG1CuWP/KRalNzw1IdwZtOIqh5Ns=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Q2MzGcEC; arc=fail smtp.client-ip=40.107.220.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cNhATiDXxoFtcXXEfZFveZtxUvaOdSgRFL87FojrjLtUX7F7YyTNjVayDqd1Ca+GWRHCnjQBSryhJVklAtfdsXWlIcSwUrOSwpaDFZJK0aQG8rAMHcXcrUpp9AwT3nesGtlOlRy9T5P5svslpKNOEV9o2pyC73xh/t1YzOQAKjOkz8noQc0FU83LKKXNC+XcgkaSzoleUNjL9DSA6PKzshUr3FhyK9bjCrRU8jOMfPGS+QGZIWqovmqSJRCbDvqRVV0Qbkz0ACiv8scDtWnNcQ2JGCs87yW8i6iDWfi9BULUBQio6L0F5Nk22BFw361Vurir1UgNdxyjt3FxCZ+0EQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0pFnbzELzeABeu7YvtCA3xdHcGUwbc7/fpG0pw6zzHc=;
 b=JbNF0PEHKsiRn3ahD26ObuNuldEy05kWswRBYq1b5Pz0kUKTXH2HJ1pGR1qIEUpD0KpRJ2F3IBVKk3fp0AQdG5VKBeWvIL2e4+lgEU2oyyUE2AUpdXDy1Mw+0R/1PYk++Ccn6FlEZlV6ae6OP07MLKthe5nfP2cMs69jusJ01AY7sfqDS4X2nDkgUhP04GVQSMDVXflku9DkLsYQfd/Vzc9dJU2hWo2GRa1NzuVGFsUrZ20YTGFmlmUMpdPbK8e9haPw0HIIXm4SboXaVI1sI38KPcl2wYgdp2EaqEa3mldCWslOxBLfldkHWIitvbMeb+gGKeS1AHAZ1RlPhcOa1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0pFnbzELzeABeu7YvtCA3xdHcGUwbc7/fpG0pw6zzHc=;
 b=Q2MzGcECnZy3UGYlfh3mpEOvxJGFyo6TRtkxNULiffnOcWJPLQTJY+6FCE1uTE0bbwSMJQHofYezzzJBsvpEXdIzrsrhs6rOzCO6V7grN4omlYgfJm8ie1ofxslPsibU3CjPk9/jd6tI6yfOsUUmEPl9qfrefxgXKmPycURNouuxcfE8kagP0ALB8Y2HL531ycJBznbIpZWGa9kvt62Xtco3WwoVwvmKxQevARL6l3YHVvLBvKn0PUVbKv6SvkxLZHKQx95lSFXHzF3HUUYzL0mKo8nV4J7GuLpT2jbBXK1rZDF2B5o2bxI4oezDpOKETL/sLDs29JkkzWwbK44bMA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH7PR12MB5757.namprd12.prod.outlook.com (2603:10b6:510:1d0::13)
 by MW4PR12MB7288.namprd12.prod.outlook.com (2603:10b6:303:223::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Mon, 8 Sep
 2025 15:04:06 +0000
Received: from PH7PR12MB5757.namprd12.prod.outlook.com
 ([fe80::f012:300c:6bf4:7632]) by PH7PR12MB5757.namprd12.prod.outlook.com
 ([fe80::f012:300c:6bf4:7632%2]) with mapi id 15.20.9094.017; Mon, 8 Sep 2025
 15:04:06 +0000
Date: Mon, 8 Sep 2025 12:04:04 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Jan Kara <jack@suse.cz>, Andrew Morton <akpm@linux-foundation.org>,
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
	Christian Brauner <brauner@kernel.org>,
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
	kasan-dev@googlegroups.com
Subject: Re: [PATCH 00/16] expand mmap_prepare functionality, port more users
Message-ID: <20250908150404.GL616306@nvidia.com>
References: <cover.1757329751.git.lorenzo.stoakes@oracle.com>
 <tyoifr2ym3pzx4nwqhdwap57us3msusbsmql7do4pim5ku7qtm@wjyvh5bs633s>
 <9b463af0-3f29-4816-bd5d-caa282b1a9cd@lucifer.local>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9b463af0-3f29-4816-bd5d-caa282b1a9cd@lucifer.local>
X-ClientProxiedBy: YT4PR01CA0279.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:109::17) To PH7PR12MB5757.namprd12.prod.outlook.com
 (2603:10b6:510:1d0::13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5757:EE_|MW4PR12MB7288:EE_
X-MS-Office365-Filtering-Correlation-Id: 62cb388d-db7d-4d65-be8c-08ddeee8f497
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?4LMm5Y7Xx8YyZ3nMNGj77qXb5JeM+tvTI8NUduVrJnLlYbVIS2ygM7wuY0Za?=
 =?us-ascii?Q?ni5upQdYk8wLppaCwEffq9sBJ1ltqZuolcA5WL/M7y6lMQWQJVmmfQcGa+tr?=
 =?us-ascii?Q?fFumPC2YHtuzr5ov5ubplkLBAeNo7Xtv4cg6as3aAkmfiqaETYcfySTerce6?=
 =?us-ascii?Q?xcwBP7qXahbG1UykKFmMwtYLAf4hEXrAPhuJCyad2lRscBXnAv/fzfnIQWLZ?=
 =?us-ascii?Q?DJcxipnKqa6h18WIKJcX6Bu6bd5vTzHPqXXRGL7i/zatElgoNspz42/dLVR2?=
 =?us-ascii?Q?P6pRNCpo8SejbuZ2BDkwgxVaW25oleH6NS0F28R9OMwqTg2iwPBA4w+6oy4+?=
 =?us-ascii?Q?9Uhztg6XzN06O8VAJWIAODzM0/TndqiX32KaEmiog7ZYNazfjBDNJlB2fut5?=
 =?us-ascii?Q?bqWC90sdVtApiSZIlDc7m8AaUuw1ovmOZDVK2VjmqW+JQ0Hdqnka52vl3Lz3?=
 =?us-ascii?Q?xzBxQkli2mfUIKuQy2E++Si1riQ1+2hK/RQsC9D59ahWc+asas+WTULpeJ75?=
 =?us-ascii?Q?JARsSCclz3xWXnxBc4UE8qBGh5V9j29KxIQJPJ/3T14xEWa7bRWi9ZlX77RO?=
 =?us-ascii?Q?CMmiRKtCHipIMb9K7Axd0Z8TRsJcrz+bXNqhV97rUelGPtzy6VpGkZcvcOH2?=
 =?us-ascii?Q?zlUeBr0B/9Fve0QWlIX3WokcSg0iJf2+bCT9s1ZTdboMHAv6cxRa3PgJKrD7?=
 =?us-ascii?Q?RHsxtKMuDjQ5I7ILXvJnzCyJ1/2+9Ng0+YvY/qIM5ycDJ1g2tm3558PHWPZl?=
 =?us-ascii?Q?a3QOCV2w2Zm8h8e/stwrNLOS9b1ZsBob4HBMM79CPp2sdpEwump1wwPmUK9R?=
 =?us-ascii?Q?SUAZntV6gJOzLQYbrE7Q3W7Bd/1yZz8McI/pvNvnoeO9JJTebSSmQIlE0rl2?=
 =?us-ascii?Q?U16H1KtCsq0EPTSJUpNtsyQGY49FTmH4qkKgOHL1hjVdsdZEf7e/h5rKEQ5p?=
 =?us-ascii?Q?lNjPbwqdOh/wrsf/A/LFtuz8ghc9RlyuyLR+Y3o8dwP/V5ObCZPok2XDvK0L?=
 =?us-ascii?Q?09CLrJe4gK+beBlHg2kx87FBSbPZ9x2ctYnMAIC7UfeZ3kUwRPdZyiatZLmn?=
 =?us-ascii?Q?UBMOgmM8fOkpvmx4r1mhJnm1iUx7MC3cjgOm0/JmMIIzYZoQfeX+m7mhKB2M?=
 =?us-ascii?Q?zk7X7ucBwqcl8Af3X8Xuejl6ai37FrQcdDuhUs6giuQyFxPYJyVaLE8NeX9m?=
 =?us-ascii?Q?ZsCKpriy94Gq54th6Ii3+fTogUtRvqcUU8357k3sA5mvYOqo9/bePFaeVMQw?=
 =?us-ascii?Q?Y6jz8oDLzLiOh1JzQ8acwW5J5bOcjzL6VY3vPiyCoBamv3w+UO3yt2X6i/0c?=
 =?us-ascii?Q?OeH3+npk5UscsERBvjou6EWdZ08mIHDP4/bK0ZGmcNSJuAA30jibJBxp7brS?=
 =?us-ascii?Q?z/c153j7t3nVFKM+hTGaTWi1YYqVRNQ33xYpQu8XmXhlqS57R2D+EhR242B1?=
 =?us-ascii?Q?TsgTFMEbCmg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5757.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?RdjXWPDyZNBWQnk6yjfmYmYMos5vLyvhYHvMy2zFV1T1ANTtF9kb/Pnu5dK7?=
 =?us-ascii?Q?baTJoQjgUebzcnGg25kLlGIC4O4iFlRoI9BCnue3NYlSpYceXfxsMZ0gei3V?=
 =?us-ascii?Q?6l4UhTqgL1XsOCkrTW2R8cJNc/sSQZD1pBLRptOTj/UdtIk/jpmyNrqdkwga?=
 =?us-ascii?Q?Szrcp1yK0PxFOnkCnLTHDd3uMzi4YxXLHaARHz/uI8jc7rwYfUqync3iNfTb?=
 =?us-ascii?Q?z85263l1cqVbcAzvKCeDG9zdJUrWJwc8gdq86n24QwCLlx1FfDHJBasURTbT?=
 =?us-ascii?Q?RPGuFSIYIWnjC+ZYVsOd02dkqwS3W6WqCxQbORtExCJiRvui4jrrVgzlJoFc?=
 =?us-ascii?Q?VdYau3AqVxQxx7DKFH6V4lP3g2YGZWQBX3VLyznAzorTWcMTOVCnQSWALMCJ?=
 =?us-ascii?Q?kM1IG8GPtCzllps232vX0eXduf9A/i5yLKL+9TJyeJoGVhFE9Y9ru7ba3sV0?=
 =?us-ascii?Q?n6fkvq55e3NKz1RiKma6ZVYj4GfVUT+6Se62TuLPHq8Q9vh3X20Ft+S9xlp6?=
 =?us-ascii?Q?ixd91sLzQOKhsTxDhK1xTuJxdclsKnqjU8sO9BH9GRqoxP5em2UQLtQRkohO?=
 =?us-ascii?Q?pZDZL8szWFB/2zDkfMoUEod9K3IMMQg/uerfMUAA1rM1DN4OuRMhZer0Y37o?=
 =?us-ascii?Q?Hp4jQ7WSR374MmPP2Bun3j4Lid2uoC0LMjqZFDFVnx/xFM3DtbbkOAe0br/k?=
 =?us-ascii?Q?XnzMAAFnX9i2HiwP6GpQFZtAuz0d1QlC5IxHhbWImR8HGYp5kyVXSypQK6/+?=
 =?us-ascii?Q?Vtz+Pjn3ml9Ku3JEvj33MXfo6zdAQ4rk9IV++OzB3T3TjTpnDuTYOn2NH6Va?=
 =?us-ascii?Q?bq8tZIERd0usTMhczrzyFBJMtLH3nCI+/X7oRlWX25fLc7PkmElK2Y86m5jI?=
 =?us-ascii?Q?0DiIe7Q9jkCPJB1zTP1RDqxgtGO7Bzad2YN+DiskuNgt7ELwThj/tO3Kedo5?=
 =?us-ascii?Q?OqOpRPn1Iuh2XqLf97INXjjagwKszpr6ZwARf8kSiXR7oVsRfhNaD8tUIvtl?=
 =?us-ascii?Q?x4j3CfC7G3Jlk/xgFiQRcJcjZWMm29hX/6QWJI5OoplK6o7HWmCZtaWJ7P3H?=
 =?us-ascii?Q?u/CTa319oqFEdE6VHINnX1TieQ6joW/s3lM3s6DJF51IJpVPCe8fjzAck4LV?=
 =?us-ascii?Q?NnmOIBZEyasJIA6Wv6qWHbsb/e1IFa5399VXS/l7zEyrlS2Nee8c9MkDfR/S?=
 =?us-ascii?Q?e7Eqw1h1v5seSLOmsYpLMBEwoZDD8ov+/XjEoc4uaW+FTTe1L/ilZXgyoLGH?=
 =?us-ascii?Q?EO6x59EmtiQ1AYfzDcYL737oqsWEGrLtbpa4ORWtk+Ahkyjqjwb10zXkBDPN?=
 =?us-ascii?Q?2l5Qydrf89Sb45YttVqKFV17uXaH1Wp/I/NfMlNO87FIbiphD1xgDMDYFctL?=
 =?us-ascii?Q?VUz/6ZXVnbwYYpKnW0s8eWUGilC3bWIKbXct5VNaCgBQegNlNMB/DyNH7L3U?=
 =?us-ascii?Q?1K+jx7y0GLNdYBXZjVGwjzHLAWA9c+JtkVbK78D78hRNOTkvPk6wnBeFpSnd?=
 =?us-ascii?Q?sDCmn5r3LqGjrfxWSjqxmYqKULxL2mjj4UjE5RhXbPO+Q4NFZPTx5GFTRLmo?=
 =?us-ascii?Q?UjJ684ZdKqQs3SomQZU=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62cb388d-db7d-4d65-be8c-08ddeee8f497
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5757.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2025 15:04:06.3779
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mUQlgCPve6Hrk1P15+DUvQRHcERo6HvLEhI+4lf3XlL+h/wnNHrEduK/fYdHAwT8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7288

On Mon, Sep 08, 2025 at 03:48:36PM +0100, Lorenzo Stoakes wrote:
> But sadly some _do need_ to do extra work afterwards, most notably,
> prepopulation.

I think Jan is suggesting something more like

mmap_op()
{
   struct vma_desc desc = {};

   desc.[..] = x
   desc.[..] = y
   desc.[..] = z
   vma = vma_alloc(desc);

   ret = remap_pfn(vma)
   if (ret) goto err_vma;

   return vma_commit(vma);

err_va:
  vma_dealloc(vma);
  return ERR_PTR(ret);
}

Jason

