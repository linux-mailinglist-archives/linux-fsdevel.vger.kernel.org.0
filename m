Return-Path: <linux-fsdevel+bounces-37679-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B67709F5A8E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Dec 2024 00:38:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE7ED1636EE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Dec 2024 23:38:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C63241FA831;
	Tue, 17 Dec 2024 23:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="JJxCgpdT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05olkn2091.outbound.protection.outlook.com [40.92.90.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08A881E489;
	Tue, 17 Dec 2024 23:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.90.91
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734478711; cv=fail; b=IxPmwpqHOaIrLVeHOeTnAbe5+nKRH3KTUXxk/YJEQbKveoCzkO/wuf1C3/yAD2x14+2Fmxw8DJ0UYNsHacNQoqNlUfY1jfkWX/pET+1IdXNqTi1xm70uKVsFYiEsC9t+VHy1oBvP2Wrz9kKeA8CrB3Itx3fusXCHa1qdsMLv+pU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734478711; c=relaxed/simple;
	bh=vEZUKwdceXRJn7QWyvgBDn2Qwv35oHDkljrnPox/JKk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dz2CDeQWXamblEeeKbg+FIVAx1eIfbvD6cbk3shrer5AgaHYc47QExQUI6hcuIXTwenDxwUxj7Rd7ZdJL8B9TeQdO+tCw48EdmH0noTl+bmJiYbDbs1HXEHZigDVr0iQLLZmdBtxU9FdBtOS77KOFEAGlurdM4qsuy09wqh2DG8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=JJxCgpdT; arc=fail smtp.client-ip=40.92.90.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w1Ogg/uCXdfVX6YWNduwDRAk4cVHKbYbp6P6fbnLpz7ZLcCguSAGIpLBx1iLFM7GkOU1ZKfLFL+VavAFfXo3WO6vjmi0Hgu96NDGNeNtFivpW4c/P1ro579hIrP/g1JpeEqa0oHquTZpHoA3OMelJseFgg3mM1Gwf+tyAbiM33ODwmLMk2+yViu1qz32DjhwKHa4u08Oph2AUBI9Ao/pDtQwAkaC/NUqsx6UROWUG5zHUeX2kQKtHH2OhHfZipRMwEqfP/f7ejXmcD92UCqptw/o1iD4Sqb4CUUrEaF5sQrSVYlDyZVHhQF9l3D3TL5Ene1CdAaWSpaIY0Uaj7BOpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lpX9may4ZFhg+0QB0gs5iq3gsgRIQcvjtnbFkTIR2K4=;
 b=DsL0O0jzV/3suZU2A5ByHy5rzFUoaoZ4DCePHECOOX5ZHTvvGgJkC1FBRI51U65bcmgpMz8BTeY/b6NhnqT9ZIL0rAnojwbhZ1ekFy/dl9Zvh1w5duv+hJFx7VbIMuLhF4PUuZWIJQUrUl7i5qEAcJZzpwE6W3nFfMKf1e6+Qtdpa/TY4o+/99SSOdiBWcJo8R+hWW2JfPV13vCLFxRrk31pkjaLm36vfWPmEGGVs5CIuYWADB1ilzDw0NgLAaPDNstE0J2wLXw+vgIEuZNl1Hg3xI3ljCAsWkTW8s8eaQsAYr9pj+gGzMrQ+WHTHIPLPk41CRp2lNZLbzAtcFuJnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lpX9may4ZFhg+0QB0gs5iq3gsgRIQcvjtnbFkTIR2K4=;
 b=JJxCgpdTK/49qysoPR5AjA387oaqlCBTiBSBaV9Z45oW4bHDDy9MzaRPj1C8DuOEOZsqUiUspPcZ9uqVlD/mZogNZyYjvU+D//OZ4lURcwbDv/4RMb/+5VOY2uTg5zR5p+GfZgIWoZY0bTlvvylClzB/Xomwzd4ARmgCDW6b2xXPsBOQsYHcX08XE7BqH9m1XQO4t9CnQY3TjOXmxQGShddOxis4vnNacPmd07yCOiBOt+Mc8W5KUkTQb5UgSqW0r1HY1/sD0keBcdIBBHVMVKuFkn09u870k9V+S9Rs+/CB7GiSKNkflN+BI6v75aTO4cPn1fl0ks0odjqlrz0V5g==
