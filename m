Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70BE179E2D6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Sep 2023 11:00:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239172AbjIMJAg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 13 Sep 2023 05:00:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239168AbjIMJAf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 13 Sep 2023 05:00:35 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 492C71999
        for <linux-fsdevel@vger.kernel.org>; Wed, 13 Sep 2023 01:59:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1694595585;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zg3xgaGt3YM14Q/74ywVVEdNECrsCoG2YVv1+tUkXQw=;
        b=cr/oNLryh9KrGOuOD5TIzvZvP3V86DFSN70hN53cpDT3HlIk51LUIAmQ8Sqj1C1e8q6R+O
        30ZZe6fgRtsv0if7pqM1Hdb4lvHyjIVFUadb957FYvpMvgOHioY9HF80hkKlp3IkAj6NEV
        Eh4NWl5oiH2XVyyMfd2yZ4kRPbRAjj8=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-149-qhWz-FtgN4mMg7ukQe8Wew-1; Wed, 13 Sep 2023 04:59:44 -0400
X-MC-Unique: qhWz-FtgN4mMg7ukQe8Wew-1
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-68fc8541d9cso3590370b3a.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 13 Sep 2023 01:59:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694595583; x=1695200383;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zg3xgaGt3YM14Q/74ywVVEdNECrsCoG2YVv1+tUkXQw=;
        b=uC4mMxiUhbwqbYpvW1PJETh35s6edwHQA2tasPk9MbHFt9tMBNc3RG6wVkl+d9SKXs
         HWE6nhWUV4da2B1LdlOB3y5mrPGZ8L50IHmecrZRVhvb+ruejPVt1Vy7WDEz5zBOHgMP
         qAUcdKROYnWl+UWc0uATPWbo3zE9kMd/FkaeQOfq2rAXLw4US1M+TBME/e1V9AZPuNdn
         k9bVQeyO4cykOTwf7/nHIfMfUnAd1WfwnWE/HZsnNZrCjn7NmTh0vt3QgOCuPHAn95fV
         0mX38t46oUYz6FCRkvSENHM3Tp/0ry0cBXW2cSQQUrwcME0xl2AEZQeC6quz5Kj3EctB
         +57Q==
X-Gm-Message-State: AOJu0YwJQ3d8ODlhnUCRCtqq4ksDGcvcMPJtKgWgLEOEl+48Yq/V30EN
        WARychHXNXRtz65sFdFZkinf80QZ/Xc84OJnu9LLB/PGkD4T6RA81h8cxzqYZxAFlecwYU14ihE
        CK5VyO4/tz14x2BNZ9pNzCUp0sNqW/F0bUNdv0zUx+Q==
X-Received: by 2002:a05:6a20:4409:b0:147:ecf6:c4e6 with SMTP id ce9-20020a056a20440900b00147ecf6c4e6mr2624921pzb.0.1694595582895;
        Wed, 13 Sep 2023 01:59:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEvjwGjuxLbs3G0Vtth7vyyQ5drG3y9+lL82C/9FoeyuulGiba97ar4/B83UDRUpkZnhpiW5DzYL2nEc4fFfcU=
X-Received: by 2002:a05:6a20:4409:b0:147:ecf6:c4e6 with SMTP id
 ce9-20020a056a20440900b00147ecf6c4e6mr2624903pzb.0.1694595582527; Wed, 13 Sep
 2023 01:59:42 -0700 (PDT)
MIME-Version: 1.0
References: <ZOWFtqA2om0w5Vmz@fedora> <20230823-kuppe-lassen-bc81a20dd831@brauner>
 <CAFj5m9KiBDzNHCsTjwUevZh3E3RRda2ypj9+QcRrqEsJnf9rXQ@mail.gmail.com>
In-Reply-To: <CAFj5m9KiBDzNHCsTjwUevZh3E3RRda2ypj9+QcRrqEsJnf9rXQ@mail.gmail.com>
From:   Yi Zhang <yi.zhang@redhat.com>
Date:   Wed, 13 Sep 2023 16:59:31 +0800
Message-ID: <CAHj4cs_MqqWYy+pKrNrLqTb=eoSOXcZdjPXy44x-aA1WvdVv0w@mail.gmail.com>
Subject: Re: [czhong@redhat.com: [bug report] WARNING: CPU: 121 PID: 93233 at
 fs/dcache.c:365 __dentry_kill+0x214/0x278]
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        Changhui Zhong <czhong@redhat.com>, mark.rutland@arm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The issue still can be reproduced on the latest linux tree[2].
To reproduce I need to run about 1000 times blktests block/001, and
bisect shows it was introduced with commit[1], as it was not 100%
reproduced, not sure if it's the culprit?


