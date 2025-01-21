Return-Path: <linux-fsdevel+bounces-39774-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64B9CA17E7C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Jan 2025 14:08:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B75B53A2E6C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Jan 2025 13:07:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 735411F239C;
	Tue, 21 Jan 2025 13:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="aTLdZmdM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazolkn19012028.outbound.protection.outlook.com [52.103.32.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A011F1E49F;
	Tue, 21 Jan 2025 13:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.32.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737464861; cv=fail; b=PcfX6dwDsWQwPnXEE8IK1ypdO+1iwHHQsAdvqjzRhHlNB7f5oIE2T1yguaESf0o4b17mRuQX0auw9kd/MtKbv7ckR2nahHs7Dbjl+GluwqYbLoTDXQnIEri9lln83cXvpNwc+vBCI5Nj5+Gzd2eaiZEPE1/WXqdGLVxa3OjZdnI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737464861; c=relaxed/simple;
	bh=G1gisU/KcagKgxasMBq0Yk+iS8Eo7x5MM2P3T7GbG+k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Izxn9uqE9lnagkXxU4e6uf95GIMnGKDROPXr1FubjzgA//py/AIaZf7CC6h5jXZBMVXA/eQ6Aqa+KpybQIKQFvNwymN59Ce0Pix0y0wuVFhfV7fHan16asfyK4WhUC5rqDU4LIn0AVqt5Ak+1Xhe0y82FebPLd6+pFPM5qXcyH0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=aTLdZmdM; arc=fail smtp.client-ip=52.103.32.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=whKrL+36uOnSjoIGReH5HTwlpORjr0DMy/E3f5Dzs7hFjmMNX+IqYv29x3BVeq3NTyqSOG3p7TaXnzM5GO7vRGyirOLMDCZ2LHuii66/WyxeDA1Pa/rHNHqZuQ1Fjbmz9Wv7eQEwbbhI7uHh+nKOR5pHOAQLtYfxnoujkMMc0NU5pISLa3AaNyLpqz9E/vraw6CsbFSoXtmb4sMhQarlzSdvl2JSp7QxETAwuJoxnZI29/EucbAOc3QHsQj9JByD5cHzPUlJZjyC8myu11gs53p9p09qbFNTf6V/ZOVRdqAT6IT0kRENbWUXF8Ao+/8rLRXtKPjMmixaM890YWKpUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bWgQjdDHnA4RZa6+dx7NN26Ptx9ZkimbWPcd5t8NZuM=;
 b=EQqlA+rPQxrsCaduDQkL3HnsDZFAUGo6WvUO/EO5CoF+GTeNXh9UFpP+h5XTs6mIXnoYv/xDsqSseG9vtirP0RXse1xSuQBB9StDB93CGqHitxzolfLU2lxkoK5gwhJGt2IO9YTB0fUaiMBLrZ/e0M7fHkTV4K1ZrwD1UhJiW9Uz0TPEohpYX3l0Qz1EZvNAhBdaj6+k8t2pnEDdEMswgt5hAIrXfAx5dGJjNUbWUmFn7zagFOhE2WXz39tCg/X1ZjJxE92FBWkid9kzQSGwQ7t0SqbftlIQy/ds5BMC+PtFzDpo/cyN0PCa8+9lww90Rr6LNtfU5G+HanYVLl5AQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bWgQjdDHnA4RZa6+dx7NN26Ptx9ZkimbWPcd5t8NZuM=;
 b=aTLdZmdM9g/MHiQFmn0FWfmUHdf+sIiI1RiMmYdtrb51BeOvUzYA/Haz/0H0ybv1bgeR7+HC/FvCI0kpZPGNPU9mJyror6ELc/t1AmRwP21gFoQDuOj/ApdikXJJQtmkPn6TXuZnNOF6fdTMj5s2FQ5PJovpCHJZXd9hRJmN8uTUkydjJsuxellvCmP0jLO6TfkSG2s7iLZ+PDUYhZAuUm7po04p4S2csbURwKGGTe57bg/rDj++Ah/2T6XLyxpyOVDHkN43EEPrMZQv6bZ2QgRG2ZRABCoM7VEDz5KV+kxCoQPq6l7jDZ6UewXIzYmTg1Lqp6OZldL311ldn+GX0Q==
