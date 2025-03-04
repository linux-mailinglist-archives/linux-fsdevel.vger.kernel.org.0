Return-Path: <linux-fsdevel+bounces-43106-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E763FA4DFBF
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Mar 2025 14:52:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8BE963A532A
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Mar 2025 13:52:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E85E32046B3;
	Tue,  4 Mar 2025 13:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="sFD9/S8j"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2072.outbound.protection.outlook.com [40.107.93.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DB20201267;
	Tue,  4 Mar 2025 13:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741096331; cv=fail; b=spNNSGPxYQ4Kse3KhTV+HYRANEUonhETdQT6KO1TTLTuL74stkxvLJGcLcFtvpnqOwsptGrO6w7IfMuNsR3a4gVHY/RZ/1BX2t17XkYH4gis6ZaujpcHMYJSpqa5HkkHIBzSyLVfDKSdC3Mq8G8r19yTS+5V81Fz8IPJkNqfIOE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741096331; c=relaxed/simple;
	bh=Yt+E62jsgx35P7X+Nhb8q+GPHOXr0d3vb8Npk5jB9so=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bzWL0pG1seeC8UG5TpofF03B/TNJBJmefB6BtU0aLOiFU/REhARGt/usHqbfn3lTDsYbm5uXhMCIizHSyAcyf3J3xqlpRBAdwj3uDPIwDnyiTkOcj2AkMPIrfeuyApIGFdeZgiw4TOOz6bXI8pvGeXnUBBKzpxP34Sbo33O2wOY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=sFD9/S8j; arc=fail smtp.client-ip=40.107.93.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uskJlUZFra8kGcp+KBGVegTaz/Q7T6t9Or70CGi5Fx+3nYB0lTvwn4D+3f1QOqJ82Tmw/9WfKjPLvRFhuEqLPuwlu8BU4+RSHqNnZwUxljxE5aCY+qBxq+aBPjVqKmk424r1dUIhEvtNWQI/LoefXojcuaMv6uHn0yUxf9mPh9WCpzbulK3Sa10m7lmRCJL2rEJOU8OZo72UidSmeZq6JLi9xUScHKEyeWMkgc1mQePLfRnbpslxj6ckHhPvqZpYPqUHOzoVC6zc5fZyRYXGvFf7GAxsG18bNAOQoAfPWIL3gn5nOlutLf2tD6prJi6X0ZwVBeAa3R+ZTboWj54x9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r6S71u7Un9B3fE2RhAbsnE0BT4ziJ7nsdyWmLNk9ktg=;
 b=RNAIC9uarsmYePQmze5FXbfqZBUDuPMtiURx78JpIAYHAsSZZgSeyLsNNulYsB9MrsDX2VeId80zigajgElu3hW/ftCvNOsFla5n4IhB4FmhMEHaXe98dYd0K/PO7LexnKEqFh/7mEXm7B2iRtMGHVIq8CoiSGohtQmBf/iObXkIduno+i2bJZIh3ritbN9giB6YRVQmxV5JmMf9LqS/wBGpjFlMIJlPF8EzqmZgDIrAiFwuU4tWCQNeIQgAWHakiS2hQ/GWQNQYpreCubbG4wfiq7VvKDyXivQXURA0UBzW+VJUuizThIB1OLjdwiat19sK5Rb32odDhpa1zXBlrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=zeniv.linux.org.uk smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r6S71u7Un9B3fE2RhAbsnE0BT4ziJ7nsdyWmLNk9ktg=;
 b=sFD9/S8jiwXRFxF4/SbmuKH5/pyBjP/WVsq/chzq8r2dsRLXFSW3q8/bbPBwTNlOjDukOBc5ECDMpBqHxACnIq6RjtN7LoyGQZSWV0ZAGZlnXqJymNWEElkqn+H8h3ZuLgAM/xuxW80hmIU5k5mWbNoK9t2bW+uiR0Obui6uJBk=
Received: from CH0PR13CA0015.namprd13.prod.outlook.com (2603:10b6:610:b1::20)
 by SA3PR12MB7973.namprd12.prod.outlook.com (2603:10b6:806:305::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.25; Tue, 4 Mar
 2025 13:52:04 +0000
Received: from CH2PEPF00000099.namprd02.prod.outlook.com
 (2603:10b6:610:b1:cafe::a2) by CH0PR13CA0015.outlook.office365.com
 (2603:10b6:610:b1::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.16 via Frontend Transport; Tue,
 4 Mar 2025 13:52:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF00000099.mail.protection.outlook.com (10.167.244.20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8511.15 via Frontend Transport; Tue, 4 Mar 2025 13:52:04 +0000
Received: from BLRKPRNAYAK.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 4 Mar
 2025 07:51:53 -0600
From: K Prateek Nayak <kprateek.nayak@amd.com>
To: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner
	<brauner@kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, "Oleg
 Nesterov" <oleg@redhat.com>, Swapnil Sapkal <swapnil.sapkal@amd.com>, "Alexey
 Gladkov" <legion@kernel.org>, <linux-fsdevel@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: Jan Kara <jack@suse.cz>, Mateusz Guzik <mjguzik@gmail.com>, Manfred Spraul
	<manfred@colorfullife.com>, David Howells <dhowells@redhat.com>, WangYuli
	<wangyuli@uniontech.com>, Hillf Danton <hdanton@sina.com>, "Gautham R.
 Shenoy" <gautham.shenoy@amd.com>, <Neeraj.Upadhyay@amd.com>,
	<Ananth.narayan@amd.com>, K Prateek Nayak <kprateek.nayak@amd.com>
Subject: [PATCH] fs/pipe: Read pipe->{head,tail} atomically outside pipe->mutex
Date: Tue, 4 Mar 2025 13:51:38 +0000
Message-ID: <20250304135138.1278-1-kprateek.nayak@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <CAHk-=wiA-7pdaQm2nV0iv-fihyhWX-=KjZwQTHNKoDqid46F0w@mail.gmail.com>
References: <CAHk-=wiA-7pdaQm2nV0iv-fihyhWX-=KjZwQTHNKoDqid46F0w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000099:EE_|SA3PR12MB7973:EE_
X-MS-Office365-Filtering-Correlation-Id: 32a403bb-baec-4041-c6af-08dd5b23bf3a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|36860700013|1800799024|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?7ic41XRfxxjp3rOedjdzOdhgbu4dGLds87Bxz9c+QhiPAaBOiswLi1IRTjyw?=
 =?us-ascii?Q?ghizCCWgmyUGm0uowjBM+mY5WAdfjsPv2yjJBAhCfupyWomzF8rUnU8WWWhS?=
 =?us-ascii?Q?g5FmQHPVeRWREoqQc4ygAWOmWVPCbktAyicIS8UE1rwYTCOeDbMZyLVevkwH?=
 =?us-ascii?Q?vNjjX8mpfDvj8e9Sn79geirjG6G1b11CF/sLJDBfJb2EPGYaGDFhA1SunPBF?=
 =?us-ascii?Q?SUU9AdmTcIYWtQlosAsBczLeXhFLu2rC0jgW1mKMcHegP0RdBhzGbSTNXsnR?=
 =?us-ascii?Q?0tB5A28rRCmhEZ4TlyYXFlU+h7FuyyRGeYHCzVaOkuDuxFyspAGGH1y+K/AT?=
 =?us-ascii?Q?cY7GKYdV1PGyB0KRrgAjDrf8BYsZgb0YasvKiVI9ITlT7bwOxUi1pbuqfvD2?=
 =?us-ascii?Q?f5tugqojfzqRfcdOWb3cncLyTpbxpcXqDExU0J9kQbelWykO8LRue+R9Dt+c?=
 =?us-ascii?Q?y41t1siDUo5HBXnA/O9MfZ6Fl3R5e7OmGFCAX4Srsgyd2yzYd9nXxJ2haWZa?=
 =?us-ascii?Q?u2SYrcG78pBHzsoZFHLb934TaTgQ09RpPnaC1yJ4m1weO5cyPr5CCYiS/g5F?=
 =?us-ascii?Q?mMr33kooX/ZzvV+4JaL7laIbp6+WcGk41/y67E2wqs2schov8syfrU1scWje?=
 =?us-ascii?Q?3HoaIfHxYBwmTOp5mrbf+A5+f6VMfYWJtfBGbyDd7iGLCfjU8WXFjK1JOVHb?=
 =?us-ascii?Q?ZXoG3HuyACvNgkUQZobNxgrFuTUYlrZUif8j7eCVtUJbz2ojA68Rdyryor+G?=
 =?us-ascii?Q?LIH5FWgJGFHtxdRmHa0aC/2mxhZxLzW738kAQsuCZ7ZzLDeEIYC6YBLTjgaL?=
 =?us-ascii?Q?YJm/xW1ScDnRRhVroA6j/W92Ov3WYHthrq1+GKhFEu9aOhQImu9dZggWZPVD?=
 =?us-ascii?Q?n67hCLy7zK31iuElEoghR2+sv0FGDzDJFS58WODbwIxru5iYKaEnxARRLS+t?=
 =?us-ascii?Q?Bwa+VOYYouHmhTl9zBiq5PWYOkUVrz/rDDqJUDbgJzBCwFkLX9HViOyydMUJ?=
 =?us-ascii?Q?smVATL9sS4eSxPzZpsFsfnm2n+4jFsk4Mv+1Esq3q0z9zGnITHHAwmQ/dPlQ?=
 =?us-ascii?Q?g558m0MxNHJgugvujVEohfDuJOyK7TzMsIPSuyhTalQ0blZ0LgYG4iyoAvT1?=
 =?us-ascii?Q?vUPJIWfZVq9jFK169LaxvTq8I4lXGXx1QUA3IHxAH67npq/HpNLuPBxhH0Wv?=
 =?us-ascii?Q?mg1pk9s7D42+jyxP3ZufodKufnndxoBsg2uB7Brd2WBVaXzwXQFNnWed92ZC?=
 =?us-ascii?Q?qYDKFrctBVMQ/Bh40rkg9XkAwMXCh85Nva/VwLnZENVW9PrrarPTFoK8JEbF?=
 =?us-ascii?Q?YcSsVQC0b15zSKiLmBjKoRBQ+8jMu12kOYMldx+YwjKAbTGxZN9kLM3a2HSV?=
 =?us-ascii?Q?IbCgRCoeiczqtfCwF0qlFv9urPiN2KSCQHIh/R3Y9KBeUTZqcdvpDKoAHh5z?=
 =?us-ascii?Q?YgVyUCzijW7aAgULu16cHV5oh0PzcTNh?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(36860700013)(1800799024)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2025 13:52:04.6136
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 32a403bb-baec-4041-c6af-08dd5b23bf3a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000099.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7973

From: Linus Torvalds <torvalds@linux-foundation.org>

pipe_readable(), pipe_writable(), and pipe_poll() can read "pipe->head"
and "pipe->tail" outside of "pipe->mutex" critical section. When the
head and the tail are read individually in that order, there is a window
for interruption between the two reads in which both the head and the
tail can be updated by concurrent readers and writers.

One of the problematic scenarios observed with hackbench running
multiple groups on a large server on a particular pipe inode is as
follows:

    pipe->head = 36
    pipe->tail = 36

    hackbench-118762  [057] .....  1029.550548: pipe_write: *wakes up: pipe not full*
    hackbench-118762  [057] .....  1029.550548: pipe_write: head: 36 -> 37 [tail: 36]
    hackbench-118762  [057] .....  1029.550548: pipe_write: *wake up next reader 118740*
    hackbench-118762  [057] .....  1029.550548: pipe_write: *wake up next writer 118768*

    hackbench-118768  [206] .....  1029.55055X: pipe_write: *writer wakes up*
    hackbench-118768  [206] .....  1029.55055X: pipe_write: head = READ_ONCE(pipe->head) [37]
    ... CPU 206 interrupted (exact wakeup was not traced but 118768 did read head at 37 in traces)

    hackbench-118740  [057] .....  1029.550558: pipe_read:  *reader wakes up: pipe is not empty*
    hackbench-118740  [057] .....  1029.550558: pipe_read:  tail: 36 -> 37 [head = 37]
    hackbench-118740  [057] .....  1029.550559: pipe_read:  *pipe is empty; wakeup writer 118768*
    hackbench-118740  [057] .....  1029.550559: pipe_read:  *sleeps*

    hackbench-118766  [185] .....  1029.550592: pipe_write: *New writer comes in*
    hackbench-118766  [185] .....  1029.550592: pipe_write: head: 37 -> 38 [tail: 37]
    hackbench-118766  [185] .....  1029.550592: pipe_write: *wakes up reader 118766*

    hackbench-118740  [185] .....  1029.550598: pipe_read:  *reader wakes up; pipe not empty*
    hackbench-118740  [185] .....  1029.550599: pipe_read:  tail: 37 -> 38 [head: 38]
    hackbench-118740  [185] .....  1029.550599: pipe_read:  *pipe is empty*
    hackbench-118740  [185] .....  1029.550599: pipe_read:  *reader sleeps; wakeup writer 118768*

    ... CPU 206 switches back to writer
    hackbench-118768  [206] .....  1029.550601: pipe_write: tail = READ_ONCE(pipe->tail) [38]
    hackbench-118768  [206] .....  1029.550601: pipe_write: pipe_full()? (u32)(37 - 38) >= 16? Yes
    hackbench-118768  [206] .....  1029.550601: pipe_write: *writer goes back to sleep*

    [ Tasks 118740 and 118768 can then indefinitely wait on each other. ]

The unsigned arithmetic in pipe_occupancy() wraps around when
"pipe->tail > pipe->head" leading to pipe_full() returning true despite
the pipe being empty.

The case of genuine wraparound of "pipe->head" is handled since pipe
buffer has data allowing readers to make progress until the pipe->tail
wraps too after which the reader will wakeup a sleeping writer, however,
mistaking the pipe to be full when it is in fact empty can lead to
readers and writers waiting on each other indefinitely.

This issue became more problematic and surfaced as a hang in hackbench
after the optimization in commit aaec5a95d596 ("pipe_read: don't wake up
the writer if the pipe is still full") significantly reduced the number
of spurious wakeups of writers that had previously helped mask the
issue.

To avoid missing any updates between the reads of "pipe->head" and
"pipe->write", unionize the two with a single unsigned long
"pipe->head_tail" member that can be loaded atomically.

Using "pipe->head_tail" to read the head and the tail ensures the
lockless checks do not miss any updates to the head or the tail and
since those two are only updated under "pipe->mutex", it ensures that
the head is always ahead of, or equal to the tail resulting in correct
calculations.

  [ prateek: commit log, testing on x86 platforms. ]

Reported-and-debugged-by: Swapnil Sapkal <swapnil.sapkal@amd.com>
Closes: https://lore.kernel.org/lkml/e813814e-7094-4673-bc69-731af065a0eb@amd.com/
Reported-by: Alexey Gladkov <legion@kernel.org>
Closes: https://lore.kernel.org/all/Z8Wn0nTvevLRG_4m@example.org/
Fixes: 8cefc107ca54 ("pipe: Use head and tail pointers for the ring, not cursor and length")
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Tested-by: Swapnil Sapkal <swapnil.sapkal@amd.com>
Reviewed-by: Oleg Nesterov <oleg@redhat.com>
Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
---
Changes are based on:

  git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git vfs-6.15.pipe

at commit commit ee5eda8ea595 ("pipe: change pipe_write() to never add a
zero-sized buffer") but also applies cleanly on top of v6.14-rc5.

The diff from Linus is kept as is except for removing the whitespaces in
front of the typedef that checkpatch complained about (the warning on
usage of typedef itself has been ignored since I could not think of a
better alternative other than #ifdef hackery in pipe_inode_info and the
newly introduced pipe_index union.) and the suggestion from Oleg to
explicitly initialize the "head_tail" with:

    union pipe_index idx = { .head_tail = READ_ONCE(pipe->head_tail) }

I went with commit 8cefc107ca54 ("pipe: Use head and tail pointers for
the ring, not cursor and length") for the "Fixes:" tag since pipe_poll()
added:

    unsigned int head = READ_ONCE(pipe->head);
    unsigned int tail = READ_ONCE(pipe->tail);

    poll_wait(filp, &pipe->wait, wait);

    BUG_ON(pipe_occupancy(head, tail) > pipe->ring_size);

and the race described can trigger that BUG_ON() but as Linus pointed
out in [1] the commit 85190d15f4ea ("pipe: don't use 'pipe_wait() for
basic pipe IO") is probably the one that can cause the writers to
sleep on empty pipe since the pipe_wait() used prior did not drop the
pipe lock until it called schedule() and prepare_to_wait() was called
before pipe_unlock() ensuring no races.

[1] https://lore.kernel.org/all/CAHk-=wh804HX8H86VRUSKoJGVG0eBe8sPz8=E3d8LHftOCSqwQ@mail.gmail.com/

Please let me know if the patch requires any modifications and I'll jump
right on it. The changes have been tested on both a 5th Generation AMD
EPYC system and on a dual socket Intel Emerald Rapids system with
multiple thousand iterations of hackbench for small and large loop
counts. Thanks a ton to Swapnil for all the help.
---
 fs/pipe.c                 | 19 ++++++++-----------
 include/linux/pipe_fs_i.h | 39 +++++++++++++++++++++++++++++++++++++--
 2 files changed, 45 insertions(+), 13 deletions(-)

diff --git a/fs/pipe.c b/fs/pipe.c
index b0641f75b1ba..780990f307ab 100644
--- a/fs/pipe.c
+++ b/fs/pipe.c
@@ -210,11 +210,10 @@ static const struct pipe_buf_operations anon_pipe_buf_ops = {
 /* Done while waiting without holding the pipe lock - thus the READ_ONCE() */
 static inline bool pipe_readable(const struct pipe_inode_info *pipe)
 {
-	unsigned int head = READ_ONCE(pipe->head);
-	unsigned int tail = READ_ONCE(pipe->tail);
+	union pipe_index idx = { .head_tail = READ_ONCE(pipe->head_tail) };
 	unsigned int writers = READ_ONCE(pipe->writers);
 
-	return !pipe_empty(head, tail) || !writers;
+	return !pipe_empty(idx.head, idx.tail) || !writers;
 }
 
 static inline unsigned int pipe_update_tail(struct pipe_inode_info *pipe,
@@ -403,11 +402,10 @@ static inline int is_packetized(struct file *file)
 /* Done while waiting without holding the pipe lock - thus the READ_ONCE() */
 static inline bool pipe_writable(const struct pipe_inode_info *pipe)
 {
-	unsigned int head = READ_ONCE(pipe->head);
-	unsigned int tail = READ_ONCE(pipe->tail);
+	union pipe_index idx = { .head_tail = READ_ONCE(pipe->head_tail) };
 	unsigned int max_usage = READ_ONCE(pipe->max_usage);
 
-	return !pipe_full(head, tail, max_usage) ||
+	return !pipe_full(idx.head, idx.tail, max_usage) ||
 		!READ_ONCE(pipe->readers);
 }
 
@@ -649,7 +647,7 @@ pipe_poll(struct file *filp, poll_table *wait)
 {
 	__poll_t mask;
 	struct pipe_inode_info *pipe = filp->private_data;
-	unsigned int head, tail;
+	union pipe_index idx;
 
 	/* Epoll has some historical nasty semantics, this enables them */
 	WRITE_ONCE(pipe->poll_usage, true);
@@ -670,19 +668,18 @@ pipe_poll(struct file *filp, poll_table *wait)
 	 * if something changes and you got it wrong, the poll
 	 * table entry will wake you up and fix it.
 	 */
-	head = READ_ONCE(pipe->head);
-	tail = READ_ONCE(pipe->tail);
+	idx.head_tail = READ_ONCE(pipe->head_tail);
 
 	mask = 0;
 	if (filp->f_mode & FMODE_READ) {
-		if (!pipe_empty(head, tail))
+		if (!pipe_empty(idx.head, idx.tail))
 			mask |= EPOLLIN | EPOLLRDNORM;
 		if (!pipe->writers && filp->f_pipe != pipe->w_counter)
 			mask |= EPOLLHUP;
 	}
 
 	if (filp->f_mode & FMODE_WRITE) {
-		if (!pipe_full(head, tail, pipe->max_usage))
+		if (!pipe_full(idx.head, idx.tail, pipe->max_usage))
 			mask |= EPOLLOUT | EPOLLWRNORM;
 		/*
 		 * Most Unices do not set EPOLLERR for FIFOs but on Linux they
diff --git a/include/linux/pipe_fs_i.h b/include/linux/pipe_fs_i.h
index 8ff23bf5a819..3cc4f8eab853 100644
--- a/include/linux/pipe_fs_i.h
+++ b/include/linux/pipe_fs_i.h
@@ -31,6 +31,33 @@ struct pipe_buffer {
 	unsigned long private;
 };
 
+/*
+ * Really only alpha needs 32-bit fields, but
+ * might as well do it for 64-bit architectures
+ * since that's what we've historically done,
+ * and it makes 'head_tail' always be a simple
+ * 'unsigned long'.
+ */
+#ifdef CONFIG_64BIT
+typedef unsigned int pipe_index_t;
+#else
+typedef unsigned short pipe_index_t;
+#endif
+
+/*
+ * We have to declare this outside 'struct pipe_inode_info',
+ * but then we can't use 'union pipe_index' for an anonymous
+ * union, so we end up having to duplicate this declaration
+ * below. Annoying.
+ */
+union pipe_index {
+	unsigned long head_tail;
+	struct {
+		pipe_index_t head;
+		pipe_index_t tail;
+	};
+};
+
 /**
  *	struct pipe_inode_info - a linux kernel pipe
  *	@mutex: mutex protecting the whole thing
@@ -58,8 +85,16 @@ struct pipe_buffer {
 struct pipe_inode_info {
 	struct mutex mutex;
 	wait_queue_head_t rd_wait, wr_wait;
-	unsigned int head;
-	unsigned int tail;
+
+	/* This has to match the 'union pipe_index' above */
+	union {
+		unsigned long head_tail;
+		struct {
+			pipe_index_t head;
+			pipe_index_t tail;
+		};
+	};
+
 	unsigned int max_usage;
 	unsigned int ring_size;
 	unsigned int nr_accounted;

base-commit: ee5eda8ea59546af2e8f192c060fbf29862d7cbd
-- 
2.34.1


