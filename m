Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 105453D268F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jul 2021 17:21:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232648AbhGVOlH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 22 Jul 2021 10:41:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232620AbhGVOkP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 22 Jul 2021 10:40:15 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C155CC061757;
        Thu, 22 Jul 2021 08:20:22 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id i16-20020a17090acf90b02901736d9d2218so5985678pju.1;
        Thu, 22 Jul 2021 08:20:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=dcmUigRFaKaUGLQ8hPJNePWalGpdmF9/PmKs/DMnFfs=;
        b=AvId1PeFmONSOPW86UAvvUln0l2s3+ibt9wUhp3/0CAzqmHEppIRVnUjPGhTvTS5bB
         ksubKtFnhPrJgaSFMOYoJfRP0BLxxz+u9XomRSiOtIG1qyAeB1ItJmGZ+qBNxlpBb7Zo
         kM+qN+GliyXzrSwqfctZznjlNVT/y0uscX1DWG0ePfsp9JS/JAUsJlrKsWIYRjf4UUbT
         8OKuzDUUtxkyS9tT13HrPcjTv2JoPyL3qYNXzjlYvCq5fSrjPjFsg/dxAyR6HJTK9Qx/
         QU7UGYhKi71GRa2VkRCQ0IFXsP3plfzp5uJL0VpvtYMyEoV/Fqpq+xLW7neo8wqN1njD
         v2yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=dcmUigRFaKaUGLQ8hPJNePWalGpdmF9/PmKs/DMnFfs=;
        b=MoMWogbRqDl83hmQdPEiENUWv+IpX9cNtVkAv4vkujfDSum4E0T0cqTjBl7x4oYh70
         6krbAEnSsIrwtwUjG6uIvPLF4ibrrhFVnjBvHZzc37nAA9RTLLnH12KG5knCAH0aVzY9
         ge+QDDapTjldQma9XPDeQu13kE4ffDiWuDgvGBaVA8qESL9Oni5oZMHdlFMZi9G91leS
         5Jp61w13kylPK+BoJNAj+RurG4IHy2GU/VKyW1CrXyBJNARZJSgA7a6kfEKMJD33gbmv
         6iIuzrI+Jn4PRv05PMTgS1RJiCBvIdpzX8Cegm7n0BTMdwI+vDG6Jg8TACzd9Hje2EyP
         BycQ==
X-Gm-Message-State: AOAM532sZRQtQ6b7Q3P+mhrM2TB89vKeZZmFcYKOGGBdInO1JNBjkE2f
        dlTjJmHGztH/Y0b+GYwomM3tpl03t8/dpg==
X-Google-Smtp-Source: ABdhPJzyGTPSRCYDexUXivv9U9ci/H14qAtcJL5ddN027Yx7Tr/76igW7lmGo7GD6X2JJcpl31AEDw==
X-Received: by 2002:aa7:8ed0:0:b029:357:9c8:d13 with SMTP id b16-20020aa78ed00000b029035709c80d13mr238924pfr.10.1626967222204;
        Thu, 22 Jul 2021 08:20:22 -0700 (PDT)
Received: from VM-0-3-centos.localdomain ([101.32.213.191])
        by smtp.gmail.com with ESMTPSA id 11sm30768663pfl.41.2021.07.22.08.20.20
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 22 Jul 2021 08:20:21 -0700 (PDT)
From:   brookxu <brookxu.cn@gmail.com>
To:     viro@zeniv.linux.org.uk, tj@kernel.org, lizefan.x@bytedance.com,
        hannes@cmpxchg.org
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        cgroups@vger.kernel.org
Subject: [RFC PATCH v2 1/3] misc_cgroup: add support for nofile limit
Date:   Thu, 22 Jul 2021 23:20:17 +0800
Message-Id: <3fd94563b4949ffbfe10e7d18ac1df3852b103a6.1626966339.git.brookxu@tencent.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Chunguang Xu <brookxu@tencent.com>

Since the global open files are limited, in order to avoid the
abnormal behavior of some containers from generating too many
files, causing other containers to be unavailable, we need to
limit the open files of some containers.

v2: fix compile error while CONFIG_CGROUP_MISC not set.

Signed-off-by: Chunguang Xu <brookxu@tencent.com>
Reported-by: kernel test robot <lkp@intel.com>
---
 fs/file_table.c             | 28 ++++++++++++++++++++++++++--
 include/linux/fs.h          |  4 +++-
 include/linux/misc_cgroup.h |  1 +
 kernel/cgroup/misc.c        |  1 +
 4 files changed, 31 insertions(+), 3 deletions(-)

diff --git a/fs/file_table.c b/fs/file_table.c
index 45437f8e1003..5957b2de9701 100644
--- a/fs/file_table.c
+++ b/fs/file_table.c
@@ -29,6 +29,7 @@
 #include <linux/swap.h>
 
 #include <linux/atomic.h>
+#include <linux/misc_cgroup.h>
 
 #include "internal.h"
 
@@ -53,8 +54,16 @@ static void file_free_rcu(struct rcu_head *head)
 static inline void file_free(struct file *f)
 {
 	security_file_free(f);
-	if (!(f->f_mode & FMODE_NOACCOUNT))
+	if (!(f->f_mode & FMODE_NOACCOUNT)) {
+#ifdef CONFIG_CGROUP_MISC
+		struct misc_cg *misc_cg = css_misc(f->f_css);
+
+		misc_cg_uncharge(MISC_CG_RES_NOFILE, misc_cg, 1);
+		put_misc_cg(misc_cg);
+#endif
+
 		percpu_counter_dec(&nr_files);
+	}
 	call_rcu(&f->f_u.fu_rcuhead, file_free_rcu);
 }
 
@@ -148,8 +157,22 @@ struct file *alloc_empty_file(int flags, const struct cred *cred)
 	}
 
 	f = __alloc_file(flags, cred);
-	if (!IS_ERR(f))
+	if (!IS_ERR(f)) {
+#ifdef CONFIG_CGROUP_MISC
+		struct misc_cg *misc_cg = get_current_misc_cg();
+		int ret;
+
+		ret = misc_cg_try_charge(MISC_CG_RES_NOFILE, misc_cg, 1);
+		if (ret < 0) {
+			file_free(f);
+			put_misc_cg(misc_cg);
+			return ERR_PTR(-ENFILE);
+		}
+		f->f_css = &misc_cg->css;
+#endif
+
 		percpu_counter_inc(&nr_files);
+	}
 
 	return f;
 
@@ -397,4 +420,5 @@ void __init files_maxfiles_init(void)
 	n = ((nr_pages - memreserve) * (PAGE_SIZE / 1024)) / 10;
 
 	files_stat.max_files = max_t(unsigned long, n, NR_FILE);
+	misc_cg_set_capacity(MISC_CG_RES_NOFILE, files_stat.max_files);
 }
diff --git a/include/linux/fs.h b/include/linux/fs.h
index fad6663cd1b0..9ef3dd579ed6 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -947,7 +947,9 @@ struct file {
 #endif
 	/* needed for tty driver, and maybe others */
 	void			*private_data;
-
+#ifdef CONFIG_CGROUP_MISC
+	struct cgroup_subsys_state *f_css;
+#endif
 #ifdef CONFIG_EPOLL
 	/* Used by fs/eventpoll.c to link all the hooks to this file */
 	struct hlist_head	*f_ep;
diff --git a/include/linux/misc_cgroup.h b/include/linux/misc_cgroup.h
index da2367e2ac1e..8450a5e66de0 100644
--- a/include/linux/misc_cgroup.h
+++ b/include/linux/misc_cgroup.h
@@ -18,6 +18,7 @@ enum misc_res_type {
 	/* AMD SEV-ES ASIDs resource */
 	MISC_CG_RES_SEV_ES,
 #endif
+	MISC_CG_RES_NOFILE,
 	MISC_CG_RES_TYPES
 };
 
diff --git a/kernel/cgroup/misc.c b/kernel/cgroup/misc.c
index ec02d963cad1..5d51b8eeece6 100644
--- a/kernel/cgroup/misc.c
+++ b/kernel/cgroup/misc.c
@@ -24,6 +24,7 @@ static const char *const misc_res_name[] = {
 	/* AMD SEV-ES ASIDs resource */
 	"sev_es",
 #endif
+	"nofile"
 };
 
 /* Root misc cgroup */
-- 
2.30.0

