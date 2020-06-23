Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 155692066BC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jun 2020 00:00:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388602AbgFWV6e (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 Jun 2020 17:58:34 -0400
Received: from out02.mta.xmission.com ([166.70.13.232]:57574 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387455AbgFWV6d (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 Jun 2020 17:58:33 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out02.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1jnqw3-0004Nx-RL; Tue, 23 Jun 2020 15:58:31 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1jnqw3-0003FG-0o; Tue, 23 Jun 2020 15:58:31 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     <linux-kernel@vger.kernel.org>
Cc:     <linux-fsdevel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>, Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Bernd Edlinger <bernd.edlinger@hotmail.de>
References: <87pn9u6h8c.fsf@x220.int.ebiederm.org>
        <87r1u5laac.fsf@x220.int.ebiederm.org>
Date:   Tue, 23 Jun 2020 16:54:07 -0500
In-Reply-To: <87r1u5laac.fsf@x220.int.ebiederm.org> (Eric W. Biederman's
        message of "Tue, 23 Jun 2020 16:52:43 -0500")
Message-ID: <87ftalla80.fsf_-_@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1jnqw3-0003FG-0o;;;mid=<87ftalla80.fsf_-_@x220.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX192WU5omqc6II6syhD9LEG1XUFeakeHPL4=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa07.xmission.com
X-Spam-Level: 
X-Spam-Status: No, score=-0.2 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa07 0; Body=1 Fuz1=1 Fuz2=1]
X-Spam-DCC: ; sa07 0; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;<linux-kernel@vger.kernel.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 427 ms - load_scoreonly_sql: 0.03 (0.0%),
        signal_user_changed: 9 (2.2%), b_tie_ro: 8 (1.9%), parse: 1.10 (0.3%),
        extract_message_metadata: 13 (3.0%), get_uri_detail_list: 1.92 (0.4%),
        tests_pri_-1000: 13 (3.1%), tests_pri_-950: 1.22 (0.3%),
        tests_pri_-900: 1.02 (0.2%), tests_pri_-90: 138 (32.3%), check_bayes:
        136 (31.9%), b_tokenize: 6 (1.5%), b_tok_get_all: 6 (1.4%),
        b_comp_prob: 2.1 (0.5%), b_tok_touch_all: 118 (27.7%), b_finish: 0.95
        (0.2%), tests_pri_0: 238 (55.8%), check_dkim_signature: 0.50 (0.1%),
        check_dkim_adsp: 2.1 (0.5%), poll_dns_idle: 0.46 (0.1%), tests_pri_10:
        2.1 (0.5%), tests_pri_500: 7 (1.6%), rewrite_mail: 0.00 (0.0%)
Subject: [PATCH v2 2/6] exec: Lock more defensively in exec
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


When taking the task_list_lock in de_thread also take the siglock.  This
makes de_thread closer to fork the canonical place where these locks are
taken.

To complete the defensiveness always take siglock when clearing
group_exit_task and notify_count.

This gives now gives the guarantee that group_exit_task and notify_count
are now always changed under siglock.  As anything multi-threaded in exec
is a rare and slow path I don't think we care if we take an extra lock in
practice.

The practical reason for doing this is to enable setting signal->flags along
with group_exit_task so that the function signal_group_exit can be simplified.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 fs/exec.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/fs/exec.c b/fs/exec.c
index e6e8a9a70327..33b5d9229c01 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1171,6 +1171,7 @@ static int de_thread(struct task_struct *tsk)
 		for (;;) {
 			cgroup_threadgroup_change_begin(tsk);
 			write_lock_irq(&tasklist_lock);
+			spin_lock(lock);
 			/*
 			 * Do this under tasklist_lock to ensure that
 			 * exit_notify() can't miss ->group_exit_task
@@ -1179,6 +1180,7 @@ static int de_thread(struct task_struct *tsk)
 			if (likely(leader->exit_state))
 				break;
 			__set_current_state(TASK_KILLABLE);
+			spin_unlock(lock);
 			write_unlock_irq(&tasklist_lock);
 			cgroup_threadgroup_change_end(tsk);
 			schedule();
@@ -1234,14 +1236,17 @@ static int de_thread(struct task_struct *tsk)
 		 */
 		if (unlikely(leader->ptrace))
 			__wake_up_parent(leader, leader->parent);
+		spin_unlock(lock);
 		write_unlock_irq(&tasklist_lock);
 		cgroup_threadgroup_change_end(tsk);
 
 		release_task(leader);
 	}
 
+	spin_lock_irq(lock);
 	sig->group_exit_task = NULL;
 	sig->notify_count = 0;
+	spin_unlock_irq(lock);
 
 no_thread_group:
 	/* we have changed execution domain */
@@ -1252,10 +1257,12 @@ static int de_thread(struct task_struct *tsk)
 
 killed:
 	/* protects against exit_notify() and __exit_signal() */
-	read_lock(&tasklist_lock);
+	read_lock_irq(&tasklist_lock);
+	spin_lock(lock);
 	sig->group_exit_task = NULL;
 	sig->notify_count = 0;
-	read_unlock(&tasklist_lock);
+	spin_unlock(lock);
+	read_unlock_irq(&tasklist_lock);
 	return -EAGAIN;
 }
 
-- 
2.20.1

