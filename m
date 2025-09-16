Return-Path: <linux-fsdevel+bounces-61792-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ABFC9B59E1E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 18:47:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1FBEB460B96
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 16:47:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E89A13016FB;
	Tue, 16 Sep 2025 16:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="WthhqDh9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011007.outbound.protection.outlook.com [52.101.62.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE6722AE7F;
	Tue, 16 Sep 2025 16:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758041204; cv=fail; b=US2K33VMkeuZNqpdxFQlhRSCqLCUiWAoOA/NdmIdPq0O3hbRfUG3fL8Lftci8CDA3Zl08bjkmfwKZahoRQVs/8NnNGBEut2XCjAdeDqJXP8O5D20yU6fYrZKm0ClTMouZbSeQ3bdEbfnbMvzDlRymPvbHq7LewjLvmNyVoy5oAk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758041204; c=relaxed/simple;
	bh=YZiiWZoN9WtHWapkVEP/7efjaFsr8mDejrb8REC9PeE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=IvpK4pzj4VT7qkoEYbny1ETBJO2sg3AfPpqqNaDUHZ1R61HWrpTq1Os8EFUyPEmBjAklvRe+eRTYNqvYtnsRx+9/gxDxv8Q4+FqNltUMBL10B4qHirIaGr14WkFHytx2b+1TXY/skAZNB3WjgcDS46vTjpFKngQUWKq/Ewt2SwY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=WthhqDh9; arc=fail smtp.client-ip=52.101.62.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HlIw7WZt63CFHbMZGXBeMQdCkHNb+HI8H/puesywKRO+L8ocWThDUCckE2eWT6dCw8pTG3BDfXkZyvdbYmZHtCfun3+rYn75ZRGcSsXfRr0rIUWosWVRgCvsjSw48g1AdwwJ40FoTMMICUKJTfq6F0LAv7iIwjbCPwR+3DplwY273qex0WBkC/7NAkyQB8zA8tIQyIjmdObKr9r5HV35Hatg5tXJJpJ+/goDTG33edveSgoS9kPal4oTYHxqt85Ut1pnQ/+5qaIyegoQeQ3L+qcj04upHUkaWiL+2V6KWVICWYp3GieOzSliDiiLlTEs8ltwLjvD8UEJSgfq4pCG+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fD9pbvz5idVivI00y4IBedK5vLEhUrKfz9h0Xx+4ku4=;
 b=MuF8O00avmFQ+3gJnqLmfYJdcdXcU2XQHYhu3Es5MHc5iPO50Ed/GALUh59co5egkd9TV0v434c80Id9FUy7JFBbThDNcWNqE5EkFC+78MNrrs5Yrm5jods5YYfbr0yNBB8xTzMNvl1IeKrPY+Zj5HKI2/rl/UYIN1izQE2Ch71D6USJ5iTzqMVtyVjonsMisS9X2SBCf9nU54LDAaLHclQXi3jT1SGryJvOeuLZ4iBN8l+41xjJ5kxMOPf+xzB5gmIGhYXu6j8GBFb7L9CPjX7mIIH1tIvLR40DMeLn2zeyHKHaMgOZpo1pFsuyXplJLLfFNt+hGx85L7jg1Ub9LA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fD9pbvz5idVivI00y4IBedK5vLEhUrKfz9h0Xx+4ku4=;
 b=WthhqDh9tfW1CQugeVZTGrpvzjq7C5CT0omiV/jxCPnHp7uxskV+DX60jVD/vkP2IX/iiNL86tyfTI5+4hhTeCjwz6lbAkHxSfrQXGgP0YvNtQYZgRXeL/bdMXHj8VZSd2THHXnTMPS4aTyVlY68a+dkCSefgYw00+LYloP7MvCHSbtyHFq/3zYp2BplGukyz0WM2Ue2daV7MIWQ175Y20QPSoRQgihVXwpZHG3t7Afo/f1xkYxhH5aUCAOYrAe/7XDTev810WBrQb+nOwzZnnebBnRdEzSVzrjmDPQPlPE1YQSdU86BRvHx9S50xX2TI1UUIsXSs+dYIOpaUJK3Zw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH7PR12MB5757.namprd12.prod.outlook.com (2603:10b6:510:1d0::13)
 by CH3PR12MB8257.namprd12.prod.outlook.com (2603:10b6:610:121::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.18; Tue, 16 Sep
 2025 16:46:39 +0000
Received: from PH7PR12MB5757.namprd12.prod.outlook.com
 ([fe80::f012:300c:6bf4:7632]) by PH7PR12MB5757.namprd12.prod.outlook.com
 ([fe80::f012:300c:6bf4:7632%2]) with mapi id 15.20.9115.022; Tue, 16 Sep 2025
 16:46:39 +0000
Date: Tue, 16 Sep 2025 13:46:37 -0300
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
Subject: Re: [PATCH v3 03/13] mm: add vma_desc_size(), vma_desc_pages()
 helpers
Message-ID: <20250916164637.GL1086830@nvidia.com>
References: <cover.1758031792.git.lorenzo.stoakes@oracle.com>
 <011a41d86fce1141acb5cc9af2cea3f4e42b5e69.1758031792.git.lorenzo.stoakes@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <011a41d86fce1141acb5cc9af2cea3f4e42b5e69.1758031792.git.lorenzo.stoakes@oracle.com>
X-ClientProxiedBy: BN9PR03CA0291.namprd03.prod.outlook.com
 (2603:10b6:408:f5::26) To PH7PR12MB5757.namprd12.prod.outlook.com
 (2603:10b6:510:1d0::13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5757:EE_|CH3PR12MB8257:EE_
X-MS-Office365-Filtering-Correlation-Id: 05ee3b0a-c146-4ce1-7e82-08ddf5409b9c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|7416014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8U4K2L3LdZvOnLMw7JBvJvb9H5ue/hCOzaScbILF2thhIE3LVVseiK3Uuh7M?=
 =?us-ascii?Q?YEsvbWIHJ2xrVKY0S0e61InPuuJvawraafzC2dKoBi7LAxzp0T3YLK0Awh5+?=
 =?us-ascii?Q?KbhBCJJ4IEEFIqe+p6ZEqbzhSKUL/EYU1Z6+TtitBx3xGY0W9zdBlPLGA5wv?=
 =?us-ascii?Q?P1v+K9mW5dubdD6+rrKbQv2UKMDsx0BSyhO0h70ShCOtXloGQ8VeVELoNfB0?=
 =?us-ascii?Q?1BiAivGJqERm16pAYiIxe8kukQA1ljOSd1TNWdV0T3hq6Skd7XH52aeRbGWx?=
 =?us-ascii?Q?UjCHXLLfh/jZJuQbDLgbAC+0HodFCOw+vW34IF5HjG4T19WwJ4zu3l/DR4Wc?=
 =?us-ascii?Q?Mkl6rasAT+ZBPLVqHwYNwMUmnzynH/sNCe9s2Mb/uURXRTHiHCLV6qhJtJ8u?=
 =?us-ascii?Q?DQ2kA9Kcwp+Qv8Nz/lTUBDzUjy9NG541Sd27ob4IS8nbXtX8Z27U9MqMd6wt?=
 =?us-ascii?Q?jsacWeN+A4O0/Zv+v/6vFzfvwMkkEPKT52dymb0y/eUv0tQQm1x9eMAH1wZ3?=
 =?us-ascii?Q?UqwypNcy9Szw7epNleBnriGQI3OavReFNsq99lAJtIyJVuZSdCwyFtgVM2Zi?=
 =?us-ascii?Q?jthoffFiAxfhs9MZOFA9HXMajuCl+OdQPZFLAyRwO0wNh6KQchHIjIVeWWfo?=
 =?us-ascii?Q?E+qa94yunxUZzbPwDfAf8EnCJ4d4WsnogJ4jYT0tQcKl9QBkm4jV6WVRA8Gp?=
 =?us-ascii?Q?/wCnLhJdsTQEdU0ZYTghhQ5I974iBdFMY7j27R/WBKBYCJJtYEsArN8uyIrT?=
 =?us-ascii?Q?R2o+iJmbAYPQL4Ia+nbXRBcolOTlOgxLwRtEJtE48RucG5g4l+irtUTIdCTB?=
 =?us-ascii?Q?DA7azWzphBdUb8wIRk5/u4VJJRBaioW4ywoBwYv0w5emj+H0EpBxVt2/qjId?=
 =?us-ascii?Q?0pwEODHvD7+I3Y8TGEaM+viQfG3Cx2Y7YHCHdWbr3VQpVRQ+2vJY2tbb7SC+?=
 =?us-ascii?Q?HcqZjPT0RfWuyp+WdgGoTADdjr/ZRaLu/wLmETxG4UpmOEnqZL0qATNKk92a?=
 =?us-ascii?Q?1WPpNJS/AQEeR+maZFoMavrnrEwHq3ItW49rhaJa5XojSoIMH3xbGYwXGAI9?=
 =?us-ascii?Q?2GTO3ULeZJvE/Y5ORfj/msKANUIi+Wds8QXgG7bS3xeRGO7yE8MxbtgOWxGb?=
 =?us-ascii?Q?U83EW7ZODj1V3r1SGK0cfK+68U0GzxGs+8oNNKbtF0IgeHQUUgVKhAty0gqV?=
 =?us-ascii?Q?ec8UPNQbIVfBxXd2Kbtx9CBpGvDTzUHrC6gcPnMt8g7C+pHVcDGbF0ss4vzF?=
 =?us-ascii?Q?uD2ZeH2wdKIk31QniN9uZoGoXyxEG0frHHXF9Yodn3N865Itzw2pT/BgFZFz?=
 =?us-ascii?Q?tq2utIDn6kNZZGqZf7/jaigCbhQcn8Ck5ujAwXfXvYk0j6Q+Rcnqjtj6f4ZR?=
 =?us-ascii?Q?9lyesLcFgi9x+Xur1HQOiDEQ50AzVYGreA9HfBAutBrhSOkRWq1/gCkvZr7D?=
 =?us-ascii?Q?GuYJF4knzf4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5757.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?EMIPA/Q1hjehLU75UDvX2LwzPpgCsTyItNZV0LcS1+m5rvoy2TgDwWyoqukR?=
 =?us-ascii?Q?rRL5d+cHq64wR5ZFopetRZJSE1iyVMAwpqEKFund4w1H6csVWF2DZroreJD0?=
 =?us-ascii?Q?VhIi3s6dQ0WAtSx79hlUOq7nBs1mfSJwuLpgqzNScYbDdas3r7RHoI6py1yu?=
 =?us-ascii?Q?g1/bs26fLeBd5wUkVRp6Fs6iGdUlnTQxBOffR9K6fK8ps2IHZZx64uLLcARc?=
 =?us-ascii?Q?xehIEK3xm8xKZ4ev2FRnNN6FpAdSzQWkVS1CIcPT52JMQlmBwvdU32DkaA9m?=
 =?us-ascii?Q?BIBzJpQYA7TNAROrwuihzgBU57tklVkZIJngIny0P2/hyc1heI8Q2C8gx627?=
 =?us-ascii?Q?MTg1q4K5U0SUQoIKK8VK3TfpnndOu1NKbsFVsPPbIgoxIm5tnmyyIdR3VwmY?=
 =?us-ascii?Q?lBMRZnUMRPMl+rlniHkxZMB15mrS2w/65HfYDMC+oQPKujhVVxXBgHm+sdHA?=
 =?us-ascii?Q?wkNuJIiJ0y3q/NdQY09ZJ50Z+yDKineAzOjZ2WfpltL/sedPxAbdaYXKwePK?=
 =?us-ascii?Q?h6vH0D2pHKdm7ARKPiLRDi/HhmVMM9JgyDZFG5smLXeyu7hkfpyNSQ91vCr1?=
 =?us-ascii?Q?dR4lgDedwAfs3bdgprQjP3DfU5FsLeKgiI4QkRZWLXuXVoaEM9MZVSZypil2?=
 =?us-ascii?Q?cxT/sWa27Lp3FfE045LKOxM30qZ1f8KWXQ9U9ETT39MxNOTCcc/SwV4DjqPc?=
 =?us-ascii?Q?57flG7m8DeMXjlcpvhjjDPnj4VSl1Knr0IjGpVQlP985AlXnDuYaC+OZG1nL?=
 =?us-ascii?Q?sqx0WofSoJgeVScftrIMl5UI7IOvKzbYRPzIkxaxb7mg706AlvTf21eZy+25?=
 =?us-ascii?Q?Nlv2i+2RYWaCgQWV3++GydrlWY8zW53NwYSLjk6/xrp4tSvjpBJxXMixiXSv?=
 =?us-ascii?Q?CYWMXTXH040tqYCNV5IdgkF4rQx/in4lBzRR1e5QXiMqjrV7YuE09C5YgD1/?=
 =?us-ascii?Q?pOrC5rOq5zb+jtBHkmwGCM9GJR61bjUL0piIRWRjPIxNRtKWl1UpO2TiKKqe?=
 =?us-ascii?Q?RvGcC5eRE7YYjuyvtSbgb7UcG2/HAwCMs1/Y7smfE2iNUgXm7NKIvzODzuSX?=
 =?us-ascii?Q?432XwR5Q/uyj3z6qaiztFAOsd2RsziCMq95Ef42TgzpRe9q59qTYSkePtHVq?=
 =?us-ascii?Q?PTqNnua2dzUiRi2Y580TKJAP33XyvLEvQpuS+b4UAnHaCkm4mH8hzrT7p3qm?=
 =?us-ascii?Q?9imYMwTAwbEMiz4EZzb1WE+Axdosx8G29C41bhSR1zEHQZrN3waqh0FY56UQ?=
 =?us-ascii?Q?XXfIIX1A2ahMLmIALrd+hPFn1KDvX6lZWVEZ7SmbLi0H602FDjIGKBxkCuLB?=
 =?us-ascii?Q?ijz8G+zTvupIRcYvbIu5vJQyvG9uzkogm/pTS5RIvWAy7Fadx0JzWYRL41Gf?=
 =?us-ascii?Q?0RTLkmMvXSYI8+NpAlfMBRBZunWcRCB0u4NGVwmrC+1bNjzox71icrezDCIm?=
 =?us-ascii?Q?HnlzvOEEFqOdhTa+ol1dg3wuMZfBu4LP1IC1lMzZkItL69DmsfSo9/NMcKAt?=
 =?us-ascii?Q?zLIINhN/WgIg/GZv6WsWrXMqGa+pPWIlZ6jMzcjV0VRPTWcYh2xzp9WlF6Mo?=
 =?us-ascii?Q?FKEiU7Yp4vsEnbIn4C1qANL8WeKebS3wtrsAGGXL?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05ee3b0a-c146-4ce1-7e82-08ddf5409b9c
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5757.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2025 16:46:39.5819
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KYEwjTCmN5a537Xg/7/eea1z/fHEYq1OuBBBCM1K62t6N8FS1ndcy3+msldZ0Agt
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8257

On Tue, Sep 16, 2025 at 03:11:49PM +0100, Lorenzo Stoakes wrote:
> It's useful to be able to determine the size of a VMA descriptor range
> used on f_op->mmap_prepare, expressed both in bytes and pages, so add
> helpers for both and update code that could make use of it to do so.
> 
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> Reviewed-by: Jan Kara <jack@suse.cz>
> Acked-by: David Hildenbrand <david@redhat.com>
> ---
>  fs/ntfs3/file.c    |  2 +-
>  include/linux/mm.h | 10 ++++++++++
>  mm/secretmem.c     |  2 +-
>  3 files changed, 12 insertions(+), 2 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason

