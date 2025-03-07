Return-Path: <linux-fsdevel+bounces-43406-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CB7AA5600A
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Mar 2025 06:31:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D15FE3B4D4D
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Mar 2025 05:30:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 034EA166F3D;
	Fri,  7 Mar 2025 05:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="wZqWOEGF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2043.outbound.protection.outlook.com [40.107.220.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC8E8157A48;
	Fri,  7 Mar 2025 05:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741325456; cv=fail; b=eUxILQQbj/88PEwIPj4hbgX1972lB0c9QKXc9kIsLoliqbQnD5lwOQMa6hwGDb06oeYpn8USnIeB0b1wXEi61N1AfzL8jcmdnxw2QoagV/hwPc/AODUrBkLUkW3BeJaOPOoXdB2Ns0GoCdN0PIzMJqE3s9jnRBnyKKtc7GqUUao=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741325456; c=relaxed/simple;
	bh=A9d/q1YpQvLlyUbELP2m65tW8cqxGx7CgZxDrZDYz54=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rPeog0zpqORn/9b1Xxi9trQrEoObwLc0EIgVYR3WMuB+CP6pHhscUOw1ey5//WtWUCAuBEUXAS3UfJTdTbzA4tvJtEK2EFavv9XSqUd7a91EAnnzMpVDGouhgChzbx9tzE31RIOrvg7MUCQs9+Uvny5LwMWMld+m/0tHs+Nitps=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=wZqWOEGF; arc=fail smtp.client-ip=40.107.220.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oZ0Ifu1dT/zK+2KWEd+0Gi7zARp8dPYojFSe404ocWR3Y3OVAMaa3DF9vdLN4A4dKGWTJXWrYk4mfVOYz1KEFyMUY2B/LTfkr6dBoTvvtV/J1tDM2AUZzbxgPIE7gWBdhxrqNawCjCm0Af9IB7gO/JxSGjbV5VD9fRGFSHfRX260GqRbB6ddS74jemPWRt8sl72r5SEki5hxhiVlagYA+HG2Lh23DS8tN5OQwXkabgI3R7PVz3whuaLeixYKbT6MKMRNPPToe4suSnXQBlj4EUaYCBsDNQu4YOtKVEZFjZP5N1MVjCqfcv/a07Giycl6K+SgRjVUyO+nzwqKm1QeWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U/LEbqWXu9+405LHQ0kI8kGwEk0uesBShmGPBh9BRwk=;
 b=ynUE7kt4mq0qPw9YupWyTVLocVlprgo7JtDQKmqH7Zms84QtivmPpbibpSUmYp28Hv4295b1Y3Y+mtTHSliHvGRsOHhL0hnF6bYOej9uXLXCtOVDxQ5XoYw69HAMo7kZ6ff+d7cd7yRCFSHhfKlRHQbpiOeWalNo/H0mzdgb9qj3u0uLpP9R6k3DMOi5T+0maxP0fmq2NXGhe//47NQBXeSJ5gE5Hfx0sdlq8bOYJ69+DnqVUDnpYaOg4PcadskN6434gN2Eqns93ML2Xx9K+BNSWCBSm1tGNXViXSI0QZYFFSC4L3x0nr17ifYWouSVOb8lsAh9aGIumMBQQTaz1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linux-foundation.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U/LEbqWXu9+405LHQ0kI8kGwEk0uesBShmGPBh9BRwk=;
 b=wZqWOEGF2tD6dAJPtE/CHdjRxuMCdcr09N3FeHT6S3T5lU4oENotc8JJasYVColrfwXEipfe0Et05As5wKbvf0FF0xaQiwMW2Kz0F7BX9Y/E5Fpd0fdl5JRcXETOl1Z9XHVDg6gBkYOvIazGofTMwCAjHWCuzU26Qm9rC+i4K8U=
