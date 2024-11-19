Return-Path: <linux-fsdevel+bounces-35232-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A8F09D2D71
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Nov 2024 19:02:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2DB841F265F3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Nov 2024 18:02:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAB231D2B30;
	Tue, 19 Nov 2024 17:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="lDcpFB/k"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazolkn19011078.outbound.protection.outlook.com [52.103.32.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 050E314375D;
	Tue, 19 Nov 2024 17:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.32.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732039071; cv=fail; b=DP6FXXHkcNuylDIIKLdBTTTcwp/m2UFyEssYaxZXD91B+Fj/97rX+7WkQchJpbJlXG5Mgup5zWHWMBuwiHHXgqyFjInOO7CIMglpXVOwRgIcGfCJNIFYMD4Ma1h4gzNfdwVaRhbiemsxtUyGwGxs/ykkQtZPpE/v370otypQ57g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732039071; c=relaxed/simple;
	bh=cfjuXJcMBVBRVRlWMNWEFl9Ta8bYkTHoDzGDunfbbA0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=s5wPswJtuIgC/6uPixxnpq8K36zcBWbDubKJVuX92qIzZcWgFd6ky8Prm0Asl+uxUzAU8SkEpVhX6Yqy3AAnrWfzI1j+8xcbgPZHbutUcQ9g+27pX+V3yb2rC3VDs7ERHBVDt21Rgyo+sq8HHmyShoMSPZlXAmp7R5XwVuMDeMk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=lDcpFB/k; arc=fail smtp.client-ip=52.103.32.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fu40+0OGWEtjqLq/KslQqfN2HFFVvoosQhQ8Ro0cVc/YDYdlJcEvVxA1AAkmpyLW8u1FuIL2ob+b9ArG+XPZken+bl0f8rYJCvrW8ygoHqUlPmeoWsDiLZVtfpZL5JuPJ/QedlhfB1zZpGWc9eZsFru72fz+r0ydDfYHUliODP/wsL/QnzgDHfzWg3B4vgLS/b8moMNQ/Ho8nlFNCg1gQ+ixEl3X0iOZMw6pzRMC34hUGUjhR2icOA9c9ZWljNhx4KjlcRI01ob/bn6CjLfQPjSTwBXlrEdP6KyLKPXevuESItUa+Qy4Q6vUMlMNQUSOc3IwnVMMaKzHgGYkRUqC5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JSKDnppz9R+W1Lb3PYAiSs62avuREGXGlx1KBx57RU4=;
 b=gIDZNA0Q6bOl0tYMNXIvYGBl/PtqOhQ3eYogn6zG7us7BryL2CjncDFufwKXlnUYJHp+muR1Xpg6GQFEB9DpYU+bP5UUxAQa+74KU4+WVl8fjK1ucgXJx0/zheYhEtUqcv/CM3pDCKvUwQomSgV/vrUtLz0ioybJ7faMStbUmrmx+jSbtOy1f45s8asVnrOFvk8gSKRY/Qc/qqAlpCm77ByZRhcOKK2tM/1Dt4rlyN/eD+J2Yh7WVhZazOLPj6EeToHO+yiGh/sy6ACOi6/tluoeSvEwWM6Sx/SsVJTklVk9eyx71Jq/pKn6YfPUjTrSTAKRbjAyDV7BasT61i9BKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JSKDnppz9R+W1Lb3PYAiSs62avuREGXGlx1KBx57RU4=;
 b=lDcpFB/kdnj0JXIvXsQtvUPsD3H5UHoONcn3hflx2xE4rQRfoVmii1A2YMpzK3OGQESpOo3Gd8GsTLHIWPvn8SDrY/N7PWjhXZkGRyVau66CYtju+8Jbd+lMFAwk0nfYMdEsaJMpZgfzOF/M/Y+oFYy1iQJ10DJeQ3jl9ZjaVzcTJICVq6Uc4izkPXTIkibAkOJFHX74BWhE/ntvZlOijGCIX9gGjwhfSjFfttI0YLAAJPNk4vzRrK06padwiannVCY4M8g5JeWI+Z9X5o0GKGP0/KSn1Ic9/41as0p4FJ3LMymm1B5bJgKZnhBYYIKVRUgA0a3O29ZjJ6s/a/XD7w==
Received: from AM6PR03MB5080.eurprd03.prod.outlook.com (2603:10a6:20b:90::20)
 by DB8PR03MB6170.eurprd03.prod.outlook.com (2603:10a6:10:141::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.20; Tue, 19 Nov
 2024 17:57:46 +0000
Received: from AM6PR03MB5080.eurprd03.prod.outlook.com
 ([fe80::a16:9eb8:6868:f6d8]) by AM6PR03MB5080.eurprd03.prod.outlook.com
 ([fe80::a16:9eb8:6868:f6d8%4]) with mapi id 15.20.8158.023; Tue, 19 Nov 2024
 17:57:46 +0000
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
Subject: [PATCH bpf-next v4 5/5] selftests/bpf: Add tests for bpf_fget_task() kfunc
Date: Tue, 19 Nov 2024 17:54:02 +0000
Message-ID:
 <AM6PR03MB50801CAD7F39745C2B8850D799202@AM6PR03MB5080.eurprd03.prod.outlook.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <AM6PR03MB50804C0DF9FB1E844B593FDB99202@AM6PR03MB5080.eurprd03.prod.outlook.com>
References: <AM6PR03MB50804C0DF9FB1E844B593FDB99202@AM6PR03MB5080.eurprd03.prod.outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0187.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a::31) To AM6PR03MB5080.eurprd03.prod.outlook.com
 (2603:10a6:20b:90::20)
X-Microsoft-Original-Message-ID:
 <20241119175402.51778-5-juntong.deng@outlook.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR03MB5080:EE_|DB8PR03MB6170:EE_
X-MS-Office365-Filtering-Correlation-Id: f831a46b-b217-40ef-82ad-08dd08c3ac6d
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|5072599009|461199028|19110799003|8060799006|15080799006|440099028|3412199025;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?KQqQdJlZLCTAhtqPPqnesujcjbpl22oe2YsXDFDsT8mLT7m9FiA0bGRsbjNm?=
 =?us-ascii?Q?FeMp1LFezSkhQ87Es9yo2G8EqDR5GEDQ9RfK11Ggjg8NL1g+xUnpEzJdmAkB?=
 =?us-ascii?Q?aCo/HpZQeWthpf958NMazpatdrOVUU30uRmBsu5NEo4kPUEd0GDdE9Jf6z/q?=
 =?us-ascii?Q?PpUTnvnudIXj3z04suNjEuFNMtYLi+4gj1x6ZZoE/79Ps3x7x63EONLboU9z?=
 =?us-ascii?Q?c+qQjZ2TZ3swiwsjOhVY12p88mfAZe2t9LYlgSCxPtHl9nyiNqPBXOhDCbYg?=
 =?us-ascii?Q?ShDrY0PVQ+ay3q0ew2UBc02AjLdIJoEDpKg4YBO07k5+gzRI43uVEdEWINjn?=
 =?us-ascii?Q?dj+YWVwbENeLg4cbmYpbhciIKN5jgJhCExWZCl2Tr3WcdmyhLTfBLixES95c?=
 =?us-ascii?Q?+f/Basjczo26tS80VRjMvYvQNm10aOzq5g43AhFyZYsmwfykuO4H/cwIDs7a?=
 =?us-ascii?Q?bInlu1uLlu04rQ109S5WF5RQiCWH+UBnQbHcTjJqDLcW/EILYsZTWxeJetWA?=
 =?us-ascii?Q?xT4xFlXEN1v7PFzgofp/EatjFPh3FSoIZSN0BNWgBSNTGQmIxKrm56HuFiDo?=
 =?us-ascii?Q?gUolPuByaGJws1RCJZt64xGyV7/9LrHFQ1YWV/QKTKZHGU5m3cgg8YloCom0?=
 =?us-ascii?Q?C6VJb6yEk221gw2k/4ZTk+JeSmEiHCUMWzQU5cmRr5122sKV9JlHTc9jEuQZ?=
 =?us-ascii?Q?ZWBai2PLCYZOhlYqbRzkc/Exj7dwh8kHW7TqXPcuSN5Y08te9tSDsqjY+D+K?=
 =?us-ascii?Q?iSKmzRoUFN6k7eIdo9gIkxVzKlwbD6iUua7uvXUnL8xgfCH9GMvWSu0kPX09?=
 =?us-ascii?Q?XReHDqmf48Sf5jNe+rVxumHoCC2Swdz3gi1QvYGG1jEbkTxNsZQ6O1G77lQ9?=
 =?us-ascii?Q?DpcQYZM9n53ZcT7/NokthVs3Tcfm/fmm1Vwm0ZnvtFpYw5k2yXuCpbFRSUyh?=
 =?us-ascii?Q?Fc3Dvp58ZGjfFZZqq86UqJzgpeUDRVcnzD6NMZso4fDoUJCG6c/eADq38RHZ?=
 =?us-ascii?Q?qLNL?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?JMGoNQ+L49k+4dwRKLlN2fO2tdm3MPnDe00U4tLyLS0wSOqmI4XFiB/K4Qyj?=
 =?us-ascii?Q?i7lMMdSU5fRsMtwvJbKyEIwK+dpEaCkI03G0N62RDkvunNQThW9u4UtvXfmt?=
 =?us-ascii?Q?bpriLE74+lphzsHJ2qbfiTallRPqMslztQ0rFMidTsV/6CEDKL7o9GQheGAS?=
 =?us-ascii?Q?FHZvT92MuGeNe0bRCfi3sA7fU90M6uUshyHQORbeZocBRyTnIS8Hdt5sO5X3?=
 =?us-ascii?Q?cdF6p8prCAM3m0FNhFdSgue35WO/NSRQC6kgR8tiMLB4fRXVEvfuY+ktzET/?=
 =?us-ascii?Q?YFNC7jtx3RJi9PJadLAWTgjixXoE8thHzJqpO+DwnV3V/4WGEH7VhcFZQzRY?=
 =?us-ascii?Q?plChMUl7zFFYyEdLTtaX/7Tccy9/dNWKQS0R7KZEUUcPcVneI2sgJxWZyZbI?=
 =?us-ascii?Q?YliMO2gksjUWW6oAGRoftg4SZxql4nbhPBdB5ndt+tmToBdt1pm6RHz/tf3w?=
 =?us-ascii?Q?g0cBY7egmeeMx/Ss2LoXmULAWe7PH0xR1xAS9yoISeSuv7JloDxNcBDxCJmW?=
 =?us-ascii?Q?dzi6BkA3a14/++xAGwBI9Ii8C43Szr6QCgNuf/SknVD8I2qpD+Fp3rzIXwYB?=
 =?us-ascii?Q?YhoCCpmfAT/FkCWxM00mkVH6cSDphFQ3FfOfLvovCzXc+IrXr1ZK0XyotHY0?=
 =?us-ascii?Q?5e5EleA62Bzn5qYAMlIvawEtyCJtLzD9XP+oJQRaMCeYiLml8BWpjq12R1+3?=
 =?us-ascii?Q?xRTfYSr3lVrYNXZyRw0cGIAxoag72phr4nOodWUOateNi1gi/p0EtizkzFNC?=
 =?us-ascii?Q?xkKwNqBi4/ncQfU8aia6UXt8JkYCnZ29sXZigoiB/IYVb2Y2+PgfxhN4xLYN?=
 =?us-ascii?Q?z99zCgESDebyMZ/qLZ0Sa2XcYZQE5UKJWehwTjItkjPZnIa3altMvdKDFfw2?=
 =?us-ascii?Q?FnOnGHg3j8zXnuUqoxFkHSx6otrjc7swr+ZWP4PFWVq9jBFyAtAk4deK0a62?=
 =?us-ascii?Q?Zrc2AfnLuUXPntf7qSvCplNEonSO8dMN4cIvY29Z7vWlfJSRrtW4/FCV16Dc?=
 =?us-ascii?Q?5eASwhAFPm64P5KexB4fIrtf+t/eN5iLjCLmApELALz6ptD1boKgnjS1XnRn?=
 =?us-ascii?Q?vSqUEb02Mx/KFz55r7CG+l+yBfNnYw9dnjXLYnsSPJN+BloXwWJWTcJYSRZO?=
 =?us-ascii?Q?61v2EGR31h4Sa6qg+0yR7jPdWoyjA8va4LU0MskmJ7oxq9yJd2hMUyaMKiSh?=
 =?us-ascii?Q?8M4cSzoP8T10HjktUU1E+jy6d0AfnA3VEA+Ytkv9ihcnABUZt4rKw7P//sAZ?=
 =?us-ascii?Q?z6LmGcQQ6ruiKZR6l3oQ?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f831a46b-b217-40ef-82ad-08dd08c3ac6d
X-MS-Exchange-CrossTenant-AuthSource: AM6PR03MB5080.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2024 17:57:46.3432
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR03MB6170

This patch adds test cases for bpf_fget_task() kfunc.

test_bpf_fget_task is used to test obtaining struct file based on
the file descriptor in the current process.

bpf_fget_task_null_task and bpf_fget_task_untrusted_task are used to
test the failure cases of passing NULL or untrusted pointer as argument.

Signed-off-by: Juntong Deng <juntong.deng@outlook.com>
---
 .../testing/selftests/bpf/bpf_experimental.h  |  8 +++
 .../selftests/bpf/prog_tests/fs_kfuncs.c      | 46 +++++++++++++++++
 .../selftests/bpf/progs/fs_kfuncs_failure.c   | 33 +++++++++++++
 .../selftests/bpf/progs/test_fget_task.c      | 49 +++++++++++++++++++
 4 files changed, 136 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/fs_kfuncs_failure.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_fget_task.c

diff --git a/tools/testing/selftests/bpf/bpf_experimental.h b/tools/testing/selftests/bpf/bpf_experimental.h
index ce1520c56b55..e0c9e7d9ba0a 100644
--- a/tools/testing/selftests/bpf/bpf_experimental.h
+++ b/tools/testing/selftests/bpf/bpf_experimental.h
@@ -221,6 +221,14 @@ extern void bpf_put_file(struct file *file) __ksym;
  */
 extern int bpf_path_d_path(struct path *path, char *buf, size_t buf__sz) __ksym;
 
+/* Description
+ *	Get a pointer to the struct file corresponding to the task file descriptor
+ *	Note that this function acquires a reference to struct file.
+ * Returns
+ *	The corresponding struct file pointer if found, otherwise returns NULL
+ */
+extern struct file *bpf_fget_task(struct task_struct *task, unsigned int fd) __ksym;
+
 /* This macro must be used to mark the exception callback corresponding to the
  * main program. For example:
  *
diff --git a/tools/testing/selftests/bpf/prog_tests/fs_kfuncs.c b/tools/testing/selftests/bpf/prog_tests/fs_kfuncs.c
index 5a0b51157451..83dfe64aa3fb 100644
--- a/tools/testing/selftests/bpf/prog_tests/fs_kfuncs.c
+++ b/tools/testing/selftests/bpf/prog_tests/fs_kfuncs.c
@@ -9,6 +9,8 @@
 #include <test_progs.h>
 #include "test_get_xattr.skel.h"
 #include "test_fsverity.skel.h"
+#include "test_fget_task.skel.h"
+#include "fs_kfuncs_failure.skel.h"
 
 static const char testfile[] = "/tmp/test_progs_fs_kfuncs";
 
@@ -139,6 +141,45 @@ static void test_fsverity(void)
 	remove(testfile);
 }
 
+static void test_fget_task(void)
+{
+	int pipefd[2], prog_fd, err = 0;
+	struct test_fget_task *skel;
+	struct bpf_program *prog;
+
+	skel = test_fget_task__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "open_and_load"))
+		return;
+
+	if (!ASSERT_OK(skel->bss->err, "pre_test_err"))
+		goto cleanup_skel;
+
+	prog = bpf_object__find_program_by_name(skel->obj, "test_bpf_fget_task");
+	if (!ASSERT_OK_PTR(prog, "find_program_by_name"))
+		goto cleanup_skel;
+
+	prog_fd = bpf_program__fd(prog);
+	if (!ASSERT_GT(prog_fd, -1, "bpf_program__fd"))
+		goto cleanup_skel;
+
+	if (pipe(pipefd) < 0)
+		goto cleanup_skel;
+
+	skel->bss->test_fd1 = pipefd[0];
+	skel->bss->test_fd2 = pipefd[1];
+
+	err = bpf_prog_test_run_opts(prog_fd, NULL);
+	if (!ASSERT_OK(err, "prog_test_run"))
+		goto cleanup_pipe;
+
+	ASSERT_OK(skel->bss->err, "run_bpf_fget_task_test_failure");
+cleanup_pipe:
+	close(pipefd[0]);
+	close(pipefd[1]);
+cleanup_skel:
+	test_fget_task__destroy(skel);
+}
+
 void test_fs_kfuncs(void)
 {
 	if (test__start_subtest("xattr"))
@@ -146,4 +187,9 @@ void test_fs_kfuncs(void)
 
 	if (test__start_subtest("fsverity"))
 		test_fsverity();
+
+	if (test__start_subtest("fget_task"))
+		test_fget_task();
+
+	RUN_TESTS(fs_kfuncs_failure);
 }
diff --git a/tools/testing/selftests/bpf/progs/fs_kfuncs_failure.c b/tools/testing/selftests/bpf/progs/fs_kfuncs_failure.c
new file mode 100644
index 000000000000..57aa6d2787ac
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/fs_kfuncs_failure.c
@@ -0,0 +1,33 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include "vmlinux.h"
+#include <bpf/bpf_tracing.h>
+#include <bpf/bpf_helpers.h>
+#include "bpf_misc.h"
+#include "bpf_experimental.h"
+
+char _license[] SEC("license") = "GPL";
+
+SEC("syscall")
+__failure __msg("Possibly NULL pointer passed to trusted arg0")
+int bpf_fget_task_null_task(void *ctx)
+{
+	struct task_struct *task = NULL;
+
+	bpf_fget_task(task, 1);
+
+	return 0;
+}
+
+SEC("syscall")
+__failure __msg("R1 must be referenced or trusted")
+int bpf_fget_task_untrusted_task(void *ctx)
+{
+	struct task_struct *task;
+
+	task = bpf_get_current_task_btf()->parent;
+
+	bpf_fget_task(task, 1);
+
+	return 0;
+}
diff --git a/tools/testing/selftests/bpf/progs/test_fget_task.c b/tools/testing/selftests/bpf/progs/test_fget_task.c
new file mode 100644
index 000000000000..ec40360ac1b2
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/test_fget_task.c
@@ -0,0 +1,49 @@
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
+int err, test_fd1, test_fd2;
+
+SEC("syscall")
+int test_bpf_fget_task(void *ctx)
+{
+	struct task_struct *task;
+	struct file *file;
+
+	task = bpf_get_current_task_btf();
+	if (task == NULL) {
+		err = 1;
+		return 0;
+	}
+
+	file = bpf_fget_task(task, test_fd1);
+	if (file == NULL) {
+		err = 2;
+		return 0;
+	}
+
+	bpf_put_file(file);
+
+	file = bpf_fget_task(task, test_fd2);
+	if (file == NULL) {
+		err = 3;
+		return 0;
+	}
+
+	bpf_put_file(file);
+
+	file = bpf_fget_task(task, 9999);
+	if (file != NULL) {
+		err = 4;
+		bpf_put_file(file);
+	}
+
+	return 0;
+}
-- 
2.39.5


