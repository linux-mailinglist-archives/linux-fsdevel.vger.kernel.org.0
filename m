Return-Path: <linux-fsdevel+bounces-39878-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D41D3A19B54
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Jan 2025 00:07:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7687D188DD62
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Jan 2025 23:07:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9EB41CB51B;
	Wed, 22 Jan 2025 23:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="klW7vwQO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05olkn2094.outbound.protection.outlook.com [40.92.90.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9A2A1AF4EA;
	Wed, 22 Jan 2025 23:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.90.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737587246; cv=fail; b=ZWuhgB0y2XrWoD9WfSvcqQMUdXOervqyzjThz377ohA8wnqiFB9wi00EaZdxEU6/v7IbJM8kfec3urgm68Ie0fGhqZ3YDEoPPUvoaY24uEeyRJURK3wS7ShbE1VnWZlFFf6363IgaTSOKxA3aDbS+7yTxVsMmD8gBKJ2799rL88=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737587246; c=relaxed/simple;
	bh=BYSocogKlFAPra9Y5/Yj6+kyGm4RvEp6FzTLA+b7F1I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XAfNDUexzCtk3y9IP4ciR760VR6Fac82q13RBT3MVmvpFMDBSeZDkp+d+7cA+6IyuCs/MupKAhuZReqz4aGlYVBHpu+EXklfwXjn55tQJOI/0IfG2Y3r0WUR2MBlZy7lasw16TXlnGH6JqysKLbbu6J9K71ErbVurHZhTFB4b9A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=klW7vwQO; arc=fail smtp.client-ip=40.92.90.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hKzkBqREW9hbK6Hu9s4u9+ltExgyYfQGp6reFWdh42J5qu0dOmbz2Gi/F1tO9Rn3p7HqBXOaXctEhtk1KhNBfgNrLqWmS51nfy5zL+UTfCXrVukqF2S2M4YF6OABfVRmQ/uhJllrljPpwTAptiOil0uw6eqUk2v28blYpUdytdu80rAFsDh7YG2KoTq0Gnn/2d0Igz62zixKsCvVd3JxkBJ1XWng0xSv3k/Lj4Khlx5RtVtyaHUirfVJo2va/oXR4EvYgxU4fRMu31R04F6GD5hVfnKwp8NBA7M0vI3RIxK8+otRvghWs1ybMTVYPRu+21mi6LwrfCBC0RIsw6XIUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ndNFiBWUvosO55p2mAYmKSYuPkupTbj5tPcOz5iTqbM=;
 b=pbG9CgY7WSAVmC+2WpUtbzKBXFZ/MVFX2nN6Rsf7b4gHY2rx88eX4ogDFO1qHshXjWAf4Av8Pe84QHRQ3VHxSOqcPVmhtpY+LIuGpnp/yLvm+Xc9DARVPuYRr1EqbujSw4B2s7uiQdB3ZQgUbux+g8B7EHpbStiHw0ykd8yTAHoSsdfWYVYW78RKKL2OQiJZ4reSpjztmSxtLmn50IOKBxfe9NYoMl+TCHqSMRVG2bqWJFwC2pbrgTvPyy+rjrXA4im9EzX6VLkOvqNtPd7+3FZNDB4NFaI5fiKLw1xhmOv1dRNRyhSaMCMzK8IJr3jb43fQHdVTN4KH7cyyyBCQ4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ndNFiBWUvosO55p2mAYmKSYuPkupTbj5tPcOz5iTqbM=;
 b=klW7vwQO/x1kT20zgkrhcMUMp/vBV+CCxENubRE9l/Tvn02weapluPeQ9/saOUNR0ibj4h3W5c3w6vPpMPknRXMGrZzrKvcGibn8+fATvmmLtknPgiQX614VJPWfEV/tlpAV/CsQpSy0cKDFV9X61lLk/JPwMG3szQobWwp90zop28m/TuGZy5rZEMeFrEJ3eSvGWql7QMzs3qA9Ncx1O4pvQsaJpLvh59/I7wdnshXYsykS/rlqhOf3eLKZVjjSauANnolS9g+8rx2GTZZk0cSds+svuzeYdUeTm5FdxL2L6o1yLuu5Iiv4U3YU8IEnSBMtqEDl1mIGGfuMQvmrfA==
