Return-Path: <linux-fsdevel+bounces-68413-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AAD1C5AF8A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Nov 2025 03:03:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C5E73A7968
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Nov 2025 02:03:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AD7E256C84;
	Fri, 14 Nov 2025 02:03:06 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12954237713
	for <linux-fsdevel@vger.kernel.org>; Fri, 14 Nov 2025 02:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763085786; cv=none; b=cwmkAr2IZWvg+U4MJNPtqY8mOyg5nszVA68riW5vVV7xgdg4FMFFidAhKtaM/K055bEFqx4ctk3ocAu9J9q5HKKD83hLfMAlAkOwQ+3mJMFYE3ZSlGgjbM9O6AQSl/WrgwwJd/+3phXbMromUWs1x6/112a0vGVldf42HVAZReY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763085786; c=relaxed/simple;
	bh=0Qd7FThGnwlfZ98OYqer6gQS8OM+VmKYFPYYitsPFm8=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=i/tUdwDpqML2wHhDNIbt+14YokwXgNsvD3lm/ttlbdgzyH37fgdPvqCRr+QDOp+vZgpVhQCKOHvyEaL997QSbeAxUg1Z6nseO3Am9CNVgspCpCRkKlcmDK8OmhZSMOxTVKKY+P/Auk8mTQjil67Kj8sM2ZNEZ8p2HyNU2t7aPIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-433154d39abso52901065ab.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 13 Nov 2025 18:03:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763085783; x=1763690583;
        h=content-transfer-encoding:to:from:subject:message-id:in-reply-to
         :date:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PhmW7/QilQSJDrVyjRRjI/jdtpsOIHUs2rQXfHfV/WU=;
        b=Z3XcW6HyKqHjsW2oWNthrdIeNaPD5tiNDFN2Tfk78aGUD6R+34iK8J4kCeQoOz6Bej
         WiVi4zfTE45e70Yo2ivogs9CuZzuZDPMvAlmhcwkJRKqg/qIao8Of+BhKDWzN79Ws+Vx
         cAcahMsiORygro1kWmZroYiprjdSTZnekphQKiMZR1YxegYf5Ozx7XfnxUpLaGF/MMbB
         MRSfvJMMntq6T9CZ5P7/rW1LaG+Bl3myq7sWauOSR8ef15FlxI1+p48gMUlbtk4JyvKK
         VOYE9PRDHFYV9LIsZSwqEkYdwqzHKKPKUQUn3X6NJwpsnXUjrutN53BSRrikpcyZnsAe
         h60w==
X-Forwarded-Encrypted: i=1; AJvYcCX80On9NR+WkcrmHNrkALplWvkus5BL6G8PEGu/QqZyBogwlGLXVSdf0Y1NuDst5sYY+fwO5Q4ELuz1MDwT@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/B9HHa4Dq+pQQxojmtfBeEIzXhxKiCw5yxc6KbwGnHAbiF/b0
	521cZ5D/Fx0E6oPnnfIM6kprW2JulePPq6jw/kDAods/XlNygTPjaXwTj/kc+E6JcyRLLNzBwPb
	mQE0bcF1NQ3OY6qrBqlhhBImI6/CuvSBQeM/ozTbJy7ZtPpE4dZkXa/NYstM=
X-Google-Smtp-Source: AGHT+IHp+ng4jmAuiyxMzu2o1RgkqmcL0ou99Y5YNGteOxjZ2j4A+7fJw37D15R9Z3Irt2FTJcsRw/zXw4DgIdN2Wng27aOPdWvI
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3c84:b0:434:7d59:cb21 with SMTP id
 e9e14a558f8ab-4348c942cd7mr31490845ab.17.1763085782146; Thu, 13 Nov 2025
 18:03:02 -0800 (PST)
