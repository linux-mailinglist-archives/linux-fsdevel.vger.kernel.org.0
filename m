Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5439D23E784
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Aug 2020 09:03:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726198AbgHGHDf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 7 Aug 2020 03:03:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725805AbgHGHDd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 7 Aug 2020 03:03:33 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35ED6C061574;
        Fri,  7 Aug 2020 00:03:32 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id g19so644779plq.0;
        Fri, 07 Aug 2020 00:03:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :in-reply-to;
        bh=cXiFY40k3YE3h5GKxLLu7Lb8Z/u2Pasapw1Qrti5SeE=;
        b=X6fzQY++CFlxidAbfDEoYwyNQPvjwSGUESo4p2YC1IKHcFg7zpA2t7N9Vb87Y42fKi
         DUaNkHibnMqukp7+NPMT/rpER1zd/81jp3zk6l9Kgmd65OD+kFgb3W09WZ21KMdpgFms
         JSrDF6WOdZoz+7E228lncn2P6O7DeQZsdC0BzDWXHjfu9BWP+EJnLa9jQy/IkD0ZizDg
         vFg+48Y7V4JvEQVF01oVfLaPyX5cMtBZxpb7NtZdQyQ0SKe28evlEweXLACRL5dvhy/k
         g68uGYVXVT1cPJ2vF5tvugJ9wxC2HSe66353jwffcRVjpT3q2pHFTpDBv58ncc0+Jj58
         MDhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:in-reply-to;
        bh=cXiFY40k3YE3h5GKxLLu7Lb8Z/u2Pasapw1Qrti5SeE=;
        b=h9IpzftF8HRqmeqb9uoQlspCKbXDlRb/EOw01Jfy2k6fRZ17gb4urczDnNMPds+INR
         KBaJ/Le5ePvluvnFDWyDzbVJsuTq25YZxEPKhxqHbjnVmrN7OUpvXze+VwmJYlSdFCNm
         /NtRTfczXxbwSDUH8jKjb4ayMsJGS8W+wm0ozu7JWhRzKAcek7Z593V8gNro6JdVIU8n
         oDhpN2IC3JT1EVmuwTx5GEAC1fGXtmH+toPuEcVSx7u0oDZLFfan7E4YQA3rcm+Qyf+q
         wGQ01yEupDJmWuJp6tVLBZGtM80ZNugxC1kIOYlAoDi5nwph1xG6l4O3oIlFEg3s9QyJ
         Gx8g==
X-Gm-Message-State: AOAM531VxWrcLDwga5RT3DwhpIw1j7jh83wSUMq65ZFuu3MjrkdMH9Kk
        BhCgQCLylXn52qkLufx9CkjcPXxC+ww=
X-Google-Smtp-Source: ABdhPJwERHoyeYBSjOxRiDHETwlDme8Ekxn6cWsbmS65/Py/JR56kSzaY5kLJCW9JzCEyCKwhmIQMg==
X-Received: by 2002:a17:902:bc49:: with SMTP id t9mr11269864plz.20.1596783811704;
        Fri, 07 Aug 2020 00:03:31 -0700 (PDT)
Received: from thinkpad (104.36.148.139.aurocloud.com. [104.36.148.139])
        by smtp.gmail.com with ESMTPSA id e15sm6897268pfj.167.2020.08.07.00.03.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2020 00:03:31 -0700 (PDT)
