Return-Path: <linux-fsdevel+bounces-40181-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C3AFA201F2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Jan 2025 00:52:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D7B818862FC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Jan 2025 23:52:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38DE61E0DEA;
	Mon, 27 Jan 2025 23:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="W2ze9o4Q"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazolkn19012035.outbound.protection.outlook.com [52.103.32.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC7D41DF24B;
	Mon, 27 Jan 2025 23:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.32.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738021914; cv=fail; b=du22ZzgRtSXhynvVzZuqrXpYs/HWA9mAZEkjUnvNHczB0hyFJqnFXIS2I4U2u+XDbrfCLfuaTXDAEOC2zeLkOivgXQQuW6ifWkQShZzwbubNouPfL3zejXq6Qs0mF/FL6tPH7sLweR+S20f8OZ+pKWGAheNMpq40qHr/6NnwXKA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738021914; c=relaxed/simple;
	bh=wK3FzXuQpDXmaSzr0vURQaYKg0fxON8Sw/uCWWRLeiM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XNge6Z/hDbrpbMJ9mgX/uBHxTEqMio3M/VWD2XqvVPuYVpxI2jTJQy3bdju5Yvt/0mQTfx4pcfIJQYi4lW6QKCM5F8PLjR+F0Ikqz6NT8wHfAR7PFaLcmGn7aMzmGssRYbOx//9mrT8SXg4B0PrEX/LBUw+/On5/gAF+JOe69MU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=W2ze9o4Q; arc=fail smtp.client-ip=52.103.32.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CAG4wjy+EmPSfxngU5z0BX24G/smbRYyR2Y6sa33v18Sc7k+yJwe6PA5M2bC0iTXUMEqRQ1V0hP23JACI0h5EYhpqZUZQoHoj5scclSMorsBCqeAZz76VH4dW67UuAoY1RrniPTCOSreY+O2Qw+mBoWLQ3jZu8/Sm2QxOcIQRIlUaLl8tFMoTqBFLL/XQm/pUWPZp9Qnegaxo31H+SZD5nPYDYymTk20Ir/OTXSQF9W+gkJKwpdplXBOzWeW8Xg64uZ2KduAYHPAv+itELa6u/EnK1AkrzlYIQuGmtlb6xlOjW0BjPk+FuHjcJpuwbBILyRz9GB+VAJh821Nx2t/wQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yaoaGdtKnNqICPXFl5gVmGgFsml4c7tLCw2b/4JCy3k=;
 b=MH+eiAOMn2EQCA5x+wKXz4gTbEawxiL+mhChjAvYKn/6mBStQQUdvwqN3u5khPszk8OS2ysopCKjcBkOO+Eb7RW8EPCTAFErRtlirGC1QiMzdDS5Z0QvKhnElYIepJNrA8nZ+2ktM72dq/1iORRxo34/5AzxSd47XD0fVEbE2u+KFUcNuo8b/xFzWWI9A/wGkegO1VLXB64Mb2IkTQP4raD08IzTV3K+9FZe/J2xeji3gTqDy82J5d8c6hjpX/XSwfDDGQfydGVjUB9AVbyoKyQamTDtThnb3tfsl8wOrxEH0zjnose2Iaisp+j9eY7UtWV9EkPZGbgqALJT6Z8MbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yaoaGdtKnNqICPXFl5gVmGgFsml4c7tLCw2b/4JCy3k=;
 b=W2ze9o4QwplV0GU5++D8mLetwepcRN4OO0W4IILdi7IweLWPla5OQCmwC+w3oZr55wrIvXVEmH7ewwIJAhlEf4YMw7NSBPxY97zCaOIZbxYQiX+V5aE5PUplaiK+v/FQs7o8Om5L8o2Hhoy/cNLg9+DL6+ekez5ZQjZtCCdS95Idf21ipBpOUhTmu/dNOlShWPy1k5LTNOBcqJorfnv5OcaPaNDExKpy3Yk4rDGPLfZywygwTP66ojyw8KB/sS0CEvUMczp31bfrVOGJBbNC8CXPSC3gSphPuo632KdUffsf0/N8LRlYM0sSpYhu7byx7laRO++XEm0CNoqAKU/vGQ==
Received: from AM6PR03MB5080.eurprd03.prod.outlook.com (2603:10a6:20b:90::20)
 by AM0PR03MB6209.eurprd03.prod.outlook.com (2603:10a6:20b:156::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.22; Mon, 27 Jan
 2025 23:51:50 +0000
Received: from AM6PR03MB5080.eurprd03.prod.outlook.com
 ([fe80::a16:9eb8:6868:f6d8]) by AM6PR03MB5080.eurprd03.prod.outlook.com
 ([fe80::a16:9eb8:6868:f6d8%3]) with mapi id 15.20.8377.021; Mon, 27 Jan 2025
 23:51:50 +0000
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
Subject: [PATCH bpf-next v9 5/5] selftests/bpf: Add tests for bpf_fget_task() kfunc
Date: Mon, 27 Jan 2025 23:46:54 +0000
Message-ID:
 <AM6PR03MB5080F44F19C7184FCA074E7899EC2@AM6PR03MB5080.eurprd03.prod.outlook.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <AM6PR03MB50801990BD93BFA2297A123599EC2@AM6PR03MB5080.eurprd03.prod.outlook.com>
References: <AM6PR03MB50801990BD93BFA2297A123599EC2@AM6PR03MB5080.eurprd03.prod.outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO3P265CA0018.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:bb::23) To AM6PR03MB5080.eurprd03.prod.outlook.com
 (2603:10a6:20b:90::20)
X-Microsoft-Original-Message-ID:
 <20250127234654.89332-5-juntong.deng@outlook.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR03MB5080:EE_|AM0PR03MB6209:EE_
X-MS-Office365-Filtering-Correlation-Id: f75c0692-1945-4691-a9d4-08dd3f2d9139
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|8060799006|19110799003|5072599009|15080799006|461199028|440099028|3412199025|41001999003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?y0ChuLADc8ZDgHFrBdafyG4urdoOLt3vbOvoxsxYQkehzcSFETI2+7V+zorW?=
 =?us-ascii?Q?QXy/GUB/ZOmw8XAVWEUGx7KJNIARd+Cgon1eAiev6YpTIVUFoU4YgEt6/vxF?=
 =?us-ascii?Q?ew9pAEYhNZkqCRyirFU6SLTt/w0KNx//w8vsESehDkuCNpEJRqkHMcWjDieC?=
 =?us-ascii?Q?gYHnPTUc1BUwBqLDSIYIu+P7zWGtbHa6bNt6wK8zdXhEwYKkjGuEy2tAw2y3?=
 =?us-ascii?Q?Bwd2cDMlqrsDi+8AUr5wwY2oWsJDf91uCywlKGAaGL8CLuwB6KI3+kQIf9B/?=
 =?us-ascii?Q?5vpzuJpTR2iwIC0nx0bDJ8M/jrTyWKrZOnDKS459oTzo9pVhkJgJypZr80c9?=
 =?us-ascii?Q?8WfqBgECEvH9e6F801iv1qDV+pdVn6N1ZEE1xCkk/N8DNj31b3ySQ7QIvqRU?=
 =?us-ascii?Q?TFV/+aNZ8pzRZq9rDRePUPvhUAT2VyJAhv+epUT5w6ChyV8mfpJkBTaIFotS?=
 =?us-ascii?Q?Wv3ewIi5RkZV48CMcEn27Wf6RN0nGd8rHcCbMVfOUCcgaK8K2l/ylDNRg6SC?=
 =?us-ascii?Q?Unhql/uDaGd38jnB0qm7zVdh7N4Rex69oe9xTsl0gSSruVa5+ctaEnKhjs2v?=
 =?us-ascii?Q?fsuXE5QZGBuGLUNtd3nvw3IFEp/tGmyOCYUl2xXoqvm7w9eppXKLDxegxyoc?=
 =?us-ascii?Q?Z4Q3YgPA3QMOhgB8ygAC3SakfucbQnUoDag4Vt/KB6pRtp5mhI6Wn3V3RSJQ?=
 =?us-ascii?Q?ppzSisnfi5X361hcHE/61lZUF8ldPHmGAISrpWiSBWH1GOZszgNw49MuRup3?=
 =?us-ascii?Q?cSuJ098ImqMqcE3JK+6cWWPDWXfOam55OrptWpKAhq4yuVMmy/qxrFQSRQU5?=
 =?us-ascii?Q?umXcCxA8NSosRZauIGic/eKJPmDk/8EyfM6i/jLAztxGHxTwlvNLafckkLxc?=
 =?us-ascii?Q?F0Ix0Ku/Gc7O23R613Zos9/a18sd5iBG6rPg1icEMh/f/lWqsn56U1gZzFo9?=
 =?us-ascii?Q?2RFhxvcx7BJOQ6lJEcS5tO1i57iT9sLnWIIhKk+h5mIWEfT3p9UBLYeBSIU1?=
 =?us-ascii?Q?uipPWUXVU6L0YSuT8W1dvCHTjHups0EklJQ8QbpBToH8ZDFAjV0JHF6gz/ac?=
 =?us-ascii?Q?T7FrcoKbjNuB9EPNq1gPJU3mO1EnDg=3D=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?KGFzLt2RsHC5gdQTzcKlmqNEnhzDaJl7pcrJ766yhp19ql1sBMmuXtgGOyVI?=
 =?us-ascii?Q?DKCGtcud8kpC6y5zivsCFtRUhhYKr8qGGTRorWItQ8+hmi11s7kfSk3jDGK/?=
 =?us-ascii?Q?WQnlwVjqUUjwCh8vmOWaX3l4ZUCWmB44sVrWDBMOcuOic4kczh+1LepfCi78?=
 =?us-ascii?Q?VT13mcuE6zVd9CmJ6ZwjI5nr4XQB1zqMISAqNljUOOm8wBVSo+pcAl7rF1C5?=
 =?us-ascii?Q?4krfVb/57lclzMQZlVgYoF1KdCO8Iwjmj8jTExc6jvQUNcQnOd8k6ZMVf67y?=
 =?us-ascii?Q?c5Lupc2RaW5mT64xDai2CS9T+sfZpxvmeSgg6G9kUDfpP9zC3HhTNwUOrFFU?=
 =?us-ascii?Q?WEXg/Fou4XUYvxq5rGHFmCGhMlafjiWK20QQ6Mx9DK/JbURZ1kZnBYEMDryK?=
 =?us-ascii?Q?2YDW0OWS421T11QeFRR7GkHhFRROm4wiH2H3vRyJ/cfU1GoFYhDoTcz60qsZ?=
 =?us-ascii?Q?2VIY1q1dCs3zElQlSB7L2ixVQTpsFuqaoL++6ZX1z0e5ZLwIzNdroBTfUlH1?=
 =?us-ascii?Q?ZB6UB9ECpXRNPM0AsXT9nqKvRc3dOoN0EEqhepXoU8zow9ZlY0tRQCeR1LY8?=
 =?us-ascii?Q?F9XQBD4Yw9Zm1qazxqJzoAXuwmY0Ghut16U+BfMgpmsHZ+zkjNGZpgvT3XsM?=
 =?us-ascii?Q?bmGWF5o3zDT/TtndPAPQJB1W/S6mepL6Y7bBuSIuipZ1eACi9xC9rrDN7XS2?=
 =?us-ascii?Q?JtZp0ezTvBI0iIspLRG+Pi9z+3RW09b3qd2LoBBi+fHjVgbnRnyYjcUE59+C?=
 =?us-ascii?Q?K05yZt4TxSkXoMicXOb9ndbhWb0sO7E27oHweujQo8fxSRYIlNGgK3K4xuGc?=
 =?us-ascii?Q?roafVWE4iUl1VAhwp2vr9LIaVlO1s5OrTp40+dWZWXzofLbD2WExbsWgDWW8?=
 =?us-ascii?Q?w9+GGUIs8ds5zf+XBs6MT1xUXwBWbvDoGqeH6ASv8UV7NrbQnM9aqKPvJTW9?=
 =?us-ascii?Q?B/nWSFyoTnDjl3s409nKVQ7ughfKzzhaUoJ+nlCRnZAFmLRa7UxJqsPo/2mF?=
 =?us-ascii?Q?VO8Iyde6Ad1cXTs13Aa69Z4QrPN5nrsgCqlWvR/gaw4MqAECO/uDCIP4HPsF?=
 =?us-ascii?Q?fB39dA2LHb1CBPE2cMXBThAxTzbfHEhOVW17LCJbZ9kjPGpPzOCXvKCA5xwg?=
 =?us-ascii?Q?o/KARJfUFm1ieHYfeqHzd5aO4+mvjsCVNloP8mFx5I+K+Rk+bj1GsZgYgbMx?=
 =?us-ascii?Q?XYiG3YnnpQ5oldGwVt+uAVIIXbsYFuMfvgtoKNzLIFnTvLkVANMrj8pysiS4?=
 =?us-ascii?Q?XVM4QbWUXLFDho0gIG3I?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f75c0692-1945-4691-a9d4-08dd3f2d9139
X-MS-Exchange-CrossTenant-AuthSource: AM6PR03MB5080.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2025 23:51:50.1452
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR03MB6209

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


