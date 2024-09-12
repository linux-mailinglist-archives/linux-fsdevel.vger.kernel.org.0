Return-Path: <linux-fsdevel+bounces-29134-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 45871975F4A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Sep 2024 04:54:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C2C551F24111
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Sep 2024 02:54:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60FFF4AED1;
	Thu, 12 Sep 2024 02:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jhujKeNT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 707FB126BE0
	for <linux-fsdevel@vger.kernel.org>; Thu, 12 Sep 2024 02:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726109611; cv=none; b=oRRAuWADW1QMAClU6b4lFVFifaoUv2Iqp1GsTdR6+tlahsE2/1mHOkbM0HXo5B96utKroTmh9O1A3bSpGKNJ8BtwYi59TgUMyseWspxBSST8+C9hOy5R28CWEzA5XfAnuJav1lWpOwDdrskDzWEJOGS+HbqDC/yvY87fZYB8U7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726109611; c=relaxed/simple;
	bh=8jwwRksUVh2PtC+aU9rb4ZABr6lhdjhKNROnY6lKaew=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QapiOkefM/Qveq02gtcUjPxoIOMUVsT49XWJVWXSw6nFfyhb0c+zonErLgvJpvqQ+4rtjGTVZZsj1Ot/Hcfq9XvCzlmcdhsDgnY5QRIIYULdU20UQIZ7XTgUkmrX4FB8EoWgKyfSQLP513Av+fXxT+Aim0tnrjhAdcquDslb1AE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jhujKeNT; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726109609; x=1757645609;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=8jwwRksUVh2PtC+aU9rb4ZABr6lhdjhKNROnY6lKaew=;
  b=jhujKeNTx76IcFHXzUhizHkFxROhRwLZo/SBaJx5FA6YJwg/DJeHiwoF
   6Po4rsmq7xE6zPG+T9TGLlHZ56VJA0tPP9fWmzzQTEZVyQkrjDr65h7LY
   qde3QOSfsWq8YPRJW97ur1Gx6oRPokYLW+Cfv1nmEzq6ZC+N3PUapbizT
   XTjRj7A/7F1622QUVernWKINHFz5HqGnV4ho5fn8TBS8/DpHBlJ5SB2N/
   0IlD05OSN0f8y2snYJGkwA4IjO5WhOrBUvjfuu1tUUJwcezo3+pMAq5+q
   uVRuRIjVio2utCcuBKLakNfRKVSWbi9UNA35C9SJkekSlM0RuWc6Rb4R7
   Q==;
X-CSE-ConnectionGUID: zcfyvbrBQjmqCsImffyGCw==
X-CSE-MsgGUID: RAk/mqhEQ9mnfOGMkeSgHw==
X-IronPort-AV: E=McAfee;i="6700,10204,11192"; a="28828173"
X-IronPort-AV: E=Sophos;i="6.10,221,1719903600"; 
   d="scan'208";a="28828173"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2024 19:53:28 -0700
X-CSE-ConnectionGUID: iT1CU2MrSCaWDr5kKcS7Rg==
X-CSE-MsgGUID: NkNlp/awTpKKFLk8UWkV3Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,221,1719903600"; 
   d="scan'208";a="98392828"
Received: from ly-workstation.sh.intel.com (HELO ly-workstation) ([10.239.161.23])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2024 19:53:26 -0700
Date: Thu, 12 Sep 2024 10:52:16 +0800
From: "Lai, Yi" <yi1.lai@linux.intel.com>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Jan Kara <jack@suse.com>,
	Al Viro <viro@zeniv.linux.org.uk>, Jeff Layton <jlayton@kernel.org>,
	Josef Bacik <josef@toxicpanda.com>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH RFC 12/20] input: remove f_version abuse
Message-ID: <ZuJXYNeTGrnRpPHk@ly-workstation>
References: <20240830-vfs-file-f_version-v1-0-6d3e4816aa7b@kernel.org>
 <20240830-vfs-file-f_version-v1-12-6d3e4816aa7b@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240830-vfs-file-f_version-v1-12-6d3e4816aa7b@kernel.org>

Hi Christian Brauner,

Greetings!

I used Syzkaller and found that there is BUG: unable to handle kernel paging request in input_proc_devices_poll in next-20240909.

After bisection and the first bad commit is:
"
7c3d158418c2 input: remove f_version abuse
"

All detailed into can be found at:
https://github.com/laifryiee/syzkaller_logs/tree/main/240911_155303_input_proc_devices_poll
Syzkaller repro code:
https://github.com/laifryiee/syzkaller_logs/blob/main/240911_155303_input_proc_devices_poll/repro.c
Syzkaller repro syscall steps:
https://github.com/laifryiee/syzkaller_logs/blob/main/240911_155303_input_proc_devices_poll/repro.prog
Syzkaller report:
https://github.com/laifryiee/syzkaller_logs/blob/main/240911_155303_input_proc_devices_poll/repro.report
Kconfig(make olddefconfig):
https://github.com/laifryiee/syzkaller_logs/blob/main/240911_155303_input_proc_devices_poll/kconfig_origin
Bisect info:
https://github.com/laifryiee/syzkaller_logs/blob/main/240911_155303_input_proc_devices_poll/bisect_info.log
bzImage:
https://github.com/laifryiee/syzkaller_logs/raw/main/240911_155303_input_proc_devices_poll/bzImage_100cc857359b5d731407d1038f7e76cd0e871d94
Issue dmesg:
https://github.com/laifryiee/syzkaller_logs/blob/main/240911_155303_input_proc_devices_poll/100cc857359b5d731407d1038f7e76cd0e871d94_dmesg.log

