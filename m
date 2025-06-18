Return-Path: <linux-fsdevel+bounces-52096-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33D99ADF639
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Jun 2025 20:48:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 18EE05604F2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Jun 2025 18:48:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7D952F5474;
	Wed, 18 Jun 2025 18:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="XVBvqF7d"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2049.outbound.protection.outlook.com [40.107.223.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9BA31F4192;
	Wed, 18 Jun 2025 18:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750272509; cv=fail; b=pDRuUGnbm6+iM+lOAhBq6KkFuSVS4w9swuyTNLozRoSgnjPJNS3tGUYTDOW9mBy4EZbGk8f6NmOWh2elHJ1ivUwvgeVJO7bK2KzmNnNvg4NzbJj9iulYy/0c4XmatxxsodNVNgyG0jeib03JPMOGOiCjiBhWSWi94Fz0E13zVAo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750272509; c=relaxed/simple;
	bh=+PGEdALWCNEtJxbzyg1idlZDLWZ5wW0AjcFIF5hH3Bo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YLmh3HHw0IToPoBu1P1trU7XRBOJ7nu/m0QNHSH6+2NryFTfggRytlDPRuFjBLc0Yhwxs2tcokOim43W0bXPfyxnN7emKCgpb3l8gd3sSu6nQxA8CCVlVs1zaBXVJ4NIjSmmiFn/hTcmnnGw0kFZBHytBwmk3655fbl8o8oLVPE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=XVBvqF7d; arc=fail smtp.client-ip=40.107.223.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wPQ2Th0H4BVcqbnS9UEsk6rUC4KT9Ikvu1RqrHEKgsLbS7TLOfF5ADA9EBrLKPhmg91HMorEz+sRZEi4tLcbPpQd1IYH3z5RnKAuOlaR1YxzHY8VTUO7Jq3tnR+y5A1BArD21OK9Ra/HV+PamSvPrp5tMIfk0XRcWTqg9Xz8LnrUZozyrLQDh9xMYnSZycaoD6Et1AOmVrywGY/wjR7rCD2s3S7m5L1fhwYsQr2Wd7zqpVWnoOxVbwR188gVlKzR/xKy7ucJMN5tDZPsJzKgHHsEOm1cRuxVFF2QpB8dttM8PqVj9ts4Nn+cOWKJ1cAQTefgMHg2ug9SHOPzn7W05w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+PGEdALWCNEtJxbzyg1idlZDLWZ5wW0AjcFIF5hH3Bo=;
 b=a7W7Wr4FpLThK2x55MonQpcXxzlgI3hTKjkpcqKFX0CYdVjjtegZohnrZPxVBM7l05WGm0qb28x2asI1JR8ilFN2dAenR6uAht4ZTnqEFsKaV1F6SRSafVOfdSy+qipsxddyXUtt+mpQhopXrfVMkqBdwWRbEPGaM3QBu9ZwvwMwl+aLxrWl8dCLa92zqEaAspnBKXJj5q3gILLv6hrwGmYDG5cebixXbVMV6qfJWHgi2rh4ybk0WJwNelUf3XOQSy9lyLbQRVmSuhJpu3dqOYrxfUKB9fKdDsDSfQfUw/ORvAZHJgF8xmvrCQUqp5HugZyAU1NGCaDXEtyPGw2uug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+PGEdALWCNEtJxbzyg1idlZDLWZ5wW0AjcFIF5hH3Bo=;
 b=XVBvqF7d1P0AMI0K8OgnlCCgUlsW4DPG/BTWo39dJjG5QCz7l8FG6xXxJQVArUKkIQj0NUq9Wtt0yk3W0bgjlOqBnm7YKT/8NJc6PWAZb2VT0ff8q3mGbVXZrEZ0vlYNVZ1ONMvGa5lyrEPWjn6zqB2kK+12Qf8EAioNl59ABdOAP+aszKVeWBVMbye91+NM2do5Cbnmg7D93pn/9RZQNvQnL5q+o366oL1/Q5x4oo1SjE70l0oaa73Dkz75FUQ0KvxhTY18RL4h1YymekyLd/5gdRFQprZFDf17E6TPlJ7xZ5p+xJ/McnlEoJGlwFU6Igtl1pGnSdIhSOxqdygZxA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 CH3PR12MB8850.namprd12.prod.outlook.com (2603:10b6:610:167::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.29; Wed, 18 Jun
 2025 18:48:25 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%5]) with mapi id 15.20.8835.027; Wed, 18 Jun 2025
 18:48:24 +0000
