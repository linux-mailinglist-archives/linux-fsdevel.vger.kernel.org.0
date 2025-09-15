Return-Path: <linux-fsdevel+bounces-61422-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 96924B57F21
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Sep 2025 16:35:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2105E1882618
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Sep 2025 14:35:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4B7F3375AA;
	Mon, 15 Sep 2025 14:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="BgSdNvPI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011029.outbound.protection.outlook.com [40.93.194.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33E7B314A8E;
	Mon, 15 Sep 2025 14:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757946867; cv=fail; b=ZSgIBlZao6Fsmd10M/TeTkmsyt5F/v1nPYyr0F66G3hNen4NL3OuXB3pBV2Ihsqhu+WFptImUXZbF09JDhQ7vzkMIgENT7QMxMhqBri1kxfz0YTQWosZQOMx9b2yazHLOngopf9IlV5oactKgFgQQg+eID92d12EVxoVci45ICg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757946867; c=relaxed/simple;
	bh=p/VZON1NvfsTPde7pO7AHEoThUNWOp+t4sTO8PHmT6M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=dnVyTwzTjZeUe1F114hOibDXgVHNtPxMTasBUd5xW/EmQBsEc+0R6dmqcthStH/RE5K79aGLEO369YHRIIhEYsad23LDQAKKf2ArBPeEUWOQUrta366egYdZEt9HEacDsAEZjn0iCx2zvB1bNp9utguAh/Qu2DUplteTpy39Oew=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=BgSdNvPI; arc=fail smtp.client-ip=40.93.194.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w/q1kqg7d7ctFBI/zK9lLnqh8AjDLmCNsuY5LQOet/RvaSn4blhi2b7gt3jNR8telINzeNVD5Q64QY5Hp+3o6QTVfu5K7x2y52jdT+eiqeA/ieRTpPOgFSpxwOjqioztXZGQ9EVRC3SMuRb03fn/d6hPpkABnNQ5ChGJfgu52dsOc5gXc76VcTeT9XQ48sl+cEB1b3CJG0kSOq7FSFLZTjyREvvWJlDnPu5B6BC7xqPGiCDoC6QEogZ0jKsOZ2/jcPoBrwPC3z6w85SvriUtO5FvKoojs8oqjhO4q0CJHGxZR5ycjdN3qBh2ioRJ0tvHPnKb7/GS+tH3WMkFrhc7UA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w2OLPJGQr7Z+rVWzl8laX+IkMurJZ2I4ncppuXQbRPY=;
 b=KhqKhJ/3Cde1vw4E30jBiU46PfZ02BAj7ciN1A2+XwueIqb4ls4ZsZLqX8XVtUP0EsuCD+1Ztwko3YyWggx3n7sl20hjpXv0c1Y++oLcfwIEQvFuFlDrsuFi6iJr5bMXpaZ1LxflgC4OA8YP8ocuMJ/B70fUZKxSNWU0/vVHx+sc9+5UHxLrDL44oTYWfebT8W83vdisqtqRpImtsmjRFoPXX1TSUSmU92/jALVRNsK2Mi83LB87uTw8qPe5qT5tYeQ9rfyU0pBzaf31KmhoEVtz3PHrPFEsRy1awYfkndoAwL4cOX/ek3kBDFiflOXeEwh7zIoCtK+KTNFtdzMK0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w2OLPJGQr7Z+rVWzl8laX+IkMurJZ2I4ncppuXQbRPY=;
 b=BgSdNvPIN7Dtg7t4BYb6qqLQ2Dz1h7alCFqsxGx2ef8kgSI48cPDlEDn+AFW3SDDGrOMJbQtcjIyPieRsxmbITgisfoTWm7gSsidLNk5hqaASkd0jQ8bJO0iJc+CnXsHQ6cJO2OmqKA0pSulkvPJJKE9IWWjBNCgrkwRkVsjthl4cmwMSx6IW1mn7IwSnKGSPwtieGk2iT53BPNDJB9I2TsYdXGmaj/Mhk5LVoaMhjOcYyAFNK8L+BXEP95Pwb2lYTGSbgQN52Z7jxu2IlLOfowUN6LVoIGQ/xvjWXaqrIYL26b45zaNApGh3o6mHwTenSWSM7Ye67VVWPbcHkGTHw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH7PR12MB5757.namprd12.prod.outlook.com (2603:10b6:510:1d0::13)
 by MW4PR12MB7213.namprd12.prod.outlook.com (2603:10b6:303:22a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.22; Mon, 15 Sep
 2025 14:34:18 +0000
Received: from PH7PR12MB5757.namprd12.prod.outlook.com
 ([fe80::f012:300c:6bf4:7632]) by PH7PR12MB5757.namprd12.prod.outlook.com
 ([fe80::f012:300c:6bf4:7632%2]) with mapi id 15.20.9115.020; Mon, 15 Sep 2025
 14:34:17 +0000
Date: Mon, 15 Sep 2025 11:34:14 -0300
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
Subject: Re: [PATCH v2 08/16] mm: add ability to take further action in
 vm_area_desc
Message-ID: <20250915143414.GJ1024672@nvidia.com>
References: <cover.1757534913.git.lorenzo.stoakes@oracle.com>
 <d85cc08dd7c5f0a4d5a3c5a5a1b75556461392a1.1757534913.git.lorenzo.stoakes@oracle.com>
 <20250915121112.GC1024672@nvidia.com>
 <77bbbfe8-871f-4bb3-ae8d-84dd328a1f7c@lucifer.local>
 <20250915124259.GF1024672@nvidia.com>
 <5be340e8-353a-4cde-8770-136a515f326a@lucifer.local>
 <20250915131142.GI1024672@nvidia.com>
 <c9c576db-a8d6-4a69-a7f6-2de4ab11390b@lucifer.local>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c9c576db-a8d6-4a69-a7f6-2de4ab11390b@lucifer.local>
X-ClientProxiedBy: BYAPR01CA0022.prod.exchangelabs.com (2603:10b6:a02:80::35)
 To PH7PR12MB5757.namprd12.prod.outlook.com (2603:10b6:510:1d0::13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5757:EE_|MW4PR12MB7213:EE_
X-MS-Office365-Filtering-Correlation-Id: c2eb574c-df41-4d7d-a0bb-08ddf464f360
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?J0fgzA3EZhDGT7KbfP8CmsywsIxKJJVvO2ZE9bGNw3Q/f2nhzl/evKYMDZ0K?=
 =?us-ascii?Q?5oDGq400RO1n/B4DIouUv+J4gk9rvdKMyDNUqnkctgYHpW99au5EiX6svH+Z?=
 =?us-ascii?Q?X6uwd6GedpE8y1sOxbU4hG5Nv/g+p59WJ6Ran3+HbKtLMqVEvwtyHprkup0G?=
 =?us-ascii?Q?L4hH4SsCITv12/C9g4PdZhsmAji95/qjColkRsM2hUZNcKBHMxfkkj89ofJI?=
 =?us-ascii?Q?BAk8wTkiUWz4TF4cm55a5WkPz65eU3JmNfiGqHm7Ie6iODS9oIXhdZZxlG5u?=
 =?us-ascii?Q?aYiIQi5B3oNBG7KqLH3mvUN+6lljkbkRS8+VyFSq6BD96wW/pz2bNEHtEByS?=
 =?us-ascii?Q?2IUJ3Y/0/TImRFH8gikcmCD/y27a4gt0lMV45CdXbEKblstTG/X5LDzCWans?=
 =?us-ascii?Q?/F8uJzs9ufYM78XE5d5boAE7SKf6XNnfhKbecpT2W26Vt3a6alHZa5ICx5E4?=
 =?us-ascii?Q?xzHyQOE2gfDOnsPUxAfWAxNvBC0o7MtC+IYvUH0FyYL9KAJbnHRbstlZB7cr?=
 =?us-ascii?Q?Jjs7YZDDkI/xNfdMJvrmmHt/o86+FQnST283wiqbSfX3dRkDRgTCQ9Xl0M63?=
 =?us-ascii?Q?PRMDFEKDk2tvjR2mz9DGcnazhNvWeKbCM5LKImHz5JlTI5xSZJtFMn5+m4El?=
 =?us-ascii?Q?7sIx5mEr1Bpobz0gG+uLmHdKKcb2JkZu7oiSxb4/n78KO66FM2lPOU8CJtWF?=
 =?us-ascii?Q?wDS7Q8mJcbnjDqK3xQIXrzcYOPD8O7WIuwYqAqgviK6xgvALVHqx75G1Few8?=
 =?us-ascii?Q?rQiqCbGcx2dkLpq/qe3fYjLOpK/6b4NzPiOhY26QfAff45JG6G28UfKYAMcW?=
 =?us-ascii?Q?8l7A13LMzBYtjaDC0YpLPjSz+lsxZTSGl8iewfhhfNhGfBHVdA21zCE5vnhT?=
 =?us-ascii?Q?Ljm9CHsLmRxWdomaXeAdsx6pWOWhDSZyjuKWEF12MF90x4T+P+wtO+OZ7IlR?=
 =?us-ascii?Q?ZaMe7qbwpQRUQwhUMgmd6ErDjx6w03zI1csGM4yprl48xZzNtbBH35bK+yzi?=
 =?us-ascii?Q?MQjh4qyyNFbJEp17TeB7iDsHAGf235EeH7s4Fo5gMA6Xzl9gotrzBmcfeoWI?=
 =?us-ascii?Q?d4BcoqdWbK7T5ni2GcLxr3sRrGgFHwtKDEFlsQcBAKRjxxzgvBKAg0GJYcHY?=
 =?us-ascii?Q?fgseRh15/pzRbUEbkrFuXIskr0rf46kEKCd3Wqum46yrLhS4YDYrxx0vKtKk?=
 =?us-ascii?Q?8D5KLnBbMg5wS509/16GtdXZU3zrajZQSVUyk1yTa88QfhiymthLKulNK6YP?=
 =?us-ascii?Q?nKHC2Rv888t6e9cDLWt1WyeYxvVRV1JS/McPEaM8Lt0yzmmFblaYJdga139e?=
 =?us-ascii?Q?9mHbKduwb3Ro7ZZG5+9eN4XyKZAjYhQTWX6M21UWOe71yCDc6cSfNkZ4qz/4?=
 =?us-ascii?Q?lqmhEBGn49dYQWg66wddSl1nQ2l3Iv5HYESMjyWRUW7dKyNWzL7h2cmM5Vyi?=
 =?us-ascii?Q?KQeg+Aew84U=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5757.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/3WCFB0Gi/gwIic4Rv8tIjZqRx6Q/sGGJ5Qm6p67L9OhcuF316JvcdNoB0Zv?=
 =?us-ascii?Q?C4rLP8tZo0Jhy8UwiUyPDPS7BnokeqAXJ/PRnjNP3+hX1qeo6sCD9FC3CpM2?=
 =?us-ascii?Q?lP0SbNpOWvv3F4+X0wGNvsgm9WloWB4XWrgLMV9mtdLZyYcWG+duAsKP8wFI?=
 =?us-ascii?Q?dEc/3gdTdbNS9kqicJkAs3lDbeRg+rg5NIzKbIdCyJgGqHoVoSKMjr8rWx9h?=
 =?us-ascii?Q?savJcpcNanRKORwcB9+U96gwqpPNn7ctMESLs0RRkrwN/ALoV2pKy4XsUb0f?=
 =?us-ascii?Q?T4Xk91N/HsF4dfymJrT4PyRyMCB7IaGvkBJO+x83RAKTcpV+nZSrJSu8y1Xu?=
 =?us-ascii?Q?oA34OR2fZvbJav/qyShK+/wD0wD3Rox6c216DButK3DWll7puwEJQBX2UHBm?=
 =?us-ascii?Q?xy1kulgBJNXrO9w6r5hIh5xbnjN3zmv0g2i3TaIAr0a0RlUawSmHmR6Y4hoN?=
 =?us-ascii?Q?g1enrb0Gd2w8L5ZIP7RXCyQl+yExNJPY3P5/QsiXEsFBx5W7qpCP9y3LJ6CI?=
 =?us-ascii?Q?O2ftPOJfJfEPE6ncAOlz+d9ngPfbjh4+GxkKQr3J7Em4DBnfrJL/c5zY1LPf?=
 =?us-ascii?Q?wstDSaLl6ZK7aD+Qe4obdZqaznmxQ7AQ26BfYny7Z2pCD7eKqJE9V8+1y7jo?=
 =?us-ascii?Q?Cy2X7f7Pe2sm/ZXZpXICyNwkI7bXGFqEUmsLiPL7BWWsyRaL4Bf8pMJh6UDj?=
 =?us-ascii?Q?AU8XvlcclK81GLsEsoZhuA4KeU4cFYOwOg9o9U2Y1IuK+Rfjts1f/c92dE3f?=
 =?us-ascii?Q?d+oUeiwc3iveRXZ4sm9Fl0lZ1KnG+iP2N75Ii6pfm/fA1OIJ4JsLBjdCRdcG?=
 =?us-ascii?Q?tlkz8EweM9xQAeMIKRakoGxS2exPncZ6UU7dwPgOKQoSQ6r6Y7IEBh5tCbsr?=
 =?us-ascii?Q?OVxfiRdOfUpoRjdjF/6SJzNHzixxcULmWxRV8f9xWVaGlazPw1MCSWs+a8tx?=
 =?us-ascii?Q?C8utKH/bDXbwFMPDzOtIASwW8grrNTjCe5ipBnPeZAB6+cY2SG+UHwAVD84b?=
 =?us-ascii?Q?XuGxXURuPgV6GP3wsTBB5USxJWh39uQwlNiaSxpq4nIecECuWz6UoOlfwJ/Y?=
 =?us-ascii?Q?1uCAkNFM4T01plaUWjz5dyVTn6Uj9FlOSOBPfgcAeLOLXQVbiSOAq63qnwsB?=
 =?us-ascii?Q?oN5O2V+T2MRIG7mC1v6i/s0fytTnG1Pn5fhbiHWexGPUvwTbVlmbD36rAH2u?=
 =?us-ascii?Q?wm0dzulxmi5et3HAL8onV1W53DQgx6+ZXQmHL5Edzlu50Co6Jeim89hRgIcz?=
 =?us-ascii?Q?heZwAjVS+ewdGlAPwMNE12Ar1BV3lgNM72AUEdUQpQ3X4aTVgzY7wiDgfbJi?=
 =?us-ascii?Q?L1mUfEZZ7CXQ0NjiB827RFrbkh0cS5LhQoby/BjaqVACOluDAyqqfUrNAUQK?=
 =?us-ascii?Q?xIJpxn5F510cl3gnQlF13EGu1jv8pEf+z6kx5FTo73xPnFax/j/DqCVgwg66?=
 =?us-ascii?Q?IVIRidoFiaTrNbC03o8TnbL8GRQG/z9nG0KBfPLmWSCnnFRsHiH8/G91GYwX?=
 =?us-ascii?Q?TAg71dOv4QB9gZO9cHVntZSZaY110H3x5jEgMhes/qNmJNULMOUuvkh/CFBS?=
 =?us-ascii?Q?yMQ0+MSGOlIIItLUz6RTrAm+k+dvHmwygFweqt2B?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2eb574c-df41-4d7d-a0bb-08ddf464f360
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5757.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2025 14:34:17.5723
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nuekJOcIltSv64PXnhJ9nduz2Ux8IGU0sDYcCkCUw4OJvfDQhyOvEIyOeWPaznQR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7213

On Mon, Sep 15, 2025 at 02:51:52PM +0100, Lorenzo Stoakes wrote:
> > vmcore is a true MIXEDMAP, it isn't doing two actions. These mixedmap
> > helpers just aren't good for what mixedmap needs.. Mixed map need a
> > list of physical pfns with a bit indicating if they are "special" or
> > not. If you do it with a callback or a kmalloc allocation it doesn't
> > matter.
> 
> Well it's a mix of actions to accomodate PFNs and normal pages as
> implemented via a custom hook that can invoke each.

No it's not a mix of actions. The mixedmap helpers are just
wrong for actual mixedmap usage:

+static inline void mmap_action_remap(struct mmap_action *action,
+		unsigned long addr, unsigned long pfn, unsigned long size,
+		pgprot_t pgprot)
+
+static inline void mmap_action_mixedmap(struct mmap_action *action,
+		unsigned long addr, unsigned long pfn, unsigned long num_pages)

Mixed map is a list of PFNs and a flag if the PFN is special or
not. That's what makes mixed map different from the other mapping
cases.

One action per VMA, and mixed map is handled by supporting the above
lis tin some way.

> > I think this series should drop the mixedmem stuff, it is the most
> > complicated action type. A vmalloc_user action is better for kcov.
> 
> Fine, I mean if we could find a way to explicitly just give a list of stuff
> to map that'd be _great_ vs. having a custom hook.

You already proposed to allocate memory to hold an array, I suggested
to have a per-range callback. Either could work as an API for
mixedmap.

> So maybe I should drop the vmalloc_user() bits too and make this a
> remap-only change...

Sure
 
> But I don't want to tackle _all_ remap cases here.

Due 4-5 or something to show the API is working. Things like my remark
to have a better helper that does whole-vma only should show up more
clearly with a few more conversions.

It is generally a good idea when doing these reworks to look across
all the use cases patterns and try to simplify them. This is why a
series per pattern is a good idea because you are saying you found a
pattern, and here are N examples of the pattern to prove it.

Eg if a huge number of drivers are just mmaping a linear range of
memory with a fixed pgoff then a helper to support exactly that
pattern with minimal driver code should be developed.

Like below, apparently vmalloc_user() is already a pattern and already
has a simplifying safe helper.

> Anyway maybe if I simplify there's still a shot at this landing in time...

Simplify is always good to help things get merged :)
 
> > Eg there are not that many places calling vmalloc_user(), a single
> > series could convert alot of them.
> >
> > If you did it this way we'd discover that there are already
> > helpers for vmalloc_user():
> >
> > 	return remap_vmalloc_range(vma, mdev_state->memblk, 0);
> >
> > And kcov looks buggy to not be using it already. The above gets the
> > VMA type right and doesn't force mixedmap :)
> 
> Right, I mean maybe.

Maybe send out a single patch to change kcov to remap_vmalloc_range()
for this cycle? Answer the maybe?

Jason

