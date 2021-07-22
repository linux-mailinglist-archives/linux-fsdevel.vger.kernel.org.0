Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21EFD3D268C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jul 2021 17:21:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232619AbhGVOlF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 22 Jul 2021 10:41:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232616AbhGVOkO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 22 Jul 2021 10:40:14 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52AD8C061760;
        Thu, 22 Jul 2021 08:20:24 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id q13so3885652plx.7;
        Thu, 22 Jul 2021 08:20:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=nKxDmYGABfohxuLPargQrpGLtl0A5Dtlbr1nooTegnQ=;
        b=h6zrYKfCi1QSIzifwVkE7CUsQr1UndXBaiqyHaBpdyxXY0wJ1YhxH3BMVzvT6CZmtp
         8bkLzFD/Gi5zkPzY2wdY0b0WxpLSLnFDccOf3hqiE1hk9PmDJgT/xjg3oBdUkTIbrFpW
         Ri3+1WQ7beOC6hsFBHAf1xh4f5xIjDyXJocNC58mZ3gk634oHfq0Oyc+r3gB0137Ifhs
         U/q1ao8boXFw7SgU89Sx2YSBj//JenOdNZ+W5qa4yeJ5lKobUmfSyUvVzTZMyQooitW7
         j5EvBh/9CtDymXx4S+49VPJA1qhUqOe4CucENeWME11G6WHv19KuoY33RLnNwts1ALfy
         vIcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=nKxDmYGABfohxuLPargQrpGLtl0A5Dtlbr1nooTegnQ=;
        b=ts4H2HDpnHb6621IMMCEXgfsLPZnXDFSPbdcjVBkIKb7z6YJRTFA4D1pvPvBVcBX/0
         vJpHGnaDRU60tgiPykOE0FRvkNajEik3Zwq3nAhjkFbHn4cZ+PECBf2bgikZV6rnnoat
         5oq1CXvf673zLMwlFOd/nzeNjxObaCSuT3oB7I7vDqDDG12qVsMFjjRPOZoObdQGvzB1
         Y76s4y4JGcOQuBl0Oc01grR+6h6WsIspC0AsDlvpjYOR71pCWhocpOeJGJt7fns9O49G
         j8INSMJ7R/BccUukTkP3o57/m6O+TytJdhMijHZqy/2kepuSKpBsTaXtxAQ4bocJaUEZ
         XJpw==
X-Gm-Message-State: AOAM533WA7Ptld/NBZfobSUr/AdqpB4f0z+bOfEMi2TlAwg2bfql7ykt
        Mavy4cOS1f+EunNx9gnciRQ=
X-Google-Smtp-Source: ABdhPJynUglnoTqx2b3U+Jmd3z13zKTgqg7hfMNFT99PXfOeXXdvMHYWyOk35UOj8hXjL7dchrbG8w==
X-Received: by 2002:a17:902:7005:b029:12b:9b9f:c463 with SMTP id y5-20020a1709027005b029012b9b9fc463mr117766plk.76.1626967223931;
        Thu, 22 Jul 2021 08:20:23 -0700 (PDT)
Received: from VM-0-3-centos.localdomain ([101.32.213.191])
        by smtp.gmail.com with ESMTPSA id 11sm30768663pfl.41.2021.07.22.08.20.22
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 22 Jul 2021 08:20:23 -0700 (PDT)
From:   brookxu <brookxu.cn@gmail.com>
To:     viro@zeniv.linux.org.uk, tj@kernel.org, lizefan.x@bytedance.com,
        hannes@cmpxchg.org
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        cgroups@vger.kernel.org
Subject: [RFC PATCH v2 2/3] misc_cgroup: add failcnt counter
Date:   Thu, 22 Jul 2021 23:20:18 +0800
Message-Id: <5aed58ba0147169ab26b1403fe135df4f77b8492.1626966339.git.brookxu@tencent.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <3fd94563b4949ffbfe10e7d18ac1df3852b103a6.1626966339.git.brookxu@tencent.com>
References: <3fd94563b4949ffbfe10e7d18ac1df3852b103a6.1626966339.git.brookxu@tencent.com>
In-Reply-To: <3fd94563b4949ffbfe10e7d18ac1df3852b103a6.1626966339.git.brookxu@tencent.com>
References: <3fd94563b4949ffbfe10e7d18ac1df3852b103a6.1626966339.git.brookxu@tencent.com>
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

