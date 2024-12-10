Return-Path: <linux-fsdevel+bounces-36938-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D52099EB2A8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Dec 2024 15:06:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D91A2188B71E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Dec 2024 14:04:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 130531BD9E6;
	Tue, 10 Dec 2024 14:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="BNttw+Rf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02olkn2082.outbound.protection.outlook.com [40.92.49.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 483861BD9CB;
	Tue, 10 Dec 2024 14:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.49.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733839367; cv=fail; b=C+CEEi2JEhJZpxnRcL3rHvULSGSY3GljsY1tR3APJfSLbNBgKCn7VX16hPO+EXohhln6wNQSENfLpfcoAHuCSYHsTkThKONq6gnxKU/Cn2U08q7KsKhEf8aLQTctKbAn9wh1d17E3jxgCuBOD73jlWTz8i6fNZIJhgT1M7ycdg0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733839367; c=relaxed/simple;
	bh=sjv8bswRCu9DuW6KSqzamw/ZTpbPRm/8M027l9zTCsA=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=OI9/EXiUsFHgsCn8HcwUnnI++EFnU9+bk9bTuEA5behcnlOxHa6y075/CpFP/5IzITfxzs8bxmKpYMr+WFqd5bSSHhC/Fl3sBrh6bR4SRUtSsjE4+S4bALgNHX+nZF9Y+uI/68JEKbCWxhg+CmktEjpITkACFo8+otDYtqFPoec=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=BNttw+Rf; arc=fail smtp.client-ip=40.92.49.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Yq3EvZd/DDFx/uQemKYByRP8AGwwfbIrRTkZ0VbOkeHtdl/tpqDjxVsR+zIfUNgjd6/W/Cl13x4XPqNn5PBz+UxUN5Jvabc9EYNDVOXP+/t38knHpaZ4K8GK6cRHdQmaPRU0mmPihf4nQXzm9r8VtjOuU1Jpb9WCBor2IPULVW72cY61yeJEkWZVmlCC9oDFlFMddYw65aT1BvTj61xdhJUfzYFv30t/KyoscHwHJ98ZP0N6IZ049myMhLVe0ZifaMxjkGX9oxZs1/Qiam4jNxmvTCvYaV6+5ndKUyS0pebAD2koc5dzF59emo2ImSFJYMFtO6tpqZC8O/npjFcbtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1gws6PrV0RoX1EhblE221bBC3xFiytRivkoPaDD0H04=;
 b=S3Eh8AXVcCap7VynZfLrnVks6Bk/D6OIrk4FoUyoM8NVm/OwxzYe0eZgXak7IY6lL/2i/0hO+wxC+rYtLgmZOnNFgApkGx7GNqMw19H353zt+ixp4maH8kPj0oOQZ33T9UvWTD21hr3A9Cgj63QgwjcmOnZ7XHq9lsrXpq3qhqKA0bNvEXylmsppDHAjrrUofG1CrGj5kyxJZs8TBGk4of1vgUBmPwf+JXS/dxqtahKyN4/zXOY6lihA+16ig4YQbGDTlDku1c+2NAGHo/rqz9iEaz2Zm4sAH/xiQn9XaPaUTsNaPFamhI0TinF44F3ao0A4A1bkVA1pbke8tgqwrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1gws6PrV0RoX1EhblE221bBC3xFiytRivkoPaDD0H04=;
 b=BNttw+Rf7RBeY9+U4u+lnwEsY0UW+2L4zxmynSIkLAQcwl/bcV3hJuUXEql/sYV6F1aQP7k7UQ27ZbLOWz9zA3orrrLLj5+TiwvliC0EauTOm3rJbbc6FfCtNhdVfP2CkQ3eCnhAt+tn5UsIADE0AKZtJTpb1u7mz2Cj9QySD0NXu1I7xuxK6snBgMzp06NM3b3o3fugDx19y38zacRqZr1prVgUTLbJjp37v4a2zL1sUiR9O3GLmaNLLs4vRgXOuxn3DCIYX0BNnr1Cam6ucVZawGj8ba5lEZAAcdHBJebOlr09lKHYWoCp9/IgCL/s3uZ37MzfHssHrbTNUn/NOA==
