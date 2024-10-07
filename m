Return-Path: <linux-fsdevel+bounces-31257-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD8B99938AA
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Oct 2024 22:59:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C83991C23D83
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Oct 2024 20:59:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDB951DE8BE;
	Mon,  7 Oct 2024 20:59:06 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AA541DE894
	for <linux-fsdevel@vger.kernel.org>; Mon,  7 Oct 2024 20:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728334746; cv=none; b=eeLs9JAbpbFmYdj0z7b9Sd18mQ7tHtaL3Qe8OvoRL8tM36nPb8c6PY+vYsQHkYPtE9KO8SxPpP2R5QXqHP4qWKzX53TsofRYY2Rofr6CT4nhxf33HOt7NjU+Y29F5JK0+UOyYIrhSwXvpILJQvNp/n/xmZgppo5G3HZc8n3cxVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728334746; c=relaxed/simple;
	bh=0IbqKIo0jn/v73lxxaX06gFtvl7aSz8QormMN+mq51M=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=VrKVW+eQ66BW4t4Nkvea0bDolEfw9J7MdWNNDaJ3URe98Lre9n0YMtlPLdKhBVyDNxGhHDr8HoLBdD/ZT/UDEV2xXJc08tSl6eMX0KT/cRZkpIonUSopFr6j2CsWidFVIYd2b1tiY1zBeNJVMcUpNChWmNWD0XXquRngCN3O7rM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-82aa499f938so437349139f.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 07 Oct 2024 13:59:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728334743; x=1728939543;
        h=content-transfer-encoding:to:from:subject:message-id:in-reply-to
         :date:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gPwNdDSbiUlV0pmxPhWzB79GWLE+oEVrTtChZBh3/Fc=;
        b=CktNAPlB202Kfb3zrth7le2YIyOjHJeFGMYIkm+i2C41O8G8qAFi11pT49Bju5xBDu
         +gFRwXafxiXyHGNrSudx++j9rPx3YdW36fP0S8qxFyl6z9AwzOqo1Ys946un3XcJyqau
         gcFNVN1CJOxXQGRFO10UhnHqkmnauezEf+hZoleLKWbSThGqi2FbL4bVMSvHfNuAlG07
         lgk49oclKTcBWBkV94E+7T7f5TNfgn1rFm1wPs/Og8spfY/8cpq5zQ808zVjwMTYDVA4
         Zm4DeB265rlknS38tDIbpgLoMDQ4iCsUgYUt5ijEt0RzyOnM8OTOC7hgBXHmyvYextfc
         6p0w==
X-Forwarded-Encrypted: i=1; AJvYcCWgXi5ukXfeORGLJPMQiPWN9IRYHeBndVHtLC4wNciq4hCyetQaVE3lYkiffxMirSTuh5LQxFM5A8/aMeuJ@vger.kernel.org
X-Gm-Message-State: AOJu0YxcvjgRQMKCDKeNv1lroSv1K8AsB+85ob3qc+Qj9ac2tzzneZcl
	lh5TtuUCZ1ygZybzSGAkgOODciVw0mt4gL7HZoUYAYOdb57bKgqa5PSLybGxPttRrmriJa68bsS
	erNSvRnbm9/Yq4WW+jDi2mJUtbBeqOKlubU0oVJQCtOEMPxUAfToqpac=
X-Google-Smtp-Source: AGHT+IFaXgyV/jxtvx6BR0J7tbbEIz+lUZjeYjmXAezShcZOvJeVzCFxegdt6rN0jTtMVP6u9YFl7IfeleO7iO4I/5F5oGQ+62Ti
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:154d:b0:3a2:762b:faf0 with SMTP id
 e9e14a558f8ab-3a38af37298mr7911475ab.11.1728334743545; Mon, 07 Oct 2024
 13:59:03 -0700 (PDT)
