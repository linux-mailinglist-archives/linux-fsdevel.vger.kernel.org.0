Return-Path: <linux-fsdevel+bounces-21858-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BE51990C29C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Jun 2024 05:55:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D2661F2411E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Jun 2024 03:55:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51C8145BF3;
	Tue, 18 Jun 2024 03:55:06 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18F384C6D
	for <linux-fsdevel@vger.kernel.org>; Tue, 18 Jun 2024 03:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718682906; cv=none; b=okd5m6yf94l8Nn25+mYiVHW/1qT4/GdsYfY+csdfXcdKhWnjYDf0ttHbHHjgxnd6RTsxdqFWmYdBwEp6rfr1UigLxTdq+yvOKRV1PveK7pfEb8aki/cKwiFZVVOdiU2268Q7RDMDZ7L7P5YtT5AJnSY2o5TpI0vk9K+o3UrcdJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718682906; c=relaxed/simple;
	bh=81trWdXVFGaFWWgzCVQNUbvVeJ5EePAeKK+p6UqN01c=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=EF/jU8ngW+AIMe52ZoSE/78YP1v+aObu7pRIfdymnM3FAMiS647yyBwONh/ftlTywIIfeoKT1FGipEyr/GegXd12VhJ6N9LyOStfkjT7JpShVF/F8EHP3+IzbesqpFPavDTwcP/xWVclAbCY3Bp8NFcKWP2q4qBUDvwDE93rDzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3746147204eso64344235ab.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 17 Jun 2024 20:55:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718682903; x=1719287703;
        h=content-transfer-encoding:to:from:subject:message-id:in-reply-to
         :date:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DlVOyRbn4/XbWHgjXaVFvTy++OyJbV82Ig6/wZCoS3o=;
        b=ve0Ca6bahXNufSUUzKRsTYiOUplqmfRB9ZnCIbeCBwBiozzTfNIo3bz0mLQCjiLAxs
         ecGiol9EtL5PMo5593kil9xQJNmXEnxzoWgXkpLjx4A+4xAxFG61+mLW1tVd0+v0gCGf
         LYt5eAM23Q5nQc9CZLW9VOg8ppdb67E5KBZTS52n/sQO/PmC/cWgl80mUBFFoeHMHJBz
         gFMRbek8e+oyQYmQ6fMNTWZIsVvzpD/r/OQFOxpkDzq8sYY+MgP4SqgFnzuPUfriSSIC
         19jebDa5pos8hPGnwucVcrobTll4qL7dtAfkvL3VO1fLk4F8un8JgLz8g74LC1rnsTiR
         m0ag==
X-Forwarded-Encrypted: i=1; AJvYcCUNyQiRRD5e7wKyzaua+8SC2xvFCAqBubfTp6yndO3ZJPZ0IxM00awRSYqsqSNAFN8GukyDPBpEECM51+G5xGfm/BKP6+auSKT3rY6ELQ==
X-Gm-Message-State: AOJu0YwXJybLaFD8Wc2pxBmHr0TIm5Wixj/jAaxotfcchxGk6rWhDRcQ
	m3tu983E+bdvV36/feOOieV16jk1TJby0NdZKK8K0xJ3dcZXTeNBJXspOQ8Y0+/T58hDv9E6PIj
	GiZRB8uhtMkvlfBavaavIXoXZCM4iFh6lc2pcmMWSJZlKsLNX0GOHrps=
X-Google-Smtp-Source: AGHT+IFxfFqRI04q5X/ALazcGj5gVYBYsv8hytOEcq4BdhXh9eyYArtoq+QvfIe8s5z2VJn3rw5R9TMfvwxabF6QvMjxgbwu8VUv
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:164e:b0:375:ae17:a2aa with SMTP id
 e9e14a558f8ab-375e0e9fc29mr8708845ab.3.1718682903243; Mon, 17 Jun 2024
 20:55:03 -0700 (PDT)
