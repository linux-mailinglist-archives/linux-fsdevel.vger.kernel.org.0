Return-Path: <linux-fsdevel+bounces-60562-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B32BB4938F
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Sep 2025 17:34:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1F6AD7AF0D1
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Sep 2025 15:32:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A18BC30DD02;
	Mon,  8 Sep 2025 15:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Et3lA6Eh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2051.outbound.protection.outlook.com [40.107.220.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76B0A10E0;
	Mon,  8 Sep 2025 15:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757345632; cv=fail; b=UWPuYWF5qkJxJ/qlhJiMFMD7g7GaQXLyDw586+sk1tb4J+K2Zp1SPIUn7lod9Y02jU+o5Zly1/tw4b4D/TIqHI6vfJG91ipAlvD//stJb+1JhHrhBbcHE/qfmU59k3zBhHSM+QFQyCwz0UgpUoucU938AFsljqbqrZXkIMa5NOk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757345632; c=relaxed/simple;
	bh=Z0v3kqlDjGIBLTG9BZ6p/uzgL1duvrqw7n4tCx+DqPw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=KAqGKafcdKtR2PZC43xeyCsGM5zcpu299xeGD1U6Ut7i8gUhg6Dho3wU8EaWyJVcv9lnBPL90mNzYaEPpwUEg4ugas7DSEyjQugFlCBNxrn+gAx11egnXPFN3XhLVbMub2zIXaZUdRXoGqciLJWAMrAxkiKpJPrTGxpRW3r7YgA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Et3lA6Eh; arc=fail smtp.client-ip=40.107.220.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wvGqU+BlIi6TgiOfXrZA5qvBdkOrGjc+tEuk04zdBm6nBG18ws7Vk6ktUzD4pEk41s+wTcOE3LnF4jtXaagCFqARU1/hsexW+mXxqfCcCvPqaW7Y+9MARQzKnYJzQ8RTAyZwmy/7g6xvOB0opgnYhqStScEif4lfbj2zKZvO7g8fbH7/L07C3YePVfenhj08VPS7tDvBbKumKXt4z1zQ74xJ5oXsJfhIR1V9lUKqr1wV+IN5CPNfcBFU7t7gnr/A6eB2aAJcvx9YKx5P1EvIaMM7aUOgxLyfo8UcpgWA/Hw/TOpVU61RvAqtCil5ikPS6lGlgme5Kb8whm6jKTansA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cl8F1qd2eBFExcsp+ZyEpNuRqUubzW5u4nbEAXt8sPM=;
 b=IALElEGBCngR87plE1ERFwvhGhqhx6x51tLSYuKqbzVBCl+5g2XZn/6pZgf0963zZW82KMgRLBRzLjsKGgZMEi8d9OexP0HZpNg++c2jhZN7jeAaFdfF4my9ahS31Mt6OFcwk/F3Md9qEgQFSNflH2EkpllR83tXp0q+wGY7IRNE2+13J6eGf9BChW6XR9dBT286vuNf5KIo1RIc7z/aQgqIgQhxpr4RThBIpo0n7KtRiB+1SFoT9VyJ+xbQhHEFyso/Y8tMb2uVb+kMUXRbFQ/pkwY9x4OdJokx69NsJY2ZEv0ClUCWKC8vLherNZ0DwAbeAemX/6XsJti2z5yzjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cl8F1qd2eBFExcsp+ZyEpNuRqUubzW5u4nbEAXt8sPM=;
 b=Et3lA6EhhJqml5sP4xflmPTB1PwGGkEEJqJ/OpdKo9p4Mnh8woel8O+VqEqvu/yXE0Tqo8XkngBszYSA+uw+VHroMg5xNFtUxDcPuhY/ou0mLH9Z/wnhhh5GKmEHp9ZgAAkiA/qVbbIqfX/yunSNcTq/6G1IYNDrXraoe6+R9FBKBlMiKboUM5jdh04Z3xwDbVLASBEARTnmihugVOZfx+qFAUXQ4IihwvlMWp89P9CMpPAyjD0F6gLwqzMuBAfpceXW/thLTOO0yMKZ0o9S2eAGp1wiDTqsU82Bmsl5OhhLJKFWzhPIIFqIdmTozp5cPQHDEZBfqGWR1z7Tvs+Jig==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL1PR12MB5753.namprd12.prod.outlook.com (2603:10b6:208:390::15)
 by DS0PR12MB9037.namprd12.prod.outlook.com (2603:10b6:8:f1::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Mon, 8 Sep
 2025 15:33:45 +0000
Received: from BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::81e6:908a:a59b:87e2]) by BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::81e6:908a:a59b:87e2%6]) with mapi id 15.20.9094.018; Mon, 8 Sep 2025
 15:33:45 +0000
