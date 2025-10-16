Return-Path: <linux-fsdevel+bounces-64335-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 841FEBE15E3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Oct 2025 05:35:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 935AC5424F4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Oct 2025 03:35:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDB352192EA;
	Thu, 16 Oct 2025 03:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Y2/YlfVj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012047.outbound.protection.outlook.com [52.101.43.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CE32433C4;
	Thu, 16 Oct 2025 03:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760585704; cv=fail; b=X1btx5S6kkVm/cPZMShzIKTNnx1MSEdFDZfKZ0831Dh9Ivsq9dUPalss9pDXvP5oB9c4SK9KufbYdUOHvmBjNWuhzq55DN3bRMniACMRhvTDtkCcreVm01XLEvkYuO8cUMUBq5g8VlfrE9zxDFBhw0XuKC37h/Kj3sz4vCsNDP8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760585704; c=relaxed/simple;
	bh=ed2Oxry4yzX83h66xwu1WKTDa3N2r5qceNk4+K/f974=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OzQabNOLLEV4UOyhMPzJZrzTvMuvZN9TX92Xwasxr5vleoElQlobM9jBAtjDgfGTtEtQQqjzMHED1+4IwfRYRyWa8E7mrMpg2Iz9DjtE/gBFyQ55mNYoO/7zR9CobaObEZINhOChz92ytIPltJ0mQszmXUJtAqEcA3HPokGrPwM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Y2/YlfVj; arc=fail smtp.client-ip=52.101.43.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cdHFPACTDzjvQ4xgJODHY9/9XJt0fbVpK/megektfL2aZoOOay2J03g2OmSzN3twEyNiuX0T5yLqI1xs5pm56c3yOozGH7joVy9GW/An3L/VEJ5Q7kz/qaScYEiT8IpUVVzwdYVQTQ4ABFxXbtq9ZWVrhIcFfnXK2DLmiZ/8+xJL9SSFC9N2HHPmK8fmbj1XUNpR6sAoQvh4dN/82cAIy4+yKfKH1VlXrVXZ96qFCl/YZ9J3rMwjReLfN61O01jN9USZwhAFo/4QMVBeBWhiI8F223rKVm2uoSRJO77zgCD+0KPs4XovcsXr3DNC8CWZDlGW/qlzsutfGyc8yLyDgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QOllv8gnRWUd1S9T7Rmu/2JW60l6ERdeszE4tj5beG0=;
 b=j4Xgz5qOu8k042H3mzv20KG6o+bgqQmdozuxHcHH7oqvC0X+ZQ/oQyt96/g7dTaEl9MLU3vEcAu0dgP9hc3vSGvBHbOlS9OBKlRMx+ouj887ItVW5qbXsio1CN1hdw03I3RAL6BUxXE0ABV2FSD9MUEsDFEaxOAmWX5wQlRUb8vuvmp6xBQnfvS15LN8jS7mHFHswYapgW1+3WZ2HocxCDLwJkJjYGXXox4fecGjfBid2NqYbMhqcE44WXBLWA2oQHBQmWlBEq7HZbXQFJL/wnL9a5e5z/h9hhsZaBTXMpdjGQEH+jy5Mp01d5dAX1Z+QAyX3DI2XZ/w88z5djHeMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QOllv8gnRWUd1S9T7Rmu/2JW60l6ERdeszE4tj5beG0=;
 b=Y2/YlfVj86eUViZToV1ROVmcg6sgA1amY+N4QDTOGnpdZ/L1UP1lBTtaPXm3vzuWqI/xNTeKhwsd2+wPpQnq5tSXZMDE36MTgQMWpiTqJmAOPzkNVN8tMrBoboyXx2xqj4X+6eXbH+zz+80P4TYusTEHREheHcgz5Qcf2J0QRxNxzRPs7ECLeRS44juDz2W6Pw2HaWUhvsPHXkKm8igVdM4U7AMGlTTD1NQovA1lBIzsHIU2WK+6kn0aZyuWoABvN541kTSEVA611DNvDN86SKYTRltCHR1eZhNysVxon1OxcrGSmGsHJJQFJGQV1EYV9FgfJMnlDid1NlevoPzPxg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 CH2PR12MB9493.namprd12.prod.outlook.com (2603:10b6:610:27c::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9228.11; Thu, 16 Oct 2025 03:34:57 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%5]) with mapi id 15.20.9203.009; Thu, 16 Oct 2025
 03:34:57 +0000
