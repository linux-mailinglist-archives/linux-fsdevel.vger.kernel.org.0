Return-Path: <linux-fsdevel+bounces-40175-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E38BA201D5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Jan 2025 00:45:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 682BF3A44FC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Jan 2025 23:45:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4DF81DDA00;
	Mon, 27 Jan 2025 23:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="tIXDVVq2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazolkn19013074.outbound.protection.outlook.com [52.103.51.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55D61481A3;
	Mon, 27 Jan 2025 23:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.51.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738021531; cv=fail; b=cmLvMzNlJF+Pft43a1v3i/a9oe5COBhsiwaXf2Up6TdWRVUZsNGf1MMe8zJHZBBZ//Mb4vbCQbsdF90uHLvc/X6EMa6r4FWaK0Cb4dh85GE1OGI5IRMg+v5POyuC2qr79VAR3rJa0ZJg4XnEFZwKkCXakVuQUDuo4YoR8FiOTdI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738021531; c=relaxed/simple;
	bh=4U874iizo/Gq7jDY5XRhmzGcg/vOuyQ/QbXRwf09HWs=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=U87d1b3/7sfmprECI7v3l2xe/FS2N1Hr6YhfaSEl6W6g7PWQaq5+U3R8YTbG60f+5/7O4wTMu1NKr1NyA6vpDgR+xrNCfIo2Q4gYkoEkBPgQvw1sh7UqrDGRPxiGPEjuSbSKpKHW2updIcVBbFRCICoLBwReV+brh+7jvsmpVUM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=tIXDVVq2; arc=fail smtp.client-ip=52.103.51.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t6uxLoSMxnBkNXF1e7aP8TCMyIqeZMDBQntDb2DFaru1AFPzIONXU+N8KMhvlkcwUkizJwBqmepAWy70Mjai6auHVKLviVGxDP8ySHE0Akw3y4JNX4Dy+Mh106KUXQWEbWsbIsQXth2XjGemRQnjj+IbDv18PheGC4L7+1I5vaTmQ+4vkeS+cmmu+2YpQxDD7AlBzKy+CYU132a+fGyJMzBtkLY21fgdAaVf7Pt3VhR0WguuPZTuiKf9RrXRI1Q8DCDuZ0IZ4btXIF+ikT8k4DDeFPE+AclWADVWcQX+iffZUfxEvwd8+hnez396Rd8POtV2MfW6UUB1jKlYPdlTow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9a4pLyAcNFZ8m/oNOPS7c8MjQ1NruiWpqgAbTaXVxXY=;
 b=RPsJ7W0vFLbnYdDGqhTdYXP/ws9xLHwGSrf2m7B8pnQGoiGjFKj7OGmV2bOCu66c/CAfdLzMvH6gkEQbqnOGsB5isK81Tmrsk2R+YAgMj9WiO973pxZuMLNUSt/qGklVXXe9JskXlc7XHMN0Cz7cn8ShX062e2y7psYQyHMgrZ+4YEu0yMnyajN88eYs9JSyLB1tpM00ycNR+SWUdIe4JyysAubZYZzWTyT2cpIOuxlarrhA8q1utYfGju1tTl3nBhRWKypAuPDK0rr9QPmRVNuCZRnXUPx8AdSXEXfCZIKHe1a8jrPe36Bqrh+mc0amnlc2LBkmKzOC5vz7dHRsDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9a4pLyAcNFZ8m/oNOPS7c8MjQ1NruiWpqgAbTaXVxXY=;
 b=tIXDVVq2JbL96f8FAI+0vBuC1M6gXCJe6LPXUpg6XIZWDvwWWfuXoBPpTMGXGOL5UWWzJ71JU+NI35S1ZiuUtl0HVsNqYwMoDJ7GQXXBgGItW5qw4ULAkoAfv/x8ij/FMS/PEroW2wUL+q4pNaocvS3EnlNfa3rVuM7feMKpw/RF5VJKfZA5ygBWY6j2LbZD3Hb6TS0WmfUBsJ/jjs2aNCzmfBy1iJaJylXROpv12pIb22JLLitygHGcSfHma1y4amWxG/h7MMuxpe13hFz7JzPR0eX/y5+ETHnzrkBqPDwqPbx2a10JvTIDAquUaL6CPumrRWgriSSnlKGLZ0XeUQ==
