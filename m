Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 884DB40A40A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Sep 2021 04:58:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237213AbhINDAG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 13 Sep 2021 23:00:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:59202 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238162AbhINDAA (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 13 Sep 2021 23:00:00 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9ADEA61108;
        Tue, 14 Sep 2021 02:58:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631588323;
        bh=WwLKONhLQD5yu3qOg6mO99EvFPpF5pg1KAphIgvFPOY=;
        h=Date:From:To:Subject:From;
        b=jf740rma9NXfbo6JQs1uGl05VxesMb8BECRSsq+wrW2GXkmJf6qvIbv/QyhbtRCup
         +/QN4frnt+BegLmND2vEZB0ONoOJxmBisc6jo7G/eWdEhgiDwuRr2droA9MsCa5WA9
         nPT86BHq1OOHKt9/gbnaXjq8JFwdhxieuIzBQFX7uBJKrK3YZMVlTFI98tRLO9VIu3
         xS9+eIFhZT4veKRI8pV8lOEdVMNvL+UKqSv+6CQGSDFQ84+pprOYXAK3BXFd0Fg85Z
         FxGDNkyzlDXjhLm8ItI4sbMV/dMRMryPVaPV4V+zAz3vSs8TL22/qb3P4NzOr5VW0H
         sloum5tdsZT3A==
Date:   Mon, 13 Sep 2021 19:58:43 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: kvm crash in 5.14.1?
Message-ID: <20210914025843.GA638460@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi everyone,

While running the XFS fuzz test suite (which launches ~50 VMs, which is
enough to eat nearly all the DRAM on the system) on a VM host that I'd
recently upgrade to 5.14.1, I noticed the following crash in dmesg on
the host:

BUG: kernel NULL pointer dereference, address: 0000000000000068
#PF: supervisor read access in kernel mode
#PF: error_code(0x0000) - not-present page
PGD 0 P4D 0 
Oops: 0000 [#1] PREEMPT SMP NOPTI
CPU: 6 PID: 4173897 Comm: CPU 3/KVM Tainted: G        W         5.14.1-67-server #67.3
RIP: 0010:internal_get_user_pages_fast+0x621/0x9d0
Code: f7 c2 00 00 01 00 0f 85 94 fb ff ff 48 8b 4c 24 18 48 8d bc 24 8c 00 00 00 8b b4 24 8c 00 00 00 e8 b4 cd ff ff e9 76 fb ff ff <48> 81 7a 68 80 08 04 bc 0f 85 21 ff ff 
8 89 c7 be
RSP: 0018:ffffaa90087679b0 EFLAGS: 00010046
RAX: ffffe3f37905b900 RBX: 00007f2dd561e000 RCX: ffffe3f37905b934
RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffffe3f37905b900
RBP: 00007f2dd561f000 R08: ffffe3f37905b900 R09: 000000049b4b6000
R10: ffffaa9008767b17 R11: 0000000000000000 R12: 8000000e416e4067
R13: ffff9dc39b4b60f0 R14: 000000ffffffffff R15: ffffe3f37905b900
FS:  00007f2e07fff700(0000) GS:ffff9dcf3f980000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000068 CR3: 00000004c5898003 CR4: 00000000001726e0
Call Trace:
 get_user_pages_fast_only+0x13/0x20
 hva_to_pfn+0xa9/0x3e0
 ? check_preempt_wakeup+0xec/0x230
 try_async_pf+0xa1/0x270
 ? try_to_wake_up+0x1f0/0x580
 ? generic_exec_single+0x50/0xa0
 direct_page_fault+0x113/0xad0
 kvm_mmu_page_fault+0x69/0x680
 ? __schedule+0x301/0x13f0
 ? enqueue_hrtimer+0x2f/0x80
 ? vmx_sync_pir_to_irr+0x73/0x100
 ? vmx_set_hv_timer+0x31/0x100
 vmx_handle_exit+0xe1/0x5d0
 kvm_arch_vcpu_ioctl_run+0xd81/0x1c70
 ? kvm_vcpu_ioctl+0xe8/0x670
 kvm_vcpu_ioctl+0x267/0x670
 ? kvm_on_user_return+0x7e/0x80
 ? fire_user_return_notifiers+0x38/0x50
 __x64_sys_ioctl+0x83/0xa0
 do_syscall_64+0x56/0x80
 ? do_syscall_64+0x63/0x80
 ? syscall_exit_to_user_mode+0x1d/0x40
 ? do_syscall_64+0x63/0x80
 ? do_syscall_64+0x63/0x80
 ? asm_exc_page_fault+0x5/0x20
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7f2e2018c50b
Code: 0f 1e fa 48 8b 05 85 39 0d 00 64 c7 00 26 00 00 00 48 c7 c0 ff ff ff ff c3 66 0f 1f 44 00 00 f3 0f 1e fa b8 10 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 55 39 0d 00 f7 d8 64 89 01 48
RSP: 002b:00007f2e07ffe5b8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 000000000000ae80 RCX: 00007f2e2018c50b
RDX: 0000000000000000 RSI: 000000000000ae80 RDI: 000000000000001e
RBP: 0000556cd92161e0 R08: 0000556cd823b1d0 R09: 00000000000000ff
R10: 0000000000000001 R11: 0000000000000246 R12: 0000000000000000
R13: 0000556cd88a8080 R14: 0000000000000001 R15: 0000000000000000
Modules linked in: vhost_net vhost vhost_iotlb tap nfsv4 nfs xt_REDIRECT md5 xt_CHECKSUM xt_MASQUERADE ip6table_mangle ip6table_nat iptable_mangle ebtable_filter ebtables tun iptable_nat nf_nat joydev af_packet bonding bridge stp llc ip_set_hash_ip ip_set_hash_net xt_set tcp_diag udp_diag raw_diag inet_diag ip_set_hash_mac ip_set nfnetlink binfmt_misc nls_iso8859_1 nls_cp437 vfat fat bfq ipmi_ssif intel_rapl_msr at24 regmap_i2c intel_rapl_common iosf_mbi wmi ipmi_si ipmi_devintf ipmi_msghandler sch_fq_codel ip6t_REJECT nf_reject_ipv6 xt_hl ip6t_rt ipt_REJECT nfsd nf_reject_ipv4 xt_comment xt_limit xt_addrtype xt_tcpudp auth_rpcgss xt_conntrack nf_conntrack nfs_acl lockd nf_defrag_ipv6 nf_defrag_ipv4 grace ip6table_filter ip6_tables sunrpc iptable_filter ip_tables x_tables uas usb_storage megaraid_sas
CR2: 0000000000000068
---[ end trace 09ba7735db5e61a6 ]---
RIP: 0010:internal_get_user_pages_fast+0x621/0x9d0
Code: f7 c2 00 00 01 00 0f 85 94 fb ff ff 48 8b 4c 24 18 48 8d bc 24 8c 00 00 00 8b b4 24 8c 00 00 00 e8 b4 cd ff ff e9 76 fb ff ff <48> 81 7a 68 80 08 04 bc 0f 85 21 ff ff ff 8b 54 24 68 48 89 c7 be
RSP: 0018:ffffaa90087679b0 EFLAGS: 00010046
RAX: ffffe3f37905b900 RBX: 00007f2dd561e000 RCX: ffffe3f37905b934
RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffffe3f37905b900
RBP: 00007f2dd561f000 R08: ffffe3f37905b900 R09: 000000049b4b6000
R10: ffffaa9008767b17 R11: 0000000000000000 R12: 8000000e416e4067
R13: ffff9dc39b4b60f0 R14: 000000ffffffffff R15: ffffe3f37905b900
FS:  00007f2e07fff700(0000) GS:ffff9dcf3f980000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000068 CR3: 00000004c5898003 CR4: 00000000001726e0

I also noticed that a number of the VMs seemed to be totally livelocked
on "memset_erms" and the only thing I could do was terminate them all.

I'll dig into this more tomorrow, but on the off chance this rings a
bell for anyone, is this a known error?

--Darrick
