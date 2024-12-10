Return-Path: <linux-fsdevel+bounces-36942-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DDC29EB2C1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Dec 2024 15:10:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3CC4D28625D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Dec 2024 14:10:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50C191AAA3B;
	Tue, 10 Dec 2024 14:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="BzcC49Gr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05olkn2027.outbound.protection.outlook.com [40.92.89.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D7561A7253;
	Tue, 10 Dec 2024 14:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.89.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733839800; cv=fail; b=LgSHVToXy5dXzaUaZtDYhH74cRFU8PAL+vswLJ5SalO2wGHI6zLI18yTbmc5ABGxEve7yF7kgUiEGhPNbDPDDMzXf0iuJ5uB0SGuTCRzO6UHtkzMzr02bTwK7yspgnGpHbVJj368cCA5OQPjPKxlEidWaT+CAPGlJhI53ERab5Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733839800; c=relaxed/simple;
	bh=yWiZsKMONhwdBwJE8lBkbb3su9Fs4JjeYHg26BAsWbc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=l0OAKbnolLuZXScZE7IwmxZsy7346wsailB36lq/GhwayLBfd7XGXxgtc4aaruOuAGgKGyTE1kTnbYn9WJedKYzF2mhPzskgNZiOBQoggAlho1J/cPku6WpuOuj0WNvfDowl1ZWubYD03Sr//BnWuFr7lkQw/czvcv3j4dcWSG0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=BzcC49Gr; arc=fail smtp.client-ip=40.92.89.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IB2In/KSfyRb591NNuCaZoJGJvYGD1bC4wrT454PDhOANf15hCTSGcC/0w3qIsgl+dXxwNeHrBDPwWXCdHTRJ6lDOw/Rsup2sHSonzm54dSffcdZXrWBc5D2irvfAf75N6nesyIe3YuZVabClKZLAwAMUjE9eDdNyyHlJyFgdLe0s837uPBe8roM5BL9DcVmSknepOz7ymOMNUGaNBE6VagwW60DkFfxsaYBKtV4JqJN2NuiJV8EgKcbYfONWqDVInwxbaIykFb2rvmmDN26OiOn8s2nhjNWNdV5gBoemwbhRB8qf5ZKhJfqCanntN+QjyywUW6doOHzPebkgCSY0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MxEfFHWq6mWVOCCWJzOoK3xDtWzGNst23SaI/LMXvXE=;
 b=JyuJO0z6CR6LGH/uk1yn9AXSqRgy/UXRAfF7Iv/ZgbPNaOx125Q79FBrbBdzNAgJAsX3oRuj16HaIQXBs06qMlvnD/35zOodZ5WJFJhAN14AYfqArB0VN7R4O95qr2O/3Y+slvAKTZLGCvgIfMmJtMd54JfIZHKRFOMo3xZ/1ryY6TJp4lbH+p3VpWH141xdyPluZpLaP+DHvnwOR0T6cURnJX29X77WEc/qxQnFZnsuXjJEkLAUsrA6i4D0gFfCuOTd+lqaifemrd1yD0cCfznomQZ3Bluk0Z6BoJjIm7D55QAZYmwLcE/4E6ZB0wY+/p6mekv0ic135TJP+XJwmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MxEfFHWq6mWVOCCWJzOoK3xDtWzGNst23SaI/LMXvXE=;
 b=BzcC49GrXhybXlQe+SN2YETLkvP1+gjE2Y1WjATFwaGXl3WK+TjdH8QcvDC7bEdjVZTDm6FmRvfUY1y3GnDXP8QulYJRcppsyD7sTi0FOIFZ38DMgyiFvugwyxUDd8l+5WK+hH+A6JeLjLuEj2hRZ5hZTpNF/rCOFLN36mEzKEgYxWbohCCVBK+mqfH7M1jCY9zWUU4/GTpLpSvCXo9GSA1g5w4+MOnK4otPPgUcYEnn3P/N/Xt+wwe2JGSIgslh4ztWW8s1EasHlnvBWr937PxXs+aUbkiwXlY5e6t/M/JaP/V7P/G88XTAMg86LyyspH9S6d7MvatIP+kaUqX6zA==
