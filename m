Return-Path: <linux-fsdevel+bounces-57047-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27E80B1E4D0
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Aug 2025 10:52:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B3F4169B34
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Aug 2025 08:51:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E02C26A0EE;
	Fri,  8 Aug 2025 08:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="qqTZh2Jv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEDB12690EA;
	Fri,  8 Aug 2025 08:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754643065; cv=none; b=CfQ4v/bIUGu2EcswcfBYOf75KDSMMjjhk2WvexCDK72cyMZZRUXApM/YKpzZeE6IgWp0zBoNcNEerE+wTD6WvfQo0DL0hdYDKWQtxyIO6rNTEDU6xwd94a3dfDsBXkmCvNFxZflDx0sIbOhh7SQk9X92WitIPmnlMrGCYwEei0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754643065; c=relaxed/simple;
	bh=r8rCm1aZtOCn00G46e0I6E4VUPfR+C65d8TtcGlT7Eo=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=qfCDSaoW0/XFCZDNW9OgxH4m9VWggdsHN9dFE4932NR/UioxN79zsjtKo7AitcXT972anuKfXbMyvUHQwMzLXfiouMELy2X3UwuwlBeUCvJvjPkDJgh3ejUK4gCy8yLPa/V/xxzPR1mSiOmftn35/KWThveYzdffe/VWmNKpwqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=qqTZh2Jv; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1754643059; x=1755247859; i=quwenruo.btrfs@gmx.com;
	bh=7x6V81kVWLBZ5XNMGClntAZZI7FEZvZr41qGezOkI/8=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:From:To:
	 References:In-Reply-To:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=qqTZh2JvSCtjI5YZXOTUfFcTNY1sUW1GkJBiNxdJEOg/WIDFsACgWxtg+Z21TrPZ
	 sOrXPaAkiXtmAB/HHrbXSQCkEd5KJudF18/AOaLOYcqyS+IJ5RlUMNbyFsK1Q5Kwd
	 CrYUgjJRTewhe8J+bO58i9TAVitbhD7qfeF80L516vzTjojaBCsaC73Xl3VacVidn
	 hcRrJyb/VmYve0Hz1vsNdGeARUkVqn7DXRFifEjKHD8/D2d55dKo+oP0RxCkPACVm
	 2JahuCABxpYu6PIMXshyIogjwVYaLzCGkE2uO7Hz1X1jkt6GPIhd7BbTLG37OvACw
	 PrtR3r0uhqfc3uBAeg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MZCfJ-1v62mQ0vMv-00QO3Z; Fri, 08
 Aug 2025 10:50:59 +0200
Message-ID: <4ef2476f-50c3-424d-927d-100e305e1f8e@gmx.com>
Date: Fri, 8 Aug 2025 18:20:56 +0930
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Ext4 iomap warning during btrfs/136 (yes, it's from btrfs test
 cases)
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
To: linux-ext4 <linux-ext4@vger.kernel.org>,
 linux-btrfs <linux-btrfs@vger.kernel.org>,
 "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
References: <9b650a52-9672-4604-a765-bb6be55d1e4a@gmx.com>
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
In-Reply-To: <9b650a52-9672-4604-a765-bb6be55d1e4a@gmx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:A/Z6UCeaOdDVY1f41SiRFei6+STklg2bEmz87irWv8q6jpfIPdr
 ffPNWdfEETVquT9b1ZDdGHR8skkg7W5hcatxjJqBhouREPFfQCUHUMki76N6HWu4+0z+So8
 TSYpx8AieZU+IwwU8Ua4qYhleI5F6F99RU1+s9/u+eBbdVqiCh3TxpnFgdHfzZ34U2UnrAs
 4b9ETV018mU0i5zyHFpkw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:So0ra9NC5F4=;dhLi7R0OoEVpWuAYWqoPq1T0Epr
 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



=E5=9C=A8 2025/8/8 17:22, Qu Wenruo =E5=86=99=E9=81=93:
> Hi,
>=20
> [BACKGROUND]
> Recently I'm testing btrfs with 16KiB block size.
>=20
> Currently btrfs is artificially limiting subpage block size to 4K.
> But there is a simple patch to change it to support all block sizes <=3D=
=20
> page size in my branch:
>=20
> https://github.com/adam900710/linux/tree/larger_bs_support
>=20
> [IOMAP WARNING]
> And I'm running into a very weird kernel warning at btrfs/136, with 16K=
=20
> block size and 64K page size.
>=20
> The problem is, the problem happens with ext3 (using ext4 modeule) with=
=20
> 16K block size, and no btrfs is involved yet.

The following reproducer is much smaller, and of course, btrfs is not=20
involved:

=2D--
#!/bin/bash

dev=3D"/dev/test/scratch1"
mnt=3D"/mnt/btrfs/"
fsstress=3D"/home/adam/xfstests-dev/ltp/fsstress"

mkfs.ext3 -F -b 16k $dev
mount $dev $mnt

$fsstress -w -n 128 -d $mnt
umount $dev
=2D--

And ext4 is fine, so it's ext3 mode causing the problem.

