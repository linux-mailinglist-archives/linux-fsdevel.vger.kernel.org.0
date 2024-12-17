Return-Path: <linux-fsdevel+bounces-37680-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3646F9F5A91
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Dec 2024 00:40:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 99A341886AC0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Dec 2024 23:40:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AB561FA831;
	Tue, 17 Dec 2024 23:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="YtoQyASp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05olkn2053.outbound.protection.outlook.com [40.92.91.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 234671E489;
	Tue, 17 Dec 2024 23:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.91.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734478795; cv=fail; b=UnUN0cYIVJKG68+sPwINuEzTbNKdKxCFb+Fxb0sROI4oce32poAxDsNvwDVWJgEAiAI5veB9sfT8GHHcuaCN/t7RilN8h0KjTrC/2OA8e9+Gkys/aHpv+2ylFJrsylfNdy8GKDMgjQv6Y9C3grBnMfuFW1gttQMeDaNCI7+52Zw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734478795; c=relaxed/simple;
	bh=kuBz/7vH7Rj2W0pBLgQzDhL5QWXpGKpmwS852TxxuzE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=k/t6658cXG0D7tjVcgcy9k7HVJRhbNzSDaWdTNBB/gQ2os153dSD/CQZjA34vGQ3EopGxmtYvdYz+P3+McfjqbdeyYNIpOy0Xk9QQkVOVWJ2vMoSedA+Ubny9e/WS/VqgFpI472CQm0070aZantXkdH3Jxja3MbUqdv4coHrWHw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=YtoQyASp; arc=fail smtp.client-ip=40.92.91.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KfQxtRan6eDI3UrJQonvxOuFwpkq0JwGAAaDx8on3Jje6wuRp2xQVoCi8fNKVnZOTbkLeC6xs3eLTmlMPrV4LGKtfn5odLTroZNE5YPrMOz/2hyaTLslZ2OFAfUTiDyHcaNWn2OBI7tcxGHrpmY3OhSKz/KQT46qljNRTYcipk69norkNdOX4fOjTpfUo6VDhV0VpZaSnXZoQJdljX5bxkzlt+go/R/9I2kHwqrIYXAsgsv2YSysWCPUNNCu0LSb3IEO4+uDgewi/QtP/81wPjuTWIgbmO1gS1ynTZDwfhIzp6L5DPo+NAspxEdC//J1vMcOVGpa4WwGTMEtot9tTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CncPRTiZu4tnS+BqX9DWEhZoGG4ps2jYS3F22V4SvIo=;
 b=Tb9b9NRoatsQwEjGAkllTOkwmWEGCDJPfFeqU9HPRUPbYRSHy++OVAPvaHadWrJThlZjgEdwklCihke/C9S4duw8s6w0K0DG4unEbBy9Se5tSzP2NnWYcae1TuBBXxNoZlzyU2IiiTSqU7FIyH+yrDJTItWdFCYS4njrMM/U8sLzudLVuMGpNSBBjR3sXiMdaYS7BgE9Kgg32zbTZKRyutRW7yBpEtgqekKwA9pj7a5qMYuJ5Ihi+2h7zIwi0CEpUOwyylc9ElpFH87+FPMorNf/uV5N1RQUK/RrcAWwoJvY72iTJozXXUt8vpn0NxP7y2/0BvCfTGSnlh7yy+mGJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CncPRTiZu4tnS+BqX9DWEhZoGG4ps2jYS3F22V4SvIo=;
 b=YtoQyASpccATrOC94x8SNMJnhYFBE7E2VLjXLLxGz6Yb8X2BpAz12UcfvB5cHIBZ2Znb8prRR8SUOpqR1E6EXWDYM9J6+flbC4t1EFVC+VjGr3g//nqHSBtyfCFdwgDBFcDf53zhhsujD9mOuiYAFoHGS5IIG7bHW+KMhMpgX2ixYRtIqStM0vpDg5PBvs0K2VUVWtZyrd5tUNhW41T2H5pu04Djb7SZwl3PmLFiVN6S+Y7lnACR82NgG7Jz4T3UsEIAZEeF20vtQBbzrbJcfDvpwoCFPaQZ+WhGg9V4eJ5PADvjTcTLZySgSpBUW0uSF4Bcj56DM8IZzZuUhcaVkA==