Received: from AM6PR03MB5080.eurprd03.prod.outlook.com (2603:10a6:20b:90::20)
 by PAWPR03MB10072.eurprd03.prod.outlook.com (2603:10a6:102:360::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.18; Tue, 10 Dec
 2024 14:02:41 +0000
Received: from AM6PR03MB5080.eurprd03.prod.outlook.com
 ([fe80::a16:9eb8:6868:f6d8]) by AM6PR03MB5080.eurprd03.prod.outlook.com
 ([fe80::a16:9eb8:6868:f6d8%5]) with mapi id 15.20.8230.016; Tue, 10 Dec 2024
 14:02:41 +0000
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
Subject: [PATCH bpf-next v5 0/5] bpf: Add open-coded style process file iterator and bpf_fget_task() kfunc
Date: Tue, 10 Dec 2024 14:01:53 +0000
Message-ID:
 <AM6PR03MB508010982C37DF735B1EAA0E993D2@AM6PR03MB5080.eurprd03.prod.outlook.com>
X-Mailer: git-send-email 2.39.5
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0567.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:33b::20) To AM6PR03MB5080.eurprd03.prod.outlook.com
 (2603:10a6:20b:90::20)
X-Microsoft-Original-Message-ID:
 <20241210140153.25328-1-juntong.deng@outlook.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR03MB5080:EE_|PAWPR03MB10072:EE_
