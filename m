Return-Path: <linux-fsdevel+bounces-37581-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E8A79F4231
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Dec 2024 06:17:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 20AB01886837
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Dec 2024 05:17:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 113241DACBF;
	Tue, 17 Dec 2024 05:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="LW7oN0bN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2065.outbound.protection.outlook.com [40.107.220.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAA2E156F28;
	Tue, 17 Dec 2024 05:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734412454; cv=fail; b=M9DWnz9sDk7fSwx9fvrm9CH5wX53ko1PSxgcvPiaUqNzRfZF2fGlq3NN68NGSRN5FJxwge3hJCsxchsnQQfngVVfehxMsF/o38mv8yIMT+WL+zPGYSmpOl4I9uVdjfuK1x2C2DHbj0Fa3D5ro/dfswlftYsveaOTdhQ5V+wrGsU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734412454; c=relaxed/simple;
	bh=PPFwLsiR7vVVskCmbfcWdCiD6rCsIroXZ3sNKGykMUI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OlVvjrIp/NjIchSqjGCxyMJ2UxEUchwQztx/8i8/qT6xN8ZDBRaEhvHsTDipVz1VPkfcoY7vKLat4di9k83nGd+Hi2dsChV+6MSYBwzLAlpcRfhUh5H+BC70VZ2lsZUlUo/vUdSubyTl0yiB7RaSdrjzS9o3XS6XPQmXkCDXslI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=LW7oN0bN; arc=fail smtp.client-ip=40.107.220.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MoRAy8lpzBvNLGI+hi6ggVQwRTJD9qExpIQKQs2bmrjlcA9zDgOUmqIG52gjVfpB+c0Kf0Y2iKyFOlJmfytGSqo2va4G5IdcdGU54hfA8f4PQBwQ1MKxpJfrWlcZVL6BAI9zsOzmBcchMpHevQDowP+/oZhfFseDRbVgPb9o0NLIDEJU3HdwCO49MawtrOLjr/8KDu4rDMzsrRbY7WtrdsBAlE5Gi2V3hk3sGf36xCXJpDzP0QGCmV9TlFETfy4HcOdaW7j+7Uf8gtNqnc2Qqykg8z4tW3PbWIb+zBlBXKQjuxDNiUIbxsxbXLsNX4SRU0WT6EzmFq/0xs5Zn30VUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8VWQbKvMZKkNtjv/Ajd0TUbTX6X5/B0Htgy5V0FzEIY=;
 b=sP4+zHkdz43wHtKyYfGgkLXFB9cUwAo9V9ZqLECHpwGnaHg6FtJpO9C6k6JvW/x7ieRmcWIPsmXoD2MBuvOJK8KkunTY7HnaDogtBXb3CezmiKWoxnV02SR2wxlebiMD2IYW5UoOS5aLmqXJ+wIlBHKMjsRNSMw7pNipXY0fcwd+cjN9H6nbKmExoCUC725aViMB3bvnHxXOFNmbm+cQTcXSOadGR8uXu2psjUWq5lnO6/zrTtrKFb4cxUv7q1qv5ajXENudBCSeW9jl+BjlDRpDJ+4ZAj/NtA3hponKHcSRZSDZ50GE42cs68KgSXZAjVre/zR3pRjjQBIz69BhtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8VWQbKvMZKkNtjv/Ajd0TUbTX6X5/B0Htgy5V0FzEIY=;
 b=LW7oN0bNN1AM4VfGpHhuO5mZ0miPBkQFcj/vM0RppI7a8vZfyVqfI4SjoqxS6zMQ0TwB0OH6fbKw6/k9erS/kmaG1W2NKoV+LKs5dxhoQdbjUBkSC0A6Vnplc89OwCQRh2EuWKo44tFylpdhteDD4YUEjUX7HDbLqHC+TcEMcuCN+UCqcl84CnW36j5nat0r9yjkcfVJyD420W5eN9h67CdcrjC9s+XamLnT5Xsko6gDQOg436obXyngYIXTEW/bpJKbiN7SzBW1A1uBKMyal8plDovMhiMdUKm6BYKLjLFoVqu72oVoE9OPkXptUy+5Prv1appciCMV7igw03RvKQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6) by
 CH3PR12MB8936.namprd12.prod.outlook.com (2603:10b6:610:179::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.22; Tue, 17 Dec
 2024 05:14:11 +0000
Received: from DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe]) by DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe%4]) with mapi id 15.20.8251.015; Tue, 17 Dec 2024
 05:14:11 +0000
