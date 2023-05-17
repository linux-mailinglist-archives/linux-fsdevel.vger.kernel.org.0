Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A495D706596
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 May 2023 12:51:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230039AbjEQKvF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 17 May 2023 06:51:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229681AbjEQKvE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 17 May 2023 06:51:04 -0400
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 379301FE5
        for <linux-fsdevel@vger.kernel.org>; Wed, 17 May 2023 03:51:03 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id 3f1490d57ef6-ba82059eec9so818224276.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 17 May 2023 03:51:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684320662; x=1686912662;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=7Gw/nFgM66W0F1hY4dIi8SPI28fmRbulPvC24clCLJA=;
        b=pJzVo6K67r/UjoBgbbGrnyKigA7vtgWFvU0DJ8IkMVQoZNXk0Lp+VJDL1iIYpd81Fc
         OKtvFy7VHXpoI9aCRITXtzueOFOyU8q2O8+ArD/oa6dhUfMPTKVhaH1hnN51fY7COCb9
         f3cthPAJeMzsrWZqamoYpdzz0SHmWO8mtr6x++Df3bGqczuaadpmB+WGDaKY7dRngvYG
         aaFupDNxm+++nsfhpyMl5cIvL87fZoQUqHGeVYkoyg9bGoLX5iXIFl6PWpcewvXp92Ki
         ZxHqIKBDhWkoRUiJpS9uAL7gzaJFsWzySZi3LS0iOPMIAhP7cjZwEW7KRrbJsgeq+IGC
         H++A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684320662; x=1686912662;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7Gw/nFgM66W0F1hY4dIi8SPI28fmRbulPvC24clCLJA=;
        b=H5b+Cq4/P0vuINoR1Ci9SazXcul8I8oArlet71C38z5qsFDL1hRINENlpQfuQ0btUw
         rU9wcZz1f/ZRuZll3ltEwjh9JnZnKs+EowtZ9trK8KchqpzzpTGqRt0ROFV8rBVztLo8
         OJxuslZNczjwx1PouI93APzAp4rlBM2Dy8xR7DLcFwIbQgH3NOibaM//uTuNQ+P5xrND
         /7Dvlsj6VsLzjwleMqDPEwbtWHwckSsJQFjKZuXkO5v8IO9leut7uZq664UlSNxdrH2v
         yqJds141I4l3QZIc6xdJhBYBxPgzlTOgu1H9ceFuLR1iHmXW5NWQo1ml6nyaxHZyi2sW
         2vxg==
X-Gm-Message-State: AC+VfDxTGtEONJTzqWZNbsvP9XAJqwk6wKWEozdms3g/S10OhBLNqmbj
        k82HOAtIQhcsrBdCYDrSm4ZzbA==
X-Google-Smtp-Source: ACHHUZ7RC+7ZD3UcS0XihTT69tZ7H6BUD9A9plffuHCSn5RjytFWbP+Ilr0C4BpxW7Qc/TJ90Woxow==
X-Received: by 2002:a25:6801:0:b0:b9e:453e:d0c4 with SMTP id d1-20020a256801000000b00b9e453ed0c4mr35279378ybc.28.1684320662248;
        Wed, 17 May 2023 03:51:02 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id 67-20020a250f46000000b00b9d8612a8bbsm478874ybp.16.2023.05.17.03.51.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 May 2023 03:51:01 -0700 (PDT)
Date:   Wed, 17 May 2023 03:50:47 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.attlocal.net
To:     Carlos Maiolino <cem@kernel.org>
cc:     Andrew Morton <akpm@linux-foundation.org>,
        Christian Brauner <brauner@kernel.org>, hughd@google.com,
        jack@suse.cz, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        djwong@kernel.org
Subject: Re: [PATCH V4 0/6] shmem: Add user and group quota support for
 tmpfs
