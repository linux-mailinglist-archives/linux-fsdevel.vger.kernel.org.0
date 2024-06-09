Return-Path: <linux-fsdevel+bounces-21288-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 626239014A9
	for <lists+linux-fsdevel@lfdr.de>; Sun,  9 Jun 2024 07:45:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7FDB0282097
	for <lists+linux-fsdevel@lfdr.de>; Sun,  9 Jun 2024 05:45:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C92813FF6;
	Sun,  9 Jun 2024 05:45:06 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 360BC17545
	for <linux-fsdevel@vger.kernel.org>; Sun,  9 Jun 2024 05:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717911906; cv=none; b=XqoZDMaYnR1MK23GLGV7CGXWDr/uh2JoSpw6DK0/x8+WAl9t2fCbxPDPQZ0nLxHoNbATQOA3XvckmlcpZiIhXmoXTKT/Qh6ih9NmCgrSSVOZljcCWIoFuBdKgxR1aUghMH1Ohm1BhsAbfMAffAo65mg9cGRHM64NT/I5tgO+2uQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717911906; c=relaxed/simple;
	bh=RTzrk6GY1mnljqMb9bYDJF64MmlYIX7pxCDeaLaVoOU=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=t45NLazzCB8IV3//fu64AVxz9G3Veb8iQxE090+DKor+MdydQAboZOnQpe0q4NOAcvKMEjv7zNryOxJW4jJMpxZUi2NdocYho/8EY1fi/pukyOMexZCPzRO/GYP0I51puY6VqSFtU3KtoWbdd6bnleRcZ6ysQV72fTzQEoyme6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-7e212ee8008so409179739f.0
        for <linux-fsdevel@vger.kernel.org>; Sat, 08 Jun 2024 22:45:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717911903; x=1718516703;
        h=content-transfer-encoding:to:from:subject:message-id:in-reply-to
         :date:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yMneK5lFkX4aAU6cmcK9EzLM5jIu4765tBMNtNsXyZc=;
        b=nWbbbze1Z/wnywV2SLc/6wVA4CVrGu4KS3PHUjTFK30PylqWkjqWxc3GMlZTk3QPvv
         NBxZmPj4gu1+mR7704lMNB5hiLdx00tVgrVt7E1RDQNmiXYXAapP/r1GghXqSh4RdVaD
         gbCDlSsaujhRgXM8fPeXX/3oVczKMVbCFgy65Rgv3P+4hnUezJj4+MTc/XTnrUVSWJSQ
         0Yx4YFvFmzidhMidEhh3w+tbGiKsU5px7k80YeYpUeJI8e0lbuyRKr1udKNKUekIsWiV
         +1n8BywqF6ZaMw3h9X0IYj8qU92QLiLBGW4MqTI4Enr7axZBaK7OCVzW4jnGwNMgAFW3
         ledA==
X-Forwarded-Encrypted: i=1; AJvYcCXpuHjVFvBN7kkBdCV4oRNxHgCY4/pQPANDgA3wY9pbprtSc8SkQXeOYWWSP/tLruJPoco7K1tqcns7w/AMdzvLhYPrOiD8px9jZYYYAQ==
X-Gm-Message-State: AOJu0Yz7CZoFt1R586pWsiNgT1mVJ3ESoXye+Wij862erUGLORkmQ2Hj
	RAGLsfywu0VC3l2YD6qERHrXWUyFjF4uX4sLRpR93iZnNJeRAdo1wujD9fT4mdC1ekNTby7Vcnq
	IhzIq/v/g+XBXe9Cqs+ZKszCBFlOGSp8qFwaQs2eOdBKTFg/DRx24loo=
X-Google-Smtp-Source: AGHT+IH/Ex/8FT88Dbal+4QU8eBIEd/ZrNiT574O5+7PxwzevxmM3NZZRUXHI4PgT+WO1xJl5Kc5N+Zi7gAroHh9u2MFmC8kLJ5W
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:248b:b0:488:75e3:f3c5 with SMTP id
 8926c6da1cb9f-4b7b122d444mr97217173.0.1717911903322; Sat, 08 Jun 2024
 22:45:03 -0700 (PDT)
