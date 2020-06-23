Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCD232066B4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Jun 2020 23:57:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388347AbgFWV5K (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 Jun 2020 17:57:10 -0400
Received: from out02.mta.xmission.com ([166.70.13.232]:57152 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387455AbgFWV5J (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 Jun 2020 17:57:09 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out02.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1jnqui-0004Gk-3i; Tue, 23 Jun 2020 15:57:08 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1jnquh-000355-0k; Tue, 23 Jun 2020 15:57:07 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     <linux-kernel@vger.kernel.org>
Cc:     <linux-fsdevel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>, Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Bernd Edlinger <bernd.edlinger@hotmail.de>
References: <87pn9u6h8c.fsf@x220.int.ebiederm.org>
Date:   Tue, 23 Jun 2020 16:52:43 -0500
In-Reply-To: <87pn9u6h8c.fsf@x220.int.ebiederm.org> (Eric W. Biederman's
        message of "Fri, 19 Jun 2020 13:30:27 -0500")
Message-ID: <87r1u5laac.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1jnquh-000355-0k;;;mid=<87r1u5laac.fsf@x220.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+sR5+PifQoLRkh+IWaUoEkbEI1rJTseHo=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa04.xmission.com
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TooManySym_01,XMSubLong autolearn=disabled
        version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.7 XMSubLong Long Subject
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa04 0; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: ; sa04 0; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;<linux-kernel@vger.kernel.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 369 ms - load_scoreonly_sql: 0.11 (0.0%),
        signal_user_changed: 14 (3.8%), b_tie_ro: 12 (3.2%), parse: 1.50
        (0.4%), extract_message_metadata: 4.6 (1.3%), get_uri_detail_list:
        1.15 (0.3%), tests_pri_-1000: 6 (1.6%), tests_pri_-950: 1.88 (0.5%),
        tests_pri_-900: 1.57 (0.4%), tests_pri_-90: 55 (14.8%), check_bayes:
        53 (14.3%), b_tokenize: 7 (2.0%), b_tok_get_all: 6 (1.6%),
        b_comp_prob: 2.6 (0.7%), b_tok_touch_all: 33 (9.0%), b_finish: 1.00
        (0.3%), tests_pri_0: 263 (71.4%), check_dkim_signature: 0.89 (0.2%),
        check_dkim_adsp: 3.7 (1.0%), poll_dns_idle: 0.66 (0.2%), tests_pri_10:
        2.2 (0.6%), tests_pri_500: 6 (1.7%), rewrite_mail: 0.00 (0.0%)
Subject: [PATCH v2 0/6] exec: s/group_exit_task/group_exec_task/ for clarity
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


There is a variable tsk->signal->group_exit_task that is only truly used
in de_thread.  These changes modify the coredump code and the
signal_group_exit() function to stop using group_exit_task, and rename
the group_exit_task variable to group_exec_task.

In addition as I think Linus was asking an additional signal flag is
added called SIGNAL_GROUP_DETHREAD, and that flag is used in the
function signal_group_exit() so that only signal->flags needs to be
tested.

Eric W. Biederman (6):
      signal: Pretty up the SIGNAL_GROUP_FLAGS
      exec: Lock more defensively in exec
      signal: Implement SIGNAL_GROUP_DETHREAD
      signal: In signal_group_exit remove the group_exit_task test
      coredump: Stop using group_exit_task
      exec: Rename group_exit_task group_exec_task and correct the Documentation

 fs/coredump.c                |  2 --
 fs/exec.c                    | 22 ++++++++++++++++------
 include/linux/sched/signal.h | 33 +++++++++++++++++----------------
 kernel/exit.c                |  4 ++--
 4 files changed, 35 insertions(+), 26 deletions(-)
