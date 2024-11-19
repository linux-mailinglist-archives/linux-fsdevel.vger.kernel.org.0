Return-Path: <linux-fsdevel+bounces-35229-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D914D9D2D22
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Nov 2024 18:55:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 67EB01F21F8B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Nov 2024 17:55:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 982221D2704;
	Tue, 19 Nov 2024 17:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="GSF7Jp7C"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazolkn19013087.outbound.protection.outlook.com [52.103.46.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEA8A1D1F40;
	Tue, 19 Nov 2024 17:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.46.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732038932; cv=fail; b=LpMlJAxB4mRpNFaF1pV9NdGyf6iFJWtV0n8oguOwZC8i5ZlFeipADfVoGkMfEFLGTHz7xDRfir44PWWOGHTu08V2kv14ax1z88nIqQkOZZa62E+bLggxMxVv2LE5hBIUEmYL1HL0/zlG5+tcwAMMd3ZS0KNbWRG1xZVY3wBCt70=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732038932; c=relaxed/simple;
	bh=qeRx/ElKW42WaCfHdn1+zez5cmtptzdhTZ21JSOEYYo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CiwIFeHslCI7BcEMkR1kuozns9tnoIH0hgMD7GiWesRfUXxv34XfAHvtlp/XndA29p8d/ZdQaerkQmbs3OmjhYREg6RtYg8fkWDdV8WHIOY2NkUdSz19vTIMUgnEsdh7dB+vlDpc2RIpnBRVGZzV4oJ3O3hClSKGHUlJaNdfZq0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=GSF7Jp7C; arc=fail smtp.client-ip=52.103.46.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ou0wV+pz98l4ElxN3Yp7gS2HLobIZB7V/KXyjR+0EBHsJ5hwJDo/xewnJ7it5CfrPY7kNnWNqtbkcBq5/KYuK95dUb3YRDkAxI68oRMDFuwFyatZd/FPAQJ88A49mxg6JQI6MenFRk8904bpdZdBLMQgJ+ywy73fHXaMa3hJ5wD/xIhNETKrV95ndy9Q5vs5n4w+ebfYx6XD7G6SBjb1MMBNVwqJjF9srUMhSnnksItJb/VRG4MI6ZP9+sx6OUG58HT6u68QmLoc/N+S4/NZ0IcRZp2HLbunwqMUSOAOFRrvLXTVmiO9owORDmzc6b5RZgipx2p2sRtQ1BUOo58R4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b0BwRJvJZKTDwMWv9+DLauZ8Ea+GIe0lmNITRlWXxUw=;
 b=w0HLiLvkuC7yM4SFp3gUdDDifn3gJjhUpFq8ZniZ3MYxWmOubeT2xoKgvfB8apk/xjL3i+6uttOav6BtqVWG3a2N/HLBxMX12+ej3SWyB6RM4/yfVcEie/qV25pszpoYBE2oq6vHXywPDixYG1VXj9GY7JnnPPB1bb+vGfvNEyKC3BzYCj6QJ5giH83MFqNqTmLXgUysZzrXkIhks8hdxnYvEdSKiudcTPaB7zCjyejMIxTWOUw4Jwdn17nMAdfkPmoczP7BxJfNzmjW1MByn37Kfu4ATs2JDWwq+78RCH3jlTCo4gMJqAyzmqB/CMaXle+7Z0x9nG7ucXVktL9frA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b0BwRJvJZKTDwMWv9+DLauZ8Ea+GIe0lmNITRlWXxUw=;
 b=GSF7Jp7ClGTGU8Ifn4z4lGRHW4xJT1tVEn6kemSkcEdP9bvUu5GeQm4YBc3HmE+9QkpMxWRIUSMRJWoWoqLyXEGtX3TWYuglo2cYuULTbWMg8qqdgta/xZdc5MILMdfyMiPAd4J1By6zfTLB56JOM9VeM0zmml2Gd6y4k1QtSUUKavX9HZum9D3QK4QfhQbO4BbDAx1yQe4Dk/RKkFFEr5JCOF/qBmN7TKVRmpGSViZYr4ANCKoE1+NYeaFuUCSIaWjqctK5A+3NjZhPn4n8vd8S4CXvhCGtcwFjiSrQTKzTnXMXA5EMMIKu4nEPflJR0mwTVaq+9JCH7V+nDLXhUg==
Received: from AM6PR03MB5080.eurprd03.prod.outlook.com (2603:10a6:20b:90::20)
 by DB8PR03MB6170.eurprd03.prod.outlook.com (2603:10a6:10:141::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.20; Tue, 19 Nov
 2024 17:55:27 +0000
Received: from AM6PR03MB5080.eurprd03.prod.outlook.com
 ([fe80::a16:9eb8:6868:f6d8]) by AM6PR03MB5080.eurprd03.prod.outlook.com
 ([fe80::a16:9eb8:6868:f6d8%4]) with mapi id 15.20.8158.023; Tue, 19 Nov 2024
 17:55:27 +0000
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
Subject: [PATCH bpf-next v4 2/5] selftests/bpf: Add tests for open-coded style process file iterator
Date: Tue, 19 Nov 2024 17:53:59 +0000
Message-ID:
 <AM6PR03MB50809E5CD1B8DE0225A85B6B99202@AM6PR03MB5080.eurprd03.prod.outlook.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <AM6PR03MB50804C0DF9FB1E844B593FDB99202@AM6PR03MB5080.eurprd03.prod.outlook.com>
References: <AM6PR03MB50804C0DF9FB1E844B593FDB99202@AM6PR03MB5080.eurprd03.prod.outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0187.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a::31) To AM6PR03MB5080.eurprd03.prod.outlook.com
 (2603:10a6:20b:90::20)
X-Microsoft-Original-Message-ID:
 <20241119175402.51778-2-juntong.deng@outlook.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR03MB5080:EE_|DB8PR03MB6170:EE_
X-MS-Office365-Filtering-Correlation-Id: 98ae0139-e300-4008-0f49-08dd08c359dc
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|5072599009|461199028|19110799003|8060799006|15080799006|440099028|3412199025;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?237cxXW/ELxi5VkZAHqoC3uq3wdkD2RODPdT14a8wZj7iHMyakeqezO5uwOC?=
 =?us-ascii?Q?9gWBuL+as85e/lXkNUOCfUjIqcx2ZdlYyZcAMNGG1DDRVGx0fBp30bLx1xB1?=
 =?us-ascii?Q?dsfTP/58cVvFWtxdABbtTq9Gq4jR6QsWlW8wlX4Bjo8Shg1IAEYPFhLotYME?=
 =?us-ascii?Q?5gSB7PrIdnUjfTm8c8zYWq6+h8uU0gwWnls1ORC30qlvzA7LEy2dIqIeANw1?=
 =?us-ascii?Q?LGIEPaxrd8GP0Rpyv7ntmCZPMaNxff31C+MaPiiPg7RT2zq/9WWjxmW2kO8t?=
 =?us-ascii?Q?xaJV+yHBPGh8VUx9Ztir4LVYQLplGVEEEekKrfhpHvpMjzy6mXmIMHeJwrg6?=
 =?us-ascii?Q?/ZrPtI/DyScifV74c00BgflXXijkEVDfEN3NB7GQhq8fcfglJggG1emaZyhp?=
 =?us-ascii?Q?znVVc1tHcxNx46hWO6AnqIRGcs+sa5oycdrXkB04dIERlnHcaepH8i2nNLvi?=
 =?us-ascii?Q?UQrZr12ATUO3bu/5AnNeDNUbKW17ukUXdSo70Vq80Px3RUsrE1BmpRVEcj0V?=
 =?us-ascii?Q?0VE8LjVFypThHV3nO8GbbKXYWNeMiGmNFqk316uWfQQiII/tLazAYAw/CFc1?=
 =?us-ascii?Q?etOTwiWEfCUsVUw8zdzQgOZGJvm3PAleotRt4XRbf4boH1jBGxr6PmCuKAuh?=
 =?us-ascii?Q?bf83mYnMQUGnTMcDLRuvBIPBe7PWfD9Uztkoe+cEQaW0o+lJNqNfseHbT0ee?=
 =?us-ascii?Q?wZjrZrSusShVMCkP3QD/3jAUQGnqD142/C0FdqdEjmsYB9tNX9xJikG230Lh?=
 =?us-ascii?Q?wj5TrZyKoIuS/dsL1B6tlUSyTcAM8Wlr2GGf7RYKZzmNWiOEYAmLeM1+6Hye?=
 =?us-ascii?Q?9BMcHb+I81hArvO6n3NO5x88rvVzTs+Shodpici/caBHrncmf4pJ5t9OHlk2?=
 =?us-ascii?Q?nEMBejrQgDfhYFxqFZ3l/goqpFjr+t3WVqKM9o3WfuAHtGW/4g5GI1WCcw42?=
 =?us-ascii?Q?kla6AuPaVXGL01q9+bc6+gRDNWDzOKZyThW8EBa3Q1GR1wZkTg/4tRTWzcG1?=
 =?us-ascii?Q?HUCGLYnCFzNEsdb+Rx1reul11A=3D=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?HzSiOnHaQmvwK1HaWghEvQeWc/jgpFmaIwicF8K6hJTm/RuPMk5935mVQN6x?=
 =?us-ascii?Q?YHCikAoQZsyZqDgFH/d5v3xmKScU3Tu9H7D3ae15wC6Whwy5lI5bWfMaiVmp?=
 =?us-ascii?Q?RcJ9GcdPvlySrhvERiAWsUdxOc9vrugl2QjAb1NEcCQByFj/FfFsxVu1PkV3?=
 =?us-ascii?Q?U10IXEeRJYCm+5Ui745/0gYkE16VBf7B+7QUpdhCm9E9kZvc/Y7UsACXV4lG?=
 =?us-ascii?Q?/zVugeKwZw6ZKQbxM/6b0kQu5tZbKaFkKhSl0oDJ70wSrhDOIHYSwN3Jfoay?=
 =?us-ascii?Q?EbGIqeyU8rkG4C1ouLs9wlMVkSjMNnwyq5Kh7dG7HohzX3MJVnSEaUfew3ag?=
 =?us-ascii?Q?Rt6uO4dzS3Elq3GKvpulSak7HSADUstOMI61Kv6/nSjDFFRXn3jRQlF2ilR+?=
 =?us-ascii?Q?5mZext/dxQKPocxlgydHJTr6TuuRCYK59bXZlSodPo5LsBZPy0OtcoYhTQ1P?=
 =?us-ascii?Q?qhV0UF05T1jHzuCHh0K8p8UuDRivfGhTQRCZMa/8lkcgJL1oV4gswieGjx1M?=
 =?us-ascii?Q?nUSstqppGIr7jBtGcnWdbXTW/o+jVApXwKmuLoiyu41rC2LHH1u1ZtbZCfQ4?=
 =?us-ascii?Q?34KruEG5h/POG0bYM4NrNmFQCIiJnMzV1uQW4enGmAQlY2brCbRXbbtevvJW?=
 =?us-ascii?Q?vAI7APcsjQi5vlN4Sa4ZaX5hne830fmhqrjb1cNSSaK3ZZDbBHBPzwcxMuBi?=
 =?us-ascii?Q?MypallJCCh9stqe0wp/7sGkFWPXRMXvPdodUGon3ZPWvhnORgfCpkGZfIw4q?=
 =?us-ascii?Q?b6Tt1XV2gAYhDiBCx08C/rfB7MN76WcaBT8oRq8t8klQEQdnr3KuT1IzNoHf?=
 =?us-ascii?Q?3GCPQwfCmk7zy8XWAN02zHCzDNiNfI5Dg0LIMGOqpxftSLzAGE3xaPC8IM4h?=
 =?us-ascii?Q?ccBGmaQRzkAiM95myjFwaBeeV7PNQ711SC+KccbWyfIZ6EKQyCV0AjBkz6lq?=
 =?us-ascii?Q?f6zSiXdeRhwo8lyTLY1s03qNTxzygu71Ge8LejlktZ5poyfVFBnlWS42Iats?=
 =?us-ascii?Q?x34u17KyRsufJSdMLYhIvR/QXgMPKcn7UyoZRRIayuPVXAkX9JQhHCfJJnj1?=
 =?us-ascii?Q?RVOxcvZfPcUsdQDAfOS47FNWLTHYP+7Az8a+21qyxrEzPWZxxI3PQ6m3BT+5?=
 =?us-ascii?Q?5/hVZvtsGhg/QZQZLmQF7NmB4yQYcJzkiAtlom1iJMyCbWsPaCj+7tKLVwB/?=
 =?us-ascii?Q?tOcTByKoPfNcpZymR3esB90IBn/Fopmu2ukU3zNkYoi+4ghBdQ2+2k6JcVKV?=
 =?us-ascii?Q?QSLMcwXihwXmz4/jN/gJ?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98ae0139-e300-4008-0f49-08dd08c359dc
X-MS-Exchange-CrossTenant-AuthSource: AM6PR03MB5080.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2024 17:55:27.8620
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR03MB6170

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
 .../testing/selftests/bpf/prog_tests/iters.c  | 105 ++++++++++++++++
 .../selftests/bpf/progs/iters_task_file.c     |  71 +++++++++++
 .../bpf/progs/iters_task_file_failure.c       | 114 ++++++++++++++++++
 4 files changed, 297 insertions(+)
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
index 3cea71f9c500..4944810e9b2f 100644
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
@@ -291,6 +295,104 @@ static void subtest_css_iters(void)
 	iters_css__destroy(skel);
 }
 
