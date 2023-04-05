Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D1C36D775C
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Apr 2023 10:52:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237158AbjDEIw5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 Apr 2023 04:52:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237575AbjDEIwv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 Apr 2023 04:52:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 679292736
        for <linux-fsdevel@vger.kernel.org>; Wed,  5 Apr 2023 01:52:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D27B26250C
        for <linux-fsdevel@vger.kernel.org>; Wed,  5 Apr 2023 08:52:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78696C433EF;
        Wed,  5 Apr 2023 08:52:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680684769;
        bh=wYgRmC8GHygAyGX9rI+0LgBMbN+B6EtuGOcgW3nxjjM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KW5wp09ogccYlGl2btqkOVLVWsWyHLw3Ty3dy6n9wJyx+4B3AYDub8WdUX+YlJg1m
         E/vj3Rcvp63JEGim++24FcL1N8TyBYr2Aw5JWm9XLpRjAh53nLa3lCzOejwqH5MwKi
         nuLKnxrPuUwBaTDBjVFNsXpIeaXaKb8SKJWfDblVqIVN+BxCLGusFWt/UB8bnix9/1
         gnsamDqAN01klfi4OQav+my7V/097GE2/1OXzWf7JvOKvjg9LKyJiyhxEErIcH8DkH
         JtBsqka1NFmVKaTGpkO0T7i4Xi95ow0CBHhRh8JZbLWb1iZT4a345a7DjrLpfAhsOb
         fYoWH93OCByoA==
Date:   Wed, 5 Apr 2023 10:52:44 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     cem@kernel.org
Cc:     hughd@google.com, jack@suse.cz, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, djwong@kernel.org
Subject: Re: [PATCH 0/6] shmem: Add user and group quota support for tmpfs
Message-ID: <20230405-klarkommen-zellkern-03af0950b80f@brauner>
References: <20230403084759.884681-1-cem@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230403084759.884681-1-cem@kernel.org>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Apr 03, 2023 at 10:47:53AM +0200, cem@kernel.org wrote:
> From: Carlos Maiolino <cmaiolino@redhat.com>
> 
> Hi folks. this work has been done originally by Lukas, but he left the company,
> so I'm taking over his work from where he left it of. This series is virtually
> done, and he had updated it with comments from the last version, but, I'm

I've commented on the last version:

https://lore.kernel.org/linux-fsdevel/20221129112133.rrpoywlwdw45k3qa@wittgenstein

trying to point out that tmpfs can be mounted in user namespaces. Which
means that the quota uids and gids need to take the idmapping of the
user namespace in which the tmpfs instances is mounted in into account;
not the one on the host.

See the link above for some details. Before we can merge this it would
be very good if we could get tests that verify tmpfs being mounted
inside a userns with quotas enabled because I don't think this is
covered yet by xfstests. Or you punt on it for now and restricted quotas
to tmpfs instances mounted on the host.

> initially posting it as a RFC because it's been a while since he posted the
> last version.
> Most of what I did here was rebase his last work on top of current Linus's tree.
> 
> Honza, there is one patch from you in this series, which I believe you had it
> suggested to Lukas on a previous version.
> 
> The original cover-letter follows...
> 
> people have been asking for quota support in tmpfs many times in the past
> mostly to avoid one malicious user, or misbehaving user/program to consume
> all of the system memory. This has been partially solved with the size
> mount option, but some problems still prevail.
> 
> One of the problems is the fact that /dev/shm is still generally unprotected
> with this and another is administration overhead of managing multiple tmpfs
> mounts and lack of more fine grained control.
> 
> Quota support can solve all these problems in a somewhat standard way
> people are already familiar with from regular file systems. It can give us
> more fine grained control over how much memory user/groups can consume.
> Additionally it can also control number of inodes and with special quota
> mount options introduced with a second patch we can set global limits
> allowing us to replace the size mount option with quota entirely.
> 
> Currently the standard userspace quota tools (quota, xfs_quota) are only
> using quotactl ioctl which is expecting a block device. I patched quota [1]
> and xfs_quota [2] to use quotactl_fd in case we want to run the tools on
> mount point directory to work nicely with tmpfs.
> 
> The implementation was tested on patched version of xfstests [3].
> 
> 
> Jan Kara (1):
>   quota: Check presence of quota operation structures instead of
>     ->quota_read and ->quota_write callbacks
> 
> Lukas Czerner (5):
>   shmem: make shmem_inode_acct_block() return error
>   shmem: make shmem_get_inode() return ERR_PTR instead of NULL
>   shmem: prepare shmem quota infrastructure
>   shmem: quota support
>   Add default quota limit mount options
> 
>  Documentation/filesystems/tmpfs.rst |  28 ++
>  fs/Kconfig                          |  12 +
>  fs/quota/dquot.c                    |   2 +-
>  include/linux/shmem_fs.h            |  25 ++
>  include/uapi/linux/quota.h          |   1 +
>  mm/Makefile                         |   2 +-
>  mm/shmem.c                          | 452 +++++++++++++++++++++-------
>  mm/shmem_quota.c                    | 327 ++++++++++++++++++++
>  8 files changed, 740 insertions(+), 109 deletions(-)
>  create mode 100644 mm/shmem_quota.c
> 
> -- 
> 2.30.2
> 
