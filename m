Return-Path: <linux-fsdevel+bounces-42021-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1248A3ACE1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Feb 2025 00:55:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 64ABB7A5A82
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Feb 2025 23:54:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 794CA1DE2C2;
	Tue, 18 Feb 2025 23:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="clcKTZMC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2077.outbound.protection.outlook.com [40.107.237.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFB3B1A8F6D;
	Tue, 18 Feb 2025 23:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739922895; cv=fail; b=Or+RgAqyh/hsV+srUccTztRX/NkgKMZ5ITmo8IKhJMyzQT9RVX2ArZO3K2i2sY1NIu7eSLqY0BKjOkzco1xCEN6aa7c6XS41MToPgVxB8Tt8N02ZGAqHp/G4FFN+IuNnjQyHvSpV1a4yqi3FhdXAmlZVRO9Fri6zHkknc3ku6hk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739922895; c=relaxed/simple;
	bh=UBd1NpUzGXZpksUHhrh0SJ+6roUyGAQxYeIGirOVxWE=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=qmZ2umbg+1daxos7eyTBQveig8573uhSYBed3rsmqkvVO5wPSXyhbGyvP1le4RC2t28EAtAJo8Q1NPYVnw6//4tbSMm0bantoqqSyAEDPufHcL+p9i1jj9LiA2RB7E9zgh6JcuSavAgR+pm1uFM/3BLimgP47CHabXOdrhr/rBA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=clcKTZMC; arc=fail smtp.client-ip=40.107.237.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a+wq66WSH6OuKuzn2FWFY1clhNHpZGCWIHg47ErXV6BDNS6koOC+zJO5oCFfHiv8ZEWnJwjP7tPXFzdLmSzpLtIhuq6LYTOjPZnU9e+hQ2G01SgBMw5VDk7uxgtJr2nD5nSR6mC76c220NfV7wAclLCcT5FkJ48/j+MeMit3lGQhA22fO+yAF4I34JKCAhyUxvcAUIJZHWAbSfsaEzsLsvxKWyJYi5D4utpkzUBSkokJ+XdZXozgTQYYFwPjK2ZrTwEoqGJqeLg5M0ulX7QCHwn5p9WklQIo2aZZ22a+Oilt22+6DVc0NmhC5u5MVs77aia2tNnDJnnQFy8Z5Mp4SQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SOkXQfmfQt8wTq9weoeJzYUJFFptcZEOF9Y+cRn/QWA=;
 b=XrujqR1STowGx4TGgwLaKVaQnMoDOd2AWCauRONBLbWUpPW4hAOSbQMYo+6i8mLvkdlKdRMc8n2OTodtw6rOLUF13DNYRZjLBqSRD43t/t3s1/mNiNzSrDaK/NFpoTxS/U76Jdw27ZkM6RKcOl/pR8B2wvtoqEmYvhjNY58RavyVkpnx3hKzYmJjiE/pZlXha3l92t7bct41fp5Sqz1bPpapu4WWC945vs/xI8Thp+s3wF46inabDILfwytksNvCuwcTPUHaIHX6feY+iF7K5HvVHgI8HXgzdTlf7MbkR3Qk+Oa0KnMr5q9z15LX4TDkKy9i1gyJ0gvrBrwhiW6h0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SOkXQfmfQt8wTq9weoeJzYUJFFptcZEOF9Y+cRn/QWA=;
 b=clcKTZMCrO87Z9mPi4ElYl4bj8aOcUQdaQhgUzSceE750dQ4TxwlQMAAreFmCanGAWFa9IL3w9hQaRhyfTrmcalXp77s4d7HXGK0ndAfVvkYn3wNyYv77h/puyRT6LJswgeZNDf+wxhnFS52PIJC1Wwvwrpvl+pVLK12G3IZ4pErwzX3dmgvA1FbLFTBvD21x1Cb/i4PGvuNlR2N0d1xhzKlfb0HvszZJokt8sw20E3dUCY1aRqX/2DyImKx8q8W+iVqEBoRX8ghmG+Au8ZYIZFJm9T+T0os6xV3tb2uFtRIKu4kA/MvBfX+dZsOZfmJkYdLVsiu3EcBL2HXwciE3Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 CH2PR12MB4326.namprd12.prod.outlook.com (2603:10b6:610:af::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8466.14; Tue, 18 Feb 2025 23:54:49 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%5]) with mapi id 15.20.8445.017; Tue, 18 Feb 2025
 23:54:49 +0000
