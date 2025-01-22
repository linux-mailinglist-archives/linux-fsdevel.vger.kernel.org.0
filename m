Return-Path: <linux-fsdevel+bounces-39879-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A839A19B59
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Jan 2025 00:09:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 564EE7A2B15
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Jan 2025 23:08:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FC9B1CEAC6;
	Wed, 22 Jan 2025 23:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="PDlS2AFR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03olkn2032.outbound.protection.outlook.com [40.92.59.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6E111CBEAC;
	Wed, 22 Jan 2025 23:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.59.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737587325; cv=fail; b=cAfEu5qU/lVGkBaiDCAcXTE7FXwESLI54o/hap8yAbyOOBZshdLYoaBdIR7UTOUCwNVuUGU77+BuZY6cBBnS4NsJJ4H/ZRKfckR+ZAN7dsYn8qmbXCBhgYWbDKRWuMNPOdJQv1umgNzCfzalgXHJLOUBO7Tmf51oxal+4k/FMgs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737587325; c=relaxed/simple;
	bh=KIxnMIr3pjygOZQfnbAT4gl8laW2esmTBi9+dragCrw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Jv8z1XXnAMcmUePtcB3XvQctmuF7QxS9LSafHdjwlAitMC307TORVuY+oKK4FumdlGgDPSR0ML64XCw8FjQZBYt/Dlu20+HBGyBzO7YbPOhERVqnK5SSirpUUKn307wwgJNVH8ZnplarAqFIwvnVsqEJPu8bbiwuBmD3bLh3hNA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=PDlS2AFR; arc=fail smtp.client-ip=40.92.59.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=czWtzbtDz1PzEPrSPaF4QouZ1kNikK5Ns4f5HUcgM0mTpKdhKj6UjC3+KMbpLLwgxMKksTqkBdW0DAVcEh+N5IWL4igVud1fB5/7fM4swP3KPLP8J6hRaeJVi0NIRukjjwMnG+klWPA0jBhhM48ocSg4KvlcsRdanD/UtPkGoGHkQjo+72L0wnrpNNszbTP0QQ8SqP41oST7PB5EvXXQtARufzXiCU+8hpQAc/Z8hloph085dCeXnaWE8/VIOBEyblPGk6GkOXCLOVLZtqbuQXKOetDD9Yi99umT7OAKr5BRYMsoq5gDyfwSVFpSNZKXNlsdKqhajykV21QYR7Hq7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QRVV0jX1KjzggGbvz87UhS2xPIc9n8VFZ0MWXdCk1fc=;
 b=M9d6O6MeeSG/5QPu61oXjvh7VNViwNPaqzZb6RI6fWNgFE8+gUyNydIavpA79w5s260Xm2MKSonjyx9wsjYLgYdkZoS2wota9UCHORaeKRzoCDXY8P6K43GEezJNQOUp4urYdKz+vXrsdAApsaUdF4y5YqNbFEzegdPK5mz/P3J/ioZuf9xI+3JrAFyuiUkUcEuE7KQiijp7vhXCk1EdJgYVS4+UqgI+Q+1lYYBwx9zdIErGrTOfDTR51HiooJT628ttm8+bj3SUhTk8a/50NNd5X5hVU2AKGKOXcgZldlgFMg3Y0rNNKpKc3+D7As5gjP0nbeJhrER3bgNR8BlC3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QRVV0jX1KjzggGbvz87UhS2xPIc9n8VFZ0MWXdCk1fc=;
 b=PDlS2AFRuF+cTOpsc6/7pYVU/SBX495ccoppTq/JSR2/UdmSCosm0AHCSGjyEkDJH5IykhxCwDqfzt6W5DY5bYXtNtyMDzyWWWwdMypHn6w+CzDD+szDm1JHWL/pu/hndaGOzGy7lTmcIt/mM07XgGTKO7Lslv4Tws5mMfCxQ5AnBfMib8cfoUJDwddw/O8SV2jtF+4fLmmQljkKmbERHXA43CGL5ZR0UPct3mMStuRsyqo0+oMEGKMcQlsf94SAd8K3qQVTxZ8wbtOTcvee6NCPz75xCzQUkmgD+ZvMhuWLIyAHdFepeFASFECTTZItg/dR2UG1ikEjzgeqJHO9ZQ==
