Return-Path: <linux-fsdevel+bounces-39776-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C9AF6A17E89
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Jan 2025 14:09:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A179D18821C7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Jan 2025 13:09:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78FCF1F2C27;
	Tue, 21 Jan 2025 13:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="PC15QJAp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazolkn19013070.outbound.protection.outlook.com [52.103.32.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 061981F1308;
	Tue, 21 Jan 2025 13:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.32.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737464952; cv=fail; b=YGgmOb6ea7NWL66GH4Co64IKhsiExOcidwGszQ7vL67Ku87ZWpGDcItG78KsmDSsQrwldtd30LUTbHf0W0qzk7jnnwXOf6yFHm9Q0V2q7Zxwl5ADqDnCurg5UobhUfuqSAS6URv6tws0Dw20F4BjwAkHnP7uAcOW0UCeBZGE8LA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737464952; c=relaxed/simple;
	bh=Z98SlYswvTOLTJ5U4HYyJYif+T6I9OmR1MD/gfOdJ0I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=oLEhaBnExnW4eePyVEXyVKR6JnAcwayXL1joeiFfSOiVprFyTLnaZ0Zm9hgl3XPD/OP5iKpmFC038vJhCEqZkuKidPHfb/C6Le7MepQENb8/KwlVddF0PXn0LotSb+Jk4reMmt4fbAfVfPegMAoUMsVsMtY2+aOzq5YTRRgXk4w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=PC15QJAp; arc=fail smtp.client-ip=52.103.32.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MXuQ7WTqrnBl+ynN1HqdYRiqxmltwjnFh6cBpsG9NdQhI9vX20lcY6NgwJv+QWJsQqd/cfzcO8JI390rpCOLPQYl2YEBdVfsxO7n9gOBX3OCipPaBRz+4BcFvlb5pjyF7Ihu7KSCMUEiBU/sXqFaoZcztYMasiODrf3HVk/fQ1tKwtAoM4/cjb0FAJGGr1Yk0KDn2gp//9NZopPTjpekxDeuTtr3WyUVrMsAJCbKI7q/8Q6Kt+TJwQYIK8GjWA1AjtyoTFKITyq7G+gwVjTMORkc6k27nyAJbACM9QxxReUmqbNbc6/7aqRzLQaa/zUHxRsFdq5m5m1Jo/82MylOXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mu9z6Ffs6fZx0FXVek680VNLVqR8w6Pgi3x/k1UoQWE=;
 b=P3PxuENITwnK5r6bwx48RVcx2DH7YKMVaJGhZ5kBySl+KahVdhtqGUksNbCHUDqsLouryC17F0iB6d57nb698T2RSL30pvoZqfMn6vQ+AIOgKt1lHiU2zvO0VhqAs5tk1Szk8nQAWcnUoCh+vmUOn9idOi6RQAmmFeGAu6tIhEcsinbQDOtM9frdPFZoRd/J+A3KCDOAval7SYGyRWwvMSiLnzi0SpiUximsaec0InzZ2e+O1FQlHSzdcZ/WYu5oFso4ELPC/ugLuMnTGH2c9s+X5M9WOzyfEP4MK70yPLY9j2hm05X1YopJ/5jFoI5PaQL8p7+e7stEcq0JgtDtlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mu9z6Ffs6fZx0FXVek680VNLVqR8w6Pgi3x/k1UoQWE=;
 b=PC15QJApAtoYKRKY1NvN6i/b6N3RTfHyXEenqVtJo1TjpiPSYs0MjW40mjBeEG4to1AbhWl/W6xF3Q9eJo0aOJ1o7HRBxZ4771XSxjxFkig/rCQvIl2arU57BdxddTCxNVXogrF9lSDqyFOFs90x1t6/N1oH28Va4MdnS8AHegXcoFsUUddSMzcTOlx5tu+A4TeOHBuoT/8SRkX4imTI6I6LZCztiQLYk8/LghiM2v+FmFhIe4jYRLOuB2PGHV+zOfs803GMV623yORdH9DwM3Ut/ZMJyxH2cJp7FGzTstIY2trLkNS5qbpL1vnXWxjBhqxd3HLGyi/AUR35jsStmw==
Received: from AM6PR03MB5080.eurprd03.prod.outlook.com (2603:10a6:20b:90::20)
 by DBAPR03MB6407.eurprd03.prod.outlook.com (2603:10a6:10:192::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.22; Tue, 21 Jan
 2025 13:09:08 +0000
Received: from AM6PR03MB5080.eurprd03.prod.outlook.com
 ([fe80::a16:9eb8:6868:f6d8]) by AM6PR03MB5080.eurprd03.prod.outlook.com
 ([fe80::a16:9eb8:6868:f6d8%3]) with mapi id 15.20.8356.020; Tue, 21 Jan 2025
 13:09:08 +0000
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
Subject: [PATCH bpf-next v7 4/5] bpf: Make fs kfuncs available for SYSCALL program type
Date: Tue, 21 Jan 2025 13:03:05 +0000
Message-ID:
 <AM6PR03MB50806C5D9B5314E55D4204A499E62@AM6PR03MB5080.eurprd03.prod.outlook.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <AM6PR03MB508004527B8B38AAF18D763399E62@AM6PR03MB5080.eurprd03.prod.outlook.com>
References: <AM6PR03MB508004527B8B38AAF18D763399E62@AM6PR03MB5080.eurprd03.prod.outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P265CA0260.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:37c::11) To AM6PR03MB5080.eurprd03.prod.outlook.com
 (2603:10a6:20b:90::20)
