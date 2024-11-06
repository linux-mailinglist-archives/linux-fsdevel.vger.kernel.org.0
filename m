Return-Path: <linux-fsdevel+bounces-33822-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2354F9BF77D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Nov 2024 20:49:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A651B1F22DCC
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Nov 2024 19:49:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F9292101B1;
	Wed,  6 Nov 2024 19:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="howoHFO0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05olkn2086.outbound.protection.outlook.com [40.92.89.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACB6220A5E0;
	Wed,  6 Nov 2024 19:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.89.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730922111; cv=fail; b=d/uH/fXikeg2vRXcmQg1A+OJxiTTDfa/J9LflfmIRMvNk+wvk7aBkDEd4s1FjxHrmV8IVHjTbaTsM+tcJBp7YFma1ZxjyxoAwlcoGg6perBQYVNIwHQfE3MNcDBV2yfgK4KfIE0XrLnb2FlzX6OoE9JnSyMH9vHmOsxiV6l6U7s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730922111; c=relaxed/simple;
	bh=KXnSoYq23pKPhySia7NA6P3OqJA/RlteqQmtQgIkxMo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fUUWWG69BnpJ0xwhyC5M9amrmPy63IFpJSf0KWu/djvvlNsGiLkJXMxJia+rK0GSLWZ5f8pgcNr/Fis0IbfJeEQwuIEU4FtBkY3sc+doWxXOZDaRhNJaFqE6S35bH24MD2ktP6qIWbm+cSArbQabHQAW89ZF97a+bSzyZ/8wixs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=howoHFO0; arc=fail smtp.client-ip=40.92.89.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B1Pp2mNKOEH6kjHTTEe5KacS9HaE39lYl74xZ63C2w9vnidyq6L73FRmrovfttgE7LcJv2/sWI8HHkhrx/ZN+pQzPrrpSDNLrl/NGOmpWBtwoe+bC9ynivXcKrQtN9el4lN8YlkP8ROOG0YX1n8Zfwv1LIPO8p5y7WgoUU2sIZPw5/6pEaurb7R7abEoCjsv/u8piZk4qtPNjhcva+HZ+0bbgmb2ouZlNJ/cSPHPoBTpJ3LhvxJlnf2L2BJASK56kiXr2g9Tn8tygHHZYR4sr89JUr8ZdBhP0YxDU+SOpUEDJOSpkRS8CGYNafW7vik7VNBuS3Q1hBRs08iSigtGuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jv1sJZwx9eKR8V9NrmGKUvTF3Jqh7OwSXf9NEFqVf5k=;
 b=ejhzey36M4tCTdJgZ7yybr5H9lFqLQuF4/i0X85aSRv7ZF9hnVDMpoZ2e5I+tWvmC4sEmJrld7Py/YW6fXbeii2UN3NvASVV3v7Wsw5kOum8sf9GC9IeSuhCmnTkie3xL02nj6CLgXY6x3+oAvyCzwzmTKtoPxTrTf67IKC/doR1P20daI1dQ4gfAgE2ZXXNuE7iP9zG8yMRO/zSvHcHyjxAnon2ci865nrt/v0pYe1mkkiP2JsW+95QfHg2XWeiUEvJ5Qry21jyjBOG9Zir110tPelO/+0Y4nrmrhy7rlWH0okNqL/CXWFCPVK8+aAZRn9KXgP59Yk6xGeDP5Q0DA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jv1sJZwx9eKR8V9NrmGKUvTF3Jqh7OwSXf9NEFqVf5k=;
 b=howoHFO0QeWQ7vFJ/diSapXIzjwwCyaDPfgmy/Pm7g1WM5L6bP6c7eIiR9rBgWIxRw+0QBd0+aKgGiYdkr1aAmTCvNzO0ugxDF4uAjqh4StcibZhGG5UjStcVXs3XpaKbTYaAH5Ks7IADParajdf9iRmixfyBMUMzZWk/EOlkTZAVNbh+wbh/8x1AXx+wMlbNy8AQ7HFxsuKNhZrX106QB1BE5cBRqEKRI9/qGuNm7ym/XV2ZZV9YGi+WlHx5uoihIUE1qcP3eyeidviqBup1s6uZo3BH5zdqquTkblK9MmKpm29BdqEOScXlbhFAVDatyYc9u52LCi+8vUV6k/N/Q==