Received: from AM6PR03MB5080.eurprd03.prod.outlook.com (2603:10a6:20b:90::20)
 by VI0PR03MB10927.eurprd03.prod.outlook.com (2603:10a6:800:26b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.21; Tue, 17 Dec
 2024 23:39:50 +0000
Received: from AM6PR03MB5080.eurprd03.prod.outlook.com
 ([fe80::a16:9eb8:6868:f6d8]) by AM6PR03MB5080.eurprd03.prod.outlook.com
 ([fe80::a16:9eb8:6868:f6d8%5]) with mapi id 15.20.8272.005; Tue, 17 Dec 2024
 23:39:50 +0000
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
Subject: [PATCH bpf-next v6 2/5] selftests/bpf: Add tests for open-coded style process file iterator
Date: Tue, 17 Dec 2024 23:37:02 +0000
Message-ID:
 <AM6PR03MB508014EBAC89D14D0C3ADA6899042@AM6PR03MB5080.eurprd03.prod.outlook.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <AM6PR03MB5080DC63013560E26507079E99042@AM6PR03MB5080.eurprd03.prod.outlook.com>
References: <AM6PR03MB5080DC63013560E26507079E99042@AM6PR03MB5080.eurprd03.prod.outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0117.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:192::14) To AM6PR03MB5080.eurprd03.prod.outlook.com
 (2603:10a6:20b:90::20)
