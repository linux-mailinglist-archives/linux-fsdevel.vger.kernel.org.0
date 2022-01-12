Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5544B48CD28
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Jan 2022 21:40:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357678AbiALUkD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Jan 2022 15:40:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357670AbiALUkB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Jan 2022 15:40:01 -0500
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0232EC06173F;
        Wed, 12 Jan 2022 12:39:53 -0800 (PST)
Received: by fieldses.org (Postfix, from userid 2815)
        id 4BFA66A5F; Wed, 12 Jan 2022 15:39:53 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 4BFA66A5F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1642019993;
        bh=fQNBe7mukPaj6TG6m13NpG9O+wufMciUzA3ztgr23cw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZhZxjnvL8Vo+qY4Zm1cFtpE3ht0M6GVJ85JfT2vS7b/NmHC/r4SHvXA+plL/Z2eji
         K+YPqkw8toQdRpxBZbgtDASmU+7q6Pok95ZOvB7Of+e1b83wiOoMMTQlJZ8RabE5eW
         vnp36VPvcSqL47cZUSqaJyVPpscwEnQf59/xGNbM=
Date:   Wed, 12 Jan 2022 15:39:53 -0500
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     dai.ngo@oracle.com
Cc:     chuck.lever@oracle.com, jlayton@redhat.com,
        viro@zeniv.linux.org.uk, linux-nfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH RFC v9 0/2] nfsd: Initial implementation of NFSv4
 Courteous Server
Message-ID: <20220112203953.GG10518@fieldses.org>
References: <1641840653-23059-1-git-send-email-dai.ngo@oracle.com>
 <20220112185912.GB10518@fieldses.org>
 <ad62d8d1-f566-ab6f-8c74-38ba2d053d89@oracle.com>
 <20220112192111.GC10518@fieldses.org>
 <eb3dc795-092c-8624-8e11-bfe8758b812c@oracle.com>
 <20220112194204.GE10518@fieldses.org>
 <ce66ae74-6fdb-dd82-5fc4-345b2f7fe282@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <ce66ae74-6fdb-dd82-5fc4-345b2f7fe282@oracle.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jan 12, 2022 at 12:34:53PM -0800, dai.ngo@oracle.com wrote:
>=20
> On 1/12/22 11:42 AM, J. Bruce Fields wrote:
> >On Wed, Jan 12, 2022 at 11:31:55AM -0800, dai.ngo@oracle.com wrote:
> >>On 1/12/22 11:21 AM, J. Bruce Fields wrote:
> >>>On Wed, Jan 12, 2022 at 11:05:03AM -0800, dai.ngo@oracle.com wrote:
> >>>>On 1/12/22 10:59 AM, J. Bruce Fields wrote:
> >>>>>Could you look back over previous comments?  I notice there's a coup=
le
> >>>>>unaddressed (circular locking dependency, Documentation/filesystems/=
).
> >>>>I think v9 addresses the circular locking dependency.
> >>>The below is on 5.16 + these two v9 patches.
> >>>
> >>>--b.
> >>>
> >>>[  335.595143] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >>>[  335.596176] WARNING: possible circular locking dependency detected
> >>>[  335.597128] 5.16.0-00002-g616758bf6583 #1278 Not tainted
> >>>[  335.597903] ------------------------------------------------------
> >>>[  335.598845] kworker/u8:0/7 is trying to acquire lock:
> >>>[  335.599582] ffff888010393b60 (&clp->cl_lock){+.+.}-{2:2}, at: laund=
romat_main+0x177d/0x23b0 [nfsd]
> >>>[  335.601111]
> >>>                but task is already holding lock:
> >>>[  335.601750] ffff888010393e18 (&clp->cl_cs_lock){+.+.}-{2:2}, at: la=
undromat_main+0x33e/0x23b0 [nfsd]
> >>This is the new spinlock that I added. It's weird that I don't see it
> >>my messages log, I will check.
> >Not especially weird, we probably have different config options and run
> >different tests.
> >
> >You'll need to just inspect the code and figure ou why these locks are
> >being taken in different orders.
>=20
> I will inspect the code paths but it helps to reproduce this warning
> messages to ensure the problem is really fixed.
>=20
> I have these in my .config:
>=20
> CONFIG_LOCKDEP_SUPPORT=3Dy
> CONFIG_LOCKDEP=3Dy
> CONFIG_LOCKDEP_BITS=3D15
> CONFIG_LOCKDEP_CHAINS_BITS=3D16
> CONFIG_LOCKDEP_STACK_TRACE_BITS=3D19
> CONFIG_LOCKDEP_STACK_TRACE_HASH_BITS=3D14
> CONFIG_LOCKDEP_CIRCULAR_QUEUE_BITS=3D12
> # CONFIG_DEBUG_LOCKDEP is not set
>=20
> I ran pynfs and did not see the messages.  What tests did you run
> to get these messages?

Sorry, I'm not sure which tests were running at the time.  I'll let you
know if I manage to narrow it down.  For now, I really think the lockdep
output should be enough to figure out what's going on.

--b.

>=20
> Thanks,
> -Dai
>=20
> >
> >--b.
> >
> >>Thanks,
> >>-Dai
> >>
> >>>[  335.602896]
> >>>                which lock already depends on the new lock.
> >>>
> >>>[  335.603378]
> >>>                the existing dependency chain (in reverse order) is:
> >>>[  335.603897]
> >>>                -> #2 (&clp->cl_cs_lock){+.+.}-{2:2}:
> >>>[  335.604305]        _raw_spin_lock+0x2f/0x40
> >>>[  335.604622]        nfsd4_fl_expire_lock+0x7a/0x330 [nfsd]
> >>>[  335.605078]        posix_lock_inode+0x9b8/0x1a50
> >>>[  335.605442]        nfsd4_lock+0xe33/0x3d20 [nfsd]
> >>>[  335.605827]        nfsd4_proc_compound+0xcef/0x21e0 [nfsd]
> >>>[  335.606289]        nfsd_dispatch+0x4b8/0xbd0 [nfsd]
> >>>[  335.606692]        svc_process_common+0xd56/0x1ac0 [sunrpc]
> >>>[  335.607188]        svc_process+0x32e/0x4a0 [sunrpc]
> >>>[  335.607604]        nfsd+0x306/0x530 [nfsd]
> >>>[  335.607923]        kthread+0x3b1/0x490
> >>>[  335.608199]        ret_from_fork+0x22/0x30
> >>>[  335.608512]
> >>>                -> #1 (&ctx->flc_lock){+.+.}-{2:2}:
> >>>[  335.608878]        _raw_spin_lock+0x2f/0x40
> >>>[  335.609187]        check_for_locks+0xcf/0x200 [nfsd]
> >>>[  335.609602]        nfsd4_release_lockowner+0x583/0xa20 [nfsd]
> >>>[  335.610093]        nfsd4_proc_compound+0xcef/0x21e0 [nfsd]
> >>>[  335.610564]        nfsd_dispatch+0x4b8/0xbd0 [nfsd]
> >>>[  335.610963]        svc_process_common+0xd56/0x1ac0 [sunrpc]
> >>>[  335.611450]        svc_process+0x32e/0x4a0 [sunrpc]
> >>>[  335.611863]        nfsd+0x306/0x530 [nfsd]
> >>>[  335.612193]        kthread+0x3b1/0x490
> >>>[  335.612463]        ret_from_fork+0x22/0x30
> >>>[  335.612764]
> >>>                -> #0 (&clp->cl_lock){+.+.}-{2:2}:
> >>>[  335.613120]        __lock_acquire+0x29f8/0x5b80
> >>>[  335.613469]        lock_acquire+0x1a6/0x4b0
> >>>[  335.613763]        _raw_spin_lock+0x2f/0x40
> >>>[  335.614057]        laundromat_main+0x177d/0x23b0 [nfsd]
> >>>[  335.614477]        process_one_work+0x7ec/0x1320
> >>>[  335.614813]        worker_thread+0x59e/0xf90
> >>>[  335.615135]        kthread+0x3b1/0x490
> >>>[  335.615409]        ret_from_fork+0x22/0x30
> >>>[  335.615695]
> >>>                other info that might help us debug this:
> >>>
> >>>[  335.616135] Chain exists of:
> >>>                  &clp->cl_lock --> &ctx->flc_lock --> &clp->cl_cs_lock
> >>>
> >>>[  335.616806]  Possible unsafe locking scenario:
> >>>
> >>>[  335.617140]        CPU0                    CPU1
> >>>[  335.617467]        ----                    ----
> >>>[  335.617793]   lock(&clp->cl_cs_lock);
> >>>[  335.618036]                                lock(&ctx->flc_lock);
> >>>[  335.618531]                                lock(&clp->cl_cs_lock);
> >>>[  335.619037]   lock(&clp->cl_lock);
> >>>[  335.619256]
> >>>                 *** DEADLOCK ***
> >>>
> >>>[  335.619487] 4 locks held by kworker/u8:0/7:
> >>>[  335.619780]  #0: ffff88800ca5b138 ((wq_completion)nfsd4){+.+.}-{0:0=
}, at: process_one_work+0x6f5/0x1320
> >>>[  335.620619]  #1: ffff88800776fdd8 ((work_completion)(&(&nn->laundro=
mat_work)->work)){+.+.}-{0:0}, at: process_one_work+0x723/0x1320
> >>>[  335.621657]  #2: ffff888008a4c190 (&nn->client_lock){+.+.}-{2:2}, a=
t: laundromat_main+0x2b4/0x23b0 [nfsd]
> >>>[  335.622499]  #3: ffff888010393e18 (&clp->cl_cs_lock){+.+.}-{2:2}, a=
t: laundromat_main+0x33e/0x23b0 [nfsd]
> >>>[  335.623462]
> >>>                stack backtrace:
> >>>[  335.623648] CPU: 2 PID: 7 Comm: kworker/u8:0 Not tainted 5.16.0-000=
02-g616758bf6583 #1278
> >>>[  335.624364] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), =
BIOS 1.14.0-6.fc35 04/01/2014
> >>>[  335.625124] Workqueue: nfsd4 laundromat_main [nfsd]
> >>>[  335.625514] Call Trace:
> >>>[  335.625641]  <TASK>
> >>>[  335.625734]  dump_stack_lvl+0x45/0x59
> >>>[  335.625981]  check_noncircular+0x23e/0x2e0
> >>>[  335.626268]  ? print_circular_bug+0x450/0x450
> >>>[  335.626583]  ? mark_lock+0xf1/0x30c0
> >>>[  335.626821]  ? alloc_chain_hlocks+0x1e6/0x590
> >>>[  335.627156]  __lock_acquire+0x29f8/0x5b80
> >>>[  335.627463]  ? lock_chain_count+0x20/0x20
> >>>[  335.627740]  ? lockdep_hardirqs_on_prepare+0x400/0x400
> >>>[  335.628161]  ? lockdep_hardirqs_on_prepare+0x400/0x400
> >>>[  335.628555]  lock_acquire+0x1a6/0x4b0
> >>>[  335.628799]  ? laundromat_main+0x177d/0x23b0 [nfsd]
> >>>[  335.629184]  ? lock_release+0x6d0/0x6d0
> >>>[  335.629449]  ? laundromat_main+0x29c/0x23b0 [nfsd]
> >>>[  335.629825]  ? do_raw_spin_lock+0x11e/0x240
> >>>[  335.630120]  ? rwlock_bug.part.0+0x90/0x90
> >>>[  335.630409]  _raw_spin_lock+0x2f/0x40
> >>>[  335.630654]  ? laundromat_main+0x177d/0x23b0 [nfsd]
> >>>[  335.631058]  laundromat_main+0x177d/0x23b0 [nfsd]
> >>>[  335.631450]  ? lock_release+0x6d0/0x6d0
> >>>[  335.631712]  ? client_ctl_write+0x9f0/0x9f0 [nfsd]
> >>>[  335.632110]  process_one_work+0x7ec/0x1320
> >>>[  335.632411]  ? lock_release+0x6d0/0x6d0
> >>>[  335.632672]  ? pwq_dec_nr_in_flight+0x230/0x230
> >>>[  335.633002]  ? rwlock_bug.part.0+0x90/0x90
> >>>[  335.633290]  worker_thread+0x59e/0xf90
> >>>[  335.633548]  ? process_one_work+0x1320/0x1320
> >>>[  335.633860]  kthread+0x3b1/0x490
> >>>[  335.634082]  ? _raw_spin_unlock_irq+0x24/0x50
> >>>[  335.634396]  ? set_kthread_struct+0x100/0x100
> >>>[  335.634709]  ret_from_fork+0x22/0x30
> >>>[  335.634961]  </TASK>
> >>>[  751.568771] nfsd (4021) used greatest stack depth: 21792 bytes left
> >>>[  751.769042] nfsd: last server has exited, flushing export cache
> >>>[  751.957555] NFSD: Using nfsdcld client tracking operations.
> >>>[  751.958050] NFSD: starting 15-second grace period (net f0000098)
> >>>[  773.101065] nfsd: last server has exited, flushing export cache
> >>>[  773.341554] NFSD: Using nfsdcld client tracking operations.
> >>>[  773.342404] NFSD: starting 15-second grace period (net f0000098)
> >>>[  795.757041] nfsd: last server has exited, flushing export cache
> >>>[  795.881057] NFSD: Using nfsdcld client tracking operations.
> >>>[  795.881637] NFSD: starting 15-second grace period (net f0000098)
> >>>[  816.968871] nfsd: last server has exited, flushing export cache
> >>>[  817.199987] NFSD: Using nfsdcld client tracking operations.
> >>>[  817.201123] NFSD: starting 15-second grace period (net f0000098)
> >>>[  817.696746] nfsd: last server has exited, flushing export cache
> >>>[  817.925616] NFSD: Using nfsdcld client tracking operations.
> >>>[  817.926073] NFSD: starting 15-second grace period (net f0000098)
> >>>[  839.080820] nfsd: last server has exited, flushing export cache
> >>>[  839.321569] NFSD: Using nfsdcld client tracking operations.
> >>>[  839.322562] NFSD: starting 15-second grace period (net f0000098)
> >>>[  860.492782] nfsd: last server has exited, flushing export cache
> >>>[  860.749705] NFSD: Using nfsdcld client tracking operations.
> >>>[  860.751710] NFSD: starting 15-second grace period (net f0000098)
> >>>[  882.889711] nfsd: last server has exited, flushing export cache
> >>>[  883.125502] NFSD: Using nfsdcld client tracking operations.
> >>>[  883.126399] NFSD: starting 15-second grace period (net f0000098)
> >>>[  904.224662] nfsd: last server has exited, flushing export cache
> >>>[  904.342387] NFSD: Using nfsdcld client tracking operations.
> >>>[  904.342962] NFSD: starting 15-second grace period (net f0000098)
> >>>[  947.528620] nfsd: last server has exited, flushing export cache
> >>>[  947.763520] NFSD: Using nfsdcld client tracking operations.
> >>>[  947.764569] NFSD: starting 15-second grace period (net f0000098)
> >>>[ 1442.187410] nfsd: last server has exited, flushing export cache
> >>>[ 1442.430496] NFSD: Using nfsdcld client tracking operations.
> >>>[ 1442.430974] NFSD: starting 15-second grace period (net f0000098)
> >>>[ 1483.739309] nfsd: last server has exited, flushing export cache
> >>>[ 1483.864102] NFSD: Using nfsdcld client tracking operations.
> >>>[ 1483.864606] NFSD: starting 15-second grace period (net f0000098)
> >>>[ 1486.644498] NFSD: all clients done reclaiming, ending NFSv4 grace p=
eriod (net f0000098)
> >>>[ 1490.023618] clocksource: timekeeping watchdog on CPU3: acpi_pm retr=
ied 2 times before success
> >>>[ 1508.807419] nfsd: last server has exited, flushing export cache
> >>>[ 1508.925396] NFSD: Using nfsdcld client tracking operations.
> >>>[ 1508.925905] NFSD: starting 15-second grace period (net f0000098)
> >>>[ 1509.412224] NFSD: all clients done reclaiming, ending NFSv4 grace p=
eriod (net f0000098)
> >>>[ 1530.667340] nfsd: last server has exited, flushing export cache
> >>>[ 1530.803387] NFSD: Using nfsdcld client tracking operations.
> >>>[ 1530.804150] NFSD: starting 15-second grace period (net f0000098)
> >>>[ 1531.185069] NFSD: all clients done reclaiming, ending NFSv4 grace p=
eriod (net f0000098)
> >>>[ 1552.563368] nfsd: last server has exited, flushing export cache
> >>>[ 1552.794957] NFSD: Using nfsdcld client tracking operations.
> >>>[ 1552.797092] NFSD: starting 15-second grace period (net f0000098)
> >>>[ 1573.931430] NFSD: all clients done reclaiming, ending NFSv4 grace p=
eriod (net f0000098)
> >>>[ 1594.943247] nfsd: last server has exited, flushing export cache
> >>>[ 1595.175609] NFSD: Using nfsdcld client tracking operations.
> >>>[ 1595.177610] NFSD: starting 15-second grace period (net f0000098)
> >>>[ 1595.277962] NFSD: all clients done reclaiming, ending NFSv4 grace p=
eriod (net f0000098)
> >>>[ 1618.323178] nfsd: last server has exited, flushing export cache
> >>>[ 1618.553210] NFSD: Using nfsdcld client tracking operations.
> >>>[ 1618.555049] NFSD: starting 15-second grace period (net f0000098)
> >>>[ 1620.455011] nfsd: last server has exited, flushing export cache
> >>>[ 1620.687824] NFSD: Using nfsdcld client tracking operations.
> >>>[ 1620.688329] NFSD: starting 15-second grace period (net f0000098)
> >>>[ 1660.003178] nfsd: last server has exited, flushing export cache
> >>>[ 1660.236374] NFSD: Using nfsdcld client tracking operations.
> >>>[ 1660.237760] NFSD: starting 15-second grace period (net f0000098)
> >>>[ 1660.842977] nfsd: last server has exited, flushing export cache
> >>>[ 1661.061619] NFSD: Using nfsdcld client tracking operations.
> >>>[ 1661.062070] NFSD: starting 15-second grace period (net f0000098)
> >>>[ 1661.440842] NFSD: all clients done reclaiming, ending NFSv4 grace p=
eriod (net f0000098)
> >>>[ 2704.041055] clocksource: timekeeping watchdog on CPU3: acpi_pm retr=
ied 2 times before success
> >>>[ 2712.517015] clocksource: timekeeping watchdog on CPU0: acpi_pm retr=
ied 2 times before success
> >>>[ 6066.999200] clocksource: timekeeping watchdog on CPU1: acpi_pm retr=
ied 2 times before success
> >>>
> >>>started Wed Jan 12 11:28:28 AM EST 2022, finished Wed Jan 12 01:47:36 =
PM EST 2022
> >>>
> >>>
> >>>+-----------------------------------------+
> >>>|            verbose output               |
> >>>+-----------------------------------------+
> >>>fs/select.c: In function =E2=80=98do_select=E2=80=99:
> >>>fs/select.c:611:1: warning: the frame size of 1120 bytes is larger tha=
n 1024 bytes [-Wframe-larger-than=3D]
> >>>   611 | }
> >>>       | ^
> >>>fs/select.c: In function =E2=80=98do_sys_poll=E2=80=99:
> >>>fs/select.c:1041:1: warning: the frame size of 1296 bytes is larger th=
an 1024 bytes [-Wframe-larger-than=3D]
> >>>  1041 | }
> >>>       | ^
> >>>net/core/rtnetlink.c: In function =E2=80=98__rtnl_newlink=E2=80=99:
> >>>net/core/rtnetlink.c:3494:1: warning: the frame size of 1368 bytes is =
larger than 1024 bytes [-Wframe-larger-than=3D]
> >>>  3494 | }
> >>>       | ^
> >>>drivers/tty/serial/8250/8250_core.c: In function =E2=80=98serial8250_p=
robe=E2=80=99:
> >>>drivers/tty/serial/8250/8250_core.c:840:1: warning: the frame size of =
1152 bytes is larger than 1024 bytes [-Wframe-larger-than=3D]
> >>>   840 | }
> >>>       | ^
> >>>drivers/tty/serial/8250/8250_pnp.c: In function =E2=80=98serial_pnp_pr=
obe=E2=80=99:
> >>>drivers/tty/serial/8250/8250_pnp.c:488:1: warning: the frame size of 1=
136 bytes is larger than 1024 bytes [-Wframe-larger-than=3D]
> >>>   488 | }
> >>>       | ^
> >>>drivers/tty/serial/8250/8250_pci.c: In function =E2=80=98pciserial_ini=
t_ports=E2=80=99:
> >>>drivers/tty/serial/8250/8250_pci.c:4030:1: warning: the frame size of =
1160 bytes is larger than 1024 bytes [-Wframe-larger-than=3D]
> >>>  4030 | }
> >>>       | ^
> >>>drivers/tty/serial/8250/8250_exar.c: In function =E2=80=98exar_pci_pro=
be=E2=80=99:
> >>>drivers/tty/serial/8250/8250_exar.c:678:1: warning: the frame size of =
1176 bytes is larger than 1024 bytes [-Wframe-larger-than=3D]
> >>>   678 | }
> >>>       | ^
> >>>drivers/tty/serial/8250/8250_lpss.c: In function =E2=80=98lpss8250_pro=
be.part.0=E2=80=99:
> >>>drivers/tty/serial/8250/8250_lpss.c:351:1: warning: the frame size of =
1152 bytes is larger than 1024 bytes [-Wframe-larger-than=3D]
> >>>   351 | }
> >>>       | ^
> >>>drivers/tty/serial/8250/8250_mid.c: In function =E2=80=98mid8250_probe=
=2Epart.0=E2=80=99:
> >>>drivers/tty/serial/8250/8250_mid.c:337:1: warning: the frame size of 1=
144 bytes is larger than 1024 bytes [-Wframe-larger-than=3D]
> >>>   337 | }
> >>>       | ^
> >>>lib/zstd/common/entropy_common.c: In function =E2=80=98HUF_readStats=
=E2=80=99:
> >>>lib/zstd/common/entropy_common.c:257:1: warning: the frame size of 105=
6 bytes is larger than 1024 bytes [-Wframe-larger-than=3D]
> >>>   257 | }
> >>>       | ^
> >>>drivers/acpi/processor_thermal.c: In function =E2=80=98cpu_has_cpufreq=
=E2=80=99:
> >>>drivers/acpi/processor_thermal.c:60:1: warning: the frame size of 1384=
 bytes is larger than 1024 bytes [-Wframe-larger-than=3D]
> >>>    60 | }
> >>>       | ^
> >>>drivers/dma-buf/dma-resv.c: In function =E2=80=98dma_resv_lockdep=E2=
=80=99:
> >>>drivers/dma-buf/dma-resv.c:708:1: warning: the frame size of 1192 byte=
s is larger than 1024 bytes [-Wframe-larger-than=3D]
> >>>   708 | }
> >>>       | ^
> >>>fs/lockd/svcsubs.c: In function =E2=80=98nlmsvc_mark_resources=E2=80=
=99:
> >>>fs/lockd/svcsubs.c:418:1: warning: the frame size of 1152 bytes is lar=
ger than 1024 bytes [-Wframe-larger-than=3D]
> >>>   418 | }
> >>>       | ^
> >>>drivers/md/raid5-ppl.c: In function =E2=80=98ppl_recover_entry=E2=80=
=99:
> >>>drivers/md/raid5-ppl.c:968:1: warning: the frame size of 1200 bytes is=
 larger than 1024 bytes [-Wframe-larger-than=3D]
> >>>   968 | }
> >>>       | ^
> >>>fs/ocfs2/namei.c: In function =E2=80=98ocfs2_rename=E2=80=99:
> >>>fs/ocfs2/namei.c:1686:1: warning: the frame size of 1064 bytes is larg=
er than 1024 bytes [-Wframe-larger-than=3D]
> >>>  1686 | }
> >>>       | ^
> >>>net/sunrpc/auth_gss/gss_krb5_crypto.c: In function =E2=80=98gss_krb5_a=
es_encrypt=E2=80=99:
> >>>net/sunrpc/auth_gss/gss_krb5_crypto.c:717:1: warning: the frame size o=
f 1120 bytes is larger than 1024 bytes [-Wframe-larger-than=3D]
> >>>   717 | }
> >>>       | ^
> >>>net/sunrpc/auth_gss/gss_krb5_crypto.c: In function =E2=80=98gss_krb5_a=
es_decrypt=E2=80=99:
> >>>net/sunrpc/auth_gss/gss_krb5_crypto.c:810:1: warning: the frame size o=
f 1168 bytes is larger than 1024 bytes [-Wframe-larger-than=3D]
> >>>   810 | }
> >>>       | ^
> >>>drivers/infiniband/core/nldev.c: In function =E2=80=98nldev_set_doit=
=E2=80=99:
> >>>drivers/infiniband/core/nldev.c:1112:1: warning: the frame size of 106=
4 bytes is larger than 1024 bytes [-Wframe-larger-than=3D]
> >>>  1112 | }
> >>>       | ^
> >>>drivers/infiniband/core/nldev.c: In function =E2=80=98nldev_newlink=E2=
=80=99:
> >>>drivers/infiniband/core/nldev.c:1722:1: warning: the frame size of 112=
8 bytes is larger than 1024 bytes [-Wframe-larger-than=3D]
> >>>  1722 | }
> >>>       | ^
> >>>drivers/infiniband/core/nldev.c: In function =E2=80=98nldev_get_charde=
v=E2=80=99:
> >>>drivers/infiniband/core/nldev.c:1833:1: warning: the frame size of 114=
4 bytes is larger than 1024 bytes [-Wframe-larger-than=3D]
> >>>  1833 | }
> >>>       | ^
> >>>drivers/infiniband/core/nldev.c: In function =E2=80=98nldev_stat_set_d=
oit=E2=80=99:
> >>>drivers/infiniband/core/nldev.c:2061:1: warning: the frame size of 106=
4 bytes is larger than 1024 bytes [-Wframe-larger-than=3D]
> >>>  2061 | }
> >>>       | ^
> >>>drivers/infiniband/core/nldev.c: In function =E2=80=98res_get_common_d=
umpit=E2=80=99:
> >>>drivers/infiniband/core/nldev.c:1613:1: warning: the frame size of 109=
6 bytes is larger than 1024 bytes [-Wframe-larger-than=3D]
> >>>  1613 | }
> >>>       | ^
> >>>drivers/infiniband/core/nldev.c: In function =E2=80=98nldev_stat_get_d=
oit=E2=80=99:
> >>>drivers/infiniband/core/nldev.c:2318:1: warning: the frame size of 108=
8 bytes is larger than 1024 bytes [-Wframe-larger-than=3D]
> >>>  2318 | }
> >>>       | ^
> >>>drivers/infiniband/core/nldev.c: In function =E2=80=98nldev_stat_get_c=
ounter_status_doit=E2=80=99:
> >>>drivers/infiniband/core/nldev.c:2438:1: warning: the frame size of 109=
6 bytes is larger than 1024 bytes [-Wframe-larger-than=3D]
> >>>  2438 | }
> >>>       | ^
> >>>net/sunrpc/auth_gss/gss_krb5_crypto.c: In function =E2=80=98gss_krb5_a=
es_encrypt=E2=80=99:
> >>>net/sunrpc/auth_gss/gss_krb5_crypto.c:717:1: warning: the frame size o=
f 1120 bytes is larger than 1024 bytes [-Wframe-larger-than=3D]
> >>>   717 | }
> >>>       | ^
> >>>net/sunrpc/auth_gss/gss_krb5_crypto.c: In function =E2=80=98gss_krb5_a=
es_decrypt=E2=80=99:
> >>>net/sunrpc/auth_gss/gss_krb5_crypto.c:810:1: warning: the frame size o=
f 1168 bytes is larger than 1024 bytes [-Wframe-larger-than=3D]
> >>>   810 | }
> >>>       | ^
> >>>fs/lockd/svcsubs.c: In function =E2=80=98nlmsvc_mark_resources=E2=80=
=99:
> >>>fs/lockd/svcsubs.c:418:1: warning: the frame size of 1152 bytes is lar=
ger than 1024 bytes [-Wframe-larger-than=3D]
> >>>   418 | }
> >>>       | ^
> >>>make -f ./Makefile
> >>>   CALL    scripts/checksyscalls.sh
> >>>   CALL    scripts/atomic/check-atomics.sh
> >>>   DESCEND objtool
> >>>   CHK     include/generated/compile.h
> >>>   BUILD   arch/x86/boot/bzImage
> >>>Kernel: arch/x86/boot/bzImage is ready  (#1278)
> >>>sh ./scripts/package/buildtar targz-pkg
> >>>   INSTALL tar-install/lib/modules/5.16.0-00002-g616758bf6583/kernel/c=
rypto/authenc.ko
> >>>   INSTALL tar-install/lib/modules/5.16.0-00002-g616758bf6583/kernel/c=
rypto/authencesn.ko
> >>>   INSTALL tar-install/lib/modules/5.16.0-00002-g616758bf6583/kernel/c=
rypto/crypto_engine.ko
> >>>   INSTALL tar-install/lib/modules/5.16.0-00002-g616758bf6583/kernel/c=
rypto/echainiv.ko
> >>>   INSTALL tar-install/lib/modules/5.16.0-00002-g616758bf6583/kernel/d=
rivers/crypto/virtio/virtio_crypto.ko
> >>>   INSTALL tar-install/lib/modules/5.16.0-00002-g616758bf6583/kernel/d=
rivers/scsi/iscsi_tcp.ko
> >>>   INSTALL tar-install/lib/modules/5.16.0-00002-g616758bf6583/kernel/d=
rivers/scsi/libiscsi.ko
> >>>   INSTALL tar-install/lib/modules/5.16.0-00002-g616758bf6583/kernel/d=
rivers/scsi/libiscsi_tcp.ko
> >>>   INSTALL tar-install/lib/modules/5.16.0-00002-g616758bf6583/kernel/d=
rivers/scsi/scsi_transport_iscsi.ko
> >>>   INSTALL tar-install/lib/modules/5.16.0-00002-g616758bf6583/kernel/d=
rivers/thermal/intel/x86_pkg_temp_thermal.ko
> >>>   INSTALL tar-install/lib/modules/5.16.0-00002-g616758bf6583/kernel/f=
s/lockd/lockd.ko
> >>>   INSTALL tar-install/lib/modules/5.16.0-00002-g616758bf6583/kernel/f=
s/nfs/blocklayout/blocklayoutdriver.ko
> >>>   INSTALL tar-install/lib/modules/5.16.0-00002-g616758bf6583/kernel/f=
s/nfs/filelayout/nfs_layout_nfsv41_files.ko
> >>>   INSTALL tar-install/lib/modules/5.16.0-00002-g616758bf6583/kernel/f=
s/nfs/flexfilelayout/nfs_layout_flexfiles.ko
> >>>   INSTALL tar-install/lib/modules/5.16.0-00002-g616758bf6583/kernel/f=
s/nfs/nfs.ko
> >>>   INSTALL tar-install/lib/modules/5.16.0-00002-g616758bf6583/kernel/f=
s/nfs/nfsv2.ko
> >>>   INSTALL tar-install/lib/modules/5.16.0-00002-g616758bf6583/kernel/f=
s/nfs/nfsv3.ko
> >>>   INSTALL tar-install/lib/modules/5.16.0-00002-g616758bf6583/kernel/f=
s/nfs/nfsv4.ko
> >>>   INSTALL tar-install/lib/modules/5.16.0-00002-g616758bf6583/kernel/f=
s/nfs_common/grace.ko
> >>>   INSTALL tar-install/lib/modules/5.16.0-00002-g616758bf6583/kernel/f=
s/nfs_common/nfs_acl.ko
> >>>   INSTALL tar-install/lib/modules/5.16.0-00002-g616758bf6583/kernel/f=
s/nfsd/nfsd.ko
> >>>   INSTALL tar-install/lib/modules/5.16.0-00002-g616758bf6583/kernel/n=
et/sched/cls_bpf.ko
> >>>   INSTALL tar-install/lib/modules/5.16.0-00002-g616758bf6583/kernel/n=
et/sunrpc/auth_gss/auth_rpcgss.ko
> >>>   INSTALL tar-install/lib/modules/5.16.0-00002-g616758bf6583/kernel/n=
et/sunrpc/auth_gss/rpcsec_gss_krb5.ko
> >>>   INSTALL tar-install/lib/modules/5.16.0-00002-g616758bf6583/kernel/n=
et/sunrpc/sunrpc.ko
> >>>   INSTALL tar-install/lib/modules/5.16.0-00002-g616758bf6583/kernel/n=
et/sunrpc/xprtrdma/rpcrdma.ko
> >>>   DEPMOD  ./tar-install/lib/modules/5.16.0-00002-g616758bf6583
> >>>'./System.map' -> './tar-install/boot/System.map-5.16.0-00002-g616758b=
f6583'
> >>>'.config' -> './tar-install/boot/config-5.16.0-00002-g616758bf6583'
> >>>'./vmlinux' -> './tar-install/boot/vmlinux-5.16.0-00002-g616758bf6583'
> >>>'./arch/x86/boot/bzImage' -> './tar-install/boot/vmlinuz-5.16.0-00002-=
g616758bf6583'
> >>>Tarball successfully created in ./linux-5.16.0-00002-g616758bf6583-x86=
_64.tar.gz
> >>>user pynfs tests:
> >>>WARNING - could not create /b'exports/xfs/pynfstest-user/tree/block'
> >>>WARNING - could not create /b'exports/xfs/pynfstest-user/tree/char'
> >>>DELEG22  st_delegation.testServerSelfConflict2                    : RU=
NNING
> >>>DELEG22  st_delegation.testServerSelfConflict2                    : PA=
SS
> >>>DELEG21  st_delegation.testServerSelfConflict                     : RU=
NNING
> >>>DELEG21  st_delegation.testServerSelfConflict                     : PA=
SS
> >>>DELEG18  st_delegation.testServerRenameTarget                     : RU=
NNING
> >>>*****CB received COMPOUND******
> >>>******* CB_Recall (id=3D3)********
> >>>DELEG18  st_delegation.testServerRenameTarget                     : PA=
SS
> >>>DELEG17  st_delegation.testServerRenameSource                     : RU=
NNING
> >>>*****CB received COMPOUND******
> >>>******* CB_Recall (id=3D4)********
> >>>DELEG17  st_delegation.testServerRenameSource                     : PA=
SS
> >>>DELEG16  st_delegation.testServerRemove                           : RU=
NNING
> >>>*****CB received COMPOUND******
> >>>******* CB_Recall (id=3D5)********
> >>>DELEG16  st_delegation.testServerRemove                           : PA=
SS
> >>>DELEG19  st_delegation.testServerLink                             : RU=
NNING
> >>>*****CB received COMPOUND******
> >>>******* CB_Recall (id=3D6)********
> >>>DELEG19  st_delegation.testServerLink                             : PA=
SS
> >>>DELEG20  st_delegation.testServerChmod                            : RU=
NNING
> >>>*****CB received COMPOUND******
> >>>******* CB_Recall (id=3D7)********
> >>>DELEG20  st_delegation.testServerChmod                            : PA=
SS
> >>>DELEG6   st_delegation.testRenew                                  : RU=
NNING
> >>>Sleeping for 7.5 seconds: Waiting to send RENEW
> >>>Woke up
> >>>DELEG6   st_delegation.testRenew                                  : PA=
SS
> >>>DELEG15d st_delegation.testRenameOver                             : RU=
NNING
> >>>*****CB received COMPOUND******
> >>>******* CB_Recall (id=3D9)********
> >>>Sleeping for 1 seconds: Got NFS4ERR_DELAY on rename
> >>>Woke up
> >>>DELEG15d st_delegation.testRenameOver                             : PA=
SS
> >>>DELEG15c st_delegation.testRename                                 : RU=
NNING
> >>>*****CB received COMPOUND******
> >>>******* CB_Recall (id=3D10)********
> >>>Sleeping for 1 seconds: Got NFS4ERR_DELAY on rename
> >>>Woke up
> >>>DELEG15c st_delegation.testRename                                 : PA=
SS
> >>>DELEG15a st_delegation.testRemove                                 : RU=
NNING
> >>>Sleeping for 1 seconds: Got NFS4ERR_DELAY on remove
> >>>*****CB received COMPOUND******
> >>>******* CB_Recall (id=3D11)********
> >>>Woke up
> >>>DELEG15a st_delegation.testRemove                                 : PA=
SS
> >>>DELEG3e  st_delegation.testReadDeleg3e                            : RU=
NNING
> >>>Sleeping for 1 seconds: Got NFS4ERR_DELAY on open
> >>>*****CB received COMPOUND******
> >>>******* CB_Recall (id=3D12)********
> >>>Woke up
> >>>Sleeping for 1 seconds: Got NFS4ERR_DELAY on open
> >>>Woke up
> >>>Sleeping for 1 seconds: Got NFS4ERR_DELAY on open
> >>>Woke up
> >>>Sleeping for 1 seconds: Got NFS4ERR_DELAY on open
> >>>Woke up
> >>>Sleeping for 1 seconds: Got NFS4ERR_DELAY on open
> >>>Woke up
> >>>Sleeping for 1 seconds: Got NFS4ERR_DELAY on open
> >>>Woke up
> >>>Sleeping for 1 seconds: Got NFS4ERR_DELAY on open
> >>>Woke up
> >>>Sleeping for 1 seconds: Got NFS4ERR_DELAY on open
> >>>Woke up
> >>>Sleeping for 1 seconds: Got NFS4ERR_DELAY on open
> >>>Woke up
> >>>Sleeping for 1 seconds: Got NFS4ERR_DELAY on open
> >>>Woke up
> >>>Sleeping for 1 seconds: Got NFS4ERR_DELAY on open
> >>>Woke up
> >>>Sleeping for 1 seconds: Got NFS4ERR_DELAY on open
> >>>Woke up
> >>>Sleeping for 1 seconds: Got NFS4ERR_DELAY on open
> >>>Woke up
> >>>Sleeping for 1 seconds: Got NFS4ERR_DELAY on open
> >>>Woke up
> >>>Sleeping for 1 seconds: Got NFS4ERR_DELAY on open
> >>>Woke up
> >>>Sleeping for 1 seconds: Got NFS4ERR_DELAY on open
> >>>Woke up
> >>>DELEG3e  st_delegation.testReadDeleg3e                            : PA=
SS
> >>>DELEG3d  st_delegation.testReadDeleg3d                            : RU=
NNING
> >>>Sleeping for 1 seconds: Got NFS4ERR_DELAY on open
> >>>*****CB received COMPOUND******
> >>>******* CB_Recall (id=3D13)********
> >>>Woke up
> >>>Sleeping for 1 seconds: Got NFS4ERR_DELAY on open
> >>>Woke up
> >>>Sleeping for 1 seconds: Got NFS4ERR_DELAY on open
> >>>Woke up
> >>>Sleeping for 1 seconds: Got NFS4ERR_DELAY on open
> >>>Woke up
> >>>Sleeping for 1 seconds: Got NFS4ERR_DELAY on open
> >>>Woke up
> >>>Sleeping for 1 seconds: Got NFS4ERR_DELAY on open
> >>>Woke up
> >>>Sleeping for 1 seconds: Got NFS4ERR_DELAY on open
> >>>Woke up
> >>>Sleeping for 1 seconds: Got NFS4ERR_DELAY on open
> >>>Woke up
> >>>Sleeping for 1 seconds: Got NFS4ERR_DELAY on open
> >>>Woke up
> >>>Sleeping for 1 seconds: Got NFS4ERR_DELAY on open
> >>>Woke up
> >>>Sleeping for 1 seconds: Got NFS4ERR_DELAY on open
> >>>Woke up
> >>>Sleeping for 1 seconds: Got NFS4ERR_DELAY on open
> >>>Woke up
> >>>Sleeping for 1 seconds: Got NFS4ERR_DELAY on open
> >>>Woke up
> >>>Sleeping for 1 seconds: Got NFS4ERR_DELAY on open
> >>>Woke up
> >>>Sleeping for 1 seconds: Got NFS4ERR_DELAY on open
> >>>Woke up
> >>>Sleeping for 1 seconds: Got NFS4ERR_DELAY on open
> >>>Woke up
> >>>DELEG3d  st_delegation.testReadDeleg3d                            : PA=
SS
> >>>DELEG3c  st_delegation.testReadDeleg3c                            : RU=
NNING
> >>>Sleeping for 1 seconds: Got NFS4ERR_DELAY on open
> >>>*****CB received COMPOUND******
> >>>******* CB_Recall (id=3D14)********
> >>>Woke up
> >>>Sleeping for 1 seconds: Got NFS4ERR_DELAY on open
> >>>Woke up
> >>>Sleeping for 1 seconds: Got NFS4ERR_DELAY on open
> >>>Woke up
> >>>Sleeping for 1 seconds: Got NFS4ERR_DELAY on open
> >>>Woke up
> >>>Sleeping for 1 seconds: Got NFS4ERR_DELAY on open
> >>>Woke up
> >>>Sleeping for 1 seconds: Got NFS4ERR_DELAY on open
> >>>Woke up
> >>>Sleeping for 1 seconds: Got NFS4ERR_DELAY on open
> >>>Woke up
> >>>Sleeping for 1 seconds: Got NFS4ERR_DELAY on open
> >>>Woke up
> >>>Sleeping for 1 seconds: Got NFS4ERR_DELAY on open
> >>>Woke up
> >>>Sleeping for 1 seconds: Got NFS4ERR_DELAY on open
> >>>Woke up
> >>>Sleeping for 1 seconds: Got NFS4ERR_DELAY on open
> >>>Woke up
> >>>Sleeping for 1 seconds: Got NFS4ERR_DELAY on open
> >>>Woke up
> >>>Sleeping for 1 seconds: Got NFS4ERR_DELAY on open
> >>>Woke up
> >>>Sleeping for 1 seconds: Got NFS4ERR_DELAY on open
> >>>Woke up
> >>>Sleeping for 1 seconds: Got NFS4ERR_DELAY on open
> >>>Woke up
> >>>Sleeping for 1 seconds: Got NFS4ERR_DELAY on open
> >>>Woke up
> >>>Sleeping for 1 seconds: Got NFS4ERR_DELAY on open
> >>>Woke up
> >>>DELEG3c  st_delegation.testReadDeleg3c                            : PA=
SS
> >>>DELEG3b  st_delegation.testReadDeleg3b                            : RU=
NNING
> >>>Sleeping for 1 seconds: Got NFS4ERR_DELAY on open
> >>>*****CB received COMPOUND******
> >>>******* CB_Recall (id=3D15)********
> >>>Woke up
> >>>Sleeping for 1 seconds: Got NFS4ERR_DELAY on open
> >>>Woke up
> >>>Sleeping for 1 seconds: Got NFS4ERR_DELAY on open
> >>>Woke up
> >>>Sleeping for 1 seconds: Got NFS4ERR_DELAY on open
> >>>Woke up
> >>>Sleeping for 1 seconds: Got NFS4ERR_DELAY on open
> >>>Woke up
> >>>Sleeping for 1 seconds: Got NFS4ERR_DELAY on open
> >>>Woke up
> >>>Sleeping for 1 seconds: Got NFS4ERR_DELAY on open
> >>>Woke up
> >>>Sleeping for 1 seconds: Got NFS4ERR_DELAY on open
> >>>Woke up
> >>>Sleeping for 1 seconds: Got NFS4ERR_DELAY on open
> >>>Woke up
> >>>Sleeping for 1 seconds: Got NFS4ERR_DELAY on open
> >>>Woke up
> >>>Sleeping for 1 seconds: Got NFS4ERR_DELAY on open
> >>>Woke up
> >>>Sleeping for 1 seconds: Got NFS4ERR_DELAY on open
> >>>Woke up
> >>>Sleeping for 1 seconds: Got NFS4ERR_DELAY on open
> >>>Woke up
> >>>Sleeping for 1 seconds: Got NFS4ERR_DELAY on open
> >>>Woke up
> >>>Sleeping for 1 seconds: Got NFS4ERR_DELAY on open
> >>>Woke up
> >>>Sleeping for 1 seconds: Got NFS4ERR_DELAY on open
> >>>Woke up
> >>>DELEG3b  st_delegation.testReadDeleg3b                            : PA=
SS
> >>>DELEG3a  st_delegation.testReadDeleg3a                            : RU=
NNING
> >>>Sleeping for 1 seconds: Got NFS4ERR_DELAY on open
> >>>*****CB received COMPOUND******
> >>>******* CB_Recall (id=3D16)********
> >>>Woke up
> >>>Sleeping for 1 seconds: Got NFS4ERR_DELAY on open
> >>>Woke up
> >>>Sleeping for 1 seconds: Got NFS4ERR_DELAY on open
> >>>Woke up
> >>>Sleeping for 1 seconds: Got NFS4ERR_DELAY on open
> >>>Woke up
> >>>Sleeping for 1 seconds: Got NFS4ERR_DELAY on open
> >>>Woke up
> >>>Sleeping for 1 seconds: Got NFS4ERR_DELAY on open
> >>>Woke up
> >>>Sleeping for 1 seconds: Got NFS4ERR_DELAY on open
> >>>Woke up
> >>>Sleeping for 1 seconds: Got NFS4ERR_DELAY on open
> >>>Woke up
> >>>Sleeping for 1 seconds: Got NFS4ERR_DELAY on open
> >>>Woke up
> >>>Sleeping for 1 seconds: Got NFS4ERR_DELAY on open
> >>>Woke up
> >>>Sleeping for 1 seconds: Got NFS4ERR_DELAY on open
> >>>Woke up
> >>>Sleeping for 1 seconds: Got NFS4ERR_DELAY on open
> >>>Woke up
> >>>Sleeping for 1 seconds: Got NFS4ERR_DELAY on open
> >>>Woke up
> >>>Sleeping for 1 seconds: Got NFS4ERR_DELAY on open
> >>>Woke up
> >>>Sleeping for 1 seconds: Got NFS4ERR_DELAY on open
> >>>Woke up
> >>>Sleeping for 1 seconds: Got NFS4ERR_DELAY on open
> >>>Woke up
> >>>Sleeping for 1 seconds: Got NFS4ERR_DELAY on open
> >>>Woke up
> >>>DELEG3a  st_delegation.testReadDeleg3a                            : PA=
SS
> >>>DELEG2   st_delegation.testReadDeleg2                             : RU=
NNING
> >>>*****CB received COMPOUND******
> >>>******* CB_Recall (id=3D17)********
> >>>Sleeping for 1 seconds: Got NFS4ERR_DELAY on open
> >>>Woke up
> >>>Sleeping for 1 seconds: Got NFS4ERR_DELAY on open
> >>>Woke up
> >>>Sleeping for 1 seconds: Got NFS4ERR_DELAY on open
> >>>Woke up
> >>>Sleeping for 1 seconds: Got NFS4ERR_DELAY on open
> >>>Woke up
> >>>Sleeping for 1 seconds: Got NFS4ERR_DELAY on open
> >>>Woke up
> >>>Sleeping for 1 seconds: Got NFS4ERR_DELAY on open
> >>>Woke up
> >>>Sleeping for 1 seconds: Got NFS4ERR_DELAY on open
> >>>Woke up
> >>>Sleeping for 1 seconds: Got NFS4ERR_DELAY on open
> >>>Woke up
> >>>Sleeping for 1 seconds: Got NFS4ERR_DELAY on open
> >>>Woke up
> >>>Sleeping for 1 seconds: Got NFS4ERR_DELAY on open
> >>>Woke up
> >>>Sleeping for 1 seconds: Got NFS4ERR_DELAY on open
> >>>Woke up
> >>>Sleeping for 1 seconds: Got NFS4ERR_DELAY on open
> >>>Woke up
> >>>Sleeping for 1 seconds: Got NFS4ERR_DELAY on open
> >>>Woke up
> >>>Sleeping for 1 seconds: Got NFS4ERR_DELAY on open
> >>>Woke up
> >>>Sleeping for 1 seconds: Got NFS4ERR_DELAY on open
> >>>Woke up
> >>>Sleeping for 1 seconds: Got NFS4ERR_DELAY on open
> >>>Woke up
> >>>Sleeping for 1 seconds: Got NFS4ERR_DELAY on open
> >>>Woke up
> >>>DELEG2   st_delegation.testReadDeleg2                             : PA=
SS
> >>>DELEG1   st_delegation.testReadDeleg1                             : RU=
NNING
> >>>Sleeping for 1 seconds: Got NFS4ERR_DELAY on open
> >>>*****CB received COMPOUND******
> >>>******* CB_Recall (id=3D18)********
> >>>Woke up
> >>>DELEG1   st_delegation.testReadDeleg1                             : PA=
SS
> >>>DELEG15b st_delegation.testLink                                   : RU=
NNING
> >>>Sleeping for 1 seconds: Got NFS4ERR_DELAY on link
> >>>*****CB received COMPOUND******
> >>>******* CB_Recall (id=3D19)********
> >>>Woke up
> >>>DELEG15b st_delegation.testLink                                   : PA=
SS
> >>>DELEG7   st_delegation.testIgnoreDeleg                            : RU=
NNING
> >>>Sleeping for 1 seconds: Got NFS4ERR_DELAY on open
> >>>*****CB received COMPOUND******
> >>>******* CB_Recall (id=3D20)********
> >>>Woke up
> >>>DELEG7   st_delegation.testIgnoreDeleg                            : PA=
SS
> >>>DELEG8   st_delegation.testDelegShare                             : RU=
NNING
> >>>DELEG8   st_delegation.testDelegShare                             : PA=
SS
> >>>DELEG4   st_delegation.testCloseDeleg                             : RU=
NNING
> >>>Sleeping for 1 seconds: Got NFS4ERR_DELAY on open
> >>>*****CB received COMPOUND******
> >>>******* CB_Recall (id=3D22)********
> >>>Woke up
> >>>DELEG4   st_delegation.testCloseDeleg                             : PA=
SS
> >>>DELEG14  st_delegation.testClaimCur                               : RU=
NNING
> >>>Sleeping for 2 seconds: Waiting for recall
> >>>*****CB received COMPOUND******
> >>>******* CB_Recall (id=3D23)********
> >>>Woke up
> >>>DELEG14  st_delegation.testClaimCur                               : PA=
SS
> >>>DELEG9   st_delegation.testChangeDeleg                            : RU=
NNING
> >>>Sleeping for 3 seconds:
> >>>Woke up
> >>>Sleeping for 1 seconds: Got NFS4ERR_DELAY on open
> >>>*****CB received COMPOUND******
> >>>******* CB_Recall (id=3D1)********
> >>>Woke up
> >>>Sleeping for 1 seconds: Got NFS4ERR_DELAY on open
> >>>Woke up
> >>>Sleeping for 1 seconds: Got NFS4ERR_DELAY on open
> >>>Woke up
> >>>Sleeping for 1 seconds: Got NFS4ERR_DELAY on open
> >>>Woke up
> >>>Sleeping for 1 seconds: Got NFS4ERR_DELAY on open
> >>>Woke up
> >>>Sleeping for 1 seconds: Got NFS4ERR_DELAY on open
> >>>Woke up
> >>>Sleeping for 1 seconds: Got NFS4ERR_DELAY on open
> >>>Woke up
> >>>Sleeping for 1 seconds: Got NFS4ERR_DELAY on open
> >>>Woke up
> >>>Sleeping for 1 seconds: Got NFS4ERR_DELAY on open
> >>>Woke up
> >>>Sleeping for 1 seconds: Got NFS4ERR_DELAY on open
> >>>Woke up
> >>>Sleeping for 1 seconds: Got NFS4ERR_DELAY on open
> >>>Woke up
> >>>Sleeping for 1 seconds: Got NFS4ERR_DELAY on open
> >>>Woke up
> >>>Sleeping for 1 seconds: Got NFS4ERR_DELAY on open
> >>>Woke up
> >>>Sleeping for 1 seconds: Got NFS4ERR_DELAY on open
> >>>Woke up
> >>>Sleeping for 1 seconds: Got NFS4ERR_DELAY on open
> >>>Woke up
> >>>Sleeping for 1 seconds: Got NFS4ERR_DELAY on open
> >>>Woke up
> >>>DELEG9   st_delegation.testChangeDeleg                            : PA=
SS
> >>>INIT     st_setclientid.testValid                                 : RU=
NNING
> >>>INIT     st_setclientid.testValid                                 : PA=
SS
> >>>MKFILE   st_open.testOpen                                         : RU=
NNING
> >>>MKFILE   st_open.testOpen                                         : PA=
SS
> >>>REBT8    st_reboot.testValidDeleg                                 : RU=
NNING
> >>>Got error: Connection closed
> >>>Sleeping for 20 seconds: Waiting for grace period to end
> >>>Woke up
> >>>REBT8    st_reboot.testValidDeleg                                 : PA=
SS
> >>>REBT3    st_reboot.testRebootWait                                 : RU=
NNING
> >>>Got error: Connection closed
> >>>Sleeping for 10 seconds: Waiting till halfway through grace period
> >>>Woke up
> >>>Sleeping for 11 seconds: Waiting for grace period to end
> >>>Woke up
> >>>REBT3    st_reboot.testRebootWait                                 : PA=
SS
> >>>REBT1    st_reboot.testRebootValid                                : RU=
NNING
> >>>Got error: Connection closed
> >>>Sleeping for 20 seconds: Waiting for grace period to end
> >>>Woke up
> >>>REBT1    st_reboot.testRebootValid                                : PA=
SS
> >>>REBT10   st_reboot.testRebootMultiple                             : RU=
NNING
> >>>Got error: Connection closed
> >>>Got error: Connection closed
> >>>Sleeping for 20 seconds: Waiting for grace period to end
> >>>Woke up
> >>>REBT10   st_reboot.testRebootMultiple                             : PA=
SS
> >>>MKDIR    st_create.testDir                                        : RU=
NNING
> >>>MKDIR    st_create.testDir                                        : PA=
SS
> >>>REBT2    st_reboot.testManyClaims                                 : RU=
NNING
> >>>Got error: Connection closed
> >>>Sleeping for 20 seconds: Waiting for grace period to end
> >>>Woke up
> >>>REBT2    st_reboot.testManyClaims                                 : PA=
SS
> >>>REBT11   st_reboot.testGraceSeqid                                 : RU=
NNING
> >>>Got error: Connection closed
> >>>Sleeping for 10 seconds: Waiting till halfway through grace period
> >>>Woke up
> >>>Sleeping for 11 seconds: Waiting for grace period to end
> >>>Woke up
> >>>REBT11   st_reboot.testGraceSeqid                                 : PA=
SS
> >>>REBT6    st_reboot.testEdge2                                      : RU=
NNING
> >>>Got error: Connection closed
> >>>Sleeping for 20 seconds: Waiting for grace period to end
> >>>Woke up
> >>>Got error: Connection closed
> >>>Got error: Connection closed
> >>>Got error: Connection closed
> >>>Sleeping for 20 seconds: Waiting for grace period to end
> >>>Woke up
> >>>REBT6    st_reboot.testEdge2                                      : PA=
SS
> >>>REBT5    st_reboot.testEdge1                                      : RU=
NNING
> >>>Sleeping for 22 seconds: Waiting for lock lease to expire
> >>>Woke up
> >>>Got error: Connection closed
> >>>Got error: Connection closed
> >>>Sleeping for 20 seconds: Waiting for grace period to end
> >>>Woke up
> >>>REBT5    st_reboot.testEdge1                                      : PA=
SS
> >>>RPLY8    st_replay.testUnlockWait                                 : RU=
NNING
> >>>Sleeping for 30 seconds:
> >>>Woke up
> >>>Sleeping for 0.3 seconds:
> >>>Woke up
> >>>Sleeping for 0.3 seconds:
> >>>Woke up
> >>>RPLY8    st_replay.testUnlockWait                                 : PA=
SS
> >>>RPLY7    st_replay.testUnlock                                     : RU=
NNING
> >>>Sleeping for 0.3 seconds:
> >>>Woke up
> >>>Sleeping for 0.3 seconds:
> >>>Woke up
> >>>RPLY7    st_replay.testUnlock                                     : PA=
SS
> >>>RPLY3    st_replay.testReplayState2                               : RU=
NNING
> >>>Sleeping for 0.3 seconds:
> >>>Woke up
> >>>Sleeping for 0.3 seconds:
> >>>Woke up
> >>>RPLY3    st_replay.testReplayState2                               : PA=
SS
> >>>RPLY2    st_replay.testReplayState1                               : RU=
NNING
> >>>Sleeping for 0.3 seconds:
> >>>Woke up
> >>>Sleeping for 0.3 seconds:
> >>>Woke up
> >>>RPLY2    st_replay.testReplayState1                               : PA=
SS
> >>>RPLY4    st_replay.testReplayNonState                             : RU=
NNING
> >>>Sleeping for 0.3 seconds:
> >>>Woke up
> >>>Sleeping for 0.3 seconds:
> >>>Woke up
> >>>RPLY4    st_replay.testReplayNonState                             : PA=
SS
> >>>RPLY13   st_replay.testOpenConfirmFail                            : RU=
NNING
> >>>Sleeping for 0.3 seconds:
> >>>Woke up
> >>>Sleeping for 0.3 seconds:
> >>>Woke up
> >>>RPLY13   st_replay.testOpenConfirmFail                            : PA=
SS
> >>>RPLY12   st_replay.testOpenConfirm                                : RU=
NNING
> >>>Sleeping for 0.3 seconds:
> >>>Woke up
> >>>Sleeping for 0.3 seconds:
> >>>Woke up
> >>>RPLY12   st_replay.testOpenConfirm                                : PA=
SS
> >>>RPLY1    st_replay.testOpen                                       : RU=
NNING
> >>>Sleeping for 0.3 seconds:
> >>>Woke up
> >>>Sleeping for 0.3 seconds:
> >>>Woke up
> >>>RPLY1    st_replay.testOpen                                       : PA=
SS
> >>>RPLY14   st_replay.testMkdirReplay                                : RU=
NNING
> >>>Sleeping for 0.3 seconds:
> >>>Woke up
> >>>Sleeping for 0.3 seconds:
> >>>Woke up
> >>>RPLY14   st_replay.testMkdirReplay                                : PA=
SS
> >>>RPLY6    st_replay.testLockDenied                                 : RU=
NNING
> >>>Sleeping for 0.3 seconds:
> >>>Woke up
> >>>Sleeping for 0.3 seconds:
> >>>Woke up
> >>>RPLY6    st_replay.testLockDenied                                 : PA=
SS
> >>>RPLY5    st_replay.testLock                                       : RU=
NNING
> >>>Sleeping for 0.3 seconds:
> >>>Woke up
> >>>Sleeping for 0.3 seconds:
> >>>Woke up
> >>>RPLY5    st_replay.testLock                                       : PA=
SS
> >>>RPLY10   st_replay.testCloseWait                                  : RU=
NNING
> >>>Sleeping for 30 seconds:
> >>>Woke up
> >>>Sleeping for 0.3 seconds:
> >>>Woke up
> >>>Sleeping for 0.3 seconds:
> >>>Woke up
> >>>RPLY10   st_replay.testCloseWait                                  : PA=
SS
> >>>RPLY11   st_replay.testCloseFail                                  : RU=
NNING
> >>>Sleeping for 0.3 seconds:
> >>>Woke up
> >>>Sleeping for 0.3 seconds:
> >>>Woke up
> >>>RPLY11   st_replay.testCloseFail                                  : PA=
SS
> >>>RPLY9    st_replay.testClose                                      : RU=
NNING
> >>>Sleeping for 0.3 seconds:
> >>>Woke up
> >>>Sleeping for 0.3 seconds:
> >>>Woke up
> >>>RPLY9    st_replay.testClose                                      : PA=
SS
> >>>WRT3     st_write.testWithOpen                                    : RU=
NNING
> >>>WRT3     st_write.testWithOpen                                    : PA=
SS
> >>>WRT5b    st_write.testTooLargeData                                : RU=
NNING
> >>>WRT5b    st_write.testTooLargeData                                : PA=
SS
> >>>WRT19    st_write.testStolenStateid                               : RU=
NNING
> >>>WRT19    st_write.testStolenStateid                               : PA=
SS
> >>>WRT2     st_write.testStateidOne                                  : RU=
NNING
> >>>WRT2     st_write.testStateidOne                                  : PA=
SS
> >>>WRT11    st_write.testStaleStateid                                : RU=
NNING
> >>>WRT11    st_write.testStaleStateid                                : PA=
SS
> >>>MKSOCK   st_create.testSocket                                     : RU=
NNING
> >>>MKSOCK   st_create.testSocket                                     : PA=
SS
> >>>WRT6s    st_write.testSocket                                      : RU=
NNING
> >>>WRT6s    st_write.testSocket                                      : PA=
SS
> >>>WRT15    st_write.testSizes                                       : RU=
NNING
> >>>WRT15    st_write.testSizes                                       : PA=
SS
> >>>WRT1b    st_write.testSimpleWrite2                                : RU=
NNING
> >>>WRT1b    st_write.testSimpleWrite2                                : PA=
SS
> >>>WRT1     st_write.testSimpleWrite                                 : RU=
NNING
> >>>WRT1     st_write.testSimpleWrite                                 : PA=
SS
> >>>WRT9     st_write.testShareDeny                                   : RU=
NNING
> >>>WRT9     st_write.testShareDeny                                   : PA=
SS
> >>>WRT8     st_write.testOpenMode                                    : RU=
NNING
> >>>WRT8     st_write.testOpenMode                                    : PA=
SS
> >>>WRT12    st_write.testOldStateid                                  : RU=
NNING
> >>>WRT12    st_write.testOldStateid                                  : PA=
SS
> >>>WRT7     st_write.testNoFh                                        : RU=
NNING
> >>>WRT7     st_write.testNoFh                                        : PA=
SS
> >>>WRT4     st_write.testNoData                                      : RU=
NNING
> >>>Sleeping for 1 seconds:
> >>>Woke up
> >>>WRT4     st_write.testNoData                                      : PA=
SS
> >>>WRT5a    st_write.testMaximumData                                 : RU=
NNING
> >>>WRT5a    st_write.testMaximumData                                 : PA=
SS
> >>>MKLINK   st_create.testLink                                       : RU=
NNING
> >>>MKLINK   st_create.testLink                                       : PA=
SS
> >>>WRT6a    st_write.testLink                                        : RU=
NNING
> >>>WRT6a    st_write.testLink                                        : PA=
SS
> >>>WRT14    st_write.testLargeWrite                                  : RU=
NNING
> >>>WRT14    st_write.testLargeWrite                                  : PA=
SS
> >>>MKFIFO   st_create.testFIFO                                       : RU=
NNING
> >>>MKFIFO   st_create.testFIFO                                       : PA=
SS
> >>>WRT6f    st_write.testFifo                                        : RU=
NNING
> >>>WRT6f    st_write.testFifo                                        : PA=
SS
> >>>WRT13    st_write.testDoubleWrite                                 : RU=
NNING
> >>>WRT13    st_write.testDoubleWrite                                 : PA=
SS
> >>>WRT6d    st_write.testDir                                         : RU=
NNING
> >>>WRT6d    st_write.testDir                                         : PA=
SS
> >>>MODE     st_setattr.testMode                                      : RU=
NNING
> >>>MODE     st_setattr.testMode                                      : PA=
SS
> >>>WRT18    st_write.testChangeGranularityWrite                      : RU=
NNING
> >>>WRT18    st_write.testChangeGranularityWrite                      : PA=
SS
> >>>LOOKSOCK st_lookup.testSocket                                     : RU=
NNING
> >>>LOOKSOCK st_lookup.testSocket                                     : PA=
SS
> >>>VF5s     st_verify.testWriteOnlySocket                            : RU=
NNING
> >>>VF5s     st_verify.testWriteOnlySocket                            : PA=
SS
> >>>LOOKLINK st_lookup.testLink                                       : RU=
NNING
> >>>LOOKLINK st_lookup.testLink                                       : PA=
SS
> >>>VF5a     st_verify.testWriteOnlyLink                              : RU=
NNING
> >>>VF5a     st_verify.testWriteOnlyLink                              : PA=
SS
> >>>LOOKFILE st_lookup.testFile                                       : RU=
NNING
> >>>LOOKFILE st_lookup.testFile                                       : PA=
SS
> >>>VF5r     st_verify.testWriteOnlyFile                              : RU=
NNING
> >>>VF5r     st_verify.testWriteOnlyFile                              : PA=
SS
> >>>LOOKFIFO st_lookup.testFifo                                       : RU=
NNING
> >>>LOOKFIFO st_lookup.testFifo                                       : PA=
SS
> >>>VF5f     st_verify.testWriteOnlyFifo                              : RU=
NNING
> >>>VF5f     st_verify.testWriteOnlyFifo                              : PA=
SS
> >>>LOOKDIR  st_lookup.testDir                                        : RU=
NNING
> >>>LOOKDIR  st_lookup.testDir                                        : PA=
SS
> >>>VF5d     st_verify.testWriteOnlyDir                               : RU=
NNING
> >>>VF5d     st_verify.testWriteOnlyDir                               : PA=
SS
> >>>VF7s     st_verify.testUnsupportedSocket                          : RU=
NNING
> >>>VF7s     st_verify.testUnsupportedSocket                          : PA=
SS
> >>>VF7a     st_verify.testUnsupportedLink                            : RU=
NNING
> >>>VF7a     st_verify.testUnsupportedLink                            : PA=
SS
> >>>VF7r     st_verify.testUnsupportedFile                            : RU=
NNING
> >>>VF7r     st_verify.testUnsupportedFile                            : PA=
SS
> >>>VF7f     st_verify.testUnsupportedFifo                            : RU=
NNING
> >>>VF7f     st_verify.testUnsupportedFifo                            : PA=
SS
> >>>VF7d     st_verify.testUnsupportedDir                             : RU=
NNING
> >>>VF7d     st_verify.testUnsupportedDir                             : PA=
SS
> >>>VF2s     st_verify.testTypeSocket                                 : RU=
NNING
> >>>VF2s     st_verify.testTypeSocket                                 : PA=
SS
> >>>VF2a     st_verify.testTypeLink                                   : RU=
NNING
> >>>VF2a     st_verify.testTypeLink                                   : PA=
SS
> >>>VF2r     st_verify.testTypeFile                                   : RU=
NNING
> >>>VF2r     st_verify.testTypeFile                                   : PA=
SS
> >>>VF2f     st_verify.testTypeFifo                                   : RU=
NNING
> >>>VF2f     st_verify.testTypeFifo                                   : PA=
SS
> >>>VF2d     st_verify.testTypeDir                                    : RU=
NNING
> >>>VF2d     st_verify.testTypeDir                                    : PA=
SS
> >>>VF4      st_verify.testNoFh                                       : RU=
NNING
> >>>VF4      st_verify.testNoFh                                       : PA=
SS
> >>>VF1s     st_verify.testMandSocket                                 : RU=
NNING
> >>>VF1s     st_verify.testMandSocket                                 : PA=
SS
> >>>VF1a     st_verify.testMandLink                                   : RU=
NNING
> >>>VF1a     st_verify.testMandLink                                   : PA=
SS
> >>>VF1r     st_verify.testMandFile                                   : RU=
NNING
> >>>VF1r     st_verify.testMandFile                                   : PA=
SS
> >>>VF1f     st_verify.testMandFifo                                   : RU=
NNING
> >>>VF1f     st_verify.testMandFifo                                   : PA=
SS
> >>>VF1d     st_verify.testMandDir                                    : RU=
NNING
> >>>VF1d     st_verify.testMandDir                                    : PA=
SS
> >>>VF3s     st_verify.testBadSizeSocket                              : RU=
NNING
> >>>VF3s     st_verify.testBadSizeSocket                              : PA=
SS
> >>>VF3a     st_verify.testBadSizeLink                                : RU=
NNING
> >>>VF3a     st_verify.testBadSizeLink                                : PA=
SS
> >>>VF3r     st_verify.testBadSizeFile                                : RU=
NNING
> >>>VF3r     st_verify.testBadSizeFile                                : PA=
SS
> >>>VF3f     st_verify.testBadSizeFifo                                : RU=
NNING
> >>>VF3f     st_verify.testBadSizeFifo                                : PA=
SS
> >>>VF3d     st_verify.testBadSizeDir                                 : RU=
NNING
> >>>VF3d     st_verify.testBadSizeDir                                 : PA=
SS
> >>>CIDCF1   st_setclientidconfirm.testStale                          : RU=
NNING
> >>>CIDCF1   st_setclientidconfirm.testStale                          : PA=
SS
> >>>CIDCF3   st_setclientidconfirm.testAllCases                       : RU=
NNING
> >>>CIDCF3   st_setclientidconfirm.testAllCases                       : PA=
SS
> >>>CID4e    st_setclientid.testUnConfReplaced                        : RU=
NNING
> >>>CID4e    st_setclientid.testUnConfReplaced                        : PA=
SS
> >>>CID2     st_setclientid.testNotInUse                              : RU=
NNING
> >>>CID2     st_setclientid.testNotInUse                              : PA=
SS
> >>>CID6     st_setclientid.testNoConfirm                             : RU=
NNING
> >>>CID6     st_setclientid.testNoConfirm                             : PA=
SS
> >>>CID5     st_setclientid.testLotsOfClients                         : RU=
NNING
> >>>CID5     st_setclientid.testLotsOfClients                         : PA=
SS
> >>>CID3     st_setclientid.testLoseAnswer                            : RU=
NNING
> >>>CID3     st_setclientid.testLoseAnswer                            : PA=
SS
> >>>CID2a    st_setclientid.testInUse                                 : RU=
NNING
> >>>CID2a    st_setclientid.testInUse                                 : PA=
SS
> >>>CID4b    st_setclientid.testConfirmedDiffVerifier                 : RU=
NNING
> >>>CID4b    st_setclientid.testConfirmedDiffVerifier                 : PA=
SS
> >>>CID4d    st_setclientid.testConfUnConfDiffVerifier2               : RU=
NNING
> >>>CID4d    st_setclientid.testConfUnConfDiffVerifier2               : PA=
SS
> >>>CID4c    st_setclientid.testConfUnConfDiffVerifier1               : RU=
NNING
> >>>CID4c    st_setclientid.testConfUnConfDiffVerifier1               : PA=
SS
> >>>CID1b    st_setclientid.testClientUpdateCallback                  : RU=
NNING
> >>>CID1b    st_setclientid.testClientUpdateCallback                  : PA=
SS
> >>>CID1     st_setclientid.testClientReboot                          : RU=
NNING
> >>>CID1     st_setclientid.testClientReboot                          : PA=
SS
> >>>CID4a    st_setclientid.testCallbackInfoUpdate                    : RU=
NNING
> >>>CID4a    st_setclientid.testCallbackInfoUpdate                    : PA=
SS
> >>>CID4     st_setclientid.testAllCases                              : RU=
NNING
> >>>CID4     st_setclientid.testAllCases                              : PA=
SS
> >>>SATT2c   st_setattr.testUselessStateid3                           : RU=
NNING
> >>>SATT2c   st_setattr.testUselessStateid3                           : PA=
SS
> >>>SATT2b   st_setattr.testUselessStateid2                           : RU=
NNING
> >>>SATT2b   st_setattr.testUselessStateid2                           : PA=
SS
> >>>SATT2a   st_setattr.testUselessStateid1                           : RU=
NNING
> >>>SATT2a   st_setattr.testUselessStateid1                           : PA=
SS
> >>>SATT11s  st_setattr.testUnsupportedSocket                         : RU=
NNING
> >>>SATT11s  st_setattr.testUnsupportedSocket                         : PA=
SS
> >>>SATT11a  st_setattr.testUnsupportedLink                           : RU=
NNING
> >>>SATT11a  st_setattr.testUnsupportedLink                           : PA=
SS
> >>>SATT11r  st_setattr.testUnsupportedFile                           : RU=
NNING
> >>>SATT11r  st_setattr.testUnsupportedFile                           : PA=
SS
> >>>SATT11f  st_setattr.testUnsupportedFifo                           : RU=
NNING
> >>>SATT11f  st_setattr.testUnsupportedFifo                           : PA=
SS
> >>>SATT11d  st_setattr.testUnsupportedDir                            : RU=
NNING
> >>>SATT11d  st_setattr.testUnsupportedDir                            : PA=
SS
> >>>SATT12s  st_setattr.testSizeSocket                                : RU=
NNING
> >>>SATT12s  st_setattr.testSizeSocket                                : PA=
SS
> >>>SATT12a  st_setattr.testSizeLink                                  : RU=
NNING
> >>>SATT12a  st_setattr.testSizeLink                                  : PA=
SS
> >>>SATT12f  st_setattr.testSizeFifo                                  : RU=
NNING
> >>>SATT12f  st_setattr.testSizeFifo                                  : PA=
SS
> >>>SATT12d  st_setattr.testSizeDir                                   : RU=
NNING
> >>>SATT12d  st_setattr.testSizeDir                                   : PA=
SS
> >>>SATT3d   st_setattr.testResizeFile3                               : RU=
NNING
> >>>SATT3d   st_setattr.testResizeFile3                               : PA=
SS
> >>>SATT3c   st_setattr.testResizeFile2                               : RU=
NNING
> >>>SATT3c   st_setattr.testResizeFile2                               : PA=
SS
> >>>SATT3b   st_setattr.testResizeFile1                               : RU=
NNING
> >>>SATT3b   st_setattr.testResizeFile1                               : PA=
SS
> >>>SATT3a   st_setattr.testResizeFile0                               : RU=
NNING
> >>>SATT3a   st_setattr.testResizeFile0                               : PA=
SS
> >>>SATT6d   st_setattr.testReadonlyDir                               : RU=
NNING
> >>>SATT6d   st_setattr.testReadonlyDir                               : PA=
SS
> >>>SATT6s   st_setattr.testReadonlySocket                            : RU=
NNING
> >>>SATT6s   st_setattr.testReadonlySocket                            : PA=
SS
> >>>SATT6a   st_setattr.testReadonlyLink                              : RU=
NNING
> >>>SATT6a   st_setattr.testReadonlyLink                              : PA=
SS
> >>>SATT6r   st_setattr.testReadonlyFile                              : RU=
NNING
> >>>SATT6r   st_setattr.testReadonlyFile                              : PA=
SS
> >>>SATT6f   st_setattr.testReadonlyFifo                              : RU=
NNING
> >>>SATT6f   st_setattr.testReadonlyFifo                              : PA=
SS
> >>>SATT4    st_setattr.testOpenModeResize                            : RU=
NNING
> >>>SATT4    st_setattr.testOpenModeResize                            : PA=
SS
> >>>SATT5    st_setattr.testNoFh                                      : RU=
NNING
> >>>SATT5    st_setattr.testNoFh                                      : PA=
SS
> >>>SATT10   st_setattr.testInvalidTime                               : RU=
NNING
> >>>SATT10   st_setattr.testInvalidTime                               : PA=
SS
> >>>SATT8    st_setattr.testInvalidAttr2                              : RU=
NNING
> >>>SATT8    st_setattr.testInvalidAttr2                              : PA=
SS
> >>>SATT7    st_setattr.testInvalidAttr1                              : RU=
NNING
> >>>Traceback (most recent call last):
> >>>   File "/root/pynfs/nfs4.0/lib/testmod.py", line 234, in run
> >>>     self.runtest(self, environment)
> >>>   File "/root/pynfs/nfs4.0/servertests/st_renew.py", line 41, in test=
Expired
> >>>     c2.open_confirm(t.word(), access=3DOPEN4_SHARE_ACCESS_READ,
> >>>   File "/root/pynfs/nfs4.0/nfs4lib.py", line 727, in open_confirm
> >>>     check_result(res, "Opening file %s" % _getname(owner, path))
> >>>   File "/root/pynfs/nfs4.0/nfs4lib.py", line 895, in check_result
> >>>     raise BadCompoundRes(resop, res.status, msg)
> >>>nfs4lib.BadCompoundRes: Opening file b'RENEW3-1': operation OP_OPEN sh=
ould return NFS4_OK, instead got NFS4ERR_DELAY
> >>>SATT7    st_setattr.testInvalidAttr1                              : PA=
SS
> >>>SATT13   st_setattr.testInodeLocking                              : RU=
NNING
> >>>SATT13   st_setattr.testInodeLocking                              : PA=
SS
> >>>SATT1r   st_setattr.testFile                                      : RU=
NNING
> >>>SATT1r   st_setattr.testFile                                      : PA=
SS
> >>>SATT1f   st_setattr.testFifo                                      : RU=
NNING
> >>>SATT1f   st_setattr.testFifo                                      : PA=
SS
> >>>SATT16   st_setattr.testEmptyPrincipal                            : RU=
NNING
> >>>SATT16   st_setattr.testEmptyPrincipal                            : PA=
SS
> >>>SATT17   st_setattr.testEmptyGroupPrincipal                       : RU=
NNING
> >>>SATT17   st_setattr.testEmptyGroupPrincipal                       : PA=
SS
> >>>SATT1d   st_setattr.testDir                                       : RU=
NNING
> >>>SATT1d   st_setattr.testDir                                       : PA=
SS
> >>>SATT15   st_setattr.testChangeGranularity                         : RU=
NNING
> >>>SATT15   st_setattr.testChangeGranularity                         : PA=
SS
> >>>SATT14   st_setattr.testChange                                    : RU=
NNING
> >>>SATT14   st_setattr.testChange                                    : PA=
SS
> >>>SEC1     st_secinfo.testValid                                     : RU=
NNING
> >>>SEC1     st_secinfo.testValid                                     : PA=
SS
> >>>SEC5     st_secinfo.testZeroLenName                               : RU=
NNING
> >>>SEC5     st_secinfo.testZeroLenName                               : PA=
SS
> >>>SEC3     st_secinfo.testVaporFile                                 : RU=
NNING
> >>>SEC3     st_secinfo.testVaporFile                                 : PA=
SS
> >>>SEC7     st_secinfo.testRPCSEC_GSS                                : RU=
NNING
> >>>SEC7     st_secinfo.testRPCSEC_GSS                                : PA=
SS
> >>>SEC2     st_secinfo.testNotDir                                    : RU=
NNING
> >>>SEC2     st_secinfo.testNotDir                                    : PA=
SS
> >>>SEC4     st_secinfo.testNoFh                                      : RU=
NNING
> >>>SEC4     st_secinfo.testNoFh                                      : PA=
SS
> >>>SVFH1    st_savefh.testNoFh                                       : RU=
NNING
> >>>SVFH1    st_savefh.testNoFh                                       : PA=
SS
> >>>SVFH2s   st_restorefh.testValidSocket                             : RU=
NNING
> >>>SVFH2s   st_restorefh.testValidSocket                             : PA=
SS
> >>>SVFH2a   st_restorefh.testValidLink                               : RU=
NNING
> >>>SVFH2a   st_restorefh.testValidLink                               : PA=
SS
> >>>SVFH2r   st_restorefh.testValidFile                               : RU=
NNING
> >>>SVFH2r   st_restorefh.testValidFile                               : PA=
SS
> >>>SVFH2f   st_restorefh.testValidFifo                               : RU=
NNING
> >>>SVFH2f   st_restorefh.testValidFifo                               : PA=
SS
> >>>SVFH2d   st_restorefh.testValidDir                                : RU=
NNING
> >>>SVFH2d   st_restorefh.testValidDir                                : PA=
SS
> >>>RSFH2    st_restorefh.testNoFh2                                   : RU=
NNING
> >>>RSFH2    st_restorefh.testNoFh2                                   : PA=
SS
> >>>RSFH1    st_restorefh.testNoFh1                                   : RU=
NNING
> >>>RSFH1    st_restorefh.testNoFh1                                   : PA=
SS
> >>>RENEW1   st_renew.testRenew                                       : RU=
NNING
> >>>RENEW1   st_renew.testRenew                                       : PA=
SS
> >>>RENEW3   st_renew.testExpired                                     : RU=
NNING
> >>>Sleeping for 30 seconds:
> >>>Woke up
> >>>RENEW3   st_renew.testExpired                                     : FA=
ILURE
> >>>            nfs4lib.BadCompoundRes: Opening file b'RENEW3-1':
> >>>            operation OP_OPEN should return NFS4_OK, instead got
> >>>            NFS4ERR_DELAY
> >>>RENEW2   st_renew.testBadRenew                                    : RU=
NNING
> >>>RENEW2   st_renew.testBadRenew                                    : PA=
SS
> >>>RNM6     st_rename.testZeroLengthOldname                          : RU=
NNING
> >>>RNM6     st_rename.testZeroLengthOldname                          : PA=
SS
> >>>RNM7     st_rename.testZeroLengthNewname                          : RU=
NNING
> >>>RNM7     st_rename.testZeroLengthNewname                          : PA=
SS
> >>>RNM1s    st_rename.testValidSocket                                : RU=
NNING
> >>>RNM1s    st_rename.testValidSocket                                : PA=
SS
> >>>RNM1a    st_rename.testValidLink                                  : RU=
NNING
> >>>RNM1a    st_rename.testValidLink                                  : PA=
SS
> >>>RNM1r    st_rename.testValidFile                                  : RU=
NNING
> >>>RNM1r    st_rename.testValidFile                                  : PA=
SS
> >>>RNM1f    st_rename.testValidFifo                                  : RU=
NNING
> >>>RNM1f    st_rename.testValidFifo                                  : PA=
SS
> >>>RNM1d    st_rename.testValidDir                                   : RU=
NNING
> >>>RNM1d    st_rename.testValidDir                                   : PA=
SS
> >>>RNM2s    st_rename.testSfhSocket                                  : RU=
NNING
> >>>RNM2s    st_rename.testSfhSocket                                  : PA=
SS
> >>>RNM2a    st_rename.testSfhLink                                    : RU=
NNING
> >>>RNM2a    st_rename.testSfhLink                                    : PA=
SS
> >>>RNM2r    st_rename.testSfhFile                                    : RU=
NNING
> >>>RNM2r    st_rename.testSfhFile                                    : PA=
SS
> >>>RNM2f    st_rename.testSfhFifo                                    : RU=
NNING
> >>>RNM2f    st_rename.testSfhFifo                                    : PA=
SS
> >>>RNM19    st_rename.testSelfRenameFile                             : RU=
NNING
> >>>RNM19    st_rename.testSelfRenameFile                             : PA=
SS
> >>>RNM18    st_rename.testSelfRenameDir                              : RU=
NNING
> >>>RNM18    st_rename.testSelfRenameDir                              : PA=
SS
> >>>RNM5     st_rename.testNonExistent                                : RU=
NNING
> >>>RNM5     st_rename.testNonExistent                                : PA=
SS
> >>>RNM4     st_rename.testNoSfh                                      : RU=
NNING
> >>>RNM4     st_rename.testNoSfh                                      : PA=
SS
> >>>LINKS    st_link.testSupported                                    : RU=
NNING
> >>>LINKS    st_link.testSupported                                    : PA=
SS
> >>>RNM20    st_rename.testLinkRename                                 : RU=
NNING
> >>>RNM20    st_rename.testLinkRename                                 : PA=
SS
> >>>RNM17    st_rename.testFileToFullDir                              : RU=
NNING
> >>>RNM17    st_rename.testFileToFullDir                              : PA=
SS
> >>>RNM15    st_rename.testFileToFile                                 : RU=
NNING
> >>>RNM15    st_rename.testFileToFile                                 : PA=
SS
> >>>RNM14    st_rename.testFileToDir                                  : RU=
NNING
> >>>RNM14    st_rename.testFileToDir                                  : PA=
SS
> >>>RNM10    st_rename.testDotsOldname                                : RU=
NNING
> >>>RNM10    st_rename.testDotsOldname                                : PA=
SS
> >>>RNM11    st_rename.testDotsNewname                                : RU=
NNING
> >>>RNM11    st_rename.testDotsNewname                                : PA=
SS
> >>>RNM12    st_rename.testDirToObj                                   : RU=
NNING
> >>>RNM12    st_rename.testDirToObj                                   : PA=
SS
> >>>RNM16    st_rename.testDirToFullDir                               : RU=
NNING
> >>>RNM16    st_rename.testDirToFullDir                               : PA=
SS
> >>>RNM13    st_rename.testDirToDir                                   : RU=
NNING
> >>>RNM13    st_rename.testDirToDir                                   : PA=
SS
> >>>RNM3s    st_rename.testCfhSocket                                  : RU=
NNING
> >>>RNM3s    st_rename.testCfhSocket                                  : PA=
SS
> >>>RNM3a    st_rename.testCfhLink                                    : RU=
NNING
> >>>RNM3a    st_rename.testCfhLink                                    : PA=
SS
> >>>RNM3r    st_rename.testCfhFile                                    : RU=
NNING
> >>>RNM3r    st_rename.testCfhFile                                    : PA=
SS
> >>>RNM3f    st_rename.testCfhFifo                                    : RU=
NNING
> >>>RNM3f    st_rename.testCfhFifo                                    : PA=
SS
> >>>RM4      st_remove.testZeroLengthTarget                           : RU=
NNING
> >>>RM4      st_remove.testZeroLengthTarget                           : PA=
SS
> >>>RM1s     st_remove.testSocket                                     : RU=
NNING
> >>>RM1s     st_remove.testSocket                                     : PA=
SS
> >>>RM8      st_remove.testNotEmpty                                   : RU=
NNING
> >>>RM8      st_remove.testNotEmpty                                   : PA=
SS
> >>>RM6      st_remove.testNonExistent                                : RU=
NNING
> >>>RM6      st_remove.testNonExistent                                : PA=
SS
> >>>RM3      st_remove.testNoFh                                       : RU=
NNING
> >>>RM3      st_remove.testNoFh                                       : PA=
SS
> >>>RM1a     st_remove.testLink                                       : RU=
NNING
> >>>RM1a     st_remove.testLink                                       : PA=
SS
> >>>RM1r     st_remove.testFile                                       : RU=
NNING
> >>>RM1r     st_remove.testFile                                       : PA=
SS
> >>>RM1f     st_remove.testFifo                                       : RU=
NNING
> >>>RM1f     st_remove.testFifo                                       : PA=
SS
> >>>RM7      st_remove.testDots                                       : RU=
NNING
> >>>RM7      st_remove.testDots                                       : PA=
SS
> >>>RM1d     st_remove.testDir                                        : RU=
NNING
> >>>RM1d     st_remove.testDir                                        : PA=
SS
> >>>RM2s     st_remove.testCfhSocket                                  : RU=
NNING
> >>>RM2s     st_remove.testCfhSocket                                  : PA=
SS
> >>>RM2a     st_remove.testCfhLink                                    : RU=
NNING
> >>>RM2a     st_remove.testCfhLink                                    : PA=
SS
> >>>RM2r     st_remove.testCfhFile                                    : RU=
NNING
> >>>RM2r     st_remove.testCfhFile                                    : PA=
SS
> >>>RM2f     st_remove.testCfhFifo                                    : RU=
NNING
> >>>RM2f     st_remove.testCfhFifo                                    : PA=
SS
> >>>RLOWN1   st_releaselockowner.testFile                             : RU=
NNING
> >>>RLOWN1   st_releaselockowner.testFile                             : PA=
SS
> >>>RDLK2s   st_readlink.testSocket                                   : RU=
NNING
> >>>RDLK2s   st_readlink.testSocket                                   : PA=
SS
> >>>RDLK1    st_readlink.testReadlink                                 : RU=
NNING
> >>>RDLK1    st_readlink.testReadlink                                 : PA=
SS
> >>>RDLK3    st_readlink.testNoFh                                     : RU=
NNING
> >>>RDLK3    st_readlink.testNoFh                                     : PA=
SS
> >>>RDLK2r   st_readlink.testFile                                     : RU=
NNING
> >>>RDLK2r   st_readlink.testFile                                     : PA=
SS
> >>>RDLK2f   st_readlink.testFifo                                     : RU=
NNING
> >>>RDLK2f   st_readlink.testFifo                                     : PA=
SS
> >>>RDLK2d   st_readlink.testDir                                      : RU=
NNING
> >>>RDLK2d   st_readlink.testDir                                      : PA=
SS
> >>>RDDR9    st_readdir.testWriteOnlyAttributes                       : RU=
NNING
> >>>RDDR9    st_readdir.testWriteOnlyAttributes                       : PA=
SS
> >>>RDDR12   st_readdir.testUnaccessibleDirAttrs                      : RU=
NNING
> >>>RDDR12   st_readdir.testUnaccessibleDirAttrs                      : PA=
SS
> >>>RDDR11   st_readdir.testUnaccessibleDir                           : RU=
NNING
> >>>RDDR11   st_readdir.testUnaccessibleDir                           : PA=
SS
> >>>RDDR4    st_readdir.testSubsequent                                : RU=
NNING
> >>>RDDR4    st_readdir.testSubsequent                                : PA=
SS
> >>>RDDR10   st_readdir.testReservedCookies                           : RU=
NNING
> >>>RDDR10   st_readdir.testReservedCookies                           : PA=
SS
> >>>RDDR6    st_readdir.testNoFh                                      : RU=
NNING
> >>>RDDR6    st_readdir.testNoFh                                      : PA=
SS
> >>>RDDR7    st_readdir.testMaxcountZero                              : RU=
NNING
> >>>RDDR7    st_readdir.testMaxcountZero                              : PA=
SS
> >>>RDDR8    st_readdir.testMaxcountSmall                             : RU=
NNING
> >>>RDDR8    st_readdir.testMaxcountSmall                             : PA=
SS
> >>>RDDR2    st_readdir.testFirst                                     : RU=
NNING
> >>>RDDR2    st_readdir.testFirst                                     : PA=
SS
> >>>RDDR5s   st_readdir.testFhSocket                                  : RU=
NNING
> >>>RDDR5s   st_readdir.testFhSocket                                  : PA=
SS
> >>>RDDR5a   st_readdir.testFhLink                                    : RU=
NNING
> >>>RDDR5a   st_readdir.testFhLink                                    : PA=
SS
> >>>RDDR5r   st_readdir.testFhFile                                    : RU=
NNING
> >>>RDDR5r   st_readdir.testFhFile                                    : PA=
SS
> >>>RDDR5f   st_readdir.testFhFifo                                    : RU=
NNING
> >>>RDDR5f   st_readdir.testFhFifo                                    : PA=
SS
> >>>RDDR1    st_readdir.testEmptyDir                                  : RU=
NNING
> >>>RDDR1    st_readdir.testEmptyDir                                  : PA=
SS
> >>>RDDR8b   st_readdir.testDircountVarious                           : RU=
NNING
> >>>RDDR8b   st_readdir.testDircountVarious                           : PA=
SS
> >>>RDDR3    st_readdir.testAttr                                      : RU=
NNING
> >>>RDDR3    st_readdir.testAttr                                      : PA=
SS
> >>>RD6      st_read.testZeroCount                                    : RU=
NNING
> >>>RD6      st_read.testZeroCount                                    : PA=
SS
> >>>RD3      st_read.testWithOpen                                     : RU=
NNING
> >>>RD3      st_read.testWithOpen                                     : PA=
SS
> >>>RD2      st_read.testStateidOnes                                  : RU=
NNING
> >>>RD2      st_read.testStateidOnes                                  : PA=
SS
> >>>RD10     st_read.testStaleStateid                                 : RU=
NNING
> >>>RD10     st_read.testStaleStateid                                 : PA=
SS
> >>>RD7s     st_read.testSocket                                       : RU=
NNING
> >>>RD7s     st_read.testSocket                                       : PA=
SS
> >>>RD1      st_read.testSimpleRead                                   : RU=
NNING
> >>>RD1      st_read.testSimpleRead                                   : PA=
SS
> >>>RD11     st_read.testOldStateid                                   : RU=
NNING
> >>>RD11     st_read.testOldStateid                                   : PA=
SS
> >>>RD8      st_read.testNoFh                                         : RU=
NNING
> >>>RD8      st_read.testNoFh                                         : PA=
SS
> >>>RD7a     st_read.testLink                                         : RU=
NNING
> >>>RD7a     st_read.testLink                                         : PA=
SS
> >>>RD5      st_read.testLargeOffset                                  : RU=
NNING
> >>>RD5      st_read.testLargeOffset                                  : PA=
SS
> >>>RD7f     st_read.testFifo                                         : RU=
NNING
> >>>RD7f     st_read.testFifo                                         : PA=
SS
> >>>RD7d     st_read.testDir                                          : RU=
NNING
> >>>RD7d     st_read.testDir                                          : PA=
SS
> >>>ROOT1    st_putrootfh.testSupported                               : RU=
NNING
> >>>ROOT1    st_putrootfh.testSupported                               : PA=
SS
> >>>PUB1     st_putpubfh.testSupported                                : RU=
NNING
> >>>PUB1     st_putpubfh.testSupported                                : PA=
SS
> >>>PUB2     st_putpubfh.testSameAsRoot                               : RU=
NNING
> >>>PUB2     st_putpubfh.testSameAsRoot                               : PA=
SS
> >>>PUTFH1s  st_putfh.testSocket                                      : RU=
NNING
> >>>PUTFH1s  st_putfh.testSocket                                      : PA=
SS
> >>>PUTFH1a  st_putfh.testLink                                        : RU=
NNING
> >>>PUTFH1a  st_putfh.testLink                                        : PA=
SS
> >>>PUTFH1r  st_putfh.testFile                                        : RU=
NNING
> >>>PUTFH1r  st_putfh.testFile                                        : PA=
SS
> >>>PUTFH1f  st_putfh.testFifo                                        : RU=
NNING
> >>>PUTFH1f  st_putfh.testFifo                                        : PA=
SS
> >>>PUTFH1d  st_putfh.testDir                                         : RU=
NNING
> >>>PUTFH1d  st_putfh.testDir                                         : PA=
SS
> >>>PUTFH2   st_putfh.testBadHandle                                   : RU=
NNING
> >>>PUTFH2   st_putfh.testBadHandle                                   : PA=
SS
> >>>OPDG6    st_opendowngrade.testStaleStateid                        : RU=
NNING
> >>>OPDG6    st_opendowngrade.testStaleStateid                        : PA=
SS
> >>>OPDG1    st_opendowngrade.testRegularOpen                         : RU=
NNING
> >>>OPDG1    st_opendowngrade.testRegularOpen                         : PA=
SS
> >>>OPDG10   st_opendowngrade.testOpenDowngradeSequence               : RU=
NNING
> >>>OPDG10   st_opendowngrade.testOpenDowngradeSequence               : PA=
SS
> >>>OPDG11   st_opendowngrade.testOpenDowngradeLock                   : RU=
NNING
> >>>OPDG11   st_opendowngrade.testOpenDowngradeLock                   : PA=
SS
> >>>OPDG7    st_opendowngrade.testOldStateid                          : RU=
NNING
> >>>OPDG7    st_opendowngrade.testOldStateid                          : PA=
SS
> >>>OPDG8    st_opendowngrade.testNoFh                                : RU=
NNING
> >>>OPDG8    st_opendowngrade.testNoFh                                : PA=
SS
> >>>OPDG3    st_opendowngrade.testNewState2                           : RU=
NNING
> >>>OPDG3    st_opendowngrade.testNewState2                           : PA=
SS
> >>>OPDG2    st_opendowngrade.testNewState1                           : RU=
NNING
> >>>OPDG2    st_opendowngrade.testNewState1                           : PA=
SS
> >>>OPDG5    st_opendowngrade.testBadStateid                          : RU=
NNING
> >>>OPDG5    st_opendowngrade.testBadStateid                          : PA=
SS
> >>>OPDG4    st_opendowngrade.testBadSeqid                            : RU=
NNING
> >>>OPDG4    st_opendowngrade.testBadSeqid                            : PA=
SS
> >>>OPCF6    st_openconfirm.testStaleStateid                          : RU=
NNING
> >>>OPCF6    st_openconfirm.testStaleStateid                          : PA=
SS
> >>>OPCF2    st_openconfirm.testNoFh                                  : RU=
NNING
> >>>OPCF2    st_openconfirm.testNoFh                                  : PA=
SS
> >>>OPCF1    st_openconfirm.testConfirmCreate                         : RU=
NNING
> >>>OPCF1    st_openconfirm.testConfirmCreate                         : PA=
SS
> >>>OPCF5    st_openconfirm.testBadStateid                            : RU=
NNING
> >>>OPCF5    st_openconfirm.testBadStateid                            : PA=
SS
> >>>OPCF4    st_openconfirm.testBadSeqid                              : RU=
NNING
> >>>OPCF4    st_openconfirm.testBadSeqid                              : PA=
SS
> >>>OPEN10   st_open.testZeroLenName                                  : RU=
NNING
> >>>OPEN10   st_open.testZeroLenName                                  : PA=
SS
> >>>OPEN29   st_open.testUpgrades                                     : RU=
NNING
> >>>OPEN29   st_open.testUpgrades                                     : PA=
SS
> >>>OPEN15   st_open.testUnsupportedAttributes                        : RU=
NNING
> >>>OPEN15   st_open.testUnsupportedAttributes                        : PA=
SS
> >>>OPEN7s   st_open.testSocket                                       : RU=
NNING
> >>>OPEN7s   st_open.testSocket                                       : PA=
SS
> >>>OPEN18   st_open.testShareConflict1                               : RU=
NNING
> >>>OPEN18   st_open.testShareConflict1                               : PA=
SS
> >>>OPEN30   st_open.testReplay                                       : RU=
NNING
> >>>OPEN30   st_open.testReplay                                       : PA=
SS
> >>>OPEN6    st_open.testOpenVaporFile                                : RU=
NNING
> >>>OPEN6    st_open.testOpenVaporFile                                : PA=
SS
> >>>OPEN5    st_open.testOpenFile                                     : RU=
NNING
> >>>OPEN5    st_open.testOpenFile                                     : PA=
SS
> >>>OPEN12   st_open.testNotDir                                       : RU=
NNING
> >>>OPEN12   st_open.testNotDir                                       : PA=
SS
> >>>OPEN8    st_open.testNoFh                                         : RU=
NNING
> >>>OPEN8    st_open.testNoFh                                         : PA=
SS
> >>>OPEN17   st_open.testModeChange                                   : RU=
NNING
> >>>OPEN17   st_open.testModeChange                                   : PA=
SS
> >>>OPEN11   st_open.testLongName                                     : RU=
NNING
> >>>OPEN11   st_open.testLongName                                     : PA=
SS
> >>>OPEN7a   st_open.testLink                                         : RU=
NNING
> >>>OPEN7a   st_open.testLink                                         : PA=
SS
> >>>OPEN14   st_open.testInvalidAttrmask                              : RU=
NNING
> >>>OPEN14   st_open.testInvalidAttrmask                              : PA=
SS
> >>>OPEN7f   st_open.testFifo                                         : RU=
NNING
> >>>OPEN7f   st_open.testFifo                                         : PA=
SS
> >>>OPEN20   st_open.testFailedOpen                                   : RU=
NNING
> >>>OPEN20   st_open.testFailedOpen                                   : PA=
SS
> >>>OPEN7d   st_open.testDir                                          : RU=
NNING
> >>>OPEN7d   st_open.testDir                                          : PA=
SS
> >>>OPEN28   st_open.testDenyWrite4                                   : RU=
NNING
> >>>OPEN28   st_open.testDenyWrite4                                   : PA=
SS
> >>>OPEN27   st_open.testDenyWrite3                                   : RU=
NNING
> >>>OPEN27   st_open.testDenyWrite3                                   : PA=
SS
> >>>OPEN26   st_open.testDenyWrite2                                   : RU=
NNING
> >>>OPEN26   st_open.testDenyWrite2                                   : PA=
SS
> >>>OPEN25   st_open.testDenyWrite1                                   : RU=
NNING
> >>>OPEN25   st_open.testDenyWrite1                                   : PA=
SS
> >>>OPEN24   st_open.testDenyRead4                                    : RU=
NNING
> >>>OPEN24   st_open.testDenyRead4                                    : PA=
SS
> >>>OPEN23b  st_open.testDenyRead3a                                   : RU=
NNING
> >>>OPEN23b  st_open.testDenyRead3a                                   : PA=
SS
> >>>OPEN23   st_open.testDenyRead3                                    : RU=
NNING
> >>>OPEN23   st_open.testDenyRead3                                    : PA=
SS
> >>>OPEN22   st_open.testDenyRead2                                    : RU=
NNING
> >>>OPEN22   st_open.testDenyRead2                                    : PA=
SS
> >>>OPEN21   st_open.testDenyRead1                                    : RU=
NNING
> >>>OPEN21   st_open.testDenyRead1                                    : PA=
SS
> >>>OPEN2    st_open.testCreateUncheckedFile                          : RU=
NNING
> >>>OPEN2    st_open.testCreateUncheckedFile                          : PA=
SS
> >>>OPEN3    st_open.testCreatGuardedFile                             : RU=
NNING
> >>>OPEN3    st_open.testCreatGuardedFile                             : PA=
SS
> >>>OPEN4    st_open.testCreatExclusiveFile                           : RU=
NNING
> >>>OPEN4    st_open.testCreatExclusiveFile                           : PA=
SS
> >>>OPEN16   st_open.testClaimPrev                                    : RU=
NNING
> >>>OPEN16   st_open.testClaimPrev                                    : PA=
SS
> >>>OPEN31   st_open.testBadSeqid                                     : RU=
NNING
> >>>OPEN31   st_open.testBadSeqid                                     : PA=
SS
> >>>NVF5s    st_nverify.testWriteOnlySocket                           : RU=
NNING
> >>>NVF5s    st_nverify.testWriteOnlySocket                           : PA=
SS
> >>>NVF5a    st_nverify.testWriteOnlyLink                             : RU=
NNING
> >>>NVF5a    st_nverify.testWriteOnlyLink                             : PA=
SS
> >>>NVF5r    st_nverify.testWriteOnlyFile                             : RU=
NNING
> >>>NVF5r    st_nverify.testWriteOnlyFile                             : PA=
SS
> >>>NVF5f    st_nverify.testWriteOnlyFifo                             : RU=
NNING
> >>>NVF5f    st_nverify.testWriteOnlyFifo                             : PA=
SS
> >>>Traceback (most recent call last):
> >>>   File "/root/pynfs/nfs4.0/lib/testmod.py", line 234, in run
> >>>     self.runtest(self, environment)
> >>>   File "/root/pynfs/nfs4.0/servertests/st_locku.py", line 266, in tes=
tTimedoutUnlock
> >>>     c2.open_confirm(t.word(), access=3DOPEN4_SHARE_ACCESS_WRITE)
> >>>   File "/root/pynfs/nfs4.0/nfs4lib.py", line 727, in open_confirm
> >>>     check_result(res, "Opening file %s" % _getname(owner, path))
> >>>   File "/root/pynfs/nfs4.0/nfs4lib.py", line 895, in check_result
> >>>     raise BadCompoundRes(resop, res.status, msg)
> >>>nfs4lib.BadCompoundRes: Opening file b'LKU10-1': operation OP_OPEN sho=
uld return NFS4_OK, instead got NFS4ERR_DELAY
> >>>NVF5d    st_nverify.testWriteOnlyDir                              : RU=
NNING
> >>>NVF5d    st_nverify.testWriteOnlyDir                              : PA=
SS
> >>>NVF7s    st_nverify.testUnsupportedSocket                         : RU=
NNING
> >>>NVF7s    st_nverify.testUnsupportedSocket                         : PA=
SS
> >>>NVF7a    st_nverify.testUnsupportedLink                           : RU=
NNING
> >>>NVF7a    st_nverify.testUnsupportedLink                           : PA=
SS
> >>>NVF7r    st_nverify.testUnsupportedFile                           : RU=
NNING
> >>>NVF7r    st_nverify.testUnsupportedFile                           : PA=
SS
> >>>NVF7f    st_nverify.testUnsupportedFifo                           : RU=
NNING
> >>>NVF7f    st_nverify.testUnsupportedFifo                           : PA=
SS
> >>>NVF7d    st_nverify.testUnsupportedDir                            : RU=
NNING
> >>>NVF7d    st_nverify.testUnsupportedDir                            : PA=
SS
> >>>NVF2s    st_nverify.testTypeSocket                                : RU=
NNING
> >>>NVF2s    st_nverify.testTypeSocket                                : PA=
SS
> >>>NVF2a    st_nverify.testTypeLink                                  : RU=
NNING
> >>>NVF2a    st_nverify.testTypeLink                                  : PA=
SS
> >>>NVF2r    st_nverify.testTypeFile                                  : RU=
NNING
> >>>NVF2r    st_nverify.testTypeFile                                  : PA=
SS
> >>>NVF2f    st_nverify.testTypeFifo                                  : RU=
NNING
> >>>NVF2f    st_nverify.testTypeFifo                                  : PA=
SS
> >>>NVF2d    st_nverify.testTypeDir                                   : RU=
NNING
> >>>NVF2d    st_nverify.testTypeDir                                   : PA=
SS
> >>>NVF4     st_nverify.testNoFh                                      : RU=
NNING
> >>>NVF4     st_nverify.testNoFh                                      : PA=
SS
> >>>NVF1s    st_nverify.testMandSocket                                : RU=
NNING
> >>>NVF1s    st_nverify.testMandSocket                                : PA=
SS
> >>>NVF1a    st_nverify.testMandLink                                  : RU=
NNING
> >>>NVF1a    st_nverify.testMandLink                                  : PA=
SS
> >>>NVF1r    st_nverify.testMandFile                                  : RU=
NNING
> >>>NVF1r    st_nverify.testMandFile                                  : PA=
SS
> >>>NVF1f    st_nverify.testMandFifo                                  : RU=
NNING
> >>>NVF1f    st_nverify.testMandFifo                                  : PA=
SS
> >>>NVF1d    st_nverify.testMandDir                                   : RU=
NNING
> >>>NVF1d    st_nverify.testMandDir                                   : PA=
SS
> >>>NVF3s    st_nverify.testBadSizeSocket                             : RU=
NNING
> >>>NVF3s    st_nverify.testBadSizeSocket                             : PA=
SS
> >>>NVF3a    st_nverify.testBadSizeLink                               : RU=
NNING
> >>>NVF3a    st_nverify.testBadSizeLink                               : PA=
SS
> >>>NVF3r    st_nverify.testBadSizeFile                               : RU=
NNING
> >>>NVF3r    st_nverify.testBadSizeFile                               : PA=
SS
> >>>NVF3f    st_nverify.testBadSizeFifo                               : RU=
NNING
> >>>NVF3f    st_nverify.testBadSizeFifo                               : PA=
SS
> >>>NVF3d    st_nverify.testBadSizeDir                                : RU=
NNING
> >>>NVF3d    st_nverify.testBadSizeDir                                : PA=
SS
> >>>LOOKP2s  st_lookupp.testSock                                      : RU=
NNING
> >>>LOOKP2s  st_lookupp.testSock                                      : PA=
SS
> >>>LOOKP4   st_lookupp.testNoFh                                      : RU=
NNING
> >>>LOOKP4   st_lookupp.testNoFh                                      : PA=
SS
> >>>LOOKP2a  st_lookupp.testLink                                      : RU=
NNING
> >>>LOOKP2a  st_lookupp.testLink                                      : PA=
SS
> >>>LOOKP2r  st_lookupp.testFile                                      : RU=
NNING
> >>>LOOKP2r  st_lookupp.testFile                                      : PA=
SS
> >>>LOOKP2f  st_lookupp.testFifo                                      : RU=
NNING
> >>>LOOKP2f  st_lookupp.testFifo                                      : PA=
SS
> >>>LOOKP1   st_lookupp.testDir                                       : RU=
NNING
> >>>LOOKP1   st_lookupp.testDir                                       : PA=
SS
> >>>LOOKP3   st_lookupp.testAtRoot                                    : RU=
NNING
> >>>LOOKP3   st_lookupp.testAtRoot                                    : PA=
SS
> >>>LOOK3    st_lookup.testZeroLength                                 : RU=
NNING
> >>>LOOK3    st_lookup.testZeroLength                                 : PA=
SS
> >>>LOOK9    st_lookup.testUnaccessibleDir                            : RU=
NNING
> >>>LOOK9    st_lookup.testUnaccessibleDir                            : PA=
SS
> >>>LOOK5a   st_lookup.testSymlinkNotDir                              : RU=
NNING
> >>>LOOK5a   st_lookup.testSymlinkNotDir                              : PA=
SS
> >>>LOOK5s   st_lookup.testSocketNotDir                               : RU=
NNING
> >>>LOOK5s   st_lookup.testSocketNotDir                               : PA=
SS
> >>>LOOK2    st_lookup.testNonExistent                                : RU=
NNING
> >>>LOOK2    st_lookup.testNonExistent                                : PA=
SS
> >>>LOOK6    st_lookup.testNonAccessable                              : RU=
NNING
> >>>LOOK6    st_lookup.testNonAccessable                              : PA=
SS
> >>>LOOK1    st_lookup.testNoFh                                       : RU=
NNING
> >>>LOOK1    st_lookup.testNoFh                                       : PA=
SS
> >>>LOOK4    st_lookup.testLongName                                   : RU=
NNING
> >>>LOOK4    st_lookup.testLongName                                   : PA=
SS
> >>>LOOK5r   st_lookup.testFileNotDir                                 : RU=
NNING
> >>>LOOK5r   st_lookup.testFileNotDir                                 : PA=
SS
> >>>LOOK5f   st_lookup.testFifoNotDir                                 : RU=
NNING
> >>>LOOK5f   st_lookup.testFifoNotDir                                 : PA=
SS
> >>>LOOK8    st_lookup.testDots                                       : RU=
NNING
> >>>LOOK8    st_lookup.testDots                                       : PA=
SS
> >>>LOOK10   st_lookup.testBadOpaque                                  : RU=
NNING
> >>>LOOK10   st_lookup.testBadOpaque                                  : PA=
SS
> >>>LKU3     st_locku.testZeroLen                                     : RU=
NNING
> >>>LKU3     st_locku.testZeroLen                                     : PA=
SS
> >>>LKUNONE  st_locku.testUnlocked                                    : RU=
NNING
> >>>LKUNONE  st_locku.testUnlocked                                    : PA=
SS
> >>>LKU10    st_locku.testTimedoutUnlock                              : RU=
NNING
> >>>Sleeping for 22 seconds:
> >>>Woke up
> >>>LKU10    st_locku.testTimedoutUnlock                              : FA=
ILURE
> >>>            nfs4lib.BadCompoundRes: Opening file b'LKU10-1':
> >>>            operation OP_OPEN should return NFS4_OK, instead got
> >>>            NFS4ERR_DELAY
> >>>LKU9     st_locku.testStaleLockStateid                            : RU=
NNING
> >>>LKU9     st_locku.testStaleLockStateid                            : PA=
SS
> >>>LKUSPLIT st_locku.testSplit                                       : RU=
NNING
> >>>LKUSPLIT st_locku.testSplit                                       : PA=
SS
> >>>LKUOVER  st_locku.testOverlap                                     : RU=
NNING
> >>>LKUOVER  st_locku.testOverlap                                     : PA=
SS
> >>>LKU7     st_locku.testOldLockStateid                              : RU=
NNING
> >>>LKU7     st_locku.testOldLockStateid                              : PA=
SS
> >>>LKU5     st_locku.testNoFh                                        : RU=
NNING
> >>>LKU5     st_locku.testNoFh                                        : PA=
SS
> >>>LKU4     st_locku.testLenTooLong                                  : RU=
NNING
> >>>LKU4     st_locku.testLenTooLong                                  : PA=
SS
> >>>LOCK1    st_lock.testFile                                         : RU=
NNING
> >>>LOCK1    st_lock.testFile                                         : PA=
SS
> >>>LKU1     st_locku.testFile                                        : RU=
NNING
> >>>LKU1     st_locku.testFile                                        : PA=
SS
> >>>LKU8     st_locku.testBadLockStateid                              : RU=
NNING
> >>>LKU8     st_locku.testBadLockStateid                              : PA=
SS
> >>>LKU6b    st_locku.testBadLockSeqid2                               : RU=
NNING
> >>>LKU6b    st_locku.testBadLockSeqid2                               : PA=
SS
> >>>LKU6     st_locku.testBadLockSeqid                                : RU=
NNING
> >>>LKU6     st_locku.testBadLockSeqid                                : PA=
SS
> >>>LOCKRNG  st_lock.test32bitRange                                   : RU=
NNING
> >>>LOCKRNG  st_lock.test32bitRange                                   : PA=
SS
> >>>LKU2     st_locku.test32bitRange                                  : RU=
NNING
> >>>LKU2     st_locku.test32bitRange                                  : PA=
SS
> >>>LKT6     st_lockt.testZeroLen                                     : RU=
NNING
> >>>LKT6     st_lockt.testZeroLen                                     : PA=
SS
> >>>LKT1     st_lockt.testUnlockedFile                                : RU=
NNING
> >>>LKT1     st_lockt.testUnlockedFile                                : PA=
SS
> >>>LKT9     st_lockt.testStaleClientid                               : RU=
NNING
> >>>LKT9     st_lockt.testStaleClientid                               : PA=
SS
> >>>LKT2s    st_lockt.testSocket                                      : RU=
NNING
> >>>LKT2s    st_lockt.testSocket                                      : PA=
SS
> >>>LKT4     st_lockt.testPartialLockedFile2                          : RU=
NNING
> >>>LKT4     st_lockt.testPartialLockedFile2                          : PA=
SS
> >>>LKT3     st_lockt.testPartialLockedFile1                          : RU=
NNING
> >>>LKT3     st_lockt.testPartialLockedFile1                          : PA=
SS
> >>>LKTOVER  st_lockt.testOverlap                                     : RU=
NNING
> >>>LKTOVER  st_lockt.testOverlap                                     : PA=
SS
> >>>LKT8     st_lockt.testNoFh                                        : RU=
NNING
> >>>LKT8     st_lockt.testNoFh                                        : PA=
SS
> >>>LKT2a    st_lockt.testLink                                        : RU=
NNING
> >>>LKT2a    st_lockt.testLink                                        : PA=
SS
> >>>LKT7     st_lockt.testLenTooLong                                  : RU=
NNING
> >>>LKT7     st_lockt.testLenTooLong                                  : PA=
SS
> >>>LKT2f    st_lockt.testFifo                                        : RU=
NNING
> >>>LKT2f    st_lockt.testFifo                                        : PA=
SS
> >>>LKT2d    st_lockt.testDir                                         : RU=
NNING
> >>>LKT2d    st_lockt.testDir                                         : PA=
SS
> >>>LKT5     st_lockt.test32bitRange                                  : RU=
NNING
> >>>LKT5     st_lockt.test32bitRange                                  : PA=
SS
> >>>LOCK5    st_lock.testZeroLen                                      : RU=
NNING
> >>>LOCK5    st_lock.testZeroLen                                      : PA=
SS
> >>>LOCKCHGU st_lock.testUpgrade                                      : RU=
NNING
> >>>LOCKCHGU st_lock.testUpgrade                                      : PA=
SS
> >>>LOCK13   st_lock.testTimedoutGrabLock                             : RU=
NNING
> >>>Sleeping for 7 seconds:
> >>>Woke up
> >>>Sleeping for 7 seconds:
> >>>Woke up
> >>>Sleeping for 7 seconds:
> >>>Woke up
> >>>LOCK13   st_lock.testTimedoutGrabLock                             : PA=
SS
> >>>LOCK12b  st_lock.testStaleOpenStateid                             : RU=
NNING
> >>>LOCK12b  st_lock.testStaleOpenStateid                             : PA=
SS
> >>>LOCK12a  st_lock.testStaleLockStateid                             : RU=
NNING
> >>>LOCK12a  st_lock.testStaleLockStateid                             : PA=
SS
> >>>LOCK10   st_lock.testStaleClientid                                : RU=
NNING
> >>>LOCK10   st_lock.testStaleClientid                                : PA=
SS
> >>>LOCK17   st_lock.testReadLocks2                                   : RU=
NNING
> >>>LOCK17   st_lock.testReadLocks2                                   : PA=
SS
> >>>LOCK16   st_lock.testReadLocks1                                   : RU=
NNING
> >>>LOCK16   st_lock.testReadLocks1                                   : PA=
SS
> >>>LOCKMRG  st_lock.testOverlap                                      : RU=
NNING
> >>>LOCKMRG  st_lock.testOverlap                                      : PA=
SS
> >>>LOCK23   st_lock.testOpenDowngradeLock                            : RU=
NNING
> >>>LOCK23   st_lock.testOpenDowngradeLock                            : PA=
SS
> >>>LOCK9c   st_lock.testOldOpenStateid2                              : RU=
NNING
> >>>LOCK9c   st_lock.testOldOpenStateid2                              : PA=
SS
> >>>LOCK9b   st_lock.testOldOpenStateid                               : RU=
NNING
> >>>LOCK9b   st_lock.testOldOpenStateid                               : PA=
SS
> >>>LOCK9a   st_lock.testOldLockStateid                               : RU=
NNING
> >>>LOCK9a   st_lock.testOldLockStateid                               : PA=
SS
> >>>LOCK7    st_lock.testNoFh                                         : RU=
NNING
> >>>LOCK7    st_lock.testNoFh                                         : PA=
SS
> >>>LOCK4    st_lock.testMode                                         : RU=
NNING
> >>>LOCK4    st_lock.testMode                                         : PA=
SS
> >>>LOCK6    st_lock.testLenTooLong                                   : RU=
NNING
> >>>LOCK6    st_lock.testLenTooLong                                   : PA=
SS
> >>>LOCK15   st_lock.testGrabLock2                                    : RU=
NNING
> >>>LOCK15   st_lock.testGrabLock2                                    : PA=
SS
> >>>LOCK14   st_lock.testGrabLock1                                    : RU=
NNING
> >>>LOCK14   st_lock.testGrabLock1                                    : PA=
SS
> >>>LOCK3    st_lock.testExistingFile                                 : RU=
NNING
> >>>LOCK3    st_lock.testExistingFile                                 : PA=
SS
> >>>LOCKCHGD st_lock.testDowngrade                                    : RU=
NNING
> >>>LOCKCHGD st_lock.testDowngrade                                    : PA=
SS
> >>>LOCKHELD st_lock.testClose                                        : RU=
NNING
> >>>LOCKHELD st_lock.testClose                                        : PA=
SS
> >>>LOCK20   st_lock.testBlockTimeout                                 : RU=
NNING
> >>>Sleeping for 7 seconds: Waiting for queued blocking lock to timeout
> >>>Woke up
> >>>Sleeping for 7 seconds: Waiting for queued blocking lock to timeout
> >>>Woke up
> >>>Sleeping for 7 seconds: Waiting for queued blocking lock to timeout
> >>>Woke up
> >>>LOCK20   st_lock.testBlockTimeout                                 : PA=
SS
> >>>LOCK11   st_lock.testBadStateid                                   : RU=
NNING
> >>>LOCK11   st_lock.testBadStateid                                   : PA=
SS
> >>>LOCK8b   st_lock.testBadOpenSeqid                                 : RU=
NNING
> >>>LOCK8b   st_lock.testBadOpenSeqid                                 : PA=
SS
> >>>LOCK8a   st_lock.testBadLockSeqid                                 : RU=
NNING
> >>>LOCK8a   st_lock.testBadLockSeqid                                 : PA=
SS
> >>>LINK6    st_link.testZeroLenName                                  : RU=
NNING
> >>>LINK6    st_link.testZeroLenName                                  : PA=
SS
> >>>LINK1s   st_link.testSocket                                       : RU=
NNING
> >>>LINK1s   st_link.testSocket                                       : PA=
SS
> >>>LINK2    st_link.testNoSfh                                        : RU=
NNING
> >>>LINK2    st_link.testNoSfh                                        : PA=
SS
> >>>LINK3    st_link.testNoCfh                                        : RU=
NNING
> >>>LINK3    st_link.testNoCfh                                        : PA=
SS
> >>>LINK7    st_link.testLongName                                     : RU=
NNING
> >>>LINK7    st_link.testLongName                                     : PA=
SS
> >>>LINK1a   st_link.testLink                                         : RU=
NNING
> >>>LINK1a   st_link.testLink                                         : PA=
SS
> >>>LINK1r   st_link.testFile                                         : RU=
NNING
> >>>LINK1r   st_link.testFile                                         : PA=
SS
> >>>LINK1f   st_link.testFifo                                         : RU=
NNING
> >>>LINK1f   st_link.testFifo                                         : PA=
SS
> >>>LINK5    st_link.testExists                                       : RU=
NNING
> >>>LINK5    st_link.testExists                                       : PA=
SS
> >>>LINK9    st_link.testDots                                         : RU=
NNING
> >>>LINK9    st_link.testDots                                         : PA=
SS
> >>>LINK1d   st_link.testDir                                          : RU=
NNING
> >>>LINK1d   st_link.testDir                                          : PA=
SS
> >>>LINK4s   st_link.testCfhSocket                                    : RU=
NNING
> >>>LINK4s   st_link.testCfhSocket                                    : PA=
SS
> >>>LINK4a   st_link.testCfhLink                                      : RU=
NNING
> >>>LINK4a   st_link.testCfhLink                                      : PA=
SS
> >>>LINK4r   st_link.testCfhFile                                      : RU=
NNING
> >>>LINK4r   st_link.testCfhFile                                      : PA=
SS
> >>>LINK4f   st_link.testCfhFifo                                      : RU=
NNING
> >>>LINK4f   st_link.testCfhFifo                                      : PA=
SS
> >>>GF1s     st_getfh.testSocket                                      : RU=
NNING
> >>>GF1s     st_getfh.testSocket                                      : PA=
SS
> >>>GF9      st_getfh.testNoFh                                        : RU=
NNING
> >>>GF9      st_getfh.testNoFh                                        : PA=
SS
> >>>GF1a     st_getfh.testLink                                        : RU=
NNING
> >>>GF1a     st_getfh.testLink                                        : PA=
SS
> >>>GF1r     st_getfh.testFile                                        : RU=
NNING
> >>>GF1r     st_getfh.testFile                                        : PA=
SS
> >>>GF1f     st_getfh.testFifo                                        : RU=
NNING
> >>>GF1f     st_getfh.testFifo                                        : PA=
SS
> >>>GF1d     st_getfh.testDir                                         : RU=
NNING
> >>>GF1d     st_getfh.testDir                                         : PA=
SS
> >>>GATT3s   st_getattr.testWriteOnlySocket                           : RU=
NNING
> >>>GATT3s   st_getattr.testWriteOnlySocket                           : PA=
SS
> >>>GATT3a   st_getattr.testWriteOnlyLink                             : RU=
NNING
> >>>GATT3a   st_getattr.testWriteOnlyLink                             : PA=
SS
> >>>GATT3r   st_getattr.testWriteOnlyFile                             : RU=
NNING
> >>>GATT3r   st_getattr.testWriteOnlyFile                             : PA=
SS
> >>>GATT3f   st_getattr.testWriteOnlyFifo                             : RU=
NNING
> >>>GATT3f   st_getattr.testWriteOnlyFifo                             : PA=
SS
> >>>GATT3d   st_getattr.testWriteOnlyDir                              : RU=
NNING
> >>>GATT3d   st_getattr.testWriteOnlyDir                              : PA=
SS
> >>>GATT4s   st_getattr.testUnknownAttrSocket                         : RU=
NNING
> >>>GATT4s   st_getattr.testUnknownAttrSocket                         : PA=
SS
> >>>GATT4a   st_getattr.testUnknownAttrLink                           : RU=
NNING
> >>>GATT4a   st_getattr.testUnknownAttrLink                           : PA=
SS
> >>>GATT4r   st_getattr.testUnknownAttrFile                           : RU=
NNING
> >>>GATT4r   st_getattr.testUnknownAttrFile                           : PA=
SS
> >>>GATT4f   st_getattr.testUnknownAttrFifo                           : RU=
NNING
> >>>GATT4f   st_getattr.testUnknownAttrFifo                           : PA=
SS
> >>>GATT4d   st_getattr.testUnknownAttrDir                            : RU=
NNING
> >>>GATT4d   st_getattr.testUnknownAttrDir                            : PA=
SS
> >>>GATT6s   st_getattr.testSupportedSocket                           : RU=
NNING
> >>>GATT6s   st_getattr.testSupportedSocket                           : PA=
SS
> >>>GATT6a   st_getattr.testSupportedLink                             : RU=
NNING
> >>>GATT6a   st_getattr.testSupportedLink                             : PA=
SS
> >>>GATT6r   st_getattr.testSupportedFile                             : RU=
NNING
> >>>GATT6r   st_getattr.testSupportedFile                             : PA=
SS
> >>>GATT6f   st_getattr.testSupportedFifo                             : RU=
NNING
> >>>GATT6f   st_getattr.testSupportedFifo                             : PA=
SS
> >>>GATT6d   st_getattr.testSupportedDir                              : RU=
NNING
> >>>GATT6d   st_getattr.testSupportedDir                              : PA=
SS
> >>>GATT10   st_getattr.testOwnerName                                 : RU=
NNING
> >>>GATT10   st_getattr.testOwnerName                                 : PA=
SS
> >>>GATT2    st_getattr.testNoFh                                      : RU=
NNING
> >>>GATT2    st_getattr.testNoFh                                      : PA=
SS
> >>>GATT1s   st_getattr.testMandSocket                                : RU=
NNING
> >>>GATT1s   st_getattr.testMandSocket                                : PA=
SS
> >>>GATT1a   st_getattr.testMandLink                                  : RU=
NNING
> >>>GATT1a   st_getattr.testMandLink                                  : PA=
SS
> >>>GATT1r   st_getattr.testMandFile                                  : RU=
NNING
> >>>GATT1r   st_getattr.testMandFile                                  : PA=
SS
> >>>GATT1f   st_getattr.testMandFifo                                  : RU=
NNING
> >>>GATT1f   st_getattr.testMandFifo                                  : PA=
SS
> >>>GATT1d   st_getattr.testMandDir                                   : RU=
NNING
> >>>GATT1d   st_getattr.testMandDir                                   : PA=
SS
> >>>GATT9    st_getattr.testLotsofGetattrsFile                        : RU=
NNING
> >>>GATT9    st_getattr.testLotsofGetattrsFile                        : PA=
SS
> >>>GATT7s   st_getattr.testLongSocket                                : RU=
NNING
> >>>GATT7s   st_getattr.testLongSocket                                : PA=
SS
> >>>GATT7a   st_getattr.testLongLink                                  : RU=
NNING
> >>>GATT7a   st_getattr.testLongLink                                  : PA=
SS
> >>>GATT7r   st_getattr.testLongFile                                  : RU=
NNING
> >>>GATT7r   st_getattr.testLongFile                                  : PA=
SS
> >>>GATT7f   st_getattr.testLongFifo                                  : RU=
NNING
> >>>GATT7f   st_getattr.testLongFifo                                  : PA=
SS
> >>>GATT7d   st_getattr.testLongDir                                   : RU=
NNING
> >>>GATT7d   st_getattr.testLongDir                                   : PA=
SS
> >>>GATT8    st_getattr.testFSLocations                               : RU=
NNING
> >>>GATT8    st_getattr.testFSLocations                               : PA=
SS
> >>>GATT5s   st_getattr.testEmptySocket                               : RU=
NNING
> >>>GATT5s   st_getattr.testEmptySocket                               : PA=
SS
> >>>GATT5a   st_getattr.testEmptyLink                                 : RU=
NNING
> >>>GATT5a   st_getattr.testEmptyLink                                 : PA=
SS
> >>>GATT5r   st_getattr.testEmptyFile                                 : RU=
NNING
> >>>GATT5r   st_getattr.testEmptyFile                                 : PA=
SS
> >>>GATT5f   st_getattr.testEmptyFifo                                 : RU=
NNING
> >>>GATT5f   st_getattr.testEmptyFifo                                 : PA=
SS
> >>>GATT5d   st_getattr.testEmptyDir                                  : RU=
NNING
> >>>GATT5d   st_getattr.testEmptyDir                                  : PA=
SS
> >>>CR9a     st_create.testZeroLengthForLNK                           : RU=
NNING
> >>>CR9a     st_create.testZeroLengthForLNK                           : PA=
SS
> >>>CR9      st_create.testZeroLength                                 : RU=
NNING
> >>>CR9      st_create.testZeroLength                                 : PA=
SS
> >>>CR12     st_create.testUnsupportedAttributes                      : RU=
NNING
> >>>CR12     st_create.testUnsupportedAttributes                      : PA=
SS
> >>>CR14     st_create.testSlash                                      : RU=
NNING
> >>>CR14     st_create.testSlash                                      : PA=
SS
> >>>CR10     st_create.testRegularFile                                : RU=
NNING
> >>>CR10     st_create.testRegularFile                                : PA=
SS
> >>>CR8      st_create.testNoFh                                       : RU=
NNING
> >>>CR8      st_create.testNoFh                                       : PA=
SS
> >>>CR15     st_create.testLongName                                   : RU=
NNING
> >>>CR15     st_create.testLongName                                   : PA=
SS
> >>>CR11     st_create.testInvalidAttrmask                            : RU=
NNING
> >>>CR11     st_create.testInvalidAttrmask                            : PA=
SS
> >>>CR13     st_create.testDots                                       : RU=
NNING
> >>>CR13     st_create.testDots                                       : PA=
SS
> >>>CR5      st_create.testDirOffSocket                               : RU=
NNING
> >>>CR5      st_create.testDirOffSocket                               : PA=
SS
> >>>CR2      st_create.testDirOffLink                                 : RU=
NNING
> >>>Traceback (most recent call last):
> >>>   File "/root/pynfs/nfs4.0/lib/testmod.py", line 234, in run
> >>>     self.runtest(self, environment)
> >>>   File "/root/pynfs/nfs4.0/servertests/st_close.py", line 142, in tes=
tTimedoutClose2
> >>>     c2.open_confirm(t.word(), access=3DOPEN4_SHARE_ACCESS_WRITE)
> >>>   File "/root/pynfs/nfs4.0/nfs4lib.py", line 727, in open_confirm
> >>>     check_result(res, "Opening file %s" % _getname(owner, path))
> >>>   File "/root/pynfs/nfs4.0/nfs4lib.py", line 895, in check_result
> >>>     raise BadCompoundRes(resop, res.status, msg)
> >>>nfs4lib.BadCompoundRes: Opening file b'CLOSE9-1': operation OP_OPEN sh=
ould return NFS4_OK, instead got NFS4ERR_DELAY
> >>>Traceback (most recent call last):
> >>>   File "/root/pynfs/nfs4.0/lib/testmod.py", line 234, in run
> >>>     self.runtest(self, environment)
> >>>   File "/root/pynfs/nfs4.0/servertests/st_close.py", line 118, in tes=
tTimedoutClose1
> >>>     c2.open_confirm(t.word(), access=3DOPEN4_SHARE_ACCESS_WRITE)
> >>>   File "/root/pynfs/nfs4.0/nfs4lib.py", line 727, in open_confirm
> >>>     check_result(res, "Opening file %s" % _getname(owner, path))
> >>>   File "/root/pynfs/nfs4.0/nfs4lib.py", line 895, in check_result
> >>>     raise BadCompoundRes(resop, res.status, msg)
> >>>nfs4lib.BadCompoundRes: Opening file b'CLOSE8-1': operation OP_OPEN sh=
ould return NFS4_OK, instead got NFS4ERR_DELAY
> >>>CR2      st_create.testDirOffLink                                 : PA=
SS
> >>>CR7      st_create.testDirOffFile                                 : RU=
NNING
> >>>CR7      st_create.testDirOffFile                                 : PA=
SS
> >>>CR6      st_create.testDirOffFIFO                                 : RU=
NNING
> >>>CR6      st_create.testDirOffFIFO                                 : PA=
SS
> >>>COMP1    st_compound.testZeroOps                                  : RU=
NNING
> >>>COMP1    st_compound.testZeroOps                                  : PA=
SS
> >>>COMP5    st_compound.testUndefined                                : RU=
NNING
> >>>COMP5    st_compound.testUndefined                                : PA=
SS
> >>>COMP6    st_compound.testLongCompound                             : RU=
NNING
> >>>COMP6    st_compound.testLongCompound                             : PA=
SS
> >>>COMP4    st_compound.testInvalidMinor                             : RU=
NNING
> >>>COMP4    st_compound.testInvalidMinor                             : PA=
SS
> >>>COMP2    st_compound.testGoodTag                                  : RU=
NNING
> >>>COMP2    st_compound.testGoodTag                                  : PA=
SS
> >>>CMT2s    st_commit.testSocket                                     : RU=
NNING
> >>>CMT2s    st_commit.testSocket                                     : PA=
SS
> >>>CMT3     st_commit.testNoFh                                       : RU=
NNING
> >>>CMT3     st_commit.testNoFh                                       : PA=
SS
> >>>CMT2a    st_commit.testLink                                       : RU=
NNING
> >>>CMT2a    st_commit.testLink                                       : PA=
SS
> >>>CMT2f    st_commit.testFifo                                       : RU=
NNING
> >>>CMT2f    st_commit.testFifo                                       : PA=
SS
> >>>CMT2d    st_commit.testDir                                        : RU=
NNING
> >>>CMT2d    st_commit.testDir                                        : PA=
SS
> >>>CMT4     st_commit.testCommitOverflow                             : RU=
NNING
> >>>CMT4     st_commit.testCommitOverflow                             : PA=
SS
> >>>CMT1d    st_commit.testCommitOffsetMax2                           : RU=
NNING
> >>>CMT1d    st_commit.testCommitOffsetMax2                           : PA=
SS
> >>>CMT1c    st_commit.testCommitOffsetMax1                           : RU=
NNING
> >>>CMT1c    st_commit.testCommitOffsetMax1                           : PA=
SS
> >>>CMT1b    st_commit.testCommitOffset1                              : RU=
NNING
> >>>CMT1b    st_commit.testCommitOffset1                              : PA=
SS
> >>>CMT1aa   st_commit.testCommitOffset0                              : RU=
NNING
> >>>CMT1aa   st_commit.testCommitOffset0                              : PA=
SS
> >>>CMT1f    st_commit.testCommitCountMax                             : RU=
NNING
> >>>CMT1f    st_commit.testCommitCountMax                             : PA=
SS
> >>>CMT1e    st_commit.testCommitCount1                               : RU=
NNING
> >>>CMT1e    st_commit.testCommitCount1                               : PA=
SS
> >>>CLOSE9   st_close.testTimedoutClose2                              : RU=
NNING
> >>>Sleeping for 30 seconds:
> >>>Woke up
> >>>CLOSE9   st_close.testTimedoutClose2                              : FA=
ILURE
> >>>            nfs4lib.BadCompoundRes: Opening file b'CLOSE9-1':
> >>>            operation OP_OPEN should return NFS4_OK, instead got
> >>>            NFS4ERR_DELAY
> >>>CLOSE8   st_close.testTimedoutClose1                              : RU=
NNING
> >>>Sleeping for 30 seconds:
> >>>Woke up
> >>>CLOSE8   st_close.testTimedoutClose1                              : FA=
ILURE
> >>>            nfs4lib.BadCompoundRes: Opening file b'CLOSE8-1':
> >>>            operation OP_OPEN should return NFS4_OK, instead got
> >>>            NFS4ERR_DELAY
> >>>CLOSE6   st_close.testStaleStateid                                : RU=
NNING
> >>>CLOSE6   st_close.testStaleStateid                                : PA=
SS
> >>>CLOSE12  st_close.testReplaySeqid2                                : RU=
NNING
> >>>CLOSE12  st_close.testReplaySeqid2                                : PA=
SS
> >>>CLOSE10  st_close.testReplaySeqid1                                : RU=
NNING
> >>>CLOSE10  st_close.testReplaySeqid1                                : PA=
SS
> >>>CLOSE5   st_close.testOldStateid                                  : RU=
NNING
> >>>CLOSE5   st_close.testOldStateid                                  : PA=
SS
> >>>CLOSE7   st_close.testNoCfh                                       : RU=
NNING
> >>>CLOSE7   st_close.testNoCfh                                       : PA=
SS
> >>>CLOSE11  st_close.testNextSeqid                                   : RU=
NNING
> >>>CLOSE11  st_close.testNextSeqid                                   : PA=
SS
> >>>CLOSE2   st_close.testCloseOpen                                   : RU=
NNING
> >>>CLOSE2   st_close.testCloseOpen                                   : PA=
SS
> >>>CLOSE1   st_close.testCloseCreate                                 : RU=
NNING
> >>>CLOSE1   st_close.testCloseCreate                                 : PA=
SS
> >>>CLOSE4   st_close.testBadStateid                                  : RU=
NNING
> >>>CLOSE4   st_close.testBadStateid                                  : PA=
SS
> >>>CLOSE3   st_close.testBadSeqid                                    : RU=
NNING
> >>>CLOSE3   st_close.testBadSeqid                                    : PA=
SS
> >>>ACL0     st_acl.testACLsupport                                    : RU=
NNING
> >>>ACL0     st_acl.testACLsupport                                    : PA=
SS
> >>>ACL10    st_acl.testLargeACL                                      : RU=
NNING
> >>>ACL10    st_acl.testLargeACL                                      : PA=
SS
> >>>ACL5     st_acl.testACL                                           : RU=
NNING
> >>>ACL5     st_acl.testACL                                           : PA=
SS
> >>>ACC1s    st_access.testReadSocket                                 : RU=
NNING
> >>>ACC1s    st_access.testReadSocket                                 : PA=
SS
> >>>ACC1a    st_access.testReadLink                                   : RU=
NNING
> >>>ACC1a    st_access.testReadLink                                   : PA=
SS
> >>>ACC1r    st_access.testReadFile                                   : RU=
NNING
> >>>ACC1r    st_access.testReadFile                                   : PA=
SS
> >>>ACC1f    st_access.testReadFifo                                   : RU=
NNING
> >>>ACC1f    st_access.testReadFifo                                   : PA=
SS
> >>>ACC1d    st_access.testReadDir                                    : RU=
NNING
> >>>ACC1d    st_access.testReadDir                                    : PA=
SS
> >>>ACC3     st_access.testNoFh                                       : RU=
NNING
> >>>ACC3     st_access.testNoFh                                       : PA=
SS
> >>>ACC4s    st_access.testInvalidsSocket                             : RU=
NNING
> >>>ACC4s    st_access.testInvalidsSocket                             : PA=
SS
> >>>ACC4a    st_access.testInvalidsLink                               : RU=
NNING
> >>>ACC4a    st_access.testInvalidsLink                               : PA=
SS
> >>>ACC4r    st_access.testInvalidsFile                               : RU=
NNING
> >>>ACC4r    st_access.testInvalidsFile                               : PA=
SS
> >>>ACC4f    st_access.testInvalidsFifo                               : RU=
NNING
> >>>ACC4f    st_access.testInvalidsFifo                               : PA=
SS
> >>>ACC4d    st_access.testInvalidsDir                                : RU=
NNING
> >>>ACC4d    st_access.testInvalidsDir                                : PA=
SS
> >>>ACC2s    st_access.testAllSocket                                  : RU=
NNING
> >>>ACC2s    st_access.testAllSocket                                  : PA=
SS
> >>>ACC2a    st_access.testAllLink                                    : RU=
NNING
> >>>ACC2a    st_access.testAllLink                                    : PA=
SS
> >>>ACC2r    st_access.testAllFile                                    : RU=
NNING
> >>>ACC2r    st_access.testAllFile                                    : PA=
SS
> >>>ACC2f    st_access.testAllFifo                                    : RU=
NNING
> >>>ACC2f    st_access.testAllFifo                                    : PA=
SS
> >>>ACC2d    st_access.testAllDir                                     : RU=
NNING
> >>>ACC2d    st_access.testAllDir                                     : PA=
SS
> >>>**************************************************
> >>>RENEW3   st_renew.testExpired                                     : FA=
ILURE
> >>>            nfs4lib.BadCompoundRes: Opening file b'RENEW3-1':
> >>>            operation OP_OPEN should return NFS4_OK, instead got
> >>>            NFS4ERR_DELAY
> >>>LKU10    st_locku.testTimedoutUnlock                              : FA=
ILURE
> >>>            nfs4lib.BadCompoundRes: Opening file b'LKU10-1':
> >>>            operation OP_OPEN should return NFS4_OK, instead got
> >>>            NFS4ERR_DELAY
> >>>CLOSE9   st_close.testTimedoutClose2                              : FA=
ILURE
> >>>            nfs4lib.BadCompoundRes: Opening file b'CLOSE9-1':
> >>>            operation OP_OPEN should return NFS4_OK, instead got
> >>>            NFS4ERR_DELAY
> >>>CLOSE8   st_close.testTimedoutClose1                              : FA=
ILURE
> >>>            nfs4lib.BadCompoundRes: Opening file b'CLOSE8-1':
> >>>            operation OP_OPEN should return NFS4_OK, instead got
> >>>            NFS4ERR_DELAY
> >>>**************************************************
> >>>Command line asked for 526 of 673 tests
> >>>Of those: 7 Skipped, 4 Failed, 0 Warned, 515 Passed
> >>>root pynfs tests:
> >>>MKCHAR   st_create.testChar                                       : RU=
NNING
> >>>MKCHAR   st_create.testChar                                       : PA=
SS
> >>>WRT6c    st_write.testChar                                        : RU=
NNING
> >>>WRT6c    st_write.testChar                                        : PA=
SS
> >>>MKBLK    st_create.testBlock                                      : RU=
NNING
> >>>MKBLK    st_create.testBlock                                      : PA=
SS
> >>>WRT6b    st_write.testBlock                                       : RU=
NNING
> >>>WRT6b    st_write.testBlock                                       : PA=
SS
> >>>LOOKCHAR st_lookup.testChar                                       : RU=
NNING
> >>>LOOKCHAR st_lookup.testChar                                       : PA=
SS
> >>>VF5c     st_verify.testWriteOnlyChar                              : RU=
NNING
> >>>VF5c     st_verify.testWriteOnlyChar                              : PA=
SS
> >>>LOOKBLK  st_lookup.testBlock                                      : RU=
NNING
> >>>LOOKBLK  st_lookup.testBlock                                      : PA=
SS
> >>>VF5b     st_verify.testWriteOnlyBlock                             : RU=
NNING
> >>>VF5b     st_verify.testWriteOnlyBlock                             : PA=
SS
> >>>VF7c     st_verify.testUnsupportedChar                            : RU=
NNING
> >>>VF7c     st_verify.testUnsupportedChar                            : PA=
SS
> >>>VF7b     st_verify.testUnsupportedBlock                           : RU=
NNING
> >>>VF7b     st_verify.testUnsupportedBlock                           : PA=
SS
> >>>VF2c     st_verify.testTypeChar                                   : RU=
NNING
> >>>VF2c     st_verify.testTypeChar                                   : PA=
SS
> >>>VF2b     st_verify.testTypeBlock                                  : RU=
NNING
> >>>VF2b     st_verify.testTypeBlock                                  : PA=
SS
> >>>VF1c     st_verify.testMandChar                                   : RU=
NNING
> >>>VF1c     st_verify.testMandChar                                   : PA=
SS
> >>>VF1b     st_verify.testMandBlock                                  : RU=
NNING
> >>>VF1b     st_verify.testMandBlock                                  : PA=
SS
> >>>VF3c     st_verify.testBadSizeChar                                : RU=
NNING
> >>>VF3c     st_verify.testBadSizeChar                                : PA=
SS
> >>>VF3b     st_verify.testBadSizeBlock                               : RU=
NNING
> >>>VF3b     st_verify.testBadSizeBlock                               : PA=
SS
> >>>SATT11c  st_setattr.testUnsupportedChar                           : RU=
NNING
> >>>SATT11c  st_setattr.testUnsupportedChar                           : PA=
SS
> >>>SATT11b  st_setattr.testUnsupportedBlock                          : RU=
NNING
> >>>SATT11b  st_setattr.testUnsupportedBlock                          : PA=
SS
> >>>SATT12c  st_setattr.testSizeChar                                  : RU=
NNING
> >>>SATT12c  st_setattr.testSizeChar                                  : PA=
SS
> >>>SATT12b  st_setattr.testSizeBlock                                 : RU=
NNING
> >>>SATT12b  st_setattr.testSizeBlock                                 : PA=
SS
> >>>MKDIR    st_create.testDir                                        : RU=
NNING
> >>>MKDIR    st_create.testDir                                        : PA=
SS
> >>>SATT6d   st_setattr.testReadonlyDir                               : RU=
NNING
> >>>SATT6d   st_setattr.testReadonlyDir                               : PA=
SS
> >>>SATT6c   st_setattr.testReadonlyChar                              : RU=
NNING
> >>>SATT6c   st_setattr.testReadonlyChar                              : PA=
SS
> >>>SATT6b   st_setattr.testReadonlyBlock                             : RU=
NNING
> >>>SATT6b   st_setattr.testReadonlyBlock                             : PA=
SS
> >>>MODE     st_setattr.testMode                                      : RU=
NNING
> >>>MODE     st_setattr.testMode                                      : PA=
SS
> >>>SATT1c   st_setattr.testChar                                      : RU=
NNING
> >>>SATT1c   st_setattr.testChar                                      : PA=
SS
> >>>SATT1b   st_setattr.testBlock                                     : RU=
NNING
> >>>SATT1b   st_setattr.testBlock                                     : PA=
SS
> >>>SVFH2c   st_restorefh.testValidChar                               : RU=
NNING
> >>>SVFH2c   st_restorefh.testValidChar                               : PA=
SS
> >>>SVFH2b   st_restorefh.testValidBlock                              : RU=
NNING
> >>>SVFH2b   st_restorefh.testValidBlock                              : PA=
SS
> >>>RNM1c    st_rename.testValidChar                                  : RU=
NNING
> >>>RNM1c    st_rename.testValidChar                                  : PA=
SS
> >>>RNM1b    st_rename.testValidBlock                                 : RU=
NNING
> >>>RNM1b    st_rename.testValidBlock                                 : PA=
SS
> >>>RNM2c    st_rename.testSfhChar                                    : RU=
NNING
> >>>RNM2c    st_rename.testSfhChar                                    : PA=
SS
> >>>RNM2b    st_rename.testSfhBlock                                   : RU=
NNING
> >>>RNM2b    st_rename.testSfhBlock                                   : PA=
SS
> >>>RNM3c    st_rename.testCfhChar                                    : RU=
NNING
> >>>RNM3c    st_rename.testCfhChar                                    : PA=
SS
> >>>RNM3b    st_rename.testCfhBlock                                   : RU=
NNING
> >>>RNM3b    st_rename.testCfhBlock                                   : PA=
SS
> >>>RM1c     st_remove.testChar                                       : RU=
NNING
> >>>RM1c     st_remove.testChar                                       : PA=
SS
> >>>RM2c     st_remove.testCfhChar                                    : RU=
NNING
> >>>RM2c     st_remove.testCfhChar                                    : PA=
SS
> >>>RM2b     st_remove.testCfhBlock                                   : RU=
NNING
> >>>RM2b     st_remove.testCfhBlock                                   : PA=
SS
> >>>RM1b     st_remove.testBlock                                      : RU=
NNING
> >>>RM1b     st_remove.testBlock                                      : PA=
SS
> >>>RDLK2c   st_readlink.testChar                                     : RU=
NNING
> >>>RDLK2c   st_readlink.testChar                                     : PA=
SS
> >>>RDLK2b   st_readlink.testBlock                                    : RU=
NNING
> >>>RDLK2b   st_readlink.testBlock                                    : PA=
SS
> >>>RDDR5c   st_readdir.testFhChar                                    : RU=
NNING
> >>>RDDR5c   st_readdir.testFhChar                                    : PA=
SS
> >>>RDDR5b   st_readdir.testFhBlock                                   : RU=
NNING
> >>>RDDR5b   st_readdir.testFhBlock                                   : PA=
SS
> >>>RD7c     st_read.testChar                                         : RU=
NNING
> >>>RD7c     st_read.testChar                                         : PA=
SS
> >>>RD7b     st_read.testBlock                                        : RU=
NNING
> >>>RD7b     st_read.testBlock                                        : PA=
SS
> >>>PUTFH1c  st_putfh.testChar                                        : RU=
NNING
> >>>PUTFH1c  st_putfh.testChar                                        : PA=
SS
> >>>PUTFH1b  st_putfh.testBlock                                       : RU=
NNING
> >>>PUTFH1b  st_putfh.testBlock                                       : PA=
SS
> >>>INIT     st_setclientid.testValid                                 : RU=
NNING
> >>>INIT     st_setclientid.testValid                                 : PA=
SS
> >>>OPEN7c   st_open.testChar                                         : RU=
NNING
> >>>OPEN7c   st_open.testChar                                         : PA=
SS
> >>>OPEN7b   st_open.testBlock                                        : RU=
NNING
> >>>OPEN7b   st_open.testBlock                                        : PA=
SS
> >>>NVF5c    st_nverify.testWriteOnlyChar                             : RU=
NNING
> >>>NVF5c    st_nverify.testWriteOnlyChar                             : PA=
SS
> >>>NVF5b    st_nverify.testWriteOnlyBlock                            : RU=
NNING
> >>>NVF5b    st_nverify.testWriteOnlyBlock                            : PA=
SS
> >>>NVF7c    st_nverify.testUnsupportedChar                           : RU=
NNING
> >>>NVF7c    st_nverify.testUnsupportedChar                           : PA=
SS
> >>>NVF7b    st_nverify.testUnsupportedBlock                          : RU=
NNING
> >>>NVF7b    st_nverify.testUnsupportedBlock                          : PA=
SS
> >>>NVF2c    st_nverify.testTypeChar                                  : RU=
NNING
> >>>NVF2c    st_nverify.testTypeChar                                  : PA=
SS
> >>>NVF2b    st_nverify.testTypeBlock                                 : RU=
NNING
> >>>NVF2b    st_nverify.testTypeBlock                                 : PA=
SS
> >>>NVF1c    st_nverify.testMandChar                                  : RU=
NNING
> >>>NVF1c    st_nverify.testMandChar                                  : PA=
SS
> >>>NVF1b    st_nverify.testMandBlock                                 : RU=
NNING
> >>>NVF1b    st_nverify.testMandBlock                                 : PA=
SS
> >>>NVF3c    st_nverify.testBadSizeChar                               : RU=
NNING
> >>>NVF3c    st_nverify.testBadSizeChar                               : PA=
SS
> >>>NVF3b    st_nverify.testBadSizeBlock                              : RU=
NNING
> >>>NVF3b    st_nverify.testBadSizeBlock                              : PA=
SS
> >>>LOOKP2c  st_lookupp.testChar                                      : RU=
NNING
> >>>LOOKP2c  st_lookupp.testChar                                      : PA=
SS
> >>>LOOKP2b  st_lookupp.testBlock                                     : RU=
NNING
> >>>LOOKP2b  st_lookupp.testBlock                                     : PA=
SS
> >>>LOOK5c   st_lookup.testCharNotDir                                 : RU=
NNING
> >>>LOOK5c   st_lookup.testCharNotDir                                 : PA=
SS
> >>>LOOK5b   st_lookup.testBlockNotDir                                : RU=
NNING
> >>>LOOK5b   st_lookup.testBlockNotDir                                : PA=
SS
> >>>LKT2c    st_lockt.testChar                                        : RU=
NNING
> >>>LKT2c    st_lockt.testChar                                        : PA=
SS
> >>>LKT2b    st_lockt.testBlock                                       : RU=
NNING
> >>>LKT2b    st_lockt.testBlock                                       : PA=
SS
> >>>LINKS    st_link.testSupported                                    : RU=
NNING
> >>>LINKS    st_link.testSupported                                    : PA=
SS
> >>>LINK1c   st_link.testChar                                         : RU=
NNING
> >>>LINK1c   st_link.testChar                                         : PA=
SS
> >>>LOOKFILE st_lookup.testFile                                       : RU=
NNING
> >>>LOOKFILE st_lookup.testFile                                       : PA=
SS
> >>>LINK4c   st_link.testCfhChar                                      : RU=
NNING
> >>>LINK4c   st_link.testCfhChar                                      : PA=
SS
> >>>LINK4b   st_link.testCfhBlock                                     : RU=
NNING
> >>>LINK4b   st_link.testCfhBlock                                     : PA=
SS
> >>>LINK1b   st_link.testBlock                                        : RU=
NNING
> >>>LINK1b   st_link.testBlock                                        : PA=
SS
> >>>GF1c     st_getfh.testChar                                        : RU=
NNING
> >>>GF1c     st_getfh.testChar                                        : PA=
SS
> >>>GF1b     st_getfh.testBlock                                       : RU=
NNING
> >>>GF1b     st_getfh.testBlock                                       : PA=
SS
> >>>GATT3c   st_getattr.testWriteOnlyChar                             : RU=
NNING
> >>>GATT3c   st_getattr.testWriteOnlyChar                             : PA=
SS
> >>>GATT3b   st_getattr.testWriteOnlyBlock                            : RU=
NNING
> >>>GATT3b   st_getattr.testWriteOnlyBlock                            : PA=
SS
> >>>GATT4c   st_getattr.testUnknownAttrChar                           : RU=
NNING
> >>>GATT4c   st_getattr.testUnknownAttrChar                           : PA=
SS
> >>>GATT4b   st_getattr.testUnknownAttrBlock                          : RU=
NNING
> >>>GATT4b   st_getattr.testUnknownAttrBlock                          : PA=
SS
> >>>GATT6c   st_getattr.testSupportedChar                             : RU=
NNING
> >>>GATT6c   st_getattr.testSupportedChar                             : PA=
SS
> >>>GATT6b   st_getattr.testSupportedBlock                            : RU=
NNING
> >>>GATT6b   st_getattr.testSupportedBlock                            : PA=
SS
> >>>GATT1c   st_getattr.testMandChar                                  : RU=
NNING
> >>>GATT1c   st_getattr.testMandChar                                  : PA=
SS
> >>>GATT1b   st_getattr.testMandBlock                                 : RU=
NNING
> >>>GATT1b   st_getattr.testMandBlock                                 : PA=
SS
> >>>GATT7c   st_getattr.testLongChar                                  : RU=
NNING
> >>>GATT7c   st_getattr.testLongChar                                  : PA=
SS
> >>>GATT7b   st_getattr.testLongBlock                                 : RU=
NNING
> >>>GATT7b   st_getattr.testLongBlock                                 : PA=
SS
> >>>GATT5c   st_getattr.testEmptyChar                                 : RU=
NNING
> >>>GATT5c   st_getattr.testEmptyChar                                 : PA=
SS
> >>>GATT5b   st_getattr.testEmptyBlock                                : RU=
NNING
> >>>GATT5b   st_getattr.testEmptyBlock                                : PA=
SS
> >>>CR4      st_create.testDirOffChar                                 : RU=
NNING
> >>>CR4      st_create.testDirOffChar                                 : PA=
SS
> >>>CR3      st_create.testDirOffBlock                                : RU=
NNING
> >>>CR3      st_create.testDirOffBlock                                : PA=
SS
> >>>CMT2c    st_commit.testChar                                       : RU=
NNING
> >>>CMT2c    st_commit.testChar                                       : PA=
SS
> >>>CMT2b    st_commit.testBlock                                      : RU=
NNING
> >>>CMT2b    st_commit.testBlock                                      : PA=
SS
> >>>ACC1c    st_access.testReadChar                                   : RU=
NNING
> >>>ACC1c    st_access.testReadChar                                   : PA=
SS
> >>>ACC1b    st_access.testReadBlock                                  : RU=
NNING
> >>>ACC1b    st_access.testReadBlock                                  : PA=
SS
> >>>ACC4c    st_access.testInvalidsChar                               : RU=
NNING
> >>>ACC4c    st_access.testInvalidsChar                               : PA=
SS
> >>>ACC4b    st_access.testInvalidsBlock                              : RU=
NNING
> >>>ACC4b    st_access.testInvalidsBlock                              : PA=
SS
> >>>ACC2c    st_access.testAllChar                                    : RU=
NNING
> >>>ACC2c    st_access.testAllChar                                    : PA=
SS
> >>>ACC2b    st_access.testAllBlock                                   : RU=
NNING
> >>>ACC2b    st_access.testAllBlock                                   : PA=
SS
> >>>**************************************************
> >>>**************************************************
> >>>Command line asked for 96 of 673 tests
> >>>Of those: 0 Skipped, 0 Failed, 0 Warned, 96 Passed
> >>>INFO   :rpc.poll:got connection from ('127.0.0.1', 51342), assigned to=
 fd=3D5
> >>>INFO   :rpc.thread:Called connect(('test1.fieldses.org', 2049))
> >>>INFO   :rpc.poll:Adding 6 generated by another thread
> >>>INFO   :test.env:Created client to test1.fieldses.org, 2049
> >>>INFO   :test.env:Called do_readdir()
> >>>INFO   :test.env:do_readdir() =3D [entry4(cookie=3D14, name=3Db'dir', =
attrs=3D{}), entry4(cookie=3D17, name=3Db'socket', attrs=3D{}), entry4(cook=
ie=3D19, name=3Db'fifo', attrs=3D{}), entry4(cookie=3D21, name=3Db'link', a=
ttrs=3D{}), entry4(cookie=3D24, name=3Db'block', attrs=3D{}), entry4(cookie=
=3D26, name=3Db'char', attrs=3D{}), entry4(cookie=3D512, name=3Db'file', at=
trs=3D{})]
> >>>INFO   :test.env:Called do_readdir()
> >>>INFO   :test.env:do_readdir() =3D []
> >>>INFO   :test.env:client 1 creates file OK
> >>>
> >>>INFO   :test.env:client 2 open file OK
> >>>
> >>>INFO   :test.env:force lease to expire...
> >>>
> >>>INFO   :test.env:Sleeping for 25 seconds: the lease period + 10 secs
> >>>INFO   :test.env:Woke up
> >>>INFO   :test.env:3rd client open OK - PASSED
> >>>
> >>>INFO   :test.env:client 1 creates file OK
> >>>
> >>>INFO   :test.env:force lease to expire...
> >>>
> >>>INFO   :test.env:Sleeping for 25 seconds: the lease period + 10 secs
> >>>INFO   :test.env:Woke up
> >>>INFO   :test.env:2nd client open OK - PASSED
> >>>
> >>>INFO   :test.env:2nd client open OK - PASSED
> >>>
> >>>INFO   :test.env:local open conflict detected - PASSED
> >>>
> >>>INFO   :test.env:2nd client open conflict detected - PASSED
> >>>
> >>>INFO   :test.env:force lease to expire...
> >>>
> >>>INFO   :test.env:Sleeping for 25 seconds: the lease period + 10 secs
> >>>INFO   :test.env:Woke up
> >>>INFO   :test.env:3nd client opened OK - no conflict detected - PASSED
> >>>
> >>>INFO   :test.env:Sleeping for 25 seconds: the lease period + 10 secs
> >>>INFO   :test.env:Woke up
> >>>INFO   :rpc.poll:Closing 6
> >>>INFO   :rpc.thread:Called connect(('test1.fieldses.org', 2049))
> >>>INFO   :rpc.poll:Adding 6 generated by another thread
> >>>WARNING:test.env:server took approximately 13 seconds to lift grace af=
ter all clients reclaimed
> >>>INFO   :test.env:Sleeping for 20 seconds: Waiting for grace period to =
end
> >>>INFO   :test.env:Woke up
> >>>INFO   :rpc.poll:Closing 6
> >>>INFO   :rpc.thread:Called connect(('test1.fieldses.org', 2049))
> >>>INFO   :rpc.poll:Adding 6 generated by another thread
> >>>INFO   :test.env:Sleeping for 20 seconds: Waiting for grace period to =
end
> >>>INFO   :test.env:Woke up
> >>>INFO   :rpc.poll:Closing 6
> >>>INFO   :rpc.thread:Called connect(('test1.fieldses.org', 2049))
> >>>INFO   :rpc.poll:Adding 6 generated by another thread
> >>>INFO   :test.env:Sleeping for 20 seconds: Waiting for grace period to =
end
> >>>INFO   :test.env:Woke up
> >>>INFO   :rpc.poll:Closing 6
> >>>INFO   :rpc.thread:Called connect(('test1.fieldses.org', 2049))
> >>>INFO   :rpc.poll:Adding 6 generated by another thread
> >>>INFO   :test.env:Sleeping for 20 seconds: Waiting for grace period to =
end
> >>>INFO   :test.env:Woke up
> >>>INFO   :rpc.poll:Closing 6
> >>>INFO   :rpc.thread:Called connect(('test1.fieldses.org', 2049))
> >>>INFO   :rpc.poll:Adding 6 generated by another thread
> >>>INFO   :test.env:Sleeping for 10 seconds: Delaying start of reclaim
> >>>INFO   :test.env:Woke up
> >>>INFO   :test.env:Sleeping for 20 seconds: Waiting for grace period to =
end
> >>>INFO   :test.env:Woke up
> >>>INFO   :rpc.poll:Closing 6
> >>>INFO   :rpc.thread:Called connect(('test1.fieldses.org', 2049))
> >>>INFO   :rpc.poll:Adding 6 generated by another thread
> >>>INFO   :test.env:Sleeping for 20 seconds: Waiting for grace period to =
end
> >>>INFO   :test.env:Woke up
> >>>INFO   :rpc.poll:Closing 6
> >>>INFO   :rpc.thread:Called connect(('test1.fieldses.org', 2049))
> >>>INFO   :rpc.poll:Adding 6 generated by another thread
> >>>INFO   :rpc.poll:Closing 6
> >>>INFO   :rpc.thread:Called connect(('test1.fieldses.org', 2049))
> >>>INFO   :rpc.poll:Adding 6 generated by another thread
> >>>WARNING:test.env:server took approximately 14 seconds to lift grace af=
ter all clients reclaimed
> >>>INFO   :test.env:Sleeping for 20 seconds: Waiting for grace period to =
end
> >>>INFO   :test.env:Woke up
> >>>INFO   :rpc.poll:Closing 6
> >>>INFO   :rpc.thread:Called connect(('test1.fieldses.org', 2049))
> >>>INFO   :rpc.poll:Adding 6 generated by another thread
> >>>INFO   :rpc.poll:Closing 6
> >>>INFO   :rpc.thread:Called connect(('test1.fieldses.org', 2049))
> >>>INFO   :rpc.poll:Adding 6 generated by another thread
> >>>INFO   :test.env:Sleeping for 20 seconds: Waiting for grace period to =
end
> >>>INFO   :test.env:Woke up
> >>>COUR6    st_courtesy.testShareReservationDB03                     : RU=
NNING
> >>>COUR6    st_courtesy.testShareReservationDB03                     : PA=
SS
> >>>COUR5    st_courtesy.testShareReservationDB02                     : RU=
NNING
> >>>COUR5    st_courtesy.testShareReservationDB02                     : PA=
SS
> >>>COUR4    st_courtesy.testShareReservationDB01                     : RU=
NNING
> >>>COUR4    st_courtesy.testShareReservationDB01                     : PA=
SS
> >>>COUR3    st_courtesy.testShareReservation00                       : RU=
NNING
> >>>COUR3    st_courtesy.testShareReservation00                       : PA=
SS
> >>>COUR2    st_courtesy.testLockSleepLock                            : RU=
NNING
> >>>COUR2    st_courtesy.testLockSleepLock                            : PA=
SS
> >>>CSID3    st_current_stateid.testOpenWriteClose                    : RU=
NNING
> >>>CSID3    st_current_stateid.testOpenWriteClose                    : PA=
SS
> >>>CSID8    st_current_stateid.testOpenSetattr                       : RU=
NNING
> >>>CSID8    st_current_stateid.testOpenSetattr                       : PA=
SS
> >>>CSID10   st_current_stateid.testOpenSaveFHLookupRestoreFHClose    : RU=
NNING
> >>>CSID10   st_current_stateid.testOpenSaveFHLookupRestoreFHClose    : PA=
SS
> >>>CSID5    st_current_stateid.testOpenLookupClose                   : RU=
NNING
> >>>CSID5    st_current_stateid.testOpenLookupClose                   : PA=
SS
> >>>CSID9    st_current_stateid.testOpenFreestateidClose              : RU=
NNING
> >>>CSID9    st_current_stateid.testOpenFreestateidClose              : PA=
SS
> >>>CSID1    st_current_stateid.testOpenAndClose                      : RU=
NNING
> >>>CSID1    st_current_stateid.testOpenAndClose                      : PA=
SS
> >>>CSID4    st_current_stateid.testLockWriteLocku                    : RU=
NNING
> >>>CSID4    st_current_stateid.testLockWriteLocku                    : PA=
SS
> >>>CSID2    st_current_stateid.testLockLockU                         : RU=
NNING
> >>>CSID2    st_current_stateid.testLockLockU                         : PA=
SS
> >>>CSID6    st_current_stateid.testCloseNoStateid                    : RU=
NNING
> >>>CSID6    st_current_stateid.testCloseNoStateid                    : PA=
SS
> >>>REBT4b   st_reboot.testRebootWithManyManyClientsDoubleReclaim     : RU=
NNING
> >>>REBT4b   st_reboot.testRebootWithManyManyClientsDoubleReclaim     : PA=
SS
> >>>REBT2b   st_reboot.testRebootWithManyManyClients                  : RU=
NNING
> >>>REBT2b   st_reboot.testRebootWithManyManyClients                  : PA=
SS
> >>>REBT4a   st_reboot.testRebootWithManyClientsDoubleReclaim         : RU=
NNING
> >>>REBT4a   st_reboot.testRebootWithManyClientsDoubleReclaim         : PA=
SS
> >>>REBT2a   st_reboot.testRebootWithManyClients                      : RU=
NNING
> >>>REBT2a   st_reboot.testRebootWithManyClients                      : PA=
SS
> >>>REBT5    st_reboot.testRebootWithLateReclaim                      : RU=
NNING
> >>>REBT5    st_reboot.testRebootWithLateReclaim                      : PA=
SS
> >>>REBT1    st_reboot.testRebootValid                                : RU=
NNING
> >>>REBT1    st_reboot.testRebootValid                                : PA=
SS
> >>>REBT3b   st_reboot.testDoubleRebootWithManyManyClients            : RU=
NNING
> >>>REBT3b   st_reboot.testDoubleRebootWithManyManyClients            : PA=
SS
> >>>REBT3a   st_reboot.testDoubleRebootWithManyClients                : RU=
NNING
> >>>REBT3a   st_reboot.testDoubleRebootWithManyClients                : PA=
SS
> >>>PUTFH1s  st_putfh.testSocket                                      : RU=
NNING
> >>>PUTFH1s  st_putfh.testSocket                                      : PA=
SS
> >>>PUTFH1a  st_putfh.testLink                                        : RU=
NNING
> >>>PUTFH1a  st_putfh.testLink                                        : PA=
SS
> >>>PUTFH1r  st_putfh.testFile                                        : RU=
NNING
> >>>PUTFH1r  st_putfh.testFile                                        : PA=
SS
> >>>PUTFH1f  st_putfh.testFifo                                        : RU=
NNING
> >>>PUTFH1f  st_putfh.testFifo                                        : PA=
SS
> >>>PUTFH1d  st_putfh.testDir                                         : RU=
NNING
> >>>PUTFH1d  st_putfh.testDir                                         : PA=
SS
> >>>PUTFH2   st_putfh.testBadHandle                                   : RU=
NNING
> >>>PUTFH2   st_putfh.testBadHandle                                   : PA=
SS
> >>>RNM6     st_rename.testZeroLengthOldname                          : RU=
NNING
> >>>RNM6     st_rename.testZeroLengthOldname                          : PA=
SS
> >>>RNM7     st_rename.testZeroLengthNewname                          : RU=
NNING
> >>>RNM7     st_rename.testZeroLengthNewname                          : PA=
SS
> >>>RNM1s    st_rename.testValidSocket                                : RU=
NNING
> >>>RNM1s    st_rename.testValidSocket                                : PA=
SS
> >>>RNM1a    st_rename.testValidLink                                  : RU=
NNING
> >>>RNM1a    st_rename.testValidLink                                  : PA=
SS
> >>>RNM1r    st_rename.testValidFile                                  : RU=
NNING
> >>>RNM1r    st_rename.testValidFile                                  : PA=
SS
> >>>RNM1f    st_rename.testValidFifo                                  : RU=
NNING
> >>>RNM1f    st_rename.testValidFifo                                  : PA=
SS
> >>>RNM1d    st_rename.testValidDir                                   : RU=
NNING
> >>>RNM1d    st_rename.testValidDir                                   : PA=
SS
> >>>RNM2s    st_rename.testSfhSocket                                  : RU=
NNING
> >>>RNM2s    st_rename.testSfhSocket                                  : PA=
SS
> >>>RNM2a    st_rename.testSfhLink                                    : RU=
NNING
> >>>RNM2a    st_rename.testSfhLink                                    : PA=
SS
> >>>RNM2r    st_rename.testSfhFile                                    : RU=
NNING
> >>>RNM2r    st_rename.testSfhFile                                    : PA=
SS
> >>>RNM2f    st_rename.testSfhFifo                                    : RU=
NNING
> >>>RNM2f    st_rename.testSfhFifo                                    : PA=
SS
> >>>RNM19    st_rename.testSelfRenameFile                             : RU=
NNING
> >>>RNM19    st_rename.testSelfRenameFile                             : PA=
SS
> >>>RNM18    st_rename.testSelfRenameDir                              : RU=
NNING
> >>>RNM18    st_rename.testSelfRenameDir                              : PA=
SS
> >>>RNM5     st_rename.testNonExistent                                : RU=
NNING
> >>>RNM5     st_rename.testNonExistent                                : PA=
SS
> >>>RNM4     st_rename.testNoSfh                                      : RU=
NNING
> >>>RNM4     st_rename.testNoSfh                                      : PA=
SS
> >>>RNM20    st_rename.testLinkRename                                 : RU=
NNING
> >>>RNM20    st_rename.testLinkRename                                 : PA=
SS
> >>>RNM17    st_rename.testFileToFullDir                              : RU=
NNING
> >>>RNM17    st_rename.testFileToFullDir                              : PA=
SS
> >>>RNM15    st_rename.testFileToFile                                 : RU=
NNING
> >>>RNM15    st_rename.testFileToFile                                 : PA=
SS
> >>>RNM14    st_rename.testFileToDir                                  : RU=
NNING
> >>>RNM14    st_rename.testFileToDir                                  : PA=
SS
> >>>RNM10    st_rename.testDotsOldname                                : RU=
NNING
> >>>RNM10    st_rename.testDotsOldname                                : PA=
SS
> >>>RNM11    st_rename.testDotsNewname                                : RU=
NNING
> >>>RNM11    st_rename.testDotsNewname                                : PA=
SS
> >>>RNM12    st_rename.testDirToObj                                   : RU=
NNING
> >>>RNM12    st_rename.testDirToObj                                   : PA=
SS
> >>>RNM16    st_rename.testDirToFullDir                               : RU=
NNING
> >>>RNM16    st_rename.testDirToFullDir                               : PA=
SS
> >>>RNM13    st_rename.testDirToDir                                   : RU=
NNING
> >>>RNM13    st_rename.testDirToDir                                   : PA=
SS
> >>>RNM3s    st_rename.testCfhSocket                                  : RU=
NNING
> >>>RNM3s    st_rename.testCfhSocket                                  : PA=
SS
> >>>RNM3a    st_rename.testCfhLink                                    : RU=
NNING
> >>>RNM3a    st_rename.testCfhLink                                    : PA=
SS
> >>>RNM3r    st_rename.testCfhFile                                    : RU=
NNING
> >>>INFO   :nfs.client.cb:********************
> >>>INFO   :nfs.client.cb:Handling COMPOUND
> >>>INFO   :nfs.client.cb:*** OP_CB_SEQUENCE (11) ***
> >>>INFO   :nfs.client.cb:In CB_SEQUENCE
> >>>INFO   :nfs.client.cb:*** OP_CB_RECALL (4) ***
> >>>INFO   :nfs.client.cb:In CB_RECALL
> >>>INFO   :nfs.client.cb:Replying.  Status NFS4_OK (0)
> >>>INFO   :nfs.client.cb:[nfs_cb_resop4(resop=3D11, opcbsequence=3DCB_SEQ=
UENCE4res(csr_status=3DNFS4_OK, csr_resok4=3DCB_SEQUENCE4resok(csr_sessioni=
d=3Db'<\x0b\xdfa\x9cWSo[\x03\x00\x00\x00\x00\x00\x00', csr_sequenceid=3D1, =
csr_slotid=3D0, csr_highest_slotid=3D8, csr_target_highest_slotid=3D8))), n=
fs_cb_resop4(resop=3D4, opcbrecall=3DCB_RECALL4res(status=3DNFS4_OK))]
> >>>INFO   :test.env:Sleeping for 0 seconds:
> >>>INFO   :test.env:Woke up
> >>>INFO   :nfs.client.cb:********************
> >>>INFO   :nfs.client.cb:Handling COMPOUND
> >>>INFO   :nfs.client.cb:*** OP_CB_SEQUENCE (11) ***
> >>>INFO   :nfs.client.cb:In CB_SEQUENCE
> >>>INFO   :nfs.client.cb:*** OP_CB_RECALL (4) ***
> >>>INFO   :nfs.client.cb:In CB_RECALL
> >>>INFO   :nfs.client.cb:Replying.  Status NFS4_OK (0)
> >>>INFO   :nfs.client.cb:[nfs_cb_resop4(resop=3D11, opcbsequence=3DCB_SEQ=
UENCE4res(csr_status=3DNFS4_OK, csr_resok4=3DCB_SEQUENCE4resok(csr_sessioni=
d=3Db'<\x0b\xdfa\x9eWSo]\x03\x00\x00\x00\x00\x00\x00', csr_sequenceid=3D1, =
csr_slotid=3D0, csr_highest_slotid=3D8, csr_target_highest_slotid=3D8))), n=
fs_cb_resop4(resop=3D4, opcbrecall=3DCB_RECALL4res(status=3DNFS4_OK))]
> >>>INFO   :test.env:Sleeping for 0 seconds:
> >>>INFO   :test.env:Woke up
> >>>INFO   :nfs.client.cb:********************
> >>>INFO   :nfs.client.cb:Handling COMPOUND
> >>>INFO   :nfs.client.cb:*** OP_CB_SEQUENCE (11) ***
> >>>INFO   :nfs.client.cb:In CB_SEQUENCE
> >>>INFO   :nfs.client.cb:*** OP_CB_RECALL (4) ***
> >>>INFO   :nfs.client.cb:In CB_RECALL
> >>>INFO   :nfs.client.cb:Replying.  Status NFS4_OK (0)
> >>>INFO   :nfs.client.cb:[nfs_cb_resop4(resop=3D11, opcbsequence=3DCB_SEQ=
UENCE4res(csr_status=3DNFS4_OK, csr_resok4=3DCB_SEQUENCE4resok(csr_sessioni=
d=3Db'<\x0b\xdfa\xa1WSo`\x03\x00\x00\x00\x00\x00\x00', csr_sequenceid=3D1, =
csr_slotid=3D0, csr_highest_slotid=3D8, csr_target_highest_slotid=3D8))), n=
fs_cb_resop4(resop=3D4, opcbrecall=3DCB_RECALL4res(status=3DNFS4_OK))]
> >>>INFO   :nfs.client.cb:********************
> >>>INFO   :nfs.client.cb:Handling COMPOUND
> >>>INFO   :nfs.client.cb:*** OP_CB_SEQUENCE (11) ***
> >>>INFO   :nfs.client.cb:In CB_SEQUENCE
> >>>INFO   :nfs.client.cb:*** OP_CB_RECALL (4) ***
> >>>INFO   :nfs.client.cb:In CB_RECALL
> >>>INFO   :nfs.client.cb:Replying.  Status NFS4_OK (0)
> >>>INFO   :nfs.client.cb:[nfs_cb_resop4(resop=3D11, opcbsequence=3DCB_SEQ=
UENCE4res(csr_status=3DNFS4_OK, csr_resok4=3DCB_SEQUENCE4resok(csr_sessioni=
d=3Db'<\x0b\xdfa\xa3WSob\x03\x00\x00\x00\x00\x00\x00', csr_sequenceid=3D1, =
csr_slotid=3D0, csr_highest_slotid=3D8, csr_target_highest_slotid=3D8))), n=
fs_cb_resop4(resop=3D4, opcbrecall=3DCB_RECALL4res(status=3DNFS4_OK))]
> >>>INFO   :test.env:Sleeping for 0 seconds:
> >>>INFO   :test.env:Woke up
> >>>INFO   :rpc.thread:Called connect(('test1.fieldses.org', 2049))
> >>>INFO   :rpc.poll:Adding 8 generated by another thread
> >>>RNM3r    st_rename.testCfhFile                                    : PA=
SS
> >>>RNM3f    st_rename.testCfhFifo                                    : RU=
NNING
> >>>RNM3f    st_rename.testCfhFifo                                    : PA=
SS
> >>>LKPP1s   st_lookupp.testSock                                      : RU=
NNING
> >>>LKPP1s   st_lookupp.testSock                                      : PA=
SS
> >>>LKPP3    st_lookupp.testNoFH                                      : RU=
NNING
> >>>LKPP3    st_lookupp.testNoFH                                      : PA=
SS
> >>>LKPP2    st_lookupp.testLookuppRoot                               : RU=
NNING
> >>>LKPP2    st_lookupp.testLookuppRoot                               : PA=
SS
> >>>LKPP1a   st_lookupp.testLink                                      : RU=
NNING
> >>>LKPP1a   st_lookupp.testLink                                      : PA=
SS
> >>>LKPP1r   st_lookupp.testFile                                      : RU=
NNING
> >>>LKPP1r   st_lookupp.testFile                                      : PA=
SS
> >>>LKPP1f   st_lookupp.testFifo                                      : RU=
NNING
> >>>LKPP1f   st_lookupp.testFifo                                      : PA=
SS
> >>>VF1r     st_verify.testMandFile                                   : RU=
NNING
> >>>VF1r     st_verify.testMandFile                                   : PA=
SS
> >>>DELEG9   st_delegation.testWriteOpenvsReadDeleg                   : RU=
NNING
> >>>DELEG9   st_delegation.testWriteOpenvsReadDeleg                   : PA=
SS
> >>>DELEG23  st_delegation.testServerSelfConflict3                    : RU=
NNING
> >>>__create_file_with_deleg:  b'\x01\x00\x06\x81\xa68F}\x17\x9bN\xb5\xa8\=
x85Pp0\xbc\xdc`?S\x80\x00\x00\x00\x00\x00\x1eX\xc5%' open_delegation4(deleg=
ation_type=3DOPEN_DELEGATE_READ, read=3Dopen_read_delegation4(stateid=3Dsta=
teid4(seqid=3D1, other=3Db'<\x0b\xdfa\x9cWSo\x02\x00\x00\x00'), recall=3DFa=
lse, permissions=3Dnfsace4(type=3D0, flag=3D0, access_mask=3D0, who=3Db'')))
> >>>open_file res:  COMPOUND4res(status=3DNFS4_OK, tag=3Db'environment.py:=
open_create_file', resarray=3D[nfs_resop4(resop=3DOP_PUTROOTFH, opputrootfh=
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
> >>>  X\xc5%')))])
> >>>DELEG23  st_delegation.testServerSelfConflict3                    : PA=
SS
> >>>DELEG1   st_delegation.testReadDeleg                              : RU=
NNING
> >>>DELEG1   st_delegation.testReadDeleg                              : PA=
SS
> >>>DELEG4   st_delegation.testNoDeleg                                : RU=
NNING
> >>>DELEG4   st_delegation.testNoDeleg                                : PA=
SS
> >>>DELEG8   st_delegation.testDelegRevocation                        : RU=
NNING
> >>>DELEG8   st_delegation.testDelegRevocation                        : PA=
SS
> >>>DELEG6   st_delegation.testCBSecParmsNull                         : RU=
NNING
> >>>DELEG6   st_delegation.testCBSecParmsNull                         : PA=
SS
> >>>OPEN1    st_open.testSupported                                    : RU=
NNING
> >>>OPEN1    st_open.testSupported                                    : PA=
SS
> >>>OPEN2    st_open.testServerStateSeqid                             : RU=
NNING
> >>>OPEN2    st_open.testServerStateSeqid                             : PA=
SS
> >>>OPEN30   st_open.testReadWrite                                    : RU=
NNING
> >>>OPEN30   st_open.testReadWrite                                    : PA=
SS
> >>>OPEN7    st_open.testOPENClaimFH                                  : RU=
NNING
> >>>OPEN7    st_open.testOPENClaimFH                                  : PA=
SS
> >>>OPEN6    st_open.testEXCLUSIVE4AtNameAttribute                    : RU=
NNING
> >>>OPEN6    st_open.testEXCLUSIVE4AtNameAttribute                    : PA=
SS
> >>>OPEN8    st_open.testCloseWithZeroSeqid                           : RU=
NNING
> >>>OPEN8    st_open.testCloseWithZeroSeqid                           : PA=
SS
> >>>OPEN31   st_open.testAnonReadWrite                                : RU=
NNING
> >>>OPEN31   st_open.testAnonReadWrite                                : PA=
SS
> >>>TRUNK2   st_trunking.testUseTwoSessions                           : RU=
NNING
> >>>TRUNK2   st_trunking.testUseTwoSessions                           : PA=
SS
> >>>TRUNK1   st_trunking.testTwoSessions                              : RU=
NNING
> >>>TRUNK1   st_trunking.testTwoSessions                              : PA=
SS
> >>>SEQ7     st_sequence.testTooManyOps                               : RU=
NNING
> >>>SEQ7     st_sequence.testTooManyOps                               : PA=
SS
> >>>SEQ1     st_sequence.testSupported                                : RU=
NNING
> >>>SEQ1     st_sequence.testSupported                                : PA=
SS
> >>>SEQ12    st_sequence.testSessionidSequenceidSlotid                : RU=
NNING
> >>>SEQ12    st_sequence.testSessionidSequenceidSlotid                : PA=
SS
> >>>SEQ6     st_sequence.testRequestTooBig                            : RU=
NNING
> >>>SEQ6     st_sequence.testRequestTooBig                            : PA=
SS
> >>>SEQ10b   st_sequence.testReplayCache007                           : RU=
NNING
> >>>SEQ10b   st_sequence.testReplayCache007                           : PA=
SS
> >>>SEQ9f    st_sequence.testReplayCache006                           : RU=
NNING
> >>>SEQ9f    st_sequence.testReplayCache006                           : PA=
SS
> >>>SEQ9e    st_sequence.testReplayCache005                           : RU=
NNING
> >>>SEQ9e    st_sequence.testReplayCache005                           : PA=
SS
> >>>SEQ9d    st_sequence.testReplayCache004                           : RU=
NNING
> >>>SEQ9d    st_sequence.testReplayCache004                           : PA=
SS
> >>>SEQ9c    st_sequence.testReplayCache003                           : RU=
NNING
> >>>SEQ9c    st_sequence.testReplayCache003                           : PA=
SS
> >>>SEQ9b    st_sequence.testReplayCache002                           : RU=
NNING
> >>>SEQ9b    st_sequence.testReplayCache002                           : PA=
SS
> >>>SEQ9a    st_sequence.testReplayCache001                           : RU=
NNING
> >>>SEQ9a    st_sequence.testReplayCache001                           : PA=
SS
> >>>SEQ11    st_sequence.testOpNotInSession                           : RU=
NNING
> >>>SEQ11    st_sequence.testOpNotInSession                           : PA=
SS
> >>>SEQ2     st_sequence.testNotFirst                                 : RU=
NNING
> >>>SEQ2     st_sequence.testNotFirst                                 : PA=
SS
> >>>SEQ4     st_sequence.testImplicitBind                             : RU=
NNING
> >>>SEQ4     st_sequence.testImplicitBind                             : PA=
SS
> >>>SEQ8     st_sequence.testBadSlot                                  : RU=
NNING
> >>>SEQ8     st_sequence.testBadSlot                                  : PA=
SS
> >>>SEQ5     st_sequence.testBadSession                               : RU=
NNING
> >>>SEQ5     st_sequence.testBadSession                               : PA=
SS
> >>>SEQ13    st_sequence.testBadSequenceidAtSlot                      : RU=
NNING
> >>>SEQ13    st_sequence.testBadSequenceidAtSlot                      : PA=
SS
> >>>SEC2     st_secinfo.testSupported2                                : RU=
NNING
> >>>SEC2     st_secinfo.testSupported2                                : PA=
SS
> >>>SEC1     st_secinfo.testSupported                                 : RU=
NNING
> >>>SEC1     st_secinfo.testSupported                                 : PA=
SS
> >>>SECNN4   st_secinfo_no_name.testSupported4                        : RU=
NNING
> >>>SECNN4   st_secinfo_no_name.testSupported4                        : PA=
SS
> >>>SECNN3   st_secinfo_no_name.testSupported3                        : RU=
NNING
> >>>SECNN3   st_secinfo_no_name.testSupported3                        : PA=
SS
> >>>SECNN2   st_secinfo_no_name.testSupported2                        : RU=
NNING
> >>>COMPOUND4res(status=3DNFS4ERR_NOFILEHANDLE, tag=3Db'st_secinfo_no_name=
=2Epy:testSupported2', resarray=3D[nfs_resop4(resop=3DOP_PUTROOTFH, opputro=
otfh=3DPUTROOTFH4res(status=3DNFS4_OK)), nfs_resop4(resop=3DOP_SECINFO_NO_N=
AME, opsecinfo_no_name=3DSECINFO4res(status=3DNFS4_OK, resok4=3D[secinfo4(f=
lavor=3D6, flavor_info=3Drpcsec_gss_info(oid=3Db'*\x86H\x86\xf7\x12\x01\x02=
\x02', qop=3D0, service=3DRPC_GSS_SVC_NONE)), secinfo4(flavor=3D6, flavor_i=
nfo=3Drpcsec_gss_info(oid=3Db'*\x86H\x86\xf7\x12\x01\x02\x02', qop=3D0, ser=
vice=3DRPC_GSS_SVC_INTEGRITY)), secinfo4(flavor=3D6, flavor_info=3Drpcsec_g=
ss_info(oid=3Db'*\x86H\x86\xf7\x12\x01\x02\x02', qop=3D0, service=3DRPC_GSS=
_SVC_PRIVACY)), secinfo4(flavor=3D1)])), nfs_resop4(resop=3DOP_GETFH, opget=
fh=3DGETFH4res(status=3DNFS4ERR_NOFILEHANDLE))])
> >>>SECNN2   st_secinfo_no_name.testSupported2                        : PA=
SS
> >>>SECNN1   st_secinfo_no_name.testSupported                         : RU=
NNING
> >>>SECNN1   st_secinfo_no_name.testSupported                         : PA=
SS
> >>>RECC1    st_reclaim_complete.testSupported                        : RU=
NNING
> >>>RECC1    st_reclaim_complete.testSupported                        : PA=
SS
> >>>RECC2    st_reclaim_complete.testReclaimAfterRECC                 : RU=
NNING
> >>>RECC2    st_reclaim_complete.testReclaimAfterRECC                 : PA=
SS
> >>>RECC3    st_reclaim_complete.testOpenBeforeRECC                   : RU=
NNING
> >>>RECC3    st_reclaim_complete.testOpenBeforeRECC                   : PA=
SS
> >>>RECC4    st_reclaim_complete.testDoubleRECC                       : RU=
NNING
> >>>RECC4    st_reclaim_complete.testDoubleRECC                       : PA=
SS
> >>>DESCID1  st_destroy_clientid.testSupported                        : RU=
NNING
> >>>DESCID1  st_destroy_clientid.testSupported                        : PA=
SS
> >>>DESCID2  st_destroy_clientid.testDestroyCIDWS                     : RU=
NNING
> >>>DESCID2  st_destroy_clientid.testDestroyCIDWS                     : PA=
SS
> >>>DESCID8  st_destroy_clientid.testDestroyCIDTwice                  : RU=
NNING
> >>>DESCID8  st_destroy_clientid.testDestroyCIDTwice                  : PA=
SS
> >>>DESCID5  st_destroy_clientid.testDestroyCIDSessionB               : RU=
NNING
> >>>DESCID5  st_destroy_clientid.testDestroyCIDSessionB               : PA=
SS
> >>>DESCID7  st_destroy_clientid.testDestroyCIDNotOnly                : RU=
NNING
> >>>DESCID7  st_destroy_clientid.testDestroyCIDNotOnly                : PA=
SS
> >>>DESCID6  st_destroy_clientid.testDestroyCIDCSession               : RU=
NNING
> >>>DESCID6  st_destroy_clientid.testDestroyCIDCSession               : PA=
SS
> >>>DESCID3  st_destroy_clientid.testDestroyBadCIDWS                  : RU=
NNING
> >>>DESCID3  st_destroy_clientid.testDestroyBadCIDWS                  : PA=
SS
> >>>DESCID4  st_destroy_clientid.testDestroyBadCIDIS                  : RU=
NNING
> >>>DESCID4  st_destroy_clientid.testDestroyBadCIDIS                  : PA=
SS
> >>>CSESS28  st_create_session.testTooSmallMaxReq                     : RU=
NNING
> >>>CSESS28  st_create_session.testTooSmallMaxReq                     : PA=
SS
> >>>CSESS25  st_create_session.testTooSmallMaxRS                      : RU=
NNING
> >>>CSESS25  st_create_session.testTooSmallMaxRS                      : PA=
SS
> >>>CSESS2b  st_create_session.testSupported2b                        : RU=
NNING
> >>>CSESS2b  st_create_session.testSupported2b                        : PA=
SS
> >>>CSESS2   st_create_session.testSupported2                         : RU=
NNING
> >>>CSESS2   st_create_session.testSupported2                         : PA=
SS
> >>>CSESS1   st_create_session.testSupported1                         : RU=
NNING
> >>>CSESS1   st_create_session.testSupported1                         : PA=
SS
> >>>CSESS9   st_create_session.testPrincipalCollision1                : RU=
NNING
> >>>CSESS9   st_create_session.testPrincipalCollision1                : PA=
SS
> >>>CSESS6   st_create_session.testReplay2                            : RU=
NNING
> >>>CSESS6   st_create_session.testReplay2                            : PA=
SS
> >>>CSESS5b  st_create_session.testReplay1b                           : RU=
NNING
> >>>CSESS5b  st_create_session.testReplay1b                           : PA=
SS
> >>>CSESS5a  st_create_session.testReplay1a                           : RU=
NNING
> >>>CSESS5a  st_create_session.testReplay1a                           : PA=
SS
> >>>CSESS5   st_create_session.testReplay1                            : RU=
NNING
> >>>CSESS5   st_create_session.testReplay1                            : PA=
SS
> >>>CSESS27  st_create_session.testRepTooBigToCache                   : RU=
NNING
> >>>CSESS27  st_create_session.testRepTooBigToCache                   : PA=
SS
> >>>CSESS26  st_create_session.testRepTooBig                          : RU=
NNING
> >>>[0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 19]
> >>>CSESS26  st_create_session.testRepTooBig                          : PA=
SS
> >>>CSESS19  st_create_session.testRdmaArray2                         : RU=
NNING
> >>>COMPOUND4res(status=3DNFS4ERR_BADXDR, tag=3Db'st_create_session.py:tes=
tRdmaArray2', resarray=3D[nfs_resop4(resop=3DOP_CREATE_SESSION, opcreate_se=
ssion=3DCREATE_SESSION4res(csr_status=3DNFS4ERR_BADXDR))])
> >>>CSESS19  st_create_session.testRdmaArray2                         : PA=
SS
> >>>CSESS18  st_create_session.testRdmaArray1                         : RU=
NNING
> >>>CSESS18  st_create_session.testRdmaArray1                         : PA=
SS
> >>>CSESS17  st_create_session.testRdmaArray0                         : RU=
NNING
> >>>CSESS17  st_create_session.testRdmaArray0                         : PA=
SS
> >>>CSESS10  st_create_session.testPrincipalCollision2                : RU=
NNING
> >>>CSESS10  st_create_session.testPrincipalCollision2                : PA=
SS
> >>>CSESS23  st_create_session.testNotOnlyOp                          : RU=
NNING
> >>>CSESS23  st_create_session.testNotOnlyOp                          : PA=
SS
> >>>CSESS3   st_create_session.testNoExchange                         : RU=
NNING
> >>>CSESS3   st_create_session.testNoExchange                         : PA=
SS
> >>>CSESS22  st_create_session.testMaxreqs                            : RU=
NNING
> >>>CSESS22  st_create_session.testMaxreqs                            : PA=
SS
> >>>CSESS200 st_create_session.testManyClients                        : RU=
NNING
> >>>CSESS200 st_create_session.testManyClients                        : PA=
SS
> >>>CSESS29  st_create_session.testDRCMemLeak                         : RU=
NNING
> >>>CSESS29  st_create_session.testDRCMemLeak                         : PA=
SS
> >>>CSESS24  st_create_session.testCsr_sequence                       : RU=
NNING
> >>>CSESS24  st_create_session.testCsr_sequence                       : PA=
SS
> >>>CSESS4   st_create_session.testContrivedReplay                    : RU=
NNING
> >>>CSESS4   st_create_session.testContrivedReplay                    : PA=
SS
> >>>CSESS16a st_create_session.testCbSecParmsDec                      : RU=
NNING
> >>>CSESS16a st_create_session.testCbSecParmsDec                      : PA=
SS
> >>>CSESS16  st_create_session.testCbSecParms                         : RU=
NNING
> >>>CSESS16  st_create_session.testCbSecParms                         : PA=
SS
> >>>CSESS8   st_create_session.testBadSeqnum2                         : RU=
NNING
> >>>CSESS8   st_create_session.testBadSeqnum2                         : PA=
SS
> >>>CSESS7   st_create_session.testBadSeqnum1                         : RU=
NNING
> >>>CSESS7   st_create_session.testBadSeqnum1                         : PA=
SS
> >>>CSESS15  st_create_session.testBadFlag                            : RU=
NNING
> >>>CSESS15  st_create_session.testBadFlag                            : PA=
SS
> >>>COMP1    st_compound.testZeroOps                                  : RU=
NNING
> >>>COMP1    st_compound.testZeroOps                                  : PA=
SS
> >>>COMP5    st_compound.testUndefined                                : RU=
NNING
> >>>COMP5    st_compound.testUndefined                                : PA=
SS
> >>>COMP4b   st_compound.testInvalidMinor2                            : RU=
NNING
> >>>COMP4b   st_compound.testInvalidMinor2                            : PA=
SS
> >>>COMP4a   st_compound.testInvalidMinor                             : RU=
NNING
> >>>COMP4a   st_compound.testInvalidMinor                             : PA=
SS
> >>>COMP2    st_compound.testGoodTag                                  : RU=
NNING
> >>>COMP2    st_compound.testGoodTag                                  : PA=
SS
> >>>EID6     st_exchange_id.testUpdateNonexistant                     : RU=
NNING
> >>>EID6     st_exchange_id.testUpdateNonexistant                     : PA=
SS
> >>>EID6h    st_exchange_id.testUpdate111                             : RU=
NNING
> >>>INFO   :test.env:Called do_readdir()
> >>>INFO   :test.env:do_readdir() =3D [entry4(cookie=3D16, name=3Db'COUR6_=
1642007029', attrs=3D{}), entry4(cookie=3D20, name=3Db'COUR5_1642007029', a=
ttrs=3D{}), entry4(cookie=3D24, name=3Db'COUR4_1642007029', attrs=3D{}), en=
try4(cookie=3D28, name=3Db'COUR3_1642007029', attrs=3D{}), entry4(cookie=3D=
32, name=3Db'COUR2_1642007029', attrs=3D{}), entry4(cookie=3D36, name=3Db'C=
SID3_1642007029', attrs=3D{}), entry4(cookie=3D40, name=3Db'CSID8_164200702=
9', attrs=3D{}), entry4(cookie=3D44, name=3Db'CSID10_1642007029', attrs=3D{=
}), entry4(cookie=3D48, name=3Db'CSID5_1642007029', attrs=3D{}), entry4(coo=
kie=3D52, name=3Db'CSID9_1642007029', attrs=3D{}), entry4(cookie=3D56, name=
=3Db'CSID1_1642007029', attrs=3D{}), entry4(cookie=3D60, name=3Db'CSID4_164=
2007029', attrs=3D{}), entry4(cookie=3D64, name=3Db'CSID2_1642007029', attr=
s=3D{}), entry4(cookie=3D68, name=3Db'CSID6_1642007029', attrs=3D{}), entry=
4(cookie=3D74, name=3Db'owner_REBT4b_1642007029_client_0', attrs=3D{}), ent=
ry4(cookie=3D80, name=3Db'owner_REBT4b_1642007029_client_1', attrs=3D{}), e=
ntry4(cookie=3D86, name=3Db'owner_REBT4b_1642007029_cli
> >>>  ent_2', attrs=3D{}), entry4(cookie=3D92, name=3Db'owner_REBT4b_16420=
07029_client_3', attrs=3D{}), entry4(cookie=3D98, name=3Db'owner_REBT4b_164=
2007029_client_4', attrs=3D{}), entry4(cookie=3D104, name=3Db'owner_REBT4b_=
1642007029_client_5', attrs=3D{}), entry4(cookie=3D110, name=3Db'owner_REBT=
4b_1642007029_client_6', attrs=3D{}), entry4(cookie=3D116, name=3Db'owner_R=
EBT4b_1642007029_client_7', attrs=3D{}), entry4(cookie=3D122, name=3Db'owne=
r_REBT4b_1642007029_client_8', attrs=3D{}), entry4(cookie=3D128, name=3Db'o=
wner_REBT4b_1642007029_client_9', attrs=3D{}), entry4(cookie=3D134, name=3D=
b'owner_REBT4b_1642007029_client_10', attrs=3D{}), entry4(cookie=3D140, nam=
e=3Db'owner_REBT4b_1642007029_client_11', attrs=3D{}), entry4(cookie=3D146,=
 name=3Db'owner_REBT4b_1642007029_client_12', attrs=3D{}), entry4(cookie=3D=
152, name=3Db'owner_REBT4b_1642007029_client_13', attrs=3D{}), entry4(cooki=
e=3D158, name=3Db'owner_REBT4b_1642007029_client_14', attrs=3D{}), entry4(c=
ookie=3D164, name=3Db'owner_REBT4b_1642007029_client_15', attrs=3D{}), entr=
y4(cookie=3D170, name=3Db'owner_REBT4b
> >>>  _1642007029_client_16', attrs=3D{}), entry4(cookie=3D176, name=3Db'o=
wner_REBT4b_1642007029_client_17', attrs=3D{}), entry4(cookie=3D182, name=
=3Db'owner_REBT4b_1642007029_client_18', attrs=3D{}), entry4(cookie=3D188, =
name=3Db'owner_REBT4b_1642007029_client_19', attrs=3D{}), entry4(cookie=3D1=
94, name=3Db'owner_REBT4b_1642007029_client_20', attrs=3D{}), entry4(cookie=
=3D200, name=3Db'owner_REBT4b_1642007029_client_21', attrs=3D{}), entry4(co=
okie=3D206, name=3Db'owner_REBT4b_1642007029_client_22', attrs=3D{}), entry=
4(cookie=3D212, name=3Db'owner_REBT4b_1642007029_client_23', attrs=3D{}), e=
ntry4(cookie=3D218, name=3Db'owner_REBT4b_1642007029_client_24', attrs=3D{}=
), entry4(cookie=3D224, name=3Db'owner_REBT4b_1642007029_client_25', attrs=
=3D{}), entry4(cookie=3D230, name=3Db'owner_REBT4b_1642007029_client_26', a=
ttrs=3D{}), entry4(cookie=3D236, name=3Db'owner_REBT4b_1642007029_client_27=
', attrs=3D{}), entry4(cookie=3D242, name=3Db'owner_REBT4b_1642007029_clien=
t_28', attrs=3D{}), entry4(cookie=3D248, name=3Db'owner_REBT4b_1642007029_c=
lient_29', attrs=3D{}), entry4(cookie
> >>>  =3D254, name=3Db'owner_REBT4b_1642007029_client_30', attrs=3D{}), en=
try4(cookie=3D260, name=3Db'owner_REBT4b_1642007029_client_31', attrs=3D{})=
, entry4(cookie=3D266, name=3Db'owner_REBT4b_1642007029_client_32', attrs=
=3D{}), entry4(cookie=3D272, name=3Db'owner_REBT4b_1642007029_client_33', a=
ttrs=3D{}), entry4(cookie=3D278, name=3Db'owner_REBT4b_1642007029_client_34=
', attrs=3D{}), entry4(cookie=3D284, name=3Db'owner_REBT4b_1642007029_clien=
t_35', attrs=3D{}), entry4(cookie=3D290, name=3Db'owner_REBT4b_1642007029_c=
lient_36', attrs=3D{}), entry4(cookie=3D296, name=3Db'owner_REBT4b_16420070=
29_client_37', attrs=3D{}), entry4(cookie=3D302, name=3Db'owner_REBT4b_1642=
007029_client_38', attrs=3D{}), entry4(cookie=3D308, name=3Db'owner_REBT4b_=
1642007029_client_39', attrs=3D{}), entry4(cookie=3D314, name=3Db'owner_REB=
T4b_1642007029_client_40', attrs=3D{}), entry4(cookie=3D320, name=3Db'owner=
_REBT4b_1642007029_client_41', attrs=3D{}), entry4(cookie=3D326, name=3Db'o=
wner_REBT4b_1642007029_client_42', attrs=3D{}), entry4(cookie=3D332, name=
=3Db'owner_REBT4b_1642007029_client_43',
> >>>   attrs=3D{}), entry4(cookie=3D338, name=3Db'owner_REBT4b_1642007029_=
client_44', attrs=3D{}), entry4(cookie=3D344, name=3Db'owner_REBT4b_1642007=
029_client_45', attrs=3D{}), entry4(cookie=3D350, name=3Db'owner_REBT4b_164=
2007029_client_46', attrs=3D{}), entry4(cookie=3D356, name=3Db'owner_REBT4b=
_1642007029_client_47', attrs=3D{}), entry4(cookie=3D362, name=3Db'owner_RE=
BT4b_1642007029_client_48', attrs=3D{}), entry4(cookie=3D368, name=3Db'owne=
r_REBT4b_1642007029_client_49', attrs=3D{}), entry4(cookie=3D374, name=3Db'=
owner_REBT4b_1642007029_client_50', attrs=3D{}), entry4(cookie=3D380, name=
=3Db'owner_REBT4b_1642007029_client_51', attrs=3D{}), entry4(cookie=3D386, =
name=3Db'owner_REBT4b_1642007029_client_52', attrs=3D{}), entry4(cookie=3D3=
92, name=3Db'owner_REBT4b_1642007029_client_53', attrs=3D{}), entry4(cookie=
=3D398, name=3Db'owner_REBT4b_1642007029_client_54', attrs=3D{}), entry4(co=
okie=3D404, name=3Db'owner_REBT4b_1642007029_client_55', attrs=3D{}), entry=
4(cookie=3D410, name=3Db'owner_REBT4b_1642007029_client_56', attrs=3D{}), e=
ntry4(cookie=3D416, name=3Db'owner_REBT
> >>>  4b_1642007029_client_57', attrs=3D{}), entry4(cookie=3D422, name=3Db=
'owner_REBT4b_1642007029_client_58', attrs=3D{}), entry4(cookie=3D428, name=
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
> >>>  ie=3D500, name=3Db'owner_REBT4b_1642007029_client_71', attrs=3D{}), =
entry4(cookie=3D506, name=3Db'owner_REBT4b_1642007029_client_72', attrs=3D{=
}), entry4(cookie=3D520, name=3Db'owner_REBT4b_1642007029_client_73', attrs=
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
> >>>  ', attrs=3D{}), entry4(cookie=3D592, name=3Db'owner_REBT4b_164200702=
9_client_85', attrs=3D{}), entry4(cookie=3D598, name=3Db'owner_REBT4b_16420=
07029_client_86', attrs=3D{}), entry4(cookie=3D604, name=3Db'owner_REBT4b_1=
642007029_client_87', attrs=3D{}), entry4(cookie=3D610, name=3Db'owner_REBT=
4b_1642007029_client_88', attrs=3D{}), entry4(cookie=3D616, name=3Db'owner_=
REBT4b_1642007029_client_89', attrs=3D{}), entry4(cookie=3D622, name=3Db'ow=
ner_REBT4b_1642007029_client_90', attrs=3D{}), entry4(cookie=3D628, name=3D=
b'owner_REBT4b_1642007029_client_91', attrs=3D{}), entry4(cookie=3D634, nam=
e=3Db'owner_REBT4b_1642007029_client_92', attrs=3D{}), entry4(cookie=3D640,=
 name=3Db'owner_REBT4b_1642007029_client_93', attrs=3D{}), entry4(cookie=3D=
646, name=3Db'owner_REBT4b_1642007029_client_94', attrs=3D{}), entry4(cooki=
e=3D652, name=3Db'owner_REBT4b_1642007029_client_95', attrs=3D{}), entry4(c=
ookie=3D658, name=3Db'owner_REBT4b_1642007029_client_96', attrs=3D{}), entr=
y4(cookie=3D664, name=3Db'owner_REBT4b_1642007029_client_97', attrs=3D{}), =
entry4(cookie=3D670, name=3Db'owner_RE
> >>>  BT4b_1642007029_client_98', attrs=3D{}), entry4(cookie=3D676, name=
=3Db'owner_REBT4b_1642007029_client_99', attrs=3D{}), entry4(cookie=3D682, =
name=3Db'owner_REBT2b_1642007029_client_0', attrs=3D{}), entry4(cookie=3D68=
8, name=3Db'owner_REBT2b_1642007029_client_1', attrs=3D{}), entry4(cookie=
=3D694, name=3Db'owner_REBT2b_1642007029_client_2', attrs=3D{}), entry4(coo=
kie=3D700, name=3Db'owner_REBT2b_1642007029_client_3', attrs=3D{}), entry4(=
cookie=3D706, name=3Db'owner_REBT2b_1642007029_client_4', attrs=3D{}), entr=
y4(cookie=3D712, name=3Db'owner_REBT2b_1642007029_client_5', attrs=3D{}), e=
ntry4(cookie=3D718, name=3Db'owner_REBT2b_1642007029_client_6', attrs=3D{})=
, entry4(cookie=3D724, name=3Db'owner_REBT2b_1642007029_client_7', attrs=3D=
{}), entry4(cookie=3D730, name=3Db'owner_REBT2b_1642007029_client_8', attrs=
=3D{}), entry4(cookie=3D736, name=3Db'owner_REBT2b_1642007029_client_9', at=
trs=3D{}), entry4(cookie=3D742, name=3Db'owner_REBT2b_1642007029_client_10'=
, attrs=3D{}), entry4(cookie=3D748, name=3Db'owner_REBT2b_1642007029_client=
_11', attrs=3D{}), entry4(cookie=3D754,
> >>>  name=3Db'owner_REBT2b_1642007029_client_12', attrs=3D{}), entry4(coo=
kie=3D760, name=3Db'owner_REBT2b_1642007029_client_13', attrs=3D{}), entry4=
(cookie=3D766, name=3Db'owner_REBT2b_1642007029_client_14', attrs=3D{}), en=
try4(cookie=3D772, name=3Db'owner_REBT2b_1642007029_client_15', attrs=3D{})=
, entry4(cookie=3D778, name=3Db'owner_REBT2b_1642007029_client_16', attrs=
=3D{}), entry4(cookie=3D784, name=3Db'owner_REBT2b_1642007029_client_17', a=
ttrs=3D{}), entry4(cookie=3D790, name=3Db'owner_REBT2b_1642007029_client_18=
', attrs=3D{}), entry4(cookie=3D796, name=3Db'owner_REBT2b_1642007029_clien=
t_19', attrs=3D{}), entry4(cookie=3D802, name=3Db'owner_REBT2b_1642007029_c=
lient_20', attrs=3D{}), entry4(cookie=3D808, name=3Db'owner_REBT2b_16420070=
29_client_21', attrs=3D{}), entry4(cookie=3D814, name=3Db'owner_REBT2b_1642=
007029_client_22', attrs=3D{}), entry4(cookie=3D820, name=3Db'owner_REBT2b_=
1642007029_client_23', attrs=3D{}), entry4(cookie=3D826, name=3Db'owner_REB=
T2b_1642007029_client_24', attrs=3D{}), entry4(cookie=3D832, name=3Db'owner=
_REBT2b_1642007029_client_25', attrs
> >>>  =3D{}), entry4(cookie=3D838, name=3Db'owner_REBT2b_1642007029_client=
_26', attrs=3D{}), entry4(cookie=3D844, name=3Db'owner_REBT2b_1642007029_cl=
ient_27', attrs=3D{}), entry4(cookie=3D850, name=3Db'owner_REBT2b_164200702=
9_client_28', attrs=3D{}), entry4(cookie=3D856, name=3Db'owner_REBT2b_16420=
07029_client_29', attrs=3D{}), entry4(cookie=3D862, name=3Db'owner_REBT2b_1=
642007029_client_30', attrs=3D{}), entry4(cookie=3D868, name=3Db'owner_REBT=
2b_1642007029_client_31', attrs=3D{}), entry4(cookie=3D874, name=3Db'owner_=
REBT2b_1642007029_client_32', attrs=3D{}), entry4(cookie=3D880, name=3Db'ow=
ner_REBT2b_1642007029_client_33', attrs=3D{}), entry4(cookie=3D886, name=3D=
b'owner_REBT2b_1642007029_client_34', attrs=3D{}), entry4(cookie=3D892, nam=
e=3Db'owner_REBT2b_1642007029_client_35', attrs=3D{}), entry4(cookie=3D898,=
 name=3Db'owner_REBT2b_1642007029_client_36', attrs=3D{}), entry4(cookie=3D=
904, name=3Db'owner_REBT2b_1642007029_client_37', attrs=3D{}), entry4(cooki=
e=3D910, name=3Db'owner_REBT2b_1642007029_client_38', attrs=3D{}), entry4(c=
ookie=3D916, name=3Db'owner_REBT2b_164
> >>>  2007029_client_39', attrs=3D{}), entry4(cookie=3D922, name=3Db'owner=
_REBT2b_1642007029_client_40', attrs=3D{}), entry4(cookie=3D928, name=3Db'o=
wner_REBT2b_1642007029_client_41', attrs=3D{}), entry4(cookie=3D934, name=
=3Db'owner_REBT2b_1642007029_client_42', attrs=3D{}), entry4(cookie=3D940, =
name=3Db'owner_REBT2b_1642007029_client_43', attrs=3D{}), entry4(cookie=3D9=
46, name=3Db'owner_REBT2b_1642007029_client_44', attrs=3D{}), entry4(cookie=
=3D952, name=3Db'owner_REBT2b_1642007029_client_45', attrs=3D{}), entry4(co=
okie=3D958, name=3Db'owner_REBT2b_1642007029_client_46', attrs=3D{}), entry=
4(cookie=3D964, name=3Db'owner_REBT2b_1642007029_client_47', attrs=3D{}), e=
ntry4(cookie=3D970, name=3Db'owner_REBT2b_1642007029_client_48', attrs=3D{}=
), entry4(cookie=3D976, name=3Db'owner_REBT2b_1642007029_client_49', attrs=
=3D{}), entry4(cookie=3D982, name=3Db'owner_REBT2b_1642007029_client_50', a=
ttrs=3D{}), entry4(cookie=3D988, name=3Db'owner_REBT2b_1642007029_client_51=
', attrs=3D{}), entry4(cookie=3D994, name=3Db'owner_REBT2b_1642007029_clien=
t_52', attrs=3D{}), entry4(cookie=3D100
> >>>  0, name=3Db'owner_REBT2b_1642007029_client_53', attrs=3D{}), entry4(=
cookie=3D1006, name=3Db'owner_REBT2b_1642007029_client_54', attrs=3D{}), en=
try4(cookie=3D1012, name=3Db'owner_REBT2b_1642007029_client_55', attrs=3D{}=
), entry4(cookie=3D1018, name=3Db'owner_REBT2b_1642007029_client_56', attrs=
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
> >>>  lient_66', attrs=3D{}), entry4(cookie=3D1092, name=3Db'owner_REBT2b_=
1642007029_client_67', attrs=3D{}), entry4(cookie=3D1098, name=3Db'owner_RE=
BT2b_1642007029_client_68', attrs=3D{}), entry4(cookie=3D1104, name=3Db'own=
er_REBT2b_1642007029_client_69', attrs=3D{}), entry4(cookie=3D1110, name=3D=
b'owner_REBT2b_1642007029_client_70', attrs=3D{}), entry4(cookie=3D1116, na=
me=3Db'owner_REBT2b_1642007029_client_71', attrs=3D{}), entry4(cookie=3D112=
2, name=3Db'owner_REBT2b_1642007029_client_72', attrs=3D{}), entry4(cookie=
=3D1128, name=3Db'owner_REBT2b_1642007029_client_73', attrs=3D{}), entry4(c=
ookie=3D1134, name=3Db'owner_REBT2b_1642007029_client_74', attrs=3D{}), ent=
ry4(cookie=3D1140, name=3Db'owner_REBT2b_1642007029_client_75', attrs=3D{})=
, entry4(cookie=3D1146, name=3Db'owner_REBT2b_1642007029_client_76', attrs=
=3D{}), entry4(cookie=3D1152, name=3Db'owner_REBT2b_1642007029_client_77', =
attrs=3D{}), entry4(cookie=3D1158, name=3Db'owner_REBT2b_1642007029_client_=
78', attrs=3D{}), entry4(cookie=3D1164, name=3Db'owner_REBT2b_1642007029_cl=
ient_79', attrs=3D{}), entry4(cookie
> >>>  =3D1170, name=3Db'owner_REBT2b_1642007029_client_80', attrs=3D{}), e=
ntry4(cookie=3D1176, name=3Db'owner_REBT2b_1642007029_client_81', attrs=3D{=
}), entry4(cookie=3D1182, name=3Db'owner_REBT2b_1642007029_client_82', attr=
s=3D{}), entry4(cookie=3D1188, name=3Db'owner_REBT2b_1642007029_client_83',=
 attrs=3D{}), entry4(cookie=3D1194, name=3Db'owner_REBT2b_1642007029_client=
_84', attrs=3D{}), entry4(cookie=3D1200, name=3Db'owner_REBT2b_1642007029_c=
lient_85', attrs=3D{}), entry4(cookie=3D1206, name=3Db'owner_REBT2b_1642007=
029_client_86', attrs=3D{}), entry4(cookie=3D1212, name=3Db'owner_REBT2b_16=
42007029_client_87', attrs=3D{}), entry4(cookie=3D1218, name=3Db'owner_REBT=
2b_1642007029_client_88', attrs=3D{}), entry4(cookie=3D1224, name=3Db'owner=
_REBT2b_1642007029_client_89', attrs=3D{}), entry4(cookie=3D1230, name=3Db'=
owner_REBT2b_1642007029_client_90', attrs=3D{}), entry4(cookie=3D1236, name=
=3Db'owner_REBT2b_1642007029_client_91', attrs=3D{}), entry4(cookie=3D1242,=
 name=3Db'owner_REBT2b_1642007029_client_92', attrs=3D{}), entry4(cookie=3D=
1248, name=3Db'owner_REBT2b_16420070
> >>>  29_client_93', attrs=3D{}), entry4(cookie=3D1254, name=3Db'owner_REB=
T2b_1642007029_client_94', attrs=3D{}), entry4(cookie=3D1260, name=3Db'owne=
r_REBT2b_1642007029_client_95', attrs=3D{}), entry4(cookie=3D1266, name=3Db=
'owner_REBT2b_1642007029_client_96', attrs=3D{}), entry4(cookie=3D1272, nam=
e=3Db'owner_REBT2b_1642007029_client_97', attrs=3D{}), entry4(cookie=3D1278=
, name=3Db'owner_REBT2b_1642007029_client_98', attrs=3D{}), entry4(cookie=
=3D1284, name=3Db'owner_REBT2b_1642007029_client_99', attrs=3D{}), entry4(c=
ookie=3D1290, name=3Db'owner_REBT4a_1642007029_client_0', attrs=3D{}), entr=
y4(cookie=3D1296, name=3Db'owner_REBT4a_1642007029_client_1', attrs=3D{}), =
entry4(cookie=3D1302, name=3Db'owner_REBT4a_1642007029_client_2', attrs=3D{=
}), entry4(cookie=3D1308, name=3Db'owner_REBT4a_1642007029_client_3', attrs=
=3D{}), entry4(cookie=3D1314, name=3Db'owner_REBT4a_1642007029_client_4', a=
ttrs=3D{}), entry4(cookie=3D1320, name=3Db'owner_REBT4a_1642007029_client_5=
', attrs=3D{}), entry4(cookie=3D1326, name=3Db'owner_REBT4a_1642007029_clie=
nt_6', attrs=3D{}), entry4(cookie=3D13
> >>>  32, name=3Db'owner_REBT4a_1642007029_client_7', attrs=3D{}), entry4(=
cookie=3D1338, name=3Db'owner_REBT4a_1642007029_client_8', attrs=3D{}), ent=
ry4(cookie=3D1344, name=3Db'owner_REBT4a_1642007029_client_9', attrs=3D{}),=
 entry4(cookie=3D1350, name=3Db'owner_REBT2a_1642007029_client_0', attrs=3D=
{}), entry4(cookie=3D1356, name=3Db'owner_REBT2a_1642007029_client_1', attr=
s=3D{}), entry4(cookie=3D1362, name=3Db'owner_REBT2a_1642007029_client_2', =
attrs=3D{}), entry4(cookie=3D1368, name=3Db'owner_REBT2a_1642007029_client_=
3', attrs=3D{}), entry4(cookie=3D1374, name=3Db'owner_REBT2a_1642007029_cli=
ent_4', attrs=3D{}), entry4(cookie=3D1380, name=3Db'owner_REBT2a_1642007029=
_client_5', attrs=3D{}), entry4(cookie=3D1386, name=3Db'owner_REBT2a_164200=
7029_client_6', attrs=3D{}), entry4(cookie=3D1392, name=3Db'owner_REBT2a_16=
42007029_client_7', attrs=3D{}), entry4(cookie=3D1398, name=3Db'owner_REBT2=
a_1642007029_client_8', attrs=3D{}), entry4(cookie=3D1404, name=3Db'owner_R=
EBT2a_1642007029_client_9', attrs=3D{}), entry4(cookie=3D1410, name=3Db'own=
er_REBT5_1642007029_client_file_0'
> >>>  , attrs=3D{}), entry4(cookie=3D1416, name=3Db'owner_REBT5_1642007029=
_client_file_1', attrs=3D{}), entry4(cookie=3D1422, name=3Db'owner_REBT5_16=
42007029_client_file_2', attrs=3D{}), entry4(cookie=3D1428, name=3Db'owner_=
REBT5_1642007029_client_file_3', attrs=3D{}), entry4(cookie=3D1434, name=3D=
b'owner_REBT5_1642007029_client_file_4', attrs=3D{}), entry4(cookie=3D1440,=
 name=3Db'owner_REBT5_1642007029_client_file_5', attrs=3D{}), entry4(cookie=
=3D1446, name=3Db'owner_REBT5_1642007029_client_file_6', attrs=3D{}), entry=
4(cookie=3D1452, name=3Db'owner_REBT5_1642007029_client_file_7', attrs=3D{}=
), entry4(cookie=3D1458, name=3Db'owner_REBT5_1642007029_client_file_8', at=
trs=3D{}), entry4(cookie=3D1464, name=3Db'owner_REBT5_1642007029_client_fil=
e_9', attrs=3D{}), entry4(cookie=3D1471, name=3Db'owner_REBT5_1642007029_cl=
ient_file_10', attrs=3D{}), entry4(cookie=3D1478, name=3Db'owner_REBT5_1642=
007029_client_file_11', attrs=3D{}), entry4(cookie=3D1485, name=3Db'owner_R=
EBT5_1642007029_client_file_12', attrs=3D{}), entry4(cookie=3D1492, name=3D=
b'owner_REBT5_1642007029_client_
> >>>  file_13', attrs=3D{}), entry4(cookie=3D1499, name=3Db'owner_REBT5_16=
42007029_client_file_14', attrs=3D{}), entry4(cookie=3D1506, name=3Db'owner=
_REBT5_1642007029_client_file_15', attrs=3D{}), entry4(cookie=3D1513, name=
=3Db'owner_REBT5_1642007029_client_file_16', attrs=3D{}), entry4(cookie=3D1=
520, name=3Db'owner_REBT5_1642007029_client_file_17', attrs=3D{}), entry4(c=
ookie=3D1527, name=3Db'owner_REBT5_1642007029_client_file_18', attrs=3D{}),=
 entry4(cookie=3D1544, name=3Db'owner_REBT5_1642007029_client_file_19', att=
rs=3D{}), entry4(cookie=3D1551, name=3Db'owner_REBT5_1642007029_client_file=
_20', attrs=3D{}), entry4(cookie=3D1558, name=3Db'owner_REBT5_1642007029_cl=
ient_file_21', attrs=3D{}), entry4(cookie=3D1565, name=3Db'owner_REBT5_1642=
007029_client_file_22', attrs=3D{}), entry4(cookie=3D1572, name=3Db'owner_R=
EBT5_1642007029_client_file_23', attrs=3D{}), entry4(cookie=3D1579, name=3D=
b'owner_REBT5_1642007029_client_file_24', attrs=3D{}), entry4(cookie=3D1586=
, name=3Db'owner_REBT5_1642007029_client_file_25', attrs=3D{}), entry4(cook=
ie=3D1593, name=3Db'owner_REBT5_1
> >>>  642007029_client_file_26', attrs=3D{}), entry4(cookie=3D1600, name=
=3Db'owner_REBT5_1642007029_client_file_27', attrs=3D{}), entry4(cookie=3D1=
607, name=3Db'owner_REBT5_1642007029_client_file_28', attrs=3D{}), entry4(c=
ookie=3D1614, name=3Db'owner_REBT5_1642007029_client_file_29', attrs=3D{}),=
 entry4(cookie=3D1621, name=3Db'owner_REBT5_1642007029_client_file_30', att=
rs=3D{}), entry4(cookie=3D1628, name=3Db'owner_REBT5_1642007029_client_file=
_31', attrs=3D{}), entry4(cookie=3D1635, name=3Db'owner_REBT5_1642007029_cl=
ient_file_32', attrs=3D{}), entry4(cookie=3D1642, name=3Db'owner_REBT5_1642=
007029_client_file_33', attrs=3D{}), entry4(cookie=3D1649, name=3Db'owner_R=
EBT5_1642007029_client_file_34', attrs=3D{}), entry4(cookie=3D1656, name=3D=
b'owner_REBT5_1642007029_client_file_35', attrs=3D{}), entry4(cookie=3D1663=
, name=3Db'owner_REBT5_1642007029_client_file_36', attrs=3D{}), entry4(cook=
ie=3D1670, name=3Db'owner_REBT5_1642007029_client_file_37', attrs=3D{}), en=
try4(cookie=3D1677, name=3Db'owner_REBT5_1642007029_client_file_38', attrs=
=3D{}), entry4(cookie=3D1684, nam
> >>>  e=3Db'owner_REBT5_1642007029_client_file_39', attrs=3D{}), entry4(co=
okie=3D1691, name=3Db'owner_REBT5_1642007029_client_file_40', attrs=3D{}), =
entry4(cookie=3D1698, name=3Db'owner_REBT5_1642007029_client_file_41', attr=
s=3D{}), entry4(cookie=3D1703, name=3Db'owner_REBT1_1642007029', attrs=3D{}=
), entry4(cookie=3D1709, name=3Db'owner_REBT3b_1642007029_client_0', attrs=
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
> >>>  s=3D{}), entry4(cookie=3D1769, name=3Db'owner_REBT3b_1642007029_clie=
nt_10', attrs=3D{}), entry4(cookie=3D1775, name=3Db'owner_REBT3b_1642007029=
_client_11', attrs=3D{}), entry4(cookie=3D1781, name=3Db'owner_REBT3b_16420=
07029_client_12', attrs=3D{}), entry4(cookie=3D1787, name=3Db'owner_REBT3b_=
1642007029_client_13', attrs=3D{}), entry4(cookie=3D1793, name=3Db'owner_RE=
BT3b_1642007029_client_14', attrs=3D{}), entry4(cookie=3D1799, name=3Db'own=
er_REBT3b_1642007029_client_15', attrs=3D{}), entry4(cookie=3D1805, name=3D=
b'owner_REBT3b_1642007029_client_16', attrs=3D{}), entry4(cookie=3D1811, na=
me=3Db'owner_REBT3b_1642007029_client_17', attrs=3D{}), entry4(cookie=3D181=
7, name=3Db'owner_REBT3b_1642007029_client_18', attrs=3D{}), entry4(cookie=
=3D1823, name=3Db'owner_REBT3b_1642007029_client_19', attrs=3D{}), entry4(c=
ookie=3D1829, name=3Db'owner_REBT3b_1642007029_client_20', attrs=3D{}), ent=
ry4(cookie=3D1835, name=3Db'owner_REBT3b_1642007029_client_21', attrs=3D{})=
, entry4(cookie=3D1841, name=3Db'owner_REBT3b_1642007029_client_22', attrs=
=3D{}), entry4(cookie=3D1847, name=3Db'o
> >>>  wner_REBT3b_1642007029_client_23', attrs=3D{}), entry4(cookie=3D1853=
, name=3Db'owner_REBT3b_1642007029_client_24', attrs=3D{}), entry4(cookie=
=3D1859, name=3Db'owner_REBT3b_1642007029_client_25', attrs=3D{}), entry4(c=
ookie=3D1865, name=3Db'owner_REBT3b_1642007029_client_26', attrs=3D{}), ent=
ry4(cookie=3D1871, name=3Db'owner_REBT3b_1642007029_client_27', attrs=3D{})=
, entry4(cookie=3D1877, name=3Db'owner_REBT3b_1642007029_client_28', attrs=
=3D{}), entry4(cookie=3D1883, name=3Db'owner_REBT3b_1642007029_client_29', =
attrs=3D{}), entry4(cookie=3D1889, name=3Db'owner_REBT3b_1642007029_client_=
30', attrs=3D{}), entry4(cookie=3D1895, name=3Db'owner_REBT3b_1642007029_cl=
ient_31', attrs=3D{}), entry4(cookie=3D1901, name=3Db'owner_REBT3b_16420070=
29_client_32', attrs=3D{}), entry4(cookie=3D1907, name=3Db'owner_REBT3b_164=
2007029_client_33', attrs=3D{}), entry4(cookie=3D1913, name=3Db'owner_REBT3=
b_1642007029_client_34', attrs=3D{}), entry4(cookie=3D1919, name=3Db'owner_=
REBT3b_1642007029_client_35', attrs=3D{}), entry4(cookie=3D1925, name=3Db'o=
wner_REBT3b_1642007029_client_36',
> >>>  attrs=3D{}), entry4(cookie=3D1931, name=3Db'owner_REBT3b_1642007029_=
client_37', attrs=3D{}), entry4(cookie=3D1937, name=3Db'owner_REBT3b_164200=
7029_client_38', attrs=3D{}), entry4(cookie=3D1943, name=3Db'owner_REBT3b_1=
642007029_client_39', attrs=3D{}), entry4(cookie=3D1949, name=3Db'owner_REB=
T3b_1642007029_client_40', attrs=3D{}), entry4(cookie=3D1955, name=3Db'owne=
r_REBT3b_1642007029_client_41', attrs=3D{}), entry4(cookie=3D1961, name=3Db=
'owner_REBT3b_1642007029_client_42', attrs=3D{}), entry4(cookie=3D1967, nam=
e=3Db'owner_REBT3b_1642007029_client_43', attrs=3D{}), entry4(cookie=3D1973=
, name=3Db'owner_REBT3b_1642007029_client_44', attrs=3D{}), entry4(cookie=
=3D1979, name=3Db'owner_REBT3b_1642007029_client_45', attrs=3D{}), entry4(c=
ookie=3D1985, name=3Db'owner_REBT3b_1642007029_client_46', attrs=3D{}), ent=
ry4(cookie=3D1991, name=3Db'owner_REBT3b_1642007029_client_47', attrs=3D{})=
, entry4(cookie=3D1997, name=3Db'owner_REBT3b_1642007029_client_48', attrs=
=3D{}), entry4(cookie=3D2003, name=3Db'owner_REBT3b_1642007029_client_49', =
attrs=3D{}), entry4(cookie=3D2009, name
> >>>  =3Db'owner_REBT3b_1642007029_client_50', attrs=3D{}), entry4(cookie=
=3D2015, name=3Db'owner_REBT3b_1642007029_client_51', attrs=3D{}), entry4(c=
ookie=3D2021, name=3Db'owner_REBT3b_1642007029_client_52', attrs=3D{}), ent=
ry4(cookie=3D2027, name=3Db'owner_REBT3b_1642007029_client_53', attrs=3D{})=
, entry4(cookie=3D2033, name=3Db'owner_REBT3b_1642007029_client_54', attrs=
=3D{}), entry4(cookie=3D2039, name=3Db'owner_REBT3b_1642007029_client_55', =
attrs=3D{}), entry4(cookie=3D2056, name=3Db'owner_REBT3b_1642007029_client_=
56', attrs=3D{}), entry4(cookie=3D2062, name=3Db'owner_REBT3b_1642007029_cl=
ient_57', attrs=3D{}), entry4(cookie=3D2068, name=3Db'owner_REBT3b_16420070=
29_client_58', attrs=3D{}), entry4(cookie=3D2074, name=3Db'owner_REBT3b_164=
2007029_client_59', attrs=3D{}), entry4(cookie=3D2080, name=3Db'owner_REBT3=
b_1642007029_client_60', attrs=3D{}), entry4(cookie=3D2086, name=3Db'owner_=
REBT3b_1642007029_client_61', attrs=3D{}), entry4(cookie=3D2092, name=3Db'o=
wner_REBT3b_1642007029_client_62', attrs=3D{}), entry4(cookie=3D2098, name=
=3Db'owner_REBT3b_1642007029_client_6
> >>>  3', attrs=3D{}), entry4(cookie=3D2104, name=3Db'owner_REBT3b_1642007=
029_client_64', attrs=3D{}), entry4(cookie=3D2110, name=3Db'owner_REBT3b_16=
42007029_client_65', attrs=3D{}), entry4(cookie=3D2116, name=3Db'owner_REBT=
3b_1642007029_client_66', attrs=3D{}), entry4(cookie=3D2122, name=3Db'owner=
_REBT3b_1642007029_client_67', attrs=3D{}), entry4(cookie=3D2128, name=3Db'=
owner_REBT3b_1642007029_client_68', attrs=3D{}), entry4(cookie=3D2134, name=
=3Db'owner_REBT3b_1642007029_client_69', attrs=3D{}), entry4(cookie=3D2140,=
 name=3Db'owner_REBT3b_1642007029_client_70', attrs=3D{}), entry4(cookie=3D=
2146, name=3Db'owner_REBT3b_1642007029_client_71', attrs=3D{}), entry4(cook=
ie=3D2152, name=3Db'owner_REBT3b_1642007029_client_72', attrs=3D{}), entry4=
(cookie=3D2158, name=3Db'owner_REBT3b_1642007029_client_73', attrs=3D{}), e=
ntry4(cookie=3D2164, name=3Db'owner_REBT3b_1642007029_client_74', attrs=3D{=
}), entry4(cookie=3D2170, name=3Db'owner_REBT3b_1642007029_client_75', attr=
s=3D{}), entry4(cookie=3D2176, name=3Db'owner_REBT3b_1642007029_client_76',=
 attrs=3D{}), entry4(cookie=3D2182,
> >>>  name=3Db'owner_REBT3b_1642007029_client_77', attrs=3D{}), entry4(coo=
kie=3D2188, name=3Db'owner_REBT3b_1642007029_client_78', attrs=3D{}), entry=
4(cookie=3D2194, name=3Db'owner_REBT3b_1642007029_client_79', attrs=3D{}), =
entry4(cookie=3D2200, name=3Db'owner_REBT3b_1642007029_client_80', attrs=3D=
{}), entry4(cookie=3D2206, name=3Db'owner_REBT3b_1642007029_client_81', att=
rs=3D{}), entry4(cookie=3D2212, name=3Db'owner_REBT3b_1642007029_client_82'=
, attrs=3D{}), entry4(cookie=3D2218, name=3Db'owner_REBT3b_1642007029_clien=
t_83', attrs=3D{}), entry4(cookie=3D2224, name=3Db'owner_REBT3b_1642007029_=
client_84', attrs=3D{}), entry4(cookie=3D2230, name=3Db'owner_REBT3b_164200=
7029_client_85', attrs=3D{}), entry4(cookie=3D2236, name=3Db'owner_REBT3b_1=
642007029_client_86', attrs=3D{}), entry4(cookie=3D2242, name=3Db'owner_REB=
T3b_1642007029_client_87', attrs=3D{}), entry4(cookie=3D2248, name=3Db'owne=
r_REBT3b_1642007029_client_88', attrs=3D{}), entry4(cookie=3D2254, name=3Db=
'owner_REBT3b_1642007029_client_89', attrs=3D{}), entry4(cookie=3D2260, nam=
e=3Db'owner_REBT3b_1642007029_clie
> >>>  nt_90', attrs=3D{}), entry4(cookie=3D2266, name=3Db'owner_REBT3b_164=
2007029_client_91', attrs=3D{}), entry4(cookie=3D2272, name=3Db'owner_REBT3=
b_1642007029_client_92', attrs=3D{}), entry4(cookie=3D2278, name=3Db'owner_=
REBT3b_1642007029_client_93', attrs=3D{}), entry4(cookie=3D2284, name=3Db'o=
wner_REBT3b_1642007029_client_94', attrs=3D{}), entry4(cookie=3D2290, name=
=3Db'owner_REBT3b_1642007029_client_95', attrs=3D{}), entry4(cookie=3D2296,=
 name=3Db'owner_REBT3b_1642007029_client_96', attrs=3D{}), entry4(cookie=3D=
2302, name=3Db'owner_REBT3b_1642007029_client_97', attrs=3D{}), entry4(cook=
ie=3D2308, name=3Db'owner_REBT3b_1642007029_client_98', attrs=3D{}), entry4=
(cookie=3D2314, name=3Db'owner_REBT3b_1642007029_client_99', attrs=3D{}), e=
ntry4(cookie=3D2320, name=3Db'owner_REBT3a_1642007029_client_0', attrs=3D{}=
), entry4(cookie=3D2326, name=3Db'owner_REBT3a_1642007029_client_1', attrs=
=3D{}), entry4(cookie=3D2332, name=3Db'owner_REBT3a_1642007029_client_2', a=
ttrs=3D{}), entry4(cookie=3D2338, name=3Db'owner_REBT3a_1642007029_client_3=
', attrs=3D{}), entry4(cookie=3D2344,
> >>>  name=3Db'owner_REBT3a_1642007029_client_4', attrs=3D{}), entry4(cook=
ie=3D2350, name=3Db'owner_REBT3a_1642007029_client_5', attrs=3D{}), entry4(=
cookie=3D2356, name=3Db'owner_REBT3a_1642007029_client_6', attrs=3D{}), ent=
ry4(cookie=3D2362, name=3Db'owner_REBT3a_1642007029_client_7', attrs=3D{}),=
 entry4(cookie=3D2368, name=3Db'owner_REBT3a_1642007029_client_8', attrs=3D=
{}), entry4(cookie=3D2374, name=3Db'owner_REBT3a_1642007029_client_9', attr=
s=3D{}), entry4(cookie=3D2378, name=3Db'RNM6_1642007029', attrs=3D{}), entr=
y4(cookie=3D2382, name=3Db'RNM7_1642007029', attrs=3D{}), entry4(cookie=3D2=
386, name=3Db'RNM1s_1642007029', attrs=3D{}), entry4(cookie=3D2390, name=3D=
b'RNM1a_1642007029', attrs=3D{}), entry4(cookie=3D2394, name=3Db'RNM1r_1642=
007029', attrs=3D{}), entry4(cookie=3D2398, name=3Db'RNM1f_1642007029', att=
rs=3D{}), entry4(cookie=3D2402, name=3Db'RNM1d_1642007029', attrs=3D{}), en=
try4(cookie=3D2406, name=3Db'RNM19_1642007029', attrs=3D{}), entry4(cookie=
=3D2410, name=3Db'RNM18_1642007029', attrs=3D{}), entry4(cookie=3D2414, nam=
e=3Db'RNM5_1642007029', attrs=3D{}), entry4(cooki
> >>>  e=3D2418, name=3Db'RNM20_1642007029', attrs=3D{}), entry4(cookie=3D2=
422, name=3Db'RNM17_1642007029', attrs=3D{}), entry4(cookie=3D2426, name=3D=
b'RNM15_1642007029', attrs=3D{}), entry4(cookie=3D2430, name=3Db'RNM14_1642=
007029', attrs=3D{}), entry4(cookie=3D2434, name=3Db'RNM10_1642007029', att=
rs=3D{}), entry4(cookie=3D2438, name=3Db'RNM11_1642007029', attrs=3D{}), en=
try4(cookie=3D2442, name=3Db'RNM12_1642007029', attrs=3D{}), entry4(cookie=
=3D2446, name=3Db'RNM16_1642007029', attrs=3D{}), entry4(cookie=3D2450, nam=
e=3Db'RNM13_1642007029', attrs=3D{}), entry4(cookie=3D2454, name=3Db'RNM3s_=
1642007029', attrs=3D{}), entry4(cookie=3D2458, name=3Db'RNM3a_1642007029',=
 attrs=3D{}), entry4(cookie=3D2462, name=3Db'RNM3r_1642007029', attrs=3D{})=
, entry4(cookie=3D2466, name=3Db'RNM3f_1642007029', attrs=3D{}), entry4(coo=
kie=3D2471, name=3Db'owner_DELEG9_1642007029', attrs=3D{}), entry4(cookie=
=3D2475, name=3Db'DELEG23_1642007029', attrs=3D{}), entry4(cookie=3D2479, n=
ame=3Db'DELEG1_1642007029', attrs=3D{}), entry4(cookie=3D2483, name=3Db'DEL=
EG4_1642007029', attrs=3D{}), entry4(cookie=3D2487, name=3Db'DE
> >>>  LEG8_1642007029', attrs=3D{}), entry4(cookie=3D2491, name=3Db'DELEG6=
_1642007029', attrs=3D{}), entry4(cookie=3D2495, name=3Db'OPEN1_1642007029'=
, attrs=3D{}), entry4(cookie=3D2499, name=3Db'OPEN2_1642007029', attrs=3D{}=
), entry4(cookie=3D2503, name=3Db'OPEN30_1642007029', attrs=3D{}), entry4(c=
ookie=3D2507, name=3Db'OPEN7_1642007029', attrs=3D{}), entry4(cookie=3D2511=
, name=3Db'OPEN6_1642007029', attrs=3D{}), entry4(cookie=3D2515, name=3Db'O=
PEN8_1642007029', attrs=3D{}), entry4(cookie=3D2523, name=3Db'OPEN31_164200=
7029', attrs=3D{}), entry4(cookie=3D2531, name=3Db'SEQ10b_1642007029_2', at=
trs=3D{}), entry4(cookie=3D2535, name=3Db'SEQ9b_1642007029_2', attrs=3D{}),=
 entry4(cookie=3D2539, name=3Db'SEC2_1642007029', attrs=3D{}), entry4(cooki=
e=3D2543, name=3Db'SEC1_1642007029', attrs=3D{}), entry4(cookie=3D2560, nam=
e=3Db'owner_RECC2_1642007029', attrs=3D{})]
> >>>INFO   :test.env:Called do_readdir()
> >>>INFO   :test.env:do_readdir() =3D [entry4(cookie=3D14, name=3Db'dir1',=
 attrs=3D{}), entry4(cookie=3D512, name=3Db'dir2', attrs=3D{})]
> >>>INFO   :test.env:Called do_readdir()
> >>>INFO   :test.env:do_readdir() =3D [entry4(cookie=3D512, name=3Db'bar',=
 attrs=3D{})]
> >>>INFO   :test.env:Called do_readdir()
> >>>INFO   :test.env:do_readdir() =3D [entry4(cookie=3D14, name=3Db'dir1',=
 attrs=3D{}), entry4(cookie=3D512, name=3Db'dir2', attrs=3D{})]
> >>>INFO   :test.env:Called do_readdir()
> >>>INFO   :test.env:do_readdir() =3D [entry4(cookie=3D512, name=3Db'bar',=
 attrs=3D{})]
> >>>INFO   :test.env:Called do_readdir()
> >>>INFO   :test.env:do_readdir() =3D [entry4(cookie=3D14, name=3Db'dir1',=
 attrs=3D{}), entry4(cookie=3D512, name=3Db'dir2', attrs=3D{})]
> >>>INFO   :test.env:Called do_readdir()
> >>>INFO   :test.env:do_readdir() =3D [entry4(cookie=3D512, name=3Db'bar',=
 attrs=3D{})]
> >>>INFO   :test.env:Called do_readdir()
> >>>INFO   :test.env:do_readdir() =3D [entry4(cookie=3D14, name=3Db'dir1',=
 attrs=3D{}), entry4(cookie=3D512, name=3Db'dir2', attrs=3D{})]
> >>>INFO   :test.env:Called do_readdir()
> >>>INFO   :test.env:do_readdir() =3D [entry4(cookie=3D512, name=3Db'bar',=
 attrs=3D{})]
> >>>INFO   :test.env:Called do_readdir()
> >>>INFO   :test.env:do_readdir() =3D [entry4(cookie=3D14, name=3Db'dir1',=
 attrs=3D{}), entry4(cookie=3D512, name=3Db'dir2', attrs=3D{})]
> >>>INFO   :test.env:Called do_readdir()
> >>>INFO   :test.env:do_readdir() =3D [entry4(cookie=3D512, name=3Db'bar',=
 attrs=3D{})]
> >>>INFO   :test.env:Called do_readdir()
> >>>INFO   :test.env:do_readdir() =3D [entry4(cookie=3D14, name=3Db'file',=
 attrs=3D{}), entry4(cookie=3D512, name=3Db'link', attrs=3D{})]
> >>>INFO   :test.env:Called do_readdir()
> >>>INFO   :test.env:do_readdir() =3D [entry4(cookie=3D14, name=3Db'file',=
 attrs=3D{}), entry4(cookie=3D512, name=3Db'dir', attrs=3D{})]
> >>>INFO   :test.env:Called do_readdir()
> >>>INFO   :test.env:do_readdir() =3D [entry4(cookie=3D512, name=3Db'foo',=
 attrs=3D{})]
> >>>INFO   :test.env:Called do_readdir()
> >>>INFO   :test.env:do_readdir() =3D [entry4(cookie=3D512, name=3Db'file2=
', attrs=3D{})]
> >>>INFO   :test.env:Called do_readdir()
> >>>INFO   :test.env:do_readdir() =3D [entry4(cookie=3D14, name=3Db'dir', =
attrs=3D{}), entry4(cookie=3D512, name=3Db'file', attrs=3D{})]
> >>>INFO   :test.env:Called do_readdir()
> >>>INFO   :test.env:do_readdir() =3D [entry4(cookie=3D512, name=3Db'RNM10=
_1642007029', attrs=3D{})]
> >>>INFO   :test.env:Called do_readdir()
> >>>INFO   :test.env:do_readdir() =3D [entry4(cookie=3D512, name=3Db'RNM11=
_1642007029', attrs=3D{})]
> >>>INFO   :test.env:Called do_readdir()
> >>>INFO   :test.env:do_readdir() =3D [entry4(cookie=3D14, name=3Db'dir', =
attrs=3D{}), entry4(cookie=3D512, name=3Db'file', attrs=3D{})]
> >>>INFO   :test.env:Called do_readdir()
> >>>INFO   :test.env:do_readdir() =3D [entry4(cookie=3D14, name=3Db'dir1',=
 attrs=3D{}), entry4(cookie=3D512, name=3Db'dir2', attrs=3D{})]
> >>>INFO   :test.env:Called do_readdir()
> >>>INFO   :test.env:do_readdir() =3D [entry4(cookie=3D512, name=3Db'foo',=
 attrs=3D{})]
> >>>INFO   :test.env:Called do_readdir()
> >>>INFO   :test.env:do_readdir() =3D [entry4(cookie=3D512, name=3Db'dir2'=
, attrs=3D{})]
> >>>INFO   :test.env:Called do_readdir()
> >>>INFO   :test.env:do_readdir() =3D [entry4(cookie=3D512, name=3Db'foo',=
 attrs=3D{})]
> >>>EID6h    st_exchange_id.testUpdate111                             : PA=
SS
> >>>EID6g    st_exchange_id.testUpdate110                             : RU=
NNING
> >>>EID6g    st_exchange_id.testUpdate110                             : PA=
SS
> >>>EID6f    st_exchange_id.testUpdate101                             : RU=
NNING
> >>>EID6f    st_exchange_id.testUpdate101                             : PA=
SS
> >>>EID6e    st_exchange_id.testUpdate100                             : RU=
NNING
> >>>EID6e    st_exchange_id.testUpdate100                             : PA=
SS
> >>>EID6d    st_exchange_id.testUpdate011                             : RU=
NNING
> >>>EID6d    st_exchange_id.testUpdate011                             : PA=
SS
> >>>EID6c    st_exchange_id.testUpdate010                             : RU=
NNING
> >>>EID6c    st_exchange_id.testUpdate010                             : PA=
SS
> >>>EID6b    st_exchange_id.testUpdate001                             : RU=
NNING
> >>>EID6b    st_exchange_id.testUpdate001                             : PA=
SS
> >>>EID6a    st_exchange_id.testUpdate000                             : RU=
NNING
> >>>EID6a    st_exchange_id.testUpdate000                             : PA=
SS
> >>>EID1b    st_exchange_id.testSupported2                            : RU=
NNING
> >>>EID1b    st_exchange_id.testSupported2                            : PA=
SS
> >>>EID7     st_exchange_id.testSupported1a                           : RU=
NNING
> >>>EID7     st_exchange_id.testSupported1a                           : PA=
SS
> >>>EID1     st_exchange_id.testSupported                             : RU=
NNING
> >>>EID1     st_exchange_id.testSupported                             : PA=
SS
> >>>EID8     st_exchange_id.testNotOnlyOp                             : RU=
NNING
> >>>EID8     st_exchange_id.testNotOnlyOp                             : PA=
SS
> >>>EID5h    st_exchange_id.testNoUpdate111                           : RU=
NNING
> >>>EID5h    st_exchange_id.testNoUpdate111                           : PA=
SS
> >>>EID5g    st_exchange_id.testNoUpdate110                           : RU=
NNING
> >>>EID5g    st_exchange_id.testNoUpdate110                           : PA=
SS
> >>>EID5fb   st_exchange_id.testNoUpdate101b                          : RU=
NNING
> >>>EID5fb   st_exchange_id.testNoUpdate101b                          : PA=
SS
> >>>EID5f    st_exchange_id.testNoUpdate101                           : RU=
NNING
> >>>EID5f    st_exchange_id.testNoUpdate101                           : PA=
SS
> >>>EID5e    st_exchange_id.testNoUpdate100                           : RU=
NNING
> >>>EID5e    st_exchange_id.testNoUpdate100                           : PA=
SS
> >>>EID5d    st_exchange_id.testNoUpdate011                           : RU=
NNING
> >>>EID5d    st_exchange_id.testNoUpdate011                           : PA=
SS
> >>>EID5c    st_exchange_id.testNoUpdate010                           : RU=
NNING
> >>>EID5c    st_exchange_id.testNoUpdate010                           : PA=
SS
> >>>EID5b    st_exchange_id.testNoUpdate001                           : RU=
NNING
> >>>EID5b    st_exchange_id.testNoUpdate001                           : PA=
SS
> >>>EID5a    st_exchange_id.testNoUpdate000                           : RU=
NNING
> >>>EID5a    st_exchange_id.testNoUpdate000                           : PA=
SS
> >>>EID2     st_exchange_id.testNoImplId                              : RU=
NNING
> >>>EID2     st_exchange_id.testNoImplId                              : PA=
SS
> >>>EID3     st_exchange_id.testLongArray                             : RU=
NNING
> >>>COMPOUND4res(status=3DNFS4ERR_BADXDR, tag=3Db'st_exchange_id.py:testNo=
ImplId', resarray=3D[nfs_resop4(resop=3DOP_EXCHANGE_ID, opexchange_id=3DEXC=
HANGE_ID4res(eir_status=3DNFS4ERR_BADXDR))])
> >>>EID3     st_exchange_id.testLongArray                             : PA=
SS
> >>>EID9     st_exchange_id.testLeasePeriod                           : RU=
NNING
> >>>EID9     st_exchange_id.testLeasePeriod                           : PA=
SS
> >>>EID4     st_exchange_id.testBadFlags                              : RU=
NNING
> >>>EID4     st_exchange_id.testBadFlags                              : PA=
SS
> >>>**************************************************
> >>>**************************************************
> >>>Command line asked for 172 of 260 tests
> >>>Of those: 0 Skipped, 0 Failed, 0 Warned, 172 Passed
> >>>FSTYP         -- nfs
> >>>PLATFORM      -- Linux/x86_64 test3 5.16.0-00002-g616758bf6583 #1278 S=
MP PREEMPT Wed Jan 12 11:37:28 EST 2022
> >>>MKFS_OPTIONS  -- test1.fieldses.org:/exports/xfs2
> >>>MOUNT_OPTIONS -- -overs=3D4.2,sec=3Dsys -o context=3Dsystem_u:object_r=
:root_t:s0 test1.fieldses.org:/exports/xfs2 /mnt2
> >>>
> >>>generic/001 41s ...  41s
> >>>generic/002 1s ...  1s
> >>>generic/003	[not run] atime related mount options have no effect on nfs
> >>>generic/004	[not run] O_TMPFILE is not supported
> >>>generic/005 2s ...  2s
> >>>generic/006       [expunged]
> >>>generic/007       [expunged]
> >>>generic/008	[not run] xfs_io fzero  failed (old kernel/wrong fs?)
> >>>generic/009	[not run] xfs_io fzero  failed (old kernel/wrong fs?)
> >>>generic/010	[not run] /root/xfstests-dev/src/dbtest not built
> >>>generic/011 68s ...  65s
> >>>generic/012	[not run] xfs_io fiemap  failed (old kernel/wrong fs?)
> >>>generic/013 68s ...  66s
> >>>generic/014       [expunged]
> >>>generic/015	[not run] Filesystem nfs not supported in _scratch_mkfs_si=
zed
> >>>generic/016	[not run] xfs_io fiemap  failed (old kernel/wrong fs?)
> >>>generic/017       [expunged]
> >>>generic/018	[not run] defragmentation not supported for fstype "nfs"
> >>>generic/020 13s ...  13s
> >>>generic/021	[not run] xfs_io fiemap  failed (old kernel/wrong fs?)
> >>>generic/022	[not run] xfs_io fiemap  failed (old kernel/wrong fs?)
> >>>generic/023 4s ...  3s
> >>>generic/024	[not run] kernel doesn't support renameat2 syscall
> >>>generic/025	[not run] kernel doesn't support renameat2 syscall
> >>>generic/026	[not run] ACLs not supported by this filesystem type: nfs
> >>>generic/027	[not run] Filesystem nfs not supported in _scratch_mkfs_si=
zed
> >>>generic/028 5s ...  5s
> >>>generic/029 1s ...  2s
> >>>generic/030 3s ...  3s
> >>>generic/031       [expunged]
> >>>generic/032       [expunged]
> >>>generic/033       [expunged]
> >>>generic/034	[not run] require test1.fieldses.org:/exports/xfs2 to be v=
alid block disk
> >>>generic/035       [expunged]
> >>>generic/036 11s ...  11s
> >>>generic/037 21s ...  21s
> >>>generic/038	[not run] FITRIM not supported on /mnt2
> >>>generic/039	[not run] require test1.fieldses.org:/exports/xfs2 to be v=
alid block disk
> >>>generic/040	[not run] require test1.fieldses.org:/exports/xfs2 to be v=
alid block disk
> >>>generic/041	[not run] require test1.fieldses.org:/exports/xfs2 to be v=
alid block disk
> >>>generic/043	[not run] nfs does not support shutdown
> >>>generic/044	[not run] nfs does not support shutdown
> >>>generic/045	[not run] nfs does not support shutdown
> >>>generic/046	[not run] nfs does not support shutdown
> >>>generic/047	[not run] nfs does not support shutdown
> >>>generic/048	[not run] nfs does not support shutdown
> >>>generic/049	[not run] nfs does not support shutdown
> >>>generic/050	[not run] nfs does not support shutdown
> >>>generic/051	[not run] nfs does not support shutdown
> >>>generic/052	[not run] nfs does not support shutdown
> >>>generic/053       [expunged]
> >>>generic/054	[not run] nfs does not support shutdown
> >>>generic/055	[not run] nfs does not support shutdown
> >>>generic/056	[not run] require test1.fieldses.org:/exports/xfs2 to be v=
alid block disk
> >>>generic/057	[not run] require test1.fieldses.org:/exports/xfs2 to be v=
alid block disk
> >>>generic/058	[not run] xfs_io fiemap  failed (old kernel/wrong fs?)
> >>>generic/059	[not run] require test1.fieldses.org:/exports/xfs2 to be v=
alid block disk
> >>>generic/060	[not run] xfs_io fiemap  failed (old kernel/wrong fs?)
> >>>generic/061	[not run] xfs_io fiemap  failed (old kernel/wrong fs?)
> >>>generic/062       [expunged]
> >>>generic/063	[not run] xfs_io fiemap  failed (old kernel/wrong fs?)
> >>>generic/064       [expunged]
> >>>generic/065	[not run] require test1.fieldses.org:/exports/xfs2 to be v=
alid block disk
> >>>generic/066	[not run] require test1.fieldses.org:/exports/xfs2 to be v=
alid block disk
> >>>generic/067	[not run] require test1.fieldses.org:/exports/xfs2 to be v=
alid block disk
> >>>generic/068       [expunged]
> >>>generic/069 29s ...  30s
> >>>generic/070 60s ...  47s
> >>>generic/071       [expunged]
> >>>generic/072 24s ... [not run] xfs_io fcollapse  failed (old kernel/wro=
ng fs?)
> >>>generic/073	[not run] require test1.fieldses.org:/exports/xfs2 to be v=
alid block disk
> >>>generic/074       [expunged]
> >>>generic/075 61s ...  56s
> >>>generic/076	[not run] require test1.fieldses.org:/exports/xfs2 to be l=
ocal device
> >>>generic/077	[not run] ACLs not supported by this filesystem type: nfs
> >>>generic/078	[not run] kernel doesn't support renameat2 syscall
> >>>generic/079	[not run] file system doesn't support chattr +ia
> >>>generic/080 3s ...  3s
> >>>generic/081	[not run] require test1.fieldses.org:/exports/xfs2 to be v=
alid block disk
> >>>generic/082	[not run] disk quotas not supported by this filesystem typ=
e: nfs
> >>>generic/083	[not run] Filesystem nfs not supported in _scratch_mkfs_si=
zed
> >>>generic/084 5s ...  6s
> >>>generic/085	[not run] require test1.fieldses.org:/exports/xfs2 to be v=
alid block disk
> >>>generic/086 2s ...  2s
> >>>generic/087       [expunged]
> >>>generic/088       [expunged]
> >>>generic/089       [expunged]
> >>>generic/090	[not run] require test1.fieldses.org:/exports/xfs2 to be v=
alid block disk
> >>>generic/091       [expunged]
> >>>generic/092	[not run] xfs_io fiemap  failed (old kernel/wrong fs?)
> >>>generic/093	[not run] attr namespace security not supported by this fi=
lesystem type: nfs
> >>>generic/094       [expunged]
> >>>generic/095	[not run] fio utility required, skipped this test
> >>>generic/096	[not run] xfs_io fzero  failed (old kernel/wrong fs?)
> >>>generic/097	[not run] attr namespace trusted not supported by this fil=
esystem type: nfs
> >>>generic/098 2s ...  2s
> >>>generic/099	[not run] ACLs not supported by this filesystem type: nfs
> >>>generic/100       [expunged]
> >>>generic/101	[not run] require test1.fieldses.org:/exports/xfs2 to be v=
alid block disk
> >>>generic/102	[not run] Filesystem nfs not supported in _scratch_mkfs_si=
zed
> >>>generic/103 3s ...  3s
> >>>generic/104	[not run] require test1.fieldses.org:/exports/xfs2 to be v=
alid block disk
> >>>generic/105       [expunged]
> >>>generic/106	[not run] require test1.fieldses.org:/exports/xfs2 to be v=
alid block disk
> >>>generic/107	[not run] require test1.fieldses.org:/exports/xfs2 to be v=
alid block disk
> >>>generic/108	[not run] require test1.fieldses.org:/exports/xfs2 to be v=
alid block disk
> >>>generic/109 57s ...  56s
> >>>generic/110	[not run] xfs_io fiemap  failed (old kernel/wrong fs?)
> >>>generic/111	[not run] xfs_io fiemap  failed (old kernel/wrong fs?)
> >>>generic/112 61s ...  59s
> >>>generic/113       [expunged]
> >>>generic/114	[not run] device block size: 4096 greater than 512
> >>>generic/115	[not run] xfs_io fiemap  failed (old kernel/wrong fs?)
> >>>generic/116 1s ...  2s
> >>>generic/117       [expunged]
> >>>generic/118 2s ...  1s
> >>>generic/119 3s ...  3s
> >>>generic/120	[not run] atime related mount options have no effect on nfs
> >>>generic/121	[not run] Dedupe not supported by test filesystem type: nfs
> >>>generic/122	[not run] Dedupe not supported by test filesystem type: nfs
> >>>generic/123	[not run] fsgqa user not defined.
> >>>generic/124 60s ...  54s
> >>>generic/126       [expunged]
> >>>generic/127       [expunged]
> >>>generic/128	[not run] fsgqa user not defined.
> >>>generic/129       [expunged]
> >>>generic/130 19s ...  18s
> >>>generic/131 2s ...  2s
> >>>generic/132 20s ...  19s
> >>>generic/133       [expunged]
> >>>generic/134 2s ...  2s
> >>>generic/135 2s ...  1s
> >>>generic/136	[not run] Dedupe not supported by test filesystem type: nfs
> >>>generic/137	[not run] Dedupe not supported by test filesystem type: nfs
> >>>generic/138 3s ...  2s
> >>>generic/139 3s ...  3s
> >>>generic/140 2s ...  3s
> >>>generic/141 1s ...  1s
> >>>generic/142 10s ...  8s
> >>>generic/143 246s ...  242s
> >>>generic/144 2s ...  2s
> >>>generic/145	[not run] xfs_io fcollapse  failed (old kernel/wrong fs?)
> >>>generic/146 3s ...  2s
> >>>generic/147	[not run] xfs_io finsert  failed (old kernel/wrong fs?)
> >>>generic/148 2s ...  2s
> >>>generic/149	[not run] xfs_io fzero  failed (old kernel/wrong fs?)
> >>>generic/150 19s ...  17s
> >>>generic/151 21s ...  20s
> >>>generic/152 22s ...  20s
> >>>generic/153	[not run] xfs_io fcollapse  failed (old kernel/wrong fs?)
> >>>generic/154       [expunged]
> >>>generic/155	[not run] xfs_io fzero  failed (old kernel/wrong fs?)
> >>>generic/156	[not run] xfs_io funshare  failed (old kernel/wrong fs?)
> >>>generic/157 88s ...  86s
> >>>generic/158	[not run] Dedupe not supported by test filesystem type: nfs
> >>>generic/159	[not run] file system doesn't support chattr +i
> >>>generic/160	[not run] file system doesn't support chattr +i
> >>>generic/161 18s ...  20s
> >>>generic/162	[not run] Dedupe not supported by scratch filesystem type:=
 nfs
> >>>generic/163	[not run] Dedupe not supported by scratch filesystem type:=
 nfs
> >>>generic/164 71s ...  70s
> >>>generic/165 65s ...  60s
> >>>generic/166 207s ...  182s
> >>>generic/167 46s ...  42s
> >>>generic/168 319s ...  280s
> >>>generic/169 2s ...  2s
> >>>generic/170 382s ...  361s
> >>>generic/171	[not run] Filesystem nfs not supported in _scratch_mkfs_si=
zed
> >>>generic/172	[not run] Filesystem nfs not supported in _scratch_mkfs_si=
zed
> >>>generic/173	[not run] Filesystem nfs not supported in _scratch_mkfs_si=
zed
> >>>generic/174	[not run] Filesystem nfs not supported in _scratch_mkfs_si=
zed
> >>>generic/175 370s ...  235s
> >>>generic/176	[not run] Insufficient space for stress test; would only c=
reate 32768 extents.
> >>>generic/177	[not run] xfs_io fiemap  failed (old kernel/wrong fs?)
> >>>generic/178 5s ...  5s
> >>>generic/179 1s ...  1s
> >>>generic/180	[not run] xfs_io fzero  failed (old kernel/wrong fs?)
> >>>generic/181 4s ...  4s
> >>>generic/182	[not run] Dedupe not supported by test filesystem type: nfs
> >>>generic/183 6s ...  6s
> >>>generic/184       [expunged]
> >>>generic/185 6s ...  6s
> >>>generic/186 832s ...  813s
> >>>generic/187 829s ...  815s
> >>>generic/188 8s ...  6s
> >>>generic/189 4s ...  4s
> >>>generic/190 5s ...  5s
> >>>generic/191 5s ...  4s
> >>>generic/192	[not run] atime related mount options have no effect on nfs
> >>>generic/193	[not run] fsgqa user not defined.
> >>>generic/194 6s ...  6s
> >>>generic/195 6s ...  6s
> >>>generic/196 4s ...  4s
> >>>generic/197 4s ...  5s
> >>>generic/198 6s ...  6s
> >>>generic/199 6s ...  6s
> >>>generic/200 6s ...  5s
> >>>generic/201 5s ...  3s
> >>>generic/202 2s ...  2s
> >>>generic/203 2s ...  3s
> >>>generic/204	[not run] Filesystem nfs not supported in _scratch_mkfs_si=
zed
> >>>generic/205	[not run] Filesystem nfs not supported in _scratch_mkfs_bl=
ocksized
> >>>generic/206	[not run] Filesystem nfs not supported in _scratch_mkfs_bl=
ocksized
> >>>generic/207 22s ...  20s
> >>>generic/208       [expunged]
> >>>generic/209 33s ...  45s
> >>>generic/210 0s ...  0s
> >>>generic/211 2s ...  1s
> >>>generic/212 0s ...  0s
> >>>generic/213 1s ...  0s
> >>>generic/214 1s ...  1s
> >>>generic/215 3s ...  3s
> >>>generic/216	[not run] Filesystem nfs not supported in _scratch_mkfs_bl=
ocksized
> >>>generic/217	[not run] Filesystem nfs not supported in _scratch_mkfs_bl=
ocksized
> >>>generic/218	[not run] Filesystem nfs not supported in _scratch_mkfs_bl=
ocksized
> >>>generic/219	[not run] disk quotas not supported by this filesystem typ=
e: nfs
> >>>generic/220	[not run] Filesystem nfs not supported in _scratch_mkfs_bl=
ocksized
> >>>generic/221 1s ...  2s
> >>>generic/222	[not run] Filesystem nfs not supported in _scratch_mkfs_bl=
ocksized
> >>>generic/223	[not run] can't mkfs nfs with geometry
> >>>generic/224	[not run] Filesystem nfs not supported in _scratch_mkfs_si=
zed
> >>>generic/225       [expunged]
> >>>generic/226	[not run] Filesystem nfs not supported in _scratch_mkfs_si=
zed
> >>>generic/227	[not run] Filesystem nfs not supported in _scratch_mkfs_bl=
ocksized
> >>>generic/228 1s ...  1s
> >>>generic/229	[not run] Filesystem nfs not supported in _scratch_mkfs_bl=
ocksized
> >>>generic/230	[not run] disk quotas not supported by this filesystem typ=
e: nfs
> >>>generic/231	[not run] disk quotas not supported by this filesystem typ=
e: nfs
> >>>generic/232	[not run] disk quotas not supported by this filesystem typ=
e: nfs
> >>>generic/233	[not run] disk quotas not supported by this filesystem typ=
e: nfs
> >>>generic/234	[not run] disk quotas not supported by this filesystem typ=
e: nfs
> >>>generic/235	[not run] disk quotas not supported by this filesystem typ=
e: nfs
> >>>generic/236 2s ...  2s
> >>>generic/237	[not run] ACLs not supported by this filesystem type: nfs
> >>>generic/238	[not run] Filesystem nfs not supported in _scratch_mkfs_bl=
ocksized
> >>>generic/239 32s ...  31s
> >>>generic/240 1s ...  1s
> >>>generic/241	[not run] dbench not found
> >>>generic/242 89s ...  85s
> >>>generic/243 89s ...  81s
> >>>generic/244	[not run] disk quotas not supported by this filesystem typ=
e: nfs
> >>>generic/245 1s ...  1s
> >>>generic/246 0s ...  0s
> >>>generic/247 85s ...  81s
> >>>generic/248 1s ...  0s
> >>>generic/249 3s ...  3s
> >>>generic/250	[not run] require test1.fieldses.org:/exports/xfs2 to be v=
alid block disk
> >>>generic/252	[not run] require test1.fieldses.org:/exports/xfs2 to be v=
alid block disk
> >>>generic/253 3s ...  2s
> >>>generic/254 2s ...  3s
> >>>generic/255	[not run] xfs_io fiemap  failed (old kernel/wrong fs?)
> >>>generic/256	[not run] fsgqa user not defined.
> >>>generic/257 4s ...  5s
> >>>generic/258 1s ...  0s
> >>>generic/259	[not run] xfs_io fzero  failed (old kernel/wrong fs?)
> >>>generic/260	[not run] FITRIM not supported on /mnt2
> >>>generic/261	[not run] xfs_io fcollapse  failed (old kernel/wrong fs?)
> >>>generic/262	[not run] xfs_io finsert  failed (old kernel/wrong fs?)
> >>>generic/263       [expunged]
> >>>generic/264	[not run] xfs_io funshare  failed (old kernel/wrong fs?)
> >>>generic/265	[not run] require test1.fieldses.org:/exports/xfs2 to be v=
alid block disk
> >>>generic/266	[not run] require test1.fieldses.org:/exports/xfs2 to be v=
alid block disk
> >>>generic/267	[not run] require test1.fieldses.org:/exports/xfs2 to be v=
alid block disk
> >>>generic/268	[not run] require test1.fieldses.org:/exports/xfs2 to be v=
alid block disk
> >>>generic/269	[not run] Filesystem nfs not supported in _scratch_mkfs_si=
zed
> >>>generic/270	[not run] disk quotas not supported by this filesystem typ=
e: nfs
> >>>generic/271	[not run] require test1.fieldses.org:/exports/xfs2 to be v=
alid block disk
> >>>generic/272	[not run] require test1.fieldses.org:/exports/xfs2 to be v=
alid block disk
> >>>generic/273	[not run] Filesystem nfs not supported in _scratch_mkfs_si=
zed
> >>>generic/274	[not run] xfs_io falloc -k failed (old kernel/wrong fs?)
> >>>generic/275	[not run] Filesystem nfs not supported in _scratch_mkfs_si=
zed
> >>>generic/276	[not run] require test1.fieldses.org:/exports/xfs2 to be v=
alid block disk
> >>>generic/277       [expunged]
> >>>generic/278	[not run] require test1.fieldses.org:/exports/xfs2 to be v=
alid block disk
> >>>generic/279	[not run] require test1.fieldses.org:/exports/xfs2 to be v=
alid block disk
> >>>generic/280	[not run] disk quotas not supported by this filesystem typ=
e: nfs
> >>>generic/281	[not run] require test1.fieldses.org:/exports/xfs2 to be v=
alid block disk
> >>>generic/282	[not run] require test1.fieldses.org:/exports/xfs2 to be v=
alid block disk
> >>>generic/283	[not run] require test1.fieldses.org:/exports/xfs2 to be v=
alid block disk
> >>>generic/284 4s ...  3s
> >>>generic/285 2s ...  2s
> >>>generic/286 19s ...  19s
> >>>generic/287 4s ...  4s
> >>>generic/288	[not run] FITRIM not supported on /mnt2
> >>>generic/289 5s ...  5s
> >>>generic/290 5s ...  5s
> >>>generic/291 6s ...  6s
> >>>generic/292 6s ...  5s
> >>>generic/293 7s ...  7s
> >>>generic/294       [expunged]
> >>>generic/295 8s ...  7s
> >>>generic/296 4s ...  3s
> >>>generic/297	[not run] NFS can't interrupt clone operations
> >>>generic/298	[not run] NFS can't interrupt clone operations
> >>>generic/299	[not run] require test1.fieldses.org:/exports/xfs2 to be v=
alid block disk
> >>>generic/300	[not run] require test1.fieldses.org:/exports/xfs2 to be v=
alid block disk
> >>>generic/301	[not run] xfs_io fiemap  failed (old kernel/wrong fs?)
> >>>generic/302	[not run] xfs_io fiemap  failed (old kernel/wrong fs?)
> >>>generic/303 1s ...  1s
> >>>generic/304	[not run] Dedupe not supported by test filesystem type: nfs
> >>>generic/305	[not run] xfs_io fiemap  failed (old kernel/wrong fs?)
> >>>generic/306 1s ...  1s
> >>>generic/307 3s ... [not run] ACLs not supported by this filesystem typ=
e: nfs
> >>>generic/308 1s ...  0s
> >>>generic/309 1s ...  2s
> >>>generic/310       [expunged]
> >>>generic/311	[not run] require test1.fieldses.org:/exports/xfs2 to be v=
alid block disk
> >>>generic/312	[not run] Filesystem nfs not supported in _scratch_mkfs_si=
zed
> >>>generic/313 4s ...  5s
> >>>generic/314	[not run] fsgqa user not defined.
> >>>generic/315 15s ... [not run] xfs_io falloc -k failed (old kernel/wron=
g fs?)
> >>>generic/316	[not run] xfs_io fiemap  failed (old kernel/wrong fs?)
> >>>generic/317	[not run] fsgqa user not defined.
> >>>generic/318       [expunged]
> >>>generic/319	[not run] ACLs not supported by this filesystem type: nfs
> >>>generic/320	[not run] Filesystem nfs not supported in _scratch_mkfs_si=
zed
> >>>generic/321	[not run] require test1.fieldses.org:/exports/xfs2 to be v=
alid block disk
> >>>generic/322	[not run] require test1.fieldses.org:/exports/xfs2 to be v=
alid block disk
> >>>generic/323       [expunged]
> >>>generic/324	[not run] defragmentation not supported for fstype "nfs"
> >>>generic/325	[not run] require test1.fieldses.org:/exports/xfs2 to be v=
alid block disk
> >>>generic/326	[not run] xfs_io fiemap  failed (old kernel/wrong fs?)
> >>>generic/327	[not run] xfs_io fiemap  failed (old kernel/wrong fs?)
> >>>generic/328	[not run] xfs_io fiemap  failed (old kernel/wrong fs?)
> >>>generic/329	[not run] require test1.fieldses.org:/exports/xfs2 to be v=
alid block disk
> >>>generic/330 10s ...  9s
> >>>generic/331	[not run] require test1.fieldses.org:/exports/xfs2 to be v=
alid block disk
> >>>generic/332 9s ...  8s
> >>>generic/333	[not run] Filesystem nfs not supported in _scratch_mkfs_si=
zed
> >>>generic/334	[not run] Filesystem nfs not supported in _scratch_mkfs_si=
zed
> >>>generic/335	[not run] require test1.fieldses.org:/exports/xfs2 to be v=
alid block disk
> >>>generic/336	[not run] require test1.fieldses.org:/exports/xfs2 to be v=
alid block disk
> >>>generic/337 1s ...  1s
> >>>generic/338	[not run] require test1.fieldses.org:/exports/xfs2 to be v=
alid block disk
> >>>generic/339       [expunged]
> >>>generic/340 41s ...  42s
> >>>generic/341	[not run] require test1.fieldses.org:/exports/xfs2 to be v=
alid block disk
> >>>generic/342	[not run] require test1.fieldses.org:/exports/xfs2 to be v=
alid block disk
> >>>generic/343	[not run] require test1.fieldses.org:/exports/xfs2 to be v=
alid block disk
> >>>generic/344 86s ...  84s
> >>>generic/345 89s ...  84s
> >>>generic/346 41s ...  38s
> >>>generic/347	[not run] require test1.fieldses.org:/exports/xfs2 to be v=
alid block disk
> >>>generic/348	[not run] require test1.fieldses.org:/exports/xfs2 to be v=
alid block disk
> >>>generic/352	[not run] xfs_io fiemap  failed (old kernel/wrong fs?)
> >>>generic/353	[not run] xfs_io fiemap  failed (old kernel/wrong fs?)
> >>>generic/354 30s ...  29s
> >>>generic/355	[not run] fsgqa user not defined.
> >>>generic/356 3s ...  2s
> >>>generic/357       [expunged]
> >>>generic/358 58s ...  55s
> >>>generic/359 15s ...  15s
> >>>generic/360 0s ...  1s
> >>>generic/361	[not run] require test1.fieldses.org:/exports/xfs2 to be v=
alid block disk
> >>>generic/362	[not run] this test requires richacl support on $SCRATCH_D=
EV
> >>>generic/363	[not run] this test requires richacl support on $SCRATCH_D=
EV
> >>>generic/364	[not run] this test requires richacl support on $SCRATCH_D=
EV
> >>>generic/365	[not run] this test requires richacl support on $SCRATCH_D=
EV
> >>>generic/366	[not run] this test requires richacl support on $SCRATCH_D=
EV
> >>>generic/367	[not run] this test requires richacl support on $SCRATCH_D=
EV
> >>>generic/368	[not run] this test requires richacl support on $SCRATCH_D=
EV
> >>>generic/369	[not run] this test requires richacl support on $SCRATCH_D=
EV
> >>>generic/370	[not run] this test requires richacl support on $SCRATCH_D=
EV
> >>>generic/371	[not run] Filesystem nfs not supported in _scratch_mkfs_si=
zed
> >>>generic/372	[not run] xfs_io fiemap  failed (old kernel/wrong fs?)
> >>>generic/373 1s ...  1s
> >>>generic/374	[not run] Dedupe not supported by scratch filesystem type:=
 nfs
> >>>generic/375	[not run] ACLs not supported by this filesystem type: nfs
> >>>generic/376	[not run] require test1.fieldses.org:/exports/xfs2 to be v=
alid block disk
> >>>generic/377 1s ...  1s
> >>>generic/378	[not run] fsgqa user not defined.
> >>>generic/379	[not run] disk quotas not supported by this filesystem typ=
e: nfs
> >>>generic/380	[not run] disk quotas not supported by this filesystem typ=
e: nfs
> >>>generic/381	[not run] disk quotas not supported by this filesystem typ=
e: nfs
> >>>generic/382	[not run] disk quotas not supported by this filesystem typ=
e: nfs
> >>>generic/383	[not run] disk quotas not supported by this filesystem typ=
e: nfs
> >>>generic/384	[not run] disk quotas not supported by this filesystem typ=
e: nfs
> >>>generic/385	[not run] disk quotas not supported by this filesystem typ=
e: nfs
> >>>generic/386	[not run] disk quotas not supported by this filesystem typ=
e: nfs
> >>>generic/387	[not run] Filesystem nfs not supported in _scratch_mkfs_si=
zed
> >>>generic/388	[not run] require test1.fieldses.org:/exports/xfs2 to be l=
ocal device
> >>>generic/389	[not run] O_TMPFILE is not supported
> >>>generic/390 9s ... [not run] nfs does not support freezing
> >>>generic/391 24s ...  22s
> >>>generic/392	[not run] nfs does not support shutdown
> >>>generic/393 2s ...  2s
> >>>generic/394 2s ...  1s
> >>>generic/395	[not run] No encryption support for nfs
> >>>generic/396	[not run] No encryption support for nfs
> >>>generic/397	[not run] No encryption support for nfs
> >>>generic/398	[not run] No encryption support for nfs
> >>>generic/399	[not run] No encryption support for nfs
> >>>generic/400	[not run] disk quotas not supported by this filesystem typ=
e: nfs
> >>>generic/401 1s ...  2s
> >>>generic/402	[not run] filesystem nfs timestamp bounds are unknown
> >>>generic/403       [expunged]
> >>>generic/404	[not run] xfs_io finsert  failed (old kernel/wrong fs?)
> >>>generic/405	[not run] require test1.fieldses.org:/exports/xfs2 to be v=
alid block disk
> >>>generic/406 9s ...  8s
> >>>generic/407 2s ...  1s
> >>>generic/408	[not run] Dedupe not supported by test filesystem type: nfs
> >>>generic/409	[not run] require test1.fieldses.org:/exports/xfs2 to be l=
ocal device
> >>>generic/410	[not run] require test1.fieldses.org:/exports/xfs2 to be l=
ocal device
> >>>generic/411	[not run] require test1.fieldses.org:/exports/xfs2 to be l=
ocal device
> >>>generic/412 2s ...  1s
> >>>generic/413	[not run] mount test1.fieldses.org:/exports/xfs2 with dax =
failed
> >>>generic/414	[not run] xfs_io fiemap  failed (old kernel/wrong fs?)
> >>>generic/415 15s ...  16s
> >>>generic/416	[not run] Filesystem nfs not supported in _scratch_mkfs_si=
zed
> >>>generic/417	[not run] nfs does not support shutdown
> >>>generic/418	[not run] require test1.fieldses.org:/exports/xfs to be va=
lid block disk
> >>>generic/419	[not run] No encryption support for nfs
> >>>generic/420 1s ...  0s
> >>>generic/421	[not run] No encryption support for nfs
> >>>generic/422       [expunged]
> >>>generic/423       [expunged]
> >>>generic/424	[not run] file system doesn't support any of /usr/bin/chat=
tr +a/+c/+d/+i
> >>>generic/425       [expunged]
> >>>generic/426       [expunged]
> >>>generic/427	[not run] Filesystem nfs not supported in _scratch_mkfs_si=
zed
> >>>generic/428 1s ...  0s
> >>>generic/429	[not run] No encryption support for nfs
> >>>generic/430 1s ...  1s
> >>>generic/431 1s ...  1s
> >>>generic/432 1s ...  1s
> >>>generic/433 1s ...  1s
> >>>generic/434       [expunged]
> >>>generic/435	[not run] No encryption support for nfs
> >>>generic/436 1s ...  2s
> >>>generic/437 21s ...  20s
> >>>generic/438       [expunged]
> >>>generic/439 2s ...  2s
> >>>generic/440	[not run] No encryption support for nfs
> >>>generic/441	[not run] require test1.fieldses.org:/exports/xfs2 to be v=
alid block disk
> >>>generic/443 0s ...  1s
> >>>generic/444	[not run] ACLs not supported by this filesystem type: nfs
> >>>generic/445 1s ...  2s
> >>>generic/446       [expunged]
> >>>generic/447	[not run] Insufficient space for stress test; would only c=
reate 32768 extents (10737418240/21281112064 blocks).
> >>>generic/448 1s ...  2s
> >>>generic/449	[not run] ACLs not supported by this filesystem type: nfs
> >>>generic/450 1s ...  1s
> >>>generic/451 31s ...  31s
> >>>generic/452 1s ...  1s
> >>>generic/453 2s ...  2s
> >>>generic/454 3s ...  2s
> >>>generic/455	[not run] This test requires a valid $LOGWRITES_DEV
> >>>generic/456	[not run] require test1.fieldses.org:/exports/xfs2 to be v=
alid block disk
> >>>generic/457	[not run] This test requires a valid $LOGWRITES_DEV
> >>>generic/458	[not run] xfs_io fzero  failed (old kernel/wrong fs?)
> >>>generic/459	[not run] require test1.fieldses.org:/exports/xfs2 to be v=
alid block disk
> >>>generic/460 36s ...  37s
> >>>generic/461	[not run] nfs does not support shutdown
> >>>generic/462	[not run] mount test1.fieldses.org:/exports/xfs2 with dax =
failed
> >>>generic/463 1s ...  1s
> >>>generic/464 73s ...  73s
> >>>generic/465       [expunged]
> >>>generic/466	[not run] require test1.fieldses.org:/exports/xfs2 to be v=
alid block disk
> >>>generic/467 4s ...  4s
> >>>generic/468	[not run] nfs does not support shutdown
> >>>generic/469       [expunged]
> >>>generic/470	[not run] This test requires a valid $LOGWRITES_DEV
> >>>generic/471	[not run] xfs_io pwrite  -V 1 -b 4k -N failed (old kernel/=
wrong fs?)
> >>>generic/472 2s ...  2s
> >>>generic/474	[not run] nfs does not support shutdown
> >>>generic/475	[not run] require test1.fieldses.org:/exports/xfs2 to be v=
alid block disk
> >>>generic/476       [expunged]
> >>>generic/477 4s ...  4s
> >>>generic/478       [expunged]
> >>>generic/479	[not run] require test1.fieldses.org:/exports/xfs2 to be v=
alid block disk
> >>>generic/480	[not run] require test1.fieldses.org:/exports/xfs2 to be v=
alid block disk
> >>>generic/481	[not run] require test1.fieldses.org:/exports/xfs2 to be v=
alid block disk
> >>>generic/482	[not run] This test requires a valid $LOGWRITES_DEV
> >>>generic/483	[not run] require test1.fieldses.org:/exports/xfs2 to be v=
alid block disk
> >>>generic/484       [expunged]
> >>>generic/485       [expunged]
> >>>generic/486       [expunged]
> >>>generic/487	[not run] This test requires a valid $SCRATCH_LOGDEV
> >>>generic/488	[not run] Filesystem nfs not supported in _scratch_mkfs_si=
zed
> >>>generic/489	[not run] require test1.fieldses.org:/exports/xfs2 to be v=
alid block disk
> >>>generic/490 1s ...  2s
> >>>generic/491       [expunged]
> >>>generic/492	[not run] xfs_io label  failed (old kernel/wrong fs?)
> >>>generic/493	[not run] Dedupe not supported by scratch filesystem type:=
 nfs
> >>>generic/494 3s ...  2s
> >>>generic/495 2s ...  2s
> >>>generic/496 7s ...  7s
> >>>generic/497 2s ... [not run] xfs_io fcollapse  failed (old kernel/wron=
g fs?)
> >>>generic/498	[not run] require test1.fieldses.org:/exports/xfs2 to be v=
alid block disk
> >>>generic/499       [expunged]
> >>>generic/500	[not run] require test1.fieldses.org:/exports/xfs2 to be v=
alid block disk
> >>>generic/501	[not run] require test1.fieldses.org:/exports/xfs2 to be v=
alid block disk
> >>>generic/502	[not run] require test1.fieldses.org:/exports/xfs2 to be v=
alid block disk
> >>>generic/503       [expunged]
> >>>generic/504 0s ...  0s
> >>>generic/505	[not run] nfs does not support shutdown
> >>>generic/506	[not run] nfs does not support shutdown
> >>>generic/507	[not run] file system doesn't support chattr +AsSu
> >>>generic/508	[not run] lsattr not supported by test filesystem type: nfs
> >>>generic/509	[not run] O_TMPFILE is not supported
> >>>generic/510	[not run] require test1.fieldses.org:/exports/xfs2 to be v=
alid block disk
> >>>generic/511	[not run] xfs_io falloc -k failed (old kernel/wrong fs?)
> >>>generic/512	[not run] require test1.fieldses.org:/exports/xfs2 to be v=
alid block disk
> >>>generic/513       [expunged]
> >>>generic/514	[not run] fsgqa user not defined.
> >>>generic/515	[not run] Filesystem nfs not supported in _scratch_mkfs_si=
zed
> >>>generic/516	[not run] Dedupe not supported by test filesystem type: nfs
> >>>generic/517	[not run] Dedupe not supported by scratch filesystem type:=
 nfs
> >>>generic/518 2s ...  2s
> >>>generic/519       [expunged]
> >>>generic/520	[not run] require test1.fieldses.org:/exports/xfs2 to be v=
alid block disk
> >>>generic/523 1s ...  1s
> >>>generic/524 25s ...  27s
> >>>generic/525 1s ...  2s
> >>>generic/526	[not run] require test1.fieldses.org:/exports/xfs2 to be v=
alid block disk
> >>>generic/527	[not run] require test1.fieldses.org:/exports/xfs2 to be v=
alid block disk
> >>>generic/528	[not run] inode creation time not supported by this filesy=
stem
> >>>generic/529	[not run] ACLs not supported by this filesystem type: nfs
> >>>generic/530	[not run] nfs does not support shutdown
> >>>generic/531       [expunged]
> >>>generic/532 1s ...  1s
> >>>generic/533 1s ...  1s
> >>>generic/534	[not run] require test1.fieldses.org:/exports/xfs2 to be v=
alid block disk
> >>>generic/535	[not run] require test1.fieldses.org:/exports/xfs2 to be v=
alid block disk
> >>>generic/536	[not run] nfs does not support shutdown
> >>>generic/537	[not run] FSTRIM not supported
> >>>generic/538 26s ...  26s
> >>>generic/539 1s ...  1s
> >>>generic/540 6s ...  6s
> >>>generic/541 7s ...  6s
> >>>generic/542 6s ...  6s
> >>>generic/543 7s ...  6s
> >>>generic/544 6s ...  7s
> >>>generic/545	[not run] file system doesn't support chattr +i
> >>>generic/546	[not run] require test1.fieldses.org:/exports/xfs2 to be v=
alid block disk
> >>>generic/547	[not run] require test1.fieldses.org:/exports/xfs2 to be v=
alid block disk
> >>>generic/548	[not run] No encryption support for nfs
> >>>generic/549	[not run] No encryption support for nfs
> >>>generic/550	[not run] No encryption support for nfs
> >>>generic/551       [expunged]
> >>>generic/552	[not run] require test1.fieldses.org:/exports/xfs2 to be v=
alid block disk
> >>>generic/553	[not run] xfs_io chattr +i failed (old kernel/wrong fs?)
> >>>generic/554 3s ...  2s
> >>>generic/555	[not run] xfs_io chattr +ia failed (old kernel/wrong fs?)
> >>>generic/556	[not run] nfs does not support casefold feature
> >>>generic/557	[not run] require test1.fieldses.org:/exports/xfs2 to be v=
alid block disk
> >>>generic/558	[not run] Filesystem nfs not supported in _scratch_mkfs_si=
zed
> >>>generic/559	[not run] duperemove utility required, skipped this test
> >>>generic/560	[not run] duperemove utility required, skipped this test
> >>>generic/561	[not run] duperemove utility required, skipped this test
> >>>generic/562	[not run] Filesystem nfs not supported in _scratch_mkfs_si=
zed
> >>>generic/563	[not run] Cgroup2 doesn't support io controller io
> >>>generic/564 2s ...  2s
> >>>generic/565       [expunged]
> >>>generic/566	[not run] disk quotas not supported by this filesystem typ=
e: nfs
> >>>generic/567 1s ...  2s
> >>>generic/568 1s ...  1s
> >>>generic/569 2s ...  3s
> >>>generic/570	[not run] require test1.fieldses.org:/exports/xfs2 to be v=
alid block disk
> >>>generic/571       [expunged]
> >>>generic/572	[not run] fsverity utility required, skipped this test
> >>>generic/573	[not run] fsverity utility required, skipped this test
> >>>generic/574	[not run] fsverity utility required, skipped this test
> >>>generic/575	[not run] fsverity utility required, skipped this test
> >>>generic/576	[not run] fsverity utility required, skipped this test
> >>>generic/577	[not run] fsverity utility required, skipped this test
> >>>generic/578       [expunged]
> >>>generic/579	[not run] fsverity utility required, skipped this test
> >>>generic/580	[not run] No encryption support for nfs
> >>>generic/581	[not run] fsgqa user not defined.
> >>>generic/582	[not run] No encryption support for nfs
> >>>generic/583	[not run] No encryption support for nfs
> >>>generic/584	[not run] No encryption support for nfs
> >>>generic/585 8s ... [not run] kernel doesn't support renameat2 syscall
> >>>generic/586 9s ...  9s
> >>>generic/587	[not run] fsgqa user not defined.
> >>>generic/588	[not run] require test1.fieldses.org:/exports/xfs2 to be v=
alid block disk
> >>>generic/589	[not run] require test1.fieldses.org:/exports/xfs2 to be l=
ocal device
> >>>generic/590 281s ...  276s
> >>>generic/591 1s ...  1s
> >>>generic/592	[not run] No encryption support for nfs
> >>>generic/593	[not run] No encryption support for nfs
> >>>generic/594	[not run] disk quotas not supported by this filesystem typ=
e: nfs
> >>>generic/595	[not run] No encryption support for nfs
> >>>generic/596	[not run] file system doesn't support chattr +S
> >>>generic/597	[not run] fsgqa2 user not defined.
> >>>generic/598	[not run] fsgqa2 user not defined.
> >>>generic/599	[not run] nfs does not support shutdown
> >>>generic/600	[not run] disk quotas not supported by this filesystem typ=
e: nfs
> >>>generic/601	[not run] disk quotas not supported by this filesystem typ=
e: nfs
> >>>generic/602	[not run] No encryption support for nfs
> >>>generic/603	[not run] disk quotas not supported by this filesystem typ=
e: nfs
> >>>generic/604 6s ...  5s
> >>>generic/605	[not run] mount test1.fieldses.org:/exports/xfs2 with dax=
=3Dalways failed
> >>>generic/606	[not run] mount test1.fieldses.org:/exports/xfs2 with dax=
=3Dalways failed
> >>>generic/607       [expunged]
> >>>generic/608	[not run] mount test1.fieldses.org:/exports/xfs2 with dax=
=3Dalways failed
> >>>generic/609 1s ...  0s
> >>>generic/610       [expunged]
> >>>generic/611 1s ...  2s
> >>>nfs/001 3s ...  2s
> >>>shared/002	[not run] not suitable for this filesystem type: nfs
> >>>shared/032	[not run] not suitable for this filesystem type: nfs
> >>>shared/298	[not run] not suitable for this filesystem type: nfs
> >>>Ran: generic/001 generic/002 generic/003 generic/004 generic/005 gener=
ic/008 generic/009 generic/010 generic/011 generic/012 generic/013 generic/=
015 generic/016 generic/018 generic/020 generic/021 generic/022 generic/023=
 generic/024 generic/025 generic/026 generic/027 generic/028 generic/029 ge=
neric/030 generic/034 generic/036 generic/037 generic/038 generic/039 gener=
ic/040 generic/041 generic/043 generic/044 generic/045 generic/046 generic/=
047 generic/048 generic/049 generic/050 generic/051 generic/052 generic/054=
 generic/055 generic/056 generic/057 generic/058 generic/059 generic/060 ge=
neric/061 generic/063 generic/065 generic/066 generic/067 generic/069 gener=
ic/070 generic/072 generic/073 generic/075 generic/076 generic/077 generic/=
078 generic/079 generic/080 generic/081 generic/082 generic/083 generic/084=
 generic/085 generic/086 generic/090 generic/092 generic/093 generic/095 ge=
neric/096 generic/097 generic/098 generic/099 generic/101 generic/102 gener=
ic/103 generic/104 generic/1
> >>>  06 generic/107 generic/108 generic/109 generic/110 generic/111 gener=
ic/112 generic/114 generic/115 generic/116 generic/118 generic/119 generic/=
120 generic/121 generic/122 generic/123 generic/124 generic/128 generic/130=
 generic/131 generic/132 generic/134 generic/135 generic/136 generic/137 ge=
neric/138 generic/139 generic/140 generic/141 generic/142 generic/143 gener=
ic/144 generic/145 generic/146 generic/147 generic/148 generic/149 generic/=
150 generic/151 generic/152 generic/153 generic/155 generic/156 generic/157=
 generic/158 generic/159 generic/160 generic/161 generic/162 generic/163 ge=
neric/164 generic/165 generic/166 generic/167 generic/168 generic/169 gener=
ic/170 generic/171 generic/172 generic/173 generic/174 generic/175 generic/=
176 generic/177 generic/178 generic/179 generic/180 generic/181 generic/182=
 generic/183 generic/185 generic/186 generic/187 generic/188 generic/189 ge=
neric/190 generic/191 generic/192 generic/193 generic/194 generic/195 gener=
ic/196 generic/197 generic/19
> >>>  8 generic/199 generic/200 generic/201 generic/202 generic/203 generi=
c/204 generic/205 generic/206 generic/207 generic/209 generic/210 generic/2=
11 generic/212 generic/213 generic/214 generic/215 generic/216 generic/217 =
generic/218 generic/219 generic/220 generic/221 generic/222 generic/223 gen=
eric/224 generic/226 generic/227 generic/228 generic/229 generic/230 generi=
c/231 generic/232 generic/233 generic/234 generic/235 generic/236 generic/2=
37 generic/238 generic/239 generic/240 generic/241 generic/242 generic/243 =
generic/244 generic/245 generic/246 generic/247 generic/248 generic/249 gen=
eric/250 generic/252 generic/253 generic/254 generic/255 generic/256 generi=
c/257 generic/258 generic/259 generic/260 generic/261 generic/262 generic/2=
64 generic/265 generic/266 generic/267 generic/268 generic/269 generic/270 =
generic/271 generic/272 generic/273 generic/274 generic/275 generic/276 gen=
eric/278 generic/279 generic/280 generic/281 generic/282 generic/283 generi=
c/284 generic/285 generic/286
> >>>   generic/287 generic/288 generic/289 generic/290 generic/291 generic=
/292 generic/293 generic/295 generic/296 generic/297 generic/298 generic/29=
9 generic/300 generic/301 generic/302 generic/303 generic/304 generic/305 g=
eneric/306 generic/307 generic/308 generic/309 generic/311 generic/312 gene=
ric/313 generic/314 generic/315 generic/316 generic/317 generic/319 generic=
/320 generic/321 generic/322 generic/324 generic/325 generic/326 generic/32=
7 generic/328 generic/329 generic/330 generic/331 generic/332 generic/333 g=
eneric/334 generic/335 generic/336 generic/337 generic/338 generic/340 gene=
ric/341 generic/342 generic/343 generic/344 generic/345 generic/346 generic=
/347 generic/348 generic/352 generic/353 generic/354 generic/355 generic/35=
6 generic/358 generic/359 generic/360 generic/361 generic/362 generic/363 g=
eneric/364 generic/365 generic/366 generic/367 generic/368 generic/369 gene=
ric/370 generic/371 generic/372 generic/373 generic/374 generic/375 generic=
/376 generic/377 generic/378
> >>>  generic/379 generic/380 generic/381 generic/382 generic/383 generic/=
384 generic/385 generic/386 generic/387 generic/388 generic/389 generic/390=
 generic/391 generic/392 generic/393 generic/394 generic/395 generic/396 ge=
neric/397 generic/398 generic/399 generic/400 generic/401 generic/402 gener=
ic/404 generic/405 generic/406 generic/407 generic/408 generic/409 generic/=
410 generic/411 generic/412 generic/413 generic/414 generic/415 generic/416=
 generic/417 generic/418 generic/419 generic/420 generic/421 generic/424 ge=
neric/427 generic/428 generic/429 generic/430 generic/431 generic/432 gener=
ic/433 generic/435 generic/436 generic/437 generic/439 generic/440 generic/=
441 generic/443 generic/444 generic/445 generic/447 generic/448 generic/449=
 generic/450 generic/451 generic/452 generic/453 generic/454 generic/455 ge=
neric/456 generic/457 generic/458 generic/459 generic/460 generic/461 gener=
ic/462 generic/463 generic/464 generic/466 generic/467 generic/468 generic/=
470 generic/471 generic/472 g
> >>>  eneric/474 generic/475 generic/477 generic/479 generic/480 generic/4=
81 generic/482 generic/483 generic/487 generic/488 generic/489 generic/490 =
generic/492 generic/493 generic/494 generic/495 generic/496 generic/497 gen=
eric/498 generic/500 generic/501 generic/502 generic/504 generic/505 generi=
c/506 generic/507 generic/508 generic/509 generic/510 generic/511 generic/5=
12 generic/514 generic/515 generic/516 generic/517 generic/518 generic/520 =
generic/523 generic/524 generic/525 generic/526 generic/527 generic/528 gen=
eric/529 generic/530 generic/532 generic/533 generic/534 generic/535 generi=
c/536 generic/537 generic/538 generic/539 generic/540 generic/541 generic/5=
42 generic/543 generic/544 generic/545 generic/546 generic/547 generic/548 =
generic/549 generic/550 generic/552 generic/553 generic/554 generic/555 gen=
eric/556 generic/557 generic/558 generic/559 generic/560 generic/561 generi=
c/562 generic/563 generic/564 generic/566 generic/567 generic/568 generic/5=
69 generic/570 generic/572 ge
> >>>  neric/573 generic/574 generic/575 generic/576 generic/577 generic/57=
9 generic/580 generic/581 generic/582 generic/583 generic/584 generic/585 g=
eneric/586 generic/587 generic/588 generic/589 generic/590 generic/591 gene=
ric/592 generic/593 generic/594 generic/595 generic/596 generic/597 generic=
/598 generic/599 generic/600 generic/601 generic/602 generic/603 generic/60=
4 generic/605 generic/606 generic/608 generic/609 generic/611 nfs/001 share=
d/002 shared/032 shared/298
> >>>Not run: generic/003 generic/004 generic/008 generic/009 generic/010 g=
eneric/012 generic/015 generic/016 generic/018 generic/021 generic/022 gene=
ric/024 generic/025 generic/026 generic/027 generic/034 generic/038 generic=
/039 generic/040 generic/041 generic/043 generic/044 generic/045 generic/04=
6 generic/047 generic/048 generic/049 generic/050 generic/051 generic/052 g=
eneric/054 generic/055 generic/056 generic/057 generic/058 generic/059 gene=
ric/060 generic/061 generic/063 generic/065 generic/066 generic/067 generic=
/072 generic/073 generic/076 generic/077 generic/078 generic/079 generic/08=
1 generic/082 generic/083 generic/085 generic/090 generic/092 generic/093 g=
eneric/095 generic/096 generic/097 generic/099 generic/101 generic/102 gene=
ric/104 generic/106 generic/107 generic/108 generic/110 generic/111 generic=
/114 generic/115 generic/120 generic/121 generic/122 generic/123 generic/12=
8 generic/136 generic/137 generic/145 generic/147 generic/149 generic/153 g=
eneric/155 generic/156 gener
> >>>  ic/158 generic/159 generic/160 generic/162 generic/163 generic/171 g=
eneric/172 generic/173 generic/174 generic/176 generic/177 generic/180 gene=
ric/182 generic/192 generic/193 generic/204 generic/205 generic/206 generic=
/216 generic/217 generic/218 generic/219 generic/220 generic/222 generic/22=
3 generic/224 generic/226 generic/227 generic/229 generic/230 generic/231 g=
eneric/232 generic/233 generic/234 generic/235 generic/237 generic/238 gene=
ric/241 generic/244 generic/250 generic/252 generic/255 generic/256 generic=
/259 generic/260 generic/261 generic/262 generic/264 generic/265 generic/26=
6 generic/267 generic/268 generic/269 generic/270 generic/271 generic/272 g=
eneric/273 generic/274 generic/275 generic/276 generic/278 generic/279 gene=
ric/280 generic/281 generic/282 generic/283 generic/288 generic/297 generic=
/298 generic/299 generic/300 generic/301 generic/302 generic/304 generic/30=
5 generic/307 generic/311 generic/312 generic/314 generic/315 generic/316 g=
eneric/317 generic/319 generi
> >>>  c/320 generic/321 generic/322 generic/324 generic/325 generic/326 ge=
neric/327 generic/328 generic/329 generic/331 generic/333 generic/334 gener=
ic/335 generic/336 generic/338 generic/341 generic/342 generic/343 generic/=
347 generic/348 generic/352 generic/353 generic/355 generic/361 generic/362=
 generic/363 generic/364 generic/365 generic/366 generic/367 generic/368 ge=
neric/369 generic/370 generic/371 generic/372 generic/374 generic/375 gener=
ic/376 generic/378 generic/379 generic/380 generic/381 generic/382 generic/=
383 generic/384 generic/385 generic/386 generic/387 generic/388 generic/389=
 generic/390 generic/392 generic/395 generic/396 generic/397 generic/398 ge=
neric/399 generic/400 generic/402 generic/404 generic/405 generic/408 gener=
ic/409 generic/410 generic/411 generic/413 generic/414 generic/416 generic/=
417 generic/418 generic/419 generic/421 generic/424 generic/427 generic/429=
 generic/435 generic/440 generic/441 generic/444 generic/447 generic/449 ge=
neric/455 generic/456 generic
> >>>  /457 generic/458 generic/459 generic/461 generic/462 generic/466 gen=
eric/468 generic/470 generic/471 generic/474 generic/475 generic/479 generi=
c/480 generic/481 generic/482 generic/483 generic/487 generic/488 generic/4=
89 generic/492 generic/493 generic/497 generic/498 generic/500 generic/501 =
generic/502 generic/505 generic/506 generic/507 generic/508 generic/509 gen=
eric/510 generic/511 generic/512 generic/514 generic/515 generic/516 generi=
c/517 generic/520 generic/526 generic/527 generic/528 generic/529 generic/5=
30 generic/534 generic/535 generic/536 generic/537 generic/545 generic/546 =
generic/547 generic/548 generic/549 generic/550 generic/552 generic/553 gen=
eric/555 generic/556 generic/557 generic/558 generic/559 generic/560 generi=
c/561 generic/562 generic/563 generic/566 generic/570 generic/572 generic/5=
73 generic/574 generic/575 generic/576 generic/577 generic/579 generic/580 =
generic/581 generic/582 generic/583 generic/584 generic/585 generic/587 gen=
eric/588 generic/589 generic/
> >>>  592 generic/593 generic/594 generic/595 generic/596 generic/597 gene=
ric/598 generic/599 generic/600 generic/601 generic/602 generic/603 generic=
/605 generic/606 generic/608 shared/002 shared/032 shared/298
> >>>Passed all 538 tests
> >>>
> >>>[    0.000000] Linux version 5.16.0-00002-g616758bf6583 (bfields@patat=
e.fieldses.org) (gcc (GCC) 11.2.1 20211203 (Red Hat 11.2.1-7), GNU ld versi=
on 2.37-10.fc35) #1278 SMP PREEMPT Wed Jan 12 11:37:28 EST 2022
> >>>[    0.000000] Command line: BOOT_IMAGE=3D(hd0,msdos1)/vmlinuz-5.16.0-=
00002-g616758bf6583 root=3D/dev/mapper/fedora-root ro resume=3D/dev/mapper/=
fedora-swap rd.lvm.lv=3Dfedora/root rd.lvm.lv=3Dfedora/swap console=3Dtty0 =
console=3DttyS0,38400n8 consoleblank=3D0
> >>>[    0.000000] x86/fpu: Supporting XSAVE feature 0x001: 'x87 floating =
point registers'
> >>>[    0.000000] x86/fpu: Supporting XSAVE feature 0x002: 'SSE registers'
> >>>[    0.000000] x86/fpu: Supporting XSAVE feature 0x004: 'AVX registers'
> >>>[    0.000000] x86/fpu: xstate_offset[2]:  576, xstate_sizes[2]:  256
> >>>[    0.000000] x86/fpu: Enabled xstate features 0x7, context size is 8=
32 bytes, using 'standard' format.
> >>>[    0.000000] signal: max sigframe size: 1776
> >>>[    0.000000] BIOS-provided physical RAM map:
> >>>[    0.000000] BIOS-e820: [mem 0x0000000000000000-0x000000000009fbff] =
usable
> >>>[    0.000000] BIOS-e820: [mem 0x000000000009fc00-0x000000000009ffff] =
reserved
> >>>[    0.000000] BIOS-e820: [mem 0x00000000000f0000-0x00000000000fffff] =
reserved
> >>>[    0.000000] BIOS-e820: [mem 0x0000000000100000-0x000000007ffdbfff] =
usable
> >>>[    0.000000] BIOS-e820: [mem 0x000000007ffdc000-0x000000007fffffff] =
reserved
> >>>[    0.000000] BIOS-e820: [mem 0x00000000b0000000-0x00000000bfffffff] =
reserved
> >>>[    0.000000] BIOS-e820: [mem 0x00000000fed1c000-0x00000000fed1ffff] =
reserved
> >>>[    0.000000] BIOS-e820: [mem 0x00000000feffc000-0x00000000feffffff] =
reserved
> >>>[    0.000000] BIOS-e820: [mem 0x00000000fffc0000-0x00000000ffffffff] =
reserved
> >>>[    0.000000] NX (Execute Disable) protection: active
> >>>[    0.000000] SMBIOS 2.8 present.
> >>>[    0.000000] DMI: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.14.0-6=
=2Efc35 04/01/2014
> >>>[    0.000000] tsc: Fast TSC calibration using PIT
> >>>[    0.000000] tsc: Detected 3591.787 MHz processor
> >>>[    0.000930] e820: update [mem 0x00000000-0x00000fff] usable =3D=3D>=
 reserved
> >>>[    0.000938] e820: remove [mem 0x000a0000-0x000fffff] usable
> >>>[    0.000946] last_pfn =3D 0x7ffdc max_arch_pfn =3D 0x400000000
> >>>[    0.000979] x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB  WP  U=
C- WT
> >>>[    0.004415] found SMP MP-table at [mem 0x000f5c10-0x000f5c1f]
> >>>[    0.004436] Using GB pages for direct mapping
> >>>[    0.004911] RAMDISK: [mem 0x34784000-0x363b9fff]
> >>>[    0.004919] ACPI: Early table checksum verification disabled
> >>>[    0.004924] ACPI: RSDP 0x00000000000F5A20 000014 (v00 BOCHS )
> >>>[    0.004934] ACPI: RSDT 0x000000007FFE2066 000034 (v01 BOCHS  BXPC  =
   00000001 BXPC 00000001)
> >>>[    0.004943] ACPI: FACP 0x000000007FFE1E8E 0000F4 (v03 BOCHS  BXPC  =
   00000001 BXPC 00000001)
> >>>[    0.004953] ACPI: DSDT 0x000000007FFE0040 001E4E (v01 BOCHS  BXPC  =
   00000001 BXPC 00000001)
> >>>[    0.004960] ACPI: FACS 0x000000007FFE0000 000040
> >>>[    0.004966] ACPI: APIC 0x000000007FFE1F82 000080 (v01 BOCHS  BXPC  =
   00000001 BXPC 00000001)
> >>>[    0.004972] ACPI: MCFG 0x000000007FFE2002 00003C (v01 BOCHS  BXPC  =
   00000001 BXPC 00000001)
> >>>[    0.004978] ACPI: WAET 0x000000007FFE203E 000028 (v01 BOCHS  BXPC  =
   00000001 BXPC 00000001)
> >>>[    0.004984] ACPI: Reserving FACP table memory at [mem 0x7ffe1e8e-0x=
7ffe1f81]
> >>>[    0.004988] ACPI: Reserving DSDT table memory at [mem 0x7ffe0040-0x=
7ffe1e8d]
> >>>[    0.004991] ACPI: Reserving FACS table memory at [mem 0x7ffe0000-0x=
7ffe003f]
> >>>[    0.004993] ACPI: Reserving APIC table memory at [mem 0x7ffe1f82-0x=
7ffe2001]
> >>>[    0.004996] ACPI: Reserving MCFG table memory at [mem 0x7ffe2002-0x=
7ffe203d]
> >>>[    0.004999] ACPI: Reserving WAET table memory at [mem 0x7ffe203e-0x=
7ffe2065]
> >>>[    0.008477] Zone ranges:
> >>>[    0.008484]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
> >>>[    0.008491]   DMA32    [mem 0x0000000001000000-0x000000007ffdbfff]
> >>>[    0.008495]   Normal   empty
> >>>[    0.008499] Movable zone start for each node
> >>>[    0.008518] Early memory node ranges
> >>>[    0.008521]   node   0: [mem 0x0000000000001000-0x000000000009efff]
> >>>[    0.008535]   node   0: [mem 0x0000000000100000-0x000000007ffdbfff]
> >>>[    0.008538] Initmem setup node 0 [mem 0x0000000000001000-0x00000000=
7ffdbfff]
> >>>[    0.008548] On node 0, zone DMA: 1 pages in unavailable ranges
> >>>[    0.008622] On node 0, zone DMA: 97 pages in unavailable ranges
> >>>[    0.016858] On node 0, zone DMA32: 36 pages in unavailable ranges
> >>>[    0.048098] kasan: KernelAddressSanitizer initialized
> >>>[    0.048939] ACPI: PM-Timer IO Port: 0x608
> >>>[    0.048950] ACPI: LAPIC_NMI (acpi_id[0xff] dfl dfl lint[0x1])
> >>>[    0.048993] IOAPIC[0]: apic_id 0, version 17, address 0xfec00000, G=
SI 0-23
> >>>[    0.049002] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
> >>>[    0.049006] ACPI: INT_SRC_OVR (bus 0 bus_irq 5 global_irq 5 high le=
vel)
> >>>[    0.049009] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high le=
vel)
> >>>[    0.049012] ACPI: INT_SRC_OVR (bus 0 bus_irq 10 global_irq 10 high =
level)
> >>>[    0.049015] ACPI: INT_SRC_OVR (bus 0 bus_irq 11 global_irq 11 high =
level)
> >>>[    0.049021] ACPI: Using ACPI (MADT) for SMP configuration informati=
on
> >>>[    0.049024] TSC deadline timer available
> >>>[    0.049030] smpboot: Allowing 2 CPUs, 0 hotplug CPUs
> >>>[    0.049050] [mem 0xc0000000-0xfed1bfff] available for PCI devices
> >>>[    0.049055] clocksource: refined-jiffies: mask: 0xffffffff max_cycl=
es: 0xffffffff, max_idle_ns: 7645519600211568 ns
> >>>[    0.064532] setup_percpu: NR_CPUS:8 nr_cpumask_bits:8 nr_cpu_ids:2 =
nr_node_ids:1
> >>>[    0.064789] percpu: Embedded 66 pages/cpu s231440 r8192 d30704 u104=
8576
> >>>[    0.064798] pcpu-alloc: s231440 r8192 d30704 u1048576 alloc=3D1*209=
7152
> >>>[    0.064802] pcpu-alloc: [0] 0 1
> >>>[    0.064836] Built 1 zonelists, mobility grouping on.  Total pages: =
516828
> >>>[    0.064886] Kernel command line: BOOT_IMAGE=3D(hd0,msdos1)/vmlinuz-=
5.16.0-00002-g616758bf6583 root=3D/dev/mapper/fedora-root ro resume=3D/dev/=
mapper/fedora-swap rd.lvm.lv=3Dfedora/root rd.lvm.lv=3Dfedora/swap console=
=3Dtty0 console=3DttyS0,38400n8 consoleblank=3D0
> >>>[    0.064998] Unknown kernel command line parameters "BOOT_IMAGE=3D(h=
d0,msdos1)/vmlinuz-5.16.0-00002-g616758bf6583 resume=3D/dev/mapper/fedora-s=
wap", will be passed to user space.
> >>>[    0.065286] Dentry cache hash table entries: 262144 (order: 9, 2097=
152 bytes, linear)
> >>>[    0.065405] Inode-cache hash table entries: 131072 (order: 8, 10485=
76 bytes, linear)
> >>>[    0.065443] mem auto-init: stack:off, heap alloc:off, heap free:off
> >>>[    0.217018] Memory: 1653208K/2096616K available (49170K kernel code=
, 11662K rwdata, 9292K rodata, 2076K init, 15268K bss, 443152K reserved, 0K=
 cma-reserved)
> >>>[    0.218927] Kernel/User page tables isolation: enabled
> >>>[    0.219010] ftrace: allocating 48466 entries in 190 pages
> >>>[    0.236213] ftrace: allocated 190 pages with 6 groups
> >>>[    0.236405] Dynamic Preempt: full
> >>>[    0.236588] Running RCU self tests
> >>>[    0.236599] rcu: Preemptible hierarchical RCU implementation.
> >>>[    0.236602] rcu: 	RCU lockdep checking is enabled.
> >>>[    0.236604] rcu: 	RCU restricting CPUs from NR_CPUS=3D8 to nr_cpu_i=
ds=3D2.
> >>>[    0.236608] 	Trampoline variant of Tasks RCU enabled.
> >>>[    0.236610] 	Rude variant of Tasks RCU enabled.
> >>>[    0.236612] 	Tracing variant of Tasks RCU enabled.
> >>>[    0.236614] rcu: RCU calculated value of scheduler-enlistment delay=
 is 25 jiffies.
> >>>[    0.236617] rcu: Adjusting geometry for rcu_fanout_leaf=3D16, nr_cp=
u_ids=3D2
> >>>[    0.246098] NR_IRQS: 4352, nr_irqs: 56, preallocated irqs: 16
> >>>[    0.246516] random: get_random_bytes called from start_kernel+0x1ef=
/0x384 with crng_init=3D0
> >>>[    0.252863] Console: colour VGA+ 80x25
> >>>[    0.285411] printk: console [tty0] enabled
> >>>[    0.341424] printk: console [ttyS0] enabled
> >>>[    0.342010] Lock dependency validator: Copyright (c) 2006 Red Hat, =
Inc., Ingo Molnar
> >>>[    0.343034] ... MAX_LOCKDEP_SUBCLASSES:  8
> >>>[    0.343564] ... MAX_LOCK_DEPTH:          48
> >>>[    0.344099] ... MAX_LOCKDEP_KEYS:        8192
> >>>[    0.344657] ... CLASSHASH_SIZE:          4096
> >>>[    0.345239] ... MAX_LOCKDEP_ENTRIES:     32768
> >>>[    0.345872] ... MAX_LOCKDEP_CHAINS:      65536
> >>>[    0.346470] ... CHAINHASH_SIZE:          32768
> >>>[    0.347042]  memory used by lock dependency info: 6365 kB
> >>>[    0.347732]  memory used for stack traces: 4224 kB
> >>>[    0.349158]  per task-struct memory footprint: 1920 bytes
> >>>[    0.350184] ACPI: Core revision 20210930
> >>>[    0.351362] APIC: Switch to symmetric I/O mode setup
> >>>[    0.353278] clocksource: tsc-early: mask: 0xffffffffffffffff max_cy=
cles: 0x33c604d3dd7, max_idle_ns: 440795267083 ns
> >>>[    0.354743] Calibrating delay loop (skipped), value calculated usin=
g timer frequency.. 7183.57 BogoMIPS (lpj=3D14367148)
> >>>[    0.356135] pid_max: default: 32768 minimum: 301
> >>>[    0.356866] LSM: Security Framework initializing
> >>>[    0.357606] SELinux:  Initializing.
> >>>[    0.358214] Mount-cache hash table entries: 4096 (order: 3, 32768 b=
ytes, linear)
> >>>[    0.358743] Mountpoint-cache hash table entries: 4096 (order: 3, 32=
768 bytes, linear)
> >>>[    0.358743] x86/cpu: User Mode Instruction Prevention (UMIP) activa=
ted
> >>>[    0.358743] Last level iTLB entries: 4KB 0, 2MB 0, 4MB 0
> >>>[    0.358743] Last level dTLB entries: 4KB 0, 2MB 0, 4MB 0, 1GB 0
> >>>[    0.358743] Spectre V1 : Mitigation: usercopy/swapgs barriers and _=
_user pointer sanitization
> >>>[    0.358743] Spectre V2 : Mitigation: Full generic retpoline
> >>>[    0.358743] Spectre V2 : Spectre v2 / SpectreRSB mitigation: Fillin=
g RSB on context switch
> >>>[    0.358743] Spectre V2 : Enabling Restricted Speculation for firmwa=
re calls
> >>>[    0.358743] Spectre V2 : mitigation: Enabling conditional Indirect =
Branch Prediction Barrier
> >>>[    0.358743] Speculative Store Bypass: Mitigation: Speculative Store=
 Bypass disabled via prctl
> >>>[    0.358743] SRBDS: Unknown: Dependent on hypervisor status
> >>>[    0.358743] MDS: Mitigation: Clear CPU buffers
> >>>[    0.358743] Freeing SMP alternatives memory: 44K
> >>>[    0.358743] smpboot: CPU0: Intel Core Processor (Haswell, no TSX, I=
BRS) (family: 0x6, model: 0x3c, stepping: 0x1)
> >>>[    0.358743] Running RCU-tasks wait API self tests
> >>>[    0.458995] Performance Events: unsupported p6 CPU model 60 no PMU =
driver, software events only.
> >>>[    0.460503] rcu: Hierarchical SRCU implementation.
> >>>[    0.462157] NMI watchdog: Perf NMI watchdog permanently disabled
> >>>[    0.463002] smp: Bringing up secondary CPUs ...
> >>>[    0.464950] x86: Booting SMP configuration:
> >>>[    0.465537] .... node  #0, CPUs:      #1
> >>>[    0.112317] smpboot: CPU 1 Converting physical 0 to logical die 1
> >>>[    0.547215] smp: Brought up 1 node, 2 CPUs
> >>>[    0.547814] smpboot: Max logical packages: 2
> >>>[    0.548434] smpboot: Total of 2 processors activated (14386.42 Bogo=
MIPS)
> >>>[    0.550634] devtmpfs: initialized
> >>>[    0.554801] Callback from call_rcu_tasks_trace() invoked.
> >>>[    0.556772] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xff=
ffffff, max_idle_ns: 7645041785100000 ns
> >>>[    0.558148] futex hash table entries: 512 (order: 4, 65536 bytes, l=
inear)
> >>>[    0.560130] NET: Registered PF_NETLINK/PF_ROUTE protocol family
> >>>[    0.561904] audit: initializing netlink subsys (disabled)
> >>>[    0.562980] Callback from call_rcu_tasks_rude() invoked.
> >>>[    0.562980] audit: type=3D2000 audit(1642005631.208:1): state=3Dini=
tialized audit_enabled=3D0 res=3D1
> >>>[    0.564434] thermal_sys: Registered thermal governor 'step_wise'
> >>>[    0.564897] thermal_sys: Registered thermal governor 'user_space'
> >>>[    0.565807] cpuidle: using governor ladder
> >>>[    0.567202] PCI: MMCONFIG for domain 0000 [bus 00-ff] at [mem 0xb00=
00000-0xbfffffff] (base 0xb0000000)
> >>>[    0.568443] PCI: MMCONFIG at [mem 0xb0000000-0xbfffffff] reserved i=
n E820
> >>>[    0.569384] PCI: Using configuration type 1 for base access
> >>>[    0.595171] kprobes: kprobe jump-optimization is enabled. All kprob=
es are optimized if possible.
> >>>[    0.597094] HugeTLB registered 2.00 MiB page size, pre-allocated 0 =
pages
> >>>[    0.598409] cryptd: max_cpu_qlen set to 1000
> >>>[    0.666772] raid6: avx2x4   gen() 33460 MB/s
> >>>[    0.670759] Callback from call_rcu_tasks() invoked.
> >>>[    0.738747] raid6: avx2x4   xor() 12834 MB/s
> >>>[    0.806748] raid6: avx2x2   gen() 31395 MB/s
> >>>[    0.874753] raid6: avx2x2   xor() 16250 MB/s
> >>>[    0.942748] raid6: avx2x1   gen() 21106 MB/s
> >>>[    1.010748] raid6: avx2x1   xor() 13944 MB/s
> >>>[    1.078749] raid6: sse2x4   gen() 15737 MB/s
> >>>[    1.146749] raid6: sse2x4   xor()  8765 MB/s
> >>>[    1.214864] raid6: sse2x2   gen() 15874 MB/s
> >>>[    1.282747] raid6: sse2x2   xor()  9860 MB/s
> >>>[    1.350748] raid6: sse2x1   gen() 12302 MB/s
> >>>[    1.418748] raid6: sse2x1   xor()  8642 MB/s
> >>>[    1.419372] raid6: using algorithm avx2x4 gen() 33460 MB/s
> >>>[    1.420108] raid6: .... xor() 12834 MB/s, rmw enabled
> >>>[    1.420790] raid6: using avx2x2 recovery algorithm
> >>>[    1.421810] ACPI: Added _OSI(Module Device)
> >>>[    1.422358] ACPI: Added _OSI(Processor Device)
> >>>[    1.422750] ACPI: Added _OSI(3.0 _SCP Extensions)
> >>>[    1.423428] ACPI: Added _OSI(Processor Aggregator Device)
> >>>[    1.424154] ACPI: Added _OSI(Linux-Dell-Video)
> >>>[    1.424733] ACPI: Added _OSI(Linux-Lenovo-NV-HDMI-Audio)
> >>>[    1.425493] ACPI: Added _OSI(Linux-HPI-Hybrid-Graphics)
> >>>[    1.457880] ACPI: 1 ACPI AML tables successfully acquired and loaded
> >>>[    1.482752] ACPI: Interpreter enabled
> >>>[    1.482752] ACPI: PM: (supports S0 S5)
> >>>[    1.482761] ACPI: Using IOAPIC for interrupt routing
> >>>[    1.483660] PCI: Using host bridge windows from ACPI; if necessary,=
 use "pci=3Dnocrs" and report a bug
> >>>[    1.486749] ACPI: Enabled 1 GPEs in block 00 to 3F
> >>>[    1.519179] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-ff])
> >>>[    1.520193] acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM=
 ClockPM Segments HPX-Type3]
> >>>[    1.521406] acpi PNP0A08:00: PCIe port services disabled; not reque=
sting _OSC control
> >>>[    1.524178] PCI host bridge to bus 0000:00
> >>>[    1.525561] pci_bus 0000:00: root bus resource [io  0x0000-0x0cf7 w=
indow]
> >>>[    1.526771] pci_bus 0000:00: root bus resource [io  0x0d00-0xffff w=
indow]
> >>>[    1.527754] pci_bus 0000:00: root bus resource [mem 0x000a0000-0x00=
0bffff window]
> >>>[    1.528814] pci_bus 0000:00: root bus resource [mem 0x80000000-0xaf=
ffffff window]
> >>>[    1.529801] pci_bus 0000:00: root bus resource [mem 0xc0000000-0xfe=
bfffff window]
> >>>[    1.530753] pci_bus 0000:00: root bus resource [mem 0x100000000-0x8=
ffffffff window]
> >>>[    1.531784] pci_bus 0000:00: root bus resource [bus 00-ff]
> >>>[    1.532720] pci 0000:00:00.0: [8086:29c0] type 00 class 0x060000
> >>>[    1.535064] pci 0000:00:01.0: [1b36:0100] type 00 class 0x030000
> >>>[    1.538691] pci 0000:00:01.0: reg 0x10: [mem 0xf4000000-0xf7ffffff]
> >>>[    1.541347] pci 0000:00:01.0: reg 0x14: [mem 0xf8000000-0xfbffffff]
> >>>[    1.548136] pci 0000:00:01.0: reg 0x18: [mem 0xfce14000-0xfce15fff]
> >>>[    1.551749] pci 0000:00:01.0: reg 0x1c: [io  0xc040-0xc05f]
> >>>[    1.562234] pci 0000:00:01.0: reg 0x30: [mem 0xfce00000-0xfce0ffff =
pref]
> >>>[    1.564193] pci 0000:00:02.0: [1b36:000c] type 01 class 0x060400
> >>>[    1.566392] pci 0000:00:02.0: reg 0x10: [mem 0xfce16000-0xfce16fff]
> >>>[    1.570855] pci 0000:00:02.1: [1b36:000c] type 01 class 0x060400
> >>>[    1.572957] pci 0000:00:02.1: reg 0x10: [mem 0xfce17000-0xfce17fff]
> >>>[    1.576544] pci 0000:00:02.2: [1b36:000c] type 01 class 0x060400
> >>>[    1.578655] pci 0000:00:02.2: reg 0x10: [mem 0xfce18000-0xfce18fff]
> >>>[    1.584327] pci 0000:00:02.3: [1b36:000c] type 01 class 0x060400
> >>>[    1.587400] pci 0000:00:02.3: reg 0x10: [mem 0xfce19000-0xfce19fff]
> >>>[    1.591318] pci 0000:00:02.4: [1b36:000c] type 01 class 0x060400
> >>>[    1.594121] pci 0000:00:02.4: reg 0x10: [mem 0xfce1a000-0xfce1afff]
> >>>[    1.601524] pci 0000:00:02.5: [1b36:000c] type 01 class 0x060400
> >>>[    1.603552] pci 0000:00:02.5: reg 0x10: [mem 0xfce1b000-0xfce1bfff]
> >>>[    1.609104] pci 0000:00:02.6: [1b36:000c] type 01 class 0x060400
> >>>[    1.611147] pci 0000:00:02.6: reg 0x10: [mem 0xfce1c000-0xfce1cfff]
> >>>[    1.615049] pci 0000:00:1b.0: [8086:293e] type 00 class 0x040300
> >>>[    1.616318] pci 0000:00:1b.0: reg 0x10: [mem 0xfce10000-0xfce13fff]
> >>>[    1.622859] pci 0000:00:1f.0: [8086:2918] type 00 class 0x060100
> >>>[    1.624201] pci 0000:00:1f.0: quirk: [io  0x0600-0x067f] claimed by=
 ICH6 ACPI/GPIO/TCO
> >>>[    1.626532] pci 0000:00:1f.2: [8086:2922] type 00 class 0x010601
> >>>[    1.631433] pci 0000:00:1f.2: reg 0x20: [io  0xc060-0xc07f]
> >>>[    1.633066] pci 0000:00:1f.2: reg 0x24: [mem 0xfce1d000-0xfce1dfff]
> >>>[    1.635263] pci 0000:00:1f.3: [8086:2930] type 00 class 0x0c0500
> >>>[    1.638672] pci 0000:00:1f.3: reg 0x20: [io  0x0700-0x073f]
> >>>[    1.646276] pci 0000:01:00.0: [1af4:1041] type 00 class 0x020000
> >>>[    1.648447] pci 0000:01:00.0: reg 0x14: [mem 0xfcc40000-0xfcc40fff]
> >>>[    1.651541] pci 0000:01:00.0: reg 0x20: [mem 0xfea00000-0xfea03fff =
64bit pref]
> >>>[    1.654708] pci 0000:01:00.0: reg 0x30: [mem 0xfcc00000-0xfcc3ffff =
pref]
> >>>[    1.656245] pci 0000:00:02.0: PCI bridge to [bus 01]
> >>>[    1.657166] pci 0000:00:02.0:   bridge window [mem 0xfcc00000-0xfcd=
fffff]
> >>>[    1.658560] pci 0000:00:02.0:   bridge window [mem 0xfea00000-0xfeb=
fffff 64bit pref]
> >>>[    1.665128] pci 0000:02:00.0: [1b36:000d] type 00 class 0x0c0330
> >>>[    1.666639] pci 0000:02:00.0: reg 0x10: [mem 0xfca00000-0xfca03fff =
64bit]
> >>>[    1.669547] pci 0000:00:02.1: PCI bridge to [bus 02]
> >>>[    1.670253] pci 0000:00:02.1:   bridge window [mem 0xfca00000-0xfcb=
fffff]
> >>>[    1.670778] pci 0000:00:02.1:   bridge window [mem 0xfe800000-0xfe9=
fffff 64bit pref]
> >>>[    1.672750] pci 0000:03:00.0: [1af4:1043] type 00 class 0x078000
> >>>[    1.676211] pci 0000:03:00.0: reg 0x14: [mem 0xfc800000-0xfc800fff]
> >>>[    1.679169] pci 0000:03:00.0: reg 0x20: [mem 0xfe600000-0xfe603fff =
64bit pref]
> >>>[    1.682558] pci 0000:00:02.2: PCI bridge to [bus 03]
> >>>[    1.682793] pci 0000:00:02.2:   bridge window [mem 0xfc800000-0xfc9=
fffff]
> >>>[    1.685144] pci 0000:00:02.2:   bridge window [mem 0xfe600000-0xfe7=
fffff 64bit pref]
> >>>[    1.687495] pci 0000:04:00.0: [1af4:1042] type 00 class 0x010000
> >>>[    1.689946] pci 0000:04:00.0: reg 0x14: [mem 0xfc600000-0xfc600fff]
> >>>[    1.693151] pci 0000:04:00.0: reg 0x20: [mem 0xfe400000-0xfe403fff =
64bit pref]
> >>>[    1.700473] pci 0000:00:02.3: PCI bridge to [bus 04]
> >>>[    1.701209] pci 0000:00:02.3:   bridge window [mem 0xfc600000-0xfc7=
fffff]
> >>>[    1.702128] pci 0000:00:02.3:   bridge window [mem 0xfe400000-0xfe5=
fffff 64bit pref]
> >>>[    1.703714] pci 0000:05:00.0: [1af4:1045] type 00 class 0x00ff00
> >>>[    1.707200] pci 0000:05:00.0: reg 0x20: [mem 0xfe200000-0xfe203fff =
64bit pref]
> >>>[    1.711310] pci 0000:00:02.4: PCI bridge to [bus 05]
> >>>[    1.712069] pci 0000:00:02.4:   bridge window [mem 0xfc400000-0xfc5=
fffff]
> >>>[    1.713336] pci 0000:00:02.4:   bridge window [mem 0xfe200000-0xfe3=
fffff 64bit pref]
> >>>[    1.716482] pci 0000:06:00.0: [1af4:1044] type 00 class 0x00ff00
> >>>[    1.722542] pci 0000:06:00.0: reg 0x20: [mem 0xfe000000-0xfe003fff =
64bit pref]
> >>>[    1.725211] pci 0000:00:02.5: PCI bridge to [bus 06]
> >>>[    1.726212] pci 0000:00:02.5:   bridge window [mem 0xfc200000-0xfc3=
fffff]
> >>>[    1.726791] pci 0000:00:02.5:   bridge window [mem 0xfe000000-0xfe1=
fffff 64bit pref]
> >>>[    1.729879] pci 0000:00:02.6: PCI bridge to [bus 07]
> >>>[    1.730651] pci 0000:00:02.6:   bridge window [mem 0xfc000000-0xfc1=
fffff]
> >>>[    1.730778] pci 0000:00:02.6:   bridge window [mem 0xfde00000-0xfdf=
fffff 64bit pref]
> >>>[    1.736005] pci_bus 0000:00: on NUMA node 0
> >>>[    1.741503] ACPI: PCI: Interrupt link LNKA configured for IRQ 10
> >>>[    1.744737] ACPI: PCI: Interrupt link LNKB configured for IRQ 10
> >>>[    1.746758] ACPI: PCI: Interrupt link LNKC configured for IRQ 11
> >>>[    1.748846] ACPI: PCI: Interrupt link LNKD configured for IRQ 11
> >>>[    1.750851] ACPI: PCI: Interrupt link LNKE configured for IRQ 10
> >>>[    1.752940] ACPI: PCI: Interrupt link LNKF configured for IRQ 10
> >>>[    1.754949] ACPI: PCI: Interrupt link LNKG configured for IRQ 11
> >>>[    1.757050] ACPI: PCI: Interrupt link LNKH configured for IRQ 11
> >>>[    1.758160] ACPI: PCI: Interrupt link GSIA configured for IRQ 16
> >>>[    1.758938] ACPI: PCI: Interrupt link GSIB configured for IRQ 17
> >>>[    1.759889] ACPI: PCI: Interrupt link GSIC configured for IRQ 18
> >>>[    1.760914] ACPI: PCI: Interrupt link GSID configured for IRQ 19
> >>>[    1.761939] ACPI: PCI: Interrupt link GSIE configured for IRQ 20
> >>>[    1.766937] ACPI: PCI: Interrupt link GSIF configured for IRQ 21
> >>>[    1.767962] ACPI: PCI: Interrupt link GSIG configured for IRQ 22
> >>>[    1.768958] ACPI: PCI: Interrupt link GSIH configured for IRQ 23
> >>>[    1.773089] pci 0000:00:01.0: vgaarb: setting as boot VGA device
> >>>[    1.773978] pci 0000:00:01.0: vgaarb: VGA device added: decodes=3Di=
o+mem,owns=3Dio+mem,locks=3Dnone
> >>>[    1.774767] pci 0000:00:01.0: vgaarb: bridge control possible
> >>>[    1.775580] vgaarb: loaded
> >>>[    1.776770] SCSI subsystem initialized
> >>>[    1.778193] libata version 3.00 loaded.
> >>>[    1.778193] ACPI: bus type USB registered
> >>>[    1.778750] usbcore: registered new interface driver usbfs
> >>>[    1.778857] usbcore: registered new interface driver hub
> >>>[    1.779636] usbcore: registered new device driver usb
> >>>[    1.780451] pps_core: LinuxPPS API ver. 1 registered
> >>>[    1.781112] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rod=
olfo Giometti <giometti@linux.it>
> >>>[    1.782493] PTP clock support registered
> >>>[    1.784500] EDAC MC: Ver: 3.0.0
> >>>[    1.785785] Advanced Linux Sound Architecture Driver Initialized.
> >>>[    1.786798] PCI: Using ACPI for IRQ routing
> >>>[    1.842255] PCI: pci_cache_line_size set to 64 bytes
> >>>[    1.842540] e820: reserve RAM buffer [mem 0x0009fc00-0x0009ffff]
> >>>[    1.842577] e820: reserve RAM buffer [mem 0x7ffdc000-0x7fffffff]
> >>>[    1.842970] clocksource: Switched to clocksource tsc-early
> >>>[    2.035298] VFS: Disk quotas dquot_6.6.0
> >>>[    2.035981] VFS: Dquot-cache hash table entries: 512 (order 0, 4096=
 bytes)
> >>>[    2.037121] FS-Cache: Loaded
> >>>[    2.037960] CacheFiles: Loaded
> >>>[    2.038518] pnp: PnP ACPI init
> >>>[    2.040511] system 00:04: [mem 0xb0000000-0xbfffffff window] has be=
en reserved
> >>>[    2.044352] pnp: PnP ACPI: found 5 devices
> >>>[    2.064254] clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffff=
ff, max_idle_ns: 2085701024 ns
> >>>[    2.065958] NET: Registered PF_INET protocol family
> >>>[    2.066945] IP idents hash table entries: 32768 (order: 6, 262144 b=
ytes, linear)
> >>>[    2.069039] tcp_listen_portaddr_hash hash table entries: 1024 (orde=
r: 4, 81920 bytes, linear)
> >>>[    2.070326] TCP established hash table entries: 16384 (order: 5, 13=
1072 bytes, linear)
> >>>[    2.071828] TCP bind hash table entries: 16384 (order: 8, 1179648 b=
ytes, linear)
> >>>[    2.073288] TCP: Hash tables configured (established 16384 bind 163=
84)
> >>>[    2.074354] UDP hash table entries: 1024 (order: 5, 163840 bytes, l=
inear)
> >>>[    2.075383] UDP-Lite hash table entries: 1024 (order: 5, 163840 byt=
es, linear)
> >>>[    2.076613] NET: Registered PF_UNIX/PF_LOCAL protocol family
> >>>[    2.077413] pci 0000:00:02.0: bridge window [io  0x1000-0x0fff] to =
[bus 01] add_size 1000
> >>>[    2.078529] pci 0000:00:02.1: bridge window [io  0x1000-0x0fff] to =
[bus 02] add_size 1000
> >>>[    2.079641] pci 0000:00:02.2: bridge window [io  0x1000-0x0fff] to =
[bus 03] add_size 1000
> >>>[    2.080719] pci 0000:00:02.3: bridge window [io  0x1000-0x0fff] to =
[bus 04] add_size 1000
> >>>[    2.081811] pci 0000:00:02.4: bridge window [io  0x1000-0x0fff] to =
[bus 05] add_size 1000
> >>>[    2.082948] pci 0000:00:02.5: bridge window [io  0x1000-0x0fff] to =
[bus 06] add_size 1000
> >>>[    2.084025] pci 0000:00:02.6: bridge window [io  0x1000-0x0fff] to =
[bus 07] add_size 1000
> >>>[    2.085111] pci 0000:00:02.0: BAR 7: assigned [io  0x1000-0x1fff]
> >>>[    2.085981] pci 0000:00:02.1: BAR 7: assigned [io  0x2000-0x2fff]
> >>>[    2.086810] pci 0000:00:02.2: BAR 7: assigned [io  0x3000-0x3fff]
> >>>[    2.087614] pci 0000:00:02.3: BAR 7: assigned [io  0x4000-0x4fff]
> >>>[    2.088415] pci 0000:00:02.4: BAR 7: assigned [io  0x5000-0x5fff]
> >>>[    2.089201] pci 0000:00:02.5: BAR 7: assigned [io  0x6000-0x6fff]
> >>>[    2.090032] pci 0000:00:02.6: BAR 7: assigned [io  0x7000-0x7fff]
> >>>[    2.091014] pci 0000:00:02.0: PCI bridge to [bus 01]
> >>>[    2.091666] pci 0000:00:02.0:   bridge window [io  0x1000-0x1fff]
> >>>[    2.093625] pci 0000:00:02.0:   bridge window [mem 0xfcc00000-0xfcd=
fffff]
> >>>[    2.096206] pci 0000:00:02.0:   bridge window [mem 0xfea00000-0xfeb=
fffff 64bit pref]
> >>>[    2.098607] pci 0000:00:02.1: PCI bridge to [bus 02]
> >>>[    2.107557] pci 0000:00:02.1:   bridge window [io  0x2000-0x2fff]
> >>>[    2.109321] pci 0000:00:02.1:   bridge window [mem 0xfca00000-0xfcb=
fffff]
> >>>[    2.111058] pci 0000:00:02.1:   bridge window [mem 0xfe800000-0xfe9=
fffff 64bit pref]
> >>>[    2.113315] pci 0000:00:02.2: PCI bridge to [bus 03]
> >>>[    2.114828] pci 0000:00:02.2:   bridge window [io  0x3000-0x3fff]
> >>>[    2.116339] pci 0000:00:02.2:   bridge window [mem 0xfc800000-0xfc9=
fffff]
> >>>[    2.117673] pci 0000:00:02.2:   bridge window [mem 0xfe600000-0xfe7=
fffff 64bit pref]
> >>>[    2.119702] pci 0000:00:02.3: PCI bridge to [bus 04]
> >>>[    2.120377] pci 0000:00:02.3:   bridge window [io  0x4000-0x4fff]
> >>>[    2.122070] pci 0000:00:02.3:   bridge window [mem 0xfc600000-0xfc7=
fffff]
> >>>[    2.123621] pci 0000:00:02.3:   bridge window [mem 0xfe400000-0xfe5=
fffff 64bit pref]
> >>>[    2.127750] pci 0000:00:02.4: PCI bridge to [bus 05]
> >>>[    2.128452] pci 0000:00:02.4:   bridge window [io  0x5000-0x5fff]
> >>>[    2.129948] pci 0000:00:02.4:   bridge window [mem 0xfc400000-0xfc5=
fffff]
> >>>[    2.131293] pci 0000:00:02.4:   bridge window [mem 0xfe200000-0xfe3=
fffff 64bit pref]
> >>>[    2.133183] pci 0000:00:02.5: PCI bridge to [bus 06]
> >>>[    2.133884] pci 0000:00:02.5:   bridge window [io  0x6000-0x6fff]
> >>>[    2.135463] pci 0000:00:02.5:   bridge window [mem 0xfc200000-0xfc3=
fffff]
> >>>[    2.137987] pci 0000:00:02.5:   bridge window [mem 0xfe000000-0xfe1=
fffff 64bit pref]
> >>>[    2.139814] pci 0000:00:02.6: PCI bridge to [bus 07]
> >>>[    2.140490] pci 0000:00:02.6:   bridge window [io  0x7000-0x7fff]
> >>>[    2.141949] pci 0000:00:02.6:   bridge window [mem 0xfc000000-0xfc1=
fffff]
> >>>[    2.143311] pci 0000:00:02.6:   bridge window [mem 0xfde00000-0xfdf=
fffff 64bit pref]
> >>>[    2.145174] pci_bus 0000:00: resource 4 [io  0x0000-0x0cf7 window]
> >>>[    2.146052] pci_bus 0000:00: resource 5 [io  0x0d00-0xffff window]
> >>>[    2.148019] pci_bus 0000:00: resource 6 [mem 0x000a0000-0x000bffff =
window]
> >>>[    2.148914] pci_bus 0000:00: resource 7 [mem 0x80000000-0xafffffff =
window]
> >>>[    2.149845] pci_bus 0000:00: resource 8 [mem 0xc0000000-0xfebfffff =
window]
> >>>[    2.150799] pci_bus 0000:00: resource 9 [mem 0x100000000-0x8fffffff=
f window]
> >>>[    2.151720] pci_bus 0000:01: resource 0 [io  0x1000-0x1fff]
> >>>[    2.152452] pci_bus 0000:01: resource 1 [mem 0xfcc00000-0xfcdfffff]
> >>>[    2.153255] pci_bus 0000:01: resource 2 [mem 0xfea00000-0xfebfffff =
64bit pref]
> >>>[    2.154240] pci_bus 0000:02: resource 0 [io  0x2000-0x2fff]
> >>>[    2.155046] pci_bus 0000:02: resource 1 [mem 0xfca00000-0xfcbfffff]
> >>>[    2.156636] pci_bus 0000:02: resource 2 [mem 0xfe800000-0xfe9fffff =
64bit pref]
> >>>[    2.157602] pci_bus 0000:03: resource 0 [io  0x3000-0x3fff]
> >>>[    2.158387] pci_bus 0000:03: resource 1 [mem 0xfc800000-0xfc9fffff]
> >>>[    2.159282] pci_bus 0000:03: resource 2 [mem 0xfe600000-0xfe7fffff =
64bit pref]
> >>>[    2.160251] pci_bus 0000:04: resource 0 [io  0x4000-0x4fff]
> >>>[    2.161035] pci_bus 0000:04: resource 1 [mem 0xfc600000-0xfc7fffff]
> >>>[    2.161909] pci_bus 0000:04: resource 2 [mem 0xfe400000-0xfe5fffff =
64bit pref]
> >>>[    2.162902] pci_bus 0000:05: resource 0 [io  0x5000-0x5fff]
> >>>[    2.163619] pci_bus 0000:05: resource 1 [mem 0xfc400000-0xfc5fffff]
> >>>[    2.164420] pci_bus 0000:05: resource 2 [mem 0xfe200000-0xfe3fffff =
64bit pref]
> >>>[    2.165342] pci_bus 0000:06: resource 0 [io  0x6000-0x6fff]
> >>>[    2.166091] pci_bus 0000:06: resource 1 [mem 0xfc200000-0xfc3fffff]
> >>>[    2.166960] pci_bus 0000:06: resource 2 [mem 0xfe000000-0xfe1fffff =
64bit pref]
> >>>[    2.167884] pci_bus 0000:07: resource 0 [io  0x7000-0x7fff]
> >>>[    2.168599] pci_bus 0000:07: resource 1 [mem 0xfc000000-0xfc1fffff]
> >>>[    2.169400] pci_bus 0000:07: resource 2 [mem 0xfde00000-0xfdffffff =
64bit pref]
> >>>[    2.170541] pci 0000:00:01.0: Video device with shadowed ROM at [me=
m 0x000c0000-0x000dffff]
> >>>[    2.180949] ACPI: \_SB_.GSIG: Enabled at IRQ 22
> >>>[    2.199686] pci 0000:02:00.0: quirk_usb_early_handoff+0x0/0xa70 too=
k 27224 usecs
> >>>[    2.200800] PCI: CLS 0 bytes, default 64
> >>>[    2.202085] Trying to unpack rootfs image as initramfs...
> >>>[    2.203583] Initialise system trusted keyrings
> >>>[    2.204372] workingset: timestamp_bits=3D62 max_order=3D19 bucket_o=
rder=3D0
> >>>[    2.206592] DLM installed
> >>>[    2.210086] Key type cifs.idmap registered
> >>>[    2.210915] fuse: init (API version 7.35)
> >>>[    2.211730] SGI XFS with ACLs, security attributes, no debug enabled
> >>>[    2.213541] ocfs2: Registered cluster interface o2cb
> >>>[    2.214457] ocfs2: Registered cluster interface user
> >>>[    2.215320] OCFS2 User DLM kernel interface loaded
> >>>[    2.223471] gfs2: GFS2 installed
> >>>[    2.232573] xor: automatically using best checksumming function   a=
vx
> >>>[    2.233488] Key type asymmetric registered
> >>>[    2.234109] Asymmetric key parser 'x509' registered
> >>>[    2.235034] Block layer SCSI generic (bsg) driver version 0.4 loade=
d (major 251)
> >>>[    2.236044] io scheduler mq-deadline registered
> >>>[    2.236631] io scheduler kyber registered
> >>>[    2.237151] test_string_helpers: Running tests...
> >>>[    2.251590] cryptomgr_test (80) used greatest stack depth: 30192 by=
tes left
> >>>[    2.253812] shpchp: Standard Hot Plug PCI Controller Driver version=
: 0.4
> >>>[    2.255322] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00=
/input/input0
> >>>[    2.263630] ACPI: button: Power Button [PWRF]
> >>>[    2.503777] Serial: 8250/16550 driver, 4 ports, IRQ sharing disabled
> >>>[    2.505227] 00:00: ttyS0 at I/O 0x3f8 (irq =3D 4, base_baud =3D 115=
200) is a 16550A
> >>>[    2.512214] Non-volatile memory driver v1.3
> >>>[    2.513012] Linux agpgart interface v0.103
> >>>[    2.515374] ACPI: bus type drm_connector registered
> >>>[    2.536836] brd: module loaded
> >>>[    2.553358] loop: module loaded
> >>>[    2.554597] virtio_blk virtio2: [vda] 41943040 512-byte logical blo=
cks (21.5 GB/20.0 GiB)
> >>>[    2.560013]  vda: vda1 vda2
> >>>[    2.563947] zram: Added device: zram0
> >>>[    2.565170] ahci 0000:00:1f.2: version 3.0
> >>>[    2.577984] ACPI: \_SB_.GSIA: Enabled at IRQ 16
> >>>[    2.581236] ahci 0000:00:1f.2: AHCI 0001.0000 32 slots 6 ports 1.5 =
Gbps 0x3f impl SATA mode
> >>>[    2.582629] ahci 0000:00:1f.2: flags: 64bit ncq only
> >>>[    2.591294] scsi host0: ahci
> >>>[    2.593071] scsi host1: ahci
> >>>[    2.594746] scsi host2: ahci
> >>>[    2.596433] scsi host3: ahci
> >>>[    2.598107] scsi host4: ahci
> >>>[    2.599711] scsi host5: ahci
> >>>[    2.600666] ata1: SATA max UDMA/133 abar m4096@0xfce1d000 port 0xfc=
e1d100 irq 16
> >>>[    2.601704] ata2: SATA max UDMA/133 abar m4096@0xfce1d000 port 0xfc=
e1d180 irq 16
> >>>[    2.602728] ata3: SATA max UDMA/133 abar m4096@0xfce1d000 port 0xfc=
e1d200 irq 16
> >>>[    2.603965] ata4: SATA max UDMA/133 abar m4096@0xfce1d000 port 0xfc=
e1d280 irq 16
> >>>[    2.604966] ata5: SATA max UDMA/133 abar m4096@0xfce1d000 port 0xfc=
e1d300 irq 16
> >>>[    2.606025] ata6: SATA max UDMA/133 abar m4096@0xfce1d000 port 0xfc=
e1d380 irq 16
> >>>[    2.608967] tun: Universal TUN/TAP device driver, 1.6
> >>>[    2.615031] e1000: Intel(R) PRO/1000 Network Driver
> >>>[    2.615697] e1000: Copyright (c) 1999-2006 Intel Corporation.
> >>>[    2.616600] e1000e: Intel(R) PRO/1000 Network Driver
> >>>[    2.617285] e1000e: Copyright(c) 1999 - 2015 Intel Corporation.
> >>>[    2.618418] PPP generic driver version 2.4.2
> >>>[    2.621200] aoe: AoE v85 initialised.
> >>>[    2.622145] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Dri=
ver
> >>>[    2.623064] ehci-pci: EHCI PCI platform driver
> >>>[    2.623725] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
> >>>[    2.624583] ohci-pci: OHCI PCI platform driver
> >>>[    2.625273] uhci_hcd: USB Universal Host Controller Interface driver
> >>>[    2.626383] usbcore: registered new interface driver usblp
> >>>[    2.627485] usbcore: registered new interface driver usb-storage
> >>>[    2.628515] i8042: PNP: PS/2 Controller [PNP0303:KBD,PNP0f13:MOU] a=
t 0x60,0x64 irq 1,12
> >>>[    2.630612] serio: i8042 KBD port at 0x60,0x64 irq 1
> >>>[    2.632241] serio: i8042 AUX port at 0x60,0x64 irq 12
> >>>[    2.633725] mousedev: PS/2 mouse device common for all mice
> >>>[    2.635967] input: AT Translated Set 2 keyboard as /devices/platfor=
m/i8042/serio0/input/input1
> >>>[    2.641790] input: PC Speaker as /devices/platform/pcspkr/input/inp=
ut4
> >>>[    2.665764] i801_smbus 0000:00:1f.3: SMBus using PCI interrupt
> >>>[    2.667260] i2c i2c-0: 1/1 memory slots populated (from DMI)
> >>>[    2.668024] i2c i2c-0: Memory type 0x07 not supported yet, not inst=
antiating SPD
> >>>[    2.675052] device-mapper: core: CONFIG_IMA_DISABLE_HTABLE is disab=
led. Duplicate IMA measurements will not be recorded in the IMA log.
> >>>[    2.676742] device-mapper: uevent: version 1.0.3
> >>>[    2.678918] device-mapper: ioctl: 4.45.0-ioctl (2021-03-22) initial=
ised: dm-devel@redhat.com
> >>>[    2.683257] device-mapper: multipath round-robin: version 1.2.0 loa=
ded
> >>>[    2.684241] intel_pstate: CPU model not supported
> >>>[    2.688823] usbcore: registered new interface driver usbhid
> >>>[    2.689598] usbhid: USB HID core driver
> >>>[    2.705474] netem: version 1.3
> >>>[    2.706277] NET: Registered PF_INET6 protocol family
> >>>[    2.712188] Segment Routing with IPv6
> >>>[    2.712717] In-situ OAM (IOAM) with IPv6
> >>>[    2.713285] sit: IPv6, IPv4 and MPLS over IPv4 tunneling driver
> >>>[    2.715480] NET: Registered PF_PACKET protocol family
> >>>[    2.716182] NET: Registered PF_KEY protocol family
> >>>[    2.716862] sctp: Hash tables configured (bind 32/56)
> >>>[    2.717728] Key type dns_resolver registered
> >>>[    2.726933] IPI shorthand broadcast: enabled
> >>>[    2.727537] AVX2 version of gcm_enc/dec engaged.
> >>>[    2.728259] AES CTR mode by8 optimization enabled
> >>>[    2.730257] sched_clock: Marking stable (2618472228, 108317297)->(2=
782282047, -55492522)
> >>>[    2.735020] Loading compiled-in X.509 certificates
> >>>[    2.736126] debug_vm_pgtable: [debug_vm_pgtable         ]: Validati=
ng architecture page table helpers
> >>>[    2.738851] Btrfs loaded, crc32c=3Dcrc32c-intel, zoned=3Dno, fsveri=
ty=3Dno
> >>>[    2.739983] ima: No TPM chip found, activating TPM-bypass!
> >>>[    2.746925] ima: Allocated hash algorithm: sha1
> >>>[    2.747568] ima: No architecture policies found
> >>>[    2.760119] cryptomgr_test (960) used greatest stack depth: 29896 b=
ytes left
> >>>[    2.774263] ALSA device list:
> >>>[    2.774801]   #0: Virtual MIDI Card 1
> >>>[    2.927000] ata2: SATA link down (SStatus 0 SControl 300)
> >>>[    2.928006] ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
> >>>[    2.929043] ata1.00: ATAPI: QEMU DVD-ROM, 2.5+, max UDMA/100
> >>>[    2.929850] ata1.00: applying bridge limits
> >>>[    2.930655] ata1.00: configured for UDMA/100
> >>>[    2.943534] ata3: SATA link down (SStatus 0 SControl 300)
> >>>[    2.944410] ata5: SATA link down (SStatus 0 SControl 300)
> >>>[    2.945288] ata4: SATA link down (SStatus 0 SControl 300)
> >>>[    2.947488] scsi 0:0:0:0: CD-ROM            QEMU     QEMU DVD-ROM  =
   2.5+ PQ: 0 ANSI: 5
> >>>[    2.950893] ata6: SATA link down (SStatus 0 SControl 300)
> >>>[    2.983329] sr 0:0:0:0: [sr0] scsi3-mmc drive: 4x/4x cd/rw xa/form2=
 tray
> >>>[    2.984315] cdrom: Uniform CD-ROM driver Revision: 3.20
> >>>[    3.002413] Freeing initrd memory: 28888K
> >>>[    3.003747] kworker/u4:10 (919) used greatest stack depth: 28568 by=
tes left
> >>>[    3.007194] kworker/u4:2 (706) used greatest stack depth: 28384 byt=
es left
> >>>[    3.083826] sr 0:0:0:0: Attached scsi CD-ROM sr0
> >>>[    3.085147] sr 0:0:0:0: Attached scsi generic sg0 type 5
> >>>[    3.103164] Freeing unused kernel image (initmem) memory: 2076K
> >>>[    3.117192] Write protecting the kernel read-only data: 61440k
> >>>[    3.120374] Freeing unused kernel image (text/rodata gap) memory: 2=
028K
> >>>[    3.122810] Freeing unused kernel image (rodata/data gap) memory: 9=
48K
> >>>[    3.126083] Run /init as init process
> >>>[    3.127909]   with arguments:
> >>>[    3.127914]     /init
> >>>[    3.127917]   with environment:
> >>>[    3.127920]     HOME=3D/
> >>>[    3.127923]     TERM=3Dlinux
> >>>[    3.127926]     BOOT_IMAGE=3D(hd0,msdos1)/vmlinuz-5.16.0-00002-g616=
758bf6583
> >>>[    3.127929]     resume=3D/dev/mapper/fedora-swap
> >>>[    3.177129] systemd[1]: systemd v246.13-1.fc33 running in system mo=
de. (+PAM +AUDIT +SELINUX +IMA -APPARMOR +SMACK +SYSVINIT +UTMP +LIBCRYPTSE=
TUP +GCRYPT +GNUTLS +ACL +XZ +LZ4 +ZSTD +SECCOMP +BLKID +ELFUTILS +KMOD +ID=
N2 -IDN +PCRE2 default-hierarchy=3Dunified)
> >>>[    3.191635] systemd[1]: Detected virtualization kvm.
> >>>[    3.192554] systemd[1]: Detected architecture x86-64.
> >>>[    3.193497] systemd[1]: Running in initial RAM disk.
> >>>[    3.200495] systemd[1]: Set hostname to <test3.fieldses.org>.
> >>>[    3.206888] tsc: Refined TSC clocksource calibration: 3591.601 MHz
> >>>[    3.207931] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: =
0x33c55573deb, max_idle_ns: 440795385523 ns
> >>>[    3.209808] clocksource: Switched to clocksource tsc
> >>>[    3.276323] input: ImExPS/2 Generic Explorer Mouse as /devices/plat=
form/i8042/serio1/input/input3
> >>>[    3.410362] dracut-rootfs-g (994) used greatest stack depth: 28168 =
bytes left
> >>>[    3.459425] systemd[1]: /usr/lib/systemd/system/plymouth-start.serv=
ice:15: Unit configured to use KillMode=3Dnone. This is unsafe, as it disab=
les systemd's process lifecycle management for the service. Please update y=
our service to use a safer KillMode=3D, such as 'mixed' or 'control-group'.=
 Support for KillMode=3Dnone is deprecated and will eventually be removed.
> >>>[    3.483169] systemd[1]: Queued start job for default target Initrd =
Default Target.
> >>>[    3.486365] systemd[1]: Created slice system-systemd\x2dhibernate\x=
2dresume.slice.
> >>>[    3.490492] systemd[1]: Reached target Slices.
> >>>[    3.492032] systemd[1]: Reached target Swap.
> >>>[    3.493442] systemd[1]: Reached target Timers.
> >>>[    3.496270] systemd[1]: Listening on Journal Audit Socket.
> >>>[    3.499878] systemd[1]: Listening on Journal Socket (/dev/log).
> >>>[    3.503436] systemd[1]: Listening on Journal Socket.
> >>>[    3.506420] systemd[1]: Listening on udev Control Socket.
> >>>[    3.509264] systemd[1]: Listening on udev Kernel Socket.
> >>>[    3.511877] systemd[1]: Reached target Sockets.
> >>>[    3.513442] systemd[1]: Condition check resulted in Create list of =
static device nodes for the current kernel being skipped.
> >>>[    3.520259] systemd[1]: Started Memstrack Anylazing Service.
> >>>[    3.527783] systemd[1]: Started Hardware RNG Entropy Gatherer Daemo=
n.
> >>>[    3.530307] systemd[1]: systemd-journald.service: unit configures a=
n IP firewall, but the local system does not support BPF/cgroup firewalling.
> >>>[    3.532742] systemd[1]: (This warning is only shown for the first u=
nit using IP firewalling.)
> >>>[    3.540109] systemd[1]: Starting Journal Service...
> >>>[    3.550015] systemd[1]: Starting Load Kernel Modules...
> >>>[    3.559017] systemd[1]: Starting Create Static Device Nodes in /dev=
=2E..
> >>>[    3.565890] random: rngd: uninitialized urandom read (16 bytes read)
> >>>[    3.579371] systemd[1]: Starting Setup Virtual Console...
> >>>[    3.611362] systemd[1]: memstrack.service: Succeeded.
> >>>[    3.627660] systemd[1]: Finished Create Static Device Nodes in /dev.
> >>>[    3.668283] systemd[1]: Finished Load Kernel Modules.
> >>>[    3.683342] systemd[1]: Starting Apply Kernel Variables...
> >>>[    3.793704] systemd[1]: Finished Apply Kernel Variables.
> >>>[    3.852545] audit: type=3D1130 audit(1642005634.495:2): pid=3D1 uid=
=3D0 auid=3D4294967295 ses=3D4294967295 subj=3Dkernel msg=3D'unit=3Dsystemd=
-sysctl comm=3D"systemd" exe=3D"/usr/lib/systemd/systemd" hostname=3D? addr=
=3D? terminal=3D? res=3Dsuccess'
> >>>[    4.017096] systemd[1]: Started Journal Service.
> >>>[    4.019152] audit: type=3D1130 audit(1642005634.663:3): pid=3D1 uid=
=3D0 auid=3D4294967295 ses=3D4294967295 subj=3Dkernel msg=3D'unit=3Dsystemd=
-journald comm=3D"systemd" exe=3D"/usr/lib/systemd/systemd" hostname=3D? ad=
dr=3D? terminal=3D? res=3Dsuccess'
> >>>[    4.367941] audit: type=3D1130 audit(1642005635.011:4): pid=3D1 uid=
=3D0 auid=3D4294967295 ses=3D4294967295 subj=3Dkernel msg=3D'unit=3Dsystemd=
-vconsole-setup comm=3D"systemd" exe=3D"/usr/lib/systemd/systemd" hostname=
=3D? addr=3D? terminal=3D? res=3Dsuccess'
> >>>[    5.158530] audit: type=3D1130 audit(1642005635.799:5): pid=3D1 uid=
=3D0 auid=3D4294967295 ses=3D4294967295 subj=3Dkernel msg=3D'unit=3Ddracut-=
cmdline comm=3D"systemd" exe=3D"/usr/lib/systemd/systemd" hostname=3D? addr=
=3D? terminal=3D? res=3Dsuccess'
> >>>[    5.240723] random: crng init done
> >>>[    5.428343] audit: type=3D1130 audit(1642005636.071:6): pid=3D1 uid=
=3D0 auid=3D4294967295 ses=3D4294967295 subj=3Dkernel msg=3D'unit=3Ddracut-=
pre-udev comm=3D"systemd" exe=3D"/usr/lib/systemd/systemd" hostname=3D? add=
r=3D? terminal=3D? res=3Dsuccess'
> >>>[    5.562117] audit: type=3D1130 audit(1642005636.203:7): pid=3D1 uid=
=3D0 auid=3D4294967295 ses=3D4294967295 subj=3Dkernel msg=3D'unit=3Dsystemd=
-udevd comm=3D"systemd" exe=3D"/usr/lib/systemd/systemd" hostname=3D? addr=
=3D? terminal=3D? res=3Dsuccess'
> >>>[    5.826193] kworker/u4:0 (1195) used greatest stack depth: 27960 by=
tes left
> >>>[    7.667205] virtio_net virtio0 enp1s0: renamed from eth0
> >>>[    8.061253] ata_id (1566) used greatest stack depth: 27648 bytes le=
ft
> >>>[    8.873062] audit: type=3D1130 audit(1642005639.515:8): pid=3D1 uid=
=3D0 auid=3D4294967295 ses=3D4294967295 subj=3Dkernel msg=3D'unit=3Dsystemd=
-udev-trigger comm=3D"systemd" exe=3D"/usr/lib/systemd/systemd" hostname=3D=
? addr=3D? terminal=3D? res=3Dsuccess'
> >>>[    9.126782] audit: type=3D1130 audit(1642005639.767:9): pid=3D1 uid=
=3D0 auid=3D4294967295 ses=3D4294967295 subj=3Dkernel msg=3D'unit=3Dplymout=
h-start comm=3D"systemd" exe=3D"/usr/lib/systemd/systemd" hostname=3D? addr=
=3D? terminal=3D? res=3Dsuccess'
> >>>[    9.898584] lvm (2335) used greatest stack depth: 27600 bytes left
> >>>[   10.171243] lvm (2337) used greatest stack depth: 27504 bytes left
> >>>[   10.389632] audit: type=3D1130 audit(1642005641.031:10): pid=3D1 ui=
d=3D0 auid=3D4294967295 ses=3D4294967295 subj=3Dkernel msg=3D'unit=3Dsystem=
d-hibernate-resume@dev-mapper-fedora\x2dswap comm=3D"systemd" exe=3D"/usr/l=
ib/systemd/systemd" hostname=3D? addr=3D? terminal=3D? res=3Dfailed'
> >>>[   10.456068] audit: type=3D1130 audit(1642005641.099:11): pid=3D1 ui=
d=3D0 auid=3D4294967295 ses=3D4294967295 subj=3Dkernel msg=3D'unit=3Dsystem=
d-tmpfiles-setup comm=3D"systemd" exe=3D"/usr/lib/systemd/systemd" hostname=
=3D? addr=3D? terminal=3D? res=3Dsuccess'
> >>>[   10.477828] dracut-initqueu (2286) used greatest stack depth: 27416=
 bytes left
> >>>[   10.481902] audit: type=3D1130 audit(1642005641.123:12): pid=3D1 ui=
d=3D0 auid=3D4294967295 ses=3D4294967295 subj=3Dkernel msg=3D'unit=3Ddracut=
-initqueue comm=3D"systemd" exe=3D"/usr/lib/systemd/systemd" hostname=3D? a=
ddr=3D? terminal=3D? res=3Dsuccess'
> >>>[   10.545851] fsck (2364) used greatest stack depth: 26560 bytes left
> >>>[   10.555806] audit: type=3D1130 audit(1642005641.195:13): pid=3D1 ui=
d=3D0 auid=3D4294967295 ses=3D4294967295 subj=3Dkernel msg=3D'unit=3Dsystem=
d-fsck-root comm=3D"systemd" exe=3D"/usr/lib/systemd/systemd" hostname=3D? =
addr=3D? terminal=3D? res=3Dsuccess'
> >>>[   10.584297] XFS (dm-0): Mounting V5 Filesystem
> >>>[   10.767936] XFS (dm-0): Ending clean mount
> >>>[   10.840832] mount (2366) used greatest stack depth: 25344 bytes left
> >>>[   10.996402] systemd-fstab-g (2379) used greatest stack depth: 24872=
 bytes left
> >>>[   11.699148] audit: type=3D1130 audit(1642005642.339:14): pid=3D1 ui=
d=3D0 auid=3D4294967295 ses=3D4294967295 subj=3Dkernel msg=3D'unit=3Dinitrd=
-parse-etc comm=3D"systemd" exe=3D"/usr/lib/systemd/systemd" hostname=3D? a=
ddr=3D? terminal=3D? res=3Dsuccess'
> >>>[   11.702004] audit: type=3D1131 audit(1642005642.339:15): pid=3D1 ui=
d=3D0 auid=3D4294967295 ses=3D4294967295 subj=3Dkernel msg=3D'unit=3Dinitrd=
-parse-etc comm=3D"systemd" exe=3D"/usr/lib/systemd/systemd" hostname=3D? a=
ddr=3D? terminal=3D? res=3Dsuccess'
> >>>[   11.858512] audit: type=3D1130 audit(1642005642.499:16): pid=3D1 ui=
d=3D0 auid=3D4294967295 ses=3D4294967295 subj=3Dkernel msg=3D'unit=3Ddracut=
-pre-pivot comm=3D"systemd" exe=3D"/usr/lib/systemd/systemd" hostname=3D? a=
ddr=3D? terminal=3D? res=3Dsuccess'
> >>>[   11.895749] audit: type=3D1131 audit(1642005642.535:17): pid=3D1 ui=
d=3D0 auid=3D4294967295 ses=3D4294967295 subj=3Dkernel msg=3D'unit=3Ddracut=
-pre-pivot comm=3D"systemd" exe=3D"/usr/lib/systemd/systemd" hostname=3D? a=
ddr=3D? terminal=3D? res=3Dsuccess'
> >>>[   14.895253] SELinux:  Permission watch in class filesystem not defi=
ned in policy.
> >>>[   14.896380] SELinux:  Permission watch in class file not defined in=
 policy.
> >>>[   14.898184] SELinux:  Permission watch_mount in class file not defi=
ned in policy.
> >>>[   14.899597] SELinux:  Permission watch_sb in class file not defined=
 in policy.
> >>>[   14.900888] SELinux:  Permission watch_with_perm in class file not =
defined in policy.
> >>>[   14.902011] SELinux:  Permission watch_reads in class file not defi=
ned in policy.
> >>>[   14.903080] SELinux:  Permission watch in class dir not defined in =
policy.
> >>>[   14.915479] SELinux:  Permission watch_mount in class dir not defin=
ed in policy.
> >>>[   14.916793] SELinux:  Permission watch_sb in class dir not defined =
in policy.
> >>>[   14.918117] SELinux:  Permission watch_with_perm in class dir not d=
efined in policy.
> >>>[   14.919521] SELinux:  Permission watch_reads in class dir not defin=
ed in policy.
> >>>[   14.920832] SELinux:  Permission watch in class lnk_file not define=
d in policy.
> >>>[   14.922158] SELinux:  Permission watch_mount in class lnk_file not =
defined in policy.
> >>>[   14.923410] SELinux:  Permission watch_sb in class lnk_file not def=
ined in policy.
> >>>[   14.924406] SELinux:  Permission watch_with_perm in class lnk_file =
not defined in policy.
> >>>[   14.925567] SELinux:  Permission watch_reads in class lnk_file not =
defined in policy.
> >>>[   14.927302] SELinux:  Permission watch in class chr_file not define=
d in policy.
> >>>[   14.928363] SELinux:  Permission watch_mount in class chr_file not =
defined in policy.
> >>>[   14.929448] SELinux:  Permission watch_sb in class chr_file not def=
ined in policy.
> >>>[   14.930486] SELinux:  Permission watch_with_perm in class chr_file =
not defined in policy.
> >>>[   14.931631] SELinux:  Permission watch_reads in class chr_file not =
defined in policy.
> >>>[   14.932702] SELinux:  Permission watch in class blk_file not define=
d in policy.
> >>>[   14.933695] SELinux:  Permission watch_mount in class blk_file not =
defined in policy.
> >>>[   14.934779] SELinux:  Permission watch_sb in class blk_file not def=
ined in policy.
> >>>[   14.935782] SELinux:  Permission watch_with_perm in class blk_file =
not defined in policy.
> >>>[   14.936834] SELinux:  Permission watch_reads in class blk_file not =
defined in policy.
> >>>[   14.937933] SELinux:  Permission watch in class sock_file not defin=
ed in policy.
> >>>[   14.938979] SELinux:  Permission watch_mount in class sock_file not=
 defined in policy.
> >>>[   14.940022] SELinux:  Permission watch_sb in class sock_file not de=
fined in policy.
> >>>[   14.941043] SELinux:  Permission watch_with_perm in class sock_file=
 not defined in policy.
> >>>[   14.942178] SELinux:  Permission watch_reads in class sock_file not=
 defined in policy.
> >>>[   14.943287] SELinux:  Permission watch in class fifo_file not defin=
ed in policy.
> >>>[   14.944263] SELinux:  Permission watch_mount in class fifo_file not=
 defined in policy.
> >>>[   14.945325] SELinux:  Permission watch_sb in class fifo_file not de=
fined in policy.
> >>>[   14.946386] SELinux:  Permission watch_with_perm in class fifo_file=
 not defined in policy.
> >>>[   14.947525] SELinux:  Permission watch_reads in class fifo_file not=
 defined in policy.
> >>>[   14.948611] SELinux:  Permission perfmon in class capability2 not d=
efined in policy.
> >>>[   14.949662] SELinux:  Permission bpf in class capability2 not defin=
ed in policy.
> >>>[   14.950682] SELinux:  Permission checkpoint_restore in class capabi=
lity2 not defined in policy.
> >>>[   14.951921] SELinux:  Permission perfmon in class cap2_userns not d=
efined in policy.
> >>>[   14.952939] SELinux:  Permission bpf in class cap2_userns not defin=
ed in policy.
> >>>[   14.953970] SELinux:  Permission checkpoint_restore in class cap2_u=
serns not defined in policy.
> >>>[   14.955277] SELinux:  Class mctp_socket not defined in policy.
> >>>[   14.956110] SELinux:  Class perf_event not defined in policy.
> >>>[   14.957746] SELinux:  Class anon_inode not defined in policy.
> >>>[   14.958536] SELinux:  Class io_uring not defined in policy.
> >>>[   14.959313] SELinux: the above unknown classes and permissions will=
 be allowed
> >>>[   15.013559] SELinux:  policy capability network_peer_controls=3D1
> >>>[   15.014417] SELinux:  policy capability open_perms=3D1
> >>>[   15.015183] SELinux:  policy capability extended_socket_class=3D1
> >>>[   15.015968] SELinux:  policy capability always_check_network=3D0
> >>>[   15.017534] SELinux:  policy capability cgroup_seclabel=3D1
> >>>[   15.018305] SELinux:  policy capability nnp_nosuid_transition=3D1
> >>>[   15.019126] SELinux:  policy capability genfs_seclabel_symlinks=3D0
> >>>[   15.244501] kauditd_printk_skb: 16 callbacks suppressed
> >>>[   15.244506] audit: type=3D1403 audit(1642005645.887:34): auid=3D429=
4967295 ses=3D4294967295 lsm=3Dselinux res=3D1
> >>>[   15.255513] systemd[1]: Successfully loaded SELinux policy in 2.766=
323s.
> >>>[   15.619234] systemd[1]: Relabelled /dev, /dev/shm, /run, /sys/fs/cg=
roup in 261.945ms.
> >>>[   15.628383] systemd[1]: systemd v246.13-1.fc33 running in system mo=
de. (+PAM +AUDIT +SELINUX +IMA -APPARMOR +SMACK +SYSVINIT +UTMP +LIBCRYPTSE=
TUP +GCRYPT +GNUTLS +ACL +XZ +LZ4 +ZSTD +SECCOMP +BLKID +ELFUTILS +KMOD +ID=
N2 -IDN +PCRE2 default-hierarchy=3Dunified)
> >>>[   15.632666] systemd[1]: Detected virtualization kvm.
> >>>[   15.633353] systemd[1]: Detected architecture x86-64.
> >>>[   15.639738] systemd[1]: Set hostname to <test3.fieldses.org>.
> >>>[   15.905148] lvmconfig (2442) used greatest stack depth: 24544 bytes=
 left
> >>>[   15.941811] kdump-dep-gener (2432) used greatest stack depth: 24464=
 bytes left
> >>>[   15.942995] grep (2450) used greatest stack depth: 24448 bytes left
> >>>[   16.222623] systemd[1]: /usr/lib/systemd/system/plymouth-start.serv=
ice:15: Unit configured to use KillMode=3Dnone. This is unsafe, as it disab=
les systemd's process lifecycle management for the service. Please update y=
our service to use a safer KillMode=3D, such as 'mixed' or 'control-group'.=
 Support for KillMode=3Dnone is deprecated and will eventually be removed.
> >>>[   16.548178] systemd[1]: /usr/lib/systemd/system/mcelog.service:8: S=
tandard output type syslog is obsolete, automatically updating to journal. =
Please update your unit file, and consider removing the setting altogether.
> >>>[   17.024523] audit: type=3D1131 audit(1642005647.667:35): pid=3D1 ui=
d=3D0 auid=3D4294967295 ses=3D4294967295 subj=3Dsystem_u:system_r:init_t:s0=
 msg=3D'unit=3Dsystemd-journald comm=3D"systemd" exe=3D"/usr/lib/systemd/sy=
stemd" hostname=3D? addr=3D? terminal=3D? res=3Dsuccess'
> >>>[   17.032331] systemd[1]: initrd-switch-root.service: Succeeded.
> >>>[   17.034511] systemd[1]: Stopped Switch Root.
> >>>[   17.037797] audit: type=3D1130 audit(1642005647.679:36): pid=3D1 ui=
d=3D0 auid=3D4294967295 ses=3D4294967295 subj=3Dsystem_u:system_r:init_t:s0=
 msg=3D'unit=3Dinitrd-switch-root comm=3D"systemd" exe=3D"/usr/lib/systemd/=
systemd" hostname=3D? addr=3D? terminal=3D? res=3Dsuccess'
> >>>[   17.039820] systemd[1]: systemd-journald.service: Scheduled restart=
 job, restart counter is at 1.
> >>>[   17.040822] audit: type=3D1131 audit(1642005647.679:37): pid=3D1 ui=
d=3D0 auid=3D4294967295 ses=3D4294967295 subj=3Dsystem_u:system_r:init_t:s0=
 msg=3D'unit=3Dinitrd-switch-root comm=3D"systemd" exe=3D"/usr/lib/systemd/=
systemd" hostname=3D? addr=3D? terminal=3D? res=3Dsuccess'
> >>>[   17.044319] systemd[1]: Created slice system-getty.slice.
> >>>[   17.048401] systemd[1]: Created slice system-modprobe.slice.
> >>>[   17.052765] systemd[1]: Created slice system-serial\x2dgetty.slice.
> >>>[   17.055258] systemd[1]: Created slice system-sshd\x2dkeygen.slice.
> >>>[   17.058406] systemd[1]: Created slice User and Session Slice.
> >>>[   17.060191] systemd[1]: Condition check resulted in Dispatch Passwo=
rd Requests to Console Directory Watch being skipped.
> >>>[   17.063067] systemd[1]: Started Forward Password Requests to Wall D=
irectory Watch.
> >>>[   17.066845] systemd[1]: Set up automount Arbitrary Executable File =
Formats File System Automount Point.
> >>>[   17.068244] systemd[1]: Reached target Local Encrypted Volumes.
> >>>[   17.070271] systemd[1]: Stopped target Switch Root.
> >>>[   17.071236] systemd[1]: Stopped target Initrd File Systems.
> >>>[   17.072219] systemd[1]: Stopped target Initrd Root File System.
> >>>[   17.075495] systemd[1]: Reached target Paths.
> >>>[   17.076283] systemd[1]: Reached target Slices.
> >>>[   17.080904] systemd[1]: Listening on Device-mapper event daemon FIF=
Os.
> >>>[   17.084889] systemd[1]: Listening on LVM2 poll daemon socket.
> >>>[   17.087729] systemd[1]: Listening on multipathd control socket.
> >>>[   17.093018] systemd[1]: Listening on Process Core Dump Socket.
> >>>[   17.095415] systemd[1]: Listening on initctl Compatibility Named Pi=
pe.
> >>>[   17.099466] systemd[1]: Listening on udev Control Socket.
> >>>[   17.102467] systemd[1]: Listening on udev Kernel Socket.
> >>>[   17.109715] systemd[1]: Activating swap /dev/mapper/fedora-swap...
> >>>[   17.117743] systemd[1]: Mounting Huge Pages File System...
> >>>[   17.125890] systemd[1]: Mounting POSIX Message Queue File System...
> >>>[   17.130492] Adding 2097148k swap on /dev/mapper/fedora-swap.  Prior=
ity:-2 extents:1 across:2097148k
> >>>[   17.140236] systemd[1]: Mounting Kernel Debug File System...
> >>>[   17.149754] systemd[1]: Starting Kernel Module supporting RPCSEC_GS=
S...
> >>>[   17.151753] systemd[1]: Condition check resulted in Create list of =
static device nodes for the current kernel being skipped.
> >>>[   17.159082] systemd[1]: Starting Monitoring of LVM2 mirrors, snapsh=
ots etc. using dmeventd or progress polling...
> >>>[   17.166647] systemd[1]: Starting Load Kernel Module configfs...
> >>>[   17.173097] systemd[1]: Starting Load Kernel Module drm...
> >>>[   17.181757] systemd[1]: Starting Load Kernel Module fuse...
> >>>[   17.199195] systemd[1]: Starting Preprocess NFS configuration conve=
rtion...
> >>>[   17.203114] systemd[1]: plymouth-switch-root.service: Succeeded.
> >>>[   17.217307] systemd[1]: Stopped Plymouth switch root service.
> >>>[   17.220790] audit: type=3D1131 audit(1642005647.863:38): pid=3D1 ui=
d=3D0 auid=3D4294967295 ses=3D4294967295 subj=3Dsystem_u:system_r:init_t:s0=
 msg=3D'unit=3Dplymouth-switch-root comm=3D"systemd" exe=3D"/usr/lib/system=
d/systemd" hostname=3D? addr=3D? terminal=3D? res=3Dsuccess'
> >>>[   17.222477] systemd[1]: Condition check resulted in Set Up Addition=
al Binary Formats being skipped.
> >>>[   17.235950] systemd[1]: systemd-fsck-root.service: Succeeded.
> >>>[   17.239114] systemd[1]: Stopped File System Check on Root Device.
> >>>[   17.241914] systemd[1]: Stopped Journal Service.
> >>>[   17.246822] audit: type=3D1131 audit(1642005647.883:39): pid=3D1 ui=
d=3D0 auid=3D4294967295 ses=3D4294967295 subj=3Dsystem_u:system_r:init_t:s0=
 msg=3D'unit=3Dsystemd-fsck-root comm=3D"systemd" exe=3D"/usr/lib/systemd/s=
ystemd" hostname=3D? addr=3D? terminal=3D? res=3Dsuccess'
> >>>[   17.248647] systemd[1]: Starting Journal Service...
> >>>[   17.250212] audit: type=3D1130 audit(1642005647.883:40): pid=3D1 ui=
d=3D0 auid=3D4294967295 ses=3D4294967295 subj=3Dsystem_u:system_r:init_t:s0=
 msg=3D'unit=3Dsystemd-journald comm=3D"systemd" exe=3D"/usr/lib/systemd/sy=
stemd" hostname=3D? addr=3D? terminal=3D? res=3Dsuccess'
> >>>[   17.263202] audit: type=3D1131 audit(1642005647.887:41): pid=3D1 ui=
d=3D0 auid=3D4294967295 ses=3D4294967295 subj=3Dsystem_u:system_r:init_t:s0=
 msg=3D'unit=3Dsystemd-journald comm=3D"systemd" exe=3D"/usr/lib/systemd/sy=
stemd" hostname=3D? addr=3D? terminal=3D? res=3Dsuccess'
> >>>[   17.276489] systemd[1]: Starting Load Kernel Modules...
> >>>[   17.295377] systemd[1]: Starting Remount Root and Kernel File Syste=
ms...
> >>>[   17.297774] systemd[1]: Condition check resulted in Repartition Roo=
t Disk being skipped.
> >>>[   17.324773] systemd[1]: Starting Coldplug All udev Devices...
> >>>[   17.328304] systemd[1]: sysroot.mount: Succeeded.
> >>>[   17.374101] systemd[1]: Activated swap /dev/mapper/fedora-swap.
> >>>[   17.401071] systemd[1]: Mounted Huge Pages File System.
> >>>[   17.410741] xfs filesystem being remounted at / supports timestamps=
 until 2038 (0x7fffffff)
> >>>[   17.425620] systemd[1]: Mounted POSIX Message Queue File System.
> >>>[   17.440432] systemd[1]: Mounted Kernel Debug File System.
> >>>[   17.447566] RPC: Registered named UNIX socket transport module.
> >>>[   17.448425] RPC: Registered udp transport module.
> >>>[   17.449052] RPC: Registered tcp transport module.
> >>>[   17.449719] RPC: Registered tcp NFSv4.1 backchannel transport modul=
e.
> >>>[   17.457211] systemd[1]: modprobe@configfs.service: Succeeded.
> >>>[   17.459723] systemd[1]: Finished Load Kernel Module configfs.
> >>>[   17.461450] audit: type=3D1130 audit(1642005648.103:42): pid=3D1 ui=
d=3D0 auid=3D4294967295 ses=3D4294967295 subj=3Dsystem_u:system_r:init_t:s0=
 msg=3D'unit=3Dmodprobe@configfs comm=3D"systemd" exe=3D"/usr/lib/systemd/s=
ystemd" hostname=3D? addr=3D? terminal=3D? res=3Dsuccess'
> >>>[   17.464558] audit: type=3D1131 audit(1642005648.103:43): pid=3D1 ui=
d=3D0 auid=3D4294967295 ses=3D4294967295 subj=3Dsystem_u:system_r:init_t:s0=
 msg=3D'unit=3Dmodprobe@configfs comm=3D"systemd" exe=3D"/usr/lib/systemd/s=
ystemd" hostname=3D? addr=3D? terminal=3D? res=3Dsuccess'
> >>>[   17.476290] systemd[1]: modprobe@drm.service: Succeeded.
> >>>[   17.491863] systemd[1]: Finished Load Kernel Module drm.
> >>>[   17.496010] systemd[1]: Finished Kernel Module supporting RPCSEC_GS=
S.
> >>>[   17.501497] systemd[1]: modprobe@fuse.service: Succeeded.
> >>>[   17.504499] systemd[1]: Finished Load Kernel Module fuse.
> >>>[   17.517872] systemd[1]: Started Journal Service.
> >>>[   20.438290] kauditd_printk_skb: 22 callbacks suppressed
> >>>[   20.438294] audit: type=3D1130 audit(1642005651.079:64): pid=3D1 ui=
d=3D0 auid=3D4294967295 ses=3D4294967295 subj=3Dsystem_u:system_r:init_t:s0=
 msg=3D'unit=3Dsystemd-journal-flush comm=3D"systemd" exe=3D"/usr/lib/syste=
md/systemd" hostname=3D? addr=3D? terminal=3D? res=3Dsuccess'
> >>>[   20.725931] audit: type=3D1130 audit(1642005651.367:65): pid=3D1 ui=
d=3D0 auid=3D4294967295 ses=3D4294967295 subj=3Dsystem_u:system_r:init_t:s0=
 msg=3D'unit=3Dlvm2-pvscan@253:2 comm=3D"systemd" exe=3D"/usr/lib/systemd/s=
ystemd" hostname=3D? addr=3D? terminal=3D? res=3Dsuccess'
> >>>[   20.998904] audit: type=3D1130 audit(1642005651.639:66): pid=3D1 ui=
d=3D0 auid=3D4294967295 ses=3D4294967295 subj=3Dsystem_u:system_r:init_t:s0=
 msg=3D'unit=3Dlvm2-monitor comm=3D"systemd" exe=3D"/usr/lib/systemd/system=
d" hostname=3D? addr=3D? terminal=3D? res=3Dsuccess'
> >>>[   22.158644] audit: type=3D1130 audit(1642005652.799:67): pid=3D1 ui=
d=3D0 auid=3D4294967295 ses=3D4294967295 subj=3Dsystem_u:system_r:init_t:s0=
 msg=3D'unit=3Dsystemd-udev-settle comm=3D"systemd" exe=3D"/usr/lib/systemd=
/systemd" hostname=3D? addr=3D? terminal=3D? res=3Dsuccess'
> >>>[   22.183237] XFS (vda1): Mounting V5 Filesystem
> >>>[   22.329168] XFS (vda1): Ending clean mount
> >>>[   22.344447] xfs filesystem being mounted at /boot supports timestam=
ps until 2038 (0x7fffffff)
> >>>[   22.381960] audit: type=3D1130 audit(1642005653.023:68): pid=3D1 ui=
d=3D0 auid=3D4294967295 ses=3D4294967295 subj=3Dsystem_u:system_r:init_t:s0=
 msg=3D'unit=3Ddracut-shutdown comm=3D"systemd" exe=3D"/usr/lib/systemd/sys=
temd" hostname=3D? addr=3D? terminal=3D? res=3Dsuccess'
> >>>[   22.430820] audit: type=3D1130 audit(1642005653.071:69): pid=3D1 ui=
d=3D0 auid=3D4294967295 ses=3D4294967295 subj=3Dsystem_u:system_r:init_t:s0=
 msg=3D'unit=3Dplymouth-read-write comm=3D"systemd" exe=3D"/usr/lib/systemd=
/systemd" hostname=3D? addr=3D? terminal=3D? res=3Dsuccess'
> >>>[   22.485659] audit: type=3D1130 audit(1642005653.127:70): pid=3D1 ui=
d=3D0 auid=3D4294967295 ses=3D4294967295 subj=3Dsystem_u:system_r:init_t:s0=
 msg=3D'unit=3Dimport-state comm=3D"systemd" exe=3D"/usr/lib/systemd/system=
d" hostname=3D? addr=3D? terminal=3D? res=3Dsuccess'
> >>>[   22.749894] audit: type=3D1130 audit(1642005653.391:71): pid=3D1 ui=
d=3D0 auid=3D4294967295 ses=3D4294967295 subj=3Dsystem_u:system_r:init_t:s0=
 msg=3D'unit=3Dsystemd-tmpfiles-setup comm=3D"systemd" exe=3D"/usr/lib/syst=
emd/systemd" hostname=3D? addr=3D? terminal=3D? res=3Dsuccess'
> >>>[   22.857336] audit: type=3D1400 audit(1642005653.499:72): avc:  deni=
ed  { fowner } for  pid=3D3657 comm=3D"auditd" capability=3D3  scontext=3Ds=
ystem_u:system_r:auditd_t:s0 tcontext=3Dsystem_u:system_r:auditd_t:s0 tclas=
s=3Dcapability permissive=3D0
> >>>[   22.861281] audit: type=3D1300 audit(1642005653.499:72): arch=3Dc00=
0003e syscall=3D90 success=3Dyes exit=3D0 a0=3D56090a1699e0 a1=3D1c0 a2=3D1=
9 a3=3D56090a169c40 items=3D0 ppid=3D3655 pid=3D3657 auid=3D4294967295 uid=
=3D0 gid=3D0 euid=3D0 suid=3D0 fsuid=3D0 egid=3D0 sgid=3D0 fsgid=3D0 tty=3D=
(none) ses=3D4294967295 comm=3D"auditd" exe=3D"/usr/sbin/auditd" subj=3Dsys=
tem_u:system_r:auditd_t:s0 key=3D(null)
> >>>[  121.479732] rpm (3866) used greatest stack depth: 23336 bytes left
> >>>[  160.313750] FS-Cache: Netfs 'nfs' registered for caching
> >>>[  267.826493] NFS: Registering the id_resolver key type
> >>>[  267.827159] Key type id_resolver registered
> >>>[  267.827643] Key type id_legacy registered
> >>>[  268.393694] mount.nfs (5859) used greatest stack depth: 22896 bytes=
 left
> >>>[  523.352374] clocksource: timekeeping watchdog on CPU0: acpi_pm retr=
ied 2 times before success
> >>>[  938.809224] kworker/dying (2523) used greatest stack depth: 21832 b=
ytes left
> >>>[ 1827.841420] run fstests generic/001 at 2022-01-12 12:10:59
> >>>[ 1867.998292] run fstests generic/002 at 2022-01-12 12:11:39
> >>>[ 1869.297577] run fstests generic/003 at 2022-01-12 12:11:40
> >>>[ 1869.823503] run fstests generic/004 at 2022-01-12 12:11:40
> >>>[ 1870.357158] run fstests generic/005 at 2022-01-12 12:11:41
> >>>[ 1872.033166] run fstests generic/008 at 2022-01-12 12:11:43
> >>>[ 1872.682257] run fstests generic/009 at 2022-01-12 12:11:43
> >>>[ 1873.300870] run fstests generic/010 at 2022-01-12 12:11:44
> >>>[ 1873.867023] run fstests generic/011 at 2022-01-12 12:11:45
> >>>[ 1939.414212] run fstests generic/012 at 2022-01-12 12:12:50
> >>>[ 1940.257756] run fstests generic/013 at 2022-01-12 12:12:51
> >>>[ 2006.667055] run fstests generic/015 at 2022-01-12 12:13:57
> >>>[ 2007.186484] run fstests generic/016 at 2022-01-12 12:13:58
> >>>[ 2008.063569] run fstests generic/018 at 2022-01-12 12:13:59
> >>>[ 2008.831790] run fstests generic/020 at 2022-01-12 12:14:00
> >>>[ 2020.997738] run fstests generic/021 at 2022-01-12 12:14:12
> >>>[ 2021.774590] run fstests generic/022 at 2022-01-12 12:14:12
> >>>[ 2022.542934] run fstests generic/023 at 2022-01-12 12:14:13
> >>>[ 2025.824308] run fstests generic/024 at 2022-01-12 12:14:16
> >>>[ 2026.390736] run fstests generic/025 at 2022-01-12 12:14:17
> >>>[ 2026.963217] run fstests generic/026 at 2022-01-12 12:14:18
> >>>[ 2027.592530] run fstests generic/027 at 2022-01-12 12:14:18
> >>>[ 2028.101801] run fstests generic/028 at 2022-01-12 12:14:19
> >>>[ 2033.709852] run fstests generic/029 at 2022-01-12 12:14:24
> >>>[ 2035.495458] run fstests generic/030 at 2022-01-12 12:14:26
> >>>[ 2038.537954] run fstests generic/034 at 2022-01-12 12:14:29
> >>>[ 2039.329741] run fstests generic/036 at 2022-01-12 12:14:30
> >>>[ 2050.072609] run fstests generic/037 at 2022-01-12 12:14:41
> >>>[ 2071.336677] run fstests generic/038 at 2022-01-12 12:15:02
> >>>[ 2072.411721] run fstests generic/039 at 2022-01-12 12:15:03
> >>>[ 2073.123576] run fstests generic/040 at 2022-01-12 12:15:04
> >>>[ 2073.748265] run fstests generic/041 at 2022-01-12 12:15:04
> >>>[ 2074.344951] run fstests generic/043 at 2022-01-12 12:15:05
> >>>[ 2075.114885] run fstests generic/044 at 2022-01-12 12:15:06
> >>>[ 2075.977059] run fstests generic/045 at 2022-01-12 12:15:07
> >>>[ 2076.855028] run fstests generic/046 at 2022-01-12 12:15:08
> >>>[ 2077.696747] run fstests generic/047 at 2022-01-12 12:15:08
> >>>[ 2078.533668] run fstests generic/048 at 2022-01-12 12:15:09
> >>>[ 2079.397374] run fstests generic/049 at 2022-01-12 12:15:10
> >>>[ 2080.261339] run fstests generic/050 at 2022-01-12 12:15:11
> >>>[ 2081.107141] run fstests generic/051 at 2022-01-12 12:15:12
> >>>[ 2082.008096] run fstests generic/052 at 2022-01-12 12:15:13
> >>>[ 2082.858320] run fstests generic/054 at 2022-01-12 12:15:14
> >>>[ 2083.731997] run fstests generic/055 at 2022-01-12 12:15:14
> >>>[ 2084.590242] run fstests generic/056 at 2022-01-12 12:15:15
> >>>[ 2085.303754] run fstests generic/057 at 2022-01-12 12:15:16
> >>>[ 2085.908458] run fstests generic/058 at 2022-01-12 12:15:17
> >>>[ 2086.640354] run fstests generic/059 at 2022-01-12 12:15:17
> >>>[ 2087.217469] run fstests generic/060 at 2022-01-12 12:15:18
> >>>[ 2087.944489] run fstests generic/061 at 2022-01-12 12:15:19
> >>>[ 2088.749344] run fstests generic/063 at 2022-01-12 12:15:19
> >>>[ 2089.524340] run fstests generic/065 at 2022-01-12 12:15:20
> >>>[ 2090.121276] run fstests generic/066 at 2022-01-12 12:15:21
> >>>[ 2090.702873] run fstests generic/067 at 2022-01-12 12:15:21
> >>>[ 2091.333532] run fstests generic/069 at 2022-01-12 12:15:22
> >>>[ 2121.140927] run fstests generic/070 at 2022-01-12 12:15:52
> >>>[ 2168.861297] run fstests generic/072 at 2022-01-12 12:16:40
> >>>[ 2169.690898] run fstests generic/073 at 2022-01-12 12:16:40
> >>>[ 2170.302749] run fstests generic/075 at 2022-01-12 12:16:41
> >>>[ 2226.187399] run fstests generic/076 at 2022-01-12 12:17:37
> >>>[ 2226.692121] run fstests generic/077 at 2022-01-12 12:17:37
> >>>[ 2230.646484] run fstests generic/078 at 2022-01-12 12:17:41
> >>>[ 2231.233467] run fstests generic/079 at 2022-01-12 12:17:42
> >>>[ 2231.792759] run fstests generic/080 at 2022-01-12 12:17:42
> >>>[ 2234.478551] run fstests generic/081 at 2022-01-12 12:17:45
> >>>[ 2235.016264] run fstests generic/082 at 2022-01-12 12:17:46
> >>>[ 2235.544754] run fstests generic/083 at 2022-01-12 12:17:46
> >>>[ 2236.070354] run fstests generic/084 at 2022-01-12 12:17:47
> >>>[ 2242.089643] run fstests generic/085 at 2022-01-12 12:17:53
> >>>[ 2242.829424] run fstests generic/086 at 2022-01-12 12:17:54
> >>>[ 2244.627985] 086 (63919): drop_caches: 3
> >>>[ 2245.004053] run fstests generic/090 at 2022-01-12 12:17:56
> >>>[ 2245.726297] run fstests generic/092 at 2022-01-12 12:17:56
> >>>[ 2246.386331] run fstests generic/093 at 2022-01-12 12:17:57
> >>>[ 2246.989287] run fstests generic/095 at 2022-01-12 12:17:58
> >>>[ 2247.568818] run fstests generic/096 at 2022-01-12 12:17:58
> >>>[ 2248.194588] run fstests generic/097 at 2022-01-12 12:17:59
> >>>[ 2248.808142] run fstests generic/098 at 2022-01-12 12:17:59
> >>>[ 2250.531860] run fstests generic/099 at 2022-01-12 12:18:01
> >>>[ 2251.371697] run fstests generic/101 at 2022-01-12 12:18:02
> >>>[ 2251.916640] run fstests generic/102 at 2022-01-12 12:18:03
> >>>[ 2252.419409] run fstests generic/103 at 2022-01-12 12:18:03
> >>>[ 2255.825340] run fstests generic/104 at 2022-01-12 12:18:06
> >>>[ 2256.640587] run fstests generic/106 at 2022-01-12 12:18:07
> >>>[ 2257.275429] run fstests generic/107 at 2022-01-12 12:18:08
> >>>[ 2257.871596] run fstests generic/108 at 2022-01-12 12:18:09
> >>>[ 2258.649789] run fstests generic/109 at 2022-01-12 12:18:09
> >>>[ 2314.619077] run fstests generic/110 at 2022-01-12 12:19:05
> >>>[ 2315.511518] run fstests generic/111 at 2022-01-12 12:19:06
> >>>[ 2316.200429] run fstests generic/112 at 2022-01-12 12:19:07
> >>>[ 2375.093348] run fstests generic/114 at 2022-01-12 12:20:06
> >>>[ 2375.726022] run fstests generic/115 at 2022-01-12 12:20:06
> >>>[ 2376.417534] run fstests generic/116 at 2022-01-12 12:20:07
> >>>[ 2378.207570] run fstests generic/118 at 2022-01-12 12:20:09
> >>>[ 2379.767855] run fstests generic/119 at 2022-01-12 12:20:10
> >>>[ 2382.596453] run fstests generic/120 at 2022-01-12 12:20:13
> >>>[ 2383.118291] run fstests generic/121 at 2022-01-12 12:20:14
> >>>[ 2383.763385] run fstests generic/122 at 2022-01-12 12:20:14
> >>>[ 2384.417857] run fstests generic/123 at 2022-01-12 12:20:15
> >>>[ 2384.952387] run fstests generic/124 at 2022-01-12 12:20:16
> >>>[ 2439.979901] run fstests generic/128 at 2022-01-12 12:21:11
> >>>[ 2440.534640] run fstests generic/130 at 2022-01-12 12:21:11
> >>>[ 2458.532247] run fstests generic/131 at 2022-01-12 12:21:29
> >>>[ 2460.624455] run fstests generic/132 at 2022-01-12 12:21:31
> >>>[ 2479.380043] run fstests generic/134 at 2022-01-12 12:21:50
> >>>[ 2481.259289] run fstests generic/135 at 2022-01-12 12:21:52
> >>>[ 2482.602837] run fstests generic/136 at 2022-01-12 12:21:53
> >>>[ 2483.422863] run fstests generic/137 at 2022-01-12 12:21:54
> >>>[ 2484.225794] run fstests generic/138 at 2022-01-12 12:21:55
> >>>[ 2486.911951] run fstests generic/139 at 2022-01-12 12:21:58
> >>>[ 2490.247175] run fstests generic/140 at 2022-01-12 12:22:01
> >>>[ 2492.960214] run fstests generic/141 at 2022-01-12 12:22:04
> >>>[ 2493.949160] run fstests generic/142 at 2022-01-12 12:22:05
> >>>[ 2502.811792] run fstests generic/143 at 2022-01-12 12:22:13
> >>>[ 2744.562632] run fstests generic/144 at 2022-01-12 12:26:15
> >>>[ 2746.679337] run fstests generic/145 at 2022-01-12 12:26:17
> >>>[ 2747.559239] run fstests generic/146 at 2022-01-12 12:26:18
> >>>[ 2749.654314] run fstests generic/147 at 2022-01-12 12:26:20
> >>>[ 2750.441774] run fstests generic/148 at 2022-01-12 12:26:21
> >>>[ 2752.169829] run fstests generic/149 at 2022-01-12 12:26:23
> >>>[ 2752.935800] run fstests generic/150 at 2022-01-12 12:26:24
> >>>[ 2770.733819] run fstests generic/151 at 2022-01-12 12:26:41
> >>>[ 2790.154829] run fstests generic/152 at 2022-01-12 12:27:01
> >>>[ 2810.016846] run fstests generic/153 at 2022-01-12 12:27:21
> >>>[ 2810.829252] run fstests generic/155 at 2022-01-12 12:27:22
> >>>[ 2811.642982] run fstests generic/156 at 2022-01-12 12:27:22
> >>>[ 2812.435476] run fstests generic/157 at 2022-01-12 12:27:23
> >>>[ 2898.516142] run fstests generic/158 at 2022-01-12 12:28:49
> >>>[ 2899.169820] run fstests generic/159 at 2022-01-12 12:28:50
> >>>[ 2899.707414] run fstests generic/160 at 2022-01-12 12:28:50
> >>>[ 2900.240792] run fstests generic/161 at 2022-01-12 12:28:51
> >>>[ 2920.346459] run fstests generic/162 at 2022-01-12 12:29:11
> >>>[ 2921.465497] run fstests generic/163 at 2022-01-12 12:29:12
> >>>[ 2922.457235] run fstests generic/164 at 2022-01-12 12:29:13
> >>>[ 2992.429168] run fstests generic/165 at 2022-01-12 12:30:23
> >>>[ 3052.173968] run fstests generic/166 at 2022-01-12 12:31:23
> >>>[ 3234.652685] run fstests generic/167 at 2022-01-12 12:34:25
> >>>[ 3276.304549] run fstests generic/168 at 2022-01-12 12:35:07
> >>>[ 3556.737914] run fstests generic/169 at 2022-01-12 12:39:47
> >>>[ 3558.300604] run fstests generic/170 at 2022-01-12 12:39:49
> >>>[ 3919.058972] run fstests generic/171 at 2022-01-12 12:45:50
> >>>[ 3920.624329] run fstests generic/172 at 2022-01-12 12:45:51
> >>>[ 3921.953882] run fstests generic/173 at 2022-01-12 12:45:53
> >>>[ 3923.239526] run fstests generic/174 at 2022-01-12 12:45:54
> >>>[ 3924.575586] run fstests generic/175 at 2022-01-12 12:45:55
> >>>[ 4159.652128] run fstests generic/176 at 2022-01-12 12:49:50
> >>>[ 4231.459928] run fstests generic/177 at 2022-01-12 12:51:02
> >>>[ 4232.370516] run fstests generic/178 at 2022-01-12 12:51:03
> >>>[ 4237.868525] run fstests generic/179 at 2022-01-12 12:51:09
> >>>[ 4239.533836] run fstests generic/180 at 2022-01-12 12:51:10
> >>>[ 4240.307772] run fstests generic/181 at 2022-01-12 12:51:11
> >>>[ 4244.757968] run fstests generic/182 at 2022-01-12 12:51:15
> >>>[ 4245.418557] run fstests generic/183 at 2022-01-12 12:51:16
> >>>[ 4251.302820] run fstests generic/185 at 2022-01-12 12:51:22
> >>>[ 4257.418284] run fstests generic/186 at 2022-01-12 12:51:28
> >>>[ 5070.488206] run fstests generic/187 at 2022-01-12 13:05:01
> >>>[ 5885.066194] run fstests generic/188 at 2022-01-12 13:18:36
> >>>[ 5891.287909] run fstests generic/189 at 2022-01-12 13:18:42
> >>>[ 5895.605867] run fstests generic/190 at 2022-01-12 13:18:46
> >>>[ 5900.073040] run fstests generic/191 at 2022-01-12 13:18:51
> >>>[ 5904.614273] run fstests generic/192 at 2022-01-12 13:18:55
> >>>[ 5905.308580] run fstests generic/193 at 2022-01-12 13:18:56
> >>>[ 5905.844031] run fstests generic/194 at 2022-01-12 13:18:57
> >>>[ 5912.087984] run fstests generic/195 at 2022-01-12 13:19:03
> >>>[ 5918.021826] run fstests generic/196 at 2022-01-12 13:19:09
> >>>[ 5922.532326] run fstests generic/197 at 2022-01-12 13:19:13
> >>>[ 5927.467154] run fstests generic/198 at 2022-01-12 13:19:18
> >>>[ 5933.061489] run fstests generic/199 at 2022-01-12 13:19:24
> >>>[ 5938.925983] run fstests generic/200 at 2022-01-12 13:19:30
> >>>[ 5944.827402] run fstests generic/201 at 2022-01-12 13:19:36
> >>>[ 5948.708601] run fstests generic/202 at 2022-01-12 13:19:39
> >>>[ 5950.790927] run fstests generic/203 at 2022-01-12 13:19:41
> >>>[ 5953.029748] run fstests generic/204 at 2022-01-12 13:19:44
> >>>[ 5954.153740] run fstests generic/205 at 2022-01-12 13:19:45
> >>>[ 5955.124318] run fstests generic/206 at 2022-01-12 13:19:46
> >>>[ 5956.139535] run fstests generic/207 at 2022-01-12 13:19:47
> >>>[ 5976.917435] run fstests generic/209 at 2022-01-12 13:20:08
> >>>[ 6022.149019] run fstests generic/210 at 2022-01-12 13:20:53
> >>>[ 6022.898911] run fstests generic/211 at 2022-01-12 13:20:54
> >>>[ 6024.148505] run fstests generic/212 at 2022-01-12 13:20:55
> >>>[ 6024.829471] run fstests generic/213 at 2022-01-12 13:20:56
> >>>[ 6025.661954] run fstests generic/214 at 2022-01-12 13:20:56
> >>>[ 6026.799438] run fstests generic/215 at 2022-01-12 13:20:57
> >>>[ 6029.680826] run fstests generic/216 at 2022-01-12 13:21:00
> >>>[ 6030.690346] run fstests generic/217 at 2022-01-12 13:21:01
> >>>[ 6031.755530] run fstests generic/218 at 2022-01-12 13:21:02
> >>>[ 6032.778991] run fstests generic/219 at 2022-01-12 13:21:03
> >>>[ 6033.283631] run fstests generic/220 at 2022-01-12 13:21:04
> >>>[ 6034.360789] run fstests generic/221 at 2022-01-12 13:21:05
> >>>[ 6035.998554] run fstests generic/222 at 2022-01-12 13:21:07
> >>>[ 6036.984890] run fstests generic/223 at 2022-01-12 13:21:08
> >>>[ 6037.549093] run fstests generic/224 at 2022-01-12 13:21:08
> >>>[ 6038.116815] run fstests generic/226 at 2022-01-12 13:21:09
> >>>[ 6038.692541] run fstests generic/227 at 2022-01-12 13:21:09
> >>>[ 6039.755092] run fstests generic/228 at 2022-01-12 13:21:10
> >>>[ 6040.281881] Unsafe core_pattern used with fs.suid_dumpable=3D2.
> >>>                Pipe handler or fully qualified core dump path require=
d.
> >>>                Set kernel.core_pattern before fs.suid_dumpable.
> >>>[ 6040.553574] run fstests generic/229 at 2022-01-12 13:21:11
> >>>[ 6041.551145] run fstests generic/230 at 2022-01-12 13:21:12
> >>>[ 6042.058550] run fstests generic/231 at 2022-01-12 13:21:13
> >>>[ 6042.559297] run fstests generic/232 at 2022-01-12 13:21:13
> >>>[ 6043.063531] run fstests generic/233 at 2022-01-12 13:21:14
> >>>[ 6043.572898] run fstests generic/234 at 2022-01-12 13:21:14
> >>>[ 6044.083619] run fstests generic/235 at 2022-01-12 13:21:15
> >>>[ 6044.595386] run fstests generic/236 at 2022-01-12 13:21:15
> >>>[ 6046.330897] run fstests generic/237 at 2022-01-12 13:21:17
> >>>[ 6046.995456] run fstests generic/238 at 2022-01-12 13:21:18
> >>>[ 6048.062920] run fstests generic/239 at 2022-01-12 13:21:19
> >>>[ 6079.167087] run fstests generic/240 at 2022-01-12 13:21:50
> >>>[ 6080.262050] run fstests generic/241 at 2022-01-12 13:21:51
> >>>[ 6080.777265] run fstests generic/242 at 2022-01-12 13:21:51
> >>>[ 6165.131825] run fstests generic/243 at 2022-01-12 13:23:16
> >>>[ 6246.858636] run fstests generic/244 at 2022-01-12 13:24:38
> >>>[ 6247.538623] run fstests generic/245 at 2022-01-12 13:24:38
> >>>[ 6248.262918] run fstests generic/246 at 2022-01-12 13:24:39
> >>>[ 6248.891286] run fstests generic/247 at 2022-01-12 13:24:40
> >>>[ 6330.034484] run fstests generic/248 at 2022-01-12 13:26:01
> >>>[ 6330.856382] run fstests generic/249 at 2022-01-12 13:26:02
> >>>[ 6334.074505] run fstests generic/250 at 2022-01-12 13:26:05
> >>>[ 6334.909446] run fstests generic/252 at 2022-01-12 13:26:06
> >>>[ 6335.473954] run fstests generic/253 at 2022-01-12 13:26:06
> >>>[ 6337.650997] run fstests generic/254 at 2022-01-12 13:26:08
> >>>[ 6340.130137] run fstests generic/255 at 2022-01-12 13:26:11
> >>>[ 6341.103237] run fstests generic/256 at 2022-01-12 13:26:12
> >>>[ 6341.796869] run fstests generic/257 at 2022-01-12 13:26:12
> >>>[ 6345.943041] run fstests generic/258 at 2022-01-12 13:26:17
> >>>[ 6346.813066] run fstests generic/259 at 2022-01-12 13:26:18
> >>>[ 6347.896367] run fstests generic/260 at 2022-01-12 13:26:19
> >>>[ 6348.746022] run fstests generic/261 at 2022-01-12 13:26:19
> >>>[ 6349.851327] run fstests generic/262 at 2022-01-12 13:26:21
> >>>[ 6350.974652] run fstests generic/264 at 2022-01-12 13:26:22
> >>>[ 6352.017430] run fstests generic/265 at 2022-01-12 13:26:23
> >>>[ 6353.016731] run fstests generic/266 at 2022-01-12 13:26:24
> >>>[ 6353.983465] run fstests generic/267 at 2022-01-12 13:26:25
> >>>[ 6354.953896] run fstests generic/268 at 2022-01-12 13:26:26
> >>>[ 6355.951768] run fstests generic/269 at 2022-01-12 13:26:27
> >>>[ 6356.458572] run fstests generic/270 at 2022-01-12 13:26:27
> >>>[ 6356.938338] run fstests generic/271 at 2022-01-12 13:26:28
> >>>[ 6357.892032] run fstests generic/272 at 2022-01-12 13:26:29
> >>>[ 6358.849363] run fstests generic/273 at 2022-01-12 13:26:30
> >>>[ 6359.360457] run fstests generic/274 at 2022-01-12 13:26:30
> >>>[ 6359.918582] run fstests generic/275 at 2022-01-12 13:26:31
> >>>[ 6360.433874] run fstests generic/276 at 2022-01-12 13:26:31
> >>>[ 6361.462929] run fstests generic/278 at 2022-01-12 13:26:32
> >>>[ 6362.446136] run fstests generic/279 at 2022-01-12 13:26:33
> >>>[ 6363.428985] run fstests generic/280 at 2022-01-12 13:26:34
> >>>[ 6363.934111] run fstests generic/281 at 2022-01-12 13:26:35
> >>>[ 6364.932675] run fstests generic/282 at 2022-01-12 13:26:36
> >>>[ 6365.931183] run fstests generic/283 at 2022-01-12 13:26:37
> >>>[ 6366.950101] run fstests generic/284 at 2022-01-12 13:26:38
> >>>[ 6370.483205] run fstests generic/285 at 2022-01-12 13:26:41
> >>>[ 6372.532605] run fstests generic/286 at 2022-01-12 13:26:43
> >>>[ 6391.552588] run fstests generic/287 at 2022-01-12 13:27:02
> >>>[ 6395.221066] run fstests generic/288 at 2022-01-12 13:27:06
> >>>[ 6396.199239] run fstests generic/289 at 2022-01-12 13:27:07
> >>>[ 6401.494200] run fstests generic/290 at 2022-01-12 13:27:12
> >>>[ 6406.705872] run fstests generic/291 at 2022-01-12 13:27:17
> >>>[ 6411.919310] run fstests generic/292 at 2022-01-12 13:27:23
> >>>[ 6417.313613] run fstests generic/293 at 2022-01-12 13:27:28
> >>>[ 6424.177254] run fstests generic/295 at 2022-01-12 13:27:35
> >>>[ 6430.984886] run fstests generic/296 at 2022-01-12 13:27:42
> >>>[ 6434.891933] run fstests generic/297 at 2022-01-12 13:27:46
> >>>[ 6435.979562] run fstests generic/298 at 2022-01-12 13:27:47
> >>>[ 6436.941076] run fstests generic/299 at 2022-01-12 13:27:48
> >>>[ 6437.539615] run fstests generic/300 at 2022-01-12 13:27:48
> >>>[ 6438.104575] run fstests generic/301 at 2022-01-12 13:27:49
> >>>[ 6439.145713] run fstests generic/302 at 2022-01-12 13:27:50
> >>>[ 6440.109454] run fstests generic/303 at 2022-01-12 13:27:51
> >>>[ 6441.507025] run fstests generic/304 at 2022-01-12 13:27:52
> >>>[ 6442.163632] run fstests generic/305 at 2022-01-12 13:27:53
> >>>[ 6443.161513] run fstests generic/306 at 2022-01-12 13:27:54
> >>>[ 6444.462375] run fstests generic/307 at 2022-01-12 13:27:55
> >>>[ 6445.026925] run fstests generic/308 at 2022-01-12 13:27:56
> >>>[ 6445.694065] run fstests generic/309 at 2022-01-12 13:27:56
> >>>[ 6447.429347] run fstests generic/311 at 2022-01-12 13:27:58
> >>>[ 6448.065661] run fstests generic/312 at 2022-01-12 13:27:59
> >>>[ 6448.641786] run fstests generic/313 at 2022-01-12 13:27:59
> >>>[ 6453.330380] run fstests generic/314 at 2022-01-12 13:28:04
> >>>[ 6453.869735] run fstests generic/315 at 2022-01-12 13:28:05
> >>>[ 6454.432871] run fstests generic/316 at 2022-01-12 13:28:05
> >>>[ 6455.179812] run fstests generic/317 at 2022-01-12 13:28:06
> >>>[ 6455.744870] run fstests generic/319 at 2022-01-12 13:28:06
> >>>[ 6456.295368] run fstests generic/320 at 2022-01-12 13:28:07
> >>>[ 6456.823414] run fstests generic/321 at 2022-01-12 13:28:08
> >>>[ 6457.398078] run fstests generic/322 at 2022-01-12 13:28:08
> >>>[ 6457.986300] run fstests generic/324 at 2022-01-12 13:28:09
> >>>[ 6458.486502] run fstests generic/325 at 2022-01-12 13:28:09
> >>>[ 6459.043391] run fstests generic/326 at 2022-01-12 13:28:10
> >>>[ 6460.040241] run fstests generic/327 at 2022-01-12 13:28:11
> >>>[ 6461.054872] run fstests generic/328 at 2022-01-12 13:28:12
> >>>[ 6462.066528] run fstests generic/329 at 2022-01-12 13:28:13
> >>>[ 6463.065254] run fstests generic/330 at 2022-01-12 13:28:14
> >>>[ 6471.961534] run fstests generic/331 at 2022-01-12 13:28:23
> >>>[ 6473.162639] run fstests generic/332 at 2022-01-12 13:28:24
> >>>[ 6481.558320] run fstests generic/333 at 2022-01-12 13:28:32
> >>>[ 6482.970708] run fstests generic/334 at 2022-01-12 13:28:34
> >>>[ 6483.883159] run fstests generic/335 at 2022-01-12 13:28:35
> >>>[ 6484.424615] run fstests generic/336 at 2022-01-12 13:28:35
> >>>[ 6485.026317] run fstests generic/337 at 2022-01-12 13:28:36
> >>>[ 6486.087022] run fstests generic/338 at 2022-01-12 13:28:37
> >>>[ 6486.853279] run fstests generic/340 at 2022-01-12 13:28:38
> >>>[ 6529.018625] run fstests generic/341 at 2022-01-12 13:29:20
> >>>[ 6529.743485] run fstests generic/342 at 2022-01-12 13:29:20
> >>>[ 6530.324586] run fstests generic/343 at 2022-01-12 13:29:21
> >>>[ 6530.920079] run fstests generic/344 at 2022-01-12 13:29:22
> >>>[ 6615.377472] run fstests generic/345 at 2022-01-12 13:30:46
> >>>[ 6699.843608] run fstests generic/346 at 2022-01-12 13:32:11
> >>>[ 6738.437542] run fstests generic/347 at 2022-01-12 13:32:49
> >>>[ 6739.294108] run fstests generic/348 at 2022-01-12 13:32:50
> >>>[ 6739.898344] run fstests generic/352 at 2022-01-12 13:32:51
> >>>[ 6741.077399] run fstests generic/353 at 2022-01-12 13:32:52
> >>>[ 6742.043936] run fstests generic/354 at 2022-01-12 13:32:53
> >>>[ 6762.336256] clocksource: timekeeping watchdog on CPU0: acpi_pm retr=
ied 2 times before success
> >>>[ 6771.148344] run fstests generic/355 at 2022-01-12 13:33:22
> >>>[ 6771.867718] run fstests generic/356 at 2022-01-12 13:33:23
> >>>[ 6772.723288] Adding 36k swap on /mnt2/swap.  Priority:-3 extents:1 a=
cross:36k
> >>>[ 6774.212765] Adding 10236k swap on /mnt2/test-356/file1.  Priority:-=
3 extents:1 across:10236k
> >>>[ 6774.563473] run fstests generic/358 at 2022-01-12 13:33:25
> >>>[ 6829.824103] run fstests generic/359 at 2022-01-12 13:34:21
> >>>[ 6844.529776] run fstests generic/360 at 2022-01-12 13:34:35
> >>>[ 6845.353612] run fstests generic/361 at 2022-01-12 13:34:36
> >>>[ 6845.922540] run fstests generic/362 at 2022-01-12 13:34:37
> >>>[ 6846.514415] run fstests generic/363 at 2022-01-12 13:34:37
> >>>[ 6847.212681] run fstests generic/364 at 2022-01-12 13:34:38
> >>>[ 6847.905685] run fstests generic/365 at 2022-01-12 13:34:39
> >>>[ 6848.597706] run fstests generic/366 at 2022-01-12 13:34:39
> >>>[ 6849.301636] run fstests generic/367 at 2022-01-12 13:34:40
> >>>[ 6849.993675] run fstests generic/368 at 2022-01-12 13:34:41
> >>>[ 6850.694262] run fstests generic/369 at 2022-01-12 13:34:41
> >>>[ 6851.389744] run fstests generic/370 at 2022-01-12 13:34:42
> >>>[ 6852.089253] run fstests generic/371 at 2022-01-12 13:34:43
> >>>[ 6852.772792] run fstests generic/372 at 2022-01-12 13:34:43
> >>>[ 6853.867908] run fstests generic/373 at 2022-01-12 13:34:45
> >>>[ 6855.370332] run fstests generic/374 at 2022-01-12 13:34:46
> >>>[ 6856.417262] run fstests generic/375 at 2022-01-12 13:34:47
> >>>[ 6857.021504] run fstests generic/376 at 2022-01-12 13:34:48
> >>>[ 6857.662821] run fstests generic/377 at 2022-01-12 13:34:48
> >>>[ 6858.728302] run fstests generic/378 at 2022-01-12 13:34:49
> >>>[ 6859.437621] run fstests generic/379 at 2022-01-12 13:34:50
> >>>[ 6859.958758] run fstests generic/380 at 2022-01-12 13:34:51
> >>>[ 6860.467861] run fstests generic/381 at 2022-01-12 13:34:51
> >>>[ 6860.979217] run fstests generic/382 at 2022-01-12 13:34:52
> >>>[ 6861.490673] run fstests generic/383 at 2022-01-12 13:34:52
> >>>[ 6862.007029] run fstests generic/384 at 2022-01-12 13:34:53
> >>>[ 6862.539285] run fstests generic/385 at 2022-01-12 13:34:53
> >>>[ 6863.056895] run fstests generic/386 at 2022-01-12 13:34:54
> >>>[ 6863.540959] run fstests generic/387 at 2022-01-12 13:34:54
> >>>[ 6864.451640] run fstests generic/388 at 2022-01-12 13:34:55
> >>>[ 6865.020938] run fstests generic/389 at 2022-01-12 13:34:56
> >>>[ 6865.578808] run fstests generic/390 at 2022-01-12 13:34:56
> >>>[ 6866.159617] run fstests generic/391 at 2022-01-12 13:34:57
> >>>[ 6886.115735] 391 (267517): drop_caches: 3
> >>>[ 6889.286981] run fstests generic/392 at 2022-01-12 13:35:20
> >>>[ 6891.203337] run fstests generic/393 at 2022-01-12 13:35:22
> >>>[ 6893.177969] run fstests generic/394 at 2022-01-12 13:35:24
> >>>[ 6894.586568] run fstests generic/395 at 2022-01-12 13:35:25
> >>>[ 6895.341072] run fstests generic/396 at 2022-01-12 13:35:26
> >>>[ 6896.026789] run fstests generic/397 at 2022-01-12 13:35:27
> >>>[ 6896.798172] run fstests generic/398 at 2022-01-12 13:35:27
> >>>[ 6897.556444] run fstests generic/399 at 2022-01-12 13:35:28
> >>>[ 6898.303641] run fstests generic/400 at 2022-01-12 13:35:29
> >>>[ 6898.815244] run fstests generic/401 at 2022-01-12 13:35:30
> >>>[ 6899.937180] run fstests generic/402 at 2022-01-12 13:35:31
> >>>[ 6901.017461] run fstests generic/404 at 2022-01-12 13:35:32
> >>>[ 6901.789100] run fstests generic/405 at 2022-01-12 13:35:32
> >>>[ 6902.645105] run fstests generic/406 at 2022-01-12 13:35:33
> >>>[ 6910.841871] run fstests generic/407 at 2022-01-12 13:35:42
> >>>[ 6912.903774] run fstests generic/408 at 2022-01-12 13:35:44
> >>>[ 6913.608890] run fstests generic/409 at 2022-01-12 13:35:44
> >>>[ 6914.156131] run fstests generic/410 at 2022-01-12 13:35:45
> >>>[ 6914.704550] run fstests generic/411 at 2022-01-12 13:35:45
> >>>[ 6915.251230] run fstests generic/412 at 2022-01-12 13:35:46
> >>>[ 6916.526789] run fstests generic/413 at 2022-01-12 13:35:47
> >>>[ 6917.304149] nfs: Unknown parameter 'dax'
> >>>[ 6917.410347] run fstests generic/414 at 2022-01-12 13:35:48
> >>>[ 6918.634861] run fstests generic/415 at 2022-01-12 13:35:49
> >>>[ 6933.976957] run fstests generic/416 at 2022-01-12 13:36:05
> >>>[ 6934.691603] run fstests generic/417 at 2022-01-12 13:36:05
> >>>[ 6935.629054] run fstests generic/418 at 2022-01-12 13:36:06
> >>>[ 6936.242138] run fstests generic/419 at 2022-01-12 13:36:07
> >>>[ 6937.045544] run fstests generic/420 at 2022-01-12 13:36:08
> >>>[ 6937.839373] run fstests generic/421 at 2022-01-12 13:36:09
> >>>[ 6938.636575] run fstests generic/424 at 2022-01-12 13:36:09
> >>>[ 6939.351034] run fstests generic/427 at 2022-01-12 13:36:10
> >>>[ 6939.996982] run fstests generic/428 at 2022-01-12 13:36:11
> >>>[ 6940.637416] run fstests generic/429 at 2022-01-12 13:36:11
> >>>[ 6941.362410] run fstests generic/430 at 2022-01-12 13:36:12
> >>>[ 6942.506724] run fstests generic/431 at 2022-01-12 13:36:13
> >>>[ 6943.556512] run fstests generic/432 at 2022-01-12 13:36:14
> >>>[ 6944.645630] run fstests generic/433 at 2022-01-12 13:36:15
> >>>[ 6945.677486] run fstests generic/435 at 2022-01-12 13:36:16
> >>>[ 6946.409026] run fstests generic/436 at 2022-01-12 13:36:17
> >>>[ 6947.992848] run fstests generic/437 at 2022-01-12 13:36:19
> >>>[ 6968.653759] run fstests generic/439 at 2022-01-12 13:36:39
> >>>[ 6970.194179] run fstests generic/440 at 2022-01-12 13:36:41
> >>>[ 6970.921973] run fstests generic/441 at 2022-01-12 13:36:42
> >>>[ 6971.489914] run fstests generic/443 at 2022-01-12 13:36:42
> >>>[ 6972.110321] run fstests generic/444 at 2022-01-12 13:36:43
> >>>[ 6972.734069] run fstests generic/445 at 2022-01-12 13:36:43
> >>>[ 6974.220817] run fstests generic/447 at 2022-01-12 13:36:45
> >>>[ 6975.531450] run fstests generic/448 at 2022-01-12 13:36:46
> >>>[ 6976.914815] run fstests generic/449 at 2022-01-12 13:36:48
> >>>[ 6977.512944] run fstests generic/450 at 2022-01-12 13:36:48
> >>>[ 6978.444175] run fstests generic/451 at 2022-01-12 13:36:49
> >>>[ 7009.200274] run fstests generic/452 at 2022-01-12 13:37:20
> >>>[ 7010.248330] run fstests generic/453 at 2022-01-12 13:37:21
> >>>[ 7012.836935] run fstests generic/454 at 2022-01-12 13:37:24
> >>>[ 7015.394697] run fstests generic/455 at 2022-01-12 13:37:26
> >>>[ 7016.318699] run fstests generic/456 at 2022-01-12 13:37:27
> >>>[ 7016.892196] run fstests generic/457 at 2022-01-12 13:37:28
> >>>[ 7018.100645] run fstests generic/458 at 2022-01-12 13:37:29
> >>>[ 7019.153106] run fstests generic/459 at 2022-01-12 13:37:30
> >>>[ 7020.261614] run fstests generic/460 at 2022-01-12 13:37:31
> >>>[ 7057.684200] run fstests generic/461 at 2022-01-12 13:38:08
> >>>[ 7058.928713] run fstests generic/462 at 2022-01-12 13:38:10
> >>>[ 7059.578267] nfs: Unknown parameter 'dax'
> >>>[ 7059.685070] run fstests generic/463 at 2022-01-12 13:38:10
> >>>[ 7060.682186] run fstests generic/464 at 2022-01-12 13:38:11
> >>>[ 7133.376125] run fstests generic/466 at 2022-01-12 13:39:24
> >>>[ 7134.033001] run fstests generic/467 at 2022-01-12 13:39:25
> >>>[ 7134.958056] sh (300657): drop_caches: 3
> >>>[ 7135.273575] sh (300664): drop_caches: 3
> >>>[ 7135.779078] sh (300671): drop_caches: 3
> >>>[ 7136.171387] sh (300678): drop_caches: 3
> >>>[ 7136.372701] sh (300683): drop_caches: 3
> >>>[ 7136.858710] sh (300690): drop_caches: 3
> >>>[ 7137.390146] sh (300699): drop_caches: 3
> >>>[ 7137.986292] sh (300709): drop_caches: 3
> >>>[ 7138.252495] run fstests generic/468 at 2022-01-12 13:39:29
> >>>[ 7140.487581] run fstests generic/470 at 2022-01-12 13:39:31
> >>>[ 7141.285153] run fstests generic/471 at 2022-01-12 13:39:32
> >>>[ 7141.971971] run fstests generic/472 at 2022-01-12 13:39:33
> >>>[ 7142.757677] Adding 36k swap on /mnt2/swap.  Priority:-3 extents:1 a=
cross:36k
> >>>[ 7143.294807] Adding 2044k swap on /mnt2/swap.  Priority:-3 extents:1=
 across:2044k
> >>>[ 7143.500315] Adding 2044k swap on /mnt2/swap.  Priority:-3 extents:1=
 across:2044k
> >>>[ 7143.621722] Adding 8k swap on /mnt2/swap.  Priority:-3 extents:1 ac=
ross:8k
> >>>[ 7144.046333] run fstests generic/474 at 2022-01-12 13:39:35
> >>>[ 7144.988579] run fstests generic/475 at 2022-01-12 13:39:36
> >>>[ 7145.710624] run fstests generic/477 at 2022-01-12 13:39:36
> >>>[ 7146.845233] sh (302346): drop_caches: 3
> >>>[ 7147.640367] sh (302387): drop_caches: 3
> >>>[ 7148.536961] sh (302428): drop_caches: 3
> >>>[ 7149.466709] sh (302470): drop_caches: 3
> >>>[ 7149.738194] run fstests generic/479 at 2022-01-12 13:39:40
> >>>[ 7150.443204] run fstests generic/480 at 2022-01-12 13:39:41
> >>>[ 7151.048938] run fstests generic/481 at 2022-01-12 13:39:42
> >>>[ 7151.619524] run fstests generic/482 at 2022-01-12 13:39:42
> >>>[ 7152.348315] run fstests generic/483 at 2022-01-12 13:39:43
> >>>[ 7153.020108] run fstests generic/487 at 2022-01-12 13:39:44
> >>>[ 7153.578129] run fstests generic/488 at 2022-01-12 13:39:44
> >>>[ 7154.092708] run fstests generic/489 at 2022-01-12 13:39:45
> >>>[ 7154.645766] run fstests generic/490 at 2022-01-12 13:39:45
> >>>[ 7156.152532] run fstests generic/492 at 2022-01-12 13:39:47
> >>>[ 7156.687978] run fstests generic/493 at 2022-01-12 13:39:47
> >>>[ 7157.440775] Adding 36k swap on /mnt2/swap.  Priority:-3 extents:1 a=
cross:36k
> >>>[ 7158.071570] run fstests generic/494 at 2022-01-12 13:39:49
> >>>[ 7158.945655] Adding 36k swap on /mnt2/swap.  Priority:-3 extents:1 a=
cross:36k
> >>>[ 7159.987483] Adding 10236k swap on /mnt2/test-494/file1.  Priority:-=
3 extents:1 across:10236k
> >>>[ 7160.426306] run fstests generic/495 at 2022-01-12 13:39:51
> >>>[ 7161.398950] Adding 36k swap on /mnt2/swap.  Priority:-3 extents:1 a=
cross:36k
> >>>[ 7161.828770] swap activate: swapfile has holes
> >>>[ 7161.924587] Empty swap-file
> >>>[ 7162.186835] run fstests generic/496 at 2022-01-12 13:39:53
> >>>[ 7163.145304] Adding 36k swap on /mnt2/swap.  Priority:-3 extents:1 a=
cross:36k
> >>>[ 7163.664228] Adding 2044k swap on /mnt2/swap.  Priority:-3 extents:1=
 across:2044k
> >>>[ 7169.433211] Adding 2044k swap on /mnt2/swap.  Priority:-3 extents:1=
 across:2044k
> >>>[ 7169.727608] run fstests generic/497 at 2022-01-12 13:40:00
> >>>[ 7170.735141] Adding 36k swap on /mnt2/swap.  Priority:-3 extents:1 a=
cross:36k
> >>>[ 7171.069079] run fstests generic/498 at 2022-01-12 13:40:02
> >>>[ 7171.732186] run fstests generic/500 at 2022-01-12 13:40:02
> >>>[ 7172.402636] run fstests generic/501 at 2022-01-12 13:40:03
> >>>[ 7173.367894] run fstests generic/502 at 2022-01-12 13:40:04
> >>>[ 7174.036468] run fstests generic/504 at 2022-01-12 13:40:05
> >>>[ 7174.679080] run fstests generic/505 at 2022-01-12 13:40:05
> >>>[ 7175.476364] run fstests generic/506 at 2022-01-12 13:40:06
> >>>[ 7176.336327] run fstests generic/507 at 2022-01-12 13:40:07
> >>>[ 7176.906752] run fstests generic/508 at 2022-01-12 13:40:08
> >>>[ 7177.443466] run fstests generic/509 at 2022-01-12 13:40:08
> >>>[ 7178.113899] run fstests generic/510 at 2022-01-12 13:40:09
> >>>[ 7178.665874] run fstests generic/511 at 2022-01-12 13:40:09
> >>>[ 7179.212399] run fstests generic/512 at 2022-01-12 13:40:10
> >>>[ 7179.863716] run fstests generic/514 at 2022-01-12 13:40:11
> >>>[ 7180.815618] run fstests generic/515 at 2022-01-12 13:40:12
> >>>[ 7181.850294] run fstests generic/516 at 2022-01-12 13:40:13
> >>>[ 7182.497964] run fstests generic/517 at 2022-01-12 13:40:13
> >>>[ 7183.397705] run fstests generic/518 at 2022-01-12 13:40:14
> >>>[ 7185.260858] run fstests generic/520 at 2022-01-12 13:40:16
> >>>[ 7185.995518] run fstests generic/523 at 2022-01-12 13:40:17
> >>>[ 7187.015108] run fstests generic/524 at 2022-01-12 13:40:18
> >>>[ 7214.588812] run fstests generic/525 at 2022-01-12 13:40:45
> >>>[ 7215.945729] run fstests generic/526 at 2022-01-12 13:40:47
> >>>[ 7216.731432] run fstests generic/527 at 2022-01-12 13:40:47
> >>>[ 7217.332036] run fstests generic/528 at 2022-01-12 13:40:48
> >>>[ 7217.928387] run fstests generic/529 at 2022-01-12 13:40:49
> >>>[ 7218.474947] run fstests generic/530 at 2022-01-12 13:40:49
> >>>[ 7219.289577] run fstests generic/532 at 2022-01-12 13:40:50
> >>>[ 7219.984287] run fstests generic/533 at 2022-01-12 13:40:51
> >>>[ 7221.588573] run fstests generic/534 at 2022-01-12 13:40:52
> >>>[ 7222.205596] run fstests generic/535 at 2022-01-12 13:40:53
> >>>[ 7222.829546] run fstests generic/536 at 2022-01-12 13:40:54
> >>>[ 7223.590202] run fstests generic/537 at 2022-01-12 13:40:54
> >>>[ 7224.466640] run fstests generic/538 at 2022-01-12 13:40:55
> >>>[ 7250.048839] run fstests generic/539 at 2022-01-12 13:41:21
> >>>[ 7251.550550] run fstests generic/540 at 2022-01-12 13:41:22
> >>>[ 7257.243669] run fstests generic/541 at 2022-01-12 13:41:28
> >>>[ 7263.478824] run fstests generic/542 at 2022-01-12 13:41:34
> >>>[ 7269.624181] run fstests generic/543 at 2022-01-12 13:41:40
> >>>[ 7275.817103] run fstests generic/544 at 2022-01-12 13:41:47
> >>>[ 7282.092977] run fstests generic/545 at 2022-01-12 13:41:53
> >>>[ 7282.904252] run fstests generic/546 at 2022-01-12 13:41:54
> >>>[ 7283.957773] run fstests generic/547 at 2022-01-12 13:41:55
> >>>[ 7284.580048] run fstests generic/548 at 2022-01-12 13:41:55
> >>>[ 7285.326032] run fstests generic/549 at 2022-01-12 13:41:56
> >>>[ 7286.075114] run fstests generic/550 at 2022-01-12 13:41:57
> >>>[ 7286.842980] run fstests generic/552 at 2022-01-12 13:41:58
> >>>[ 7287.485856] run fstests generic/553 at 2022-01-12 13:41:58
> >>>[ 7288.214457] run fstests generic/554 at 2022-01-12 13:41:59
> >>>[ 7289.123966] Adding 36k swap on /mnt2/swap.  Priority:-3 extents:1 a=
cross:36k
> >>>[ 7290.370393] Adding 16380k swap on /mnt2/swapfile.  Priority:-3 exte=
nts:1 across:16380k
> >>>[ 7290.687659] run fstests generic/555 at 2022-01-12 13:42:01
> >>>[ 7291.521126] run fstests generic/556 at 2022-01-12 13:42:02
> >>>[ 7292.049123] run fstests generic/557 at 2022-01-12 13:42:03
> >>>[ 7292.594633] run fstests generic/558 at 2022-01-12 13:42:03
> >>>[ 7293.116986] run fstests generic/559 at 2022-01-12 13:42:04
> >>>[ 7293.625068] run fstests generic/560 at 2022-01-12 13:42:04
> >>>[ 7294.150767] run fstests generic/561 at 2022-01-12 13:42:05
> >>>[ 7294.672595] run fstests generic/562 at 2022-01-12 13:42:05
> >>>[ 7295.755050] run fstests generic/563 at 2022-01-12 13:42:06
> >>>[ 7296.284954] run fstests generic/564 at 2022-01-12 13:42:07
> >>>[ 7297.286052] loop0: detected capacity change from 0 to 256
> >>>[ 7298.231618] run fstests generic/566 at 2022-01-12 13:42:09
> >>>[ 7298.730755] run fstests generic/567 at 2022-01-12 13:42:09
> >>>[ 7300.222707] run fstests generic/568 at 2022-01-12 13:42:11
> >>>[ 7301.134560] run fstests generic/569 at 2022-01-12 13:42:12
> >>>[ 7302.142643] Adding 36k swap on /mnt2/swap.  Priority:-3 extents:1 a=
cross:36k
> >>>[ 7303.448133] Adding 20476k swap on /mnt2/569.swap.  Priority:-3 exte=
nts:1 across:20476k
> >>>[ 7303.452275] NFS: attempt to write to active swap file!
> >>>[ 7303.487542] Adding 20476k swap on /mnt2/569.swap.  Priority:-3 exte=
nts:1 across:20476k
> >>>[ 7303.530750] Adding 20476k swap on /mnt2/569.swap.  Priority:-3 exte=
nts:1 across:20476k
> >>>[ 7303.587615] Adding 20476k swap on /mnt2/569.swap.  Priority:-3 exte=
nts:1 across:20476k
> >>>[ 7303.629119] Adding 20476k swap on /mnt2/569.swap.  Priority:-3 exte=
nts:1 across:20476k
> >>>[ 7303.646860] NFS: attempt to write to active swap file!
> >>>[ 7303.979451] run fstests generic/570 at 2022-01-12 13:42:15
> >>>[ 7304.692420] run fstests generic/572 at 2022-01-12 13:42:15
> >>>[ 7305.210036] run fstests generic/573 at 2022-01-12 13:42:16
> >>>[ 7305.731408] run fstests generic/574 at 2022-01-12 13:42:16
> >>>[ 7306.245226] run fstests generic/575 at 2022-01-12 13:42:17
> >>>[ 7306.755327] run fstests generic/576 at 2022-01-12 13:42:17
> >>>[ 7307.415264] run fstests generic/577 at 2022-01-12 13:42:18
> >>>[ 7307.966901] run fstests generic/579 at 2022-01-12 13:42:19
> >>>[ 7308.532284] run fstests generic/580 at 2022-01-12 13:42:19
> >>>[ 7309.267749] run fstests generic/581 at 2022-01-12 13:42:20
> >>>[ 7309.916075] run fstests generic/582 at 2022-01-12 13:42:21
> >>>[ 7310.643888] run fstests generic/583 at 2022-01-12 13:42:21
> >>>[ 7311.371543] run fstests generic/584 at 2022-01-12 13:42:22
> >>>[ 7312.108260] run fstests generic/585 at 2022-01-12 13:42:23
> >>>[ 7312.708730] run fstests generic/586 at 2022-01-12 13:42:23
> >>>[ 7321.372427] run fstests generic/587 at 2022-01-12 13:42:32
> >>>[ 7321.882959] run fstests generic/588 at 2022-01-12 13:42:33
> >>>[ 7322.869048] run fstests generic/589 at 2022-01-12 13:42:34
> >>>[ 7323.420928] run fstests generic/590 at 2022-01-12 13:42:34
> >>>[ 7599.522683] run fstests generic/591 at 2022-01-12 13:47:10
> >>>[ 7600.469219] run fstests generic/592 at 2022-01-12 13:47:11
> >>>[ 7601.209667] run fstests generic/593 at 2022-01-12 13:47:12
> >>>[ 7601.925298] run fstests generic/594 at 2022-01-12 13:47:13
> >>>[ 7602.455466] run fstests generic/595 at 2022-01-12 13:47:13
> >>>[ 7603.181000] run fstests generic/596 at 2022-01-12 13:47:14
> >>>[ 7603.583124] Process accounting resumed
> >>>[ 7603.780139] run fstests generic/597 at 2022-01-12 13:47:14
> >>>[ 7604.359127] run fstests generic/598 at 2022-01-12 13:47:15
> >>>[ 7604.907400] run fstests generic/599 at 2022-01-12 13:47:16
> >>>[ 7605.710364] run fstests generic/600 at 2022-01-12 13:47:16
> >>>[ 7606.295426] run fstests generic/601 at 2022-01-12 13:47:17
> >>>[ 7606.813031] run fstests generic/602 at 2022-01-12 13:47:18
> >>>[ 7607.566587] run fstests generic/603 at 2022-01-12 13:47:18
> >>>[ 7608.093235] run fstests generic/604 at 2022-01-12 13:47:19
> >>>[ 7613.505790] run fstests generic/605 at 2022-01-12 13:47:24
> >>>[ 7614.268456] nfs: Unknown parameter 'dax'
> >>>[ 7614.378027] run fstests generic/606 at 2022-01-12 13:47:25
> >>>[ 7614.970728] nfs: Unknown parameter 'dax'
> >>>[ 7615.132524] run fstests generic/608 at 2022-01-12 13:47:26
> >>>[ 7615.730417] nfs: Unknown parameter 'dax'
> >>>[ 7615.838044] run fstests generic/609 at 2022-01-12 13:47:27
> >>>[ 7616.725570] run fstests generic/611 at 2022-01-12 13:47:27
> >>>[ 7617.915374] run fstests nfs/001 at 2022-01-12 13:47:29
> >>>[ 7620.841996] run fstests shared/002 at 2022-01-12 13:47:32
> >>>[ 7621.379231] run fstests shared/032 at 2022-01-12 13:47:32
> >>>[ 7621.870631] run fstests shared/298 at 2022-01-12 13:47:33
> >>>[    0.000000] Linux version 5.16.0-00002-g616758bf6583 (bfields@patat=
e.fieldses.org) (gcc (GCC) 11.2.1 20211203 (Red Hat 11.2.1-7), GNU ld versi=
on 2.37-10.fc35) #1278 SMP PREEMPT Wed Jan 12 11:37:28 EST 2022
> >>>[    0.000000] Command line: BOOT_IMAGE=3D(hd0,msdos1)/vmlinuz-5.16.0-=
00002-g616758bf6583 root=3D/dev/mapper/fedora-root ro resume=3D/dev/mapper/=
fedora-swap rd.lvm.lv=3Dfedora/root rd.lvm.lv=3Dfedora/swap console=3DttyS0=
,38400n8 consoleblank=3D0
> >>>[    0.000000] x86/fpu: Supporting XSAVE feature 0x001: 'x87 floating =
point registers'
> >>>[    0.000000] x86/fpu: Supporting XSAVE feature 0x002: 'SSE registers'
> >>>[    0.000000] x86/fpu: Supporting XSAVE feature 0x004: 'AVX registers'
> >>>[    0.000000] x86/fpu: xstate_offset[2]:  576, xstate_sizes[2]:  256
> >>>[    0.000000] x86/fpu: Enabled xstate features 0x7, context size is 8=
32 bytes, using 'standard' format.
> >>>[    0.000000] signal: max sigframe size: 1776
> >>>[    0.000000] BIOS-provided physical RAM map:
> >>>[    0.000000] BIOS-e820: [mem 0x0000000000000000-0x000000000009fbff] =
usable
> >>>[    0.000000] BIOS-e820: [mem 0x000000000009fc00-0x000000000009ffff] =
reserved
> >>>[    0.000000] BIOS-e820: [mem 0x00000000000f0000-0x00000000000fffff] =
reserved
> >>>[    0.000000] BIOS-e820: [mem 0x0000000000100000-0x000000007ffd7fff] =
usable
> >>>[    0.000000] BIOS-e820: [mem 0x000000007ffd8000-0x000000007fffffff] =
reserved
> >>>[    0.000000] BIOS-e820: [mem 0x00000000feffc000-0x00000000feffffff] =
reserved
> >>>[    0.000000] BIOS-e820: [mem 0x00000000fffc0000-0x00000000ffffffff] =
reserved
> >>>[    0.000000] NX (Execute Disable) protection: active
> >>>[    0.000000] SMBIOS 2.8 present.
> >>>[    0.000000] DMI: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.14.=
0-6.fc35 04/01/2014
> >>>[    0.000000] tsc: Fast TSC calibration using PIT
> >>>[    0.000000] tsc: Detected 3591.667 MHz processor
> >>>[    0.000880] e820: update [mem 0x00000000-0x00000fff] usable =3D=3D>=
 reserved
> >>>[    0.000887] e820: remove [mem 0x000a0000-0x000fffff] usable
> >>>[    0.000894] last_pfn =3D 0x7ffd8 max_arch_pfn =3D 0x400000000
> >>>[    0.000926] x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB  WP  U=
C- WT
> >>>[    0.004010] found SMP MP-table at [mem 0x000f5b80-0x000f5b8f]
> >>>[    0.004443] RAMDISK: [mem 0x346ce000-0x3635efff]
> >>>[    0.004450] ACPI: Early table checksum verification disabled
> >>>[    0.004455] ACPI: RSDP 0x00000000000F58F0 000014 (v00 BOCHS )
> >>>[    0.004464] ACPI: RSDT 0x000000007FFE1902 000030 (v01 BOCHS  BXPC  =
   00000001 BXPC 00000001)
> >>>[    0.004473] ACPI: FACP 0x000000007FFE17D6 000074 (v01 BOCHS  BXPC  =
   00000001 BXPC 00000001)
> >>>[    0.004482] ACPI: DSDT 0x000000007FFE0040 001796 (v01 BOCHS  BXPC  =
   00000001 BXPC 00000001)
> >>>[    0.004489] ACPI: FACS 0x000000007FFE0000 000040
> >>>[    0.004494] ACPI: APIC 0x000000007FFE184A 000090 (v01 BOCHS  BXPC  =
   00000001 BXPC 00000001)
> >>>[    0.004501] ACPI: WAET 0x000000007FFE18DA 000028 (v01 BOCHS  BXPC  =
   00000001 BXPC 00000001)
> >>>[    0.004506] ACPI: Reserving FACP table memory at [mem 0x7ffe17d6-0x=
7ffe1849]
> >>>[    0.004510] ACPI: Reserving DSDT table memory at [mem 0x7ffe0040-0x=
7ffe17d5]
> >>>[    0.004513] ACPI: Reserving FACS table memory at [mem 0x7ffe0000-0x=
7ffe003f]
> >>>[    0.004515] ACPI: Reserving APIC table memory at [mem 0x7ffe184a-0x=
7ffe18d9]
> >>>[    0.004518] ACPI: Reserving WAET table memory at [mem 0x7ffe18da-0x=
7ffe1901]
> >>>[    0.007926] Zone ranges:
> >>>[    0.007934]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
> >>>[    0.007940]   DMA32    [mem 0x0000000001000000-0x000000007ffd7fff]
> >>>[    0.007944]   Normal   empty
> >>>[    0.007947] Movable zone start for each node
> >>>[    0.007949] Early memory node ranges
> >>>[    0.007952]   node   0: [mem 0x0000000000001000-0x000000000009efff]
> >>>[    0.007955]   node   0: [mem 0x0000000000100000-0x000000007ffd7fff]
> >>>[    0.007959] Initmem setup node 0 [mem 0x0000000000001000-0x00000000=
7ffd7fff]
> >>>[    0.007968] On node 0, zone DMA: 1 pages in unavailable ranges
> >>>[    0.008031] On node 0, zone DMA: 97 pages in unavailable ranges
> >>>[    0.015752] On node 0, zone DMA32: 40 pages in unavailable ranges
> >>>[    0.043852] kasan: KernelAddressSanitizer initialized
> >>>[    0.044423] ACPI: PM-Timer IO Port: 0x608
> >>>[    0.044432] ACPI: LAPIC_NMI (acpi_id[0xff] dfl dfl lint[0x1])
> >>>[    0.044477] IOAPIC[0]: apic_id 0, version 17, address 0xfec00000, G=
SI 0-23
> >>>[    0.044486] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
> >>>[    0.044490] ACPI: INT_SRC_OVR (bus 0 bus_irq 5 global_irq 5 high le=
vel)
> >>>[    0.044494] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high le=
vel)
> >>>[    0.044497] ACPI: INT_SRC_OVR (bus 0 bus_irq 10 global_irq 10 high =
level)
> >>>[    0.044500] ACPI: INT_SRC_OVR (bus 0 bus_irq 11 global_irq 11 high =
level)
> >>>[    0.044505] ACPI: Using ACPI (MADT) for SMP configuration informati=
on
> >>>[    0.044508] TSC deadline timer available
> >>>[    0.044514] smpboot: Allowing 4 CPUs, 0 hotplug CPUs
> >>>[    0.044531] [mem 0x80000000-0xfeffbfff] available for PCI devices
> >>>[    0.044536] clocksource: refined-jiffies: mask: 0xffffffff max_cycl=
es: 0xffffffff, max_idle_ns: 7645519600211568 ns
> >>>[    0.059178] setup_percpu: NR_CPUS:8 nr_cpumask_bits:8 nr_cpu_ids:4 =
nr_node_ids:1
> >>>[    0.059473] percpu: Embedded 66 pages/cpu s231440 r8192 d30704 u524=
288
> >>>[    0.059481] pcpu-alloc: s231440 r8192 d30704 u524288 alloc=3D1*2097=
152
> >>>[    0.059486] pcpu-alloc: [0] 0 1 2 3
> >>>[    0.059518] Built 1 zonelists, mobility grouping on.  Total pages: =
516824
> >>>[    0.059528] Kernel command line: BOOT_IMAGE=3D(hd0,msdos1)/vmlinuz-=
5.16.0-00002-g616758bf6583 root=3D/dev/mapper/fedora-root ro resume=3D/dev/=
mapper/fedora-swap rd.lvm.lv=3Dfedora/root rd.lvm.lv=3Dfedora/swap console=
=3DttyS0,38400n8 consoleblank=3D0
> >>>[    0.059605] Unknown kernel command line parameters "BOOT_IMAGE=3D(h=
d0,msdos1)/vmlinuz-5.16.0-00002-g616758bf6583 resume=3D/dev/mapper/fedora-s=
wap", will be passed to user space.
> >>>[    0.059829] Dentry cache hash table entries: 262144 (order: 9, 2097=
152 bytes, linear)
> >>>[    0.059938] Inode-cache hash table entries: 131072 (order: 8, 10485=
76 bytes, linear)
> >>>[    0.059987] mem auto-init: stack:off, heap alloc:off, heap free:off
> >>>[    0.189829] Memory: 1652304K/2096600K available (49170K kernel code=
, 11662K rwdata, 9292K rodata, 2076K init, 15268K bss, 444040K reserved, 0K=
 cma-reserved)
> >>>[    0.191638] Kernel/User page tables isolation: enabled
> >>>[    0.191721] ftrace: allocating 48466 entries in 190 pages
> >>>[    0.208382] ftrace: allocated 190 pages with 6 groups
> >>>[    0.208563] Dynamic Preempt: full
> >>>[    0.208737] Running RCU self tests
> >>>[    0.208749] rcu: Preemptible hierarchical RCU implementation.
> >>>[    0.208751] rcu: 	RCU lockdep checking is enabled.
> >>>[    0.208754] rcu: 	RCU restricting CPUs from NR_CPUS=3D8 to nr_cpu_i=
ds=3D4.
> >>>[    0.208758] 	Trampoline variant of Tasks RCU enabled.
> >>>[    0.208760] 	Rude variant of Tasks RCU enabled.
> >>>[    0.208762] 	Tracing variant of Tasks RCU enabled.
> >>>[    0.208765] rcu: RCU calculated value of scheduler-enlistment delay=
 is 25 jiffies.
> >>>[    0.208767] rcu: Adjusting geometry for rcu_fanout_leaf=3D16, nr_cp=
u_ids=3D4
> >>>[    0.218069] NR_IRQS: 4352, nr_irqs: 72, preallocated irqs: 16
> >>>[    0.218411] random: get_random_bytes called from start_kernel+0x1ef=
/0x384 with crng_init=3D0
> >>>[    0.224704] Console: colour VGA+ 80x25
> >>>[    0.273917] printk: console [ttyS0] enabled
> >>>[    0.274215] Lock dependency validator: Copyright (c) 2006 Red Hat, =
Inc., Ingo Molnar
> >>>[    0.274876] ... MAX_LOCKDEP_SUBCLASSES:  8
> >>>[    0.275165] ... MAX_LOCK_DEPTH:          48
> >>>[    0.275459] ... MAX_LOCKDEP_KEYS:        8192
> >>>[    0.275790] ... CLASSHASH_SIZE:          4096
> >>>[    0.276100] ... MAX_LOCKDEP_ENTRIES:     32768
> >>>[    0.276423] ... MAX_LOCKDEP_CHAINS:      65536
> >>>[    0.276742] ... CHAINHASH_SIZE:          32768
> >>>[    0.277061]  memory used by lock dependency info: 6365 kB
> >>>[    0.277476]  memory used for stack traces: 4224 kB
> >>>[    0.277830]  per task-struct memory footprint: 1920 bytes
> >>>[    0.278254] ACPI: Core revision 20210930
> >>>[    0.278762] APIC: Switch to symmetric I/O mode setup
> >>>[    0.280353] clocksource: tsc-early: mask: 0xffffffffffffffff max_cy=
cles: 0x33c5939df6d, max_idle_ns: 440795297647 ns
> >>>[    0.281280] Calibrating delay loop (skipped), value calculated usin=
g timer frequency.. 7183.33 BogoMIPS (lpj=3D14366668)
> >>>[    0.282204] pid_max: default: 32768 minimum: 301
> >>>[    0.282676] LSM: Security Framework initializing
> >>>[    0.283076] SELinux:  Initializing.
> >>>[    0.283465] Mount-cache hash table entries: 4096 (order: 3, 32768 b=
ytes, linear)
> >>>[    0.284092] Mountpoint-cache hash table entries: 4096 (order: 3, 32=
768 bytes, linear)
> >>>[    0.285279] Last level iTLB entries: 4KB 0, 2MB 0, 4MB 0
> >>>[    0.285279] Last level dTLB entries: 4KB 0, 2MB 0, 4MB 0, 1GB 0
> >>>[    0.285279] Spectre V1 : Mitigation: usercopy/swapgs barriers and _=
_user pointer sanitization
> >>>[    0.285279] Spectre V2 : Mitigation: Full generic retpoline
> >>>[    0.285279] Spectre V2 : Spectre v2 / SpectreRSB mitigation: Fillin=
g RSB on context switch
> >>>[    0.285279] Spectre V2 : Enabling Restricted Speculation for firmwa=
re calls
> >>>[    0.285279] Spectre V2 : mitigation: Enabling conditional Indirect =
Branch Prediction Barrier
> >>>[    0.285279] Speculative Store Bypass: Vulnerable
> >>>[    0.285279] SRBDS: Unknown: Dependent on hypervisor status
> >>>[    0.285279] MDS: Vulnerable: Clear CPU buffers attempted, no microc=
ode
> >>>[    0.285279] Freeing SMP alternatives memory: 44K
> >>>[    0.285279] smpboot: CPU0: Intel Core Processor (Haswell, no TSX, I=
BRS) (family: 0x6, model: 0x3c, stepping: 0x1)
> >>>[    0.285279] Running RCU-tasks wait API self tests
> >>>[    0.386107] Performance Events: unsupported p6 CPU model 60 no PMU =
driver, software events only.
> >>>[    0.389599] rcu: Hierarchical SRCU implementation.
> >>>[    0.392441] NMI watchdog: Perf NMI watchdog permanently disabled
> >>>[    0.393385] Callback from call_rcu_tasks_trace() invoked.
> >>>[    0.394170] smp: Bringing up secondary CPUs ...
> >>>[    0.396370] x86: Booting SMP configuration:
> >>>[    0.396786] .... node  #0, CPUs:      #1
> >>>[    0.066931] smpboot: CPU 1 Converting physical 0 to logical die 1
> >>>[    0.482790]  #2
> >>>[    0.066931] smpboot: CPU 2 Converting physical 0 to logical die 2
> >>>[    0.565821] Callback from call_rcu_tasks_rude() invoked.
> >>>[    0.567462]  #3
> >>>[    0.066931] smpboot: CPU 3 Converting physical 0 to logical die 3
> >>>[    0.649444] smp: Brought up 1 node, 4 CPUs
> >>>[    0.649755] smpboot: Max logical packages: 4
> >>>[    0.650109] smpboot: Total of 4 processors activated (28813.78 Bogo=
MIPS)
> >>>[    0.652111] devtmpfs: initialized
> >>>[    0.656548] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xff=
ffffff, max_idle_ns: 7645041785100000 ns
> >>>[    0.657296] futex hash table entries: 1024 (order: 5, 131072 bytes,=
 linear)
> >>>[    0.659317] NET: Registered PF_NETLINK/PF_ROUTE protocol family
> >>>[    0.660716] audit: initializing netlink subsys (disabled)
> >>>[    0.661311] audit: type=3D2000 audit(1642005696.380:1): state=3Dini=
tialized audit_enabled=3D0 res=3D1
> >>>[    0.662148] thermal_sys: Registered thermal governor 'step_wise'
> >>>[    0.662161] thermal_sys: Registered thermal governor 'user_space'
> >>>[    0.662741] cpuidle: using governor ladder
> >>>[    0.663957] PCI: Using configuration type 1 for base access
> >>>[    0.673336] Callback from call_rcu_tasks() invoked.
> >>>[    0.688468] kprobes: kprobe jump-optimization is enabled. All kprob=
es are optimized if possible.
> >>>[    0.689933] HugeTLB registered 2.00 MiB page size, pre-allocated 0 =
pages
> >>>[    0.690902] cryptd: max_cpu_qlen set to 1000
> >>>[    0.757333] raid6: avx2x4   gen() 34683 MB/s
> >>>[    0.825285] raid6: avx2x4   xor() 13341 MB/s
> >>>[    0.893285] raid6: avx2x2   gen() 32969 MB/s
> >>>[    0.961293] raid6: avx2x2   xor() 18290 MB/s
> >>>[    1.029283] raid6: avx2x1   gen() 25495 MB/s
> >>>[    1.097283] raid6: avx2x1   xor() 16599 MB/s
> >>>[    1.165417] raid6: sse2x4   gen() 18858 MB/s
> >>>[    1.233284] raid6: sse2x4   xor()  9882 MB/s
> >>>[    1.301284] raid6: sse2x2   gen() 17529 MB/s
> >>>[    1.369284] raid6: sse2x2   xor() 10528 MB/s
> >>>[    1.437284] raid6: sse2x1   gen() 12868 MB/s
> >>>[    1.505284] raid6: sse2x1   xor()  9047 MB/s
> >>>[    1.505592] raid6: using algorithm avx2x4 gen() 34683 MB/s
> >>>[    1.506016] raid6: .... xor() 13341 MB/s, rmw enabled
> >>>[    1.506395] raid6: using avx2x2 recovery algorithm
> >>>[    1.507187] ACPI: Added _OSI(Module Device)
> >>>[    1.507507] ACPI: Added _OSI(Processor Device)
> >>>[    1.507827] ACPI: Added _OSI(3.0 _SCP Extensions)
> >>>[    1.508176] ACPI: Added _OSI(Processor Aggregator Device)
> >>>[    1.508594] ACPI: Added _OSI(Linux-Dell-Video)
> >>>[    1.508918] ACPI: Added _OSI(Linux-Lenovo-NV-HDMI-Audio)
> >>>[    1.509291] ACPI: Added _OSI(Linux-HPI-Hybrid-Graphics)
> >>>[    1.529597] ACPI: 1 ACPI AML tables successfully acquired and loaded
> >>>[    1.536937] ACPI: Interpreter enabled
> >>>[    1.537121] ACPI: PM: (supports S0 S5)
> >>>[    1.537300] ACPI: Using IOAPIC for interrupt routing
> >>>[    1.537790] PCI: Using host bridge windows from ACPI; if necessary,=
 use "pci=3Dnocrs" and report a bug
> >>>[    1.539878] ACPI: Enabled 2 GPEs in block 00 to 0F
> >>>[    1.582821] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-ff])
> >>>[    1.583389] acpi PNP0A03:00: _OSC: OS supports [ASPM ClockPM Segmen=
ts HPX-Type3]
> >>>[    1.584011] acpi PNP0A03:00: PCIe port services disabled; not reque=
sting _OSC control
> >>>[    1.584761] acpi PNP0A03:00: fail to add MMCONFIG information, can'=
t access extended PCI configuration space under this bridge.
> >>>[    1.585813] PCI host bridge to bus 0000:00
> >>>[    1.586147] pci_bus 0000:00: root bus resource [io  0x0000-0x0cf7 w=
indow]
> >>>[    1.586722] pci_bus 0000:00: root bus resource [io  0x0d00-0xffff w=
indow]
> >>>[    1.587293] pci_bus 0000:00: root bus resource [mem 0x000a0000-0x00=
0bffff window]
> >>>[    1.587921] pci_bus 0000:00: root bus resource [mem 0x80000000-0xfe=
bfffff window]
> >>>[    1.588545] pci_bus 0000:00: root bus resource [mem 0x100000000-0x1=
7fffffff window]
> >>>[    1.589183] pci_bus 0000:00: root bus resource [bus 00-ff]
> >>>[    1.593451] pci 0000:00:00.0: [8086:1237] type 00 class 0x060000
> >>>[    1.604897] pci 0000:00:01.0: [8086:7000] type 00 class 0x060100
> >>>[    1.606756] pci 0000:00:01.1: [8086:7010] type 00 class 0x010180
> >>>[    1.609820] pci 0000:00:01.1: reg 0x20: [io  0xc2e0-0xc2ef]
> >>>[    1.611254] pci 0000:00:01.1: legacy IDE quirk: reg 0x10: [io  0x01=
f0-0x01f7]
> >>>[    1.611843] pci 0000:00:01.1: legacy IDE quirk: reg 0x14: [io  0x03=
f6]
> >>>[    1.612367] pci 0000:00:01.1: legacy IDE quirk: reg 0x18: [io  0x01=
70-0x0177]
> >>>[    1.612952] pci 0000:00:01.1: legacy IDE quirk: reg 0x1c: [io  0x03=
76]
> >>>[    1.613748] pci 0000:00:01.3: [8086:7113] type 00 class 0x068000
> >>>[    1.614670] pci 0000:00:01.3: quirk: [io  0x0600-0x063f] claimed by=
 PIIX4 ACPI
> >>>[    1.615271] pci 0000:00:01.3: quirk: [io  0x0700-0x070f] claimed by=
 PIIX4 SMB
> >>>[    1.616279] pci 0000:00:02.0: [1b36:0100] type 00 class 0x030000
> >>>[    1.618571] pci 0000:00:02.0: reg 0x10: [mem 0xf4000000-0xf7ffffff]
> >>>[    1.621026] pci 0000:00:02.0: reg 0x14: [mem 0xf8000000-0xfbffffff]
> >>>[    1.623401] pci 0000:00:02.0: reg 0x18: [mem 0xfc054000-0xfc055fff]
> >>>[    1.625293] pci 0000:00:02.0: reg 0x1c: [io  0xc200-0xc21f]
> >>>[    1.632521] pci 0000:00:02.0: reg 0x30: [mem 0xfc040000-0xfc04ffff =
pref]
> >>>[    1.643746] pci 0000:00:03.0: [1af4:1000] type 00 class 0x020000
> >>>[    1.645084] pci 0000:00:03.0: reg 0x10: [io  0xc220-0xc23f]
> >>>[    1.646115] pci 0000:00:03.0: reg 0x14: [mem 0xfc056000-0xfc056fff]
> >>>[    1.650262] pci 0000:00:03.0: reg 0x20: [mem 0xfebd4000-0xfebd7fff =
64bit pref]
> >>>[    1.651726] pci 0000:00:03.0: reg 0x30: [mem 0xfc000000-0xfc03ffff =
pref]
> >>>[    1.663001] pci 0000:00:04.0: [8086:2668] type 00 class 0x040300
> >>>[    1.663848] pci 0000:00:04.0: reg 0x10: [mem 0xfc050000-0xfc053fff]
> >>>[    1.676622] pci 0000:00:05.0: [8086:2934] type 00 class 0x0c0300
> >>>[    1.678734] pci 0000:00:05.0: reg 0x20: [io  0xc240-0xc25f]
> >>>[    1.690560] pci 0000:00:05.1: [8086:2935] type 00 class 0x0c0300
> >>>[    1.692610] pci 0000:00:05.1: reg 0x20: [io  0xc260-0xc27f]
> >>>[    1.694089] pci 0000:00:05.2: [8086:2936] type 00 class 0x0c0300
> >>>[    1.696372] pci 0000:00:05.2: reg 0x20: [io  0xc280-0xc29f]
> >>>[    1.697989] pci 0000:00:05.7: [8086:293a] type 00 class 0x0c0320
> >>>[    1.698889] pci 0000:00:05.7: reg 0x10: [mem 0xfc057000-0xfc057fff]
> >>>[    1.707037] pci 0000:00:06.0: [1af4:1003] type 00 class 0x078000
> >>>[    1.708590] pci 0000:00:06.0: reg 0x10: [io  0xc000-0xc03f]
> >>>[    1.709714] pci 0000:00:06.0: reg 0x14: [mem 0xfc058000-0xfc058fff]
> >>>[    1.712836] pci 0000:00:06.0: reg 0x20: [mem 0xfebd8000-0xfebdbfff =
64bit pref]
> >>>[    1.726059] pci 0000:00:07.0: [1af4:1001] type 00 class 0x010000
> >>>[    1.727542] pci 0000:00:07.0: reg 0x10: [io  0xc040-0xc07f]
> >>>[    1.728892] pci 0000:00:07.0: reg 0x14: [mem 0xfc059000-0xfc059fff]
> >>>[    1.731824] pci 0000:00:07.0: reg 0x20: [mem 0xfebdc000-0xfebdffff =
64bit pref]
> >>>[    1.744361] pci 0000:00:08.0: [1af4:1002] type 00 class 0x00ff00
> >>>[    1.745286] pci 0000:00:08.0: reg 0x10: [io  0xc2a0-0xc2bf]
> >>>[    1.748005] pci 0000:00:08.0: reg 0x20: [mem 0xfebe0000-0xfebe3fff =
64bit pref]
> >>>[    1.760699] pci 0000:00:09.0: [1af4:1005] type 00 class 0x00ff00
> >>>[    1.761568] pci 0000:00:09.0: reg 0x10: [io  0xc2c0-0xc2df]
> >>>[    1.764291] pci 0000:00:09.0: reg 0x20: [mem 0xfebe4000-0xfebe7fff =
64bit pref]
> >>>[    1.775904] pci 0000:00:0a.0: [1af4:1001] type 00 class 0x010000
> >>>[    1.777237] pci 0000:00:0a.0: reg 0x10: [io  0xc080-0xc0bf]
> >>>[    1.778068] pci 0000:00:0a.0: reg 0x14: [mem 0xfc05a000-0xfc05afff]
> >>>[    1.781719] pci 0000:00:0a.0: reg 0x20: [mem 0xfebe8000-0xfebebfff =
64bit pref]
> >>>[    1.794394] pci 0000:00:0b.0: [1af4:1001] type 00 class 0x010000
> >>>[    1.795745] pci 0000:00:0b.0: reg 0x10: [io  0xc0c0-0xc0ff]
> >>>[    1.796982] pci 0000:00:0b.0: reg 0x14: [mem 0xfc05b000-0xfc05bfff]
> >>>[    1.799779] pci 0000:00:0b.0: reg 0x20: [mem 0xfebec000-0xfebeffff =
64bit pref]
> >>>[    1.812867] pci 0000:00:0c.0: [1af4:1001] type 00 class 0x010000
> >>>[    1.814289] pci 0000:00:0c.0: reg 0x10: [io  0xc100-0xc13f]
> >>>[    1.815517] pci 0000:00:0c.0: reg 0x14: [mem 0xfc05c000-0xfc05cfff]
> >>>[    1.818535] pci 0000:00:0c.0: reg 0x20: [mem 0xfebf0000-0xfebf3fff =
64bit pref]
> >>>[    1.830979] pci 0000:00:0d.0: [1af4:1001] type 00 class 0x010000
> >>>[    1.832321] pci 0000:00:0d.0: reg 0x10: [io  0xc140-0xc17f]
> >>>[    1.833286] pci 0000:00:0d.0: reg 0x14: [mem 0xfc05d000-0xfc05dfff]
> >>>[    1.836445] pci 0000:00:0d.0: reg 0x20: [mem 0xfebf4000-0xfebf7fff =
64bit pref]
> >>>[    1.848403] pci 0000:00:0e.0: [1af4:1001] type 00 class 0x010000
> >>>[    1.849691] pci 0000:00:0e.0: reg 0x10: [io  0xc180-0xc1bf]
> >>>[    1.850908] pci 0000:00:0e.0: reg 0x14: [mem 0xfc05e000-0xfc05efff]
> >>>[    1.853728] pci 0000:00:0e.0: reg 0x20: [mem 0xfebf8000-0xfebfbfff =
64bit pref]
> >>>[    1.867912] pci 0000:00:0f.0: [1af4:1001] type 00 class 0x010000
> >>>[    1.869286] pci 0000:00:0f.0: reg 0x10: [io  0xc1c0-0xc1ff]
> >>>[    1.870507] pci 0000:00:0f.0: reg 0x14: [mem 0xfc05f000-0xfc05ffff]
> >>>[    1.873286] pci 0000:00:0f.0: reg 0x20: [mem 0xfebfc000-0xfebfffff =
64bit pref]
> >>>[    1.886571] pci_bus 0000:00: on NUMA node 0
> >>>[    1.890389] ACPI: PCI: Interrupt link LNKA configured for IRQ 10
> >>>[    1.892145] ACPI: PCI: Interrupt link LNKB configured for IRQ 10
> >>>[    1.893842] ACPI: PCI: Interrupt link LNKC configured for IRQ 11
> >>>[    1.895486] ACPI: PCI: Interrupt link LNKD configured for IRQ 11
> >>>[    1.896509] ACPI: PCI: Interrupt link LNKS configured for IRQ 9
> >>>[    1.904775] pci 0000:00:02.0: vgaarb: setting as boot VGA device
> >>>[    1.904775] pci 0000:00:02.0: vgaarb: VGA device added: decodes=3Di=
o+mem,owns=3Dio+mem,locks=3Dnone
> >>>[    1.904775] pci 0000:00:02.0: vgaarb: bridge control possible
> >>>[    1.904775] vgaarb: loaded
> >>>[    1.904775] SCSI subsystem initialized
> >>>[    1.904775] libata version 3.00 loaded.
> >>>[    1.904775] ACPI: bus type USB registered
> >>>[    1.905259] usbcore: registered new interface driver usbfs
> >>>[    1.909389] usbcore: registered new interface driver hub
> >>>[    1.909860] usbcore: registered new device driver usb
> >>>[    1.910380] pps_core: LinuxPPS API ver. 1 registered
> >>>[    1.910754] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rod=
olfo Giometti <giometti@linux.it>
> >>>[    1.911613] PTP clock support registered
> >>>[    1.912179] EDAC MC: Ver: 3.0.0
> >>>[    1.913040] Advanced Linux Sound Architecture Driver Initialized.
> >>>[    1.913040] PCI: Using ACPI for IRQ routing
> >>>[    1.913040] PCI: pci_cache_line_size set to 64 bytes
> >>>[    1.913040] e820: reserve RAM buffer [mem 0x0009fc00-0x0009ffff]
> >>>[    1.913040] e820: reserve RAM buffer [mem 0x7ffd8000-0x7fffffff]
> >>>[    1.913283] clocksource: Switched to clocksource tsc-early
> >>>[    2.100358] VFS: Disk quotas dquot_6.6.0
> >>>[    2.100783] VFS: Dquot-cache hash table entries: 512 (order 0, 4096=
 bytes)
> >>>[    2.101643] FS-Cache: Loaded
> >>>[    2.102237] CacheFiles: Loaded
> >>>[    2.102534] pnp: PnP ACPI init
> >>>[    2.103635] pnp 00:03: [dma 2]
> >>>[    2.106017] pnp: PnP ACPI: found 5 devices
> >>>[    2.127076] clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffff=
ff, max_idle_ns: 2085701024 ns
> >>>[    2.127982] NET: Registered PF_INET protocol family
> >>>[    2.128550] IP idents hash table entries: 32768 (order: 6, 262144 b=
ytes, linear)
> >>>[    2.130129] tcp_listen_portaddr_hash hash table entries: 1024 (orde=
r: 4, 81920 bytes, linear)
> >>>[    2.130900] TCP established hash table entries: 16384 (order: 5, 13=
1072 bytes, linear)
> >>>[    2.131794] TCP bind hash table entries: 16384 (order: 8, 1179648 b=
ytes, linear)
> >>>[    2.132819] TCP: Hash tables configured (established 16384 bind 163=
84)
> >>>[    2.133780] UDP hash table entries: 1024 (order: 5, 163840 bytes, l=
inear)
> >>>[    2.134414] UDP-Lite hash table entries: 1024 (order: 5, 163840 byt=
es, linear)
> >>>[    2.135294] NET: Registered PF_UNIX/PF_LOCAL protocol family
> >>>[    2.135777] pci_bus 0000:00: resource 4 [io  0x0000-0x0cf7 window]
> >>>[    2.136308] pci_bus 0000:00: resource 5 [io  0x0d00-0xffff window]
> >>>[    2.136806] pci_bus 0000:00: resource 6 [mem 0x000a0000-0x000bffff =
window]
> >>>[    2.137427] pci_bus 0000:00: resource 7 [mem 0x80000000-0xfebfffff =
window]
> >>>[    2.137992] pci_bus 0000:00: resource 8 [mem 0x100000000-0x17ffffff=
f window]
> >>>[    2.138908] pci 0000:00:01.0: PIIX3: Enabling Passive Release
> >>>[    2.139376] pci 0000:00:00.0: Limiting direct PCI/PCI transfers
> >>>[    2.139854] pci 0000:00:01.0: Activating ISA DMA hang workarounds
> >>>[    2.140425] pci 0000:00:02.0: Video device with shadowed ROM at [me=
m 0x000c0000-0x000dffff]
> >>>[    3.202115] ACPI: \_SB_.LNKA: Enabled at IRQ 10
> >>>[    4.239171] pci 0000:00:05.0: quirk_usb_early_handoff+0x0/0xa70 too=
k 2048819 usecs
> >>>[    5.300725] ACPI: \_SB_.LNKB: Enabled at IRQ 11
> >>>[    6.347387] pci 0000:00:05.1: quirk_usb_early_handoff+0x0/0xa70 too=
k 2058145 usecs
> >>>[    7.421229] ACPI: \_SB_.LNKC: Enabled at IRQ 11
> >>>[    8.471039] pci 0000:00:05.2: quirk_usb_early_handoff+0x0/0xa70 too=
k 2073223 usecs
> >>>[    9.544718] ACPI: \_SB_.LNKD: Enabled at IRQ 10
> >>>[   10.599331] pci 0000:00:05.7: quirk_usb_early_handoff+0x0/0xa70 too=
k 2077756 usecs
> >>>[   10.600123] PCI: CLS 0 bytes, default 64
> >>>[   10.601188] Trying to unpack rootfs image as initramfs...
> >>>[   10.604786] Initialise system trusted keyrings
> >>>[   10.605377] workingset: timestamp_bits=3D62 max_order=3D19 bucket_o=
rder=3D0
> >>>[   10.607827] DLM installed
> >>>[   10.610089] Key type cifs.idmap registered
> >>>[   10.610742] fuse: init (API version 7.35)
> >>>[   10.611401] SGI XFS with ACLs, security attributes, no debug enabled
> >>>[   10.612942] ocfs2: Registered cluster interface o2cb
> >>>[   10.613684] ocfs2: Registered cluster interface user
> >>>[   10.614265] OCFS2 User DLM kernel interface loaded
> >>>[   10.617912] gfs2: GFS2 installed
> >>>[   10.626466] xor: automatically using best checksumming function   a=
vx
> >>>[   10.627049] Key type asymmetric registered
> >>>[   10.627348] Asymmetric key parser 'x509' registered
> >>>[   10.627936] Block layer SCSI generic (bsg) driver version 0.4 loade=
d (major 251)
> >>>[   10.628640] io scheduler mq-deadline registered
> >>>[   10.628991] io scheduler kyber registered
> >>>[   10.629268] test_string_helpers: Running tests...
> >>>[   10.646349] cryptomgr_test (94) used greatest stack depth: 30192 by=
tes left
> >>>[   10.647783] shpchp: Standard Hot Plug PCI Controller Driver version=
: 0.4
> >>>[   10.649320] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00=
/input/input0
> >>>[   10.661911] ACPI: button: Power Button [PWRF]
> >>>[   11.308291] Freeing initrd memory: 29252K
> >>>[   11.309219] kworker/u8:1 (116) used greatest stack depth: 28384 byt=
es left
> >>>[   11.613446] tsc: Refined TSC clocksource calibration: 3591.600 MHz
> >>>[   11.614007] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: =
0x33c55424d7b, max_idle_ns: 440795215499 ns
> >>>[   11.615017] clocksource: Switched to clocksource tsc
> >>>[   24.416686] Serial: 8250/16550 driver, 4 ports, IRQ sharing disabled
> >>>[   24.417569] 00:00: ttyS0 at I/O 0x3f8 (irq =3D 4, base_baud =3D 115=
200) is a 16550A
> >>>[   24.421615] Non-volatile memory driver v1.3
> >>>[   24.421936] Linux agpgart interface v0.103
> >>>[   24.423208] ACPI: bus type drm_connector registered
> >>>[   24.444467] brd: module loaded
> >>>[   24.457220] loop: module loaded
> >>>[   24.458122] virtio_blk virtio2: [vda] 16777216 512-byte logical blo=
cks (8.59 GB/8.00 GiB)
> >>>[   24.462053]  vda: vda1 vda2
> >>>[   24.465619] virtio_blk virtio5: [vdb] 10485760 512-byte logical blo=
cks (5.37 GB/5.00 GiB)
> >>>[   24.469543] virtio_blk virtio6: [vdc] 10485760 512-byte logical blo=
cks (5.37 GB/5.00 GiB)
> >>>[   24.473451] virtio_blk virtio7: [vdd] 10485760 512-byte logical blo=
cks (5.37 GB/5.00 GiB)
> >>>[   24.477416] virtio_blk virtio8: [vde] 10485760 512-byte logical blo=
cks (5.37 GB/5.00 GiB)
> >>>[   24.481188] virtio_blk virtio9: [vdf] 41943040 512-byte logical blo=
cks (21.5 GB/20.0 GiB)
> >>>[   24.484978] virtio_blk virtio10: [vdg] 20971520 512-byte logical bl=
ocks (10.7 GB/10.0 GiB)
> >>>[   24.488125]  vdg:
> >>>[   24.489758] zram: Added device: zram0
> >>>[   24.492368] ata_piix 0000:00:01.1: version 2.13
> >>>[   24.496603] scsi host0: ata_piix
> >>>[   24.498008] scsi host1: ata_piix
> >>>[   24.498675] ata1: PATA max MWDMA2 cmd 0x1f0 ctl 0x3f6 bmdma 0xc2e0 =
irq 14
> >>>[   24.499256] ata2: PATA max MWDMA2 cmd 0x170 ctl 0x376 bmdma 0xc2e8 =
irq 15
> >>>[   24.501218] tun: Universal TUN/TAP device driver, 1.6
> >>>[   24.504829] e1000: Intel(R) PRO/1000 Network Driver
> >>>[   24.505219] e1000: Copyright (c) 1999-2006 Intel Corporation.
> >>>[   24.505862] e1000e: Intel(R) PRO/1000 Network Driver
> >>>[   24.506254] e1000e: Copyright(c) 1999 - 2015 Intel Corporation.
> >>>[   24.507072] PPP generic driver version 2.4.2
> >>>[   24.509436] aoe: AoE v85 initialised.
> >>>[   24.510102] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Dri=
ver
> >>>[   24.510679] ehci-pci: EHCI PCI platform driver
> >>>[   24.657958] ata1.01: NODEV after polling detection
> >>>[   24.658233] ata1.00: ATAPI: QEMU DVD-ROM, 2.5+, max UDMA/100
> >>>[   24.660230] scsi 0:0:0:0: CD-ROM            QEMU     QEMU DVD-ROM  =
   2.5+ PQ: 0 ANSI: 5
> >>>[   24.714138] sr 0:0:0:0: [sr0] scsi3-mmc drive: 4x/4x cd/rw xa/form2=
 tray
> >>>[   24.714722] cdrom: Uniform CD-ROM driver Revision: 3.20
> >>>[   24.749225] sr 0:0:0:0: Attached scsi CD-ROM sr0
> >>>[   24.750199] sr 0:0:0:0: Attached scsi generic sg0 type 5
> >>>[   25.753762] ehci-pci 0000:00:05.7: EHCI Host Controller
> >>>[   25.755008] ehci-pci 0000:00:05.7: new USB bus registered, assigned=
 bus number 1
> >>>[   25.755944] ehci-pci 0000:00:05.7: irq 10, io mem 0xfc057000
> >>>[   25.769490] ehci-pci 0000:00:05.7: USB 2.0 started, EHCI 1.00
> >>>[   25.773616] hub 1-0:1.0: USB hub found
> >>>[   25.774306] hub 1-0:1.0: 6 ports detected
> >>>[   25.779054] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
> >>>[   25.779761] ohci-pci: OHCI PCI platform driver
> >>>[   25.780223] uhci_hcd: USB Universal Host Controller Interface driver
> >>>[   26.041366] usb 1-1: new high-speed USB device number 2 using ehci-=
pci
> >>>[   27.054250] uhci_hcd 0000:00:05.0: UHCI Host Controller
> >>>[   27.055419] uhci_hcd 0000:00:05.0: new USB bus registered, assigned=
 bus number 2
> >>>[   27.056446] uhci_hcd 0000:00:05.0: irq 10, io port 0x0000c240
> >>>[   27.058858] hub 2-0:1.0: USB hub found
> >>>[   27.059323] hub 2-0:1.0: 2 ports detected
> >>>[   28.319755] uhci_hcd 0000:00:05.1: UHCI Host Controller
> >>>[   28.320738] uhci_hcd 0000:00:05.1: new USB bus registered, assigned=
 bus number 3
> >>>[   28.321673] uhci_hcd 0000:00:05.1: irq 11, io port 0x0000c260
> >>>[   28.323716] hub 3-0:1.0: USB hub found
> >>>[   28.324067] hub 3-0:1.0: 2 ports detected
> >>>[   29.592163] uhci_hcd 0000:00:05.2: UHCI Host Controller
> >>>[   29.593127] uhci_hcd 0000:00:05.2: new USB bus registered, assigned=
 bus number 4
> >>>[   29.594072] uhci_hcd 0000:00:05.2: irq 11, io port 0x0000c280
> >>>[   29.596130] hub 4-0:1.0: USB hub found
> >>>[   29.596496] hub 4-0:1.0: 2 ports detected
> >>>[   29.598855] usbcore: registered new interface driver usblp
> >>>[   29.599462] usbcore: registered new interface driver usb-storage
> >>>[   29.600541] i8042: PNP: PS/2 Controller [PNP0303:KBD,PNP0f13:MOU] a=
t 0x60,0x64 irq 1,12
> >>>[   29.602527] serio: i8042 KBD port at 0x60,0x64 irq 1
> >>>[   29.603702] serio: i8042 AUX port at 0x60,0x64 irq 12
> >>>[   29.605764] mousedev: PS/2 mouse device common for all mice
> >>>[   29.607846] input: AT Translated Set 2 keyboard as /devices/platfor=
m/i8042/serio0/input/input1
> >>>[   29.609776] input: PC Speaker as /devices/platform/pcspkr/input/inp=
ut3
> >>>[   29.611498] device-mapper: core: CONFIG_IMA_DISABLE_HTABLE is disab=
led. Duplicate IMA measurements will not be recorded in the IMA log.
> >>>[   29.613021] device-mapper: uevent: version 1.0.3
> >>>[   29.614146] device-mapper: ioctl: 4.45.0-ioctl (2021-03-22) initial=
ised: dm-devel@redhat.com
> >>>[   29.615545] device-mapper: multipath round-robin: version 1.2.0 loa=
ded
> >>>[   29.616195] intel_pstate: CPU model not supported
> >>>[   29.627242] input: QEMU QEMU USB Tablet as /devices/pci0000:00/0000=
:00:05.7/usb1/1-1/1-1:1.0/0003:0627:0001.0001/input/input5
> >>>[   29.629270] hid-generic 0003:0627:0001.0001: input: USB HID v0.01 M=
ouse [QEMU QEMU USB Tablet] on usb-0000:00:05.7-1/input0
> >>>[   29.631016] usbcore: registered new interface driver usbhid
> >>>[   29.631500] usbhid: USB HID core driver
> >>>[   29.640019] netem: version 1.3
> >>>[   29.640848] NET: Registered PF_INET6 protocol family
> >>>[   29.643109] Segment Routing with IPv6
> >>>[   29.643405] In-situ OAM (IOAM) with IPv6
> >>>[   29.643760] sit: IPv6, IPv4 and MPLS over IPv4 tunneling driver
> >>>[   29.645948] NET: Registered PF_PACKET protocol family
> >>>[   29.646371] NET: Registered PF_KEY protocol family
> >>>[   29.646805] sctp: Hash tables configured (bind 32/56)
> >>>[   29.647357] Key type dns_resolver registered
> >>>[   29.649453] IPI shorthand broadcast: enabled
> >>>[   29.649838] AVX2 version of gcm_enc/dec engaged.
> >>>[   29.650351] AES CTR mode by8 optimization enabled
> >>>[   29.651971] sched_clock: Marking stable (29586356484, 62931318)->(2=
9723854493, -74566691)
> >>>[   29.654238] Loading compiled-in X.509 certificates
> >>>[   29.655218] debug_vm_pgtable: [debug_vm_pgtable         ]: Validati=
ng architecture page table helpers
> >>>[   29.657030] Btrfs loaded, crc32c=3Dcrc32c-intel, zoned=3Dno, fsveri=
ty=3Dno
> >>>[   29.659515] ima: No TPM chip found, activating TPM-bypass!
> >>>[   29.660173] ima: Allocated hash algorithm: sha1
> >>>[   29.660593] ima: No architecture policies found
> >>>[   29.673045] ALSA device list:
> >>>[   29.673234]   #0: Virtual MIDI Card 1
> >>>[   29.682863] Freeing unused kernel image (initmem) memory: 2076K
> >>>[   29.717568] Write protecting the kernel read-only data: 61440k
> >>>[   29.721990] Freeing unused kernel image (text/rodata gap) memory: 2=
028K
> >>>[   29.724251] Freeing unused kernel image (rodata/data gap) memory: 9=
48K
> >>>[   29.727486] Run /init as init process
> >>>[   29.727944]   with arguments:
> >>>[   29.727947]     /init
> >>>[   29.727951]   with environment:
> >>>[   29.727954]     HOME=3D/
> >>>[   29.727957]     TERM=3Dlinux
> >>>[   29.727960]     BOOT_IMAGE=3D(hd0,msdos1)/vmlinuz-5.16.0-00002-g616=
758bf6583
> >>>[   29.727964]     resume=3D/dev/mapper/fedora-swap
> >>>[   29.803093] systemd[1]: systemd v246.13-1.fc33 running in system mo=
de. (+PAM +AUDIT +SELINUX +IMA -APPARMOR +SMACK +SYSVINIT +UTMP +LIBCRYPTSE=
TUP +GCRYPT +GNUTLS +ACL +XZ +LZ4 +ZSTD +SECCOMP +BLKID +ELFUTILS +KMOD +ID=
N2 -IDN +PCRE2 default-hierarchy=3Dunified)
> >>>[   29.806218] systemd[1]: Detected virtualization kvm.
> >>>[   29.806681] systemd[1]: Detected architecture x86-64.
> >>>[   29.807140] systemd[1]: Running in initial RAM disk.
> >>>[   29.809901] systemd[1]: Set hostname to <test1.fieldses.org>.
> >>>[   29.885369] systemd-hiberna (1054) used greatest stack depth: 28256=
 bytes left
> >>>[   29.979654] dracut-rootfs-g (1047) used greatest stack depth: 28216=
 bytes left
> >>>[   30.021117] systemd[1]: /usr/lib/systemd/system/plymouth-start.serv=
ice:15: Unit configured to use KillMode=3Dnone. This is unsafe, as it disab=
les systemd's process lifecycle management for the service. Please update y=
our service to use a safer KillMode=3D, such as 'mixed' or 'control-group'.=
 Support for KillMode=3Dnone is deprecated and will eventually be removed.
> >>>[   30.044537] systemd[1]: Queued start job for default target Initrd =
Default Target.
> >>>[   30.047340] systemd[1]: Created slice system-systemd\x2dhibernate\x=
2dresume.slice.
> >>>[   30.050175] systemd[1]: Reached target Slices.
> >>>[   30.051386] systemd[1]: Reached target Swap.
> >>>[   30.052613] systemd[1]: Reached target Timers.
> >>>[   30.054515] systemd[1]: Listening on Journal Audit Socket.
> >>>[   30.056550] systemd[1]: Listening on Journal Socket (/dev/log).
> >>>[   30.058686] systemd[1]: Listening on Journal Socket.
> >>>[   30.060760] systemd[1]: Listening on udev Control Socket.
> >>>[   30.063831] systemd[1]: Listening on udev Kernel Socket.
> >>>[   30.065248] systemd[1]: Reached target Sockets.
> >>>[   30.066604] systemd[1]: Condition check resulted in Create list of =
static device nodes for the current kernel being skipped.
> >>>[   30.071265] systemd[1]: Started Memstrack Anylazing Service.
> >>>[   30.077532] systemd[1]: Started Hardware RNG Entropy Gatherer Daemo=
n.
> >>>[   30.079586] systemd[1]: systemd-journald.service: unit configures a=
n IP firewall, but the local system does not support BPF/cgroup firewalling.
> >>>[   30.080901] systemd[1]: (This warning is only shown for the first u=
nit using IP firewalling.)
> >>>[   30.085726] systemd[1]: Starting Journal Service...
> >>>[   30.087684] systemd[1]: Condition check resulted in Load Kernel Mod=
ules being skipped.
> >>>[   30.089551] random: rngd: uninitialized urandom read (16 bytes read)
> >>>[   30.092470] systemd[1]: Starting Apply Kernel Variables...
> >>>[   30.098065] systemd[1]: Starting Create Static Device Nodes in /dev=
=2E..
> >>>[   30.117909] systemd[1]: Starting Setup Virtual Console...
> >>>[   30.149991] systemd[1]: Finished Create Static Device Nodes in /dev.
> >>>[   30.159172] systemd[1]: memstrack.service: Succeeded.
> >>>[   30.198818] systemd[1]: Finished Apply Kernel Variables.
> >>>[   30.200519] audit: type=3D1130 audit(1642005725.913:2): pid=3D1 uid=
=3D0 auid=3D4294967295 ses=3D4294967295 subj=3Dkernel msg=3D'unit=3Dsystemd=
-sysctl comm=3D"systemd" exe=3D"/usr/lib/systemd/systemd" hostname=3D? addr=
=3D? terminal=3D? res=3Dsuccess'
> >>>[   30.227486] input: ImExPS/2 Generic Explorer Mouse as /devices/plat=
form/i8042/serio1/input/input4
> >>>[   30.460095] systemd[1]: Started Journal Service.
> >>>[   30.461750] audit: type=3D1130 audit(1642005726.177:3): pid=3D1 uid=
=3D0 auid=3D4294967295 ses=3D4294967295 subj=3Dkernel msg=3D'unit=3Dsystemd=
-journald comm=3D"systemd" exe=3D"/usr/lib/systemd/systemd" hostname=3D? ad=
dr=3D? terminal=3D? res=3Dsuccess'
> >>>[   30.803462] audit: type=3D1130 audit(1642005726.517:4): pid=3D1 uid=
=3D0 auid=3D4294967295 ses=3D4294967295 subj=3Dkernel msg=3D'unit=3Dsystemd=
-vconsole-setup comm=3D"systemd" exe=3D"/usr/lib/systemd/systemd" hostname=
=3D? addr=3D? terminal=3D? res=3Dsuccess'
> >>>[   31.357792] random: crng init done
> >>>[   31.748912] dracut-cmdline (1106) used greatest stack depth: 27968 =
bytes left
> >>>[   31.752614] audit: type=3D1130 audit(1642005727.465:5): pid=3D1 uid=
=3D0 auid=3D4294967295 ses=3D4294967295 subj=3Dkernel msg=3D'unit=3Ddracut-=
cmdline comm=3D"systemd" exe=3D"/usr/lib/systemd/systemd" hostname=3D? addr=
=3D? terminal=3D? res=3Dsuccess'
> >>>[   32.032836] audit: type=3D1130 audit(1642005727.745:6): pid=3D1 uid=
=3D0 auid=3D4294967295 ses=3D4294967295 subj=3Dkernel msg=3D'unit=3Ddracut-=
pre-udev comm=3D"systemd" exe=3D"/usr/lib/systemd/systemd" hostname=3D? add=
r=3D? terminal=3D? res=3Dsuccess'
> >>>[   32.157892] audit: type=3D1130 audit(1642005727.873:7): pid=3D1 uid=
=3D0 auid=3D4294967295 ses=3D4294967295 subj=3Dkernel msg=3D'unit=3Dsystemd=
-udevd comm=3D"systemd" exe=3D"/usr/lib/systemd/systemd" hostname=3D? addr=
=3D? terminal=3D? res=3Dsuccess'
> >>>[   34.122946] virtio_net virtio0 enp0s3: renamed from eth0
> >>>[   34.168250] kworker/u8:4 (1729) used greatest stack depth: 27536 by=
tes left
> >>>[   34.330444] ata_id (1886) used greatest stack depth: 26656 bytes le=
ft
> >>>[   34.467966] audit: type=3D1130 audit(1642005730.181:8): pid=3D1 uid=
=3D0 auid=3D4294967295 ses=3D4294967295 subj=3Dkernel msg=3D'unit=3Dsystemd=
-udev-trigger comm=3D"systemd" exe=3D"/usr/lib/systemd/systemd" hostname=3D=
? addr=3D? terminal=3D? res=3Dsuccess'
> >>>[   34.581444] audit: type=3D1130 audit(1642005730.293:9): pid=3D1 uid=
=3D0 auid=3D4294967295 ses=3D4294967295 subj=3Dkernel msg=3D'unit=3Dplymout=
h-start comm=3D"systemd" exe=3D"/usr/lib/systemd/systemd" hostname=3D? addr=
=3D? terminal=3D? res=3Dsuccess'
> >>>[   35.924826] audit: type=3D1130 audit(1642005731.637:10): pid=3D1 ui=
d=3D0 auid=3D4294967295 ses=3D4294967295 subj=3Dkernel msg=3D'unit=3Dsystem=
d-hibernate-resume@dev-mapper-fedora\x2dswap comm=3D"systemd" exe=3D"/usr/l=
ib/systemd/systemd" hostname=3D? addr=3D? terminal=3D? res=3Dfailed'
> >>>[   35.979064] audit: type=3D1130 audit(1642005731.693:11): pid=3D1 ui=
d=3D0 auid=3D4294967295 ses=3D4294967295 subj=3Dkernel msg=3D'unit=3Dsystem=
d-tmpfiles-setup comm=3D"systemd" exe=3D"/usr/lib/systemd/systemd" hostname=
=3D? addr=3D? terminal=3D? res=3Dsuccess'
> >>>[   36.080161] audit: type=3D1130 audit(1642005731.793:12): pid=3D1 ui=
d=3D0 auid=3D4294967295 ses=3D4294967295 subj=3Dkernel msg=3D'unit=3Ddracut=
-initqueue comm=3D"systemd" exe=3D"/usr/lib/systemd/systemd" hostname=3D? a=
ddr=3D? terminal=3D? res=3Dsuccess'
> >>>[   36.137141] fsck (2468) used greatest stack depth: 26560 bytes left
> >>>[   36.142664] audit: type=3D1130 audit(1642005731.857:13): pid=3D1 ui=
d=3D0 auid=3D4294967295 ses=3D4294967295 subj=3Dkernel msg=3D'unit=3Dsystem=
d-fsck-root comm=3D"systemd" exe=3D"/usr/lib/systemd/systemd" hostname=3D? =
addr=3D? terminal=3D? res=3Dsuccess'
> >>>[   36.170836] XFS (dm-0): Mounting V5 Filesystem
> >>>[   36.314126] XFS (dm-0): Ending clean mount
> >>>[   36.383563] mount (2470) used greatest stack depth: 25344 bytes left
> >>>[   36.491652] systemd-fstab-g (2483) used greatest stack depth: 25008=
 bytes left
> >>>[   37.102323] audit: type=3D1130 audit(1642005732.817:14): pid=3D1 ui=
d=3D0 auid=3D4294967295 ses=3D4294967295 subj=3Dkernel msg=3D'unit=3Dinitrd=
-parse-etc comm=3D"systemd" exe=3D"/usr/lib/systemd/systemd" hostname=3D? a=
ddr=3D? terminal=3D? res=3Dsuccess'
> >>>[   37.104426] audit: type=3D1131 audit(1642005732.817:15): pid=3D1 ui=
d=3D0 auid=3D4294967295 ses=3D4294967295 subj=3Dkernel msg=3D'unit=3Dinitrd=
-parse-etc comm=3D"systemd" exe=3D"/usr/lib/systemd/systemd" hostname=3D? a=
ddr=3D? terminal=3D? res=3Dsuccess'
> >>>[   37.254915] audit: type=3D1130 audit(1642005732.969:16): pid=3D1 ui=
d=3D0 auid=3D4294967295 ses=3D4294967295 subj=3Dkernel msg=3D'unit=3Ddracut=
-pre-pivot comm=3D"systemd" exe=3D"/usr/lib/systemd/systemd" hostname=3D? a=
ddr=3D? terminal=3D? res=3Dsuccess'
> >>>[   37.290146] audit: type=3D1131 audit(1642005733.005:17): pid=3D1 ui=
d=3D0 auid=3D4294967295 ses=3D4294967295 subj=3Dkernel msg=3D'unit=3Ddracut=
-pre-pivot comm=3D"systemd" exe=3D"/usr/lib/systemd/systemd" hostname=3D? a=
ddr=3D? terminal=3D? res=3Dsuccess'
> >>>[   37.296542] audit: type=3D1131 audit(1642005733.009:18): pid=3D1 ui=
d=3D0 auid=3D4294967295 ses=3D4294967295 subj=3Dkernel msg=3D'unit=3Ddracut=
-initqueue comm=3D"systemd" exe=3D"/usr/lib/systemd/systemd" hostname=3D? a=
ddr=3D? terminal=3D? res=3Dsuccess'
> >>>[   37.304265] audit: type=3D1131 audit(1642005733.017:19): pid=3D1 ui=
d=3D0 auid=3D4294967295 ses=3D4294967295 subj=3Dkernel msg=3D'unit=3Dsystem=
d-sysctl comm=3D"systemd" exe=3D"/usr/lib/systemd/systemd" hostname=3D? add=
r=3D? terminal=3D? res=3Dsuccess'
> >>>[   40.558013] SELinux:  Permission watch in class filesystem not defi=
ned in policy.
> >>>[   40.558745] SELinux:  Permission watch in class file not defined in=
 policy.
> >>>[   40.559313] SELinux:  Permission watch_mount in class file not defi=
ned in policy.
> >>>[   40.559934] SELinux:  Permission watch_sb in class file not defined=
 in policy.
> >>>[   40.560593] SELinux:  Permission watch_with_perm in class file not =
defined in policy.
> >>>[   40.561264] SELinux:  Permission watch_reads in class file not defi=
ned in policy.
> >>>[   40.561928] SELinux:  Permission watch in class dir not defined in =
policy.
> >>>[   40.562491] SELinux:  Permission watch_mount in class dir not defin=
ed in policy.
> >>>[   40.563098] SELinux:  Permission watch_sb in class dir not defined =
in policy.
> >>>[   40.563684] SELinux:  Permission watch_with_perm in class dir not d=
efined in policy.
> >>>[   40.564391] SELinux:  Permission watch_reads in class dir not defin=
ed in policy.
> >>>[   40.565023] SELinux:  Permission watch in class lnk_file not define=
d in policy.
> >>>[   40.565673] SELinux:  Permission watch_mount in class lnk_file not =
defined in policy.
> >>>[   40.566349] SELinux:  Permission watch_sb in class lnk_file not def=
ined in policy.
> >>>[   40.566973] SELinux:  Permission watch_with_perm in class lnk_file =
not defined in policy.
> >>>[   40.567658] SELinux:  Permission watch_reads in class lnk_file not =
defined in policy.
> >>>[   40.568356] SELinux:  Permission watch in class chr_file not define=
d in policy.
> >>>[   40.568977] SELinux:  Permission watch_mount in class chr_file not =
defined in policy.
> >>>[   40.569671] SELinux:  Permission watch_sb in class chr_file not def=
ined in policy.
> >>>[   40.570298] SELinux:  Permission watch_with_perm in class chr_file =
not defined in policy.
> >>>[   40.570986] SELinux:  Permission watch_reads in class chr_file not =
defined in policy.
> >>>[   40.571646] SELinux:  Permission watch in class blk_file not define=
d in policy.
> >>>[   40.572293] SELinux:  Permission watch_mount in class blk_file not =
defined in policy.
> >>>[   40.573045] SELinux:  Permission watch_sb in class blk_file not def=
ined in policy.
> >>>[   40.573722] SELinux:  Permission watch_with_perm in class blk_file =
not defined in policy.
> >>>[   40.574413] SELinux:  Permission watch_reads in class blk_file not =
defined in policy.
> >>>[   40.575086] SELinux:  Permission watch in class sock_file not defin=
ed in policy.
> >>>[   40.575697] SELinux:  Permission watch_mount in class sock_file not=
 defined in policy.
> >>>[   40.576405] SELinux:  Permission watch_sb in class sock_file not de=
fined in policy.
> >>>[   40.577058] SELinux:  Permission watch_with_perm in class sock_file=
 not defined in policy.
> >>>[   40.577794] SELinux:  Permission watch_reads in class sock_file not=
 defined in policy.
> >>>[   40.578458] SELinux:  Permission watch in class fifo_file not defin=
ed in policy.
> >>>[   40.579066] SELinux:  Permission watch_mount in class fifo_file not=
 defined in policy.
> >>>[   40.579727] SELinux:  Permission watch_sb in class fifo_file not de=
fined in policy.
> >>>[   40.580405] SELinux:  Permission watch_with_perm in class fifo_file=
 not defined in policy.
> >>>[   40.581116] SELinux:  Permission watch_reads in class fifo_file not=
 defined in policy.
> >>>[   40.581870] SELinux:  Permission perfmon in class capability2 not d=
efined in policy.
> >>>[   40.582516] SELinux:  Permission bpf in class capability2 not defin=
ed in policy.
> >>>[   40.583123] SELinux:  Permission checkpoint_restore in class capabi=
lity2 not defined in policy.
> >>>[   40.583865] SELinux:  Permission perfmon in class cap2_userns not d=
efined in policy.
> >>>[   40.584574] SELinux:  Permission bpf in class cap2_userns not defin=
ed in policy.
> >>>[   40.585208] SELinux:  Permission checkpoint_restore in class cap2_u=
serns not defined in policy.
> >>>[   40.586020] SELinux:  Class mctp_socket not defined in policy.
> >>>[   40.586482] SELinux:  Class perf_event not defined in policy.
> >>>[   40.586930] SELinux:  Class anon_inode not defined in policy.
> >>>[   40.587380] SELinux:  Class io_uring not defined in policy.
> >>>[   40.587811] SELinux: the above unknown classes and permissions will=
 be allowed
> >>>[   40.638612] SELinux:  policy capability network_peer_controls=3D1
> >>>[   40.639094] SELinux:  policy capability open_perms=3D1
> >>>[   40.639471] SELinux:  policy capability extended_socket_class=3D1
> >>>[   40.639937] SELinux:  policy capability always_check_network=3D0
> >>>[   40.640472] SELinux:  policy capability cgroup_seclabel=3D1
> >>>[   40.640907] SELinux:  policy capability nnp_nosuid_transition=3D1
> >>>[   40.641442] SELinux:  policy capability genfs_seclabel_symlinks=3D0
> >>>[   40.858863] systemd[1]: Successfully loaded SELinux policy in 2.430=
314s.
> >>>[   41.410189] systemd[1]: Relabelled /dev, /dev/shm, /run, /sys/fs/cg=
roup in 249.521ms.
> >>>[   41.418749] systemd[1]: systemd v246.13-1.fc33 running in system mo=
de. (+PAM +AUDIT +SELINUX +IMA -APPARMOR +SMACK +SYSVINIT +UTMP +LIBCRYPTSE=
TUP +GCRYPT +GNUTLS +ACL +XZ +LZ4 +ZSTD +SECCOMP +BLKID +ELFUTILS +KMOD +ID=
N2 -IDN +PCRE2 default-hierarchy=3Dunified)
> >>>[   41.421461] systemd[1]: Detected virtualization kvm.
> >>>[   41.421851] systemd[1]: Detected architecture x86-64.
> >>>[   41.439136] systemd[1]: Set hostname to <test1.fieldses.org>.
> >>>[   41.753375] lvmconfig (2543) used greatest stack depth: 24544 bytes=
 left
> >>>[   41.774174] grep (2557) used greatest stack depth: 24448 bytes left
> >>>[   41.800082] zram_generator::generator[2554]: Creating dev-zram0.swa=
p for /dev/zram0 (823MB)
> >>>[   41.850246] systemd-sysv-generator[2552]: SysV service '/etc/rc.d/i=
nit.d/network' lacks a native systemd unit file. Automatically generating a=
 unit file for compatibility. Please update package to include a native sys=
temd unit file, in order to make it more safe and robust.
> >>>[   42.699764] systemd[1]: /usr/lib/systemd/system/plymouth-start.serv=
ice:15: Unit configured to use KillMode=3Dnone. This is unsafe, as it disab=
les systemd's process lifecycle management for the service. Please update y=
our service to use a safer KillMode=3D, such as 'mixed' or 'control-group'.=
 Support for KillMode=3Dnone is deprecated and will eventually be removed.
> >>>[   42.961005] systemd[1]: /usr/lib/systemd/system/mcelog.service:8: S=
tandard output type syslog is obsolete, automatically updating to journal. =
Please update your unit file, and consider removing the setting altogether.
> >>>[   43.550746] kauditd_printk_skb: 13 callbacks suppressed
> >>>[   43.550750] audit: type=3D1131 audit(1642005739.265:33): pid=3D1 ui=
d=3D0 auid=3D4294967295 ses=3D4294967295 subj=3Dsystem_u:system_r:init_t:s0=
 msg=3D'unit=3Dsystemd-journald comm=3D"systemd" exe=3D"/usr/lib/systemd/sy=
stemd" hostname=3D? addr=3D? terminal=3D? res=3Dsuccess'
> >>>[   43.557309] systemd[1]: initrd-switch-root.service: Succeeded.
> >>>[   43.559018] systemd[1]: Stopped Switch Root.
> >>>[   43.559933] audit: type=3D1130 audit(1642005739.273:34): pid=3D1 ui=
d=3D0 auid=3D4294967295 ses=3D4294967295 subj=3Dsystem_u:system_r:init_t:s0=
 msg=3D'unit=3Dinitrd-switch-root comm=3D"systemd" exe=3D"/usr/lib/systemd/=
systemd" hostname=3D? addr=3D? terminal=3D? res=3Dsuccess'
> >>>[   43.562887] audit: type=3D1131 audit(1642005739.277:35): pid=3D1 ui=
d=3D0 auid=3D4294967295 ses=3D4294967295 subj=3Dsystem_u:system_r:init_t:s0=
 msg=3D'unit=3Dinitrd-switch-root comm=3D"systemd" exe=3D"/usr/lib/systemd/=
systemd" hostname=3D? addr=3D? terminal=3D? res=3Dsuccess'
> >>>[   43.563870] systemd[1]: systemd-journald.service: Scheduled restart=
 job, restart counter is at 1.
> >>>[   43.566772] systemd[1]: Created slice system-getty.slice.
> >>>[   43.568626] systemd[1]: Created slice system-modprobe.slice.
> >>>[   43.570533] systemd[1]: Created slice system-serial\x2dgetty.slice.
> >>>[   43.572518] systemd[1]: Created slice system-sshd\x2dkeygen.slice.
> >>>[   43.575249] systemd[1]: Created slice system-swap\x2dcreate.slice.
> >>>[   43.577790] systemd[1]: Created slice system-systemd\x2dfsck.slice.
> >>>[   43.580470] systemd[1]: Created slice User and Session Slice.
> >>>[   43.581081] systemd[1]: Condition check resulted in Dispatch Passwo=
rd Requests to Console Directory Watch being skipped.
> >>>[   43.583848] systemd[1]: Started Forward Password Requests to Wall D=
irectory Watch.
> >>>[   43.587144] systemd[1]: Set up automount Arbitrary Executable File =
Formats File System Automount Point.
> >>>[   43.588834] systemd[1]: Reached target Local Encrypted Volumes.
> >>>[   43.589488] systemd[1]: Stopped target Switch Root.
> >>>[   43.590478] systemd[1]: Stopped target Initrd File Systems.
> >>>[   43.591448] systemd[1]: Stopped target Initrd Root File System.
> >>>[   43.592607] systemd[1]: Reached target Paths.
> >>>[   43.593681] systemd[1]: Reached target Slices.
> >>>[   43.595921] systemd[1]: Listening on Device-mapper event daemon FIF=
Os.
> >>>[   43.599288] systemd[1]: Listening on LVM2 poll daemon socket.
> >>>[   43.603589] systemd[1]: Listening on RPCbind Server Activation Sock=
et.
> >>>[   43.604301] systemd[1]: Reached target RPC Port Mapper.
> >>>[   43.621281] systemd[1]: Listening on Process Core Dump Socket.
> >>>[   43.623666] systemd[1]: Listening on initctl Compatibility Named Pi=
pe.
> >>>[   43.639128] systemd[1]: Listening on udev Control Socket.
> >>>[   43.641921] systemd[1]: Listening on udev Kernel Socket.
> >>>[   43.648355] systemd[1]: Activating swap /dev/mapper/fedora-swap...
> >>>[   43.654892] systemd[1]: Mounting Huge Pages File System...
> >>>[   43.661099] systemd[1]: Mounting POSIX Message Queue File System...
> >>>[   43.667262] systemd[1]: Mounting NFSD configuration filesystem...
> >>>[   43.676216] systemd[1]: Mounting Kernel Debug File System...
> >>>[   43.682222] Adding 839676k swap on /dev/mapper/fedora-swap.  Priori=
ty:-2 extents:1 across:839676k
> >>>[   43.684653] systemd[1]: Starting Kernel Module supporting RPCSEC_GS=
S...
> >>>[   43.686822] systemd[1]: Condition check resulted in Create list of =
static device nodes for the current kernel being skipped.
> >>>[   43.696795] systemd[1]: Starting Monitoring of LVM2 mirrors, snapsh=
ots etc. using dmeventd or progress polling...
> >>>[   43.703564] systemd[1]: Starting Load Kernel Module configfs...
> >>>[   43.711831] systemd[1]: Starting Load Kernel Module drm...
> >>>[   43.721843] systemd[1]: Starting Load Kernel Module fuse...
> >>>[   43.735057] systemd[1]: Starting Preprocess NFS configuration conve=
rtion...
> >>>[   43.739099] systemd[1]: plymouth-switch-root.service: Succeeded.
> >>>[   43.742433] systemd[1]: Stopped Plymouth switch root service.
> >>>[   43.744497] audit: type=3D1131 audit(1642005739.457:36): pid=3D1 ui=
d=3D0 auid=3D4294967295 ses=3D4294967295 subj=3Dsystem_u:system_r:init_t:s0=
 msg=3D'unit=3Dplymouth-switch-root comm=3D"systemd" exe=3D"/usr/lib/system=
d/systemd" hostname=3D? addr=3D? terminal=3D? res=3Dsuccess'
> >>>[   43.751143] systemd[1]: Starting Create swap on /dev/zram0...
> >>>[   43.752961] systemd[1]: Condition check resulted in Set Up Addition=
al Binary Formats being skipped.
> >>>[   43.755225] systemd[1]: systemd-fsck-root.service: Succeeded.
> >>>[   43.758291] systemd[1]: Stopped File System Check on Root Device.
> >>>[   43.759755] audit: type=3D1131 audit(1642005739.473:37): pid=3D1 ui=
d=3D0 auid=3D4294967295 ses=3D4294967295 subj=3Dsystem_u:system_r:init_t:s0=
 msg=3D'unit=3Dsystemd-fsck-root comm=3D"systemd" exe=3D"/usr/lib/systemd/s=
ystemd" hostname=3D? addr=3D? terminal=3D? res=3Dsuccess'
> >>>[   43.759862] systemd[1]: Stopped Journal Service.
> >>>[   43.766144] audit: type=3D1130 audit(1642005739.481:38): pid=3D1 ui=
d=3D0 auid=3D4294967295 ses=3D4294967295 subj=3Dsystem_u:system_r:init_t:s0=
 msg=3D'unit=3Dsystemd-journald comm=3D"systemd" exe=3D"/usr/lib/systemd/sy=
stemd" hostname=3D? addr=3D? terminal=3D? res=3Dsuccess'
> >>>[   43.770089] audit: type=3D1131 audit(1642005739.481:39): pid=3D1 ui=
d=3D0 auid=3D4294967295 ses=3D4294967295 subj=3Dsystem_u:system_r:init_t:s0=
 msg=3D'unit=3Dsystemd-journald comm=3D"systemd" exe=3D"/usr/lib/systemd/sy=
stemd" hostname=3D? addr=3D? terminal=3D? res=3Dsuccess'
> >>>[   43.785015] systemd[1]: Starting Journal Service...
> >>>[   43.786753] systemd[1]: Condition check resulted in Load Kernel Mod=
ules being skipped.
> >>>[   43.788967] zram0: detected capacity change from 0 to 1685504
> >>>[   43.792217] systemd[1]: Starting Remount Root and Kernel File Syste=
ms...
> >>>[   43.793231] systemd[1]: Condition check resulted in Repartition Roo=
t Disk being skipped.
> >>>[   43.799775] systemd[1]: Starting Apply Kernel Variables...
> >>>[   43.830240] systemd[1]: Starting Coldplug All udev Devices...
> >>>[   43.833802] systemd[1]: sysroot.mount: Succeeded.
> >>>[   43.838089] RPC: Registered named UNIX socket transport module.
> >>>[   43.838642] RPC: Registered udp transport module.
> >>>[   43.838999] RPC: Registered tcp transport module.
> >>>[   43.839369] RPC: Registered tcp NFSv4.1 backchannel transport modul=
e.
> >>>[   43.854269] systemd[1]: Activated swap /dev/mapper/fedora-swap.
> >>>[   43.871240] audit: type=3D1305 audit(1642005739.585:40): op=3Dset a=
udit_enabled=3D1 old=3D1 auid=3D4294967295 ses=3D4294967295 subj=3Dsystem_u=
:system_r:syslogd_t:s0 res=3D1
> >>>[   43.872637] audit: type=3D1300 audit(1642005739.585:40): arch=3Dc00=
0003e syscall=3D46 success=3Dyes exit=3D60 a0=3D5 a1=3D7ffd304bc550 a2=3D40=
00 a3=3D7ffd304bc5fc items=3D0 ppid=3D1 pid=3D2572 auid=3D4294967295 uid=3D=
0 gid=3D0 euid=3D0 suid=3D0 fsuid=3D0 egid=3D0 sgid=3D0 fsgid=3D0 tty=3D(no=
ne) ses=3D4294967295 comm=3D"systemd-journal" exe=3D"/usr/lib/systemd/syste=
md-journald" subj=3Dsystem_u:system_r:syslogd_t:s0 key=3D(null)
> >>>[   43.876478] audit: type=3D1327 audit(1642005739.585:40): proctitle=
=3D"/usr/lib/systemd/systemd-journald"
> >>>[   43.882944] systemd[1]: Mounted Huge Pages File System.
> >>>[   43.886495] xfs filesystem being remounted at / supports timestamps=
 until 2038 (0x7fffffff)
> >>>[   43.895767] systemd[1]: Started Journal Service.
> >>>[   43.974904] Adding 842748k swap on /dev/zram0.  Priority:100 extent=
s:1 across:842748k SS
> >>>[   43.996937] Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
> >>>[   46.194003] BTRFS: device fsid 27379e6a-3b97-45ef-bf83-dc7e8178b695=
 devid 1 transid 865 /dev/vde scanned by systemd-udevd (3767)
> >>>[   47.371666] FAT-fs (vdg): Volume was not properly unmounted. Some d=
ata may be corrupt. Please run fsck.
> >>>[   47.378054] XFS (vdb): Mounting V5 Filesystem
> >>>[   47.384999] XFS (vdf): Mounting V5 Filesystem
> >>>[   47.404867] EXT4-fs (vdd): mounted filesystem with ordered data mod=
e. Opts: (null). Quota mode: none.
> >>>[   47.576714] EXT4-fs (vda1): mounted filesystem with ordered data mo=
de. Opts: (null). Quota mode: none.
> >>>[   48.050435] XFS (vdf): Ending clean mount
> >>>[   48.091447] XFS (vdb): Ending clean mount
> >>>[   48.100548] xfs filesystem being mounted at /exports/xfs2 supports =
timestamps until 2038 (0x7fffffff)
> >>>[   48.102015] xfs filesystem being mounted at /exports/xfs supports t=
imestamps until 2038 (0x7fffffff)
> >>>[   48.600280] kauditd_printk_skb: 40 callbacks suppressed
> >>>[   48.600285] audit: type=3D1130 audit(1642005744.313:73): pid=3D1 ui=
d=3D0 auid=3D4294967295 ses=3D4294967295 subj=3Dsystem_u:system_r:init_t:s0=
 msg=3D'unit=3Dnfs-idmapd comm=3D"systemd" exe=3D"/usr/lib/systemd/systemd"=
 hostname=3D? addr=3D? terminal=3D? res=3Dsuccess'
> >>>[   48.650555] audit: type=3D1400 audit(1642005744.365:74): avc:  deni=
ed  { map } for  pid=3D3849 comm=3D"nfsdcld" path=3D"/var/lib/nfs/nfsdcld/m=
ain.sqlite-shm" dev=3D"dm-0" ino=3D873070 scontext=3Dsystem_u:system_r:init=
_t:s0 tcontext=3Dsystem_u:object_r:var_lib_nfs_t:s0 tclass=3Dfile permissiv=
e=3D1
> >>>[   48.655197] audit: type=3D1300 audit(1642005744.365:74): arch=3Dc00=
0003e syscall=3D9 success=3Dyes exit=3D140401715851264 a0=3D0 a1=3D8000 a2=
=3D3 a3=3D1 items=3D0 ppid=3D1 pid=3D3849 auid=3D4294967295 uid=3D0 gid=3D0=
 euid=3D0 suid=3D0 fsuid=3D0 egid=3D0 sgid=3D0 fsgid=3D0 tty=3D(none) ses=
=3D4294967295 comm=3D"nfsdcld" exe=3D"/root/nfsdcld" subj=3Dsystem_u:system=
_r:init_t:s0 key=3D(null)
> >>>[   48.659212] audit: type=3D1327 audit(1642005744.365:74): proctitle=
=3D"/root/nfsdcld"
> >>>[   48.662263] audit: type=3D1305 audit(1642005744.377:75): op=3Dset a=
udit_enabled=3D1 old=3D1 auid=3D4294967295 ses=3D4294967295 subj=3Dsystem_u=
:system_r:auditd_t:s0 res=3D1
> >>>[   48.663809] audit: type=3D1300 audit(1642005744.377:75): arch=3Dc00=
0003e syscall=3D44 success=3Dyes exit=3D60 a0=3D3 a1=3D7ffd61589d20 a2=3D3c=
 a3=3D0 items=3D0 ppid=3D3844 pid=3D3850 auid=3D4294967295 uid=3D0 gid=3D0 =
euid=3D0 suid=3D0 fsuid=3D0 egid=3D0 sgid=3D0 fsgid=3D0 tty=3D(none) ses=3D=
4294967295 comm=3D"auditd" exe=3D"/usr/sbin/auditd" subj=3Dsystem_u:system_=
r:auditd_t:s0 key=3D(null)
> >>>[   48.668534] audit: type=3D1327 audit(1642005744.377:75): proctitle=
=3D"/sbin/auditd"
> >>>[   48.669369] audit: type=3D1305 audit(1642005744.377:76): op=3Dset a=
udit_pid=3D3850 old=3D0 auid=3D4294967295 ses=3D4294967295 subj=3Dsystem_u:=
system_r:auditd_t:s0 res=3D1
> >>>[   48.670842] audit: type=3D1300 audit(1642005744.377:76): arch=3Dc00=
0003e syscall=3D44 success=3Dyes exit=3D60 a0=3D3 a1=3D7ffd615879d0 a2=3D3c=
 a3=3D0 items=3D0 ppid=3D3844 pid=3D3850 auid=3D4294967295 uid=3D0 gid=3D0 =
euid=3D0 suid=3D0 fsuid=3D0 egid=3D0 sgid=3D0 fsgid=3D0 tty=3D(none) ses=3D=
4294967295 comm=3D"auditd" exe=3D"/usr/sbin/auditd" subj=3Dsystem_u:system_=
r:auditd_t:s0 key=3D(null)
> >>>[   48.673934] audit: type=3D1327 audit(1642005744.377:76): proctitle=
=3D"/sbin/auditd"
> >>>[   51.467504] plymouthd (2385) used greatest stack depth: 24080 bytes=
 left
> >>>[   52.964929] NFSD: Using nfsdcld client tracking operations.
> >>>[   52.965487] NFSD: no clients to reclaim, skipping NFSv4 grace perio=
d (net f0000098)
> >>>[   57.672761] rpm (4068) used greatest stack depth: 22976 bytes left
> >>>[  201.516445] clocksource: timekeeping watchdog on CPU2: acpi_pm retr=
ied 2 times before success
> >>>
> >>>[  335.595143] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >>>[  335.596176] WARNING: possible circular locking dependency detected
> >>>[  335.597128] 5.16.0-00002-g616758bf6583 #1278 Not tainted
> >>>[  335.597903] ------------------------------------------------------
> >>>[  335.598845] kworker/u8:0/7 is trying to acquire lock:
> >>>[  335.599582] ffff888010393b60 (&clp->cl_lock){+.+.}-{2:2}, at: laund=
romat_main+0x177d/0x23b0 [nfsd]
> >>>[  335.601111]
> >>>                but task is already holding lock:
> >>>[  335.601750] ffff888010393e18 (&clp->cl_cs_lock){+.+.}-{2:2}, at: la=
undromat_main+0x33e/0x23b0 [nfsd]
> >>>[  335.602896]
> >>>                which lock already depends on the new lock.
> >>>
> >>>[  335.603378]
> >>>                the existing dependency chain (in reverse order) is:
> >>>[  335.603897]
> >>>                -> #2 (&clp->cl_cs_lock){+.+.}-{2:2}:
> >>>[  335.604305]        _raw_spin_lock+0x2f/0x40
> >>>[  335.604622]        nfsd4_fl_expire_lock+0x7a/0x330 [nfsd]
> >>>[  335.605078]        posix_lock_inode+0x9b8/0x1a50
> >>>[  335.605442]        nfsd4_lock+0xe33/0x3d20 [nfsd]
> >>>[  335.605827]        nfsd4_proc_compound+0xcef/0x21e0 [nfsd]
> >>>[  335.606289]        nfsd_dispatch+0x4b8/0xbd0 [nfsd]
> >>>[  335.606692]        svc_process_common+0xd56/0x1ac0 [sunrpc]
> >>>[  335.607188]        svc_process+0x32e/0x4a0 [sunrpc]
> >>>[  335.607604]        nfsd+0x306/0x530 [nfsd]
> >>>[  335.607923]        kthread+0x3b1/0x490
> >>>[  335.608199]        ret_from_fork+0x22/0x30
> >>>[  335.608512]
> >>>                -> #1 (&ctx->flc_lock){+.+.}-{2:2}:
> >>>[  335.608878]        _raw_spin_lock+0x2f/0x40
> >>>[  335.609187]        check_for_locks+0xcf/0x200 [nfsd]
> >>>[  335.609602]        nfsd4_release_lockowner+0x583/0xa20 [nfsd]
> >>>[  335.610093]        nfsd4_proc_compound+0xcef/0x21e0 [nfsd]
> >>>[  335.610564]        nfsd_dispatch+0x4b8/0xbd0 [nfsd]
> >>>[  335.610963]        svc_process_common+0xd56/0x1ac0 [sunrpc]
> >>>[  335.611450]        svc_process+0x32e/0x4a0 [sunrpc]
> >>>[  335.611863]        nfsd+0x306/0x530 [nfsd]
> >>>[  335.612193]        kthread+0x3b1/0x490
> >>>[  335.612463]        ret_from_fork+0x22/0x30
> >>>[  335.612764]
> >>>                -> #0 (&clp->cl_lock){+.+.}-{2:2}:
> >>>[  335.613120]        __lock_acquire+0x29f8/0x5b80
> >>>[  335.613469]        lock_acquire+0x1a6/0x4b0
> >>>[  335.613763]        _raw_spin_lock+0x2f/0x40
> >>>[  335.614057]        laundromat_main+0x177d/0x23b0 [nfsd]
> >>>[  335.614477]        process_one_work+0x7ec/0x1320
> >>>[  335.614813]        worker_thread+0x59e/0xf90
> >>>[  335.615135]        kthread+0x3b1/0x490
> >>>[  335.615409]        ret_from_fork+0x22/0x30
> >>>[  335.615695]
> >>>                other info that might help us debug this:
> >>>
> >>>[  335.616135] Chain exists of:
> >>>                  &clp->cl_lock --> &ctx->flc_lock --> &clp->cl_cs_lock
> >>>
> >>>[  335.616806]  Possible unsafe locking scenario:
> >>>
> >>>[  335.617140]        CPU0                    CPU1
> >>>[  335.617467]        ----                    ----
> >>>[  335.617793]   lock(&clp->cl_cs_lock);
> >>>[  335.618036]                                lock(&ctx->flc_lock);
> >>>[  335.618531]                                lock(&clp->cl_cs_lock);
> >>>[  335.619037]   lock(&clp->cl_lock);
> >>>[  335.619256]
> >>>                 *** DEADLOCK ***
> >>>
> >>>[  335.619487] 4 locks held by kworker/u8:0/7:
> >>>[  335.619780]  #0: ffff88800ca5b138 ((wq_completion)nfsd4){+.+.}-{0:0=
}, at: process_one_work+0x6f5/0x1320
> >>>[  335.620619]  #1: ffff88800776fdd8 ((work_completion)(&(&nn->laundro=
mat_work)->work)){+.+.}-{0:0}, at: process_one_work+0x723/0x1320
> >>>[  335.621657]  #2: ffff888008a4c190 (&nn->client_lock){+.+.}-{2:2}, a=
t: laundromat_main+0x2b4/0x23b0 [nfsd]
> >>>[  335.622499]  #3: ffff888010393e18 (&clp->cl_cs_lock){+.+.}-{2:2}, a=
t: laundromat_main+0x33e/0x23b0 [nfsd]
> >>>[  335.623462]
> >>>                stack backtrace:
> >>>[  335.623648] CPU: 2 PID: 7 Comm: kworker/u8:0 Not tainted 5.16.0-000=
02-g616758bf6583 #1278
> >>>[  335.624364] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), =
BIOS 1.14.0-6.fc35 04/01/2014
> >>>[  335.625124] Workqueue: nfsd4 laundromat_main [nfsd]
> >>>[  335.625514] Call Trace:
> >>>[  335.625641]  <TASK>
> >>>[  335.625734]  dump_stack_lvl+0x45/0x59
> >>>[  335.625981]  check_noncircular+0x23e/0x2e0
> >>>[  335.626268]  ? print_circular_bug+0x450/0x450
> >>>[  335.626583]  ? mark_lock+0xf1/0x30c0
> >>>[  335.626821]  ? alloc_chain_hlocks+0x1e6/0x590
> >>>[  335.627156]  __lock_acquire+0x29f8/0x5b80
> >>>[  335.627463]  ? lock_chain_count+0x20/0x20
> >>>[  335.627740]  ? lockdep_hardirqs_on_prepare+0x400/0x400
> >>>[  335.628161]  ? lockdep_hardirqs_on_prepare+0x400/0x400
> >>>[  335.628555]  lock_acquire+0x1a6/0x4b0
> >>>[  335.628799]  ? laundromat_main+0x177d/0x23b0 [nfsd]
> >>>[  335.629184]  ? lock_release+0x6d0/0x6d0
> >>>[  335.629449]  ? laundromat_main+0x29c/0x23b0 [nfsd]
> >>>[  335.629825]  ? do_raw_spin_lock+0x11e/0x240
> >>>[  335.630120]  ? rwlock_bug.part.0+0x90/0x90
> >>>[  335.630409]  _raw_spin_lock+0x2f/0x40
> >>>[  335.630654]  ? laundromat_main+0x177d/0x23b0 [nfsd]
> >>>[  335.631058]  laundromat_main+0x177d/0x23b0 [nfsd]
> >>>[  335.631450]  ? lock_release+0x6d0/0x6d0
> >>>[  335.631712]  ? client_ctl_write+0x9f0/0x9f0 [nfsd]
> >>>[  335.632110]  process_one_work+0x7ec/0x1320
> >>>[  335.632411]  ? lock_release+0x6d0/0x6d0
> >>>[  335.632672]  ? pwq_dec_nr_in_flight+0x230/0x230
> >>>[  335.633002]  ? rwlock_bug.part.0+0x90/0x90
> >>>[  335.633290]  worker_thread+0x59e/0xf90
> >>>[  335.633548]  ? process_one_work+0x1320/0x1320
> >>>[  335.633860]  kthread+0x3b1/0x490
> >>>[  335.634082]  ? _raw_spin_unlock_irq+0x24/0x50
> >>>[  335.634396]  ? set_kthread_struct+0x100/0x100
> >>>[  335.634709]  ret_from_fork+0x22/0x30
> >>>[  335.634961]  </TASK>
> >>>[  751.568771] nfsd (4021) used greatest stack depth: 21792 bytes left
> >>>[  751.769042] nfsd: last server has exited, flushing export cache
> >>>[  751.957555] NFSD: Using nfsdcld client tracking operations.
> >>>[  751.958050] NFSD: starting 15-second grace period (net f0000098)
> >>>[  773.101065] nfsd: last server has exited, flushing export cache
> >>>[  773.341554] NFSD: Using nfsdcld client tracking operations.
> >>>[  773.342404] NFSD: starting 15-second grace period (net f0000098)
> >>>[  795.757041] nfsd: last server has exited, flushing export cache
> >>>[  795.881057] NFSD: Using nfsdcld client tracking operations.
> >>>[  795.881637] NFSD: starting 15-second grace period (net f0000098)
> >>>[  816.968871] nfsd: last server has exited, flushing export cache
> >>>[  817.199987] NFSD: Using nfsdcld client tracking operations.
> >>>[  817.201123] NFSD: starting 15-second grace period (net f0000098)
> >>>[  817.696746] nfsd: last server has exited, flushing export cache
> >>>[  817.925616] NFSD: Using nfsdcld client tracking operations.
> >>>[  817.926073] NFSD: starting 15-second grace period (net f0000098)
> >>>[  839.080820] nfsd: last server has exited, flushing export cache
> >>>[  839.321569] NFSD: Using nfsdcld client tracking operations.
> >>>[  839.322562] NFSD: starting 15-second grace period (net f0000098)
> >>>[  860.492782] nfsd: last server has exited, flushing export cache
> >>>[  860.749705] NFSD: Using nfsdcld client tracking operations.
> >>>[  860.751710] NFSD: starting 15-second grace period (net f0000098)
> >>>[  882.889711] nfsd: last server has exited, flushing export cache
> >>>[  883.125502] NFSD: Using nfsdcld client tracking operations.
> >>>[  883.126399] NFSD: starting 15-second grace period (net f0000098)
> >>>[  904.224662] nfsd: last server has exited, flushing export cache
> >>>[  904.342387] NFSD: Using nfsdcld client tracking operations.
> >>>[  904.342962] NFSD: starting 15-second grace period (net f0000098)
> >>>[  947.528620] nfsd: last server has exited, flushing export cache
> >>>[  947.763520] NFSD: Using nfsdcld client tracking operations.
> >>>[  947.764569] NFSD: starting 15-second grace period (net f0000098)
> >>>[ 1442.187410] nfsd: last server has exited, flushing export cache
> >>>[ 1442.430496] NFSD: Using nfsdcld client tracking operations.
> >>>[ 1442.430974] NFSD: starting 15-second grace period (net f0000098)
> >>>[ 1483.739309] nfsd: last server has exited, flushing export cache
> >>>[ 1483.864102] NFSD: Using nfsdcld client tracking operations.
> >>>[ 1483.864606] NFSD: starting 15-second grace period (net f0000098)
> >>>[ 1486.644498] NFSD: all clients done reclaiming, ending NFSv4 grace p=
eriod (net f0000098)
> >>>[ 1490.023618] clocksource: timekeeping watchdog on CPU3: acpi_pm retr=
ied 2 times before success
> >>>[ 1508.807419] nfsd: last server has exited, flushing export cache
> >>>[ 1508.925396] NFSD: Using nfsdcld client tracking operations.
> >>>[ 1508.925905] NFSD: starting 15-second grace period (net f0000098)
> >>>[ 1509.412224] NFSD: all clients done reclaiming, ending NFSv4 grace p=
eriod (net f0000098)
> >>>[ 1530.667340] nfsd: last server has exited, flushing export cache
> >>>[ 1530.803387] NFSD: Using nfsdcld client tracking operations.
> >>>[ 1530.804150] NFSD: starting 15-second grace period (net f0000098)
> >>>[ 1531.185069] NFSD: all clients done reclaiming, ending NFSv4 grace p=
eriod (net f0000098)
> >>>[ 1552.563368] nfsd: last server has exited, flushing export cache
> >>>[ 1552.794957] NFSD: Using nfsdcld client tracking operations.
> >>>[ 1552.797092] NFSD: starting 15-second grace period (net f0000098)
> >>>[ 1573.931430] NFSD: all clients done reclaiming, ending NFSv4 grace p=
eriod (net f0000098)
> >>>[ 1594.943247] nfsd: last server has exited, flushing export cache
> >>>[ 1595.175609] NFSD: Using nfsdcld client tracking operations.
> >>>[ 1595.177610] NFSD: starting 15-second grace period (net f0000098)
> >>>[ 1595.277962] NFSD: all clients done reclaiming, ending NFSv4 grace p=
eriod (net f0000098)
> >>>[ 1618.323178] nfsd: last server has exited, flushing export cache
> >>>[ 1618.553210] NFSD: Using nfsdcld client tracking operations.
> >>>[ 1618.555049] NFSD: starting 15-second grace period (net f0000098)
> >>>[ 1620.455011] nfsd: last server has exited, flushing export cache
> >>>[ 1620.687824] NFSD: Using nfsdcld client tracking operations.
> >>>[ 1620.688329] NFSD: starting 15-second grace period (net f0000098)
> >>>[ 1660.003178] nfsd: last server has exited, flushing export cache
> >>>[ 1660.236374] NFSD: Using nfsdcld client tracking operations.
> >>>[ 1660.237760] NFSD: starting 15-second grace period (net f0000098)
> >>>[ 1660.842977] nfsd: last server has exited, flushing export cache
> >>>[ 1661.061619] NFSD: Using nfsdcld client tracking operations.
> >>>[ 1661.062070] NFSD: starting 15-second grace period (net f0000098)
> >>>[ 1661.440842] NFSD: all clients done reclaiming, ending NFSv4 grace p=
eriod (net f0000098)
> >>>[ 2704.041055] clocksource: timekeeping watchdog on CPU3: acpi_pm retr=
ied 2 times before success
> >>>[ 2712.517015] clocksource: timekeeping watchdog on CPU0: acpi_pm retr=
ied 2 times before success
> >>>[ 6066.999200] clocksource: timekeeping watchdog on CPU1: acpi_pm retr=
ied 2 times before success
> >>>
> >>>
> >>>I will update the
> >>>>Documentation/filesystems/locking.rst in v10.
> >>>>
> >>>>>I agree with Chuck that we don't need to reschedule the laundromat, =
it's
> >>>>>OK if it takes longer to get around to cleaning up a dead client.
> >>>>Yes, it is now implemented for lock conflict and share reservation
> >>>>resolution. I'm doing the same for delegation conflict.
> >>>>
> >>>>-Dai
> >>>>
> >>>>>--b.
> >>>>>
> >>>>>On Mon, Jan 10, 2022 at 10:50:51AM -0800, Dai Ngo wrote:
> >>>>>>Hi Bruce, Chuck
> >>>>>>
> >>>>>>This series of patches implement the NFSv4 Courteous Server.
> >>>>>>
> >>>>>>A server which does not immediately expunge the state on lease expi=
ration
> >>>>>>is known as a Courteous Server.  A Courteous Server continues to re=
cognize
> >>>>>>previously generated state tokens as valid until conflict arises be=
tween
> >>>>>>the expired state and the requests from another client, or the serv=
er
> >>>>>>reboots.
> >>>>>>
> >>>>>>The v2 patch includes the following:
> >>>>>>
> >>>>>>. add new callback, lm_expire_lock, to lock_manager_operations to
> >>>>>>   allow the lock manager to take appropriate action with conflict =
lock.
> >>>>>>
> >>>>>>. handle conflicts of NFSv4 locks with NFSv3/NLM and local locks.
> >>>>>>
> >>>>>>. expire courtesy client after 24hr if client has not reconnected.
> >>>>>>
> >>>>>>. do not allow expired client to become courtesy client if there are
> >>>>>>   waiters for client's locks.
> >>>>>>
> >>>>>>. modify client_info_show to show courtesy client and seconds from
> >>>>>>   last renew.
> >>>>>>
> >>>>>>. fix a problem with NFSv4.1 server where the it keeps returning
> >>>>>>   SEQ4_STATUS_CB_PATH_DOWN in the successful SEQUENCE reply, after
> >>>>>>   the courtesy client re-connects, causing the client to keep send=
ing
> >>>>>>   BCTS requests to server.
> >>>>>>
> >>>>>>The v3 patch includes the following:
> >>>>>>
> >>>>>>. modified posix_test_lock to check and resolve conflict locks
> >>>>>>   to handle NLM TEST and NFSv4 LOCKT requests.
> >>>>>>
> >>>>>>. separate out fix for back channel stuck in SEQ4_STATUS_CB_PATH_DO=
WN.
> >>>>>>
> >>>>>>The v4 patch includes:
> >>>>>>
> >>>>>>. rework nfsd_check_courtesy to avoid dead lock of fl_lock and clie=
nt_lock
> >>>>>>   by asking the laudromat thread to destroy the courtesy client.
> >>>>>>
> >>>>>>. handle NFSv4 share reservation conflicts with courtesy client. Th=
is
> >>>>>>   includes conflicts between access mode and deny mode and vice ve=
rsa.
> >>>>>>
> >>>>>>. drop the patch for back channel stuck in SEQ4_STATUS_CB_PATH_DOWN.
> >>>>>>
> >>>>>>The v5 patch includes:
> >>>>>>
> >>>>>>. fix recursive locking of file_rwsem from posix_lock_file.
> >>>>>>
> >>>>>>. retest with LOCKDEP enabled.
> >>>>>>
> >>>>>>The v6 patch includes:
> >>>>>>
> >>>>>>. merge witn 5.15-rc7
> >>>>>>
> >>>>>>. fix a bug in nfs4_check_deny_bmap that did not check for matched
> >>>>>>   nfs4_file before checking for access/deny conflict. This bug cau=
ses
> >>>>>>   pynfs OPEN18 to fail since the server taking too long to release
> >>>>>>   lots of un-conflict clients' state.
> >>>>>>
> >>>>>>. enhance share reservation conflict handler to handle case where
> >>>>>>   a large number of conflict courtesy clients need to be expired.
> >>>>>>   The 1st 100 clients are expired synchronously and the rest are
> >>>>>>   expired in the background by the laundromat and NFS4ERR_DELAY
> >>>>>>   is returned to the NFS client. This is needed to prevent the
> >>>>>>   NFS client from timing out waiting got the reply.
> >>>>>>
> >>>>>>The v7 patch includes:
> >>>>>>
> >>>>>>. Fix race condition in posix_test_lock and posix_lock_inode after
> >>>>>>   dropping spinlock.
> >>>>>>
> >>>>>>. Enhance nfsd4_fl_expire_lock to work with with new lm_expire_lock
> >>>>>>   callback
> >>>>>>
> >>>>>>. Always resolve share reservation conflicts asynchrously.
> >>>>>>
> >>>>>>. Fix bug in nfs4_laundromat where spinlock is not used when
> >>>>>>   scanning cl_ownerstr_hashtbl.
> >>>>>>
> >>>>>>. Fix bug in nfs4_laundromat where idr_get_next was called
> >>>>>>   with incorrect 'id'.
> >>>>>>
> >>>>>>. Merge nfs4_destroy_courtesy_client into nfsd4_fl_expire_lock.
> >>>>>>
> >>>>>>The v8 patch includes:
> >>>>>>
> >>>>>>. Fix warning in nfsd4_fl_expire_lock reported by test robot.
> >>>>>>
> >>>>>>The V9 patch include:
> >>>>>>
> >>>>>>. Simplify lm_expire_lock API by (1) remove the 'testonly' flag
> >>>>>>   and (2) specifying return value as true/false to indicate
> >>>>>>   whether conflict was succesfully resolved.
> >>>>>>
> >>>>>>. Rework nfsd4_fl_expire_lock to mark client with
> >>>>>>   NFSD4_DESTROY_COURTESY_CLIENT then tell the laundromat to expire
> >>>>>>   the client in the background.
> >>>>>>
> >>>>>>. Add a spinlock in nfs4_client to synchronize access to the
> >>>>>>   NFSD4_COURTESY_CLIENT and NFSD4_DESTROY_COURTESY_CLIENT flag to
> >>>>>>   handle race conditions when resolving lock and share reservation
> >>>>>>   conflict.
> >>>>>>
> >>>>>>. Courtesy client that was marked as NFSD4_DESTROY_COURTESY_CLIENT
> >>>>>>   are now consisdered 'dead', waiting for the laundromat to expire
> >>>>>>   it. This client is no longer allowed to use its states if it
> >>>>>>   re-connects before the laundromat finishes expiring the client.
> >>>>>>
> >>>>>>   For v4.1 client, the detection is done in the processing of the
> >>>>>>   SEQUENCE op and returns NFS4ERR_BAD_SESSION to force the client
> >>>>>>   to re-establish new clientid and session.
> >>>>>>   For v4.0 client, the detection is done in the processing of the
> >>>>>>   RENEW and state-related ops and return NFS4ERR_EXPIRE to force
> >>>>>>   the client to re-establish new clientid.
