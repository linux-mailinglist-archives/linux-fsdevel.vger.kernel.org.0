Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58B747067F6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 May 2023 14:22:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231641AbjEQMWV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 17 May 2023 08:22:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231622AbjEQMWQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 17 May 2023 08:22:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20C6A59C7
        for <linux-fsdevel@vger.kernel.org>; Wed, 17 May 2023 05:22:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6E24064662
        for <linux-fsdevel@vger.kernel.org>; Wed, 17 May 2023 12:22:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BCD1C433D2;
        Wed, 17 May 2023 12:22:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684326132;
        bh=FS5hJLIreLmYThJX5ovyAKImggtvHjFjGWDpMaDKFWc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JYMTTNsCxNIR2lKiO4jCrnoncKKY7qe8QMkqkns9wwWOBt7TYudRDmGy79977hS/K
         SeOd6A+YuKMqGLLsUwk9JbqG3rOcI55NJmZCX/8G7LiPNS11KPEeqhAusJHSEsM2u3
         nbB2LmgEjbaN7Yq+i85MiCIvp37YwBRrlDMrtOauhhfxPn6ciX1tPuAChTuBsYATzI
         mCjNBvIQXAgtHly4a8WTfXRdrZ3vQM8Omuz/RgJDYJanCY3OE0zAWMTyZLhDEkF1M6
         wZZvwzSkYPwFbaAZIz8Gat1bv3SO+BHUUr6D5jofrbul7JSHx65Ykg45o3rnyf1mpB
         JzV/L84cZrKJQ==
Date:   Wed, 17 May 2023 14:22:07 +0200
From:   Carlos Maiolino <cem@kernel.org>
To:     Hugh Dickins <hughd@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Christian Brauner <brauner@kernel.org>, jack@suse.cz,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        djwong@kernel.org
Subject: Re: [PATCH V4 0/6] shmem: Add user and group quota support for tmpfs
Message-ID: <20230517122207.we22cdv5fd5krycm@andromeda>
References: <p9LagXdw-LiFcxInjRmJLqLkzLqVNNSLD3tgGy8JvvgCPGI7k-7Aaxu5gpTG0Kyy3tXWAbNZT8ZUzAH1eFW4qw==@protonmail.internalid>
 <20230426102008.2930932-1-cem@kernel.org>
 <20230515085439.5s5n4xxljgl6e5jl@andromeda>
 <12rt-sYUxmvAXLbmaMhLA_ap2EaJmFK5iu4EhdH7UESkGam2ac8u6viRVotk1nIJ69uLzucT_tIXNeSS9B1dEA==@protonmail.internalid>
 <f0c4b9c1-e131-fa4c-e07-7466a2e2f98@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f0c4b9c1-e131-fa4c-e07-7466a2e2f98@google.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, May 17, 2023 at 03:50:47AM -0700, Hugh Dickins wrote:
> Hi Carlos,
> 
> On Mon, 15 May 2023, Carlos Maiolino wrote:
> > On Wed, Apr 26, 2023 at 12:20:02PM +0200, cem@kernel.org wrote:
> > > From: Carlos Maiolino <cem@kernel.org>
> > >
> > > Hello folks.
> > >
> > > This is the final version of the quota support from tmpfs, with all the issues
> > > addressed, and now including RwB tags on all patches, and should be ready for
> > > merge. Details are within each patch, and the original cover-letter below.
> > >
> >
> > Ping? Can somebody manage to pickup these patches?
> 
> Sorry, but it won't be me picking them up.  Let's Cc Andrew Morton,
> through whose mm tree mm/shmem.c patches usually go.  fs-wide updates
> often go through the fs tree, but this is not really in that category:
> it's a specific addition of a feature new to tmpfs; plus I see that
> Andrew did have plenty of quota involvement back in the day.  And let's
> Cc Christian Brauner, who was raising namespace questions in November.

