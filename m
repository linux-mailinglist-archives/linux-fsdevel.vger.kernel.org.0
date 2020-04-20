Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3D401B17AE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Apr 2020 22:58:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726713AbgDTU6J (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Apr 2020 16:58:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725897AbgDTU6J (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Apr 2020 16:58:09 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40DA9C061A0C;
        Mon, 20 Apr 2020 13:58:09 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id j2so13917756wrs.9;
        Mon, 20 Apr 2020 13:58:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pC49c/tGR6tK2Z+rYS1KNFKjC1tBztIhygWmLjD7XLI=;
        b=f1PC9GGbwevBHseC3LNTYWokCHtjeXFgp+JLbN/hCndazXoYtl/CCNswU0vAkLGaJy
         0GqKKEvvJFTKwJqgBa16fnvDZmKRG9U6e6MucwXA9eZuvcou8TDCZdfbsp62pczdV9Nb
         9JgMS4g2ZxSdRUGSGzzt1cUk87Jn5pCvBxNs25A/eo+fGpsSWC5cTQ5720M09OcW79bA
         kbfB2EJYcq8oyvn44VCavykzL+/JBr2BIve1zboxJcwog/bW+M5AcGATmxggfZzXKwPN
         hi4qQWZHrCUiezvvFpcL0mNxACk3x1FFosxq4oo6kRljuxdFByZUXFISKNbgPeqoyFZv
         cx4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pC49c/tGR6tK2Z+rYS1KNFKjC1tBztIhygWmLjD7XLI=;
        b=p2mI5M/YW3C3CsRl/NePoEDzXKaGNat/PhdhicuWFRmIfAZP7hdPykWN1DclILmaYG
         j1A/b4a+OSTSgGA24bWBHhBvJa7DEZQwbmhvP2duzapT/+22CENMa8p5ZJgSQhfPT+aC
         FlIYALZiI4TXS+qbrMnXiQeQKWwqUfpWOmAwuzTPe/EfSIkn+q5gge0BF6uQixPpAbwQ
         SQkTf3SCVgFSD87Hg0VWC8aNxLhtZbU64JGkDgyQUV1Eemceelw3nw2vHOVPvWMlT77U
         +w7f0XWfFqTBliidOtzVlQH57zuZ5tSOMpDt+PJ82d55/CQy1YeyksfoZ7Jw+ntcA5s7
         Rm+A==
X-Gm-Message-State: AGi0PuZ9IPXD4UQVMxK2QLe69ZO0tTIamr8JzLc88B38Yh4Q2y84ZSfu
        XJzrVKoj68ZY90Pg3MdK+g==
X-Google-Smtp-Source: APiQypLW8ETOCzkbPGxgpl7pYqCcvOUjjBaD9WzEY6V00sdbIhXQtXozGpRYBtxJSxfEZ1wTWWUCXQ==
X-Received: by 2002:a5d:6445:: with SMTP id d5mr19970703wrw.373.1587416288001;
        Mon, 20 Apr 2020 13:58:08 -0700 (PDT)
Received: from avx2.telecom.by ([46.53.249.74])
        by smtp.gmail.com with ESMTPSA id m8sm863069wrx.54.2020.04.20.13.58.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2020 13:58:07 -0700 (PDT)
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     akpm@linux-foundation.org
Cc:     adobriyan@gmail.com, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, pmladek@suse.com,
        rostedt@goodmis.org, sergey.senozhatsky@gmail.com,
        andriy.shevchenko@linux.intel.com, linux@rasmusvillemoes.dk
Subject: [PATCH 01/15] sched: make nr_running() return "unsigned int"
Date:   Mon, 20 Apr 2020 23:57:29 +0300
Message-Id: <20200420205743.19964-1-adobriyan@gmail.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

I don't anyone have been crazy enough to spawn 2^32 threads.
It'd require absurd amounts of physical memory,  and bump into futex pid
limit anyway.

Meanwhile save few bits on REX prefixes and some stack space for upcoming
print_integer() stuff.

And remove "extern" from prototypes while I'm at it.

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---
 fs/proc/loadavg.c          | 2 +-
 fs/proc/stat.c             | 2 +-
 include/linux/sched/stat.h | 2 +-
 kernel/sched/core.c        | 4 ++--
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/proc/loadavg.c b/fs/proc/loadavg.c
index 8468baee951d..f32878d9a39f 100644
--- a/fs/proc/loadavg.c
+++ b/fs/proc/loadavg.c
@@ -16,7 +16,7 @@ static int loadavg_proc_show(struct seq_file *m, void *v)
 
 	get_avenrun(avnrun, FIXED_1/200, 0);
 
-	seq_printf(m, "%lu.%02lu %lu.%02lu %lu.%02lu %ld/%d %d\n",
+	seq_printf(m, "%lu.%02lu %lu.%02lu %lu.%02lu %u/%d %d\n",
 		LOAD_INT(avnrun[0]), LOAD_FRAC(avnrun[0]),
 		LOAD_INT(avnrun[1]), LOAD_FRAC(avnrun[1]),
 		LOAD_INT(avnrun[2]), LOAD_FRAC(avnrun[2]),
diff --git a/fs/proc/stat.c b/fs/proc/stat.c
index 46b3293015fe..93ce344f62a5 100644
--- a/fs/proc/stat.c
+++ b/fs/proc/stat.c
@@ -197,7 +197,7 @@ static int show_stat(struct seq_file *p, void *v)
 		"\nctxt %llu\n"
 		"btime %llu\n"
 		"processes %lu\n"
-		"procs_running %lu\n"
+		"procs_running %u\n"
 		"procs_blocked %lu\n",
 		nr_context_switches(),
 		(unsigned long long)boottime.tv_sec,
diff --git a/include/linux/sched/stat.h b/include/linux/sched/stat.h
index 568286411b43..f3b86515bafe 100644
--- a/include/linux/sched/stat.h
+++ b/include/linux/sched/stat.h
@@ -16,7 +16,7 @@ extern unsigned long total_forks;
 extern int nr_threads;
 DECLARE_PER_CPU(unsigned long, process_counts);
 extern int nr_processes(void);
-extern unsigned long nr_running(void);
+unsigned int nr_running(void);
 extern bool single_task_running(void);
 extern unsigned long nr_iowait(void);
 extern unsigned long nr_iowait_cpu(int cpu);
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 3a61a3b8eaa9..d9bae602966c 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3381,9 +3381,9 @@ context_switch(struct rq *rq, struct task_struct *prev,
  * externally visible scheduler statistics: current number of runnable
  * threads, total number of context switches performed since bootup.
  */
-unsigned long nr_running(void)
+unsigned int nr_running(void)
 {
-	unsigned long i, sum = 0;
+	unsigned int i, sum = 0;
 
 	for_each_online_cpu(i)
 		sum += cpu_rq(i)->nr_running;
-- 
2.24.1

