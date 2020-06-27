Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0C2620BD92
	for <lists+linux-fsdevel@lfdr.de>; Sat, 27 Jun 2020 03:27:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726486AbgF0B1o (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 26 Jun 2020 21:27:44 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:53379 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726101AbgF0B1o (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 26 Jun 2020 21:27:44 -0400
Received: from fsav403.sakura.ne.jp (fsav403.sakura.ne.jp [133.242.250.102])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 05R1QYhN024426;
        Sat, 27 Jun 2020 10:26:35 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav403.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav403.sakura.ne.jp);
 Sat, 27 Jun 2020 10:26:34 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav403.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 05R1QYj1024423
        (version=TLSv1.2 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Sat, 27 Jun 2020 10:26:34 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [PATCH 05/14] umh: Separate the user mode driver and the user
 mode helper support
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        David Miller <davem@davemloft.net>,
        Greg Kroah-Hartman <greg@kroah.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
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
        Casey Schaufler <casey@schaufler-ca.com>
References: <20200625095725.GA3303921@kroah.com>
 <778297d2-512a-8361-cf05-42d9379e6977@i-love.sakura.ne.jp>
 <20200625120725.GA3493334@kroah.com>
 <20200625.123437.2219826613137938086.davem@davemloft.net>
 <CAHk-=whuTwGHEPjvtbBvneHHXeqJC=q5S09mbPnqb=Q+MSPMag@mail.gmail.com>
 <87pn9mgfc2.fsf_-_@x220.int.ebiederm.org>
 <87tuyyf0ln.fsf_-_@x220.int.ebiederm.org>
 <5ce4d340-096a-f468-6719-4c34a951511e@i-love.sakura.ne.jp>
 <87d05lbwt4.fsf@x220.int.ebiederm.org>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <32604829-35f7-5263-aff1-27808500c1d1@i-love.sakura.ne.jp>
Date:   Sat, 27 Jun 2020 10:26:33 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <87d05lbwt4.fsf@x220.int.ebiederm.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2020/06/27 1:45, Eric W. Biederman wrote:
>> After this cleanup, I expect adding some protections/isolation which kernel threads
>> have (e.g. excluded from ptrace(), excluded from OOM victim selection, excluded from
>> SysRq-i, won't be terminated by SIGKILL from usermode processes, won't be stopped by
>> SIGSTOP from usermode processes, what else?). Doing it means giving up Alexei's
>>
>>   It's nice to be able to compile that blob with -g and be able to 'gdb -p' into it.
>>   That works and very convenient when it comes to debugging. Compare that to debugging
>>   a kernel module!
>>
>> but I think doing it is essential for keeping usermode blob processes as secure/robust
>> as kernel threads.
> 
> Do you have an application for a user mode driver?

No, I'm not a user of this interface.

> 
> I think concerns like that are best addressed in the context of a
> specific driver/usecase.  Just to make certain we are solving the right
> problems.
> 
> My sense is that an advantage of user mode drivers can safely be buggier
> than kernel drivers and the freedom to kill them when the drivers go
> wrong (knowing the drivers will restart) is important.

Right. Segmentation fault in user mode drivers does not cause a kernel oops
is an advantage of user mode drivers. But the freedom to disturb/kill user mode
drivers due to interference like ptrace()/signals from user mode processes,
SIGKILL from OOM-killer/SysRq-i etc. is a big disadvantage of user mode drivers.
I expect that user mode drivers should be killable only when the manager
interface detected that user mode drivers need to be stopped (or restarted).

One of advantages kernel mode drivers have is that their memory is not swapped
out/in. I don't know whether mlockall(MCL_FUTURE) should be automatically applied
to user mode drivers.

> 
> Does this series by using the normal path through exec solve your
> concerns with LSMs being able to identify these processes (both
> individually and as class)?.

I guess "yes" for pathname based LSMs. Though, TOMOYO wants to obtain both
AT_SYMLINK_NOFOLLOW "struct path" and !AT_SYMLINK_NOFOLLOW "struct path"
at do_open_execat() from do_execveat_common().

I guess "no" for inode based LSMs, for they want a chance to associate
security labels at blob_to_mnt().

