Return-Path: <linux-fsdevel+bounces-61806-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B591BB59F94
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 19:40:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA0BD16C244
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 17:40:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECA3D301706;
	Tue, 16 Sep 2025 17:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="SfDLFomu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012003.outbound.protection.outlook.com [52.101.43.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA2CB253359;
	Tue, 16 Sep 2025 17:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758044413; cv=fail; b=dO+UYpb+isl9NGG2+LB6vyYQ5X1JLj1Ug6aotAmPBSj1yhd+vr/NXeLDaxxM2S+HOHAbk0JT58OjBjBmWlw5nLav4wJ4ipFWuPZAWn6w0RaN4iM0yiZkRLGQKArSntjnhhFO6clcJ+TRo9NggudjouWUm/Bh5knFUgz6VqU14aw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758044413; c=relaxed/simple;
	bh=V0MllmO77Q1001fKC7Brb5hOppzQGuuuwYzjhf2Z2FE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=gAW8bD4booCY5rF7Y6O+KPAwbKEBHz4eCq9lnTuG19x7cQguX+gafVgJXoKDBpMiLgSgUkfw3Pm90XPK2iK7MXki2PEUnrSMrWkOQiQgpnamlfOrSsgbPyIH222hFttwe+ZHhNf3TApH7qMVLTreOb4qOQONFjLEe5GQ4Zy/eJs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=SfDLFomu; arc=fail smtp.client-ip=52.101.43.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oombBUrdr2UmHsmP2z3pGHqeEw1euNtq3QN819Y5x3+oEbGRpUu6TR/F0wqBcuzprCpwd1EtG8HyRplw4ng94oZq/7eaNs/mbG4BpcyqP3t1Ut2+quChRNgeoS91Ts/Kh6WeuwF+AH1N6bOPe1Vmz83ZblOP1GP5FWWQC2EIBPAfDCx6G5TSO7vwcgGLK92rJAhvraWquLCjPXfi88VEJoB3KCy3tx4d0qYNNvwEJXK10qUVvdUhOo4VXdkaXow1Kzl2svFv55iXEvRHnCb5iiJma7up06G85GS9FeThdGZua+Scr6dltlidy4UmWLz38/rKF3/l/Oc8qepg7vNfJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kv3exHaLT/gRXvH40sf1Pdb4hUzxphfOSVZjU8RsTkE=;
 b=QPOlF/eCTGeohlLyID1rEivutg4V91hzXLXNcCE137NOUanVQRJhoi3dM/ius+jPJf7ZwT9vc+Ce4O/Iq9q0dYAEa9B4fUSFIH5qdcfApedT04j/S+98TS7IsPw72w0TFMO6n0pN/DC/ATiu+ZFOpQw3YK0/pHrcLOz2vT66yym3l96lGpjbjc55VFkztaUtHUqECkZTKeIEE0lefUiZQ4FYTuh2bQJqbkU4Y0jMpkgzwrsSWg5ziXiW9abgYxT0RHVAFgALf61nR0s0yyc8YL3HpcDItcwkb0uoWvXa+Dgmy2EIjfd9yYI47zazdp51zdM69lGh7Vnz044uxU8olA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kv3exHaLT/gRXvH40sf1Pdb4hUzxphfOSVZjU8RsTkE=;
 b=SfDLFomuzJ8zNWlDOihi8FpMH1vEYcil2BbHEDk+umqjCYJLHWwDA1gDkzMLmwqE1g20lhs/tVPVLpUJTkO9uwuh4GnyDJkqH7HUBQ+4GfVr0IaU9u6RqDuHBkV1bUztz5td9RuBP3ewO2UdP66GW7AFz+3Nn0KnG3xy8kYizc4SVObbHjcmVe2dkg1m2BRqvvosAPy2srpkNrJ/oa0yqR1SjseCi1vocG/gSzcwMx8FTKUydH2gJ1IBeQH/eTsoYFalUnHPHTb/CLjFbniytCuhMLgnEHlJgN21+QnGFfu2ygRVtRbyEJ/VoPxRs4DRNlUTASsR2y1+R/1f5C74DQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH7PR12MB5757.namprd12.prod.outlook.com (2603:10b6:510:1d0::13)
 by SN7PR12MB8130.namprd12.prod.outlook.com (2603:10b6:806:32e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.22; Tue, 16 Sep
 2025 17:40:09 +0000
Received: from PH7PR12MB5757.namprd12.prod.outlook.com
 ([fe80::f012:300c:6bf4:7632]) by PH7PR12MB5757.namprd12.prod.outlook.com
 ([fe80::f012:300c:6bf4:7632%2]) with mapi id 15.20.9115.022; Tue, 16 Sep 2025
 17:40:08 +0000
Date: Tue, 16 Sep 2025 14:40:06 -0300
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
Subject: Re: [PATCH v3 11/13] mm: update mem char driver to use mmap_prepare
Message-ID: <20250916174006.GS1086830@nvidia.com>
References: <cover.1758031792.git.lorenzo.stoakes@oracle.com>
 <03d4fce5fd356022b5af453fc5ab702c2c3a36d6.1758031792.git.lorenzo.stoakes@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <03d4fce5fd356022b5af453fc5ab702c2c3a36d6.1758031792.git.lorenzo.stoakes@oracle.com>
X-ClientProxiedBy: BLAPR03CA0056.namprd03.prod.outlook.com
 (2603:10b6:208:32d::31) To PH7PR12MB5757.namprd12.prod.outlook.com
 (2603:10b6:510:1d0::13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5757:EE_|SN7PR12MB8130:EE_
X-MS-Office365-Filtering-Correlation-Id: 8cb764e8-ebc7-4e7b-b17a-08ddf5481478
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?n9vRekYrYlV9T6J9aHhknlVei3ZMyO0zGx98JMLd7x66Rh3P66hEkYmI9PdF?=
 =?us-ascii?Q?HlWxS6RlwAQ+g6g5dJjQQhhOQ3lyKhIkPuk9M5XCL/2LtOKlkchMwuwVGM4A?=
 =?us-ascii?Q?QiXEoA0QDu0SGBJqhkkLgmrNC8uxF1jUwCvrJ1ID0kfpl1GzyOhzEqOr/xbw?=
 =?us-ascii?Q?EyMbvef/gJRoBpeNKPEizw/1lS1iAhEy2kJPy2FspFd1Wr+CWaKvhd+8CXkv?=
 =?us-ascii?Q?0o9vXwrFrxfMGOepU7//t9ctvCC7XS1y4KBZVZVQ9tk935dIMfvtbfpPmHZo?=
 =?us-ascii?Q?VpN99mAjXkvW3kkIHOENcrRKsktJ+5nrQ5S74vSm34ok9uQMHXGPvqUr8ioV?=
 =?us-ascii?Q?xdM3g5UMxP71yYq9Yoc3r3cRtpZ+GCtFA8a78PLT2TKYJca4SvrwfDq7qPOB?=
 =?us-ascii?Q?It85D/Ipm64tkMLc+lq2LSisgaKdz8KoPZaS7y4KQiuLJTeO2OltGF18cdxW?=
 =?us-ascii?Q?c1ZiActq5c421sMpLGQP9+c2NFbfGB3H5zEXzxXMZx1c2neQkMG6DAg67Ao1?=
 =?us-ascii?Q?7ZRt61G9RXr5Go+4B/nGQCGNSstcYCqhHZ7u5QbILzrEumfeDIaU41rpjBIa?=
 =?us-ascii?Q?nvMe/cxt+gOXohDvqXBz7CEOXn9LUKQAc97EJxGwjF/KqqL7sdnocNISScV7?=
 =?us-ascii?Q?EmGDFAQb8rfnrSjpbXMww5AT8BK3scEogmlHD9rYh1bgCodqQfZ+v51++fJf?=
 =?us-ascii?Q?vg9LvBsvtVo/240h+oUlJYVNx2if9eNhFm9glcLz1wzy6+qAeVeD85tAZKcp?=
 =?us-ascii?Q?0PSPXwydL+AcVo3BsSGr2vagdL9y/lVtB+Libs9tTYaT/aaGrdOX0QRJG4et?=
 =?us-ascii?Q?YilgqJQ1Kr4TM34dBRguYUtrLW2qBmzly1zeoi4cAx0H4NvFOn159/S5/v3v?=
 =?us-ascii?Q?qBOUa7gzSN4BdryXlRxeX6WSrYQNvHHHSfZo1mWWNm64Y11Q5qrpGEUsm9K7?=
 =?us-ascii?Q?Sp7idYqZTakxYjVLO6LBDJAkVFFKhLYxaDOW8xnDX/iYPk+s918LMIdvkU6k?=
 =?us-ascii?Q?1mjeDHisV0SRtTuPZS1b0iTCobXJFW2bZ6gX5OkHLsGWlr+72NII6+K1dKa2?=
 =?us-ascii?Q?IR6FodbEi4GHJe+JLCjsZZj6mv6Zr6+rj2DZlHrKnEkPROAigxZ6neSnuRfP?=
 =?us-ascii?Q?qEizFNgiwnez3mm0Dj8UI/pni6SoV59EFDePSvva8IoDK8RCU5bvvxbMv0rc?=
 =?us-ascii?Q?2DEK44j6QxiY6DmxSJkswpQq7IJW32b2ThEj8HjBkX8n8BCyL/lsDE7jxmiq?=
 =?us-ascii?Q?YvjfJCJnPj4EKG2ZzzmKSvzNKL3pnOdUZDhCbDHHgSUDmbLMTL7Ud3vZwAkB?=
 =?us-ascii?Q?EEtWLgVfroPZla8nUbImDcgHNji6Ar9fgLsjDgXmAq1yMkGiQG7pH8zswAD1?=
 =?us-ascii?Q?WVCnTf/xvYm/F5zRdwaTiH1W7GsVCP7cr2cCd/ju2C7nHv+Za1njhVhaWxQd?=
 =?us-ascii?Q?IYE4ddJCBdA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5757.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?W5yRxc6sKftRS/lKAeRN3CkrPIXJN+SW8mmQJ5Tvu8aVDoFTdE1nJ1T50utS?=
 =?us-ascii?Q?FqLCujN/0JTTOHUe99loE88Wf8SlYXK51E1uj3lWGakr6A663zUgjGuKIgcu?=
 =?us-ascii?Q?WP7BcIUPvT8qe6puocnBQpBmYlseuqTHnzFUwlCnfD50meFqJAPUI6BULvKm?=
 =?us-ascii?Q?4kwQIuVOtk+331PLrcmKoxdNQJKgRrZaMXZOyvWzaL5/uZG8/xzh3fvIobhg?=
 =?us-ascii?Q?7f4qEOw6fidPYGTFxzDP5NVzzbmnPnHQv2zyBEI1T2AIBTPwrEel8uAOvbBL?=
 =?us-ascii?Q?ByYdBj+1pnUrqmEDEN8SQ3+qGWrWCA7bFU5AAw00r711m/tRT7pi8xt5kuOn?=
 =?us-ascii?Q?bd12S29DyTnSWnjJZntz96fEj6DVKQf495AQlNEW+Ps2chTq+kx7aE9uHVmF?=
 =?us-ascii?Q?omAzpYwjJPRaqWIEsiZaAuxFJbwJkWlncn4nCGsmW1kP4KRhY41gefO7Bi9s?=
 =?us-ascii?Q?8JN7OlcL9h6MyCC34mOhu66FYvG9iYjVFIDFeGyJaA8aM7eMIAT6OT5cCtBQ?=
 =?us-ascii?Q?Y0dcbXCOASHYrYFfVh4wj6S719dQeJPEpa6MoBCfUMzzr/ZI/betPVLlX0Rm?=
 =?us-ascii?Q?uDwcfnmwq7/5+1+4cI4YOQ0+nVrX4tU4bS1Lc/vpsh6Ffws5x4Bsh8WMI/sQ?=
 =?us-ascii?Q?QM2wkDOHvsC+kih5FmDUcCU1f5ZxHo5OSJ2thusOUJZMxUZV6e4NSrEjXLQF?=
 =?us-ascii?Q?ynYN7U38fJhqtHXQx1yNwdIjZbzgLfryYBom3bYzvOhEBQ/9BlRGPcmKdxA2?=
 =?us-ascii?Q?4c+wf5iDqZy/KvHmBRIBGxWodOJtYP5LTPL8bcl9cvSIh7Ke8pijle5MNQZz?=
 =?us-ascii?Q?ay7qPDL3f/DlSIqF7MtjdWBBfoejzlDLu2x1FcitpGy5HaqOCbO2D/wfo3QI?=
 =?us-ascii?Q?Y3dXPUZNqmAkHG1N1fsqParpepoxnCTy/MTu9KMxVRpBsy21NBATQK46mKXB?=
 =?us-ascii?Q?lyE9hPxbsdTExhXqKpui4LErVb0Z6C+grqrM9j5eXaYnqe+hhpmnZnkkJJ5+?=
 =?us-ascii?Q?ng3GISP3s8Ntm8fWkWjxcSS9+zv97PEwM0t124ieZMNT3zLcMXYQSy76ioRZ?=
 =?us-ascii?Q?iitxYAIlIn2re729TkCaExqW7xdD7vKOiEsDYTrO/W55mcYUFElhhOzb0dJ2?=
 =?us-ascii?Q?0hcrkDjOSGpwT2pJEdizDlBBuCx2eCYCF4znDb4cQYtnm4mRxbI34QENN+De?=
 =?us-ascii?Q?nryxiX1KqRmQZx8jtqDax7JKIjskY3u9Jge76kDg+FWWhhfPSxDsczsPH07V?=
 =?us-ascii?Q?PrsT6Zq07xY+FeGic3XXiKwCwTbW1hkqRi59bviVERdnk+g9UIcGBzuDo9Hw?=
 =?us-ascii?Q?3QtVjariEs6RSX6d2VywksmJi6Xd4z6rm7XzBA5b2cMJLmhdwvnwxhiGtqF1?=
 =?us-ascii?Q?OR5TDDBqL+4TDwUabSmXtDEnliP4PU0oc+6EbfKWOkAn8m5LCWc/Q6M+hsfd?=
 =?us-ascii?Q?nRS0VzUc4PNrDlp9Twz9Fz0BfnXQi3eC9G2tuQm8DTgS0tI15A8ZjA7OSUWJ?=
 =?us-ascii?Q?O5QCP0VEnWINf7Jz5RhoS0OeMUcYYBcdfz/OgypEkrpB7MfZPiyivfShriNc?=
 =?us-ascii?Q?fDdiz86PeRO0Za1m3BhHOTa6VP3wGlAfu+Ybnesq?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8cb764e8-ebc7-4e7b-b17a-08ddf5481478
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5757.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2025 17:40:08.8596
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O8/N3WC2EpvfaG+bbRE0ALwfOCd4/b/zgyU8mLqy+0J2yiVIunz/zXcbVY38WBXF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8130

On Tue, Sep 16, 2025 at 03:11:57PM +0100, Lorenzo Stoakes wrote:
> Update the mem char driver (backing /dev/mem and /dev/zero) to use
> f_op->mmap_prepare hook rather than the deprecated f_op->mmap.
> 
> The /dev/zero implementation has a very unique and rather concerning
> characteristic in that it converts MAP_PRIVATE mmap() mappings anonymous
> when they are, in fact, not.
> 
> The new f_op->mmap_prepare() can support this, but rather than introducing
> a helper function to perform this hack (and risk introducing other users),
> simply set desc->vm_op to NULL here and add a comment describing what's
> going on.
> 
> We also introduce shmem_zero_setup_desc() to allow for the shared mapping
> case via an f_op->mmap_prepare() hook, and generalise the code between
> this and shmem_zero_setup().
> 
> We also use the desc->action_error_hook to filter the remap error to
> -EAGAIN to keep behaviour consistent.

Hurm, in practice this converts reserve_pfn_range()/etc conflicts into
from EINVAL into EAGAIN and converts all the unlikely OOM ENOMEM
failures to EAGAIN. Seems wrong/unnecessary to me, I wouldn't have
preserved it.

But oh well

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

> diff --git a/include/linux/shmem_fs.h b/include/linux/shmem_fs.h
> index 0e47465ef0fd..5b368f9549d6 100644
> --- a/include/linux/shmem_fs.h
> +++ b/include/linux/shmem_fs.h

This little bit should probably be its own patch "Add
shmem_zero_setup_desc()", and I wonder if the caller from vma.c can
call the desc version now?

Too bad the usage in ppc is such an adventure through sysfs :\

But the code looks fine

Jason

