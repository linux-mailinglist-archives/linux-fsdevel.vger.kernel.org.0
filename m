Return-Path: <linux-fsdevel+bounces-52360-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD986AE235B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Jun 2025 22:15:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 72DCC4A8195
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Jun 2025 20:15:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FFB228A724;
	Fri, 20 Jun 2025 20:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="qqi2deFp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2072.outbound.protection.outlook.com [40.107.236.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DCE0136988;
	Fri, 20 Jun 2025 20:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750450533; cv=fail; b=f/YImq5ueUWyiTv9P4Bjyqj0c3FCE/87yGpLnNzHv79xZOhaMFWPiQCpqrFOSRAWmrH681Mq9DsiL7OtPFLj6Ef5VmNtdOliCreatfq0PuAN3T5VznsebGqcMqSK8DO72SSGZi7yuj2ThCijUx8VOivjvSWklCAhKnhJ2JcaVdc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750450533; c=relaxed/simple;
	bh=+shQxfdYLIt5mJkK58NX5mj+cMMPtcP7T352isPOreI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cdiDlEomsYGab0lt3LqJY/BhTHR0sJrX4/xgolRj6CsVhiRgf/Lj/wC3vJssHffTiKWApnnSXBZ5NNrt0ErPeaVQiEyRFVrWWba0xEMLHvIjbUhxCSeokS43su/8zEum1wXMPx5TUpytMWYvtZKGy3MgJEye1ON3n3vvP0/7Y5Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=qqi2deFp; arc=fail smtp.client-ip=40.107.236.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UIbPUa6dOuVaUvO29IaWjOhGNzVaIgOddqpMobwe2cyDh0hvSsJC6XkpFGqiA/R7/9NZ+B7/0QsjF7MxkL86brfXQ8bofKhfvnOoQWgvtI9pkUNctBhJ8JNOj7IB+vTdPLQ6ZzDjaToZ+qvag/JPAxxA0PteHF3UkvyiR/+gajSHNe/av2Kr0l2XdxXr4iQZdZ4Fx5mgR30i6/TpIiwFhuDytKnyrMqw9bIaK7FKACln1j5I7qpAQ4IM4QvLs1irMwRc+rTyXf3piWDLM12r4dR3ZktSNtQ2R0wB/qSx9lHa/bl0ygxeii52K7a5SF7bfq23KfmbTcFSElDu9dc+7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8dr+9l5kZE5TzcKfM0PYNA18p+MwgUcSXmWCMm29C4A=;
 b=xM3quRBFUac4IVOIET+qeHHhP35hKsR3l6sdXZb/FsH+MNG+9oMLIiP+sda544GBDglzY78bEb2T/UkibfseykKfpt8lesiMLkG8JZODKGyWHPm9xbN1/m9j2K3k4DNN6IjIQlQwrTkm+23Ks0NQi+C/xDA2a+Cqo4lJzDpxGUes/E6kF2e6x5y0SbNskppPWIUJ4vfsFRtNll5HzB+4G7TVAe4GuAAHbiYW5rSS0bkveTe7WzZ9du9p0z0zcgTYRMo7tncppqH9615LkAiIjaQH94Jzf7DJgkFBs4/dmDqiJRXIPRI45qDjkHs7t4IhGJXdhfc1rxHpdxnvJ+/guw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8dr+9l5kZE5TzcKfM0PYNA18p+MwgUcSXmWCMm29C4A=;
 b=qqi2deFpelUkPQoCXj72H1okJq7GRqCDJwbQAl4zxjfubdDbY+yrKJOKHhECHfBQXj816FRFClBGhIO+DUtPrmaa/+l5bnF1lySUJHDpIG+LdwThTrU7j1BQ3V/7vY05DgLfpeCmDyqa7sNRolI9GOp+w5ZtoPjF3KBaQse3eDW2YfFdPchcGNbMOoHD3VkYEsc5XJfSiry66qfrxLVxiDME1niZ8g8VlN2nQ2YfQvF2l/IXlAWjwc761wUKo+xzqYhAPthfo6q3L7rHt6sZC9kPLLQMBAe9+ie6C0WprtXakLVm9UISSGT/nRhtNMSDHhUl0wLT2mYNqCLFef7w1g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 IA1PR12MB6139.namprd12.prod.outlook.com (2603:10b6:208:3e9::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.29; Fri, 20 Jun
 2025 20:15:28 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%5]) with mapi id 15.20.8835.037; Fri, 20 Jun 2025
 20:15:28 +0000
