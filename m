Return-Path: <linux-fsdevel+bounces-51793-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BC899ADB7CA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Jun 2025 19:28:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A3B03AC949
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Jun 2025 17:28:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1ED0288C3F;
	Mon, 16 Jun 2025 17:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dWjWw14f"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94707288C39;
	Mon, 16 Jun 2025 17:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750094918; cv=none; b=Izlb849QfAZWX3vr6zXMiLEE6rnSOF2oEj9mcSVPp77s+/TE7QNUaQA9/6Qyqvg7aE3tBXIh7Y1ssk7YVXVGyB3h1/1PNsvuNUwNUv7kqMquF05qNe1RFMpT4siUQldtdn9ZGfmC6FdoYGuPaV+qtR9HBlEY1Zj/AbTpvNQagCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750094918; c=relaxed/simple;
	bh=2Fbs6UMkQ9LcOk+ZOuO2Bk/T2mvT2zwnK3wJafFmDS4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M6f2KX92GPBhZJhQhteKaBd2cPOOujGxOOMtSAiubhcIsL8ZoKMJchoclg0chHnmChWe9wuCdwoUmg9aeMKfOfbiwbKT1NKXB+m4HyyiBFR12EkSoQobiXVKD/QgWSc6TWo8R8Fw2HffIz8h0wihfsBaTd0ZvV2U7Tt5ElWVk+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dWjWw14f; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-3105ef2a071so48876161fa.1;
        Mon, 16 Jun 2025 10:28:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750094912; x=1750699712; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5P3XUO4NNnSeLKs5ZQzNZZ5e09Cc0dVJga4AGJGzk0s=;
        b=dWjWw14fZZMRMmYu6GWrKp3FnV4s+yf/fSQHJkoYnahy2t5pau2oebJN5cG56ntf2I
         9gd5Vn3XMW7LgnbjzaWqncQe2UMZRh0hWwHA9mxmNcGBqWPlnSyuPeC3h4dZZ62JeqKI
         VjyZWTnsJ8TCtNJNC1X8EC7jcFAADtG6qVn8meKIPWKTBweDuucg4CACztP6UCvF9ise
         tESO4yyFKVSx/g3OgXLkrbaFsqX7B8kCbjoFAt7Q224V/YPzTfpqnM/lxzyLd16L0ckN
         8pTR36ATwfoUbr2pQZbpo2oIbjlMIVShVCNNijn3eeGdTQYXWfqKPyGYdRF12v2bbWAr
         Rmsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750094912; x=1750699712;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5P3XUO4NNnSeLKs5ZQzNZZ5e09Cc0dVJga4AGJGzk0s=;
        b=Wp+n3jU8cFI7rhhOFItbJah8Z+Xl0mUuWBErlxOi2VrT7wLCNIRo4UhhO/0hquBL53
         gl8Awj33x19uqDe/BeEojJJnqVDaRwMsGw9jdWtoFsYOEPswwI8iZv955jnzHEMY8iY5
         bR5pv/pzzDDtTIQSUGpxcQjywwcvgiun5HL0zbljngrz73iAudlkBoG7ql0Mr5wzPQNJ
         DeTYMQH/eKxmFWSYKLEL4N2hX/pwSz0ZOxXtUjMgUpdn+3OuQAjuA2eWF/S1aqJKLpM3
         uJkw+ERxDr3dCsPhEsuvtH3OfyUh3vF//67r9nXy0yh0/J3vQg/qMWastuRSv0OVj06i
         SP3g==
X-Forwarded-Encrypted: i=1; AJvYcCVBlHULhpKffV+koEXdeJqHpTC3cDFi87Xg7uTUnOsbZWBLjdWhIxqPHm2BlN3jCRRxiocweywzZyYJupWA@vger.kernel.org, AJvYcCVrJUOBMvYsJqVPPI/lqFvVohATFgDVVWDE2hbStNJvpCihDvWh+lcqbmW7kSeNlg/BJBTdBGVVkbHFXCaf+w==@vger.kernel.org, AJvYcCX/ulh6W5ivDsWbCxzQIVv86EyTYIoO0VJRUAtsr2YKqn/E0fIFxe+UwxkFqHgK1M01djUxzC3EQZdR@vger.kernel.org
X-Gm-Message-State: AOJu0Yxdcjj7WpsVAzJFZAA22v0q0KQtt5jWS8ZZ/0t33wqFtNT2Rdev
	CaV3Jz+R1r3IZ341pIZbOTj0+bjCGD9zvpvwGh5FrI5wJJ9/oxUvRPdMy398cnSij2gzgUZqGaa
	6b/VSPIdrHPOCsjWHVEUqGjxJEkOGjGE=
X-Gm-Gg: ASbGnctHyBWLPeUvsa8o+bwAI1tj79wt52qU0/WWMo0st+MHMCRMaBzknXMgSlzc1jy
	OJCvPpK8rHDNEHZA4/l9/X6YJxVF41s8A8xQ8HbbCwmaMEt5J0m42MCFjwQ1B0U7MdzCMfkyl7N
	Xf5LxtHP3wNqHjL4lAbCE6vFDAhKlnmSJh7E6f4fyuwindZPxj1wcdPM4BC/rhd0dbHM3bHRoaG
	m3Zzg==
X-Google-Smtp-Source: AGHT+IFG0XsAhEg8+2EFMozHZqFiv0ZETjTIbvQ3YmmC+Ou4LQB236L0B+HP7HJfThNrHwxPpcWReTpsjET8WlQDUt4=
X-Received: by 2002:a2e:bc15:0:b0:32a:7122:58cc with SMTP id
 38308e7fff4ca-32b4a2e24cbmr27024401fa.6.1750094911066; Mon, 16 Jun 2025
 10:28:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <583792.1750073757@warthog.procyon.org.uk>
In-Reply-To: <583792.1750073757@warthog.procyon.org.uk>
From: Steve French <smfrench@gmail.com>
Date: Mon, 16 Jun 2025 12:28:20 -0500
X-Gm-Features: AX0GCFuV9qXrcTguzoBEApNTukdItQgqH1Dr_eEEAB12GXt7_RTTvq4kVk3gsIg
Message-ID: <CAH2r5mtyeRX=AKRoY7tBJOaMtcLUxfBB5yRLqJWq2O=jaziURg@mail.gmail.com>
Subject: Re: [PATCH] netfs: Fix hang due to missing case in final DIO read
 result collection
To: David Howells <dhowells@redhat.com>
Cc: Steve French <sfrench@samba.org>, Paulo Alcantara <pc@manguebit.org>, linux-cifs@vger.kernel.org, 
	netfs@lists.linux.dev, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Saw this crash with the patch when it got to generic/013 xfstest:

[ 1253.228233] CIFS: VFS: cifs_revalidate_mapping: invalidate inode
00000000d618b07c failed with rc -5
[ 1260.800723] watchdog: BUG: soft lockup - CPU#5 stuck for 26s!
[fsstress:31998]
[ 1260.800732] Modules linked in: cifs(E) cmac(E) nls_utf8(E)
cifs_arc4(E) nls_ucs2_utils(E) cifs_md4(E) rpcsec_gss_krb5(E)
auth_rpcgss(E) nfsv4(E) dns_resolver(E) nfs(E) lockd(E) grace(E)
netfs(E) nf_conntrack_
netbios_ns(E) nf_conntrack_broadcast(E) nft_fib_inet(E)
nft_fib_ipv4(E) nft_fib_ipv6(E) nft_fib(E) nft_reject_inet(E)
nf_reject_ipv4(E) nf_reject_ipv6(E) nft_reject(E) nft_ct(E)
nft_chain_nat(E) nf_tables(E) ebt
able_nat(E) ebtable_broute(E) ip6table_nat(E) ip6table_mangle(E)
ip6table_raw(E) ip6table_security(E) iptable_nat(E) nf_nat(E)
nf_conntrack(E) nf_defrag_ipv6(E) nf_defrag_ipv4(E) iptable_mangle(E)
iptable_raw(E)
 iptable_security(E) ip_set(E) ebtable_filter(E) ebtables(E)
ip6table_filter(E) ip6_tables(E) iptable_filter(E) ip_tables(E)
sunrpc(E) kvm_intel(E) kvm(E) irqbypass(E) virtio_net(E)
virtio_balloon(E) net_failove
r(E) failover(E) fuse(E) loop(E) dm_multipath(E) nfnetlink(E) zram(E)
xfs(E) bochs(E) drm_client_lib(E) drm_shmem_helper(E)
drm_kms_helper(E) ghash_clmulni_intel(E) sha512_ssse3(E) floppy(E)
[ 1260.800879]  sha1_ssse3(E) virtio_blk(E) drm(E) qemu_fw_cfg(E)
virtio_console(E) [last unloaded: cifs(E)]
[ 1260.800889] irq event stamp: 127589062
[ 1260.800892] hardirqs last  enabled at (127589061):
[<ffffffffba969e81>] _raw_spin_unlock_irqrestore+0x31/0x60
[ 1260.800915] hardirqs last disabled at (127589062):
[<ffffffffba95175f>] sysvec_apic_timer_interrupt+0xf/0x90
[ 1260.800921] softirqs last  enabled at (127443248):
[<ffffffffb93252f5>] __irq_exit_rcu+0x135/0x160
[ 1260.800927] softirqs last disabled at (127443231):
[<ffffffffb93252f5>] __irq_exit_rcu+0x135/0x160
[ 1260.800936] CPU: 5 UID: 0 PID: 31998 Comm: fsstress Tainted: G
      E       6.16.0-rc2 #1 PREEMPT(voluntary)
[ 1260.800942] Tainted: [E]=3DUNSIGNED_MODULE
[ 1260.800944] Hardware name: Red Hat KVM, BIOS 1.16.3-4.el9 04/01/2014
[ 1260.800946] RIP: 0010:_raw_spin_unlock_irqrestore+0x37/0x60
[ 1260.800951] Code: 48 83 c7 18 53 48 89 f3 48 8b 74 24 10 e8 d1 f3
a9 fe 48 89 ef e8 a9 2d aa fe 80 e7 02 74 0b e8 ff b6 c2 fe fb 0f 1f
44 00 00 <65> ff 0d a2 b1 47 02 74 07 5b 5d e9 49 2d 00 00 0f 1f 44 00
00
 5b
