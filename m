Return-Path: <linux-fsdevel+bounces-52584-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79A28AE469A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jun 2025 16:24:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F1BE3163F5F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jun 2025 14:18:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C603239E76;
	Mon, 23 Jun 2025 14:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="C/ASBeTB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2083.outbound.protection.outlook.com [40.107.237.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 425BE2367B0;
	Mon, 23 Jun 2025 14:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750688181; cv=fail; b=lmI7q6YYaA2Xg1FB50sW2w3zh5dpXs+5X8hwqjyDdqu0JhXkJC5L9KSDMG/5OmE8hBRBzk3/lqlyVFrJcMfcrwpfFu6cwCYK6hoHx/vfSzQAj/NvHEwCoF2HmfnEDmfL77am282/rTyaN5tTwFk9A0igwVdgVuyWHnwCJHCChiI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750688181; c=relaxed/simple;
	bh=tjFoHB94kIDRQnVWevoSfWHJPKcPt4PPhHSjQAi1oTQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=R0qG5JmASP+S9NJ6KLihQSNGyqNMDq/7rp/oYW8o1tCDfZTQGYMI4HmSgKktyKYtAHwT207ZS0BYI7xLSjxxP7QcV4PUOZ3D72z0/xYY2VwPiEnJkJgZXFowUVou+vBSNXXMplstr+3Od+XgyVGSG56imGdwbh3s5tn1cgl03ek=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=C/ASBeTB; arc=fail smtp.client-ip=40.107.237.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JmIWcOd1AEQtw+EqHZUaU8hQ3EcOTzezvUa5mzlbh/UR0QDOtao0N0A41IGRYiOgP2w+3K4sU2vQ7WtD9t0O/plVp/ll7rWBwYfB48GiPZ842IMiZkS65NwP091d+o5gwHPa9uvEOGhu3wKiVUUHRcfJRIgYESlGsdhqL6RkY4ktQoN/mu3eiy/8sZZSmanzW3fxCl4+XyBZyIuSEUzSTpQPCYiyfN0VUjnhCnPByD/t4PSP15KQ285UXkbhFPIyhn+1DdHLLW2p1Kz/9RqJ2VTzuI5/BMVNVols8V+r7u9fqNgZ9iBo8H+K0J192zSOUUTuKjYlUgv1nLYBotMwoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hk4zlYyOGgrT0LwLBVFuxbbScctg5tq/SNhBceUxtSk=;
 b=PeLxRC28GpAPFbEhGEh0ITPEIUVqoKjFiKgV9dg13wYB0RWw858U3UnOeP6e8DmmW00p+ni1omCgl4ezwx27itL9ZAzp/T4t82S55QHDFRpPZpL0aprnJdG5KYqBrHz5h5PhaXJwxc7lV0g6bj2HnuAGOBQKscwYSJ3PK43yVSqF0G0b2YKIUdlbPkaU3Xd/F80VcNgWtQNgd1s0cgIAGYcoh9A5PL6ljh6ZhlLga59MBWGreackeIWuLLXVtFQOz61Tm6y2DBiHY3F3YQz3e+Gx+p/RdaEWI5moj50mrJSCe6c2CWNKpuNysVdj5/w9rmhrqKurpudjfL0V5FZGnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hk4zlYyOGgrT0LwLBVFuxbbScctg5tq/SNhBceUxtSk=;
 b=C/ASBeTBlWEEzHGU10IsnkzO3waKO9hrfhkqH0sTYs9YPm/V4SK0YyHnwvFT/ktFVqG354guWt+znJt3nXpru/Q0EDmxFhGIfryisVxO8EgTBVQvWCXS7pR2i2wszokcPgLxpk/vJBh6z9SUmr27Y0jtIuO+JYBXrod3FfjqiIYi0u14Zukyvt7lkbWP62xcJ1kL8Gih/QpUECfhnoyZOZRp0D+Dv/7cnMLTKD/hvCua7e22B3xfb0c9ufZ97244D2mt7K92ADpPlDkFGwgHlQuZORj68rHEuz+4rZVqzCYNq9DMZP7wT9A2VCHL/qUvMFK9cpP62ZwqIlzaMvgHPw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 CY8PR12MB7340.namprd12.prod.outlook.com (2603:10b6:930:50::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8857.22; Mon, 23 Jun 2025 14:16:14 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%5]) with mapi id 15.20.8835.037; Mon, 23 Jun 2025
 14:16:14 +0000
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
Subject: Re: [PATCH RFC 21/29] mm: rename PG_isolated to
 PG_movable_ops_isolated
Date: Mon, 23 Jun 2025 10:16:10 -0400
X-Mailer: MailMate (2.0r6265)
Message-ID: <73C2F580-151E-4808-A8F5-AFC65D2D0869@nvidia.com>
In-Reply-To: <20250618174014.1168640-22-david@redhat.com>
References: <20250618174014.1168640-1-david@redhat.com>
 <20250618174014.1168640-22-david@redhat.com>
Content-Type: text/plain
X-ClientProxiedBy: BN0PR03CA0021.namprd03.prod.outlook.com
 (2603:10b6:408:e6::26) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|CY8PR12MB7340:EE_
