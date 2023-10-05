Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B8377B9E60
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Oct 2023 16:06:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231423AbjJEOFw convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>); Thu, 5 Oct 2023 10:05:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231765AbjJEOEH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 5 Oct 2023 10:04:07 -0400
Received: from mail-oa1-x47.google.com (mail-oa1-x47.google.com [IPv6:2001:4860:4864:20::47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B86F1F753
        for <linux-fsdevel@vger.kernel.org>; Thu,  5 Oct 2023 02:59:35 -0700 (PDT)
Received: by mail-oa1-x47.google.com with SMTP id 586e51a60fabf-187959a901eso990812fac.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 05 Oct 2023 02:59:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696499970; x=1697104770;
        h=content-transfer-encoding:to:from:subject:message-id:in-reply-to
         :date:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OUidpdIlBCHQOAT8hc6EhjF1qs8gR/l4JBM25yUma+A=;
        b=vj9WdK3/X7r6YJI49XAAMuViieuip5YL3kEYmBwEgDX/9d9Ngf4B2baC4b8d2IWBT+
         yi1cOYKI97bLLME8/ZydcSWjzkAON1ShYoGAxzz13MI69Fn+5bhRtxDU25AG5Yir/5sN
         T0mi1wZ8A56dCC2lK23F5DzjjW71yUqaDjyOHRcwL1FpwUy3YYb49xybrnE2Bde2sYF/
         rDnQMTYrnZLkJSI7nD4JD+P3WTwo/imz6j1wzxPA+PbuH657CTiy9UsweL7t+WC+wge8
         BpJ6sqkuf69WI/AWLjtgCx8VyAQdWx9AyTQQlJM039IkDCZDzaiO0SEUgnlLW+rzlVno
         zDKQ==
X-Gm-Message-State: AOJu0Yy3UsVExOynkKjP11/7y+n4uEAoZRABOw4VMTZ3Pe13LiSLJvDf
        mTrBUYqNkV9CjnAQPIt7+fTNV/lDnaCrBZAEZNkRegKHeZj5
X-Google-Smtp-Source: AGHT+IGTroKHuY0zHyu8X3nMiXGnuNGMZmtK2noF4INH/S1nULtywBtdw/og0+CfDsZSKQKdbwVROfu9WlV6VLhh8y0mIMLSXBh3
MIME-Version: 1.0
X-Received: by 2002:a05:6870:b796:b0:1d5:8e96:7d85 with SMTP id
 ed22-20020a056870b79600b001d58e967d85mr1845337oab.1.1696499969849; Thu, 05
 Oct 2023 02:59:29 -0700 (PDT)
Date:   Thu, 05 Oct 2023 02:59:29 -0700
In-Reply-To: <CAOQ4uxhbNyDzf0_fFh1Yy5Kz2Coz=gTrfOtsmteE0=ncibBnpw@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000001081fc0606f52ed9@google.com>
Subject: Re: [syzbot] [integrity] [overlayfs] possible deadlock in
 mnt_want_write (2)
From:   syzbot <syzbot+b42fe626038981fb7bfa@syzkaller.appspotmail.com>
To:     amir73il@gmail.com, hdanton@sina.com,
        linux-fsdevel@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-unionfs@vger.kernel.org, miklos@szeredi.hu,
        mszeredi@redhat.com, syzbot@syzkalhler.appspotmail.com,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk,
        zohar@linux.ibm.com, zohar@us.ibm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SORTED_RECIPS,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

.11
[   11.711476][    T1] Bluetooth: BNEP (Ethernet Emulation) ver 1.3
[   11.717652][    T1] Bluetooth: BNEP filters: protocol multicast
[   11.723764][    T1] Bluetooth: BNEP socket layer initialized
[   11.729798][    T1] Bluetooth: CMTP (CAPI Emulation) ver 1.0
[   11.735800][    T1] Bluetooth: CMTP socket layer initialized
[   11.741657][    T1] Bluetooth: HIDP (Human Interface Emulation) ver 1.2
[   11.748518][    T1] Bluetooth: HIDP socket layer initialized
[   11.758808][    T1] NET: Registered PF_RXRPC protocol family
[   11.764714][    T1] Key type rxrpc registered
[   11.769426][    T1] Key type rxrpc_s registered
[   11.774975][    T1] NET: Registered PF_KCM protocol family
[   11.781399][    T1] lec:lane_module_init: lec.c: initialized
[   11.787210][    T1] mpoa:atm_mpoa_init: mpc.c: initialized
[   11.793325][    T1] l2tp_core: L2TP core driver, V2.0
[   11.798593][    T1] l2tp_ppp: PPPoL2TP kernel driver, V2.0
[   11.804282][    T1] l2tp_ip: L2TP IP encapsulation support (L2TPv3)
[   11.810911][    T1] l2tp_netlink: L2TP netlink interface
[   11.816532][    T1] l2tp_eth: L2TP ethernet pseudowire support (L2TPv3)
[   11.823862][    T1] l2tp_ip6: L2TP IP encapsulation support for IPv6 (L2TPv3)
[   11.831528][    T1] NET: Registered PF_PHONET protocol family
[   11.837777][    T1] 8021q: 802.1Q VLAN Support v1.8
[   11.855888][    T1] DCCP: Activated CCID 2 (TCP-like)
[   11.861493][    T1] DCCP: Activated CCID 3 (TCP-Friendly Rate Control)
[   11.868489][    T1] DCCP is deprecated and scheduled to be removed in 2025, please contact the netdev mailing list
[   11.879600][    T1] sctp: Hash tables configured (bind 32/56)
[   11.886970][    T1] NET: Registered PF_RDS protocol family
[   11.893414][    T1] Registered RDS/infiniband transport
[   11.900057][    T1] Registered RDS/tcp transport
[   11.904815][    T1] tipc: Activated (version 2.0.0)
[   11.910959][    T1] NET: Registered PF_TIPC protocol family
[   11.917541][    T1] tipc: Started in single node mode
[   11.923606][    T1] NET: Registered PF_SMC protocol family
[   11.929592][    T1] 9pnet: Installing 9P2000 support
[   11.935356][    T1] NET: Registered PF_CAIF protocol family
[   11.948223][    T1] NET: Registered PF_IEEE802154 protocol family
[   11.954672][    T1] Key type dns_resolver registered
[   11.959869][    T1] Key type ceph registered
[   11.964886][    T1] libceph: loaded (mon/osd proto 15/24)
[   11.971970][    T1] batman_adv: B.A.T.M.A.N. advanced 2023.3 (compatibility version 15) loaded
[   11.981263][    T1] openvswitch: Open vSwitch switching datapath
[   11.991164][    T1] NET: Registered PF_VSOCK protocol family
[   11.997270][    T1] mpls_gso: MPLS GSO support
[   12.019850][    T1] IPI shorthand broadcast: enabled
[   12.025183][    T1] AVX2 version of gcm_enc/dec engaged.
[   12.031096][    T1] AES CTR mode by8 optimization enabled
[   13.986311][    T1] sched_clock: Marking stable (13940030159, 37368238)->(13987518566, -10120169)
[   14.000622][    T1] registered taskstats version 1
[   14.020069][    T1] Loading compiled-in X.509 certificates
[   14.031543][    T1] Loaded X.509 cert 'Build time autogenerated kernel key: 2d553f2396bceba4be328de3fad0b481a51ca3cf'
[   14.045807][    T1] zswap: loaded using pool lzo/zbud
[   14.257081][    T1] debug_vm_pgtable: [debug_vm_pgtable         ]: Validating architecture page table helpers
[   16.606589][    T1] Key type .fscrypt registered
[   16.611425][    T1] Key type fscrypt-provisioning registered
[   16.624007][    T1] kAFS: Red Hat AFS client v0.1 registering.
[   16.646715][    T1] Btrfs loaded, assert=on, ref-verify=on, zoned=yes, fsverity=yes
[   16.656542][    T1] Key type big_key registered
[   16.664108][    T1] Key type encrypted registered
[   16.669211][    T1] ima: No TPM chip found, activating TPM-bypass!
[   16.675572][    T1] Loading compiled-in module X.509 certificates
[   16.684589][    T1] Loaded X.509 cert 'Build time autogenerated kernel key: 2d553f2396bceba4be328de3fad0b481a51ca3cf'
[   16.695647][    T1] ima: Allocated hash algorithm: sha256
[   16.701654][    T1] ima: No architecture policies found
[   16.707848][    T1] evm: Initialising EVM extended attributes:
[   16.714189][    T1] evm: security.selinux (disabled)
[   16.719369][    T1] evm: security.SMACK64
[   16.723503][    T1] evm: security.SMACK64EXEC
[   16.728365][    T1] evm: security.SMACK64TRANSMUTE
[   16.733278][    T1] evm: security.SMACK64MMAP
[   16.737801][    T1] evm: security.apparmor (disabled)
[   16.742978][    T1] evm: security.ima
[   16.746763][    T1] evm: security.capability
[   16.751272][    T1] evm: HMAC attrs: 0x1
[   16.757582][    T1] PM:   Magic number: 11:141:828
[   16.762692][    T1] video4linux v4l-touch6: hash matches
[   16.768621][    T1] tty ptyt8: hash matches
[   16.772947][    T1] tty ptyqb: hash matches
[   16.779976][    T1] printk: console [netcon0] enabled
[   16.785201][    T1] netconsole: network logging started
[   16.791177][    T1] gtp: GTP module loaded (pdp ctx size 104 bytes)
[   16.799026][    T1] rdma_rxe: loaded
[   16.803522][    T1] cfg80211: Loading compiled-in X.509 certificates for regulatory database
[   16.814312][    T1] Loaded X.509 cert 'sforshee: 00b28ddf47aef9cea7'
[   16.821808][    T1] clk: Disabling unused clocks
[   16.822972][ T2520] platform regulatory.0: Direct firmware load for regulatory.db failed with error -2
[   16.826718][    T1] ALSA device list:
[   16.836181][ T2520] platform regulatory.0: Falling back to sysfs fallback for: regulatory.db
[   16.849196][    T1]   #0: Dummy 1
[   16.852687][    T1]   #1: Loopback 1
[   16.856406][    T1]   #2: Virtual MIDI Card 1
[   16.864429][    T1] md: Waiting for all devices to be available before autodetect
[   16.872287][    T1] md: If you don't use raid, use raid=noautodetect
[   16.878935][    T1] md: Autodetecting RAID arrays.
[   16.883975][    T1] md: autorun ...
[   16.887676][    T1] md: ... autorun DONE.
[   16.961157][    T1] EXT4-fs (sda1): mounted filesystem 5941fea2-f5fa-4b4e-b5ef-9af118b27b95 ro with ordered data mode. Quota mode: none.
[   16.973957][    T1] VFS: Mounted root (ext4 filesystem) readonly on device 8:1.
[   17.007193][    T1] devtmpfs: mounted
[   17.026225][    T1] Freeing unused kernel image (initmem) memory: 2884K
[   17.033318][    T1] Write protecting the kernel read-only data: 196608k
[   17.044849][    T1] Freeing unused kernel image (rodata/data gap) memory: 1780K
[   17.152701][    T1] x86/mm: Checked W+X mappings: passed, no W+X pages found.
[   17.165765][    T1] Failed to set sysctl parameter 'max_rcu_stall_to_panic=1': parameter not found
[   17.175611][    T1] Run /sbin/init as init process
[   17.221897][    T1] ------------[ cut here ]------------
[   17.227549][    T1] WARNING: CPU: 1 PID: 1 at security/integrity/iint.c:85 integrity_inode_get+0x499/0x580
[   17.237529][    T1] Modules linked in:
[   17.241431][    T1] CPU: 1 PID: 1 Comm: swapper/0 Not tainted 6.6.0-rc4-syzkaller-00001-g79be50b1a644 #0
[   17.251093][    T1] Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/06/2023
[   17.261192][    T1] RIP: 0010:integrity_inode_get+0x499/0x580
[   17.267086][    T1] Code: eb 11 e8 ba 30 8c fd 48 c7 c7 60 e4 92 8d e8 be 1e d6 06 4c 89 e0 48 83 c4 18 5b 41 5c 41 5d 41 5e 41 5f 5d c3 e8 97 30 8c fd <0f> 0b 31 db e9 b0 fd ff ff 44 89 e9 80 e1 07 80 c1 03 38 c1 0f 8c
[   17.287095][    T1] RSP: 0000:ffffc900000678f0 EFLAGS: 00010293
[   17.293214][    T1] RAX: ffffffff8401db19 RBX: 00000000ffffffff RCX: ffff888015e58000
[   17.301239][    T1] RDX: 0000000000000000 RSI: 00000000ffffffff RDI: 0000000000000001
[   17.309277][    T1] RBP: ffff88801db8aad8 R08: ffffffff8401d8c4 R09: 0000000000000000
[   17.317271][    T1] R10: ffff88802871d088 R11: ffffed10050e3a13 R12: ffff88802871d000
[   17.325268][    T1] R13: ffff88802871d0d0 R14: dffffc0000000000 R15: ffff88801db8aab0
[   17.333277][    T1] FS:  0000000000000000(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
[   17.342239][    T1] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   17.348852][    T1] CR2: 0000000000000000 CR3: 000000000d130000 CR4: 00000000003506e0
[   17.356912][    T1] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[   17.364907][    T1] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[   17.372924][    T1] Call Trace:
[   17.376200][    T1]  <TASK>
[   17.379331][    T1]  ? __warn+0x162/0x4a0
[   17.383486][    T1]  ? integrity_inode_get+0x499/0x580
[   17.388813][    T1]  ? report_bug+0x2b3/0x500
[   17.393312][    T1]  ? integrity_inode_get+0x499/0x580
[   17.398712][    T1]  ? handle_bug+0x3d/0x70
[   17.403043][    T1]  ? exc_invalid_op+0x1a/0x50
[   17.407747][    T1]  ? asm_exc_invalid_op+0x1a/0x20
[   17.412768][    T1]  ? integrity_inode_get+0x244/0x580
[   17.418159][    T1]  ? integrity_inode_get+0x499/0x580
[   17.423885][    T1]  ? integrity_inode_get+0x499/0x580
[   17.429210][    T1]  process_measurement+0x44d/0x1cf0
[   17.434430][    T1]  ? ima_file_mmap+0x2b0/0x2b0
[   17.439238][    T1]  ? lockdep_hardirqs_on_prepare+0x43c/0x7a0
[   17.445312][    T1]  ? print_irqtrace_events+0x220/0x220
[   17.450839][    T1]  ? smack_current_getsecid_subj+0x22/0xf0
[   17.456665][    T1]  ima_bprm_check+0x128/0x2b0
[   17.461376][    T1]  ? ima_file_mprotect+0x630/0x630
[   17.466596][    T1]  ? tomoyo_bprm_check_security+0x157/0x170
[   17.472718][    T1]  ? bpf_lsm_bprm_check_security+0x9/0x10
[   17.478532][    T1]  bprm_execve+0x8c7/0x17c0
[   17.483078][    T1]  ? alloc_bprm+0x900/0x900
[   17.487748][    T1]  ? copy_string_kernel+0x1c9/0x1f0
[   17.492960][    T1]  kernel_execve+0x8ea/0xa10
[   17.497605][    T1]  ? rest_init+0x300/0x300
[   17.502038][    T1]  kernel_init+0xde/0x2a0
[   17.506364][    T1]  ret_from_fork+0x48/0x80
[   17.510808][    T1]  ? rest_init+0x300/0x300
[   17.515229][    T1]  ret_from_fork_asm+0x11/0x20
[   17.520045][    T1]  </TASK>
[   17.523071][    T1] Kernel panic - not syncing: kernel: panic_on_warn set ...
[   17.530373][    T1] CPU: 1 PID: 1 Comm: swapper/0 Not tainted 6.6.0-rc4-syzkaller-00001-g79be50b1a644 #0
[   17.540081][    T1] Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/06/2023
[   17.550128][    T1] Call Trace:
[   17.553400][    T1]  <TASK>
[   17.556320][    T1]  dump_stack_lvl+0x1e7/0x2d0
[   17.561004][    T1]  ? nf_tcp_handle_invalid+0x650/0x650
[   17.566476][    T1]  ? panic+0x770/0x770
[   17.570546][    T1]  ? vscnprintf+0x5d/0x80
[   17.574964][    T1]  panic+0x30f/0x770
[   17.578877][    T1]  ? __warn+0x171/0x4a0
[   17.583027][    T1]  ? __memcpy_flushcache+0x2b0/0x2b0
[   17.588307][    T1]  ? ret_from_fork_asm+0x11/0x20
[   17.593262][    T1]  __warn+0x314/0x4a0
[   17.597275][    T1]  ? integrity_inode_get+0x499/0x580
[   17.602597][    T1]  report_bug+0x2b3/0x500
[   17.606935][    T1]  ? integrity_inode_get+0x499/0x580
[   17.612218][    T1]  handle_bug+0x3d/0x70
[   17.616365][    T1]  exc_invalid_op+0x1a/0x50
[   17.620862][    T1]  asm_exc_invalid_op+0x1a/0x20
[   17.625711][    T1] RIP: 0010:integrity_inode_get+0x499/0x580
[   17.631598][    T1] Code: eb 11 e8 ba 30 8c fd 48 c7 c7 60 e4 92 8d e8 be 1e d6 06 4c 89 e0 48 83 c4 18 5b 41 5c 41 5d 41 5e 41 5f 5d c3 e8 97 30 8c fd <0f> 0b 31 db e9 b0 fd ff ff 44 89 e9 80 e1 07 80 c1 03 38 c1 0f 8c
[   17.651202][    T1] RSP: 0000:ffffc900000678f0 EFLAGS: 00010293
[   17.657365][    T1] RAX: ffffffff8401db19 RBX: 00000000ffffffff RCX: ffff888015e58000
[   17.665448][    T1] RDX: 0000000000000000 RSI: 00000000ffffffff RDI: 0000000000000001
[   17.673405][    T1] RBP: ffff88801db8aad8 R08: ffffffff8401d8c4 R09: 0000000000000000
[   17.681392][    T1] R10: ffff88802871d088 R11: ffffed10050e3a13 R12: ffff88802871d000
[   17.689449][    T1] R13: ffff88802871d0d0 R14: dffffc0000000000 R15: ffff88801db8aab0
[   17.697440][    T1]  ? integrity_inode_get+0x244/0x580
[   17.702744][    T1]  ? integrity_inode_get+0x499/0x580
[   17.708088][    T1]  process_measurement+0x44d/0x1cf0
[   17.713299][    T1]  ? ima_file_mmap+0x2b0/0x2b0
[   17.718152][    T1]  ? lockdep_hardirqs_on_prepare+0x43c/0x7a0
[   17.724212][    T1]  ? print_irqtrace_events+0x220/0x220
[   17.729771][    T1]  ? smack_current_getsecid_subj+0x22/0xf0
[   17.735568][    T1]  ima_bprm_check+0x128/0x2b0
[   17.740240][    T1]  ? ima_file_mprotect+0x630/0x630
[   17.745342][    T1]  ? tomoyo_bprm_check_security+0x157/0x170
[   17.751221][    T1]  ? bpf_lsm_bprm_check_security+0x9/0x10
[   17.756946][    T1]  bprm_execve+0x8c7/0x17c0
[   17.761458][    T1]  ? alloc_bprm+0x900/0x900
[   17.765952][    T1]  ? copy_string_kernel+0x1c9/0x1f0
[   17.771134][    T1]  kernel_execve+0x8ea/0xa10
[   17.775738][    T1]  ? rest_init+0x300/0x300
[   17.780153][    T1]  kernel_init+0xde/0x2a0
[   17.784472][    T1]  ret_from_fork+0x48/0x80
[   17.788876][    T1]  ? rest_init+0x300/0x300
[   17.793276][    T1]  ret_from_fork_asm+0x11/0x20
[   17.798036][    T1]  </TASK>
[   17.801282][    T1] Kernel Offset: disabled
[   17.805673][    T1] Rebooting in 86400 seconds..


syzkaller build log:
go env (err=<nil>)
GO111MODULE="auto"
GOARCH="amd64"
GOBIN=""
GOCACHE="/syzkaller/.cache/go-build"
GOENV="/syzkaller/.config/go/env"
GOEXE=""
GOEXPERIMENT=""
GOFLAGS=""
GOHOSTARCH="amd64"
GOHOSTOS="linux"
GOINSECURE=""
GOMODCACHE="/syzkaller/jobs-2/linux/gopath/pkg/mod"
GONOPROXY=""
GONOSUMDB=""
GOOS="linux"
GOPATH="/syzkaller/jobs-2/linux/gopath"
GOPRIVATE=""
GOPROXY="https://proxy.golang.org,direct"
GOROOT="/usr/local/go"
GOSUMDB="sum.golang.org"
GOTMPDIR=""
GOTOOLDIR="/usr/local/go/pkg/tool/linux_amd64"
GOVCS=""
GOVERSION="go1.20.1"
GCCGO="gccgo"
GOAMD64="v1"
AR="ar"
CC="gcc"
CXX="g++"
CGO_ENABLED="1"
GOMOD="/syzkaller/jobs-2/linux/gopath/src/github.com/google/syzkaller/go.mod"
GOWORK=""
CGO_CFLAGS="-O2 -g"
CGO_CPPFLAGS=""
CGO_CXXFLAGS="-O2 -g"
CGO_FFLAGS="-O2 -g"
CGO_LDFLAGS="-O2 -g"
PKG_CONFIG="pkg-config"
GOGCCFLAGS="-fPIC -m64 -pthread -Wl,--no-gc-sections -fmessage-length=0 -fdebug-prefix-map=/tmp/go-build3394607480=/tmp/go-build -gno-record-gcc-switches"

git status (err=<nil>)
HEAD detached at 0b6a67ac4
nothing to commit, working tree clean


tput: No value for $TERM and no -T specified
tput: No value for $TERM and no -T specified
Makefile:32: run command via tools/syz-env for best compatibility, see:
Makefile:33: https://github.com/google/syzkaller/blob/master/docs/contributing.md#using-syz-env
go list -f '{{.Stale}}' ./sys/syz-sysgen | grep -q false || go install ./sys/syz-sysgen
make .descriptions
tput: No value for $TERM and no -T specified
tput: No value for $TERM and no -T specified
bin/syz-sysgen
touch .descriptions
GOOS=linux GOARCH=amd64 go build "-ldflags=-s -w -X github.com/google/syzkaller/prog.GitRevision=0b6a67ac4b0dc26f43030c5edd01c9175f13b784 -X 'github.com/google/syzkaller/prog.gitRevisionDate=20230913-073137'" "-tags=syz_target syz_os_linux syz_arch_amd64 " -o ./bin/linux_amd64/syz-fuzzer github.com/google/syzkaller/syz-fuzzer
GOOS=linux GOARCH=amd64 go build "-ldflags=-s -w -X github.com/google/syzkaller/prog.GitRevision=0b6a67ac4b0dc26f43030c5edd01c9175f13b784 -X 'github.com/google/syzkaller/prog.gitRevisionDate=20230913-073137'" "-tags=syz_target syz_os_linux syz_arch_amd64 " -o ./bin/linux_amd64/syz-execprog github.com/google/syzkaller/tools/syz-execprog
GOOS=linux GOARCH=amd64 go build "-ldflags=-s -w -X github.com/google/syzkaller/prog.GitRevision=0b6a67ac4b0dc26f43030c5edd01c9175f13b784 -X 'github.com/google/syzkaller/prog.gitRevisionDate=20230913-073137'" "-tags=syz_target syz_os_linux syz_arch_amd64 " -o ./bin/linux_amd64/syz-stress github.com/google/syzkaller/tools/syz-stress
mkdir -p ./bin/linux_amd64
gcc -o ./bin/linux_amd64/syz-executor executor/executor.cc \
	-m64 -O2 -pthread -Wall -Werror -Wparentheses -Wunused-const-variable -Wframe-larger-than=16384 -Wno-stringop-overflow -Wno-array-bounds -Wno-format-overflow -Wno-unused-but-set-variable -Wno-unused-command-line-argument -static-pie -fpermissive -w -DGOOS_linux=1 -DGOARCH_amd64=1 \
	-DHOSTGOOS_linux=1 -DGIT_REVISION=\"0b6a67ac4b0dc26f43030c5edd01c9175f13b784\"


Error text is too large and was truncated, full error text is at:
https://syzkaller.appspot.com/x/error.txt?x=137bc1b2680000


Tested on:

commit:         79be50b1 ima: annotate iint mutex to avoid lockdep fal..
git tree:       https://github.com/amir73il/linux ima-ovl-fix
kernel config:  https://syzkaller.appspot.com/x/.config?x=57da1ac039c4c78a
dashboard link: https://syzkaller.appspot.com/bug?extid=b42fe626038981fb7bfa
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.
