Return-Path: <linux-fsdevel+bounces-68006-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 58D44C50612
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Nov 2025 03:59:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B8A424E3FA7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Nov 2025 02:58:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE5352C159A;
	Wed, 12 Nov 2025 02:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="U7VZ1F7S"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010040.outbound.protection.outlook.com [52.101.85.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AFF2242D7C;
	Wed, 12 Nov 2025 02:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762916326; cv=fail; b=kkfC6A4m/zEfJE6FHiiSzSgbIK23xKKvsMDC8NOPqut8fIV5iTaTytdVznr2ha5bcgtOdn8gckBCXfa2UEJsvcZRehuLktgnwq44EJpreGe31Z/CfWe/EqjlZXkJfj2GY7F4D0VlvizElsVkYdcGd/93fGiiTy2Rervvv5ynXuE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762916326; c=relaxed/simple;
	bh=nwimU4Zp7AoP4CBsoaBv5Qe9mnvXVZk0JvMIkiKsEOM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HOzlffUgVxfVCRF3w3g8ZMJyokRqSA3HZKgFLTJvd2uFEIgNcZIkZSK1KZUpyUYc2kN7PiDzp7dpUd3jhEarTtzU6uD93H4mb22aqgNq33pUKMNE0bxCF3fjuUGQ2dvmSY59I19CEyojaUgRtOE+FYbbTC32iQbUFo/p+aBSyvQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=U7VZ1F7S; arc=fail smtp.client-ip=52.101.85.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rqr8VF28ML9PFRYA/t46MWdVj7dXMeEJpe3H22tiMEKvfEUYDhUpanUSkG6G5cohyUlnYMJqhLQY8F7XNiBo5CEhRjodnT317eZ3LnWGBrwcgMhszSh8GwDlfQCeWGDqyLwXFY2mQmgg8PYgEj+89bts6G2gJNq2/Zcb5tlOXy00SkwxD+YGCx9cJNXq6dQJMw95Tw20hniQLk5v1aWvhYxsrAz7lj6jVRI5dvC2tootwkjyZptupmoCToPlgm3lcaGgmKT4oHqqxQqNHxDPuOMcqq4Uz4N0Gz4sqHRnUFTuNIZ64oPLhWp8gidiWvEH5w0r5MljPjjcdyCHqVDurw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eX52ichgjC044UKTP0yfsUJ91M7raRwWvWEbTKyzhSU=;
 b=bfpNADeneyo3oc91tGt1eGyKp+lGc/akbAmBUbHtnUhf8zhTag8Bd9Awe/xidvl04XRY08C/DrdQMYoOINlut9OiJg3jXCqyf9lPHR+49LzjwqQEhJvqYHMpBsNLdlnADJ8A89XUgTGCWUTVeoyDXeEIePMY6blT0Ifs212U7hISaU+zPSEcniYzzOABueYA42Tkko3PdwyRj17Y0SqXcx6OMx53CG+MNUbHxQTceRRprRiRROpjklZ9G+r4OK1T+njlp6+WDE/Nx2JeQIHf4DAswxg7ntyyiZEqkk6FtNtdt9X+YW9SM9qHsb+HI/KSt0yZ4m/X6dMDICavEtYgmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eX52ichgjC044UKTP0yfsUJ91M7raRwWvWEbTKyzhSU=;
 b=U7VZ1F7Sx68CpaOzVucgCeArbitRNjy5UR0Uc78stGxt4leGR2o0VbOoY7YFvt84ZmylHuEPA86qusci8HVmq0Ngp4dcrTdNouVp2L6C/r/1nL17gAGdFLAbrCktLjnwjG+4jiezsht1drnzrPIt2InCdTjs8kwCWaBo1whxx3S3NUSFss0gFyEpJXYALVnMxT0blyDoqOVpTtuRA2v90shz2aQepv0MqhR8Mokc5XnJ5MGCzUtaCJ19Ck96aGXf9kpy8xB7RvAq+lQpmHylyc3H1d5TcV9RhV16ge2BXKsvAQyCD2Ut6PhbTD/ZiETH6LvPqDq8+zRbaZjaV8XqwA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 SJ0PR12MB7082.namprd12.prod.outlook.com (2603:10b6:a03:4ae::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.16; Wed, 12 Nov
 2025 02:58:40 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%5]) with mapi id 15.20.9320.013; Wed, 12 Nov 2025
 02:58:40 +0000