Date: Mon, 07 Oct 2024 13:59:03 -0700
In-Reply-To: <5c31f6f0-b68e-4ee6-80ae-e57799177f6c@redhat.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67044b97.050a0220.49194.051b.GAE@google.com>
Subject: Re: [syzbot] [hfs?] general protection fault in hfs_mdb_commit
From: syzbot <syzbot+5cfa9ffce7cc5744fe24@syzkaller.appspotmail.com>
To: brauner@kernel.org, jack@suse.cz, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, sandeen@redhat.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

2.392036][    T1] Simple TC action Loaded
[   12.400348][    T1] netem: version 1.3
[   12.404412][    T1] u32 classifier
[   12.407989][    T1]     Performance counters on
[   12.412673][    T1]     input device check on
[   12.417197][    T1]     Actions configured
[   12.424268][    T1] nf_conntrack_irc: failed to register helpers
[   12.430566][    T1] nf_conntrack_sane: failed to register helpers
[   12.549571][    T1] nf_conntrack_sip: failed to register helpers
[   12.561145][    T1] xt_time: kernel timezone is -0000
[   12.566617][    T1] IPVS: Registered protocols (TCP, UDP, SCTP, AH, ESP)
[   12.573587][    T1] IPVS: Connection hash table configured (size=3D4096,=
 memory=3D32Kbytes)