[1] 9257959a6e5b locking/atomic: scripts: restructure fallback ifdeffery
[2]
[ 2304.536339] scsi 48:0:0:0: CD-ROM            Linux    scsi_debug
   0191 PQ: 0 ANSI: 7
[ 2304.540805] sr 50:0:0:0: Attached scsi CD-ROM sr3
[ 2304.544574] scsi 48:0:0:0: Power-on or device reset occurred
[ 2304.600645] sr 48:0:0:0: [sr1] scsi-1 drive
[ 2304.616364] scsi 51:0:0:0: CD-ROM            Linux    scsi_debug
   0191 PQ: 0 ANSI: 7
[ 2304.624639] scsi 51:0:0:0: Power-on or device reset occurred
[ 2304.626634] sr 48:0:0:0: Attached scsi CD-ROM sr1
[ 2304.680537] sr 51:0:0:0: [sr2] scsi-1 drive
[ 2304.706394] sr 51:0:0:0: Attached scsi CD-ROM sr2
[ 2304.746329] scsi 49:0:0:0: CD-ROM            Linux    scsi_debug
   0191 PQ: 0 ANSI: 7
[ 2304.754569] scsi 49:0:0:0: Power-on or device reset occurred
[ 2304.756302] scsi 50:0:0:0: CD-ROM            Linux    scsi_debug
   0191 PQ: 0 ANSI: 7
[ 2304.768483] scsi 50:0:0:0: Power-on or device reset occurred
[ 2304.806321] scsi 48:0:0:0: CD-ROM            Linux    scsi_debug
   0191 PQ: 0 ANSI: 7
[ 2304.810587] sr 49:0:0:0: [sr0] scsi-1 drive
[ 2304.814561] scsi 48:0:0:0: Power-on or device reset occurred
[ 2304.824475] sr 50:0:0:0: [sr3] scsi-1 drive
[ 2304.836384] scsi 51:0:0:0: CD-ROM            Linux    scsi_debug
   0191 PQ: 0 ANSI: 7
[ 2304.840364] sr 49:0:0:0: Attached scsi CD-ROM sr0
[ 2304.844619] scsi 51:0:0:0: Power-on or device reset occurred
[ 2304.850444] sr 50:0:0:0: Attached scsi CD-ROM sr3
[ 2304.874563] sr 48:0:0:0: [sr1] scsi-1 drive
[ 2304.900660] sr 51:0:0:0: [sr2] scsi-1 drive
[ 2304.901506] sr 48:0:0:0: Attached scsi CD-ROM sr1
[ 2304.926306] sr 51:0:0:0: Attached scsi CD-ROM sr2
[ 2305.056432] scsi 50:0:0:0: CD-ROM            Linux    scsi_debug
   0191 PQ: 0 ANSI: 7
[ 2305.056572] scsi 49:0:0:0: CD-ROM            Linux    scsi_debug
   0191 PQ: 0 ANSI: 7
[ 2305.064635] scsi 50:0:0:0: Power-on or device reset occurred
[ 2305.072821] scsi 49:0:0:0: Power-on or device reset occurred
[ 2305.086286] scsi 51:0:0:0: CD-ROM            Linux    scsi_debug
   0191 PQ: 0 ANSI: 7
[ 2305.086357] scsi 48:0:0:0: CD-ROM            Linux    scsi_debug
   0191 PQ: 0 ANSI: 7
