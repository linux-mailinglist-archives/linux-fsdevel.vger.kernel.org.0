Return-Path: <linux-fsdevel+bounces-47761-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6297EAA55FB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Apr 2025 22:45:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED1D31B63AB4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Apr 2025 20:45:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D4312C032A;
	Wed, 30 Apr 2025 20:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=omnibond-com.20230601.gappssmtp.com header.i=@omnibond-com.20230601.gappssmtp.com header.b="eYtE9pdT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EB472BD93C
	for <linux-fsdevel@vger.kernel.org>; Wed, 30 Apr 2025 20:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746045825; cv=none; b=rmgsVxUVlv/4wlOm5lhDd5BascYwFTaNAID6ciWG8rwvYPiZXK+TQAb4z2iixRWz4HwhUYnIF9hwDmLpxkr5CIxAIgX5OrzGZiUgaF53DDZeYTjm633McQqLe8mfJtCl4fMEnaG8ZL1JL51CcioLgXjkhbDk5PrzwBMIB0bzMu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746045825; c=relaxed/simple;
	bh=hh4ZZiX0W826M97c84IM/h5+C/W+Gv9ECtdOHNQYU70=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OggHQUisRm/wg2y+8BlRN8sQR2/tdtdGNuekmFExfZhDpCQQZLH8rwdpbFTrPY4hmF26Fj1k89XFOxjLM9u7CG2Ih0N+gvb+Hh052DvYRxdZZLjn+l45KdTPRvkshvArXTToaC/YXgfqwWdJJSjJFxUNiuWmuV4Ou62ySpRDyAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omnibond.com; spf=pass smtp.mailfrom=omnibond.com; dkim=pass (2048-bit key) header.d=omnibond-com.20230601.gappssmtp.com header.i=@omnibond-com.20230601.gappssmtp.com header.b=eYtE9pdT; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omnibond.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=omnibond.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-af9925bbeb7so207474a12.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 30 Apr 2025 13:43:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=omnibond-com.20230601.gappssmtp.com; s=20230601; t=1746045823; x=1746650623; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FBXEsIRX3HTUdGiB2T4+SNUyoyHY4ZN88XCDfcybUGc=;
        b=eYtE9pdTbigY83wVTdnSeyTEfiiEz85Ly7SC07NM/LGBZdZjtb8OnmWkRZKxLM7+Kw
         K0IVYYXYn12DIUn2A+y9GUEITch2ey3gaGcuQJl5mhB4yDVQHl+OnDkeUnBTMRnQWoR9
         ++M6lKw66F5/xyVkxCbpqSsS1ipWYzflO+R0IDBV0mLiN8ONx4yCRxbCm9bKcENwlqX8
         9xaMjPj61JWQ/3pnuH2P7MfJziXqj22zbGSNz1qTAI7Q+zkrg/oCHWjz+Pt4gYkpWfne
         dJX1fssmAl2d2hPfDgVZWshRV9Ipw8Hb6jQe3QCEgVuymwdhYvbw2zsRQ1ZKIyDRBL2g
         SHNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746045823; x=1746650623;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FBXEsIRX3HTUdGiB2T4+SNUyoyHY4ZN88XCDfcybUGc=;
        b=MI0+FMbwBnvzqrl4De+jDGrIkSEoPd1n3gWOs/3Fj8AZuz8b7E/PSrUj/ha0yAOxYZ
         aFGFBC/EGo7MuHmI+i0yHCWK2azBwNfzn2093CvXPEpQjygHQLrPke1ZsgEzG++r9Ly7
         gCIowOQACx3W2BjX4ZS/3iRHcvFIkWAo32gGVen0xtEsEXS7pA6bK57wJV6A63oWs5mK
         cPyz+8lNoPS8IIvuo70QV2SNr5RCzl2ybokbZdprqeB+w9zrSIg/xD2YwXYdWBjv8EA9
         UKGTFZdzS35vsJnUl+ndWJNeWfBM38Roul2zugwB71YZGFaIVfWmhZgWR2KwNPuW7pH0
         gQLw==
