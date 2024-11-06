Return-Path: <linux-fsdevel+bounces-33821-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28CF49BF779
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Nov 2024 20:49:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9B412815A3
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Nov 2024 19:49:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72261210180;
	Wed,  6 Nov 2024 19:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="JtdMU+H5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05olkn2043.outbound.protection.outlook.com [40.92.90.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB0E320FA96;
	Wed,  6 Nov 2024 19:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.90.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730922066; cv=fail; b=b4f8hORG0CchMjEKYh4TeKzhn7zFw2DrpvzhHigKke/7DKlW22f6roXw8BE0CxHBMitwsyWoAhp8IjF+WJGIICgzTef5HBtHYNv8b9L7BDNmG+B3gzqKYfnx24LmzKZ1c+fhyT78JOSZCWgPR+7b9rbjKkLfgw9E5GOm3MzYFZc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730922066; c=relaxed/simple;
	bh=ChFHYJSmtb1Af0VsHQB0kNLIRsq6RI/GToZk/efCpTQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YxdH7bA11iNrBAIvyyTERqtZcYMjRCoEuC+4+YVCfd7mKVf9zySa5XWQbaU0EOFqwDLYG3uYmNAvyo3yg/Yi/y6lBHTUXhSOinNNDvHdEsBMs7gt4VQXbu4ep3yJAsF0FDRfDS5dSNx6zFyyk+fwPN5ammnAAIrCdTOVBer4cDg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=JtdMU+H5; arc=fail smtp.client-ip=40.92.90.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Dgzacpo8QSZIaoU6bb7kxnl3bkYSA9FHuP2wYLC8vMKYK7fs6XXz8wvqGE0hmzFmS/X11ZCYdiQmASSzacMm3M6cVWuI/2vzW4M9B9zg77ohFtYf4fdpd4P/57g6V6wrb8ZZ/753Ser8nPzThGE8oVLgAEr+U7r1mQNiSQjvkPcaX37n2JvqAwFGebYpEfoF6YLlRam70qHRjet6Gxvni4U6X3QdIItD5QuvN4hYS/YrvdWXgrDXaZ/Os9xnTBFf4a77JXHLS1aZjxbD9dk9Hu5ufrsbmsd2spoWj6X/o1mcLo7bCSXamgyfYPkqiBCFFlmzlicXkGWdrYrVEznrig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L+EPXcAd3NsboONqndjrNljlrQs3hawE6sVQwYnwiMY=;
 b=W4JWSLuSd6c23dMWl62ExUEnHmWpdSiHf72tn9A/jINUiqAuUwHk0U04jeZr3OtcFAfHVC98+PSZxKY2f46hbsIPCGuIKucmHl97h9kCIs+0I9hnscq3aTikpCjxgbwMp/e1SoMyTa1TBMa3RHXMT0lcm1EJcfsD3GRzYZM8+J6ex6QIYnot9XhaOK/f62pE6616SmV198Au2rOfFWOeNv9XgS/0xeofMMmrtl2A1Ew63ySI9M7vAbhHZXcuM5P8bdZ5RY3XAuBVQGnkLy5xTKEHms23YOzvdIfRZggt1wVxNzJXx+8bsLLVOTQQeOBcyYCmnNqUvcZHqjYwux3R/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L+EPXcAd3NsboONqndjrNljlrQs3hawE6sVQwYnwiMY=;
 b=JtdMU+H5w/v6mmSGmFPhsVe/8g9JBmMbCgjCR8L8+5ewJpi+/mniBYPfb2g6KuYGiSaWJ8/sv3thsm4xqjyFzi4FeWpE3AtwxOax3yxbW2DZOuhzajkZbehlNQC3VHxzvvKzfFYqRF8heMVbBVhqIGbx1neiZHIxYSu8jq/jTpIDj46DOoctbT0BrbttA5IrVVjXkIsjJ9Kgb1lS9zhllo2a4NJiHI6HjmEi8LRvvAL/RFX4FfsCIT8wgmf/MN9VhLeBfkzsftejPRqzBCeMgHq6ClMOjtQwehfP1hNgWl+l7CTJWFN8Zy7B+1fOz9qSL8RIjhDiAJhsmAKjZHAHcg==