Received: from AM6PR03MB5080.eurprd03.prod.outlook.com (2603:10a6:20b:90::20)
 by AM0PR03MB6209.eurprd03.prod.outlook.com (2603:10a6:20b:156::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.22; Mon, 27 Jan
 2025 23:45:26 +0000
Received: from AM6PR03MB5080.eurprd03.prod.outlook.com
 ([fe80::a16:9eb8:6868:f6d8]) by AM6PR03MB5080.eurprd03.prod.outlook.com
 ([fe80::a16:9eb8:6868:f6d8%3]) with mapi id 15.20.8377.021; Mon, 27 Jan 2025
 23:45:26 +0000
From: Juntong Deng <juntong.deng@outlook.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	memxor@gmail.com,
	snorcht@gmail.com,
	brauner@kernel.org
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH bpf-next v9 0/5] bpf: Add open-coded style process file iterator and bpf_fget_task() kfunc
Date: Mon, 27 Jan 2025 23:44:47 +0000
Message-ID:
 <AM6PR03MB50801990BD93BFA2297A123599EC2@AM6PR03MB5080.eurprd03.prod.outlook.com>
X-Mailer: git-send-email 2.39.5
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0488.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:13a::13) To AM6PR03MB5080.eurprd03.prod.outlook.com
 (2603:10a6:20b:90::20)
X-Microsoft-Original-Message-ID:
 <20250127234447.88949-1-juntong.deng@outlook.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR03MB5080:EE_|AM0PR03MB6209:EE_
