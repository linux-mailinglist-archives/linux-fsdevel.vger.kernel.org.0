Return-Path: <linux-fsdevel+bounces-61383-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D6F4B57BD0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Sep 2025 14:49:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B7450204366
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Sep 2025 12:49:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A410E30DD36;
	Mon, 15 Sep 2025 12:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="F2BY1gAt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011032.outbound.protection.outlook.com [52.101.52.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66A9A30DD19;
	Mon, 15 Sep 2025 12:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757940489; cv=fail; b=XYXG3u/DLMNb9JK0iATAn0UFvKTG3E9RtLXiXVC45qhnn91tGb1XZNt+yloyHnv0d5drEIywMCTVGpeGSBAkjBHBOoVrom9Flk4LqBeNo+x2rfZAC03agPjeSe2vOi4hEcZDViiUtqZoDtSW8SYZJ3eW3YYMggJmu5Kuyq63Tzo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757940489; c=relaxed/simple;
	bh=fdKQKxzjZcdUndFujGkJVb25PEVgM/iWrm9exup38rk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=hcibROu70WKjYaH4kklb4K3TkkIvYmYsHP1znfF0wFfgAGQ18yHJ2/l4qrbR0tHshzWsoDvrD+ZODgUnaSwLi9Eo7BePxsEqRe3RdvvEOkcfGPWlZ7NOUPE3SEWiKf6JuuXYWGjSE33OjJ9FNyXOiQhMdNH0on1JXDMnUyTEXgw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=F2BY1gAt; arc=fail smtp.client-ip=52.101.52.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dlSIxsCR+FzVFz02fh/03m2+Bner2nQrcojaHa+yVDJnOjL7Ihh5XN2eEWwooGymo1l9eLZ7pPGiYzrX/8JY/UJoro2Vakjqwo2veKc/5EjUDu8MdXby8cfhq7oRvjhiQ/DCezAbx1ynlRsKzQTkWgPAlnLlazEsjXnA3Ym4gYeyQIOBFEP1PxTyyhqT724vv7VbVbhL0lVbMYM1ebc4zlpEESZEnzIigfM+RG4k6FZ2HFBXnE50+8Q5jQePTWq4ERZ5gJMnpJcEwpYiIO1pwth3+TAO/tfwcDiKST+a8tbUhvEV+6QN7CJzCvIlyfb2JSVZGScW93QQYS5pcfPgmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u8VVEzO9o/35ttMOcQLCNrppJIx203qCXHmmvtiGP+Y=;
 b=Ddv8Km1pqYUUqB5sr998b6GFEDBoqI8V46DDCl3e7jvpUvpE6cgVaHrp6IQwLfDAR8AbiYgHZz4B2k5R7IspvK8j3EndZmUgePo1IznukCIdx/MTm49m7bxTXrA+y07BH08oQ7x7eLEyEiNW5iFp/2+4KGOOlUF+j++KuF/OMnAhqJCe92jOqZS34S8grURZeTVUvz/CR7lApo8Ym1nzNJv1n5wnfcs6R3aUo5gUyIKAuwHJGFSgymWja6RmzcnAi5dv3JfJaO5NaZwg+5FvsYQ9R+lriz+x4iho4xiuCFU93tHttZZRiQ0q1vKd2PbVkT4whjrb+sSFafsK+YbJzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u8VVEzO9o/35ttMOcQLCNrppJIx203qCXHmmvtiGP+Y=;
 b=F2BY1gAtH9gqn/kPRZSfFXY67fSzoTEl9mpms3iLtI0Qerw/jZo3pYmO05o/9wUEbW6hcbWhfhKQD4H3lseVKakOsYUNMC8GNKP3WzKZ4e9wdgsYvcyNF2IMHruOdt+KnwAVgZVLT9X7GXrVDupbg2l4Sf55U9wyKxCvzVcsyrldUrrC7u6tswFLneKXIyLZYmoHMjkVoe/3zFPxFNi2qKgIFG5eYVeaWst2zWhYQrM+ISFDqzw5yImJs+Cl5fO22p076lvLRkxx2HrSbIoZBChA02VcF9k2GzskCW/uUBtzlXtm077H4ZiS4XQwd0dVaq2GFGyaYa2HVmCTom7JLw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH7PR12MB5757.namprd12.prod.outlook.com (2603:10b6:510:1d0::13)
 by PH0PR12MB8797.namprd12.prod.outlook.com (2603:10b6:510:28d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Mon, 15 Sep
 2025 12:48:03 +0000
Received: from PH7PR12MB5757.namprd12.prod.outlook.com
 ([fe80::f012:300c:6bf4:7632]) by PH7PR12MB5757.namprd12.prod.outlook.com
 ([fe80::f012:300c:6bf4:7632%2]) with mapi id 15.20.9115.020; Mon, 15 Sep 2025
 12:48:03 +0000
Date: Mon, 15 Sep 2025 09:48:01 -0300
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
Subject: Re: [PATCH v2 16/16] kcov: update kcov to use mmap_prepare
Message-ID: <20250915124801.GG1024672@nvidia.com>
References: <cover.1757534913.git.lorenzo.stoakes@oracle.com>
 <5b1ab8ef7065093884fc9af15364b48c0a02599a.1757534913.git.lorenzo.stoakes@oracle.com>
 <20250915121617.GD1024672@nvidia.com>
 <872a06d7-6b74-410c-a0fe-0a64ae1efd9b@lucifer.local>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <872a06d7-6b74-410c-a0fe-0a64ae1efd9b@lucifer.local>
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
X-MS-TrafficTypeDiagnostic: PH7PR12MB5757:EE_|PH0PR12MB8797:EE_
X-MS-Office365-Filtering-Correlation-Id: 47b0046c-5032-4fe6-4a90-08ddf4561c2c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?h69OqifMYJ77UeoUpRuSUzSeSb7tiVa615I6hYAzwR8MdOH6gW0D61yooP48?=
 =?us-ascii?Q?p2a3mL9kQB7BFSEbEsOXkgPhyVIwoDeGL91zQtUSUYQiHGT3PIdSdukpRKeQ?=
 =?us-ascii?Q?6Sa+XOSAUPqMbuXaZ3pJBqlTxw7UJ400o981XTveJtFaJGsXgj9+LNgqcZQW?=
 =?us-ascii?Q?DNbnh/aVpHUXW4jdeR7rVFsIyttbpu2isVo+12Re29YAT5SX6i85D0X8d2RS?=
 =?us-ascii?Q?wMwifiw1KR1PxphYJrjpTV8xe4Dkf6CWW/X4RxJJ0T4JBrou+XbCa/QdhOE1?=
 =?us-ascii?Q?7jwpcMajUbCLrq9c7ptog80tZc1FmUKylCmvj7PM/3qIzyWUL3xkb0GTprAY?=
 =?us-ascii?Q?/sjKCNskD2K4XEjB2ggfp8D1eezZ9fU4c8KZuJbDR9SS9UpBkwPIg0KYgU36?=
 =?us-ascii?Q?Ksu6piLrmaVIQUy35jjt/bmfpeCo41wfWpRndNDIrxe8D6oRgSTT1UramCz3?=
 =?us-ascii?Q?rUwmH75mGac47qc36ywNePNNBWYYntSeVBaFhBho6xh/XOMXhe3AwJ4eLGVY?=
 =?us-ascii?Q?qqqjokf3oR/vkmDkGvimHfVm/yaAScMBTZOU6S+K84a5WXnsOmw4C6AK69IO?=
 =?us-ascii?Q?umnyr1FyfJrqUeVqBZOFNuNq4sSw/u6iD8UzqN+S0yY077xoztTj9L7VNZzN?=
 =?us-ascii?Q?4rWRwK9w6NCOZ1CfpWINuJBFPQX44IsZoCnjaKFp+VUk9bswYyfnMvaMEc0r?=
 =?us-ascii?Q?lszc5vap141CeUOVbQ9d04i5aG5cNSCQ0b8oNzTZLDvahCOkCmfs5ybwF3Mp?=
 =?us-ascii?Q?Jmr15dQTwb9yvTliFhWzOErZntnWZH9BgkfqG3/aBOnsyf6HXvBlhl6BDXe2?=
 =?us-ascii?Q?PD4zfv2T6XnNrZ1lH6RFkMcxOnhnZ8udUCIVcEwobI96BsQkXtUoGnqBGhMv?=
 =?us-ascii?Q?oG2afYTK7ADVFOTSdmFXTqlNR3S4Eh2fRnUBa8c4r9nUm8Jixthxdlooct79?=
 =?us-ascii?Q?CKmo/bI+qmZHwrfUSjNcwrahPW7bEWwcNtUD7A8o64MX9oz9XMvNykMYT59N?=
 =?us-ascii?Q?MBqQg5N4QSCs13wPzMnkbR8GGD4Q7aTr8ySU+I/kdIDGPSY0J9V8s69Gsob4?=
 =?us-ascii?Q?RYw8RuuGXtJwUR1kDo00QXnOWMPfGYkrwwHI57wP1k5tTEVr1rbFCCIxVT0R?=
 =?us-ascii?Q?PXqX6zSk0wu7eS4QH4d7pYuToTnaaAdUGqaz7gWd0vwSMOadmcuMZwKLT5nG?=
 =?us-ascii?Q?egv4D0MCecVXy+7ymclegsHVJwO9GS60eZsGb6gDsF44edGSELzEkU2ryOpT?=
 =?us-ascii?Q?kinGfbNGRWnM16sO3XUwZ2Xj5x2GgUcOjpnvLkUkGzkOToZFfkUh8hcpMr+m?=
 =?us-ascii?Q?eJ7lylSvdm349sFbRKjxlTNEnLJybVac/mUCCKMIkqITj6X89EUt6pNsZzVL?=
 =?us-ascii?Q?aheissS841EFHtMfEDIBApnD5zem6zQo/Uyyubm56XHC5ST3hrDxzRGxjkrD?=
 =?us-ascii?Q?sDBFVrlqHbQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5757.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?VRWn03OitKYRA/DwuaRE4Cz5hxYxke5N/q7ey/Z9o3NeiogdaYuIuN3b3w6O?=
 =?us-ascii?Q?vcH7/9gKtxt80vCJOGkoSa5jVEOS8npGNmbSQwAYuG4xcgDiJI/kjTeneB14?=
 =?us-ascii?Q?6PtduwEZ9Qjf1X7Or6XaNpDFULeXuc57I+i/Y4DLN1Eh9XqWoU/oYC6zUW6W?=
 =?us-ascii?Q?6zQSp8rStAtgE6J4r5VAXo+HQUJNMIh4i+W7/c5QMSOCOa1UUGa6M1Ha7w4H?=
 =?us-ascii?Q?nfYvEmBa9nrkUwmycN4NJv2dW7cbpRuWGaJqlYtS6GyZpl1OVfRTD4t/W3Xt?=
 =?us-ascii?Q?bAbuOJovwi5hqRu2b8Blj9IhdV+MuY7xaw/4zO2JQQ+ztKMRxT/OWHNL7D/6?=
 =?us-ascii?Q?++M02t3H0wRIEZTLIBDN1qpulzu71mRouTohx2icrvQ6uNjSzBAj5sZGRRC2?=
 =?us-ascii?Q?/ZrUQGfkWAh80HCOUvU4c27xV9J+Os904X9Yj1gIDOZ26ST3386hOqfLvuJn?=
 =?us-ascii?Q?DhlMDquwC6N95vEtk9Bo9Hd1QmgLn3VqL/R3Ydbn72fUGCaSqNQNNy48eWLQ?=
 =?us-ascii?Q?FJ2/zGsbWNlYDeCv14SazZOQ/tTiPgKpISD0cIa+oUvB6Ra+OJ/MJqDRdUOr?=
 =?us-ascii?Q?URXZwn6RjWnRdGwVYwobyr1RI6rEC+l3rcZsWljG8YEFQW5Yp+7hsNgFCtdD?=
 =?us-ascii?Q?mqlRZTtxPy7dt4HS5YfslZoiEh5rhJMLT7eJZVUDEcSzMbXyElIlGTFp2rCI?=
 =?us-ascii?Q?kLz5sRg05Gat92uRQ48Awq45oR0GTqpohqckpPODcqxSfRrw2ISO13QMJdVs?=
 =?us-ascii?Q?Qxke30Q9p/RCFMpVpaBnx6oecxI8TFbyoCENqlwAG80+uDkBdCnHCZe7UJN/?=
 =?us-ascii?Q?YBODqs8e1Kh6/jQnMZfhrRJm4IjIJjN1jGIDjEYe6EJ1EePWA1AFpD4cBGs8?=
 =?us-ascii?Q?v0J1vFjK2+5cvbbhEkDu1zrUGuqkEIKCw5FHXLCMnRl6gzBLMQsxUupBZQvL?=
 =?us-ascii?Q?EnyeIvO5Fkqkih8kIkAqk6rdhbn+/ONDy+xvIz6kZHkJlDIzNxMJ+sYr5UAs?=
 =?us-ascii?Q?rxcR4KMNO0CCHH/qjXfwFz3jhopelZIM2UI83JZ3N2ISbDddMJuYYpKwoU09?=
 =?us-ascii?Q?W5bmc6JilH2AZGPFNE9GlHGcEGpV/vAE75WE6jyxCOhN7xGeyPxMvHYWNc0l?=
 =?us-ascii?Q?5iwFn+7Vv01wSTcvuSG7x3vz/KFaAzDM2T6mjxfm2FTXUixrYSII/rcIDk46?=
 =?us-ascii?Q?G645bU1aiZzTvkyLTA/kkx0qBxsvn54HHsFzAbTSMjX+gmlrhYejhT7bV0fZ?=
 =?us-ascii?Q?7X53i8vx06iJUfF+DLvswGrND4tvkus/ZFfFckkRZnJy/5fuflApTbC3zZWY?=
 =?us-ascii?Q?6aAtj9rXUUld/CjFcMzGfYEa82cf+elD0/6MLo2/h5VeTEp37jBh6RjBxiBK?=
 =?us-ascii?Q?RqVCQFLLzaacsd3mTrW6ENKOukVGHSHi8P1ykTmgwVggYagRbtC/KjXCchz/?=
 =?us-ascii?Q?K5U612uOW1On5OVXjUoQmcqxrYnENWHRLUiLykJkcMXVzZEmW/F1adD/DPML?=
 =?us-ascii?Q?SqD56ktlJnUaMPm8HNZ9hvaZMYSwwr2Gk8Vki37XiDK6asijXzzyYJO9I2N4?=
 =?us-ascii?Q?gGONw+NzJyG8YnMPhx0=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47b0046c-5032-4fe6-4a90-08ddf4561c2c
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5757.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2025 12:48:03.5144
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mzogALwuNUANkerB9kJgREo0bYyzFJppK0PxFsRPgsC3FoO4zqVXsW11aSVktkt0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8797

On Mon, Sep 15, 2025 at 01:43:50PM +0100, Lorenzo Stoakes wrote:
> > > +	if (kcov->area == NULL || desc->pgoff != 0 ||
> > > +	    vma_desc_size(desc) != size) {
> >
> > IMHO these range checks should be cleaned up into a helper:
> >
> > /* Returns true if the VMA falls within starting_pgoff to
> >      starting_pgoff + ROUND_DOWN(length_bytes, PAGE_SIZE))
> >    Is careful to avoid any arithmetic overflow.
> >  */
> 
> Right, but I can't refactor every driver I touch, it's not really tractable. I'd
> like to get this change done before I retire :)

I don't think it is a big deal, and these helpers should be part of
the new api. You are reading and touching anyhow.

> > If anything the action should be called mmap_action_vmalloc_user() to
> > match how the memory was allocated instead of open coding something.
> 
> Again we're getting into the same issue - my workload doesn't really permit
> me to refactor every user of .mmap beyond converting sensibly to the new
> scheme.

If you are adding this explicit action concept then it should be a
sane set of actions. Using a mixed map action to insert a vmalloc_user
is not a reasonable thing to do.

Jason