Date: Thu, 13 Nov 2025 18:03:02 -0800
In-Reply-To: <20251114012440.531779-1-mehdi.benhadjkhelifa@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69168dd6.a70a0220.3124cb.003c.GAE@google.com>
Subject: Re: [syzbot] [hfs?] memory leak in hfs_init_fs_context
From: syzbot <syzbot+ad45f827c88778ff7df6@syzkaller.appspotmail.com>
To: frank.li@vivo.com, glaubitz@physik.fu-berlin.de, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	mehdi.benhadjkhelifa@gmail.com, slava@dubeyko.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

roller area network core
[    9.749562][    T1] NET: Registered PF_CAN protocol family
[    9.750438][    T1] can: raw protocol
[    9.750982][    T1] can: broadcast manager protocol
[    9.751738][    T1] can: netlink gateway - max_hops=3D1
[    9.752496][    T1] can: SAE J1939
[    9.753010][    T1] can: isotp protocol (max_pdu_size 8300)
[    9.754130][    T1] Bluetooth: RFCOMM TTY layer initialized
[    9.754932][    T1] Bluetooth: RFCOMM socket layer initialized
[    9.755826][    T1] Bluetooth: RFCOMM ver 1.11
[    9.756640][    T1] Bluetooth: BNEP (Ethernet Emulation) ver 1.3
[    9.757547][    T1] Bluetooth: BNEP filters: protocol multicast
[    9.758499][    T1] Bluetooth: BNEP socket layer initialized
[    9.759429][    T1] Bluetooth: HIDP (Human Interface Emulation) ver 1.2
[    9.760557][    T1] Bluetooth: HIDP socket layer initialized
[    9.762424][    T1] NET: Registered PF_RXRPC protocol family
[    9.763241][    T1] Key type rxrpc registered
[    9.764425][    T1] Key type rxrpc_s registered
[    9.765548][    T1] NET: Registered PF_KCM protocol family
[    9.766688][    T1] lec:lane_module_init: lec.c: initialized
[    9.767737][    T1] mpoa:atm_mpoa_init: mpc.c: initialized
[    9.768664][    T1] l2tp_core: L2TP core driver, V2.0
[    9.769494][    T1] l2tp_ppp: PPPoL2TP kernel driver, V2.0
[    9.770289][    T1] l2tp_ip: L2TP IP encapsulation support (L2TPv3)
[    9.771155][    T1] l2tp_netlink: L2TP netlink interface
[    9.771938][    T1] l2tp_eth: L2TP ethernet pseudowire support (L2TPv3)
[    9.772847][    T1] l2tp_ip6: L2TP IP encapsulation support for IPv6 (L2=
TPv3)
[    9.774041][    T1] NET: Registered PF_PHONET protocol family
[    9.774894][    T1] 8021q: 802.1Q VLAN Support v1.8
[    9.775717][    T1] sctp: Hash tables configured (bind 256/256)
[    9.777068][    T1] NET: Registered PF_RDS protocol family
[    9.778075][    T1] Registered RDS/infiniband transport
[    9.778994][    T1] Registered RDS/tcp transport
[    9.779692][    T1] tipc: Activated (version 2.0.0)
[    9.780699][    T1] NET: Registered PF_TIPC protocol family
[    9.782344][    T1] tipc: Started in single node mode
[    9.784387][    T1] smc: adding smcd device lo without pnetid
[    9.785913][    T1] NET: Registered PF_SMC protocol family
[    9.787625][    T1] 9pnet: Installing 9P2000 support
[    9.789167][    T1] NET: Registered PF_CAIF protocol family
[    9.791371][    T1] NET: Registered PF_IEEE802154 protocol family
[    9.792806][    T1] Key type dns_resolver registered
[    9.794259][    T1] Key type ceph registered
[    9.795165][    T1] libceph: loaded (mon/osd proto 15/24)
[    9.796573][    T1] batman_adv: B.A.T.M.A.N. advanced 2025.4 (compatibil=
ity version 15) loaded
[    9.798385][    T1] openvswitch: Open vSwitch switching datapath
[    9.799992][    T1] NET: Registered PF_VSOCK protocol family
[    9.800986][    T1] mpls_gso: MPLS GSO support
[    9.819559][    T1] IPI shorthand broadcast: enabled
[   10.013424][    T1] sched_clock: Marking stable (9984532893, 23793120)->=
(10012625265, -4299252)
[   10.021125][    T1] registered taskstats version 1
[   10.025750][    T1] Loading compiled-in X.509 certificates
[   10.058263][    T1] Loaded X.509 cert 'Build time autogenerated kernel k=
ey: ea23c8da7267aa5b617cb0954f38b31bf7cab05f'
[   10.088097][    T1] zswap: loaded using pool 842
[   10.089329][    T1] Demotion targets for Node 0: null
[   10.090444][    T1] Demotion targets for Node 1: null
[   10.091182][    T1] kmemleak: Kernel memory leak detector initialized (m=
em pool available: 15732)
[   10.093020][    T1] Key type .fscrypt registered
[   10.093752][    T1] Key type fscrypt-provisioning registered
[   10.095763][    T1] kAFS: Red Hat AFS client v0.1 registering.
[   10.099093][    T1] Btrfs loaded, assert=3Don, zoned=3Dyes, fsverity=3Dy=
es
[   10.100242][    T1] Key type big_key registered
[   10.101201][    T1] Key type encrypted registered
[   10.101898][    T1] AppArmor: AppArmor sha256 policy hashing enabled
[   10.102910][    T1] ima: No TPM chip found, activating TPM-bypass!
[   10.103860][    T1] Loading compiled-in module X.509 certificates
[   10.135501][    T1] Loaded X.509 cert 'Build time autogenerated kernel k=
ey: ea23c8da7267aa5b617cb0954f38b31bf7cab05f'
[   10.137680][    T1] ima: Allocated hash algorithm: sha256
[   10.138660][    T1] ima: No architecture policies found
[   10.139629][    T1] evm: Initialising EVM extended attributes:
[   10.140520][    T1] evm: security.selinux (disabled)
[   10.141260][    T1] evm: security.SMACK64 (disabled)
[   10.142032][    T1] evm: security.SMACK64EXEC (disabled)
[   10.142977][    T1] evm: security.SMACK64TRANSMUTE (disabled)
[   10.143870][    T1] evm: security.SMACK64MMAP (disabled)
[   10.144647][    T1] evm: security.apparmor
[   10.145278][    T1] evm: security.ima
[   10.145794][    T1] evm: security.capability
[   10.146417][    T1] evm: HMAC attrs: 0x1
[   10.147566][    T1] PM:   Magic number: 1:78:913
[   10.148733][    T1] tty ptyz9: hash matches
[   10.149389][    T1] tty ptywc: hash matches
[   10.150164][    T1] netconsole: network logging started
[   10.151137][    T1] gtp: GTP module loaded (pdp ctx size 128 bytes)
[   10.153632][    T1] rdma_rxe: loaded
[   10.154685][    T1] cfg80211: Loading compiled-in X.509 certificates for=
 regulatory database
[   10.157212][    T1] Loaded X.509 cert 'sforshee: 00b28ddf47aef9cea7'
[   10.159121][    T1] Loaded X.509 cert 'wens: 61c038651aabdcf94bd0ac7ff06=
c7248db18c600'
[   10.160513][ T3094] faux_driver regulatory: Direct firmware load for reg=
ulatory.db failed with error -2
[   10.161920][ T3094] faux_driver regulatory: Falling back to sysfs fallba=
ck for: regulatory.db
[   10.163450][    T1] clk: Disabling unused clocks
[   10.164221][    T1] ALSA device list:
[   10.164750][    T1]   #0: Dummy 1
[   10.165239][    T1]   #1: Loopback 1
[   10.165745][    T1]   #2: Virtual MIDI Card 1
[   10.167530][    T1] check access for rdinit=3D/init failed: -2, ignoring
[   10.168530][    T1] md: Waiting for all devices to be available before a=
utodetect
[   10.169637][    T1] md: If you don't use raid, use raid=3Dnoautodetect
[   10.170520][    T1] md: Autodetecting RAID arrays.
[   10.171192][    T1] md: autorun ...
[   10.171746][    T1] md: ... autorun DONE.
[   10.355755][    T1] EXT4-fs (sda1): orphan cleanup on readonly fs
[   10.357816][    T1] EXT4-fs (sda1): mounted filesystem 4f91c6db-4997-4bb=
4-91b8-7e83a20c1bf1 ro with ordered data mode. Quota mode: none.
[   10.359703][    T1] VFS: Mounted root (ext4 filesystem) readonly on devi=
ce 8:1.
[   10.362032][    T1] devtmpfs: mounted
[   10.368420][    T1] Freeing unused kernel image (initmem) memory: 16140K
[   10.370400][    T1] Write protecting the kernel read-only data: 94208k
[   10.374836][    T1] Freeing unused kernel image (text/rodata gap) memory=
: 1156K
[   10.377014][    T1] Freeing unused kernel image (rodata/data gap) memory=
: 964K
[   10.479434][    T1] x86/mm: Checked W+X mappings: passed, no W+X pages f=
ound.
[   10.481095][    T1] x86/mm: Checking user space page tables
[   10.573323][    T1] x86/mm: Checked W+X mappings: passed, no W+X pages f=
ound.
[   10.574604][    T1] Failed to set sysctl parameter 'kernel.hung_task_all=
_cpu_backtrace=3D1': parameter not found
[   10.578671][    T1] Failed to set sysctl parameter 'max_rcu_stall_to_pan=
ic=3D1': parameter not found
[   10.580258][    T1] Run /sbin/init as init process
[   10.915515][ T5147] mount (5147) used greatest stack depth: 12376 bytes =
left
[   10.959767][ T5148] EXT4-fs (sda1): re-mounted 4f91c6db-4997-4bb4-91b8-7=
e83a20c1bf1 r/w.
[   10.962072][ T5148] mount (5148) used greatest stack depth: 11720 bytes =
left
mount: mounting devtmpfs on /dev failed: Device or resource busy
mount: mounting smackfs on /sys/fs/smackfs failed: No such file or director=
y
mount: mounting selinuxfs on /sys/fs/selinux failed: No such file or direct=
ory
[   11.009468][ T5152] mount (5152) used greatest stack depth: 10488 bytes =
left
Starting syslogd: OK
Starting acpid: OK
Starting klogd: OK
Running sysctl: OK
Populating /dev using udev: [   11.409279][ T5182] udevd[5182]: starting ve=
rsion 3.2.14
[   11.616899][ T5183] udevd[5183]: starting eudev-3.2.14
[   11.618261][ T5182] udevd (5182) used greatest stack depth: 9464 bytes l=
eft
done
Starting system message bus: done
Starting iptables: OK
Starting network: OK
Starting dhcpcd...
dhcpcd-10.2.0 starting
dev: loaded udev
no interfaces have a carrier
[   16.257231][ T5478] 8021q: adding VLAN 0 to HW filter on device bond0
[   16.264394][ T5549] Oops: general protection fault, probably for non-can=
onical address 0x6564752f62696c4f: 0000 [#1] SMP PTI
[   16.265069][ T5478] eql: remember to turn off Van-Jacobson compression o=
n your slave devices
[   16.275854][ T5549] CPU: 1 UID: 0 PID: 5549 Comm: rcS Not tainted syzkal=
ler #0 PREEMPT(full)=20
[   16.275872][ T5549] Hardware name: Google Google Compute Engine/Google C=
ompute Engine, BIOS Google 10/25/2025
[   16.275881][ T5549] RIP: 0010:tomoyo_get_name+0xa9/0x270
[   16.308751][ T5549] Code: 0f 85 6a 01 00 00 e8 b6 b1 ec fe 89 d8 48 c1 e=
3 04 48 8b 9b c0 1a 85 89 48 89 04 24 49 39 dd 0f 84 b2 00 00 00 e8 97 b1 e=
c fe <44> 8b 7b 20 89 ee 44 89 ff e8 39 a9 ec fe 41 39 ef 0f 85 85 00 00
[   16.328351][ T5549] RSP: 0018:ffffc90002807c28 EFLAGS: 00010293
[   16.334412][ T5549] RAX: 0000000000000000 RBX: 6564752f62696c2f RCX: fff=
fffff8274e487
[   16.342387][ T5549] RDX: ffff888102fdb480 RSI: ffffffff8274e479 RDI: 000=
0000000000004
[   16.350405][ T5549] RBP: 000000000367e4aa R08: 0000000000000004 R09: 000=
0000061736c61
[   16.358373][ T5549] R10: 000000000367e4aa R11: 0000000000000000 R12: fff=
f88810984c000
[   16.366511][ T5549] R13: ffffffff898520c0 R14: 0000000000000038 R15: 000=
0000061736c61
[   16.374647][ T5549] FS:  00007fdabe210c80(0000) GS:ffff8881b26c2000(0000=
) knlGS:0000000000000000
[   16.383729][ T5549] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   16.390297][ T5549] CR2: 00007fec51a9a7b8 CR3: 000000010966c000 CR4: 000=
00000003526f0
[   16.398302][ T5549] Call Trace:
[   16.401564][ T5549]  <TASK>
[   16.404607][ T5549]  ? tomoyo_assign_namespace+0x84/0x1d0
[   16.410156][ T5549]  tomoyo_assign_domain+0x249/0x490
[   16.415496][ T5549]  tomoyo_find_next_domain+0x4d1/0xdb0
[   16.420969][ T5549]  tomoyo_bprm_check_security+0x72/0xc0
[   16.426508][ T5549]  security_bprm_check+0x1b9/0x1e0
[   16.431605][ T5549]  bprm_execve+0x381/0x830
[   16.436100][ T5549]  do_execveat_common.isra.0+0x262/0x2e0
[   16.441713][ T5549]  __x64_sys_execve+0x3d/0x50
[   16.446381][ T5549]  do_syscall_64+0xa4/0xfa0
[   16.450879][ T5549]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
[   16.456743][ T5549] RIP: 0033:0x7fdabe3ab107
[   16.461148][ T5549] Code: 0f 00 64 c7 00 07 00 00 00 b8 ff ff ff ff c9 c=
3 0f 1f 00 48 8b 05 a9 ee 0f 00 48 8b 10 e9 01 00 00 00 90 b8 3b 00 00 00 0=
f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d c1 ec 0f 00 f7 d8 64 89 01 48
[   16.480773][ T5549] RSP: 002b:00007fffd1b40b78 EFLAGS: 00000206 ORIG_RAX=
: 000000000000003b
[   16.489522][ T5549] RAX: ffffffffffffffda RBX: 000055ca63b60d30 RCX: 000=
07fdabe3ab107
[   16.497466][ T5549] RDX: 000055ca63b57bb8 RSI: 000055ca63b60d30 RDI: 000=
055ca63b60ce8
[   16.505417][ T5549] RBP: 000055ca63b60ce8 R08: 0000000000000000 R09: 000=
0000000000000
[   16.513806][ T5549] R10: 0000000000000008 R11: 0000000000000206 R12: 000=
055ca63b57bb8
[   16.521843][ T5549] R13: 00007fdabe570e8b R14: 000055ca63b57bb8 R15: 000=
0000000000000
[   16.529794][ T5549]  </TASK>
[   16.532798][ T5549] Modules linked in:
[   16.536769][ T5549] ---[ end trace 0000000000000000 ]---
[   16.542535][ T5549] RIP: 0010:tomoyo_get_name+0xa9/0x270
[   16.548074][ T5549] Code: 0f 85 6a 01 00 00 e8 b6 b1 ec fe 89 d8 48 c1 e=
3 04 48 8b 9b c0 1a 85 89 48 89 04 24 49 39 dd 0f 84 b2 00 00 00 e8 97 b1 e=
c fe <44> 8b 7b 20 89 ee 44 89 ff e8 39 a9 ec fe 41 39 ef 0f 85 85 00 00
[   16.567885][ T5549] RSP: 0018:ffffc90002807c28 EFLAGS: 00010293
[   16.574145][ T5549] RAX: 0000000000000000 RBX: 6564752f62696c2f RCX: fff=
fffff8274e487
[   16.582126][ T5549] RDX: ffff888102fdb480 RSI: ffffffff8274e479 RDI: 000=
0000000000004
[   16.590202][ T5549] RBP: 000000000367e4aa R08: 0000000000000004 R09: 000=
0000061736c61
[   16.598259][ T5549] R10: 000000000367e4aa R11: 0000000000000000 R12: fff=
f88810984c000
[   16.606251][ T5549] R13: ffffffff898520c0 R14: 0000000000000038 R15: 000=
0000061736c61
[   16.614332][ T5549] FS:  00007fdabe210c80(0000) GS:ffff8881b26c2000(0000=
) knlGS:0000000000000000
[   16.623328][ T5549] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   16.629908][ T5549] CR2: 00007fec51a9a7b8 CR3: 000000010966c000 CR4: 000=
00000003526f0
[   16.637983][ T5549] Kernel panic - not syncing: Fatal exception
[   16.644472][ T5549] Kernel Offset: disabled
[   16.648952][ T5549] Rebooting in 86400 seconds..