[ 1260.800955] RSP: 0018:ff1100011afefbe8 EFLAGS: 00000206
[ 1260.800958] RAX: 00000000079adac5 RBX: 0000000000000246 RCX: 00000000000=
00080
[ 1260.800961] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffffffffba9=
69e81
[ 1260.800963] RBP: ff1100011b0ad0a8 R08: 0000000000000001 R09: 00000000000=
00001
[ 1260.800966] R10: ffffffffbbfe44e7 R11: 0000000000000000 R12: ff1100011b0=
ad0a8
[ 1260.800968] R13: 1fe22000235fdf80 R14: ffffffffc1350c80 R15: ff1100011b0=
ad1c8
[ 1260.800970] FS:  00007f45a913cc40(0000) GS:ff1100050e4c3000(0000)
knlGS:0000000000000000
[ 1260.800973] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 1260.800976] CR2: 00007faaa9cd3380 CR3: 0000000109c93004 CR4: 00000000003=
73ef0
[ 1260.800984] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 00000000000=
00000
[ 1260.800987] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 00000000000=
00400
[ 1260.800989] Call Trace:
[ 1260.800993]  <TASK>
[ 1260.801002]  netfs_wait_for_pause+0xc5/0x1a0 [netfs]
[ 1260.801052]  ? __pfx_netfs_wait_for_pause+0x10/0x10 [netfs]
[ 1260.801092]  ? __pfx_autoremove_wake_function+0x10/0x10
[ 1260.801100]  ? iov_iter_advance+0x170/0x280
[ 1260.801108]  netfs_unbuffered_write+0xe6/0x120 [netfs]
[ 1260.801153]  netfs_unbuffered_write_iter_locked+0x42f/0x550 [netfs]
[ 1260.801193]  netfs_unbuffered_write_iter+0x21d/0x360 [netfs]
[ 1260.801233]  ? __pfx_netfs_file_write_iter+0x10/0x10 [netfs]
[ 1260.801269]  vfs_write+0x5c6/0x7b0
[ 1260.801277]  ? __fget_files+0x31/0x1f0
[ 1260.801283]  ? __pfx_vfs_write+0x10/0x10
[ 1260.801289]  ? __rcu_read_unlock+0x6f/0x2a0
[ 1260.801298]  ? fdget_pos+0x126/0x170
[ 1260.801304]  ksys_write+0xb6/0x140
[ 1260.801309]  ? __pfx_ksys_write+0x10/0x10
[ 1260.801313]  ? irqtime_account_irq+0xaf/0x100
[ 1260.801321]  do_syscall_64+0x75/0x3a0
[ 1260.801326]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[ 1260.801330] RIP: 0033:0x7f45a924c984
[ 1260.801338] Code: c7 00 16 00 00 00 b8 ff ff ff ff c3 66 2e 0f 1f
84 00 00 00 00 00 f3 0f 1e fa 80 3d c5 06 0e 00 00 74 13 b8 01 00 00
00 0f 05 <48> 3d 00 f0 ff ff 77 54 c3 0f 1f 00 55 48 89 e5 48 83 ec 20
48
 89
[ 1260.801341] RSP: 002b:00007fff9b2e3f78 EFLAGS: 00000202 ORIG_RAX:
0000000000000001
[ 1260.801344] RAX: ffffffffffffffda RBX: 0000000000000004 RCX: 00007f45a92=
4c984
[ 1260.801346] RDX: 0000000000100000 RSI: 000000000db00000 RDI: 00000000000=
00004
[ 1260.801348] RBP: 0000000000000327 R08: 0000000000083570 R09: 00000000000=
00001
[ 1260.801351] R10: 0000000000000004 R11: 0000000000000202 R12: 00000000003=
00000
[ 1260.801353] R13: 0000000000100000 R14: 000000000db00000 R15: 00000000000=
00000
[ 1260.801364]  </TASK>
[ 1288.800844] watchdog: BUG: soft lockup - CPU#5 stuck for 52s!
[fsstress:31998]
[ 1288.800851] Modules linked in: cifs(E) cmac(E) nls_utf8(E)
cifs_arc4(E) nls_ucs2_utils(E) cifs_md4(E) rpcsec_gss_krb5(E)
auth_rpcgss(E) nfsv4(E) dns_resolver(E) nfs(E) lockd(E) grace(E)
netfs(E) nf_conntrack_
netbios_ns(E) nf_conntrack_broadcast(E) nft_fib_inet(E)
nft_fib_ipv4(E) nft_fib_ipv6(E) nft_fib(E) nft_reject_inet(E)
nf_reject_ipv4(E) nf_reject_ipv6(E) nft_reject(E) nft_ct(E)
nft_chain_nat(E) nf_tables(E) ebt
able_nat(E) ebtable_broute(E) ip6table_nat(E) ip6table_mangle(E)
ip6table_raw(E) ip6table_security(E) iptable_nat(E) nf_nat(E)
nf_conntrack(E) nf_defrag_ipv6(E) nf_defrag_ipv4(E) iptable_mangle(E)
iptable_raw(E)
 iptable_security(E) ip_set(E) ebtable_filter(E) ebtables(E)
ip6table_filter(E) ip6_tables(E) iptable_filter(E) ip_tables(E)
sunrpc(E) kvm_intel(E) kvm(E) irqbypass(E) virtio_net(E)
virtio_balloon(E) net_failove
r(E) failover(E) fuse(E) loop(E) dm_multipath(E) nfnetlink(E) zram(E)
xfs(E) bochs(E) drm_client_lib(E) drm_shmem_helper(E)
drm_kms_helper(E) ghash_clmulni_intel(E) sha512_ssse3(E) floppy(E)
[ 1288.800956]  sha1_ssse3(E) virtio_blk(E) drm(E) qemu_fw_cfg(E)
virtio_console(E) [last unloaded: cifs(E)]
[ 1288.800965] irq event stamp: 271218830
[ 1288.800969] hardirqs last  enabled at (271218829):
[<ffffffffba969e81>] _raw_spin_unlock_irqrestore+0x31/0x60
[ 1288.800980] hardirqs last disabled at (271218830):
[<ffffffffba95175f>] sysvec_apic_timer_interrupt+0xf/0x90
[ 1288.800987] softirqs last  enabled at (270990108):
[<ffffffffb93252f5>] __irq_exit_rcu+0x135/0x160
[ 1288.800993] softirqs last disabled at (270990087):
[<ffffffffb93252f5>] __irq_exit_rcu+0x135/0x160
[ 1288.801000] CPU: 5 UID: 0 PID: 31998 Comm: fsstress Tainted: G
      EL      6.16.0-rc2 #1 PREEMPT(voluntary)
[ 1288.801007] Tainted: [E]=3DUNSIGNED_MODULE, [L]=3DSOFTLOCKUP
[ 1288.801009] Hardware name: Red Hat KVM, BIOS 1.16.3-4.el9 04/01/2014
[ 1288.801011] RIP: 0010:netfs_write_collection+0x21f/0x17b0 [netfs]
[ 1288.801061] Code: 24 a8 00 00 00 48 89 44 24 20 48 8d 7b 15 e8 d8
1f 52 f8 48 63 44 24 38 48 8d 04 40 48 c1 e0 05 48 03 44 24 10 48 89
44 24 30 <0f> b6 80 3d 01 00 00 84 c0 0f 85 1f 01 00 00 48 83 44 24 18
60
 48
[ 1288.801065] RSP: 0018:ff1100011afefab0 EFLAGS: 00000286
[ 1288.801069] RAX: ff1100011b0acec0 RBX: ff1100011b0acfe8 RCX: ffffffffc13=
50e88
[ 1288.801071] RDX: 1fe22000236159ff RSI: 0000000000000008 RDI: ff1100011b0=
acffd
[ 1288.801074] RBP: ff1100011b0acec0 R08: 0000000000000000 R09: ffe21c00236=
15a28
[ 1288.801076] R10: ff1100011b0ad147 R11: 0000000000000000 R12: ff1100011b0=
acec0
[ 1288.801079] R13: ff1100011b0acfd0 R14: ff1100011b0ad180 R15: 00000000000=
00000
[ 1288.801081] FS:  00007f45a913cc40(0000) GS:ff1100050e4c3000(0000)
knlGS:0000000000000000
[ 1288.801084] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 1288.801086] CR2: 00007faaa9cd3380 CR3: 0000000109c93004 CR4: 00000000003=
73ef0
[ 1288.801096] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 00000000000=
00000
[ 1288.801098] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 00000000000=
00400
[ 1288.801100] Call Trace:
[ 1288.801103]  <TASK>
[ 1288.801120]  ? __pfx_netfs_write_collection+0x10/0x10 [netfs]
[ 1288.801161]  netfs_collect_in_app+0x12f/0x2c0 [netfs]
[ 1288.801203]  ? __pfx_netfs_write_collection+0x10/0x10 [netfs]
[ 1288.801245]  netfs_wait_for_pause+0x148/0x1a0 [netfs]
[ 1288.801284]  ? __pfx_netfs_wait_for_pause+0x10/0x10 [netfs]
[ 1288.801323]  ? __pfx_autoremove_wake_function+0x10/0x10
[ 1288.801330]  ? iov_iter_advance+0x170/0x280
[ 1288.801338]  netfs_unbuffered_write+0xe6/0x120 [netfs]
[ 1288.801381]  netfs_unbuffered_write_iter_locked+0x42f/0x550 [netfs]
[ 1288.801423]  netfs_unbuffered_write_iter+0x21d/0x360 [netfs]
[ 1288.801462]  ? __pfx_netfs_file_write_iter+0x10/0x10 [netfs]
[ 1288.801498]  vfs_write+0x5c6/0x7b0
[ 1288.801506]  ? __fget_files+0x31/0x1f0
[ 1288.801511]  ? __pfx_vfs_write+0x10/0x10
[ 1288.801517]  ? __rcu_read_unlock+0x6f/0x2a0
[ 1288.801526]  ? fdget_pos+0x126/0x170
[ 1288.801532]  ksys_write+0xb6/0x140
[ 1288.801537]  ? __pfx_ksys_write+0x10/0x10
[ 1288.801541]  ? irqtime_account_irq+0xaf/0x100
[ 1288.801549]  do_syscall_64+0x75/0x3a0
[ 1288.801554]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[ 1288.801559] RIP: 0033:0x7f45a924c984
[ 1288.801563] Code: c7 00 16 00 00 00 b8 ff ff ff ff c3 66 2e 0f 1f
84 00 00 00 00 00 f3 0f 1e fa 80 3d c5 06 0e 00 00 74 13 b8 01 00 00
00 0f 05 <48> 3d 00 f0 ff ff 77 54 c3 0f 1f 00 55 48 89 e5 48 83 ec 20
48
 89
[ 1288.801566] RSP: 002b:00007fff9b2e3f78 EFLAGS: 00000202 ORIG_RAX:
0000000000000001
[ 1288.801570] RAX: ffffffffffffffda RBX: 0000000000000004 RCX: 00007f45a92=
4c984
[ 1288.801572] RDX: 0000000000100000 RSI: 000000000db00000 RDI: 00000000000=
00004
[ 1288.801574] RBP: 0000000000000327 R08: 0000000000083570 R09: 00000000000=
00001
[ 1288.801576] R10: 0000000000000004 R11: 0000000000000202 R12: 00000000003=
00000
[ 1288.801578] R13: 0000000000100000 R14: 000000000db00000 R15: 00000000000=
00000
[ 1288.801589]  </TASK>
[ 1316.800973] watchdog: BUG: soft lockup - CPU#5 stuck for 78s!
[fsstress:31998]
[ 1316.800984] Modules linked in: cifs(E) cmac(E) nls_utf8(E)
cifs_arc4(E) nls_ucs2_utils(E) cifs_md4(E) rpcsec_gss_krb5(E)
auth_rpcgss(E) nfsv4(E) dns_resolver(E) nfs(E) lockd(E) grace(E)
netfs(E) nf_conntrack_
netbios_ns(E) nf_conntrack_broadcast(E) nft_fib_inet(E)
nft_fib_ipv4(E) nft_fib_ipv6(E) nft_fib(E) nft_reject_inet(E)
nf_reject_ipv4(E) nf_reject_ipv6(E) nft_reject(E) nft_ct(E)
nft_chain_nat(E) nf_tables(E) ebt
able_nat(E) ebtable_broute(E) ip6table_nat(E) ip6table_mangle(E)
ip6table_raw(E) ip6table_security(E) iptable_nat(E) nf_nat(E)
nf_conntrack(E) nf_defrag_ipv6(E) nf_defrag_ipv4(E) iptable_mangle(E)
iptable_raw(E)
 iptable_security(E) ip_set(E) ebtable_filter(E) ebtables(E)
ip6table_filter(E) ip6_tables(E) iptable_filter(E) ip_tables(E)
sunrpc(E) kvm_intel(E) kvm(E) irqbypass(E) virtio_net(E)
virtio_balloon(E) net_failove
r(E) failover(E) fuse(E) loop(E) dm_multipath(E) nfnetlink(E) zram(E)
xfs(E) bochs(E) drm_client_lib(E) drm_shmem_helper(E)
drm_kms_helper(E) ghash_clmulni_intel(E) sha512_ssse3(E) floppy(E)
[ 1316.801102]  sha1_ssse3(E) virtio_blk(E) drm(E) qemu_fw_cfg(E)
virtio_console(E) [last unloaded: cifs(E)]
[ 1316.801112] irq event stamp: 414737210
[ 1316.801115] hardirqs last  enabled at (414737209):
[<ffffffffba969e81>] _raw_spin_unlock_irqrestore+0x31/0x60
[ 1316.801127] hardirqs last disabled at (414737210):
[<ffffffffba95175f>] sysvec_apic_timer_interrupt+0xf/0x90
[ 1316.801133] softirqs last  enabled at (414508978):
[<ffffffffb93252f5>] __irq_exit_rcu+0x135/0x160
[ 1316.801139] softirqs last disabled at (414508957):
[<ffffffffb93252f5>] __irq_exit_rcu+0x135/0x160
[ 1316.801147] CPU: 5 UID: 0 PID: 31998 Comm: fsstress Tainted: G
      EL      6.16.0-rc2 #1 PREEMPT(voluntary)
[ 1316.801154] Tainted: [E]=3DUNSIGNED_MODULE, [L]=3DSOFTLOCKUP
[ 1316.801156] Hardware name: Red Hat KVM, BIOS 1.16.3-4.el9 04/01/2014
[ 1316.801158] RIP: 0010:_raw_spin_unlock_irqrestore+0x37/0x60
[ 1316.801163] Code: 48 83 c7 18 53 48 89 f3 48 8b 74 24 10 e8 d1 f3
a9 fe 48 89 ef e8 a9 2d aa fe 80 e7 02 74 0b e8 ff b6 c2 fe fb 0f 1f
44 00 00 <65> ff 0d a2 b1 47 02 74 07 5b 5d e9 49 2d 00 00 0f 1f 44 00
00
 5b
[ 1316.801167] RSP: 0018:ff1100011afefbe8 EFLAGS: 00000206
[ 1316.801170] RAX: 0000000018b86339 RBX: 0000000000000246 RCX: 00000000000=
00080
[ 1316.801172] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffffffffba9=
69e81
[ 1316.801175] RBP: ff1100011b0ad0a8 R08: 0000000000000001 R09: 00000000000=
00001
[ 1316.801177] R10: ffffffffbbfe44e7 R11: 0000000000000000 R12: ff1100011b0=
ad0a8
[ 1316.801179] R13: 1fe22000235fdf80 R14: ffffffffc1350c80 R15: ff1100011b0=
ad1c8
[ 1316.801181] FS:  00007f45a913cc40(0000) GS:ff1100050e4c3000(0000)
knlGS:0000000000000000
[ 1316.801184] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 1316.801187] CR2: 00007faaa9cd3380 CR3: 0000000109c93004 CR4: 00000000003=
73ef0
[ 1316.801195] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 00000000000=
00000
[ 1316.801197] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 00000000000=
00400
[ 1316.801199] Call Trace:
[ 1316.801201]  <TASK>
[ 1316.801211]  netfs_wait_for_pause+0xc5/0x1a0 [netfs]
[ 1316.801262]  ? __pfx_netfs_wait_for_pause+0x10/0x10 [netfs]
[ 1316.801304]  ? __pfx_autoremove_wake_function+0x10/0x10
[ 1316.801311]  ? iov_iter_advance+0x170/0x280
[ 1316.801319]  netfs_unbuffered_write+0xe6/0x120 [netfs]
[ 1316.801364]  netfs_unbuffered_write_iter_locked+0x42f/0x550 [netfs]
[ 1316.801407]  netfs_unbuffered_write_iter+0x21d/0x360 [netfs]
[ 1316.801449]  ? __pfx_netfs_file_write_iter+0x10/0x10 [netfs]
[ 1316.801485]  vfs_write+0x5c6/0x7b0
[ 1316.801492]  ? __fget_files+0x31/0x1f0
[ 1316.801497]  ? __pfx_vfs_write+0x10/0x10
[ 1316.801504]  ? __rcu_read_unlock+0x6f/0x2a0
[ 1316.801514]  ? fdget_pos+0x126/0x170
[ 1316.801520]  ksys_write+0xb6/0x140
[ 1316.801525]  ? __pfx_ksys_write+0x10/0x10
[ 1316.801530]  ? irqtime_account_irq+0xaf/0x100
[ 1316.801538]  do_syscall_64+0x75/0x3a0
[ 1316.801544]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[ 1316.801548] RIP: 0033:0x7f45a924c984
[ 1316.801556] Code: c7 00 16 00 00 00 b8 ff ff ff ff c3 66 2e 0f 1f
84 00 00 00 00 00 f3 0f 1e fa 80 3d c5 06 0e 00 00 74 13 b8 01 00 00
00 0f 05 <48> 3d 00 f0 ff ff 77 54 c3 0f 1f 00 55 48 89 e5 48 83 ec 20
48
 89
[ 1316.801559] RSP: 002b:00007fff9b2e3f78 EFLAGS: 00000202 ORIG_RAX:
0000000000000001
[ 1316.801563] RAX: ffffffffffffffda RBX: 0000000000000004 RCX: 00007f45a92=
4c984
[ 1316.801566] RDX: 0000000000100000 RSI: 000000000db00000 RDI: 00000000000=
00004
[ 1316.801568] RBP: 0000000000000327 R08: 0000000000083570 R09: 00000000000=
00001
[ 1316.801570] R10: 0000000000000004 R11: 0000000000000202 R12: 00000000003=
00000
[ 1316.801573] R13: 0000000000100000 R14: 000000000db00000 R15: 00000000000=
00000
[ 1316.801584]  </TASK>
[ 1344.801100] watchdog: BUG: soft lockup - CPU#5 stuck for 104s!
[fsstress:31998]
[ 1344.801108] Modules linked in: cifs(E) cmac(E) nls_utf8(E)
cifs_arc4(E) nls_ucs2_utils(E) cifs_md4(E) rpcsec_gss_krb5(E)
auth_rpcgss(E) nfsv4(E) dns_resolver(E) nfs(E) lockd(E) grace(E)
netfs(E) nf_conntrack_
netbios_ns(E) nf_conntrack_broadcast(E) nft_fib_inet(E)
nft_fib_ipv4(E) nft_fib_ipv6(E) nft_fib(E) nft_reject_inet(E)
nf_reject_ipv4(E) nf_reject_ipv6(E) nft_reject(E) nft_ct(E)
nft_chain_nat(E) nf_tables(E) ebt
able_nat(E) ebtable_broute(E) ip6table_nat(E) ip6table_mangle(E)
ip6table_raw(E) ip6table_security(E) iptable_nat(E) nf_nat(E)
nf_conntrack(E) nf_defrag_ipv6(E) nf_defrag_ipv4(E) iptable_mangle(E)
iptable_raw(E)
 iptable_security(E) ip_set(E) ebtable_filter(E) ebtables(E)
ip6table_filter(E) ip6_tables(E) iptable_filter(E) ip_tables(E)
sunrpc(E) kvm_intel(E) kvm(E) irqbypass(E) virtio_net(E)
virtio_balloon(E) net_failove
r(E) failover(E) fuse(E) loop(E) dm_multipath(E) nfnetlink(E) zram(E)
xfs(E) bochs(E) drm_client_lib(E) drm_shmem_helper(E)
drm_kms_helper(E) ghash_clmulni_intel(E) sha512_ssse3(E) floppy(E)
[ 1344.801202]  sha1_ssse3(E) virtio_blk(E) drm(E) qemu_fw_cfg(E)
virtio_console(E) [last unloaded: cifs(E)]
[ 1344.801221] irq event stamp: 558050720
[ 1344.801224] hardirqs last  enabled at (558050719):
[<ffffffffba969e81>] _raw_spin_unlock_irqrestore+0x31/0x60
[ 1344.801236] hardirqs last disabled at (558050720):
[<ffffffffba95175f>] sysvec_apic_timer_interrupt+0xf/0x90
[ 1344.801242] softirqs last  enabled at (557822314):
[<ffffffffb93252f5>] __irq_exit_rcu+0x135/0x160
[ 1344.801248] softirqs last disabled at (557822293):
[<ffffffffb93252f5>] __irq_exit_rcu+0x135/0x160
[ 1344.801255] CPU: 5 UID: 0 PID: 31998 Comm: fsstress Tainted: G
      EL      6.16.0-rc2 #1 PREEMPT(voluntary)
[ 1344.801262] Tainted: [E]=3DUNSIGNED_MODULE, [L]=3DSOFTLOCKUP
[ 1344.801263] Hardware name: Red Hat KVM, BIOS 1.16.3-4.el9 04/01/2014
[ 1344.801266] RIP: 0010:_raw_spin_unlock_irqrestore+0x37/0x60
[ 1344.801271] Code: 48 83 c7 18 53 48 89 f3 48 8b 74 24 10 e8 d1 f3
a9 fe 48 89 ef e8 a9 2d aa fe 80 e7 02 74 0b e8 ff b6 c2 fe fb 0f 1f
44 00 00 <65> ff 0d a2 b1 47 02 74 07 5b 5d e9 49 2d 00 00 0f 1f 44 00
00
 5b
