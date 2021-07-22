Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 906F83D2107
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jul 2021 11:38:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231406AbhGVI6J (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 22 Jul 2021 04:58:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231280AbhGVI6J (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 22 Jul 2021 04:58:09 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 095CAC061575;
        Thu, 22 Jul 2021 02:38:45 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id n11so3811074plc.2;
        Thu, 22 Jul 2021 02:38:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=f1tJJWsNPHtyLHNkjYc8ShNPedoFW/MJWzFqp9S/91w=;
        b=B7f+or+TDrkCSwBhquaRkJnVlXzRiPzhjVZKT6H4pC9Uji8jM1Wv9kqqB9wyhEVsM1
         35O+q0km0e+c2lSlCF97LN9J+ataibov+Ghn58k5OQ2rG89hlkPhiuHqWau7uEGMUjNz
         SWWK9RKKPp1bQqX2GE/YoA8TTriF+Crd/UVJbPWPdnKRYTox32OHYUP1FvVUlReWSNzk
         hwPCAjQgdUh1sUHCqad0dU4VVwqmMng0+K3MeDAd2nrdFc3J3K21YpoF8AktZODlpvqs
         5HhfBRz3K8hxxUEfkCKEUCT6HWHprqmtKprsLViWfb3Pph9RK/3DGryXEpsG3YdS4lCH
         XsEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=f1tJJWsNPHtyLHNkjYc8ShNPedoFW/MJWzFqp9S/91w=;
        b=OSEOFX71PcFiir9yevpn6FGYJ05g1Wnp6L0TnLTSRynp52ErCeo3SXlF2/RCtPotcm
         ul28E1auIo9/x4ESfj00cgvLiaQWrMEcuG+F7DjpCElWfI60ia3x7sxdXPJwCLRYLSh8
         JnHfi4imGH3ZlDW6urY3JkCs4OS5elGaZv8gB+FTuOL555Guko1FMhOobrKRHm9UPAwz
         Giizt0eWGywQDDJA/ugTuUH8UA5KRGB5yDRs0+oPcGfBbkJG4NiQvSzNiq9TXERaodLu
         zdRzG++saE6UI/8Xs5IgKM5QBS2WdqmO8h+cw2IQ9RsJ3XE+cQganSMIwx4j6LPCUkVk
         O81w==
X-Gm-Message-State: AOAM531y14GgS6AxnGqmWCV+EveHNQsqLtOZSytkxqjYipE//jnMxfWd
        /LY4uIjW9GPrwKI/8VeDhlo=
X-Google-Smtp-Source: ABdhPJxykY9eDhoHQsUCZgEum2owRP78F/EENYqKC7XDWiCPlHpJhqz1U82H5G/bjzGccdHpK4bmHw==
X-Received: by 2002:a17:90a:fb86:: with SMTP id cp6mr8357408pjb.211.1626946724513;
        Thu, 22 Jul 2021 02:38:44 -0700 (PDT)
Received: from VM-0-3-centos.localdomain ([101.32.213.191])
        by smtp.gmail.com with ESMTPSA id m1sm14208741pfc.36.2021.07.22.02.38.42
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 22 Jul 2021 02:38:43 -0700 (PDT)
From:   brookxu <brookxu.cn@gmail.com>
To:     viro@zeniv.linux.org.uk, tj@kernel.org, lizefan.x@bytedance.com,
        hannes@cmpxchg.org
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        cgroups@vger.kernel.org
Subject: [RFC PATCH 1/3] misc_cgroup: add support for nofile limit
Date:   Thu, 22 Jul 2021 17:38:38 +0800
Message-Id: <4775e8d187920399403b296f8bb11bd687688671.1626946231.git.brookxu@tencent.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Chunguang Xu <brookxu@tencent.com>

Since the global open files are limited, in order to avoid the
abnormal behavior of some containers from generating too many
files, causing other containers to be unavailable, we need to
limit the open files of some containers.

Signed-off-by: Chunguang Xu <brookxu@tencent.com>
---
 fs/file_table.c             | 25 +++++++++++++++++++++++--
 include/linux/fs.h          |  4 +++-
 include/linux/misc_cgroup.h |  1 +
 kernel/cgroup/misc.c        |  1 +
 4 files changed, 28 insertions(+), 3 deletions(-)

diff --git a/fs/file_table.c b/fs/file_table.c
index 45437f8e1003..a7848a4cac19 100644
--- a/fs/file_table.c
+++ b/fs/file_table.c
@@ -29,6 +29,7 @@
 #include <linux/swap.h>
 
 #include <linux/atomic.h>
+#include <linux/misc_cgroup.h>
 
 #include "internal.h"
 
@@ -53,8 +54,14 @@ static void file_free_rcu(struct rcu_head *head)
 static inline void file_free(struct file *f)
 {
 	security_file_free(f);
-	if (!(f->f_mode & FMODE_NOACCOUNT))
+	if (!(f->f_mode & FMODE_NOACCOUNT)) {
+		struct misc_cg *misc_cg = css_misc(f->f_css);
+
+		misc_cg_uncharge(MISC_CG_RES_NOFILE, misc_cg, 1);
+		put_misc_cg(misc_cg);
+
 		percpu_counter_dec(&nr_files);
+	}
 	call_rcu(&f->f_u.fu_rcuhead, file_free_rcu);
 }
 
@@ -148,8 +155,20 @@ struct file *alloc_empty_file(int flags, const struct cred *cred)
 	}
 
 	f = __alloc_file(flags, cred);
-	if (!IS_ERR(f))
+	if (!IS_ERR(f)) {
+		struct misc_cg *misc_cg = get_current_misc_cg();
+		int ret;
+
+		ret = misc_cg_try_charge(MISC_CG_RES_NOFILE, misc_cg, 1);
+		if (ret < 0) {
+			put_misc_cg(misc_cg);
+			file_free(f);
+			goto out;
+		}
+
 		percpu_counter_inc(&nr_files);
+		f->f_css = &misc_cg->css;
+	}
 
 	return f;
 
@@ -159,6 +178,7 @@ struct file *alloc_empty_file(int flags, const struct cred *cred)
 		pr_info("VFS: file-max limit %lu reached\n", get_max_files());
 		old_max = get_nr_files();
 	}
+ out:
 	return ERR_PTR(-ENFILE);
 }
 
@@ -397,4 +417,5 @@ void __init files_maxfiles_init(void)
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

