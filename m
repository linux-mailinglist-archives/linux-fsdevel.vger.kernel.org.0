Return-Path: <linux-fsdevel+bounces-35231-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 683249D2D88
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Nov 2024 19:06:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B408CB36D9F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Nov 2024 17:57:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47C831D2B02;
	Tue, 19 Nov 2024 17:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="T0Eh/QXb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazolkn19010011.outbound.protection.outlook.com [52.103.33.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 859281D1727;
	Tue, 19 Nov 2024 17:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.33.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732039008; cv=fail; b=LNOe5YiPZ6WSlftYSx/QsXd5/1+ki+5Omn+Qp5tVYCY1hYWhaCzosg6xdgxlvQMvKdJ47CEUDSYnijcceVp+jAl8C7vD5ZTvT5+7CWMQ1RqO7IvxF84QFR9oEEw6HQHCm3UH3iJM7WEsVSZtuOR5parxZqWqVsgkp0Pt2Kzh7x8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732039008; c=relaxed/simple;
	bh=jPqMnhqEVjrs/YtN0Nl5n4/7czmxm8I86RQdrPfoxmc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FHZ8QZ8mQnfvQIf/gZ960A9wTNw/8krytIVh1pY6jVgiJMzxBMP5RC3febP5a6hVbisPThRhOPgVITG5QkkqdUai9mN0/G9KSz0hqhctTIQUDNYGVi93RXDOB9JSKi49d7ZB+J+UDSJqEayyz+AWzhWsyJ8lOgc4W/fK09PGa3k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=T0Eh/QXb; arc=fail smtp.client-ip=52.103.33.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RGOUbtcljzQcOjjUy4JzoqULL6fDmwMinCr0OEnAa1VUPBkZdZoZLHWB6wMZ1fXXoKF+mc+sS7NQQJ2C2c5nTm+Z1tjz6DcVr1WXFK0KbvATXmqKyTL+IYM5ETLQ//XyBPbqnQ89C/x4AG1VklzEgg5Mg4ZIYL0vCgb4rdZtv/gYZYAxUFS+Ml7l6BxzGMmjMKEW+gKf8bEQQBn3AMW8gf0LH8yP+Fj2VOykDWi++y/yfifLHHQUl5AD1qr/fgdK+X07lEX9ZyIOe49XntV2pOdno9i/vMTDv88nyohbN9dtV4Gjn+Tdbqce1EpYI19JnVaHzbtlWQrViQWNCp5jMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yyjv667QTt66YdRMMFhmiG1OLZP10SLSGw6sVN5Hwfc=;
 b=hycAVN38ks7e3OY9F8eFZivQ1hVG3GGM+DT1+bGPrZv99vCULFTL/O2JtKPxdEMK78V6isU64fLIMo79p4/mn5T8/4aQzARKC8MlSNqLZGh8G86egr5LcPGufkXqDFpUJKbq0HcfoPb/QlmDkHbd2sJ7GVtvIx0jvh26LSu5l7AFYUPY1e7zyVHLtFuevfQAIScK5NBbcqsFkVpUrxppGUVLS4eHRq6/j2HXyshp/DMhaISCFkTfBL/GXp/6Rt3yFEi2I91zILPM49j0dEmHB0fUTJ8OcgRQALFwdjxwKi4kkuyi6Enxf4xor2kH87oyFuxxBCZB/dFTa00EU3IjnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yyjv667QTt66YdRMMFhmiG1OLZP10SLSGw6sVN5Hwfc=;
 b=T0Eh/QXbBJJO2En9Vh18upsNDDbwqXbRT51dLEiMNTbKPTCagUli3ITUgn/LuSbPmi3jHcNKfsX8bszRtssUy+UgJKg5d7YIiBe2x3m463AEjVG0RbQ3opJqcOve7KJ+BKfT044PJRtWEL2ofd8IIxXWWveuNgrSNxrurg+S2GuEuvBtAswDgqmNi7nIJeXGtsLkIZGD5/tUBnSFnjyc3TreKOjDXBAAnMY8I0FHxGOCHtt15s8BYlRoxy5BHXAJtC59QK8XnWlFgAH2/ZtyZfhR03v9f5ItfmvQ0FB0MSc9x5RmPh9F/ejH+6R0eL0X01sHsqXwfe81f9q7sC6DZA==
