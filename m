Return-Path: <linux-fsdevel+bounces-40179-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11565A201EC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Jan 2025 00:50:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F40416500F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Jan 2025 23:50:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAE151E1A23;
	Mon, 27 Jan 2025 23:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="OEObYzw+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazolkn19012032.outbound.protection.outlook.com [52.103.32.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F642481A3;
	Mon, 27 Jan 2025 23:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.32.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738021832; cv=fail; b=PwbiXQouXzA9AcxsUV+Wtwnvm8wuTpBaijURhV4QG4QH6X7LUGjTxuqs85eK60HbsMKIt+SeP7gyQRBCSHTRlSS4q7ksx8+3/zh2TQEsv+N+oWwJZeuRk5Dq2Nc403rG+Umdb97wuQQdnQStXfbYBLQY/XgNJspYDcva74CJbrg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738021832; c=relaxed/simple;
	bh=KIxnMIr3pjygOZQfnbAT4gl8laW2esmTBi9+dragCrw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qyKEfkw5UdxfiCXZlqGCvFhg39+PGfhxMhYw+fPHewKNvQ7zxY7x0ftm6qPqVsckyD8Tc/MgSW+wP8WNXVcqJ+gC91cBGPmrMHXgj3YZPXz5kQGpVHvC95Q/c4rduzVmxZmiiSr/ASU4I83cZ7Dx68RSIq+v9JyeWmdhBxQd2Q0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=OEObYzw+; arc=fail smtp.client-ip=52.103.32.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ITnYjV0/49MRt3Xtwbho0oLkempRkAdT0KBONE+hOWIZ3LkRAxkUxTCwJuaT0cS6T0E0OmhgEE/mZrYt/Ix5F8org/hByNGKqRmkCdHNYhnjkesgPukDke5lpw0dhuJ5rPt30I4QjCV3TvSFAvhw2nPClGOXwtbUWS3Ib3g1okXPFbbSywqXD54CvGzotoIcab4u8dZuO4b+6bO1VpsE07q2/4YN9xfsV4gaHxsm6jicZSU4mK5ZlArQu2ZBs1jbUK4vTdESs4Wf/uNzlw6WVkm9lw75Sz2qku9X5BCesWaoxO1OcQXTSv/Ne6AkpH2Au5O8B/J29iqs01v6qt/U/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QRVV0jX1KjzggGbvz87UhS2xPIc9n8VFZ0MWXdCk1fc=;
 b=kkY1qAgX66GkUa3Nii4DhL+zff564/Krzg8VpOMpXP1JU+Cp3DVXz71n6jH+o/BMs+ikCXxMhiKV4kjfOOhEfwqrhYJp6umeIo+UTDmHRv1FISzt14q/vohuSq42ml8DFka+1S8fIkqSZUEZuetmRUNxvelBIOpTxnPdPQty7xA+QJmX8Oq1FomY8gc9EIqfoLDMv+rfrs+TJXJVuUU68gOTsj3+FspjaCfjUA10f5Orm4KIyVxyt4QrtyTj9V2OcSGL7CIhFAycWjI64yOQiXcf2i8ldJESqdc4Z+DzB0z/qn/UOwle06l0Fq6i7Ta/2XB5ocuCFJBN2qxxX2DlXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QRVV0jX1KjzggGbvz87UhS2xPIc9n8VFZ0MWXdCk1fc=;
 b=OEObYzw+6UlwYlhQy1TL24f3GDmD9mFYtKisb1A5hG1wixiYC87U0cKz7PgHf4OXfEvN9MP4YF0bkmo7kXtmiteV7mqcBPKHOUcH7+O5+VAmO8S+VxrXHTPaLq27WNFREHa0TIk8jmWKVSWQvNMd4HdA4J6XJSqY2oavkwpI/ibgHP1J2/IQOnzSo4I7r5dZhdeBCnMVTB+2AloLf7jkR5Z3XGoAni03igBSCT/wO7Krpb7DAZt74HBGfYdDt6x1Hq9ZPsU0EKl0x8mTGfVwfdPicc/XS5mJ0QBMIUksEshDkFpNbHF2PJa7NFjtCGCsSHpgZxmFt86RJeRtFjsGyw==