From: Zi Yan <ziy@nvidia.com>
To: Matthew Wilcox <willy@infradead.org>
Cc: David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, linux-doc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
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
Subject: Re: [PATCH RFC 07/29] mm/migrate: rename isolate_movable_page() to
 isolate_movable_ops_page()
Date: Wed, 18 Jun 2025 14:48:20 -0400
X-Mailer: MailMate (2.0r6265)
Message-ID: <4D6D7321-CAEC-4D82-9354-4B9786C4D05E@nvidia.com>
In-Reply-To: <aFMH0TmoPylhkSjZ@casper.infradead.org>
References: <20250618174014.1168640-1-david@redhat.com>
 <20250618174014.1168640-8-david@redhat.com>
 <9F76592E-BB0E-4136-BDBA-195CC6FF3B03@nvidia.com>
 <aFMH0TmoPylhkSjZ@casper.infradead.org>
Content-Type: text/plain
X-ClientProxiedBy: BN0PR10CA0026.namprd10.prod.outlook.com
 (2603:10b6:408:143::21) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|CH3PR12MB8850:EE_
X-MS-Office365-Filtering-Correlation-Id: 06f4493c-a2b6-4876-69d0-08ddae98b4b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?QHyyAyNZTHSWBrpKH35vV0VEn/i57ZjC1mun28tNW7MgRNlHxwsmbnB8YJRY?=
 =?us-ascii?Q?QwuYqdkg4RXNPuEKJscr52bYbpCmIpWDF73w7KMsloT+4G0sPkz7obLEnqFk?=
 =?us-ascii?Q?8bhw0bEKGDNXf9J3NGIByJ+Y/y6cRWY4Bde63NY4SwHGqhxmqdYeS6QMe89G?=
 =?us-ascii?Q?hHR8E0mcPzF16WYIr+v2SSpA4NjtJpweoW3j1NOtTgWZUzeREdC+FlTru8TK?=
 =?us-ascii?Q?6DPMLHP7nKjWdLERvccsx9JyvHSWFRBfKaH+7RBn20wS3IPU78eDYVRxiPxp?=
 =?us-ascii?Q?ht5TraMdowRbNUUhBIwxq10o4zLYIWhsHZOQf28xTNna1elKmreB/AHZAUsp?=
 =?us-ascii?Q?t4A5mIBKoMUdPLRXMqYELEPGaYMm3NQ85GlZNScbWj6hfRARBf4qjNRnXS0P?=
 =?us-ascii?Q?rQvk06lNRRbFBdM5D+h0y0DTzrFbztemfUhVUo0fdtoQ7rWOLPVKfT0zha8b?=
 =?us-ascii?Q?UKLeLSHgCSkg4f/8mny5xH8zACt/VNpwewBl76yq4IaGhi/TpSaejHYjlQAX?=
 =?us-ascii?Q?1iQlRM+Fw4VCFes8vsH4EFweshun4c3SqsbEXFq3HXMw3HUOQPQ0fz7doubU?=
 =?us-ascii?Q?iXPJVRVNYNS9Ou6qIh/rVo4LbdGLhn9z5DwNsqkYfyJ+wO7iIOzp3wxRP2YQ?=
 =?us-ascii?Q?LzfhcHcEfqUr2122P0VSpqyQhsn5wkwdIjDuc9R8sowB34Ol6Gn5/ki64elR?=
 =?us-ascii?Q?astHjEhDSfnubZCTdY3dhpIrwbQibsPEd2sb/IDjYI5GPasJIn/9c2zp9dWF?=
 =?us-ascii?Q?u/Nz63ZpmagZN7535UWtUJpcYRPC3Wpw7+NeOeYpDyjSDLmuWsgy+x0LV4bj?=
 =?us-ascii?Q?5GySxNEaLQlBxJPme2wTuC9G5fY5UaaxXCGZASLHV4m6QiUBJ1j2BjFshTgL?=
 =?us-ascii?Q?77XN6qcovXC1DAK/QAZ6YUTvTS1QbUUUWxdsMx9lRfUwg8Lr8NUhG1k3mi5h?=
 =?us-ascii?Q?IwmwupjYqeeZrf6Uh1bmWIIBoTov5O1q/4PZ07WfFCv5i41N12elMMHhIvsh?=
 =?us-ascii?Q?n+3bl7OVr7sFkZZ1jvFytwjL9d4Z+oV/oPXvduQGCiYZTFcEIHKwWXcObhqh?=
 =?us-ascii?Q?/GAIu0zinCPgvnELdDD8TRuHOa2rglIXPpO6vDme3Qsvoq/uEA5r+VVk46D8?=
 =?us-ascii?Q?mv7cF+MwNmrboPlecKNJCXgTHFOqtfr8opyktoGRvuwk+bqgdNVzcl8rQL/j?=
 =?us-ascii?Q?3VKj8tK00yEU8aqEKJU/50JXRbq0dWHe/e4sPR8BQNd39qg7JYDsveiskCMQ?=
 =?us-ascii?Q?0BWXnjOr2UmZHHzB380kKGE39w8c6/+nyV6CmSGqn+a9yWlHPrPyFmQ1e9zH?=
 =?us-ascii?Q?eldA43wmO+B5B5PjLUhJljY3PuwgfAaVIGx2TifsvxPflwo4E9v5rlLAC3VN?=
 =?us-ascii?Q?kg0eLjBBQDFhG+Ip4nI/2BE/RsEsEl1dRMLkVtTTwp9Ovb8FEGSb1zpnnzkb?=
 =?us-ascii?Q?ePIKmQ6r0Io=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?gUZozCVTPyb6maIeN/+WCvm6X0Tm2LWBCwqLoswyEaWqPhCC382jYrk8P9Ew?=
 =?us-ascii?Q?wFuCu7a3S1bdRpyF6aHwj5pAAwjlsJiSYzLBckUcChFLFmtVkbDcuD9jUPda?=
 =?us-ascii?Q?DiassUqlhpVxM70py4Dyk+YuwpGp4U6DkjW3fS5TFLD6yyv+FJCrLl5MjjlF?=
 =?us-ascii?Q?D/qFV1SdYSuVB5V6zhkwLcxiU2MPaKYhEP9trTTTn6dgL2WTFOWSbAvG+jgD?=
 =?us-ascii?Q?a2ICWPWtoeVa+3BaDzQNCjfAo3NBIvYKWtbAp/DtIE4LkUeddCHfKV/mK4qS?=
 =?us-ascii?Q?zlL+T4BKwUtbwFPOzTwClF/Ed+LHiuPokHBphHQrPQZegkgxzfs7SwOizonF?=
 =?us-ascii?Q?qUaj2fzxBWfa1CW+sgK+qorWEYkJLQGXvMefGUytRWKPNF7QayInp4ZNY33c?=
 =?us-ascii?Q?DQwsQI7FVmVCfOVNAJ4B/Qxqi4BMZ4C8FwzdqlgMzqidxE2PWyL4xrgs0WrW?=
 =?us-ascii?Q?4oW9RJzzHwN48GsExhnteEMoM5u0c1FpJWobMSrHnesvWPmddM2fcHVE8r7O?=
 =?us-ascii?Q?huDoKxFxy3TKDuwWmC9XUrWXnLHX/FkDXtIXB48mghGVkBRVWWm9MHxXzTc/?=
 =?us-ascii?Q?bDNDR7cmBS5F451LBzQ8PO8mnKV5Y0HxWui2P32RClRY62X0k90hAamCV9RX?=
 =?us-ascii?Q?NEjsMQYTqUsgbyr4g+LF4SwACoJK4rlXGQubrlBi61+telg3K6HlyaOTMHCm?=
 =?us-ascii?Q?N4lku2x0XN610EqDJkZvGr8v/Cd0lHctw6gHBGscMoRxkVWLcJS6XKmdWlKN?=
 =?us-ascii?Q?BfwO9REEDhgoMu4QTsmOjz1awgT5ZJHHT5JCLQ/LZbmVxhvGad/rhYB/cPOf?=
 =?us-ascii?Q?GSDubZrkMruJKwjeE7qFLiIw/hnoSa+BDEpbMrP+edDhIaPqRCF+qZquLZwR?=
 =?us-ascii?Q?3ojRhmFEgW6WMN3v8KkDn9wEtj/L6Arzint/qpRiMZ0pEQGZ8rQRIE1uBXJr?=
 =?us-ascii?Q?rCykcOn/fIRggzvdUXrswKM4MsPS+88/XBmL1+9NZSygptVApd//IPL9fZ0w?=
 =?us-ascii?Q?V3Gi1sfV2Eksjz91cYNHbZnOxLXkkhp8Bvv+/7B833MGbH7M/DWrkukUVx1u?=
 =?us-ascii?Q?RgfvpM4LnZb38MTbW5aRS3XY36jrv/RA0tmrXwJfuVmVon0g8o2ib5X7XHFr?=
 =?us-ascii?Q?GCXbxyEEAqTDUS/xPeWlwwJQfVhR3IrfwjFM0aBDxtY8Gz9DksSIimOiZQqN?=
 =?us-ascii?Q?gaL6WNmrs1npimYOoqr5dNIlE1XVF9rzJTeEdiMujtV/g5QA3y+9bLSUgRrV?=
 =?us-ascii?Q?6sSH22z2sP3fRVqoJfy0idE7bqtN0LMi7ja+RIL+/X1UFKeoptryy8wkEp45?=
 =?us-ascii?Q?ntjEyJ6zulPUTeMHCxCC4yzOgRptG35pmp8iR8hpiPUaEKetD7sIZM4FMeyg?=
 =?us-ascii?Q?bN65vsVlyVAjNZLfr+rfmvP6rwlhj97EUIYrsmqyhEBQQYMyXW/vhztyh5Ua?=
 =?us-ascii?Q?l13zjWsSf8Bj+djeDT6S3G1zfGXF+5Wn/IYtn5TYU8vLkjPhvoYueoUzVaOj?=
 =?us-ascii?Q?1nkheGikoeKelSlRbp0b0rS9pP8j6Ux0G4gCwPiy9BVupVCqjSFFhxmTvkXy?=
 =?us-ascii?Q?9RDCSu5vOrQmnBc8cMQZQ86EGOJ+JOhjHXUsjuX4?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06f4493c-a2b6-4876-69d0-08ddae98b4b3
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2025 18:48:24.9051
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A4/AP6yBvBxWHy8vqR0iz4v63dp7dbqjYBWDJwA5B9Q/DBV+mTlI3oPll00GZSlG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8850

On 18 Jun 2025, at 14:39, Matthew Wilcox wrote:

> On Wed, Jun 18, 2025 at 02:14:15PM -0400, Zi Yan wrote:
>> On 18 Jun 2025, at 13:39, David Hildenbrand wrote:
>>
>>> ... and start moving back to per-page things that will absolutely not be
>>> folio things in the future. Add documentation and a comment that the
>>> remaining folio stuff (lock, refcount) will have to be reworked as well.
>>>
>>> While at it, convert the VM_BUG_ON() into a WARN_ON_ONCE() and handle
>>> it gracefully (relevant with further changes), and convert a
>>> WARN_ON_ONCE() into a VM_WARN_ON_ONCE_PAGE().
>>
>> The reason is that there is no upstream code, which use movable_ops for
>> folios? Is there any fundamental reason preventing movable_ops from
>> being used on folios?
>
> folios either belong to a filesystem or they are anonymous memory, and
> so either the filesystem knows how to migrate them (through its a_ops)
> or the migration code knows how to handle anon folios directly.

for device private pages, to support migrating >0 order anon or fs folios
to device, how should we represent them for devices? if you think folio is
only for anon and fs.

Best Regards,
Yan, Zi

