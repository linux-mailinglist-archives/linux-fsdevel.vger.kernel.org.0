Return-Path: <linux-fsdevel+bounces-33818-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 622FE9BF76C
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Nov 2024 20:47:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 214CF28159B
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Nov 2024 19:47:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8DE220E038;
	Wed,  6 Nov 2024 19:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="EzGwyc0N"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05olkn2107.outbound.protection.outlook.com [40.92.89.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C2DD209F5F;
	Wed,  6 Nov 2024 19:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.89.107
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730921974; cv=fail; b=ZVaKs7w+RHQ0AVhVWiy6qoSjmUPqRtpoz/ZAnvV/t47Ej/8QIa9G2pJ+AaT8ID46rMEXfTYscz3jr32Ex4d65OeInI5CTI7veM01b65kEgAQYhTvYgVps6mlDl3aFBnyRqLcGM5kQO+WabpbRhGERma4O2q551EMEK+4GrOCl84=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730921974; c=relaxed/simple;
	bh=imCKjTt+FjZs71vA+1DWP4iRwmafPtQ7z6q2v3riIQE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HlBEds+6pQ3pPgvx3RSwbKaZpThEiyU79Jj2HMM9gYp4mOS23AzHh7nI2p+wyowej+A/oL8AIF1l9rvMr0iyjb8+nspyPki3AosdYkx9Bcm/JhycJ7sRapkvcFmhleqB6IYGJv9gQuA5PNjsXrfJoZB4Y0hSxOgOyz65LBCmC/0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=EzGwyc0N; arc=fail smtp.client-ip=40.92.89.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Jk+38LfN0uHu6852d6eFrETgibUgKRii2N+ZqYrsNKY1DqVwiVyxqk2GKFTsCZE9lvV+PWrV+keWQ3eBY9LxCB5VeoytoKZatL5x3uOXCZKb4HT2Lqv3XRB27BFg5DFJjMyoZW+NR3X0ROoNZMJBmz/QiwpE/lkLiD2Waub9nc+TEer15ah0cTtQi1PRyzuED9po3oAat9MzyrFM9a/qRNlt51Moi29c3GrEF/0uOjV3/3Ip2c5FOfW4CIvKAtSG6NJw17IjTOqTMxLOO3zat9NMM1Ac5UK8S4vxIGLLeSnZ6ym3qSBhj3reCTCVCZ92UoXe2lRy2AdGPFNPYGw8Qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P96QpylSM/F4xNLnWHy7URkJkQ9HGs/KE5ZWx90fjjQ=;
 b=nFs7f7SNRKt4kFwyk6h7o6hfr/6l+o5GabOQQrhpoe2ZiX8vNbote4y6dGMG/JROi3T+btUsomojeQZdV/iBEPq9gc1WQNfnoTrpZ+2nMm+JZ7aXujrFivFyOrQ+PRoq9z1KfduDXw4+SFKdUeO6ExTIyt0vQaNijFmDBoYTj0HYPjMPF64o+el5fybQ1XINy1GYp1fkkWxO9YPmCPUJ//GH4JUpXZmpuRooB1hKEZdA5Q9XUDJhPuTY4RI7BoVJrvph8mSkHz7pwtqm/e47ANMZTTMCDXtYSVwantwEZpE7hi8Ykgn42luiPM1s1w+9yygGlBgfzPCLTY9K3gQNfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P96QpylSM/F4xNLnWHy7URkJkQ9HGs/KE5ZWx90fjjQ=;
 b=EzGwyc0NYPIq7MvfhOHwN8Ht8/jrNyRl+u4K8Qy6AabSHTVxXTAand9efKg5oSqCXsG3cQ+tq7mNKxYfOr0CyNh6RY9SdD+z8ql/4GaOrrHLl11GBVI/zO9ApUSFaIkurZp53x+AIUiIUzy0jwqQiHn+qapK4U61wQX28y4u/OwWZb3eFHUFdB87PVng5wucPC0dShOutVkJG/IlEuu0iArKDplGfpZJSnkSR8T8eeqZD3KKoOmRNiNz6U+4lYNGPWSGAaHm+ZZ3pd9F08GvEz4MN0ejXT8qgRl2am5iUy+DN77C5ZEzRlUlQFAzebU/YaHu3wBL2MZW5OUmeHaXDw==
Received: from AM6PR03MB5848.eurprd03.prod.outlook.com (2603:10a6:20b:e4::10)
 by AS2PR03MB9792.eurprd03.prod.outlook.com (2603:10a6:20b:608::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.18; Wed, 6 Nov
 2024 19:39:28 +0000
Received: from AM6PR03MB5848.eurprd03.prod.outlook.com
 ([fe80::4b97:bbdb:e0ac:6f7]) by AM6PR03MB5848.eurprd03.prod.outlook.com
 ([fe80::4b97:bbdb:e0ac:6f7%4]) with mapi id 15.20.8093.027; Wed, 6 Nov 2024
 19:39:28 +0000
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
Subject: [PATCH bpf-next v3 1/4] bpf/crib: Introduce task_file open-coded iterator kfuncs
Date: Wed,  6 Nov 2024 19:38:45 +0000
Message-ID:
 <AM6PR03MB5848C66D53C0204C4EE2655F99532@AM6PR03MB5848.eurprd03.prod.outlook.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <AM6PR03MB58488FD29EB0D0B89D52AABB99532@AM6PR03MB5848.eurprd03.prod.outlook.com>
References: <AM6PR03MB58488FD29EB0D0B89D52AABB99532@AM6PR03MB5848.eurprd03.prod.outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P265CA0280.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:37a::17) To AM6PR03MB5848.eurprd03.prod.outlook.com
 (2603:10a6:20b:e4::10)
X-Microsoft-Original-Message-ID:
 <20241106193848.160447-1-juntong.deng@outlook.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR03MB5848:EE_|AS2PR03MB9792:EE_
X-MS-Office365-Filtering-Correlation-Id: cb6fa12a-530c-48c8-2e90-08dcfe9aba1a
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199028|15080799006|19110799003|5072599009|8060799006|3412199025|440099028;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?es8Kqm/eKjHZ6UQAoQoE9FZcNxAbXaRL6V+U2sZ1FEVRnhWhxiL7Bx0sS3xo?=
 =?us-ascii?Q?auVL3ZNAo/dgwgCTFi9xdR56iStz9DRjaMAYQiJKxfIy2nHYLBbkJi2YimSm?=
 =?us-ascii?Q?X/N/90WemFQu9Wp+2Ouqdu0LNJ2ZIZthQKP/zGRwPfcYOuuFZx4BYgZpTPD9?=
 =?us-ascii?Q?mh6jhWXATE/MBjm0J2h6YUTKvru7mcZ2jr4EfhZJOs8P5LgDAwzKtVOl/vr+?=
 =?us-ascii?Q?7q5X0UUES6rk4ogarw3wEkRa61YbbTbyXpUQTrboWCFIDr2mfEj5p4NuVmzf?=
 =?us-ascii?Q?PMTw2pVEvcTPI+N3EjB0A6Zt1UP91jZfyGkROZem68+lZ13qW3hByIKLDG4W?=
 =?us-ascii?Q?qzDt6W0dCiFB4qxZJWbLTCKxhU0/omxF6MI5gQwOLgjFsr3eoSGd+4NNAxk5?=
 =?us-ascii?Q?X2vlduhvutMAhp5fe7nHla0QkQEuZRyeY1RITQSLMLFsmN2D8Ym+YeJOpTFI?=
 =?us-ascii?Q?KocHdDkVvwMTuMBn5C36+uaDQf+K5y74um5cy3cFTtvQvfObzRoYcDpoZ8nH?=
 =?us-ascii?Q?DYyJN1Q404CBTqiCFWsBwU25Vq+Hn0COQzJVkpS0QNCXLOxFd7EmZAWIuR8w?=
 =?us-ascii?Q?t5W04YfIWk7Aj/IK14cBGoVLSSo3RuRXJOgV2KMfJvCQptdO2lK93STyIMwJ?=
 =?us-ascii?Q?FsfA3vvZX12KuWclgQhtYaG7oxJP19A7NUChbYEtH/CxJWvIYAOuNonHpDlt?=
 =?us-ascii?Q?FtAbleSp1dujIKBdMMIbwVXNYg94QHvI0uNC0jqgdBlORs3XUKtdFApj2Gt1?=
 =?us-ascii?Q?Zpa+o6LSLtLQfJxkMTVbHe1HxBc4QduowTxHHdbR0iiSCV1vhW7GsKKA/wSz?=
 =?us-ascii?Q?SY8SuO+/yHT3yWND68pU8ViVkxqoY0WOqRfdMLD/8BuDkwPJNCjItgBbzsm4?=
 =?us-ascii?Q?dyzGNiE4WMEb2uSkJDU5QkdXFXPZh7MTagBt2+X/X7ACK6zU5gb/fL4w+a15?=
 =?us-ascii?Q?xmEHST9yc7FctR0Z+eMZzWsqagfotB3EQ4N1VkC8XiunIsN/F5WlKYPlHVvc?=
 =?us-ascii?Q?gJ9de1MblvJghao6U/5A2BFLRQ=3D=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rN4arw0R29lGXi0Pg1H1lFwWR6Fk30UfuxkuujPyrNewfDGsVXAI7Zt8+2z+?=
 =?us-ascii?Q?Z/QRgtvLE2zR9Z4bXDuhKLcKbiSKsUs40JKKLHT3EI9EKGr7P7u9+836cJ1p?=
 =?us-ascii?Q?7/35/8Ls5/VykVABdN8uqA2w+hJiU1VF/Md1vUScveXz6rTipoQTKdWRIGZz?=
 =?us-ascii?Q?3MriYHkBAeGfGJmxc++OcSmYQFGww9xBNohjbDqPpadxPA2houonZ3rzg0mM?=
 =?us-ascii?Q?5PzZu+5rwrIfHY5G8vXLejzfE9TdsuRm8yGs+FYAaDWuxTYyTKY7stDHzKKZ?=
 =?us-ascii?Q?DslqYt8FVO3sRMxXFymA042Lr0sHbr3TJKz6N01U11+qV1R858c6vsp1knba?=
 =?us-ascii?Q?0MgSHZvkPXm81+m7ZcVFUZ7rwlTVqgAP1eFCwHaHMTNpGC/MVHxicu3BMkOU?=
 =?us-ascii?Q?Q4SJGdK+GTVOiGKTYAvTZo6IsfXFUC2pInNCVK7uvI9J8pcHKdjrdMqJ1Nw+?=
 =?us-ascii?Q?7OilO1inBjldKi2zc6DhLQMxamhRAezUWoUhtP6FjpAnZuzmq4zGzWol9CQ5?=
 =?us-ascii?Q?Yo30d6AK27RPo5CuVPjkKgh3Mrx/I2rqoiEHaOvsAlmFzMl354i2KmobUdfO?=
 =?us-ascii?Q?eVAq8a3tNnyidu/dRKOoCgrjmJVsrKH055sQaAfRxu3HzE/irzrbCq25VUsE?=
 =?us-ascii?Q?lIK1phWq7TUzCbGQx36YLd6WhhgxbcTiqYFKxXbmd10shJR7GyGF+GT/JK1S?=
 =?us-ascii?Q?im8eW8FN5C+LBVcnf/mupnvrKjaZ0vzfnWwksvoduC1MCFnKewEZ/83Q+Ytr?=
 =?us-ascii?Q?Aejyd5t2VbPQlrF4aQUTLzsyx4wiJzWQAWQNWahCaW6Wr3Pcy0mQesA5rwhC?=
 =?us-ascii?Q?OriwB3ezN+DUZLBcwbnS02bUkNELAQBhiWErp0aofqIsTJh8d8eo6GF/hI8O?=
 =?us-ascii?Q?XpiVZk/5WAQ0NY/FtsETQ6rflKJW4T7sA24z/jU8ljPY64NhoxZtte1d2mm2?=
 =?us-ascii?Q?P8O7eTzJHfME0nsQP36DsPa0f3vm3bW4sZapebPdszwdfhL8c7lDI3bSmFFQ?=
 =?us-ascii?Q?HCwFf/toNZ5J+WijwBr7f56Wcx/KZh1N4lF3Y+PEpbd4MgBPoX8pO0QiFIyr?=
 =?us-ascii?Q?GvxfL6oBHQ9xcHckBRi4+wbkwbxVHEzuDb7Yre34MQL4UblWvKvrgV6ZNl8i?=
 =?us-ascii?Q?IinCZgDhbUW8EDSt7WkToRx7uJ5i1nUGcuDLUOOcQEynDf1eC6cimYkunGi5?=
 =?us-ascii?Q?WuhPtS9wqL4ui42lbixM3nuRnFHrBg4YbbfnyWW/8eDWPD3g5AcCvh+ad1J5?=
 =?us-ascii?Q?ps+CF42NNs9vK9WqYs9o?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb6fa12a-530c-48c8-2e90-08dcfe9aba1a
X-MS-Exchange-CrossTenant-AuthSource: AM6PR03MB5848.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2024 19:39:28.2714
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR03MB9792

This patch adds the open-coded iterator style process file iterator
kfuncs bpf_iter_task_file_{new,next,destroy} that iterates over all
files opened by the specified process.

In addition, this patch adds bpf_iter_task_file_get_fd() getter to get
the file descriptor corresponding to the file in the current iteration.

The reference to struct file acquired by the previous
bpf_iter_task_file_next() is released in the next
bpf_iter_task_file_next(), and the last reference is released in the
last bpf_iter_task_file_next() that returns NULL.

In the bpf_iter_task_file_destroy(), if the iterator does not iterate to
the end, then the last struct file reference is released at this time.

Signed-off-by: Juntong Deng <juntong.deng@outlook.com>
---
 kernel/bpf/helpers.c   |  4 ++
 kernel/bpf/task_iter.c | 96 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 100 insertions(+)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 395221e53832..1f0f7ca1c47a 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -3096,6 +3096,10 @@ BTF_ID_FLAGS(func, bpf_iter_css_destroy, KF_ITER_DESTROY)
 BTF_ID_FLAGS(func, bpf_iter_task_new, KF_ITER_NEW | KF_TRUSTED_ARGS | KF_RCU_PROTECTED)
 BTF_ID_FLAGS(func, bpf_iter_task_next, KF_ITER_NEXT | KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_iter_task_destroy, KF_ITER_DESTROY)
+BTF_ID_FLAGS(func, bpf_iter_task_file_new, KF_ITER_NEW | KF_TRUSTED_ARGS)
+BTF_ID_FLAGS(func, bpf_iter_task_file_next, KF_ITER_NEXT | KF_RET_NULL)
+BTF_ID_FLAGS(func, bpf_iter_task_file_get_fd)
+BTF_ID_FLAGS(func, bpf_iter_task_file_destroy, KF_ITER_DESTROY)
 BTF_ID_FLAGS(func, bpf_dynptr_adjust)
 BTF_ID_FLAGS(func, bpf_dynptr_is_null)
 BTF_ID_FLAGS(func, bpf_dynptr_is_rdonly)
diff --git a/kernel/bpf/task_iter.c b/kernel/bpf/task_iter.c
index 5af9e130e500..32e15403a5a6 100644
--- a/kernel/bpf/task_iter.c
+++ b/kernel/bpf/task_iter.c
@@ -1031,6 +1031,102 @@ __bpf_kfunc void bpf_iter_task_destroy(struct bpf_iter_task *it)
 {
 }
 
+struct bpf_iter_task_file {
+	__u64 __opaque[3];
+} __aligned(8);
+
+struct bpf_iter_task_file_kern {
+	struct task_struct *task;
+	struct file *file;
+	int fd;
+} __aligned(8);
+
+/**
+ * bpf_iter_task_file_new() - Initialize a new task file iterator for a task,
+ * used to iterate over all files opened by a specified task
+ *
+ * @it: the new bpf_iter_task_file to be created
+ * @task: a pointer pointing to a task to be iterated over
+ */
+__bpf_kfunc int bpf_iter_task_file_new(struct bpf_iter_task_file *it,
+		struct task_struct *task)
+{
+	struct bpf_iter_task_file_kern *kit = (void *)it;
+
+	BUILD_BUG_ON(sizeof(struct bpf_iter_task_file_kern) > sizeof(struct bpf_iter_task_file));
+	BUILD_BUG_ON(__alignof__(struct bpf_iter_task_file_kern) !=
+		     __alignof__(struct bpf_iter_task_file));
+
+	kit->task = task;
+	kit->fd = -1;
+	kit->file = NULL;
+
+	return 0;
+}
+
+/**
+ * bpf_iter_task_file_next() - Get the next file in bpf_iter_task_file
+ *
+ * bpf_iter_task_file_next acquires a reference to the returned struct file.
+ *
+ * The reference to struct file acquired by the previous
+ * bpf_iter_task_file_next() is released in the next bpf_iter_task_file_next(),
+ * and the last reference is released in the last bpf_iter_task_file_next()
+ * that returns NULL.
+ *
+ * @it: the bpf_iter_task_file to be checked
+ *
+ * @returns a pointer to the struct file of the next file if further files
+ * are available, otherwise returns NULL
+ */
+__bpf_kfunc struct file *bpf_iter_task_file_next(struct bpf_iter_task_file *it)
+{
+	struct bpf_iter_task_file_kern *kit = (void *)it;
+
+	if (kit->file)
+		fput(kit->file);
+
+	kit->fd++;
+
+	rcu_read_lock();
+	kit->file = task_lookup_next_fdget_rcu(kit->task, &kit->fd);
+	rcu_read_unlock();
+
+	return kit->file;
+}
+
+/**
+ * bpf_iter_task_file_get_fd() - Get the file descriptor corresponding to
+ * the file in the current iteration
+ *
+ * @it: the bpf_iter_task_file to be checked
+ *
+ * @returns the file descriptor. If -1 is returned, it means the iteration
+ * has not started yet.
+ */
+__bpf_kfunc int bpf_iter_task_file_get_fd(struct bpf_iter_task_file *it__iter)
+{
+	struct bpf_iter_task_file_kern *kit = (void *)it__iter;
+
+	return kit->fd;
+}
+
+/**
+ * bpf_iter_task_file_destroy() - Destroy a bpf_iter_task_file
+ *
+ * If the iterator does not iterate to the end, then the last
+ * struct file reference is released at this time.
+ *
+ * @it: the bpf_iter_task_file to be destroyed
+ */
+__bpf_kfunc void bpf_iter_task_file_destroy(struct bpf_iter_task_file *it)
+{
+	struct bpf_iter_task_file_kern *kit = (void *)it;
+
+	if (kit->file)
+		fput(kit->file);
+}
+
 __bpf_kfunc_end_defs();
 
 DEFINE_PER_CPU(struct mmap_unlock_irq_work, mmap_unlock_work);
-- 
2.39.5