"
[   23.266063] ==================================================================
[   23.268350] BUG: KASAN: slab-out-of-bounds in input_proc_devices_poll+0x113/0x140
[   23.270806] Read of size 8 at addr ffff88801101fa40 by task repro/729
[   23.272537] 
[   23.272980] CPU: 1 UID: 0 PID: 729 Comm: repro Not tainted 6.11.0-rc7-next-20240909-100cc857359b-dirty #1
[   23.274230] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.0-0-gd239552ce722-prebuilt.qemu.org 04/01/2014
[   23.275200] Call Trace:
[   23.275432]  <TASK>
[   23.275633]  dump_stack_lvl+0xea/0x150
[   23.275972]  print_report+0xce/0x610
[   23.276269]  ? input_proc_devices_poll+0x113/0x140
[   23.276650]  ? kasan_complete_mode_report_info+0x40/0x200
[   23.277058]  ? input_proc_devices_poll+0x113/0x140
[   23.277400]  kasan_report+0xcc/0x110
[   23.277668]  ? input_proc_devices_poll+0x113/0x140
[   23.277989]  ? __pfx___pollwait+0x10/0x10
[   23.278288]  __asan_report_load8_noabort+0x18/0x20
[   23.278634]  input_proc_devices_poll+0x113/0x140
[   23.278963]  ? __pfx_input_proc_devices_poll+0x10/0x10
[   23.279325]  proc_reg_poll+0x210/0x2e0
[   23.279607]  ? __pfx_proc_reg_poll+0x10/0x10
[   23.279917]  do_sys_poll+0x521/0xdd0
[   23.280188]  ? __pfx_do_sys_poll+0x10/0x10
[   23.280485]  ? __kasan_check_read+0x15/0x20
[   23.280791]  ? mark_lock.part.0+0xf3/0x17b0
[   23.281101]  ? __pfx_mark_lock.part.0+0x10/0x10
[   23.281427]  ? __kasan_check_read+0x15/0x20
[   23.281736]  ? mark_lock.part.0+0xf3/0x17b0
[   23.282039]  ? mutex_unlock+0x16/0x20
[   23.282311]  ? seq_read_iter+0x72/0x1300
[   23.282604]  ? __pfx_mark_lock.part.0+0x10/0x10
[   23.282935]  ? __pfx___pollwait+0x10/0x10
[   23.283235]  ? __pfx_pollwake+0x10/0x10
[   23.283526]  ? __pfx___lock_acquire+0x10/0x10
[   23.283848]  ? __this_cpu_preempt_check+0x21/0x30
[   23.284200]  ? __this_cpu_preempt_check+0x21/0x30
[   23.284542]  ? lock_release+0x441/0x870
[   23.284825]  ? __sanitizer_cov_trace_cmp8+0x1c/0x30
[   23.285180]  ? timespec64_add_safe+0x192/0x220
[   23.285505]  ? __pfx_timespec64_add_safe+0x10/0x10
[   23.285851]  ? __sanitizer_cov_trace_const_cmp1+0x1e/0x30
[   23.286236]  ? __sanitizer_cov_trace_const_cmp8+0x1c/0x30
[   23.286622]  ? ktime_get_ts64+0x1db/0x2e0
[   23.286925]  __x64_sys_poll+0x1bf/0x560
[   23.287205]  ? __pfx___x64_sys_poll+0x10/0x10
[   23.287524]  x64_sys_call+0x1294/0x2140
[   23.287808]  do_syscall_64+0x6d/0x140
[   23.288083]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[   23.288457] RIP: 0033:0x7faf33c3ee5d
[   23.288721] Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 93 af 1b 00 f7 d8 64 89 01 48
[   23.289988] RSP: 002b:00007ffff3de1fe8 EFLAGS: 00000207 ORIG_RAX: 0000000000000007
[   23.290531] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007faf33c3ee5d
[   23.291025] RDX: 0000000000000029 RSI: 0000000000000005 RDI: 0000000020000040
[   23.291519] RBP: 00007ffff3de2000 R08: 00007ffff3de2000 R09: 00007ffff3de2000
[   23.292201] R10: 00007ffff3de2000 R11: 0000000000000207 R12: 00007ffff3de2158
[   23.292800] R13: 0000000000401810 R14: 0000000000403e08 R15: 00007faf33e55000
[   23.293320]  </TASK>
[   23.293487] 
[   23.293609] Allocated by task 1:
[   23.293862]  kasan_save_stack+0x2c/0x60
[   23.294153]  kasan_save_track+0x18/0x40
[   23.294435]  kasan_save_alloc_info+0x3c/0x50
[   23.294744]  __kasan_kmalloc+0x88/0xa0
[   23.295019]  __kmalloc_noprof+0x1cd/0x4a0
[   23.295316]  cgroup_mkdir+0x282/0x1320
[   23.295602]  kernfs_iop_mkdir+0x15a/0x1f0
[   23.295899]  vfs_mkdir+0x57d/0x860
[   23.296157]  do_mkdirat+0x2e2/0x3b0
[   23.296414]  __x64_sys_mkdir+0xfd/0x150
[   23.296692]  x64_sys_call+0x1c5a/0x2140
[   23.296974]  do_syscall_64+0x6d/0x140
[   23.297246]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[   23.297611] 
[   23.297735] The buggy address belongs to the object at ffff88801101e000
[   23.297735]  which belongs to the cache kmalloc-4k of size 4096
[   23.298583] The buggy address is located 4584 bytes to the right of
[   23.298583]  allocated 2136-byte region [ffff88801101e000, ffff88801101e858)
[   23.299489] 
[   23.299611] The buggy address belongs to the physical page:
[   23.300004] page: refcount:1 mapcount:0 mapping:0000000000000000 index:0xffff88801101c000 pfn:0x11018
[   23.300643] head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
[   23.301177] flags: 0xfffffc0000240(workingset|head|node=0|zone=1|lastcpupid=0x1fffff)
[   23.301729] page_type: f5(slab)
[   23.301968] raw: 000fffffc0000240 ffff88800d442140 ffffea00004e3610 ffffea0000446410
[   23.302505] raw: ffff88801101c000 0000000000040002 00000001f5000000 0000000000000000
[   23.303048] head: 000fffffc0000240 ffff88800d442140 ffffea00004e3610 ffffea0000446410
[   23.303597] head: ffff88801101c000 0000000000040002 00000001f5000000 0000000000000000
[   23.304147] head: 000fffffc0000003 ffffea0000440601 ffffffffffffffff 0000000000000000
[   23.304692] head: ffff888000000008 0000000000000000 00000000ffffffff 0000000000000000
[   23.305238] page dumped because: kasan: bad access detected
[   23.305632] 
[   23.305752] Memory state around the buggy address:
[   23.306096]  ffff88801101f900: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
[   23.306600]  ffff88801101f980: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
[   23.307102] >ffff88801101fa00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
[   23.307612]                                            ^
[   23.307984]  ffff88801101fa80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
[   23.308490]  ffff88801101fb00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
[   23.308993] ==================================================================
[   23.309546] Disabling lock debugging due to kernel taint

