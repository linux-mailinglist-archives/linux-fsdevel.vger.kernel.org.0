Return-Path: <linux-fsdevel+bounces-43342-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8A2FA549D7
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Mar 2025 12:46:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80C3A3AE6EF
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Mar 2025 11:42:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE13220D50F;
	Thu,  6 Mar 2025 11:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="us2hlPIc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2056.outbound.protection.outlook.com [40.107.236.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4777220D4F6;
	Thu,  6 Mar 2025 11:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741261217; cv=fail; b=bAU+69GKwnz4v+I9uvsWLFuocmj5iI80eHfB8wSLDzqECTc71XGEMObzWLishCXLDFYiOYoVIgj04bdM2pWTdIafuzegBZaT3vhHJDIUFIcCwu5yB1y1l5uBFzkkOu3d7Fz1bqGYY0xecjPziiZH13RNJwFZ1gHCV8Sy+DC3r1g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741261217; c=relaxed/simple;
	bh=kfuj6Tuj1un3hWjLcspO4RtSms0pB9xrMceArVLjjhY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JmtY+nuz0S92nwGTiocoEUjvgomNR2nULbaIilOLFNbgZgYqVGML7B95pe2rgBm/CtkaHrr48goWgeDkbUU6PJQ62lsgYis9BQRSpPzFva3mcMvVZ5QFy7AQSgX1o80TfGNrD+2OUuhqgkq26EWtnNF1JoXn3w+94Qr5Vt7XtIM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=us2hlPIc; arc=fail smtp.client-ip=40.107.236.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YNFjfC4ziE8ui5LOWhxAIyOiB0Xcv+dsDBC9pc8T+MWhc87V44OPO8D69vwa1fJQxDyQFnSQnYuEJRDVKo1/7JBa3sD/MjscCGkRPrPbR+JCj7Ysi8rzx3bIucVqPHXQJTpb6yjhiOZy9vZHSgiU944/UXy2++FLIn7sPRi9t1FP6pr1gYMtZ50xXBSkQNFX/Bno5BVTOSnapooTfAbt3LKD8RIDsMcQg/uHY2Ei3SnyxHubdxIXjHdIEHBRQqhXPAPrKKSmNwvivachDoFh8q7R37WHUrgXfExfZWzKeiAiHHB2GIdNv5AZdMQmPOQsrnjvuWRWy+Kf9FgUe/0ATw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hOpN0zEc8cInHConMJIJjTGl0oV1Z8GIpP/kTvr5DRw=;
 b=qT9xm26XZ9rAadinxBhq0GZNDAFW12ZiDIVc2RmH1eWOBKMYhosbha+hacZEK5tJ8FFqRQhccYWvWD7tdspvjxkBBuADMlURwWJwsQtdz06JGQxCFkr8w4x+fNJz8KwHRxE+tNX+mMR7ynlC5Zgdz8PG4olZ6WcTmLminP5Z/GKWxYKuHibb1NIB5g9oiVL3PEzxeG5ARdb7vE0U0mHCUxJmDE0XR+qt6mm+j3mIpVnvErzx1+OMcLh5ElhFrbxI0Gq3lO7ERpxZZpdJchORtLJzHd5+97KttJDNrSOWGEmmMDtTOcU011OxuFvyT685mc1FPXfCbqXDw++bcyE+Jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linux-foundation.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hOpN0zEc8cInHConMJIJjTGl0oV1Z8GIpP/kTvr5DRw=;
 b=us2hlPIcWDjpgaU8mKJHi7JjlfFgXVqZo8QOfNHQDrjZdF3cs3LjzSj14AWVCxom8Ux+dUdaZ0BAewS3i+h0fVlY25RArbMWwxeLaYzCweof/WWDYSvsnTDTQk6pauwaL8oANqQsASf2JE9BLOEixBHjO0seOHxIyN+uxg+MkN4=