Furthermore, after the kernel wanring, the fsstress will never finish,=20
and no blocked process either.

Thanks,
Qu

>=20
> The test case btrfs/136 create an ext3 fs first, using the same block=20
> size of the btrfs on TEST_DEV (so it's 16K).
> Then populate the fs.
>=20
> The hang happens at the ext3 populating part, with the following kernel=
=20
> warning:
>=20
> [=C2=A0 989.664270] run fstests btrfs/136 at 2025-08-08 16:57:37
> [=C2=A0 990.551395] EXT4-fs (dm-3): mounting ext3 file system using the =
ext4=20
> subsystem
> [=C2=A0 990.554980] EXT4-fs (dm-3): mounted filesystem d90f4325-=20
> e6a6-4787-9da8-150ece277a94 r/w with ordered data mode. Quota mode: none=
.
> [=C2=A0 990.581540] ------------[ cut here ]------------
> [=C2=A0 990.581551] WARNING: CPU: 3 PID: 434101 at fs/iomap/iter.c:34=20
> iomap_iter_done+0x148/0x190
> [=C2=A0 990.583497] Modules linked in: dm_flakey nls_ascii nls_cp437 vfa=
t fat=20
> btrfs polyval_ce ghash_ce rtc_efi processor xor xor_neon raid6_pq=20
> zstd_compress fuse loop nfnetlink qemu_fw_cfg ext4 crc16 mbcache jbd2=20
> dm_mod xhci_pci xhci_hcd virtio_net virtio_scsi net_failover failover=20
> virtio_console virtio_balloon virtio_blk virtio_mmio
> [=C2=A0 990.587247] CPU: 3 UID: 0 PID: 434101 Comm: fsstress Not tainted=
=20
> 6.16.0-rc7-custom+ #128 PREEMPT(voluntary)
> [=C2=A0 990.588525] Hardware name: QEMU KVM Virtual Machine, BIOS unknow=
n=20
> 2/2/2022
> [=C2=A0 990.589414] pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSB=
S=20
> BTYPE=3D--)
> [=C2=A0 990.590314] pc : iomap_iter_done+0x148/0x190
> [=C2=A0 990.590874] lr : iomap_iter+0x174/0x230
> [=C2=A0 990.591370] sp : ffff8000880af740
> [=C2=A0 990.591800] x29: ffff8000880af740 x28: ffff0000db8e6840 x27:=20
> 0000000000000000
> [=C2=A0 990.592716] x26: 0000000000000000 x25: ffff8000880af830 x24:=20
> 0000004000000000
> [=C2=A0 990.593631] x23: 0000000000000002 x22: 000001bfdbfa8000 x21:=20
> ffffa6a41c002e48
> [=C2=A0 990.594549] x20: 0000000000000001 x19: ffff8000880af808 x18:=20
> 0000000000000000
> [=C2=A0 990.595464] x17: 0000000000000000 x16: ffffa6a495ee6cd0 x15:=20
> 0000000000000000
> [=C2=A0 990.596379] x14: 00000000000003d4 x13: 00000000fa83b2da x12:=20
> 0000b236fc95f18c
> [=C2=A0 990.597295] x11: ffffa6a4978b9c08 x10: 0000000000001da0 x9 :=20
> ffffa6a41c1a2a44
> [=C2=A0 990.598210] x8 : ffff8000880af5c8 x7 : 0000000001000000 x6 :=20
> 0000000000000000
> [=C2=A0 990.599125] x5 : 0000000000000004 x4 : 000001bfdbfa8000 x3 :=20
> 0000000000000000
> [=C2=A0 990.600040] x2 : 0000000000000000 x1 : 0000004004030000 x0 :=20
> 0000000000000000
> [=C2=A0 990.600955] Call trace:
> [=C2=A0 990.601273]=C2=A0 iomap_iter_done+0x148/0x190 (P)
> [=C2=A0 990.601829]=C2=A0 iomap_iter+0x174/0x230
> [=C2=A0 990.602280]=C2=A0 iomap_fiemap+0x154/0x1d8
> [=C2=A0 990.602751]=C2=A0 ext4_fiemap+0x110/0x140 [ext4]
> [=C2=A0 990.603350]=C2=A0 do_vfs_ioctl+0x4b8/0xbc0
> [=C2=A0 990.603831]=C2=A0 __arm64_sys_ioctl+0x8c/0x120
> [=C2=A0 990.604346]=C2=A0 invoke_syscall+0x6c/0x100
> [=C2=A0 990.604836]=C2=A0 el0_svc_common.constprop.0+0x48/0xf0
> [=C2=A0 990.605444]=C2=A0 do_el0_svc+0x24/0x38
> [=C2=A0 990.605875]=C2=A0 el0_svc+0x38/0x120
> [=C2=A0 990.606283]=C2=A0 el0t_64_sync_handler+0x10c/0x138
> [=C2=A0 990.606846]=C2=A0 el0t_64_sync+0x198/0x1a0
> [=C2=A0 990.607319] ---[ end trace 0000000000000000 ]---
> [=C2=A0 990.608042] ------------[ cut here ]------------
> [=C2=A0 990.608047] WARNING: CPU: 3 PID: 434101 at fs/iomap/iter.c:35=20
> iomap_iter_done+0x164/0x190
> [=C2=A0 990.610842] Modules linked in: dm_flakey nls_ascii nls_cp437 vfa=
t fat=20
> btrfs polyval_ce ghash_ce rtc_efi processor xor xor_neon raid6_pq=20
> zstd_compress fuse loop nfnetlink qemu_fw_cfg ext4 crc16 mbcache jbd2=20
> dm_mod xhci_pci xhci_hcd virtio_net virtio_scsi net_failover failover=20
> virtio_console virtio_balloon virtio_blk virtio_mmio
> [=C2=A0 990.619189] CPU: 3 UID: 0 PID: 434101 Comm: fsstress Tainted: G=
=20
>  =C2=A0W=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 6.1=
6.0-rc7-custom+ #128 PREEMPT(voluntary)
> [=C2=A0 990.620876] Tainted: [W]=3DWARN
> [=C2=A0 990.621458] Hardware name: QEMU KVM Virtual Machine, BIOS unknow=
n=20
> 2/2/2022
> [=C2=A0 990.622507] pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSB=
S=20
> BTYPE=3D--)
> [=C2=A0 990.623911] pc : iomap_iter_done+0x164/0x190
> [=C2=A0 990.624936] lr : iomap_iter+0x174/0x230
> [=C2=A0 990.626747] sp : ffff8000880af740
> [=C2=A0 990.627404] x29: ffff8000880af740 x28: ffff0000db8e6840 x27:=20
> 0000000000000000
> [=C2=A0 990.628947] x26: 0000000000000000 x25: ffff8000880af830 x24:=20
> 0000004000000000
> [=C2=A0 990.631024] x23: 0000000000000002 x22: 000001bfdbfa8000 x21:=20
> ffffa6a41c002e48
> [=C2=A0 990.632278] x20: 0000000000000001 x19: ffff8000880af808 x18:=20
> 0000000000000000
> [=C2=A0 990.634189] x17: 0000000000000000 x16: ffffa6a495ee6cd0 x15:=20
> 0000000000000000
> [=C2=A0 990.635608] x14: 00000000000003d4 x13: 00000000fa83b2da x12:=20
> 0000b236fc95f18c
> [=C2=A0 990.637854] x11: ffffa6a4978b9c08 x10: 0000000000001da0 x9 :=20
> ffffa6a41c1a2a44
> [=C2=A0 990.639181] x8 : ffff8000880af5c8 x7 : 0000000001000000 x6 :=20
> 0000000000000000
> [=C2=A0 990.642370] x5 : 0000000000000004 x4 : 000001bfdbfa8000 x3 :=20
> 0000000000000000
> [=C2=A0 990.644505] x2 : 0000004004030000 x1 : 0000004004030000 x0 :=20
> 0000004004030000
> [=C2=A0 990.645493] Call trace:
> [=C2=A0 990.645841]=C2=A0 iomap_iter_done+0x164/0x190 (P)
> [=C2=A0 990.646377]=C2=A0 iomap_iter+0x174/0x230
> [=C2=A0 990.647550]=C2=A0 iomap_fiemap+0x154/0x1d8
> [=C2=A0 990.648052]=C2=A0 ext4_fiemap+0x110/0x140 [ext4]
> [=C2=A0 990.649061]=C2=A0 do_vfs_ioctl+0x4b8/0xbc0
> [=C2=A0 990.649704]=C2=A0 __arm64_sys_ioctl+0x8c/0x120
> [=C2=A0 990.652141]=C2=A0 invoke_syscall+0x6c/0x100
> [=C2=A0 990.653001]=C2=A0 el0_svc_common.constprop.0+0x48/0xf0
> [=C2=A0 990.653909]=C2=A0 do_el0_svc+0x24/0x38
> [=C2=A0 990.654332]=C2=A0 el0_svc+0x38/0x120
> [=C2=A0 990.654736]=C2=A0 el0t_64_sync_handler+0x10c/0x138
> [=C2=A0 990.655295]=C2=A0 el0t_64_sync+0x198/0x1a0
> [=C2=A0 990.655761] ---[ end trace 0000000000000000 ]---
>=20
> Considering it's not yet btrfs, and the call trace is from iomap, I=20
> guess there is something wrong with ext4's ext3 support?
>=20
> The involved ext4 kernel configs are the following:
>=20
> # CONFIG_EXT2_FS is not set
> # CONFIG_EXT3_FS is not set
> CONFIG_EXT4_FS=3Dm
> CONFIG_EXT4_USE_FOR_EXT2=3Dy
> CONFIG_EXT4_FS_POSIX_ACL=3Dy
> CONFIG_EXT4_FS_SECURITY=3Dy
> # CONFIG_EXT4_DEBUG is not set
> CONFIG_JBD2=3Dm
> # CONFIG_JBD2_DEBUG is not set
>=20
> Thanks,
> Qu
>=20