Received: from AM6PR03MB5080.eurprd03.prod.outlook.com (2603:10a6:20b:90::20)
 by VI0PR03MB10927.eurprd03.prod.outlook.com (2603:10a6:800:26b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.21; Tue, 17 Dec
 2024 23:38:25 +0000
Received: from AM6PR03MB5080.eurprd03.prod.outlook.com
 ([fe80::a16:9eb8:6868:f6d8]) by AM6PR03MB5080.eurprd03.prod.outlook.com
 ([fe80::a16:9eb8:6868:f6d8%5]) with mapi id 15.20.8272.005; Tue, 17 Dec 2024
 23:38:24 +0000
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
Subject: [PATCH bpf-next v6 1/5] bpf: Introduce task_file open-coded iterator kfuncs
Date: Tue, 17 Dec 2024 23:37:01 +0000
Message-ID:
 <AM6PR03MB50807D3E0975E184C4D1D0FB99042@AM6PR03MB5080.eurprd03.prod.outlook.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <AM6PR03MB5080DC63013560E26507079E99042@AM6PR03MB5080.eurprd03.prod.outlook.com>
References: <AM6PR03MB5080DC63013560E26507079E99042@AM6PR03MB5080.eurprd03.prod.outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0117.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:192::14) To AM6PR03MB5080.eurprd03.prod.outlook.com
 (2603:10a6:20b:90::20)
X-Microsoft-Original-Message-ID:
 <20241217233705.208089-1-juntong.deng@outlook.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR03MB5080:EE_|VI0PR03MB10927:EE_
