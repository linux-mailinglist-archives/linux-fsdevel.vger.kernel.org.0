Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7ED65200B19
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Jun 2020 16:14:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733013AbgFSOOG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 19 Jun 2020 10:14:06 -0400
Received: from out02.mta.xmission.com ([166.70.13.232]:51900 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725974AbgFSOOE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 19 Jun 2020 10:14:04 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out02.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1jmHmK-00081o-MS; Fri, 19 Jun 2020 08:14:00 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1jmHmJ-0001Ae-Fn; Fri, 19 Jun 2020 08:14:00 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Junxiao Bi <junxiao.bi@oracle.com>
Cc:     Matthew Wilcox <willy@infradead.org>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        Matthew Wilcox <matthew.wilcox@oracle.com>,
        Srinivas Eeda <SRINIVAS.EEDA@oracle.com>,
        "joe.jin\@oracle.com" <joe.jin@oracle.com>
References: <54091fc0-ca46-2186-97a8-d1f3c4f3877b@oracle.com>
        <20200618233958.GV8681@bombadil.infradead.org>
        <877dw3apn8.fsf@x220.int.ebiederm.org>
        <2cf6af59-e86b-f6cc-06d3-84309425bd1d@oracle.com>
Date:   Fri, 19 Jun 2020 09:09:41 -0500
In-Reply-To: <2cf6af59-e86b-f6cc-06d3-84309425bd1d@oracle.com> (Junxiao Bi's
        message of "Thu, 18 Jun 2020 17:27:43 -0700")
Message-ID: <87bllf87ve.fsf_-_@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1jmHmJ-0001Ae-Fn;;;mid=<87bllf87ve.fsf_-_@x220.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19+kJXk7DdBNSbufeE2zhsPt9yABoMvPa4=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa07.xmission.com
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,XMSubLong autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4921]
        *  0.7 XMSubLong Long Subject
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa07 0; Body=1 Fuz1=1 Fuz2=1]
X-Spam-DCC: ; sa07 0; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Junxiao Bi <junxiao.bi@oracle.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 753 ms - load_scoreonly_sql: 0.05 (0.0%),
        signal_user_changed: 9 (1.2%), b_tie_ro: 8 (1.0%), parse: 1.48 (0.2%),
        extract_message_metadata: 25 (3.3%), get_uri_detail_list: 4.0 (0.5%),
        tests_pri_-1000: 42 (5.5%), tests_pri_-950: 1.78 (0.2%),
        tests_pri_-900: 1.41 (0.2%), tests_pri_-90: 135 (17.9%), check_bayes:
        132 (17.5%), b_tokenize: 32 (4.2%), b_tok_get_all: 10 (1.3%),
        b_comp_prob: 3.2 (0.4%), b_tok_touch_all: 82 (10.9%), b_finish: 1.01
        (0.1%), tests_pri_0: 522 (69.2%), check_dkim_signature: 0.94 (0.1%),
        check_dkim_adsp: 6 (0.8%), poll_dns_idle: 3.4 (0.5%), tests_pri_10:
        3.3 (0.4%), tests_pri_500: 8 (1.1%), rewrite_mail: 0.00 (0.0%)
Subject: [PATCH] proc: Avoid a thundering herd of threads freeing proc dentries
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


Junxiao Bi <junxiao.bi@oracle.com> reported:
> When debugging some performance issue, i found that thousands of threads exit
> around same time could cause a severe spin lock contention on proc dentry
> "/proc/$parent_process_pid/task/", that's because threads needs to clean up
> their pid file from that dir when exit.

Matthew Wilcox <willy@infradead.org> reported:
> We've looked at a few different ways of fixing this problem.

The flushing of the proc dentries from the dcache is an optmization,
and is not necessary for correctness.  Eventually cache pressure will
cause the dentries to be freed even if no flushing happens.  Some
light testing when I refactored the proc flushg[1] indicated that at
least the memory footprint is easily measurable.

An optimization that causes a performance problem due to a thundering
herd of threads is no real optimization.

Modify the code to only flush the /proc/<tgid>/ directory when all
threads in a process are killed at once.  This continues to flush
practically everything when the process is reaped as the threads live
under /proc/<tgid>/task/<tid>.

There is a rare possibility that a debugger will access /proc/<tid>/,
which this change will no longer flush, but I believe such accesses
are sufficiently rare to not be observed in practice.

[1] 7bc3e6e55acf ("proc: Use a list of inodes to flush from proc")
Link: https://lkml.kernel.org/r/54091fc0-ca46-2186-97a8-d1f3c4f3877b@oracle.com
Reported-by: Masahiro Yamada <masahiroy@kernel.org>
Reported-by: Matthew Wilcox <willy@infradead.org>
Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---

I am still waiting for word on how this affects performance, but this is
a clean version that should avoid the thundering herd problem in
general.


 kernel/exit.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/kernel/exit.c b/kernel/exit.c
index cebae77a9664..567354550d62 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -151,8 +151,8 @@ void put_task_struct_rcu_user(struct task_struct *task)
 
 void release_task(struct task_struct *p)
 {
+	struct pid *flush_pid = NULL;
 	struct task_struct *leader;
-	struct pid *thread_pid;
 	int zap_leader;
 repeat:
 	/* don't need to get the RCU readlock here - the process is dead and
@@ -165,7 +165,16 @@ void release_task(struct task_struct *p)
 
 	write_lock_irq(&tasklist_lock);
 	ptrace_release_task(p);
-	thread_pid = get_pid(p->thread_pid);
+
+	/*
+	 * When all of the threads are exiting wait until the end
+	 * and flush everything.
+	 */
+	if (thread_group_leader(p))
+		flush_pid = get_pid(task_tgid(p));
+	else if (!(p->signal->flags & SIGNAL_GROUP_EXIT))
+		flush_pid = get_pid(task_pid(p));
+
 	__exit_signal(p);
 
 	/*
@@ -188,8 +197,10 @@ void release_task(struct task_struct *p)
 	}
 
 	write_unlock_irq(&tasklist_lock);
-	proc_flush_pid(thread_pid);
-	put_pid(thread_pid);
+	if (flush_pid) {
+		proc_flush_pid(flush_pid);
+		put_pid(flush_pid);
+	}
 	release_thread(p);
 	put_task_struct_rcu_user(p);
 
-- 
2.20.1
