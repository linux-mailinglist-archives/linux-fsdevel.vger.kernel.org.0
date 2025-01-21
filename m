Return-Path: <linux-fsdevel+bounces-39773-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 91A51A17E75
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Jan 2025 14:07:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA9913A90D4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Jan 2025 13:06:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76C2B1F239D;
	Tue, 21 Jan 2025 13:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="Up4jYAuE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazolkn19013064.outbound.protection.outlook.com [52.103.32.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABEA91F191E;
	Tue, 21 Jan 2025 13:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.32.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737464765; cv=fail; b=SNIt6O8CY9dB8foK1fdhekM3B9TQlImQ7EmQQgM5wSsdUf5kQRjPi/FulR8AQfEgGrdHxTe7OLQz42rWj75NNBOqkG50ev0YNCivYxFKt4f5ZXLtYV0lIfxVjm+3yy+po6AQRLQGsUYrCNbC0SXsPT+SmYqUm5V0NSizS5W4DmY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737464765; c=relaxed/simple;
	bh=TjuuEP7vkBNZP8PiRd7an3x2Yz+9/WZQOW1T8a02L54=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gonA05aBT+5M+gH319MKRX47ZS42cStqI9/VBbdvtIJzuiKPcXt+deiDUIyBufkQcM745ZE6Q65pl64Y2v0pUQQmaY7oTcUoCbs5WEpxKZxGvc4vj14dkJ8G+pyN84qOE4Ri/EgNWUjpT8DYBwNQ67Qhf76imGzCSto2oM3VJaQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=Up4jYAuE; arc=fail smtp.client-ip=52.103.32.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kWFjStPoyeYehcG1Nv9AUzHR4kOnM2SJB3CwZUvq69yxxGhzhexsc9tEsKcOX9Owpqfy3dGt0JfvkvvK5zAmDFqI8GbmkuIqpg9R/xOBfQR7MhN/fGgezhxtSm/d0yx5Mpmbd8jqrlNjO8WoVqu4lE10QGn6fHZ8vSBnxWb/VnnrZyjFC7OV/6oC9oeYt+090Z06ruUd00Ln0c6Pt1mCAmQ1OWKknD8PFsG8Sy1WFxF+FFebfIlXWJ6Dp7xzdhl+NTz4jxffYnh+zmtgJutDDvrTVroxpD7cQAx/8VthHeIziIlicAnlS8+c/Ek9QL59DXyOesoo2LI9irQ9H7L03w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JNnqfaRrbBcwACW+jIsFfIzmHQaPqqJi77Ja5rYI23E=;
 b=YcaVuR6q4CqzB0V2Zdt6QG2rs+hUtnpfkRCaRnI8Ky+p5R4ITCig4Ts/WRCCoAsXVCypI6VxEgLzTMQVZeyQCvkkc1bswHMbJwkFM6+lZmwixQ2ygTNwrBOXHlp/xUf2wZSJieipyFBd43v/Z8HIp+IopIJeF0eYc9I/Ri00ArdnCy5D7g5LICx+Ht9sAGIXwsI5zKLSMA8YiJnkPPAo6r+fWaXxo+66Ecq23ruybT0P+khEkIWFhE6OVODoRlkiCRxKi7S+9lwiZZhufGxBcSO3O9Pcwuc3RiLj4UwH9WZ5p2ZVl1BASJXaVQb9ok66NjU6+ZoJGTW0tQ8t7EfbJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JNnqfaRrbBcwACW+jIsFfIzmHQaPqqJi77Ja5rYI23E=;
 b=Up4jYAuEUElB2BHhfFhmoCqSDazCWP4LOixmiUpAihVxSsmUVYiFYrDjY7slQdeKrTzRbFHmZxkZVqfvpg8j3qC61yd7tHyXJi5d92L+2h2Kmhhb9twXkx60q4t983VWsrhfb6eW163TPvtM1CRhy8DFYkffA9Qlh5kEuKp1YKc52a9Wb9r8IiX5PG6iISKYC8onONxNav/OLlhjmifn3y2zhbuzmHKWTrOgzY+dULVfPXAxpITJUycHsIOJMg3x7qXY54OgW/8Tc2IToHbi0lCRNyAfAm1ONhXCpieLv5scA43lvmHMXVjE1k6rkEOPsN8e3Qf3ifiCBpy39RRpMg==
