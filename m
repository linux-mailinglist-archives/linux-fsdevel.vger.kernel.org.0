Return-Path: <linux-fsdevel+bounces-52599-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CDA95AE46CC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jun 2025 16:32:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7284518978B4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jun 2025 14:32:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F04FB25BF19;
	Mon, 23 Jun 2025 14:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="XZKE7e8c"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2064.outbound.protection.outlook.com [40.107.223.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5A6E25B683;
	Mon, 23 Jun 2025 14:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750689135; cv=fail; b=CkVgHsYMvUEGGqRNi0Qz+Ue/2SH5conWUUaMtgdBNh7NYE5xzDmg/nr5kTy9nOyD/DTsjT8wbXkWKLrZvLjmBVw+mX0hOUdGtlXmrBJ6wjfUqKakzwk5xE/g/UcjOH3me1UoMk/RWu9XvzLucHSoUSTKyWwY9FNpuCKfLE9yOS8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750689135; c=relaxed/simple;
	bh=VsSiPA/raQy5c5IEXjmbA0OwkGpoQx5lUyNXm+nhpZQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DHI9zugP6w01cM7+xOuEbbMrDzUqzjBqoTygXHKu5CR9l6rJb1t/sRW2qrjUniN0Ln/dlDFN8bwiwddkix7OSxjyYK7t/oxrxRzxijqhpGk8BKIymJlU7xpX33I4VwmCz5wKQcXiWIY5M9OLiWeORmIrvJUr6iFAnb4NUYV9+Ms=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=XZKE7e8c; arc=fail smtp.client-ip=40.107.223.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RpIpnKVBJtIqOxH/92teQXr73Ggh2K/pDNTqWuKtKztSH/kEiiSJROyB8owhYOG8qeghmxWZNR2729CFQJmwDKiM1VDCDfitL9sWTjenKFZkl50CQhjpWsghM8oHqSvkDVD1fgosCOeBSio0BgF7jF8MRbnE/fMQshNsQs5n0IrTS9IV9Tj9497gP4ebWXAKBACLrdFruWDcViqp2oKwHF/l2bgICJqMT4enlFhFE3D8nB8QdLzX5v5uFobmjLUTMCsZ+KicydIoABXtSK0U67lFdGMOXSw9nFY9X9KajxSLwQJ9MqGkkxnCJxtLhdihKa3K2h8PFmzF+Uneyg1RKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BjyU/ZaizK64asL0ZmLM5/yk9SbQFMk0GO8yQdrYE0c=;
 b=xIy2LUDq22fzJTNJqkS78CRXsleL9CucAn8xk9f6t7NzeS3qcwnIAI3GBSm4obq1eQGJVtJV5/queUsNsi/UHJY4d2omu5ikX3wsyU4YYABjXJzmOz2Bc0IB9VRJKQSeJM72yi4+lOTBF9sWStVB4k5jKGQQCVf+qqjYF04UK7ZVeRrmFrsTfbvKCL0rHAZKZVudeG7Ie3/0ASnUz19dQjkPbCNbFOrzwEPO4m4E4hMfOOAajSD4//f86sRpZEqWXCPjT69rND3mZBRy+icnej5LiAepyX+e/o5qbVCswmkRl6c7eRBoz5rrc1mz1FwFy+8X485bsHY16Z27isBj3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BjyU/ZaizK64asL0ZmLM5/yk9SbQFMk0GO8yQdrYE0c=;
 b=XZKE7e8cIUJiRRDgW/KvMfnFRgOUkcVIXsw8gysMAjYq19zNd/vYABESMqryiMZf1OMZes29Bf5ueSJeQDVan9dskYL6VVn+cV91K8pgqlXLxC5Q5xzG0FxMsddJpaDNUa4RGgT0DshXtDymO8g3rEURaGmmhhG05DXJEmTrV9o56K62WgWeicunWOYkaq4Xh34Qk+qnovqsnk9lUrUza/ZP76rkw04sVpifd0kywW4dVVB5p7KnO8wpLPOHn8Og2XssHczSmyg59iNZ4qLhiOhqYaSTxHwMpWIAj6+p5fN2uA74Ab8hH4cQYt5IkChjmcQqW8atgkKnmm5FDuCgfg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 IA0PR12MB7750.namprd12.prod.outlook.com (2603:10b6:208:431::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.28; Mon, 23 Jun
 2025 14:32:09 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%5]) with mapi id 15.20.8835.037; Mon, 23 Jun 2025
 14:32:09 +0000