Received: from AM6PR03MB5848.eurprd03.prod.outlook.com (2603:10a6:20b:e4::10)
 by AS2PR03MB9792.eurprd03.prod.outlook.com (2603:10a6:20b:608::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.18; Wed, 6 Nov
 2024 19:41:47 +0000
Received: from AM6PR03MB5848.eurprd03.prod.outlook.com
 ([fe80::4b97:bbdb:e0ac:6f7]) by AM6PR03MB5848.eurprd03.prod.outlook.com
 ([fe80::4b97:bbdb:e0ac:6f7%4]) with mapi id 15.20.8093.027; Wed, 6 Nov 2024
 19:41:47 +0000
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
Subject: [PATCH bpf-next v3 4/4] selftests/bpf: Add tests for struct file related CRIB kfuncs
Date: Wed,  6 Nov 2024 19:38:48 +0000
Message-ID:
 <AM6PR03MB5848464E27435C30A51C8DDF99532@AM6PR03MB5848.eurprd03.prod.outlook.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <AM6PR03MB58488FD29EB0D0B89D52AABB99532@AM6PR03MB5848.eurprd03.prod.outlook.com>
References: <AM6PR03MB58488FD29EB0D0B89D52AABB99532@AM6PR03MB5848.eurprd03.prod.outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P265CA0280.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:37a::17) To AM6PR03MB5848.eurprd03.prod.outlook.com
 (2603:10a6:20b:e4::10)
X-Microsoft-Original-Message-ID:
 <20241106193848.160447-4-juntong.deng@outlook.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR03MB5848:EE_|AS2PR03MB9792:EE_
