Return-Path: <linux-fsdevel+bounces-44094-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BDF4A62034
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Mar 2025 23:22:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9BCDE17D4D2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Mar 2025 22:22:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1487204F8D;
	Fri, 14 Mar 2025 22:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="fEIyhnK0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2083.outbound.protection.outlook.com [40.107.93.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F219B1FF1AF;
	Fri, 14 Mar 2025 22:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741990894; cv=fail; b=GRKnaeuFWPjnOetZpMU+NyFaPIH29Us+tFP10BWALBmx8855u56j8e0EPlZergDOWOEsdGwBIR7W5hLctL0WViHN5h+KBqPCF7WVd81igeR8oMiaDON3wL1RoVOwxypJafl6FTc+WQXCVpnHPlxvhn2Rf7hBbbhOG+whLFqWUC8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741990894; c=relaxed/simple;
	bh=8HxKjQiXzFOjObuQ350/K7vUpTPUEWL4tXaXpCUvna8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dX3VDPA+XWjlg5Mx5jd9lOJf1ZuMtriZwb0MSAMql6EFEeHXcBkFICaH3pHz1Z5pLjLA7AG3xKuJyoesKrR8zW4/Zwysii+2WWvQN3J6rrVK46wUac/+fZ23xvP/FiUeXIdgZIVE179ObhqXNEx0hFbmZ44uzSRKH+/onwobGx0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=fEIyhnK0; arc=fail smtp.client-ip=40.107.93.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HWRcXeuqnt55bxBKk7MSiWLlVloYATE9G529gxAV+U8OmdbGIgVKxjhfslFWAh5SqeZFVia/MPvESwMQQVoqRguaj3iZ81Ubbh+JOmXHc9Y+AchRi7X+K1qfnIYzeCMNG5bsheqxKawb2Ej83gKk92uc1ypvvw3t9oLkyRLl482E83UZLQAFlXIM3eDU0hSoBHbx5afbbV5qf75D6RtHaKcGW5JWm04R6asAbnb2FV3vuiUMFiNQO1S7Wp84fFszBb4iRaUVPcXWRE9+KW16FXz+NlU6UjBt9iPYbGc/wQYDE+/iDOG5GsJcoFFgqFTV1K9x1vz6utHomks25zd54Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m3vCypCdoWVadCZlANYmq2YAis7NDT4qJ+tzvN0ESSc=;
 b=apkspoFUWCACgfUvZSWNwdxUfw8on1farTBRvf2zs5gcho8C4by1P3/rrLEtQRPgh7cRCSRrSS1DAttnYY+AdmF5DXAB6rfE9EboqcDYsiHLgQp5yEPZ83w7z6xn/rOfALp4NQlYfOeVzwQWEa4Ac2kSv08SgB4JptCVCwla6rwwG6Tt/EurGY2zy3Gd7m6tcYrussd8Irz9ogNQmicm3Aml5Sh4S096oQKww4ooJHWnwOctNgyDY2I4/WSa5ygB6b+1dZpgmNTkgifWpxHTwT/j7SO4YEq7GBUjSfckY0pqCcjNuFdzexharUxOJ8jI6v/Ey3cZ+ajBxzgc1gqCtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m3vCypCdoWVadCZlANYmq2YAis7NDT4qJ+tzvN0ESSc=;
 b=fEIyhnK0c4DLYL/liscW/qI4a8q2fqaM0+XPG8g2E7pnaM1O6Q/7eFH96zFSagUsq5wNT+Np2i3hEqi8nWM2IZRMXkQeQp+79ZPHrZYY2CdBBJ1vm1MBzK9An5XnvhSsG7fJVU5M2z3MR10MNGkAQiuqrPhOhnxn1IhIJGh9NmqoPkW0tZ8zL94KRHayzdc53c2v4yFLuNxF/9Uf14IOjxIfPQ7Fjk/VoNbPl2rxT9ZV9JgwUM1qjvP9t88OCPdMPqcsSB7kT7yHhsfO1gJcCE6SM40hYgFbh6WV0mpossBFW5gPtW4I7NVKm9uq80Uj1EkXijumjYo06omHSJzgdw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 PH7PR12MB9076.namprd12.prod.outlook.com (2603:10b6:510:2f6::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.28; Fri, 14 Mar
 2025 22:21:26 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%5]) with mapi id 15.20.8534.027; Fri, 14 Mar 2025
 22:21:26 +0000
