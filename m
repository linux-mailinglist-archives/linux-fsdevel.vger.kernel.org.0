Return-Path: <linux-fsdevel+bounces-37683-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 460419F5AAC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Dec 2024 00:47:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B1176189247E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Dec 2024 23:47:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DFDA1FA827;
	Tue, 17 Dec 2024 23:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="RowY4RSp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02olkn2095.outbound.protection.outlook.com [40.92.50.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FE201DF969;
	Tue, 17 Dec 2024 23:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.50.95
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734479214; cv=fail; b=Fdu9sRU4uii1qc7L8GWwpop0gCldOORkizlZmC9aG9U/9dMeZrLuhnnuXLI/UwhzSBiNJ4uS0r/e7JkDGJWSAj/0sJGGXTgmlzaaCPQcxqn6nUIgBYGMF15qYYhnflbIQohui4Nmfh0utyIFmrXYxNTHGZkOxZqJV0vbXGPeZls=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734479214; c=relaxed/simple;
	bh=wK3FzXuQpDXmaSzr0vURQaYKg0fxON8Sw/uCWWRLeiM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uZ6Y1Eqt+nVpCFJ0Q7vnnhT0XkvASFm0vI25kMTPP3jIBNzx8nnqA+LDK5+FfjiMPEu6/NqGypadybfhUCwXbHe6NloCiURS3LMioayyuEtIUKx63/vCdF6gcEn5ojrRFi0FokERU29szKIyTrXBulKW5RAnfti8nUoYps90TfY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=RowY4RSp; arc=fail smtp.client-ip=40.92.50.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fm8RkMDwxPYaVXf5ZLb0cFK2a51TcYwGLte1gG2dTZpu8ZiWQuGkKMIR8GqVzie/IVvhjG9ixjjv51PFHHfDWsWLsobKpscw2MFOifA20WWklkuDHwlXUrqDAoo0a2snSEgBpKCqcBMyKA0L0f9n3chdlQlhkv78jIw+8vMOOrC8Ng/M7LtAA8Wd66CKTmw69j/N1Hg0JiQ6jkmQL4z2d+AUaVKwikAkdmFWAIAvRL5m1AY/z/l6Liw6w47lzGYoey6mOi92VM7CmqGuVwElZjJbXYxcvrZ/UdfNS0/z1hR5TUhn8NzpDdn8nRd9l2Iwnf/79HwJZPbhC5PG4cXi1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yaoaGdtKnNqICPXFl5gVmGgFsml4c7tLCw2b/4JCy3k=;
 b=NeJDmUOP6E1angZQR3IIeX3uc/jzQu/Vi+EDNPhYpp5vv/B3HOScRWaT72rrb6g522znpiZvi+4Onrkm6jF7sCBgZF7hbjDqrGQx+rCN4//gnjq/zD+vvh407bUb/J3L1j6uEzEOFSgmmEZSQlZzlyzWeJ0TgAadIW8456BIv78NvGOoY2P182CYoig/Z78UaDWj1e4ciGcyf57B50La9i2EkDqI9XvyG1/L15s+GUU/voA5nFosGhX4vAJltFmet043CLWWgZvWUri78ohd6/4XP41rzXdJ9V/SJ7asKoWwYphwWL/pFlkBcX5ISLMLk3+cs1OK3W57HxD1hdg5Xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yaoaGdtKnNqICPXFl5gVmGgFsml4c7tLCw2b/4JCy3k=;
 b=RowY4RSpjf6ANc77/2Q+WMqUA8AMPHou20EI5ZDIAvA6muhn6gBtMpndwmnoQOwAiGNsylsYAccTekp6FBZRTfp4CFi9uawkAuVI6ClgL35t5hj2i/kXUhRSd812yJXsH5FAe0n7AyO/735SnH8zLNLEW43DSO3v6n3+dtsozzB+5DH21NCwk9IlVomFepcZl8bXW7hZwrmuSO/GHc3uZQX5RmTziwjSHIDC5jXTgXGt+vC4nUYJBnLf13S5QhQA9C/tooyWHLM4mlP0to70Cczmu9FEkZZ3PMvsvMnB605hh8hQWylbb/M8QGFc4i5QU7//NVyCFgQRWGKho27H1A==