Date: Sat, 08 Jun 2024 22:45:03 -0700
In-Reply-To: <d6923855-5846-4ae7-be6a-ef987ecb9f9c@kernel.org>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c0d2aa061a6e88d0@google.com>
Subject: Re: [syzbot] [hfs?] KMSAN: uninit-value in hfs_revalidate_dentry
From: syzbot <syzbot+3ae6be33a50b5aae4dab@syzkaller.appspotmail.com>
To: chao@kernel.org, glider@google.com, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

  T1] ALSA device list:
[   49.732806][    T1]   #0: Dummy 1
[   49.736413][    T1]   #1: Loopback 1
[   49.740228][    T1]   #2: Virtual MIDI Card 1
[   49.750262][   T10] platform regulatory.0: Direct firmware load for regu=
latory.db failed with error -2
[   49.760115][   T10] platform regulatory.0: Falling back to sysfs fallbac=
k for: regulatory.db
[   49.769557][    T1] md: Waiting for all devices to be available before a=
utodetect
[   49.777447][    T1] md: If you don't use raid, use raid=3Dnoautodetect
[   49.784213][    T1] md: Autodetecting RAID arrays.
[   49.789324][    T1] md: autorun ...
[   49.793191][    T1] md: ... autorun DONE.
[   49.912261][    T1] EXT4-fs (sda1): mounted filesystem 5941fea2-f5fa-4b4=
e-b5ef-9af118b27b95 ro with ordered data mode. Quota mode: none.
[   49.925661][    T1] VFS: Mounted root (ext4 filesystem) readonly on devi=
ce 8:1.
[   49.949100][    T1] devtmpfs: mounted
[   50.204085][    T1] Freeing unused kernel image (initmem) memory: 36920K
[   50.216901][    T1] Write protecting the kernel read-only data: 260096k
[   50.263842][    T1] Freeing unused kernel image (rodata/data gap) memory=
: 1876K
[   51.884629][    T1] x86/mm: Checked W+X mappings: passed, no W+X pages f=
ound.
[   51.895285][    T1] x86/mm: Checking user space page tables
[   53.370836][    T1] x86/mm: Checked W+X mappings: passed, no W+X pages f=
ound.
[   53.379919][    T1] Failed to set sysctl parameter 'kernel.hung_task_all=
_cpu_backtrace=3D1': parameter not found
[   53.401312][    T1] Failed to set sysctl parameter 'max_rcu_stall_to_pan=
ic=3D1': parameter not found
[   53.413335][    T1] Run /sbin/init as init process
[   55.024257][ T4444] mount (4444) used greatest stack depth: 8112 bytes l=
eft
[   55.119469][ T4445] EXT4-fs (sda1): re-mounted 5941fea2-f5fa-4b4e-b5ef-9=
af118b27b95 r/w. Quota mode: none.
mount: mounting smackfs on /sys/fs/smackfs failed: No such file or director=
y
mount: mounting selinuxfs on /sys/fs/selinux failed: No such file or direct=
ory
[   55.460316][ T4448] mount (4448) used greatest stack depth: 5568 bytes l=
eft
Starting syslogd: OK
Starting acpid: OK
Starting klogd: OK
Running sysctl: OK
Populating /dev using udev: [   59.293786][ T4478] udevd[4478]: starting ve=
rsion 3.2.11
[   62.812014][ T4480] udevd[4480]: starting eudev-3.2.11
[   62.823661][ T4478] udevd (4478) used greatest stack depth: 5344 bytes l=
eft
[   96.252561][ T1219] net_ratelimit: 2 callbacks suppressed
[   96.252654][ T1219] aoe: packet could not be sent on lo.  consider incre=
asing tx_queue_len
[   96.267801][ T1219] aoe: packet could not be sent on bond0.  consider in=
creasing tx_queue_len
[   96.276910][ T1219] aoe: packet could not be sent on dummy0.  consider i=
ncreasing tx_queue_len
[   96.286143][ T1219] aoe: packet could not be sent on eql.  consider incr=
easing tx_queue_len
[   96.295161][ T1219] aoe: packet could not be sent on ifb0.  consider inc=
reasing tx_queue_len
[   96.304298][ T1219] aoe: packet could not be sent on ifb1.  consider inc=
reasing tx_queue_len
[   96.313312][ T1219] aoe: packet could not be sent on eth0.  consider inc=
reasing tx_queue_len
[   96.322319][ T1219] aoe: packet could not be sent on wlan0.  consider in=
creasing tx_queue_len
[   96.331822][ T1219] aoe: packet could not be sent on wlan1.  consider in=
creasing tx_queue_len
[   96.341035][ T1219] aoe: packet could not be sent on hwsim0.  consider i=
ncreasing tx_queue_len
done
Starting system message bus: done
Starting iptables: OK
Starting network: OK
Starting dhcpcd...
dhcpcd-9.4.1 starting
dev: loaded udev
DUID 00:04:98:24:4c:28:99:7c:d9:70:fe:51:ca:fe:56:33:2c:7d
forked to background, child pid 4692
[  110.213007][ T4693] 8021q: adding VLAN 0 to HW filter on device bond0
[  110.255329][ T4693] eql: remember to turn off Van-Jacobson compression o=
n your slave devices
Starting sshd: [  111.615530][   T10] cfg80211: failed to load regulatory.d=
b
OK


syzkaller

syzkaller login: [  114.058251][    C0] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[  114.065473][    C0] BUG: KMSAN: uninit-value in receive_buf+0x25e3/0x5fd=
0
[  114.072524][    C0]  receive_buf+0x25e3/0x5fd0
[  114.077324][    C0]  virtnet_poll+0xd1c/0x23c0
[  114.082110][    C0]  __napi_poll+0xe7/0x980
[  114.086745][    C0]  net_rx_action+0x82a/0x1850
[  114.091708][    C0]  handle_softirqs+0x1ce/0x800
[  114.096721][    C0]  __irq_exit_rcu+0x68/0x120
[  114.101495][    C0]  irq_exit_rcu+0x12/0x20
[  114.106116][    C0]  common_interrupt+0x94/0xa0
[  114.111003][    C0]  asm_common_interrupt+0x2b/0x40
[  114.116235][    C0]  virt_to_page_or_null+0x9b/0x150
[  114.121622][    C0]  kmsan_get_metadata+0x146/0x1d0
[  114.126851][    C0]  kmsan_get_shadow_origin_ptr+0x4d/0xb0
[  114.132755][    C0]  __msan_metadata_ptr_for_load_8+0x24/0x40
[  114.138838][    C0]  move_page_tables+0x22aa/0x3940
[  114.144062][    C0]  setup_arg_pages+0x1741/0x1eb0
[  114.149161][    C0]  load_elf_binary+0x186e/0x4e10
[  114.154310][    C0]  bprm_execve+0xc57/0x21c0
[  114.158971][    C0]  do_execveat_common+0xceb/0xd70
[  114.164231][    C0]  __x64_sys_execve+0xf4/0x130
[  114.169182][    C0]  x64_sys_call+0x164f/0x3b90
[  114.174097][    C0]  do_syscall_64+0xcd/0x1e0
[  114.178953][    C0]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
[  114.185159][    C0]=20
[  114.187583][    C0] Uninit was created at:
[  114.191970][    C0]  __alloc_pages_noprof+0x9d6/0xe70
[  114.197429][    C0]  alloc_pages_mpol_noprof+0x299/0x990
[  114.203217][    C0]  alloc_pages_noprof+0x1bf/0x1e0
[  114.208521][    C0]  skb_page_frag_refill+0x2bf/0x7c0
[  114.214331][    C0]  virtnet_rq_alloc+0x43/0xbb0
[  114.219311][    C0]  try_fill_recv+0x3f0/0x2f50
[  114.224213][    C0]  virtnet_open+0x1cc/0xb00
[  114.228892][    C0]  __dev_open+0x546/0x6f0
[  114.233458][    C0]  __dev_change_flags+0x309/0x9a0
[  114.238699][    C0]  dev_change_flags+0x8e/0x1d0
[  114.243670][    C0]  devinet_ioctl+0x13ec/0x22c0
[  114.248707][    C0]  inet_ioctl+0x4bd/0x6d0
[  114.253223][    C0]  sock_do_ioctl+0xb7/0x540
[  114.257877][    C0]  sock_ioctl+0x727/0xd70
[  114.262296][    C0]  __se_sys_ioctl+0x261/0x450
[  114.267163][    C0]  __x64_sys_ioctl+0x96/0xe0
[  114.271913][    C0]  x64_sys_call+0x18c0/0x3b90
[  114.276861][    C0]  do_syscall_64+0xcd/0x1e0
[  114.281557][    C0]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
[  114.287691][    C0]=20
[  114.290142][    C0] CPU: 0 PID: 4810 Comm: cmp Not tainted 6.10.0-rc2-sy=
zkaller-00318-g68af0e6e57f1 #0
[  114.299891][    C0] Hardware name: Google Google Compute Engine/Google C=
ompute Engine, BIOS Google 04/02/2024
[  114.310124][    C0] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[  114.317210][    C0] Disabling lock debugging due to kernel taint
[  114.323590][    C0] Kernel panic - not syncing: kmsan.panic set ...
[  114.330063][    C0] CPU: 0 PID: 4810 Comm: cmp Tainted: G    B          =
    6.10.0-rc2-syzkaller-00318-g68af0e6e57f1 #0