From: Zi Yan <ziy@nvidia.com>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Janosch Frank <frankja@linux.ibm.com>,
 Claudio Imbrenda <imbrenda@linux.ibm.com>,
 David Hildenbrand <david@redhat.com>,
 Alexander Gordeev <agordeev@linux.ibm.com>,
 Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>, Peter Xu <peterx@redhat.com>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 Arnd Bergmann <arnd@arndb.de>, Baolin Wang <baolin.wang@linux.alibaba.com>,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>, Nico Pache <npache@redhat.com>,
 Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>,
 Barry Song <baohua@kernel.org>, Lance Yang <lance.yang@linux.dev>,
 Muchun Song <muchun.song@linux.dev>, Oscar Salvador <osalvador@suse.de>,
 Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 Matthew Brost <matthew.brost@intel.com>,
 Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>,
 Byungchul Park <byungchul@sk.com>, Gregory Price <gourry@gourry.net>,
 Ying Huang <ying.huang@linux.alibaba.com>,
 Alistair Popple <apopple@nvidia.com>,
 Axel Rasmussen <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>,
 Wei Xu <weixugc@google.com>, Kemeng Shi <shikemeng@huaweicloud.com>,
 Kairui Song <kasong@tencent.com>, Nhat Pham <nphamcs@gmail.com>,
 Baoquan He <bhe@redhat.com>, Chris Li <chrisl@kernel.org>,
 SeongJae Park <sj@kernel.org>, Matthew Wilcox <willy@infradead.org>,
 Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
 Xu Xin <xu.xin16@zte.com.cn>, Chengming Zhou <chengming.zhou@linux.dev>,
 Jann Horn <jannh@google.com>, Miaohe Lin <linmiaohe@huawei.com>,
 Naoya Horiguchi <nao.horiguchi@gmail.com>, Pedro Falcato <pfalcato@suse.de>,
 Pasha Tatashin <pasha.tatashin@soleen.com>, Rik van Riel <riel@surriel.com>,
 Harry Yoo <harry.yoo@oracle.com>, Hugh Dickins <hughd@google.com>,
 linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
 linux-s390@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-mm@kvack.org, linux-arch@vger.kernel.org, damon@lists.linux.dev