Date:   Fri, 7 Aug 2020 00:04:00 -0700
From:   Rustam Kovhaev <rkovhaev@gmail.com>
To:     kvm@vger.kernel.org, ebiggers@kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Subject: Re: memory leak in do_eventfd
Message-ID: <20200807070400.GA10331@thinkpad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200605042402.GO2667@sol.localdomain>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jun 04, 2020 at 09:24:02PM -0700, Eric Biggers wrote:
> [+Cc kvm mailing list]
> 
> On Wed, May 20, 2020 at 06:12:17PM -0700, syzbot wrote:
> > Hello,
> > 
> > syzbot found the following crash on:
> > 
> > HEAD commit:    5a9ffb95 Merge tag '5.7-rc5-smb3-fixes' of git://git.samba..
> > git tree:       upstream
> > console output: https://syzkaller.appspot.com/x/log.txt?x=10b72a02100000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=f8295ae5b3f8268d
> > dashboard link: https://syzkaller.appspot.com/bug?extid=f196caa45793d6374707
> > compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17585b76100000
> > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12500a02100000
> > 
> > IMPORTANT: if you fix the bug, please add the following tag to the commit:
> > Reported-by: syzbot+f196caa45793d6374707@syzkaller.appspotmail.com
> > 
> > BUG: memory leak
> > unreferenced object 0xffff888117169ac0 (size 64):
> >   comm "syz-executor012", pid 6609, jiffies 4294942172 (age 13.720s)
> >   hex dump (first 32 bytes):
> >     01 00 00 00 ff ff ff ff 00 00 00 00 00 c9 ff ff  ................
> >     d0 9a 16 17 81 88 ff ff d0 9a 16 17 81 88 ff ff  ................
> >   backtrace:
> >     [<00000000351bb234>] kmalloc include/linux/slab.h:555 [inline]
> >     [<00000000351bb234>] do_eventfd+0x35/0xf0 fs/eventfd.c:418
> >     [<00000000c2f69a77>] __do_sys_eventfd fs/eventfd.c:443 [inline]
> >     [<00000000c2f69a77>] __se_sys_eventfd fs/eventfd.c:441 [inline]
> >     [<00000000c2f69a77>] __x64_sys_eventfd+0x14/0x20 fs/eventfd.c:441
> >     [<0000000086d6f989>] do_syscall_64+0x6e/0x220 arch/x86/entry/common.c:295
> >     [<000000006c5bcb63>] entry_SYSCALL_64_after_hwframe+0x44/0xa9
> > 
> > BUG: memory leak
> > unreferenced object 0xffff888117169100 (size 64):
> >   comm "syz-executor012", pid 6609, jiffies 4294942172 (age 13.720s)
> >   hex dump (first 32 bytes):
> >     e8 99 dd 00 00 c9 ff ff e8 99 dd 00 00 c9 ff ff  ................
> >     00 00 00 20 00 00 00 00 00 00 00 00 00 00 00 00  ... ............
> >   backtrace:
> >     [<00000000436d2955>] kmalloc include/linux/slab.h:555 [inline]
> >     [<00000000436d2955>] kzalloc include/linux/slab.h:669 [inline]
> >     [<00000000436d2955>] kvm_assign_ioeventfd_idx+0x4f/0x270 arch/x86/kvm/../../../virt/kvm/eventfd.c:798
> >     [<00000000e89390cc>] kvm_assign_ioeventfd arch/x86/kvm/../../../virt/kvm/eventfd.c:934 [inline]
> >     [<00000000e89390cc>] kvm_ioeventfd+0xbb/0x194 arch/x86/kvm/../../../virt/kvm/eventfd.c:961
> >     [<00000000ba9f6732>] kvm_vm_ioctl+0x1e6/0x1030 arch/x86/kvm/../../../virt/kvm/kvm_main.c:3670
> >     [<000000005da94937>] vfs_ioctl fs/ioctl.c:47 [inline]
> >     [<000000005da94937>] ksys_ioctl+0xa6/0xd0 fs/ioctl.c:771
> >     [<00000000a583d097>] __do_sys_ioctl fs/ioctl.c:780 [inline]
> >     [<00000000a583d097>] __se_sys_ioctl fs/ioctl.c:778 [inline]
> >     [<00000000a583d097>] __x64_sys_ioctl+0x1a/0x20 fs/ioctl.c:778
> >     [<0000000086d6f989>] do_syscall_64+0x6e/0x220 arch/x86/entry/common.c:295
> >     [<000000006c5bcb63>] entry_SYSCALL_64_after_hwframe+0x44/0xa9
> > 

i had to slightly change syzbot reproducer to reproduce this bug in my
lab:
	root@syzkaller:~# diff repro_fixed.c repro_syz.c
	371c371
	<   inject_fault(2);
	---
	>   inject_fault(4);

the memleak happens when kmalloc() fails in kvm_io_bus_unregister_dev()
i also confirmed the leak by running ftrace - eventfd_free_ctx() was
not executed when we got to kvm_vm_release()

it seems like we should call kvm_iodevice_destructor(), because there
could be other devices linked to the bus that's being removed when that
particular kmalloc() failure happens

i did not want to modify callers of kvm_io_bus_unregister_dev() and i
tested the patch below that fixed the leak, but i am not sure if it
completely breaks other things in KVM, i would really appreciate if
someone can review it:

diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 0a68c9d3d3ab..b1996989d576 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -4268,7 +4268,7 @@ int kvm_io_bus_register_dev(struct kvm *kvm, enum kvm_bus bus_idx, gpa_t addr,
 void kvm_io_bus_unregister_dev(struct kvm *kvm, enum kvm_bus bus_idx,
 			       struct kvm_io_device *dev)
 {
-	int i;
+	int i, j;
 	struct kvm_io_bus *new_bus, *bus;
 
 	bus = kvm_get_bus(kvm, bus_idx);
@@ -4298,6 +4298,13 @@ void kvm_io_bus_unregister_dev(struct kvm *kvm, enum kvm_bus bus_idx,
 broken:
 	rcu_assign_pointer(kvm->buses[bus_idx], new_bus);
 	synchronize_srcu_expedited(&kvm->srcu);
+	if (!new_bus) {
+		for (j = 0; j < bus->dev_count; j++) {
+			if (j == i)
+				continue;
+			kvm_iodevice_destructor(bus->range[j].dev);
+		}
+	}
 	kfree(bus);
 	return;
 }