Received: from AM6PR03MB5080.eurprd03.prod.outlook.com (2603:10a6:20b:90::20)
 by DBAPR03MB6407.eurprd03.prod.outlook.com (2603:10a6:10:192::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.22; Tue, 21 Jan
 2025 13:07:37 +0000
Received: from AM6PR03MB5080.eurprd03.prod.outlook.com
 ([fe80::a16:9eb8:6868:f6d8]) by AM6PR03MB5080.eurprd03.prod.outlook.com
 ([fe80::a16:9eb8:6868:f6d8%3]) with mapi id 15.20.8356.020; Tue, 21 Jan 2025
 13:07:37 +0000
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
Subject: [PATCH bpf-next v7 2/5] selftests/bpf: Add tests for open-coded style process file iterator
Date: Tue, 21 Jan 2025 13:03:03 +0000
Message-ID:
 <AM6PR03MB5080ED47911FD1837BFA942499E62@AM6PR03MB5080.eurprd03.prod.outlook.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <AM6PR03MB508004527B8B38AAF18D763399E62@AM6PR03MB5080.eurprd03.prod.outlook.com>
References: <AM6PR03MB508004527B8B38AAF18D763399E62@AM6PR03MB5080.eurprd03.prod.outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P265CA0260.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:37c::11) To AM6PR03MB5080.eurprd03.prod.outlook.com
 (2603:10a6:20b:90::20)
X-Microsoft-Original-Message-ID:
 <20250121130306.90527-2-juntong.deng@outlook.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR03MB5080:EE_|DBAPR03MB6407:EE_
