Return-Path: <linux-fsdevel+bounces-43404-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F5E6A56004
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Mar 2025 06:30:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D4123B4E7A
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Mar 2025 05:30:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 307D8192B81;
	Fri,  7 Mar 2025 05:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="e5+6qiMo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2077.outbound.protection.outlook.com [40.107.237.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8D4C10E4;
	Fri,  7 Mar 2025 05:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741325422; cv=fail; b=ZM+hDocIDMN2g/pIOVh5VoHasLtoRHOzuwMVLrDbarXi3wKvxFuNpPaJh2B0c+6NF6c8bRV0ULbKG2DxMRYUS9lx3vvfTaQMzv8fQIAMmYSlsRRfwe5skNRI3lwRkHwmxWJueabpSoTdjiPCTizXqhPxSE8viCq65GmmMpzroWA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741325422; c=relaxed/simple;
	bh=xKSvsqplKs397uvJ86IP99n0l87p+1fQl/qlWBIXo3A=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WxBOWBUgYR8OIJG62q0TqkS1g84vBuUzSMKltoxQZaPFLKFOm+KUWtcDQTLIFptxjv6wmG4+EVIVvSVo9nz2cqHu1aT9S1yX6kTwxlL2xvrU+jTwYuLpK3UIMTPfdhh/U72MRtNhOHuFaPEPzjtJCoDSF+4pLqhIH95hqcQX2tc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=e5+6qiMo; arc=fail smtp.client-ip=40.107.237.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=caa5GJGdLgxGhE9hqfFZ3zWGd5PCaD09BJi6HpPkT8d5RkXiaqG2K0hKq/4BKaXs6Hin0C4DolK+EYu0hrVnBTGXbwxkEaPHL2UChpAFZvhoueceTryr6NGsRHZtttkZQR6ltw8fmTxJgRZZRrGVQcvMwehlgYrhwRK8iLNVqRblApBXBWfoufN4LEq5SR1NjTHW3XIqyB4TzxiHJhx0dQmzggDPPGlTMvii5nBSn4U5/2JOe4xiBcax2Rc2qCtOb2yynEjWhOyqmqb7lcsRZkmNqADWT9GUuMgsFNuuZyo4uLzJZ/+RqRJDB+VA6aU1UJdcPAvn1QX8Q9q0LvGftQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iiP2qiR8gLuSVVOWR0tyRnMR1UGprbqzHrSdraYZfnI=;
 b=OS0sPe5vFbeFwB0+Dw7KXD44D56muJbzYGcvXFQlMTy6e7gyrxIU2bjs6miw1GtWQb+YKDSz7EQqXR+4lleHB3JKN3HS5/pA5ccA/le1KEw9Ha+AASPflp7PKepd3R+i+MLAIt9ok5ab6hrDxCbS2uIyx1R+B4m3GNQZp5ZlCEvxB7wwcE3iJnz9bdHbSBb4b0T9PZxPwTRyFpl2RZ1Q+/tLeqkX/5NvCKqk38S2M8U8CHjkzfWz8MXOKykGx6DQ+M6y/f5Zvix4cs3+isVcuw19xy9sHAn9KkH4c7BTy0kB87dOLNx39FHf2nYvubvUVB3ligRoZnEoalfpyMDxGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linux-foundation.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iiP2qiR8gLuSVVOWR0tyRnMR1UGprbqzHrSdraYZfnI=;
 b=e5+6qiMozXxUH2W8lzR6OyfDzYNxTQ2kIOmlQMXYlhqMSa+ONlfcwSrKhZsukzyAIQ0LxNI6m/S+aUPuyO+pD5/h3+eKJjlvpXJ+UXJKfhWRLDvVDJ7sj2sgJP7hi8O7L6/EpsAlGiJeSEfd7U8fSVuZ8EgNQa2W9Tt0BYBahqI=