Received: from SJ0PR03CA0183.namprd03.prod.outlook.com (2603:10b6:a03:2ef::8)
 by DM4PR12MB7624.namprd12.prod.outlook.com (2603:10b6:8:107::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.18; Fri, 7 Mar
 2025 05:30:50 +0000
Received: from MWH0EPF000A6732.namprd04.prod.outlook.com
 (2603:10b6:a03:2ef:cafe::a4) by SJ0PR03CA0183.outlook.office365.com
 (2603:10b6:a03:2ef::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.17 via Frontend Transport; Fri,
 7 Mar 2025 05:30:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000A6732.mail.protection.outlook.com (10.167.249.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8511.15 via Frontend Transport; Fri, 7 Mar 2025 05:30:49 +0000
Received: from BLRKPRNAYAK.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 6 Mar
 2025 23:30:44 -0600
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
Subject: [PATCH v2 4/4] fs/splice: Use pipe_buf() helper to retrieve pipe buffer
Date: Fri, 7 Mar 2025 05:29:19 +0000
Message-ID: <20250307052919.34542-5-kprateek.nayak@amd.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6732:EE_|DM4PR12MB7624:EE_
X-MS-Office365-Filtering-Correlation-Id: 1237710a-2928-47f8-fcbe-08dd5d393881
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|376014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?sa5CPHCw+cy5F1qcj41/yZdn4U0MJ1n6hcYtuBqihPQfkQbQIvRbAHcyQsMc?=
 =?us-ascii?Q?ayv/7+us3Hs5Ni1hqEre19NRJTgVZEb5sKppVlS8ta+Jh+lHPrgDejItZp2V?=
 =?us-ascii?Q?71ovlld3m1D3lQl1NlVvlisUgTSspmr3Tn5e5QVEUxDet2MuPLQEUcamqP1U?=
 =?us-ascii?Q?eAF1aP5febTJ1XBG29LLKwnTkmbNSpTTjT2t0qWJzOK/HMSC9KMdGFZYhDVP?=
 =?us-ascii?Q?UoHddXBcqUssA6cZwB3CnCwcsvCs1DC0EsBuelSk+X4PMwP0Qr5/488DoIX3?=
 =?us-ascii?Q?RfWEEzMtHb5hHWv+EAD8tGT339eeLKY8g28LURAt+6pGNlbaQPcpOiE+LOT0?=
 =?us-ascii?Q?Q8DOggM1qS+csaEZiAVcv2lI5dIZyDtkOeKrVfdC4ANGBULLmiiOx7Y0ibqh?=
 =?us-ascii?Q?RE7SwW8LuEz9gTh6yZb22zwYEjP9e3qcdJ+cx95KS3G6B2PSNgKf3IWMG2GX?=
 =?us-ascii?Q?jVvu7p4d46P0g48FXVgT3vQBpBLAPJ1LF9jI1VJr6evdZmYnJRdjh6kmGiL3?=
 =?us-ascii?Q?gPva+KS7dkxrmFdYdK9EoKhuRobgtZkNn/RZi/qoPhVDKUaOa5ExJmObG149?=
 =?us-ascii?Q?2mhga6xsfLrhaGpp736IoVEFL3KHwpcufoUGOn1qtn6TZ6ZGqIYo3IucxhEV?=
 =?us-ascii?Q?PasWgV53KcJt/lFyv9lykvKBZJH6c5SW6q4BPnzg0xdlosE94wuIwYJ3hi2N?=
 =?us-ascii?Q?demvzvq9TbVKgWN4Db0Qk2p2TnC7LZmyy2anSR7JGWEI8ug/YKC+Od81K+Ab?=
 =?us-ascii?Q?otqtnVLYg1trvqeNdgvoC6HYCzbQscrBUgRbbt0bRAOLHSO4suFdORguhIhY?=
 =?us-ascii?Q?y6i/RP7dljbVhkwAyZVzyaVMiiPY3nNnGoMPJ0oE/acAU/3YTPnujTVmrJwI?=
 =?us-ascii?Q?YQk/+TgU81EvBjbDYkZHpvkYLs43zeBHwVvhD4FaioLG2gwJBvFpXUj0cqPG?=
 =?us-ascii?Q?2rNAG5eRTXKsohFHyoHIiIV4/sgfjmuVuzo7KJEZhONEDfgcww+7n3B9DTo5?=
 =?us-ascii?Q?bgCxmu5/2NKZJ7BezMP31+ZNytdHDRlFds0aIkaAMBBtzqW/9IMvIrQvp4rL?=
 =?us-ascii?Q?SjSU0NI2NQ6ia1D27ynIRLSnX/p49WIM6/3owLqEUEEQ9BhzWIyFL4QTAfql?=
 =?us-ascii?Q?RvGnZ5GFRcgWf8juHGxzmNhs0dr+sCW86m2s/y9XCpmRhPeFVvCrzNSlvLWg?=
 =?us-ascii?Q?ervJQqqefWNF0H8I+bCmc8CLbMKOWYmgAhXNwS2P9Pc8ZlkCrxO3CRVG6a8G?=
 =?us-ascii?Q?f1Zj7kGtwP2nqLJs+6T1Tmv2zsRmcT2TNLCCienWNHN53AkA5cQZVsqqegO8?=
 =?us-ascii?Q?C3CDY2a7PxOV6hNPqdNdnVaBjI2VSdnt6qRAAo5Nh2onMgd2g06xc9wGjPpH?=
 =?us-ascii?Q?3/T8Pfo1m1sgHEoMJS3Q/EBB7vIsta0R6FEiBRAQEcf9mRpqK+TcrypO/XWF?=
 =?us-ascii?Q?AzKcl58efI1SshxMUDfGSy8A4OLZcD7j8jMtAbMZBZ56qBTu+5tmiA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(376014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2025 05:30:49.7321
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1237710a-2928-47f8-fcbe-08dd5d393881
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000A6732.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7624

Use pipe_buf() helper to retrieve the pipe buffer throughout the file
replacing the open-coded the logic.

Suggested-by: Oleg Nesterov <oleg@redhat.com>
Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
---
Changelog:

RFC v1..v2:

o New patch.
---
 fs/splice.c | 40 ++++++++++++++--------------------------
 1 file changed, 14 insertions(+), 26 deletions(-)

diff --git a/fs/splice.c b/fs/splice.c
index 23fa5561b944..90d464241f15 100644
--- a/fs/splice.c
+++ b/fs/splice.c
@@ -200,7 +200,6 @@ ssize_t splice_to_pipe(struct pipe_inode_info *pipe,
 	unsigned int spd_pages = spd->nr_pages;
 	unsigned int tail = pipe->tail;
 	unsigned int head = pipe->head;
-	unsigned int mask = pipe->ring_size - 1;
 	ssize_t ret = 0;
 	int page_nr = 0;
 
@@ -214,7 +213,7 @@ ssize_t splice_to_pipe(struct pipe_inode_info *pipe,
 	}
 
 	while (!pipe_full(head, tail, pipe->max_usage)) {
-		struct pipe_buffer *buf = &pipe->bufs[head & mask];
+		struct pipe_buffer *buf = pipe_buf(pipe, head);
 
 		buf->page = spd->pages[page_nr];
 		buf->offset = spd->partial[page_nr].offset;
@@ -247,7 +246,6 @@ ssize_t add_to_pipe(struct pipe_inode_info *pipe, struct pipe_buffer *buf)
 {
 	unsigned int head = pipe->head;
 	unsigned int tail = pipe->tail;
-	unsigned int mask = pipe->ring_size - 1;
 	int ret;
 
 	if (unlikely(!pipe->readers)) {
@@ -256,7 +254,7 @@ ssize_t add_to_pipe(struct pipe_inode_info *pipe, struct pipe_buffer *buf)
 	} else if (pipe_full(head, tail, pipe->max_usage)) {
 		ret = -EAGAIN;
 	} else {
-		pipe->bufs[head & mask] = *buf;
+		*pipe_buf(pipe, head) = *buf;
 		pipe->head = head + 1;
 		return buf->len;
 	}
@@ -447,11 +445,10 @@ static int splice_from_pipe_feed(struct pipe_inode_info *pipe, struct splice_des
 {
 	unsigned int head = pipe->head;
 	unsigned int tail = pipe->tail;
-	unsigned int mask = pipe->ring_size - 1;
 	int ret;
 
 	while (!pipe_empty(head, tail)) {
-		struct pipe_buffer *buf = &pipe->bufs[tail & mask];
+		struct pipe_buffer *buf = pipe_buf(pipe, tail);
 
 		sd->len = buf->len;
 		if (sd->len > sd->total_len)
@@ -495,8 +492,7 @@ static int splice_from_pipe_feed(struct pipe_inode_info *pipe, struct splice_des
 static inline bool eat_empty_buffer(struct pipe_inode_info *pipe)
 {
 	unsigned int tail = pipe->tail;
-	unsigned int mask = pipe->ring_size - 1;
-	struct pipe_buffer *buf = &pipe->bufs[tail & mask];
+	struct pipe_buffer *buf = pipe_buf(pipe, tail);
 
 	if (unlikely(!buf->len)) {
 		pipe_buf_release(pipe, buf);
@@ -690,7 +686,7 @@ iter_file_splice_write(struct pipe_inode_info *pipe, struct file *out,
 	while (sd.total_len) {
 		struct kiocb kiocb;
 		struct iov_iter from;
-		unsigned int head, tail, mask;
+		unsigned int head, tail;
 		size_t left;
 		int n;
 
@@ -711,12 +707,11 @@ iter_file_splice_write(struct pipe_inode_info *pipe, struct file *out,
 
 		head = pipe->head;
 		tail = pipe->tail;
-		mask = pipe->ring_size - 1;
 
 		/* build the vector */
 		left = sd.total_len;
 		for (n = 0; !pipe_empty(head, tail) && left && n < nbufs; tail++) {
-			struct pipe_buffer *buf = &pipe->bufs[tail & mask];
+			struct pipe_buffer *buf = pipe_buf(pipe, tail);
 			size_t this_len = buf->len;
 
 			/* zero-length bvecs are not supported, skip them */
@@ -752,7 +747,7 @@ iter_file_splice_write(struct pipe_inode_info *pipe, struct file *out,
 		/* dismiss the fully eaten buffers, adjust the partial one */
 		tail = pipe->tail;
 		while (ret) {
-			struct pipe_buffer *buf = &pipe->bufs[tail & mask];
+			struct pipe_buffer *buf = pipe_buf(pipe, tail);
 			if (ret >= buf->len) {
 				ret -= buf->len;
 				buf->len = 0;
@@ -809,7 +804,7 @@ ssize_t splice_to_socket(struct pipe_inode_info *pipe, struct file *out,
 	pipe_lock(pipe);
 
 	while (len > 0) {
-		unsigned int head, tail, mask, bc = 0;
+		unsigned int head, tail, bc = 0;
 		size_t remain = len;
 
 		/*
@@ -846,10 +841,9 @@ ssize_t splice_to_socket(struct pipe_inode_info *pipe, struct file *out,
 
 		head = pipe->head;
 		tail = pipe->tail;
-		mask = pipe->ring_size - 1;
 
 		while (!pipe_empty(head, tail)) {
-			struct pipe_buffer *buf = &pipe->bufs[tail & mask];
+			struct pipe_buffer *buf = pipe_buf(pipe, tail);
 			size_t seg;
 
 			if (!buf->len) {
@@ -894,7 +888,7 @@ ssize_t splice_to_socket(struct pipe_inode_info *pipe, struct file *out,
 		len -= ret;
 		tail = pipe->tail;
 		while (ret > 0) {
-			struct pipe_buffer *buf = &pipe->bufs[tail & mask];
+			struct pipe_buffer *buf = pipe_buf(pipe, tail);
 			size_t seg = min_t(size_t, ret, buf->len);
 
 			buf->offset += seg;
@@ -1725,7 +1719,6 @@ static int splice_pipe_to_pipe(struct pipe_inode_info *ipipe,
 	struct pipe_buffer *ibuf, *obuf;
 	unsigned int i_head, o_head;
 	unsigned int i_tail, o_tail;
-	unsigned int i_mask, o_mask;
 	int ret = 0;
 	bool input_wakeup = false;
 
@@ -1747,9 +1740,7 @@ static int splice_pipe_to_pipe(struct pipe_inode_info *ipipe,
 	pipe_double_lock(ipipe, opipe);
 
 	i_tail = ipipe->tail;
-	i_mask = ipipe->ring_size - 1;
 	o_head = opipe->head;
-	o_mask = opipe->ring_size - 1;
 
 	do {
 		size_t o_len;
@@ -1792,8 +1783,8 @@ static int splice_pipe_to_pipe(struct pipe_inode_info *ipipe,
 			goto retry;
 		}
 
-		ibuf = &ipipe->bufs[i_tail & i_mask];
-		obuf = &opipe->bufs[o_head & o_mask];
+		ibuf = pipe_buf(ipipe, i_tail);
+		obuf = pipe_buf(opipe, o_head);
 
 		if (len >= ibuf->len) {
 			/*
@@ -1862,7 +1853,6 @@ static ssize_t link_pipe(struct pipe_inode_info *ipipe,
 	struct pipe_buffer *ibuf, *obuf;
 	unsigned int i_head, o_head;
 	unsigned int i_tail, o_tail;
-	unsigned int i_mask, o_mask;
 	ssize_t ret = 0;
 
 	/*
@@ -1873,9 +1863,7 @@ static ssize_t link_pipe(struct pipe_inode_info *ipipe,
 	pipe_double_lock(ipipe, opipe);
 
 	i_tail = ipipe->tail;
-	i_mask = ipipe->ring_size - 1;
 	o_head = opipe->head;
-	o_mask = opipe->ring_size - 1;
 
 	do {
 		if (!opipe->readers) {
@@ -1896,8 +1884,8 @@ static ssize_t link_pipe(struct pipe_inode_info *ipipe,
 		    pipe_full(o_head, o_tail, opipe->max_usage))
 			break;
 
-		ibuf = &ipipe->bufs[i_tail & i_mask];
-		obuf = &opipe->bufs[o_head & o_mask];
+		ibuf = pipe_buf(ipipe, i_tail);
+		obuf = pipe_buf(opipe, o_head);
 
 		/*
 		 * Get a reference to this pipe buffer,
-- 
2.43.0


