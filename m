Return-Path: <linux-fsdevel+bounces-52630-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 16717AE49E0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jun 2025 18:09:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5BA471885893
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jun 2025 16:05:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4EEA28ECD1;
	Mon, 23 Jun 2025 16:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="OknFkyF2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2074.outbound.protection.outlook.com [40.107.237.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87F2927875C;
	Mon, 23 Jun 2025 16:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750694717; cv=fail; b=no6pFQl38huQtOObFfEIUihXGqeaTpgivQCVXpPTRF7mOP6R5wCIpaA3/ivF36uQ4Y7o4gHyHSVxRsQ4EYOB64Jn32jiZ72lX/pb/IQcqeVMnaKa3gUTp8Uxlyubap/lBBaG/xz0HLacQty9B9UWJJXEag4lvzEYSgZDLsRM2EU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750694717; c=relaxed/simple;
	bh=P0WPMuARHfreyGlunpzNMh6sTZh0X5p27dHvl49qJI8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qlqjgUI228qQ6ZoN5sMXno5bsJkJRmYJibpwP6IY3QC82/dA0Hssx52aKot9L8JPIFEUq/HXXqhBGY3US9Yy+P5OpybDUFyCGP8EmJE8HAZ4uwsDR/A81oHZNCKIqRw2KnFSs8YR4vgI0Pg4p/SZsnmvFbhpPimB0ATa8auRVZI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=OknFkyF2; arc=fail smtp.client-ip=40.107.237.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=amECBPOpWjtiuEpNh6J3E0BY5gP+x4nTyL2/T5jc695xstFph9CZvi69WIbqE/KuqqlderkPrZ2AbSb9Pf5Cs1SciRg/kbNpaUekbiv+ill210Bdkhi5h8QMQOsENfM97IkL3l9uo7LogNgHmWa50C18UNUNjbGMA4ufbWAfpN/oc7BAOy7MZlDQL+6ap7CsRdZDgaa5aXikGH1WcPNzgz9QbqL6XH7svXpy79pmzyRy6YaxJiJniZUbm7Ru5r3O3QSGsjBT3bLLUU+I2Iz2KJzeJMuGGTI065UpBvUsdLmF5L70WFmvRaGF2/CBq5FES+OMkL4Ye0ATqFGujBmAQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AoiAeg/yVYS1Zt5MTTHJYSmM9q4nI5TTT0pYf4CDJrg=;
 b=rdir9vJf0TwbzJFuO7kMd0Ycqi9pb3GYkb7uRSaWEGXxNHOjqz132FGPS4QFTiUScyC+i/y4vkkBCo5sWsvSsoLJO5qUp6F8JK72GmghugOjwu7WvTPZS9plfc1KiM6+3oaXOTaATyeRPw5vTVBx/RiCZIMaqQDD4y1PoOsj6VoVtplPg6I0vw4YgCTbHvPl7kpKMbte7X110AOH7ycv4jZdNi6fD4CHoEXRhCTbK3xwoJfW4nMp/VdpA5noQIQ0mZMFIk3+bXdQZR8YNk6IFs8F7G606EKoBzySFhMfq0X6IN/Pd2m+xheWlDJszjJwI/f0imFgP57EeqId24dkMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AoiAeg/yVYS1Zt5MTTHJYSmM9q4nI5TTT0pYf4CDJrg=;
 b=OknFkyF2TPwRQisDdwSxWafPFn6RsvPk7zxZLYCvqrInZIlf1nQp8s2N0Lh9/m1tsLobsFf/tbPftM2j4eP/qfPKd1kGT8BzPEJRKxAp7Zez9CLuUUZzbPjnbhYHP4PlyMgJa98+XEuNDEi0+Oo2qddHrQZ3hs5qWjnTbczCE4RKHVKV+yzkjgTPvXvdJkh+/M5QtmMmhuPMUwKEv3YGhc/jmjgKucYRNelOWHyrtoDDi0s38/N3K4prF8Yn1uZfgaUEbXcC648nzB+KKeo6wBBQYULXzOXJzuOAWyE1F01D1t1lDS9d2RCfUkvff6lvDx4t8meuCgOpmfTvMMiW7w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 SA1PR12MB6971.namprd12.prod.outlook.com (2603:10b6:806:24e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.27; Mon, 23 Jun
 2025 16:05:10 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%5]) with mapi id 15.20.8835.037; Mon, 23 Jun 2025
 16:05:09 +0000
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
Subject: Re: [PATCH RFC 16/29] mm: rename __PageMovable() to
 page_has_movable_ops()
