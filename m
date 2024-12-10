Return-Path: <linux-fsdevel+bounces-36939-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 891C49EB2B0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Dec 2024 15:07:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1FA0F188E4B6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Dec 2024 14:05:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6F641AAA15;
	Tue, 10 Dec 2024 14:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="G8mmumlr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05olkn2096.outbound.protection.outlook.com [40.92.91.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E1581AA1D9;
	Tue, 10 Dec 2024 14:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.91.96
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733839498; cv=fail; b=X7knvkN931kxWN7F24D1e4aWChRjsuSZllZIOF+2o+pzvN1AyhhskvI5srLQwif5Isc3MPKBy6tEIEKqdGvzhbIEDWmL564HqcpDFOygl3M9MAq8/HuouaULW75eRKmwOUD7GqbBqdr4Ba+x/dM+ikrswR634CPXqRynf60n5DU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733839498; c=relaxed/simple;
	bh=+nRoNWzsUxOYQ7IeJVDM9/oq6X3M7yuf73NdPtR48oc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=s6ackNoS9dU1xGYISgSHhN2vFW5de+tsgB50wLmi0CJ0gCf2Uw65w1/DJz7lfNG/g7fKkpGxjXt/YgO8ywOPGmU+X/uPGfZXX3ZF+DTZ2+zS2pyZ/jL+Q7643k2Pgtzc/lLau6lZF4BmRnwXkL2I0DpxwXZFELNqys/l4/cNgnc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=G8mmumlr; arc=fail smtp.client-ip=40.92.91.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pp5/s+opSpg+4ybsi/nd9MVRPTSRctB2CHDtd1g/YP8PEP+SPDWWbvFEW1Ya/bIFCq3fjHMNKHlPuwJF+mLDs/XkZbrXSnLoaOVuxqlFH1VIgFJnda9m87F0BDLxubFIU1KsRi3NSADHCWCxcPdq5lj86PE1E7Hy8VrVCiM9MIoY55Qp0x9yrKBr+KE1Fqc23hb7FjU0XjVCvArb0KIjIV9fB0PbYlypUiIQ1p8YChsJzu6FGhJdSt2IH2rdc53LOVByfp4uHxy0Qd3+Q5w+HU2WygINREh2D0DqNmTIV0ny32LjsD68xq86V/jC1mqDCU/xcI7GxXKsbuzJ9kcIpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Oua7KwJZiSn+X+T1BbtP3eluryriam8DpXTssfquqIU=;
 b=ME3DXhlUrWvbWANVqTqHACn4Nil6P2KQ1EASnjUnrhElJH3iWXgW6uo+qN4iPbTCacJkGWmYYtqbeMIvOyf+FjCAAn0WwtCiy/yvNpLXtqT0QpcxJNBwGZtl7XhD8ZJDw7tV61u5tGPG1yKWjk6P5eIzJDgM8Vc4YEvObbOz51mzVlw3AEhxwwzbJiQ0p0r2kCg4PmNI77zKAAM05iRlUmi23Snw7IKYCGOKSXlAeMfaKIPxUJ3I3RjumUvQb8+8RXXv+eMRpnLszUbiyrS6R5QtpvgCkxHpi4v5LoZfDE0NnRW6ZHNwfFPn3ruH+R+rLPiG/OtDssactPw3SfK94Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Oua7KwJZiSn+X+T1BbtP3eluryriam8DpXTssfquqIU=;
 b=G8mmumlrI9C772zXfIC4oIJHNDqM0V4E/QElT/nOtiuLF3rPv2eImalZPmYrvSsjJUysKCf17mmi0DpXSqBEULKUJ0Lcr6sUtUWoLjKV7Y0zUlFxY2694hT+rnhA47VYDtyghI8cUjZBk3gTOODBQRJVuElVMOEdPMkedwZe3cZK9nmqCs/DqFnX8vvGe9zJNhY96ET1IS6ZLD+H/JWbitZe0+XPNfReJs35ezW+TAU0TzQ7mQux6GAPW24Q2q4DmYu5iqgB+EB7ry8O5FBU8vPRpgW/Z/WiBFqUNzOqXs5WIjxGbWNnMDI+BgBMPqCxN+2MISLrZiWD+hLJIbguVA==
