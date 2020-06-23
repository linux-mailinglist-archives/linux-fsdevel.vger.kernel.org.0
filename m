Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36E422066C5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jun 2020 00:00:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388927AbgFWWAR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 Jun 2020 18:00:17 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:42486 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387558AbgFWWAQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 Jun 2020 18:00:16 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out01.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1jnqxj-00032s-8r; Tue, 23 Jun 2020 16:00:15 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1jnqxi-0003Uu-CR; Tue, 23 Jun 2020 16:00:15 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     <linux-kernel@vger.kernel.org>
Cc:     <linux-fsdevel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>, Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Bernd Edlinger <bernd.edlinger@hotmail.de>
References: <87pn9u6h8c.fsf@x220.int.ebiederm.org>
        <87r1u5laac.fsf@x220.int.ebiederm.org>
Date:   Tue, 23 Jun 2020 16:55:51 -0500
In-Reply-To: <87r1u5laac.fsf@x220.int.ebiederm.org> (Eric W. Biederman's
        message of "Tue, 23 Jun 2020 16:52:43 -0500")
Message-ID: <87y2odjvko.fsf_-_@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1jnqxi-0003Uu-CR;;;mid=<87y2odjvko.fsf_-_@x220.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18OOvS43z9gpnli31m0/YVpcSYNZcjVme4=
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
X-Spam-Timing: total 361 ms - load_scoreonly_sql: 0.06 (0.0%),
        signal_user_changed: 11 (3.2%), b_tie_ro: 10 (2.8%), parse: 1.74
        (0.5%), extract_message_metadata: 13 (3.5%), get_uri_detail_list: 1.05
        (0.3%), tests_pri_-1000: 17 (4.7%), tests_pri_-950: 2.2 (0.6%),
        tests_pri_-900: 1.58 (0.4%), tests_pri_-90: 140 (38.7%), check_bayes:
        138 (38.2%), b_tokenize: 6 (1.7%), b_tok_get_all: 6 (1.6%),
        b_comp_prob: 2.2 (0.6%), b_tok_touch_all: 120 (33.2%), b_finish: 1.04
        (0.3%), tests_pri_0: 160 (44.5%), check_dkim_signature: 0.51 (0.1%),
        check_dkim_adsp: 2.5 (0.7%), poll_dns_idle: 0.54 (0.1%), tests_pri_10:
        2.7 (0.7%), tests_pri_500: 8 (2.1%), rewrite_mail: 0.00 (0.0%)
Subject: [PATCH v2 5/6] coredump: Stop using group_exit_task
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


Setting and clearing of group_exit_task in the coredump code was added
to affect the outcome of signal_group_exit()[1].  The coredump code
has not grown any other uses for setting group_exit_task since.  Now
that signal_group_exit() no longer tests group_exit_task stop setting
and clearing it.

[1] 6cd8f0acae34 ("coredump: ensure that SIGKILL always kills the dumping thread")
Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 fs/coredump.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/fs/coredump.c b/fs/coredump.c
index 7237f07ff6be..37b71c72ab3a 100644
--- a/fs/coredump.c
+++ b/fs/coredump.c
@@ -369,7 +369,6 @@ static int zap_threads(struct task_struct *tsk, struct mm_struct *mm,
 	spin_lock_irq(&tsk->sighand->siglock);
 	if (!signal_group_exit(tsk->signal)) {
 		mm->core_state = core_state;
-		tsk->signal->group_exit_task = tsk;
 		nr = zap_process(tsk, exit_code, 0);
 		clear_tsk_thread_flag(tsk, TIF_SIGPENDING);
 	}
@@ -481,7 +480,6 @@ static void coredump_finish(struct mm_struct *mm, bool core_dumped)
 	spin_lock_irq(&current->sighand->siglock);
 	if (core_dumped && !__fatal_signal_pending(current))
 		current->signal->group_exit_code |= 0x80;
-	current->signal->group_exit_task = NULL;
 	current->signal->flags = SIGNAL_GROUP_EXIT;
 	spin_unlock_irq(&current->sighand->siglock);
 
-- 
2.20.1