Received: from AM6PR03MB5080.eurprd03.prod.outlook.com (2603:10a6:20b:90::20)
 by DB3PR0302MB9037.eurprd03.prod.outlook.com (2603:10a6:10:439::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.18; Tue, 10 Dec
 2024 14:09:52 +0000
Received: from AM6PR03MB5080.eurprd03.prod.outlook.com
 ([fe80::a16:9eb8:6868:f6d8]) by AM6PR03MB5080.eurprd03.prod.outlook.com
 ([fe80::a16:9eb8:6868:f6d8%5]) with mapi id 15.20.8230.016; Tue, 10 Dec 2024
 14:09:52 +0000
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
Subject: [PATCH bpf-next v5 4/5] bpf: Make fs kfuncs available for SYSCALL and TRACING program types
Date: Tue, 10 Dec 2024 14:03:53 +0000
Message-ID:
 <AM6PR03MB50804FA149F08D34A095BA28993D2@AM6PR03MB5080.eurprd03.prod.outlook.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <AM6PR03MB508010982C37DF735B1EAA0E993D2@AM6PR03MB5080.eurprd03.prod.outlook.com>
References: <AM6PR03MB508010982C37DF735B1EAA0E993D2@AM6PR03MB5080.eurprd03.prod.outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO6P265CA0010.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:339::7) To AM6PR03MB5080.eurprd03.prod.outlook.com
 (2603:10a6:20b:90::20)
X-Microsoft-Original-Message-ID:
 <20241210140354.25560-4-juntong.deng@outlook.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR03MB5080:EE_|DB3PR0302MB9037:EE_
