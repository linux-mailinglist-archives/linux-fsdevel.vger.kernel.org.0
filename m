Return-Path: <linux-fsdevel+bounces-30061-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82683985807
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Sep 2024 13:35:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BF66AB20C7C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Sep 2024 11:35:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1029015B562;
	Wed, 25 Sep 2024 11:35:06 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39639137775;
	Wed, 25 Sep 2024 11:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727264105; cv=none; b=OiSNjT8/ZCmOCrR02yGzQ9991mlydgCZ6Krw3qrFyV2S+43uaAEYxw1oR1oAWvmYv504VVifWG5nJK3zsd0sLDsnDCMCpS01zPVP2+vsZJBh0ViNVQbuURU3nZm5ZKGTKHTl9L8QSCZQMhf5bVY36o6yLnjm9b5ZYxbfU+Hdq68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727264105; c=relaxed/simple;
	bh=170AVyQFJ3/97RuZmyCLwYfGaDGwl+WX6cd9BfoheAA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HUZvg8UkMewAhrVmw9G5ve/aLm43Mo9EXm2fzxqZ6ajoXf0A6AGfA/6LjHcOn8tGxxIyeEiNTMClJ9JNWwfRN44k/UN4QdUAJWzfaGJjUS3xiMo9YUaJnpMAVKpzR6nwQ0WxhS1UysSuHMRUWbK20dZOGLfFTGoN/jEsENA+LCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4XDF4r1LYkz4f3l2C;
	Wed, 25 Sep 2024 19:34:36 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 207C31A1125;
	Wed, 25 Sep 2024 19:34:53 +0800 (CST)
Received: from [10.174.179.80] (unknown [10.174.179.80])
	by APP4 (Coremail) with SMTP id gCh0CgDH+sZX9fNmN5E9CQ--.2308S3;
	Wed, 25 Sep 2024 19:34:48 +0800 (CST)
Message-ID: <b98ad16c-8362-45ef-86fc-b23f17ac8697@huaweicloud.com>
Date: Wed, 25 Sep 2024 19:34:47 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 03/10] ext4: warn if delalloc counters are not zero on
 inactive
To: "Lai, Yi" <yi1.lai@linux.intel.com>
Cc: linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca,
 jack@suse.cz, ritesh.list@gmail.com, yi.zhang@huawei.com,
 chengzhihao1@huawei.com, yukuai3@huawei.com, yi1.lai@intel.com
References: <20240517124005.347221-1-yi.zhang@huaweicloud.com>
 <20240517124005.347221-4-yi.zhang@huaweicloud.com>
 <ZvIxRP0eVkbagUr5@ly-workstation>
 <e3503ded-749c-4651-85a4-a6165b22cfd1@huaweicloud.com>
 <ZvPdaEqsboTBcMrm@ly-workstation>
Content-Language: en-US
From: Zhang Yi <yi.zhang@huaweicloud.com>
In-Reply-To: <ZvPdaEqsboTBcMrm@ly-workstation>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:gCh0CgDH+sZX9fNmN5E9CQ--.2308S3
X-Coremail-Antispam: 1UD129KBjvAXoW3uF1fGr18uF1UKF4DGw17KFg_yoW8Gr1DJo
	WfJrZ7Jw4rGFy5Grn5Cw17J345G397tFn7Jr98KrWUGF1Iga1DXr18J34kXwsrtF1FgFWU
	A3sIqF1DZa98Jrn7n29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
	AaLaJ3UjIYCTnIWjp_UUUY77kC6x804xWl14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK
	8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4
	AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF
	7I0E14v26F4UJVW0owA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS
	14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I
	8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8
	ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x
	0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_
	Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU1
	7KsUUUUUU==
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

On 2024/9/25 17:52, Lai, Yi wrote:
> Hi,
> 
> I have applied your mentioned patch series on top of linux tag v6.11.
> Using the same repro binary, issue cannot be reproduced.
> 

Ah, that's great, this series seems had fixed some corner problems
as well, thanks a lot for testing this.

Thanks,
Yi.

> Regards,
> Yi Lai
> 
> On Tue, Sep 24, 2024 at 04:38:22PM +0800, Zhang Yi wrote:
>> On 2024/9/24 11:25, Lai, Yi wrote:
>>> Hi Zhang Yi,
>>>
>>> Greetings!
>>>
>>> I used Syzkaller and found that there is WARNING in ext4_destroy_inode.
>>>
>>> After bisection and the first bad commit is:
>>> "
>>> b37c907073e8 ext4: warn if delalloc counters are not zero on inactive
>>> "
>>>
>>> I understand that the commit is to add WARN_ON_ONCE to make error message more visible. I hope the reproduction program will be insightful for you.
>>>
>>
>> Thanks for the report! It seems that this patch worked, it start exposing
>> problems about inconsistent delalloc counter, which were previously hidden.
>> However, the counter updating logic has changed after this series:
>>
>> https://lore.kernel.org/linux-ext4/20240813123452.2824659-1-yi.zhang@huaweicloud.com/
>>
>> Could you reproduce this issue with this series or in the latest upstream
>> kernel?
>>
>> Thanks,
>> Yi.
>>
>>> All detailed into can be found at:
>>> https://github.com/laifryiee/syzkaller_logs/tree/main/240923_043748_ext4_destroy_inode
>>> Syzkaller repro code:
>>> https://github.com/laifryiee/syzkaller_logs/blob/main/240923_043748_ext4_destroy_inode/repro.c
>>> Syzkaller repro syscall steps:
>>> https://github.com/laifryiee/syzkaller_logs/blob/main/240923_043748_ext4_destroy_inode/repro.prog
>>> Syzkaller report:
>>> https://github.com/laifryiee/syzkaller_logs/blob/main/240923_043748_ext4_destroy_inode/repro.report
>>> Kconfig(make olddefconfig):
>>> https://github.com/laifryiee/syzkaller_logs/blob/main/240923_043748_ext4_destroy_inode/kconfig_origin
>>> Bisect info:
>>> https://github.com/laifryiee/syzkaller_logs/blob/main/240923_043748_ext4_destroy_inode/bisect_info.log
>>> bzImage:
>>> https://github.com/laifryiee/syzkaller_logs/raw/main/240923_043748_ext4_destroy_inode/bzImage_98f7e32f20d28ec452afb208f9cffc08448a2652
>>> Issue dmesg:
>>> https://github.com/laifryiee/syzkaller_logs/blob/main/240923_043748_ext4_destroy_inode/98f7e32f20d28ec452afb208f9cffc08448a2652_dmesg.log
>>>
>>> "
>>> [   25.223775] ------------[ cut here ]------------
>>> [   25.224177] WARNING: CPU: 0 PID: 740 at fs/ext4/super.c:1464 ext4_destroy_inode+0x1de/0x280
>>> [   25.224724] Modules linked in:
>>> [   25.224920] CPU: 0 UID: 0 PID: 740 Comm: repro Not tainted 6.11.0-98f7e32f20d2 #1
>>> [   25.225393] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.3-0-ga6ed6b701f0a-prebuilt.qemu.org 04/01/2014
>>> [   25.226103] RIP: 0010:ext4_destroy_inode+0x1de/0x280
>>> [   25.226429] Code: 31 ff 44 89 e6 e8 62 ad 45 ff 45 85 e4 75 16 e8 d8 a9 45 ff 48 8d 65 e0 5b 41 5c 41 5d 41 5e 5d c3 cc cc cc cc e8 c2 a9 45 ff <0f> 0b 48 8d 7b 40 4c 8d 83 50 fd ff ff 48 b8 00 00 00 00 00 fc ff
>>> [   25.227570] RSP: 0018:ff11000023707c08 EFLAGS: 00010293
>>> [   25.227915] RAX: 0000000000000000 RBX: ff11000022f22a50 RCX: ffffffff822028de
>>> [   25.228357] RDX: ff110000139a8000 RSI: ffffffff822028fe RDI: 0000000000000005
>>> [   25.228840] RBP: ff11000023707c30 R08: 0000000000000001 R09: ffe21c00024e24eb
>>> [   25.229284] R10: 0000000000000001 R11: 0000000000000001 R12: 0000000000000001
>>> [   25.229712] R13: ff11000012712000 R14: ff11000022f22ad0 R15: ff1100006c1aa440
>>> [   25.230168] FS:  00007f1d418a7800(0000) GS:ff1100006c400000(0000) knlGS:0000000000000000
>>> [   25.230666] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>>> [   25.230818] EXT4-fs (sda): Inode 151593 (000000004419e1b8): i_reserved_data_blocks (1) not cleared!
>>> [   25.231037] CR2: 00007f1d416b1ac0 CR3: 00000000140e4004 CR4: 0000000000771ef0
>>> [   25.232104] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>>> [   25.232546] DR3: 0000000000000000 DR6: 00000000fffe07f0 DR7: 0000000000000400
>>> [   25.233006] PKRU: 55555554
>>> [   25.233184] Call Trace:
>>> [   25.233348]  <TASK>
>>> [   25.233489]  ? show_regs+0xa8/0xc0
>>> [   25.233724]  ? __warn+0xee/0x380
>>> [   25.233953]  ? report_bug+0x25e/0x4b0
>>> [   25.234201]  ? ext4_destroy_inode+0x1de/0x280
>>> [   25.234485]  ? report_bug+0x2cb/0x4b0
>>> [   25.234729]  ? ext4_destroy_inode+0x1de/0x280
>>> [   25.235020]  ? handle_bug+0xa2/0x130
>>> [   25.235266]  ? exc_invalid_op+0x3c/0x80
>>> [   25.235513]  ? asm_exc_invalid_op+0x1f/0x30
>>> [   25.235786]  ? ext4_destroy_inode+0x1be/0x280
>>> [   25.236072]  ? ext4_destroy_inode+0x1de/0x280
>>> [   25.236356]  ? ext4_destroy_inode+0x1de/0x280
>>> [   25.236637]  ? ext4_destroy_inode+0x1de/0x280
>>> [   25.236949]  ? __pfx_ext4_destroy_inode+0x10/0x10
>>> [   25.237257]  destroy_inode+0xd6/0x1d0
>>> [   25.237507]  evict+0x5a7/0x930
>>> [   25.237708]  ? lock_release+0x441/0x870
>>> [   25.237975]  ? do_raw_spin_lock+0x141/0x280
>>> [   25.238246]  ? __pfx_evict+0x10/0x10
>>> [   25.238486]  ? __pfx_lock_release+0x10/0x10
>>> [   25.238757]  ? lock_release+0x441/0x870
>>> [   25.239015]  ? lock_release+0x441/0x870
>>> [   25.239266]  ? do_raw_spin_unlock+0x15c/0x210
>>> [   25.239552]  iput.part.0+0x543/0x740
>>> [   25.239788]  ? __pfx_ext4_drop_inode+0x10/0x10
>>> [   25.240081]  iput+0x68/0x90
>>> [   25.240265]  do_unlinkat+0x5dc/0x730
>>> [   25.240503]  ? __pfx_do_unlinkat+0x10/0x10
>>> [   25.240791]  ? __sanitizer_cov_trace_const_cmp8+0x1c/0x30
>>> [   25.241149]  ? strncpy_from_user+0x1ef/0x2e0
>>> [   25.241436]  ? __sanitizer_cov_trace_const_cmp4+0x1a/0x20
>>> [   25.241774]  ? getname_flags.part.0+0x1d5/0x570
>>> [   25.242459]  __x64_sys_unlink+0xd1/0x120
>>> [   25.242749]  x64_sys_call+0x2014/0x20d0
>>> [   25.243031]  do_syscall_64+0x6d/0x140
>>> [   25.243304]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
>>> [   25.243630] RIP: 0033:0x7f1d4163eb7b
>>> [   25.243878] Code: f0 ff ff 73 01 c3 48 8b 0d a2 b2 1b 00 f7 d8 64 89 01 48 83 c8 ff c3 0f 1f 84 00 00 00 00 00 f3 0f 1e fa b8 57 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 75 b2 1b 00 f7 d8 64 89 01 48
>>> [   25.245038] RSP: 002b:00007fffffa2ca48 EFLAGS: 00000206 ORIG_RAX: 0000000000000057
>>> [   25.245508] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f1d4163eb7b
>>> [   25.245966] RDX: 00007fffffa2ca60 RSI: 00007fffffa2caf0 RDI: 00007fffffa2caf0
>>> [   25.246412] RBP: 00007fffffa2db30 R08: 0000000000000000 R09: 00007fffffa2c8e0
>>> [   25.246872] R10: 00007f1d4160b208 R11: 0000000000000206 R12: 00007fffffa2dca8
>>> [   25.247310] R13: 0000000000402e4b R14: 0000000000404e08 R15: 00007f1d418f2000
>>> [   25.247759]  </TASK>
>>> [   25.247912] irq event stamp: 5719
>>> [   25.248127] hardirqs last  enabled at (5727): [<ffffffff81458eb4>] console_unlock+0x224/0x240
>>> [   25.248690] hardirqs last disabled at (5736): [<ffffffff81458e99>] console_unlock+0x209/0x240
>>> [   25.249236] softirqs last  enabled at (5252): [<ffffffff81289d19>] __irq_exit_rcu+0xa9/0x120
>>> [   25.249768] softirqs last disabled at (5247): [<ffffffff81289d19>] __irq_exit_rcu+0xa9/0x120
>>> [   25.250311] ---[ end trace 0000000000000000 ]---
>>> [   25.250602] EXT4-fs (sda): Inode 151586 (00000000f9d6a315): i_reserved_data_blocks (1) not cleared!
>>> [   25.326263] EXT4-fs (sda): Inode 151578 (00000000d86ad2f9): i_reserved_data_blocks (1) not cleared!
>>> [   25.680884] EXT4-fs (sda): Inode 151596 (00000000da9177c9): i_reserved_data_blocks (1) not cleared!
>>> [   25.717550] EXT4-fs (sda): Inode 151573 (0000000088687caa): i_reserved_data_blocks (1) not cleared!
>>> [   25.726089] EXT4-fs (sda): Inode 151585 (000000005d7aed9a): i_reserved_data_blocks (1) not cleared!
>>> [   25.838592] EXT4-fs (sda): Inode 151573 (000000004af622df): i_reserved_data_blocks (1) not cleared!
>>> [   25.955073] EXT4-fs (sda): Inode 151598 (00000000a6e598ec): i_reserved_data_blocks (1) not cleared!
>>> [   26.525552] EXT4-fs (sda): Inode 151593 (0000000026aef1cd): i_reserved_data_blocks (1) not cleared!
>>> [   26.554067] EXT4-fs (sda): Inode 151591 (0000000051e990da): i_reserved_data_blocks (1) not cleared!
>>> [   30.291490] EXT4-fs: 14 callbacks suppressed
>>> [   30.291510] EXT4-fs (sda): Inode 151591 (0000000050be254a): i_reserved_data_blocks (1) not cleared!
>>> [   30.301238] EXT4-fs (sda): Inode 151587 (000000004ba9ad70): i_reserved_data_blocks (1) not cleared!
>>> [   30.414377] EXT4-fs (sda): Inode 151583 (00000000f6751ad3): i_reserved_data_blocks (1) not cleared!
>>> [   30.417213] EXT4-fs (sda): Inode 151591 (0000000090a0dce3): i_reserved_data_blocks (1) not cleared!
>>> [   30.537920] EXT4-fs (sda): Inode 151587 (00000000de72acf9): i_reserved_data_blocks (1) not cleared!
>>> [   30.645791] EXT4-fs (sda): Inode 151580 (00000000a40a052f): i_reserved_data_blocks (1) not cleared!
>>> [   30.665732] EXT4-fs (sda): Inode 151587 (00000000d9452edd): i_reserved_data_blocks (1) not cleared!
>>> [   30.670204] EXT4-fs (sda): Inode 151597 (00000000f861d75f): i_reserved_data_blocks (1) not cleared!
>>> [   31.964931] EXT4-fs (sda): Inode 151589 (000000009baa4064): i_reserved_data_blocks (1) not cleared!
>>> [   32.101343] EXT4-fs (sda): Inode 151598 (000000003fca6cd5): i_reserved_data_blocks (1) not cleared!
>>> "
>>>
>>> I hope you find it useful.
>>>
>>> Regards,
>>> Yi Lai
>>>
>>> ---
>>>
>>> If you don't need the following environment to reproduce the problem or if you
>>> already have one reproduced environment, please ignore the following information.
>>>
>>> How to reproduce:
>>> git clone https://gitlab.com/xupengfe/repro_vm_env.git
>>> cd repro_vm_env
>>> tar -xvf repro_vm_env.tar.gz
>>> cd repro_vm_env; ./start3.sh  // it needs qemu-system-x86_64 and I used v7.1.0
>>>   // start3.sh will load bzImage_2241ab53cbb5cdb08a6b2d4688feb13971058f65 v6.2-rc5 kernel
>>>   // You could change the bzImage_xxx as you want
>>>   // Maybe you need to remove line "-drive if=pflash,format=raw,readonly=on,file=./OVMF_CODE.fd \" for different qemu version
>>> You could use below command to log in, there is no password for root.
>>> ssh -p 10023 root@localhost
>>>
>>> After login vm(virtual machine) successfully, you could transfer reproduced
>>> binary to the vm by below way, and reproduce the problem in vm:
>>> gcc -pthread -o repro repro.c
>>> scp -P 10023 repro root@localhost:/root/
>>>
>>> Get the bzImage for target kernel:
>>> Please use target kconfig and copy it to kernel_src/.config
>>> make olddefconfig
>>> make -jx bzImage           //x should equal or less than cpu num your pc has
>>>
>>> Fill the bzImage file into above start3.sh to load the target kernel in vm.
>>>
>>> Tips:
>>> If you already have qemu-system-x86_64, please ignore below info.
>>> If you want to install qemu v7.1.0 version:
>>> git clone https://github.com/qemu/qemu.git
>>> cd qemu
>>> git checkout -f v7.1.0
>>> mkdir build
>>> cd build
>>> yum install -y ninja-build.x86_64
>>> yum -y install libslirp-devel.x86_64
>>> ../configure --target-list=x86_64-softmmu --enable-kvm --enable-vnc --enable-gtk --enable-sdl --enable-usb-redir --enable-slirp
>>> make
>>> make install 
>>>
>>> On Fri, May 17, 2024 at 08:39:58PM +0800, Zhang Yi wrote:
>>>> From: Zhang Yi <yi.zhang@huawei.com>
>>>>
>>>> The per-inode i_reserved_data_blocks count the reserved delalloc blocks
>>>> in a regular file, it should be zero when destroying the file. The
>>>> per-fs s_dirtyclusters_counter count all reserved delalloc blocks in a
>>>> filesystem, it also should be zero when umounting the filesystem. Now we
>>>> have only an error message if the i_reserved_data_blocks is not zero,
>>>> which is unable to be simply captured, so add WARN_ON_ONCE to make it
>>>> more visable.
>>>>
>>>> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
>>>> ---
>>>>  fs/ext4/super.c | 6 +++++-
>>>>  1 file changed, 5 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
>>>> index 044135796f2b..b68064c877e3 100644
>>>> --- a/fs/ext4/super.c
>>>> +++ b/fs/ext4/super.c
>>>> @@ -1343,6 +1343,9 @@ static void ext4_put_super(struct super_block *sb)
>>>>  
>>>>  	ext4_group_desc_free(sbi);
>>>>  	ext4_flex_groups_free(sbi);
>>>> +
>>>> +	WARN_ON_ONCE(!(sbi->s_mount_state & EXT4_ERROR_FS) &&
>>>> +		     percpu_counter_sum(&sbi->s_dirtyclusters_counter));
>>>>  	ext4_percpu_param_destroy(sbi);
>>>>  #ifdef CONFIG_QUOTA
>>>>  	for (int i = 0; i < EXT4_MAXQUOTAS; i++)
>>>> @@ -1473,7 +1476,8 @@ static void ext4_destroy_inode(struct inode *inode)
>>>>  		dump_stack();
>>>>  	}
>>>>  
>>>> -	if (EXT4_I(inode)->i_reserved_data_blocks)
>>>> +	if (!(EXT4_SB(inode->i_sb)->s_mount_state & EXT4_ERROR_FS) &&
>>>> +	    WARN_ON_ONCE(EXT4_I(inode)->i_reserved_data_blocks))
>>>>  		ext4_msg(inode->i_sb, KERN_ERR,
>>>>  			 "Inode %lu (%p): i_reserved_data_blocks (%u) not cleared!",
>>>>  			 inode->i_ino, EXT4_I(inode),
>>>> -- 
>>>> 2.39.2
>>>>
>>>
>>


