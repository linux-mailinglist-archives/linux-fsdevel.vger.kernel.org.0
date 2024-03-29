Return-Path: <linux-fsdevel+bounces-15694-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0759689226A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Mar 2024 18:09:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F26A928796D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Mar 2024 17:09:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BD0685653;
	Fri, 29 Mar 2024 17:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="wI44bynk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84ED128DC0
	for <linux-fsdevel@vger.kernel.org>; Fri, 29 Mar 2024 17:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711732182; cv=none; b=sKBBfPOI+8ZLzn9O314LZOifi22ukVlLiAqgo4UQ5l3FFfo3Omhl/HrKisGQfDN+Lq0mHZu1l7K57HAakwjsJmjxdzNlGiKmsPAD/0sL7WfhapFIjO+1DBB0WFxBs0cmkPTfbbXT/Qovn/L8iHfmQ3kEzASlmXj9TvVRsp4C2hQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711732182; c=relaxed/simple;
	bh=VKPTP3q9hvCEIwdrl+c6GMT4FdGYAJ9INodRreMvE3U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g0SaCZNN13AaPwYor5FfPBiJ9dBbbc7IP+3Rqtj/LwSQWQcJli44HLdqF68+3cb1V4z6Hh5JY5t6GRMHkJsobWYDldV5N3UMEYw0MWdmbaCvtorY4K0v1slc/10tyL/nMEJZQ21NNY7S7kIc+qdYoOAiS+zgJqnx/ZePvqCvwtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=wI44bynk; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com [209.85.208.69])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 2C09842498
	for <linux-fsdevel@vger.kernel.org>; Fri, 29 Mar 2024 17:09:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1711732170;
	bh=E0YGgx3/QgFsNk08rbXK0tsAsAPg+FSnnHQ/PgTzsS0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=wI44bynk/xNgLgcn0hSLofA/Txn5rWJUkmiO/dLT3PvZ4qOmjmBDhXcorkALxfEmx
	 OLQ2vmfYLule2zonX6P4VrZ6dkTeYruFiAmrOX0dPuuWdEZZrKv1VUOUL8sxpFQKNJ
	 +Kn6Q8lLGKl4e3odZOcLzsXlgjBxhnKt/Sjvpz3BZS1s3iRBIzaGK9B+Gyk4AkvjEd
	 4syAUwwB0Syid/cac2KfDZlpBrqvw6SkkR4Jg3dHlg/ovmUkIhLnQUWWzydM5THk+t
	 QTrM5jjrBADcNs4dwCNmqhCIkCHAR1wzIRLPAzNocB+zrowWtY7ctDKi6LEfjXSjAn
	 SIB6FF+7gkm6w==
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-56bf2dbbaadso1427412a12.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 29 Mar 2024 10:09:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711732163; x=1712336963;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E0YGgx3/QgFsNk08rbXK0tsAsAPg+FSnnHQ/PgTzsS0=;
        b=TCfL2jGQvEDWdHPvH5w/E+Hy/sCsX1koG2vkXpuJZ91mLyjSmE4BVtJO3j92Y8zUVJ
         HnWHwQFg+opRaFljY0tnSDMPJFTmoxuGh6Hry60pRJ1EswWKpVkIOGeUOK/xePTUzdve
         w0I98dx1a/y39f6GkG27pBYSmBZio8cdnJqWH0c2oL8iwiGJy3SbcHugs/UnbP4ZjdZW
         YfhMMT+WosHuhEgEe7sVmgmcbWqQ+tL1Vsw7p32y7VloPHv6VZZbtz2+iD+Oc9s2cxM+
         JsGm5kzF1qOssiQzlRaPdE1+RThgfM06bqQ2SLeZmA8ub/NL6kO3WTS/vXcUt9Dum6IB
         soOw==
X-Forwarded-Encrypted: i=1; AJvYcCXjhjOmfRcFJI9C/kGju6GLQQTW8DgeVrb8IteuGpbgtw8fwTuc0Aynr7dmY79KbMUgJHkFFBB3A/uxDyb55kjRGDXomholQxjkUAh7LQ==
X-Gm-Message-State: AOJu0YyrHdONRgPNPPCKwCTxXWMzuBF5olyHQvUJWBz/qa45U5M4rZd4
	8eCjf3N1Gp5xyYQqbbYDgKNq8554j7/WavApeaCkE0aYng+V9GbrEbwhqy+1OLHkc/qdolZG2ux
	ulcMl5i0SAGB9XER/Zz5/c5a2+p2C8WnK0myifTlcVJiMzcVgvjGzgaabVdCvtYW3IgiVG4WXnx
	JDK9IWz5Og4NrUTHllNzDLnCrvq/8gpCjnYt4+L3pzPv82Uvz62KP2NQ==