syzkaller build log:
go env (err=3D<nil>)
AR=3D'ar'
CC=3D'gcc'
CGO_CFLAGS=3D'-O2 -g'
CGO_CPPFLAGS=3D''
CGO_CXXFLAGS=3D'-O2 -g'
CGO_ENABLED=3D'1'
CGO_FFLAGS=3D'-O2 -g'
CGO_LDFLAGS=3D'-O2 -g'
CXX=3D'g++'
GCCGO=3D'gccgo'
GO111MODULE=3D'auto'
GOAMD64=3D'v1'
GOARCH=3D'amd64'
GOAUTH=3D'netrc'
GOBIN=3D''
GOCACHE=3D'/syzkaller/.cache/go-build'
GOCACHEPROG=3D''
GODEBUG=3D''
GOENV=3D'/syzkaller/.config/go/env'
GOEXE=3D''
GOEXPERIMENT=3D''
GOFIPS140=3D'off'
GOFLAGS=3D''
GOGCCFLAGS=3D'-fPIC -m64 -pthread -Wl,--no-gc-sections -fmessage-length=3D0=
 -ffile-prefix-map=3D/tmp/go-build3937347293=3D/tmp/go-build -gno-record-gc=
c-switches'
GOHOSTARCH=3D'amd64'
GOHOSTOS=3D'linux'
GOINSECURE=3D''
GOMOD=3D'/syzkaller/jobs-2/linux/gopath/src/github.com/google/syzkaller/go.=
mod'
GOMODCACHE=3D'/syzkaller/jobs-2/linux/gopath/pkg/mod'
GONOPROXY=3D''
GONOSUMDB=3D''
GOOS=3D'linux'
GOPATH=3D'/syzkaller/jobs-2/linux/gopath'
GOPRIVATE=3D''
GOPROXY=3D'https://proxy.golang.org,direct'
GOROOT=3D'/usr/local/go'
GOSUMDB=3D'sum.golang.org'
GOTELEMETRY=3D'local'
GOTELEMETRYDIR=3D'/syzkaller/.config/go/telemetry'
GOTMPDIR=3D''
GOTOOLCHAIN=3D'auto'
GOTOOLDIR=3D'/usr/local/go/pkg/tool/linux_amd64'
GOVCS=3D''
GOVERSION=3D'go1.24.4'
GOWORK=3D''
PKG_CONFIG=3D'pkg-config'