Received: from AM6PR03MB5080.eurprd03.prod.outlook.com (2603:10a6:20b:90::20)
 by VI2PR03MB10907.eurprd03.prod.outlook.com (2603:10a6:800:270::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.20; Wed, 22 Jan
 2025 23:07:20 +0000
Received: from AM6PR03MB5080.eurprd03.prod.outlook.com
 ([fe80::a16:9eb8:6868:f6d8]) by AM6PR03MB5080.eurprd03.prod.outlook.com
 ([fe80::a16:9eb8:6868:f6d8%3]) with mapi id 15.20.8356.020; Wed, 22 Jan 2025
 23:07:20 +0000
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
Subject: [PATCH bpf-next v8 2/5] selftests/bpf: Add tests for open-coded style process file iterator
Date: Wed, 22 Jan 2025 23:04:48 +0000
Message-ID:
 <AM6PR03MB50808C48B7DC158EF4BD327C99E12@AM6PR03MB5080.eurprd03.prod.outlook.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <AM6PR03MB50806D2E13B3C81B0ECDB5B299E12@AM6PR03MB5080.eurprd03.prod.outlook.com>
References: <AM6PR03MB50806D2E13B3C81B0ECDB5B299E12@AM6PR03MB5080.eurprd03.prod.outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P123CA0049.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1::13) To AM6PR03MB5080.eurprd03.prod.outlook.com
 (2603:10a6:20b:90::20)
X-Microsoft-Original-Message-ID:
 <20250122230451.35719-2-juntong.deng@outlook.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR03MB5080:EE_|VI2PR03MB10907:EE_
