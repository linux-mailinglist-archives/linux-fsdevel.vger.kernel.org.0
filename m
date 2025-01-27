Return-Path: <linux-fsdevel+bounces-40178-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CD03A201E6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Jan 2025 00:49:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C25A162A38
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Jan 2025 23:49:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D54E1E0DE5;
	Mon, 27 Jan 2025 23:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="oro+vOkg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazolkn19013087.outbound.protection.outlook.com [52.103.46.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 365371DF759;
	Mon, 27 Jan 2025 23:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.46.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738021775; cv=fail; b=GadpjWqUfyMW0bUoa1iWluBPQYL2GStVw+RLczjRS025rozK4ITrZv4TWutze/koNxRz6PkCNnlYH5+Lun+XC2FaSXbIcqVQP9OnqXqR0E6poBoDx/wT5GICTsWGro2J13Ps1+Ce0xSFmqf8tnWhW1JAXdti04KccFib3IFaa+c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738021775; c=relaxed/simple;
	bh=bQvl4lkjyGDdnzyE0yqokIgHouZBcQgDSgVAA6fyKLM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=D0mtf81wxstcBhx8GngAmonLS0fT06QwBXytiwysXpKCrdAWs4BY7rDj8kM+ZE8pKAdEcUT0P1lkEgPpqV33oVZuFy25UoVNSQ82HwDXcRBqb8K+nUI64AyEbFxfpP29WoSJgTIOf1CHP3LDhifspZnWmzvhQUVY1NrgsfgjEtQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=oro+vOkg; arc=fail smtp.client-ip=52.103.46.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T6mpJBvq4zl/X0MHoOtmlBDr/YPepxXRDfmIHMlkmXOQ8s6P1f9Dwd96SmbhnBX1WbXNeKq2sRTTtWKm0bNzIzsm9btctZcZO1CORe3rWP0Goej1E4jdzZVMy5ieWKXrz8qYIRr0gy19SzbhdyedPfmNPPm6ynX0SEoDCeSOAcWD6AMwR2vu66rDgBPx5yIOjKb6UpJFu5jr1ZGYtTESmSZrtJWRkzuS98SzhDN0vAvPlcLariAXp4DrZ4z9/BNc18ZIq4LjHqAiptTNS01p5zXYoTMgGdOaugLt1ayp7wC4l2XaNdfqWLccPrjYk8MweVPrjfh6Ou/2IzmFqitQGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WKkDboDq3HnOsNL8iV3Vs+SvQfWo5LYPgipnektaNu0=;
 b=Ha0NpNabSeaIAbT0qhIr+FAI4atvu+nUCOHII9prjh04nUf/up/L7j/ovS9BdS1dWgJJFHwYQcBvjbRWfmo7MMufHDUdNGEf//94aZQIvNfQxTMWFAGfAJ8lgRmJOlRC6z4BzLPRHmEh7CVpsKfFGLjhdOqptKoRQbV83CVLBeoERuprEgEnCju2ge9gYi1o/sssDl1IWnf1yUjNQ4e+t7wxfbTiDF5DQsbyLS0uGyvlKzQEYIr2GErNu0zZiEMMwJi7/gPx9vRbkH9Rh41sDswwVndk2URxQ7A3W3FaeSrxEkYbi8ncULjX87Sklq8j0gapo+lNaXAEhxd+fnvGiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WKkDboDq3HnOsNL8iV3Vs+SvQfWo5LYPgipnektaNu0=;
 b=oro+vOkgxRQq3JDeE2jXCg0jaoWuz3pPC8edE4klTyS7lD0rng6KctE7SUb3IcYCWW1i3UgS7hqWhE8DAa/Bxff1ggxnbMutt6KZFmClNHkoAOhZY4v9K6Kbi5saVPgW5Fd71C2T4s/JjN6DTlJaOi6qGUVOXZlvg4LDJPCkyR0LlfQ0PBOHQuwwqQdprpi0pim7zIb+RDzfauxl0RmWNvjwpvsR3ZqBy+mPOcACFUIHBBuSgGhpBNvwRlyyWNv+Eu1HM0/LHTDs7LKi5jTJC/bEeS7iTa17NgsN9gWjM1DWvQdKC1H22rZny0pIKJjjT0ZRtQQgcxEA9NiLoi90GQ==