From: Zi Yan <ziy@nvidia.com>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Russell King <linux@armlinux.org.uk>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 "David S . Miller" <davem@davemloft.net>,
 Andreas Larsson <andreas@gaisler.com>, Jarkko Sakkinen <jarkko@kernel.org>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, "H . Peter Anvin" <hpa@zytor.com>,
 Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 Kees Cook <kees@kernel.org>, Peter Xu <peterx@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>, Nico Pache <npache@redhat.com>,
 Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>,
 Barry Song <baohua@kernel.org>, Xu Xin <xu.xin16@zte.com.cn>,
 Chengming Zhou <chengming.zhou@linux.dev>, Hugh Dickins <hughd@google.com>,
 Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 Rik van Riel <riel@surriel.com>, Harry Yoo <harry.yoo@oracle.com>,
 Dan Williams <dan.j.williams@intel.com>,
 Matthew Wilcox <willy@infradead.org>, Steven Rostedt <rostedt@goodmis.org>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Jason Gunthorpe <jgg@ziepe.ca>, John Hubbard <jhubbard@nvidia.com>,
 Muchun Song <muchun.song@linux.dev>, Oscar Salvador <osalvador@suse.de>,
 Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>,
 Johannes Weiner <hannes@cmpxchg.org>, Qi Zheng <zhengqi.arch@bytedance.com>,
 Shakeel Butt <shakeel.butt@linux.dev>, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 kvm@vger.kernel.org, sparclinux@vger.kernel.org, linux-sgx@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, nvdimm@lists.linux.dev,
 linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] mm: change vm_get_page_prot() to accept vm_flags_t
 argument
Date: Mon, 23 Jun 2025 10:32:03 -0400
X-Mailer: MailMate (2.0r6265)
Message-ID: <77B692A8-9DD7-4B92-9C05-2DAD376F6DF3@nvidia.com>
In-Reply-To: <a12769720a2743f235643b158c4f4f0a9911daf0.1750274467.git.lorenzo.stoakes@oracle.com>
References: <cover.1750274467.git.lorenzo.stoakes@oracle.com>
 <a12769720a2743f235643b158c4f4f0a9911daf0.1750274467.git.lorenzo.stoakes@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: BN0PR04CA0192.namprd04.prod.outlook.com
 (2603:10b6:408:e9::17) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|IA0PR12MB7750:EE_