From: Zi Yan <ziy@nvidia.com>
To: Matthew Wilcox <willy@infradead.org>,
	linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Hugh Dickins <hughd@google.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Kairui Song <kasong@tencent.com>,
	Miaohe Lin <linmiaohe@huawei.com>,
	linux-kernel@vger.kernel.org,
	Zi Yan <ziy@nvidia.com>
Subject: [PATCH v2 0/2] Minimize xa_node allocation during xarry split
Date: Tue, 18 Feb 2025 18:54:42 -0500
Message-ID: <20250218235444.1543173-1-ziy@nvidia.com>
X-Mailer: git-send-email 2.47.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR12CA0035.namprd12.prod.outlook.com
 (2603:10b6:208:a8::48) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|CH2PR12MB4326:EE_
X-MS-Office365-Filtering-Correlation-Id: 8cc3e83e-5e54-41c9-3d3d-08dd5077a107
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?mJkXBCkN89HwvlGiQw/RofuRfDs8hzpJ8iGNxFXSyF2z0G3drGU3qPq7/TFj?=
 =?us-ascii?Q?TwvTJYQ06L62dmRHv6UCUwGugLd/t82owxom4XcGbPXHsedBI+GZIV9qNGTB?=
 =?us-ascii?Q?NEjjGDhAc/h8tFQprhUscfGT7b4GY4lV45N90wJaf7vD/wwXDRPIThfkLqkb?=
 =?us-ascii?Q?r1Kpv+7PRPECKJff6Q5PTsc3CHd7rvqTo/5AWk5BnQMgZZNFW9ckeiqVx83t?=
 =?us-ascii?Q?ogJsaV0hKQbvfpr6hQvvReCk+wpm+/NjLp+cm6JFOq4j+FBvifTLu+gMJhHB?=
 =?us-ascii?Q?fwf9gXn03ycEcWP7+U0XKr0HrpHQXE6d2Bvn4zT+wr87OtyBFIrCzEXSksjg?=
 =?us-ascii?Q?fpYVxa9vSZmdRCwOSk/s5nox1QD1RGFbMVr+GhC6f9emJdUzAQgCg26yQmnO?=
 =?us-ascii?Q?hjhNyGNpMmjlO0oRLqJwKRjHYWWZLjtrwChW8i1JCFEfOXEM2MfcwaBPBghx?=
 =?us-ascii?Q?obW2CdIJRWuaNe8kt0OQ6QOilWHA5++s1rb32KBfBiMlMm42+xygfOrvyRSS?=
 =?us-ascii?Q?kLvviw46cjxl6/HR83bLmSQ7iW8LVKBYzBJWc9bdjamn2+JIehw/8KV3PhD4?=
 =?us-ascii?Q?90JquZX07D62MKoVSSsqKNLj9XTFCflzCax9D5toLKZVRHJcQukTuIO52Z2B?=
 =?us-ascii?Q?Jf/hd/8ofopykmr2ML0CJwZSWw8m97GbfgzscimArFy5mTv/yxCPq8xZzbvE?=
 =?us-ascii?Q?sg4pY9tUp/TZx2pbm1IgSUHSkWiwwXAePgrZ/qqc85kt0WRmrzl4xIklC7XY?=
 =?us-ascii?Q?WSONx2CDM5ew7nSvOC39fu/U1gdXYJ30d7Vvcq+zWaZWUao6zR+KtJ3JJpNt?=
 =?us-ascii?Q?8IjTH2qvG5lJEKgug3bP3BUvZ3p6lzXXccTG7miOeu7IH3oz/FkWNSUcrvgA?=
 =?us-ascii?Q?dvLSWN5yDeMkuLXJGiy3bWVcv31cGrR/Z3TNXC3Vvx59+vtSmFoyfQFDMFT1?=
 =?us-ascii?Q?JLtrhXpononmHgIOQWg4GZP6m1t3W9cuiRO1uXJFgV23mB3E5W5lvZUEdmdi?=
 =?us-ascii?Q?WXQPdgU2wJumLSxTMSqAI/Lo+rc7lRbmwWcH7fEt2/MygJzte/Fq/n/N0vNw?=
 =?us-ascii?Q?A1G7Tf7dmkgbI2f+s5iHsBl1hhdzl/rgGyIgOWO3MYOo5rDVT5BN8HcCe/uc?=
 =?us-ascii?Q?Z6TlHCEiTcDVciHo/zIQcQHHQvyVTMsD3DxmGvv6C05Hbn0r02tN1Ewpyvp9?=
 =?us-ascii?Q?QO+ViBdaXBxelHruihE+9C1Nlrzd/IG4RpUh/hMH6ljYykerb5fyFfP6feuR?=
 =?us-ascii?Q?zsCcL+vfcoXj2Xsy7HPcnhDZ5GpEJ84h3+70Y0TarA/AurRE40h/li7OMM1E?=
 =?us-ascii?Q?VOaXQHWeP3GIi+GB/JMoMzXA2j94nd7SdPgpeT9AOQ0odKUMqjzqIpPIl+Nw?=
 =?us-ascii?Q?MapQyQg5n4ra0H7bQvjU323y+bRf?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?TT7SlRz5lPBFEcsk47h+pBOgScYef8D0Iap/MfehulFqu/IAefoVzmhHkTa8?=
 =?us-ascii?Q?BCygvMUksnI43PrQZa29udKWVOir2xYbST5Dh4wIuZCvh1TF+ibCqqeGp9UZ?=
 =?us-ascii?Q?UWO1M4XgHw5ox3+XABqYyPDMp51028Syl/j/YuGbmk5ZzBnmCPhrZw+2UxXl?=
 =?us-ascii?Q?xDnMFZCAAhFjI8d/8ZBdhddXj7q1VyqTokakoaDCpMGFWIO9qT2OSErNBNl9?=
 =?us-ascii?Q?diRtPvymoo2ZcGhbyIJhwOdXAfxJHC/YJBANa6gGE8ly5W3JjjDzV214/VzL?=
 =?us-ascii?Q?tGo5aNH3KOcdHQPjQ04KZ44OrJ/FY86vt3Jx2Q2wD31B2OLfwBkRlBbQWAGz?=
 =?us-ascii?Q?BKJgaPh6MEseQNF9XToO0mAMX3MwuxU/+Q2gmKQNuBTlpS+b7rpkIoPVWace?=
 =?us-ascii?Q?F+0Okgilr+d3O+3XqrnDNoWE9SGh6vdmMapA5Cw9EI4bYRCd+ii9U3gdDdbS?=
 =?us-ascii?Q?iYrQm5wdj5xVqGAZr+/04ZCDMdDYWSMJFi8uXyJReIvqZDXB9ne5wkGfbUbx?=
 =?us-ascii?Q?lnFSPFWBLj7yIdk8Fe96dOViwGofeoakdji3lJc7JFwgLDxw64RBs3bnPV7V?=
 =?us-ascii?Q?naK/qvujLSN1B0KlGHon3CkmnCmy/PlsJCwLCQsrykOr/Ug6nqpYz65VSr+W?=
 =?us-ascii?Q?Z/7WkJlJsgS+k73zNxnnylc7NF3bgYypJbgov6VgL+aLmiUMkca5xgbgVcyC?=
 =?us-ascii?Q?4Ipus4sFZZ8IuNnJVVrtlBXbgyBWiaqceIMe1IVc0OVzHbjsu04qOyYojRgR?=
 =?us-ascii?Q?Cv6BFpHBmKKfFSaVjwXQ6tmEEmSaJm1le8O93xtF1w9zdMNS7Ua3foMa+7yE?=
 =?us-ascii?Q?lRLvSp+CW0IlkQ7pXNa1I3iFjTayCWAh/WTzXSXg/tn2EgOv8oEdkD4Okogm?=
 =?us-ascii?Q?T14vN60f58JJomNaI8gDiH4uS5ySAdR5JxmDQGnXXYtW5E08B1o7r8RKWQ4W?=
 =?us-ascii?Q?nCcK+aZcvPwTUhDQLKveano4tT7rAdbcODpc7Qn/7vk2p/8oXy9DXIX9E9aU?=
 =?us-ascii?Q?WCDj0RFf7uxSoN88YqpmnlBVVTdTJhsHL3mZheSz8qabBGD4tBSSP+GQnehx?=
 =?us-ascii?Q?XF1o1Bj9NTmVj5Sk7pLzie4lL8VKfnbb3SG8AhIo7r4HmLusXWAfdSzUHE82?=
 =?us-ascii?Q?+0NGWUshCXGd7TtdhqJIsUsudSdYLWjY1A8xgxF7Hb15qKTuSJchCWupPnQm?=
 =?us-ascii?Q?kCbb+9dOGW5RTIfdVmsogFYSCOQ8+9izI98zztsCB0Q4VFRRqgRtTdia58uz?=
 =?us-ascii?Q?OYqT6/74qFpq5aMBiAsYpKN5gsPlIDKJMxekJC1UL1vYQFx46AxdNC63NLjz?=
 =?us-ascii?Q?4bqH9U0/Pqgu4VUNrCvwRRzGL9NQQPQK1n8C2YOE+mzF423E1KS3GGNh/6oS?=
 =?us-ascii?Q?RurWjLnjc8tG73xhwgvAlkuahUyUUV9q0cyJceN+ZkEStpd+wyVRtbfTbR4H?=
 =?us-ascii?Q?dUg58iHn2bmQp9vLs60me4ILrchL6/HECOWDv+CslqpyLIdzoOoNaOniF4oc?=
 =?us-ascii?Q?FEQ2OwV/2hQOvNHtdoFg5xei/2VnRilzzusQW6Zn4w88tjvZFlFXmhWvV3Fp?=
 =?us-ascii?Q?yCydUf8WW2hrr6mw3U/xLYI5dwpog1vDrKtB/VRS?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8cc3e83e-5e54-41c9-3d3d-08dd5077a107
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2025 23:54:49.0519
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wlgWaugObab3lutVO7uNVpBW9LrQRg+lPyOu0GL3/biXi8GyCPW7pwUFDc+HNgn2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4326