Received: from AM6PR03MB5080.eurprd03.prod.outlook.com (2603:10a6:20b:90::20)
 by DB8PR03MB6170.eurprd03.prod.outlook.com (2603:10a6:10:141::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.20; Tue, 19 Nov
 2024 17:56:43 +0000
Received: from AM6PR03MB5080.eurprd03.prod.outlook.com
 ([fe80::a16:9eb8:6868:f6d8]) by AM6PR03MB5080.eurprd03.prod.outlook.com
 ([fe80::a16:9eb8:6868:f6d8%4]) with mapi id 15.20.8158.023; Tue, 19 Nov 2024
 17:56:43 +0000
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
Subject: [PATCH bpf-next v4 4/5] bpf: Make fs kfuncs available for SYSCALL and TRACING program types
Date: Tue, 19 Nov 2024 17:54:01 +0000
Message-ID:
 <AM6PR03MB50806AE40A9BBCFD67DD8BF099202@AM6PR03MB5080.eurprd03.prod.outlook.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <AM6PR03MB50804C0DF9FB1E844B593FDB99202@AM6PR03MB5080.eurprd03.prod.outlook.com>
References: <AM6PR03MB50804C0DF9FB1E844B593FDB99202@AM6PR03MB5080.eurprd03.prod.outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0187.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a::31) To AM6PR03MB5080.eurprd03.prod.outlook.com
 (2603:10a6:20b:90::20)
