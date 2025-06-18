Return-Path: <linux-fsdevel+bounces-52091-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A487ADF5E8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Jun 2025 20:33:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA6F21898BB2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Jun 2025 18:33:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D6762F949B;
	Wed, 18 Jun 2025 18:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Q92P8/kW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2069.outbound.protection.outlook.com [40.107.94.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 290A52F4A1A;
	Wed, 18 Jun 2025 18:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750271550; cv=fail; b=gyQpnL8ZGEw6o8WQMwwoxSYsWsU2MJeVHtoKDAQhmNQuyaAKVxEjzMdM4A9RE+22kj5StTLFP2l6N2CfJfS9zisO4ztwzfOICTgvzhHHltmCKx2W8qx5C6LsjuDaOXoMJ9auwzzqNRjnbFTXiXZpUvcdyBgHFECzY5ucppjKC8E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750271550; c=relaxed/simple;
	bh=p8ZB6ZEsIaTeicKX7APyBRBnbaNNE0sMWXjIs/XWS+s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=S+imRhEqF8fRQtnimEHw30qkFczra7viPN5irox4MKR8T991/ko94/YEVe+Tc9wDo4UU7i1dQrOcie+rHiCFHjDk7606rWbitQazW111V+RlGYO5l0v40Xc9nUfEXCi/YM9UORpCKvJFw+6NJW+1jYV0CZekARdC0USsu3U98G8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Q92P8/kW; arc=fail smtp.client-ip=40.107.94.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qB+Y0SXoZtOzONFgndzNCbI9k6tugEQdawww/tXWGti473QNy94XVTZPFREboHhEurF3KwrfnWMY1QV3uhFHheELSr5YzheR2FZ3C77dSrvLxc6SeJuzVZr5hEsR9WYMkY25aCah21fC93x8yjSNFtc+M/8q2/Y24ck+1alnNGw/FdTMD3fsTBKje3esh7o1vtUSqr+J5Y381ES/KxAh+05DT8uW+WNpLL7d0mnvxMeWk6Yq6wTtSZd1LD0BBewero/GdkVcFJaNFgE/Js3ca3u64CTl2ho/Di2B7Rm77BP+wlSsrqrNpibdSD1blkXEhfo9RjY7PkSxO31VgWn27w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=81krn+59tOTKbL5GPBiMr+NYgG6giE/kZjheAbqXnK4=;
 b=zAVekdyaQtvQeau0/uvvb3Xi3sEPWs2UV7u3RVkKSDL6LL0cLjVp0eLi0LsU8eyXLzRhunJYTw9aNExnVg6eDiY7TVMIsqmFKUrGtk4vMDUNxv1w7fGv0oyWvFy0vCFEpNKjPlGMkuTqxLMgoJFAPLtW4RIN6hKNx9Rmuv2JxJgv6ZZkSLIVJiqMLgTWT5KxxD6oPlER3DxkO6rkk4+1AViqLgfHu9ClV64FntNbIoNG3XFIwAuNNhJia6p13QC9QPIT59v49hQfTtDyBee5UYMPzvteB6Gq/c5EsXhoN/D7tpxjbDBjZmiiD1RN/bLTlKPWVYlMdwd4qYRJPD+DzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=81krn+59tOTKbL5GPBiMr+NYgG6giE/kZjheAbqXnK4=;
 b=Q92P8/kWb12fVWHacS4Osd7SqMCNIgIFGl3pi0NzsQL+iVZDUOhxDzul+8fOULGq59bE2WG1klEJAikHEXWz4F2VQgs/B7kHYLjuLU0tOKONnCh/cfODm5wQnQAXqPUZAKulTymV3z6wfVDM6eErtxUFHvcFIOCR1GOCUsTIK8XLBPBJ2EE7Ghvpqq1IRukkSSg4ZdXq8Oe4yEXz6uSDbegZoywv3ZTGHrNJBfLZuknqRj3Jvt7FrTbLabiwFVbAydFYLYgDZwtgS8vCd+DqocBgpnbX7+KOUolmEqCsy4tVPHB43nVh/LpSyEv6CmOO0tw5BzSuWdAOcYPpSauwVA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 CY8PR12MB8244.namprd12.prod.outlook.com (2603:10b6:930:72::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8792.40; Wed, 18 Jun 2025 18:32:26 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%5]) with mapi id 15.20.8835.027; Wed, 18 Jun 2025
 18:32:25 +0000
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
Subject: Re: [PATCH RFC 01/29] mm/balloon_compaction: we cannot have isolated
 pages in the balloon list
Date: Wed, 18 Jun 2025 14:32:21 -0400
X-Mailer: MailMate (2.0r6265)
Message-ID: <F0624D53-D30F-4DC7-A09F-4699BBCF2C44@nvidia.com>
In-Reply-To: <20250618174014.1168640-2-david@redhat.com>
References: <20250618174014.1168640-1-david@redhat.com>
 <20250618174014.1168640-2-david@redhat.com>
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0234.namprd13.prod.outlook.com
 (2603:10b6:208:2bf::29) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|CY8PR12MB8244:EE_
