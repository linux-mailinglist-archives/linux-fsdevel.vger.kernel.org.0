Return-Path: <linux-fsdevel+bounces-42386-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EEE95A415BF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Feb 2025 08:02:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D6DBA166C2D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Feb 2025 07:02:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26A4E1DB34C;
	Mon, 24 Feb 2025 07:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=m.fudan.edu.cn header.i=@m.fudan.edu.cn header.b="h/jpnLkz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtpbgbr1.qq.com (smtpbgbr1.qq.com [54.207.19.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 217A62B9B7;
	Mon, 24 Feb 2025 07:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.207.19.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740380540; cv=none; b=fw/C+IhlH3SrEMD15TJ/hGbjeTMMW8KeLHrdERA9TMNVf25TIEzECMj8mFvXiXx3LHkiNHgjOXeK3q7Qedru0aU2wouXd4gl7wWxQ8EG7kUgd/1I5RHkPlw2A9520X7yqVWAxQk1evyBsiuAzKvZxMV4Yfa6Bhl8UB/4D/Ylmyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740380540; c=relaxed/simple;
	bh=yRhDTKlSCUyuNVqeszGHZdYRoSSGIqDMqqfXqekQTds=;
	h=From:Content-Type:Mime-Version:Subject:Message-Id:Date:Cc:To; b=ujH77nGbj7RCsQv2tQPuANb+syNRBRHu1wdn9svSap5wavOEdmUG/d0Gx8MsBElkZ0YipMlbNIedXhnt++GwDnkrHABBd7oFJB+LQahLkz1ylvAB3Tm2qFIu59kEEdCG6VvIbLB5n9rTzFDIF6nTccJ34SnCflBwQ6bx+wd44QM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=m.fudan.edu.cn; spf=pass smtp.mailfrom=m.fudan.edu.cn; dkim=pass (1024-bit key) header.d=m.fudan.edu.cn header.i=@m.fudan.edu.cn header.b=h/jpnLkz; arc=none smtp.client-ip=54.207.19.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=m.fudan.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=m.fudan.edu.cn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=m.fudan.edu.cn;
	s=sorc2401; t=1740380490;
	bh=V7qsRLdXkZlw0W7HKOTVcedvQC0hs9Z8rB5x5WLRYXo=;
	h=From:Mime-Version:Subject:Message-Id:Date:To;
	b=h/jpnLkzS4KQNqwhl35xoiA6oeMcPsDhdzS8HpiZLjv0CoLUyREBYfbudhJfrmjuv
	 dlDXkLgeEXUWSfc84Nah+R2Kg2rb1NJlCdiIjMJp0mVPxycWkqw/3O2D88ODIv87CB
	 6qlowPJITS0h4VBfdoVXIibUCwxdeMsJbLoV9bQ0=
X-QQ-mid: bizesmtpsz11t1740380488tesplx
X-QQ-Originating-IP: 2GRpAs7D0fk1sOCcZeWqQMv9fNR/IsRZNRnt9fej5Zo=
Received: from smtpclient.apple ( [202.120.235.11])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 24 Feb 2025 15:01:26 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 4223574400451450303
From: Kun Hu <huk23@m.fudan.edu.cn>
Content-Type: text/plain;
	charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3818.100.11.1.3\))
Subject: KASAN: slab-use-after-free Read in chrdev_open
Message-Id: <2C7D0D31-01C4-42ED-94A9-5D668600C063@m.fudan.edu.cn>
Date: Mon, 24 Feb 2025 15:01:16 +0800
Cc: hillf.zj@alibaba-inc.com,
 linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 "jjtan24@m.fudan.edu.cn" <jjtan24@m.fudan.edu.cn>,
 syzkaller@googlegroups.com,
 baishuoran@hrbeu.edu.cn,
 akpm@linux-foundation.org
To: crquan@gmail.com
X-Mailer: Apple Mail (2.3818.100.11.1.3)
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpsz:m.fudan.edu.cn:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: NTHY/YkN8c+xeW6Ljc2KRzDdhrpxRpSzxrP/eCGyLVpDUnRaSJFpiupX
	ZuUGaomytcJXxIChvYuQcYxvIuuqrTOMVqn2kOETj79o7iR82Fzf6O2OHjtF52W+1sfCsgG
	JuArzYrcVHORichqS4Z+u0lq9NcXuIqE43Bv55GMCbMe4I8NlIwOAHRAA5I0n6slWfTyhDm
	wdEO6unWL3QqVyBxAiewvGPIGZUSjpb0Psy5G4JRTI3zY9OgblNxh3OUhuP7ZRYF1NmQdnq
	mFdJAhZv3nLyJnEGGA3HwUeYPPYe5QPlewADZg6bruml+RdE55jT+BCTFP+r5sCEIQ3PtwU
	w302+FQOGsr9AKQueh55B9jqdaXILJGXP5Ud/ueNX6mK4QC5lo9mM4ked1gXWU7tt0+UJFa
	XePx/G3VNIt921iBMd2Mnp2kD4yidpCiobO5/VAscKEvnGsBegqFUuiARz81Q/9RWmfOevn
	RU04ZzPpvYv8c/kM1im6C7IelodpiNQpGc5QL+tzRUaSRooT1r0abCMWRXbPEQVZnbf7umN
	WXnZpCpGP5c7iJJc7s0zbfuI4mkD9IYkOOVoO1w85JaLlaGY+fWWJTBQDRcrlWx6v6Y+sES
	cL8tMupN/d/FVa3D+jcqhSZVH5Xcju+DewlLbV3VkmdvWs2sHH2nsUQRPo26q/45mPpH9en
	G1KDqOxl4SbP3FJGrMy8av+ayoUUaG199kMRz19SSCIDZLwXr/TNjfkogG0R4lrco0FmfxK
	SFBdF84zCHNGe3X/MnZgUrzM/0KOjIHjlkVIPXaBcTOfrVrjMu9xaTrAJH9htG2PDt5+6/8
	rpq5EYoOhXVak2pU7ziyYD6Mg/Xx28SMHwBM1BDJa6JXJGmhZsszYlCHVFIlbmp/6Ska4gX
	FCrNBCvF5zA9wLSOgEx3epKCqeVZF4i0ZObeYR3cTtLoE0OcCLu2VNjtsohU704N8SL7CXN
	G43EDD2qLN5QOdi0Jt0X09LAHbkmAd01SibM=
X-QQ-XMRINFO: NI4Ajvh11aEj8Xl/2s1/T8w=
X-QQ-RECHKSPAM: 0

Dear Maintainers,

When using our customized Syzkaller to fuzz the latest Linux kernel, the =
following crash (67s)
was triggered.

HEAD commit: 6537cfb395f352782918d8ee7b7f10ba2cc3cbf2
git tree: upstream
Kernel config: =
https://github.com/pghk13/Kernel-Bug/blob/main/0219_6.13rc7_todo/config.tx=
t
C reproducer: =
https://github.com/pghk13/Kernel-Bug/blob/main/0219_6.13rc7_todo/67-KASAN_=
%20slab-use-after-free%20Read%20in%20cd_forget/c_repro.c
Syzlang reproducer: =
https://github.com/pghk13/Kernel-Bug/blob/main/0219_6.13rc7_todo/67-KASAN_=
%20slab-use-after-free%20Read%20in%20cd_forget/syscall_repro.syz.txt
Similar Bug: =
https://lore.kernel.org/all/tencent_706EA97643BAE446F774577CA6D6536A0305@q=
q.com/T/#me2c1e1442c2d22dd3963aeecd4b6dcb507064af0

