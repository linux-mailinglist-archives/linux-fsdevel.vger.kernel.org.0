Return-Path: <linux-fsdevel+bounces-3488-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DF1A87F5254
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Nov 2023 22:13:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 947162819A5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Nov 2023 21:13:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBA0E1BDCB;
	Wed, 22 Nov 2023 21:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CvLkIMDk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE3D81732;
	Wed, 22 Nov 2023 13:12:38 -0800 (PST)
Received: by mail-il1-x143.google.com with SMTP id e9e14a558f8ab-359d27f6d46so675435ab.3;
        Wed, 22 Nov 2023 13:12:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700687558; x=1701292358; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nj0/yLijkUDdchJx9f8WaqM9fNxYMjAKFnMHDPEdLR0=;
        b=CvLkIMDkDzteeQ6Ts+K4t3f+w6WGRk2D658wVs0Lj9UFMwobPY0HwrMsnMkXfyh3S9
         VfilVD4qVHokHaRvnYM+cfsfPHXM0UKBl+S6ieVvv2BDzEWzmjo/8hqU9iffVFFi5WAt
         aX7QSfHXZWk5DBtsznxyMK47zYlulIPdgiY118oPBGWruuB1GMRLogc3boldj1f8MMbd
         QQJP9BwFKPKeUAsmkEF4J++KwT7cFA0Ol0bdjmpLM6cDl7DbKlEPls1CYBkG2qSkswVe
         g0Oz1Q35EkfceH9oFKpgdUZ/EUtwUaNlqyp9Hr/geiEwMpjnYQHn6PntfhiGXVq4+Wg+
         bD1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700687558; x=1701292358;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nj0/yLijkUDdchJx9f8WaqM9fNxYMjAKFnMHDPEdLR0=;
        b=MAZ2goqW4hMq6r9Qcpm+XCKoIiqUIiLtUj8mVwEPWJDgQmU8WS8sgZ9DLX2t7oC0jW
         wUd+eAwHNNoNKsLGIn9QD8+CxYE9eoXymZ+T6i1rzYURaygBJZnNfBjR9O8JaRJlrTYE
         DlzFkcurlb+hSTdryPfFBMUaYzh4++ZOLhpsH3hJi4q/Ot0ClUFsFxsWlkDBNabQEh4+
         3ILdX8qeGVvZAoqAUPDDpdQyQlq9+nCJqkgFtVirAzBKAKyI8V9QD1xIYJXTab8AdNGS
         QcAhuQXSm88JS4AbLx0PU8LKBkv60B2HQ00qOLSwXJnRD24omp2YRoup6w1gP5Vve0Wa
         g7Ug==
X-Gm-Message-State: AOJu0Yy7Y18iohcUp0gv2YRtwWCUFBZ9cMx7GeOD+fm/q8Z+lgEVyz4G
	WPAA61Ogf3zWDS2wqrlS5Hz1N0Wfo8BX
X-Google-Smtp-Source: AGHT+IGWypkgJaNcLXjK/eS64ds6ElauQ9WWQUmh33zgk8yVZiSbJ9XTKd3ElRdp4RxU4lnDOSLTsw==
X-Received: by 2002:a05:6e02:1c84:b0:350:f51b:c32e with SMTP id w4-20020a056e021c8400b00350f51bc32emr4817949ill.16.1700687558122;
        Wed, 22 Nov 2023 13:12:38 -0800 (PST)
Received: from fedora.mshome.net ([75.167.214.230])
        by smtp.gmail.com with ESMTPSA id j18-20020a635512000000b005bdbce6818esm132136pgb.30.2023.11.22.13.12.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Nov 2023 13:12:37 -0800 (PST)
From: Gregory Price <gourry.memverge@gmail.com>
X-Google-Original-From: Gregory Price <gregory.price@memverge.com>
To: linux-mm@kvack.org
Cc: linux-doc@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-api@vger.kernel.org,
	linux-arch@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	arnd@arndb.de,
	tglx@linutronix.de,
	luto@kernel.org,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	hpa@zytor.com,
	mhocko@kernel.org,
	tj@kernel.org,
	ying.huang@intel.com,
	Gregory Price <gregory.price@memverge.com>
Subject: [RFC PATCH 11/11] fs/proc: Add mempolicy attribute to allow read/write of task mempolicy
Date: Wed, 22 Nov 2023 16:12:00 -0500
Message-Id: <20231122211200.31620-12-gregory.price@memverge.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20231122211200.31620-1-gregory.price@memverge.com>
References: <20231122211200.31620-1-gregory.price@memverge.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Expose mempolicy via procfs, and utilize the existing mpol_parse_str
format to allow external tasks to change the policies of another task.

mpol_parse_str format:
	<mode>[=<flags>][:<nodelist>]

valid settings:
  "prefer"	(without a nodemask, aliases to 'local')
  "prefer:node"
  "interleave:nodelist"
  "local"
  "default"
  "prefer (many):nodelist"
  "bind:nodelist"

flags are either "=static" or "=relative", and cannot be used with
"prefer" or "local"  ("prefer=flag:nodelist" is valid).

Signed-off-by: Gregory Price <gregory.price@memverge.com>
---
 fs/proc/Makefile    |   1 +
 fs/proc/base.c      |   1 +
 fs/proc/internal.h  |   1 +
 fs/proc/mempolicy.c | 117 ++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 120 insertions(+)
 create mode 100644 fs/proc/mempolicy.c

diff --git a/fs/proc/Makefile b/fs/proc/Makefile
index bd08616ed8ba..272d22d9022f 100644
--- a/fs/proc/Makefile
+++ b/fs/proc/Makefile
@@ -27,6 +27,7 @@ proc-y	+= softirqs.o
 proc-y	+= namespaces.o
 proc-y	+= self.o
 proc-y	+= thread_self.o
+proc-y	+= mempolicy.o
 proc-$(CONFIG_PROC_SYSCTL)	+= proc_sysctl.o
 proc-$(CONFIG_NET)		+= proc_net.o
 proc-$(CONFIG_PROC_KCORE)	+= kcore.o
diff --git a/fs/proc/base.c b/fs/proc/base.c
index dd31e3b6bf77..3eb3d6d81a8e 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -3279,6 +3279,7 @@ static const struct pid_entry tgid_base_stuff[] = {
 	REG("maps",       S_IRUGO, proc_pid_maps_operations),
 #ifdef CONFIG_NUMA
 	REG("numa_maps",  S_IRUGO, proc_pid_numa_maps_operations),
+	REG("mempolicy",  S_IRUSR|S_IWUSR, proc_mempolicy_operations),
 #endif
 	REG("mem",        S_IRUSR|S_IWUSR, proc_mem_operations),
 	LNK("cwd",        proc_cwd_link),
diff --git a/fs/proc/internal.h b/fs/proc/internal.h
index 9a8f32f21ff5..e8e81629a8d8 100644
--- a/fs/proc/internal.h
+++ b/fs/proc/internal.h
@@ -303,6 +303,7 @@ extern const struct file_operations proc_pid_smaps_operations;
 extern const struct file_operations proc_pid_smaps_rollup_operations;
 extern const struct file_operations proc_clear_refs_operations;
 extern const struct file_operations proc_pagemap_operations;
+extern const struct file_operations proc_mempolicy_operations;
 
 extern unsigned long task_vsize(struct mm_struct *);
 extern unsigned long task_statm(struct mm_struct *,
diff --git a/fs/proc/mempolicy.c b/fs/proc/mempolicy.c
new file mode 100644
index 000000000000..417c2c8046d9
--- /dev/null
+++ b/fs/proc/mempolicy.c
@@ -0,0 +1,117 @@
+// SPDX-License-Identifier: GPL-2.0
+#ifdef CONFIG_NUMA
+#include <linux/fs.h>
+#include <linux/proc_fs.h>
+#include <linux/sched.h>
+#include <linux/mempolicy.h>
+#include <linux/uaccess.h>
+#include <linux/nodemask.h>
+
+#include "internal.h"
+
+#define MPOL_STR_SIZE 4096
+static ssize_t mempolicy_read_proc(struct file *file, char __user *buf,
+		size_t count, loff_t *ppos)
+{
+	struct task_struct *task;
+	struct mempolicy *policy;
+	char *buffer;
+	ssize_t rv = 0;
+	size_t outlen;
+
+	buffer = kzalloc(MPOL_STR_SIZE, GFP_KERNEL);
+	if (!buffer)
+		return -ENOMEM;
+
+	task = get_proc_task(file_inode(file));
+	if (!task) {
+		rv = -ESRCH;
+		goto freebuf;
+	}
+
+	task_lock(task);
+	policy = get_task_policy(task);
+	mpol_get(policy);
+	task_unlock(task);
+
+	if (!policy)
+		goto out;
+
+	mpol_to_str(buffer, MPOL_STR_SIZE, policy);
+
+	buffer[MPOL_STR_SIZE-1] = '\0';
+	outlen = strlen(buffer);
+	if (outlen < MPOL_STR_SIZE - 1) {
+		buffer[outlen] = '\n';
+		buffer[outlen + 1] = '\0';
+		outlen++;
+	}
+	rv = simple_read_from_buffer(buf, count, ppos, buffer, outlen);
+	mpol_put(policy);
+out:
+	put_task_struct(task);
+freebuf:
+	kfree(buffer);
+	return rv;
+}
+
+static ssize_t mempolicy_write_proc(struct file *file, const char __user *buf,
+				    size_t count, loff_t *ppos)
+{
+	struct task_struct *task;
+	struct mempolicy *new_policy = NULL;
+	char *mempolicy_str, *nl;
+	nodemask_t nodes;
+	int err;
+
+	mempolicy_str = kmalloc(count + 1, GFP_KERNEL);
+	if (!mempolicy_str)
+		return -ENOMEM;
+
+	if (copy_from_user(mempolicy_str, buf, count)) {
+		kfree(mempolicy_str);
+		return -EFAULT;
+	}
+	mempolicy_str[count] = '\0';
+
+	/* strip new line characters for simplicity of handling by parser */
+	nl = strchr(mempolicy_str, '\n');
+	if (nl)
+		*nl = '\0';
+	nl = strchr(mempolicy_str, '\r');
+	if (nl)
+		*nl = '\0';
+
+	err = mpol_parse_str(mempolicy_str, &new_policy);
+	if (err) {
+		kfree(mempolicy_str);
+		return err;
+	}
+
+	/* If no error and no policy, it was 'default', clear node list */
+	if (new_policy)
+		nodes = new_policy->nodes;
+	else
+		nodes_clear(nodes);
+
+	task = get_proc_task(file_inode(file));
+	if (!task) {
+		mpol_put(new_policy);
+		kfree(mempolicy_str);
+		return -ESRCH;
+	}
+
+	err = replace_mempolicy(task, new_policy, &nodes);
+
+	put_task_struct(task);
+	kfree(mempolicy_str);
+
+	return err ? err : count;
+}
+
+const struct file_operations proc_mempolicy_operations = {
+	.read = mempolicy_read_proc,
+	.write = mempolicy_write_proc,
+	.llseek = noop_llseek,
+};
+#endif /* CONFIG_NUMA */
-- 
2.39.1