From: Alistair Popple <apopple@nvidia.com>
To: akpm@linux-foundation.org,
	dan.j.williams@intel.com,
	linux-mm@kvack.org
Cc: Alistair Popple <apopple@nvidia.com>,
	lina@asahilina.net,
	zhang.lyra@gmail.com,
	gerald.schaefer@linux.ibm.com,
	vishal.l.verma@intel.com,
	dave.jiang@intel.com,
	logang@deltatee.com,
	bhelgaas@google.com,
	jack@suse.cz,
	jgg@ziepe.ca,
	catalin.marinas@arm.com,
	will@kernel.org,
	mpe@ellerman.id.au,
	npiggin@gmail.com,
	dave.hansen@linux.intel.com,
	ira.weiny@intel.com,
	willy@infradead.org,
	djwong@kernel.org,
	tytso@mit.edu,
	linmiaohe@huawei.com,
	david@redhat.com,
	peterx@redhat.com,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linuxppc-dev@lists.ozlabs.org,
	nvdimm@lists.linux.dev,
	linux-cxl@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	jhubbard@nvidia.com,
	hch@lst.de,
	david@fromorbit.com
Subject: [PATCH v4 07/25] fs/dax: Ensure all pages are idle prior to filesystem unmount
Date: Tue, 17 Dec 2024 16:12:50 +1100
Message-ID: <f6aea86fad2d670a35ff9d60ba8e9f3f748bbd8c.1734407924.git-series.apopple@nvidia.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.18cbcff3638c6aacc051c44533ebc6c002bf2bd9.1734407924.git-series.apopple@nvidia.com>
References: <cover.18cbcff3638c6aacc051c44533ebc6c002bf2bd9.1734407924.git-series.apopple@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SY5P282CA0173.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:10:24a::27) To DS0PR12MB7726.namprd12.prod.outlook.com
 (2603:10b6:8:130::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7726:EE_|CH3PR12MB8936:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c631d3f-094d-43b8-c511-08dd1e59a3ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?as8i8ffgpAstVBPkHwkW1o8DaUglLxTeZKqe3Mr31rGRJabwfbKyx59hDO82?=
 =?us-ascii?Q?KidtVxqtwMq1Txr9OH+Hfn065yf1vR+vFqQ5u9XqWJrxg4E+uv7jahbpUHX3?=
 =?us-ascii?Q?kc3nQg4/uk+3MDj8KUmyA37buBdv6snuyFTNKLh+pGb0AMR92h9cU9M9BtDx?=
 =?us-ascii?Q?1fIbMpKhsbFL/mHLvlSzVWG0dwjl+CqqdMbcEu3/PVmz/1aDpVjdfr8TnP7A?=
 =?us-ascii?Q?ZiZlmkdQc/U9LLAIS8xReFehAXT7bO7AFqXkkvZLOpwOoD9EaobhqIaNVePr?=
 =?us-ascii?Q?rFQ16kUJvGI/q30KNAwYZ0xPJrbCBJ6pt3DiOfRH1J0BqI3u8a2dbYEuqHu2?=
 =?us-ascii?Q?HPn6XtXZyIq3KK9t4toL2YZRZbhSgjgDAZcYhendj5DVOC+7SHaTk/TRcUQt?=
 =?us-ascii?Q?7fbnWS3ZCK7YoEO/RqOw56fTNTWgSS2drXxGeQjfZaCCHWvgoJGNa/HmmZoF?=
 =?us-ascii?Q?N2/A90y0nwYUF1EJ2JFNxc0Mih30X5kncC2auQMkMX+txDtV2BhRfJIP6Q4U?=
 =?us-ascii?Q?f2Wrk0aVXwHljtebxB7vEz6edmD47h4rWfaKJeiW6XTPtAkaeoJEC8Ls6Bbx?=
 =?us-ascii?Q?C9gGXvM/q7SyLGDgQKlE0xJ7e9yXDu2YkWi7arhqr/b+r/TY6fXvy/SCDckr?=
 =?us-ascii?Q?zCZ/DrL2WDqPwA2z/W6AhG32pH2PIvER1j/Z8JBaqglSazx9BvC5Tb9Lg2We?=
 =?us-ascii?Q?T1RtYP9IGJb2GAsw5j5hDPkVCSiATRq2xGLe6Dz3VrwBZjjKK14GMxy50Arn?=
 =?us-ascii?Q?k+QzScnZFIlKZ92YvY/FFGgKyV4CqxsJoP8tSbKwwcyZUqyUCRaLDhS5p9Qu?=
 =?us-ascii?Q?HYNrwuHj49QwaTbRiMD47C7386Nc2PtcMx6gIzImP/M7W21uv6v9e6pyLj1x?=
 =?us-ascii?Q?1Bh6lf/NufR6EHC0kXA0fnrhAJYAdw3ajvxMnjJy1GcIUsWq0aIy3pNI5eFj?=
 =?us-ascii?Q?SsZNgYysXF2ia/OPlnTT4i5h2TMRVnHQjAgU4f6qxzcsJkXZlstk3nA191ou?=
 =?us-ascii?Q?EEQzEeHB4E7zUG/WJIpC7y1TKic/tB4eFV0dSBB4TwCaqKtp9i3Jy9vCAEhS?=
 =?us-ascii?Q?dpyChdNeRSlJZQChT2RFajXQ3s7l3+zcvW/QqznHmBurT7vkvLdrn/ZJlI0i?=
 =?us-ascii?Q?jIWhpwkmJwRtHC4oYp2xzZcIMrWoEDrk8OiAvCnr+GOoqHPCM0u3+M/8s5Ge?=
 =?us-ascii?Q?AtjQlorX+94aUPEnbXBlLhqhuZIZeEm+Caz5gs3DmcKHO+c2HdmFLQa9T/0v?=
 =?us-ascii?Q?8/uMV4140wg59WXVECDPqgJkup3F/Alw4mhpyDaCk7W0WrLV2i5aXtqp6tZ2?=
 =?us-ascii?Q?3uC3dLTVnaDxvI8zT1XnQewHjBWD8gZ9cfPu+uu5C/ZNHq9x1pEhUco/Vz9M?=
 =?us-ascii?Q?b1P/sbIMlmy9anq+pqiAojmeJ1hT?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7726.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2dpjZsx//tdvur07Icte7WooBnpKiJwUDxaqTRO7xCtGYMaMMiRBT7IzXo5e?=
 =?us-ascii?Q?8gZ4ulP7Ii4JjrTJtjgIVFh7EBT0mLK44bDL+Gd7ds/9Rz28O1jzTLMGfm3R?=
 =?us-ascii?Q?OCWElc7ogfWAwLOimTbZf+hHY4JunRrrt//YSKB4V5hwjMejJRPswW/ka8Z/?=
 =?us-ascii?Q?JLP08PMH/TvYtaab/Cc0hWdzvS813/3uSK+0TYCaPNq5AWUkB4ZdKJA8kW97?=
 =?us-ascii?Q?5DCJo84/7NbT71woPNR5CPRAICU+S4c3guHk3L3aGQebnWiPZ69VCNS8VFvO?=
 =?us-ascii?Q?rzoulCaRXeRF73YrQbUudE++yEGHkI3+mMqIK2pB49VrRRXZc85jQE2Tbu9O?=
 =?us-ascii?Q?1aedLZx5AtuKgwyly3RMDWf9hkuhT6YXHKnYBHj7d1PekeqZB8XOMuscVTw7?=
 =?us-ascii?Q?ITAfbgxrwsASFN8D2paNKKogcFHuu7GmxTM9hxxphgCwc6TCVNPrJSPTC390?=
 =?us-ascii?Q?JrXyVv1xM3cjpsT8PwTWeOkdPARJMbOgPxfoWK5kfLRlFyV/OAPuheIiAOcY?=
 =?us-ascii?Q?oY22JCL9/2EUsRbJAfFKRe2OYn+6Uydvt0ek3uHJa3JwUIXiw79NWjUA2jq8?=
 =?us-ascii?Q?sYTlVAAvFnFOAiTYKnwdT40RVKyVzRq/hKKi0ppUQJPBToFq6Qqpf1C1fqrY?=
 =?us-ascii?Q?rK/r+ew8UuaJTCkcrwP85UWBXNnjXhPG/E+5KOuX0QyEXAFV+kEDBr1XTz71?=
 =?us-ascii?Q?pyV14louyUCzWsnoeLY8bIhHZImzDwGzdzDj6TaGUMRCFHZdHB+DPFz5kyrJ?=
 =?us-ascii?Q?GLL4Hn86bsYrQQrkHS826B24JThXdQVB9Oa7MNngsa/t16Dt5CqA7Xi4knRh?=
 =?us-ascii?Q?cImt8Kb1sOcG8iVsv1kpuyOjgv4FgQVvvgOotLnHr8fOdmoIrOhbhG7iAXLW?=
 =?us-ascii?Q?qv3328+rQMekWl5mMMSmHhb8EEIygXyXNZ0nVItfxMKUVb6qwutiN2OqLQyH?=
 =?us-ascii?Q?4HtY/KHztlNBJfK7sjw0QabI32DrD5JR+UmZWkw7Ks1q+vCJZO1JmNv8YVNI?=
 =?us-ascii?Q?Dqz5T8iY+6JMstfaCbRz5YHoQmgS4ocRv6dp10BICbr5WHW4MW10rUz+6JHL?=
 =?us-ascii?Q?OyhrlTRM91WVvYuHHAiKi8CWkUiPWt3pK9F/FZTJa/WHERw2xT8FMTpU8bG/?=
 =?us-ascii?Q?9XFaE5NNa9/VMgiMhd9cMuQ4Wxpbte6XgDS9mqWaWvEtd1dql1gmCrfuXHVL?=
 =?us-ascii?Q?7eR9pKSTUWAFjeu0/dL80hdjckyngLJN4c4rmKp3umfep3zrc/djEeoLZZX+?=
 =?us-ascii?Q?CD7RbrWo7VNZP89Ez4bcRY2LB2g9rqMOdHnkaiBX/rfncJ3KF+cGoYi+zOVg?=
 =?us-ascii?Q?yeWG44gub2vxlkg6k/53OgQwLNJTakhVHzYqlhmerbpKqAtUvDPg8yEBPd0C?=
 =?us-ascii?Q?Vz7b6z0G3YxP/Gj8deJk9yoAP79lP2+Rfn30vqVQk0X4akJPiqC3iZAM/h6A?=
 =?us-ascii?Q?Woky4hbteRrG7WefkplUIfZitJetWjQbGipFxpA6HyYWBI+KKvVTw0AE74Aa?=
 =?us-ascii?Q?Lm7xyLdJyIMjHR7UiFWpbOOkfA6mj1x3c7t4f6kkKYDf9CsRpURt0QhMXcJ2?=
 =?us-ascii?Q?7CECwhTLeiLkN+7Sn+lSSZF4bAZ2eIyX5sOx+SXM?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c631d3f-094d-43b8-c511-08dd1e59a3ed
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7726.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2024 05:14:10.9586
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8fpD9kQFfa3rtmgSeKjbUhJQWJ31Mx99ccUmBBNiVXu52wY7Rdk1P81Afcf2DX5Tf96m/l+sCijQWog/bc/cHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8936

File systems call dax_break_mapping() prior to reallocating file
system blocks to ensure the page is not undergoing any DMA or other
accesses. Generally this is needed when a file is truncated to ensure
that if a block is reallocated nothing is writing to it. However
filesystems currently don't call this when an FS DAX inode is evicted.

This can cause problems when the file system is unmounted as a page
can continue to be under going DMA or other remote access after
unmount. This means if the file system is remounted any truncate or
other operation which requires the underlying file system block to be
freed will not wait for the remote access to complete. Therefore a
busy block may be reallocated to a new file leading to corruption.

Signed-off-by: Alistair Popple <apopple@nvidia.com>
---
 fs/dax.c            | 26 ++++++++++++++++++++++++++
 fs/ext4/inode.c     | 32 ++++++++++++++------------------
 fs/xfs/xfs_inode.c  |  9 +++++++++
 fs/xfs/xfs_inode.h  |  1 +
 fs/xfs/xfs_super.c  | 18 ++++++++++++++++++
 include/linux/dax.h |  2 ++
 6 files changed, 70 insertions(+), 18 deletions(-)

diff --git a/fs/dax.c b/fs/dax.c
index cd6cca8..34a7690 100644
--- a/fs/dax.c
+++ b/fs/dax.c
@@ -883,6 +883,14 @@ static int wait_page_idle(struct page *page,
 				TASK_INTERRUPTIBLE, 0, 0, cb(inode));
 }
 