X-MS-Office365-Filtering-Correlation-Id: d183cc2f-8b3c-47ff-4c48-08dd3a1c93ab
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|19110799003|8060799006|15080799006|461199028|5072599009|440099028|3412199025|41001999003|12091999003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?MYFdjEeh6Fkrh7ejIaFmY+Onad44BqCVqWi5HhNJ8Oakx//0EaweRTMHtwQY?=
 =?us-ascii?Q?4jR7643aS7717RvYtzm/MU/1/7BEK5LDgSCD5bPYdVgWewyfDJutpGhTuqh4?=
 =?us-ascii?Q?9zowrRkLaEZmDjyOIpNTdiltLCPKbwBgA6BHvUFQmzf+e3fAlR149/ZR/z19?=
 =?us-ascii?Q?dkUesRBNSCjbbpicevtnToxZ0H8chT7p//dG4KegUNKrxDXLCp00kyrsUPjE?=
 =?us-ascii?Q?YMrRvU0IT1xwk353HEs/y2Z4nyG64V5+MpvNVX+sPwBzll99DD1oslBDeoB9?=
 =?us-ascii?Q?rP2lAZZGZ4i/+DpYk++DWbHKTmyCQnj6xiG+rTSDKAb9zKaYIIUD+dVVNY0I?=
 =?us-ascii?Q?IjB3vZvLPJ7WU57N1p/utXN8YLSeTPRtXQAd0bgY9cux3Wzzux7lGulWlbwG?=
 =?us-ascii?Q?P+lxEF8WNF44G4DaCPa7OSrlClDc848s0kgRrtblSFKZrxCtU25kHwC9Ngja?=
 =?us-ascii?Q?HbL7jYtPAo/fHhDwrA/UOszDT9wEKFauRVbrct4uWIWPQnPQnferqPGiGXHO?=
 =?us-ascii?Q?2A1KI7PbD0qMDTJcfVeJC3jfudnNqWr6GmuGO/6uyqYRwuUwnuDMu8emrpYa?=
 =?us-ascii?Q?B00178ItxsmsnjNfKZLRfZ1DPX8punLAc08hhFK1besfajFPyln+9a3smGfq?=
 =?us-ascii?Q?Fhww973aNlOCLq7h9dmV+4ECg4g9Jkr20oA/0SAFIntVenLieDkPbUX8nKPn?=
 =?us-ascii?Q?geyuViHHXP5MXFqG61aBdnnDwqfyA5K3v//JhKylA0uIaoXMXDAMHBiiLNZO?=
 =?us-ascii?Q?ET0gq09e+LPQbbYzBz/9HCTv55PBWR/6PXmTH+8whPpNyQW7RyFJu15LCdnu?=
 =?us-ascii?Q?NR6u3fvFsHyPM9k5r/KBGPlxxYYQKiMAlNuWxOoNapVdTNvLd1IyZrx/7SJ1?=
 =?us-ascii?Q?TmeV/zQXJTNQHVZ91uUNAKDHa9VM77IxWm9+dxi+tsvCG2fN/dGL8Xiw/9Yt?=
 =?us-ascii?Q?J7i2mi0J3aqfNg51JLfI7/Pr8DFdk4CT2CkPbGcUkNsJ/ia25StuoxEx/EHN?=
 =?us-ascii?Q?k0dcUfKuP7Iwav9qgf2zvsotYP4S9gl7gvYyl+g5q12cHdfdyVPFAd2RtZo/?=
 =?us-ascii?Q?ZBs6X4Y0RvgjDHHAt7Eg1FuS618+4UburVnpfoErJRoTM1blEX4=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?iJ8ulNEM1Lq9nY7ZD6zHXnNrQ1w5NDMMYfQJvG2W1Qc9F8w5OQdpr9hH26+D?=
 =?us-ascii?Q?8GUlVHOhw06GQrbHysrD7jvJ/OT0kD+k4+Kikfa+1/on9/rTUkp64bTe4B8h?=
 =?us-ascii?Q?ZxZgtM1GLXf+UWkIaN+xdejIPGET/HkngAYlpiPuwl/lpQna6LAzP5uVt79W?=
 =?us-ascii?Q?pfKyZkCdxOF8Oq5MvN1fzSfEiqlanTFdPoDdNmVTyGDgwN24jYZwEnZhO1+f?=
 =?us-ascii?Q?rxuEeh0XO0lWzwR+EVqP4ycfpnNyAW37dRag1+lbTCpdU4sIwYuvUiGoPxy7?=
 =?us-ascii?Q?FNExEpqxTBDiIPmoUFer6NaS5hikK/nJ772UHTdyi/0Uc2F8lwUHdvxMT3UI?=
 =?us-ascii?Q?dS4IqTzQkX4agHFcYdTIW+y3wQrzAts8odDeaePJLAd6I5Sq+oH//5tDPwry?=
 =?us-ascii?Q?VnLUbB/L4XdcOy9DLxTxYU81I3i2eGwd4mxpnvW20CjaRZhEBsPcwFmSe2Yq?=
 =?us-ascii?Q?affNSjsbrDODt3VjwGWVbXJOSe/jMqjZ/tfgR7QvpW54rBqmlGqXRtb8ZeNI?=
 =?us-ascii?Q?G7+Q6vYGazXMEbI39U1vNUJQhPctpQFJliM7PCTddWmKqYwFj1vsYDhmCNAo?=
 =?us-ascii?Q?TL8juNNukdeOsZPPTvOPtTsePOzX8uq7gDpTjD7xN4Qk5VdWacnv8IG61eT6?=
 =?us-ascii?Q?+/1ocbpyduN/7xDG0LF9Yj6yzRVJGBbvIwIKJlkXEQaJGiQ5uSvXDFlqCgyo?=
 =?us-ascii?Q?qSnU2Qf5ORl2UT6oBJ57k5G2mJDJnTfASa+bzfZpKARRYdNQBdVDFUy23cR3?=
 =?us-ascii?Q?gT5MiVONyjHQJl5zDGP+jCajUgzvcsnWuEFx20/ni4lvUCdt1iFmJUcRv4AK?=
 =?us-ascii?Q?b+ts2bRjNxDAEYGwttikitw8/VvvApQ7xb9Rh5VeY6UWYfLo1SWcQvZjeKtG?=
 =?us-ascii?Q?DeSOI6dzGXYGkNPGj8cX/qxX7FerOnNxgjJo73w8Ub5Q6DuqfTuYU39Dvcde?=
 =?us-ascii?Q?nKaQ3BhyMnxTbA0Ek7tkEDVNaEyrLhmR3QjcJyrZYPg0B9zIgygf063MYZIU?=
 =?us-ascii?Q?5zx+XlpYf93vZjjcsToyEP/prFuSG83pFqlY1UBOMzQGsYSwSixKIXKeD0jq?=
 =?us-ascii?Q?I0IqNdeJ43EuwzlblK40FRANUT//D5QEb7ZYFbbKyhi6V/qrSaD3S6KNmxXk?=
 =?us-ascii?Q?tg0aKc0azoyh1YaF27PF+iBqjKyKVob4qu/hgn0dSSxyL5fhDMJmHai+7hoT?=
 =?us-ascii?Q?xgb0W1JFgM+mVdlhMJRKQIwBMeF7M6ULLrd1GUYwAJG7UlWhjpSvmP53BTHf?=
 =?us-ascii?Q?IZNBXvybEgX6/uY9h8G+?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d183cc2f-8b3c-47ff-4c48-08dd3a1c93ab
