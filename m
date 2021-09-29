Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41CE441CEAE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Sep 2021 00:03:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346955AbhI2WEG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 Sep 2021 18:04:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346846AbhI2WEE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 Sep 2021 18:04:04 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E09EC06176F
        for <linux-fsdevel@vger.kernel.org>; Wed, 29 Sep 2021 15:02:22 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id 133so4159984pgb.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 29 Sep 2021 15:02:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FXiCuxEPMvqVSi+g+P0evOsDZPlbh8jjQbS0s6wZm8k=;
        b=SRrGW9zo/d6XA0WfD3zwDEcbIo+Z1I96cCKPaPYXClI+Qfg8s9OJNo/xb7TEDE5aYr
         Ho17NV6HPaJkzNytOQUl6mp8zKXpU0ULv+wkVZg+EBUY+CEH/WHSNssW9o9ZppK3PwaO
         fhhITLjFDcaVBGI2nxkxo8lrt6URHO+miQv6Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FXiCuxEPMvqVSi+g+P0evOsDZPlbh8jjQbS0s6wZm8k=;
        b=z0CKJXMEb4flreYJRXU9QQbiHodIL8no/AY3yp9v1l4bDx4kD265EMEDGEF6iuLKK2
         J47hWildB/LRKduBRaF0PoQptItpkVdqV0ihvr9/gbQafepPFLwwMSljWLGY1jjd8SbS
         tZDEBTKNa0n1S6p0L9/5j95UsoGD3QYliasFquH76zMPcts+UeeaHq4jUYdyI6XU+/2N
         P13lZZaIh57lFY7kYsIJ+NbtUXQRnarBDNqf+9fmThOKCN63P/v8FSMNgtPogfb9euUc
         TBRjY0rRxQjrvTDQ1oV1cmMFakw9cJrSxscOdNdWqRZ9+BztKsjoSDXz0qnQBDVOyBoW
         GxlQ==
X-Gm-Message-State: AOAM532LkFxDr0r8sKFJ2HEqdrNEnFpOH1u38/Ene3k2omT149gqzuOe
        3RvSfu8cYblRMOKeHtsfT3eXXQ==
X-Google-Smtp-Source: ABdhPJzliJ0RYWBweCHHWJ+P3Zmj4CAL9EDfVBAf9D4cTfaBNZUREv4N4JrivSvzlyTgfNZ7/6QD/Q==
X-Received: by 2002:a63:1e60:: with SMTP id p32mr1903923pgm.234.1632952941938;
        Wed, 29 Sep 2021 15:02:21 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id o16sm561897pgv.29.2021.09.29.15.02.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Sep 2021 15:02:20 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Anand K Mistry <amistry@google.com>,
        "Kenta.Tada@sony.com" <Kenta.Tada@sony.com>,
        Alexey Gladkov <legion@kernel.org>,
        =?UTF-8?q?Michael=20Wei=C3=9F?= <michael.weiss@aisec.fraunhofer.de>,
        Jann Horn <jannh@google.com>, Michal Hocko <mhocko@suse.com>,
        Helge Deller <deller@gmx.de>, linux-fsdevel@vger.kernel.org,
        kernel test robot <oliver.sang@intel.com>,
        Vito Caputo <vcaputo@pengaru.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Qi Zheng <zhengqi.arch@bytedance.com>,
        "Tobin C. Harding" <me@tobin.cc>,
        Tycho Andersen <tycho@tycho.pizza>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Jens Axboe <axboe@kernel.dk>,
        Stefan Metzmacher <metze@samba.org>,
        Lai Jiangshan <laijs@linux.alibaba.com>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Ohhoon Kwon <ohoono.kwon@samsung.com>,
        Kalesh Singh <kaleshsingh@google.com>,
        YiFei Zhu <yifeifz2@illinois.edu>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        x86@kernel.org
