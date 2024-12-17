Return-Path: <linux-fsdevel+bounces-37682-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DB0189F5AA4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Dec 2024 00:46:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2214516A4B5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Dec 2024 23:46:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 540701FA82E;
	Tue, 17 Dec 2024 23:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="jKZYIL/0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05olkn2049.outbound.protection.outlook.com [40.92.90.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A72871DF969;
	Tue, 17 Dec 2024 23:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.90.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734479144; cv=fail; b=ajgNme6Yfc4iZ82hBIClGTCK2b91jtkID8yj1zM5DQUUbaZEYViE5FJNQJXdy9Lk39M3vRPokXhFhBHqNiPztxKL98zpwNntdi3xlAq26/WC3RyQZq1YQvBZ+JzwIxQPE09ClaoCC0bdNX15mhaCT4IheU6h74UCLpFxmI6F/PI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734479144; c=relaxed/simple;
	bh=TlAmZFVAXDw8hB2+tk50ydgHNEMHZe3/jN/g6w5HqoE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RSg4BBB8sVJfYrAQroglr4Luy7tRRkQfLxIFOYGoDzy0nAHS+40sEkBl/faO8jY4isayem6ZY6iMxcpEXdpoU/1C8d3laQKpzqrnS+s1KJNGP0HR3Y7ff5Rq9SKRunLrifkzg2jRExEjTJJpGGfoXMXuZhmYCzM5V/b478KbDTw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=jKZYIL/0; arc=fail smtp.client-ip=40.92.90.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eV3KFUsefdn28rjWYZnX8kPMyqo2Ru0ArO3U3XBYhFL1uOAD3/iKXvfx+y86Qu78ooAWOiF/7NHpPuHWtCI3AnoT2TBx/S5h0cmGwVYwdp8fvuPtwzyUvS64MDypk9nSgTPo0ersHLM4nSiX2jaQ6kNouW2MZd2qd5SybsoCQxV+e6oETC+AeArFOf7pekLqko3K62h4UFtT15cRIliCxYJxCB+6ZPkFKK0YieICnZb9wSGdRP96rLZMEMr/2uWaZ2Mw3iBDXKVe3RCj1RBmJz5xea6Quv+DN641UY51i9HaGBxEWp3druNTOjgktLnIVWsOldNkBkIEyiT6pSDEMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xa9vl8cG4E6D+oqH6Dk5TUBdYgnMGsYLe3tXzjbKMJU=;
 b=bSZtQjv0VasXx7OY+0EKIMKmi8+Rzy7jqP50akcuQYt989LtzVex42pLrru8xpPi5byPQIikXyA0RAsZPXhhIcIUMWtkoVY6IslXR4+lMGbinEr2TsnW0WS1SSGlr2ATmazJCaC76cleqViezo7X/bjhRbfX6cgrt3yeNCezGAYOPy4bcc8jHRCanswD43LD1D7EK4OTQNZGwAOdpD385YZTLAZt9X0xPkKtqoaHfUgvsFwf5YX3ZYLbahTIYfTcKijUfKsCZQsbLcCHiEsta7ehSxH9Y2pnZz9Fi3NXrYoQYqKGCr/xjdouXdHAs2MILJ7X3RPBrJtmFCY2a1XwnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xa9vl8cG4E6D+oqH6Dk5TUBdYgnMGsYLe3tXzjbKMJU=;
 b=jKZYIL/0t38flFQdx6n5ar4x7Dw5z7Q2j53S1U8/Is5ES0mdo9ckSnXUuSoSIQrQcDY0IIKiEEK04ifs9shtB10SCx7VxuLLrK6hCqxHOu/BFQFWYkxqrl+MVQGjZr1su4fkLWdmoFPyItYIaglZ2SEaMKQsJUMrJrZQS3O0dtVxupnzPq/OL5+Fzhmkshjsh0FV0MUIUUj2rUNQRkBAhHb8R2ZFc3wRMpXQDm5NG+WeuTZYVBvJp6MjDwtxw6doEu/mGPdw1MZ8qwjefcJ0f8GYqekBsq+SBM+ghLEXNETZMT8VqbtljhRFFacv808v3yrgIcTnZTBeqpMicrGgaA==
