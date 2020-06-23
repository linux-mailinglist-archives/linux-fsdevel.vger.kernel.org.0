Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3A7B2066BE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jun 2020 00:00:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388356AbgFWV7J (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 Jun 2020 17:59:09 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:42034 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387455AbgFWV7J (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 Jun 2020 17:59:09 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out01.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1jnqwd-0002ux-QC; Tue, 23 Jun 2020 15:59:07 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1jnqwc-0000mu-Qc; Tue, 23 Jun 2020 15:59:07 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     <linux-kernel@vger.kernel.org>
Cc:     <linux-fsdevel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>, Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Bernd Edlinger <bernd.edlinger@hotmail.de>
References: <87pn9u6h8c.fsf@x220.int.ebiederm.org>
        <87r1u5laac.fsf@x220.int.ebiederm.org>
Date:   Tue, 23 Jun 2020 16:54:43 -0500
In-Reply-To: <87r1u5laac.fsf@x220.int.ebiederm.org> (Eric W. Biederman's
        message of "Tue, 23 Jun 2020 16:52:43 -0500")
Message-ID: <87a70tla70.fsf_-_@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1jnqwc-0000mu-Qc;;;mid=<87a70tla70.fsf_-_@x220.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+kkhDUBissrPENOFQGDqoexIjbrQanp20=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa07.xmission.com
X-Spam-Level: 
X-Spam-Status: No, score=-0.2 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TooManySym_01 autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa07 0; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: ; sa07 0; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;<linux-kernel@vger.kernel.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 540 ms - load_scoreonly_sql: 0.11 (0.0%),
        signal_user_changed: 215 (39.9%), b_tie_ro: 213 (39.5%), parse: 1.09
        (0.2%), extract_message_metadata: 12 (2.2%), get_uri_detail_list: 1.34
        (0.2%), tests_pri_-1000: 15 (2.8%), tests_pri_-950: 1.44 (0.3%),
        tests_pri_-900: 1.10 (0.2%), tests_pri_-90: 82 (15.2%), check_bayes:
        81 (14.9%), b_tokenize: 7 (1.3%), b_tok_get_all: 6 (1.1%),
        b_comp_prob: 2.1 (0.4%), b_tok_touch_all: 62 (11.5%), b_finish: 0.96
        (0.2%), tests_pri_0: 192 (35.5%), check_dkim_signature: 1.17 (0.2%),
        check_dkim_adsp: 2.9 (0.5%), poll_dns_idle: 0.53 (0.1%), tests_pri_10:
        2.3 (0.4%), tests_pri_500: 14 (2.5%), rewrite_mail: 0.00 (0.0%)
Subject: [PATCH v2 3/6] signal: Implement SIGNAL_GROUP_DETHREAD
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


To allow signal_group_exit to be simplfied so that it can only test
signal->flags.  Add a new flag SIGNAL_GROUP_DETHREAD, that is set and
cleared where de_thread sets and clears group_exit_task today.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 fs/exec.c                    | 3 +++
 include/linux/sched/signal.h | 1 +
 2 files changed, 4 insertions(+)

diff --git a/fs/exec.c b/fs/exec.c
index 33b5d9229c01..9c4c1ab8f715 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1145,6 +1145,7 @@ static int de_thread(struct task_struct *tsk)
 		return -EAGAIN;
 	}
 
+	sig->flags |= SIGNAL_GROUP_DETHREAD;
 	sig->group_exit_task = tsk;
 	sig->notify_count = zap_other_threads(tsk);
 	if (!thread_group_leader(tsk))
@@ -1244,6 +1245,7 @@ static int de_thread(struct task_struct *tsk)
 	}
 
 	spin_lock_irq(lock);
+	sig->flags &= ~SIGNAL_GROUP_DETHREAD;
 	sig->group_exit_task = NULL;
 	sig->notify_count = 0;
 	spin_unlock_irq(lock);
@@ -1259,6 +1261,7 @@ static int de_thread(struct task_struct *tsk)
 	/* protects against exit_notify() and __exit_signal() */
 	read_lock_irq(&tasklist_lock);
 	spin_lock(lock);
+	sig->flags &= ~SIGNAL_GROUP_DETHREAD;
 	sig->group_exit_task = NULL;
 	sig->notify_count = 0;
 	spin_unlock(lock);
diff --git a/include/linux/sched/signal.h b/include/linux/sched/signal.h
index b4f36a11be5e..5ff8697b21cd 100644
--- a/include/linux/sched/signal.h
+++ b/include/linux/sched/signal.h
@@ -253,6 +253,7 @@ struct signal_struct {
 /* Signal group actions. */
 #define SIGNAL_GROUP_EXIT	0x00000100 /* group exit in progress */
 #define SIGNAL_GROUP_COREDUMP	0x00000200 /* coredump in progress */
+#define SIGNAL_GROUP_DETHREAD	0x00000400 /* exec de_thread in progress */
 
 /* Flags applicable to the entire signal group. */
 #define SIGNAL_UNKILLABLE	0x00001000 /* for init: ignore fatal signals */
-- 
2.20.1

