Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0CAB48CC31
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Jan 2022 20:44:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241914AbiALToD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Jan 2022 14:44:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344388AbiALTmL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Jan 2022 14:42:11 -0500
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FAECC034002;
        Wed, 12 Jan 2022 11:42:04 -0800 (PST)
Received: by fieldses.org (Postfix, from userid 2815)
        id 1820D6CEE; Wed, 12 Jan 2022 14:42:04 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 1820D6CEE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1642016524;
        bh=Dk5AOhKGYf2KVPVSM6SHCdqD/FTGcoFUG0TfIvKYx7A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=v7R3uQucWbCj2B9j7q8wp3g9fVEdJU2zY5RFsx3IFQpA3Rkvcj6iwCqSvFnXFmiLY
         M6gccncnDEhHn+OvU19yUHVOhz4Vckj7wUMSbStB+miigXrevUA9qqG13O9EOkqFJk
         BLzE48BWJCAcAppfp69RoGegISCHlzS0hvCJGPns=
Date:   Wed, 12 Jan 2022 14:42:04 -0500
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     dai.ngo@oracle.com
Cc:     chuck.lever@oracle.com, jlayton@redhat.com,
        viro@zeniv.linux.org.uk, linux-nfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH RFC v9 0/2] nfsd: Initial implementation of NFSv4
 Courteous Server
Message-ID: <20220112194204.GE10518@fieldses.org>
References: <1641840653-23059-1-git-send-email-dai.ngo@oracle.com>
 <20220112185912.GB10518@fieldses.org>
 <ad62d8d1-f566-ab6f-8c74-38ba2d053d89@oracle.com>
 <20220112192111.GC10518@fieldses.org>
 <eb3dc795-092c-8624-8e11-bfe8758b812c@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <eb3dc795-092c-8624-8e11-bfe8758b812c@oracle.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jan 12, 2022 at 11:31:55AM -0800, dai.ngo@oracle.com wrote:
>=20
> On 1/12/22 11:21 AM, J. Bruce Fields wrote:
> >On Wed, Jan 12, 2022 at 11:05:03AM -0800, dai.ngo@oracle.com wrote:
> >>On 1/12/22 10:59 AM, J. Bruce Fields wrote:
> >>>Could you look back over previous comments?  I notice there's a couple
> >>>unaddressed (circular locking dependency, Documentation/filesystems/).
> >>I think v9 addresses the circular locking dependency.
> >The below is on 5.16 + these two v9 patches.
> >
> >--b.
> >
> >[  335.595143] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >[  335.596176] WARNING: possible circular locking dependency detected
> >[  335.597128] 5.16.0-00002-g616758bf6583 #1278 Not tainted
> >[  335.597903] ------------------------------------------------------
> >[  335.598845] kworker/u8:0/7 is trying to acquire lock:
> >[  335.599582] ffff888010393b60 (&clp->cl_lock){+.+.}-{2:2}, at: laundro=
mat_main+0x177d/0x23b0 [nfsd]
> >[  335.601111]
> >                but task is already holding lock:
> >[  335.601750] ffff888010393e18 (&clp->cl_cs_lock){+.+.}-{2:2}, at: laun=
dromat_main+0x33e/0x23b0 [nfsd]
>=20
> This is the new spinlock that I added. It's weird that I don't see it
> my messages log, I will check.

Not especially weird, we probably have different config options and run
different tests.

You'll need to just inspect the code and figure ou why these locks are
being taken in different orders.

--b.

>=20
> Thanks,
> -Dai
>=20
> >[  335.602896]
> >                which lock already depends on the new lock.
> >
> >[  335.603378]
> >                the existing dependency chain (in reverse order) is:
> >[  335.603897]
> >                -> #2 (&clp->cl_cs_lock){+.+.}-{2:2}:
> >[  335.604305]        _raw_spin_lock+0x2f/0x40
> >[  335.604622]        nfsd4_fl_expire_lock+0x7a/0x330 [nfsd]
> >[  335.605078]        posix_lock_inode+0x9b8/0x1a50
> >[  335.605442]        nfsd4_lock+0xe33/0x3d20 [nfsd]
> >[  335.605827]        nfsd4_proc_compound+0xcef/0x21e0 [nfsd]
> >[  335.606289]        nfsd_dispatch+0x4b8/0xbd0 [nfsd]
> >[  335.606692]        svc_process_common+0xd56/0x1ac0 [sunrpc]
> >[  335.607188]        svc_process+0x32e/0x4a0 [sunrpc]
> >[  335.607604]        nfsd+0x306/0x530 [nfsd]
> >[  335.607923]        kthread+0x3b1/0x490
> >[  335.608199]        ret_from_fork+0x22/0x30
> >[  335.608512]
> >                -> #1 (&ctx->flc_lock){+.+.}-{2:2}:
> >[  335.608878]        _raw_spin_lock+0x2f/0x40
> >[  335.609187]        check_for_locks+0xcf/0x200 [nfsd]
> >[  335.609602]        nfsd4_release_lockowner+0x583/0xa20 [nfsd]
> >[  335.610093]        nfsd4_proc_compound+0xcef/0x21e0 [nfsd]
> >[  335.610564]        nfsd_dispatch+0x4b8/0xbd0 [nfsd]
> >[  335.610963]        svc_process_common+0xd56/0x1ac0 [sunrpc]
> >[  335.611450]        svc_process+0x32e/0x4a0 [sunrpc]
> >[  335.611863]        nfsd+0x306/0x530 [nfsd]
> >[  335.612193]        kthread+0x3b1/0x490
> >[  335.612463]        ret_from_fork+0x22/0x30
> >[  335.612764]
> >                -> #0 (&clp->cl_lock){+.+.}-{2:2}:
> >[  335.613120]        __lock_acquire+0x29f8/0x5b80
> >[  335.613469]        lock_acquire+0x1a6/0x4b0
> >[  335.613763]        _raw_spin_lock+0x2f/0x40
> >[  335.614057]        laundromat_main+0x177d/0x23b0 [nfsd]
> >[  335.614477]        process_one_work+0x7ec/0x1320
> >[  335.614813]        worker_thread+0x59e/0xf90
> >[  335.615135]        kthread+0x3b1/0x490
> >[  335.615409]        ret_from_fork+0x22/0x30
> >[  335.615695]
> >                other info that might help us debug this:
> >
> >[  335.616135] Chain exists of:
> >                  &clp->cl_lock --> &ctx->flc_lock --> &clp->cl_cs_lock
> >
> >[  335.616806]  Possible unsafe locking scenario:
> >
> >[  335.617140]        CPU0                    CPU1
> >[  335.617467]        ----                    ----
> >[  335.617793]   lock(&clp->cl_cs_lock);
> >[  335.618036]                                lock(&ctx->flc_lock);
> >[  335.618531]                                lock(&clp->cl_cs_lock);
> >[  335.619037]   lock(&clp->cl_lock);
> >[  335.619256]
> >                 *** DEADLOCK ***
> >
> >[  335.619487] 4 locks held by kworker/u8:0/7:
> >[  335.619780]  #0: ffff88800ca5b138 ((wq_completion)nfsd4){+.+.}-{0:0},=
 at: process_one_work+0x6f5/0x1320
> >[  335.620619]  #1: ffff88800776fdd8 ((work_completion)(&(&nn->laundroma=
t_work)->work)){+.+.}-{0:0}, at: process_one_work+0x723/0x1320
> >[  335.621657]  #2: ffff888008a4c190 (&nn->client_lock){+.+.}-{2:2}, at:=
 laundromat_main+0x2b4/0x23b0 [nfsd]
> >[  335.622499]  #3: ffff888010393e18 (&clp->cl_cs_lock){+.+.}-{2:2}, at:=
 laundromat_main+0x33e/0x23b0 [nfsd]
> >[  335.623462]
> >                stack backtrace:
> >[  335.623648] CPU: 2 PID: 7 Comm: kworker/u8:0 Not tainted 5.16.0-00002=
-g616758bf6583 #1278
> >[  335.624364] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BI=
OS 1.14.0-6.fc35 04/01/2014
> >[  335.625124] Workqueue: nfsd4 laundromat_main [nfsd]
> >[  335.625514] Call Trace:
> >[  335.625641]  <TASK>
> >[  335.625734]  dump_stack_lvl+0x45/0x59
> >[  335.625981]  check_noncircular+0x23e/0x2e0
> >[  335.626268]  ? print_circular_bug+0x450/0x450
> >[  335.626583]  ? mark_lock+0xf1/0x30c0
> >[  335.626821]  ? alloc_chain_hlocks+0x1e6/0x590
> >[  335.627156]  __lock_acquire+0x29f8/0x5b80
> >[  335.627463]  ? lock_chain_count+0x20/0x20
> >[  335.627740]  ? lockdep_hardirqs_on_prepare+0x400/0x400
> >[  335.628161]  ? lockdep_hardirqs_on_prepare+0x400/0x400
> >[  335.628555]  lock_acquire+0x1a6/0x4b0
> >[  335.628799]  ? laundromat_main+0x177d/0x23b0 [nfsd]
> >[  335.629184]  ? lock_release+0x6d0/0x6d0
> >[  335.629449]  ? laundromat_main+0x29c/0x23b0 [nfsd]
> >[  335.629825]  ? do_raw_spin_lock+0x11e/0x240
> >[  335.630120]  ? rwlock_bug.part.0+0x90/0x90
> >[  335.630409]  _raw_spin_lock+0x2f/0x40
> >[  335.630654]  ? laundromat_main+0x177d/0x23b0 [nfsd]
> >[  335.631058]  laundromat_main+0x177d/0x23b0 [nfsd]
> >[  335.631450]  ? lock_release+0x6d0/0x6d0
> >[  335.631712]  ? client_ctl_write+0x9f0/0x9f0 [nfsd]
> >[  335.632110]  process_one_work+0x7ec/0x1320
> >[  335.632411]  ? lock_release+0x6d0/0x6d0
> >[  335.632672]  ? pwq_dec_nr_in_flight+0x230/0x230
> >[  335.633002]  ? rwlock_bug.part.0+0x90/0x90
> >[  335.633290]  worker_thread+0x59e/0xf90
> >[  335.633548]  ? process_one_work+0x1320/0x1320
> >[  335.633860]  kthread+0x3b1/0x490
> >[  335.634082]  ? _raw_spin_unlock_irq+0x24/0x50
> >[  335.634396]  ? set_kthread_struct+0x100/0x100
> >[  335.634709]  ret_from_fork+0x22/0x30
> >[  335.634961]  </TASK>
> >[  751.568771] nfsd (4021) used greatest stack depth: 21792 bytes left
> >[  751.769042] nfsd: last server has exited, flushing export cache
> >[  751.957555] NFSD: Using nfsdcld client tracking operations.
> >[  751.958050] NFSD: starting 15-second grace period (net f0000098)
> >[  773.101065] nfsd: last server has exited, flushing export cache
> >[  773.341554] NFSD: Using nfsdcld client tracking operations.
> >[  773.342404] NFSD: starting 15-second grace period (net f0000098)
> >[  795.757041] nfsd: last server has exited, flushing export cache
> >[  795.881057] NFSD: Using nfsdcld client tracking operations.
> >[  795.881637] NFSD: starting 15-second grace period (net f0000098)
> >[  816.968871] nfsd: last server has exited, flushing export cache
> >[  817.199987] NFSD: Using nfsdcld client tracking operations.
> >[  817.201123] NFSD: starting 15-second grace period (net f0000098)
> >[  817.696746] nfsd: last server has exited, flushing export cache
> >[  817.925616] NFSD: Using nfsdcld client tracking operations.
> >[  817.926073] NFSD: starting 15-second grace period (net f0000098)
> >[  839.080820] nfsd: last server has exited, flushing export cache
> >[  839.321569] NFSD: Using nfsdcld client tracking operations.
> >[  839.322562] NFSD: starting 15-second grace period (net f0000098)
> >[  860.492782] nfsd: last server has exited, flushing export cache
> >[  860.749705] NFSD: Using nfsdcld client tracking operations.
> >[  860.751710] NFSD: starting 15-second grace period (net f0000098)
> >[  882.889711] nfsd: last server has exited, flushing export cache
> >[  883.125502] NFSD: Using nfsdcld client tracking operations.
> >[  883.126399] NFSD: starting 15-second grace period (net f0000098)
> >[  904.224662] nfsd: last server has exited, flushing export cache
> >[  904.342387] NFSD: Using nfsdcld client tracking operations.
> >[  904.342962] NFSD: starting 15-second grace period (net f0000098)
> >[  947.528620] nfsd: last server has exited, flushing export cache
> >[  947.763520] NFSD: Using nfsdcld client tracking operations.
> >[  947.764569] NFSD: starting 15-second grace period (net f0000098)
> >[ 1442.187410] nfsd: last server has exited, flushing export cache
> >[ 1442.430496] NFSD: Using nfsdcld client tracking operations.
> >[ 1442.430974] NFSD: starting 15-second grace period (net f0000098)
> >[ 1483.739309] nfsd: last server has exited, flushing export cache
> >[ 1483.864102] NFSD: Using nfsdcld client tracking operations.
> >[ 1483.864606] NFSD: starting 15-second grace period (net f0000098)
> >[ 1486.644498] NFSD: all clients done reclaiming, ending NFSv4 grace per=
iod (net f0000098)
> >[ 1490.023618] clocksource: timekeeping watchdog on CPU3: acpi_pm retrie=
d 2 times before success
> >[ 1508.807419] nfsd: last server has exited, flushing export cache
> >[ 1508.925396] NFSD: Using nfsdcld client tracking operations.
> >[ 1508.925905] NFSD: starting 15-second grace period (net f0000098)
> >[ 1509.412224] NFSD: all clients done reclaiming, ending NFSv4 grace per=
iod (net f0000098)
> >[ 1530.667340] nfsd: last server has exited, flushing export cache
> >[ 1530.803387] NFSD: Using nfsdcld client tracking operations.
> >[ 1530.804150] NFSD: starting 15-second grace period (net f0000098)
> >[ 1531.185069] NFSD: all clients done reclaiming, ending NFSv4 grace per=
iod (net f0000098)
> >[ 1552.563368] nfsd: last server has exited, flushing export cache
> >[ 1552.794957] NFSD: Using nfsdcld client tracking operations.
> >[ 1552.797092] NFSD: starting 15-second grace period (net f0000098)
> >[ 1573.931430] NFSD: all clients done reclaiming, ending NFSv4 grace per=
iod (net f0000098)
> >[ 1594.943247] nfsd: last server has exited, flushing export cache
> >[ 1595.175609] NFSD: Using nfsdcld client tracking operations.
> >[ 1595.177610] NFSD: starting 15-second grace period (net f0000098)
> >[ 1595.277962] NFSD: all clients done reclaiming, ending NFSv4 grace per=
iod (net f0000098)
> >[ 1618.323178] nfsd: last server has exited, flushing export cache
> >[ 1618.553210] NFSD: Using nfsdcld client tracking operations.
> >[ 1618.555049] NFSD: starting 15-second grace period (net f0000098)
> >[ 1620.455011] nfsd: last server has exited, flushing export cache
> >[ 1620.687824] NFSD: Using nfsdcld client tracking operations.
> >[ 1620.688329] NFSD: starting 15-second grace period (net f0000098)
> >[ 1660.003178] nfsd: last server has exited, flushing export cache
> >[ 1660.236374] NFSD: Using nfsdcld client tracking operations.
> >[ 1660.237760] NFSD: starting 15-second grace period (net f0000098)
> >[ 1660.842977] nfsd: last server has exited, flushing export cache
> >[ 1661.061619] NFSD: Using nfsdcld client tracking operations.
> >[ 1661.062070] NFSD: starting 15-second grace period (net f0000098)
> >[ 1661.440842] NFSD: all clients done reclaiming, ending NFSv4 grace per=
iod (net f0000098)
> >[ 2704.041055] clocksource: timekeeping watchdog on CPU3: acpi_pm retrie=
d 2 times before success
> >[ 2712.517015] clocksource: timekeeping watchdog on CPU0: acpi_pm retrie=
d 2 times before success
> >[ 6066.999200] clocksource: timekeeping watchdog on CPU1: acpi_pm retrie=
d 2 times before success
> >
> >started Wed Jan 12 11:28:28 AM EST 2022, finished Wed Jan 12 01:47:36 PM=
 EST 2022
> >
> >
> >+-----------------------------------------+
> >|            verbose output               |
> >+-----------------------------------------+
> >fs/select.c: In function =E2=80=98do_select=E2=80=99:
> >fs/select.c:611:1: warning: the frame size of 1120 bytes is larger than =
1024 bytes [-Wframe-larger-than=3D]
> >   611 | }
> >       | ^
> >fs/select.c: In function =E2=80=98do_sys_poll=E2=80=99:
> >fs/select.c:1041:1: warning: the frame size of 1296 bytes is larger than=
 1024 bytes [-Wframe-larger-than=3D]
> >  1041 | }
> >       | ^
> >net/core/rtnetlink.c: In function =E2=80=98__rtnl_newlink=E2=80=99:
> >net/core/rtnetlink.c:3494:1: warning: the frame size of 1368 bytes is la=
rger than 1024 bytes [-Wframe-larger-than=3D]
> >  3494 | }
> >       | ^
> >drivers/tty/serial/8250/8250_core.c: In function =E2=80=98serial8250_pro=
be=E2=80=99:
> >drivers/tty/serial/8250/8250_core.c:840:1: warning: the frame size of 11=
52 bytes is larger than 1024 bytes [-Wframe-larger-than=3D]
> >   840 | }
> >       | ^
> >drivers/tty/serial/8250/8250_pnp.c: In function =E2=80=98serial_pnp_prob=
e=E2=80=99:
> >drivers/tty/serial/8250/8250_pnp.c:488:1: warning: the frame size of 113=
6 bytes is larger than 1024 bytes [-Wframe-larger-than=3D]
> >   488 | }
> >       | ^
> >drivers/tty/serial/8250/8250_pci.c: In function =E2=80=98pciserial_init_=
ports=E2=80=99:
> >drivers/tty/serial/8250/8250_pci.c:4030:1: warning: the frame size of 11=
60 bytes is larger than 1024 bytes [-Wframe-larger-than=3D]
> >  4030 | }
> >       | ^
> >drivers/tty/serial/8250/8250_exar.c: In function =E2=80=98exar_pci_probe=
=E2=80=99:
> >drivers/tty/serial/8250/8250_exar.c:678:1: warning: the frame size of 11=
76 bytes is larger than 1024 bytes [-Wframe-larger-than=3D]
> >   678 | }
> >       | ^
> >drivers/tty/serial/8250/8250_lpss.c: In function =E2=80=98lpss8250_probe=
=2Epart.0=E2=80=99:
> >drivers/tty/serial/8250/8250_lpss.c:351:1: warning: the frame size of 11=
52 bytes is larger than 1024 bytes [-Wframe-larger-than=3D]
> >   351 | }
> >       | ^
> >drivers/tty/serial/8250/8250_mid.c: In function =E2=80=98mid8250_probe.p=
art.0=E2=80=99:
> >drivers/tty/serial/8250/8250_mid.c:337:1: warning: the frame size of 114=
4 bytes is larger than 1024 bytes [-Wframe-larger-than=3D]
> >   337 | }
> >       | ^
> >lib/zstd/common/entropy_common.c: In function =E2=80=98HUF_readStats=E2=
=80=99:
> >lib/zstd/common/entropy_common.c:257:1: warning: the frame size of 1056 =
bytes is larger than 1024 bytes [-Wframe-larger-than=3D]
> >   257 | }
> >       | ^
> >drivers/acpi/processor_thermal.c: In function =E2=80=98cpu_has_cpufreq=
=E2=80=99:
> >drivers/acpi/processor_thermal.c:60:1: warning: the frame size of 1384 b=
ytes is larger than 1024 bytes [-Wframe-larger-than=3D]
> >    60 | }
> >       | ^
> >drivers/dma-buf/dma-resv.c: In function =E2=80=98dma_resv_lockdep=E2=80=
=99:
> >drivers/dma-buf/dma-resv.c:708:1: warning: the frame size of 1192 bytes =
is larger than 1024 bytes [-Wframe-larger-than=3D]
> >   708 | }
> >       | ^
> >fs/lockd/svcsubs.c: In function =E2=80=98nlmsvc_mark_resources=E2=80=99:
> >fs/lockd/svcsubs.c:418:1: warning: the frame size of 1152 bytes is large=
r than 1024 bytes [-Wframe-larger-than=3D]
> >   418 | }
> >       | ^
> >drivers/md/raid5-ppl.c: In function =E2=80=98ppl_recover_entry=E2=80=99:
> >drivers/md/raid5-ppl.c:968:1: warning: the frame size of 1200 bytes is l=
arger than 1024 bytes [-Wframe-larger-than=3D]
> >   968 | }
> >       | ^
> >fs/ocfs2/namei.c: In function =E2=80=98ocfs2_rename=E2=80=99:
> >fs/ocfs2/namei.c:1686:1: warning: the frame size of 1064 bytes is larger=
 than 1024 bytes [-Wframe-larger-than=3D]
> >  1686 | }
> >       | ^
> >net/sunrpc/auth_gss/gss_krb5_crypto.c: In function =E2=80=98gss_krb5_aes=
_encrypt=E2=80=99:
> >net/sunrpc/auth_gss/gss_krb5_crypto.c:717:1: warning: the frame size of =
1120 bytes is larger than 1024 bytes [-Wframe-larger-than=3D]
> >   717 | }
> >       | ^
> >net/sunrpc/auth_gss/gss_krb5_crypto.c: In function =E2=80=98gss_krb5_aes=
_decrypt=E2=80=99:
> >net/sunrpc/auth_gss/gss_krb5_crypto.c:810:1: warning: the frame size of =
1168 bytes is larger than 1024 bytes [-Wframe-larger-than=3D]
> >   810 | }
> >       | ^
> >drivers/infiniband/core/nldev.c: In function =E2=80=98nldev_set_doit=E2=
=80=99:
> >drivers/infiniband/core/nldev.c:1112:1: warning: the frame size of 1064 =
bytes is larger than 1024 bytes [-Wframe-larger-than=3D]
> >  1112 | }
> >       | ^
> >drivers/infiniband/core/nldev.c: In function =E2=80=98nldev_newlink=E2=
=80=99:
> >drivers/infiniband/core/nldev.c:1722:1: warning: the frame size of 1128 =
bytes is larger than 1024 bytes [-Wframe-larger-than=3D]
> >  1722 | }
> >       | ^
> >drivers/infiniband/core/nldev.c: In function =E2=80=98nldev_get_chardev=
=E2=80=99:
> >drivers/infiniband/core/nldev.c:1833:1: warning: the frame size of 1144 =
bytes is larger than 1024 bytes [-Wframe-larger-than=3D]
> >  1833 | }
> >       | ^
> >drivers/infiniband/core/nldev.c: In function =E2=80=98nldev_stat_set_doi=
t=E2=80=99:
> >drivers/infiniband/core/nldev.c:2061:1: warning: the frame size of 1064 =
bytes is larger than 1024 bytes [-Wframe-larger-than=3D]
> >  2061 | }
> >       | ^
> >drivers/infiniband/core/nldev.c: In function =E2=80=98res_get_common_dum=
pit=E2=80=99:
> >drivers/infiniband/core/nldev.c:1613:1: warning: the frame size of 1096 =
bytes is larger than 1024 bytes [-Wframe-larger-than=3D]
> >  1613 | }
> >       | ^
> >drivers/infiniband/core/nldev.c: In function =E2=80=98nldev_stat_get_doi=
t=E2=80=99:
> >drivers/infiniband/core/nldev.c:2318:1: warning: the frame size of 1088 =
bytes is larger than 1024 bytes [-Wframe-larger-than=3D]
> >  2318 | }
> >       | ^
> >drivers/infiniband/core/nldev.c: In function =E2=80=98nldev_stat_get_cou=
nter_status_doit=E2=80=99:
> >drivers/infiniband/core/nldev.c:2438:1: warning: the frame size of 1096 =
bytes is larger than 1024 bytes [-Wframe-larger-than=3D]
> >  2438 | }
> >       | ^
> >net/sunrpc/auth_gss/gss_krb5_crypto.c: In function =E2=80=98gss_krb5_aes=
_encrypt=E2=80=99:
> >net/sunrpc/auth_gss/gss_krb5_crypto.c:717:1: warning: the frame size of =
1120 bytes is larger than 1024 bytes [-Wframe-larger-than=3D]
> >   717 | }
> >       | ^
> >net/sunrpc/auth_gss/gss_krb5_crypto.c: In function =E2=80=98gss_krb5_aes=
_decrypt=E2=80=99:
> >net/sunrpc/auth_gss/gss_krb5_crypto.c:810:1: warning: the frame size of =
1168 bytes is larger than 1024 bytes [-Wframe-larger-than=3D]
> >   810 | }
> >       | ^
> >fs/lockd/svcsubs.c: In function =E2=80=98nlmsvc_mark_resources=E2=80=99:
> >fs/lockd/svcsubs.c:418:1: warning: the frame size of 1152 bytes is large=
r than 1024 bytes [-Wframe-larger-than=3D]
> >   418 | }
> >       | ^
> >make -f ./Makefile
> >   CALL    scripts/checksyscalls.sh
> >   CALL    scripts/atomic/check-atomics.sh
> >   DESCEND objtool
> >   CHK     include/generated/compile.h
> >   BUILD   arch/x86/boot/bzImage
> >Kernel: arch/x86/boot/bzImage is ready  (#1278)
> >sh ./scripts/package/buildtar targz-pkg
> >   INSTALL tar-install/lib/modules/5.16.0-00002-g616758bf6583/kernel/cry=
pto/authenc.ko
> >   INSTALL tar-install/lib/modules/5.16.0-00002-g616758bf6583/kernel/cry=
pto/authencesn.ko
> >   INSTALL tar-install/lib/modules/5.16.0-00002-g616758bf6583/kernel/cry=
pto/crypto_engine.ko
> >   INSTALL tar-install/lib/modules/5.16.0-00002-g616758bf6583/kernel/cry=
pto/echainiv.ko
> >   INSTALL tar-install/lib/modules/5.16.0-00002-g616758bf6583/kernel/dri=
vers/crypto/virtio/virtio_crypto.ko
> >   INSTALL tar-install/lib/modules/5.16.0-00002-g616758bf6583/kernel/dri=
vers/scsi/iscsi_tcp.ko
> >   INSTALL tar-install/lib/modules/5.16.0-00002-g616758bf6583/kernel/dri=
vers/scsi/libiscsi.ko
> >   INSTALL tar-install/lib/modules/5.16.0-00002-g616758bf6583/kernel/dri=
vers/scsi/libiscsi_tcp.ko
> >   INSTALL tar-install/lib/modules/5.16.0-00002-g616758bf6583/kernel/dri=
vers/scsi/scsi_transport_iscsi.ko
> >   INSTALL tar-install/lib/modules/5.16.0-00002-g616758bf6583/kernel/dri=
vers/thermal/intel/x86_pkg_temp_thermal.ko
> >   INSTALL tar-install/lib/modules/5.16.0-00002-g616758bf6583/kernel/fs/=
lockd/lockd.ko
> >   INSTALL tar-install/lib/modules/5.16.0-00002-g616758bf6583/kernel/fs/=
nfs/blocklayout/blocklayoutdriver.ko
> >   INSTALL tar-install/lib/modules/5.16.0-00002-g616758bf6583/kernel/fs/=
nfs/filelayout/nfs_layout_nfsv41_files.ko
> >   INSTALL tar-install/lib/modules/5.16.0-00002-g616758bf6583/kernel/fs/=
nfs/flexfilelayout/nfs_layout_flexfiles.ko
> >   INSTALL tar-install/lib/modules/5.16.0-00002-g616758bf6583/kernel/fs/=
nfs/nfs.ko
> >   INSTALL tar-install/lib/modules/5.16.0-00002-g616758bf6583/kernel/fs/=
nfs/nfsv2.ko
> >   INSTALL tar-install/lib/modules/5.16.0-00002-g616758bf6583/kernel/fs/=
nfs/nfsv3.ko
> >   INSTALL tar-install/lib/modules/5.16.0-00002-g616758bf6583/kernel/fs/=
nfs/nfsv4.ko
> >   INSTALL tar-install/lib/modules/5.16.0-00002-g616758bf6583/kernel/fs/=
nfs_common/grace.ko
> >   INSTALL tar-install/lib/modules/5.16.0-00002-g616758bf6583/kernel/fs/=
nfs_common/nfs_acl.ko
> >   INSTALL tar-install/lib/modules/5.16.0-00002-g616758bf6583/kernel/fs/=
nfsd/nfsd.ko
> >   INSTALL tar-install/lib/modules/5.16.0-00002-g616758bf6583/kernel/net=
/sched/cls_bpf.ko
> >   INSTALL tar-install/lib/modules/5.16.0-00002-g616758bf6583/kernel/net=
/sunrpc/auth_gss/auth_rpcgss.ko
> >   INSTALL tar-install/lib/modules/5.16.0-00002-g616758bf6583/kernel/net=
/sunrpc/auth_gss/rpcsec_gss_krb5.ko
> >   INSTALL tar-install/lib/modules/5.16.0-00002-g616758bf6583/kernel/net=
/sunrpc/sunrpc.ko
> >   INSTALL tar-install/lib/modules/5.16.0-00002-g616758bf6583/kernel/net=
/sunrpc/xprtrdma/rpcrdma.ko
> >   DEPMOD  ./tar-install/lib/modules/5.16.0-00002-g616758bf6583
> >'./System.map' -> './tar-install/boot/System.map-5.16.0-00002-g616758bf6=
583'
> >'.config' -> './tar-install/boot/config-5.16.0-00002-g616758bf6583'
> >'./vmlinux' -> './tar-install/boot/vmlinux-5.16.0-00002-g616758bf6583'
> >'./arch/x86/boot/bzImage' -> './tar-install/boot/vmlinuz-5.16.0-00002-g6=
16758bf6583'
> >Tarball successfully created in ./linux-5.16.0-00002-g616758bf6583-x86_6=
4.tar.gz
> >user pynfs tests:
> >WARNING - could not create /b'exports/xfs/pynfstest-user/tree/block'
> >WARNING - could not create /b'exports/xfs/pynfstest-user/tree/char'
> >DELEG22  st_delegation.testServerSelfConflict2                    : RUNN=
ING
> >DELEG22  st_delegation.testServerSelfConflict2                    : PASS
> >DELEG21  st_delegation.testServerSelfConflict                     : RUNN=
ING
> >DELEG21  st_delegation.testServerSelfConflict                     : PASS
> >DELEG18  st_delegation.testServerRenameTarget                     : RUNN=
ING
> >*****CB received COMPOUND******
> >******* CB_Recall (id=3D3)********
> >DELEG18  st_delegation.testServerRenameTarget                     : PASS
> >DELEG17  st_delegation.testServerRenameSource                     : RUNN=
ING
> >*****CB received COMPOUND******
> >******* CB_Recall (id=3D4)********
> >DELEG17  st_delegation.testServerRenameSource                     : PASS
> >DELEG16  st_delegation.testServerRemove                           : RUNN=
ING
> >*****CB received COMPOUND******
> >******* CB_Recall (id=3D5)********
> >DELEG16  st_delegation.testServerRemove                           : PASS
> >DELEG19  st_delegation.testServerLink                             : RUNN=
ING
> >*****CB received COMPOUND******
> >******* CB_Recall (id=3D6)********
> >DELEG19  st_delegation.testServerLink                             : PASS
> >DELEG20  st_delegation.testServerChmod                            : RUNN=
ING
> >*****CB received COMPOUND******
> >******* CB_Recall (id=3D7)********
> >DELEG20  st_delegation.testServerChmod                            : PASS
> >DELEG6   st_delegation.testRenew                                  : RUNN=
ING
> >Sleeping for 7.5 seconds: Waiting to send RENEW
> >Woke up
> >DELEG6   st_delegation.testRenew                                  : PASS
> >DELEG15d st_delegation.testRenameOver                             : RUNN=
ING
> >*****CB received COMPOUND******
> >******* CB_Recall (id=3D9)********
> >Sleeping for 1 seconds: Got NFS4ERR_DELAY on rename
> >Woke up
> >DELEG15d st_delegation.testRenameOver                             : PASS
> >DELEG15c st_delegation.testRename                                 : RUNN=
ING
> >*****CB received COMPOUND******
> >******* CB_Recall (id=3D10)********
> >Sleeping for 1 seconds: Got NFS4ERR_DELAY on rename
> >Woke up
> >DELEG15c st_delegation.testRename                                 : PASS
> >DELEG15a st_delegation.testRemove                                 : RUNN=
ING
> >Sleeping for 1 seconds: Got NFS4ERR_DELAY on remove
> >*****CB received COMPOUND******
> >******* CB_Recall (id=3D11)********
> >Woke up
> >DELEG15a st_delegation.testRemove                                 : PASS
> >DELEG3e  st_delegation.testReadDeleg3e                            : RUNN=
ING
> >Sleeping for 1 seconds: Got NFS4ERR_DELAY on open
> >*****CB received COMPOUND******
> >******* CB_Recall (id=3D12)********
> >Woke up
> >Sleeping for 1 seconds: Got NFS4ERR_DELAY on open
> >Woke up
> >Sleeping for 1 seconds: Got NFS4ERR_DELAY on open
> >Woke up
> >Sleeping for 1 seconds: Got NFS4ERR_DELAY on open
> >Woke up
> >Sleeping for 1 seconds: Got NFS4ERR_DELAY on open
> >Woke up
> >Sleeping for 1 seconds: Got NFS4ERR_DELAY on open
> >Woke up
> >Sleeping for 1 seconds: Got NFS4ERR_DELAY on open
> >Woke up
> >Sleeping for 1 seconds: Got NFS4ERR_DELAY on open
> >Woke up
> >Sleeping for 1 seconds: Got NFS4ERR_DELAY on open
> >Woke up
> >Sleeping for 1 seconds: Got NFS4ERR_DELAY on open
> >Woke up
> >Sleeping for 1 seconds: Got NFS4ERR_DELAY on open
> >Woke up
> >Sleeping for 1 seconds: Got NFS4ERR_DELAY on open
> >Woke up
> >Sleeping for 1 seconds: Got NFS4ERR_DELAY on open
> >Woke up
> >Sleeping for 1 seconds: Got NFS4ERR_DELAY on open
> >Woke up
> >Sleeping for 1 seconds: Got NFS4ERR_DELAY on open
> >Woke up
> >Sleeping for 1 seconds: Got NFS4ERR_DELAY on open
> >Woke up
> >DELEG3e  st_delegation.testReadDeleg3e                            : PASS
> >DELEG3d  st_delegation.testReadDeleg3d                            : RUNN=
ING
> >Sleeping for 1 seconds: Got NFS4ERR_DELAY on open
> >*****CB received COMPOUND******
> >******* CB_Recall (id=3D13)********
> >Woke up
> >Sleeping for 1 seconds: Got NFS4ERR_DELAY on open
> >Woke up
> >Sleeping for 1 seconds: Got NFS4ERR_DELAY on open
> >Woke up
> >Sleeping for 1 seconds: Got NFS4ERR_DELAY on open
> >Woke up
> >Sleeping for 1 seconds: Got NFS4ERR_DELAY on open
> >Woke up
> >Sleeping for 1 seconds: Got NFS4ERR_DELAY on open
> >Woke up
> >Sleeping for 1 seconds: Got NFS4ERR_DELAY on open
> >Woke up
> >Sleeping for 1 seconds: Got NFS4ERR_DELAY on open
> >Woke up
> >Sleeping for 1 seconds: Got NFS4ERR_DELAY on open
> >Woke up
> >Sleeping for 1 seconds: Got NFS4ERR_DELAY on open
> >Woke up
> >Sleeping for 1 seconds: Got NFS4ERR_DELAY on open
> >Woke up
> >Sleeping for 1 seconds: Got NFS4ERR_DELAY on open
> >Woke up
> >Sleeping for 1 seconds: Got NFS4ERR_DELAY on open
> >Woke up
> >Sleeping for 1 seconds: Got NFS4ERR_DELAY on open
> >Woke up
> >Sleeping for 1 seconds: Got NFS4ERR_DELAY on open
> >Woke up
> >Sleeping for 1 seconds: Got NFS4ERR_DELAY on open
> >Woke up
> >DELEG3d  st_delegation.testReadDeleg3d                            : PASS
> >DELEG3c  st_delegation.testReadDeleg3c                            : RUNN=
ING
> >Sleeping for 1 seconds: Got NFS4ERR_DELAY on open
> >*****CB received COMPOUND******
> >******* CB_Recall (id=3D14)********
> >Woke up
> >Sleeping for 1 seconds: Got NFS4ERR_DELAY on open
> >Woke up
> >Sleeping for 1 seconds: Got NFS4ERR_DELAY on open
> >Woke up
> >Sleeping for 1 seconds: Got NFS4ERR_DELAY on open
> >Woke up
> >Sleeping for 1 seconds: Got NFS4ERR_DELAY on open
> >Woke up
> >Sleeping for 1 seconds: Got NFS4ERR_DELAY on open
> >Woke up
> >Sleeping for 1 seconds: Got NFS4ERR_DELAY on open
> >Woke up
> >Sleeping for 1 seconds: Got NFS4ERR_DELAY on open
> >Woke up
> >Sleeping for 1 seconds: Got NFS4ERR_DELAY on open
> >Woke up
> >Sleeping for 1 seconds: Got NFS4ERR_DELAY on open
> >Woke up
> >Sleeping for 1 seconds: Got NFS4ERR_DELAY on open
> >Woke up
> >Sleeping for 1 seconds: Got NFS4ERR_DELAY on open
> >Woke up
> >Sleeping for 1 seconds: Got NFS4ERR_DELAY on open
> >Woke up
> >Sleeping for 1 seconds: Got NFS4ERR_DELAY on open
> >Woke up
> >Sleeping for 1 seconds: Got NFS4ERR_DELAY on open
> >Woke up
> >Sleeping for 1 seconds: Got NFS4ERR_DELAY on open
> >Woke up
> >Sleeping for 1 seconds: Got NFS4ERR_DELAY on open
> >Woke up
> >DELEG3c  st_delegation.testReadDeleg3c                            : PASS
> >DELEG3b  st_delegation.testReadDeleg3b                            : RUNN=
ING
> >Sleeping for 1 seconds: Got NFS4ERR_DELAY on open
> >*****CB received COMPOUND******
> >******* CB_Recall (id=3D15)********
> >Woke up
> >Sleeping for 1 seconds: Got NFS4ERR_DELAY on open
> >Woke up
> >Sleeping for 1 seconds: Got NFS4ERR_DELAY on open
> >Woke up
> >Sleeping for 1 seconds: Got NFS4ERR_DELAY on open
> >Woke up
> >Sleeping for 1 seconds: Got NFS4ERR_DELAY on open
> >Woke up
> >Sleeping for 1 seconds: Got NFS4ERR_DELAY on open
> >Woke up
> >Sleeping for 1 seconds: Got NFS4ERR_DELAY on open
> >Woke up
> >Sleeping for 1 seconds: Got NFS4ERR_DELAY on open
> >Woke up
> >Sleeping for 1 seconds: Got NFS4ERR_DELAY on open
> >Woke up
> >Sleeping for 1 seconds: Got NFS4ERR_DELAY on open
> >Woke up
> >Sleeping for 1 seconds: Got NFS4ERR_DELAY on open
> >Woke up
> >Sleeping for 1 seconds: Got NFS4ERR_DELAY on open
> >Woke up
> >Sleeping for 1 seconds: Got NFS4ERR_DELAY on open
> >Woke up
> >Sleeping for 1 seconds: Got NFS4ERR_DELAY on open
> >Woke up
> >Sleeping for 1 seconds: Got NFS4ERR_DELAY on open
> >Woke up
> >Sleeping for 1 seconds: Got NFS4ERR_DELAY on open
> >Woke up
> >DELEG3b  st_delegation.testReadDeleg3b                            : PASS
> >DELEG3a  st_delegation.testReadDeleg3a                            : RUNN=
ING
> >Sleeping for 1 seconds: Got NFS4ERR_DELAY on open
> >*****CB received COMPOUND******
> >******* CB_Recall (id=3D16)********
> >Woke up
> >Sleeping for 1 seconds: Got NFS4ERR_DELAY on open
> >Woke up
> >Sleeping for 1 seconds: Got NFS4ERR_DELAY on open
> >Woke up
> >Sleeping for 1 seconds: Got NFS4ERR_DELAY on open
> >Woke up
> >Sleeping for 1 seconds: Got NFS4ERR_DELAY on open
> >Woke up
> >Sleeping for 1 seconds: Got NFS4ERR_DELAY on open
> >Woke up
> >Sleeping for 1 seconds: Got NFS4ERR_DELAY on open
> >Woke up
> >Sleeping for 1 seconds: Got NFS4ERR_DELAY on open
> >Woke up
> >Sleeping for 1 seconds: Got NFS4ERR_DELAY on open
> >Woke up
> >Sleeping for 1 seconds: Got NFS4ERR_DELAY on open
> >Woke up
> >Sleeping for 1 seconds: Got NFS4ERR_DELAY on open
> >Woke up
> >Sleeping for 1 seconds: Got NFS4ERR_DELAY on open
> >Woke up
> >Sleeping for 1 seconds: Got NFS4ERR_DELAY on open
> >Woke up
> >Sleeping for 1 seconds: Got NFS4ERR_DELAY on open
> >Woke up
> >Sleeping for 1 seconds: Got NFS4ERR_DELAY on open
> >Woke up
> >Sleeping for 1 seconds: Got NFS4ERR_DELAY on open
> >Woke up
> >Sleeping for 1 seconds: Got NFS4ERR_DELAY on open
> >Woke up
> >DELEG3a  st_delegation.testReadDeleg3a                            : PASS
> >DELEG2   st_delegation.testReadDeleg2                             : RUNN=
ING
> >*****CB received COMPOUND******
> >******* CB_Recall (id=3D17)********
> >Sleeping for 1 seconds: Got NFS4ERR_DELAY on open
> >Woke up
> >Sleeping for 1 seconds: Got NFS4ERR_DELAY on open
> >Woke up
> >Sleeping for 1 seconds: Got NFS4ERR_DELAY on open
> >Woke up
> >Sleeping for 1 seconds: Got NFS4ERR_DELAY on open
> >Woke up
> >Sleeping for 1 seconds: Got NFS4ERR_DELAY on open
> >Woke up
> >Sleeping for 1 seconds: Got NFS4ERR_DELAY on open
> >Woke up
> >Sleeping for 1 seconds: Got NFS4ERR_DELAY on open
> >Woke up
> >Sleeping for 1 seconds: Got NFS4ERR_DELAY on open
> >Woke up
> >Sleeping for 1 seconds: Got NFS4ERR_DELAY on open
> >Woke up
> >Sleeping for 1 seconds: Got NFS4ERR_DELAY on open
> >Woke up
> >Sleeping for 1 seconds: Got NFS4ERR_DELAY on open
> >Woke up
> >Sleeping for 1 seconds: Got NFS4ERR_DELAY on open
> >Woke up
> >Sleeping for 1 seconds: Got NFS4ERR_DELAY on open
> >Woke up
> >Sleeping for 1 seconds: Got NFS4ERR_DELAY on open
> >Woke up
> >Sleeping for 1 seconds: Got NFS4ERR_DELAY on open
> >Woke up
> >Sleeping for 1 seconds: Got NFS4ERR_DELAY on open
> >Woke up
> >Sleeping for 1 seconds: Got NFS4ERR_DELAY on open
> >Woke up
> >DELEG2   st_delegation.testReadDeleg2                             : PASS
> >DELEG1   st_delegation.testReadDeleg1                             : RUNN=
ING
> >Sleeping for 1 seconds: Got NFS4ERR_DELAY on open
> >*****CB received COMPOUND******
> >******* CB_Recall (id=3D18)********
> >Woke up
> >DELEG1   st_delegation.testReadDeleg1                             : PASS
> >DELEG15b st_delegation.testLink                                   : RUNN=
ING
> >Sleeping for 1 seconds: Got NFS4ERR_DELAY on link
> >*****CB received COMPOUND******
> >******* CB_Recall (id=3D19)********
> >Woke up
> >DELEG15b st_delegation.testLink                                   : PASS
> >DELEG7   st_delegation.testIgnoreDeleg                            : RUNN=
ING
> >Sleeping for 1 seconds: Got NFS4ERR_DELAY on open
> >*****CB received COMPOUND******
> >******* CB_Recall (id=3D20)********
> >Woke up
> >DELEG7   st_delegation.testIgnoreDeleg                            : PASS
> >DELEG8   st_delegation.testDelegShare                             : RUNN=
ING
> >DELEG8   st_delegation.testDelegShare                             : PASS
> >DELEG4   st_delegation.testCloseDeleg                             : RUNN=
ING
> >Sleeping for 1 seconds: Got NFS4ERR_DELAY on open
> >*****CB received COMPOUND******
> >******* CB_Recall (id=3D22)********
> >Woke up
> >DELEG4   st_delegation.testCloseDeleg                             : PASS
> >DELEG14  st_delegation.testClaimCur                               : RUNN=
ING
> >Sleeping for 2 seconds: Waiting for recall
> >*****CB received COMPOUND******
> >******* CB_Recall (id=3D23)********
> >Woke up
> >DELEG14  st_delegation.testClaimCur                               : PASS
> >DELEG9   st_delegation.testChangeDeleg                            : RUNN=
ING
> >Sleeping for 3 seconds:
> >Woke up
> >Sleeping for 1 seconds: Got NFS4ERR_DELAY on open
> >*****CB received COMPOUND******
> >******* CB_Recall (id=3D1)********
> >Woke up
> >Sleeping for 1 seconds: Got NFS4ERR_DELAY on open
> >Woke up
> >Sleeping for 1 seconds: Got NFS4ERR_DELAY on open
> >Woke up
> >Sleeping for 1 seconds: Got NFS4ERR_DELAY on open
> >Woke up
> >Sleeping for 1 seconds: Got NFS4ERR_DELAY on open
> >Woke up
> >Sleeping for 1 seconds: Got NFS4ERR_DELAY on open
> >Woke up
> >Sleeping for 1 seconds: Got NFS4ERR_DELAY on open
> >Woke up
> >Sleeping for 1 seconds: Got NFS4ERR_DELAY on open
> >Woke up
> >Sleeping for 1 seconds: Got NFS4ERR_DELAY on open
> >Woke up
> >Sleeping for 1 seconds: Got NFS4ERR_DELAY on open
> >Woke up
> >Sleeping for 1 seconds: Got NFS4ERR_DELAY on open
> >Woke up
> >Sleeping for 1 seconds: Got NFS4ERR_DELAY on open
> >Woke up
> >Sleeping for 1 seconds: Got NFS4ERR_DELAY on open
> >Woke up
> >Sleeping for 1 seconds: Got NFS4ERR_DELAY on open
> >Woke up
> >Sleeping for 1 seconds: Got NFS4ERR_DELAY on open
> >Woke up
> >Sleeping for 1 seconds: Got NFS4ERR_DELAY on open
> >Woke up
> >DELEG9   st_delegation.testChangeDeleg                            : PASS
> >INIT     st_setclientid.testValid                                 : RUNN=
ING
> >INIT     st_setclientid.testValid                                 : PASS
> >MKFILE   st_open.testOpen                                         : RUNN=
ING
> >MKFILE   st_open.testOpen                                         : PASS
> >REBT8    st_reboot.testValidDeleg                                 : RUNN=
ING
> >Got error: Connection closed
> >Sleeping for 20 seconds: Waiting for grace period to end
> >Woke up
> >REBT8    st_reboot.testValidDeleg                                 : PASS
> >REBT3    st_reboot.testRebootWait                                 : RUNN=
ING
> >Got error: Connection closed
> >Sleeping for 10 seconds: Waiting till halfway through grace period
> >Woke up
> >Sleeping for 11 seconds: Waiting for grace period to end
> >Woke up
> >REBT3    st_reboot.testRebootWait                                 : PASS
> >REBT1    st_reboot.testRebootValid                                : RUNN=
ING
> >Got error: Connection closed
> >Sleeping for 20 seconds: Waiting for grace period to end
> >Woke up
> >REBT1    st_reboot.testRebootValid                                : PASS
> >REBT10   st_reboot.testRebootMultiple                             : RUNN=
ING
> >Got error: Connection closed
> >Got error: Connection closed
> >Sleeping for 20 seconds: Waiting for grace period to end
> >Woke up
> >REBT10   st_reboot.testRebootMultiple                             : PASS
> >MKDIR    st_create.testDir                                        : RUNN=
ING
> >MKDIR    st_create.testDir                                        : PASS
> >REBT2    st_reboot.testManyClaims                                 : RUNN=
ING
> >Got error: Connection closed
> >Sleeping for 20 seconds: Waiting for grace period to end
> >Woke up
> >REBT2    st_reboot.testManyClaims                                 : PASS
> >REBT11   st_reboot.testGraceSeqid                                 : RUNN=
ING
> >Got error: Connection closed
> >Sleeping for 10 seconds: Waiting till halfway through grace period
> >Woke up
> >Sleeping for 11 seconds: Waiting for grace period to end
> >Woke up
> >REBT11   st_reboot.testGraceSeqid                                 : PASS
> >REBT6    st_reboot.testEdge2                                      : RUNN=
ING
> >Got error: Connection closed
> >Sleeping for 20 seconds: Waiting for grace period to end
> >Woke up
> >Got error: Connection closed
> >Got error: Connection closed
> >Got error: Connection closed
> >Sleeping for 20 seconds: Waiting for grace period to end
> >Woke up
> >REBT6    st_reboot.testEdge2                                      : PASS
> >REBT5    st_reboot.testEdge1                                      : RUNN=
ING
> >Sleeping for 22 seconds: Waiting for lock lease to expire
> >Woke up
> >Got error: Connection closed
> >Got error: Connection closed
> >Sleeping for 20 seconds: Waiting for grace period to end
> >Woke up
> >REBT5    st_reboot.testEdge1                                      : PASS
> >RPLY8    st_replay.testUnlockWait                                 : RUNN=
ING
> >Sleeping for 30 seconds:
> >Woke up
> >Sleeping for 0.3 seconds:
> >Woke up
> >Sleeping for 0.3 seconds:
> >Woke up
> >RPLY8    st_replay.testUnlockWait                                 : PASS
> >RPLY7    st_replay.testUnlock                                     : RUNN=
ING
> >Sleeping for 0.3 seconds:
> >Woke up
> >Sleeping for 0.3 seconds:
> >Woke up
> >RPLY7    st_replay.testUnlock                                     : PASS
> >RPLY3    st_replay.testReplayState2                               : RUNN=
ING
> >Sleeping for 0.3 seconds:
> >Woke up
> >Sleeping for 0.3 seconds:
> >Woke up
> >RPLY3    st_replay.testReplayState2                               : PASS
> >RPLY2    st_replay.testReplayState1                               : RUNN=
ING
> >Sleeping for 0.3 seconds:
> >Woke up
> >Sleeping for 0.3 seconds:
> >Woke up
> >RPLY2    st_replay.testReplayState1                               : PASS
> >RPLY4    st_replay.testReplayNonState                             : RUNN=
ING
> >Sleeping for 0.3 seconds:
> >Woke up
> >Sleeping for 0.3 seconds:
> >Woke up
> >RPLY4    st_replay.testReplayNonState                             : PASS
> >RPLY13   st_replay.testOpenConfirmFail                            : RUNN=
ING
> >Sleeping for 0.3 seconds:
> >Woke up
> >Sleeping for 0.3 seconds:
> >Woke up
> >RPLY13   st_replay.testOpenConfirmFail                            : PASS
> >RPLY12   st_replay.testOpenConfirm                                : RUNN=
ING
> >Sleeping for 0.3 seconds:
> >Woke up
> >Sleeping for 0.3 seconds:
> >Woke up
> >RPLY12   st_replay.testOpenConfirm                                : PASS
> >RPLY1    st_replay.testOpen                                       : RUNN=
ING
> >Sleeping for 0.3 seconds:
> >Woke up
> >Sleeping for 0.3 seconds:
> >Woke up
> >RPLY1    st_replay.testOpen                                       : PASS
> >RPLY14   st_replay.testMkdirReplay                                : RUNN=
ING
> >Sleeping for 0.3 seconds:
> >Woke up
> >Sleeping for 0.3 seconds:
> >Woke up
> >RPLY14   st_replay.testMkdirReplay                                : PASS
> >RPLY6    st_replay.testLockDenied                                 : RUNN=
ING
> >Sleeping for 0.3 seconds:
> >Woke up
> >Sleeping for 0.3 seconds:
> >Woke up
> >RPLY6    st_replay.testLockDenied                                 : PASS
> >RPLY5    st_replay.testLock                                       : RUNN=
ING
> >Sleeping for 0.3 seconds:
> >Woke up
> >Sleeping for 0.3 seconds:
> >Woke up
> >RPLY5    st_replay.testLock                                       : PASS
> >RPLY10   st_replay.testCloseWait                                  : RUNN=
ING
> >Sleeping for 30 seconds:
> >Woke up
> >Sleeping for 0.3 seconds:
> >Woke up
> >Sleeping for 0.3 seconds:
> >Woke up
> >RPLY10   st_replay.testCloseWait                                  : PASS
> >RPLY11   st_replay.testCloseFail                                  : RUNN=
ING
> >Sleeping for 0.3 seconds:
> >Woke up
> >Sleeping for 0.3 seconds:
> >Woke up
> >RPLY11   st_replay.testCloseFail                                  : PASS
> >RPLY9    st_replay.testClose                                      : RUNN=
ING
> >Sleeping for 0.3 seconds:
> >Woke up
> >Sleeping for 0.3 seconds:
> >Woke up
> >RPLY9    st_replay.testClose                                      : PASS
> >WRT3     st_write.testWithOpen                                    : RUNN=
ING
> >WRT3     st_write.testWithOpen                                    : PASS
> >WRT5b    st_write.testTooLargeData                                : RUNN=
ING
> >WRT5b    st_write.testTooLargeData                                : PASS
> >WRT19    st_write.testStolenStateid                               : RUNN=
ING
> >WRT19    st_write.testStolenStateid                               : PASS
> >WRT2     st_write.testStateidOne                                  : RUNN=
ING
> >WRT2     st_write.testStateidOne                                  : PASS
> >WRT11    st_write.testStaleStateid                                : RUNN=
ING
> >WRT11    st_write.testStaleStateid                                : PASS
> >MKSOCK   st_create.testSocket                                     : RUNN=
ING
> >MKSOCK   st_create.testSocket                                     : PASS
> >WRT6s    st_write.testSocket                                      : RUNN=
ING
> >WRT6s    st_write.testSocket                                      : PASS
> >WRT15    st_write.testSizes                                       : RUNN=
ING
> >WRT15    st_write.testSizes                                       : PASS
> >WRT1b    st_write.testSimpleWrite2                                : RUNN=
ING
> >WRT1b    st_write.testSimpleWrite2                                : PASS
> >WRT1     st_write.testSimpleWrite                                 : RUNN=
ING
> >WRT1     st_write.testSimpleWrite                                 : PASS
> >WRT9     st_write.testShareDeny                                   : RUNN=
ING
> >WRT9     st_write.testShareDeny                                   : PASS
> >WRT8     st_write.testOpenMode                                    : RUNN=
ING
> >WRT8     st_write.testOpenMode                                    : PASS
> >WRT12    st_write.testOldStateid                                  : RUNN=
ING
> >WRT12    st_write.testOldStateid                                  : PASS
> >WRT7     st_write.testNoFh                                        : RUNN=
ING
> >WRT7     st_write.testNoFh                                        : PASS
> >WRT4     st_write.testNoData                                      : RUNN=
ING
> >Sleeping for 1 seconds:
> >Woke up
> >WRT4     st_write.testNoData                                      : PASS
> >WRT5a    st_write.testMaximumData                                 : RUNN=
ING
> >WRT5a    st_write.testMaximumData                                 : PASS
> >MKLINK   st_create.testLink                                       : RUNN=
ING
> >MKLINK   st_create.testLink                                       : PASS
> >WRT6a    st_write.testLink                                        : RUNN=
ING
> >WRT6a    st_write.testLink                                        : PASS
> >WRT14    st_write.testLargeWrite                                  : RUNN=
ING
> >WRT14    st_write.testLargeWrite                                  : PASS
> >MKFIFO   st_create.testFIFO                                       : RUNN=
ING
> >MKFIFO   st_create.testFIFO                                       : PASS
> >WRT6f    st_write.testFifo                                        : RUNN=
ING
> >WRT6f    st_write.testFifo                                        : PASS
> >WRT13    st_write.testDoubleWrite                                 : RUNN=
ING
> >WRT13    st_write.testDoubleWrite                                 : PASS
> >WRT6d    st_write.testDir                                         : RUNN=
ING
> >WRT6d    st_write.testDir                                         : PASS
> >MODE     st_setattr.testMode                                      : RUNN=
ING
> >MODE     st_setattr.testMode                                      : PASS
> >WRT18    st_write.testChangeGranularityWrite                      : RUNN=
ING
> >WRT18    st_write.testChangeGranularityWrite                      : PASS
> >LOOKSOCK st_lookup.testSocket                                     : RUNN=
ING
> >LOOKSOCK st_lookup.testSocket                                     : PASS
> >VF5s     st_verify.testWriteOnlySocket                            : RUNN=
ING
> >VF5s     st_verify.testWriteOnlySocket                            : PASS
> >LOOKLINK st_lookup.testLink                                       : RUNN=
ING
> >LOOKLINK st_lookup.testLink                                       : PASS
> >VF5a     st_verify.testWriteOnlyLink                              : RUNN=
ING
> >VF5a     st_verify.testWriteOnlyLink                              : PASS
> >LOOKFILE st_lookup.testFile                                       : RUNN=
ING
> >LOOKFILE st_lookup.testFile                                       : PASS
> >VF5r     st_verify.testWriteOnlyFile                              : RUNN=
ING
> >VF5r     st_verify.testWriteOnlyFile                              : PASS
> >LOOKFIFO st_lookup.testFifo                                       : RUNN=
ING
> >LOOKFIFO st_lookup.testFifo                                       : PASS
> >VF5f     st_verify.testWriteOnlyFifo                              : RUNN=
ING
> >VF5f     st_verify.testWriteOnlyFifo                              : PASS
> >LOOKDIR  st_lookup.testDir                                        : RUNN=
ING
> >LOOKDIR  st_lookup.testDir                                        : PASS
> >VF5d     st_verify.testWriteOnlyDir                               : RUNN=
ING
> >VF5d     st_verify.testWriteOnlyDir                               : PASS
> >VF7s     st_verify.testUnsupportedSocket                          : RUNN=
ING
> >VF7s     st_verify.testUnsupportedSocket                          : PASS
> >VF7a     st_verify.testUnsupportedLink                            : RUNN=
ING
> >VF7a     st_verify.testUnsupportedLink                            : PASS
> >VF7r     st_verify.testUnsupportedFile                            : RUNN=
ING
> >VF7r     st_verify.testUnsupportedFile                            : PASS
> >VF7f     st_verify.testUnsupportedFifo                            : RUNN=
ING
> >VF7f     st_verify.testUnsupportedFifo                            : PASS
> >VF7d     st_verify.testUnsupportedDir                             : RUNN=
ING
> >VF7d     st_verify.testUnsupportedDir                             : PASS
> >VF2s     st_verify.testTypeSocket                                 : RUNN=
ING
> >VF2s     st_verify.testTypeSocket                                 : PASS
> >VF2a     st_verify.testTypeLink                                   : RUNN=
ING
> >VF2a     st_verify.testTypeLink                                   : PASS
> >VF2r     st_verify.testTypeFile                                   : RUNN=
ING
> >VF2r     st_verify.testTypeFile                                   : PASS
> >VF2f     st_verify.testTypeFifo                                   : RUNN=
ING
> >VF2f     st_verify.testTypeFifo                                   : PASS
> >VF2d     st_verify.testTypeDir                                    : RUNN=
ING
> >VF2d     st_verify.testTypeDir                                    : PASS
> >VF4      st_verify.testNoFh                                       : RUNN=
ING
> >VF4      st_verify.testNoFh                                       : PASS
> >VF1s     st_verify.testMandSocket                                 : RUNN=
ING
> >VF1s     st_verify.testMandSocket                                 : PASS
> >VF1a     st_verify.testMandLink                                   : RUNN=
ING
> >VF1a     st_verify.testMandLink                                   : PASS
> >VF1r     st_verify.testMandFile                                   : RUNN=
ING
> >VF1r     st_verify.testMandFile                                   : PASS
> >VF1f     st_verify.testMandFifo                                   : RUNN=
ING
> >VF1f     st_verify.testMandFifo                                   : PASS
> >VF1d     st_verify.testMandDir                                    : RUNN=
ING
> >VF1d     st_verify.testMandDir                                    : PASS
> >VF3s     st_verify.testBadSizeSocket                              : RUNN=
ING
> >VF3s     st_verify.testBadSizeSocket                              : PASS
> >VF3a     st_verify.testBadSizeLink                                : RUNN=
ING
> >VF3a     st_verify.testBadSizeLink                                : PASS
> >VF3r     st_verify.testBadSizeFile                                : RUNN=
ING
> >VF3r     st_verify.testBadSizeFile                                : PASS
> >VF3f     st_verify.testBadSizeFifo                                : RUNN=
ING
> >VF3f     st_verify.testBadSizeFifo                                : PASS
> >VF3d     st_verify.testBadSizeDir                                 : RUNN=
ING
> >VF3d     st_verify.testBadSizeDir                                 : PASS
> >CIDCF1   st_setclientidconfirm.testStale                          : RUNN=
ING
> >CIDCF1   st_setclientidconfirm.testStale                          : PASS
> >CIDCF3   st_setclientidconfirm.testAllCases                       : RUNN=
ING
> >CIDCF3   st_setclientidconfirm.testAllCases                       : PASS
> >CID4e    st_setclientid.testUnConfReplaced                        : RUNN=
ING
> >CID4e    st_setclientid.testUnConfReplaced                        : PASS
> >CID2     st_setclientid.testNotInUse                              : RUNN=
ING
> >CID2     st_setclientid.testNotInUse                              : PASS
> >CID6     st_setclientid.testNoConfirm                             : RUNN=
ING
> >CID6     st_setclientid.testNoConfirm                             : PASS
> >CID5     st_setclientid.testLotsOfClients                         : RUNN=
ING
> >CID5     st_setclientid.testLotsOfClients                         : PASS
> >CID3     st_setclientid.testLoseAnswer                            : RUNN=
ING
> >CID3     st_setclientid.testLoseAnswer                            : PASS
> >CID2a    st_setclientid.testInUse                                 : RUNN=
ING
> >CID2a    st_setclientid.testInUse                                 : PASS
> >CID4b    st_setclientid.testConfirmedDiffVerifier                 : RUNN=
ING
> >CID4b    st_setclientid.testConfirmedDiffVerifier                 : PASS
> >CID4d    st_setclientid.testConfUnConfDiffVerifier2               : RUNN=
ING
> >CID4d    st_setclientid.testConfUnConfDiffVerifier2               : PASS
> >CID4c    st_setclientid.testConfUnConfDiffVerifier1               : RUNN=
ING
> >CID4c    st_setclientid.testConfUnConfDiffVerifier1               : PASS
> >CID1b    st_setclientid.testClientUpdateCallback                  : RUNN=
ING
> >CID1b    st_setclientid.testClientUpdateCallback                  : PASS
> >CID1     st_setclientid.testClientReboot                          : RUNN=
ING
> >CID1     st_setclientid.testClientReboot                          : PASS
> >CID4a    st_setclientid.testCallbackInfoUpdate                    : RUNN=
ING
> >CID4a    st_setclientid.testCallbackInfoUpdate                    : PASS
> >CID4     st_setclientid.testAllCases                              : RUNN=
ING
> >CID4     st_setclientid.testAllCases                              : PASS
> >SATT2c   st_setattr.testUselessStateid3                           : RUNN=
ING
> >SATT2c   st_setattr.testUselessStateid3                           : PASS
> >SATT2b   st_setattr.testUselessStateid2                           : RUNN=
ING
> >SATT2b   st_setattr.testUselessStateid2                           : PASS
> >SATT2a   st_setattr.testUselessStateid1                           : RUNN=
ING
> >SATT2a   st_setattr.testUselessStateid1                           : PASS
> >SATT11s  st_setattr.testUnsupportedSocket                         : RUNN=
ING
> >SATT11s  st_setattr.testUnsupportedSocket                         : PASS
> >SATT11a  st_setattr.testUnsupportedLink                           : RUNN=
ING
> >SATT11a  st_setattr.testUnsupportedLink                           : PASS
> >SATT11r  st_setattr.testUnsupportedFile                           : RUNN=
ING
> >SATT11r  st_setattr.testUnsupportedFile                           : PASS
> >SATT11f  st_setattr.testUnsupportedFifo                           : RUNN=
ING
> >SATT11f  st_setattr.testUnsupportedFifo                           : PASS
> >SATT11d  st_setattr.testUnsupportedDir                            : RUNN=
ING
> >SATT11d  st_setattr.testUnsupportedDir                            : PASS
> >SATT12s  st_setattr.testSizeSocket                                : RUNN=
ING
> >SATT12s  st_setattr.testSizeSocket                                : PASS
> >SATT12a  st_setattr.testSizeLink                                  : RUNN=
ING
> >SATT12a  st_setattr.testSizeLink                                  : PASS
> >SATT12f  st_setattr.testSizeFifo                                  : RUNN=
ING
> >SATT12f  st_setattr.testSizeFifo                                  : PASS
> >SATT12d  st_setattr.testSizeDir                                   : RUNN=
ING
> >SATT12d  st_setattr.testSizeDir                                   : PASS
> >SATT3d   st_setattr.testResizeFile3                               : RUNN=
ING
> >SATT3d   st_setattr.testResizeFile3                               : PASS
> >SATT3c   st_setattr.testResizeFile2                               : RUNN=
ING
> >SATT3c   st_setattr.testResizeFile2                               : PASS
> >SATT3b   st_setattr.testResizeFile1                               : RUNN=
ING
> >SATT3b   st_setattr.testResizeFile1                               : PASS
> >SATT3a   st_setattr.testResizeFile0                               : RUNN=
ING
> >SATT3a   st_setattr.testResizeFile0                               : PASS
> >SATT6d   st_setattr.testReadonlyDir                               : RUNN=
ING
> >SATT6d   st_setattr.testReadonlyDir                               : PASS
> >SATT6s   st_setattr.testReadonlySocket                            : RUNN=
ING
> >SATT6s   st_setattr.testReadonlySocket                            : PASS
> >SATT6a   st_setattr.testReadonlyLink                              : RUNN=
ING
> >SATT6a   st_setattr.testReadonlyLink                              : PASS
> >SATT6r   st_setattr.testReadonlyFile                              : RUNN=
ING
> >SATT6r   st_setattr.testReadonlyFile                              : PASS
> >SATT6f   st_setattr.testReadonlyFifo                              : RUNN=
ING
> >SATT6f   st_setattr.testReadonlyFifo                              : PASS
> >SATT4    st_setattr.testOpenModeResize                            : RUNN=
ING
> >SATT4    st_setattr.testOpenModeResize                            : PASS
> >SATT5    st_setattr.testNoFh                                      : RUNN=
ING
> >SATT5    st_setattr.testNoFh                                      : PASS
> >SATT10   st_setattr.testInvalidTime                               : RUNN=
ING
> >SATT10   st_setattr.testInvalidTime                               : PASS
> >SATT8    st_setattr.testInvalidAttr2                              : RUNN=
ING
> >SATT8    st_setattr.testInvalidAttr2                              : PASS
> >SATT7    st_setattr.testInvalidAttr1                              : RUNN=
ING
> >Traceback (most recent call last):
> >   File "/root/pynfs/nfs4.0/lib/testmod.py", line 234, in run
> >     self.runtest(self, environment)
> >   File "/root/pynfs/nfs4.0/servertests/st_renew.py", line 41, in testEx=
pired
> >     c2.open_confirm(t.word(), access=3DOPEN4_SHARE_ACCESS_READ,
> >   File "/root/pynfs/nfs4.0/nfs4lib.py", line 727, in open_confirm
> >     check_result(res, "Opening file %s" % _getname(owner, path))
> >   File "/root/pynfs/nfs4.0/nfs4lib.py", line 895, in check_result
> >     raise BadCompoundRes(resop, res.status, msg)
> >nfs4lib.BadCompoundRes: Opening file b'RENEW3-1': operation OP_OPEN shou=
ld return NFS4_OK, instead got NFS4ERR_DELAY
> >SATT7    st_setattr.testInvalidAttr1                              : PASS
> >SATT13   st_setattr.testInodeLocking                              : RUNN=
ING
> >SATT13   st_setattr.testInodeLocking                              : PASS
> >SATT1r   st_setattr.testFile                                      : RUNN=
ING
> >SATT1r   st_setattr.testFile                                      : PASS
> >SATT1f   st_setattr.testFifo                                      : RUNN=
ING
> >SATT1f   st_setattr.testFifo                                      : PASS
> >SATT16   st_setattr.testEmptyPrincipal                            : RUNN=
ING
> >SATT16   st_setattr.testEmptyPrincipal                            : PASS
> >SATT17   st_setattr.testEmptyGroupPrincipal                       : RUNN=
ING
> >SATT17   st_setattr.testEmptyGroupPrincipal                       : PASS
> >SATT1d   st_setattr.testDir                                       : RUNN=
ING
> >SATT1d   st_setattr.testDir                                       : PASS
> >SATT15   st_setattr.testChangeGranularity                         : RUNN=
ING
> >SATT15   st_setattr.testChangeGranularity                         : PASS
> >SATT14   st_setattr.testChange                                    : RUNN=
ING
> >SATT14   st_setattr.testChange                                    : PASS
> >SEC1     st_secinfo.testValid                                     : RUNN=
ING
> >SEC1     st_secinfo.testValid                                     : PASS
> >SEC5     st_secinfo.testZeroLenName                               : RUNN=
ING
> >SEC5     st_secinfo.testZeroLenName                               : PASS
> >SEC3     st_secinfo.testVaporFile                                 : RUNN=
ING
> >SEC3     st_secinfo.testVaporFile                                 : PASS
> >SEC7     st_secinfo.testRPCSEC_GSS                                : RUNN=
ING
> >SEC7     st_secinfo.testRPCSEC_GSS                                : PASS
> >SEC2     st_secinfo.testNotDir                                    : RUNN=
ING
> >SEC2     st_secinfo.testNotDir                                    : PASS
> >SEC4     st_secinfo.testNoFh                                      : RUNN=
ING
> >SEC4     st_secinfo.testNoFh                                      : PASS
> >SVFH1    st_savefh.testNoFh                                       : RUNN=
ING
> >SVFH1    st_savefh.testNoFh                                       : PASS
> >SVFH2s   st_restorefh.testValidSocket                             : RUNN=
ING
> >SVFH2s   st_restorefh.testValidSocket                             : PASS
> >SVFH2a   st_restorefh.testValidLink                               : RUNN=
ING
> >SVFH2a   st_restorefh.testValidLink                               : PASS
> >SVFH2r   st_restorefh.testValidFile                               : RUNN=
ING
> >SVFH2r   st_restorefh.testValidFile                               : PASS
> >SVFH2f   st_restorefh.testValidFifo                               : RUNN=
ING
> >SVFH2f   st_restorefh.testValidFifo                               : PASS
> >SVFH2d   st_restorefh.testValidDir                                : RUNN=
ING
> >SVFH2d   st_restorefh.testValidDir                                : PASS
> >RSFH2    st_restorefh.testNoFh2                                   : RUNN=
ING
> >RSFH2    st_restorefh.testNoFh2                                   : PASS
> >RSFH1    st_restorefh.testNoFh1                                   : RUNN=
ING
> >RSFH1    st_restorefh.testNoFh1                                   : PASS
> >RENEW1   st_renew.testRenew                                       : RUNN=
ING
> >RENEW1   st_renew.testRenew                                       : PASS
> >RENEW3   st_renew.testExpired                                     : RUNN=
ING
> >Sleeping for 30 seconds:
> >Woke up
> >RENEW3   st_renew.testExpired                                     : FAIL=
URE
> >            nfs4lib.BadCompoundRes: Opening file b'RENEW3-1':
> >            operation OP_OPEN should return NFS4_OK, instead got
> >            NFS4ERR_DELAY
> >RENEW2   st_renew.testBadRenew                                    : RUNN=
ING
> >RENEW2   st_renew.testBadRenew                                    : PASS
> >RNM6     st_rename.testZeroLengthOldname                          : RUNN=
ING
> >RNM6     st_rename.testZeroLengthOldname                          : PASS
> >RNM7     st_rename.testZeroLengthNewname                          : RUNN=
ING
> >RNM7     st_rename.testZeroLengthNewname                          : PASS
> >RNM1s    st_rename.testValidSocket                                : RUNN=
ING
> >RNM1s    st_rename.testValidSocket                                : PASS
> >RNM1a    st_rename.testValidLink                                  : RUNN=
ING
> >RNM1a    st_rename.testValidLink                                  : PASS
> >RNM1r    st_rename.testValidFile                                  : RUNN=
ING
> >RNM1r    st_rename.testValidFile                                  : PASS
> >RNM1f    st_rename.testValidFifo                                  : RUNN=
ING
> >RNM1f    st_rename.testValidFifo                                  : PASS
> >RNM1d    st_rename.testValidDir                                   : RUNN=
ING
> >RNM1d    st_rename.testValidDir                                   : PASS
> >RNM2s    st_rename.testSfhSocket                                  : RUNN=
ING
> >RNM2s    st_rename.testSfhSocket                                  : PASS
> >RNM2a    st_rename.testSfhLink                                    : RUNN=
ING
> >RNM2a    st_rename.testSfhLink                                    : PASS
> >RNM2r    st_rename.testSfhFile                                    : RUNN=
ING
> >RNM2r    st_rename.testSfhFile                                    : PASS
> >RNM2f    st_rename.testSfhFifo                                    : RUNN=
ING
> >RNM2f    st_rename.testSfhFifo                                    : PASS
> >RNM19    st_rename.testSelfRenameFile                             : RUNN=
ING
> >RNM19    st_rename.testSelfRenameFile                             : PASS
> >RNM18    st_rename.testSelfRenameDir                              : RUNN=
ING
> >RNM18    st_rename.testSelfRenameDir                              : PASS
> >RNM5     st_rename.testNonExistent                                : RUNN=
ING
> >RNM5     st_rename.testNonExistent                                : PASS
> >RNM4     st_rename.testNoSfh                                      : RUNN=
ING
> >RNM4     st_rename.testNoSfh                                      : PASS
> >LINKS    st_link.testSupported                                    : RUNN=
ING
> >LINKS    st_link.testSupported                                    : PASS
> >RNM20    st_rename.testLinkRename                                 : RUNN=
ING
> >RNM20    st_rename.testLinkRename                                 : PASS
> >RNM17    st_rename.testFileToFullDir                              : RUNN=
ING
> >RNM17    st_rename.testFileToFullDir                              : PASS
> >RNM15    st_rename.testFileToFile                                 : RUNN=
ING
> >RNM15    st_rename.testFileToFile                                 : PASS
> >RNM14    st_rename.testFileToDir                                  : RUNN=
ING
> >RNM14    st_rename.testFileToDir                                  : PASS
> >RNM10    st_rename.testDotsOldname                                : RUNN=
ING
> >RNM10    st_rename.testDotsOldname                                : PASS
> >RNM11    st_rename.testDotsNewname                                : RUNN=
ING
> >RNM11    st_rename.testDotsNewname                                : PASS
> >RNM12    st_rename.testDirToObj                                   : RUNN=
ING
> >RNM12    st_rename.testDirToObj                                   : PASS
> >RNM16    st_rename.testDirToFullDir                               : RUNN=
ING
> >RNM16    st_rename.testDirToFullDir                               : PASS
> >RNM13    st_rename.testDirToDir                                   : RUNN=
ING
> >RNM13    st_rename.testDirToDir                                   : PASS
> >RNM3s    st_rename.testCfhSocket                                  : RUNN=
ING
> >RNM3s    st_rename.testCfhSocket                                  : PASS
> >RNM3a    st_rename.testCfhLink                                    : RUNN=
ING
> >RNM3a    st_rename.testCfhLink                                    : PASS
> >RNM3r    st_rename.testCfhFile                                    : RUNN=
ING
> >RNM3r    st_rename.testCfhFile                                    : PASS
> >RNM3f    st_rename.testCfhFifo                                    : RUNN=
ING
> >RNM3f    st_rename.testCfhFifo                                    : PASS
> >RM4      st_remove.testZeroLengthTarget                           : RUNN=
ING
> >RM4      st_remove.testZeroLengthTarget                           : PASS
> >RM1s     st_remove.testSocket                                     : RUNN=
ING
> >RM1s     st_remove.testSocket                                     : PASS
> >RM8      st_remove.testNotEmpty                                   : RUNN=
ING
> >RM8      st_remove.testNotEmpty                                   : PASS
> >RM6      st_remove.testNonExistent                                : RUNN=
ING
> >RM6      st_remove.testNonExistent                                : PASS
> >RM3      st_remove.testNoFh                                       : RUNN=
ING
> >RM3      st_remove.testNoFh                                       : PASS
> >RM1a     st_remove.testLink                                       : RUNN=
ING
> >RM1a     st_remove.testLink                                       : PASS
> >RM1r     st_remove.testFile                                       : RUNN=
ING
> >RM1r     st_remove.testFile                                       : PASS
> >RM1f     st_remove.testFifo                                       : RUNN=
ING
> >RM1f     st_remove.testFifo                                       : PASS
> >RM7      st_remove.testDots                                       : RUNN=
ING
> >RM7      st_remove.testDots                                       : PASS
> >RM1d     st_remove.testDir                                        : RUNN=
ING
> >RM1d     st_remove.testDir                                        : PASS
> >RM2s     st_remove.testCfhSocket                                  : RUNN=
ING
> >RM2s     st_remove.testCfhSocket                                  : PASS
> >RM2a     st_remove.testCfhLink                                    : RUNN=
ING
> >RM2a     st_remove.testCfhLink                                    : PASS
> >RM2r     st_remove.testCfhFile                                    : RUNN=
ING
> >RM2r     st_remove.testCfhFile                                    : PASS
> >RM2f     st_remove.testCfhFifo                                    : RUNN=
ING
> >RM2f     st_remove.testCfhFifo                                    : PASS
> >RLOWN1   st_releaselockowner.testFile                             : RUNN=
ING
> >RLOWN1   st_releaselockowner.testFile                             : PASS
> >RDLK2s   st_readlink.testSocket                                   : RUNN=
ING
> >RDLK2s   st_readlink.testSocket                                   : PASS
> >RDLK1    st_readlink.testReadlink                                 : RUNN=
ING
> >RDLK1    st_readlink.testReadlink                                 : PASS
> >RDLK3    st_readlink.testNoFh                                     : RUNN=
ING
> >RDLK3    st_readlink.testNoFh                                     : PASS
> >RDLK2r   st_readlink.testFile                                     : RUNN=
ING
> >RDLK2r   st_readlink.testFile                                     : PASS
> >RDLK2f   st_readlink.testFifo                                     : RUNN=
ING
> >RDLK2f   st_readlink.testFifo                                     : PASS
> >RDLK2d   st_readlink.testDir                                      : RUNN=
ING
> >RDLK2d   st_readlink.testDir                                      : PASS
> >RDDR9    st_readdir.testWriteOnlyAttributes                       : RUNN=
ING
> >RDDR9    st_readdir.testWriteOnlyAttributes                       : PASS
> >RDDR12   st_readdir.testUnaccessibleDirAttrs                      : RUNN=
ING
> >RDDR12   st_readdir.testUnaccessibleDirAttrs                      : PASS
> >RDDR11   st_readdir.testUnaccessibleDir                           : RUNN=
ING
> >RDDR11   st_readdir.testUnaccessibleDir                           : PASS
> >RDDR4    st_readdir.testSubsequent                                : RUNN=
ING
> >RDDR4    st_readdir.testSubsequent                                : PASS
> >RDDR10   st_readdir.testReservedCookies                           : RUNN=
ING
> >RDDR10   st_readdir.testReservedCookies                           : PASS
> >RDDR6    st_readdir.testNoFh                                      : RUNN=
ING
> >RDDR6    st_readdir.testNoFh                                      : PASS
> >RDDR7    st_readdir.testMaxcountZero                              : RUNN=
ING
> >RDDR7    st_readdir.testMaxcountZero                              : PASS
> >RDDR8    st_readdir.testMaxcountSmall                             : RUNN=
ING
> >RDDR8    st_readdir.testMaxcountSmall                             : PASS
> >RDDR2    st_readdir.testFirst                                     : RUNN=
ING
> >RDDR2    st_readdir.testFirst                                     : PASS
> >RDDR5s   st_readdir.testFhSocket                                  : RUNN=
ING
> >RDDR5s   st_readdir.testFhSocket                                  : PASS
> >RDDR5a   st_readdir.testFhLink                                    : RUNN=
ING
> >RDDR5a   st_readdir.testFhLink                                    : PASS
> >RDDR5r   st_readdir.testFhFile                                    : RUNN=
ING
> >RDDR5r   st_readdir.testFhFile                                    : PASS
> >RDDR5f   st_readdir.testFhFifo                                    : RUNN=
ING
> >RDDR5f   st_readdir.testFhFifo                                    : PASS
> >RDDR1    st_readdir.testEmptyDir                                  : RUNN=
ING
> >RDDR1    st_readdir.testEmptyDir                                  : PASS
> >RDDR8b   st_readdir.testDircountVarious                           : RUNN=
ING
> >RDDR8b   st_readdir.testDircountVarious                           : PASS
> >RDDR3    st_readdir.testAttr                                      : RUNN=
ING
> >RDDR3    st_readdir.testAttr                                      : PASS
> >RD6      st_read.testZeroCount                                    : RUNN=
ING
> >RD6      st_read.testZeroCount                                    : PASS
> >RD3      st_read.testWithOpen                                     : RUNN=
ING
> >RD3      st_read.testWithOpen                                     : PASS
> >RD2      st_read.testStateidOnes                                  : RUNN=
ING
> >RD2      st_read.testStateidOnes                                  : PASS
> >RD10     st_read.testStaleStateid                                 : RUNN=
ING
> >RD10     st_read.testStaleStateid                                 : PASS
> >RD7s     st_read.testSocket                                       : RUNN=
ING
> >RD7s     st_read.testSocket                                       : PASS
> >RD1      st_read.testSimpleRead                                   : RUNN=
ING
> >RD1      st_read.testSimpleRead                                   : PASS
> >RD11     st_read.testOldStateid                                   : RUNN=
ING
> >RD11     st_read.testOldStateid                                   : PASS
> >RD8      st_read.testNoFh                                         : RUNN=
ING
> >RD8      st_read.testNoFh                                         : PASS
> >RD7a     st_read.testLink                                         : RUNN=
ING
> >RD7a     st_read.testLink                                         : PASS
> >RD5      st_read.testLargeOffset                                  : RUNN=
ING
> >RD5      st_read.testLargeOffset                                  : PASS
> >RD7f     st_read.testFifo                                         : RUNN=
ING
> >RD7f     st_read.testFifo                                         : PASS
> >RD7d     st_read.testDir                                          : RUNN=
ING
> >RD7d     st_read.testDir                                          : PASS
> >ROOT1    st_putrootfh.testSupported                               : RUNN=
ING
> >ROOT1    st_putrootfh.testSupported                               : PASS
> >PUB1     st_putpubfh.testSupported                                : RUNN=
ING
> >PUB1     st_putpubfh.testSupported                                : PASS
> >PUB2     st_putpubfh.testSameAsRoot                               : RUNN=
ING
> >PUB2     st_putpubfh.testSameAsRoot                               : PASS
> >PUTFH1s  st_putfh.testSocket                                      : RUNN=
ING
> >PUTFH1s  st_putfh.testSocket                                      : PASS
> >PUTFH1a  st_putfh.testLink                                        : RUNN=
ING
> >PUTFH1a  st_putfh.testLink                                        : PASS
> >PUTFH1r  st_putfh.testFile                                        : RUNN=
ING
> >PUTFH1r  st_putfh.testFile                                        : PASS
> >PUTFH1f  st_putfh.testFifo                                        : RUNN=
ING
> >PUTFH1f  st_putfh.testFifo                                        : PASS
> >PUTFH1d  st_putfh.testDir                                         : RUNN=
ING
> >PUTFH1d  st_putfh.testDir                                         : PASS
> >PUTFH2   st_putfh.testBadHandle                                   : RUNN=
ING
> >PUTFH2   st_putfh.testBadHandle                                   : PASS
> >OPDG6    st_opendowngrade.testStaleStateid                        : RUNN=
ING
> >OPDG6    st_opendowngrade.testStaleStateid                        : PASS
> >OPDG1    st_opendowngrade.testRegularOpen                         : RUNN=
ING
> >OPDG1    st_opendowngrade.testRegularOpen                         : PASS
> >OPDG10   st_opendowngrade.testOpenDowngradeSequence               : RUNN=
ING
> >OPDG10   st_opendowngrade.testOpenDowngradeSequence               : PASS
> >OPDG11   st_opendowngrade.testOpenDowngradeLock                   : RUNN=
ING
> >OPDG11   st_opendowngrade.testOpenDowngradeLock                   : PASS
> >OPDG7    st_opendowngrade.testOldStateid                          : RUNN=
ING
> >OPDG7    st_opendowngrade.testOldStateid                          : PASS
> >OPDG8    st_opendowngrade.testNoFh                                : RUNN=
ING
> >OPDG8    st_opendowngrade.testNoFh                                : PASS
> >OPDG3    st_opendowngrade.testNewState2                           : RUNN=
ING
> >OPDG3    st_opendowngrade.testNewState2                           : PASS
> >OPDG2    st_opendowngrade.testNewState1                           : RUNN=
ING
> >OPDG2    st_opendowngrade.testNewState1                           : PASS
> >OPDG5    st_opendowngrade.testBadStateid                          : RUNN=
ING
> >OPDG5    st_opendowngrade.testBadStateid                          : PASS
> >OPDG4    st_opendowngrade.testBadSeqid                            : RUNN=
ING
> >OPDG4    st_opendowngrade.testBadSeqid                            : PASS
> >OPCF6    st_openconfirm.testStaleStateid                          : RUNN=
ING
> >OPCF6    st_openconfirm.testStaleStateid                          : PASS
> >OPCF2    st_openconfirm.testNoFh                                  : RUNN=
ING
> >OPCF2    st_openconfirm.testNoFh                                  : PASS
> >OPCF1    st_openconfirm.testConfirmCreate                         : RUNN=
ING
> >OPCF1    st_openconfirm.testConfirmCreate                         : PASS
> >OPCF5    st_openconfirm.testBadStateid                            : RUNN=
ING
> >OPCF5    st_openconfirm.testBadStateid                            : PASS
> >OPCF4    st_openconfirm.testBadSeqid                              : RUNN=
ING
> >OPCF4    st_openconfirm.testBadSeqid                              : PASS
> >OPEN10   st_open.testZeroLenName                                  : RUNN=
ING
> >OPEN10   st_open.testZeroLenName                                  : PASS
> >OPEN29   st_open.testUpgrades                                     : RUNN=
ING
> >OPEN29   st_open.testUpgrades                                     : PASS
> >OPEN15   st_open.testUnsupportedAttributes                        : RUNN=
ING
> >OPEN15   st_open.testUnsupportedAttributes                        : PASS
> >OPEN7s   st_open.testSocket                                       : RUNN=
ING
> >OPEN7s   st_open.testSocket                                       : PASS
> >OPEN18   st_open.testShareConflict1                               : RUNN=
ING
> >OPEN18   st_open.testShareConflict1                               : PASS
> >OPEN30   st_open.testReplay                                       : RUNN=
ING
> >OPEN30   st_open.testReplay                                       : PASS
> >OPEN6    st_open.testOpenVaporFile                                : RUNN=
ING
> >OPEN6    st_open.testOpenVaporFile                                : PASS
> >OPEN5    st_open.testOpenFile                                     : RUNN=
ING
> >OPEN5    st_open.testOpenFile                                     : PASS
> >OPEN12   st_open.testNotDir                                       : RUNN=
ING
> >OPEN12   st_open.testNotDir                                       : PASS
> >OPEN8    st_open.testNoFh                                         : RUNN=
ING
> >OPEN8    st_open.testNoFh                                         : PASS
> >OPEN17   st_open.testModeChange                                   : RUNN=
ING
> >OPEN17   st_open.testModeChange                                   : PASS
> >OPEN11   st_open.testLongName                                     : RUNN=
ING
> >OPEN11   st_open.testLongName                                     : PASS
> >OPEN7a   st_open.testLink                                         : RUNN=
ING
> >OPEN7a   st_open.testLink                                         : PASS
> >OPEN14   st_open.testInvalidAttrmask                              : RUNN=
ING
> >OPEN14   st_open.testInvalidAttrmask                              : PASS
> >OPEN7f   st_open.testFifo                                         : RUNN=
ING
> >OPEN7f   st_open.testFifo                                         : PASS
> >OPEN20   st_open.testFailedOpen                                   : RUNN=
ING
> >OPEN20   st_open.testFailedOpen                                   : PASS
> >OPEN7d   st_open.testDir                                          : RUNN=
ING
> >OPEN7d   st_open.testDir                                          : PASS
> >OPEN28   st_open.testDenyWrite4                                   : RUNN=
ING
> >OPEN28   st_open.testDenyWrite4                                   : PASS
> >OPEN27   st_open.testDenyWrite3                                   : RUNN=
ING
> >OPEN27   st_open.testDenyWrite3                                   : PASS
> >OPEN26   st_open.testDenyWrite2                                   : RUNN=
ING
> >OPEN26   st_open.testDenyWrite2                                   : PASS
> >OPEN25   st_open.testDenyWrite1                                   : RUNN=
ING
> >OPEN25   st_open.testDenyWrite1                                   : PASS
> >OPEN24   st_open.testDenyRead4                                    : RUNN=
ING
> >OPEN24   st_open.testDenyRead4                                    : PASS
> >OPEN23b  st_open.testDenyRead3a                                   : RUNN=
ING
> >OPEN23b  st_open.testDenyRead3a                                   : PASS
> >OPEN23   st_open.testDenyRead3                                    : RUNN=
ING
> >OPEN23   st_open.testDenyRead3                                    : PASS
> >OPEN22   st_open.testDenyRead2                                    : RUNN=
ING
> >OPEN22   st_open.testDenyRead2                                    : PASS
> >OPEN21   st_open.testDenyRead1                                    : RUNN=
ING
> >OPEN21   st_open.testDenyRead1                                    : PASS
> >OPEN2    st_open.testCreateUncheckedFile                          : RUNN=
ING
> >OPEN2    st_open.testCreateUncheckedFile                          : PASS
> >OPEN3    st_open.testCreatGuardedFile                             : RUNN=
ING
> >OPEN3    st_open.testCreatGuardedFile                             : PASS
> >OPEN4    st_open.testCreatExclusiveFile                           : RUNN=
ING
> >OPEN4    st_open.testCreatExclusiveFile                           : PASS
> >OPEN16   st_open.testClaimPrev                                    : RUNN=
ING
> >OPEN16   st_open.testClaimPrev                                    : PASS
> >OPEN31   st_open.testBadSeqid                                     : RUNN=
ING
> >OPEN31   st_open.testBadSeqid                                     : PASS
> >NVF5s    st_nverify.testWriteOnlySocket                           : RUNN=
ING
> >NVF5s    st_nverify.testWriteOnlySocket                           : PASS
> >NVF5a    st_nverify.testWriteOnlyLink                             : RUNN=
ING
> >NVF5a    st_nverify.testWriteOnlyLink                             : PASS
> >NVF5r    st_nverify.testWriteOnlyFile                             : RUNN=
ING
> >NVF5r    st_nverify.testWriteOnlyFile                             : PASS
> >NVF5f    st_nverify.testWriteOnlyFifo                             : RUNN=
ING
> >NVF5f    st_nverify.testWriteOnlyFifo                             : PASS
> >Traceback (most recent call last):
> >   File "/root/pynfs/nfs4.0/lib/testmod.py", line 234, in run
> >     self.runtest(self, environment)
> >   File "/root/pynfs/nfs4.0/servertests/st_locku.py", line 266, in testT=
imedoutUnlock
> >     c2.open_confirm(t.word(), access=3DOPEN4_SHARE_ACCESS_WRITE)
> >   File "/root/pynfs/nfs4.0/nfs4lib.py", line 727, in open_confirm
> >     check_result(res, "Opening file %s" % _getname(owner, path))
> >   File "/root/pynfs/nfs4.0/nfs4lib.py", line 895, in check_result
> >     raise BadCompoundRes(resop, res.status, msg)
> >nfs4lib.BadCompoundRes: Opening file b'LKU10-1': operation OP_OPEN shoul=
d return NFS4_OK, instead got NFS4ERR_DELAY
> >NVF5d    st_nverify.testWriteOnlyDir                              : RUNN=
ING
> >NVF5d    st_nverify.testWriteOnlyDir                              : PASS
> >NVF7s    st_nverify.testUnsupportedSocket                         : RUNN=
ING
> >NVF7s    st_nverify.testUnsupportedSocket                         : PASS
> >NVF7a    st_nverify.testUnsupportedLink                           : RUNN=
ING
> >NVF7a    st_nverify.testUnsupportedLink                           : PASS
> >NVF7r    st_nverify.testUnsupportedFile                           : RUNN=
ING
> >NVF7r    st_nverify.testUnsupportedFile                           : PASS
> >NVF7f    st_nverify.testUnsupportedFifo                           : RUNN=
ING
> >NVF7f    st_nverify.testUnsupportedFifo                           : PASS
> >NVF7d    st_nverify.testUnsupportedDir                            : RUNN=
ING
> >NVF7d    st_nverify.testUnsupportedDir                            : PASS
> >NVF2s    st_nverify.testTypeSocket                                : RUNN=
ING
> >NVF2s    st_nverify.testTypeSocket                                : PASS
> >NVF2a    st_nverify.testTypeLink                                  : RUNN=
ING
> >NVF2a    st_nverify.testTypeLink                                  : PASS
> >NVF2r    st_nverify.testTypeFile                                  : RUNN=
ING
> >NVF2r    st_nverify.testTypeFile                                  : PASS
> >NVF2f    st_nverify.testTypeFifo                                  : RUNN=
ING
> >NVF2f    st_nverify.testTypeFifo                                  : PASS
> >NVF2d    st_nverify.testTypeDir                                   : RUNN=
ING
> >NVF2d    st_nverify.testTypeDir                                   : PASS
> >NVF4     st_nverify.testNoFh                                      : RUNN=
ING
> >NVF4     st_nverify.testNoFh                                      : PASS
> >NVF1s    st_nverify.testMandSocket                                : RUNN=
ING
> >NVF1s    st_nverify.testMandSocket                                : PASS
> >NVF1a    st_nverify.testMandLink                                  : RUNN=
ING
> >NVF1a    st_nverify.testMandLink                                  : PASS
> >NVF1r    st_nverify.testMandFile                                  : RUNN=
ING
> >NVF1r    st_nverify.testMandFile                                  : PASS
> >NVF1f    st_nverify.testMandFifo                                  : RUNN=
ING
> >NVF1f    st_nverify.testMandFifo                                  : PASS
> >NVF1d    st_nverify.testMandDir                                   : RUNN=
ING
> >NVF1d    st_nverify.testMandDir                                   : PASS
> >NVF3s    st_nverify.testBadSizeSocket                             : RUNN=
ING
> >NVF3s    st_nverify.testBadSizeSocket                             : PASS
> >NVF3a    st_nverify.testBadSizeLink                               : RUNN=
ING
> >NVF3a    st_nverify.testBadSizeLink                               : PASS
> >NVF3r    st_nverify.testBadSizeFile                               : RUNN=
ING
> >NVF3r    st_nverify.testBadSizeFile                               : PASS
> >NVF3f    st_nverify.testBadSizeFifo                               : RUNN=
ING
> >NVF3f    st_nverify.testBadSizeFifo                               : PASS
> >NVF3d    st_nverify.testBadSizeDir                                : RUNN=
ING
> >NVF3d    st_nverify.testBadSizeDir                                : PASS
> >LOOKP2s  st_lookupp.testSock                                      : RUNN=
ING
> >LOOKP2s  st_lookupp.testSock                                      : PASS
> >LOOKP4   st_lookupp.testNoFh                                      : RUNN=
ING
> >LOOKP4   st_lookupp.testNoFh                                      : PASS
> >LOOKP2a  st_lookupp.testLink                                      : RUNN=
ING
> >LOOKP2a  st_lookupp.testLink                                      : PASS
> >LOOKP2r  st_lookupp.testFile                                      : RUNN=
ING
> >LOOKP2r  st_lookupp.testFile                                      : PASS
> >LOOKP2f  st_lookupp.testFifo                                      : RUNN=
ING
> >LOOKP2f  st_lookupp.testFifo                                      : PASS
> >LOOKP1   st_lookupp.testDir                                       : RUNN=
ING
> >LOOKP1   st_lookupp.testDir                                       : PASS
> >LOOKP3   st_lookupp.testAtRoot                                    : RUNN=
ING
> >LOOKP3   st_lookupp.testAtRoot                                    : PASS
> >LOOK3    st_lookup.testZeroLength                                 : RUNN=
ING
> >LOOK3    st_lookup.testZeroLength                                 : PASS
> >LOOK9    st_lookup.testUnaccessibleDir                            : RUNN=
ING
> >LOOK9    st_lookup.testUnaccessibleDir                            : PASS
> >LOOK5a   st_lookup.testSymlinkNotDir                              : RUNN=
ING
> >LOOK5a   st_lookup.testSymlinkNotDir                              : PASS
> >LOOK5s   st_lookup.testSocketNotDir                               : RUNN=
ING
> >LOOK5s   st_lookup.testSocketNotDir                               : PASS
> >LOOK2    st_lookup.testNonExistent                                : RUNN=
ING
> >LOOK2    st_lookup.testNonExistent                                : PASS
> >LOOK6    st_lookup.testNonAccessable                              : RUNN=
ING
> >LOOK6    st_lookup.testNonAccessable                              : PASS
> >LOOK1    st_lookup.testNoFh                                       : RUNN=
ING
> >LOOK1    st_lookup.testNoFh                                       : PASS
> >LOOK4    st_lookup.testLongName                                   : RUNN=
ING
> >LOOK4    st_lookup.testLongName                                   : PASS
> >LOOK5r   st_lookup.testFileNotDir                                 : RUNN=
ING
> >LOOK5r   st_lookup.testFileNotDir                                 : PASS
> >LOOK5f   st_lookup.testFifoNotDir                                 : RUNN=
ING
> >LOOK5f   st_lookup.testFifoNotDir                                 : PASS
> >LOOK8    st_lookup.testDots                                       : RUNN=
ING
> >LOOK8    st_lookup.testDots                                       : PASS
> >LOOK10   st_lookup.testBadOpaque                                  : RUNN=
ING
> >LOOK10   st_lookup.testBadOpaque                                  : PASS
> >LKU3     st_locku.testZeroLen                                     : RUNN=
ING
> >LKU3     st_locku.testZeroLen                                     : PASS
> >LKUNONE  st_locku.testUnlocked                                    : RUNN=
ING
> >LKUNONE  st_locku.testUnlocked                                    : PASS
> >LKU10    st_locku.testTimedoutUnlock                              : RUNN=
ING
> >Sleeping for 22 seconds:
> >Woke up
> >LKU10    st_locku.testTimedoutUnlock                              : FAIL=
URE
> >            nfs4lib.BadCompoundRes: Opening file b'LKU10-1':
> >            operation OP_OPEN should return NFS4_OK, instead got
> >            NFS4ERR_DELAY
> >LKU9     st_locku.testStaleLockStateid                            : RUNN=
ING
> >LKU9     st_locku.testStaleLockStateid                            : PASS
> >LKUSPLIT st_locku.testSplit                                       : RUNN=
ING
> >LKUSPLIT st_locku.testSplit                                       : PASS
> >LKUOVER  st_locku.testOverlap                                     : RUNN=
ING
> >LKUOVER  st_locku.testOverlap                                     : PASS
> >LKU7     st_locku.testOldLockStateid                              : RUNN=
ING
> >LKU7     st_locku.testOldLockStateid                              : PASS
> >LKU5     st_locku.testNoFh                                        : RUNN=
ING
> >LKU5     st_locku.testNoFh                                        : PASS
> >LKU4     st_locku.testLenTooLong                                  : RUNN=
ING
> >LKU4     st_locku.testLenTooLong                                  : PASS
> >LOCK1    st_lock.testFile                                         : RUNN=
ING
> >LOCK1    st_lock.testFile                                         : PASS
> >LKU1     st_locku.testFile                                        : RUNN=
ING
> >LKU1     st_locku.testFile                                        : PASS
> >LKU8     st_locku.testBadLockStateid                              : RUNN=
ING
> >LKU8     st_locku.testBadLockStateid                              : PASS
> >LKU6b    st_locku.testBadLockSeqid2                               : RUNN=
ING
> >LKU6b    st_locku.testBadLockSeqid2                               : PASS
> >LKU6     st_locku.testBadLockSeqid                                : RUNN=
ING
> >LKU6     st_locku.testBadLockSeqid                                : PASS
> >LOCKRNG  st_lock.test32bitRange                                   : RUNN=
ING
> >LOCKRNG  st_lock.test32bitRange                                   : PASS
> >LKU2     st_locku.test32bitRange                                  : RUNN=
ING
> >LKU2     st_locku.test32bitRange                                  : PASS
> >LKT6     st_lockt.testZeroLen                                     : RUNN=
ING
> >LKT6     st_lockt.testZeroLen                                     : PASS
> >LKT1     st_lockt.testUnlockedFile                                : RUNN=
ING
> >LKT1     st_lockt.testUnlockedFile                                : PASS
> >LKT9     st_lockt.testStaleClientid                               : RUNN=
ING
> >LKT9     st_lockt.testStaleClientid                               : PASS
> >LKT2s    st_lockt.testSocket                                      : RUNN=
ING
> >LKT2s    st_lockt.testSocket                                      : PASS
> >LKT4     st_lockt.testPartialLockedFile2                          : RUNN=
ING
> >LKT4     st_lockt.testPartialLockedFile2                          : PASS
> >LKT3     st_lockt.testPartialLockedFile1                          : RUNN=
ING
> >LKT3     st_lockt.testPartialLockedFile1                          : PASS
> >LKTOVER  st_lockt.testOverlap                                     : RUNN=
ING
> >LKTOVER  st_lockt.testOverlap                                     : PASS
> >LKT8     st_lockt.testNoFh                                        : RUNN=
ING
> >LKT8     st_lockt.testNoFh                                        : PASS
> >LKT2a    st_lockt.testLink                                        : RUNN=
ING
> >LKT2a    st_lockt.testLink                                        : PASS
> >LKT7     st_lockt.testLenTooLong                                  : RUNN=
ING
> >LKT7     st_lockt.testLenTooLong                                  : PASS
> >LKT2f    st_lockt.testFifo                                        : RUNN=
ING
> >LKT2f    st_lockt.testFifo                                        : PASS
> >LKT2d    st_lockt.testDir                                         : RUNN=
ING
> >LKT2d    st_lockt.testDir                                         : PASS
> >LKT5     st_lockt.test32bitRange                                  : RUNN=
ING
> >LKT5     st_lockt.test32bitRange                                  : PASS
> >LOCK5    st_lock.testZeroLen                                      : RUNN=
ING
> >LOCK5    st_lock.testZeroLen                                      : PASS
> >LOCKCHGU st_lock.testUpgrade                                      : RUNN=
ING
> >LOCKCHGU st_lock.testUpgrade                                      : PASS
> >LOCK13   st_lock.testTimedoutGrabLock                             : RUNN=
ING
> >Sleeping for 7 seconds:
> >Woke up
> >Sleeping for 7 seconds:
> >Woke up
> >Sleeping for 7 seconds:
> >Woke up
> >LOCK13   st_lock.testTimedoutGrabLock                             : PASS
> >LOCK12b  st_lock.testStaleOpenStateid                             : RUNN=
ING
> >LOCK12b  st_lock.testStaleOpenStateid                             : PASS
> >LOCK12a  st_lock.testStaleLockStateid                             : RUNN=
ING
> >LOCK12a  st_lock.testStaleLockStateid                             : PASS
> >LOCK10   st_lock.testStaleClientid                                : RUNN=
ING
> >LOCK10   st_lock.testStaleClientid                                : PASS
> >LOCK17   st_lock.testReadLocks2                                   : RUNN=
ING
> >LOCK17   st_lock.testReadLocks2                                   : PASS
> >LOCK16   st_lock.testReadLocks1                                   : RUNN=
ING
> >LOCK16   st_lock.testReadLocks1                                   : PASS
> >LOCKMRG  st_lock.testOverlap                                      : RUNN=
ING
> >LOCKMRG  st_lock.testOverlap                                      : PASS
> >LOCK23   st_lock.testOpenDowngradeLock                            : RUNN=
ING
> >LOCK23   st_lock.testOpenDowngradeLock                            : PASS
> >LOCK9c   st_lock.testOldOpenStateid2                              : RUNN=
ING
> >LOCK9c   st_lock.testOldOpenStateid2                              : PASS
> >LOCK9b   st_lock.testOldOpenStateid                               : RUNN=
ING
> >LOCK9b   st_lock.testOldOpenStateid                               : PASS
> >LOCK9a   st_lock.testOldLockStateid                               : RUNN=
ING
> >LOCK9a   st_lock.testOldLockStateid                               : PASS
> >LOCK7    st_lock.testNoFh                                         : RUNN=
ING
> >LOCK7    st_lock.testNoFh                                         : PASS
> >LOCK4    st_lock.testMode                                         : RUNN=
ING
> >LOCK4    st_lock.testMode                                         : PASS
> >LOCK6    st_lock.testLenTooLong                                   : RUNN=
ING
> >LOCK6    st_lock.testLenTooLong                                   : PASS
> >LOCK15   st_lock.testGrabLock2                                    : RUNN=
ING
> >LOCK15   st_lock.testGrabLock2                                    : PASS
> >LOCK14   st_lock.testGrabLock1                                    : RUNN=
ING
> >LOCK14   st_lock.testGrabLock1                                    : PASS
> >LOCK3    st_lock.testExistingFile                                 : RUNN=
ING
> >LOCK3    st_lock.testExistingFile                                 : PASS
> >LOCKCHGD st_lock.testDowngrade                                    : RUNN=
ING
> >LOCKCHGD st_lock.testDowngrade                                    : PASS
> >LOCKHELD st_lock.testClose                                        : RUNN=
ING
> >LOCKHELD st_lock.testClose                                        : PASS
> >LOCK20   st_lock.testBlockTimeout                                 : RUNN=
ING
> >Sleeping for 7 seconds: Waiting for queued blocking lock to timeout
> >Woke up
> >Sleeping for 7 seconds: Waiting for queued blocking lock to timeout
> >Woke up
> >Sleeping for 7 seconds: Waiting for queued blocking lock to timeout
> >Woke up
> >LOCK20   st_lock.testBlockTimeout                                 : PASS
> >LOCK11   st_lock.testBadStateid                                   : RUNN=
ING
> >LOCK11   st_lock.testBadStateid                                   : PASS
> >LOCK8b   st_lock.testBadOpenSeqid                                 : RUNN=
ING
> >LOCK8b   st_lock.testBadOpenSeqid                                 : PASS
> >LOCK8a   st_lock.testBadLockSeqid                                 : RUNN=
ING
> >LOCK8a   st_lock.testBadLockSeqid                                 : PASS
> >LINK6    st_link.testZeroLenName                                  : RUNN=
ING
> >LINK6    st_link.testZeroLenName                                  : PASS
> >LINK1s   st_link.testSocket                                       : RUNN=
ING
> >LINK1s   st_link.testSocket                                       : PASS
> >LINK2    st_link.testNoSfh                                        : RUNN=
ING
> >LINK2    st_link.testNoSfh                                        : PASS
> >LINK3    st_link.testNoCfh                                        : RUNN=
ING
> >LINK3    st_link.testNoCfh                                        : PASS
> >LINK7    st_link.testLongName                                     : RUNN=
ING
> >LINK7    st_link.testLongName                                     : PASS
> >LINK1a   st_link.testLink                                         : RUNN=
ING
> >LINK1a   st_link.testLink                                         : PASS
> >LINK1r   st_link.testFile                                         : RUNN=
ING
> >LINK1r   st_link.testFile                                         : PASS
> >LINK1f   st_link.testFifo                                         : RUNN=
ING
> >LINK1f   st_link.testFifo                                         : PASS
> >LINK5    st_link.testExists                                       : RUNN=
ING
> >LINK5    st_link.testExists                                       : PASS
> >LINK9    st_link.testDots                                         : RUNN=
ING
> >LINK9    st_link.testDots                                         : PASS
> >LINK1d   st_link.testDir                                          : RUNN=
ING
> >LINK1d   st_link.testDir                                          : PASS
> >LINK4s   st_link.testCfhSocket                                    : RUNN=
ING
> >LINK4s   st_link.testCfhSocket                                    : PASS
> >LINK4a   st_link.testCfhLink                                      : RUNN=
ING
> >LINK4a   st_link.testCfhLink                                      : PASS
> >LINK4r   st_link.testCfhFile                                      : RUNN=
ING
> >LINK4r   st_link.testCfhFile                                      : PASS
> >LINK4f   st_link.testCfhFifo                                      : RUNN=
ING
> >LINK4f   st_link.testCfhFifo                                      : PASS
> >GF1s     st_getfh.testSocket                                      : RUNN=
ING
> >GF1s     st_getfh.testSocket                                      : PASS
> >GF9      st_getfh.testNoFh                                        : RUNN=
ING
> >GF9      st_getfh.testNoFh                                        : PASS
> >GF1a     st_getfh.testLink                                        : RUNN=
ING
> >GF1a     st_getfh.testLink                                        : PASS
> >GF1r     st_getfh.testFile                                        : RUNN=
ING
> >GF1r     st_getfh.testFile                                        : PASS
> >GF1f     st_getfh.testFifo                                        : RUNN=
ING
> >GF1f     st_getfh.testFifo                                        : PASS
> >GF1d     st_getfh.testDir                                         : RUNN=
ING
> >GF1d     st_getfh.testDir                                         : PASS
> >GATT3s   st_getattr.testWriteOnlySocket                           : RUNN=
ING
> >GATT3s   st_getattr.testWriteOnlySocket                           : PASS
> >GATT3a   st_getattr.testWriteOnlyLink                             : RUNN=
ING
> >GATT3a   st_getattr.testWriteOnlyLink                             : PASS
> >GATT3r   st_getattr.testWriteOnlyFile                             : RUNN=
ING
> >GATT3r   st_getattr.testWriteOnlyFile                             : PASS
> >GATT3f   st_getattr.testWriteOnlyFifo                             : RUNN=
ING
> >GATT3f   st_getattr.testWriteOnlyFifo                             : PASS
> >GATT3d   st_getattr.testWriteOnlyDir                              : RUNN=
ING
> >GATT3d   st_getattr.testWriteOnlyDir                              : PASS
> >GATT4s   st_getattr.testUnknownAttrSocket                         : RUNN=
ING
> >GATT4s   st_getattr.testUnknownAttrSocket                         : PASS
> >GATT4a   st_getattr.testUnknownAttrLink                           : RUNN=
ING
> >GATT4a   st_getattr.testUnknownAttrLink                           : PASS
> >GATT4r   st_getattr.testUnknownAttrFile                           : RUNN=
ING
> >GATT4r   st_getattr.testUnknownAttrFile                           : PASS
> >GATT4f   st_getattr.testUnknownAttrFifo                           : RUNN=
ING
> >GATT4f   st_getattr.testUnknownAttrFifo                           : PASS
> >GATT4d   st_getattr.testUnknownAttrDir                            : RUNN=
ING
> >GATT4d   st_getattr.testUnknownAttrDir                            : PASS
> >GATT6s   st_getattr.testSupportedSocket                           : RUNN=
ING
> >GATT6s   st_getattr.testSupportedSocket                           : PASS
> >GATT6a   st_getattr.testSupportedLink                             : RUNN=
ING
> >GATT6a   st_getattr.testSupportedLink                             : PASS
> >GATT6r   st_getattr.testSupportedFile                             : RUNN=
ING
> >GATT6r   st_getattr.testSupportedFile                             : PASS
> >GATT6f   st_getattr.testSupportedFifo                             : RUNN=
ING
> >GATT6f   st_getattr.testSupportedFifo                             : PASS
> >GATT6d   st_getattr.testSupportedDir                              : RUNN=
ING
> >GATT6d   st_getattr.testSupportedDir                              : PASS
> >GATT10   st_getattr.testOwnerName                                 : RUNN=
ING
> >GATT10   st_getattr.testOwnerName                                 : PASS
> >GATT2    st_getattr.testNoFh                                      : RUNN=
ING
> >GATT2    st_getattr.testNoFh                                      : PASS
> >GATT1s   st_getattr.testMandSocket                                : RUNN=
ING
> >GATT1s   st_getattr.testMandSocket                                : PASS
> >GATT1a   st_getattr.testMandLink                                  : RUNN=
ING
> >GATT1a   st_getattr.testMandLink                                  : PASS
> >GATT1r   st_getattr.testMandFile                                  : RUNN=
ING
> >GATT1r   st_getattr.testMandFile                                  : PASS
> >GATT1f   st_getattr.testMandFifo                                  : RUNN=
ING
> >GATT1f   st_getattr.testMandFifo                                  : PASS
> >GATT1d   st_getattr.testMandDir                                   : RUNN=
ING
> >GATT1d   st_getattr.testMandDir                                   : PASS
> >GATT9    st_getattr.testLotsofGetattrsFile                        : RUNN=
ING
> >GATT9    st_getattr.testLotsofGetattrsFile                        : PASS
> >GATT7s   st_getattr.testLongSocket                                : RUNN=
ING
> >GATT7s   st_getattr.testLongSocket                                : PASS
> >GATT7a   st_getattr.testLongLink                                  : RUNN=
ING
> >GATT7a   st_getattr.testLongLink                                  : PASS
> >GATT7r   st_getattr.testLongFile                                  : RUNN=
ING
> >GATT7r   st_getattr.testLongFile                                  : PASS
> >GATT7f   st_getattr.testLongFifo                                  : RUNN=
ING
> >GATT7f   st_getattr.testLongFifo                                  : PASS
> >GATT7d   st_getattr.testLongDir                                   : RUNN=
ING
> >GATT7d   st_getattr.testLongDir                                   : PASS
> >GATT8    st_getattr.testFSLocations                               : RUNN=
ING
> >GATT8    st_getattr.testFSLocations                               : PASS
> >GATT5s   st_getattr.testEmptySocket                               : RUNN=
ING
> >GATT5s   st_getattr.testEmptySocket                               : PASS
> >GATT5a   st_getattr.testEmptyLink                                 : RUNN=
ING
> >GATT5a   st_getattr.testEmptyLink                                 : PASS
> >GATT5r   st_getattr.testEmptyFile                                 : RUNN=
ING
> >GATT5r   st_getattr.testEmptyFile                                 : PASS
> >GATT5f   st_getattr.testEmptyFifo                                 : RUNN=
ING
> >GATT5f   st_getattr.testEmptyFifo                                 : PASS
> >GATT5d   st_getattr.testEmptyDir                                  : RUNN=
ING
> >GATT5d   st_getattr.testEmptyDir                                  : PASS
> >CR9a     st_create.testZeroLengthForLNK                           : RUNN=
ING
> >CR9a     st_create.testZeroLengthForLNK                           : PASS
> >CR9      st_create.testZeroLength                                 : RUNN=
ING
> >CR9      st_create.testZeroLength                                 : PASS
> >CR12     st_create.testUnsupportedAttributes                      : RUNN=
ING
> >CR12     st_create.testUnsupportedAttributes                      : PASS
> >CR14     st_create.testSlash                                      : RUNN=
ING
> >CR14     st_create.testSlash                                      : PASS
> >CR10     st_create.testRegularFile                                : RUNN=
ING
> >CR10     st_create.testRegularFile                                : PASS
> >CR8      st_create.testNoFh                                       : RUNN=
ING
> >CR8      st_create.testNoFh                                       : PASS
> >CR15     st_create.testLongName                                   : RUNN=
ING
> >CR15     st_create.testLongName                                   : PASS
> >CR11     st_create.testInvalidAttrmask                            : RUNN=
ING
> >CR11     st_create.testInvalidAttrmask                            : PASS
> >CR13     st_create.testDots                                       : RUNN=
ING
> >CR13     st_create.testDots                                       : PASS
> >CR5      st_create.testDirOffSocket                               : RUNN=
ING
> >CR5      st_create.testDirOffSocket                               : PASS
> >CR2      st_create.testDirOffLink                                 : RUNN=
ING
> >Traceback (most recent call last):
> >   File "/root/pynfs/nfs4.0/lib/testmod.py", line 234, in run
> >     self.runtest(self, environment)
> >   File "/root/pynfs/nfs4.0/servertests/st_close.py", line 142, in testT=
imedoutClose2
> >     c2.open_confirm(t.word(), access=3DOPEN4_SHARE_ACCESS_WRITE)
> >   File "/root/pynfs/nfs4.0/nfs4lib.py", line 727, in open_confirm
> >     check_result(res, "Opening file %s" % _getname(owner, path))
> >   File "/root/pynfs/nfs4.0/nfs4lib.py", line 895, in check_result
> >     raise BadCompoundRes(resop, res.status, msg)
> >nfs4lib.BadCompoundRes: Opening file b'CLOSE9-1': operation OP_OPEN shou=
ld return NFS4_OK, instead got NFS4ERR_DELAY
> >Traceback (most recent call last):
> >   File "/root/pynfs/nfs4.0/lib/testmod.py", line 234, in run
> >     self.runtest(self, environment)
> >   File "/root/pynfs/nfs4.0/servertests/st_close.py", line 118, in testT=
imedoutClose1
> >     c2.open_confirm(t.word(), access=3DOPEN4_SHARE_ACCESS_WRITE)
> >   File "/root/pynfs/nfs4.0/nfs4lib.py", line 727, in open_confirm
> >     check_result(res, "Opening file %s" % _getname(owner, path))
> >   File "/root/pynfs/nfs4.0/nfs4lib.py", line 895, in check_result
> >     raise BadCompoundRes(resop, res.status, msg)
> >nfs4lib.BadCompoundRes: Opening file b'CLOSE8-1': operation OP_OPEN shou=
ld return NFS4_OK, instead got NFS4ERR_DELAY
> >CR2      st_create.testDirOffLink                                 : PASS
> >CR7      st_create.testDirOffFile                                 : RUNN=
ING
> >CR7      st_create.testDirOffFile                                 : PASS
> >CR6      st_create.testDirOffFIFO                                 : RUNN=
ING
> >CR6      st_create.testDirOffFIFO                                 : PASS
> >COMP1    st_compound.testZeroOps                                  : RUNN=
ING
> >COMP1    st_compound.testZeroOps                                  : PASS
> >COMP5    st_compound.testUndefined                                : RUNN=
ING
> >COMP5    st_compound.testUndefined                                : PASS
> >COMP6    st_compound.testLongCompound                             : RUNN=
ING
> >COMP6    st_compound.testLongCompound                             : PASS
> >COMP4    st_compound.testInvalidMinor                             : RUNN=
ING
> >COMP4    st_compound.testInvalidMinor                             : PASS
> >COMP2    st_compound.testGoodTag                                  : RUNN=
ING
> >COMP2    st_compound.testGoodTag                                  : PASS
> >CMT2s    st_commit.testSocket                                     : RUNN=
ING
> >CMT2s    st_commit.testSocket                                     : PASS
> >CMT3     st_commit.testNoFh                                       : RUNN=
ING
> >CMT3     st_commit.testNoFh                                       : PASS
> >CMT2a    st_commit.testLink                                       : RUNN=
ING
> >CMT2a    st_commit.testLink                                       : PASS
> >CMT2f    st_commit.testFifo                                       : RUNN=
ING
> >CMT2f    st_commit.testFifo                                       : PASS
> >CMT2d    st_commit.testDir                                        : RUNN=
ING
> >CMT2d    st_commit.testDir                                        : PASS
> >CMT4     st_commit.testCommitOverflow                             : RUNN=
ING
> >CMT4     st_commit.testCommitOverflow                             : PASS
> >CMT1d    st_commit.testCommitOffsetMax2                           : RUNN=
ING
> >CMT1d    st_commit.testCommitOffsetMax2                           : PASS
> >CMT1c    st_commit.testCommitOffsetMax1                           : RUNN=
ING
> >CMT1c    st_commit.testCommitOffsetMax1                           : PASS
> >CMT1b    st_commit.testCommitOffset1                              : RUNN=
ING
> >CMT1b    st_commit.testCommitOffset1                              : PASS
> >CMT1aa   st_commit.testCommitOffset0                              : RUNN=
ING
> >CMT1aa   st_commit.testCommitOffset0                              : PASS
> >CMT1f    st_commit.testCommitCountMax                             : RUNN=
ING
> >CMT1f    st_commit.testCommitCountMax                             : PASS
> >CMT1e    st_commit.testCommitCount1                               : RUNN=
ING
> >CMT1e    st_commit.testCommitCount1                               : PASS
> >CLOSE9   st_close.testTimedoutClose2                              : RUNN=
ING
> >Sleeping for 30 seconds:
> >Woke up
> >CLOSE9   st_close.testTimedoutClose2                              : FAIL=
URE
> >            nfs4lib.BadCompoundRes: Opening file b'CLOSE9-1':
> >            operation OP_OPEN should return NFS4_OK, instead got
> >            NFS4ERR_DELAY
> >CLOSE8   st_close.testTimedoutClose1                              : RUNN=
ING
> >Sleeping for 30 seconds:
> >Woke up
> >CLOSE8   st_close.testTimedoutClose1                              : FAIL=
URE
> >            nfs4lib.BadCompoundRes: Opening file b'CLOSE8-1':
> >            operation OP_OPEN should return NFS4_OK, instead got
> >            NFS4ERR_DELAY
> >CLOSE6   st_close.testStaleStateid                                : RUNN=
ING
> >CLOSE6   st_close.testStaleStateid                                : PASS
> >CLOSE12  st_close.testReplaySeqid2                                : RUNN=
ING
> >CLOSE12  st_close.testReplaySeqid2                                : PASS
> >CLOSE10  st_close.testReplaySeqid1                                : RUNN=
ING
> >CLOSE10  st_close.testReplaySeqid1                                : PASS
> >CLOSE5   st_close.testOldStateid                                  : RUNN=
ING
> >CLOSE5   st_close.testOldStateid                                  : PASS
> >CLOSE7   st_close.testNoCfh                                       : RUNN=
ING
> >CLOSE7   st_close.testNoCfh                                       : PASS
> >CLOSE11  st_close.testNextSeqid                                   : RUNN=
ING
> >CLOSE11  st_close.testNextSeqid                                   : PASS
> >CLOSE2   st_close.testCloseOpen                                   : RUNN=
ING
> >CLOSE2   st_close.testCloseOpen                                   : PASS
> >CLOSE1   st_close.testCloseCreate                                 : RUNN=
ING
> >CLOSE1   st_close.testCloseCreate                                 : PASS
> >CLOSE4   st_close.testBadStateid                                  : RUNN=
ING
> >CLOSE4   st_close.testBadStateid                                  : PASS
> >CLOSE3   st_close.testBadSeqid                                    : RUNN=
ING
> >CLOSE3   st_close.testBadSeqid                                    : PASS
> >ACL0     st_acl.testACLsupport                                    : RUNN=
ING
> >ACL0     st_acl.testACLsupport                                    : PASS
> >ACL10    st_acl.testLargeACL                                      : RUNN=
ING
> >ACL10    st_acl.testLargeACL                                      : PASS
> >ACL5     st_acl.testACL                                           : RUNN=
ING
> >ACL5     st_acl.testACL                                           : PASS
> >ACC1s    st_access.testReadSocket                                 : RUNN=
ING
> >ACC1s    st_access.testReadSocket                                 : PASS
> >ACC1a    st_access.testReadLink                                   : RUNN=
ING
> >ACC1a    st_access.testReadLink                                   : PASS
> >ACC1r    st_access.testReadFile                                   : RUNN=
ING
> >ACC1r    st_access.testReadFile                                   : PASS
> >ACC1f    st_access.testReadFifo                                   : RUNN=
ING
> >ACC1f    st_access.testReadFifo                                   : PASS
> >ACC1d    st_access.testReadDir                                    : RUNN=
ING
> >ACC1d    st_access.testReadDir                                    : PASS
> >ACC3     st_access.testNoFh                                       : RUNN=
ING
> >ACC3     st_access.testNoFh                                       : PASS
> >ACC4s    st_access.testInvalidsSocket                             : RUNN=
ING
> >ACC4s    st_access.testInvalidsSocket                             : PASS
> >ACC4a    st_access.testInvalidsLink                               : RUNN=
ING
> >ACC4a    st_access.testInvalidsLink                               : PASS
> >ACC4r    st_access.testInvalidsFile                               : RUNN=
ING
> >ACC4r    st_access.testInvalidsFile                               : PASS
> >ACC4f    st_access.testInvalidsFifo                               : RUNN=
ING
> >ACC4f    st_access.testInvalidsFifo                               : PASS
> >ACC4d    st_access.testInvalidsDir                                : RUNN=
ING
> >ACC4d    st_access.testInvalidsDir                                : PASS
> >ACC2s    st_access.testAllSocket                                  : RUNN=
ING
> >ACC2s    st_access.testAllSocket                                  : PASS
> >ACC2a    st_access.testAllLink                                    : RUNN=
ING
> >ACC2a    st_access.testAllLink                                    : PASS
> >ACC2r    st_access.testAllFile                                    : RUNN=
ING
> >ACC2r    st_access.testAllFile                                    : PASS
> >ACC2f    st_access.testAllFifo                                    : RUNN=
ING
> >ACC2f    st_access.testAllFifo                                    : PASS
> >ACC2d    st_access.testAllDir                                     : RUNN=
ING
> >ACC2d    st_access.testAllDir                                     : PASS
> >**************************************************
> >RENEW3   st_renew.testExpired                                     : FAIL=
URE
> >            nfs4lib.BadCompoundRes: Opening file b'RENEW3-1':
> >            operation OP_OPEN should return NFS4_OK, instead got
> >            NFS4ERR_DELAY
> >LKU10    st_locku.testTimedoutUnlock                              : FAIL=
URE
> >            nfs4lib.BadCompoundRes: Opening file b'LKU10-1':
> >            operation OP_OPEN should return NFS4_OK, instead got
> >            NFS4ERR_DELAY
> >CLOSE9   st_close.testTimedoutClose2                              : FAIL=
URE
> >            nfs4lib.BadCompoundRes: Opening file b'CLOSE9-1':
> >            operation OP_OPEN should return NFS4_OK, instead got
> >            NFS4ERR_DELAY
> >CLOSE8   st_close.testTimedoutClose1                              : FAIL=
URE
> >            nfs4lib.BadCompoundRes: Opening file b'CLOSE8-1':
> >            operation OP_OPEN should return NFS4_OK, instead got
> >            NFS4ERR_DELAY
> >**************************************************
> >Command line asked for 526 of 673 tests
> >Of those: 7 Skipped, 4 Failed, 0 Warned, 515 Passed
> >root pynfs tests:
> >MKCHAR   st_create.testChar                                       : RUNN=
ING
> >MKCHAR   st_create.testChar                                       : PASS
> >WRT6c    st_write.testChar                                        : RUNN=
ING
> >WRT6c    st_write.testChar                                        : PASS
> >MKBLK    st_create.testBlock                                      : RUNN=
ING
> >MKBLK    st_create.testBlock                                      : PASS
> >WRT6b    st_write.testBlock                                       : RUNN=
ING
> >WRT6b    st_write.testBlock                                       : PASS
> >LOOKCHAR st_lookup.testChar                                       : RUNN=
ING
> >LOOKCHAR st_lookup.testChar                                       : PASS
> >VF5c     st_verify.testWriteOnlyChar                              : RUNN=
ING
> >VF5c     st_verify.testWriteOnlyChar                              : PASS
> >LOOKBLK  st_lookup.testBlock                                      : RUNN=
ING
> >LOOKBLK  st_lookup.testBlock                                      : PASS
> >VF5b     st_verify.testWriteOnlyBlock                             : RUNN=
ING
> >VF5b     st_verify.testWriteOnlyBlock                             : PASS
> >VF7c     st_verify.testUnsupportedChar                            : RUNN=
ING
> >VF7c     st_verify.testUnsupportedChar                            : PASS
> >VF7b     st_verify.testUnsupportedBlock                           : RUNN=
ING
> >VF7b     st_verify.testUnsupportedBlock                           : PASS
> >VF2c     st_verify.testTypeChar                                   : RUNN=
ING
> >VF2c     st_verify.testTypeChar                                   : PASS
> >VF2b     st_verify.testTypeBlock                                  : RUNN=
ING
> >VF2b     st_verify.testTypeBlock                                  : PASS
> >VF1c     st_verify.testMandChar                                   : RUNN=
ING
> >VF1c     st_verify.testMandChar                                   : PASS
> >VF1b     st_verify.testMandBlock                                  : RUNN=
ING
> >VF1b     st_verify.testMandBlock                                  : PASS
> >VF3c     st_verify.testBadSizeChar                                : RUNN=
ING
> >VF3c     st_verify.testBadSizeChar                                : PASS
> >VF3b     st_verify.testBadSizeBlock                               : RUNN=
ING
> >VF3b     st_verify.testBadSizeBlock                               : PASS
> >SATT11c  st_setattr.testUnsupportedChar                           : RUNN=
ING
> >SATT11c  st_setattr.testUnsupportedChar                           : PASS
> >SATT11b  st_setattr.testUnsupportedBlock                          : RUNN=
ING
> >SATT11b  st_setattr.testUnsupportedBlock                          : PASS
> >SATT12c  st_setattr.testSizeChar                                  : RUNN=
ING
> >SATT12c  st_setattr.testSizeChar                                  : PASS
> >SATT12b  st_setattr.testSizeBlock                                 : RUNN=
ING
> >SATT12b  st_setattr.testSizeBlock                                 : PASS
> >MKDIR    st_create.testDir                                        : RUNN=
ING
> >MKDIR    st_create.testDir                                        : PASS
> >SATT6d   st_setattr.testReadonlyDir                               : RUNN=
ING
> >SATT6d   st_setattr.testReadonlyDir                               : PASS
> >SATT6c   st_setattr.testReadonlyChar                              : RUNN=
ING
> >SATT6c   st_setattr.testReadonlyChar                              : PASS
> >SATT6b   st_setattr.testReadonlyBlock                             : RUNN=
ING
> >SATT6b   st_setattr.testReadonlyBlock                             : PASS
> >MODE     st_setattr.testMode                                      : RUNN=
ING
> >MODE     st_setattr.testMode                                      : PASS
> >SATT1c   st_setattr.testChar                                      : RUNN=
ING
> >SATT1c   st_setattr.testChar                                      : PASS
> >SATT1b   st_setattr.testBlock                                     : RUNN=
ING
> >SATT1b   st_setattr.testBlock                                     : PASS
> >SVFH2c   st_restorefh.testValidChar                               : RUNN=
ING
> >SVFH2c   st_restorefh.testValidChar                               : PASS
> >SVFH2b   st_restorefh.testValidBlock                              : RUNN=
ING
> >SVFH2b   st_restorefh.testValidBlock                              : PASS
> >RNM1c    st_rename.testValidChar                                  : RUNN=
ING
> >RNM1c    st_rename.testValidChar                                  : PASS
> >RNM1b    st_rename.testValidBlock                                 : RUNN=
ING
> >RNM1b    st_rename.testValidBlock                                 : PASS
> >RNM2c    st_rename.testSfhChar                                    : RUNN=
ING
> >RNM2c    st_rename.testSfhChar                                    : PASS
> >RNM2b    st_rename.testSfhBlock                                   : RUNN=
ING
> >RNM2b    st_rename.testSfhBlock                                   : PASS
> >RNM3c    st_rename.testCfhChar                                    : RUNN=
ING
> >RNM3c    st_rename.testCfhChar                                    : PASS
> >RNM3b    st_rename.testCfhBlock                                   : RUNN=
ING
> >RNM3b    st_rename.testCfhBlock                                   : PASS
> >RM1c     st_remove.testChar                                       : RUNN=
ING
> >RM1c     st_remove.testChar                                       : PASS
> >RM2c     st_remove.testCfhChar                                    : RUNN=
ING
> >RM2c     st_remove.testCfhChar                                    : PASS
> >RM2b     st_remove.testCfhBlock                                   : RUNN=
ING
> >RM2b     st_remove.testCfhBlock                                   : PASS
> >RM1b     st_remove.testBlock                                      : RUNN=
ING
> >RM1b     st_remove.testBlock                                      : PASS
> >RDLK2c   st_readlink.testChar                                     : RUNN=
ING
> >RDLK2c   st_readlink.testChar                                     : PASS
> >RDLK2b   st_readlink.testBlock                                    : RUNN=
ING
> >RDLK2b   st_readlink.testBlock                                    : PASS
> >RDDR5c   st_readdir.testFhChar                                    : RUNN=
ING
> >RDDR5c   st_readdir.testFhChar                                    : PASS
> >RDDR5b   st_readdir.testFhBlock                                   : RUNN=
ING
> >RDDR5b   st_readdir.testFhBlock                                   : PASS
> >RD7c     st_read.testChar                                         : RUNN=
ING
> >RD7c     st_read.testChar                                         : PASS
> >RD7b     st_read.testBlock                                        : RUNN=
ING
> >RD7b     st_read.testBlock                                        : PASS
> >PUTFH1c  st_putfh.testChar                                        : RUNN=
ING
> >PUTFH1c  st_putfh.testChar                                        : PASS
> >PUTFH1b  st_putfh.testBlock                                       : RUNN=
ING
> >PUTFH1b  st_putfh.testBlock                                       : PASS
> >INIT     st_setclientid.testValid                                 : RUNN=
ING
> >INIT     st_setclientid.testValid                                 : PASS
> >OPEN7c   st_open.testChar                                         : RUNN=
ING
> >OPEN7c   st_open.testChar                                         : PASS
> >OPEN7b   st_open.testBlock                                        : RUNN=
ING
> >OPEN7b   st_open.testBlock                                        : PASS
> >NVF5c    st_nverify.testWriteOnlyChar                             : RUNN=
ING
> >NVF5c    st_nverify.testWriteOnlyChar                             : PASS
> >NVF5b    st_nverify.testWriteOnlyBlock                            : RUNN=
ING
> >NVF5b    st_nverify.testWriteOnlyBlock                            : PASS
> >NVF7c    st_nverify.testUnsupportedChar                           : RUNN=
ING
> >NVF7c    st_nverify.testUnsupportedChar                           : PASS
> >NVF7b    st_nverify.testUnsupportedBlock                          : RUNN=
ING
> >NVF7b    st_nverify.testUnsupportedBlock                          : PASS
> >NVF2c    st_nverify.testTypeChar                                  : RUNN=
ING
> >NVF2c    st_nverify.testTypeChar                                  : PASS
> >NVF2b    st_nverify.testTypeBlock                                 : RUNN=
ING
> >NVF2b    st_nverify.testTypeBlock                                 : PASS
> >NVF1c    st_nverify.testMandChar                                  : RUNN=
ING
> >NVF1c    st_nverify.testMandChar                                  : PASS
> >NVF1b    st_nverify.testMandBlock                                 : RUNN=
ING
> >NVF1b    st_nverify.testMandBlock                                 : PASS
> >NVF3c    st_nverify.testBadSizeChar                               : RUNN=
ING
> >NVF3c    st_nverify.testBadSizeChar                               : PASS
> >NVF3b    st_nverify.testBadSizeBlock                              : RUNN=
ING
> >NVF3b    st_nverify.testBadSizeBlock                              : PASS
> >LOOKP2c  st_lookupp.testChar                                      : RUNN=
ING
> >LOOKP2c  st_lookupp.testChar                                      : PASS
> >LOOKP2b  st_lookupp.testBlock                                     : RUNN=
ING
> >LOOKP2b  st_lookupp.testBlock                                     : PASS
> >LOOK5c   st_lookup.testCharNotDir                                 : RUNN=
ING
> >LOOK5c   st_lookup.testCharNotDir                                 : PASS
> >LOOK5b   st_lookup.testBlockNotDir                                : RUNN=
ING
> >LOOK5b   st_lookup.testBlockNotDir                                : PASS
> >LKT2c    st_lockt.testChar                                        : RUNN=
ING
> >LKT2c    st_lockt.testChar                                        : PASS
> >LKT2b    st_lockt.testBlock                                       : RUNN=
ING
> >LKT2b    st_lockt.testBlock                                       : PASS
> >LINKS    st_link.testSupported                                    : RUNN=
ING
> >LINKS    st_link.testSupported                                    : PASS
> >LINK1c   st_link.testChar                                         : RUNN=
ING
> >LINK1c   st_link.testChar                                         : PASS
> >LOOKFILE st_lookup.testFile                                       : RUNN=
ING
> >LOOKFILE st_lookup.testFile                                       : PASS
> >LINK4c   st_link.testCfhChar                                      : RUNN=
ING
> >LINK4c   st_link.testCfhChar                                      : PASS
> >LINK4b   st_link.testCfhBlock                                     : RUNN=
ING
> >LINK4b   st_link.testCfhBlock                                     : PASS
> >LINK1b   st_link.testBlock                                        : RUNN=
ING
> >LINK1b   st_link.testBlock                                        : PASS
> >GF1c     st_getfh.testChar                                        : RUNN=
ING
> >GF1c     st_getfh.testChar                                        : PASS
> >GF1b     st_getfh.testBlock                                       : RUNN=
ING
> >GF1b     st_getfh.testBlock                                       : PASS
> >GATT3c   st_getattr.testWriteOnlyChar                             : RUNN=
ING
> >GATT3c   st_getattr.testWriteOnlyChar                             : PASS
> >GATT3b   st_getattr.testWriteOnlyBlock                            : RUNN=
ING
> >GATT3b   st_getattr.testWriteOnlyBlock                            : PASS
> >GATT4c   st_getattr.testUnknownAttrChar                           : RUNN=
ING
> >GATT4c   st_getattr.testUnknownAttrChar                           : PASS
> >GATT4b   st_getattr.testUnknownAttrBlock                          : RUNN=
ING
> >GATT4b   st_getattr.testUnknownAttrBlock                          : PASS
> >GATT6c   st_getattr.testSupportedChar                             : RUNN=
ING
> >GATT6c   st_getattr.testSupportedChar                             : PASS
> >GATT6b   st_getattr.testSupportedBlock                            : RUNN=
ING
> >GATT6b   st_getattr.testSupportedBlock                            : PASS
> >GATT1c   st_getattr.testMandChar                                  : RUNN=
ING
> >GATT1c   st_getattr.testMandChar                                  : PASS
> >GATT1b   st_getattr.testMandBlock                                 : RUNN=
ING
> >GATT1b   st_getattr.testMandBlock                                 : PASS
> >GATT7c   st_getattr.testLongChar                                  : RUNN=
ING
> >GATT7c   st_getattr.testLongChar                                  : PASS
> >GATT7b   st_getattr.testLongBlock                                 : RUNN=
ING
> >GATT7b   st_getattr.testLongBlock                                 : PASS
> >GATT5c   st_getattr.testEmptyChar                                 : RUNN=
ING
> >GATT5c   st_getattr.testEmptyChar                                 : PASS
> >GATT5b   st_getattr.testEmptyBlock                                : RUNN=
ING
> >GATT5b   st_getattr.testEmptyBlock                                : PASS
> >CR4      st_create.testDirOffChar                                 : RUNN=
ING
> >CR4      st_create.testDirOffChar                                 : PASS
> >CR3      st_create.testDirOffBlock                                : RUNN=
ING
> >CR3      st_create.testDirOffBlock                                : PASS
> >CMT2c    st_commit.testChar                                       : RUNN=
ING
> >CMT2c    st_commit.testChar                                       : PASS
> >CMT2b    st_commit.testBlock                                      : RUNN=
ING
> >CMT2b    st_commit.testBlock                                      : PASS
> >ACC1c    st_access.testReadChar                                   : RUNN=
ING
> >ACC1c    st_access.testReadChar                                   : PASS
> >ACC1b    st_access.testReadBlock                                  : RUNN=
ING
> >ACC1b    st_access.testReadBlock                                  : PASS
> >ACC4c    st_access.testInvalidsChar                               : RUNN=
ING
> >ACC4c    st_access.testInvalidsChar                               : PASS
> >ACC4b    st_access.testInvalidsBlock                              : RUNN=
ING
> >ACC4b    st_access.testInvalidsBlock                              : PASS
> >ACC2c    st_access.testAllChar                                    : RUNN=
ING
> >ACC2c    st_access.testAllChar                                    : PASS
> >ACC2b    st_access.testAllBlock                                   : RUNN=
ING
> >ACC2b    st_access.testAllBlock                                   : PASS
> >**************************************************
> >**************************************************
> >Command line asked for 96 of 673 tests
> >Of those: 0 Skipped, 0 Failed, 0 Warned, 96 Passed
> >INFO   :rpc.poll:got connection from ('127.0.0.1', 51342), assigned to f=
d=3D5
> >INFO   :rpc.thread:Called connect(('test1.fieldses.org', 2049))
> >INFO   :rpc.poll:Adding 6 generated by another thread
> >INFO   :test.env:Created client to test1.fieldses.org, 2049
> >INFO   :test.env:Called do_readdir()
> >INFO   :test.env:do_readdir() =3D [entry4(cookie=3D14, name=3Db'dir', at=
trs=3D{}), entry4(cookie=3D17, name=3Db'socket', attrs=3D{}), entry4(cookie=
=3D19, name=3Db'fifo', attrs=3D{}), entry4(cookie=3D21, name=3Db'link', att=
rs=3D{}), entry4(cookie=3D24, name=3Db'block', attrs=3D{}), entry4(cookie=
=3D26, name=3Db'char', attrs=3D{}), entry4(cookie=3D512, name=3Db'file', at=
trs=3D{})]
> >INFO   :test.env:Called do_readdir()
> >INFO   :test.env:do_readdir() =3D []
> >INFO   :test.env:client 1 creates file OK
> >
> >INFO   :test.env:client 2 open file OK
> >
> >INFO   :test.env:force lease to expire...
> >
> >INFO   :test.env:Sleeping for 25 seconds: the lease period + 10 secs
> >INFO   :test.env:Woke up
> >INFO   :test.env:3rd client open OK - PASSED
> >
> >INFO   :test.env:client 1 creates file OK
> >
> >INFO   :test.env:force lease to expire...
> >
> >INFO   :test.env:Sleeping for 25 seconds: the lease period + 10 secs
> >INFO   :test.env:Woke up
> >INFO   :test.env:2nd client open OK - PASSED
> >
> >INFO   :test.env:2nd client open OK - PASSED
> >
> >INFO   :test.env:local open conflict detected - PASSED
> >
> >INFO   :test.env:2nd client open conflict detected - PASSED
> >
> >INFO   :test.env:force lease to expire...
> >
> >INFO   :test.env:Sleeping for 25 seconds: the lease period + 10 secs
> >INFO   :test.env:Woke up
> >INFO   :test.env:3nd client opened OK - no conflict detected - PASSED
> >
> >INFO   :test.env:Sleeping for 25 seconds: the lease period + 10 secs
> >INFO   :test.env:Woke up
> >INFO   :rpc.poll:Closing 6
> >INFO   :rpc.thread:Called connect(('test1.fieldses.org', 2049))
> >INFO   :rpc.poll:Adding 6 generated by another thread
> >WARNING:test.env:server took approximately 13 seconds to lift grace afte=
r all clients reclaimed
> >INFO   :test.env:Sleeping for 20 seconds: Waiting for grace period to end
> >INFO   :test.env:Woke up
> >INFO   :rpc.poll:Closing 6
> >INFO   :rpc.thread:Called connect(('test1.fieldses.org', 2049))
> >INFO   :rpc.poll:Adding 6 generated by another thread
> >INFO   :test.env:Sleeping for 20 seconds: Waiting for grace period to end
> >INFO   :test.env:Woke up
> >INFO   :rpc.poll:Closing 6
> >INFO   :rpc.thread:Called connect(('test1.fieldses.org', 2049))
> >INFO   :rpc.poll:Adding 6 generated by another thread
> >INFO   :test.env:Sleeping for 20 seconds: Waiting for grace period to end
> >INFO   :test.env:Woke up
> >INFO   :rpc.poll:Closing 6
> >INFO   :rpc.thread:Called connect(('test1.fieldses.org', 2049))
> >INFO   :rpc.poll:Adding 6 generated by another thread
> >INFO   :test.env:Sleeping for 20 seconds: Waiting for grace period to end
> >INFO   :test.env:Woke up
> >INFO   :rpc.poll:Closing 6
> >INFO   :rpc.thread:Called connect(('test1.fieldses.org', 2049))
> >INFO   :rpc.poll:Adding 6 generated by another thread
> >INFO   :test.env:Sleeping for 10 seconds: Delaying start of reclaim
> >INFO   :test.env:Woke up
> >INFO   :test.env:Sleeping for 20 seconds: Waiting for grace period to end
> >INFO   :test.env:Woke up
> >INFO   :rpc.poll:Closing 6
> >INFO   :rpc.thread:Called connect(('test1.fieldses.org', 2049))
> >INFO   :rpc.poll:Adding 6 generated by another thread
> >INFO   :test.env:Sleeping for 20 seconds: Waiting for grace period to end
> >INFO   :test.env:Woke up
> >INFO   :rpc.poll:Closing 6
> >INFO   :rpc.thread:Called connect(('test1.fieldses.org', 2049))
> >INFO   :rpc.poll:Adding 6 generated by another thread
> >INFO   :rpc.poll:Closing 6
> >INFO   :rpc.thread:Called connect(('test1.fieldses.org', 2049))
> >INFO   :rpc.poll:Adding 6 generated by another thread
> >WARNING:test.env:server took approximately 14 seconds to lift grace afte=
r all clients reclaimed
> >INFO   :test.env:Sleeping for 20 seconds: Waiting for grace period to end
> >INFO   :test.env:Woke up
> >INFO   :rpc.poll:Closing 6
> >INFO   :rpc.thread:Called connect(('test1.fieldses.org', 2049))
> >INFO   :rpc.poll:Adding 6 generated by another thread
> >INFO   :rpc.poll:Closing 6
> >INFO   :rpc.thread:Called connect(('test1.fieldses.org', 2049))
> >INFO   :rpc.poll:Adding 6 generated by another thread
> >INFO   :test.env:Sleeping for 20 seconds: Waiting for grace period to end
> >INFO   :test.env:Woke up
> >COUR6    st_courtesy.testShareReservationDB03                     : RUNN=
ING
> >COUR6    st_courtesy.testShareReservationDB03                     : PASS
> >COUR5    st_courtesy.testShareReservationDB02                     : RUNN=
ING
> >COUR5    st_courtesy.testShareReservationDB02                     : PASS
> >COUR4    st_courtesy.testShareReservationDB01                     : RUNN=
ING
> >COUR4    st_courtesy.testShareReservationDB01                     : PASS
> >COUR3    st_courtesy.testShareReservation00                       : RUNN=
ING
> >COUR3    st_courtesy.testShareReservation00                       : PASS
> >COUR2    st_courtesy.testLockSleepLock                            : RUNN=
ING
> >COUR2    st_courtesy.testLockSleepLock                            : PASS
> >CSID3    st_current_stateid.testOpenWriteClose                    : RUNN=
ING
> >CSID3    st_current_stateid.testOpenWriteClose                    : PASS
> >CSID8    st_current_stateid.testOpenSetattr                       : RUNN=
ING
> >CSID8    st_current_stateid.testOpenSetattr                       : PASS
> >CSID10   st_current_stateid.testOpenSaveFHLookupRestoreFHClose    : RUNN=
ING
> >CSID10   st_current_stateid.testOpenSaveFHLookupRestoreFHClose    : PASS
> >CSID5    st_current_stateid.testOpenLookupClose                   : RUNN=
ING
> >CSID5    st_current_stateid.testOpenLookupClose                   : PASS
> >CSID9    st_current_stateid.testOpenFreestateidClose              : RUNN=
ING
> >CSID9    st_current_stateid.testOpenFreestateidClose              : PASS
> >CSID1    st_current_stateid.testOpenAndClose                      : RUNN=
ING
> >CSID1    st_current_stateid.testOpenAndClose                      : PASS
> >CSID4    st_current_stateid.testLockWriteLocku                    : RUNN=
ING
> >CSID4    st_current_stateid.testLockWriteLocku                    : PASS
> >CSID2    st_current_stateid.testLockLockU                         : RUNN=
ING
> >CSID2    st_current_stateid.testLockLockU                         : PASS
> >CSID6    st_current_stateid.testCloseNoStateid                    : RUNN=
ING
> >CSID6    st_current_stateid.testCloseNoStateid                    : PASS
> >REBT4b   st_reboot.testRebootWithManyManyClientsDoubleReclaim     : RUNN=
ING
> >REBT4b   st_reboot.testRebootWithManyManyClientsDoubleReclaim     : PASS
> >REBT2b   st_reboot.testRebootWithManyManyClients                  : RUNN=
ING
> >REBT2b   st_reboot.testRebootWithManyManyClients                  : PASS
> >REBT4a   st_reboot.testRebootWithManyClientsDoubleReclaim         : RUNN=
ING
> >REBT4a   st_reboot.testRebootWithManyClientsDoubleReclaim         : PASS
> >REBT2a   st_reboot.testRebootWithManyClients                      : RUNN=
ING
> >REBT2a   st_reboot.testRebootWithManyClients                      : PASS
> >REBT5    st_reboot.testRebootWithLateReclaim                      : RUNN=
ING
> >REBT5    st_reboot.testRebootWithLateReclaim                      : PASS
> >REBT1    st_reboot.testRebootValid                                : RUNN=
ING
> >REBT1    st_reboot.testRebootValid                                : PASS
> >REBT3b   st_reboot.testDoubleRebootWithManyManyClients            : RUNN=
ING
> >REBT3b   st_reboot.testDoubleRebootWithManyManyClients            : PASS
> >REBT3a   st_reboot.testDoubleRebootWithManyClients                : RUNN=
ING
> >REBT3a   st_reboot.testDoubleRebootWithManyClients                : PASS
> >PUTFH1s  st_putfh.testSocket                                      : RUNN=
ING
> >PUTFH1s  st_putfh.testSocket                                      : PASS
> >PUTFH1a  st_putfh.testLink                                        : RUNN=
ING
> >PUTFH1a  st_putfh.testLink                                        : PASS
> >PUTFH1r  st_putfh.testFile                                        : RUNN=
ING
> >PUTFH1r  st_putfh.testFile                                        : PASS
> >PUTFH1f  st_putfh.testFifo                                        : RUNN=
ING
> >PUTFH1f  st_putfh.testFifo                                        : PASS
> >PUTFH1d  st_putfh.testDir                                         : RUNN=
ING
> >PUTFH1d  st_putfh.testDir                                         : PASS
> >PUTFH2   st_putfh.testBadHandle                                   : RUNN=
ING
> >PUTFH2   st_putfh.testBadHandle                                   : PASS
> >RNM6     st_rename.testZeroLengthOldname                          : RUNN=
ING
> >RNM6     st_rename.testZeroLengthOldname                          : PASS
> >RNM7     st_rename.testZeroLengthNewname                          : RUNN=
ING
> >RNM7     st_rename.testZeroLengthNewname                          : PASS
> >RNM1s    st_rename.testValidSocket                                : RUNN=
ING
> >RNM1s    st_rename.testValidSocket                                : PASS
> >RNM1a    st_rename.testValidLink                                  : RUNN=
ING
> >RNM1a    st_rename.testValidLink                                  : PASS
> >RNM1r    st_rename.testValidFile                                  : RUNN=
ING
> >RNM1r    st_rename.testValidFile                                  : PASS
> >RNM1f    st_rename.testValidFifo                                  : RUNN=
ING
> >RNM1f    st_rename.testValidFifo                                  : PASS
> >RNM1d    st_rename.testValidDir                                   : RUNN=
ING
> >RNM1d    st_rename.testValidDir                                   : PASS
> >RNM2s    st_rename.testSfhSocket                                  : RUNN=
ING
> >RNM2s    st_rename.testSfhSocket                                  : PASS
> >RNM2a    st_rename.testSfhLink                                    : RUNN=
ING
> >RNM2a    st_rename.testSfhLink                                    : PASS
> >RNM2r    st_rename.testSfhFile                                    : RUNN=
ING
> >RNM2r    st_rename.testSfhFile                                    : PASS
> >RNM2f    st_rename.testSfhFifo                                    : RUNN=
ING
> >RNM2f    st_rename.testSfhFifo                                    : PASS
> >RNM19    st_rename.testSelfRenameFile                             : RUNN=
ING
> >RNM19    st_rename.testSelfRenameFile                             : PASS
> >RNM18    st_rename.testSelfRenameDir                              : RUNN=
ING
> >RNM18    st_rename.testSelfRenameDir                              : PASS
> >RNM5     st_rename.testNonExistent                                : RUNN=
ING
> >RNM5     st_rename.testNonExistent                                : PASS
> >RNM4     st_rename.testNoSfh                                      : RUNN=
ING
> >RNM4     st_rename.testNoSfh                                      : PASS
> >RNM20    st_rename.testLinkRename                                 : RUNN=
ING
> >RNM20    st_rename.testLinkRename                                 : PASS
> >RNM17    st_rename.testFileToFullDir                              : RUNN=
ING
> >RNM17    st_rename.testFileToFullDir                              : PASS
> >RNM15    st_rename.testFileToFile                                 : RUNN=
ING
> >RNM15    st_rename.testFileToFile                                 : PASS
> >RNM14    st_rename.testFileToDir                                  : RUNN=
ING
> >RNM14    st_rename.testFileToDir                                  : PASS
> >RNM10    st_rename.testDotsOldname                                : RUNN=
ING
> >RNM10    st_rename.testDotsOldname                                : PASS
> >RNM11    st_rename.testDotsNewname                                : RUNN=
ING
> >RNM11    st_rename.testDotsNewname                                : PASS
> >RNM12    st_rename.testDirToObj                                   : RUNN=
ING
> >RNM12    st_rename.testDirToObj                                   : PASS
> >RNM16    st_rename.testDirToFullDir                               : RUNN=
ING
> >RNM16    st_rename.testDirToFullDir                               : PASS
> >RNM13    st_rename.testDirToDir                                   : RUNN=
ING
> >RNM13    st_rename.testDirToDir                                   : PASS
> >RNM3s    st_rename.testCfhSocket                                  : RUNN=
ING
> >RNM3s    st_rename.testCfhSocket                                  : PASS
> >RNM3a    st_rename.testCfhLink                                    : RUNN=
ING
> >RNM3a    st_rename.testCfhLink                                    : PASS
> >RNM3r    st_rename.testCfhFile                                    : RUNN=
ING
> >INFO   :nfs.client.cb:********************
> >INFO   :nfs.client.cb:Handling COMPOUND
> >INFO   :nfs.client.cb:*** OP_CB_SEQUENCE (11) ***
> >INFO   :nfs.client.cb:In CB_SEQUENCE
> >INFO   :nfs.client.cb:*** OP_CB_RECALL (4) ***
> >INFO   :nfs.client.cb:In CB_RECALL
> >INFO   :nfs.client.cb:Replying.  Status NFS4_OK (0)
> >INFO   :nfs.client.cb:[nfs_cb_resop4(resop=3D11, opcbsequence=3DCB_SEQUE=
NCE4res(csr_status=3DNFS4_OK, csr_resok4=3DCB_SEQUENCE4resok(csr_sessionid=
=3Db'<\x0b\xdfa\x9cWSo[\x03\x00\x00\x00\x00\x00\x00', csr_sequenceid=3D1, c=
sr_slotid=3D0, csr_highest_slotid=3D8, csr_target_highest_slotid=3D8))), nf=
s_cb_resop4(resop=3D4, opcbrecall=3DCB_RECALL4res(status=3DNFS4_OK))]
> >INFO   :test.env:Sleeping for 0 seconds:
> >INFO   :test.env:Woke up
> >INFO   :nfs.client.cb:********************
> >INFO   :nfs.client.cb:Handling COMPOUND
> >INFO   :nfs.client.cb:*** OP_CB_SEQUENCE (11) ***
> >INFO   :nfs.client.cb:In CB_SEQUENCE
> >INFO   :nfs.client.cb:*** OP_CB_RECALL (4) ***
> >INFO   :nfs.client.cb:In CB_RECALL
> >INFO   :nfs.client.cb:Replying.  Status NFS4_OK (0)
> >INFO   :nfs.client.cb:[nfs_cb_resop4(resop=3D11, opcbsequence=3DCB_SEQUE=
NCE4res(csr_status=3DNFS4_OK, csr_resok4=3DCB_SEQUENCE4resok(csr_sessionid=
=3Db'<\x0b\xdfa\x9eWSo]\x03\x00\x00\x00\x00\x00\x00', csr_sequenceid=3D1, c=
sr_slotid=3D0, csr_highest_slotid=3D8, csr_target_highest_slotid=3D8))), nf=
s_cb_resop4(resop=3D4, opcbrecall=3DCB_RECALL4res(status=3DNFS4_OK))]
> >INFO   :test.env:Sleeping for 0 seconds:
> >INFO   :test.env:Woke up
> >INFO   :nfs.client.cb:********************
> >INFO   :nfs.client.cb:Handling COMPOUND
> >INFO   :nfs.client.cb:*** OP_CB_SEQUENCE (11) ***
> >INFO   :nfs.client.cb:In CB_SEQUENCE
> >INFO   :nfs.client.cb:*** OP_CB_RECALL (4) ***
> >INFO   :nfs.client.cb:In CB_RECALL
> >INFO   :nfs.client.cb:Replying.  Status NFS4_OK (0)
> >INFO   :nfs.client.cb:[nfs_cb_resop4(resop=3D11, opcbsequence=3DCB_SEQUE=
NCE4res(csr_status=3DNFS4_OK, csr_resok4=3DCB_SEQUENCE4resok(csr_sessionid=
=3Db'<\x0b\xdfa\xa1WSo`\x03\x00\x00\x00\x00\x00\x00', csr_sequenceid=3D1, c=
sr_slotid=3D0, csr_highest_slotid=3D8, csr_target_highest_slotid=3D8))), nf=
s_cb_resop4(resop=3D4, opcbrecall=3DCB_RECALL4res(status=3DNFS4_OK))]
> >INFO   :nfs.client.cb:********************
> >INFO   :nfs.client.cb:Handling COMPOUND
> >INFO   :nfs.client.cb:*** OP_CB_SEQUENCE (11) ***
> >INFO   :nfs.client.cb:In CB_SEQUENCE
> >INFO   :nfs.client.cb:*** OP_CB_RECALL (4) ***
> >INFO   :nfs.client.cb:In CB_RECALL
> >INFO   :nfs.client.cb:Replying.  Status NFS4_OK (0)
> >INFO   :nfs.client.cb:[nfs_cb_resop4(resop=3D11, opcbsequence=3DCB_SEQUE=
NCE4res(csr_status=3DNFS4_OK, csr_resok4=3DCB_SEQUENCE4resok(csr_sessionid=
=3Db'<\x0b\xdfa\xa3WSob\x03\x00\x00\x00\x00\x00\x00', csr_sequenceid=3D1, c=
sr_slotid=3D0, csr_highest_slotid=3D8, csr_target_highest_slotid=3D8))), nf=
s_cb_resop4(resop=3D4, opcbrecall=3DCB_RECALL4res(status=3DNFS4_OK))]
> >INFO   :test.env:Sleeping for 0 seconds:
> >INFO   :test.env:Woke up
> >INFO   :rpc.thread:Called connect(('test1.fieldses.org', 2049))
> >INFO   :rpc.poll:Adding 8 generated by another thread
> >RNM3r    st_rename.testCfhFile                                    : PASS
> >RNM3f    st_rename.testCfhFifo                                    : RUNN=
ING
> >RNM3f    st_rename.testCfhFifo                                    : PASS
> >LKPP1s   st_lookupp.testSock                                      : RUNN=
ING
> >LKPP1s   st_lookupp.testSock                                      : PASS
> >LKPP3    st_lookupp.testNoFH                                      : RUNN=
ING
> >LKPP3    st_lookupp.testNoFH                                      : PASS
> >LKPP2    st_lookupp.testLookuppRoot                               : RUNN=
ING
> >LKPP2    st_lookupp.testLookuppRoot                               : PASS
> >LKPP1a   st_lookupp.testLink                                      : RUNN=
ING
> >LKPP1a   st_lookupp.testLink                                      : PASS
> >LKPP1r   st_lookupp.testFile                                      : RUNN=
ING
> >LKPP1r   st_lookupp.testFile                                      : PASS
> >LKPP1f   st_lookupp.testFifo                                      : RUNN=
ING
> >LKPP1f   st_lookupp.testFifo                                      : PASS
> >VF1r     st_verify.testMandFile                                   : RUNN=
ING
> >VF1r     st_verify.testMandFile                                   : PASS
> >DELEG9   st_delegation.testWriteOpenvsReadDeleg                   : RUNN=
ING
> >DELEG9   st_delegation.testWriteOpenvsReadDeleg                   : PASS
> >DELEG23  st_delegation.testServerSelfConflict3                    : RUNN=
ING
> >__create_file_with_deleg:  b'\x01\x00\x06\x81\xa68F}\x17\x9bN\xb5\xa8\x8=
5Pp0\xbc\xdc`?S\x80\x00\x00\x00\x00\x00\x1eX\xc5%' open_delegation4(delegat=
ion_type=3DOPEN_DELEGATE_READ, read=3Dopen_read_delegation4(stateid=3Dstate=
id4(seqid=3D1, other=3Db'<\x0b\xdfa\x9cWSo\x02\x00\x00\x00'), recall=3DFals=
e, permissions=3Dnfsace4(type=3D0, flag=3D0, access_mask=3D0, who=3Db'')))
> >open_file res:  COMPOUND4res(status=3DNFS4_OK, tag=3Db'environment.py:op=
en_create_file', resarray=3D[nfs_resop4(resop=3DOP_PUTROOTFH, opputrootfh=
=3DPUTROOTFH4res(status=3DNFS4_OK)), nfs_resop4(resop=3DOP_LOOKUP, oplookup=
=3DLOOKUP4res(status=3DNFS4_OK)), nfs_resop4(resop=3DOP_LOOKUP, oplookup=3D=
LOOKUP4res(status=3DNFS4_OK)), nfs_resop4(resop=3DOP_LOOKUP, oplookup=3DLOO=
KUP4res(status=3DNFS4_OK)), nfs_resop4(resop=3DOP_LOOKUP, oplookup=3DLOOKUP=
4res(status=3DNFS4_OK)), nfs_resop4(resop=3DOP_OPEN, opopen=3DOPEN4res(stat=
us=3DNFS4_OK, resok4=3DOPEN4resok(stateid=3Dstateid4(seqid=3D2, other=3Db'<=
\x0b\xdfa\x9cWSo\x01\x00\x00\x00'), cinfo=3Dchange_info4(atomic=3DFalse, be=
fore=3D1763091998602434224, after=3D1737777748740145092), rflags=3D36, attr=
set=3D0, delegation=3Dopen_delegation4(delegation_type=3DOPEN_DELEGATE_NONE=
_EXT, od_whynone=3Dopen_none_delegation4(ond_why=3DWND4_NOT_WANTED))))), nf=
s_resop4(resop=3DOP_GETFH, opgetfh=3DGETFH4res(status=3DNFS4_OK, resok4=3DG=
ETFH4resok(object=3Db'\x01\x00\x06\x81\xa68F}\x17\x9bN\xb5\xa8\x85Pp0\xbc\x=
dc`?S\x80\x00\x00\x00\x00\x00\x1e
> >  X\xc5%')))])
> >DELEG23  st_delegation.testServerSelfConflict3                    : PASS
> >DELEG1   st_delegation.testReadDeleg                              : RUNN=
ING
> >DELEG1   st_delegation.testReadDeleg                              : PASS
> >DELEG4   st_delegation.testNoDeleg                                : RUNN=
ING
> >DELEG4   st_delegation.testNoDeleg                                : PASS
> >DELEG8   st_delegation.testDelegRevocation                        : RUNN=
ING
> >DELEG8   st_delegation.testDelegRevocation                        : PASS
> >DELEG6   st_delegation.testCBSecParmsNull                         : RUNN=
ING
> >DELEG6   st_delegation.testCBSecParmsNull                         : PASS
> >OPEN1    st_open.testSupported                                    : RUNN=
ING
> >OPEN1    st_open.testSupported                                    : PASS
> >OPEN2    st_open.testServerStateSeqid                             : RUNN=
ING
> >OPEN2    st_open.testServerStateSeqid                             : PASS
> >OPEN30   st_open.testReadWrite                                    : RUNN=
ING
> >OPEN30   st_open.testReadWrite                                    : PASS
> >OPEN7    st_open.testOPENClaimFH                                  : RUNN=
ING
> >OPEN7    st_open.testOPENClaimFH                                  : PASS
> >OPEN6    st_open.testEXCLUSIVE4AtNameAttribute                    : RUNN=
ING
> >OPEN6    st_open.testEXCLUSIVE4AtNameAttribute                    : PASS
> >OPEN8    st_open.testCloseWithZeroSeqid                           : RUNN=
ING
> >OPEN8    st_open.testCloseWithZeroSeqid                           : PASS
> >OPEN31   st_open.testAnonReadWrite                                : RUNN=
ING
> >OPEN31   st_open.testAnonReadWrite                                : PASS
> >TRUNK2   st_trunking.testUseTwoSessions                           : RUNN=
ING
> >TRUNK2   st_trunking.testUseTwoSessions                           : PASS
> >TRUNK1   st_trunking.testTwoSessions                              : RUNN=
ING
> >TRUNK1   st_trunking.testTwoSessions                              : PASS
> >SEQ7     st_sequence.testTooManyOps                               : RUNN=
ING
> >SEQ7     st_sequence.testTooManyOps                               : PASS
> >SEQ1     st_sequence.testSupported                                : RUNN=
ING
> >SEQ1     st_sequence.testSupported                                : PASS
> >SEQ12    st_sequence.testSessionidSequenceidSlotid                : RUNN=
ING
> >SEQ12    st_sequence.testSessionidSequenceidSlotid                : PASS
> >SEQ6     st_sequence.testRequestTooBig                            : RUNN=
ING
> >SEQ6     st_sequence.testRequestTooBig                            : PASS
> >SEQ10b   st_sequence.testReplayCache007                           : RUNN=
ING
> >SEQ10b   st_sequence.testReplayCache007                           : PASS
> >SEQ9f    st_sequence.testReplayCache006                           : RUNN=
ING
> >SEQ9f    st_sequence.testReplayCache006                           : PASS
> >SEQ9e    st_sequence.testReplayCache005                           : RUNN=
ING
> >SEQ9e    st_sequence.testReplayCache005                           : PASS
> >SEQ9d    st_sequence.testReplayCache004                           : RUNN=
ING
> >SEQ9d    st_sequence.testReplayCache004                           : PASS
> >SEQ9c    st_sequence.testReplayCache003                           : RUNN=
ING
> >SEQ9c    st_sequence.testReplayCache003                           : PASS
> >SEQ9b    st_sequence.testReplayCache002                           : RUNN=
ING
> >SEQ9b    st_sequence.testReplayCache002                           : PASS
> >SEQ9a    st_sequence.testReplayCache001                           : RUNN=
ING
> >SEQ9a    st_sequence.testReplayCache001                           : PASS
> >SEQ11    st_sequence.testOpNotInSession                           : RUNN=
ING
> >SEQ11    st_sequence.testOpNotInSession                           : PASS
> >SEQ2     st_sequence.testNotFirst                                 : RUNN=
ING
> >SEQ2     st_sequence.testNotFirst                                 : PASS
> >SEQ4     st_sequence.testImplicitBind                             : RUNN=
ING
> >SEQ4     st_sequence.testImplicitBind                             : PASS
> >SEQ8     st_sequence.testBadSlot                                  : RUNN=
ING
> >SEQ8     st_sequence.testBadSlot                                  : PASS
> >SEQ5     st_sequence.testBadSession                               : RUNN=
ING
> >SEQ5     st_sequence.testBadSession                               : PASS
> >SEQ13    st_sequence.testBadSequenceidAtSlot                      : RUNN=
ING
> >SEQ13    st_sequence.testBadSequenceidAtSlot                      : PASS
> >SEC2     st_secinfo.testSupported2                                : RUNN=
ING
> >SEC2     st_secinfo.testSupported2                                : PASS
> >SEC1     st_secinfo.testSupported                                 : RUNN=
ING
> >SEC1     st_secinfo.testSupported                                 : PASS
> >SECNN4   st_secinfo_no_name.testSupported4                        : RUNN=
ING
> >SECNN4   st_secinfo_no_name.testSupported4                        : PASS
> >SECNN3   st_secinfo_no_name.testSupported3                        : RUNN=
ING
> >SECNN3   st_secinfo_no_name.testSupported3                        : PASS
> >SECNN2   st_secinfo_no_name.testSupported2                        : RUNN=
ING
> >COMPOUND4res(status=3DNFS4ERR_NOFILEHANDLE, tag=3Db'st_secinfo_no_name.p=
y:testSupported2', resarray=3D[nfs_resop4(resop=3DOP_PUTROOTFH, opputrootfh=
=3DPUTROOTFH4res(status=3DNFS4_OK)), nfs_resop4(resop=3DOP_SECINFO_NO_NAME,=
 opsecinfo_no_name=3DSECINFO4res(status=3DNFS4_OK, resok4=3D[secinfo4(flavo=
r=3D6, flavor_info=3Drpcsec_gss_info(oid=3Db'*\x86H\x86\xf7\x12\x01\x02\x02=
', qop=3D0, service=3DRPC_GSS_SVC_NONE)), secinfo4(flavor=3D6, flavor_info=
=3Drpcsec_gss_info(oid=3Db'*\x86H\x86\xf7\x12\x01\x02\x02', qop=3D0, servic=
e=3DRPC_GSS_SVC_INTEGRITY)), secinfo4(flavor=3D6, flavor_info=3Drpcsec_gss_=
info(oid=3Db'*\x86H\x86\xf7\x12\x01\x02\x02', qop=3D0, service=3DRPC_GSS_SV=
C_PRIVACY)), secinfo4(flavor=3D1)])), nfs_resop4(resop=3DOP_GETFH, opgetfh=
=3DGETFH4res(status=3DNFS4ERR_NOFILEHANDLE))])
> >SECNN2   st_secinfo_no_name.testSupported2                        : PASS
> >SECNN1   st_secinfo_no_name.testSupported                         : RUNN=
ING
> >SECNN1   st_secinfo_no_name.testSupported                         : PASS
> >RECC1    st_reclaim_complete.testSupported                        : RUNN=
ING
> >RECC1    st_reclaim_complete.testSupported                        : PASS
> >RECC2    st_reclaim_complete.testReclaimAfterRECC                 : RUNN=
ING
> >RECC2    st_reclaim_complete.testReclaimAfterRECC                 : PASS
> >RECC3    st_reclaim_complete.testOpenBeforeRECC                   : RUNN=
ING
> >RECC3    st_reclaim_complete.testOpenBeforeRECC                   : PASS
> >RECC4    st_reclaim_complete.testDoubleRECC                       : RUNN=
ING
> >RECC4    st_reclaim_complete.testDoubleRECC                       : PASS
> >DESCID1  st_destroy_clientid.testSupported                        : RUNN=
ING
> >DESCID1  st_destroy_clientid.testSupported                        : PASS
> >DESCID2  st_destroy_clientid.testDestroyCIDWS                     : RUNN=
ING
> >DESCID2  st_destroy_clientid.testDestroyCIDWS                     : PASS
> >DESCID8  st_destroy_clientid.testDestroyCIDTwice                  : RUNN=
ING
> >DESCID8  st_destroy_clientid.testDestroyCIDTwice                  : PASS
> >DESCID5  st_destroy_clientid.testDestroyCIDSessionB               : RUNN=
ING
> >DESCID5  st_destroy_clientid.testDestroyCIDSessionB               : PASS
> >DESCID7  st_destroy_clientid.testDestroyCIDNotOnly                : RUNN=
ING
> >DESCID7  st_destroy_clientid.testDestroyCIDNotOnly                : PASS
> >DESCID6  st_destroy_clientid.testDestroyCIDCSession               : RUNN=
ING
> >DESCID6  st_destroy_clientid.testDestroyCIDCSession               : PASS
> >DESCID3  st_destroy_clientid.testDestroyBadCIDWS                  : RUNN=
ING
> >DESCID3  st_destroy_clientid.testDestroyBadCIDWS                  : PASS
> >DESCID4  st_destroy_clientid.testDestroyBadCIDIS                  : RUNN=
ING
> >DESCID4  st_destroy_clientid.testDestroyBadCIDIS                  : PASS
> >CSESS28  st_create_session.testTooSmallMaxReq                     : RUNN=
ING
> >CSESS28  st_create_session.testTooSmallMaxReq                     : PASS
> >CSESS25  st_create_session.testTooSmallMaxRS                      : RUNN=
ING
> >CSESS25  st_create_session.testTooSmallMaxRS                      : PASS
> >CSESS2b  st_create_session.testSupported2b                        : RUNN=
ING
> >CSESS2b  st_create_session.testSupported2b                        : PASS
> >CSESS2   st_create_session.testSupported2                         : RUNN=
ING
> >CSESS2   st_create_session.testSupported2                         : PASS
> >CSESS1   st_create_session.testSupported1                         : RUNN=
ING
> >CSESS1   st_create_session.testSupported1                         : PASS
> >CSESS9   st_create_session.testPrincipalCollision1                : RUNN=
ING
> >CSESS9   st_create_session.testPrincipalCollision1                : PASS
> >CSESS6   st_create_session.testReplay2                            : RUNN=
ING
> >CSESS6   st_create_session.testReplay2                            : PASS
> >CSESS5b  st_create_session.testReplay1b                           : RUNN=
ING
> >CSESS5b  st_create_session.testReplay1b                           : PASS
> >CSESS5a  st_create_session.testReplay1a                           : RUNN=
ING
> >CSESS5a  st_create_session.testReplay1a                           : PASS
> >CSESS5   st_create_session.testReplay1                            : RUNN=
ING
> >CSESS5   st_create_session.testReplay1                            : PASS
> >CSESS27  st_create_session.testRepTooBigToCache                   : RUNN=
ING
> >CSESS27  st_create_session.testRepTooBigToCache                   : PASS
> >CSESS26  st_create_session.testRepTooBig                          : RUNN=
ING
> >[0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 19]
> >CSESS26  st_create_session.testRepTooBig                          : PASS
> >CSESS19  st_create_session.testRdmaArray2                         : RUNN=
ING
> >COMPOUND4res(status=3DNFS4ERR_BADXDR, tag=3Db'st_create_session.py:testR=
dmaArray2', resarray=3D[nfs_resop4(resop=3DOP_CREATE_SESSION, opcreate_sess=
ion=3DCREATE_SESSION4res(csr_status=3DNFS4ERR_BADXDR))])
> >CSESS19  st_create_session.testRdmaArray2                         : PASS
> >CSESS18  st_create_session.testRdmaArray1                         : RUNN=
ING
> >CSESS18  st_create_session.testRdmaArray1                         : PASS
> >CSESS17  st_create_session.testRdmaArray0                         : RUNN=
ING
> >CSESS17  st_create_session.testRdmaArray0                         : PASS
> >CSESS10  st_create_session.testPrincipalCollision2                : RUNN=
ING
> >CSESS10  st_create_session.testPrincipalCollision2                : PASS
> >CSESS23  st_create_session.testNotOnlyOp                          : RUNN=
ING
> >CSESS23  st_create_session.testNotOnlyOp                          : PASS
> >CSESS3   st_create_session.testNoExchange                         : RUNN=
ING
> >CSESS3   st_create_session.testNoExchange                         : PASS
> >CSESS22  st_create_session.testMaxreqs                            : RUNN=
ING
> >CSESS22  st_create_session.testMaxreqs                            : PASS
> >CSESS200 st_create_session.testManyClients                        : RUNN=
ING
> >CSESS200 st_create_session.testManyClients                        : PASS
> >CSESS29  st_create_session.testDRCMemLeak                         : RUNN=
ING
> >CSESS29  st_create_session.testDRCMemLeak                         : PASS
> >CSESS24  st_create_session.testCsr_sequence                       : RUNN=
ING
> >CSESS24  st_create_session.testCsr_sequence                       : PASS
> >CSESS4   st_create_session.testContrivedReplay                    : RUNN=
ING
> >CSESS4   st_create_session.testContrivedReplay                    : PASS
> >CSESS16a st_create_session.testCbSecParmsDec                      : RUNN=
ING
> >CSESS16a st_create_session.testCbSecParmsDec                      : PASS
> >CSESS16  st_create_session.testCbSecParms                         : RUNN=
ING
> >CSESS16  st_create_session.testCbSecParms                         : PASS
> >CSESS8   st_create_session.testBadSeqnum2                         : RUNN=
ING
> >CSESS8   st_create_session.testBadSeqnum2                         : PASS
> >CSESS7   st_create_session.testBadSeqnum1                         : RUNN=
ING
> >CSESS7   st_create_session.testBadSeqnum1                         : PASS
> >CSESS15  st_create_session.testBadFlag                            : RUNN=
ING
> >CSESS15  st_create_session.testBadFlag                            : PASS
> >COMP1    st_compound.testZeroOps                                  : RUNN=
ING
> >COMP1    st_compound.testZeroOps                                  : PASS
> >COMP5    st_compound.testUndefined                                : RUNN=
ING
> >COMP5    st_compound.testUndefined                                : PASS
> >COMP4b   st_compound.testInvalidMinor2                            : RUNN=
ING
> >COMP4b   st_compound.testInvalidMinor2                            : PASS
> >COMP4a   st_compound.testInvalidMinor                             : RUNN=
ING
> >COMP4a   st_compound.testInvalidMinor                             : PASS
> >COMP2    st_compound.testGoodTag                                  : RUNN=
ING
> >COMP2    st_compound.testGoodTag                                  : PASS
> >EID6     st_exchange_id.testUpdateNonexistant                     : RUNN=
ING
> >EID6     st_exchange_id.testUpdateNonexistant                     : PASS
> >EID6h    st_exchange_id.testUpdate111                             : RUNN=
ING
> >INFO   :test.env:Called do_readdir()
> >INFO   :test.env:do_readdir() =3D [entry4(cookie=3D16, name=3Db'COUR6_16=
42007029', attrs=3D{}), entry4(cookie=3D20, name=3Db'COUR5_1642007029', att=
rs=3D{}), entry4(cookie=3D24, name=3Db'COUR4_1642007029', attrs=3D{}), entr=
y4(cookie=3D28, name=3Db'COUR3_1642007029', attrs=3D{}), entry4(cookie=3D32=
, name=3Db'COUR2_1642007029', attrs=3D{}), entry4(cookie=3D36, name=3Db'CSI=
D3_1642007029', attrs=3D{}), entry4(cookie=3D40, name=3Db'CSID8_1642007029'=
, attrs=3D{}), entry4(cookie=3D44, name=3Db'CSID10_1642007029', attrs=3D{})=
, entry4(cookie=3D48, name=3Db'CSID5_1642007029', attrs=3D{}), entry4(cooki=
e=3D52, name=3Db'CSID9_1642007029', attrs=3D{}), entry4(cookie=3D56, name=
=3Db'CSID1_1642007029', attrs=3D{}), entry4(cookie=3D60, name=3Db'CSID4_164=
2007029', attrs=3D{}), entry4(cookie=3D64, name=3Db'CSID2_1642007029', attr=
s=3D{}), entry4(cookie=3D68, name=3Db'CSID6_1642007029', attrs=3D{}), entry=
4(cookie=3D74, name=3Db'owner_REBT4b_1642007029_client_0', attrs=3D{}), ent=
ry4(cookie=3D80, name=3Db'owner_REBT4b_1642007029_client_1', attrs=3D{}), e=
ntry4(cookie=3D86, name=3Db'owner_REBT4b_1642007029_cli
> >  ent_2', attrs=3D{}), entry4(cookie=3D92, name=3Db'owner_REBT4b_1642007=
029_client_3', attrs=3D{}), entry4(cookie=3D98, name=3Db'owner_REBT4b_16420=
07029_client_4', attrs=3D{}), entry4(cookie=3D104, name=3Db'owner_REBT4b_16=
42007029_client_5', attrs=3D{}), entry4(cookie=3D110, name=3Db'owner_REBT4b=
_1642007029_client_6', attrs=3D{}), entry4(cookie=3D116, name=3Db'owner_REB=
T4b_1642007029_client_7', attrs=3D{}), entry4(cookie=3D122, name=3Db'owner_=
REBT4b_1642007029_client_8', attrs=3D{}), entry4(cookie=3D128, name=3Db'own=
er_REBT4b_1642007029_client_9', attrs=3D{}), entry4(cookie=3D134, name=3Db'=
owner_REBT4b_1642007029_client_10', attrs=3D{}), entry4(cookie=3D140, name=
=3Db'owner_REBT4b_1642007029_client_11', attrs=3D{}), entry4(cookie=3D146, =
name=3Db'owner_REBT4b_1642007029_client_12', attrs=3D{}), entry4(cookie=3D1=
52, name=3Db'owner_REBT4b_1642007029_client_13', attrs=3D{}), entry4(cookie=
=3D158, name=3Db'owner_REBT4b_1642007029_client_14', attrs=3D{}), entry4(co=
okie=3D164, name=3Db'owner_REBT4b_1642007029_client_15', attrs=3D{}), entry=
4(cookie=3D170, name=3Db'owner_REBT4b
> >  _1642007029_client_16', attrs=3D{}), entry4(cookie=3D176, name=3Db'own=
er_REBT4b_1642007029_client_17', attrs=3D{}), entry4(cookie=3D182, name=3Db=
'owner_REBT4b_1642007029_client_18', attrs=3D{}), entry4(cookie=3D188, name=
=3Db'owner_REBT4b_1642007029_client_19', attrs=3D{}), entry4(cookie=3D194, =
name=3Db'owner_REBT4b_1642007029_client_20', attrs=3D{}), entry4(cookie=3D2=
00, name=3Db'owner_REBT4b_1642007029_client_21', attrs=3D{}), entry4(cookie=
=3D206, name=3Db'owner_REBT4b_1642007029_client_22', attrs=3D{}), entry4(co=
okie=3D212, name=3Db'owner_REBT4b_1642007029_client_23', attrs=3D{}), entry=
4(cookie=3D218, name=3Db'owner_REBT4b_1642007029_client_24', attrs=3D{}), e=
ntry4(cookie=3D224, name=3Db'owner_REBT4b_1642007029_client_25', attrs=3D{}=
), entry4(cookie=3D230, name=3Db'owner_REBT4b_1642007029_client_26', attrs=
=3D{}), entry4(cookie=3D236, name=3Db'owner_REBT4b_1642007029_client_27', a=
ttrs=3D{}), entry4(cookie=3D242, name=3Db'owner_REBT4b_1642007029_client_28=
', attrs=3D{}), entry4(cookie=3D248, name=3Db'owner_REBT4b_1642007029_clien=
t_29', attrs=3D{}), entry4(cookie
> >  =3D254, name=3Db'owner_REBT4b_1642007029_client_30', attrs=3D{}), entr=
y4(cookie=3D260, name=3Db'owner_REBT4b_1642007029_client_31', attrs=3D{}), =
entry4(cookie=3D266, name=3Db'owner_REBT4b_1642007029_client_32', attrs=3D{=
}), entry4(cookie=3D272, name=3Db'owner_REBT4b_1642007029_client_33', attrs=
=3D{}), entry4(cookie=3D278, name=3Db'owner_REBT4b_1642007029_client_34', a=
ttrs=3D{}), entry4(cookie=3D284, name=3Db'owner_REBT4b_1642007029_client_35=
', attrs=3D{}), entry4(cookie=3D290, name=3Db'owner_REBT4b_1642007029_clien=
t_36', attrs=3D{}), entry4(cookie=3D296, name=3Db'owner_REBT4b_1642007029_c=
lient_37', attrs=3D{}), entry4(cookie=3D302, name=3Db'owner_REBT4b_16420070=
29_client_38', attrs=3D{}), entry4(cookie=3D308, name=3Db'owner_REBT4b_1642=
007029_client_39', attrs=3D{}), entry4(cookie=3D314, name=3Db'owner_REBT4b_=
1642007029_client_40', attrs=3D{}), entry4(cookie=3D320, name=3Db'owner_REB=
T4b_1642007029_client_41', attrs=3D{}), entry4(cookie=3D326, name=3Db'owner=
_REBT4b_1642007029_client_42', attrs=3D{}), entry4(cookie=3D332, name=3Db'o=
wner_REBT4b_1642007029_client_43',
> >   attrs=3D{}), entry4(cookie=3D338, name=3Db'owner_REBT4b_1642007029_cl=
ient_44', attrs=3D{}), entry4(cookie=3D344, name=3Db'owner_REBT4b_164200702=
9_client_45', attrs=3D{}), entry4(cookie=3D350, name=3Db'owner_REBT4b_16420=
07029_client_46', attrs=3D{}), entry4(cookie=3D356, name=3Db'owner_REBT4b_1=
642007029_client_47', attrs=3D{}), entry4(cookie=3D362, name=3Db'owner_REBT=
4b_1642007029_client_48', attrs=3D{}), entry4(cookie=3D368, name=3Db'owner_=
REBT4b_1642007029_client_49', attrs=3D{}), entry4(cookie=3D374, name=3Db'ow=
ner_REBT4b_1642007029_client_50', attrs=3D{}), entry4(cookie=3D380, name=3D=
b'owner_REBT4b_1642007029_client_51', attrs=3D{}), entry4(cookie=3D386, nam=
e=3Db'owner_REBT4b_1642007029_client_52', attrs=3D{}), entry4(cookie=3D392,=
 name=3Db'owner_REBT4b_1642007029_client_53', attrs=3D{}), entry4(cookie=3D=
398, name=3Db'owner_REBT4b_1642007029_client_54', attrs=3D{}), entry4(cooki=
e=3D404, name=3Db'owner_REBT4b_1642007029_client_55', attrs=3D{}), entry4(c=
ookie=3D410, name=3Db'owner_REBT4b_1642007029_client_56', attrs=3D{}), entr=
y4(cookie=3D416, name=3Db'owner_REBT
> >  4b_1642007029_client_57', attrs=3D{}), entry4(cookie=3D422, name=3Db'o=
wner_REBT4b_1642007029_client_58', attrs=3D{}), entry4(cookie=3D428, name=
=3Db'owner_REBT4b_1642007029_client_59', attrs=3D{}), entry4(cookie=3D434, =
name=3Db'owner_REBT4b_1642007029_client_60', attrs=3D{}), entry4(cookie=3D4=
40, name=3Db'owner_REBT4b_1642007029_client_61', attrs=3D{}), entry4(cookie=
=3D446, name=3Db'owner_REBT4b_1642007029_client_62', attrs=3D{}), entry4(co=
okie=3D452, name=3Db'owner_REBT4b_1642007029_client_63', attrs=3D{}), entry=
4(cookie=3D458, name=3Db'owner_REBT4b_1642007029_client_64', attrs=3D{}), e=
ntry4(cookie=3D464, name=3Db'owner_REBT4b_1642007029_client_65', attrs=3D{}=
), entry4(cookie=3D470, name=3Db'owner_REBT4b_1642007029_client_66', attrs=
=3D{}), entry4(cookie=3D476, name=3Db'owner_REBT4b_1642007029_client_67', a=
ttrs=3D{}), entry4(cookie=3D482, name=3Db'owner_REBT4b_1642007029_client_68=
', attrs=3D{}), entry4(cookie=3D488, name=3Db'owner_REBT4b_1642007029_clien=
t_69', attrs=3D{}), entry4(cookie=3D494, name=3Db'owner_REBT4b_1642007029_c=
lient_70', attrs=3D{}), entry4(cook
> >  ie=3D500, name=3Db'owner_REBT4b_1642007029_client_71', attrs=3D{}), en=
try4(cookie=3D506, name=3Db'owner_REBT4b_1642007029_client_72', attrs=3D{})=
, entry4(cookie=3D520, name=3Db'owner_REBT4b_1642007029_client_73', attrs=
=3D{}), entry4(cookie=3D526, name=3Db'owner_REBT4b_1642007029_client_74', a=
ttrs=3D{}), entry4(cookie=3D532, name=3Db'owner_REBT4b_1642007029_client_75=
', attrs=3D{}), entry4(cookie=3D538, name=3Db'owner_REBT4b_1642007029_clien=
t_76', attrs=3D{}), entry4(cookie=3D544, name=3Db'owner_REBT4b_1642007029_c=
lient_77', attrs=3D{}), entry4(cookie=3D550, name=3Db'owner_REBT4b_16420070=
29_client_78', attrs=3D{}), entry4(cookie=3D556, name=3Db'owner_REBT4b_1642=
007029_client_79', attrs=3D{}), entry4(cookie=3D562, name=3Db'owner_REBT4b_=
1642007029_client_80', attrs=3D{}), entry4(cookie=3D568, name=3Db'owner_REB=
T4b_1642007029_client_81', attrs=3D{}), entry4(cookie=3D574, name=3Db'owner=
_REBT4b_1642007029_client_82', attrs=3D{}), entry4(cookie=3D580, name=3Db'o=
wner_REBT4b_1642007029_client_83', attrs=3D{}), entry4(cookie=3D586, name=
=3Db'owner_REBT4b_1642007029_client_84
> >  ', attrs=3D{}), entry4(cookie=3D592, name=3Db'owner_REBT4b_1642007029_=
client_85', attrs=3D{}), entry4(cookie=3D598, name=3Db'owner_REBT4b_1642007=
029_client_86', attrs=3D{}), entry4(cookie=3D604, name=3Db'owner_REBT4b_164=
2007029_client_87', attrs=3D{}), entry4(cookie=3D610, name=3Db'owner_REBT4b=
_1642007029_client_88', attrs=3D{}), entry4(cookie=3D616, name=3Db'owner_RE=
BT4b_1642007029_client_89', attrs=3D{}), entry4(cookie=3D622, name=3Db'owne=
r_REBT4b_1642007029_client_90', attrs=3D{}), entry4(cookie=3D628, name=3Db'=
owner_REBT4b_1642007029_client_91', attrs=3D{}), entry4(cookie=3D634, name=
=3Db'owner_REBT4b_1642007029_client_92', attrs=3D{}), entry4(cookie=3D640, =
name=3Db'owner_REBT4b_1642007029_client_93', attrs=3D{}), entry4(cookie=3D6=
46, name=3Db'owner_REBT4b_1642007029_client_94', attrs=3D{}), entry4(cookie=
=3D652, name=3Db'owner_REBT4b_1642007029_client_95', attrs=3D{}), entry4(co=
okie=3D658, name=3Db'owner_REBT4b_1642007029_client_96', attrs=3D{}), entry=
4(cookie=3D664, name=3Db'owner_REBT4b_1642007029_client_97', attrs=3D{}), e=
ntry4(cookie=3D670, name=3Db'owner_RE
> >  BT4b_1642007029_client_98', attrs=3D{}), entry4(cookie=3D676, name=3Db=
'owner_REBT4b_1642007029_client_99', attrs=3D{}), entry4(cookie=3D682, name=
=3Db'owner_REBT2b_1642007029_client_0', attrs=3D{}), entry4(cookie=3D688, n=
ame=3Db'owner_REBT2b_1642007029_client_1', attrs=3D{}), entry4(cookie=3D694=
, name=3Db'owner_REBT2b_1642007029_client_2', attrs=3D{}), entry4(cookie=3D=
700, name=3Db'owner_REBT2b_1642007029_client_3', attrs=3D{}), entry4(cookie=
=3D706, name=3Db'owner_REBT2b_1642007029_client_4', attrs=3D{}), entry4(coo=
kie=3D712, name=3Db'owner_REBT2b_1642007029_client_5', attrs=3D{}), entry4(=
cookie=3D718, name=3Db'owner_REBT2b_1642007029_client_6', attrs=3D{}), entr=
y4(cookie=3D724, name=3Db'owner_REBT2b_1642007029_client_7', attrs=3D{}), e=
ntry4(cookie=3D730, name=3Db'owner_REBT2b_1642007029_client_8', attrs=3D{})=
, entry4(cookie=3D736, name=3Db'owner_REBT2b_1642007029_client_9', attrs=3D=
{}), entry4(cookie=3D742, name=3Db'owner_REBT2b_1642007029_client_10', attr=
s=3D{}), entry4(cookie=3D748, name=3Db'owner_REBT2b_1642007029_client_11', =
attrs=3D{}), entry4(cookie=3D754,
> >  name=3Db'owner_REBT2b_1642007029_client_12', attrs=3D{}), entry4(cooki=
e=3D760, name=3Db'owner_REBT2b_1642007029_client_13', attrs=3D{}), entry4(c=
ookie=3D766, name=3Db'owner_REBT2b_1642007029_client_14', attrs=3D{}), entr=
y4(cookie=3D772, name=3Db'owner_REBT2b_1642007029_client_15', attrs=3D{}), =
entry4(cookie=3D778, name=3Db'owner_REBT2b_1642007029_client_16', attrs=3D{=
}), entry4(cookie=3D784, name=3Db'owner_REBT2b_1642007029_client_17', attrs=
=3D{}), entry4(cookie=3D790, name=3Db'owner_REBT2b_1642007029_client_18', a=
ttrs=3D{}), entry4(cookie=3D796, name=3Db'owner_REBT2b_1642007029_client_19=
', attrs=3D{}), entry4(cookie=3D802, name=3Db'owner_REBT2b_1642007029_clien=
t_20', attrs=3D{}), entry4(cookie=3D808, name=3Db'owner_REBT2b_1642007029_c=
lient_21', attrs=3D{}), entry4(cookie=3D814, name=3Db'owner_REBT2b_16420070=
29_client_22', attrs=3D{}), entry4(cookie=3D820, name=3Db'owner_REBT2b_1642=
007029_client_23', attrs=3D{}), entry4(cookie=3D826, name=3Db'owner_REBT2b_=
1642007029_client_24', attrs=3D{}), entry4(cookie=3D832, name=3Db'owner_REB=
T2b_1642007029_client_25', attrs
> >  =3D{}), entry4(cookie=3D838, name=3Db'owner_REBT2b_1642007029_client_2=
6', attrs=3D{}), entry4(cookie=3D844, name=3Db'owner_REBT2b_1642007029_clie=
nt_27', attrs=3D{}), entry4(cookie=3D850, name=3Db'owner_REBT2b_1642007029_=
client_28', attrs=3D{}), entry4(cookie=3D856, name=3Db'owner_REBT2b_1642007=
029_client_29', attrs=3D{}), entry4(cookie=3D862, name=3Db'owner_REBT2b_164=
2007029_client_30', attrs=3D{}), entry4(cookie=3D868, name=3Db'owner_REBT2b=
_1642007029_client_31', attrs=3D{}), entry4(cookie=3D874, name=3Db'owner_RE=
BT2b_1642007029_client_32', attrs=3D{}), entry4(cookie=3D880, name=3Db'owne=
r_REBT2b_1642007029_client_33', attrs=3D{}), entry4(cookie=3D886, name=3Db'=
owner_REBT2b_1642007029_client_34', attrs=3D{}), entry4(cookie=3D892, name=
=3Db'owner_REBT2b_1642007029_client_35', attrs=3D{}), entry4(cookie=3D898, =
name=3Db'owner_REBT2b_1642007029_client_36', attrs=3D{}), entry4(cookie=3D9=
04, name=3Db'owner_REBT2b_1642007029_client_37', attrs=3D{}), entry4(cookie=
=3D910, name=3Db'owner_REBT2b_1642007029_client_38', attrs=3D{}), entry4(co=
okie=3D916, name=3Db'owner_REBT2b_164
> >  2007029_client_39', attrs=3D{}), entry4(cookie=3D922, name=3Db'owner_R=
EBT2b_1642007029_client_40', attrs=3D{}), entry4(cookie=3D928, name=3Db'own=
er_REBT2b_1642007029_client_41', attrs=3D{}), entry4(cookie=3D934, name=3Db=
'owner_REBT2b_1642007029_client_42', attrs=3D{}), entry4(cookie=3D940, name=
=3Db'owner_REBT2b_1642007029_client_43', attrs=3D{}), entry4(cookie=3D946, =
name=3Db'owner_REBT2b_1642007029_client_44', attrs=3D{}), entry4(cookie=3D9=
52, name=3Db'owner_REBT2b_1642007029_client_45', attrs=3D{}), entry4(cookie=
=3D958, name=3Db'owner_REBT2b_1642007029_client_46', attrs=3D{}), entry4(co=
okie=3D964, name=3Db'owner_REBT2b_1642007029_client_47', attrs=3D{}), entry=
4(cookie=3D970, name=3Db'owner_REBT2b_1642007029_client_48', attrs=3D{}), e=
ntry4(cookie=3D976, name=3Db'owner_REBT2b_1642007029_client_49', attrs=3D{}=
), entry4(cookie=3D982, name=3Db'owner_REBT2b_1642007029_client_50', attrs=
=3D{}), entry4(cookie=3D988, name=3Db'owner_REBT2b_1642007029_client_51', a=
ttrs=3D{}), entry4(cookie=3D994, name=3Db'owner_REBT2b_1642007029_client_52=
', attrs=3D{}), entry4(cookie=3D100
> >  0, name=3Db'owner_REBT2b_1642007029_client_53', attrs=3D{}), entry4(co=
okie=3D1006, name=3Db'owner_REBT2b_1642007029_client_54', attrs=3D{}), entr=
y4(cookie=3D1012, name=3Db'owner_REBT2b_1642007029_client_55', attrs=3D{}),=
 entry4(cookie=3D1018, name=3Db'owner_REBT2b_1642007029_client_56', attrs=
=3D{}), entry4(cookie=3D1032, name=3Db'owner_REBT2b_1642007029_client_57', =
attrs=3D{}), entry4(cookie=3D1038, name=3Db'owner_REBT2b_1642007029_client_=
58', attrs=3D{}), entry4(cookie=3D1044, name=3Db'owner_REBT2b_1642007029_cl=
ient_59', attrs=3D{}), entry4(cookie=3D1050, name=3Db'owner_REBT2b_16420070=
29_client_60', attrs=3D{}), entry4(cookie=3D1056, name=3Db'owner_REBT2b_164=
2007029_client_61', attrs=3D{}), entry4(cookie=3D1062, name=3Db'owner_REBT2=
b_1642007029_client_62', attrs=3D{}), entry4(cookie=3D1068, name=3Db'owner_=
REBT2b_1642007029_client_63', attrs=3D{}), entry4(cookie=3D1074, name=3Db'o=
wner_REBT2b_1642007029_client_64', attrs=3D{}), entry4(cookie=3D1080, name=
=3Db'owner_REBT2b_1642007029_client_65', attrs=3D{}), entry4(cookie=3D1086,=
 name=3Db'owner_REBT2b_1642007029_c
> >  lient_66', attrs=3D{}), entry4(cookie=3D1092, name=3Db'owner_REBT2b_16=
42007029_client_67', attrs=3D{}), entry4(cookie=3D1098, name=3Db'owner_REBT=
2b_1642007029_client_68', attrs=3D{}), entry4(cookie=3D1104, name=3Db'owner=
_REBT2b_1642007029_client_69', attrs=3D{}), entry4(cookie=3D1110, name=3Db'=
owner_REBT2b_1642007029_client_70', attrs=3D{}), entry4(cookie=3D1116, name=
=3Db'owner_REBT2b_1642007029_client_71', attrs=3D{}), entry4(cookie=3D1122,=
 name=3Db'owner_REBT2b_1642007029_client_72', attrs=3D{}), entry4(cookie=3D=
1128, name=3Db'owner_REBT2b_1642007029_client_73', attrs=3D{}), entry4(cook=
ie=3D1134, name=3Db'owner_REBT2b_1642007029_client_74', attrs=3D{}), entry4=
(cookie=3D1140, name=3Db'owner_REBT2b_1642007029_client_75', attrs=3D{}), e=
ntry4(cookie=3D1146, name=3Db'owner_REBT2b_1642007029_client_76', attrs=3D{=
}), entry4(cookie=3D1152, name=3Db'owner_REBT2b_1642007029_client_77', attr=
s=3D{}), entry4(cookie=3D1158, name=3Db'owner_REBT2b_1642007029_client_78',=
 attrs=3D{}), entry4(cookie=3D1164, name=3Db'owner_REBT2b_1642007029_client=
_79', attrs=3D{}), entry4(cookie
> >  =3D1170, name=3Db'owner_REBT2b_1642007029_client_80', attrs=3D{}), ent=
ry4(cookie=3D1176, name=3Db'owner_REBT2b_1642007029_client_81', attrs=3D{})=
, entry4(cookie=3D1182, name=3Db'owner_REBT2b_1642007029_client_82', attrs=
=3D{}), entry4(cookie=3D1188, name=3Db'owner_REBT2b_1642007029_client_83', =
attrs=3D{}), entry4(cookie=3D1194, name=3Db'owner_REBT2b_1642007029_client_=
84', attrs=3D{}), entry4(cookie=3D1200, name=3Db'owner_REBT2b_1642007029_cl=
ient_85', attrs=3D{}), entry4(cookie=3D1206, name=3Db'owner_REBT2b_16420070=
29_client_86', attrs=3D{}), entry4(cookie=3D1212, name=3Db'owner_REBT2b_164=
2007029_client_87', attrs=3D{}), entry4(cookie=3D1218, name=3Db'owner_REBT2=
b_1642007029_client_88', attrs=3D{}), entry4(cookie=3D1224, name=3Db'owner_=
REBT2b_1642007029_client_89', attrs=3D{}), entry4(cookie=3D1230, name=3Db'o=
wner_REBT2b_1642007029_client_90', attrs=3D{}), entry4(cookie=3D1236, name=
=3Db'owner_REBT2b_1642007029_client_91', attrs=3D{}), entry4(cookie=3D1242,=
 name=3Db'owner_REBT2b_1642007029_client_92', attrs=3D{}), entry4(cookie=3D=
1248, name=3Db'owner_REBT2b_16420070
> >  29_client_93', attrs=3D{}), entry4(cookie=3D1254, name=3Db'owner_REBT2=
b_1642007029_client_94', attrs=3D{}), entry4(cookie=3D1260, name=3Db'owner_=
REBT2b_1642007029_client_95', attrs=3D{}), entry4(cookie=3D1266, name=3Db'o=
wner_REBT2b_1642007029_client_96', attrs=3D{}), entry4(cookie=3D1272, name=
=3Db'owner_REBT2b_1642007029_client_97', attrs=3D{}), entry4(cookie=3D1278,=
 name=3Db'owner_REBT2b_1642007029_client_98', attrs=3D{}), entry4(cookie=3D=
1284, name=3Db'owner_REBT2b_1642007029_client_99', attrs=3D{}), entry4(cook=
ie=3D1290, name=3Db'owner_REBT4a_1642007029_client_0', attrs=3D{}), entry4(=
cookie=3D1296, name=3Db'owner_REBT4a_1642007029_client_1', attrs=3D{}), ent=
ry4(cookie=3D1302, name=3Db'owner_REBT4a_1642007029_client_2', attrs=3D{}),=
 entry4(cookie=3D1308, name=3Db'owner_REBT4a_1642007029_client_3', attrs=3D=
{}), entry4(cookie=3D1314, name=3Db'owner_REBT4a_1642007029_client_4', attr=
s=3D{}), entry4(cookie=3D1320, name=3Db'owner_REBT4a_1642007029_client_5', =
attrs=3D{}), entry4(cookie=3D1326, name=3Db'owner_REBT4a_1642007029_client_=
6', attrs=3D{}), entry4(cookie=3D13
> >  32, name=3Db'owner_REBT4a_1642007029_client_7', attrs=3D{}), entry4(co=
okie=3D1338, name=3Db'owner_REBT4a_1642007029_client_8', attrs=3D{}), entry=
4(cookie=3D1344, name=3Db'owner_REBT4a_1642007029_client_9', attrs=3D{}), e=
ntry4(cookie=3D1350, name=3Db'owner_REBT2a_1642007029_client_0', attrs=3D{}=
), entry4(cookie=3D1356, name=3Db'owner_REBT2a_1642007029_client_1', attrs=
=3D{}), entry4(cookie=3D1362, name=3Db'owner_REBT2a_1642007029_client_2', a=
ttrs=3D{}), entry4(cookie=3D1368, name=3Db'owner_REBT2a_1642007029_client_3=
', attrs=3D{}), entry4(cookie=3D1374, name=3Db'owner_REBT2a_1642007029_clie=
nt_4', attrs=3D{}), entry4(cookie=3D1380, name=3Db'owner_REBT2a_1642007029_=
client_5', attrs=3D{}), entry4(cookie=3D1386, name=3Db'owner_REBT2a_1642007=
029_client_6', attrs=3D{}), entry4(cookie=3D1392, name=3Db'owner_REBT2a_164=
2007029_client_7', attrs=3D{}), entry4(cookie=3D1398, name=3Db'owner_REBT2a=
_1642007029_client_8', attrs=3D{}), entry4(cookie=3D1404, name=3Db'owner_RE=
BT2a_1642007029_client_9', attrs=3D{}), entry4(cookie=3D1410, name=3Db'owne=
r_REBT5_1642007029_client_file_0'
> >  , attrs=3D{}), entry4(cookie=3D1416, name=3Db'owner_REBT5_1642007029_c=
lient_file_1', attrs=3D{}), entry4(cookie=3D1422, name=3Db'owner_REBT5_1642=
007029_client_file_2', attrs=3D{}), entry4(cookie=3D1428, name=3Db'owner_RE=
BT5_1642007029_client_file_3', attrs=3D{}), entry4(cookie=3D1434, name=3Db'=
owner_REBT5_1642007029_client_file_4', attrs=3D{}), entry4(cookie=3D1440, n=
ame=3Db'owner_REBT5_1642007029_client_file_5', attrs=3D{}), entry4(cookie=
=3D1446, name=3Db'owner_REBT5_1642007029_client_file_6', attrs=3D{}), entry=
4(cookie=3D1452, name=3Db'owner_REBT5_1642007029_client_file_7', attrs=3D{}=
), entry4(cookie=3D1458, name=3Db'owner_REBT5_1642007029_client_file_8', at=
trs=3D{}), entry4(cookie=3D1464, name=3Db'owner_REBT5_1642007029_client_fil=
e_9', attrs=3D{}), entry4(cookie=3D1471, name=3Db'owner_REBT5_1642007029_cl=
ient_file_10', attrs=3D{}), entry4(cookie=3D1478, name=3Db'owner_REBT5_1642=
007029_client_file_11', attrs=3D{}), entry4(cookie=3D1485, name=3Db'owner_R=
EBT5_1642007029_client_file_12', attrs=3D{}), entry4(cookie=3D1492, name=3D=
b'owner_REBT5_1642007029_client_
> >  file_13', attrs=3D{}), entry4(cookie=3D1499, name=3Db'owner_REBT5_1642=
007029_client_file_14', attrs=3D{}), entry4(cookie=3D1506, name=3Db'owner_R=
EBT5_1642007029_client_file_15', attrs=3D{}), entry4(cookie=3D1513, name=3D=
b'owner_REBT5_1642007029_client_file_16', attrs=3D{}), entry4(cookie=3D1520=
, name=3Db'owner_REBT5_1642007029_client_file_17', attrs=3D{}), entry4(cook=
ie=3D1527, name=3Db'owner_REBT5_1642007029_client_file_18', attrs=3D{}), en=
try4(cookie=3D1544, name=3Db'owner_REBT5_1642007029_client_file_19', attrs=
=3D{}), entry4(cookie=3D1551, name=3Db'owner_REBT5_1642007029_client_file_2=
0', attrs=3D{}), entry4(cookie=3D1558, name=3Db'owner_REBT5_1642007029_clie=
nt_file_21', attrs=3D{}), entry4(cookie=3D1565, name=3Db'owner_REBT5_164200=
7029_client_file_22', attrs=3D{}), entry4(cookie=3D1572, name=3Db'owner_REB=
T5_1642007029_client_file_23', attrs=3D{}), entry4(cookie=3D1579, name=3Db'=
owner_REBT5_1642007029_client_file_24', attrs=3D{}), entry4(cookie=3D1586, =
name=3Db'owner_REBT5_1642007029_client_file_25', attrs=3D{}), entry4(cookie=
=3D1593, name=3Db'owner_REBT5_1
> >  642007029_client_file_26', attrs=3D{}), entry4(cookie=3D1600, name=3Db=
'owner_REBT5_1642007029_client_file_27', attrs=3D{}), entry4(cookie=3D1607,=
 name=3Db'owner_REBT5_1642007029_client_file_28', attrs=3D{}), entry4(cooki=
e=3D1614, name=3Db'owner_REBT5_1642007029_client_file_29', attrs=3D{}), ent=
ry4(cookie=3D1621, name=3Db'owner_REBT5_1642007029_client_file_30', attrs=
=3D{}), entry4(cookie=3D1628, name=3Db'owner_REBT5_1642007029_client_file_3=
1', attrs=3D{}), entry4(cookie=3D1635, name=3Db'owner_REBT5_1642007029_clie=
nt_file_32', attrs=3D{}), entry4(cookie=3D1642, name=3Db'owner_REBT5_164200=
7029_client_file_33', attrs=3D{}), entry4(cookie=3D1649, name=3Db'owner_REB=
T5_1642007029_client_file_34', attrs=3D{}), entry4(cookie=3D1656, name=3Db'=
owner_REBT5_1642007029_client_file_35', attrs=3D{}), entry4(cookie=3D1663, =
name=3Db'owner_REBT5_1642007029_client_file_36', attrs=3D{}), entry4(cookie=
=3D1670, name=3Db'owner_REBT5_1642007029_client_file_37', attrs=3D{}), entr=
y4(cookie=3D1677, name=3Db'owner_REBT5_1642007029_client_file_38', attrs=3D=
{}), entry4(cookie=3D1684, nam
> >  e=3Db'owner_REBT5_1642007029_client_file_39', attrs=3D{}), entry4(cook=
ie=3D1691, name=3Db'owner_REBT5_1642007029_client_file_40', attrs=3D{}), en=
try4(cookie=3D1698, name=3Db'owner_REBT5_1642007029_client_file_41', attrs=
=3D{}), entry4(cookie=3D1703, name=3Db'owner_REBT1_1642007029', attrs=3D{})=
, entry4(cookie=3D1709, name=3Db'owner_REBT3b_1642007029_client_0', attrs=
=3D{}), entry4(cookie=3D1715, name=3Db'owner_REBT3b_1642007029_client_1', a=
ttrs=3D{}), entry4(cookie=3D1721, name=3Db'owner_REBT3b_1642007029_client_2=
', attrs=3D{}), entry4(cookie=3D1727, name=3Db'owner_REBT3b_1642007029_clie=
nt_3', attrs=3D{}), entry4(cookie=3D1733, name=3Db'owner_REBT3b_1642007029_=
client_4', attrs=3D{}), entry4(cookie=3D1739, name=3Db'owner_REBT3b_1642007=
029_client_5', attrs=3D{}), entry4(cookie=3D1745, name=3Db'owner_REBT3b_164=
2007029_client_6', attrs=3D{}), entry4(cookie=3D1751, name=3Db'owner_REBT3b=
_1642007029_client_7', attrs=3D{}), entry4(cookie=3D1757, name=3Db'owner_RE=
BT3b_1642007029_client_8', attrs=3D{}), entry4(cookie=3D1763, name=3Db'owne=
r_REBT3b_1642007029_client_9', attr
> >  s=3D{}), entry4(cookie=3D1769, name=3Db'owner_REBT3b_1642007029_client=
_10', attrs=3D{}), entry4(cookie=3D1775, name=3Db'owner_REBT3b_1642007029_c=
lient_11', attrs=3D{}), entry4(cookie=3D1781, name=3Db'owner_REBT3b_1642007=
029_client_12', attrs=3D{}), entry4(cookie=3D1787, name=3Db'owner_REBT3b_16=
42007029_client_13', attrs=3D{}), entry4(cookie=3D1793, name=3Db'owner_REBT=
3b_1642007029_client_14', attrs=3D{}), entry4(cookie=3D1799, name=3Db'owner=
_REBT3b_1642007029_client_15', attrs=3D{}), entry4(cookie=3D1805, name=3Db'=
owner_REBT3b_1642007029_client_16', attrs=3D{}), entry4(cookie=3D1811, name=
=3Db'owner_REBT3b_1642007029_client_17', attrs=3D{}), entry4(cookie=3D1817,=
 name=3Db'owner_REBT3b_1642007029_client_18', attrs=3D{}), entry4(cookie=3D=
1823, name=3Db'owner_REBT3b_1642007029_client_19', attrs=3D{}), entry4(cook=
ie=3D1829, name=3Db'owner_REBT3b_1642007029_client_20', attrs=3D{}), entry4=
(cookie=3D1835, name=3Db'owner_REBT3b_1642007029_client_21', attrs=3D{}), e=
ntry4(cookie=3D1841, name=3Db'owner_REBT3b_1642007029_client_22', attrs=3D{=
}), entry4(cookie=3D1847, name=3Db'o
> >  wner_REBT3b_1642007029_client_23', attrs=3D{}), entry4(cookie=3D1853, =
name=3Db'owner_REBT3b_1642007029_client_24', attrs=3D{}), entry4(cookie=3D1=
859, name=3Db'owner_REBT3b_1642007029_client_25', attrs=3D{}), entry4(cooki=
e=3D1865, name=3Db'owner_REBT3b_1642007029_client_26', attrs=3D{}), entry4(=
cookie=3D1871, name=3Db'owner_REBT3b_1642007029_client_27', attrs=3D{}), en=
try4(cookie=3D1877, name=3Db'owner_REBT3b_1642007029_client_28', attrs=3D{}=
), entry4(cookie=3D1883, name=3Db'owner_REBT3b_1642007029_client_29', attrs=
=3D{}), entry4(cookie=3D1889, name=3Db'owner_REBT3b_1642007029_client_30', =
attrs=3D{}), entry4(cookie=3D1895, name=3Db'owner_REBT3b_1642007029_client_=
31', attrs=3D{}), entry4(cookie=3D1901, name=3Db'owner_REBT3b_1642007029_cl=
ient_32', attrs=3D{}), entry4(cookie=3D1907, name=3Db'owner_REBT3b_16420070=
29_client_33', attrs=3D{}), entry4(cookie=3D1913, name=3Db'owner_REBT3b_164=
2007029_client_34', attrs=3D{}), entry4(cookie=3D1919, name=3Db'owner_REBT3=
b_1642007029_client_35', attrs=3D{}), entry4(cookie=3D1925, name=3Db'owner_=
REBT3b_1642007029_client_36',
> >  attrs=3D{}), entry4(cookie=3D1931, name=3Db'owner_REBT3b_1642007029_cl=
ient_37', attrs=3D{}), entry4(cookie=3D1937, name=3Db'owner_REBT3b_16420070=
29_client_38', attrs=3D{}), entry4(cookie=3D1943, name=3Db'owner_REBT3b_164=
2007029_client_39', attrs=3D{}), entry4(cookie=3D1949, name=3Db'owner_REBT3=
b_1642007029_client_40', attrs=3D{}), entry4(cookie=3D1955, name=3Db'owner_=
REBT3b_1642007029_client_41', attrs=3D{}), entry4(cookie=3D1961, name=3Db'o=
wner_REBT3b_1642007029_client_42', attrs=3D{}), entry4(cookie=3D1967, name=
=3Db'owner_REBT3b_1642007029_client_43', attrs=3D{}), entry4(cookie=3D1973,=
 name=3Db'owner_REBT3b_1642007029_client_44', attrs=3D{}), entry4(cookie=3D=
1979, name=3Db'owner_REBT3b_1642007029_client_45', attrs=3D{}), entry4(cook=
ie=3D1985, name=3Db'owner_REBT3b_1642007029_client_46', attrs=3D{}), entry4=
(cookie=3D1991, name=3Db'owner_REBT3b_1642007029_client_47', attrs=3D{}), e=
ntry4(cookie=3D1997, name=3Db'owner_REBT3b_1642007029_client_48', attrs=3D{=
}), entry4(cookie=3D2003, name=3Db'owner_REBT3b_1642007029_client_49', attr=
s=3D{}), entry4(cookie=3D2009, name
> >  =3Db'owner_REBT3b_1642007029_client_50', attrs=3D{}), entry4(cookie=3D=
2015, name=3Db'owner_REBT3b_1642007029_client_51', attrs=3D{}), entry4(cook=
ie=3D2021, name=3Db'owner_REBT3b_1642007029_client_52', attrs=3D{}), entry4=
(cookie=3D2027, name=3Db'owner_REBT3b_1642007029_client_53', attrs=3D{}), e=
ntry4(cookie=3D2033, name=3Db'owner_REBT3b_1642007029_client_54', attrs=3D{=
}), entry4(cookie=3D2039, name=3Db'owner_REBT3b_1642007029_client_55', attr=
s=3D{}), entry4(cookie=3D2056, name=3Db'owner_REBT3b_1642007029_client_56',=
 attrs=3D{}), entry4(cookie=3D2062, name=3Db'owner_REBT3b_1642007029_client=
_57', attrs=3D{}), entry4(cookie=3D2068, name=3Db'owner_REBT3b_1642007029_c=
lient_58', attrs=3D{}), entry4(cookie=3D2074, name=3Db'owner_REBT3b_1642007=
029_client_59', attrs=3D{}), entry4(cookie=3D2080, name=3Db'owner_REBT3b_16=
42007029_client_60', attrs=3D{}), entry4(cookie=3D2086, name=3Db'owner_REBT=
3b_1642007029_client_61', attrs=3D{}), entry4(cookie=3D2092, name=3Db'owner=
_REBT3b_1642007029_client_62', attrs=3D{}), entry4(cookie=3D2098, name=3Db'=
owner_REBT3b_1642007029_client_6
> >  3', attrs=3D{}), entry4(cookie=3D2104, name=3Db'owner_REBT3b_164200702=
9_client_64', attrs=3D{}), entry4(cookie=3D2110, name=3Db'owner_REBT3b_1642=
007029_client_65', attrs=3D{}), entry4(cookie=3D2116, name=3Db'owner_REBT3b=
_1642007029_client_66', attrs=3D{}), entry4(cookie=3D2122, name=3Db'owner_R=
EBT3b_1642007029_client_67', attrs=3D{}), entry4(cookie=3D2128, name=3Db'ow=
ner_REBT3b_1642007029_client_68', attrs=3D{}), entry4(cookie=3D2134, name=
=3Db'owner_REBT3b_1642007029_client_69', attrs=3D{}), entry4(cookie=3D2140,=
 name=3Db'owner_REBT3b_1642007029_client_70', attrs=3D{}), entry4(cookie=3D=
2146, name=3Db'owner_REBT3b_1642007029_client_71', attrs=3D{}), entry4(cook=
ie=3D2152, name=3Db'owner_REBT3b_1642007029_client_72', attrs=3D{}), entry4=
(cookie=3D2158, name=3Db'owner_REBT3b_1642007029_client_73', attrs=3D{}), e=
ntry4(cookie=3D2164, name=3Db'owner_REBT3b_1642007029_client_74', attrs=3D{=
}), entry4(cookie=3D2170, name=3Db'owner_REBT3b_1642007029_client_75', attr=
s=3D{}), entry4(cookie=3D2176, name=3Db'owner_REBT3b_1642007029_client_76',=
 attrs=3D{}), entry4(cookie=3D2182,
> >  name=3Db'owner_REBT3b_1642007029_client_77', attrs=3D{}), entry4(cooki=
e=3D2188, name=3Db'owner_REBT3b_1642007029_client_78', attrs=3D{}), entry4(=
cookie=3D2194, name=3Db'owner_REBT3b_1642007029_client_79', attrs=3D{}), en=
try4(cookie=3D2200, name=3Db'owner_REBT3b_1642007029_client_80', attrs=3D{}=
), entry4(cookie=3D2206, name=3Db'owner_REBT3b_1642007029_client_81', attrs=
=3D{}), entry4(cookie=3D2212, name=3Db'owner_REBT3b_1642007029_client_82', =
attrs=3D{}), entry4(cookie=3D2218, name=3Db'owner_REBT3b_1642007029_client_=
83', attrs=3D{}), entry4(cookie=3D2224, name=3Db'owner_REBT3b_1642007029_cl=
ient_84', attrs=3D{}), entry4(cookie=3D2230, name=3Db'owner_REBT3b_16420070=
29_client_85', attrs=3D{}), entry4(cookie=3D2236, name=3Db'owner_REBT3b_164=
2007029_client_86', attrs=3D{}), entry4(cookie=3D2242, name=3Db'owner_REBT3=
b_1642007029_client_87', attrs=3D{}), entry4(cookie=3D2248, name=3Db'owner_=
REBT3b_1642007029_client_88', attrs=3D{}), entry4(cookie=3D2254, name=3Db'o=
wner_REBT3b_1642007029_client_89', attrs=3D{}), entry4(cookie=3D2260, name=
=3Db'owner_REBT3b_1642007029_clie
> >  nt_90', attrs=3D{}), entry4(cookie=3D2266, name=3Db'owner_REBT3b_16420=
07029_client_91', attrs=3D{}), entry4(cookie=3D2272, name=3Db'owner_REBT3b_=
1642007029_client_92', attrs=3D{}), entry4(cookie=3D2278, name=3Db'owner_RE=
BT3b_1642007029_client_93', attrs=3D{}), entry4(cookie=3D2284, name=3Db'own=
er_REBT3b_1642007029_client_94', attrs=3D{}), entry4(cookie=3D2290, name=3D=
b'owner_REBT3b_1642007029_client_95', attrs=3D{}), entry4(cookie=3D2296, na=
me=3Db'owner_REBT3b_1642007029_client_96', attrs=3D{}), entry4(cookie=3D230=
2, name=3Db'owner_REBT3b_1642007029_client_97', attrs=3D{}), entry4(cookie=
=3D2308, name=3Db'owner_REBT3b_1642007029_client_98', attrs=3D{}), entry4(c=
ookie=3D2314, name=3Db'owner_REBT3b_1642007029_client_99', attrs=3D{}), ent=
ry4(cookie=3D2320, name=3Db'owner_REBT3a_1642007029_client_0', attrs=3D{}),=
 entry4(cookie=3D2326, name=3Db'owner_REBT3a_1642007029_client_1', attrs=3D=
{}), entry4(cookie=3D2332, name=3Db'owner_REBT3a_1642007029_client_2', attr=
s=3D{}), entry4(cookie=3D2338, name=3Db'owner_REBT3a_1642007029_client_3', =
attrs=3D{}), entry4(cookie=3D2344,
> >  name=3Db'owner_REBT3a_1642007029_client_4', attrs=3D{}), entry4(cookie=
=3D2350, name=3Db'owner_REBT3a_1642007029_client_5', attrs=3D{}), entry4(co=
okie=3D2356, name=3Db'owner_REBT3a_1642007029_client_6', attrs=3D{}), entry=
4(cookie=3D2362, name=3Db'owner_REBT3a_1642007029_client_7', attrs=3D{}), e=
ntry4(cookie=3D2368, name=3Db'owner_REBT3a_1642007029_client_8', attrs=3D{}=
), entry4(cookie=3D2374, name=3Db'owner_REBT3a_1642007029_client_9', attrs=
=3D{}), entry4(cookie=3D2378, name=3Db'RNM6_1642007029', attrs=3D{}), entry=
4(cookie=3D2382, name=3Db'RNM7_1642007029', attrs=3D{}), entry4(cookie=3D23=
86, name=3Db'RNM1s_1642007029', attrs=3D{}), entry4(cookie=3D2390, name=3Db=
'RNM1a_1642007029', attrs=3D{}), entry4(cookie=3D2394, name=3Db'RNM1r_16420=
07029', attrs=3D{}), entry4(cookie=3D2398, name=3Db'RNM1f_1642007029', attr=
s=3D{}), entry4(cookie=3D2402, name=3Db'RNM1d_1642007029', attrs=3D{}), ent=
ry4(cookie=3D2406, name=3Db'RNM19_1642007029', attrs=3D{}), entry4(cookie=
=3D2410, name=3Db'RNM18_1642007029', attrs=3D{}), entry4(cookie=3D2414, nam=
e=3Db'RNM5_1642007029', attrs=3D{}), entry4(cooki
> >  e=3D2418, name=3Db'RNM20_1642007029', attrs=3D{}), entry4(cookie=3D242=
2, name=3Db'RNM17_1642007029', attrs=3D{}), entry4(cookie=3D2426, name=3Db'=
RNM15_1642007029', attrs=3D{}), entry4(cookie=3D2430, name=3Db'RNM14_164200=
7029', attrs=3D{}), entry4(cookie=3D2434, name=3Db'RNM10_1642007029', attrs=
=3D{}), entry4(cookie=3D2438, name=3Db'RNM11_1642007029', attrs=3D{}), entr=
y4(cookie=3D2442, name=3Db'RNM12_1642007029', attrs=3D{}), entry4(cookie=3D=
2446, name=3Db'RNM16_1642007029', attrs=3D{}), entry4(cookie=3D2450, name=
=3Db'RNM13_1642007029', attrs=3D{}), entry4(cookie=3D2454, name=3Db'RNM3s_1=
642007029', attrs=3D{}), entry4(cookie=3D2458, name=3Db'RNM3a_1642007029', =
attrs=3D{}), entry4(cookie=3D2462, name=3Db'RNM3r_1642007029', attrs=3D{}),=
 entry4(cookie=3D2466, name=3Db'RNM3f_1642007029', attrs=3D{}), entry4(cook=
ie=3D2471, name=3Db'owner_DELEG9_1642007029', attrs=3D{}), entry4(cookie=3D=
2475, name=3Db'DELEG23_1642007029', attrs=3D{}), entry4(cookie=3D2479, name=
=3Db'DELEG1_1642007029', attrs=3D{}), entry4(cookie=3D2483, name=3Db'DELEG4=
_1642007029', attrs=3D{}), entry4(cookie=3D2487, name=3Db'DE
> >  LEG8_1642007029', attrs=3D{}), entry4(cookie=3D2491, name=3Db'DELEG6_1=
642007029', attrs=3D{}), entry4(cookie=3D2495, name=3Db'OPEN1_1642007029', =
attrs=3D{}), entry4(cookie=3D2499, name=3Db'OPEN2_1642007029', attrs=3D{}),=
 entry4(cookie=3D2503, name=3Db'OPEN30_1642007029', attrs=3D{}), entry4(coo=
kie=3D2507, name=3Db'OPEN7_1642007029', attrs=3D{}), entry4(cookie=3D2511, =
name=3Db'OPEN6_1642007029', attrs=3D{}), entry4(cookie=3D2515, name=3Db'OPE=
N8_1642007029', attrs=3D{}), entry4(cookie=3D2523, name=3Db'OPEN31_16420070=
29', attrs=3D{}), entry4(cookie=3D2531, name=3Db'SEQ10b_1642007029_2', attr=
s=3D{}), entry4(cookie=3D2535, name=3Db'SEQ9b_1642007029_2', attrs=3D{}), e=
ntry4(cookie=3D2539, name=3Db'SEC2_1642007029', attrs=3D{}), entry4(cookie=
=3D2543, name=3Db'SEC1_1642007029', attrs=3D{}), entry4(cookie=3D2560, name=
=3Db'owner_RECC2_1642007029', attrs=3D{})]
> >INFO   :test.env:Called do_readdir()
> >INFO   :test.env:do_readdir() =3D [entry4(cookie=3D14, name=3Db'dir1', a=
ttrs=3D{}), entry4(cookie=3D512, name=3Db'dir2', attrs=3D{})]
> >INFO   :test.env:Called do_readdir()
> >INFO   :test.env:do_readdir() =3D [entry4(cookie=3D512, name=3Db'bar', a=
ttrs=3D{})]
> >INFO   :test.env:Called do_readdir()
> >INFO   :test.env:do_readdir() =3D [entry4(cookie=3D14, name=3Db'dir1', a=
ttrs=3D{}), entry4(cookie=3D512, name=3Db'dir2', attrs=3D{})]
> >INFO   :test.env:Called do_readdir()
> >INFO   :test.env:do_readdir() =3D [entry4(cookie=3D512, name=3Db'bar', a=
ttrs=3D{})]
> >INFO   :test.env:Called do_readdir()
> >INFO   :test.env:do_readdir() =3D [entry4(cookie=3D14, name=3Db'dir1', a=
ttrs=3D{}), entry4(cookie=3D512, name=3Db'dir2', attrs=3D{})]
> >INFO   :test.env:Called do_readdir()
> >INFO   :test.env:do_readdir() =3D [entry4(cookie=3D512, name=3Db'bar', a=
ttrs=3D{})]
> >INFO   :test.env:Called do_readdir()
> >INFO   :test.env:do_readdir() =3D [entry4(cookie=3D14, name=3Db'dir1', a=
ttrs=3D{}), entry4(cookie=3D512, name=3Db'dir2', attrs=3D{})]
> >INFO   :test.env:Called do_readdir()
> >INFO   :test.env:do_readdir() =3D [entry4(cookie=3D512, name=3Db'bar', a=
ttrs=3D{})]
> >INFO   :test.env:Called do_readdir()
> >INFO   :test.env:do_readdir() =3D [entry4(cookie=3D14, name=3Db'dir1', a=
ttrs=3D{}), entry4(cookie=3D512, name=3Db'dir2', attrs=3D{})]
> >INFO   :test.env:Called do_readdir()
> >INFO   :test.env:do_readdir() =3D [entry4(cookie=3D512, name=3Db'bar', a=
ttrs=3D{})]
> >INFO   :test.env:Called do_readdir()
> >INFO   :test.env:do_readdir() =3D [entry4(cookie=3D14, name=3Db'file', a=
ttrs=3D{}), entry4(cookie=3D512, name=3Db'link', attrs=3D{})]
> >INFO   :test.env:Called do_readdir()
> >INFO   :test.env:do_readdir() =3D [entry4(cookie=3D14, name=3Db'file', a=
ttrs=3D{}), entry4(cookie=3D512, name=3Db'dir', attrs=3D{})]
> >INFO   :test.env:Called do_readdir()
> >INFO   :test.env:do_readdir() =3D [entry4(cookie=3D512, name=3Db'foo', a=
ttrs=3D{})]
> >INFO   :test.env:Called do_readdir()
> >INFO   :test.env:do_readdir() =3D [entry4(cookie=3D512, name=3Db'file2',=
 attrs=3D{})]
> >INFO   :test.env:Called do_readdir()
> >INFO   :test.env:do_readdir() =3D [entry4(cookie=3D14, name=3Db'dir', at=
trs=3D{}), entry4(cookie=3D512, name=3Db'file', attrs=3D{})]
> >INFO   :test.env:Called do_readdir()
> >INFO   :test.env:do_readdir() =3D [entry4(cookie=3D512, name=3Db'RNM10_1=
642007029', attrs=3D{})]
> >INFO   :test.env:Called do_readdir()
> >INFO   :test.env:do_readdir() =3D [entry4(cookie=3D512, name=3Db'RNM11_1=
642007029', attrs=3D{})]
> >INFO   :test.env:Called do_readdir()
> >INFO   :test.env:do_readdir() =3D [entry4(cookie=3D14, name=3Db'dir', at=
trs=3D{}), entry4(cookie=3D512, name=3Db'file', attrs=3D{})]
> >INFO   :test.env:Called do_readdir()
> >INFO   :test.env:do_readdir() =3D [entry4(cookie=3D14, name=3Db'dir1', a=
ttrs=3D{}), entry4(cookie=3D512, name=3Db'dir2', attrs=3D{})]
> >INFO   :test.env:Called do_readdir()
> >INFO   :test.env:do_readdir() =3D [entry4(cookie=3D512, name=3Db'foo', a=
ttrs=3D{})]
> >INFO   :test.env:Called do_readdir()
> >INFO   :test.env:do_readdir() =3D [entry4(cookie=3D512, name=3Db'dir2', =
attrs=3D{})]
> >INFO   :test.env:Called do_readdir()
> >INFO   :test.env:do_readdir() =3D [entry4(cookie=3D512, name=3Db'foo', a=
ttrs=3D{})]
> >EID6h    st_exchange_id.testUpdate111                             : PASS
> >EID6g    st_exchange_id.testUpdate110                             : RUNN=
ING
> >EID6g    st_exchange_id.testUpdate110                             : PASS
> >EID6f    st_exchange_id.testUpdate101                             : RUNN=
ING
> >EID6f    st_exchange_id.testUpdate101                             : PASS
> >EID6e    st_exchange_id.testUpdate100                             : RUNN=
ING
> >EID6e    st_exchange_id.testUpdate100                             : PASS
> >EID6d    st_exchange_id.testUpdate011                             : RUNN=
ING
> >EID6d    st_exchange_id.testUpdate011                             : PASS
> >EID6c    st_exchange_id.testUpdate010                             : RUNN=
ING
> >EID6c    st_exchange_id.testUpdate010                             : PASS
> >EID6b    st_exchange_id.testUpdate001                             : RUNN=
ING
> >EID6b    st_exchange_id.testUpdate001                             : PASS
> >EID6a    st_exchange_id.testUpdate000                             : RUNN=
ING
> >EID6a    st_exchange_id.testUpdate000                             : PASS
> >EID1b    st_exchange_id.testSupported2                            : RUNN=
ING
> >EID1b    st_exchange_id.testSupported2                            : PASS
> >EID7     st_exchange_id.testSupported1a                           : RUNN=
ING
> >EID7     st_exchange_id.testSupported1a                           : PASS
> >EID1     st_exchange_id.testSupported                             : RUNN=
ING
> >EID1     st_exchange_id.testSupported                             : PASS
> >EID8     st_exchange_id.testNotOnlyOp                             : RUNN=
ING
> >EID8     st_exchange_id.testNotOnlyOp                             : PASS
> >EID5h    st_exchange_id.testNoUpdate111                           : RUNN=
ING
> >EID5h    st_exchange_id.testNoUpdate111                           : PASS
> >EID5g    st_exchange_id.testNoUpdate110                           : RUNN=
ING
> >EID5g    st_exchange_id.testNoUpdate110                           : PASS
> >EID5fb   st_exchange_id.testNoUpdate101b                          : RUNN=
ING
> >EID5fb   st_exchange_id.testNoUpdate101b                          : PASS
> >EID5f    st_exchange_id.testNoUpdate101                           : RUNN=
ING
> >EID5f    st_exchange_id.testNoUpdate101                           : PASS
> >EID5e    st_exchange_id.testNoUpdate100                           : RUNN=
ING
> >EID5e    st_exchange_id.testNoUpdate100                           : PASS
> >EID5d    st_exchange_id.testNoUpdate011                           : RUNN=
ING
> >EID5d    st_exchange_id.testNoUpdate011                           : PASS
> >EID5c    st_exchange_id.testNoUpdate010                           : RUNN=
ING
> >EID5c    st_exchange_id.testNoUpdate010                           : PASS
> >EID5b    st_exchange_id.testNoUpdate001                           : RUNN=
ING
> >EID5b    st_exchange_id.testNoUpdate001                           : PASS
> >EID5a    st_exchange_id.testNoUpdate000                           : RUNN=
ING
> >EID5a    st_exchange_id.testNoUpdate000                           : PASS
> >EID2     st_exchange_id.testNoImplId                              : RUNN=
ING
> >EID2     st_exchange_id.testNoImplId                              : PASS
> >EID3     st_exchange_id.testLongArray                             : RUNN=
ING
> >COMPOUND4res(status=3DNFS4ERR_BADXDR, tag=3Db'st_exchange_id.py:testNoIm=
plId', resarray=3D[nfs_resop4(resop=3DOP_EXCHANGE_ID, opexchange_id=3DEXCHA=
NGE_ID4res(eir_status=3DNFS4ERR_BADXDR))])
> >EID3     st_exchange_id.testLongArray                             : PASS
> >EID9     st_exchange_id.testLeasePeriod                           : RUNN=
ING
> >EID9     st_exchange_id.testLeasePeriod                           : PASS
> >EID4     st_exchange_id.testBadFlags                              : RUNN=
ING
> >EID4     st_exchange_id.testBadFlags                              : PASS
> >**************************************************
> >**************************************************
> >Command line asked for 172 of 260 tests
> >Of those: 0 Skipped, 0 Failed, 0 Warned, 172 Passed
> >FSTYP         -- nfs
> >PLATFORM      -- Linux/x86_64 test3 5.16.0-00002-g616758bf6583 #1278 SMP=
 PREEMPT Wed Jan 12 11:37:28 EST 2022
> >MKFS_OPTIONS  -- test1.fieldses.org:/exports/xfs2
> >MOUNT_OPTIONS -- -overs=3D4.2,sec=3Dsys -o context=3Dsystem_u:object_r:r=
oot_t:s0 test1.fieldses.org:/exports/xfs2 /mnt2
> >
> >generic/001 41s ...  41s
> >generic/002 1s ...  1s
> >generic/003	[not run] atime related mount options have no effect on nfs
> >generic/004	[not run] O_TMPFILE is not supported
> >generic/005 2s ...  2s
> >generic/006       [expunged]
> >generic/007       [expunged]
> >generic/008	[not run] xfs_io fzero  failed (old kernel/wrong fs?)
> >generic/009	[not run] xfs_io fzero  failed (old kernel/wrong fs?)
> >generic/010	[not run] /root/xfstests-dev/src/dbtest not built
> >generic/011 68s ...  65s
> >generic/012	[not run] xfs_io fiemap  failed (old kernel/wrong fs?)
> >generic/013 68s ...  66s
> >generic/014       [expunged]
> >generic/015	[not run] Filesystem nfs not supported in _scratch_mkfs_sized
> >generic/016	[not run] xfs_io fiemap  failed (old kernel/wrong fs?)
> >generic/017       [expunged]
> >generic/018	[not run] defragmentation not supported for fstype "nfs"
> >generic/020 13s ...  13s
> >generic/021	[not run] xfs_io fiemap  failed (old kernel/wrong fs?)
> >generic/022	[not run] xfs_io fiemap  failed (old kernel/wrong fs?)
> >generic/023 4s ...  3s
> >generic/024	[not run] kernel doesn't support renameat2 syscall
> >generic/025	[not run] kernel doesn't support renameat2 syscall
> >generic/026	[not run] ACLs not supported by this filesystem type: nfs
> >generic/027	[not run] Filesystem nfs not supported in _scratch_mkfs_sized
> >generic/028 5s ...  5s
> >generic/029 1s ...  2s
> >generic/030 3s ...  3s
> >generic/031       [expunged]
> >generic/032       [expunged]
> >generic/033       [expunged]
> >generic/034	[not run] require test1.fieldses.org:/exports/xfs2 to be val=
id block disk
> >generic/035       [expunged]
> >generic/036 11s ...  11s
> >generic/037 21s ...  21s
> >generic/038	[not run] FITRIM not supported on /mnt2
> >generic/039	[not run] require test1.fieldses.org:/exports/xfs2 to be val=
id block disk
> >generic/040	[not run] require test1.fieldses.org:/exports/xfs2 to be val=
id block disk
> >generic/041	[not run] require test1.fieldses.org:/exports/xfs2 to be val=
id block disk
> >generic/043	[not run] nfs does not support shutdown
> >generic/044	[not run] nfs does not support shutdown
> >generic/045	[not run] nfs does not support shutdown
> >generic/046	[not run] nfs does not support shutdown
> >generic/047	[not run] nfs does not support shutdown
> >generic/048	[not run] nfs does not support shutdown
> >generic/049	[not run] nfs does not support shutdown
> >generic/050	[not run] nfs does not support shutdown
> >generic/051	[not run] nfs does not support shutdown
> >generic/052	[not run] nfs does not support shutdown
> >generic/053       [expunged]
> >generic/054	[not run] nfs does not support shutdown
> >generic/055	[not run] nfs does not support shutdown
> >generic/056	[not run] require test1.fieldses.org:/exports/xfs2 to be val=
id block disk
> >generic/057	[not run] require test1.fieldses.org:/exports/xfs2 to be val=
id block disk
> >generic/058	[not run] xfs_io fiemap  failed (old kernel/wrong fs?)
> >generic/059	[not run] require test1.fieldses.org:/exports/xfs2 to be val=
id block disk
> >generic/060	[not run] xfs_io fiemap  failed (old kernel/wrong fs?)
> >generic/061	[not run] xfs_io fiemap  failed (old kernel/wrong fs?)
> >generic/062       [expunged]
> >generic/063	[not run] xfs_io fiemap  failed (old kernel/wrong fs?)
> >generic/064       [expunged]
> >generic/065	[not run] require test1.fieldses.org:/exports/xfs2 to be val=
id block disk
> >generic/066	[not run] require test1.fieldses.org:/exports/xfs2 to be val=
id block disk
> >generic/067	[not run] require test1.fieldses.org:/exports/xfs2 to be val=
id block disk
> >generic/068       [expunged]
> >generic/069 29s ...  30s
> >generic/070 60s ...  47s
> >generic/071       [expunged]
> >generic/072 24s ... [not run] xfs_io fcollapse  failed (old kernel/wrong=
 fs?)
> >generic/073	[not run] require test1.fieldses.org:/exports/xfs2 to be val=
id block disk
> >generic/074       [expunged]
> >generic/075 61s ...  56s
> >generic/076	[not run] require test1.fieldses.org:/exports/xfs2 to be loc=
al device
> >generic/077	[not run] ACLs not supported by this filesystem type: nfs
> >generic/078	[not run] kernel doesn't support renameat2 syscall
> >generic/079	[not run] file system doesn't support chattr +ia
> >generic/080 3s ...  3s
> >generic/081	[not run] require test1.fieldses.org:/exports/xfs2 to be val=
id block disk
> >generic/082	[not run] disk quotas not supported by this filesystem type:=
 nfs
> >generic/083	[not run] Filesystem nfs not supported in _scratch_mkfs_sized
> >generic/084 5s ...  6s
> >generic/085	[not run] require test1.fieldses.org:/exports/xfs2 to be val=
id block disk
> >generic/086 2s ...  2s
> >generic/087       [expunged]
> >generic/088       [expunged]
> >generic/089       [expunged]
> >generic/090	[not run] require test1.fieldses.org:/exports/xfs2 to be val=
id block disk
> >generic/091       [expunged]
> >generic/092	[not run] xfs_io fiemap  failed (old kernel/wrong fs?)
> >generic/093	[not run] attr namespace security not supported by this file=
system type: nfs
> >generic/094       [expunged]
> >generic/095	[not run] fio utility required, skipped this test
> >generic/096	[not run] xfs_io fzero  failed (old kernel/wrong fs?)
> >generic/097	[not run] attr namespace trusted not supported by this files=
ystem type: nfs
> >generic/098 2s ...  2s
> >generic/099	[not run] ACLs not supported by this filesystem type: nfs
> >generic/100       [expunged]
> >generic/101	[not run] require test1.fieldses.org:/exports/xfs2 to be val=
id block disk
> >generic/102	[not run] Filesystem nfs not supported in _scratch_mkfs_sized
> >generic/103 3s ...  3s
> >generic/104	[not run] require test1.fieldses.org:/exports/xfs2 to be val=
id block disk
> >generic/105       [expunged]
> >generic/106	[not run] require test1.fieldses.org:/exports/xfs2 to be val=
id block disk
> >generic/107	[not run] require test1.fieldses.org:/exports/xfs2 to be val=
id block disk
> >generic/108	[not run] require test1.fieldses.org:/exports/xfs2 to be val=
id block disk
> >generic/109 57s ...  56s
> >generic/110	[not run] xfs_io fiemap  failed (old kernel/wrong fs?)
> >generic/111	[not run] xfs_io fiemap  failed (old kernel/wrong fs?)
> >generic/112 61s ...  59s
> >generic/113       [expunged]
> >generic/114	[not run] device block size: 4096 greater than 512
> >generic/115	[not run] xfs_io fiemap  failed (old kernel/wrong fs?)
> >generic/116 1s ...  2s
> >generic/117       [expunged]
> >generic/118 2s ...  1s
> >generic/119 3s ...  3s
> >generic/120	[not run] atime related mount options have no effect on nfs
> >generic/121	[not run] Dedupe not supported by test filesystem type: nfs
> >generic/122	[not run] Dedupe not supported by test filesystem type: nfs
> >generic/123	[not run] fsgqa user not defined.
> >generic/124 60s ...  54s
> >generic/126       [expunged]
> >generic/127       [expunged]
> >generic/128	[not run] fsgqa user not defined.
> >generic/129       [expunged]
> >generic/130 19s ...  18s
> >generic/131 2s ...  2s
> >generic/132 20s ...  19s
> >generic/133       [expunged]
> >generic/134 2s ...  2s
> >generic/135 2s ...  1s
> >generic/136	[not run] Dedupe not supported by test filesystem type: nfs
> >generic/137	[not run] Dedupe not supported by test filesystem type: nfs
> >generic/138 3s ...  2s
> >generic/139 3s ...  3s
> >generic/140 2s ...  3s
> >generic/141 1s ...  1s
> >generic/142 10s ...  8s
> >generic/143 246s ...  242s
> >generic/144 2s ...  2s
> >generic/145	[not run] xfs_io fcollapse  failed (old kernel/wrong fs?)
> >generic/146 3s ...  2s
> >generic/147	[not run] xfs_io finsert  failed (old kernel/wrong fs?)
> >generic/148 2s ...  2s
> >generic/149	[not run] xfs_io fzero  failed (old kernel/wrong fs?)
> >generic/150 19s ...  17s
> >generic/151 21s ...  20s
> >generic/152 22s ...  20s
> >generic/153	[not run] xfs_io fcollapse  failed (old kernel/wrong fs?)
> >generic/154       [expunged]
> >generic/155	[not run] xfs_io fzero  failed (old kernel/wrong fs?)
> >generic/156	[not run] xfs_io funshare  failed (old kernel/wrong fs?)
> >generic/157 88s ...  86s
> >generic/158	[not run] Dedupe not supported by test filesystem type: nfs
> >generic/159	[not run] file system doesn't support chattr +i
> >generic/160	[not run] file system doesn't support chattr +i
> >generic/161 18s ...  20s
> >generic/162	[not run] Dedupe not supported by scratch filesystem type: n=
fs
> >generic/163	[not run] Dedupe not supported by scratch filesystem type: n=
fs
> >generic/164 71s ...  70s
> >generic/165 65s ...  60s
> >generic/166 207s ...  182s
> >generic/167 46s ...  42s
> >generic/168 319s ...  280s
> >generic/169 2s ...  2s
> >generic/170 382s ...  361s
> >generic/171	[not run] Filesystem nfs not supported in _scratch_mkfs_sized
> >generic/172	[not run] Filesystem nfs not supported in _scratch_mkfs_sized
> >generic/173	[not run] Filesystem nfs not supported in _scratch_mkfs_sized
> >generic/174	[not run] Filesystem nfs not supported in _scratch_mkfs_sized
> >generic/175 370s ...  235s
> >generic/176	[not run] Insufficient space for stress test; would only cre=
ate 32768 extents.
> >generic/177	[not run] xfs_io fiemap  failed (old kernel/wrong fs?)
> >generic/178 5s ...  5s
> >generic/179 1s ...  1s
> >generic/180	[not run] xfs_io fzero  failed (old kernel/wrong fs?)
> >generic/181 4s ...  4s
> >generic/182	[not run] Dedupe not supported by test filesystem type: nfs
> >generic/183 6s ...  6s
> >generic/184       [expunged]
> >generic/185 6s ...  6s
> >generic/186 832s ...  813s
> >generic/187 829s ...  815s
> >generic/188 8s ...  6s
> >generic/189 4s ...  4s
> >generic/190 5s ...  5s
> >generic/191 5s ...  4s
> >generic/192	[not run] atime related mount options have no effect on nfs
> >generic/193	[not run] fsgqa user not defined.
> >generic/194 6s ...  6s
> >generic/195 6s ...  6s
> >generic/196 4s ...  4s
> >generic/197 4s ...  5s
> >generic/198 6s ...  6s
> >generic/199 6s ...  6s
> >generic/200 6s ...  5s
> >generic/201 5s ...  3s
> >generic/202 2s ...  2s
> >generic/203 2s ...  3s
> >generic/204	[not run] Filesystem nfs not supported in _scratch_mkfs_sized
> >generic/205	[not run] Filesystem nfs not supported in _scratch_mkfs_bloc=
ksized
> >generic/206	[not run] Filesystem nfs not supported in _scratch_mkfs_bloc=
ksized
> >generic/207 22s ...  20s
> >generic/208       [expunged]
> >generic/209 33s ...  45s
> >generic/210 0s ...  0s
> >generic/211 2s ...  1s
> >generic/212 0s ...  0s
> >generic/213 1s ...  0s
> >generic/214 1s ...  1s
> >generic/215 3s ...  3s
> >generic/216	[not run] Filesystem nfs not supported in _scratch_mkfs_bloc=
ksized
> >generic/217	[not run] Filesystem nfs not supported in _scratch_mkfs_bloc=
ksized
> >generic/218	[not run] Filesystem nfs not supported in _scratch_mkfs_bloc=
ksized
> >generic/219	[not run] disk quotas not supported by this filesystem type:=
 nfs
> >generic/220	[not run] Filesystem nfs not supported in _scratch_mkfs_bloc=
ksized
> >generic/221 1s ...  2s
> >generic/222	[not run] Filesystem nfs not supported in _scratch_mkfs_bloc=
ksized
> >generic/223	[not run] can't mkfs nfs with geometry
> >generic/224	[not run] Filesystem nfs not supported in _scratch_mkfs_sized
> >generic/225       [expunged]
> >generic/226	[not run] Filesystem nfs not supported in _scratch_mkfs_sized
> >generic/227	[not run] Filesystem nfs not supported in _scratch_mkfs_bloc=
ksized
> >generic/228 1s ...  1s
> >generic/229	[not run] Filesystem nfs not supported in _scratch_mkfs_bloc=
ksized
> >generic/230	[not run] disk quotas not supported by this filesystem type:=
 nfs
> >generic/231	[not run] disk quotas not supported by this filesystem type:=
 nfs
> >generic/232	[not run] disk quotas not supported by this filesystem type:=
 nfs
> >generic/233	[not run] disk quotas not supported by this filesystem type:=
 nfs
> >generic/234	[not run] disk quotas not supported by this filesystem type:=
 nfs
> >generic/235	[not run] disk quotas not supported by this filesystem type:=
 nfs
> >generic/236 2s ...  2s
> >generic/237	[not run] ACLs not supported by this filesystem type: nfs
> >generic/238	[not run] Filesystem nfs not supported in _scratch_mkfs_bloc=
ksized
> >generic/239 32s ...  31s
> >generic/240 1s ...  1s
> >generic/241	[not run] dbench not found
> >generic/242 89s ...  85s
> >generic/243 89s ...  81s
> >generic/244	[not run] disk quotas not supported by this filesystem type:=
 nfs
> >generic/245 1s ...  1s
> >generic/246 0s ...  0s
> >generic/247 85s ...  81s
> >generic/248 1s ...  0s
> >generic/249 3s ...  3s
> >generic/250	[not run] require test1.fieldses.org:/exports/xfs2 to be val=
id block disk
> >generic/252	[not run] require test1.fieldses.org:/exports/xfs2 to be val=
id block disk
> >generic/253 3s ...  2s
> >generic/254 2s ...  3s
> >generic/255	[not run] xfs_io fiemap  failed (old kernel/wrong fs?)
> >generic/256	[not run] fsgqa user not defined.
> >generic/257 4s ...  5s
> >generic/258 1s ...  0s
> >generic/259	[not run] xfs_io fzero  failed (old kernel/wrong fs?)
> >generic/260	[not run] FITRIM not supported on /mnt2
> >generic/261	[not run] xfs_io fcollapse  failed (old kernel/wrong fs?)
> >generic/262	[not run] xfs_io finsert  failed (old kernel/wrong fs?)
> >generic/263       [expunged]
> >generic/264	[not run] xfs_io funshare  failed (old kernel/wrong fs?)
> >generic/265	[not run] require test1.fieldses.org:/exports/xfs2 to be val=
id block disk
> >generic/266	[not run] require test1.fieldses.org:/exports/xfs2 to be val=
id block disk
> >generic/267	[not run] require test1.fieldses.org:/exports/xfs2 to be val=
id block disk
> >generic/268	[not run] require test1.fieldses.org:/exports/xfs2 to be val=
id block disk
> >generic/269	[not run] Filesystem nfs not supported in _scratch_mkfs_sized
> >generic/270	[not run] disk quotas not supported by this filesystem type:=
 nfs
> >generic/271	[not run] require test1.fieldses.org:/exports/xfs2 to be val=
id block disk
> >generic/272	[not run] require test1.fieldses.org:/exports/xfs2 to be val=
id block disk
> >generic/273	[not run] Filesystem nfs not supported in _scratch_mkfs_sized
> >generic/274	[not run] xfs_io falloc -k failed (old kernel/wrong fs?)
> >generic/275	[not run] Filesystem nfs not supported in _scratch_mkfs_sized
> >generic/276	[not run] require test1.fieldses.org:/exports/xfs2 to be val=
id block disk
> >generic/277       [expunged]
> >generic/278	[not run] require test1.fieldses.org:/exports/xfs2 to be val=
id block disk
> >generic/279	[not run] require test1.fieldses.org:/exports/xfs2 to be val=
id block disk
> >generic/280	[not run] disk quotas not supported by this filesystem type:=
 nfs
> >generic/281	[not run] require test1.fieldses.org:/exports/xfs2 to be val=
id block disk
> >generic/282	[not run] require test1.fieldses.org:/exports/xfs2 to be val=
id block disk
> >generic/283	[not run] require test1.fieldses.org:/exports/xfs2 to be val=
id block disk
> >generic/284 4s ...  3s
> >generic/285 2s ...  2s
> >generic/286 19s ...  19s
> >generic/287 4s ...  4s
> >generic/288	[not run] FITRIM not supported on /mnt2
> >generic/289 5s ...  5s
> >generic/290 5s ...  5s
> >generic/291 6s ...  6s
> >generic/292 6s ...  5s
> >generic/293 7s ...  7s
> >generic/294       [expunged]
> >generic/295 8s ...  7s
> >generic/296 4s ...  3s
> >generic/297	[not run] NFS can't interrupt clone operations
> >generic/298	[not run] NFS can't interrupt clone operations
> >generic/299	[not run] require test1.fieldses.org:/exports/xfs2 to be val=
id block disk
> >generic/300	[not run] require test1.fieldses.org:/exports/xfs2 to be val=
id block disk
> >generic/301	[not run] xfs_io fiemap  failed (old kernel/wrong fs?)
> >generic/302	[not run] xfs_io fiemap  failed (old kernel/wrong fs?)
> >generic/303 1s ...  1s
> >generic/304	[not run] Dedupe not supported by test filesystem type: nfs
> >generic/305	[not run] xfs_io fiemap  failed (old kernel/wrong fs?)
> >generic/306 1s ...  1s
> >generic/307 3s ... [not run] ACLs not supported by this filesystem type:=
 nfs
> >generic/308 1s ...  0s
> >generic/309 1s ...  2s
> >generic/310       [expunged]
> >generic/311	[not run] require test1.fieldses.org:/exports/xfs2 to be val=
id block disk
> >generic/312	[not run] Filesystem nfs not supported in _scratch_mkfs_sized
> >generic/313 4s ...  5s
> >generic/314	[not run] fsgqa user not defined.
> >generic/315 15s ... [not run] xfs_io falloc -k failed (old kernel/wrong =
fs?)
> >generic/316	[not run] xfs_io fiemap  failed (old kernel/wrong fs?)
> >generic/317	[not run] fsgqa user not defined.
> >generic/318       [expunged]
> >generic/319	[not run] ACLs not supported by this filesystem type: nfs
> >generic/320	[not run] Filesystem nfs not supported in _scratch_mkfs_sized
> >generic/321	[not run] require test1.fieldses.org:/exports/xfs2 to be val=
id block disk
> >generic/322	[not run] require test1.fieldses.org:/exports/xfs2 to be val=
id block disk
> >generic/323       [expunged]
> >generic/324	[not run] defragmentation not supported for fstype "nfs"
> >generic/325	[not run] require test1.fieldses.org:/exports/xfs2 to be val=
id block disk
> >generic/326	[not run] xfs_io fiemap  failed (old kernel/wrong fs?)
> >generic/327	[not run] xfs_io fiemap  failed (old kernel/wrong fs?)
> >generic/328	[not run] xfs_io fiemap  failed (old kernel/wrong fs?)
> >generic/329	[not run] require test1.fieldses.org:/exports/xfs2 to be val=
id block disk
> >generic/330 10s ...  9s
> >generic/331	[not run] require test1.fieldses.org:/exports/xfs2 to be val=
id block disk
> >generic/332 9s ...  8s
> >generic/333	[not run] Filesystem nfs not supported in _scratch_mkfs_sized
> >generic/334	[not run] Filesystem nfs not supported in _scratch_mkfs_sized
> >generic/335	[not run] require test1.fieldses.org:/exports/xfs2 to be val=
id block disk
> >generic/336	[not run] require test1.fieldses.org:/exports/xfs2 to be val=
id block disk
> >generic/337 1s ...  1s
> >generic/338	[not run] require test1.fieldses.org:/exports/xfs2 to be val=
id block disk
> >generic/339       [expunged]
> >generic/340 41s ...  42s
> >generic/341	[not run] require test1.fieldses.org:/exports/xfs2 to be val=
id block disk
> >generic/342	[not run] require test1.fieldses.org:/exports/xfs2 to be val=
id block disk
> >generic/343	[not run] require test1.fieldses.org:/exports/xfs2 to be val=
id block disk
> >generic/344 86s ...  84s
> >generic/345 89s ...  84s
> >generic/346 41s ...  38s
> >generic/347	[not run] require test1.fieldses.org:/exports/xfs2 to be val=
id block disk
> >generic/348	[not run] require test1.fieldses.org:/exports/xfs2 to be val=
id block disk
> >generic/352	[not run] xfs_io fiemap  failed (old kernel/wrong fs?)
> >generic/353	[not run] xfs_io fiemap  failed (old kernel/wrong fs?)
> >generic/354 30s ...  29s
> >generic/355	[not run] fsgqa user not defined.
> >generic/356 3s ...  2s
> >generic/357       [expunged]
> >generic/358 58s ...  55s
> >generic/359 15s ...  15s
> >generic/360 0s ...  1s
> >generic/361	[not run] require test1.fieldses.org:/exports/xfs2 to be val=
id block disk
> >generic/362	[not run] this test requires richacl support on $SCRATCH_DEV
> >generic/363	[not run] this test requires richacl support on $SCRATCH_DEV
> >generic/364	[not run] this test requires richacl support on $SCRATCH_DEV
> >generic/365	[not run] this test requires richacl support on $SCRATCH_DEV
> >generic/366	[not run] this test requires richacl support on $SCRATCH_DEV
> >generic/367	[not run] this test requires richacl support on $SCRATCH_DEV
> >generic/368	[not run] this test requires richacl support on $SCRATCH_DEV
> >generic/369	[not run] this test requires richacl support on $SCRATCH_DEV
> >generic/370	[not run] this test requires richacl support on $SCRATCH_DEV
> >generic/371	[not run] Filesystem nfs not supported in _scratch_mkfs_sized
> >generic/372	[not run] xfs_io fiemap  failed (old kernel/wrong fs?)
> >generic/373 1s ...  1s
> >generic/374	[not run] Dedupe not supported by scratch filesystem type: n=
fs
> >generic/375	[not run] ACLs not supported by this filesystem type: nfs
> >generic/376	[not run] require test1.fieldses.org:/exports/xfs2 to be val=
id block disk
> >generic/377 1s ...  1s
> >generic/378	[not run] fsgqa user not defined.
> >generic/379	[not run] disk quotas not supported by this filesystem type:=
 nfs
> >generic/380	[not run] disk quotas not supported by this filesystem type:=
 nfs
> >generic/381	[not run] disk quotas not supported by this filesystem type:=
 nfs
> >generic/382	[not run] disk quotas not supported by this filesystem type:=
 nfs
> >generic/383	[not run] disk quotas not supported by this filesystem type:=
 nfs
> >generic/384	[not run] disk quotas not supported by this filesystem type:=
 nfs
> >generic/385	[not run] disk quotas not supported by this filesystem type:=
 nfs
> >generic/386	[not run] disk quotas not supported by this filesystem type:=
 nfs
> >generic/387	[not run] Filesystem nfs not supported in _scratch_mkfs_sized
> >generic/388	[not run] require test1.fieldses.org:/exports/xfs2 to be loc=
al device
> >generic/389	[not run] O_TMPFILE is not supported
> >generic/390 9s ... [not run] nfs does not support freezing
> >generic/391 24s ...  22s
> >generic/392	[not run] nfs does not support shutdown
> >generic/393 2s ...  2s
> >generic/394 2s ...  1s
> >generic/395	[not run] No encryption support for nfs
> >generic/396	[not run] No encryption support for nfs
> >generic/397	[not run] No encryption support for nfs
> >generic/398	[not run] No encryption support for nfs
> >generic/399	[not run] No encryption support for nfs
> >generic/400	[not run] disk quotas not supported by this filesystem type:=
 nfs
> >generic/401 1s ...  2s
> >generic/402	[not run] filesystem nfs timestamp bounds are unknown
> >generic/403       [expunged]
> >generic/404	[not run] xfs_io finsert  failed (old kernel/wrong fs?)
> >generic/405	[not run] require test1.fieldses.org:/exports/xfs2 to be val=
id block disk
> >generic/406 9s ...  8s
> >generic/407 2s ...  1s
> >generic/408	[not run] Dedupe not supported by test filesystem type: nfs
> >generic/409	[not run] require test1.fieldses.org:/exports/xfs2 to be loc=
al device
> >generic/410	[not run] require test1.fieldses.org:/exports/xfs2 to be loc=
al device
> >generic/411	[not run] require test1.fieldses.org:/exports/xfs2 to be loc=
al device
> >generic/412 2s ...  1s
> >generic/413	[not run] mount test1.fieldses.org:/exports/xfs2 with dax fa=
iled
> >generic/414	[not run] xfs_io fiemap  failed (old kernel/wrong fs?)
> >generic/415 15s ...  16s
> >generic/416	[not run] Filesystem nfs not supported in _scratch_mkfs_sized
> >generic/417	[not run] nfs does not support shutdown
> >generic/418	[not run] require test1.fieldses.org:/exports/xfs to be vali=
d block disk
> >generic/419	[not run] No encryption support for nfs
> >generic/420 1s ...  0s
> >generic/421	[not run] No encryption support for nfs
> >generic/422       [expunged]
> >generic/423       [expunged]
> >generic/424	[not run] file system doesn't support any of /usr/bin/chattr=
 +a/+c/+d/+i
> >generic/425       [expunged]
> >generic/426       [expunged]
> >generic/427	[not run] Filesystem nfs not supported in _scratch_mkfs_sized
> >generic/428 1s ...  0s
> >generic/429	[not run] No encryption support for nfs
> >generic/430 1s ...  1s
> >generic/431 1s ...  1s
> >generic/432 1s ...  1s
> >generic/433 1s ...  1s
> >generic/434       [expunged]
> >generic/435	[not run] No encryption support for nfs
> >generic/436 1s ...  2s
> >generic/437 21s ...  20s
> >generic/438       [expunged]
> >generic/439 2s ...  2s
> >generic/440	[not run] No encryption support for nfs
> >generic/441	[not run] require test1.fieldses.org:/exports/xfs2 to be val=
id block disk
> >generic/443 0s ...  1s
> >generic/444	[not run] ACLs not supported by this filesystem type: nfs
> >generic/445 1s ...  2s
> >generic/446       [expunged]
> >generic/447	[not run] Insufficient space for stress test; would only cre=
ate 32768 extents (10737418240/21281112064 blocks).
> >generic/448 1s ...  2s
> >generic/449	[not run] ACLs not supported by this filesystem type: nfs
> >generic/450 1s ...  1s
> >generic/451 31s ...  31s
> >generic/452 1s ...  1s
> >generic/453 2s ...  2s
> >generic/454 3s ...  2s
> >generic/455	[not run] This test requires a valid $LOGWRITES_DEV
> >generic/456	[not run] require test1.fieldses.org:/exports/xfs2 to be val=
id block disk
> >generic/457	[not run] This test requires a valid $LOGWRITES_DEV
> >generic/458	[not run] xfs_io fzero  failed (old kernel/wrong fs?)
> >generic/459	[not run] require test1.fieldses.org:/exports/xfs2 to be val=
id block disk
> >generic/460 36s ...  37s
> >generic/461	[not run] nfs does not support shutdown
> >generic/462	[not run] mount test1.fieldses.org:/exports/xfs2 with dax fa=
iled
> >generic/463 1s ...  1s
> >generic/464 73s ...  73s
> >generic/465       [expunged]
> >generic/466	[not run] require test1.fieldses.org:/exports/xfs2 to be val=
id block disk
> >generic/467 4s ...  4s
> >generic/468	[not run] nfs does not support shutdown
> >generic/469       [expunged]
> >generic/470	[not run] This test requires a valid $LOGWRITES_DEV
> >generic/471	[not run] xfs_io pwrite  -V 1 -b 4k -N failed (old kernel/wr=
ong fs?)
> >generic/472 2s ...  2s
> >generic/474	[not run] nfs does not support shutdown
> >generic/475	[not run] require test1.fieldses.org:/exports/xfs2 to be val=
id block disk
> >generic/476       [expunged]
> >generic/477 4s ...  4s
> >generic/478       [expunged]
> >generic/479	[not run] require test1.fieldses.org:/exports/xfs2 to be val=
id block disk
> >generic/480	[not run] require test1.fieldses.org:/exports/xfs2 to be val=
id block disk
> >generic/481	[not run] require test1.fieldses.org:/exports/xfs2 to be val=
id block disk
> >generic/482	[not run] This test requires a valid $LOGWRITES_DEV
> >generic/483	[not run] require test1.fieldses.org:/exports/xfs2 to be val=
id block disk
> >generic/484       [expunged]
> >generic/485       [expunged]
> >generic/486       [expunged]
> >generic/487	[not run] This test requires a valid $SCRATCH_LOGDEV
> >generic/488	[not run] Filesystem nfs not supported in _scratch_mkfs_sized
> >generic/489	[not run] require test1.fieldses.org:/exports/xfs2 to be val=
id block disk
> >generic/490 1s ...  2s
> >generic/491       [expunged]
> >generic/492	[not run] xfs_io label  failed (old kernel/wrong fs?)
> >generic/493	[not run] Dedupe not supported by scratch filesystem type: n=
fs
> >generic/494 3s ...  2s
> >generic/495 2s ...  2s
> >generic/496 7s ...  7s
> >generic/497 2s ... [not run] xfs_io fcollapse  failed (old kernel/wrong =
fs?)
> >generic/498	[not run] require test1.fieldses.org:/exports/xfs2 to be val=
id block disk
> >generic/499       [expunged]
> >generic/500	[not run] require test1.fieldses.org:/exports/xfs2 to be val=
id block disk
> >generic/501	[not run] require test1.fieldses.org:/exports/xfs2 to be val=
id block disk
> >generic/502	[not run] require test1.fieldses.org:/exports/xfs2 to be val=
id block disk
> >generic/503       [expunged]
> >generic/504 0s ...  0s
> >generic/505	[not run] nfs does not support shutdown
> >generic/506	[not run] nfs does not support shutdown
> >generic/507	[not run] file system doesn't support chattr +AsSu
> >generic/508	[not run] lsattr not supported by test filesystem type: nfs
> >generic/509	[not run] O_TMPFILE is not supported
> >generic/510	[not run] require test1.fieldses.org:/exports/xfs2 to be val=
id block disk
> >generic/511	[not run] xfs_io falloc -k failed (old kernel/wrong fs?)
> >generic/512	[not run] require test1.fieldses.org:/exports/xfs2 to be val=
id block disk
> >generic/513       [expunged]
> >generic/514	[not run] fsgqa user not defined.
> >generic/515	[not run] Filesystem nfs not supported in _scratch_mkfs_sized
> >generic/516	[not run] Dedupe not supported by test filesystem type: nfs
> >generic/517	[not run] Dedupe not supported by scratch filesystem type: n=
fs
> >generic/518 2s ...  2s
> >generic/519       [expunged]
> >generic/520	[not run] require test1.fieldses.org:/exports/xfs2 to be val=
id block disk
> >generic/523 1s ...  1s
> >generic/524 25s ...  27s
> >generic/525 1s ...  2s
> >generic/526	[not run] require test1.fieldses.org:/exports/xfs2 to be val=
id block disk
> >generic/527	[not run] require test1.fieldses.org:/exports/xfs2 to be val=
id block disk
> >generic/528	[not run] inode creation time not supported by this filesyst=
em
> >generic/529	[not run] ACLs not supported by this filesystem type: nfs
> >generic/530	[not run] nfs does not support shutdown
> >generic/531       [expunged]
> >generic/532 1s ...  1s
> >generic/533 1s ...  1s
> >generic/534	[not run] require test1.fieldses.org:/exports/xfs2 to be val=
id block disk
> >generic/535	[not run] require test1.fieldses.org:/exports/xfs2 to be val=
id block disk
> >generic/536	[not run] nfs does not support shutdown
> >generic/537	[not run] FSTRIM not supported
> >generic/538 26s ...  26s
> >generic/539 1s ...  1s
> >generic/540 6s ...  6s
> >generic/541 7s ...  6s
> >generic/542 6s ...  6s
> >generic/543 7s ...  6s
> >generic/544 6s ...  7s
> >generic/545	[not run] file system doesn't support chattr +i
> >generic/546	[not run] require test1.fieldses.org:/exports/xfs2 to be val=
id block disk
> >generic/547	[not run] require test1.fieldses.org:/exports/xfs2 to be val=
id block disk
> >generic/548	[not run] No encryption support for nfs
> >generic/549	[not run] No encryption support for nfs
> >generic/550	[not run] No encryption support for nfs
> >generic/551       [expunged]
> >generic/552	[not run] require test1.fieldses.org:/exports/xfs2 to be val=
id block disk
> >generic/553	[not run] xfs_io chattr +i failed (old kernel/wrong fs?)
> >generic/554 3s ...  2s
> >generic/555	[not run] xfs_io chattr +ia failed (old kernel/wrong fs?)
> >generic/556	[not run] nfs does not support casefold feature
> >generic/557	[not run] require test1.fieldses.org:/exports/xfs2 to be val=
id block disk
> >generic/558	[not run] Filesystem nfs not supported in _scratch_mkfs_sized
> >generic/559	[not run] duperemove utility required, skipped this test
> >generic/560	[not run] duperemove utility required, skipped this test
> >generic/561	[not run] duperemove utility required, skipped this test
> >generic/562	[not run] Filesystem nfs not supported in _scratch_mkfs_sized
> >generic/563	[not run] Cgroup2 doesn't support io controller io
> >generic/564 2s ...  2s
> >generic/565       [expunged]
> >generic/566	[not run] disk quotas not supported by this filesystem type:=
 nfs
> >generic/567 1s ...  2s
> >generic/568 1s ...  1s
> >generic/569 2s ...  3s
> >generic/570	[not run] require test1.fieldses.org:/exports/xfs2 to be val=
id block disk
> >generic/571       [expunged]
> >generic/572	[not run] fsverity utility required, skipped this test
> >generic/573	[not run] fsverity utility required, skipped this test
> >generic/574	[not run] fsverity utility required, skipped this test
> >generic/575	[not run] fsverity utility required, skipped this test
> >generic/576	[not run] fsverity utility required, skipped this test
> >generic/577	[not run] fsverity utility required, skipped this test
> >generic/578       [expunged]
> >generic/579	[not run] fsverity utility required, skipped this test
> >generic/580	[not run] No encryption support for nfs
> >generic/581	[not run] fsgqa user not defined.
> >generic/582	[not run] No encryption support for nfs
> >generic/583	[not run] No encryption support for nfs
> >generic/584	[not run] No encryption support for nfs
> >generic/585 8s ... [not run] kernel doesn't support renameat2 syscall
> >generic/586 9s ...  9s
> >generic/587	[not run] fsgqa user not defined.
> >generic/588	[not run] require test1.fieldses.org:/exports/xfs2 to be val=
id block disk
> >generic/589	[not run] require test1.fieldses.org:/exports/xfs2 to be loc=
al device
> >generic/590 281s ...  276s
> >generic/591 1s ...  1s
> >generic/592	[not run] No encryption support for nfs
> >generic/593	[not run] No encryption support for nfs
> >generic/594	[not run] disk quotas not supported by this filesystem type:=
 nfs
> >generic/595	[not run] No encryption support for nfs
> >generic/596	[not run] file system doesn't support chattr +S
> >generic/597	[not run] fsgqa2 user not defined.
> >generic/598	[not run] fsgqa2 user not defined.
> >generic/599	[not run] nfs does not support shutdown
> >generic/600	[not run] disk quotas not supported by this filesystem type:=
 nfs
> >generic/601	[not run] disk quotas not supported by this filesystem type:=
 nfs
> >generic/602	[not run] No encryption support for nfs
> >generic/603	[not run] disk quotas not supported by this filesystem type:=
 nfs
> >generic/604 6s ...  5s
> >generic/605	[not run] mount test1.fieldses.org:/exports/xfs2 with dax=3D=
always failed
> >generic/606	[not run] mount test1.fieldses.org:/exports/xfs2 with dax=3D=
always failed
> >generic/607       [expunged]
> >generic/608	[not run] mount test1.fieldses.org:/exports/xfs2 with dax=3D=
always failed
> >generic/609 1s ...  0s
> >generic/610       [expunged]
> >generic/611 1s ...  2s
> >nfs/001 3s ...  2s
> >shared/002	[not run] not suitable for this filesystem type: nfs
> >shared/032	[not run] not suitable for this filesystem type: nfs
> >shared/298	[not run] not suitable for this filesystem type: nfs
> >Ran: generic/001 generic/002 generic/003 generic/004 generic/005 generic=
/008 generic/009 generic/010 generic/011 generic/012 generic/013 generic/01=
5 generic/016 generic/018 generic/020 generic/021 generic/022 generic/023 g=
eneric/024 generic/025 generic/026 generic/027 generic/028 generic/029 gene=
ric/030 generic/034 generic/036 generic/037 generic/038 generic/039 generic=
/040 generic/041 generic/043 generic/044 generic/045 generic/046 generic/04=
7 generic/048 generic/049 generic/050 generic/051 generic/052 generic/054 g=
eneric/055 generic/056 generic/057 generic/058 generic/059 generic/060 gene=
ric/061 generic/063 generic/065 generic/066 generic/067 generic/069 generic=
/070 generic/072 generic/073 generic/075 generic/076 generic/077 generic/07=
8 generic/079 generic/080 generic/081 generic/082 generic/083 generic/084 g=
eneric/085 generic/086 generic/090 generic/092 generic/093 generic/095 gene=
ric/096 generic/097 generic/098 generic/099 generic/101 generic/102 generic=
/103 generic/104 generic/1
> >  06 generic/107 generic/108 generic/109 generic/110 generic/111 generic=
/112 generic/114 generic/115 generic/116 generic/118 generic/119 generic/12=
0 generic/121 generic/122 generic/123 generic/124 generic/128 generic/130 g=
eneric/131 generic/132 generic/134 generic/135 generic/136 generic/137 gene=
ric/138 generic/139 generic/140 generic/141 generic/142 generic/143 generic=
/144 generic/145 generic/146 generic/147 generic/148 generic/149 generic/15=
0 generic/151 generic/152 generic/153 generic/155 generic/156 generic/157 g=
eneric/158 generic/159 generic/160 generic/161 generic/162 generic/163 gene=
ric/164 generic/165 generic/166 generic/167 generic/168 generic/169 generic=
/170 generic/171 generic/172 generic/173 generic/174 generic/175 generic/17=
6 generic/177 generic/178 generic/179 generic/180 generic/181 generic/182 g=
eneric/183 generic/185 generic/186 generic/187 generic/188 generic/189 gene=
ric/190 generic/191 generic/192 generic/193 generic/194 generic/195 generic=
/196 generic/197 generic/19
> >  8 generic/199 generic/200 generic/201 generic/202 generic/203 generic/=
204 generic/205 generic/206 generic/207 generic/209 generic/210 generic/211=
 generic/212 generic/213 generic/214 generic/215 generic/216 generic/217 ge=
neric/218 generic/219 generic/220 generic/221 generic/222 generic/223 gener=
ic/224 generic/226 generic/227 generic/228 generic/229 generic/230 generic/=
231 generic/232 generic/233 generic/234 generic/235 generic/236 generic/237=
 generic/238 generic/239 generic/240 generic/241 generic/242 generic/243 ge=
neric/244 generic/245 generic/246 generic/247 generic/248 generic/249 gener=
ic/250 generic/252 generic/253 generic/254 generic/255 generic/256 generic/=
257 generic/258 generic/259 generic/260 generic/261 generic/262 generic/264=
 generic/265 generic/266 generic/267 generic/268 generic/269 generic/270 ge=
neric/271 generic/272 generic/273 generic/274 generic/275 generic/276 gener=
ic/278 generic/279 generic/280 generic/281 generic/282 generic/283 generic/=
284 generic/285 generic/286
> >   generic/287 generic/288 generic/289 generic/290 generic/291 generic/2=
92 generic/293 generic/295 generic/296 generic/297 generic/298 generic/299 =
generic/300 generic/301 generic/302 generic/303 generic/304 generic/305 gen=
eric/306 generic/307 generic/308 generic/309 generic/311 generic/312 generi=
c/313 generic/314 generic/315 generic/316 generic/317 generic/319 generic/3=
20 generic/321 generic/322 generic/324 generic/325 generic/326 generic/327 =
generic/328 generic/329 generic/330 generic/331 generic/332 generic/333 gen=
eric/334 generic/335 generic/336 generic/337 generic/338 generic/340 generi=
c/341 generic/342 generic/343 generic/344 generic/345 generic/346 generic/3=
47 generic/348 generic/352 generic/353 generic/354 generic/355 generic/356 =
generic/358 generic/359 generic/360 generic/361 generic/362 generic/363 gen=
eric/364 generic/365 generic/366 generic/367 generic/368 generic/369 generi=
c/370 generic/371 generic/372 generic/373 generic/374 generic/375 generic/3=
76 generic/377 generic/378
> >  generic/379 generic/380 generic/381 generic/382 generic/383 generic/38=
4 generic/385 generic/386 generic/387 generic/388 generic/389 generic/390 g=
eneric/391 generic/392 generic/393 generic/394 generic/395 generic/396 gene=
ric/397 generic/398 generic/399 generic/400 generic/401 generic/402 generic=
/404 generic/405 generic/406 generic/407 generic/408 generic/409 generic/41=
0 generic/411 generic/412 generic/413 generic/414 generic/415 generic/416 g=
eneric/417 generic/418 generic/419 generic/420 generic/421 generic/424 gene=
ric/427 generic/428 generic/429 generic/430 generic/431 generic/432 generic=
/433 generic/435 generic/436 generic/437 generic/439 generic/440 generic/44=
1 generic/443 generic/444 generic/445 generic/447 generic/448 generic/449 g=
eneric/450 generic/451 generic/452 generic/453 generic/454 generic/455 gene=
ric/456 generic/457 generic/458 generic/459 generic/460 generic/461 generic=
/462 generic/463 generic/464 generic/466 generic/467 generic/468 generic/47=
0 generic/471 generic/472 g
> >  eneric/474 generic/475 generic/477 generic/479 generic/480 generic/481=
 generic/482 generic/483 generic/487 generic/488 generic/489 generic/490 ge=
neric/492 generic/493 generic/494 generic/495 generic/496 generic/497 gener=
ic/498 generic/500 generic/501 generic/502 generic/504 generic/505 generic/=
506 generic/507 generic/508 generic/509 generic/510 generic/511 generic/512=
 generic/514 generic/515 generic/516 generic/517 generic/518 generic/520 ge=
neric/523 generic/524 generic/525 generic/526 generic/527 generic/528 gener=
ic/529 generic/530 generic/532 generic/533 generic/534 generic/535 generic/=
536 generic/537 generic/538 generic/539 generic/540 generic/541 generic/542=
 generic/543 generic/544 generic/545 generic/546 generic/547 generic/548 ge=
neric/549 generic/550 generic/552 generic/553 generic/554 generic/555 gener=
ic/556 generic/557 generic/558 generic/559 generic/560 generic/561 generic/=
562 generic/563 generic/564 generic/566 generic/567 generic/568 generic/569=
 generic/570 generic/572 ge
> >  neric/573 generic/574 generic/575 generic/576 generic/577 generic/579 =
generic/580 generic/581 generic/582 generic/583 generic/584 generic/585 gen=
eric/586 generic/587 generic/588 generic/589 generic/590 generic/591 generi=
c/592 generic/593 generic/594 generic/595 generic/596 generic/597 generic/5=
98 generic/599 generic/600 generic/601 generic/602 generic/603 generic/604 =
generic/605 generic/606 generic/608 generic/609 generic/611 nfs/001 shared/=
002 shared/032 shared/298
> >Not run: generic/003 generic/004 generic/008 generic/009 generic/010 gen=
eric/012 generic/015 generic/016 generic/018 generic/021 generic/022 generi=
c/024 generic/025 generic/026 generic/027 generic/034 generic/038 generic/0=
39 generic/040 generic/041 generic/043 generic/044 generic/045 generic/046 =
generic/047 generic/048 generic/049 generic/050 generic/051 generic/052 gen=
eric/054 generic/055 generic/056 generic/057 generic/058 generic/059 generi=
c/060 generic/061 generic/063 generic/065 generic/066 generic/067 generic/0=
72 generic/073 generic/076 generic/077 generic/078 generic/079 generic/081 =
generic/082 generic/083 generic/085 generic/090 generic/092 generic/093 gen=
eric/095 generic/096 generic/097 generic/099 generic/101 generic/102 generi=
c/104 generic/106 generic/107 generic/108 generic/110 generic/111 generic/1=
14 generic/115 generic/120 generic/121 generic/122 generic/123 generic/128 =
generic/136 generic/137 generic/145 generic/147 generic/149 generic/153 gen=
eric/155 generic/156 gener
> >  ic/158 generic/159 generic/160 generic/162 generic/163 generic/171 gen=
eric/172 generic/173 generic/174 generic/176 generic/177 generic/180 generi=
c/182 generic/192 generic/193 generic/204 generic/205 generic/206 generic/2=
16 generic/217 generic/218 generic/219 generic/220 generic/222 generic/223 =
generic/224 generic/226 generic/227 generic/229 generic/230 generic/231 gen=
eric/232 generic/233 generic/234 generic/235 generic/237 generic/238 generi=
c/241 generic/244 generic/250 generic/252 generic/255 generic/256 generic/2=
59 generic/260 generic/261 generic/262 generic/264 generic/265 generic/266 =
generic/267 generic/268 generic/269 generic/270 generic/271 generic/272 gen=
eric/273 generic/274 generic/275 generic/276 generic/278 generic/279 generi=
c/280 generic/281 generic/282 generic/283 generic/288 generic/297 generic/2=
98 generic/299 generic/300 generic/301 generic/302 generic/304 generic/305 =
generic/307 generic/311 generic/312 generic/314 generic/315 generic/316 gen=
eric/317 generic/319 generi
> >  c/320 generic/321 generic/322 generic/324 generic/325 generic/326 gene=
ric/327 generic/328 generic/329 generic/331 generic/333 generic/334 generic=
/335 generic/336 generic/338 generic/341 generic/342 generic/343 generic/34=
7 generic/348 generic/352 generic/353 generic/355 generic/361 generic/362 g=
eneric/363 generic/364 generic/365 generic/366 generic/367 generic/368 gene=
ric/369 generic/370 generic/371 generic/372 generic/374 generic/375 generic=
/376 generic/378 generic/379 generic/380 generic/381 generic/382 generic/38=
3 generic/384 generic/385 generic/386 generic/387 generic/388 generic/389 g=
eneric/390 generic/392 generic/395 generic/396 generic/397 generic/398 gene=
ric/399 generic/400 generic/402 generic/404 generic/405 generic/408 generic=
/409 generic/410 generic/411 generic/413 generic/414 generic/416 generic/41=
7 generic/418 generic/419 generic/421 generic/424 generic/427 generic/429 g=
eneric/435 generic/440 generic/441 generic/444 generic/447 generic/449 gene=
ric/455 generic/456 generic
> >  /457 generic/458 generic/459 generic/461 generic/462 generic/466 gener=
ic/468 generic/470 generic/471 generic/474 generic/475 generic/479 generic/=
480 generic/481 generic/482 generic/483 generic/487 generic/488 generic/489=
 generic/492 generic/493 generic/497 generic/498 generic/500 generic/501 ge=
neric/502 generic/505 generic/506 generic/507 generic/508 generic/509 gener=
ic/510 generic/511 generic/512 generic/514 generic/515 generic/516 generic/=
517 generic/520 generic/526 generic/527 generic/528 generic/529 generic/530=
 generic/534 generic/535 generic/536 generic/537 generic/545 generic/546 ge=
neric/547 generic/548 generic/549 generic/550 generic/552 generic/553 gener=
ic/555 generic/556 generic/557 generic/558 generic/559 generic/560 generic/=
561 generic/562 generic/563 generic/566 generic/570 generic/572 generic/573=
 generic/574 generic/575 generic/576 generic/577 generic/579 generic/580 ge=
neric/581 generic/582 generic/583 generic/584 generic/585 generic/587 gener=
ic/588 generic/589 generic/
> >  592 generic/593 generic/594 generic/595 generic/596 generic/597 generi=
c/598 generic/599 generic/600 generic/601 generic/602 generic/603 generic/6=
05 generic/606 generic/608 shared/002 shared/032 shared/298
> >Passed all 538 tests
> >
> >[    0.000000] Linux version 5.16.0-00002-g616758bf6583 (bfields@patate.=
fieldses.org) (gcc (GCC) 11.2.1 20211203 (Red Hat 11.2.1-7), GNU ld version=
 2.37-10.fc35) #1278 SMP PREEMPT Wed Jan 12 11:37:28 EST 2022
> >[    0.000000] Command line: BOOT_IMAGE=3D(hd0,msdos1)/vmlinuz-5.16.0-00=
002-g616758bf6583 root=3D/dev/mapper/fedora-root ro resume=3D/dev/mapper/fe=
dora-swap rd.lvm.lv=3Dfedora/root rd.lvm.lv=3Dfedora/swap console=3Dtty0 co=
nsole=3DttyS0,38400n8 consoleblank=3D0
> >[    0.000000] x86/fpu: Supporting XSAVE feature 0x001: 'x87 floating po=
int registers'
> >[    0.000000] x86/fpu: Supporting XSAVE feature 0x002: 'SSE registers'
> >[    0.000000] x86/fpu: Supporting XSAVE feature 0x004: 'AVX registers'
> >[    0.000000] x86/fpu: xstate_offset[2]:  576, xstate_sizes[2]:  256
> >[    0.000000] x86/fpu: Enabled xstate features 0x7, context size is 832=
 bytes, using 'standard' format.
> >[    0.000000] signal: max sigframe size: 1776
> >[    0.000000] BIOS-provided physical RAM map:
> >[    0.000000] BIOS-e820: [mem 0x0000000000000000-0x000000000009fbff] us=
able
> >[    0.000000] BIOS-e820: [mem 0x000000000009fc00-0x000000000009ffff] re=
served
> >[    0.000000] BIOS-e820: [mem 0x00000000000f0000-0x00000000000fffff] re=
served
> >[    0.000000] BIOS-e820: [mem 0x0000000000100000-0x000000007ffdbfff] us=
able
> >[    0.000000] BIOS-e820: [mem 0x000000007ffdc000-0x000000007fffffff] re=
served
> >[    0.000000] BIOS-e820: [mem 0x00000000b0000000-0x00000000bfffffff] re=
served
> >[    0.000000] BIOS-e820: [mem 0x00000000fed1c000-0x00000000fed1ffff] re=
served
> >[    0.000000] BIOS-e820: [mem 0x00000000feffc000-0x00000000feffffff] re=
served
> >[    0.000000] BIOS-e820: [mem 0x00000000fffc0000-0x00000000ffffffff] re=
served
> >[    0.000000] NX (Execute Disable) protection: active
> >[    0.000000] SMBIOS 2.8 present.
> >[    0.000000] DMI: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.14.0-6.f=
c35 04/01/2014
> >[    0.000000] tsc: Fast TSC calibration using PIT
> >[    0.000000] tsc: Detected 3591.787 MHz processor
> >[    0.000930] e820: update [mem 0x00000000-0x00000fff] usable =3D=3D> r=
eserved
> >[    0.000938] e820: remove [mem 0x000a0000-0x000fffff] usable
> >[    0.000946] last_pfn =3D 0x7ffdc max_arch_pfn =3D 0x400000000
> >[    0.000979] x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB  WP  UC-=
 WT
> >[    0.004415] found SMP MP-table at [mem 0x000f5c10-0x000f5c1f]
> >[    0.004436] Using GB pages for direct mapping
> >[    0.004911] RAMDISK: [mem 0x34784000-0x363b9fff]
> >[    0.004919] ACPI: Early table checksum verification disabled
> >[    0.004924] ACPI: RSDP 0x00000000000F5A20 000014 (v00 BOCHS )
> >[    0.004934] ACPI: RSDT 0x000000007FFE2066 000034 (v01 BOCHS  BXPC    =
 00000001 BXPC 00000001)
> >[    0.004943] ACPI: FACP 0x000000007FFE1E8E 0000F4 (v03 BOCHS  BXPC    =
 00000001 BXPC 00000001)
> >[    0.004953] ACPI: DSDT 0x000000007FFE0040 001E4E (v01 BOCHS  BXPC    =
 00000001 BXPC 00000001)
> >[    0.004960] ACPI: FACS 0x000000007FFE0000 000040
> >[    0.004966] ACPI: APIC 0x000000007FFE1F82 000080 (v01 BOCHS  BXPC    =
 00000001 BXPC 00000001)
> >[    0.004972] ACPI: MCFG 0x000000007FFE2002 00003C (v01 BOCHS  BXPC    =
 00000001 BXPC 00000001)
> >[    0.004978] ACPI: WAET 0x000000007FFE203E 000028 (v01 BOCHS  BXPC    =
 00000001 BXPC 00000001)
> >[    0.004984] ACPI: Reserving FACP table memory at [mem 0x7ffe1e8e-0x7f=
fe1f81]
> >[    0.004988] ACPI: Reserving DSDT table memory at [mem 0x7ffe0040-0x7f=
fe1e8d]
> >[    0.004991] ACPI: Reserving FACS table memory at [mem 0x7ffe0000-0x7f=
fe003f]
> >[    0.004993] ACPI: Reserving APIC table memory at [mem 0x7ffe1f82-0x7f=
fe2001]
> >[    0.004996] ACPI: Reserving MCFG table memory at [mem 0x7ffe2002-0x7f=
fe203d]
> >[    0.004999] ACPI: Reserving WAET table memory at [mem 0x7ffe203e-0x7f=
fe2065]
> >[    0.008477] Zone ranges:
> >[    0.008484]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
> >[    0.008491]   DMA32    [mem 0x0000000001000000-0x000000007ffdbfff]
> >[    0.008495]   Normal   empty
> >[    0.008499] Movable zone start for each node
> >[    0.008518] Early memory node ranges
> >[    0.008521]   node   0: [mem 0x0000000000001000-0x000000000009efff]
> >[    0.008535]   node   0: [mem 0x0000000000100000-0x000000007ffdbfff]
> >[    0.008538] Initmem setup node 0 [mem 0x0000000000001000-0x000000007f=
fdbfff]
> >[    0.008548] On node 0, zone DMA: 1 pages in unavailable ranges
> >[    0.008622] On node 0, zone DMA: 97 pages in unavailable ranges
> >[    0.016858] On node 0, zone DMA32: 36 pages in unavailable ranges
> >[    0.048098] kasan: KernelAddressSanitizer initialized
> >[    0.048939] ACPI: PM-Timer IO Port: 0x608
> >[    0.048950] ACPI: LAPIC_NMI (acpi_id[0xff] dfl dfl lint[0x1])
> >[    0.048993] IOAPIC[0]: apic_id 0, version 17, address 0xfec00000, GSI=
 0-23
> >[    0.049002] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
> >[    0.049006] ACPI: INT_SRC_OVR (bus 0 bus_irq 5 global_irq 5 high leve=
l)
> >[    0.049009] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high leve=
l)
> >[    0.049012] ACPI: INT_SRC_OVR (bus 0 bus_irq 10 global_irq 10 high le=
vel)
> >[    0.049015] ACPI: INT_SRC_OVR (bus 0 bus_irq 11 global_irq 11 high le=
vel)
> >[    0.049021] ACPI: Using ACPI (MADT) for SMP configuration information
> >[    0.049024] TSC deadline timer available
> >[    0.049030] smpboot: Allowing 2 CPUs, 0 hotplug CPUs
> >[    0.049050] [mem 0xc0000000-0xfed1bfff] available for PCI devices
> >[    0.049055] clocksource: refined-jiffies: mask: 0xffffffff max_cycles=
: 0xffffffff, max_idle_ns: 7645519600211568 ns
> >[    0.064532] setup_percpu: NR_CPUS:8 nr_cpumask_bits:8 nr_cpu_ids:2 nr=
_node_ids:1
> >[    0.064789] percpu: Embedded 66 pages/cpu s231440 r8192 d30704 u10485=
76
> >[    0.064798] pcpu-alloc: s231440 r8192 d30704 u1048576 alloc=3D1*20971=
52
> >[    0.064802] pcpu-alloc: [0] 0 1
> >[    0.064836] Built 1 zonelists, mobility grouping on.  Total pages: 51=
6828
> >[    0.064886] Kernel command line: BOOT_IMAGE=3D(hd0,msdos1)/vmlinuz-5.=
16.0-00002-g616758bf6583 root=3D/dev/mapper/fedora-root ro resume=3D/dev/ma=
pper/fedora-swap rd.lvm.lv=3Dfedora/root rd.lvm.lv=3Dfedora/swap console=3D=
tty0 console=3DttyS0,38400n8 consoleblank=3D0
> >[    0.064998] Unknown kernel command line parameters "BOOT_IMAGE=3D(hd0=
,msdos1)/vmlinuz-5.16.0-00002-g616758bf6583 resume=3D/dev/mapper/fedora-swa=
p", will be passed to user space.
> >[    0.065286] Dentry cache hash table entries: 262144 (order: 9, 209715=
2 bytes, linear)
> >[    0.065405] Inode-cache hash table entries: 131072 (order: 8, 1048576=
 bytes, linear)
> >[    0.065443] mem auto-init: stack:off, heap alloc:off, heap free:off
> >[    0.217018] Memory: 1653208K/2096616K available (49170K kernel code, =
11662K rwdata, 9292K rodata, 2076K init, 15268K bss, 443152K reserved, 0K c=
ma-reserved)
> >[    0.218927] Kernel/User page tables isolation: enabled
> >[    0.219010] ftrace: allocating 48466 entries in 190 pages
> >[    0.236213] ftrace: allocated 190 pages with 6 groups
> >[    0.236405] Dynamic Preempt: full
> >[    0.236588] Running RCU self tests
> >[    0.236599] rcu: Preemptible hierarchical RCU implementation.
> >[    0.236602] rcu: 	RCU lockdep checking is enabled.
> >[    0.236604] rcu: 	RCU restricting CPUs from NR_CPUS=3D8 to nr_cpu_ids=
=3D2.
> >[    0.236608] 	Trampoline variant of Tasks RCU enabled.
> >[    0.236610] 	Rude variant of Tasks RCU enabled.
> >[    0.236612] 	Tracing variant of Tasks RCU enabled.
> >[    0.236614] rcu: RCU calculated value of scheduler-enlistment delay i=
s 25 jiffies.
> >[    0.236617] rcu: Adjusting geometry for rcu_fanout_leaf=3D16, nr_cpu_=
ids=3D2
> >[    0.246098] NR_IRQS: 4352, nr_irqs: 56, preallocated irqs: 16
> >[    0.246516] random: get_random_bytes called from start_kernel+0x1ef/0=
x384 with crng_init=3D0
> >[    0.252863] Console: colour VGA+ 80x25
> >[    0.285411] printk: console [tty0] enabled
> >[    0.341424] printk: console [ttyS0] enabled
> >[    0.342010] Lock dependency validator: Copyright (c) 2006 Red Hat, In=
c., Ingo Molnar
> >[    0.343034] ... MAX_LOCKDEP_SUBCLASSES:  8
> >[    0.343564] ... MAX_LOCK_DEPTH:          48
> >[    0.344099] ... MAX_LOCKDEP_KEYS:        8192
> >[    0.344657] ... CLASSHASH_SIZE:          4096
> >[    0.345239] ... MAX_LOCKDEP_ENTRIES:     32768
> >[    0.345872] ... MAX_LOCKDEP_CHAINS:      65536
> >[    0.346470] ... CHAINHASH_SIZE:          32768
> >[    0.347042]  memory used by lock dependency info: 6365 kB
> >[    0.347732]  memory used for stack traces: 4224 kB
> >[    0.349158]  per task-struct memory footprint: 1920 bytes
> >[    0.350184] ACPI: Core revision 20210930
> >[    0.351362] APIC: Switch to symmetric I/O mode setup
> >[    0.353278] clocksource: tsc-early: mask: 0xffffffffffffffff max_cycl=
es: 0x33c604d3dd7, max_idle_ns: 440795267083 ns
> >[    0.354743] Calibrating delay loop (skipped), value calculated using =
timer frequency.. 7183.57 BogoMIPS (lpj=3D14367148)
> >[    0.356135] pid_max: default: 32768 minimum: 301
> >[    0.356866] LSM: Security Framework initializing
> >[    0.357606] SELinux:  Initializing.
> >[    0.358214] Mount-cache hash table entries: 4096 (order: 3, 32768 byt=
es, linear)
> >[    0.358743] Mountpoint-cache hash table entries: 4096 (order: 3, 3276=
8 bytes, linear)
> >[    0.358743] x86/cpu: User Mode Instruction Prevention (UMIP) activated
> >[    0.358743] Last level iTLB entries: 4KB 0, 2MB 0, 4MB 0
> >[    0.358743] Last level dTLB entries: 4KB 0, 2MB 0, 4MB 0, 1GB 0
> >[    0.358743] Spectre V1 : Mitigation: usercopy/swapgs barriers and __u=
ser pointer sanitization
> >[    0.358743] Spectre V2 : Mitigation: Full generic retpoline
> >[    0.358743] Spectre V2 : Spectre v2 / SpectreRSB mitigation: Filling =
RSB on context switch
> >[    0.358743] Spectre V2 : Enabling Restricted Speculation for firmware=
 calls
> >[    0.358743] Spectre V2 : mitigation: Enabling conditional Indirect Br=
anch Prediction Barrier
> >[    0.358743] Speculative Store Bypass: Mitigation: Speculative Store B=
ypass disabled via prctl
> >[    0.358743] SRBDS: Unknown: Dependent on hypervisor status
> >[    0.358743] MDS: Mitigation: Clear CPU buffers
> >[    0.358743] Freeing SMP alternatives memory: 44K
> >[    0.358743] smpboot: CPU0: Intel Core Processor (Haswell, no TSX, IBR=
S) (family: 0x6, model: 0x3c, stepping: 0x1)
> >[    0.358743] Running RCU-tasks wait API self tests
> >[    0.458995] Performance Events: unsupported p6 CPU model 60 no PMU dr=
iver, software events only.
> >[    0.460503] rcu: Hierarchical SRCU implementation.
> >[    0.462157] NMI watchdog: Perf NMI watchdog permanently disabled
> >[    0.463002] smp: Bringing up secondary CPUs ...
> >[    0.464950] x86: Booting SMP configuration:
> >[    0.465537] .... node  #0, CPUs:      #1
> >[    0.112317] smpboot: CPU 1 Converting physical 0 to logical die 1
> >[    0.547215] smp: Brought up 1 node, 2 CPUs
> >[    0.547814] smpboot: Max logical packages: 2
> >[    0.548434] smpboot: Total of 2 processors activated (14386.42 BogoMI=
PS)
> >[    0.550634] devtmpfs: initialized
> >[    0.554801] Callback from call_rcu_tasks_trace() invoked.
> >[    0.556772] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffff=
ffff, max_idle_ns: 7645041785100000 ns
> >[    0.558148] futex hash table entries: 512 (order: 4, 65536 bytes, lin=
ear)
> >[    0.560130] NET: Registered PF_NETLINK/PF_ROUTE protocol family
> >[    0.561904] audit: initializing netlink subsys (disabled)
> >[    0.562980] Callback from call_rcu_tasks_rude() invoked.
> >[    0.562980] audit: type=3D2000 audit(1642005631.208:1): state=3Diniti=
alized audit_enabled=3D0 res=3D1
> >[    0.564434] thermal_sys: Registered thermal governor 'step_wise'
> >[    0.564897] thermal_sys: Registered thermal governor 'user_space'
> >[    0.565807] cpuidle: using governor ladder
> >[    0.567202] PCI: MMCONFIG for domain 0000 [bus 00-ff] at [mem 0xb0000=
000-0xbfffffff] (base 0xb0000000)
> >[    0.568443] PCI: MMCONFIG at [mem 0xb0000000-0xbfffffff] reserved in =
E820
> >[    0.569384] PCI: Using configuration type 1 for base access
> >[    0.595171] kprobes: kprobe jump-optimization is enabled. All kprobes=
 are optimized if possible.
> >[    0.597094] HugeTLB registered 2.00 MiB page size, pre-allocated 0 pa=
ges
> >[    0.598409] cryptd: max_cpu_qlen set to 1000
> >[    0.666772] raid6: avx2x4   gen() 33460 MB/s
> >[    0.670759] Callback from call_rcu_tasks() invoked.
> >[    0.738747] raid6: avx2x4   xor() 12834 MB/s
> >[    0.806748] raid6: avx2x2   gen() 31395 MB/s
> >[    0.874753] raid6: avx2x2   xor() 16250 MB/s
> >[    0.942748] raid6: avx2x1   gen() 21106 MB/s
> >[    1.010748] raid6: avx2x1   xor() 13944 MB/s
> >[    1.078749] raid6: sse2x4   gen() 15737 MB/s
> >[    1.146749] raid6: sse2x4   xor()  8765 MB/s
> >[    1.214864] raid6: sse2x2   gen() 15874 MB/s
> >[    1.282747] raid6: sse2x2   xor()  9860 MB/s
> >[    1.350748] raid6: sse2x1   gen() 12302 MB/s
> >[    1.418748] raid6: sse2x1   xor()  8642 MB/s
> >[    1.419372] raid6: using algorithm avx2x4 gen() 33460 MB/s
> >[    1.420108] raid6: .... xor() 12834 MB/s, rmw enabled
> >[    1.420790] raid6: using avx2x2 recovery algorithm
> >[    1.421810] ACPI: Added _OSI(Module Device)
> >[    1.422358] ACPI: Added _OSI(Processor Device)
> >[    1.422750] ACPI: Added _OSI(3.0 _SCP Extensions)
> >[    1.423428] ACPI: Added _OSI(Processor Aggregator Device)
> >[    1.424154] ACPI: Added _OSI(Linux-Dell-Video)
> >[    1.424733] ACPI: Added _OSI(Linux-Lenovo-NV-HDMI-Audio)
> >[    1.425493] ACPI: Added _OSI(Linux-HPI-Hybrid-Graphics)
> >[    1.457880] ACPI: 1 ACPI AML tables successfully acquired and loaded
> >[    1.482752] ACPI: Interpreter enabled
> >[    1.482752] ACPI: PM: (supports S0 S5)
> >[    1.482761] ACPI: Using IOAPIC for interrupt routing
> >[    1.483660] PCI: Using host bridge windows from ACPI; if necessary, u=
se "pci=3Dnocrs" and report a bug
> >[    1.486749] ACPI: Enabled 1 GPEs in block 00 to 3F
> >[    1.519179] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-ff])
> >[    1.520193] acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM C=
lockPM Segments HPX-Type3]
> >[    1.521406] acpi PNP0A08:00: PCIe port services disabled; not request=
ing _OSC control
> >[    1.524178] PCI host bridge to bus 0000:00
> >[    1.525561] pci_bus 0000:00: root bus resource [io  0x0000-0x0cf7 win=
dow]
> >[    1.526771] pci_bus 0000:00: root bus resource [io  0x0d00-0xffff win=
dow]
> >[    1.527754] pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000b=
ffff window]
> >[    1.528814] pci_bus 0000:00: root bus resource [mem 0x80000000-0xafff=
ffff window]
> >[    1.529801] pci_bus 0000:00: root bus resource [mem 0xc0000000-0xfebf=
ffff window]
> >[    1.530753] pci_bus 0000:00: root bus resource [mem 0x100000000-0x8ff=
ffffff window]
> >[    1.531784] pci_bus 0000:00: root bus resource [bus 00-ff]
> >[    1.532720] pci 0000:00:00.0: [8086:29c0] type 00 class 0x060000
> >[    1.535064] pci 0000:00:01.0: [1b36:0100] type 00 class 0x030000
> >[    1.538691] pci 0000:00:01.0: reg 0x10: [mem 0xf4000000-0xf7ffffff]
> >[    1.541347] pci 0000:00:01.0: reg 0x14: [mem 0xf8000000-0xfbffffff]
> >[    1.548136] pci 0000:00:01.0: reg 0x18: [mem 0xfce14000-0xfce15fff]
> >[    1.551749] pci 0000:00:01.0: reg 0x1c: [io  0xc040-0xc05f]
> >[    1.562234] pci 0000:00:01.0: reg 0x30: [mem 0xfce00000-0xfce0ffff pr=
ef]
> >[    1.564193] pci 0000:00:02.0: [1b36:000c] type 01 class 0x060400
> >[    1.566392] pci 0000:00:02.0: reg 0x10: [mem 0xfce16000-0xfce16fff]
> >[    1.570855] pci 0000:00:02.1: [1b36:000c] type 01 class 0x060400
> >[    1.572957] pci 0000:00:02.1: reg 0x10: [mem 0xfce17000-0xfce17fff]
> >[    1.576544] pci 0000:00:02.2: [1b36:000c] type 01 class 0x060400
> >[    1.578655] pci 0000:00:02.2: reg 0x10: [mem 0xfce18000-0xfce18fff]
> >[    1.584327] pci 0000:00:02.3: [1b36:000c] type 01 class 0x060400
> >[    1.587400] pci 0000:00:02.3: reg 0x10: [mem 0xfce19000-0xfce19fff]
> >[    1.591318] pci 0000:00:02.4: [1b36:000c] type 01 class 0x060400
> >[    1.594121] pci 0000:00:02.4: reg 0x10: [mem 0xfce1a000-0xfce1afff]
> >[    1.601524] pci 0000:00:02.5: [1b36:000c] type 01 class 0x060400
> >[    1.603552] pci 0000:00:02.5: reg 0x10: [mem 0xfce1b000-0xfce1bfff]
> >[    1.609104] pci 0000:00:02.6: [1b36:000c] type 01 class 0x060400
> >[    1.611147] pci 0000:00:02.6: reg 0x10: [mem 0xfce1c000-0xfce1cfff]
> >[    1.615049] pci 0000:00:1b.0: [8086:293e] type 00 class 0x040300
> >[    1.616318] pci 0000:00:1b.0: reg 0x10: [mem 0xfce10000-0xfce13fff]
> >[    1.622859] pci 0000:00:1f.0: [8086:2918] type 00 class 0x060100
> >[    1.624201] pci 0000:00:1f.0: quirk: [io  0x0600-0x067f] claimed by I=
CH6 ACPI/GPIO/TCO
> >[    1.626532] pci 0000:00:1f.2: [8086:2922] type 00 class 0x010601
> >[    1.631433] pci 0000:00:1f.2: reg 0x20: [io  0xc060-0xc07f]
> >[    1.633066] pci 0000:00:1f.2: reg 0x24: [mem 0xfce1d000-0xfce1dfff]
> >[    1.635263] pci 0000:00:1f.3: [8086:2930] type 00 class 0x0c0500
> >[    1.638672] pci 0000:00:1f.3: reg 0x20: [io  0x0700-0x073f]
> >[    1.646276] pci 0000:01:00.0: [1af4:1041] type 00 class 0x020000
> >[    1.648447] pci 0000:01:00.0: reg 0x14: [mem 0xfcc40000-0xfcc40fff]
> >[    1.651541] pci 0000:01:00.0: reg 0x20: [mem 0xfea00000-0xfea03fff 64=
bit pref]
> >[    1.654708] pci 0000:01:00.0: reg 0x30: [mem 0xfcc00000-0xfcc3ffff pr=
ef]
> >[    1.656245] pci 0000:00:02.0: PCI bridge to [bus 01]
> >[    1.657166] pci 0000:00:02.0:   bridge window [mem 0xfcc00000-0xfcdff=
fff]
> >[    1.658560] pci 0000:00:02.0:   bridge window [mem 0xfea00000-0xfebff=
fff 64bit pref]
> >[    1.665128] pci 0000:02:00.0: [1b36:000d] type 00 class 0x0c0330
> >[    1.666639] pci 0000:02:00.0: reg 0x10: [mem 0xfca00000-0xfca03fff 64=
bit]
> >[    1.669547] pci 0000:00:02.1: PCI bridge to [bus 02]
> >[    1.670253] pci 0000:00:02.1:   bridge window [mem 0xfca00000-0xfcbff=
fff]
> >[    1.670778] pci 0000:00:02.1:   bridge window [mem 0xfe800000-0xfe9ff=
fff 64bit pref]
> >[    1.672750] pci 0000:03:00.0: [1af4:1043] type 00 class 0x078000
> >[    1.676211] pci 0000:03:00.0: reg 0x14: [mem 0xfc800000-0xfc800fff]
> >[    1.679169] pci 0000:03:00.0: reg 0x20: [mem 0xfe600000-0xfe603fff 64=
bit pref]
> >[    1.682558] pci 0000:00:02.2: PCI bridge to [bus 03]
> >[    1.682793] pci 0000:00:02.2:   bridge window [mem 0xfc800000-0xfc9ff=
fff]
> >[    1.685144] pci 0000:00:02.2:   bridge window [mem 0xfe600000-0xfe7ff=
fff 64bit pref]
> >[    1.687495] pci 0000:04:00.0: [1af4:1042] type 00 class 0x010000
> >[    1.689946] pci 0000:04:00.0: reg 0x14: [mem 0xfc600000-0xfc600fff]
> >[    1.693151] pci 0000:04:00.0: reg 0x20: [mem 0xfe400000-0xfe403fff 64=
bit pref]
> >[    1.700473] pci 0000:00:02.3: PCI bridge to [bus 04]
> >[    1.701209] pci 0000:00:02.3:   bridge window [mem 0xfc600000-0xfc7ff=
fff]
> >[    1.702128] pci 0000:00:02.3:   bridge window [mem 0xfe400000-0xfe5ff=
fff 64bit pref]
> >[    1.703714] pci 0000:05:00.0: [1af4:1045] type 00 class 0x00ff00
> >[    1.707200] pci 0000:05:00.0: reg 0x20: [mem 0xfe200000-0xfe203fff 64=
bit pref]
> >[    1.711310] pci 0000:00:02.4: PCI bridge to [bus 05]
> >[    1.712069] pci 0000:00:02.4:   bridge window [mem 0xfc400000-0xfc5ff=
fff]
> >[    1.713336] pci 0000:00:02.4:   bridge window [mem 0xfe200000-0xfe3ff=
fff 64bit pref]
> >[    1.716482] pci 0000:06:00.0: [1af4:1044] type 00 class 0x00ff00
> >[    1.722542] pci 0000:06:00.0: reg 0x20: [mem 0xfe000000-0xfe003fff 64=
bit pref]
> >[    1.725211] pci 0000:00:02.5: PCI bridge to [bus 06]
> >[    1.726212] pci 0000:00:02.5:   bridge window [mem 0xfc200000-0xfc3ff=
fff]
> >[    1.726791] pci 0000:00:02.5:   bridge window [mem 0xfe000000-0xfe1ff=
fff 64bit pref]
> >[    1.729879] pci 0000:00:02.6: PCI bridge to [bus 07]
> >[    1.730651] pci 0000:00:02.6:   bridge window [mem 0xfc000000-0xfc1ff=
fff]
> >[    1.730778] pci 0000:00:02.6:   bridge window [mem 0xfde00000-0xfdfff=
fff 64bit pref]
> >[    1.736005] pci_bus 0000:00: on NUMA node 0
> >[    1.741503] ACPI: PCI: Interrupt link LNKA configured for IRQ 10
> >[    1.744737] ACPI: PCI: Interrupt link LNKB configured for IRQ 10
> >[    1.746758] ACPI: PCI: Interrupt link LNKC configured for IRQ 11
> >[    1.748846] ACPI: PCI: Interrupt link LNKD configured for IRQ 11
> >[    1.750851] ACPI: PCI: Interrupt link LNKE configured for IRQ 10
> >[    1.752940] ACPI: PCI: Interrupt link LNKF configured for IRQ 10
> >[    1.754949] ACPI: PCI: Interrupt link LNKG configured for IRQ 11
> >[    1.757050] ACPI: PCI: Interrupt link LNKH configured for IRQ 11
> >[    1.758160] ACPI: PCI: Interrupt link GSIA configured for IRQ 16
> >[    1.758938] ACPI: PCI: Interrupt link GSIB configured for IRQ 17
> >[    1.759889] ACPI: PCI: Interrupt link GSIC configured for IRQ 18
> >[    1.760914] ACPI: PCI: Interrupt link GSID configured for IRQ 19
> >[    1.761939] ACPI: PCI: Interrupt link GSIE configured for IRQ 20
> >[    1.766937] ACPI: PCI: Interrupt link GSIF configured for IRQ 21
> >[    1.767962] ACPI: PCI: Interrupt link GSIG configured for IRQ 22
> >[    1.768958] ACPI: PCI: Interrupt link GSIH configured for IRQ 23
> >[    1.773089] pci 0000:00:01.0: vgaarb: setting as boot VGA device
> >[    1.773978] pci 0000:00:01.0: vgaarb: VGA device added: decodes=3Dio+=
mem,owns=3Dio+mem,locks=3Dnone
> >[    1.774767] pci 0000:00:01.0: vgaarb: bridge control possible
> >[    1.775580] vgaarb: loaded
> >[    1.776770] SCSI subsystem initialized
> >[    1.778193] libata version 3.00 loaded.
> >[    1.778193] ACPI: bus type USB registered
> >[    1.778750] usbcore: registered new interface driver usbfs
> >[    1.778857] usbcore: registered new interface driver hub
> >[    1.779636] usbcore: registered new device driver usb
> >[    1.780451] pps_core: LinuxPPS API ver. 1 registered
> >[    1.781112] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodol=
fo Giometti <giometti@linux.it>
> >[    1.782493] PTP clock support registered
> >[    1.784500] EDAC MC: Ver: 3.0.0
> >[    1.785785] Advanced Linux Sound Architecture Driver Initialized.
> >[    1.786798] PCI: Using ACPI for IRQ routing
> >[    1.842255] PCI: pci_cache_line_size set to 64 bytes
> >[    1.842540] e820: reserve RAM buffer [mem 0x0009fc00-0x0009ffff]
> >[    1.842577] e820: reserve RAM buffer [mem 0x7ffdc000-0x7fffffff]
> >[    1.842970] clocksource: Switched to clocksource tsc-early
> >[    2.035298] VFS: Disk quotas dquot_6.6.0
> >[    2.035981] VFS: Dquot-cache hash table entries: 512 (order 0, 4096 b=
ytes)
> >[    2.037121] FS-Cache: Loaded
> >[    2.037960] CacheFiles: Loaded
> >[    2.038518] pnp: PnP ACPI init
> >[    2.040511] system 00:04: [mem 0xb0000000-0xbfffffff window] has been=
 reserved
> >[    2.044352] pnp: PnP ACPI: found 5 devices
> >[    2.064254] clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff=
, max_idle_ns: 2085701024 ns
> >[    2.065958] NET: Registered PF_INET protocol family
> >[    2.066945] IP idents hash table entries: 32768 (order: 6, 262144 byt=
es, linear)
> >[    2.069039] tcp_listen_portaddr_hash hash table entries: 1024 (order:=
 4, 81920 bytes, linear)
> >[    2.070326] TCP established hash table entries: 16384 (order: 5, 1310=
72 bytes, linear)
> >[    2.071828] TCP bind hash table entries: 16384 (order: 8, 1179648 byt=
es, linear)
> >[    2.073288] TCP: Hash tables configured (established 16384 bind 16384)
> >[    2.074354] UDP hash table entries: 1024 (order: 5, 163840 bytes, lin=
ear)
> >[    2.075383] UDP-Lite hash table entries: 1024 (order: 5, 163840 bytes=
, linear)
> >[    2.076613] NET: Registered PF_UNIX/PF_LOCAL protocol family
> >[    2.077413] pci 0000:00:02.0: bridge window [io  0x1000-0x0fff] to [b=
us 01] add_size 1000
> >[    2.078529] pci 0000:00:02.1: bridge window [io  0x1000-0x0fff] to [b=
us 02] add_size 1000
> >[    2.079641] pci 0000:00:02.2: bridge window [io  0x1000-0x0fff] to [b=
us 03] add_size 1000
> >[    2.080719] pci 0000:00:02.3: bridge window [io  0x1000-0x0fff] to [b=
us 04] add_size 1000
> >[    2.081811] pci 0000:00:02.4: bridge window [io  0x1000-0x0fff] to [b=
us 05] add_size 1000
> >[    2.082948] pci 0000:00:02.5: bridge window [io  0x1000-0x0fff] to [b=
us 06] add_size 1000
> >[    2.084025] pci 0000:00:02.6: bridge window [io  0x1000-0x0fff] to [b=
us 07] add_size 1000
> >[    2.085111] pci 0000:00:02.0: BAR 7: assigned [io  0x1000-0x1fff]
> >[    2.085981] pci 0000:00:02.1: BAR 7: assigned [io  0x2000-0x2fff]
> >[    2.086810] pci 0000:00:02.2: BAR 7: assigned [io  0x3000-0x3fff]
> >[    2.087614] pci 0000:00:02.3: BAR 7: assigned [io  0x4000-0x4fff]
> >[    2.088415] pci 0000:00:02.4: BAR 7: assigned [io  0x5000-0x5fff]
> >[    2.089201] pci 0000:00:02.5: BAR 7: assigned [io  0x6000-0x6fff]
> >[    2.090032] pci 0000:00:02.6: BAR 7: assigned [io  0x7000-0x7fff]
> >[    2.091014] pci 0000:00:02.0: PCI bridge to [bus 01]
> >[    2.091666] pci 0000:00:02.0:   bridge window [io  0x1000-0x1fff]
> >[    2.093625] pci 0000:00:02.0:   bridge window [mem 0xfcc00000-0xfcdff=
fff]
> >[    2.096206] pci 0000:00:02.0:   bridge window [mem 0xfea00000-0xfebff=
fff 64bit pref]
> >[    2.098607] pci 0000:00:02.1: PCI bridge to [bus 02]
> >[    2.107557] pci 0000:00:02.1:   bridge window [io  0x2000-0x2fff]
> >[    2.109321] pci 0000:00:02.1:   bridge window [mem 0xfca00000-0xfcbff=
fff]
> >[    2.111058] pci 0000:00:02.1:   bridge window [mem 0xfe800000-0xfe9ff=
fff 64bit pref]
> >[    2.113315] pci 0000:00:02.2: PCI bridge to [bus 03]
> >[    2.114828] pci 0000:00:02.2:   bridge window [io  0x3000-0x3fff]
> >[    2.116339] pci 0000:00:02.2:   bridge window [mem 0xfc800000-0xfc9ff=
fff]
> >[    2.117673] pci 0000:00:02.2:   bridge window [mem 0xfe600000-0xfe7ff=
fff 64bit pref]
> >[    2.119702] pci 0000:00:02.3: PCI bridge to [bus 04]
> >[    2.120377] pci 0000:00:02.3:   bridge window [io  0x4000-0x4fff]
> >[    2.122070] pci 0000:00:02.3:   bridge window [mem 0xfc600000-0xfc7ff=
fff]
> >[    2.123621] pci 0000:00:02.3:   bridge window [mem 0xfe400000-0xfe5ff=
fff 64bit pref]
> >[    2.127750] pci 0000:00:02.4: PCI bridge to [bus 05]
> >[    2.128452] pci 0000:00:02.4:   bridge window [io  0x5000-0x5fff]
> >[    2.129948] pci 0000:00:02.4:   bridge window [mem 0xfc400000-0xfc5ff=
fff]
> >[    2.131293] pci 0000:00:02.4:   bridge window [mem 0xfe200000-0xfe3ff=
fff 64bit pref]
> >[    2.133183] pci 0000:00:02.5: PCI bridge to [bus 06]
> >[    2.133884] pci 0000:00:02.5:   bridge window [io  0x6000-0x6fff]
> >[    2.135463] pci 0000:00:02.5:   bridge window [mem 0xfc200000-0xfc3ff=
fff]
> >[    2.137987] pci 0000:00:02.5:   bridge window [mem 0xfe000000-0xfe1ff=
fff 64bit pref]
> >[    2.139814] pci 0000:00:02.6: PCI bridge to [bus 07]
> >[    2.140490] pci 0000:00:02.6:   bridge window [io  0x7000-0x7fff]
> >[    2.141949] pci 0000:00:02.6:   bridge window [mem 0xfc000000-0xfc1ff=
fff]
> >[    2.143311] pci 0000:00:02.6:   bridge window [mem 0xfde00000-0xfdfff=
fff 64bit pref]
> >[    2.145174] pci_bus 0000:00: resource 4 [io  0x0000-0x0cf7 window]
> >[    2.146052] pci_bus 0000:00: resource 5 [io  0x0d00-0xffff window]
> >[    2.148019] pci_bus 0000:00: resource 6 [mem 0x000a0000-0x000bffff wi=
ndow]
> >[    2.148914] pci_bus 0000:00: resource 7 [mem 0x80000000-0xafffffff wi=
ndow]
> >[    2.149845] pci_bus 0000:00: resource 8 [mem 0xc0000000-0xfebfffff wi=
ndow]
> >[    2.150799] pci_bus 0000:00: resource 9 [mem 0x100000000-0x8ffffffff =
window]
> >[    2.151720] pci_bus 0000:01: resource 0 [io  0x1000-0x1fff]
> >[    2.152452] pci_bus 0000:01: resource 1 [mem 0xfcc00000-0xfcdfffff]
> >[    2.153255] pci_bus 0000:01: resource 2 [mem 0xfea00000-0xfebfffff 64=
bit pref]
> >[    2.154240] pci_bus 0000:02: resource 0 [io  0x2000-0x2fff]
> >[    2.155046] pci_bus 0000:02: resource 1 [mem 0xfca00000-0xfcbfffff]
> >[    2.156636] pci_bus 0000:02: resource 2 [mem 0xfe800000-0xfe9fffff 64=
bit pref]
> >[    2.157602] pci_bus 0000:03: resource 0 [io  0x3000-0x3fff]
> >[    2.158387] pci_bus 0000:03: resource 1 [mem 0xfc800000-0xfc9fffff]
> >[    2.159282] pci_bus 0000:03: resource 2 [mem 0xfe600000-0xfe7fffff 64=
bit pref]
> >[    2.160251] pci_bus 0000:04: resource 0 [io  0x4000-0x4fff]
> >[    2.161035] pci_bus 0000:04: resource 1 [mem 0xfc600000-0xfc7fffff]
> >[    2.161909] pci_bus 0000:04: resource 2 [mem 0xfe400000-0xfe5fffff 64=
bit pref]
> >[    2.162902] pci_bus 0000:05: resource 0 [io  0x5000-0x5fff]
> >[    2.163619] pci_bus 0000:05: resource 1 [mem 0xfc400000-0xfc5fffff]
> >[    2.164420] pci_bus 0000:05: resource 2 [mem 0xfe200000-0xfe3fffff 64=
bit pref]
> >[    2.165342] pci_bus 0000:06: resource 0 [io  0x6000-0x6fff]
> >[    2.166091] pci_bus 0000:06: resource 1 [mem 0xfc200000-0xfc3fffff]
> >[    2.166960] pci_bus 0000:06: resource 2 [mem 0xfe000000-0xfe1fffff 64=
bit pref]
> >[    2.167884] pci_bus 0000:07: resource 0 [io  0x7000-0x7fff]
> >[    2.168599] pci_bus 0000:07: resource 1 [mem 0xfc000000-0xfc1fffff]
> >[    2.169400] pci_bus 0000:07: resource 2 [mem 0xfde00000-0xfdffffff 64=
bit pref]
> >[    2.170541] pci 0000:00:01.0: Video device with shadowed ROM at [mem =
0x000c0000-0x000dffff]
> >[    2.180949] ACPI: \_SB_.GSIG: Enabled at IRQ 22
> >[    2.199686] pci 0000:02:00.0: quirk_usb_early_handoff+0x0/0xa70 took =
27224 usecs
> >[    2.200800] PCI: CLS 0 bytes, default 64
> >[    2.202085] Trying to unpack rootfs image as initramfs...
> >[    2.203583] Initialise system trusted keyrings
> >[    2.204372] workingset: timestamp_bits=3D62 max_order=3D19 bucket_ord=
er=3D0
> >[    2.206592] DLM installed
> >[    2.210086] Key type cifs.idmap registered
> >[    2.210915] fuse: init (API version 7.35)
> >[    2.211730] SGI XFS with ACLs, security attributes, no debug enabled
> >[    2.213541] ocfs2: Registered cluster interface o2cb
> >[    2.214457] ocfs2: Registered cluster interface user
> >[    2.215320] OCFS2 User DLM kernel interface loaded
> >[    2.223471] gfs2: GFS2 installed
> >[    2.232573] xor: automatically using best checksumming function   avx
> >[    2.233488] Key type asymmetric registered
> >[    2.234109] Asymmetric key parser 'x509' registered
> >[    2.235034] Block layer SCSI generic (bsg) driver version 0.4 loaded =
(major 251)
> >[    2.236044] io scheduler mq-deadline registered
> >[    2.236631] io scheduler kyber registered
> >[    2.237151] test_string_helpers: Running tests...
> >[    2.251590] cryptomgr_test (80) used greatest stack depth: 30192 byte=
s left
> >[    2.253812] shpchp: Standard Hot Plug PCI Controller Driver version: =
0.4
> >[    2.255322] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/i=
nput/input0
> >[    2.263630] ACPI: button: Power Button [PWRF]
> >[    2.503777] Serial: 8250/16550 driver, 4 ports, IRQ sharing disabled
> >[    2.505227] 00:00: ttyS0 at I/O 0x3f8 (irq =3D 4, base_baud =3D 11520=
0) is a 16550A
> >[    2.512214] Non-volatile memory driver v1.3
> >[    2.513012] Linux agpgart interface v0.103
> >[    2.515374] ACPI: bus type drm_connector registered
> >[    2.536836] brd: module loaded
> >[    2.553358] loop: module loaded
> >[    2.554597] virtio_blk virtio2: [vda] 41943040 512-byte logical block=
s (21.5 GB/20.0 GiB)
> >[    2.560013]  vda: vda1 vda2
> >[    2.563947] zram: Added device: zram0
> >[    2.565170] ahci 0000:00:1f.2: version 3.0
> >[    2.577984] ACPI: \_SB_.GSIA: Enabled at IRQ 16
> >[    2.581236] ahci 0000:00:1f.2: AHCI 0001.0000 32 slots 6 ports 1.5 Gb=
ps 0x3f impl SATA mode
> >[    2.582629] ahci 0000:00:1f.2: flags: 64bit ncq only
> >[    2.591294] scsi host0: ahci
> >[    2.593071] scsi host1: ahci
> >[    2.594746] scsi host2: ahci
> >[    2.596433] scsi host3: ahci
> >[    2.598107] scsi host4: ahci
> >[    2.599711] scsi host5: ahci
> >[    2.600666] ata1: SATA max UDMA/133 abar m4096@0xfce1d000 port 0xfce1=
d100 irq 16
> >[    2.601704] ata2: SATA max UDMA/133 abar m4096@0xfce1d000 port 0xfce1=
d180 irq 16
> >[    2.602728] ata3: SATA max UDMA/133 abar m4096@0xfce1d000 port 0xfce1=
d200 irq 16
> >[    2.603965] ata4: SATA max UDMA/133 abar m4096@0xfce1d000 port 0xfce1=
d280 irq 16
> >[    2.604966] ata5: SATA max UDMA/133 abar m4096@0xfce1d000 port 0xfce1=
d300 irq 16
> >[    2.606025] ata6: SATA max UDMA/133 abar m4096@0xfce1d000 port 0xfce1=
d380 irq 16
> >[    2.608967] tun: Universal TUN/TAP device driver, 1.6
> >[    2.615031] e1000: Intel(R) PRO/1000 Network Driver
> >[    2.615697] e1000: Copyright (c) 1999-2006 Intel Corporation.
> >[    2.616600] e1000e: Intel(R) PRO/1000 Network Driver
> >[    2.617285] e1000e: Copyright(c) 1999 - 2015 Intel Corporation.
> >[    2.618418] PPP generic driver version 2.4.2
> >[    2.621200] aoe: AoE v85 initialised.
> >[    2.622145] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
> >[    2.623064] ehci-pci: EHCI PCI platform driver
> >[    2.623725] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
> >[    2.624583] ohci-pci: OHCI PCI platform driver
> >[    2.625273] uhci_hcd: USB Universal Host Controller Interface driver
> >[    2.626383] usbcore: registered new interface driver usblp
> >[    2.627485] usbcore: registered new interface driver usb-storage
> >[    2.628515] i8042: PNP: PS/2 Controller [PNP0303:KBD,PNP0f13:MOU] at =
0x60,0x64 irq 1,12
> >[    2.630612] serio: i8042 KBD port at 0x60,0x64 irq 1
> >[    2.632241] serio: i8042 AUX port at 0x60,0x64 irq 12
> >[    2.633725] mousedev: PS/2 mouse device common for all mice
> >[    2.635967] input: AT Translated Set 2 keyboard as /devices/platform/=
i8042/serio0/input/input1
> >[    2.641790] input: PC Speaker as /devices/platform/pcspkr/input/input4
> >[    2.665764] i801_smbus 0000:00:1f.3: SMBus using PCI interrupt
> >[    2.667260] i2c i2c-0: 1/1 memory slots populated (from DMI)
> >[    2.668024] i2c i2c-0: Memory type 0x07 not supported yet, not instan=
tiating SPD
> >[    2.675052] device-mapper: core: CONFIG_IMA_DISABLE_HTABLE is disable=
d. Duplicate IMA measurements will not be recorded in the IMA log.
> >[    2.676742] device-mapper: uevent: version 1.0.3
> >[    2.678918] device-mapper: ioctl: 4.45.0-ioctl (2021-03-22) initialis=
ed: dm-devel@redhat.com
> >[    2.683257] device-mapper: multipath round-robin: version 1.2.0 loaded
> >[    2.684241] intel_pstate: CPU model not supported
> >[    2.688823] usbcore: registered new interface driver usbhid
> >[    2.689598] usbhid: USB HID core driver
> >[    2.705474] netem: version 1.3
> >[    2.706277] NET: Registered PF_INET6 protocol family
> >[    2.712188] Segment Routing with IPv6
> >[    2.712717] In-situ OAM (IOAM) with IPv6
> >[    2.713285] sit: IPv6, IPv4 and MPLS over IPv4 tunneling driver
> >[    2.715480] NET: Registered PF_PACKET protocol family
> >[    2.716182] NET: Registered PF_KEY protocol family
> >[    2.716862] sctp: Hash tables configured (bind 32/56)
> >[    2.717728] Key type dns_resolver registered
> >[    2.726933] IPI shorthand broadcast: enabled
> >[    2.727537] AVX2 version of gcm_enc/dec engaged.
> >[    2.728259] AES CTR mode by8 optimization enabled
> >[    2.730257] sched_clock: Marking stable (2618472228, 108317297)->(278=
2282047, -55492522)
> >[    2.735020] Loading compiled-in X.509 certificates
> >[    2.736126] debug_vm_pgtable: [debug_vm_pgtable         ]: Validating=
 architecture page table helpers
> >[    2.738851] Btrfs loaded, crc32c=3Dcrc32c-intel, zoned=3Dno, fsverity=
=3Dno
> >[    2.739983] ima: No TPM chip found, activating TPM-bypass!
> >[    2.746925] ima: Allocated hash algorithm: sha1
> >[    2.747568] ima: No architecture policies found
> >[    2.760119] cryptomgr_test (960) used greatest stack depth: 29896 byt=
es left
> >[    2.774263] ALSA device list:
> >[    2.774801]   #0: Virtual MIDI Card 1
> >[    2.927000] ata2: SATA link down (SStatus 0 SControl 300)
> >[    2.928006] ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
> >[    2.929043] ata1.00: ATAPI: QEMU DVD-ROM, 2.5+, max UDMA/100
> >[    2.929850] ata1.00: applying bridge limits
> >[    2.930655] ata1.00: configured for UDMA/100
> >[    2.943534] ata3: SATA link down (SStatus 0 SControl 300)
> >[    2.944410] ata5: SATA link down (SStatus 0 SControl 300)
> >[    2.945288] ata4: SATA link down (SStatus 0 SControl 300)
> >[    2.947488] scsi 0:0:0:0: CD-ROM            QEMU     QEMU DVD-ROM    =
 2.5+ PQ: 0 ANSI: 5
> >[    2.950893] ata6: SATA link down (SStatus 0 SControl 300)
> >[    2.983329] sr 0:0:0:0: [sr0] scsi3-mmc drive: 4x/4x cd/rw xa/form2 t=
ray
> >[    2.984315] cdrom: Uniform CD-ROM driver Revision: 3.20
> >[    3.002413] Freeing initrd memory: 28888K
> >[    3.003747] kworker/u4:10 (919) used greatest stack depth: 28568 byte=
s left
> >[    3.007194] kworker/u4:2 (706) used greatest stack depth: 28384 bytes=
 left
> >[    3.083826] sr 0:0:0:0: Attached scsi CD-ROM sr0
> >[    3.085147] sr 0:0:0:0: Attached scsi generic sg0 type 5
> >[    3.103164] Freeing unused kernel image (initmem) memory: 2076K
> >[    3.117192] Write protecting the kernel read-only data: 61440k
> >[    3.120374] Freeing unused kernel image (text/rodata gap) memory: 202=
8K
> >[    3.122810] Freeing unused kernel image (rodata/data gap) memory: 948K
> >[    3.126083] Run /init as init process
> >[    3.127909]   with arguments:
> >[    3.127914]     /init
> >[    3.127917]   with environment:
> >[    3.127920]     HOME=3D/
> >[    3.127923]     TERM=3Dlinux
> >[    3.127926]     BOOT_IMAGE=3D(hd0,msdos1)/vmlinuz-5.16.0-00002-g61675=
8bf6583
> >[    3.127929]     resume=3D/dev/mapper/fedora-swap
> >[    3.177129] systemd[1]: systemd v246.13-1.fc33 running in system mode=
=2E (+PAM +AUDIT +SELINUX +IMA -APPARMOR +SMACK +SYSVINIT +UTMP +LIBCRYPTSE=
TUP +GCRYPT +GNUTLS +ACL +XZ +LZ4 +ZSTD +SECCOMP +BLKID +ELFUTILS +KMOD +ID=
N2 -IDN +PCRE2 default-hierarchy=3Dunified)
> >[    3.191635] systemd[1]: Detected virtualization kvm.
> >[    3.192554] systemd[1]: Detected architecture x86-64.
> >[    3.193497] systemd[1]: Running in initial RAM disk.
> >[    3.200495] systemd[1]: Set hostname to <test3.fieldses.org>.
> >[    3.206888] tsc: Refined TSC clocksource calibration: 3591.601 MHz
> >[    3.207931] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x=
33c55573deb, max_idle_ns: 440795385523 ns
> >[    3.209808] clocksource: Switched to clocksource tsc
> >[    3.276323] input: ImExPS/2 Generic Explorer Mouse as /devices/platfo=
rm/i8042/serio1/input/input3
> >[    3.410362] dracut-rootfs-g (994) used greatest stack depth: 28168 by=
tes left
> >[    3.459425] systemd[1]: /usr/lib/systemd/system/plymouth-start.servic=
e:15: Unit configured to use KillMode=3Dnone. This is unsafe, as it disable=
s systemd's process lifecycle management for the service. Please update you=
r service to use a safer KillMode=3D, such as 'mixed' or 'control-group'. S=
upport for KillMode=3Dnone is deprecated and will eventually be removed.
> >[    3.483169] systemd[1]: Queued start job for default target Initrd De=
fault Target.
> >[    3.486365] systemd[1]: Created slice system-systemd\x2dhibernate\x2d=
resume.slice.
> >[    3.490492] systemd[1]: Reached target Slices.
> >[    3.492032] systemd[1]: Reached target Swap.
> >[    3.493442] systemd[1]: Reached target Timers.
> >[    3.496270] systemd[1]: Listening on Journal Audit Socket.
> >[    3.499878] systemd[1]: Listening on Journal Socket (/dev/log).
> >[    3.503436] systemd[1]: Listening on Journal Socket.
> >[    3.506420] systemd[1]: Listening on udev Control Socket.
> >[    3.509264] systemd[1]: Listening on udev Kernel Socket.
> >[    3.511877] systemd[1]: Reached target Sockets.
> >[    3.513442] systemd[1]: Condition check resulted in Create list of st=
atic device nodes for the current kernel being skipped.
> >[    3.520259] systemd[1]: Started Memstrack Anylazing Service.
> >[    3.527783] systemd[1]: Started Hardware RNG Entropy Gatherer Daemon.
> >[    3.530307] systemd[1]: systemd-journald.service: unit configures an =
IP firewall, but the local system does not support BPF/cgroup firewalling.
> >[    3.532742] systemd[1]: (This warning is only shown for the first uni=
t using IP firewalling.)
> >[    3.540109] systemd[1]: Starting Journal Service...
> >[    3.550015] systemd[1]: Starting Load Kernel Modules...
> >[    3.559017] systemd[1]: Starting Create Static Device Nodes in /dev...
> >[    3.565890] random: rngd: uninitialized urandom read (16 bytes read)
> >[    3.579371] systemd[1]: Starting Setup Virtual Console...
> >[    3.611362] systemd[1]: memstrack.service: Succeeded.
> >[    3.627660] systemd[1]: Finished Create Static Device Nodes in /dev.
> >[    3.668283] systemd[1]: Finished Load Kernel Modules.
> >[    3.683342] systemd[1]: Starting Apply Kernel Variables...
> >[    3.793704] systemd[1]: Finished Apply Kernel Variables.
> >[    3.852545] audit: type=3D1130 audit(1642005634.495:2): pid=3D1 uid=
=3D0 auid=3D4294967295 ses=3D4294967295 subj=3Dkernel msg=3D'unit=3Dsystemd=
-sysctl comm=3D"systemd" exe=3D"/usr/lib/systemd/systemd" hostname=3D? addr=
=3D? terminal=3D? res=3Dsuccess'
> >[    4.017096] systemd[1]: Started Journal Service.
> >[    4.019152] audit: type=3D1130 audit(1642005634.663:3): pid=3D1 uid=
=3D0 auid=3D4294967295 ses=3D4294967295 subj=3Dkernel msg=3D'unit=3Dsystemd=
-journald comm=3D"systemd" exe=3D"/usr/lib/systemd/systemd" hostname=3D? ad=
dr=3D? terminal=3D? res=3Dsuccess'
> >[    4.367941] audit: type=3D1130 audit(1642005635.011:4): pid=3D1 uid=
=3D0 auid=3D4294967295 ses=3D4294967295 subj=3Dkernel msg=3D'unit=3Dsystemd=
-vconsole-setup comm=3D"systemd" exe=3D"/usr/lib/systemd/systemd" hostname=
=3D? addr=3D? terminal=3D? res=3Dsuccess'
> >[    5.158530] audit: type=3D1130 audit(1642005635.799:5): pid=3D1 uid=
=3D0 auid=3D4294967295 ses=3D4294967295 subj=3Dkernel msg=3D'unit=3Ddracut-=
cmdline comm=3D"systemd" exe=3D"/usr/lib/systemd/systemd" hostname=3D? addr=
=3D? terminal=3D? res=3Dsuccess'
> >[    5.240723] random: crng init done
> >[    5.428343] audit: type=3D1130 audit(1642005636.071:6): pid=3D1 uid=
=3D0 auid=3D4294967295 ses=3D4294967295 subj=3Dkernel msg=3D'unit=3Ddracut-=
pre-udev comm=3D"systemd" exe=3D"/usr/lib/systemd/systemd" hostname=3D? add=
r=3D? terminal=3D? res=3Dsuccess'
> >[    5.562117] audit: type=3D1130 audit(1642005636.203:7): pid=3D1 uid=
=3D0 auid=3D4294967295 ses=3D4294967295 subj=3Dkernel msg=3D'unit=3Dsystemd=
-udevd comm=3D"systemd" exe=3D"/usr/lib/systemd/systemd" hostname=3D? addr=
=3D? terminal=3D? res=3Dsuccess'
> >[    5.826193] kworker/u4:0 (1195) used greatest stack depth: 27960 byte=
s left
> >[    7.667205] virtio_net virtio0 enp1s0: renamed from eth0
> >[    8.061253] ata_id (1566) used greatest stack depth: 27648 bytes left
> >[    8.873062] audit: type=3D1130 audit(1642005639.515:8): pid=3D1 uid=
=3D0 auid=3D4294967295 ses=3D4294967295 subj=3Dkernel msg=3D'unit=3Dsystemd=
-udev-trigger comm=3D"systemd" exe=3D"/usr/lib/systemd/systemd" hostname=3D=
? addr=3D? terminal=3D? res=3Dsuccess'
> >[    9.126782] audit: type=3D1130 audit(1642005639.767:9): pid=3D1 uid=
=3D0 auid=3D4294967295 ses=3D4294967295 subj=3Dkernel msg=3D'unit=3Dplymout=
h-start comm=3D"systemd" exe=3D"/usr/lib/systemd/systemd" hostname=3D? addr=
=3D? terminal=3D? res=3Dsuccess'
> >[    9.898584] lvm (2335) used greatest stack depth: 27600 bytes left
> >[   10.171243] lvm (2337) used greatest stack depth: 27504 bytes left
> >[   10.389632] audit: type=3D1130 audit(1642005641.031:10): pid=3D1 uid=
=3D0 auid=3D4294967295 ses=3D4294967295 subj=3Dkernel msg=3D'unit=3Dsystemd=
-hibernate-resume@dev-mapper-fedora\x2dswap comm=3D"systemd" exe=3D"/usr/li=
b/systemd/systemd" hostname=3D? addr=3D? terminal=3D? res=3Dfailed'
> >[   10.456068] audit: type=3D1130 audit(1642005641.099:11): pid=3D1 uid=
=3D0 auid=3D4294967295 ses=3D4294967295 subj=3Dkernel msg=3D'unit=3Dsystemd=
-tmpfiles-setup comm=3D"systemd" exe=3D"/usr/lib/systemd/systemd" hostname=
=3D? addr=3D? terminal=3D? res=3Dsuccess'
> >[   10.477828] dracut-initqueu (2286) used greatest stack depth: 27416 b=
ytes left
> >[   10.481902] audit: type=3D1130 audit(1642005641.123:12): pid=3D1 uid=
=3D0 auid=3D4294967295 ses=3D4294967295 subj=3Dkernel msg=3D'unit=3Ddracut-=
initqueue comm=3D"systemd" exe=3D"/usr/lib/systemd/systemd" hostname=3D? ad=
dr=3D? terminal=3D? res=3Dsuccess'
> >[   10.545851] fsck (2364) used greatest stack depth: 26560 bytes left
> >[   10.555806] audit: type=3D1130 audit(1642005641.195:13): pid=3D1 uid=
=3D0 auid=3D4294967295 ses=3D4294967295 subj=3Dkernel msg=3D'unit=3Dsystemd=
-fsck-root comm=3D"systemd" exe=3D"/usr/lib/systemd/systemd" hostname=3D? a=
ddr=3D? terminal=3D? res=3Dsuccess'
> >[   10.584297] XFS (dm-0): Mounting V5 Filesystem
> >[   10.767936] XFS (dm-0): Ending clean mount
> >[   10.840832] mount (2366) used greatest stack depth: 25344 bytes left
> >[   10.996402] systemd-fstab-g (2379) used greatest stack depth: 24872 b=
ytes left
> >[   11.699148] audit: type=3D1130 audit(1642005642.339:14): pid=3D1 uid=
=3D0 auid=3D4294967295 ses=3D4294967295 subj=3Dkernel msg=3D'unit=3Dinitrd-=
parse-etc comm=3D"systemd" exe=3D"/usr/lib/systemd/systemd" hostname=3D? ad=
dr=3D? terminal=3D? res=3Dsuccess'
> >[   11.702004] audit: type=3D1131 audit(1642005642.339:15): pid=3D1 uid=
=3D0 auid=3D4294967295 ses=3D4294967295 subj=3Dkernel msg=3D'unit=3Dinitrd-=
parse-etc comm=3D"systemd" exe=3D"/usr/lib/systemd/systemd" hostname=3D? ad=
dr=3D? terminal=3D? res=3Dsuccess'
> >[   11.858512] audit: type=3D1130 audit(1642005642.499:16): pid=3D1 uid=
=3D0 auid=3D4294967295 ses=3D4294967295 subj=3Dkernel msg=3D'unit=3Ddracut-=
pre-pivot comm=3D"systemd" exe=3D"/usr/lib/systemd/systemd" hostname=3D? ad=
dr=3D? terminal=3D? res=3Dsuccess'
> >[   11.895749] audit: type=3D1131 audit(1642005642.535:17): pid=3D1 uid=
=3D0 auid=3D4294967295 ses=3D4294967295 subj=3Dkernel msg=3D'unit=3Ddracut-=
pre-pivot comm=3D"systemd" exe=3D"/usr/lib/systemd/systemd" hostname=3D? ad=
dr=3D? terminal=3D? res=3Dsuccess'
> >[   14.895253] SELinux:  Permission watch in class filesystem not define=
d in policy.
> >[   14.896380] SELinux:  Permission watch in class file not defined in p=
olicy.
> >[   14.898184] SELinux:  Permission watch_mount in class file not define=
d in policy.
> >[   14.899597] SELinux:  Permission watch_sb in class file not defined i=
n policy.
> >[   14.900888] SELinux:  Permission watch_with_perm in class file not de=
fined in policy.
> >[   14.902011] SELinux:  Permission watch_reads in class file not define=
d in policy.
> >[   14.903080] SELinux:  Permission watch in class dir not defined in po=
licy.
> >[   14.915479] SELinux:  Permission watch_mount in class dir not defined=
 in policy.
> >[   14.916793] SELinux:  Permission watch_sb in class dir not defined in=
 policy.
> >[   14.918117] SELinux:  Permission watch_with_perm in class dir not def=
ined in policy.
> >[   14.919521] SELinux:  Permission watch_reads in class dir not defined=
 in policy.
> >[   14.920832] SELinux:  Permission watch in class lnk_file not defined =
in policy.
> >[   14.922158] SELinux:  Permission watch_mount in class lnk_file not de=
fined in policy.
> >[   14.923410] SELinux:  Permission watch_sb in class lnk_file not defin=
ed in policy.
> >[   14.924406] SELinux:  Permission watch_with_perm in class lnk_file no=
t defined in policy.
> >[   14.925567] SELinux:  Permission watch_reads in class lnk_file not de=
fined in policy.
> >[   14.927302] SELinux:  Permission watch in class chr_file not defined =
in policy.
> >[   14.928363] SELinux:  Permission watch_mount in class chr_file not de=
fined in policy.
> >[   14.929448] SELinux:  Permission watch_sb in class chr_file not defin=
ed in policy.
> >[   14.930486] SELinux:  Permission watch_with_perm in class chr_file no=
t defined in policy.
> >[   14.931631] SELinux:  Permission watch_reads in class chr_file not de=
fined in policy.
> >[   14.932702] SELinux:  Permission watch in class blk_file not defined =
in policy.
> >[   14.933695] SELinux:  Permission watch_mount in class blk_file not de=
fined in policy.
> >[   14.934779] SELinux:  Permission watch_sb in class blk_file not defin=
ed in policy.
> >[   14.935782] SELinux:  Permission watch_with_perm in class blk_file no=
t defined in policy.
> >[   14.936834] SELinux:  Permission watch_reads in class blk_file not de=
fined in policy.
> >[   14.937933] SELinux:  Permission watch in class sock_file not defined=
 in policy.
> >[   14.938979] SELinux:  Permission watch_mount in class sock_file not d=
efined in policy.
> >[   14.940022] SELinux:  Permission watch_sb in class sock_file not defi=
ned in policy.
> >[   14.941043] SELinux:  Permission watch_with_perm in class sock_file n=
ot defined in policy.
> >[   14.942178] SELinux:  Permission watch_reads in class sock_file not d=
efined in policy.
> >[   14.943287] SELinux:  Permission watch in class fifo_file not defined=
 in policy.
> >[   14.944263] SELinux:  Permission watch_mount in class fifo_file not d=
efined in policy.
> >[   14.945325] SELinux:  Permission watch_sb in class fifo_file not defi=
ned in policy.
> >[   14.946386] SELinux:  Permission watch_with_perm in class fifo_file n=
ot defined in policy.
> >[   14.947525] SELinux:  Permission watch_reads in class fifo_file not d=
efined in policy.
> >[   14.948611] SELinux:  Permission perfmon in class capability2 not def=
ined in policy.
> >[   14.949662] SELinux:  Permission bpf in class capability2 not defined=
 in policy.
> >[   14.950682] SELinux:  Permission checkpoint_restore in class capabili=
ty2 not defined in policy.
> >[   14.951921] SELinux:  Permission perfmon in class cap2_userns not def=
ined in policy.
> >[   14.952939] SELinux:  Permission bpf in class cap2_userns not defined=
 in policy.
> >[   14.953970] SELinux:  Permission checkpoint_restore in class cap2_use=
rns not defined in policy.
> >[   14.955277] SELinux:  Class mctp_socket not defined in policy.
> >[   14.956110] SELinux:  Class perf_event not defined in policy.
> >[   14.957746] SELinux:  Class anon_inode not defined in policy.
> >[   14.958536] SELinux:  Class io_uring not defined in policy.
> >[   14.959313] SELinux: the above unknown classes and permissions will b=
e allowed
> >[   15.013559] SELinux:  policy capability network_peer_controls=3D1
> >[   15.014417] SELinux:  policy capability open_perms=3D1
> >[   15.015183] SELinux:  policy capability extended_socket_class=3D1
> >[   15.015968] SELinux:  policy capability always_check_network=3D0
> >[   15.017534] SELinux:  policy capability cgroup_seclabel=3D1
> >[   15.018305] SELinux:  policy capability nnp_nosuid_transition=3D1
> >[   15.019126] SELinux:  policy capability genfs_seclabel_symlinks=3D0
> >[   15.244501] kauditd_printk_skb: 16 callbacks suppressed
> >[   15.244506] audit: type=3D1403 audit(1642005645.887:34): auid=3D42949=
67295 ses=3D4294967295 lsm=3Dselinux res=3D1
> >[   15.255513] systemd[1]: Successfully loaded SELinux policy in 2.76632=
3s.
> >[   15.619234] systemd[1]: Relabelled /dev, /dev/shm, /run, /sys/fs/cgro=
up in 261.945ms.
> >[   15.628383] systemd[1]: systemd v246.13-1.fc33 running in system mode=
=2E (+PAM +AUDIT +SELINUX +IMA -APPARMOR +SMACK +SYSVINIT +UTMP +LIBCRYPTSE=
TUP +GCRYPT +GNUTLS +ACL +XZ +LZ4 +ZSTD +SECCOMP +BLKID +ELFUTILS +KMOD +ID=
N2 -IDN +PCRE2 default-hierarchy=3Dunified)
> >[   15.632666] systemd[1]: Detected virtualization kvm.
> >[   15.633353] systemd[1]: Detected architecture x86-64.
> >[   15.639738] systemd[1]: Set hostname to <test3.fieldses.org>.
> >[   15.905148] lvmconfig (2442) used greatest stack depth: 24544 bytes l=
eft
> >[   15.941811] kdump-dep-gener (2432) used greatest stack depth: 24464 b=
ytes left
> >[   15.942995] grep (2450) used greatest stack depth: 24448 bytes left
> >[   16.222623] systemd[1]: /usr/lib/systemd/system/plymouth-start.servic=
e:15: Unit configured to use KillMode=3Dnone. This is unsafe, as it disable=
s systemd's process lifecycle management for the service. Please update you=
r service to use a safer KillMode=3D, such as 'mixed' or 'control-group'. S=
upport for KillMode=3Dnone is deprecated and will eventually be removed.
> >[   16.548178] systemd[1]: /usr/lib/systemd/system/mcelog.service:8: Sta=
ndard output type syslog is obsolete, automatically updating to journal. Pl=
ease update your unit file, and consider removing the setting altogether.
> >[   17.024523] audit: type=3D1131 audit(1642005647.667:35): pid=3D1 uid=
=3D0 auid=3D4294967295 ses=3D4294967295 subj=3Dsystem_u:system_r:init_t:s0 =
msg=3D'unit=3Dsystemd-journald comm=3D"systemd" exe=3D"/usr/lib/systemd/sys=
temd" hostname=3D? addr=3D? terminal=3D? res=3Dsuccess'
> >[   17.032331] systemd[1]: initrd-switch-root.service: Succeeded.
> >[   17.034511] systemd[1]: Stopped Switch Root.
> >[   17.037797] audit: type=3D1130 audit(1642005647.679:36): pid=3D1 uid=
=3D0 auid=3D4294967295 ses=3D4294967295 subj=3Dsystem_u:system_r:init_t:s0 =
msg=3D'unit=3Dinitrd-switch-root comm=3D"systemd" exe=3D"/usr/lib/systemd/s=
ystemd" hostname=3D? addr=3D? terminal=3D? res=3Dsuccess'
> >[   17.039820] systemd[1]: systemd-journald.service: Scheduled restart j=
ob, restart counter is at 1.
> >[   17.040822] audit: type=3D1131 audit(1642005647.679:37): pid=3D1 uid=
=3D0 auid=3D4294967295 ses=3D4294967295 subj=3Dsystem_u:system_r:init_t:s0 =
msg=3D'unit=3Dinitrd-switch-root comm=3D"systemd" exe=3D"/usr/lib/systemd/s=
ystemd" hostname=3D? addr=3D? terminal=3D? res=3Dsuccess'
> >[   17.044319] systemd[1]: Created slice system-getty.slice.
> >[   17.048401] systemd[1]: Created slice system-modprobe.slice.
> >[   17.052765] systemd[1]: Created slice system-serial\x2dgetty.slice.
> >[   17.055258] systemd[1]: Created slice system-sshd\x2dkeygen.slice.
> >[   17.058406] systemd[1]: Created slice User and Session Slice.
> >[   17.060191] systemd[1]: Condition check resulted in Dispatch Password=
 Requests to Console Directory Watch being skipped.
> >[   17.063067] systemd[1]: Started Forward Password Requests to Wall Dir=
ectory Watch.
> >[   17.066845] systemd[1]: Set up automount Arbitrary Executable File Fo=
rmats File System Automount Point.
> >[   17.068244] systemd[1]: Reached target Local Encrypted Volumes.
> >[   17.070271] systemd[1]: Stopped target Switch Root.
> >[   17.071236] systemd[1]: Stopped target Initrd File Systems.
> >[   17.072219] systemd[1]: Stopped target Initrd Root File System.
> >[   17.075495] systemd[1]: Reached target Paths.
> >[   17.076283] systemd[1]: Reached target Slices.
> >[   17.080904] systemd[1]: Listening on Device-mapper event daemon FIFOs.
> >[   17.084889] systemd[1]: Listening on LVM2 poll daemon socket.
> >[   17.087729] systemd[1]: Listening on multipathd control socket.
> >[   17.093018] systemd[1]: Listening on Process Core Dump Socket.
> >[   17.095415] systemd[1]: Listening on initctl Compatibility Named Pipe.
> >[   17.099466] systemd[1]: Listening on udev Control Socket.
> >[   17.102467] systemd[1]: Listening on udev Kernel Socket.
> >[   17.109715] systemd[1]: Activating swap /dev/mapper/fedora-swap...
> >[   17.117743] systemd[1]: Mounting Huge Pages File System...
> >[   17.125890] systemd[1]: Mounting POSIX Message Queue File System...
> >[   17.130492] Adding 2097148k swap on /dev/mapper/fedora-swap.  Priorit=
y:-2 extents:1 across:2097148k
> >[   17.140236] systemd[1]: Mounting Kernel Debug File System...
> >[   17.149754] systemd[1]: Starting Kernel Module supporting RPCSEC_GSS.=
=2E.
> >[   17.151753] systemd[1]: Condition check resulted in Create list of st=
atic device nodes for the current kernel being skipped.
> >[   17.159082] systemd[1]: Starting Monitoring of LVM2 mirrors, snapshot=
s etc. using dmeventd or progress polling...
> >[   17.166647] systemd[1]: Starting Load Kernel Module configfs...
> >[   17.173097] systemd[1]: Starting Load Kernel Module drm...
> >[   17.181757] systemd[1]: Starting Load Kernel Module fuse...
> >[   17.199195] systemd[1]: Starting Preprocess NFS configuration convert=
ion...
> >[   17.203114] systemd[1]: plymouth-switch-root.service: Succeeded.
> >[   17.217307] systemd[1]: Stopped Plymouth switch root service.
> >[   17.220790] audit: type=3D1131 audit(1642005647.863:38): pid=3D1 uid=
=3D0 auid=3D4294967295 ses=3D4294967295 subj=3Dsystem_u:system_r:init_t:s0 =
msg=3D'unit=3Dplymouth-switch-root comm=3D"systemd" exe=3D"/usr/lib/systemd=
/systemd" hostname=3D? addr=3D? terminal=3D? res=3Dsuccess'
> >[   17.222477] systemd[1]: Condition check resulted in Set Up Additional=
 Binary Formats being skipped.
> >[   17.235950] systemd[1]: systemd-fsck-root.service: Succeeded.
> >[   17.239114] systemd[1]: Stopped File System Check on Root Device.
> >[   17.241914] systemd[1]: Stopped Journal Service.
> >[   17.246822] audit: type=3D1131 audit(1642005647.883:39): pid=3D1 uid=
=3D0 auid=3D4294967295 ses=3D4294967295 subj=3Dsystem_u:system_r:init_t:s0 =
msg=3D'unit=3Dsystemd-fsck-root comm=3D"systemd" exe=3D"/usr/lib/systemd/sy=
stemd" hostname=3D? addr=3D? terminal=3D? res=3Dsuccess'
> >[   17.248647] systemd[1]: Starting Journal Service...
> >[   17.250212] audit: type=3D1130 audit(1642005647.883:40): pid=3D1 uid=
=3D0 auid=3D4294967295 ses=3D4294967295 subj=3Dsystem_u:system_r:init_t:s0 =
msg=3D'unit=3Dsystemd-journald comm=3D"systemd" exe=3D"/usr/lib/systemd/sys=
temd" hostname=3D? addr=3D? terminal=3D? res=3Dsuccess'
> >[   17.263202] audit: type=3D1131 audit(1642005647.887:41): pid=3D1 uid=
=3D0 auid=3D4294967295 ses=3D4294967295 subj=3Dsystem_u:system_r:init_t:s0 =
msg=3D'unit=3Dsystemd-journald comm=3D"systemd" exe=3D"/usr/lib/systemd/sys=
temd" hostname=3D? addr=3D? terminal=3D? res=3Dsuccess'
> >[   17.276489] systemd[1]: Starting Load Kernel Modules...
> >[   17.295377] systemd[1]: Starting Remount Root and Kernel File Systems=
=2E..
> >[   17.297774] systemd[1]: Condition check resulted in Repartition Root =
Disk being skipped.
> >[   17.324773] systemd[1]: Starting Coldplug All udev Devices...
> >[   17.328304] systemd[1]: sysroot.mount: Succeeded.
> >[   17.374101] systemd[1]: Activated swap /dev/mapper/fedora-swap.
> >[   17.401071] systemd[1]: Mounted Huge Pages File System.
> >[   17.410741] xfs filesystem being remounted at / supports timestamps u=
ntil 2038 (0x7fffffff)
> >[   17.425620] systemd[1]: Mounted POSIX Message Queue File System.
> >[   17.440432] systemd[1]: Mounted Kernel Debug File System.
> >[   17.447566] RPC: Registered named UNIX socket transport module.
> >[   17.448425] RPC: Registered udp transport module.
> >[   17.449052] RPC: Registered tcp transport module.
> >[   17.449719] RPC: Registered tcp NFSv4.1 backchannel transport module.
> >[   17.457211] systemd[1]: modprobe@configfs.service: Succeeded.
> >[   17.459723] systemd[1]: Finished Load Kernel Module configfs.
> >[   17.461450] audit: type=3D1130 audit(1642005648.103:42): pid=3D1 uid=
=3D0 auid=3D4294967295 ses=3D4294967295 subj=3Dsystem_u:system_r:init_t:s0 =
msg=3D'unit=3Dmodprobe@configfs comm=3D"systemd" exe=3D"/usr/lib/systemd/sy=
stemd" hostname=3D? addr=3D? terminal=3D? res=3Dsuccess'
> >[   17.464558] audit: type=3D1131 audit(1642005648.103:43): pid=3D1 uid=
=3D0 auid=3D4294967295 ses=3D4294967295 subj=3Dsystem_u:system_r:init_t:s0 =
msg=3D'unit=3Dmodprobe@configfs comm=3D"systemd" exe=3D"/usr/lib/systemd/sy=
stemd" hostname=3D? addr=3D? terminal=3D? res=3Dsuccess'
> >[   17.476290] systemd[1]: modprobe@drm.service: Succeeded.
> >[   17.491863] systemd[1]: Finished Load Kernel Module drm.
> >[   17.496010] systemd[1]: Finished Kernel Module supporting RPCSEC_GSS.
> >[   17.501497] systemd[1]: modprobe@fuse.service: Succeeded.
> >[   17.504499] systemd[1]: Finished Load Kernel Module fuse.
> >[   17.517872] systemd[1]: Started Journal Service.
> >[   20.438290] kauditd_printk_skb: 22 callbacks suppressed
> >[   20.438294] audit: type=3D1130 audit(1642005651.079:64): pid=3D1 uid=
=3D0 auid=3D4294967295 ses=3D4294967295 subj=3Dsystem_u:system_r:init_t:s0 =
msg=3D'unit=3Dsystemd-journal-flush comm=3D"systemd" exe=3D"/usr/lib/system=
d/systemd" hostname=3D? addr=3D? terminal=3D? res=3Dsuccess'
> >[   20.725931] audit: type=3D1130 audit(1642005651.367:65): pid=3D1 uid=
=3D0 auid=3D4294967295 ses=3D4294967295 subj=3Dsystem_u:system_r:init_t:s0 =
msg=3D'unit=3Dlvm2-pvscan@253:2 comm=3D"systemd" exe=3D"/usr/lib/systemd/sy=
stemd" hostname=3D? addr=3D? terminal=3D? res=3Dsuccess'
> >[   20.998904] audit: type=3D1130 audit(1642005651.639:66): pid=3D1 uid=
=3D0 auid=3D4294967295 ses=3D4294967295 subj=3Dsystem_u:system_r:init_t:s0 =
msg=3D'unit=3Dlvm2-monitor comm=3D"systemd" exe=3D"/usr/lib/systemd/systemd=
" hostname=3D? addr=3D? terminal=3D? res=3Dsuccess'
> >[   22.158644] audit: type=3D1130 audit(1642005652.799:67): pid=3D1 uid=
=3D0 auid=3D4294967295 ses=3D4294967295 subj=3Dsystem_u:system_r:init_t:s0 =
msg=3D'unit=3Dsystemd-udev-settle comm=3D"systemd" exe=3D"/usr/lib/systemd/=
systemd" hostname=3D? addr=3D? terminal=3D? res=3Dsuccess'
> >[   22.183237] XFS (vda1): Mounting V5 Filesystem
> >[   22.329168] XFS (vda1): Ending clean mount
> >[   22.344447] xfs filesystem being mounted at /boot supports timestamps=
 until 2038 (0x7fffffff)
> >[   22.381960] audit: type=3D1130 audit(1642005653.023:68): pid=3D1 uid=
=3D0 auid=3D4294967295 ses=3D4294967295 subj=3Dsystem_u:system_r:init_t:s0 =
msg=3D'unit=3Ddracut-shutdown comm=3D"systemd" exe=3D"/usr/lib/systemd/syst=
emd" hostname=3D? addr=3D? terminal=3D? res=3Dsuccess'
> >[   22.430820] audit: type=3D1130 audit(1642005653.071:69): pid=3D1 uid=
=3D0 auid=3D4294967295 ses=3D4294967295 subj=3Dsystem_u:system_r:init_t:s0 =
msg=3D'unit=3Dplymouth-read-write comm=3D"systemd" exe=3D"/usr/lib/systemd/=
systemd" hostname=3D? addr=3D? terminal=3D? res=3Dsuccess'
> >[   22.485659] audit: type=3D1130 audit(1642005653.127:70): pid=3D1 uid=
=3D0 auid=3D4294967295 ses=3D4294967295 subj=3Dsystem_u:system_r:init_t:s0 =
msg=3D'unit=3Dimport-state comm=3D"systemd" exe=3D"/usr/lib/systemd/systemd=
" hostname=3D? addr=3D? terminal=3D? res=3Dsuccess'
> >[   22.749894] audit: type=3D1130 audit(1642005653.391:71): pid=3D1 uid=
=3D0 auid=3D4294967295 ses=3D4294967295 subj=3Dsystem_u:system_r:init_t:s0 =
msg=3D'unit=3Dsystemd-tmpfiles-setup comm=3D"systemd" exe=3D"/usr/lib/syste=
md/systemd" hostname=3D? addr=3D? terminal=3D? res=3Dsuccess'
> >[   22.857336] audit: type=3D1400 audit(1642005653.499:72): avc:  denied=
  { fowner } for  pid=3D3657 comm=3D"auditd" capability=3D3  scontext=3Dsys=
tem_u:system_r:auditd_t:s0 tcontext=3Dsystem_u:system_r:auditd_t:s0 tclass=
=3Dcapability permissive=3D0
> >[   22.861281] audit: type=3D1300 audit(1642005653.499:72): arch=3Dc0000=
03e syscall=3D90 success=3Dyes exit=3D0 a0=3D56090a1699e0 a1=3D1c0 a2=3D19 =
a3=3D56090a169c40 items=3D0 ppid=3D3655 pid=3D3657 auid=3D4294967295 uid=3D=
0 gid=3D0 euid=3D0 suid=3D0 fsuid=3D0 egid=3D0 sgid=3D0 fsgid=3D0 tty=3D(no=
ne) ses=3D4294967295 comm=3D"auditd" exe=3D"/usr/sbin/auditd" subj=3Dsystem=
_u:system_r:auditd_t:s0 key=3D(null)
> >[  121.479732] rpm (3866) used greatest stack depth: 23336 bytes left
> >[  160.313750] FS-Cache: Netfs 'nfs' registered for caching
> >[  267.826493] NFS: Registering the id_resolver key type
> >[  267.827159] Key type id_resolver registered
> >[  267.827643] Key type id_legacy registered
> >[  268.393694] mount.nfs (5859) used greatest stack depth: 22896 bytes l=
eft
> >[  523.352374] clocksource: timekeeping watchdog on CPU0: acpi_pm retrie=
d 2 times before success
> >[  938.809224] kworker/dying (2523) used greatest stack depth: 21832 byt=
es left
> >[ 1827.841420] run fstests generic/001 at 2022-01-12 12:10:59
> >[ 1867.998292] run fstests generic/002 at 2022-01-12 12:11:39
> >[ 1869.297577] run fstests generic/003 at 2022-01-12 12:11:40
> >[ 1869.823503] run fstests generic/004 at 2022-01-12 12:11:40
> >[ 1870.357158] run fstests generic/005 at 2022-01-12 12:11:41
> >[ 1872.033166] run fstests generic/008 at 2022-01-12 12:11:43
> >[ 1872.682257] run fstests generic/009 at 2022-01-12 12:11:43
> >[ 1873.300870] run fstests generic/010 at 2022-01-12 12:11:44
> >[ 1873.867023] run fstests generic/011 at 2022-01-12 12:11:45
> >[ 1939.414212] run fstests generic/012 at 2022-01-12 12:12:50
> >[ 1940.257756] run fstests generic/013 at 2022-01-12 12:12:51
> >[ 2006.667055] run fstests generic/015 at 2022-01-12 12:13:57
> >[ 2007.186484] run fstests generic/016 at 2022-01-12 12:13:58
> >[ 2008.063569] run fstests generic/018 at 2022-01-12 12:13:59
> >[ 2008.831790] run fstests generic/020 at 2022-01-12 12:14:00
> >[ 2020.997738] run fstests generic/021 at 2022-01-12 12:14:12
> >[ 2021.774590] run fstests generic/022 at 2022-01-12 12:14:12
> >[ 2022.542934] run fstests generic/023 at 2022-01-12 12:14:13
> >[ 2025.824308] run fstests generic/024 at 2022-01-12 12:14:16
> >[ 2026.390736] run fstests generic/025 at 2022-01-12 12:14:17
> >[ 2026.963217] run fstests generic/026 at 2022-01-12 12:14:18
> >[ 2027.592530] run fstests generic/027 at 2022-01-12 12:14:18
> >[ 2028.101801] run fstests generic/028 at 2022-01-12 12:14:19
> >[ 2033.709852] run fstests generic/029 at 2022-01-12 12:14:24
> >[ 2035.495458] run fstests generic/030 at 2022-01-12 12:14:26
> >[ 2038.537954] run fstests generic/034 at 2022-01-12 12:14:29
> >[ 2039.329741] run fstests generic/036 at 2022-01-12 12:14:30
> >[ 2050.072609] run fstests generic/037 at 2022-01-12 12:14:41
> >[ 2071.336677] run fstests generic/038 at 2022-01-12 12:15:02
> >[ 2072.411721] run fstests generic/039 at 2022-01-12 12:15:03
> >[ 2073.123576] run fstests generic/040 at 2022-01-12 12:15:04
> >[ 2073.748265] run fstests generic/041 at 2022-01-12 12:15:04
> >[ 2074.344951] run fstests generic/043 at 2022-01-12 12:15:05
> >[ 2075.114885] run fstests generic/044 at 2022-01-12 12:15:06
> >[ 2075.977059] run fstests generic/045 at 2022-01-12 12:15:07
> >[ 2076.855028] run fstests generic/046 at 2022-01-12 12:15:08
> >[ 2077.696747] run fstests generic/047 at 2022-01-12 12:15:08
> >[ 2078.533668] run fstests generic/048 at 2022-01-12 12:15:09
> >[ 2079.397374] run fstests generic/049 at 2022-01-12 12:15:10
> >[ 2080.261339] run fstests generic/050 at 2022-01-12 12:15:11
> >[ 2081.107141] run fstests generic/051 at 2022-01-12 12:15:12
> >[ 2082.008096] run fstests generic/052 at 2022-01-12 12:15:13
> >[ 2082.858320] run fstests generic/054 at 2022-01-12 12:15:14
> >[ 2083.731997] run fstests generic/055 at 2022-01-12 12:15:14
> >[ 2084.590242] run fstests generic/056 at 2022-01-12 12:15:15
> >[ 2085.303754] run fstests generic/057 at 2022-01-12 12:15:16
> >[ 2085.908458] run fstests generic/058 at 2022-01-12 12:15:17
> >[ 2086.640354] run fstests generic/059 at 2022-01-12 12:15:17
> >[ 2087.217469] run fstests generic/060 at 2022-01-12 12:15:18
> >[ 2087.944489] run fstests generic/061 at 2022-01-12 12:15:19
> >[ 2088.749344] run fstests generic/063 at 2022-01-12 12:15:19
> >[ 2089.524340] run fstests generic/065 at 2022-01-12 12:15:20
> >[ 2090.121276] run fstests generic/066 at 2022-01-12 12:15:21
> >[ 2090.702873] run fstests generic/067 at 2022-01-12 12:15:21
> >[ 2091.333532] run fstests generic/069 at 2022-01-12 12:15:22
> >[ 2121.140927] run fstests generic/070 at 2022-01-12 12:15:52
> >[ 2168.861297] run fstests generic/072 at 2022-01-12 12:16:40
> >[ 2169.690898] run fstests generic/073 at 2022-01-12 12:16:40
> >[ 2170.302749] run fstests generic/075 at 2022-01-12 12:16:41
> >[ 2226.187399] run fstests generic/076 at 2022-01-12 12:17:37
> >[ 2226.692121] run fstests generic/077 at 2022-01-12 12:17:37
> >[ 2230.646484] run fstests generic/078 at 2022-01-12 12:17:41
> >[ 2231.233467] run fstests generic/079 at 2022-01-12 12:17:42
> >[ 2231.792759] run fstests generic/080 at 2022-01-12 12:17:42
> >[ 2234.478551] run fstests generic/081 at 2022-01-12 12:17:45
> >[ 2235.016264] run fstests generic/082 at 2022-01-12 12:17:46
> >[ 2235.544754] run fstests generic/083 at 2022-01-12 12:17:46
> >[ 2236.070354] run fstests generic/084 at 2022-01-12 12:17:47
> >[ 2242.089643] run fstests generic/085 at 2022-01-12 12:17:53
> >[ 2242.829424] run fstests generic/086 at 2022-01-12 12:17:54
> >[ 2244.627985] 086 (63919): drop_caches: 3
> >[ 2245.004053] run fstests generic/090 at 2022-01-12 12:17:56
> >[ 2245.726297] run fstests generic/092 at 2022-01-12 12:17:56
> >[ 2246.386331] run fstests generic/093 at 2022-01-12 12:17:57
> >[ 2246.989287] run fstests generic/095 at 2022-01-12 12:17:58
> >[ 2247.568818] run fstests generic/096 at 2022-01-12 12:17:58
> >[ 2248.194588] run fstests generic/097 at 2022-01-12 12:17:59
> >[ 2248.808142] run fstests generic/098 at 2022-01-12 12:17:59
> >[ 2250.531860] run fstests generic/099 at 2022-01-12 12:18:01
> >[ 2251.371697] run fstests generic/101 at 2022-01-12 12:18:02
> >[ 2251.916640] run fstests generic/102 at 2022-01-12 12:18:03
> >[ 2252.419409] run fstests generic/103 at 2022-01-12 12:18:03
> >[ 2255.825340] run fstests generic/104 at 2022-01-12 12:18:06
> >[ 2256.640587] run fstests generic/106 at 2022-01-12 12:18:07
> >[ 2257.275429] run fstests generic/107 at 2022-01-12 12:18:08
> >[ 2257.871596] run fstests generic/108 at 2022-01-12 12:18:09
> >[ 2258.649789] run fstests generic/109 at 2022-01-12 12:18:09
> >[ 2314.619077] run fstests generic/110 at 2022-01-12 12:19:05
> >[ 2315.511518] run fstests generic/111 at 2022-01-12 12:19:06
> >[ 2316.200429] run fstests generic/112 at 2022-01-12 12:19:07
> >[ 2375.093348] run fstests generic/114 at 2022-01-12 12:20:06
> >[ 2375.726022] run fstests generic/115 at 2022-01-12 12:20:06
> >[ 2376.417534] run fstests generic/116 at 2022-01-12 12:20:07
> >[ 2378.207570] run fstests generic/118 at 2022-01-12 12:20:09
> >[ 2379.767855] run fstests generic/119 at 2022-01-12 12:20:10
> >[ 2382.596453] run fstests generic/120 at 2022-01-12 12:20:13
> >[ 2383.118291] run fstests generic/121 at 2022-01-12 12:20:14
> >[ 2383.763385] run fstests generic/122 at 2022-01-12 12:20:14
> >[ 2384.417857] run fstests generic/123 at 2022-01-12 12:20:15
> >[ 2384.952387] run fstests generic/124 at 2022-01-12 12:20:16
> >[ 2439.979901] run fstests generic/128 at 2022-01-12 12:21:11
> >[ 2440.534640] run fstests generic/130 at 2022-01-12 12:21:11
> >[ 2458.532247] run fstests generic/131 at 2022-01-12 12:21:29
> >[ 2460.624455] run fstests generic/132 at 2022-01-12 12:21:31
> >[ 2479.380043] run fstests generic/134 at 2022-01-12 12:21:50
> >[ 2481.259289] run fstests generic/135 at 2022-01-12 12:21:52
> >[ 2482.602837] run fstests generic/136 at 2022-01-12 12:21:53
> >[ 2483.422863] run fstests generic/137 at 2022-01-12 12:21:54
> >[ 2484.225794] run fstests generic/138 at 2022-01-12 12:21:55
> >[ 2486.911951] run fstests generic/139 at 2022-01-12 12:21:58
> >[ 2490.247175] run fstests generic/140 at 2022-01-12 12:22:01
> >[ 2492.960214] run fstests generic/141 at 2022-01-12 12:22:04
> >[ 2493.949160] run fstests generic/142 at 2022-01-12 12:22:05
> >[ 2502.811792] run fstests generic/143 at 2022-01-12 12:22:13
> >[ 2744.562632] run fstests generic/144 at 2022-01-12 12:26:15
> >[ 2746.679337] run fstests generic/145 at 2022-01-12 12:26:17
> >[ 2747.559239] run fstests generic/146 at 2022-01-12 12:26:18
> >[ 2749.654314] run fstests generic/147 at 2022-01-12 12:26:20
> >[ 2750.441774] run fstests generic/148 at 2022-01-12 12:26:21
> >[ 2752.169829] run fstests generic/149 at 2022-01-12 12:26:23
> >[ 2752.935800] run fstests generic/150 at 2022-01-12 12:26:24
> >[ 2770.733819] run fstests generic/151 at 2022-01-12 12:26:41
> >[ 2790.154829] run fstests generic/152 at 2022-01-12 12:27:01
> >[ 2810.016846] run fstests generic/153 at 2022-01-12 12:27:21
> >[ 2810.829252] run fstests generic/155 at 2022-01-12 12:27:22
> >[ 2811.642982] run fstests generic/156 at 2022-01-12 12:27:22
> >[ 2812.435476] run fstests generic/157 at 2022-01-12 12:27:23
> >[ 2898.516142] run fstests generic/158 at 2022-01-12 12:28:49
> >[ 2899.169820] run fstests generic/159 at 2022-01-12 12:28:50
> >[ 2899.707414] run fstests generic/160 at 2022-01-12 12:28:50
> >[ 2900.240792] run fstests generic/161 at 2022-01-12 12:28:51
> >[ 2920.346459] run fstests generic/162 at 2022-01-12 12:29:11
> >[ 2921.465497] run fstests generic/163 at 2022-01-12 12:29:12
> >[ 2922.457235] run fstests generic/164 at 2022-01-12 12:29:13
> >[ 2992.429168] run fstests generic/165 at 2022-01-12 12:30:23
> >[ 3052.173968] run fstests generic/166 at 2022-01-12 12:31:23
> >[ 3234.652685] run fstests generic/167 at 2022-01-12 12:34:25
> >[ 3276.304549] run fstests generic/168 at 2022-01-12 12:35:07
> >[ 3556.737914] run fstests generic/169 at 2022-01-12 12:39:47
> >[ 3558.300604] run fstests generic/170 at 2022-01-12 12:39:49
> >[ 3919.058972] run fstests generic/171 at 2022-01-12 12:45:50
> >[ 3920.624329] run fstests generic/172 at 2022-01-12 12:45:51
> >[ 3921.953882] run fstests generic/173 at 2022-01-12 12:45:53
> >[ 3923.239526] run fstests generic/174 at 2022-01-12 12:45:54
> >[ 3924.575586] run fstests generic/175 at 2022-01-12 12:45:55
> >[ 4159.652128] run fstests generic/176 at 2022-01-12 12:49:50
> >[ 4231.459928] run fstests generic/177 at 2022-01-12 12:51:02
> >[ 4232.370516] run fstests generic/178 at 2022-01-12 12:51:03
> >[ 4237.868525] run fstests generic/179 at 2022-01-12 12:51:09
> >[ 4239.533836] run fstests generic/180 at 2022-01-12 12:51:10
> >[ 4240.307772] run fstests generic/181 at 2022-01-12 12:51:11
> >[ 4244.757968] run fstests generic/182 at 2022-01-12 12:51:15
> >[ 4245.418557] run fstests generic/183 at 2022-01-12 12:51:16
> >[ 4251.302820] run fstests generic/185 at 2022-01-12 12:51:22
> >[ 4257.418284] run fstests generic/186 at 2022-01-12 12:51:28
> >[ 5070.488206] run fstests generic/187 at 2022-01-12 13:05:01
> >[ 5885.066194] run fstests generic/188 at 2022-01-12 13:18:36
> >[ 5891.287909] run fstests generic/189 at 2022-01-12 13:18:42
> >[ 5895.605867] run fstests generic/190 at 2022-01-12 13:18:46
> >[ 5900.073040] run fstests generic/191 at 2022-01-12 13:18:51
> >[ 5904.614273] run fstests generic/192 at 2022-01-12 13:18:55
> >[ 5905.308580] run fstests generic/193 at 2022-01-12 13:18:56
> >[ 5905.844031] run fstests generic/194 at 2022-01-12 13:18:57
> >[ 5912.087984] run fstests generic/195 at 2022-01-12 13:19:03
> >[ 5918.021826] run fstests generic/196 at 2022-01-12 13:19:09
> >[ 5922.532326] run fstests generic/197 at 2022-01-12 13:19:13
> >[ 5927.467154] run fstests generic/198 at 2022-01-12 13:19:18
> >[ 5933.061489] run fstests generic/199 at 2022-01-12 13:19:24
> >[ 5938.925983] run fstests generic/200 at 2022-01-12 13:19:30
> >[ 5944.827402] run fstests generic/201 at 2022-01-12 13:19:36
> >[ 5948.708601] run fstests generic/202 at 2022-01-12 13:19:39
> >[ 5950.790927] run fstests generic/203 at 2022-01-12 13:19:41
> >[ 5953.029748] run fstests generic/204 at 2022-01-12 13:19:44
> >[ 5954.153740] run fstests generic/205 at 2022-01-12 13:19:45
> >[ 5955.124318] run fstests generic/206 at 2022-01-12 13:19:46
> >[ 5956.139535] run fstests generic/207 at 2022-01-12 13:19:47
> >[ 5976.917435] run fstests generic/209 at 2022-01-12 13:20:08
> >[ 6022.149019] run fstests generic/210 at 2022-01-12 13:20:53
> >[ 6022.898911] run fstests generic/211 at 2022-01-12 13:20:54
> >[ 6024.148505] run fstests generic/212 at 2022-01-12 13:20:55
> >[ 6024.829471] run fstests generic/213 at 2022-01-12 13:20:56
> >[ 6025.661954] run fstests generic/214 at 2022-01-12 13:20:56
> >[ 6026.799438] run fstests generic/215 at 2022-01-12 13:20:57
> >[ 6029.680826] run fstests generic/216 at 2022-01-12 13:21:00
> >[ 6030.690346] run fstests generic/217 at 2022-01-12 13:21:01
> >[ 6031.755530] run fstests generic/218 at 2022-01-12 13:21:02
> >[ 6032.778991] run fstests generic/219 at 2022-01-12 13:21:03
> >[ 6033.283631] run fstests generic/220 at 2022-01-12 13:21:04
> >[ 6034.360789] run fstests generic/221 at 2022-01-12 13:21:05
> >[ 6035.998554] run fstests generic/222 at 2022-01-12 13:21:07
> >[ 6036.984890] run fstests generic/223 at 2022-01-12 13:21:08
> >[ 6037.549093] run fstests generic/224 at 2022-01-12 13:21:08
> >[ 6038.116815] run fstests generic/226 at 2022-01-12 13:21:09
> >[ 6038.692541] run fstests generic/227 at 2022-01-12 13:21:09
> >[ 6039.755092] run fstests generic/228 at 2022-01-12 13:21:10
> >[ 6040.281881] Unsafe core_pattern used with fs.suid_dumpable=3D2.
> >                Pipe handler or fully qualified core dump path required.
> >                Set kernel.core_pattern before fs.suid_dumpable.
> >[ 6040.553574] run fstests generic/229 at 2022-01-12 13:21:11
> >[ 6041.551145] run fstests generic/230 at 2022-01-12 13:21:12
> >[ 6042.058550] run fstests generic/231 at 2022-01-12 13:21:13
> >[ 6042.559297] run fstests generic/232 at 2022-01-12 13:21:13
> >[ 6043.063531] run fstests generic/233 at 2022-01-12 13:21:14
> >[ 6043.572898] run fstests generic/234 at 2022-01-12 13:21:14
> >[ 6044.083619] run fstests generic/235 at 2022-01-12 13:21:15
> >[ 6044.595386] run fstests generic/236 at 2022-01-12 13:21:15
> >[ 6046.330897] run fstests generic/237 at 2022-01-12 13:21:17
> >[ 6046.995456] run fstests generic/238 at 2022-01-12 13:21:18
> >[ 6048.062920] run fstests generic/239 at 2022-01-12 13:21:19
> >[ 6079.167087] run fstests generic/240 at 2022-01-12 13:21:50
> >[ 6080.262050] run fstests generic/241 at 2022-01-12 13:21:51
> >[ 6080.777265] run fstests generic/242 at 2022-01-12 13:21:51
> >[ 6165.131825] run fstests generic/243 at 2022-01-12 13:23:16
> >[ 6246.858636] run fstests generic/244 at 2022-01-12 13:24:38
> >[ 6247.538623] run fstests generic/245 at 2022-01-12 13:24:38
> >[ 6248.262918] run fstests generic/246 at 2022-01-12 13:24:39
> >[ 6248.891286] run fstests generic/247 at 2022-01-12 13:24:40
> >[ 6330.034484] run fstests generic/248 at 2022-01-12 13:26:01
> >[ 6330.856382] run fstests generic/249 at 2022-01-12 13:26:02
> >[ 6334.074505] run fstests generic/250 at 2022-01-12 13:26:05
> >[ 6334.909446] run fstests generic/252 at 2022-01-12 13:26:06
> >[ 6335.473954] run fstests generic/253 at 2022-01-12 13:26:06
> >[ 6337.650997] run fstests generic/254 at 2022-01-12 13:26:08
> >[ 6340.130137] run fstests generic/255 at 2022-01-12 13:26:11
> >[ 6341.103237] run fstests generic/256 at 2022-01-12 13:26:12
> >[ 6341.796869] run fstests generic/257 at 2022-01-12 13:26:12
> >[ 6345.943041] run fstests generic/258 at 2022-01-12 13:26:17
> >[ 6346.813066] run fstests generic/259 at 2022-01-12 13:26:18
> >[ 6347.896367] run fstests generic/260 at 2022-01-12 13:26:19
> >[ 6348.746022] run fstests generic/261 at 2022-01-12 13:26:19
> >[ 6349.851327] run fstests generic/262 at 2022-01-12 13:26:21
> >[ 6350.974652] run fstests generic/264 at 2022-01-12 13:26:22
> >[ 6352.017430] run fstests generic/265 at 2022-01-12 13:26:23
> >[ 6353.016731] run fstests generic/266 at 2022-01-12 13:26:24
> >[ 6353.983465] run fstests generic/267 at 2022-01-12 13:26:25
> >[ 6354.953896] run fstests generic/268 at 2022-01-12 13:26:26
> >[ 6355.951768] run fstests generic/269 at 2022-01-12 13:26:27
> >[ 6356.458572] run fstests generic/270 at 2022-01-12 13:26:27
> >[ 6356.938338] run fstests generic/271 at 2022-01-12 13:26:28
> >[ 6357.892032] run fstests generic/272 at 2022-01-12 13:26:29
> >[ 6358.849363] run fstests generic/273 at 2022-01-12 13:26:30
> >[ 6359.360457] run fstests generic/274 at 2022-01-12 13:26:30
> >[ 6359.918582] run fstests generic/275 at 2022-01-12 13:26:31
> >[ 6360.433874] run fstests generic/276 at 2022-01-12 13:26:31
> >[ 6361.462929] run fstests generic/278 at 2022-01-12 13:26:32
> >[ 6362.446136] run fstests generic/279 at 2022-01-12 13:26:33
> >[ 6363.428985] run fstests generic/280 at 2022-01-12 13:26:34
> >[ 6363.934111] run fstests generic/281 at 2022-01-12 13:26:35
> >[ 6364.932675] run fstests generic/282 at 2022-01-12 13:26:36
> >[ 6365.931183] run fstests generic/283 at 2022-01-12 13:26:37
> >[ 6366.950101] run fstests generic/284 at 2022-01-12 13:26:38
> >[ 6370.483205] run fstests generic/285 at 2022-01-12 13:26:41
> >[ 6372.532605] run fstests generic/286 at 2022-01-12 13:26:43
> >[ 6391.552588] run fstests generic/287 at 2022-01-12 13:27:02
> >[ 6395.221066] run fstests generic/288 at 2022-01-12 13:27:06
> >[ 6396.199239] run fstests generic/289 at 2022-01-12 13:27:07
> >[ 6401.494200] run fstests generic/290 at 2022-01-12 13:27:12
> >[ 6406.705872] run fstests generic/291 at 2022-01-12 13:27:17
> >[ 6411.919310] run fstests generic/292 at 2022-01-12 13:27:23
> >[ 6417.313613] run fstests generic/293 at 2022-01-12 13:27:28
> >[ 6424.177254] run fstests generic/295 at 2022-01-12 13:27:35
> >[ 6430.984886] run fstests generic/296 at 2022-01-12 13:27:42
> >[ 6434.891933] run fstests generic/297 at 2022-01-12 13:27:46
> >[ 6435.979562] run fstests generic/298 at 2022-01-12 13:27:47
> >[ 6436.941076] run fstests generic/299 at 2022-01-12 13:27:48
> >[ 6437.539615] run fstests generic/300 at 2022-01-12 13:27:48
> >[ 6438.104575] run fstests generic/301 at 2022-01-12 13:27:49
> >[ 6439.145713] run fstests generic/302 at 2022-01-12 13:27:50
> >[ 6440.109454] run fstests generic/303 at 2022-01-12 13:27:51
> >[ 6441.507025] run fstests generic/304 at 2022-01-12 13:27:52
> >[ 6442.163632] run fstests generic/305 at 2022-01-12 13:27:53
> >[ 6443.161513] run fstests generic/306 at 2022-01-12 13:27:54
> >[ 6444.462375] run fstests generic/307 at 2022-01-12 13:27:55
> >[ 6445.026925] run fstests generic/308 at 2022-01-12 13:27:56
> >[ 6445.694065] run fstests generic/309 at 2022-01-12 13:27:56
> >[ 6447.429347] run fstests generic/311 at 2022-01-12 13:27:58
> >[ 6448.065661] run fstests generic/312 at 2022-01-12 13:27:59
> >[ 6448.641786] run fstests generic/313 at 2022-01-12 13:27:59
> >[ 6453.330380] run fstests generic/314 at 2022-01-12 13:28:04
> >[ 6453.869735] run fstests generic/315 at 2022-01-12 13:28:05
> >[ 6454.432871] run fstests generic/316 at 2022-01-12 13:28:05
> >[ 6455.179812] run fstests generic/317 at 2022-01-12 13:28:06
> >[ 6455.744870] run fstests generic/319 at 2022-01-12 13:28:06
> >[ 6456.295368] run fstests generic/320 at 2022-01-12 13:28:07
> >[ 6456.823414] run fstests generic/321 at 2022-01-12 13:28:08
> >[ 6457.398078] run fstests generic/322 at 2022-01-12 13:28:08
> >[ 6457.986300] run fstests generic/324 at 2022-01-12 13:28:09
> >[ 6458.486502] run fstests generic/325 at 2022-01-12 13:28:09
> >[ 6459.043391] run fstests generic/326 at 2022-01-12 13:28:10
> >[ 6460.040241] run fstests generic/327 at 2022-01-12 13:28:11
> >[ 6461.054872] run fstests generic/328 at 2022-01-12 13:28:12
> >[ 6462.066528] run fstests generic/329 at 2022-01-12 13:28:13
> >[ 6463.065254] run fstests generic/330 at 2022-01-12 13:28:14
> >[ 6471.961534] run fstests generic/331 at 2022-01-12 13:28:23
> >[ 6473.162639] run fstests generic/332 at 2022-01-12 13:28:24
> >[ 6481.558320] run fstests generic/333 at 2022-01-12 13:28:32
> >[ 6482.970708] run fstests generic/334 at 2022-01-12 13:28:34
> >[ 6483.883159] run fstests generic/335 at 2022-01-12 13:28:35
> >[ 6484.424615] run fstests generic/336 at 2022-01-12 13:28:35
> >[ 6485.026317] run fstests generic/337 at 2022-01-12 13:28:36
> >[ 6486.087022] run fstests generic/338 at 2022-01-12 13:28:37
> >[ 6486.853279] run fstests generic/340 at 2022-01-12 13:28:38
> >[ 6529.018625] run fstests generic/341 at 2022-01-12 13:29:20
> >[ 6529.743485] run fstests generic/342 at 2022-01-12 13:29:20
> >[ 6530.324586] run fstests generic/343 at 2022-01-12 13:29:21
> >[ 6530.920079] run fstests generic/344 at 2022-01-12 13:29:22
> >[ 6615.377472] run fstests generic/345 at 2022-01-12 13:30:46
> >[ 6699.843608] run fstests generic/346 at 2022-01-12 13:32:11
> >[ 6738.437542] run fstests generic/347 at 2022-01-12 13:32:49
> >[ 6739.294108] run fstests generic/348 at 2022-01-12 13:32:50
> >[ 6739.898344] run fstests generic/352 at 2022-01-12 13:32:51
> >[ 6741.077399] run fstests generic/353 at 2022-01-12 13:32:52
> >[ 6742.043936] run fstests generic/354 at 2022-01-12 13:32:53
> >[ 6762.336256] clocksource: timekeeping watchdog on CPU0: acpi_pm retrie=
d 2 times before success
> >[ 6771.148344] run fstests generic/355 at 2022-01-12 13:33:22
> >[ 6771.867718] run fstests generic/356 at 2022-01-12 13:33:23
> >[ 6772.723288] Adding 36k swap on /mnt2/swap.  Priority:-3 extents:1 acr=
oss:36k
> >[ 6774.212765] Adding 10236k swap on /mnt2/test-356/file1.  Priority:-3 =
extents:1 across:10236k
> >[ 6774.563473] run fstests generic/358 at 2022-01-12 13:33:25
> >[ 6829.824103] run fstests generic/359 at 2022-01-12 13:34:21
> >[ 6844.529776] run fstests generic/360 at 2022-01-12 13:34:35
> >[ 6845.353612] run fstests generic/361 at 2022-01-12 13:34:36
> >[ 6845.922540] run fstests generic/362 at 2022-01-12 13:34:37
> >[ 6846.514415] run fstests generic/363 at 2022-01-12 13:34:37
> >[ 6847.212681] run fstests generic/364 at 2022-01-12 13:34:38
> >[ 6847.905685] run fstests generic/365 at 2022-01-12 13:34:39
> >[ 6848.597706] run fstests generic/366 at 2022-01-12 13:34:39
> >[ 6849.301636] run fstests generic/367 at 2022-01-12 13:34:40
> >[ 6849.993675] run fstests generic/368 at 2022-01-12 13:34:41
> >[ 6850.694262] run fstests generic/369 at 2022-01-12 13:34:41
> >[ 6851.389744] run fstests generic/370 at 2022-01-12 13:34:42
> >[ 6852.089253] run fstests generic/371 at 2022-01-12 13:34:43
> >[ 6852.772792] run fstests generic/372 at 2022-01-12 13:34:43
> >[ 6853.867908] run fstests generic/373 at 2022-01-12 13:34:45
> >[ 6855.370332] run fstests generic/374 at 2022-01-12 13:34:46
> >[ 6856.417262] run fstests generic/375 at 2022-01-12 13:34:47
> >[ 6857.021504] run fstests generic/376 at 2022-01-12 13:34:48
> >[ 6857.662821] run fstests generic/377 at 2022-01-12 13:34:48
> >[ 6858.728302] run fstests generic/378 at 2022-01-12 13:34:49
> >[ 6859.437621] run fstests generic/379 at 2022-01-12 13:34:50
> >[ 6859.958758] run fstests generic/380 at 2022-01-12 13:34:51
> >[ 6860.467861] run fstests generic/381 at 2022-01-12 13:34:51
> >[ 6860.979217] run fstests generic/382 at 2022-01-12 13:34:52
> >[ 6861.490673] run fstests generic/383 at 2022-01-12 13:34:52
> >[ 6862.007029] run fstests generic/384 at 2022-01-12 13:34:53
> >[ 6862.539285] run fstests generic/385 at 2022-01-12 13:34:53
> >[ 6863.056895] run fstests generic/386 at 2022-01-12 13:34:54
> >[ 6863.540959] run fstests generic/387 at 2022-01-12 13:34:54
> >[ 6864.451640] run fstests generic/388 at 2022-01-12 13:34:55
> >[ 6865.020938] run fstests generic/389 at 2022-01-12 13:34:56
> >[ 6865.578808] run fstests generic/390 at 2022-01-12 13:34:56
> >[ 6866.159617] run fstests generic/391 at 2022-01-12 13:34:57
> >[ 6886.115735] 391 (267517): drop_caches: 3
> >[ 6889.286981] run fstests generic/392 at 2022-01-12 13:35:20
> >[ 6891.203337] run fstests generic/393 at 2022-01-12 13:35:22
> >[ 6893.177969] run fstests generic/394 at 2022-01-12 13:35:24
> >[ 6894.586568] run fstests generic/395 at 2022-01-12 13:35:25
> >[ 6895.341072] run fstests generic/396 at 2022-01-12 13:35:26
> >[ 6896.026789] run fstests generic/397 at 2022-01-12 13:35:27
> >[ 6896.798172] run fstests generic/398 at 2022-01-12 13:35:27
> >[ 6897.556444] run fstests generic/399 at 2022-01-12 13:35:28
> >[ 6898.303641] run fstests generic/400 at 2022-01-12 13:35:29
> >[ 6898.815244] run fstests generic/401 at 2022-01-12 13:35:30
> >[ 6899.937180] run fstests generic/402 at 2022-01-12 13:35:31
> >[ 6901.017461] run fstests generic/404 at 2022-01-12 13:35:32
> >[ 6901.789100] run fstests generic/405 at 2022-01-12 13:35:32
> >[ 6902.645105] run fstests generic/406 at 2022-01-12 13:35:33
> >[ 6910.841871] run fstests generic/407 at 2022-01-12 13:35:42
> >[ 6912.903774] run fstests generic/408 at 2022-01-12 13:35:44
> >[ 6913.608890] run fstests generic/409 at 2022-01-12 13:35:44
> >[ 6914.156131] run fstests generic/410 at 2022-01-12 13:35:45
> >[ 6914.704550] run fstests generic/411 at 2022-01-12 13:35:45
> >[ 6915.251230] run fstests generic/412 at 2022-01-12 13:35:46
> >[ 6916.526789] run fstests generic/413 at 2022-01-12 13:35:47
> >[ 6917.304149] nfs: Unknown parameter 'dax'
> >[ 6917.410347] run fstests generic/414 at 2022-01-12 13:35:48
> >[ 6918.634861] run fstests generic/415 at 2022-01-12 13:35:49
> >[ 6933.976957] run fstests generic/416 at 2022-01-12 13:36:05
> >[ 6934.691603] run fstests generic/417 at 2022-01-12 13:36:05
> >[ 6935.629054] run fstests generic/418 at 2022-01-12 13:36:06
> >[ 6936.242138] run fstests generic/419 at 2022-01-12 13:36:07
> >[ 6937.045544] run fstests generic/420 at 2022-01-12 13:36:08
> >[ 6937.839373] run fstests generic/421 at 2022-01-12 13:36:09
> >[ 6938.636575] run fstests generic/424 at 2022-01-12 13:36:09
> >[ 6939.351034] run fstests generic/427 at 2022-01-12 13:36:10
> >[ 6939.996982] run fstests generic/428 at 2022-01-12 13:36:11
> >[ 6940.637416] run fstests generic/429 at 2022-01-12 13:36:11
> >[ 6941.362410] run fstests generic/430 at 2022-01-12 13:36:12
> >[ 6942.506724] run fstests generic/431 at 2022-01-12 13:36:13
> >[ 6943.556512] run fstests generic/432 at 2022-01-12 13:36:14
> >[ 6944.645630] run fstests generic/433 at 2022-01-12 13:36:15
> >[ 6945.677486] run fstests generic/435 at 2022-01-12 13:36:16
> >[ 6946.409026] run fstests generic/436 at 2022-01-12 13:36:17
> >[ 6947.992848] run fstests generic/437 at 2022-01-12 13:36:19
> >[ 6968.653759] run fstests generic/439 at 2022-01-12 13:36:39
> >[ 6970.194179] run fstests generic/440 at 2022-01-12 13:36:41
> >[ 6970.921973] run fstests generic/441 at 2022-01-12 13:36:42
> >[ 6971.489914] run fstests generic/443 at 2022-01-12 13:36:42
> >[ 6972.110321] run fstests generic/444 at 2022-01-12 13:36:43
> >[ 6972.734069] run fstests generic/445 at 2022-01-12 13:36:43
> >[ 6974.220817] run fstests generic/447 at 2022-01-12 13:36:45
> >[ 6975.531450] run fstests generic/448 at 2022-01-12 13:36:46
> >[ 6976.914815] run fstests generic/449 at 2022-01-12 13:36:48
> >[ 6977.512944] run fstests generic/450 at 2022-01-12 13:36:48
> >[ 6978.444175] run fstests generic/451 at 2022-01-12 13:36:49
> >[ 7009.200274] run fstests generic/452 at 2022-01-12 13:37:20
> >[ 7010.248330] run fstests generic/453 at 2022-01-12 13:37:21
> >[ 7012.836935] run fstests generic/454 at 2022-01-12 13:37:24
> >[ 7015.394697] run fstests generic/455 at 2022-01-12 13:37:26
> >[ 7016.318699] run fstests generic/456 at 2022-01-12 13:37:27
> >[ 7016.892196] run fstests generic/457 at 2022-01-12 13:37:28
> >[ 7018.100645] run fstests generic/458 at 2022-01-12 13:37:29
> >[ 7019.153106] run fstests generic/459 at 2022-01-12 13:37:30
> >[ 7020.261614] run fstests generic/460 at 2022-01-12 13:37:31
> >[ 7057.684200] run fstests generic/461 at 2022-01-12 13:38:08
> >[ 7058.928713] run fstests generic/462 at 2022-01-12 13:38:10
> >[ 7059.578267] nfs: Unknown parameter 'dax'
> >[ 7059.685070] run fstests generic/463 at 2022-01-12 13:38:10
> >[ 7060.682186] run fstests generic/464 at 2022-01-12 13:38:11
> >[ 7133.376125] run fstests generic/466 at 2022-01-12 13:39:24
> >[ 7134.033001] run fstests generic/467 at 2022-01-12 13:39:25
> >[ 7134.958056] sh (300657): drop_caches: 3
> >[ 7135.273575] sh (300664): drop_caches: 3
> >[ 7135.779078] sh (300671): drop_caches: 3
> >[ 7136.171387] sh (300678): drop_caches: 3
> >[ 7136.372701] sh (300683): drop_caches: 3
> >[ 7136.858710] sh (300690): drop_caches: 3
> >[ 7137.390146] sh (300699): drop_caches: 3
> >[ 7137.986292] sh (300709): drop_caches: 3
> >[ 7138.252495] run fstests generic/468 at 2022-01-12 13:39:29
> >[ 7140.487581] run fstests generic/470 at 2022-01-12 13:39:31
> >[ 7141.285153] run fstests generic/471 at 2022-01-12 13:39:32
> >[ 7141.971971] run fstests generic/472 at 2022-01-12 13:39:33
> >[ 7142.757677] Adding 36k swap on /mnt2/swap.  Priority:-3 extents:1 acr=
oss:36k
> >[ 7143.294807] Adding 2044k swap on /mnt2/swap.  Priority:-3 extents:1 a=
cross:2044k
> >[ 7143.500315] Adding 2044k swap on /mnt2/swap.  Priority:-3 extents:1 a=
cross:2044k
> >[ 7143.621722] Adding 8k swap on /mnt2/swap.  Priority:-3 extents:1 acro=
ss:8k
> >[ 7144.046333] run fstests generic/474 at 2022-01-12 13:39:35
> >[ 7144.988579] run fstests generic/475 at 2022-01-12 13:39:36
> >[ 7145.710624] run fstests generic/477 at 2022-01-12 13:39:36
> >[ 7146.845233] sh (302346): drop_caches: 3
> >[ 7147.640367] sh (302387): drop_caches: 3
> >[ 7148.536961] sh (302428): drop_caches: 3
> >[ 7149.466709] sh (302470): drop_caches: 3
> >[ 7149.738194] run fstests generic/479 at 2022-01-12 13:39:40
> >[ 7150.443204] run fstests generic/480 at 2022-01-12 13:39:41
> >[ 7151.048938] run fstests generic/481 at 2022-01-12 13:39:42
> >[ 7151.619524] run fstests generic/482 at 2022-01-12 13:39:42
> >[ 7152.348315] run fstests generic/483 at 2022-01-12 13:39:43
> >[ 7153.020108] run fstests generic/487 at 2022-01-12 13:39:44
> >[ 7153.578129] run fstests generic/488 at 2022-01-12 13:39:44
> >[ 7154.092708] run fstests generic/489 at 2022-01-12 13:39:45
> >[ 7154.645766] run fstests generic/490 at 2022-01-12 13:39:45
> >[ 7156.152532] run fstests generic/492 at 2022-01-12 13:39:47
> >[ 7156.687978] run fstests generic/493 at 2022-01-12 13:39:47
> >[ 7157.440775] Adding 36k swap on /mnt2/swap.  Priority:-3 extents:1 acr=
oss:36k
> >[ 7158.071570] run fstests generic/494 at 2022-01-12 13:39:49
> >[ 7158.945655] Adding 36k swap on /mnt2/swap.  Priority:-3 extents:1 acr=
oss:36k
> >[ 7159.987483] Adding 10236k swap on /mnt2/test-494/file1.  Priority:-3 =
extents:1 across:10236k
> >[ 7160.426306] run fstests generic/495 at 2022-01-12 13:39:51
> >[ 7161.398950] Adding 36k swap on /mnt2/swap.  Priority:-3 extents:1 acr=
oss:36k
> >[ 7161.828770] swap activate: swapfile has holes
> >[ 7161.924587] Empty swap-file
> >[ 7162.186835] run fstests generic/496 at 2022-01-12 13:39:53
> >[ 7163.145304] Adding 36k swap on /mnt2/swap.  Priority:-3 extents:1 acr=
oss:36k
> >[ 7163.664228] Adding 2044k swap on /mnt2/swap.  Priority:-3 extents:1 a=
cross:2044k
> >[ 7169.433211] Adding 2044k swap on /mnt2/swap.  Priority:-3 extents:1 a=
cross:2044k
> >[ 7169.727608] run fstests generic/497 at 2022-01-12 13:40:00
> >[ 7170.735141] Adding 36k swap on /mnt2/swap.  Priority:-3 extents:1 acr=
oss:36k
> >[ 7171.069079] run fstests generic/498 at 2022-01-12 13:40:02
> >[ 7171.732186] run fstests generic/500 at 2022-01-12 13:40:02
> >[ 7172.402636] run fstests generic/501 at 2022-01-12 13:40:03
> >[ 7173.367894] run fstests generic/502 at 2022-01-12 13:40:04
> >[ 7174.036468] run fstests generic/504 at 2022-01-12 13:40:05
> >[ 7174.679080] run fstests generic/505 at 2022-01-12 13:40:05
> >[ 7175.476364] run fstests generic/506 at 2022-01-12 13:40:06
> >[ 7176.336327] run fstests generic/507 at 2022-01-12 13:40:07
> >[ 7176.906752] run fstests generic/508 at 2022-01-12 13:40:08
> >[ 7177.443466] run fstests generic/509 at 2022-01-12 13:40:08
> >[ 7178.113899] run fstests generic/510 at 2022-01-12 13:40:09
> >[ 7178.665874] run fstests generic/511 at 2022-01-12 13:40:09
> >[ 7179.212399] run fstests generic/512 at 2022-01-12 13:40:10
> >[ 7179.863716] run fstests generic/514 at 2022-01-12 13:40:11
> >[ 7180.815618] run fstests generic/515 at 2022-01-12 13:40:12
> >[ 7181.850294] run fstests generic/516 at 2022-01-12 13:40:13
> >[ 7182.497964] run fstests generic/517 at 2022-01-12 13:40:13
> >[ 7183.397705] run fstests generic/518 at 2022-01-12 13:40:14
> >[ 7185.260858] run fstests generic/520 at 2022-01-12 13:40:16
> >[ 7185.995518] run fstests generic/523 at 2022-01-12 13:40:17
> >[ 7187.015108] run fstests generic/524 at 2022-01-12 13:40:18
> >[ 7214.588812] run fstests generic/525 at 2022-01-12 13:40:45
> >[ 7215.945729] run fstests generic/526 at 2022-01-12 13:40:47
> >[ 7216.731432] run fstests generic/527 at 2022-01-12 13:40:47
> >[ 7217.332036] run fstests generic/528 at 2022-01-12 13:40:48
> >[ 7217.928387] run fstests generic/529 at 2022-01-12 13:40:49
> >[ 7218.474947] run fstests generic/530 at 2022-01-12 13:40:49
> >[ 7219.289577] run fstests generic/532 at 2022-01-12 13:40:50
> >[ 7219.984287] run fstests generic/533 at 2022-01-12 13:40:51
> >[ 7221.588573] run fstests generic/534 at 2022-01-12 13:40:52
> >[ 7222.205596] run fstests generic/535 at 2022-01-12 13:40:53
> >[ 7222.829546] run fstests generic/536 at 2022-01-12 13:40:54
> >[ 7223.590202] run fstests generic/537 at 2022-01-12 13:40:54
> >[ 7224.466640] run fstests generic/538 at 2022-01-12 13:40:55
> >[ 7250.048839] run fstests generic/539 at 2022-01-12 13:41:21
> >[ 7251.550550] run fstests generic/540 at 2022-01-12 13:41:22
> >[ 7257.243669] run fstests generic/541 at 2022-01-12 13:41:28
> >[ 7263.478824] run fstests generic/542 at 2022-01-12 13:41:34
> >[ 7269.624181] run fstests generic/543 at 2022-01-12 13:41:40
> >[ 7275.817103] run fstests generic/544 at 2022-01-12 13:41:47
> >[ 7282.092977] run fstests generic/545 at 2022-01-12 13:41:53
> >[ 7282.904252] run fstests generic/546 at 2022-01-12 13:41:54
> >[ 7283.957773] run fstests generic/547 at 2022-01-12 13:41:55
> >[ 7284.580048] run fstests generic/548 at 2022-01-12 13:41:55
> >[ 7285.326032] run fstests generic/549 at 2022-01-12 13:41:56
> >[ 7286.075114] run fstests generic/550 at 2022-01-12 13:41:57
> >[ 7286.842980] run fstests generic/552 at 2022-01-12 13:41:58
> >[ 7287.485856] run fstests generic/553 at 2022-01-12 13:41:58
> >[ 7288.214457] run fstests generic/554 at 2022-01-12 13:41:59
> >[ 7289.123966] Adding 36k swap on /mnt2/swap.  Priority:-3 extents:1 acr=
oss:36k
> >[ 7290.370393] Adding 16380k swap on /mnt2/swapfile.  Priority:-3 extent=
s:1 across:16380k
> >[ 7290.687659] run fstests generic/555 at 2022-01-12 13:42:01
> >[ 7291.521126] run fstests generic/556 at 2022-01-12 13:42:02
> >[ 7292.049123] run fstests generic/557 at 2022-01-12 13:42:03
> >[ 7292.594633] run fstests generic/558 at 2022-01-12 13:42:03
> >[ 7293.116986] run fstests generic/559 at 2022-01-12 13:42:04
> >[ 7293.625068] run fstests generic/560 at 2022-01-12 13:42:04
> >[ 7294.150767] run fstests generic/561 at 2022-01-12 13:42:05
> >[ 7294.672595] run fstests generic/562 at 2022-01-12 13:42:05
> >[ 7295.755050] run fstests generic/563 at 2022-01-12 13:42:06
> >[ 7296.284954] run fstests generic/564 at 2022-01-12 13:42:07
> >[ 7297.286052] loop0: detected capacity change from 0 to 256
> >[ 7298.231618] run fstests generic/566 at 2022-01-12 13:42:09
> >[ 7298.730755] run fstests generic/567 at 2022-01-12 13:42:09
> >[ 7300.222707] run fstests generic/568 at 2022-01-12 13:42:11
> >[ 7301.134560] run fstests generic/569 at 2022-01-12 13:42:12
> >[ 7302.142643] Adding 36k swap on /mnt2/swap.  Priority:-3 extents:1 acr=
oss:36k
> >[ 7303.448133] Adding 20476k swap on /mnt2/569.swap.  Priority:-3 extent=
s:1 across:20476k
> >[ 7303.452275] NFS: attempt to write to active swap file!
> >[ 7303.487542] Adding 20476k swap on /mnt2/569.swap.  Priority:-3 extent=
s:1 across:20476k
> >[ 7303.530750] Adding 20476k swap on /mnt2/569.swap.  Priority:-3 extent=
s:1 across:20476k
> >[ 7303.587615] Adding 20476k swap on /mnt2/569.swap.  Priority:-3 extent=
s:1 across:20476k
> >[ 7303.629119] Adding 20476k swap on /mnt2/569.swap.  Priority:-3 extent=
s:1 across:20476k
> >[ 7303.646860] NFS: attempt to write to active swap file!
> >[ 7303.979451] run fstests generic/570 at 2022-01-12 13:42:15
> >[ 7304.692420] run fstests generic/572 at 2022-01-12 13:42:15
> >[ 7305.210036] run fstests generic/573 at 2022-01-12 13:42:16
> >[ 7305.731408] run fstests generic/574 at 2022-01-12 13:42:16
> >[ 7306.245226] run fstests generic/575 at 2022-01-12 13:42:17
> >[ 7306.755327] run fstests generic/576 at 2022-01-12 13:42:17
> >[ 7307.415264] run fstests generic/577 at 2022-01-12 13:42:18
> >[ 7307.966901] run fstests generic/579 at 2022-01-12 13:42:19
> >[ 7308.532284] run fstests generic/580 at 2022-01-12 13:42:19
> >[ 7309.267749] run fstests generic/581 at 2022-01-12 13:42:20
> >[ 7309.916075] run fstests generic/582 at 2022-01-12 13:42:21
> >[ 7310.643888] run fstests generic/583 at 2022-01-12 13:42:21
> >[ 7311.371543] run fstests generic/584 at 2022-01-12 13:42:22
> >[ 7312.108260] run fstests generic/585 at 2022-01-12 13:42:23
> >[ 7312.708730] run fstests generic/586 at 2022-01-12 13:42:23
> >[ 7321.372427] run fstests generic/587 at 2022-01-12 13:42:32
> >[ 7321.882959] run fstests generic/588 at 2022-01-12 13:42:33
> >[ 7322.869048] run fstests generic/589 at 2022-01-12 13:42:34
> >[ 7323.420928] run fstests generic/590 at 2022-01-12 13:42:34
> >[ 7599.522683] run fstests generic/591 at 2022-01-12 13:47:10
> >[ 7600.469219] run fstests generic/592 at 2022-01-12 13:47:11
> >[ 7601.209667] run fstests generic/593 at 2022-01-12 13:47:12
> >[ 7601.925298] run fstests generic/594 at 2022-01-12 13:47:13
> >[ 7602.455466] run fstests generic/595 at 2022-01-12 13:47:13
> >[ 7603.181000] run fstests generic/596 at 2022-01-12 13:47:14
> >[ 7603.583124] Process accounting resumed
> >[ 7603.780139] run fstests generic/597 at 2022-01-12 13:47:14
> >[ 7604.359127] run fstests generic/598 at 2022-01-12 13:47:15
> >[ 7604.907400] run fstests generic/599 at 2022-01-12 13:47:16
> >[ 7605.710364] run fstests generic/600 at 2022-01-12 13:47:16
> >[ 7606.295426] run fstests generic/601 at 2022-01-12 13:47:17
> >[ 7606.813031] run fstests generic/602 at 2022-01-12 13:47:18
> >[ 7607.566587] run fstests generic/603 at 2022-01-12 13:47:18
> >[ 7608.093235] run fstests generic/604 at 2022-01-12 13:47:19
> >[ 7613.505790] run fstests generic/605 at 2022-01-12 13:47:24
> >[ 7614.268456] nfs: Unknown parameter 'dax'
> >[ 7614.378027] run fstests generic/606 at 2022-01-12 13:47:25
> >[ 7614.970728] nfs: Unknown parameter 'dax'
> >[ 7615.132524] run fstests generic/608 at 2022-01-12 13:47:26
> >[ 7615.730417] nfs: Unknown parameter 'dax'
> >[ 7615.838044] run fstests generic/609 at 2022-01-12 13:47:27
> >[ 7616.725570] run fstests generic/611 at 2022-01-12 13:47:27
> >[ 7617.915374] run fstests nfs/001 at 2022-01-12 13:47:29
> >[ 7620.841996] run fstests shared/002 at 2022-01-12 13:47:32
> >[ 7621.379231] run fstests shared/032 at 2022-01-12 13:47:32
> >[ 7621.870631] run fstests shared/298 at 2022-01-12 13:47:33
> >[    0.000000] Linux version 5.16.0-00002-g616758bf6583 (bfields@patate.=
fieldses.org) (gcc (GCC) 11.2.1 20211203 (Red Hat 11.2.1-7), GNU ld version=
 2.37-10.fc35) #1278 SMP PREEMPT Wed Jan 12 11:37:28 EST 2022
> >[    0.000000] Command line: BOOT_IMAGE=3D(hd0,msdos1)/vmlinuz-5.16.0-00=
002-g616758bf6583 root=3D/dev/mapper/fedora-root ro resume=3D/dev/mapper/fe=
dora-swap rd.lvm.lv=3Dfedora/root rd.lvm.lv=3Dfedora/swap console=3DttyS0,3=
8400n8 consoleblank=3D0
> >[    0.000000] x86/fpu: Supporting XSAVE feature 0x001: 'x87 floating po=
int registers'
> >[    0.000000] x86/fpu: Supporting XSAVE feature 0x002: 'SSE registers'
> >[    0.000000] x86/fpu: Supporting XSAVE feature 0x004: 'AVX registers'
> >[    0.000000] x86/fpu: xstate_offset[2]:  576, xstate_sizes[2]:  256
> >[    0.000000] x86/fpu: Enabled xstate features 0x7, context size is 832=
 bytes, using 'standard' format.
> >[    0.000000] signal: max sigframe size: 1776
> >[    0.000000] BIOS-provided physical RAM map:
> >[    0.000000] BIOS-e820: [mem 0x0000000000000000-0x000000000009fbff] us=
able
> >[    0.000000] BIOS-e820: [mem 0x000000000009fc00-0x000000000009ffff] re=
served
> >[    0.000000] BIOS-e820: [mem 0x00000000000f0000-0x00000000000fffff] re=
served
> >[    0.000000] BIOS-e820: [mem 0x0000000000100000-0x000000007ffd7fff] us=
able
> >[    0.000000] BIOS-e820: [mem 0x000000007ffd8000-0x000000007fffffff] re=
served
> >[    0.000000] BIOS-e820: [mem 0x00000000feffc000-0x00000000feffffff] re=
served
> >[    0.000000] BIOS-e820: [mem 0x00000000fffc0000-0x00000000ffffffff] re=
served
> >[    0.000000] NX (Execute Disable) protection: active
> >[    0.000000] SMBIOS 2.8 present.
> >[    0.000000] DMI: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.14.0-=
6.fc35 04/01/2014
> >[    0.000000] tsc: Fast TSC calibration using PIT
> >[    0.000000] tsc: Detected 3591.667 MHz processor
> >[    0.000880] e820: update [mem 0x00000000-0x00000fff] usable =3D=3D> r=
eserved
> >[    0.000887] e820: remove [mem 0x000a0000-0x000fffff] usable
> >[    0.000894] last_pfn =3D 0x7ffd8 max_arch_pfn =3D 0x400000000
> >[    0.000926] x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB  WP  UC-=
 WT
> >[    0.004010] found SMP MP-table at [mem 0x000f5b80-0x000f5b8f]
> >[    0.004443] RAMDISK: [mem 0x346ce000-0x3635efff]
> >[    0.004450] ACPI: Early table checksum verification disabled
> >[    0.004455] ACPI: RSDP 0x00000000000F58F0 000014 (v00 BOCHS )
> >[    0.004464] ACPI: RSDT 0x000000007FFE1902 000030 (v01 BOCHS  BXPC    =
 00000001 BXPC 00000001)
> >[    0.004473] ACPI: FACP 0x000000007FFE17D6 000074 (v01 BOCHS  BXPC    =
 00000001 BXPC 00000001)
> >[    0.004482] ACPI: DSDT 0x000000007FFE0040 001796 (v01 BOCHS  BXPC    =
 00000001 BXPC 00000001)
> >[    0.004489] ACPI: FACS 0x000000007FFE0000 000040
> >[    0.004494] ACPI: APIC 0x000000007FFE184A 000090 (v01 BOCHS  BXPC    =
 00000001 BXPC 00000001)
> >[    0.004501] ACPI: WAET 0x000000007FFE18DA 000028 (v01 BOCHS  BXPC    =
 00000001 BXPC 00000001)
> >[    0.004506] ACPI: Reserving FACP table memory at [mem 0x7ffe17d6-0x7f=
fe1849]
> >[    0.004510] ACPI: Reserving DSDT table memory at [mem 0x7ffe0040-0x7f=
fe17d5]
> >[    0.004513] ACPI: Reserving FACS table memory at [mem 0x7ffe0000-0x7f=
fe003f]
> >[    0.004515] ACPI: Reserving APIC table memory at [mem 0x7ffe184a-0x7f=
fe18d9]
> >[    0.004518] ACPI: Reserving WAET table memory at [mem 0x7ffe18da-0x7f=
fe1901]
> >[    0.007926] Zone ranges:
> >[    0.007934]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
> >[    0.007940]   DMA32    [mem 0x0000000001000000-0x000000007ffd7fff]
> >[    0.007944]   Normal   empty
> >[    0.007947] Movable zone start for each node
> >[    0.007949] Early memory node ranges
> >[    0.007952]   node   0: [mem 0x0000000000001000-0x000000000009efff]
> >[    0.007955]   node   0: [mem 0x0000000000100000-0x000000007ffd7fff]
> >[    0.007959] Initmem setup node 0 [mem 0x0000000000001000-0x000000007f=
fd7fff]
> >[    0.007968] On node 0, zone DMA: 1 pages in unavailable ranges
> >[    0.008031] On node 0, zone DMA: 97 pages in unavailable ranges
> >[    0.015752] On node 0, zone DMA32: 40 pages in unavailable ranges
> >[    0.043852] kasan: KernelAddressSanitizer initialized
> >[    0.044423] ACPI: PM-Timer IO Port: 0x608
> >[    0.044432] ACPI: LAPIC_NMI (acpi_id[0xff] dfl dfl lint[0x1])
> >[    0.044477] IOAPIC[0]: apic_id 0, version 17, address 0xfec00000, GSI=
 0-23
> >[    0.044486] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
> >[    0.044490] ACPI: INT_SRC_OVR (bus 0 bus_irq 5 global_irq 5 high leve=
l)
> >[    0.044494] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high leve=
l)
> >[    0.044497] ACPI: INT_SRC_OVR (bus 0 bus_irq 10 global_irq 10 high le=
vel)
> >[    0.044500] ACPI: INT_SRC_OVR (bus 0 bus_irq 11 global_irq 11 high le=
vel)
> >[    0.044505] ACPI: Using ACPI (MADT) for SMP configuration information
> >[    0.044508] TSC deadline timer available
> >[    0.044514] smpboot: Allowing 4 CPUs, 0 hotplug CPUs
> >[    0.044531] [mem 0x80000000-0xfeffbfff] available for PCI devices
> >[    0.044536] clocksource: refined-jiffies: mask: 0xffffffff max_cycles=
: 0xffffffff, max_idle_ns: 7645519600211568 ns
> >[    0.059178] setup_percpu: NR_CPUS:8 nr_cpumask_bits:8 nr_cpu_ids:4 nr=
_node_ids:1
> >[    0.059473] percpu: Embedded 66 pages/cpu s231440 r8192 d30704 u524288
> >[    0.059481] pcpu-alloc: s231440 r8192 d30704 u524288 alloc=3D1*2097152
> >[    0.059486] pcpu-alloc: [0] 0 1 2 3
> >[    0.059518] Built 1 zonelists, mobility grouping on.  Total pages: 51=
6824
> >[    0.059528] Kernel command line: BOOT_IMAGE=3D(hd0,msdos1)/vmlinuz-5.=
16.0-00002-g616758bf6583 root=3D/dev/mapper/fedora-root ro resume=3D/dev/ma=
pper/fedora-swap rd.lvm.lv=3Dfedora/root rd.lvm.lv=3Dfedora/swap console=3D=
ttyS0,38400n8 consoleblank=3D0
> >[    0.059605] Unknown kernel command line parameters "BOOT_IMAGE=3D(hd0=
,msdos1)/vmlinuz-5.16.0-00002-g616758bf6583 resume=3D/dev/mapper/fedora-swa=
p", will be passed to user space.
> >[    0.059829] Dentry cache hash table entries: 262144 (order: 9, 209715=
2 bytes, linear)
> >[    0.059938] Inode-cache hash table entries: 131072 (order: 8, 1048576=
 bytes, linear)
> >[    0.059987] mem auto-init: stack:off, heap alloc:off, heap free:off
> >[    0.189829] Memory: 1652304K/2096600K available (49170K kernel code, =
11662K rwdata, 9292K rodata, 2076K init, 15268K bss, 444040K reserved, 0K c=
ma-reserved)
> >[    0.191638] Kernel/User page tables isolation: enabled
> >[    0.191721] ftrace: allocating 48466 entries in 190 pages
> >[    0.208382] ftrace: allocated 190 pages with 6 groups
> >[    0.208563] Dynamic Preempt: full
> >[    0.208737] Running RCU self tests
> >[    0.208749] rcu: Preemptible hierarchical RCU implementation.
> >[    0.208751] rcu: 	RCU lockdep checking is enabled.
> >[    0.208754] rcu: 	RCU restricting CPUs from NR_CPUS=3D8 to nr_cpu_ids=
=3D4.
> >[    0.208758] 	Trampoline variant of Tasks RCU enabled.
> >[    0.208760] 	Rude variant of Tasks RCU enabled.
> >[    0.208762] 	Tracing variant of Tasks RCU enabled.
> >[    0.208765] rcu: RCU calculated value of scheduler-enlistment delay i=
s 25 jiffies.
> >[    0.208767] rcu: Adjusting geometry for rcu_fanout_leaf=3D16, nr_cpu_=
ids=3D4
> >[    0.218069] NR_IRQS: 4352, nr_irqs: 72, preallocated irqs: 16
> >[    0.218411] random: get_random_bytes called from start_kernel+0x1ef/0=
x384 with crng_init=3D0
> >[    0.224704] Console: colour VGA+ 80x25
> >[    0.273917] printk: console [ttyS0] enabled
> >[    0.274215] Lock dependency validator: Copyright (c) 2006 Red Hat, In=
c., Ingo Molnar
> >[    0.274876] ... MAX_LOCKDEP_SUBCLASSES:  8
> >[    0.275165] ... MAX_LOCK_DEPTH:          48
> >[    0.275459] ... MAX_LOCKDEP_KEYS:        8192
> >[    0.275790] ... CLASSHASH_SIZE:          4096
> >[    0.276100] ... MAX_LOCKDEP_ENTRIES:     32768
> >[    0.276423] ... MAX_LOCKDEP_CHAINS:      65536
> >[    0.276742] ... CHAINHASH_SIZE:          32768
> >[    0.277061]  memory used by lock dependency info: 6365 kB
> >[    0.277476]  memory used for stack traces: 4224 kB
> >[    0.277830]  per task-struct memory footprint: 1920 bytes
> >[    0.278254] ACPI: Core revision 20210930
> >[    0.278762] APIC: Switch to symmetric I/O mode setup
> >[    0.280353] clocksource: tsc-early: mask: 0xffffffffffffffff max_cycl=
es: 0x33c5939df6d, max_idle_ns: 440795297647 ns
> >[    0.281280] Calibrating delay loop (skipped), value calculated using =
timer frequency.. 7183.33 BogoMIPS (lpj=3D14366668)
> >[    0.282204] pid_max: default: 32768 minimum: 301
> >[    0.282676] LSM: Security Framework initializing
> >[    0.283076] SELinux:  Initializing.
> >[    0.283465] Mount-cache hash table entries: 4096 (order: 3, 32768 byt=
es, linear)
> >[    0.284092] Mountpoint-cache hash table entries: 4096 (order: 3, 3276=
8 bytes, linear)
> >[    0.285279] Last level iTLB entries: 4KB 0, 2MB 0, 4MB 0
> >[    0.285279] Last level dTLB entries: 4KB 0, 2MB 0, 4MB 0, 1GB 0
> >[    0.285279] Spectre V1 : Mitigation: usercopy/swapgs barriers and __u=
ser pointer sanitization
> >[    0.285279] Spectre V2 : Mitigation: Full generic retpoline
> >[    0.285279] Spectre V2 : Spectre v2 / SpectreRSB mitigation: Filling =
RSB on context switch
> >[    0.285279] Spectre V2 : Enabling Restricted Speculation for firmware=
 calls
> >[    0.285279] Spectre V2 : mitigation: Enabling conditional Indirect Br=
anch Prediction Barrier
> >[    0.285279] Speculative Store Bypass: Vulnerable
> >[    0.285279] SRBDS: Unknown: Dependent on hypervisor status
> >[    0.285279] MDS: Vulnerable: Clear CPU buffers attempted, no microcode
> >[    0.285279] Freeing SMP alternatives memory: 44K
> >[    0.285279] smpboot: CPU0: Intel Core Processor (Haswell, no TSX, IBR=
S) (family: 0x6, model: 0x3c, stepping: 0x1)
> >[    0.285279] Running RCU-tasks wait API self tests
> >[    0.386107] Performance Events: unsupported p6 CPU model 60 no PMU dr=
iver, software events only.
> >[    0.389599] rcu: Hierarchical SRCU implementation.
> >[    0.392441] NMI watchdog: Perf NMI watchdog permanently disabled
> >[    0.393385] Callback from call_rcu_tasks_trace() invoked.
> >[    0.394170] smp: Bringing up secondary CPUs ...
> >[    0.396370] x86: Booting SMP configuration:
> >[    0.396786] .... node  #0, CPUs:      #1
> >[    0.066931] smpboot: CPU 1 Converting physical 0 to logical die 1
> >[    0.482790]  #2
> >[    0.066931] smpboot: CPU 2 Converting physical 0 to logical die 2
> >[    0.565821] Callback from call_rcu_tasks_rude() invoked.
> >[    0.567462]  #3
> >[    0.066931] smpboot: CPU 3 Converting physical 0 to logical die 3
> >[    0.649444] smp: Brought up 1 node, 4 CPUs
> >[    0.649755] smpboot: Max logical packages: 4
> >[    0.650109] smpboot: Total of 4 processors activated (28813.78 BogoMI=
PS)
> >[    0.652111] devtmpfs: initialized
> >[    0.656548] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffff=
ffff, max_idle_ns: 7645041785100000 ns
> >[    0.657296] futex hash table entries: 1024 (order: 5, 131072 bytes, l=
inear)
> >[    0.659317] NET: Registered PF_NETLINK/PF_ROUTE protocol family
> >[    0.660716] audit: initializing netlink subsys (disabled)
> >[    0.661311] audit: type=3D2000 audit(1642005696.380:1): state=3Diniti=
alized audit_enabled=3D0 res=3D1
> >[    0.662148] thermal_sys: Registered thermal governor 'step_wise'
> >[    0.662161] thermal_sys: Registered thermal governor 'user_space'
> >[    0.662741] cpuidle: using governor ladder
> >[    0.663957] PCI: Using configuration type 1 for base access
> >[    0.673336] Callback from call_rcu_tasks() invoked.
> >[    0.688468] kprobes: kprobe jump-optimization is enabled. All kprobes=
 are optimized if possible.
> >[    0.689933] HugeTLB registered 2.00 MiB page size, pre-allocated 0 pa=
ges
> >[    0.690902] cryptd: max_cpu_qlen set to 1000
> >[    0.757333] raid6: avx2x4   gen() 34683 MB/s
> >[    0.825285] raid6: avx2x4   xor() 13341 MB/s
> >[    0.893285] raid6: avx2x2   gen() 32969 MB/s
> >[    0.961293] raid6: avx2x2   xor() 18290 MB/s
> >[    1.029283] raid6: avx2x1   gen() 25495 MB/s
> >[    1.097283] raid6: avx2x1   xor() 16599 MB/s
> >[    1.165417] raid6: sse2x4   gen() 18858 MB/s
> >[    1.233284] raid6: sse2x4   xor()  9882 MB/s
> >[    1.301284] raid6: sse2x2   gen() 17529 MB/s
> >[    1.369284] raid6: sse2x2   xor() 10528 MB/s
> >[    1.437284] raid6: sse2x1   gen() 12868 MB/s
> >[    1.505284] raid6: sse2x1   xor()  9047 MB/s
> >[    1.505592] raid6: using algorithm avx2x4 gen() 34683 MB/s
> >[    1.506016] raid6: .... xor() 13341 MB/s, rmw enabled
> >[    1.506395] raid6: using avx2x2 recovery algorithm
> >[    1.507187] ACPI: Added _OSI(Module Device)
> >[    1.507507] ACPI: Added _OSI(Processor Device)
> >[    1.507827] ACPI: Added _OSI(3.0 _SCP Extensions)
> >[    1.508176] ACPI: Added _OSI(Processor Aggregator Device)
> >[    1.508594] ACPI: Added _OSI(Linux-Dell-Video)
> >[    1.508918] ACPI: Added _OSI(Linux-Lenovo-NV-HDMI-Audio)
> >[    1.509291] ACPI: Added _OSI(Linux-HPI-Hybrid-Graphics)
> >[    1.529597] ACPI: 1 ACPI AML tables successfully acquired and loaded
> >[    1.536937] ACPI: Interpreter enabled
> >[    1.537121] ACPI: PM: (supports S0 S5)
> >[    1.537300] ACPI: Using IOAPIC for interrupt routing
> >[    1.537790] PCI: Using host bridge windows from ACPI; if necessary, u=
se "pci=3Dnocrs" and report a bug
> >[    1.539878] ACPI: Enabled 2 GPEs in block 00 to 0F
> >[    1.582821] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-ff])
> >[    1.583389] acpi PNP0A03:00: _OSC: OS supports [ASPM ClockPM Segments=
 HPX-Type3]
> >[    1.584011] acpi PNP0A03:00: PCIe port services disabled; not request=
ing _OSC control
> >[    1.584761] acpi PNP0A03:00: fail to add MMCONFIG information, can't =
access extended PCI configuration space under this bridge.
> >[    1.585813] PCI host bridge to bus 0000:00
> >[    1.586147] pci_bus 0000:00: root bus resource [io  0x0000-0x0cf7 win=
dow]
> >[    1.586722] pci_bus 0000:00: root bus resource [io  0x0d00-0xffff win=
dow]
> >[    1.587293] pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000b=
ffff window]
> >[    1.587921] pci_bus 0000:00: root bus resource [mem 0x80000000-0xfebf=
ffff window]
> >[    1.588545] pci_bus 0000:00: root bus resource [mem 0x100000000-0x17f=
ffffff window]
> >[    1.589183] pci_bus 0000:00: root bus resource [bus 00-ff]
> >[    1.593451] pci 0000:00:00.0: [8086:1237] type 00 class 0x060000
> >[    1.604897] pci 0000:00:01.0: [8086:7000] type 00 class 0x060100
> >[    1.606756] pci 0000:00:01.1: [8086:7010] type 00 class 0x010180
> >[    1.609820] pci 0000:00:01.1: reg 0x20: [io  0xc2e0-0xc2ef]
> >[    1.611254] pci 0000:00:01.1: legacy IDE quirk: reg 0x10: [io  0x01f0=
-0x01f7]
> >[    1.611843] pci 0000:00:01.1: legacy IDE quirk: reg 0x14: [io  0x03f6]
> >[    1.612367] pci 0000:00:01.1: legacy IDE quirk: reg 0x18: [io  0x0170=
-0x0177]
> >[    1.612952] pci 0000:00:01.1: legacy IDE quirk: reg 0x1c: [io  0x0376]
> >[    1.613748] pci 0000:00:01.3: [8086:7113] type 00 class 0x068000
> >[    1.614670] pci 0000:00:01.3: quirk: [io  0x0600-0x063f] claimed by P=
IIX4 ACPI
> >[    1.615271] pci 0000:00:01.3: quirk: [io  0x0700-0x070f] claimed by P=
IIX4 SMB
> >[    1.616279] pci 0000:00:02.0: [1b36:0100] type 00 class 0x030000
> >[    1.618571] pci 0000:00:02.0: reg 0x10: [mem 0xf4000000-0xf7ffffff]
> >[    1.621026] pci 0000:00:02.0: reg 0x14: [mem 0xf8000000-0xfbffffff]
> >[    1.623401] pci 0000:00:02.0: reg 0x18: [mem 0xfc054000-0xfc055fff]
> >[    1.625293] pci 0000:00:02.0: reg 0x1c: [io  0xc200-0xc21f]
> >[    1.632521] pci 0000:00:02.0: reg 0x30: [mem 0xfc040000-0xfc04ffff pr=
ef]
> >[    1.643746] pci 0000:00:03.0: [1af4:1000] type 00 class 0x020000
> >[    1.645084] pci 0000:00:03.0: reg 0x10: [io  0xc220-0xc23f]
> >[    1.646115] pci 0000:00:03.0: reg 0x14: [mem 0xfc056000-0xfc056fff]
> >[    1.650262] pci 0000:00:03.0: reg 0x20: [mem 0xfebd4000-0xfebd7fff 64=
bit pref]
> >[    1.651726] pci 0000:00:03.0: reg 0x30: [mem 0xfc000000-0xfc03ffff pr=
ef]
> >[    1.663001] pci 0000:00:04.0: [8086:2668] type 00 class 0x040300
> >[    1.663848] pci 0000:00:04.0: reg 0x10: [mem 0xfc050000-0xfc053fff]
> >[    1.676622] pci 0000:00:05.0: [8086:2934] type 00 class 0x0c0300
> >[    1.678734] pci 0000:00:05.0: reg 0x20: [io  0xc240-0xc25f]
> >[    1.690560] pci 0000:00:05.1: [8086:2935] type 00 class 0x0c0300
> >[    1.692610] pci 0000:00:05.1: reg 0x20: [io  0xc260-0xc27f]
> >[    1.694089] pci 0000:00:05.2: [8086:2936] type 00 class 0x0c0300
> >[    1.696372] pci 0000:00:05.2: reg 0x20: [io  0xc280-0xc29f]
> >[    1.697989] pci 0000:00:05.7: [8086:293a] type 00 class 0x0c0320
> >[    1.698889] pci 0000:00:05.7: reg 0x10: [mem 0xfc057000-0xfc057fff]
> >[    1.707037] pci 0000:00:06.0: [1af4:1003] type 00 class 0x078000
> >[    1.708590] pci 0000:00:06.0: reg 0x10: [io  0xc000-0xc03f]
> >[    1.709714] pci 0000:00:06.0: reg 0x14: [mem 0xfc058000-0xfc058fff]
> >[    1.712836] pci 0000:00:06.0: reg 0x20: [mem 0xfebd8000-0xfebdbfff 64=
bit pref]
> >[    1.726059] pci 0000:00:07.0: [1af4:1001] type 00 class 0x010000
> >[    1.727542] pci 0000:00:07.0: reg 0x10: [io  0xc040-0xc07f]
> >[    1.728892] pci 0000:00:07.0: reg 0x14: [mem 0xfc059000-0xfc059fff]
> >[    1.731824] pci 0000:00:07.0: reg 0x20: [mem 0xfebdc000-0xfebdffff 64=
bit pref]
> >[    1.744361] pci 0000:00:08.0: [1af4:1002] type 00 class 0x00ff00
> >[    1.745286] pci 0000:00:08.0: reg 0x10: [io  0xc2a0-0xc2bf]
> >[    1.748005] pci 0000:00:08.0: reg 0x20: [mem 0xfebe0000-0xfebe3fff 64=
bit pref]
> >[    1.760699] pci 0000:00:09.0: [1af4:1005] type 00 class 0x00ff00
> >[    1.761568] pci 0000:00:09.0: reg 0x10: [io  0xc2c0-0xc2df]
> >[    1.764291] pci 0000:00:09.0: reg 0x20: [mem 0xfebe4000-0xfebe7fff 64=
bit pref]
> >[    1.775904] pci 0000:00:0a.0: [1af4:1001] type 00 class 0x010000
> >[    1.777237] pci 0000:00:0a.0: reg 0x10: [io  0xc080-0xc0bf]
> >[    1.778068] pci 0000:00:0a.0: reg 0x14: [mem 0xfc05a000-0xfc05afff]
> >[    1.781719] pci 0000:00:0a.0: reg 0x20: [mem 0xfebe8000-0xfebebfff 64=
bit pref]
> >[    1.794394] pci 0000:00:0b.0: [1af4:1001] type 00 class 0x010000
> >[    1.795745] pci 0000:00:0b.0: reg 0x10: [io  0xc0c0-0xc0ff]
> >[    1.796982] pci 0000:00:0b.0: reg 0x14: [mem 0xfc05b000-0xfc05bfff]
> >[    1.799779] pci 0000:00:0b.0: reg 0x20: [mem 0xfebec000-0xfebeffff 64=
bit pref]
> >[    1.812867] pci 0000:00:0c.0: [1af4:1001] type 00 class 0x010000
> >[    1.814289] pci 0000:00:0c.0: reg 0x10: [io  0xc100-0xc13f]
> >[    1.815517] pci 0000:00:0c.0: reg 0x14: [mem 0xfc05c000-0xfc05cfff]
> >[    1.818535] pci 0000:00:0c.0: reg 0x20: [mem 0xfebf0000-0xfebf3fff 64=
bit pref]
> >[    1.830979] pci 0000:00:0d.0: [1af4:1001] type 00 class 0x010000
> >[    1.832321] pci 0000:00:0d.0: reg 0x10: [io  0xc140-0xc17f]
> >[    1.833286] pci 0000:00:0d.0: reg 0x14: [mem 0xfc05d000-0xfc05dfff]
> >[    1.836445] pci 0000:00:0d.0: reg 0x20: [mem 0xfebf4000-0xfebf7fff 64=
bit pref]
> >[    1.848403] pci 0000:00:0e.0: [1af4:1001] type 00 class 0x010000
> >[    1.849691] pci 0000:00:0e.0: reg 0x10: [io  0xc180-0xc1bf]
> >[    1.850908] pci 0000:00:0e.0: reg 0x14: [mem 0xfc05e000-0xfc05efff]
> >[    1.853728] pci 0000:00:0e.0: reg 0x20: [mem 0xfebf8000-0xfebfbfff 64=
bit pref]
> >[    1.867912] pci 0000:00:0f.0: [1af4:1001] type 00 class 0x010000
> >[    1.869286] pci 0000:00:0f.0: reg 0x10: [io  0xc1c0-0xc1ff]
> >[    1.870507] pci 0000:00:0f.0: reg 0x14: [mem 0xfc05f000-0xfc05ffff]
> >[    1.873286] pci 0000:00:0f.0: reg 0x20: [mem 0xfebfc000-0xfebfffff 64=
bit pref]
> >[    1.886571] pci_bus 0000:00: on NUMA node 0
> >[    1.890389] ACPI: PCI: Interrupt link LNKA configured for IRQ 10
> >[    1.892145] ACPI: PCI: Interrupt link LNKB configured for IRQ 10
> >[    1.893842] ACPI: PCI: Interrupt link LNKC configured for IRQ 11
> >[    1.895486] ACPI: PCI: Interrupt link LNKD configured for IRQ 11
> >[    1.896509] ACPI: PCI: Interrupt link LNKS configured for IRQ 9
> >[    1.904775] pci 0000:00:02.0: vgaarb: setting as boot VGA device
> >[    1.904775] pci 0000:00:02.0: vgaarb: VGA device added: decodes=3Dio+=
mem,owns=3Dio+mem,locks=3Dnone
> >[    1.904775] pci 0000:00:02.0: vgaarb: bridge control possible
> >[    1.904775] vgaarb: loaded
> >[    1.904775] SCSI subsystem initialized
> >[    1.904775] libata version 3.00 loaded.
> >[    1.904775] ACPI: bus type USB registered
> >[    1.905259] usbcore: registered new interface driver usbfs
> >[    1.909389] usbcore: registered new interface driver hub
> >[    1.909860] usbcore: registered new device driver usb
> >[    1.910380] pps_core: LinuxPPS API ver. 1 registered
> >[    1.910754] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodol=
fo Giometti <giometti@linux.it>
> >[    1.911613] PTP clock support registered
> >[    1.912179] EDAC MC: Ver: 3.0.0
> >[    1.913040] Advanced Linux Sound Architecture Driver Initialized.
> >[    1.913040] PCI: Using ACPI for IRQ routing
> >[    1.913040] PCI: pci_cache_line_size set to 64 bytes
> >[    1.913040] e820: reserve RAM buffer [mem 0x0009fc00-0x0009ffff]
> >[    1.913040] e820: reserve RAM buffer [mem 0x7ffd8000-0x7fffffff]
> >[    1.913283] clocksource: Switched to clocksource tsc-early
> >[    2.100358] VFS: Disk quotas dquot_6.6.0
> >[    2.100783] VFS: Dquot-cache hash table entries: 512 (order 0, 4096 b=
ytes)
> >[    2.101643] FS-Cache: Loaded
> >[    2.102237] CacheFiles: Loaded
> >[    2.102534] pnp: PnP ACPI init
> >[    2.103635] pnp 00:03: [dma 2]
> >[    2.106017] pnp: PnP ACPI: found 5 devices
> >[    2.127076] clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff=
, max_idle_ns: 2085701024 ns
> >[    2.127982] NET: Registered PF_INET protocol family
> >[    2.128550] IP idents hash table entries: 32768 (order: 6, 262144 byt=
es, linear)
> >[    2.130129] tcp_listen_portaddr_hash hash table entries: 1024 (order:=
 4, 81920 bytes, linear)
> >[    2.130900] TCP established hash table entries: 16384 (order: 5, 1310=
72 bytes, linear)
> >[    2.131794] TCP bind hash table entries: 16384 (order: 8, 1179648 byt=
es, linear)
> >[    2.132819] TCP: Hash tables configured (established 16384 bind 16384)
> >[    2.133780] UDP hash table entries: 1024 (order: 5, 163840 bytes, lin=
ear)
> >[    2.134414] UDP-Lite hash table entries: 1024 (order: 5, 163840 bytes=
, linear)
> >[    2.135294] NET: Registered PF_UNIX/PF_LOCAL protocol family
> >[    2.135777] pci_bus 0000:00: resource 4 [io  0x0000-0x0cf7 window]
> >[    2.136308] pci_bus 0000:00: resource 5 [io  0x0d00-0xffff window]
> >[    2.136806] pci_bus 0000:00: resource 6 [mem 0x000a0000-0x000bffff wi=
ndow]
> >[    2.137427] pci_bus 0000:00: resource 7 [mem 0x80000000-0xfebfffff wi=
ndow]
> >[    2.137992] pci_bus 0000:00: resource 8 [mem 0x100000000-0x17fffffff =
window]
> >[    2.138908] pci 0000:00:01.0: PIIX3: Enabling Passive Release
> >[    2.139376] pci 0000:00:00.0: Limiting direct PCI/PCI transfers
> >[    2.139854] pci 0000:00:01.0: Activating ISA DMA hang workarounds
> >[    2.140425] pci 0000:00:02.0: Video device with shadowed ROM at [mem =
0x000c0000-0x000dffff]
> >[    3.202115] ACPI: \_SB_.LNKA: Enabled at IRQ 10
> >[    4.239171] pci 0000:00:05.0: quirk_usb_early_handoff+0x0/0xa70 took =
2048819 usecs
> >[    5.300725] ACPI: \_SB_.LNKB: Enabled at IRQ 11
> >[    6.347387] pci 0000:00:05.1: quirk_usb_early_handoff+0x0/0xa70 took =
2058145 usecs
> >[    7.421229] ACPI: \_SB_.LNKC: Enabled at IRQ 11
> >[    8.471039] pci 0000:00:05.2: quirk_usb_early_handoff+0x0/0xa70 took =
2073223 usecs
> >[    9.544718] ACPI: \_SB_.LNKD: Enabled at IRQ 10
> >[   10.599331] pci 0000:00:05.7: quirk_usb_early_handoff+0x0/0xa70 took =
2077756 usecs
> >[   10.600123] PCI: CLS 0 bytes, default 64
> >[   10.601188] Trying to unpack rootfs image as initramfs...
> >[   10.604786] Initialise system trusted keyrings
> >[   10.605377] workingset: timestamp_bits=3D62 max_order=3D19 bucket_ord=
er=3D0
> >[   10.607827] DLM installed
> >[   10.610089] Key type cifs.idmap registered
> >[   10.610742] fuse: init (API version 7.35)
> >[   10.611401] SGI XFS with ACLs, security attributes, no debug enabled
> >[   10.612942] ocfs2: Registered cluster interface o2cb
> >[   10.613684] ocfs2: Registered cluster interface user
> >[   10.614265] OCFS2 User DLM kernel interface loaded
> >[   10.617912] gfs2: GFS2 installed
> >[   10.626466] xor: automatically using best checksumming function   avx
> >[   10.627049] Key type asymmetric registered
> >[   10.627348] Asymmetric key parser 'x509' registered
> >[   10.627936] Block layer SCSI generic (bsg) driver version 0.4 loaded =
(major 251)
> >[   10.628640] io scheduler mq-deadline registered
> >[   10.628991] io scheduler kyber registered
> >[   10.629268] test_string_helpers: Running tests...
> >[   10.646349] cryptomgr_test (94) used greatest stack depth: 30192 byte=
s left
> >[   10.647783] shpchp: Standard Hot Plug PCI Controller Driver version: =
0.4
> >[   10.649320] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/i=
nput/input0
> >[   10.661911] ACPI: button: Power Button [PWRF]
> >[   11.308291] Freeing initrd memory: 29252K
> >[   11.309219] kworker/u8:1 (116) used greatest stack depth: 28384 bytes=
 left
> >[   11.613446] tsc: Refined TSC clocksource calibration: 3591.600 MHz
> >[   11.614007] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x=
33c55424d7b, max_idle_ns: 440795215499 ns
> >[   11.615017] clocksource: Switched to clocksource tsc
> >[   24.416686] Serial: 8250/16550 driver, 4 ports, IRQ sharing disabled
> >[   24.417569] 00:00: ttyS0 at I/O 0x3f8 (irq =3D 4, base_baud =3D 11520=
0) is a 16550A
> >[   24.421615] Non-volatile memory driver v1.3
> >[   24.421936] Linux agpgart interface v0.103
> >[   24.423208] ACPI: bus type drm_connector registered
> >[   24.444467] brd: module loaded
> >[   24.457220] loop: module loaded
> >[   24.458122] virtio_blk virtio2: [vda] 16777216 512-byte logical block=
s (8.59 GB/8.00 GiB)
> >[   24.462053]  vda: vda1 vda2
> >[   24.465619] virtio_blk virtio5: [vdb] 10485760 512-byte logical block=
s (5.37 GB/5.00 GiB)
> >[   24.469543] virtio_blk virtio6: [vdc] 10485760 512-byte logical block=
s (5.37 GB/5.00 GiB)
> >[   24.473451] virtio_blk virtio7: [vdd] 10485760 512-byte logical block=
s (5.37 GB/5.00 GiB)
> >[   24.477416] virtio_blk virtio8: [vde] 10485760 512-byte logical block=
s (5.37 GB/5.00 GiB)
> >[   24.481188] virtio_blk virtio9: [vdf] 41943040 512-byte logical block=
s (21.5 GB/20.0 GiB)
> >[   24.484978] virtio_blk virtio10: [vdg] 20971520 512-byte logical bloc=
ks (10.7 GB/10.0 GiB)
> >[   24.488125]  vdg:
> >[   24.489758] zram: Added device: zram0
> >[   24.492368] ata_piix 0000:00:01.1: version 2.13
> >[   24.496603] scsi host0: ata_piix
> >[   24.498008] scsi host1: ata_piix
> >[   24.498675] ata1: PATA max MWDMA2 cmd 0x1f0 ctl 0x3f6 bmdma 0xc2e0 ir=
q 14
> >[   24.499256] ata2: PATA max MWDMA2 cmd 0x170 ctl 0x376 bmdma 0xc2e8 ir=
q 15
> >[   24.501218] tun: Universal TUN/TAP device driver, 1.6
> >[   24.504829] e1000: Intel(R) PRO/1000 Network Driver
> >[   24.505219] e1000: Copyright (c) 1999-2006 Intel Corporation.
> >[   24.505862] e1000e: Intel(R) PRO/1000 Network Driver
> >[   24.506254] e1000e: Copyright(c) 1999 - 2015 Intel Corporation.
> >[   24.507072] PPP generic driver version 2.4.2
> >[   24.509436] aoe: AoE v85 initialised.
> >[   24.510102] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
> >[   24.510679] ehci-pci: EHCI PCI platform driver
> >[   24.657958] ata1.01: NODEV after polling detection
> >[   24.658233] ata1.00: ATAPI: QEMU DVD-ROM, 2.5+, max UDMA/100
> >[   24.660230] scsi 0:0:0:0: CD-ROM            QEMU     QEMU DVD-ROM    =
 2.5+ PQ: 0 ANSI: 5
> >[   24.714138] sr 0:0:0:0: [sr0] scsi3-mmc drive: 4x/4x cd/rw xa/form2 t=
ray
> >[   24.714722] cdrom: Uniform CD-ROM driver Revision: 3.20
> >[   24.749225] sr 0:0:0:0: Attached scsi CD-ROM sr0
> >[   24.750199] sr 0:0:0:0: Attached scsi generic sg0 type 5
> >[   25.753762] ehci-pci 0000:00:05.7: EHCI Host Controller
> >[   25.755008] ehci-pci 0000:00:05.7: new USB bus registered, assigned b=
us number 1
> >[   25.755944] ehci-pci 0000:00:05.7: irq 10, io mem 0xfc057000
> >[   25.769490] ehci-pci 0000:00:05.7: USB 2.0 started, EHCI 1.00
> >[   25.773616] hub 1-0:1.0: USB hub found
> >[   25.774306] hub 1-0:1.0: 6 ports detected
> >[   25.779054] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
> >[   25.779761] ohci-pci: OHCI PCI platform driver
> >[   25.780223] uhci_hcd: USB Universal Host Controller Interface driver
> >[   26.041366] usb 1-1: new high-speed USB device number 2 using ehci-pci
> >[   27.054250] uhci_hcd 0000:00:05.0: UHCI Host Controller
> >[   27.055419] uhci_hcd 0000:00:05.0: new USB bus registered, assigned b=
us number 2
> >[   27.056446] uhci_hcd 0000:00:05.0: irq 10, io port 0x0000c240
> >[   27.058858] hub 2-0:1.0: USB hub found
> >[   27.059323] hub 2-0:1.0: 2 ports detected
> >[   28.319755] uhci_hcd 0000:00:05.1: UHCI Host Controller
> >[   28.320738] uhci_hcd 0000:00:05.1: new USB bus registered, assigned b=
us number 3
> >[   28.321673] uhci_hcd 0000:00:05.1: irq 11, io port 0x0000c260
> >[   28.323716] hub 3-0:1.0: USB hub found
> >[   28.324067] hub 3-0:1.0: 2 ports detected
> >[   29.592163] uhci_hcd 0000:00:05.2: UHCI Host Controller
> >[   29.593127] uhci_hcd 0000:00:05.2: new USB bus registered, assigned b=
us number 4
> >[   29.594072] uhci_hcd 0000:00:05.2: irq 11, io port 0x0000c280
> >[   29.596130] hub 4-0:1.0: USB hub found
> >[   29.596496] hub 4-0:1.0: 2 ports detected
> >[   29.598855] usbcore: registered new interface driver usblp
> >[   29.599462] usbcore: registered new interface driver usb-storage
> >[   29.600541] i8042: PNP: PS/2 Controller [PNP0303:KBD,PNP0f13:MOU] at =
0x60,0x64 irq 1,12
> >[   29.602527] serio: i8042 KBD port at 0x60,0x64 irq 1
> >[   29.603702] serio: i8042 AUX port at 0x60,0x64 irq 12
> >[   29.605764] mousedev: PS/2 mouse device common for all mice
> >[   29.607846] input: AT Translated Set 2 keyboard as /devices/platform/=
i8042/serio0/input/input1
> >[   29.609776] input: PC Speaker as /devices/platform/pcspkr/input/input3
> >[   29.611498] device-mapper: core: CONFIG_IMA_DISABLE_HTABLE is disable=
d. Duplicate IMA measurements will not be recorded in the IMA log.
> >[   29.613021] device-mapper: uevent: version 1.0.3
> >[   29.614146] device-mapper: ioctl: 4.45.0-ioctl (2021-03-22) initialis=
ed: dm-devel@redhat.com
> >[   29.615545] device-mapper: multipath round-robin: version 1.2.0 loaded
> >[   29.616195] intel_pstate: CPU model not supported
> >[   29.627242] input: QEMU QEMU USB Tablet as /devices/pci0000:00/0000:0=
0:05.7/usb1/1-1/1-1:1.0/0003:0627:0001.0001/input/input5
> >[   29.629270] hid-generic 0003:0627:0001.0001: input: USB HID v0.01 Mou=
se [QEMU QEMU USB Tablet] on usb-0000:00:05.7-1/input0
> >[   29.631016] usbcore: registered new interface driver usbhid
> >[   29.631500] usbhid: USB HID core driver
> >[   29.640019] netem: version 1.3
> >[   29.640848] NET: Registered PF_INET6 protocol family
> >[   29.643109] Segment Routing with IPv6
> >[   29.643405] In-situ OAM (IOAM) with IPv6
> >[   29.643760] sit: IPv6, IPv4 and MPLS over IPv4 tunneling driver
> >[   29.645948] NET: Registered PF_PACKET protocol family
> >[   29.646371] NET: Registered PF_KEY protocol family
> >[   29.646805] sctp: Hash tables configured (bind 32/56)
> >[   29.647357] Key type dns_resolver registered
> >[   29.649453] IPI shorthand broadcast: enabled
> >[   29.649838] AVX2 version of gcm_enc/dec engaged.
> >[   29.650351] AES CTR mode by8 optimization enabled
> >[   29.651971] sched_clock: Marking stable (29586356484, 62931318)->(297=
23854493, -74566691)
> >[   29.654238] Loading compiled-in X.509 certificates
> >[   29.655218] debug_vm_pgtable: [debug_vm_pgtable         ]: Validating=
 architecture page table helpers
> >[   29.657030] Btrfs loaded, crc32c=3Dcrc32c-intel, zoned=3Dno, fsverity=
=3Dno
> >[   29.659515] ima: No TPM chip found, activating TPM-bypass!
> >[   29.660173] ima: Allocated hash algorithm: sha1
> >[   29.660593] ima: No architecture policies found
> >[   29.673045] ALSA device list:
> >[   29.673234]   #0: Virtual MIDI Card 1
> >[   29.682863] Freeing unused kernel image (initmem) memory: 2076K
> >[   29.717568] Write protecting the kernel read-only data: 61440k
> >[   29.721990] Freeing unused kernel image (text/rodata gap) memory: 202=
8K
> >[   29.724251] Freeing unused kernel image (rodata/data gap) memory: 948K
> >[   29.727486] Run /init as init process
> >[   29.727944]   with arguments:
> >[   29.727947]     /init
> >[   29.727951]   with environment:
> >[   29.727954]     HOME=3D/
> >[   29.727957]     TERM=3Dlinux
> >[   29.727960]     BOOT_IMAGE=3D(hd0,msdos1)/vmlinuz-5.16.0-00002-g61675=
8bf6583
> >[   29.727964]     resume=3D/dev/mapper/fedora-swap
> >[   29.803093] systemd[1]: systemd v246.13-1.fc33 running in system mode=
=2E (+PAM +AUDIT +SELINUX +IMA -APPARMOR +SMACK +SYSVINIT +UTMP +LIBCRYPTSE=
TUP +GCRYPT +GNUTLS +ACL +XZ +LZ4 +ZSTD +SECCOMP +BLKID +ELFUTILS +KMOD +ID=
N2 -IDN +PCRE2 default-hierarchy=3Dunified)
> >[   29.806218] systemd[1]: Detected virtualization kvm.
> >[   29.806681] systemd[1]: Detected architecture x86-64.
> >[   29.807140] systemd[1]: Running in initial RAM disk.
> >[   29.809901] systemd[1]: Set hostname to <test1.fieldses.org>.
> >[   29.885369] systemd-hiberna (1054) used greatest stack depth: 28256 b=
ytes left
> >[   29.979654] dracut-rootfs-g (1047) used greatest stack depth: 28216 b=
ytes left
> >[   30.021117] systemd[1]: /usr/lib/systemd/system/plymouth-start.servic=
e:15: Unit configured to use KillMode=3Dnone. This is unsafe, as it disable=
s systemd's process lifecycle management for the service. Please update you=
r service to use a safer KillMode=3D, such as 'mixed' or 'control-group'. S=
upport for KillMode=3Dnone is deprecated and will eventually be removed.
> >[   30.044537] systemd[1]: Queued start job for default target Initrd De=
fault Target.
> >[   30.047340] systemd[1]: Created slice system-systemd\x2dhibernate\x2d=
resume.slice.
> >[   30.050175] systemd[1]: Reached target Slices.
> >[   30.051386] systemd[1]: Reached target Swap.
> >[   30.052613] systemd[1]: Reached target Timers.
> >[   30.054515] systemd[1]: Listening on Journal Audit Socket.
> >[   30.056550] systemd[1]: Listening on Journal Socket (/dev/log).
> >[   30.058686] systemd[1]: Listening on Journal Socket.
> >[   30.060760] systemd[1]: Listening on udev Control Socket.
> >[   30.063831] systemd[1]: Listening on udev Kernel Socket.
> >[   30.065248] systemd[1]: Reached target Sockets.
> >[   30.066604] systemd[1]: Condition check resulted in Create list of st=
atic device nodes for the current kernel being skipped.
> >[   30.071265] systemd[1]: Started Memstrack Anylazing Service.
> >[   30.077532] systemd[1]: Started Hardware RNG Entropy Gatherer Daemon.
> >[   30.079586] systemd[1]: systemd-journald.service: unit configures an =
IP firewall, but the local system does not support BPF/cgroup firewalling.
> >[   30.080901] systemd[1]: (This warning is only shown for the first uni=
t using IP firewalling.)
> >[   30.085726] systemd[1]: Starting Journal Service...
> >[   30.087684] systemd[1]: Condition check resulted in Load Kernel Modul=
es being skipped.
> >[   30.089551] random: rngd: uninitialized urandom read (16 bytes read)
> >[   30.092470] systemd[1]: Starting Apply Kernel Variables...
> >[   30.098065] systemd[1]: Starting Create Static Device Nodes in /dev...
> >[   30.117909] systemd[1]: Starting Setup Virtual Console...
> >[   30.149991] systemd[1]: Finished Create Static Device Nodes in /dev.
> >[   30.159172] systemd[1]: memstrack.service: Succeeded.
> >[   30.198818] systemd[1]: Finished Apply Kernel Variables.
> >[   30.200519] audit: type=3D1130 audit(1642005725.913:2): pid=3D1 uid=
=3D0 auid=3D4294967295 ses=3D4294967295 subj=3Dkernel msg=3D'unit=3Dsystemd=
-sysctl comm=3D"systemd" exe=3D"/usr/lib/systemd/systemd" hostname=3D? addr=
=3D? terminal=3D? res=3Dsuccess'
> >[   30.227486] input: ImExPS/2 Generic Explorer Mouse as /devices/platfo=
rm/i8042/serio1/input/input4
> >[   30.460095] systemd[1]: Started Journal Service.
> >[   30.461750] audit: type=3D1130 audit(1642005726.177:3): pid=3D1 uid=
=3D0 auid=3D4294967295 ses=3D4294967295 subj=3Dkernel msg=3D'unit=3Dsystemd=
-journald comm=3D"systemd" exe=3D"/usr/lib/systemd/systemd" hostname=3D? ad=
dr=3D? terminal=3D? res=3Dsuccess'
> >[   30.803462] audit: type=3D1130 audit(1642005726.517:4): pid=3D1 uid=
=3D0 auid=3D4294967295 ses=3D4294967295 subj=3Dkernel msg=3D'unit=3Dsystemd=
-vconsole-setup comm=3D"systemd" exe=3D"/usr/lib/systemd/systemd" hostname=
=3D? addr=3D? terminal=3D? res=3Dsuccess'
> >[   31.357792] random: crng init done
> >[   31.748912] dracut-cmdline (1106) used greatest stack depth: 27968 by=
tes left
> >[   31.752614] audit: type=3D1130 audit(1642005727.465:5): pid=3D1 uid=
=3D0 auid=3D4294967295 ses=3D4294967295 subj=3Dkernel msg=3D'unit=3Ddracut-=
cmdline comm=3D"systemd" exe=3D"/usr/lib/systemd/systemd" hostname=3D? addr=
=3D? terminal=3D? res=3Dsuccess'
> >[   32.032836] audit: type=3D1130 audit(1642005727.745:6): pid=3D1 uid=
=3D0 auid=3D4294967295 ses=3D4294967295 subj=3Dkernel msg=3D'unit=3Ddracut-=
pre-udev comm=3D"systemd" exe=3D"/usr/lib/systemd/systemd" hostname=3D? add=
r=3D? terminal=3D? res=3Dsuccess'
> >[   32.157892] audit: type=3D1130 audit(1642005727.873:7): pid=3D1 uid=
=3D0 auid=3D4294967295 ses=3D4294967295 subj=3Dkernel msg=3D'unit=3Dsystemd=
-udevd comm=3D"systemd" exe=3D"/usr/lib/systemd/systemd" hostname=3D? addr=
=3D? terminal=3D? res=3Dsuccess'
> >[   34.122946] virtio_net virtio0 enp0s3: renamed from eth0
> >[   34.168250] kworker/u8:4 (1729) used greatest stack depth: 27536 byte=
s left
> >[   34.330444] ata_id (1886) used greatest stack depth: 26656 bytes left
> >[   34.467966] audit: type=3D1130 audit(1642005730.181:8): pid=3D1 uid=
=3D0 auid=3D4294967295 ses=3D4294967295 subj=3Dkernel msg=3D'unit=3Dsystemd=
-udev-trigger comm=3D"systemd" exe=3D"/usr/lib/systemd/systemd" hostname=3D=
? addr=3D? terminal=3D? res=3Dsuccess'
> >[   34.581444] audit: type=3D1130 audit(1642005730.293:9): pid=3D1 uid=
=3D0 auid=3D4294967295 ses=3D4294967295 subj=3Dkernel msg=3D'unit=3Dplymout=
h-start comm=3D"systemd" exe=3D"/usr/lib/systemd/systemd" hostname=3D? addr=
=3D? terminal=3D? res=3Dsuccess'
> >[   35.924826] audit: type=3D1130 audit(1642005731.637:10): pid=3D1 uid=
=3D0 auid=3D4294967295 ses=3D4294967295 subj=3Dkernel msg=3D'unit=3Dsystemd=
-hibernate-resume@dev-mapper-fedora\x2dswap comm=3D"systemd" exe=3D"/usr/li=
b/systemd/systemd" hostname=3D? addr=3D? terminal=3D? res=3Dfailed'
> >[   35.979064] audit: type=3D1130 audit(1642005731.693:11): pid=3D1 uid=
=3D0 auid=3D4294967295 ses=3D4294967295 subj=3Dkernel msg=3D'unit=3Dsystemd=
-tmpfiles-setup comm=3D"systemd" exe=3D"/usr/lib/systemd/systemd" hostname=
=3D? addr=3D? terminal=3D? res=3Dsuccess'
> >[   36.080161] audit: type=3D1130 audit(1642005731.793:12): pid=3D1 uid=
=3D0 auid=3D4294967295 ses=3D4294967295 subj=3Dkernel msg=3D'unit=3Ddracut-=
initqueue comm=3D"systemd" exe=3D"/usr/lib/systemd/systemd" hostname=3D? ad=
dr=3D? terminal=3D? res=3Dsuccess'
> >[   36.137141] fsck (2468) used greatest stack depth: 26560 bytes left
> >[   36.142664] audit: type=3D1130 audit(1642005731.857:13): pid=3D1 uid=
=3D0 auid=3D4294967295 ses=3D4294967295 subj=3Dkernel msg=3D'unit=3Dsystemd=
-fsck-root comm=3D"systemd" exe=3D"/usr/lib/systemd/systemd" hostname=3D? a=
ddr=3D? terminal=3D? res=3Dsuccess'
> >[   36.170836] XFS (dm-0): Mounting V5 Filesystem
> >[   36.314126] XFS (dm-0): Ending clean mount
> >[   36.383563] mount (2470) used greatest stack depth: 25344 bytes left
> >[   36.491652] systemd-fstab-g (2483) used greatest stack depth: 25008 b=
ytes left
> >[   37.102323] audit: type=3D1130 audit(1642005732.817:14): pid=3D1 uid=
=3D0 auid=3D4294967295 ses=3D4294967295 subj=3Dkernel msg=3D'unit=3Dinitrd-=
parse-etc comm=3D"systemd" exe=3D"/usr/lib/systemd/systemd" hostname=3D? ad=
dr=3D? terminal=3D? res=3Dsuccess'
> >[   37.104426] audit: type=3D1131 audit(1642005732.817:15): pid=3D1 uid=
=3D0 auid=3D4294967295 ses=3D4294967295 subj=3Dkernel msg=3D'unit=3Dinitrd-=
parse-etc comm=3D"systemd" exe=3D"/usr/lib/systemd/systemd" hostname=3D? ad=
dr=3D? terminal=3D? res=3Dsuccess'
> >[   37.254915] audit: type=3D1130 audit(1642005732.969:16): pid=3D1 uid=
=3D0 auid=3D4294967295 ses=3D4294967295 subj=3Dkernel msg=3D'unit=3Ddracut-=
pre-pivot comm=3D"systemd" exe=3D"/usr/lib/systemd/systemd" hostname=3D? ad=
dr=3D? terminal=3D? res=3Dsuccess'
> >[   37.290146] audit: type=3D1131 audit(1642005733.005:17): pid=3D1 uid=
=3D0 auid=3D4294967295 ses=3D4294967295 subj=3Dkernel msg=3D'unit=3Ddracut-=
pre-pivot comm=3D"systemd" exe=3D"/usr/lib/systemd/systemd" hostname=3D? ad=
dr=3D? terminal=3D? res=3Dsuccess'
> >[   37.296542] audit: type=3D1131 audit(1642005733.009:18): pid=3D1 uid=
=3D0 auid=3D4294967295 ses=3D4294967295 subj=3Dkernel msg=3D'unit=3Ddracut-=
initqueue comm=3D"systemd" exe=3D"/usr/lib/systemd/systemd" hostname=3D? ad=
dr=3D? terminal=3D? res=3Dsuccess'
> >[   37.304265] audit: type=3D1131 audit(1642005733.017:19): pid=3D1 uid=
=3D0 auid=3D4294967295 ses=3D4294967295 subj=3Dkernel msg=3D'unit=3Dsystemd=
-sysctl comm=3D"systemd" exe=3D"/usr/lib/systemd/systemd" hostname=3D? addr=
=3D? terminal=3D? res=3Dsuccess'
> >[   40.558013] SELinux:  Permission watch in class filesystem not define=
d in policy.
> >[   40.558745] SELinux:  Permission watch in class file not defined in p=
olicy.
> >[   40.559313] SELinux:  Permission watch_mount in class file not define=
d in policy.
> >[   40.559934] SELinux:  Permission watch_sb in class file not defined i=
n policy.
> >[   40.560593] SELinux:  Permission watch_with_perm in class file not de=
fined in policy.
> >[   40.561264] SELinux:  Permission watch_reads in class file not define=
d in policy.
> >[   40.561928] SELinux:  Permission watch in class dir not defined in po=
licy.
> >[   40.562491] SELinux:  Permission watch_mount in class dir not defined=
 in policy.
> >[   40.563098] SELinux:  Permission watch_sb in class dir not defined in=
 policy.
> >[   40.563684] SELinux:  Permission watch_with_perm in class dir not def=
ined in policy.
> >[   40.564391] SELinux:  Permission watch_reads in class dir not defined=
 in policy.
> >[   40.565023] SELinux:  Permission watch in class lnk_file not defined =
in policy.
> >[   40.565673] SELinux:  Permission watch_mount in class lnk_file not de=
fined in policy.
> >[   40.566349] SELinux:  Permission watch_sb in class lnk_file not defin=
ed in policy.
> >[   40.566973] SELinux:  Permission watch_with_perm in class lnk_file no=
t defined in policy.
> >[   40.567658] SELinux:  Permission watch_reads in class lnk_file not de=
fined in policy.
> >[   40.568356] SELinux:  Permission watch in class chr_file not defined =
in policy.
> >[   40.568977] SELinux:  Permission watch_mount in class chr_file not de=
fined in policy.
> >[   40.569671] SELinux:  Permission watch_sb in class chr_file not defin=
ed in policy.
> >[   40.570298] SELinux:  Permission watch_with_perm in class chr_file no=
t defined in policy.
> >[   40.570986] SELinux:  Permission watch_reads in class chr_file not de=
fined in policy.
> >[   40.571646] SELinux:  Permission watch in class blk_file not defined =
in policy.
> >[   40.572293] SELinux:  Permission watch_mount in class blk_file not de=
fined in policy.
> >[   40.573045] SELinux:  Permission watch_sb in class blk_file not defin=
ed in policy.
> >[   40.573722] SELinux:  Permission watch_with_perm in class blk_file no=
t defined in policy.
> >[   40.574413] SELinux:  Permission watch_reads in class blk_file not de=
fined in policy.
> >[   40.575086] SELinux:  Permission watch in class sock_file not defined=
 in policy.
> >[   40.575697] SELinux:  Permission watch_mount in class sock_file not d=
efined in policy.
> >[   40.576405] SELinux:  Permission watch_sb in class sock_file not defi=
ned in policy.
> >[   40.577058] SELinux:  Permission watch_with_perm in class sock_file n=
ot defined in policy.
> >[   40.577794] SELinux:  Permission watch_reads in class sock_file not d=
efined in policy.
> >[   40.578458] SELinux:  Permission watch in class fifo_file not defined=
 in policy.
> >[   40.579066] SELinux:  Permission watch_mount in class fifo_file not d=
efined in policy.
> >[   40.579727] SELinux:  Permission watch_sb in class fifo_file not defi=
ned in policy.
> >[   40.580405] SELinux:  Permission watch_with_perm in class fifo_file n=
ot defined in policy.
> >[   40.581116] SELinux:  Permission watch_reads in class fifo_file not d=
efined in policy.
> >[   40.581870] SELinux:  Permission perfmon in class capability2 not def=
ined in policy.
> >[   40.582516] SELinux:  Permission bpf in class capability2 not defined=
 in policy.
> >[   40.583123] SELinux:  Permission checkpoint_restore in class capabili=
ty2 not defined in policy.
> >[   40.583865] SELinux:  Permission perfmon in class cap2_userns not def=
ined in policy.
> >[   40.584574] SELinux:  Permission bpf in class cap2_userns not defined=
 in policy.
> >[   40.585208] SELinux:  Permission checkpoint_restore in class cap2_use=
rns not defined in policy.
> >[   40.586020] SELinux:  Class mctp_socket not defined in policy.
> >[   40.586482] SELinux:  Class perf_event not defined in policy.
> >[   40.586930] SELinux:  Class anon_inode not defined in policy.
> >[   40.587380] SELinux:  Class io_uring not defined in policy.
> >[   40.587811] SELinux: the above unknown classes and permissions will b=
e allowed
> >[   40.638612] SELinux:  policy capability network_peer_controls=3D1
> >[   40.639094] SELinux:  policy capability open_perms=3D1
> >[   40.639471] SELinux:  policy capability extended_socket_class=3D1
> >[   40.639937] SELinux:  policy capability always_check_network=3D0
> >[   40.640472] SELinux:  policy capability cgroup_seclabel=3D1
> >[   40.640907] SELinux:  policy capability nnp_nosuid_transition=3D1
> >[   40.641442] SELinux:  policy capability genfs_seclabel_symlinks=3D0
> >[   40.858863] systemd[1]: Successfully loaded SELinux policy in 2.43031=
4s.
> >[   41.410189] systemd[1]: Relabelled /dev, /dev/shm, /run, /sys/fs/cgro=
up in 249.521ms.
> >[   41.418749] systemd[1]: systemd v246.13-1.fc33 running in system mode=
=2E (+PAM +AUDIT +SELINUX +IMA -APPARMOR +SMACK +SYSVINIT +UTMP +LIBCRYPTSE=
TUP +GCRYPT +GNUTLS +ACL +XZ +LZ4 +ZSTD +SECCOMP +BLKID +ELFUTILS +KMOD +ID=
N2 -IDN +PCRE2 default-hierarchy=3Dunified)
> >[   41.421461] systemd[1]: Detected virtualization kvm.
> >[   41.421851] systemd[1]: Detected architecture x86-64.
> >[   41.439136] systemd[1]: Set hostname to <test1.fieldses.org>.
> >[   41.753375] lvmconfig (2543) used greatest stack depth: 24544 bytes l=
eft
> >[   41.774174] grep (2557) used greatest stack depth: 24448 bytes left
> >[   41.800082] zram_generator::generator[2554]: Creating dev-zram0.swap =
for /dev/zram0 (823MB)
> >[   41.850246] systemd-sysv-generator[2552]: SysV service '/etc/rc.d/ini=
t.d/network' lacks a native systemd unit file. Automatically generating a u=
nit file for compatibility. Please update package to include a native syste=
md unit file, in order to make it more safe and robust.
> >[   42.699764] systemd[1]: /usr/lib/systemd/system/plymouth-start.servic=
e:15: Unit configured to use KillMode=3Dnone. This is unsafe, as it disable=
s systemd's process lifecycle management for the service. Please update you=
r service to use a safer KillMode=3D, such as 'mixed' or 'control-group'. S=
upport for KillMode=3Dnone is deprecated and will eventually be removed.
> >[   42.961005] systemd[1]: /usr/lib/systemd/system/mcelog.service:8: Sta=
ndard output type syslog is obsolete, automatically updating to journal. Pl=
ease update your unit file, and consider removing the setting altogether.
> >[   43.550746] kauditd_printk_skb: 13 callbacks suppressed
> >[   43.550750] audit: type=3D1131 audit(1642005739.265:33): pid=3D1 uid=
=3D0 auid=3D4294967295 ses=3D4294967295 subj=3Dsystem_u:system_r:init_t:s0 =
msg=3D'unit=3Dsystemd-journald comm=3D"systemd" exe=3D"/usr/lib/systemd/sys=
temd" hostname=3D? addr=3D? terminal=3D? res=3Dsuccess'
> >[   43.557309] systemd[1]: initrd-switch-root.service: Succeeded.
> >[   43.559018] systemd[1]: Stopped Switch Root.
> >[   43.559933] audit: type=3D1130 audit(1642005739.273:34): pid=3D1 uid=
=3D0 auid=3D4294967295 ses=3D4294967295 subj=3Dsystem_u:system_r:init_t:s0 =
msg=3D'unit=3Dinitrd-switch-root comm=3D"systemd" exe=3D"/usr/lib/systemd/s=
ystemd" hostname=3D? addr=3D? terminal=3D? res=3Dsuccess'
> >[   43.562887] audit: type=3D1131 audit(1642005739.277:35): pid=3D1 uid=
=3D0 auid=3D4294967295 ses=3D4294967295 subj=3Dsystem_u:system_r:init_t:s0 =
msg=3D'unit=3Dinitrd-switch-root comm=3D"systemd" exe=3D"/usr/lib/systemd/s=
ystemd" hostname=3D? addr=3D? terminal=3D? res=3Dsuccess'
> >[   43.563870] systemd[1]: systemd-journald.service: Scheduled restart j=
ob, restart counter is at 1.
> >[   43.566772] systemd[1]: Created slice system-getty.slice.
> >[   43.568626] systemd[1]: Created slice system-modprobe.slice.
> >[   43.570533] systemd[1]: Created slice system-serial\x2dgetty.slice.
> >[   43.572518] systemd[1]: Created slice system-sshd\x2dkeygen.slice.
> >[   43.575249] systemd[1]: Created slice system-swap\x2dcreate.slice.
> >[   43.577790] systemd[1]: Created slice system-systemd\x2dfsck.slice.
> >[   43.580470] systemd[1]: Created slice User and Session Slice.
> >[   43.581081] systemd[1]: Condition check resulted in Dispatch Password=
 Requests to Console Directory Watch being skipped.
> >[   43.583848] systemd[1]: Started Forward Password Requests to Wall Dir=
ectory Watch.
> >[   43.587144] systemd[1]: Set up automount Arbitrary Executable File Fo=
rmats File System Automount Point.
> >[   43.588834] systemd[1]: Reached target Local Encrypted Volumes.
> >[   43.589488] systemd[1]: Stopped target Switch Root.
> >[   43.590478] systemd[1]: Stopped target Initrd File Systems.
> >[   43.591448] systemd[1]: Stopped target Initrd Root File System.
> >[   43.592607] systemd[1]: Reached target Paths.
> >[   43.593681] systemd[1]: Reached target Slices.
> >[   43.595921] systemd[1]: Listening on Device-mapper event daemon FIFOs.
> >[   43.599288] systemd[1]: Listening on LVM2 poll daemon socket.
> >[   43.603589] systemd[1]: Listening on RPCbind Server Activation Socket.
> >[   43.604301] systemd[1]: Reached target RPC Port Mapper.
> >[   43.621281] systemd[1]: Listening on Process Core Dump Socket.
> >[   43.623666] systemd[1]: Listening on initctl Compatibility Named Pipe.
> >[   43.639128] systemd[1]: Listening on udev Control Socket.
> >[   43.641921] systemd[1]: Listening on udev Kernel Socket.
> >[   43.648355] systemd[1]: Activating swap /dev/mapper/fedora-swap...
> >[   43.654892] systemd[1]: Mounting Huge Pages File System...
> >[   43.661099] systemd[1]: Mounting POSIX Message Queue File System...
> >[   43.667262] systemd[1]: Mounting NFSD configuration filesystem...
> >[   43.676216] systemd[1]: Mounting Kernel Debug File System...
> >[   43.682222] Adding 839676k swap on /dev/mapper/fedora-swap.  Priority=
:-2 extents:1 across:839676k
> >[   43.684653] systemd[1]: Starting Kernel Module supporting RPCSEC_GSS.=
=2E.
> >[   43.686822] systemd[1]: Condition check resulted in Create list of st=
atic device nodes for the current kernel being skipped.
> >[   43.696795] systemd[1]: Starting Monitoring of LVM2 mirrors, snapshot=
s etc. using dmeventd or progress polling...
> >[   43.703564] systemd[1]: Starting Load Kernel Module configfs...
> >[   43.711831] systemd[1]: Starting Load Kernel Module drm...
> >[   43.721843] systemd[1]: Starting Load Kernel Module fuse...
> >[   43.735057] systemd[1]: Starting Preprocess NFS configuration convert=
ion...
> >[   43.739099] systemd[1]: plymouth-switch-root.service: Succeeded.
> >[   43.742433] systemd[1]: Stopped Plymouth switch root service.
> >[   43.744497] audit: type=3D1131 audit(1642005739.457:36): pid=3D1 uid=
=3D0 auid=3D4294967295 ses=3D4294967295 subj=3Dsystem_u:system_r:init_t:s0 =
msg=3D'unit=3Dplymouth-switch-root comm=3D"systemd" exe=3D"/usr/lib/systemd=
/systemd" hostname=3D? addr=3D? terminal=3D? res=3Dsuccess'
> >[   43.751143] systemd[1]: Starting Create swap on /dev/zram0...
> >[   43.752961] systemd[1]: Condition check resulted in Set Up Additional=
 Binary Formats being skipped.
> >[   43.755225] systemd[1]: systemd-fsck-root.service: Succeeded.
> >[   43.758291] systemd[1]: Stopped File System Check on Root Device.
> >[   43.759755] audit: type=3D1131 audit(1642005739.473:37): pid=3D1 uid=
=3D0 auid=3D4294967295 ses=3D4294967295 subj=3Dsystem_u:system_r:init_t:s0 =
msg=3D'unit=3Dsystemd-fsck-root comm=3D"systemd" exe=3D"/usr/lib/systemd/sy=
stemd" hostname=3D? addr=3D? terminal=3D? res=3Dsuccess'
> >[   43.759862] systemd[1]: Stopped Journal Service.
> >[   43.766144] audit: type=3D1130 audit(1642005739.481:38): pid=3D1 uid=
=3D0 auid=3D4294967295 ses=3D4294967295 subj=3Dsystem_u:system_r:init_t:s0 =
msg=3D'unit=3Dsystemd-journald comm=3D"systemd" exe=3D"/usr/lib/systemd/sys=
temd" hostname=3D? addr=3D? terminal=3D? res=3Dsuccess'
> >[   43.770089] audit: type=3D1131 audit(1642005739.481:39): pid=3D1 uid=
=3D0 auid=3D4294967295 ses=3D4294967295 subj=3Dsystem_u:system_r:init_t:s0 =
msg=3D'unit=3Dsystemd-journald comm=3D"systemd" exe=3D"/usr/lib/systemd/sys=
temd" hostname=3D? addr=3D? terminal=3D? res=3Dsuccess'
> >[   43.785015] systemd[1]: Starting Journal Service...
> >[   43.786753] systemd[1]: Condition check resulted in Load Kernel Modul=
es being skipped.
> >[   43.788967] zram0: detected capacity change from 0 to 1685504
> >[   43.792217] systemd[1]: Starting Remount Root and Kernel File Systems=
=2E..
> >[   43.793231] systemd[1]: Condition check resulted in Repartition Root =
Disk being skipped.
> >[   43.799775] systemd[1]: Starting Apply Kernel Variables...
> >[   43.830240] systemd[1]: Starting Coldplug All udev Devices...
> >[   43.833802] systemd[1]: sysroot.mount: Succeeded.
> >[   43.838089] RPC: Registered named UNIX socket transport module.
> >[   43.838642] RPC: Registered udp transport module.
> >[   43.838999] RPC: Registered tcp transport module.
> >[   43.839369] RPC: Registered tcp NFSv4.1 backchannel transport module.
> >[   43.854269] systemd[1]: Activated swap /dev/mapper/fedora-swap.
> >[   43.871240] audit: type=3D1305 audit(1642005739.585:40): op=3Dset aud=
it_enabled=3D1 old=3D1 auid=3D4294967295 ses=3D4294967295 subj=3Dsystem_u:s=
ystem_r:syslogd_t:s0 res=3D1
> >[   43.872637] audit: type=3D1300 audit(1642005739.585:40): arch=3Dc0000=
03e syscall=3D46 success=3Dyes exit=3D60 a0=3D5 a1=3D7ffd304bc550 a2=3D4000=
 a3=3D7ffd304bc5fc items=3D0 ppid=3D1 pid=3D2572 auid=3D4294967295 uid=3D0 =
gid=3D0 euid=3D0 suid=3D0 fsuid=3D0 egid=3D0 sgid=3D0 fsgid=3D0 tty=3D(none=
) ses=3D4294967295 comm=3D"systemd-journal" exe=3D"/usr/lib/systemd/systemd=
-journald" subj=3Dsystem_u:system_r:syslogd_t:s0 key=3D(null)
> >[   43.876478] audit: type=3D1327 audit(1642005739.585:40): proctitle=3D=
"/usr/lib/systemd/systemd-journald"
> >[   43.882944] systemd[1]: Mounted Huge Pages File System.
> >[   43.886495] xfs filesystem being remounted at / supports timestamps u=
ntil 2038 (0x7fffffff)
> >[   43.895767] systemd[1]: Started Journal Service.
> >[   43.974904] Adding 842748k swap on /dev/zram0.  Priority:100 extents:=
1 across:842748k SS
> >[   43.996937] Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
> >[   46.194003] BTRFS: device fsid 27379e6a-3b97-45ef-bf83-dc7e8178b695 d=
evid 1 transid 865 /dev/vde scanned by systemd-udevd (3767)
> >[   47.371666] FAT-fs (vdg): Volume was not properly unmounted. Some dat=
a may be corrupt. Please run fsck.
> >[   47.378054] XFS (vdb): Mounting V5 Filesystem
> >[   47.384999] XFS (vdf): Mounting V5 Filesystem
> >[   47.404867] EXT4-fs (vdd): mounted filesystem with ordered data mode.=
 Opts: (null). Quota mode: none.
> >[   47.576714] EXT4-fs (vda1): mounted filesystem with ordered data mode=
=2E Opts: (null). Quota mode: none.
> >[   48.050435] XFS (vdf): Ending clean mount
> >[   48.091447] XFS (vdb): Ending clean mount
> >[   48.100548] xfs filesystem being mounted at /exports/xfs2 supports ti=
mestamps until 2038 (0x7fffffff)
> >[   48.102015] xfs filesystem being mounted at /exports/xfs supports tim=
estamps until 2038 (0x7fffffff)
> >[   48.600280] kauditd_printk_skb: 40 callbacks suppressed
> >[   48.600285] audit: type=3D1130 audit(1642005744.313:73): pid=3D1 uid=
=3D0 auid=3D4294967295 ses=3D4294967295 subj=3Dsystem_u:system_r:init_t:s0 =
msg=3D'unit=3Dnfs-idmapd comm=3D"systemd" exe=3D"/usr/lib/systemd/systemd" =
hostname=3D? addr=3D? terminal=3D? res=3Dsuccess'
> >[   48.650555] audit: type=3D1400 audit(1642005744.365:74): avc:  denied=
  { map } for  pid=3D3849 comm=3D"nfsdcld" path=3D"/var/lib/nfs/nfsdcld/mai=
n.sqlite-shm" dev=3D"dm-0" ino=3D873070 scontext=3Dsystem_u:system_r:init_t=
:s0 tcontext=3Dsystem_u:object_r:var_lib_nfs_t:s0 tclass=3Dfile permissive=
=3D1
> >[   48.655197] audit: type=3D1300 audit(1642005744.365:74): arch=3Dc0000=
03e syscall=3D9 success=3Dyes exit=3D140401715851264 a0=3D0 a1=3D8000 a2=3D=
3 a3=3D1 items=3D0 ppid=3D1 pid=3D3849 auid=3D4294967295 uid=3D0 gid=3D0 eu=
id=3D0 suid=3D0 fsuid=3D0 egid=3D0 sgid=3D0 fsgid=3D0 tty=3D(none) ses=3D42=
94967295 comm=3D"nfsdcld" exe=3D"/root/nfsdcld" subj=3Dsystem_u:system_r:in=
it_t:s0 key=3D(null)
> >[   48.659212] audit: type=3D1327 audit(1642005744.365:74): proctitle=3D=
"/root/nfsdcld"
> >[   48.662263] audit: type=3D1305 audit(1642005744.377:75): op=3Dset aud=
it_enabled=3D1 old=3D1 auid=3D4294967295 ses=3D4294967295 subj=3Dsystem_u:s=
ystem_r:auditd_t:s0 res=3D1
> >[   48.663809] audit: type=3D1300 audit(1642005744.377:75): arch=3Dc0000=
03e syscall=3D44 success=3Dyes exit=3D60 a0=3D3 a1=3D7ffd61589d20 a2=3D3c a=
3=3D0 items=3D0 ppid=3D3844 pid=3D3850 auid=3D4294967295 uid=3D0 gid=3D0 eu=
id=3D0 suid=3D0 fsuid=3D0 egid=3D0 sgid=3D0 fsgid=3D0 tty=3D(none) ses=3D42=
94967295 comm=3D"auditd" exe=3D"/usr/sbin/auditd" subj=3Dsystem_u:system_r:=
auditd_t:s0 key=3D(null)
> >[   48.668534] audit: type=3D1327 audit(1642005744.377:75): proctitle=3D=
"/sbin/auditd"
> >[   48.669369] audit: type=3D1305 audit(1642005744.377:76): op=3Dset aud=
it_pid=3D3850 old=3D0 auid=3D4294967295 ses=3D4294967295 subj=3Dsystem_u:sy=
stem_r:auditd_t:s0 res=3D1
> >[   48.670842] audit: type=3D1300 audit(1642005744.377:76): arch=3Dc0000=
03e syscall=3D44 success=3Dyes exit=3D60 a0=3D3 a1=3D7ffd615879d0 a2=3D3c a=
3=3D0 items=3D0 ppid=3D3844 pid=3D3850 auid=3D4294967295 uid=3D0 gid=3D0 eu=
id=3D0 suid=3D0 fsuid=3D0 egid=3D0 sgid=3D0 fsgid=3D0 tty=3D(none) ses=3D42=
94967295 comm=3D"auditd" exe=3D"/usr/sbin/auditd" subj=3Dsystem_u:system_r:=
auditd_t:s0 key=3D(null)
> >[   48.673934] audit: type=3D1327 audit(1642005744.377:76): proctitle=3D=
"/sbin/auditd"
> >[   51.467504] plymouthd (2385) used greatest stack depth: 24080 bytes l=
eft
> >[   52.964929] NFSD: Using nfsdcld client tracking operations.
> >[   52.965487] NFSD: no clients to reclaim, skipping NFSv4 grace period =
(net f0000098)
> >[   57.672761] rpm (4068) used greatest stack depth: 22976 bytes left
> >[  201.516445] clocksource: timekeeping watchdog on CPU2: acpi_pm retrie=
d 2 times before success
> >
> >[  335.595143] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >[  335.596176] WARNING: possible circular locking dependency detected
> >[  335.597128] 5.16.0-00002-g616758bf6583 #1278 Not tainted
> >[  335.597903] ------------------------------------------------------
> >[  335.598845] kworker/u8:0/7 is trying to acquire lock:
> >[  335.599582] ffff888010393b60 (&clp->cl_lock){+.+.}-{2:2}, at: laundro=
mat_main+0x177d/0x23b0 [nfsd]
> >[  335.601111]
> >                but task is already holding lock:
> >[  335.601750] ffff888010393e18 (&clp->cl_cs_lock){+.+.}-{2:2}, at: laun=
dromat_main+0x33e/0x23b0 [nfsd]
> >[  335.602896]
> >                which lock already depends on the new lock.
> >
> >[  335.603378]
> >                the existing dependency chain (in reverse order) is:
> >[  335.603897]
> >                -> #2 (&clp->cl_cs_lock){+.+.}-{2:2}:
> >[  335.604305]        _raw_spin_lock+0x2f/0x40
> >[  335.604622]        nfsd4_fl_expire_lock+0x7a/0x330 [nfsd]
> >[  335.605078]        posix_lock_inode+0x9b8/0x1a50
> >[  335.605442]        nfsd4_lock+0xe33/0x3d20 [nfsd]
> >[  335.605827]        nfsd4_proc_compound+0xcef/0x21e0 [nfsd]
> >[  335.606289]        nfsd_dispatch+0x4b8/0xbd0 [nfsd]
> >[  335.606692]        svc_process_common+0xd56/0x1ac0 [sunrpc]
> >[  335.607188]        svc_process+0x32e/0x4a0 [sunrpc]
> >[  335.607604]        nfsd+0x306/0x530 [nfsd]
> >[  335.607923]        kthread+0x3b1/0x490
> >[  335.608199]        ret_from_fork+0x22/0x30
> >[  335.608512]
> >                -> #1 (&ctx->flc_lock){+.+.}-{2:2}:
> >[  335.608878]        _raw_spin_lock+0x2f/0x40
> >[  335.609187]        check_for_locks+0xcf/0x200 [nfsd]
> >[  335.609602]        nfsd4_release_lockowner+0x583/0xa20 [nfsd]
> >[  335.610093]        nfsd4_proc_compound+0xcef/0x21e0 [nfsd]
> >[  335.610564]        nfsd_dispatch+0x4b8/0xbd0 [nfsd]
> >[  335.610963]        svc_process_common+0xd56/0x1ac0 [sunrpc]
> >[  335.611450]        svc_process+0x32e/0x4a0 [sunrpc]
> >[  335.611863]        nfsd+0x306/0x530 [nfsd]
> >[  335.612193]        kthread+0x3b1/0x490
> >[  335.612463]        ret_from_fork+0x22/0x30
> >[  335.612764]
> >                -> #0 (&clp->cl_lock){+.+.}-{2:2}:
> >[  335.613120]        __lock_acquire+0x29f8/0x5b80
> >[  335.613469]        lock_acquire+0x1a6/0x4b0
> >[  335.613763]        _raw_spin_lock+0x2f/0x40
> >[  335.614057]        laundromat_main+0x177d/0x23b0 [nfsd]
> >[  335.614477]        process_one_work+0x7ec/0x1320
> >[  335.614813]        worker_thread+0x59e/0xf90
> >[  335.615135]        kthread+0x3b1/0x490
> >[  335.615409]        ret_from_fork+0x22/0x30
> >[  335.615695]
> >                other info that might help us debug this:
> >
> >[  335.616135] Chain exists of:
> >                  &clp->cl_lock --> &ctx->flc_lock --> &clp->cl_cs_lock
> >
> >[  335.616806]  Possible unsafe locking scenario:
> >
> >[  335.617140]        CPU0                    CPU1
> >[  335.617467]        ----                    ----
> >[  335.617793]   lock(&clp->cl_cs_lock);
> >[  335.618036]                                lock(&ctx->flc_lock);
> >[  335.618531]                                lock(&clp->cl_cs_lock);
> >[  335.619037]   lock(&clp->cl_lock);
> >[  335.619256]
> >                 *** DEADLOCK ***
> >
> >[  335.619487] 4 locks held by kworker/u8:0/7:
> >[  335.619780]  #0: ffff88800ca5b138 ((wq_completion)nfsd4){+.+.}-{0:0},=
 at: process_one_work+0x6f5/0x1320
> >[  335.620619]  #1: ffff88800776fdd8 ((work_completion)(&(&nn->laundroma=
t_work)->work)){+.+.}-{0:0}, at: process_one_work+0x723/0x1320
> >[  335.621657]  #2: ffff888008a4c190 (&nn->client_lock){+.+.}-{2:2}, at:=
 laundromat_main+0x2b4/0x23b0 [nfsd]
> >[  335.622499]  #3: ffff888010393e18 (&clp->cl_cs_lock){+.+.}-{2:2}, at:=
 laundromat_main+0x33e/0x23b0 [nfsd]
> >[  335.623462]
> >                stack backtrace:
> >[  335.623648] CPU: 2 PID: 7 Comm: kworker/u8:0 Not tainted 5.16.0-00002=
-g616758bf6583 #1278
> >[  335.624364] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BI=
OS 1.14.0-6.fc35 04/01/2014
> >[  335.625124] Workqueue: nfsd4 laundromat_main [nfsd]
> >[  335.625514] Call Trace:
> >[  335.625641]  <TASK>
> >[  335.625734]  dump_stack_lvl+0x45/0x59
> >[  335.625981]  check_noncircular+0x23e/0x2e0
> >[  335.626268]  ? print_circular_bug+0x450/0x450
> >[  335.626583]  ? mark_lock+0xf1/0x30c0
> >[  335.626821]  ? alloc_chain_hlocks+0x1e6/0x590
> >[  335.627156]  __lock_acquire+0x29f8/0x5b80
> >[  335.627463]  ? lock_chain_count+0x20/0x20
> >[  335.627740]  ? lockdep_hardirqs_on_prepare+0x400/0x400
> >[  335.628161]  ? lockdep_hardirqs_on_prepare+0x400/0x400
> >[  335.628555]  lock_acquire+0x1a6/0x4b0
> >[  335.628799]  ? laundromat_main+0x177d/0x23b0 [nfsd]
> >[  335.629184]  ? lock_release+0x6d0/0x6d0
> >[  335.629449]  ? laundromat_main+0x29c/0x23b0 [nfsd]
> >[  335.629825]  ? do_raw_spin_lock+0x11e/0x240
> >[  335.630120]  ? rwlock_bug.part.0+0x90/0x90
> >[  335.630409]  _raw_spin_lock+0x2f/0x40
> >[  335.630654]  ? laundromat_main+0x177d/0x23b0 [nfsd]
> >[  335.631058]  laundromat_main+0x177d/0x23b0 [nfsd]
> >[  335.631450]  ? lock_release+0x6d0/0x6d0
> >[  335.631712]  ? client_ctl_write+0x9f0/0x9f0 [nfsd]
> >[  335.632110]  process_one_work+0x7ec/0x1320
> >[  335.632411]  ? lock_release+0x6d0/0x6d0
> >[  335.632672]  ? pwq_dec_nr_in_flight+0x230/0x230
> >[  335.633002]  ? rwlock_bug.part.0+0x90/0x90
> >[  335.633290]  worker_thread+0x59e/0xf90
> >[  335.633548]  ? process_one_work+0x1320/0x1320
> >[  335.633860]  kthread+0x3b1/0x490
> >[  335.634082]  ? _raw_spin_unlock_irq+0x24/0x50
> >[  335.634396]  ? set_kthread_struct+0x100/0x100
> >[  335.634709]  ret_from_fork+0x22/0x30
> >[  335.634961]  </TASK>
> >[  751.568771] nfsd (4021) used greatest stack depth: 21792 bytes left
> >[  751.769042] nfsd: last server has exited, flushing export cache
> >[  751.957555] NFSD: Using nfsdcld client tracking operations.
> >[  751.958050] NFSD: starting 15-second grace period (net f0000098)
> >[  773.101065] nfsd: last server has exited, flushing export cache
> >[  773.341554] NFSD: Using nfsdcld client tracking operations.
> >[  773.342404] NFSD: starting 15-second grace period (net f0000098)
> >[  795.757041] nfsd: last server has exited, flushing export cache
> >[  795.881057] NFSD: Using nfsdcld client tracking operations.
> >[  795.881637] NFSD: starting 15-second grace period (net f0000098)
> >[  816.968871] nfsd: last server has exited, flushing export cache
> >[  817.199987] NFSD: Using nfsdcld client tracking operations.
> >[  817.201123] NFSD: starting 15-second grace period (net f0000098)
> >[  817.696746] nfsd: last server has exited, flushing export cache
> >[  817.925616] NFSD: Using nfsdcld client tracking operations.
> >[  817.926073] NFSD: starting 15-second grace period (net f0000098)
> >[  839.080820] nfsd: last server has exited, flushing export cache
> >[  839.321569] NFSD: Using nfsdcld client tracking operations.
> >[  839.322562] NFSD: starting 15-second grace period (net f0000098)
> >[  860.492782] nfsd: last server has exited, flushing export cache
> >[  860.749705] NFSD: Using nfsdcld client tracking operations.
> >[  860.751710] NFSD: starting 15-second grace period (net f0000098)
> >[  882.889711] nfsd: last server has exited, flushing export cache
> >[  883.125502] NFSD: Using nfsdcld client tracking operations.
> >[  883.126399] NFSD: starting 15-second grace period (net f0000098)
> >[  904.224662] nfsd: last server has exited, flushing export cache
> >[  904.342387] NFSD: Using nfsdcld client tracking operations.
> >[  904.342962] NFSD: starting 15-second grace period (net f0000098)
> >[  947.528620] nfsd: last server has exited, flushing export cache
> >[  947.763520] NFSD: Using nfsdcld client tracking operations.
> >[  947.764569] NFSD: starting 15-second grace period (net f0000098)
> >[ 1442.187410] nfsd: last server has exited, flushing export cache
> >[ 1442.430496] NFSD: Using nfsdcld client tracking operations.
> >[ 1442.430974] NFSD: starting 15-second grace period (net f0000098)
> >[ 1483.739309] nfsd: last server has exited, flushing export cache
> >[ 1483.864102] NFSD: Using nfsdcld client tracking operations.
> >[ 1483.864606] NFSD: starting 15-second grace period (net f0000098)
> >[ 1486.644498] NFSD: all clients done reclaiming, ending NFSv4 grace per=
iod (net f0000098)
> >[ 1490.023618] clocksource: timekeeping watchdog on CPU3: acpi_pm retrie=
d 2 times before success
> >[ 1508.807419] nfsd: last server has exited, flushing export cache
> >[ 1508.925396] NFSD: Using nfsdcld client tracking operations.
> >[ 1508.925905] NFSD: starting 15-second grace period (net f0000098)
> >[ 1509.412224] NFSD: all clients done reclaiming, ending NFSv4 grace per=
iod (net f0000098)
> >[ 1530.667340] nfsd: last server has exited, flushing export cache
> >[ 1530.803387] NFSD: Using nfsdcld client tracking operations.
> >[ 1530.804150] NFSD: starting 15-second grace period (net f0000098)
> >[ 1531.185069] NFSD: all clients done reclaiming, ending NFSv4 grace per=
iod (net f0000098)
> >[ 1552.563368] nfsd: last server has exited, flushing export cache
> >[ 1552.794957] NFSD: Using nfsdcld client tracking operations.
> >[ 1552.797092] NFSD: starting 15-second grace period (net f0000098)
> >[ 1573.931430] NFSD: all clients done reclaiming, ending NFSv4 grace per=
iod (net f0000098)
> >[ 1594.943247] nfsd: last server has exited, flushing export cache
> >[ 1595.175609] NFSD: Using nfsdcld client tracking operations.
> >[ 1595.177610] NFSD: starting 15-second grace period (net f0000098)
> >[ 1595.277962] NFSD: all clients done reclaiming, ending NFSv4 grace per=
iod (net f0000098)
> >[ 1618.323178] nfsd: last server has exited, flushing export cache
> >[ 1618.553210] NFSD: Using nfsdcld client tracking operations.
> >[ 1618.555049] NFSD: starting 15-second grace period (net f0000098)
> >[ 1620.455011] nfsd: last server has exited, flushing export cache
> >[ 1620.687824] NFSD: Using nfsdcld client tracking operations.
> >[ 1620.688329] NFSD: starting 15-second grace period (net f0000098)
> >[ 1660.003178] nfsd: last server has exited, flushing export cache
> >[ 1660.236374] NFSD: Using nfsdcld client tracking operations.
> >[ 1660.237760] NFSD: starting 15-second grace period (net f0000098)
> >[ 1660.842977] nfsd: last server has exited, flushing export cache
> >[ 1661.061619] NFSD: Using nfsdcld client tracking operations.
> >[ 1661.062070] NFSD: starting 15-second grace period (net f0000098)
> >[ 1661.440842] NFSD: all clients done reclaiming, ending NFSv4 grace per=
iod (net f0000098)
> >[ 2704.041055] clocksource: timekeeping watchdog on CPU3: acpi_pm retrie=
d 2 times before success
> >[ 2712.517015] clocksource: timekeeping watchdog on CPU0: acpi_pm retrie=
d 2 times before success
> >[ 6066.999200] clocksource: timekeeping watchdog on CPU1: acpi_pm retrie=
d 2 times before success
> >
> >
> >I will update the
> >>Documentation/filesystems/locking.rst in v10.
> >>
> >>>I agree with Chuck that we don't need to reschedule the laundromat, it=
's
> >>>OK if it takes longer to get around to cleaning up a dead client.
> >>Yes, it is now implemented for lock conflict and share reservation
> >>resolution. I'm doing the same for delegation conflict.
> >>
> >>-Dai
> >>
> >>>--b.
> >>>
> >>>On Mon, Jan 10, 2022 at 10:50:51AM -0800, Dai Ngo wrote:
> >>>>Hi Bruce, Chuck
> >>>>
> >>>>This series of patches implement the NFSv4 Courteous Server.
> >>>>
> >>>>A server which does not immediately expunge the state on lease expira=
tion
> >>>>is known as a Courteous Server.  A Courteous Server continues to reco=
gnize
> >>>>previously generated state tokens as valid until conflict arises betw=
een
> >>>>the expired state and the requests from another client, or the server
> >>>>reboots.
> >>>>
> >>>>The v2 patch includes the following:
> >>>>
> >>>>. add new callback, lm_expire_lock, to lock_manager_operations to
> >>>>   allow the lock manager to take appropriate action with conflict lo=
ck.
> >>>>
> >>>>. handle conflicts of NFSv4 locks with NFSv3/NLM and local locks.
> >>>>
> >>>>. expire courtesy client after 24hr if client has not reconnected.
> >>>>
> >>>>. do not allow expired client to become courtesy client if there are
> >>>>   waiters for client's locks.
> >>>>
> >>>>. modify client_info_show to show courtesy client and seconds from
> >>>>   last renew.
> >>>>
> >>>>. fix a problem with NFSv4.1 server where the it keeps returning
> >>>>   SEQ4_STATUS_CB_PATH_DOWN in the successful SEQUENCE reply, after
> >>>>   the courtesy client re-connects, causing the client to keep sending
> >>>>   BCTS requests to server.
> >>>>
> >>>>The v3 patch includes the following:
> >>>>
> >>>>. modified posix_test_lock to check and resolve conflict locks
> >>>>   to handle NLM TEST and NFSv4 LOCKT requests.
> >>>>
> >>>>. separate out fix for back channel stuck in SEQ4_STATUS_CB_PATH_DOWN.
> >>>>
> >>>>The v4 patch includes:
> >>>>
> >>>>. rework nfsd_check_courtesy to avoid dead lock of fl_lock and client=
_lock
> >>>>   by asking the laudromat thread to destroy the courtesy client.
> >>>>
> >>>>. handle NFSv4 share reservation conflicts with courtesy client. This
> >>>>   includes conflicts between access mode and deny mode and vice vers=
a.
> >>>>
> >>>>. drop the patch for back channel stuck in SEQ4_STATUS_CB_PATH_DOWN.
> >>>>
> >>>>The v5 patch includes:
> >>>>
> >>>>. fix recursive locking of file_rwsem from posix_lock_file.
> >>>>
> >>>>. retest with LOCKDEP enabled.
> >>>>
> >>>>The v6 patch includes:
> >>>>
> >>>>. merge witn 5.15-rc7
> >>>>
> >>>>. fix a bug in nfs4_check_deny_bmap that did not check for matched
> >>>>   nfs4_file before checking for access/deny conflict. This bug causes
> >>>>   pynfs OPEN18 to fail since the server taking too long to release
> >>>>   lots of un-conflict clients' state.
> >>>>
> >>>>. enhance share reservation conflict handler to handle case where
> >>>>   a large number of conflict courtesy clients need to be expired.
> >>>>   The 1st 100 clients are expired synchronously and the rest are
> >>>>   expired in the background by the laundromat and NFS4ERR_DELAY
> >>>>   is returned to the NFS client. This is needed to prevent the
> >>>>   NFS client from timing out waiting got the reply.
> >>>>
> >>>>The v7 patch includes:
> >>>>
> >>>>. Fix race condition in posix_test_lock and posix_lock_inode after
> >>>>   dropping spinlock.
> >>>>
> >>>>. Enhance nfsd4_fl_expire_lock to work with with new lm_expire_lock
> >>>>   callback
> >>>>
> >>>>. Always resolve share reservation conflicts asynchrously.
> >>>>
> >>>>. Fix bug in nfs4_laundromat where spinlock is not used when
> >>>>   scanning cl_ownerstr_hashtbl.
> >>>>
> >>>>. Fix bug in nfs4_laundromat where idr_get_next was called
> >>>>   with incorrect 'id'.
> >>>>
> >>>>. Merge nfs4_destroy_courtesy_client into nfsd4_fl_expire_lock.
> >>>>
> >>>>The v8 patch includes:
> >>>>
> >>>>. Fix warning in nfsd4_fl_expire_lock reported by test robot.
> >>>>
> >>>>The V9 patch include:
> >>>>
> >>>>. Simplify lm_expire_lock API by (1) remove the 'testonly' flag
> >>>>   and (2) specifying return value as true/false to indicate
> >>>>   whether conflict was succesfully resolved.
> >>>>
> >>>>. Rework nfsd4_fl_expire_lock to mark client with
> >>>>   NFSD4_DESTROY_COURTESY_CLIENT then tell the laundromat to expire
> >>>>   the client in the background.
> >>>>
> >>>>. Add a spinlock in nfs4_client to synchronize access to the
> >>>>   NFSD4_COURTESY_CLIENT and NFSD4_DESTROY_COURTESY_CLIENT flag to
> >>>>   handle race conditions when resolving lock and share reservation
> >>>>   conflict.
> >>>>
> >>>>. Courtesy client that was marked as NFSD4_DESTROY_COURTESY_CLIENT
> >>>>   are now consisdered 'dead', waiting for the laundromat to expire
> >>>>   it. This client is no longer allowed to use its states if it
> >>>>   re-connects before the laundromat finishes expiring the client.
> >>>>
> >>>>   For v4.1 client, the detection is done in the processing of the
> >>>>   SEQUENCE op and returns NFS4ERR_BAD_SESSION to force the client
> >>>>   to re-establish new clientid and session.
> >>>>   For v4.0 client, the detection is done in the processing of the
> >>>>   RENEW and state-related ops and return NFS4ERR_EXPIRE to force
> >>>>   the client to re-establish new clientid.