From: Zi Yan <ziy@nvidia.com>
To: linmiaohe@huawei.com,
	david@redhat.com,
	jane.chu@oracle.com,
	kernel@pankajraghav.com,
	syzbot+e6367ea2fdab6ed46056@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com
Cc: ziy@nvidia.com,
	akpm@linux-foundation.org,
	mcgrof@kernel.org,
	nao.horiguchi@gmail.com,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Nico Pache <npache@redhat.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Dev Jain <dev.jain@arm.com>,
	Barry Song <baohua@kernel.org>,
	Lance Yang <lance.yang@linux.dev>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Wei Yang <richard.weiyang@gmail.com>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Pankaj Raghav <p.raghav@samsung.com>
Subject: [PATCH v2 1/3] mm/huge_memory: do not change split_huge_page*() target order silently.
Date: Wed, 15 Oct 2025 23:34:50 -0400
Message-ID: <20251016033452.125479-2-ziy@nvidia.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251016033452.125479-1-ziy@nvidia.com>
References: <20251016033452.125479-1-ziy@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN0PR02CA0051.namprd02.prod.outlook.com
 (2603:10b6:408:e5::26) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|CH2PR12MB9493:EE_
X-MS-Office365-Filtering-Correlation-Id: dd7ce1e8-f3ac-46ba-2bfb-08de0c64fab7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?V6Zz+RxUIL6+8gTwIDElgi317iiIEd+lAJuc49ML5XDVoPMmcttoFSooRQl6?=
 =?us-ascii?Q?1HfoA5Ryf5cyaX7x7EKeQrC0mk5q+FNbVb0GM7B2ZfqJ0uLkWZK9g+C6giEM?=
 =?us-ascii?Q?Ytyejxm8fNLDbONgT5z3oBYhnTHG0Pq4lyT02vj/TIDB+/ITGscEggUcW5S4?=
 =?us-ascii?Q?DLNGhB8Y/utg4u1Ez+vuhwzE/Uhz5UcRuxLhtrPYD3Zg/J+iaxhwTtMYdt/7?=
 =?us-ascii?Q?Bfmobpnz7SAFNu2gcuUPTvtGfibNnHCrzmE3yL1Pde1gim4J1ZUEyhAEYHwb?=
 =?us-ascii?Q?5CMbdtAuWa4LoFmNV59t3bsG2UxFbam/C9BoEzpxVBdA82Q/CvjM9W/SafJT?=
 =?us-ascii?Q?XsZfnwCErNXwImgPOIL/7Qlx2+0GIQBa3uKUhDm+QXWtkZl6Ff6ODrjrz89p?=
 =?us-ascii?Q?Ex1u25NHr2nH1RdA7Or44ntgbV8abOImbZCTFyH2hR3iid3wn2/Oa+xyNPYm?=
 =?us-ascii?Q?sUAIz0hNa0k7AgHNMxHXkstwRVEFCnxO9TZLG1LV/wnFeCSRWclWzCY7dpFJ?=
 =?us-ascii?Q?UwXYKwOXQ9dTlWMdhG+OPRzJGAWMw1wuXXB9NUFtQ2fkL9cRpvAXrYAqn8pn?=
 =?us-ascii?Q?rThBGM6HXxRPq9vk84rq19ZgJE/06Q5nipOBNzz0Mb18Fn1LEGpXhAMrYaoe?=
 =?us-ascii?Q?HuwaUiS8sybfOncPmufwYKmQcC/uT86R0Mf9XfuQUu2wmVlrn8cuBpYKGbgl?=
 =?us-ascii?Q?0bX9n6lxyVq4Hs2elkTBm6gPlKm1UpuQEX9TO65/DTzofww0NzQLUeySWCvk?=
 =?us-ascii?Q?ahYmT2HKtEba/0clH91/QvvXId+00ODy0RmCBKyVDTyTc5xcLj6Jin4bPuyx?=
 =?us-ascii?Q?DVr+z9B4EO6FVFCzuNL6Zif3gvKvmrpo9lr4538bjmrLJZIPjXoiRvhJ1snx?=
 =?us-ascii?Q?uXW0GJ9g0NvUR8gk9ooK2VIOVrm5+PcuTo3BmtPcclR9uUNokQHL3wze7hig?=
 =?us-ascii?Q?chtnXzGhZD+67XetaPiEKFBnE/Ddfa93VKMyxTbcdMobY4yCoGiXRw6Ur7+2?=
 =?us-ascii?Q?AC0b+jae5oHng4siXEUbrw346rDuJOsAeBQlq3Fab4reszaAwUGif8W9a6ew?=
 =?us-ascii?Q?tNKwp2Ev9VcXCdSpZcHIU2AdnXw3PSnn3IZMbcxfm04VSaTJFHB97ltSeCKB?=
 =?us-ascii?Q?JlwPJwxAkKvkDX+PFXAI2CuOHGz8XHgUYWyNWil4Q9g34NeREn4gRfhpb2DX?=
 =?us-ascii?Q?xE/bnrtatbOEc94shbSu53WvGAcGYbvuwF+v1TROUxv5mGB0j62utv0aRmH7?=
 =?us-ascii?Q?M5YVNmnwBcrsRbYpsWVfgAFFMHwaijwbYffftoqYqSw7V1oh0JT4Vn8NU8ho?=
 =?us-ascii?Q?OlZYKidmWbTE4Fb8C0fhQvSaMZvwLPrU11/0M15yWCaZOPtQFJwgJOVY6l0G?=
 =?us-ascii?Q?TBl7MF6TgzARq4nMGMnE88CGRzqEVjHubbmyY0KxLrERDx5rUs959pWVfiJs?=
 =?us-ascii?Q?cgP7cyBKZw3Rm6vRusxsjwbpi2a6dOjXsq55p9EEGMCVoK28Y5NGiA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?EKh0c2FywqZVRqZeyFz6E4f4FbwrraTyCrtBZqWFSqgQUL0XlU5d8TIggGqx?=
 =?us-ascii?Q?vqBucOaTn3rdS7/lWPJNDidgBVCMQ+CSGPL8gZXpq4arH2+SF1L6sNNB5BFG?=
 =?us-ascii?Q?3OIGKt5FszlwMphp2WJSVhvu+OGqXC91lAtdEjiB2w7Kn9F47ZH2SoP6PVoX?=
 =?us-ascii?Q?MX9Ew79v2oqnSOASAIu3RRwJSRYC0iNJhZD4/ESMeRYeXwpIE6MHXYmTdt4H?=
 =?us-ascii?Q?3/M0I5RYUaL5WpveH62UGmU7YdI1SGs+dagKt7PI/kj+HOqznaWapjicegmt?=
 =?us-ascii?Q?UQz3YPPv7UDCJfiKY6QHfv6aBwyUoOy9qtS/eBKNxt401b87pFIbURN5fwvd?=
 =?us-ascii?Q?J6oBmCPFzReJ+RK4ZorAMfcBKtt1WLrb1TPD05cmZnEwYiPpa56yRjqB9WDY?=
 =?us-ascii?Q?pAoscIwRvU0S8MCmJ5Gw3sHSJO6VRDN9kYWzsbbQrBjDOepMJA1WcNhyF/f2?=
 =?us-ascii?Q?hsF/JzRSNLdK1QcLTs36DG30IlsdDkXFRfRLjrmwwfwF4dSEJOVcyJoCl/Me?=
 =?us-ascii?Q?Flhv8wdmqodkWvwgS1c5+GpUJtQvX+Ysw8USg+v+fY0S9mTQEkoSGdB5ta++?=
 =?us-ascii?Q?3/2G/lZamgrwYwcKycS5DZamQONwFuJttn1yNNSDS3WmTLRtO6qfM24EQQTQ?=
 =?us-ascii?Q?xsh3L7urcPnbPyecwfwKb0Org3knqLjQ3iOOyZxsLQcQjaX5TMvrKjqpcLV0?=
 =?us-ascii?Q?DOIgKBw06uAkFv5DJYBm9iKMQMcw29PeoM8dgQ9Mr+AroIDo5fF7HlwReX+Y?=
 =?us-ascii?Q?p7vNtlji4lwfkaFPISvITA4A1p0AE+X5EvGU+sK/bMJnglskznFd8ijb+Q/w?=
 =?us-ascii?Q?tW7HC+TzXEPs/l5zYQUBuh6z74ogPrHNBbiIkwFC6KK9wnZCB7Gbgq7l8aEA?=
 =?us-ascii?Q?hDvHrbBl11WXdEIvMesN0SrKFow+KIV2CSDqDegfrb4NO1SCctKLK6b/95U/?=
 =?us-ascii?Q?i49HtTZ5XP90iJjzn0lbBBQisggc4TnDMHJLPLp33FC76b76pSKJexS0v1lW?=
 =?us-ascii?Q?iyF/DlX0y5c4OaCU1qRA/76t1Cingo5lmWDU4W/khiV2/7DKWNwb1VtU5Noa?=
 =?us-ascii?Q?tvvhCLGNQ0QPXDH5Gh4dJDYN3vae3uA4gwi3cr0GKhJslyL7ettCW07dQ/vV?=
 =?us-ascii?Q?8DMoCWrGYWrNhokp8uRQYePLk4hJokG8mMjYxvtEt9LdVkMxv0RDg4JrtBgb?=
 =?us-ascii?Q?X0d5PoxoFYE3sBpiNt44pchVUNReYPnwcMkq+MVXaHmUa2Z1ApPjb9MlDVPZ?=
 =?us-ascii?Q?25NtbcoYX9JeGQ9G0IGLrRQshjK7aGSjZRr0tqoWpHwGgB/xMzW2SRXp1OJV?=
 =?us-ascii?Q?mcJjUhMbZ0AjW9SgVlNzdgUcibQi7v+kTW/3uTsZymAM9BWxeermo+GGIoeI?=
 =?us-ascii?Q?7+xFrckSPCIfHDTShvVpLxPhP75fk1feZExVccdrv2XW3jqvnC8i9Zugd/+Q?=
 =?us-ascii?Q?focp6XszSav5vAK4Em2FngDWkKXu5krPxBM3p/p5PDhDgsmMjvSc3gcf+B0N?=
 =?us-ascii?Q?wV3buQpSRDC1WtExiCyykJsMLIHmEVH7kCFE8c36dmysie8gekkWAO3Mc9/y?=
 =?us-ascii?Q?Q3VfEMyod59Qj/dhNgNqV8fvdzTdE8OVx4u3yiZ5?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd7ce1e8-f3ac-46ba-2bfb-08de0c64fab7
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2025 03:34:57.6746
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: er/n3zRThIlehSqwmRgrAzsFuVFNfJKRuXUr1GfAXG2ARZB2JT208tBhUIFsC2tD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB9493