Received: from AM6PR03MB5080.eurprd03.prod.outlook.com (2603:10a6:20b:90::20)
 by DB3PR0302MB9037.eurprd03.prod.outlook.com (2603:10a6:10:439::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.18; Tue, 10 Dec
 2024 14:04:51 +0000
Received: from AM6PR03MB5080.eurprd03.prod.outlook.com
 ([fe80::a16:9eb8:6868:f6d8]) by AM6PR03MB5080.eurprd03.prod.outlook.com
 ([fe80::a16:9eb8:6868:f6d8%5]) with mapi id 15.20.8230.016; Tue, 10 Dec 2024
 14:04:51 +0000
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
Subject: [PATCH bpf-next v5 1/5] bpf: Introduce task_file open-coded iterator kfuncs
Date: Tue, 10 Dec 2024 14:03:50 +0000
Message-ID:
 <AM6PR03MB508062DC62ABC2290C70EF71993D2@AM6PR03MB5080.eurprd03.prod.outlook.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <AM6PR03MB508010982C37DF735B1EAA0E993D2@AM6PR03MB5080.eurprd03.prod.outlook.com>
References: <AM6PR03MB508010982C37DF735B1EAA0E993D2@AM6PR03MB5080.eurprd03.prod.outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO6P265CA0010.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:339::7) To AM6PR03MB5080.eurprd03.prod.outlook.com
 (2603:10a6:20b:90::20)
X-Microsoft-Original-Message-ID:
 <20241210140354.25560-1-juntong.deng@outlook.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR03MB5080:EE_|DB3PR0302MB9037:EE_