Subject: [PATCH v2 3/6] proc: Use task_is_running() for wchan in /proc/$pid/stat
Date:   Wed, 29 Sep 2021 15:02:15 -0700
Message-Id: <20210929220218.691419-4-keescook@chromium.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210929220218.691419-1-keescook@chromium.org>
References: <20210929220218.691419-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1702; h=from:subject; bh=vEcA8vhX2LIYTyny+lSt9vtrmOxzTbXuNEQhn5SMUqg=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBhVOJo4pEo1xkbc20ffT7DBLQ7oi+h8cwMpfxIYeBP 9Dwzkr+JAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYVTiaAAKCRCJcvTf3G3AJoEdD/ 9KIWtXlguBEKgRhhajeWO7Pq+iFfZvVJRNJmrg0tcqcStHiicYq1RMWEekffyqtSOir3ypL+ZJQjSF 6GDHvBFJh7991cXxetyQeqCTAKuTRoa5QBNJCbVfjQjoehkd1NR4BodXDO8xKDStibOXos+qMk7CBm Cz+QSk9v7a6MmB3IuTuNYKf5moDvV53v0OFtDA4714WSd5ShHTdMGUTZXLzHTprDTrIsdgUJDWcgwU NoE2htw5yghyl0k2oadQlfuXAL44IaBAvchMl13m3h7zgyIzy7KLWQExSSB1XshnESbPLqMU0N3xue 9Lfw/GNXEm+nJgzx85rt8cpn2deSM2SUnYiGPwwZDItrgLHxkd7MX8MygS+wIteE1AGdSus2UaIhlt 7t1hMuRkDzT7WkChhvwrSXHsyJhI01x+Igb6+RJ9j4EDiKXCkPd0v1p+0kzEJjAllijhODUtrKZ3Z2 atfnQ3RiRcuYjhlsadJ29M4C7rlbDE3TB2bKss8qHqUxOaTbQg7iDZ8XPr3Aqp4Gx4H6rxo7FyWtfO UgeXQf+UH1M+SV0t/DDebEW4zwUheVNQC7i6+QxMbEmHf5G6DWKoKCytjqMoemLz3MWCpuI7CrTAnw LE7THqJDnJuZVjESgcd7V8f6lxhoVL2AI2WJSi4sKEScJQLVH9CxLpOzqWkQ==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The implementations of get_wchan() can be expensive. The only information
imparted here is whether or not a process is currently blocked in the
scheduler (and even this doesn't need to be exact). Avoid doing the
heavy lifting of stack walking and just report that information by using
task_is_running().

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Christian Brauner <christian.brauner@ubuntu.com>
Cc: Anand K Mistry <amistry@google.com>
Cc: "Kenta.Tada@sony.com" <Kenta.Tada@sony.com>
Cc: Alexey Gladkov <legion@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: "Michael Weiß" <michael.weiss@aisec.fraunhofer.de>
Cc: Jann Horn <jannh@google.com>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Helge Deller <deller@gmx.de>
Cc: linux-fsdevel@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 fs/proc/array.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/fs/proc/array.c b/fs/proc/array.c
index 49be8c8ef555..77cf4187adec 100644
--- a/fs/proc/array.c
+++ b/fs/proc/array.c
@@ -541,7 +541,7 @@ static int do_task_stat(struct seq_file *m, struct pid_namespace *ns,
 	}
 
 	if (permitted && (!whole || num_threads < 2))
-		wchan = get_wchan(task);
+		wchan = !task_is_running(task);
 	if (!whole) {
 		min_flt = task->min_flt;
 		maj_flt = task->maj_flt;
@@ -606,10 +606,7 @@ static int do_task_stat(struct seq_file *m, struct pid_namespace *ns,
 	 *
 	 * This works with older implementations of procps as well.
 	 */
-	if (wchan)
-		seq_puts(m, " 1");
-	else
-		seq_puts(m, " 0");
+	seq_put_decimal_ull(m, " ", wchan);
 
 	seq_put_decimal_ull(m, " ", 0);
 	seq_put_decimal_ull(m, " ", 0);
-- 
2.30.2

