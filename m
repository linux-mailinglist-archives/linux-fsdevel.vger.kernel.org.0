Return-Path: <linux-fsdevel+bounces-57037-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4F4CB1E3E2
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Aug 2025 09:53:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3FC2C7AB056
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Aug 2025 07:51:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1195825394B;
	Fri,  8 Aug 2025 07:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="DXOma/yn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA58B23B615;
	Fri,  8 Aug 2025 07:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754639563; cv=none; b=H4HbZpYmBDNoB30YW2NYJmOesl+8kXlZ0k44z8bqTJ+CfzD4aCzN9qr5dL/NAMdC8KolxkvAWFMoIDx9fhK8S1ED6qIZYwCX3FsJSKRli73PadTm32NPon9o08zLmXX0E4prE8z6HDJLWwTdF/ob+/iPYJ/m+nSlxp/86jukfBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754639563; c=relaxed/simple;
	bh=Uv7uGrVKUrQl082IaPTDRUowNnVBhilnVBIK2Oe2KPI=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=TlGz/Ns7f8fWrkowpmjMQ4baUjcCXYfnc7f0oF2u4Yw+fsP8hZoTEo1fl7kPL7GDiYnNCnRaVHfdHS2FSLDxJWgUXBOvFEpzChWgMzNNk9EmBrBw3rgNhEH791tWmxahcO0n1Ua7Ics8o8jQJJL8VY+JsHBCz7X9s3al4rcY/gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=DXOma/yn; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1754639555; x=1755244355; i=quwenruo.btrfs@gmx.com;
	bh=1zUvgIQCuWZ2zoJ6wePNNerNLqhd+V4gd1tlx0MJLHs=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:From:Subject:
	 Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=DXOma/ynv68JX3TFxzRLkjTkuQ7A5kszRNXYqzYExDQs3EjKWb4ItipwekFNQImE
	 p2dZbrNEF8hKy4Q3VPxQ/jgIFU4ejeLSLg7ZTSBbngJ9+kd9xeQFyWJHHIUM+jhVh
	 Bs7S4o++OOksGzBlRWh6MqEXeVxwZogX2IyumUIwnhb5/wTuuDjDlBjx8qGn5GnOa
	 rWdRapEdlfY90O6Zd2uhET5f9+fMagefQDVQVbt59UiG5lGV89WWIS0zN79syNvex
	 R+A0Ot1havtwVGlF4TuslmS4f86qgFbdadbJ9BRMH92FqFhUcLTpw7IytzMHi2Edd
	 CG1zhHEFehahP2J/wQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MWzjt-1v8Fsw14cz-00OCCa; Fri, 08
 Aug 2025 09:52:35 +0200
Message-ID: <9b650a52-9672-4604-a765-bb6be55d1e4a@gmx.com>
Date: Fri, 8 Aug 2025 17:22:32 +0930
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: linux-ext4 <linux-ext4@vger.kernel.org>,
 linux-btrfs <linux-btrfs@vger.kernel.org>,
 "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Ext4 iomap warning during btrfs/136 (yes, it's from btrfs test cases)
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
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:jSHIu+pQ44a4AiY029gy9dlPAu+eMrc3PHttTPahTv0jwECeWmB
 sQANA2ZVyM+BgAK/WMP26Wky2V1rNy0zfMid6T5P+nMXopodYmIDGwNH6l5VZ0pmDtyEnRF
 B+WtLMKqXsAKhKvW4d1VGKvRsi6mHMZIaX1UK4U0ALdBBIwPYkEPCRKs/PIqS81KFWJmjlx
 72GHhbo3mx0BlRg0CCbUA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:M2/HDnLW6mM=;hQj879ff0BsF87s4EkVLTSqL66D
 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
 ohM+l0+36Ug==

Hi,

[BACKGROUND]
Recently I'm testing btrfs with 16KiB block size.

Currently btrfs is artificially limiting subpage block size to 4K.
But there is a simple patch to change it to support all block sizes <=3D=
=20
page size in my branch:

https://github.com/adam900710/linux/tree/larger_bs_support