[  114.341090][    C0] Hardware name: Google Google Compute Engine/Google C=
ompute Engine, BIOS Google 04/02/2024
[  114.351224][    C0] Call Trace:
[  114.354569][    C0]  <IRQ>
[  114.357458][    C0]  dump_stack_lvl+0x216/0x2d0
[  114.362339][    C0]  ? kmsan_get_shadow_origin_ptr+0x4d/0xb0
[  114.368256][    C0]  dump_stack+0x1e/0x30
[  114.372558][    C0]  panic+0x4e2/0xcd0
[  114.376579][    C0]  ? kmsan_get_metadata+0xa1/0x1d0
[  114.381828][    C0]  kmsan_report+0x2d5/0x2e0
[  114.386474][    C0]  ? __pfx_min_vruntime_cb_rotate+0x10/0x10
[  114.392494][    C0]  ? kmsan_internal_set_shadow_origin+0x69/0x100
[  114.398930][    C0]  ? kmsan_get_metadata+0x146/0x1d0
[  114.404232][    C0]  ? __msan_warning+0x95/0x120
[  114.409102][    C0]  ? receive_buf+0x25e3/0x5fd0
[  114.413993][    C0]  ? virtnet_poll+0xd1c/0x23c0
[  114.418899][    C0]  ? __napi_poll+0xe7/0x980
[  114.423521][    C0]  ? net_rx_action+0x82a/0x1850
[  114.428495][    C0]  ? handle_softirqs+0x1ce/0x800
[  114.433533][    C0]  ? __irq_exit_rcu+0x68/0x120
[  114.438422][    C0]  ? irq_exit_rcu+0x12/0x20
[  114.443046][    C0]  ? common_interrupt+0x94/0xa0
[  114.448005][    C0]  ? asm_common_interrupt+0x2b/0x40
[  114.453326][    C0]  ? virt_to_page_or_null+0x9b/0x150
[  114.458717][    C0]  ? kmsan_get_metadata+0x146/0x1d0
[  114.464012][    C0]  ? kmsan_get_shadow_origin_ptr+0x4d/0xb0
[  114.469951][    C0]  ? __msan_metadata_ptr_for_load_8+0x24/0x40
[  114.476138][    C0]  ? move_page_tables+0x22aa/0x3940
[  114.481443][    C0]  ? setup_arg_pages+0x1741/0x1eb0
[  114.487208][    C0]  ? load_elf_binary+0x186e/0x4e10
[  114.492542][    C0]  ? bprm_execve+0xc57/0x21c0
[  114.497428][    C0]  ? do_execveat_common+0xceb/0xd70
[  114.502965][    C0]  ? __x64_sys_execve+0xf4/0x130
[  114.508049][    C0]  ? x64_sys_call+0x164f/0x3b90
[  114.513049][    C0]  ? do_syscall_64+0xcd/0x1e0
[  114.517835][    C0]  ? entry_SYSCALL_64_after_hwframe+0x77/0x7f
[  114.524271][    C0]  ? kmsan_internal_memmove_metadata+0x17b/0x230
[  114.530728][    C0]  ? kmsan_get_metadata+0x146/0x1d0
[  114.536028][    C0]  ? kmsan_get_metadata+0x146/0x1d0
[  114.541332][    C0]  ? page_to_skb+0xdae/0x1620
[  114.546091][    C0]  ? kmsan_get_metadata+0x146/0x1d0
[  114.551404][    C0]  __msan_warning+0x95/0x120
[  114.556099][    C0]  receive_buf+0x25e3/0x5fd0
[  114.560811][    C0]  ? kmsan_get_metadata+0x146/0x1d0
[  114.566222][    C0]  ? kmsan_get_shadow_origin_ptr+0x4d/0xb0
[  114.572325][    C0]  virtnet_poll+0xd1c/0x23c0
[  114.577052][    C0]  ? __pfx_virtnet_poll+0x10/0x10
[  114.582192][    C0]  __napi_poll+0xe7/0x980
[  114.586804][    C0]  ? kmsan_get_metadata+0x146/0x1d0
[  114.592127][    C0]  net_rx_action+0x82a/0x1850
[  114.596929][    C0]  ? sched_clock_cpu+0x55/0x870
[  114.601889][    C0]  ? __pfx_net_rx_action+0x10/0x10
[  114.607136][    C0]  handle_softirqs+0x1ce/0x800
[  114.612097][    C0]  __irq_exit_rcu+0x68/0x120
[  114.616825][    C0]  irq_exit_rcu+0x12/0x20
[  114.621255][    C0]  common_interrupt+0x94/0xa0
[  114.626143][    C0]  </IRQ>
[  114.629121][    C0]  <TASK>
[  114.632123][    C0]  asm_common_interrupt+0x2b/0x40
[  114.637277][    C0] RIP: 0010:virt_to_page_or_null+0x9b/0x150
[  114.643734][    C0] Code: d6 48 c1 ee 23 48 8b 34 f1 48 85 f6 74 13 48 8=
9 d1 48 c1 e9 1b 0f b6 c9 48 c1 e1 04 48 01 ce eb 02 31 f6 65 ff 05 ad a1 c=
4 7d <48> 85 f6 74 09 4c 8b 06 41 f6 c0 02 75 17 31 c9 65 ff 0d 96 a1 c4
[  114.663636][    C0] RSP: 0018:ffff888115fa3560 EFLAGS: 00000282
[  114.669801][    C0] RAX: ffff8881a04798b0 RBX: ffff8881204798b0 RCX: 000=
0000000000240
[  114.678046][    C0] RDX: 00000001204798b0 RSI: ffff88813fff9240 RDI: fff=
f8881204798b0
[  114.686097][    C0] RBP: ffff888115fa3560 R08: ffffea000000000f R09: 000=
0000000000000
[  114.694353][    C0] R10: ffff8881157a3588 R11: 0000000000000004 R12: 000=
07ffffffff000
[  114.702427][    C0] R13: ffff88811759ccc0 R14: 0000000000000001 R15: fff=
f8881204798b0
[  114.710503][    C0]  kmsan_get_metadata+0x146/0x1d0
[  114.715665][    C0]  kmsan_get_shadow_origin_ptr+0x4d/0xb0
[  114.721472][    C0]  __msan_metadata_ptr_for_load_8+0x24/0x40
[  114.727581][    C0]  move_page_tables+0x22aa/0x3940
[  114.732810][    C0]  setup_arg_pages+0x1741/0x1eb0
[  114.737898][    C0]  ? kmsan_get_metadata+0x146/0x1d0
[  114.743211][    C0]  ? kmsan_get_metadata+0x146/0x1d0
[  114.748534][    C0]  ? kmsan_internal_set_shadow_origin+0x69/0x100
[  114.754977][    C0]  ? kmsan_get_metadata+0x146/0x1d0
[  114.760321][    C0]  load_elf_binary+0x186e/0x4e10
[  114.765360][    C0]  ? kmsan_get_metadata+0x146/0x1d0
[  114.770982][    C0]  ? kmsan_internal_set_shadow_origin+0x69/0x100
[  114.777440][    C0]  ? kmsan_internal_unpoison_memory+0x14/0x20
[  114.783631][    C0]  ? load_elf_binary+0x1331/0x4e10
[  114.788932][    C0]  ? kmsan_get_metadata+0x146/0x1d0
[  114.794247][    C0]  ? __pfx_load_elf_binary+0x10/0x10
[  114.799718][    C0]  bprm_execve+0xc57/0x21c0
[  114.804338][    C0]  do_execveat_common+0xceb/0xd70
[  114.809485][    C0]  __x64_sys_execve+0xf4/0x130
[  114.814370][    C0]  x64_sys_call+0x164f/0x3b90
[  114.819190][    C0]  do_syscall_64+0xcd/0x1e0
[  114.823875][    C0]  ? clear_bhb_loop+0x25/0x80
[  114.828744][    C0]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
[  114.834741][    C0] RIP: 0033:0x7febec525ef7
[  114.839238][    C0] Code: Unable to access opcode bytes at 0x7febec525ec=
d.
[  114.846321][    C0] RSP: 002b:00007ffee08c4918 EFLAGS: 00000246 ORIG_RAX=
: 000000000000003b
[  114.855113][    C0] RAX: ffffffffffffffda RBX: 000055e293558020 RCX: 000=
07febec525ef7
[  114.863169][    C0] RDX: 000055e293558048 RSI: 000055e293558020 RDI: 000=
055e2935580d0
[  114.871237][    C0] RBP: 000055e2935580d0 R08: 000055e2935580d9 R09: 000=
07ffee08c8ecb
[  114.879289][    C0] R10: 0000000000000008 R11: 0000000000000246 R12: 000=
055e293558048
[  114.887358][    C0] R13: 00007febec6d3904 R14: 000055e293558048 R15: 000=
0000000000000
[  114.895462][    C0]  </TASK>
[  114.898839][    C0] Kernel Offset: disabled
[  114.903237][    C0] Rebooting in 86400 seconds..


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
 -ffile-prefix-map=3D/tmp/go-build3593741732=3D/tmp/go-build -gno-record-gc=
c-switches'

git status (err=3D<nil>)
HEAD detached at 25905f5d0a
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
/syzkaller/prog.GitRevision=3D25905f5d0a2a7883bd33491997556193582c6059 -X '=
github.com/google/syzkaller/prog.gitRevisionDate=3D20240301-171218'" "-tags=
=3Dsyz_target syz_os_linux syz_arch_amd64 " -o ./bin/linux_amd64/syz-fuzzer=
 github.com/google/syzkaller/syz-fuzzer
GOOS=3Dlinux GOARCH=3Damd64 go build "-ldflags=3D-s -w -X github.com/google=
/syzkaller/prog.GitRevision=3D25905f5d0a2a7883bd33491997556193582c6059 -X '=
github.com/google/syzkaller/prog.gitRevisionDate=3D20240301-171218'" "-tags=
=3Dsyz_target syz_os_linux syz_arch_amd64 " -o ./bin/linux_amd64/syz-execpr=
og github.com/google/syzkaller/tools/syz-execprog
GOOS=3Dlinux GOARCH=3Damd64 go build "-ldflags=3D-s -w -X github.com/google=
/syzkaller/prog.GitRevision=3D25905f5d0a2a7883bd33491997556193582c6059 -X '=
github.com/google/syzkaller/prog.gitRevisionDate=3D20240301-171218'" "-tags=
=3Dsyz_target syz_os_linux syz_arch_amd64 " -o ./bin/linux_amd64/syz-stress=
 github.com/google/syzkaller/tools/syz-stress
mkdir -p ./bin/linux_amd64
gcc -o ./bin/linux_amd64/syz-executor executor/executor.cc \
	-m64 -O2 -pthread -Wall -Werror -Wparentheses -Wunused-const-variable -Wfr=
ame-larger-than=3D16384 -Wno-stringop-overflow -Wno-array-bounds -Wno-forma=
t-overflow -Wno-unused-but-set-variable -Wno-unused-command-line-argument -=
static-pie -fpermissive -w -DGOOS_linux=3D1 -DGOARCH_amd64=3D1 \
	-DHOSTGOOS_linux=3D1 -DGIT_REVISION=3D\"25905f5d0a2a7883bd3349199755619358=
2c6059\"


Error text is too large and was truncated, full error text is at:
https://syzkaller.appspot.com/x/error.txt?x=3D16a96dce980000


Tested on:

commit:         68af0e6e hfs: fix to initialize fields of hfs_inode_in..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/chao/linux.=
git misc
kernel config:  https://syzkaller.appspot.com/x/.config?x=3Db7d07bfd0c305fe=
4
dashboard link: https://syzkaller.appspot.com/bug?extid=3D3ae6be33a50b5aae4=
dab
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debia=
n) 2.40

Note: no patches were applied.