Page cache folios from a file system that support large block size (LBS)
can have minimal folio order greater than 0, thus a high order folio might
not be able to be split down to order-0. Commit e220917fa507 ("mm: split a
folio in minimum folio order chunks") bumps the target order of
split_huge_page*() to the minimum allowed order when splitting a LBS folio.
This causes confusion for some split_huge_page*() callers like memory
failure handling code, since they expect after-split folios all have
order-0 when split succeeds but in really get min_order_for_split() order
folios.

Fix it by failing a split if the folio cannot be split to the target order.
Rename try_folio_split() to try_folio_split_to_order() to reflect the added
new_order parameter. Remove its unused list parameter.

Fixes: e220917fa507 ("mm: split a folio in minimum folio order chunks")
[The test poisons LBS folios, which cannot be split to order-0 folios, and
also tries to poison all memory. The non split LBS folios take more memory
than the test anticipated, leading to OOM. The patch fixed the kernel
warning and the test needs some change to avoid OOM.]
Reported-by: syzbot+e6367ea2fdab6ed46056@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/all/68d2c943.a70a0220.1b52b.02b3.GAE@google.com/
Signed-off-by: Zi Yan <ziy@nvidia.com>
Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>
Reviewed-by: Pankaj Raghav <p.raghav@samsung.com>
---
 include/linux/huge_mm.h | 55 +++++++++++++++++------------------------
 mm/huge_memory.c        |  9 +------
 mm/truncate.c           |  6 +++--
 3 files changed, 28 insertions(+), 42 deletions(-)

diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index c4a811958cda..3d9587f40c0b 100644
--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -383,45 +383,30 @@ static inline int split_huge_page_to_list_to_order(struct page *page, struct lis
 }
 
 /*
- * try_folio_split - try to split a @folio at @page using non uniform split.
+ * try_folio_split_to_order - try to split a @folio at @page to @new_order using
+ * non uniform split.
  * @folio: folio to be split
- * @page: split to order-0 at the given page
- * @list: store the after-split folios
+ * @page: split to @order at the given page
+ * @new_order: the target split order
  *
- * Try to split a @folio at @page using non uniform split to order-0, if
- * non uniform split is not supported, fall back to uniform split.
+ * Try to split a @folio at @page using non uniform split to @new_order, if
+ * non uniform split is not supported, fall back to uniform split. After-split
+ * folios are put back to LRU list. Use min_order_for_split() to get the lower
+ * bound of @new_order.
  *
  * Return: 0: split is successful, otherwise split failed.
  */
-static inline int try_folio_split(struct folio *folio, struct page *page,
-		struct list_head *list)
+static inline int try_folio_split_to_order(struct folio *folio,
+		struct page *page, unsigned int new_order)
 {
-	int ret = min_order_for_split(folio);
-
-	if (ret < 0)
-		return ret;
-
-	if (!non_uniform_split_supported(folio, 0, false))
-		return split_huge_page_to_list_to_order(&folio->page, list,
-				ret);
-	return folio_split(folio, ret, page, list);
+	if (!non_uniform_split_supported(folio, new_order, /* warns= */ false))
+		return split_huge_page_to_list_to_order(&folio->page, NULL,
+				new_order);
+	return folio_split(folio, new_order, page, NULL);
 }
 static inline int split_huge_page(struct page *page)
 {
-	struct folio *folio = page_folio(page);
-	int ret = min_order_for_split(folio);
-
-	if (ret < 0)
-		return ret;
-
-	/*
-	 * split_huge_page() locks the page before splitting and
-	 * expects the same page that has been split to be locked when
-	 * returned. split_folio(page_folio(page)) cannot be used here
-	 * because it converts the page to folio and passes the head
-	 * page to be split.
-	 */
-	return split_huge_page_to_list_to_order(page, NULL, ret);
+	return split_huge_page_to_list_to_order(page, NULL, 0);
 }
 void deferred_split_folio(struct folio *folio, bool partially_mapped);
 #ifdef CONFIG_MEMCG
@@ -611,14 +596,20 @@ static inline int split_huge_page(struct page *page)
 	return -EINVAL;
 }
 