Date: Mon, 17 Jun 2024 20:55:03 -0700
In-Reply-To: <20240617133948.4kubbcbmn2q5j5pp@quack3>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ee0579061b220b60@google.com>
Subject: Re: [syzbot] [udf?] KMSAN: uninit-value in udf_update_tag
From: syzbot <syzbot+d31185aa54170f7fc1f5@syzkaller.appspotmail.com>
To: jack@suse.com, jack@suse.cz, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

][    T1] mpls_gso: MPLS GSO support
[   46.495161][    T1] IPI shorthand broadcast: enabled
[   47.945988][    T1] sched_clock: Marking stable (47900060195, 37888241)-=
>(47941283984, -3335548)
[   48.918291][    T1] Timer migration: 1 hierarchy levels; 8 children per =
group; 0 crossnode level
[   49.239698][    T1] registered taskstats version 1
[   49.313566][    T1] Loading compiled-in X.509 certificates
[   49.357054][    T1] Loaded X.509 cert 'Build time autogenerated kernel k=
ey: 02861f0ad196e4ccf5027727c19e24903aa3308e'
[   49.597875][    T1] zswap: loaded using pool lzo/zsmalloc
[   49.611087][    T1] Demotion targets for Node 0: null
[   49.616536][    T1] Demotion targets for Node 1: null
[   49.623550][    T1] Key type .fscrypt registered
[   49.629834][    T1] Key type fscrypt-provisioning registered
[   49.637187][    T1] kAFS: Red Hat AFS client v0.1 registering.
[   49.668354][    T1] Btrfs loaded, assert=3Don, ref-verify=3Don, zoned=3D=
yes, fsverity=3Dyes
[   49.695115][    T1] Key type encrypted registered
[   49.700255][    T1] AppArmor: AppArmor sha256 policy hashing enabled
[   49.707007][    T1] ima: No TPM chip found, activating TPM-bypass!
[   49.714081][    T1] Loading compiled-in module X.509 certificates
[   49.754830][    T1] Loaded X.509 cert 'Build time autogenerated kernel k=
ey: 02861f0ad196e4ccf5027727c19e24903aa3308e'
[   49.768389][    T1] ima: Allocated hash algorithm: sha256
[   49.774425][    T1] ima: No architecture policies found
[   49.780963][    T1] evm: Initialising EVM extended attributes:
[   49.787003][    T1] evm: security.selinux (disabled)
[   49.792239][    T1] evm: security.SMACK64 (disabled)
[   49.797413][    T1] evm: security.SMACK64EXEC (disabled)
[   49.802981][    T1] evm: security.SMACK64TRANSMUTE (disabled)
[   49.809016][    T1] evm: security.SMACK64MMAP (disabled)
[   49.814639][    T1] evm: security.apparmor
[   49.819013][    T1] evm: security.ima
[   49.823162][    T1] evm: security.capability
[   49.827628][    T1] evm: HMAC attrs: 0x1
[   49.836741][    T1] PM:   Magic number: 12:902:765
[   49.843812][    T1] tty ptyp1: hash matches
[   49.849855][    T1] printk: legacy console [netcon0] enabled
[   49.855889][    T1] netconsole: network logging started
[   49.863365][    T1] gtp: GTP module loaded (pdp ctx size 128 bytes)
[   49.872448][    T1] rdma_rxe: loaded
[   49.878540][    T1] cfg80211: Loading compiled-in X.509 certificates for=
 regulatory database