X-MS-Office365-Filtering-Correlation-Id: f14032d7-f8dc-4aa8-85e2-08dd192450f8
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|19110799003|461199028|5072599009|15080799006|8060799006|440099028|3412199025;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?2ug1JTsjGf/5NWl1Jzvsls4r+gNMbOZdtlOqarxUcLgMOCjzspe4oGh/UO+p?=
 =?us-ascii?Q?DhqBspdE3so7xD1jzV6Li9DYFxoQPNwC7PORbsunC7TK3c3PNEHors05Ln9U?=
 =?us-ascii?Q?6Mf/LEWC37PNm0D+dJ3IdowLQnv16MEDea5U2/l6JlcuLqRX6n4WELBcJSpn?=
 =?us-ascii?Q?KFW1sDClWB4PgYA1JPoNEqlR7lIRYVWnS3yoD7gDEVoQO8+HMt8VVZrUfU4K?=
 =?us-ascii?Q?RYpozXcESGNVCq8Bl5cMTLl0murUacc6vRggmeYoAonWi2/lI9zdHU6j5Q40?=
 =?us-ascii?Q?6C44aWd5L9SwnUaVsH4eNUz9tSU/6XYJPBEoaaMQGAhYVYTQ1kEXQ9I7d+BG?=
 =?us-ascii?Q?F/IYKbMpmRjIBqDzAAhhiWg01VbvwFsdUErczuqCybpXP0OyBEC1ypMYeZPs?=
 =?us-ascii?Q?CYj7nYVWf5fUhAF5rJZLngu2NQ6KN0TWuvnEELpfsG0QTT0DgRyLw/uBC1Za?=
 =?us-ascii?Q?1aZ1rO/4YOJ9GQ3kez8ROO5FHImFK3TyN/DaiabKWOD32K+yxA+WVnRLSAUs?=
 =?us-ascii?Q?PQDq23GpBrenwn5iCZ6FjV1vM2gccS56L4up6MIs5uH3moivkxqvNoC0x6D6?=
 =?us-ascii?Q?e2obWG7sIE7hiwSF+kxR1lPLr7QDk8Yc87eL7UhdsLF6E6d/VOxe49KB9gOX?=
 =?us-ascii?Q?v7uSPo/DeqJyo2VyGjWGZJm5SaIWVNFhuIAepFI1+e9QMS1HtEU9oNLLNe33?=
 =?us-ascii?Q?X6Fz9Ch0rOn6axMYUMYgdao2YFWrdj6tfUAr822ushCBr3OzoisvN8ZXWQDt?=
 =?us-ascii?Q?2D8vE3A8u0O64CypIrefsa+UkTSTDGf/tfgEeTXcbQ5T2rvlGe6fL2ICk8F/?=
 =?us-ascii?Q?JDIsjU8lgnR4zZRmR2S0Bi95wb74/dmiRecPVeqdywP05/yrxfmJLR67GSWC?=
 =?us-ascii?Q?+f3EkASs75mTWGun6mCL2ZKyML3+EK+UQoKnU70NmlYumNhpcpAHrzKXaGPu?=
 =?us-ascii?Q?rHP6lfHLAt3J0dV1BDbdrBxkLIu/wO7ubAZf61gsS1s5cN3XJkB7i9pOZQkV?=
 =?us-ascii?Q?UJ6BcGR5iRl+/7H8K9iqxJcyow=3D=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?CoA0GM9/zMrfx4PV+W1FYlm0ldkQXN8/iurB3SZV70Gdi1lLQ27S/0kMIleO?=
 =?us-ascii?Q?5rInC7Wq4IeO1EAYXu/YwIAWDIon8tCdLjLaoUWOitIb8pyNdhyxs0dfm+R3?=
 =?us-ascii?Q?PlfOqfQqVed4zgAcN9QKiBhU5WkNMpX9NF84RzE1CyLRoUKXae4YO5Zw2d8e?=
 =?us-ascii?Q?inc1ptZhmCgrLjJMPm9Gsj1Y271Y9EEAw+bJ6aWoUek8xXnsMy3YgFjiD2Xb?=
 =?us-ascii?Q?KfKDQBDcNSyMQNPOLHem7nrzia25AnW54Js/I/CtE85tOvhk4DZ+T6/ZSUNc?=
 =?us-ascii?Q?ouxUnv1JBapu43WrkXN1XRPhQIEIoz2b5g/klumTKz6NlcJWOQXYoByduzZE?=
 =?us-ascii?Q?2i1k6VSVX+wEissdjiHUuUbOeJbMpE/4XjITInXuicDF/vassTWKZ+C0CFIM?=
 =?us-ascii?Q?w8XkTzKB5OKOMrNvCMcPn5oklIUL2ssnMdQnaKc4/hsnJIhiXQzbVEKS7c9x?=
 =?us-ascii?Q?50tNBn8siOizHdgQQ+wIm4/574yV7/b+arADF6rkoLTDaiKncB0EKixmyOo2?=
 =?us-ascii?Q?ZIgVKmdGN39G+nP3f5NoQq5+T4V/K10PGkFApNCmjLwrkVcb4RRe2KqrGZRC?=
 =?us-ascii?Q?JtzUBVPLIoxAtTZa68LKkswz8Dewt2uqM4k/asfk1CzYR2cDoqCjCFHTJxQC?=
 =?us-ascii?Q?0x0h7PdihygzeAKra/6/r/VQbzWdJpurOJpIZdmN1Pvd0yB8HsCJAAEwNBnY?=
 =?us-ascii?Q?GqpBJoKFsVpc26hRZNIlSRwQ8Z9FXyW0k/LBZeCYlvEx8Km+4NFVH400qQfU?=
 =?us-ascii?Q?t3nTAyfFtRtr6mao3cFYW56wS5rFW9K37fEy0Z6Id3ZmwjkTD6oLZymLmb6m?=
 =?us-ascii?Q?hNMAC6SbHP9EtSTJCO9qJQrbFTu6L54hCOnM2atVWfkQn7UB4AoaPuJBjZc2?=
 =?us-ascii?Q?ICrqg2SF5XEd+BAKygQeVPelyLCNMUBV3MI4s78jNrDSyhvmFENK1x+/rvBI?=
 =?us-ascii?Q?rErSTrMAgn6pfjpjxxCyClotxj77A+gc7QKPwfNdNCWYv6OfGng6xKLUUE7F?=
 =?us-ascii?Q?UIzZHdZeo9xLkUjM20brRjyrDFATNDfCj9GQJgy2mg/7IQhdeiPyQviYOGxW?=
 =?us-ascii?Q?DiXJuBOqrG1HrRfIGQcbTQDzd2DMdT8adTwYCgwea1IglBOr8FsNTPvxLD/a?=
 =?us-ascii?Q?3b2/u4weK+L3EwYCtApCCswpd3ttXjrONznRoJ4k2JB68aaLzyBuoEtcQIq9?=
 =?us-ascii?Q?mC6R6wWSwedOP3g2FJpxxf59gBhCjkxBseNCTk8+VCzVTm3tNBkrdajE1Tjd?=
 =?us-ascii?Q?WSmfhVU7VGG8iUDmDbdK?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f14032d7-f8dc-4aa8-85e2-08dd192450f8
X-MS-Exchange-CrossTenant-AuthSource: AM6PR03MB5080.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2024 14:09:52.6884
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0302MB9037

Currently fs kfuncs are only available for LSM program type, but fs
kfuncs are generic and useful for scenarios other than LSM.

This patch makes fs kfuncs available for SYSCALL and TRACING
program types.

