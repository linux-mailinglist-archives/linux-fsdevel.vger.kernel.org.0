Return-Path: <linux-fsdevel+bounces-33819-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F79C9BF771
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Nov 2024 20:48:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F9451F21EE6
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Nov 2024 19:48:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D257320EA37;
	Wed,  6 Nov 2024 19:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="RiTnEFAE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05olkn2055.outbound.protection.outlook.com [40.92.90.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D690420E33B;
	Wed,  6 Nov 2024 19:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.90.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730922022; cv=fail; b=rduZXxZHcxH4LL9O4pSfqPDqyNTvgT1V1+9OZku4giXuQeOVuQjggoNqX3IM4WT+900Ue00ItmQFqCIjsm542G75ZU+htn87yh9nrDftaZKm0nJ3dUuHZpf1WJgrtJiIGs35SKDl6VnJuBnkw3g9549U9GjfYLJdfOo+X4Ygq2g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730922022; c=relaxed/simple;
	bh=zdCm6U2s70xPqn85yHFyAGOgLwiup2BcmBZ19RSbvj8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nC6jt7rC2yLx74Yg6sNmRIQn270wzjJrb2icNnnxNPUNewdd24SW7tB/g6s3htuxzYb6iFfRc7/Q07pFBZkGJNT+AsCgc0RoRam8oz2zgMtbnv7LwemCnYjw+ZWFt2K8QsDykq/Y4zasu86aIzaJplDKsHgR9XSEpcpaTxt4F20=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=RiTnEFAE; arc=fail smtp.client-ip=40.92.90.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lFSSXjFprfxRkkIDNaCF2+Kk87imxv6a0jcKvDbj8IPcZ7mzyPKNNqPVuWYMtvxVdWdt1ULeajZ+5HrddoDJCZj0XzkJS7usOIaMpZt9doemHqx+SqcvdhO9MQmGUlX92pfMAmn4JVP+z8H7Vj2viz2PMpuSRfM820MLmnbEJkkgKYGk+g6kibMJe1S4JwxThouustZUGdb1UGH06WEW6PB9CXWrLdSGU6ZptnjFAt4OnlsKh1UQkvsQgM5b211w06XTNPp6Ns7G4v8D+OwSTKUsm3iDWy5MtMqv2LsqRfxcxheRz9VgIC3mCG0Xxy3q0BrIC8/Nzk9X4MQDf1e9PQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wPdVXSrZgZT19PDdftNK60UiDKPEwrcnyZ1Np9R5D/g=;
 b=Ao4E2CpOMQZ9xvoHEWlrHjftwVXUKMxL5JkuIOKpl0Jtn6MFS0qKawZMXvD4G6zxBQIqJuukDjvFzIEbv8dnfqp0tE+F/CCAV68joDIMPv7gk+YYqGuj4jgonWOdWpbkdCHZBtC2LSf2sWu1PVSgzFCam3WdDllMQNiNUHzQN9Z3oCLsttBmXfJTo9Z3EjRAsWMkdagdcELmVQRD9K1KSUrxy2IQSUm0qCElJLnAS8MnYd3Gjeka+1Dyt4O5JSHzy3DFb634OBFR2bRTA74xARW/umi+FDl5fUpI2J3ihVNnI8K2GNAVEH4jhDly5ROLkaN3jfQ8q4zWwM5bG47lvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wPdVXSrZgZT19PDdftNK60UiDKPEwrcnyZ1Np9R5D/g=;
 b=RiTnEFAEUJ3mhodQvLfEChD4OrRt1AjdH9kBQlswZRZARU3zaD4cIcZ8pIPK8pjmqQNv4j5lpGXm8MKn0nn6wtnaRKFuV23h/QRuEptzvRhgLtM3mcFiX4wS+l1j3gD+KTdG5sEQJ8u/jtAyRlZRjHxjx8zfb7nxYG2NOcU7tpWo/zmwiST5zfTOjvAMBC7K35Q3VovPsxdwOn4TUJpdzOPm3J+mAh8E7/zKHz28rLNPUmLNp97PT0lzrZNRMLa5DGPX+acZSAc0y34SYCn59mTH4y8MXpnIA7D7x1etptvuKPwtPTPyC7P02qrbQyfLSMpaeqDqAsDqOXtoEJ4Shw==
