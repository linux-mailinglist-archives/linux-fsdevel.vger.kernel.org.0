Return-Path: <linux-fsdevel+bounces-43344-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BEB0A549DF
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Mar 2025 12:47:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E66693AF387
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Mar 2025 11:43:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEE4C2063D7;
	Thu,  6 Mar 2025 11:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ko7NujTm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2077.outbound.protection.outlook.com [40.107.94.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23EFD20AF6C;
	Thu,  6 Mar 2025 11:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741261257; cv=fail; b=QwUSNjCEAqJ5I7etknrIwrN2lK4KEjPb9kMyJZTVNNveWC8dVZMCTlfE9cl/m2sFsVuG8h0h2il8uhW/8jdqjQfJyzDwkI7j/yY77bEV6BEyhYGTBcZke8fKMnc2Ny6jdapQ/z1P48de+VJIXD77VdP0FssSpa3qL2v8Zw5WhJg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741261257; c=relaxed/simple;
	bh=34f3ZiI5aiOkGW3ltTWKv+ScOS+x/r5HLbnWTisKowE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=J4XsLVGvTNN7V7l2ErwolPrrpfmCyQ6pumLJjUQ96rU8kiaQeCEiaJhJfgZUA7stjoL5EhgZMAZU0BaGNRzh4NIkk5imQLgVdp9NMGdaQXR8FVTaY2Ax3ti5nADjLvshSZUsES++5mVhvce0RjBDvaR7UOGN8QyhOUXHuhY5ulk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ko7NujTm; arc=fail smtp.client-ip=40.107.94.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LPlKUVx2PqfrKDuZSeuZc07kdXCrzZgWorQUjndWeXZlj9NO2/euLdx/KUmXDh0/bE+tSRvAiFGEdWqDKo7xOH8chO+JI6/eAqz4kRhcA/jrKf7cMID8JGtezr9T5+isZhUcKM9roUe5bRXZIko1joFvU4AWcyu0l/4GU32pMz9/T7BYEP0Zo1fIPUjlL4nkej0dfSzdoNsbaoO4kAISV2UDwGMVB90LLQGP7/wj9Tez5IcPlBKIs+NVDMfOIwAqktvUtVeH7tAntTg+v5Ozh/m4E6cGddkg8uc8+VDLot99pnan/GYfM0Dlgs4YuJuuvJqjNmYNBIP9MYocntr4fA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yWzYkgs+iTmA7ljf3vmtYL2QU3Kx0wKwUlGM4TzjI+o=;
 b=FI41KlssoLRAt53HHz6lAphV3UPgBX6YS28unQDwC6l5JFPP1JTLQGsmFIqU29eXWAeezEfk00Ud/Z/08HWjq/8P0RD7nDmykgUGZXMGVaU4jaf3+Lqb4S5J+46tnfJMSBThdvxWRkhmjavIcg5JnxmX4hXY0E1FTedhLXEO5R2kAXLbSArsRawpU/LDUH9ITxuVzvInyiQA8fOIWLAh2fq3hHU3dTRpcYxrF6bwLptizrjjCS5TGYCJRAduUcpQCuzyY49mi4Kge5FqKPGcYkqvWBFYv4tJrLS+P/Eh5MEey0ouCpmBIiEWrTBI187ZruoqFDM4MdrDrMEfc2LJMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linux-foundation.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yWzYkgs+iTmA7ljf3vmtYL2QU3Kx0wKwUlGM4TzjI+o=;
 b=ko7NujTmsOe02u4tXvX60KO0azKxrGmPcoyF+EbuPmL408RwkLEvk4zvZPx9UpD8QhGAuEuxkf4XFg3lR/dCbhtEktVzD1s1A32K20dbbRUBZcfpkIzNcNfgo+A8cKRSmZlnkBGxZo4KoTTOg4lFBkq2BUY1VTWenXcJmEawvyk=
Received: from DS7PR03CA0114.namprd03.prod.outlook.com (2603:10b6:5:3b7::29)
 by PH8PR12MB7135.namprd12.prod.outlook.com (2603:10b6:510:22c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.25; Thu, 6 Mar
 2025 11:40:45 +0000
Received: from CY4PEPF0000E9D8.namprd05.prod.outlook.com
 (2603:10b6:5:3b7:cafe::e3) by DS7PR03CA0114.outlook.office365.com
 (2603:10b6:5:3b7::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.16 via Frontend Transport; Thu,
 6 Mar 2025 11:40:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D8.mail.protection.outlook.com (10.167.241.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8511.15 via Frontend Transport; Thu, 6 Mar 2025 11:40:44 +0000
Received: from BLRKPRNAYAK.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 6 Mar
 2025 05:40:37 -0600
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
Subject: [RFC PATCH 3/3] treewide: pipe: Convert all references to pipe->{head,tail,max_usage,ring_size} to unsigned short
Date: Thu, 6 Mar 2025 11:39:24 +0000
Message-ID: <20250306113924.20004-4-kprateek.nayak@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D8:EE_|PH8PR12MB7135:EE_
X-MS-Office365-Filtering-Correlation-Id: e2bb570c-9619-45f3-0126-08dd5ca3baeb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|376014|36860700013|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?JBfInG+4LwF+sCA8FfcKj1Ta9XmXWjKnzsyDq5DfFGTqeyG9/4pgrUMHQKaB?=
 =?us-ascii?Q?H8QKNtMnOuOBksUsszJ2mcZIhzUMgVWaiUC4enaNRw2KVxyO0/TxlC6RouE+?=
 =?us-ascii?Q?IbBayX9Slfpy1aS7IdFH2Hy6dFWkpracg9NihRQ2CKHgVnt0EtFcqBSka5ny?=
 =?us-ascii?Q?fSaYCLVRH3IM4wN/KAiemr4wYxCAyhTJZZROnRb+cF9UkKeOqZ9VHLwAp3YE?=
 =?us-ascii?Q?3Rrg6miFTt1jXBL/oJQzjShNz2OqACktAvH7Mb4ycBq3VKmBZZXSr0Fq/gpJ?=
 =?us-ascii?Q?Be7kJi75BTjhXXAiMWMZc2uJ197+ZVKaAktImQVrSbkxwMpHuxR+vr7wWThV?=
 =?us-ascii?Q?WeD2EG5xN9eHDObb/aikS99AkdYoPPGCFaANYDtQOz0xzl1d/8zgdirSH9k2?=
 =?us-ascii?Q?a+Q5+6Q3YjhIMt/fpufyGDsXaOu4+1jfjdkbS2nGb2qO76YklFC3s8iFz8qw?=
 =?us-ascii?Q?/wdEsCqpb/Qm4qMf4kgOcLxQwhmJFhjwrNtdo/7/0vPBFgFR0wgNCp6aKmAQ?=
 =?us-ascii?Q?aB8HQKxp/ddV2OtPhJjKHIiO/iDlSd3g9oDVvsLcYZvbhBAfLqSioGdnMc6G?=
 =?us-ascii?Q?bYle3SiDi4GGqdhwVBqpNQrSb83ZTUiJoWYcb2Lv5gHroJ50UUpBlRVESzIV?=
 =?us-ascii?Q?2rliKOJGWAdx2n0P7yvTs2fqxRpMk4iKOMR6Czc9u87XQicQdkUTFF5M5jLx?=
 =?us-ascii?Q?Z67SZrkRZAT9xH2V+EROKpxMxhT7SekUmd6VRF4CFk7oY7ugGKnYy6fJcvRm?=
 =?us-ascii?Q?kQV0K6273GHxXk6cS0nl9yN8Tsq/1xJdTLWuxoyCtjKsvIQhLMlQK6nLGyKI?=
 =?us-ascii?Q?9thDzaaqvfsIlgL5C2OqfhRFqybmeruplzrw8+nqpoVWAHbdlX9/MaftrlS0?=
 =?us-ascii?Q?zos/5YJNzUykTnezLTlS0Ar1a8cLPWpwig3LjMtvjyA/SwMle6uE3nPFwEQM?=
 =?us-ascii?Q?jv99YCfST8JZIUlM558+UPhLyNVOwTwRUmkpre+kqHBSuEK7HhnL9ixtQVT4?=
 =?us-ascii?Q?e/4j4OpBLUkVyX7RUI9qoCNECpCX4DWXiUz8z1Wh78IC7TqcC3VP8LiqtACF?=
 =?us-ascii?Q?9c3gUvQnewEpXulzXM90Dt9H8U72LDkf9InVXrRI/EvrqKgc5wLs+sbl7ce+?=
 =?us-ascii?Q?WWHRG1v/lCNIY0pyKEwM1TJe4HioK6HgBuBDVewAxLc44iWipAPCe1phhbw+?=
 =?us-ascii?Q?Ybc4bSU09maFQMec9dIhQau5tP8L86I8v9hlitjPLZlMRmVCiTNta5dsY1+W?=
 =?us-ascii?Q?SpAzsdp8s4DtW/zFMNJpHMOZ0XRzVkcmcpKGdFmnlzZbD9p+UrntekgIHjcv?=
 =?us-ascii?Q?TZVIKfx3xrw+wkuKhJCame6xoQvITJkjnrblq4AsW0oz/Qr0SV+/A1safuV5?=
 =?us-ascii?Q?DAUtnHzVmFwN629aFjaxabEYUzFsIQ5NTLrBhxRZIWYbJPvd6lsK5E4HrXAr?=
 =?us-ascii?Q?dnBH6nMNhqBV5Gx+UPewb1agRhR12ozm2/b8JP49Fkoi3KWhOFrZzV3ygrPe?=
 =?us-ascii?Q?5uJoQAo4IIa6mmbMC2dM0XoqDW4S2a0CcCnB?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(376014)(36860700013)(1800799024)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2025 11:40:44.0147
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e2bb570c-9619-45f3-0126-08dd5ca3baeb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9D8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7135

Use 16-bit head and tail to track the pipe buffer production and
consumption.

Since "pipe->max_usage" and "pipe->ring_size" must fall between the head
and the tail limits, convert them to unsigned short as well to catch any
cases of unsigned arithmetic going wrong.

Part of fs/fuse/dev.c, fs/splice.c, mm/filemap.c, and mm/shmem.c were
touched to accommodate the "unsigned short" based calculations of
pipe_occupancy().

pipe->tail is incremented always with both "pipe->mutex" and
"pipe->rd_wait.lock" held for pipes with watch queue. pipe_write() exits
early if pipe has a watch queue but otherwise takes the "pipe->muxtex"
before updating pipe->head. post_one_notification() holds the
"pipe->rd_wait.lock" when updating pipe->head.

Updates to "pipe->head" and "pipe->tail" are always mutually exclusive,
either guarded by "pipe->mutex" or by "pipe->rd_wait.lock". Even a RMW
updates to the 16-bits fields should be safe because of those
synchronization primitives on architectures that cannot do an atomic
16-bit store.

Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
---
 fs/fuse/dev.c             |  7 +++---
 fs/pipe.c                 | 31 +++++++++++++-------------
 fs/splice.c               | 47 ++++++++++++++++++++-------------------
 include/linux/pipe_fs_i.h | 39 +++++++++++---------------------
 kernel/watch_queue.c      |  3 ++-
 mm/filemap.c              |  5 +++--
 mm/shmem.c                |  5 +++--
 7 files changed, 65 insertions(+), 72 deletions(-)

diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index 2b2d1b755544..993e6dc24de1 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -1440,6 +1440,7 @@ static ssize_t fuse_dev_splice_read(struct file *in, loff_t *ppos,
 	int page_nr = 0;
 	struct pipe_buffer *bufs;
 	struct fuse_copy_state cs;
+	unsigned short free_slots;
 	struct fuse_dev *fud = fuse_get_dev(in);
 
 	if (!fud)
@@ -1457,7 +1458,8 @@ static ssize_t fuse_dev_splice_read(struct file *in, loff_t *ppos,
 	if (ret < 0)
 		goto out;
 
-	if (pipe_occupancy(pipe->head, pipe->tail) + cs.nr_segs > pipe->max_usage) {
+	free_slots = pipe->max_usage - pipe_occupancy(pipe->head, pipe->tail);
+	if (free_slots < cs.nr_segs) {
 		ret = -EIO;
 		goto out;
 	}
@@ -2107,9 +2109,8 @@ static ssize_t fuse_dev_splice_write(struct pipe_inode_info *pipe,
 				     struct file *out, loff_t *ppos,
 				     size_t len, unsigned int flags)
 {
-	unsigned int head, tail, mask, count;
+	unsigned short head, tail, mask, count, idx;
 	unsigned nbuf;
-	unsigned idx;
 	struct pipe_buffer *bufs;
 	struct fuse_copy_state cs;
 	struct fuse_dev *fud;
diff --git a/fs/pipe.c b/fs/pipe.c
index 3ca3103e1de7..b8d87eabff79 100644
--- a/fs/pipe.c
+++ b/fs/pipe.c
@@ -216,9 +216,9 @@ static inline bool pipe_readable(const struct pipe_inode_info *pipe)
 	return !pipe_empty(idx.head, idx.tail) || !writers;
 }
 
-static inline unsigned int pipe_update_tail(struct pipe_inode_info *pipe,
-					    struct pipe_buffer *buf,
-					    unsigned int tail)
+static inline unsigned short pipe_update_tail(struct pipe_inode_info *pipe,
+					      struct pipe_buffer *buf,
+					      unsigned short tail)
 {
 	pipe_buf_release(pipe, buf);
 
@@ -272,9 +272,9 @@ pipe_read(struct kiocb *iocb, struct iov_iter *to)
 	 */
 	for (;;) {
 		/* Read ->head with a barrier vs post_one_notification() */
-		unsigned int head = smp_load_acquire(&pipe->head);
-		unsigned int tail = pipe->tail;
-		unsigned int mask = pipe->ring_size - 1;
+		unsigned short head = smp_load_acquire(&pipe->head);
+		unsigned short tail = pipe->tail;
+		unsigned short mask = pipe->ring_size - 1;
 
 #ifdef CONFIG_WATCH_QUEUE
 		if (pipe->note_loss) {
@@ -417,7 +417,7 @@ static inline int is_packetized(struct file *file)
 static inline bool pipe_writable(const struct pipe_inode_info *pipe)
 {
 	union pipe_index idx = { .head_tail = READ_ONCE(pipe->head_tail) };
-	unsigned int max_usage = READ_ONCE(pipe->max_usage);
+	unsigned short max_usage = READ_ONCE(pipe->max_usage);
 
 	return !pipe_full(idx.head, idx.tail, max_usage) ||
 		!READ_ONCE(pipe->readers);
@@ -428,7 +428,7 @@ pipe_write(struct kiocb *iocb, struct iov_iter *from)
 {
 	struct file *filp = iocb->ki_filp;
 	struct pipe_inode_info *pipe = filp->private_data;
-	unsigned int head;
+	unsigned short head;
 	ssize_t ret = 0;
 	size_t total_len = iov_iter_count(from);
 	ssize_t chars;
@@ -471,7 +471,7 @@ pipe_write(struct kiocb *iocb, struct iov_iter *from)
 	was_empty = pipe_empty(head, pipe->tail);
 	chars = total_len & (PAGE_SIZE-1);
 	if (chars && !was_empty) {
-		unsigned int mask = pipe->ring_size - 1;
+		unsigned short mask = pipe->ring_size - 1;
 		struct pipe_buffer *buf = &pipe->bufs[(head - 1) & mask];
 		int offset = buf->offset + buf->len;
 
@@ -614,7 +614,8 @@ pipe_write(struct kiocb *iocb, struct iov_iter *from)
 static long pipe_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 {
 	struct pipe_inode_info *pipe = filp->private_data;
-	unsigned int count, head, tail, mask;
+	unsigned short head, tail, mask;
+	unsigned int count;
 
 	switch (cmd) {
 	case FIONREAD:
@@ -1270,10 +1271,10 @@ unsigned int round_pipe_size(unsigned int size)
 int pipe_resize_ring(struct pipe_inode_info *pipe, unsigned int nr_slots)
 {
 	struct pipe_buffer *bufs;
-	unsigned int head, tail, mask, n;
+	unsigned short head, tail, mask, n;
 
 	/* nr_slots larger than limits of pipe->{head,tail} */
-	if (unlikely(nr_slots > BIT(BITS_PER_TYPE(pipe_index_t) - 1)))
+	if (unlikely(nr_slots > USHRT_MAX))
 		return -EINVAL;
 
 	bufs = kcalloc(nr_slots, sizeof(*bufs),
@@ -1298,13 +1299,13 @@ int pipe_resize_ring(struct pipe_inode_info *pipe, unsigned int nr_slots)
 	 * and adjust the indices.
 	 */
 	if (n > 0) {
-		unsigned int h = head & mask;
-		unsigned int t = tail & mask;
+		unsigned short h = head & mask;
+		unsigned short t = tail & mask;
 		if (h > t) {
 			memcpy(bufs, pipe->bufs + t,
 			       n * sizeof(struct pipe_buffer));
 		} else {
-			unsigned int tsize = pipe->ring_size - t;
+			unsigned short tsize = pipe->ring_size - t;
 			if (h > 0)
 				memcpy(bufs + tsize, pipe->bufs,
 				       h * sizeof(struct pipe_buffer));
diff --git a/fs/splice.c b/fs/splice.c
index e51f33aca032..891a7cf9fb55 100644
--- a/fs/splice.c
+++ b/fs/splice.c
@@ -198,9 +198,9 @@ ssize_t splice_to_pipe(struct pipe_inode_info *pipe,
 		       struct splice_pipe_desc *spd)
 {
 	unsigned int spd_pages = spd->nr_pages;
-	unsigned int tail = pipe->tail;
-	unsigned int head = pipe->head;
-	unsigned int mask = pipe->ring_size - 1;
+	unsigned short tail = pipe->tail;
+	unsigned short head = pipe->head;
+	unsigned short mask = pipe->ring_size - 1;
 	ssize_t ret = 0;
 	int page_nr = 0;
 
@@ -245,9 +245,9 @@ EXPORT_SYMBOL_GPL(splice_to_pipe);
 
 ssize_t add_to_pipe(struct pipe_inode_info *pipe, struct pipe_buffer *buf)
 {
-	unsigned int head = pipe->head;
-	unsigned int tail = pipe->tail;
-	unsigned int mask = pipe->ring_size - 1;
+	unsigned short head = pipe->head;
+	unsigned short tail = pipe->tail;
+	unsigned short mask = pipe->ring_size - 1;
 	int ret;
 
 	if (unlikely(!pipe->readers)) {
@@ -271,7 +271,7 @@ EXPORT_SYMBOL(add_to_pipe);
  */
 int splice_grow_spd(const struct pipe_inode_info *pipe, struct splice_pipe_desc *spd)
 {
-	unsigned int max_usage = READ_ONCE(pipe->max_usage);
+	unsigned short max_usage = READ_ONCE(pipe->max_usage);
 
 	spd->nr_pages_max = max_usage;
 	if (max_usage <= PIPE_DEF_BUFFERS)
@@ -327,12 +327,13 @@ ssize_t copy_splice_read(struct file *in, loff_t *ppos,
 	struct kiocb kiocb;
 	struct page **pages;
 	ssize_t ret;
-	size_t used, npages, chunk, remain, keep = 0;
+	size_t npages, chunk, remain, keep = 0;
+	unsigned short used;
 	int i;
 
 	/* Work out how much data we can actually add into the pipe */
 	used = pipe_occupancy(pipe->head, pipe->tail);
-	npages = max_t(ssize_t, pipe->max_usage - used, 0);
+	npages = max_t(unsigned short, pipe->max_usage - used, 0);
 	len = min_t(size_t, len, npages * PAGE_SIZE);
 	npages = DIV_ROUND_UP(len, PAGE_SIZE);
 
@@ -445,9 +446,9 @@ static void wakeup_pipe_writers(struct pipe_inode_info *pipe)
 static int splice_from_pipe_feed(struct pipe_inode_info *pipe, struct splice_desc *sd,
 			  splice_actor *actor)
 {
-	unsigned int head = pipe->head;
-	unsigned int tail = pipe->tail;
-	unsigned int mask = pipe->ring_size - 1;
+	unsigned short head = pipe->head;
+	unsigned short tail = pipe->tail;
+	unsigned short mask = pipe->ring_size - 1;
 	int ret;
 
 	while (!pipe_empty(head, tail)) {
@@ -494,8 +495,8 @@ static int splice_from_pipe_feed(struct pipe_inode_info *pipe, struct splice_des
 /* We know we have a pipe buffer, but maybe it's empty? */
 static inline bool eat_empty_buffer(struct pipe_inode_info *pipe)
 {
-	unsigned int tail = pipe->tail;
-	unsigned int mask = pipe->ring_size - 1;
+	unsigned short tail = pipe->tail;
+	unsigned short mask = pipe->ring_size - 1;
 	struct pipe_buffer *buf = &pipe->bufs[tail & mask];
 
 	if (unlikely(!buf->len)) {
@@ -690,7 +691,7 @@ iter_file_splice_write(struct pipe_inode_info *pipe, struct file *out,
 	while (sd.total_len) {
 		struct kiocb kiocb;
 		struct iov_iter from;
-		unsigned int head, tail, mask;
+		unsigned short head, tail, mask;
 		size_t left;
 		int n;
 
@@ -809,7 +810,7 @@ ssize_t splice_to_socket(struct pipe_inode_info *pipe, struct file *out,
 	pipe_lock(pipe);
 
 	while (len > 0) {
-		unsigned int head, tail, mask, bc = 0;
+		unsigned short head, tail, mask, bc = 0;
 		size_t remain = len;
 
 		/*
@@ -960,7 +961,7 @@ static ssize_t do_splice_read(struct file *in, loff_t *ppos,
 			      struct pipe_inode_info *pipe, size_t len,
 			      unsigned int flags)
 {
-	unsigned int p_space;
+	unsigned short p_space;
 
 	if (unlikely(!(in->f_mode & FMODE_READ)))
 		return -EBADF;
@@ -1724,9 +1725,9 @@ static int splice_pipe_to_pipe(struct pipe_inode_info *ipipe,
 			       size_t len, unsigned int flags)
 {
 	struct pipe_buffer *ibuf, *obuf;
-	unsigned int i_head, o_head;
-	unsigned int i_tail, o_tail;
-	unsigned int i_mask, o_mask;
+	unsigned short i_head, o_head;
+	unsigned short i_tail, o_tail;
+	unsigned short i_mask, o_mask;
 	int ret = 0;
 	bool input_wakeup = false;
 
@@ -1861,9 +1862,9 @@ static ssize_t link_pipe(struct pipe_inode_info *ipipe,
 			 size_t len, unsigned int flags)
 {
 	struct pipe_buffer *ibuf, *obuf;
-	unsigned int i_head, o_head;
-	unsigned int i_tail, o_tail;
-	unsigned int i_mask, o_mask;
+	unsigned short i_head, o_head;
+	unsigned short i_tail, o_tail;
+	unsigned short i_mask, o_mask;
 	ssize_t ret = 0;
 
 	/*
diff --git a/include/linux/pipe_fs_i.h b/include/linux/pipe_fs_i.h
index e572e6fc4f81..0997c028548c 100644
--- a/include/linux/pipe_fs_i.h
+++ b/include/linux/pipe_fs_i.h
@@ -31,19 +31,6 @@ struct pipe_buffer {
 	unsigned long private;
 };
 
-/*
- * Really only alpha needs 32-bit fields, but
- * might as well do it for 64-bit architectures
- * since that's what we've historically done,
- * and it makes 'head_tail' always be a simple
- * 'unsigned long'.
- */
-#ifdef CONFIG_64BIT
-typedef unsigned int pipe_index_t;
-#else
-typedef unsigned short pipe_index_t;
-#endif
-
 /*
  * We have to declare this outside 'struct pipe_inode_info',
  * but then we can't use 'union pipe_index' for an anonymous
@@ -51,10 +38,10 @@ typedef unsigned short pipe_index_t;
  * below. Annoying.
  */
 union pipe_index {
-	unsigned long head_tail;
+	unsigned int head_tail;
 	struct {
-		pipe_index_t head;
-		pipe_index_t tail;
+		unsigned short head;
+		unsigned short tail;
 	};
 };
 
@@ -89,15 +76,15 @@ struct pipe_inode_info {
 
 	/* This has to match the 'union pipe_index' above */
 	union {
-		unsigned long head_tail;
+		unsigned int head_tail;
 		struct {
-			pipe_index_t head;
-			pipe_index_t tail;
+			unsigned short head;
+			unsigned short tail;
 		};
 	};
 
-	unsigned int max_usage;
-	unsigned int ring_size;
+	unsigned short max_usage;
+	unsigned short ring_size;
 	unsigned int nr_accounted;
 	unsigned int readers;
 	unsigned int writers;
@@ -181,7 +168,7 @@ static inline bool pipe_has_watch_queue(const struct pipe_inode_info *pipe)
  * @head: The pipe ring head pointer
  * @tail: The pipe ring tail pointer
  */
-static inline bool pipe_empty(unsigned int head, unsigned int tail)
+static inline bool pipe_empty(unsigned short head, unsigned short tail)
 {
 	return head == tail;
 }
@@ -191,9 +178,9 @@ static inline bool pipe_empty(unsigned int head, unsigned int tail)
  * @head: The pipe ring head pointer
  * @tail: The pipe ring tail pointer
  */
-static inline unsigned int pipe_occupancy(unsigned int head, unsigned int tail)
+static inline unsigned short pipe_occupancy(unsigned short head, unsigned short tail)
 {
-	return (pipe_index_t)(head - tail);
+	return head - tail;
 }
 
 /**
@@ -202,8 +189,8 @@ static inline unsigned int pipe_occupancy(unsigned int head, unsigned int tail)
  * @tail: The pipe ring tail pointer
  * @limit: The maximum amount of slots available.
  */
-static inline bool pipe_full(unsigned int head, unsigned int tail,
-			     unsigned int limit)
+static inline bool pipe_full(unsigned short head, unsigned short tail,
+			     unsigned short limit)
 {
 	return pipe_occupancy(head, tail) >= limit;
 }
diff --git a/kernel/watch_queue.c b/kernel/watch_queue.c
index 5267adeaa403..c76cfebf46c8 100644
--- a/kernel/watch_queue.c
+++ b/kernel/watch_queue.c
@@ -101,7 +101,8 @@ static bool post_one_notification(struct watch_queue *wqueue,
 	struct pipe_inode_info *pipe = wqueue->pipe;
 	struct pipe_buffer *buf;
 	struct page *page;
-	unsigned int head, tail, mask, note, offset, len;
+	unsigned short head, tail, mask;
+	unsigned int note, offset, len;
 	bool done = false;
 
 	spin_lock_irq(&pipe->rd_wait.lock);
diff --git a/mm/filemap.c b/mm/filemap.c
index d4564a79eb35..6007b2403471 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2943,9 +2943,10 @@ ssize_t filemap_splice_read(struct file *in, loff_t *ppos,
 {
 	struct folio_batch fbatch;
 	struct kiocb iocb;
-	size_t total_spliced = 0, used, npages;
+	size_t total_spliced = 0, npages;
 	loff_t isize, end_offset;
 	bool writably_mapped;
+	unsigned short used;
 	int i, error = 0;
 
 	if (unlikely(*ppos >= in->f_mapping->host->i_sb->s_maxbytes))
@@ -2956,7 +2957,7 @@ ssize_t filemap_splice_read(struct file *in, loff_t *ppos,
 
 	/* Work out how much data we can actually add into the pipe */
 	used = pipe_occupancy(pipe->head, pipe->tail);
-	npages = max_t(ssize_t, pipe->max_usage - used, 0);
+	npages = max_t(unsigned short, pipe->max_usage - used, 0);
 	len = min_t(size_t, len, npages * PAGE_SIZE);
 
 	folio_batch_init(&fbatch);
diff --git a/mm/shmem.c b/mm/shmem.c
index 4ea6109a8043..339084e5a8a1 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -3509,13 +3509,14 @@ static ssize_t shmem_file_splice_read(struct file *in, loff_t *ppos,
 	struct inode *inode = file_inode(in);
 	struct address_space *mapping = inode->i_mapping;
 	struct folio *folio = NULL;
-	size_t total_spliced = 0, used, npages, n, part;
+	size_t total_spliced = 0, npages, n, part;
+	unsigned short used;
 	loff_t isize;
 	int error = 0;
 
 	/* Work out how much data we can actually add into the pipe */
 	used = pipe_occupancy(pipe->head, pipe->tail);
-	npages = max_t(ssize_t, pipe->max_usage - used, 0);
+	npages = max_t(unsigned short, pipe->max_usage - used, 0);
 	len = min_t(size_t, len, npages * PAGE_SIZE);
 
 	do {
-- 
2.43.0