+static void wait_page_idle_uninterruptible(struct page *page,
+					void (cb)(struct inode *),
+					struct inode *inode)
+{
+	___wait_var_event(page, page_ref_count(page) == 1,
+			TASK_UNINTERRUPTIBLE, 0, 0, cb(inode));
+}
+
 /*
  * Unmaps the inode and waits for any DMA to complete prior to deleting the
  * DAX mapping entries for the range.
@@ -908,6 +916,24 @@ int dax_break_mapping(struct inode *inode, loff_t start, loff_t end,
 }
 EXPORT_SYMBOL_GPL(dax_break_mapping);
 
+void dax_break_mapping_uninterruptible(struct inode *inode,
+				void (cb)(struct inode *))
+{
+	struct page *page;
+
+	do {
+		page = dax_layout_busy_page_range(inode->i_mapping, 0,
+						LLONG_MAX);
+		if (!page)
+			break;
+
+		wait_page_idle_uninterruptible(page, cb, inode);
+	} while (true);
+
+	dax_delete_mapping_range(inode->i_mapping, 0, LLONG_MAX);
+}
+EXPORT_SYMBOL_GPL(dax_break_mapping_uninterruptible);
+
 /*
  * Invalidate DAX entry if it is clean.
  */
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index ee8e83f..fa35161 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -163,6 +163,18 @@ int ext4_inode_is_fast_symlink(struct inode *inode)
 	       (inode->i_size < EXT4_N_BLOCKS * 4);
 }
 
