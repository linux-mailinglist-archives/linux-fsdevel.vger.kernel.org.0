Return-Path: <linux-fsdevel+bounces-53379-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E4BEAEE42D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Jun 2025 18:21:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB0863A7FE6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Jun 2025 16:16:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC03929ACF7;
	Mon, 30 Jun 2025 16:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="LevwA0Tm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2045.outbound.protection.outlook.com [40.107.243.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84B4C2900AD;
	Mon, 30 Jun 2025 16:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751300050; cv=fail; b=VIa/fybvxyxIA2RPcEjTh3CMiK9OEkcKGeFMsuy5mKTxzqYO0J3eJs+idgdtOm+fqEyenm5oKMYVRjOHfgTgygfFZIMJsf3OamWkU0vht41zwPLKnWMWeIiNbYsEvhGJhLEvO+RkrqcPx+csgvFWKsbZAkxml26TDqbMYys8Aj4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751300050; c=relaxed/simple;
	bh=KywnhJjRvdLILjsZMjGn6ZA+yQQDw3+bTFr6uySxKvU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=umNAtptPRHUv9YpDsCNSDZC/fsNdPl6rJ+3YDYQhyna6xkU5/A4Bkq8Ui73IxGLh0kJthAN7J/1pOAv4ITOUak2VvFR1bjIKCTdOTF3Bt9NVYfAuJjwUrvis5xgTBxCHUgO412SPTnJebsYQkeVRAbzRsCmTLdBSW/BhPyeyOf0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=LevwA0Tm; arc=fail smtp.client-ip=40.107.243.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Tm+xAg++5We5ICBPRE8V9yy0vInkrfCfXuKadTogxF6qpjWCitKxDkz+bCNahlQFQR3qrSGyJrLeit8D3AyZJ/HbaJLI+Vy1QAldJVC//Q39K4IN5OgPXy+SlGciav9bqGoM9QxgZ57LJZ7pOMMe0sLWuInPB13357eeBKi/hkCOAhgQs99hBZIcfhoZowo07qMQLRV02e6QKaOp8jIdXSIyKwCpB4qSVruFbd5Azs1LSI9HYtOx9kUthkjoHnqFRGgbEOmW7LsiBDxBi21DeMsKgR7/XJWA+wveCzwlQnrle1JjSp8jEycaNsiKKQPn0YY+LaH64Utew0gEGKIPZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KywnhJjRvdLILjsZMjGn6ZA+yQQDw3+bTFr6uySxKvU=;
 b=LA8lBLV9GGKjsWXP1cZHpwVcupHD7BeyRtv7tGsaRy4J5yrJdYLJz0MXrW/WbvI+NqC7SXgzu9ff7X+Y10WqTnBtehhbqq7evAjW63uegjFZHr7QSFXvZsDYdfPILiaesTZ48MHJQb9J5Wj0VsEzJGK9xzIhar8OBULiFmhDzsUkKpeovMF4QF9EY2Z7Xuzw4/CZr9JH40dionspC5O8euLFZ6DHVLaPjp+gbNka9cl63dMrckJOYmuHImvm2PMUFiZ7KoY30aS5ozzOa1GV8r8jZhg44oOKJallKdai0O5H9Dkuatz/LsOocRlHTVuWX8r+vVRnKDfTK5H/T6v17w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KywnhJjRvdLILjsZMjGn6ZA+yQQDw3+bTFr6uySxKvU=;
 b=LevwA0TmxmkuNUr9YJ+sPxDcOgKEPq5S4cWzGxAHRdrslutJUb6ZFD7o3TBoOEh4MV/+zIw13XpA8mxFIOivmJyLgWYaGnvP7JrVOmWjVDimVzgMbn5gJC1hLJ0fOlbfp00+uXjJC1j5m+NNzGwxovOqXOQuiFmoA/9kv58FnSjIDu7PxXcbVlwN+glrwBIuUC1vOCAJ/A6FMlut6mvtTNI6hlmhmKXgL0LNoQ5gEtoaQRPtY0niWMyRqOrVHLGInrgXCFIM9+ppxU6iYM+YpGg/jS1J8eZJuNNg2XpjBNjy36xSs8AcHIs3aLvm6I4dVpY8YP6svYOpz6V9PgituA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 SA3PR12MB7975.namprd12.prod.outlook.com (2603:10b6:806:320::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.27; Mon, 30 Jun
 2025 16:14:05 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%5]) with mapi id 15.20.8880.029; Mon, 30 Jun 2025
 16:14:05 +0000
