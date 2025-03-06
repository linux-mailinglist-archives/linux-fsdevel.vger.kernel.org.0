Return-Path: <linux-fsdevel+bounces-43343-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 47335A549DC
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Mar 2025 12:46:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6D8E3B3AF1
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Mar 2025 11:42:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E62D220E022;
	Thu,  6 Mar 2025 11:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="r8RrzXk1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2070.outbound.protection.outlook.com [40.107.102.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE0A920D4F6;
	Thu,  6 Mar 2025 11:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741261230; cv=fail; b=Gden5vRtogpBOFoXcACHSltu7+8aTmyAebKl9k6ACXpEvKhb1hp3QIXBEooKv5B8IvAoWTLNm04FJzs++4HRyHwdq9WVlCLl4OMB/76ZxU6axjgMZFAgUn2YSdiRNhjexl5o+zP0QJ2tc/QwwPezJubLwR/Xi+ILKSevFEJY05Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741261230; c=relaxed/simple;
	bh=Vw19LwwoFcvg9YQ6KNQx0U78TJUsOCxfFBkQlH9goao=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=K/Hm0cchABV5fY2RIKedct+hrG4zFNyeFszqCef5Ou73/mlhTgsY4ZjkMGmMm2KoXfJTFrDJZVBEaHoSVe7HMWPqUUWJYfa+rdI4UhcZitHw8WNPTFHdIMRpPbwFWK0gMxn2JBeMaabbVjTG5pGyRVsiHewQ2trzW4nwLvqDdSU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=r8RrzXk1; arc=fail smtp.client-ip=40.107.102.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OFP5sfrZOGG4SK5k1Hk72lDx/LlbGyGHtyqwxj0eE7r/6yKyC2gqIulROF3Y0JD/WxqGF2/Y2GaYSGLsYpI26ucAFqRKzvr8xqY0ClKYp5/25igVJklDOrOiVgKNPubyRN+5pf2dnl+cpe+xx5X8/1qUR5C6zlhTAs9T4i8ddCVMzbpUJ+LDMAdCQW8mPon7ICIaphcAGGvolJtWESdVKyLUtCRxUKFxR/vtO5Ggk2JD01P6qDY9u5I8XFDNOkqpSQHagRYn5LwxTDzmePW+YxuCVEsA6O8wmutWxSEFQ7MAJw/l2/Onmvr39RXB2P0sIQCTAGGizOXDXsacIoizOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qb6yW67yojK6bb6VWOs3X8iThjJoUbpShCGMeGQd/Qg=;
 b=KyhC6Vcc2agVsxsYbS6UKNy5huMSYzYJ5FkHDPT5JwuhQEsMVOr71Ts88+5Glbm7UV4+yHJOd9326PkJKOStRv82IngY8XITJk6OhJBX+sD3kK/7yKyG4oD11Ovsym1Oe7vhm0QKXlFt1gyIn7fik/P8mzQx2BdSc/fUCkxAXHP9jhqMIS58pTCiq5M+NU+WESygOfaPMWXbkLQsGJ5eW/wVUJJfs5KoAbcIJCyM7pXOwwa9z+k2GQQX+sqqnN2pVS4a7dneEPV5KT2dPqwZ+CkKpRDkl2KPwjyFy8m9rKux/MQCLGnQ25MU9jjSjh+326Ba4mKxj5Kw5+JFBjoukg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linux-foundation.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qb6yW67yojK6bb6VWOs3X8iThjJoUbpShCGMeGQd/Qg=;
 b=r8RrzXk1t07TCv9KG5xroR5gzpk1YWZGb+AbEHJuhszrYnlwOHSasra+lYU36rNaJc8SA4wTSSXxYWHouUcpC35oyVoqaaVGWxb2cJzsmiMEHP2VAan2p6A+YY9ucfClWVVIvLeb//5qb7AFPKL1orZ+LD+G9fg55vyF3zXz7JM=