Received: from AM6PR03MB5080.eurprd03.prod.outlook.com (2603:10a6:20b:90::20)
 by DU2PR03MB7958.eurprd03.prod.outlook.com (2603:10a6:10:2d9::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.10; Wed, 22 Jan
 2025 23:08:36 +0000
Received: from AM6PR03MB5080.eurprd03.prod.outlook.com
 ([fe80::a16:9eb8:6868:f6d8]) by AM6PR03MB5080.eurprd03.prod.outlook.com
 ([fe80::a16:9eb8:6868:f6d8%3]) with mapi id 15.20.8356.020; Wed, 22 Jan 2025
 23:08:35 +0000
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
Subject: [PATCH bpf-next v8 3/5] bpf: Add bpf_fget_task() kfunc
Date: Wed, 22 Jan 2025 23:04:49 +0000
Message-ID:
 <AM6PR03MB5080CC1369D4605011FD231799E12@AM6PR03MB5080.eurprd03.prod.outlook.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <AM6PR03MB50806D2E13B3C81B0ECDB5B299E12@AM6PR03MB5080.eurprd03.prod.outlook.com>
References: <AM6PR03MB50806D2E13B3C81B0ECDB5B299E12@AM6PR03MB5080.eurprd03.prod.outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P123CA0049.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1::13) To AM6PR03MB5080.eurprd03.prod.outlook.com
 (2603:10a6:20b:90::20)
X-Microsoft-Original-Message-ID:
 <20250122230451.35719-3-juntong.deng@outlook.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR03MB5080:EE_|DU2PR03MB7958:EE_