Received: from AM6PR03MB5080.eurprd03.prod.outlook.com (2603:10a6:20b:90::20)
 by DBAPR03MB6407.eurprd03.prod.outlook.com (2603:10a6:10:192::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.22; Tue, 21 Jan
 2025 13:06:01 +0000
Received: from AM6PR03MB5080.eurprd03.prod.outlook.com
 ([fe80::a16:9eb8:6868:f6d8]) by AM6PR03MB5080.eurprd03.prod.outlook.com
 ([fe80::a16:9eb8:6868:f6d8%3]) with mapi id 15.20.8356.020; Tue, 21 Jan 2025
 13:06:00 +0000
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
Subject: [PATCH bpf-next v7 1/5] bpf: Introduce task_file open-coded iterator kfuncs
Date: Tue, 21 Jan 2025 13:03:02 +0000
Message-ID:
 <AM6PR03MB508049D1DD3BE9BF14A799DB99E62@AM6PR03MB5080.eurprd03.prod.outlook.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <AM6PR03MB508004527B8B38AAF18D763399E62@AM6PR03MB5080.eurprd03.prod.outlook.com>
References: <AM6PR03MB508004527B8B38AAF18D763399E62@AM6PR03MB5080.eurprd03.prod.outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P265CA0260.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:37c::11) To AM6PR03MB5080.eurprd03.prod.outlook.com
 (2603:10a6:20b:90::20)
X-Microsoft-Original-Message-ID:
 <20250121130306.90527-1-juntong.deng@outlook.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR03MB5080:EE_|DBAPR03MB6407:EE_
