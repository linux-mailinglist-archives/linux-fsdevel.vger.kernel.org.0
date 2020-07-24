Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1DA622C16E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Jul 2020 10:54:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726801AbgGXIyX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Jul 2020 04:54:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726554AbgGXIyX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Jul 2020 04:54:23 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 111BDC0619D3;
        Fri, 24 Jul 2020 01:54:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=xxbr0HEbzKbRBxE7AWUk2n/xYZxM53ofuy4wot0kyPA=; b=PpYGQphaPlr8B7Udb1YijEPPAb
        czkZJ3L4+BnwKUMCyluyu0OdhBplQmOVpRCxoz6hbTh3o8MqkfRHy175rM+2CE8KKcy1cur6A0eN/
        U2R5/PYtYY3j0h4wOdpXjs5N54wzvmCJJ8nXVYlUtFWV47bf8dqMS0wDvjmFmqZ/xYwQ3CyZQ8KdI
        q0KGDzDFVRKMkiCJH3goRiq6xakaQripa417jLTtJvRDZi7uehT677O9jesB4meZD2uhVyMlQWgE6
        jSdqLQZeLjJclhVuiOR7MpMu2+nxicBuZv+4Fv639KDlkaPtAwMGBYAcP85kP5xBqrBr+eP1X7dXs
        FseivnrA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jytSx-0003Wz-NN; Fri, 24 Jul 2020 08:54:07 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id E054C301A7A;
        Fri, 24 Jul 2020 10:54:05 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id C33B528B7E76A; Fri, 24 Jul 2020 10:54:05 +0200 (CEST)
Date:   Fri, 24 Jul 2020 10:54:05 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Qais Yousef <qais.yousef@arm.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Doug Anderson <dianders@chromium.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Quentin Perret <qperret@google.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Patrick Bellasi <patrick.bellasi@matbug.net>,
        Pavan Kondeti <pkondeti@codeaurora.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v7 1/3] sched/uclamp: Add a new sysctl to control RT
 default boost value
Message-ID: <20200724085405.GW10769@hirez.programming.kicks-ass.net>
References: <20200716110347.19553-1-qais.yousef@arm.com>
 <20200716110347.19553-2-qais.yousef@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200716110347.19553-2-qais.yousef@arm.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jul 16, 2020 at 12:03:45PM +0100, Qais Yousef wrote:

Would you mind terribly if I rename things like so?

I tried and failed to come up with a shorter name in general, these
functions names are somewhat unwieldy. I considered s/_default//.

---
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -914,7 +914,7 @@ unsigned int uclamp_rq_max_value(struct
 	return uclamp_idle_value(rq, clamp_id, clamp_value);
 }
 
-static void __uclamp_sync_util_min_rt_default_locked(struct task_struct *p)
+static void __uclamp_update_util_min_rt_default(struct task_struct *p)
 {
 	unsigned int default_util_min;
 	struct uclamp_se *uc_se;
@@ -931,7 +931,7 @@ static void __uclamp_sync_util_min_rt_de
 	uclamp_se_set(uc_se, default_util_min, false);
 }
 
-static void __uclamp_sync_util_min_rt_default(struct task_struct *p)
+static void uclamp_update_util_min_rt_default(struct task_struct *p)
 {
 	struct rq_flags rf;
 	struct rq *rq;
@@ -941,7 +941,7 @@ static void __uclamp_sync_util_min_rt_de
 
 	/* Protect updates to p->uclamp_* */
 	rq = task_rq_lock(p, &rf);
-	__uclamp_sync_util_min_rt_default_locked(p);
+	__uclamp_update_util_min_rt_default(p);
 	task_rq_unlock(rq, p, &rf);
 }
 
@@ -968,7 +968,7 @@ static void uclamp_sync_util_min_rt_defa
 
 	rcu_read_lock();
 	for_each_process_thread(g, p)
-		__uclamp_sync_util_min_rt_default(p);
+		uclamp_update_util_min_rt_default(p);
 	rcu_read_unlock();
 }
 
@@ -1360,7 +1360,7 @@ static void __setscheduler_uclamp(struct
 		 * at runtime.
 		 */
 		if (unlikely(rt_task(p) && clamp_id == UCLAMP_MIN))
-			__uclamp_sync_util_min_rt_default_locked(p);
+			__uclamp_update_util_min_rt_default(p);
 		else
 			uclamp_se_set(uc_se, uclamp_none(clamp_id), false);
 
@@ -1404,7 +1404,7 @@ static void uclamp_fork(struct task_stru
 
 static void uclamp_post_fork(struct task_struct *p)
 {
-	__uclamp_sync_util_min_rt_default(p);
+	uclamp_update_util_min_rt_default(p);
 }
 
 static void __init init_uclamp_rq(struct rq *rq)
