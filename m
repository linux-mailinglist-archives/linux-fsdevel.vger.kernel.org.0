Return-Path: <linux-fsdevel+bounces-43405-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 87167A56007
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Mar 2025 06:30:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD0B11895F82
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Mar 2025 05:31:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65AAF194A6C;
	Fri,  7 Mar 2025 05:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="hEV8g9Sj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2050.outbound.protection.outlook.com [40.107.92.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A71E18A95A;
	Fri,  7 Mar 2025 05:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741325439; cv=fail; b=bC8m4NW6xx38gObhc6E3iq/bTj2KCSArhLO6c4wBHvlM4qUe7SE0Mqryf2ZjrXuOTF7YNwJQ4etS4MX960wO/p4qG3x9Ci/5DmDXPKajKkjvFIqdeTE5X61oaVp7OP31hD+0oU/l8K7bRJC+Tc4g3A9M4NGfwd6mVhV5wURziRs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741325439; c=relaxed/simple;
	bh=Q73WcTB2+VlRXzqa7ev84/LZi527mPNM2QyejGvA3+4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QId27ap56DdOCntPrD5GRWs5ZNcUhc1drHc5C25afc6Dm0vF3KSf/cBkVlbeljPvAo72kGcKqN2025Iy9G5n+V9rYETdaKRA7l63oi8CbgfdYmvUhokFzR6xH4EYPSPVCKid+Bc3gGQ/C5Ot8JwFMMPzaNrwk2OCFooXDc1rGKw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=hEV8g9Sj; arc=fail smtp.client-ip=40.107.92.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hUX82IsCWkEAnEMdBoImhHYIU6JyzTlNTJuEmVKoP3fVtrZTk6vycZ7iq5CV2YNJvlZT2TiqM8sj1pvCMVDTT+wOgxBJm6wYBwyxxrkabklkeJZDL8/qD8eLhkLTs/8GrUFHA1aOiNEtfQXEigN7tg4W2zhmrBm/ViGknxuAvuiFCoa5EA8ChpIX7YHb8ufqkgtizBvde+raGSvoOes+SMOxv8bBlZXNWyT6Oe0+ugyCUSepje3mSL6+KVGZufyQAuhS/941noDCUE5yfaMQGHioKHFLnN9yxxr5VMFJhTCBOxEAkPBNxwKSsm7ilE6zZA233ZDWRrwmdXZ3TtcUww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4VfVGspq/P3N40fr9urCp2EonRGH1D/vz4xu2onNWug=;
 b=SPCtSOyAMrU9+SzdI4bqPf4a9fNj4mVKDAden/ptkEuVhAbQ2Ac3psfVoNRsGB/phhmEO1L80TFB/XrtqYu+/ZDJ5fb4s7cPwt4Ssz73QxttR0haon2eB1lNTkWrD5+snFpoH2SIYISg3o2m3XFFE8bUL8EEMeeMkGDm2MIoTY4lOlwRnafngrujI3ENTOWGLI5dz9szcJx0YoftspTKB0dr9i88KLBucAFO7Lc9k2xvEoGVD9sLSH5qL202S+LOf1tSQm9Q2a0GIke2C9IkUXu2k48JmZ7jPZwU0IQhw9GCB5oo8Pq/qw8dD160qwkyuAFlXtv/uBwV8K79peQauA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linux-foundation.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4VfVGspq/P3N40fr9urCp2EonRGH1D/vz4xu2onNWug=;
 b=hEV8g9SjYpiv+G2hoDQdW/pdYyOvr1IOeuqzk8AJqOq1vmldbpX1lQhO6PBRDCjYydxJY/f2jKtx7cRtiFsSCtirVeGOXDeSqDk08fGIaNWYO1qRSiQz2EQZt19XU8kl7m9u4TFNNzlgY9ZV1fuGV7iew8aV4NdyuVEwnWsLCnM=