Received: from AM6PR03MB5080.eurprd03.prod.outlook.com (2603:10a6:20b:90::20)
 by GV1PR03MB10502.eurprd03.prod.outlook.com (2603:10a6:150:15d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.21; Tue, 17 Dec
 2024 23:46:49 +0000
Received: from AM6PR03MB5080.eurprd03.prod.outlook.com
 ([fe80::a16:9eb8:6868:f6d8]) by AM6PR03MB5080.eurprd03.prod.outlook.com
 ([fe80::a16:9eb8:6868:f6d8%5]) with mapi id 15.20.8272.005; Tue, 17 Dec 2024
 23:46:49 +0000
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
Subject: [PATCH bpf-next v6 5/5] selftests/bpf: Add tests for bpf_fget_task() kfunc
Date: Tue, 17 Dec 2024 23:37:05 +0000
Message-ID:
 <AM6PR03MB50806FBCD51BDD64F9D2886799042@AM6PR03MB5080.eurprd03.prod.outlook.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <AM6PR03MB5080DC63013560E26507079E99042@AM6PR03MB5080.eurprd03.prod.outlook.com>
References: <AM6PR03MB5080DC63013560E26507079E99042@AM6PR03MB5080.eurprd03.prod.outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0117.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:192::14) To AM6PR03MB5080.eurprd03.prod.outlook.com
 (2603:10a6:20b:90::20)
X-Microsoft-Original-Message-ID:
 <20241217233705.208089-5-juntong.deng@outlook.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR03MB5080:EE_|GV1PR03MB10502:EE_
