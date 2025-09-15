Return-Path: <linux-fsdevel+bounces-61373-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32EB5B57B76
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Sep 2025 14:44:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE48D203B93
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Sep 2025 12:44:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AB5430CDAF;
	Mon, 15 Sep 2025 12:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="GfyE2UD1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013022.outbound.protection.outlook.com [40.93.201.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B01523054C4;
	Mon, 15 Sep 2025 12:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757940186; cv=fail; b=pGOHvIIUTsSgtNnfZ00Q22wbyUxsjS0K4tSLiMNQVCDJB+MUN12R+UB9Tc4j6oJ3io3N7tT3JjWFyHp75dhcdFLXjMa29rDNY4oFLsRZPX+P84ycUwWkgWyEnUHRH9kNkweoVB9wyT46+dMIu5eoIxDFmrN4w42+zkaFDROts/4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757940186; c=relaxed/simple;
	bh=D2ZXIJNKXUOgsz0UJVQB6VVFPHvaEJZ3N+oaNwn68W0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=IqWFGz3vz6ObR5YfVIx1f/c0uZVXEihrYT9Ylf/DXGK0x+JZiZW5Bv6Cg+j27G43A4d25nV8CtAt0wCSsYd32TkZm8hZzY9Su8yoNKMlhfXfoTphm+xiK/Wyxcf4WNJ6EEYJufw5h6FWJApvBaI2fsvXSczNkSu39xP0Rg1oRfE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=GfyE2UD1; arc=fail smtp.client-ip=40.93.201.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pR7jGD5VQnZyjw5oIRcFhS5gDbhMafpokwhWVfOrNFr/6RkZnXxPVXdevX6JcNXXPiwMeJBlg3TzngI1Ubn9u8iUQ7z9IgxzslxFRq3SX6JGbskR0Wt+X5kax2+Gt46TZCvW3VYB3f1n61PH7kjIk2I49XT0VyRfHDrcq1R248P3zHUxoAoFYHRLrVmUUG/ZSo1A3wj7uKlbAp0ZEBRERw64bY+YO0SKNr5ptpDlKfXGR0n0jWLvM8SbOtQqkUry4bm/upMkSR4s4EX5EEruVs2UT7laz5PujPEvUt72i10HKo6kvH5Z77sG/GFoiqXNKl9/SmCkmDRXZoY9/Nodag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5ohlcgjMwlPGLbA0CUY5UdnvTO4QqpmsXQ8z+4+DxPI=;
 b=Eeqc32uVtYdCGbzaTdrWyUoSwmCDaFsoYMKaTm8a6giV9EOhmI35GVxMl6tXMS35q4X40liQbjYkYhNyUucbAnPuOyN5+09UZYrgmZBgP7gstPkY1CZH+Gyz1x3jJCV4FaC9fUBtlOE5caC7VxoVZM/LojJtYeRxdOc+3N0Dgje3k9DXtPaZM6CTFUY1nH63NFyZ/ap0wyuG3Bc4jJWypJE2wUcVXobH/H3gYYiclu4uUkCdvQ+8ZCgzP1gZSPvS8lKlB6r72yfap/tYxKm3zHg90pCLMIqs6V/oGCVjp80IfyVwnWgWEB4k8xFZ0407cpehC9tUnvqsuXZ3MV6eDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5ohlcgjMwlPGLbA0CUY5UdnvTO4QqpmsXQ8z+4+DxPI=;
 b=GfyE2UD1oemnddKLCY6caj1vk7gS/yWFExJfv+jIwFjZGWnYE8hGJt3xUbws558whCmCbfPh1hV1Ct5/jnQAvQPLRTQ8wa8ZOEmvIDyiBgqkj1alo0a8+bYbSutzGB690SHSzaA0tAYI5kkDLNsd9dkw1AmIclQYh+3TPn79htaM/gXcamkbmVSO2Xld/sc/K9sG4k9fGNU7MBZ/DYXTFwu1xOIgRKp6yA8QkCiT9slCMMpRejI5vHEAf9fYtESkl2lWFvA0RMyPSKnN5CG41nfFNONiPm7sXKPNU8mdViXqraYCTNiYjJHbFa42mP/sq0gtRnydfdt8iS2usoI/NA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH7PR12MB5757.namprd12.prod.outlook.com (2603:10b6:510:1d0::13)
 by SJ0PR12MB6688.namprd12.prod.outlook.com (2603:10b6:a03:47d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.21; Mon, 15 Sep
 2025 12:43:01 +0000
Received: from PH7PR12MB5757.namprd12.prod.outlook.com
 ([fe80::f012:300c:6bf4:7632]) by PH7PR12MB5757.namprd12.prod.outlook.com
 ([fe80::f012:300c:6bf4:7632%2]) with mapi id 15.20.9115.020; Mon, 15 Sep 2025
 12:43:01 +0000
Date: Mon, 15 Sep 2025 09:42:59 -0300
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
Subject: Re: [PATCH v2 08/16] mm: add ability to take further action in
 vm_area_desc
Message-ID: <20250915124259.GF1024672@nvidia.com>
References: <cover.1757534913.git.lorenzo.stoakes@oracle.com>
 <d85cc08dd7c5f0a4d5a3c5a5a1b75556461392a1.1757534913.git.lorenzo.stoakes@oracle.com>
 <20250915121112.GC1024672@nvidia.com>
 <77bbbfe8-871f-4bb3-ae8d-84dd328a1f7c@lucifer.local>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <77bbbfe8-871f-4bb3-ae8d-84dd328a1f7c@lucifer.local>
X-ClientProxiedBy: YT4PR01CA0402.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:108::14) To PH7PR12MB5757.namprd12.prod.outlook.com
 (2603:10b6:510:1d0::13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5757:EE_|SJ0PR12MB6688:EE_
X-MS-Office365-Filtering-Correlation-Id: 42b53a64-026a-480a-11a4-08ddf45567cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?sO+0aRI8RF5E58QKySfGcP9rblmVAJnVToMQWH7P2RgYhbMUamsORmdQNvT2?=
 =?us-ascii?Q?4hVGV6Fe8VMp9+5bry894eXhYKoD1e13Ke4krKmqJu502FkzPzn8nOBFvGtu?=
 =?us-ascii?Q?RNFhml/Dvk8IbNVHIMGTgW5q6n97z1YmrvDw8tyuA3Rjv/PFJb2dit5Qw3/v?=
 =?us-ascii?Q?h+iv2zuRUjfI2HKtXxF2myowN129A5nwzPKvGQMhqI7UH7JNNg9HantiAkgG?=
 =?us-ascii?Q?85cRSeEpLozDBCahfEbOyKCMB4sSS4XNCnxuHr5AIVsr623Fp6J82VBAjAUo?=
 =?us-ascii?Q?CroL2JdK4o2rdiUABeJQFAXPPt/Fjv1KX9sjg9gxUqnlCuh8tcwoTHvKjXkn?=
 =?us-ascii?Q?y8POQl7ggi51dgLCqiuEkIQOMmjlQiPUCsp/iUIIQ6hQXY51f4ZJu+5Lvcpd?=
 =?us-ascii?Q?pjPpLtXV4V0i5BOnNA4lZXUuonJtriokF2IcwY/LNUniQGvAjW6ngqlfac6l?=
 =?us-ascii?Q?Pf4SFqPbClChMDVI6O+ahaflpaO9H1X25hKqseS/bYVfOCKMDb5yb6HYTa3m?=
 =?us-ascii?Q?IisTBnIhzzBBe7a3K+mQ4SDMlK3875gEWBicjOg7rNcbEMGQULyLCmTc3HGf?=
 =?us-ascii?Q?l6zhTU2l0Yr8fG4WEgSDdax5suBtBaAF7ecfXyiakYfT6UKxiWmoybpt+M6j?=
 =?us-ascii?Q?vjoJ5uL4s1DVLbguIjnGmk8v3HQfCnSv6pQ0GelJWJduheLWO04ZC/VVNsaI?=
 =?us-ascii?Q?5jGR8iXHJVJ7i2z17CpvZrOZOTqD65zhwYnVuOf63FuYNaH/XY7BpRgjyA08?=
 =?us-ascii?Q?k84YSL/l8VhBNV7QMHsMkAGsos+sG3JBnzxRRWXzy1ESOgTrMyj1Shqua0uP?=
 =?us-ascii?Q?pP6O8qMr6ndlSQJNw+MuhKI39mJ9hR+wDH/AKQ8L/nzMBpwQRRdBCNZWbzKL?=
 =?us-ascii?Q?T56Q29Ey+jKQQAKlOTd747y118vnv96O36D3wmq+H1/k+B8QfEFShDTN4lj3?=
 =?us-ascii?Q?uj5Dco6nVX3a0EK4rw88BRun/FlAJK1Npg689UQeTLxfXEMa2R1kShoMwX6b?=
 =?us-ascii?Q?Auv78JqnBrCoPPS6VYERG6cL0YJ0EOu8z6QW4ZBLwLjEaMIFmYfav6qUpsVR?=
 =?us-ascii?Q?5c2bSws0vf7PY0BjHzxliGliYDFMe23rjltQnQ3BcLPQ5mxK1JzyYFUTIpiR?=
 =?us-ascii?Q?zNivisaLb2psgQUFLhLANtP7/7tJLF5WOPtiL2/quwrjQwiOYzDLfy8khgMH?=
 =?us-ascii?Q?swSjjmfgXF2OysqdHycMq2veOuxb692FusVbVF/oOZL5JbuWDRLdfnLeTihM?=
 =?us-ascii?Q?6a4S1yQuWc7IzcOiWYbuKSASxEUqMssSP11Y8SKqJkxQQeV7yx1GFDgDqCVW?=
 =?us-ascii?Q?hzAJzFGDsk85yMPxwznxc7PPz2vn66e74hk+2xBYlH6V4maYoZxhCi+LVaIB?=
 =?us-ascii?Q?g+Wu7FmSqq+oooUr4+J1+LNUscnOD9o7NrvCk0O80qa6YBjrSF96kPdNIElr?=
 =?us-ascii?Q?zlw68AQKqR0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5757.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BBAt10kH+tWfob6BKdTgTRP451+49KXe9TmfP/ryYA3h1XJdSeAJ7b5s/2Gr?=
 =?us-ascii?Q?QGxCitj26rNqrLm6MBIFnWwj5/KpCrTRTGunvzJUgnjKenYtnEp0LBzr/Wy4?=
 =?us-ascii?Q?ZxwSaHtGXXYdOE0jxuzprbSMn1VImi1d9rC1dkmx12eDXLhj/kAbxW4LemFb?=
 =?us-ascii?Q?k1uRZ0l8IRPe1Yl4kChd9jrjQZuCPewV2Po2XAv2qmH1j5bPvOheuWJ9h1TF?=
 =?us-ascii?Q?RTRAGuSb7sAMbLR4EJpYXl9qqVOPT/MCcKJhlvSh00+sXYpBIXpeqnxzUMiE?=
 =?us-ascii?Q?cVQxBXTx5xpcd4jofLhTDfzkKG+d1X5xmLQbg57Jmp24AiXBRlnpQ4dZj29R?=
 =?us-ascii?Q?xP6SdBY9N0TCqtRCClAl731hMgKTUDz+M0wEDftfJI03PJFR1bmN0BD2iizf?=
 =?us-ascii?Q?7KLtjRMjYSmOT0NT0BcKyU3km58kvQ6myyPq1j4JyNZrToYpKvltWnrwSCr0?=
 =?us-ascii?Q?F/P4LEUBXY/KF6O4konJQVAxDCFnwvgl0kYjY3901jnb1sRynhAfR8u3kPA7?=
 =?us-ascii?Q?vUEvoR3rGADRix0CJoOqTeMJbMrWBjUJtv+xsz1xmKb/h+ioifDwaUjfhjU7?=
 =?us-ascii?Q?/oq9Q52TS+DNYa/IXqa8F44a9kcPQ2gHbvE8XFxfCpJzVZoiO6NZnb6uO+Lt?=
 =?us-ascii?Q?gxC/sEOVk9lh8WDIpG75kiA1PHn4CIbl6tciBFkY79OMzu5HaW6uL5wh4dzn?=
 =?us-ascii?Q?cY0T8qkSyYXVcR6iMTxIJeWOWIg33TzikEyJJj+DC0+QlbqBB6Lu1oH6o5zQ?=
 =?us-ascii?Q?DiFFBDqjGn38eciMiMVu6mqkSBX4wF4kAWssrQc6oStqfG5FSgLziEgk7ETw?=
 =?us-ascii?Q?eyi16ITzUraQVM8U+wZ9pazofspZjUVrMe6Rb7E2Rs5Jhgy67y0yW2U5wdvw?=
 =?us-ascii?Q?5x8FVKOP+7RBfAVO6xe7CV7zezXrMu1aSghwv+Na7kFJS3/yC9lgMEoQfppv?=
 =?us-ascii?Q?EHi8Ep541WvJ9w5WinP309soLvEW5p0XplG6UeiqJ0XZq9yBJGKNrWEBU8+j?=
 =?us-ascii?Q?xJbAK2g+LCwMSz/q7GG4h8TBaSv8M3M9oLrCHCoxvmyi0dW7djb2TY+QU8cJ?=
 =?us-ascii?Q?skNWlO2/aie1ISx5hiMucb8Ir3Q+qCDBgRB47IRmiY9EM7LjjUojXgP5gz8e?=
 =?us-ascii?Q?gGMGh05d2DzwNMUqE+cGTXI3akqvdn0Z06maSA+iJTDJpy9IRW23bXbp29D/?=
 =?us-ascii?Q?NhXYfKDbnkFap8CnKM7PdDqPVQQ0kqNCCab3lY+neUbfHN57qHoXQiXb1ZO8?=
 =?us-ascii?Q?BOW0OIqFaRK5kCrIQ8BGpY4MIkfJac5T71Wx/PVdCtHn5TDmqUhVPhnRb/1Y?=
 =?us-ascii?Q?SuTXO3dhlEalK2LetiMyLvix9hWBacFvp8Nm8ZF13fD5h/MZ7egAceAzg4ma?=
 =?us-ascii?Q?KSQ4HBblKkEcXla88k3Gwmq/AaQpjITCfIrhfRfmWF81/2TKSZVUPF7A1bSi?=
 =?us-ascii?Q?j2oXpzTdB0/t8a2fQrhMQg6q9EgDTDkr/dFBjGd2uFQ7et7iE4vXr/Cylck4?=
 =?us-ascii?Q?fnR0nrz1r3yy1hIy9qzbqLAqvNwdMMDjdlfalSf9lERNQ/+Lx5djtTiRR8rh?=
 =?us-ascii?Q?HsDybNinu6XY/lSHsGQ=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42b53a64-026a-480a-11a4-08ddf45567cc
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5757.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2025 12:43:00.9844
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JS1pkbfkkyjH+vyQuj9eiMlbzo7knWphYkn1+RNTWxsr2kKTKllQ2Qv0GgnxArOq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6688

On Mon, Sep 15, 2025 at 01:23:30PM +0100, Lorenzo Stoakes wrote:
> On Mon, Sep 15, 2025 at 09:11:12AM -0300, Jason Gunthorpe wrote:
> > On Wed, Sep 10, 2025 at 09:22:03PM +0100, Lorenzo Stoakes wrote:
> > > +static inline void mmap_action_remap(struct mmap_action *action,
> > > +		unsigned long addr, unsigned long pfn, unsigned long size,
> > > +		pgprot_t pgprot)
> > > +{
> > > +	action->type = MMAP_REMAP_PFN;
> > > +
> > > +	action->remap.addr = addr;
> > > +	action->remap.pfn = pfn;
> > > +	action->remap.size = size;
> > > +	action->remap.pgprot = pgprot;
> > > +}
> >
> > These helpers drivers are supposed to call really should have kdocs.
> >
> > Especially since 'addr' is sort of ambigous.
> 
> OK.
> 
> >
> > And I'm wondering why they don't take in the vm_area_desc? Eg shouldn't
> > we be strongly discouraging using anything other than
> > vma->vm_page_prot as the last argument?
> 
> I need to abstract desc from action so custom handlers can perform
> sub-actions. It's unfortunate but there we go.

Why? I don't see this as required

Just mark the functions as manipulating the action using the 'action'
in the fuction name.

> > I'd probably also have a small helper wrapper for the very common case
> > of whole vma:
> >
> > /* Fill the entire VMA with pfns starting at pfn. Caller must have
> >  * already checked desc has an appropriate size */
> > mmap_action_remap_full(struct vm_area_desc *desc, unsigned long pfn)
> 
> See above re: desc vs. action.

Yet, this is the API most places actually want.
 
> It'd be hard to know how to get the context right that'd need to be supplied to
> the callback.
> 
> In kcov's case it'd be kcov->area + an offset.

Just use pgoff
 
> So we'd need an offset parameter, the struct file *, whatever else to be
> passed.

Yes
 
> And then we'll find a driver where that doesn't work and we're screwed.

Bah, you keep saying that but we also may never even find one.

Jason

