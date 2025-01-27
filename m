Return-Path: <linux-fsdevel+bounces-40177-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FBB2A201DE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Jan 2025 00:48:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A21DC1886301
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Jan 2025 23:48:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFEE51E008E;
	Mon, 27 Jan 2025 23:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="dHAHNWWE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazolkn19013076.outbound.protection.outlook.com [52.103.46.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 045D41DED76;
	Mon, 27 Jan 2025 23:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.46.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738021693; cv=fail; b=dpfkAK0FYZ5FUAHmvDNwF3GI3EKg6uyOAYxHHeF9IRvmXy9EkVxpUfomS3ajIdTpKuogvIsHogWRteiKD6xpVGiYNy960miO6+UP4WF0JmWjLqpbUUk6bDCQVRDgIOIHeVkYBV9M/zAdIytCRcWfN4pq3LBNw5qHzlLnhBYqLrw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738021693; c=relaxed/simple;
	bh=pugAuILa5hScos3sY9rnqD32OV7A5ZwmKpNU3EOmSf8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fCaJOTapyh+CaQHjI03/3QsovzsnLpjbcsaxHihpdeNPYS50ZRLFAlyyAfU1EfaWqLRbRWyn7JvcM+cR8HjjFsr60F5VTMn1oIP7ImTKW2LoM0rTRniAgsagC62F05Kyj1Gey3D3LilvZ9PBtnykPvV0CNnqBSA+kCz5qodAdB0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=dHAHNWWE; arc=fail smtp.client-ip=52.103.46.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kaUAq9iNfP3obWHCN/3c0s1NOqI4bwQDJsvf+2oO0CBmFll4jJFYXOhiRye5WpgNcYaodWhgU1KaH0LCM2w91QW8EI3WO5uN/ynz+OmVjwrtXz9Uu5v8kyWth1dw2keyalVWKfNqT+J23vWj8gg7SAzMKFjnOJENNHKL4QmA60NZIYWqUr2YctP8lE5U9M+DQm7GV8MOFnKT/sXtFSKpJD+M+9yAjEPDBlVbA3My2DMQ884r+MVeyctyYDujaryEARCuWPk2iIF6u3dOrYXP0BBWujhTiHxqKiA2zKCqN5bbTTW9heUBm2d/YUdk8yifTABMQjvnsrcLinW+XT9bzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gAleI/7pahHtOzi4/CGD6R44dIvtsL6dRYEC4VIDUCs=;
 b=cEQpGMV0mJBpS6MMtjEcFNDdddVVSwqkrQpImteKBjMnpfssvPzb4D0VD9+lXRSKK4/Ygxjh7z4hnCsJL3mGr59Q9fCElwlnp/8r6d8r7aB6AHEEeC1sLHqNkXnQ5Tfx52weA3ZUH7TpiaJzKRGtTLO22hAEcVl/9DtAW8S7sIhAi/scwBmaKD5v/eJyKir42SjgIFK7Xug6NjzMp5hCJ1LHKCYUaMYIPZSQWaqa/i3zYZnFCbK/vHsK7sIbeE2z5ZYJePopjKjQqG2ad5SBa68EyC6E5YiRdWHpOcjLtgJzywT3KmdMhJVqQQyYDH6RWGHMxqdhpkDw0dbkkVhGGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gAleI/7pahHtOzi4/CGD6R44dIvtsL6dRYEC4VIDUCs=;
 b=dHAHNWWEGPvjUfRBx8RBym/ABlnvgsTRHqsYF1UAJemXa1OyZC9JeMjbZfHsHZTa7R5MIyrqW1+3KXmj9ozAqxMPa6JQIFa5gzhfzlJdP6Ay9z0NSKa2/y2dVaSgg8PDJzBydZXiYVJnsYV5tyjNt6zQlU1RI3c7lEx+qWQPXAg6oiOe9xrCrsQqc/r5XqE5Yq6GlQgxEZcehMXlhdHt2L+gcHlsUE88n3xoxNHknloJo91zm79aIQ2NCZ3E2ATDj8r8YmSkyOWefqOdzqWYZ7TAXjiQkqzsTQ1yGQ5nmtA5kl6Ef/fCcOt15LBavfQa025/1m7DLUYMjBQJ6AJS7g==
