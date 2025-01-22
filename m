Return-Path: <linux-fsdevel+bounces-39877-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7EDCA19B51
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Jan 2025 00:06:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 74C5A3AD672
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Jan 2025 23:06:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76B221CB518;
	Wed, 22 Jan 2025 23:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="Eek50kJC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03olkn2080.outbound.protection.outlook.com [40.92.58.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA6EA1AF4EA;
	Wed, 22 Jan 2025 23:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.58.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737587162; cv=fail; b=mNgOmbIFLV8oojcobYHnXsYK/McdF7PsqqkMNBV/KSRQAIbYUVGLP+xKLzF0j1VvAkoyhX5KUC1HGDl0USA1IZaEu7bpLMbrRuPq1/hHzwPvxIi+ofz3PGjz0ZGaLKh2Or19bJx7U+lPAZEQO8vPk/IICe2lexpmBKdNtiOYtlc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737587162; c=relaxed/simple;
	bh=pugAuILa5hScos3sY9rnqD32OV7A5ZwmKpNU3EOmSf8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RKKockVlke0u8M1+JOH89dJTsTn3ND8+pR1ZkaSOB8ijJyoQIctX9ymXO9ls3gQEFNt6j2mrKGYirtp8u5hpuZHY5+OpkjlFdrmAHfhoeygPQuDVpx0BWaXYYSdP/9N5TQdPMtHMDDqtTxqc5VM57g9hXc0ldHoTFcfbEkxwuY0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=Eek50kJC; arc=fail smtp.client-ip=40.92.58.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lqVy8iFdD3rgUIq4f9r/yummdu8ndpbaBXbaQVo52UhaU8DdErKY3aUoeHz+U52kVWOUSXXLVkmVQq6CHLVxnfSfNW+vR/8JYO5X86nKzGtG+kO4iV704rlW0x7nhYxwSTZzWCbsnxSE8kXqzmXJ22dk5x7c5OiKnBe9JpFnGZTUDeL3yFCfQU4KafjvuVLtNOjChFnuBzZAuTzWPmoehmqeV0u26bVeidpjkI82PwFid4VP7T2uL7ivHvoQ+4d+gcteG0QhGsW8N32pkhiedOtcxx11ff9MaBV1mVb8ygzKRkfydLqeVsG9Gz7WDbR0BX9M57oHe4etBE/hvnllOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gAleI/7pahHtOzi4/CGD6R44dIvtsL6dRYEC4VIDUCs=;
 b=wnq78tO7fBXWKODgXRfP479uRj7zCDrRrVJbx5p5PFFIpp/t41Cs1mkETkyUIfRc3qxsrs465fq/8lbtrYxeYxB4GjuX1/yxVfpzvKvUoe30BzCpypawYbZGSaJCdzpQu3l8+JucrrK7aMrcYSJ3qvMy+uO1b57BTu6iTSFvtuvmGhHJvrOJbcmchKd2fKcmIX6PAx9rkV7J/DTpda1gNt9WnWba2pzS5GvS0p/zSvSzNr8ooEBOWXdOSAW1GLK8r3QquwoC3ukWTnynKuR8dt9VZa5xAFBYNVbg1bwMK4hMQcrU5VIxSGdEbodyWh2je2jrlJM4X7vuQ8a9Qp7qEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gAleI/7pahHtOzi4/CGD6R44dIvtsL6dRYEC4VIDUCs=;
 b=Eek50kJC7SnTV53MHTpkZgc3kFVe0YzsZHnBVba/M0/W24qpmDujG2BlQx39ZMNnwhXam2GAsNeKEg8qMqeT1kgM8SiOO/vhHwwuz3p36sZQAioNwYqLC5iRrPmj/trn4omfjXo8oemQUW5PgBiTCTRp7mIrEz57RE058mS854TYHTa/pJfLVYCHjmBOy/pWwhUcJM6DRul6UCRXZkQJv+DVyuQk6a1UFYJ10uA+CN43cyhPYytWZEYRLQwOFKBd7cM/C/8Cr1cabGnB7etNRSEjm6F9M/TSTWEbVGAoSjDHS/LpT3tz/ip5FHUtlb/uPJ32ftVYbZCxWBDDNp4q6g==