[IOMAP WARNING]
And I'm running into a very weird kernel warning at btrfs/136, with 16K=20
block size and 64K page size.

The problem is, the problem happens with ext3 (using ext4 modeule) with=20
16K block size, and no btrfs is involved yet.

The test case btrfs/136 create an ext3 fs first, using the same block=20
size of the btrfs on TEST_DEV (so it's 16K).
Then populate the fs.

The hang happens at the ext3 populating part, with the following kernel=20
warning:

[  989.664270] run fstests btrfs/136 at 2025-08-08 16:57:37
[  990.551395] EXT4-fs (dm-3): mounting ext3 file system using the ext4=20
subsystem
[  990.554980] EXT4-fs (dm-3): mounted filesystem=20
d90f4325-e6a6-4787-9da8-150ece277a94 r/w with ordered data mode. Quota=20
mode: none.
[  990.581540] ------------[ cut here ]------------
[  990.581551] WARNING: CPU: 3 PID: 434101 at fs/iomap/iter.c:34=20
iomap_iter_done+0x148/0x190
[  990.583497] Modules linked in: dm_flakey nls_ascii nls_cp437 vfat fat=
=20
btrfs polyval_ce ghash_ce rtc_efi processor xor xor_neon raid6_pq=20
zstd_compress fuse loop nfnetlink qemu_fw_cfg ext4 crc16 mbcache jbd2=20
dm_mod xhci_pci xhci_hcd virtio_net virtio_scsi net_failover failover=20
virtio_console virtio_balloon virtio_blk virtio_mmio
[  990.587247] CPU: 3 UID: 0 PID: 434101 Comm: fsstress Not tainted=20
6.16.0-rc7-custom+ #128 PREEMPT(voluntary)
[  990.588525] Hardware name: QEMU KVM Virtual Machine, BIOS unknown=20
2/2/2022
[  990.589414] pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS=20
BTYPE=3D--)
[  990.590314] pc : iomap_iter_done+0x148/0x190
[  990.590874] lr : iomap_iter+0x174/0x230
[  990.591370] sp : ffff8000880af740
[  990.591800] x29: ffff8000880af740 x28: ffff0000db8e6840 x27:=20
0000000000000000
[  990.592716] x26: 0000000000000000 x25: ffff8000880af830 x24:=20
0000004000000000
[  990.593631] x23: 0000000000000002 x22: 000001bfdbfa8000 x21:=20
ffffa6a41c002e48
[  990.594549] x20: 0000000000000001 x19: ffff8000880af808 x18:=20
0000000000000000
[  990.595464] x17: 0000000000000000 x16: ffffa6a495ee6cd0 x15:=20
0000000000000000
[  990.596379] x14: 00000000000003d4 x13: 00000000fa83b2da x12:=20
0000b236fc95f18c
[  990.597295] x11: ffffa6a4978b9c08 x10: 0000000000001da0 x9 :=20
ffffa6a41c1a2a44
[  990.598210] x8 : ffff8000880af5c8 x7 : 0000000001000000 x6 :=20
0000000000000000
[  990.599125] x5 : 0000000000000004 x4 : 000001bfdbfa8000 x3 :=20
0000000000000000
[  990.600040] x2 : 0000000000000000 x1 : 0000004004030000 x0 :=20
0000000000000000
[  990.600955] Call trace:
[  990.601273]  iomap_iter_done+0x148/0x190 (P)
[  990.601829]  iomap_iter+0x174/0x230
[  990.602280]  iomap_fiemap+0x154/0x1d8
[  990.602751]  ext4_fiemap+0x110/0x140 [ext4]
[  990.603350]  do_vfs_ioctl+0x4b8/0xbc0
[  990.603831]  __arm64_sys_ioctl+0x8c/0x120
[  990.604346]  invoke_syscall+0x6c/0x100
[  990.604836]  el0_svc_common.constprop.0+0x48/0xf0
[  990.605444]  do_el0_svc+0x24/0x38
[  990.605875]  el0_svc+0x38/0x120
[  990.606283]  el0t_64_sync_handler+0x10c/0x138
[  990.606846]  el0t_64_sync+0x198/0x1a0
[  990.607319] ---[ end trace 0000000000000000 ]---
[  990.608042] ------------[ cut here ]------------
[  990.608047] WARNING: CPU: 3 PID: 434101 at fs/iomap/iter.c:35=20
iomap_iter_done+0x164/0x190
[  990.610842] Modules linked in: dm_flakey nls_ascii nls_cp437 vfat fat=
=20
btrfs polyval_ce ghash_ce rtc_efi processor xor xor_neon raid6_pq=20
zstd_compress fuse loop nfnetlink qemu_fw_cfg ext4 crc16 mbcache jbd2=20
dm_mod xhci_pci xhci_hcd virtio_net virtio_scsi net_failover failover=20
virtio_console virtio_balloon virtio_blk virtio_mmio
[  990.619189] CPU: 3 UID: 0 PID: 434101 Comm: fsstress Tainted: G=20
  W           6.16.0-rc7-custom+ #128 PREEMPT(voluntary)