Received: from AM6PR03MB5080.eurprd03.prod.outlook.com (2603:10a6:20b:90::20)
 by AM0PR03MB6209.eurprd03.prod.outlook.com (2603:10a6:20b:156::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.22; Mon, 27 Jan
 2025 23:50:27 +0000
Received: from AM6PR03MB5080.eurprd03.prod.outlook.com
 ([fe80::a16:9eb8:6868:f6d8]) by AM6PR03MB5080.eurprd03.prod.outlook.com
 ([fe80::a16:9eb8:6868:f6d8%3]) with mapi id 15.20.8377.021; Mon, 27 Jan 2025
 23:50:27 +0000
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
Subject: [PATCH bpf-next v9 3/5] bpf: Add bpf_fget_task() kfunc
Date: Mon, 27 Jan 2025 23:46:52 +0000
Message-ID:
 <AM6PR03MB5080E08EED5A43DD5468CD3299EC2@AM6PR03MB5080.eurprd03.prod.outlook.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <AM6PR03MB50801990BD93BFA2297A123599EC2@AM6PR03MB5080.eurprd03.prod.outlook.com>
References: <AM6PR03MB50801990BD93BFA2297A123599EC2@AM6PR03MB5080.eurprd03.prod.outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO3P265CA0018.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:bb::23) To AM6PR03MB5080.eurprd03.prod.outlook.com
 (2603:10a6:20b:90::20)
X-Microsoft-Original-Message-ID:
 <20250127234654.89332-3-juntong.deng@outlook.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR03MB5080:EE_|AM0PR03MB6209:EE_