Received: from AM6PR03MB5848.eurprd03.prod.outlook.com (2603:10a6:20b:e4::10)
 by AS2PR03MB9792.eurprd03.prod.outlook.com (2603:10a6:20b:608::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.18; Wed, 6 Nov
 2024 19:40:15 +0000
Received: from AM6PR03MB5848.eurprd03.prod.outlook.com
 ([fe80::4b97:bbdb:e0ac:6f7]) by AM6PR03MB5848.eurprd03.prod.outlook.com
 ([fe80::4b97:bbdb:e0ac:6f7%4]) with mapi id 15.20.8093.027; Wed, 6 Nov 2024
 19:40:15 +0000
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
Subject: [PATCH bpf-next v3 2/4] selftests/bpf: Add tests for open-coded style process file iterator
Date: Wed,  6 Nov 2024 19:38:46 +0000
Message-ID:
 <AM6PR03MB5848062079D92D7C9A430CE499532@AM6PR03MB5848.eurprd03.prod.outlook.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <AM6PR03MB58488FD29EB0D0B89D52AABB99532@AM6PR03MB5848.eurprd03.prod.outlook.com>
References: <AM6PR03MB58488FD29EB0D0B89D52AABB99532@AM6PR03MB5848.eurprd03.prod.outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P265CA0280.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:37a::17) To AM6PR03MB5848.eurprd03.prod.outlook.com
 (2603:10a6:20b:e4::10)
X-Microsoft-Original-Message-ID:
 <20241106193848.160447-2-juntong.deng@outlook.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR03MB5848:EE_|AS2PR03MB9792:EE_
