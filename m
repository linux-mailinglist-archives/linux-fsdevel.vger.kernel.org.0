Return-Path: <linux-fsdevel+bounces-68984-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B482C6AAAD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Nov 2025 17:36:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id 8553D2CB43
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Nov 2025 16:36:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D946426F2B6;
	Tue, 18 Nov 2025 16:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="Vma0xz9l"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11020133.outbound.protection.outlook.com [52.101.193.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC07E227E95;
	Tue, 18 Nov 2025 16:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.133
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763483648; cv=fail; b=S0cHiJlIg7FmPu9PeRnyo4b5+NEGHaNgU1Ad86lf0vsHZd70qzzCZvRI2Rkg5H95AWSSedOkVdmExaiOXli4MYKlxHgvlZ587saEEUYfqgzyMEOoa7EtUlVe6QJZgeU21R9tH4h0OXA8SuULPFrcRBTar+3pq6i5yhQRb2KkBBc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763483648; c=relaxed/simple;
	bh=x81UXgM01z8r/Yofo8uV6Hpa7uheWtcBI1CyjDi4WH4=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=NpOegqpeb8ztFMc0XcoHe4PI9aXmCAdqqjEf3r+gVQF3kG4XQ5MXbfYS43PE5ZGXTx5I3Nxk+MXL7kZwy/5tAHBAqRyXak+ANStkwvHztdRuMmZp88JVCZOWC+GZWP2XMplClLPs4PwVRODwTxV7swf/e8VxD/F95yS0ZxlNzyA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com; spf=pass smtp.mailfrom=hammerspace.com; dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=Vma0xz9l; arc=fail smtp.client-ip=52.101.193.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hammerspace.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P4S7WV5FZbRzpKOsV131QP6O6Tc7cGbh4TlYLzhLhBVdm+um89tpJk5tdJG1RFVkJE0BTj/tfbK/ceKU0viWAdDX6aVcnNpjuSg6TLQ6j+nBGV0G+daQSZVjiaaxxrjkGtVd2nq5S7L8CZjUSqZC7Y7EDiWlm+NSgl0rVbV39iCrvTtusU0lt+vhkkgfIvuLgz7YlkEy9/a0yeIuz67A/nCNysV/aLgFZG/avbfCn/FV0eKnI2C1YqImZ2OxUtzpE2zQloul95SCJ/tH34pTXCG4Z8iGZA/wy6KM5PwA951xPm/Rtd17SJaI5ctYtpgzJU0KNbXZmd8OUUagTrGgjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=euERY4AlAEJzqGugAVxu1vJEKMoCOC+ILb8A6g95u/A=;
 b=xnOhHdGxcjvWdmol6jkrhcEF3Z+NmWp8Q4b2saJbqYhqWsuc5vXSpYfFu1DEVmuEC4/XfWRuBQB2yZxCkZEbTKv2Lyj+yHygVJmNjj8XtKaP7gHblFlUgFxN9dAEYvMZAGBN16YeuwfDDpFA4bTYUCo4QTDlpg4po6QEYj6SzCSt0OaphTr6aY5GnWoKMTbUpfNT9z/KaBxfH/sAlTMW/HeBHeaT/Ve/SxMkTzPRj4OC5ztoVZYtZiUdqqDLFhEy91f/dH2OvXjD5wJve7ObZD1exkZ5WdnrPLQ5zCtUvuPTufPMfLJfCV1J160REOYOQuQlZ0qNvXYMOkfZCABT2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=euERY4AlAEJzqGugAVxu1vJEKMoCOC+ILb8A6g95u/A=;
 b=Vma0xz9l5whq2yAgvJdE9uz4XVWfibNt7u7US41h7/bH1BlNrE7aQ8nbKaIksYeFTBlGW4I7UjeDqu8CyVVppnan+vp3i4ZwwDuQFZHopEND5A3hDdGhTWYaoFuExy4RP5vaSIs7iX3TitGXiBY7sQzXPjzMLXFABy1osMxxrJw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
Received: from SN6PR13MB2365.namprd13.prod.outlook.com (2603:10b6:805:5a::14)
 by MN2PR13MB4072.namprd13.prod.outlook.com (2603:10b6:208:26e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.16; Tue, 18 Nov
 2025 16:34:03 +0000
Received: from SN6PR13MB2365.namprd13.prod.outlook.com
 ([fe80::9127:c65a:b5c5:a9d]) by SN6PR13MB2365.namprd13.prod.outlook.com
 ([fe80::9127:c65a:b5c5:a9d%7]) with mapi id 15.20.9343.009; Tue, 18 Nov 2025
 16:34:02 +0000
From: Benjamin Coddington <bcodding@hammerspace.com>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	NeilBrown <neil@brown.name>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	Trond Myklebust <trondmy@kernel.org>,
	Mike Snitzer <snitzer@kernel.org>
Subject: [PATCH v1 0/3] Allow knfsd to use atomic_open()
Date: Tue, 18 Nov 2025 11:33:56 -0500
Message-ID: <cover.1763483341.git.bcodding@hammerspace.com>
X-Mailer: git-send-email 2.50.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH7P223CA0021.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:510:338::16) To SN6PR13MB2365.namprd13.prod.outlook.com
 (2603:10b6:805:5a::14)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR13MB2365:EE_|MN2PR13MB4072:EE_
X-MS-Office365-Filtering-Correlation-Id: 33a63630-cc89-4783-726d-08de26c04882
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?kkgnenJ0SPWrci4eMLel6zyP0EQ4vhodEl7vQ//IpeNPtdIew+9rUoHRWRRh?=
 =?us-ascii?Q?olkDEM3CfbQD4NK+uZKuIaBBNa246lHaGp8WqYF4V4Em4eQhhAsGAbcNOCcY?=
 =?us-ascii?Q?BGQqhhVXwUSNiuIziCIFldPT4X9UKplhprW/uTPtlmOoCdb3b3Jc67ayBT4Q?=
 =?us-ascii?Q?S6oZIlKtV7fYID3hP6z5HGrLek8pvSj4Fh+NxdaXNprRSgIjtsnUN7sGvkcR?=
 =?us-ascii?Q?+6/O++PW2thv/yuJL4phYJLoaOzioDjvL2xvmmvc89RkUBMRtEiIakku5wt1?=
 =?us-ascii?Q?pvndS6BeYFo11xyQ3yncFobMg0ey1tb0mf5CW7l+UisGSaH6Akg27gluIRvR?=
 =?us-ascii?Q?PG68b+AvXh7oQ2+N9tfmlzJb/DZ4emcdH1ekYe6Es/X+ga1F/y4ED/t0FmOk?=
 =?us-ascii?Q?820IE+G+6krSGBbabFNVEgHapqcXgh8h92L4Q8SowERDZL662RdAXzMn9TR7?=
 =?us-ascii?Q?zKourZlLy46bEv5SsWM2+xOp4HqHpaviBKgnq6vQVMNUPT/77Ucdwi99gf5C?=
 =?us-ascii?Q?pirWbDt4qV4HKIrBKCFTZuIsr1exyr8gNPtoVUy9ymMy4/6ilyXXJjUIxuIY?=
 =?us-ascii?Q?C4SeMx+pBvJCK3yztfoHXwswXDsKsy4wBPVgByDxWjqrmfOg/17u9hXzEIvx?=
 =?us-ascii?Q?uOcrAcl/5LQBeG7mCAFyrEW0U0HG8DJpcvZZISQe/w2HFM4bO1nQSNKIA0BC?=
 =?us-ascii?Q?gNNCU+6A5xzHJumTQ7KeVxRlikDzrPgbm/3kykF9BgQtgFREjmGdWS1qT604?=
 =?us-ascii?Q?dGjq/dVbhCj1/yUKo53SSQu23KSzWgLu56SW4Kc49P7StdMqRQY7Z/odV5N4?=
 =?us-ascii?Q?pXjMnNXK6ObxjEidT6FzIAvKxhobdq7E8WUukLYN/6WlsSZys9/SRyUvUexd?=
 =?us-ascii?Q?jN0Z/ITBu2vCunyWjpQMVqgGTektpy02DqXgAYC+Ji+aXKqZTiLwHASBTd9F?=
 =?us-ascii?Q?AevygYDjqA9Qx3We2M1hMSWexfjrZcpvFQ9XhZQuUwwg8IvDrw4NU+1O6UuX?=
 =?us-ascii?Q?NyHZX9JF2Qiu4cQ7nv8kfPbs1R0NAfYmFDjw0WxN9IuHcT1uKaMDJGY/TZ1L?=
 =?us-ascii?Q?r136qRKYo79CecCN016Jip3B1rdhoBgcbOtUjPXaO+9I9ZxVacEiG8nvWwLa?=
 =?us-ascii?Q?uk+MeaiKQLT9BpNDY4NvEwuGVvkb7kT/hWlj7HugE5zfOe6yFXx/NIXtRVm7?=
 =?us-ascii?Q?gQBmrKxvgStKkQIs+AUl12HxqQIB/sDGfncs/sM8alH5o3/gBss8JW4/ecrg?=
 =?us-ascii?Q?+G7a7EJOld2W8pzq10ccoGKZdmQZGw9Ow0wsRFHq2wW2YL+cUvsIOlxLezuA?=
 =?us-ascii?Q?9ETdrHMrx3Ikcgl5i/4ZeDqWczsiYtRy/3VJz97CrVvGL0ZJroXy/AjUwYE6?=
 =?us-ascii?Q?znUmssRg2Pq0LR9AAxv1NSGnRihkjNBbVtc2iLaT6ga7uNyjG0FuMEBt9gxr?=
 =?us-ascii?Q?eVbnrcGsSKYc+KGOruirJFPzxLhRjpqw?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR13MB2365.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?q9/9ARv5S1YJDILLZldKZA1mtLdwp4ns4x1qB24GNHS0l4l6aMRX6YNx9bO1?=
 =?us-ascii?Q?Uaei4E5C97DGo0N/NM1O27wwrq2YLu5GHO6SJBNCFbybvpn1idXVfCoILPNr?=
 =?us-ascii?Q?s5m4pWKKbMLsMNuqJE39SqggZIcd6h106pCtxaBGoiJbcNfaBt2sKTCULyWB?=
 =?us-ascii?Q?aChhBxmYiT8t7gng8pmXFEHIebfEdqXE54L83tmz8/JbFcREmi2XotYG2Dp/?=
 =?us-ascii?Q?NC53KDv38D515xM7MYW4VsAa/fDlVbbXc4AAIzmxtYYdEVMzHBywWSUBS7Zf?=
 =?us-ascii?Q?Gh35/23/TxWCFKH7tlBhp32CKCpbDs5z4JxxH+RTEWsweilui5nuCV66N0et?=
 =?us-ascii?Q?rjf9XJXg/TTmJG+/ujhJwc3zztsw1G/DY36zQbQkhP8PYZkb7ErIOrUrczux?=
 =?us-ascii?Q?h1xyC6wyO8T1UBMHE+UFM+tIQyb7FW2ftQfMtXoc6anayvtqNfEndE4Fa6Lc?=
 =?us-ascii?Q?XqwQCGMI31h6eUvbxHdrdV8T0CnsWI+2r6qdgtFDLuZCPivWfTUm7KFQw0Oq?=
 =?us-ascii?Q?QCW34nBrO9DdQU+NOaoVCnFvesasAxK/WkqgB7ExEppfU+2tMMXMYZbcyy5x?=
 =?us-ascii?Q?ki0EM/CcNRRychvJB0+E3b2zOmjGH7617H2To5knO4wvGmY1i5215HukThoz?=
 =?us-ascii?Q?o5PKNmNSEFNhAlvRIMcn/RG+rOQvtTkVZP7E1p84A1dsqaRJBzXJLcRxeT6D?=
 =?us-ascii?Q?gthj1tIptUcXApxI6y3WAEwfwfLKp2AX3SKi2fh49ip3kogAvk34Ac2slQpe?=
 =?us-ascii?Q?wlRtNYhd6brky2TuH04ApD7LZSsBVdsCfXCpMWEtfewCzWJ6DKiYnyznhm23?=
 =?us-ascii?Q?EvQ0PdL0WMuBaTbHGhCrc8Pn9aEc5uhh1m1LAZjS88DypEFxQdaT/U+IwEJP?=
 =?us-ascii?Q?NlCHQ6FXleSjwjCxlAbiF21ZMx7dwXco1n/6IYrr9vCudr0KagieyWiOcTcv?=
 =?us-ascii?Q?1TTmjSIFNsbgzBJRIC9v4bB0YEMUuEd+4L38lfR9GkwH5BjhM1TB2PrDXPS4?=
 =?us-ascii?Q?dI+rggUNDN8ftJP17caI/KPuRsqjCUWnJsnOePUVJskAl/NiA9wwqpQGKJD+?=
 =?us-ascii?Q?D2Un4Q+fUmfa1YG+rqQYbOIWzVd8sqN/oQAOA7nZZQ7lzHLr3Q3keev86A2r?=
 =?us-ascii?Q?LJ+wk93o50JwD146SQtLaqClQ01AAaTBjNJva31GfNzYw65RJLAyR5+wPAq9?=
 =?us-ascii?Q?YUO3VvlyKa6Lc1rLBdwU/+DccVImr5JTbzEpgymzeGIMti68ZUsUNY20MrQt?=
 =?us-ascii?Q?jrW6Rk8HL6+fkqkIfBY2DrJdjqrrMqkg2r/9vFYVd0jrQd+aNdYBFl1CGujR?=
 =?us-ascii?Q?YqzXJ22F3ojCgrl7qg+w6YI4gOd/ppYch3P3d2Qs/g5hILA2Yp9FJUvDyDAB?=
 =?us-ascii?Q?HKxZODTUpyupzXFjZTvXVvBzCyHqtF3cfibgbUDa5wJp1ax5EkpGIj09Kj9j?=
 =?us-ascii?Q?KAbN7pRNvUTAb3RWzfetr7anW+oZTLO2FD6OO2QXhJvuZXo1HhRxzBS45CE5?=
 =?us-ascii?Q?xmcHMuH8NqHkSAKWi8auhC6Yy69SRQLtHy3qcQNKGmn6Mc5hD8kvatRZ5Kg1?=
 =?us-ascii?Q?PSL8aeY+Ln14+zrnM4bLSCULdpKuN02BdJfqo8rxO8hM5io9EBr1YDvKNCCG?=
 =?us-ascii?Q?VA=3D=3D?=
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33a63630-cc89-4783-726d-08de26c04882
X-MS-Exchange-CrossTenant-AuthSource: SN6PR13MB2365.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2025 16:34:02.8035
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6p2qRSNT8YgzzxI3ARNSMTg6J8o3+I/n9lwVzhczA7TNnV3TE7lNxcB9CzYSWT6thXvQpX7g3by/U2T7UF9pDXSy7ceWA55OOwKx9EarZtU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR13MB4072

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

Thanks for any comment and critique.

Benjamin Coddington (3):
  VFS: move dentry_create() from fs/open.c to fs/namei.c
  VFS: Prepare atomic_open() for dentry_create()
  VFS/knfsd: Teach dentry_create() to use atomic_open()

 fs/namei.c         | 84 ++++++++++++++++++++++++++++++++++++++++++----
 fs/nfsd/nfs4proc.c |  8 +++--
 fs/open.c          | 41 ----------------------
 include/linux/fs.h |  2 +-
 4 files changed, 83 insertions(+), 52 deletions(-)

-- 
2.50.1


