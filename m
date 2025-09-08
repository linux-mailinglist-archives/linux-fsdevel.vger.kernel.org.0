Return-Path: <linux-fsdevel+bounces-60523-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E5387B48F5F
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Sep 2025 15:25:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F3A43A3039
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Sep 2025 13:25:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A94C630AD1E;
	Mon,  8 Sep 2025 13:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="row4tRFN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2061.outbound.protection.outlook.com [40.107.101.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CF7930ACEF;
	Mon,  8 Sep 2025 13:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757337895; cv=fail; b=BVzMI7Q+gbnWBO/p7+MlA6hZkYHEJbIDlBKlVcoZ4UHhmU3bwIpNum59EtRKT/2lY8lpB29YTf9j98xdiYpGnB2lBqe6DyNuxWTaxhayu26odGz3NgsHB99GCgh62jogjqQUneYuY6gs4EVGdHr2t8H2I9QN/GIC8+r5NhE5FsQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757337895; c=relaxed/simple;
	bh=RZaHfDvfmHzn40hKCUoYG5cNoU/D7bhe5oeaMpPXUNg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Yd9Uskn+3S1UgiUiI8SEg2tVlKNKdoK1+xnJWMdWSfIsLC9b7XX7BmXuSiNp+qjZoB09ztW+iAPVZAzacYbUiUj71UMwhYqY7PF4+JO+pAUoeNLNYzdWGh3Mrhu+/nDuPF0y01nhSdJla1Fthz6q07oYj98szaTMpNtwP2v0EX0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=row4tRFN; arc=fail smtp.client-ip=40.107.101.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JOH61RydzvcaeM9rI6ARSluHueDIcJYly5FkcVwknIA0GOEzgf7aLZ1S1L0ksavB2qpniAL+1t4WMHDT523Z6YWLL/6XwGJJYbsYB1HGuktd08MPLbrItI6kI39YIqFle8ruvHukWT/ZqW6MzZd4Tg/Vy8cPFDgz8gKZ7GQLGQsjjGtsK9VsZih0XOalpNs02RXxVYhhJhEVVTpd38HSN5SI6/+UDmMSO/OG9IcUPf3GdQjPm4K/PPCZJS0bATWHqp6u855ou6zwjFTt4jpLViH7k82AYqgm0knBAiV4U9CDJa+nkqKp14FHAtEzh8HBbaM6Y3aUgNlenSbpZTdcOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tZOK3gvmwqWnhlifB3wIuA1W24Pi0oLtgZexkL4geK4=;
 b=UWsvj69Ou1aQsVHBOCWobjFCQsIbob7DE6vin7+stpZ9kxgOd9jk8OWg1DcOhhO9+KA6Dt+hUkTsdpTV4rjgYr+7HDeQSkUU5vY6ZsYN0Dh8lJsx1OR1rChOZlGJNZkTvJXNLHoCcYCxzj7AJsmL51aLkbJcoRaJaZfb/b482xilsRLw2dQqyQtkjlD+hAg5RV4MTN3oLbLuXoTlIOKfDYLBQPVOIVFwWwcJb69N+r50p5hXKSCzCqRObDGRycT5rubpC/U08v9wnga95pLKsq2uil/ycxprWZLn8Mb4Nsrci+aMLpnWYEWS3n//iDPa8YKuXZIDIHc2FpEYdhDzRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tZOK3gvmwqWnhlifB3wIuA1W24Pi0oLtgZexkL4geK4=;
 b=row4tRFNJSv24bpH+I7NxMZnSY2k1N3u8JurLzW5Bn8edCLvf7s5Cd7N703DydlFbNaBOPLTN3PWrKzEB26vpBMoW0NY1Kc4l7GEVi3q8AiutVxWGwLlWxuf98MMGyA732dKMAuN/A3rIBc7Qn2M6MZygkcg72aAN5MR7+UI3KRirSLJx2ExGKIYvbvPJTvkHJOh49vk3cNrNNSW9IPwqGvIAd4hLWWUuKfvpeVtigiBOEWRu5y4Cw/Vm+AEJgGcQFnq0NLYRNQf9jjfZl+xWznnxq7Jfp/+G+MkH7JUtCx0aAUweC/IOkdSy2hk+cdfy6+FPI1R6JLbXGj2+jSwJw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH7PR12MB5757.namprd12.prod.outlook.com (2603:10b6:510:1d0::13)
 by PH7PR12MB6882.namprd12.prod.outlook.com (2603:10b6:510:1b8::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.19; Mon, 8 Sep
 2025 13:24:49 +0000
Received: from PH7PR12MB5757.namprd12.prod.outlook.com
 ([fe80::f012:300c:6bf4:7632]) by PH7PR12MB5757.namprd12.prod.outlook.com
 ([fe80::f012:300c:6bf4:7632%2]) with mapi id 15.20.9094.017; Mon, 8 Sep 2025
 13:24:49 +0000
Date: Mon, 8 Sep 2025 10:24:47 -0300
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
Subject: Re: [PATCH 12/16] mm: update resctl to use mmap_prepare,
 mmap_complete, mmap_abort
Message-ID: <20250908132447.GB616306@nvidia.com>
References: <cover.1757329751.git.lorenzo.stoakes@oracle.com>
 <d9e9407d2ee4119c83a704a80763e5344afb42f5.1757329751.git.lorenzo.stoakes@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d9e9407d2ee4119c83a704a80763e5344afb42f5.1757329751.git.lorenzo.stoakes@oracle.com>
X-ClientProxiedBy: YT3PR01CA0051.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:82::22) To PH7PR12MB5757.namprd12.prod.outlook.com
 (2603:10b6:510:1d0::13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5757:EE_|PH7PR12MB6882:EE_
X-MS-Office365-Filtering-Correlation-Id: fce15a36-c8f7-47ad-070f-08ddeedb15fe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?oPZKHxJAGK769bWS22UMAkhJgHN+y1pyccrY5DKaBgzbI+GTnsUTjrPDKTr0?=
 =?us-ascii?Q?/jUvCN9otRyNkju7bqaQ4jf+F3Is6FCSLNW3vYjDBWsmGw0f9XCCpQojTKvP?=
 =?us-ascii?Q?DhUnZZ7iwSfXl1neyNh4oQMk566NOApRdt1MIOmJCXKyJfmyVFeyf6bZcb5f?=
 =?us-ascii?Q?t4E+GHNMYdmPKNQ2/7CeypAObAzcqIUyQnA1ek9iO890CWKHO5qYakuMBqtX?=
 =?us-ascii?Q?kTeiFHxQnANTkksp6zXRbdYhz9vVSQgb6sVl8xofitzsx/zGG9aCO5b81GRF?=
 =?us-ascii?Q?aNFQugSrq1C/M+XdDjjStlk8BbvjXv8qeeDrawSWsS1sCouGCsFSc/XpOe6y?=
 =?us-ascii?Q?qgwHKpTkdxIeHcanFZMaeO9cKYp2tWmpUcSqHvCUWs8CmknSvtbV0XLdkTFA?=
 =?us-ascii?Q?4IwreVkBpTjE2LnC/KZg8FnDQPhHOO12wh0vwWRQ2Q+aWp3T0gF6Fo13YnqY?=
 =?us-ascii?Q?6oYVycx5haILgxaF7tPUVNW0AuvQjU8cHnAJHi6DkZceYPKzjIODHieRGoSd?=
 =?us-ascii?Q?9L3x91YtjOYTpjWPSFyRbuNN4aD8TpumAqPCjALVtCuB6S+KGKyAvxNNvET2?=
 =?us-ascii?Q?v7nEp2g2U1HxFbWMz2WJIhmNshtUrSsnHTLHFT6V7E+S8f9+IxTDuqFRjpzu?=
 =?us-ascii?Q?uaNKSD/+E45AXk+YPheLuzuiFeiE84AKasXTR2OfbJ2zyC2ymNkVhHt3jIaJ?=
 =?us-ascii?Q?yc9rYeCfcss7Y/k5k2FcPp/6FmdaAkXU1Kg0eNYDMLvJWUo28EJym/Z8Itol?=
 =?us-ascii?Q?z6AVfBBdv2HP8CdXaaUJlclM239HI9Q5cltDH+oVOLOAdy2rqoBSIowvmTpD?=
 =?us-ascii?Q?hBwA6XxWhI8bn81bkqQ/CXJ7VCdnsJ3QLnll0SnJ3IlDtj/Nn0ijnmwuR0bn?=
 =?us-ascii?Q?QdKmLVwis61AbqK6DbmGovnWgBErbnIr6LoXMwDB4/KUGmDXXVmmO9ER9hbE?=
 =?us-ascii?Q?P5lzjBxcAzhrEBkgiy7RIBgPJE+ThKmbSyDtIT+Kr+Oa8TSUbbcOLgeAzfdS?=
 =?us-ascii?Q?Pd+N2dg0+iZKIo+o8SSED28PVj9BHP1ZGdg22cCnwT6/fiwtN9S5ApDXpREB?=
 =?us-ascii?Q?3WUjUc2ac4uoxkU6r12c2YeKFOVGC82s2g5ofT62f33FEUo5e4XOwkDVyj9D?=
 =?us-ascii?Q?NWs9eFimI09RFWZfJRgg43hvsENUFtZFiWXsZ5nDjspedtIHB0QhOEM77u/c?=
 =?us-ascii?Q?e7rseGb/1WyJgTZOEiDDBq4k9W5QiDigp/Cx8JRhbORHsTYhTvO9qDloS1kY?=
 =?us-ascii?Q?gyNShAiTKqq91OQw3ov1m408RjUuDO3ptzYSk3ahCXdR552kcPn2uV4Cl1zF?=
 =?us-ascii?Q?viOSUVSf/lnC3JpT6jMpriWtAYcU/Cak9YlDyqBorbmz/dikSfv0Z+cL14KV?=
 =?us-ascii?Q?FFyBXsqVNEuE2C+9IClTPrq8c88/j4AYNgn9Yw75D1tGU1mguENXOfYnGYtp?=
 =?us-ascii?Q?c2Zi7ZPThVs=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5757.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hPOq5cGXa+8xF8pPAdL8AjcCIuuYLm6eAWDqVUglAWxmInkUTP4CbqTTG6AP?=
 =?us-ascii?Q?tWAsFiNd+CauxIp7XOzYRtbGK/YQvIz7wkOgCsjtG/N4Wap1yJ2cFdZCtRCH?=
 =?us-ascii?Q?VEg9hoHHnjQ9BK5INxkTZ6L7AmCkCD2TAXqdiplRZvFMJpZXx8OCKey5jREc?=
 =?us-ascii?Q?XLgDd31Cf3jN1DAlMoESwp3ZilMyMz9wmg8e89pmFbruL5YLhO0kFhfon1v3?=
 =?us-ascii?Q?vuVJjogrFPWK98yWSy5m80ZyayWD7b0BNHG4xH/2qJxMf4auyEkFyDdQuT08?=
 =?us-ascii?Q?PbRA6YpqFpLFbTim+Eyc/FPiex+Vyx+X6Y6FqLLWxcBO6hZmxrGtto2jfGlx?=
 =?us-ascii?Q?nb6AaJh5mlOSoyIbO690aAgBgR6xP/Gqyfd2EHD0vID3/74xQyDu8NxpxSQT?=
 =?us-ascii?Q?2LaluNmUfsIBAnOeoz0NvvJo5+WRdBTBByahq8P0Y3MvyOsNTSAM4yj3zeqL?=
 =?us-ascii?Q?HC54qhteagR9gZwkpOH0zFRKi2WCc1pmxO7ag6HDknarrvuudNJlc5Tooc3q?=
 =?us-ascii?Q?IU53+m1RjKFfzCBY+FfobHz91gqVxdo0W5umG0mHeQkVxPYo43/F120rOw4N?=
 =?us-ascii?Q?jIuyr+84CXXR2PAa3+jdu/cBwG0JA7ecl6Fm49CbKevyeK8YXUe29E3XtHIf?=
 =?us-ascii?Q?iTspGTpbPB8gpTw37o6El3sxoWX19/oEbVhgXBhlS2EmAtlG3mUgXWC2eF0J?=
 =?us-ascii?Q?bHCh5sIG4wo8ba+/pP7vFQ3c4kRwTrsaFnoMRjaakWTTiKy1PL3XY8X1PuUX?=
 =?us-ascii?Q?+xdLy4E4kvu528Lz1Mhezv4kcnDWfv+Nxyz+zxyjGwWdDJ+ngzHdV1wTpJb5?=
 =?us-ascii?Q?jFhljU6fqNBsfrTlgnqXTyHA7FcVgBrWRxsRMaw+EkmbQPh9pUxNQZt6C8ot?=
 =?us-ascii?Q?bh3DU+w5a0cVhVnKiYu/vgsRWPJVVxG+1uo67gh+JQPkknsFtHJJXrqrsvu2?=
 =?us-ascii?Q?XXZis+v+mWMHdrcax264rFbnTYXBWQ+nooZuCpiIRpniwT35M3Z4fY5TODuC?=
 =?us-ascii?Q?x5Xukox04dmVx7QUgmUJUfBwUEcZSWWKdxbItmiVo+IprLQrCuMndgOSInKx?=
 =?us-ascii?Q?xiYmSRSk8MxsYY37C+TTzAquKnZNzg5xnRmf564O7O4B83d7gny4KiMTZXo6?=
 =?us-ascii?Q?mjNoo7pG94ONF11cTLFyUcSLxLPCQokO0b4Z2+2vCU6j1UPJGpoglP9ot8tY?=
 =?us-ascii?Q?KYjFDWpJxKxc1a4p9go3MWsTUiEPiQc0N3LV3Z3+Ixg2BQhySAVz83Msssay?=
 =?us-ascii?Q?6S4BWAkDp/HOZPDANNPImoH6A9+97tZtawL+kfbOqlIKFntWbjRA7uBQ0YI4?=
 =?us-ascii?Q?pUiCKYRhmTgnfNfn/A4cKLfokscj+apNv1xZUT26zP3HtZLWTK35biGeYdj8?=
 =?us-ascii?Q?i4ONxBNLwzkoiJCr2hVuFW+StXWryJs/UJ3SUHHxb+jWDofjpE48NKKYKnQ/?=
 =?us-ascii?Q?Fe5BhyXNjBajebb49R8IuOZhM+odthwjSHUqpu8X7jl5Sy3PJTXV8pqozZCM?=
 =?us-ascii?Q?4XsBwsAjdPttBcGVUNMDy+DB92HBSOhL6HUgrmUvsc+cIDtNM8Skms1h/X1d?=
 =?us-ascii?Q?4BsdQ/K0M2AV60Dvaxg=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fce15a36-c8f7-47ad-070f-08ddeedb15fe
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5757.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2025 13:24:49.3190
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YUX61/utz8GYeLqVs/Ti+CneK+qRE7en9MGLKTzmGxSu1WYpxtyqb0UgjHj7TOs+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6882

On Mon, Sep 08, 2025 at 12:10:43PM +0100, Lorenzo Stoakes wrote:
> resctl uses remap_pfn_range(), but holds a mutex over the
> operation. Therefore, establish the mutex in mmap_prepare(), release it in
> mmap_complete() and release it in mmap_abort() should the operation fail.

The mutex can't do anything relative to remap_pfn, no reason to hold it.

> @@ -1053,15 +1087,11 @@ static int pseudo_lock_dev_mmap(struct file *filp, struct vm_area_struct *vma)
>  		return -ENOSPC;
>  	}
>  
> -	memset(plr->kmem + off, 0, vsize);
> +	/* No CoW allowed so don't need to specify pfn. */
> +	remap_pfn_range_prepare(desc, 0);

This would be a good place to make a more generic helper..

 ret = remap_pfn_no_cow(desc, phys);

And it can consistently check for !shared internally.

Store phys in the desc and use common code to trigger the PTE population
during complete.

Jason

