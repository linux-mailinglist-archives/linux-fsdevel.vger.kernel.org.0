Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EB363184406
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Mar 2020 10:46:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726395AbgCMJqg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 13 Mar 2020 05:46:36 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:63587 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726055AbgCMJqg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 13 Mar 2020 05:46:36 -0400
Received: from fsav109.sakura.ne.jp (fsav109.sakura.ne.jp [27.133.134.236])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 02D9kSXZ019844;
        Fri, 13 Mar 2020 18:46:28 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav109.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav109.sakura.ne.jp);
 Fri, 13 Mar 2020 18:46:28 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav109.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 02D9kLxh019677
        (version=TLSv1.2 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Fri, 13 Mar 2020 18:46:28 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [PATCH] umh: fix refcount underflow in fork_usermode_blob().
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        "David S. Miller" <davem@davemloft.net>
References: <2a8775b4-1dd5-9d5c-aa42-9872445e0942@i-love.sakura.ne.jp>
 <20200312143801.GJ23230@ZenIV.linux.org.uk>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <a802dfd6-aeda-c454-6dd3-68e32a4cf914@i-love.sakura.ne.jp>
Date:   Fri, 13 Mar 2020 18:46:19 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200312143801.GJ23230@ZenIV.linux.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2020/03/12 23:38, Al Viro wrote:
> 	It _does_ look like that double-fput() is real, but
> I'd like a confirmation before going further - umh is convoluted
> enough for something subtle to be hidden there.  Alexei, what
> the refcounting behaviour was supposed to be?  As in "this
> function consumes the reference passed to it in this argument",
> etc.
> 

Yes, double-fput() is easily observable as POISON_FREE pattern
using debug printk() patch and sample kernel module shown below.

---------- debug printk() patch start ----------
diff --git a/kernel/umh.c b/kernel/umh.c
index 7f255b5a8845..8313736b39b9 100644
--- a/kernel/umh.c
+++ b/kernel/umh.c
@@ -507,6 +507,7 @@ int fork_usermode_blob(void *data, size_t len, struct umh_info *info)
 	if (IS_ERR(file))
 		return PTR_ERR(file);
 
+	printk("writecount=%d fcount=%ld\n", atomic_read(&file_inode(file)->i_writecount), atomic_long_read(&file->f_count));
 	written = kernel_write(file, data, len, &pos);
 	if (written != len) {
 		err = written;
@@ -522,12 +523,15 @@ int fork_usermode_blob(void *data, size_t len, struct umh_info *info)
 		goto out;
 
 	err = call_usermodehelper_exec(sub_info, UMH_WAIT_EXEC);
+	printk("err=%d writecount=%d fcount=%ld\n", err, atomic_read(&file_inode(file)->i_writecount), atomic_long_read(&file->f_count));
 	if (!err) {
 		mutex_lock(&umh_list_lock);
 		list_add(&info->list, &umh_list);
 		mutex_unlock(&umh_list_lock);
 	}
 out:
+	schedule_timeout_killable(HZ);
+	printk("err=%d writecount=%d fcount=%ld\n", err, atomic_read(&file_inode(file)->i_writecount), atomic_long_read(&file->f_count));
 	fput(file);
 	return err;
 }
---------- debug printk() patch end ----------

---------- test.c start ----------
#include <linux/slab.h>
#include <linux/module.h>
#include <linux/umh.h>

static int __init test_init(void)
{
	struct umh_info *info = kzalloc(sizeof(*info), GFP_KERNEL);

	printk("fork_usermode_blob()=%d\n", fork_usermode_blob((void *) "#!/bin/true\n", 12, info));
	return -EINVAL;
}

module_init(test_init);
MODULE_LICENSE("GPL");
---------- test.c end ----------

---------- without refcount-fix patch ----------
[   30.775698] test: loading out-of-tree module taints kernel.
[   30.792584] writecount=0 fcount=1
[   30.794844] err=0 writecount=1 fcount=0
[   31.843778] general protection fault, probably for non-canonical address 0x6b6b6b6b6b6b6b6b: 0000 [#1] SMP DEBUG_PAGEALLOC
[   31.847903] CPU: 3 PID: 4131 Comm: insmod Tainted: G           O      5.6.0-rc5+ #978
[   31.850292] Hardware name: VMware, Inc. VMware Virtual Platform/440BX Desktop Reference Platform, BIOS 6.00 07/29/2019
[   31.853578] RIP: 0010:fork_usermode_blob+0xaa/0x190
[   31.855248] Code: 41 89 c4 78 06 41 bc f4 ff ff ff bf e8 03 00 00 e8 ab 75 61 00 48 8b 43 20 48 8b 8b 80 00 00 00 44 89 e6 48 c7 c7 98 ec db b6 <8b> 90 20 02 00 00 31 c0 e8 92 35 05 00 48 89 df e8 61 ab 1c 00 44
[   31.860535] RSP: 0018:ffffba7586287c48 EFLAGS: 00010296
[   31.862173] RAX: 6b6b6b6b6b6b6b6b RBX: ffffa124e05df0c0 RCX: 6b6b6b6b6b6b6b6b
[   31.864457] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffffffffb6dbec98
[   31.866585] RBP: ffffba7586287c78 R08: 0000000000000000 R09: 0000000000000000
[   31.868966] R10: 0000000000000001 R11: 0000000000000000 R12: 0000000000000000
[   31.871051] R13: ffffa124d4ef1a40 R14: ffffffffc0541024 R15: ffffba7586287e68
[   31.873188] FS:  00007fc8f6c2b740(0000) GS:ffffa124e7a00000(0000) knlGS:0000000000000000
[   31.875748] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   31.877856] CR2: 000055b90eba7e38 CR3: 000000021e06b005 CR4: 00000000003606e0
[   31.879968] Call Trace:
[   31.880842]  ? 0xffffffffc054d000
[   31.881943]  test_init+0x2e/0x1000 [test]
[   31.883207]  do_one_initcall+0x6f/0x360
[   31.884431]  ? kmem_cache_alloc_trace+0x2d8/0x380
[   31.885926]  do_init_module+0x5b/0x210
[   31.887137]  load_module+0x16b6/0x1d50
[   31.888384]  ? m_show+0x1d0/0x1d0
[   31.889524]  __do_sys_finit_module+0xa9/0x100
[   31.890965]  __x64_sys_finit_module+0x15/0x20
[   31.892387]  do_syscall_64+0x4a/0x1e0
[   31.893601]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
[   31.895119] RIP: 0033:0x7fc8f60ffba9
[   31.896305] Code: 01 00 48 81 c4 80 00 00 00 e9 f1 fe ff ff 0f 1f 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 97 e2 2c 00 f7 d8 64 89 01 48
[   31.901836] RSP: 002b:00007ffe67506d88 EFLAGS: 00000206 ORIG_RAX: 0000000000000139
[   31.904191] RAX: ffffffffffffffda RBX: 0000000001a671e0 RCX: 00007fc8f60ffba9
[   31.906317] RDX: 0000000000000000 RSI: 000000000041a96e RDI: 0000000000000003
[   31.908417] RBP: 000000000041a96e R08: 0000000000000000 R09: 00007ffe67506f28
[   31.910563] R10: 0000000000000003 R11: 0000000000000206 R12: 0000000000000000
[   31.913395] R13: 0000000001a66120 R14: 0000000000000000 R15: 0000000000000000
[   31.916120] Modules linked in: test(O+) af_packet nf_conntrack nf_defrag_ipv4 sunrpc mousedev vmw_balloon intel_rapl_perf input_leds led_class psmouse pcspkr sg vmw_vmci intel_agp intel_gtt i2c_piix4 rtc_cmos evdev mac_hid ac button ip_tables x_tables xfs libcrc32c crc32c_generic sd_mod ata_generic pata_acpi vmwgfx drm_kms_helper cfbfillrect syscopyarea cfbimgblt sysfillrect sysimgblt fb_sys_fops ahci cfbcopyarea mptspi libahci scsi_transport_spi fb fbdev mptscsih ttm mptbase ata_piix drm nvme drm_panel_orientation_quirks nvme_core libata t10_pi agpgart e1000 i2c_core scsi_mod serio_raw atkbd libps2 i8042 serio unix ipv6 crc_ccitt nf_defrag_ipv6
[   31.936929] ---[ end trace 8073d6b33b84006e ]---
[   31.939179] RIP: 0010:fork_usermode_blob+0xaa/0x190
[   31.941431] Code: 41 89 c4 78 06 41 bc f4 ff ff ff bf e8 03 00 00 e8 ab 75 61 00 48 8b 43 20 48 8b 8b 80 00 00 00 44 89 e6 48 c7 c7 98 ec db b6 <8b> 90 20 02 00 00 31 c0 e8 92 35 05 00 48 89 df e8 61 ab 1c 00 44
[   31.949189] RSP: 0018:ffffba7586287c48 EFLAGS: 00010296
[   31.951763] RAX: 6b6b6b6b6b6b6b6b RBX: ffffa124e05df0c0 RCX: 6b6b6b6b6b6b6b6b
[   31.954909] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffffffffb6dbec98
[   31.957834] RBP: ffffba7586287c78 R08: 0000000000000000 R09: 0000000000000000
[   31.960818] R10: 0000000000000001 R11: 0000000000000000 R12: 0000000000000000
[   31.963821] R13: ffffa124d4ef1a40 R14: ffffffffc0541024 R15: ffffba7586287e68
[   31.966644] FS:  00007fc8f6c2b740(0000) GS:ffffa124e7a00000(0000) knlGS:0000000000000000
[   31.970102] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   31.972786] CR2: 000055b90eba7e38 CR3: 000000021e06b005 CR4: 00000000003606e0
---------- without refcount-fix patch ----------

And this refcount fix patch makes consistent for both success and fail cases.

---------- with refcount-fix patch and without tomoyo ----------
[   26.901802] test: loading out-of-tree module taints kernel.
[   26.917614] writecount=0 fcount=1
[   26.922823] err=0 writecount=0 fcount=1
[   27.984948] err=0 writecount=0 fcount=1
[   27.986274] fork_usermode_blob()=0
---------- with refcount-fix patch and without tomoyo ----------

---------- with refcount-fix patch and with tomoyo ----------
[   24.784915] test: loading out-of-tree module taints kernel.
[   24.788705] writecount=0 fcount=1
[   24.790663] err=-2 writecount=0 fcount=1
[   25.796113] err=-2 writecount=0 fcount=1
[   25.799777] fork_usermode_blob()=-2
---------- with refcount-fix patch and with tomoyo ----------

Well, this -ENOENT assumption was introduced by commit 26a2a1c9eb88d9ac ("Domain transition handler.") in 2.6.30
and remains broken since commit 51f39a1f0cea1cac ("syscalls: implement execveat() system call") in 3.19...