+static void ext4_wait_dax_page(struct inode *inode)
+{
+	filemap_invalidate_unlock(inode->i_mapping);
+	schedule();
+	filemap_invalidate_lock(inode->i_mapping);
+}
+
+int ext4_break_layouts(struct inode *inode)
+{
+	return dax_break_mapping_inode(inode, ext4_wait_dax_page);
+}
+
 /*
  * Called at the last iput() if i_nlink is zero.
  */
@@ -181,6 +193,8 @@ void ext4_evict_inode(struct inode *inode)
 
 	trace_ext4_evict_inode(inode);
 
+	dax_break_mapping_uninterruptible(inode, ext4_wait_dax_page);
+
 	if (EXT4_I(inode)->i_flags & EXT4_EA_INODE_FL)
 		ext4_evict_ea_inode(inode);
 	if (inode->i_nlink) {
@@ -3902,24 +3916,6 @@ int ext4_update_disksize_before_punch(struct inode *inode, loff_t offset,
 	return ret;
 }
 
-static void ext4_wait_dax_page(struct inode *inode)
-{
-	filemap_invalidate_unlock(inode->i_mapping);
-	schedule();
-	filemap_invalidate_lock(inode->i_mapping);
-}
-
-int ext4_break_layouts(struct inode *inode)
-{
-	struct page *page;
-	int error;
-
-	if (WARN_ON_ONCE(!rwsem_is_locked(&inode->i_mapping->invalidate_lock)))
-		return -EINVAL;
-
-	return dax_break_mapping_inode(inode, ext4_wait_dax_page);
-}
-
 /*
  * ext4_punch_hole: punches a hole in a file by releasing the blocks
  * associated with the given offset and length
diff --git a/fs/xfs/xfs_inode.c b/fs/xfs/xfs_inode.c
index 4410b42..c7ec5ab 100644
--- a/fs/xfs/xfs_inode.c
+++ b/fs/xfs/xfs_inode.c
@@ -2997,6 +2997,15 @@ xfs_break_dax_layouts(
 	return dax_break_mapping_inode(inode, xfs_wait_dax_page);
 }
 
+void
+xfs_break_dax_layouts_uninterruptible(
+	struct inode		*inode)
+{
+	xfs_assert_ilocked(XFS_I(inode), XFS_MMAPLOCK_EXCL);
+
+	dax_break_mapping_uninterruptible(inode, xfs_wait_dax_page);
+}
+
 int
 xfs_break_layouts(
 	struct inode		*inode,
diff --git a/fs/xfs/xfs_inode.h b/fs/xfs/xfs_inode.h
index c4f03f6..613797a 100644
--- a/fs/xfs/xfs_inode.h
+++ b/fs/xfs/xfs_inode.h
@@ -594,6 +594,7 @@ xfs_itruncate_extents(
 }
 
 int	xfs_break_dax_layouts(struct inode *inode);
+void xfs_break_dax_layouts_uninterruptible(struct inode *inode);
 int	xfs_break_layouts(struct inode *inode, uint *iolock,
 		enum layout_break_reason reason);
 
diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
index 8524b9d..73ec060 100644
--- a/fs/xfs/xfs_super.c
+++ b/fs/xfs/xfs_super.c
@@ -751,6 +751,23 @@ xfs_fs_drop_inode(
 	return generic_drop_inode(inode);
 }
 
+STATIC void
+xfs_fs_evict_inode(
+	struct inode		*inode)
+{
+	struct xfs_inode	*ip = XFS_I(inode);
+	uint			iolock = XFS_IOLOCK_EXCL | XFS_MMAPLOCK_EXCL;
+
+	if (IS_DAX(inode)) {
+		xfs_ilock(ip, iolock);
+		xfs_break_dax_layouts_uninterruptible(inode);
+		xfs_iunlock(ip, iolock);
+	}
+
+	truncate_inode_pages_final(&inode->i_data);
+	clear_inode(inode);
+}
+
 static void
 xfs_mount_free(
 	struct xfs_mount	*mp)
@@ -1189,6 +1206,7 @@ static const struct super_operations xfs_super_operations = {
 	.destroy_inode		= xfs_fs_destroy_inode,
 	.dirty_inode		= xfs_fs_dirty_inode,
 	.drop_inode		= xfs_fs_drop_inode,
+	.evict_inode		= xfs_fs_evict_inode,
 	.put_super		= xfs_fs_put_super,
 	.sync_fs		= xfs_fs_sync_fs,
 	.freeze_fs		= xfs_fs_freeze,
diff --git a/include/linux/dax.h b/include/linux/dax.h
index ef9e02c..7c3773f 100644
--- a/include/linux/dax.h
+++ b/include/linux/dax.h
@@ -274,6 +274,8 @@ static inline int __must_check dax_break_mapping_inode(struct inode *inode,
 {
 	return dax_break_mapping(inode, 0, LLONG_MAX, cb);
 }
+void dax_break_mapping_uninterruptible(struct inode *inode,
+				void (cb)(struct inode *));
 int dax_dedupe_file_range_compare(struct inode *src, loff_t srcoff,
 				  struct inode *dest, loff_t destoff,
 				  loff_t len, bool *is_same,
-- 
git-series 0.9.1

