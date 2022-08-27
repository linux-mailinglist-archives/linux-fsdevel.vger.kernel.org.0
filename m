Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E0075A3593
	for <lists+linux-fsdevel@lfdr.de>; Sat, 27 Aug 2022 09:26:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232940AbiH0H0i (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 27 Aug 2022 03:26:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229639AbiH0H0h (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 27 Aug 2022 03:26:37 -0400
Received: from mail-vs1-xe31.google.com (mail-vs1-xe31.google.com [IPv6:2607:f8b0:4864:20::e31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8338DD571C;
        Sat, 27 Aug 2022 00:26:35 -0700 (PDT)
Received: by mail-vs1-xe31.google.com with SMTP id d126so3633369vsd.13;
        Sat, 27 Aug 2022 00:26:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=cgoz7UyBRMYBFxq8Rv6GdAKPo6AlZqRV0UakCmAojIs=;
        b=HvBB9UUZzJriK2fLBraBUzKdfk8lxRTgCMkUlr6/APEtCRcKsg6fzgj03fFvQpaRli
         ycliU/q/xkphqBTePc/5b3fSC/y0FAQqPnWQ47RnsGSoRigaMYomdSuwE4YT/V8MR3Ok
         nRirE8HbDBkXx0kqe4PqGm7QdlImEN7LDdHLyskmTPnqk74smA0QVYJ70WC4aeA+U7TY
         X5xMi6OwRvK56Y9lUFuubpfwyYoHU+UCHt6iq2Ndy/iywa0l1Io0FHyHUa1OGImWW6iY
         eYRM5Ro8OxHvynNYZiGbY1Ts93TvLSTGLKSNLlefD43nSauozwvumflTjuf4NwyFz73X
         YKkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=cgoz7UyBRMYBFxq8Rv6GdAKPo6AlZqRV0UakCmAojIs=;
        b=4N6OdnMy3Pm0SV0UxxvvFuUT9mqXpDqg0N0vlkcWnn+SQ6QCB7jLvFcw2OGshMcW5V
         brANLcyPMy1FWrfv5cIFQ1oPlOYUJxQPVv6GoWOxJU5MgBAFA4r+cRfLD7AFLqIGsFUt
         2FTLU0woVxV0I4QYejFIPlgXcp2fsV8P2eIcVxxG8NcrVMdUzuA4o2/FRh2Tr5di89wR
         Ei4N1GhjcChg9DeCwghUWj0ztKcjV4JeWE3aDlEbRsV/CuBmxfw2GMcLzI+oh/BxizFu
         kbm1glK3TemlzCtBZQUql7rpjvX2PyBx8azWEicbzaJqmx5svY963miumkSM+GPsuHAq
         87IA==
X-Gm-Message-State: ACgBeo3h4YPPV+Xj+kTCR7rHDVwRmbFbwKG3FaKMNup1U/A74FX9UYHN
        IXSCtde3lUX0zi2E3NQlM9nRDIH6wcZfy6tvJaM=
X-Google-Smtp-Source: AA6agR6ppzBKuL8ze0P7YMSd9CX5ppxdXWzstreFFOCD+uJ+Qt8LROiCpIu3dDfAd2EjN3hh+hIzK0zkkgo7LlY5yPU=
X-Received: by 2002:a67:b90f:0:b0:390:cb3e:efb8 with SMTP id
 q15-20020a67b90f000000b00390cb3eefb8mr186171vsn.71.1661585194660; Sat, 27 Aug
 2022 00:26:34 -0700 (PDT)
MIME-Version: 1.0
References: <20220826214703.134870-1-jlayton@kernel.org> <20220826214703.134870-5-jlayton@kernel.org>
In-Reply-To: <20220826214703.134870-5-jlayton@kernel.org>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Sat, 27 Aug 2022 10:26:23 +0300
Message-ID: <CAOQ4uxjzE_B_EQktLr8z8gXOhFDNm-_YpUTycfZCdaZNp-i0hQ@mail.gmail.com>
Subject: Re: [PATCH v3 4/7] xfs: don't bump the i_version on an atime update
 in xfs_vn_update_time
To:     Jeff Layton <jlayton@kernel.org>
Cc:     Theodore Tso <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Dave Chinner <david@fromorbit.com>,
        Trond Myklebust <trondmy@hammerspace.com>,
        Neil Brown <neilb@suse.de>, Al Viro <viro@zeniv.linux.org.uk>,
        Mimi Zohar <zohar@linux.ibm.com>, xiubli@redhat.com,
        Chuck Lever <chuck.lever@oracle.com>,
        Lukas Czerner <lczerner@redhat.com>, Jan Kara <jack@suse.cz>,
        Christian Brauner <brauner@kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Linux Btrfs <linux-btrfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-ceph@vger.kernel.org, Ext4 <linux-ext4@vger.kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        David Wysochanski <dwysocha@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Aug 27, 2022 at 12:49 AM Jeff Layton <jlayton@kernel.org> wrote:
>
> xfs will update the i_version when updating only the atime value, which
> is not desirable for any of the current consumers of i_version. Doing so
> leads to unnecessary cache invalidations on NFS and extra measurement
> activity in IMA.
>
> Add a new XFS_ILOG_NOIVER flag, and use that to indicate that the
> transaction should not update the i_version. Set that value in
> xfs_vn_update_time if we're only updating the atime.
>
> Cc: Dave Chinner <david@fromorbit.com>
> Cc: NeilBrown <neilb@suse.de>
> Cc: Trond Myklebust <trondmy@hammerspace.com>
> Cc: David Wysochanski <dwysocha@redhat.com>
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
>  fs/xfs/libxfs/xfs_log_format.h  |  2 +-
>  fs/xfs/libxfs/xfs_trans_inode.c |  2 +-
>  fs/xfs/xfs_iops.c               | 11 +++++++++--
>  3 files changed, 11 insertions(+), 4 deletions(-)
>
> Dave has NACK'ed this patch, but I'm sending it as a way to illustrate
> the problem. I still think this approach should at least fix the worst
> problems with atime updates being counted. We can look to carve out
> other "spurious" i_version updates as we identify them.
>

AFAIK, "spurious" is only inode blocks map changes due to writeback
of dirty pages. Anybody know about other cases?

Regarding inode blocks map changes, first of all, I don't think that there is
any practical loss from invalidating NFS client cache on dirty data writeback,
because NFS server should be serving cold data most of the time.
If there are a few unneeded cache invalidations they would only be temporary.

One may even consider if NFSv4 server should not flush dirty data of an inode
before granting a read lease to client.
After all, if read lease was granted, client cached data and then server crashed
before persisting the dirty data, then client will have cached a
"future" version
of the data and if i_version on the server did not roll back in that situation,
we are looking at possible data corruptions.

Same goes for IMA. IIUC, IMA data checksum would be stored in xattr?
Storing in xattr a data checksum for data that is not persistent on disk
would be an odd choice.

So in my view, I only see benefits to current i_version users in the xfs
i_version implementations and I don't think that it contradicts the
i_version definition in the man page patch.

> If however there are offline analysis tools that require atime updates
> to be counted, then we won't be able to do this. If that's the case, how
> can we fix this such that serving xfs via NFSv4 doesn't suck?
>

If I read the arguments correctly, implicit atime updates could be relaxed
as long as this behavior is clearly documented and coherent on all
implementations.

Forensics and other applications that care about atime updates can and
should check atime and don't need i_version to know that it was changed.
The reliability of atime as an audit tool has dropped considerably since
the default in relatime.
If we want to be paranoid, maybe we can leave i_version increment on
atime updates in case the user opted-in to strict '-o atime' updates, but
IMO, there is no need for that.

Thanks,
Amir.