Received: from AM6PR03MB5848.eurprd03.prod.outlook.com (2603:10a6:20b:e4::10)
 by AS2PR03MB9792.eurprd03.prod.outlook.com (2603:10a6:20b:608::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.18; Wed, 6 Nov
 2024 19:41:02 +0000
Received: from AM6PR03MB5848.eurprd03.prod.outlook.com
 ([fe80::4b97:bbdb:e0ac:6f7]) by AM6PR03MB5848.eurprd03.prod.outlook.com
 ([fe80::4b97:bbdb:e0ac:6f7%4]) with mapi id 15.20.8093.027; Wed, 6 Nov 2024
 19:41:02 +0000
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
Subject: [PATCH bpf-next v3 3/4] bpf/crib: Add struct file related CRIB kfuncs
Date: Wed,  6 Nov 2024 19:38:47 +0000
Message-ID:
 <AM6PR03MB584840534BA4A82407DFB50D99532@AM6PR03MB5848.eurprd03.prod.outlook.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <AM6PR03MB58488FD29EB0D0B89D52AABB99532@AM6PR03MB5848.eurprd03.prod.outlook.com>
References: <AM6PR03MB58488FD29EB0D0B89D52AABB99532@AM6PR03MB5848.eurprd03.prod.outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P265CA0280.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:37a::17) To AM6PR03MB5848.eurprd03.prod.outlook.com
 (2603:10a6:20b:e4::10)
X-Microsoft-Original-Message-ID:
 <20241106193848.160447-3-juntong.deng@outlook.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR03MB5848:EE_|AS2PR03MB9792:EE_
X-MS-Office365-Filtering-Correlation-Id: 6293b83d-ba6d-47a2-76bc-08dcfe9af224
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199028|15080799006|19110799003|5072599009|8060799006|3412199025|440099028;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?GDjU5pyLYQb1BkKjo6wTCz1NMIo+PW6GoUEvJS/8cROQNO1rFsf1Mv7zy+bN?=
 =?us-ascii?Q?8Ym+7SOQnCo7hKLXnstBj1oiv7mmoW0Za9V7x7K+J3totrXiCiTnI1NZhYaC?=
 =?us-ascii?Q?vFd4C2w5NtwtswmLO4zZCHNtINoj97rvWxwGBBlHvqxcnoRgop5yYF5Nq85h?=
 =?us-ascii?Q?IXd4H7PmJsPPkguv29FV00ejkxBuWZSQZR4oAhNXwhozHbSbNs6cpLAysi9j?=
 =?us-ascii?Q?ttPrBqJwI1M2XgRuNX4oVg+2yW60HMsiEAqaPwME3EucTN+oz9yGy4N4Nr6M?=
 =?us-ascii?Q?bpKUOGgfttK5wxb5n3DeuBMR+NrXIh+q98QeKAAGQ4rCRGtjtiRqDAbv14Np?=
 =?us-ascii?Q?hTGy6Gm9+pIXDbZoy7zj9PPcRcV9qJmyLV65Jj0SAwlM/M5mA6QS9Fzg2Ke9?=
 =?us-ascii?Q?egcz/DckitJtD5LSy6apUUtWM5gZSzzoGLvPJvdyqW2O63SWQLy40HGz9rnL?=
 =?us-ascii?Q?RtwaKWT/CoCeUT8V+wrDS1MWTYhHyCLg9MAIDYfdn2m2a+hvNU3m7GQqYnlW?=
 =?us-ascii?Q?1dfJ8jW6olTKXX/aELuGXvzZvMcufsNQg1IQL+d6OoV/oD1YmEZZga+jR2a8?=
 =?us-ascii?Q?ooRdpEiNoYK3gPADW0vC6+HcGva7Km0aau1wfabKyz8Y2xlf9FM1M4/K7sDZ?=
 =?us-ascii?Q?twcZ+zmrwN+v5qB0mbxzthVNf6mg7TgcRbLe4DwRZHMgHMuynI9PkxIIQbrG?=
 =?us-ascii?Q?hV9b0kqY2Rk7rgOm0rriTSR/5eDQQ3npbwd0O4ZikAURym8kyT5AxsyErEhJ?=
 =?us-ascii?Q?1qTVMphFaDLSBnHLeRftIA0QNc1U/mV0rgSV5ryUD7HXoH1I+8y7gTDxooa7?=
 =?us-ascii?Q?uMFEcFCigGvjwCSxc+q9JeXc2+AZzTo9ewh3FP6cGn6w697el6znUjoCNfTT?=
 =?us-ascii?Q?giPOOeOHKwYAsm3VL7ubhtNmfKOonIMyoJ6psl+9jZPQuyeOADAAvQOFQV9L?=
 =?us-ascii?Q?juz0L0k5weEV1/AqILS9T52e5ZTQUO8oEvtkIDSSmsCTas71kNaFlbre0uOr?=
 =?us-ascii?Q?ySCfjTMkIE54UAtJtvQ6RY/eXQ=3D=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?lzv3pzoQOnrceHwG0ndXdE5xVdQK2J239WSsiAPl4Hi7Kvt1+oioJeiaOT+H?=
 =?us-ascii?Q?Aihxkg1uJlQ1fqqC5pVekdveJMr/jSpF84QX6/0OyTqvRI/qrmGlSW70I9HW?=
 =?us-ascii?Q?MKVwgKIdezqy3WWlEFlETjntML7404ISxQhRYiilzHYn7eK7TR70HaokWJ41?=
 =?us-ascii?Q?9XT3HYjM5VdwQjSv3SDQzrRH/oTO+otdkwwoxnhuhcCJkyDgvr1PqtWWzTo9?=
 =?us-ascii?Q?fH3awKSmee67s1Ag9Yau1zbjzkOpJR8XYmlkU/SlmfTr5H6jomeAMKk+loQK?=
 =?us-ascii?Q?CiKdcWBNb0p+hdWKq9Y7z0/gTZSGMJLZONCOCXnqg0o8QDNvRLmpYZoUcix1?=
 =?us-ascii?Q?O02qw8aJyypEZmuIqOmPVxJLP4KYjwDLwYEYVeadAvm7jQBe3HyW2ZWyFECV?=
 =?us-ascii?Q?PCTugfb9+/jYcb8O+IR40993S4jTemog8vDTXEgZhCzTn4K71h8HjVyo9aCc?=
 =?us-ascii?Q?U+rk/xzF5cKNZh+/yTvMoHFQovgroJqGPQsrizyZHQX7MFLkP5MYF0ZG2YwZ?=
 =?us-ascii?Q?I5W4NSrs1Vc8XEmi+11ojL5oqNiGsw0E3+lVb5WyU6pFxuSaUkHN0H1qpsIZ?=
 =?us-ascii?Q?T+0aWUS5rRJcr6kG/XUwc6rXOAMa4hDn+8xxgkVZmekFozaAJzfau27xRB/a?=
 =?us-ascii?Q?Nm9Xd/cSTciTBj8ogDmRDNEHGJUn9uMOWIVMR0Vloh4saxWc5iWJQG/GIuoh?=
 =?us-ascii?Q?ocMH/Aggx4aUhsb8/2e5OqNZdu3mWpNlIHjzmABIOdVVYKoLCr7Vk4twC79P?=
 =?us-ascii?Q?NdEdmTdCrA+XMPxYHPvTs7jF26WXK5/EWGZxWm0DcVwwgQX0mmRq5mDF6g2F?=
 =?us-ascii?Q?g92/Nib/p9u4u+xCd5YOD3hulQ427lKfCTNrtv1jmfZzh0tMX1WR5zgf8hIr?=
 =?us-ascii?Q?md6pBqLYzRKWfiUtfAIBstFeoGv6R1/I39AYdLKEfSLo7ghb8w692js1+1tn?=
 =?us-ascii?Q?aPsRdOeGBzuauq5bIPaFEQjGzhevuqYypk/mMPkDzLbkSxleBLFU45OZn8VN?=
 =?us-ascii?Q?cS38SU09mJ6CTjZEu7zutLxBPY9MZia3fk/guUSTFdyfX+/I+S7lDE9oRYn7?=
 =?us-ascii?Q?qsCabTHZT0SfDYsgXpe/Ufs5kUMM5IEBaipEgdhqOGzlCrXry190rTGbZu6+?=
 =?us-ascii?Q?qjxV2zdLgBFDZUFyAC9BhSWvWxnU0ZlxoAvIV53wIZViVl8C5gN7kubV6aad?=
 =?us-ascii?Q?n51fSOEkfpzpIYcaiSp6nicISW0u8P0NNNDdG21apJThJTeLwPzUz8HUyP6i?=
 =?us-ascii?Q?dYU7lmFtL/hZHS4YM19m?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6293b83d-ba6d-47a2-76bc-08dcfe9af224
X-MS-Exchange-CrossTenant-AuthSource: AM6PR03MB5848.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2024 19:41:02.2937
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR03MB9792

This patch adds struct file related CRIB kfuncs.

bpf_fget_task() is used to get a pointer to the struct file
corresponding to the task file descriptor. Note that this function
acquires a reference to struct file.

bpf_get_file_ops_type() is used to determine what exactly this file
is based on the file operations, such as socket, eventfd, timerfd,
pipe, etc, in order to perform different checkpoint/restore processing
for different file types. This function currently has only one return
value, FILE_OPS_UNKNOWN, but will increase with the file types that
CRIB supports for checkpoint/restore.

