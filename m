Return-Path: <linux-fsdevel+bounces-60520-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF0E6B48E75
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Sep 2025 15:00:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 20E76341635
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Sep 2025 13:00:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02957305957;
	Mon,  8 Sep 2025 13:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="h4q/HWaf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2058.outbound.protection.outlook.com [40.107.236.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5A2022DFA8;
	Mon,  8 Sep 2025 13:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757336425; cv=fail; b=GZ1iKoYRiR9JDaBFj9MLpOb2LDmSqDoGocMzff69z2kdJO4pIniGdsavy1yDFBWxbzrNF72jZ8JPGiBC9YZUlLlc/4E2Ojqs3aeieEfD/e9pmh83xPCpXvyrbrnu3+0OVG4jXm61l8mKA96zngooAIn6QJu2VqoLEAFN5X8atHU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757336425; c=relaxed/simple;
	bh=nXKGV11o4F6/A/0Lew4K4pGO87ezPNwqe3IqSqZlpvk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=QSXKuIMGBNd3UOLEyhB18IJEpJ6GOn/flAJkqLrTfq23P5IswWTfbP8O64etUxQgZlLEQuqFdYa6VO7Q2YDRRQECyoegjM6ed2z2BGd0Y5zSnm5soMPrOhp0TFLz7il4BvD3cTPO290rBATxbHVCmz7TWEZcs//V1VFVbdIjhXI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=h4q/HWaf; arc=fail smtp.client-ip=40.107.236.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hbmTU8arglgFRu/Yvn6JMfMSZlxyq5LumninzrKoP6yk4exc42ozNWC6WPVZELJ1MIqVahK5Qz5XMtBPFfcszRjNX1/uoK+/aAnJZdBc28sOSyPVZaiLIpawwQqbY4SoEtHjj1BxY6/IOzaJeFqRVVTDWmFH7sC8UXWJEVTzunilhFUFQiDqf3pBP8xg1/Ozz/cGeO/71mViyCjLQ0vOMc4smfIg/7GB/8q8t2DUvmKupDsCW2pXTU3WBvAAVspphcmTsEOc57P2oIjs3O7EXGkZTVVdXzX1Cxnmtvr86BlPBA7umQQrrQijGUtuPqVzd26m+kbHSdvFuaVLrzmhQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nXKGV11o4F6/A/0Lew4K4pGO87ezPNwqe3IqSqZlpvk=;
 b=KJwev7LSfCR4Y1AKY+p9++T/+Fd/p9dEwkHyiMLfZrcOQwGHHqplyjOEkQgqxgtujmPbUHPNZtI8gUX/dGXvSBSQBzD4zdRivwXBwvDx51wGbQgBD3p6Ff3FucxJExkWjBFtxS4YrHvpZEoaJXX+u3Ag8Wkq4Eu1yIh0t1H4R+bhhoPWuVnFptiHpZQUw1Q2YogYwWhEjWpeyxNHaycZTVyDoqVcAN+tD6u3JR+i1VHbBe5BkOqxaODDjmaK/QMf+4Z4MXaYqqDavxX51hEvgEnuWl86M7DC2ni8cOB5WK0sGMZjQzr/V6jrOe3WPZBOdEv2bR4dHQrDURUbyO5Tpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nXKGV11o4F6/A/0Lew4K4pGO87ezPNwqe3IqSqZlpvk=;
 b=h4q/HWafj41bMwyjkL08lWBi83daEJAg4/g00qzJvE9x+aP49PG0aTsVIcgC5hqolWOuMDtXogloXLFKF+F9pnSObQeekvRevvElblwmvkDIkkD/atKxPwSMmFMvKl8NGBXn7Fq5ds8q/HOT1ohWPGtrlWQ8dtHqWxKk31rnnGQci0BSBz0ApsuPvYz3QhTEB1eiFl5nkfdmcjjEkh0E2uob/aMRo5CL2SjMrbWA9HvLKXssDAtUmaNxKeUwW9V2JvBvioe3oLkD6L/FHm+LnKSSRNO86x36uxxygodVDN/l9LGkOtdZrpDXoSemg36V9g11tDS07mfFqTmU9b5vAQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH7PR12MB5757.namprd12.prod.outlook.com (2603:10b6:510:1d0::13)
 by CYXPR12MB9320.namprd12.prod.outlook.com (2603:10b6:930:e6::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Mon, 8 Sep
 2025 13:00:18 +0000
Received: from PH7PR12MB5757.namprd12.prod.outlook.com
 ([fe80::f012:300c:6bf4:7632]) by PH7PR12MB5757.namprd12.prod.outlook.com
 ([fe80::f012:300c:6bf4:7632%2]) with mapi id 15.20.9094.017; Mon, 8 Sep 2025
 13:00:16 +0000
Date: Mon, 8 Sep 2025 10:00:15 -0300
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
Subject: Re: [PATCH 08/16] mm: add remap_pfn_range_prepare(),
 remap_pfn_range_complete()
Message-ID: <20250908130015.GZ616306@nvidia.com>
References: <cover.1757329751.git.lorenzo.stoakes@oracle.com>
 <895d7744c693aa8744fd08e0098d16332dfb359c.1757329751.git.lorenzo.stoakes@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <895d7744c693aa8744fd08e0098d16332dfb359c.1757329751.git.lorenzo.stoakes@oracle.com>
X-ClientProxiedBy: YT4PR01CA0111.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:d7::18) To PH7PR12MB5757.namprd12.prod.outlook.com
 (2603:10b6:510:1d0::13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5757:EE_|CYXPR12MB9320:EE_
X-MS-Office365-Filtering-Correlation-Id: 0394b5ea-d592-4bc7-e06e-08ddeed7a852
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?lrQn4tvnesoKrzKbjRXz9KjZnXnSTk/3UJCwZ12lWfJEUXWmkXhl5LTbzJLo?=
 =?us-ascii?Q?iUeftcVzA4WgIHkzrwmSyaPnFwplHFjUrERLcjaNYrKWgNNgg5fOErejfEUY?=
 =?us-ascii?Q?6e4WwlLsGLnK5cPLv9WIz9n0+1QtqpBCNtaUTMvD/9Uh6nxmS+P/IQzmgOe3?=
 =?us-ascii?Q?evfWUaj3mDgi8E9RsAMu9MkXWfJH5ydmV9uYBaO4mEuOpxch4DvhfLhldcW+?=
 =?us-ascii?Q?Evxx1rtP14kByrmy5W3WclnJ979/zEEoJdCQJdjHVpLHpJc7qJnNr1HCNqVp?=
 =?us-ascii?Q?Js64koTyp15iXMwypxDNkXaB5sYY3OV9111giL3lQpzmYHLUMcRZYGFeQxmM?=
 =?us-ascii?Q?zjGjDv2NcIead1lVnpYSOHJpMXv78vFizWv9r5YOwdTLjD3nE95lwku7IMIu?=
 =?us-ascii?Q?mNNZuMq/jBmYgX1Cy5KgJ/Wmjl8/dmaFebxCUfUuEr5Cuynq2pdJGrMDym7X?=
 =?us-ascii?Q?3C4VwG6ZToba+cADOuShSxKj3WviQa9V37XC2ucMs8dm8m2fa9UCgs5XuTpt?=
 =?us-ascii?Q?YffnHiIo7UWc6grUDBmPAzLjpHu31yGrsOQwXhI2jxb3HbeOpi6k4zIkGPb1?=
 =?us-ascii?Q?b1o7utOTrOVkq6wo+bhZpnIy3uW7tuvvOhs/iKuLjoUJKV+VNaFfJlp/m+Ij?=
 =?us-ascii?Q?UsL7boqo5PWNsiBDPMfauuLTwAg2+9SjVOvTnVG3Ux0run8DY5KsiJp1oGp7?=
 =?us-ascii?Q?SfXsKOxAKQ6uOD0Zacz3D0UPM5I+1ocpGBsu4/SXYN1FL0mUOUF+tJkljoUE?=
 =?us-ascii?Q?dYxzleBQN3d6r+6AZfnIWlBusje3ewUQWpSWNeyOgmq3YdqfoBOdwiLvqYAA?=
 =?us-ascii?Q?8xorkhgabd9MlAnJfWH+ptLZytP7eyVIwbFKXyBlqYvTI80/unn3+si0zJKA?=
 =?us-ascii?Q?3QK50E9dFl4qOv4/aFSIaeI2CPvdpNXv7V3LrIiw+5riL9XjAY/ci2iSZTpk?=
 =?us-ascii?Q?VqmcWw8toz8waDostRy/5t5jB4nVX97yJQfoJ1CArFDN9IBO8dEkvetpDVjn?=
 =?us-ascii?Q?VvIMw5CldVIdbR9lg6Yd1B0FGnmUvaOwNon8t1Y5nOHhTf8IT7jnnG1ghgxc?=
 =?us-ascii?Q?Jlh7/K/m7ptpIyTutmDAXTQV6d36K0hPnD6V/9nnXUUPLReteXdXBv3E3IkD?=
 =?us-ascii?Q?IHCgTaOuqiNBpq5cqZsDrDxaOLuz0ch7RRHWWsNrNvJ8H2vIUZzrtYlKoMvF?=
 =?us-ascii?Q?lM6+1cxvh9ucmWO6HohWiVRiqlv6eehf0GEuVFMfLMnw/FnezAOXdlW8vsLL?=
 =?us-ascii?Q?hZc2wUVhhNCFxyFsIwGYe5LnXmmm9xisqVEzzYAuNj1lpcjxqlMYvWkQKBOI?=
 =?us-ascii?Q?QltKBjnxhIAtMBiyZiz6PXvlE6E1EI6LZe2Raj4tXKn4ucdrFT1yRmAh4RTl?=
 =?us-ascii?Q?+SCyviVjUzk274Z805dBnhHyseFL5tVvCTCjMZ0AB4t0oa1MuLac1IsK41Bm?=
 =?us-ascii?Q?qwA3OandXEo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5757.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?IbnqqFt1p3xNch9KkSX6StllMlsl/M0mELgVQV60YbON76BXSvjUfJcundoM?=
 =?us-ascii?Q?fmmpw3s8vStB/nm1diRvT/JdLfK8ShHrQCeG5BlT9TfjTFFit52bAwXQJg2Q?=
 =?us-ascii?Q?DWhnamBYodc3UEiEXRpnYxbQITzBvuCp6eC7SyflqqaiJFoxCWiD8ASop56p?=
 =?us-ascii?Q?jOoXpXy/mtHyeaLYviDGch0I8WUnOlHA3Mk/639e/1MSSVEhiNUEGxpbKhLV?=
 =?us-ascii?Q?27LWdLgh7nOFEyxcJN2XYhbMfXvtblghGEpQwYtVV1ne51I/tbr8Akkkqgzd?=
 =?us-ascii?Q?44iffHpypUZbfs7B0l7zN31+CBTVU25/pHDp3EeupWbBg6XLJE6TjLWFRDGu?=
 =?us-ascii?Q?/hcfoFeV3PepGKuanVKaIlnqXV/9l5pV8LMDdVN9W5w+8hhQpGjITIL5AEIj?=
 =?us-ascii?Q?J7gVzWVkrO44+Os8GsOdDJtMEOPfalVM4arBCcGhVe6s/jCb7wNcR6iCBiYL?=
 =?us-ascii?Q?epZdtRQutvRP2j7F6MaZfKbSlmZRD4XFXT/e4k0uYm/1NSdI+aCThaC4x+VV?=
 =?us-ascii?Q?YKWPJuJqPXtpUxCl/NXgQYIwVDwMPb/icm6HlZ7SNG/2FQFoI92wHrepwfRr?=
 =?us-ascii?Q?aB+6U5fBYZuICl8BuYItHJDaFR5U1rfPS15nrHY42/o81vjB9MxUkr4/ibzw?=
 =?us-ascii?Q?nf+mxkYo+ISKWiC7NC6ZTbVvMFtpSEAH+fId3arDrRpXGi6ZYSSRwsfzgVj2?=
 =?us-ascii?Q?K4gE40ylF4ZDtl2IeomVw0tNSr9TaTP9j+1LQKSjFY0LU4HjKYkIUIKao+tU?=
 =?us-ascii?Q?UfEEhMXtNU2hxJgOOv112avpmBC5Ik16BSWGOQ1DN6dIsQYsMKvUOy/nfYOP?=
 =?us-ascii?Q?nrM6TTKm41eqN1aU6o9vvmiypZ0E3e+Q81TEgvFFyY8eI5ISofC5h2Ed4kk+?=
 =?us-ascii?Q?2pwcPuosFN2r8uzNQXogchrrgCZO+WHwa7nFSmtaPPDKl0r1KDsQs3wiWrRd?=
 =?us-ascii?Q?gLnGIncOQP+rc2IsBGnCi1xl/zvmLyowP4So60WArdPT83yCF2B066Pdh7EW?=
 =?us-ascii?Q?0sA8sWOW2XkZ3DvDQnL6ObIeoaG14r2tZr7ACVy0LDXGeWUi/vnzbQeNPMBU?=
 =?us-ascii?Q?3Cj/PuoitbWfea7Uh8A+YH8y7fSY1ujTolo5dnqOqavDapr8jp4ftXKv9o79?=
 =?us-ascii?Q?Dwf3K641XxZBs1li6fX6isWocCw5yFWijU/I8ZSx+QqeoPkT1NMUgozRkAkK?=
 =?us-ascii?Q?N/EoB6hs/W5hazcMwCeq24AASg3p3kJphTE/+v9zI+R9tcf5YTymag3Ffv+m?=
 =?us-ascii?Q?1EAyybS64eJUhTrQ9nBRQ4P5BADF6O886qA/oLt4nHkyFP5boJjKoeXXI5RK?=
 =?us-ascii?Q?FHXCGSijxG9+PKnjnZt/MjMFc66DSQMQfuYyg7yPmQaNlGG4q3EATRK+mWKl?=
 =?us-ascii?Q?O2KigioZwzS31TurmtMigGCD7IDzDwVOW/qq1JPUjOROZt+uYFNoHIkJs3qo?=
 =?us-ascii?Q?oHNf7bcodLu4RdDBG89yaZSPV+VgzsdToJYUYcZrxSiBeDCFad4i6np2wLwL?=
 =?us-ascii?Q?HWVCtvUepMIzKf6wmnS3vL2CJux7u8OEI7WDr31c+9G1muzcI6QswUGUUnMs?=
 =?us-ascii?Q?VxTzNQvuae7dIzq+/bE=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0394b5ea-d592-4bc7-e06e-08ddeed7a852
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5757.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2025 13:00:16.7402
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k6/5kOlWJfQ1Zv/4iOUmsF264tZPcMAO8P7nkIcIqxDgBt+oPWzW79jwXL+P2MW2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9320

On Mon, Sep 08, 2025 at 12:10:39PM +0100, Lorenzo Stoakes wrote:
> remap_pfn_range_prepare() will set the cow vma->vm_pgoff if necessary, so
> it must be supplied with a correct PFN to do so. If the caller must hold
> locks to be able to do this, those locks should be held across the
> operation, and mmap_abort() should be provided to revoke the lock should an
> error arise.

It seems very strange to me that callers have to provide locks.

Today once mmap is called the vma priv should be allocated and access
to the PFN is allowed - access doesn't stop until the priv is
destroyed.

So whatever refcounting the driver must do to protect PFN must already
be in place and driven by the vma priv.

When split I'd expect the same thing the prepare should obtain the vma
priv and that locks the pfn. On complete the already affiliated PFN is
mapped to PTEs.

Why would any driver need a lock held to complete?

Arguably we should store the remap pfn in the desc and just make
complete a fully generic helper that fills the PTEs from the prepared
desc.

Jason

