Return-Path: <linux-fsdevel+bounces-61794-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B16C7B59E3D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 18:49:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB81D4613B4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 16:48:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B984301708;
	Tue, 16 Sep 2025 16:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="KiuzhT/8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010036.outbound.protection.outlook.com [52.101.56.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D687A234973;
	Tue, 16 Sep 2025 16:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758041315; cv=fail; b=EVoCry1DxfYrEd2E3JtvGyIdxstahKYcBd35oeHxvlRFUKrtEY87eEcS2+tdmk0dS5nj0E9m3AswwjEu13jy5xfeZYcT1HQ92VVHJzuNNSWWfja5l1/+LtV7iQGKLvVMwOo1VC6mg6zpkUxerL2M5Ttlu6Fd8v4A6RLmDnJLYNw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758041315; c=relaxed/simple;
	bh=HuHNtjHjqylSYH71x3yCO1ButeVAopUVWOr1G1TjcPY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=cQJyX4cGWJsBPNF9CpovbFy4EDI2v6WTn0aEfjrFlrlgZ2S02HPRWEjktC+qKTpqEYXXTVYXm3cTCrkNVuekP6MR0thmM+Wt4lUca9iBtM7qNC7aD/fdKA/3uaNFj+xOFccb1U4Q2dVo+z7852Z0QbkBNdfF7YLrP5qw2JnEbu8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=KiuzhT/8; arc=fail smtp.client-ip=52.101.56.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qm7srhq9bvmlQEFLB25kzJ3Qy4mRsPJoRZp6pYOX5SWn4VmH4t211rDkJWh359T0qE6sXe9qBN8FCkrcFOfEsnuSITSWfBWatAKgZNJFtPHaYqBRuh9lyfEHxjalJ4zHSyLou2WGjAsN0apd5Y3Kj8jOJ1YaNItkygbVWjsJP89SEPRkL79phyrQOGFsOqIgRCVDI+u4JsdlRQL4RbLjxiloFNmzXQIknbSrm62wUL0H+QLDJPHFL3Gdvf3Bb5QLH2RnK7G+6/IeVDLju2u86y1ketob4sr9xs5JAqSZ+GKkkCPIgo13gXGNmR/1kBs1woeTM28b8Pb5Po5V7244ZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jJOpMhAEQgYILl7N5a8CSSbKFU1PshJgODTRh+eGBmY=;
 b=VqpmXRgC4j8Yb71vO1bc+5LTJ866xYTop3/9y8x8vucH4PpovangczPQNmljrZwg4MRbw9xbYgD6hGiQ+F0yrqCvb0FMn59QcW+kFR06k7zqSTjzZ5paozUhqycx8WcNUXD8qp+coA25rerY1yxapt8k5j4q0DY8ukfyW6pEXOmD4iZRAoy3oV2Im143SxFGHRYdluTBYEIMiwLY17WOB5q1fzPpUh1r+gtmPMZiZ2hMozxuBGzD+7QCFMtHc4ctg/XMa55Y1IyACIBn9kaytcU/z3LIx93sygkmWDmUYZZdCuxSYuYIjcGZ/t9svaoHEZfFIZg/mRCO9fCNc9LJJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jJOpMhAEQgYILl7N5a8CSSbKFU1PshJgODTRh+eGBmY=;
 b=KiuzhT/8OnqtSBp1312LdyN6FG1OJ8+kffuHN3aB8wtW3zgze/aDdqW2wJJj1OosadGNW9NNC0E5cq2BLaAmbcoFKIS7pbXEs+k0NdBrejyAm7RrViYNfvMn7xIr1p+ve/qKFxtE2xkxqWxgBHZTEdbHGQ1XJG0kuKwWGEJ9fSqpVnoV1YNq6sBl2mfwTRkHaqV5reR3nzVnYPh6iDqkttbGrMmQ40ZZeKnKGgnbauMMAtCw/3M6UPqEHnV3YUHAc0Zq23sFU5EgF3MTjh3KuZxj797gVZV0eOc7JO3z83fzJzjPs10Xg2dQ3iauTp3tis3nUa4yc10MKbLv5he/Gg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH7PR12MB5757.namprd12.prod.outlook.com (2603:10b6:510:1d0::13)
 by CH3PR12MB8257.namprd12.prod.outlook.com (2603:10b6:610:121::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.18; Tue, 16 Sep
 2025 16:48:30 +0000
Received: from PH7PR12MB5757.namprd12.prod.outlook.com
 ([fe80::f012:300c:6bf4:7632]) by PH7PR12MB5757.namprd12.prod.outlook.com
 ([fe80::f012:300c:6bf4:7632%2]) with mapi id 15.20.9115.022; Tue, 16 Sep 2025
 16:48:30 +0000
Date: Tue, 16 Sep 2025 13:48:28 -0300
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
Subject: Re: [PATCH v3 05/13] mm/vma: rename __mmap_prepare() function to
 avoid confusion
Message-ID: <20250916164828.GN1086830@nvidia.com>
References: <cover.1758031792.git.lorenzo.stoakes@oracle.com>
 <3063484588ffc8a74cca35e1f0c16f6f3d458259.1758031792.git.lorenzo.stoakes@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3063484588ffc8a74cca35e1f0c16f6f3d458259.1758031792.git.lorenzo.stoakes@oracle.com>
X-ClientProxiedBy: BN9PR03CA0132.namprd03.prod.outlook.com
 (2603:10b6:408:fe::17) To PH7PR12MB5757.namprd12.prod.outlook.com
 (2603:10b6:510:1d0::13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5757:EE_|CH3PR12MB8257:EE_
X-MS-Office365-Filtering-Correlation-Id: d61a45e2-8d55-4647-e77a-08ddf540dd6a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|7416014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8RWKJpYSrLCKjmnnPUO7QpEx9qzXPTOStt6AZhaiOW0y5kVo9v7T2kPlBkdv?=
 =?us-ascii?Q?X/6WLa/9S/UAxKMPUDE/axAPVJ5WtY+lkDa4VkK5MioDErbyS+2JXLUAM9Zr?=
 =?us-ascii?Q?gSCUXU6xMVdIcFdi4lHxJDHZL61j1kJ9oL/S+mMw6pz2Afs0I3AcNmdHb8/v?=
 =?us-ascii?Q?e9fJ1QMGRZ8x8viGEvllnomQfXJpduamUcjEptcaTLYxzxfws5f4EVw1KGFP?=
 =?us-ascii?Q?D/Exd0Tqmb/3bR13Vc+sdiaUOTlZ+J4jqSTul58Yr6Oi3UWXCzRNmZIQkFYa?=
 =?us-ascii?Q?NZ59Dd06cZHPk33/ZsZLw5k49qUaSWXAinp8RDKLTR9OGqYNMBLlHhL36Jyv?=
 =?us-ascii?Q?3J9c8Cwy1+7ubjkb2gzPGRc/GnABk0di8z+VogaLvpT/DlaXSE1+6DGA9Rj1?=
 =?us-ascii?Q?AE3LDIEVLGoEiOjO7RxkJipEE6gxhI0p7F8xNEevlp7hV/KDtQ9GFsC1q4Jv?=
 =?us-ascii?Q?bB2ly10MIuycDEzXqi/WbOLZMStH1V8dJcOtI9ANtN7w7M5BKx6rqdGueULT?=
 =?us-ascii?Q?MIdwK/YH/Rc9FtZcI28rmWHqDpnuQrDuR3HdgEI0VhwHGWDQss51K2vGWX30?=
 =?us-ascii?Q?Hbu4Pb/0HVToDj2+4tSkgpefkOxX490k4SR9S0g5f3gggXp07g73kf7ZhdSg?=
 =?us-ascii?Q?rjvOknxSAy7YHyj70Wpf4J8pZRF1dS0reolH9czf0Ra6qI+xhkCzoMZriThW?=
 =?us-ascii?Q?FxXaBul78GXxFgLCtB88AuaJlKYXStXSSAy63deapvyeM2IlFWQqPs1f9X8l?=
 =?us-ascii?Q?jCnDtiJYS6NQFdtPAjbwHnVBSC2M42xQuBPC0D0SXwdPdVt3BadD1vwYX+j5?=
 =?us-ascii?Q?6H1gJtaOuaqCvUGiH2HbDKX5Dh+M1835VZibHhr43oEeqPIAv/ZjvOCHxLin?=
 =?us-ascii?Q?HL6cKXPcrjDPVpQfIOOx95/kDpinl6Y7J1kBzBv61wHUJP+6y6/kTqj5Q2Mt?=
 =?us-ascii?Q?7qn0G8X6xFmIfprO3ocogXIq0+E0WudUm42xGDFi55OoSY2PaBiUlMQB8VSO?=
 =?us-ascii?Q?175Zo1R5XmPUZhxd5sbg3OYUvjbehCOodPDBjmB+ybmSK7Q7/RIUmjFB2M87?=
 =?us-ascii?Q?ct4+w02ne8fy7ZrgtDmBHdjUA+ocF5c0WiajteEMM/tW0wVVgggwD/12QJ34?=
 =?us-ascii?Q?9pjVjxp0z18O+WqlHxiAdPF5EIUGkijn9vOEZXs0QoGJps0eME443WgenxSh?=
 =?us-ascii?Q?6PNiOGw32WUEf25Q+Vx2IimFWg8H9kJE+2WMrlS9E3Hq0Fom3jcC6wW6xbBt?=
 =?us-ascii?Q?+US0ixCIFPP7pOPkMaJ2RZE/kr3f8uzon01m4YVpE9bJs48pR4H39HaDrOJm?=
 =?us-ascii?Q?fJQT8fhnzRRORng3TDJeiOBZeL2f9PzfnaAY4N4UZVk2je73k8bqt6ZtSgoW?=
 =?us-ascii?Q?anxXJGxH2nbb0M9rhW6TA5Zkd9m2RPFf3dT2RiKX4oy/qPxFazbzd5NZyCjB?=
 =?us-ascii?Q?X5lD466DDzg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5757.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Qs4mq42U9P5yoyksAXh++z+0qZ1kS/QpnK73bm1/HHbcHS16/cknuK13jix7?=
 =?us-ascii?Q?KKi0Mi3KpYC71BheZZQoOjewlBnousEo/bRNYijdAMqmBJ+0daelj/whUSi3?=
 =?us-ascii?Q?PTHO+tjRbDGjfBq78QyK/qf0QXdA7FLLncG2cIKUZISawyaVuzCvaUlfq+Im?=
 =?us-ascii?Q?elWwtDBTILKnRZ2SxPrGkZ7qoGZxL/Gzm/MFcIP5JExwCL3wzSoo/RX9VCpv?=
 =?us-ascii?Q?m/tbFE2pz6zzmYiwzJ8RzJ/bfgyPomoTcS+qPIl2Ogk6PE8rA4RNuFsp7sD7?=
 =?us-ascii?Q?x4EncUAL0Pqltf19qfw05o39iHlqzrSSzkftrsmOBqqoINNhspVU7rSGVWIs?=
 =?us-ascii?Q?A0y0Qub2n8Q2EeTs6BjKeB9EMjhjea68HMAkrKNL3dy+MNbYsAJSHQ1apoyV?=
 =?us-ascii?Q?BL9XKzjfxKKwmuvu/1KNYRUHLHN3R4hkjOXDgtNeuEK6Zhd3hlUOwLs/AxIh?=
 =?us-ascii?Q?uhB+9JN9xrcJHrAIZ3gduZuT919LuuufImEsDuYZexrTc/eD7c1YRTEGJcq4?=
 =?us-ascii?Q?06EAJmvJUY4Jjw3aPZ1kXhleiEb2Xt9C7NuAPcce01sYOByP31pMDtm6ETMd?=
 =?us-ascii?Q?FVe1XVXqVqTvs0HLvM19G05aHKPRxsoyWjhKQM8ziLE/578yajYJ6csCZIQp?=
 =?us-ascii?Q?bBm4V2pvFXk7JcAnVck4eF+N+O1z8xP4YzLD0KqfkHd3+yWMhLybM9KEJtsY?=
 =?us-ascii?Q?bY0N+/GIs1Qnh0Ta1MAJJ2OSUYiRldhadGPkqyg9Q3LZM6ILwDxzEnF5gHAL?=
 =?us-ascii?Q?svrFizmaGaCmpYyqiJs+EniYcA1t5a+KDLiU6lsLZbFoZHN3gHdco+cqLDi6?=
 =?us-ascii?Q?prpvjrL/B+NlG46lS2zFoZajID+kb1fkqg+B3Reddq+GI1SbOnwjN/wRqSUS?=
 =?us-ascii?Q?vWxq7kbRDAc59UM3gUysrWftnoeTzDDTTl+s8gAdXQAGxhTQOYTewhR3Vjww?=
 =?us-ascii?Q?BIkNC3TYQIFmJr0D01HoMH3PlLTQavRODxkhEZkpnkPWQEEnlxerc8azmVvL?=
 =?us-ascii?Q?9BQS2p+HZMCKj0qsJV3+EQRD4AgqJe2O+H56Zx5rduZc+64wLWD0Htjur9of?=
 =?us-ascii?Q?8rM4RX5U8ZwMEZY6kThMurLzMij7j1aHM36nMPcEz45zyJIQZBe1ObC6QpPf?=
 =?us-ascii?Q?NBheEVjCfZinhxROy70K4Op3uNz1VUJl/riFA8wg0c/a172wtPj61jXXZrSb?=
 =?us-ascii?Q?CtWPPP39ClBQpJuzGs826c97YcAU347tqDKfgoyFH5kLCgbKyFy8zYJ2+6oJ?=
 =?us-ascii?Q?2CDTpWIz0qgl4ZibklE5oW93rL4EodSKmjneYyA+NAfwOwnuaXPvvikdG65E?=
 =?us-ascii?Q?B4lLH1J6V1KCllxGzIox8SulJWc6Q7NAjeE5q7VNeMI2Zgtp4m2I7sch4Pg1?=
 =?us-ascii?Q?O1TGlYzSBezafwIs2eFipoks5aOt6tE9PF7kn/6HG2A9MftdhPa5ksFwj0/v?=
 =?us-ascii?Q?urZqLglyGBvlWi7PC0anMniFzcwvaLbMofJumfW8/AuLP2a3VmweigBM4Uhq?=
 =?us-ascii?Q?+RO8KTj09iCsg1AOrGjR+7pMBgqmaeOSYw/Y5LMYYHfaHGuaNUqyEs35AkgN?=
 =?us-ascii?Q?HZJ7BwxDQYXb81nXp702CanB68Y14EGyOPP+JaCq?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d61a45e2-8d55-4647-e77a-08ddf540dd6a
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5757.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2025 16:48:29.9628
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Nwp4eaw66L824OfadXyw3gBYlcskT/1LXtQo9n4W1IsVfavE77R46nxxn2WN9RTQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8257

On Tue, Sep 16, 2025 at 03:11:51PM +0100, Lorenzo Stoakes wrote:
> Now we have the f_op->mmap_prepare() hook, having a static function called
> __mmap_prepare() that has nothing to do with it is confusing, so rename
> the function to __mmap_setup().
> 
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> Reviewed-by: David Hildenbrand <david@redhat.com>
> ---
>  mm/vma.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason

