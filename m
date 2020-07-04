Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E887221446B
	for <lists+linux-fsdevel@lfdr.de>; Sat,  4 Jul 2020 08:59:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727017AbgGDG6y (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 4 Jul 2020 02:58:54 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:55118 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726157AbgGDG6y (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 4 Jul 2020 02:58:54 -0400
Received: from fsav110.sakura.ne.jp (fsav110.sakura.ne.jp [27.133.134.237])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 0646vmDZ037624;
        Sat, 4 Jul 2020 15:57:48 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav110.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav110.sakura.ne.jp);
 Sat, 04 Jul 2020 15:57:48 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav110.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 0646vcQt037357
        (version=TLSv1.2 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Sat, 4 Jul 2020 15:57:47 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [PATCH v2 00/15] Make the user mode driver code a better citizen
To:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Cc:     Casey Schaufler <casey@schaufler-ca.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
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
 <d0266a24-dfab-83d0-e178-aa67c9f5ebc0@i-love.sakura.ne.jp>
 <87lfk0nslu.fsf@x220.int.ebiederm.org>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <ec6a6e18-d7aa-3072-c8dc-b925398b8409@i-love.sakura.ne.jp>
Date:   Sat, 4 Jul 2020 15:57:38 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <87lfk0nslu.fsf@x220.int.ebiederm.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2020/07/04 7:25, Eric W. Biederman wrote:
> Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp> writes:
> 
>> On 2020/07/02 22:08, Eric W. Biederman wrote:
>>>> By the way, commit 4a9d4b024a3102fc ("switch fput to task_work_add") says
>>>> that use of flush_delayed_fput() has to be careful. Al, is it safe to call
>>>> flush_delayed_fput() from blob_to_mnt() from umd_load_blob() (which might be
>>>> called from both kernel thread and from process context (e.g. init_module()
>>>> syscall by /sbin/insmod )) ?
>>>
>>> And __fput_sync needs to be even more careful.
>>> umd_load_blob is called in these changes without any locks held.
>>
>> But where is the guarantee that a thread which called flush_delayed_fput() waits for
>> the completion of processing _all_ "struct file" linked into delayed_fput_list ?
>> If some other thread or delayed_fput_work (scheduled by fput_many()) called
>> flush_delayed_fput() between blob_to_mnt()'s fput(file) and flush_delayed_fput()
>> sequence? blob_to_mnt()'s flush_delayed_fput() can miss the "struct file" which
>> needs to be processed before execve(), can't it?
> 
> As a module the guarantee is we call task_work_run.

No. It is possible that blob_to_mnt() is called by a kernel thread which was
started by init_module() syscall by /sbin/insmod .

> Built into the kernel the guarantee as best I can trace it is that
> kthreadd hasn't started, and as such nothing that is scheduled has run
> yet.

Have you ever checked how early the kthreadd (PID=2) gets started?

----------
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -2306,6 +2306,7 @@ static __latent_entropy struct task_struct *copy_process(
        trace_task_newtask(p, clone_flags);
        uprobe_copy_process(p, clone_flags);

+       printk(KERN_INFO "Created PID: %u Comm: %s\n", p->pid, p->comm);
        return p;

 bad_fork_cancel_cgroup:
----------

----------
[    0.090757][    T0] pid_max: default: 65536 minimum: 512
[    0.090890][    T0] LSM: Security Framework initializing
[    0.090890][    T0] Mount-cache hash table entries: 8192 (order: 4, 65536 bytes, linear)
[    0.090890][    T0] Mountpoint-cache hash table entries: 8192 (order: 4, 65536 bytes, linear)
[    0.090890][    T0] Disabled fast string operations
[    0.090890][    T0] Last level iTLB entries: 4KB 1024, 2MB 1024, 4MB 1024
[    0.090890][    T0] Last level dTLB entries: 4KB 1024, 2MB 1024, 4MB 1024, 1GB 4
[    0.090890][    T0] Spectre V1 : Mitigation: usercopy/swapgs barriers and __user pointer sanitization
[    0.090890][    T0] Spectre V2 : Spectre mitigation: kernel not compiled with retpoline; no mitigation available!
[    0.090890][    T0] Speculative Store Bypass: Mitigation: Speculative Store Bypass disabled via prctl and seccomp
[    0.090890][    T0] SRBDS: Unknown: Dependent on hypervisor status
[    0.090890][    T0] MDS: Mitigation: Clear CPU buffers
[    0.090890][    T0] Freeing SMP alternatives memory: 24K
[    0.090890][    T0] Created PID: 1 Comm: swapper/0
[    0.090890][    T0] Created PID: 2 Comm: swapper/0
[    0.090890][    T1] smpboot: CPU0: Intel(R) Core(TM) i5-4440S CPU @ 2.80GHz (family: 0x6, model: 0x3c, stepping: 0x3)
[    0.091000][    T2] Created PID: 3 Comm: kthreadd
[    0.091995][    T2] Created PID: 4 Comm: kthreadd
[    0.093028][    T2] Created PID: 5 Comm: kthreadd
[    0.093997][    T2] Created PID: 6 Comm: kthreadd
[    0.094995][    T2] Created PID: 7 Comm: kthreadd
[    0.096037][    T2] Created PID: 8 Comm: kthreadd
(...snipped...)
[    0.135716][    T2] Created PID: 13 Comm: kthreadd
[    0.135716][    T1] smp: Bringing up secondary CPUs ...
[    0.135716][    T2] Created PID: 14 Comm: kthreadd
[    0.135716][    T2] Created PID: 15 Comm: kthreadd
[    0.135716][    T2] Created PID: 16 Comm: kthreadd
[    0.135716][    T2] Created PID: 17 Comm: kthreadd
[    0.135716][    T2] Created PID: 18 Comm: kthreadd
[    0.135716][    T1] x86: Booting SMP configuration:
(...snipped...)
[    0.901990][    T1] pci 0000:00:00.0: Limiting direct PCI/PCI transfers
[    0.902145][    T1] pci 0000:00:0f.0: Video device with shadowed ROM at [mem 0x000c0000-0x000dffff]
[    0.902213][    T1] pci 0000:02:00.0: CLS mismatch (32 != 64), using 64 bytes
[    0.902224][    T1] Trying to unpack rootfs image as initramfs...
[    1.107993][    T1] Freeing initrd memory: 18876K
[    1.109049][    T1] PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
[    1.111003][    T1] software IO TLB: mapped [mem 0xab000000-0xaf000000] (64MB)
[    1.112136][    T1] check: Scanning for low memory corruption every 60 seconds
[    1.115040][    T2] Created PID: 52 Comm: kthreadd
[    1.116110][    T1] workingset: timestamp_bits=46 max_order=20 bucket_order=0
[    1.120936][    T1] SGI XFS with ACLs, security attributes, verbose warnings, quota, no debug enabled
[    1.129626][    T2] Created PID: 53 Comm: kthreadd
[    1.131403][    T2] Created PID: 54 Comm: kthreadd
----------

kthreadd (PID=2) is created by swapper/0 (PID=0) immediately after init (PID=1) was created by
swapper/0 (PID=0). It is even before secondary CPUs are brought up, and far earlier than unpacking
initramfs.

And how can we prove that blob_to_mnt() is only called by a kernel thread before some kernel
thread that interferes fput() starts running? blob_to_mnt() needs to be prepared for being
called after many processes already started running.

> 
>> Also, I don't know how convoluted the dependency of all "struct file" linked into
>> delayed_fput_list might be, for there can be "struct file" which will not be a
>> simple close of tmpfs file created by blob_to_mnt()'s file_open_root() request.
>>
>> On the other hand, although __fput_sync() cannot be called from !PF_KTHREAD threads,
>> there is a guarantee that __fput_sync() waits for the completion of "struct file"
>> which needs to be flushed before execve(), isn't there?
> 
> There is really not a good helper or helpers, and this code suggests we
> have something better.  Right now I have used the existing helpers to
> the best of my ability.  If you or someone else wants to write a better
> version of flushing so that exec can happen be my guest.
> 
> As far as I can tell what I have is good enough.

Just saying what you think is not a "review". I'm waiting for answer from Al Viro
because I consider that Al will be the most familiar with fput()'s behavior.
At least I consider that

	if (current->flags & PF_KTHREAD) {
		__fput_sync(file);
	} else {
		fput(file);
		task_work_run();
	}

is a candidate for closing the race window. And depending on Al's answer,
removing

	BUG_ON(!(task->flags & PF_KTHREAD));

 from __fput_sync() and unconditionally using

	__fput_sync(file);

 from blob_to_mnt() might be the better choice. Anyway, I consider that
Al's response is important for this "review".

> 
>>> We fundamentally AKA in any correct version of this code need to flush
>>> the file descriptor before we call exec or exec can not open it a
>>> read-only denying all writes from any other opens.
>>>
>>> The use case of flush_delayed_fput is exactly the same as that used
>>> when loading the initramfs.
>>
>> When loading the initramfs, the number of threads is quite few (which
>> means that the possibility of hitting the race window and convoluted
>> dependency is small).
> 
> But the reality is the code run very early, before the initramfs is
> initialized in practice.

Such expectation is not a reality.

> 
>> But like EXPORT_SYMBOL_GPL(umd_load_blob) indicates, blob_to_mnt()'s
>> flush_delayed_fput() might be called after many number of threads already
>> started running.
> 
> At which point the code probably won't be runnig from a kernel thread
> but instead will be running in a thread where task_work_run is relevant.

No. It is possible that blob_to_mnt() is called by a kernel thread which was
started by init_module() syscall by /sbin/insmod .

> 
> At worst it is a very small race, where someone else in another thread
> starts flushing the file.  Which means the file could still be
> completely close before exec.   Even that is not necessarily fatal,
> as the usermode driver code has a respawn capability.
> 
> Code that is used enough that it hits that race sounds like a very
> good problem to have from the perspective of the usermode driver code.

In general, unconditionally retrying call_usermodehelper() when it returned
a negative value (e.g. -ENOENT, -ENOMEM, -EBUSY) is bad. I don't know which
code is an implementation of "a respawn capability"; I'd like to check where
that code is and whether that code is checking -ETXTBSY.

