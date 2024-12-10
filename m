Return-Path: <linux-fsdevel+bounces-36940-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A685C9EB2B2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Dec 2024 15:07:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1438A167241
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Dec 2024 14:05:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D82A41AAA32;
	Tue, 10 Dec 2024 14:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="Y9sBvc2t"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05olkn2090.outbound.protection.outlook.com [40.92.91.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C5E05674D;
	Tue, 10 Dec 2024 14:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.91.90
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733839553; cv=fail; b=QRP4npdqAKWUc+Qah8SRyRf1tnhP3MFnpQHzCnOPobdYPDnim+xuM7McwYJRygDQDQcD7gYuzhCh1phcMYwZbDB9SpbymlcgJz48ZY3ee6VzBWirtEwsAZxsgJ2BigTCUunDUXXPAwa9/5yB3ULr0z9bSMFpcCVYwyvXdrlEkbg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733839553; c=relaxed/simple;
	bh=AMOEaliEoExboxv8tzmYilmMcmoFdvDLT9NnVIzRarQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EVyi0Yp5JBYghbJvpnevS+AKxCjjwkul+OEKZE7uCZOqH/RZ3+XVwaucWr01M/sUTdqI4w/EL+74mwlXYvldvWU+G0wzMz3AKGRo7FPtnJ9l7eZLaUgssW5PE12DH3rw3pw7ONViQdAiCJSJ/QrNnxkD7GOiioeb1CIo1w9T9Wg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=Y9sBvc2t; arc=fail smtp.client-ip=40.92.91.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=shkEp1/GDzR8f56qGBPD2b8jIUieIWYvmts+uXXaVQwTNKkbHucWNy57TV6ytefYji1uYR5Ghd0FRiegAXPcusYuyRcTouJTFCeWhc4UWtnW2PwhdGyZhs3yfVnqLzlVNMYAEV6xnMyLAzLo/gaC/Kp4yeWknqjXqewWH0TUaMU7d/nwVEn21LwJ0VDeBrcu2/V0pFU1WY2tdyPgpntuNgqvK6Xouc/a6dWXRcpufv/O4dT1SoZajrQErFovzp7QWnSEHCqZqck8ejNgqXuzoMzEA9PQ8u2UZT57RJWMwVaQsDxCBgmRh7CCuDgru4TL8NBaplXEnti+YbnIZfKSkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XirGjwy5aUVxamVwZw/UVQgueBUFVlNHo7sPf5vx0S0=;
 b=Yz0OKh5hhCl0CYTIHQY81DoeWGF7mzQFk1KZuiNKlFs2Ns2oTIihDwAPc6VTveKw/lj7SF/HQb55c7a+bxnhwfwzGfNeTe70uo15O8QRZnRD/tZqybTSse5wf9licQqREjmW2GiLoVoGsrmhIuNzEQMbhDP/jKVsQWJorcN1NkvNlhOzpLgRtxFMwxscH0HMILn+wCwrz+waG43gIr7orbT75gr4pE9n5ciYdbh0edm0+8Pg/mlHqxKMp0A07/acCTeurwiKsb2RLLBTljBy4JU2c+l4MmM2+xr+5EOTFvVbMRH/HkPXzFQoXNoY0XkN9q/xsxBw2CNOsmdmM4iJ6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XirGjwy5aUVxamVwZw/UVQgueBUFVlNHo7sPf5vx0S0=;
 b=Y9sBvc2tbvjTbyzs3ldlBY/EeL/iYvOAg5jLb57Qu33kAUDsj4TdVA/8M0I9CDDjZOwni0/FllNNO+EZ5BtPIEVHWll2UOYvgiOkXrxAmi+5q7y7GgxCXeAZV1QumzPUcjNJsUOWa4F+wx7t0PVy4rXa6IhsMlKt7ZaBibasWxRNgoKa+NVC/F7jdq9PxtAWv4a0zZM72vHPv2/V9Fu/FBvDJaowMbZEn7+YAxKgN9uApUrIjnaEtwPwOQGlaZ84gsVDROkYnZ8B3I62VLp5fBO4FGdBE5ifQRsAFwJo5zMgec0OJ1WG2aFMdht/XfI2haWEm0ohN9T59AipjQrBGw==
Received: from AM6PR03MB5080.eurprd03.prod.outlook.com (2603:10a6:20b:90::20)
 by DB3PR0302MB9037.eurprd03.prod.outlook.com (2603:10a6:10:439::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.18; Tue, 10 Dec
 2024 14:05:48 +0000
Received: from AM6PR03MB5080.eurprd03.prod.outlook.com
 ([fe80::a16:9eb8:6868:f6d8]) by AM6PR03MB5080.eurprd03.prod.outlook.com
 ([fe80::a16:9eb8:6868:f6d8%5]) with mapi id 15.20.8230.016; Tue, 10 Dec 2024
 14:05:48 +0000
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
Subject: [PATCH bpf-next v5 2/5] selftests/bpf: Add tests for open-coded style process file iterator
Date: Tue, 10 Dec 2024 14:03:51 +0000
Message-ID:
 <AM6PR03MB5080756ABBCCCBF664B374EB993D2@AM6PR03MB5080.eurprd03.prod.outlook.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <AM6PR03MB508010982C37DF735B1EAA0E993D2@AM6PR03MB5080.eurprd03.prod.outlook.com>
References: <AM6PR03MB508010982C37DF735B1EAA0E993D2@AM6PR03MB5080.eurprd03.prod.outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO6P265CA0010.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:339::7) To AM6PR03MB5080.eurprd03.prod.outlook.com
 (2603:10a6:20b:90::20)
X-Microsoft-Original-Message-ID:
 <20241210140354.25560-2-juntong.deng@outlook.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR03MB5080:EE_|DB3PR0302MB9037:EE_
X-MS-Office365-Filtering-Correlation-Id: deb463f7-5bf0-4720-2b2e-08dd1923bf08
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199028|5072599009|8060799006|15080799006|19110799003|440099028|3412199025;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?DUEWl0KZIzHuBGm91HJdYMXDgchSAx2Pplt7VJ6QkhFRPwqwhOKq6TipLtEM?=
 =?us-ascii?Q?wMBA5P67vRFKHQNybeKGISnxPde+mNpUIdkX3d+mdn7rg+gJNuRBSLrOECx0?=
 =?us-ascii?Q?SQ6TSfcOd3uFPK2kun6lwww/qtSKxXP3Noo0Jrfs3W5asGWepfqOuflLgUdY?=
 =?us-ascii?Q?zlLJF+SMg3JQ0Cf3p8CrNl8MqqaC1eaWO6IKIBnScO0wRzpTj7Y06vo6undy?=
 =?us-ascii?Q?Slnu4/x74jwqtNgbt3lN7/0REDLrb+DRWFSk7HZqn+BG9x4m8GYfSC4/Ipuk?=
 =?us-ascii?Q?w7tJ5s1Evv2KAu2xiWfp+qo4g1NAmrppIQ/iQKkgf5TiKC7Y3onYT5mQl6Xx?=
 =?us-ascii?Q?HtEBtm8i4YSK8GyA6MHoddv9bHl7n56k5d+6H7YlCMvyTkJQQWphGZK5bnHA?=
 =?us-ascii?Q?Bd8hJek8tQEOnTcRLIkG0lhu8PewDls+oRDhg47dZFW6xo5sTEEvC5rXsenu?=
 =?us-ascii?Q?CJWTRD/deobu0AoXwTGe3WsoZ7Bdm6fUP9rD7C0mwoUbl5mgJL/Z70LM2t+O?=
 =?us-ascii?Q?P8K6eRqe8xo5e7QkvQzRgKN380qqwhF+cRHTyWSGGYXJbyJ6KorDyk+0qHxs?=
 =?us-ascii?Q?a6KFzrDHoA8PaUujCA8INirJwql+r0xLtK19I835irnnjRD/ydHOGT7OK7+W?=
 =?us-ascii?Q?ivOuszxBDbRUrwob7KF46sfLSJuaSNu07sAaw/GskFeh9aTuY4IxWqvihaKJ?=
 =?us-ascii?Q?iKJok2Qu4yaZtfLtd++RqPrtCvZjy5tWJo5cQt4+W8FUFjURjrUh/kkUba8G?=
 =?us-ascii?Q?mzwsbHVp59gFgMofn1jcuvMsC5XUoVY3VczRVrLYgGH9bVoGkrf/7bL7FTk8?=
 =?us-ascii?Q?ksA9Jbj0ZquG7aOEBqBueIwped6vGaFKUp79pZqIAjzX/0vmzR37C1C7r2UF?=
 =?us-ascii?Q?RBRm+k4L09iIUQjngv3SB4DOXtUWSWPgAGzLOrCAFiFJ9xjq5xiOiVIrptYy?=
 =?us-ascii?Q?vu3I6v/bNf3e7jK/VUGEr/DFMP5Ao5RGGlzQX1IKzmsG6JmXwRheKJmcma2a?=
 =?us-ascii?Q?LZtItVntOEpFWvyQGc/XUzZSdg=3D=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?j/g9ERvOg56yiDSAorlZ0b3R4dD5q7kmi2Ub09+ct015i7qkHAhWHjhGP0DI?=
 =?us-ascii?Q?rYe7q4h/JjWO74EPQgSCJmamroKCvtxKSPqMOhd7hl6JT7mSRaUtNOA8NuX3?=
 =?us-ascii?Q?fXqCtGHKy7fXUxRnayfFM690G0kDfiI+4iHv3JUhD69BDMwBc9usLx14J7jm?=
 =?us-ascii?Q?BbysusIIM4LmZyUMP5ScnG0TpjVTvcm1YgNLtwEZW6kO+4FRZpZ6Hioim0CF?=
 =?us-ascii?Q?7yxYkvDDBU5sb+QD0pOU6WEcrfTmmdIU9HO2pH0Y95OnPd0kmNjm6pNY60Ub?=
 =?us-ascii?Q?GtkibgnIhmkNdQ3lKOhkSNT86xX6LbCjUTevE57BGyKPAzKmNUs9SKM59ijt?=
 =?us-ascii?Q?57thS/49llEcMqqc3NsQzUeNsKqc0+eu6d6iZYy7kiIrTbVU2ugB3NMI/0hQ?=
 =?us-ascii?Q?ejWpeQR9TxF5bXzLEXAZ1+KQPlZl9dvCARXt+G6UPGWR4bVn1aO64rIul6Lz?=
 =?us-ascii?Q?Ghk6IeDfIuPYNhjuqvNJd0JWImu6Ll9qjSo53ocpNIr2ww9cKrLC3HEnhpfw?=
 =?us-ascii?Q?x5XU2ravIe9BUpiUSjrgqPew+FQIrlU4fqTAl6jmJlqpnQbHowhauFMzH5E6?=
 =?us-ascii?Q?MEq26Or1abCUifBsBXQrVFaLkbnisSnWekXz6fpbD2VfAIm/HFd3/lE3r0Ip?=
 =?us-ascii?Q?VMG/Wn/FDBRk4yDHMxPUNv91fEMHh8ooeZm5EsrRRDVx7P0FvIjwbuCNgAnJ?=
 =?us-ascii?Q?34szhkeUHTNYjneEb8u4njKdsSBG/KBI9C49QvM7/dP61igbVT7D28r+a5rf?=
 =?us-ascii?Q?lVc3kcatKXiUvclWYwj9bpVsY5krz7HMsFnJfX3OCWM0yDXxfJqpRUq7gM4y?=
 =?us-ascii?Q?Px4UUNoXi50pAlH89AaIFRrJTGDJTWg0Zs5wgR6hhMOCEIg9UtJgLhSJjF9R?=
 =?us-ascii?Q?Zn/KvhXO3hsnE69p+V1sbW2adx3BhVyG5Z545KqVlTmm7WwV2gBvMoqqrBlP?=
 =?us-ascii?Q?Z3f/IgCe/DzZ+183XiWrhLcck2VsbbcM7PuwHkk+sddIfL75YWaq10SUFoR3?=
 =?us-ascii?Q?Y/OD2X1IbJLsK5tBOpWtP/RvhShabH1iuqRjZk9gTHKT7lTkqiuDnwZ2I5dE?=
 =?us-ascii?Q?QRW/S/E3411FF+2xnaiJvFyrTjdvM5hII2GGzLk7quAerE8LEFulrzpxugWa?=
 =?us-ascii?Q?c8D+1ZuL/fgNtUJxaXDrgRGKRQ2k6Fr+mlCWrD6Z1uCNl4VCgTe/wdNOABVc?=
 =?us-ascii?Q?MiI1JEL3mbh3Sh5tAJA6cTSUWmG0xnaR+XZe84uNwZWVb6lnI0KZiK5U5sHy?=
 =?us-ascii?Q?lhaXXELPIY+1XrBVu7Y1?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: deb463f7-5bf0-4720-2b2e-08dd1923bf08
X-MS-Exchange-CrossTenant-AuthSource: AM6PR03MB5080.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2024 14:05:47.9060
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0302MB9037

This patch adds test cases for open-coded style process file iterator.

Test cases related to process files are run in the newly created child
process. Close all opened files inherited from the parent process in
the child process to avoid the files opened by the parent process
affecting the test results.

In addition, this patch adds failure test cases where bpf programs
cannot pass the verifier due to uninitialized or untrusted
arguments, or not in RCU CS, etc.

Signed-off-by: Juntong Deng <juntong.deng@outlook.com>
---
 .../testing/selftests/bpf/bpf_experimental.h  |   7 ++
 .../testing/selftests/bpf/prog_tests/iters.c  |  79 ++++++++++++
 .../selftests/bpf/progs/iters_task_file.c     |  88 ++++++++++++++
 .../bpf/progs/iters_task_file_failure.c       | 114 ++++++++++++++++++
 4 files changed, 288 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/iters_task_file.c
 create mode 100644 tools/testing/selftests/bpf/progs/iters_task_file_failure.c

diff --git a/tools/testing/selftests/bpf/bpf_experimental.h b/tools/testing/selftests/bpf/bpf_experimental.h
index cd8ecd39c3f3..ce1520c56b55 100644
--- a/tools/testing/selftests/bpf/bpf_experimental.h
+++ b/tools/testing/selftests/bpf/bpf_experimental.h
@@ -588,4 +588,11 @@ extern int bpf_iter_kmem_cache_new(struct bpf_iter_kmem_cache *it) __weak __ksym
 extern struct kmem_cache *bpf_iter_kmem_cache_next(struct bpf_iter_kmem_cache *it) __weak __ksym;
 extern void bpf_iter_kmem_cache_destroy(struct bpf_iter_kmem_cache *it) __weak __ksym;
 
+struct bpf_iter_task_file;
+struct bpf_iter_task_file_item;
+extern int bpf_iter_task_file_new(struct bpf_iter_task_file *it, struct task_struct *task) __ksym;
+extern struct bpf_iter_task_file_item *
+bpf_iter_task_file_next(struct bpf_iter_task_file *it) __ksym;
+extern void bpf_iter_task_file_destroy(struct bpf_iter_task_file *it) __ksym;
+
 #endif
diff --git a/tools/testing/selftests/bpf/prog_tests/iters.c b/tools/testing/selftests/bpf/prog_tests/iters.c
index 3cea71f9c500..cfe5b56cc027 100644
--- a/tools/testing/selftests/bpf/prog_tests/iters.c
+++ b/tools/testing/selftests/bpf/prog_tests/iters.c
@@ -1,6 +1,8 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright (c) 2023 Meta Platforms, Inc. and affiliates. */
 
+#define _GNU_SOURCE
+#include <sys/socket.h>
 #include <sys/syscall.h>
 #include <sys/mman.h>
 #include <sys/wait.h>
@@ -16,11 +18,13 @@
 #include "iters_num.skel.h"
 #include "iters_testmod.skel.h"
 #include "iters_testmod_seq.skel.h"
+#include "iters_task_file.skel.h"
 #include "iters_task_vma.skel.h"
 #include "iters_task.skel.h"
 #include "iters_css_task.skel.h"
 #include "iters_css.skel.h"
 #include "iters_task_failure.skel.h"
+#include "iters_task_file_failure.skel.h"
 
 static void subtest_num_iters(void)
 {
@@ -291,6 +295,78 @@ static void subtest_css_iters(void)
 	iters_css__destroy(skel);
 }
 
+static int task_file_test_process(void *args)
+{
+	int pipefd[2], sockfd, err = 0;
+
+	/* Create a clean file descriptor table for the test process */
+	close_range(0, ~0U, 0);
+
+	if (pipe(pipefd) < 0)
+		return 1;
+
+	sockfd = socket(AF_INET, SOCK_STREAM, IPPROTO_TCP);
+	if (sockfd < 0) {
+		err = 2;
+		goto cleanup_pipe;
+	}
+
+	usleep(1);
+
+	close(sockfd);
+cleanup_pipe:
+	close(pipefd[0]);
+	close(pipefd[1]);
+	return err;
+}
+
+static void subtest_task_file_iters(void)
+{
+	const int stack_size = 1024 * 1024;
+	struct iters_task_file *skel;
+	int child_pid, wstatus, err;
+	char *stack;
+
+	skel = iters_task_file__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "open_and_load"))
+		return;
+
+	if (!ASSERT_OK(skel->bss->err, "pre_test_err"))
+		goto cleanup_skel;
+
+	skel->bss->parent_pid = getpid();
+	skel->bss->count = 0;
+
+	err = iters_task_file__attach(skel);
+	if (!ASSERT_OK(err, "skel_attach"))
+		goto cleanup_skel;
+
+	stack = (char *)malloc(stack_size);
+	if (!ASSERT_OK_PTR(stack, "clone_stack"))
+		goto cleanup_attach;
+
+	/* Note that there is no CLONE_FILES */
+	child_pid = clone(task_file_test_process, stack + stack_size, CLONE_VM | SIGCHLD, NULL);
+	if (!ASSERT_GT(child_pid, -1, "child_pid"))
+		goto cleanup_stack;
+
+	if (!ASSERT_GT(waitpid(child_pid, &wstatus, 0), -1, "waitpid"))
+		goto cleanup_stack;
+
+	if (!ASSERT_OK(WEXITSTATUS(wstatus), "run_task_file_iters_test_err"))
+		goto cleanup_stack;
+
+	ASSERT_EQ(skel->bss->count, 1, "run_task_file_iters_test_count_err");
+	ASSERT_OK(skel->bss->err, "run_task_file_iters_test_failure");
+
+cleanup_stack:
+	free(stack);
+cleanup_attach:
+	iters_task_file__detach(skel);
+cleanup_skel:
+	iters_task_file__destroy(skel);
+}
+
 void test_iters(void)
 {
 	RUN_TESTS(iters_state_safety);
@@ -315,5 +391,8 @@ void test_iters(void)
 		subtest_css_task_iters();
 	if (test__start_subtest("css"))
 		subtest_css_iters();
+	if (test__start_subtest("task_file"))
+		subtest_task_file_iters();
 	RUN_TESTS(iters_task_failure);
+	RUN_TESTS(iters_task_file_failure);
 }