Subject: Re: [PATCH v3 03/16] mm: avoid unnecessary uses of is_swap_pte()
Date: Tue, 11 Nov 2025 21:58:36 -0500
X-Mailer: MailMate (2.0r6272)
Message-ID: <B114F7B2-8EDA-44DC-8458-79E3FF628558@nvidia.com>
In-Reply-To: <17fd6d7f46a846517fd455fadd640af47fcd7c55.1762812360.git.lorenzo.stoakes@oracle.com>
References: <cover.1762812360.git.lorenzo.stoakes@oracle.com>
 <17fd6d7f46a846517fd455fadd640af47fcd7c55.1762812360.git.lorenzo.stoakes@oracle.com>
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: MN0P220CA0008.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:208:52e::7) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|SJ0PR12MB7082:EE_
X-MS-Office365-Filtering-Correlation-Id: a1a98c80-878b-455d-9b21-08de2197624f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?gMoKcN3fAiCi6MBuaib3VlrZJnEwrrNINKrcdr1c90MAs5athBUtXPQ9regS?=
 =?us-ascii?Q?kJr5kVtIAFeMAFfNp08l5oKSpfhEv6rk+sNwjqGctjbIt/uS/mFTK5AA9YCq?=
 =?us-ascii?Q?b/a0MbQKFHViauS6ra+hDkTa04Jsd4u1tRc1/1DP557eDRPaueI2RaxQDr7w?=
 =?us-ascii?Q?Ggejh3nJyyp2P1+//+yxVMpSLjV7sI9hdsZEbsFbNa+OVKqAyzgBwbDBfDeX?=
 =?us-ascii?Q?PNLZgb3rOq9uS9YcKdFGLs2kbCXVzr64KfkJkT+kdjKQIvaR8ZzoyleiPsxe?=
 =?us-ascii?Q?DMQP78D2r4/bziuPls66EtVofTG8T9llZdVFcwUSrxLpPtJ90ZEKFI36ahkS?=
 =?us-ascii?Q?00dDeB1lM7MUjLb+rlB9CERLA42sTw49eAmsW6xPqCSyuXtBXBWYLSW7xw+c?=
 =?us-ascii?Q?7O7MgcPqHtcmCBEx3zYvGFhYq3y+uT0kRaY6WA0MlSC/QL16mPmZMgUwWLLD?=
 =?us-ascii?Q?35QWqjKW9Q/5uWsFCeq6O76gshKHsjBnf8+JUSzgqoucojat8JebrklRdsT6?=
 =?us-ascii?Q?/FzAiVxgDLYK9gBCXGtX+S8NHdRt26HHcDj8bMdclqMAX0MGJoYq5VXWjCxo?=
 =?us-ascii?Q?KuQPW1TPHIwxadsq27ikO2NuBP7qsab1QQMhIYbqwekwJO9eS5gBonUY4N64?=
 =?us-ascii?Q?trI24DJojo8mimQG6rcG1VwA8NQyAISVxwaSPI3o1GbswD9FOpo/8Ms8diYo?=
 =?us-ascii?Q?5GWgiVnixUfNmXWmgg9UP9qlS54W/fbdrXv5XrAhgnj5w23WgQo6mxFIXIq8?=
 =?us-ascii?Q?Fvz/Ydny0MRG0BDFCN3YRlbM7AphNL6MzKaQrrq1pZtzNYytYodDtZprm/P0?=
 =?us-ascii?Q?GkqQsiIbOr6zJu96KTM8urI/ftJaWs5AdPpsT3hWwnu5vMyo6Q11b5UIwsFB?=
 =?us-ascii?Q?6yDhnZ5XsAKlNDGgSlj3oPrwFEDFS4ccTEuhSbLM4dMnZ904fnmvkrVjkLW3?=
 =?us-ascii?Q?XyWtOJy3jelpa0HUr9erxWE6IxOmQKoH1/owFziLn4HPNA+Y1RC6puMpbYOe?=
 =?us-ascii?Q?8wx8BqadxZRrSKfPwVQ+46YPysI9VugKdVKEDmwP6ptStT8p5Jqcu307PRsp?=
 =?us-ascii?Q?eWmr9o0UOI5mzoFuT9iCPq+RuHSrOD3WLJH1EIvJFLMpfIDnKUEzgnCG69Oj?=
 =?us-ascii?Q?KlZNzLsvkCP2m8rIbg5YFf+HPG5RF1fyU2EYTjG1GUI9SWhV8Yk+y6dMOqT1?=
 =?us-ascii?Q?mH71uPNK8/M3HufTWPwHYsghQA66fd1TW0PkxBTXEq9RzP/PwuQLtNsIOWks?=
 =?us-ascii?Q?EImOFVPDdZZI6BdXgy4Bw0CLebdOoLVQju+Mi9pkX/hPQaXZ2MOD/ZLEjEvM?=
 =?us-ascii?Q?YHNeXdqqrZd1ra/ZCO3vQd2X2MlfzknG1vStR3DWOqH2ApTb1XJgfGkp7FqA?=
 =?us-ascii?Q?DGNbjctILSsc2dG0KMTwfCzKc5gSOGe2Rp0xGmtkjjvOptZgUXOjKG6zG0W1?=
 =?us-ascii?Q?OV2p+N+FIe+W+s36DfVuVvPDyG4u/HVS?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7B23abkw97vk4lQRjDbiNEK28WuBTCyknHcosT2YxWcTtkz1kg8mF9CenLkC?=
 =?us-ascii?Q?G9noYLGcSipa6Ja6X8jBaj5unWxc0Pwh4tGIaH1DEfKy1LENI0U19ctigAd/?=
 =?us-ascii?Q?axhqAYOxzeh2yjmgh03lS8toCge91q1iQS930Hc7JfPZeFGZlZfKNrrdwC8t?=
 =?us-ascii?Q?nM9O8dYjkXEdnrFDeG6BGxxV105Uzn69CutzbGsI2iPpgsUEixu450Qqhzgz?=
 =?us-ascii?Q?vDUgyhkiAUVm5v+pLISfr/f18ue/BJf+6QDESlsZBFYy0Tv7q2juSM7d8opW?=
 =?us-ascii?Q?jV+KsKPf1URDuKdNs1Zdcfg7L17TOIsTj4GY5KZEfOsgWOmLpI4DmYNQ02LX?=
 =?us-ascii?Q?6LmROBSb7AtSBjHP0c36muBygbhFz2SZ8Ua499wG6VhNULGPt+lYMFYm/+yo?=
 =?us-ascii?Q?weWR4/4wwXc+lhT4SysUuo1MikPOQ0c63rHMKAQp9xr+zgayf15n6rPLnWXJ?=
 =?us-ascii?Q?DT+pC0N2f0r0ddOww9BmK8q9l2u8ipxhXERP+Qyjb4o4qWeZFtla3ER/8L/L?=
 =?us-ascii?Q?4rRtZ0av1Bsn/vtw9f+0H3Gvl9VGPWDb2tmVNWll6hUJd+/cnZujNAgEIVru?=
 =?us-ascii?Q?vR8VXHGTS4YX5X4kgcyBn2LZdFBZxK9mpP6UtAtHexhRBOJDXgQYlxYA7tKC?=
 =?us-ascii?Q?xUe8V52wZ80WZ/NUkG2d03Itg1k4Fxk8yLvDPSlT0e4wUPXm5q/FdgU1dFy4?=
 =?us-ascii?Q?1UkrJ2kYrKbnByBJ52PZhQXlClioHxzt9uUiLravwtcycOCPi5XkTUWnMzwB?=
 =?us-ascii?Q?i5r6YK9w4C9V+yWY9LD9ceUvByi1elxR0ZpOQaAQCSiAwbxUa21z2L4dIFPD?=
 =?us-ascii?Q?NA/qLHJMJ4M6kJT0lTv7eT8sDdNyqzIlgc7fkeXCn4mENPOnir7jqeS155jR?=
 =?us-ascii?Q?eykVNWMK3vBTp+OYHx4w/aq+hvJLraT3nfEjMUBfC5yYcjIw7k3VCnliSK6O?=
 =?us-ascii?Q?tRgQ6nPHTAzBxJGqB2FfsSCuMX+bgKi5YW/117WKUxRegUAucp7mWjMMcgbO?=
 =?us-ascii?Q?9oSe+aONtr7gkdl98V1/Nm9haGhBQXXKJkJu7ZP1X9b/JOrv8pQnSyN7oue0?=
 =?us-ascii?Q?S1qGcfcmu3sziQc/cy/c5knkN6pPNXLODaQOGR2te6rtrfRDRPaOAPqXbYLD?=
 =?us-ascii?Q?B/2IoBFY6ahaeT90ox5vaVLGoPtb0muzRnbbHoePoDe6zMG6J77HQBq3YOMf?=
 =?us-ascii?Q?nN12Duv4g7xPANBguBxkvOwVoxdGQWGweUa47uGlDSmRng/tIPeOPM72cl95?=
 =?us-ascii?Q?D27Ovp3qQVfk+AcB/m9MHbiGkTmjYEx5Ku/Kv+wArQBNWAdF3nWVV9uGziWd?=
 =?us-ascii?Q?4/8L+Vczomi6jeyIOK646T3upVyGS1UT1/qHmjbjGiXPgiWoSB2dT6gjbBE4?=
 =?us-ascii?Q?9T1JPFwqbPPExnJ29gIG6ecO3jcj6VNQCxyJo+thVwa4a7A6kWzTFKO3nPoa?=
 =?us-ascii?Q?KnevEAEk5DOyrqe8TA+rI+fRK4v3BExK+JzATcEGfUPMl7THlM5OENHGaXNJ?=
 =?us-ascii?Q?FFUx9Lp5yBb0oy6ZM4N7eR0rqteYH3ioETmUwIwTqptCavKUaOS+ynF1kq2U?=
 =?us-ascii?Q?x1MQMobNYHBESLkNcJM/VXDnhY3DlWJzUJY+Zim+?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1a98c80-878b-455d-9b21-08de2197624f
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2025 02:58:40.7760
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Jlzq5Z/Is52aqMPPxyMSx7pBIgdC6aNw1msyEBUQ4l0rTBgrDkRwvyRLjMDBv3V/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7082