"

I hope you find it useful.

Regards,
Yi Lai

---

If you don't need the following environment to reproduce the problem or if you
already have one reproduced environment, please ignore the following information.

How to reproduce:
git clone https://gitlab.com/xupengfe/repro_vm_env.git
cd repro_vm_env
tar -xvf repro_vm_env.tar.gz
cd repro_vm_env; ./start3.sh  // it needs qemu-system-x86_64 and I used v7.1.0
  // start3.sh will load bzImage_2241ab53cbb5cdb08a6b2d4688feb13971058f65 v6.2-rc5 kernel
  // You could change the bzImage_xxx as you want
  // Maybe you need to remove line "-drive if=pflash,format=raw,readonly=on,file=./OVMF_CODE.fd \" for different qemu version
You could use below command to log in, there is no password for root.
ssh -p 10023 root@localhost

After login vm(virtual machine) successfully, you could transfer reproduced
binary to the vm by below way, and reproduce the problem in vm:
gcc -pthread -o repro repro.c
scp -P 10023 repro root@localhost:/root/

Get the bzImage for target kernel:
Please use target kconfig and copy it to kernel_src/.config
make olddefconfig
make -jx bzImage           //x should equal or less than cpu num your pc has

Fill the bzImage file into above start3.sh to load the target kernel in vm.

Tips:
If you already have qemu-system-x86_64, please ignore below info.
If you want to install qemu v7.1.0 version:
git clone https://github.com/qemu/qemu.git
cd qemu
git checkout -f v7.1.0
mkdir build
cd build
yum install -y ninja-build.x86_64
yum -y install libslirp-devel.x86_64
../configure --target-list=x86_64-softmmu --enable-kvm --enable-vnc --enable-gtk --enable-sdl --enable-usb-redir --enable-slirp
make
make install 

On Fri, Aug 30, 2024 at 03:04:53PM +0200, Christian Brauner wrote:
> Remove the f_version abuse from input. Use seq_private_open() to stash
> the information for poll.
> 
> Signed-off-by: Christian Brauner <brauner@kernel.org>
> ---
>  drivers/input/input.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/input/input.c b/drivers/input/input.c
> index 54c57b267b25..b03ae43707d8 100644
> --- a/drivers/input/input.c
> +++ b/drivers/input/input.c
> @@ -1081,9 +1081,11 @@ static inline void input_wakeup_procfs_readers(void)
>  
>  static __poll_t input_proc_devices_poll(struct file *file, poll_table *wait)
>  {
> +	struct seq_file *m = file->private_data;
> +
>  	poll_wait(file, &input_devices_poll_wait, wait);
> -	if (file->f_version != input_devices_state) {
> -		file->f_version = input_devices_state;
> +	if (*(u64 *)m->private != input_devices_state) {
> +		*(u64 *)m->private = input_devices_state;
>  		return EPOLLIN | EPOLLRDNORM;
>  	}
>  
> @@ -1210,7 +1212,7 @@ static const struct seq_operations input_devices_seq_ops = {
>  
>  static int input_proc_devices_open(struct inode *inode, struct file *file)
>  {
> -	return seq_open(file, &input_devices_seq_ops);
> +	return seq_open_private(file, &input_devices_seq_ops, sizeof(u64));
>  }
>  
>  static const struct proc_ops input_devices_proc_ops = {
> 
> -- 
> 2.45.2
> 

