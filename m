Return-Path: <linux-fsdevel+bounces-60528-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6863AB48FAC
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Sep 2025 15:33:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC7B53B017D
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Sep 2025 13:32:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4CC530B522;
	Mon,  8 Sep 2025 13:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="umqPj4zc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2040.outbound.protection.outlook.com [40.107.244.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC9B078C9C;
	Mon,  8 Sep 2025 13:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757338350; cv=fail; b=b/+tKENXMoIo7ooKDUoeJyfUmvk0B+J4gk3WcfrWgbf2XcZcZnCe2yZPd7pY2Jt7y/Kb7maigf6b3wA3U4CjLziK4JhrcHZvilL8YqoHbgPvrT4biy7TnIM+ln4FABNPOPkkTfOaMms/ckpv7EMHumxPnY+JJo6+Pj4srKnKvqg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757338350; c=relaxed/simple;
	bh=S5ekSVJFUXHAEccaPuC231TU9lZc1QMmssp+SMH5ixQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Cm5AnTSFA9XyT2NDSrtIch/seYWCcv8nZEXm5fiYz3aOsuaQOj+yYBkmmBswPKlHVGYDCYhdvHzmbyZMHeMeBZOMvUMksrKHJ1A/5TXOvESlo85YYMd+N093AKTp9uf6n8YniH3sq7MXsn7BQ1gUt7UspP1dbcWnGwgkaMon710=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=umqPj4zc; arc=fail smtp.client-ip=40.107.244.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MSXEQZKwYEaZ3VNJhatwgR9CFxZONQKMTzr4Gfrxi5W4nAjP68t2LsTlLjODpP9yj28sXZgQml9BxIZHJjcx2JkkUU5N7lpF897Hu2zeDVaWMRvE9NY8p0x6fcd6eYZUeFFD5uYkNBYWH+e2207yff4spZiw1rOgrFZEHIs/XAGfQ/M0vDtFmqcbPlhnUiDyKr3UXMBjeMy9B09Vzr6U4YMUlmbmqE0TqDxZr/EITCcRwKdrr5wsfO+YKxeofhPMDdJS/EE9VjJGeN5tZvlzoJkpMUgQJjivksuKpLJZbbocY4oySpFe4uyusq5qsJOrYPiEd+R0MSzYiR7KB7GAmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uBi1FVpshr0fT1WbsHlc8+T7+Ir3NcjHPqPXVABKwoY=;
 b=M3EjhyWj/LxvVISsAf6on0H8ARUb2Le+3CX7C9h0rp3oVNcEzEtmyjckM9fTEnWdA2qrL3Ryg2O13F+YZIvfAcvWTzM7MUz1IMNQk1OEBEXSrphymQc6L9fBtSJe15hIsnUOc9CGUYhVJ5PxVbY4jbxhvJMznULILRn+xFqlYmcGh4EA+XfB0XZucadb1BjdlozKX5tfOePkuJi/ZIZKm8wCKscS3apJDzdz2blXbUz1V7GLiE5gp2drCBdCNg6KtDMqTkiuFw+cPBcgw7jDa1zyzxzxz5tGhC66TpFiLi+lW10yqbM6XJRgZWAnVuCi82nvR/qhb4za6YSA/HR7qQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uBi1FVpshr0fT1WbsHlc8+T7+Ir3NcjHPqPXVABKwoY=;
 b=umqPj4zcwH8q9hq4oSJovDWDjGeaUBPJJ65UEzkyUgh0W8p5w6MrnaYa1Ms8Ie9gT5lAVkvf+QkEjsMH39NeNbhEScfU0MvdKn3+e3NPkg3IeYJ8c33jawkuckcGxUp1f/qmjOzvMfj1LQv6x+6wPfCuvHbFJf6IIvA5n4UoIZS5jAXmj68iGbqSEMpLIfXBM6cU83XyMClkDSvkBtpjpR7s5KvBzRJ2yXuhhKdqeHidxcFevMmgZ5Ldm8u9Z/Y3wMh2eQgDkuVXe7+TjPzlhpWt1AIGk5qvc00yg1QgBPm7n4oWosH4CcTfu/lwjk/HV2jZt5yIhSEU/j8NQt30iA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH7PR12MB5757.namprd12.prod.outlook.com (2603:10b6:510:1d0::13)
 by CH1PPFC8B3B7859.namprd12.prod.outlook.com (2603:10b6:61f:fc00::622) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.30; Mon, 8 Sep
 2025 13:32:26 +0000