diff --git a/tools/testing/selftests/bpf/progs/iters_task_file.c b/tools/testing/selftests/bpf/progs/iters_task_file.c
new file mode 100644
index 000000000000..81bcd20041d8
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/iters_task_file.c
@@ -0,0 +1,88 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include "vmlinux.h"
+#include <bpf/bpf_tracing.h>
+#include <bpf/bpf_helpers.h>
+#include "bpf_misc.h"
+#include "bpf_experimental.h"
+#include "task_kfunc_common.h"
+
+char _license[] SEC("license") = "GPL";
+
+int err, parent_pid, count;
+
+extern const void pipefifo_fops __ksym;
+extern const void socket_file_ops __ksym;
+
+SEC("fentry/" SYS_PREFIX "sys_nanosleep")
+int test_bpf_iter_task_file(void *ctx)
+{
+	struct bpf_iter_task_file task_file_it;
+	struct bpf_iter_task_file_item *item;
+	struct task_struct *task;
+
+	task = bpf_get_current_task_btf();
+	if (task->parent->pid != parent_pid)
+		return 0;
+
+	count++;
+
+	bpf_rcu_read_lock();
+	bpf_iter_task_file_new(&task_file_it, task);
+
+	item = bpf_iter_task_file_next(&task_file_it);
+	if (item == NULL) {
+		err = 1;
+		goto cleanup;
+	}
+
+	if (item->fd != 0) {
+		err = 2;
+		goto cleanup;
+	}
+
+	if (item->file->f_op != &pipefifo_fops) {
+		err = 3;
+		goto cleanup;
+	}
+
+	item = bpf_iter_task_file_next(&task_file_it);
+	if (item == NULL) {
+		err = 4;
+		goto cleanup;
+	}
+
+	if (item->fd != 1) {
+		err = 5;
+		goto cleanup;
+	}
+
+	if (item->file->f_op != &pipefifo_fops) {
+		err = 6;
+		goto cleanup;
+	}
+
+	item = bpf_iter_task_file_next(&task_file_it);
+	if (item == NULL) {
+		err = 7;
+		goto cleanup;
+	}
+
+	if (item->fd != 2) {
+		err = 8;
+		goto cleanup;
+	}
+
+	if (item->file->f_op != &socket_file_ops) {
+		err = 9;
+		goto cleanup;
+	}
+
+	item = bpf_iter_task_file_next(&task_file_it);
+	if (item != NULL)
+		err = 10;
+cleanup:
+	bpf_iter_task_file_destroy(&task_file_it);
+	bpf_rcu_read_unlock();
+	return 0;
+}
diff --git a/tools/testing/selftests/bpf/progs/iters_task_file_failure.c b/tools/testing/selftests/bpf/progs/iters_task_file_failure.c
new file mode 100644
index 000000000000..c3de9235b888
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/iters_task_file_failure.c
@@ -0,0 +1,114 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include "vmlinux.h"
+#include <bpf/bpf_tracing.h>
+#include <bpf/bpf_helpers.h>
+#include "bpf_misc.h"
+#include "bpf_experimental.h"
+#include "task_kfunc_common.h"
+
+char _license[] SEC("license") = "GPL";
+
+SEC("syscall")
+__failure __msg("expected an RCU CS when using bpf_iter_task_file")
+int bpf_iter_task_file_new_without_rcu_lock(void *ctx)
+{
+	struct bpf_iter_task_file task_file_it;
+	struct task_struct *task;
+
+	task = bpf_get_current_task_btf();
+
+	bpf_iter_task_file_new(&task_file_it, task);
+
+	bpf_iter_task_file_destroy(&task_file_it);
+	return 0;
+}
+
+SEC("syscall")
+__failure __msg("expected uninitialized iter_task_file as arg #1")
+int bpf_iter_task_file_new_inited_iter(void *ctx)
+{
+	struct bpf_iter_task_file task_file_it;
+	struct task_struct *task;
+
+	task = bpf_get_current_task_btf();
+
+	bpf_rcu_read_lock();
+	bpf_iter_task_file_new(&task_file_it, task);
+
+	bpf_iter_task_file_new(&task_file_it, task);
+
+	bpf_iter_task_file_destroy(&task_file_it);
+	bpf_rcu_read_unlock();
+	return 0;
+}
+
+SEC("syscall")
+__failure __msg("Possibly NULL pointer passed to trusted arg1")
+int bpf_iter_task_file_new_null_task(void *ctx)
+{
+	struct bpf_iter_task_file task_file_it;
+	struct task_struct *task = NULL;
+
+	bpf_rcu_read_lock();
+	bpf_iter_task_file_new(&task_file_it, task);
+
+	bpf_iter_task_file_destroy(&task_file_it);
+	bpf_rcu_read_unlock();
+	return 0;
+}
+
+SEC("syscall")
+__failure __msg("R2 must be referenced or trusted")
+int bpf_iter_task_file_new_untrusted_task(void *ctx)
+{
+	struct bpf_iter_task_file task_file_it;
+	struct task_struct *task;
+
+	task = bpf_get_current_task_btf()->parent;
+
+	bpf_rcu_read_lock();
+	bpf_iter_task_file_new(&task_file_it, task);
+
+	bpf_iter_task_file_destroy(&task_file_it);
+	bpf_rcu_read_unlock();
+	return 0;
+}
+
+SEC("syscall")
+__failure __msg("Unreleased reference")
+int bpf_iter_task_file_no_destory(void *ctx)
+{
+	struct bpf_iter_task_file task_file_it;
+	struct task_struct *task;
+
+	task = bpf_get_current_task_btf();
+
+	bpf_rcu_read_lock();
+	bpf_iter_task_file_new(&task_file_it, task);
+
+	bpf_rcu_read_unlock();
+	return 0;
+}
+
+SEC("syscall")
+__failure __msg("expected an initialized iter_task_file as arg #1")
+int bpf_iter_task_file_next_uninit_iter(void *ctx)
+{
+	struct bpf_iter_task_file task_file_it;
+
+	bpf_iter_task_file_next(&task_file_it);
+
+	return 0;
+}
+
+SEC("syscall")
+__failure __msg("expected an initialized iter_task_file as arg #1")
+int bpf_iter_task_file_destroy_uninit_iter(void *ctx)
+{
+	struct bpf_iter_task_file task_file_it;
+
+	bpf_iter_task_file_destroy(&task_file_it);
+
+	return 0;
+}
-- 
2.39.5


