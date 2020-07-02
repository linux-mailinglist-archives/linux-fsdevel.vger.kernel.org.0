Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B76221244B
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Jul 2020 15:13:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729119AbgGBNNE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 2 Jul 2020 09:13:04 -0400
Received: from out02.mta.xmission.com ([166.70.13.232]:56368 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726289AbgGBNND (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 2 Jul 2020 09:13:03 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out02.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1jqz1O-0000rK-6O; Thu, 02 Jul 2020 07:12:58 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1jqz1M-0001eL-Tx; Thu, 02 Jul 2020 07:12:58 -0600
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
Date:   Thu, 02 Jul 2020 08:08:22 -0500
In-Reply-To: <1f4d8b7e-bcff-f950-7dac-76e3c4a65661@i-love.sakura.ne.jp>
        (Tetsuo Handa's message of "Tue, 30 Jun 2020 22:21:19 +0900")
Message-ID: <87pn9euks9.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1jqz1M-0001eL-Tx;;;mid=<87pn9euks9.fsf@x220.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+kQ6VutM5mgPIKiibPM2Pbny1TfBYw3+s=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa06.xmission.com
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,XMSubLong autolearn=disabled
        version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4999]
        *  0.7 XMSubLong Long Subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa06 0; Body=1 Fuz1=1 Fuz2=1]
X-Spam-DCC: ; sa06 0; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
X-Spam-Relay-Country: 
X-Spam-Timing: total 857 ms - load_scoreonly_sql: 0.03 (0.0%),
        signal_user_changed: 10 (1.2%), b_tie_ro: 9 (1.1%), parse: 1.02 (0.1%),
         extract_message_metadata: 12 (1.4%), get_uri_detail_list: 1.50 (0.2%),
         tests_pri_-1000: 6 (0.7%), tests_pri_-950: 1.32 (0.2%),
        tests_pri_-900: 1.04 (0.1%), tests_pri_-90: 240 (28.1%), check_bayes:
        237 (27.7%), b_tokenize: 9 (1.1%), b_tok_get_all: 8 (1.0%),
        b_comp_prob: 2.8 (0.3%), b_tok_touch_all: 213 (24.8%), b_finish: 1.03
        (0.1%), tests_pri_0: 573 (66.9%), check_dkim_signature: 0.58 (0.1%),
        check_dkim_adsp: 2.3 (0.3%), poll_dns_idle: 0.34 (0.0%), tests_pri_10:
        2.1 (0.2%), tests_pri_500: 6 (0.7%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH v2 00/15] Make the user mode driver code a better citizen
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp> writes:

> On 2020/06/30 21:29, Eric W. Biederman wrote:
>> Hmm.  The wake up happens just of tgid->wait_pidfd happens just before
>> release_task is called so there is a race.  As it is possible to wake
>> up and then go back to sleep before pid_has_task becomes false.
>
> What is the reason we want to wait until pid_has_task() becomes false?
>
> - wait_event(tgid->wait_pidfd, !pid_has_task(tgid, PIDTYPE_TGID));
> + while (!wait_event_timeout(tgid->wait_pidfd, !pid_has_task(tgid, PIDTYPE_TGID), 1));

So that it is safe to call bpfilter_umh_cleanup.  The previous code
performed the wait by having a callback in do_exit.

It might be possible to call bpf_umh_cleanup early but I have not done
that analysis.

To perform the test correctly what I have right now is:

bool thread_group_exited(struct pid *pid)
{
	struct task_struct *tsk;
	bool exited;

	rcu_read_lock();
	tsk = pid_task(pid, PIDTYPE_PID);
	exited = !tsk || (READ_ONCE(tsk->exit_state) && thread_group_empty(tsk));
	rcu_read_unlock();

	return exited;
}

Which is factored out of pidfd_poll.  Which means that this won't be
something that the bpfilter code has to maintain.  That seems to be a
fundamentally good facility to have regardless of bpfilter.

I will post the whole thing in a bit once I have a chance to dot my i's
and cross my t's.

> By the way, commit 4a9d4b024a3102fc ("switch fput to task_work_add") says
> that use of flush_delayed_fput() has to be careful. Al, is it safe to call
> flush_delayed_fput() from blob_to_mnt() from umd_load_blob() (which might be
> called from both kernel thread and from process context (e.g. init_module()
> syscall by /sbin/insmod )) ?

And __fput_sync needs to be even more careful.
umd_load_blob is called in these changes without any locks held.

We fundamentally AKA in any correct version of this code need to flush
the file descriptor before we call exec or exec can not open it a
read-only denying all writes from any other opens.

The use case of flush_delayed_fput is exactly the same as that used
when loading the initramfs.

Eric