X-MS-Office365-Filtering-Correlation-Id: 3fcb684a-a356-4a38-fa20-08ddae967915
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|7416014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?igGELBMsh/s4hQ7J3v5mbuB+tx4+GN3AEEWbQfpAdVQMNL41km5AWoI5TPkD?=
 =?us-ascii?Q?dJs7Lq0qq0L7cLJwT9oTaqYPy5n542LZ7jfaakOWF0hPjS81JSnfgYGLx6zx?=
 =?us-ascii?Q?g+UJffG58kDtnwf3jofsJodUcgLmm70bsU6LRxoFwIwYCZ6LlyW6aFZRzD5O?=
 =?us-ascii?Q?pd9AvC00UF7arsXJlVkfDj3EL4q1Eg3ATaGXKoDG57ZFPrViUsJS9NHx0Ifl?=
 =?us-ascii?Q?XuKlJVKHvpdm2mfVUP5UCPzuiGvnzZ/TyJhAfIO77knctkdO0DbDnYZwxxI6?=
 =?us-ascii?Q?WXM0zFiRz8vqU85MmxMlqRnvqC/CVsufK0kAbhK6ZsShHByLGA3WyamGwgOM?=
 =?us-ascii?Q?LYw+zJHe0Ef9BL8X+Rs6dXMjFMZojm25iTqZrRrq5CfuzM4YJE5DRo0HcGsh?=
 =?us-ascii?Q?Ldce531OmYYrHiI9uQpXhlHY6FxXp6KDIKelyhF33J20W56HLH8GUHHFZbRD?=
 =?us-ascii?Q?ws0xGVv2twrW7gB9ycOheCDMjGP7lH+hWDRMklyJpIbc1Bt2qAT3kt/knoe+?=
 =?us-ascii?Q?zNhYQDOiza2F2Y/FCObO0BPFyx3kibwrUctnBQSgnfRehdBY/moFgvBZp8ns?=
 =?us-ascii?Q?hCvtREoF0GAdRBH6li6r27SVoaxh0A3lAsNZLlIGlVhGih6kbgR9BuUE+wX/?=
 =?us-ascii?Q?itEXjf85HgZdZqZX32hYahv1bRIQJeKTh2UfxuYIlrcjLuxJusPrUC1mvlOh?=
 =?us-ascii?Q?lCeGBME+giOF+hLEItSrmBx5iGJ8stjJFb548C8bpOlmDI4j+eWatItWJ2pD?=
 =?us-ascii?Q?buRwG1LzgddArkHl7QV4QRXGoXDdG1AvSPimqEi5QK2QKwabqoBkL5q26SF8?=
 =?us-ascii?Q?sgkivMxvbfoY6yncWeq9BX2Ruuk1MZ370lPKvFLXbIVvhuaAtJmROfR1HK0N?=
 =?us-ascii?Q?OEN44PmlZxq62abDuTbQveypcchSveiSyKeg+KpyiC2j5uymk9MGVTNlvjnA?=
 =?us-ascii?Q?jfiYRDyvjn/MngMKSLVuq+JWCnjcS0dN+4ozt+zY6a/qfCwlDabjOk0C559Q?=
 =?us-ascii?Q?giiErEKq5KzPXda2yKNg+yC9fD3icrwCNvJxgz3BWmlnoRV/nOb6YMJcrdtU?=
 =?us-ascii?Q?knJ7MPArF7aQnxGkHS89p1Gg14q7FahC9Qfzq3UcoNZmq6hP4FL+Zddzfq/J?=
 =?us-ascii?Q?hwJs91ejlFATjdYSQF6xzc+STcdgR/tTJNhfxMGhh5ghERjDUj2eFPQXpgff?=
 =?us-ascii?Q?bp/hIGdpP9L7BsrlMqXPABdQp6FF8M3JoEOIh/4dgOYxbx1w7d0bQ19do/1q?=
 =?us-ascii?Q?CQrPwmQ0wPdwqjjpEKUds77p0KXVyfxJEh4ppXnNO4R0svp+Z71wNwONKq4r?=
 =?us-ascii?Q?2tW5YWb+oWxgeRsr8nUcS4klsetGBYplgOe1Od9AiXWC8CjmJE/6tA8jJR2y?=
 =?us-ascii?Q?LedjkTBGT6qjd3AtLdq8Ew+4/3bpT4atv9tlYwYBN21ICORlZmUXhihSLzcl?=
 =?us-ascii?Q?1pWtXG8hwec=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?JrtAFXb1Ditaau+l7gHyW5gvrkxTPeBveT+Q5UL60yvpVCHxxjRGZdOBFlx0?=
 =?us-ascii?Q?jgW5RGbbgpr4Gyc2cGnIpCm8ATsweioj1ed7iz7rJg7D8lnZOh17MM/koLw4?=
 =?us-ascii?Q?XoUBc/07gkPdM+ABhZAAAMTjrcY2FSDLvhX+kUqkV0aUsrmpsmnG4GJhGDbY?=
 =?us-ascii?Q?cbpJuGp6v/+37DN5FVItOVIWcR8Ybkbt9QeuBqnx7oclmHmi/SMz1OfDwF7M?=
 =?us-ascii?Q?D1n38iZp6Pt2vQmRaR0oYF1IAA3JoX3jlruvF/cki/GZY+DS5gRuGoASkj+J?=
 =?us-ascii?Q?hfziwOlbTuZ5HjgPgJsSrD941CTvMldXF6SaY1RMghcGgeX467TQLxtZJRrx?=
 =?us-ascii?Q?c4YGkXDKQf8Pk2jgqyhGwbIzf1QxLBibxEbYOKmgFp1gvfBCqSQkHIfc0bXA?=
 =?us-ascii?Q?Mu0c1deTEfkQ2zsjojVaC2NOhL66GjNvV3/OmDpElGK3D3hxDy8GQYi2mUSg?=
 =?us-ascii?Q?w4iPz8cEku86xcV156oVJkqdrvF8L47DKmoB6fp68xIeq1p4l2szQBYyDts6?=
 =?us-ascii?Q?h/6JVguQOgOf8/Tz95dAoIE75N09Z4RytY9fxF30pBs3HZ8vIw/56dtUe7yu?=
 =?us-ascii?Q?2bZYEO+5hFcYXnOuHrjOsS6NtP1OL1wo9Ee7b9jNpWOg7EqeKr3QBh7bVjhl?=
 =?us-ascii?Q?NDNImTJ4Cj5VjDwnke1XiOjxo5aWwbMP+mnjuOUTzPS8//5oZPUa1petip9R?=
 =?us-ascii?Q?95FYu9zeRMi8iapHtmW9mzwkpRBiKVz9oAPtnBUCr87sH1xms25oakC7Q5RS?=
 =?us-ascii?Q?tauxCkPXkriLopH0pwk6Hj2Sl7FbtZCGluFfcKJH2QRPOvqVmWHAAn99izOf?=
 =?us-ascii?Q?rsU0XV2p3YNVVZTMRh189ikQyNE2ST1Ld6t5hvfGzmJJ3+/UYAXHIh2GRUaG?=
 =?us-ascii?Q?roBk1jAhyBuOiMBek2xX+FeCmMtYh68IrOnZSBsl/1PzX3HLPV7D1MkTNK2p?=
 =?us-ascii?Q?su+Eos33IF8l6Brq6lb5FpTsjC62hZFg9ErVtFm/gtlzP6ozlU92uqEQYkWq?=
 =?us-ascii?Q?fN/YZc7ZQyGJpYz5bO5mNTqr0bfIdVVKsrYMFFJl3ToF9IxenubkJBHVwlqB?=
 =?us-ascii?Q?0TzWq+xDbX9R31Rh1Y2+KczNxPMMt4PxRhWGoGC+AbzmhWU4a9Fi14D2T+9M?=
 =?us-ascii?Q?UkmfSEwldMuH1yOXF4x1L65Flfxxpt2HAgszL6A77vn5zmgLkeIS4eq8CQgx?=
 =?us-ascii?Q?iaJwK2kFBf5IhguUFgxNsFM8M8R5maeIQfLheQXPlpUrm6NkTst//OWo99tC?=
 =?us-ascii?Q?NDt73QOvvAacUGaitq5oze2wbB4h9IsDP+QQHpKzvx5d/2ulsp1eYqSLX+iU?=
 =?us-ascii?Q?MQTWWsro2CUXlAiQYZedt6MVIEHbKlFugQ8lYACdNG1+2xdCUNpi0raMUgJG?=
 =?us-ascii?Q?5yUDcYVQThuQDSsyC9HtMbh3SN3mGl0VyUKH7rTTDg8sq8RmKj7CDK8pv/0l?=
 =?us-ascii?Q?NTv21/udXDnxvemEUekcP91oEj2RqOT4qKKKjKGOO6GDibNat1wHvoVsvvh4?=
 =?us-ascii?Q?q35ZXbzBeOCzMtwgQvATRIjIFYY2PpU61WIxyvo/bZgg8hT5bXEUiUtDHR9u?=
 =?us-ascii?Q?F23bTYp7BShAX4VXh0eEjL5ZoEvMdxhg/eqyN/5H?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3fcb684a-a356-4a38-fa20-08ddae967915
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2025 18:32:25.8922
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 76M7PW5Te3zBF2FaeD7MQ718xu5eVldtZEFBSMX/JnEC34LFvlQyH/uWjA3MT4EN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8244

On 18 Jun 2025, at 13:39, David Hildenbrand wrote:

> The core will set PG_isolated only after mops->isolate_page() was
> called. In case of the balloon, that is where we will remove it from
> the balloon list. So we cannot have isolated pages in the balloon list.
>
> Let's drop this unnecessary check.
>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  mm/balloon_compaction.c | 6 ------
>  1 file changed, 6 deletions(-)
>

Acked-by: Zi Yan <ziy@nvidia.com>

Best Regards,
Yan, Zi

