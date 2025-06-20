Return-Path: <linux-fsdevel+bounces-52361-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ACBD5AE236A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Jun 2025 22:19:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C5DB61C226F2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Jun 2025 20:19:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 382B62E6D35;
	Fri, 20 Jun 2025 20:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="WIYDH6Jd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2044.outbound.protection.outlook.com [40.107.237.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CD6627726;
	Fri, 20 Jun 2025 20:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750450762; cv=fail; b=jryu7TZslbW6M6tVoAteQ4ij87dlhoZ3Vh5XE2Gsq0oWueiDVkgbhZ36wKceHpLEovrtxr1VAczMWGcNga+5WoaY9Cz2bOwpGgXWRChPgf4XfObSDPVAed0lqafX81LWQVLp9uFJ1IZY34u9Rj7FRr8N0J3GSu2mXbyTxbaO0xg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750450762; c=relaxed/simple;
	bh=GdAwH2kaanjhGqWjTgn84FpdVXBQMCVW249NFL26Xag=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ICGGzxs70m2opXeN17ylHA05iRe6MfdYMPIP8KjkIZMJttWPZKaO+EsXv8sEC+m9u5/CwvZASdXTSSlHrNAEoWAI3rsDLeGa9U2OwAuXvIGLY/Ha//VyMWk6ZJ3euydCKbSzdFuH5wC2QxhRc7MUJQTrwe4Pv74Rv761Np4ybc0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=WIYDH6Jd; arc=fail smtp.client-ip=40.107.237.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=daAF0q+IL/tFcLcLd77Z7osGlmmZVb4Jcbre9eenR7gTF4dNAYQskOX7O7of6R86O3C0w8qahXMs2Oml54/Ntc6zI+Og6v5X69VxjXpG+Bii7v5KVg5/SDvLlK4U34X55ZKa/c9cyra0ISdgbV3uFVBiOgGZ4wSVhRTX0ZTxQrxAsKLdbIw5oszz1brF2+YAL607QJ0aek+IjvpD3szSoSme49fvZ4ZQM9NAAbCMHMY826iPmv5sN+ygkJTM41hn0mxXV8vCxMNRPlNDMOdXxXB9bwon6cRUkuG9nvPkYP4ElJzqLy05yVueDmtyB/rKkjZhdcHVDTMqDAVbEPJlZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tJ3YGWIbAZJFKnC4D2/WZbyGHNelgob45ZcpOUcFHxM=;
 b=nUN+JoaEjAPEe4hxXv7X/gn+BuSibQV42O3UOe4z6c9t0AyDUS3AbaSkpC9Qy2pDvc3Yy8tIpBQ9ZvJUNdoz1SfOvxRcozvvUHOAGd8lXztMAi6E5m38vnl5t3Kbwg9DP4jSjO7AVuRi2mPR1k8oBgkLzAvkGg/cgZIlAu+6Hx4YtM9quPVJ8wKrl6Pld/USEVj+zgwBXG8HAON2MYiRItCADPAUDDwYxUGXAS7LTKTUqQ18VCdcO4+1f4QZz65GQUS0KLdU6F/9CGHqaMNL2rkRpj9mphEYxriZvKN2EqDwIERnYpC/0tSdvznrBNXliBLS1xK1GS2nUorlhh8j0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tJ3YGWIbAZJFKnC4D2/WZbyGHNelgob45ZcpOUcFHxM=;
 b=WIYDH6Jd8+oMNF7ee1Zz6BM2WZK7u3LW9AuXtmZxgmLpyNuD+naOjKv0Mmb0hff6rYK00F43MM1b62lI3vZAaQCTJfj6lczGWhS8VGyAJxki9Qwj1cG0auOSJscddOxYJaBetad+IWtIkzigAYQ0pJT++cRMbToG6sFmOelCxNA8ze9f0WnYtmidqxHqE2SKgphMOtFegwV/zTI8tUjSp7yFZFpnNjzuVB4Oxcdd1J6MWcRDE5zNZ1dvP9OrlDGcOc9l/vHAZKzqhL18hK/SR2BEJedl1e+ivptGee80nK8Dy3B+5pHDjk+9Lb0b7Pqgz8Lxq7Ay+F769+l3HbenXA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 CY8PR12MB8266.namprd12.prod.outlook.com (2603:10b6:930:79::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8835.29; Fri, 20 Jun 2025 20:19:16 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%5]) with mapi id 15.20.8835.037; Fri, 20 Jun 2025
 20:19:16 +0000
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
Subject: Re: [PATCH RFC 15/29] mm/migration: remove PageMovable()
Date: Fri, 20 Jun 2025 16:19:12 -0400
X-Mailer: MailMate (2.0r6263)
Message-ID: <A2697861-23B4-4A1E-994F-39E448E8FC7B@nvidia.com>
In-Reply-To: <20250618174014.1168640-16-david@redhat.com>
References: <20250618174014.1168640-1-david@redhat.com>
 <20250618174014.1168640-16-david@redhat.com>
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0340.namprd13.prod.outlook.com
 (2603:10b6:208:2c6::15) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|CY8PR12MB8266:EE_