Received: from AM6PR03MB5080.eurprd03.prod.outlook.com (2603:10a6:20b:90::20)
 by VI2PR03MB10907.eurprd03.prod.outlook.com (2603:10a6:800:270::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.20; Wed, 22 Jan
 2025 23:05:58 +0000
Received: from AM6PR03MB5080.eurprd03.prod.outlook.com
 ([fe80::a16:9eb8:6868:f6d8]) by AM6PR03MB5080.eurprd03.prod.outlook.com
 ([fe80::a16:9eb8:6868:f6d8%3]) with mapi id 15.20.8356.020; Wed, 22 Jan 2025
 23:05:58 +0000
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
Subject: [PATCH bpf-next v8 1/5] bpf: Introduce task_file open-coded iterator kfuncs
Date: Wed, 22 Jan 2025 23:04:47 +0000
Message-ID:
 <AM6PR03MB508005827BF45E02865B23D499E12@AM6PR03MB5080.eurprd03.prod.outlook.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <AM6PR03MB50806D2E13B3C81B0ECDB5B299E12@AM6PR03MB5080.eurprd03.prod.outlook.com>
References: <AM6PR03MB50806D2E13B3C81B0ECDB5B299E12@AM6PR03MB5080.eurprd03.prod.outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P123CA0049.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1::13) To AM6PR03MB5080.eurprd03.prod.outlook.com
 (2603:10a6:20b:90::20)
X-Microsoft-Original-Message-ID:
 <20250122230451.35719-1-juntong.deng@outlook.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR03MB5080:EE_|VI2PR03MB10907:EE_
