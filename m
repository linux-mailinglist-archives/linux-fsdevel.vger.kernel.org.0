Return-Path: <linux-fsdevel+bounces-52090-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 07BBBADF59B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Jun 2025 20:14:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC932189E6E7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Jun 2025 18:14:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 291352F3C38;
	Wed, 18 Jun 2025 18:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="TE2fzpcA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2049.outbound.protection.outlook.com [40.107.236.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 159523085D3;
	Wed, 18 Jun 2025 18:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750270464; cv=fail; b=svQDrET4QyQ/vtGD5ZOJ2y4O79IrupEsMJlaqEteYthCia3FNSMd93teex3t+Zze5VYSD/fxxTmTEkG+yv7Tpc6O8+YsYxkru+7EN56yxg21AJ3IxRMqavzw9eHiRpPyBMndAhUu9+dXGbEtsH7bQsgdh+C93eOxaQ50CS5cdzM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750270464; c=relaxed/simple;
	bh=CazrY/4J20xIfe3J9bxeh/sOYNtpnP/X0V+/NOhY75w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NifTdXetuhn/I3Xb0f9icTIBIwW36QNSl0OJZqHe3BHtwm6TTpXSN2jiGEy6wEDjS6Nw4gcrLAqF744F7UUjw5E2eZQ3TMZFjFNJlKkZzIzDinvWzOzxKQZX1cDg64BFbFOfmaadmQNnW7hvMNqHzbgC3Yfx0D/vMYEuw1Mu0AE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=TE2fzpcA; arc=fail smtp.client-ip=40.107.236.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PRUnQprXMhgh4C2UFixkchi/yzscN0MkLCkjVV6FUVaWifVeGltagzBu9BEnBoptsQ1QyU1H9a+Y47LNkrI/rXATYfICPKGgkxADsyzzdwVOF+VgHydEeVGXN9v4i248KobUaGCyqP9YW/dPsXJdhmBoKFWQIzgxRk9onzIQvHtsEL0fEzWDzEPvyTLD4oIo18DkMNM3YitSIr92lwhIHvzjoxB5Fi3Vw2BnEM+aLCtu74chGGvulETIz4UiprOsce4ghOXCx7p7TE16KBR+0etyfZ/OMyNgfsdAh54+gBxKslCK+XGO0+sq+2Qk2Vsv10IVLW1FwnftK1MZxOU5NA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CazrY/4J20xIfe3J9bxeh/sOYNtpnP/X0V+/NOhY75w=;
 b=D9//1pfozTOYTcGzeeaUPW4IRz0v5KZTzzLSpV7Yb9Pw9u4Xc2ac2cdFfbbRXu++VUavFTcibPehF2WxcjGRUZvNcIFY3DSI9T0MO4V7bvjNMh7+p1GqToRDweOXdmFsUEHkn28WmrFhvvlGO2fw0ZV75I9HaIUe/5N1UaqTRkUonfDR58IRLwOsoqY3KDbXIAViVYNtZLBQs9SSg9y9aNnG6HWbLfkjJrasA/HHfRlS10XKyv8zlk1J4HyfzMdi9Vv8L+g/ivDqzGyRtk/l96i5M0wTc2915tW0+bx2A2eQlAIHk8XysfOEONtN4soMbYT1lsjp+tgGziYJKgYh1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CazrY/4J20xIfe3J9bxeh/sOYNtpnP/X0V+/NOhY75w=;
 b=TE2fzpcA+H0RFi1R7yXWkMhARUGC3OvVQupWMJy6ypGyrYzldA9c2wpoeU+4WUwktLx3AWPIdeUB162LdddeO2jDcnXVH1EdBlySGqucr5wBZtGeQ9CLgLljUssabBjqOompt6rU1Gd9QJarnY9g9YLVc+jzal7c+Ay2jgj6ntZLeo70a6BohXRer5xp4oxEILEycOAjRQCm5BFqZI96ja+cIypewPj31ZPVOCc1iyHVc6gQYdBw3dM/BZn8o6KVXEuLg7dqKtt/outsfcVQpyt3Vu63Gw3UQ8MuI04tlU1Mv9s1HXgUbYK9mRPZ+DJYfJ5TUnL44r1eh8cIRto6og==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 IA1PR12MB7640.namprd12.prod.outlook.com (2603:10b6:208:424::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.29; Wed, 18 Jun
 2025 18:14:20 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%5]) with mapi id 15.20.8835.027; Wed, 18 Jun 2025
 18:14:20 +0000
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
Subject: Re: [PATCH RFC 07/29] mm/migrate: rename isolate_movable_page() to
 isolate_movable_ops_page()
Date: Wed, 18 Jun 2025 14:14:15 -0400
X-Mailer: MailMate (2.0r6265)
Message-ID: <9F76592E-BB0E-4136-BDBA-195CC6FF3B03@nvidia.com>
In-Reply-To: <20250618174014.1168640-8-david@redhat.com>
References: <20250618174014.1168640-1-david@redhat.com>
 <20250618174014.1168640-8-david@redhat.com>
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0381.namprd13.prod.outlook.com
 (2603:10b6:208:2c0::26) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|IA1PR12MB7640:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ad1be8d-eef6-4b0d-3867-08ddae93f203
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?vtUQTjfQ7Hr/Q+ZtpJHUtGlKkclgTKMuhNQtSYIyChG7AuHLfabX+aTA9k8C?=
 =?us-ascii?Q?vX0CEEyMZ2CAj3l4cBGwdx2plijtD67EVCW6cV7p5SjTtf4ROIe7Ij6mGdIk?=
 =?us-ascii?Q?7puQth43FNYRCZ45e1bfwsVLOHvprv5JrWpN0CL8hauamVixZRHOo84m2/rr?=
 =?us-ascii?Q?hdjWhyLtDOuRWkws2d8ufgKXAzFTcdp6a+QBpJRPsDe5oFxBP17B7KM6XpM3?=
 =?us-ascii?Q?KpWOxy+We7T+qVCcDGUiZRhdpeu2qS+zpLrSsLzpqIVIvaUG2ArxznNU6Xax?=
 =?us-ascii?Q?rJneky4D/+GU12kffixRa2DnkuKeP9MCXd4EAAq2tAza0KAX2mHhtuwFFbGH?=
 =?us-ascii?Q?1g/D4YpFR3sbq4N83WXK/6XLNPGCQC8fNMj42iB1ciZbr0l8gMBLkUaWagGT?=
 =?us-ascii?Q?sjKozfn3QDDEuTKD/nipmwsycTqMNIiaUOzqonctdTdxaRYRciOIVKe3DCAS?=
 =?us-ascii?Q?HiLwCagdvTlpwGwUJ7ysPzCbWOFSkYp36UaP3PugLzusL4hbcIamhSkaKv4Z?=
 =?us-ascii?Q?mGdVoYcjqVrzm7Gt0S5d4zbgm8UVooIqAEZyRlEF5SwCbD8detEIrsN4AxEf?=
 =?us-ascii?Q?636yXggBOhWPmI9zw606U43pRg2xTDCofYYqXrYeKq9JSyYwRWPW2JvUgGk6?=
 =?us-ascii?Q?HjTyxC/niHZznZHfhD5PGQeDVWToJa39U1sgBbKaagot7iShN3TaLqvbPZ1Y?=
 =?us-ascii?Q?y1J82Rawd+pwTKwI3APaavzLE0HhEeSd1vmwS5u3+FBgho/j+xOn4Gfit4Bc?=
 =?us-ascii?Q?8S/HGkt3zzKHHjmuQM66IhwekpRhIjWz1Ni70pogfWevyvXXHi0WfsaZBQSl?=
 =?us-ascii?Q?2A7kdUc+xjA1XPL3QnNFvAOu7U6SFRkxKM1d0gz+xSxIYde4fNGG3QynkBJn?=
 =?us-ascii?Q?k/ozP8mtia9ZS5/hJeDn55Sum1oGevpIhWElq6YCIsUSZb5yRU19L3soZjfB?=
 =?us-ascii?Q?3a385YTcfmqzGrKfFzeQDk6IGXc9dS/HVesFfc44GSnh1zi0i3gC5y79i99r?=
 =?us-ascii?Q?wT/anXvhbbYFdjca2MnKYmzeHHxwqc0qrwczyopaQw6dwlJX6nesGMCPDkwS?=
 =?us-ascii?Q?WjBm3y1qZkJF2yEIgPCz7UR6RxbjZJHBuQEUNPatJLOzU2rft++saNu4ZRBJ?=
 =?us-ascii?Q?5SM2dFT4DjctpDQUjZ15oA5UBUSIP+wlV6ZuvSC5JvfWv0MzHw6wkDi7LE0M?=
 =?us-ascii?Q?1oDGvIlbcLAZ6shHSMuHynRl+1+8+fyIZsJw+lMy6KJGEYxAMt4fiWwxKT/Y?=
 =?us-ascii?Q?1WmKC7+yhF75RtN4YB9OCAU3vrbcKN9xikiA5nyAwFU9oa4cGFjNKGvw60F8?=
 =?us-ascii?Q?LHl8jZfMBLiG0wb4WeG6BIMMg+803v3JOekXi8oHVoqAs4LBPnMkO0OpK3tv?=
 =?us-ascii?Q?R4grGQ6Erqe2moxQrt68bDobzitVHu2vyqltRJlQmOn+v0xrVs0n4oKXK0zE?=
 =?us-ascii?Q?hxu8Le1U8qY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?aVdlREtAeusphRtvf+yWOxNLegICtWS6GTuUfApnvNzelFSsCpvdfe5zzZ6r?=
 =?us-ascii?Q?bGkSykNRdiVDbgTahNUFO8DuNMTSNW3WPK3N5km4txMExSnXPp/xwt+i66bi?=
 =?us-ascii?Q?lw/G5GFAqjre19tPwVqwwuSw0NHO5uRLHrcldqzBZPDSq/Ng5Rc26Eu3AxOZ?=
 =?us-ascii?Q?57WZBvBkGvzx2s5QbVlCR/PurE7cV/O/cdkOJWD2dsYqpFdlZYQayBoy4xNA?=
 =?us-ascii?Q?POV/zLxz975XUGnYPT/POygI48tu0ohAtmbv5twZXi5CN8ZmIkQPvlDoX6Vo?=
 =?us-ascii?Q?ucai206sD8f2qrF/nDcZfxSVR8atNrGhv5e1njHDk6u/AvkKCyBKP6mc9c+y?=
 =?us-ascii?Q?7mOlBXSq+JeCEJaaMKfoOS5mawLer+bVz5CtS2cJCrQtNQrNI1AR51TKxrC6?=
 =?us-ascii?Q?jM55fg+jcr+Sff6heDLjhNh22RZN+U3d074uvtprSyhVOT64RaqiQkUSS9RO?=
 =?us-ascii?Q?jS381kUz1t+F04xQ2v1EuL5YtG7mwJZKwMK0EuRy4PMsXELKrtLLP5vNPYwk?=
 =?us-ascii?Q?/52Jc4j4+LYbbmkVLecWIL3+rSslWAU+XPoVORaYN/HpE96ZiC7mAzTkDJhh?=
 =?us-ascii?Q?ZIE+dN/tVs8HZz7wGqHezzkBsxEkwDOt+Wnc8fpzGRi8bQLAFhb12K6jNpRC?=
 =?us-ascii?Q?aEC3wmAZ346JG2/it6MUH+nDd5OK5jhkGMFcloe0l6VKfuJVKpRV9K0v/+oR?=
 =?us-ascii?Q?hsPfksbIAFcH/eSJ+So/W/DXECY8Oqrim95B3o6hhbIxywD1KfrjIK0E+Jca?=
 =?us-ascii?Q?qIib2SlARGbrV/79eUWwDxB9dVVOo3LpAFJ+ULf/hYLaIyKJyXfp18hnRUcB?=
 =?us-ascii?Q?3fPb113ez5gGdbbEmfBqJ+NwlLf2y9DBrpbPdhVbUFWlISqxVuzuYtvugCVO?=
 =?us-ascii?Q?KGE5QHKFvOCBhgmocOGDsxPNd/YV1uU6mKIK//08uC8h2JVSeOMh+gEk3iEj?=
 =?us-ascii?Q?cN4kayYWh2AgvlzydHnYMntbW6pnygpC73MBmJJm9Q/RxzNvZ1fDW/0YGfr1?=
 =?us-ascii?Q?lORHU9Qn0tfDk/EZaaR2YMocLbjvHiSMfADC6cxvWddzw8xlrxfBw4jNuvQP?=
 =?us-ascii?Q?KECP/wgFsZ/CYAzcSBdNVgNvM3JBMB3wSKHHCWtplNpalrCntIs8TMaFIGZm?=
 =?us-ascii?Q?Q3kMiotfimDJVcU5Jye3QBy1B671E5uc8uyIdrui9Jni8lqQ3MKY5uIHwLhP?=
 =?us-ascii?Q?uxZKKz3elJ/CBrv6ezv/ZUFSYLMAxgUKvMCNQetdQFMJdYZXfphccYjHH+iW?=
 =?us-ascii?Q?06uOwQ3+UMyzDdLdUm3xC8kRf9XAs0+0RrIjX8R9jwt5KpcgO3PJJUfmKD76?=
 =?us-ascii?Q?IRk0dpPTsJxu0oizbg0HIyTmSp9uXKZ7J+RM9PB90UnI7Q4aJFiLyAxiwD0P?=
 =?us-ascii?Q?ZNlBg/YW1smmmUkSGs1idu+5FXgR4GxvO4wc80QbmlGJTE5WbETOoT5qHZll?=
 =?us-ascii?Q?amocW5EiaA5IglIwyHSXJf5urs/mN4aZGfQfFZwFDBsBC+hnsTvvLO5S9yJU?=
 =?us-ascii?Q?0B7Rw/c+MAWptAB5oFkX4QCNdEPfA6WMH91wX5LiTxq1Jg7pOFZhdiY1cyU7?=
 =?us-ascii?Q?s0LB5ZXov1ajemoZVMCmit3BRdZJl1dJa1RJbleF?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ad1be8d-eef6-4b0d-3867-08ddae93f203
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2025 18:14:20.2867
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TiSp/dp/fqzhpuKdQ9smZsxJV8meHyirPIuqLdplFup/TW64jMujM6+BmlJlp0hQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7640

On 18 Jun 2025, at 13:39, David Hildenbrand wrote:

> ... and start moving back to per-page things that will absolutely not be
> folio things in the future. Add documentation and a comment that the
> remaining folio stuff (lock, refcount) will have to be reworked as well.
>
> While at it, convert the VM_BUG_ON() into a WARN_ON_ONCE() and handle
> it gracefully (relevant with further changes), and convert a
> WARN_ON_ONCE() into a VM_WARN_ON_ONCE_PAGE().

The reason is that there is no upstream code, which use movable_ops for
folios? Is there any fundamental reason preventing movable_ops from
being used on folios?

Best Regards,
Yan, Zi