Our reproducer uses mounts a constructed filesystem image. This UAF =
seems to occur at line 396 in the chrdev_open function. The root cause =
is speculated to be that another thread may have released the inode =
after the function released the spinlock (cdev_lock). when kobj_lookup =
returned, the inode may have been released despite reacquiring the lock, =
causing subsequent list_add operations to access the released =
inode->i_devices.

We have also listed a similar bug which was successfully fixed by Hillf =
Danton last year. I'm not sure the two are necessarily related, but this =
one did go on too long ago, so it's been reported under consideration. =
If this issue doesn't have an impact, please ignore it =E2=98=BA.

If you fix this issue, please add the following tag to the commit:
Reported-by: Kun Hu <huk23@m.fudan.edu.cn>, Jiaji Qin =
<jjtan24@m.fudan.edu.cn>, Shuoran Bai <baishuoran@hrbeu.edu.cn>

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
BUG: KASAN: slab-use-after-free in =
__list_add_valid_or_report+0x16a/0x1a0
Read of size 8 at addr ffff8880456dfc20 by task syz-executor278/9510

CPU: 3 UID: 0 PID: 9510 Comm: syz-executor278 Not tainted 6.14.0-rc3 #1
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
1.13.0-1ubuntu1.1 04/01/2014
Call Trace:
 <TASK>
 dump_stack_lvl+0x116/0x1b0
 print_report+0xc0/0x5e0
 kasan_report+0x93/0xc0
 __list_add_valid_or_report+0x16a/0x1a0
 chrdev_open+0x3a9/0x590
 do_dentry_open+0x786/0x1ca0
 vfs_open+0x82/0x3f0
 path_openat+0x1f04/0x28f0
 do_filp_open+0x1fa/0x2f0
 do_sys_openat2+0x677/0x720
 do_sys_open+0xc7/0x150
 do_syscall_64+0xcf/0x250
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f0e70c0e76d
Code: c3 e8 17 2d 00 00 0f 1f 80 00 00 00 00 f3 0f 1e fa 48 89 f8 48 89 =
f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 =
f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffe3b539ce8 EFLAGS: 00000246 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 0030656c69662f2e RCX: 00007f0e70c0e76d
RDX: 0000000000000000 RSI: 0000000020002140 RDI: ffffffffffffff9c
RBP: 0000000000000003 R08: 00007ffe3b53a209 R09: 00007ffe3b53a209
R10: 0000000000000000 R11: 0000000000000246 R12: 00007ffe3b539d0c
R13: 00007ffe3b539d30 R14: 00007ffe3b539d10 R15: 0000000000000001
 </TASK>

Allocated by task 9504:
 kasan_save_stack+0x24/0x50
 kasan_save_track+0x14/0x30
 __kasan_slab_alloc+0x87/0x90
 kmem_cache_alloc_lru_noprof+0x16c/0x4c0
 ntfs_alloc_inode+0x27/0x80
 alloc_inode+0x63/0x1f0
 new_inode+0x16/0x40
 ntfs_new_inode+0x44/0x110
 ntfs_create_inode+0x3f3/0x3de0
 ntfs_mknod+0x3c/0x50
 vfs_mknod+0x5eb/0x8f0
 do_mknodat+0x370/0x540
 __x64_sys_mknodat+0xb0/0xe0
 do_syscall_64+0xcf/0x250
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Freed by task 24:
 kasan_save_stack+0x24/0x50
 kasan_save_track+0x14/0x30
 kasan_save_free_info+0x3a/0x60
 __kasan_slab_free+0x54/0x70
 kmem_cache_free+0x153/0x560
 i_callback+0x46/0x70
 rcu_core+0x7c5/0x16b0
 handle_softirqs+0x1bd/0x880
 run_ksoftirqd+0x3a/0x60
 smpboot_thread_fn+0x63b/0xa00
 kthread+0x42a/0x880
 ret_from_fork+0x48/0x80
 ret_from_fork_asm+0x1a/0x30