Received: from PH7PR12MB5757.namprd12.prod.outlook.com
 ([fe80::f012:300c:6bf4:7632]) by PH7PR12MB5757.namprd12.prod.outlook.com
 ([fe80::f012:300c:6bf4:7632%2]) with mapi id 15.20.9094.017; Mon, 8 Sep 2025
 13:32:26 +0000
Date: Mon, 8 Sep 2025 10:32:24 -0300
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
	kasan-dev@googlegroups.com
Subject: Re: [PATCH 03/16] mm: add vma_desc_size(), vma_desc_pages() helpers
Message-ID: <20250908133224.GE616306@nvidia.com>
References: <cover.1757329751.git.lorenzo.stoakes@oracle.com>
 <d8767cda1afd04133e841a819bcedf1e8dda4436.1757329751.git.lorenzo.stoakes@oracle.com>
 <20250908125101.GX616306@nvidia.com>
 <e71b7763-4a62-4709-9969-8579bdcff595@lucifer.local>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e71b7763-4a62-4709-9969-8579bdcff595@lucifer.local>
X-ClientProxiedBy: MN0PR03CA0020.namprd03.prod.outlook.com
 (2603:10b6:208:52f::27) To PH7PR12MB5757.namprd12.prod.outlook.com
 (2603:10b6:510:1d0::13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5757:EE_|CH1PPFC8B3B7859:EE_
X-MS-Office365-Filtering-Correlation-Id: 1296e94b-a083-4b54-6cf9-08ddeedc263b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?pbGdCwQtUkBy1XWPzFEuCSxAdxGU6ymWkpWa7puKYk2lOQtfEGnVj4mOqyw7?=
 =?us-ascii?Q?DEqvv2249Hq4je6j1kic8/cnMwIAKU2b5AivI4NrculouXZX1S86JLng5w02?=
 =?us-ascii?Q?kHdwq6wM/064mWbKGrrXoyk9oXIj8xKBbacL0DNha0AfzfZa7hsesPwQeGTS?=
 =?us-ascii?Q?6WcCq4GQnXFDhYxVEpW5+cGzmbubab5QvWyQgFS24glDaS/uDV0yQ1Skwluk?=
 =?us-ascii?Q?DqPnKt29dedTeFwNNjg2Uu+yT6GbAhcJ6HIr5R0myY6bQa6BordVNcrtA5OL?=
 =?us-ascii?Q?67CELdskAAgtr7NJDew/NZfyk7ZNq9x6DokZzUx5KrlN8Hc4bM33Oqm0lwgY?=
 =?us-ascii?Q?JKiZYsPn6CjV7A/d3qnW18+JuJdk3fk3i3BSuapnJLkeuW86CzNSEtVMUq6T?=
 =?us-ascii?Q?nBvQtf+pJce7jriOfxgnFxj0JrCrLHCfjhDeTm2znZI3eSFKAz1gdlECdgav?=
 =?us-ascii?Q?DYJ51dZmSxe1xVaoTDTj+fWV+GqZkoYBAhAmQ6mdluQinPmm10paDnXCxYbT?=
 =?us-ascii?Q?k/RohGAQ6fwv43R14TUAO3nI4IeELSjssnPI98Noswq19gB8o6//y6n8oIBv?=
 =?us-ascii?Q?sowz3Hlz7DT4UNNNMU1TTWv28y8utuTrFPsNAngfngZxZAHG+IOrm8kFpiPP?=
 =?us-ascii?Q?MQXG5kHJo3o3BF4S2kxbJ3wYZW1FMJGuuyURQ6NBZOvG41GAC1plt7FdH+eQ?=
 =?us-ascii?Q?pdUQZRrABthEG3NvMQ57P0siy+3JfYY1za3GmnMkcwt5jVTyHyNkX3vowlsX?=
 =?us-ascii?Q?eJKyMoIDZHPGpIt+PdQ8l02VdzK8XYMaksDsLqLdDIE7OD92OyDqBA1tRzDA?=
 =?us-ascii?Q?FjUEf3tVIGHXbMqf8nJNpdOkNcKF2m2OhgfJgfo3yHW9n4j3blo+E0ayXL/S?=
 =?us-ascii?Q?QjYwjKegDLrnoiU0ue7XoZCmQYsxkZ9YfjkFWkjJMq4DfnrgErYVEd2BC8cX?=
 =?us-ascii?Q?Xt+h1HLDeGDhLsUVsyq5YzfhVy4wuNFjsZtcGJelqcaP/AsJqNPpLFMHc1Z2?=
 =?us-ascii?Q?S4q6VvwDDrTehOa9ujxtAu2XB4qnQHa+2x85fclPZGA3p6ZarfGqre1lQem7?=
 =?us-ascii?Q?7KAOP9QVhbLnmjf8Z3LEW0HVh1QWgWHPAQTZ6lhHJyKhq1Xri2Opp8gszD0w?=
 =?us-ascii?Q?rUQw5yIbabLeJ9wyabgtv6Q6hVZYq8MToiEcn4IIr1N5LdxV2z1OwKZLZbBD?=
 =?us-ascii?Q?O9TfFXuA7H7uPFlHEAS4aqHUh8p6K9E8W7CDcbMFf4KBsqw5c7MTdZQkj2xn?=
 =?us-ascii?Q?ZLzBiQNihUg/ITMDoxldx7p0GaE5tNzAFhyYBfmr/f2ee7R9C1MT79Nl4t2D?=
 =?us-ascii?Q?6AivkHWeMQSO47JExnn0e04RBG9PWA85cznHo6hnnxb4Pz08cbmWRVksrC7a?=
 =?us-ascii?Q?JIzs7eEjJ1RM0+7gjCgdexmWWSx20z8+tNsQk7fvUvKy8BDZ7w=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5757.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?cWluRfwjDRHkIbbSj/V4gzAvYEhm+rAPYVuK3KKOz+XhVc4jmgXAf0f2JhVW?=
 =?us-ascii?Q?3RtZG70f1N2c7PeMoSdlLtd8ggMtwbUA1MSDbTH+l4TrbUJ9Psk/T0nYP0rW?=
 =?us-ascii?Q?q+6NXhgSF4X5lYsfYNxrx4eDgZzHno14eN2tYg2GtcgMGbHS/lHL+sndpmy4?=
 =?us-ascii?Q?lW5vJZKnR8ULPwehbnfbUYHv1bUAUQicLbwQBxom6pbsDDRueMWV5EvZGcWC?=
 =?us-ascii?Q?Ca+xhyTK9U/stsJ5YUxZKHLAUekqwqp+WgG6mIjgnes+HXhkhv77aGtwMLiH?=
 =?us-ascii?Q?57Z2BkSvgQfbgtBjfZfFhE03HrwEPOVWrm2mzfO6wwRAumTujtQDxVaSvJF4?=
 =?us-ascii?Q?vGJA1S4gOuQK8WirrV3agNkSAuPta1C0QJOrtykiiB98m3hcTPXURnSW/3XF?=
 =?us-ascii?Q?Si0mrXTcAzQPoWj5iW30Ps62qOwZaie9fYyr9eEhVPHJfdcp80SEZBVlWyFr?=
 =?us-ascii?Q?4KSaeN9ltcNCrXl7XlgY2gMcmZZczYz7cCMFsFcYTzxpG2C8YONAw97vvVMi?=
 =?us-ascii?Q?WIEsrnVaCuYyvYTYOmQJqTZTdz3EDCYheiRkePmBpxE26h+b6Kq9xDnom3lT?=
 =?us-ascii?Q?hAU83w+Z4tiKJeymfhYnG+8BKpsmrYP4ogJMaZXWnhov4BJ0heS3V1XEEZJR?=
 =?us-ascii?Q?KFaWZXXx8r9QfruNFjArWZoBjuQEzfBtkWI872ymCnZoUPNZiI4rDjsm9NDz?=
 =?us-ascii?Q?mwIFqgm7z1mA+mZshBeVSd1vqvoOSyE86lk3VoBuINCOFuxtXLQWP8EqC0Rp?=
 =?us-ascii?Q?H+zL8GExBgc44sliX47Wjg8DDONQA0yB/l7HtT4O0DfBQKBmTXBFkxlKve95?=
 =?us-ascii?Q?dtp+0YVmBitZCDeuLsTdzR+67dEBZKRSGxRtW/7ZeBSk4LixF/3QEG9lB9Jm?=
 =?us-ascii?Q?Fb0sDzdduJIaSMEovZyq650G83cw8vba5BIiMXmCXCtYrDH4kDCQmJ7gAM79?=
 =?us-ascii?Q?yza0MF1DtNYK11cFgBDkStPmqjM7UlB89nc8xYtVecZEAak9EUitury93mRY?=
 =?us-ascii?Q?6xFXnHpnoXYqSd5wfZsYeRQNEJdQVPmIVzigF/uy2E4m2vlF5gT02ogsvZ5a?=
 =?us-ascii?Q?OjCUJc1Fb1oe3dzHuKA6bq2kkPAG8Tx2SlZ9C0pAuOrMGBshLZsb1sPmNiQX?=
 =?us-ascii?Q?qYTd0jwSWKHWOLijtLKxWpDACtXLPZYyUTzsIxukBwvEWIGbJt7ycFWKfu4O?=
 =?us-ascii?Q?8haVm00CFRdSXl5p5qlm6RkmDsSsv0r3T4yuuBxW5RMqtJ8nPULXpeimqUUq?=
 =?us-ascii?Q?AXVpjLEzkym0v5s0iHmfntLflk9tlNhJpQ/71W5TwtCHnGKdBV95CaVZLOHV?=
 =?us-ascii?Q?Bu9H0w0Y2VhjXk0QbDsfRwPQ1BVdZ1p3RyYworn/zuJvopPG8JXwOuNwG6nD?=
 =?us-ascii?Q?WZS6sniA83otjD8a4iyKq4f/0Uv6CLVqhEAEm0+kWri8PIExjxyB8R6Wa9qb?=
 =?us-ascii?Q?ZOP1NngUt1coAKwmQOcjri18j82Jq0uiU/FF15gmgg/6RCwH2ET1IKklkU/9?=
 =?us-ascii?Q?HRgMt20T0Ernl/NmX+olEjTyWxIKzreWbYum7KyYb5kI3C9dN+gi6D7jI8fy?=
 =?us-ascii?Q?DcZJvHJA20Z5dMwV/fY=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1296e94b-a083-4b54-6cf9-08ddeedc263b
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5757.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2025 13:32:26.0123
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +YdG2Z9wJsLcOm97NeNGzP0EsYJQ7Sg+4VCbYQF4vWiX9t8lrZw4zZKBGT3790aW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPFC8B3B7859

On Mon, Sep 08, 2025 at 02:12:00PM +0100, Lorenzo Stoakes wrote:
> On Mon, Sep 08, 2025 at 09:51:01AM -0300, Jason Gunthorpe wrote:
> > On Mon, Sep 08, 2025 at 12:10:34PM +0100, Lorenzo Stoakes wrote:
> > >  static int secretmem_mmap_prepare(struct vm_area_desc *desc)
> > >  {
> > > -	const unsigned long len = desc->end - desc->start;
> > > +	const unsigned long len = vma_desc_size(desc);
> > >
> > >  	if ((desc->vm_flags & (VM_SHARED | VM_MAYSHARE)) == 0)
> > >  		return -EINVAL;
> >
> > I wonder if we should have some helper for this shared check too, it
> > is a bit tricky with the two flags. Forced-shared checks are pretty
> > common.
> 
> Sure can add.
> 
> >
> > vma_desc_must_be_shared(desc) ?
> 
> Maybe _could_be_shared()?

It is not could, it is must. 

Perhaps

!vma_desc_cowable()

Is what many drivers are really trying to assert.

Jason