Received: from SJ0PR03CA0106.namprd03.prod.outlook.com (2603:10b6:a03:333::21)
 by PH8PR12MB6724.namprd12.prod.outlook.com (2603:10b6:510:1cf::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.19; Fri, 7 Mar
 2025 05:30:14 +0000
Received: from SJ1PEPF000023D4.namprd21.prod.outlook.com
 (2603:10b6:a03:333:cafe::f) by SJ0PR03CA0106.outlook.office365.com
 (2603:10b6:a03:333::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.19 via Frontend Transport; Fri,
 7 Mar 2025 05:30:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF000023D4.mail.protection.outlook.com (10.167.244.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8549.1 via Frontend Transport; Fri, 7 Mar 2025 05:30:14 +0000
Received: from BLRKPRNAYAK.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 6 Mar
 2025 23:30:09 -0600
From: K Prateek Nayak <kprateek.nayak@amd.com>
To: Linus Torvalds <torvalds@linux-foundation.org>, Oleg Nesterov
	<oleg@redhat.com>, Alexander Viro <viro@zeniv.linux.org.uk>, "Christian
 Brauner" <brauner@kernel.org>, <linux-fsdevel@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: Jan Kara <jack@suse.cz>, "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Mateusz Guzik <mjguzik@gmail.com>, Rasmus Villemoes <ravi@prevas.dk>,
	"Gautham R. Shenoy" <gautham.shenoy@amd.com>, <Neeraj.Upadhyay@amd.com>,
	<Ananth.narayan@amd.com>, Swapnil Sapkal <swapnil.sapkal@amd.com>, "K Prateek
 Nayak" <kprateek.nayak@amd.com>
Subject: [PATCH v2 2/4] kernel/watch_queue: Use pipe_buf() to retrieve the pipe buffer
Date: Fri, 7 Mar 2025 05:29:17 +0000
Message-ID: <20250307052919.34542-3-kprateek.nayak@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250307052919.34542-1-kprateek.nayak@amd.com>
References: <20250307052919.34542-1-kprateek.nayak@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D4:EE_|PH8PR12MB6724:EE_
X-MS-Office365-Filtering-Correlation-Id: c0ac77e8-fc05-41d9-0e82-08dd5d392356
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|7416014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?wVjEC7J50k8HB/y4KkQ69VE6+AsUeAvkE6KsUusEeBq7lVeEVA3+0dalaRL4?=
 =?us-ascii?Q?xq4RoD4etUScpM4xwa1ItqRk6Kal19d6DIzFgzEv0u4FktSPB072wgOOwPDh?=
 =?us-ascii?Q?X8/FEO+OwMj84ZA8idpLXQiycmMIhPdHZeW5As3Q7inRtDPnK00OvuQ8/OHR?=
 =?us-ascii?Q?BJ57OuJxAPnbB8XnWuyvHd0kENA/UddC+3VHh3Gx95d1+jfnZHTxsByKdG4u?=
 =?us-ascii?Q?plz4k/Zx3SLq5A4oSDwn/NaOHkUbm2ZqRThYOh9hzQV3sDMdyB2YE/Ed/KZ2?=
 =?us-ascii?Q?z8dbvq0q52Q/MvHKO8UWBrIn4iXZVVNjBjbLqzJJxPgpGHzrv0nK/kwFuaFA?=
 =?us-ascii?Q?Cg7g3Sc6kC2YaBq88DLbGfozTA4yf0ZgzhWQEYGAB7liSYmlGvP2Jxkc90jQ?=
 =?us-ascii?Q?WC17bHX0iyd+4C8dOE2pwjp1GDD153vxI7yT3v8Gjhs71jAl+3O5o+EtcYjf?=
 =?us-ascii?Q?u+jSTTck1Uyh9nFvLXAQ6Fc4WvNCPtoNZ8gtkDNfM6RR2PwoUqM/FmL51wLT?=
 =?us-ascii?Q?4MNXwdHHiIjZJupL/wjw7nTmY+Uh573yTaM1Yp9MMjqAorKSfvj4B6TzNTbb?=
 =?us-ascii?Q?QCaZsxTHbGMp+kKQrmA/nn0VTqBnZUB7OWKStl3hOHRlRY4qw2MyTdk02Zar?=
 =?us-ascii?Q?ETDtYDqkbrjp5QlEWVsmkpdHSkKxPSW0xwlh0erk1pncLcw98JTX3bz7WcBD?=
 =?us-ascii?Q?CUzLqSO19SqJiJdngFZph96vhxbAHJqihqcNPRLArfFLEM4cPlw9iAySS/4o?=
 =?us-ascii?Q?dIbMMSVPxlB24SXKvwfHZhfCCgWjUyVAL7YWpwk1P2KkBSMWB8w3hpCugqmB?=
 =?us-ascii?Q?dmrJ3mmiV2s60rg4BOr7KduJjumEg0Ez+wCHG2ANJz58ePQjXKUH+O5JO0NQ?=
 =?us-ascii?Q?hbKNOMcQjxvXPXE96HbOxUCViunUXLuugjrjBFuPA4OlxhAtU3Wp2WQcdptE?=
 =?us-ascii?Q?09E/H26jIqC1qAfzZkzLa8PqO0bTyrIOWqJhzkAIPfa/GabZ2pEKPUYqY6yL?=
 =?us-ascii?Q?3JygSdokXT88g8mUf1cruckOt/vT8IfQs1wTQBJtgCFzB7uCjiC4yocuIiXN?=
 =?us-ascii?Q?UKmzsfOvi64xoBH2tNqK98DnsXXRFIWsSONZSee4ePbxn39/xNfrjOyFt0+f?=
 =?us-ascii?Q?OwSCVk2Y/ogyJ+bDZ1JpNBckPFkyaIsPEZMF5HXDVtlRbWWOVTHpyBdhmYvJ?=
 =?us-ascii?Q?cXFdRB4d0JbxTw7FVdtRO4+kkXoajQEtqwo3FmGLubiReZF9G66p2hbfXM3M?=
 =?us-ascii?Q?rqpP9zB29WN1VY/gScvnJP+CbSH8QFDwCbAN1Oi50+vSJR49IZVI56z2sCve?=
 =?us-ascii?Q?qnyGvOc8IpHtbtCVrXzlVi1r4cc8QW42V2eEK1SlQQg28aROFIMhXmwLNY2e?=
 =?us-ascii?Q?j1l+BhWWAF7m4+vpJXeexjB+GjrzklJsaqBeyjq9fv3rCv7u/mmZoPZNPGTe?=
 =?us-ascii?Q?agn6PozFS1d9HS8GQC9xIGDcwkkFfx7R0pFaniVJTxs2SwbLUAnfTw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2025 05:30:14.2902
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c0ac77e8-fc05-41d9-0e82-08dd5d392356
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023D4.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6724

Use pipe_buf() helper to retrieve the pipe buffer in
post_one_notification() replacing the open-coded the logic.

Suggested-by: Oleg Nesterov <oleg@redhat.com>
Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
---
Changelog:

RFC v1..v2:

o New patch.
---
 kernel/watch_queue.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/kernel/watch_queue.c b/kernel/watch_queue.c
index 5267adeaa403..605129eb61a1 100644
--- a/kernel/watch_queue.c
+++ b/kernel/watch_queue.c
@@ -101,12 +101,11 @@ static bool post_one_notification(struct watch_queue *wqueue,
 	struct pipe_inode_info *pipe = wqueue->pipe;
 	struct pipe_buffer *buf;
 	struct page *page;
-	unsigned int head, tail, mask, note, offset, len;
+	unsigned int head, tail, note, offset, len;
 	bool done = false;
 
 	spin_lock_irq(&pipe->rd_wait.lock);
 
-	mask = pipe->ring_size - 1;
 	head = pipe->head;
 	tail = pipe->tail;
 	if (pipe_full(head, tail, pipe->ring_size))
@@ -124,7 +123,7 @@ static bool post_one_notification(struct watch_queue *wqueue,
 	memcpy(p + offset, n, len);
 	kunmap_atomic(p);
 
-	buf = &pipe->bufs[head & mask];
+	buf = pipe_buf(pipe, head);
 	buf->page = page;
 	buf->private = (unsigned long)wqueue;
 	buf->ops = &watch_queue_pipe_buf_ops;
@@ -147,7 +146,7 @@ static bool post_one_notification(struct watch_queue *wqueue,
 	return done;
 
 lost:
-	buf = &pipe->bufs[(head - 1) & mask];
+	buf = pipe_buf(pipe, head - 1);
 	buf->flags |= PIPE_BUF_FLAG_LOSS;
 	goto out;
 }
-- 
2.43.0


