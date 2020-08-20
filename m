Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B291D24BC35
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Aug 2020 14:43:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728785AbgHTMlc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 Aug 2020 08:41:32 -0400
Received: from mx2.suse.de ([195.135.220.15]:37594 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729346AbgHTMlM (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 Aug 2020 08:41:12 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 5D0EAAF0F;
        Thu, 20 Aug 2020 12:41:37 +0000 (UTC)
Date:   Thu, 20 Aug 2020 14:41:09 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     Oleg Nesterov <oleg@redhat.com>,
        Suren Baghdasaryan <surenb@google.com>, mingo@kernel.org,
        peterz@infradead.org, tglx@linutronix.de, esyr@redhat.com,
        christian@kellner.me, areber@redhat.com, shakeelb@google.com,
        cyphar@cyphar.com, adobriyan@gmail.com, akpm@linux-foundation.org,
        ebiederm@xmission.com, gladkov.alexey@gmail.com, walken@google.com,
        daniel.m.jordan@oracle.com, avagin@gmail.com,
        bernd.edlinger@hotmail.de, john.johansen@canonical.com,
        laoar.shao@gmail.com, timmurray@google.com, minchan@kernel.org,
        kernel-team@android.com, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 1/1] mm, oom_adj: don't loop through tasks in
 __set_oom_adj when not necessary
Message-ID: <20200820124109.GI5033@dhcp22.suse.cz>
References: <20200820002053.1424000-1-surenb@google.com>
 <20200820105555.GA4546@redhat.com>
 <20200820111349.GE5033@dhcp22.suse.cz>
 <20200820113023.rjxque4jveo4nj5o@wittgenstein>
 <20200820114245.GH5033@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200820114245.GH5033@dhcp22.suse.cz>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 20-08-20 13:42:56, Michal Hocko wrote:
> On Thu 20-08-20 13:30:23, Christian Brauner wrote:
[...]
> > trying to rely on set_bit() and test_bit() in copy_mm() being atomic and
> > then calling it where Oleg said after the point of no return.
> 
> No objections.

Would something like the following work for you?

diff --git a/kernel/fork.c b/kernel/fork.c
index 9177a76bf840..25b83f0912a6 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1403,15 +1403,6 @@ static int copy_mm(unsigned long clone_flags, struct task_struct *tsk)
 	if (clone_flags & CLONE_VM) {
 		mmget(oldmm);
 		mm = oldmm;
-		if (!(clone_flags & CLONE_SIGHAND)) {
-			/* We need to synchronize with __set_oom_adj */
-			mutex_lock(&oom_adj_lock);
-			set_bit(MMF_PROC_SHARED, &mm->flags);
-			/* Update the values in case they were changed after copy_signal */
-			tsk->signal->oom_score_adj = current->signal->oom_score_adj;
-			tsk->signal->oom_score_adj_min = current->signal->oom_score_adj_min;
-			mutex_unlock(&oom_adj_lock);
-		}
 		goto good_mm;
 	}
 
@@ -1818,6 +1809,19 @@ static __always_inline void delayed_free_task(struct task_struct *tsk)
 		free_task(tsk);
 }
 
+static void copy_oom_score_adj(u64 clone_flags, struct task_struct *tsk)
+{
+	if ((clone_flags & (CLONE_VM | CLONE_THREAD | CLONE_VFORK)) == CLONE_VM) {
+		/* We need to synchronize with __set_oom_adj */
+		mutex_lock(&oom_adj_lock);
+		set_bit(MMF_PROC_SHARED, &mm->flags);
+		/* Update the values in case they were changed after copy_signal */
+		tsk->signal->oom_score_adj = current->signal->oom_score_adj;
+		tsk->signal->oom_score_adj_min = current->signal->oom_score_adj_min;
+		mutex_unlock(&oom_adj_lock);
+	}
+}
+
 /*
  * This creates a new process as a copy of the old one,
  * but does not actually start it yet.
@@ -2290,6 +2294,8 @@ static __latent_entropy struct task_struct *copy_process(
 	trace_task_newtask(p, clone_flags);
 	uprobe_copy_process(p, clone_flags);
 
+	copy_oom_score_adj(clone_flags, p);
+
 	return p;
 
 bad_fork_cancel_cgroup:
-- 
Michal Hocko
SUSE Labs
