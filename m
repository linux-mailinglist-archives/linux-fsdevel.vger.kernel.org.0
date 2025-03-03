Return-Path: <linux-fsdevel+bounces-42912-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DFB4A4B5FE
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Mar 2025 03:12:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E0801890A54
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Mar 2025 02:13:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC0C5159596;
	Mon,  3 Mar 2025 02:12:41 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53A651547D2
	for <linux-fsdevel@vger.kernel.org>; Mon,  3 Mar 2025 02:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740967961; cv=none; b=k9j8ZAxmx/SvuWXtqE0Up9jIewV7Whg4eJeW51ZSzypG1K2p9BA7SD27OwucbUdEZddDVVXYTO+QweG3qx/y+1ZS/zPG61zm9neZBrhTj+Z7aNvqCFTeyNR5hwX/Wg4bvhCB5UyTBLzab6Eg5/3JdJySrZCtYg3AGHFEIb52cvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740967961; c=relaxed/simple;
	bh=0hsOxouyNsxQerX6uPPUr8edfjNKk3M4E1+UE5j9BVA=;
	h=Subject:To:References:Cc:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=MsW7Xxab6UHKkoMw/gYRV//EbXjeI3MYUXEREv7+LUdLDye9GO8Rildwy+XTjR60jOcj1anMKBBSAM0reCPKVZww3LJZs1ppHqOlSBT/Aql8M0VfqLRWBkACC6QnEEB8lrr/Kf032NUeKJG0WUQJ6fJ2pVGC1EEK6CcBPc0jHY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4Z5j4Q4TrPz4f3mJR
	for <linux-fsdevel@vger.kernel.org>; Mon,  3 Mar 2025 10:12:06 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 9CEF41A14CC
	for <linux-fsdevel@vger.kernel.org>; Mon,  3 Mar 2025 10:12:28 +0800 (CST)
Received: from [10.174.178.185] (unknown [10.174.178.185])
	by APP4 (Coremail) with SMTP id gCh0CgBHq18KEMVnpPyKFQ--.22048S3;
	Mon, 03 Mar 2025 10:12:28 +0800 (CST)
Subject: Re: [PATCH] proc: fix use-after-free in proc_get_inode()
To: Alexey Dobriyan <adobriyan@gmail.com>
References: <20250301034024.277290-1-yebin@huaweicloud.com>
 <2cdf3fb7-1b83-4484-b1e6-6508ddb8ed13@p183>
 <9760f1ae-7aec-4e17-b277-ea6aca13b382@p183>
Cc: akpm@linux-foundation.org, rick.p.edgecombe@intel.com, ast@kernel.org,
 kirill.shutemov@linux.intel.com, linux-fsdevel@vger.kernel.org,
 yebin10@huawei.com
From: yebin <yebin@huaweicloud.com>
Message-ID: <67C5100A.6090100@huaweicloud.com>
Date: Mon, 3 Mar 2025 10:12:26 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.1.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <9760f1ae-7aec-4e17-b277-ea6aca13b382@p183>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgBHq18KEMVnpPyKFQ--.22048S3
X-Coremail-Antispam: 1UD129KBjvAXoW3uw43Xw1xCr47KryxWw43Awb_yoW8Jr13Co
	WfG34xXr48GrZ8tr47G3WUAF18Xw4fJF97JF1jkrWfZF17tay5K342grn7Xa42vFs5Xr98
	Zrn2qr1Iya1rG3s3n29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
	AaLaJ3UjIYCTnIWjp_UUUYz7kC6x804xWl14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK
	8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4
	AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF
	7I0E14v26r4UJVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7
	CjxVAFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8C
	rVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4
	IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1cAE67vIY487MxkF7I0En4kS
	14v26r126r1DMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I
	8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWU
	twCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x
	0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_
	Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxUwx
	hLUUUUU
X-CM-SenderInfo: p1hex046kxt4xhlfz01xgou0bp/