Hi all,

When splitting a multi-index entry in XArray from order-n to order-m,
existing xas_split_alloc()+xas_split() approach requires
2^(n % XA_CHUNK_SHIFT) xa_node allocations. But its callers,
__filemap_add_folio() and shmem_split_large_entry(), use at most 1 xa_node.
To minimize xa_node allocation and remove the limitation of no split from
order-12 (or above) to order-0 (or anything between 0 and 5)[1],
xas_try_split() was added[2], which allocates
(n / XA_CHUNK_SHIFT - m / XA_CHUNK_SHIFT) xa_node. It is used
for non-uniform folio split, but can be used by __filemap_add_folio()
and shmem_split_large_entry().

It is a resend on top of Buddy allocator like (or non-uniform)
folio split V8[3], which is on top of mm-everything-2025-02-15-05-49.

xas_split_alloc() and xas_split() split an order-9 to order-0:

         ---------------------------------
         |   |   |   |   |   |   |   |   |
         | 0 | 1 | 2 | 3 | 4 | 5 | 6 | 7 |
         |   |   |   |   |   |   |   |   |
         ---------------------------------
           |   |                   |   |
     -------   ---               ---   -------
     |           |     ...       |           |
     V           V               V           V
----------- -----------     ----------- -----------
| xa_node | | xa_node | ... | xa_node | | xa_node |
----------- -----------     ----------- -----------