X-MS-Office365-Filtering-Correlation-Id: 5218b3e6-d718-41a3-22e5-08dd3a1c5a5d
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|19110799003|8060799006|15080799006|461199028|5072599009|440099028|3412199025|41001999003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?CbBBSqE2az3HSoVJ5YAKJymScpFPPVNtXOPI5lPmwOy8uHaLrfd0YzURDO+q?=
 =?us-ascii?Q?zB3HZb/ct1i5gvfWq/zLBxCzulAbAPXWjiiaT9LtUNllQT9wHgjEociQYMqP?=
 =?us-ascii?Q?Pv0BLhbvuS4oA3U5LpdmjzHqRhxhFXWozhYpAU61IndX23JecVFUJsh3F4R1?=
 =?us-ascii?Q?o0/DnADquGWfPwEjQmV0jy6/d1EX6UGFjjyFBctc6YcEAkTpWySqiHJt7JE3?=
 =?us-ascii?Q?8EODJsioXQPK8RHDXYZaeTv1I561YJM4pSYrhOQSTaHSA2BWysZdDYDqxj5O?=
 =?us-ascii?Q?dnqwohWFxXuHtdfrmIEkdt1cmci83NjcybZuqYqp1HN1wdbVviaPdM4vLP1p?=
 =?us-ascii?Q?LNebsq5En1uJYx15TLg22uMO07OTS4TyJ/Q8EjqLLuf4wB4TWv5fx0a9zJ8K?=
 =?us-ascii?Q?4KhTGmMI/pdpA5v4S3ZY0I3oKRPfXoraDxrD9qdyZXBZ2mz9bb87B7o7GRqc?=
 =?us-ascii?Q?XCTS3G6rqzkVy+QL8BkxV1934kjpvSOlRyOoOQNhqHoy3+SUKvuq7P0Q8jam?=
 =?us-ascii?Q?E1SfirIexwC+o9iMCc+H8E26iqENEgRTrqE8nGRcAKv+zi4AtZKhumnuQvUn?=
 =?us-ascii?Q?jHHzQc8A/ymRxDyTe4rSirYpRxe7AaeHNG51kMPBZz4/i5V5po3H+ScUIPq/?=
 =?us-ascii?Q?pwH0bAAEAJXr0PFExx9zS/NHZRjehllAp9mlh3U8ikqW1KYqheGGuj+n3T5c?=
 =?us-ascii?Q?yJJQQrHCpvja/ICnc/MtdpwMMH/En5sAC5OHo2ZG0PPnxZli2vh0bKA8rnAa?=
 =?us-ascii?Q?pPkDuU2erMRdGojnQ0/pjGLI13sar0KSxLLr6mk7yA45n3d1qnxT4r4zLB+J?=
 =?us-ascii?Q?b2u9AW1pRr7KKxIhdipFkeoOuZJyy4DKqeNPTM/CFIEwtO7lAqZ915xMtZVQ?=
 =?us-ascii?Q?VcMA21y3iuO7MbCS2AQ3qJd7AATuTpxPiVA7o7gdViTXIiox549pExhE/ecb?=
 =?us-ascii?Q?PoZ2jOVWJGAg1qsly/jIvPOmsW9OB/QbLkTbm5cv1wPNLut1tf9jKI0C1WAk?=
 =?us-ascii?Q?sH2uCJjHTt4+CzC3ASjgCvxW/6DYl631RBoSS2vr0SR/QDZhMD3SDtJYnESS?=
 =?us-ascii?Q?Cw6loxfr1wfcIgKIPYj4glQaQfqwRA=3D=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?HCCZajP309thb9Qolgg0jKpJViduuXMQOTFZzESGJbE4coBDh10vt2eFNhO8?=
 =?us-ascii?Q?1POX0nCAovoQrAEE6nHUE864JSfQcyglGqbPjJtOegW9MKoncXssLajaRmJQ?=
 =?us-ascii?Q?MvD1+9nIZig1DsDqM+N7ZLDxqIJyybXvdnzlWNhAjNduP0+zyfA3GdnUI1zo?=
 =?us-ascii?Q?S25/xVUbBvxXuCfPc7PDQjgLaIvpb3ohY7UMBh5ZBElUjwODfzvh0atzUxR7?=
 =?us-ascii?Q?mQOkEmT1/cDLGwaXoxpCADVzfQZXGrWLZ5g4j63OSBG5hE4vxb/G4MOC8INd?=
 =?us-ascii?Q?Nyan+KxTyD/vaBDI2rsggT8kILFs3FjOOf84zDlgemVRJYTOo3+wd+DNLShU?=
 =?us-ascii?Q?tKq93JUBFKk3zscu12ccN+8HjQeMuX0l9/I3NzZEPK4yBK07yEONk9/eTdnE?=
 =?us-ascii?Q?Et6+q6F4dMkJ5Vd9H5oOa4YkXGSh9r7Tw2PRgKkJL0WSlAhowSljnhjaB76z?=
 =?us-ascii?Q?g7DAdZyn4fW03MEoDU9jgUpOkPhBLFGBO0Ldi6qChDsWE5eY2sOzhUuixSiH?=
 =?us-ascii?Q?cwbN+l+UtLguM10ulf/n2Chwx8hYoqRRdIlX9W+0nY/VO11skOdQIM5Te8rk?=
 =?us-ascii?Q?01wiKNKLOt5u1wSD1VY6IbQQHf+k97aYDKADduPglscMuXO/g4QplyhVoWEK?=
 =?us-ascii?Q?MePqrPpDqeznF+liY6oDNHOzkdXxpU3e1HfMZXGxXojPBfuJsnPzj5/Ebi4e?=
 =?us-ascii?Q?Qdly6ydZjwC+5Ko/Sl18/FWFfTaJ/SqCReldYpG+s/XZNgujkeBNYQIR8cx7?=
 =?us-ascii?Q?JHQRxKNjPj0A+ZXeboNYZIXLeccxN3ewkvR55c9AxqjmE3UHBsMD6HXQAqVC?=
 =?us-ascii?Q?s6XY9GRtDS8ydKuiNCOiINsTIFB+yMKy/tSiMZ2DXwy3eluf8JN2jVDazBIJ?=
 =?us-ascii?Q?mAP2xtghWXkE3/531alYKDPh9cAElegkMKUhWwCvVqHAIZmP7isrwtvHz2aK?=
 =?us-ascii?Q?jednRycE8dLa0L97Cim7txu2duvXZayae7YJ1l80KOdr+p+05AFVSFVQNwJ2?=
 =?us-ascii?Q?06UwJXqnedoJnEjPkJd8k0eWzjh1fH3KvqrtY1UebBDQBArVSTRbORZGmCWV?=
 =?us-ascii?Q?PmfuPmbKGSAysDBsAc+mrONIzxCW5q006k58yKa7RDhuEUOWjDaje5sRw3r1?=
 =?us-ascii?Q?S9qyWr4vjbV8bQmnw9VHr9JPpG/T0LIuYgwGJ3wpRRlWXi7FPcCDOGNghrbO?=
 =?us-ascii?Q?t4ECsgL8ZPO0nHKjg2x5AFJdCIFQgcUy3Zw+4vpROBZygv39ZL1paYb9Tr0E?=
 =?us-ascii?Q?nnlH/GeZZdPb+Vr37hBz?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5218b3e6-d718-41a3-22e5-08dd3a1c5a5d
X-MS-Exchange-CrossTenant-AuthSource: AM6PR03MB5080.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2025 13:06:00.9512
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR03MB6407

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
index 98d9b4c0daff..25b7682bde53 100644
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
+ * @task: a pointer pointing to a task to be iterated over
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


