Return-Path: <linux-fsdevel+bounces-39876-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 271B9A19B4B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Jan 2025 00:03:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D9BAC188DD68
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Jan 2025 23:03:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 438A21CACF7;
	Wed, 22 Jan 2025 23:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="EUUkpNPB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03olkn2069.outbound.protection.outlook.com [40.92.57.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB1381AF4EA;
	Wed, 22 Jan 2025 23:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.57.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737587004; cv=fail; b=bb4G6/KYrtmnc233uobW0Ad+688voV3c2XO8GmOlKaaG4JtDfv5QjXBa34H3mXojSMVDvqQ9xm0URuo8g7k8Y76dXsM0poMI8i0dxJCLtQfqsvnUGN5ueel5Xkxy639gA6xhn5HglyyqHoA9JOa+URS1SEFUWO9VhrWo5f8ZIv0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737587004; c=relaxed/simple;
	bh=f8ga5hYX4E4145jgV9H1Q8Nc9cL2tpzmuovpR/CJKzI=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=NpibHkWcRVIHpMOOJcqNf4pQab3bCjkwbMJ45rDlLsgdFwZV1H66t7J5lcKMRt39Xav8pine31HqPfeWzWVr7/okgk5I6WdJVhfBy2d9E8jlSl2N/VPvOxtgSHKcRDNTqnplqCdIs2GFnjZriHLtlzqQiIdCeBr1n8EwCzD9ha8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=EUUkpNPB; arc=fail smtp.client-ip=40.92.57.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RY8gyqsTXFwqXD4LSe7VT5u9pzjiN5hG4Q83mGgHMfHGu2aa5HqzillI8Wah/R7Zkx35x8SeAcxaz91vfWonJV+S/kSwVttv4/NpqQJRk0R7ePzJeYhKz6vQUnvEJNyNUXyJKM8QFRh0yXdbl6Q9UH5QDywc45yicJWmfVxWqn3Og4QMd1nDbSMsE8O3WVQsmNbEdHVlm2gfEipJePbtQgsvXlhnVezzyiC4M+wQIjP2qaRc6hlOqa0suwyhoIKZzDHt9z0EXWRFbPNzgnetlLhsWxuFf2Em/TfNpGRZrkxBf2nAMCIP91RifSC2LrTEYEISXeWYChSRJYxGLkKa7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9Fu6M90j0F3iygOAHetq2vPU8ipuSE0QtPP2H9U7kQo=;
 b=MI5Itbo0k3MPdha9Yf99jyYEJ+FssdAr/X0YETmH/TdI2TqHk2Z00N3i4gnUn0KD6GINaTS7lXPCAidLRReN+A2+fnU7F+Oou4WPki+n4hJxfoPVJ8J4Zmj/SH70lU+GpRnlvHa5MAxlkX9xI6AZeb4Kx0vCO44daksJ+2m/cLW6GjHENMtWDo3OuXRATt7JQ3y8f/lyngcxyvWuWMTdRMaRwSKEr6Nd44ssx8BCHY1qBtsmdFWFT7m3TzzouqsBLN6yOjlICBGegRQT2a9WSpqBP4oH3hJ24by8kDOj4xs/S7ZDnDECWdfQFVYzwZ+0uFGs8PeldRxkarHIiBFisA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9Fu6M90j0F3iygOAHetq2vPU8ipuSE0QtPP2H9U7kQo=;
 b=EUUkpNPBQKFbvFl2YEmR3Y/1kSrt4oQXzhigj7K+WMp+XGRjP5QOaQP2brVuv0jdjyC8jnebSEVijlZ2/gsG5cUjzUkfp+5vsQEBhc4lYTfxnfbW6NZSxLZvUKSQ+Z0BGTy9UyTimm8mu5kolJSFXm6UNQo3x88sCnwqIFLhpard79lYXESqIrtRyY0lHGtQ1WHeyHHegjLg7wYirnFQDa34BRpjj0I6RWLR03axNyhs5o2b/CK9VbDGSKBEjVTswGBr7sEBTiAInVQHLxidS9hr3K8GbMsQovoTmBAEl4DRGAfpm6edugBJwuOmSH8y0uLSxScJtQl17evDm3H3aA==
