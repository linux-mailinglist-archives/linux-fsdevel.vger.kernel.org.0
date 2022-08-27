Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE41D5A35BD
	for <lists+linux-fsdevel@lfdr.de>; Sat, 27 Aug 2022 10:01:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233440AbiH0IBj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 27 Aug 2022 04:01:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232714AbiH0IBg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 27 Aug 2022 04:01:36 -0400
Received: from mail-vk1-xa33.google.com (mail-vk1-xa33.google.com [IPv6:2607:f8b0:4864:20::a33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CDE113CD5;
        Sat, 27 Aug 2022 01:01:34 -0700 (PDT)
Received: by mail-vk1-xa33.google.com with SMTP id x66so1643591vkb.8;
        Sat, 27 Aug 2022 01:01:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=lwvI7PLzkJuaBaozMxeG7nv4bRh7oWZ5nXAiBzjSaKw=;
        b=dKfQlFbcX0HvJpVVBCaYeQasNqBpkhEBpPsrJ/BQB40gSoearOxUSOtr7sx4MBS8H1
         DJprxt7L8G+irPqjTBB+fsvGN/tttJK0Rr4InrrNvUUIgT4NSN7TJuLri7eiyk+4Zbhb
         f5EUlw3qI8+o2bqO5juhg4puJhc9hbQELVoTNFVSOPBw99hPZPduUeWWI9A7F5A8nAIZ
         5OBmGyihqZtONFkWRlIkLPiNMj/AHhKKYdIjbUHulltfzcIw72/lV3zLaTkTLRWIocCq
         bkN2P4xnnk7eIJg530eM4/ElNThc9atpqEPn1D5vbkIttkDxypZbm0JprEGNHbDBKtpY
         e04w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=lwvI7PLzkJuaBaozMxeG7nv4bRh7oWZ5nXAiBzjSaKw=;
        b=T1I3m+1CVStu5urUIj3JP7z5poY4/pyTMr3PBX6ivZT6CFWm4pS9Vb+ZMhk9EduEN2
         JkmAaz1tB9DejqPuPJuQgoK1sg+xQih2FOBgcu0MVpkKDrd4J0IsGK2MSNfQF9MbLart
         23rPiy/YHjgvZEnVE+hpNE8lqstykLIjTIq3RMppKybBavj/cFf+W602yb+IYZQHwAOU
         US9fhPCjSzpUx9f993Lg4CRGzLKt6Q/sbslfXRI1Si8Z+4eQslsIVlyZFlu5Vip6YWUo
         Uq1roL8ccd6GjMzpzuG1Jej8OIPRFwOVbvK9KfkF9FjrmT3ayciGSzh505xrHUQgCNwp
         83aA==
X-Gm-Message-State: ACgBeo1RmQHURRJcTxC+cBREmEp2K6FZSCySr+t6VSxIBGUVV9fV0VuA
        URRuhwu75dmqCkjfazhHyRkRDibiNVe6xgvxWq4=
X-Google-Smtp-Source: AA6agR4mVbX5F1wkDbMHeki6nd0b18/8F4ObuQhDt1kzSdi9ixc7OuAhNhUYuCdFe1SWrAaNuBG7037sSMcVrnhzDcU=
X-Received: by 2002:a05:6122:d86:b0:37d:3fe:df43 with SMTP id
 bc6-20020a0561220d8600b0037d03fedf43mr944417vkb.15.1661587293639; Sat, 27 Aug
 2022 01:01:33 -0700 (PDT)
MIME-Version: 1.0
References: <20220826214703.134870-1-jlayton@kernel.org> <20220826214703.134870-5-jlayton@kernel.org>
 <CAOQ4uxjzE_B_EQktLr8z8gXOhFDNm-_YpUTycfZCdaZNp-i0hQ@mail.gmail.com>
In-Reply-To: <CAOQ4uxjzE_B_EQktLr8z8gXOhFDNm-_YpUTycfZCdaZNp-i0hQ@mail.gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Sat, 27 Aug 2022 11:01:22 +0300
Message-ID: <CAOQ4uxge86g=+HPnds-wRXkFHg67G=m9rGK7V_T8yS+2=w9tmg@mail.gmail.com>
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
        Ext4 <linux-ext4@vger.kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        David Wysochanski <dwysocha@redhat.com>,
        ceph-devel <ceph-devel@vger.kernel.org>
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

On Sat, Aug 27, 2022 at 10:26 AM Amir Goldstein <amir73il@gmail.com> wrote:
>
> On Sat, Aug 27, 2022 at 12:49 AM Jeff Layton <jlayton@kernel.org> wrote:
> >
> > xfs will update the i_version when updating only the atime value, which
> > is not desirable for any of the current consumers of i_version. Doing so
> > leads to unnecessary cache invalidations on NFS and extra measurement
> > activity in IMA.
> >
> > Add a new XFS_ILOG_NOIVER flag, and use that to indicate that the
> > transaction should not update the i_version. Set that value in
> > xfs_vn_update_time if we're only updating the atime.
> >
> > Cc: Dave Chinner <david@fromorbit.com>
> > Cc: NeilBrown <neilb@suse.de>
> > Cc: Trond Myklebust <trondmy@hammerspace.com>
> > Cc: David Wysochanski <dwysocha@redhat.com>
> > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > ---
> >  fs/xfs/libxfs/xfs_log_format.h  |  2 +-
> >  fs/xfs/libxfs/xfs_trans_inode.c |  2 +-
> >  fs/xfs/xfs_iops.c               | 11 +++++++++--
> >  3 files changed, 11 insertions(+), 4 deletions(-)
> >
> > Dave has NACK'ed this patch, but I'm sending it as a way to illustrate
> > the problem. I still think this approach should at least fix the worst
> > problems with atime updates being counted. We can look to carve out
> > other "spurious" i_version updates as we identify them.
> >
>
> AFAIK, "spurious" is only inode blocks map changes due to writeback
> of dirty pages. Anybody know about other cases?
>
> Regarding inode blocks map changes, first of all, I don't think that there is
> any practical loss from invalidating NFS client cache on dirty data writeback,
> because NFS server should be serving cold data most of the time.
> If there are a few unneeded cache invalidations they would only be temporary.
>

Unless there is an issue with a writer NFS client that invalidates its
own attribute
caches on server data writeback?

> One may even consider if NFSv4 server should not flush dirty data of an inode
> before granting a read lease to client.
> After all, if read lease was granted, client cached data and then server crashed
> before persisting the dirty data, then client will have cached a
> "future" version
> of the data and if i_version on the server did not roll back in that situation,
> we are looking at possible data corruptions.
>
> Same goes for IMA. IIUC, IMA data checksum would be stored in xattr?
> Storing in xattr a data checksum for data that is not persistent on disk
> would be an odd choice.
>
> So in my view, I only see benefits to current i_version users in the xfs
> i_version implementations and I don't think that it contradicts the
> i_version definition in the man page patch.
>
> > If however there are offline analysis tools that require atime updates
> > to be counted, then we won't be able to do this. If that's the case, how
> > can we fix this such that serving xfs via NFSv4 doesn't suck?
> >
>
> If I read the arguments correctly, implicit atime updates could be relaxed
> as long as this behavior is clearly documented and coherent on all
> implementations.
>
> Forensics and other applications that care about atime updates can and
> should check atime and don't need i_version to know that it was changed.
> The reliability of atime as an audit tool has dropped considerably since
> the default in relatime.
> If we want to be paranoid, maybe we can leave i_version increment on
> atime updates in case the user opted-in to strict '-o atime' updates, but
> IMO, there is no need for that.
>
> Thanks,
> Amir.