X-MS-Office365-Filtering-Correlation-Id: 2564c6d8-a098-49db-abb8-08dd3f2cac99
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|8060799006|5062599005|19110799003|5072599009|15080799006|12121999004|461199028|4302099013|440099028|3412199025|10035399004|41001999003|1602099012;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?rpzD8O/19G8/BD+b9RPlur0suj1UIeCxg6pxZdU3V0DvWv3YGoBOkZxBDJwI?=
 =?us-ascii?Q?jxys7uXlorGu/oIxU4SJVEJ8A9T1phRbwA8tWiAL5ZBof80WVtaqMuuM3KSI?=
 =?us-ascii?Q?/m/utruF8by4gi727LggKSFILPl/Y/Q59WqO8KRoQus7AgR//qSuzaAlmi3+?=
 =?us-ascii?Q?iB3D/0Z8u5/z138mHqIS60eanTR4pl0BYkwe/dEQC0RQsWkzwplSqu3Q8PgZ?=
 =?us-ascii?Q?fD+XExY2jDl0VjkGgn6z6N9z/B+tUnuGfqjTE1xT9NT5lkP8XLbRvWVl6hYG?=
 =?us-ascii?Q?nGZtw0Xl3yE9gQImf2GWGY5g2sVyBBgNtGmLTnR4d7u9NdZ6wXCz3CdouLkz?=
 =?us-ascii?Q?3O8rnxGveYEtFAgHSejVpbaI4KA6JUCDioPGndoR6Z1IDW4XHJiwxJOW3I3o?=
 =?us-ascii?Q?cpLGI4/VudQ3D1jY9chHZTtcTmwWrA6lReyx2Ah7fiBnxtTrKx/m8Tr5Ttx0?=
 =?us-ascii?Q?WPC/TagfhCaXgLwN9cIGxh2hbkaK5A8NSuY7cZA3XNaRovwP5wTknAGQ3DH1?=
 =?us-ascii?Q?6KNagADB0ia7oAiXJBAK4A8E+/1Cljil19o5vZ4QpBeJxuuxMYyJoE7aXZB2?=
 =?us-ascii?Q?ej6fyh5U6+uGlk0H7Fit3RZWVkuYZTxdTsOgR3ZzYjZxP96/J5mrW4PEOaVX?=
 =?us-ascii?Q?ICJlpet/z9y8mgKCkIT3S+3GAINBi9uYZvyTdv/Du++k2uxKxT6KpXfBGiEM?=
 =?us-ascii?Q?dqZRNqIQh/tLBaPvuMacT9z0TdILFz3yZE/bYL/Tteq0P0jkrLLq2A+23YYn?=
 =?us-ascii?Q?O3C6r20CSAARG8tqV7kTEBITXFQoe1gfci4JARLTYYZmJTi/6Dteu6k0WGQH?=
 =?us-ascii?Q?IVnzSiyWBZNUfrnHOjI4cQZzBelo0/8EkwvUWVIaJ4AxOukp9boUgSnitUUs?=
 =?us-ascii?Q?h2Tp/0cmYC8Dsn9plLCh9iLrnZvuWpB6X5GHGkn1lVRRNwNOueqLrkc1ErWq?=
 =?us-ascii?Q?zRBiIvrdMR25eHMLx1V6nQuOPx5SYUv39ajzkDE6AbCQxEQVICWhD4J2ehv2?=
 =?us-ascii?Q?TOBjozBIBZn5BIAbklmA4SX65flCbbvK5du+5y6zXkGtnW0LbD0HIqhZXgUq?=
 =?us-ascii?Q?+EyLtD3HY2BhJ74CNFGrvaAVM2lvUVZSGP8QE7QhkE6FyP7oX+xsfV0HrrLt?=
 =?us-ascii?Q?xef+ADLOGd2SUe2MsXV+oP+mGiSEEHQqLQNFUYLfQWq9/QfrKeMQ+LnbHceL?=
 =?us-ascii?Q?ip8n0/Mbr3F2wS+Z0zHAUJHJyP8Fh+QL/jxBglY1jQy0DLclfBT5GSi+1Ph0?=
 =?us-ascii?Q?ZGvf2OeC+TNzwYX9FPmp8NC4IVWJaHuWZeQMYTJDFg=3D=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?qEbVE/2H3s/DPyOoT9Z8uVH0HCcE1Y3axwwqMcOjWDDrGv0w3zQoFQiD1mpj?=
 =?us-ascii?Q?GUr+m1CUZF1sjK8XtfZ8tUeW5EUNwO2gvVRyHuyGDdSnoTLVWz7Wyk+KKi7t?=
 =?us-ascii?Q?PGEX+AaIfXfGFUfEAurGAoeITXQ3pSYD96OqmLXXnIEJABejfigKXm2MkX3f?=
 =?us-ascii?Q?aproQ5lB2mBVyg1AWHD3RampFX4d89wfIjlhSARW+6MJYFcu1RW5J7+Dg6et?=
 =?us-ascii?Q?l93tQTGENPKyCGmwu7+L4awfomiAc6fFFQxs7lCE8bE+mrsNZP+/k2ueYrf9?=
 =?us-ascii?Q?Nn+ySbLho/zdfg9amqPtBaiOzGtHY3HtWoUiJqgU+VAGs0dvKQ75v2936P9I?=
 =?us-ascii?Q?XwtLKv5BUXGioSCycWqJtgEa/O/cZxrNYM2U0QxmHaeoa4uqkT5lRL78sDBd?=
 =?us-ascii?Q?mqp4YPVUwV0yEkCVnqhdNSYp3q8k4AT33FKBK17fTu8zu2j+J23QTIbL9bea?=
 =?us-ascii?Q?56VHVgX/kSBOPi0Zh0QV+14AT/FDR+aHlEstOWWo1x70G9/h1nrShRr8fsqk?=
 =?us-ascii?Q?BqVpsCjdTx4DVuMs8Tll5UK6lut+KsBe2eKpbmD56LNGb9n0dpVnO/M6DdgU?=
 =?us-ascii?Q?PCMzmhtSPTdQsMnotlUUbZ7JPDepD/4vRp47O57TS0/6qkGN6EIC8NJDcA3X?=
 =?us-ascii?Q?parIObzeIa22Ev/9oFiThk1nwQfNfxL2l8U/lyo18C6j9ikf3gdnton1TpyK?=
 =?us-ascii?Q?+FcpJqJoeoZviSNA8+dGag0tlnCr7hVe8WzyDdDSKHxgEuNiMxofmhfIGUJF?=
 =?us-ascii?Q?Tj1V9wAVQyiyJQR+renv9TMiVEQHBZR8V0ERDDQkNAHIHcRSqVsiFh6hvyUO?=
 =?us-ascii?Q?1mOxazxv2ZVE+bTho30bKuqq6VYezxnVPr03UD6PahUFHP6VhaA7YAlwtsyc?=
 =?us-ascii?Q?v5dQUUZW40Acylw6uUQdIbOgALsRGzXDrab1rCeJsqc2NjMDv0Ej5U/wtWxc?=
 =?us-ascii?Q?8+exWKi18P7SC0B0M1iYrHGT4a5C0X9OhIkKwEHArrK+1E6r5sc+sfj+riAX?=
 =?us-ascii?Q?gJwPFEk1hUaqCNAtlbxu98hgnNdSl7mf7BGB72U2Ob78sEwOeHVXOOOZLR96?=
 =?us-ascii?Q?SilfvuWZUEIffxOxhgLgy2pLHr16XMmyMWTnIbLK5ixvWSyxkOxfj+7VZ9va?=
 =?us-ascii?Q?xnN0Pu3qlViRMACEPl3TNUryYwzfDd6hWTPAEtmZ3/gDA4x/XUvOIlbJrGMN?=
 =?us-ascii?Q?dQYGTwYO/eUfmSLvFO3dsQNSogHGAVixMKllM8WacbyrqYAnbZSiE60KZj+q?=
 =?us-ascii?Q?eTITFwRlgfFbI10XYvzo?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2564c6d8-a098-49db-abb8-08dd3f2cac99