X-MS-Office365-Filtering-Correlation-Id: 7defab5f-a513-4c20-4f9f-08dd1ef512e1
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|15080799006|19110799003|5072599009|8060799006|461199028|3412199025|440099028;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?lASmZNYwIOQuRFyCRs4L7sdxHwhd29dY7x9c6KGElDnAgT9M5LoJCRaoiY9U?=
 =?us-ascii?Q?aqhYseCxVTW1eV39F9uFdx0xDBMQ/0m1jvN8ZW0qkuSIaIC9xppgzrAZnsnZ?=
 =?us-ascii?Q?kqpJe23/Dw6EgdcAeC/v1e/eOKedAUri9XYqdrBiRlMGfVNWOgPRTwGHwbrC?=
 =?us-ascii?Q?yiRhg+K21y5HB+2wJeqvTgESmBh1B57oMGJYcXwzKkEwMVStDOL6BKH8wwAY?=
 =?us-ascii?Q?QlV39JUbEPoyMGZdIcAPtleDCocgB5uogZdg+BjTzqVCJl/E2/rnFU4isO+5?=
 =?us-ascii?Q?5xO1NYCAdniNXYq4/HIGK9LjGRgYTZruMpeuHuCi3Gstd3NKzvBWnrrcWm9c?=
 =?us-ascii?Q?d1wQ4ON5+dmA6HvoKB3B+xFGrbOHFMGV940cCbB5Qt+/IIcNmQna0Ev8un02?=
 =?us-ascii?Q?xuqF69DFYMziyOwnUDb8/7Iy6iCbSjeifVTiIaf2PpXcE4B4OOYRnQa2llD8?=
 =?us-ascii?Q?p8gRlXSapoRXuZ8c+iytmvzdb9ccLOwlj2wvdNyp9uEHRYnPFEl9KLquaD42?=
 =?us-ascii?Q?c7eZBrDwfiWhi0db+UIgPrYv6HbF0QQILh/OJJI/Vj4fYu4aKyBCrpCuaR98?=
 =?us-ascii?Q?jyhE2uRlkvxm3uN4DZk6BgVAUhZlf/2d0Nlj0SYAQauPr+xIT/iuYqjhd63h?=
 =?us-ascii?Q?33g97ndBDnMPcyOkWaHMlbo42K8kZO7c1rODqS67sRxIEh+MC+OKcfdjbgHi?=
 =?us-ascii?Q?KZArFu+8YrnJ9FpcpqmnO1tAftpvLMRYLAd/TxTqOblUG2bMVBvNNM2+3dcE?=
 =?us-ascii?Q?JoE78AxCJLLkJnbhT1twJzH3D1Gg4+NgEBfhpA9rLaQ9D6EPUwF9oq45exlz?=
 =?us-ascii?Q?LpzA3DsnZiobFwnMEMq2gvhouv0vOt6FpIcOPZBwP0NeliPEfLsdaLP996iT?=
 =?us-ascii?Q?ZlKLuvfHOLXPsprAEbDiGasIlk2f1F1ij+xzMRwXtChaZt7hLtHNlArF/rfo?=
 =?us-ascii?Q?tUrw7fHC/lARj9InYHEj5271HCaoSBRzG7V8DjXxdBivFdABfYMyVRdVvHmj?=
 =?us-ascii?Q?evKj?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?khr7KHGjDItZSW8xMCTkQC4yZWHZ119V0p1SQ2LVJ19ZL9mmJHEoOeEuN+K/?=
 =?us-ascii?Q?FsSKC8hZLO1tj70xXuPYl9CMqEZ/DInyBAlvbs9zsubwiKOTIDbpQ+0N4tKw?=
 =?us-ascii?Q?RVm+t+zKp2J2Yo9thQ0whz/7bYLMJejmbCE5eXBMoDMc/LbeJWMnYwocSrKT?=
 =?us-ascii?Q?tUPBoT/Itv4rp+tk689jyj4d9wDws1rX/r4tLK73OMjsxjxXD075U/O4yNjN?=
 =?us-ascii?Q?LN5+3tc11BNVmh6JVz/sZUvyh4WGpjI7tuyrJbgez5DQ623yAQos0jyj32+E?=
 =?us-ascii?Q?IKzVPaPUurq6lkUVRakngn0AcqUOePLLReE+Ls0fWRvaA0+ThoXCfOnhVbgl?=
 =?us-ascii?Q?Sd1e0RuJ3fgXopKaZWnM2I1cyzZeKAA3vkv3UxnKjp35nxq3yqhqcwT6+208?=
 =?us-ascii?Q?+aAHEIlHCayp4M6QYdhKVNFA+suYmZkkDQ6xQEySQ6VBJ7BWAQfIR8A/qttf?=
 =?us-ascii?Q?3bISo0xUhmGfF1eeMUxB41mpfXJSbngjqCO1Dg+hQXWcWs/76uT6JPCFIhTU?=
 =?us-ascii?Q?A2TwEDurM4hvOq8EMgRtPkvz21aN64nlgE/opSOYlps72KADMMZ9Z5NRy+Qp?=
 =?us-ascii?Q?Jtox/0bY89YE0yTvrtghRIxd/txrJBYeqg00jwRmhIrNUQTRNbVThUPiXy2X?=
 =?us-ascii?Q?Nmdljt6NrSk81nAj30Z6DI4aiin56Lo6/0W3oC7+RdnJw4lm97uyUOymM+Ns?=
 =?us-ascii?Q?03q3Rka7t4V9oqRxPxuG5qm40/i/b3fKmTHLl6L2wIkY7ctM3inH0RsmX84p?=
 =?us-ascii?Q?tjI64InWV5u+dymOuSRKqf6QDPirJscvKKGAwc6poM6LWVZG/fD5RIMSlejE?=
 =?us-ascii?Q?LShwS1z+xWNGuAhSzmbvbGI5o+pNVNGWv+8emwOQ/LaddSXOTd9XxiOFlK9p?=
 =?us-ascii?Q?ozW86GP/snZ+t9c8fvm/nujkCEp9Pi9VNWbKU0MsOQu0BB5QMax87OY/dOsp?=
 =?us-ascii?Q?lZcIbkm+mqT/ryvENxOWUGNzTCQ/OdirC9yFJAsY4UTiaezSkY5zyG9VbMtE?=
 =?us-ascii?Q?7ToG8fBi+hEiATYUYDHWC+98oCk8JwtD4jCKrae7qD4F/JYumJZaANAgxa+t?=
 =?us-ascii?Q?PEfuBAM8cG4pHP0X9RMWWphinW6zdc+BbBUqu2QW2OlFPik77AVbt07V1Tqd?=
 =?us-ascii?Q?j3GwQYkcOAmPJ3vM2kUiV9UW6SGS+PL1+dxEf1B3cbWIngsMOfNOIj8eX1xn?=
 =?us-ascii?Q?x5r5UyJZugX4VVjI3fEfoEypDWtRo6dbN/pguwKLaZWT7A+EVUqAiPgv+25i?=
 =?us-ascii?Q?5yWL/elsdZ4xdBRfONUC?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7defab5f-a513-4c20-4f9f-08dd1ef512e1
X-MS-Exchange-CrossTenant-AuthSource: AM6PR03MB5080.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2024 23:46:49.1482
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR03MB10502

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