In-Reply-To: <20230515085439.5s5n4xxljgl6e5jl@andromeda>
Message-ID: <f0c4b9c1-e131-fa4c-e07-7466a2e2f98@google.com>
References: <p9LagXdw-LiFcxInjRmJLqLkzLqVNNSLD3tgGy8JvvgCPGI7k-7Aaxu5gpTG0Kyy3tXWAbNZT8ZUzAH1eFW4qw==@protonmail.internalid> <20230426102008.2930932-1-cem@kernel.org> <20230515085439.5s5n4xxljgl6e5jl@andromeda>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Carlos,

On Mon, 15 May 2023, Carlos Maiolino wrote:
> On Wed, Apr 26, 2023 at 12:20:02PM +0200, cem@kernel.org wrote:
> > From: Carlos Maiolino <cem@kernel.org>
> > 
> > Hello folks.
> > 
> > This is the final version of the quota support from tmpfs, with all the issues
> > addressed, and now including RwB tags on all patches, and should be ready for
> > merge. Details are within each patch, and the original cover-letter below.
> > 
> 
> Ping? Can somebody manage to pickup these patches?

Sorry, but it won't be me picking them up.  Let's Cc Andrew Morton,
through whose mm tree mm/shmem.c patches usually go.  fs-wide updates
often go through the fs tree, but this is not really in that category:
it's a specific addition of a feature new to tmpfs; plus I see that
Andrew did have plenty of quota involvement back in the day.  And let's
Cc Christian Brauner, who was raising namespace questions in November.

tmpfs quotas: not a feature that I was ever hoping for, though I might
have joked about it twenty years ago.  Already we had the nr_blocks=
or size= restriction; and the vm_enough_memory strict-non-overcommit
restriction; and later the memcg charging restriction.  Nowadays,
with namespaces (and tmpfs FS_USERNS_MOUNT), I'd have imagined that
the natural way to proceed would be to mount a size-limited tmpfs
into the namespace of the user to be limited - but I'm no system
designer, and likely just boasting my ignorance of namespaces again.

It does look as if Lukas and you have done a good job here:
it's a much lighter "invasion" than I was expecting (and the
de-indentation changes looked reasonable to me too, though I didn't
check through them).  I was puzzled where the i_blocks accounting
had vanished, but found it eventually in the dquot stubs.

So, I don't have an actual objection, and it counts for a lot that
you have Jan Kara on board; but this is not work that I shall be able
to support myself (I'll rarely even turn the CONFIG on).  If Andrew
thinks it should go in, then you will be needed to maintain it.

IIRC there's an outstanding issue, that namespaces are not properly
supported here.  Given Christian's work on idmapping, that will be
unfortunate; but if it's just that you were waiting for the base
series to go in, before correcting the namespace situation, that's
understandable and should not delay further - but I hope that you
know what more is needed, and that it won't add much more code.

Hugh

> 
> Thanks!
> 
> > Hi folks. this work has been done originally by Lukas, but he left the company,
> > so I'm taking over his work from where he left it of. This series is virtually
> > done, and he had updated it with comments from the last version, but, I'm
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
> > [1] https://github.com/lczerner/quota/tree/quotactl_fd_support
> > [2] https://github.com/lczerner/xfsprogs/tree/quotactl_fd_support
> > [3] https://github.com/lczerner/xfstests/tree/tmpfs_quota_support
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
> >  Documentation/filesystems/tmpfs.rst |  31 ++
> >  fs/Kconfig                          |  12 +
> >  fs/quota/dquot.c                    |   2 +-
> >  include/linux/shmem_fs.h            |  28 ++
> >  include/uapi/linux/quota.h          |   1 +
> >  mm/Makefile                         |   2 +-
> >  mm/shmem.c                          | 465 +++++++++++++++++++++-------
> >  mm/shmem_quota.c                    | 350 +++++++++++++++++++++
> >  8 files changed, 783 insertions(+), 108 deletions(-)
> >  create mode 100644 mm/shmem_quota.c
> > 
> > Signed-off-by: Carlos Maiolino <cmaiolino@redhat.com>
> > --
> > 2.30.2
> > 
> 
> -- 
> Carlos Maiolino