X-MS-Office365-Filtering-Correlation-Id: 2612158b-bb2d-4db5-4515-08dcfe9ad5f5
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199028|15080799006|19110799003|5072599009|8060799006|3412199025|440099028;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?CovV1GQYQUUoeAdmpxPVilwm9TJ1EoU1FCdigpYKxzxy7FXaRYShBatwzNl5?=
 =?us-ascii?Q?j8pO2BR1Kowowcgn9YkUuL03j6cfHM6vNbu5hZS/n9HnMVWRm9wHh27AWVwd?=
 =?us-ascii?Q?NOYSPG7Cch1aD2kjR+6nlJNv2pXM/zvmQDjyZt6Uq/zSqJ20OVH4g2gr9VDC?=
 =?us-ascii?Q?QIMF9ORa7ALrcIhe0jr1kJCijjP8aPTAEAuXt63ATNcYY5roTJzJwoBzwXFb?=
 =?us-ascii?Q?l1qgR+EpZRIv+Db0Ln1eIA5KESyPT7+ip/7e8nrYLWwb+RtZcAwG3/8yQr42?=
 =?us-ascii?Q?AkEvJQo8Ji8oLu+R50yhLdY7IU1lAw7qm7eYdC7GHUkAMl4ZXHchpIdLfkj9?=
 =?us-ascii?Q?zxBxmVu+jocb1gCCpyWVfvxA59c5NJUjDl6/34NOOhLghVHxXaEMFxxNp617?=
 =?us-ascii?Q?thq+XvxbwbwJSHYTub5a3gUc8Jfwjrvr8vNa7IfOmWIpX2b7m6TPh67kB7eo?=
 =?us-ascii?Q?K5d/7O4epYWdM3k/Q53SkMS6ComeS56Uj4wzS7LxC9YTZluKTTGOgwCMxTFD?=
 =?us-ascii?Q?jnQGLafc1lHnSdoxoIqgeGaYZ1oZ+s5/1a+PbUY9/vs5G8IESElTF2dax1g7?=
 =?us-ascii?Q?qVLMXOxACeXWRz6moKvzG9ZX7jcVPhy8O4PGpNK7CI0ic73hV18OXQ83DGZ5?=
 =?us-ascii?Q?h1a8Ag7N6rKPKDYoytLfRPco0HIbnHqMn5n4+mgO+5iRuDiRMngSN6r7sZW7?=
 =?us-ascii?Q?bzxCRG6OS7TJLpFeR1kXxvBYVqn/uOYpY0kklrg+VSudAr3gvgA3/219TacJ?=
 =?us-ascii?Q?hAfrWkavsDdcNvMhrJdvh3cRgs+XaAxhd3nHCIFemCs5WGRoA+NGNigkaq+G?=
 =?us-ascii?Q?3kWOwC4TTLxTr0MFLYW/+rcdCwzZFOrFWRlowyt+PREMVFNfRra340VMKx2a?=
 =?us-ascii?Q?VJzR+mHYDv9tK/ks9cCDsoV7METuuJTEx1jyxCxbnt0tY/FTSQpjZzqArfoQ?=
 =?us-ascii?Q?glFeNTtSTX/0XXen/1XlMqiQbsrclr2aLXjZhMFzRpZlKjk6cvBpSjnsnhoR?=
 =?us-ascii?Q?ykSrwUSgNBcSpxVCWHY0S9yyHg=3D=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?O+Cmsgew8J8Ldu6s04VUSpSBZfB3ILefeowQBH5bDhDWj4Tng/FWqHZj5kzE?=
 =?us-ascii?Q?PVCl8/tAa+/SugsqXeFovuYVsQBxKbf9d7n8/y7hLu4IZXDZvxhbinctSzfo?=
 =?us-ascii?Q?TiKfT2X3BsEAXPHni8uUz5oJQykDMvC7F8HCSeBZToArzresjSv4sQklF4AS?=
 =?us-ascii?Q?1VTv2I3REXDXjcpmq4ApTAy8a+C//QpHwlWNn/ebelJdpMd2kCbAoOwoufhn?=
 =?us-ascii?Q?4sueRccO05ZxwbQNd8SODlqbYakY0iQU0bdnhvo/55lIUXB6VcA0Rc+USexw?=
 =?us-ascii?Q?t+vfrUKf3OoONQqt/gDgnDp6miMHKWI+2kIANQj+ZAiXNo2GnKjDeZ7sYTN3?=
 =?us-ascii?Q?ciT9uM8999Yx0mcFlImrRgNoKbbwpVC1u/i2zY16+gfTzVgFpQ31pu/gXSYE?=
 =?us-ascii?Q?5ulmwLIMBjUqPt9Fw1ipv+gevzf74okUFDFgFsFd5OO2P64qscaOLr3hCsGk?=
 =?us-ascii?Q?XVXw4FcKxDSQv1Tt9tu+RIY9WPDoih76WSH+Yexip8vNiNG3mekGuLkazk6e?=
 =?us-ascii?Q?ec31s/oEoeb0VMwoUAjzYI0KQMYzRUQ/bC9yO+rM1WEU53Z7p8BDmFZ937WD?=
 =?us-ascii?Q?3EhvbfSHssW1xGRtXS51UP8/rKbXCgbiF6WWDOTVTTz5KTInW9Eh2k6saIlq?=
 =?us-ascii?Q?QTi7SmIhH9tbEo8sa8onrzWQHfurfBV0wbPDNRiaItYf7hbytjs+7kq3hf5Z?=
 =?us-ascii?Q?3adMyF47u+iQjJtdDcyToR8O3J5voXZTSeUF4NOmCeuBPPkZgD9K4WYtcWkq?=
 =?us-ascii?Q?2j3cGlIk/swM5uTKqz8JCKuS89E0INa+5GPHZsiAeEnYLllQDEFLvlg+8DDQ?=
 =?us-ascii?Q?DRVD6Ln0y5zLCbmGNbIEcsccM5n0wluUZLJcTO1LbAe3mOzAiKjdkCHpegqB?=
 =?us-ascii?Q?Pc7ymUU5FQqAvQGY+tSz15NK+WCZwPZqpmUwRDRHzkPMjVg4rp6qpH73ek9I?=
 =?us-ascii?Q?28j0/I2hQpIYk90U3QnOXK7rJovukifZ8gZYcPHExEf35JE0guyzTM/GNhtH?=
 =?us-ascii?Q?vjC33dlDPY5PVVnF3t4LYRmmPUCMZ3lpkmENBkMeUZT0Oz9uxZVTs1Ie1Ca7?=
 =?us-ascii?Q?Hg6GtCzK/7ElyNJ821BMXRc0z1mm0QuJGssDLTO77VsrumoGB51Yn7d+1aTV?=
 =?us-ascii?Q?FcFwY2TTfcdHZy48BDICoxJ9GAkci79skAFTdeU6TkJTNyuAdpsIJM9yl5h1?=
 =?us-ascii?Q?AhxvPfMZ2RT+BGY3uU0uBwlqIGwTUodgQZGFCTWp5EDbvrlEpPthQybV6ZeO?=
 =?us-ascii?Q?BWWvT0Kk2Chjltw8jD4O?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2612158b-bb2d-4db5-4515-08dcfe9ad5f5