+struct files_test_args {
+	bool *setup_end;
+	bool *test_end;
+};
+
+static int task_file_test_process(void *args)
+{
+	struct files_test_args *test_args = (struct files_test_args *)args;
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
+	*test_args->setup_end = true;
+
+	while (!*test_args->test_end)
+		;
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
+	int prog_fd, child_pid, wstatus, err = 0;
+	const int stack_size = 1024 * 1024;
+	struct iters_task_file *skel;
+	struct files_test_args args;
+	struct bpf_program *prog;
+	bool setup_end, test_end;
+	char *stack;
+
+	skel = iters_task_file__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "open_and_load"))
+		return;
+
+	if (!ASSERT_OK(skel->bss->err, "pre_test_err"))
+		goto cleanup_skel;
+
+	prog = bpf_object__find_program_by_name(skel->obj, "test_bpf_iter_task_file");
+	if (!ASSERT_OK_PTR(prog, "find_program_by_name"))
+		goto cleanup_skel;
+
+	prog_fd = bpf_program__fd(prog);
+	if (!ASSERT_GT(prog_fd, -1, "bpf_program__fd"))
+		goto cleanup_skel;
+
+	stack = (char *)malloc(stack_size);
+	if (!ASSERT_OK_PTR(stack, "clone_stack"))
+		goto cleanup_skel;
+
+	setup_end = false;
+	test_end = false;
+
+	args.setup_end = &setup_end;
+	args.test_end = &test_end;
+
+	/* Note that there is no CLONE_FILES */
+	child_pid = clone(task_file_test_process, stack + stack_size, CLONE_VM | SIGCHLD, &args);
+	if (!ASSERT_GT(child_pid, -1, "child_pid"))
+		goto cleanup_stack;
+
+	while (!setup_end)
+		;
+
+	skel->bss->pid = child_pid;
+
+	err = bpf_prog_test_run_opts(prog_fd, NULL);
+	if (!ASSERT_OK(err, "prog_test_run"))
+		goto cleanup_stack;
+
+	test_end = true;
+
+	if (!ASSERT_GT(waitpid(child_pid, &wstatus, 0), -1, "waitpid"))
+		goto cleanup_stack;
+
+	if (!ASSERT_OK(WEXITSTATUS(wstatus), "run_task_file_iters_test_err"))
+		goto cleanup_stack;
+
+	ASSERT_OK(skel->bss->err, "run_task_file_iters_test_failure");
+cleanup_stack:
+	free(stack);
+cleanup_skel:
+	iters_task_file__destroy(skel);
+}
+
 void test_iters(void)
 {
 	RUN_TESTS(iters_state_safety);
@@ -315,5 +417,8 @@ void test_iters(void)
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
index 000000000000..f14b473936c7
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/iters_task_file.c
@@ -0,0 +1,71 @@
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
+int err, pid;
+
+SEC("syscall")
+int test_bpf_iter_task_file(void *ctx)
+{
+	struct bpf_iter_task_file task_file_it;
+	struct bpf_iter_task_file_item *item;
+	struct task_struct *task;
+
+	task = bpf_task_from_vpid(pid);
+	if (task == NULL) {
+		err = 1;
+		return 0;
+	}
+
+	bpf_rcu_read_lock();
+	bpf_iter_task_file_new(&task_file_it, task);
+
+	item = bpf_iter_task_file_next(&task_file_it);
+	if (item == NULL) {
+		err = 2;
+		goto cleanup;
+	}
+
+	if (item->fd != 0) {
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
+	item = bpf_iter_task_file_next(&task_file_it);
+	if (item == NULL) {
+		err = 6;
+		goto cleanup;
+	}
+
+	if (item->fd != 2) {
+		err = 7;
+		goto cleanup;
+	}
+
+	item = bpf_iter_task_file_next(&task_file_it);
+	if (item != NULL)
+		err = 8;
+cleanup:
+	bpf_iter_task_file_destroy(&task_file_it);
+	bpf_rcu_read_unlock();
+	bpf_task_release(task);
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


