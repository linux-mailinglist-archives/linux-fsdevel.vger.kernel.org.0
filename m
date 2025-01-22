Return-Path: <linux-fsdevel+bounces-39880-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CDE9A19B5B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Jan 2025 00:09:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A8F9D18838CE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Jan 2025 23:09:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18F851CC881;
	Wed, 22 Jan 2025 23:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="fRiwXprp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05olkn2098.outbound.protection.outlook.com [40.92.91.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2EA41CAA66;
	Wed, 22 Jan 2025 23:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.91.98
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737587361; cv=fail; b=aopVOMwEYv77zKk/L58wibwBpYGzIheEeOPGYjCQyN9NMRJhOn5p+1waD0INuKJrb8wjQyf4PWXviiAb73US64ZWriGR45Y+04ywzjXnQG74kHlgxqmS6VNOBUBpesVvw1d/IXPxjE4hFZA03z0QpfivEnLe1oSmVVGF+ep+U5Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737587361; c=relaxed/simple;
	bh=R1FX0j3ccrdp108Bs1PsHyNJF95PBMaPconV1rA7f30=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VMdzteW66CfGwyNJW4WSowdjHjqBHSf0fVI2NBURJxzsFcxv1pzQY2fsQiaWf0Qqjwk2lNQ8vhU09yA8QwyKMgNxARPmrdWBKp0bYaI/d1MQzpYEoNecDGLgCMATGkwokKvAxik+FG0qm4ETBiZFw12iFV8xWivDZcdcc7PBvjM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=fRiwXprp; arc=fail smtp.client-ip=40.92.91.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HLmZ+aA+PqFjL0Hy1JGWt2m69oIqQu2qMqwwv3ZgoGAa1Yoiy0Vr5hje6jA8Z0VOoqweEwwj7Xng01mTD7SMIWccZ80So6I8bRlOhGzlc++oXClQcaYYiSzh39FJ4L0x1+PRtoTjd7a+2frASNmpnw/Ls++7/vprAwYDuvnCIl0y/ru3HYgFP+35iHnPa1nsduuGY3GGww/zV+CBSK1YMPQpVmhBc04GSoUrsNlkSCJ1OBx3xfWX9KwW1Q3dLusa/mex+hZyRMik6IG++McopA9ut0nQJruIXXsy7yV8V0CEfUdeZFsf9nxDGpEYk03sdNaBHT8xbidGFo+mOWJE0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w+lFUOEbNYJBLXwOkeTO7mJz+bvLyupgyonJxx7IfUw=;
 b=jE8Pzx7zb690yAMm+uzLbzZwYC9IvXrhEEUh3UiIflAMvShFapOiZNNS45R/Of2+t8g22Qz/pVlFClTEFsHKOt4M+53zDHmVv3RYc3myM9HrZpjVMU5NQkKfAFtXvRsNN7qGKm01vXYBGq8gxs2777z/SdVA0xS9Z3ppoe1CHyGw8UJz05jL5MEftvI2W5L162MmI02ooM8kPmw/ibhLjKXr+I8C2re3cTThZmaiZsxCq0rlqiSY2QRaLn3jpLHGGrRIZHmqZScHZtCGDdX9gnVPsXV4APHz12mlvR0VtWiQf8gM1k89BV5p+LXExwuuqLYwgh9HDRyYpAiwBH+dqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w+lFUOEbNYJBLXwOkeTO7mJz+bvLyupgyonJxx7IfUw=;
 b=fRiwXprp0Tar/k70eVdNVud87OfJm2JMkh3Gu9IwkvidsESU8Q9fpziH1Uhaanvv086OQYqksfkdM6o9rYlpbhusouaGzYxW5A10u/j0kxdheH9zlN3ZCy9kS1b2RW/Ktuc3iDzBuoNi49fFgM0rIoIRUp1wGv6kWIHRVuJteERwwgIDDX+zyDLq3n0iOkuXiGOaZt6VnUxcaTKoOuQdqA9/eK7q35PijcOAdXhVwbRDTMwmsi2C+YHQRLZHBf1rjOHEmEL3zPqXDbwC201Wzc4iPVJJc52hP/E+jhlh6yhGCm5lCB26sAAguqvaBfN9hvJhCa6IuStR1l/nLWvNow==