X-MS-Office365-Filtering-Correlation-Id: d056bc5f-3bfd-4495-27bb-08ddb260830c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8gpSp2lGuY6oywYTsHTYyvI30Q2ey7ikdNAK5KNU63mgUXVSsv2WAlPz/Amd?=
 =?us-ascii?Q?j/sJ2d6GvtsYTA663ziPTRWntSwhQbUJyqkydtCAthPRZKPc7W8syK9QHiEI?=
 =?us-ascii?Q?jpDduulrCVZL3tICiTpuzDVn4YAwcAxfopgxnwjoz+e5sUJEEX1Ak1nnOI7d?=
 =?us-ascii?Q?5KOWcln2JOIOm8THPYYeAfe6EpzxTkyGkLKCIReibC+P8CDlXfv6JTg3C9qO?=
 =?us-ascii?Q?o03MhB3HT0dvUY+LRsjA4NZ/aS9/V2ZSGY8IrTfciwuIOPbME8mIStMRt1C8?=
 =?us-ascii?Q?qYoxnp9ametZJTTu6bOYWTQ2J/207fBQV9x+hNzVsRhPlX2OrJDY0Y//KFSI?=
 =?us-ascii?Q?MGCqSojUuIEEsuQUgr5koJwfHkUv8erC3unfI1OfVeBD3iR9ad35GkYfdSzw?=
 =?us-ascii?Q?Rm7Nj/4lzyWs3/XmDMPOrhrvwZ5NEdmkOIe6S8XI5NIhgH/nWE5AmNnVqc+S?=
 =?us-ascii?Q?n4KMgHSLynQIgTR04FbU1ujH55o/8wQu03QX4nRox96W5qvVqkuu4UaK3HvW?=
 =?us-ascii?Q?ts+oiH2XuU4ibOa3hym+CF1tE6zAwJXC0aPKX9ASCOxXlU/Vk6IipwGz4DI8?=
 =?us-ascii?Q?OHS+WzJHQDIHLT+0RsAJkpkcZdxir0l2YBF7Q7eVgz2yI7vX6RCt0iYD/qQv?=
 =?us-ascii?Q?BW1c0Mtnv8RTErGUcjVe1zfU9fHO8v2pypVa9MbxLjnKbjFgptnpg6gRX5MR?=
 =?us-ascii?Q?4efzacaW8TY2BqDj0icVH1s/TtM6zE6M5T/lHDTShSCIPy+7DXvQi4SMvbPD?=
 =?us-ascii?Q?o7zbVr/FgcMGg4GKJmR6FLqRYzTZ9Uk2wktoEvbttA4wuw1CKIPdBxVSLDEp?=
 =?us-ascii?Q?+sV/pN+R+IHnYxaI/wPB/Gv2e7zPJhe2WTIrmNGegxPaXKw2Zkhii2Nmluxn?=
 =?us-ascii?Q?4IzSlHXquz+haw17vOrel4urLuzVli4HPDgtd57q2YEbRzS3Ke3qHOh20Gxg?=
 =?us-ascii?Q?JnUYuXZChj80umAWhY6eGFr0CfDmkffB4sMkmTygthJMMRzjXsrQtAqN5ykP?=
 =?us-ascii?Q?mR89KKW9lDs+eAwYilRwfTsGWID/eNYO/rBLeeYScwhBM4BMsiNEmUFTt0b5?=
 =?us-ascii?Q?i6oyh1fiEaO31jNa7tw4uWKB3qDeYC2DPUk2r+ZW7/9GZvZvKnYIwGoCsP4A?=
 =?us-ascii?Q?X+1URnQmUYsgijjdpFNESS1xBK45XcxF/c2u7sOeS9bdTmFckkXMG5O57/0m?=
 =?us-ascii?Q?6xHThYV/vokbaEnLXoN8I94QreUbqR8LldX+tymh5zrRtgakSI/spFtSx+ww?=
 =?us-ascii?Q?2LH2jdjuq026z36/4DG90Zo8f8yMYUvbpDF9+U5g7Fa1CGFedgLRtOnpq1he?=
 =?us-ascii?Q?SNzXEf61jXrNSdnDGiiznEh3k/LTa/6vMlkwkzaYbNyGEvTHQOqfn4Xvk2Ln?=
 =?us-ascii?Q?W1D58cOpfWVLzc/b6kYPUSQMf2/I388DbeacPnyLYwnwuUotdt6lb8QQH2dR?=
 =?us-ascii?Q?kEW1ClDy9R0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?W3WTKAQz7+YXKXLyOtNnD2tKCs+JuKtVwUG3OUXXI1PXQEVqmdlfacD42Q3e?=
 =?us-ascii?Q?WtjWU0Gg03Vx2QjvBKDLDIZeLY0Q3ZQ52rrdDaUfuZZvNGrNElB40jaHy/+O?=
 =?us-ascii?Q?olhRcGQpngzdG5cEoc9rOuqhm4zPSkva+Aiv/lHnobZHZVyWoTiqn/mzobhi?=
 =?us-ascii?Q?jdQ8Cxhd61SDkF+x5BDskF/VE4qNagmT5Yl0XjHIe0DzNNReRAdhWCkYDWGn?=
 =?us-ascii?Q?F2XjeVLgandW/IYwHOXAzrVRdVGkVaDZ2xvTp4c569+YyPBLgb5KvCuWe+Ez?=
 =?us-ascii?Q?wYrTVL88gcBZXLRHl+NoBXcYkXv1uDeRB7F0EiSxs7DxmRQsRd02DQFcmROU?=
 =?us-ascii?Q?hEPNn34ALD4hD01JQ9//fBUEHkKTW9DNrQxGd66nhrzUHhedKEe+76dlvmm+?=
 =?us-ascii?Q?e8FfXkhCsO4z5YFWkLVysDX9LzsbdEl5lSWZ7A8KbovxwPoNBJrAvBijdI3K?=
 =?us-ascii?Q?xkX6Ily6HDByx/6e5eTx+eBAY1HlF0WhPnRfbq313L/SKd7z/eny8i5q7uGb?=
 =?us-ascii?Q?vD4BGoxaMZU1yRH2in0FUzqmBYuxvJCfOAiy0T4a+0DqWy0NSh2Sgn7Pz+T1?=
 =?us-ascii?Q?nG4VdXWc5oHSS6LCS22azwxKQWc1xckp6ejCuW2lqAxU3SbZuqcFYOviLSnZ?=
 =?us-ascii?Q?+VIh44aTbfPybO3AXkTnmoeRb0nY54CarOwIuNwP/mcR+aAZFJ1uW46AbazN?=
 =?us-ascii?Q?TDti22s+GjYaaTJFCzkzdAPn30YVnuypKmcNdVa+0zXBDVn2wHdW6QVM9WO6?=
 =?us-ascii?Q?wyF/1iMb7fVBuCUBQxMloI/XguyY6xz9/BZ+YezcaNVX9GqEMTIaSBEd70GV?=
 =?us-ascii?Q?WrQxYWwtIK7nsrY3s0l53xJyW7pqdSjEPR26xwmM5/iVAkvYSsbtNq8+4Y/n?=
 =?us-ascii?Q?UODHPbVZ604ITHXwzb0I/cjrXgwpR86ol5vOQSr97pQvdmuapE2PS8PNwoUT?=
 =?us-ascii?Q?rD1X3DwJpAM3N75Jv07F0oqrEZ9RyYTLiafRBGEDS4G6FcXvl3dvecpE8Gjw?=
 =?us-ascii?Q?3EHdAHsfa3g1nb/iS/h3BE4Jp07t+qQeoIq1se/vpO1hB9ifBOLloEDZslT5?=
 =?us-ascii?Q?DO2UKwO2qfGEYTjf87+djUiUbrEP3xBszrboX0EIbXy2cH+IDGMxvtf9kjmQ?=
 =?us-ascii?Q?HjGrXV4yNq/XaLN6ufnMn/OiSYxPamOeeuLoe7lAAUU2RfaRfdlDlX8C6Xf1?=
 =?us-ascii?Q?gXnCf+DeJPxlapexWVdqrKe4ot75+1Xav8O3I8HkGK+Lg7LfHmQHQpRUrNlv?=
 =?us-ascii?Q?PAeHtbpMLehKmpDyfXhDO0mH+nLEs75fIc93tTB8+Tvv/RmCDe/idV7Ln+9G?=
 =?us-ascii?Q?nnELjT4Jz/uChgla+LlcQHMpg59LAx/60g5uMjO0EIJDquUxX6QGZQ2+yzdp?=
 =?us-ascii?Q?ZZkkxysZw2iUQSn+vjplWuJJenLnwq3IPJwyayNzchXNgxJ0x7I4iRUe38oo?=
 =?us-ascii?Q?D7nD4E1he2YwuqT5hVEyNzMeIHq0E9Ox2Y5F8Tx0fonsc50iRx7tPsWBzNO4?=
 =?us-ascii?Q?S/R0bhvQemTbBYnwcgvTK16QS3ocZ2ricX8ULEywca/Y2AsiWQ1cQay4UNC+?=
 =?us-ascii?Q?SXsvtkssisbV6E8UdnN/WwaShCJhw4uLofrDUjz7?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d056bc5f-3bfd-4495-27bb-08ddb260830c
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2025 14:16:14.4211
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RmBW8glupYWKMnwSohlym2/CrU1Qp3NB0VIxMF7HXPAf1dHKoNvnZMo3R7zoHQg3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7340

On 18 Jun 2025, at 13:40, David Hildenbrand wrote:

> Let's rename the flag to make it clearer where it applies (not folios
> ...).
>
> While at it, define the flag only with CONFIG_MIGRATION.
>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  include/linux/page-flags.h | 16 +++++++++++-----
>  mm/compaction.c            |  2 +-
>  mm/migrate.c               | 14 +++++++-------
>  3 files changed, 19 insertions(+), 13 deletions(-)
>
Reviewed-by: Zi Yan <ziy@nvidia.com>
--
Best Regards,
Yan, Zi