X-Microsoft-Original-Message-ID:
 <20250121130306.90527-4-juntong.deng@outlook.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR03MB5080:EE_|DBAPR03MB6407:EE_
X-MS-Office365-Filtering-Correlation-Id: 92e0d518-a491-49a9-c155-08dd3a1cca47
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|19110799003|8060799006|15080799006|461199028|5072599009|440099028|3412199025|41001999003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?HhRbYjK/Wh0FG+HiPplL5TccPhsqpFS3ntLi+F4YVi6N/LCEMcOZPm+7Wpth?=
 =?us-ascii?Q?xN/Yy7+EH0vhu6+8YoIHHP4pjT+yFwqEuiHweaDSdtj1+aDdSSRhVOYn1hlz?=
 =?us-ascii?Q?SSOtZe9ajPx2uj4ytL20o+DCuqJ8OvfBmpEKfSAm1xdl3emwFZ+J8UVpgu2Y?=
 =?us-ascii?Q?Kz8GgGFBzyIrKkBQqJZYewhR1g8V21Ll6WwuRhUW041MCWAzR3TkGGPf8ch2?=
 =?us-ascii?Q?PCs4y4ogdjhGRlaZqH1BQzU4ZLCUd6eoPBJn5GXR0hfmvyEis++ymTMxhCWI?=
 =?us-ascii?Q?71yCKULTR0oXjzwesTxcQa+qChalntv3nH8J8xa5pH1wXndImgzN2jRGFy1M?=
 =?us-ascii?Q?WX0HqeKPRhHl52ispA0sQMmNZazxx0Xczn4XLQ2PpeI9bOyeJPacDZI+Rm53?=
 =?us-ascii?Q?apx2q6UkuTZwIEpkSUysqbOtXObEc6XPDDyC86tAdlB84w8kX4uYZC0DpAGh?=
 =?us-ascii?Q?Tecc9NkZ3PekFeLSAixpujwOeuJBEJwjvFkemeayBCmfnqTE0bpOkiaPYnz4?=
 =?us-ascii?Q?7MisdyFS8gn9LttSMFvOGF+ec2ihFAjCtUD0VZW5bwbUngVOw04y+gi6EC5V?=
 =?us-ascii?Q?43NRii4Wh0BFqCj0wqreT8aG4OGdWrhYBmVv2IXWv02e7DxDclfNeD/WiFa1?=
 =?us-ascii?Q?VY24Rsxq1v1YVCrkUA3ypJZItNdWhDuAw0ko1/mRFd03qMmTW4B5Vm5NaTi7?=
 =?us-ascii?Q?gn+fDC5qjKro+u4sxmC+4Zv3mPbWQ1GvP7akMKh3HO4a36LlHVPZN/n8Kj0A?=
 =?us-ascii?Q?gv+vxASV3cp2ultlgVr8i6GzFcJITzwJ0oCMKM/p8P0wR2pM2nPUvH0w4hxo?=
 =?us-ascii?Q?Cm3kekzAkrh67FsvnKLpRRmQLFVuKKumVKE+1UowWX6TXtrEdqxAwAG4d7zN?=
 =?us-ascii?Q?cIzC8w+kZvK1Z2jyKm7c+cJAVTBRm5jKdWAw79i8F32THZL7Hkg36n4qzS4W?=
 =?us-ascii?Q?P43XkfxvV59CQLuSdOh24Tp2dfHHqqWo18RJ4IGFFI7RvlgeYfPZqk0dzygW?=
 =?us-ascii?Q?YTtUf72GEeKUVwzAml7TlBoSUQ7O3su1u5JbbgLmXrq/JUVHmD5theo766oh?=
 =?us-ascii?Q?dXiLevVRjdR88juggMGPjymQLyY0sQ=3D=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BEq3crvzyDsuiTeBMtj/VFCgOUSySHTJrintkwQTxDuULGmle+uW3Euzdh3P?=
 =?us-ascii?Q?2nG3K1MAnUPpL5MTSINFmPNJ/9xH3aHgo9dTS+ntpQ+3f2CVPvoGV6fq4e1w?=
 =?us-ascii?Q?UlK4ftcRTTxJ8IZgDQtg4+9wPDWFDekdNQvZPx14uy2QigDhHYnD0J8Zk67v?=
 =?us-ascii?Q?szlQ3lLu6GIX6kDM6MGuJflQvIJcB+c/ZH9s0HlgXD7YOQiRGG1QQiHzaNWs?=
 =?us-ascii?Q?W0BIAwqG9SmSYX+fwAV4Hx1wziaAWmwLV853CzGOa9EzUd/kaGQXMRSuYgXk?=
 =?us-ascii?Q?Gtts56cHYEqifuB70gIft7RhYD9th6yj8dhJ7+rLd42FzwXF0Viy3WeQQohm?=
 =?us-ascii?Q?NVa3Yg2I02s55cMrTZRpQtLKRl3piWd9PXNZfN/71dvx+dF+IlBWekITJB8S?=
 =?us-ascii?Q?GArZXc0cqz/Mz0Y4JO5w7oQbFm9lZCf4lGJDmsDYcatF0kK195DlpECGh0gx?=
 =?us-ascii?Q?I/u3HrHFHdWFlcwyeWpzl6jFnHRzuxJ5faoPEORfz2fC6xPQCLZmaJ+ozbVK?=
 =?us-ascii?Q?lHxN/UYA6kbfgxTZtrCLrFnXXjsVOc6ninKbKrXKOB7n2v7Bqp9/9gkkZXas?=
 =?us-ascii?Q?LpQ7W8VKGzz18fBxMpw3Cu1gzC1Vvxi4B/uP2aSGgRWdqo7fDHjgdJYcDGec?=
 =?us-ascii?Q?HMrptVYvPpDWK+QtyvolLVnj/lYByVOe6wQsRWJZ26UqRElEoZx3NL9b6X8E?=
 =?us-ascii?Q?Vxl2WRNYr9CPT25ZXLbR8IX+eTh7eIACxVkKotp64bWItD2oTivvX3BTRuc6?=
 =?us-ascii?Q?AIJkMEikjwB9DLQG3QwgBmNa8sy14Nu8Gye/n8ahKC1RV4pU71gXPEIUxdPX?=
 =?us-ascii?Q?F59YGEjkMv83eePLtHQAQjijWXw56Xtuym2zs3fKDjhF0UZT36fZBV7PI68Z?=
 =?us-ascii?Q?Gm4GnyO5lMO9D7qtuhMLm2W0bSKpCQHyGsvZ1/6YiBzltsiV7h9/nl8H9SJh?=
 =?us-ascii?Q?BxiWh7sX9Wo2AteInuAX8nhIIBJ5Rh1ahbx9J/90rQd9TfeJ0w5mUO6ZAZkG?=
 =?us-ascii?Q?+aPo/GCUS5Z+oKzsahoM2952drf9Fi6khG2gFvNFuypuL2YYA80IZO7IJorx?=
 =?us-ascii?Q?IL0wthokx/WUcFw1a13YrtHwzXSbSjI/LMAhJ765/cti34KxJ+vJbnlwRN3d?=
 =?us-ascii?Q?VOO7F+ZlzYVAhpMZtWmHMaov/aBZfex+gyCrBA8garxT8w3KoJBLFTajt8nO?=
 =?us-ascii?Q?4K+bJkb3B8sKmIL6mDcjsoOmySNTjiWRxAAVeJYG6SZohYpv9TLpF/WjQ+r2?=
 =?us-ascii?Q?RQkbj8iZUsZoJv035Q+C?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92e0d518-a491-49a9-c155-08dd3a1cca47
