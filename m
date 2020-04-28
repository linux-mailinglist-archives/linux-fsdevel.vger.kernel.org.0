Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 863491BCB90
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Apr 2020 20:59:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729619AbgD1S6C (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Apr 2020 14:58:02 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:39868 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728934AbgD1S6A (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Apr 2020 14:58:00 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out01.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1jTVQc-00065Q-TV; Tue, 28 Apr 2020 12:57:58 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1jTVQc-00082d-3W; Tue, 28 Apr 2020 12:57:58 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Alexey Gladkov <legion@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexey Gladkov <gladkov.alexey@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E. McKenney" <paulmck@kernel.org>
References: <20200419141057.621356-1-gladkov.alexey@gmail.com>
        <87ftcv1nqe.fsf@x220.int.ebiederm.org>
        <87wo66vvnm.fsf_-_@x220.int.ebiederm.org>
        <20200424173927.GB26802@redhat.com>
        <87mu6ymkea.fsf_-_@x220.int.ebiederm.org>
        <875zdmmj4y.fsf_-_@x220.int.ebiederm.org>
        <CAHk-=whvktUC9VbzWLDw71BHbV4ofkkuAYsrB5Rmxnhc-=kSeQ@mail.gmail.com>
        <878sihgfzh.fsf@x220.int.ebiederm.org>
        <CAHk-=wjSM9mgsDuX=ZTy2L+S7wGrxZMcBn054As_Jyv8FQvcvQ@mail.gmail.com>
        <87sggnajpv.fsf_-_@x220.int.ebiederm.org>
        <20200428180540.GB29960@redhat.com>
Date:   Tue, 28 Apr 2020 13:54:43 -0500
In-Reply-To: <20200428180540.GB29960@redhat.com> (Oleg Nesterov's message of
        "Tue, 28 Apr 2020 20:05:41 +0200")
Message-ID: <875zdj8mq4.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1jTVQc-00082d-3W;;;mid=<875zdj8mq4.fsf@x220.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18ie873QmSJRuG7xLnHvzMNPbq5XK7pRSI=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa07.xmission.com
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,XMSubLong autolearn=disabled
        version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4687]
        *  0.7 XMSubLong Long Subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa07 1397; Body=1 Fuz1=1 Fuz2=1]
X-Spam-DCC: XMission; sa07 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Oleg Nesterov <oleg@redhat.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 369 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 12 (3.2%), b_tie_ro: 10 (2.8%), parse: 1.01
        (0.3%), extract_message_metadata: 3.4 (0.9%), get_uri_detail_list:
        1.26 (0.3%), tests_pri_-1000: 3.5 (1.0%), tests_pri_-950: 1.22 (0.3%),
        tests_pri_-900: 0.98 (0.3%), tests_pri_-90: 148 (40.1%), check_bayes:
        147 (39.7%), b_tokenize: 6 (1.6%), b_tok_get_all: 6 (1.7%),
        b_comp_prob: 1.98 (0.5%), b_tok_touch_all: 129 (34.9%), b_finish: 0.93
        (0.3%), tests_pri_0: 182 (49.3%), check_dkim_signature: 0.59 (0.2%),
        check_dkim_adsp: 2.4 (0.7%), poll_dns_idle: 0.67 (0.2%), tests_pri_10:
        2.2 (0.6%), tests_pri_500: 6 (1.6%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH v4 0/2] proc: Ensure we see the exit of each process tid exactly
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Oleg Nesterov <oleg@redhat.com> writes:

> On 04/28, Eric W. Biederman wrote:
>>
>> In short I don't think this change will introduce any regressions.
>>
>> Eric W. Biederman (2):
>>       rculist: Add hlists_swap_heads_rcu
>>       proc: Ensure we see the exit of each process tid exactly once
>
> Eric, sorry, I got lost.
>
> Both changes look good to me, feel free to add my ack, but I presume
> this is on top of next_tgid/lookup_task changes ? If yes, why did not
> you remove has_group_leader_pid?

On top of next_tgid.

Upon a close examination there are not any current bugs in
posix-cpu-timers nor is there anything that exchange_tids
will make worse.

I am preparing a follow on patchset to kill has_group_leader_pid.

I am preparing a further follow on patchset to see if I can get that
code to start returning pids, because that is cheaper and clearer.


I pushed those changes a little farther out so I could maintain focus on
what I am accomplishing.

Adding exchange_tids was difficult because I had to audit pretty much
all of the pid use in the kernel to see if the small change in behavior
would make anything worse.   The rest of the changes should be simpler
and more localized so I hope they go faster.

Eric

