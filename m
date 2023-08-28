Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F9EE78AD2D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Aug 2023 12:46:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231931AbjH1KqX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 28 Aug 2023 06:46:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231984AbjH1KqC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 28 Aug 2023 06:46:02 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94D39EA
        for <linux-fsdevel@vger.kernel.org>; Mon, 28 Aug 2023 03:44:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1693219415;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=I49NCLZkXxpzpCun8EBdWIYZuEM4UWE9z0FhWjOWgmo=;
        b=P79yCYt0Uob5jYmzPpRlVLxSw7jvnGImUjNhIF17gbtucNbIj5E9osH9z3ygEtJmcsD2Ma
        NSNAjG2d/InY8N+GPanpZWDcHKAjqXvuw9bpuiOTahLkNytmpObGWYnTJf50k/HeqbU0w1
        lIC1WxQ72H1fKwhWIQvH/0qHNEOx6OY=
Received: from mail-ua1-f72.google.com (mail-ua1-f72.google.com
 [209.85.222.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-407-VwDDZOM8NLSvqWi6hgO-CQ-1; Mon, 28 Aug 2023 06:43:34 -0400
X-MC-Unique: VwDDZOM8NLSvqWi6hgO-CQ-1
Received: by mail-ua1-f72.google.com with SMTP id a1e0cc1a2514c-79499607027so321223241.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 28 Aug 2023 03:43:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693219414; x=1693824214;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I49NCLZkXxpzpCun8EBdWIYZuEM4UWE9z0FhWjOWgmo=;
        b=TBwGRhXpB+O98hjUJ1iCREBLDDe8qnxz/4irBqrYjTl3qGr+5yoNo/PA4ht/A9gZQr
         1UFnyytzxjlTaBPhgoDTrsS3Hsoikcz/SCjKi3QMpZ9sf1l1uN6zZzRYfO9L4T/FhMSP
         gKw9Ah2fyLoNaka3HGDpOvgmXvXs+EMNl1MjmBvD+yI4St/R79ym0YNrympmi/SYRwJU
         0BCeU98lB9zym3m8qFoEAW8sEF203shOJOoxFIGk3P+PS+xbzf0vKUBAxPHXDJMkn0jj
         gePtCVig8MBH/JmmAnW6eQGIShKadq21xiy24jtCfNrn0uno+24OQ5dSZFpt8EiqhQXw
         vN7Q==
X-Gm-Message-State: AOJu0YxlgHuI9JNVB94CQKiTgay+kH4pEO5XrKkw1I1Vizt3bhh+bhHl
        AJ8rFj2sOeBP5R6c6iP7q9ehI4q1rZ0RFzvqjcSumm99yNYqnEcSkrpuDYa74okYoR5Fammw1PX
        HL1vjlckRB7VXaIXMK+KdrCEN9TrzY4L0yK4Uqd4j3g==
X-Received: by 2002:a67:ef01:0:b0:44e:c238:a417 with SMTP id j1-20020a67ef01000000b0044ec238a417mr1216872vsr.0.1693219414042;
        Mon, 28 Aug 2023 03:43:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFHgZu5Z5cA8smSC8fJL5JMfQxmXaHZ+3/38HPJl8mqlzBazlB7xE2IABpWoVtW5FrYL1TcvjIFInoh7hK6biw=
X-Received: by 2002:a67:ef01:0:b0:44e:c238:a417 with SMTP id
 j1-20020a67ef01000000b0044ec238a417mr1216864vsr.0.1693219413795; Mon, 28 Aug
 2023 03:43:33 -0700 (PDT)
MIME-Version: 1.0
References: <ZOWFtqA2om0w5Vmz@fedora> <20230823-kuppe-lassen-bc81a20dd831@brauner>
In-Reply-To: <20230823-kuppe-lassen-bc81a20dd831@brauner>
From:   Ming Lei <ming.lei@redhat.com>
Date:   Mon, 28 Aug 2023 18:43:22 +0800
Message-ID: <CAFj5m9KiBDzNHCsTjwUevZh3E3RRda2ypj9+QcRrqEsJnf9rXQ@mail.gmail.com>
Subject: Re: [czhong@redhat.com: [bug report] WARNING: CPU: 121 PID: 93233 at
 fs/dcache.c:365 __dentry_kill+0x214/0x278]
To:     Christian Brauner <brauner@kernel.org>
Cc:     linux-fsdevel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        Changhui Zhong <czhong@redhat.com>,
        Yi Zhang <yi.zhang@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Aug 23, 2023 at 4:47=E2=80=AFPM Christian Brauner <brauner@kernel.o=
rg> wrote:
>
> On Wed, Aug 23, 2023 at 12:06:14PM +0800, Ming Lei wrote:
> >
> > Looks the issue is more related with vfs, so forward to vfs list.
> >
> > ----- Forwarded message from Changhui Zhong <czhong@redhat.com> -----
> >
> > Date: Wed, 23 Aug 2023 11:17:55 +0800
> > From: Changhui Zhong <czhong@redhat.com>
> > To: linux-scsi@vger.kernel.org
> > Cc: Ming Lei <ming.lei@redhat.com>
> > Subject: [bug report] WARNING: CPU: 121 PID: 93233 at fs/dcache.c:365 _=
_dentry_kill+0x214/0x278
> >
> > Hello,
> >
> > triggered below warning issue with branch
> > "
> > Tree: mainline.kernel.org-clang
> > Repository: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/li=
nux.git
> > @ master
> > Commit Hash: 89bf6209cad66214d3774dac86b6bbf2aec6a30d
> > Commit Name: v6.5-rc7-18-g89bf6209cad6
> > Kernel information:
> > Commit message: Merge tag 'devicetree-fixes-for-6.5-2' of
> > git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux
> > "
> > for more detail=EF=BC=8Cplease check
> > https://datawarehouse.cki-project.org/kcidb/tests/9232643
> >
> > #modprobe scsi_debug virtual_gb=3D128
> > #echo none > /sys/block/sdb/queue/scheduler
> > #fio --bs=3D4k --ioengine=3Dlibaio --iodepth=3D1 --numjobs=3D4 --rw=3Dr=
andrw
> > --name=3Dsdb-libaio-randrw-4k --filename=3D/dev/sdb --direct=3D1 --size=
=3D60G
> > --runtime=3D60
>
> Looking at this issue it seems unlikely that this is a vfs bug.
> We should see this all over the place and specifically not just on arm64.
>
> The sequence here seems to be:
>
> echo 4 > /proc/sys/vm/drop_caches
> rmmod scsi_debug > /dev/null 3>&1
>
> [ 3117.059778] WARNING: CPU: 121 PID: 93233 at fs/dcache.c:365 __dentry_k=
ill+0x214/0x278
> [ 3117.067601] Modules linked in: scsi_debug nvme nvme_core nvme_common n=
ull_blk pktcdvd ipmi_watchdog ipmi_poweroff rfkill sunrpc vfat fat acpi_ipm=
i ipmi_ssif arm_spe_pmu igb ipmi_devintf ipmi_msghandler arm_cmn arm_dmc620=
_pmu cppc_cpufreq arm_dsu_pmu acpi_tad loop fuse zram xfs crct10dif_ce poly=
val_ce polyval_generic ghash_ce sbsa_gwdt ast onboard_usb_hub i2c_algo_bit =
xgene_hwmon [last unloaded: scsi_debug]
>
> So my money is on some device that gets removed still having an
> increased refcount and pinning the dentry. Immediate suspects would be:
>
> 7882541ca06d ("of/platform: increase refcount of fwnode")
>
> but that part is complete speculation on my part.

BTW, just saw another panic on 6.5-rc7, still scsi_debug test on arm64:

[  959.371726] sr 50:0:0:0: Attached scsi generic sg1 type 5
[  959.603145] scsi 48:0:0:0: CD-ROM            Linux    scsi_debug
   0191 PQ: 0 ANSI: 7
[  959.603155] scsi 50:0:0:0: CD-ROM            Linux    scsi_debug
   0191 PQ: 0 ANSI: 7
[  959.603950] scsi 49:0:0:0: CD-ROM            Linux    scsi_debug
   0191 PQ: 0 ANSI: 7
[  959.604052] scsi 49:0:0:0: Power-on or device reset occurred
[  959.609336] sr 49:0:0:0: [sr1] scsi-1 drive
[  959.611360] scsi 48:0:0:0: Power-on or device reset occurred
[  959.614540] Unable to handle kernel paging request at virtual
address 65888c2e6fe694d5
[  959.614544] Mem abort info:
[  959.614545]   ESR =3D 0x0000000096000004
[  959.614547]   EC =3D 0x25: DABT (current EL), IL =3D 32 bits
[  959.614550]   SET =3D 0, FnV =3D 0
[  959.614552]   EA =3D 0, S1PTW =3D 0
[  959.614553]   FSC =3D 0x04: level 0 translation fault
[  959.614555] Data abort info:
[  959.614556]   ISV =3D 0, ISS =3D 0x00000004, ISS2 =3D 0x00000000
[  959.614559]   CM =3D 0, WnR =3D 0, TnD =3D 0, TagAccess =3D 0
[  959.614561]   GCS =3D 0, Overlay =3D 0, DirtyBit =3D 0, Xs =3D 0
[  959.614563] [65888c2e6fe694d5] address between user and kernel address r=
anges
[  959.614566] Internal error: Oops: 0000000096000004 [#1] SMP
[  959.614570] Modules linked in: pktcdvd scsi_debug ipmi_watchdog
ipmi_poweroff rfkill sunrpc vfat fat acpi_ipmi ipmi_ssif arm_spe_pmu
igb ipmi_devintf arm_cmn ipmi_msghandler arm_dmc620_pmu arm_dsu_pmu
cppc_cpufreq acpi_tad loop fuse zram xfs nvme crct10dif_ce polyval_ce
nvme_core polyval_generic ghash_ce sbsa_gwdt nvme_common ast
onboard_usb_hub i2c_algo_bit xgene_hwmon [last unloaded: scsi_debug]
[  959.614620] CPU: 108 PID: 19529 Comm: check Not tainted 6.5.0-rc7 #1
[  959.614625] Hardware name: GIGABYTE R152-P31-00/MP32-AR1-00, BIOS
F31n (SCP: 2.10.20220810) 09/30/2022
[  959.614627] pstate: 80400009 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=
=3D--)
[  959.614632] pc : d_alloc_parallel+0x140/0x440
[  959.614641] lr : d_alloc_parallel+0xcc/0x440
[  959.614646] sp : ffff80008a7d3290
[  959.614647] x29: ffff80008a7d3290 x28: ffff07ff8230c530 x27: 65888c2e6fe=
69565
[  959.614654] x26: ffffcb72eac9e1d0 x25: ffff80008a7d33d8 x24: ffff07ffa0f=
d3800
[  959.614659] x23: 00000000000003c0 x22: 000000007a701548 x21: ffffcb72eac=
9ffd0
[  959.614664] x20: ffff07ffa0fd35c0 x19: ffffcb72ea6e9600 x18: fffffffffff=
fffff
[  959.614670] x17: 00000000440fd8e0 x16: 00000000b6431329 x15: ffff80008a7=
d3360
[  959.614675] x14: ffff80008a7d3508 x13: ffffcb72e94da6d0 x12: ffff80008a7=
d334c
[  959.614680] x11: 0000000c7a701548 x10: ffff3c8cb54590b8 x9 : ffffcb72e80=
832f4
[  959.614685] x8 : ffff07ffa0fd35c0 x7 : 7473696c5f71725f x6 : 00000000002=
00008
[  959.614690] x5 : ffffcb72ea6f4000 x4 : 00000000003d380a x3 : 00000000000=
00004
[  959.614696] x2 : ffff80008a7d331c x1 : ffff07ffe1760000 x0 : 00000000000=
05000
[  959.614701] Call trace:
[  959.614703]  d_alloc_parallel+0x140/0x440
[  959.614708]  __lookup_slow+0x64/0x158
[  959.614714]  lookup_one_len+0xac/0xc8
[  959.614719]  start_creating.part.0+0x88/0x198
[  959.614725]  __debugfs_create_file+0x70/0x230
[  959.614730]  debugfs_create_file+0x34/0x48
[  959.614734]  blk_mq_debugfs_register_hctx+0x154/0x1d0
[  959.614740]  blk_mq_debugfs_register+0xfc/0x1e0
[  959.614745]  blk_register_queue+0xc0/0x1f0
[  959.614750]  device_add_disk+0x1dc/0x3e0
[  959.614754]  sr_probe+0x2c0/0x368
[  959.614760]  really_probe+0x190/0x3d8
[  959.614766]  __driver_probe_device+0x84/0x180
[  959.614771]  driver_probe_device+0x44/0x120
[  959.614776]  __device_attach_driver+0xc4/0x168
[  959.614781]  bus_for_each_drv+0x8c/0xf0
[  959.614785]  __device_attach+0xa4/0x1c0
[  959.614790]  device_initial_probe+0x1c/0x30
[  959.614795]  bus_probe_device+0xb4/0xc0
[  959.614799]  device_add+0x508/0x6f8
[  959.614803]  scsi_sysfs_add_sdev+0x8c/0x250
[  959.614809]  scsi_add_lun+0x424/0x558
[  959.614813]  scsi_probe_and_add_lun+0x11c/0x430
[  959.614817]  __scsi_scan_target+0xb8/0x258
[  959.614821]  scsi_scan_channel+0xa0/0xb8
[  959.614825]  scsi_scan_host_selected+0x170/0x188
[  959.614830]  store_scan+0x194/0x1a8
[  959.614835]  dev_attr_store+0x20/0x40
[  959.614840]  sysfs_kf_write+0x4c/0x68
[  959.614845]  kernfs_fop_write_iter+0x13c/0x1d8
[  959.614849]  vfs_write+0x1c0/0x310
[  959.614855]  ksys_write+0x78/0x118
[  959.614859]  __arm64_sys_write+0x24/0x38
[  959.614864]  invoke_syscall+0x78/0x100
[  959.614868]  el0_svc_common.constprop.0+0x4c/0xf8
[  959.614871]  do_el0_svc+0x34/0x50
[  959.614874]  el0_svc+0x34/0x108
[  959.614879]  el0t_64_sync_handler+0x120/0x130
[  959.614884]  el0t_64_sync+0x194/0x198
[  959.614889] Code: 54000088 14000067 f940037b b4000cbb (b8570360)
[  959.614892] ---[ end trace 0000000000000000 ]---
[  959.614895] Kernel panic - not syncing: Oops: Fatal exception
[  959.614897] SMP: stopping secondary CPUs
[  959.619492] Kernel Offset: 0x4b7267c40000 from 0xffff800080000000
[  959.619494] PHYS_OFFSET: 0x80000000
[  959.619496] CPU features: 0x00000010,b80140a1,8841720b
[  959.619498] Memory Limit: none
[  960.040819] ---[ end Kernel panic - not syncing: Oops: Fatal exception ]=
---