X-MS-Office365-Filtering-Correlation-Id: 436bb76b-76aa-4469-6468-08dcfe9b0d05
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199028|15080799006|19110799003|5072599009|8060799006|3412199025|440099028;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?7KYmVp8YR3KN6qJnOmGZdSYoWW86NBvzaTR+n5sTB86mDjEfPhT8Y/RkOo8O?=
 =?us-ascii?Q?0v3ZJ4ryKrAUfNUbnIzIQXBIu4JXAZq5FOwqMm2YFwblFiFMG0t2S6gTkG8+?=
 =?us-ascii?Q?FJn/YGe1IdOgugr1Jwpx5YoIyMl00FUNL7D7YX4SLFE+gk9dBSvOKzPLdjBm?=
 =?us-ascii?Q?pgYBXvylRUnkZwdPTYdtfN6Bi2LTY1l7APa385Dx/UEEZvnseskMadsmCsBS?=
 =?us-ascii?Q?6aCMbhc4o6/z+sWFijGvKxyQSDY2KTmgHISSuZp31SQcLcvZTWW+FZufeGR0?=
 =?us-ascii?Q?xKKmZa8z/gE44T/DEkxJSP0egEAdgM/BGDHmEybMaWgOJ2K3X0eevxOD0CGH?=
 =?us-ascii?Q?AsnsY4arpF+lti92s/jy4C46c+KxeTLKwWSESLt5C7gdc+nMAB1j8iz9H+yA?=
 =?us-ascii?Q?s5TRT7U5wg7hYaf+Uqw0CB4e50JU37SWDfwCUHwryy3vRzEB3VPmKp9ioUDw?=
 =?us-ascii?Q?uCz89hmX0EQzsCcJhU21tmR9Q+a0nuGYGFnz1UFRaD1vGfQ3OzY0HHX0koFv?=
 =?us-ascii?Q?C4Bb5edF8UIqqG27zdzDFg8k2vxH5pRZ2K3NCQspFn7UVjwKwoyFT9t9d0hx?=
 =?us-ascii?Q?d9V1djKwa3uSOv6RKINSKhuNkT4YzMGkqeoi4isYLVqDT5xZ5bowhwYXLP33?=
 =?us-ascii?Q?KJgU+7h6qeSbiFq7MszAvlmpAjZm3y0U7HiwliSIcwiNZiSsjzPa+4dsD8xj?=
 =?us-ascii?Q?5lm+5OyKKarK1sZ/WV/6h4Lmheh0wl44zpTqiZqloXYTfuofkCRRMLBU9WCN?=
 =?us-ascii?Q?zq+Mzhhau5K3iTuJm/i6EI3PTicu50X8QPZfdJwKZAiMxcisaD/rmmXkfz7z?=
 =?us-ascii?Q?1CrwNeJYYvH2Z0lPGVUQ+385EYCR3HeeQKrC1/jK4rj9zMTYy+7zZ4DD85yQ?=
 =?us-ascii?Q?6ZVPy0DriziHhAGMeE0drR1iPPPcP48WwBWI5LrmU8VTBP1K6D0ib2jmJMdR?=
 =?us-ascii?Q?SS5GGWIJPkjDHR7VP63watQL3IsHYw4Rwp189+gnxZHpTe79f9mOYpDftcYT?=
 =?us-ascii?Q?yLLxDizTdHEJmU+PkPRr5roEVg=3D=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9kAlLZI9k6wLynyKFkqXw0evzIRWGkj3O7Px9qxKh6WCNC2lPeQBa4p4olfg?=
 =?us-ascii?Q?fTJAmzVeiJzWG1icIEP0vhUmZqdZkC2lgdVRUc9BMuWt5NH+goScSICcN5O4?=
 =?us-ascii?Q?sYCMeeU0RZp1nmp3OgUBvivTrmQzj9EslniG4yuCR+8E4ol/G1QjuuwAsr30?=
 =?us-ascii?Q?FG4g9rLgFOHrP6Pn1pWSLTfnY2Qt04bczM7GJawxvIMi0zUVvtcewLMiQIKp?=
 =?us-ascii?Q?xgQXp6IZaUzyuTRQCgIn3rrLEyZpDheCiEcJOHeNTIBvjwy+6tcZS2phJr5J?=
 =?us-ascii?Q?YJHd4sPVbR8lt4Z/W9AK/BpKKfYMrDElIqEHvw8DXdKN467nhpzybR/fbM/N?=
 =?us-ascii?Q?ew7EtFuW+MZntdqgC+q39/rbf2jRj4yt/1tkXWxM8RS+urJ7TAppGkKBAdia?=
 =?us-ascii?Q?truQ3F9+okyo15Cu1EM1lFknJNpX8anQ/zzDg44BAtQRdSrEca4QUnF9LwMZ?=
 =?us-ascii?Q?wjjUZa/gz+qnG+9/iPzrf1DbyzAcahcjqg5fVHQPsQGoEcjcuK0iFkeruufG?=
 =?us-ascii?Q?uj4etUMjXpvYQZ7CkYP6yNNdY6F9526A+3+CVqG6n+q5m/H6KBIFl+l7X51F?=
 =?us-ascii?Q?jq8gtSqTpTBV64PQliKAa0G+bUjhXR1feotjt2Wxv8KFqm+6W7syIzlGZVzc?=
 =?us-ascii?Q?Cb55TS325D7qlHgCUu823fL+f34q+acvupBUuQRUsK/MoZFrAB09vtOLpY0r?=
 =?us-ascii?Q?gVRRvTsqAGuRHNPvOgSn00ytUb6sY5uAhtUl8xMDuPYr37S+jEwIu8b2uYPm?=
 =?us-ascii?Q?k67Q7KgTEFhHomMbD//xVLq+cfvSrnaoQenNRiBiwbjNSW7As9DqP9hbFm1b?=
 =?us-ascii?Q?36VLKlg6VSgYJnfFSLCLis2ByZgonGzm5nPK5UGevtTT7uS5EYMHeKNbsM4N?=
 =?us-ascii?Q?07i7iI21bMoc57PHZXMvt+nd4SXJ1aO+yLN0ePV57aVUv5hIX/0nfGTdqUIp?=
 =?us-ascii?Q?rT/N61wXkzSNqzIJAqU0pDbadWsb5nirirVgtfuV27BGiL+xMyFIuKaPJo9m?=
 =?us-ascii?Q?quG4AndW4uZOiRes4PmQlFFpelNeWnBxVJaXz6lCLFHsPa8+hxBJv3ZUxQJP?=
 =?us-ascii?Q?6UPOIokkWMKgcTGF5/wUjWpQGqS62SLxoYYKYv2qOTCUS+9uaksbDxa13+9z?=
 =?us-ascii?Q?d/4gLFvv7Z1ymOj14zD8fAZJPE0UQXMM7XRtkVtmPnqj6xCHRiHZVQ6vQgEj?=
 =?us-ascii?Q?Ytff4INU46n1y2t+Ts6JU2YfF+wQzSJ1JmkfLgnryNOdTv+ItogXkqGBSzxA?=
 =?us-ascii?Q?mvQMZx3ITkLYt+3A7wn8?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 436bb76b-76aa-4469-6468-08dcfe9b0d05
X-MS-Exchange-CrossTenant-AuthSource: AM6PR03MB5848.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2024 19:41:47.4011
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR03MB9792

This patch adds test cases for struct file related CRIB kfuncs.

The test case for bpf_fget_task() is written based on
files_test_process(), so there should only be 3 opened files,
corresponding to file descriptors 0, 1, 2.

bpf_get_file_ops_type() currently only returns FILE_OPS_UNKNOWN,
so no test cases are needed for now.

In addition, this patch adds failure test cases where bpf programs
cannot pass the verifier due to untrusted pointer arguments.