X-MS-Office365-Filtering-Correlation-Id: 77f15123-be7a-4a33-33bc-08ddb262bbf4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?JapljedbLFZQh8Y6o2CHYR/jK/OK2n/yTiXb8L6m3ka4zeyfBjtn32sRdr5D?=
 =?us-ascii?Q?mmPF7WR88ST3MNddchOZ94a0cYUEwg9JeKxKcGbXrQ/vquMSYHsE1/4TVfmy?=
 =?us-ascii?Q?8yGxbdNsxBIcfEQlg9IrRtOsInR7SQOOaDRWlD0xpeiBpdftoaoMhNdHpVRY?=
 =?us-ascii?Q?DuS5yi23J8uS0v8nf4kblglFqoq4cHk2KNn/tQHe4x4CTd5DnFqpU6UB3a0A?=
 =?us-ascii?Q?OvkP+iHMXF9qAkKtRgs2veghTd8ixWONi3WXtBeGTYsFX4qmpl/Ii6EHSoIH?=
 =?us-ascii?Q?XgR2CuVPhr4hvY3s7NAZdx1zLyd1hyoz/Eo/qLdxx0O83XePpDlXm0xhUsFo?=
 =?us-ascii?Q?R5OoB6dKIwZhvl7ex78dQr/JxLfRLSTcSwHZBUxYK2gOVo7mvwojjUuRRcWA?=
 =?us-ascii?Q?rx52rQPmYyyFONX6MMdVZzMe2VGhKMVX8AxGJOcehyVQccoQVnv5l0tcUD5w?=
 =?us-ascii?Q?pboQ2d5jLVSBsfZbxoUMOcqm5ggzZ+wmNyjICGHHYiE7+pDzsEmcAX97vsnK?=
 =?us-ascii?Q?6DuxoiC5iqTroU7EpxV4yxEjIs0Fp6KFE0P+iVXVDYMdtjF6menFOwTaO5xi?=
 =?us-ascii?Q?sM+vsbtVkr20suaaQoAnolBbCR7zkk5/AAPbvFAosto1o/nhdwPHjx3NC80O?=
 =?us-ascii?Q?L9kgkQ+KRScy2UcfmWnhS0CwI6ztCHWcqN1Ec3736juHrEXeeHUeJAJt/IAT?=
 =?us-ascii?Q?FZ8WFiEe0ZE7s+Z+As5XHFRobN7iFzfnSoEG+GNG1N4xoNt30HxjHZ4jGQ63?=
 =?us-ascii?Q?ivLKx0RPigbdKmqSnah35pfTpDA9/+4jq5/2jubiMLQSazIx7f8OcCkHSXIS?=
 =?us-ascii?Q?gsYxM8m1VQLccercRLi5H33qBpfqYgE+GclmxuTQdYSBMFRUoBDlj37QUBKG?=
 =?us-ascii?Q?s1yxjeJO8/d7uaByBWkMzyioRycXxYc5vPJC4coT+SdVmmf30UTqPki1Ev7/?=
 =?us-ascii?Q?zFg1rFdAKVjGVUer7NfMlcC7RiadOMrH/9aEXdRHR6nppQRZvitSOy5fYtpW?=
 =?us-ascii?Q?d8ceuRjJChbC1I18eJ9m2UugBZDCX32sD+rcw01Cg0fhroZ7TXjcO0Z4Wfke?=
 =?us-ascii?Q?hGcL3frr6PKl7sWy5bskObWgU1Oylk1VQaD7Q5y5vmuNcD8+cFEG6MJbY59W?=
 =?us-ascii?Q?ASZFKGQfTxKNb3aT/4WVp/kvmvfGUdFHYXeameqOqv4JDoED03mHaa1FNhcO?=
 =?us-ascii?Q?2uXtWThtfY12kdjZk55+c12adVVldS513laJPAR3uiJ6cmWLll14vmEP0OMs?=
 =?us-ascii?Q?6WNCVipRn4x78ppWFSsRbJHMuHwLvG2ANt3F2l5StaDXG6GTlgQnGn0bclvS?=
 =?us-ascii?Q?5LuV57TmQ3XdCDxaeZb8BpW6LT80HZyOSEnL3Pgoa2ua+a+CEsSiPvSnSqn9?=
 =?us-ascii?Q?knqFJ3CyIL4Kx1UiUJJh8Mk45AHrwUkAlQwhJNDIuNH3oP8hnyhgTdj654Mh?=
 =?us-ascii?Q?Sr+z+izX5oc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?g+ma/Q7BWrRquxJmxdY6BcD/K1wfrXIL0f1Vg8LuG1eel+d+OdS5rpc0XI6p?=
 =?us-ascii?Q?SqF+Sy/0v+FKSi6sxiErbQKQIMPwfyy21KLJtRhYMWpEVlO6QQSh6qgKcJyB?=
 =?us-ascii?Q?U+zPEQOXEx246WvuUU82KH1w8X1jMmq01WQh1h+NQUVYWDjPFvOcAGhn0ye2?=
 =?us-ascii?Q?1Y6OT59pRLvc243ALwxGlPQK4l2agKbTsGMls8PQ1bK/EwRAbMkVDirUPe1D?=
 =?us-ascii?Q?UmstGKVkNNvQja+jgkxzw/9sG+XEik1TxDASzXzSAvKUKphyhm4NLwoSngjw?=
 =?us-ascii?Q?gmeFO1Fa7ZvkbDEMPyDl70rker2Wxz2cCKZW8/JTEwrehc/tMYrHO+ABGS2/?=
 =?us-ascii?Q?Hq60UOrJ5OYOPiMuCkT+WGen1+z5Z4k4loX/uSAu1hv4wstu6CJi1MAWP6xA?=
 =?us-ascii?Q?FDDdF5nEsxeOroRMd38BrWNoN2z5MIJScM0skCutY/9DtgGLDyE3XXF1O61M?=
 =?us-ascii?Q?GCgLNUHthSQE+COw0ipm+HBpQfBDfCLCreOwgKdAf/oZSExP8CWwv/8HWItf?=
 =?us-ascii?Q?iNccZl9VvbgWb0Mlqxxg82zSnziMcOEKRma4+U2CsjfNiqMJajr4uXqGZ+PG?=
 =?us-ascii?Q?v474xrl8cTfWnjajp1IdQ/pAUbCqK+qkYS14hjhaTwpJ+sIscEQhat9FWad3?=
 =?us-ascii?Q?+8ZiXKAiCoA/WdA8vmeoE1ncQ7OZVFrCGS+IEl6fr7j7v4pGlcQjNlEYTyAj?=
 =?us-ascii?Q?X+trzGyqoX3yChv3oNPvklRjMU6CFLCu8bOy2kONqPBwo0pis5SzRFK0j3gA?=
 =?us-ascii?Q?CPE/M4is6+CNBuhinqH6YU9CjhEIApfOOTihGPmv8oECsEmyahiku9JZadQR?=
 =?us-ascii?Q?CgUmCHI5ZqIfy7Mi1UEQ3gb5J87KcPit44HsaCZZVJmvJ4IZ++pRd5mhvfAV?=
 =?us-ascii?Q?A0h2UsYd0aV4Rirkcfa3Z3CZEvTrQ6uQZoNjSvRDsxutJ+R+Qwb0Zf/QsSEF?=
 =?us-ascii?Q?PtFBwF3WjtO4hcRbQB8URyo6BdbZTjEuRdn4wDwSRBtWlJzlMIq688Z4ItX3?=
 =?us-ascii?Q?nOezPMJ3KkfMwpDgfLNXjughgNgdNTrdF8I3nKxiMei3ZblDNyF/3bUSllMq?=
 =?us-ascii?Q?Y3gA8B7f/gaozsSuRAZbiy3wfHQsxiDAEgDJp2WJIBPXPxtIino4i/20NjWR?=
 =?us-ascii?Q?uzu9qUkkrnycL4B7SDrc9rj9EvzQQX0n34YQZAgyk50XFT7kUCzzfWKIYgjU?=
 =?us-ascii?Q?rzCsuro/SDpjsoLlW/aYBg0x586s4szkgjnpntLWMeBPeMydRrhLabEQ2VZ2?=
 =?us-ascii?Q?+hWea6oMAj9Xa2a9jGpOM08GgftcWnT+BbstOH6UA65rzlc4gac4Ez4zD+Zc?=
 =?us-ascii?Q?5V7YbU9P+jkoW54nNlY8eSkhqVbMUfIco1+mMe+d5ZwHKy4run6JEeUAuepa?=
 =?us-ascii?Q?F3GV/xDoxULhmGwHkodAsfeM9fDXpvKKH87AtibQO8nkfdWPwKAIwHTqRFMA?=
 =?us-ascii?Q?eDKlvwX5ojXJtln4Im8vYx3f7q2YQ71ZlZZ6AqdWoJ041YPs+z1uGapD+o9J?=
 =?us-ascii?Q?KhgE72uRlvP1QYjC6SzP+yWdFHeRxfjLYStbJ50oISmPwfaCJhkuKfNjL1Sz?=
 =?us-ascii?Q?iHOqgB+OHp4VkcmW13899+mVD6UImnF0dKmE6aIc?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77f15123-be7a-4a33-33bc-08ddb262bbf4
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2025 14:32:08.8839
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ejq6rCChwlIC5t+YhdgctNAl6Kvw6rHJEWBydhIBoHEa25uyvoa5rtkRpp+qwNb+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7750

On 18 Jun 2025, at 15:42, Lorenzo Stoakes wrote:

> We abstract the type of the VMA flags to vm_flags_t, however in may places
> it is simply assumed this is unsigned long, which is simply incorrect.
>
> At the moment this is simply an incongruity, however in future we plan to
> change this type and therefore this change is a critical requirement for
> doing so.
>
> Overall, this patch does not introduce any functional change.
>
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> ---
>  arch/arm64/mm/mmap.c                       | 2 +-
>  arch/powerpc/include/asm/book3s/64/pkeys.h | 3 ++-
>  arch/sparc/mm/init_64.c                    | 2 +-
>  arch/x86/mm/pgprot.c                       | 2 +-
>  include/linux/mm.h                         | 4 ++--
>  include/linux/pgtable.h                    | 2 +-
>  tools/testing/vma/vma_internal.h           | 2 +-
>  7 files changed, 9 insertions(+), 8 deletions(-)
>
Acked-by: Zi Yan <ziy@nvidia.com>
--
Best Regards,
Yan, Zi

