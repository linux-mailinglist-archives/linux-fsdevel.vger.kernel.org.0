Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF2421B17C1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Apr 2020 22:59:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728260AbgDTU6f (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Apr 2020 16:58:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727109AbgDTU6T (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Apr 2020 16:58:19 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59EDCC061A10;
        Mon, 20 Apr 2020 13:58:19 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id g13so11900462wrb.8;
        Mon, 20 Apr 2020 13:58:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uSj6Db6PfJW4xhAGhq+SjWM2en957Ir1zacTwwhGW/4=;
        b=juiifhgh3Ikj4+5zWUWUoCX0eHCvkEMZleQY3fcY/ELB81M1vneH2o9WKKWYhU5kEE
         P0PJzd64SbVBcPH48dWnEpKJHAfLmNyF3F4xaArcykvEuRzaZH/YDjjjIlmKPc4GX1ua
         wVqV27ZsuBRGHqKBhtRg91hhga5IX2UdE6c44iegviNlKUqSE9bAwuMNEQni8fsmfLTQ
         e93gr58q9qbziK4QqIKWrSr4D2KeKg7aP5wTVkIWt8rsDNPasW0XfhpcZUECigHLGe9x
         wTns7ZYyVG14gEguoayAIZ0jUeSmZYqU47RQslU6tyeGZR48X/0otiCyC8J1lIVkVnun
         Tbfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uSj6Db6PfJW4xhAGhq+SjWM2en957Ir1zacTwwhGW/4=;
        b=n2zQlEesJc4IMi/Ue/d7u3qJHuigZffdqWu0u59ZpQZ2YBZIJoQw+7zvkB6uGFx7ZF
         l9FXDEAEU+sWchPHPHydOx4vQgnM6MPg26YAxkZ2bjoo2m6gBctkM9a2dHLYAcrV/Ch/
         MAfnST/6I9TqEEiALq1Z4IvMMe5fLrfFugzdtMbJ/J2IEz7TVpDTnZYynxe27wKnGsyC
         AbssiCoA+53ljfZRHrMq4zVPYIDWB9i2+krZOhftDlqJI5JXL/MGinPUxWvowR4xw5mO
         Mkn7/mL+Z9Cx6MHu4ENvTuFKhZ5gN+rf/QXmZfpZhTCexlxuCA9rPfbv0LoayGHiB9WF
         WkaA==
X-Gm-Message-State: AGi0PuYU9cQwvfJHAbr2RRb/+K8xCDSPJxuIxIckLOA991ssylplMI3w
        +b7ibnXCHfJRYiTBE03mvg==
X-Google-Smtp-Source: APiQypJV+hTkzjR2JSQzY6D9kDB5TGxIT8ruUKaYk1GupS7Wqf9CvzOGBLrZfxRHlVdsA++Bl3reUA==
X-Received: by 2002:adf:aad4:: with SMTP id i20mr17105189wrc.47.1587416298008;
        Mon, 20 Apr 2020 13:58:18 -0700 (PDT)
Received: from avx2.telecom.by ([46.53.249.74])
        by smtp.gmail.com with ESMTPSA id m8sm863069wrx.54.2020.04.20.13.58.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2020 13:58:17 -0700 (PDT)
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     akpm@linux-foundation.org
Cc:     adobriyan@gmail.com, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, pmladek@suse.com,
        rostedt@goodmis.org, sergey.senozhatsky@gmail.com,
        andriy.shevchenko@linux.intel.com, linux@rasmusvillemoes.dk
Subject: [PATCH 11/15] print_integer, proc: rewrite /proc/*/stat via print_integer()
Date:   Mon, 20 Apr 2020 23:57:39 +0300
Message-Id: <20200420205743.19964-11-adobriyan@gmail.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200420205743.19964-1-adobriyan@gmail.com>
References: <20200420205743.19964-1-adobriyan@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---
 fs/proc/array.c | 192 ++++++++++++++++++++++++++++++------------------
 1 file changed, 122 insertions(+), 70 deletions(-)

diff --git a/fs/proc/array.c b/fs/proc/array.c
index 8e16f14bb05a..6986f9f68ab7 100644
--- a/fs/proc/array.c
+++ b/fs/proc/array.c
@@ -446,6 +446,9 @@ static int do_task_stat(struct seq_file *m, struct pid_namespace *ns,
 	u64 cgtime, gtime;
 	unsigned long rsslim = 0;
 	unsigned long flags;
+	char buf[11 * (1 + LEN_U32) + 7 * (1 + LEN_S32) + 19 * (1 + LEN_UL) +
+		 8 * (1 + LEN_U64) + 12];
+	char *p;
 
 	state = *get_task_state(task);
 	vsize = eip = esp = 0;
@@ -535,47 +538,54 @@ static int do_task_stat(struct seq_file *m, struct pid_namespace *ns,
 	/* convert nsec -> ticks */
 	start_time = nsec_to_clock_t(task->start_boottime);
 
-	seq_put_decimal_ull(m, "", pid_nr_ns(pid, ns));
-	seq_puts(m, " (");
+	p = buf + sizeof(buf);
+	*--p = '(';
+	*--p = ' ';
+	p = _print_integer_u32(p, pid_nr_ns(pid, ns));
+	seq_write(m, p, buf + sizeof(buf) - p);
+
 	proc_task_name(m, task, false);
-	seq_puts(m, ") ");
-	seq_putc(m, state);
-	seq_put_decimal_ll(m, " ", ppid);
-	seq_put_decimal_ll(m, " ", pgid);
-	seq_put_decimal_ll(m, " ", sid);
-	seq_put_decimal_ll(m, " ", tty_nr);
-	seq_put_decimal_ll(m, " ", tty_pgrp);
-	seq_put_decimal_ull(m, " ", task->flags);
-	seq_put_decimal_ull(m, " ", min_flt);
-	seq_put_decimal_ull(m, " ", cmin_flt);
-	seq_put_decimal_ull(m, " ", maj_flt);
-	seq_put_decimal_ull(m, " ", cmaj_flt);
-	seq_put_decimal_ull(m, " ", nsec_to_clock_t(utime));
-	seq_put_decimal_ull(m, " ", nsec_to_clock_t(stime));
-	seq_put_decimal_ll(m, " ", nsec_to_clock_t(cutime));
-	seq_put_decimal_ll(m, " ", nsec_to_clock_t(cstime));
-	seq_put_decimal_ll(m, " ", priority);
-	seq_put_decimal_ll(m, " ", nice);
-	seq_put_decimal_ll(m, " ", num_threads);
-	seq_put_decimal_ull(m, " ", 0);
-	seq_put_decimal_ull(m, " ", start_time);
-	seq_put_decimal_ull(m, " ", vsize);
-	seq_put_decimal_ull(m, " ", mm ? get_mm_rss(mm) : 0);
-	seq_put_decimal_ull(m, " ", rsslim);
-	seq_put_decimal_ull(m, " ", mm ? (permitted ? mm->start_code : 1) : 0);
-	seq_put_decimal_ull(m, " ", mm ? (permitted ? mm->end_code : 1) : 0);
-	seq_put_decimal_ull(m, " ", (permitted && mm) ? mm->start_stack : 0);
-	seq_put_decimal_ull(m, " ", esp);
-	seq_put_decimal_ull(m, " ", eip);
-	/* The signal information here is obsolete.
-	 * It must be decimal for Linux 2.0 compatibility.
-	 * Use /proc/#/status for real-time signals.
-	 */
-	seq_put_decimal_ull(m, " ", task->pending.signal.sig[0] & 0x7fffffffUL);
-	seq_put_decimal_ull(m, " ", task->blocked.sig[0] & 0x7fffffffUL);
-	seq_put_decimal_ull(m, " ", sigign.sig[0] & 0x7fffffffUL);
-	seq_put_decimal_ull(m, " ", sigcatch.sig[0] & 0x7fffffffUL);
 
+	p = buf + sizeof(buf);
+	*--p = '\n';
+	p = _print_integer_s32(p, permitted ? task->exit_code : 0);
+	*--p = ' ';
+	if (mm && permitted) {
+		p = _print_integer_ul(p, mm->env_end);
+		*--p = ' ';
+		p = _print_integer_ul(p, mm->env_start);
+		*--p = ' ';
+		p = _print_integer_ul(p, mm->arg_end);
+		*--p = ' ';
+		p = _print_integer_ul(p, mm->arg_start);
+		*--p = ' ';
+		p = _print_integer_ul(p, mm->start_brk);
+		*--p = ' ';
+		p = _print_integer_ul(p, mm->end_data);
+		*--p = ' ';
+		p = _print_integer_ul(p, mm->start_data);
+		*--p = ' ';
+	} else {
+		p = memcpy(p - 14, " 0 0 0 0 0 0 0", 14);
+	}
+	p = _print_integer_u64(p, nsec_to_clock_t(cgtime));
+	*--p = ' ';
+	p = _print_integer_u64(p, nsec_to_clock_t(gtime));
+	*--p = ' ';
+	p = _print_integer_u64(p, delayacct_blkio_ticks(task));
+	*--p = ' ';
+	p = _print_integer_u32(p, task->policy);
+	*--p = ' ';
+	p = _print_integer_u32(p, task->rt_priority);
+	*--p = ' ';
+	p = _print_integer_u32(p, task_cpu(task));
+	*--p = ' ';
+	p = _print_integer_s32(p, task->exit_signal);
+	*--p = ' ';
+	*--p = '0';
+	*--p = ' ';
+	*--p = '0';
+	*--p = ' ';
 	/*
 	 * We used to output the absolute kernel address, but that's an
 	 * information leak - so instead we show a 0/1 flag here, to signal
@@ -583,38 +593,80 @@ static int do_task_stat(struct seq_file *m, struct pid_namespace *ns,
 	 *
 	 * This works with older implementations of procps as well.
 	 */
-	if (wchan)
-		seq_puts(m, " 1");
-	else
-		seq_puts(m, " 0");
-
-	seq_put_decimal_ull(m, " ", 0);
-	seq_put_decimal_ull(m, " ", 0);
-	seq_put_decimal_ll(m, " ", task->exit_signal);
-	seq_put_decimal_ll(m, " ", task_cpu(task));
-	seq_put_decimal_ull(m, " ", task->rt_priority);
-	seq_put_decimal_ull(m, " ", task->policy);
-	seq_put_decimal_ull(m, " ", delayacct_blkio_ticks(task));
-	seq_put_decimal_ull(m, " ", nsec_to_clock_t(gtime));
-	seq_put_decimal_ll(m, " ", nsec_to_clock_t(cgtime));
-
-	if (mm && permitted) {
-		seq_put_decimal_ull(m, " ", mm->start_data);
-		seq_put_decimal_ull(m, " ", mm->end_data);
-		seq_put_decimal_ull(m, " ", mm->start_brk);
-		seq_put_decimal_ull(m, " ", mm->arg_start);
-		seq_put_decimal_ull(m, " ", mm->arg_end);
-		seq_put_decimal_ull(m, " ", mm->env_start);
-		seq_put_decimal_ull(m, " ", mm->env_end);
-	} else
-		seq_puts(m, " 0 0 0 0 0 0 0");
-
-	if (permitted)
-		seq_put_decimal_ll(m, " ", task->exit_code);
-	else
-		seq_puts(m, " 0");
+	*--p = '0' + !!wchan;
+	*--p = ' ';
+	/*
+	 * The signal information here is obsolete.
+	 * It must be decimal for Linux 2.0 compatibility.
+	 * Use /proc/#/status for real-time signals.
+	 */
+	p = _print_integer_u32(p, sigcatch.sig[0] & 0x7fffffff);
+	*--p = ' ';
+	p = _print_integer_u32(p, sigign.sig[0] & 0x7fffffff);
+	*--p = ' ';
+	p = _print_integer_u32(p, task->blocked.sig[0] & 0x7fffffff);
+	*--p = ' ';
+	p = _print_integer_u32(p, task->pending.signal.sig[0] & 0x7fffffff);
+	*--p = ' ';
+	p = _print_integer_ul(p, eip);
+	*--p = ' ';
+	p = _print_integer_ul(p, esp);
+	*--p = ' ';
+	p = _print_integer_ul(p, (permitted && mm) ? mm->start_stack : 0);
+	*--p = ' ';
+	p = _print_integer_ul(p, mm ? (permitted ? mm->end_code : 1) : 0);
+	*--p = ' ';
+	p = _print_integer_ul(p, mm ? (permitted ? mm->start_code : 1) : 0);
+	*--p = ' ';
+	p = _print_integer_ul(p, rsslim);
+	*--p = ' ';
+	p = _print_integer_ul(p, mm ? get_mm_rss(mm) : 0);
+	*--p = ' ';
+	p = _print_integer_ul(p, vsize);
+	*--p = ' ';
+	p = _print_integer_u64(p, start_time);
+	*--p = ' ';
+	*--p = '0';
+	*--p = ' ';
+	p = _print_integer_u32(p, num_threads);
+	*--p = ' ';
+	p = _print_integer_s32(p, nice);
+	*--p = ' ';
+	p = _print_integer_s32(p, priority);
+	*--p = ' ';
+	p = _print_integer_u64(p, nsec_to_clock_t(cstime));
+	*--p = ' ';
+	p = _print_integer_u64(p, nsec_to_clock_t(cutime));
+	*--p = ' ';
+	p = _print_integer_u64(p, nsec_to_clock_t(stime));
+	*--p = ' ';
+	p = _print_integer_u64(p, nsec_to_clock_t(utime));
+	*--p = ' ';
+	p = _print_integer_ul(p, cmaj_flt);
+	*--p = ' ';
+	p = _print_integer_ul(p, maj_flt);
+	*--p = ' ';
+	p = _print_integer_ul(p, cmin_flt);
+	*--p = ' ';
+	p = _print_integer_ul(p, min_flt);
+	*--p = ' ';
+	p = _print_integer_u32(p, task->flags);
+	*--p = ' ';
+	p = _print_integer_s32(p, tty_pgrp);
+	*--p = ' ';
+	p = _print_integer_u32(p, tty_nr);
+	*--p = ' ';
+	p = _print_integer_s32(p, sid);
+	*--p = ' ';
+	p = _print_integer_s32(p, pgid);
+	*--p = ' ';
+	p = _print_integer_u32(p, ppid);
+	*--p = ' ';
+	*--p = state;
+	*--p = ' ';
+	*--p = ')';
+	seq_write(m, p, buf + sizeof(buf) - p);
 
-	seq_putc(m, '\n');
 	if (mm)
 		mmput(mm);
 	return 0;
-- 
2.24.1

