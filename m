Return-Path: <linux-fsdevel+bounces-37678-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 72BC79F5A84
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Dec 2024 00:36:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 83B8B188D390
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Dec 2024 23:36:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF5301FA828;
	Tue, 17 Dec 2024 23:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="Gm5cxmXF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05olkn2073.outbound.protection.outlook.com [40.92.91.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11A221E489;
	Tue, 17 Dec 2024 23:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.91.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734478555; cv=fail; b=jUV67K6a/2LAy3spQc5vZRnQrvvkE7SJ6hid0xJ5akpEXQJmZyc1oPLmU8H3MFBIW/GFEToNK1CpkliggpcHTSFZLwtzoePdTR8b0qFGlxRkVe74gQVONhBouQJytJ8QyFMh87RHSbk3gFRN9yccO3IUV66FaeUBjV92GmWgRzo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734478555; c=relaxed/simple;
	bh=8XJyD7dAqP4WQZ89pPg6uV0yqp5mCiO/82eQII+zGzQ=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=eUMWxUxYSFnI2dc0qDxuG6+5DmayaALlY/kDZAJXKa1fzIxlUY/w3AvIFLOI4PxrwmYMyX8+hoxk+JBNzlUZ4hzt/LlL40GC9Ny3G60WFxQKfaKiRgf/FNZYoUc7B5RkmmdQ1iwdzx/LXZuAj7W1CdtfQwLZEmaWTmTVgz/sM9Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=Gm5cxmXF; arc=fail smtp.client-ip=40.92.91.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HaXH3VoxLKkVMrmhstdWdD+z/Zykj9Ea2KaUQLZaenu5fEH8xmON+8W7F8gUTzFoEDXSWwODJDtvTBmwsd1XWOKXfMK+B8829tgMv8CUurqE816TaxOcrhNLMn3huQxRPxoNBdNhr4rpf5xf4vcpHcdETSDyqL9A9O+5s7FMY3XDp2O3cwGM1gbr0EefDl9RpDX945EXieiZPnHXPRj3/n9Jj903gYQ2tZ7aQ0Gd0vVr7hWAJ9qsMT4u5uQ9qtJoAi1HSkOpyZ6lLLJWxCtebPQfo2kHpSphnt+1Avkdqwbj957cGdCk7wL9pUCtSp8hmNc39lf7XJv/SDFnzRBt7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wk1kTL3ELsgzXmEDTJBP5fFi0MCq8dZdt+LrGrb6pkA=;
 b=HgofBWcNCswowENzQydYZ5HKB4P8xmbexoTAj6fIcf/8Cw2biahbUgAR/+c7cxLfXIPrmvCD+YV+ILVrhzhHydNVRzjEw8BOFH322qjSbpwzQV0f2RbBDdKTdADXVNNkHz2Addh7sqPEvhGLCpAb6vgfv6E5VxXWWe1OVPSYljmJrtZ6/rrEC6QsuZs39LTQbD/3XGGXa6/35XXSfGMdYW5N5HSWrI/bRA/W/le59tUstNPeDgWy8M77j66F6oL22xMz643FzvzKnwVMA+N9nN49iLrrCm7cDoFxwW7hcCvneIgduNn/N+dILbCXIk4fSPwJqjsiWhHjFC0u8S5fqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wk1kTL3ELsgzXmEDTJBP5fFi0MCq8dZdt+LrGrb6pkA=;
 b=Gm5cxmXFTIo3UJn4JZaPDt1n5/sm32T48M9RxCj7hXkR89+z2d3k2EiFCF3rN02wrq/n15yUdayj51c1LeGTwIirGgr/wSgpG1mPFH6dklqIs9uqlt/HqJF7kuaeiqJQDdXwg80nEQsvBVYglKsoVeU9E5ikBfheuUSeI1CxmySeWJUu3awN4uSud/DTmahZK66Q0bE9hZ88M0AOBL/vry/qUH45wwFKIqrnwa4W33lQs+hnvPVCfGtJ88cubiA+rs2lmsYV+KLAZEAMNix4jh4ILxM/45dLNNFyfRxFZb8+zz0lVUDsq25k0QW4K3WRD3HeGYDs1tRO4o6EQ68Kvw==
Received: from AM6PR03MB5080.eurprd03.prod.outlook.com (2603:10a6:20b:90::20)
 by VI0PR03MB10927.eurprd03.prod.outlook.com (2603:10a6:800:26b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.21; Tue, 17 Dec
 2024 23:35:49 +0000
Received: from AM6PR03MB5080.eurprd03.prod.outlook.com
 ([fe80::a16:9eb8:6868:f6d8]) by AM6PR03MB5080.eurprd03.prod.outlook.com
 ([fe80::a16:9eb8:6868:f6d8%5]) with mapi id 15.20.8272.005; Tue, 17 Dec 2024
 23:35:49 +0000
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
Subject: [PATCH bpf-next v6 0/5] bpf: Add open-coded style process file iterator and bpf_fget_task() kfunc
Date: Tue, 17 Dec 2024 23:34:18 +0000
Message-ID:
 <AM6PR03MB5080DC63013560E26507079E99042@AM6PR03MB5080.eurprd03.prod.outlook.com>
X-Mailer: git-send-email 2.39.5
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P265CA0127.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2c6::18) To AM6PR03MB5080.eurprd03.prod.outlook.com
 (2603:10a6:20b:90::20)