Received: from AM6PR03MB5080.eurprd03.prod.outlook.com (2603:10a6:20b:90::20)
 by AM0PR03MB6209.eurprd03.prod.outlook.com (2603:10a6:20b:156::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.22; Mon, 27 Jan
 2025 23:48:07 +0000
Received: from AM6PR03MB5080.eurprd03.prod.outlook.com
 ([fe80::a16:9eb8:6868:f6d8]) by AM6PR03MB5080.eurprd03.prod.outlook.com
 ([fe80::a16:9eb8:6868:f6d8%3]) with mapi id 15.20.8377.021; Mon, 27 Jan 2025
 23:48:07 +0000
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
Subject: [PATCH bpf-next v9 1/5] bpf: Introduce task_file open-coded iterator kfuncs
Date: Mon, 27 Jan 2025 23:46:50 +0000
Message-ID:
 <AM6PR03MB50802EA81C89D22791CCF09099EC2@AM6PR03MB5080.eurprd03.prod.outlook.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <AM6PR03MB50801990BD93BFA2297A123599EC2@AM6PR03MB5080.eurprd03.prod.outlook.com>
References: <AM6PR03MB50801990BD93BFA2297A123599EC2@AM6PR03MB5080.eurprd03.prod.outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO3P265CA0018.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:bb::23) To AM6PR03MB5080.eurprd03.prod.outlook.com
 (2603:10a6:20b:90::20)
X-Microsoft-Original-Message-ID:
 <20250127234654.89332-1-juntong.deng@outlook.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR03MB5080:EE_|AM0PR03MB6209:EE_
