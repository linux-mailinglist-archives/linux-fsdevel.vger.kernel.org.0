Return-Path: <linux-fsdevel+bounces-62031-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F27E3B81FF4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Sep 2025 23:39:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F14C4A5912
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Sep 2025 21:39:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDC2430DEC8;
	Wed, 17 Sep 2025 21:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="DileqXqA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010039.outbound.protection.outlook.com [52.101.85.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEE4A21C194;
	Wed, 17 Sep 2025 21:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758145130; cv=fail; b=EDYZqYEk2KPkrrCGz9u1fA5LZ6ztqFSwqDtqSPjmax8iLlu7PiikYg7Zr0ukrV4SgUZm4pq2lmNdl/2U2F3FXwur8gzfdKZSGb+ugahl0B3Os0/5Si3pfSW3SKmb31Xlo9sK6V3zp61KnswRuSKCxqKois41MgW3B9NMY/LNpzk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758145130; c=relaxed/simple;
	bh=0aPTiA1WJLcug1hSUsVydLCj29zzzjMBHdXEhg326KY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=iKtXu8/HYTukDnZP8Jy8C4bsyyKfTxbboS3bzdNoT6W/gd6nGOROvmap7NXnUzie8wVwlFR4QK53TG9ACCcJXouvA+5Ew+7fcjSxF8bhzAEl8mH4z828jdKNkPye1R8qBAUv7OpxgT29dd/ygYkbdbqsTJ5Srjc4ZoiBag+z6tU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=DileqXqA; arc=fail smtp.client-ip=52.101.85.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DH45ewbwOslUcbwpcV2jFQnR1CdboL0OljoHbprUB/hWAkWoQsmzjAmy7Jcn96J5fdqWxVq07HRPZwLsoYF5a3P9WMbOtjfFISmE39BJBDqtNyMYiGQ+ZGLWXfPHLFc2CPAzP/b8se2x3P0d2/JvhTaD3Z4LAO8Zkr8HNYWB8MrDotRX8gdFs/QtxTJiv5v3u78jqTy5cZklhJ3WTdzUBPHOVUhUxs7Fry8NAascFGrdB/enptgueGuiiCK74ARN7peXPd7MbNr0xcjhZs0YVqTfPhzazj+jo2uTPsJZoGoC6Fv3dVn8CvkuTCtntk+3ngY9ENpDjPSGb9ZQu6qi2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lF5KVuXz/1zcfTw3CpjReV5CJqzjHk74wv6/Oxx0d80=;
 b=F038bzCz+167/rlkjvDzupNY5apfYkE0S3yhqIJbQ5JTIRjCuYKCTAhdDgsOAc/7nxQ7sROxcchNMD0vlXs0g0b9hsiY2G+RbHPOH5sZzdC3UjJF5Zwl7kWEV1lYw1tdXLqLnHVvQfKjWyWwxNT1Z8RqXI4Ffz5hxUJ0uGeUO8+GK7PDTvleE5FTo08hukCI+wpXVGFuMD/LcTznrqPlHYYk2T/a5RLIr0c+jFHQ4/RXDvaP7rN+LsxKhm+J57YCKgy89nSi4wB1KwAR/qCBywgwqycbuKgXIPM5UAJ1khNGrMbTCnVhqaL/QYf8vUGLmuTFSMoWLt0399nfOe66YA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lF5KVuXz/1zcfTw3CpjReV5CJqzjHk74wv6/Oxx0d80=;
 b=DileqXqAXb+oTJd1vL3qMzsqgCht7KUXViYa6xdoSX4rvTnj3qt8h+kJlpReaekCFnVFqaOKCrEDXk5MhI9I4/nqSstN2ZB0VYNqVV8avff2WmsRJnN1nLzT4sFe7++azmXtpcvJYnfdgcrLrMmCbCp8zIz4uNZrzKGPAMIdfY9hyjOuUFUccQdLBJyN7lgBKFYuxftL0HP16t0W33CflH5MyapR3XrPzeUoQMUNclqx8+04Rb94QcEaN1HurghEei/vRXyGBkR3iMSJ9BLwKbmTj8YupPHdNdYjq7FNWDd/i8OXtHjLvoUM6QAplbKRAUEEtrEvaPKRtUhXhpMWlQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH7PR12MB5757.namprd12.prod.outlook.com (2603:10b6:510:1d0::13)
 by SA0PR12MB4464.namprd12.prod.outlook.com (2603:10b6:806:9f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.13; Wed, 17 Sep
 2025 21:38:46 +0000
Received: from PH7PR12MB5757.namprd12.prod.outlook.com
 ([fe80::f012:300c:6bf4:7632]) by PH7PR12MB5757.namprd12.prod.outlook.com
 ([fe80::f012:300c:6bf4:7632%2]) with mapi id 15.20.9115.022; Wed, 17 Sep 2025
 21:38:46 +0000
Date: Wed, 17 Sep 2025 18:38:44 -0300
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
Subject: Re: [PATCH v4 12/14] mm: add shmem_zero_setup_desc()
Message-ID: <20250917213844.GI1391379@nvidia.com>
References: <cover.1758135681.git.lorenzo.stoakes@oracle.com>
 <fe4367c705612574477374ffac8497add2655e43.1758135681.git.lorenzo.stoakes@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fe4367c705612574477374ffac8497add2655e43.1758135681.git.lorenzo.stoakes@oracle.com>
X-ClientProxiedBy: YT4PR01CA0264.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10f::25) To PH7PR12MB5757.namprd12.prod.outlook.com
 (2603:10b6:510:1d0::13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5757:EE_|SA0PR12MB4464:EE_
X-MS-Office365-Filtering-Correlation-Id: 9352092b-8e69-477e-afa7-08ddf63294bd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?auzMi/sTWx/0AuN+gPFH01Vdv5ix4f6Z/XsT12pLBHz4vTY4tbdnzKyLrvfq?=
 =?us-ascii?Q?W2gEk8gE9yCPZfKE+X3AqumgfKfNEaRHGz1q5F9G3a1a6VP5V8s5bUR/s9oA?=
 =?us-ascii?Q?HVFHqvD4vTD/qNCEnnkyWtiNZHDqezQbFexp73rGSmmBl9N9rtTwC52mxnnF?=
 =?us-ascii?Q?8tX15skbFLJF14qr3UKtZBIWNeehiALrHFGyLTo5koGeRCauV+dfFiATmDvU?=
 =?us-ascii?Q?lHoxM2rO7A2jPqeBccjhU7iPVOT9UtaBTzVSpRu5QyPRN8Xrf12koFTTdiIF?=
 =?us-ascii?Q?/5H2Ff2uS368817Sac1h4jwTypXVLpjdnYtYcFAOI8rjOJGi9WOPiLUfGbHu?=
 =?us-ascii?Q?e1BydCnW3P4Ci5ZOFM2WMfkqIAzjoGJ+7sku8/3rsHDiXiBsoNyOWUwDHcIe?=
 =?us-ascii?Q?6ax6+C7zaITBgjcpzw3aGLZrD/Gk+Bt5MILqQvpqJZGeI9q+sJyoCU8Km2KR?=
 =?us-ascii?Q?+6qXI28EzF+VDDDgk9lybWG0mtcY7NkBa8s9VhoGHsSyeGzdH2GjnOMIjAJT?=
 =?us-ascii?Q?UKbMR8FbQK7CRQAKuU49zZrXwNMm6wikk3ECRms0fzRQuLevuAl4Sv6+Gva+?=
 =?us-ascii?Q?Agfe1EWB0JRr98bpkRX8SxsMyJbTJ//R1mCK1p7dvdkdsfFaw3B03s6bTmVC?=
 =?us-ascii?Q?6O19yL7SrRYl6hhbdy18MxDCEuJsUDqHdafD6cnbqpLh/hWMmVF4JhqIIBjs?=
 =?us-ascii?Q?sEURcxGoVNUTp5a66o28vK4nnboyaIphUt8DxcFy1+vMiGeOuUjvnbAJGdWr?=
 =?us-ascii?Q?s1iEWIY2rQFlBbq91oFhkZjdtcvwImBzhE/r+i78I88J9eDftZgj+atogNuj?=
 =?us-ascii?Q?1R33Mh7dEUaka9E+xmQ6Aq5KrLVTM+2UrVReDzFx0knK8cHMdDT8hlbM37py?=
 =?us-ascii?Q?r3DA75kO8EuZJG+u+WOs5MKboF9enbH0uJXqa1oYLTPd7SVKhXjEsxM2Wuxr?=
 =?us-ascii?Q?qiR945aopNOGfIkhZZB3sNsAmn3spUaMTTxvm/2QDKozL60+QqSY2WCB7v9O?=
 =?us-ascii?Q?Z18h5Kx3ZNw0yYBVvk58PE6luVngtRSy/VgUjN70xapb9ebIlQm4lfjdtmvI?=
 =?us-ascii?Q?kis5YALr6Af3aBtPtIv4EuToV2051R20u83phOh7BCufCVFUUSQnHbqR/WQo?=
 =?us-ascii?Q?hXzn1OFNL2wpwXgZ5p2WiaHcxKlKnOZuxOqe1A1zQnPFCNCzYVztL9KImSqc?=
 =?us-ascii?Q?kvel0pL85fPBG6WLyOrKnOCfAUkxKrfupTQt1fR3poZerOj0GashElmvFoWi?=
 =?us-ascii?Q?1coY9gQqYHlMJC5UEapSSFGgXY/dB4mTudi6iTISGNTs3wzQWODJHVarqsjQ?=
 =?us-ascii?Q?SfB2gYyEhNlj16IVFWNNdTkjT22jQvzkM4eD/FZBEHDwEKLs0gDyjlUFu6Gh?=
 =?us-ascii?Q?OuhSpZQfsjjABq7VYIabcKCIIhumCMYl37MLUpjWvjrtrXnAT+OkSPjLY6Mj?=
 =?us-ascii?Q?wSOuIA+Du8A=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5757.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3keE6VgY65koBrB/8iiaINZmyzIoNpWMlyUv6b5pStE+fVQuHOYi5R3t/CTj?=
 =?us-ascii?Q?6WVFxspFCT4guWKrlFTOP3o493YzRi5CjbcvZ/di0vnc28X8We3EpwWA23VR?=
 =?us-ascii?Q?jsEG722Yi7Co3YhWuKEptTDilEsn9nH801PdNXZSibHGvMB/eS+pWyAVbYuN?=
 =?us-ascii?Q?bCJ/dHtAUblnqz/fvHvfl8ykBSP7EDTCk+24DBcbeJ+YI34F+X6jGFWRlv13?=
 =?us-ascii?Q?lKJ7Xh6fHPDvDEovee6GDRe4059R7nZgg0gJQMdh9mu3/GkOs8w2F9tkCz4i?=
 =?us-ascii?Q?RpUc9i/YcvsU4J8aLY8gcq2lWeqWdgPaz2KtmmdeY7Y8087wqJiLOXvdwA1Z?=
 =?us-ascii?Q?4VDEkRf82FX+lcXXCyH9Me5LmrGRLJyuFqMZlUeFWj+SJ9hQIiIrn6vQI0Dv?=
 =?us-ascii?Q?qzpOYRaIEC5y9yoZSgPS+lHhrvULyMeWfA/iggoOdc4PrR/nL8yYexojhubE?=
 =?us-ascii?Q?S0q1ujbcLVPqZ6zHOy+9gj/A2JMeGPsmfwzzRiAgu/labI7ZuTNiz77YQKQK?=
 =?us-ascii?Q?2W7TB/JeaWgooNFO4bx/XY2GNjYhfl7pk02uB0jcA98ZNBDmSedop7wb6X5o?=
 =?us-ascii?Q?AjYgTFuNCetlZcVvEJHQGTprPDB7Wb0SAcXwDqzcPDKVaKBHUdMQwj8NHD9n?=
 =?us-ascii?Q?NEtXQfgy/wqrTLGHNHkub2Wa+ipDAEa8rM+PpKXw0HeASgPDuVc94XDuZMtt?=
 =?us-ascii?Q?RHr3KkK0DV6uJykBGr92ckASugFRZNIM8g5Lf0zPAOvjJTHX1Xo8uXiy/7G1?=
 =?us-ascii?Q?BVy4AqTY0u+sDeFlcL3ECGPOb9ckp2jj4o2cS+oeo5Nr4D0zCjOEAnA9EPf5?=
 =?us-ascii?Q?VefqaOmEupFP+Vg5QVk9RR2IAYE1Eka4wGQojAW5KfxwSt7GViNSd5ndKDyU?=
 =?us-ascii?Q?y2/nY1M5GyZDMazbsVfOUTnVC1jZ7oYSey4saV4bUmFPTUOjk8k9bhz8VESY?=
 =?us-ascii?Q?feOKPoIZWhxRtG4JahsOkP5sjpW+RTV3RDUMegJJ9VsLeFv3kt3GrBoX7EBX?=
 =?us-ascii?Q?DbAg1UOi9TYTP8gZ/XdlDJ7mbasMtQgxW0H8O0WVR4C58dKiA40fnUnCNCxS?=
 =?us-ascii?Q?BnyEEKNAtvl52EI+mp5Ip267fA7BaMfIfpV906KZ+0ERGrvnZj4OBdW5PREV?=
 =?us-ascii?Q?1ZsXFw8E9QH+To3BmPaB9xLq/X0lRQI8WUmVUpG0JpZN2syIHi4SKYgyj8sF?=
 =?us-ascii?Q?1NhrdoZcC/6B8Lu2tHP0OGj/SJ5v61xShPsy4ILzz2iJPQ7nT8/YsAHmskcI?=
 =?us-ascii?Q?acm2aazGoxTak9rhGqSThCNg4Ao9Jtz5meAAqvwFxUULjAk6o5+a6gzKv3NS?=
 =?us-ascii?Q?k35IAYcxqTXIwu5F47DGoQwCX2FlJe4qvAyf3+0APmfFMN08tiHpXfjMdTWd?=
 =?us-ascii?Q?P2O7Y+Q7IS83/WBtiIXB1mbUt5XhuFbTYBifOInwCmTiF4DZVCKyUmD06uIj?=
 =?us-ascii?Q?eHUSDwAem2Qf1YndY/sC1cshaaepw4MpSMFdJmoJSm6QZg4RY25705r8C+cE?=
 =?us-ascii?Q?f1EAErUe5zYFU20AKrw1ubd9rLkKmSGb2jnc50hv/9wDQ/vAueQl1paSPBjM?=
 =?us-ascii?Q?OkdYuA3ALe11Gh9vQHI=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9352092b-8e69-477e-afa7-08ddf63294bd
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5757.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2025 21:38:46.2503
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8mfaXxn5rV+kc9WTkq0LNL/qX9Mr87eGpCFc+CFvYjNTfWN8j88+jmeXB6T9l2gp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4464

On Wed, Sep 17, 2025 at 08:11:14PM +0100, Lorenzo Stoakes wrote:
> Add the ability to set up a shared anonymous mapping based on a VMA
> descriptor rather than a VMA.
> 
> This is a prerequisite for converting to the char mm driver to use the
> mmap_prepare hook.
> 
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> ---
>  include/linux/shmem_fs.h |  3 ++-
>  mm/shmem.c               | 41 ++++++++++++++++++++++++++++++++--------
>  2 files changed, 35 insertions(+), 9 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason

