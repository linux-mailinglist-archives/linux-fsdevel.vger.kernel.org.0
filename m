Return-Path: <linux-fsdevel+bounces-52362-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E9DBAE23A5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Jun 2025 22:37:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 820AA3B67E7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Jun 2025 20:37:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 237A128D8F3;
	Fri, 20 Jun 2025 20:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="HzIG81ps"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2088.outbound.protection.outlook.com [40.107.95.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 325471862BB;
	Fri, 20 Jun 2025 20:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750451837; cv=fail; b=ePRA1w0kK5KSGrqaECeN5gMz9M2iyDxnGwgeCdX+Eqm7cToLEDwkXdbHiJJ4d8uTjb2B3g34fxb7cctlc0klBB/Yvaosqiq7hVPs8lx3+o/4dAJEpqf6x1BY46Zt9YKWMqO1SYkTDQpJP4zJHmDRyiDtIFB7DuR/KgxkybOakXg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750451837; c=relaxed/simple;
	bh=8I+ZY98pJOm6b34a4XJJMwDtPUBU3O2fTb0B52n0hFU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=X2UJkjaLxhrKAQoK22RlUHjX3gA8dsxa86L4ptJ5bMvNyG4a/cQllEbECTsqexAFEC3R7L7mP5YnuIB7NxjSSZv6cubNUWmLdPD/uXRVRh3T94uaOapx/4J8tuthD+pGSZg6eUEZtdcfEz9cmw/9+N+QjniJ5Xd+aANVgHbRxvU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=HzIG81ps; arc=fail smtp.client-ip=40.107.95.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PpkmPZZcfJ0zjx41llVg/uKRavE0KSJ8bELXR25isc9I+VBqJSqWWMPQnDbVOXi57Ayh/rMIDyEw+3T4481mGU5jmqB66jtNqT82PuuJ8tuM3RMDPVBcEA6738KopT/Fl50rLnIyrLD+NhtxLsL8jghkYggjrQmwyMDRJvmA46sLLeeDqO0Zxz4vSMjFQn3nSPyvfVQUnH81SczkOvRoRPZn9T5vKd/DE1t+NN7xP7mjIydZXoHCpHrFrQakF8keHMiP9TpSkhBLduQITy7Hozw9FhtuCg0gEoVD9bRF43AyWUEXivCNmU9osreGkvGKusgS4jp7hYvrFFfSyFVJng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TaOvFJoJXJuRX3e9rP09EDoYgUvI5z4A4GE32T5lVxQ=;
 b=a4VSLdvJFxyBiAR1E2ucC7klx6XMzSw+BitmW6e3QwWC64siqhBAh884G5xvX6NEWT7XgfaPQuOkQJU9+xIYThwA13ERWFrJkd9QrCnTY4aSPUQngnanH7/Y7xzQUfqWvXpsRrOB91aEhZnycIUfypZS1x3Ob9XM6MYTB2AO6TacJ1mNKr+0hvns+HeWbu2l9M7Py2aB84VY0rv9H0zZO1SSU2R9vpI0Du8sOr6799VMs4MS+h/CRQ4g9Ppz5EDH6ma+T2GkbSjPT24hP9fczh2/6q7BGAFfstLz/wjXZ4MdJnIomX5rDALhzA7OYytk5hxjq3SvFfn1eSxgqy6mAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TaOvFJoJXJuRX3e9rP09EDoYgUvI5z4A4GE32T5lVxQ=;
 b=HzIG81ps9dhBpGt2/52BdMnVykUAcpkIFFSjoIOorcBN3QEBy1h+ay2XEkC90QG34dEY83Fmi7KKVImFEOhY11liHCSTsfVyD6BObG5TOcexe1ORNFuw1FjyYYLEKQbw8lZzf3SkPVI0cF53Sg89FGh+0y2tryQrreAM8k6daKJPU+AZwgDOmTbaTlaLFUAvBXdYxC86qKbDDs5POqg8l0qhTA0fuOAooPmk/sUlWY3pvQQx0NDl1W5Wtqg18B7tLcLs1IWRdwld3QlPEUy3bQCqG3TbWTU7Dz0ThVpNIkqURwIXUaxvuXmoRGI2A7o8IKFcXo2wh8hALSbwNJZ+QQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 DS0PR12MB6438.namprd12.prod.outlook.com (2603:10b6:8:ca::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8857.22; Fri, 20 Jun 2025 20:37:11 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%5]) with mapi id 15.20.8835.037; Fri, 20 Jun 2025
 20:37:11 +0000
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
Date: Fri, 20 Jun 2025 16:37:07 -0400
X-Mailer: MailMate (2.0r6263)
Message-ID: <DAA0D876-D5A4-4E54-9BD3-363E34D8B3F3@nvidia.com>
In-Reply-To: <20250618174014.1168640-17-david@redhat.com>
References: <20250618174014.1168640-1-david@redhat.com>
 <20250618174014.1168640-17-david@redhat.com>
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: MN2PR05CA0016.namprd05.prod.outlook.com
 (2603:10b6:208:c0::29) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|DS0PR12MB6438:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c6c60d7-7451-41e2-ab5c-08ddb03a3b9f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?jGScbeGnmNFs7Y9/ucOhOT3kZjq9uJpx8Oga44WlvzpxXxNAUO/4P2xGRuMF?=
 =?us-ascii?Q?AKmLJVYvLcbVoykWs3Ekmspt8I1ln6+6PFCBRpOWFJkn2p2JFXitmHw9wQDF?=
 =?us-ascii?Q?I0ozUnAOmPygR0P2khoTypcGE/IOGcTt1mdc3G6mOrVACFZD7zeQ0J7sNnI7?=
 =?us-ascii?Q?COz4pFsKLsqvOVl0qsC2I+25fbICcP3oc+RL6whbtix7+vRLSvKK/FbAtAus?=
 =?us-ascii?Q?FfcXaY7TbdJddNbQ4qWS1khjVy7idH8TQNvTNJLtcBuEPB4NJHv+eyL3NuKI?=
 =?us-ascii?Q?pVZfrBqvj4/ahC5hKSXfhiiiUzH5A5bQ4GHneGcKMoUnwQhKfhX0PCCotB3T?=
 =?us-ascii?Q?HcvtNnX2MqwfAex9kzv/pM7kgvWizYhHwApsQEOdRAgaTmmhi6HC1FB6xTy+?=
 =?us-ascii?Q?tTUCkYUK9vacpeD7YxNDpFLiCQ9Hk2q9/XGTJ5S98zeMQ8FnImpgjOXvC2rd?=
 =?us-ascii?Q?U5FNrPZN0OysEnOsXMKjN8dh+lYCK/79NJljyLeZPIWh7+o4xVXYMr1FY4KT?=
 =?us-ascii?Q?Ed2Xrz4AtzA6A4aG1k/o9c3KfK8O4VJGtY1rcNF2kHc84hYng+hdbKbB0W5b?=
 =?us-ascii?Q?clXaXjG0G5XPlOxHXmOOoRaFEJb2hzEXPyGJ6rxsbMWaLSAdLUsidTrbzAab?=
 =?us-ascii?Q?duZzgI2MX2d2iSrcz30nuCZNbO613KQXyEL8ZbFIduIBXXgS3rzPT+LBbWpa?=
 =?us-ascii?Q?CopYtw4EPswdh7C+S/FLtZ5lKYQd49SJwKICCUcj7AtzBGVymmjU5/urea0H?=
 =?us-ascii?Q?WL0G+NchTcU1j3xVMijYlrHt6pDbfM9xg4lZioiXYWAApqaxVDXA+zfKs0tE?=
 =?us-ascii?Q?FuudZ3MDIXgYQJ0j9EUn4kGzuEx8FV6bMhQMa8lFf2F7HuJ5eiXHKdBNWyGY?=
 =?us-ascii?Q?3q+hy3VapwgSo3MY+hCUiO9gDPdqj+SNggNtyrgiUVOVPx8VsC0X6g8h8j5J?=
 =?us-ascii?Q?BfFsKDyP/NjAKFaAZAGnmgHogTfDl+wr7qOW4ya4YIjCkIVJkRSnxrVVKZxR?=
 =?us-ascii?Q?96OorhOC9+f3ppx4kqv5wOrJvvYzR0LE/yOuw7hnRhP1+RvjesJSVIGMyItM?=
 =?us-ascii?Q?vA8V4/ai3NXy1J2OzmDszMX6Eoiq3xZxBKPvi2W+58HAe5yJuDi3G11fmFWq?=
 =?us-ascii?Q?HlpW+5HR79DmzJPj6ddT8iTEeHI8TO8ERs2fy5AX+YNSNQzGVtdYcbcICx5L?=
 =?us-ascii?Q?Bx2lrQ8Ovw3v6FzbBKv1sQ4gFNClGq9nGrKTn+W1tceMaoAQwaWgw6v8+1cf?=
 =?us-ascii?Q?Wt9Lqr3IwXK/pTShUxJI1W15na94tsabO1Tj1D4K2zYyGg/qesCt5lQWD+C3?=
 =?us-ascii?Q?xBedPPxM0LIFowe/rrmGkMkVzFfBB0o5ht3y3WbqAS75+Un34xvYPULYOE3J?=
 =?us-ascii?Q?0pRAZXZ651KYlEc/PG+Rw5zICsmKCTu0s11oq2SL92MxSbOdy7xmaA37qXTP?=
 =?us-ascii?Q?wxMLPFlhgw8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?iDYVZ06XRkSazsr4ffm59vCURK2fdYQp4HrTV5EfSGoNw8hNfmPlDzCmAsFz?=
 =?us-ascii?Q?xIvfTKM4+hE/Km82trm997F0fOZN0jDz+gI2Ox8Zlgh16bCNIxBM8oWsfD9n?=
 =?us-ascii?Q?gzcJ57n/Ap+UyHSjPt93NW8zziyLDiLc1SUmKBwDmz0ABIdYocFzQy8jx4lh?=
 =?us-ascii?Q?fcADBzXI+9flRikaBvfgRqHKIqQsTwzarrftB9hW33pfxvsMQxKhrnKkN/Qm?=
 =?us-ascii?Q?ZOYWD9pjJVStLeX7e0GX5bJNRUpnfmX0kIcDt4bR1fcRbGMm6+H/JElyuF+U?=
 =?us-ascii?Q?4xOafpKz20A/FvWBuP4ChcY5mvMHax/s3o+pjeY+6XqbueANoHRD79OQjzo1?=
 =?us-ascii?Q?AH0PGGDz+8ymkydJxFqgv1796pLVv6a8J11NzWqwuZCawPwUzqlICnqtHs4l?=
 =?us-ascii?Q?drzxNTuYMJ7DHAcWwmCS2EGw1eikTvyfcSFj7ckQa9L1Ga/vy2OynBTbsaMI?=
 =?us-ascii?Q?utOFBXRrXNdewphm+sAR4K1U3YlifvOhLw4lrvBYRLmNhuK+xIsSRXBWDykn?=
 =?us-ascii?Q?DlX8fKkPMf4dan+uIfsK3heUqVZbIoB5Sp404qEQ7r4IvJj+HgVnGbs90YPf?=
 =?us-ascii?Q?1mncaKoL3KyzMQ9FXEXUqHyKb1PQwojcpvtk65Jwj86UA5Hhsd2xFAAF0iav?=
 =?us-ascii?Q?5iX4Rnpj3vGMChnC0Ws92EQnN0aniZzY+bI148+bxdNoS2NTOGLtAsFULWJP?=
 =?us-ascii?Q?OlFMhjYHx2FE8rlolZKhbbhmsbniT5z53XzRQmdf5RMa37lm3QPTOOoJa9tG?=
 =?us-ascii?Q?iy1a2vOYhuLRPVVEa067W0OBU+DbIMl9RfUGBhHwphsf4tpRAEMsluHOgcjf?=
 =?us-ascii?Q?S7AxOhuBBtcptOpSSYOe3sS/AUpViE9n4YNklBrgYl/GsENZmqYNR0T/DIcD?=
 =?us-ascii?Q?8SibrOmQ0fZLDFy7aDMeCCvfZLtC7F6RJy1fPNADgzbV1WF/BZKN3H6RGuRZ?=
 =?us-ascii?Q?OaDmRIDSwXbvVDpUaQsZpAy/Wn9gt7I7ud3NANs1ncQgY/Go1mOzELM7ojii?=
 =?us-ascii?Q?5M0ickwIu/Bpa8KVfaYAyQmW1EDPAdYn/on+PJE0kJNJfxCk/JIJPJpTOmHA?=
 =?us-ascii?Q?GNrbuBhQVFKf7vswRa4+fjyJvZxobNOLbN7YEc+UWSwP/ottmxbOa+MzEURV?=
 =?us-ascii?Q?RGN27TotW5unnyvvTcp8sB+WPIgnSewpcBlZM6jTkNmxSvNlIgh2DvQyg4uG?=
 =?us-ascii?Q?5AaxsH5CMxnH7bTpVU6f5Wls4ayjdmynl/zghh40bhyZWKhCBJ0OTd3ftpu/?=
 =?us-ascii?Q?aX4cQ39c+lrPC/pmQboyK3TeGZA1HofDBS+as3K44geowBA+xFt0hnWj+Iub?=
 =?us-ascii?Q?UqqswDOexP+nfPx19Zs0D8WamtSs1VXDOKDypZwsmRr8tYM6Kcjf+9aBc1kv?=
 =?us-ascii?Q?sp0bywB0Nd18VgcsrCj9rnJCXn0D5stc/E09uSO1cgZXJ5Hq0ru+j40zIA9W?=
 =?us-ascii?Q?7pHiSjzrH14jdbZWweqvEahoRSwuYU94v+fcSWXuWs4q1Xbh9ewdUt4fF3fK?=
 =?us-ascii?Q?zhK0go1T0Iw7HsE+dVmlmJ0t3EPJhVfbjG+cdMp/tMlSCV+geVX8DWTBQvcJ?=
 =?us-ascii?Q?Zh2Bo6xS0iKeQ5pH09Qgbt3iNLrP3thrtJaB2/L8?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c6c60d7-7451-41e2-ab5c-08ddb03a3b9f
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2025 20:37:11.4442
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FmfYp0Ng+IDYx5N03wMKxumtMQiKGOf+xRI8Oi3YcSjKmGGRCnJosA1boZiM/fL8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6438

On 18 Jun 2025, at 13:39, David Hildenbrand wrote:

> Let's make it clearer that we are talking about movable_ops pages.
>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  include/linux/migrate.h    |  2 +-
>  include/linux/page-flags.h |  2 +-
>  mm/compaction.c            |  7 ++-----
>  mm/memory-failure.c        |  4 ++--
>  mm/memory_hotplug.c        |  8 +++-----
>  mm/migrate.c               |  8 ++++----
>  mm/page_alloc.c            |  2 +-
>  mm/page_isolation.c        | 10 +++++-----
>  8 files changed, 19 insertions(+), 24 deletions(-)
>
> diff --git a/include/linux/migrate.h b/include/linux/migrate.h
> index 204e89eac998f..c575778456f97 100644
> --- a/include/linux/migrate.h
> +++ b/include/linux/migrate.h
> @@ -115,7 +115,7 @@ static inline void __SetPageMovable(struct page *pa=
ge,
>  static inline
>  const struct movable_operations *page_movable_ops(struct page *page)
>  {
> -	VM_BUG_ON(!__PageMovable(page));
> +	VM_BUG_ON(!page_has_movable_ops(page));
>
>  	return (const struct movable_operations *)
>  		((unsigned long)page->mapping - PAGE_MAPPING_MOVABLE);
> diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
> index 4fe5ee67535b2..c67163b73c5ec 100644
> --- a/include/linux/page-flags.h
> +++ b/include/linux/page-flags.h
> @@ -750,7 +750,7 @@ static __always_inline bool __folio_test_movable(co=
nst struct folio *folio)
>  			PAGE_MAPPING_MOVABLE;
>  }
>
> -static __always_inline bool __PageMovable(const struct page *page)
> +static __always_inline bool page_has_movable_ops(const struct page *pa=
ge)
>  {
>  	return ((unsigned long)page->mapping & PAGE_MAPPING_FLAGS) =3D=3D
>  				PAGE_MAPPING_MOVABLE;
> diff --git a/mm/compaction.c b/mm/compaction.c
> index 5c37373017014..f8b7c09e2e48c 100644
> --- a/mm/compaction.c
> +++ b/mm/compaction.c
> @@ -1056,11 +1056,8 @@ isolate_migratepages_block(struct compact_contro=
l *cc, unsigned long low_pfn,
>  		 * Skip any other type of page
>  		 */
>  		if (!PageLRU(page)) {
> -			/*
> -			 * __PageMovable can return false positive so we need
> -			 * to verify it under page_lock.
> -			 */
> -			if (unlikely(__PageMovable(page)) &&
> +			/* Isolation will grab the page lock. */

I feel that the removed comment should stay, since the current comment
makes no sense when I read it alone.

In addition, why is __PageMovable() is renamed to page_has_movable_ops() =
but
__SetPageMovable() stays the same? page_has_movable_ops() and __SetPageMo=
vable()
are functions for checking and setting PAGE_MAPPING_MOVABLE. The naming j=
ust
does not look symmetric.

--
Best Regards,
Yan, Zi