+static inline int min_order_for_split(struct folio *folio)
+{
+	VM_WARN_ON_ONCE_FOLIO(1, folio);
+	return -EINVAL;
+}
+
 static inline int split_folio_to_list(struct folio *folio, struct list_head *list)
 {
 	VM_WARN_ON_ONCE_FOLIO(1, folio);
 	return -EINVAL;
 }
 
-static inline int try_folio_split(struct folio *folio, struct page *page,
-		struct list_head *list)
+static inline int try_folio_split_to_order(struct folio *folio,
+		struct page *page, unsigned int new_order)
 {
 	VM_WARN_ON_ONCE_FOLIO(1, folio);
 	return -EINVAL;
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 8c82a0ac6e69..f308f11dc72f 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -3805,8 +3805,6 @@ static int __folio_split(struct folio *folio, unsigned int new_order,
 
 		min_order = mapping_min_folio_order(folio->mapping);
 		if (new_order < min_order) {
-			VM_WARN_ONCE(1, "Cannot split mapped folio below min-order: %u",
-				     min_order);
 			ret = -EINVAL;
 			goto out;
 		}
@@ -4158,12 +4156,7 @@ int min_order_for_split(struct folio *folio)
 
 int split_folio_to_list(struct folio *folio, struct list_head *list)
 {
-	int ret = min_order_for_split(folio);
-
-	if (ret < 0)
-		return ret;
-
-	return split_huge_page_to_list_to_order(&folio->page, list, ret);
+	return split_huge_page_to_list_to_order(&folio->page, list, 0);
 }
 
 /*
diff --git a/mm/truncate.c b/mm/truncate.c
index 91eb92a5ce4f..9210cf808f5c 100644
--- a/mm/truncate.c
+++ b/mm/truncate.c
@@ -194,6 +194,7 @@ bool truncate_inode_partial_folio(struct folio *folio, loff_t start, loff_t end)
 	size_t size = folio_size(folio);
 	unsigned int offset, length;
 	struct page *split_at, *split_at2;
+	unsigned int min_order;
 
 	if (pos < start)
 		offset = start - pos;
@@ -223,8 +224,9 @@ bool truncate_inode_partial_folio(struct folio *folio, loff_t start, loff_t end)
 	if (!folio_test_large(folio))
 		return true;
 
+	min_order = mapping_min_folio_order(folio->mapping);
 	split_at = folio_page(folio, PAGE_ALIGN_DOWN(offset) / PAGE_SIZE);
-	if (!try_folio_split(folio, split_at, NULL)) {
+	if (!try_folio_split_to_order(folio, split_at, min_order)) {
 		/*
 		 * try to split at offset + length to make sure folios within
 		 * the range can be dropped, especially to avoid memory waste
@@ -254,7 +256,7 @@ bool truncate_inode_partial_folio(struct folio *folio, loff_t start, loff_t end)
 		 */
 		if (folio_test_large(folio2) &&
 		    folio2->mapping == folio->mapping)
-			try_folio_split(folio2, split_at2, NULL);
+			try_folio_split_to_order(folio2, split_at2, min_order);
 
 		folio_unlock(folio2);
 out:
-- 
2.51.0