Thanks, I spoke with Christian on the previous thread. I believe we are all set
in there by now.
> 
> tmpfs quotas: not a feature that I was ever hoping for, though I might
> have joked about it twenty years ago.  Already we had the nr_blocks=
> or size= restriction; and the vm_enough_memory strict-non-overcommit
> restriction; and later the memcg charging restriction.  Nowadays,
> with namespaces (and tmpfs FS_USERNS_MOUNT), I'd have imagined that
> the natural way to proceed would be to mount a size-limited tmpfs
> into the namespace of the user to be limited - but I'm no system
> designer, and likely just boasting my ignorance of namespaces again.
> 
> It does look as if Lukas and you have done a good job here:
> it's a much lighter "invasion" than I was expecting (and the
> de-indentation changes looked reasonable to me too, though I didn't
> check through them).  I was puzzled where the i_blocks accounting
> had vanished, but found it eventually in the dquot stubs.
> 
> So, I don't have an actual objection, and it counts for a lot that
> you have Jan Kara on board; but this is not work that I shall be able
> to support myself (I'll rarely even turn the CONFIG on).  If Andrew
> thinks it should go in, then you will be needed to maintain it.

Sounds reasonable.

> 
> IIRC there's an outstanding issue, that namespaces are not properly
> supported here.  Given Christian's work on idmapping, that will be
> unfortunate; but if it's just that you were waiting for the base
> series to go in, before correcting the namespace situation, that's
> understandable and should not delay further - but I hope that you
> know what more is needed, and that it won't add much more code.

Yup, I didn't want to add more features here by now to avoid further delays to
have the basic series merged, both things I plan to implement here by now are
userns support and prjquotas. Both AFAIK won't really need too much extra code,
but will add more overhead on people to review, so having them as separated series
and not part of the basic quota implementation, should ease the burden a bit.

> 
> Hugh
> 
> >
> > Thanks!
> >
> > > Hi folks. this work has been done originally by Lukas, but he left the company,
> > > so I'm taking over his work from where he left it of. This series is virtually
> > > done, and he had updated it with comments from the last version, but, I'm
> > > initially posting it as a RFC because it's been a while since he posted the
> > > last version.
> > > Most of what I did here was rebase his last work on top of current Linus's tree.
> > >
> > > Honza, there is one patch from you in this series, which I believe you had it
> > > suggested to Lukas on a previous version.
> > >
> > > The original cover-letter follows...
> > >
> > > people have been asking for quota support in tmpfs many times in the past
> > > mostly to avoid one malicious user, or misbehaving user/program to consume
> > > all of the system memory. This has been partially solved with the size
> > > mount option, but some problems still prevail.
> > >
> > > One of the problems is the fact that /dev/shm is still generally unprotected
> > > with this and another is administration overhead of managing multiple tmpfs
> > > mounts and lack of more fine grained control.
> > >
> > > Quota support can solve all these problems in a somewhat standard way
> > > people are already familiar with from regular file systems. It can give us
> > > more fine grained control over how much memory user/groups can consume.
> > > Additionally it can also control number of inodes and with special quota
> > > mount options introduced with a second patch we can set global limits
> > > allowing us to replace the size mount option with quota entirely.
> > >
> > > Currently the standard userspace quota tools (quota, xfs_quota) are only
> > > using quotactl ioctl which is expecting a block device. I patched quota [1]
> > > and xfs_quota [2] to use quotactl_fd in case we want to run the tools on
> > > mount point directory to work nicely with tmpfs.
> > >
> > > The implementation was tested on patched version of xfstests [3].
> > >
> > > [1] https://github.com/lczerner/quota/tree/quotactl_fd_support
> > > [2] https://github.com/lczerner/xfsprogs/tree/quotactl_fd_support
> > > [3] https://github.com/lczerner/xfstests/tree/tmpfs_quota_support
> > >
> > >
> > > Jan Kara (1):
> > >   quota: Check presence of quota operation structures instead of
> > >     ->quota_read and ->quota_write callbacks
> > >
> > > Lukas Czerner (5):
> > >   shmem: make shmem_inode_acct_block() return error
> > >   shmem: make shmem_get_inode() return ERR_PTR instead of NULL
> > >   shmem: prepare shmem quota infrastructure
> > >   shmem: quota support
> > >   Add default quota limit mount options
> > >
> > >  Documentation/filesystems/tmpfs.rst |  31 ++
> > >  fs/Kconfig                          |  12 +
> > >  fs/quota/dquot.c                    |   2 +-
> > >  include/linux/shmem_fs.h            |  28 ++
> > >  include/uapi/linux/quota.h          |   1 +
> > >  mm/Makefile                         |   2 +-
> > >  mm/shmem.c                          | 465 +++++++++++++++++++++-------
> > >  mm/shmem_quota.c                    | 350 +++++++++++++++++++++
> > >  8 files changed, 783 insertions(+), 108 deletions(-)
> > >  create mode 100644 mm/shmem_quota.c
> > >
> > > Signed-off-by: Carlos Maiolino <cmaiolino@redhat.com>
> > > --
> > > 2.30.2
> > >
> >
> > --
> > Carlos Maiolino

-- 
Carlos Maiolino
