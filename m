Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F5222128FE
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Jul 2020 18:07:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726260AbgGBQG5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 2 Jul 2020 12:06:57 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:35464 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726082AbgGBQG5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 2 Jul 2020 12:06:57 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out01.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1jr1je-0001Ce-Ig; Thu, 02 Jul 2020 10:06:50 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1jr1jd-0001tc-9M; Thu, 02 Jul 2020 10:06:50 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        linux-kernel@vger.kernel.org, David Miller <davem@davemloft.net>,
        Greg Kroah-Hartman <greg@kroah.com>,
        Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>, bpf <bpf@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Gary Lin <GLin@suse.com>, Bruno Meneguele <bmeneg@redhat.com>,
        LSM List <linux-security-module@vger.kernel.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
References: <20200625095725.GA3303921@kroah.com>
        <778297d2-512a-8361-cf05-42d9379e6977@i-love.sakura.ne.jp>
        <20200625120725.GA3493334@kroah.com>
        <20200625.123437.2219826613137938086.davem@davemloft.net>
        <CAHk-=whuTwGHEPjvtbBvneHHXeqJC=q5S09mbPnqb=Q+MSPMag@mail.gmail.com>
        <87pn9mgfc2.fsf_-_@x220.int.ebiederm.org>
        <87y2oac50p.fsf@x220.int.ebiederm.org>
        <87bll17ili.fsf_-_@x220.int.ebiederm.org>
        <20200629221231.jjc2czk3ul2roxkw@ast-mbp.dhcp.thefacebook.com>
        <87eepwzqhd.fsf@x220.int.ebiederm.org>
        <1f4d8b7e-bcff-f950-7dac-76e3c4a65661@i-love.sakura.ne.jp>
        <87pn9euks9.fsf@x220.int.ebiederm.org>
        <757f37f8-5641-91d2-be80-a96ebc74cacb@i-love.sakura.ne.jp>
Date:   Thu, 02 Jul 2020 11:02:13 -0500
In-Reply-To: <757f37f8-5641-91d2-be80-a96ebc74cacb@i-love.sakura.ne.jp>
        (Tetsuo Handa's message of "Thu, 2 Jul 2020 22:40:09 +0900")
Message-ID: <87h7upucqi.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1jr1jd-0001tc-9M;;;mid=<87h7upucqi.fsf@x220.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+Qp30pcQd+q4FhKljd+sR/8XsbQDCsYXo=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa05.xmission.com
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,XMSubLong autolearn=disabled
        version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.7 XMSubLong Long Subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa05 0; Body=1 Fuz1=1 Fuz2=1]
X-Spam-DCC: ; sa05 0; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
X-Spam-Relay-Country: 
X-Spam-Timing: total 932 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 11 (1.2%), b_tie_ro: 9 (1.0%), parse: 1.00 (0.1%),
         extract_message_metadata: 12 (1.3%), get_uri_detail_list: 1.61 (0.2%),
         tests_pri_-1000: 6 (0.6%), tests_pri_-950: 1.27 (0.1%),
        tests_pri_-900: 1.01 (0.1%), tests_pri_-90: 135 (14.5%), check_bayes:
        132 (14.2%), b_tokenize: 9 (0.9%), b_tok_get_all: 11 (1.1%),
        b_comp_prob: 3.1 (0.3%), b_tok_touch_all: 106 (11.4%), b_finish: 1.12
        (0.1%), tests_pri_0: 706 (75.7%), check_dkim_signature: 1.02 (0.1%),
        check_dkim_adsp: 3.0 (0.3%), poll_dns_idle: 0.37 (0.0%), tests_pri_10:
        3.1 (0.3%), tests_pri_500: 53 (5.7%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH v2 00/15] Make the user mode driver code a better citizen
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp> writes:

> On 2020/07/02 22:08, Eric W. Biederman wrote:
>> Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp> writes:
>> 
>>> On 2020/06/30 21:29, Eric W. Biederman wrote:
>>>> Hmm.  The wake up happens just of tgid->wait_pidfd happens just before
>>>> release_task is called so there is a race.  As it is possible to wake
>>>> up and then go back to sleep before pid_has_task becomes false.
>>>
>>> What is the reason we want to wait until pid_has_task() becomes false?
>>>
>>> - wait_event(tgid->wait_pidfd, !pid_has_task(tgid, PIDTYPE_TGID));
>>> + while (!wait_event_timeout(tgid->wait_pidfd, !pid_has_task(tgid, PIDTYPE_TGID), 1));
>> 
>> So that it is safe to call bpfilter_umh_cleanup.  The previous code
>> performed the wait by having a callback in do_exit.
>
> But bpfilter_umh_cleanup() does only
>
> 	fput(info->pipe_to_umh);
> 	fput(info->pipe_from_umh);
> 	put_pid(info->tgid);
> 	info->tgid = NULL;
>
> which is (I think) already safe regardless of the usermode process because
> bpfilter_umh_cleanup() merely closes one side of two pipes used between
> two processes and forgets about the usermode process.

It is not safe.

Baring bugs there is only one use of shtudown_umh that matters.  The one
in fini_umh.  The use of the file by the mm must be finished before
umd_unload_blob.  AKA unmount.  Which completely frees the filesystem.

>> It might be possible to call bpf_umh_cleanup early but I have not done
>> that analysis.
>> 
>> To perform the test correctly what I have right now is:
>
> Waiting for the termination of a SIGKILLed usermode process is not
> such simple.

The waiting is that simple.

You are correct it might not be a quick process.

A good general principle is to start with something simple and correct
for what it does, and then to make it more complicated when real world
cases show up, and it can be understood what the real challenges are.

I am not going to merge known broken code but I am also not going to
overcomplicate it.

Dealing with very rare and pathological cases that are not handled or
considered today is out of scope for my patchset.

Eric