X-Microsoft-Original-Message-ID:
 <20241119175402.51778-4-juntong.deng@outlook.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR03MB5080:EE_|DB8PR03MB6170:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b053433-899d-49c8-9685-08dd08c3872f
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|5072599009|461199028|19110799003|8060799006|15080799006|440099028|3412199025;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?U+7JQzZW97e8ZcgiuR/9+lyAP80cCLFlCweX3FahTbp3YaahxjW+exbx5AE0?=
 =?us-ascii?Q?FfsHI6Ea0R6d+bqHteO/+aHbEcZYKoct0/5Fbw/i7QDtirgraupLlIiooSYT?=
 =?us-ascii?Q?VbAIxBCmPVh1oivBwDjRBJiAwVpwEEWUfzrCVk+V5i0g88QHOWfrbtj6/XGM?=
 =?us-ascii?Q?FDJ8Sx1D83Ik9R7wcZp+soKsn5kvUvLtsoCTVH+ULgwjmXw/YR/OO5Tl2Gp+?=
 =?us-ascii?Q?XnuUAyugPtHrc+Qmb7oYekloV2NbaXmhLsFqsNgjeeyUm03gRD9EEszHmy2a?=
 =?us-ascii?Q?Bcj6sVgvIYyMVNBnv84fuMBT2GcF/Vg/JiNjSGJ7YsBpX5gxcWFS7E5f6I4v?=
 =?us-ascii?Q?NgTEPOJCY+9zNayPu0RdRIe2UGTNrvKkuZIEEj86eU/7tEI2KaSDqNwD2qPi?=
 =?us-ascii?Q?phR6ThJCxdYvODhEwBeAZr2kV0oHVYMYoDwDBrI2IiWotbiklKG5V1GzoltP?=
 =?us-ascii?Q?SV+fh8YSwwmKjxjQq+U/buSSENDa7e0BVq4lvw+QOr/NCm+CkIsvNMHVsKLv?=
 =?us-ascii?Q?mtFIUVm8M/XHeH1bgeudwaIaZV4SJ9ULDOrIvHPE5fi3KN/LLYvbRV9G+ABm?=
 =?us-ascii?Q?PdFyRb5AyizvlGioffS0H3uLdfvlkcys6jt1ggL0x1xsQuHS+G4Us8KewUwY?=
 =?us-ascii?Q?IdPiaXmp5bLL39KY3Ajty+7tC0NSbFnv6VyQuCGVZpqJ6ELPD125Rw3q2E1l?=
 =?us-ascii?Q?78GUSOPUH/53PiHtodDxxsBrriOudyyWIC3nVKBt6kq6p5EUMXyP61xNOCQN?=
 =?us-ascii?Q?6LfY+wq+RdGDJD/7JfTNxIy96mGUJq4UL/i+Y0+mxBFoxdudKF1o5rq5wZYZ?=
 =?us-ascii?Q?HJbkfidOtx1H3vKGyhYoS+ztIwy2Hctdch9eKcmnoHFse+xAXjMQZ9bWQr9R?=
 =?us-ascii?Q?v2vfPrHxnKkaE6aM98PnUkJ8vXKN4krrL56r11Eb4cPVnZis2rhLV/ytEeUB?=
 =?us-ascii?Q?xJBzEDPRgwmlWDKCP3l2izx7GwHKY8MY7wMf9QUkygth1nzF9bcyGD/UE+CT?=
 =?us-ascii?Q?QWfLCrwtJhcG4XP0m8URFeHVxQ=3D=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?I849Gk317RuMv6jI8MNOC5g7fNpfz15CkhQMFM2V2uVisFrX0cyM75PcuMYT?=
 =?us-ascii?Q?YP6YCQ45uLSkjhggJHJArNUNxtpYPRX7JLFdiLB02TlCJYJWCaaBj7QAz/Bb?=
 =?us-ascii?Q?nBRik8BQ2TsW/lSaHGVLcscPncJbtoBzxGB5QIPkpQDa15SEuew6ZiY22iPk?=
 =?us-ascii?Q?0ZpGF0KEI8kpQ/gC/+pTuxrkMDJuGENxYk+D/8AKNnmU/NBYq1fX9vktMlIR?=
 =?us-ascii?Q?XGPOb/7WwJG5Y+P+psWWX5R1LU0DOSsgBQWYujNZV52l/pXyRzdKAav5f7jW?=
 =?us-ascii?Q?VNwcUIH7rehOtGWLLrEchbnvpeNMr1ieKMveSiNF3SRz1I6/oAbSM/yjGbgW?=
 =?us-ascii?Q?81vGB65aSkjsSyOS6JL2tNnL3UKTc+j6oGw4PlxGo0qK/Rk6bf/ovuMarRz5?=
 =?us-ascii?Q?w2NRtlQ0JBKqCPxULcOmtO8dqzZF0fKwlFrvTeHiQa5s+qKHVmQVfftYdGnM?=
 =?us-ascii?Q?kuCzuaCg1V0dYgAys3I3PG3NPIIBEH4n9wzsKAep7FNZLC9ql6z6/PKWhOJP?=
 =?us-ascii?Q?Mku49ua5Xu3zdnr44WqwitzFEFG2Yosr2OYFVGfN0lA1t4Jsn31yn3YpbvJd?=
 =?us-ascii?Q?VWh6Qi7lTXIX6IbL99GqMCG6YZkKRPhUjUiPakx7zFVuYctrIE50fI4vRti8?=
 =?us-ascii?Q?jLI49GjIswgXq431sQ198/WuTDSRAKmbXUmx2uqUgtvQn9VkUnMcLmqb/nJ0?=
 =?us-ascii?Q?ExEFiXcsTux9l1o+n2z+REEJoOGAltZCMNZhU5fcXkQTP7txb6pNxrFh04KP?=
 =?us-ascii?Q?U1eqp4VSNIruFzhdpDOjuGHAp4vafb4d0BiTQmsiQ16CUJDKAmIYfAsETB1/?=
 =?us-ascii?Q?8tHtuBZpXYOTyrQeNYxxnbIsWwJumPU5zXJqmO9+5a9BIxr6XU0Lh2TtUSSy?=
 =?us-ascii?Q?jrlUEdF/G6Nw0Lh+lo5MA7JaD5txJed3OW+m92sk6lgy24etnVUn8RhaMQh9?=
 =?us-ascii?Q?QUmblztmolMuVG4Ady0BtraOdHNj0RGPEEIK19IgI99RYMchcKtt0/XxdQXe?=
 =?us-ascii?Q?7gxRwiFeI3F/14G43bQd8HXj7p2gO5qvpD9nLvGORo0MjODAB4Tae60Ey7el?=
 =?us-ascii?Q?zxU5GsPxsXWWPdF4o1A62yoek2K/L1MOwRIjlOy6QK9jSbcZb3ekJo2vGYKC?=
 =?us-ascii?Q?HUTkQsjjrMPjcYnWCFhM+MOuWJc0p6hCwr8zKC870anjyZvV74QbFsteo2Gi?=
 =?us-ascii?Q?K+fKKuyslVJnTFRWayOTKq+jUMFF53JZZWMDf6EgZTxx+NAZsbRyXls1XxTC?=
 =?us-ascii?Q?oeQ1w1Eg0+04qEYXA0WB?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b053433-899d-49c8-9685-08dd08c3872f
X-MS-Exchange-CrossTenant-AuthSource: AM6PR03MB5080.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2024 17:56:43.8384
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR03MB6170

Currently fs kfuncs are only available for LSM program type, but fs
kfuncs are generic and useful for scenarios other than LSM.

This patch makes fs kfuncs available for SYSCALL and TRACING
program types.

Signed-off-by: Juntong Deng <juntong.deng@outlook.com>
---
 fs/bpf_fs_kfuncs.c | 21 +++++----------------
 1 file changed, 5 insertions(+), 16 deletions(-)

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
-- 
2.39.5