X-MS-Office365-Filtering-Correlation-Id: 614e40e6-23ed-4189-f9cc-08dd19234fb7
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|5062599005|19110799003|461199028|5072599009|15080799006|8060799006|10035399004|4302099013|440099028|3412199025|1602099012;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?vHv0Ef3hOSqIup+Ur7ZyxRDCCEa8FQq+hkvtAC5gPAQb17n/d+LS9QUqWych?=
 =?us-ascii?Q?0CHvQA8IaeACOTQ8loIJiqppn5+FIXuSAsKGeW7GMj+j+qzfQJLJyoyv08xM?=
 =?us-ascii?Q?bDFoh3WB5H+qlkdHd2fwBaYKTFBuyX0Plok75AvSN1s1VZMMv/1ybpeBl18n?=
 =?us-ascii?Q?IoQJSLNGjG0TRVAvk7V9r1I01IfszrIQ+XUGtsLGg38IX8Bl91i+gr4KWn/Q?=
 =?us-ascii?Q?cWzLDv51tIGfCcalm9Pgy5Ml0SmMQtcDiXeaGWoIUkFUlivmOlKSKaUiEtSz?=
 =?us-ascii?Q?Dz9lqAGLwhC15bYuQVLC8BOtn25XA95yrSU+IaHx0YKfl4iz5rNHxYcyGhor?=
 =?us-ascii?Q?uzphpoS6zc8bnnvSTerR+V8wkc8Mr39Z+qDO+sNU4hkQPoOupEbVA0Pzo/YJ?=
 =?us-ascii?Q?G6rYZj9zdeAIgCkzGtOxdlkmk9L7+B8hH+7iC3NitxKLqO8K6yP+gauBkJik?=
 =?us-ascii?Q?scfOfRkWXUCT9WnPw4DhZFZavoGNgOUtfr35zrOqpRW2IgIXumqA5ShH0ZUA?=
 =?us-ascii?Q?jAjorLKE/ssd2PBwJ8of07xVTiQcSLbQMfQFIqyyM7btNVLlDCMwM2/3Wot8?=
 =?us-ascii?Q?uaRP9F7mh4z66UbXQhHfh5DFp1epQcvC1J1e/8avnbUoqaLPthBirJ0xLHFw?=
 =?us-ascii?Q?dVYMV5QOaMYIbLVC06m1N/belnza29RKALJ1FiJJB8ZztvxRC24a2lj/TLmA?=
 =?us-ascii?Q?KGzUOUPSuBqVZClod6jAVg8JYVUwHyfw6kgLeeBWcwep/6JDGo00csQnG7jV?=
 =?us-ascii?Q?5zNeSZV8ZqIOpn2gRDaHgMVaHGru4FSFMz+dzaWSK6ueDL+YFHkJqgWZiexg?=
 =?us-ascii?Q?+aWM8sUNT6QqInJYs+kv66JNqsNcjudh0Mt3e+ShX0a0lfeR2xe5K0S43n39?=
 =?us-ascii?Q?Kmw6Ltjum1sF21eAecLQDDDGXYBOICZAlwpivRN5WaMyAXjTwRsg1Mumuf7+?=
 =?us-ascii?Q?cT5fMgZFvfMoINVJMb910qHYvG73rzr2XZQle2BrTYwjxTtXImslT4HGoEtj?=
 =?us-ascii?Q?Mtb7qUzcB+ahEIFKzEzOU+ISnxFRX7hZSMcjz1EBiLV2V4EzWJHoSJlCygLN?=
 =?us-ascii?Q?pBrLeWET+640Pesa/4KsuACzAS681jBk5FkH70xBcrz6ZtkYS0ZTRQqZrOY6?=
 =?us-ascii?Q?a9iRbZO1QHr1WFQT7p2ZWZfR7wqbkUXow4cZ19T+A6ZqBDK8SyntJvrnoZr8?=
 =?us-ascii?Q?YSx+S+7C6piy+MWZ7H9ViDH4peuWarkb6Hl8nA=3D=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?DyOr3PnxaDKcSdBPU/sFrp9VKnr4jQ8sAA6JI3tfP2KH/SSXByDCdWULZFq+?=
 =?us-ascii?Q?Hawmu4+NiYsyNf3zyfm0hjUCXI7tfqY/yjm56FtxjN5V3PuokOdtv8tgFt4E?=
 =?us-ascii?Q?VIY0ukMY1xA9ggvGG8cmKgmsob6awhneJs5TxaKVbYNHKXUv3ZD9HB7qDf4J?=
 =?us-ascii?Q?qu9sR6wg3DU6MBaxkGCTwshazqxXmTyYbTAS9zZFPUPdkCkfc/sp7FhyQEcL?=
 =?us-ascii?Q?FTp1hlMUTLgmGFCTj3eHW81+hlQw0DOaD9XdHU0aR7M9ggZLyllEkZM/sJV3?=
 =?us-ascii?Q?kuJBJzGihjPb6qKqa316HoS7smDASCl7WA8SYxdXz2ztjdVhwxY8tPq6lNbv?=
 =?us-ascii?Q?DMi7lVapbDPO5Mxi/ATqV6eAVLSIr/+4R6gGqCZlBOcrFMu7E16q3eA2jaOa?=
 =?us-ascii?Q?Jc5rhQdseNie4tKt5SMj1/nkz7NTwpuWElZEQzVYiXZkhMb0gemYKN27Yl+u?=
 =?us-ascii?Q?pqCzS4PMpswplWGaWSy8Z5QnXCrWvEbEy5zGY7ND809Qsyj/Y/lwcIB0o2Cs?=
 =?us-ascii?Q?qXW3kNFV8hDYrHiTqPLZ+SYUS1VCPvNE4iIMRMdtW2TGZ3fYcKhcWLu5NW9a?=
 =?us-ascii?Q?0uTAjynLRWYIGQUVjqPUTUHkdl3nrMhsSP77774k0GoJppzOPGRPZmWvhpmS?=
 =?us-ascii?Q?DFx+8VD762R+ztXYgOmiWZEn57H9/WyxKiiBe1hdhhktov2Jp5rOGQZNKgjM?=
 =?us-ascii?Q?EyPYodclDeprcRv+3uK5C2lWUzeBkUVTwBY3x4W6cE7oivEB1ilR+h1c7P8L?=
 =?us-ascii?Q?Pap64EkrPdux7s16zs8nJKpf4IYk8NQshwTXjY9XhTNO2IHwiTBWJ+/+N24L?=
 =?us-ascii?Q?1sjN5czIRl8r7wor0V1B4OeIveE/yGD9r+zdibibqBr82D1mgPbHPp2TP+CE?=
 =?us-ascii?Q?77mWJocD1yKTyQUvhvhTZoizPPE/hranl0m5aY2rqEupsslmRlLQg5pKuSBm?=
 =?us-ascii?Q?8d3ymdseQtjM79HwREKv18KwrHZYdGZLCc2YFPQU4Q6Rfllwui57LnWb9XoB?=
 =?us-ascii?Q?qJu/ot7pgfj7m2sXRlGP8gL9cmOvK2TyjDBMgyn1ptdLPVM2joQo4SafURAD?=
 =?us-ascii?Q?tnBRvTWSsO5JN3iCSsRnS7ac/0hnME0n4PuQhp8bstN2yFTFdKuJBpiu17fN?=
 =?us-ascii?Q?puUFnqWZxQrhN2EEu49rFXGuqLQeBHWALmRt7C/9x1Pc3DAtp4pJPmEkwEm1?=
 =?us-ascii?Q?bw7eyBFJ1c0yKQMVwV84CmZQcx+gOj7FM16qsfmntLvA97j6xtPPmsop1dqp?=
 =?us-ascii?Q?IsUspxYrlCZxchbVJmb2?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 614e40e6-23ed-4189-f9cc-08dd19234fb7