Received: from AM6PR03MB5080.eurprd03.prod.outlook.com (2603:10a6:20b:90::20)
 by AM0PR03MB6209.eurprd03.prod.outlook.com (2603:10a6:20b:156::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.22; Mon, 27 Jan
 2025 23:49:30 +0000
Received: from AM6PR03MB5080.eurprd03.prod.outlook.com
 ([fe80::a16:9eb8:6868:f6d8]) by AM6PR03MB5080.eurprd03.prod.outlook.com
 ([fe80::a16:9eb8:6868:f6d8%3]) with mapi id 15.20.8377.021; Mon, 27 Jan 2025
 23:49:30 +0000
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
Subject: [PATCH bpf-next v9 2/5] selftests/bpf: Add tests for open-coded style process file iterator
Date: Mon, 27 Jan 2025 23:46:51 +0000
Message-ID:
 <AM6PR03MB5080079AFE8697A377D1A1E199EC2@AM6PR03MB5080.eurprd03.prod.outlook.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <AM6PR03MB50801990BD93BFA2297A123599EC2@AM6PR03MB5080.eurprd03.prod.outlook.com>
References: <AM6PR03MB50801990BD93BFA2297A123599EC2@AM6PR03MB5080.eurprd03.prod.outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO3P265CA0018.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:bb::23) To AM6PR03MB5080.eurprd03.prod.outlook.com
 (2603:10a6:20b:90::20)
X-Microsoft-Original-Message-ID:
 <20250127234654.89332-2-juntong.deng@outlook.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR03MB5080:EE_|AM0PR03MB6209:EE_