X-MS-Office365-Filtering-Correlation-Id: c9447beb-0513-4e50-82ae-08dd3b395488
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|19110799003|15080799006|5072599009|8060799006|461199028|440099028|41001999003|3412199025;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?cGXYAyZsmKFBw72VqPXnCSKonXFqZuPxjimXxsRRr8vBqAnCKotMvuriojtm?=
 =?us-ascii?Q?w77zpjj2KoicYX63XmI53bXf42f+ad8kT7ZoNC/a3R6bQSnrJCFusxp5cKKR?=
 =?us-ascii?Q?ZBeJ7eC12kgHghxufmG5gKE3mGoHwVN0jLCCJysBezb/H25ZJqzkvZ9xNL+X?=
 =?us-ascii?Q?rJoxm/Cur9vfSiBT9yAMlSPID9CyathNhczfXtMbuhkeTNs+DkvQG51g+taQ?=
 =?us-ascii?Q?7piQjIYv07M0bPkonrWPstfFwy8AFKkBMhFjedjnTqIohwtyKA4ntAEOXyXE?=
 =?us-ascii?Q?0j9ejMLlb60BzTSCTyMd7OadV3ZNuV5z8tuWsSpO1er1fqtt0D+s0MqBxG9k?=
 =?us-ascii?Q?7jzR3YsSyO2FXozYlpXgMty1KkkmX5ttK2uH+hmgzF7EmDA35BV+130hQo98?=
 =?us-ascii?Q?m4kqmAznVHNKDdGcjrGXY9TdwQJDGI6u/yUXluhlLPlytSAxmnbwsaO1nP/+?=
 =?us-ascii?Q?sQFrIrlKfPlheeEEixQWynIOXFz2YoXK6lmEds0CqlsTWzLawYpgi9IpHdRs?=
 =?us-ascii?Q?K2ah7JFX4ieIV2UZe0j5IgjnIs2JWaNHhoyhAtzfogs50U8RBcBBsP0k0zcO?=
 =?us-ascii?Q?McFGuE8FJOynFaimYI7i1BBKpcOTNo59sb1cBJPzYNUwx/mOCLeTVaK1VA7L?=
 =?us-ascii?Q?lThOe/nNjuJpTJAU8gc+0ASjV7DDvz5n8oQLVqaM909us/TzwQfzjb1gJtoK?=
 =?us-ascii?Q?5UCx2/i32FZ7VO+kiLCKb4jIrFGOkgxa1jLoJcTZWAvftLDaKfw5x+ylnxdq?=
 =?us-ascii?Q?ScGHlaRIvm569csTdvNNiIrj4n/tbRxjpBHdWctBIRP+wlU8JgfqESIz8ABe?=
 =?us-ascii?Q?R4cfNWKUFpo3+ZeVxipDPgcmTYfCDvRQa60x3ox8HZkTgv2l7iUBuWQYcQEL?=
 =?us-ascii?Q?3q7g7MwiBiof1QPNOvuW48XPYcDOX2KSQ/89NSvrR8jdvABnkJYDzqazcOpP?=
 =?us-ascii?Q?jf8JjwYEXaQegraD1rFrNHfS4IMWLg/BJaJ7MeK50ysoxGn3I1L4k6Iz1M9/?=
 =?us-ascii?Q?0RXc0/IlpKD1e061RvfaK+nqT76+RHGa41n2onXrC35FiW8piuhI0f1qCr6N?=
 =?us-ascii?Q?kw9yJWd+imguZYU+dFyNeDp4QKlAZQ=3D=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?slcH9Jw8oUEVQ4JwXmF8mA9xGnQ1c7Vk2ET8RpvRh9l7zBqX/4/vyZKXXsHL?=
 =?us-ascii?Q?KCCXzovI8HB3fhnA3yQs3P1lt2IVGA9Rz82q3DDMP32ike9jXuS7gdXm5J9r?=
 =?us-ascii?Q?Cd+8ItK2R1j4McdhKI1PAsxRgZoG7DMX7KTW8Sc9YjRpN4/UdTsOC5FRQNpQ?=
 =?us-ascii?Q?Xn4xqgvVr0PppFr1t54fK5yUTsgIPob0kzb1/usgUkQ5LFLyYr527Dc72+2Y?=
 =?us-ascii?Q?EyhRagHRtg2cCucdkQRkAqATxbKSfJd+oLaPNZwH+xaraN9YNx64q4lqwkFN?=
 =?us-ascii?Q?YGpD5jR0fD2oXRNifSST/rcab5dhmxNAPDzIzDpxdN1EZ6tAEeORJJfmb591?=
 =?us-ascii?Q?V7j0EQB4P2X9akLkP+1jIifQhbl35PFoa/rSVLIs533mVt/WgFCijd53ExuZ?=
 =?us-ascii?Q?54FyELex4UYcU/Hnlwc889T4T7SFDAhzdNduxomHzJ6O2lZ5KVKiJh1VMcec?=
 =?us-ascii?Q?Dx0PZHzGQRoLt3YGJMJi/kZVWGZy7z6Yqe55sba0jJAzEWYPwDfb3UBZ4Z0Q?=
 =?us-ascii?Q?YvkaAR2n3CQEUn2bsaas2PUMlSAHfi76QGRCohfObLU3M1YUfnNDlA0EObvN?=
 =?us-ascii?Q?SjQnekbJy9iKOyGmf6l5BIK3T3IxpMZLQvljg47Q/lG3jQQGeQcOnyHk+smd?=
 =?us-ascii?Q?KgY/MCM3Ukuvu1Bpb7rzHTnheaJtiZG7R2ii1207HS0gvV24mg/xKdTCdJEd?=
 =?us-ascii?Q?lWwuDzDRZQHpV+3PLICNwmGlF2ZJR5j/B9hA3Z0o/qmGq5YRqRoi6ZeSdiKL?=
 =?us-ascii?Q?SoZZBabLls6gisp+uLDMQO+iokr3lu0hj5N1lyZWNjT2weFZfyF8UIFZWG3D?=
 =?us-ascii?Q?YUg9P/qhuj10i++6h7LsGjSgifJrqP4kjgDXyCpgK3mlH2sLeIA9aibgFw8W?=
 =?us-ascii?Q?yUbPO6Tgc35H3qEOM2jfLWZBRIgpgcJVqlJWnxi0eb2IrHtsHRFvDt6BnVGO?=
 =?us-ascii?Q?b5ffT0nw/cBTzongFNwjMoYoBRiEY5/bLWfL/MHoGNp0tP/8n+sPlyZb/tut?=
 =?us-ascii?Q?WTXPV0lr6d+BsyWtK4YW+gYmY6rZ+z2r71q/wh4hkMd0J1fPpmf+Fb3uLqaa?=
 =?us-ascii?Q?bSVzK/vI9gJzA1pSvum4gKJ186sxjOKb9Io3eSpI7xw01xwEzepVKhchh5L2?=
 =?us-ascii?Q?PtIceBiXg7WdzcTRNkjbMPXkiZrMrOuqKAx3u/hTsufEQ2BEgG58kdMfplSa?=
 =?us-ascii?Q?I1ZcD2fQCx1Z8x2QRdB9C7z69Ch33g7OfXm4U6WybXOhSl1KgJ4ky1+b3rff?=
 =?us-ascii?Q?NoDCxnn4X8CMcCyseRKB?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9447beb-0513-4e50-82ae-08dd3b395488
X-MS-Exchange-CrossTenant-AuthSource: AM6PR03MB5080.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2025 23:05:57.9009
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR03MB10907

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