X-Microsoft-Original-Message-ID:
 <20241217233705.208089-2-juntong.deng@outlook.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR03MB5080:EE_|VI0PR03MB10927:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a51f5da-b4e3-4b40-1998-08dd1ef41921
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|19110799003|8060799006|5072599009|461199028|15080799006|440099028|3412199025;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6SmB6ZD1AaEkwcfbehQOILOYCJgWfbUvrZ6A7zBGZKmiOX5iD1W/Hh/5okVd?=
 =?us-ascii?Q?ibMePAIAl76zWfh+q9/3eWTPOPHhjyZl5HMFP/hcS6qNrCvQQZPF9sb6h2pu?=
 =?us-ascii?Q?VhvtQI89XqE2wmT1uq76+S4pIAP8xcbifmZKsy1UPKyCPfeCO+fcx/PKgzpC?=
 =?us-ascii?Q?/GhOXDLbofpmoX7WdUYgzdWjD9Dtpum6ly6YtxpzB6pzJuCDbtSfeE9tUZhC?=
 =?us-ascii?Q?hdqZ7ddEJievop4j/vGQlq4D2YucIyjKKHgJ5jcEAWv0VIwZ+qPVcPxHBrKu?=
 =?us-ascii?Q?XWkENHqSfpLMXlvYvmkRnd9cv792CGggFyAZA7BmCKC2qIyk3I2jsRzKA+7z?=
 =?us-ascii?Q?n+dLQKpIPVFGrzcxotb3MbUz6MEXATRt9OQSSHn2u1twNO0uqHnY4OtkMxOl?=
 =?us-ascii?Q?B1APsZOh6Zfyu1CrQ/VGlltmzSdUfn3kD3wVoN6aaLyH4WpdNC27T5Y7jzcs?=
 =?us-ascii?Q?kGaWlbT0BiB+nxhoU1YyExm7ucS2Y6nqAvHQ2poxHQAwzd1g3BmrKSfKsUyY?=
 =?us-ascii?Q?csT8SMypv+0cJorzIXplprOr2QrX8NJjlXN8SBvBe7Ej9hAazJNPo6gUBsZ3?=
 =?us-ascii?Q?d6spObhy9gRZq1hD1ALrW6o/OX1LiXk0Rk5RvBoXUwEH2YA+vaTuFEyRZZYg?=
 =?us-ascii?Q?U8EAOASfmTqXwv9myvzmOlmLLACYPTWUnX4lnqtnJiC2guC8ym+/VECKSC/s?=
 =?us-ascii?Q?t3abXY7FLJYKzeLyD9ngOjmt73Nq7NExein8lDbg+3twTczhPTf3RSRgkMxp?=
 =?us-ascii?Q?CDzOpJPGkNgXep9ZBubUWcZp/g9clZiIktUHmLhjH6h907+za4EtpKfMt/Qy?=
 =?us-ascii?Q?wwdNubefCnGIVEJdoxwaqOFvbg6TvM5thKF8IuN8T4KfVXx9F4M9pAM/KmY/?=
 =?us-ascii?Q?dpZ1lqlWJEfDk11Ca7bPczzjG3Nw9mxcHH7jERDB0oW9bHrYQa+XFwImidEK?=
 =?us-ascii?Q?sRfUifChp+RJxQZuRVKviFA+wm8w3QvzWu8XfTmdTEqB8JQIZHvfAOAlT/TD?=
 =?us-ascii?Q?eltsNZnxYXVzVshI316sWOSbeA=3D=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?oz8+DscNObKr4QUepya+Je00ceJle4ORZtltXUlI/v0/hhjhPkmubyyLUji/?=
 =?us-ascii?Q?neCwB/4yjq66pB9aib2Mf3oDcsg5I4hnL5a+nAulGL2Pe+xI8GSNjGFR5yFq?=
 =?us-ascii?Q?O+ranboRCUUp+nBynFua3y9/QiW2hLIxAmwtHjZ7ueWdR+a8zf/Urn82JLEx?=
 =?us-ascii?Q?e0sY1jiIbJPps0d+bkqGihMgQYVK0P/4fRPAHxMYoAD7bZ4CgOoJGs9WuI78?=
 =?us-ascii?Q?/7u/WYVv1flzUQbe5BeNX531GwTk2P18ETPJtyYMHz3p5gIJo03d82M5rDs6?=
 =?us-ascii?Q?cNDU+JhhQaiOLNSWkpjoX3/MlRcTH+rdK8W7m5DzUE8oP37f9kz1MOMYx49/?=
 =?us-ascii?Q?APWoid+IVYUCnUxtLt+puZ/CQDdOQUZ0tO3F98DKFjRHGf8ykpmW11ag7kRv?=
 =?us-ascii?Q?pW2DhioHzTqw78crrkjSjEqzfqdfr+NBNA0liLu6Q6Fe2mfekly03mJe/979?=
 =?us-ascii?Q?hyhYDJlMj5wHwqma0j5rmM61iUAEewHsi8EMwjIx50BKY8fynmBV0mbpBc6M?=
 =?us-ascii?Q?R7XVSzfinu4s7o5iLsOTrpqPujKpPZZMgCmgG3ODWCTXPsd+0DHZtq7XAgzd?=
 =?us-ascii?Q?0+gE37dq6F86/a8lMGvJEErLpZekrdQpQKY1G4yVhIOuixPygQ7w7dbBG3bU?=
 =?us-ascii?Q?m3Q4tXOn5D4LeW1CdrBpK+3sVAGez9xKtVYuzPhgQrirziZ6ftj7G1C8MmaA?=
 =?us-ascii?Q?AH3fvWGi7pw0+0mn2iB5QuMq38Bkdyu0Ekc0vLLasBUPVXPKubLn4I/vgBRQ?=
 =?us-ascii?Q?gZskyDuBNEVRY7slv7T5i65tIrnZL4ZTnEi3vOuygWRlnSFpILXkWdx7fnxV?=
 =?us-ascii?Q?d7efdBI6MXETBFEs8mP1zT+4tI+fdWiCIZUl0zKeLcCSnE3CcjkWY8DEhQgx?=
 =?us-ascii?Q?M/HAfoUf0a/LcXWwnpetXsGzGvs+AYAiXXMDH/NkoYeuKXdRK6klQDSbO/6G?=
 =?us-ascii?Q?vnaLHDV2X4H8Jje9FlK0LeQDpqMVDKycTi0kQJLmUdKhn6pwdhw6WF5DW2Jz?=
 =?us-ascii?Q?TRMns+27xnlzE3Qn0VYiiRAdkMvCZkF9VF+dWwX+yVUDa0TwPPCyRshmCwbr?=
 =?us-ascii?Q?gQofXP2wOwWa2z1A1WfIcIgh1jXrftuoMLxkqVId7+ugh+L2SJFfBRFF7Aid?=
 =?us-ascii?Q?dgRGCVd7LP79tVYmEyOqQWYA3HMBgpwHWpgMSR/hYGy8kuA5KKhXT1cmuhcf?=
 =?us-ascii?Q?k/FLKkl6Pnv3bqoww8cr7L+d7QQ1Sk8M88a96fG+gxWuSIhd612RkxD2XhXD?=
 =?us-ascii?Q?IW7OgovxurapQYbT33rA?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a51f5da-b4e3-4b40-1998-08dd1ef41921
X-MS-Exchange-CrossTenant-AuthSource: AM6PR03MB5080.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2024 23:39:50.1246
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR03MB10927

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
 .../testing/selftests/bpf/prog_tests/iters.c  | 79 ++++++++++++++++
 .../selftests/bpf/progs/iters_task_file.c     | 86 ++++++++++++++++++
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
index 3cea71f9c500..cfe5b56cc027 100644
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
@@ -291,6 +295,78 @@ static void subtest_css_iters(void)
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
+
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
@@ -315,5 +391,8 @@ void test_iters(void)
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
index 000000000000..47941530e51b
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
index 000000000000..66e522583850
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


