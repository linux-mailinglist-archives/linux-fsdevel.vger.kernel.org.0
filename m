Return-Path: <linux-fsdevel+bounces-61797-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E256CB59F20
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 19:19:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 98E04462F25
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 17:19:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2CBB25F97C;
	Tue, 16 Sep 2025 17:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="cOwLbzLy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011048.outbound.protection.outlook.com [52.101.52.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CBE8247281;
	Tue, 16 Sep 2025 17:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758043179; cv=fail; b=GcKICpZ0QlGs28000m/ivZ4H1fPzJ+iQE0i27myU2mqniKpKbAgzQ6DI2FLpuEYj2uleMRM64bJnTjI2/h3NIBJPX7JuOp0st8lpyoUqhDu6rVd1d6PhJQvtsMd9S0NSzzK2AxLoeGXGjgnlQguzgitqwDix9pusA/bEmzT5lnU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758043179; c=relaxed/simple;
	bh=A0+3feUqTD4C1kik4egxjecsOenIsqggJAOI5S9fwVM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=tuJx0ze2USk3+OxybGmnF4XeHODYhp8BQFnr3qCPu5eP8hk+7j8oomSQXdqh8q1+m4oDqCqLKZ+aYup7ory+CECdaNgiVKda32irnEwvuTgrtDahU5bjg02wK2zJ46RRTwzL61prfk1fa7knmSmbNEOj4S4LDYuP48UvT/qoxyI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=cOwLbzLy; arc=fail smtp.client-ip=52.101.52.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=baSuvDaQ2ylCrkHKkizEF6YSOnKO3Pqk8tJzdh02lSy/NQ+wERIy3K7yq4rZepdxkn6GPefbrjr1gXJSZVPxEOb6ppb79G6jnwMANSJ6BEbR320R1T+XPOZaSYB/i/59rSnTTS74WevapLytqDY0l99m0ASADQzsRUeNXIqwTl4KIgDj01sUdEp6E9HfWZbSp/jurSrENOxQDO+pA4O5/+bTV69QGwGtGDMn8HsuDBBVIZodYcegYUgLW6zVgfOgdz91wIeGB5HYtmBOq1C5pMgNzoe0Bi8Z+SJT1VSJvEFadqsqjlXIqNFDbYUEsG2CWibS9J7b69MtwInebu7Yhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ItVKPLLwvprRNFT6X7VAsBvihdfCxXFF9VCA4y3l4f0=;
 b=v2syJOjmtdwzii2SW5wAzlm+1rY7WyiBUiVwx4t/Tfy2P4qFz4p+Gvm5MbK8xWByj4UtZruJwghb902kM8Z0rJCdu+D9vU15eC+3ULfP5GeTZDkWo7mWL2o+Ro8wwHbrbCPgClMuzJRcazicgNkN3af1ebFYlrxKM/gP4tsrqgOLpauDIcp2UESVivsgv/+lnuoe61CIIQ9R/tss6rTO6YhbZ2NlNl1DAbkTK2A53tiC3JI8cudr+7XSCvnGirohdHkjgmsT/KFPIPAVUmh1eMjUdD0cuj6TCqz22hwjFu6l/MiXsgSBVJX5msYxO2edF4DETSEiWfrnFlgiCwjo0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ItVKPLLwvprRNFT6X7VAsBvihdfCxXFF9VCA4y3l4f0=;
 b=cOwLbzLyhDwy6AigXL3yFMBe3XYpK3fd2XgkyQH44v3l1EKN+a45x5WFgREf17SyRujxuV5WGrTP+AokHXbZWAb3aO5zWWd5p0QEi8PLc6SAJ0lpMhKIUQNxkZkskKHWyrY3NAO1jYVNiWBnvz3uPm2gM4xdVGkIgxc6SLp3xizqLaITWMMDNttOGmbgybnIK8i2VnPW84HIwU78MBCQzwzph7UToyI6o9+PxT8N89rnLBY0RIklBHWqP8kJUtaNRw/N3wEX75Nx42aDTXi3xx94vNdVJcyiIZXv+FwUJyVdR++k22dEbu7imZWfd6SrsvYXA8PJIVs9j5AdtickbA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH7PR12MB5757.namprd12.prod.outlook.com (2603:10b6:510:1d0::13)
 by MW6PR12MB8900.namprd12.prod.outlook.com (2603:10b6:303:244::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Tue, 16 Sep
 2025 17:19:32 +0000
Received: from PH7PR12MB5757.namprd12.prod.outlook.com
 ([fe80::f012:300c:6bf4:7632]) by PH7PR12MB5757.namprd12.prod.outlook.com
 ([fe80::f012:300c:6bf4:7632%2]) with mapi id 15.20.9115.022; Tue, 16 Sep 2025
 17:19:32 +0000
Date: Tue, 16 Sep 2025 14:19:30 -0300
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
Subject: Re: [PATCH v3 07/13] mm: introduce io_remap_pfn_range_[prepare,
 complete]()
Message-ID: <20250916171930.GP1086830@nvidia.com>
References: <cover.1758031792.git.lorenzo.stoakes@oracle.com>
 <3d8f72ece78c1b470382b6a1f12eef0eacd4c068.1758031792.git.lorenzo.stoakes@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3d8f72ece78c1b470382b6a1f12eef0eacd4c068.1758031792.git.lorenzo.stoakes@oracle.com>
X-ClientProxiedBy: SA1P222CA0108.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:3c5::29) To PH7PR12MB5757.namprd12.prod.outlook.com
 (2603:10b6:510:1d0::13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5757:EE_|MW6PR12MB8900:EE_
X-MS-Office365-Filtering-Correlation-Id: 341fc7f3-738b-44df-f13b-08ddf5453383
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Vl4N23yHSqL+EMYITX/5wxgcMBlb101tXwqHSvX1Nrj1+UJ86bWRvRyWZi97?=
 =?us-ascii?Q?4aDaQDAckt0xzvg/pnEA0L4xfyRH9pKyVhAdep6gp9Etjvho+S0uOL/Ueod4?=
 =?us-ascii?Q?l8GCHY8nh/p/odFodZlqU9CvPHfxom4zNbZCdqzXRwzxqvGhsdYiU7td8II7?=
 =?us-ascii?Q?gQJkRywrOuRJzMkyb0Nn6akE+z6Yt9iyIeFUk8rtyL8NXR2mQaEcxBjDZx6p?=
 =?us-ascii?Q?nu0pECMpyFFvp52GRPbs6s71w5TCLtZUV4Pyce67L89kHDU9S+LSICtTijeH?=
 =?us-ascii?Q?n236R3+ZllgrVSg8TH8rSlVY6sLvs5f//OBkFgsRiGFbHYrZp4Fi399movEO?=
 =?us-ascii?Q?Slg4dmL9r6J7ivLBtZE56TAtKgD65wPssa+blGBP0/C7vmeewWhuU88zHx1w?=
 =?us-ascii?Q?rwRBW6yjGV99OOPlkFJJvT9G1mb4B8gL9kodCW8TYybevEAD9T9+qnQZ3MXA?=
 =?us-ascii?Q?2KeA08uimOIknR2Os1tMMr6wUtdtfCAViAou4nTxXMKF9i8HO1aYVb2NagEG?=
 =?us-ascii?Q?qFB4751J+ZsMnITBVGt8/zBa9BU3mjbke3NGaiaJFv05kk+tJN5HRCD9cWuK?=
 =?us-ascii?Q?Bpi9zO9vYmyT/unFemMnk0RZC4/IdGafyfWr354d0qEK7ps147cLF1rrBmSN?=
 =?us-ascii?Q?Lxh+Yv1z9+QKD/KRkGQsQrmbHWclN/SjnSDth9tyfwY0U9ob0ZTwmDZCDFBA?=
 =?us-ascii?Q?EwXp7REhQ2FuEMUiESSXffaYIgRLSOrI8NUS+smvPLajuOxSZX3Eo7RmPI7F?=
 =?us-ascii?Q?gxFOkg7WI/LgdriTHfi3is2ggJvE1kUV1dSF5K/0N5iwEfgCxec5RLy1Q6Xs?=
 =?us-ascii?Q?blPz+y5aLy9VA7VZVL2/vth3f5cA3XI9gdxYPjsRohbK4VHmBvxujN6JmTUD?=
 =?us-ascii?Q?Aq9aWNnJt0M4o+cse7wa+5G2rgt05I2/qUdGhka3IRly7TQGMSHycu7yX7pD?=
 =?us-ascii?Q?l++J6YGzSDCDzbhOJUA4ZrOB3gWbEqi+Hu/s8QFUjdIrg2zyKk2WwT1UPL9m?=
 =?us-ascii?Q?PDiLxtTVncgc6f1iTKvLw8Y9Kjbum+fQ5nV5jdnBt9wjBw+ztcRoJpqULl+A?=
 =?us-ascii?Q?LrDI7yVlMv0UU3b4suMX1NSfn/Aw7RV4rWRqzGW6Qu4Kj3h9vbenqGGAsZsq?=
 =?us-ascii?Q?0QDD/pT3C/kLdRwMy8c1kZ0azCMdYvJ5zNY+vn3ke8m5tYwHMIYaxPficH2f?=
 =?us-ascii?Q?p/E9JtqqjVrAW6gKMaJbOpurvRBKsNpKGrESev/ARBgpkHn8sxjuL5pOaDq8?=
 =?us-ascii?Q?AtWI2BVjgyKbdJyBCZYtC7jB2K0UcGtXx3Ukx0qpTIzJK52CpOI6Aw+QaSS7?=
 =?us-ascii?Q?UsalmDJ58w5f+Gbhn+zfkmXUXtyU0IKxzaEXSsqN5jZ4QbgwxwsWNoJxP8E8?=
 =?us-ascii?Q?8T/tf1iDCyvFLMjxZ3VZuHV1J9zgH9X4fXxPraGNesIi4sjqd+KWsxg9SiUC?=
 =?us-ascii?Q?RNqaEY0eG2M=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5757.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?AhwdEjg3CH98NPMwNrq81fS5VJ/FD+TIBa+jyUvBQ/8W5qkcRF0Opo6yy2BR?=
 =?us-ascii?Q?ZB5IIt/4Yd5JrkXHQHnDOV7oAA2VKBoGWC5bVgihffsfh8z2f0ROYF07ivZP?=
 =?us-ascii?Q?3hx2dy3cBDT5Av+sOMvESByR/9/oV7DywGArpes5AMdzy/619g+VWbwTktan?=
 =?us-ascii?Q?aT9DMqwLjlKCXr04SQAqBoBWItfVP7wjrn2fCOIa/XPIUufaz8+QsBE248Jy?=
 =?us-ascii?Q?EVaftuOPijwlnyrq7mVw90wtDmJojgUZwFKzCXEVnG/HkuI0qdb/ak2lEJPF?=
 =?us-ascii?Q?roiIAteoeVmCv9rEQXUNcTX81SrF1lGhgOejDhCom+BhNMANb8FMpTH0ixvB?=
 =?us-ascii?Q?QTcpbAQzKuHel2TCYd7drfhLv3CYaYvx7BHkGeO6qXrfXw2xOddHan1lQ4tB?=
 =?us-ascii?Q?fjQnBtzkIOa3IpSlvDgjn4Utr0hlJMuLmGHJPZv6+dq0qYR7JC4t8VPOxr6T?=
 =?us-ascii?Q?mms9q/k1HKC3m6oRj9cznzrJCJRo+78AZKslDQ4WPAZNXHcOmUWWwAvffarV?=
 =?us-ascii?Q?D0wEVgeKg4CYq/xcuq5lat3lza2xrApCjnD1g3mYeraJ86uQIc16Px8v91rb?=
 =?us-ascii?Q?iPGcvDeycPdvttntwZlyTyW98R3XqteIkBbltnqYSr5iYOT5B6jfqEiXX7sp?=
 =?us-ascii?Q?KAIofZe34u5h3lSpAXqhvoCT2nlQffsv+lwObsfWmxLGW91QZwXfudYmHxXc?=
 =?us-ascii?Q?mUzIeCFbESPH1HmFqN6AXg8HCL6qkTMerzYMVuhZDj58zgx/rcbUDBu18095?=
 =?us-ascii?Q?1O1cErQrnPi9ZtmIOFbefnvuTWPX65wt0HJrzEnOzmC1omSrF5Dh0Q5mlik4?=
 =?us-ascii?Q?fGROhDaqH0VxNl2IV4qPczxcwJzvG+vYlbGDojr5X0ECOGw+HWvhwRlNFp4t?=
 =?us-ascii?Q?5p3ywYkzsN2cbrNSp6cEFvco1xpuUae34qXvSOX5rQQV10RoEZ7NI0M7VXdg?=
 =?us-ascii?Q?CyR71cqiAnjT6eZQ6oW6KewoVJbjvrQNKluIglALj1kl67hIwJHgRXLvBr/Y?=
 =?us-ascii?Q?NRB0GUZsej9HAgoejz9WJ+M3yg0DRRMjduhr4AsMeTUNLDr3wTWzS9ppogl9?=
 =?us-ascii?Q?ieNHrlC+EW9+5wP7Jbu5fJyyNh84qflUltAqsPOv3QxgPrW/lR1pr2rEEXHn?=
 =?us-ascii?Q?Zy2+neRkJsJI8SibWnTenMm5YmNSaoLq7f2uPVSDrgFexE+NTRxc9MP5hghR?=
 =?us-ascii?Q?Rr86kppon3ONCuT+C+Q3G9ekSRToyy7illnDfqrXHyCjgQvwfiD4rOTHfuuF?=
 =?us-ascii?Q?vcC7dkdhPXxfiGvwAuHDNEm/D1Mglg5wHH3qjnm1RzRRaFbwIzsEhCx2ZIkS?=
 =?us-ascii?Q?9d5RoYvbK4ajNSOeovHsyLQDyOf3LP4e2uXBx70Ej+OFHmbkDBiRl3K1+fiC?=
 =?us-ascii?Q?CqJ5G4A/Ni/ynEFwpA0Eh/74B24XN2sjZGfvYiyH50S15n/Qot8jyV+kkthx?=
 =?us-ascii?Q?oKqmJzk7uvzIbI9ZrrrxvbiqZAHosoN1/J2DzrIP7K9O2lULFL3791Q8GuWk?=
 =?us-ascii?Q?+9a/3uBPmjXwSCRevZ9y0tUg6KMQYGsqlAmLuqHYkViSS0d1JPXMdwahe0t7?=
 =?us-ascii?Q?OShIkfoXWMm6LOzV1cLtpbMgi7F8EuFOnKiSYl/l?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 341fc7f3-738b-44df-f13b-08ddf5453383
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5757.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2025 17:19:32.4937
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EjmQ13RSj0Z960t1+t5GSw7mtIVaFDa31d2y75L2NwWOggCBGnh8VfbpxDh+LgXZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8900

On Tue, Sep 16, 2025 at 03:11:53PM +0100, Lorenzo Stoakes wrote:
>  
> -int io_remap_pfn_range(struct vm_area_struct *vma, unsigned long vaddr,
> -		unsigned long pfn, unsigned long size, pgprot_t prot)
> +static unsigned long calc_pfn(unsigned long pfn, unsigned long size)
>  {
>  	phys_addr_t phys_addr = fixup_bigphys_addr(pfn << PAGE_SHIFT, size);
>  
> -	return remap_pfn_range(vma, vaddr, phys_addr >> PAGE_SHIFT, size, prot);
> +	return phys_addr >> PAGE_SHIFT;
> +}

Given you changed all of these to add a calc_pfn why not make that
the arch abstraction?

static unsigned long arch_io_remap_remap_pfn(unsigned long pfn, unsigned long size)
{
..
}
#define arch_io_remap_remap_pfn arch_io_remap_remap_pfn

[..]

#ifndef arch_io_remap_remap_pfn
static inline unsigned long arch_io_remap_remap_pfn(unsigned long pfn, unsigned long size)
{
	return pfn;
}
#endif

static inline void io_remap_pfn_range_prepare(struct vm_area_desc *desc, unsigned long pfn,
	unsigned long size)
{
	return remap_pfn_range_prepare(desc, arch_io_remap_remap_pfn(pfn));
}

etc

Removes alot of the maze here.

Jason