X-MS-Office365-Filtering-Correlation-Id: 23750658-87c6-4e04-5c9f-08dd3f2d0ca6
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|8060799006|19110799003|5072599009|15080799006|461199028|440099028|3412199025|41001999003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?jhxSo9XNohlSb3Ao0cIJ4iugbC5hzL8kzmjSlSeox3Udn9Wt3GpHpsHdXfT/?=
 =?us-ascii?Q?A8x6fuUXjRKgXlhca2xR0p2qzAR5LHDfFA+k02bWRXhdIBYmTPjFGJgP1xCH?=
 =?us-ascii?Q?mC40TkQZbg/HQuTDR4yrnCQmDIC55iVersDZ6IJP8KSsw4zma2/u0EohFGRU?=
 =?us-ascii?Q?MxY8uzfugx6rApA7esm6c0CLxVvhW6rD25+0qwNlJjPm0zOOFPtO/QumXgkM?=
 =?us-ascii?Q?ZdJgLhc23dQ0xtakgm+5D9UiYj6oaZJPDe0oFizD95Nse3pB2dm0IjvhKBzI?=
 =?us-ascii?Q?WjpVVMxToL/ZFHEbo8Hpzm1wjb+nfWNYtexTi8mmjFCs9yYBcKoz5W9OdUBz?=
 =?us-ascii?Q?riiGF2InyTUw9Ne/D20IoIXGY9gqYaO+gj71QE/TzZ32nnTbs0CEf0/al/AI?=
 =?us-ascii?Q?FxRPnFj41d4K8poLgbXBfT0Y3pjDofte7X6e+KZTrV0DTnFNDPxTmZKuJxk/?=
 =?us-ascii?Q?NTyDzRwDZim832lMLofNP5waZBKtWHvqWv8K5CiuIXG03clcZ2nIbKZ7XOUm?=
 =?us-ascii?Q?J7QuGhScAgEH35Moxe9H3Q+0e9+FSYX34xv0Sb/j10hWrgY7g4skXVO73Gxu?=
 =?us-ascii?Q?BVRVvjUKu0DzwsryBsc24ALxVO5cK0DTHzhpFNFjXOQnI3JxNTdxhqggUWzx?=
 =?us-ascii?Q?/dCosa4r8RFKDQItQ4y/llAvJux1yCNc9OBmz3AhgU86LlB/F6jTMBTbyDSA?=
 =?us-ascii?Q?ETwTOToXDPljAczb01un/j1WsxUsQJQ6xYSVVYKQuzvQVyfsU4VYzU+eeBus?=
 =?us-ascii?Q?SgMHxIPPN4rFKoRG+3hxNFjQ7qap8+30AgpgSFC8C6Wkp5bYv6+uS5CFlphH?=
 =?us-ascii?Q?LyZQHYlacSB/tQ7U944gja7wUR1ekEbI3BtMDdXrFwHosAbuX08SU5rK/Z98?=
 =?us-ascii?Q?y01khEETy5JvFtGhcuATsbxgVRt+MFzkSJPLH9ZxpWh7JUBjybqVxsSJVBOI?=
 =?us-ascii?Q?Xi0kNGj0Vp4zOf2ZeuLem92sL6j/BiDHeTYUPk4om9bE2mjWFwXN59Cxiv80?=
 =?us-ascii?Q?DiVGmK14u/NCUEIqHEChyJn+oyGZeXhKgjm6wZ5VaLOrHFUR6wrUaWtxXGIm?=
 =?us-ascii?Q?hhX+Q8qYPRdjqyYfEH2OQtaFQapZ0Q=3D=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Y28tRB0z1m7J6nZLqRS1yn3K7zfV8VAWPPI4cuUQAyFyKFTEveJSXr1LSsMQ?=
 =?us-ascii?Q?A2y+d9B3EicsJGgiDElYwIW739x3vR0ztmDlh/rBnS2HgWU6oW0Y3MOD9nas?=
 =?us-ascii?Q?WeBT/51d8oqT6f7QtYKBVfnqJTdQyY4KWNqIm7G8K3ecPWL9CA/OweDc4Js8?=
 =?us-ascii?Q?qX3WcXPuBeTqODnbMPizr0ghP5p5fsJQN3X+oHTWx3HwsKXavSHnrS+CCW3M?=
 =?us-ascii?Q?5jFFi1kyfGnVhJAB+w5R8dOk+s0sAVvZQBCbnNyMRjZ8sb5kIQZ91cuYoNh1?=
 =?us-ascii?Q?AsUDrjIYd+0NHrtSVTysbQSoqIwb0szoYRmlfE/9ZGI2BHR17BX3Tkh71cDx?=
 =?us-ascii?Q?Ynrx1JSpUNLpZsNWXxUdmj/CQTlAIQF20Odn2hnAQPa1k1j0CbgKLFhgf9Eo?=
 =?us-ascii?Q?0eb2gnsTR1d0JAMpkjQOrnTo4acau2oYUTD5GMRHgms31i6Btn3TimyqNTAQ?=
 =?us-ascii?Q?XAS7gXv/7OuYXcMCq9l/ORwmmbbQpPrBCykjWH+rSIHvyvPQwwTyNcwL+MRT?=
 =?us-ascii?Q?zdeSy7i6FuY6Fqx+1yShqCh4croUxuj3atr4ZbDXPeCKPr1ZDNONqIAQvRG2?=
 =?us-ascii?Q?cCjGzdLF3xmDk1Q+iUFxfjqtai79U2qI8MvHxswjXSncUri8M8f3TiMNuqka?=
 =?us-ascii?Q?GKfgvN/D8tZs6juDXnht4gu9FXy3hiOF/wDixBadXu9SAWChTymDAzPB0xhE?=
 =?us-ascii?Q?RuchHdLeVxNDWzYqOTWPhTEyOeLp/tfNxQnp2ItlSLZxPI+8ujWfIj1U9D4Q?=
 =?us-ascii?Q?m2hOSmP1Ke+zQi7d0BZlPSkeLoLnOldTofoA5gZFqCvUxAWqxGsM4GGzxed1?=
 =?us-ascii?Q?StCvJtoGG89YbVus7H2YqQk1I6oP7wamEsKsnOSpzghvDH5aME02YveY2/aX?=
 =?us-ascii?Q?IKQ3aYW857fL2qrYLJTwoSY6Mfz7v2JBT5+/Ko6tIEVbVo7a9gxzGFZhlKCD?=
 =?us-ascii?Q?EjGtxtUemNbJGMZBZHooK16qGPCHuamYTsuFh12DmvjeqAxJi/fxny29mUQL?=
 =?us-ascii?Q?Q0o3CSDCAuV2fehXM0X5E3R8Q9xDk+sajkHFLWDx+UG9I+X0BKLPDQ1jdqia?=
 =?us-ascii?Q?aAbf8DcbjsC+u6G0MiFnJg2ZmeBMGBdqh2Guq1xadVnntMLHpnV0a8a4U4++?=
 =?us-ascii?Q?szl/goC7qTs2gGWXntP5Pngl5Gn/0d3S2Ikx2sGWpzMhPxhEVPTMJhdkQzNw?=
 =?us-ascii?Q?hqxFFidzc7yPU8l2OPz8uFJQPShSPYYTYTgTKdo6UwTYXXUkkyfoSvIjKtt+?=
 =?us-ascii?Q?M268rOR7cuBzeZsSotn0?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23750658-87c6-4e04-5c9f-08dd3f2d0ca6
X-MS-Exchange-CrossTenant-AuthSource: AM6PR03MB5080.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2025 23:48:07.6929
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR03MB6209

This patch adds the open-coded iterator style process file iterator
kfuncs bpf_iter_task_file_{new,next,destroy} that iterates over all
files opened by the specified process.

bpf_iter_task_file_next returns a pointer to bpf_iter_task_file_item,
which currently contains *task, *file, fd. This is an extensible
structure that enables compatibility with different versions
through CO-RE.

The reference to struct file acquired by the previous
bpf_iter_task_file_next() is released in the next
bpf_iter_task_file_next(), and the last reference is released in the
last bpf_iter_task_file_next() that returns NULL.