Date: Mon, 23 Jun 2025 12:05:04 -0400
X-Mailer: MailMate (2.0r6265)
Message-ID: <DD051CFE-9B2A-4140-9D90-8B3F8C8D80FC@nvidia.com>
In-Reply-To: <d6208fab-9ab5-485e-9cc3-94256fef2e1b@redhat.com>
References: <20250618174014.1168640-1-david@redhat.com>
 <20250618174014.1168640-17-david@redhat.com>
 <DAA0D876-D5A4-4E54-9BD3-363E34D8B3F3@nvidia.com>
 <d6208fab-9ab5-485e-9cc3-94256fef2e1b@redhat.com>
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: BL0PR01CA0002.prod.exchangelabs.com (2603:10b6:208:71::15)
 To DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|SA1PR12MB6971:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e5b295e-0867-4fc4-0e05-08ddb26fba25
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|7416014|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3L8+d3mIbajIo3sltLLCclTqGg3hlDU4taHzmxLz9gV6rcDmH7ddRRZP/Vts?=
 =?us-ascii?Q?qpNkoNElc5lqrIxt8HO23t6r6/8S91UHIVwPEEL6iFHcyHuMi3PV/7QIHaP2?=
 =?us-ascii?Q?PG2UWU0sg0GCimqUFA4Vx2M7FFYdwmrvF8vcazCXaeAnGpoYMBdydGod6TPT?=
 =?us-ascii?Q?YPmbrbAJ51aTZ2401XZfz+91ld0l9K1utrwpD8/L5YXU7tJ0zstuL4GBeZ/C?=
 =?us-ascii?Q?AukwkNvlfjZ17IwsDhg6KVkLSQkwzYWniReGG9dwkVn06YrgPXsmHyDLqU8Y?=
 =?us-ascii?Q?5z5ybsaz0iikHdztYpcslk34o6co+SIeppvZglZQz1FGPMAebYDVNb0WiE3B?=
 =?us-ascii?Q?TNwBuxDM93FClcs8Ih5eJUzTtITZH/TserCjGQUvwF4fkq9ilH5HZIhpZU/9?=
 =?us-ascii?Q?ANe7Pu2AsKibDOelNmigb7USc6yX6xCMagQbJTm1Y/btk90ZfOyetRS9kwX4?=
 =?us-ascii?Q?EPccrJoEucUBZFJZDL4FXWspc+6foQMEMNrDFPvXK7ckBYFbsVoOTl4iX3kt?=
 =?us-ascii?Q?bDB7Ucy+Jc6Mqq+Vfy80E4dUpoopOi00CagfZYWs2U6j63bPOrR4UKaHdVIl?=
 =?us-ascii?Q?xN5jfVvxKf3xOu2AgFhKA30bC+yeTeL3/eJTPqx464aCSLdr0hcKmLpqNtL0?=
 =?us-ascii?Q?d/CuDol/nv8lJxwiue82l5NguvE9KglmocPI9yTjOUh29eFRT/9hEpmPmxgh?=
 =?us-ascii?Q?es2HuT/xnuVz5sK0dzVgNBmgRbhNYAmRElK1ZI6F96AnMaG21VbZgX7dfi+5?=
 =?us-ascii?Q?AGNdzYifNgwHgLEfg7C6du7jmSQHpofWYGl944ULwcCvh3vOQrYgu6sIdgmx?=
 =?us-ascii?Q?L7gfXd+7jicbUTkgrnIHTYxbwlr/Szj4J6G1aJUXltIPHaw6EeuXicrdxhzC?=
 =?us-ascii?Q?Fd6Kgn9zGIzR7fQPgpIzkzKWaAUQuj1LmfQd1CO++j+p7zMak+Zi/+zWg9nn?=
 =?us-ascii?Q?qnLRFxe2nRqQbJwOlLzvRAdDZk1Y38m4wGkJghzwREbjQ0SzZNHMra3Ajb4s?=
 =?us-ascii?Q?yBdy7VVjijm+7gYn0sw9jYk1/lKzlJyMxVhRN4ap+yrwRepsmEv1qO/zwOW0?=
 =?us-ascii?Q?eaXJe27BrXmlP9A1l/P2ypAqG462jJTZDLN5BGw3BWJjE7zYkPA668yhZDaw?=
 =?us-ascii?Q?md6WYeYukbX4cprGC1hnndz6ZrNrhQXUlE2iisMzcsoL8CvsE6knWjV/C6QK?=
 =?us-ascii?Q?/lwZR8yb+79l4htNVw+6v+ekd10kDVe7uGTn5aI7fS11vIaQERxg6JMb9EcU?=
 =?us-ascii?Q?/+/z3BXgucRNS7vf9wVcIMqV9YRU3P/q0hCHLSd4T0gVtf6nzLQ+eYG5AmZE?=
 =?us-ascii?Q?BSAhslBL2qZx+81NFMpuoJjGx2pjSoNlZrr2Y4+i86NpmpXkZ+lq7koIVof5?=
 =?us-ascii?Q?RFk4YoKmkJY7PNAj7+wNf1tbweUP1Lc/ohPeELeDvgrMspWSrht4L3M/KFU0?=
 =?us-ascii?Q?46Zg660zcGA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(7416014)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/XwGD5uljOG5HXRnat087Y1NtSVVHeBgV9GncZaoi/47ncYo/hPu/qFOjafW?=
 =?us-ascii?Q?+ONi5axEpnfTRHYNyF7L6vYHl4AXuortWCFhJYk628nETMCGzw6VIWaaYbJN?=
 =?us-ascii?Q?cGFfuN3DXIhTJXUFx9QGloNwHFcWweoB7cT+XYj6NqC1GC+u0KnjDr8hozF6?=
 =?us-ascii?Q?QpngJe5FSgcVkN8vxXrXyN0NAL5fLlcHCePp0ZXHjtYhstbW1RCyHK9EA1LG?=
 =?us-ascii?Q?Sk9IGE0LAQbuxaLJ0cPwGjXzVN1z+0tNR4tS2Vf9EnzRNvoVYu1u4dzdV5Bg?=
 =?us-ascii?Q?XHr2YbVxPBHyD8u0Iq85beWLFyjXTQgSCWoRLXZrPlHfH8rsgOsLVSt2nhig?=
 =?us-ascii?Q?nebUrL3DKo4MNFXlOMuPapnlwRcfGTAm5uHLrEaGIt8YSXtncQ/RHbTHuw+H?=
 =?us-ascii?Q?pXOLlgMw++DGsKte861UDWHLEoHao3Bez2UC2Kb1hJu7RCso3nvh28iyNE0A?=
 =?us-ascii?Q?galh23X9OJQQYng5VfrnXu+ka55kyyKsgEeVTmOFTm579ojP/UFvO9M2gdPP?=
 =?us-ascii?Q?rr0yOci410yzAvKGAsgvyW5IMK93Y+yaT2Bjgjkoi+lNBmtBgnwmg9tcKItW?=
 =?us-ascii?Q?tG0MVyofRDqywmNoCYjPin97z+QV+qOaFH8FWS/zZIKvurFPGccsTlwt1kPH?=
 =?us-ascii?Q?z+59OwSz8RJk3sRtYoN9zA8QKK/KI3s9Zdo9MHl4C4bq27uigtxbGqvZg/zL?=
 =?us-ascii?Q?gCeKxPJR3GTimMKwRlrX9zRa9rCRq3KJnobcnxfOLKuJfoD6yBT7Bo6meRf9?=
 =?us-ascii?Q?VI7vE2nEVwJBOa5dK+gcPxWu9/7T2G/OQFUYDPGVhgmgE4IbT+vWd1XpZnY/?=
 =?us-ascii?Q?rlUIL/KEURGxwEfjOSuAY1ZkFiNpu+c9u2GAEl64XN7xIyEc7N3APHyXKQuY?=
 =?us-ascii?Q?tCGpxZzDaolZKyTZtbj0MGtD7z/PU0qi66ScauSl21pfGMVDitbyPg/bdLua?=
 =?us-ascii?Q?0huSOamqAXedWfm5A7GNyt91CVC+dBxgFgkWJ5OkprWy3z4DLV1+rCNrVJFc?=
 =?us-ascii?Q?SmAR3ncI54iX0rO6eW5MoQavZyo7LRVX/MFZdSdQF7d/8dnHDAs8GQ3ZvuGn?=
 =?us-ascii?Q?kgv8FZ3PdPo3JMvz5iUlDPxyDf0nyratMX5oh1JcA7fvRZS5220n81WO5xo4?=
 =?us-ascii?Q?yJIerx+rrFrpZsaHiVKuD2p72kRL5P/0PvdCFoijw8o9u6dMe92Y2d32dL+N?=
 =?us-ascii?Q?wdVzsU00KdNLFy1Jyp4nyOG5KhmNa1nUiR52sQxXKwdiS+yWhgeFDlMwCEAj?=
 =?us-ascii?Q?AUjqW8Xo7aBsKubZdVSqFByNGpF0OfWXn5fRnU2oiDiBKbNQdkpAeEhjwPgZ?=
 =?us-ascii?Q?Dag4w2LEJNGv7mVqHXg5RBCV+WPH5lOjz6xWpouJLaQRVSCkkyDIurldxvFE?=
 =?us-ascii?Q?NTUiN3tpOKZ/ki64Dy0UZLE1AGfDK7YXu8DVVGZc5y243nWCWJIIwAwJkDtf?=
 =?us-ascii?Q?K+BFyGn1exD1Q8HAGiDQOaIYrMHW6ghpwvxhl3Bm81ehVlD+YmNRtej3RRsO?=
 =?us-ascii?Q?1qu7eg7SYZclGFEeocFTVKTLx9Kwc1VFPl5Oe4NRJtAePbIpqRFAhvxaUHzq?=
 =?us-ascii?Q?JqBORKzZUXGan4gJ+RgBF0x5/lGjGW8IM9ek8aMEbP+wSE70XSg0VeluXVq2?=
 =?us-ascii?Q?25/WGWOS11ZD5vv1y5d5j37pSdnnOEyoYd424bu/uSSj?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e5b295e-0867-4fc4-0e05-08ddb26fba25
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2025 16:05:09.3079
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GD6N2N2oin/HBSTQLlHJ33NcCdwqm8u9m96pYzdI8Ey1qCUR6RCIn1MP6bIy/yF3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6971

