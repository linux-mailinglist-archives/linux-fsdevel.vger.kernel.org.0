Return-Path: <linux-fsdevel+bounces-60529-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BEFC4B48FB8
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Sep 2025 15:35:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E27D1B26D31
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Sep 2025 13:36:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44B1630B530;
	Mon,  8 Sep 2025 13:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="YJjLy7lc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2055.outbound.protection.outlook.com [40.107.236.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14BD423026B;
	Mon,  8 Sep 2025 13:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757338544; cv=fail; b=WS2DEZd4jyw9bkhZKrG9FhGHyNNDagO9ExMj4UFBYKikeCoYubfQJt7z1mSAhvLkvTinv+flo2wCMfUzL7BqlEzbFmN1stefrhUAT08r7sPBt01E+1BcDIdFCrUIniS4zhxCfKhVq6pNfPBN2KG8SyJ/RTaIqYoCCXF/7ftTn4Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757338544; c=relaxed/simple;
	bh=4kKs0ULVrmsp0q9pUjSjwYRoJS6dVCpdN8WM8V3+MSg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=B1865Fkbjzu5D2nVtbLhADTfJAXiG2l+HyvUjfNUneAcGoYfcY1UU1VkQGNdbSFJPkMsSDlAXZrVJ5FM0Ir/XTQLI2kDIVSBLOXl2R6taETP9hzYtL8n8Tb4wuFWYK8Yi1+IEQvsSF3tCk5NJl54uFN7Yzni7RGtaymezJtRNXM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=YJjLy7lc; arc=fail smtp.client-ip=40.107.236.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Fm/QNG5CWPQm0vheGQPQ43eTSlWS5GAI/KK9xDOZ5eVgVk0Iu04rmGMrVyGhdiq6FjAjXPmz0zlJyl/jPbPOaKqIbjN+P+AedYQJKzDI21XGkXUNSfS/9CtPWNcuY+DnUS2F1RCaPwbiOGyvGw56Z+4hfYaPxj1hpt25cv/66QOIlVngsyF3iPduuOsCmxKlXCNGeKaXAEAOAuyG/L+CkKYjuxdMuxEWsIhX73Aibg7QqmwQJEWY9d92w++TzWTe/6TrvrdoknTQOrwl9Td9+L6qy4oMxHvPP2//vQSXw7HpWTV/qJKuszav31BPGPNC334UPsQFNHKcI2LMpNkpCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4kKs0ULVrmsp0q9pUjSjwYRoJS6dVCpdN8WM8V3+MSg=;
 b=DxeKHxWI4eQHO3LKQO4CR9zpe0f2MnrLLN98sNl6qZ5+3dEV4CMpp/1C9acYBQttZ/JHdoqFLROLE5eaOD9tLXGcRNQr4D35HgdBZGFrn8sIAgtUThZjJSypsYpwERBqL/Fx4FYM1djlRB4vDhaBk+z+VF8ful+Sdl3ewqLKyJQbjYNFmV+96/zTS6KG60RuzvL4ovJByOy1ReMGb8cYNVMUieLcw7JL/Il1xtbUC/SomgrgBqGOaZjyouvlN9sVGXfCqOqyAvrgkj3+Z520AgomKdmHUjupHi+92bqKVibO45Z01unxya6tS2UxRSAldz4rYKeZEN7RnvIAbHZMSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4kKs0ULVrmsp0q9pUjSjwYRoJS6dVCpdN8WM8V3+MSg=;
 b=YJjLy7lc9LUmqfH+mFtFoVf4bnkGJ1AIrD0ukz5Ins89E3/y9ryTE2rrTSX1m0Ye+tPjj0j/mwhyuPPTUOkDOo62Dm6Q1ORBX43YApn5NjAPpMyDfMAMawCR6Ra65GOfJ4qpZnS5+EuJGoNEnpACGUdURCsArInoQ6DMCC7w3hG6fCxBIFvrOkH7ZCmy88etGqL3B1xB9p3ZUMT7t0TNtYQH85ryOigRCN3su+0PP9QNn8xj81gcCdK/5PhtdnXmBm9BtQRUI789BkQYl8q1ASi8TyIKj1KQFtqDlD4vGt9ql3D3APDeCShaeH/ZTCdwmnwmtboJBwgdPbM2c5W7pQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH7PR12MB5757.namprd12.prod.outlook.com (2603:10b6:510:1d0::13)
 by CH1PPFC8B3B7859.namprd12.prod.outlook.com (2603:10b6:61f:fc00::622) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.30; Mon, 8 Sep
 2025 13:35:40 +0000
Received: from PH7PR12MB5757.namprd12.prod.outlook.com
 ([fe80::f012:300c:6bf4:7632]) by PH7PR12MB5757.namprd12.prod.outlook.com
 ([fe80::f012:300c:6bf4:7632%2]) with mapi id 15.20.9094.017; Mon, 8 Sep 2025
 13:35:39 +0000
Date: Mon, 8 Sep 2025 10:35:38 -0300
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
Message-ID: <20250908133538.GF616306@nvidia.com>
References: <cover.1757329751.git.lorenzo.stoakes@oracle.com>
 <895d7744c693aa8744fd08e0098d16332dfb359c.1757329751.git.lorenzo.stoakes@oracle.com>
 <20250908130015.GZ616306@nvidia.com>
 <f819a3b8-7040-44fd-b1ae-f273d702eb5b@lucifer.local>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f819a3b8-7040-44fd-b1ae-f273d702eb5b@lucifer.local>
X-ClientProxiedBy: YT4PR01CA0235.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:eb::23) To PH7PR12MB5757.namprd12.prod.outlook.com
 (2603:10b6:510:1d0::13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5757:EE_|CH1PPFC8B3B7859:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b1abce0-3b27-4a91-4505-08ddeedc99ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?q5Sc4kxW2Htk7RIituyQkliTWEMFyz0aoHo7O5B93rDmRzoomgRYwui9DXX6?=
 =?us-ascii?Q?GAK5kpXqzhClfYVzGYGgsAwW7c1BFkvzCJCchI1XGWuwWwdBvzawEUmhcEmV?=
 =?us-ascii?Q?+CzfQ4wCJhM/69WPS5Bq2BbNvsrNMHUhrCgp4ouuEEewl08EDVuYsaPLVxPw?=
 =?us-ascii?Q?Rm8mc6eitT28ULRMQ+mYafg0CamBYszp5+qaCOWwkovBLEqnddi/fI8QAKM0?=
 =?us-ascii?Q?VfrJuYLl2bIR9ZrsxrUa6mvjVJ1PhM9Borsyb/0Q0kRthnLWjjt2zn5J5EVc?=
 =?us-ascii?Q?yvecmnkeaeRNXX8kIiJCugijr9+pmPZKcBkrpdzsGC3nekD5uWm+kJoEPFMI?=
 =?us-ascii?Q?f8De5swF0Iz3MlYyuPBy0r1ZzBtm6EgpRVfTn99wcvflf3RNtPq89w5gZ4EB?=
 =?us-ascii?Q?lmB1y4bpq5htTDCjxHCskxpFwcwkiYFEpp9eCCuSKMHGBCIgh1Mzu7/JnWNp?=
 =?us-ascii?Q?qwGJprSn+rS12xUZMZAcy28KlUhLJJlkq8jSL+hrPTgEy8yaZ8ysfLa3wqye?=
 =?us-ascii?Q?7NVyOV/7zQAavetS8eDJerD9zMU0yE5XWsOSEoop8MIrAaAsRMVpgIagA+bZ?=
 =?us-ascii?Q?Orqv1uWqLwGR7QR+HOSoNXp/GeZ0YknOvVOg6dV27cjEtNlUu+kyPnDA2EEy?=
 =?us-ascii?Q?Cas+rIVSflT5pKXoqzxCGMoaQpmGldKw4i6qZEfqcSBzIF/F50pJ7G/IWv1z?=
 =?us-ascii?Q?Hlleid9xZ7475EJOdGbNfS+H6rPcRYvzdXgzx1usZ5hYnvaqhoZdlriwlBKG?=
 =?us-ascii?Q?DfTUnR1j1vhx0HBcOG+hgf2aOTdHp23NM9EjIh4n4Ixbn21TBjcEwT6jWAsh?=
 =?us-ascii?Q?nlBC0cwmoh8suWxojiMywSC/jHredzMw3y5I2eb5LDokeaESr9ABapujz8v+?=
 =?us-ascii?Q?Bp5gIFf0+gKb/sLGAK+9iTwHnnuf6klwCrHnbSF5kIjceYpnZdUPl+ljpeWh?=
 =?us-ascii?Q?t+3mskVkq06wqXjyhi1PHdbF88mklwZOzcE9c8wyFbzvh6QZZ+K0w1KvapRc?=
 =?us-ascii?Q?M44UJqOZMDrH+DXoEMwHrllZTvN7Op5SHFeR9or0FgGtUu2og6F0ci4Zkd7n?=
 =?us-ascii?Q?WEkrGlaCxdgVFu5/jaGj66ouq9MQMh/KN2FyMvZuLQwT7sOP6NVv1Mk/QH1g?=
 =?us-ascii?Q?yVBw498spv30urE6zaduZOnWUDt68yHPMjTMl9m0yqJ8oWFHcAg541cKSa1O?=
 =?us-ascii?Q?nCE5tZFA8oLyxTEZ4dufj9GMwRZX3tcvlvlFW8HxEsOE2eOU06/2ThPXo8T0?=
 =?us-ascii?Q?uxcOtIlO+lWmoE64HtUdOtqFr/BXOu84LkXOILusVHSU5lPPULIOjxUH8abi?=
 =?us-ascii?Q?dwUXVPqKZEqBskzCnMExyRTgkcsIVJs3qX003Nb3cYMC8DzjCy96j4cVom7/?=
 =?us-ascii?Q?In+C5cZOI7252KlG0R5zfBF4WVjWZtR0/OfHvss+zLY/QcAtTA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5757.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?XoSFbBmQ/CennDI8oGI0MESDwwJX8yEwaHfHkpFzoNPSkfzfCDLpJgtLTrI0?=
 =?us-ascii?Q?SUpq83zu7SxOXaU+/wiNK014JpLYDaKvfTdbUYX2Ye+0+ytFyeT67llbsWJ/?=
 =?us-ascii?Q?bU8WHlxGrTd/eQ1LSF1LZiNzUB9wIluTBs33OCAJyp8rgDBnHxg3vo/8jIoC?=
 =?us-ascii?Q?6J0AL32mUTblgy5BaelXuS1eaWbaIW5MG4YiVEadeqrVevgfByWLS1hsKqDz?=
 =?us-ascii?Q?5J4oUYF7LTBAANzNZDBxoU+L/64ddHSo3bKBvnNwoT+/hvW58W4XYU0vbVi6?=
 =?us-ascii?Q?LznekYaA4157apt1Z4sBrC5AjXojFR/K5SWsGpL5n7EG/duNHMRS9z8IJLH0?=
 =?us-ascii?Q?yb9MNom4HdZs23t8nEhLy4zTV5hSUv/ezS+vu8bNKBPmuqHPhKajLbdu+NYL?=
 =?us-ascii?Q?XFNq6FCYdzZfHBViB9h32hMZl5Za7PJ6Ux0nI6ngfUuQ4HH3KoauI0KDqh3h?=
 =?us-ascii?Q?bRWZQYh9k5xhnh4ncGaCeXerBnmE3GLaHsGT3t2cGI5y3TPsl19PNs9fwXtw?=
 =?us-ascii?Q?MGW9mz8KEoWpj3dA3YTTM7R/jvXow20E7MogxHij7kjL477kylqJYn1frt1y?=
 =?us-ascii?Q?jRVV5HdchogiipTpKEU1xKHxpsXdrvZ5WC6ZRqAEiFqaVDTg+d75efEq03A4?=
 =?us-ascii?Q?HUel/xTJN9UdPUitqyJcnupLu/Nvo90cF/stAC2Ixm9AwTeUnf3/rPiFmmpL?=
 =?us-ascii?Q?hUnb9kYvxOVslrUT0boTzxcvvih1yEvm5hUmFUbSbLOAvct0jHiGlwwsqTEd?=
 =?us-ascii?Q?zIR4k2JA+OibLbooYWuMDWyEUf6NswxR5eTne2gExobaEm1e9Zcxo8OSAaxV?=
 =?us-ascii?Q?tvUQXZ9+1+YVzftXOs/Pnh9boONC5y14i0wDVWzs1IW5a72z0A5ribvDwb5M?=
 =?us-ascii?Q?0G9TijqNGBjsZtCj+Flzcs3zVqIWlLagQ0wfbjjsWbRemHOgmkA9w+v/rw1S?=
 =?us-ascii?Q?BbzaEvA1/bfTpNoU+qXVu/oHkeEtzEyyXCyF+HXqmprCux+RuyAqjxTuSqxc?=
 =?us-ascii?Q?o603eA8jGFqDyMB4wMyzWmv2C5rstnentmJVWEhSAok4EWFMi5ZpvTAgoj8t?=
 =?us-ascii?Q?jLHaKXPkCmAnsoeyBUPfBx53Og5Fg4YchUI8iq9sZ5li5m0VhOrizP/6tTgy?=
 =?us-ascii?Q?oxhmRGajUcPCEaYJELT2L4FwzSq6SGoz6LudOOJVGFSWxepbuHKzZsFu6xmp?=
 =?us-ascii?Q?knvYA+tHJAGMSgKQNucWWyd/d9PPWNYbQviMILNzikJMrVc1Hvk4Snw7U3Aw?=
 =?us-ascii?Q?ZdsZwb5zTE95ogb4FQNlwtzsVbaetS68NbFJYi/JhoefmlgoYz8YiQ8EkM+1?=
 =?us-ascii?Q?xmOEFMnQYxM29LdRSbwq5aOGgQPQAbDvp4hhGnEmivNdfHhcZS+8IR9ANwuo?=
 =?us-ascii?Q?ww3UcqjR8PM78X5AaI1/IlvnIBz4+N8rFSC7rv6NCIwxY9VOFNFQgynE55ib?=
 =?us-ascii?Q?0UqYtT44c8jXInkvlUFLzHNZN9RWAYdncMIZ+kF9saqBrTZnIk2gEQzxHdlQ?=
 =?us-ascii?Q?eSl4eCwkfjyYgGZ0BUM4yVr+VLO8/eoSnIGiXTku+Ym/nYJI3u3pdAvF9dr8?=
 =?us-ascii?Q?HP/e7HFEWsuUurH1XDM=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b1abce0-3b27-4a91-4505-08ddeedc99ad
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5757.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2025 13:35:39.6548
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ywhab8dI4tMuB18SbSNhlK0aNKx8mOn9NqG+l3MsmIb9xJnhpEG9w9k3jzdq7/6h
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPFC8B3B7859

On Mon, Sep 08, 2025 at 02:27:12PM +0100, Lorenzo Stoakes wrote:

> It's not only remap that is a concern here, people do all kinds of weird
> and wonderful things in .mmap(), sometimes in combination with remap.

So it should really not be split this way, complete is a badly name
prepopulate and it should only fill the PTEs, which shouldn't need
more locking.

The only example in this series didn't actually need to hold the lock.

Jason