In the bpf_iter_task_file_destroy(), if the iterator does not iterate to
the end, then the last struct file reference is released at this time.

Signed-off-by: Juntong Deng <juntong.deng@outlook.com>
---
 kernel/bpf/helpers.c   |  3 ++
 kernel/bpf/task_iter.c | 90 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 93 insertions(+)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index f27ce162427a..359c5bbf4814 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -3157,6 +3157,9 @@ BTF_ID_FLAGS(func, bpf_iter_css_destroy, KF_ITER_DESTROY)
 BTF_ID_FLAGS(func, bpf_iter_task_new, KF_ITER_NEW | KF_TRUSTED_ARGS | KF_RCU_PROTECTED)
 BTF_ID_FLAGS(func, bpf_iter_task_next, KF_ITER_NEXT | KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_iter_task_destroy, KF_ITER_DESTROY)
+BTF_ID_FLAGS(func, bpf_iter_task_file_new, KF_ITER_NEW | KF_TRUSTED_ARGS)
+BTF_ID_FLAGS(func, bpf_iter_task_file_next, KF_ITER_NEXT | KF_RET_NULL)
+BTF_ID_FLAGS(func, bpf_iter_task_file_destroy, KF_ITER_DESTROY)
 BTF_ID_FLAGS(func, bpf_dynptr_adjust)
 BTF_ID_FLAGS(func, bpf_dynptr_is_null)
 BTF_ID_FLAGS(func, bpf_dynptr_is_rdonly)
diff --git a/kernel/bpf/task_iter.c b/kernel/bpf/task_iter.c
index 98d9b4c0daff..24a5af67e6c8 100644
--- a/kernel/bpf/task_iter.c
+++ b/kernel/bpf/task_iter.c
@@ -1027,6 +1027,96 @@ __bpf_kfunc void bpf_iter_task_destroy(struct bpf_iter_task *it)
 {
 }
 
+struct bpf_iter_task_file_item {
+	struct task_struct *task;
+	struct file *file;
+	unsigned int fd;
+};
+
+struct bpf_iter_task_file {
+	__u64 __opaque[4];
+} __aligned(8);
+
+struct bpf_iter_task_file_kern {
+	struct bpf_iter_task_file_item item;
+	unsigned int next_fd;
+} __aligned(8);
+
+/**
+ * bpf_iter_task_file_new() - Initialize a new task file iterator for a task,
+ * used to iterate over all files opened by a specified task
+ *
+ * @it: the new bpf_iter_task_file to be created
+ * @task: a pointer pointing to the task to be iterated over
+ */
+__bpf_kfunc int bpf_iter_task_file_new(struct bpf_iter_task_file *it, struct task_struct *task)
+{
+	struct bpf_iter_task_file_kern *kit = (void *)it;
+	struct bpf_iter_task_file_item *item = &kit->item;
+
+	BUILD_BUG_ON(sizeof(struct bpf_iter_task_file_kern) > sizeof(struct bpf_iter_task_file));
+	BUILD_BUG_ON(__alignof__(struct bpf_iter_task_file_kern) !=
+		     __alignof__(struct bpf_iter_task_file));
+
+	item->task = get_task_struct(task);
+	item->file = NULL;
+	item->fd = 0;
+	kit->next_fd = 0;
+
+	return 0;
+}
+
+/**
+ * bpf_iter_task_file_next() - Get the next file in bpf_iter_task_file
+ *
+ * bpf_iter_task_file_next acquires a reference to the struct file.
+ *
+ * The reference to struct file acquired by the previous
+ * bpf_iter_task_file_next() is released in the next bpf_iter_task_file_next(),
+ * and the last reference is released in the last bpf_iter_task_file_next()
+ * that returns NULL.
+ *
+ * @it: the bpf_iter_task_file to be checked
+ *
+ * @returns a pointer to bpf_iter_task_file_item
+ */
+__bpf_kfunc struct bpf_iter_task_file_item *bpf_iter_task_file_next(struct bpf_iter_task_file *it)
+{
+	struct bpf_iter_task_file_kern *kit = (void *)it;
+	struct bpf_iter_task_file_item *item = &kit->item;
+
+	if (item->file)
+		fput(item->file);
+
+	item->file = fget_task_next(item->task, &kit->next_fd);
+	if (!item->file)
+		return NULL;
+
+	item->fd = kit->next_fd;
+	kit->next_fd++;
+
+	return item;
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
+	struct bpf_iter_task_file_item *item = &kit->item;
+
+	if (item->file)
+		fput(item->file);
+
+	put_task_struct(item->task);
+}
+
 __bpf_kfunc_end_defs();
 
 DEFINE_PER_CPU(struct mmap_unlock_irq_work, mmap_unlock_work);
-- 
2.39.5