xas_try_split() splits an order-9 to order-0:
   ---------------------------------
   |   |   |   |   |   |   |   |   |
   | 0 | 1 | 2 | 3 | 4 | 5 | 6 | 7 |
   |   |   |   |   |   |   |   |   |
   ---------------------------------
     |
     |
     V
-----------
| xa_node |
-----------

xas_try_split() is designed to be called iteratively with n = m + 1.
xas_try_split_mini_order() is added to minmize the number of calls to
xas_try_split() by telling the caller the next minimal order to split to
instead of n - 1. Splitting order-n to order-m when m= l * XA_CHUNK_SHIFT
does not require xa_node allocation and requires 1 xa_node
when n=l * XA_CHUNK_SHIFT and m = n - 1, so it is OK to use
xas_try_split() with n > m + 1 when no new xa_node is needed.

xfstests quick group test passed on xfs and tmpfs.

Let me know your comments.


[1] https://lore.kernel.org/linux-mm/Z6YX3RznGLUD07Ao@casper.infradead.org/
[2] https://lore.kernel.org/linux-mm/20250211155034.268962-2-ziy@nvidia.com/
[3] https://lore.kernel.org/linux-mm/20250218235012.1542225-1-ziy@nvidia.com/


Zi Yan (2):
  mm/filemap: use xas_try_split() in __filemap_add_folio()
  mm/shmem: use xas_try_split() in shmem_split_large_entry()

 include/linux/xarray.h |  7 +++++++
 lib/xarray.c           | 25 +++++++++++++++++++++++
 mm/filemap.c           | 46 +++++++++++++++++-------------------------
 mm/shmem.c             | 43 +++++++++++++++------------------------
 4 files changed, 67 insertions(+), 54 deletions(-)

-- 
2.47.2


