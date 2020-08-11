Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA129241A44
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Aug 2020 13:20:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728732AbgHKLTv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Aug 2020 07:19:51 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:17314 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728724AbgHKLTu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Aug 2020 07:19:50 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f327e6c0000>; Tue, 11 Aug 2020 04:18:04 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Tue, 11 Aug 2020 04:19:49 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Tue, 11 Aug 2020 04:19:49 -0700
Received: from [10.2.56.80] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 11 Aug
 2020 11:19:48 +0000
Subject: Re: btrfs crash in kobject_del while running xfstest
From:   John Hubbard <jhubbard@nvidia.com>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, <linux-btrfs@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
CC:     linux-fsdevel <linux-fsdevel@vger.kernel.org>
References: <200e5b49-5c51-bbe5-de93-c6bd6339bb7f@nvidia.com>
Message-ID: <2a3eb48d-6ca1-61c6-20cf-ba2fbda21f45@nvidia.com>
Date:   Tue, 11 Aug 2020 04:19:47 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <200e5b49-5c51-bbe5-de93-c6bd6339bb7f@nvidia.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1597144684; bh=zFtAbPZdWaO97kUqdFPAa8G34TZ9heuYOs9focgzlik=;
        h=X-PGP-Universal:Subject:From:To:CC:References:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=C1+8hZ/9mJMSMaDjXyL7oLnM5ZF5aMV+xA0AXi8rsoA/pQBR8fmu095PK0f9X+1qt
         8BNaHoSwExaDSr9/ugJYkkHWqzTYnSPcCECHe99fccgw4X8viSJvirGJQjq83l0A9m
         Cb0X21oyiartmN61vkAoAkTOMG3Ey6oAgowsCKC2X//l58w25Aac1ZdJCh+WMX0EwX
         7s5X2eseN6qBQkygvGSs25sfcu9NHnz7lAsRgmcwKw6HBao+E4TpSNdn/nV4u+oeB9
         BknalryQ5Wle4l1F/aNspmakisWCqu3klNssknlznGMtrUjSz3fSrFUr2i88cFub+0
         t0GiLhj0da2Lw==
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Somehow the copy-paste of Chris Mason's name failed (user error
on my end), sorry about that Chris!