X-Microsoft-Original-Message-ID:
 <20241217233418.207893-1-juntong.deng@outlook.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR03MB5080:EE_|VI0PR03MB10927:EE_
X-MS-Office365-Filtering-Correlation-Id: 93f814a0-1de7-4ed9-ea4d-08dd1ef3899c
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|19110799003|5062599005|8060799006|5072599009|461199028|15080799006|10035399004|440099028|3412199025|4302099013|1602099012;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ZUWHslJklA65I+a9PKodLzkCgGzF893eOXSojQ19VBmkoEPQpjBpaNgfEtaT?=
 =?us-ascii?Q?dLtvkM6vRVRqIPe9pfox2fJnjsyhfSPVONY0xH4JkP5BCj2051TB2Rklwih7?=
 =?us-ascii?Q?zmLj7b7CKLWa+wv5uH050KcmkhicP0x8kA4/4Ccep/NQSzxoA/cY2DUDErb5?=
 =?us-ascii?Q?sSNq0r6nncAW5CJZfNbV9lWw6aMayh2NdHPvyCCA1U4mIGCQbKxRcLH9MTng?=
 =?us-ascii?Q?mmRQRwJkqACG5Iz0w/zH/qfBBjLTNMhtngTCDk2HfjYLKLxsQwYl67xeDg95?=
 =?us-ascii?Q?wUAZbVKBO3/TaEjL18jBqMTCbv81NZSE3wV4YwGHHKPA5ehCk4U60zLPTlbu?=
 =?us-ascii?Q?0xvX2pBv1Ww66p0Rm33eN0W0HaUT3iQriVXZ42iCTu1qGpMd0TN6xzYoDOP1?=
 =?us-ascii?Q?NN03CJ989GzaRqvVZtGvuKwxD3pdfoO4gLTZw9HSvB1Lh4UZzMPOWXO8wAEQ?=
 =?us-ascii?Q?bAMwYHd3nOepyLSq7n6pwSCBG65plJTs+5nrfJmURah+3huNc6PSUFnis5Ru?=
 =?us-ascii?Q?lw3aDA6yMHdJmxRtLujVepzNQP7Z4PFc63ZsO6v55VR/sr+25DfWwY9RYH1V?=
 =?us-ascii?Q?JwQ9epZkfyDbSGuL9hExU+GfqLB4yQ9xvsXChYxX7BHaVS38zslcvHGLccf+?=
 =?us-ascii?Q?GIdRu0/WBTAAeksf150zyLWrFoMZNTmK/jSAsy0pOAu+oNuw2ED/ttsFGzYC?=
 =?us-ascii?Q?Mapua8vgDTrqQmgpJ5zmOs3bQnplZR9J1AlEu4laEFtKJvXRc/ZI5fEXzflN?=
 =?us-ascii?Q?3jyJASgtfUMBILSO9p31Rwviu9v30Rz4fvWM4XjN5VqJUQXrP1auMOEaOni+?=
 =?us-ascii?Q?xIBiFr9quQVU6wGFpPNpZQya5pkwXBGd+VCpbSeAQFqxhmJtl7Ohmj1rjkhO?=
 =?us-ascii?Q?HrvtNEXTh1FXRvquidsUPTlkwF3V/3rf3sa3+/8BUsRb+Q3gUph91WmjZlEc?=
 =?us-ascii?Q?A+ei0V9NYs2gLScZmLakW3rY7tcOF1FarH6IpN3t5dexrCeIz9yFPNDnTo9t?=
 =?us-ascii?Q?OoAs4So/7VEYq1r8gZiVcFE39LYvxlvGGswvRSNI0vBnFt5nNjcbBjHTRqhv?=
 =?us-ascii?Q?liobgkqGmxjTVVg/R7UghBfpJgIi4kweherrSdoQ1DOmRA5YskLsb1zd3Bwb?=
 =?us-ascii?Q?awiFI86+/94+7cDk9CuslPyQ3NgIiTNHU6CTU1/5GavBSr+sIePoFfm93m1Q?=
 =?us-ascii?Q?EL51Y8zWf6u6fnryufld/BK33yITdAesuW0mKg=3D=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?tG3hKWZavRBT8+nmh+pvklchxczOiAusAcvT7YQr4oKy+CK2O4NnJVkfQ/kC?=
 =?us-ascii?Q?ZxfCCoecgO9b5fTXEhWA/TuisZsBl0bMFEpRfozYlLmWnbwo7QBDJmLsE4m3?=
 =?us-ascii?Q?UGcHDL2uZ0AgvEsQu8dgyZhEAr69tewyNy34wKDXgQzWhz5RIvE4/WUwE3be?=
 =?us-ascii?Q?PaPU7/UX8anEipg/RCWwW/tt4HsnOmcBH46+ZPk3exEz2L7QqfUUHAfa/NSq?=
 =?us-ascii?Q?wi3veimO5meWtBTVoo7E+dab0/vRsny5LJdi7+JQxSLtqmGfwqymuDxtDAyR?=
 =?us-ascii?Q?cEAiEybVLvmGhxlKcXPIDZYAoRPCHEWEMm3L/2YYVxG0anoZnv5aCKtZlA+L?=
 =?us-ascii?Q?9xW0lx2pF1aezC7aWNwwENsoYETOUfHEd51pSSS3tX+MCTdP6qWyj6Wcpa+P?=
 =?us-ascii?Q?pDDXE7G1lk1AxP1F0l0u2BXvPc7ygWoEZ2Y99k6kj4AZ7Bg5Ald0zKfgaMwa?=
 =?us-ascii?Q?cmmAOeR7KTnhRBNKdyqAH4H+gLXi9tyDl8+1mTeliuzCMqwxT+z53XX5T6Tp?=
 =?us-ascii?Q?UgbBEBYiDNpzt0Yerk9uBFRgzwZ3GTL13E0ryn3J4y+Vci3iFV/BCGjowERl?=
 =?us-ascii?Q?7vIEh5Is9pirGDslhGcsuC2EsnKXHAl0IEupSCv0ffbGjzTopeRoQGU3qCkp?=
 =?us-ascii?Q?A0Ejbp7A7Roux2jQvVq5bAsq1nfJqtB4FXCzZZfd2b/m2ijp2VW4DVCiIqWP?=
 =?us-ascii?Q?x8xd49SrR33Ba8Jr4rNwKzzAdCabQGt1Gk2gwifnk0v1N2oN7g8r/3iL1IRz?=
 =?us-ascii?Q?IC3+XtSJCfOfFkqAZSDV7evVO2xmU4c0kvFDDE/zWCH3NVsFuuAENnowYhMu?=
 =?us-ascii?Q?LOX0UJH/dHCKdcHK7qNVyrcxzkjI2f1JKcY/5bNC1+L9vhitpx1N5vQNMd8S?=
 =?us-ascii?Q?x5pMkxlBKHUCIFlRUBSxpTmi9k/gaF0U0PQT6syS8LglMhqnkDzVZsTLGff0?=
 =?us-ascii?Q?oh3JsMWPZoyv273sNx89bYEGZ0iVQEqxPjRX4I2Bvhaf3pusOwzV4CfPwJve?=
 =?us-ascii?Q?2uEFmbCZlzLWcC1A/+hE0Ka8SoFd+VP/IqV4JpdL1H8jROaJ46rThpmImHh1?=
 =?us-ascii?Q?pkLWEKzT1jyo5iPXv97MOKwhPtKbuSV7laFdr4HetEnLSmz3l73EKmomEDPz?=
 =?us-ascii?Q?IVYVGYHN7ewYNPZTXNxs70qD/fHrRWh3jGgma8JQ64poyGSWzVuBGSc/9NOm?=
 =?us-ascii?Q?Tee/NGibMsKWSAlg9lQ0n2SWMfJua7ZuG76oK4Yb3B3LxohANZP7YFuAhBGz?=
 =?us-ascii?Q?QHHFlei1Y4FAocAe8s2j?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93f814a0-1de7-4ed9-ea4d-08dd1ef3899c