On 10 Nov 2025, at 17:21, Lorenzo Stoakes wrote:

> There's an established convention in the kernel that we treat PTEs as
> containing swap entries (and the unfortunately named non-swap swap entr=
ies)
> should they be neither empty (i.e. pte_none() evaluating true) nor pres=
ent
> (i.e. pte_present() evaluating true).
>
> However, there is some inconsistency in how this is applied, as we also=

> have the is_swap_pte() helper which explicitly performs this check:
>
> 	/* check whether a pte points to a swap entry */
> 	static inline int is_swap_pte(pte_t pte)
> 	{
> 		return !pte_none(pte) && !pte_present(pte);
> 	}
>
> As this represents a predicate, and it's logical to assume that in orde=
r to
> establish that a PTE entry can correctly be manipulated as a swap/non-s=
wap
> entry, this predicate seems as if it must first be checked.
>
> But we instead, we far more often utilise the established convention of=

> checking pte_none() / pte_present() before operating on entries as if t=
hey
> were swap/non-swap.
>
> This patch works towards correcting this inconsistency by removing all =
uses
> of is_swap_pte() where we are already in a position where we perform
> pte_none()/pte_present() checks anyway or otherwise it is clearly logic=
al
> to do so.
>
> We also take advantage of the fact that pte_swp_uffd_wp() is only set o=
n
> swap entries.
>
> Additionally, update comments referencing to is_swap_pte() and
> non_swap_entry().
>
> No functional change intended.
>
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> ---
>  fs/proc/task_mmu.c            | 49 ++++++++++++++++++++++++-----------=