From: Zi Yan <ziy@nvidia.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org
Cc: Baolin Wang <baolin.wang@linux.alibaba.com>,
	Matthew Wilcox <willy@infradead.org>,
	Hugh Dickins <hughd@google.com>,
	Kairui Song <kasong@tencent.com>,
	Miaohe Lin <linmiaohe@huawei.com>,
	SeongJae Park <sj@kernel.org>,
	linux-kernel@vger.kernel.org,
	Zi Yan <ziy@nvidia.com>,
	David Hildenbrand <david@redhat.com>,
	John Hubbard <jhubbard@nvidia.com>,
	Kefeng Wang <wangkefeng.wang@huawei.com>,
	"Kirill A. Shuemov" <kirill.shutemov@linux.intel.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Yang Shi <yang@os.amperecomputing.com>,
	Yu Zhao <yuzhao@google.com>
Subject: [PATCH RESEND v3 2/2] mm/shmem: use xas_try_split() in shmem_split_large_entry()
Date: Fri, 14 Mar 2025 18:21:13 -0400
Message-ID: <20250314222113.711703-3-ziy@nvidia.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250314222113.711703-1-ziy@nvidia.com>
References: <20250314222113.711703-1-ziy@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BLAP220CA0016.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:208:32c::21) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|PH7PR12MB9076:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d2b7342-8ed7-4ce9-c9d5-08dd63468fb2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?p2YZdUHnjr5dvA4reXylEPGoz54j09qrGEDZpnENZ5/Cw4W1G9sufZTD+Lyv?=
 =?us-ascii?Q?i9Im1R4SuAWkYpDtejna+fnQiXxujp9onLipPoOnadU+w9QMrsczlDsRLVvL?=
 =?us-ascii?Q?xpJEsxObCU4MR7YY2yvKG7e6j1OpQFNpaGTEuQ3c+fUKOYOkgynR8HW1+RYT?=
 =?us-ascii?Q?r1YsH7cImKWQ0jnqvm4ugyxUus0Y75XfN1F+wIGxc5UohIdMvu/W/VAGI1Xk?=
 =?us-ascii?Q?FqlSqMprMy4BuVBNFNL8CVk3P4eJZUVammL9sJL9rHnVTbLrHiNc4EZHl4J4?=
 =?us-ascii?Q?BxUVtIr9qQrS5422/Hu8fSKA4ojpV3xivf31+C6qmuWkbkbyVWW0QIdoJf4I?=
 =?us-ascii?Q?F8chWMd+ES982TYyiYX5pZpgCU5BqmhdRobBLNvVV8stb1IvRPbfnE3NcmJ9?=
 =?us-ascii?Q?K8qw4vqrfgK4SSIacT7YQ2OaFUU4hfonZJAr5qtWRDa93u7SFE+QhFUpbscI?=
 =?us-ascii?Q?7CDgcWExvnUpNq4HJ48BjDjEO8Odg7nzvzV6QYvtG/SsFOTBrwq5Z+HFRIqL?=
 =?us-ascii?Q?/KmJSa2n/Nusdwv5eK4CkJg3vkjWEHygIk5umMKq0yRfgxMMQFwa8uHgfFbZ?=
 =?us-ascii?Q?7Qfa2N7PceruB4SwO/tIBIUe1+vHhOMzZg8mUfV95gUVDxATDk8b3yg5ZddJ?=
 =?us-ascii?Q?tZppTOrbncM6OCTma3HwrCYczH3T2+L2WJkEpT97+JwrbKtWW4+j45kSt9jJ?=
 =?us-ascii?Q?j2d0osSMldT+JpBqFjmV8djXNN6kPwWo+bhoQPj00E/onVeLHQQizurCq1TT?=
 =?us-ascii?Q?FBtf3Fx3izIrEOaeCoimAtmzfdwJoRuyi1/fNHK1YIs+Y+NLSKRM12oh/z9/?=
 =?us-ascii?Q?b7yvwxgcMdtpnmBnJzAVjjQWY78EENx49jB7QRrd2rixZN1ko6EnPbfVDLCG?=
 =?us-ascii?Q?9vdzqee7pYLYtzncFkLjbBk8aKpQo2gyTD8+dJJARpcMn9/w5tG53sfLsFra?=
 =?us-ascii?Q?8c5V5yZc5EnO35U2T0NCK1GucjS9Vfegniusili5Xgd6j4Fp37jXNB7aM16D?=
 =?us-ascii?Q?UAEZ3jzoKt5JkQCpsn3488E5OmMORrd6RXMKiT8XnysRdkhAHiqHg8yLgqP4?=
 =?us-ascii?Q?3tPd+tTm1bAZTQLz2yIwz9Jq4yNE1ZsaW1JGS/WNxB5pPSl8qUbmsuH+zl1a?=
 =?us-ascii?Q?Z81S8YEHEF5h1jNqMb43AI196CJG+nh43RdDpFpue2wDTZpyg3FuVYrhf//c?=
 =?us-ascii?Q?IYCpp3IDPO8NqncsHJ/pO++StTqnEr74X5ZOYI8a+3KM+B5kI01i1AWoLEKf?=
 =?us-ascii?Q?ECTTfkzFUQsZIRwg3ytrH3rkXDKJkrMWQc4GdlpivmfgFkyYu2W9f1Slg5Cp?=
 =?us-ascii?Q?V0nb0cxDzyqUeWVxwYVjcj626f6MNBEcvSBwCyLJygf/fGXudh+yMYplwA8b?=
 =?us-ascii?Q?M/x+T+CLFiGlhMaxovFd3JaY9uuj?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Z6xvJ9uhFFJORgDx58vpkiDFOI2jWiYfQuP02/PN7Gk2F9YxFwckL7WdNldD?=
 =?us-ascii?Q?N946AkX6h9OpTv8F474dRBmvgUmhdlo7kMfc034qw7HHhIiUotc/cFyBwf7L?=
 =?us-ascii?Q?o3ByGhRBhXclUy0p7Vke0NH7H/ZS6qVE0/GKBAlIKf6nc0H8eKvCORI/QLJD?=
 =?us-ascii?Q?g5p4H1Uwj3ua3oaNMoGaF0UqQJRZ3RHKbUh+5ef3d/ND4RQykknAlHVMiZHn?=
 =?us-ascii?Q?M609mgSES5ZQYApBk+wQzDy3jXox2K1mjBBEeAD8k9vcZVmAxxrVOAcdgk8l?=
 =?us-ascii?Q?MOXsnSqShAGSgulRCz7jJCMPMMLPDVnoqtRRVTl/nDvAyHT/0+FPNRWMJvea?=
 =?us-ascii?Q?EV84ysumOUDaH40pSIvb2GcCy/kbsaX6wT0f/t8JMNIXHHay/+nWaUeHRdzD?=
 =?us-ascii?Q?EnNvkCXeT80ZuCkKe+tEsWOPBgfHwrrF7qN4ZZlmbgHPzLA9ENUVn661YIc8?=
 =?us-ascii?Q?lnX0sBzqnOp7VpscXgYOuBqIjLLPWBoBGeAK1ej+8Y3nJnKqnBVJ9uGEIe8c?=
 =?us-ascii?Q?mNtZl5q1VOKL4N3hD4RUR8yQ43BmKnrMuvItDZB5ao89mecQ5x1uswSyx11m?=
 =?us-ascii?Q?UMVQr9BedVAh5AnAWrpGUHYth/2b2ltjQziUf224jYRSIcHT4C1DhqetsWMG?=
 =?us-ascii?Q?TtExdjndlLp9q9Ho/30NX0Vze11pZqtrb3vwnnZfcXIQ8Iv0eehF6Asl9PaX?=
 =?us-ascii?Q?zQzazM7Wo/NtR25h5loXUmoqSrRGX64chf24ImoW4A1af3QrNv66tTTrnx0s?=
 =?us-ascii?Q?T+gclSCPFlgyLGX9CocS5XAzhvnAs9IKz1JDCW2ts13S/TPQkwnkBS7k/P/h?=
 =?us-ascii?Q?+gkGlFmSzGUNcd9SZHSM5Jr2y0Kxyq1YenVB9NrZN6QcHZtkZmYAKbXWBgDq?=
 =?us-ascii?Q?2Qczrby7ZkceXSOEQR2se5+1EO6CG1w6kS1pu2h+IsmYHqbZ4UNliNb3Qg8g?=
 =?us-ascii?Q?uaOvJ/LyYOnxVI+9HqO/6EYaPx4RpLkzbrX6q28zL2n/2eIu4z5zylND343Q?=
 =?us-ascii?Q?dVGaQ4hyeHtFk0NkOLWU0MD7nNEYGXi23CVDeBA8PFSHhMp5c2wpsJTNllLr?=
 =?us-ascii?Q?avg5hyp5LlR0ouddyLLE8TI6MSDFei/eHQ5/DJpptMjs9AlbE+62OFSHJuof?=
 =?us-ascii?Q?O7FKhEYY9k/00b87vccpE/KSjUJxRtYPPhGpjWoQiASsN88crHSNk3UFoV/U?=
 =?us-ascii?Q?6ADwu1OPRV2i5vKPF3ELs20/VL7Vamm0MxxuifIWkbv9XKuD+boTlkeYPYrT?=
 =?us-ascii?Q?Ct0wU0qEkZyldBU8J2+SGWqLQkvx5SDtjPDjzbbUzQSuZdsc9xvu23NNCF3T?=
 =?us-ascii?Q?RPdPN9ShXWlywx7PIC79V0WvO+v3c6zpAsJHOzoMddzK7Hmg81CT+8xvimz6?=
 =?us-ascii?Q?6h7RPijvotqvsgfdjseh5YMN6F3D0tqoNZOZqriRmqaFslhRroleawcJ0SqU?=
 =?us-ascii?Q?1QiPzW8vB/ABX35li0LQSsye6iY8F65+eQNwg/Jqy6BEv6RAUT/2WQzt2PZN?=
 =?us-ascii?Q?dCqRtC7WOsfl7BHABXS1oUSCS2Hmbn6hhdDt3fmDguZp0DeGqZu+U4lV9cqc?=
 =?us-ascii?Q?3RjLy5l6yuKJi6qSoAj1/jqYH84OHm+rbCnTPvuv?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d2b7342-8ed7-4ce9-c9d5-08dd63468fb2
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2025 22:21:26.7507
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9sCE0RSIKd565HoNOhvb7OIj+wJXP4agNmQ8YzJm7RTMvTc2Hx8ukhyOPNHuMBfI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9076

