Return-Path: <linux-fsdevel+bounces-39881-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E7B2A19B5E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Jan 2025 00:11:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E72081882250
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Jan 2025 23:11:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 830251CBEAC;
	Wed, 22 Jan 2025 23:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="h59vDn9e"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05olkn2070.outbound.protection.outlook.com [40.92.90.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2D591C5F39;
	Wed, 22 Jan 2025 23:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.90.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737587480; cv=fail; b=SyZ9kLa5VCohWr3Borl/uZMfDgcF4ndvUH4BD6DoZ0AjOMh9nuruwtZb23qKFL1UbvQ6S0EXIFomKceN3v4Ei8zW2Ii5Nv/xzIWjpzXQygrhM/sFzNesOll5YnIQZpvl6VgtYlHi1H/QJoTWmu/r/ma2UFNg+7dnuxgxrSPf/6o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737587480; c=relaxed/simple;
	bh=wK3FzXuQpDXmaSzr0vURQaYKg0fxON8Sw/uCWWRLeiM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=sEweCPOprskAgmyTStyfUXEsTxFOEY9YRLKP3xuSsG/dY02NAsmJjTHOZ1drqbvvw56n9meMEjZl0kqMm6sfN/gSJ3DhAPHJT3JM0qEMRC74kN7k9TmFDn+B2aYJASfvM5kJAUJPISDU7Xkqd40aCIBaJp2B/HvZg4eD700cMf4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=h59vDn9e; arc=fail smtp.client-ip=40.92.90.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fgmJzZYNrrwJCRFWGQYaTEPDTeDO8UN38j06L9twt8kMgqX1lvUCF1sGCu6D10nvL0wm9/uGvUiLaQx0s1dK0eQitCb1wWqbMDvpSuuSztCEpknWKnkmtwsUwimnuFLgUCQTC+gCJfRIYVQ9MpAJx6NJWiN4rPCmTVeAgA+gC0DXieR8EmcS/OINJ7+R/Q5+bEFhh0w0EErOL0k7a+bvkf5HWnqHamOJjttcr9hQk4lzZmQjV4E9Wy4h0wMltwRniSHUmM1lq9WkSJI0IOkAUGnabworivb3ijtfTn69x0U2dbIe1bdfsWyyy+WeemxBuXgbmunDJ752IJXAcTRjtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yaoaGdtKnNqICPXFl5gVmGgFsml4c7tLCw2b/4JCy3k=;
 b=qdXLFzDbGFdkqTwxFiEdyHJrnY5deNWAz+buyvVd3axa9hglvVCLimHzNP3+4SMcmGS6tGhif2UqJq92Mkk/2jgXhi12n36RxBLxlhSP99/Z20pXzVb+cfT0SVFve0wYtDDQNhh1i6JPyl2biJ6MxltcyFQoRKXpKJTTnqMQZUqUfolXmu+Lq5i57+s9GOEDDzPga8NTosT1gnwUUnuEo4Nw/Ecg8CyOXl5mb/y/6lu8Etjw1bb+Y/xUjZ6COYEEm5OIICjUEYEVdu4kGAid2cjj2XuWBAYQbrfMscBV3qoymQ5KK4mj04mSjnJdk+bA94PRNGV/+BJXNEyg0Hgpkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yaoaGdtKnNqICPXFl5gVmGgFsml4c7tLCw2b/4JCy3k=;
 b=h59vDn9e06288fLEYezV3/xVBMxMlCyjngGu6MbydMiJDJi/TvPCCD+z/mNGY6QKiRsKCILV5E6WGGwFzI8RG2UO+GPbjxOmbQ9Xchdt+RMk5g9TSNxmceZyEAtN9JzwScVpnDjDeZ9IXBpcd6fJAvLjjyNGrSpyYvrAB+Bs1xUjBgsopADWUcadZJex3BdwpRjUdQcoFkNCb2IgR3HdS7b2k/T13WmZ3ouk7MoSWEIan/X3hP9ZyMJlD1sfRZZUVhkuaMx8m2Up2jU5tVNIrsvauGhD/Ou0uDbi0Cm4ur4489tdB4wzGy2hpC/Na9bQ/ssEKIJYn/NLgHmdNVMtzw==
Received: from AM6PR03MB5080.eurprd03.prod.outlook.com (2603:10a6:20b:90::20)
 by DU2PR03MB7958.eurprd03.prod.outlook.com (2603:10a6:10:2d9::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.10; Wed, 22 Jan
 2025 23:11:16 +0000
Received: from AM6PR03MB5080.eurprd03.prod.outlook.com
 ([fe80::a16:9eb8:6868:f6d8]) by AM6PR03MB5080.eurprd03.prod.outlook.com
 ([fe80::a16:9eb8:6868:f6d8%3]) with mapi id 15.20.8356.020; Wed, 22 Jan 2025
 23:11:16 +0000
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
Subject: [PATCH bpf-next v8 5/5] selftests/bpf: Add tests for bpf_fget_task() kfunc
Date: Wed, 22 Jan 2025 23:04:51 +0000
Message-ID:
 <AM6PR03MB508011569947E4698E46596599E12@AM6PR03MB5080.eurprd03.prod.outlook.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <AM6PR03MB50806D2E13B3C81B0ECDB5B299E12@AM6PR03MB5080.eurprd03.prod.outlook.com>
References: <AM6PR03MB50806D2E13B3C81B0ECDB5B299E12@AM6PR03MB5080.eurprd03.prod.outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P123CA0049.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1::13) To AM6PR03MB5080.eurprd03.prod.outlook.com
 (2603:10a6:20b:90::20)
X-Microsoft-Original-Message-ID:
 <20250122230451.35719-5-juntong.deng@outlook.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR03MB5080:EE_|DU2PR03MB7958:EE_
X-MS-Office365-Filtering-Correlation-Id: 50f6a17d-db32-42cc-1214-08dd3b3a123c
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199028|8060799006|5072599009|15080799006|19110799003|440099028|3412199025|41001999003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0Clj7diGiGCgheyCF3HL5AMDuefj3tf53P++7kVxj/3i5U+WqUOQtqLTn4n5?=
 =?us-ascii?Q?CpTY1hhqe6cUib0NQm9+8MbR4kqOuIBRcnMLRfwBlLTdNPhlthabgM4oKORc?=
 =?us-ascii?Q?MyUtqYaIgzDxCzEtGmJRTRNDPd+Ox2UPWUjXwl7XJpJCjXRWEu4JzfwAPGnZ?=
 =?us-ascii?Q?3SudNFoLw0UZdR9U1iTIrKHDXva/XAwxNKGgY4DHdjLhSCFQGskEdigwne38?=
 =?us-ascii?Q?kgnhJZOPxlhiTj8ZLZ+80v2CsenOfAi3XrHf4KL6Wn8WXMWE2LNx5dhajZ3w?=
 =?us-ascii?Q?GW0GkRrUqU+MXwL6wPsLcXRlNQsApswWGY/jLEQArvieT5lkPRfvMJFuDK7/?=
 =?us-ascii?Q?SZulU4+eqNcVo3FQHrH0DNZfu3lI43Iekykah6Zpcb4K8euX4IGb128GVt7c?=
 =?us-ascii?Q?ENnpC4fJH5MuTlE2RPQvm2MpcmeQjMzadB7qy5GP8aaaScG4CxjgMyouW5Jp?=
 =?us-ascii?Q?7voFImjeH5qw6vlxIAr3Dca2yiCThuZCSF3z06K5Md6yzZFHqFhQNpHCstee?=
 =?us-ascii?Q?pQDxYm7Uu2X3HWxOf3i/mbmr5JytQBYBFTlAYQcfdUBlDVlfYn3hCn9ihGGm?=
 =?us-ascii?Q?uVhTekpuyUzrTpFSaUGgC9ioirhL1KlHCtmaVlrT26RSIISVOEgqloPqGL+i?=
 =?us-ascii?Q?uRJq23dCiIrA0zqlrvK2Q7vWbFDeP2p0Iux39RQlsOFi38N82Mac0EFcwpqq?=
 =?us-ascii?Q?72Vm8BVtmyo8NciuPRx60CYDe8I4t/3LzP66vVweKVnTGuSWOd/Lc19nPDcm?=
 =?us-ascii?Q?eyKphZuVm1OrE6tjvywE73RX/Xt9eM01W2fW+n9vRI81T4KpVP6Xv6FqF7tv?=
 =?us-ascii?Q?JAEZqCpfH/XUilUXsi3IasCbO+ZCBmg9IWK4u8+tAD/wUSYZONyZ4WUwkghD?=
 =?us-ascii?Q?BnHz2Gzvn3eGQxQFKZuq8OpyL2oyR7TTJpT1fa5Cjh0tS5oLmeGotVDU7mKG?=
 =?us-ascii?Q?jF79cX9Z1d7tIisYQAb76Sgp2JhXsuAE4jfvD3PjjIKZ+oTLyJDd8PauAACr?=
 =?us-ascii?Q?BwTkhS4TrDd5dyyt6xHm2YdAI2gq5zoPf/RuGNZEy34nMkn9OPIYIekzqvph?=
 =?us-ascii?Q?XasWvWfayid+/5QqYmF9H1kbslg0DA=3D=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Jv1aB0c0GQ02lVPrJ0e9Yqlj74M8aFxprFXlNU9o03I5eSBAXJDUfA44bwKq?=
 =?us-ascii?Q?uZ6M+3TVRc9m+bLwUGy9DXuNO3rJnqYGrp+UzPsBtmdtFOQYcKIwiR7wk36z?=
 =?us-ascii?Q?LC9k4pnzudI92LjPBC1xUNNnSwyckhnm3FEOY+kj5tPJp3nkYiEfu8unuvGB?=
 =?us-ascii?Q?AxHgMOwuptGPzu1ZK86C/9QlSnMwpu1OF6NeIURMXmKip5VoGE+RwPg+i2o1?=
 =?us-ascii?Q?OY0hs63Y15vCRs4KcGW3q6EHfFVWPpnyf98fDhKf2E6zowxSxcfwPuJ8rV3B?=
 =?us-ascii?Q?xbympAElLUzmCWTXa/YGw81TcWm9ShpfML6enhEHp+VG1Q4fmNsBq6ZEAB7s?=
 =?us-ascii?Q?5ri/gXj9yLkl3Rq1xpbVEJ9d6fcqedGXQri09eqyrC3dG94WsweHPJZYM+ZC?=
 =?us-ascii?Q?PTE3jeKpbt/lYWBoQ2HDot1aoNISDuF8P5D1/y5Rt05Mzc7qRwzLsiUbxcx/?=
 =?us-ascii?Q?qO41FEn+z1Wi0TQr/70dCptCWB2B/6UyQFXuRtl7KTLCiHUTFGh2ari/Ef08?=
 =?us-ascii?Q?u3BYr5z2ywN3gnBZaXYzMEc0u57B0GBHRdTlw3xUpMOoso7Q0rtjRcL7JLk5?=
 =?us-ascii?Q?W6lKm02Il1op/s9UbnhqRhqmEcH+kdQ8XMmfDoy90JHzj5vq/p/ttc7HZtbh?=
 =?us-ascii?Q?kYHloIa/emrr8XVvmrYmBD5X1pzFKZtObbUQOH1h2b8etpFLXShqtAYwhq6y?=
 =?us-ascii?Q?hBeF3GrKG9AwZa3dkgbM1FHOivogzSGn1p7oFQuI/1VfVxqu0wBSI7vLLElY?=
 =?us-ascii?Q?3GMSK20DWng+0GHsfgFRmq+A4unqMhbVMv7Z16MSUnCgAKWNQfnTTDY48nGV?=
 =?us-ascii?Q?pgCdHJO8U2X7vBsamaIdijtz2jQRYaJ6PPqdGSC75J3Ns2EiA3Sgbn+jB/dV?=
 =?us-ascii?Q?PSkpHX/KzQyLnHj5PdGMHUVt/2xsYdUodaZlHSf813faHTc/3/7R7YNViXhk?=
 =?us-ascii?Q?hrbRDhR4U7bwNPhzJX6Q13RsKess62IJ9NnjPbVfkl+GjJhCcP5VLK/cZuJu?=
 =?us-ascii?Q?N6R8GsMvdzSKmxZVJki+RdUofYq7uzytD3DgpF1ev22UHxOQOmcnP/83+fNW?=
 =?us-ascii?Q?4nlQRkKKdWMDRD7qixldQd3YvszBwzTqKojGQ1m4fxuQmZX+h7xbuxgmd+EP?=
 =?us-ascii?Q?gJBeNq0sFigYK3EIm332swU7hkQMdDHYmupsafR/tBSIYd3dR4xnOwwIjnzy?=
 =?us-ascii?Q?LCKeBXvtJqU7GHaBemCXBgU4NtDoLShpK7eA4GVjI5PZJ2hUo5p10LQO5n97?=
 =?us-ascii?Q?EYSqvYrnudodlmpDEaNm?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50f6a17d-db32-42cc-1214-08dd3b3a123c
X-MS-Exchange-CrossTenant-AuthSource: AM6PR03MB5080.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2025 23:11:15.9505
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR03MB7958

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