X-Received: by 2002:a05:6402:348d:b0:56b:b5d6:1efc with SMTP id v13-20020a056402348d00b0056bb5d61efcmr2194835edc.18.1711732162706;
        Fri, 29 Mar 2024 10:09:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF4oIcC/jLWLVKBIl32bqPvF5BAFYyM3J4U5MY0PnOOXaXb8PkRwwUpMmNmj+w5L7DCYjwDJigdxxuXJLHh3mw=
X-Received: by 2002:a05:6402:348d:b0:56b:b5d6:1efc with SMTP id
 v13-20020a056402348d00b0056bb5d61efcmr2194820edc.18.1711732162225; Fri, 29
 Mar 2024 10:09:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <b8e4d93c-f2f2-4a0e-a47f-15a740434356@mitchellaugustin.com>
 <CAHTA-ubfwwB51A5Wg5M6H_rPEQK9pNf8FkAGH=vr=FEkyRrtqw@mail.gmail.com>
 <u7o6c74dsi3fxewhguinoy77dxgscsnmix5zzqqm2ckdcdiv2j@2g5zuy5vsudc> <CAHTA-uaQRS4E=hPsqf0V01x3ycd9LyCP5-Auqs1cP77bUpAEmg@mail.gmail.com>
In-Reply-To: <CAHTA-uaQRS4E=hPsqf0V01x3ycd9LyCP5-Auqs1cP77bUpAEmg@mail.gmail.com>
From: Mitchell Augustin <mitchell.augustin@canonical.com>
Date: Fri, 29 Mar 2024 12:09:10 -0500
Message-ID: <CAHTA-uZo15smL6f=S7kMcJiGMNjUQ7fZMj7-5e6is=2HUeYr-Q@mail.gmail.com>
Subject: Re: [PATCH] fs/aio: obey min_nr when doing wakeups
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: linux-aio@kvack.org, brauner@kernel.org, bcrl@kvack.org, 
	linux-fsdevel@vger.kernel.org, colin.i.king@gmail.com, 
	dann frazier <dann.frazier@canonical.com>, Ian May <ian.may@canonical.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I was able to reproduce this panic with the following ktest:

~/ktest/tests/stress_ng.ktest:

#!/usr/bin/env bash

. $(dirname $(readlink -e "${BASH_SOURCE[0]}"))/test-libs.sh

test_stressng()
{
    apt install stress-ng
    count=3D15
    for i in $(seq $count); do
        echo "Starting Stress #${i}/${count} for $(uname -r)"
        mkdir /tmp/kerneltest
        stress-ng --aggressive --verify --timeout 240 --temp-path
//tmp/kerneltest --hdd-opts dsync --readahead-bytes 16M -k --aiol 0
        rm -rf /tmp/kerneltest
        echo "Completed Stress #${i}/${count} for $(uname -r)"
    done
}

main "$@"

by running ~/ktest/build-test-kernel run -I ~/ktest/tests/stress_ng.ktest

Note that the panic may not necessarily happen on the first run of
that stress-ng command, so you might have to wait several iterations.

Panic:
Running test stress_ng.ktest on gunyolk at /home/ubuntu/upstream/linux
building kernel... done
Kernel version: 6.9.0-rc1-ktest-00061-g8d025e2092e2

Running tests stressng

=3D=3D=3D=3D=3D=3D=3D=3D=3D TEST   stressng

Reading package lists... Done
Building dependency tree... Done
Reading state information... Done
stress-ng is already the newest version (0.17.06-1).
0 upgraded, 0 newly installed, 0 to remove and 0 not upgraded.
Starting Stress #1/15 for 6.9.0-rc1-ktest-00061-g8d025e2092e2
stress-ng: info:  [426] setting to a 4 mins, 0 secs run per stressor
stress-ng: info:  [426] dispatching hogs: 16 aiol
platform kgdboc: deferred probe pending: (reason unknown)
Unable to handle kernel NULL pointer dereference at virtual address
00000000000006c4
Mem abort info:
  ESR =3D 0x0000000096000004
  EC =3D 0x25: DABT (current EL), IL =3D 32 bits
  SET =3D 0, FnV =3D 0
  EA =3D 0, S1PTW =3D 0
  FSC =3D 0x04: level 0 translation fault