Signed-off-by: Juntong Deng <juntong.deng@outlook.com>
---
 tools/testing/selftests/bpf/prog_tests/crib.c |  1 +
 .../testing/selftests/bpf/progs/crib_common.h |  4 ++
 .../selftests/bpf/progs/crib_files_failure.c  | 22 +++++++++
 .../selftests/bpf/progs/crib_files_success.c  | 46 +++++++++++++++++++
 4 files changed, 73 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/crib.c b/tools/testing/selftests/bpf/prog_tests/crib.c
index 48c5156504ad..5ef887e43170 100644
--- a/tools/testing/selftests/bpf/prog_tests/crib.c
+++ b/tools/testing/selftests/bpf/prog_tests/crib.c
@@ -108,6 +108,7 @@ static void run_files_success_test(const char *prog_name)
 
 static const char * const files_success_tests[] = {
 	"test_bpf_iter_task_file",
+	"test_bpf_fget_task",
 };
 
 void test_crib(void)
diff --git a/tools/testing/selftests/bpf/progs/crib_common.h b/tools/testing/selftests/bpf/progs/crib_common.h
index 93b8f9b1bdf8..0bc77d1b02b2 100644
--- a/tools/testing/selftests/bpf/progs/crib_common.h
+++ b/tools/testing/selftests/bpf/progs/crib_common.h
@@ -18,4 +18,8 @@ extern struct file *bpf_iter_task_file_next(struct bpf_iter_task_file *it) __ksy
 extern int bpf_iter_task_file_get_fd(struct bpf_iter_task_file *it__iter) __ksym;
 extern void bpf_iter_task_file_destroy(struct bpf_iter_task_file *it) __ksym;
 
+extern struct file *bpf_fget_task(struct task_struct *task, unsigned int fd) __ksym;
+extern unsigned int bpf_get_file_ops_type(struct file *file) __ksym;
+extern void bpf_put_file(struct file *file) __ksym;
+
 #endif /* __CRIB_COMMON_H */
diff --git a/tools/testing/selftests/bpf/progs/crib_files_failure.c b/tools/testing/selftests/bpf/progs/crib_files_failure.c
index ebae01d87ff9..9360aad50c15 100644
--- a/tools/testing/selftests/bpf/progs/crib_files_failure.c
+++ b/tools/testing/selftests/bpf/progs/crib_files_failure.c
@@ -84,3 +84,25 @@ int bpf_iter_task_file_destroy_uninit_iter(void *ctx)
 
 	return 0;
 }
+
+SEC("syscall")
+__failure __msg("Possibly NULL pointer passed to trusted arg0")
+int bpf_fget_task_untrusted_file(void *ctx)
+{
+	struct task_struct *task = NULL;
+
+	bpf_fget_task(task, 1);
+
+	return 0;
+}
+
+SEC("syscall")
+__failure __msg("Possibly NULL pointer passed to trusted arg0")
+int bpf_get_file_ops_type_untrusted_file(void *ctx)
+{
+	struct file *file = NULL;
+
+	bpf_get_file_ops_type(file);
+
+	return 0;
+}
diff --git a/tools/testing/selftests/bpf/progs/crib_files_success.c b/tools/testing/selftests/bpf/progs/crib_files_success.c
index 8de43dedbb02..f2e8becbfd04 100644
--- a/tools/testing/selftests/bpf/progs/crib_files_success.c
+++ b/tools/testing/selftests/bpf/progs/crib_files_success.c
@@ -71,3 +71,49 @@ int test_bpf_iter_task_file(void *ctx)
 	bpf_task_release(task);
 	return 0;
 }
+
+SEC("syscall")
+int test_bpf_fget_task(void *ctx)
+{
+	struct task_struct *task;
+	struct file *file;
+
+	task = bpf_task_from_vpid(pid);
+	if (task == NULL) {
+		err = 1;
+		return 0;
+	}
+
+	file = bpf_fget_task(task, 0);
+	if (file == NULL) {
+		err = 2;
+		goto cleanup;
+	}
+
+	bpf_put_file(file);
+
+	file = bpf_fget_task(task, 1);
+	if (file == NULL) {
+		err = 3;
+		goto cleanup;
+	}
+
+	bpf_put_file(file);
+
+	file = bpf_fget_task(task, 2);
+	if (file == NULL) {
+		err = 4;
+		goto cleanup;
+	}
+
+	bpf_put_file(file);
+
+	file = bpf_fget_task(task, 3);
+	if (file != NULL) {
+		err = 5;
+		bpf_put_file(file);
+	}
+cleanup:
+	bpf_task_release(task);
+	return 0;
+}
-- 
2.39.5