Date: Mon, 8 Sep 2025 12:33:42 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: David Hildenbrand <david@redhat.com>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Andrew Morton <akpm@linux-foundation.org>,
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
Message-ID: <20250908153342.GA789684@nvidia.com>
References: <cover.1757329751.git.lorenzo.stoakes@oracle.com>
 <d8767cda1afd04133e841a819bcedf1e8dda4436.1757329751.git.lorenzo.stoakes@oracle.com>
 <20250908125101.GX616306@nvidia.com>
 <e71b7763-4a62-4709-9969-8579bdcff595@lucifer.local>
 <20250908133224.GE616306@nvidia.com>
 <090675bd-cb18-4148-967b-52cca452e07b@lucifer.local>
 <20250908142011.GK616306@nvidia.com>
 <764d413a-43a3-4be2-99c4-616cd8cd3998@lucifer.local>
 <20250908151637.GM616306@nvidia.com>
 <8edb13fc-e58d-4480-8c94-c321da0f4d8e@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8edb13fc-e58d-4480-8c94-c321da0f4d8e@redhat.com>
X-ClientProxiedBy: YT3PR01CA0142.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:83::24) To BL1PR12MB5753.namprd12.prod.outlook.com
 (2603:10b6:208:390::15)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5753:EE_|DS0PR12MB9037:EE_
