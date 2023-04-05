Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C8AC6D7A1F
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Apr 2023 12:44:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237505AbjDEKog (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 Apr 2023 06:44:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237435AbjDEKof (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 Apr 2023 06:44:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97A6C4ED0
        for <linux-fsdevel@vger.kernel.org>; Wed,  5 Apr 2023 03:44:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2EFAD63C53
        for <linux-fsdevel@vger.kernel.org>; Wed,  5 Apr 2023 10:44:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B140C433D2;
        Wed,  5 Apr 2023 10:44:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680691473;
        bh=+cdhz2CMx94Qpiww/9dH8jB4BLwMUhhDy7fTZNjLdp4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mArROwVXu//vCpGUXIitInQ5I5HqBYxVVS748op1IiLt+II5NVOMS+E2HPHJsRR8y
         KYs1PhUKVicStYgO5WX6ywbOPnjWLgqJcQa0FlaUkf+lA0VNGe4rB9xVOZEtDivOao
         s4vmltB0aG8ReGGpaa2Qu+vpC5z5z9ZLXCQZ7JlVMNWfex7FDuuTRqTdsQlZedR63e
         WC+tDFK3xvHxPEgHPfNEEPK0aHbI+s9up7xnS5rXdhMgj/+6Kq9kbSi5/LXaX4uLvq
         HRhvnmmmw0ATD9MbqVloNXbqXFV6PlR88/0bdWvyWIoNcnP9sF5olPDNRw9fC4stxh
         TAAiOJy467HkA==
Date:   Wed, 5 Apr 2023 12:44:27 +0200
From:   Carlos Maiolino <cem@kernel.org>
To:     Christian Brauner <brauner@kernel.org>
Cc:     hughd@google.com, jack@suse.cz, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, djwong@kernel.org
Subject: Re: [PATCH 0/6] shmem: Add user and group quota support for tmpfs
Message-ID: <20230405104427.rndb5skuubfhucpv@andromeda>
References: <20230403084759.884681-1-cem@kernel.org>
 <fdtiyXbw8TmG_ejIJ5vPraJdjBI167s5n57S8oBv03Q0TzQZc1TE_rf4qJ3_NVURUq7L56qAOqkEhAjLJE_1Tw==@protonmail.internalid>
 <20230405-klarkommen-zellkern-03af0950b80f@brauner>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230405-klarkommen-zellkern-03af0950b80f@brauner>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Christian.

On Wed, Apr 05, 2023 at 10:52:44AM +0200, Christian Brauner wrote:
> On Mon, Apr 03, 2023 at 10:47:53AM +0200, cem@kernel.org wrote:
> > From: Carlos Maiolino <cmaiolino@redhat.com>
> >
> > Hi folks. this work has been done originally by Lukas, but he left the company,
> > so I'm taking over his work from where he left it of. This series is virtually
> > done, and he had updated it with comments from the last version, but, I'm
> 
> I've commented on the last version:
> 
> https://lore.kernel.org/linux-fsdevel/20221129112133.rrpoywlwdw45k3qa@wittgenstein
> 
> trying to point out that tmpfs can be mounted in user namespaces. Which
> means that the quota uids and gids need to take the idmapping of the
> user namespace in which the tmpfs instances is mounted in into account;
> not the one on the host.
> 
> See the link above for some details. Before we can merge this it would
> be very good if we could get tests that verify tmpfs being mounted
> inside a userns with quotas enabled because I don't think this is
> covered yet by xfstests. Or you punt on it for now and restricted quotas
> to tmpfs instances mounted on the host.
> 

Thanks for the link, I've read it before, and this is by now a limitation I'd
like to keep in this series. I can extend it to be namespace aware later on, but
the current goal of this series is to be able tmpfs mounts on the host to limit
the amount of memory consumed by users. Being namespace aware is something I
plan to work later. Because as you said, it needs more testing coverage, which
will only delay the main goal of this series, which again, is to avoid users to
consume all memory in the host itself.

> > initially posting it as a RFC because it's been a while since he posted the
> > last version.
> > Most of what I did here was rebase his last work on top of current Linus's tree.
> >
> > Honza, there is one patch from you in this series, which I believe you had it
> > suggested to Lukas on a previous version.
> >
> > The original cover-letter follows...
> >
> > people have been asking for quota support in tmpfs many times in the past
> > mostly to avoid one malicious user, or misbehaving user/program to consume
> > all of the system memory. This has been partially solved with the size
> > mount option, but some problems still prevail.
> >
> > One of the problems is the fact that /dev/shm is still generally unprotected
> > with this and another is administration overhead of managing multiple tmpfs
> > mounts and lack of more fine grained control.
> >
> > Quota support can solve all these problems in a somewhat standard way
> > people are already familiar with from regular file systems. It can give us
> > more fine grained control over how much memory user/groups can consume.
> > Additionally it can also control number of inodes and with special quota
> > mount options introduced with a second patch we can set global limits
> > allowing us to replace the size mount option with quota entirely.
> >
> > Currently the standard userspace quota tools (quota, xfs_quota) are only
> > using quotactl ioctl which is expecting a block device. I patched quota [1]
> > and xfs_quota [2] to use quotactl_fd in case we want to run the tools on
> > mount point directory to work nicely with tmpfs.
> >
> > The implementation was tested on patched version of xfstests [3].
> >
> >
> > Jan Kara (1):
> >   quota: Check presence of quota operation structures instead of
> >     ->quota_read and ->quota_write callbacks
> >
> > Lukas Czerner (5):
> >   shmem: make shmem_inode_acct_block() return error
> >   shmem: make shmem_get_inode() return ERR_PTR instead of NULL
> >   shmem: prepare shmem quota infrastructure
> >   shmem: quota support
> >   Add default quota limit mount options
> >
> >  Documentation/filesystems/tmpfs.rst |  28 ++
> >  fs/Kconfig                          |  12 +
> >  fs/quota/dquot.c                    |   2 +-
> >  include/linux/shmem_fs.h            |  25 ++
> >  include/uapi/linux/quota.h          |   1 +
> >  mm/Makefile                         |   2 +-
> >  mm/shmem.c                          | 452 +++++++++++++++++++++-------
> >  mm/shmem_quota.c                    | 327 ++++++++++++++++++++
> >  8 files changed, 740 insertions(+), 109 deletions(-)
> >  create mode 100644 mm/shmem_quota.c
> >
> > --
> > 2.30.2
> >

-- 
Carlos Maiolino