X-MS-Exchange-CrossTenant-AuthSource: AM6PR03MB5848.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2024 19:40:14.9957
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR03MB9792

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
 tools/testing/selftests/bpf/prog_tests/crib.c | 125 ++++++++++++++++++
 .../testing/selftests/bpf/progs/crib_common.h |  21 +++
 .../selftests/bpf/progs/crib_files_failure.c  |  86 ++++++++++++
 .../selftests/bpf/progs/crib_files_success.c  |  73 ++++++++++
 4 files changed, 305 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/crib.c
 create mode 100644 tools/testing/selftests/bpf/progs/crib_common.h
 create mode 100644 tools/testing/selftests/bpf/progs/crib_files_failure.c
 create mode 100644 tools/testing/selftests/bpf/progs/crib_files_success.c

diff --git a/tools/testing/selftests/bpf/prog_tests/crib.c b/tools/testing/selftests/bpf/prog_tests/crib.c
new file mode 100644
index 000000000000..48c5156504ad
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/crib.c
@@ -0,0 +1,125 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#define _GNU_SOURCE
+#include <test_progs.h>
+#include <unistd.h>
+#include <sys/wait.h>
+#include <sys/socket.h>
+#include "crib_files_failure.skel.h"
+#include "crib_files_success.skel.h"
+
+struct files_test_args {
+	bool *setup_end;
+	bool *cr_end;
+};
+
+static int files_test_process(void *args)
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
+	while (!*test_args->cr_end)
+		;
+
+	close(sockfd);
+cleanup_pipe:
+	close(pipefd[0]);
+	close(pipefd[1]);
+	return err;
+}
+
+static void run_files_success_test(const char *prog_name)
+{
+	int prog_fd, child_pid, wstatus, err = 0;
+	const int stack_size = 1024 * 1024;
+	struct crib_files_success *skel;
+	struct files_test_args args;
+	struct bpf_program *prog;
+	bool setup_end, cr_end;
+	char *stack;
+
+	skel = crib_files_success__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "open_and_load"))
+		return;
+
+	if (!ASSERT_OK(skel->bss->err, "pre_test_err"))
+		goto cleanup_skel;
+
+	prog = bpf_object__find_program_by_name(skel->obj, prog_name);
+	if (!ASSERT_OK_PTR(prog, "find_program_by_name"))
+		goto cleanup_skel;
+
+	prog_fd = bpf_program__fd(prog);
+	if (!ASSERT_GT(prog_fd, -1, "bpf_program__fd"))
+		goto cleanup_skel;
+
+	stack = (char *)malloc(stack_size);
+	if (!ASSERT_OK_PTR(stack, "clone_stack"))
+		return;
+
+	setup_end = false;
+	cr_end = false;
+
+	args.setup_end = &setup_end;
+	args.cr_end = &cr_end;
+
+	/* Note that there is no CLONE_FILES */
+	child_pid = clone(files_test_process, stack + stack_size, CLONE_VM | SIGCHLD, &args);
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
+	cr_end = true;
+
+	if (!ASSERT_GT(waitpid(child_pid, &wstatus, 0), -1, "waitpid"))
+		goto cleanup_stack;
+
+	if (!ASSERT_OK(WEXITSTATUS(wstatus), "run_files_test_err"))
+		goto cleanup_stack;
+
+	ASSERT_OK(skel->bss->err, "run_files_test_failure");
+cleanup_stack:
+	free(stack);
+cleanup_skel:
+	crib_files_success__destroy(skel);
+}
+
+static const char * const files_success_tests[] = {
+	"test_bpf_iter_task_file",
+};
+
+void test_crib(void)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(files_success_tests); i++) {
+		if (!test__start_subtest(files_success_tests[i]))
+			continue;
+
+		run_files_success_test(files_success_tests[i]);
+	}
+
+	RUN_TESTS(crib_files_failure);
+}
diff --git a/tools/testing/selftests/bpf/progs/crib_common.h b/tools/testing/selftests/bpf/progs/crib_common.h
new file mode 100644
index 000000000000..93b8f9b1bdf8
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/crib_common.h
@@ -0,0 +1,21 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef __CRIB_COMMON_H
+#define __CRIB_COMMON_H
+
+#include <vmlinux.h>
+#include <bpf/bpf_tracing.h>
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_core_read.h>
+
+extern struct task_struct *bpf_task_from_vpid(s32 vpid) __ksym;
+extern void bpf_task_release(struct task_struct *p) __ksym;
+
+struct bpf_iter_task_file;
+extern int bpf_iter_task_file_new(struct bpf_iter_task_file *it,
+		struct task_struct *task) __ksym;
+extern struct file *bpf_iter_task_file_next(struct bpf_iter_task_file *it) __ksym;
+extern int bpf_iter_task_file_get_fd(struct bpf_iter_task_file *it__iter) __ksym;
+extern void bpf_iter_task_file_destroy(struct bpf_iter_task_file *it) __ksym;
+
+#endif /* __CRIB_COMMON_H */
diff --git a/tools/testing/selftests/bpf/progs/crib_files_failure.c b/tools/testing/selftests/bpf/progs/crib_files_failure.c
new file mode 100644
index 000000000000..ebae01d87ff9
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/crib_files_failure.c
@@ -0,0 +1,86 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include "vmlinux.h"
+#include <bpf/bpf_tracing.h>
+#include <bpf/bpf_helpers.h>
+#include "bpf_misc.h"
+#include "crib_common.h"
+
+char _license[] SEC("license") = "GPL";
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
+int bpf_iter_task_file_new_untrusted_task(void *ctx)
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
+int bpf_iter_task_file_get_fd_uninit_iter(void *ctx)
+{
+	struct bpf_iter_task_file task_file_it;
+
+	bpf_iter_task_file_get_fd(&task_file_it);
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
diff --git a/tools/testing/selftests/bpf/progs/crib_files_success.c b/tools/testing/selftests/bpf/progs/crib_files_success.c
new file mode 100644
index 000000000000..8de43dedbb02
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/crib_files_success.c
@@ -0,0 +1,73 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include "vmlinux.h"
+#include <bpf/bpf_tracing.h>
+#include <bpf/bpf_helpers.h>
+#include "bpf_misc.h"
+#include "crib_common.h"
+
+char _license[] SEC("license") = "GPL";
+
+int err, pid;
+
+SEC("syscall")
+int test_bpf_iter_task_file(void *ctx)
+{
+	struct bpf_iter_task_file task_file_it;
+	struct task_struct *task;
+	struct file *file;
+	int fd;
+
+	task = bpf_task_from_vpid(pid);
+	if (task == NULL) {
+		err = 1;
+		return 0;
+	}
+
+	bpf_iter_task_file_new(&task_file_it, task);
+
+	file = bpf_iter_task_file_next(&task_file_it);
+	if (file == NULL) {
+		err = 2;
+		goto cleanup;
+	}
+
+	fd = bpf_iter_task_file_get_fd(&task_file_it);
+	if (fd != 0) {
+		err = 3;
+		goto cleanup;
+	}
+
+	file = bpf_iter_task_file_next(&task_file_it);
+	if (file == NULL) {
+		err = 4;
+		goto cleanup;
+	}
+
+	fd = bpf_iter_task_file_get_fd(&task_file_it);
+	if (fd != 1) {
+		err = 5;
+		goto cleanup;
+	}
+
+	file = bpf_iter_task_file_next(&task_file_it);
+	if (file == NULL) {
+		err = 6;
+		goto cleanup;
+	}
+
+	fd = bpf_iter_task_file_get_fd(&task_file_it);
+	if (fd != 2) {
+		err = 7;
+		goto cleanup;
+	}
+
+	file = bpf_iter_task_file_next(&task_file_it);
+	if (file != NULL)
+		err = 8;
+
+cleanup:
+	bpf_iter_task_file_destroy(&task_file_it);
+	bpf_task_release(task);
+	return 0;
+}
-- 
2.39.5