Received: from PH1PEPF000132F0.NAMP220.PROD.OUTLOOK.COM (2603:10b6:518:1::33)
 by CY8PR12MB8066.namprd12.prod.outlook.com (2603:10b6:930:70::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.18; Thu, 6 Mar
 2025 11:40:25 +0000
Received: from CY4PEPF0000E9D6.namprd05.prod.outlook.com
 (2a01:111:f403:f912::5) by PH1PEPF000132F0.outlook.office365.com
 (2603:1036:903:47::3) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.18 via Frontend Transport; Thu,
 6 Mar 2025 11:40:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D6.mail.protection.outlook.com (10.167.241.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8511.15 via Frontend Transport; Thu, 6 Mar 2025 11:40:24 +0000
Received: from BLRKPRNAYAK.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 6 Mar
 2025 05:40:18 -0600
From: K Prateek Nayak <kprateek.nayak@amd.com>
To: Linus Torvalds <torvalds@linux-foundation.org>, Oleg Nesterov
	<oleg@redhat.com>, Miklos Szeredi <miklos@szeredi.hu>, Alexander Viro
	<viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, "Andrew
 Morton" <akpm@linux-foundation.org>, Hugh Dickins <hughd@google.com>,
	<linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-mm@kvack.org>
CC: Jan Kara <jack@suse.cz>, "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Mateusz Guzik <mjguzik@gmail.com>, "Gautham R. Shenoy"
	<gautham.shenoy@amd.com>, Rasmus Villemoes <ravi@prevas.dk>,
	<Neeraj.Upadhyay@amd.com>, <Ananth.narayan@amd.com>, Swapnil Sapkal
	<swapnil.sapkal@amd.com>, K Prateek Nayak <kprateek.nayak@amd.com>
Subject: [RFC PATCH 2/3] fs/splice: Atomically read pipe->{head,tail} in opipe_prep()
Date: Thu, 6 Mar 2025 11:39:23 +0000
Message-ID: <20250306113924.20004-3-kprateek.nayak@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250306113924.20004-1-kprateek.nayak@amd.com>
References: <CAHk-=wjyHsGLx=rxg6PKYBNkPYAejgo7=CbyL3=HGLZLsAaJFQ@mail.gmail.com>
 <20250306113924.20004-1-kprateek.nayak@amd.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D6:EE_|CY8PR12MB8066:EE_
X-MS-Office365-Filtering-Correlation-Id: a6b719a1-e0be-4a11-f2ac-08dd5ca3af93
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|1800799024|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?LmZ0tLhsi5yIhjYuciVW1JA6qxzTsqSiJE9RY9SbYuzrWnPCAzGD9wdkkwCQ?=
 =?us-ascii?Q?s8ztuX6LpIgZWeIGgRHLrzARu/Ua6t8La4EDth3U/gzz9n1MEcxLZVE2jKpb?=
 =?us-ascii?Q?TvrXQpiN04tGhoiNyzVi9cxJj3o3Kn5yiWmI4dKjO5p7MLq41JzVWu71BBaz?=
 =?us-ascii?Q?cOMGC8Xw9yFq/pkA8h8wrBghheFe0lY8mI/GLur7t8h0v5UrJ/yoPQuqND35?=
 =?us-ascii?Q?KbFbkkgtSOK0sIlLpQ+UsgVaTYOri0kKnqiLpmSw0TWfJActPoREyP1+OGvd?=
 =?us-ascii?Q?o2HlbhuCFCf8PC8/+8Qmj09mQgtovFvaWX+VqleeZC49WUkA7JC/Jxdzs9e+?=
 =?us-ascii?Q?eWJsDehYDGBccDrGf5RTa6IA8jc8nAX7+Wtn6KLUu2scwowXU2UniHNXleBS?=
 =?us-ascii?Q?5NpI9Yj0KLaMSaR2KwJIi9wJCFXOx7BWNQtuJ/C+bDKslUenICbHBOiOEmnG?=
 =?us-ascii?Q?tnhlbb37BaX3CVQ19Y5rRJjxbsjsp2Pb28rAs/JwEwUFXRpeEaOw6indLGl9?=
 =?us-ascii?Q?8LaZ8DSHuZ5cXyo6N4c8yffJRUmvsDQ5i9DOYAKtsDD2dA9GN/o3aSrqOP2U?=
 =?us-ascii?Q?pIO3vYg7y2v0Ro/dY8uj5osJEZ6A/Ycfl9KcYVa8PQd2vZ3JwhtuRYf+wlPb?=
 =?us-ascii?Q?5o6JRf830s0I2oeFaH0GmnkYQt6keXvj12bQ3juymy5DriMHyMR7vIkFsBDf?=
 =?us-ascii?Q?NSoX0pI95UbSxaD2EZY/+UWJb2FG4ve6TSn31XMJMILYwRd/kJFV9LB/7hkd?=
 =?us-ascii?Q?v+XN1QpVuxlmTUp58zDcNFY8O6uLiAKjumr6d7NlGuE3w8KvFEP2ot6t1UOj?=
 =?us-ascii?Q?UoZgd6iAs4LWd9y6Yg8R25ECg2qD3AWVmyZKl6e++5wG6AwhDdPT6r8qhytM?=
 =?us-ascii?Q?0pw2HNwhvkjUUSxyYbigyYRsE6N8V71JJmhLa0XI+aAl0pecNUZ6BsPLaL77?=
 =?us-ascii?Q?JHW5zUCJYsU4wNHJjsbGupZU7sI3VhGlI8qXNJx0HpQ96hmkd0tlYynsGdPB?=
 =?us-ascii?Q?SEvSAv7ynh+16p9RDBi6S4Onw1YTK/GneiXLRzhZvgvj35LCpa2dTvW5Ioti?=
 =?us-ascii?Q?yxtPWtVcYNTcZwcyTuHwWhgvmeHomLaTNVNJ+DZxGWk+Xr4ELlIYIkSr5Lot?=
 =?us-ascii?Q?DVBHCYteFw1P7yfVZWf5MIB5IMAtSfmbon3kQMUu7LLLey4L9TdJmRxIOL0N?=
 =?us-ascii?Q?YjI8QxlQdUycvYpqEV1H6FuUUTcQR12BdA0ndfW6XbjMMhFR3N2mD70KoZI9?=
 =?us-ascii?Q?ddPUDAKwtbQ41ZPNTZeMyKA3rkHzhrJJUZHO00sqbfTv4Xs2iVeNp/leSX3B?=
 =?us-ascii?Q?FWvQwYll/r2xjLgJQoOwT3RViVvKekL1Rn5D2xpeZ8uLMH3JwV2amxfLAYTl?=
 =?us-ascii?Q?Yxt7lHg3EPJjRDXVkArjaD+8rw3MpFYGGhBogTNuKTJvy7VS1vYJuOQml8cW?=
 =?us-ascii?Q?NOMZu6UuKqhlN+yrUIVDhejOBif2dQ+BESGhVifSc8Ae2dIlMRlrpTNc4nvs?=
 =?us-ascii?Q?V8VbINmnw4u9EswEeZ5vHlU/D5a0///ERESs?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(1800799024)(36860700013)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2025 11:40:24.9893
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a6b719a1-e0be-4a11-f2ac-08dd5ca3af93
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9D6.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8066

opipe_prep() checks pipe_full() before taking the "pipe->mutex". Use the
newly introduced "pipe->head_tail" member to read the head and the tail
atomically and not miss any updates between the reads.

Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
---
 fs/splice.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/splice.c b/fs/splice.c
index 28cfa63aa236..e51f33aca032 100644
--- a/fs/splice.c
+++ b/fs/splice.c
@@ -1682,13 +1682,14 @@ static int ipipe_prep(struct pipe_inode_info *pipe, unsigned int flags)
  */
 static int opipe_prep(struct pipe_inode_info *pipe, unsigned int flags)
 {
+	union pipe_index idx = { .head_tail = READ_ONCE(pipe->head_tail) };
 	int ret;
 
 	/*
 	 * Check pipe occupancy without the inode lock first. This function
 	 * is speculative anyways, so missing one is ok.
 	 */
-	if (!pipe_full(pipe->head, pipe->tail, pipe->max_usage))
+	if (!pipe_full(idx.head, idx.tail, READ_ONCE(pipe->max_usage)))
 		return 0;
 
 	ret = 0;
-- 
2.43.0