X-MS-Office365-Filtering-Correlation-Id: 62293ab1-18b2-4527-71e4-08ddeeed1846
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?OfexwaZ1qAXecR/I9MLGdg+4q3gY2zPAE7wUIBRgqoVULJIOAJdVY8yZjeM+?=
 =?us-ascii?Q?jyrER12D3LiUfbmGsRezeWFo06VZG+uCEdBegdcrFDsUxkS7N0C2gUBXadIw?=
 =?us-ascii?Q?FOnRnNaTph6Ygk5sFDh9Kqmc/hzSTTea8+918uwfYznUZZ5sHjGOnjkJLYV3?=
 =?us-ascii?Q?D7XDYE2hV+FXdal/j84uVw1ApcWHVIz4x2pP1p8Q4AEEw860HmGK/H4u4RHM?=
 =?us-ascii?Q?AvOQkl61kadumqVLe8nClFL3Mnj+UE3e5T+taODMixBLuwpUhB1c1QK2+YsD?=
 =?us-ascii?Q?JB/abcEQnAjJVY+gCZFgMHjYj37X+NG18UzY+4XX0XdX71KcB/NIt32eQNMw?=
 =?us-ascii?Q?3fCjo0xHzriCSYq0lYd9h8BamGLM/tSN3onTW0PxkiCpiBH8eo3Wm7DlxTMZ?=
 =?us-ascii?Q?CbVbDOfOrO5U8HH4zJeIzlPClmQMJLhvlFCbGtaTiSkav3gMSeS1k9AQ0PHZ?=
 =?us-ascii?Q?mSNUSWrR0UAmhVPJOg0onuMHlscG9X5sl7//sG7t6DEdSS4UKQU+Lzf15F7X?=
 =?us-ascii?Q?8o6OoZFc5exe+tv/dlOdb4dNaVRVEb+uOEeQw1gazyHwbk4A8OELrIeYxqYb?=
 =?us-ascii?Q?C3y7le/+QeTWCEzCD2msSVBrcXK8Jajv4bBAHeTykQmJmjVtuXmoDlOWcraK?=
 =?us-ascii?Q?DPE8fTnH8S4jQ5kZ/WqiyNfGuIuRonaAJA+N7dRVDfTA/MiZGaY5PQa61ySZ?=
 =?us-ascii?Q?P13eTuPjGhdiiUpR5vwet73M5zBD79KPNlbqTNuU1FP1/zIGQFc8a5c+qHcO?=
 =?us-ascii?Q?K1NbgHbi1B4SEwhKxTPZNMrV9czp1+BS6gJg9mpWsXoATuOH0ppRwAGAwcs+?=
 =?us-ascii?Q?/g0XgzDZdk8cHszF+jFLFv8u7MSYsWvmf8X0gIehj5/UxjFJMeoHEfsMyqR7?=
 =?us-ascii?Q?fjoKl1XqHrW3cQCIh1JJ/SjO33s5XxrMGfVNFXbJvefYdgAOvoMgizIQTwbv?=
 =?us-ascii?Q?yIFaW+/y0luabjAU5dzdgT4rndx8/DA+MEJTCFX2A70Z5vSqRMIQXzqWwsGl?=
 =?us-ascii?Q?/3nbp8eQQ9MbsCrpmUlt3Moq0j8Lp10o0OPnIEcmNkmNzMWT4DbAgoBpGIJJ?=
 =?us-ascii?Q?OO8OFY1zfLe+voh5cBUYnC2EITxj9DN+W32i9GL04CDh9aCFbrAlGL4Em2da?=
 =?us-ascii?Q?ByBcHKVsgvoeMIn+BwqiWArZwomllVXQZ60PA7rbc71oL33GAKUXJVElLQxx?=
 =?us-ascii?Q?KTExEgybB94AhbXfkExbTKvrTj5/0Y3fZIv/oMzR6VMS9vyNlUSNLRcCqvA6?=
 =?us-ascii?Q?pADpHHN+04pwULc7dGjGI8yLZVSxDNTsikprHE2MKjpw/eNqqRvYx8Kn3re+?=
 =?us-ascii?Q?8Qp260pkoOSAqzFhqzapbAnEYE2l8gZCiGDpOlwLkNh6GDvgcq+DUVKhVrcN?=
 =?us-ascii?Q?43iwktF0Di8pKMuxhrpjDds9ruST7YJKYo36dxo3KTYw5M4+16bMDQFQgP6X?=
 =?us-ascii?Q?s9QFP+fm9XU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5753.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?NWYPb0XDGZP9lV/DXB4iYGnO5mF72swH0ERSUad4Do8YqCu/hcDyn7OY6JNf?=
 =?us-ascii?Q?6gEAQmDowMY/HDpKuvEFLxhRIFWbDDSsFlmn/HAHjSqMd3E0IfiWfAWQN9yC?=
 =?us-ascii?Q?CMN57SnFTFoM1mCtvMJk09S0MV4fho1EgML4X88DvvysExcb/YTUBrBHR5wr?=
 =?us-ascii?Q?3Uk9+mBEtqpodHZzUxXjIhKFOiaC0xZsQoOxq6XfB6dIJBqQ5Jem8BZslr98?=
 =?us-ascii?Q?YkwnNWeBtlEUc6tOYjyKIZEgKixneimM/7WjGd3BF1AE4aGzx1NhQabBsKSH?=
 =?us-ascii?Q?9zmLSM33X5mj0wspSEjqoW7ZSCtm+KcGR7f8mvFj6ACArXctZCFHlHhBQeoh?=
 =?us-ascii?Q?3krknZ15OKhxYQLotsZIIDVENbmauzrrF3R6Wj0oyD32CwiwhBxZdxTcDeYW?=
 =?us-ascii?Q?y97glatPlqS7ndsHKC8Sa1L0XlLekVahLX9YboPesWQ303KDHqtWSOWaWO00?=
 =?us-ascii?Q?xBOkcPVdXiGrd3E7eHRcLvGjzSLZukuEvwLE6zkQEcQ3GyFdr+0Vmjq8HwYO?=
 =?us-ascii?Q?KqZisxViIjiBLrASS+sTGTBJQGS54KdjkppGQEBWgEf+77kRSkA296hmOZUR?=
 =?us-ascii?Q?uZuNhpErA+8wxE5bwv1eTVVIrGQUkXgDVsz5f5NDwIDEYhqqPkU4UgWxaNiq?=
 =?us-ascii?Q?xvpyyTGo+VUXJKmaBkjxi/pYh8butaPuC0YvLD1pX1QgBr3GDWsapgyRV+1n?=
 =?us-ascii?Q?Ls0/rI/GxPJT/xidBA2ZfaQnSHGNSEoH7+vO3v8ve89PeXRzhg+Lsywk7iN1?=
 =?us-ascii?Q?wqRmcH2FNctSvXhOS19HEYMK47uNooG0UmC5r1XdZ9KsoT8fU8ONkOmQtGfA?=
 =?us-ascii?Q?wHSo0mHRh8y11oCnbTqTJ+VD5roayv40Rh6AMMd0pXMFJwZIW8moMaidbqTO?=
 =?us-ascii?Q?I8Ft/Cj1Hq2zG4k0yW2P3bFXctXcB1swqwyyH2wTqN6ZxJyaywk/BlBZGLYT?=
 =?us-ascii?Q?Q1NVme2eovr91f3zaJOH9SWX2bBJKcuwft982p7JCtmzVDGA9wsOO4adx0Hh?=
 =?us-ascii?Q?Liz4hDFUnjZuwWEwzwZD0MukqeJI6WZEYnrSpz6UdT5gXy0U15XmVWW4TB8x?=
 =?us-ascii?Q?f8yhnMoJ27Ed9Px64RK9pyehnXXjtxUGPq5qArUj/czhAl8MBzvFXojwSdlg?=
 =?us-ascii?Q?xVViCk1Yco3OeTST/ude6F7jXaOiLXjFn7UpKSo42UoGvKD49EhFCs4BXuDk?=
 =?us-ascii?Q?jhX0o0Jwu4NqybM6HKJENAZGiEXOBhfaYcDFvbjJ/kdIJSgx+kT+MZgWKk94?=
 =?us-ascii?Q?TbfjMDIhIlJE3DRFWs4Ae+p94ZCjjv3BFMCGUFHYQjl4a+h7p9mUyUly++/4?=
 =?us-ascii?Q?ZfKqZ7duFQHPitp4OHDsRW2YupmSYGqgLcE2tJ/iT/wZlbNc2LNM0Iq8hJPQ?=
 =?us-ascii?Q?DVtro54lMO0mRNnuC9dU97AU1yxkKTdXr/ASYx4MmHHrEnXxn+5p0AGfeO+n?=
 =?us-ascii?Q?sm4JJD2PNPXxu081S1KLgKUSRb/qAUS3hpTQ5zJp1HYojUdoD8TmyCPW7/6D?=
 =?us-ascii?Q?VetFcj7CVUkoySXFF4dSeQIyT0ybif5TMOVms9EGZ+g9E8sLpzWNqM4af0jf?=
 =?us-ascii?Q?HHeBEckKoI7EOAvRG1w=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62293ab1-18b2-4527-71e4-08ddeeed1846
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5753.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2025 15:33:44.7583
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A/yAki0ZFGGvcHRFOXm2BAGkF8f5EtB04iNvaJOcWQD16qm11k1FiOzD1sppt2QH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9037

On Mon, Sep 08, 2025 at 05:24:23PM +0200, David Hildenbrand wrote:
> > 
> > > I think we need to be cautious of scope here :) I don't want to
> > > accidentally break things this way.
> > 
> > IMHO it is worth doing when you get into more driver places it is far
> > more obvious why the VM_SHARED is being checked.
> > 
> > > OK I think a sensible way forward - How about I add desc_is_cowable() or
> > > vma_desc_cowable() and only set this if I'm confident it's correct?
> > 
> > I'm thinking to call it vma_desc_never_cowable() as that is much much
> > clear what the purpose is.
> 
> Secretmem wants no private mappings. So we should check exactly that, not
> whether we might have a cow mapping.

secretmem is checking shared for a different reason than many other places..

Jason