X-MS-Exchange-CrossTenant-AuthSource: AM6PR03MB5080.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2025 23:45:26.5434
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR03MB6209

This patch series adds open-coded style process file iterator
bpf_iter_task_file and bpf_fget_task() kfunc, and corresponding
selftests test cases.

In addition, since fs kfuncs is general and useful for scenarios
other than LSM, this patch makes fs kfuncs available for SYSCALL
program type.

(In this version I did not remove the declarations in
bpf_experimental.h as I guess these might be useful to others?)

Please do not ignore the previous version. The iters/task_file test case
revealed inconsistent behavior between gcc-compiled kernel and
llvm-compiled kernel [0].

[0]: https://lore.kernel.org/bpf/AM6PR03MB5080DFE11B733C9DCD6547E199EC2@AM6PR03MB5080.eurprd03.prod.outlook.com/

Although iter/task_file already exists, for CRIB we still need the
open-coded iterator style process file iterator, and the same is true
for other bpf iterators such as iter/tcp, iter/udp, etc.

The traditional bpf iterator is more like a bpf version of procfs, but
similar to procfs, it is not suitable for CRIB scenarios that need to
obtain large amounts of complex, multi-level in-kernel information.

The following is from previous discussions [1].

[1]: https://lore.kernel.org/bpf/AM6PR03MB5848CA34B5B68C90F210285E99B12@AM6PR03MB5848.eurprd03.prod.outlook.com/

This is because the context of bpf iterators is fixed and bpf iterators
cannot be nested. This means that a bpf iterator program can only
complete a specific small iterative dump task, and cannot dump
multi-level data.

An example, when we need to dump all the sockets of a process, we need
to iterate over all the files (sockets) of the process, and iterate over
the all packets in the queue of each socket, and iterate over all data
in each packet.

If we use bpf iterator, since the iterator can not be nested, we need to
use socket iterator program to get all the basic information of all
sockets (pass pid as filter), and then use packet iterator program to
get the basic information of all packets of a specific socket (pass pid,
fd as filter), and then use packet data iterator program to get all the
data of a specific packet (pass pid, fd, packet index as filter).

This would be complicated and require a lot of (each iteration)
bpf program startup and exit (leading to poor performance).

By comparison, open coded iterator is much more flexible, we can iterate
in any context, at any time, and iteration can be nested, so we can
achieve more flexible and more elegant dumping through open coded
iterators.

