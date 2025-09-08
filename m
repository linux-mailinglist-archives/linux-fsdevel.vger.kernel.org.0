Return-Path: <linux-fsdevel+bounces-60516-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B362B48E4C
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Sep 2025 14:55:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B18B1890852
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Sep 2025 12:56:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABD9D305964;
	Mon,  8 Sep 2025 12:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="sttyjNGN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2069.outbound.protection.outlook.com [40.107.236.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88B0D304BBF;
	Mon,  8 Sep 2025 12:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757336135; cv=fail; b=feyroTsKzu2X/bqM75ZeVaCmt9ujfe2g6XGTPM0BDAFmk46UrLiHjoRpXy0tbkltRPIfPpyeRksEUoWinTzG6XzidobWXaNf6DVINIXZmUcYA/KbXzO5a7G1Dkk5fjjt0gASOS6xieb3l6eU2K56sZ0BefSoIzR7ZR38xlw0LX8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757336135; c=relaxed/simple;
	bh=RHBK6zdZ2tFERUGyYl6QeDFQzZswFJ262G+RzFhu3dc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=fdmZezwP4fdjyIHC2X36yPHMMiQ6cK1v+uITMF5+InuvYn+UfvUfUB8CPLa1j61VyOGkq5e5jXI3aegJTG+OThTOLYrJrsvb9k14mzwnsFsnGZAUW6Lp8KfWcLA4s9v0ZgxrH/HwvHJgXCV3DgtVedbYBBfW+buaNZ6KLx+h7SY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=sttyjNGN; arc=fail smtp.client-ip=40.107.236.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mQaF8TJ1Q4Emvgr2GrBjBSvbQPLhDZ7OTnTBlHBCx/gFfE2XbxfwBHoeDtY6LKbHLMimyGmikOQTd2HstyUvdiYnuOK+6v1xx2JC8cbhuTFB44MyG5r9gzMiVrX3DSNe8YFtVMykr4EGR8YqkcAQ1p7GdEFXIAgEDLnFd/ZmenDy7fNCsMceHHciwY0XBwmJHBs7JTaGBMfRMO5M/f262/MN4IGqRyjbxFU2Cyfwcu0ns4olbKTBYkoFMtNpzBIJw9HuCE977oFwJj3YHNNAmS9rW60S9Q27qUBSYkpLzhAa0xsnRfr93vVc/uTaQv5BwrEGvXF2IAkXBN6fGN1K1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SRrPfiibCGwC+zaCjoY5N9gjObQEi6dhTCBpZrINs4A=;
 b=TqCagHm19sWiMkS0WD/VPlt1A7ONWi485AzlJ4DuwXLFhQ3YqCxUHnwU8x2Unqd+8pPKymPmRFMnmnpF27CowACKwcTf2OQBnkrOQl5G1HzwzdNCuiSV2Epw62P/rkMJ1SpvWnNcwTCJqj/55vv3apPM0yYL1ZWz+tGj9whXEgBmc24oloxFdI0H0e5mr1wwV9QWn7Tl7QMChCM+oO8caiwdKhBBuL+t6jeFxNPYmGnf538LxsrmL9Atz5ORgnypDZWYoJFqP6aDzJQYqAlqXvqqkARQ0v6nSOiLMKfJWSbUuGjlja6j2TPS7u5Q7mJJXGvw2OF7D9wCcdYVT5+vdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SRrPfiibCGwC+zaCjoY5N9gjObQEi6dhTCBpZrINs4A=;
 b=sttyjNGNDQ+G7G913vDv4lLpZRPBykPXCVlzIIftPMdzXlUM0rBpZTm85FJ5Djac+fnWA6MsmHtecPumB/uzY7lFqR864bskisyUXUqln705JDY7PFNT6qhVqg3Q0TOpkhJDcsv5I2K9WY5g+pSQcwugTf93GAmOAr+3jNEWOljxfxhC6tFtgPriDct+BUdYDYlvTiPm601miMLxEdNNWvpw+wBCoUExIyAcb2xjDu+/9+jD9C4l+kuAEhwHppltDpMHT5y94VEwXuxoLKvYrfTbRSvbkEpF3oECRk8HvWyKUKxmozkjQ2frp502c+hotaaeNDicJipaq5EJUP99ZA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH7PR12MB5757.namprd12.prod.outlook.com (2603:10b6:510:1d0::13)
 by DM3PR12MB9436.namprd12.prod.outlook.com (2603:10b6:8:1af::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Mon, 8 Sep
 2025 12:55:28 +0000
Received: from PH7PR12MB5757.namprd12.prod.outlook.com
 ([fe80::f012:300c:6bf4:7632]) by PH7PR12MB5757.namprd12.prod.outlook.com
 ([fe80::f012:300c:6bf4:7632%2]) with mapi id 15.20.9094.017; Mon, 8 Sep 2025
 12:55:28 +0000
Date: Mon, 8 Sep 2025 09:55:26 -0300
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
Subject: Re: [PATCH 06/16] mm: introduce the f_op->mmap_complete, mmap_abort
 hooks
Message-ID: <20250908125526.GY616306@nvidia.com>
References: <cover.1757329751.git.lorenzo.stoakes@oracle.com>
 <ea1a5ab9fff7330b69f0b97c123ec95308818c98.1757329751.git.lorenzo.stoakes@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ea1a5ab9fff7330b69f0b97c123ec95308818c98.1757329751.git.lorenzo.stoakes@oracle.com>
X-ClientProxiedBy: YT3PR01CA0129.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:83::17) To PH7PR12MB5757.namprd12.prod.outlook.com
 (2603:10b6:510:1d0::13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5757:EE_|DM3PR12MB9436:EE_
X-MS-Office365-Filtering-Correlation-Id: e548f10d-fcaa-4f1f-3736-08ddeed6fc49
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?hOLzpllpfjJV1l75dvoebmxablzhZqGRn02hp8Er9zgVtXKfRDLHj2J5345W?=
 =?us-ascii?Q?78gWzVSOi/uCjeTviNl2jHB++OnlYRXhAOCOBLt95Gv5xXJEo+GWYzpkmXbB?=
 =?us-ascii?Q?BWTW60yJJCrxSOv1IFuMBcKAt/TP+jnP+hFI5pcQInxMhYYGyU2KN0aZHC0+?=
 =?us-ascii?Q?hzO3kMnN2ee49kPX8q4/7UxJMJSou6hisu7UwZekP/LW+TwwQJXCnIYZ0+3x?=
 =?us-ascii?Q?VmgX2HvwEMe+Y3WA0WH6BnwdUP/bWjSYmQzDVBsZ05R1tbXzSxSCUBlbqv9w?=
 =?us-ascii?Q?lxj/tIckeFbx+GZm7onzTt/e9gXpkdUNwdpzEEb+VIt4heM46O4h3zjtG2dC?=
 =?us-ascii?Q?xM1EADd7FTc0PQFf+4YVFYkvpWXx/fOnlAcXVNDzRltJyL2eHio9Hr+ce5lI?=
 =?us-ascii?Q?mtFieFut3fMcMRPAtN765t00cpPPo5VZzMiYNhGbcND1gTVKygcEgus0R6Hw?=
 =?us-ascii?Q?wQjguPGow4ulCHnmM8xKxK+U97cWc0HlzpVBWayhXtoPf08EVQOkiasN4PD+?=
 =?us-ascii?Q?Sm3JvUgGPwZ/GGMYfAdFHwjP02+XFNY0CEvENReVnYRvPClAvo2NAc0KcdpR?=
 =?us-ascii?Q?NEp6jgELeHQdzXGx4IG9vDvbzO6PVdU+QC0EyzIoImwLdjq53u59d3BWpyyq?=
 =?us-ascii?Q?ZJzIAkopxeQzhWrvE5ogYgqPA3TLI+IJ3D5IjKByPTjWAMYRXQsays/pTUfa?=
 =?us-ascii?Q?BnUPRKjVuC33UDGLTBJfhE4vltW06tds7r1DrRcjPtbyStlfCUeOYSxHzGPT?=
 =?us-ascii?Q?VTFI/YKhTwJgEWgkKL3EQmHagke21qNpFK3d86cybJEtp8S6YWHduHTOGguz?=
 =?us-ascii?Q?+UDz5SBqnAY4Sq8XY1Bn7nbBJMmC8BU88ZzkfymmP5lh75OWkDerG0fnxosC?=
 =?us-ascii?Q?Ryq2IHLf4vdOKs6EP+kDHi633+JCo7Uj4QsnTV3KcIdS22vTCT1iY42ql5vx?=
 =?us-ascii?Q?qB9vOhOS6JniEcZTVkLNfNy4kq2cIkx1IO+1kbgxH42/gyN+sDEjev6F6vTR?=
 =?us-ascii?Q?4tS/CLqI772rAIHO61GOrKu4R9t/GHmwu/Rdxtn2TzJb3pK8o5l+O1K/Qkan?=
 =?us-ascii?Q?zimXSYbaR8Q9AORsvkaCDCOWr7syEFCJHUyj2PrCyYh3r0vitqAgg6q2Wuoc?=
 =?us-ascii?Q?B+7NXMLOu1/u2zrDL36DXH3k44vthCEpmWwigNs48+h0kC/dzi65Mf4lTnvc?=
 =?us-ascii?Q?Z1ST7LnmAreJ75qxW9XZBloCcX97po0b8+lX4Aq/d38ml0vYYnohbrpcxfk6?=
 =?us-ascii?Q?bOQt9XNON+AuejEphu4zi9S9TAMqjrG6qK40az0OJclh0TOdfnkEEmr+Oqgu?=
 =?us-ascii?Q?E0G8SrPosfwSCejBRRfmTnnpn5mdPdLzT5+JBerjLC9fofTUTjGnGhXUaWfD?=
 =?us-ascii?Q?7r8mVW4/7qmjf/Rpz+4Ry8SrkJxUcUwHvSv8lw/uNX6sWIZ5Ag=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5757.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?oIcDJZNfShniNK/etH2wxFhi//hajGhHFdmCnLtf46OOA9sGmdBa6ghcVL+r?=
 =?us-ascii?Q?tJsF7W0LaEDWk/G96KUaaXh1nRYASHW3KS1ycu/I444a7rmYdAaILZK0aRIW?=
 =?us-ascii?Q?bloidKoYiuWF3x+nLsQGKj+bB9KG262oSIFnC8cIE3P6h2mzYAws1eisy/Rg?=
 =?us-ascii?Q?yebflx546I4o5RFGYPdC60jlH5l3VjnyTSjoJTvuJpJ0mkoSaW8A2lM+vJDM?=
 =?us-ascii?Q?XZOLW2zkX5EH2m5lwoQYAuVjjLy+R90YCt7jEKPGO+/WIeDM6/E5Q6DuSTGp?=
 =?us-ascii?Q?uWUlekAmQ/p7wb41CQD87q6JPiXYM5MsQx7YtBpDsmpbrsLj8BSmRqvS1k8p?=
 =?us-ascii?Q?C8LGW1X4ptEKAVsx7QBVKEozTCFUb8vrEAVHME9nJ9poRhvWEf6v1PjpeHPL?=
 =?us-ascii?Q?tNbZOb370TyMwaxMAFdBen2DhXJVgL1ESIS7fwyTTCwKyeH5Owu5J/g87/gr?=
 =?us-ascii?Q?8DmXhL04uciEofkDaWOVo5MKmxRidSgexagbUJYw1D0CeA1AMY2lVBl6/VwH?=
 =?us-ascii?Q?pV/Wuy1F21xuWysnkCUmqw8S5Z88dEOP2dlaAgGa/6xuf7HAtOGq92rpboU6?=
 =?us-ascii?Q?5hpY+K/ICzuxjNfY1k83a5NODCYa/RMpR8hThZCq/hbVUNYhatN4D0gF7Ch9?=
 =?us-ascii?Q?KPchDhdjVejDLm+JyHKSyM271BGXc2rzJeo85M+XVi6pxOSX8oipqx2b2vVH?=
 =?us-ascii?Q?C1RJS14MPXgQdV2Y/8pa2vvSduj8cK2ral9q7qb2gzb/MUJpOyrN06f2xcem?=
 =?us-ascii?Q?y9FXKGjk5zmsjvnhrUfDwRg6qDl/aOUj7/BeDQ+gLA4dYOVneZr+9hXCYtrP?=
 =?us-ascii?Q?dEJH18C9o/2XRP9eYGEVP8Z8ENp+VJ+QMicnqvlNet8NAoLN2ijluDcOJ1Kx?=
 =?us-ascii?Q?o+WvMYu+vel7+YSIB9ahPJOFkibzzFFwqziLB7kNNMoSN9VWfm6b5v13GYQJ?=
 =?us-ascii?Q?LMFPvguxw0nZdc57UiR4LyHBPvZt0836oyaHB+8qwCDdqqvVGI95HLOEXF8S?=
 =?us-ascii?Q?ccXQkOd9L66atXWy0ao71ynwNeA7vMFwmTmWBOXfRm5mAevAKSaZNjAJfcOR?=
 =?us-ascii?Q?nA3a8uEpRPdoIid3oNXQoFidwuky8uaA8d8K0xEWk8zlfRVkn/6gFCCrIsPX?=
 =?us-ascii?Q?cS7HuUCuC4JMIL2N42DCcvBywJFfe26tUe/TXt+TOB5SdG6tTkiORdoIEsUf?=
 =?us-ascii?Q?GnpHy0g2eScGN2LRgLkvnXUdEMnI/a15/JauikF0o2L0fhxD0sHwgjdURlSh?=
 =?us-ascii?Q?j36DzNyUDA9lM6F4QKuvOnICWpO/iKvojedw0sPRuXz55zE9vJulwXf7OwB+?=
 =?us-ascii?Q?vSNkpvvVEk9t6NDVfywSeVc3N6KL9lCubKIIBHZ9bJQ5Gw4c4JalYyfYaW2Y?=
 =?us-ascii?Q?T/J9gV8VBDTidnU1t7xWplV0zTSXHnND9NY3oqiHtwTEYj/lPBq7YUAX7eLo?=
 =?us-ascii?Q?LagfIR/gi2VRT6iBUhCn9M6hci1o57VZTx5/D6BhamsApghl1Ik/1D5qHHOm?=
 =?us-ascii?Q?0e9Ad9bjpMirYXxO3jUvxq24gAONWEPpp4qAGi2880kHK0OqlHoZ6mbDsDq4?=
 =?us-ascii?Q?c3b4KJPEvHvZB8pvD5c=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e548f10d-fcaa-4f1f-3736-08ddeed6fc49
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5757.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2025 12:55:28.1443
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R1ezjMFFuTM5OI0AydpXJG/5y8pqqbydzBG9m50QBq7gRMt9aV3i6yuenmm1weHj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9436

On Mon, Sep 08, 2025 at 12:10:37PM +0100, Lorenzo Stoakes wrote:
> We have introduced the f_op->mmap_prepare hook to allow for setting up a
> VMA far earlier in the process of mapping memory, reducing problematic
> error handling paths, but this does not provide what all
> drivers/filesystems need.
> 
> In order to supply this, and to be able to move forward with removing
> f_op->mmap altogether, introduce f_op->mmap_complete.
> 
> This hook is called once the VMA is fully mapped and everything is done,
> however with the mmap write lock and VMA write locks held.
> 
> The hook is then provided with a fully initialised VMA which it can do what
> it needs with, though the mmap and VMA write locks must remain held
> throughout.
> 
> It is not intended that the VMA be modified at this point, attempts to do
> so will end in tears.

The commit message should call out if this has fixed the race
condition with unmap mapping range and prepopulation in mmap()..

> @@ -793,6 +793,11 @@ struct vm_area_desc {
>  	/* Write-only fields. */
>  	const struct vm_operations_struct *vm_ops;
>  	void *private_data;
> +	/*
> +	 * A user-defined field, value will be passed to mmap_complete,
> +	 * mmap_abort.
> +	 */
> +	void *mmap_context;

Seem strange, private_data and mmap_context? Something actually needs
both?

Jason

