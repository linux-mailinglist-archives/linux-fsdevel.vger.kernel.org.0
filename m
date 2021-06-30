Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C60633B86C3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Jun 2021 18:06:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232018AbhF3QI7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 30 Jun 2021 12:08:59 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:41580 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229753AbhF3QI6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 30 Jun 2021 12:08:58 -0400
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
        (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id A088B20483;
        Wed, 30 Jun 2021 16:06:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1625069188; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=R+/U4JehVX0FhkBlOkfzWo0x8lCwrBaeOESsSdyk28Y=;
        b=Rjn+2hiBLWwyjfFNPxIHwptzno1cJItH37TEtJuQ8SvCUwv/dPVYwPrLNtPJ8zH+RmmBRT
        Hfr9wvdi+cCUR8+PUehJ30loQWlQ/tiNXO/is7shMoXM+T9V4u1KBtsSvmnynRrsAryjIH
        HdvzUCXxB9cU/hmnz19T2cZTJ+ATZVA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1625069188;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=R+/U4JehVX0FhkBlOkfzWo0x8lCwrBaeOESsSdyk28Y=;
        b=s6m1jYejOk8yfoCaOzESlebrkrRGXExFJI4rTp5M34pM7Y3gmd9fgSqL9E2txte6IAu9+7
        qMlYMdhuVZ3kMIAw==
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
        by imap.suse.de (Postfix) with ESMTP id 1AA4D118DD;
        Wed, 30 Jun 2021 16:06:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1625069188; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=R+/U4JehVX0FhkBlOkfzWo0x8lCwrBaeOESsSdyk28Y=;
        b=Rjn+2hiBLWwyjfFNPxIHwptzno1cJItH37TEtJuQ8SvCUwv/dPVYwPrLNtPJ8zH+RmmBRT
        Hfr9wvdi+cCUR8+PUehJ30loQWlQ/tiNXO/is7shMoXM+T9V4u1KBtsSvmnynRrsAryjIH
        HdvzUCXxB9cU/hmnz19T2cZTJ+ATZVA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1625069188;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=R+/U4JehVX0FhkBlOkfzWo0x8lCwrBaeOESsSdyk28Y=;
        b=s6m1jYejOk8yfoCaOzESlebrkrRGXExFJI4rTp5M34pM7Y3gmd9fgSqL9E2txte6IAu9+7
        qMlYMdhuVZ3kMIAw==
Received: from director2.suse.de ([192.168.254.72])
        by imap3-int with ESMTPSA
        id Uui7A4SW3GDZWAAALh3uQQ
        (envelope-from <lhenriques@suse.de>); Wed, 30 Jun 2021 16:06:28 +0000
Received: from localhost (brahms [local])
        by brahms (OpenSMTPD) with ESMTPA id 578c595a;
        Wed, 30 Jun 2021 16:06:27 +0000 (UTC)
Date:   Wed, 30 Jun 2021 17:06:27 +0100
From:   Luis Henriques <lhenriques@suse.de>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     kernel test robot <oliver.sang@intel.com>,
        0day robot <lkp@intel.com>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Olga Kornievskaia <aglo@umich.edu>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [vfs] 94a4dd06a6: xfstests.generic.263.fail
Message-ID: <YNyWgxlX4xoQ8itu@suse.de>
References: <20210513135644.GE20142@xsang-OptiPlex-9020>
 <877dk1zibo.fsf@suse.de>
 <CAOQ4uxgde72YDADffihj1P-Kse_P6zkhrjBb1DhwVUC+yRJooQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxgde72YDADffihj1P-Kse_P6zkhrjBb1DhwVUC+yRJooQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jun 30, 2021 at 06:46:22PM +0300, Amir Goldstein wrote:
> On Fri, May 14, 2021 at 2:03 PM Luis Henriques <lhenriques@suse.de> wrote:
> >
> > kernel test robot <oliver.sang@intel.com> writes:
> >
> > > Greeting,
> > >
> > > FYI, we noticed the following commit (built with gcc-9):
> > >
> > > commit: 94a4dd06a6bbf3978b0bb1dddc2d8ec4e5bcad26 ("[PATCH v9] vfs: fix copy_file_range regression in cross-fs copies")
> > > url: https://github.com/0day-ci/linux/commits/Luis-Henriques/vfs-fix-copy_file_range-regression-in-cross-fs-copies/20210510-170804
> > > base: https://git.kernel.org/cgit/linux/kernel/git/viro/vfs.git for-next
> > >
> > > in testcase: xfstests
> > > version: xfstests-x86_64-73c0871-1_20210401
> > > with following parameters:
> > >
> > >       disk: 4HDD
> > >       fs: xfs
> > >       test: generic-group-13
> > >       ucode: 0x21
> > >
> > > test-description: xfstests is a regression test suite for xfs and other files ystems.
> > > test-url: git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git
> > >
> > >
> > > on test machine: 4 threads 1 sockets Intel(R) Core(TM) i3-3220 CPU @ 3.30GHz with 8G memory
> > >
> > > caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):
> > >
> > >
> > >
> > >
> > > If you fix the issue, kindly add following tag
> > > Reported-by: kernel test robot <oliver.sang@intel.com>
> > >
> > > 2021-05-11 11:28:23 export TEST_DIR=/fs/sda1
> > > 2021-05-11 11:28:23 export TEST_DEV=/dev/sda1
> > > 2021-05-11 11:28:23 export FSTYP=xfs
> > > 2021-05-11 11:28:23 export SCRATCH_MNT=/fs/scratch
> > > 2021-05-11 11:28:23 mkdir /fs/scratch -p
> > > 2021-05-11 11:28:23 export SCRATCH_DEV=/dev/sda4
> > > 2021-05-11 11:28:23 export SCRATCH_LOGDEV=/dev/sda2
> > > 2021-05-11 11:28:23 sed "s:^:generic/:" //lkp/benchmarks/xfstests/tests/generic-group-13
> > > 2021-05-11 11:28:23 ./check generic/260 generic/261 generic/262 generic/263 generic/264 generic/265 generic/266 generic/267 generic/268 generic/269 generic/270 generic/271 generic/272 generic/273 generic/274 generic/275 generic/276 generic/277 generic/278 generic/279
> > > FSTYP         -- xfs (debug)
> > > PLATFORM      -- Linux/x86_64 lkp-ivb-d02 5.12.0-rc6-00061-g94a4dd06a6bb #1 SMP Tue May 11 00:58:17 CST 2021
> > > MKFS_OPTIONS  -- -f -bsize=4096 /dev/sda4
> > > MOUNT_OPTIONS -- /dev/sda4 /fs/scratch
> > >
> > > generic/260   [not run] FITRIM not supported on /fs/scratch
> > > generic/261   [not run] Reflink not supported by scratch filesystem type: xfs
> > > generic/262   [not run] Reflink not supported by scratch filesystem type: xfs
> > > generic/263   [failed, exit status 1]- output mismatch (see /lkp/benchmarks/xfstests/results//generic/263.out.bad)
> > >     --- tests/generic/263.out 2021-04-01 03:07:08.000000000 +0000
> > >     +++ /lkp/benchmarks/xfstests/results//generic/263.out.bad 2021-05-11 11:28:29.773460096 +0000
> > >     @@ -1,3 +1,32 @@
> > >      QA output created by 263
> > >      fsx -N 10000 -o 8192 -l 500000 -r PSIZE -t BSIZE -w BSIZE -Z
> > >     -fsx -N 10000 -o 128000 -l 500000 -r PSIZE -t BSIZE -w BSIZE -Z
> > >     +Seed set to 1
> > >     +main: filesystem does not support clone range, disabling!
> > >     +main: filesystem does not support dedupe range, disabling!
> > >     +skipping zero size read
> > >     ...
> > >     (Run 'diff -u /lkp/benchmarks/xfstests/tests/generic/263.out /lkp/benchmarks/xfstests/results//generic/263.out.bad'  to see the entire diff)
> > > generic/264   [not run] Reflink not supported by scratch filesystem type: xfs
> > > generic/265   [not run] Reflink not supported by scratch filesystem type: xfs
> > > generic/266   [not run] Reflink not supported by scratch filesystem type: xfs
> > > generic/267   [not run] Reflink not supported by scratch filesystem type: xfs
> > > generic/268   [not run] Reflink not supported by scratch filesystem type: xfs
> > > generic/269    48s
> > > generic/270    61s
> > > generic/271   [not run] Reflink not supported by scratch filesystem type: xfs
> > > generic/272   [not run] Reflink not supported by scratch filesystem type: xfs
> > > generic/273    17s
> > > generic/274    14s
> > > generic/275    11s
> > > generic/276   [not run] Reflink not supported by scratch filesystem type: xfs
> > > generic/277    3s
> > > generic/278   [not run] Reflink not supported by scratch filesystem type: xfs
> > > generic/279   [not run] Reflink not supported by scratch filesystem type: xfs
> > > Ran: generic/260 generic/261 generic/262 generic/263 generic/264 generic/265 generic/266 generic/267 generic/268 generic/269 generic/270 generic/271 generic/272 generic/273 generic/274 generic/275 generic/276 generic/277 generic/278 generic/279
> > > Not run: generic/260 generic/261 generic/262 generic/264 generic/265 generic/266 generic/267 generic/268 generic/271 generic/272 generic/276 generic/278 generic/279
> > > Failures: generic/263
> > > Failed 1 of 20 tests
> >
> > OK, I see what's going on.  There are 2 issues: one with patch and another
> > one with the test itself.
> >
> > The CFR syscall should have been disabled in this test but it isn't
> > because the test tries to copy 1 byte from a zero-sized file:
> >
> > int
> > test_copy_range(void)
> > {
> >         loff_t o1 = 0, o2 = 1;
> >
> >         if (syscall(__NR_copy_file_range, fd, &o1, fd, &o2, 1, 0) == -1 &&
> >             (errno == ENOSYS || errno == EOPNOTSUPP || errno == ENOTTY)) {
> >                 if (!quiet)
> >                         fprintf(stderr,
> >                                 "main: filesystem does not support "
> >                                 "copy range, disabling!\n");
> >                 return 0;
> >         }
> >
> >         return 1;
> > }
> >
> > The syscall is doing an early '0' return because the file size is < len.
> >
> > Fixing the kernel should probably be as easy as removing the
> > short-circuiting check in vfs_copy_file_range():
> >
> >         if (len == 0)
> >                 return 0;
> >
> > This will force the filesystems code to handle '0' size copies but will
> > also make sure -EOPNOTSUPP is returned in this case.
> >
> 
> Sorry for the late reply.
> The solution above is correct.
> That is aligned with the behavior of vfs_clone_file_range().
> Need to call into the filesystem method also with 0 length
> in order to learn about CFR support of this filesystem instance.

Yep, this makes sense (I've seen you're detailed explanation in the other
thread -- thanks!).  I'll send out v11 in a sec.

Cheers,
--
Luís

> > Alternatively, we could have something like:
> >
> >         if (len == 0) {
> >                 if (file_out->f_op->copy_file_range)
> >                         return 0;
> >                 else
> >                         return -EOPNOTSUPP;
> >         }
> >
> 
> This does not catch the case of a filesystem driver that has
> CFR method but a filesystem instance does not support CFR.
> For example, overlayfs with ext4 as upper fs.
> 
> > What do you guys think is the right thing to do?
> >
> > Additionally, the test should also be fixed with something as the patch
> > bellow.  By making sure we have 1 byte to copy we also ensure the syscall
> > will return -EOPNOTSUPP, even with the current version of the patch.
> >
> 
> I don't think that the test should be fixed.
> 
> Thanks,
> Amir.
> 
> > Cheers,
> > --
> > Luis
> >
> > diff --git a/ltp/fsx.c b/ltp/fsx.c
> > index cd0bae55aeb8..97db594ae142 100644
> > --- a/ltp/fsx.c
> > +++ b/ltp/fsx.c
> > @@ -1596,6 +1596,10 @@ int
> >  test_copy_range(void)
> >  {
> >         loff_t o1 = 0, o2 = 1;
> > +       int ret = 1;
> > +
> > +       /* Make sure we have 1 byte to copy */
> > +       ftruncate(fd, 1);
> >
> >         if (syscall(__NR_copy_file_range, fd, &o1, fd, &o2, 1, 0) == -1 &&
> >             (errno == ENOSYS || errno == EOPNOTSUPP || errno == ENOTTY)) {
> > @@ -1603,10 +1607,13 @@ test_copy_range(void)
> >                         fprintf(stderr,
> >                                 "main: filesystem does not support "
> >                                 "copy range, disabling!\n");
> > -               return 0;
> > +               ret = 0;
> >         }
> >
> > -       return 1;
> > +       /* Restore file size */
> > +       ftruncate(fd, 0);
> > +
> > +       return ret;
> >  }
> >
> >  void