[   49.899504][    T1] Loaded X.509 cert 'sforshee: 00b28ddf47aef9cea7'
[   49.917084][    T1] Loaded X.509 cert 'wens: 61c038651aabdcf94bd0ac7ff06=
c7248db18c600'
[   49.925983][    T1] clk: Disabling unused clocks
[   49.931082][    T1] ALSA device list:
[   49.934975][    T1]   #0: Dummy 1
[   49.938653][    T1]   #1: Loopback 1
[   49.942572][    T1]   #2: Virtual MIDI Card 1
[   49.953506][    T1] md: Waiting for all devices to be available before a=
utodetect
[   49.953939][  T780] platform regulatory.0: Direct firmware load for regu=
latory.db failed with error -2
[   49.961362][    T1] md: If you don't use raid, use raid=3Dnoautodetect
[   49.961430][    T1] md: Autodetecting RAID arrays.
[   49.961470][    T1] md: autorun ...
[   49.961510][    T1] md: ... autorun DONE.
[   49.971152][  T780] platform regulatory.0: Falling back to sysfs fallbac=
k for: regulatory.db
[   50.054771][    T1] EXT4-fs (sda1): mounted filesystem 5941fea2-f5fa-4b4=
e-b5ef-9af118b27b95 ro with ordered data mode. Quota mode: none.
[   50.068782][    T1] VFS: Mounted root (ext4 filesystem) readonly on devi=
ce 8:1.
[   50.080603][    T1] devtmpfs: mounted
[   50.343600][    T1] Freeing unused kernel image (initmem) memory: 36920K
[   50.355761][    T1] Write protecting the kernel read-only data: 260096k
[   50.404101][    T1] Freeing unused kernel image (rodata/data gap) memory=
: 1876K
[   52.057623][    T1] x86/mm: Checked W+X mappings: passed, no W+X pages f=
ound.
[   52.067985][    T1] x86/mm: Checking user space page tables
[   53.575965][    T1] x86/mm: Checked W+X mappings: passed, no W+X pages f=
ound.
[   53.585097][    T1] Failed to set sysctl parameter 'kernel.hung_task_all=
_cpu_backtrace=3D1': parameter not found
[   53.606359][    T1] Failed to set sysctl parameter 'max_rcu_stall_to_pan=
ic=3D1': parameter not found
[   53.618619][    T1] Run /sbin/init as init process
[   55.234149][ T4444] mount (4444) used greatest stack depth: 8144 bytes l=
eft
[   55.320581][ T4445] EXT4-fs (sda1): re-mounted 5941fea2-f5fa-4b4e-b5ef-9=
af118b27b95 r/w. Quota mode: none.
mount: mounting smackfs on /sys/fs/smackfs failed: No such file or director=
y
mount: mounting selinuxfs on /sys/fs/selinux failed: No such file or direct=
ory
[   55.667884][ T4449] modprobe (4449) used greatest stack depth: 8080 byte=
s left
[   55.689620][ T4448] mount (4448) used greatest stack depth: 5568 bytes l=
eft
Starting syslogd: OK
Starting acpid: OK
Starting klogd: OK
Running sysctl: OK
Populating /dev using udev: [   59.547215][ T4478] udevd[4478]: starting ve=
rsion 3.2.11
[   63.118863][ T4480] udevd[4480]: starting eudev-3.2.11
[   63.131754][ T4478] udevd (4478) used greatest stack depth: 5216 bytes l=
eft
done
Starting system message bus: done
Starting iptables: OK
Starting network: OK
Starting dhcpcd...
dhcpcd-9.4.1 starting
dev: loaded udev
DUID 00:04:98:24:4c:28:99:7c:d9:70:fe:51:ca:fe:56:33:2c:7d
forked to background, child pid 4692
[  110.662197][ T4693] 8021q: adding VLAN 0 to HW filter on device bond0
[  110.687472][ T4693] eql: remember to turn off Van-Jacobson compression o=
n your slave devices
[  111.699849][  T780] cfg80211: failed to load regulatory.db
Starting sshd: OK


syzkaller

syzkaller login: [  113.995752][    C0] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[  114.003140][    C0] BUG: KMSAN: uninit-value in receive_buf+0x25e3/0x5fd=
0
[  114.010578][    C0]  receive_buf+0x25e3/0x5fd0
[  114.015335][    C0]  virtnet_poll+0xd1c/0x23c0
[  114.020289][    C0]  __napi_poll+0xe7/0x980
[  114.024799][    C0]  net_rx_action+0x82a/0x1850
[  114.029799][    C0]  handle_softirqs+0x1ce/0x800
[  114.034808][    C0]  __irq_exit_rcu+0x68/0x120
[  114.039610][    C0]  irq_exit_rcu+0x12/0x20
[  114.044101][    C0]  common_interrupt+0x94/0xa0
[  114.048999][    C0]  asm_common_interrupt+0x2b/0x40
[  114.054181][    C0]  acpi_safe_halt+0x25/0x30
[  114.058877][    C0]  acpi_idle_do_entry+0x22/0x40
[  114.063885][    C0]  acpi_idle_enter+0xa1/0xc0
[  114.068670][    C0]  cpuidle_enter_state+0xcb/0x250
[  114.073847][    C0]  cpuidle_enter+0x7f/0xf0
[  114.078553][    C0]  do_idle+0x551/0x750
[  114.082755][    C0]  cpu_startup_entry+0x65/0x80
[  114.087599][    C0]  rest_init+0x1e8/0x260
[  114.092032][    C0]  start_kernel+0x92c/0xa70
[  114.096678][    C0]  x86_64_start_reservations+0x2e/0x30
[  114.102462][    C0]  x86_64_start_kernel+0x98/0xa0
[  114.107575][    C0]  common_startup_64+0x12c/0x137
[  114.112751][    C0]=20
[  114.115148][    C0] Uninit was created at:
[  114.119660][    C0]  __alloc_pages_noprof+0x9d6/0xe70
[  114.125021][    C0]  alloc_pages_mpol_noprof+0x299/0x990
[  114.130803][    C0]  alloc_pages_noprof+0x1bf/0x1e0
[  114.136127][    C0]  skb_page_frag_refill+0x2bf/0x7c0
[  114.141580][    C0]  virtnet_rq_alloc+0x43/0xbb0
[  114.146609][    C0]  try_fill_recv+0x3f0/0x2f50
[  114.151581][    C0]  virtnet_open+0x1cc/0xb00
[  114.156245][    C0]  __dev_open+0x546/0x6f0
[  114.160795][    C0]  __dev_change_flags+0x309/0x9a0
[  114.165983][    C0]  dev_change_flags+0x8e/0x1d0
[  114.170953][    C0]  devinet_ioctl+0x13ec/0x22c0
[  114.175904][    C0]  inet_ioctl+0x4bd/0x6d0
[  114.180437][    C0]  sock_do_ioctl+0xb7/0x540
[  114.185091][    C0]  sock_ioctl+0x727/0xd70
[  114.189602][    C0]  __se_sys_ioctl+0x261/0x450
[  114.194696][    C0]  __x64_sys_ioctl+0x96/0xe0
[  114.199487][    C0]  x64_sys_call+0x18c0/0x3b90
[  114.204368][    C0]  do_syscall_64+0xcd/0x1e0
[  114.209064][    C0]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
[  114.215133][    C0]=20
[  114.217511][    C0] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 6.10.0-rc4=
-syzkaller-dirty #0
[  114.226738][    C0] Hardware name: Google Google Compute Engine/Google C=
ompute Engine, BIOS Google 06/07/2024
[  114.236984][    C0] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[  114.244114][    C0] Disabling lock debugging due to kernel taint
[  114.250782][    C0] Kernel panic - not syncing: kmsan.panic set ...
[  114.257250][    C0] CPU: 0 PID: 0 Comm: swapper/0 Tainted: G    B       =
       6.10.0-rc4-syzkaller-dirty #0
[  114.267410][    C0] Hardware name: Google Google Compute Engine/Google C=
ompute Engine, BIOS Google 06/07/2024
[  114.277561][    C0] Call Trace:
[  114.280892][    C0]  <IRQ>
[  114.283786][    C0]  dump_stack_lvl+0x216/0x2d0
[  114.288571][    C0]  ? kmsan_get_shadow_origin_ptr+0x4d/0xb0
[  114.294499][    C0]  dump_stack+0x1e/0x30
[  114.298749][    C0]  panic+0x4e2/0xcd0
[  114.302817][    C0]  ? kmsan_get_metadata+0xb1/0x1d0
[  114.308066][    C0]  kmsan_report+0x2d5/0x2e0
[  114.312721][    C0]  ? kmsan_get_metadata+0x146/0x1d0
[  114.318200][    C0]  ? __msan_warning+0x95/0x120
[  114.323067][    C0]  ? receive_buf+0x25e3/0x5fd0
[  114.327937][    C0]  ? virtnet_poll+0xd1c/0x23c0
[  114.332904][    C0]  ? __napi_poll+0xe7/0x980
[  114.337566][    C0]  ? net_rx_action+0x82a/0x1850
[  114.342539][    C0]  ? handle_softirqs+0x1ce/0x800
[  114.347687][    C0]  ? __irq_exit_rcu+0x68/0x120
[  114.352577][    C0]  ? irq_exit_rcu+0x12/0x20
[  114.357170][    C0]  ? common_interrupt+0x94/0xa0
[  114.362308][    C0]  ? asm_common_interrupt+0x2b/0x40
[  114.367636][    C0]  ? acpi_safe_halt+0x25/0x30
[  114.372535][    C0]  ? acpi_idle_do_entry+0x22/0x40
[  114.377754][    C0]  ? acpi_idle_enter+0xa1/0xc0
[  114.382617][    C0]  ? cpuidle_enter_state+0xcb/0x250
[  114.387914][    C0]  ? cpuidle_enter+0x7f/0xf0
[  114.392631][    C0]  ? do_idle+0x551/0x750
[  114.396963][    C0]  ? cpu_startup_entry+0x65/0x80
[  114.401979][    C0]  ? rest_init+0x1e8/0x260
[  114.406488][    C0]  ? start_kernel+0x92c/0xa70
[  114.411277][    C0]  ? x86_64_start_reservations+0x2e/0x30
[  114.417062][    C0]  ? x86_64_start_kernel+0x98/0xa0
[  114.422838][    C0]  ? common_startup_64+0x12c/0x137
[  114.428096][    C0]  ? kmsan_internal_memmove_metadata+0x17b/0x230
[  114.434850][    C0]  ? kmsan_get_metadata+0x146/0x1d0
[  114.440427][    C0]  ? kmsan_get_metadata+0x146/0x1d0
[  114.446050][    C0]  ? page_to_skb+0xdae/0x1620
[  114.450931][    C0]  ? kmsan_get_metadata+0x146/0x1d0
[  114.456277][    C0]  __msan_warning+0x95/0x120
[  114.460988][    C0]  receive_buf+0x25e3/0x5fd0
[  114.465686][    C0]  ? kmsan_get_metadata+0x146/0x1d0
[  114.471013][    C0]  ? kmsan_get_shadow_origin_ptr+0x4d/0xb0
[  114.477029][    C0]  virtnet_poll+0xd1c/0x23c0
[  114.481755][    C0]  ? __pfx_virtnet_poll+0x10/0x10
[  114.486892][    C0]  __napi_poll+0xe7/0x980
[  114.491329][    C0]  ? kmsan_get_metadata+0x146/0x1d0
[  114.496652][    C0]  net_rx_action+0x82a/0x1850
[  114.501454][    C0]  ? sched_clock_cpu+0x55/0x870
[  114.506415][    C0]  ? __pfx_net_rx_action+0x10/0x10
[  114.511641][    C0]  handle_softirqs+0x1ce/0x800
[  114.516691][    C0]  __irq_exit_rcu+0x68/0x120
[  114.521462][    C0]  irq_exit_rcu+0x12/0x20
[  114.525906][    C0]  common_interrupt+0x94/0xa0
[  114.530773][    C0]  </IRQ>
[  114.533771][    C0]  <TASK>
[  114.536758][    C0]  asm_common_interrupt+0x2b/0x40
[  114.542185][    C0] RIP: 0010:acpi_safe_halt+0x25/0x30
[  114.547620][    C0] Code: 90 90 90 90 90 55 48 89 e5 65 48 8b 04 25 80 5=
e 0a 00 48 f7 00 08 00 00 00 75 10 66 90 0f 00 2d 6b 58 44 00 f3 0f 1e fa f=
b f4 <fa> 5d c3 cc cc cc cc 0f 1f 40 00 90 90 90 90 90 90 90 90 90 90 90
[  114.567621][    C0] RSP: 0018:ffffffff90e03ce8 EFLAGS: 00000246
[  114.573874][    C0] RAX: ffffffff90e2bdc0 RBX: ffffffff91286eb0 RCX: 000=
0000000000001
[  114.581921][    C0] RDX: ffff888103176464 RSI: ffffffff91286eb0 RDI: fff=
f888103176464
[  114.589991][    C0] RBP: ffffffff90e03ce8 R08: ffffea000000000f R09: 000=
00000000000ff
[  114.598071][    C0] R10: ffff88823f173dc2 R11: ffffffff8f790610 R12: fff=
f888106278400
[  114.606347][    C0] R13: ffffffff91286f30 R14: 0000000000000001 R15: 000=
0000000000001
[  114.614502][    C0]  ? __pfx_acpi_idle_enter+0x10/0x10
[  114.620219][    C0]  acpi_idle_do_entry+0x22/0x40
[  114.625320][    C0]  acpi_idle_enter+0xa1/0xc0
[  114.630012][    C0]  cpuidle_enter_state+0xcb/0x250
[  114.635136][    C0]  cpuidle_enter+0x7f/0xf0
[  114.639660][    C0]  do_idle+0x551/0x750
[  114.643814][    C0]  cpu_startup_entry+0x65/0x80
[  114.648680][    C0]  rest_init+0x1e8/0x260
[  114.653022][    C0]  start_kernel+0x92c/0xa70
[  114.657789][    C0]  x86_64_start_reservations+0x2e/0x30
[  114.663371][    C0]  x86_64_start_kernel+0x98/0xa0
[  114.668439][    C0]  common_startup_64+0x12c/0x137
[  114.673688][    C0]  </TASK>
[  114.677305][    C0] Kernel Offset: disabled
[  114.681725][    C0] Rebooting in 86400 seconds..


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
GOVERSION=3D'go1.21.4'
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
 -ffile-prefix-map=3D/tmp/go-build891887690=3D/tmp/go-build -gno-record-gcc=
-switches'

git status (err=3D<nil>)
HEAD detached at ca620dd8f9
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
touch .descriptions
GOOS=3Dlinux GOARCH=3Damd64 go build "-ldflags=3D-s -w -X github.com/google=
/syzkaller/prog.GitRevision=3Dca620dd8f97f5b3a9134b687b5584203019518fb -X '=
github.com/google/syzkaller/prog.gitRevisionDate=3D20240405-142321'" "-tags=
=3Dsyz_target syz_os_linux syz_arch_amd64 " -o ./bin/linux_amd64/syz-fuzzer=
 github.com/google/syzkaller/syz-fuzzer
GOOS=3Dlinux GOARCH=3Damd64 go build "-ldflags=3D-s -w -X github.com/google=
/syzkaller/prog.GitRevision=3Dca620dd8f97f5b3a9134b687b5584203019518fb -X '=
github.com/google/syzkaller/prog.gitRevisionDate=3D20240405-142321'" "-tags=
=3Dsyz_target syz_os_linux syz_arch_amd64 " -o ./bin/linux_amd64/syz-execpr=
og github.com/google/syzkaller/tools/syz-execprog
GOOS=3Dlinux GOARCH=3Damd64 go build "-ldflags=3D-s -w -X github.com/google=
/syzkaller/prog.GitRevision=3Dca620dd8f97f5b3a9134b687b5584203019518fb -X '=
github.com/google/syzkaller/prog.gitRevisionDate=3D20240405-142321'" "-tags=
=3Dsyz_target syz_os_linux syz_arch_amd64 " -o ./bin/linux_amd64/syz-stress=
 github.com/google/syzkaller/tools/syz-stress
mkdir -p ./bin/linux_amd64
gcc -o ./bin/linux_amd64/syz-executor executor/executor.cc \
	-m64 -O2 -pthread -Wall -Werror -Wparentheses -Wunused-const-variable -Wfr=
ame-larger-than=3D16384 -Wno-stringop-overflow -Wno-array-bounds -Wno-forma=
t-overflow -Wno-unused-but-set-variable -Wno-unused-command-line-argument -=
static-pie -fpermissive -w -DGOOS_linux=3D1 -DGOARCH_amd64=3D1 \
	-DHOSTGOOS_linux=3D1 -DGIT_REVISION=3D\"ca620dd8f97f5b3a9134b687b558420301=
9518fb\"


Error text is too large and was truncated, full error text is at:
https://syzkaller.appspot.com/x/error.txt?x=3D17bcf6da980000


Tested on:

commit:         6ba59ff4 Linux 6.10-rc4
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/li=
nux.git
kernel config:  https://syzkaller.appspot.com/x/.config?x=3D95d734ed31cad8a=
0
dashboard link: https://syzkaller.appspot.com/bug?extid=3Dd31185aa54170f7fc=
1f5
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debia=
n) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=3D11bfceda9800=
00