[  990.620876] Tainted: [W]=3DWARN
[  990.621458] Hardware name: QEMU KVM Virtual Machine, BIOS unknown=20
2/2/2022
[  990.622507] pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS=20
BTYPE=3D--)
[  990.623911] pc : iomap_iter_done+0x164/0x190
[  990.624936] lr : iomap_iter+0x174/0x230
[  990.626747] sp : ffff8000880af740
[  990.627404] x29: ffff8000880af740 x28: ffff0000db8e6840 x27:=20
0000000000000000
[  990.628947] x26: 0000000000000000 x25: ffff8000880af830 x24:=20
0000004000000000
[  990.631024] x23: 0000000000000002 x22: 000001bfdbfa8000 x21:=20
ffffa6a41c002e48
[  990.632278] x20: 0000000000000001 x19: ffff8000880af808 x18:=20
0000000000000000
[  990.634189] x17: 0000000000000000 x16: ffffa6a495ee6cd0 x15:=20
0000000000000000
[  990.635608] x14: 00000000000003d4 x13: 00000000fa83b2da x12:=20
0000b236fc95f18c
[  990.637854] x11: ffffa6a4978b9c08 x10: 0000000000001da0 x9 :=20
ffffa6a41c1a2a44
[  990.639181] x8 : ffff8000880af5c8 x7 : 0000000001000000 x6 :=20
0000000000000000
[  990.642370] x5 : 0000000000000004 x4 : 000001bfdbfa8000 x3 :=20
0000000000000000
[  990.644505] x2 : 0000004004030000 x1 : 0000004004030000 x0 :=20
0000004004030000
[  990.645493] Call trace:
[  990.645841]  iomap_iter_done+0x164/0x190 (P)
[  990.646377]  iomap_iter+0x174/0x230
[  990.647550]  iomap_fiemap+0x154/0x1d8
[  990.648052]  ext4_fiemap+0x110/0x140 [ext4]
[  990.649061]  do_vfs_ioctl+0x4b8/0xbc0
[  990.649704]  __arm64_sys_ioctl+0x8c/0x120
[  990.652141]  invoke_syscall+0x6c/0x100
[  990.653001]  el0_svc_common.constprop.0+0x48/0xf0
[  990.653909]  do_el0_svc+0x24/0x38
[  990.654332]  el0_svc+0x38/0x120
[  990.654736]  el0t_64_sync_handler+0x10c/0x138
[  990.655295]  el0t_64_sync+0x198/0x1a0
[  990.655761] ---[ end trace 0000000000000000 ]---

Considering it's not yet btrfs, and the call trace is from iomap, I=20
guess there is something wrong with ext4's ext3 support?

The involved ext4 kernel configs are the following:

# CONFIG_EXT2_FS is not set
# CONFIG_EXT3_FS is not set
CONFIG_EXT4_FS=3Dm
CONFIG_EXT4_USE_FOR_EXT2=3Dy
CONFIG_EXT4_FS_POSIX_ACL=3Dy
CONFIG_EXT4_FS_SECURITY=3Dy
# CONFIG_EXT4_DEBUG is not set
CONFIG_JBD2=3Dm
# CONFIG_JBD2_DEBUG is not set

Thanks,
Qu

