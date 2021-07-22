Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 754673D210A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jul 2021 11:38:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231432AbhGVI6M (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 22 Jul 2021 04:58:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231389AbhGVI6L (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 22 Jul 2021 04:58:11 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80A71C061575;
        Thu, 22 Jul 2021 02:38:46 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id y3so3812133plp.4;
        Thu, 22 Jul 2021 02:38:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=nKxDmYGABfohxuLPargQrpGLtl0A5Dtlbr1nooTegnQ=;
        b=g9utncxrFENx5WtS0n5EfMZODNjhHJhohBuVEnt+qGOu0OyE3OqQcowfdM8xyUql8G
         llqpdWyG0BXOPhxfGJDuJZ1eCXqDwb2OO9I9KTOsIFId161sb/uzzHeZahCJdFXo6D9X
         ERCrepOY8r5oa6/vxNTsH9DA5xwh0Bwjagj6/1sNtTcAOPRaUKP/krpydLlangx0uGx1
         by++XA7z9chJkgk8dx1TK2VQvvS+ulelKEFc/bIUsHQkmZQKFf4GPr6pvDzvEb4x3Jaf
         DWgfxO+DjaQ11C6rp076IG1WiHPyh4rSxwK5gdsUm9u1c5b9ITNiFjlsQCHYdYCioAYc
         wRXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=nKxDmYGABfohxuLPargQrpGLtl0A5Dtlbr1nooTegnQ=;
        b=rigRBzk4AqgBBBykZjg0CquLEIJ8HZ6Sntm7+KoTXBt1UXOfqW1rLQfOpzWahSjvBa
         BpOikdyCxCs410osoSVKIXB9z98wah+G9SvnHmcWuKx1myn0x8U5+Her/A3DDUNZcp+Z
         Cv92YzUkFqifarq5VbFtIWDJoV5L1orzkMGcA/cZDgwQn+2KKWLQyOR1D8N808ja+iBM
         pjv5SvcqdktNtvHlOVIhBaXLKqwKpbJ61wNKI+5xvbtSvxor4zbM+Bo97hSHvv4reSXP
         HOFkzuCqE4fiZCGgeBJ2fjKQSNCp5O4BMmDUHxxhCYmT5mBumHHVLQfe+udZ7MmLVrVK
         dG5w==
X-Gm-Message-State: AOAM533HN2tg9tWEfsqpUb0iEaoxdKImbNKvMBrtckf69exCQkM218ZM
        nyS+PV+4CL4WF0adnqY8ei4=
X-Google-Smtp-Source: ABdhPJw7mj9ouYNsYehCbzd1qrODjGe26E/HEF4O4SvtNAkyHQaf5yqok854HKeBlXM4mMIAAC8j3A==
X-Received: by 2002:a63:3f42:: with SMTP id m63mr11677284pga.33.1626946726171;
        Thu, 22 Jul 2021 02:38:46 -0700 (PDT)
Received: from VM-0-3-centos.localdomain ([101.32.213.191])
        by smtp.gmail.com with ESMTPSA id m1sm14208741pfc.36.2021.07.22.02.38.44
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 22 Jul 2021 02:38:45 -0700 (PDT)
From:   brookxu <brookxu.cn@gmail.com>
To:     viro@zeniv.linux.org.uk, tj@kernel.org, lizefan.x@bytedance.com,
        hannes@cmpxchg.org
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        cgroups@vger.kernel.org
Subject: [RFC PATCH 2/3] misc_cgroup: add failcnt counter
Date:   Thu, 22 Jul 2021 17:38:39 +0800
Message-Id: <cba4e118c342f55097c1fa5c255b26bfb2609590.1626946231.git.brookxu@tencent.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <4775e8d187920399403b296f8bb11bd687688671.1626946231.git.brookxu@tencent.com>
References: <4775e8d187920399403b296f8bb11bd687688671.1626946231.git.brookxu@tencent.com>
In-Reply-To: <4775e8d187920399403b296f8bb11bd687688671.1626946231.git.brookxu@tencent.com>
References: <4775e8d187920399403b296f8bb11bd687688671.1626946231.git.brookxu@tencent.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Chunguang Xu <brookxu@tencent.com>

Instead of printing logs, we should probably track failures through
a failcnt counter, similar to mem_cgroup.

Signed-off-by: Chunguang Xu <brookxu@tencent.com>
---
 include/linux/misc_cgroup.h |  1 +
 kernel/cgroup/misc.c        | 30 ++++++++++++++++++++++++++++++
 2 files changed, 31 insertions(+)

diff --git a/include/linux/misc_cgroup.h b/include/linux/misc_cgroup.h
index 8450a5e66de0..dd1a786f39b8 100644
--- a/include/linux/misc_cgroup.h
+++ b/include/linux/misc_cgroup.h
@@ -37,6 +37,7 @@ struct misc_cg;
 struct misc_res {
 	unsigned long max;
 	atomic_long_t usage;
+	atomic_long_t failcnt;
 	bool failed;
 };
 
diff --git a/kernel/cgroup/misc.c b/kernel/cgroup/misc.c
index 5d51b8eeece6..7c568b619f82 100644
--- a/kernel/cgroup/misc.c
+++ b/kernel/cgroup/misc.c
@@ -165,6 +165,7 @@ int misc_cg_try_charge(enum misc_res_type type, struct misc_cg *cg,
 				pr_cont("\n");
 				res->failed = true;
 			}
+			atomic_long_inc(&res->failcnt);
 			ret = -EBUSY;
 			goto err_charge;
 		}
@@ -312,6 +313,29 @@ static int misc_cg_current_show(struct seq_file *sf, void *v)
 	return 0;
 }
 
+/**
+ * misc_cg_failcnt_show() - Show the fail count of the misc cgroup.
+ * @sf: Interface file
+ * @v: Arguments passed
+ *
+ * Context: Any context.
+ * Return: 0 to denote successful print.
+ */
+static int misc_cg_failcnt_show(struct seq_file *sf, void *v)
+{
+	int i;
+	unsigned long failcnt;
+	struct misc_cg *cg = css_misc(seq_css(sf));
+
+	for (i = 0; i < MISC_CG_RES_TYPES; i++) {
+		failcnt = atomic_long_read(&cg->res[i].failcnt);
+		if (READ_ONCE(misc_res_capacity[i]) || failcnt)
+			seq_printf(sf, "%s %lu\n", misc_res_name[i], failcnt);
+	}
+
+	return 0;
+}
+
 /**
  * misc_cg_capacity_show() - Show the total capacity of misc res on the host.
  * @sf: Interface file
@@ -349,6 +373,11 @@ static struct cftype misc_cg_files[] = {
 		.seq_show = misc_cg_current_show,
 		.flags = CFTYPE_NOT_ON_ROOT,
 	},
+	{
+		.name = "failcnt",
+		.seq_show = misc_cg_failcnt_show,
+		.flags = CFTYPE_NOT_ON_ROOT,
+	},
 	{
 		.name = "capacity",
 		.seq_show = misc_cg_capacity_show,
@@ -383,6 +412,7 @@ misc_cg_alloc(struct cgroup_subsys_state *parent_css)
 	for (i = 0; i < MISC_CG_RES_TYPES; i++) {
 		WRITE_ONCE(cg->res[i].max, MAX_NUM);
 		atomic_long_set(&cg->res[i].usage, 0);
+		atomic_long_set(&cg->res[i].failcnt, 0);
 	}
 
 	return &cg->css;
-- 
2.30.0

