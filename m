Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E44B53A5069
	for <lists+linux-fsdevel@lfdr.de>; Sat, 12 Jun 2021 21:48:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230136AbhFLTtt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 12 Jun 2021 15:49:49 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:58004 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229753AbhFLTts (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 12 Jun 2021 15:49:48 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out01.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1ls9bd-00B7yK-Dq; Sat, 12 Jun 2021 13:47:45 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=email.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1ls9ba-00839m-4V; Sat, 12 Jun 2021 13:47:44 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Bernd Edlinger <bernd.edlinger@hotmail.de>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>, Shuah Khan <shuah@kernel.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Michal Hocko <mhocko@suse.com>,
        Serge Hallyn <serge@hallyn.com>,
        James Morris <jamorris@linux.microsoft.com>,
        Charles Haithcock <chaithco@redhat.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Yafang Shao <laoar.shao@gmail.com>,
        Helge Deller <deller@gmx.de>,
        YiFei Zhu <yifeifz2@illinois.edu>,
        Adrian Reber <areber@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jens Axboe <axboe@kernel.dk>,
        "linux-fsdevel\@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-kselftest@vger.kernel.org
References: <AM8PR10MB4708AFBD838138A84CE89EF8E4359@AM8PR10MB4708.EURPRD10.PROD.OUTLOOK.COM>
        <20210610143642.e4535dbdc0db0b1bd3ee5367@linux-foundation.org>
Date:   Sat, 12 Jun 2021 14:44:05 -0500
In-Reply-To: <20210610143642.e4535dbdc0db0b1bd3ee5367@linux-foundation.org>
        (Andrew Morton's message of "Thu, 10 Jun 2021 14:36:42 -0700")
Message-ID: <87eed6zx4q.fsf@disp2133>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1ls9ba-00839m-4V;;;mid=<87eed6zx4q.fsf@disp2133>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+Lb/nnF3A2u0YB7jYNPcnJEbfzC5VPB3M=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa07.xmission.com
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,T_TooManySym_01,XMSubLong
        autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.7 XMSubLong Long Subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa07 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa07 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Andrew Morton <akpm@linux-foundation.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 2478 ms - load_scoreonly_sql: 0.07 (0.0%),
        signal_user_changed: 11 (0.5%), b_tie_ro: 10 (0.4%), parse: 1.04
        (0.0%), extract_message_metadata: 20 (0.8%), get_uri_detail_list: 1.00
        (0.0%), tests_pri_-1000: 18 (0.7%), tests_pri_-950: 1.29 (0.1%),
        tests_pri_-900: 1.11 (0.0%), tests_pri_-90: 2229 (89.9%), check_bayes:
        2217 (89.5%), b_tokenize: 7 (0.3%), b_tok_get_all: 6 (0.3%),
        b_comp_prob: 2.2 (0.1%), b_tok_touch_all: 2197 (88.7%), b_finish: 1.18
        (0.0%), tests_pri_0: 181 (7.3%), check_dkim_signature: 0.54 (0.0%),
        check_dkim_adsp: 3.0 (0.1%), poll_dns_idle: 1.15 (0.0%), tests_pri_10:
        3.0 (0.1%), tests_pri_500: 9 (0.4%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCHv8] exec: Fix dead-lock in de_thread with ptrace_attach
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Andrew Morton <akpm@linux-foundation.org> writes:

> On Thu, 10 Jun 2021 09:31:42 +0200 Bernd Edlinger <bernd.edlinger@hotmail.de> wrote:
>
>> This introduces signal->unsafe_execve_in_progress,
>> which is used to fix the case when at least one of the
>> sibling threads is traced, and therefore the trace
>> process may dead-lock in ptrace_attach, but de_thread
>> will need to wait for the tracer to continue execution.
>
> Deadlocks are serious.  Is this exploitable by unprivileged userspace?

The processes are killable so I don't think this is the serious in the
way you mean.  In fact Linus has already said that it is not a deadlock.

Eric
