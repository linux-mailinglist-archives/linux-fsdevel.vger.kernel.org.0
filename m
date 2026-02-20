Return-Path: <linux-fsdevel+bounces-77784-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gNnbLgg0mGn/CgMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77784-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Feb 2026 11:14:32 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C8F2166B74
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Feb 2026 11:14:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DF586302C349
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Feb 2026 10:14:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D2153382E4;
	Fri, 20 Feb 2026 10:14:23 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com [209.85.161.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF6812BCF4C
	for <linux-fsdevel@vger.kernel.org>; Fri, 20 Feb 2026 10:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771582463; cv=none; b=tgsdqUCKgJO3hPuHY00Y3dKe6VXmCgFLl1EsJOVh1fnueHUDjbOtXdEUGcJlZlvIKBdJ6ZDtHZxPviFO0DvihPp82WWifmFAtu1aXSrX0zS9Wle+sOfSrllCQ41Ha3Cyn2zuw6mXjGk2n3BsOa/t75xNrfxuE6nCkTkbLcyb320=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771582463; c=relaxed/simple;
	bh=gcsXTMo7iqO4Pg3sVMoOLMSk7eLVL7Ljh8aJq2IakFM=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=LNRvEY8x9Y6QOAzc3QByPel4GpL+a1h+e2B7Yeq4Nuqoz8578YZoV9fgIXFx4ptwYB5kGxNV2QN0BAIxlgUErDYPdEfXrXfOX9biV7u5Wapn4yc9T3pcohSEjL2wkDPWATJeVSZxUFhc5J9r/MO5CPd1Xk91WFUWxkDAsHHCsKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f71.google.com with SMTP id 006d021491bc7-679ae8ba9d8so29400693eaf.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 20 Feb 2026 02:14:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771582461; x=1772187261;
        h=cc:to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JMNiebd2whpNinmgx82cwNyRYJ5UqFJmTJ6XQA4gK7o=;
        b=F4QEV5deP6wTOsTVfmAqVeDAKS2265O5b2fDlCNf/6gF/U/6KCg2S22BMqqAIFluU1
         fPvNvBTQ1hhIO9vmZFIAbAbxpSmiVNhfmJwINDXMfXdIwmVwayrEJGDAMuRNtz5cxMJ8
         RSyZ3mFihPC3mU9Pn92B/z/FxcLimlNYtVGCkIdfbnlf/cUbR17Ysc8TVUyakTmoITt9
         E/OBRNregTaKw7hGcWCDBsI3NsQDR3Exsg/Xe0m7u1eq1EhLT8B2RpcG3oF1zrjC6bPF
         iPuAehxMiRoSvpmHZqGCY8eq3htYEk4GFjiULGeGLCCWQHbXpT2oOk+K+/asyDIeSBLC
         hPSQ==
X-Forwarded-Encrypted: i=1; AJvYcCUPwUQyQBXLl6+lWNeghN0LTbNUODxihpugszn6NZo5dpZMmbDHaoYgVqw/spnQKHnDTh/DcBzEp9ea2rvT@vger.kernel.org
X-Gm-Message-State: AOJu0YyRcZoM4NXreZdcZrKgmQSgTJtEnWJUloaRMQahCRucrGJ5StNE
	42nCcv7FjY0NrAbsnMylXutTd8MzrXv57O8xXXnRQJGRt/L+1F3Opf6EvAwHrzzPx/LTh74X1j3
	iyiOGYZulTUG9ZhY3Gwq3OB19nho6v7XLAfv9R0uZwYpsoe4Tq889SL6KsAQ=
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:2108:b0:66e:66b1:963f with SMTP id
 006d021491bc7-679aeec7538mr3091201eaf.18.1771582461010; Fri, 20 Feb 2026
 02:14:21 -0800 (PST)
Date: Fri, 20 Feb 2026 02:14:20 -0800
In-Reply-To: <20260220055449.3073-1-tjmercier@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <699833fc.050a0220.b01bb.0039.GAE@google.com>
Subject: [syzbot ci] Re: kernfs: Add inotify IN_DELETE_SELF, IN_IGNORED support
From: syzbot ci <syzbot+cif2121bcf05a8d84e@syzkaller.appspotmail.com>
To: amir73il@gmail.com, cgroups@vger.kernel.org, driver-core@lists.linux.dev, 
	gregkh@linuxfoundation.org, jack@suse.cz, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	shuah@kernel.org, tj@kernel.org, tjmercier@google.com
Cc: syzbot@lists.linux.dev, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[appspotmail.com : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-77784-lists,linux-fsdevel=lfdr.de,cif2121bcf05a8d84e];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org,lists.linux.dev,linuxfoundation.org,suse.cz,kernel.org,google.com];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[syzbot@syzkaller.appspotmail.com,linux-fsdevel@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_NONE(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.923];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,googlesource.com:url,appspotmail.com:email]
X-Rspamd-Queue-Id: 7C8F2166B74
X-Rspamd-Action: no action

syzbot ci has tested the following series

[v4] kernfs: Add inotify IN_DELETE_SELF, IN_IGNORED support
https://lore.kernel.org/all/20260220055449.3073-1-tjmercier@google.com
* [PATCH v4 1/3] kernfs: Don't set_nlink for directories being removed
* [PATCH v4 2/3] kernfs: Send IN_DELETE_SELF and IN_IGNORED
* [PATCH v4 3/3] selftests: memcg: Add tests for IN_DELETE_SELF and IN_IGNORED

and found the following issue:
possible deadlock in __kernfs_remove

Full report is available here:
https://ci.syzbot.org/series/4b44d5c2-c2eb-4425-a19a-f9963b64f74f

***

possible deadlock in __kernfs_remove

tree:      bpf-next
URL:       https://kernel.googlesource.com/pub/scm/linux/kernel/git/bpf/bpf-next.git
base:      ba268514ea14b44570030e8ed2aef92a38679e85
arch:      amd64
compiler:  Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8
config:    https://ci.syzbot.org/builds/45ab774f-e8d7-4def-8279-888a5cb2d01e/config
syz repro: https://ci.syzbot.org/findings/b74cbc6a-1cef-4ae9-be46-dd9e8b29b648/syz_repro

======================================================
WARNING: possible circular locking dependency detected
syzkaller #0 Not tainted
------------------------------------------------------
kworker/u8:1/13 is trying to acquire lock:
ffff88816ef2b878 (kn->active#5){++++}-{0:0}, at: __kernfs_remove+0x47e/0x8c0 fs/kernfs/dir.c:1533

but task is already holding lock:
ffff8881012e8ab8 (&root->kernfs_supers_rwsem){++++}-{4:4}, at: kernfs_remove_by_name_ns+0x3f/0x140 fs/kernfs/dir.c:1745

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #2 (&root->kernfs_supers_rwsem){++++}-{4:4}:
       down_read+0x47/0x2e0 kernel/locking/rwsem.c:1537
       kernfs_remove_by_name_ns+0x3f/0x140 fs/kernfs/dir.c:1745
       acpi_unbind_one+0x2d8/0x3b0 drivers/acpi/glue.c:337
       device_platform_notify_remove drivers/base/core.c:2386 [inline]
       device_del+0x547/0x8f0 drivers/base/core.c:3881
       serdev_controller_add+0x46f/0x640 drivers/tty/serdev/core.c:785
       serdev_tty_port_register+0x159/0x260 drivers/tty/serdev/serdev-ttyport.c:291
       tty_port_register_device_attr_serdev+0xe7/0x170 drivers/tty/tty_port.c:187
       serial_core_add_one_port drivers/tty/serial/serial_core.c:3107 [inline]
       serial_core_register_port+0x103a/0x28b0 drivers/tty/serial/serial_core.c:3305
       serial8250_register_8250_port+0x1658/0x1fd0 drivers/tty/serial/8250/8250_core.c:822
       serial_pnp_probe+0x568/0x7f0 drivers/tty/serial/8250/8250_pnp.c:480
       pnp_device_probe+0x30b/0x4c0 drivers/pnp/driver.c:111
       call_driver_probe drivers/base/dd.c:-1 [inline]
       really_probe+0x267/0xaf0 drivers/base/dd.c:661
       __driver_probe_device+0x18c/0x320 drivers/base/dd.c:803
       driver_probe_device+0x4f/0x240 drivers/base/dd.c:833
       __driver_attach+0x3e7/0x710 drivers/base/dd.c:1227
       bus_for_each_dev+0x23b/0x2c0 drivers/base/bus.c:383
       bus_add_driver+0x345/0x670 drivers/base/bus.c:715
       driver_register+0x23a/0x320 drivers/base/driver.c:249
       serial8250_init+0x8f/0x160 drivers/tty/serial/8250/8250_platform.c:317
       do_one_initcall+0x250/0x840 init/main.c:1378
       do_initcall_level+0x104/0x190 init/main.c:1440
       do_initcalls+0x59/0xa0 init/main.c:1456
       kernel_init_freeable+0x2a6/0x3d0 init/main.c:1688
       kernel_init+0x1d/0x1d0 init/main.c:1578
       ret_from_fork+0x51b/0xa40 arch/x86/kernel/process.c:158
       ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:246

-> #1 (&device->physical_node_lock){+.+.}-{4:4}:
       __mutex_lock_common kernel/locking/mutex.c:614 [inline]
       __mutex_lock+0x19f/0x1300 kernel/locking/mutex.c:776
       acpi_get_first_physical_node drivers/acpi/bus.c:691 [inline]
       acpi_primary_dev_companion drivers/acpi/bus.c:710 [inline]
       acpi_companion_match+0x8a/0x120 drivers/acpi/bus.c:764
       acpi_device_uevent_modalias+0x1a/0x30 drivers/acpi/device_sysfs.c:280
       platform_uevent+0x3c/0xb0 drivers/base/platform.c:1411
       dev_uevent+0x446/0x8a0 drivers/base/core.c:2692
       kobject_uevent_env+0x477/0x9e0 lib/kobject_uevent.c:573
       kobject_synth_uevent+0x585/0xbd0 lib/kobject_uevent.c:207
       uevent_store+0x26/0x70 drivers/base/core.c:2773
       kernfs_fop_write_iter+0x3af/0x540 fs/kernfs/file.c:352
       new_sync_write fs/read_write.c:593 [inline]
       vfs_write+0x61d/0xb90 fs/read_write.c:686
       ksys_write+0x150/0x270 fs/read_write.c:738
       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
       do_syscall_64+0xe2/0xf80 arch/x86/entry/syscall_64.c:94
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #0 (kn->active#5){++++}-{0:0}:
       check_prev_add kernel/locking/lockdep.c:3165 [inline]
       check_prevs_add kernel/locking/lockdep.c:3284 [inline]
       validate_chain kernel/locking/lockdep.c:3908 [inline]
       __lock_acquire+0x15a5/0x2cf0 kernel/locking/lockdep.c:5237
       lock_acquire+0x106/0x330 kernel/locking/lockdep.c:5868
       kernfs_drain+0x27c/0x5f0 fs/kernfs/dir.c:511
       __kernfs_remove+0x47e/0x8c0 fs/kernfs/dir.c:1533
       kernfs_remove_by_name_ns+0xc0/0x140 fs/kernfs/dir.c:1751
       sysfs_remove_file include/linux/sysfs.h:780 [inline]
       device_remove_file drivers/base/core.c:3071 [inline]
       device_del+0x506/0x8f0 drivers/base/core.c:3876
       device_unregister+0x21/0xf0 drivers/base/core.c:3919
       mac80211_hwsim_del_radio+0x2dc/0x490 drivers/net/wireless/virtual/mac80211_hwsim.c:5918
       hwsim_exit_net+0xede/0xfa0 drivers/net/wireless/virtual/mac80211_hwsim.c:6807
       ops_exit_list net/core/net_namespace.c:199 [inline]
       ops_undo_list+0x49f/0x940 net/core/net_namespace.c:252
       cleanup_net+0x4df/0x7b0 net/core/net_namespace.c:696
       process_one_work kernel/workqueue.c:3257 [inline]
       process_scheduled_works+0xaec/0x17a0 kernel/workqueue.c:3340
       worker_thread+0xda6/0x1360 kernel/workqueue.c:3421
       kthread+0x726/0x8b0 kernel/kthread.c:463
       ret_from_fork+0x51b/0xa40 arch/x86/kernel/process.c:158
       ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:246

other info that might help us debug this:

Chain exists of:
  kn->active#5 --> &device->physical_node_lock --> &root->kernfs_supers_rwsem

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  rlock(&root->kernfs_supers_rwsem);
                               lock(&device->physical_node_lock);
                               lock(&root->kernfs_supers_rwsem);
  lock(kn->active#5);

 *** DEADLOCK ***

4 locks held by kworker/u8:1/13:
 #0: ffff888100ef7948 ((wq_completion)netns){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3232 [inline]
 #0: ffff888100ef7948 ((wq_completion)netns){+.+.}-{0:0}, at: process_scheduled_works+0x9d4/0x17a0 kernel/workqueue.c:3340
 #1: ffffc90000127bc0 (net_cleanup_work){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3233 [inline]
 #1: ffffc90000127bc0 (net_cleanup_work){+.+.}-{0:0}, at: process_scheduled_works+0xa0f/0x17a0 kernel/workqueue.c:3340
 #2: ffffffff8f99d2d0 (pernet_ops_rwsem){++++}-{4:4}, at: cleanup_net+0xfe/0x7b0 net/core/net_namespace.c:670
 #3: ffff8881012e8ab8 (&root->kernfs_supers_rwsem){++++}-{4:4}, at: kernfs_remove_by_name_ns+0x3f/0x140 fs/kernfs/dir.c:1745

stack backtrace:
CPU: 0 UID: 0 PID: 13 Comm: kworker/u8:1 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
Workqueue: netns cleanup_net
Call Trace:
 <TASK>
 dump_stack_lvl+0xe8/0x150 lib/dump_stack.c:120
 print_circular_bug+0x2e1/0x300 kernel/locking/lockdep.c:2043
 check_noncircular+0x12e/0x150 kernel/locking/lockdep.c:2175
 check_prev_add kernel/locking/lockdep.c:3165 [inline]
 check_prevs_add kernel/locking/lockdep.c:3284 [inline]
 validate_chain kernel/locking/lockdep.c:3908 [inline]
 __lock_acquire+0x15a5/0x2cf0 kernel/locking/lockdep.c:5237
 lock_acquire+0x106/0x330 kernel/locking/lockdep.c:5868
 kernfs_drain+0x27c/0x5f0 fs/kernfs/dir.c:511
 __kernfs_remove+0x47e/0x8c0 fs/kernfs/dir.c:1533
 kernfs_remove_by_name_ns+0xc0/0x140 fs/kernfs/dir.c:1751
 sysfs_remove_file include/linux/sysfs.h:780 [inline]
 device_remove_file drivers/base/core.c:3071 [inline]
 device_del+0x506/0x8f0 drivers/base/core.c:3876
 device_unregister+0x21/0xf0 drivers/base/core.c:3919
 mac80211_hwsim_del_radio+0x2dc/0x490 drivers/net/wireless/virtual/mac80211_hwsim.c:5918
 hwsim_exit_net+0xede/0xfa0 drivers/net/wireless/virtual/mac80211_hwsim.c:6807
 ops_exit_list net/core/net_namespace.c:199 [inline]
 ops_undo_list+0x49f/0x940 net/core/net_namespace.c:252
 cleanup_net+0x4df/0x7b0 net/core/net_namespace.c:696
 process_one_work kernel/workqueue.c:3257 [inline]
 process_scheduled_works+0xaec/0x17a0 kernel/workqueue.c:3340
 worker_thread+0xda6/0x1360 kernel/workqueue.c:3421
 kthread+0x726/0x8b0 kernel/kthread.c:463
 ret_from_fork+0x51b/0xa40 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:246
 </TASK>
hsr_slave_0: left promiscuous mode
hsr_slave_1: left promiscuous mode
batman_adv: batadv0: Interface deactivated: batadv_slave_0
batman_adv: batadv0: Removing interface: batadv_slave_0
batman_adv: batadv0: Interface deactivated: batadv_slave_1
batman_adv: batadv0: Removing interface: batadv_slave_1
veth1_macvtap: left promiscuous mode
veth0_macvtap: left promiscuous mode
veth1_vlan: left promiscuous mode
veth0_vlan: left promiscuous mode
team0 (unregistering): Port device team_slave_1 removed
team0 (unregistering): Port device team_slave_0 removed
netdevsim netdevsim2 netdevsim0: set [1, 0] type 2 family 0 port 6081 - 0
netdevsim netdevsim2 netdevsim1: set [1, 0] type 2 family 0 port 6081 - 0
netdevsim netdevsim2 netdevsim2: set [1, 0] type 2 family 0 port 6081 - 0
netdevsim netdevsim2 netdevsim3: set [1, 0] type 2 family 0 port 6081 - 0


***

If these findings have caused you to resend the series or submit a
separate fix, please add the following tag to your commit message:
  Tested-by: syzbot@syzkaller.appspotmail.com

---
This report is generated by a bot. It may contain errors.
syzbot ci engineers can be reached at syzkaller@googlegroups.com.