Last potentially related work creation:
 kasan_save_stack+0x24/0x50
 kasan_record_aux_stack+0xb0/0xc0
 __call_rcu_common.constprop.0+0x99/0x860
 destroy_inode+0x12b/0x1b0
 evict+0x4f2/0x860
 iput+0x51c/0x830
 dentry_unlink_inode+0x2cd/0x4c0
 __dentry_kill+0x186/0x5b0
 shrink_dentry_list+0x13d/0x650
 shrink_dcache_parent+0x1c5/0x5a0
 do_one_tree+0x11/0x50
 shrink_dcache_for_umount+0x95/0x1c0
 generic_shutdown_super+0x6c/0x390
 kill_block_super+0x3b/0x90
 ntfs3_kill_sb+0x40/0xf0
 deactivate_locked_super+0xbb/0x130
 deactivate_super+0xb1/0xd0
 cleanup_mnt+0x378/0x510
 task_work_run+0x173/0x280
 syscall_exit_to_user_mode+0x29e/0x2a0
 do_syscall_64+0xdc/0x250
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

The buggy address belongs to the object at ffff8880456df580
 which belongs to the cache ntfs_inode_cache of size 1752
The buggy address is located 1696 bytes inside of
 freed 1752-byte region [ffff8880456df580, ffff8880456dfc58)

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 =
pfn:0x456d8
head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
memcg:ffff888050577001
flags: 0x4fff00000000040(head|node=3D1|zone=3D1|lastcpupid=3D0x7ff)
page_type: f5(slab)
raw: 04fff00000000040 ffff888040af68c0 dead000000000122 0000000000000000
raw: 0000000000000000 0000000000110011 00000000f5000000 ffff888050577001
head: 04fff00000000040 ffff888040af68c0 dead000000000122 =
0000000000000000
head: 0000000000000000 0000000000110011 00000000f5000000 =
ffff888050577001
head: 04fff00000000003 ffffea000115b601 ffffffffffffffff =
0000000000000000
head: 0000000000000008 0000000000000000 00000000ffffffff =
0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Reclaimable, gfp_mask =
0xd2050(__GFP_IO|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC|__=
GFP_RECLAIMABLE), pid 9504, tgid 9504 (syz-executor278), ts =
888593482435, free_ts 887115858472
 prep_new_page+0x1b0/0x1e0
 get_page_from_freelist+0x19a2/0x3250
 __alloc_frozen_pages_noprof+0x324/0x6b0
 alloc_pages_mpol+0x20a/0x550
 new_slab+0x251/0x350
 ___slab_alloc+0xe40/0x1740
 __slab_alloc.isra.0+0x56/0xb0
 kmem_cache_alloc_lru_noprof+0x27d/0x4c0
 ntfs_alloc_inode+0x27/0x80
 alloc_inode+0x63/0x1f0
 iget5_locked+0x5f/0xa0
 ntfs_iget5+0xda/0x39f0
 ntfs_fill_super+0x1aa9/0x3ed0
 get_tree_bdev_flags+0x38c/0x620
 vfs_get_tree+0x93/0x340
 path_mount+0x1290/0x1bc0
page last free pid 9490 tgid 9490 stack trace:
 free_frozen_pages+0x7aa/0x1290
 qlist_free_all+0x50/0x130
 kasan_quarantine_reduce+0x168/0x1c0
 __kasan_slab_alloc+0x67/0x90
 kmem_cache_alloc_noprof+0x167/0x4b0
 vm_area_dup+0x22/0x300
 __split_vma+0x171/0x1160
 vms_gather_munmap_vmas+0x1c5/0x15a0
 __mmap_region+0x31a/0x2980
 mmap_region+0x17b/0x3c0
 do_mmap+0xd6b/0x11a0
 vm_mmap_pgoff+0x207/0x3b0
 ksys_mmap_pgoff+0x46d/0x600
 __x64_sys_mmap+0x125/0x190
 do_syscall_64+0xcf/0x250
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Memory state around the buggy address:
 ffff8880456dfb00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff8880456dfb80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff8880456dfc00: fb fb fb fb fb fb fb fb fb fb fb fc fc fc fc fc
                               ^
 ffff8880456dfc80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff8880456dfd00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
2025/02/21 22:30:40 reproducing crash 'KASAN: slab-use-after-free Read =
in cd_forget': final repro crashed as (corrupted=3Dfalse):
loop0: detected capacity change from 0 to 4096
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
BUG: KASAN: slab-use-after-free in =
__list_add_valid_or_report+0x16a/0x1a0
Read of size 8 at addr ffff8880456dfc20 by task syz-executor278/9510

CPU: 3 UID: 0 PID: 9510 Comm: syz-executor278 Not tainted 6.14.0-rc3 #1
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
1.13.0-1ubuntu1.1 04/01/2014
Call Trace:
 <TASK>
 dump_stack_lvl+0x116/0x1b0
 print_report+0xc0/0x5e0
 kasan_report+0x93/0xc0
 __list_add_valid_or_report+0x16a/0x1a0
 chrdev_open+0x3a9/0x590
 do_dentry_open+0x786/0x1ca0
 vfs_open+0x82/0x3f0
 path_openat+0x1f04/0x28f0
 do_filp_open+0x1fa/0x2f0
 do_sys_openat2+0x677/0x720
 do_sys_open+0xc7/0x150
 do_syscall_64+0xcf/0x250
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f0e70c0e76d
Code: c3 e8 17 2d 00 00 0f 1f 80 00 00 00 00 f3 0f 1e fa 48 89 f8 48 89 =
f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 =
f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffe3b539ce8 EFLAGS: 00000246 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 0030656c69662f2e RCX: 00007f0e70c0e76d
RDX: 0000000000000000 RSI: 0000000020002140 RDI: ffffffffffffff9c
RBP: 0000000000000003 R08: 00007ffe3b53a209 R09: 00007ffe3b53a209
R10: 0000000000000000 R11: 0000000000000246 R12: 00007ffe3b539d0c
R13: 00007ffe3b539d30 R14: 00007ffe3b539d10 R15: 0000000000000001
 </TASK>

Allocated by task 9504:
 kasan_save_stack+0x24/0x50
 kasan_save_track+0x14/0x30
 __kasan_slab_alloc+0x87/0x90
 kmem_cache_alloc_lru_noprof+0x16c/0x4c0
 ntfs_alloc_inode+0x27/0x80
 alloc_inode+0x63/0x1f0
 new_inode+0x16/0x40
 ntfs_new_inode+0x44/0x110
 ntfs_create_inode+0x3f3/0x3de0
 ntfs_mknod+0x3c/0x50
 vfs_mknod+0x5eb/0x8f0
 do_mknodat+0x370/0x540
 __x64_sys_mknodat+0xb0/0xe0
 do_syscall_64+0xcf/0x250
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Freed by task 24:
 kasan_save_stack+0x24/0x50
 kasan_save_track+0x14/0x30
 kasan_save_free_info+0x3a/0x60
 __kasan_slab_free+0x54/0x70
 kmem_cache_free+0x153/0x560
 i_callback+0x46/0x70
 rcu_core+0x7c5/0x16b0
 handle_softirqs+0x1bd/0x880
 run_ksoftirqd+0x3a/0x60
 smpboot_thread_fn+0x63b/0xa00
 kthread+0x42a/0x880
 ret_from_fork+0x48/0x80
 ret_from_fork_asm+0x1a/0x30

Last potentially related work creation:
 kasan_save_stack+0x24/0x50
 kasan_record_aux_stack+0xb0/0xc0
 __call_rcu_common.constprop.0+0x99/0x860
 destroy_inode+0x12b/0x1b0
 evict+0x4f2/0x860
 iput+0x51c/0x830
 dentry_unlink_inode+0x2cd/0x4c0
 __dentry_kill+0x186/0x5b0
 shrink_dentry_list+0x13d/0x650
 shrink_dcache_parent+0x1c5/0x5a0
 do_one_tree+0x11/0x50
 shrink_dcache_for_umount+0x95/0x1c0
 generic_shutdown_super+0x6c/0x390
 kill_block_super+0x3b/0x90
 ntfs3_kill_sb+0x40/0xf0
 deactivate_locked_super+0xbb/0x130
 deactivate_super+0xb1/0xd0
 cleanup_mnt+0x378/0x510
 task_work_run+0x173/0x280
 syscall_exit_to_user_mode+0x29e/0x2a0
 do_syscall_64+0xdc/0x250
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

The buggy address belongs to the object at ffff8880456df580
 which belongs to the cache ntfs_inode_cache of size 1752
The buggy address is located 1696 bytes inside of
 freed 1752-byte region [ffff8880456df580, ffff8880456dfc58)

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 =
pfn:0x456d8
head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
memcg:ffff888050577001
flags: 0x4fff00000000040(head|node=3D1|zone=3D1|lastcpupid=3D0x7ff)
page_type: f5(slab)
raw: 04fff00000000040 ffff888040af68c0 dead000000000122 0000000000000000
raw: 0000000000000000 0000000000110011 00000000f5000000 ffff888050577001
head: 04fff00000000040 ffff888040af68c0 dead000000000122 =
0000000000000000
head: 0000000000000000 0000000000110011 00000000f5000000 =
ffff888050577001
head: 04fff00000000003 ffffea000115b601 ffffffffffffffff =
0000000000000000
head: 0000000000000008 0000000000000000 00000000ffffffff =
0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Reclaimable, gfp_mask =
0xd2050(__GFP_IO|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC|__=
GFP_RECLAIMABLE), pid 9504, tgid 9504 (syz-executor278), ts =
888593482435, free_ts 887115858472
 prep_new_page+0x1b0/0x1e0
 get_page_from_freelist+0x19a2/0x3250
 __alloc_frozen_pages_noprof+0x324/0x6b0
 alloc_pages_mpol+0x20a/0x550
 new_slab+0x251/0x350
 ___slab_alloc+0xe40/0x1740
 __slab_alloc.isra.0+0x56/0xb0
 kmem_cache_alloc_lru_noprof+0x27d/0x4c0
 ntfs_alloc_inode+0x27/0x80
 alloc_inode+0x63/0x1f0
 iget5_locked+0x5f/0xa0
 ntfs_iget5+0xda/0x39f0
 ntfs_fill_super+0x1aa9/0x3ed0
 get_tree_bdev_flags+0x38c/0x620
 vfs_get_tree+0x93/0x340
 path_mount+0x1290/0x1bc0
page last free pid 9490 tgid 9490 stack trace:
 free_frozen_pages+0x7aa/0x1290
 qlist_free_all+0x50/0x130
 kasan_quarantine_reduce+0x168/0x1c0
 __kasan_slab_alloc+0x67/0x90
 kmem_cache_alloc_noprof+0x167/0x4b0
 vm_area_dup+0x22/0x300
 __split_vma+0x171/0x1160
 vms_gather_munmap_vmas+0x1c5/0x15a0
 __mmap_region+0x31a/0x2980
 mmap_region+0x17b/0x3c0
 do_mmap+0xd6b/0x11a0
 vm_mmap_pgoff+0x207/0x3b0
 ksys_mmap_pgoff+0x46d/0x600
 __x64_sys_mmap+0x125/0x190
 do_syscall_64+0xcf/0x250
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Memory state around the buggy address:
 ffff8880456dfb00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff8880456dfb80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff8880456dfc00: fb fb fb fb fb fb fb fb fb fb fb fc fc fc fc fc
                               ^
 ffff8880456dfc80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff8880456dfd00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

---------------
thanks,
Kun Hu=