From: Zi Yan <ziy@nvidia.com>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
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
Subject: Re: [PATCH v1 05/29] mm/balloon_compaction: make PageOffline sticky
 until the page is freed
Date: Mon, 30 Jun 2025 12:14:01 -0400
X-Mailer: MailMate (2.0r6265)
Message-ID: <595C96DA-C652-455F-91DB-F7893B95124B@nvidia.com>
In-Reply-To: <6a6cde69-23de-4727-abd7-bae4c0918643@lucifer.local>
References: <20250630130011.330477-1-david@redhat.com>
 <20250630130011.330477-6-david@redhat.com>
 <6a6cde69-23de-4727-abd7-bae4c0918643@lucifer.local>
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: BL1P221CA0025.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:208:2c5::13) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|SA3PR12MB7975:EE_
X-MS-Office365-Filtering-Correlation-Id: 01dbd93d-ead7-4c1f-2ab1-08ddb7f1229b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0dt+gH9hTJB9mzYjeeW7InxHvBU7jZPl358295vDM5m7uU8BJ0NDSugpAo5r?=
 =?us-ascii?Q?pOUUShi+44M3Ne7N/ANyLPC2odM2U6S2wdFZpjnqSe3d6H7kZmaX4wyzk3SQ?=
 =?us-ascii?Q?EKYEjI9oXrZyBSIuFSukkF3bXvO2Z+CRhxn+kULdPuPdEYodYmNqW5jDY6gj?=
 =?us-ascii?Q?0JsUWjuUGCWRLuxZxHinmmACmsNNVwwZeBfOPxh97WtQ9DMf4GhHsH52Jfkh?=
 =?us-ascii?Q?yCSPOFzh2XtNSWvqHYdbXGW3cRq0KZf+KWvBBmsW9tKBLtV9tpUNLzcQvNqe?=
 =?us-ascii?Q?Dj76ymRve7wMyJpwJbs8BTIQp1g8gpyerV4JKpCBalEFgCuCRA5sD3S9pYBu?=
 =?us-ascii?Q?MJwLjyY6RWSZOr7TAnbBLtoxk6/Q9KFRMM1N0fOyzroet9OwWtjzdAM165Rv?=
 =?us-ascii?Q?N7Tnz81XlEoVl7htOAEfSmuDsp13v8FLA0Gbk4KTHlrMJhuG6pTsLDE4d/GC?=
 =?us-ascii?Q?skLtIBT6lXi0VAI9gMPyGjwtEcd86TT94AAoWrw7WovEPqV9iEj3hBMO1yH2?=
 =?us-ascii?Q?kYkMlYGqneC0W8vUlxoQwNSWsU2y+aPQaxcMjfFZeQg9RyBkGlQnPcN4MBFv?=
 =?us-ascii?Q?vrxava1y9putvuqRv2nyu3feIyVi7HwqQpZvahQdfnyR76270yXL89GdQ1Fi?=
 =?us-ascii?Q?qezaD17epxNrw7wBombo9+N3eT57Oyl6H6qRQmxh/80OzgL4CsbODN+qbotj?=
 =?us-ascii?Q?6WRBxpkFuuspQXe8xIYn6UQAMnR3TyfiN3Gy6gDJe1ElXxsrjsWs+9y2QSFz?=
 =?us-ascii?Q?NYzHkOqgHejuSZeKBObYqz5fFdUFOkExU33ZvIHoyhXzcRg2qNPjZQNKUKTP?=
 =?us-ascii?Q?ZWFpsWc1J4gu8LphDBNn62I6dAtHY3m+MsY5wIOpRRxEjs8mNahgEz1HpEEB?=
 =?us-ascii?Q?3uFj3UmOGYSampbzJb4nJakYAma+V28KvUfUgoCSK7qhKhETNTF7mpiA5lUy?=
 =?us-ascii?Q?sU7Sug4HSUEEeBOBqXTditBVtq4FsGMLPmR7TWBlHOqqoDmvNqe7QJ0eUtJG?=
 =?us-ascii?Q?r6IoyIhIEg+XyB1TqjOEFYpvsma7ZtkltlPeQg9cvBp096Y5W3I09RQAz3sk?=
 =?us-ascii?Q?9iSaXpbeh+7ESP9IcgSqPRBPU95lBEcXbql0Ae0EfVrkNzND6SYgijhol/HI?=
 =?us-ascii?Q?cUBj/1MvNnaSvQiOddDpda41taiUM3KfRzmlLYlHpb6+C/8AKMfGBirIv/5q?=
 =?us-ascii?Q?w65r8WyZgG+yi2fJ7zLSEVgYRmxCjVgAZYusTzoV5fBiTct8J5FRJvpl10jr?=
 =?us-ascii?Q?ybiJw+8h8nbATQP7gR58oIuk09BSDPnRvWBH0ZYF+65kCwn5RR3hpBFjqwgq?=
 =?us-ascii?Q?nt2KYPiXqSiVLQx/QD2Hbap5SUxDGVd3UQAGQULe8uD/vOQsrnrCHdGOJbdX?=
 =?us-ascii?Q?y0941aVM+nyCk1OEBANYMF/4KjpB+Z57uNvNhETyjtsYZCfFCWl2Zn5JfnR+?=
 =?us-ascii?Q?6cLKGs7Tiz4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZYDxaasFFONSzHncEI/QEvzmZtbcNreVaiYqILc4o+lFa/liTOtC3zClEade?=
 =?us-ascii?Q?G91oc7cj1jWbgtUdtOjbet2LkYybTpBWl3aTLS4U6g61FEojtFHK9/6bHt2X?=
 =?us-ascii?Q?PFHBZA8N0RQm+OI0ZhD0cEK+AqUsh91uHvPrwTJ5IhwQvZaA8E6AY3Beu7A/?=
 =?us-ascii?Q?tnte4T9uZgpU3P4VwpHqNNm2tgB7UdgcjObVFTFfAIqmd5dAwWkP6Ejo25jV?=
 =?us-ascii?Q?xXUOIW3+rQp653z4oRmZVLl7Kn1LuACzk7uI6lvkgm5J1BWcN5T8SMASJV9Z?=
 =?us-ascii?Q?zlEVQJKnPVkb07hQRIUYoLabpaJOzNUt1YgngjTVQXqKFR+fehIGoVEu4RVP?=
 =?us-ascii?Q?ZBLzE/rLxi8JZftEtPViGkVl+59+9Lbwhjv/yjSTvuLa4Z2pBZLoHPbXRADi?=
 =?us-ascii?Q?jk1SCqe2TIg52WWYIWwqv8VCrq7+E/MPHrVLLSMhYcgj0qNTnbO7qgTnmUQk?=
 =?us-ascii?Q?KTdJySCuDfQdrSMUbUOchrO7+wwIrdFqiIgT+Tb93qjhqcwXX6EsSeEFyxOA?=
 =?us-ascii?Q?S4vbPo1snDFAP1JfYSp9gcF04T1Uh0j571SofvlgUSTNNsOYklJqHOsbrOPZ?=
 =?us-ascii?Q?tKvIhHhKn773tcul3p/i1trcUgigCkX6Xmvh4/Zt7esNPL0bGb8VzDXhQWIT?=
 =?us-ascii?Q?kGJq5zueVBJ2KuCjTjWvxr3VAS9WNNMOrFBhicnKNZ6a4YXZ5yhxxsZsmqZQ?=
 =?us-ascii?Q?JpVXmKW+rvrVhtZt8LO3zJjnSE+rcv/IgnqyGme6ZYus0yc50b2jUKxNHdKR?=
 =?us-ascii?Q?PMpHb/oWwW+1qJIChO+qKeDn6IiFUz0BXOLNmkoHJaOB44MSEWDwCAulbQHM?=
 =?us-ascii?Q?tgZkemo89AwkKP7grf5mCooUifCC81LJ51rOR11PRQVxGhxU1I/P/zcktr7D?=
 =?us-ascii?Q?zMzP7+z20WxxunGIw3Nd+N/trH8ZM8faltrQiyutqRD1NeUE8zQT/x9zaZki?=
 =?us-ascii?Q?0ooWPeeVyJOR/+mg2TM32uMZZ2THXiGImuSjf1J7YOjxJrxlHjl4jpbH5vH8?=
 =?us-ascii?Q?XlH8tTQjjOUUuBG7CiW/MisEGmCZbtaEn9eR5+lRO9UcXcmMLWA9gSDDqqqv?=
 =?us-ascii?Q?rt2hsy1q1zcaEqxYKWKV/sCM9HeL1yJEdkjMoN3me03C1efVkfj7aQomhVVt?=
 =?us-ascii?Q?jfTCkHzYZLXwHxxCI2yiWYViib3ZQjtngS/uolMRDtcW4W/YRWTzLIJoDgKe?=
 =?us-ascii?Q?D2jkE+gKS1b4hUTNn5QndQqDdDbcm3GdVa+MTkF2nssoBelS2jYKirb4DNqn?=
 =?us-ascii?Q?h2NrmyBvtjK/34qpbmdRx1IHD3fOa37+BGzzoq6kKTnkjXbJXKvghI/Aayiy?=
 =?us-ascii?Q?V5O0P+VE+BgWlGKZEFpetvBukdOfKkviO3XXTbdMNPgUPV8QDq7HkeUfJwkI?=
 =?us-ascii?Q?/djctq8kOkLNlvkL+B7HtPZ1RL2Q3aYORRNtLHYzdSRCNwPQ89AGxVanHTxf?=
 =?us-ascii?Q?tSmXTY+djTHUuyS1fFxHAGd0X8uUOg+AvPh7hRgaUv4WqF2rD87oV8kZ0EAk?=
 =?us-ascii?Q?FUmWFNQ3qjkes4gleSZdTYQZrfi0VJIczQW1Z1oQkicNKj4vG1nvgkaYIiAS?=
 =?us-ascii?Q?CLZhCdvR0u2zSvgAaq9sAxtgIKGE8L0giTcxKrcw?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01dbd93d-ead7-4c1f-2ab1-08ddb7f1229b
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2025 16:14:05.4536
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kOyHvJnFXfFlNCU3J1ZI0k/d1PcN2xSzW+LsnuHGI2AxmIzp+qS46FWA46FMmqyo
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7975

On 30 Jun 2025, at 12:01, Lorenzo Stoakes wrote:

> On Mon, Jun 30, 2025 at 02:59:46PM +0200, David Hildenbrand wrote:
>> Let the page freeing code handle clearing the page type.
>
> Why is this advantageous? We want to keep the page marked offline for l=
onger?
>
>>
>> Acked-by: Zi Yan <ziy@nvidia.com>
>> Acked-by: Harry Yoo <harry.yoo@oracle.com>
>> Signed-off-by: David Hildenbrand <david@redhat.com>
>
> On assumption this UINT_MAX stuff is sane :)) I mean this is straightfo=
rward I
> guess:

This is how page type is cleared.
See: https://elixir.bootlin.com/linux/v6.15.4/source/include/linux/page-f=
lags.h#L1013.

I agree with you that patch 4 should have a comment in free_pages_prepare=
()
about what the code is for and why UINT_MAX is used.


Best Regards,
Yan, Zi