Received: from AM6PR03MB5080.eurprd03.prod.outlook.com (2603:10a6:20b:90::20)
 by GV1PR03MB10502.eurprd03.prod.outlook.com (2603:10a6:150:15d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.21; Tue, 17 Dec
 2024 23:45:39 +0000
Received: from AM6PR03MB5080.eurprd03.prod.outlook.com
 ([fe80::a16:9eb8:6868:f6d8]) by AM6PR03MB5080.eurprd03.prod.outlook.com
 ([fe80::a16:9eb8:6868:f6d8%5]) with mapi id 15.20.8272.005; Tue, 17 Dec 2024
 23:45:39 +0000
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
Subject: [PATCH bpf-next v6 4/5] bpf: Make fs kfuncs available for SYSCALL program type
Date: Tue, 17 Dec 2024 23:37:04 +0000
Message-ID:
 <AM6PR03MB5080E0DFE4F9BAFFDB9D113B99042@AM6PR03MB5080.eurprd03.prod.outlook.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <AM6PR03MB5080DC63013560E26507079E99042@AM6PR03MB5080.eurprd03.prod.outlook.com>
References: <AM6PR03MB5080DC63013560E26507079E99042@AM6PR03MB5080.eurprd03.prod.outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0117.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:192::14) To AM6PR03MB5080.eurprd03.prod.outlook.com
 (2603:10a6:20b:90::20)
X-Microsoft-Original-Message-ID:
 <20241217233705.208089-4-juntong.deng@outlook.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR03MB5080:EE_|GV1PR03MB10502:EE_
X-MS-Office365-Filtering-Correlation-Id: 5205a6f2-1117-4401-2674-08dd1ef4e90e
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|15080799006|19110799003|5072599009|8060799006|461199028|3412199025|440099028;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Zk/lRxrqxf2v4SgLO2zpq0ikQesIMbod2ueQKZa100NnYHVCTMtIyIfpVQqP?=
 =?us-ascii?Q?UbG3n65vxVc+Dcq9W1gqniK83c8lzAfDF4JFqytmnl69ZPFk8IxQMFsNmgN8?=
 =?us-ascii?Q?JBNU1XxRrNUMMaQPrlCsYDIMgs1hEia4b5GEevRCrVnLNKRMXjwKASi17ty7?=
 =?us-ascii?Q?JEsPGslGvNrp/RMAt95XH3FBTc76o4uNwbLRaWcZyvxUeDyzslOIcnSZhZi+?=
 =?us-ascii?Q?HXF+cQjNOdd48LsgHH0HrYGonIZrCn2fRJ+mkCCq4rn8DCJ3EZHpZOQdjrUi?=
 =?us-ascii?Q?0vpoKwcwDQWTq2aBnscDPVnh4IPAO0q2jFbTieFTu+brrJXUQ2cW3iAuCaLr?=
 =?us-ascii?Q?x+D3Vf3ilzezn/R8l5Ajz1l/34/8GB21zpNuPWrUy1aGBZGx2yaAjLGV395Z?=
 =?us-ascii?Q?xWXbJFURDN4cB0yARZQ2CtQ2fnJHe2bavrURNstC9vezhR7dHrd4LMeZSnYN?=
 =?us-ascii?Q?GlFBRp3ApSmhx9XUvnhvZn4eOwgkGf9AVbKBqOtbwxbFuHLa/7UyBFPO98n9?=
 =?us-ascii?Q?ioIXgxCB1XMPBs3UrFKv4RPyZyxGlSCLbPP5tu0hJkluEdknSRlwrmfnT4fQ?=
 =?us-ascii?Q?ZjatFGS7UFFD80BLNGVZHYnExddJw/zz2XM34umiB0tQk9rQKXYR3LZoddFq?=
 =?us-ascii?Q?xLc6BPx9X9khFpvU5t1KUziShYK9dV37hs7dDtLAOfnXWWVgdCen76UicjjA?=
 =?us-ascii?Q?ZKxC0r9HfTNQGMDkUlFeGcqrRiXPbQxS9SUU2CcpgDMnYIIQFWtcpnXaxd1r?=
 =?us-ascii?Q?IyzeQ7yf8Cl8BXGkXgFu9MVVjpmHVG7eKfoIHA4h4goXQgjKXhnVtL4Z4S/m?=
 =?us-ascii?Q?u/peeIo9xGh8oE6OrIdMQ4DJupzh61L+cgmF4Jqql4utdvrHS3TDTbXCB6Si?=
 =?us-ascii?Q?/u2RQAd3xpTmwAB7er4bCM5hbyP29BDoGFJZfkFcPLai/ckiICJ7jOfdpfgB?=
 =?us-ascii?Q?+oKy6UQY5bWSopaQi3VFx16U6JHmOCTRI+6my3Wb3ztrcNRNEm6VjDUy0dQ4?=
 =?us-ascii?Q?lB7guG3KmKPd/4quxyOsn8n6hg=3D=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Zg09grvgvmlvkKtvc60Hitq+iqZXJS8vkxVYQBQMogfpW7gedeX4FyxeFsNP?=
 =?us-ascii?Q?OLRuC44+/0SCzZ8hijHCOsPDqgF9PDCHY4xV6WTWGVRp2jnaB0RsQqA3q23H?=
 =?us-ascii?Q?zQaAK0spoR3HIAI/0CzmLQXOzuHduFVog3agZutfiKneQlXgLLI6BrqmIvRG?=
 =?us-ascii?Q?U4Yk2tLqiQgT/pJbGj2Ewp/1UOZPDUlI2AdPTzaC9eGwtY1dEYAtO6XbNFqP?=
 =?us-ascii?Q?cuVxwS0cf+Ey8eQPcM2uNtLQjn+QayLSHumBYMEBqE1CIOXfUu7Hva1coXej?=
 =?us-ascii?Q?eW22c2zbTGvEuQuflzju77g3j8N6vHg6c2MdZsLhcWLdM1wgrbe8yyKMoyx7?=
 =?us-ascii?Q?1zP9WYNQ/hiasTGubUPdZ1OPrduXqMEL41vF5IagVw3M0e570i/IciFAhcTT?=
 =?us-ascii?Q?PkF5aa6f5QzT5eYXY1qhV9CgRpKpUE9WXB54l9ea7fKE9amQDjswzGmLsA5J?=
 =?us-ascii?Q?009/Cf9fHn/nJkCk4hDvWjphbHoIjecliVoLtvf4yEmR06RCCUv+O5newDWv?=
 =?us-ascii?Q?5cGnz3AMap+bvOQAFwON/j4Wz5P+JtUlqQRCQ4aSTPF63hTQgq13tQGXV4b3?=
 =?us-ascii?Q?CszWk02nsJwkdDzg94JiI46hGrG2fY541sUXJxosNOR3R9p9ojZtvOqj+5IW?=
 =?us-ascii?Q?3jsxSV4DbFb0p11GabZKxtuDZXrtTkhPb00YVK865ruf93utfXl5RaTceCbg?=
 =?us-ascii?Q?9ZfU99r4d658FYbpi/UtTlhMSLhS1yCDPM+00j/jwX/K1ZSul7a0OqUJrqLc?=
 =?us-ascii?Q?YQhkHzA4j2Q7Vnj1HiN0eajiSDTDBOINJJdkGrbR5lpc0uxg31L0lCSfiaKO?=
 =?us-ascii?Q?AaYmTWmrepQFrPFuKh/K8agNUK8bbI8w0svuM98nLXnq4dk+CKhV4Nb6RIb2?=
 =?us-ascii?Q?bQtUIUWfO4Ol90CJBCgZTofuqxGyhDjcGHgwMqU4A4WA2TnNSzoR1CON+Tnc?=
 =?us-ascii?Q?U7YZKqN4I4YbAo4peWXc8DEOW1R8dRS52Gdj/LNr5L+GIxZ1EfJvh4xXx5UK?=
 =?us-ascii?Q?j2VhAMV7LYjfst4oCAf6Wh1DliFAHXuWaFbwzm3omnL6pxV6U9zglJfCMXmz?=
 =?us-ascii?Q?IpY9Ir9HUm5LDel/4XnlOrY6YP/fhXZihiPCg0Z4cBnwFlP1+RMeOJd+ox2V?=
 =?us-ascii?Q?GTJ/jASNEEaUHhM6olDm2Uq1zojBTxB/hhRkACtSD13AsMO2dHaGaAu/CKny?=
 =?us-ascii?Q?533cSil3IeqkvQS/a+q1kzUClZfK5q3k4HB2yVxeuvIddBlpK9AUqc2m0Aa3?=
 =?us-ascii?Q?7DdW045SXpjf4dcVxLjG?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5205a6f2-1117-4401-2674-08dd1ef4e90e
X-MS-Exchange-CrossTenant-AuthSource: AM6PR03MB5080.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2024 23:45:38.9453
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR03MB10502

Currently fs kfuncs are only available for LSM program type, but fs
kfuncs are generic and useful for scenarios other than LSM.

This patch makes fs kfuncs available for SYSCALL program type.

Signed-off-by: Juntong Deng <juntong.deng@outlook.com>
---
 fs/bpf_fs_kfuncs.c                            | 20 ++++---------------
 .../selftests/bpf/progs/verifier_vfs_reject.c | 10 ----------
 2 files changed, 4 insertions(+), 26 deletions(-)

diff --git a/fs/bpf_fs_kfuncs.c b/fs/bpf_fs_kfuncs.c
index 4a810046dcf3..6010fccc9db8 100644
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
@@ -181,23 +175,17 @@ BTF_ID_FLAGS(func, bpf_get_file_xattr, KF_SLEEPABLE | KF_TRUSTED_ARGS)
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