From: Zi Yan <ziy@nvidia.com>
To: David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 linux-doc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 virtualization@lists.linux.dev, linux-fsdevel@vger.kernel.org,
 Andrew Morton <akpm@linux-foundation.org>, Jonathan Corbet <corbet@lwn.net>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Jerrin Shaji George <jerrin.shaji-george@broadcom.com>,
 Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 Matthew Brost <matthew.brost@intel.com>,
 Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>,
 Byungchul Park <byungchul@sk.com>, Gregory Price <gourry@gourry.net>,
 Ying Huang <ying.huang@linux.alibaba.com>,
 Alistair Popple <apopple@nvidia.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Minchan Kim <minchan@kernel.org>,
 Sergey Senozhatsky <senozhatsky@chromium.org>,
 Brendan Jackman <jackmanb@google.com>, Johannes Weiner <hannes@cmpxchg.org>,
 Jason Gunthorpe <jgg@ziepe.ca>, John Hubbard <jhubbard@nvidia.com>,
 Peter Xu <peterx@redhat.com>, Xu Xin <xu.xin16@zte.com.cn>,
 Chengming Zhou <chengming.zhou@linux.dev>, Miaohe Lin <linmiaohe@huawei.com>,
 Naoya Horiguchi <nao.horiguchi@gmail.com>,
 Oscar Salvador <osalvador@suse.de>, Rik van Riel <riel@surriel.com>,
 Harry Yoo <harry.yoo@oracle.com>, Qi Zheng <zhengqi.arch@bytedance.com>,
 Shakeel Butt <shakeel.butt@linux.dev>