[ 1344.801275] RSP: 0018:ff1100011afefbe8 EFLAGS: 00000206
[ 1344.801278] RAX: 0000000021432d9f RBX: 0000000000000246 RCX: 00000000000=
00080
[ 1344.801281] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffffffffba9=
69e81
[ 1344.801283] RBP: ff1100011b0ad0a8 R08: 0000000000000001 R09: 00000000000=
00001
[ 1344.801285] R10: ffffffffbbfe44e7 R11: 0000000000000000 R12: ff1100011b0=
ad0a8
[ 1344.801287] R13: 1fe22000235fdf80 R14: ffffffffc1350c80 R15: ff1100011b0=
ad1c8
[ 1344.801290] FS:  00007f45a913cc40(0000) GS:ff1100050e4c3000(0000)
knlGS:0000000000000000
[ 1344.801292] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 1344.801295] CR2: 00007faaa9cd3380 CR3: 0000000109c93004 CR4: 00000000003=
73ef0
[ 1344.801303] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 00000000000=
00000
[ 1344.801305] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 00000000000=
00400
[ 1344.801307] Call Trace:
[ 1344.801310]  <TASK>
[ 1344.801316]  netfs_wait_for_pause+0xc5/0x1a0 [netfs]
[ 1344.801366]  ? __pfx_netfs_wait_for_pause+0x10/0x10 [netfs]
[ 1344.801405]  ? __pfx_autoremove_wake_function+0x10/0x10
[ 1344.801412]  ? iov_iter_advance+0x170/0x280
[ 1344.801420]  netfs_unbuffered_write+0xe6/0x120 [netfs]
[ 1344.801465]  netfs_unbuffered_write_iter_locked+0x42f/0x550 [netfs]
[ 1344.801505]  netfs_unbuffered_write_iter+0x21d/0x360 [netfs]
[ 1344.801546]  ? __pfx_netfs_file_write_iter+0x10/0x10 [netfs]
[ 1344.801583]  vfs_write+0x5c6/0x7b0
[ 1344.801590]  ? __fget_files+0x31/0x1f0
[ 1344.801595]  ? __pfx_vfs_write+0x10/0x10
[ 1344.801601]  ? __rcu_read_unlock+0x6f/0x2a0
[ 1344.801610]  ? fdget_pos+0x126/0x170
[ 1344.801616]  ksys_write+0xb6/0x140
[ 1344.801621]  ? __pfx_ksys_write+0x10/0x10
[ 1344.801626]  ? irqtime_account_irq+0xaf/0x100
[ 1344.801633]  do_syscall_64+0x75/0x3a0
[ 1344.801639]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[ 1344.801643] RIP: 0033:0x7f45a924c984
[ 1344.801649] Code: c7 00 16 00 00 00 b8 ff ff ff ff c3 66 2e 0f 1f
84 00 00 00 00 00 f3 0f 1e fa 80 3d c5 06 0e 00 00 74 13 b8 01 00 00
00 0f 05 <48> 3d 00 f0 ff ff 77 54 c3 0f 1f 00 55 48 89 e5 48 83 ec 20
48
 89
[ 1344.801652] RSP: 002b:00007fff9b2e3f78 EFLAGS: 00000202 ORIG_RAX:
0000000000000001
[ 1344.801655] RAX: ffffffffffffffda RBX: 0000000000000004 RCX: 00007f45a92=
4c984
[ 1344.801657] RDX: 0000000000100000 RSI: 000000000db00000 RDI: 00000000000=
00004
[ 1344.801659] RBP: 0000000000000327 R08: 0000000000083570 R09: 00000000000=
00001
[ 1344.801662] R10: 0000000000000004 R11: 0000000000000202 R12: 00000000003=
00000
[ 1344.801664] R13: 0000000000100000 R14: 000000000db00000 R15: 00000000000=
00000
[ 1344.801675]  </TASK>
[ 1372.801226] watchdog: BUG: soft lockup - CPU#5 stuck for 130s!
[fsstress:31998]
[ 1372.801233] Modules linked in: cifs(E) cmac(E) nls_utf8(E)
cifs_arc4(E) nls_ucs2_utils(E) cifs_md4(E) rpcsec_gss_krb5(E)
auth_rpcgss(E) nfsv4(E) dns_resolver(E) nfs(E) lockd(E) grace(E)
netfs(E) nf_conntrack_
netbios_ns(E) nf_conntrack_broadcast(E) nft_fib_inet(E)
nft_fib_ipv4(E) nft_fib_ipv6(E) nft_fib(E) nft_reject_inet(E)
nf_reject_ipv4(E) nf_reject_ipv6(E) nft_reject(E) nft_ct(E)
nft_chain_nat(E) nf_tables(E) ebt
able_nat(E) ebtable_broute(E) ip6table_nat(E) ip6table_mangle(E)
ip6table_raw(E) ip6table_security(E) iptable_nat(E) nf_nat(E)
nf_conntrack(E) nf_defrag_ipv6(E) nf_defrag_ipv4(E) iptable_mangle(E)
iptable_raw(E)
 iptable_security(E) ip_set(E) ebtable_filter(E) ebtables(E)
ip6table_filter(E) ip6_tables(E) iptable_filter(E) ip_tables(E)
sunrpc(E) kvm_intel(E) kvm(E) irqbypass(E) virtio_net(E)
virtio_balloon(E) net_failove
r(E) failover(E) fuse(E) loop(E) dm_multipath(E) nfnetlink(E) zram(E)
xfs(E) bochs(E) drm_client_lib(E) drm_shmem_helper(E)
drm_kms_helper(E) ghash_clmulni_intel(E) sha512_ssse3(E) floppy(E)
[ 1372.801337]  sha1_ssse3(E) virtio_blk(E) drm(E) qemu_fw_cfg(E)
virtio_console(E) [last unloaded: cifs(E)]
[ 1372.801346] irq event stamp: 700625230
[ 1372.801349] hardirqs last  enabled at (700625229):
[<ffffffffba969e81>] _raw_spin_unlock_irqrestore+0x31/0x60
[ 1372.801369] hardirqs last disabled at (700625230):
[<ffffffffba95175f>] sysvec_apic_timer_interrupt+0xf/0x90
[ 1372.801375] softirqs last  enabled at (700396446):
[<ffffffffb93252f5>] __irq_exit_rcu+0x135/0x160
[ 1372.801382] softirqs last disabled at (700396425):
[<ffffffffb93252f5>] __irq_exit_rcu+0x135/0x160
[ 1372.801389] CPU: 5 UID: 0 PID: 31998 Comm: fsstress Tainted: G
      EL      6.16.0-rc2 #1 PREEMPT(voluntary)
[ 1372.801396] Tainted: [E]=3DUNSIGNED_MODULE, [L]=3DSOFTLOCKUP
[ 1372.801398] Hardware name: Red Hat KVM, BIOS 1.16.3-4.el9 04/01/2014
[ 1372.801400] RIP: 0010:_raw_spin_unlock_irqrestore+0x37/0x60
[ 1372.801406] Code: 48 83 c7 18 53 48 89 f3 48 8b 74 24 10 e8 d1 f3
a9 fe 48 89 ef e8 a9 2d aa fe 80 e7 02 74 0b e8 ff b6 c2 fe fb 0f 1f
44 00 00 <65> ff 0d a2 b1 47 02 74 07 5b 5d e9 49 2d 00 00 0f 1f 44 00
00
 5b
[ 1372.801409] RSP: 0018:ff1100011afefbe8 EFLAGS: 00000206
[ 1372.801412] RAX: 0000000029c2b14d RBX: 0000000000000246 RCX: 00000000000=
00080
[ 1372.801415] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffffffffba9=
69e81
[ 1372.801417] RBP: ff1100011b0ad0a8 R08: 0000000000000001 R09: 00000000000=
00001
[ 1372.801419] R10: ffffffffbbfe44e7 R11: 0000000000000000 R12: ff1100011b0=
ad0a8
[ 1372.801421] R13: 1fe22000235fdf80 R14: ffffffffc1350c80 R15: ff1100011b0=
ad1c8
[ 1372.801424] FS:  00007f45a913cc40(0000) GS:ff1100050e4c3000(0000)
knlGS:0000000000000000
[ 1372.801427] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 1372.801429] CR2: 00007faaa9cd3380 CR3: 0000000109c93004 CR4: 00000000003=
73ef0
[ 1372.801437] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 00000000000=
00000
[ 1372.801439] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 00000000000=
00400
[ 1372.801441] Call Trace:
[ 1372.801444]  <TASK>
[ 1372.801450]  netfs_wait_for_pause+0xc5/0x1a0 [netfs]
[ 1372.801500]  ? __pfx_netfs_wait_for_pause+0x10/0x10 [netfs]
[ 1372.801542]  ? __pfx_autoremove_wake_function+0x10/0x10
[ 1372.801549]  ? iov_iter_advance+0x170/0x280
[ 1372.801557]  netfs_unbuffered_write+0xe6/0x120 [netfs]
[ 1372.801604]  netfs_unbuffered_write_iter_locked+0x42f/0x550 [netfs]
[ 1372.801647]  netfs_unbuffered_write_iter+0x21d/0x360 [netfs]
[ 1372.801687]  ? __pfx_netfs_file_write_iter+0x10/0x10 [netfs]
[ 1372.801723]  vfs_write+0x5c6/0x7b0
[ 1372.801730]  ? __fget_files+0x31/0x1f0
[ 1372.801735]  ? __pfx_vfs_write+0x10/0x10
[ 1372.801741]  ? __rcu_read_unlock+0x6f/0x2a0
[ 1372.801751]  ? fdget_pos+0x126/0x170
[ 1372.801757]  ksys_write+0xb6/0x140
[ 1372.801762]  ? __pfx_ksys_write+0x10/0x10
[ 1372.801767]  ? irqtime_account_irq+0xaf/0x100
[ 1372.801775]  do_syscall_64+0x75/0x3a0
[ 1372.801780]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[ 1372.801785] RIP: 0033:0x7f45a924c984
[ 1372.801791] Code: c7 00 16 00 00 00 b8 ff ff ff ff c3 66 2e 0f 1f
84 00 00 00 00 00 f3 0f 1e fa 80 3d c5 06 0e 00 00 74 13 b8 01 00 00
00 0f 05 <48> 3d 00 f0 ff ff 77 54 c3 0f 1f 00 55 48 89 e5 48 83 ec 20
48
 89
[ 1372.801794] RSP: 002b:00007fff9b2e3f78 EFLAGS: 00000202 ORIG_RAX:
0000000000000001
[ 1372.801798] RAX: ffffffffffffffda RBX: 0000000000000004 RCX: 00007f45a92=
4c984
[ 1372.801800] RDX: 0000000000100000 RSI: 000000000db00000 RDI: 00000000000=
00004
[ 1372.801802] RBP: 0000000000000327 R08: 0000000000083570 R09: 00000000000=
00001
[ 1372.801804] R10: 0000000000000004 R11: 0000000000000202 R12: 00000000003=
00000
[ 1372.801807] R13: 0000000000100000 R14: 000000000db00000 R15: 00000000000=
00000
[ 1372.801818]  </TASK>
[ 1400.801350] watchdog: BUG: soft lockup - CPU#5 stuck for 156s!
[fsstress:31998]
[ 1400.801358] Modules linked in: cifs(E) cmac(E) nls_utf8(E)
cifs_arc4(E) nls_ucs2_utils(E) cifs_md4(E) rpcsec_gss_krb5(E)
auth_rpcgss(E) nfsv4(E) dns_resolver(E) nfs(E) lockd(E) grace(E)
netfs(E) nf_conntrack_
netbios_ns(E) nf_conntrack_broadcast(E) nft_fib_inet(E)
nft_fib_ipv4(E) nft_fib_ipv6(E) nft_fib(E) nft_reject_inet(E)
nf_reject_ipv4(E) nf_reject_ipv6(E) nft_reject(E) nft_ct(E)
nft_chain_nat(E) nf_tables(E) ebt
able_nat(E) ebtable_broute(E) ip6table_nat(E) ip6table_mangle(E)
ip6table_raw(E) ip6table_security(E) iptable_nat(E) nf_nat(E)
nf_conntrack(E) nf_defrag_ipv6(E) nf_defrag_ipv4(E) iptable_mangle(E)
iptable_raw(E)
 iptable_security(E) ip_set(E) ebtable_filter(E) ebtables(E)
ip6table_filter(E) ip6_tables(E) iptable_filter(E) ip_tables(E)
sunrpc(E) kvm_intel(E) kvm(E) irqbypass(E) virtio_net(E)
virtio_balloon(E) net_failove
r(E) failover(E) fuse(E) loop(E) dm_multipath(E) nfnetlink(E) zram(E)
xfs(E) bochs(E) drm_client_lib(E) drm_shmem_helper(E)
drm_kms_helper(E) ghash_clmulni_intel(E) sha512_ssse3(E) floppy(E)
[ 1400.801483]  sha1_ssse3(E) virtio_blk(E) drm(E) qemu_fw_cfg(E)
virtio_console(E) [last unloaded: cifs(E)]
[ 1400.801493] irq event stamp: 843953346
[ 1400.801504] hardirqs last  enabled at (843953345):
[<ffffffffba969e81>] _raw_spin_unlock_irqrestore+0x31/0x60
[ 1400.801516] hardirqs last disabled at (843953346):
[<ffffffffba95175f>] sysvec_apic_timer_interrupt+0xf/0x90
[ 1400.801523] softirqs last  enabled at (843735034):
[<ffffffffb93252f5>] __irq_exit_rcu+0x135/0x160
[ 1400.801528] softirqs last disabled at (843735013):
[<ffffffffb93252f5>] __irq_exit_rcu+0x135/0x160
[ 1400.801536] CPU: 5 UID: 0 PID: 31998 Comm: fsstress Tainted: G
      EL      6.16.0-rc2 #1 PREEMPT(voluntary)
[ 1400.801543] Tainted: [E]=3DUNSIGNED_MODULE, [L]=3DSOFTLOCKUP
[ 1400.801544] Hardware name: Red Hat KVM, BIOS 1.16.3-4.el9 04/01/2014
[ 1400.801547] RIP: 0010:_raw_spin_unlock_irqrestore+0x37/0x60
[ 1400.801552] Code: 48 83 c7 18 53 48 89 f3 48 8b 74 24 10 e8 d1 f3
a9 fe 48 89 ef e8 a9 2d aa fe 80 e7 02 74 0b e8 ff b6 c2 fe fb 0f 1f
44 00 00 <65> ff 0d a2 b1 47 02 74 07 5b 5d e9 49 2d 00 00 0f 1f 44 00
00
 5b
[ 1400.801555] RSP: 0018:ff1100011afefbe8 EFLAGS: 00000202
[ 1400.801559] RAX: 00000000324db4c1 RBX: 0000000000000246 RCX: 00000000000=
00080
[ 1400.801561] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffffffffba9=
69e81
[ 1400.801564] RBP: ff1100011b0ad0a8 R08: 0000000000000001 R09: 00000000000=
00001
[ 1400.801566] R10: ffffffffbbfe44e7 R11: 0000000000000000 R12: ff1100011b0=
ad0a8
[ 1400.801568] R13: 1fe22000235fdf80 R14: ffffffffc1350c80 R15: ff1100011b0=
ad1c8
[ 1400.801571] FS:  00007f45a913cc40(0000) GS:ff1100050e4c3000(0000)
knlGS:0000000000000000
[ 1400.801573] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 1400.801576] CR2: 00007faaa9cd3380 CR3: 0000000109c93004 CR4: 00000000003=
73ef0
[ 1400.801585] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 00000000000=
00000
[ 1400.801587] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 00000000000=
00400
[ 1400.801589] Call Trace:
[ 1400.801594]  <TASK>
[ 1400.801605]  netfs_wait_for_pause+0xc5/0x1a0 [netfs]
[ 1400.801656]  ? __pfx_netfs_wait_for_pause+0x10/0x10 [netfs]
[ 1400.801696]  ? __pfx_autoremove_wake_function+0x10/0x10
[ 1400.801703]  ? iov_iter_advance+0x170/0x280
[ 1400.801711]  netfs_unbuffered_write+0xe6/0x120 [netfs]
[ 1400.801755]  netfs_unbuffered_write_iter_locked+0x42f/0x550 [netfs]
[ 1400.801796]  netfs_unbuffered_write_iter+0x21d/0x360 [netfs]
[ 1400.801837]  ? __pfx_netfs_file_write_iter+0x10/0x10 [netfs]
[ 1400.801873]  vfs_write+0x5c6/0x7b0
[ 1400.801881]  ? __fget_files+0x31/0x1f0
[ 1400.801886]  ? __pfx_vfs_write+0x10/0x10
[ 1400.801892]  ? __rcu_read_unlock+0x6f/0x2a0
[ 1400.801901]  ? fdget_pos+0x126/0x170
[ 1400.801907]  ksys_write+0xb6/0x140
[ 1400.801912]  ? __pfx_ksys_write+0x10/0x10
[ 1400.801916]  ? irqtime_account_irq+0xaf/0x100
[ 1400.801924]  do_syscall_64+0x75/0x3a0
[ 1400.801929]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[ 1400.801933] RIP: 0033:0x7f45a924c984
[ 1400.801940] Code: c7 00 16 00 00 00 b8 ff ff ff ff c3 66 2e 0f 1f
84 00 00 00 00 00 f3 0f 1e fa 80 3d c5 06 0e 00 00 74 13 b8 01 00 00
00 0f 05 <48> 3d 00 f0 ff ff 77 54 c3 0f 1f 00 55 48 89 e5 48 83 ec 20
48
 89
[ 1400.801943] RSP: 002b:00007fff9b2e3f78 EFLAGS: 00000202 ORIG_RAX:
0000000000000001
[ 1400.801947] RAX: ffffffffffffffda RBX: 0000000000000004 RCX: 00007f45a92=
4c984
[ 1400.801949] RDX: 0000000000100000 RSI: 000000000db00000 RDI: 00000000000=
00004
[ 1400.801951] RBP: 0000000000000327 R08: 0000000000083570 R09: 00000000000=
00001
[ 1400.801953] R10: 0000000000000004 R11: 0000000000000202 R12: 00000000003=
00000
[ 1400.801955] R13: 0000000000100000 R14: 000000000db00000 R15: 00000000000=
00000
[ 1400.801967]  </TASK>
[ 1428.801470] watchdog: BUG: soft lockup - CPU#5 stuck for 182s!
[fsstress:31998]
[ 1428.801476] Modules linked in: cifs(E) cmac(E) nls_utf8(E)
cifs_arc4(E) nls_ucs2_utils(E) cifs_md4(E) rpcsec_gss_krb5(E)
auth_rpcgss(E) nfsv4(E) dns_resolver(E) nfs(E) lockd(E) grace(E)
netfs(E) nf_conntrack_
netbios_ns(E) nf_conntrack_broadcast(E) nft_fib_inet(E)
nft_fib_ipv4(E) nft_fib_ipv6(E) nft_fib(E) nft_reject_inet(E)
nf_reject_ipv4(E) nf_reject_ipv6(E) nft_reject(E) nft_ct(E)
nft_chain_nat(E) nf_tables(E) ebt
able_nat(E) ebtable_broute(E) ip6table_nat(E) ip6table_mangle(E)
ip6table_raw(E) ip6table_security(E) iptable_nat(E) nf_nat(E)
nf_conntrack(E) nf_defrag_ipv6(E) nf_defrag_ipv4(E) iptable_mangle(E)
iptable_raw(E)
 iptable_security(E) ip_set(E) ebtable_filter(E) ebtables(E)
ip6table_filter(E) ip6_tables(E) iptable_filter(E) ip_tables(E)
sunrpc(E) kvm_intel(E) kvm(E) irqbypass(E) virtio_net(E)
virtio_balloon(E) net_failove
r(E) failover(E) fuse(E) loop(E) dm_multipath(E) nfnetlink(E) zram(E)
xfs(E) bochs(E) drm_client_lib(E) drm_shmem_helper(E)
drm_kms_helper(E) ghash_clmulni_intel(E) sha512_ssse3(E) floppy(E)
[ 1428.801589]  sha1_ssse3(E) virtio_blk(E) drm(E) qemu_fw_cfg(E)
virtio_console(E) [last unloaded: cifs(E)]
[ 1428.801598] irq event stamp: 987603758
[ 1428.801601] hardirqs last  enabled at (987603757):
[<ffffffffba969e81>] _raw_spin_unlock_irqrestore+0x31/0x60
[ 1428.801612] hardirqs last disabled at (987603758):
[<ffffffffba95175f>] sysvec_apic_timer_interrupt+0xf/0x90
[ 1428.801618] softirqs last  enabled at (987384786):
[<ffffffffb93252f5>] __irq_exit_rcu+0x135/0x160
[ 1428.801624] softirqs last disabled at (987384765):
[<ffffffffb93252f5>] __irq_exit_rcu+0x135/0x160
[ 1428.801631] CPU: 5 UID: 0 PID: 31998 Comm: fsstress Tainted: G
      EL      6.16.0-rc2 #1 PREEMPT(voluntary)
[ 1428.801637] Tainted: [E]=3DUNSIGNED_MODULE, [L]=3DSOFTLOCKUP
[ 1428.801648] Hardware name: Red Hat KVM, BIOS 1.16.3-4.el9 04/01/2014
[ 1428.801650] RIP: 0010:__asan_load8+0x2e/0xa0
[ 1428.801657] Code: 48 8b 0c 24 48 83 ff f8 73 63 0f 1f 44 00 00 48
b8 00 00 00 00 00 00 00 ff eb 0a 48 b8 00 00 00 00 00 80 ff ff 48 39
c7 72 43 <48> 8d 47 07 48 89 c2 83 e2 07 48 83 fa 07 75 1b 48 ba 00 00
00
 00
[ 1428.801660] RSP: 0018:ff1100011afefaa8 EFLAGS: 00000202
[ 1428.801663] RAX: ff00000000000000 RBX: ff1100011b0acfe8 RCX: ffffffffc13=
50fe0
[ 1428.801666] RDX: 1fe22000236159ff RSI: 0000000000000008 RDI: ff1100011b0=
acfe0
[ 1428.801669] RBP: ff1100011b0acec0 R08: 0000000000000000 R09: ffe21c00236=
15a28
[ 1428.801671] R10: ff1100011b0ad147 R11: 0000000000000000 R12: ff1100011b0=
acec0
[ 1428.801673] R13: ff1100011b0acfd0 R14: ff1100011b0ad180 R15: 00000000000=
00000
[ 1428.801675] FS:  00007f45a913cc40(0000) GS:ff1100050e4c3000(0000)
knlGS:0000000000000000
[ 1428.801678] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 1428.801681] CR2: 00007faaa9cd3380 CR3: 0000000109c93004 CR4: 00000000003=
73ef0
[ 1428.801688] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 00000000000=
00000
[ 1428.801690] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 00000000000=
00400
[ 1428.801692] Call Trace:
[ 1428.801695]  <TASK>
[ 1428.801699]  netfs_write_collection+0x360/0x17b0 [netfs]
[ 1428.801764]  ? __pfx_netfs_write_collection+0x10/0x10 [netfs]
[ 1428.801808]  netfs_collect_in_app+0x12f/0x2c0 [netfs]
[ 1428.801850]  ? __pfx_netfs_write_collection+0x10/0x10 [netfs]
[ 1428.801891]  netfs_wait_for_pause+0x148/0x1a0 [netfs]
[ 1428.801932]  ? __pfx_netfs_wait_for_pause+0x10/0x10 [netfs]
[ 1428.801973]  ? __pfx_autoremove_wake_function+0x10/0x10
[ 1428.801981]  ? iov_iter_advance+0x170/0x280
[ 1428.801988]  netfs_unbuffered_write+0xe6/0x120 [netfs]
[ 1428.802033]  netfs_unbuffered_write_iter_locked+0x42f/0x550 [netfs]
[ 1428.802074]  netfs_unbuffered_write_iter+0x21d/0x360 [netfs]
[ 1428.802114]  ? __pfx_netfs_file_write_iter+0x10/0x10 [netfs]
[ 1428.802150]  vfs_write+0x5c6/0x7b0
[ 1428.802157]  ? __fget_files+0x31/0x1f0
[ 1428.802162]  ? __pfx_vfs_write+0x10/0x10
[ 1428.802168]  ? __rcu_read_unlock+0x6f/0x2a0
[ 1428.802178]  ? fdget_pos+0x126/0x170
[ 1428.802185]  ksys_write+0xb6/0x140
[ 1428.802190]  ? __pfx_ksys_write+0x10/0x10
[ 1428.802194]  ? irqtime_account_irq+0xaf/0x100
[ 1428.802204]  do_syscall_64+0x75/0x3a0
[ 1428.802210]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[ 1428.802214] RIP: 0033:0x7f45a924c984
[ 1428.802218] Code: c7 00 16 00 00 00 b8 ff ff ff ff c3 66 2e 0f 1f
84 00 00 00 00 00 f3 0f 1e fa 80 3d c5 06 0e 00 00 74 13 b8 01 00 00
00 0f 05 <48> 3d 00 f0 ff ff 77 54 c3 0f 1f 00 55 48 89 e5 48 83 ec 20
48
 89
[ 1428.802221] RSP: 002b:00007fff9b2e3f78 EFLAGS: 00000202 ORIG_RAX:
0000000000000001
[ 1428.802225] RAX: ffffffffffffffda RBX: 0000000000000004 RCX: 00007f45a92=
4c984
[ 1428.802227] RDX: 0000000000100000 RSI: 000000000db00000 RDI: 00000000000=
00004
[ 1428.802230] RBP: 0000000000000327 R08: 0000000000083570 R09: 00000000000=
00001
[ 1428.802232] R10: 0000000000000004 R11: 0000000000000202 R12: 00000000003=
00000
[ 1428.802234] R13: 0000000000100000 R14: 000000000db00000 R15: 00000000000=
00000
[ 1428.802245]  </TASK>
[ 1443.559211] CIFS: VFS: \\ has not responded in 180 seconds. Reconnecting=
...
[ 1443.559239] CIFS: VFS: \\ has not responded in 180 seconds. Reconnecting=
...
[ 1443.601751] CIFS: VFS: generate_smb3signingkey: dumping generated
AES session keys
[ 1443.601769] CIFS: VFS: Session Id    91 02 00 fc bd c8 b2 00
[ 1443.601775] CIFS: VFS: Cipher type   2
[ 1443.601780] CIFS: VFS: Session Key   f2 c3 13 66 05 50 7c 63 1e d1
a5 e6 61 5a 1b 71
[ 1443.601785] CIFS: VFS: Signing Key   b0 3a b7 3d 1b 38 19 bd f6 56
ad d7 b6 68 65 dd
[ 1443.601790] CIFS: VFS: ServerIn Key  97 a9 03 cf 0e 89 b6 c2 7f 7f
8e e3 e3 7f 97 f7
[ 1443.601794] CIFS: VFS: ServerOut Key 98 7c b8 c5 a8 a8 3b 12 3e d3
7f f3 d4 77 78 90
[ 1443.602240] CIFS: VFS: reconnect tcon failed rc =3D -11
[ 1443.605121] CIFS: VFS:
\\linuxsmb3testsharesmc.file.core.windows.net\IPC$ error -11 on ioctl
to get interface list
[ 1443.605156] ------------[ cut here ]------------
[ 1443.605160] WARNING: CPU: 0 PID: 32107 at kernel/workqueue.c:2498
__queue_delayed_work+0x1e3/0x200
[ 1443.605170] Modules linked in: cifs(E) cmac(E) nls_utf8(E)
cifs_arc4(E) nls_ucs2_utils(E) cifs_md4(E) rpcsec_gss_krb5(E)
auth_rpcgss(E) nfsv4(E) dns_resolver(E) nfs(E) lockd(E) grace(E)
netfs(E) nf_conntrack_
netbios_ns(E) nf_conntrack_broadcast(E) nft_fib_inet(E)
nft_fib_ipv4(E) nft_fib_ipv6(E) nft_fib(E) nft_reject_inet(E)
nf_reject_ipv4(E) nf_reject_ipv6(E) nft_reject(E) nft_ct(E)
nft_chain_nat(E) nf_tables(E) ebt
able_nat(E) ebtable_broute(E) ip6table_nat(E) ip6table_mangle(E)
ip6table_raw(E) ip6table_security(E) iptable_nat(E) nf_nat(E)
nf_conntrack(E) nf_defrag_ipv6(E) nf_defrag_ipv4(E) iptable_mangle(E)
iptable_raw(E)
 iptable_security(E) ip_set(E) ebtable_filter(E) ebtables(E)
ip6table_filter(E) ip6_tables(E) iptable_filter(E) ip_tables(E)
sunrpc(E) kvm_intel(E) kvm(E) irqbypass(E) virtio_net(E)
virtio_balloon(E) net_failove
r(E) failover(E) fuse(E) loop(E) dm_multipath(E) nfnetlink(E) zram(E)
xfs(E) bochs(E) drm_client_lib(E) drm_shmem_helper(E)
drm_kms_helper(E) ghash_clmulni_intel(E) sha512_ssse3(E) floppy(E)
[ 1443.605329]  sha1_ssse3(E) virtio_blk(E) drm(E) qemu_fw_cfg(E)
virtio_console(E) [last unloaded: cifs(E)]
[ 1443.605349] CPU: 0 UID: 0 PID: 32107 Comm: kworker/0:18 Tainted: G
          EL      6.16.0-rc2 #1 PREEMPT(voluntary)
[ 1443.605357] Tainted: [E]=3DUNSIGNED_MODULE, [L]=3DSOFTLOCKUP
[ 1443.605360] Hardware name: Red Hat KVM, BIOS 1.16.3-4.el9 04/01/2014
[ 1443.605364] Workqueue: cifsiod smb2_reconnect_server [cifs]
[ 1443.605536] RIP: 0010:__queue_delayed_work+0x1e3/0x200
[ 1443.605542] Code: 5d 41 5c 41 5d 41 5e 41 5f e9 09 ef ff ff 0f 0b
e9 59 ff ff ff bf 02 00 00 00 e8 28 df 09 00 89 c5 eb bf 0f 0b e9 45
fe ff ff <0f> 0b e9 57 fe ff ff 0f 0b e9 68 fe ff ff 0f 0b e9 7c fe ff
ff
 44
[ 1443.605547] RSP: 0018:ff1100010a0b7b40 EFLAGS: 00010003
[ 1443.605553] RAX: 0000000000000000 RBX: 00000000000927c0 RCX: ffffffffb93=
5a3e2
[ 1443.605557] RDX: dffffc0000000000 RSI: ff11000126f29400 RDI: ff11000130b=
5e9a8
[ 1443.605561] RBP: ff11000126f29400 R08: 0000000000000000 R09: ffe21c00261=
6bd29
[ 1443.605564] R10: ff11000130b5e94f R11: 0000000000000000 R12: ff11000130b=
5e948
[ 1443.605568] R13: 0000000000002000 R14: 00000000000927c0 R15: ff11000130b=
5e990
[ 1443.605572] FS:  0000000000000000(0000) GS:ff1100050e243000(0000)
knlGS:0000000000000000
[ 1443.605576] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 1443.605580] CR2: 00007f2c017fcd60 CR3: 000000010f93d002 CR4: 00000000003=
73ef0
[ 1443.605590] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 00000000000=
00000
[ 1443.605594] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 00000000000=
00400
[ 1443.605598] Call Trace:
[ 1443.605601]  <TASK>
[ 1443.605608]  queue_delayed_work_on+0x8f/0xa0
[ 1443.605616]  smb2_reconnect.part.0+0x69c/0xea0 [cifs]
[ 1443.605793]  smb2_reconnect_server+0x383/0xc90 [cifs]
[ 1443.605948]  ? __pfx_smb2_reconnect_server+0x10/0x10 [cifs]
[ 1443.606119]  ? rcu_is_watching+0x20/0x50
[ 1443.606129]  process_one_work+0x4bf/0xb40
[ 1443.606143]  ? __pfx_process_one_work+0x10/0x10
[ 1443.606154]  ? assign_work+0xd6/0x110
[ 1443.606162]  worker_thread+0x2c9/0x550
[ 1443.606171]  ? __pfx_worker_thread+0x10/0x10
[ 1443.606178]  kthread+0x216/0x3e0
[ 1443.606183]  ? __pfx_kthread+0x10/0x10
[ 1443.606188]  ? __pfx_kthread+0x10/0x10
[ 1443.606193]  ? lock_release+0xc4/0x270
[ 1443.606199]  ? rcu_is_watching+0x20/0x50
[ 1443.606204]  ? __pfx_kthread+0x10/0x10
[ 1443.606211]  ret_from_fork+0x23a/0x2e0
[ 1443.606217]  ? __pfx_kthread+0x10/0x10
[ 1443.606223]  ret_from_fork_asm+0x1a/0x30
[ 1443.606239]  </TASK>
[ 1443.606242] irq event stamp: 6634
[ 1443.606244] hardirqs last  enabled at (6633): [<ffffffffb94226be>]
__up_console_sem+0x5e/0x70
[ 1443.606251] hardirqs last disabled at (6634): [<ffffffffb935a631>]
queue_delayed_work_on+0x71/0xa0
[ 1443.606256] softirqs last  enabled at (6576): [<ffffffffc1aeed28>]
__smb_send_rqst+0x498/0x8d0 [cifs]
[ 1443.606429] softirqs last disabled at (6574): [<ffffffffba47baf1>]
release_sock+0x21/0xf0
[ 1443.606438] ---[ end trace 0000000000000000 ]---
[ 1443.606458] ------------[ cut here ]------------
[ 1443.606461] WARNING: CPU: 0 PID: 32107 at kernel/workqueue.c:2500
__queue_delayed_work+0x1f1/0x200
[ 1443.606468] Modules linked in: cifs(E) cmac(E) nls_utf8(E)
cifs_arc4(E) nls_ucs2_utils(E) cifs_md4(E) rpcsec_gss_krb5(E)
auth_rpcgss(E) nfsv4(E) dns_resolver(E) nfs(E) lockd(E) grace(E)
netfs(E) nf_conntrack_
netbios_ns(E) nf_conntrack_broadcast(E) nft_fib_inet(E)
nft_fib_ipv4(E) nft_fib_ipv6(E) nft_fib(E) nft_reject_inet(E)
nf_reject_ipv4(E) nf_reject_ipv6(E) nft_reject(E) nft_ct(E)
nft_chain_nat(E) nf_tables(E) ebt
able_nat(E) ebtable_broute(E) ip6table_nat(E) ip6table_mangle(E)
ip6table_raw(E) ip6table_security(E) iptable_nat(E) nf_nat(E)
nf_conntrack(E) nf_defrag_ipv6(E) nf_defrag_ipv4(E) iptable_mangle(E)
iptable_raw(E)
 iptable_security(E) ip_set(E) ebtable_filter(E) ebtables(E)
ip6table_filter(E) ip6_tables(E) iptable_filter(E) ip_tables(E)
sunrpc(E) kvm_intel(E) kvm(E) irqbypass(E) virtio_net(E)
virtio_balloon(E) net_failove
r(E) failover(E) fuse(E) loop(E) dm_multipath(E) nfnetlink(E) zram(E)
xfs(E) bochs(E) drm_client_lib(E) drm_shmem_helper(E)
drm_kms_helper(E) ghash_clmulni_intel(E) sha512_ssse3(E) floppy(E)
[ 1443.606616]  sha1_ssse3(E) virtio_blk(E) drm(E) qemu_fw_cfg(E)
virtio_console(E) [last unloaded: cifs(E)]
[ 1443.606634] CPU: 0 UID: 0 PID: 32107 Comm: kworker/0:18 Tainted: G
      W   EL      6.16.0-rc2 #1 PREEMPT(voluntary)
[ 1443.606642] Tainted: [W]=3DWARN, [E]=3DUNSIGNED_MODULE, [L]=3DSOFTLOCKUP
[ 1443.606645] Hardware name: Red Hat KVM, BIOS 1.16.3-4.el9 04/01/2014
[ 1443.606649] Workqueue: cifsiod smb2_reconnect_server [cifs]
[ 1443.606832] RIP: 0010:__queue_delayed_work+0x1f1/0x200
[ 1443.606838] Code: 0f 0b e9 59 ff ff ff bf 02 00 00 00 e8 28 df 09
00 89 c5 eb bf 0f 0b e9 45 fe ff ff 0f 0b e9 57 fe ff ff 0f 0b e9 68
fe ff ff <0f> 0b e9 7c fe ff ff 44 89 ee eb a0 0f 1f 00 90 90 90 90 90
90
 90
[ 1443.606842] RSP: 0018:ff1100010a0b7b40 EFLAGS: 00010086
[ 1443.606848] RAX: 0000000000000000 RBX: 00000000000927c0 RCX: ffffffffb93=
5a416
[ 1443.606851] RDX: dffffc0000000000 RSI: ff11000126f29400 RDI: ff11000130b=
5e950
[ 1443.606855] RBP: ff11000126f29400 R08: 0000000000000000 R09: ffe21c00261=
6bd29
[ 1443.606859] R10: ff11000130b5e94f R11: 0000000000000000 R12: ff11000130b=
5e948
[ 1443.606863] R13: 0000000000002000 R14: ff11000130b5e950 R15: ff11000130b=
5e990
[ 1443.606867] FS:  0000000000000000(0000) GS:ff1100050e243000(0000)
knlGS:0000000000000000
[ 1443.606871] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 1443.606875] CR2: 00007f2c017fcd60 CR3: 000000010f93d002 CR4: 00000000003=
73ef0
[ 1443.606883] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 00000000000=
00000
[ 1443.606887] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 00000000000=
00400
[ 1443.606890] Call Trace:
[ 1443.606893]  <TASK>
[ 1443.606899]  queue_delayed_work_on+0x8f/0xa0
[ 1443.606907]  smb2_reconnect.part.0+0x69c/0xea0 [cifs]
[ 1443.607087]  smb2_reconnect_server+0x383/0xc90 [cifs]
[ 1443.607267]  ? __pfx_smb2_reconnect_server+0x10/0x10 [cifs]
[ 1443.607442]  ? rcu_is_watching+0x20/0x50
[ 1443.607451]  process_one_work+0x4bf/0xb40
[ 1443.607464]  ? __pfx_process_one_work+0x10/0x10
[ 1443.607475]  ? assign_work+0xd6/0x110
[ 1443.607482]  worker_thread+0x2c9/0x550
[ 1443.607492]  ? __pfx_worker_thread+0x10/0x10
[ 1443.607499]  kthread+0x216/0x3e0
[ 1443.607503]  ? __pfx_kthread+0x10/0x10
[ 1443.607508]  ? __pfx_kthread+0x10/0x10
[ 1443.607513]  ? lock_release+0xc4/0x270
[ 1443.607518]  ? rcu_is_watching+0x20/0x50
[ 1443.607523]  ? __pfx_kthread+0x10/0x10
[ 1443.607530]  ret_from_fork+0x23a/0x2e0
[ 1443.607535]  ? __pfx_kthread+0x10/0x10
[ 1443.607541]  ret_from_fork_asm+0x1a/0x30
[ 1443.607556]  </TASK>
[ 1443.607559] irq event stamp: 6634
[ 1443.607561] hardirqs last  enabled at (6633): [<ffffffffb94226be>]
__up_console_sem+0x5e/0x70
[ 1443.607566] hardirqs last disabled at (6634): [<ffffffffb935a631>]
queue_delayed_work_on+0x71/0xa0
[ 1443.607572] softirqs last  enabled at (6576): [<ffffffffc1aeed28>]
__smb_send_rqst+0x498/0x8d0 [cifs]
[ 1443.607754] softirqs last disabled at (6574): [<ffffffffba47baf1>]
release_sock+0x21/0xf0
[ 1443.607760] ---[ end trace 0000000000000000 ]---
[ 1456.801776] RIP: 0010:_raw_spin_unlock_irqrestore+0x37/0x60
[ 1456.801781] Code: 48 83 c7 18 53 48 89 f3 48 8b 74 24 10 e8 d1 f3
a9 fe 48 89 ef e8 a9 2d aa fe 80 e7 02 74 0b e8 ff b6 c2 fe fb 0f 1f
44 00 00 <65> ff 0d a2 b1 47 02 74 07 5b 5d e9 49 2d 00 00 0f 1f 44 00
00
 5b
[ 1456.801794] RSP: 0018:ff1100011afefbe8 EFLAGS: 00000206
[ 1456.801797] RAX: 00000000436ae62b RBX: 0000000000000246 RCX: 00000000000=
00080
[ 1456.801800] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffffffffba9=
69e81
[ 1456.801802] RBP: ff1100011b0ad0a8 R08: 0000000000000001 R09: 00000000000=
00001
[ 1456.801804] R10: ffffffffbbfe44e7 R11: 0000000000000000 R12: ff1100011b0=
ad0a8
[ 1456.801807] R13: 1fe22000235fdf80 R14: ffffffffc1350c80 R15: ff1100011b0=
ad1c8
[ 1456.801809] FS:  00007f45a913cc40(0000) GS:ff1100050e4c3000(0000)
knlGS:0000000000000000
[ 1456.801812] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 1456.801815] CR2: 00007faaa9cd3380 CR3: 0000000109c93004 CR4: 00000000003=
73ef0
[ 1456.801822] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 00000000000=
00000
[ 1456.801825] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 00000000000=
00400
[ 1456.801827] Call Trace:
[ 1456.801830]  <TASK>
[ 1456.801839]  netfs_wait_for_pause+0xc5/0x1a0 [netfs]
[ 1456.801890]  ? __pfx_netfs_wait_for_pause+0x10/0x10 [netfs]
[ 1456.801930]  ? __pfx_autoremove_wake_function+0x10/0x10
[ 1456.801937]  ? iov_iter_advance+0x170/0x280
[ 1456.801945]  netfs_unbuffered_write+0xe6/0x120 [netfs]
[ 1456.801988]  netfs_unbuffered_write_iter_locked+0x42f/0x550 [netfs]
[ 1456.802028]  netfs_unbuffered_write_iter+0x21d/0x360 [netfs]
[ 1456.802068]  ? __pfx_netfs_file_write_iter+0x10/0x10 [netfs]
[ 1456.802105]  vfs_write+0x5c6/0x7b0
[ 1456.802112]  ? __fget_files+0x31/0x1f0
[ 1456.802116]  ? __pfx_vfs_write+0x10/0x10
[ 1456.802122]  ? __rcu_read_unlock+0x6f/0x2a0
[ 1456.802132]  ? fdget_pos+0x126/0x170
[ 1456.802138]  ksys_write+0xb6/0x140
[ 1456.802143]  ? __pfx_ksys_write+0x10/0x10
[ 1456.802147]  ? irqtime_account_irq+0xaf/0x100
[ 1456.802155]  do_syscall_64+0x75/0x3a0
[ 1456.802160]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[ 1456.802164] RIP: 0033:0x7f45a924c984
[ 1456.802170] Code: c7 00 16 00 00 00 b8 ff ff ff ff c3 66 2e 0f 1f
84 00 00 00 00 00 f3 0f 1e fa 80 3d c5 06 0e 00 00 74 13 b8 01 00 00
00 0f 05 <48> 3d 00 f0 ff ff 77 54 c3 0f 1f 00 55 48 89 e5 48 83 ec 20
48
 89
[ 1456.802173] RSP: 002b:00007fff9b2e3f78 EFLAGS: 00000202 ORIG_RAX:
0000000000000001
[ 1456.802176] RAX: ffffffffffffffda RBX: 0000000000000004 RCX: 00007f45a92=
4c984
[ 1456.802178] RDX: 0000000000100000 RSI: 000000000db00000 RDI: 00000000000=
00004
[ 1456.802181] RBP: 0000000000000327 R08: 0000000000083570 R09: 00000000000=
00001
[ 1456.802183] R10: 0000000000000004 R11: 0000000000000202 R12: 00000000003=
00000
[ 1456.802185] R13: 0000000000100000 R14: 000000000db00000 R15: 00000000000=
00000
[ 1456.802196]  </TASK>
[ 1484.801716] watchdog: BUG: soft lockup - CPU#5 stuck for 234s!
[fsstress:31998]
[ 1484.801722] Modules linked in: cifs(E) cmac(E) nls_utf8(E)
cifs_arc4(E) nls_ucs2_utils(E) cifs_md4(E) rpcsec_gss_krb5(E)
auth_rpcgss(E) nfsv4(E) dns_resolver(E) nfs(E) lockd(E) grace(E)
netfs(E) nf_conntrack_
netbios_ns(E) nf_conntrack_broadcast(E) nft_fib_inet(E)
nft_fib_ipv4(E) nft_fib_ipv6(E) nft_fib(E) nft_reject_inet(E)
nf_reject_ipv4(E) nf_reject_ipv6(E) nft_reject(E) nft_ct(E)
nft_chain_nat(E) nf_tables(E) ebt
able_nat(E) ebtable_broute(E) ip6table_nat(E) ip6table_mangle(E)
ip6table_raw(E) ip6table_security(E) iptable_nat(E) nf_nat(E)
nf_conntrack(E) nf_defrag_ipv6(E) nf_defrag_ipv4(E) iptable_mangle(E)
iptable_raw(E)
 iptable_security(E) ip_set(E) ebtable_filter(E) ebtables(E)
ip6table_filter(E) ip6_tables(E) iptable_filter(E) ip_tables(E)
sunrpc(E) kvm_intel(E) kvm(E) irqbypass(E) virtio_net(E)
virtio_balloon(E) net_failove
r(E) failover(E) fuse(E) loop(E) dm_multipath(E) nfnetlink(E) zram(E)
xfs(E) bochs(E) drm_client_lib(E) drm_shmem_helper(E)
drm_kms_helper(E) ghash_clmulni_intel(E) sha512_ssse3(E) floppy(E)
[ 1484.801824]  sha1_ssse3(E) virtio_blk(E) drm(E) qemu_fw_cfg(E)
virtio_console(E) [last unloaded: cifs(E)]
[ 1484.801833] irq event stamp: 1274243064
[ 1484.801837] hardirqs last  enabled at (1274243063):
[<ffffffffba969e81>] _raw_spin_unlock_irqrestore+0x31/0x60
[ 1484.801848] hardirqs last disabled at (1274243064):
[<ffffffffba95175f>] sysvec_apic_timer_interrupt+0xf/0x90
[ 1484.801854] softirqs last  enabled at (1274045358):
[<ffffffffb93252f5>] __irq_exit_rcu+0x135/0x160
[ 1484.801860] softirqs last disabled at (1274045337):
[<ffffffffb93252f5>] __irq_exit_rcu+0x135/0x160
[ 1484.801866] CPU: 5 UID: 0 PID: 31998 Comm: fsstress Tainted: G
  W   EL      6.16.0-rc2 #1 PREEMPT(voluntary)
[ 1484.801874] Tainted: [W]=3DWARN, [E]=3DUNSIGNED_MODULE, [L]=3DSOFTLOCKUP
[ 1484.801875] Hardware name: Red Hat KVM, BIOS 1.16.3-4.el9 04/01/2014
[ 1484.801878] RIP: 0010:rcu_is_watching+0x0/0x50
[ 1484.801884] Code: 2c 01 00 00 48 c7 c7 00 92 ab ba c6 05 30 ba b4
02 01 e8 03 eb fa ff eb 8e 90 90 90 90 90 90 90 90 90 90 90 90 90 90
90 90 90 <f3> 0f 1e fa 53 65 ff 05 34 fc 98 03 65 48 8b 1d 24 fc 98 03
48 8d
[ 1484.801888] RSP: 0018:ff1100011afefaa8 EFLAGS: 00000247
[ 1484.801891] RAX: 0000000000000001 RBX: 0000000000000005 RCX: ffffffffc13=
50ceb
[ 1484.801894] RDX: fffffbfff77fc89d RSI: 0000000000000008 RDI: ffffffffbbf=
e44e0
[ 1484.801896] RBP: ff1100011b0acec0 R08: 0000000000000000 R09: fffffbfff77=
fc89c
[ 1484.801898] R10: ffffffffbbfe44e7 R11: 0000000000000000 R12: ff1100011b0=
acec0
[ 1484.801900] R13: ffffffffc1350c80 R14: 0000000000000001 R15: 00000000000=
00000
[ 1484.801903] FS:  00007f45a913cc40(0000) GS:ff1100050e4c3000(0000)
knlGS:0000000000000000
[ 1484.801906] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 1484.801908] CR2: 00007faaa9cd3380 CR3: 0000000109c93004 CR4: 00000000003=
73ef0
[ 1484.801916] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 00000000000=
00000
[ 1484.801919] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 00000000000=
00400
[ 1484.801921] Call Trace:
[ 1484.801924]  <TASK>
[ 1484.801927]  netfs_write_collection+0x12a3/0x17b0 [netfs]
[ 1484.801992]  ? do_raw_spin_lock+0x10c/0x190
[ 1484.801999]  ? __pfx_do_raw_spin_lock+0x10/0x10
[ 1484.802007]  ? __pfx_netfs_write_collection+0x10/0x10 [netfs]
[ 1484.802048]  ? __pfx_netfs_write_collection+0x10/0x10 [netfs]
[ 1484.802088]  netfs_collect_in_app+0x12f/0x2c0 [netfs]
[ 1484.802131]  ? __pfx_netfs_write_collection+0x10/0x10 [netfs]
[ 1484.802171]  netfs_wait_for_pause+0x148/0x1a0 [netfs]
[ 1484.802212]  ? __pfx_netfs_wait_for_pause+0x10/0x10 [netfs]
[ 1484.802252]  ? __pfx_autoremove_wake_function+0x10/0x10
[ 1484.802259]  ? iov_iter_advance+0x170/0x280
[ 1484.802266]  netfs_unbuffered_write+0xe6/0x120 [netfs]
[ 1484.802309]  netfs_unbuffered_write_iter_locked+0x42f/0x550 [netfs]
[ 1484.802351]  netfs_unbuffered_write_iter+0x21d/0x360 [netfs]
[ 1484.802391]  ? __pfx_netfs_file_write_iter+0x10/0x10 [netfs]
[ 1484.802427]  vfs_write+0x5c6/0x7b0
[ 1484.802434]  ? __fget_files+0x31/0x1f0
[ 1484.802439]  ? __pfx_vfs_write+0x10/0x10
[ 1484.802445]  ? __rcu_read_unlock+0x6f/0x2a0
[ 1484.802454]  ? fdget_pos+0x126/0x170
[ 1484.802460]  ksys_write+0xb6/0x140
[ 1484.802465]  ? __pfx_ksys_write+0x10/0x10
[ 1484.802469]  ? irqtime_account_irq+0xaf/0x100
[ 1484.802477]  do_syscall_64+0x75/0x3a0
[ 1484.802483]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[ 1484.802487] RIP: 0033:0x7f45a924c984
[ 1484.802492] Code: c7 00 16 00 00 00 b8 ff ff ff ff c3 66 2e 0f 1f
84 00 00 00 00 00 f3 0f 1e fa 80 3d c5 06 0e 00 00 74 13 b8 01 00 00
00 0f 05 <48> 3d 00 f0 ff ff 77 54 c3 0f 1f 00 55 48 89 e5 48 83 ec 20
48 89
[ 1484.802495] RSP: 002b:00007fff9b2e3f78 EFLAGS: 00000202 ORIG_RAX:
0000000000000001
[ 1484.802498] RAX: ffffffffffffffda RBX: 0000000000000004 RCX: 00007f45a92=
4c984
[ 1484.802501] RDX: 0000000000100000 RSI: 000000000db00000 RDI: 00000000000=
00004
[ 1484.802503] RBP: 0000000000000327 R08: 0000000000083570 R09: 00000000000=
00001
[ 1484.802505] R10: 0000000000000004 R11: 0000000000000202 R12: 00000000003=
00000
[ 1484.802507] R13: 0000000000100000 R14: 000000000db00000 R15: 00000000000=
00000

On Mon, Jun 16, 2025 at 6:36=E2=80=AFAM David Howells <dhowells@redhat.com>=
 wrote:
>
> When doing a DIO read, if the subrequests we issue fail and cause the
> request PAUSE flag to be set to put a pause on subrequest generation, we
> may complete collection of the subrequests (possibly discarding them) pri=
or
> to the ALL_QUEUED flags being set.
>
> In such a case, netfs_read_collection() doesn't see ALL_QUEUED being set
> after netfs_collect_read_results() returns and will just return to the ap=
p
> (the collector can be seen unpausing the generator in the trace log).
>
> The subrequest generator can then set ALL_QUEUED and the app thread reach=
es
> netfs_wait_for_request().  This causes netfs_collect_in_app() to be calle=
d
> to see if we're done yet, but there's missing case here.
>
> netfs_collect_in_app() will see that a thread is active and set inactive =
to
> false, but won't see any subrequests in the read stream, and so won't set
> need_collect to true.  The function will then just return 0, indicating
> that the caller should just sleep until further activity (which won't be
> forthcoming) occurs.
>
> Fix this by making netfs_collect_in_app() check to see if an active threa=
d
> is complete - i.e. that ALL_QUEUED is set and the subrequests list is emp=
ty
> - and to skip the sleep return path.  The collector will then be called
> which will clear the request IN_PROGRESS flag, allowing the app to
> progress.
>
> Fixes: 2b1424cd131c ("netfs: Fix wait/wake to be consistent about the wai=
tqueue used")
> Reported-by: Steve French <sfrench@samba.org>
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: Paulo Alcantara <pc@manguebit.org>
> cc: linux-cifs@vger.kernel.org
> cc: netfs@lists.linux.dev
> cc: linux-fsdevel@vger.kernel.org
> ---
> diff --git a/fs/netfs/misc.c b/fs/netfs/misc.c
> index 43b67a28a8fa..1966dfba285e 100644
> --- a/fs/netfs/misc.c
> +++ b/fs/netfs/misc.c
> @@ -381,7 +381,7 @@ void netfs_wait_for_in_progress_stream(struct netfs_i=
o_request *rreq,
>  static int netfs_collect_in_app(struct netfs_io_request *rreq,
>                                 bool (*collector)(struct netfs_io_request=
 *rreq))
>  {
> -       bool need_collect =3D false, inactive =3D true;
> +       bool need_collect =3D false, inactive =3D true, done =3D true;
>
>         for (int i =3D 0; i < NR_IO_STREAMS; i++) {
>                 struct netfs_io_subrequest *subreq;
> @@ -400,9 +400,11 @@ static int netfs_collect_in_app(struct netfs_io_requ=
est *rreq,
>                         need_collect =3D true;
>                         break;
>                 }
> +               if (subreq || test_bit(NETFS_RREQ_ALL_QUEUED, &rreq->flag=
s))
> +                       done =3D false;
>         }
>
> -       if (!need_collect && !inactive)
> +       if (!need_collect && !inactive && !done)
>                 return 0; /* Sleep */
>
>         __set_current_state(TASK_RUNNING);
>
>


--=20
Thanks,

Steve