X-MS-Office365-Filtering-Correlation-Id: 0642f07b-7269-4f51-0b48-08dd3f2d3dde
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|8060799006|19110799003|5072599009|15080799006|461199028|440099028|3412199025|41001999003|12091999003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Dj55CO+jhQ/hrrtqFdd9BhO7sDqxdHVLiY9cDebVKxSsHBS06lGb9lKMrBDb?=
 =?us-ascii?Q?2r3/GVrnoNvubHcbT47LSOAPmOdXheGx9q1tYNN28zO8EPxxiLdFzVAMb6rc?=
 =?us-ascii?Q?AVUm+IhDJh/28m9pMyg/3tkfR3boNW5/q9AUjaUIWXv9OTvzcGNna6R/Xb84?=
 =?us-ascii?Q?XC9i2s/ZEKmZNDNaevRWqvQJa6wEiZG8Q117erEPoZISGcgB5H77J9DP6byg?=
 =?us-ascii?Q?nvT7/iXaLgN3vhgzMJQyvGsXvddjrX7yTNqbZB/cJX7MU0jgMADcm6tZtqrF?=
 =?us-ascii?Q?B0JwiL/j3KOLDrTmxrShAG3upzg/Nhs4gfYicTA91vvi2U9YJdpjcCAb2Xb7?=
 =?us-ascii?Q?fUQ5nLgmQvK8xHs7JhlZDiPm7+5mB6qZuNmCxEpwhyFzGv2EN3YoAsxr74aR?=
 =?us-ascii?Q?Q1kCJK03F1LE5qNf7QLMobcDl7Z1g5e3ARwwJ5HG/f0JyWM/e2V1glVc1Nxl?=
 =?us-ascii?Q?bQ6FfQYxJXyc6PqfAmY1d6LmiLEgM8mJZ2ls48vEFct78XtG8Z15vrAzKcjS?=
 =?us-ascii?Q?KUpon7mhA/x29LMLyKyz3bOc+GBESEkHn0srt+si1DTkrIuu5ugv12itDQWu?=
 =?us-ascii?Q?1LgY+XvxyKVye0Ay394FV3PASfZmbl/s3DVKfvQkqkR/gUDWSo9Nj4bg3VLr?=
 =?us-ascii?Q?AAxkUdC1XFQmu/1eYR2YWm/HIs8srDNiw/65wAjCRIHfvlctvEe5INrB4sSn?=
 =?us-ascii?Q?eYE2hi8H65T5sowEDhZUJG1yiDSTraSbJzTKXhe7zFmJev3/aBjuyFvS+bFm?=
 =?us-ascii?Q?Y9C1Ool5Lqm709SovM3kmAnQSWN7tIyqC2FI5LV7A7RU/uHsPSGT4QM8GWJj?=
 =?us-ascii?Q?7/edqvFe7Xbv/m7nisu+FomAskYuFnusTal9r16Ruo/dVkxd1vmgVFs8BIq6?=
 =?us-ascii?Q?SawnKUnP4xA/hKmdsLMIfy3fORoZDKEhJsqdkpj1u4/YS0hPsXg2DdqVqw+Z?=
 =?us-ascii?Q?VysLRU7uU8AqRgktc57SkyJ/C1+n245U9+hE3WzmW+IWJ/HX1pEjnBVSiRxV?=
 =?us-ascii?Q?SbU2h5W6JSjXpc+oQlksXss1XiRjO+feF+7x/1ftk4tKofjXfPDWWUaZCuyd?=
 =?us-ascii?Q?JaQYYyVOfRHqDq/uHvFUGZTY97gHfZ1f25s/5Dpkq70tMtEnans=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zJpOUUnaCKs6CklRfCm22t9ZiZG2f4Zu8P9FVPlJvuAyVgwoljsrbZW/zKvg?=
 =?us-ascii?Q?lqBagzNFrBe0GEbxd61rNcRsY8sr2/FiM+VnxWm7N5ifCyN5IwRNo5kjq4YW?=
 =?us-ascii?Q?GggWI+hWgTe58pIrbOmH6me4NjLBgVMgn5/FKtVq9I2w+jsIb/0JEdBxvqp/?=
 =?us-ascii?Q?GLpyco/CleRoHcQQVkkAXXggIcNgOxoONbALCGRk35zpJLxSw930kfq2ag+H?=
 =?us-ascii?Q?Z8N5yGR790oNN+dK/NNfjQdmyVl9dUcYltOsguKvqjBa/u3cTHt6TkLPUX4d?=
 =?us-ascii?Q?NRP1AhpkyX+yaTcIRIveTWJG2g5pyC17B0D+t9vP6ejg2pOfyuQL/a2DwR2i?=
 =?us-ascii?Q?87+1pioU6NKyTtCiib+q9dJkJS/Yrjueei0rgk8Z8I8z1WrCnRZDwAiJyTlj?=
 =?us-ascii?Q?f2sFRYAPQF8mwD3rmTHr0U1iahw6Qk6585+PbZ6KFmQf7FNbvKe8QLci+5va?=
 =?us-ascii?Q?EMlej+UxNKkB93DC2GGPHlUGqRe2Nd4HkwgECwInohvGBVT4E/UgIZ5RjU+G?=
 =?us-ascii?Q?ihYs/UQN1og9qFjREMh7TB2YWi+xcgd+v5vhE7xAU2Yn/16fjNxKHTqLUy+l?=
 =?us-ascii?Q?Vs02kULqOUDEenv1iPiUA8qLkheOgmZQja82qgZ1aF5Lzl6sJD0afYUL3x0D?=
 =?us-ascii?Q?+JbX8HiTNKAcxxEnIirFhULpQmXb+hzALHryhdZ0VJ8Qi75wQ7H51yxuIxJe?=
 =?us-ascii?Q?Y0dxkM1qqlNj+rgxEFjBSQc9qyMaubeUuflvIKAgMNSmcRPbJ5vArekNMYmj?=
 =?us-ascii?Q?w0wWZ3w6yxuuD4YbCp4zOfK/APom/PF3vV99YG3w8qQTpznfzjq5eNb3Q+SR?=
 =?us-ascii?Q?JA005E2fQFRFNHLbE8RFnRVaGnqGQBL9LTwshB9bTVpUN+jMq1gpNw0MVhQe?=
 =?us-ascii?Q?PWMGHpg1fAB2K9NZ1IpiTbgFLuJvG8VN4Y90/r8s65O6g+0DsSepoeNrBOzW?=
 =?us-ascii?Q?Zh/G7xy5mVq7Nu59ZzvbrO63qaXISkWtZoMrlNNBheEGYZ7Icxba6ek3sZVU?=
 =?us-ascii?Q?MBMn62rFxfnlDSvGU1ypKCHdqrN0gdrZXak17EOclJ7JY6F43FhRtuupfCRI?=
 =?us-ascii?Q?5lp2iNPf9NYx0cj2KK7c8IdGIy8spj8IVS//M4k2nPpsRQLqVuGrYj3KzGSH?=
 =?us-ascii?Q?TpM/tpP5wzkfFfp3nyiv/A++pnbF4a44srAPLgPUottm7EEKrNy5g+Tb7viX?=
 =?us-ascii?Q?HmEYgJEV1FK+/ONTflvzIEp2wbKQeV2MNUxwocIgGW8KitaRJ4Me69px3doE?=
 =?us-ascii?Q?6TqpIAPtNCaEc5T8QLAX?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0642f07b-7269-4f51-0b48-08dd3f2d3dde
X-MS-Exchange-CrossTenant-AuthSource: AM6PR03MB5080.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2025 23:49:30.2885
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR03MB6209

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
 .../selftests/bpf/progs/iters_task_file.c     | 87 ++++++++++++++++++
 .../bpf/progs/iters_task_file_failure.c       | 91 +++++++++++++++++++
 4 files changed, 263 insertions(+)
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
index 000000000000..cdf81ae022a0
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/iters_task_file.c
@@ -0,0 +1,87 @@
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
+/* 'const' can eliminate the "taking address of expression of type 'void'" warning */
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
+	if (task->real_parent->pid != parent_pid)
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