During shmem_split_large_entry(), large swap entries are covering n slots
and an order-0 folio needs to be inserted.

Instead of splitting all n slots, only the 1 slot covered by the folio
need to be split and the remaining n-1 shadow entries can be retained with
orders ranging from 0 to n-1.  This method only requires
(n/XA_CHUNK_SHIFT) new xa_nodes instead of (n % XA_CHUNK_SHIFT) *
(n/XA_CHUNK_SHIFT) new xa_nodes, compared to the original
xas_split_alloc() + xas_split() one.

For example, to split an order-9 large swap entry (assuming XA_CHUNK_SHIFT
is 6), 1 xa_node is needed instead of 8.

xas_try_split_min_order() is used to reduce the number of calls to
xas_try_split() during split.

Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: Hugh Dickins <hughd@google.com>
Cc: Kairui Song <kasong@tencent.com>
Cc: Mattew Wilcox <willy@infradead.org>
Cc: Miaohe Lin <linmiaohe@huawei.com>
Cc: David Hildenbrand <david@redhat.com>
Cc: John Hubbard <jhubbard@nvidia.com>
Cc: Kefeng Wang <wangkefeng.wang@huawei.com>
Cc: Kirill A. Shuemov <kirill.shutemov@linux.intel.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>
Cc: Yang Shi <yang@os.amperecomputing.com>
Cc: Yu Zhao <yuzhao@google.com>
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
Tested-by: Baolin Wang <baolin.wang@linux.alibaba.com>
Signed-off-by: Zi Yan <ziy@nvidia.com>
---
 mm/shmem.c | 59 ++++++++++++++++++++++++++----------------------------
 1 file changed, 28 insertions(+), 31 deletions(-)