On 23 Jun 2025, at 11:47, David Hildenbrand wrote:

> On 20.06.25 22:37, Zi Yan wrote:
>> On 18 Jun 2025, at 13:39, David Hildenbrand wrote:
>>
>>> Let's make it clearer that we are talking about movable_ops pages.
>>>
>>> Signed-off-by: David Hildenbrand <david@redhat.com>
>>> ---
>>>   include/linux/migrate.h    |  2 +-
>>>   include/linux/page-flags.h |  2 +-
>>>   mm/compaction.c            |  7 ++-----
>>>   mm/memory-failure.c        |  4 ++--
>>>   mm/memory_hotplug.c        |  8 +++-----
>>>   mm/migrate.c               |  8 ++++----
>>>   mm/page_alloc.c            |  2 +-
>>>   mm/page_isolation.c        | 10 +++++-----
>>>   8 files changed, 19 insertions(+), 24 deletions(-)
>>>
>>> diff --git a/include/linux/migrate.h b/include/linux/migrate.h
>>> index 204e89eac998f..c575778456f97 100644
>>> --- a/include/linux/migrate.h
>>> +++ b/include/linux/migrate.h
>>> @@ -115,7 +115,7 @@ static inline void __SetPageMovable(struct page *=
page,
>>>   static inline
>>>   const struct movable_operations *page_movable_ops(struct page *page=
)
>>>   {
>>> -	VM_BUG_ON(!__PageMovable(page));
>>> +	VM_BUG_ON(!page_has_movable_ops(page));
>>>
>>>   	return (const struct movable_operations *)
>>>   		((unsigned long)page->mapping - PAGE_MAPPING_MOVABLE);
>>> diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
>>> index 4fe5ee67535b2..c67163b73c5ec 100644
>>> --- a/include/linux/page-flags.h
>>> +++ b/include/linux/page-flags.h
>>> @@ -750,7 +750,7 @@ static __always_inline bool __folio_test_movable(=
const struct folio *folio)
>>>   			PAGE_MAPPING_MOVABLE;
>>>   }
>>>
>>> -static __always_inline bool __PageMovable(const struct page *page)
>>> +static __always_inline bool page_has_movable_ops(const struct page *=
page)
>>>   {
>>>   	return ((unsigned long)page->mapping & PAGE_MAPPING_FLAGS) =3D=3D
>>>   				PAGE_MAPPING_MOVABLE;
>>> diff --git a/mm/compaction.c b/mm/compaction.c
>>> index 5c37373017014..f8b7c09e2e48c 100644
>>> --- a/mm/compaction.c
>>> +++ b/mm/compaction.c
>>> @@ -1056,11 +1056,8 @@ isolate_migratepages_block(struct compact_cont=
rol *cc, unsigned long low_pfn,
>>>   		 * Skip any other type of page
>>>   		 */
>>>   		if (!PageLRU(page)) {
>>> -			/*
>>> -			 * __PageMovable can return false positive so we need
>>> -			 * to verify it under page_lock.
>>> -			 */
>>> -			if (unlikely(__PageMovable(page)) &&
>>> +			/* Isolation will grab the page lock. */
>>
>> I feel that the removed comment should stay, since the current comment=

>> makes no sense when I read it alone.
>
> Well, talking about the page lock is moot either way. The thing is, any=
thing can change while we don't hold a page reference. So should we chang=
e the comment to
>
> /* isolation code will deal with any races. */

Sounds good to me.

>
> ... or drop it completely?
>
>>
>> In addition, why is __PageMovable() is renamed to page_has_movable_ops=
() but
>> __SetPageMovable() stays the same? page_has_movable_ops() and __SetPag=
eMovable()
>> are functions for checking and setting PAGE_MAPPING_MOVABLE. The namin=
g just
>> does not look symmetric.
>
> See follow-up commits where __SetPageMovable() is cleaned up.

Right. It becomes clear at Patch 20.

Reviewed-by: Zi Yan <ziy@nvidia.com>

--
Best Regards,
Yan, Zi