git status (err=3D<nil>)
HEAD detached at 4e1406b4def
nothing to commit, working tree clean


tput: No value for $TERM and no -T specified
tput: No value for $TERM and no -T specified
Makefile:31: run command via tools/syz-env for best compatibility, see:
Makefile:32: https://github.com/google/syzkaller/blob/master/docs/contribut=
ing.md#using-syz-env
go list -f '{{.Stale}}' -ldflags=3D"-s -w -X github.com/google/syzkaller/pr=
og.GitRevision=3D4e1406b4defac0e2a9d9424c70706f79a7750cf3 -X github.com/goo=
gle/syzkaller/prog.gitRevisionDate=3D20251106-151142"  ./sys/syz-sysgen | g=
rep -q false || go install -ldflags=3D"-s -w -X github.com/google/syzkaller=
/prog.GitRevision=3D4e1406b4defac0e2a9d9424c70706f79a7750cf3 -X github.com/=
google/syzkaller/prog.gitRevisionDate=3D20251106-151142"  ./sys/syz-sysgen
make .descriptions
tput: No value for $TERM and no -T specified
tput: No value for $TERM and no -T specified
Makefile:31: run command via tools/syz-env for best compatibility, see:
Makefile:32: https://github.com/google/syzkaller/blob/master/docs/contribut=
ing.md#using-syz-env
bin/syz-sysgen
touch .descriptions
GOOS=3Dlinux GOARCH=3Damd64 go build -ldflags=3D"-s -w -X github.com/google=
/syzkaller/prog.GitRevision=3D4e1406b4defac0e2a9d9424c70706f79a7750cf3 -X g=
ithub.com/google/syzkaller/prog.gitRevisionDate=3D20251106-151142"  -o ./bi=
n/linux_amd64/syz-execprog github.com/google/syzkaller/tools/syz-execprog
mkdir -p ./bin/linux_amd64
g++ -o ./bin/linux_amd64/syz-executor executor/executor.cc \
	-m64 -O2 -pthread -Wall -Werror -Wparentheses -Wunused-const-variable -Wfr=