X-MS-Exchange-CrossTenant-AuthSource: AM6PR03MB5080.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2025 13:09:08.5885
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR03MB6407

Currently fs kfuncs are only available for LSM program type, but fs
kfuncs are generic and useful for scenarios other than LSM.

This patch makes fs kfuncs available for SYSCALL program type.

Signed-off-by: Juntong Deng <juntong.deng@outlook.com>
---
 fs/bpf_fs_kfuncs.c                                 | 14 ++++++--------
 .../selftests/bpf/progs/verifier_vfs_reject.c      | 10 ----------
 2 files changed, 6 insertions(+), 18 deletions(-)

diff --git a/fs/bpf_fs_kfuncs.c b/fs/bpf_fs_kfuncs.c
index 4a810046dcf3..8a7e9ed371de 100644
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
@@ -184,7 +178,8 @@ BTF_KFUNCS_END(bpf_fs_kfunc_set_ids)
 static int bpf_fs_kfuncs_filter(const struct bpf_prog *prog, u32 kfunc_id)
 {
 	if (!btf_id_set8_contains(&bpf_fs_kfunc_set_ids, kfunc_id) ||
-	    prog->type == BPF_PROG_TYPE_LSM)
+	    prog->type == BPF_PROG_TYPE_LSM ||
+	    prog->type == BPF_PROG_TYPE_SYSCALL)
 		return 0;
 	return -EACCES;
 }
@@ -197,7 +192,10 @@ static const struct btf_kfunc_id_set bpf_fs_kfunc_set = {
 
 static int __init bpf_fs_kfuncs_init(void)
 {
-	return register_btf_kfunc_id_set(BPF_PROG_TYPE_LSM, &bpf_fs_kfunc_set);
+	int ret;
+
+	ret = register_btf_kfunc_id_set(BPF_PROG_TYPE_LSM, &bpf_fs_kfunc_set);
+	return ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_SYSCALL, &bpf_fs_kfunc_set);
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