diff --git a/mm/shmem.c b/mm/shmem.c
index 5586903950b3..7b738d8d6581 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -2153,15 +2153,16 @@ static int shmem_split_large_entry(struct inode *inode, pgoff_t index,
 {
 	struct address_space *mapping = inode->i_mapping;
 	XA_STATE_ORDER(xas, &mapping->i_pages, index, 0);
-	void *alloced_shadow = NULL;
-	int alloced_order = 0, i;
+	int split_order = 0, entry_order;
+	int i;
 
 	/* Convert user data gfp flags to xarray node gfp flags */
 	gfp &= GFP_RECLAIM_MASK;
 
 	for (;;) {
-		int order = -1, split_order = 0;
 		void *old = NULL;
+		int cur_order;
+		pgoff_t swap_index;
 
 		xas_lock_irq(&xas);
 		old = xas_load(&xas);
@@ -2170,60 +2171,56 @@ static int shmem_split_large_entry(struct inode *inode, pgoff_t index,
 			goto unlock;
 		}
 
-		order = xas_get_order(&xas);
+		entry_order = xas_get_order(&xas);
 
-		/* Swap entry may have changed before we re-acquire the lock */
-		if (alloced_order &&
-		    (old != alloced_shadow || order != alloced_order)) {
-			xas_destroy(&xas);
-			alloced_order = 0;
-		}
+		if (!entry_order)
+			goto unlock;
 
 		/* Try to split large swap entry in pagecache */
-		if (order > 0) {
-			if (!alloced_order) {
-				split_order = order;
+		cur_order = entry_order;
+		swap_index = round_down(index, 1 << entry_order);
+
+		split_order = xas_try_split_min_order(cur_order);
+
+		while (cur_order > 0) {
+			pgoff_t aligned_index =
+				round_down(index, 1 << cur_order);
+			pgoff_t swap_offset = aligned_index - swap_index;
+
+			xas_set_order(&xas, index, split_order);
+			xas_try_split(&xas, old, cur_order);
+			if (xas_error(&xas))
 				goto unlock;
-			}
-			xas_split(&xas, old, order);
 
 			/*
 			 * Re-set the swap entry after splitting, and the swap
 			 * offset of the original large entry must be continuous.
 			 */
-			for (i = 0; i < 1 << order; i++) {
-				pgoff_t aligned_index = round_down(index, 1 << order);
+			for (i = 0; i < 1 << cur_order;
+			     i += (1 << split_order)) {
 				swp_entry_t tmp;
 
-				tmp = swp_entry(swp_type(swap), swp_offset(swap) + i);
+				tmp = swp_entry(swp_type(swap),
+						swp_offset(swap) + swap_offset +
+							i);
 				__xa_store(&mapping->i_pages, aligned_index + i,
 					   swp_to_radix_entry(tmp), 0);
 			}
+			cur_order = split_order;
+			split_order = xas_try_split_min_order(split_order);
 		}
 
 unlock:
 		xas_unlock_irq(&xas);
 
-		/* split needed, alloc here and retry. */
-		if (split_order) {
-			xas_split_alloc(&xas, old, split_order, gfp);
-			if (xas_error(&xas))
-				goto error;
-			alloced_shadow = old;
-			alloced_order = split_order;
-			xas_reset(&xas);
-			continue;
-		}
-
 		if (!xas_nomem(&xas, gfp))
 			break;
 	}
 
-error:
 	if (xas_error(&xas))
 		return xas_error(&xas);
 
-	return alloced_order;
+	return entry_order;
 }
 
 /*
-- 
2.47.2