X-Gm-Message-State: AOJu0YxXyGd/lwaAEFXZW32tHgt+9KyHdPY0Hcyq6AFX2fDch5GtSdqm
	4qMgWiZZ1oyZQYqx08ssVLuwq4+mtvk04aECz56DaoN7xrjIKdpO2ga8xZmyynth6f++SQcOKlR
	ZqatXrWNqrNQtpDwzFOTubW0/jM+Xv9bYyKgw3MEhFBIXlnvJaA==
X-Gm-Gg: ASbGncv2ah7U6dtQyqNbT7ElXwRYsMEbB9IPIZ9ak6Jq+QIrNj53d9c0nNgDs31bq7H
	6VfwYMa5yCjklJ1FZNIHP78xyG+6JsJBpbpx95ub/+Czpzshf5B8p5NbqPWNCmD8JjgvxvntsvI
	iiFk2er120bJ0jHVeTA2ohtD2+IROiwdRMCg==
X-Google-Smtp-Source: AGHT+IF++9gBY9Pj6J8xyiJ7kN/jgiGINWWE519tcb4jrqCj2syUVa/FDJXH0xdiu/kUj18OcA2Wp10O4mmP0erLvWE=
X-Received: by 2002:a17:90b:57cc:b0:301:a0e9:66f with SMTP id
 98e67ed59e1d1-30a400b201emr862045a91.14.1746045822525; Wed, 30 Apr 2025
 13:43:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAOg9mSTLUOEobom72-MekLpdH-FuF0S+JkU4E13PK6KzNqT1pw@mail.gmail.com>
 <2040f153-c50e-49ea-acb6-72914c62fecb@intel.com>
In-Reply-To: <2040f153-c50e-49ea-acb6-72914c62fecb@intel.com>
From: Mike Marshall <hubcap@omnibond.com>
Date: Wed, 30 Apr 2025 16:43:31 -0400
X-Gm-Features: ATxdqUHvU7DUxHrr94g4Vm7ZsCaQAI_qOgBUG4q3bMGtYKk6CPBWdRUEMvP1NWU
Message-ID: <CAOg9mSRPok2NR5UNkkyBb8nGgZxQo36dfvL0ZWSpMZ3pT5884Q@mail.gmail.com>
Subject: Re: [REGRESSION] orangefs: page writeback problem in 6.14 (bisected
 to 665575cf)
To: Dave Hansen <dave.hansen@intel.com>
Cc: linux-fsdevel <linux-fsdevel@vger.kernel.org>, 
	Dave Hansen <dave.hansen@linux.intel.com>, devel@lists.orangefs.org, 
	Mike Marshall <hubcap@omnibond.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I'll check through the counting code, I don't know of a bug there...

I had turned on some debug and added a print statement before
the warnon, here's what's produced...
[ 1991.319111] orangefs_writepage_locked: wr->pos:0: len:4080:
[ 1991.319114] service_operation: file_write op:0000000018e1923a:
process:dbtest: pid:21269:
[ 1991.319448] service_operation: wait_for_matching_downcall returned
0 for 0000000018e1923a
[ 1991.319450] service_operation: file_write returning: 0 for 0000000018e19=
23a.
[ 1991.319457] orangefs_writepage_locked: wr->pos:4080: len:4080:
[ 1991.319479] ------------[ cut here ]------------
[ 1991.319480] WARNING: CPU: 0 PID: 21269 at fs/orangefs/inode.c:36
orangefs_writepage_locked.isra.0.cold+0x25/0x51 [orangefs]
[ 1991.319491] Modules linked in: orangefs uinput snd_seq_dummy
snd_hrtimer nf_conntrack_netbios_ns nf_conntrack_broadcast
nft_fib_inet nft_fib_ipv4 nft_fib_ipv6 nft_fib nft_reject_inet
nf_reject_ipv4 nf_reject_ipv6 nft_reject nft_ct nft_chain_nat nf_nat
nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 rfkill ip_set nf_tables
qrtr sunrpc intel_rapl_msr snd_hda_codec_generic intel_rapl_common
snd_hda_intel kvm_intel snd_intel_dspcfg snd_hda_codec snd_hwdep
snd_hda_core snd_seq snd_seq_device kvm snd_pcm iTCO_wdt intel_pmc_bxt
iTCO_vendor_support snd_timer i2c_i801 i2c_smbus snd rapl pcspkr
soundcore virtio_net lpc_ich virtio_balloon net_failover joydev
failover nfnetlink zram virtio_gpu drm_client_lib virtio_dma_buf
drm_shmem_helper drm_kms_helper drm ghash_clmulni_intel virtio_console
virtio_blk serio_raw fuse qemu_fw_cfg [last unloaded: orangefs]
[ 1991.319557] CPU: 0 UID: 0 PID: 21269 Comm: dbtest Tainted: G
W          6.14.0-dirty #9
[ 1991.319559] Tainted: [W]=3DWARN
[ 1991.319560] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009),
BIOS 1.16.3-3.fc41 04/01/2014
[ 1991.319561] RIP:
0010:orangefs_writepage_locked.isra.0.cold+0x25/0x51 [orangefs]
[ 1991.319568] Code: e9 53 60 ff ff 4c 8b 7b 28 4c 89 e9 48 c7 c6 d0
b6 99 c0 48 c7 c7 2b d0 99 c0 49 8b 17 e8 6c 35 88 e6 49 8b 07 4c 39
e8 72 02 <0f> 0b 4d 8b 77 08 48 89 04 24 4a 8d 14 30 49 39 d5 73 0b 4d
89 ee
[ 1991.319569] RSP: 0018:ffffba548a6afd00 EFLAGS: 00010246
[ 1991.319571] RAX: 0000000000000ff0 RBX: fffff4c381581180 RCX: 00000000000=
00000
[ 1991.319572] RDX: 0000000000000001 RSI: 0000000000000027 RDI: 00000000fff=
fffff
[ 1991.319573] RBP: 0000000000000000 R08: 0000000000000000 R09: ffffba548a6=
afbc0
[ 1991.319574] R10: ffffffffa90f54d8 R11: 0000000000000003 R12: ffff9b2852b=
fdbb0
[ 1991.319574] R13: 0000000000000ff0 R14: 000000000001f010 R15: ffff9b29070=
b8220
[ 1991.319576] FS:  00007f218b044300(0000) GS:ffff9b297bc00000(0000)
knlGS:0000000000000000
[ 1991.319577] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 1991.319578] CR2: 00007f218b023000 CR3: 000000004ffc6001 CR4: 00000000003=
72ef0
[ 1991.319581] Call Trace:
[ 1991.319583]  <TASK>
[ 1991.319583]  ? orangefs_writepage_locked.isra.0.cold+0x25/0x51 [orangefs=
]
[ 1991.319588]  ? __warn.cold+0x93/0xfb
[ 1991.319593]  ? orangefs_writepage_locked.isra.0.cold+0x25/0x51 [orangefs=
]
[ 1991.319597]  ? report_bug+0xe6/0x170
[ 1991.319600]  ? handle_bug+0x58/0x90
[ 1991.319602]  ? exc_invalid_op+0x13/0x60
[ 1991.319604]  ? asm_exc_invalid_op+0x16/0x20
[ 1991.319607]  ? orangefs_writepage_locked.isra.0.cold+0x25/0x51 [orangefs=
]
[ 1991.319611]  ? folio_clear_dirty_for_io+0x128/0x1a0
[ 1991.319613]  orangefs_launder_folio+0x2e/0x50 [orangefs]
[ 1991.319619]  orangefs_write_begin+0x87/0x150 [orangefs]
[ 1991.319624]  generic_perform_write+0x81/0x280
[ 1991.319627]  generic_file_write_iter+0x5e/0xe0
[ 1991.319629]  orangefs_file_write_iter+0x44/0x50 [orangefs]
[ 1991.319633]  vfs_write+0x240/0x410
[ 1991.319636]  ksys_write+0x52/0xc0
[ 1991.319638]  do_syscall_64+0x62/0x180
[ 1991.319640]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[ 1991.319643] RIP: 0033:0x7f218b134f44
[ 1991.319652] Code: c7 00 16 00 00 00 b8 ff ff ff ff c3 66 2e 0f 1f
84 00 00 00 00 00 f3 0f 1e fa 80 3d 85 91 10 00 00 74 13 b8 01 00 00
00 0f 05 <48> 3d 00 f0 ff ff 77 54 c3 0f 1f 00 55 48 89 e5 48 83 ec 20
48 89
[ 1991.319653] RSP: 002b:00007ffcd8d84e98 EFLAGS: 00000202 ORIG_RAX:
0000000000000001
[ 1991.319654] RAX: ffffffffffffffda RBX: 0000000000020000 RCX: 00007f218b1=
34f44
[ 1991.319655] RDX: 0000000000020000 RSI: 00007f218b022010 RDI: 00000000000=
00003
[ 1991.319656] RBP: 00007ffcd8d84ec0 R08: 00000000ffffffff R09: 00007f218b0=
21010
[ 1991.319657] R10: 0000000000000022 R11: 0000000000000202 R12: 00007f218b0=
22010
[ 1991.319658] R13: 0000000028c35310 R14: 0000000000020000 R15: 00007f218b0=
22010
[ 1991.319659]  </TASK>
[ 1991.319660] ---[ end trace 0000000000000000 ]---
[ 1991.319678] ------------[ cut here ]------------
[ 1991.319679] WARNING: CPU: 0 PID: 21269 at fs/orangefs/inode.c:51
orangefs_writepage_locked.isra.0+0x13e/0x220 [orangefs]
[ 1991.319687] Modules linked in: orangefs uinput snd_seq_dummy
snd_hrtimer nf_conntrack_netbios_ns nf_conntrack_broadcast
nft_fib_inet nft_fib_ipv4 nft_fib_ipv6 nft_fib nft_reject_inet
nf_reject_ipv4 nf_reject_ipv6 nft_reject nft_ct nft_chain_nat nf_nat
nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 rfkill ip_set nf_tables
qrtr sunrpc intel_rapl_msr snd_hda_codec_generic intel_rapl_common
snd_hda_intel kvm_intel snd_intel_dspcfg snd_hda_codec snd_hwdep
snd_hda_core snd_seq snd_seq_device kvm snd_pcm iTCO_wdt intel_pmc_bxt
iTCO_vendor_support snd_timer i2c_i801 i2c_smbus snd rapl pcspkr
soundcore virtio_net lpc_ich virtio_balloon net_failover joydev
failover nfnetlink zram virtio_gpu drm_client_lib virtio_dma_buf
drm_shmem_helper drm_kms_helper drm ghash_clmulni_intel virtio_console
virtio_blk serio_raw fuse qemu_fw_cfg [last unloaded: orangefs]
[ 1991.319731] CPU: 0 UID: 0 PID: 21269 Comm: dbtest Tainted: G
W          6.14.0-dirty #9
[ 1991.319733] Tainted: [W]=3DWARN
[ 1991.319733] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009),
BIOS 1.16.3-3.fc41 04/01/2014
[ 1991.319734] RIP: 0010:orangefs_writepage_locked.isra.0+0x13e/0x220 [oran=
gefs]
[ 1991.319738] Code: 48 83 c4 40 5b 5d 41 5c 41 5d 41 5e 41 5f c3 cc
cc cc cc 4d 89 ee 45 31 ff 49 29 c6 49 39 c5 74 09 4a 8d 14 30 49 39
d5 73 02 <0f> 0b 44 89 f2 4d 85 f6 0f 85 1c ff ff ff 0f 0b 31 d2 e9 13
ff ff
[ 1991.319740] RSP: 0018:ffffba548a6afd00 EFLAGS: 00010246
[ 1991.319741] RAX: 0000000000000ff0 RBX: fffff4c381581180 RCX: 00000000000=
00000
[ 1991.319742] RDX: 0000000000001000 RSI: 0000000000000027 RDI: 00000000fff=
fffff
[ 1991.319744] RBP: 0000000000000000 R08: 0000000000000000 R09: ffffba548a6=
afbc0
[ 1991.319745] R10: ffffffffa90f54d8 R11: 0000000000000003 R12: ffff9b2852b=
fdbb0
[ 1991.319746] R13: 0000000000000ff0 R14: 0000000000000000 R15: ffff9b29070=
b8220
[ 1991.319747] FS:  00007f218b044300(0000) GS:ffff9b297bc00000(0000)
knlGS:0000000000000000
[ 1991.319749] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 1991.319750] CR2: 00007f218b023000 CR3: 000000004ffc6001 CR4: 00000000003=
72ef0
[ 1991.319754] Call Trace:
[ 1991.319755]  <TASK>
[ 1991.319756]  ? orangefs_writepage_locked.isra.0+0x13e/0x220 [orangefs]
[ 1991.319763]  ? __warn.cold+0x93/0xfb
[ 1991.319766]  ? orangefs_writepage_locked.isra.0+0x13e/0x220 [orangefs]
[ 1991.319770]  ? report_bug+0xe6/0x170
[ 1991.319772]  ? handle_bug+0x58/0x90
[ 1991.319774]  ? exc_invalid_op+0x13/0x60
[ 1991.319775]  ? asm_exc_invalid_op+0x16/0x20
[ 1991.319778]  ? orangefs_writepage_locked.isra.0+0x13e/0x220 [orangefs]
[ 1991.319782]  ? folio_clear_dirty_for_io+0x128/0x1a0
[ 1991.319784]  orangefs_launder_folio+0x2e/0x50 [orangefs]
[ 1991.319788]  orangefs_write_begin+0x87/0x150 [orangefs]
[ 1991.319792]  generic_perform_write+0x81/0x280
[ 1991.319795]  generic_file_write_iter+0x5e/0xe0
[ 1991.319797]  orangefs_file_write_iter+0x44/0x50 [orangefs]
[ 1991.319801]  vfs_write+0x240/0x410
[ 1991.319803]  ksys_write+0x52/0xc0
[ 1991.319818]  do_syscall_64+0x62/0x180
[ 1991.319819]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[ 1991.319821] RIP: 0033:0x7f218b134f44
[ 1991.319823] Code: c7 00 16 00 00 00 b8 ff ff ff ff c3 66 2e 0f 1f
84 00 00 00 00 00 f3 0f 1e fa 80 3d 85 91 10 00 00 74 13 b8 01 00 00
00 0f 05 <48> 3d 00 f0 ff ff 77 54 c3 0f 1f 00 55 48 89 e5 48 83 ec 20
48 89
[ 1991.319824] RSP: 002b:00007ffcd8d84e98 EFLAGS: 00000202 ORIG_RAX:
0000000000000001
[ 1991.319826] RAX: ffffffffffffffda RBX: 0000000000020000 RCX: 00007f218b1=
34f44
[ 1991.319827] RDX: 0000000000020000 RSI: 00007f218b022010 RDI: 00000000000=
00003
[ 1991.319827] RBP: 00007ffcd8d84ec0 R08: 00000000ffffffff R09: 00007f218b0=
21010
[ 1991.319828] R10: 0000000000000022 R11: 0000000000000202 R12: 00007f218b0=
22010
[ 1991.319829] R13: 0000000028c35310 R14: 0000000000020000 R15: 00007f218b0=
22010
[ 1991.319831]  </TASK>
[ 1991.319831] ---[ end trace 0000000000000000 ]---
[ 1991.319842] ------------[ cut here ]------------
[ 1991.319843] WARNING: CPU: 0 PID: 21269 at fs/orangefs/inode.c:53
orangefs_writepage_locked.isra.0+0x14c/0x220 [orangefs]
[ 1991.319847] Modules linked in: orangefs uinput snd_seq_dummy
snd_hrtimer nf_conntrack_netbios_ns nf_conntrack_broadcast
nft_fib_inet nft_fib_ipv4 nft_fib_ipv6 nft_fib nft_reject_inet
nf_reject_ipv4 nf_reject_ipv6 nft_reject nft_ct nft_chain_nat nf_nat
nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 rfkill ip_set nf_tables
qrtr sunrpc intel_rapl_msr snd_hda_codec_generic intel_rapl_common
snd_hda_intel kvm_intel snd_intel_dspcfg snd_hda_codec snd_hwdep
snd_hda_core snd_seq snd_seq_device kvm snd_pcm iTCO_wdt intel_pmc_bxt
iTCO_vendor_support snd_timer i2c_i801 i2c_smbus snd rapl pcspkr
soundcore virtio_net lpc_ich virtio_balloon net_failover joydev
failover nfnetlink zram virtio_gpu drm_client_lib virtio_dma_buf
drm_shmem_helper drm_kms_helper drm ghash_clmulni_intel virtio_console
virtio_blk serio_raw fuse qemu_fw_cfg [last unloaded: orangefs]
[ 1991.319871] CPU: 0 UID: 0 PID: 21269 Comm: dbtest Tainted: G
W          6.14.0-dirty #9
[ 1991.319873] Tainted: [W]=3DWARN
[ 1991.319874] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009),
BIOS 1.16.3-3.fc41 04/01/2014
[ 1991.319874] RIP: 0010:orangefs_writepage_locked.isra.0+0x14c/0x220 [oran=
gefs]
[ 1991.319878] Code: c3 cc cc cc cc 4d 89 ee 45 31 ff 49 29 c6 49 39
c5 74 09 4a 8d 14 30 49 39 d5 73 02 0f 0b 44 89 f2 4d 85 f6 0f 85 1c
ff ff ff <0f> 0b 31 d2 e9 13 ff ff ff f7 c3 ff 0f 00 00 0f 85 77 ff ff
ff 48
[ 1991.319879] RSP: 0018:ffffba548a6afd00 EFLAGS: 00010246
[ 1991.319880] RAX: 0000000000000ff0 RBX: fffff4c381581180 RCX: 00000000000=
00000
[ 1991.319881] RDX: 0000000000000000 RSI: 0000000000000027 RDI: 00000000fff=
fffff
[ 1991.319882] RBP: 0000000000000000 R08: 0000000000000000 R09: ffffba548a6=
afbc0
[ 1991.319883] R10: ffffffffa90f54d8 R11: 0000000000000003 R12: ffff9b2852b=
fdbb0
[ 1991.319883] R13: 0000000000000ff0 R14: 0000000000000000 R15: ffff9b29070=
b8220
[ 1991.319884] FS:  00007f218b044300(0000) GS:ffff9b297bc00000(0000)
knlGS:0000000000000000
[ 1991.319885] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 1991.319886] CR2: 00007f218b023000 CR3: 000000004ffc6001 CR4: 00000000003=
72ef0
[ 1991.319888] Call Trace:
[ 1991.319889]  <TASK>
[ 1991.319890]  ? orangefs_writepage_locked.isra.0+0x14c/0x220 [orangefs]
[ 1991.319893]  ? __warn.cold+0x93/0xfb
[ 1991.319896]  ? orangefs_writepage_locked.isra.0+0x14c/0x220 [orangefs]
[ 1991.319900]  ? report_bug+0xe6/0x170
[ 1991.319902]  ? handle_bug+0x58/0x90
[ 1991.319904]  ? exc_invalid_op+0x13/0x60
[ 1991.319905]  ? asm_exc_invalid_op+0x16/0x20
[ 1991.319907]  ? orangefs_writepage_locked.isra.0+0x14c/0x220 [orangefs]
[ 1991.319912]  ? folio_clear_dirty_for_io+0x128/0x1a0
[ 1991.319914]  orangefs_launder_folio+0x2e/0x50 [orangefs]
[ 1991.319918]  orangefs_write_begin+0x87/0x150 [orangefs]
[ 1991.319922]  generic_perform_write+0x81/0x280
[ 1991.319924]  generic_file_write_iter+0x5e/0xe0
[ 1991.319926]  orangefs_file_write_iter+0x44/0x50 [orangefs]
[ 1991.319930]  vfs_write+0x240/0x410
[ 1991.319932]  ksys_write+0x52/0xc0
[ 1991.319934]  do_syscall_64+0x62/0x180
[ 1991.319936]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[ 1991.319937] RIP: 0033:0x7f218b134f44
[ 1991.319939] Code: c7 00 16 00 00 00 b8 ff ff ff ff c3 66 2e 0f 1f
84 00 00 00 00 00 f3 0f 1e fa 80 3d 85 91 10 00 00 74 13 b8 01 00 00
00 0f 05 <48> 3d 00 f0 ff ff 77 54 c3 0f 1f 00 55 48 89 e5 48 83 ec 20
48 89
[ 1991.319940] RSP: 002b:00007ffcd8d84e98 EFLAGS: 00000202 ORIG_RAX:
0000000000000001
[ 1991.319941] RAX: ffffffffffffffda RBX: 0000000000020000 RCX: 00007f218b1=
34f44
[ 1991.319942] RDX: 0000000000020000 RSI: 00007f218b022010 RDI: 00000000000=
00003
[ 1991.319943] RBP: 00007ffcd8d84ec0 R08: 00000000ffffffff R09: 00007f218b0=
21010
[ 1991.319944] R10: 0000000000000022 R11: 0000000000000202 R12: 00007f218b0=
22010
[ 1991.319944] R13: 0000000028c35310 R14: 0000000000020000 R15: 00007f218b0=
22010
[ 1991.319946]  </TASK>
[ 1991.319947] ---[ end trace 0000000000000000 ]---
[ 1991.319949] service_operation: file_write op:0000000018e1923a:
process:dbtest: pid:21269:
[ 1992.730150] service_operation: orangefs_inode_setattr
op:00000000cd5c216a: process:kworker/u10:0: pid:29:
[ 1992.7333

On Wed, Apr 30, 2025 at 11:52=E2=80=AFAM Dave Hansen <dave.hansen@intel.com=
> wrote:
>
> On 4/30/25 07:28, Mike Marshall wrote:
> > I ran through xfstests at 6.14-rc7, and then not again until 6.15-rc4.
> >
> > Starting with 6.14 xfstests generic/010 hits "WARN_ON(wr->pos >=3D len)=
;" in
> > orangefs_writepage_locked. I bisected:
>
> Any chance you could share the entire warning splat?
>
> I suspect what's happening here is that the orangefs code had an
> existing bug when it faults during a write and the write partially
> completes. My _guess_ is that the code effectively incremented wr->pos
> too far which took it past i_size.
>
> Before my patch, the writes fully complete. After my patch, the writes
> partially complete.
>
> Ext4 had a similar bug that caused this to get reverted the first time:
>
> > 00a3d660cbac ("Revert "fs: do not prefault sys_write() user buffer page=
s"")
>
> I would have felt pretty bad adding a hack to ext4 to work around this
> bug. I don't feel as bad doing it to orangefs. Does that make me a
> horrible person? :)
>
> Anyway, does the (entirely untested) attached patch hack around the
> issue for you? It just adds the old prefault behavior back to orangefs.
>
> BTW, I suspect you could reproduce this splat _without_ 665575cf by
> finding a way to undo the iov_iter_fault_in_readable() before
> iov_iter_copy_from_user_atomic(). Maybe by having another thread sit
> there and pound on the source memory buffer with MADV_DONTNEED or somethi=
ng.
>
> BTW, the orangefs Documentation/ is looking a little crusty. Both of
> these 404 on me:
>
> https://lists.orangefs.org/pipermail/devel_lists.orangefs.org/
> https://docs.orangefs.com/home/index.htm