ame-larger-than=3D16384 -Wno-stringop-overflow -Wno-array-bounds -Wno-forma=
t-overflow -Wno-unused-but-set-variable -Wno-unused-command-line-argument -=
static-pie -std=3Dc++17 -I. -Iexecutor/_include   -DGOOS_linux=3D1 -DGOARCH=
_amd64=3D1 \
	-DHOSTGOOS_linux=3D1 -DGIT_REVISION=3D\"4e1406b4defac0e2a9d9424c70706f79a7=
750cf3\"
/usr/bin/ld: /tmp/cctPnRU9.o: in function `Connection::Connect(char const*,=
 char const*)':
executor.cc:(.text._ZN10Connection7ConnectEPKcS1_[_ZN10Connection7ConnectEP=
KcS1_]+0x104): warning: Using 'gethostbyname' in statically linked applicat=
ions requires at runtime the shared libraries from the glibc version used f=
or linking
./tools/check-syzos.sh 2>/dev/null


Error text is too large and was truncated, full error text is at:
https://syzkaller.appspot.com/x/error.txt?x=3D16bad7cd980000


Tested on:

commit:         6da43bbe Merge tag 'vfio-v6.18-rc6' of https://github...
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=3Dcb128cd5cb43980=
9
dashboard link: https://syzkaller.appspot.com/bug?extid=3Dad45f827c88778ff7=
df6
compiler:       gcc (Debian 12.2.0-14+deb12u1) 12.2.0, GNU ld (GNU Binutils=
 for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=3D11f2b60a5800=
00