Signed-off-by: Juntong Deng <juntong.deng@outlook.com>
---
 fs/bpf_fs_kfuncs.c                            | 21 +++++--------------
 .../selftests/bpf/progs/verifier_vfs_reject.c | 10 ---------
 2 files changed, 5 insertions(+), 26 deletions(-)

diff --git a/fs/bpf_fs_kfuncs.c b/fs/bpf_fs_kfuncs.c
index 19a9d45c47f9..609d6b2af1db 100644
--- a/fs/bpf_fs_kfuncs.c
+++ b/fs/bpf_fs_kfuncs.c
@@ -26,8 +26,6 @@ __bpf_kfunc_start_defs();
  * acquired by this BPF kfunc will result in the BPF program being rejected by
  * the BPF verifier.
  *
- * This BPF kfunc may only be called from BPF LSM programs.
- *
  * Internally, this BPF kfunc leans on get_task_exe_file(), such that calling
  * bpf_get_task_exe_file() would be analogous to calling get_task_exe_file()
  * directly in kernel context.
@@ -49,8 +47,6 @@ __bpf_kfunc struct file *bpf_get_task_exe_file(struct task_struct *task)
  * passed to this BPF kfunc. Attempting to pass an unreferenced file pointer, or
  * any other arbitrary pointer for that matter, will result in the BPF program
  * being rejected by the BPF verifier.
- *
- * This BPF kfunc may only be called from BPF LSM programs.
  */
 __bpf_kfunc void bpf_put_file(struct file *file)
 {
@@ -70,8 +66,6 @@ __bpf_kfunc void bpf_put_file(struct file *file)
  * reference, or else the BPF program will be outright rejected by the BPF
  * verifier.
  *
- * This BPF kfunc may only be called from BPF LSM programs.
- *
  * Return: A positive integer corresponding to the length of the resolved
  * pathname in *buf*, including the NUL termination character. On error, a
  * negative integer is returned.
@@ -184,23 +178,18 @@ BTF_ID_FLAGS(func, bpf_get_file_xattr, KF_SLEEPABLE | KF_TRUSTED_ARGS)
 BTF_ID_FLAGS(func, bpf_fget_task, KF_ACQUIRE | KF_TRUSTED_ARGS | KF_RET_NULL)
 BTF_KFUNCS_END(bpf_fs_kfunc_set_ids)
 
-static int bpf_fs_kfuncs_filter(const struct bpf_prog *prog, u32 kfunc_id)
-{
-	if (!btf_id_set8_contains(&bpf_fs_kfunc_set_ids, kfunc_id) ||
-	    prog->type == BPF_PROG_TYPE_LSM)
-		return 0;
-	return -EACCES;
-}
-
 static const struct btf_kfunc_id_set bpf_fs_kfunc_set = {
 	.owner = THIS_MODULE,
 	.set = &bpf_fs_kfunc_set_ids,
-	.filter = bpf_fs_kfuncs_filter,
 };
 
 static int __init bpf_fs_kfuncs_init(void)
 {
-	return register_btf_kfunc_id_set(BPF_PROG_TYPE_LSM, &bpf_fs_kfunc_set);
+	int ret;
+
+	ret = register_btf_kfunc_id_set(BPF_PROG_TYPE_LSM, &bpf_fs_kfunc_set);
+	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_SYSCALL, &bpf_fs_kfunc_set);
+	return ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_TRACING, &bpf_fs_kfunc_set);
 }
 
 late_initcall(bpf_fs_kfuncs_init);
diff --git a/tools/testing/selftests/bpf/progs/verifier_vfs_reject.c b/tools/testing/selftests/bpf/progs/verifier_vfs_reject.c
index d6d3f4fcb24c..5aab75fd2fa5 100644
--- a/tools/testing/selftests/bpf/progs/verifier_vfs_reject.c
+++ b/tools/testing/selftests/bpf/progs/verifier_vfs_reject.c
@@ -148,14 +148,4 @@ int BPF_PROG(path_d_path_kfunc_invalid_buf_sz, struct file *file)
 	return 0;
 }
 
-SEC("fentry/vfs_open")
-__failure __msg("calling kernel function bpf_path_d_path is not allowed")
-int BPF_PROG(path_d_path_kfunc_non_lsm, struct path *path, struct file *f)
-{
-	/* Calling bpf_path_d_path() from a non-LSM BPF program isn't permitted.
-	 */
-	bpf_path_d_path(path, buf, sizeof(buf));
-	return 0;
-}
-
 char _license[] SEC("license") = "GPL";
-- 
2.39.5


