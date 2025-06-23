Return-Path: <linux-fsdevel+bounces-52582-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19623AE463F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jun 2025 16:16:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8DEEF7A9FB5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jun 2025 14:14:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38D22257AF9;
	Mon, 23 Jun 2025 14:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="poiZtFAJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2059.outbound.protection.outlook.com [40.107.243.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF611257AF4;
	Mon, 23 Jun 2025 14:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750688065; cv=fail; b=XvqF0BEXm1BDjZjPn9mMgttK1IjBbOOodTYbdu7dWVUwLjaZ++sNxwuR417NXjYnaERGjhisOIcmNkfDRDkl7n3Q6DXCZ6Q/4j/ebMNOtHzDO+z1f4WproD5la+A0l4uKFBJswjqG1DY1VfhjRpQVR5xkkn2o5drJHqQ+BDFA+k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750688065; c=relaxed/simple;
	bh=LBB8+gwmtqpAAOOyFxKMZD79cXmSRZpRoN5H2ZVXV1c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ALfMBZ6H97R99kPvl8QBbQl9hufLyCqYi3H/rjvcjvsFJ8yCvi+K3IPaG1qUWCs3Jx1uFUOd0K82AIvERa3dduTcXLTG+wjlG7mh1bkBuruYEv8PwSeVlOJlRLI9O5ciCMrEGRW1AuKo0WXvKpK4r7TynalucVWnQwUmu/6r1aE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=poiZtFAJ; arc=fail smtp.client-ip=40.107.243.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Rh94NNDmsGNCwBHDIBVxK7j/X3vkCNLw99Vm2CGOdIJiuqs1i23xpweg+hFrIa6PapZ/VUZcZSrg3Tuw7dIElDJc4ZgSclvwv4KMNkknWwXUexIrQTtS1sUUd576PPQ444J8TXM4q+tNtFQ1miTH/L+xg9Ps3UeGsUVGKGIR1o4UFX5C713Zh45UlU1b+uKjaSDJg/ULhN24TqH/Eeifw/0WsFrNHPlprca7b8y2rXJQgBTXXTzPlMEbf7cYh/cENE7c47KJv4S0/K5RouXgaFVT30ggB2WLXa21xN7L3rci0JworWIj6nsl0/8LXqDAYAu5URogs+MZNEKbidx7uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lHbd8KdKQ8/qaS5r8HU31huX0qN4EDkxFrBmHxEDKCk=;
 b=W3d71nnmtcgAXZHooMEdSY3WQSd78g7/GMsHVmRATTwSYBu94QDJ52tRVz/6m8QgFggizbsLl+KaCeX9KG6JrsP4hVxGI+dW1oBUM8YuQrRfdBTYAC1NN8vIxk+ido/38V9muQ72tTuOK6O96EdOmSYsNX8mFETFoPNx6P+zn4sFvPwKXKA9ndFETv+7JiIx3E4BhZ2oFU94f1UR1G19/Xy4R+BcnotwijGkc65vCF8pG9i2axvP3GeI/XOuD63JhROjxpOqELDwMsfsuwmceOgyIjS43SXJTDIT0jf3D0UjUBfRDh9BT+GlB0xjqYdj+MYoPaEKUd7YgiFa6EM5qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lHbd8KdKQ8/qaS5r8HU31huX0qN4EDkxFrBmHxEDKCk=;
 b=poiZtFAJ9KXMRsuxxHzE+e1J4XBhUFyRRJ2NE6fZ27MIZtdNjaIFF5sEbiHb/ER3SJjMcDvJoHNAhd7ExKLrTgs57ekecV/iwRC/0tpsIB4E8VgztRklzAsq3NbD7KjJXXlUzGiOIDA//tiwKmOxrlRArwJwqeRHeNxGk+cC16Tp/NwkX+80g44WpOVIcZgLGQl8KakQLwI3tQAjd4x6YdaHoZOktjeLl2ygPKPmh+q5v+EBTnMEgWbS5u7m9v5p8HsPOwDNGBv25d7BHqCqe4gVFBbsGBLnwrwpRHFhRcUIyA8fBQa0E1LJdJj8UgmzxqYYiu2WszYShXCQrZkNnw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 DS5PPFEC0C6BDA1.namprd12.prod.outlook.com (2603:10b6:f:fc00::668) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.28; Mon, 23 Jun
 2025 14:14:21 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%5]) with mapi id 15.20.8835.037; Mon, 23 Jun 2025
 14:14:20 +0000
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
Subject: Re: [PATCH RFC 20/29] mm: convert "movable" flag in page->mapping to
 a page flag
Date: Mon, 23 Jun 2025 10:14:16 -0400
X-Mailer: MailMate (2.0r6265)
Message-ID: <2EE119E0-C71C-43C6-A445-E9CB8AAA86E6@nvidia.com>
In-Reply-To: <20250618174014.1168640-21-david@redhat.com>
References: <20250618174014.1168640-1-david@redhat.com>
 <20250618174014.1168640-21-david@redhat.com>
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: BN0PR04CA0126.namprd04.prod.outlook.com
 (2603:10b6:408:ed::11) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|DS5PPFEC0C6BDA1:EE_
X-MS-Office365-Filtering-Correlation-Id: e4dcef0d-7532-4537-a80a-08ddb2603f48
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?OeuK5CxGCS0SmRlo47x29J0CUcs9iryRDVy/g4U29B69DKo5NDf32ja50W2O?=
 =?us-ascii?Q?WJ8k6FZ19jlvjuPh0faQTTbi2MglxfW8g7wlmwjBqTMc58UJVsgzC7Q8Id9h?=
 =?us-ascii?Q?JdtVJLYyZfhAI/7SjscHuclyuoOS+DioS5fBrCu/8h3VQdp4KvAAl7/vEK+Y?=
 =?us-ascii?Q?QsZxclOTg3rfhryeHzUqfzHBHKXkMcL2X0bmgFiC1cFBRAIVunyz5LEpF9Qr?=
 =?us-ascii?Q?0lvGiC3rJszNOT9arRwsXmFJMeg9ilSmbt2uiriKrfIXAFJMrNLbgM4+Gok7?=
 =?us-ascii?Q?tQaEQ+gvg8XP/gdzehxDqTa32xpFYZU8IDOzOSGKfuay/t51TE5gx293JWfO?=
 =?us-ascii?Q?x11Aw4AoBxc3VrKvkbryjto0+aZx7WJQ8hxLD13MXuu1cKtSG6nRBrlOXLRn?=
 =?us-ascii?Q?0/sKZ7JUlYqAL/jgY8djN2xc8Gfj59XH9pQA5ENpbY0yFw3zCsFQAL05IK9b?=
 =?us-ascii?Q?fuPLaccW9KrI4y/nJVPjza77cgn8sZEHPhTNVcTJhL2Ry9xFXC6/rKvteSTo?=
 =?us-ascii?Q?HmY0j2y1kvwMPN/dRCOh0hj9fiqQl8Eodcdnkvboup8gO9MY3r3NZ4KsfkFM?=
 =?us-ascii?Q?xWMWjTOXWM7wO4y3glh7kFeJ4UGHdm0GolcSEsPCpumDTz3OWNiArv5+Egba?=
 =?us-ascii?Q?mkB1+kXPhx/Idr5v0Oj8AbDfeVl4SQy4quQPKd3+mxs6boaGOqQ8zJ2CRvgQ?=
 =?us-ascii?Q?+avFYO2hNnSwB6ssSG8AKpBT39kKtcBXYblzmbg6P4DBksqu+DQ/PMg2Eb6l?=
 =?us-ascii?Q?/hERJe4Ou8vOANKMTRlK6NbitkhD2viTZK84BRo8qKO5HEowpAteWzmOFK6O?=
 =?us-ascii?Q?o396PkgwurDS7XLyZPxX8MRRYMZwlX9z9UjWftKXDPrC/WFIzQ+YpMzFiHOq?=
 =?us-ascii?Q?RJDl5oC2WwE1+eXEEAdl4Ve5/VFQ1puhGJ7wm4y5cscXPy5C+JzwVieqeq2i?=
 =?us-ascii?Q?g0M+Nh9o0DCPznqhTHNT4FO3yEuV1G5M6k9spLRSNrz+BhWZ6Tncqs2690rw?=
 =?us-ascii?Q?ZCPvyxBi+OlqChjixhun6xk+IJAmPqNrylIwu8kascWH7ol2h+rwlxbgZK/s?=
 =?us-ascii?Q?MsLpih/vLADsQ1I3SHH3bKn9rUVBNd4f7wpqMuBaz9f/ZbOCqp+7lr47PBXv?=
 =?us-ascii?Q?NtRpwjeG5syjsChXoUEoSMZP4pri3f5u13P+iKtuiDW82iiuzblYX/M/lV8z?=
 =?us-ascii?Q?2goZmWiAzgdCPsNzWPc778zDpsw2g5uzcaGl69K9m/wnmidx5TOmPAK7CwUl?=
 =?us-ascii?Q?6TbqEa+K1w+EKXJxcX+EOy/8zsp1BRsNxa0x0WQ2qv3oS/bWfGovaXEL3XFH?=
 =?us-ascii?Q?lqvOEad9r92OBaSZLD7XbDBp3FC5GvAifbN5/iH6SKajqaCO1jSP41m8H+m9?=
 =?us-ascii?Q?5OEyxbtunPjeWrlePr1TYe6A72a/OIeG3pc4h1JzlRvsO+6a2JpTfItOzrpB?=
 =?us-ascii?Q?LmFhueMxzsg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/DrhCG3zFY9eKlmusRpkpE7Oe5Y2TYwH3CtHC8VpgIaFFmRUJJ/x2GmvXQyB?=
 =?us-ascii?Q?SJHzTLMtyaZ6s3z35pNSMwemjV2duADzCuc4RVqdL5RB9+NeXc4Twy1fDzXV?=
 =?us-ascii?Q?tMHe28kij10phgCs8EYxN0p5kAjJ2UQWk9kIUvDKyVlr61jccJx0O0kvKYMr?=
 =?us-ascii?Q?6hZqfmb2NQzsGkn9Q4oRQwr4ANnmBnNy/jpoJIvlkjAKlIby0XM9NlqZXPwM?=
 =?us-ascii?Q?SJrBHah9pelolMFhq1fPxRAJ6RE7TfCHeLhTd2ekJzMU4a9HbUyE6FtAJ2NS?=
 =?us-ascii?Q?tQ84M9rUH/uTqdjedvGdSea6ob4+w1+uy6fbx0xp+VO5zeeHmWd62xdCEiiA?=
 =?us-ascii?Q?VgHX4GFsw6rJ2sOX+oOsBdCCAnTyMnW/RHxZuGCSQfjETKVYSAdkdswXwMo2?=
 =?us-ascii?Q?KZAfFLp83VP1+c1YNY2kAVgRFVKu9MTkwucRlQz04H3XNqhgc7/x3FH7XYvq?=
 =?us-ascii?Q?2kIIQB362j5MKAZMoCnpLtQinWM+wVbrTNzE2e9Lav3KDkr8iMoD0vWCL5Jj?=
 =?us-ascii?Q?HBAeMlUyV+o3l+f0HSbYds9csELjzcmIibeOml9XHEdlIPNCkemoHNAnrnT/?=
 =?us-ascii?Q?ao8sTzvsnuFwc1GD4z20XswLl/EvcNQ9166uBTJOgE8omtizrJYyzEu2kL4s?=
 =?us-ascii?Q?wj/uM2Eaeuad1CAZ7rMLKrYaJ6+SKwiy1DQfeX/My34ftEM7t3GXTJUtcsDI?=
 =?us-ascii?Q?UNqnk0jyJqsC+c7V4pvxfAU7licTjfGwWc+4wIAFez7zRWHcQnrRmhp9cAer?=
 =?us-ascii?Q?71sIek25weJXnZp9Lfxe1I+tGC09Jt7izOqgGS2mgsHOzk1mOfa+Ke1GrP26?=
 =?us-ascii?Q?XLOiTmUxm/8qM1BNxLkqgZYWdZQDRBwqaQq8SdlHPfCZzhhBgJj+DNuvL4mP?=
 =?us-ascii?Q?XDweCr4nUYtanlD9mKWryv5m+fL/ncrxo629BzKrRJg0Y/TXfqKWUpHwh6f+?=
 =?us-ascii?Q?Z0zkdIdBnY0XnX2rJ2dv53XDK+Tj9Zo8EwRzZtdKgYfFJojLAuEufYSHHSt1?=
 =?us-ascii?Q?tb+gWciSuJUjQEv2J7UKdQ/cgC4iBc7jpO8pkSyBIB/YA5h0vhDWOLuwP439?=
 =?us-ascii?Q?8MiMYk/6xA1TTOuvosRO3JUpMeT2J8RTVhFbdu/2CWW8CMBcz683UNMhRiqH?=
 =?us-ascii?Q?sGHjSzQ3tzgyOw0kDdie2xbb1E+1I8zQLCA63+7Kyj06k5IoHDazmHHO4HhT?=
 =?us-ascii?Q?trGs+CoUmBa56BchF0tJ/A2+dP/VBpJ9lA9qwplZP8yuAHhzackVbOsFIVQK?=
 =?us-ascii?Q?EodjvDho+jt+dC20BJoDW4lEG+hSKCs1rvDRoRVRXs1lUrUndLAjvq66TG39?=
 =?us-ascii?Q?2hpQTNf4whKQYNNGj/a0A7aDVLJ3NdRvB5ZPcpoxzVvXWfXdLu+913gxnPo6?=
 =?us-ascii?Q?wd98o/kXhu8CzGto6qKPfff0IS9w2nz3Ct9uCN+BvZncmlR+YeNZWdBr1RA4?=
 =?us-ascii?Q?NYzNoKNX9WrCCu++TcvLKAhU0+B05eLEm105vywFs7u4a5RyPf63OXq33lCn?=
 =?us-ascii?Q?hvy+4SbgemOyADFE/GxzW3+uzucO4C97RaFSrWAA11bxiMPHFA7Yy9wfY/5N?=
 =?us-ascii?Q?KJd2thJ+RV5as7tMMhCdG6Qq4ds+lOm/AI8mW/Ae?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4dcef0d-7532-4537-a80a-08ddb2603f48
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2025 14:14:20.8301
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5Z26UFedS3bI8tbdQxjvQSFjpTlxi7gCTxBAQnTFXbOIy4WSz0ziUAED1COsZlpK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PPFEC0C6BDA1

On 18 Jun 2025, at 13:40, David Hildenbrand wrote:

> Instead, let's use a page flag. As the page flag can result in
> false-positives, glue it to the page types for which we
> support/implement movable_ops page migration.
>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  include/linux/balloon_compaction.h |  2 +-
>  include/linux/migrate.h            |  8 -----
>  include/linux/page-flags.h         | 52 ++++++++++++++++++++++++------=

>  mm/compaction.c                    |  6 ----
>  mm/zpdesc.h                        |  2 +-
>  5 files changed, 44 insertions(+), 26 deletions(-)
>

<snip>

> +
> +/**
> + * page_has_movable_ops - test for a movable_ops page
> + * @page The page to test.
> + *
> + * Test whether this is a movable_ops page. Such pages will stay that
> + * way until freed.
> + *
> + * Returns true if this is a movable_ops page, otherwise false.
> + */
> +static inline bool page_has_movable_ops(const struct page *page)
> +{
> +	return PageMovableOps(page) &&
> +	       (PageOffline(page) || PageZsmalloc(page));
> +}
> +

Should we do the code below in case PageMovableOps is set on pages
other than PageOffline and PageZsmalloc?

return PageMovableOps(page) &&
	   !VM_WARN_ON_ONCE_PAGE(!(PageOffline(page) || PageZsmalloc(page)),
							 page);

>  static __always_inline int PageAnonExclusive(const struct page *page)
>  {
>  	VM_BUG_ON_PGFLAGS(!PageAnon(page), page);
> diff --git a/mm/compaction.c b/mm/compaction.c
> index a10f23df9396e..86d671a520e91 100644
> --- a/mm/compaction.c
> +++ b/mm/compaction.c
> @@ -114,12 +114,6 @@ static unsigned long release_free_list(struct list=
_head *freepages)
>  }
>
>  #ifdef CONFIG_COMPACTION
> -void __SetPageMovable(struct page *page)
> -{
> -	VM_BUG_ON_PAGE(!PageLocked(page), page);
> -	page->mapping =3D (void *)(PAGE_MAPPING_MOVABLE);
> -}
> -EXPORT_SYMBOL(__SetPageMovable);
>
>  /* Do not skip compaction more than 64 times */
>  #define COMPACT_MAX_DEFER_SHIFT 6
> diff --git a/mm/zpdesc.h b/mm/zpdesc.h
> index 6855d9e2732d8..25bf5ea0beb83 100644
> --- a/mm/zpdesc.h
> +++ b/mm/zpdesc.h
> @@ -154,7 +154,7 @@ static inline struct zpdesc *pfn_zpdesc(unsigned lo=
ng pfn)
>
>  static inline void __zpdesc_set_movable(struct zpdesc *zpdesc)
>  {
> -	__SetPageMovable(zpdesc_page(zpdesc));
> +	SetPageMovableOps(zpdesc_page(zpdesc));
>  }
>
>  static inline void __zpdesc_set_zsmalloc(struct zpdesc *zpdesc)
> -- =

> 2.49.0

Otherwise, LGTM. Reviewed-by: Zi Yan <ziy@nvidia.com>


--
Best Regards,
Yan, Zi

