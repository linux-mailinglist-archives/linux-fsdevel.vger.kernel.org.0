Return-Path: <linux-fsdevel+bounces-36943-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DA10D9EB2C6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Dec 2024 15:10:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9CA0284322
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Dec 2024 14:10:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4194C1AAE1A;
	Tue, 10 Dec 2024 14:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="QqPp+g/O"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02olkn2046.outbound.protection.outlook.com [40.92.48.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F6541AA1D4;
	Tue, 10 Dec 2024 14:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.48.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733839844; cv=fail; b=Azvlg5kDRzzRh/WUhWinAopDNnGfOGjXKSXyiWxPppjl8bmf6sFVD+AlrUllKKw96fWZ4Ln3VumFQsBkx/FTBM8raOEwvRnSMWcacHQ4gIb08bVxaBfxugdYnUAiLFQZs66FMwgBpvqy//IhFdvQFZaYhnwzbZIO8rEdSFcuoow=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733839844; c=relaxed/simple;
	bh=wK3FzXuQpDXmaSzr0vURQaYKg0fxON8Sw/uCWWRLeiM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GQD9ntqAk1J07f5TQMuDH+K6ougE7KQSG27OuWRNW5XXR9F+P8WCbj3stALQZvq5EoGwgFtKrGTv3xAgpxgamxhfbyMkz6XfTTgQLm9NADG1hfuvkua/4Zq/3QtyWl2qZ26kliTZVQCyZF3DrMiH994EySopVCyXMVet7hdWOv0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=QqPp+g/O; arc=fail smtp.client-ip=40.92.48.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TsqZHyGXECfXuuFOOnP+ChnLSh7ZTYsdawWV5Y07LnWf6p06sI/nMtkDChlbHLnHzsa6u4ir3u469E4EixGCXuaeOT+VD+ZZcT3247yyWPhSwQdjOt+kU6c/JeY+lszItCiTjM4LefhdvWvfr77dKXdYwYtWJUPE7P6alC/AEU/yATNbVYWNawteNbEoT1bUhKMAB6qu3+6ACvJwVguJnUrQZJ0DkUoXFwhalQQzz+cqFjS24NT9NBS6NC2bKfwSIkDDz7yGpDZEez/3yYJkuz6f99RfaXU/RU3DCAZwB+HZfXr0a8gMdMGfDzxo2uNOxcZValhLJOIbW5+oF8yDIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yaoaGdtKnNqICPXFl5gVmGgFsml4c7tLCw2b/4JCy3k=;
 b=LgtfbxzYQu7uAQNbSTFWlhzht014qNv+Oj/7Ne1IMWUcVmdci80HVsfg/ocZ6SPSVlB1ddw+B646U00Yq7Jkdps95JgJ+UkA96BUL+WAIDe3ANg/MpaMIO0VGiE5wuvIjugvlKjCH2ndS2sKL5DQ95rxNWyHhe1X+rs34vS20NHkoHa1InxBkx9iBsE7agGcM7KcdXrd3T0XPrSW3Z9EcjNIPZI3eDtS54ZekAZ4P372S7y43e51I6FqFlC20eVJQPRGAAdJ/EybnyT2B9f2I7beBqp3bJynesdtwB/V0FpAn6CRdRhRD3nxpSXQXmKz2AMoyA4dqXlxnlefdtkMAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yaoaGdtKnNqICPXFl5gVmGgFsml4c7tLCw2b/4JCy3k=;
 b=QqPp+g/OWgALC+xThaw7AF33at9VScd9yGzTAUdH7EMlJGhSuu7AxuUK7PZKi3aB5O+B6klgeCRlUBai2iEoaJahyL4Fy3U6KtkHGguW9e/ZLRy69W7j9NOwyZu3XUI/9O0RF7WlZpCYnM1j1e3kbZduMyIUj7gSgXnC2lUOeqUNAWdCT1nzYB9Awndpq5F2WsKU2S0Brsh3Dxqdn9eGK/S2Pxiu0oFtRi2jZUdt85nGJos2yon/2yvAw4KDiX6rhsH2B9sffAEeisfTr8uqhxdzRGIi6EKLeUFZ1fDZ9/IhAkko/6aXlo+/gL4Nq+ADyOvjfGsyB7y77CQ1F9PBEQ==
Received: from AM6PR03MB5080.eurprd03.prod.outlook.com (2603:10a6:20b:90::20)
 by AS8PR03MB7704.eurprd03.prod.outlook.com (2603:10a6:20b:403::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.19; Tue, 10 Dec
 2024 14:10:39 +0000
Received: from AM6PR03MB5080.eurprd03.prod.outlook.com
 ([fe80::a16:9eb8:6868:f6d8]) by AM6PR03MB5080.eurprd03.prod.outlook.com
 ([fe80::a16:9eb8:6868:f6d8%5]) with mapi id 15.20.8230.016; Tue, 10 Dec 2024
 14:10:39 +0000
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
Subject: [PATCH bpf-next v5 5/5] selftests/bpf: Add tests for bpf_fget_task() kfunc
Date: Tue, 10 Dec 2024 14:03:54 +0000
Message-ID:
 <AM6PR03MB5080FD8ECBC1430F38BFD3C7993D2@AM6PR03MB5080.eurprd03.prod.outlook.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <AM6PR03MB508010982C37DF735B1EAA0E993D2@AM6PR03MB5080.eurprd03.prod.outlook.com>
References: <AM6PR03MB508010982C37DF735B1EAA0E993D2@AM6PR03MB5080.eurprd03.prod.outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO6P265CA0010.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:339::7) To AM6PR03MB5080.eurprd03.prod.outlook.com
 (2603:10a6:20b:90::20)
X-Microsoft-Original-Message-ID:
 <20241210140354.25560-5-juntong.deng@outlook.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR03MB5080:EE_|AS8PR03MB7704:EE_
X-MS-Office365-Filtering-Correlation-Id: 5740ffb6-73c3-496a-dd16-08dd19246cdd
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199028|19110799003|15080799006|5072599009|8060799006|3412199025|440099028;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?RyVWd0305g+G3J0rK4hQl9DSObi4eZwr2vi7ET3OPeefI1pBujmdUSl7MeAr?=
 =?us-ascii?Q?a4MYJ4bJOg0CknOH48STWlH54feua57hdlgtUhUt+SIRjn5dL1tufw6jvnmc?=
 =?us-ascii?Q?ikZFmaROxTxvX8akUQ444LUvnLNmCc0YqhOL6rHe7tcg/wLboWUmP2Z4kWEv?=
 =?us-ascii?Q?XE1gAWhd4XbMVINJaodO4l44mSoP82U+A/Rp8oe7PI0KkUTKeUrroF/CFogT?=
 =?us-ascii?Q?WEc8EvEzesfmSQrcBHHD1MygzktbzoVm96tTSu+3Sh9C54VHpPh75PFeQw+l?=
 =?us-ascii?Q?5L65rEA+Qgy587E7f844CWp686moXHzE26lgD8dTEAdiX63dOcYQdmmadhyY?=
 =?us-ascii?Q?1M6Bg6tPTkS/2wwZ35rznyYnaORanCJtej6llwH6J8LCvjXfbNuSwYgLKTlh?=
 =?us-ascii?Q?uF7AjAbszdLqFyOhQjZlj92tF8nqcM6TFlrfHZdSH4WacTWZhOpwWq3OfO3o?=
 =?us-ascii?Q?p80KZGKAcvedq+08sAv6TvNbfYASzrm3HPmOmn0aMWR1iPZrQ42CtgzQOYZN?=
 =?us-ascii?Q?u99UWg4/4sUufMEYEycZCbNpZ4FRe1Zj1JBZAvrWfw8ZHoczQvM5oT/yUR5p?=
 =?us-ascii?Q?Ct1PNh1gAgnWzo5e4F6KtXJEeFLCdwWStsgoJxIDt/tSdhFrULBugCOubUv3?=
 =?us-ascii?Q?3Rh+IN+MOEHfPpaPeyJyFs75FAoj/Yj7HJlZmZdl5X7gsB6g6AQ/3ws/wjzP?=
 =?us-ascii?Q?0TqVmVymOr40psVD6xbzzovUa3V7QBwjGedj4/oEpcJGIWL6wWHxSMiCuqJv?=
 =?us-ascii?Q?jaAfIlP+lYgSkmB/67adKMlDqEgbXDcBdRGmcOliFikU2Xm9j4LyOUG63+yI?=
 =?us-ascii?Q?Ok2TFdkrjrdjz8zVjNlEklfzXH+rQO8rV100I+UiFSNwLCoySeNTuG/Ipcta?=
 =?us-ascii?Q?nraPr6hLeO+eQGGcOutz9mfAWAGvhOiEfyu2L1noC880srUlojt/Bm8Q7nLL?=
 =?us-ascii?Q?6g7rb43CY58jVIV8akkKWuMbgn6L9zD8dTvPuGb/YaJGHkteHtiwoCh5g15x?=
 =?us-ascii?Q?dHta?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?36xPAWi/0bSwCdrExjlY9Wk2v3GA4m5AzFOJF1eo0tyOyDSpket1itzQR0DQ?=
 =?us-ascii?Q?YsYXWZ6hQsMKs6hmwce1OmGniIbQbjq7Vi5uybmiwdfZV2Z5wQNy8G01O8dG?=
 =?us-ascii?Q?jcSLY4YnV89yn30euid/lSUNl5GWYmwQgrT+t76Vczdqm7IRchvZxl6SyFOf?=
 =?us-ascii?Q?GYXKabCMiDFeu/vSmJ0JWfGj71L2+H54mBv2o7+O93/9k6/n+hE+WtcsEkhQ?=
 =?us-ascii?Q?eNFqwD42acc4zJGzcDGKdviVdWCmJBJ25McGMb47+yYry8gsC4fjiSSPOrBV?=
 =?us-ascii?Q?X8XYFPdZJE+IdV3uDp5IVYDtD9qWJmNdzR960sJ12xM8oj4tEdG+76bounMO?=
 =?us-ascii?Q?ESQWABoDBer9JxYvFNl+4dhyOz31wkWm9OoeR9BpTksZgOmUi15PdGjATLic?=
 =?us-ascii?Q?0ycCqWUei0VPVGI0Nj3vkevG/j2pgucq8BUJzyUcTL5Lo1QAB3GpQnfEdPGB?=
 =?us-ascii?Q?Ffet6tX1wVZLMFt+09L8b6+kOlgZxad1RDZkYKCLJiBpTqvELPR6gnaEnxFR?=
 =?us-ascii?Q?Pybea837cdSrCFpZhwD0nqA8yLn9MdDvA5GdyL0koRa1ZhyEG/lnRvjHviH+?=
 =?us-ascii?Q?hgi2xYURnZEAXpjJWsroRxO78jYm/ThbZZBo3kPLpbeSlsz7zbRqYd77E5iS?=
 =?us-ascii?Q?FwgJDgzx91PK5RRTtJFBMwRPxKzhmnHePnMDINP+5jIrZj9ZC1xGQHCDewl1?=
 =?us-ascii?Q?9ySjEGflEYTYW7BNr2IAb2l4f5EXLDmFYfSnfe8CRszmgzQqxCzK8zb5bNnQ?=
 =?us-ascii?Q?Yr37dQzmKlZ2rIO5XJ6n+7jmn8TmqWWehHBkW2oxm4uFkYulAc77G6koC2Nz?=
 =?us-ascii?Q?d5DGlhqKxXhbizjZDfM2EP5m+7z6ZPa4JJB2/L6COKkQsHWpwMqVkRQTNoD0?=
 =?us-ascii?Q?+KGA4LyKnHdcd49nfi9/ctpiL/XUW6bUjB2nhXTclywJM8tQGVNopqs66I8f?=
 =?us-ascii?Q?oRW7tB5rdedy7QpX4UT4kB/UnkOHJFbI6Bu7BNJGKEqXeYzHzdMp6LVcdkld?=
 =?us-ascii?Q?1dapobjyZmqf/eZJKsxsUdlkondg9xLzmLyA9kp2wCLvSPCS/RpHVB3zK1IQ?=
 =?us-ascii?Q?0TczKerGd2kRxREkiqKocTIlvmlZiLo5c1KVMDASmhTCm9DNDy+u/qXRY8dX?=
 =?us-ascii?Q?0rO8dS20uOejQkzO8i5qXDo8BYhxFuK4EBrMPCYxoqeqOAqZXoMCHPr3q9Am?=
 =?us-ascii?Q?F77nI3y4qvdwIT9HP7KuF3JY+8TOSgq9m/gQ2z1DYRBWWGQn19Lrof4wSz4q?=
 =?us-ascii?Q?H7qjKnj/A0OebT+6cSlb?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5740ffb6-73c3-496a-dd16-08dd19246cdd
X-MS-Exchange-CrossTenant-AuthSource: AM6PR03MB5080.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2024 14:10:39.4951
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR03MB7704

This patch adds test cases for bpf_fget_task() kfunc.

test_bpf_fget_task is used to test obtaining struct file based on
the file descriptor in the current process.

bpf_fget_task_null_task and bpf_fget_task_untrusted_task are used to
test the failure cases of passing NULL or untrusted pointer as argument.

Signed-off-by: Juntong Deng <juntong.deng@outlook.com>
---
 .../testing/selftests/bpf/bpf_experimental.h  |  8 +++
 .../selftests/bpf/prog_tests/fs_kfuncs.c      | 46 ++++++++++++++
 .../selftests/bpf/progs/fs_kfuncs_failure.c   | 33 ++++++++++
 .../selftests/bpf/progs/test_fget_task.c      | 63 +++++++++++++++++++
 4 files changed, 150 insertions(+)
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
index 5a0b51157451..89f5e09672b3 100644
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
+	int pipefd[2], prog_fd, err;
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
index 000000000000..fee5d5e1244a
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/test_fget_task.c
@@ -0,0 +1,63 @@
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
+extern const void pipefifo_fops __ksym;
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
+	if (file->f_op != &pipefifo_fops) {
+		err = 3;
+		bpf_put_file(file);
+		return 0;
+	}
+
+	bpf_put_file(file);
+
+	file = bpf_fget_task(task, test_fd2);
+	if (file == NULL) {
+		err = 4;
+		return 0;
+	}
+
+	if (file->f_op != &pipefifo_fops) {
+		err = 5;
+		bpf_put_file(file);
+		return 0;
+	}
+
+	bpf_put_file(file);
+
+	file = bpf_fget_task(task, 9999);
+	if (file != NULL) {
+		err = 6;
+		bpf_put_file(file);
+	}
+
+	return 0;
+}
-- 
2.39.5