X-MS-Office365-Filtering-Correlation-Id: 37a8d3a1-6486-4766-ecf4-08dd3f2d6018
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|8060799006|19110799003|5072599009|15080799006|461199028|440099028|3412199025|41001999003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?iotGClZvXE0tkLIIAFZlLK2HaMc+YneKzZAYyS6DK0Fvtvu7Axs/LtUrGQVu?=
 =?us-ascii?Q?rkKsZrccNNvNNADy0UhjzMkvgEymyagJE4mDP2eyyA0edSzvtkWVQJE+GJEL?=
 =?us-ascii?Q?ZDxjTnhDAnJky3gpWqJxjOEFw6mIY7EwiXHduSHPsLcCCPZwENIA1wzYaHmk?=
 =?us-ascii?Q?HSujvdYOsTrq+rrJYIhIMQzoW/kwC488atO6tzh/sla30GFylCgdfDHxo7d2?=
 =?us-ascii?Q?/wDzWGuG27gd39e+8SRS9LXzetEMxFSO8WgGztuuTGGjLOyazRpLqBgwH/az?=
 =?us-ascii?Q?/5ok+h4tzqmykiqj1xJ4YDg2QyXIi9V2aT08uZQny12abj/DerhjkKQxBMPo?=
 =?us-ascii?Q?V8xATbx7JIsbdDV+sOv4rhanG+NnB9fD6cRSQdbg6hACtd6mNH8uutJSRTAK?=
 =?us-ascii?Q?sAAp8mz/ydW/I6CUafwnlxORoiUak9FADtWnxEnhTc3VH7jL13l3XkzFnX4Q?=
 =?us-ascii?Q?qPMfbVd+rK9qmuUCzwmbgk7bBDQZppvfS5PHWied9w/A5Lh9Nsv82iDvok0i?=
 =?us-ascii?Q?NxXj4RMn10va/ev2s9jXHys85fDDvUWbCWxcqr/TrcUVEUSGlh+rRMu4d2pg?=
 =?us-ascii?Q?lRLHf2yKW0OCf7FtJWKnHyINJzWtQm4RXZQBhxLMHld1EmBoLMDCJclz3lzD?=
 =?us-ascii?Q?eWlrFwqH8CXGd0lHiQpR7brg57ENaItAN57DWK62Ru7590aKzqlwT14yFzl4?=
 =?us-ascii?Q?npyWUf/1OUWCX9EaPf7QhSBiH+8LuXVIT4Vd+ySTl8/bWH3K7AH1okp9JGU7?=
 =?us-ascii?Q?pts7riEuP26Zm3OZ3ErP22XwWMWOpI3AKRaxfTieOO8uSTk1CheIMM5mzqB0?=
 =?us-ascii?Q?75ctLDw/jvl+VJXrY8F+riIiScja/KOtPvzqDGAQWhE1PJ8lQfIxfNcYy8yF?=
 =?us-ascii?Q?2ePs5pVhvmwEH/BV7iwUJHR04wswJSVC/+kd0opH1gnIknQivktCwA39zLk1?=
 =?us-ascii?Q?kY2TBDRojSHsTkcGRup+OkSXylN6QqVUpSuqtlNSa++SCUGBdVgtUkWkFr4J?=
 =?us-ascii?Q?kd/MCABy3LLtrOXN3zxHi1xSqcWmtHe8c8nw0C2TU71dOGv7efI1ae7P56uz?=
 =?us-ascii?Q?Kvdu2AhIV+WkV/gt9mA3Z6zH3yA+xw=3D=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?VkvINoUzDLH2/UmU0pqUnbl06ub+2UzLo/hy3d/5lTEmA4Bg/qLx1VgFWur0?=
 =?us-ascii?Q?fH3WdlSFcJ7PsicU+0rENV8NKV+v9Qb7i0uNtqpv7MeQ8KcW2EbIxAAGzPq6?=
 =?us-ascii?Q?VNc5vJT86KKJ3wXQ21MI4tw7zoV4X1j2nK+011vqZCvDFAVYYbUIVvktfy9w?=
 =?us-ascii?Q?9jj5cDjjKhJ9tH4L45hjfaKqgbDt/VrnOrskUHT0zwZGo2y4orMQesszstUm?=
 =?us-ascii?Q?s/pAsL39mX73oX8qxvjpu22SX3nxMuMvc7GYe+Deui0YUJk6IZrSFtjU8NC1?=
 =?us-ascii?Q?NGOd/gRuqgF62HcTEkQkninVpLAUsPbLHd4U0o/MKUD53+3RnpCbXEOhBH9E?=
 =?us-ascii?Q?KU5tg/4VOWSB89NTRsSHD0hLdXdl3vXlWwiatcs402TB92TizkLBuovr5BWX?=
 =?us-ascii?Q?IaijN6TYqpT/T5bejGFY3wasC12+8NPpOuAl5iUqWd1eXFfgFDMUbeUfic5C?=
 =?us-ascii?Q?M1G7vav32OcLe8QEcENWa39KXzxROSbCfb0UzpDY1p+CynJzXDzN1rRmo4AS?=
 =?us-ascii?Q?38uKk4gXtg0D23ajCl40b0kix25qgaPSIK2KZK1hOrZRHd6/zsZfwS4YYEg8?=
 =?us-ascii?Q?BX31tC2cBU5G/F5iK1JrbwjpXCQypwTlojjvBa27RZGJMKci8BATB4QXtdTo?=
 =?us-ascii?Q?RyAdi/Ob15+jJ4osLYVIwGQFzrzQ6gLBYv8gf5dTB3GEq8KPMbDvz4w2Xvtf?=
 =?us-ascii?Q?9rL8cffo4gGthrNVULXMfB5mBo872386tOaarah6RI9f/1uTeI/4rKckJc2o?=
 =?us-ascii?Q?TnKQzdfglvDQm+SJUtLXNXAhBew4OJZ+utNUUI3CfkQfHfoizG3u3LChC8eG?=
 =?us-ascii?Q?FNKpIQONVBe6FTwI7IAPFuFZccXtScja/o8wrMq+Vi81fFxvpW8lepcbu+De?=
 =?us-ascii?Q?luLc+pvU5GPYjfseknrdITN3oyvhOcBrcJUD0TJmTc+aagrCgN2WLpQadaiL?=
 =?us-ascii?Q?oxkWi8CMJRkFlwuQgB4txlK+gHGxhDUkYoKP/krkrVYKuOxc7rusznGbqdWv?=
 =?us-ascii?Q?gsDFuNlM78EjDAlHv0EdpOuUJrgRnXFZY77tNyMeYncYwoOlFvTNSx73bOtA?=
 =?us-ascii?Q?PLBUz8pXKzFgD/H6ITvdRyownObwHksl4McZHkvP0k9ZJg+OWVE9R7+C5oX0?=
 =?us-ascii?Q?zuLYxyxROcGu1FYSNur78Gswi4t5J5i8/Z6QGNUeisPEwlI7V3RNFbxFZ1Bc?=
 =?us-ascii?Q?TUtUSCW07GhRxkoF3O7IgIy5/wDQHCLZerXlDzF1MML6NWBiV0mFK2F+yfvv?=
 =?us-ascii?Q?Qxxt5zmm1jRjZLS9rWuo?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37a8d3a1-6486-4766-ecf4-08dd3f2d6018
X-MS-Exchange-CrossTenant-AuthSource: AM6PR03MB5080.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2025 23:50:27.7160
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR03MB6209

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


