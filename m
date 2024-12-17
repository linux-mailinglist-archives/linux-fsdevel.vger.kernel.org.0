Return-Path: <linux-fsdevel+bounces-37681-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4F759F5A9A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Dec 2024 00:43:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D11B1697CD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Dec 2024 23:43:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A4F81FA851;
	Tue, 17 Dec 2024 23:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="hX3hcR5R"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05olkn2041.outbound.protection.outlook.com [40.92.89.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D43431DDC1E;
	Tue, 17 Dec 2024 23:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.89.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734478991; cv=fail; b=rncxiFGHqWg25HwJOTH9GrprIZ0eRxEPU5LQhX8JloqxHzNpccsAlvWnCrq0Rl5aqWgqmpo7RcTQykx5JAo12JHGKBSV6QGGtvpMXriBOqGSmKk/u8uIts1L1WiwlKdzsfWhK/p9EKQFk1rTgP7JvEWMmvICb++9b1vT20w7hN8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734478991; c=relaxed/simple;
	bh=KIxnMIr3pjygOZQfnbAT4gl8laW2esmTBi9+dragCrw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=oNKKOiJWFuL6zDukwKje6VwnMiCDJfoieo39WIvzv3/VKgrj3q6qnzFjdDfj5c8GSEdg8ETkSneFrxNOOyBgJYG0MU4cqdeT7odZnaTH1qaYgsU66NSaEgn9S4uChUC9/DP/FFE0Om4MIU5YwdmeqkBCUQojWFgAoOi3Rk4ONw8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=hX3hcR5R; arc=fail smtp.client-ip=40.92.89.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xTFfgvOmY/40U8ELMJZyBqKy/wnBQWbWtZokm+b2vWKKz8kSCOeqq3c5E5Z/TW5ELwLWwkOi4T5TOCXQ0ZooMh58f/MDyCpOWpz6zEhuEDpaJ5cVnNbEJLkXiiPtPRmFTJP7+fMACU+A9AT7gFokCfahWB3aH/QSfNvJfUSU+LYHg1uc0dk8mVHXUyHwjVsxD7HDCFzZqRN1XTrFnH2+fk5ExTOFMdA/C8yh6rQyucqvnuo/tW/elZEYPT/yHxbutwFizw14se8wxcg0GddKt818n9icP2/XuPBH7CF82CV6OxxVnKLb05pYoDb3rF0dkr6UZpNX7S+y64QTrm+WZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QRVV0jX1KjzggGbvz87UhS2xPIc9n8VFZ0MWXdCk1fc=;
 b=T7eADwxNFBbE1eS6YJZlRhrkmwuvkS1bHvYUlu/7D67wwnfB3pREys6Sww2cV3iJd9yhlfKj80qhnjEONYuAlKNhkhgd4HzyvK7JhBw9r6fQ9g3TtHCKnNz3aBvg6dJaUedHNflRLI/yrMCwdJ7hxRIZOhSqPiON9ZuAPvkzR0VXFskMZOdZOl3Q6ks/InGb3FaW3FA5yZnKQsek0y+5zjbs/BBGtgDp1DLbQm4pZU577Rb6DWUk6eqIQzPTkqpsS12bqm4Pq0L3Q+a8vqq/lrdPF5g+gGh0lEnTgNkijNMDCh3ick5HZyHdoJkiNCiPDYvq44UGvAXHofTCULukZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QRVV0jX1KjzggGbvz87UhS2xPIc9n8VFZ0MWXdCk1fc=;
 b=hX3hcR5RxivWIWVijSeY2zSJSZ74i+Jope63OfB21sVhwFiFMGfLpA57s5oegfTd04pY+5tiNSyQqxWkOim6xCMkIiRVsudxSBsvcAN9wPg8qsakQJ15VXO6O2AEDyNgr50x6hcaWH1+Q5pKBYQs++S8E6nqXqQK45fri2bFj5Pwexh6BTN+/0MeSiEcANtavKyieEC/A+hcmOSJ3fAfvv3x66pl7KCuJYPfkRbeAwfGrIS/JAG59LJaHP8gRy0KCKKFHoj3u7UDaQB8J/IzPArIFhR7C+TTdOvSKWHp24IflO8StxTZ+cASA2Bl1ASJyN0gTUCJtAIqBK8wXmFgSg==
Received: from AM6PR03MB5080.eurprd03.prod.outlook.com (2603:10a6:20b:90::20)
 by VI0PR03MB10927.eurprd03.prod.outlook.com (2603:10a6:800:26b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.21; Tue, 17 Dec
 2024 23:43:06 +0000
Received: from AM6PR03MB5080.eurprd03.prod.outlook.com
 ([fe80::a16:9eb8:6868:f6d8]) by AM6PR03MB5080.eurprd03.prod.outlook.com
 ([fe80::a16:9eb8:6868:f6d8%5]) with mapi id 15.20.8272.005; Tue, 17 Dec 2024
 23:43:06 +0000
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
Subject: [PATCH bpf-next v6 3/5] bpf: Add bpf_fget_task() kfunc
Date: Tue, 17 Dec 2024 23:37:03 +0000
Message-ID:
 <AM6PR03MB5080B131375F41F92007DB4599042@AM6PR03MB5080.eurprd03.prod.outlook.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <AM6PR03MB5080DC63013560E26507079E99042@AM6PR03MB5080.eurprd03.prod.outlook.com>
References: <AM6PR03MB5080DC63013560E26507079E99042@AM6PR03MB5080.eurprd03.prod.outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0117.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:192::14) To AM6PR03MB5080.eurprd03.prod.outlook.com
 (2603:10a6:20b:90::20)
X-Microsoft-Original-Message-ID:
 <20241217233705.208089-3-juntong.deng@outlook.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR03MB5080:EE_|VI0PR03MB10927:EE_
X-MS-Office365-Filtering-Correlation-Id: d3b8d594-1884-44e9-2e42-08dd1ef48df7
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|19110799003|8060799006|5072599009|461199028|15080799006|440099028|3412199025;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?zyQCpcVOuxZJRd3qifRA5t3lT5IS9+MMX1Ay1lD5tccAnhJ7yy8CLeTcBPCL?=
 =?us-ascii?Q?QlPrZsG8vVaVupCGLvCtiBfe9NDcD46eE7mnMmBmjdUb1VOJp14MAecYM0QD?=
 =?us-ascii?Q?dxJbTjilRwHRM5xWPFLr3ZRaZEVY1hBCeGN3lWUuIk+GwN5SFzyZl2e4j10o?=
 =?us-ascii?Q?+Hq8/r7nb5iTfu0Fq65a5EOJKF93/056MR01KGd2RITKKjokp73y30fhmHt9?=
 =?us-ascii?Q?2EwysG98dyeJaxD+l9U7aquITC76gr++1NB5s9c63Ct6FW7x5mC9w33oLOjb?=
 =?us-ascii?Q?1Ld2hb8b32tbjqEVYkZ0aAoxvgWBnG0oB0BbQEn5p/f1NAfDAMVcf8wxzkdi?=
 =?us-ascii?Q?fSYlXksAJlUL0mmYQoAA0FXhVqSdqeZL1lx53YsY3Nl2s2vVvJ1e+CrGa65S?=
 =?us-ascii?Q?z1C0I+LNMy9atlcboLPAxv/0gl9sW6dpOIbIY0sX+77p1dvl3S68yR8wrlBm?=
 =?us-ascii?Q?ueRiv27ymgvgrfkf0YBzfOn25T604KWv4fOFZr7Qq+UdxUTMdgH2mawIRkmZ?=
 =?us-ascii?Q?y6I1p1cDQkZmS31eVJyniT5sVsah+T2DuDhvmgsmO2zanWvWtzSW2OpOOtGK?=
 =?us-ascii?Q?3tLqqgvou+txD67nOVk0gy4Q/uT6yuS+D/xejvwBA8DtxK+oxDl3Z0E+woLE?=
 =?us-ascii?Q?A/hh2deddFc3fzadu7KutzN6wHHDKmc8LFBxUMQwIVdi9qkRBE16gXLjVZP1?=
 =?us-ascii?Q?1gxlDALUpET9HP4R2gESwhyLQ9zfdktGVWJcR0hFZuVt0nCJT5diYScSbluj?=
 =?us-ascii?Q?d4xW18ERKk2Cxy7NCS2/Gc5opUo1xVQemj+iRyJCNs60C3uVNvGJe3ZHzSja?=
 =?us-ascii?Q?lnwLbrngnSe85WW1MfdFTRJZ0J3WgC67HSMtwk/aJbNDqmH0jIj8DAmI9xfo?=
 =?us-ascii?Q?JsYGfCGQKlHtULoJRan0TcgCcADTY3lyXoMS+qgmdl9WCxeV9Db39nhcEL9m?=
 =?us-ascii?Q?zYjUe07KLoMVYuKHdzWjMs8OUu5yw12GipFOMR8IUS5Q/bz1O7/SvPRr4Of2?=
 =?us-ascii?Q?j/s0?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?QOUUF96XkY7fMwuxpetJcmNHcslbgpCNIrSZRGsUW/aX9bLMm0CwkFrywhXS?=
 =?us-ascii?Q?oBaENgc1PZHbjund/sHmLvE+I04WFhPE4i1yr3tS3jB/giMaxaRmgltJ5wb6?=
 =?us-ascii?Q?8VN+4h+fsQWW55JKL0SLGI2WmhNdtpMUxyjtxJjULtKeUI39vpISU6IpGkNE?=
 =?us-ascii?Q?N0R/SRaXJ7Yx5P/7JhhCTyo2ogS42JQLGFCz/k5b1qF10Ym8sDOsOYiTVooj?=
 =?us-ascii?Q?qON7fhjFxWSDF1BRb15HB7SRFnOxoS+4j5ofP++Ly9eDusTrRoZih8Gk4VLx?=
 =?us-ascii?Q?QqI0p8eA3DEh7nZGkRsdrVgsTuQhnao6f/fiKTBOO0enDwsPGuTccKCMptqn?=
 =?us-ascii?Q?7PhY8FzIzuFy4camSSfdsC6UUqb9tPn4nLvs5727sgmAX+uO0MuNF1qLho0I?=
 =?us-ascii?Q?dGUr3lc6TMvlrXqrlyZbMF/2F17U/vWo32CAeIuwgkpBHHO2t1rfc+zczMKp?=
 =?us-ascii?Q?AcQWDM6mxglEdsB85ZxzlPzdpIs5Ja5G9x36N5eu8MVAJ6sNLaUAInLVVgsv?=
 =?us-ascii?Q?y/egxIWbYEUlLDe4nq82K5lVI+7tcFtwEU2bry3Xmup5sUnEuSdGBId2712p?=
 =?us-ascii?Q?btWbq9d3l9fUEmvjGmLtOkhV9JjwRy6fr2u99rCyuQqRkzENte+pk7fyBvKZ?=
 =?us-ascii?Q?kpmUbpmEOqcjBrOhem8OTXZekrHm1O09QKD90kr3yRBv3m++WTJpIyfYyGeQ?=
 =?us-ascii?Q?09Oq7XpUaD1SHQioSnJEZzT0WSKmBLd/65l9ysiQ0VOtXhIP23vNNo9vwDkg?=
 =?us-ascii?Q?BHv9fzyUdcVlUgKaiAarpDCyRlp1zwh+KqGYUXHZ/FB/vhaaU98DJFnGsPGB?=
 =?us-ascii?Q?U8ciJcKgcg8cKmoaYFutuev++m35RDcxxuAsKkyKKVIcL94OewOmXzxSRemp?=
 =?us-ascii?Q?UaoY0N0ezOJ4NYQf+CKmw9jz39BllVicjw3/NM/tthxdNQ5JoAE061SPXAcR?=
 =?us-ascii?Q?71W3VOQNft+jXwaU9Lca8/yTmVB3hNI5lMZBHY0rQ3SuRg0g9VrZtcmKIuz/?=
 =?us-ascii?Q?rbZmhK8YR39JqbL8vICEX49CZZv+JikydUDiMUCKpfzB9If07xdjlcom7Wox?=
 =?us-ascii?Q?ZlLLIApwkJIZFNcTEyJKTM8qpV8MV/OwGm4eF3Hft1iUp5aMGD8MitEDooN+?=
 =?us-ascii?Q?EjJwBsiXZJar2T36h5SySn445UlPXm7X0yc7VcBO6bDER09kO8P9zn+E7pdx?=
 =?us-ascii?Q?VQb1JASfh/ysiWMBxfCLvmMb8J60hovinZ7HilH6fnQb+y3xMZkGmILYyPga?=
 =?us-ascii?Q?beTchK8Fe8wTuwVeY2vB?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3b8d594-1884-44e9-2e42-08dd1ef48df7
X-MS-Exchange-CrossTenant-AuthSource: AM6PR03MB5080.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2024 23:43:06.5549
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR03MB10927

This patch adds bpf_fget_task() kfunc.

bpf_fget_task() is used to get a pointer to the struct file
corresponding to the task file descriptor. Note that this function
acquires a reference to struct file.

Signed-off-by: Juntong Deng <juntong.deng@outlook.com>
---
 fs/bpf_fs_kfuncs.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/fs/bpf_fs_kfuncs.c b/fs/bpf_fs_kfuncs.c
index 3fe9f59ef867..4a810046dcf3 100644
--- a/fs/bpf_fs_kfuncs.c
+++ b/fs/bpf_fs_kfuncs.c
@@ -152,6 +152,23 @@ __bpf_kfunc int bpf_get_file_xattr(struct file *file, const char *name__str,
 	return bpf_get_dentry_xattr(dentry, name__str, value_p);
 }
 
+/**
+ * bpf_fget_task() - Get a pointer to the struct file corresponding to
+ * the task file descriptor
+ *
+ * Note that this function acquires a reference to struct file.
+ *
+ * @task: the specified struct task_struct
+ * @fd: the file descriptor
+ *
+ * @returns the corresponding struct file pointer if found,
+ * otherwise returns NULL
+ */
+__bpf_kfunc struct file *bpf_fget_task(struct task_struct *task, unsigned int fd)
+{
+	return fget_task(task, fd);
+}
+
 __bpf_kfunc_end_defs();
 
 BTF_KFUNCS_START(bpf_fs_kfunc_set_ids)
@@ -161,6 +178,7 @@ BTF_ID_FLAGS(func, bpf_put_file, KF_RELEASE)
 BTF_ID_FLAGS(func, bpf_path_d_path, KF_TRUSTED_ARGS)
 BTF_ID_FLAGS(func, bpf_get_dentry_xattr, KF_SLEEPABLE | KF_TRUSTED_ARGS)
 BTF_ID_FLAGS(func, bpf_get_file_xattr, KF_SLEEPABLE | KF_TRUSTED_ARGS)
+BTF_ID_FLAGS(func, bpf_fget_task, KF_ACQUIRE | KF_TRUSTED_ARGS | KF_RET_NULL)
 BTF_KFUNCS_END(bpf_fs_kfunc_set_ids)
 
 static int bpf_fs_kfuncs_filter(const struct bpf_prog *prog, u32 kfunc_id)
-- 
2.39.5


