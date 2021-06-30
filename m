Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E55223B865C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Jun 2021 17:38:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235743AbhF3Pk5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 30 Jun 2021 11:40:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235508AbhF3Pk5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 30 Jun 2021 11:40:57 -0400
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C256C061756;
        Wed, 30 Jun 2021 08:38:27 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id u7so1532182ion.3;
        Wed, 30 Jun 2021 08:38:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fTg6aPlYdnMZc4cZ4vz9hUNOB1Qg7xkr6gdYsrqEqcE=;
        b=ZtwmrQxYx4oxz4UpRtnRHNlIJz/+2poRpHN1qLK/0GKefj7xX7/AOqlTG/n1sC+3H2
         iEYbLAXMc+Ken//UPG1f1OCQ8JY7W2cHBp9D7nTV0ReQNq7qnsiDd6s5ZsutkJ9nlnBt
         lCChYQNSWBXErSoEiaEfezxITNnonHY2qI+D9GGd2wj/KjszLcp9CUyGqlTD+/4iBMrS
         YDhqu57LR5x/PrBW/A7G+QKlKJWMMOOx1zwkD2jse+YbC5ngcyXH+vkTHvmGVFoKnjWa
         yOK8psQd6wyKM+FTIJMeqsGwohD3lfwmunUgenfoL/OeRZNI2AQCwudFKt+Dqt7lDdMI
         aZJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fTg6aPlYdnMZc4cZ4vz9hUNOB1Qg7xkr6gdYsrqEqcE=;
        b=UA40yN5l5deqQqFjo/uk6fmleZ/1wnxqbOq+Vk0704mzlRNr+6rh05WGgqjFxFR/HB
         0j+tV13zKhzJ24t/f9rwTW2IAHkTf7NJZWMgMWU6nGJBQbTX0M0WInsEK0NSseUmoEBE
         +eXpuBhcZQmwzf38D5NuUgXVg37pvPQZ7Su0CRf1CzS7qFIwj1jLDJWoMMtSkI9RiKdo
         OZHyOD84oTOmHi97Mk/Mass80T7TZeECh93ErmGox1uWKiwRKRHoKBJEh1FvZaBuyj2A
         +nE0pbKRGPtPeteOvgcjDiq9oiR6I9u2pJdnx16iejmhxI2xdnnowYVLhIF7GiL3qnhZ
         ivDA==
X-Gm-Message-State: AOAM530DQw2G+/RKvZewoqyFfWTO4W6228El80ZyUypLpE9oC8sSSaE6
        L1QwJqELTnDYjS7td+NPVK8f6itidQBVzEYHtFE=
X-Google-Smtp-Source: ABdhPJyPiSsimHoJ7OydcwrteA3FKRKE6K7bCBEsQ8jMpw0DtLhzqlalh0/EWtrUpLvUduS3Q0UvHh81asRCVECSuM4=
X-Received: by 2002:a02:8790:: with SMTP id t16mr9329242jai.81.1625067506964;
 Wed, 30 Jun 2021 08:38:26 -0700 (PDT)
MIME-Version: 1.0
References: <20210630134449.16851-1-lhenriques@suse.de> <CAOQ4uxi6pMEehkXWAk=vzx3mZAfcxwVPvFs9W7LM2CfgBkZWxQ@mail.gmail.com>
 <YNyIYNpcy2WsnUnu@suse.de>
In-Reply-To: <YNyIYNpcy2WsnUnu@suse.de>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Wed, 30 Jun 2021 18:38:16 +0300
Message-ID: <CAOQ4uxj5r86cM6KgvkjgwUrHwZ0ASVUR8OMzu5wUmCxOV9rLRw@mail.gmail.com>
Subject: Re: [PATCH v10] vfs: fix copy_file_range regression in cross-fs copies
To:     Luis Henriques <lhenriques@suse.de>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Olga Kornievskaia <aglo@umich.edu>,
        Petr Vorel <pvorel@suse.cz>,
        kernel test robot <oliver.sang@intel.com>,
        "Darrick J. Wong" <djwong@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jun 30, 2021 at 6:06 PM Luis Henriques <lhenriques@suse.de> wrote:
