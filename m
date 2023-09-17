Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BB3A7A337F
	for <lists+linux-fsdevel@lfdr.de>; Sun, 17 Sep 2023 02:36:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230166AbjIQAff (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 16 Sep 2023 20:35:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbjIQAfN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 16 Sep 2023 20:35:13 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C5271B0;
        Sat, 16 Sep 2023 17:35:07 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1c1ff5b741cso31742775ad.2;
        Sat, 16 Sep 2023 17:35:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1694910907; x=1695515707; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UvnoTq8kgRLmMYnH92XBBzRZojHSijMAth7s/bu24Ek=;
        b=B1qYn8VbhCELWT7tXEoQ8cFmhCg0fv0KMbScpWS/3Y3O+oxiAtWBUGvcU3lIci7TyL
         QuGmrp4xSuy3rDEaH8H3cHKcljM8ab65GIygmxQURX3QJ8jSPZC38IJJ/GsKxCjAHvlv
         kfdI648uzm7FBzbCSNnsLvq5T5xg+FMbCq27sdgwqFvzXLh3yWF1CMNeWVoWd0kJlxWJ
         DQ3PHPFAp+cz7/d8frhW7t5xW60lyb90FOHsRm6UFiUIu0L/LsWvfyJ4DW2wfz4Z4P79
         vCrL4KdW6NCvtzegZMcNaBTETqhYzTG+79Y2PL9Xb4iiEE1mePwcdzRSxCBKFclBJVlm
         oXlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694910907; x=1695515707;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UvnoTq8kgRLmMYnH92XBBzRZojHSijMAth7s/bu24Ek=;
        b=LGExePr+5HFyu+GRsYHQ1pBbdLATORYUCjzeU/2pncG/FFYIohHhjjoM/yRTPTsbic
         C2siBv+vSVrikM14tjG2tCPGnw39UJizFpajsnhtovHrZODs8AJBBjNFgDNgbQyM3yP1
         +qY0UxGDaRECaXJ1ysfz5oaK6tt0DQQhu2vWas2ENp3SNMk1vAL8d3oq5k5zNVQ52PUp
         kikx8e/dMDV7pACiUmlUZ0Bxf6Ne3uSl8kUlm1zkCqScetiqxK5X+vcEdCWKuOaPg/B3
         hCn3u/QZX4oxQG6aDUA6JyBw/VuDv+ZLdwXFs3E2k3PAGE1oItkP0gVnGPQNaEC4zlNj
         Ihlw==
X-Gm-Message-State: AOJu0YyIqsDNoWWkzyu1yGJIKR5vSPD1OSt0T3/TqY+YL9zY0Pn/Wq9w
        Z8Khdmu9PThMgscXdUAMmT0=
X-Google-Smtp-Source: AGHT+IFroDpN4Ujpq3VcM5VtaIKGIiCy/YHwzx5lROriXPLYoQ1gZCRSNunUo2t3Ozd6qgfdWDrKhQ==
X-Received: by 2002:a17:902:6b05:b0:1c2:218c:3754 with SMTP id o5-20020a1709026b0500b001c2218c3754mr5441599plk.53.1694910906841;
        Sat, 16 Sep 2023 17:35:06 -0700 (PDT)
Received: from debian.me ([103.124.138.83])
        by smtp.gmail.com with ESMTPSA id q20-20020a170902e31400b001b8baa83639sm5790896plc.200.2023.09.16.17.35.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Sep 2023 17:35:06 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id 32000819BFC0; Sun, 17 Sep 2023 07:35:00 +0700 (WIB)
Date:   Sun, 17 Sep 2023 07:35:00 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Yi Zhang <yi.zhang@redhat.com>, Ming Lei <ming.lei@redhat.com>
Cc:     Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        Changhui Zhong <czhong@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra (Intel) <peterz@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        Linux Regressions <regressions@lists.linux.dev>
Subject: Re: [czhong@redhat.com: [bug report] WARNING: CPU: 121 PID: 93233 at
 fs/dcache.c:365 __dentry_kill+0x214/0x278]
Message-ID: <ZQZJtHHPZwCeQH9v@debian.me>
References: <ZOWFtqA2om0w5Vmz@fedora>
 <20230823-kuppe-lassen-bc81a20dd831@brauner>
 <CAFj5m9KiBDzNHCsTjwUevZh3E3RRda2ypj9+QcRrqEsJnf9rXQ@mail.gmail.com>
 <CAHj4cs_MqqWYy+pKrNrLqTb=eoSOXcZdjPXy44x-aA1WvdVv0w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="q4BzXabHRQeqqnGy"
Content-Disposition: inline
In-Reply-To: <CAHj4cs_MqqWYy+pKrNrLqTb=eoSOXcZdjPXy44x-aA1WvdVv0w@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--q4BzXabHRQeqqnGy
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 13, 2023 at 04:59:31PM +0800, Yi Zhang wrote:
> The issue still can be reproduced on the latest linux tree[2].
> To reproduce I need to run about 1000 times blktests block/001, and
> bisect shows it was introduced with commit[1], as it was not 100%
> reproduced, not sure if it's the culprit?
>=20
>=20
> [1] 9257959a6e5b locking/atomic: scripts: restructure fallback ifdeffery
> [2]
> [ 2304.536339] scsi 48:0:0:0: CD-ROM            Linux    scsi_debug
>    0191 PQ: 0 ANSI: 7
> [ 2304.540805] sr 50:0:0:0: Attached scsi CD-ROM sr3
> [ 2304.544574] scsi 48:0:0:0: Power-on or device reset occurred
> [ 2304.600645] sr 48:0:0:0: [sr1] scsi-1 drive
> [ 2304.616364] scsi 51:0:0:0: CD-ROM            Linux    scsi_debug
>    0191 PQ: 0 ANSI: 7
> [ 2304.624639] scsi 51:0:0:0: Power-on or device reset occurred
> [ 2304.626634] sr 48:0:0:0: Attached scsi CD-ROM sr1
> [ 2304.680537] sr 51:0:0:0: [sr2] scsi-1 drive
> [ 2304.706394] sr 51:0:0:0: Attached scsi CD-ROM sr2
> [ 2304.746329] scsi 49:0:0:0: CD-ROM            Linux    scsi_debug
>    0191 PQ: 0 ANSI: 7
> [ 2304.754569] scsi 49:0:0:0: Power-on or device reset occurred
> [ 2304.756302] scsi 50:0:0:0: CD-ROM            Linux    scsi_debug
>    0191 PQ: 0 ANSI: 7
> [ 2304.768483] scsi 50:0:0:0: Power-on or device reset occurred
> [ 2304.806321] scsi 48:0:0:0: CD-ROM            Linux    scsi_debug
>    0191 PQ: 0 ANSI: 7
> [ 2304.810587] sr 49:0:0:0: [sr0] scsi-1 drive
> [ 2304.814561] scsi 48:0:0:0: Power-on or device reset occurred
> [ 2304.824475] sr 50:0:0:0: [sr3] scsi-1 drive
> [ 2304.836384] scsi 51:0:0:0: CD-ROM            Linux    scsi_debug
>    0191 PQ: 0 ANSI: 7
> [ 2304.840364] sr 49:0:0:0: Attached scsi CD-ROM sr0
> [ 2304.844619] scsi 51:0:0:0: Power-on or device reset occurred
> [ 2304.850444] sr 50:0:0:0: Attached scsi CD-ROM sr3
> [ 2304.874563] sr 48:0:0:0: [sr1] scsi-1 drive
> [ 2304.900660] sr 51:0:0:0: [sr2] scsi-1 drive
> [ 2304.901506] sr 48:0:0:0: Attached scsi CD-ROM sr1
> [ 2304.926306] sr 51:0:0:0: Attached scsi CD-ROM sr2
> [ 2305.056432] scsi 50:0:0:0: CD-ROM            Linux    scsi_debug
>    0191 PQ: 0 ANSI: 7
> [ 2305.056572] scsi 49:0:0:0: CD-ROM            Linux    scsi_debug
>    0191 PQ: 0 ANSI: 7
> [ 2305.064635] scsi 50:0:0:0: Power-on or device reset occurred
> [ 2305.072821] scsi 49:0:0:0: Power-on or device reset occurred
> [ 2305.086286] scsi 51:0:0:0: CD-ROM            Linux    scsi_debug
>    0191 PQ: 0 ANSI: 7
> [ 2305.086357] scsi 48:0:0:0: CD-ROM            Linux    scsi_debug
>    0191 PQ: 0 ANSI: 7
> [ 2305.094521] scsi 51:0:0:0: Power-on or device reset occurred
> [ 2305.102693] scsi 48:0:0:0: Power-on or device reset occurred
> [ 2305.128785] sr 50:0:0:0: [sr0] scsi-1 drive
> [ 2305.134445] sr 49:0:0:0: [sr1] scsi-1 drive
> [ 2305.154728] sr 50:0:0:0: Attached scsi CD-ROM sr0
> [ 2305.158607] sr 51:0:0:0: [sr2] scsi-1 drive
> [ 2305.160392] sr 49:0:0:0: Attached scsi CD-ROM sr1
> [ 2305.164254] sr 48:0:0:0: [sr3] scsi-1 drive
> [ 2305.184185] sr 51:0:0:0: Attached scsi CD-ROM sr2
> [ 2305.190086] sr 48:0:0:0: Attached scsi CD-ROM sr3
> [ 2305.555658] Unable to handle kernel execute from non-executable
> memory at virtual address ffffc61b656052e8
> [ 2305.565301] Mem abort info:
> [ 2305.568086]   ESR =3D 0x000000008600000e
> [ 2305.571822]   EC =3D 0x21: IABT (current EL), IL =3D 32 bits
> [ 2305.577123]   SET =3D 0, FnV =3D 0
> [ 2305.580164]   EA =3D 0, S1PTW =3D 0
> [ 2305.583292]   FSC =3D 0x0e: level 2 permission fault
> [ 2305.588074] swapper pgtable: 4k pages, 48-bit VAs, pgdp=3D0000080731fa=
0000
> [ 2305.594761] [ffffc61b656052e8] pgd=3D1000080ffffff003,
> p4d=3D1000080ffffff003, pud=3D1000080fffffe003, pmd=3D0068080732e00f01
> [ 2305.605362] Internal error: Oops: 000000008600000e [#1] SMP
> [ 2305.610922] Modules linked in: scsi_debug sr_mod pktcdvd cdrom
> rfkill sunrpc vfat fat acpi_ipmi arm_spe_pmu ipmi_ssif ipmi_devintf
> ipmi_msghandler arm_cmn arm_dmc620_pmu arm_dsu_pmu cppc_cpufreq loop
> fuse zram xfs crct10dif_ce ghash_ce nvme sha2_ce nvme_core
> sha256_arm64 igb sha1_ce ast sbsa_gwdt nvme_common
> i2c_designware_platform i2c_algo_bit i2c_designware_core xgene_hwmon
> dm_mod [last unloaded: scsi_debug]
> [ 2305.647236] CPU: 85 PID: 1 Comm: systemd Kdump: loaded Not tainted
> 6.6.0-rc1+ #13
> [ 2305.654706] Hardware name: GIGABYTE R152-P31-00/MP32-AR1-00, BIOS
> F31n (SCP: 2.10.20220810) 09/30/2022
> [ 2305.663997] pstate: 20400009 (nzCv daif +PAN -UAO -TCO -DIT -SSBS BTYP=
E=3D--)
> [ 2305.670946] pc : in_lookup_hashtable+0x1138/0x2000
> [ 2305.675728] lr : rcu_do_batch+0x194/0x488
> [ 2305.679727] sp : ffff8000802abe60
> [ 2305.683029] x29: ffff8000802abe60 x28: ffffc61b6524c7c0 x27: ffffc61b6=
3452f40
> [ 2305.690152] x26: ffff080f37ab6438 x25: 000000000000000a x24: 000000000=
0000000
> [ 2305.697274] x23: 0000000000000002 x22: ffff8000802abec0 x21: ffff080f3=
7ab63c0
> [ 2305.704396] x20: ffff07ff8136a580 x19: 0000000000000003 x18: 000000000=
0000000
> [ 2305.711519] x17: ffff41f3d3161000 x16: ffff8000802a8000 x15: 000000000=
0000000
> [ 2305.718641] x14: 0000000000000000 x13: ffff07ffa131802d x12: ffff80008=
041bb94
> [ 2305.725764] x11: 0000000000000040 x10: ffff07ff802622e8 x9 : ffffc61b6=
3452e30
> [ 2305.732887] x8 : 000002189dce1780 x7 : ffff07ff8d5c1000 x6 : ffff41f3d=
3161000
> [ 2305.740009] x5 : ffff07ff8136a580 x4 : ffff080f37aba960 x3 : 000000001=
550a055
> [ 2305.747131] x2 : 0000000000000000 x1 : ffffc61b656052e8 x0 : ffff08018=
4c565f0
> [ 2305.754254] Call trace:
> [ 2305.756687]  in_lookup_hashtable+0x1138/0x2000
> [ 2305.761119]  rcu_core+0x268/0x350
> [ 2305.764422]  rcu_core_si+0x18/0x30
> [ 2305.767812]  __do_softirq+0x120/0x3d4
> [ 2305.771462]  ____do_softirq+0x18/0x30
> [ 2305.775112]  call_on_irq_stack+0x24/0x30
> [ 2305.779022]  do_softirq_own_stack+0x24/0x38
> [ 2305.783192]  __irq_exit_rcu+0xfc/0x130
> [ 2305.786929]  irq_exit_rcu+0x18/0x30
> [ 2305.790404]  el1_interrupt+0x4c/0xe8
> [ 2305.793969]  el1h_64_irq_handler+0x18/0x28
> [ 2305.798052]  el1h_64_irq+0x78/0x80
> [ 2305.801441]  d_same_name+0x50/0xd0
> [ 2305.804832]  __lookup_slow+0x64/0x158
> [ 2305.808482]  walk_component+0xe0/0x1a0
> [ 2305.812219]  path_lookupat+0x7c/0x1b8
> [ 2305.815869]  filename_lookup+0xb4/0x1b8
> [ 2305.819692]  vfs_statx+0x94/0x1a8
> [ 2305.822995]  vfs_fstatat+0xd4/0x110
> [ 2305.826471]  __do_sys_newfstatat+0x58/0xa8
> [ 2305.830556]  __arm64_sys_newfstatat+0x28/0x40
> [ 2305.834901]  invoke_syscall.constprop.0+0x80/0xd8
> [ 2305.839592]  do_el0_svc+0x48/0xd0
> [ 2305.842894]  el0_svc+0x4c/0x1c0
> [ 2305.846023]  el0t_64_sync_handler+0x120/0x130
> [ 2305.850367]  el0t_64_sync+0x1a4/0x1a8
> [ 2305.854017] Code: 00000000 00000000 00000000 00000000 (84c565f1)
> [ 2305.860098] SMP: stopping secondary CPUs
> [ 2305.865048] Starting crashdump kernel...
> [ 2305.868958] Bye!
>=20
>=20

Please don't top-post; reply inline with appropriate context instead.

Anyway, thanks for bisecting this regression. I'm adding it to regzbot:

#regzbot ^introduced: 9257959a6e5b4f
#regzbot title: restructuring atomic locking conditionals causes vfs dentry=
 lock protection failure

--=20
An old man doll... just what I always wanted! - Clara

--q4BzXabHRQeqqnGy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZQZJrQAKCRD2uYlJVVFO
o/cMAP4tqfKbPeBA1hX9fv2VX6jLpP1MGeMpbnLIDlk3WBEDXAEA5ST9sg+34d+r
Bece/dxoiVhrFu/YWO++BE54Bh2r1QE=
=fBuF
-----END PGP SIGNATURE-----

--q4BzXabHRQeqqnGy--
