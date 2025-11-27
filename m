Return-Path: <linux-fsdevel+bounces-70045-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8166CC8F6A4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Nov 2025 17:02:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 71337344EB8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Nov 2025 16:02:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B2BB2D0C94;
	Thu, 27 Nov 2025 16:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="HYQYtp1O"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11023119.outbound.protection.outlook.com [40.93.201.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 918FE2773FE;
	Thu, 27 Nov 2025 16:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.119
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764259336; cv=fail; b=HTkXnO/dVBSVZPH3R1hbb+javOAZxCDTN/l/xkT2SHfviRlOjVVyq7LwyyVHjvYNlcHiyzF/282FDQsf8MJMmWgO8cHM16g8Ivv20ACtT0Jf1Ch5MNbKPeLQFuE64byjPKjnDwbaz0FcjSh8GCKQT5L48THuq+UmZqUOh1isC8Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764259336; c=relaxed/simple;
	bh=AgTKhNx4wUgM5nYeJFV87Qvxj9eJZsxrUdROpqxChE0=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=cRjWY00vasfsCKvsOiOS2bnWRdtYHO8VSijjmpMdtB7Wxmq9Odds8JvB8rsWzDo5tp27lEq4E6d/0A1Kb/nur7YQaSPyu34zbC+wmfTbyER3BF2YanjehgqRDUlsQATCfrwvdTroIgVaCejDHl8HfA0yQ7AHd0WqF5z6qGBtm2k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com; spf=pass smtp.mailfrom=hammerspace.com; dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=HYQYtp1O; arc=fail smtp.client-ip=40.93.201.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hammerspace.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q6EwH8wQnpdFYRrHScO5s5dzt3wozSaEIUMpgrMb8x4VgHxQO4D9ogZzl5L7zPwx8OjVBeg/v/oliCAHl+qkyBMaqEifoNpN7FFpr7KlMJryLzvwwsi0mM80mWonkWgyrSuTgFsh3W9Pf3PVBrDSwUrH290OW1DnrkDwyX4RXWxtoDg+pGpjMYz9nRTA0FqDHaYuF6Ye40F1YaEBUWEQ7/O6xZcsB2tqjz833VA2d0lbkbA83I9LGi+Wsu/eZ8+WV5rUHiMF+I5taXRv/rvly8W4kaNFbUQaY9dRZ0X8mzP/idS7oKpVXJbQMja03K6WPNUUk7gOG5Mr40QkZN4PyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iLRXYOxSgXP7BZPhrXvoI4FdNuNkc1/TMx5kJ9uJFMA=;
 b=XuaIWF+Lm1icQWzak8JP0RlQuxLuM+y7qLkWBtCYDkk/sH3f5r2FJo9ACjQZI+V29/wDdyAz8/sRU6NCujVlMpASLHNyYbI+Q77b7F3XD8qMYUsxnKvmC59FbrLTPv6LX90ODUSlvkaz4Blpj8r9XmlkzyJwmeZBziOc29aeIfW5fQzR0/mrK1Bj2eTp5sKHcbBaJOO/YFzk0ZBrZKnzd6a1w3jsWUhoCXFlaqbWXjTTBxmrgf6s7DbIBoBgr96m1mKn+SU+IawyJP83gKPQNbC9msp0kEfw5xGC0smaCL5HFRd0AMakAix8GGntpZ1uctwkLHh6HAbyeQMlOwpeKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iLRXYOxSgXP7BZPhrXvoI4FdNuNkc1/TMx5kJ9uJFMA=;
 b=HYQYtp1OxT1fZ3Z4Hbbk4lvvdryYRG93j3Vi/We0WYL/7k+9YE777TqDU7/SHL2KN4JNhxP6zt5o5nFIPrWmWihrplxgunj0sOhZFIPQPFHIGcdWDiiFKJVul3qlzeTKLdF9zJgRBvyD18Ux+/bmJUEVDbfodcnHG7xLxO/L+x4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
Received: from SN6PR13MB2365.namprd13.prod.outlook.com (2603:10b6:805:5a::14)
 by SJ0PR13MB5500.namprd13.prod.outlook.com (2603:10b6:a03:421::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.12; Thu, 27 Nov
 2025 16:02:09 +0000
Received: from SN6PR13MB2365.namprd13.prod.outlook.com
 ([fe80::9127:c65a:b5c5:a9d]) by SN6PR13MB2365.namprd13.prod.outlook.com
 ([fe80::9127:c65a:b5c5:a9d%7]) with mapi id 15.20.9366.009; Thu, 27 Nov 2025
 16:02:08 +0000
From: Benjamin Coddington <bcodding@hammerspace.com>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	NeilBrown <neil@brown.name>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	Trond Myklebust <trondmy@kernel.org>,
	Mike Snitzer <snitzer@kernel.org>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-nfs@vger.kernel.org
Subject: [PATCH v4 0/3] Allow knfsd to use atomic_open()
Date: Thu, 27 Nov 2025 11:02:02 -0500
Message-ID: <cover.1764259052.git.bcodding@hammerspace.com>
X-Mailer: git-send-email 2.50.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL0PR05CA0013.namprd05.prod.outlook.com
 (2603:10b6:208:91::23) To SN6PR13MB2365.namprd13.prod.outlook.com
 (2603:10b6:805:5a::14)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR13MB2365:EE_|SJ0PR13MB5500:EE_
X-MS-Office365-Filtering-Correlation-Id: efd9cc7e-55c2-4ad9-73a4-08de2dce5173
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?s51su9uThSJwz/DOSnp4+X1oMlHFUqFc8V/vKOHewXNxURJ4rdPNlYuUA6KD?=
 =?us-ascii?Q?oQCiC3djm62W8NP+iJ4F4GT/2UI9lE0we7ddyfzSp4Jj5htw9GYkubso5Zjs?=
 =?us-ascii?Q?eHsTmVo66S7jc6lsk3wUfjtGcEReZlS2TTcZ95TjpaQduqRYnX4jdU/O540V?=
 =?us-ascii?Q?m7XIZrKygpo7XTzHfbMo91xk++MMY3brzkNVNpYbiRv8jGVmOrbIZS8XFxhb?=
 =?us-ascii?Q?lPG7CDUIseYvX6pDphR6gh/TpusBqBJjnO/3Z/fpbIZ9Edmlv/WDMIfjWU3v?=
 =?us-ascii?Q?lnk904oGvlEjIhoQ2ilwpf83DhfbHo6N1U2+NMHV8SFIiusNOT7M1vjpJ9SP?=
 =?us-ascii?Q?w2ftzgRa2bNFrly3keSN5LVf0CWCGJ/d9Au9VwuWdMb0IS0ujG9Uks31Dzyr?=
 =?us-ascii?Q?Lcu3wtWD4MpFHngAxKrQdBUtNe+m8Pzv08N7xnfIU/PNbSODpl3BmKhisUVV?=
 =?us-ascii?Q?lG2YxgHxl3INVzr0tR/TNiJCrbtZhrnsVxwMeUou9S8GoFNLw9o28RgBMBPr?=
 =?us-ascii?Q?+lWe7ppZ/tX8o0AmjDY0Yx+XemMJXyFOi5GPox9RvJAoOzeZaDy/xGu1feKD?=
 =?us-ascii?Q?wxelFpa3BvTQB7RREGkO1/BARO9S+IVzJy7bAkrtelna1abRmQ1POkZvbc9v?=
 =?us-ascii?Q?2ut2P1dMhHObubXr+CeTwWVbbCWdqpuO0CLbFIhgJjeNcqINGBPveJUkQFFV?=
 =?us-ascii?Q?thiYTr21h5bxoDOH4K7FJ+GksluXW19MDyn5K2MzgcGTQsRF8M74w1zw41hR?=
 =?us-ascii?Q?UIT3ukmJcenqAQjgZC/WjsQ+gCQjlLAU/aEoGD9WaePM994za/AWo18AeUP0?=
 =?us-ascii?Q?M1o54xeYOZ4a+n9RoeCGwx4MH7Nf9LuC83IbmorugNqFi/S+s8odszCrG2fi?=
 =?us-ascii?Q?lerVSRG43w8gRyxzF3Y20ytZub9+xMgj9JVEYmn9z3y3yHV7enb6X+19hI4n?=
 =?us-ascii?Q?yzeV+0YkLoLqZN0h7asq9ah3YCiAkpNaOJ5VRR+vetGu5yBfEVsulwWrnEVS?=
 =?us-ascii?Q?e0wCwVqdsD/ttXB4RnLKoWrFsawuBDyJn5agMCfiKGhInQwgaOsQ6gU/bV5F?=
 =?us-ascii?Q?OeugTnRtxk1G8BYzxeneyMsHRu0dSPuvZK/vBA4ZowbcwNlRa0/f8Flu/sOk?=
 =?us-ascii?Q?8pGC31v1Id+gCwKXRDEWqklp++X0GORBIgX0D2JpRsttQbViKTcTzyAEHB2n?=
 =?us-ascii?Q?yXzxg9wIX0AsTTepdECbq/SclUZVWgO82x2I6MdN1fPJBy9EzkFbD3Nyh/f0?=
 =?us-ascii?Q?PVxeUkBwnRTa3rbmOuq6qsF9Hhz6iCp+B7aAfEszVS69oz/9ZkaY01YKwfCy?=
 =?us-ascii?Q?CmG0/sxzGT2/3h9Ut/RMEgB+EhCQZXFgqz8/SL2a6Lwyck+dcEbVujw/rwaq?=
 =?us-ascii?Q?5mWGNWZFlSpL0nq3jdlkpW/15YA5Ttmh0IiXSKMVAER2pont87R6PjEeAs8r?=
 =?us-ascii?Q?gQqf/AadLoAlapUmlP/S9YPdqHikjEefvEW5BaUnycPcACHNu2pGDS+jNbts?=
 =?us-ascii?Q?QwmuyjxyLwgzTKc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR13MB2365.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?G26GciByu80oCHTwh4Ic97goAmS7pIz1hSgeTqxOuojKwXnaSubuTo8/mDLi?=
 =?us-ascii?Q?monLfi6dUFvcq/z1/DOZHgw/B1STyw0kTLqEhvrb7LNKjMPmhOYWYjBeriri?=
 =?us-ascii?Q?Dr9fuVdEukbgzR2mrOnNQaK2NqBZpA5D5nsLjm97e+KVaXL2caulSJAUy6YK?=
 =?us-ascii?Q?ed+PlB2zKXULPFiVaw7CKSkuePRi9u+cAFoGvVuH8hzQt2stbl2/ajJEh7bB?=
 =?us-ascii?Q?FkO/HMILbhw5GvJ/p7OmxQThllFWGO0X7Y145LKaCNKFXtHGXVaG+z0CDWcq?=
 =?us-ascii?Q?Dchepom9nwnHVuFvEs9X0M2nIFmaXowh/2K6YQPphY2IrUtZM6rUmJvA8Ud/?=
 =?us-ascii?Q?qq2ypfL3AGMgvyKmJFcswp+E1qvfqo9g1NNciBmge6ZyFvZso1K1iai7lymg?=
 =?us-ascii?Q?+qF4ErLAbvPmDAGSjfCQumXqCf+1hlS6IBhIdt0Sy1bAgsWzWWIjmLSIH/uv?=
 =?us-ascii?Q?xW3LU9fxZqcNpxeOLjmaP/boOd14oV1GhckqBtnNxm9Azd8dieDmxGBDnutq?=
 =?us-ascii?Q?njOR+Q38l8VVItXFpMR0sL6lc5czYo4plFTEAuKiE9KZ1aJvFztzYTgraDuw?=
 =?us-ascii?Q?KzSf2NmYo8aiQjJVGebPZAan9r6qpfmdeMTOmfZ6neSinDSr8B0tvIDsuWWC?=
 =?us-ascii?Q?nAuJxexQm15iteDbLtPDVAH0MeK71V2kyfYeASLbmVN7QB/YZD+cbgSmSRZH?=
 =?us-ascii?Q?Eokp0vPZmh87RaQrbH2ynk7+X2YR05l7mH6TNN7DXymwGl0A2ahNk16FEEXM?=
 =?us-ascii?Q?zQOsXjY4EN+1ieylGQGq5qLlCuRVtTTD5B5cTlnziagPcC5QwYTC2WL5F3MB?=
 =?us-ascii?Q?atU4gDHsM8fMbr45P7PYzO+4aeghb9jUIFRb3/w42G3TQfBQd9RHWzL4rNqF?=
 =?us-ascii?Q?Ho8mkq+Lt+DRYKjaX73D1Hzx0mTi9jI7qO1jfMi0fpuDxKgIHaDJMo9XfLc0?=
 =?us-ascii?Q?IgFG8ur+ByCyESCiqCr8otj48M4yyH+Ui6fVhXA0YsGOg1/CTCwG65u7i6Lu?=
 =?us-ascii?Q?WlqecrKRPyaiMdK5pKUAT91G9ksElmbD3AZGs0M9ZWpirsQoXJTsBP4dfFgn?=
 =?us-ascii?Q?f++d7wMXFBCPemh5nszEgn80hOiYaSPaPVN+Fy3THlFcPNvi9TZlQvU8yOPj?=
 =?us-ascii?Q?otvA5s2fmHFR755lJOfWrCXRkDANCOvWOZc+e4eofT7Nuu35+rzgRkaOmZHX?=
 =?us-ascii?Q?Z+AN4Hxsy4Qk/BpGUSj/srjeL27B3QewadG6H2Nj/nlA/g3SHDZy6HDMTRrv?=
 =?us-ascii?Q?WbPNv/c9feWF7dP55QFcioIyk3bNPOqSqmXN10AfcymT7HI/uWRqwK7Rmq1i?=
 =?us-ascii?Q?MIF5lgOuTslvH7G+pG29Zdk/ALnlwsAzFh8aH6c54eBi6QYGHch/g6F+rK9K?=
 =?us-ascii?Q?/0dEOjzqmCi3LfvhUosBZDzNlfRC7IfIWwrfCss92/AxNXgjtbkbbJ/6Ye6R?=
 =?us-ascii?Q?IuQf46lnUMqRVOMH4r/PcZie6wRTvXyGxd4w2avJaN48DkBoUlp7EUaILmKO?=
 =?us-ascii?Q?nsap+MZxBnoj6NE+mxNgSVY+CKYC9rkuYjRgE4qkSNd1t3WfJUiu93VOkm30?=
 =?us-ascii?Q?kkI/bIQ6PoS6cUhYRZDU6gp3mCFIgAtO7YoL+e2Z/0EwyiZ4/LmIbsSWFfi/?=
 =?us-ascii?Q?Hw=3D=3D?=
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-Network-Message-Id: efd9cc7e-55c2-4ad9-73a4-08de2dce5173
X-MS-Exchange-CrossTenant-AuthSource: SN6PR13MB2365.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2025 16:02:08.7622
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HX5DlK8wyRWVPNQl8X4mJZ6dVf7eSLOMxwua/NswOoxYg+3MGTTf6K6aWyxOK+Q2bjOT+1I2e3o5gMO/px1z1+NQMkPajfXFRWUdP/r8olw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR13MB5500

We have workloads that will benefit from allowing knfsd to use atomic_open()
in the open/create path.  There are two benefits; the first is the original
matter of correctness: when knfsd must perform both vfs_create() and
vfs_open() in series there can be races or error results that cause the
caller to receive unexpected results.  The second benefit is that for some
network filesystems, we can reduce the number of remote round-trip
operations by using a single atomic_open() path which provides a performance
benefit.

I've implemented this with the simplest possible change - by modifying
dentry_create() which has a single user: knfsd.  The changes cause us to
insert ourselves part-way into the previously closed/static atomic_open()
path, so I expect VFS folks to have some good ideas about potentially
superior approaches.

Previous work on commit fb70bf124b05 ("NFSD: Instantiate a struct file when
creating a regular NFSv4 file") addressed most of the atomicity issues, but
there are still a few gaps on network filesystems.

The problem was noticed on a test that did open O_CREAT with mode 0 which
will succeed in creating the file but will return -EACCES from vfs_open() -
this specific test is mentioned in 3/3 description.

Also, Trond notes that independently of the permissions issues, atomic_open
also solves races in open(O_CREAT|O_TRUNC). The NFS client now uses it for
both NFSv4 and NFSv3 for that reason.  See commit 7c6c5249f061 "NFS: add
atomic_open for NFSv3 to handle O_TRUNC correctly."

Changes on v4:
	- ensure we pass O_EXCL for NFS4_CREATE_EXCLUSIVE and
  NFS4_CREATE_EXCLUSIVE4_1, thanks to Neil Brown

Changes on v3:
	- rebased onto v6.18-rc7
	- R-b on 3/3 thanks to Chuck Lever

Changes on v2:
	- R-b thanks to Jeff Layton
	- improvements to patch descriptions thanks to Chuck Lever, Neil
  Brown, and Trond Myklebust
	- improvements to dentry_create()'s doc comment to clarify dentry
  handling thanks to Mike Snitzer

Thanks for any additional comment and critique.  gobble gobble


Benjamin Coddington (3):
  VFS: move dentry_create() from fs/open.c to fs/namei.c
  VFS: Prepare atomic_open() for dentry_create()
  VFS/knfsd: Teach dentry_create() to use atomic_open()

 fs/namei.c         | 86 ++++++++++++++++++++++++++++++++++++++++++----
 fs/nfsd/nfs4proc.c | 11 ++++--
 fs/open.c          | 41 ----------------------
 include/linux/fs.h |  2 +-
 4 files changed, 88 insertions(+), 52 deletions(-)

-- 
2.50.1


