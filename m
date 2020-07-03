Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABBE4213AC5
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Jul 2020 15:20:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726276AbgGCNU0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 3 Jul 2020 09:20:26 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:64056 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726022AbgGCNUZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 3 Jul 2020 09:20:25 -0400
Received: from fsav402.sakura.ne.jp (fsav402.sakura.ne.jp [133.242.250.101])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 063DJNb2024792;
        Fri, 3 Jul 2020 22:19:23 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav402.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav402.sakura.ne.jp);
 Fri, 03 Jul 2020 22:19:23 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav402.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 063DJMxC024786
        (version=TLSv1.2 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Fri, 3 Jul 2020 22:19:23 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [PATCH v2 00/15] Make the user mode driver code a better citizen
To:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Casey Schaufler <casey@schaufler-ca.com>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        linux-kernel@vger.kernel.org, David Miller <davem@davemloft.net>,
        Greg Kroah-Hartman <greg@kroah.com>,
        Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexei Starovoitov <ast@kernel.org>, bpf <bpf@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Gary Lin <GLin@suse.com>, Bruno Meneguele <bmeneg@redhat.com>,
        LSM List <linux-security-module@vger.kernel.org>,
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
 <87h7upucqi.fsf@x220.int.ebiederm.org>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <d0266a24-dfab-83d0-e178-aa67c9f5ebc0@i-love.sakura.ne.jp>
Date:   Fri, 3 Jul 2020 22:19:17 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <87h7upucqi.fsf@x220.int.ebiederm.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2020/07/02 22:08, Eric W. Biederman wrote:
>> By the way, commit 4a9d4b024a3102fc ("switch fput to task_work_add") says
>> that use of flush_delayed_fput() has to be careful. Al, is it safe to call
>> flush_delayed_fput() from blob_to_mnt() from umd_load_blob() (which might be
>> called from both kernel thread and from process context (e.g. init_module()
>> syscall by /sbin/insmod )) ?
> 
> And __fput_sync needs to be even more careful.
> umd_load_blob is called in these changes without any locks held.

But where is the guarantee that a thread which called flush_delayed_fput() waits for
the completion of processing _all_ "struct file" linked into delayed_fput_list ?
If some other thread or delayed_fput_work (scheduled by fput_many()) called
flush_delayed_fput() between blob_to_mnt()'s fput(file) and flush_delayed_fput()
sequence? blob_to_mnt()'s flush_delayed_fput() can miss the "struct file" which
needs to be processed before execve(), can't it?

Also, I don't know how convoluted the dependency of all "struct file" linked into
delayed_fput_list might be, for there can be "struct file" which will not be a
simple close of tmpfs file created by blob_to_mnt()'s file_open_root() request.

On the other hand, although __fput_sync() cannot be called from !PF_KTHREAD threads,
there is a guarantee that __fput_sync() waits for the completion of "struct file"
which needs to be flushed before execve(), isn't there?

> 
> We fundamentally AKA in any correct version of this code need to flush
> the file descriptor before we call exec or exec can not open it a
> read-only denying all writes from any other opens.
> 
> The use case of flush_delayed_fput is exactly the same as that used
> when loading the initramfs.

When loading the initramfs, the number of threads is quite few (which
means that the possibility of hitting the race window and convoluted
dependency is small).

But like EXPORT_SYMBOL_GPL(umd_load_blob) indicates, blob_to_mnt()'s
flush_delayed_fput() might be called after many number of threads already
started running.



On 2020/07/03 1:02, Eric W. Biederman wrote:
>>>> On 2020/06/30 21:29, Eric W. Biederman wrote:
>>>>> Hmm.  The wake up happens just of tgid->wait_pidfd happens just before
>>>>> release_task is called so there is a race.  As it is possible to wake
>>>>> up and then go back to sleep before pid_has_task becomes false.
>>>>
>>>> What is the reason we want to wait until pid_has_task() becomes false?
>>>>
>>>> - wait_event(tgid->wait_pidfd, !pid_has_task(tgid, PIDTYPE_TGID));
>>>> + while (!wait_event_timeout(tgid->wait_pidfd, !pid_has_task(tgid, PIDTYPE_TGID), 1));
>>>
>>> So that it is safe to call bpfilter_umh_cleanup.  The previous code
>>> performed the wait by having a callback in do_exit.
>>
>> But bpfilter_umh_cleanup() does only
>>
>> 	fput(info->pipe_to_umh);
>> 	fput(info->pipe_from_umh);
>> 	put_pid(info->tgid);
>> 	info->tgid = NULL;
>>
>> which is (I think) already safe regardless of the usermode process because
>> bpfilter_umh_cleanup() merely closes one side of two pipes used between
>> two processes and forgets about the usermode process.
> 
> It is not safe.
> 
> Baring bugs there is only one use of shtudown_umh that matters.  The one
> in fini_umh.  The use of the file by the mm must be finished before
> umd_unload_blob.  AKA unmount.  Which completely frees the filesystem.

Do we really need to mount upon umd_load_blob() and unmount upon umd_unload_blob() ?
LSM modules might prefer only one instance of filesystem for umd blobs.

For pathname based LSMs, since that filesystem is not visible from mount tree, only
info->driver_name can be used for distinction. Therefore, one instance of filesystem
with files created with file_open_root(O_CREAT | O_WRONLY | O_EXCL) might be preferable.

For inode based LSMs, reusing one instance of filesystem created upon early boot might
be convenient for labeling.

Also, we might want a dedicated filesystem (say, "umdfs") instead of regular tmpfs in
order to implement protections without labeling files. Then, we might also be able to
implement minimal protections without LSMs.