[   12.582584][    T1] IPVS: ipvs loaded.
[   12.586580][    T1] IPVS: [rr] scheduler registered.
[   12.592118][    T1] IPVS: [wrr] scheduler registered.
[   12.597856][    T1] IPVS: [lc] scheduler registered.
[   12.603294][    T1] IPVS: [wlc] scheduler registered.
[   12.608549][    T1] IPVS: [fo] scheduler registered.
[   12.613738][    T1] IPVS: [ovf] scheduler registered.
[   12.619443][    T1] IPVS: [lblc] scheduler registered.
[   12.624956][    T1] IPVS: [lblcr] scheduler registered.
[   12.630545][    T1] IPVS: [dh] scheduler registered.
[   12.635664][    T1] IPVS: [sh] scheduler registered.
[   12.641370][    T1] IPVS: [mh] scheduler registered.
[   12.646997][    T1] IPVS: [sed] scheduler registered.
[   12.652295][    T1] IPVS: [nq] scheduler registered.
[   12.657444][    T1] IPVS: [twos] scheduler registered.
[   12.663128][    T1] IPVS: [sip] pe registered.
[   12.668316][    T1] ipip: IPv4 and MPLS over IPv4 tunneling driver
[   12.677479][    T1] gre: GRE over IPv4 demultiplexor driver
[   12.683315][    T1] ip_gre: GRE over IPv4 tunneling driver
[   12.697687][    T1] IPv4 over IPsec tunneling driver
[   12.706721][    T1] Initializing XFRM netlink socket
[   12.712259][    T1] IPsec XFRM device driver
[   12.718070][    T1] NET: Registered PF_INET6 protocol family
[   12.736184][    T1] Segment Routing with IPv6
[   12.741286][    T1] RPL Segment Routing with IPv6
[   12.746530][    T1] In-situ OAM (IOAM) with IPv6
[   12.751621][    T1] mip6: Mobile IPv6
[   12.759166][    T1] sit: IPv6, IPv4 and MPLS over IPv4 tunneling driver
[   12.771857][    T1] ip6_gre: GRE over IPv6 tunneling driver
[   12.781112][    T1] NET: Registered PF_PACKET protocol family
[   12.787253][    T1] NET: Registered PF_KEY protocol family
[   12.793462][    T1] Bridge firewalling registered
[   12.799359][    T1] NET: Registered PF_X25 protocol family
[   12.805265][    T1] X25: Linux Version 0.2
[   12.843878][    T1] NET: Registered PF_NETROM protocol family
[   12.885061][    T1] NET: Registered PF_ROSE protocol family
[   12.891212][    T1] NET: Registered PF_AX25 protocol family
[   12.897409][    T1] can: controller area network core
[   12.903103][    T1] NET: Registered PF_CAN protocol family
[   12.908798][    T1] can: raw protocol
[   12.912720][    T1] can: broadcast manager protocol
[   12.918861][    T1] can: netlink gateway - max_hops=3D1
[   12.924251][    T1] can: SAE J1939
[   12.928653][    T1] can: isotp protocol (max_pdu_size 8300)
[   12.935025][    T1] Bluetooth: RFCOMM TTY layer initialized
[   12.940918][    T1] Bluetooth: RFCOMM socket layer initialized
[   12.947066][    T1] Bluetooth: RFCOMM ver 1.11
[   12.951710][    T1] Bluetooth: BNEP (Ethernet Emulation) ver 1.3
[   12.957878][    T1] Bluetooth: BNEP filters: protocol multicast
[   12.964036][    T1] Bluetooth: BNEP socket layer initialized
[   12.969859][    T1] Bluetooth: HIDP (Human Interface Emulation) ver 1.2
[   12.976661][    T1] Bluetooth: HIDP socket layer initialized
[   12.986457][    T1] NET: Registered PF_RXRPC protocol family
[   12.992506][    T1] Key type rxrpc registered
[   12.997264][    T1] Key type rxrpc_s registered
[   13.003267][    T1] NET: Registered PF_KCM protocol family
[   13.010612][    T1] lec:lane_module_init: lec.c: initialized
[   13.016647][    T1] mpoa:atm_mpoa_init: mpc.c: initialized
[   13.022464][    T1] l2tp_core: L2TP core driver, V2.0
[   13.027737][    T1] l2tp_ppp: PPPoL2TP kernel driver, V2.0
[   13.033968][    T1] l2tp_ip: L2TP IP encapsulation support (L2TPv3)
[   13.041194][    T1] l2tp_netlink: L2TP netlink interface
[   13.046980][    T1] l2tp_eth: L2TP ethernet pseudowire support (L2TPv3)
[   13.053952][    T1] l2tp_ip6: L2TP IP encapsulation support for IPv6 (L2=
TPv3)
[   13.061705][    T1] NET: Registered PF_PHONET protocol family
[   13.068094][    T1] 8021q: 802.1Q VLAN Support v1.8
[   13.087954][    T1] DCCP: Activated CCID 2 (TCP-like)
[   13.093706][    T1] DCCP: Activated CCID 3 (TCP-Friendly Rate Control)
[   13.100779][    T1] DCCP is deprecated and scheduled to be removed in 20=
25, please contact the netdev mailing list
[   13.112339][    T1] sctp: Hash tables configured (bind 32/56)
[   13.119792][    T1] NET: Registered PF_RDS protocol family
[   13.137180][    T1] Registered RDS/infiniband transport
[   13.143886][    T1] Registered RDS/tcp transport
[   13.148725][    T1] tipc: Activated (version 2.0.0)
[   13.154585][    T1] NET: Registered PF_TIPC protocol family
[   13.161215][    T1] tipc: Started in single node mode
[   13.167673][    T1] NET: Registered PF_SMC protocol family
[   13.174197][    T1] 9pnet: Installing 9P2000 support
[   13.180146][    T1] NET: Registered PF_CAIF protocol family
[   13.189912][    T1] NET: Registered PF_IEEE802154 protocol family
[   13.196637][    T1] Key type dns_resolver registered
[   13.202031][    T1] Key type ceph registered
[   13.207113][    T1] libceph: loaded (mon/osd proto 15/24)
[   13.214179][    T1] batman_adv: B.A.T.M.A.N. advanced 2024.2 (compatibil=
ity version 15) loaded
[   13.223205][    T1] openvswitch: Open vSwitch switching datapath
[   13.231919][    T1] NET: Registered PF_VSOCK protocol family
[   13.238480][    T1] mpls_gso: MPLS GSO support
[   13.260193][    T1] IPI shorthand broadcast: enabled
[   13.266458][    T1] AES CTR mode by8 optimization enabled
[   13.589566][    T1] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[   13.596222][    T1] BUG: KFENCE: memory corruption in krealloc_noprof+0x=
160/0x2e0
[   13.596222][    T1]=20
[   13.596222][    T1] Corrupted memory at 0xffff88823bea2ff8 [ 0x00 0x00 0=
x00 0x00 0x00 0x00 0x00 0x00 ] (in kfence-#80):
[   13.596222][    T1]  krealloc_noprof+0x160/0x2e0
[   13.596222][    T1]  add_sysfs_param+0x137/0x7f0
[   13.596222][    T1]  kernel_add_sysfs_param+0xb4/0x130
[   13.596222][    T1]  param_sysfs_builtin+0x16e/0x1f0
[   13.596222][    T1]  param_sysfs_builtin_init+0x31/0x40
[   13.596222][    T1]  do_one_initcall+0x248/0x880
[   13.646287][    T1]  do_initcall_level+0x157/0x210
[   13.646287][    T1]  do_initcalls+0x3f/0x80
[   13.646287][    T1]  kernel_init_freeable+0x435/0x5d0
[   13.646287][    T1]  kernel_init+0x1d/0x2b0
[   13.646287][    T1]  ret_from_fork+0x4b/0x80
[   13.646287][    T1]  ret_from_fork_asm+0x1a/0x30
[   13.676285][    T1]=20
[   13.676285][    T1] kfence-#80: 0xffff88823bea2fe0-0xffff88823bea2ff7, s=
ize=3D24, cache=3Dkmalloc-32
[   13.676285][    T1]=20
[   13.676285][    T1] allocated by task 1 on cpu 0 at 13.588158s (0.088126=
s ago):
[   13.676285][    T1]  krealloc_noprof+0xd6/0x2e0
[   13.676285][    T1]  add_sysfs_param+0x137/0x7f0
[   13.706250][    T1]  kernel_add_sysfs_param+0xb4/0x130
[   13.706250][    T1]  param_sysfs_builtin+0x16e/0x1f0
[   13.706250][    T1]  param_sysfs_builtin_init+0x31/0x40
[   13.706250][    T1]  do_one_initcall+0x248/0x880
[   13.706250][    T1]  do_initcall_level+0x157/0x210
[   13.706250][    T1]  do_initcalls+0x3f/0x80
[   13.736270][    T1]  kernel_init_freeable+0x435/0x5d0
[   13.736270][    T1]  kernel_init+0x1d/0x2b0
[   13.736270][    T1]  ret_from_fork+0x4b/0x80
[   13.736270][    T1]  ret_from_fork_asm+0x1a/0x30
[   13.736270][    T1]=20
[   13.736270][    T1] freed by task 1 on cpu 0 at 13.589501s (0.146769s ag=
o):
[   13.766251][    T1]  krealloc_noprof+0x160/0x2e0
[   13.766251][    T1]  add_sysfs_param+0x137/0x7f0
[   13.766251][    T1]  kernel_add_sysfs_param+0xb4/0x130
[   13.766251][    T1]  param_sysfs_builtin+0x16e/0x1f0
[   13.766251][    T1]  param_sysfs_builtin_init+0x31/0x40
[   13.766251][    T1]  do_one_initcall+0x248/0x880
[   13.796268][    T1]  do_initcall_level+0x157/0x210
[   13.796268][    T1]  do_initcalls+0x3f/0x80
[   13.796268][    T1]  kernel_init_freeable+0x435/0x5d0
[   13.796268][    T1]  kernel_init+0x1d/0x2b0
[   13.796268][    T1]  ret_from_fork+0x4b/0x80
[   13.796268][    T1]  ret_from_fork_asm+0x1a/0x30
[   13.826256][    T1]=20
[   13.826256][    T1] CPU: 0 UID: 0 PID: 1 Comm: swapper/0 Not tainted 6.1=
2.0-rc1-next-20241004-syzkaller-02483-g58ca61c1a866-dirty #0
[   13.826256][    T1] Hardware name: Google Google Compute Engine/Google C=
ompute Engine, BIOS Google 09/13/2024
[   13.826256][    T1] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[   13.856269][    T1] Kernel panic - not syncing: KFENCE: panic_on_warn se=
t ...
[   13.856269][    T1] CPU: 0 UID: 0 PID: 1 Comm: swapper/0 Not tainted 6.1=
2.0-rc1-next-20241004-syzkaller-02483-g58ca61c1a866-dirty #0
[   13.856269][    T1] Hardware name: Google Google Compute Engine/Google C=
ompute Engine, BIOS Google 09/13/2024
[   13.886253][    T1] Call Trace:
[   13.886253][    T1]  <TASK>
[   13.886253][    T1]  dump_stack_lvl+0x241/0x360
[   13.886253][    T1]  ? __pfx_dump_stack_lvl+0x10/0x10
[   13.886253][    T1]  ? __pfx__printk+0x10/0x10
[   13.886253][    T1]  ? __asan_memset+0x23/0x50
[   13.886253][    T1]  ? vscnprintf+0x5d/0x90
[   13.916309][    T1]  panic+0x349/0x880
[   13.916309][    T1]  ? check_panic_on_warn+0x21/0xb0
[   13.916309][    T1]  ? __pfx_panic+0x10/0x10
[   13.916309][    T1]  ? _printk+0xd5/0x120
[   13.916309][    T1]  ? __pfx__printk+0x10/0x10
[   13.916309][    T1]  ? __pfx__printk+0x10/0x10
[   13.946300][    T1]  check_panic_on_warn+0x86/0xb0
[   13.946300][    T1]  kfence_report_error+0x998/0xd10
[   13.956349][    T1]  ? mark_lock+0x9a/0x360
[   13.956349][    T1]  ? __pfx_kfence_report_error+0x10/0x10
[   13.966332][    T1]  ? check_canary+0x82b/0x920
[   13.966332][    T1]  ? kfence_guarded_free+0x24f/0x4f0
[   13.976366][    T1]  ? kfree+0x21c/0x420
[   13.976366][    T1]  ? krealloc_noprof+0x160/0x2e0
[   13.986334][    T1]  ? add_sysfs_param+0x137/0x7f0
[   13.986334][    T1]  ? kernel_add_sysfs_param+0xb4/0x130
[   13.996298][    T1]  ? param_sysfs_builtin+0x16e/0x1f0
[   13.996298][    T1]  ? param_sysfs_builtin_init+0x31/0x40
[   14.006339][    T1]  ? do_one_initcall+0x248/0x880
[   14.006339][    T1]  ? do_initcall_level+0x157/0x210
[   14.016317][    T1]  ? do_initcalls+0x3f/0x80
[   14.016317][    T1]  ? kernel_init_freeable+0x435/0x5d0
[   14.026379][    T1]  ? kernel_init+0x1d/0x2b0
[   14.026379][    T1]  ? ret_from_fork+0x4b/0x80
[   14.036348][    T1]  ? ret_from_fork_asm+0x1a/0x30
[   14.036348][    T1]  ? _raw_spin_lock_irqsave+0xe1/0x120
[   14.046348][    T1]  ? __pfx__raw_spin_lock_irqsave+0x10/0x10
[   14.046348][    T1]  ? lockdep_hardirqs_on+0x99/0x150
[   14.056353][    T1]  ? _raw_spin_unlock_irqrestore+0xdd/0x140
[   14.066294][    T1]  ? __pfx__raw_spin_unlock_irqrestore+0x10/0x10
[   14.066294][    T1]  check_canary+0x82b/0x920
[   14.076348][    T1]  kfence_guarded_free+0x24f/0x4f0
[   14.076348][    T1]  ? krealloc_noprof+0x160/0x2e0
[   14.086273][    T1]  kfree+0x21c/0x420
[   14.086273][    T1]  ? add_sysfs_param+0x137/0x7f0
[   14.096312][    T1]  krealloc_noprof+0x160/0x2e0
[   14.096312][    T1]  add_sysfs_param+0x137/0x7f0
[   14.106294][    T1]  kernel_add_sysfs_param+0xb4/0x130
[   14.106294][    T1]  param_sysfs_builtin+0x16e/0x1f0
[   14.116362][    T1]  ? __pfx_param_sysfs_builtin+0x10/0x10
[   14.116362][    T1]  ? version_sysfs_builtin+0xcd/0xe0
[   14.126328][    T1]  ? __pfx_param_sysfs_builtin_init+0x10/0x10
[   14.136364][    T1]  param_sysfs_builtin_init+0x31/0x40
[   14.136364][    T1]  do_one_initcall+0x248/0x880
[   14.146289][    T1]  ? __pfx_param_sysfs_builtin_init+0x10/0x10
[   14.146289][    T1]  ? __pfx_do_one_initcall+0x10/0x10
[   14.156303][    T1]  ? __pfx_parse_args+0x10/0x10
[   14.156303][    T1]  ? rcu_is_watching+0x15/0xb0
[   14.166286][    T1]  do_initcall_level+0x157/0x210
[   14.166286][    T1]  do_initcalls+0x3f/0x80
[   14.176344][    T1]  kernel_init_freeable+0x435/0x5d0
[   14.176344][    T1]  ? __pfx_kernel_init_freeable+0x10/0x10
[   14.186278][    T1]  ? __pfx_lockdep_hardirqs_on_prepare+0x10/0x10
[   14.186278][    T1]  ? __pfx_kernel_init+0x10/0x10
[   14.196404][    T1]  ? __pfx_kernel_init+0x10/0x10
[   14.196404][    T1]  ? __pfx_kernel_init+0x10/0x10
[   14.206288][    T1]  kernel_init+0x1d/0x2b0
[   14.206288][    T1]  ret_from_fork+0x4b/0x80
[   14.216356][    T1]  ? __pfx_kernel_init+0x10/0x10
[   14.216356][    T1]  ret_from_fork_asm+0x1a/0x30
[   14.226293][    T1]  </TASK>
[   14.226293][    T1] Kernel Offset: disabled
[   14.226293][    T1] Rebooting in 86400 seconds..


syzkaller build log:
go env (err=3D<nil>)
GO111MODULE=3D'auto'
GOARCH=3D'amd64'
GOBIN=3D''
GOCACHE=3D'/syzkaller/.cache/go-build'
GOENV=3D'/syzkaller/.config/go/env'
GOEXE=3D''
GOEXPERIMENT=3D''
GOFLAGS=3D''
GOHOSTARCH=3D'amd64'
GOHOSTOS=3D'linux'
GOINSECURE=3D''
GOMODCACHE=3D'/syzkaller/jobs-2/linux/gopath/pkg/mod'
GONOPROXY=3D''
GONOSUMDB=3D''
GOOS=3D'linux'
GOPATH=3D'/syzkaller/jobs-2/linux/gopath'
GOPRIVATE=3D''
GOPROXY=3D'https://proxy.golang.org,direct'
GOROOT=3D'/usr/local/go'
GOSUMDB=3D'sum.golang.org'
GOTMPDIR=3D''
GOTOOLCHAIN=3D'auto'
GOTOOLDIR=3D'/usr/local/go/pkg/tool/linux_amd64'
GOVCS=3D''
GOVERSION=3D'go1.22.7'
GCCGO=3D'gccgo'
GOAMD64=3D'v1'
AR=3D'ar'
CC=3D'gcc'
CXX=3D'g++'
CGO_ENABLED=3D'1'
GOMOD=3D'/syzkaller/jobs-2/linux/gopath/src/github.com/google/syzkaller/go.=
mod'
GOWORK=3D''
CGO_CFLAGS=3D'-O2 -g'
CGO_CPPFLAGS=3D''
CGO_CXXFLAGS=3D'-O2 -g'
CGO_FFLAGS=3D'-O2 -g'
CGO_LDFLAGS=3D'-O2 -g'
PKG_CONFIG=3D'pkg-config'
GOGCCFLAGS=3D'-fPIC -m64 -pthread -Wl,--no-gc-sections -fmessage-length=3D0=
 -ffile-prefix-map=3D/tmp/go-build1625951770=3D/tmp/go-build -gno-record-gc=
c-switches'

git status (err=3D<nil>)
HEAD detached at d7906effc2
nothing to commit, working tree clean


tput: No value for $TERM and no -T specified
tput: No value for $TERM and no -T specified
Makefile:31: run command via tools/syz-env for best compatibility, see:
Makefile:32: https://github.com/google/syzkaller/blob/master/docs/contribut=
ing.md#using-syz-env
go list -f '{{.Stale}}' ./sys/syz-sysgen | grep -q false || go install ./sy=
s/syz-sysgen
make .descriptions
tput: No value for $TERM and no -T specified
tput: No value for $TERM and no -T specified
Makefile:31: run command via tools/syz-env for best compatibility, see:
Makefile:32: https://github.com/google/syzkaller/blob/master/docs/contribut=
ing.md#using-syz-env
bin/syz-sysgen
go fmt ./sys/... >/dev/null
touch .descriptions
GOOS=3Dlinux GOARCH=3Damd64 go build "-ldflags=3D-s -w -X github.com/google=
/syzkaller/prog.GitRevision=3Dd7906effc263366a8b067258cec67072b29aa5e0 -X '=
github.com/google/syzkaller/prog.gitRevisionDate=3D20241003-062913'" "-tags=
=3Dsyz_target syz_os_linux syz_arch_amd64 " -o ./bin/linux_amd64/syz-execpr=
og github.com/google/syzkaller/tools/syz-execprog
mkdir -p ./bin/linux_amd64
g++ -o ./bin/linux_amd64/syz-executor executor/executor.cc \
	-m64 -O2 -pthread -Wall -Werror -Wparentheses -Wunused-const-variable -Wfr=
ame-larger-than=3D16384 -Wno-stringop-overflow -Wno-array-bounds -Wno-forma=
t-overflow -Wno-unused-but-set-variable -Wno-unused-command-line-argument -=
static-pie -std=3Dc++17 -I. -Iexecutor/_include -fpermissive -w -DGOOS_linu=
x=3D1 -DGOARCH_amd64=3D1 \
	-DHOSTGOOS_linux=3D1 -DGIT_REVISION=3D\"d7906effc263366a8b067258cec67072b2=
9aa5e0\"
/usr/bin/ld: /tmp/ccMzj0Og.o: in function `test_cover_filter()':
executor.cc:(.text+0x1424b): warning: the use of `tempnam' is dangerous, be=
tter use `mkstemp'
/usr/bin/ld: /tmp/ccMzj0Og.o: in function `Connection::Connect(char const*,=
 char const*)':
executor.cc:(.text._ZN10Connection7ConnectEPKcS1_[_ZN10Connection7ConnectEP=
KcS1_]+0x104): warning: Using 'gethostbyname' in statically linked applicat=
ions requires at runtime the shared libraries from the glibc version used f=
or linking


Error text is too large and was truncated, full error text is at:
https://syzkaller.appspot.com/x/error.txt?x=3D1510e7d0580000


Tested on:

commit:         58ca61c1 Add linux-next specific files for 20241004
git tree:       linux-next
kernel config:  https://syzkaller.appspot.com/x/.config?x=3D94f9caf16c0af42=
d
dashboard link: https://syzkaller.appspot.com/bug?extid=3D5cfa9ffce7cc5744f=
e24
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debia=
n) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=3D1115f79f9800=
00