Since the struct file_operations of most file types are currently
static (e.g., socket_file_ops) and cannot be directly accessed in
crib/files.c, the future plan is to add functions like
is_socket_file_fops() to the corresponding files (e.g., net/socket.c).

Signed-off-by: Juntong Deng <juntong.deng@outlook.com>
---
 kernel/bpf/Makefile      |  1 +
 kernel/bpf/crib/Makefile |  3 +++
 kernel/bpf/crib/crib.c   | 28 +++++++++++++++++++++
 kernel/bpf/crib/files.c  | 54 ++++++++++++++++++++++++++++++++++++++++
 4 files changed, 86 insertions(+)
 create mode 100644 kernel/bpf/crib/Makefile
 create mode 100644 kernel/bpf/crib/crib.c
 create mode 100644 kernel/bpf/crib/files.c

diff --git a/kernel/bpf/Makefile b/kernel/bpf/Makefile
index 105328f0b9c0..933d36264e5e 100644
--- a/kernel/bpf/Makefile
+++ b/kernel/bpf/Makefile
@@ -53,3 +53,4 @@ obj-$(CONFIG_BPF_SYSCALL) += relo_core.o
 obj-$(CONFIG_BPF_SYSCALL) += btf_iter.o
 obj-$(CONFIG_BPF_SYSCALL) += btf_relocate.o
 obj-$(CONFIG_BPF_SYSCALL) += kmem_cache_iter.o
+obj-$(CONFIG_BPF_SYSCALL) += crib/
diff --git a/kernel/bpf/crib/Makefile b/kernel/bpf/crib/Makefile
new file mode 100644
index 000000000000..4e1bae1972dd
--- /dev/null
+++ b/kernel/bpf/crib/Makefile
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier: GPL-2.0
+
+obj-$(CONFIG_BPF_SYSCALL) += crib.o files.o
diff --git a/kernel/bpf/crib/crib.c b/kernel/bpf/crib/crib.c
new file mode 100644
index 000000000000..e00f4a4f0d42
--- /dev/null
+++ b/kernel/bpf/crib/crib.c
@@ -0,0 +1,28 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Checkpoint/Restore In eBPF (CRIB)
+ */
+
+#include <linux/bpf.h>
+#include <linux/btf.h>
+#include <linux/btf_ids.h>
+
+BTF_KFUNCS_START(bpf_crib_kfuncs)
+
+BTF_ID_FLAGS(func, bpf_fget_task, KF_ACQUIRE | KF_TRUSTED_ARGS | KF_RET_NULL)
+BTF_ID_FLAGS(func, bpf_get_file_ops_type, KF_TRUSTED_ARGS)
+BTF_ID_FLAGS(func, bpf_put_file, KF_RELEASE)
+
+BTF_KFUNCS_END(bpf_crib_kfuncs)
+
+static const struct btf_kfunc_id_set bpf_crib_kfunc_set = {
+	.owner = THIS_MODULE,
+	.set   = &bpf_crib_kfuncs,
+};
+
+static int __init bpf_crib_init(void)
+{
+	return register_btf_kfunc_id_set(BPF_PROG_TYPE_SYSCALL, &bpf_crib_kfunc_set);
+}
+
+late_initcall(bpf_crib_init);
diff --git a/kernel/bpf/crib/files.c b/kernel/bpf/crib/files.c
new file mode 100644
index 000000000000..61201923a35f
--- /dev/null
+++ b/kernel/bpf/crib/files.c
@@ -0,0 +1,54 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/btf.h>
+#include <linux/file.h>
+#include <linux/fdtable.h>
+#include <linux/net.h>
+
+/**
+ * This enum will grow with the file types that CRIB supports for
+ * checkpoint/restore.
+ */
+enum {
+	FILE_OPS_UNKNOWN = 0
+};
+
+__bpf_kfunc_start_defs();
+
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
+	struct file *file;
+
+	file = fget_task(task, fd);
+	return file;
+}
+
+/**
+ * bpf_get_file_ops_type() - Determine what exactly this file is based on
+ * the file operations, such as socket, eventfd, timerfd, pipe, etc
+ *
+ * This function will grow with the file types that CRIB supports for
+ * checkpoint/restore.
+ *
+ * @file: a pointer to the struct file
+ *
+ * @returns the file operations type
+ */
+__bpf_kfunc unsigned int bpf_get_file_ops_type(struct file *file)
+{
+	return FILE_OPS_UNKNOWN;
+}
+
+__bpf_kfunc_end_defs();
-- 
2.39.5