X-MS-Office365-Filtering-Correlation-Id: 8fa60037-fa3e-4762-476f-08dd3b39860f
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|19110799003|15080799006|5072599009|8060799006|461199028|440099028|41001999003|12091999003|3412199025;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/eCZq4P9xkQyZH4YKUKYbZgZZ/xhaclXW/s6cHCaAfdnb3lnMM5MQxS4E+f6?=
 =?us-ascii?Q?xi2aueD7RhmFbPrfWRGcVvtpUGVwB36sH5ztJdJnsbzkBLj9K5SX+rSO+9gh?=
 =?us-ascii?Q?LR/83O3KncVh3P2CEVcpQgB7IkvidJeVdZtwXgb3aimltbg7Ls1xvDWMEYAu?=
 =?us-ascii?Q?VQ4sh5epMBrAGkGAi0cx/UGN9rK0Jh4s88WnLJMuxT1kMUpEcylzGiuwtPqH?=
 =?us-ascii?Q?uisECE71KMdnqiyZgu7d81YG6tduIpxv+ItD06g4GLxpZc5DvtwbC9IhK6ta?=
 =?us-ascii?Q?GeYjWBFGTc+w0su3sGYkLL0Eup/1hNSCR98hCU3TIhlC1ygW9qPfOWEVZp+X?=
 =?us-ascii?Q?l/1JEsWcdeUrGaovEm/ojvq2Qp2PnJFq/kId3hrfi+CIB4WYdLPSaGAifQM5?=
 =?us-ascii?Q?OVoI71bda3kmyOor4XuBa3gCAprGEdqowo/IRaa/0qYXMVEooiHuUYQY0x3V?=
 =?us-ascii?Q?xCoW6fHfJh3DPVZQxBbRjQQWjjqX74OznN7jHeepO0U3YWRx3UEpaSDdWSKq?=
 =?us-ascii?Q?Km+0gykTfBpTW6uagLTTdJAEnrUDKdwZTsnITuc/h4lRmq78cbs67V3s4JfQ?=
 =?us-ascii?Q?vQX2totG9yFEphJTZO/ougJ9/RwUeVnRYmyx3IIAMx0WdNmC0Vi3e/CWg+nu?=
 =?us-ascii?Q?rQUPIFBK7d3THkZREZktJSvcnCD+7rLiJ9w4soAZIcBtLFv5/KMWEHGUHgjA?=
 =?us-ascii?Q?RyTbkTsLAhkBVZ3P+b/gYGyPcpz+wv6GrWtbMmWBAy44gGYTEHrrQH0GuaQE?=
 =?us-ascii?Q?NA2IG8ZWVX+oxen7B7Ll+pAK53noe3XPC6gFC81NcYOXbR4jyVd7sFM84fC2?=
 =?us-ascii?Q?l7ZhnCkiaQL2oPmlxueF/y45e7h3gUBr/bx8f5oHd0bbg7GYX91/hmqF5Egd?=
 =?us-ascii?Q?3i4JWNE3fGbvKGxvH5KbcIrSp94haPsqMiANxbNtuycX/2bQIYbltCZcNEMH?=
 =?us-ascii?Q?vSUY5y5UYuFqQrRW829KCrue0dDWfmavj6T7XeC9u/JR634v3eQKiXcSQdv+?=
 =?us-ascii?Q?L+Fg2kCyEp62hrFtGnaXHa9reSLUvBBxTe0RCxXTzLh5Nc/Wexi9lAVMTWGC?=
 =?us-ascii?Q?pqb9BaO2Q5RgqUOnvsp4AxoJ3gfF1jYD7sL789F1JM16H5n4WYM=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?LEZv5VE5Kf812yaE4ou0sOAxeSVaiCUfNlNYcEXIF8ujS4RLuHBFgZTuIoFq?=
 =?us-ascii?Q?iRcKm7OysEEH6+2YTbbWgg4AAiy30UQP2GXWWIvH4+RI8K2MzMBE2F2QYigQ?=
 =?us-ascii?Q?0yAGwvRttlPmoJy2sCuNvDdqlONGjAXosp98VPkCx7JsbN2x6MtQQSHaytM1?=
 =?us-ascii?Q?0rIUSM6AG5xQ2ogOaiY4JM9touDeYICSTLMdOxcO1aXMLeA385wFPcTAuDcr?=
 =?us-ascii?Q?6As0ksGmiG5jBtPoMtCOrNjYYFALmNDIVICs3wGjo/U+s+N2Kg+vO4U6vN/M?=
 =?us-ascii?Q?PLaEdBuUsto35EkFLBNnJp7IZd8WCV+DFZnz+Ani5x2zxfaD+ZNwSS2QtM/r?=
 =?us-ascii?Q?NGiNtMsNk2xGR0Kg88uR5+caZ3aTa0VL1tGdBDh0iGHROKNw5A5dQTItq0j+?=
 =?us-ascii?Q?EyGPqw3+sjZzZIhB711TUIWil6rLEkMA0wMbAY5x1wSVBomeEN3k9+OJvGsG?=
 =?us-ascii?Q?i5BQzopWWeiUoOFRtj1BOBuPWIDdTG1YrW1GMNJalOc8ysAT2iujVx+HVeNp?=
 =?us-ascii?Q?a3vJMc/NhKQ719rJf7EOt+QEAypHh4hdPh7AnqSA8EtBQ0KP04eLLCRDc58w?=
 =?us-ascii?Q?ad1RYn8qdRxdBl0326u4+YT9m+GqyvO5BczdQONEP3XHtvBndVaoOZDMk8/H?=
 =?us-ascii?Q?ZRedqm5Nh3KReKMYMmXJqX18fvFpYOvmezHcyUA5V+OHfxM4iPqv+ACM8VJC?=
 =?us-ascii?Q?i4G9WkXyJAJy4+hihUQgHSD3kxDrVJv177gZku+59e6BUXJR90Nht6ewB9RJ?=
 =?us-ascii?Q?B2LPwjmpUeoSSVZd0XRHTirjI51G4uX1pKcjrKYRH21FMmNmlICT0/B418JZ?=
 =?us-ascii?Q?etB5ZKs+MWHJmsLpFBPvt9zUyCtwgF2w7Q3HeCedAKfi9bPvTh3UNoiU/CyZ?=
 =?us-ascii?Q?PmWGuZhXob5etQ52Bhg366FUFNDVwQACKgTAVGSW5yMQom5fQJfs2zoHDBRJ?=
 =?us-ascii?Q?hByFr2ulL5ucDAXFSgl3Tynb9iehi+7hOBv3ig3ZPtetxciHz4rCLOok9QkM?=
 =?us-ascii?Q?zZj4kgjTgfoq6x4TiCAxcXQH0HXfynpuMeAruW9jcibCWnk8RDjC/ozt+AwI?=
 =?us-ascii?Q?bdRXGxam490McZ/gqWOIxq8gp65VZgpLzHaOUtqeRjEN6BBbdK2aMomW/epF?=
 =?us-ascii?Q?sY7klUUkta+9YZ5YXWzTvwSBsbfRYsS4Z3rXpWVUvs2cX/5rk/+mGBlak/BG?=
 =?us-ascii?Q?pD93q6V6SRVonppVEfc+dwjGHpxbLRf+r4lv93RA16o1zXqJTg75zHMMHxnd?=
 =?us-ascii?Q?WJoBBhc9jTg7wAPuW3ty?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fa60037-fa3e-4762-476f-08dd3b39860f
X-MS-Exchange-CrossTenant-AuthSource: AM6PR03MB5080.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2025 23:07:20.7699
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR03MB10907

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
index 000000000000..62f1dd6280ca
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