X-MS-Office365-Filtering-Correlation-Id: 69f5a801-540e-40b2-8bc3-08dd19239d03
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199028|5072599009|8060799006|15080799006|19110799003|440099028|3412199025;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?WLVL2kNtnXLQaYazXkye+XQsDkcGM8mJ37Z/cfJYjgr/7Qg6gahqy6cl4Zor?=
 =?us-ascii?Q?6cguKwpYIdt4tkHm8t8KcXFUELRptH7NYJoUeVzMmbOBlzkDRlA9zY6wj9aS?=
 =?us-ascii?Q?NZXCCe3d/EkMy4F2DkqdRSPBErFQQ2sZVsYuJ42zDgDnG2Y0Q8Gn2kpaK+ez?=
 =?us-ascii?Q?Y1B1jNspv/FfWmKYH8n6LbOGuL/d3+HtWgYX4euZFL59AkHnknMZ7tXyEkeN?=
 =?us-ascii?Q?xrT8ghbLIKzv1JNh0iKkHQ7GIXlwdcdenIw8yQ0X2gJlFZvWdEcw7xxUpBx9?=
 =?us-ascii?Q?ljv2W0Q2qE1o7W0idLb8FL1yVGnw/vi3mUTJaJ+L6jW0cSIC4hxU+ra72gD/?=
 =?us-ascii?Q?9KaH0ztd46cxr9knxmq9DkNwAInmE3Cv6LrkqosGRvESMqT0sRc5msAQxEVo?=
 =?us-ascii?Q?YxVP26jfDo4tTMDw0g/or/vRDt5F/ErkQV+aUoordUuyrVNkwuueK9xQ8Phs?=
 =?us-ascii?Q?SXe6/+S4RSMSrt2+ngan460iBOGzjaLwFQKRkKH3+UQ8gRafWWPuMnHwp5RI?=
 =?us-ascii?Q?/jF5HmPAqIEpGQxJAGStyIPHoo9nAyrkR29CI9lmo2n5Dt2qyzVMGE5XRUAG?=
 =?us-ascii?Q?WjwbtyjcK1XrrwkfrGAjw+8no07t61+4MRZmVH6kHSqpXQbwyg0tGCl83Vn9?=
 =?us-ascii?Q?b+vwHAg8QU6Cn47zOrfUng59Z7KjsKcYIXFeQ2md6EqrwRGc2CQJRiH7Kjri?=
 =?us-ascii?Q?06zlYLbrQXpCanfHazWM64+VSqhwbjNC3gDcjaZbmtBUPOot+cRpiN1hJqi5?=
 =?us-ascii?Q?evDQ5LYSeTQVNhavp1It1UydYqD2QuX4Jv9kkIESztZy1zNl7IM6UMZHc4/J?=
 =?us-ascii?Q?d6lirBSVx/GjoGwUE37ihSMdkfb+hm3nIRk0GiD7KlRr2Pb2UgMKpwgwnYHd?=
 =?us-ascii?Q?aoct2MDrNvE5ZWkhdS7m99QySZYmJYvQLKaPFjVgigwzb8kc/FjcGMqziaIT?=
 =?us-ascii?Q?TjUHRtKSuCXQjdU/AoWu/EpXLcx2lMlI5v76/o06FZuOb1FjxGLMAVTvIRcU?=
 =?us-ascii?Q?JgbYEYT8wZ1R+mBb0JYpoUDldw=3D=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?TOC0D0frW9hQf4nhOZDDog3saun0uBYuYp0qp+4dIG9IKAXcs/3oGRQQyWle?=
 =?us-ascii?Q?37vZ2+kOHx5V9xOa3eeZx7NyJ2aD1uzD023I05hpYZgLkrUo15pqUGOZNQU5?=
 =?us-ascii?Q?lfvZKw4rX6+9Fq1R3xla54XSvGGjQ7J1MXb7u6bHzI4zZWLFKi8KzY/Qa61G?=
 =?us-ascii?Q?4rCK0Y08AxQHMzK2G/Xt0X/d870vmF/cDgWv67MnQps5znwYBEpBvw+uQnKl?=
 =?us-ascii?Q?Fu4imxNj4B3jtHiVB032bJdKIdpLgQW+1vmfngG2XwIGmR75f6w1X+W8CkvR?=
 =?us-ascii?Q?T6vhxqLRPgLTG+kYXStOviJJJ7XLMcwiKTCeqaZKd5VwX7WPwRedE4+MgOuA?=
 =?us-ascii?Q?D7BIPWL+Oc/NRqRn8lBGQryBG8bKIg7HNhM54+heF7NDxbYCgrDQyWlpEwtt?=
 =?us-ascii?Q?iCAVxknoWPvcNbp6rd0LlwG/u3nPVgfwJMHLO65pYZiQN71qgAyvfOxv7HIL?=
 =?us-ascii?Q?RT9joRDNs/vGzqrMF3yQxxcnw1Vmx9vNVytXVMNK8yVXMYDkZ84hI0OwzNR3?=
 =?us-ascii?Q?RzSULSVlsXMWzR10+OyP7X7vZiEAcb1aboGROCiUCPo3AF9AY3m/oqIF7Y5p?=
 =?us-ascii?Q?COgWbI/O3IxV1ck8LV/JoSuHf/HRlnQRFXOx4JA8DMIDHYjPDaIe1N6ur314?=
 =?us-ascii?Q?L7MM7Qx5E5eTkxeyS6h1GSNeA1mUHfgITuWcTwT70xZESZxO0SDEINC742l6?=
 =?us-ascii?Q?nKFUR3QrmfhynJPRK8eZU9cKQ9kfJO+3gVwf9qEvvUCNkR5xQwGvBQUe2zF+?=
 =?us-ascii?Q?mdgiqmpJxoJ3Dq+lFVOK28ykRfiAKWxygfYQR1TsnVn0o2K/k9RePEmntVVa?=
 =?us-ascii?Q?DghaPNDU84yp/3RCtW0DmVwNkwyx3x1805MbRZ05GLGZ1OynH8YQjybQ3tQA?=
 =?us-ascii?Q?15etEWMm94nZu8F1P8XxQQwNw+UFP1silpG84YNne6edHlyAFxttj8yCq+VR?=
 =?us-ascii?Q?AJ09XrFS5AXLRy1+e5c4nKHkObtXT6H4tEaZLyjpltl5Drq3QB49r/9EAi8L?=
 =?us-ascii?Q?BwP6ifu5IoTuRoKUFqUqqbI6xHY80xwP20pYZwsgkrBuTnVQatcc3y4tzayC?=
 =?us-ascii?Q?2LGhxoCFyCuQSxiM/z6+eK9UrH15oXrsgn89heFK8Ia5sR/W8XUA5dUEbWrk?=
 =?us-ascii?Q?qobOYnhODr6/74HSLFznFRuX6jVJv1jqeC8/EqRzQAHRGH4IFOsYkz0Ne1pp?=
 =?us-ascii?Q?jIGItnyEW+uWkZHfjAp7mXZ2x2Vna995KDh3lZgzPk3LS5vu3hEFMGll2G3O?=
 =?us-ascii?Q?9wzeLDw1601aBhy3DQRR?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69f5a801-540e-40b2-8bc3-08dd19239d03
X-MS-Exchange-CrossTenant-AuthSource: AM6PR03MB5080.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2024 14:04:50.8964
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0302MB9037

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
index 532ea74d4850..b2a73b49d1a9 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -3145,6 +3145,9 @@ BTF_ID_FLAGS(func, bpf_iter_css_destroy, KF_ITER_DESTROY)
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
index 98d9b4c0daff..133eacbff92a 100644
--- a/kernel/bpf/task_iter.c
+++ b/kernel/bpf/task_iter.c
@@ -1027,6 +1027,98 @@ __bpf_kfunc void bpf_iter_task_destroy(struct bpf_iter_task *it)
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
+}
+
 __bpf_kfunc_end_defs();
 
 DEFINE_PER_CPU(struct mmap_unlock_irq_work, mmap_unlock_work);
-- 
2.39.5


