Return-Path: <linux-fsdevel+bounces-38306-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BD15D9FF1D8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 31 Dec 2024 21:35:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 92C281882B9B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 31 Dec 2024 20:35:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F09DF1B043E;
	Tue, 31 Dec 2024 20:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="kwcpoAg3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 536C9DDBE;
	Tue, 31 Dec 2024 20:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735677318; cv=none; b=EpF/daJa/5n75/pOzidMn8CN7TqvR0v35tvGzBTIs/nVMCPqNwE5vUe00Djc+gDf9tTQlC96P1yjH4teWv4tyntsjBhxKZYY6JlG/+MDcgdb0/BqHpTGfqnePKsmsaJmnJdlMI5uKE4N/CQKIf7T4tAZPAWn990ZbaTlRX/DuUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735677318; c=relaxed/simple;
	bh=numv2lz8idzdT87vdQRtsbW8la8vLkzAtxs9gs2Y6bA=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=LQekbESwqxoHfTERZf1G9woPvkrLUlrDPbaPxnyIwNkI2zsW1nefoCtDWCwoKVm+bv9B/hroiHIWa6S7po99KOYOG882Pm9hJz9Lqt4IbIDoWmZ8DGTASUYeb1XjAnYdQXGNw9UgkhaplCLpgRSrVfRQIA8ZYan83k07BfLNTD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=kwcpoAg3; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1735677313; x=1736282113; i=quwenruo.btrfs@gmx.com;
	bh=P18MkVrfK9x4L9B4LzdWYB8TKuFbYsvQEukM70PGPAc=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:From:To:
	 References:In-Reply-To:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=kwcpoAg3Lmtmo6a4flxDjZgwLFsGeZRORVUtYv3hyeRKDDtnT93dIaPGP3+Vfxs4
	 wQZIRqjxA2Z0LSJ+Tu83rAKBZGyU2NNnsXF2EVbGHsq1XFUTyn7Y/ufu6tVhXNoeq
	 1+1gOqwZVic0Jis1y6VaANa0za3fS/3kEdGN48StbG1jcsGEnbiqNRhOJzJwowuMb
	 5j9f5jwbHwLE5yoBSdbXMqK2tM2rzQtm9PQNKHpL3shcW1PL/W5tB2ovel5pZAILv
	 VU48WtyYCP9TQzy/DKLwP0HTrwwsiL4o+fZJD0dwlLRt5f6FOB8kQVljC8V1aDpUy
	 p4sAY2DHIwq/rosTOQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1Mg6Zw-1tzIYo2kjG-00hMTS; Tue, 31
 Dec 2024 21:35:13 +0100