X-MS-Office365-Filtering-Correlation-Id: 13f42be9-6ae3-4f8e-48bf-08dd3b39b2ac
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199028|8060799006|5072599009|15080799006|19110799003|440099028|3412199025|41001999003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?2mV+7tvyK8goVsMbWfI/3e5VKriH0ZvyDkUeTzM+Z0aq7XR56+PIlixx066L?=
 =?us-ascii?Q?z6WITpHdlhxRY61hBh+CE3F7pD7mexrer8n2rDI06DJOl4wtzAe4uf0Hl2ii?=
 =?us-ascii?Q?oejg/b313wmCj2dKtR0/vgqyGQXlGqYxXKRr5YUtVUKATyvHRvlu4oNNVeln?=
 =?us-ascii?Q?V0ughlbeLNzKlMH6vezFaLNoz1ecyB1OEn7Tg3anFdakljch59s8X2A3pl5u?=
 =?us-ascii?Q?nYQO2WdIp14adV29X1q+B+SUuBSMxmCkxRGMYcEvPC0XM3UKEgTL4QykN2fG?=
 =?us-ascii?Q?NV0loNIL6S+vUOvgg9TKSnoroCK5B4Ref8savB7NkqGVv8ZXS1uV4cTU/Ivz?=
 =?us-ascii?Q?30Vv8+Kg8sFsSe8DMuWzxyIsjGAFpcU0QfQFFzDC3LN4B+8BTwJ4YsNjukev?=
 =?us-ascii?Q?Rvpb+8iVzXTxKr7l2z5NysGc+1xT4ugOaDSjsWbYtNbvTzYt8IcArQlgNysU?=
 =?us-ascii?Q?pE9oS2XABQK283IjXxAGROotDZlLaBlJZoN9qcXTY0zksfYxm5b35BE7oUQl?=
 =?us-ascii?Q?MStRgBXWdKe5Jf44zE2k9a6kJaiF8Mq685pyBc0zVxDW5JiZhK/6k/B3dFHB?=
 =?us-ascii?Q?7KD4zGJCvjhW/uEk2Px3A3cDQVCtD3yYFrBLe7YSqH5OjjM1Anxnjg1y4ToQ?=
 =?us-ascii?Q?PFRvjIGo67U05d++GtiXoGd5Ptz0rjQVKymh9U1kGIb1L945EBOkxDMXFXeS?=
 =?us-ascii?Q?7apWI79G9dHTQs39hxSUxszhhEHCyCoT3r1em6Gp/Ofbl21JGxtpsQxOP7XN?=
 =?us-ascii?Q?JQJr/MTEo1571ly3Lu6z7O9La/a3qN/u5cEKJwGxJazLN7bN0cOSBhvGFXjJ?=
 =?us-ascii?Q?zZfA1AIwuM2j24Z9CX8fu2XgT5qfoQI0gfSBECHjIP9yE6qbGEgorNLg0g8R?=
 =?us-ascii?Q?4LwRgDPaSqIkfG/5pq+rJNWsu4OvTgSEkVjex8HAOGkPxFoCGQurZgnT57fZ?=
 =?us-ascii?Q?2M4TcV/b0auNpGf28NrvXeiocwQJMAQXj2KXD8FHQoBMr0Sszzvmszgw4dqN?=
 =?us-ascii?Q?+t2lowUxfs0Emi+l3JTfvgWYQLbuLx04mOkXsNpDcMJ0T56wSYjkY0KKP2vJ?=
 =?us-ascii?Q?OC9AbOqTE8eXa1i2QULrQZ2JpLPeEw=3D=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6OTetoLG8J1IyU0yDAL3amnwUhikA3RoSp9bnna96i7oXcdcgRDIsg5Tv36o?=
 =?us-ascii?Q?qE8D8RVFU5jdf7OY2yv6FZW+C4GYhZdSuM29U60NNs3lM3BIi5w7SvSw0LJx?=
 =?us-ascii?Q?lryIfy2EeJROhtksdX7c/iJIqqSfuRnbo9KhnoguN+HVQRZLXLauPK3VFmQx?=
 =?us-ascii?Q?mUbVxfEEvJO1J/F7EbDK/U6RfNI1Dt76D4i2VuAIaah4wDcjOXe1MFfHIgdi?=
 =?us-ascii?Q?9uGxkOsacFaG4JQ0ogPgYmjByaGnhYzACwWnIoA5Hj5xQFGsO5c6HM3hfFI1?=
 =?us-ascii?Q?Y/F3oiPxBdJP1PtI7KeZWbcJ1nR0tZRmGmAtobqZJs7x6SuZuOYPlTCaeiuq?=
 =?us-ascii?Q?cwJoexFI0xrXfpKBcFw32oOJfQfjQkP1WPK45OmF+ImXghq3ao5WyWBzuwci?=
 =?us-ascii?Q?1zLIOsU3zJfOtDsC4tn4t983SNt8O0eRedRRjNnEBxbiCkx/YFPen9Q3TZ0S?=
 =?us-ascii?Q?IzuzpERy6DFBzVA/neXprZ5dkdYBnyJgJP7HsyOjGeXBbEetNIyQ2fOMK2qT?=
 =?us-ascii?Q?0hrNta1KYlt7kdyXUlKF5t1hqZwqK/ZmYU8G1YKYN8Dt6c8siivy4kAqxHNh?=
 =?us-ascii?Q?T5f8pUA8imV+CE6G58KIz6LYX0NnCty8y0X1p4bDlQjNakTeTupJBZuAl2xv?=
 =?us-ascii?Q?J+m5Wv29zbn3VmR+oGo5NEl02DB4gA8Kz2nOgOVmx09IYa+BxCoq3Vf4Xgjq?=
 =?us-ascii?Q?eHivxx4u5e6MrkAT47mg8QzNo0z0THIZ5iWm/pe0v8d4VoWVIlNxE0FoQ6YT?=
 =?us-ascii?Q?PedDpVu2uIMj98AckmLjBfwK9W5IHcrgQe15pi/YvwRszhj+XLW5/RVVyyop?=
 =?us-ascii?Q?9q1rsOYsWHJ3dAWvhgT7dZiASlheAkXaRdxJVS7cja4/Yg45aFrYaZWIhtlC?=
 =?us-ascii?Q?EZzLdsSAZemNKpPd2XDYsNWAS/ohpR71jxpC6Gm+dF8CD67YeRQTplcJxyU8?=
 =?us-ascii?Q?Xmwd2inXOpzCb15/goQU/R/Cy1wqeK4U0ywa1bRVMQva4aZ3d0EhRdDNB9jd?=
 =?us-ascii?Q?CxBGD4tL/Lyz3zmPCChpKNU91erM8Axr5fB3j4hU724yn27xCHqnYnbmDR0O?=
 =?us-ascii?Q?ZQ18S2DLPralQH1hIgHMH75VeWeNewR2kWfUCOzMd3kyFenUXWJ97pM6qNpV?=
 =?us-ascii?Q?0DTCf/VVvx/hS6FeSQRiOKB2Bqw1rLo8/tkQdGDpwl8TdEVg9U+vfdIyg5Os?=
 =?us-ascii?Q?dTi+zRB2Wfik1i9f4gYwOJfNFobhE/RYq9syiYcA8suNa11yHqTJafcQLJiI?=
 =?us-ascii?Q?KIPNEv96OrXOK/irmJlL?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13f42be9-6ae3-4f8e-48bf-08dd3b39b2ac
X-MS-Exchange-CrossTenant-AuthSource: AM6PR03MB5080.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2025 23:08:35.5991
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR03MB7958

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


