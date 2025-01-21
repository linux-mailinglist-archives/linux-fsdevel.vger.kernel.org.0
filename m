Return-Path: <linux-fsdevel+bounces-39778-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BB672A17E8E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Jan 2025 14:10:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 541DF1616FE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Jan 2025 13:10:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33F9C1F2C2E;
	Tue, 21 Jan 2025 13:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="vKSFGX5A"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazolkn19011039.outbound.protection.outlook.com [52.103.33.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A9011F237E;
	Tue, 21 Jan 2025 13:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.33.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737465004; cv=fail; b=alyYKedZbq2PXt7g5d9Sr897tEpWvvvVxp76CYUArJZ2vUvKQsJWiatGJ7TCo/CsuLf8Wo8ml+Hc3yHOAn8vszgZHmiydDCicUDFcbWKwsIWy6bvipDXuOTW3FbW0z8QQbi1tkj7Ju2xq2KC3Gewg/z1wUiwqI6lQyhO/Neq49E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737465004; c=relaxed/simple;
	bh=wK3FzXuQpDXmaSzr0vURQaYKg0fxON8Sw/uCWWRLeiM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ISVwIYBpyOhSD0qkrrzACsmQlIGYUfPnSd4CCgiwy/huL2iNOm2XxGhtuVCl6PRlPblB7w7SCxslcCmVwr5toP2iEM6BJPE+uhn45PDmbWjgCTt2lS7PdiRZ0JEKwOs1bzqpNlvDT4pcaWDSQSKQJA4wsXdH6cNecYDuQBYBNZA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=vKSFGX5A; arc=fail smtp.client-ip=52.103.33.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kUVpFEjTG0+U9Qe4Tv+Mkpf3Pjchubl8a1KrOH6izYKoUp3+UIOqt5fJqnnV9nFyldhpWiylwmL8o1aqQmQh/tuRJW3fFfVoDNN9/I3/10470YZ0fEzppgk2TakHJ1eTXVMI6/i8z09QNHpwfYnpdJDR0zrr7zrVimA9Zimv0wrFjQnBOVF1eZBHplJzl1bzJZR1ct/cVhnVSngSUfQDt83V7eGfqIgdSrOzA2uwznAYHRIDAvbuKaBXCgqkovpcnrLmKEWezh/jBaPgPTqhezwLVxsPAWqwsOIbUOO0zCs/oQU7c8RgZ5oqDa83FCGibvLXJDqc8se3VjQRhMSrcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yaoaGdtKnNqICPXFl5gVmGgFsml4c7tLCw2b/4JCy3k=;
 b=bpGWEm8sCt0v8zaZ0yVW+PMiTHxJ8ACLCNv1QkT5JQi/fXC7OZ+q9lVX15gL1L2p04T2XnE5bpqzOqaz/vFwGBlAgDr2BlV5r+3Vtj9K0G+S9+WZXXC+uOiEoKsmBpPeiHj8fyD38wDl7wgTyQvn5yKNYgI77LmNSqOiiVz2n+WFc2Iw8w8lWgyIfgSr7OQHP4g1qffPXXcPhTFMAdZLxkmUwrLJM72yasVwnbJaU2+muq1fTfenf7ul+OMqCzbvSaWMd6dfr4/9OGzjn8fTPCySsAmPFB6RqKIThJFX4+o0Zparb1BnU6B6OcM9Cn0ZcLIWW0OBB2IlgWgq2Co/vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yaoaGdtKnNqICPXFl5gVmGgFsml4c7tLCw2b/4JCy3k=;
 b=vKSFGX5ANdfYtgbkg4hBz/p17XziPUNQiijWH5Rzam6M+jB6Cgitm7T2Cg1HDnNUmDkxh8ivxt3G8Jm63eJfS7jzyYMxHIGdmxDx7Dm6WdZZeR6t3mnQV40cEU9F5Hq0g6OQGbG6x8GZUViF6v30nf0FI0Ia32906N+A4v8wEyJpTKv5qAhqa9OhY7ISJ0IZv3bMgbvFfZaKPuv/3f8RMfFNdy6bbmbWG2HxXnvYpVK1Jhs741/VGUkuhb3WpSPqmb3FxE5COYIPItpUz2BWj7bzkmLajn5MSwqWO1TD1db7fX5c+jBfNMaekOUy0HQ4wF5QHnwDHum3hdOeKkpFCw==
Received: from AM6PR03MB5080.eurprd03.prod.outlook.com (2603:10a6:20b:90::20)
 by DBAPR03MB6407.eurprd03.prod.outlook.com (2603:10a6:10:192::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.22; Tue, 21 Jan
 2025 13:10:00 +0000
Received: from AM6PR03MB5080.eurprd03.prod.outlook.com
 ([fe80::a16:9eb8:6868:f6d8]) by AM6PR03MB5080.eurprd03.prod.outlook.com
 ([fe80::a16:9eb8:6868:f6d8%3]) with mapi id 15.20.8356.020; Tue, 21 Jan 2025
 13:09:59 +0000
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
Subject: [PATCH bpf-next v7 5/5] selftests/bpf: Add tests for bpf_fget_task() kfunc
Date: Tue, 21 Jan 2025 13:03:06 +0000
Message-ID:
 <AM6PR03MB5080B74BE5863DF1EA5F964799E62@AM6PR03MB5080.eurprd03.prod.outlook.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <AM6PR03MB508004527B8B38AAF18D763399E62@AM6PR03MB5080.eurprd03.prod.outlook.com>
References: <AM6PR03MB508004527B8B38AAF18D763399E62@AM6PR03MB5080.eurprd03.prod.outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P265CA0260.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:37c::11) To AM6PR03MB5080.eurprd03.prod.outlook.com
 (2603:10a6:20b:90::20)
X-Microsoft-Original-Message-ID:
 <20250121130306.90527-5-juntong.deng@outlook.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR03MB5080:EE_|DBAPR03MB6407:EE_
X-MS-Office365-Filtering-Correlation-Id: 682cb4ae-3a05-41f3-c510-08dd3a1ce8d6
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|19110799003|8060799006|15080799006|461199028|5072599009|440099028|3412199025|41001999003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?iCne5UNU+7NKJ6/GOs8vVH6ysEzc9tNfRqL73mrcyy6EFVWjZFXj/TqQUbh7?=
 =?us-ascii?Q?MU4b0HYOd9qWj47ZgKMANS7fbsV5wKpyW/Fa3+8ag/3xXlmriUFlqhMCaibU?=
 =?us-ascii?Q?ivOpALqoBk8sgRm0bowyvH9EWm3CM+PVJiz9p9ssoJ620JBU7EQTSyqvJq+I?=
 =?us-ascii?Q?HKRHjzEgA4KKxsBkleEHVzMq3G7GMIpzN4SOvLqaxqG3JRP07yUYKqE7xEGX?=
 =?us-ascii?Q?biRCJ1FGmOQ/gFre1cXypda5PqLL5TBLaiJ3zGzoqs+25mTSyQe1vZFigPvf?=
 =?us-ascii?Q?tx21A98C7DC9z/hHzsR00ZUrquXZhq6xoASqF9Kw3gPEbDlEJocGIgBvhO22?=
 =?us-ascii?Q?5cE1FC5YyhTwNaXUIatPUTAvsheXeROxqoYF3etTy5Ds5p6sC71tZBmejzyn?=
 =?us-ascii?Q?pWlbZrdMM7H7zF77wU2+KZ5ZaB/OgBweIUiaUHnNLjVGLyd4G6ViXE12+VBS?=
 =?us-ascii?Q?xyf9ytXWO9vyvNDkYAUtAV7C2iTpDExtp2fpLHJzTyVYVtaRfEBfku262edq?=
 =?us-ascii?Q?NATR9dh+gBk0YV8d4EwsQHV+zG8j6BTjS2iYSZ4eAAZE7i4q/kYMPV8kfLFO?=
 =?us-ascii?Q?OvibXNnSaeFF/BImC7e7I56Nxi/xcrzjPWKkal+Cb2bEvYsmq3Ql8sg4D5mY?=
 =?us-ascii?Q?J96p0kvnVu0iPjenTpHiuWqufX8TxAst6dm1lBc37MfBj0BeINOTgr6ObGy7?=
 =?us-ascii?Q?NCcUachCAg0WdJYqeJqKBmgKAeWS4cnkrbflehbU/1fWzCNosD8xViX7H7pk?=
 =?us-ascii?Q?uVpqwSMORkzp7O+xiMacTiama34pd6Jt5sC0cOLFj9h6NH/Cu5iNWvyX4pt3?=
 =?us-ascii?Q?cRbM+IxPQZTJTnXud8fi8pDfmMHdrWIsk7sB+N5IwTCdCkn6aqBa5JmPDOHG?=
 =?us-ascii?Q?2JXnK+L8upDj9/p+K1QRyYCiJFjAF6BC1BNJHWhCVy2gVI7DxKqxlYNUo6RP?=
 =?us-ascii?Q?BXjfru8YG9qMFTBRmfUZxK4NcGktlp1yO2NhxHGP7oAxrg27+9V3G5S5zP19?=
 =?us-ascii?Q?YnsK3rbuX8Ko0Hvw94kbNT/po/r68ufxatmUCE/diAfO7/faWTfklKanqxpw?=
 =?us-ascii?Q?VWn4xrSrwW8IYsuRr7PRjb7G/LWBIQ=3D=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?v8Bl/HBHcQ3NmqPciR3GBir2LSCNb5eEEPhpYQQso29OKJqRZJbPAm+q8tVq?=
 =?us-ascii?Q?kJ5zT7807l4YOVrX/WAH5AT46O+0ehnDGQLaWMVpd1S4lIT1H9IgNehB/bmF?=
 =?us-ascii?Q?sEed7sOZeEkoP5yIS0nTiP0g6cqL2UY08WZneuZ64R9klAlmJfe5EqO7hHaI?=
 =?us-ascii?Q?pXhcQJuUYjA4pBEIJtYjkYFPZrz65pEY5nY5Cz39e2KmLbnFGDkoU+p3/l31?=
 =?us-ascii?Q?VVinJmiHwYijn+HJvVm/scNXh/7ZD1JsCjKG/sIG9bRp+RoAryn7gDOgCegA?=
 =?us-ascii?Q?Jtrg+doqXzbxkUySKYtjAhBshG0DL70MDA3cPNghvhQqlq0BZnOMRHwNH/Ze?=
 =?us-ascii?Q?EEwY6mWGPrDv/B6OrvgZpnoVgidCenPBe+qXAFwMqVT9I3BwmM+XM0x/4I9z?=
 =?us-ascii?Q?DqJIaPRQ/SuFzIIyGEoj+Om9fXm/nDoF6HBsY0RrU4gUTCEGZ25N9SyBaYJr?=
 =?us-ascii?Q?Xoe2a0VSImYJPePzvD5Hf2bA0qSF8R6CfU8z+JvcZmeRZ5Fj1tLl3SL/EPUB?=
 =?us-ascii?Q?ShnFTZgb8FC8vqoNoBwNPZWNOO63neKhAn06UFDC7eqhzL0fGfsnPiV4S9Ts?=
 =?us-ascii?Q?CdtsyBFoCm1UdMoBL7v5jMmxQPpmrSNq7nDlizKadnyYYFxSKoZVwptenhYP?=
 =?us-ascii?Q?lwVvyCFVbKzi4M57+b+tLP4dJqDaoNgGRdQanZ+c1lQyrTx6JxUh4yY3n6AM?=
 =?us-ascii?Q?iY7o3co0+KGjmA22RvDgIIkHPDgRZhQTLW9T08JKLN5qvWf1/Jpx9ZOcJj2n?=
 =?us-ascii?Q?nRAhM4DINPdsWpyfMpwjO1PGW2yNfLBPXyU6/GTlRi+GYBkonVVL5mAFtcxL?=
 =?us-ascii?Q?BScvDA4+V/zUDpmVOUrUgfKNji3WJITXTwhitQbddiOyVQpDpdDfRAFFBlmE?=
 =?us-ascii?Q?s6NHy+byuhYr42HkldFnhETdmtbbeoSdIG64yH4qotuMp+tI11+b+kVpvo20?=
 =?us-ascii?Q?2+GIkVyX5/7MN3UQr8RmaTi3IpkwWyxcm9JVcf5qkpuoxWaXseiOW9bwsZo/?=
 =?us-ascii?Q?Frr4XIVInBsVVbhcUGPUU9AS5q10SxWj43l4kUWuNY4YXNaJ30qMYWeh/h3P?=
 =?us-ascii?Q?RYFfb7sV0p+WesJ15+lzWCYMtB8QXAEcTAT2zW3p65zXs7LrCiFIyd6Xv0dA?=
 =?us-ascii?Q?3j0XsHbWVb6I9y6utUuSPpP6/qqA5CWQ4gQ9ZV1nheQhLdmqnabQhj+hZ+aB?=
 =?us-ascii?Q?jgWchCzdJFEEXeK9NyYBP8qpUnUEnpnqXJ0CXVJ2zOxZrbekXxDbkjw9YVVj?=
 =?us-ascii?Q?cbu+wwVpiKj/r4W2RSuJ?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 682cb4ae-3a05-41f3-c510-08dd3a1ce8d6
X-MS-Exchange-CrossTenant-AuthSource: AM6PR03MB5080.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2025 13:09:59.8880
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR03MB6407

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