With open coded iterators, all of the above can be done in a single
bpf program, and with nested iterators, everything becomes compact
and simple.

Also, bpf iterators transmit data to user space through seq_file,
which involves a lot of open (bpf_iter_create), read, close syscalls,
context switching, memory copying, and cannot achieve the performance
of using ringbuf.

Signed-off-by: Juntong Deng <juntong.deng@outlook.com>
---
v8 -> v9:
* Replace task->parent in test_bpf_iter_task_file with
  task->real_parent.

v7 -> v8:
* Keep path_d_path_kfunc_non_lsm

* Add back the const following extern

v6 -> v7:
* Fix argument index mistake

* Remove __aligned(8) at bpf_iter_task_file_kern

* Make the if statement that checks item->file closer to
  fget_task_next

* Remove the const following extern

* Keep bpf_fs_kfuncs_filter

v5 -> v6:
* Remove local variable in bpf_fget_task.

* Remove KF_RCU_PROTECTED from bpf_iter_task_file_new.

* Remove bpf_fs_kfunc_set from being available for TRACING.

* Use get_task_struct in bpf_iter_task_file_new.

* Use put_task_struct in bpf_iter_task_file_destroy.

v4 -> v5:
* Add file type checks in test cases for process file iterator
  and bpf_fget_task().

* Use fentry to synchronize tests instead of waiting in a loop.

* Remove path_d_path_kfunc_non_lsm test case.

* Replace task_lookup_next_fdget_rcu() with fget_task_next().

* Remove future merge conflict section in cover letter (resolved).

v3 -> v4:
* Make all kfuncs generic, not CRIB specific.

* Move bpf_fget_task to fs/bpf_fs_kfuncs.c.

* Remove bpf_iter_task_file_get_fd and bpf_get_file_ops_type.

* Use struct bpf_iter_task_file_item * as the return value of
  bpf_iter_task_file_next.

* Change fd to unsigned int type and add next_fd.

* Add KF_RCU_PROTECTED to bpf_iter_task_file_new.

* Make fs kfuncs available to SYSCALL and TRACING program types.

* Update all relevant test cases.

* Remove the discussion section from cover letter.

v2 -> v3:
* Move task_file open-coded iterator to kernel/bpf/helpers.c.

* Fix duplicate error code 7 in test_bpf_iter_task_file().

* Add comment for case when bpf_iter_task_file_get_fd() returns -1.

* Add future plans in commit message of "Add struct file related
  CRIB kfuncs".

* Add Discussion section to cover letter.

v1 -> v2:
* Fix a type definition error in the fd parameter of
  bpf_fget_task() at crib_common.h.

Juntong Deng (5):
  bpf: Introduce task_file open-coded iterator kfuncs
  selftests/bpf: Add tests for open-coded style process file iterator
  bpf: Add bpf_fget_task() kfunc
  bpf: Make fs kfuncs available for SYSCALL program type
  selftests/bpf: Add tests for bpf_fget_task() kfunc

 fs/bpf_fs_kfuncs.c                            | 32 +++++--
 kernel/bpf/helpers.c                          |  3 +
 kernel/bpf/task_iter.c                        | 90 ++++++++++++++++++
 .../testing/selftests/bpf/bpf_experimental.h  | 15 +++
 .../selftests/bpf/prog_tests/fs_kfuncs.c      | 46 ++++++++++
 .../testing/selftests/bpf/prog_tests/iters.c  | 78 ++++++++++++++++
 .../selftests/bpf/progs/fs_kfuncs_failure.c   | 33 +++++++
 .../selftests/bpf/progs/iters_task_file.c     | 87 ++++++++++++++++++
 .../bpf/progs/iters_task_file_failure.c       | 91 +++++++++++++++++++
 .../selftests/bpf/progs/test_fget_task.c      | 63 +++++++++++++
 10 files changed, 530 insertions(+), 8 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/fs_kfuncs_failure.c
 create mode 100644 tools/testing/selftests/bpf/progs/iters_task_file.c
 create mode 100644 tools/testing/selftests/bpf/progs/iters_task_file_failure.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_fget_task.c

-- 
2.39.5