On 8/11/20 4:17 AM, John Hubbard wrote:
> Hi,
>=20
> Here's an early warning of a possible problem.
>=20
> I'm seeing a new btrfs crash when running xfstests, as of
> 00e4db51259a5f936fec1424b884f029479d3981 ("Merge tag
> 'perf-tools-2020-08-10' of
> git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux") in linux.git.
>=20
> This doesn't crash in v5.8, so I attempted to bisect, but ended up with
> the net-next merge commit as the offending one: commit
> 47ec5303d73ea344e84f46660fff693c57641386 ("Merge
> git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next"), which
> doesn't really help because it's 2088 files changed, of course.
>=20
> I'm attaching the .config that I used.
>=20
> This is easily reproducible via something like (change to match your setu=
p,
> of course):
>=20
>  =C2=A0=C2=A0=C2=A0 sudo TEST_DEV=3D/dev/nvme0n1p8 TEST_DIR=3D/xfstest_bt=
rfs \
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 SCRATCH_DEV=3D/dev/nvme0n1p9 SCRATCH_MNT=
=3D/xfstest_scratch=C2=A0 ./check \
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 btrfs/002
>=20
> which leads to:
>=20
> [=C2=A0 586.097360] BTRFS info (device nvme0n1p8): disk space caching is =
enabled
> [=C2=A0 586.103232] BTRFS info (device nvme0n1p8): has skinny extents
> [=C2=A0 586.115169] BTRFS info (device nvme0n1p8): enabling ssd optimizat=
ions
> [=C2=A0 586.308264] BTRFS: device fsid 5dfff89d-8f8d-42ac-8538-acb95164d0=
be devid 1 transid 5=20
> /dev/nvme0n1p9 scanned by mkfs.btrfs (6374)
> [=C2=A0 586.342776] BTRFS info (device nvme0n1p9): disk space caching is =
enabled
> [=C2=A0 586.348585] BTRFS info (device nvme0n1p9): has skinny extents
> [=C2=A0 586.353413] BTRFS info (device nvme0n1p9): flagging fs with big m=
etadata feature
> [=C2=A0 586.368129] BTRFS info (device nvme0n1p9): enabling ssd optimizat=
ions
> [=C2=A0 586.373996] BTRFS info (device nvme0n1p9): checking UUID tree
> [=C2=A0 586.387449] BUG: kernel NULL pointer dereference, address: 000000=
0000000018
> [=C2=A0 586.393485] #PF: supervisor read access in kernel mode
> [=C2=A0 586.397623] #PF: error_code(0x0000) - not-present page
> [=C2=A0 586.401763] PGD 0 P4D 0
> [=C2=A0 586.403219] Oops: 0000 [#1] SMP PTI
> [=C2=A0 586.405650] CPU: 1 PID: 6405 Comm: umount Not tainted 5.8.0-hubba=
rd-github+ #171
> [=C2=A0 586.412118] Hardware name: Gigabyte Technology Co., Ltd. To be fi=
lled by O.E.M./X99-UD3P-CF, BIOS=20
> F1 02/10/2015
> [=C2=A0 586.421360] RIP: 0010:kobject_del+0x1/0x20
> [=C2=A0 586.424427] Code: 48 c7 43 18 00 00 00 00 5b 5d c3 c3 be 01 00 00=
 00 48 89 df e8 60 1b 00 00 eb=20
> c9 66 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 55 <48> 8b 6f 18 e8 86 ff ff=
 ff 48 89 ef 5d e9 cd fe ff=20
> ff 66 66 2e 0f
> [=C2=A0 586.442644] RSP: 0018:ffffc90009ef7e08 EFLAGS: 00010246
> [=C2=A0 586.446914] RAX: 0000000000000000 RBX: ffff888896080000 RCX: 0000=
000000000006
> [=C2=A0 586.453149] RDX: ffff88888ee4b000 RSI: ffffffff82669a00 RDI: 0000=
000000000000
> [=C2=A0 586.459390] RBP: 0000000000000000 R08: 0000000000000000 R09: 0000=
000000000001
> [=C2=A0 586.465631] R10: 0000000000000001 R11: 0000000000000000 R12: ffff=
888896080000
> [=C2=A0 586.471866] R13: 0000000000000000 R14: 0000000000000000 R15: 0000=
000000000000
> [=C2=A0 586.478106] FS:=C2=A0 00007f5595739c80(0000) GS:ffff88889fc40000(=
0000) knlGS:0000000000000000
> [=C2=A0 586.485325] CS:=C2=A0 0010 DS: 0000 ES: 0000 CR0: 000000008005003=
3
> [=C2=A0 586.490129] CR2: 0000000000000018 CR3: 0000000896d5a006 CR4: 0000=
0000001706e0
> [=C2=A0 586.496372] Call Trace:
> [=C2=A0 586.497807]=C2=A0 btrfs_sysfs_del_qgroups+0xa5/0xe0 [btrfs]
> [=C2=A0 586.502017]=C2=A0 close_ctree+0x1c5/0x2b6 [btrfs]
> [=C2=A0 586.505307]=C2=A0 ? fsnotify_destroy_marks+0x24/0x124
> [=C2=A0 586.508948]=C2=A0 generic_shutdown_super+0x67/0x100
> [=C2=A0 586.512408]=C2=A0 kill_anon_super+0x14/0x30
> [=C2=A0 586.515159]=C2=A0 btrfs_kill_super+0x12/0x20 [btrfs]
> [=C2=A0 586.518704]=C2=A0 deactivate_locked_super+0x36/0x90
> [=C2=A0 586.522159]=C2=A0 cleanup_mnt+0x12d/0x190
> [=C2=A0 586.524720]=C2=A0 task_work_run+0x5c/0xa0
> [=C2=A0 586.527285]=C2=A0 exit_to_user_mode_loop+0xb9/0xc0
> [=C2=A0 586.530648]=C2=A0 exit_to_user_mode_prepare+0xab/0xe0
> [=C2=A0 586.534276]=C2=A0 syscall_exit_to_user_mode+0x17/0x50
> [=C2=A0 586.537908]=C2=A0 entry_SYSCALL_64_after_hwframe+0x44/0xa9
> [=C2=A0 586.541984] RIP: 0033:0x7f55959896fb
> [=C2=A0 586.544531] Code: 07 0c 00 f7 d8 64 89 01 48 83 c8 ff c3 66 90 f3=
 0f 1e fa 31 f6 e9 05 00 00 00=20
> 0f 1f 44 00 00 f3 0f 1e fa b8 a6 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01=
 c3 48 8b 0d 5d 07 0c 00 f7=20
> d8 64 89 01 48
> [=C2=A0 586.562775] RSP: 002b:00007fffcc431228 EFLAGS: 00000246 ORIG_RAX:=
 00000000000000a6
> [=C2=A0 586.569485] RAX: 0000000000000000 RBX: 00007f5595ab31e4 RCX: 0000=
7f55959896fb
> [=C2=A0 586.575753] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000=
5601fb16bb80
> [=C2=A0 586.582020] RBP: 00005601fb16b970 R08: 0000000000000000 R09: 0000=
7fffcc42ffa0
> [=C2=A0 586.588278] R10: 00005601fb16c930 R11: 0000000000000246 R12: 0000=
5601fb16bb80
> [=C2=A0 586.594534] R13: 0000000000000000 R14: 00005601fb16ba68 R15: 0000=
000000000000
> [=C2=A0 586.600805] Modules linked in: xfs rpcsec_gss_krb5 auth_rpcgss nf=
sv4 dns_resolver nfs lockd grace=20
> fscache bpfilter dm_mirror dm_region_hash dm_log dm_mod iTCO_wdt iTCO_ven=
dor_support=20
> x86_pkg_temp_thermal coretemp crct10dif_pclmul crc32_pclmul btrfs ghash_c=
lmulni_intel aesni_intel=20
> blake2b_generic crypto_simd xor cryptd zstd_compress glue_helper input_le=
ds raid6_pq libcrc32c=20
> lpc_ich i2c_i801 mfd_core mei_me i2c_smbus mei rpcrdma sunrpc ib_isert is=
csi_target_mod ib_iser=20
> libiscsi ib_srpt target_core_mod ib_srp ib_ipoib rdma_ucm ib_uverbs ib_um=
ad sr_mod cdrom sd_mod=20
> nouveau ahci libahci nvme crc32c_intel video e1000e led_class nvme_core l=
ibata t10_pi ttm mxm_wmi=20
> wmi fuse
> [=C2=A0 586.661098] CR2: 0000000000000018
> [=C2=A0 586.663455] ---[ end trace 158f42d646f4715d ]---
>=20
> A quick peek shows that this is crashing here:
>=20
> void kobject_del(struct kobject *kobj)
> {
>  =C2=A0=C2=A0=C2=A0=C2=A0struct kobject *parent =3D kobj->parent; <---- C=
RASHES HERE with NULL kobj
>=20
>  =C2=A0=C2=A0=C2=A0=C2=A0__kobject_del(kobj);
>  =C2=A0=C2=A0=C2=A0=C2=A0kobject_put(parent);
> }
> EXPORT_SYMBOL(kobject_del);
>=20
> The crash at 0x18 matches passes in a null, because that's the right offs=
et for
> ->parent, and the disassembly confirms that 0x18 gets offset right at kob=
ject_del+0x1:
>=20
> Dump of assembler code for function kobject_del:
>  =C2=A0=C2=A0 0xffffffff81534ec0 <+0>:=C2=A0=C2=A0=C2=A0=C2=A0 push=C2=A0=
=C2=A0 %rbp
>  =C2=A0=C2=A0 0xffffffff81534ec1 <+1>:=C2=A0=C2=A0=C2=A0=C2=A0 mov=C2=A0=
=C2=A0=C2=A0 0x18(%rdi),%rbp
>  =C2=A0=C2=A0 0xffffffff81534ec5 <+5>:=C2=A0=C2=A0=C2=A0=C2=A0 callq=C2=
=A0 0xffffffff81534e50 <__kobject_del>
>  =C2=A0=C2=A0 0xffffffff81534eca <+10>:=C2=A0=C2=A0=C2=A0 mov=C2=A0=C2=A0=
=C2=A0 %rbp,%rdi
>  =C2=A0=C2=A0 0xffffffff81534ecd <+13>:=C2=A0=C2=A0=C2=A0 pop=C2=A0=C2=A0=
=C2=A0 %rbp
>  =C2=A0=C2=A0 0xffffffff81534ece <+14>:=C2=A0=C2=A0=C2=A0 jmpq=C2=A0=C2=
=A0 0xffffffff81534da0 <kobject_put>
> End of assembler dump.
>=20
> But as for how we ended up with a null kobj here, that's actually hard to=
 see, at least
> for a non-btrfs person, which is why I hoped git bisect would help more t=
han it did here.
>=20
>=20
> thanks,

thanks,
--=20
John Hubbard
NVIDIA