X-MS-Exchange-CrossTenant-AuthSource: AM6PR03MB5080.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2024 14:02:41.0707
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR03MB10072

This patch series adds open-coded style process file iterator
bpf_iter_task_file and bpf_fget_task() kfunc, and corresponding
selftests test cases.

In addition, since fs kfuncs is generic and useful for scenarios
other than LSM, this patch makes fs kfuncs available for SYSCALL
and TRACING program types [0].

[0]: https://lore.kernel.org/bpf/CAPhsuW6ud21v2xz8iSXf=CiDL+R_zpQ+p8isSTMTw=EiJQtRSw@mail.gmail.com/

Although iter/task_file already exists, for CRIB we still need the
open-coded iterator style process file iterator, and the same is true
for other bpf iterators such as iter/tcp, iter/udp, etc.

The traditional bpf iterator is more like a bpf version of procfs, but
similar to procfs, it is not suitable for CRIB scenarios that need to
obtain large amounts of complex, multi-level in-kernel information.

The following is from previous discussions [2].

[2]: https://lore.kernel.org/bpf/AM6PR03MB5848CA34B5B68C90F210285E99B12@AM6PR03MB5848.eurprd03.prod.outlook.com/

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
  bpf: Make fs kfuncs available for SYSCALL and TRACING program types
  selftests/bpf: Add tests for bpf_fget_task() kfunc

 fs/bpf_fs_kfuncs.c                            |  42 ++++---
 kernel/bpf/helpers.c                          |   3 +
 kernel/bpf/task_iter.c                        |  92 ++++++++++++++
 .../testing/selftests/bpf/bpf_experimental.h  |  15 +++
 .../selftests/bpf/prog_tests/fs_kfuncs.c      |  46 +++++++
 .../testing/selftests/bpf/prog_tests/iters.c  |  79 ++++++++++++
 .../selftests/bpf/progs/fs_kfuncs_failure.c   |  33 +++++
 .../selftests/bpf/progs/iters_task_file.c     |  88 ++++++++++++++
 .../bpf/progs/iters_task_file_failure.c       | 114 ++++++++++++++++++
 .../selftests/bpf/progs/test_fget_task.c      |  63 ++++++++++
 .../selftests/bpf/progs/verifier_vfs_reject.c |  10 --
 11 files changed, 559 insertions(+), 26 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/fs_kfuncs_failure.c
 create mode 100644 tools/testing/selftests/bpf/progs/iters_task_file.c
 create mode 100644 tools/testing/selftests/bpf/progs/iters_task_file_failure.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_fget_task.c

-- 
2.39.5