X-MS-Office365-Filtering-Correlation-Id: c6858bb7-c460-4626-67d1-08ddb037baf2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?lHBIt60cYgxGIuxkq4iIEYQ+cyq6xvysV0Ap0L1xMgarOHqNjED0pEmugEbI?=
 =?us-ascii?Q?BBdV7eCweLjEemRzqc1UooUEh0BsNHGTtiGew0QgwodsaLUlhTCJOHH1pb62?=
 =?us-ascii?Q?1zEgwa9jbNQ0dX/j5jxIJCeRQnjEtM86hGfKeFvYUQ9D17URLMDDv4imo5IX?=
 =?us-ascii?Q?89pAVnIWE/t2RPPL997gOM9BRxsCli/f7zOKbYx+EBNWY097mYfWctV9QKs8?=
 =?us-ascii?Q?Xl2G1RlrearQ0+KStNV3caL2EVtXEgFlbQxHvTDq+Hx9/zl72tIowza9FQd3?=
 =?us-ascii?Q?gmsd/3Ps7SrB2cUEy5wFZMZOoB1nfg4d5ZXo+EGjPkk23Tvzpcp5K2QPsz7H?=
 =?us-ascii?Q?WBlJ9z8FRuZPMF57woaFM2boAxxg6RJhM3Wa32lmfjpZdsKtTZyVJWgh6foI?=
 =?us-ascii?Q?o7I1jfs2p8aqVHc5EDujv1G+wx+QTxkPa8X6LuUn9mFz7lHAjrPHeP+WoFkX?=
 =?us-ascii?Q?fKdsenJGxpydw6kweL/yeRFC99fhXkF2y/oe7xpfJMzKY/tdXf4ikxJQDyqx?=
 =?us-ascii?Q?5Qwoq75wP7KM3Aj8Fdt6FTwd8C/Oq3TUqPL3JbZ5TL4SIwwrnGADzM6BRjfl?=
 =?us-ascii?Q?m/qiEQiy0R9c6JRrv781TUaODn9MSkq3eXi4qtFLLzeLoRp0dYPdj/3TKjSC?=
 =?us-ascii?Q?cY+/SmWLksI85f+CbizEYJ/awxuAyo63HQ+o0/nlXT2U3plSc1fpZsIQOD1U?=
 =?us-ascii?Q?KRrBzVvL1bU9CKCImPishNae+41rBYEPINNrAl1YNiPG1YOLhLncon5MLgCB?=
 =?us-ascii?Q?Eeixv07kG91R8NDhe/0yDZnW0M64SK/cTYy8vDPDiTZuyo7IXTQ36S9/knqm?=
 =?us-ascii?Q?EhBE1w3ufvwYVptQwxjFpCejelJ8m+0BreLydv8ADjCSZ3vb2p6yb2NEniJg?=
 =?us-ascii?Q?CcV1WUa4TW4ZTM+7vp78lgkckMiywxRS5byIfF99mX825/r4JUtturfYbXNB?=
 =?us-ascii?Q?Sb24PAgVCrth000Qc9Q5f29PozON5BOvPU5fCjPq0yxdL1+1KOtFc2IXtRlK?=
 =?us-ascii?Q?AbKc9u4rEEYhRhmdCR0mPwo1pGsdZ9iAdppL9N265JEXJYcYyroorMPoeYkq?=
 =?us-ascii?Q?UzUMV8IFa//nEGuwl7cgp4cR1SqwhL3b/3n2EK7FsC1msoV3Unwy6cUv/uri?=
 =?us-ascii?Q?ArLreXrJsg+9MdOlRes/kiBwVajymBOffvVj7qdEMD3GGhq1a6PWcSDlFpiD?=
 =?us-ascii?Q?0rs4uW1DpZd95KDciBTky72kJTClgr4TkTS3IL6X2uWYAjUMW0xtHrJHCDzM?=
 =?us-ascii?Q?aofVgHbkIHCi2+T7sW7qmgGLO0X1YGolR0/dSb7mSek5BiM4gRIBffT9dTeK?=
 =?us-ascii?Q?qHAk474ItLlMv48xu7BXE+vAgrPu2e0obyuyqfa6RiX+5I5ifk2/F4YjVIeD?=
 =?us-ascii?Q?yi7Xr8XvaUquUArn/s/PPcf/AXGpnZIkZJMS01+6XqmgLKuWMkpHb+9b5sqE?=
 =?us-ascii?Q?k/vefAeGgI4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?raKRV6kfU1HSHdutj5Jml1dUaukuVtrgO+XltkXEFXevf0dhlhfxRaQ/ftXa?=
 =?us-ascii?Q?NOrSwrInJ/Af067ORkONIzLGa/CcHcAuiUtvDnLqOCrY7hgPyVxNMgYAC1eR?=
 =?us-ascii?Q?Usu9ijTkYti+iAVMX2Sb6yZYASQtLXyQ/i1Uy8L8EPqV9ccTH7QDYWNhtz25?=
 =?us-ascii?Q?V6lxi9uSrbpY/LTrKzQqKo1Cf5wATKu+SkY7YzPCpZG1Dd3B7aJs85VmN4y1?=
 =?us-ascii?Q?2spbC3JqzfgNQfhm0dkg73bengg5H4sHtARzJzrptn3QuDyePKMg4oYn0UP3?=
 =?us-ascii?Q?/FuR6NEglTzWzCaZE/72O0LxsHqpqsJY5b0P4n+0KefFFPGLPDnwqEoT0iaT?=
 =?us-ascii?Q?KilLyUUrxHDehTCc81DXako67yXTpCKClq/PxFxTIsA4C3RTYURDaXSzo8GD?=
 =?us-ascii?Q?pvBbIXQZU/aK9PGIsS+ynse/UU4Jejk77r5zMG2cnLMKYfYfG+EUaHJ6MJMw?=
 =?us-ascii?Q?FIyh7kZ/vs4h+xtKVgbp6bIY94G0kIoFgRo1Esw0rP+e29uLqgoHkxvbOVXr?=
 =?us-ascii?Q?MK14wh/OhTGQlVr9nGLe9BYvMahVk0kNUgFVpDb3xxQ6vkeDFDFTF7ci517r?=
 =?us-ascii?Q?Gq9WmXxC+NsW/AE+CtBKkTLS/wQnTnji5vF4pDj/qw2VnI9AG26UL+1vCFzz?=
 =?us-ascii?Q?YsfIoDBSabjssdYpvMfkWoGY6wSgTWLKkfpJqA9w+7g2tjiEizkKSEgGu3zR?=
 =?us-ascii?Q?MZb804vUks/e4dtXU94aPSnBmZU4Vl3UiY9U7pgNoTrgnURiTsIr1vg8N+0i?=
 =?us-ascii?Q?bOwXNR7l2C2+Nc1UIDdGuuubDkQHfijoiIJf2aewJj7UJ/Q0srEwIW5DZlu1?=
 =?us-ascii?Q?DxTExyqqVEiHdL/h5pthKgcQ0hjxv4+MmFjN7zyqQMq3ohmcUrhXvEI0FlZL?=
 =?us-ascii?Q?/+x+L+KaPsS7ss2dFyq8ryvDRoZLCjMlvk1HniNMMFDCZ3dQCA3hmXJIIeAb?=
 =?us-ascii?Q?8x/yy540WEkOgoftztxTo9GfBTsivHRMP2hh9lBEJdQJx+Na5V+y4s9698pI?=
 =?us-ascii?Q?mJtFeyvl2B3MZZpsxjZcgj4v5/IibQ10Nvl7dglzDlWvBwKFB+yL1EtV4hsr?=
 =?us-ascii?Q?tr+J1yO1lskguCTEVHR0gjqfutQF2mNRxFmiuDzWNi5ZLB69zQWnDLKSgjZ2?=
 =?us-ascii?Q?98rln9x/ilHmRjXkNODfDUhUFWa8WsZhejTboJFfE5SD9te2n3Wto845dQZc?=
 =?us-ascii?Q?RyV4BEoBcId7Z1tp5WxZOmFobqO0dpGRSyxCyUcQhYZ7hsM0LO5Ypb/efgjd?=
 =?us-ascii?Q?QuilVvRHmoUWCXyD/uueEoZVP0XcLNpS2bh0iZqspvyyqweNDj/zJcRN6aIL?=
 =?us-ascii?Q?gPRmjpmru+fSfh8lYSp54v8s4Q3lS9mt5TCgQ4ISc6+wUfc2+jk+Mk0IFBtQ?=
 =?us-ascii?Q?rkrPrPeuT0eDMUQk3dzD7Mm1LNo1MiXOXR2BUWQZvnRDDS7rs55bwtFrpTzF?=
 =?us-ascii?Q?Tlz6c3kJP132HprHVwEF5RLMGzNuo14jMYWeA0kjAYY6PqohhUX1lLr2Gg3h?=
 =?us-ascii?Q?pkpjwzUJJabEbhS5GJs/xMRV1DBN2/vx6G5NJdtdcw0CvVJvCzLTXw//CwF4?=
 =?us-ascii?Q?YVc0EhYbWdQjU7xF82gXABY6k2aCZFq6VrGZC7OK?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6858bb7-c460-4626-67d1-08ddb037baf2
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2025 20:19:16.5144
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ql6twvobWYKUKppUcgOVkQLKhL/nDsjH22kTfLBJv0/XThhVHwWqGfYS6rMmGnct
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8266

On 18 Jun 2025, at 13:39, David Hildenbrand wrote:

> As __ClearPageMovable() is gone that would have only made
> PageMovable()==false but still __PageMovable()==true, now
> PageMovable() == __PageMovable().
>
> So we can replace PageMovable() checks by __PageMovable(). In fact,
> __PageMovable() cannot change until a page is freed, so we can turn
> some PageMovable() into sanity checks for __PageMovable().
>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  include/linux/migrate.h |  2 --
>  mm/compaction.c         | 15 ---------------
>  mm/migrate.c            | 18 ++++++++++--------
>  3 files changed, 10 insertions(+), 25 deletions(-)
>
Reviewed-by: Zi Yan <ziy@nvidia.com>

--
Best Regards,
Yan, Zi

