Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EF5A5594FF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Jun 2022 10:11:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230521AbiFXIE6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Jun 2022 04:04:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230326AbiFXIEw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Jun 2022 04:04:52 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5B586DB14;
        Fri, 24 Jun 2022 01:04:51 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id c65so2326836edf.4;
        Fri, 24 Jun 2022 01:04:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6j0Gpi54M48fI1NcNiQ2zQbh0cpYb0wFPGGgMk6DiNo=;
        b=fk1Q8DhcfpcNKxoNpWHiQSY9AE96A9aVxjRhZQQUWDZRdv7jEZGX6hMqBKr6rqq5fy
         9t7SzX2Vl712znvGA8+d7SsV/SLjOuEz8EJqw7KMYQFjdKxhRvkPZZZiwuZ1Mbl3yEfV
         0czXl+5DWtas1YhPkEGvL798aRjcHESclYc/C/XKzSoId3CQoIeGfVhaQ9gE8V4nAnvz
         yPNyik6e47/+4vPDqcfn3WUpjSuAR16t34HQILns5txBmvATmE4OpVbQiTQ3jTbxv/Ju
         QRq5NGdaccxi64UFpJMIIRqRVNhqRxqlSvbkbbvI6sIihwWIzkjAbvWZWMqIO6dN8QxY
         AsDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6j0Gpi54M48fI1NcNiQ2zQbh0cpYb0wFPGGgMk6DiNo=;
        b=7y73GjiB1DXT9pahs2jEX+bK2t3gViVXm1dWT5yal6dPlVNlGgYR3CPYPQRjGOEa9L
         oZstmo8tkTeqZcIoUO5bZXm8niw2+b3EQDnzKSw0WLzkVKdN+jVtZpA87t1zdrms6kdi
         dgExl4mZO619ikOHTD8tpFdAP09IOawwQscnjBaJMkKRYKJJ1vCkNz8HDndABqGoS+IU
         oi1xmA34Eps1V4Bh+/EQNuaI+jxT622UZG+1n8UmFlNqBPoYJHtku0HWggK73CzCFoq+
         Y5F0EaELw4WTMFN5+ijL6UxJblfsGkQpAb17g+6VdwSEGD/En5ZS3THQE8mkAp5GdFhl
         F+kQ==
X-Gm-Message-State: AJIora8/dDCYRgWh7XGg0Yn5hzdWrJoeKXHJDqFLQAxnQda+AsBkfukA
        0QjvtbquEcUqKFSDQBnVokJpRdpn3gI=
X-Google-Smtp-Source: AGRyM1srTDsD3lF1Nj8u/D/xjMuJOrSeuMWkaVaQOvHyyq+uUmVQu5uN8XQJNPLwVdaC1R98cp8x3A==
X-Received: by 2002:a05:6402:350f:b0:42f:68f9:ae5 with SMTP id b15-20020a056402350f00b0042f68f90ae5mr16118492edd.36.1656057890308;
        Fri, 24 Jun 2022 01:04:50 -0700 (PDT)
Received: from able.fritz.box (p57b0bd9f.dip0.t-ipconnect.de. [87.176.189.159])
        by smtp.gmail.com with ESMTPSA id c19-20020a170906155300b006fea43db5c1sm697779ejd.21.2022.06.24.01.04.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jun 2022 01:04:49 -0700 (PDT)
From:   "=?UTF-8?q?Christian=20K=C3=B6nig?=" 
        <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
To:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        intel-gfx@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        nouveau@lists.freedesktop.org, linux-tegra@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        dri-devel@lists.freedesktop.org
Cc:     mhocko@suse.com, Andrey Grodzovsky <andrey.grodzovsky@amd.com>
Subject: [PATCH 02/14] oom: take per file RSS into account
Date:   Fri, 24 Jun 2022 10:04:32 +0200
Message-Id: <20220624080444.7619-3-christian.koenig@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220624080444.7619-1-christian.koenig@amd.com>
References: <20220624080444.7619-1-christian.koenig@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Andrey Grodzovsky <andrey.grodzovsky@amd.com>

Try to make better decisions which process to kill based on
per file RSS.

Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
---
 mm/oom_kill.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/mm/oom_kill.c b/mm/oom_kill.c
index 3c6cf9e3cd66..76a5ea73eb6a 100644
--- a/mm/oom_kill.c
+++ b/mm/oom_kill.c
@@ -18,6 +18,7 @@
  *  kernel subsystems and hints as to where to find out what things do.
  */
 
+#include <linux/fdtable.h>
 #include <linux/oom.h>
 #include <linux/mm.h>
 #include <linux/err.h>
@@ -228,7 +229,8 @@ long oom_badness(struct task_struct *p, unsigned long totalpages)
 	 * task's rss, pagetable and swap space use.
 	 */
 	points = get_mm_rss(p->mm) + get_mm_counter(p->mm, MM_SWAPENTS) +
-		mm_pgtables_bytes(p->mm) / PAGE_SIZE;
+		files_rss(p->files) + mm_pgtables_bytes(p->mm) / PAGE_SIZE;
+
 	task_unlock(p);
 
 	/* Normalize to oom_score_adj units */
@@ -401,8 +403,8 @@ static int dump_task(struct task_struct *p, void *arg)
 
 	pr_info("[%7d] %5d %5d %8lu %8lu %8ld %8lu         %5hd %s\n",
 		task->pid, from_kuid(&init_user_ns, task_uid(task)),
-		task->tgid, task->mm->total_vm, get_mm_rss(task->mm),
-		mm_pgtables_bytes(task->mm),
+		task->tgid, task->mm->total_vm, get_mm_rss(task->mm) +
+		files_rss(task->files),	mm_pgtables_bytes(task->mm),
 		get_mm_counter(task->mm, MM_SWAPENTS),
 		task->signal->oom_score_adj, task->comm);
 	task_unlock(task);
@@ -594,7 +596,8 @@ static bool oom_reap_task_mm(struct task_struct *tsk, struct mm_struct *mm)
 	pr_info("oom_reaper: reaped process %d (%s), now anon-rss:%lukB, file-rss:%lukB, shmem-rss:%lukB\n",
 			task_pid_nr(tsk), tsk->comm,
 			K(get_mm_counter(mm, MM_ANONPAGES)),
-			K(get_mm_counter(mm, MM_FILEPAGES)),
+			K(get_mm_counter(mm, MM_FILEPAGES) +
+			  files_rss(tsk->files)),
 			K(get_mm_counter(mm, MM_SHMEMPAGES)));
 out_finish:
 	trace_finish_task_reaping(tsk->pid);
@@ -950,7 +953,7 @@ static void __oom_kill_process(struct task_struct *victim, const char *message)
 	pr_err("%s: Killed process %d (%s) total-vm:%lukB, anon-rss:%lukB, file-rss:%lukB, shmem-rss:%lukB, UID:%u pgtables:%lukB oom_score_adj:%hd\n",
 		message, task_pid_nr(victim), victim->comm, K(mm->total_vm),
 		K(get_mm_counter(mm, MM_ANONPAGES)),
-		K(get_mm_counter(mm, MM_FILEPAGES)),
+		K(get_mm_counter(mm, MM_FILEPAGES) + files_rss(victim->files)),
 		K(get_mm_counter(mm, MM_SHMEMPAGES)),
 		from_kuid(&init_user_ns, task_uid(victim)),
 		mm_pgtables_bytes(mm) >> 10, victim->signal->oom_score_adj);
-- 
2.25.1

