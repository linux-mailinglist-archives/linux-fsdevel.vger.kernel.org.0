Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61BCB257AE5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 Aug 2020 15:52:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727956AbgHaNwp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 31 Aug 2020 09:52:45 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:41302 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727946AbgHaNw0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 31 Aug 2020 09:52:26 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out01.mta.xmission.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1kCkEP-00DtQu-Dt; Mon, 31 Aug 2020 07:52:21 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1kCkEO-0002TR-Ej; Mon, 31 Aug 2020 07:52:21 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     peterz@infradead.org
Cc:     syzbot <syzbot+db9cdf3dd1f64252c6ef@syzkaller.appspotmail.com>,
        adobriyan@gmail.com, akpm@linux-foundation.org, avagin@gmail.com,
        christian@brauner.io, gladkov.alexey@gmail.com,
        keescook@chromium.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        walken@google.com, Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Miklos Szeredi <miklos@szeredi.hu>, jannh@google.com
References: <00000000000063640c05ade8e3de@google.com>
        <87mu2fj7xu.fsf@x220.int.ebiederm.org>
        <20200828123720.GZ1362448@hirez.programming.kicks-ass.net>
        <87v9h0gvro.fsf@x220.int.ebiederm.org>
        <20200831074328.GN1362448@hirez.programming.kicks-ass.net>
Date:   Mon, 31 Aug 2020 08:52:16 -0500
In-Reply-To: <20200831074328.GN1362448@hirez.programming.kicks-ass.net>
        (peterz's message of "Mon, 31 Aug 2020 09:43:28 +0200")
Message-ID: <87eenmgbxr.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1kCkEO-0002TR-Ej;;;mid=<87eenmgbxr.fsf@x220.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/pDE+t//a5yiKVsLhDBsA/S8IDZWtzoPo=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa07.xmission.com
X-Spam-Level: 
X-Spam-Status: No, score=-0.2 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG autolearn=disabled
        version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4160]
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa07 0; Body=1 Fuz1=1 Fuz2=1]
X-Spam-DCC: ; sa07 0; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;peterz@infradead.org
X-Spam-Relay-Country: 
X-Spam-Timing: total 579 ms - load_scoreonly_sql: 0.05 (0.0%),
        signal_user_changed: 10 (1.8%), b_tie_ro: 9 (1.5%), parse: 0.90 (0.2%),
         extract_message_metadata: 11 (1.9%), get_uri_detail_list: 1.33 (0.2%),
         tests_pri_-1000: 18 (3.1%), tests_pri_-950: 1.37 (0.2%),
        tests_pri_-900: 1.15 (0.2%), tests_pri_-90: 218 (37.7%), check_bayes:
        216 (37.4%), b_tokenize: 8 (1.4%), b_tok_get_all: 63 (11.0%),
        b_comp_prob: 4.5 (0.8%), b_tok_touch_all: 136 (23.4%), b_finish: 1.18
        (0.2%), tests_pri_0: 306 (52.9%), check_dkim_signature: 0.53 (0.1%),
        check_dkim_adsp: 2.8 (0.5%), poll_dns_idle: 0.77 (0.1%), tests_pri_10:
        2.1 (0.4%), tests_pri_500: 6 (1.1%), rewrite_mail: 0.00 (0.0%)
Subject: Re: possible deadlock in proc_pid_syscall (2)
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

peterz@infradead.org writes:

> On Sun, Aug 30, 2020 at 07:31:39AM -0500, Eric W. Biederman wrote:
>
>> I am thinking that for cases where we want to do significant work it
>> might be better to ask the process to pause at someplace safe (probably
>> get_signal) and then do all of the work when we know nothing is changing
>> in the process.
>> 
>> I don't really like the idea of checking and then checking again.  We
>> might have to do it but it feels like the model is wrong somewhere.
>> 
>> Given that this is tricky to hit in practice, and given that I am
>> already working the general problem of how to sort out the locking I am
>> going to work this with the rest of the thorny issues of in exec.  This
>> feels like a case where the proper solution is that we simply need
>> something better than a mutex.
>
> One possible alternative would be something RCU-like, surround the thing
> with get_task_cred() / put_cred() and then have commit_creds() wait for
> the usage of the old creds to drop to 0 before continuing.
>
> (Also, get_cred_rcu() is disgusting for casting away const)
>
> But this could be complete garbage, I'm not much familiar with any of
> thise code.

This looks like an area of code that will take a couple of passes to get
100% right.

Usually changing creds happens atomically, and separately from
everything else so we simply don't care if there a race,  Either the old
creds or the new creds are valid.

With exec the situation is trickier as several things in addition to the
cred are changing at the same time.  So a lock is needed.

Now that it is separated from the cred_guard_mutex, probably the easiest
solution is to make exec_update_mutex a sleeping reader writer lock.
There are fewer cases that matter as such a lock would only block on
exec (the writer).

I don't understand perf well enough to do much without carefully
studying the code.

Eric