Received: from AM6PR03MB5080.eurprd03.prod.outlook.com (2603:10a6:20b:90::20)
 by VI2PR03MB10907.eurprd03.prod.outlook.com (2603:10a6:800:270::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.20; Wed, 22 Jan
 2025 23:03:19 +0000
Received: from AM6PR03MB5080.eurprd03.prod.outlook.com
 ([fe80::a16:9eb8:6868:f6d8]) by AM6PR03MB5080.eurprd03.prod.outlook.com
 ([fe80::a16:9eb8:6868:f6d8%3]) with mapi id 15.20.8356.020; Wed, 22 Jan 2025
 23:03:19 +0000
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
Subject: [PATCH bpf-next v8 0/5] bpf: Add open-coded style process file iterator and bpf_fget_task() kfunc
Date: Wed, 22 Jan 2025 23:01:27 +0000
Message-ID:
 <AM6PR03MB50806D2E13B3C81B0ECDB5B299E12@AM6PR03MB5080.eurprd03.prod.outlook.com>
X-Mailer: git-send-email 2.39.5
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P265CA0301.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:391::19) To AM6PR03MB5080.eurprd03.prod.outlook.com
 (2603:10a6:20b:90::20)
X-Microsoft-Original-Message-ID:
 <20250122230127.35382-1-juntong.deng@outlook.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR03MB5080:EE_|VI2PR03MB10907:EE_
