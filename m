Return-Path: <linux-fsdevel+bounces-60539-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E68B8B49134
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Sep 2025 16:21:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 71FD17A2A3C
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Sep 2025 14:19:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 195D130C631;
	Mon,  8 Sep 2025 14:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="UFYRNqXu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2074.outbound.protection.outlook.com [40.107.223.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E192C30BF5A;
	Mon,  8 Sep 2025 14:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757341222; cv=fail; b=lCR1/FhLx61B1DfgLIRHii88EI8GzjapY2v7wsmgGchZlgly8oJIrk9B5vsXmnkbyVF++JHbE3afEklmgMHJkvf/74O2op4W2mkM+9xaHFwHhrqV3nDlmfSklAYgf0Ojh34pE/o8shc6DxKCd8uwh93AvtUL9jrgnWJiQTtxXYM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757341222; c=relaxed/simple;
	bh=sKY5DSSRaz/arg/V8RYnrJqqs0IMaZTvqyIO62JgZtQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ZvpREmmSBY+3EHEp8Ae1v0/zUHBv8vu9UYIkHGE8LD9VEmsjEzR8ezplbN9D0j5EqxklKqlmFk1nm0BkwjxDifazEaqwQRGLIqD0kJxDYZ/iqxIjodQxYebAjY6ugJZqliPTVzHvwndKedHfHBY7Zw1nE8q7ScGtahafGO/v0BQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=UFYRNqXu; arc=fail smtp.client-ip=40.107.223.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RNH/kE0p6m/E0nWgExMvUaM2ySQsCmnXob1z3rgw+SEmOQ5wIE4v/sBJMtnsw7utCrCpdnKfSTQaaIQXhtPN/YJjFUzW5uy2gi1uqMmG8KfQFmXLMENQH7Bv+QLgQKio8I+NqtEU02NbaDiMn8eM6XhC0ej/sJHO5+Rr1xMXKjsU5fNuZnVwBIdL/w93gPapqmFYY7XhQTfYe9OWyn+Wb26cUEBUOMj44OBZmgp7yjFJkk9NkKgK3iYuTR/XC42i9x9J9aI56zH0C0l3c+szvaI+DtztTUAOvR7Ltgv0gpt7aOsDvKLa9CbLMf7ut8KcdhLusnHNMO2tZ1Eyz2bWLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xBtjK2xUYRThSvljThoLHjNrXDf79zCXXd6yIWgqAlc=;
 b=BPE6stLqcVZhc2nYOb/Zo4bS4f9o2jCgBhr/fMD0Ltl3tDJ82ctJvMyazoX00K/1FEIaPSbCcme0BI5glwj2Bx13IPM/Uc7oThs9vd/9PR+JsPr8p5+s/almpN+eENW2RPcJ0lPUWbOSBzSKsROoPYrLKd0XOSyMln2jJql2B15uFFNss8iHnAZtF4k8tgVtJ3xdGi86MJRdlUnyyWDnOPzR8Sw7Oqy26WAaU58yku2EGI3nnGiw4GkFtw0LPw1iFHMdNlYuFxa9j71koub5Sxnb1w2dpkwuNxAJLzCyTOoJkaF0KhU4KQHV98aDybdXvD/1SkDhCjgryacGFo96Cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xBtjK2xUYRThSvljThoLHjNrXDf79zCXXd6yIWgqAlc=;
 b=UFYRNqXucmY0xZwv/UQAZ7cu3fj3Q0gkzeEs+B2diYniRwEDZD/F1WxKwcd76+1/oO/PGvYBDs5aBceZ56yBh49mFD+sdTVTgY65gzv9x2Dem1oYEDv+8qiQYDpiZD8CS9WcInaPoRFgJTATWKKvwj+I5dw74yA51mqKRX7B0K49tLiO1beCqQDAGHzCFgDviOXa+EXjvVgh8MK0gDiMzyQe5BT4wdzPOHzoNalT55n6KEXCBC7zuCashVtxwtVdcQpqHfnGpeP6tqvyGtcXszWgsLgX+gBCR6FZg8QfUCp0GUGaPYXei5eEkM2mKB070nbqt70qnH5Jb6VxKBKR3w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH7PR12MB5757.namprd12.prod.outlook.com (2603:10b6:510:1d0::13)
 by PH8PR12MB8605.namprd12.prod.outlook.com (2603:10b6:510:1cc::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Mon, 8 Sep
 2025 14:20:13 +0000
Received: from PH7PR12MB5757.namprd12.prod.outlook.com
 ([fe80::f012:300c:6bf4:7632]) by PH7PR12MB5757.namprd12.prod.outlook.com
 ([fe80::f012:300c:6bf4:7632%2]) with mapi id 15.20.9094.017; Mon, 8 Sep 2025
 14:20:13 +0000
Date: Mon, 8 Sep 2025 11:20:11 -0300
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
Message-ID: <20250908142011.GK616306@nvidia.com>
References: <cover.1757329751.git.lorenzo.stoakes@oracle.com>
 <d8767cda1afd04133e841a819bcedf1e8dda4436.1757329751.git.lorenzo.stoakes@oracle.com>
 <20250908125101.GX616306@nvidia.com>
 <e71b7763-4a62-4709-9969-8579bdcff595@lucifer.local>
 <20250908133224.GE616306@nvidia.com>
 <090675bd-cb18-4148-967b-52cca452e07b@lucifer.local>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <090675bd-cb18-4148-967b-52cca452e07b@lucifer.local>
X-ClientProxiedBy: YT4PR01CA0476.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:d6::16) To PH7PR12MB5757.namprd12.prod.outlook.com
 (2603:10b6:510:1d0::13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5757:EE_|PH8PR12MB8605:EE_
X-MS-Office365-Filtering-Correlation-Id: 433c19e2-04b8-41f7-f273-08ddeee2d31d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?2/e+sCnBbAJlzNRhx38zyvxidUk6CswXCQcXZ0MlNvez7/S82amVq4uzFit1?=
 =?us-ascii?Q?PTh/wEpu5oFaDZZ1qU7VNts8KiMN37g2tMnL2ohZiBea3z+L+urKiyBMKcY2?=
 =?us-ascii?Q?/un6gpXM0wIIfgEMxsR0YlR0YpFtMnqwcfzk0aMNyIobsAJt5gntFH1FAI7W?=
 =?us-ascii?Q?h3RY5zUEEvnaGN4Wl9KBNMa85zcKzAXp31IeNRDLS5wuJRvwWZ5ei5CqCO99?=
 =?us-ascii?Q?cw9feOH6m9adddcGUWwNWFDFn/Knkq/7i2/0I8hIXI1JM9oAUD5ybauCI+LD?=
 =?us-ascii?Q?Am2mzukuWl1slpEAZTEfIMesyAJWv5MLekTlHOv8qDcA1JFTaVI9n0m/mstH?=
 =?us-ascii?Q?ya/c++px5TAlrMUjd543U8j9mjZmxrXdVyTLR69bcCpT5qCDfGeXd/9q92RF?=
 =?us-ascii?Q?sfQiUxc+vB1/GBSC8GLBFbKPeYHvK+pP4fbiuHateKpnX6M7D00kkheLHPK4?=
 =?us-ascii?Q?YqbDDkqk2Ggsl7Oh/xXtnryNsq3spCzpaWJI0rbO3ozgQY/2VmpRwNxj5XPJ?=
 =?us-ascii?Q?Vq2OLJrP2hFFa4WUoV1nXP+dUtd88UNbNy0s56tD2EOkxtChiN58rDd4Z/u1?=
 =?us-ascii?Q?y/OYAfbjSV+JDv7pnYw9LtF716VNmYvslhkwpL2O5g16SVjs9M/Po+TCKkIC?=
 =?us-ascii?Q?+tZx74XBMVVumjxBpHWYm3xhEVEIOLRBAv8uVs6zvgrv5v2yTxtlV4bvIx5p?=
 =?us-ascii?Q?PvN3FWS74u4G9QmCImf/9gEyeRTWRH2ZrYcJh6VJmziiZ9bZfWakmpBCRB5h?=
 =?us-ascii?Q?Vw2lDPxHqfG5LH/9CWH9lawOiS+38dP3jxOodOZdqGWFbydlcordg5mfU1AB?=
 =?us-ascii?Q?2WgZF/5FSEtaaERf9652uwuJUbboRx+RWInPxwBWTT7BQaMTw8o87Cu69heM?=
 =?us-ascii?Q?9c+FD7YgCsrHQV5VdFByGmTQmOfNEYUquYQAHM7QGvbhezI/Jz2Y+gf+Q7hI?=
 =?us-ascii?Q?fmMkikBkl3esOKBXcWpc/jIg4CWCxIpecSIgdZXRs9l6AThnn4CsqgqdH6Xd?=
 =?us-ascii?Q?VKUsLzccusIC5FaoQWRi8tTxSP9XPmdGfFUL90qlRZrKE4H3mhIR/i+bGY+H?=
 =?us-ascii?Q?A978hVBWNcbH6CC+wTPsOURc5UE/z1bCestZOgCfpqt/brk38RkC1GnBsLCs?=
 =?us-ascii?Q?zg+O56PdId9qmuOpfiqrYAvlJu9J/XVV+4XVn4sMFCXDkPVDuOA2139CY9SY?=
 =?us-ascii?Q?cwi69ZUm0ATkUL8wwUFZUsdaIR8P1D+nZV2WC++OKDSYNSbrnP9uddNECIH+?=
 =?us-ascii?Q?6TZmobnsu99ytyvT6ry2b51ifTW6gbRoD1pKgUYcynHQ/YumDBgQC8vMjAjM?=
 =?us-ascii?Q?dbYToOHOzIgzy3FY5vOvT9Hzve/7L2RZjCcm0yebpcEV78XgwBupiDi7m2/Y?=
 =?us-ascii?Q?LnDTmdvc19YoLCVAJqYgEvwFnwld9+EuyTPDYzoHJkrdRuWujg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5757.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?SOsWuvp3OXQPEbafdV2Ah9UA+sA+AYS5XicZlvVGDU/WB3IjOP9trBr3Rrmp?=
 =?us-ascii?Q?klpuwijHfTBO/vtVH0lh5pW4BBdZeG0xhhRqxuw0I6bwFvDSmzdiSRw+BSAY?=
 =?us-ascii?Q?OX52q2SKJnqX9Lm7wPVYBSWRMHjRpQDcBS8XxXV3oQRzNjLGJo0b7oDucPbm?=
 =?us-ascii?Q?fDzlUmddfk7qSK+EQ438HALg9i70ahaEnzKl33NHIzLzknzuokMLo4Oyvd96?=
 =?us-ascii?Q?Q3SrTvmfgBZ+Wat+3IP8MlD0zEa9f/qeihDeGl//yf+9MBibPbQJW9Y2Gv8U?=
 =?us-ascii?Q?mdeOYK3HIgvWjdruunXBJjA5ZOd6D8o3G0wr0gH3hGCTiqaKJVVUmzzeH2tK?=
 =?us-ascii?Q?8/BCL4kzFsAMKiJ1hNXJw7fdn8CYbSnsf9y1tnujF/n41CcuPlny57LU6ri+?=
 =?us-ascii?Q?iFsq/W7rdJ9LHpGuoZibwJ+QSHkLPIIKCn+3SHwhba5+GqU2ue7pI6suBmih?=
 =?us-ascii?Q?cBRIpWKSlSArS4DXWYkfhyEkkc7Kr6/0PwC0DM3eju8pHWYtlDbiVQoIKCJD?=
 =?us-ascii?Q?OrJL701gNmldYiJ4FHBD+N1qVAj+kiCASawyxx6hcYA8hG06EqS4mPfrXZDt?=
 =?us-ascii?Q?O6cUGdoMWNGcz+r3Sqj2KtW2BYExEN1UMOs6I5nxCy0s+M0i9gKhmLfwtF+U?=
 =?us-ascii?Q?+GtAoo2uOzNAnJDSZ6ve6bjmUHpT93EuzjFi01jEvF3dL/XXBbyt0HcGhA2F?=
 =?us-ascii?Q?FV4v2xM9MGZa3KOGWYpMyQryAzz06I+PSI5BeZxHYGWMBk9/7pknlXjjj+Kl?=
 =?us-ascii?Q?jnq+JhT8VMLaBUwCZvOjkfcAlRpwz5EzgnyCLY3xPt5Vr5jQiUBM9i2YVfY+?=
 =?us-ascii?Q?A8HBckXDUbxR9DkWoXMlBN1ncg4WpegCPiBivQweLB9IveIM5wDN/DJrxhsJ?=
 =?us-ascii?Q?Tk/poBYgPMvVgfCZiC5mLcRW6SReflBb+3LuLpvgm9t+rGOT3u5oJBkVjk5G?=
 =?us-ascii?Q?I6VXXOMQIVdcpF8Ov0yrSY/T1+SgiDTnA/ixc/ZhVrwUHsPtyHoa8mtfMDhZ?=
 =?us-ascii?Q?2dqOxKp5Cu68gCnBBdm9lGdLBuGtiwEQerGTTUw8Q6WpePZT2o9U5Es8HLA6?=
 =?us-ascii?Q?zhzGpXPU6VHaHl5X0FWYYEQgJycS/o88ijNsgAFnxyoZtxUQ8KwjpO+DdF2S?=
 =?us-ascii?Q?uWB/ZVS+645rHaNVlxO4cYLcdatA4CxFsMFzSiJoyRK6UsbnZWYUUG/yY781?=
 =?us-ascii?Q?hikhaSKrI1+ihxQL6Res/Lr0ZhDMEWct61VQ1/i6hLNQeeVZkLyRJXU+IuYZ?=
 =?us-ascii?Q?UUts2yb7Z0hsCtt0AtRqtbBb4u4IJX1WgnhTzqzndVagrfhv7vU/Rpixylzr?=
 =?us-ascii?Q?KrdmOG9qTgB0vfcPDPTXLE176aXV8WntG89Rc5Z31zpmKgV9Fgc59ybmYRQh?=
 =?us-ascii?Q?kNRTuzd5iA1invXazXoPYD/om2sI1V3bIUIFk1H3l2NwAstv2OpS8lCeMMV5?=
 =?us-ascii?Q?2PTv2pli8F7pU01Cvv2peaJsaCFkspYD4/6JmuXes53HkfK+fSClP8dQqw5e?=
 =?us-ascii?Q?3JTefc+eVtVVjIv4Ihgj+iiNNyG0FtHvHS7TFidrdMBzpAgLI2gmiNbF0AHE?=
 =?us-ascii?Q?P+ma8unw2vjJghVfkus=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 433c19e2-04b8-41f7-f273-08ddeee2d31d
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5757.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2025 14:20:13.0048
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 18fGkzI2lV+WD/XXMN3z8O1dmPyKXRbxKrZo49eWCtNN2fPiVvl6m7u0ZZAUjgnC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB8605

On Mon, Sep 08, 2025 at 03:09:43PM +0100, Lorenzo Stoakes wrote:
> > Perhaps
> >
> > !vma_desc_cowable()
> >
> > Is what many drivers are really trying to assert.
> 
> Well no, because:
> 
> static inline bool is_cow_mapping(vm_flags_t flags)
> {
> 	return (flags & (VM_SHARED | VM_MAYWRITE)) == VM_MAYWRITE;
> }
> 
> Read-only means !CoW.

What drivers want when they check SHARED is to prevent COW. It is COW
that causes problems for whatever the driver is doing, so calling the
helper cowable and making the test actually right for is a good thing.

COW of this VMA, and no possibilty to remap/mprotect/fork/etc it into
something that is COW in future.

Drivers have commonly various things with VM_SHARED to establish !COW,
but if that isn't actually right then lets fix it to be clear and
correct.

Jason