>
> On Wed, Jun 30, 2021 at 05:56:34PM +0300, Amir Goldstein wrote:
> > On Wed, Jun 30, 2021 at 4:44 PM Luis Henriques <lhenriques@suse.de> wrote:
> > >
> > > A regression has been reported by Nicolas Boichat, found while using the
> > > copy_file_range syscall to copy a tracefs file.  Before commit
> > > 5dae222a5ff0 ("vfs: allow copy_file_range to copy across devices") the
> > > kernel would return -EXDEV to userspace when trying to copy a file across
> > > different filesystems.  After this commit, the syscall doesn't fail anymore
> > > and instead returns zero (zero bytes copied), as this file's content is
> > > generated on-the-fly and thus reports a size of zero.
> > >
> > > This patch restores some cross-filesystem copy restrictions that existed
> > > prior to commit 5dae222a5ff0 ("vfs: allow copy_file_range to copy across
> > > devices").  Filesystems are still allowed to fall-back to the VFS
> > > generic_copy_file_range() implementation, but that has now to be done
> > > explicitly.
> > >
> > > nfsd is also modified to fall-back into generic_copy_file_range() in case
> > > vfs_copy_file_range() fails with -EOPNOTSUPP or -EXDEV.
> > >
> > > Fixes: 5dae222a5ff0 ("vfs: allow copy_file_range to copy across devices")
> > > Link: https://lore.kernel.org/linux-fsdevel/20210212044405.4120619-1-drinkcat@chromium.org/
> > > Link: https://lore.kernel.org/linux-fsdevel/CANMq1KDZuxir2LM5jOTm0xx+BnvW=ZmpsG47CyHFJwnw7zSX6Q@mail.gmail.com/
> > > Link: https://lore.kernel.org/linux-fsdevel/20210126135012.1.If45b7cdc3ff707bc1efa17f5366057d60603c45f@changeid/
> > > Reported-by: Nicolas Boichat <drinkcat@chromium.org>
> > > Reported-by: kernel test robot <oliver.sang@intel.com>
> > > Signed-off-by: Luis Henriques <lhenriques@suse.de>
> > > ---
> > > Changes since v9
> > > - the early return from the syscall when len is zero now checks if the
> > >   filesystem is implemented, returning -EOPNOTSUPP if it is not and 0
> > >   otherwise.  Issue reported by test robot.
> >
> > What issue was reported?
>
> Here's the link to my previous email:
>
> https://lore.kernel.org/linux-fsdevel/877dk1zibo.fsf@suse.de/
>

Sorry, I missed it. I guess the subject was not aluring enough ;-)

So your patch does not fix the root cause.
The solution is to remove the (len == 0) short-circuit as you first suggested.

The problem is this:
A program tries to check for CFR support by calling CFR with zero length.
The XFS filesystem driver (in the test robot report) supports CFR via the
remap_file_range() method in general, but not on the particular filesystem
instance that was formatted without reflink support.
The intention of the program was to test for CFR support on the particular
filesystem instance, so the short-circuit response is wrong.

Note that vfs_clone_file_range() does NOT short circuit (len == 0).
That is (allegedly) because it needs to call into the filesystem
method to know if the filesystem instance supports clone_file_range.

The reason that your patch is wrong is because the same situation
can happen with a filesystem driver that has a copy_file_range()
method, but a particular instance does not support copy_file_range().
For example, overlayfs has an ovl_copy_file_range() method, so it would
short circuit zero CFR, but if in a particular overlayfs, the upper fs does
not support CFR, then the overlayfs instance does not support CFR either.

> ... which reminds me that I need to also send a patch to fix the fstest.
> (Although the test as-is actually allowed to find this bug...)
>

Not sure why you'd want to fix the test.
The test check with a zero length file seems valid to me.

Thanks,
Amir.