X-MS-Office365-Filtering-Correlation-Id: 8729304d-64c3-408b-a0be-08dd3b38f661
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|19110799003|15080799006|5072599009|8060799006|461199028|5062599005|10035399004|440099028|41001999003|4302099013|3412199025|1602099012;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?dGuuBcKfpx0JlQ63DRQI/gi1MKK/dVYev2TTrB1Yzwgq+JHE8rZEsny+ykVa?=
 =?us-ascii?Q?008ogcpET07lCQxGG2ShdDsyxUNeAWTA30eVR6wDFcnrvQ34U7C0Cb+xKd/D?=
 =?us-ascii?Q?zajTydzGiqrBjQ5x7MjxuFUXjWJzWModIURiQMBUzBLabY/cJGOOMZnoK0s3?=
 =?us-ascii?Q?PWyOmq0QL7dJ+37plHzBeLa8Dw026Iq5i730H9QY1Cr04yghcTq5OlDQ62Cw?=
 =?us-ascii?Q?UXZCppCvHTbl1ECy8Q08OWpLqtbbv7sxAVtY4kSOseyn47wIT6LIK5c6GF/6?=
 =?us-ascii?Q?Vi8PsKG75OlVbnkcuHYnE9X3fBY0SfwvjTgUOm+IWSKJwh9+HPIEis/XPqdD?=
 =?us-ascii?Q?Mwns+bmo7ZZiUdp5Px5cFEf3SDYvC5vnEe/m7nu4He4wIkYcX87mS3TEKLSe?=
 =?us-ascii?Q?FC2n00EC+R1xjh7TKwB+f82ZmRon8BE4DdRKznDVnEaDvUBgKSSQU/EEz+NW?=
 =?us-ascii?Q?PzgZi+rX+qkKPYdcPpyA9VLvdU4ip7792xIG07d/hhGaZRdjoSovKvL+8oe2?=
 =?us-ascii?Q?rwTeGaADYt61GfRsnBIIrX4oaArExSltMIp9+9Logdknvk3i4yEV9ho050T+?=
 =?us-ascii?Q?mlL5vafDIFrqWxM3B5eUZMI2OwTGpixVBnYn11KG4kdlLx15JqztwTBb4KXk?=
 =?us-ascii?Q?RFqmWBCkKj15GG1pZYxN6UW1NbClwdBMSg9jNnyPU/wCd63J7V8vQZsdaWqH?=
 =?us-ascii?Q?FXWkjUu8t2rKIcFf2akEf24lVtSwvDQbbend0LjyDbrb3MRTgLPOb9hj1jLC?=
 =?us-ascii?Q?qg6MKibHtJuEpoXzFgteZ3bu0XjVFc8+uIaty0R1o2Lx5ssqSEyw73vMOrvT?=
 =?us-ascii?Q?lu8r2ZDjAoWVPmOOojcR2yMJ9MgE7btEqs5e9nZM/O1qXAdUuUm0zq5LQlYc?=
 =?us-ascii?Q?nshU/L4KOVmMU06F6DxGp7HZkfdLqTKSC1eD2op3Oi1+hlWMeTs1/do8amV0?=
 =?us-ascii?Q?SWjygvh6EcRqG5F2bNTxGAgVoiT6Z9i3bPIWd3owJ1UQUFK/R1PzXZBqfNvY?=
 =?us-ascii?Q?yd3OKkt04KZdS0onvUWGEhm9NZPyxrMybObCO1E2PRAal20TU0sFSHhQyc/H?=
 =?us-ascii?Q?stTVOEH927K/xU0v+XMOpwDqOxn0Wqje3l06mRtCc+Y8BmomxwbIbf1FVVOM?=
 =?us-ascii?Q?lI/hi7Im3KqcVJ3x3UsMnPdNjPOpUIOrjo/InHimpIG7GVKcAZe+NClCiJWn?=
 =?us-ascii?Q?qqbKfh8S78puXiZ6TVnPUwnEFFCP4Al48sOvQDk/jmOzEriet1cy6g9KWC8?=
 =?us-ascii?Q?=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?iRHS1tkgH8OpvDYSjYGtT5/pFQxj1JGs+dlumKtPLWZ34Q0bZ6p3oWcp0YgU?=
 =?us-ascii?Q?LVqXmDc7U+u1jZNfsygIVJVRFCE4LCyR0GKwAy19jxqdA2reW8MKbSWtFift?=
 =?us-ascii?Q?JcwzyoqQvyj4O9VdLdlWWdtGWNn4T1OMKHCrxf6s6b4FdSRzI2FWKWag/oa2?=
 =?us-ascii?Q?EqbYxLIL5+AV4zK1l7ubqTnUYUW9JPn83tjExmpnHygogGNHnCvSgCPsmCsK?=
 =?us-ascii?Q?0sdiEhqF+srBDhYi44Q1kZ7/uHUFdP0R3EBK/gdnSFZl+Bl5GUWwA2WzD/8X?=
 =?us-ascii?Q?3m2KayNkx8Ikaf9bpywogU9MwzJaON5iIWU2v1dJlT0J3zkV9Rn4ZqloP7BZ?=
 =?us-ascii?Q?uIDBx9rYKcrAYd2YD2uFHCDcv18pVk2xKYYwXWbYxvmuw2Ps9sbfp+7ihkyb?=
 =?us-ascii?Q?FPi/ITVzER8dfAcjFGDMkxv8+XrCaVj3EziMP8D+piDKLvisbjUXCK4/aooI?=
 =?us-ascii?Q?cYl8ck/iMUKRjkgb3ZVJEiU9us9M55F/VccuMbAnwJkgCnKAbaPCwhyxPYFd?=
 =?us-ascii?Q?YLNTvEuk8+DQyOVIRTrKyG1loVAtv5zAxgrtdE8qcxkqFMzGuDVBIZ4xLIZx?=
 =?us-ascii?Q?uVXWb2BP7rfGcj/kvGyV7rkFo5YrIaGqlGN4yB/BUsnfBdQF49TGmGhQjaQl?=
 =?us-ascii?Q?NRJKRsm6JbOQ1IhiXNuPZh/JbIqwGNp/NC86DST5v4qAf7+qg5Rh4TcL+Sbc?=
 =?us-ascii?Q?/ZowCbQdd0IG3XTNxHxEIlzM/h8FDjb2hye/gjsi5PBbc6ZAMCedOF4cBgi3?=
 =?us-ascii?Q?ij4ibF2LCCkPCPlcc6bqneyC8qmeeXYaQHwvQg63Qqjjzht/wkCnTUB2+wv9?=
 =?us-ascii?Q?JIBrZFRzAdL6TxbhnRovb+4VrLro+nkiKwuiuui3uzF9RpkQKAqK3nGvWJyo?=
 =?us-ascii?Q?qjlMgHw+khXnki3tqRbAC8ItH/7aUCuyFuUPjA+OhxydyDNQQ8+lFF7lfjCG?=
 =?us-ascii?Q?dqDW1PBx9xPgZFMJVku54ZUE2Zlldir90I8YEy2DntOS57MxrKHxFSPGMSc+?=
 =?us-ascii?Q?l0LHKFuI2EK23E8ltWPye1qn4gTx0tfz1px33RFIgNJF+jYy4eVfmbp5oHWr?=
 =?us-ascii?Q?KWUDVc3TdcEtpB9QDAgly+3j+7EE0EKc0AS9LncAJR3v1fDIkBOBhX+OntUj?=
 =?us-ascii?Q?yonetQCULb1NU9sUpUVFhreXpw0FtsJvR1XM9j4rqF6u2RrEXx5lY9n/ox/g?=
 =?us-ascii?Q?cdHrIT+ankS7zUwuEEoWHD4Nvh7mwTHUKBwhRts+GWT56LhYXRGh4RKuhbYw?=
 =?us-ascii?Q?Mfw0ANhLszoWxgdAVIqp?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8729304d-64c3-408b-a0be-08dd3b38f661
X-MS-Exchange-CrossTenant-AuthSource: AM6PR03MB5080.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2025 23:03:19.6869
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR03MB10907

This patch series adds open-coded style process file iterator
bpf_iter_task_file and bpf_fget_task() kfunc, and corresponding
selftests test cases.

In addition, since fs kfuncs is general and useful for scenarios
other than LSM, this patch makes fs kfuncs available for SYSCALL
program type.

(In this version I did not remove the declarations in
bpf_experimental.h as I guess these might be useful to others?)

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


