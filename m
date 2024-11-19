Return-Path: <linux-fsdevel+bounces-35228-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C79189D2D1D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Nov 2024 18:55:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C3F51F22FE9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Nov 2024 17:55:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 634311D26F2;
	Tue, 19 Nov 2024 17:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="MtKe/P2F"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazolkn19013085.outbound.protection.outlook.com [52.103.51.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFD271D1F44;
	Tue, 19 Nov 2024 17:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.51.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732038897; cv=fail; b=k2ZAMUhsUSdDQyU3C746BBdTkeg8vG1gQKFmKbNw9mBBZ7Pz1MbXRKDuctgACNwyDjUxjmzuSJWddGlOw1Cjz2qbj7HYGQSLhKYIAEsm0SEFHleKapjwmLmTJo0GPaIxJLvdSuMmCuhtc/i4ZGM16KlmSBJrSl27qZNHs6vMbcw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732038897; c=relaxed/simple;
	bh=0j9SdFmQmc/JsU7okW3qy/PSDzL8BqqsZkT7lPFh8UM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nInkltf9GMOgCA/Bz91gHgWjf2loPbHhlv4GS/zWpF6tM7znvEmygobwZw5ezwL5S9KWuAwJIVX5sjQ4OxdLpTNguODWzv24rEpvfM1x3i4wwLLXDSOz5mlYUo3LAZyurP5NOIVJnmagGi2hZn63+o+pMy/nsOVwyOFlaUC8kMY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=MtKe/P2F; arc=fail smtp.client-ip=52.103.51.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M73Hyot29wZgh/EEiccwzCXlS4Ml/fK6Otbe4ekm7mcCr2dECOFcu99+of93duYD488h67cH64xLiK1vZ0Q0Uvz8/Z6rXgrdDx7MLNO2JPosEVpn7jq7B2QeG1nn8/jl+uvVdpmP86vp1weinti/mE4YvYT+bUuYu3gQZfigO7yjpjfYGdPh64C3IUXdoiU2ZBq8P30VBpopRejrqh+so39AzAxUKuheJ1BUbpWHEDaC6+NQRTVF0OrKivK4TrR+vxEUwS4zF047JZZDEs48VRAY8NQhmnR8+DPmVvMAYz2iwi5SCiZjxUKlRBF68SQm6EvLjCNToRxkc+alOwB3Vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EWktmrnogyzW9MyoepEcA+7pM6Gz/OOBM2kq56ApKTs=;
 b=kPUwl8Yh4Sas/iZdOD1E68/1DmKeJl4lUTCoHbXTPP/zAcru9liyvsEEdHU9Z986uX6XyHw4Jrlzx2oU3fbIKLxDPPxnkJCgK0s0Lvci+pg7yudk6jWN/evUACWJANHWhKvNq2Hf3N09QlPU/yWPxPMi6twcDJudzY3Vqb1/fphbwwsVfSfuazQG8sl2A9N+0aieDdQAmRCIM67RunFRvBYwDdaumrH4xb7vjT6zN4URrnT5tfuKLTlmMtsJS5XJ+OY7B1r4XqXxWDvcKDG9fgUBgiZ9AoE4t9iQQk9PUjjsIF2SRUayRiu4lz6z9piH5e0BWvs5aMfP/5m7PaRYrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EWktmrnogyzW9MyoepEcA+7pM6Gz/OOBM2kq56ApKTs=;
 b=MtKe/P2FLrdbiTfuYKK31TdSLCelT1rGAGOctH+5uB712YMd0Z74ArTRppt2zcHdDzXjHKIWKp2/TEU/rCmArEksGIQv+0G84T0N1K0hjYqDPnz24SWPkwF16uPZLAyhH2EcDara58tsV2qR+n5a2oUSVbpVAKXxyYlpwjN0ETF20IVJuakieoetj311BdKpi2g4NhLT571Cnbsb9/YJOiDfqEZ6Nfzw8tW89WvvE+J6WSvQu6NitfuD7etKMBene3eL4KCrqBzElmLt8MQZWmuCJ9cEQrJrg1FzY4z9CKKxJp+rVc1NdhRhc2DWJ+H7jsV3Ruwktl7Ry5ZQ9YqsMg==
Received: from AM6PR03MB5080.eurprd03.prod.outlook.com (2603:10a6:20b:90::20)
 by DB8PR03MB6170.eurprd03.prod.outlook.com (2603:10a6:10:141::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.20; Tue, 19 Nov
 2024 17:54:52 +0000
Received: from AM6PR03MB5080.eurprd03.prod.outlook.com
 ([fe80::a16:9eb8:6868:f6d8]) by AM6PR03MB5080.eurprd03.prod.outlook.com
 ([fe80::a16:9eb8:6868:f6d8%4]) with mapi id 15.20.8158.023; Tue, 19 Nov 2024
 17:54:52 +0000
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
Subject: [PATCH bpf-next v4 1/5] bpf: Introduce task_file open-coded iterator kfuncs
Date: Tue, 19 Nov 2024 17:53:58 +0000
Message-ID:
 <AM6PR03MB508013A6E8B5DEF15A87B1EC99202@AM6PR03MB5080.eurprd03.prod.outlook.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <AM6PR03MB50804C0DF9FB1E844B593FDB99202@AM6PR03MB5080.eurprd03.prod.outlook.com>
References: <AM6PR03MB50804C0DF9FB1E844B593FDB99202@AM6PR03MB5080.eurprd03.prod.outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0187.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a::31) To AM6PR03MB5080.eurprd03.prod.outlook.com
 (2603:10a6:20b:90::20)
X-Microsoft-Original-Message-ID:
 <20241119175402.51778-1-juntong.deng@outlook.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR03MB5080:EE_|DB8PR03MB6170:EE_
X-MS-Office365-Filtering-Correlation-Id: 148acbbb-d00d-40b4-e5bd-08dd08c3445c
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|5072599009|461199028|19110799003|8060799006|15080799006|440099028|3412199025;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?mCdbfHCnp7cTsvF8BVQVUzFzB1TtYqbatZ9a2OJZtvlWsu8yfNRGLKrIVmuh?=
 =?us-ascii?Q?shfuLKVw7yk/7jv/BjM1RoIXfemcQzskbkOAowQJBaouDpKVwfFJ/3v60wmE?=
 =?us-ascii?Q?4vFcblDXq26ENi7rgUYFILnXtgztC6PB/EI9c1cfVtChD/mpu7beTCk8HRHm?=
 =?us-ascii?Q?ylYkalCBkE92n7ptGffiGUtYdyzFgy8bS+qHBrYR8Z2084a1FgiPE6cRnkKN?=
 =?us-ascii?Q?b2QqMFW1fDoabS/Ian87iYUSoAG6IrJSR7H+EdZvgAPCCutkvrQNKNNV/0rC?=
 =?us-ascii?Q?1zKhjY+JxQAY0pOYfQwBca03FK0pJe52buVqd1OIJGzKLMMIJahRA4dnIXNs?=
 =?us-ascii?Q?VC2O+Pxka9QuIu3YeexnG7VQD5B6dd//phGx6oIPGxrerOd2/1o/gWANoHbj?=
 =?us-ascii?Q?KalPP5o+Wqi+h8MGFBI4QhOuA4WcHyZevpYSAmrOLlkfTr2Nh0I8APOdQSXk?=
 =?us-ascii?Q?RQocxz13FD583PpdjZwjIIyy86zXpR50JT+y0kRT0rOjapzBE2nYbrnXbM+y?=
 =?us-ascii?Q?0LSOycPa/CunlzdPkdnOw0FiMhJpRamZQYGLByNwo1TtCA4Zr2YgmU3qrFUb?=
 =?us-ascii?Q?qteLqz/U2nbs+CCDTSn3ZisfTExmphETW+AeGtNYS/cB3maN78lvNKMuvKPs?=
 =?us-ascii?Q?+EcS3Ja1buICpLbvUFlloB4pj9BoZdYmHZklUqUvCpLKgUy2hwNiLP357h9i?=
 =?us-ascii?Q?9jHj3XblEq7av7gSgAvp7qhZc97NTeZdO/MoMVt2zOT1LUYgzjgUYFNS+6HN?=
 =?us-ascii?Q?3QK9zO2ZK8vlQDBnolrOOAGmP6GCcXBTT+764d5BK1tpgQ0IQw96Lpz9P5ZH?=
 =?us-ascii?Q?RC1Fuc1kgoJx1rCCdTHUuThFRkEvsl438ANYA0eMgmUZ3pLq2lj2pNvw5b8j?=
 =?us-ascii?Q?85OBioHeg+nHRV/t6rXZaaVJfRDcd2s39lT5BymKgpem1265+/PnttnmuInr?=
 =?us-ascii?Q?PRrXr7cb9hWKhOQ/Tk4Xbj/MuVacpPn8tGDH2JsNwVDx6B2OPJU6TEnGNGoV?=
 =?us-ascii?Q?xzS//wmXLldT8f5G+DBjuQiScg=3D=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?FO/CSOgwXr5h+xy5ZgCRfM25GjJ09UWBLPinaVLmKmu6cYIawX2WtVVHdZ9L?=
 =?us-ascii?Q?m5tdfPbnjGBwOnRUpEDC8R+st1R0cz/yO72dik0bNiktXmSjMsgO16QqK7O1?=
 =?us-ascii?Q?2R2Z+Czr25TOU3ql9p4JOfJA8rFOJn8wowJkkMJLEapm2WXXc6DrZd51TOtH?=
 =?us-ascii?Q?THMb0HwvkuZ33opDveoZcF+i2Z+yRUWnMmmbip3MDbLy2q1jPFa+6G2g07ON?=
 =?us-ascii?Q?GXlfC8qVZeg8MVG0ihcy9ZvEC6EkDtKcp832DL2lxZkCQrSaEy9YEnFAmbkV?=
 =?us-ascii?Q?8P6bd9yGaInIKjBF5mSJRcsSRYxFbiLijnBzV6vaBV1HmOQdO9yHc72/MSZ7?=
 =?us-ascii?Q?LlXKHT4e8ZFNUsHTFL9LDxz7O2CBO36I/NW1JyMHqaa4VKjWDZxNdZ/ouBzc?=
 =?us-ascii?Q?ERJoW68aAa04q5CT1gR8wzv8wE5XLxa8Z7LUONVUxYGYXThGK4JrjLQk0+3Q?=
 =?us-ascii?Q?iHLPHGuqCiqmNOfT6kFgK3bMl7gSPNuk7UbFrr/lmhvoKyNX5d7tmBQ32dpk?=
 =?us-ascii?Q?YVwne2EMoChKsrK0xvjzXYCSsawRyC5gO6CZQ0z8K+q0piDa9zZlKFlEvoFn?=
 =?us-ascii?Q?8hAVHjFEQMuVZbzxQvgxxOaSavDKb/K7/9MlvY+p9PcpSjtReR5apCLd+zIx?=
 =?us-ascii?Q?iMcpw3cpvxSxBmcuVzBOqQRCnhis2encTxQjnDuhGWe/yAfUNgohFiw0uSZu?=
 =?us-ascii?Q?4DoWIn5zoCg1cGc3SKMhWTmVlsbehqEZVeKB7VAQMP355U+HKiD7lHaekn/f?=
 =?us-ascii?Q?jlR7xmVRoB6JKwdrvNlwOJS1yf5QzWVtaROu3b8wBLAPhSQdZingk1XsSxL9?=
 =?us-ascii?Q?d5snIIsmqfwNYhsBkxVUqkdUfKhyH65WWChTMBAsJb3jfmBNT1kxBaak7/qy?=
 =?us-ascii?Q?SjDpOenDzpIdlhVcHgIvIABsKJdErIXSDRlia+b/dmSeMtKB3wfTBAjVmHJz?=
 =?us-ascii?Q?Yt/bdKJ27ImB0eevNxqrFIo8dEV+X1ys1k2Jz0IOyk+piqcFRx3gkGuc7pMO?=
 =?us-ascii?Q?O87PhUGfg96AdeT1VVfLmJbXzaFnvwVrQOWPHSvZ+vQGvTplj7q0jyRreFV1?=
 =?us-ascii?Q?D0WfC5VAnPWIhRJ9CK1GcGVDxaRdK5A9qhQqVNhLnSv88QH0Y9MXFOJD8HEh?=
 =?us-ascii?Q?ADK9GyYwO57GsO8PqSQLKevf4Ed/huLGtYHEa1ejK7SXu3gNpWbc6ng7oRHD?=
 =?us-ascii?Q?VMPdakNhLFKocSy/jEyTFS71wRqyim4KEZpDLr4H8Enw8iTti31Y7IlCpABz?=
 =?us-ascii?Q?3fY58uWmllYRZ8EaSkRJ?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 148acbbb-d00d-40b4-e5bd-08dd08c3445c
X-MS-Exchange-CrossTenant-AuthSource: AM6PR03MB5080.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2024 17:54:52.7609
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR03MB6170

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
 kernel/bpf/task_iter.c | 92 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 95 insertions(+)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 751c150f9e1c..ed99d2bfd425 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -3130,6 +3130,9 @@ BTF_ID_FLAGS(func, bpf_iter_css_destroy, KF_ITER_DESTROY)
 BTF_ID_FLAGS(func, bpf_iter_task_new, KF_ITER_NEW | KF_TRUSTED_ARGS | KF_RCU_PROTECTED)
 BTF_ID_FLAGS(func, bpf_iter_task_next, KF_ITER_NEXT | KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_iter_task_destroy, KF_ITER_DESTROY)
+BTF_ID_FLAGS(func, bpf_iter_task_file_new, KF_ITER_NEW | KF_TRUSTED_ARGS | KF_RCU_PROTECTED)
+BTF_ID_FLAGS(func, bpf_iter_task_file_next, KF_ITER_NEXT | KF_RET_NULL)
+BTF_ID_FLAGS(func, bpf_iter_task_file_destroy, KF_ITER_DESTROY)
 BTF_ID_FLAGS(func, bpf_dynptr_adjust)
 BTF_ID_FLAGS(func, bpf_dynptr_is_null)
 BTF_ID_FLAGS(func, bpf_dynptr_is_rdonly)
diff --git a/kernel/bpf/task_iter.c b/kernel/bpf/task_iter.c
index 5af9e130e500..7a3d8c9c3480 100644
--- a/kernel/bpf/task_iter.c
+++ b/kernel/bpf/task_iter.c
@@ -1031,6 +1031,98 @@ __bpf_kfunc void bpf_iter_task_destroy(struct bpf_iter_task *it)
 {
 }
 
+struct bpf_iter_task_file_item {
+	struct task_struct *task;
+	struct file *file;
+	unsigned int fd;
+} __aligned(8);
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
+ * Note that task file iterator requires to be used within RCU CS.
+ *
+ * @it: the new bpf_iter_task_file to be created
+ * @task: a pointer pointing to a task to be iterated over
+ */
+__bpf_kfunc int bpf_iter_task_file_new(struct bpf_iter_task_file *it,
+		struct task_struct *task)
+{
+	struct bpf_iter_task_file_kern *kit = (void *)it;
+	struct bpf_iter_task_file_item *item = &kit->item;
+
+	BUILD_BUG_ON(sizeof(struct bpf_iter_task_file_kern) > sizeof(struct bpf_iter_task_file));
+	BUILD_BUG_ON(__alignof__(struct bpf_iter_task_file_kern) !=
+		     __alignof__(struct bpf_iter_task_file));
+
+	item->task = task;
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
+	item->file = task_lookup_next_fdget_rcu(item->task, &kit->next_fd);
+	item->fd = kit->next_fd;
+
+	kit->next_fd++;
+
+	if (!item->file)
+		return NULL;
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
+}
+
 __bpf_kfunc_end_defs();
 
 DEFINE_PER_CPU(struct mmap_unlock_irq_work, mmap_unlock_work);
-- 
2.39.5