On 2025/3/1 19:51, Alexey Dobriyan wrote:
> On Sat, Mar 01, 2025 at 07:46:13AM +0300, Alexey Dobriyan wrote:
>> On Sat, Mar 01, 2025 at 11:40:24AM +0800, Ye Bin wrote:
>>> There's a issue as follows:
>>> BUG: unable to handle page fault for address: fffffbfff80a702b
>>
>>> Above issue may happen as follows:
>>>        rmmod                         lookup
>>> sys_delete_module
>>>                           proc_lookup_de
>>>                             read_lock(&proc_subdir_lock);
>>> 			   pde_get(de);
>>> 			   read_unlock(&proc_subdir_lock);
>>> 			   proc_get_inode(dir->i_sb, de);
>>>    mod->exit()
>>>      proc_remove
>>>        remove_proc_subtree
>>>         write_lock(&proc_subdir_lock);
>>>         write_unlock(&proc_subdir_lock);
>>>         proc_entry_rundown(de);
>>>    free_module(mod);
>>>
>>>                                 if (S_ISREG(inode->i_mode))
>>> 	                         if (de->proc_ops->proc_read_iter)
>>>                             --> As module is already freed, will trigger UAF
>>
>> Hey look, vintage 17.5 year old /proc bug.
>> This just shows how long I didn't ran rmmod test. :-(
>>
>>> To solve above issue there's need to get 'in_use' before use proc_dir_entry
>>> in proc_get_inode().
>>>
>>> Fixes: fd5a13f4893c ("proc: add a read_iter method to proc proc_ops")
>>
>> OK, this is copy of the original sin below.
>>
>>> Fixes: 778f3dd5a13c ("Fix procfs compat_ioctl regression")
>>
>> This one is.
>>
>> Let me think a little.
>>
>>> --- a/fs/proc/inode.c
>>> +++ b/fs/proc/inode.c
>>> @@ -644,6 +644,11 @@ struct inode *proc_get_inode(struct super_block *sb, struct proc_dir_entry *de)
>>>   		return inode;
>>>   	}
>>>
>>> +	if (!pde_is_permanent(de) && !use_pde(de)) {
>>> +		pde_put(de);
>>> +		return NULL;
>>> +	}
>>> +
>>>   	if (de->mode) {
>>>   		inode->i_mode = de->mode;
>>>   		inode->i_uid = de->uid;
>>> @@ -677,5 +682,9 @@ struct inode *proc_get_inode(struct super_block *sb, struct proc_dir_entry *de)
>>>   	} else {
>>>   		BUG();
>>>   	}
>>> +
>>> +	if (!pde_is_permanent(de))
>>> +		unuse_pde(de);
>>> +
>
> I can't reproduce. Can you test new patch -- it avoid 2 atomic ops on
> common path.
>
I can provide specific reproduction methods and test results of new fixes.
Reproduction method as follows：
1. Kernel modification adding delay：
diff --git a/fs/proc/generic.c b/fs/proc/generic.c
index a3e22803cddf..31a5d8171259 100644
--- a/fs/proc/generic.c
+++ b/fs/proc/generic.c
@@ -27,6 +27,7 @@
  #include <linux/completion.h>
  #include <linux/uaccess.h>
  #include <linux/seq_file.h>
+#include <linux/delay.h>

  #include "internal.h"