[ 2305.094521] scsi 51:0:0:0: Power-on or device reset occurred
[ 2305.102693] scsi 48:0:0:0: Power-on or device reset occurred
[ 2305.128785] sr 50:0:0:0: [sr0] scsi-1 drive
[ 2305.134445] sr 49:0:0:0: [sr1] scsi-1 drive
[ 2305.154728] sr 50:0:0:0: Attached scsi CD-ROM sr0
[ 2305.158607] sr 51:0:0:0: [sr2] scsi-1 drive
[ 2305.160392] sr 49:0:0:0: Attached scsi CD-ROM sr1
[ 2305.164254] sr 48:0:0:0: [sr3] scsi-1 drive
[ 2305.184185] sr 51:0:0:0: Attached scsi CD-ROM sr2
[ 2305.190086] sr 48:0:0:0: Attached scsi CD-ROM sr3
[ 2305.555658] Unable to handle kernel execute from non-executable
memory at virtual address ffffc61b656052e8
[ 2305.565301] Mem abort info:
[ 2305.568086]   ESR =3D 0x000000008600000e
[ 2305.571822]   EC =3D 0x21: IABT (current EL), IL =3D 32 bits
[ 2305.577123]   SET =3D 0, FnV =3D 0
[ 2305.580164]   EA =3D 0, S1PTW =3D 0
[ 2305.583292]   FSC =3D 0x0e: level 2 permission fault
[ 2305.588074] swapper pgtable: 4k pages, 48-bit VAs, pgdp=3D0000080731fa00=
00
[ 2305.594761] [ffffc61b656052e8] pgd=3D1000080ffffff003,
p4d=3D1000080ffffff003, pud=3D1000080fffffe003, pmd=3D0068080732e00f01
[ 2305.605362] Internal error: Oops: 000000008600000e [#1] SMP
[ 2305.610922] Modules linked in: scsi_debug sr_mod pktcdvd cdrom
rfkill sunrpc vfat fat acpi_ipmi arm_spe_pmu ipmi_ssif ipmi_devintf
ipmi_msghandler arm_cmn arm_dmc620_pmu arm_dsu_pmu cppc_cpufreq loop
fuse zram xfs crct10dif_ce ghash_ce nvme sha2_ce nvme_core
sha256_arm64 igb sha1_ce ast sbsa_gwdt nvme_common
i2c_designware_platform i2c_algo_bit i2c_designware_core xgene_hwmon
dm_mod [last unloaded: scsi_debug]
[ 2305.647236] CPU: 85 PID: 1 Comm: systemd Kdump: loaded Not tainted
6.6.0-rc1+ #13
[ 2305.654706] Hardware name: GIGABYTE R152-P31-00/MP32-AR1-00, BIOS
F31n (SCP: 2.10.20220810) 09/30/2022
[ 2305.663997] pstate: 20400009 (nzCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=
=3D--)
[ 2305.670946] pc : in_lookup_hashtable+0x1138/0x2000
[ 2305.675728] lr : rcu_do_batch+0x194/0x488
[ 2305.679727] sp : ffff8000802abe60
[ 2305.683029] x29: ffff8000802abe60 x28: ffffc61b6524c7c0 x27: ffffc61b634=
52f40
[ 2305.690152] x26: ffff080f37ab6438 x25: 000000000000000a x24: 00000000000=
00000
[ 2305.697274] x23: 0000000000000002 x22: ffff8000802abec0 x21: ffff080f37a=
b63c0
[ 2305.704396] x20: ffff07ff8136a580 x19: 0000000000000003 x18: 00000000000=
00000
[ 2305.711519] x17: ffff41f3d3161000 x16: ffff8000802a8000 x15: 00000000000=
00000
[ 2305.718641] x14: 0000000000000000 x13: ffff07ffa131802d x12: ffff8000804=
1bb94
[ 2305.725764] x11: 0000000000000040 x10: ffff07ff802622e8 x9 : ffffc61b634=
52e30
[ 2305.732887] x8 : 000002189dce1780 x7 : ffff07ff8d5c1000 x6 : ffff41f3d31=
61000
[ 2305.740009] x5 : ffff07ff8136a580 x4 : ffff080f37aba960 x3 : 00000000155=
0a055
[ 2305.747131] x2 : 0000000000000000 x1 : ffffc61b656052e8 x0 : ffff080184c=
565f0
[ 2305.754254] Call trace:
[ 2305.756687]  in_lookup_hashtable+0x1138/0x2000
[ 2305.761119]  rcu_core+0x268/0x350
[ 2305.764422]  rcu_core_si+0x18/0x30
[ 2305.767812]  __do_softirq+0x120/0x3d4
[ 2305.771462]  ____do_softirq+0x18/0x30
[ 2305.775112]  call_on_irq_stack+0x24/0x30
[ 2305.779022]  do_softirq_own_stack+0x24/0x38
[ 2305.783192]  __irq_exit_rcu+0xfc/0x130
[ 2305.786929]  irq_exit_rcu+0x18/0x30
[ 2305.790404]  el1_interrupt+0x4c/0xe8
[ 2305.793969]  el1h_64_irq_handler+0x18/0x28
[ 2305.798052]  el1h_64_irq+0x78/0x80
[ 2305.801441]  d_same_name+0x50/0xd0
[ 2305.804832]  __lookup_slow+0x64/0x158
[ 2305.808482]  walk_component+0xe0/0x1a0
[ 2305.812219]  path_lookupat+0x7c/0x1b8
[ 2305.815869]  filename_lookup+0xb4/0x1b8
[ 2305.819692]  vfs_statx+0x94/0x1a8
[ 2305.822995]  vfs_fstatat+0xd4/0x110
[ 2305.826471]  __do_sys_newfstatat+0x58/0xa8
[ 2305.830556]  __arm64_sys_newfstatat+0x28/0x40
[ 2305.834901]  invoke_syscall.constprop.0+0x80/0xd8
[ 2305.839592]  do_el0_svc+0x48/0xd0
[ 2305.842894]  el0_svc+0x4c/0x1c0
[ 2305.846023]  el0t_64_sync_handler+0x120/0x130
[ 2305.850367]  el0t_64_sync+0x1a4/0x1a8
[ 2305.854017] Code: 00000000 00000000 00000000 00000000 (84c565f1)
[ 2305.860098] SMP: stopping secondary CPUs
[ 2305.865048] Starting crashdump kernel...
[ 2305.868958] Bye!


On Mon, Aug 28, 2023 at 6:43=E2=80=AFPM Ming Lei <ming.lei@redhat.com> wrot=
e:
>
> On Wed, Aug 23, 2023 at 4:47=E2=80=AFPM Christian Brauner <brauner@kernel=
.org> wrote:
> >
> > On Wed, Aug 23, 2023 at 12:06:14PM +0800, Ming Lei wrote:
> > >
> > > Looks the issue is more related with vfs, so forward to vfs list.
> > >
> > > ----- Forwarded message from Changhui Zhong <czhong@redhat.com> -----
> > >
> > > Date: Wed, 23 Aug 2023 11:17:55 +0800
> > > From: Changhui Zhong <czhong@redhat.com>
> > > To: linux-scsi@vger.kernel.org
> > > Cc: Ming Lei <ming.lei@redhat.com>
> > > Subject: [bug report] WARNING: CPU: 121 PID: 93233 at fs/dcache.c:365=
 __dentry_kill+0x214/0x278
> > >
> > > Hello,
> > >
> > > triggered below warning issue with branch
> > > "
> > > Tree: mainline.kernel.org-clang
> > > Repository: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/=
linux.git
> > > @ master
> > > Commit Hash: 89bf6209cad66214d3774dac86b6bbf2aec6a30d
> > > Commit Name: v6.5-rc7-18-g89bf6209cad6
> > > Kernel information:
> > > Commit message: Merge tag 'devicetree-fixes-for-6.5-2' of
> > > git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux
> > > "
> > > for more detail=EF=BC=8Cplease check
> > > https://datawarehouse.cki-project.org/kcidb/tests/9232643
> > >
> > > #modprobe scsi_debug virtual_gb=3D128
> > > #echo none > /sys/block/sdb/queue/scheduler
> > > #fio --bs=3D4k --ioengine=3Dlibaio --iodepth=3D1 --numjobs=3D4 --rw=
=3Drandrw
> > > --name=3Dsdb-libaio-randrw-4k --filename=3D/dev/sdb --direct=3D1 --si=
ze=3D60G
> > > --runtime=3D60
> >
> > Looking at this issue it seems unlikely that this is a vfs bug.
> > We should see this all over the place and specifically not just on arm6=
4.
> >
> > The sequence here seems to be:
> >
> > echo 4 > /proc/sys/vm/drop_caches
> > rmmod scsi_debug > /dev/null 3>&1
> >
> > [ 3117.059778] WARNING: CPU: 121 PID: 93233 at fs/dcache.c:365 __dentry=
_kill+0x214/0x278
> > [ 3117.067601] Modules linked in: scsi_debug nvme nvme_core nvme_common=
 null_blk pktcdvd ipmi_watchdog ipmi_poweroff rfkill sunrpc vfat fat acpi_i=
pmi ipmi_ssif arm_spe_pmu igb ipmi_devintf ipmi_msghandler arm_cmn arm_dmc6=
20_pmu cppc_cpufreq arm_dsu_pmu acpi_tad loop fuse zram xfs crct10dif_ce po=
lyval_ce polyval_generic ghash_ce sbsa_gwdt ast onboard_usb_hub i2c_algo_bi=
t xgene_hwmon [last unloaded: scsi_debug]
> >
> > So my money is on some device that gets removed still having an
> > increased refcount and pinning the dentry. Immediate suspects would be:
> >
> > 7882541ca06d ("of/platform: increase refcount of fwnode")
> >
> > but that part is complete speculation on my part.
>
> BTW, just saw another panic on 6.5-rc7, still scsi_debug test on arm64:
>
> [  959.371726] sr 50:0:0:0: Attached scsi generic sg1 type 5
> [  959.603145] scsi 48:0:0:0: CD-ROM            Linux    scsi_debug
>    0191 PQ: 0 ANSI: 7
> [  959.603155] scsi 50:0:0:0: CD-ROM            Linux    scsi_debug
>    0191 PQ: 0 ANSI: 7
> [  959.603950] scsi 49:0:0:0: CD-ROM            Linux    scsi_debug
>    0191 PQ: 0 ANSI: 7
> [  959.604052] scsi 49:0:0:0: Power-on or device reset occurred
> [  959.609336] sr 49:0:0:0: [sr1] scsi-1 drive
> [  959.611360] scsi 48:0:0:0: Power-on or device reset occurred
> [  959.614540] Unable to handle kernel paging request at virtual
> address 65888c2e6fe694d5
> [  959.614544] Mem abort info:
> [  959.614545]   ESR =3D 0x0000000096000004
> [  959.614547]   EC =3D 0x25: DABT (current EL), IL =3D 32 bits
> [  959.614550]   SET =3D 0, FnV =3D 0
> [  959.614552]   EA =3D 0, S1PTW =3D 0
> [  959.614553]   FSC =3D 0x04: level 0 translation fault
> [  959.614555] Data abort info:
> [  959.614556]   ISV =3D 0, ISS =3D 0x00000004, ISS2 =3D 0x00000000
> [  959.614559]   CM =3D 0, WnR =3D 0, TnD =3D 0, TagAccess =3D 0
> [  959.614561]   GCS =3D 0, Overlay =3D 0, DirtyBit =3D 0, Xs =3D 0
> [  959.614563] [65888c2e6fe694d5] address between user and kernel address=
 ranges
> [  959.614566] Internal error: Oops: 0000000096000004 [#1] SMP
> [  959.614570] Modules linked in: pktcdvd scsi_debug ipmi_watchdog
> ipmi_poweroff rfkill sunrpc vfat fat acpi_ipmi ipmi_ssif arm_spe_pmu
> igb ipmi_devintf arm_cmn ipmi_msghandler arm_dmc620_pmu arm_dsu_pmu
> cppc_cpufreq acpi_tad loop fuse zram xfs nvme crct10dif_ce polyval_ce
> nvme_core polyval_generic ghash_ce sbsa_gwdt nvme_common ast
> onboard_usb_hub i2c_algo_bit xgene_hwmon [last unloaded: scsi_debug]
> [  959.614620] CPU: 108 PID: 19529 Comm: check Not tainted 6.5.0-rc7 #1
> [  959.614625] Hardware name: GIGABYTE R152-P31-00/MP32-AR1-00, BIOS
> F31n (SCP: 2.10.20220810) 09/30/2022
> [  959.614627] pstate: 80400009 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYP=
E=3D--)
> [  959.614632] pc : d_alloc_parallel+0x140/0x440
> [  959.614641] lr : d_alloc_parallel+0xcc/0x440
> [  959.614646] sp : ffff80008a7d3290
> [  959.614647] x29: ffff80008a7d3290 x28: ffff07ff8230c530 x27: 65888c2e6=
fe69565
> [  959.614654] x26: ffffcb72eac9e1d0 x25: ffff80008a7d33d8 x24: ffff07ffa=
0fd3800
> [  959.614659] x23: 00000000000003c0 x22: 000000007a701548 x21: ffffcb72e=
ac9ffd0
> [  959.614664] x20: ffff07ffa0fd35c0 x19: ffffcb72ea6e9600 x18: fffffffff=
fffffff
> [  959.614670] x17: 00000000440fd8e0 x16: 00000000b6431329 x15: ffff80008=
a7d3360
> [  959.614675] x14: ffff80008a7d3508 x13: ffffcb72e94da6d0 x12: ffff80008=
a7d334c
> [  959.614680] x11: 0000000c7a701548 x10: ffff3c8cb54590b8 x9 : ffffcb72e=
80832f4
> [  959.614685] x8 : ffff07ffa0fd35c0 x7 : 7473696c5f71725f x6 : 000000000=
0200008
> [  959.614690] x5 : ffffcb72ea6f4000 x4 : 00000000003d380a x3 : 000000000=
0000004
> [  959.614696] x2 : ffff80008a7d331c x1 : ffff07ffe1760000 x0 : 000000000=
0005000
> [  959.614701] Call trace:
> [  959.614703]  d_alloc_parallel+0x140/0x440
> [  959.614708]  __lookup_slow+0x64/0x158
> [  959.614714]  lookup_one_len+0xac/0xc8
> [  959.614719]  start_creating.part.0+0x88/0x198
> [  959.614725]  __debugfs_create_file+0x70/0x230
> [  959.614730]  debugfs_create_file+0x34/0x48
> [  959.614734]  blk_mq_debugfs_register_hctx+0x154/0x1d0
> [  959.614740]  blk_mq_debugfs_register+0xfc/0x1e0
> [  959.614745]  blk_register_queue+0xc0/0x1f0
> [  959.614750]  device_add_disk+0x1dc/0x3e0
> [  959.614754]  sr_probe+0x2c0/0x368
> [  959.614760]  really_probe+0x190/0x3d8
> [  959.614766]  __driver_probe_device+0x84/0x180
> [  959.614771]  driver_probe_device+0x44/0x120
> [  959.614776]  __device_attach_driver+0xc4/0x168
> [  959.614781]  bus_for_each_drv+0x8c/0xf0
> [  959.614785]  __device_attach+0xa4/0x1c0
> [  959.614790]  device_initial_probe+0x1c/0x30
> [  959.614795]  bus_probe_device+0xb4/0xc0
> [  959.614799]  device_add+0x508/0x6f8
> [  959.614803]  scsi_sysfs_add_sdev+0x8c/0x250
> [  959.614809]  scsi_add_lun+0x424/0x558
> [  959.614813]  scsi_probe_and_add_lun+0x11c/0x430
> [  959.614817]  __scsi_scan_target+0xb8/0x258
> [  959.614821]  scsi_scan_channel+0xa0/0xb8
> [  959.614825]  scsi_scan_host_selected+0x170/0x188
> [  959.614830]  store_scan+0x194/0x1a8
> [  959.614835]  dev_attr_store+0x20/0x40
> [  959.614840]  sysfs_kf_write+0x4c/0x68
> [  959.614845]  kernfs_fop_write_iter+0x13c/0x1d8
> [  959.614849]  vfs_write+0x1c0/0x310
> [  959.614855]  ksys_write+0x78/0x118
> [  959.614859]  __arm64_sys_write+0x24/0x38
> [  959.614864]  invoke_syscall+0x78/0x100
> [  959.614868]  el0_svc_common.constprop.0+0x4c/0xf8
> [  959.614871]  do_el0_svc+0x34/0x50
> [  959.614874]  el0_svc+0x34/0x108
> [  959.614879]  el0t_64_sync_handler+0x120/0x130
> [  959.614884]  el0t_64_sync+0x194/0x198
> [  959.614889] Code: 54000088 14000067 f940037b b4000cbb (b8570360)
> [  959.614892] ---[ end trace 0000000000000000 ]---
> [  959.614895] Kernel panic - not syncing: Oops: Fatal exception
> [  959.614897] SMP: stopping secondary CPUs
> [  959.619492] Kernel Offset: 0x4b7267c40000 from 0xffff800080000000
> [  959.619494] PHYS_OFFSET: 0x80000000
> [  959.619496] CPU features: 0x00000010,b80140a1,8841720b
> [  959.619498] Memory Limit: none
> [  960.040819] ---[ end Kernel panic - not syncing: Oops: Fatal exception=
 ]---
>


--=20
Best Regards,
  Yi Zhang

