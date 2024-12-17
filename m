Return-Path: <linux-fsdevel+bounces-37585-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D18169F4249
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Dec 2024 06:19:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 573851885D0F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Dec 2024 05:19:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCD371DED79;
	Tue, 17 Dec 2024 05:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="JWgMqr+d"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2065.outbound.protection.outlook.com [40.107.220.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 305781DE895;
	Tue, 17 Dec 2024 05:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734412477; cv=fail; b=DWqB8Zg66IYT5WNTuj7Hg0YldISo5NTyrulyMLNpW+BHm9U9ScElGY2TZB7elq3sJF85Yu9sSjk5i0Vrdaav8EtYdA29KqKy/H1StfvfjVdFStZnwb0/Rp7Bcv0EwcXyq3qg8W6aZ9ZJmznhbznp7LKPBScMrlcLm+EBWzXP+9Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734412477; c=relaxed/simple;
	bh=ZWO5wkQ4gT6pArSvWzIa9XFRDsmGAuf7RKvqTO/MErE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hnqEjMrUNHUOzove3GFfbhARl71zVD4MIlufDcCR4dseCduHYfZXH6TQV/3kkOZJ8bWqYfOr8Put+txaUST4YSdsl06mim0xROZknJU0QFw/DsVClYTDL2C6B4kVdpTL0kPks7vkKBr62IajJjS7fXl7ZOMv3iqwvFTWtACHwwk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=JWgMqr+d; arc=fail smtp.client-ip=40.107.220.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vJn+HLjMoHHRjaIwODT/ngsjTnRiYjE2HIn0fuUkUqvBTHCzpUZ2zSB/DXL+l6qqQiwIGRSagkSHNvyPneOCBN4BaoRP7KJg3/k21UHwU6V+c9fFBxAVhYcFBiCM6zELjFFpP8ez1KklQwcoeeSx7ltGQ6Y6MGuD9u5g9IiK2DnJK2VpLV/xsjmqi86TR8sifDH4xganUU6DXp8XMwKJVHSkb5TbeojOfAItNCFyWZ1sr7bZTVhBCShPeCRpr4Z34IVZ8l6Xde3lGZ0u0jyQGLzthe243YWvYmf5FLd8DOOhtg/gNT99L+4kHn8oBCYhraB0AncCYu4JC5Pq+6bWLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HbvWzssPrT9FZMJZBSAKYh1TA5jh1lsqkg7Zp8OnHfg=;
 b=kScuAI8SYKEtdgGgc2Q59jH1zjQ+7WmBuPInX1oNKp2rE5fXZVG2aeEcuEqy+QYLh9/K8u1cFWULVzDJcFNJXPa4A3gF/5w4gEKJHrMDMwYrXgAAkKEU3mHHfoVveHOynwM8DlE1ZxncaFCv3jCpq038SGSaLR0nZcGnO5JN9qc81n6/qFMLeRNqcF/mEoX67+0hEXuXkFHcwrfF3bf42QOfhsH381sDdjrQjq2ceQetB8QphzAk1APtmp44eAGubfMZBV7N5u2ldaXNOPIliyqRV0hgQQM0AMvcFpPPoY9V2cN/FBewG8EYbS7fYOULSGHUHFR1jIf4GU5bsmsmBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HbvWzssPrT9FZMJZBSAKYh1TA5jh1lsqkg7Zp8OnHfg=;
 b=JWgMqr+d5l/f86m+NykPlMlMLMte4FmBnLTYhjyGRFnJ4WrVXh0bCJxrUt5xT1DP5Yh3Le9M/XGKcZwb84Ug+x6ZusCv3J3X8m3aXt+oj++tViuGBb1+7g0LpzkSEQG/sPm7hoDGfNKFl+Nk4Z+pXEYrQ/fRMpnFQqQoFc8dqNjXjPwKZbyXdSMXQ+SbE9RlL923VPGhAo6l5A9p3yqI6pMQIQ2pkpZ4wsk9G9CsfE/iNl4bNl8mP3yEavbsgWB7Txwc8pl3EcXG2GPFGGT/U3AABsI2GeVzseV3zo99r926qHI/zyfAbdPpk8ych/domOrrsXCw+ZwDmiIPE47tJA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6) by
 CH3PR12MB8936.namprd12.prod.outlook.com (2603:10b6:610:179::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.22; Tue, 17 Dec
 2024 05:14:33 +0000
Received: from DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe]) by DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe%4]) with mapi id 15.20.8251.015; Tue, 17 Dec 2024
 05:14:33 +0000