Message-ID: <324cf712-7a7e-455b-b203-e221cb1ed542@gmx.com>
Date: Wed, 1 Jan 2025 07:05:10 +1030
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: mnt_list corruption triggered during btrfs/326
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
To: linux-fsdevel@vger.kernel.org, linux-btrfs <linux-btrfs@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>
References: <ec6784ed-8722-4695-980a-4400d4e7bd1a@gmx.com>
Content-Language: en-US
Autocrypt: addr=quwenruo.btrfs@gmx.com; keydata=
 xsBNBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAHNIlF1IFdlbnJ1byA8cXV3ZW5ydW8uYnRyZnNAZ214LmNvbT7CwJQEEwEIAD4CGwMFCwkI
 BwIGFQgJCgsCBBYCAwECHgECF4AWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCZxF1YAUJEP5a
 sQAKCRDCPZHzoSX+qF+mB/9gXu9C3BV0omDZBDWevJHxpWpOwQ8DxZEbk9b9LcrQlWdhFhyn
 xi+l5lRziV9ZGyYXp7N35a9t7GQJndMCFUWYoEa+1NCuxDs6bslfrCaGEGG/+wd6oIPb85xo
 naxnQ+SQtYLUFbU77WkUPaaIU8hH2BAfn9ZSDX9lIxheQE8ZYGGmo4wYpnN7/hSXALD7+oun
 tZljjGNT1o+/B8WVZtw/YZuCuHgZeaFdhcV2jsz7+iGb+LsqzHuznrXqbyUQgQT9kn8ZYFNW
 7tf+LNxXuwedzRag4fxtR+5GVvJ41Oh/eygp8VqiMAtnFYaSlb9sjia1Mh+m+OBFeuXjgGlG
 VvQFzsBNBFnVga8BCACqU+th4Esy/c8BnvliFAjAfpzhI1wH76FD1MJPmAhA3DnX5JDORcga
 CbPEwhLj1xlwTgpeT+QfDmGJ5B5BlrrQFZVE1fChEjiJvyiSAO4yQPkrPVYTI7Xj34FnscPj
 /IrRUUka68MlHxPtFnAHr25VIuOS41lmYKYNwPNLRz9Ik6DmeTG3WJO2BQRNvXA0pXrJH1fN
 GSsRb+pKEKHKtL1803x71zQxCwLh+zLP1iXHVM5j8gX9zqupigQR/Cel2XPS44zWcDW8r7B0
 q1eW4Jrv0x19p4P923voqn+joIAostyNTUjCeSrUdKth9jcdlam9X2DziA/DHDFfS5eq4fEv
 ABEBAAHCwHwEGAEIACYCGwwWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCZxF1gQUJEP5a0gAK
 CRDCPZHzoSX+qHGpB/kB8A7M7KGL5qzat+jBRoLwB0Y3Zax0QWuANVdZM3eJDlKJKJ4HKzjo
 B2Pcn4JXL2apSan2uJftaMbNQbwotvabLXkE7cPpnppnBq7iovmBw++/d8zQjLQLWInQ5kNq
 Vmi36kmq8o5c0f97QVjMryHlmSlEZ2Wwc1kURAe4lsRG2dNeAd4CAqmTw0cMIrR6R/Dpt3ma
 +8oGXJOmwWuDFKNV4G2XLKcghqrtcRf2zAGNogg3KulCykHHripG3kPKsb7fYVcSQtlt5R6v
 HZStaZBzw4PcDiaAF3pPDBd+0fIKS6BlpeNRSFG94RYrt84Qw77JWDOAZsyNfEIEE0J6LSR/
In-Reply-To: <ec6784ed-8722-4695-980a-4400d4e7bd1a@gmx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:kp732BvmRbL6Ogj0Whjgm3MQI4LqfmjdKktm9nL1dqmv/zoe7hG
 PPpZ9Ph1ACBypFy8C8wG73CciY6gqIduBLTzm45QbCDxFPJ+Y230VhEIHE2NO6x0xaBjr8K
 CHTGB82WHlqkEjk9RJtgyW/7wXFQ3gKsd9pUIjj9TgUHR+EYMR2WVE2jXQXAlYvOF2jiIa+
 hBFFdCI2eMLNn+9j6fRqA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Z7s7DCwgciA=;qS3h+p/fv+py8qFI5a9/PS0u6x1
 RBk3CHkP0iDY/P2/SL0+yhMhevHmnsFXHuCwF3ceixTkjDbYG/fOxLr6XoAnbPXmJVANmNigo
 hnOJu/5ZHhccuHdcWx8OCdQCjhN5xMA5OiqHA3a+8RZEfag46bQylmjAhDvfvEKA+T0Xqc0GG
 MRsDWjcQfRR/qHas9boQRVGrzq9vK3qcVEk9oG61ek9zRhjC+Qcq/OYrg+OxVcWG/xoXUkvNL
 njNgNmiTedZU5A1JuDo3gdZIHl4Of1Sz76gQ6YJO+QhFwhTRJ+3+zXt4p2U9YzYyRm/rLEJR/
 H/e567tgWVq2OvoPweMhBR2q2ndynCNE5NullEjnPqBcps56O6YFY7XF0B0tWZi73c0NO2q+v
 KiHT6qB9aSQeyo4yExoZd/KWkEZFrs8ixdbHO9PXGoWXR4cFxnpJ2DigcZd6cUBSJuOe5cBWI
 CroCJaYqujzYgjEQAED63NAG6+16z0VtRNlfqnV/BFnSU9o+1wC0Izo/wVDg89xIiq20CenwB
 FNo1rQNY8BZ5QeMIL5tyHbfRxy3MTjXWegv7gG8mlz2tIXuVtqMk0jfF/67QXyHyPevj+DPGA
 s6UfsKad9tff4/cemRn0QqEsBp2/27gesaquFXUxN8Txx55vkHBlQCkzGMvRu4qmb/V66tUxM
 hrRvdKGO7c80qQ9yRaL3C1ejfjelKU0yH+BFbxWzupW+8+4KkCEIIILYSxnSmhz7cfimA/U84
 KS8iYDIyxM378f+wIwwABGCQRa8lKn5x3vTlGTUneY58HcdQ9dCUrqfhrJ9rr2D/cWLCBy3eT
 MHyrMLnkxxdcGVeTyGLXJXOK/Cx8nQF+3XI9nrc7axkLphHQ1E4RXJiPPqID5evpa6fhJhgo2
 Iy4mpzM8Y28p4Q3o9ep760QzSYFbx7nsg2hWAJCbpD6U5Vxq7DX4gLU4iMqJ/BigcNobY+LXQ
 QYQfYfi11rLTM3xFJQjJCDnWuv5Batj+64hiUs5xBFdLJb7HLoMH09jxild7VS5R/hWd/Rjhl
 MPc4feoRouwGroa71G2gpIhaLZ/GXo+jUKLkyOKKMgekbcBlHGtqBvv9SsjYEr834jSB8Zklw
 A0JoLbtfE4lRuv1x70hzzTCSQ6XL7r



=E5=9C=A8 2024/12/30 19:59, Qu Wenruo =E5=86=99=E9=81=93:
> Hi,
>
> Although I know it's triggered from btrfs, but the mnt_list handling is
> out of btrfs' control, so I'm here asking for some help.
>
> [BUG]
> With CONFIG_DEBUG_LIST and CONFIG_BUG_ON_DATA_CORRUPTION, and an
> upstream 6.13-rc kernel, which has commit 951a3f59d268 ("btrfs: fix
> mount failure due to remount races"), I can hit the following crash,
> with varied frequency (from 1/4 to hundreds runs no crash):

There is also another WARNING triggered, without btrfs callback involved
at all:

[  192.688671] ------------[ cut here ]------------
[  192.690016] WARNING: CPU: 3 PID: 59747 at fs/mount.h:150
attach_recursive_mnt+0xc58/0x1260
[  192.692051] Modules linked in: nft_fib_inet nft_fib_ipv4 nft_fib_ipv6
nft_fib nft_reject_inet nf_reject_ipv4 nf_reject_ipv6 nft_reject nft_ct
nft_chain_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4
nf_tables binfmt_misc btrfs xor raid6_pq zstd_compress iTCO_wdt
intel_pmc_bxt iTCO_vendor_support i2c_i801 i2c_smbus virtio_net
net_failover virtio_balloon lpc_ich failover joydev loop dm_multipath
nfnetlink vsock_loopback vmw_vsock_virtio_transport_common vsock zram
crct10dif_pclmul crc32_pclmul crc32c_intel polyval_clmulni
polyval_generic ghash_clmulni_intel sha512_ssse3 sha256_ssse3 sha1_ssse3
virtio_blk virtio_console bochs serio_raw scsi_dh_rdac scsi_dh_emc
scsi_dh_alua fuse qemu_fw_cfg
[  192.707547] CPU: 3 UID: 0 PID: 59747 Comm: mount Kdump: loaded Not
tainted 6.13.0-rc4-custom+ #9
[  192.709485] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS
Arch Linux 1.16.3-1-1 04/01/2014
[  192.711601] RIP: 0010:attach_recursive_mnt+0xc58/0x1260
[  192.712725] Code: 85 c0 0f 85 79 ff ff ff 48 c7 c7 04 e7 00 8e 83 05
9c 18 28 03 01 e8 97 1d c8 01 31 f6 48 89 ef e8 dd c1 fe ff e9 9c f5 ff
ff <0f> 0b e9 48 f8 ff ff 48 8b 44 24 10 48 8d 78 20 48 b8 00 00 00 00
[  192.716521] RSP: 0018:ffff888105cafb68 EFLAGS: 00010246
[  192.717621] RAX: 0000000000001020 RBX: ffff88811cc24030 RCX:
ffffffff8ca0e8e5
[  192.719078] RDX: ffff888105cafbf0 RSI: ffff888118db0800 RDI:
ffff88811cc240f0
[  192.720313] RBP: ffff88811cc24000 R08: ffff88810f21a840 R09:
ffffed1020b95f62
[  192.721028] R10: 0000000000000003 R11: ffff88810a56e558 R12:
ffff88811cc24000
[  192.721718] R13: dffffc0000000000 R14: ffff88810f21a840 R15:
ffff888105cafbf0
[  192.722426] FS:  00007fdf69887800(0000) GS:ffff888236f80000(0000)
knlGS:0000000000000000
[  192.723229] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  192.723849] CR2: 00007fdf697a9000 CR3: 000000010d925000 CR4:
0000000000750ef0
[  192.724549] PKRU: 55555554
[  192.724860] Call Trace:
[  192.725101]  <TASK>
[  192.725311]  ? __warn.cold+0xb6/0x176
[  192.725672]  ? attach_recursive_mnt+0xc58/0x1260
[  192.726149]  ? report_bug+0x1f0/0x2a0
[  192.726520]  ? handle_bug+0x54/0x90
[  192.726895]  ? exc_invalid_op+0x17/0x40
[  192.727259]  ? asm_exc_invalid_op+0x1a/0x20
[  192.727664]  ? _raw_spin_lock+0x85/0xe0
[  192.728053]  ? attach_recursive_mnt+0xc58/0x1260
[  192.728501]  ? attach_recursive_mnt+0xb82/0x1260
[  192.728954]  ? _raw_spin_unlock+0xe/0x20
[  192.729330]  ? count_mounts+0x1e0/0x1e0
[  192.729703]  ? _raw_spin_lock+0x85/0xe0
[  192.730082]  ? _raw_write_lock_bh+0xe0/0xe0
[  192.730493]  do_move_mount+0x7a8/0x1a20
[  192.730871]  __do_sys_move_mount+0x7e2/0xcf0
[  192.731288]  ? syscall_exit_to_user_mode+0x10/0x200
[  192.731762]  ? do_syscall_64+0x8e/0x160
[  192.732180]  ? do_move_mount+0x1a20/0x1a20
[  192.732587]  do_syscall_64+0x82/0x160
[  192.732950]  ? syscall_exit_to_user_mode_prepare+0x15a/0x190
[  192.733500]  ? syscall_exit_to_user_mode+0x10/0x200
[  192.733977]  ? do_syscall_64+0x8e/0x160
[  192.734374]  ? from_kuid_munged+0x86/0x100
[  192.734765]  ? from_kuid+0xc0/0xc0
[  192.735115]  ? syscall_exit_to_user_mode_prepare+0x15a/0x190
[  192.735644]  ? syscall_exit_to_user_mode+0x10/0x200
[  192.736124]  ? do_syscall_64+0x8e/0x160
[  192.736487]  ? exc_page_fault+0x76/0xf0
[  192.736861]  entry_SYSCALL_64_after_hwframe+0x4b/0x53
[  192.737352] RIP: 0033:0x7fdf69a5c3de
[  192.737725] Code: 73 01 c3 48 8b 0d 32 3a 0f 00 f7 d8 64 89 01 48 83
c8 ff c3 0f 1f 84 00 00 00 00 00 f3 0f 1e fa 49 89 ca b8 ad 01 00 00 0f
05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 02 3a 0f 00 f7 d8 64 89 01 48
[  192.739455] RSP: 002b:00007ffd2b7c36d8 EFLAGS: 00000246 ORIG_RAX:
00000000000001ad
[  192.740176] RAX: ffffffffffffffda RBX: 0000557ac60e9a00 RCX:
00007fdf69a5c3de
[  192.740895] RDX: 00000000ffffff9c RSI: 00007fdf69bc9902 RDI:
0000000000000004
[  192.741578] RBP: 00007ffd2b7c3700 R08: 0000000000000004 R09:
0000000000000001
[  192.742247] R10: 0000557ac60e9e40 R11: 0000000000000246 R12:
00007fdf69bd6b00
[  192.742911] R13: 0000557ac60e9e40 R14: 0000557ac60ebbe0 R15:
0000000000000066
[  192.743573]  </TASK>
[  192.743803] ---[ end trace 0000000000000000 ]---

Thanks,
Qu

>
> [=C2=A0 303.356328] BTRFS: device fsid 6fd8eb6f-1ea5-40aa-9857-05c64efe6=
d43
> devid 1 transid 9 /dev/mapper/test-scratch1 (253:2) scanned by mount
> (358060)
> [=C2=A0 303.358614] BTRFS info (device dm-2): first mount of filesystem
> 6fd8eb6f-1ea5-40aa-9857-05c64efe6d43
> [=C2=A0 303.359475] BTRFS info (device dm-2): using crc32c (crc32c-intel=
)
> checksum algorithm
> [=C2=A0 303.360134] BTRFS info (device dm-2): using free-space-tree
> [=C2=A0 313.264317] list_del corruption, ffff8fd48a7b2c90->prev is NULL
> [=C2=A0 313.264966] ------------[ cut here ]------------
> [=C2=A0 313.265402] kernel BUG at lib/list_debug.c:54!
> [=C2=A0 313.265847] Oops: invalid opcode: 0000 [#1] PREEMPT SMP
> [=C2=A0 313.266335] CPU: 4 UID: 0 PID: 370457 Comm: mount Kdump: loaded =
Not
> tainted 6.13.0-rc4-custom+ #8
> [=C2=A0 313.267252] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), =
BIOS
> Arch Linux 1.16.3-1-1 04/01/2014
> [=C2=A0 313.268147] RIP: 0010:__list_del_entry_valid_or_report.cold+0x6d=
/0x6f
> [=C2=A0 313.268777] Code: 05 77 a0 e8 4b 10 fd ff 0f 0b 48 89 fe 48 c7 c=
7 90
> 05 77 a0 e8 3a 10 fd ff 0f 0b 48 89 fe 48 c7 c7 60 05 77 a0 e8 29 10 fd
> ff <0f> 0b 4c 89 ea be 01 00 00 00 4c 89 44 24 48 48 c7 c7 20 7c 2b a1
> [=C2=A0 313.270493] RSP: 0018:ffffa7620d2b3a38 EFLAGS: 00010246
> [=C2=A0 313.270960] RAX: 0000000000000033 RBX: ffff8fd48a7b2c00 RCX:
> 0000000000000000
> [=C2=A0 313.271565] RDX: 0000000000000000 RSI: ffff8fd5f7c21900 RDI:
> ffff8fd5f7c21900
> [=C2=A0 313.272226] RBP: ffff8fd48a7b2c00 R08: 0000000000000000 R09:
> 0000000000000000
> [=C2=A0 313.272895] R10: 74707572726f6320 R11: 6c65645f7473696c R12:
> ffffa7620d2b3a58
> [=C2=A0 313.273521] R13: ffff8fd48a7b2c00 R14: 0000000000000000 R15:
> ffff8fd48a7b2c90
> [=C2=A0 313.274138] FS:=C2=A0 00007f04740d4800(0000) GS:ffff8fd5f7c00000=
(0000)
> knlGS:0000000000000000
> [=C2=A0 313.274864] CS:=C2=A0 0010 DS: 0000 ES: 0000 CR0: 00000000800500=
33
> [=C2=A0 313.275392] CR2: 00007f0473ff6000 CR3: 000000011a8eb000 CR4:
> 0000000000750ef0
> [=C2=A0 313.276084] PKRU: 55555554
> [=C2=A0 313.276327] Call Trace:
> [=C2=A0 313.276551]=C2=A0 <TASK>
> [=C2=A0 313.276752]=C2=A0 ? __die_body.cold+0x19/0x28
> [=C2=A0 313.277102]=C2=A0 ? die+0x2e/0x50
> [=C2=A0 313.277699]=C2=A0 ? do_trap+0xc6/0x110
> [=C2=A0 313.278033]=C2=A0 ? do_error_trap+0x6a/0x90
> [=C2=A0 313.278401]=C2=A0 ? __list_del_entry_valid_or_report.cold+0x6d/0=
x6f
> [=C2=A0 313.278941]=C2=A0 ? exc_invalid_op+0x50/0x60
> [=C2=A0 313.279308]=C2=A0 ? __list_del_entry_valid_or_report.cold+0x6d/0=
x6f
> [=C2=A0 313.279850]=C2=A0 ? asm_exc_invalid_op+0x1a/0x20
> [=C2=A0 313.280241]=C2=A0 ? __list_del_entry_valid_or_report.cold+0x6d/0=
x6f
> [=C2=A0 313.280777]=C2=A0 ? __list_del_entry_valid_or_report.cold+0x6d/0=
x6f
> [=C2=A0 313.281285]=C2=A0 umount_tree+0xed/0x3c0
> [=C2=A0 313.281589]=C2=A0 put_mnt_ns+0x51/0x90
> [=C2=A0 313.281886]=C2=A0 mount_subtree+0x92/0x130
> [=C2=A0 313.282205]=C2=A0 btrfs_get_tree+0x343/0x6b0 [btrfs]
> [=C2=A0 313.282785]=C2=A0 vfs_get_tree+0x23/0xc0
> [=C2=A0 313.283089]=C2=A0 vfs_cmd_create+0x59/0xd0
> [=C2=A0 313.283406]=C2=A0 __do_sys_fsconfig+0x4eb/0x6b0
> [=C2=A0 313.283764]=C2=A0 do_syscall_64+0x82/0x160
> [=C2=A0 313.284085]=C2=A0 ? syscall_exit_to_user_mode_prepare+0x15a/0x19=
0
> [=C2=A0 313.284598]=C2=A0 ? __fs_parse+0x68/0x1b0
> [=C2=A0 313.284929]=C2=A0 ? btrfs_parse_param+0x64/0x870 [btrfs]
> [=C2=A0 313.285381]=C2=A0 ? vfs_parse_fs_param_source+0x20/0x90
> [=C2=A0 313.285825]=C2=A0 ? __do_sys_fsconfig+0x1b8/0x6b0
> [=C2=A0 313.286215]=C2=A0 ? syscall_exit_to_user_mode_prepare+0x15a/0x19=
0
> [=C2=A0 313.286719]=C2=A0 ? syscall_exit_to_user_mode+0x10/0x200
> [=C2=A0 313.287151]=C2=A0 ? do_syscall_64+0x8e/0x160
> [=C2=A0 313.287498]=C2=A0 ? vfs_fstatat+0x75/0xa0
> [=C2=A0 313.287835]=C2=A0 ? __do_sys_newfstatat+0x56/0x90
> [=C2=A0 313.288240]=C2=A0 ? syscall_exit_to_user_mode_prepare+0x15a/0x19=
0
> [=C2=A0 313.288749]=C2=A0 ? syscall_exit_to_user_mode+0x10/0x200
> [=C2=A0 313.289188]=C2=A0 ? do_syscall_64+0x8e/0x160
> [=C2=A0 313.289544]=C2=A0 ? do_syscall_64+0x8e/0x160
> [=C2=A0 313.289892]=C2=A0 ? do_syscall_64+0x8e/0x160
> [=C2=A0 313.290253]=C2=A0 ? syscall_exit_to_user_mode+0x10/0x200
> [=C2=A0 313.290692]=C2=A0 ? do_syscall_64+0x8e/0x160
> [=C2=A0 313.291034]=C2=A0 ? exc_page_fault+0x7e/0x180
> [=C2=A0 313.291380]=C2=A0 entry_SYSCALL_64_after_hwframe+0x4b/0x53
> [=C2=A0 313.291845] RIP: 0033:0x7f04742a919e
> [=C2=A0 313.292182] Code: 73 01 c3 48 8b 0d 72 3c 0f 00 f7 d8 64 89 01 4=
8 83
> c8 ff c3 0f 1f 84 00 00 00 00 00 f3 0f 1e fa 49 89 ca b8 af 01 00 00 0f
> 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 42 3c 0f 00 f7 d8 64 89 01 48
> [=C2=A0 313.293830] RSP: 002b:00007ffc3df08df8 EFLAGS: 00000246 ORIG_RAX=
:
> 00000000000001af
> [=C2=A0 313.294529] RAX: ffffffffffffffda RBX: 000056407e37aa00 RCX:
> 00007f04742a919e
> [=C2=A0 313.295201] RDX: 0000000000000000 RSI: 0000000000000006 RDI:
> 0000000000000003
> [=C2=A0 313.295864] RBP: 00007ffc3df08f40 R08: 0000000000000000 R09:
> 0000000000000001
> [=C2=A0 313.296602] R10: 0000000000000000 R11: 0000000000000246 R12:
> 00007f0474423b00
> [=C2=A0 313.297416] R13: 0000000000000000 R14: 000056407e37cbe0 R15:
> 00007f0474418561
> [=C2=A0 313.298242]=C2=A0 </TASK>
> [=C2=A0 313.298832] Modules linked in: nft_fib_inet nft_fib_ipv4 nft_fib=
_ipv6
> nft_fib nft_reject_inet nf_reject_ipv4 nf_reject_ipv6 nft_reject nft_ct
> nft_chain_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4
> nf_tables binfmt_misc btrfs xor raid6_pq zstd_compress iTCO_wdt
> intel_pmc_bxt iTCO_vendor_support i2c_i801 i2c_smbus virtio_net joydev
> net_failover lpc_ich virtio_balloon failover loop dm_multipath nfnetlink
> vsock_loopback vmw_vsock_virtio_transport_common vsock zram
> crct10dif_pclmul crc32_pclmul crc32c_intel polyval_clmulni
> polyval_generic ghash_clmulni_intel virtio_console sha512_ssse3
> sha256_ssse3 bochs sha1_ssse3 virtio_blk serio_raw scsi_dh_rdac
> scsi_dh_emc scsi_dh_alua fuse qemu_fw_cfg
> [=C2=A0 313.304504] Dumping ftrace buffer:
> [=C2=A0 313.304876]=C2=A0=C2=A0=C2=A0 (ftrace buffer empty)
>
> [EARLY ANALYZE]
>
> The offending line is the list_move() call inside unmount_tree().
>
> With crash core dump, the offending mnt_list is totally corrupted:
>
> crash> struct list_head ffff8fd48a7b2c90
> struct list_head {
>  =C2=A0 next =3D 0x1,
>  =C2=A0 prev =3D 0x0
> }
>
> umount_tree() should be protected by @mount_lock seqlock, and
> @namespace_sem rwsem.
>
> I also checked other mnt_list users:
>
> - commit_tree()
> - do_umount()
> - copy_tree()
>
> They all hold write @mount_lock at least.
>
> The only caller doesn't hold @mount_lock is iterate_mounts() but that's
> only called from audit, and I'm not sure if audit is even involved in
> this case.
>
> So I ran out of ideas why this mnt_list can even happen.
>
> Even if it's some btrfs' abuse, all mnt_list users are properly
> protected thus it should not lead to such list corruption.
>
> Any advice would be appreciated.
>
> Thanks,
> Qu
>