X-MS-Exchange-CrossTenant-AuthSource: AM6PR03MB5080.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2025 13:07:36.9834
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR03MB6407

This patch adds test cases for open-coded style process file iterator.

Test cases related to process files are run in the newly created child
process. Close all opened files inherited from the parent process in
the child process to avoid the files opened by the parent process
affecting the test results.

In addition, this patch adds failure test cases where bpf programs
cannot pass the verifier due to uninitialized or untrusted
arguments, etc.

Signed-off-by: Juntong Deng <juntong.deng@outlook.com>
---
 .../testing/selftests/bpf/bpf_experimental.h  |  7 ++
 .../testing/selftests/bpf/prog_tests/iters.c  | 78 ++++++++++++++++
 .../selftests/bpf/progs/iters_task_file.c     | 86 ++++++++++++++++++
 .../bpf/progs/iters_task_file_failure.c       | 91 +++++++++++++++++++
 4 files changed, 262 insertions(+)
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
index 3cea71f9c500..f400aeb91cba 100644
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
@@ -291,6 +295,77 @@ static void subtest_css_iters(void)
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
@@ -315,5 +390,8 @@ void test_iters(void)
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
index 000000000000..bac1d616459e
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/iters_task_file.c
@@ -0,0 +1,86 @@
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
+extern void pipefifo_fops __ksym;
+extern void socket_file_ops __ksym;
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
+	return 0;
+}
diff --git a/tools/testing/selftests/bpf/progs/iters_task_file_failure.c b/tools/testing/selftests/bpf/progs/iters_task_file_failure.c
new file mode 100644
index 000000000000..f7c26c49d8b4
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/iters_task_file_failure.c
@@ -0,0 +1,91 @@
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
+__failure __msg("expected uninitialized iter_task_file as arg #0")
+int bpf_iter_task_file_new_inited_iter(void *ctx)
+{
+	struct bpf_iter_task_file task_file_it;
+	struct task_struct *task;
+
+	task = bpf_get_current_task_btf();
+
+	bpf_iter_task_file_new(&task_file_it, task);
+
+	bpf_iter_task_file_new(&task_file_it, task);
+
+	bpf_iter_task_file_destroy(&task_file_it);
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
+	bpf_iter_task_file_new(&task_file_it, task);
+
+	bpf_iter_task_file_destroy(&task_file_it);
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
+	bpf_iter_task_file_new(&task_file_it, task);
+
+	bpf_iter_task_file_destroy(&task_file_it);
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
+	bpf_iter_task_file_new(&task_file_it, task);
+
+	return 0;
+}
+
+SEC("syscall")
+__failure __msg("expected an initialized iter_task_file as arg #0")
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
+__failure __msg("expected an initialized iter_task_file as arg #0")
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