From: Alistair Popple <apopple@nvidia.com>
To: akpm@linux-foundation.org,
	dan.j.williams@intel.com,
	linux-mm@kvack.org
Cc: Alistair Popple <apopple@nvidia.com>,
	lina@asahilina.net,
	zhang.lyra@gmail.com,
	gerald.schaefer@linux.ibm.com,
	vishal.l.verma@intel.com,
	dave.jiang@intel.com,
	logang@deltatee.com,
	bhelgaas@google.com,
	jack@suse.cz,
	jgg@ziepe.ca,
	catalin.marinas@arm.com,
	will@kernel.org,
	mpe@ellerman.id.au,
	npiggin@gmail.com,
	dave.hansen@linux.intel.com,
	ira.weiny@intel.com,
	willy@infradead.org,
	djwong@kernel.org,
	tytso@mit.edu,
	linmiaohe@huawei.com,
	david@redhat.com,
	peterx@redhat.com,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linuxppc-dev@lists.ozlabs.org,
	nvdimm@lists.linux.dev,
	linux-cxl@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	jhubbard@nvidia.com,
	hch@lst.de,
	david@fromorbit.com,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: [PATCH v4 11/25] mm: Allow compound zone device pages
Date: Tue, 17 Dec 2024 16:12:54 +1100
Message-ID: <ede5823e99c178bbe28470af1e5d84d09bfcc989.1734407924.git-series.apopple@nvidia.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.18cbcff3638c6aacc051c44533ebc6c002bf2bd9.1734407924.git-series.apopple@nvidia.com>
References: <cover.18cbcff3638c6aacc051c44533ebc6c002bf2bd9.1734407924.git-series.apopple@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SY5P300CA0044.AUSP300.PROD.OUTLOOK.COM
 (2603:10c6:10:1fd::19) To DS0PR12MB7726.namprd12.prod.outlook.com
 (2603:10b6:8:130::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7726:EE_|CH3PR12MB8936:EE_
X-MS-Office365-Filtering-Correlation-Id: a51a1687-d51c-498a-fe53-08dd1e59b12f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?rTD7DX3RD2RYIHPnI43H/jYxKepPl7NXdHEKU+OxTrt8G696RjSmL6/S4AZr?=
 =?us-ascii?Q?+EEqsoDOiJYtwlDk8S2Xrl1cg9ei3kGkbbww2ZQ97G59J99lqT4d7toPL08Y?=
 =?us-ascii?Q?yFNO5gD7SdQKS9X1nsENUaGZ7aZ0jgO5M6kMfqFNCHvVsE7kMJRrj0zgybgN?=
 =?us-ascii?Q?ndbNaKTeecbodHe056tinnSt8zZQMrA0JGYSHX9gQGUAtiBBdKBc6s8rYYTj?=
 =?us-ascii?Q?g5uZWsNfuudK4w8aqyn86H/IuB1VEaMoQ9AeAnGDvzavKuZOZia97HSWk8E4?=
 =?us-ascii?Q?7gPhIR3hju/oAXFN+XFyyeGjGNcR+SXV/+vm/GeveIv5OKaACstLb6knFrJ5?=
 =?us-ascii?Q?Cuf6silFsMeRPCFXoKpJJiFr3yfOiT1kM1HbXYeJ7lEnZze8bPm5UQ1Ny+mP?=
 =?us-ascii?Q?HH32pJ7VN/c55RNe8+GE6YMa/AXCcTC/wcRlkBjGF0sqpvKP7bSUiFMw1b7I?=
 =?us-ascii?Q?bxYA+Uhynw7Y1OZjMhDYxQT1+J/qIsjqYxkko+m0KyATBMvifzF9XY89AcYb?=
 =?us-ascii?Q?gRIdHWuQFUlydUSaLtoc02E2aIZv7Rabw/AZu0gV3zpX5Fl8QGp6NJfk03Cf?=
 =?us-ascii?Q?zddwrMvy0/7yK4Aqlol/vT/WDMJv8JkcWAW0MGURc1/6I/wHvb/OwIoWAjqJ?=
 =?us-ascii?Q?ScZEXSArNUE5NZEK6ajC3tL0Q08zLjdYT/Iu6X9UbOb59lt43AJiC/9UKKEl?=
 =?us-ascii?Q?3J3WXEgkEA22YMd6kgbCZBitXVrYYDYzMe96UcdKK/BMzBkSdxHLoXZJNYvN?=
 =?us-ascii?Q?v/dQXRMqqm66X+k7062ieXL8q5whfYUiwQFgTfhStNKSNvANSz4LBtiLRnZi?=
 =?us-ascii?Q?sensGvjHmuuG9oZo9bGj4d/T9UkPtRXpefI7MWOVTS2F7Xexgwg4paP+WATB?=
 =?us-ascii?Q?B9rLNu7kW25lmdu5sjGHH3V4PdsUFtnjNS0Wghi0qMpt97eunQrF0purGEjS?=
 =?us-ascii?Q?IB57i/pQNJjBV2A1xxuif4t3u4Vu8w6ga+wLy4Etpf0X1+zFiycZeuBgC2kB?=
 =?us-ascii?Q?jPNimRcEtsQTVbtGDdN3zYsO07XbKuHUp6+HRv2uVKHdrw77BLFdHbztVN5b?=
 =?us-ascii?Q?hMAyG6Du0HZsKvusqHpm923nkh9b8t1Ac9d3smdvoDvBt394Yy2qYmxJJKNq?=
 =?us-ascii?Q?/4/v4N1Wr0rFCU5v0OY+TvpSext6m6qkkdpaDNs+cY6kxROna6auAAEpgJdf?=
 =?us-ascii?Q?xj2ZC3Z9FtJDvruQnhyOypbbmWeUKUFf+qqhSQoA+9a2aNT9IqTFG8tamvBV?=
 =?us-ascii?Q?nwnYMyhSZe9X8TgVLO8AessG1557zFeR4mffkEBrnyhOqG8iVFv4d3qw2KAe?=
 =?us-ascii?Q?ssNejCJzr3IuGoAheh60lf+Pe94WJSBGYSte+NkHGszNHX9Uor20wc5IxTkM?=
 =?us-ascii?Q?ePgmg9l51dIooVIz817yGjE6sqSx?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7726.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jixC477irzY+HeY4cKZrLWXU13FErYCumrWlXaLwCYCPYLWpXgsVXXFXU4va?=
 =?us-ascii?Q?x82/YPHdy9wFXPg+yf/iM+d+elA1zQvOxc5Xk3J9gYsHAd1RI43Un9dtaTli?=
 =?us-ascii?Q?OaKm/Siyq3PjD2AVZB2qrlXOB4W9Hjirxi6Wv0wT0ECmojbEJqfexxU8/LLu?=
 =?us-ascii?Q?bPBavjD+r89rDRtvQzb7YDz9hptljdbSezUTZ66TIzfH7ed7JOH5MDFi8VoN?=
 =?us-ascii?Q?guFn5ulfl9h6fenRWc0n7B74sBAaCQk2ZvdUCw5nufyswPimL0vBN11jqAc/?=
 =?us-ascii?Q?tcz2IUil/J7ycUtHkQ7J7WsPxH1oTm+h+pDTm8F0aBSUt/AW2No/K5W66u7E?=
 =?us-ascii?Q?3WSO8iNFzWQUAq6HqZdohj2rCC7TFBrTfl4BKzaaqgN6TXu2jVOn+KCDMkIG?=
 =?us-ascii?Q?t8RpVg/jst8+ulxh2mARpyHsEkT+dHNZqRP09uQQHOx3FRlg5Cv1L+fY+05R?=
 =?us-ascii?Q?Wkg/BO97ylQzx8gPoyIqpDxuuMUZmXh1srJGBxgNuRtwK0VPFFdwWwbcT9jU?=
 =?us-ascii?Q?wzcfqb6qJFxKp6mt+pxZgg5ZPtlKTPm9wuANDmt98NlrzMWYgZKuHM0BfcbX?=
 =?us-ascii?Q?dREI6QiFMofmAJtY5tjzX8kci5qGs9/7HEfNtOmpmW303KswHVJ7BleWpZV8?=
 =?us-ascii?Q?jrzztS22pxTcU1HB5atYCOE2caIzvdpVnNvnMji1osHfY5y5NrLe7D0HwUO7?=
 =?us-ascii?Q?G+5IRHmFuy47qOvNe1i0YOtGPqN0GDQBWuX5klroFsoCtqzXmsX2NE9mZWsw?=
 =?us-ascii?Q?DKOoK4aTvdPTUYeMJG9nLGrgAKv+uk6j4TNXvSmR29QbInGJP+HyUtC02J6U?=
 =?us-ascii?Q?qpY6EgDm+Ml13tQp8ecnEURbyxd12O60ziajLVegRzLxDGYIkf0uQvASDtGo?=
 =?us-ascii?Q?juOIV2kQSGVCjAZrx0k7LQyYT1r5mH3l/dMzrpFiaQJPdNZxUfbL3BIUscGm?=
 =?us-ascii?Q?Fg/aw1biT2orcn6zt0zTbXI6BCW+/p7on10J7/dCXqp/2eMCBzCqAg53hZtn?=
 =?us-ascii?Q?zVcFQzhirP2y2ZWkhKXopTNlD1G5f0ynWHKyf6ukG3uPcOtB5k/sRvoAaeWa?=
 =?us-ascii?Q?pZxJXxTuMHxTvXx7C8Hbs3rUgkS+31f5V/LytmMzjbv4A+Oh9CVOtRC6ESLM?=
 =?us-ascii?Q?dhn5gpDlEpfivix8xCiRc0aAAYorTx2fhq/AAUZpfFC4CqSH/48ane6XTZYK?=
 =?us-ascii?Q?+NpAbeVN+1yO4MKbHJ+n/RkL1fR9Uqkxxe4Imyj8f7+9rm81cAEgT6BWLKmn?=
 =?us-ascii?Q?XB8MiVPwONYd5NdFUGxQcirr18UTFSqXJwk3MnzbLrUnvmhJf3s9z+a0dJXt?=
 =?us-ascii?Q?P1ByH2RA+6etJpVFrcBXA6ZR6hnPj2MFKTiLDrZDu1ejiYquo9blexs2kZn1?=
 =?us-ascii?Q?RoA0j/Gugs2RvBuqUv5B0A2fAr/WvVKgpDuvw0rRLy6HWrxaTR5jSmNTXmM2?=
 =?us-ascii?Q?PwT4npatF90h0qFOkZ8nNFLNy+AvYdvjt3uEmm54zINLKa8++riFWy/x3viu?=
 =?us-ascii?Q?5NQcP/C49eFVsC2Q+yiXsD14RQs3Gx+DAGhus8R7cAgzbIWYJLa3DHUkAVzJ?=
 =?us-ascii?Q?U8ax3sYbA831pjyR9HJGY8grR+4bf0oE7Jq3qxUU?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a51a1687-d51c-498a-fe53-08dd1e59b12f
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7726.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2024 05:14:33.2309
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W5PCVM2IF3FRehc455qhgk1P8disHCM9Xv6XBIIxN6U53ouP23qOgxBI5R7ILxUx3OMTXKYS5x7ag2fNPeVDCg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8936

Zone device pages are used to represent various type of device memory
managed by device drivers. Currently compound zone device pages are
not supported. This is because MEMORY_DEVICE_FS_DAX pages are the only
user of higher order zone device pages and have their own page
reference counting.

A future change will unify FS DAX reference counting with normal page
reference counting rules and remove the special FS DAX reference
counting. Supporting that requires compound zone device pages.

Supporting compound zone device pages requires compound_head() to
distinguish between head and tail pages whilst still preserving the
special struct page fields that are specific to zone device pages.

A tail page is distinguished by having bit zero being set in
page->compound_head, with the remaining bits pointing to the head
page. For zone device pages page->compound_head is shared with
page->pgmap.

The page->pgmap field is common to all pages within a memory section.
Therefore pgmap is the same for both head and tail pages and can be
moved into the folio and we can use the standard scheme to find
compound_head from a tail page.

Signed-off-by: Alistair Popple <apopple@nvidia.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>

---

Changes for v4:
 - Fix build breakages reported by kernel test robot

Changes since v2:

 - Indentation fix
 - Rename page_dev_pagemap() to page_pgmap()
 - Rename folio _unused field to _unused_pgmap_compound_head
 - s/WARN_ON/VM_WARN_ON_ONCE_PAGE/

Changes since v1:

 - Move pgmap to the folio as suggested by Matthew Wilcox
---
 drivers/gpu/drm/nouveau/nouveau_dmem.c |  3 ++-
 drivers/pci/p2pdma.c                   |  6 +++---
 include/linux/memremap.h               |  6 +++---
 include/linux/migrate.h                |  4 ++--
 include/linux/mm_types.h               |  9 +++++++--
 include/linux/mmzone.h                 | 12 +++++++++++-
 lib/test_hmm.c                         |  3 ++-
 mm/hmm.c                               |  2 +-
 mm/memory.c                            |  4 +++-
 mm/memremap.c                          | 14 +++++++-------
 mm/migrate_device.c                    |  7 +++++--
 mm/mm_init.c                           |  2 +-
 12 files changed, 47 insertions(+), 25 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nouveau_dmem.c b/drivers/gpu/drm/nouveau/nouveau_dmem.c
index 1a07256..61d0f41 100644
--- a/drivers/gpu/drm/nouveau/nouveau_dmem.c
+++ b/drivers/gpu/drm/nouveau/nouveau_dmem.c
@@ -88,7 +88,8 @@ struct nouveau_dmem {
 
 static struct nouveau_dmem_chunk *nouveau_page_to_chunk(struct page *page)
 {
-	return container_of(page->pgmap, struct nouveau_dmem_chunk, pagemap);
+	return container_of(page_pgmap(page), struct nouveau_dmem_chunk,
+			    pagemap);
 }
 
 static struct nouveau_drm *page_to_drm(struct page *page)
diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
index 04773a8..19214ec 100644
--- a/drivers/pci/p2pdma.c
+++ b/drivers/pci/p2pdma.c
@@ -202,7 +202,7 @@ static const struct attribute_group p2pmem_group = {
 
 static void p2pdma_page_free(struct page *page)
 {
-	struct pci_p2pdma_pagemap *pgmap = to_p2p_pgmap(page->pgmap);
+	struct pci_p2pdma_pagemap *pgmap = to_p2p_pgmap(page_pgmap(page));
 	/* safe to dereference while a reference is held to the percpu ref */
 	struct pci_p2pdma *p2pdma =
 		rcu_dereference_protected(pgmap->provider->p2pdma, 1);
@@ -1025,8 +1025,8 @@ enum pci_p2pdma_map_type
 pci_p2pdma_map_segment(struct pci_p2pdma_map_state *state, struct device *dev,
 		       struct scatterlist *sg)
 {
-	if (state->pgmap != sg_page(sg)->pgmap) {
-		state->pgmap = sg_page(sg)->pgmap;
+	if (state->pgmap != page_pgmap(sg_page(sg))) {
+		state->pgmap = page_pgmap(sg_page(sg));
 		state->map = pci_p2pdma_map_type(state->pgmap, dev);
 		state->bus_off = to_p2p_pgmap(state->pgmap)->bus_offset;
 	}
diff --git a/include/linux/memremap.h b/include/linux/memremap.h
index 3f7143a..0256a42 100644
--- a/include/linux/memremap.h
+++ b/include/linux/memremap.h
@@ -161,7 +161,7 @@ static inline bool is_device_private_page(const struct page *page)
 {
 	return IS_ENABLED(CONFIG_DEVICE_PRIVATE) &&
 		is_zone_device_page(page) &&
-		page->pgmap->type == MEMORY_DEVICE_PRIVATE;
+		page_pgmap(page)->type == MEMORY_DEVICE_PRIVATE;
 }
 
 static inline bool folio_is_device_private(const struct folio *folio)
@@ -173,13 +173,13 @@ static inline bool is_pci_p2pdma_page(const struct page *page)
 {
 	return IS_ENABLED(CONFIG_PCI_P2PDMA) &&
 		is_zone_device_page(page) &&
-		page->pgmap->type == MEMORY_DEVICE_PCI_P2PDMA;
+		page_pgmap(page)->type == MEMORY_DEVICE_PCI_P2PDMA;
 }
 
 static inline bool is_device_coherent_page(const struct page *page)
 {
 	return is_zone_device_page(page) &&
-		page->pgmap->type == MEMORY_DEVICE_COHERENT;
+		page_pgmap(page)->type == MEMORY_DEVICE_COHERENT;
 }
 
 static inline bool folio_is_device_coherent(const struct folio *folio)
diff --git a/include/linux/migrate.h b/include/linux/migrate.h
index 29919fa..61899ec 100644
--- a/include/linux/migrate.h
+++ b/include/linux/migrate.h
@@ -205,8 +205,8 @@ struct migrate_vma {
 	unsigned long		end;
 
 	/*
-	 * Set to the owner value also stored in page->pgmap->owner for
-	 * migrating out of device private memory. The flags also need to
+	 * Set to the owner value also stored in page_pgmap(page)->owner
+	 * for migrating out of device private memory. The flags also need to
 	 * be set to MIGRATE_VMA_SELECT_DEVICE_PRIVATE.
 	 * The caller should always set this field when using mmu notifier
 	 * callbacks to avoid device MMU invalidations for device private
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index df8f515..54b59b8 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -129,8 +129,11 @@ struct page {
 			unsigned long compound_head;	/* Bit zero is set */
 		};
 		struct {	/* ZONE_DEVICE pages */
-			/** @pgmap: Points to the hosting device page map. */
-			struct dev_pagemap *pgmap;
+			/*
+			 * The first word is used for compound_head or folio
+			 * pgmap
+			 */
+			void *_unused_pgmap_compound_head;
 			void *zone_device_data;
 			/*
 			 * ZONE_DEVICE private pages are counted as being
@@ -299,6 +302,7 @@ typedef struct {
  * @_refcount: Do not access this member directly.  Use folio_ref_count()
  *    to find how many references there are to this folio.
  * @memcg_data: Memory Control Group data.
+ * @pgmap: Metadata for ZONE_DEVICE mappings
  * @virtual: Virtual address in the kernel direct map.
  * @_last_cpupid: IDs of last CPU and last process that accessed the folio.
  * @_entire_mapcount: Do not use directly, call folio_entire_mapcount().
@@ -337,6 +341,7 @@ struct folio {
 	/* private: */
 				};
 	/* public: */
+				struct dev_pagemap *pgmap;
 			};
 			struct address_space *mapping;
 			pgoff_t index;
diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index c7ad4d6..fd492c3 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -1159,6 +1159,12 @@ static inline bool is_zone_device_page(const struct page *page)
 	return page_zonenum(page) == ZONE_DEVICE;
 }
 
+static inline struct dev_pagemap *page_pgmap(const struct page *page)
+{
+	VM_WARN_ON_ONCE_PAGE(!is_zone_device_page(page), page);
+	return page_folio(page)->pgmap;
+}
+
 /*
  * Consecutive zone device pages should not be merged into the same sgl
  * or bvec segment with other types of pages or if they belong to different
@@ -1174,7 +1180,7 @@ static inline bool zone_device_pages_have_same_pgmap(const struct page *a,
 		return false;
 	if (!is_zone_device_page(a))
 		return true;
-	return a->pgmap == b->pgmap;
+	return page_pgmap(a) == page_pgmap(b);
 }
 
 extern void memmap_init_zone_device(struct zone *, unsigned long,
@@ -1189,6 +1195,10 @@ static inline bool zone_device_pages_have_same_pgmap(const struct page *a,
 {
 	return true;
 }
+static inline struct dev_pagemap *page_pgmap(const struct page *page)
+{
+	return NULL;
+}
 #endif
 
 static inline bool folio_is_zone_device(const struct folio *folio)
diff --git a/lib/test_hmm.c b/lib/test_hmm.c
index 056f2e4..ffd0c6f 100644
--- a/lib/test_hmm.c
+++ b/lib/test_hmm.c
@@ -195,7 +195,8 @@ static int dmirror_fops_release(struct inode *inode, struct file *filp)
 
 static struct dmirror_chunk *dmirror_page_to_chunk(struct page *page)
 {
-	return container_of(page->pgmap, struct dmirror_chunk, pagemap);
+	return container_of(page_pgmap(page), struct dmirror_chunk,
+			    pagemap);
 }
 
 static struct dmirror_device *dmirror_page_to_device(struct page *page)
diff --git a/mm/hmm.c b/mm/hmm.c
index 7e0229a..082f7b7 100644
--- a/mm/hmm.c
+++ b/mm/hmm.c
@@ -248,7 +248,7 @@ static int hmm_vma_handle_pte(struct mm_walk *walk, unsigned long addr,
 		 * just report the PFN.
 		 */
 		if (is_device_private_entry(entry) &&
-		    pfn_swap_entry_to_page(entry)->pgmap->owner ==
+		    page_pgmap(pfn_swap_entry_to_page(entry))->owner ==
 		    range->dev_private_owner) {
 			cpu_flags = HMM_PFN_VALID;
 			if (is_writable_device_private_entry(entry))
diff --git a/mm/memory.c b/mm/memory.c
index f09f20c..06bb29e 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -4316,6 +4316,7 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 			vmf->page = pfn_swap_entry_to_page(entry);
 			ret = remove_device_exclusive_entry(vmf);
 		} else if (is_device_private_entry(entry)) {
+			struct dev_pagemap *pgmap;
 			if (vmf->flags & FAULT_FLAG_VMA_LOCK) {
 				/*
 				 * migrate_to_ram is not yet ready to operate
@@ -4340,7 +4341,8 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 			 */
 			get_page(vmf->page);
 			pte_unmap_unlock(vmf->pte, vmf->ptl);
-			ret = vmf->page->pgmap->ops->migrate_to_ram(vmf);
+			pgmap = page_pgmap(vmf->page);
+			ret = pgmap->ops->migrate_to_ram(vmf);
 			put_page(vmf->page);
 		} else if (is_hwpoison_entry(entry)) {
 			ret = VM_FAULT_HWPOISON;
diff --git a/mm/memremap.c b/mm/memremap.c
index 07bbe0e..68099af 100644
--- a/mm/memremap.c
+++ b/mm/memremap.c
@@ -458,8 +458,8 @@ EXPORT_SYMBOL_GPL(get_dev_pagemap);
 
 void free_zone_device_folio(struct folio *folio)
 {
-	if (WARN_ON_ONCE(!folio->page.pgmap->ops ||
-			!folio->page.pgmap->ops->page_free))
+	if (WARN_ON_ONCE(!folio->pgmap->ops ||
+			!folio->pgmap->ops->page_free))
 		return;
 
 	mem_cgroup_uncharge(folio);
@@ -486,12 +486,12 @@ void free_zone_device_folio(struct folio *folio)
 	 * to clear folio->mapping.
 	 */
 	folio->mapping = NULL;
-	folio->page.pgmap->ops->page_free(folio_page(folio, 0));
+	folio->pgmap->ops->page_free(folio_page(folio, 0));
 
-	switch (folio->page.pgmap->type) {
+	switch (folio->pgmap->type) {
 	case MEMORY_DEVICE_PRIVATE:
 	case MEMORY_DEVICE_COHERENT:
-		put_dev_pagemap(folio->page.pgmap);
+		put_dev_pagemap(folio->pgmap);
 		break;
 
 	case MEMORY_DEVICE_FS_DAX:
@@ -514,7 +514,7 @@ void zone_device_page_init(struct page *page)
 	 * Drivers shouldn't be allocating pages after calling
 	 * memunmap_pages().
 	 */
-	WARN_ON_ONCE(!percpu_ref_tryget_live(&page->pgmap->ref));
+	WARN_ON_ONCE(!percpu_ref_tryget_live(&page_pgmap(page)->ref));
 	set_page_count(page, 1);
 	lock_page(page);
 }
@@ -523,7 +523,7 @@ EXPORT_SYMBOL_GPL(zone_device_page_init);
 #ifdef CONFIG_FS_DAX
 bool __put_devmap_managed_folio_refs(struct folio *folio, int refs)
 {
-	if (folio->page.pgmap->type != MEMORY_DEVICE_FS_DAX)
+	if (folio->pgmap->type != MEMORY_DEVICE_FS_DAX)
 		return false;
 
 	/*
diff --git a/mm/migrate_device.c b/mm/migrate_device.c
index 9cf2659..2209070 100644
--- a/mm/migrate_device.c
+++ b/mm/migrate_device.c
@@ -106,6 +106,7 @@ static int migrate_vma_collect_pmd(pmd_t *pmdp,
 	arch_enter_lazy_mmu_mode();
 
 	for (; addr < end; addr += PAGE_SIZE, ptep++) {
+		struct dev_pagemap *pgmap;
 		unsigned long mpfn = 0, pfn;
 		struct folio *folio;
 		struct page *page;
@@ -133,9 +134,10 @@ static int migrate_vma_collect_pmd(pmd_t *pmdp,
 				goto next;
 
 			page = pfn_swap_entry_to_page(entry);
+			pgmap = page_pgmap(page);
 			if (!(migrate->flags &
 				MIGRATE_VMA_SELECT_DEVICE_PRIVATE) ||
-			    page->pgmap->owner != migrate->pgmap_owner)
+			    pgmap->owner != migrate->pgmap_owner)
 				goto next;
 
 			mpfn = migrate_pfn(page_to_pfn(page)) |
@@ -151,12 +153,13 @@ static int migrate_vma_collect_pmd(pmd_t *pmdp,
 				goto next;
 			}
 			page = vm_normal_page(migrate->vma, addr, pte);
+			pgmap = page_pgmap(page);
 			if (page && !is_zone_device_page(page) &&
 			    !(migrate->flags & MIGRATE_VMA_SELECT_SYSTEM))
 				goto next;
 			else if (page && is_device_coherent_page(page) &&
 			    (!(migrate->flags & MIGRATE_VMA_SELECT_DEVICE_COHERENT) ||
-			     page->pgmap->owner != migrate->pgmap_owner))
+			     pgmap->owner != migrate->pgmap_owner))
 				goto next;
 			mpfn = migrate_pfn(pfn) | MIGRATE_PFN_MIGRATE;
 			mpfn |= pte_write(pte) ? MIGRATE_PFN_WRITE : 0;
diff --git a/mm/mm_init.c b/mm/mm_init.c
index f021e63..cb73402 100644
--- a/mm/mm_init.c
+++ b/mm/mm_init.c
@@ -998,7 +998,7 @@ static void __ref __init_zone_device_page(struct page *page, unsigned long pfn,
 	 * and zone_device_data.  It is a bug if a ZONE_DEVICE page is
 	 * ever freed or placed on a driver-private list.
 	 */
-	page->pgmap = pgmap;
+	page_folio(page)->pgmap = pgmap;
 	page->zone_device_data = NULL;
 
 	/*
-- 
git-series 0.9.1