X-MS-Exchange-CrossTenant-AuthSource: AM6PR03MB5080.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2024 23:35:49.3520
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR03MB10927

This patch series adds open-coded style process file iterator
bpf_iter_task_file and bpf_fget_task() kfunc, and corresponding
selftests test cases.

In addition, since fs kfuncs is generic and useful for scenarios
other than LSM, this patch makes fs kfuncs available for SYSCALL
program type.

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

 fs/bpf_fs_kfuncs.c                            | 38 ++++----
 kernel/bpf/helpers.c                          |  3 +
 kernel/bpf/task_iter.c                        | 91 +++++++++++++++++++
 .../testing/selftests/bpf/bpf_experimental.h  | 15 +++
 .../selftests/bpf/prog_tests/fs_kfuncs.c      | 46 ++++++++++
 .../testing/selftests/bpf/prog_tests/iters.c  | 79 ++++++++++++++++
 .../selftests/bpf/progs/fs_kfuncs_failure.c   | 33 +++++++
 .../selftests/bpf/progs/iters_task_file.c     | 86 ++++++++++++++++++
 .../bpf/progs/iters_task_file_failure.c       | 91 +++++++++++++++++++
 .../selftests/bpf/progs/test_fget_task.c      | 63 +++++++++++++
 .../selftests/bpf/progs/verifier_vfs_reject.c | 10 --
 11 files changed, 529 insertions(+), 26 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/fs_kfuncs_failure.c
 create mode 100644 tools/testing/selftests/bpf/progs/iters_task_file.c
 create mode 100644 tools/testing/selftests/bpf/progs/iters_task_file_failure.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_fget_task.c

-- 
2.39.5


