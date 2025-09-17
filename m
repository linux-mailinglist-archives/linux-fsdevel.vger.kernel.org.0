Return-Path: <linux-fsdevel+bounces-62027-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC164B81EC8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Sep 2025 23:20:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91B4F3BC300
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Sep 2025 21:20:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E5CA2F6581;
	Wed, 17 Sep 2025 21:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="hK+Q6egU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010049.outbound.protection.outlook.com [52.101.201.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41B4C243371;
	Wed, 17 Sep 2025 21:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758143992; cv=fail; b=sq8xr4Mz8a19vNV5YpMd0Y/XJ4rvz96W4Pl4402QRsHOhwQwNrEbTGdnV6u0TS21N3TWlQcAdiowxrJ7smYsWHdz2PJ9h0y2T4w4r7fGAPf2XsLxaD2zaT0A63/C0XewUfx9v5vmacBVhVAi2XxdIy3oCNhNe0XJUWcDV63R4Xc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758143992; c=relaxed/simple;
	bh=UP9gP6m7wjA8Rf0c497fli6oMB6xG5HK9NCjemE6V74=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=hprM0Rb1W4w/yYbn5/M33WUqbOFPEK+HtZkVyd+oGhAN4LodR/oafljK9QZkP9hJxp5odzBFjMaA9WVsB2ldEE7sJ3JN/QZWMt8qpG3eb/7t1JAll37sfv1YM63PtLvOoLf7Ja2LA2oiYcGfRdt6y9mUhQnxK8DBnZS4+3qIjjw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=hK+Q6egU; arc=fail smtp.client-ip=52.101.201.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cbucwQ6p156jMPx3ciQbekiQrvQ+Z+dL3RrcmkhzT5c87F3RYgQFUZkt3hCP0FOYPqwBxitOVd6ipdZZdJhPQq+Dr1YLVHAdkei7f/oBbXWRLQ7uidK0A/baDUcTlp6e0GwktHIBCzO2ZTq5Oz6k4LU4Ds2Zv77M+PNbQxW21g0He//8s+jXgMYXAEb/O0IZ31mfGmho9A5ltIykU+va4QBx4lRcMjkFuqDRtC6YKlQUlPFdxPXoMzvxjxyvtyLZpCJYPCwwmhh/KZYCwAc/LFGtXawqtF8bKGIJqQb5iZ2vX7QqLoxUMP5PuUNW/VYgbLVK3iSUoirsFS0MOBUXeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ivO8ZyXjhrVFUoG23WcAc0qIXAzKjaT+w+I3vSe6Xts=;
 b=qdwk1DA90F4WE72J1gmkHq+NggjzZJjHWFSiuBUDqTEZgxKSTlYreoyc8eVITSlYLkBONMUB6nnYn+sCj01IH4M26ItbQ4p1/dhQdyV0KLMaCsllwpGiOjRk7zyWkY6+5zALtMVwvBojMfgfLiCoAOgSLJPFmrQJcKj6VjUBu9b5qLkrvqCubN0bli63djto+OiWtSsFG5q9jbsGobLvp6XYNQQY6g9ZlcTF7KV3wQfOJj8e2XEVEjTMVLw3MVNMsYw1yZUUEsnbJ9fEfeLhC4dgTUWn+BSs/ZXdFe5bwKrJvm/FcapByTBl+9vALiI309df1kZWLmHTWuyUFJvv6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ivO8ZyXjhrVFUoG23WcAc0qIXAzKjaT+w+I3vSe6Xts=;
 b=hK+Q6egUpXcQxj8k/004GSxfuZZWqeymleabMpEZHw3FTOWN0YshQrI6Rkxg8xxDW4EAOtJmjh1k5A48NhEfI4btDPDRM/nO91a0tpPTk7C78vGcEJ15Btd5Q0rInzlvNkYBIeTw//Ln8er7xTNVezIuNf7z/udrGja8AHOn7TU1sKJsR/Snwy6PMsKi2DmjTrA06U2piswwt3TvZW7qiRQtDQ+W6JpMAGOQtC/lFYuW/jVQlUmBXyJD2bgbwYyu46+erWMBIqfOF0P888MgZrPrTwTS9KN1H9CXM0cVO44ZqEUUccqSWiOSWH1hHx+pwNamL0vUkoGBssnBowC5Vw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH7PR12MB5757.namprd12.prod.outlook.com (2603:10b6:510:1d0::13)
 by DM4PR12MB6376.namprd12.prod.outlook.com (2603:10b6:8:a0::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.23; Wed, 17 Sep
 2025 21:19:47 +0000
Received: from PH7PR12MB5757.namprd12.prod.outlook.com
 ([fe80::f012:300c:6bf4:7632]) by PH7PR12MB5757.namprd12.prod.outlook.com
 ([fe80::f012:300c:6bf4:7632%2]) with mapi id 15.20.9115.022; Wed, 17 Sep 2025
 21:19:47 +0000
Date: Wed, 17 Sep 2025 18:19:44 -0300
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
Subject: Re: [PATCH v4 07/14] mm: abstract io_remap_pfn_range() based on PFN
Message-ID: <20250917211944.GF1391379@nvidia.com>
References: <cover.1758135681.git.lorenzo.stoakes@oracle.com>
 <4f01f4d82300444dee4af4f8d1333e52db402a45.1758135681.git.lorenzo.stoakes@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4f01f4d82300444dee4af4f8d1333e52db402a45.1758135681.git.lorenzo.stoakes@oracle.com>
X-ClientProxiedBy: YT4P288CA0009.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:d4::14) To PH7PR12MB5757.namprd12.prod.outlook.com
 (2603:10b6:510:1d0::13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5757:EE_|DM4PR12MB6376:EE_
X-MS-Office365-Filtering-Correlation-Id: f4b50d17-26a3-4523-d1c6-08ddf62fed5b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3B62/4ihQZDq1ff4P2NXaoccNNc+T1/KAEbkQqiDonPA57KVi7o44OWkS1CO?=
 =?us-ascii?Q?j5BoSQlmPHwWkl5sdmIPU1vVK3VXGf+1nYihDXg+x/u5W3mEub8TtuP3Myof?=
 =?us-ascii?Q?+xZIb64ySSfijB2/P9MLDfJPVhmMrF50czGfLo+nE0jFaif3ZmxiPCsRiGu6?=
 =?us-ascii?Q?SFN3mj7uyuYw+fyhNeg/D3aI98ZDLWPHVml7u0jO67x7YrIj1SY6tcCXeTeg?=
 =?us-ascii?Q?x25bvbRcdI6yK/nFXXhpGOEx/xKpqQx6Z/yt2V0cygE9OJot30w0tUEkItaN?=
 =?us-ascii?Q?pXFUnMg4RBLuMziJBupO+aBPIZzryiGBA/mEm9en7Q2DKC8R4plvax9iZ4KX?=
 =?us-ascii?Q?eSCPC5530EnG94k9/ibLeeXlzYlxCt/fDtN6BzpEU60fBGefhLcwWjXvYRgw?=
 =?us-ascii?Q?pyS4OzEl2X5uc+izZ9YbnHYv15kYPuL8qIMGOmBgiBETJz//MWbGJmOP/jia?=
 =?us-ascii?Q?lrOXbQX9u4aDdvYtjn0JApWB2HcDj5vRN2+aN2ffHtqUPeShwK7qsYpu/WrQ?=
 =?us-ascii?Q?wktj+rxBbAjTC/7ilyzCz2MElz/kvrjPxFjWtdrhQEiwfUIgRF1gEK4Z5Zrc?=
 =?us-ascii?Q?yP1oDLRC5rZct60udQvWMTFa+Ut02KHQeuuqs7eHhLFGewOHYz/+wDvTrVD4?=
 =?us-ascii?Q?NPJ8bu7EOfmKV3jxr9JkQA3oFCa08bm+WzeAkH0b+abB/RghvpNh2Y6ncWf6?=
 =?us-ascii?Q?o1E8sqVtC51Uz5uxHw9QVvW6x7fnQXQEBn9rRUp9lxsxM5PF6CAOygJoQAgZ?=
 =?us-ascii?Q?UqA0ZfcANHQLFuEs3ZyPn7ejpak/3/EW73AY8YCdJBPoImu0/D/LYPK50lH+?=
 =?us-ascii?Q?MsAJyVu633hpoH0UK4ISxgGh1jcVofsqz1ouQjp66VJsMMtkDUH7nKfxTWaw?=
 =?us-ascii?Q?v30OGwfa/BPYrVTSLu5HPcsK4CzaE1f/HKZpMVej7yuG6dN2zlPeBx0AShW1?=
 =?us-ascii?Q?jMzt1Zeqn6PcS0WP6LDfS2ysDbk0ERCXOBasxrVeQuhVcWkdcvDfvc0mvVtM?=
 =?us-ascii?Q?Ik+TW8VglaYw0KvWsViWt49H+58/tgiSDgGwK3CnNKXlNfNJ06r9f3rCrRv2?=
 =?us-ascii?Q?/hiEODIIlZkU5yofdyldhiBM41SGkUhGvdarxmLqIhBk91BN3z+Gobs1BmFM?=
 =?us-ascii?Q?Mc8vy/avgyiiP44YtPjgWOVLk97sRBLelJTlGoec5s3Y7+1JSHXzNbL19zUs?=
 =?us-ascii?Q?llTxu4SoVhyKFrxNEmREkspnK9IpNgWhaYm4OG5Ysfw/HjYytDhi65uZY1TR?=
 =?us-ascii?Q?fD9WKBL7Ai9OjMh8hOFoHftQoot6ZNVXnBNvU5j1wxQvxDPbtrLHEMso//0s?=
 =?us-ascii?Q?ElnFbQIR9MW0C8NuSsAfXg7paoum++0mYU2Bz07hV+MhxE6x4ZeSzh4IF8Ow?=
 =?us-ascii?Q?B5bKIzj41TIo4Yc2djzeSBdCu31YC/NyKmqMy6lXg3IIvE7j9OrNSvE+m8NL?=
 =?us-ascii?Q?cy7m7QvLYok=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5757.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9dMK/p8Iu3s4Mgo7x6wA1TXLb1LDsq+0FSHiETRztPu4/gpLwh+kwy/Ro5Cd?=
 =?us-ascii?Q?X/bdEH28eZ9evw6fCCHtRz5HhVxYlF5AEpHD69apOhhyVSl0nFPHV9gy7GhI?=
 =?us-ascii?Q?rX4YbZqGpoEhfHGpiMXQ/NZRLTKGTJQz3lg27oKYgg5bcIruBLQHR+OxSrSK?=
 =?us-ascii?Q?PDHBQWDup4GlHaE90RULRAmmOq9CdEbU/CAdFY2UcsYO7vpSIh8sGrT3wXdi?=
 =?us-ascii?Q?VnBGTvpPEmOaZe4/qI/d+/VrvbmL5BbpUgF3XVv+Cx61TfLzBpxfS29MSQBg?=
 =?us-ascii?Q?aQ++MoAWyGE/QSD62OEqb2hsDHhX2EQIl4dMyvWMv+25C81eEYIMzZ9QyJVC?=
 =?us-ascii?Q?UPLajGKD/41qnGtpWojF3TYLSmyqGMUq8E4sXsVrjhvJGzNWR/XaJrN0FXYV?=
 =?us-ascii?Q?FneaBeZN4GkQtT6iz8ipEtc1q2muS7TprxgxHPxxPOf2a81uYkh8TExJASaf?=
 =?us-ascii?Q?I5Tkw3YHYfkWlnTNwh7dCQ1fNFeYOmrVXTZwrSFpX94TU38+EzBHwHMehlyb?=
 =?us-ascii?Q?w/BMFpfJNkaQPX1N198OH9yRroDSF9jePxulfgCK+U3MmwwkW9a08xC3Pi/v?=
 =?us-ascii?Q?gvaOiyQsSY2g9douepvybNT6wYwP7i40VEc2Td+PaqwINa9Sjf4L6OJ1wclp?=
 =?us-ascii?Q?DV5YQwQdn2OSvK4rZ2/e3EOIODyluEv4gjJ4Gq6dNbf6G5A4BZ6GOIlHv1nK?=
 =?us-ascii?Q?huQtlS8JuXZWhDlystrFuYp6dZKe8rInhCtzYuz8K2xtOJiNAWHA+bwpgjfU?=
 =?us-ascii?Q?3jODfCRL4+6dr9DfJ0vAMmyDikU1/J1sulJGdty2bCj4gs4KK1IG4Dh/C08a?=
 =?us-ascii?Q?8HiGoWngEKPOMK6La6EYO2FT9dKgb5afl3VBER5DX6oj9rIXMN3gVaCOdcHU?=
 =?us-ascii?Q?WxJTm+PAItO2gaDrZfpiuC9Q2n5Pj6SR6XI6RQ2EXG3I/ryUHN6pr2bxPtVB?=
 =?us-ascii?Q?cdF/4tWtzDttzCr+I2G8ubQc+wbRAgybexyq2XbmmjalxTuAoPwZgzSiN9qw?=
 =?us-ascii?Q?6JWFGYpu4Cj+huB3GXnShTsrQlIuUe54S0IhxeiIa91ykw5VKVpRW2u+oo+Z?=
 =?us-ascii?Q?zg3iEfrFLL7Jd9HL53tSpDi1vBbl6UC1QYYLwc/G1YnqYvhsT+Up21pGSMsl?=
 =?us-ascii?Q?GGH07A/X5qKTqgBgUesE8Mw5/H8EDtYc5hrqaimztD7/ccMZDsgFUhcPAbfh?=
 =?us-ascii?Q?CyZHcxiI31hRq1ZQQMX1oE24o6Vk4gLoIGjZWD/5JyfD5c/MAY09LYf2tMt3?=
 =?us-ascii?Q?5X6F7UQFChEhZRd96cUUMc7y9SrjHvHrXnlmPemMcOcCEschlpltk6QUlB50?=
 =?us-ascii?Q?y71FKiWeOE60EPHhReDKmt2IvaHoCQEw1VuzkRxmDB2GaXp0Rg8dxBIwyPTy?=
 =?us-ascii?Q?B55SKxF7MTyO6T/j5RgyNcmRYfCta+9NvgEaBSD1uw9bkQE/H3QJGLf9YdOq?=
 =?us-ascii?Q?b9uNObtzlNCeqaRhK8DZuYYM2SZtloOJNWqk/VeobeFHOmlQp3y+0ne/7tLX?=
 =?us-ascii?Q?7WBGeyx4sc4Y9J9CFAyFlGZE5zSCDyI21Og0PvNpfbhsRV8g50dlAMP/VjxN?=
 =?us-ascii?Q?UPD2EzBNVVFzSoIVnaY=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4b50d17-26a3-4523-d1c6-08ddf62fed5b
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5757.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2025 21:19:46.6773
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: be+TFSjYy8XT9dattliDuHoDgNRD7xE6VoLABPr4kF6WWTDDB1QK2yDPO6sFeLHc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6376

On Wed, Sep 17, 2025 at 08:11:09PM +0100, Lorenzo Stoakes wrote:

> -#define io_remap_pfn_range(vma, vaddr, pfn, size, prot) \
> -	remap_pfn_range(vma, vaddr, pfn, size, prot)
> +#define io_remap_pfn_range_pfn(pfn, size) (pfn)

??

Just delete it? Looks like cargo cult cruft, see below about
pgprot_decrypted().

> +#ifdef io_remap_pfn_range_pfn
> +static inline unsigned long io_remap_pfn_range_prot(pgprot_t prot)
> +{
> +	/* We do not decrypt if arch customises PFN. */
> +	return prot;

pgprot_decrypted() is a NOP on all the arches that use this override,
please drop this.

Soon future work will require something more complicated to compute if
pgprot_decrypted() should be called so this unused stuff isn't going
to hold up.

Otherwise looks good to me

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason

