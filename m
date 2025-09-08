Return-Path: <linux-fsdevel+bounces-60521-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 36881B48EE4
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Sep 2025 15:11:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DDD19188260D
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Sep 2025 13:12:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32D6530B52A;
	Mon,  8 Sep 2025 13:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="e0e3e9+Y"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2075.outbound.protection.outlook.com [40.107.93.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F20A7306D4D;
	Mon,  8 Sep 2025 13:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757337090; cv=fail; b=L3lEIz5vm/UAK7Xp+fzO3Q+3MAPC/dcHJHEbm5tqm4pq1qKRujXwZtNE62OkNJp3qMKg9bvrYUbYZWGrUy/fVjiDbSaF0wrko0ymg+gZPECV6JZx4zpBnwfE2J9p74fstOciWn8jSKDEhLEa0NVoq0qXMYzReYnlVzbj8L/8X6c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757337090; c=relaxed/simple;
	bh=FeF9zLDeUfQtLhfvQQ4f/AX9BLlAfqbce1bkG6lhU5I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=kRmcCub5nWQLWze+qXqEaqyUNJekstvSTIpaKKKfKPhNCG75O1Zh3SIQJxNJMFHHVP4kLllO2333rvV1QfsUemuIcCr0Z1e7XnGIFZqsIobjg3Wz6XeTQ2RYTELAcTNDFtTGxp/L8VntnGrNfqEQe39uj193qkapezR3oiK/J6A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=e0e3e9+Y; arc=fail smtp.client-ip=40.107.93.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wg+tvgGzPKaChDClFNQhQXYA7zY9ie7Ye2wM0NtvzOcNncDF8A7dvHYCZcGplKsMVbaiLnxffLVQVdhNjpXnGBZP5WnM7oRdi3aJfCNkhjKOrVw3heGaJbSgsTMDAf4v+CPDldGbuQFjPbs7Or9jqHey4SbifLW2jArW0kk2fWXulAeWp+aU2IOisM449HH33FFiBKiTSoqbdlRt06Wyz8CO2nHandmWOyZN2HPI++O7cpq/Y2lu6BO2CIw74YQgDG75uF3ui42lJu++2mUgEegGhEzI8Ehb1awCs5CN8jilR70awFmaL7+QwBhVlWo+XMRHR2stZbhvlC0O956l7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bz15BRQJDJr031E71fvpDtrGADfbwz04cIMxbKpzdQA=;
 b=Cukrp6Lm5vJ/1bXU0Fylh4CgHSizjfHTlmeQcsKwmqZfwYOatcPv24ja4qKPlfKNEm33ReAjIhE7bTzuDrGTsuEdko29OfI/5NT4VQLlnoH9vZGhEgb+DMEeC76Wkp+lnyJQRuv0Fy+TMrloX1SGosaDAW8nZz9UGDxxBrw/W529Rxk+zKA2BuoLzbYru6szE+VpEfdiEy5Oqs8168yUw+hKGVWG38aLVhtBDVDuaU54DWMVbFSX3K0FrlqrwipYApMHGbTDPKAxzBlaqTRXRQOo3chm6+slaFAAYffWtA13jSmlbT9pKSSKqaEVfkmmk71d/qiT4D0LbkE5wihRTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bz15BRQJDJr031E71fvpDtrGADfbwz04cIMxbKpzdQA=;
 b=e0e3e9+YKy6FDF8g2ukoefN1YWsEdITCweXuzaFFnp3sVn1TKpwDQXPzHAjFFnZhqTr65hIdEVttddsjTdxX30AaA/5nNN0dnGIYLb7Q7hUhgZXoToiCLhuqoO5shUHo8ICHi9VkJz5oNNnSWSzg7gKEdS3yKtJVzdZstwjGZV+KZ1zP57d7Q2DXM7xp5pQi4DdR5I2//rQVcN75uEMsSjC17bVeDyRqRzthYABXTn3IanHSNyvyMdZNmQYEByoe0vsJZAF9XpL3ztvTLQBn3W0R9V6Kk5rplqAqwyushrpl5PDNauaYFtmkjMNHLLtuGAdVwl2flKZfW/J7+yGfrw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH7PR12MB5757.namprd12.prod.outlook.com (2603:10b6:510:1d0::13)
 by IA1PR12MB8335.namprd12.prod.outlook.com (2603:10b6:208:3fa::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.19; Mon, 8 Sep
 2025 13:11:23 +0000
Received: from PH7PR12MB5757.namprd12.prod.outlook.com
 ([fe80::f012:300c:6bf4:7632]) by PH7PR12MB5757.namprd12.prod.outlook.com
 ([fe80::f012:300c:6bf4:7632%2]) with mapi id 15.20.9094.017; Mon, 8 Sep 2025
 13:11:23 +0000
Date: Mon, 8 Sep 2025 10:11:21 -0300
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
Subject: Re: [PATCH 10/16] mm/hugetlb: update hugetlbfs to use mmap_prepare,
 mmap_complete
Message-ID: <20250908131121.GA616306@nvidia.com>
References: <cover.1757329751.git.lorenzo.stoakes@oracle.com>
 <346e2d1e768a2e5bf344c772cfbb0cd1d6f2fd15.1757329751.git.lorenzo.stoakes@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <346e2d1e768a2e5bf344c772cfbb0cd1d6f2fd15.1757329751.git.lorenzo.stoakes@oracle.com>
X-ClientProxiedBy: YT4PR01CA0209.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:ad::6) To PH7PR12MB5757.namprd12.prod.outlook.com
 (2603:10b6:510:1d0::13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5757:EE_|IA1PR12MB8335:EE_
X-MS-Office365-Filtering-Correlation-Id: 386a6328-7435-44da-9244-08ddeed93593
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?q8HBHKuQn1jDqfku0SHQMpqHFzJLzy9/1XphfSkkXwawrt3tflPKpRzoa9Bg?=
 =?us-ascii?Q?lJkwenNqZRJRB544dpvAAHV/f/le4z7YyBySchpJwaslvNCfmKGldeqZNbdh?=
 =?us-ascii?Q?SmIp0NTBjwzOdOSI9eFqRiKMjf3gbqJqkMTP4EZA4q61V6Lf1NYSvTiY9Trt?=
 =?us-ascii?Q?s3eldiUElHxCxvOlDVV71VTusd7WZvfPovSzZsGms/psSVD8J6VxpOA6q32q?=
 =?us-ascii?Q?9o+SlzckeUmbtIxyJ/HNeMbmhYK6+A7vpq9UQG4QDr8Ljv/SOsK0xHvLPNEe?=
 =?us-ascii?Q?kbvyNpnK7cR/zlYPjEVvmdQvVigrUi+fPzaiZ9yJSyfhXzFTSJS8+Ws3rCUm?=
 =?us-ascii?Q?VYEcscr4Z16E2Ckue5s0Ap+W1bbpG8EXQps5/aLnkTRTR7lh1Wke2NkZEwzt?=
 =?us-ascii?Q?xcElJ7fXLVn9BqMJVKzagFfxx/X4h0s44sfvHVW+zMw6HBmVoBIgSg+X91Vi?=
 =?us-ascii?Q?/FAWftaR79JeJ7B0y5g5m6pQntwqD5qtRfs+XrM5SUV7fZNZGMjBOVvSCJJm?=
 =?us-ascii?Q?RNiL1xn9jMy1CaHLJQjuqZWh3jMj6yFhTuTsFCuI5STmyn+KKH7GJx2y+g1y?=
 =?us-ascii?Q?mS3iJlPADC5t8/ULq2iUW/iA/eOPDjyr63eeVGbgXoVhkwZHKFIiU1BIQluc?=
 =?us-ascii?Q?95eNazxRfN2gBGG+HT5vakCPqgZ9BhQ9VpnDzdTk+3n/AhQh6qPexY9YUoxQ?=
 =?us-ascii?Q?r1sIBsFlV4XIsmjzAFAoyma4FGHOcaK6QUpkSKXNQAvN5GoJpHr0meh0DPJG?=
 =?us-ascii?Q?Wx/SqpUVEWZIm/4FeN+stedGIAFkkSLKVSmXm00O5y+SVjGVMk5g5GIDmL83?=
 =?us-ascii?Q?+IdMRRzE5GKi3J1s8igPZ8er5+41JxGrAHTFxeRObBna6ddXYUL7eSDMwiE+?=
 =?us-ascii?Q?CouX5Z6+YVVFb0vBalD2T5KsPol9YDuMMPvxZoggPkJ3/i0YhnaJzt3lfiJv?=
 =?us-ascii?Q?1zVNLIxQVZHKahEHBPyqOdSbPfeh9kvaWH1OaLxRv9wB6+f2928+fvRF2glG?=
 =?us-ascii?Q?Jg4UnLnffG1y8rmpVPXI6RG9BQzIKtHGgiGOPYdxE3Wxvsyg5fOzvLetIHv1?=
 =?us-ascii?Q?m/YxQ0e7HjLoFNVIei91ELcyJEZEtM/qh/1vuwahs4bFcu2n4x7m3o2H6YDZ?=
 =?us-ascii?Q?QNErhdhs+jO2AeqgG5KyMmbOlZN9a9UvGb8Mq2RPKlkzvu7ZaHGlkucdpgpU?=
 =?us-ascii?Q?HwqpLcuBuD+HXa7iwDNYGMUUvkk8mr/ppQxcOMv6fuMI2LkHGO5QRqg2fmlT?=
 =?us-ascii?Q?LLk8g6KD38fmYKAUW1VtBIj1K9imIwgjwVSZL6w79AS2LLoHPi9LCYPFnltN?=
 =?us-ascii?Q?sSdlfJMbbCkoXdz63kG7km9G+i5h8xVHFsUCJ9hDC1RzwKQQ/fhMnhAuH/pP?=
 =?us-ascii?Q?ch68fHLLEV9+j9ruyLVD7Lil/nFGVIRhTTpBYQshMJhMIuc/aM0uYyqM/kDz?=
 =?us-ascii?Q?6mihUzcux1g=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5757.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?puNHc3Z8GXMGaWZkoxhpuBbaF7Z7UWLHP/jLt/GRYUus7URhLKkcKn04AWxk?=
 =?us-ascii?Q?seGUJYpIuKkREmgF8akgId2qQQMS5jCVxmHgimKttTXEWgyccbwayIzi2aX6?=
 =?us-ascii?Q?cUIQha6HPQph72MP9j7c0GWapgYjNKovwHlMzuruWFiuYRVCDNAYd7UNibYL?=
 =?us-ascii?Q?A+0fNKhrN84gQKmecNX0p/D1Zw61Z0J1Fe1T6lSW5iVK+TVazhTtWfXNPtEa?=
 =?us-ascii?Q?9aSL3iuuJQnpoDcKb29OdLInJicV8YLGT3c4R/aolGkwa4Gdaj//QCE3TPVm?=
 =?us-ascii?Q?dkbVvu72BpVPZ7t8yzrrSK6Q94w6cfiP9kClkK5MoCJGpdWJ3DSrXrK4SJUx?=
 =?us-ascii?Q?VL8nrAH9MzStu0rX9qXoNTEBD99u70sXahdMk7j60bdLRJ5NyRwlLftinbvB?=
 =?us-ascii?Q?utrCq1nhgqHQfUp+pudwyELoApRretIhGjdgYpeVfG2yvBFKn4qVYgrDq7IC?=
 =?us-ascii?Q?FsrtkIJwtqDn+lQtBLt8tFMpO/kTtq8MYEGoPzxpYFP5GM8RAfTiTd0KQedC?=
 =?us-ascii?Q?/yGe5iNShenSCrYe3tKsKQbw3JNAOdfLeKwTY5RGgOSjVluDtCJrkAwuHGPa?=
 =?us-ascii?Q?80VSaDdd9OoVHD2cr6uCz4DlNiz8mfvVwCrsJZTwT0hL4qRvPeW/4MrrZlEx?=
 =?us-ascii?Q?2tLI/3BE6CrxrCZuIE8jEgSr6jUe93YYDqwsBgkMMi4H0jcxSOUaYYdXWjKR?=
 =?us-ascii?Q?RAWwnDhIBtcI/mWB7SJwOr7mfefmJ3tjCwopkKlDdnk1jKUlQQcrLbVYLGNn?=
 =?us-ascii?Q?AolQyIlkB7tHT700z3BlvWoNk3U1hmhJJMo6CIZvfEhMprff5Fof9/8wBg80?=
 =?us-ascii?Q?1ffQp409zG28mp7gEbzugiSTWZea4hqdB/YNKll4D+TBxhnWvNyY//ctqyKg?=
 =?us-ascii?Q?SfX5D6fHmkP4G21JvjkrdGJbtJff75guzY5vCmQ+xU1GjQ7jdj2X4DqvET6k?=
 =?us-ascii?Q?4lnJRa9nWmgikN9v+AXtT4apDWClOqO9r25krgd/Y7CIrpN/N0XWiuWMUFJ5?=
 =?us-ascii?Q?j7hmN+pw+Yj8yHawkiD/medxjZzxa4pVSssaCJ9kP0BHIpn0bsHflQ8ZxpqK?=
 =?us-ascii?Q?slCAGSx9Q9Y91MKxFaeMX+WxpjMrgKGxSukCLjKU/EJ+xambNnYOzw7fFSGd?=
 =?us-ascii?Q?ywoOG0wxhGUmeQFtxf56F0VYqeAZIxUxkLOt6IFBjX9rmqPaRjdFxHq9SVpH?=
 =?us-ascii?Q?mCtH5uVb0xG2GkRRLO+Cr/7DxevWFZQuhCk2N/VaMpZEO5Lj72M9ZwZe0x02?=
 =?us-ascii?Q?EKaIdd0x5JyTuroybGUbBjllSls+JCAWH+4HKSle4hB/FvXgseIBzaw7sp2/?=
 =?us-ascii?Q?88aYnqVmfdHAh1kbGiuLI3CAziqOFumypgeaF4ikL89c8AcrArZwaXM4Xjc8?=
 =?us-ascii?Q?Aad7smU8946SzTeEVvNCcyO9U7v8p1lvQsiFiTaCBgiv7K4LAviDOcytOmqd?=
 =?us-ascii?Q?NbG8UyI20W0xq0uccOrnJYUe3+lfCiLEVw/2CqDOqwgUbXUqCy9Ppfsw1SJb?=
 =?us-ascii?Q?uNZ4sYHZPlsYdLsxXAkmdbCHzSASMUNqjN7wNpMw1PmwLUlFhJlxF/eiAvEH?=
 =?us-ascii?Q?vVrdHqy/P75ZzvLMVxc=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 386a6328-7435-44da-9244-08ddeed93593
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5757.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2025 13:11:23.3097
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tICOvs9SHVif2QRV8+lHUpobroN8UIyUJxKgWUsntnopVcEqSChA4jmi1I7jBTlH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8335

On Mon, Sep 08, 2025 at 12:10:41PM +0100, Lorenzo Stoakes wrote:
> @@ -151,20 +123,55 @@ static int hugetlbfs_file_mmap(struct file *file, struct vm_area_struct *vma)
>  		vm_flags |= VM_NORESERVE;
>  
>  	if (hugetlb_reserve_pages(inode,
> -				vma->vm_pgoff >> huge_page_order(h),
> -				len >> huge_page_shift(h), vma,
> -				vm_flags) < 0)
> +			vma->vm_pgoff >> huge_page_order(h),
> +			len >> huge_page_shift(h), vma,
> +			vm_flags) < 0) {

It was split like this because vma is passed here right?

But hugetlb_reserve_pages() doesn't do much with the vma:

	hugetlb_vma_lock_alloc(vma);
[..]
	vma->vm_private_data = vma_lock;

Manipulates the private which should already exist in prepare:

Check non-share a few times:

	if (!vma || vma->vm_flags & VM_MAYSHARE) {
	if (vma && !(vma->vm_flags & VM_MAYSHARE) && h_cg) {
	if (!vma || vma->vm_flags & VM_MAYSHARE) {

And does this resv_map stuff:

		set_vma_resv_map(vma, resv_map);
		set_vma_resv_flags(vma, HPAGE_RESV_OWNER);
[..]
	set_vma_private_data(vma, (unsigned long)map);

Which is also just manipulating the private data.

So it looks to me like it should be refactored so that
hugetlb_reserve_pages() returns the priv pointer to set in the VMA
instead of accepting vma as an argument. Maybe just pass in the desc
instead?

Then no need to introduce complete. I think it is probably better to
try to avoid using complete except for filling PTEs..

Jason