>  include/linux/userfaultfd_k.h |  3 +--
>  mm/hugetlb.c                  |  6 ++---
>  mm/internal.h                 |  6 ++---
>  mm/khugepaged.c               | 29 +++++++++++----------
>  mm/migrate.c                  |  2 +-
>  mm/mprotect.c                 | 43 ++++++++++++++----------------
>  mm/mremap.c                   |  7 +++--
>  mm/page_table_check.c         | 13 ++++++----
>  mm/page_vma_mapped.c          | 31 +++++++++++-----------
>  10 files changed, 104 insertions(+), 85 deletions(-)
>

<snip>

> diff --git a/mm/page_vma_mapped.c b/mm/page_vma_mapped.c
> index be20468fb5a9..a4e23818f37f 100644
> --- a/mm/page_vma_mapped.c
> +++ b/mm/page_vma_mapped.c
> @@ -16,6 +16,7 @@ static inline bool not_found(struct page_vma_mapped_w=
alk *pvmw)
>  static bool map_pte(struct page_vma_mapped_walk *pvmw, pmd_t *pmdvalp,=

>  		    spinlock_t **ptlp)
>  {
> +	bool is_migration;
>  	pte_t ptent;
>
>  	if (pvmw->flags & PVMW_SYNC) {
> @@ -26,6 +27,7 @@ static bool map_pte(struct page_vma_mapped_walk *pvmw=
, pmd_t *pmdvalp,
>  		return !!pvmw->pte;
>  	}
>
> +	is_migration =3D pvmw->flags & PVMW_MIGRATION;
>  again:
>  	/*
>  	 * It is important to return the ptl corresponding to pte,
> @@ -41,11 +43,14 @@ static bool map_pte(struct page_vma_mapped_walk *pv=
mw, pmd_t *pmdvalp,
>
>  	ptent =3D ptep_get(pvmw->pte);
>
> -	if (pvmw->flags & PVMW_MIGRATION) {
> -		if (!is_swap_pte(ptent))

Here, is_migration =3D true and either pte_none() or pte_present()
would return false, and ...

> +	if (pte_none(ptent)) {
> +		return false;
> +	} else if (pte_present(ptent)) {
> +		if (is_migration)
>  			return false;
> -	} else if (is_swap_pte(ptent)) {
> +	} else if (!is_migration) {
>  		swp_entry_t entry;
> +
>  		/*
>  		 * Handle un-addressable ZONE_DEVICE memory.
>  		 *
> @@ -66,8 +71,6 @@ static bool map_pte(struct page_vma_mapped_walk *pvmw=
, pmd_t *pmdvalp,
>  		if (!is_device_private_entry(entry) &&
>  		    !is_device_exclusive_entry(entry))
>  			return false;
> -	} else if (!pte_present(ptent)) {
> -		return false;

=2E.. is_migration =3D false and !pte_present() is actually pte_none(),
because of the is_swap_pte() above the added !is_migration check.
So pte_none() should return false regardless of is_migration.

This is a nice cleanup. Thanks.

>  	}
>  	spin_lock(*ptlp);
>  	if (unlikely(!pmd_same(*pmdvalp, pmdp_get_lockless(pvmw->pmd)))) {
> @@ -113,21 +116,17 @@ static bool check_pte(struct page_vma_mapped_walk=
 *pvmw, unsigned long pte_nr)
>  			return false;
>
>  		pfn =3D softleaf_to_pfn(entry);
> -	} else if (is_swap_pte(ptent)) {
> -		swp_entry_t entry;
> +	} else if (pte_present(ptent)) {
> +		pfn =3D pte_pfn(ptent);
> +	} else {
> +		const softleaf_t entry =3D softleaf_from_pte(ptent);
>
>  		/* Handle un-addressable ZONE_DEVICE memory */
> -		entry =3D pte_to_swp_entry(ptent);
> -		if (!is_device_private_entry(entry) &&
> -		    !is_device_exclusive_entry(entry))
> -			return false;
> -
> -		pfn =3D swp_offset_pfn(entry);
> -	} else {
> -		if (!pte_present(ptent))

This !pte_present() is pte_none(). It seems that there should be

} else if (pte_none(ptent)) {
	return false;
}

before the above "} else {".

> +		if (!softleaf_is_device_private(entry) &&
> +		    !softleaf_is_device_exclusive(entry))
>  			return false;
>
> -		pfn =3D pte_pfn(ptent);
> +		pfn =3D softleaf_to_pfn(entry);
>  	}
>
>  	if ((pfn + pte_nr - 1) < pvmw->pfn)
> -- =

> 2.51.0

Otherwise, LGTM. With the above issue addressed, feel free to
add Reviewed-by: Zi Yan <ziy@nvidia.com>

--
Best Regards,
Yan, Zi