Received: from AM6PR03MB5080.eurprd03.prod.outlook.com (2603:10a6:20b:90::20)
 by DU2PR03MB7958.eurprd03.prod.outlook.com (2603:10a6:10:2d9::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.10; Wed, 22 Jan
 2025 23:09:16 +0000
Received: from AM6PR03MB5080.eurprd03.prod.outlook.com
 ([fe80::a16:9eb8:6868:f6d8]) by AM6PR03MB5080.eurprd03.prod.outlook.com
 ([fe80::a16:9eb8:6868:f6d8%3]) with mapi id 15.20.8356.020; Wed, 22 Jan 2025
 23:09:16 +0000
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
Subject: [PATCH bpf-next v8 4/5] bpf: Make fs kfuncs available for SYSCALL program type
Date: Wed, 22 Jan 2025 23:04:50 +0000
Message-ID:
 <AM6PR03MB50800269747016757C7BA35D99E12@AM6PR03MB5080.eurprd03.prod.outlook.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <AM6PR03MB50806D2E13B3C81B0ECDB5B299E12@AM6PR03MB5080.eurprd03.prod.outlook.com>
References: <AM6PR03MB50806D2E13B3C81B0ECDB5B299E12@AM6PR03MB5080.eurprd03.prod.outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P123CA0049.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1::13) To AM6PR03MB5080.eurprd03.prod.outlook.com
 (2603:10a6:20b:90::20)
X-Microsoft-Original-Message-ID:
 <20250122230451.35719-4-juntong.deng@outlook.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR03MB5080:EE_|DU2PR03MB7958:EE_
X-MS-Office365-Filtering-Correlation-Id: b2f3251e-7230-4367-9604-08dd3b39cb35
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199028|8060799006|5072599009|15080799006|19110799003|440099028|3412199025|41001999003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?zKCgaLTsKdaZT4o8pY65hU071KukpQDgDyTh3t9ujE3Fz5ggPQdMVoXBLUoz?=
 =?us-ascii?Q?N7UvNLmawdyUNrNAGMfHSxH/TVnpvrwQdSPlX2dwrUpvxViv6UnL6uitlKYl?=
 =?us-ascii?Q?VQX2xdKBJlJ/BjOvbIs6RIXB9jlhYUUNhfixeKBa7p+Y7Egkrk894ZU+LzWa?=
 =?us-ascii?Q?8qA1XsZYAVi9KRch7hrCpDSUojxpkx+6i4SBUVLWNNpQZ9MgxLuGpm5P5pqw?=
 =?us-ascii?Q?tYIHPOV76bZj7R8qZpbFHDmOGNbw2Gwdsk1mYcnEAlKmz+ZgMuPXjW6qQFcK?=
 =?us-ascii?Q?m4AtYpSoJnhHDSdMKZRbJ67S/dFTGkc72X7k8keV411yAsy2hBZExkiFhtky?=
 =?us-ascii?Q?JGGKHmctVwTMSfg3WBNlIsz87oDVutoy23MkKwlxrIRM3hdAm673cNK+55nj?=
 =?us-ascii?Q?czFFO2HFgfXRztRwz6JY3TsIlqA9ZUqpajSQtpo5AXj8RIfSz75E+TOGZaXC?=
 =?us-ascii?Q?INUZUhVqBSHgMgb8Hmd0pJdu2uqwCYLY1FCSkQ/zhEevL8y5eKCi6L9h0X+a?=
 =?us-ascii?Q?/B2oTOc+/y1n/+IPvfDjfGoez3KUEf0hxDhUIdAYinXjAMAwIjFrUTabiGgk?=
 =?us-ascii?Q?0N8A4FyrqCbKvRjQhnvmUPbBhiYMdslr63WbMBsYMOkxMjH6HwB/8cqQPpje?=
 =?us-ascii?Q?/0RnjRGvcdi1/PQ50Jg3FDT1l1GrC37bymraCZG4yxPJ3ugiQynJBbiNh987?=
 =?us-ascii?Q?UbY+70GUUkjZmqbtY3j2ddKNcFnpJi80uhuy7kSu5d+exn+bXOVItICuVoyM?=
 =?us-ascii?Q?pH6rM4fA+O0hcuQbQVTXKj3rppwfIFI5/GK7zF+FCbRbfMa7L3Pjv6YV6l5H?=
 =?us-ascii?Q?ELtfs2i2ZZMdt4deNKlOiBPrCyVjUHvKgTCSezfbM12iVD/cM/aymkghD2KK?=
 =?us-ascii?Q?O63J80nOO4gNoA+KaeQq9AZLyoiEW7QwTW4Eth61/IoP0QLT3uHgBsdCWxB4?=
 =?us-ascii?Q?jKvansWNd6HyjF2krcKUF3oFmqCnTBGV7QOa6LxGl4WCflkVMKy2Ury0MOwa?=
 =?us-ascii?Q?HrfrCVQzF6uQ2L2znxDdYiK470noC74Gc41Ip88Heg/AfFVse/KXk9R9ROJu?=
 =?us-ascii?Q?gd/BnSxhujlsJEyGYaRGIF+MpWCizQ=3D=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fEwj58XQVgsKgrorXWHuYXaNXOVHGXsFOvmlE6ZX3D27x7YPymmnKJOauyU6?=
 =?us-ascii?Q?UTw0MEt1dSNRT71YnSz33amJtkYcgLVG3wKoH7qbZGvTj1amVngFXu5kD1Hi?=
 =?us-ascii?Q?o6Noa31oqGsbfkPHrywEcJIW2rBzsDBQYXUaJN4SaVgJp69Shv/NLrlbkWwR?=
 =?us-ascii?Q?wJ5MUvC/fQxdf1vHfhXrRQCNWSDGXulV9cr/MQ+kvPag46HoDnvLBnIrVfkW?=
 =?us-ascii?Q?zWLe5RfE83PXdyfZB4f8N/WYlZt/kDBJ5jKoE6tHo8JZ/rvgkgZzmF6YIQUr?=
 =?us-ascii?Q?+lvcjUPtoc3267QctNNcxhsiR0S1LyME1oRuEvyIIjs03bc7B/H8cyK822Qy?=
 =?us-ascii?Q?4YQhVLmh9Fw9E15PO1XNYZTgtUBC1R4m/hrgxhxW/efTKALTDhtmhERbJjTu?=
 =?us-ascii?Q?4TY4/NOStv2TrEnf2kuWmN+rVZKTfJ+ZoCxBhtsNdQnlDaMaBBPuPn4A4f0C?=
 =?us-ascii?Q?sTXEYXF+DOwSSjEMtWoHun4GqPfpnRuK7BK/PYnVZBqwHhpbT3767RKQ5zTb?=
 =?us-ascii?Q?Lds+vd0C7u/9opic21pZsqtAJgOq33cfmOwBbBDnXblDoZOrIWN6OEpJA2eI?=
 =?us-ascii?Q?zGLQrmsEpfSZ8x0c6c1/v6pk9tBZ1fu0Qqh8iUqnkngS2a2kDcB22K496cJw?=
 =?us-ascii?Q?QAP4JfgLlrltjGbW/3KDeyJBwtgULIm4LaJf7rtVe/CGb39RcSXhrf8uwPFw?=
 =?us-ascii?Q?vv0Hem+9Ci9EhH5ec1pFgkbs986/kLBpXvvGVKAOXxRu9AsZJjAtXTDSqiks?=
 =?us-ascii?Q?1jxMiqbm/e3TfIjwaw54RmR78Y7r89phEARpsuEHhoM+mn3BNDH4CKiy88ia?=
 =?us-ascii?Q?yIJfI1Q78IhHalOIE+VHVftTOQD4706WtDbHcg2cP/s5ZRBLj0LR6uF6jkJR?=
 =?us-ascii?Q?iFgfgi2FHriuMsd1EefJPXGzEJrHgjdUoGvq3NhlX18lzY0BI810gSdG6Uns?=
 =?us-ascii?Q?3nFYtUv5rA8S5LvDl+l0zBc0hJy84XU4vfR7jp6ewC1NEUTeIfAIQauE0ypD?=
 =?us-ascii?Q?jIGGrbiunwyn/7mQ+7aHbfl1hfkIFTDS5aaJ3mqm3yrx6mKZyODRvXAdm9fE?=
 =?us-ascii?Q?EScdL7r+h07taXCLEMzna1zYsZiebhG2WqgiQF/IIPoqnDIUegMgWxpN771V?=
 =?us-ascii?Q?G+rvW6bK/Tvj1dE6+C/wU6H9qluoARm0lNxD8ACcaKGFpKvhhr8/0kJfo5Oo?=
 =?us-ascii?Q?wX+LQE1vtWRTD3QkipxpnYbfhtaC4xzY31ssa4c74l2QslLOauSmeKE1w1Xd?=
 =?us-ascii?Q?fPDLMoeMuEYZG0CLezmb?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2f3251e-7230-4367-9604-08dd3b39cb35
X-MS-Exchange-CrossTenant-AuthSource: AM6PR03MB5080.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2025 23:09:16.7191
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR03MB7958

Currently fs kfuncs are only available for LSM program type, but fs
kfuncs are general and useful for scenarios other than LSM.

This patch makes fs kfuncs available for SYSCALL program type.

Signed-off-by: Juntong Deng <juntong.deng@outlook.com>
---
 fs/bpf_fs_kfuncs.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

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
-- 
2.39.5