Data abort info:
  ISV =3D 0, ISS =3D 0x00000004, ISS2 =3D 0x00000000
  CM =3D 0, WnR =3D 0, TnD =3D 0, TagAccess =3D 0
  GCS =3D 0, Overlay =3D 0, DirtyBit =3D 0, Xs =3D 0
user pgtable: 4k pages, 48-bit VAs, pgdp=3D0000000107097000
[00000000000006c4] pgd=3D0000000000000000, p4d=3D0000000000000000
Internal error: Oops: 0000000096000004 [#1] SMP
Modules linked in:
CPU: 5 PID: 1456 Comm: kworker/5:72 Not tainted
6.9.0-rc1-ktest-00061-g8d025e2092e2 #1
Hardware name: linux,dummy-virt (DT)
Workqueue: dio/vda iomap_dio_complete_work
pstate: 030010c5 (nzcv daIF -PAN -UAO +TCO +DIT +SSBS BTYPE=3D--)
pc : try_to_wake_up+0x4c/0x620
lr : wake_up_process+0x1c/0x30
sp : ffff0000c62dbca0
x29: ffff0000c62dbca0 x28: ffff0000d1b3b800 x27: ffff0000fbcdd0a8
x26: 0000000000000000 x25: ffff0000d1b3b840 x24: 00003e0040000000
x23: 00000000000006c4 x22: 00000000000000c0 x21: 0000000000000000
x20: 0000000000000003 x19: 0000000000000000 x18: 0000000000000000
x17: 0000000000000000 x16: ffff0000c7e01820 x15: 0000000000000000
x14: ffff0000fbce5508 x13: 0000000000000000 x12: 0000000000000000
x11: 00000000ffffffff x10: 0000000000000920 x9 : ffff800080069704
x8 : 0000000000000000 x7 : ffff0000c0e25f60 x6 : 00000000000000c0
x5 : 0000000000000004 x4 : 0000000000000000 x3 : 0000000000000001
x2 : 0000000000000000 x1 : 0000000000000003 x0 : ffff0000c6003d00
Call trace:
 try_to_wake_up+0x4c/0x620
 wake_up_process+0x1c/0x30
 aio_complete+0x1c0/0x250
 aio_complete_rw+0xf8/0x230
 iomap_dio_complete_work+0x34/0x48
 process_one_work+0x148/0x3a0
 worker_thread+0x290/0x470
 kthread+0xe0/0xf0
 ret_from_fork+0x10/0x20
Code: d50343df d2800002 52800023 f98002f1 (885ffee1)
---[ end trace 0000000000000000 ]---
Kernel panic - not syncing: Oops: Fatal exception
SMP: stopping secondary CPUs
SMP: failed to stop secondary CPUs 2,5
Kernel Offset: disabled
CPU features: 0x0,00000002,80013008,42425c03
Memory Limit: none
---[ end Kernel panic - not syncing: Oops: Fatal exception ]---

-Mitchell Augustin

On Thu, Mar 28, 2024 at 8:40=E2=80=AFPM Mitchell Augustin
<mitchell.augustin@canonical.com> wrote:
>
> @Ian May from our kernel team also mentioned early on that he thought
> this might be due to a race condition. I've added him to this thread
> in case he has any additional thoughts on that.
>
> I'll look into setting up a ktest environment to help reproduce this.
> In the meantime, here is the exact process I used that exposes the
> issue on Noble daily arm64+largemem
> (https://cdimage.ubuntu.com/ubuntu-server/daily-live/current/noble-live-s=
erver-arm64+largemem.iso)
> on our Grace machine:
>
> I'm not sure what differences there may be between different versions
> of stress-ng, but the version I am running is the one that comes with
> the following version of canonical-certification-server:
> canonical-certification-server/noble,now 3.3.0~dev19~ubuntu24.04.1 all
>
> which can be installed by running the following commands:
>
> add-apt-repository -y ppa:checkbox-dev/stable
> apt-add-repository -y ppa:firmware-testing-team/ppa-fwts-stable
> apt update
> apt install -y canonical-certification-server
>
> Inside the stress_disk() function of
> /usr/lib/checkbox-provider-base/bin/stress_ng_test.py, I have
> redefined disk_stressors =3D ['aiol'] so that only the aiol test runs.
> Each aiol test takes about 5 minutes when run alone, and the panic
> will usually happen in under 10 runs.
>
> Once the above is complete, I run the following script, which runs
> only the affected test $count times:
>
> count=3D15
> for i in $(seq $count); do
>     echo "Starting Stress #${i}/${count} for $(uname -r)"
>     /usr/lib/checkbox-provider-base/bin/stress_ng_test.py disk
> --device dm-0 --base-time 240
>     echo "Completed Stress #${i}/${count} for $(uname -r)"
> done
>
> Aside from the above steps and the fact that I was stressing the
> device-mapper device dm-0, I don't think there were any special
> configuration options in use.
>
> -Mitchell Augustin
>
>
> On Thu, Mar 28, 2024 at 7:18=E2=80=AFPM Kent Overstreet
> <kent.overstreet@linux.dev> wrote:
> >
> > On Thu, Mar 28, 2024 at 05:29:30PM -0500, Mitchell Augustin wrote:
> > > Hello!
> > >
> > > While running the stress-ng disk test suite as part of our
> > > certification process for Noble on Nvidia Grace machines, I observed =
a
> > > kernel panic during the aiol test. This issue initially presented
> > > itself on the Ubuntu 6.8.0-11-generic kernel, but I have verified tha=
t
> > > it is also present in the latest mainline 6.8 kernel as well as the
> > > master branch of the Linus tree (at least as late as
> > > 8d025e2092e29bfd13e56c78e22af25fac83c8ec). The panic does not occur
> > > during every run of the aiol test on affected kernels, but it does
> > > appear at least 25% of the time based on my tests. I'm also not
> > > entirely sure if this is related, but I have only personally observed
> > > this issue on Grace when disks were set up with LVM enabled during th=
e
> > > Ubuntu installation phase (and thus, stress-ng was stressing /dev/dm-=
0
> > > rather than /dev/nvme*). (See this Ubuntu BugLink for more details on
> > > reproducing this:
> > > https://bugs.launchpad.net/ubuntu/+source/linux/+bug/2058557).
> > >
> > > I have determined that this commit
> > > (https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/c=
ommit/fs/aio.c?id=3D71eb6b6b0ba93b1467bccff57b5de746b09113d2)
> > > introduced this regression. On this commit's parent (and all other
> > > ancestors I tested during the bisect), I was able to run the aiol tes=
t
> > > 15 times in a row without any panics, but on this commit (and all
> > > descendants I tested, including the latest version of the Linus tree)=
,
> > > there would typically be a kernel panic within the first 5 executions
> > > of the aiol test. The trace also supports this, as it shows the crash
> > > occurring during the wake_up_process() call inside aio_complete(),
> > > which is introduced in this commit. To further verify this, I also
> > > reverted this patch on the latest Ubuntu kernel, and that version of
> > > the kernel did not panic after 15 aiol test runs.
> > >
> > > I've CC'd Colin King here since stress-ng helped us find this bug.
> > > Thanks, Colin!
> > >
> > > Let me know if you need any more information from me that would be
> > > useful in fixing this regression.
> > >
> > > Thanks,
> > >
> > > Mitchell Augustin
> >
> > Yeah, this is a funny one, w.w.private (task_struct) appears to have
> > been set to NULL, but I see nothing in that codepath that would do that=
.
> >
> > But hrtimer_sleeper also has a pointer back to current and that does ge=
t
> > nulled when the timeout expires; device-mapper affecting how often the
> > bug pops does point to a race, i.e. likely hrtimer involvement.
> >
> > If you could get me a testcase that I could run in ktest, or more
> > details on how to repro - that would let me get kgdb attached and check
> > exactly what's going on with both the aio_waiter and the
> > hrtimer_sleeper. I run stress-ng in my automated testing and haven't
> > seen this there, but only with the default options, so maybe your
> > harness is giving it non defaults?
> >
> > https://evilpiepirate.org/git/ktest.git/
> >
> >
> > >
> > > Kernel panic trace:
> > >
> > > 28 Mar 21:28: Running stress-ng aiol stressor for 240 seconds...
> > > [  453.969106] Unable to handle kernel NULL pointer dereference at vi=
rtual add
> > > ress 00000000000008f5
> > > [  453.978106] Mem abort info:
> > > [  453.980957]   ESR =3D 0x0000000096000005
> > > [  453.984786]   EC =3D 0x25: DABT (current EL), IL =3D 32 bits
> > > [  453.990215]   SET =3D 0, FnV =3D 0
> > > [  453.993331]   EA =3D 0, S1PTW =3D 0
> > > [  453.996537]   FSC =3D 0x05: level 1 translation fault
> > > [  454.001521] Data abort info:
> > > [  454.004459]   ISV =3D 0, ISS =3D 0x00000005, ISS2 =3D 0x00000000
> > > [  454.010065]   CM =3D 0, WnR =3D 0, TnD =3D 0, TagAccess =3D 0
> > > [  454.015225]   GCS =3D 0, Overlay =3D 0, DirtyBit =3D 0, Xs =3D 0
> > > [  454.020653] user pgtable: 64k pages, 48-bit VAs, pgdp=3D00001000d9=
a70a00
> > > [  454.027328] [00000000000008f5] pgd=3D0000000000000000, p4d=3D00000=
00000000000,
> > > pud=3D0000000000000000
> > > [  454.036229] Internal error: Oops: 0000000096000005 [#1] SMP
> > > [  454.041928] Modules linked in: qrtr cfg80211 binfmt_misc nls_iso88=
59_1 dax_
> > > hmem cxl_acpi acpi_ipmi cxl_core onboard_usb_hub ipmi_ssif input_leds=
 einj uio
> > > _pdrv_genirq ipmi_devintf arm_smmuv3_pmu arm_cspmu_module uio ipmi_ms=
ghandler
> > > joydev spi_nor mtd cppc_cpufreq acpi_power_meter dm_multipath nvme_fa=
brics efi
> > > _pstore nfnetlink dmi_sysfs ip_tables x_tables autofs4 btrfs blake2b_=
generic r
> > > aid10 raid456 async_raid6_recov async_memcpy async_pq async_xor async=
_tx xor x
> > > or_neon raid6_pq libcrc32c raid1 raid0 hid_generic rndis_host usbhid =
cdc_ether
> > >  hid usbnet uas usb_storage crct10dif_ce polyval_ce polyval_generic g=
hash_ce s
> > > m4_ce_gcm sm4_ce_ccm sm4_ce sm4_ce_cipher sm4 ast sm3_ce sm3 drm_shme=
m_helper
> > > i2c_algo_bit i2c_smbus sha3_ce drm_kms_helper nvme sha2_ce ixgbe xhci=
_pci sha2
> > > 56_arm64 sha1_ce drm xfrm_algo nvme_core xhci_pci_renesas mdio spi_te=
gra210_qu
> > > ad i2c_tegra aes_neon_bs aes_neon_blk aes_ce_blk aes_ce_cipher
> > > [  454.123972] CPU: 63 PID: 3571 Comm: kworker/63:6 Not tainted 6.9.0=
-rc1+ #2
> > > [  454.131003] Hardware name: Supermicro MBD-G1SMH/G1SMH, BIOS 1.0c 1=
2/28/2023
> > > [  454.138121] Workqueue: dio/dm-0 iomap_dio_complete_work
> > > [  454.143475] pstate: 034000c9 (nzcv daIF +PAN -UAO +TCO +DIT -SSBS =
BTYPE=3D--)
> > > [  454.150594] pc : _raw_spin_lock_irqsave+0x44/0x100
> > > [  454.155503] lr : try_to_wake_up+0x68/0x758
> > > [  454.159692] sp : ffff8000faa4fc50
> > > [  454.163075] x29: ffff8000faa4fc50 x28: 0000000000000000 x27: 00000=
000000000
> > > 00
> > > [  454.170371] x26: ffff003bdc6ff328 x25: 0000000000000000 x24: 00000=
000000000
> > > 12
> > > [  454.177666] x23: ffff0000e11f5640 x22: 00000000000008f5 x21: 00000=
000000000
> > > 00
> > > [  454.184963] x20: 0000000000000003 x19: 00000000000000c0 x18: ffff8=
000faa600
> > > 48
> > > [  454.192258] x17: 0000000000000000 x16: 0000000000000000 x15: 0000b=
a4bb2d887
> > > f0
> > > [  454.199554] x14: 0000000000000000 x13: 0000000000000000 x12: 01010=
101010101
> > > 01
> > > [  454.206850] x11: 7f7f7f7f7f7f7f7f x10: fefefefefefefeff x9 : ffffc=
81e3f8edb
> > > 60
> > > [  454.214145] x8 : 8080808080808080 x7 : 0000002040000000 x6 : 00000=
0000000b2
> > > 40
> > > [  454.221442] x5 : 0000ba4bb2d883b0 x4 : 0000000000000000 x3 : ffff0=
000ec4400
> > > 00
> > > [  454.228738] x2 : 0000000000000001 x1 : 0000000000000000 x0 : 00000=
000000008
> > > f5
> > > [  454.236034] Call trace:
> > > [  454.238529]  _raw_spin_lock_irqsave+0x44/0x100
> > > [  454.243069]  try_to_wake_up+0x68/0x758
> > > [  454.246897]  wake_up_process+0x24/0x50
> > > [  454.250725]  aio_complete+0x1cc/0x2c0
> > > [  454.254472]  aio_complete_rw+0x11c/0x2c8
> > > [  454.258480]  iomap_dio_complete_work+0x3c/0x68
> > > [  454.263018]  process_one_work+0x18c/0x478
> > > [  454.267118]  worker_thread+0x338/0x450
> > > [  454.270947]  kthread+0x11c/0x128
> > > [  454.274244]  ret_from_fork+0x10/0x20
> > > [  454.277901] Code: b9001041 d503201f 52800001 52800022 (88e17c02)
> > > [  454.284134] ---[ end trace 0000000000000000 ]---
> > > [  454.316501] note: kworker/63:6[3571] exited with irqs disabled
> > > [  454.322522] note: kworker/63:6[3571] exited with preempt_count 3
> > > [  454.325180] kauditd_printk_skb: 81 callbacks suppressed
> > > [  454.325247] audit: type=3D1400 audit(1711661498.816:93): apparmor=
=3D"DENIED" op
> > > eration=3D"open" class=3D"file" profile=3D"rsyslogd" name=3D"/run/sys=
temd/sessions/" p
> > > id=3D2692 comm=3D72733A6D61696E20513A526567 requested_mask=3D"r" deni=
ed_mask=3D"r" fsu
> > > id=3D103 ouid=3D0
> > > [  514.192212] rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
> > > [  514.198495] rcu: 120-...0: (27 ticks this GP) idle=3D7504/1/0x4000=
0000000
> > > 00000 softirq=3D9023/9025 fqs=3D6895
> > > [  514.208233] rcu:         hardirqs   softirqs   csw/system
> > > [  514.213941] rcu: number:        0          0            0
> > > [  514.219653] rcu: cputime:        0          0            0   =3D=
=3D> 30028(
> > > ms)
> > > [  514.226801] rcu: (detected by 18, t=3D15010 jiffies, g=3D19925, q=
=3D444 ncpus
> > > =3D144)
> > > [  514.234133] Sending NMI from CPU 18 to CPUs 120:
> > > [  524.245328] rcu: rcu_preempt kthread timer wakeup didn't happen fo=
r 2513 ji
> > > ffies! g19925 f0x0 RCU_GP_WAIT_FQS(5) ->state=3D0x402
> > > [  524.257006] rcu: Possible timer handling issue on cpu=3D18 timer-s=
oftirq=3D
> > > 2890
> > > [  524.264227] rcu: rcu_preempt kthread starved for 2518 jiffies! g19=
925 f0x0
> > > RCU_GP_WAIT_FQS(5) ->state=3D0x402 ->cpu=3D18
> > > [  524.275009] rcu: Unless rcu_preempt kthread gets sufficient CPU ti=
me, O
> > > OM is now expected behavior.
> > > [  524.284361] rcu: RCU grace-period kthread stack dump:
> > > [  524.289532] task:rcu_preempt     state:I stack:0     pid:16    tgi=
d:16    p
> > > pid:2      flags:0x00000008
> > > [  524.299085] Call trace:
> > > [  524.301593]  __switch_to+0xdc/0x138
> > > [  524.305196]  __schedule+0x3f0/0x18a0
> > > [  524.308870]  schedule+0x40/0x1b8
> > > [  524.312184]  schedule_timeout+0xac/0x1e0
> > > [  524.316222]  rcu_gp_fqs_loop+0x120/0x508
> > > [  524.320273]  rcu_gp_kthread+0x148/0x178
> > > [  524.324222]  kthread+0x11c/0x128
> > > [  524.327551]  ret_from_fork+0x10/0x20
> > > [  524.331235] rcu: Stack dump where RCU GP kthread last ran:
> > > [  524.336859] CPU: 18 PID: 0 Comm: swapper/18 Tainted: G      D     =
       6.
> > > 9.0-rc1+ #2
> > > [  524.344976] Hardware name: Supermicro MBD-G1SMH/G1SMH, BIOS 1.0c 1=
2/28/2023
> > > [  524.352104] pstate: 63400009 (nZCv daif +PAN -UAO +TCO +DIT -SSBS =
BTYPE=3D--)
> > > [  524.359243] pc : cpuidle_enter_state+0xd8/0x790
> > > [  524.363906] lr : cpuidle_enter_state+0xcc/0x790
> > > [  524.368563] sp : ffff80008324fd80
> > > [  524.371957] x29: ffff80008324fd80 x28: 0000000000000000 x27: 00000=
000000000
> > > 00
> > > [  524.379287] x26: 0000000000000000 x25: 00000077b804c1a0 x24: 00000=
000000000
> > > 00
> > > [  524.386611] x23: ffffc81e42d8bd68 x22: 0000000000000000 x21: 00000=
077b83e5c
> > > e0
> > > [  524.393935] x20: ffffc81e42d8bd80 x19: ffff000098ef0000 x18: ffff8=
000832600
> > > 28
> > > [  524.401258] x17: 0000000000000000 x16: 0000000000000000 x15: 0000b=
a4bb2d87f
> > > b0
> > > [  524.408583] x14: 0000000000000000 x13: 0000000000000000 x12: 00000=
000000000
> > > 00
> > > [  524.415907] x11: 0000000000000000 x10: 0000000000000000 x9 : ffffc=
81e40d035
> > > 64
> > > [  524.423231] x8 : 0000000000000000 x7 : 0000000000000000 x6 : 00000=
000000000
> > > 00
> > > [  524.430553] x5 : 0000000000000000 x4 : 0000000000000000 x3 : 00000=
000000000
> > > 00
> > > [  524.437876] x2 : 0000000000000000 x1 : 0000000000000000 x0 : 00000=
000000000
> > > 00
> > > [  524.445198] Call trace:
> > > [  524.447705]  cpuidle_enter_state+0xd8/0x790
> > > [  524.452008]  cpuidle_enter+0x44/0x78
> > > [  524.455683]  do_idle+0x264/0x2f8
> > > [  524.458995]  cpu_startup_entry+0x44/0x50
> > > [  524.463016]  secondary_start_kernel+0x13c/0x180
> > > [  524.467679]  __secondary_switched+0xc0/0xc8
> > > [  615.621045] ------------[ cut here ]------------
> > > [  615.625852] hwirq =3D 71
> > > [  615.625996] WARNING: CPU: 0 PID: 0 at drivers/gpio/gpio-tegra186.c=
:655 tegr
> > > a186_gpio_irq+0x258/0x2e0
> > > [  615.637932] Modules linked in: qrtr cfg80211 binfmt_misc nls_iso88=
59_1 dax_
> > > hmem cxl_acpi acpi_ipmi cxl_core onboard_usb_hub ipmi_ssif input_leds=
 einj uio
> > > _pdrv_genirq ipmi_devintf arm_smmuv3_pmu arm_cspmu_module uio ipmi_ms=
ghandler
> > > joydev spi_nor mt[0001.089] W> RATCHET: MB1 binary ratchet value 1 is=
 larger t
> > > han ratchet level 0 from HW fuses.
> > >
> > >
> > > On Wed, 22 Nov 2023 18:42:53 -0500 Kent Overstreet
> > > <kent.overstreet@linux.dev> wrote:
> > > >
> > > > Unclear who's maintaining fs/aio.c these days - who wants to take t=
his?
> > > > -- >8 --
> > > >
> > > > I've been observing workloads where IPIs due to wakeups in
> > > > aio_complete() are ~15% of total CPU time in the profile. Most of t=
hose
> > > > wakeups are unnecessary when completion batching is in use in
> > > > io_getevents().
> > > >
> > > > This plumbs min_nr through via the wait eventry, so that aio_comple=
te()
> > > > can avoid doing unnecessary wakeups.
> > > >
> > > > Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
> > > > Cc: Benjamin LaHaise <bcrl@kvack.org
> > > > Cc: Christian Brauner <brauner@kernel.org>
> > > > Cc: linux-aio@kvack.org
> > > > Cc: linux-fsdevel@vger.kernel.org
> > > > ---
> > > > fs/aio.c | 66 +++++++++++++++++++++++++++++++++++++++++++++++------=
---
> > > > 1 file changed, 56 insertions(+), 10 deletions(-)
> > > >
> > > > diff --git a/fs/aio.c b/fs/aio.c
> > > > index f8589caef9c1..c69e7caacd1b 100644
> > > > --- a/fs/aio.c
> > > > +++ b/fs/aio.c
> > > > @@ -1106,6 +1106,11 @@ static inline void iocb_destroy(struct aio_k=
iocb
> > > > *iocb)
> > > > kmem_cache_free(kiocb_cachep, iocb);
> > > > }
> > > > +struct aio_waiter {
> > > > + struct wait_queue_entry w;
> > > > + size_t min_nr;
> > > > +};
> > > > +
> > > > /* aio_complete
> > > > * Called when the io request on the given iocb is complete.
> > > > */
> > > > @@ -1114,7 +1119,7 @@ static void aio_complete(struct aio_kiocb *io=
cb)
> > > > struct kioctx *ctx =3D iocb->ki_ctx;
> > > > struct aio_ring *ring;
> > > > struct io_event *ev_page, *event;
> > > > - unsigned tail, pos, head;
> > > > + unsigned tail, pos, head, avail;
> > > > unsigned long flags;
> > > > /*
> > > > @@ -1156,6 +1161,10 @@ static void aio_complete(struct aio_kiocb *i=
ocb)
> > > > ctx->completed_events++;
> > > > if (ctx->completed_events > 1)
> > > > refill_reqs_available(ctx, head, tail);
> > > > +
> > > > + avail =3D tail > head
> > > > + ? tail - head
> > > > + : tail + ctx->nr_events - head;
> > > > spin_unlock_irqrestore(&ctx->completion_lock, flags);
> > > > pr_debug("added to ring %p at [%u]\n", iocb, tail);
> > > > @@ -1176,8 +1185,18 @@ static void aio_complete(struct aio_kiocb *i=
ocb)
> > > > */
> > > > smp_mb();
> > > > - if (waitqueue_active(&ctx->wait))
> > > > - wake_up(&ctx->wait);
> > > > + if (waitqueue_active(&ctx->wait)) {
> > > > + struct aio_waiter *curr, *next;
> > > > + unsigned long flags;
> > > > +
> > > > + spin_lock_irqsave(&ctx->wait.lock, flags);
> > > > + list_for_each_entry_safe(curr, next, &ctx->wait.head, w.entry)
> > > > + if (avail >=3D curr->min_nr) {
> > > > + list_del_init_careful(&curr->w.entry);
> > > > + wake_up_process(curr->w.private);
> > > > + }
> > > > + spin_unlock_irqrestore(&ctx->wait.lock, flags);
> > > > + }
> > > > }
> > > > static inline void iocb_put(struct aio_kiocb *iocb)
> > > > @@ -1290,7 +1309,9 @@ static long read_events(struct kioctx *ctx, l=
ong
> > > > min_nr, long nr,
> > > > struct io_event __user *event,
> > > > ktime_t until)
> > > > {
> > > > - long ret =3D 0;
> > > > + struct hrtimer_sleeper t;
> > > > + struct aio_waiter w;
> > > > + long ret =3D 0, ret2 =3D 0;
> > > > /*
> > > > * Note that aio_read_events() is being called as the conditional - =
i.e.
> > > > @@ -1306,12 +1327,37 @@ static long read_events(struct kioctx *ctx,=
 long
> > > > min_nr, long nr,
> > > > * the ringbuffer empty. So in practice we should be ok, but it's
> > > > * something to be aware of when touching this code.
> > > > */
> > > > - if (until =3D=3D 0)
> > > > - aio_read_events(ctx, min_nr, nr, event, &ret);
> > > > - else
> > > > - wait_event_interruptible_hrtimeout(ctx->wait,
> > > > - aio_read_events(ctx, min_nr, nr, event, &ret),
> > > > - until);
> > > > + aio_read_events(ctx, min_nr, nr, event, &ret);
> > > > + if (until =3D=3D 0 || ret < 0 || ret >=3D min_nr)
> > > > + return ret;
> > > > +
> > > > + hrtimer_init_sleeper_on_stack(&t, CLOCK_MONOTONIC, HRTIMER_MODE_R=
EL);
> > > > + if (until !=3D KTIME_MAX) {
> > > > + hrtimer_set_expires_range_ns(&t.timer, until, current->timer_slac=
k_ns);
> > > > + hrtimer_sleeper_start_expires(&t, HRTIMER_MODE_REL);
> > > > + }
> > > > +
> > > > + init_wait(&w.w);
> > > > +
> > > > + while (1) {
> > > > + unsigned long nr_got =3D ret;
> > > > +
> > > > + w.min_nr =3D min_nr - ret;
> > > > +
> > > > + ret2 =3D prepare_to_wait_event(&ctx->wait, &w.w, TASK_INTERRUPTIB=
LE) ?:
> > > > + !t.task ? -ETIME : 0;
> > > > +
> > > > + if (aio_read_events(ctx, min_nr, nr, event, &ret) || ret2)
> > > > + break;
> > > > +
> > > > + if (nr_got =3D=3D ret)
> > > > + schedule();
> > > > + }
> > > > +
> > > > + finish_wait(&ctx->wait, &w.w);
> > > > + hrtimer_cancel(&t.timer);
> > > > + destroy_hrtimer_on_stack(&t.timer);
> > > > +
> > > > return ret;
> > > > }
> > > >
> > > > --
> > > > 2.42.0
> > > >
> > > >