Received: from MW4PR04CA0325.namprd04.prod.outlook.com (2603:10b6:303:82::30)
 by IA0PR12MB7649.namprd12.prod.outlook.com (2603:10b6:208:437::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.19; Fri, 7 Mar
 2025 05:30:31 +0000
Received: from MWH0EPF000A672F.namprd04.prod.outlook.com
 (2603:10b6:303:82:cafe::30) by MW4PR04CA0325.outlook.office365.com
 (2603:10b6:303:82::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.19 via Frontend Transport; Fri,
 7 Mar 2025 05:30:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000A672F.mail.protection.outlook.com (10.167.249.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8511.15 via Frontend Transport; Fri, 7 Mar 2025 05:30:31 +0000
Received: from BLRKPRNAYAK.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 6 Mar
 2025 23:30:26 -0600
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
Subject: [PATCH v2 3/4] fs/pipe: Use pipe_buf() helper to retrieve pipe buffer
Date: Fri, 7 Mar 2025 05:29:18 +0000
Message-ID: <20250307052919.34542-4-kprateek.nayak@amd.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000A672F:EE_|IA0PR12MB7649:EE_
X-MS-Office365-Filtering-Correlation-Id: 202d39c6-833a-4a06-4771-08dd5d392da6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?JzwlEVZH8MPXplRF6mE1H7n63I4/DGIWxLJye01myOlVcjZcnRzXgPHE9aD1?=
 =?us-ascii?Q?VP0Vaq8NM+XlKSNBtFxN6GCTpFdGj7gDe4SGLFVWpcHwbobR7iBNo5f/eTDb?=
 =?us-ascii?Q?pn2yC0VXunQptVW6wc129H99+nUFQXCY/YpVPrS0EfQ3l3UkY7yHhdeI/fTm?=
 =?us-ascii?Q?432cBFeMNIiQSyqjg/C3+fH5YJI/3nbne7oAUr3Bofbpl6C4XQWKyKJh9A+T?=
 =?us-ascii?Q?OERg75JxApGHZRVPbSNcbWBubsxMZYsjlG38bHYWlYUt5RoLW3EIQOn+VRgB?=
 =?us-ascii?Q?F8T6ZPIdrUtky8nD9xKQyccM527xmmP0HlITUmhe9MJQg0hmNvugjsyQR9WR?=
 =?us-ascii?Q?12wMT+TX+H2e5GWslIQhPur2mt5MvPgukOOCpPy5AQuF8t65XUg6nRd1FYt5?=
 =?us-ascii?Q?uxpvx2RM50NreQTN6ipbJ9YKOGqz469PrEQsAhuECPLdCpJ3XedbNZNb6D8M?=
 =?us-ascii?Q?DYJtbXOBq7CtmFEqxjPjdCUkd5f2nC71fxAQti+9T7yuj3XNvJvgSXyLBjjK?=
 =?us-ascii?Q?uZ4RLVlTkDtE5ham8eQLoznibvJzfrRLDRVpve1lmj1M5+vr6XLTU/Q/zKXH?=
 =?us-ascii?Q?MFG/0Ix9Zcze4TuKsrfuOuCcjvfhwPvyCBa0vtK9ykLuM3m/l/7NU4kRpstO?=
 =?us-ascii?Q?3/Cy1ho5+dPypqL/rXdLZayNKiwHx7ZZNYXXbiKcG+qjjSJnCffT7rd/Sg55?=
 =?us-ascii?Q?pRy7mE6/snaQnpplCIO/Zla/goB3QM0r9NLczXWln5B+ZCijm/9yyl7O29Zx?=
 =?us-ascii?Q?WGlSjPadkhET0/KfYgK5GRzBbMcndcdDTLIwCygnhwpzoHu90sjRkpxm8c/1?=
 =?us-ascii?Q?J1+6O53dGX0ecYelSpTlSwn3qa5/Uj1loju9rSqzqnuBN9YBuGXWaQ3/HPVi?=
 =?us-ascii?Q?5usAANDK58YbSmvSjdJx9MnyjAOINfrGp97bopPjFPpPMxsLFPANDc3WMZdn?=
 =?us-ascii?Q?vYfPl2aNH0KEAGWP3fYQ5nyFfmy+B0jGR9EI1z7oXlyCViDQdFoj85BX034G?=
 =?us-ascii?Q?GgOym+J3ego9pozqNC6HYgo23od1Rs48ROrG7+hO4Buym2OdJSpwFnf1Df29?=
 =?us-ascii?Q?AZfDNRkVKAvrAbOSpaWXTHF4bgjqAMC0i4wX9lyy4VTw99P2BZE24FK2q4Ob?=
 =?us-ascii?Q?cw5xHoiItfAdvJiuYoPBeoFo/scPYzCvQXo4D+5FDyAmYEJHjYfq3oDX+5kE?=
 =?us-ascii?Q?3R0Ztvanyu2dBjF7jp26Df1CdHv0ycc9AyFzxTrCP1/9kKFxyq/ELdS0R7z/?=
 =?us-ascii?Q?IAnBT38roppLt4jOMwgStlTc3r0VNvA+Dxk4b50/NvbrRfSrgDvHXjXcRylr?=
 =?us-ascii?Q?N3reMLkZiezjExSMQQgRWtwe5AD4J/pBEWqM+8aa97kD1ZoZEOMiN0t5oPQq?=
 =?us-ascii?Q?ZrbvvFmpNqi4F8GnRJEwXn0nLxv2rXI034OwtMCg3HtcUu/rfNJM3TCfpSUB?=
 =?us-ascii?Q?VzBeIzPMk2Zk+Dk43hO0kr6GCnxueZvAD3XvME/XvSamAHzKcKGI/JatavYY?=
 =?us-ascii?Q?GQImbykU5pzvLDg=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2025 05:30:31.5306
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 202d39c6-833a-4a06-4771-08dd5d392da6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000A672F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7649

Use pipe_buf() helper to retrieve the pipe buffer throughout the file
replacing the open-coded the logic.

Suggested-by: Oleg Nesterov <oleg@redhat.com>
Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
---
Changelog:

RFC v1..v2:

o New patch.
---
 fs/pipe.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/fs/pipe.c b/fs/pipe.c
index 88e81f84e3ea..4d6ca0f892b1 100644
--- a/fs/pipe.c
+++ b/fs/pipe.c
@@ -274,7 +274,6 @@ pipe_read(struct kiocb *iocb, struct iov_iter *to)
 		/* Read ->head with a barrier vs post_one_notification() */
 		unsigned int head = smp_load_acquire(&pipe->head);
 		unsigned int tail = pipe->tail;
-		unsigned int mask = pipe->ring_size - 1;
 
 #ifdef CONFIG_WATCH_QUEUE
 		if (pipe->note_loss) {
@@ -301,7 +300,7 @@ pipe_read(struct kiocb *iocb, struct iov_iter *to)
 #endif
 
 		if (!pipe_empty(head, tail)) {
-			struct pipe_buffer *buf = &pipe->bufs[tail & mask];
+			struct pipe_buffer *buf = pipe_buf(pipe, tail);
 			size_t chars = buf->len;
 			size_t written;
 			int error;
@@ -471,8 +470,7 @@ pipe_write(struct kiocb *iocb, struct iov_iter *from)
 	was_empty = pipe_empty(head, pipe->tail);
 	chars = total_len & (PAGE_SIZE-1);
 	if (chars && !was_empty) {
-		unsigned int mask = pipe->ring_size - 1;
-		struct pipe_buffer *buf = &pipe->bufs[(head - 1) & mask];
+		struct pipe_buffer *buf = pipe_buf(pipe, head - 1);
 		int offset = buf->offset + buf->len;
 
 		if ((buf->flags & PIPE_BUF_FLAG_CAN_MERGE) &&
@@ -503,7 +501,6 @@ pipe_write(struct kiocb *iocb, struct iov_iter *from)
 
 		head = pipe->head;
 		if (!pipe_full(head, pipe->tail, pipe->max_usage)) {
-			unsigned int mask = pipe->ring_size - 1;
 			struct pipe_buffer *buf;
 			struct page *page = pipe->tmp_page;
 			int copied;
@@ -525,7 +522,7 @@ pipe_write(struct kiocb *iocb, struct iov_iter *from)
 			pipe->head = head + 1;
 
 			/* Insert it into the buffer array */
-			buf = &pipe->bufs[head & mask];
+			buf = pipe_buf(pipe, head);
 			buf->page = page;
 			buf->ops = &anon_pipe_buf_ops;
 			buf->offset = 0;
-- 
2.43.0