Received: from DS0PR17CA0017.namprd17.prod.outlook.com (2603:10b6:8:191::28)
 by MW6PR12MB8707.namprd12.prod.outlook.com (2603:10b6:303:241::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.16; Thu, 6 Mar
 2025 11:40:06 +0000
Received: from CY4PEPF0000E9DC.namprd05.prod.outlook.com
 (2603:10b6:8:191:cafe::5) by DS0PR17CA0017.outlook.office365.com
 (2603:10b6:8:191::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.17 via Frontend Transport; Thu,
 6 Mar 2025 11:40:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9DC.mail.protection.outlook.com (10.167.241.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8511.15 via Frontend Transport; Thu, 6 Mar 2025 11:40:06 +0000
Received: from BLRKPRNAYAK.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 6 Mar
 2025 05:39:59 -0600
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
Subject: [RFC PATCH 1/3] fs/pipe: Limit the slots in pipe_resize_ring()
Date: Thu, 6 Mar 2025 11:39:22 +0000
Message-ID: <20250306113924.20004-2-kprateek.nayak@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9DC:EE_|MW6PR12MB8707:EE_
X-MS-Office365-Filtering-Correlation-Id: a0e95e4b-797a-41b0-d0f3-08dd5ca3a449
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|7416014|376014|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0yM9AQMpbAR9/CONQ4MBXeTAcnB1zzZL/UNd4grn/8CEQhkzwjjvNvyga14X?=
 =?us-ascii?Q?prcGJVtEPpHlLU8ejPlaW16MnmeZ2y8Rb5e2AmOB/ZZJBOoNnU58Axe4Ieco?=
 =?us-ascii?Q?CrZuTpfxOdDT0xdD+eO7pBBq2T7o06Kwn5bw50WIkMyLa6u1U8IJpEl7X8BI?=
 =?us-ascii?Q?44HsUpNWGv0d7QuHSaIeO7nOFKRYg8vxUgqymfdqy9YPb/NeO3PkWelN+pRq?=
 =?us-ascii?Q?k2AFEl6bfh7m4GhBh46v1zrioGCGnSVXkRWO+sQcQCS+97KOkeMRrpHitMqn?=
 =?us-ascii?Q?FrCUXfkDtkFK8YTregz26O1RjJ8noWv7bza0KbE7JzvHR/4p4aPUnrMhM75n?=
 =?us-ascii?Q?0j7/4KVlHk1Cx+sCQuL/s5lNWQzJ1v4Pufrqd+ltLyZ2TTfhruj5lca1dmUa?=
 =?us-ascii?Q?xNPS4PcFlOR1TDQHNApij1X9GxMR5wEfJWfxKf+rzq9eaRHDjojppBLB/PsA?=
 =?us-ascii?Q?b/2i1J9ubtwXWDFxVCeaSUpOil8TOBDb09gl/oQ0MRLfuE4BlFxN9eFRJjV5?=
 =?us-ascii?Q?B9Aj2YNrTFKub3iBePCxoiSW3f8ejM73etYdLJq/Q9ascjhe5sDPKv2RrRCA?=
 =?us-ascii?Q?NtzqkvLbHXtpQ2CBvjlbBCPl9sn9ALeNTSvAQk4DcNwQ6k+wMJkTtoksyygY?=
 =?us-ascii?Q?ISF31nD9tR3Kq9/kHgQKeaTYWJpbPJH7ScTdzvJ1YO2kJfSGQs+KMyqAmX6I?=
 =?us-ascii?Q?U8B6k6g9e1kmc7Aer+O+b185NOGwM4TVdETvsPkQB36yrvXaXRrjmC10FjSx?=
 =?us-ascii?Q?CM0qCNAmT4PPfB2e7KA0qD9zA+TSgcdEzqUH/i04OWSFExcD7ClKuNMNblIS?=
 =?us-ascii?Q?j46FAx+iAO6TldWbEbLIucGx8JFMKurWPyWVxqzrhdEYMJMm1XOXImSan0QG?=
 =?us-ascii?Q?F+kqMvuN7JTb/x5e4+PqaQa/OMkGfUHkw/N6efTDbDARww7/PsplS3rGAB6u?=
 =?us-ascii?Q?9LmskymzxICIZt943ukq5wuIf91/6nGeqpSqlRU33dwWElB1dnrubh9XnVpu?=
 =?us-ascii?Q?EFq37cOp/87ch0ehpvpKs66bPH7FagHZHMNLqlDtyrVvAQQ30EGqOPp8lK7Q?=
 =?us-ascii?Q?a+w3o7CGJDHIkopN5B8XvrMPvb/JU2fGk2bvCL/Wx0Ivkn+GEa0+/Hy3FgCQ?=
 =?us-ascii?Q?RLCUSXeyoNp4bDHddxtOrM1X7t3nMmCjdcp6sI8fquGt3idtUjs0RyXMkZHO?=
 =?us-ascii?Q?GSi6hMogt/kD2Lw3+aT42ODGi7qFOPLRvC9wghAJIGFDwNhJ8LBpm3LzI7VJ?=
 =?us-ascii?Q?d75iFL6N6EV6JLwx1+j4EfJp7WQ8AtMOWrs5lt5KMczo4xSdIsLWrqSo+7+T?=
 =?us-ascii?Q?uDtKaTPgm0kvYJNGoJwgA20EaSKvrJdjr+ei1fvIrtcKP7q+HrhKmTv2X7uZ?=
 =?us-ascii?Q?bPCRXRLCVvfnZcgGjvDg4eXawIRLYhOGt0tjWFCUXoY0AbJnURZd0JWV9A6T?=
 =?us-ascii?Q?3clhIL0lF4EUwaxiXatOqP7QJh6wDt4jPkqd/qO04ifQpBVne5CG6w8iyqbI?=
 =?us-ascii?Q?RrtN7m1+nk1ZV79f1DJUn5aHcogEncfVAuiM?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(7416014)(376014)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2025 11:40:06.0329
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a0e95e4b-797a-41b0-d0f3-08dd5ca3a449
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9DC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8707

Limit the number of slots in pipe_resize_ring() to the maximum value
representable by pipe->{head,tail}. Values beyond the max limit can
lead to incorrect pipe_occupancy() calculations where the pipe will
never appear full.

Since nr_slots is always a power of 2 and the maximum size of
pipe_index_t is 32 bits, BIT() is sufficient to represent the maximum
value possible for nr_slots.

Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
---
 fs/pipe.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/pipe.c b/fs/pipe.c
index e8e6698f3698..3ca3103e1de7 100644
--- a/fs/pipe.c
+++ b/fs/pipe.c
@@ -1272,6 +1272,10 @@ int pipe_resize_ring(struct pipe_inode_info *pipe, unsigned int nr_slots)
 	struct pipe_buffer *bufs;
 	unsigned int head, tail, mask, n;
 
+	/* nr_slots larger than limits of pipe->{head,tail} */
+	if (unlikely(nr_slots > BIT(BITS_PER_TYPE(pipe_index_t) - 1)))
+		return -EINVAL;
+
 	bufs = kcalloc(nr_slots, sizeof(*bufs),
 		       GFP_KERNEL_ACCOUNT | __GFP_NOWARN);
 	if (unlikely(!bufs))

base-commit: 848e076317446f9c663771ddec142d7c2eb4cb43
-- 
2.43.0