Subject: Re: [PATCH RFC 14/29] mm/migrate: remove __ClearPageMovable()
Date: Fri, 20 Jun 2025 16:15:21 -0400
X-Mailer: MailMate (2.0r6263)
Message-ID: <501877A7-28C9-4203-84B8-E05E7A0E24F8@nvidia.com>
In-Reply-To: <20250618174014.1168640-15-david@redhat.com>
References: <20250618174014.1168640-1-david@redhat.com>
 <20250618174014.1168640-15-david@redhat.com>
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0252.namprd13.prod.outlook.com
 (2603:10b6:208:2ba::17) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|IA1PR12MB6139:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ac4ef3b-3d70-45a2-e12b-08ddb03732b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?zip6ch6m0HErZBprKdAgimHdeFaWCaGKeqDnpiRCeQykormnUZojguwzvkvh?=
 =?us-ascii?Q?dxqzyM+4vD4EjYidUfl/yXhFMod4u4vBhx7kU3Ve9UKDifbeE1Yu5I+dbCGO?=
 =?us-ascii?Q?UZI/m3kvYJpe7mJwCQZ5gb4Gw2EeH+dK4EWZDfiCQVJiGnEn7puwZns5R1Cr?=
 =?us-ascii?Q?IpbfFvY+k0t4VAr013VPpMYuOa4p6c5gezH7UvLccaGp1DeYIVHd3FeCRb/Q?=
 =?us-ascii?Q?dktz60ETxTmlXYuujPNRNxjPkzB/3hRDWG/vqGjKK2zzdcwF9TgoDYn3evvu?=
 =?us-ascii?Q?mVb0eSLQwzi0SOd2qsc/U4m3Z05xD//bXvyogysdUDie9DQcYQvF3TMGk9T+?=
 =?us-ascii?Q?wHnUJjAiWXvn3cew181YJ4n5BW3QDMovKjmW0+wyxjt2/RzUAM1eXcUcHZfG?=
 =?us-ascii?Q?KFrFxym0FjHSs/dW8WtHnJetiieRLVvv9WYVeeG+SO8ZyTaHgYn3xIXyhebA?=
 =?us-ascii?Q?T07ftYC+1tjpV6N70d5gqVdUw+kOYmu5KN8TxJpVmiIZy+PRuHlS0NCrUOtL?=
 =?us-ascii?Q?2TsKWZIporr5/wTdiOyXmYw1DKB2d36oI1QeNFOe1lYe3O1x5k3c/57tZcO9?=
 =?us-ascii?Q?yfb/fSfGGx/+GNAY6sERrZgTsvZm9Y1UPiHRWW5thatAcykkghbT6/I4/Q7+?=
 =?us-ascii?Q?IDfjh6VBn8BOeshrXSeerFMQUFqPCdR9IJ14kbpYS37E4NpZ6aOStOxyHjQs?=
 =?us-ascii?Q?bru99ly8eLfxRgdRHN5o+S+V4JrCvS+TyHwCNgAt2E81IoaDSw1sLr0G+0Zq?=
 =?us-ascii?Q?/eziONc/cgzxwygwRVk2cg8nYGgDdFX6bu/XTL7sYxqav9Svnn3qarVVUc+s?=
 =?us-ascii?Q?tg7t6Oi1L4faYHMs65XfcRu3Ptm6rrB5NgZMY1f75MRacnzKjbovqSYhW+6N?=
 =?us-ascii?Q?0tJRGH30RvQPTtEJN04iGH2VHe51PL1JN55k/ZTuRqyrct8BdxsIsO2qkx1s?=
 =?us-ascii?Q?3jGFoZzM5BZBl6KA9Y+eOobZZ1zp8cYYfCXaxu/Ujp+ZgLnB64S/dQvjajxb?=
 =?us-ascii?Q?/SkLIijRgG/p5ReSH8oEvSpAgdZasEWwHrwbz1kSY2ZNUfGAW7td2X9Vqu3J?=
 =?us-ascii?Q?Q4Pr4windnFzNUp9JENCmwX7f7gbfPCgQ97jWKL6roZfkeB2nEP4rK+AKMZu?=
 =?us-ascii?Q?QTOEtt2IIimehD39OXwaaqqXcIhOEzohQjnQb2hyxboyYpcsl7qHXnDkCbtH?=
 =?us-ascii?Q?W6an1Afts3LBAC3g5mOiV138L5a8Kelx8a/Rz6ePHPq1dTXLs+mgUfa1bjSc?=
 =?us-ascii?Q?iCKOy6T7BeeZXUWko/hPxhHCvIUW+XcQSMnJCDMbYhGXVH4rOK+6SZDd/rsI?=
 =?us-ascii?Q?nSm85uetIJoBv8MpUOQGM7E8dN0iHvDjM5YfjncfbNoHhLtwNx+QwojEkxcu?=
 =?us-ascii?Q?GIjBfq2MXVO5l/aR01XKOfVUsanuxuEvmmpr4jGJHy8O2Cp+ZsV8DuFshOV1?=
 =?us-ascii?Q?7inCx2vX5SU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ayN5ek/h8VyUiuDEllpQaA2Rvun0fxSFkY3BgCPzqWX96JFNdJsS5C9kAjsV?=
 =?us-ascii?Q?l4NGKTpmjkbMCZ95u1I8/VrZQTwQn3CLSSMlC9OmlGTizJFU3VXSap+LQkoL?=
 =?us-ascii?Q?60TnZFLSlVOMFQkPe+pTkX5d6NPyF82sr0DXOMEitRr7Rdy4xgv2n3mkrGNK?=
 =?us-ascii?Q?ZBoGOYy33ujUzxDhm8a/FzAqH0pxJqOHsLG973iXqdxcs/fYlDV5S3e/Fwki?=
 =?us-ascii?Q?ABGOJqexA57uoZQl+HgIrqCuAjBf+trH1O/HKvr6lLClyVPmgp0GlMZrK2Te?=
 =?us-ascii?Q?x1sGWNmhkLRcjvWYNINDZaqqv18+nGBlaqnZTZXj9CMN+KF1/zWRLMFf7o2a?=
 =?us-ascii?Q?3RfRZhvFaHM9DyiRqRStwzoklzohnOqVQvX9fMO0Y7MYJ2fMYUJhxA5ZDyFX?=
 =?us-ascii?Q?H7r9bFTrxGnxYOgAVATaUd25OM1GT0sC8+xAXjb6qm9Jtygl3V0pwNnNw/Lp?=
 =?us-ascii?Q?DsMUKYjSI5VpueoKLKJuQJMg7Lvm4wd6Sd7dG74POhszg5SIimURjJMkQO3S?=
 =?us-ascii?Q?8saBrXKjwXPvZqmcaIFCRDxRQORhBbMuZgYsRDIqKSQx5IjVFx9cBgAl5Pb2?=
 =?us-ascii?Q?Ydr+1lJw0lnh+icqNb2NBTJ/DTSQ4WBXvkBS98iw9eeg40yaXXI4apXxy+2+?=
 =?us-ascii?Q?JTw9uqisHtFyxh/CJ5oX0a8SkQYRotkvGjEE48YyF+J1JKUpcF0KmyrnkAlO?=
 =?us-ascii?Q?CGjeX17e325Y7yIMRCckElf3ZZc4j0ryeFI/d8+4V1Jd88S4ihdQPQGvpEZ+?=
 =?us-ascii?Q?sPEWhWXZsDlRO2uRwwIQp5jGHVzsbEPdOJyyUzdy/QYMd+DeaeR+cxqlQPY/?=
 =?us-ascii?Q?HpCL6iDRHlFfGBvavDUeYlApuiEXE1B0c0Ry+XAswkWh7NspUewuxCpeaN3Q?=
 =?us-ascii?Q?rWM1Dj5CyM91vbB48aH0pK105UxheCo84/avC5dxnACgr4upjFOwQNwRdemh?=
 =?us-ascii?Q?H6Vi21jfyh0GfZOiYKPtWn5IEvtD+KlGe7yxLmAuJeMgmaREUsHfZ7GS/cAw?=
 =?us-ascii?Q?If9xbB37mlfqTQj1MB+2jP0gKhGAncLRgU7jzThr4wpVF0qIJH15zMyiKF6C?=
 =?us-ascii?Q?mBGbUh1OOtK2XnxlBphLFTHVBNAxiBVzK2RV5j0XPDUzg6eNk0RFgp7SQIxr?=
 =?us-ascii?Q?i4mh54rBP+jLaBNe/bzw5KI2RI3qjePLBVkD10G9VS6DLv9OCu8CKSxY+ioR?=
 =?us-ascii?Q?sUjL0vS/zeL0xpgS18fY5tYYHdCWSh6gpSzNnE52ReT4kYaw+wNmT/owwY7d?=
 =?us-ascii?Q?l41zZRgG9RzKgRXPL1l2v6tsa0S2i7uJX4njqfZnk6mYfszx0ccVVXGv6k1b?=
 =?us-ascii?Q?BdrM+DTFZdJWRxYDlZ5hN2u74ZHWhPHiNgHZcr9Cy1rE/uK+vI7NvVN7iHPQ?=
 =?us-ascii?Q?w3hICY64u97FhSpvK3jkYxc3dxwQcIJldkkRumX2MMe1n1lmSWiEKMPnA6PV?=
 =?us-ascii?Q?UIatYO6aDxwnpcqfTDoiTkLS9sQJRIjomD7jgih3aVjMJcCZsAQP6oFWSfDb?=
 =?us-ascii?Q?/jychSLyCSXu4daeZmkacUHUoM859ieKlfTK9BT7Mtcjl+XU7nfYTAqPBxDW?=
 =?us-ascii?Q?Dbi8ho25WSP2CtdgAnhBm01QV/CYyzP5UN5HiSI3?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ac4ef3b-3d70-45a2-e12b-08ddb03732b6
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2025 20:15:27.9326
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rtD1p5LJUWHtiTqY6+q35cB7EfyZG+/YXpnAA2rgP+0J4rFQmP7w6F6C1uhHMW7w
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6139

On 18 Jun 2025, at 13:39, David Hildenbrand wrote:

> Unused, let's remove it.
>
> The Chinese docs in Documentation/translations/zh_CN/mm/page_migration.rst
> still mention it, but that whole docs is destined to get outdated and
> updated by somebody that actually speaks that language.
>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  include/linux/migrate.h |  4 ----
>  mm/compaction.c         | 11 -----------
>  2 files changed, 15 deletions(-)
>

The comment for struct movable_operations needs an update too.
"
If page migration is successful, the driver should call
__ClearPageMovable(@src) and return MIGRATEPAGE_SUCCESS.
"

Otherwise, Reviewed-by: Zi Yan <ziy@nvidia.com>

--
Best Regards,
Yan, Zi

