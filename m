Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D24B02124F8
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Jul 2020 15:41:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729313AbgGBNl1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 2 Jul 2020 09:41:27 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:56554 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729171AbgGBNl0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 2 Jul 2020 09:41:26 -0400
Received: from fsav303.sakura.ne.jp (fsav303.sakura.ne.jp [153.120.85.134])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 062DeGHr064859;
        Thu, 2 Jul 2020 22:40:16 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav303.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav303.sakura.ne.jp);
 Thu, 02 Jul 2020 22:40:16 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav303.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 062DeAdE064698
        (version=TLSv1.2 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Thu, 2 Jul 2020 22:40:16 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [PATCH v2 00/15] Make the user mode driver code a better citizen
To:     "Eric W. Biederman" <ebiederm@xmission.com>
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
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <757f37f8-5641-91d2-be80-a96ebc74cacb@i-love.sakura.ne.jp>
Date:   Thu, 2 Jul 2020 22:40:09 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <87pn9euks9.fsf@x220.int.ebiederm.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2020/07/02 22:08, Eric W. Biederman wrote:
> Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp> writes:
> 
>> On 2020/06/30 21:29, Eric W. Biederman wrote:
>>> Hmm.  The wake up happens just of tgid->wait_pidfd happens just before
>>> release_task is called so there is a race.  As it is possible to wake
>>> up and then go back to sleep before pid_has_task becomes false.
>>
>> What is the reason we want to wait until pid_has_task() becomes false?
>>
>> - wait_event(tgid->wait_pidfd, !pid_has_task(tgid, PIDTYPE_TGID));
>> + while (!wait_event_timeout(tgid->wait_pidfd, !pid_has_task(tgid, PIDTYPE_TGID), 1));
> 
> So that it is safe to call bpfilter_umh_cleanup.  The previous code
> performed the wait by having a callback in do_exit.

But bpfilter_umh_cleanup() does only

	fput(info->pipe_to_umh);
	fput(info->pipe_from_umh);
	put_pid(info->tgid);
	info->tgid = NULL;

which is (I think) already safe regardless of the usermode process because
bpfilter_umh_cleanup() merely closes one side of two pipes used between
two processes and forgets about the usermode process.

> 
> It might be possible to call bpf_umh_cleanup early but I have not done
> that analysis.
> 
> To perform the test correctly what I have right now is:

Waiting for the termination of a SIGKILLed usermode process is not
such simple. If a usermode process was killed by the OOM killer, it
might take minutes for the killed process to reach do_exit() due to
invisible memory allocation dependency chain. Since the OOM killer
kicks the OOM reaper, and the OOM reaper forgets about the killed
process after one second if mmap_sem could not be held (in order to
avoid OOM deadlock), the OOM situation will be eventually solved; but
there is no guarantee that the killed process can reach do_exit()
in a short period.