@@ -251,6 +252,13 @@ struct dentry *proc_lookup_de(struct inode *dir, 
struct dentry *dentry,
         if (de) {
                 pde_get(de);
                 read_unlock(&proc_subdir_lock);
+               if (!strcmp("ls", current->comm)) {
+                       printk("%s: %s %d will wait de=0x%px name=%pd 
remove....\n",
+                              __func__, current->comm, current->pid, 
de, dentry);
+                       mdelay(5 * 1000);
+                       printk("%s: %s %d end delay  de=0x%px name=%pd 
remove....\n",
+                              __func__, current->comm, current->pid, 
de, dentry);
+               }
                 inode = proc_get_inode(dir->i_sb, de);
                 if (!inode)
                         return ERR_PTR(-ENOMEM);
diff --git a/kernel/module/main.c b/kernel/module/main.c
index 3dbe23098433..0b2488c4bdab 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -60,6 +60,7 @@
  #include <linux/debugfs.h>
  #include <linux/execmem.h>
  #include <uapi/linux/module.h>
+#include <linux/delay.h>
  #include "internal.h"

  #define CREATE_TRACE_POINTS
@@ -776,6 +777,9 @@ SYSCALL_DEFINE2(delete_module, const char __user *, 
name_user,
                 goto out;

         mutex_unlock(&module_mutex);
+       printk("%s: will wait for ls procfs 2s....\n", __func__);
+       mdelay(2 * 1000);
+       printk("%s: end wait for ls procfs\n", __func__);
         /* Final destruction now no one is using it. */
         if (mod->exit != NULL)
                 mod->exit();
@@ -791,6 +795,7 @@ SYSCALL_DEFINE2(delete_module, const char __user *, 
name_user,
         strscpy(last_unloaded_module.taints, module_flags(mod, buf, 
false), sizeof(last_unloaded_module.taints));

         free_module(mod);
+       printk("%s: freed module\n", __func__);
         /* someone could wait for the module in add_unformed_module() */
         wake_up_all(&module_wq);
         return 0;

2. Preparing module
test_procfs.c：
#include <linux/file.h>
#include <linux/proc_fs.h>
#include <linux/module.h>
#include <linux/version.h>

struct proc_dir_entry *g_proc_test;
static const struct proc_ops g_proc_test_operations = {};

static int __init test_init(void)
{
         g_proc_test = proc_create("test_procfs", 0400, NULL,
                                   &g_proc_test_operations);

         return 0;
}

static void __exit test_exit(void)
{
         printk("test: will exit\n");
         proc_remove(g_proc_test);
         printk("test: test proc remove\n");
}

module_init(test_init);
module_exit(test_exit);
MODULE_DESCRIPTION("Test module");
MODULE_LICENSE("GPL");

3. Reproduction procedure：
     insmod test_procfs.ko
     rmmod test_procfs &
     sleep 1
     ls /proc/test_procfs

4. Reproduction result：
[root@localhost ~]#     insmod test_procfs.ko
[  106.816730][ T2550] test_procfs: loading out-of-tree module taints 
kernel.
[root@localhost ~]#     rmmod test_procfs &
[1] 2553
[root@localhost ~]#     sleep 1
[  106.871589][ T2553] __do_sys_delete_module: will wait for ls procfs 
2s....
[root@localhost ~]#     ls /proc/test_procfs
[  107.898489][ T2556] proc_lookup_de: ls 2556 will wait 
de=0xffff8881136bb900 name=test_procfs remove....
[  108.876730][ T2553] __do_sys_delete_module: end wait for ls procfs
[  108.877177][ T2553] test: will exit
[  108.877430][ T2553] test: test proc remove
[  108.897238][ T2553] __do_sys_delete_module: freed module
[  112.903812][ T2556] proc_lookup_de: ls 2556 end delay 
de=0xffff8881136bb900 name=test_procfs remove....
[  112.904967][ T2556] BUG: unable to handle page fault for address: 
fffffbfff80bb01b
[  112.906801][ T2556] #PF: supervisor read access in kernel mode
[  112.908180][ T2556] #PF: error_code(0x0000) - not-present page
[  112.909534][ T2556] PGD 817fc4067 P4D 817fc4067 PUD 817fc0067 PMD 
102ebb067 PTE 0
[  112.911272][ T2556] Oops: Oops: 0000 [#1] PREEMPT SMP KASAN PTI
[  112.912648][ T2556] CPU: 28 UID: 0 PID: 2556 Comm: ls Tainted: G 
       OE 
6.14.0-rc4-next-20250228-862.14.0.6.x86_64-00030-gd76eeb7f22fa #110
[  112.915724][ T2556] Tainted: [O]=OOT_MODULE, [E]=UNSIGNED_MODULE
[  112.917124][ T2556] Hardware name: QEMU Standard PC (i440FX + PIIX, 
1996), BIOS 1.15.0-1 04/01/2014
[  112.919182][ T2556] RIP: 0010:proc_get_inode+0x302/0x6e0
[  112.920475][ T2556] Code: 48 89 fa 48 c1 ea 03 80 3c 02 00 0f 85 cf 
03 00 00 48 b8 00 00 00 00 00 fc ff df 48 8b 5d 30 48 8d 7b 18 48 89 fa 
48 c1 ea 03 <808
[  112.924874][ T2556] RSP: 0018:ffff88812c157998 EFLAGS: 00010a06
[  112.926288][ T2556] RAX: dffffc0000000000 RBX: ffffffffc05d80c0 RCX: 
0000000000000007
[  112.928094][ T2556] RDX: 1ffffffff80bb01b RSI: 0000000000000001 RDI: 
ffffffffc05d80d8
[  112.929908][ T2556] RBP: ffff8881136bb900 R08: 0000000067c50d9b R09: 
1ffff1102582af20
[  112.931755][ T2556] R10: ffffffffa160da07 R11: ffffffff9eb42bb8 R12: 
ffff888105bacda0
[  112.933572][ T2556] R13: ffff888105b38048 R14: ffff8881136bb904 R15: 
0000000000000001
[  112.935372][ T2556] FS:  00007fc41042e840(0000) 
GS:ffff88840c1b4000(0000) knlGS:0000000000000000
[  112.937396][ T2556] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  112.938895][ T2556] CR2: fffffbfff80bb01b CR3: 000000010353c000 CR4: 
00000000000006f0
[  112.940732][ T2556] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 
0000000000000000
[  112.942555][ T2556] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 
0000000000000400
[  112.944372][ T2556] Call Trace:
[  112.945140][ T2556]  <TASK>
[  112.945822][ T2556]  ? __die+0x24/0x70
[  112.946742][ T2556]  ? page_fault_oops+0xce/0x120
[  112.947870][ T2556]  ? exc_page_fault+0xb2/0xc0
[  112.948967][ T2556]  ? asm_exc_page_fault+0x26/0x30
[  112.950055][ T2556]  ? inode_init_always_gfp+0x948/0xba0
[  112.951199][ T2556]  ? proc_get_inode+0x302/0x6e0
[  112.952232][ T2556]  ? proc_get_inode+0x3c6/0x6e0
[  112.953280][ T2556]  proc_lookup_de+0x11f/0x2e0
[  112.954177][ T2556]  __lookup_slow+0x187/0x350
[  112.955065][ T2556]  ? __pfx___lookup_slow+0x10/0x10
[  112.956070][ T2556]  ? try_to_unlazy+0x1c4/0x480
[  112.956984][ T2556]  ? lookup_fast+0x230/0x4e0
[  112.957850][ T2556]  ? __pfx_link_path_walk.part.0.constprop.0+0x10/0x10
[  112.959058][ T2556]  walk_component+0x2ab/0x4f0
[  112.959891][ T2556]  path_lookupat+0x120/0x660
[  112.960711][ T2556]  ? __pfx_stack_trace_consume_entry+0x10/0x10
[  112.961780][ T2556]  filename_lookup+0x1cd/0x560
[  112.962578][ T2556]  ? __pfx_filename_lookup+0x10/0x10
[  112.963458][ T2556]  ? set_track_prepare+0x49/0x70
[  112.964282][ T2556]  ? kmem_cache_alloc_noprof+0x2d7/0x360
[  112.965223][ T2556]  ? getname_flags.part.0+0x4b/0x490
[  112.966075][ T2556]  ? __pfx__raw_spin_lock_irqsave+0x10/0x10
[  112.967003][ T2556]  ? __link_object+0x10c/0x1b0
[  112.967754][ T2556]  vfs_statx+0xab/0x150
[  112.968401][ T2556]  ? __pfx_vfs_statx+0x10/0x10
[  112.969148][ T2556]  ? getname_flags.part.0+0xaf/0x490
[  112.969942][ T2556]  __do_sys_newstat+0x95/0x100
[  112.970648][ T2556]  ? __pfx___do_sys_newstat+0x10/0x10
[  112.971435][ T2556]  ? handle_mm_fault+0x172/0x430
[  112.972160][ T2556]  do_syscall_64+0x5f/0x170
[  112.972831][ T2556]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[  112.973693][ T2556] RIP: 0033:0x7fc40f2ee895
[  112.974280][ T2556] Code: e8 60 01 00 00 48 83 c4 18 c3 66 2e 0f 1f 
84 00 00 00 00 00 90 83 ff 01 48 89 f0 77 18 48 89 c7 48 89 d6 b8 04 00 
00 00 0f 05 <486
[  112.976839][ T2556] RSP: 002b:00007ffd0107d9f8 EFLAGS: 00000246 
ORIG_RAX: 0000000000000004
[  112.977920][ T2556] RAX: ffffffffffffffda RBX: 00007ffd0107ecb3 RCX: 
00007fc40f2ee895
[  112.978919][ T2556] RDX: 0000000016022110 RSI: 0000000016022110 RDI: 
00007ffd0107ecb3
[  112.979928][ T2556] RBP: 00007ffd0107dda0 R08: 0000000000000000 R09: 
0000000016022100
[  112.980937][ T2556] R10: 00007ffd0107d5c0 R11: 0000000000000246 R12: 
00007ffd0107ecb3
[  112.981932][ T2556] R13: 000000000000000a R14: 0000000016022100 R15: 
0000000000000000
[  112.982887][ T2556]  </TASK>
...
[  112.999566][ T2556] ---[ end Kernel panic - not syncing: Fatal 
exception ]---

5. Test results for new patch：
--round 1
[root@localhost ~]# insmod test_procfs.ko
[  300.997847][ T2641] test_procfs: loading out-of-tree module taints 
kernel.
[root@localhost ~]# rmmod test_procfs &
[1] 2644
[root@localhost ~]# sleep 1
[  301.062858][ T2644] __do_sys_delete_module: will wait for ls procfs 
2s....
[root@localhost ~]# ls /proc/test_procfs
[  302.084609][ T2647] proc_lookup_de: ls 2647 will wait 
de=0xffff888122a74000 name=test_procfs remove....
[  303.066879][ T2644] __do_sys_delete_module: end wait for ls procfs
[  303.067351][ T2644] test: will exit
[  303.067624][ T2644] test: test proc remove
[  303.087512][ T2644] __do_sys_delete_module: freed module

[  307.088773][ T2647] proc_lookup_de: ls 2647 end delay 
de=0xffff888122a74000 name=test_procfs remove....
ls: cannot access /proc/test_procfs: No such file or directory
[1]+  Done                    rmmod test_procfs

--round 2
[root@localhost ~]#
[root@localhost ~]# insmod test_procfs.ko
[root@localhost ~]# rmmod test_procfs &
[1] 2651
[root@localhost ~]# sleep 1
[  315.614603][ T2651] __do_sys_delete_module: will wait for ls procfs 
2s....
[root@localhost ~]# ls /proc/test_procfs
[  316.638267][ T2654] proc_lookup_de: ls 2654 will wait 
de=0xffff888117ade000 name=test_procfs remove....
[  317.617933][ T2651] __do_sys_delete_module: end wait for ls procfs
[  317.618504][ T2651] test: will exit
[  317.618758][ T2651] test: test proc remove
[  317.638900][ T2651] __do_sys_delete_module: freed module
[  321.642678][ T2654] proc_lookup_de: ls 2654 end delay 
de=0xffff888117ade000 name=test_procfs remove....
ls: cannot access /proc/test_procfs: No such file or directory
[1]+  Done                    rmmod test_procfs


> If the bug is looking into pde->proc_ops, then don't do it.
   Yes. It's a really good idea.
>