X-MS-Office365-Filtering-Correlation-Id: 337f8517-8427-451f-875d-08dd1ef3e640
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|19110799003|8060799006|5072599009|461199028|15080799006|440099028|3412199025;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/4wyIEWJauodKoFmZ8hJ9I/lyj5kCy2BkyLpZkLxSy7qEtuWIZ4Ek7ntT0yg?=
 =?us-ascii?Q?x7UGo7kYya3B4IgNGnR+0crEk1BiiKcCrPfKsv7IyIQ+KT7BsM1DJvfgttbe?=
 =?us-ascii?Q?AQYfdXEeZNgKQeBUkofRA2qo4NhdD2Zh21IjQ+p22uM9lNrhK7OjpJPCjDUJ?=
 =?us-ascii?Q?Vn+fCcnyZaFATSUwPyE4xIYxfpe1oezCO75jRpDFf9e89y3454ZNM09g0moZ?=
 =?us-ascii?Q?EfURL1J19eqGsw2DGCpHxstKnxlilGnmpZcNvjdM1LYU9XAioCGbDONHDRfF?=
 =?us-ascii?Q?VO4bQOo2eEVaVL4PEb+yEcwDkt4rNO/YSRhLutsyxpfOBNluieJp92EvV9/c?=
 =?us-ascii?Q?/G3w3sVEDhhCdcySnoCaiOMZ968ICzQNMuofJbSIj06KVZ197nDmKYzrtAEM?=
 =?us-ascii?Q?DLQbneAlN8BvjGv7HjPny1ncvWwMpDdN3GLuykzHJXeWei4nxpxfKLCp3+In?=
 =?us-ascii?Q?HoZGC1q+EuBuyi2AlQKynIPWxqpsyMjzDrjzEN2cSkyXumQTKYNDWLn7LJcl?=
 =?us-ascii?Q?ri6m6t2M7VXmJSfcJvtgnBWLTUSjYqegQosYqQC0Yc1DghLgiyqssVHPAX9u?=
 =?us-ascii?Q?CLG18AAA4KIarBvxvL9aiX1lIAHoZETAniPVlKN9gpz78UFbgjkhRuXetP0K?=
 =?us-ascii?Q?FmYW+gShdzVi7Q+w4+Ex7Wz0Sx0A1nqhTAWlr7N9sCRd3XIOc9FrgJu7gy+/?=
 =?us-ascii?Q?0FciHJGQwenNVuYRL3BWx5WF9Fe6nc59AH5QDabycxLaOoLpyyMxJ2LtaeKQ?=
 =?us-ascii?Q?+K43xqWijkHXBHCa/vAJn/4616jrEPDMVq+K2iuLi1lnaua5y5hecuUaoQIk?=
 =?us-ascii?Q?kaniDS71g1gfg8UyAmGuQ9z3X+L5ChAKGpP+TieEaBKU/f1cInf9NeebNbFz?=
 =?us-ascii?Q?ZQG5Yk06TP0s4AFjGAC7jMkjbzuGNtlkleQpgb3Pe3nsjgKNqcVAOpbr/sIo?=
 =?us-ascii?Q?FB2kw6500BGSvegClzyd+MP2CFKYZ7o1HBksjG7hYSpyT9vrM6blTFR376Kt?=
 =?us-ascii?Q?CcVtScV2Z+2NSPF4KsVtQZv4qA=3D=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?waT6c6jrAAeqK1pC/bovSUZuQJErdyKt2UPZkQpCAmTBgDI5FoIA5wT9g/Xf?=
 =?us-ascii?Q?Hpxzs/QyvTR3Hm5SYqJXmPvLaB4i+rt/zx8kRaal9NFX5PZpwV+5uwEDRJpC?=
 =?us-ascii?Q?dHNusEziUAz6SR5URBk0kweH2SNvOuiSwIOHQAaLTxI+8qpy7kMjM7OWrEQ7?=
 =?us-ascii?Q?00Fb6NZVivUKuVQ7dGo9phxGahfsmEdWSe/6tEwXqsubWO8nJ+37EoCGriCH?=
 =?us-ascii?Q?6SoyeA9TSMX6fcLlfYKEWrFmNkv4KzxYrsVG6t9Q+VNBqjIGoDHQTz60fdGM?=
 =?us-ascii?Q?jf18ZGMQVjT7lsdnL4sxEXT3TWrr1TfdvrVaAqkbshCUxzxMg/g/ZjjHpq/k?=
 =?us-ascii?Q?u6cBUL/F7DQrTo+m9VX3fb+rA9UqHlSc3GjgV8oift68guZxlu+2XPSLVcD7?=
 =?us-ascii?Q?iO5NVXX/cAvrj2CrQWDYcvZhXBolrrFb0btcdZNDebCT+VBXMP3i+DJRC5RM?=
 =?us-ascii?Q?D+BGF37qTwGs95GbH1ipTe+bFlT27TQwsuqZpNN7SGipFCGIWTVqytwXCUY3?=
 =?us-ascii?Q?66XsKSrSp2i3fyRc3pPfTB9x9uNfbHdz4xUA/Ua+LkPN0l1poMYK+SZwO7sw?=
 =?us-ascii?Q?fNPWjD5BZxGHyjw1l+Ame8vWobMNTiUCQ3elIMWh1NedcDRxrGHeOOVYQGeq?=
 =?us-ascii?Q?1cNO5I8cVxCCXZUbNosyXA6R7hdeUupBzDakCutbY1HX4xwe6+cDQRcto1Td?=
 =?us-ascii?Q?FCNb8+K6jGKZLsXRkJCnXPJKctKJ88wzKfUp6oZW5KzHcpwceuBd9pStoLYf?=
 =?us-ascii?Q?DNpsZWmRyWnPVZQRY9G5thbFjuT3bjc6dcDju34EThWy/uqc4PifbWLWezyn?=
 =?us-ascii?Q?FYBUFdIx/nVO80jUU0ZYjLcqutENz2pdIuLcSbZZWy/7FvApfn/Cj9OvIP71?=
 =?us-ascii?Q?3PuMJB4hsC/tQBjTWHwAzjhtFXZZfCsKdhBX6oS0vEXVczUeDgWWKBfosCVv?=
 =?us-ascii?Q?n4jr//3ynz3qBtAWmZOUfPLU+x3bXUnR0puzRq23c3+SSZzak5/Ywr4PptZZ?=
 =?us-ascii?Q?tHH2B8PGlAAI2PUa4u8HNR8/B8RqjcvLEaf0i9Q7WBDdX35BxQ8jJsMCbbKb?=
 =?us-ascii?Q?w75cBVxeO6B4pLxx7Jy5k33B7APQhmbtJCnXwGYnMx1rxo0vsoMP7FLOSLF3?=
 =?us-ascii?Q?4Z3Qvgil83e3mqztIqSFdplmELn3gI0B+mDmsFjKZKQQxVtJLgy0RP3M/D1X?=
 =?us-ascii?Q?gnJN9ueSMBAfHwit6Ir6FSxCOXS9whDbGam22wyvbkGdgb6WI2kJp6F9v4T1?=
 =?us-ascii?Q?YO7wBhUCaUhV1m9Z74tP?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 337f8517-8427-451f-875d-08dd1ef3e640
X-MS-Exchange-CrossTenant-AuthSource: AM6PR03MB5080.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2024 23:38:24.7806
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR03MB10927

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
 kernel/bpf/task_iter.c | 91 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 94 insertions(+)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index cd5f9884d85b..61a652bea0ba 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -3147,6 +3147,9 @@ BTF_ID_FLAGS(func, bpf_iter_css_destroy, KF_ITER_DESTROY)
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
index 98d9b4c0daff..149a95762f68 100644
--- a/kernel/bpf/task_iter.c
+++ b/kernel/bpf/task_iter.c
@@ -1027,6 +1027,97 @@ __bpf_kfunc void bpf_iter_task_destroy(struct bpf_iter_task *it)
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
+
+	put_task_struct(item->task);
+}
+
 __bpf_kfunc_end_defs();
 
 DEFINE_PER_CPU(struct mmap_unlock_irq_work, mmap_unlock_work);
-- 
2.39.5


