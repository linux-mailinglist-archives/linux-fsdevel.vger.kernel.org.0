Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA8CE2FC3C2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Jan 2021 23:40:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405617AbhASOdl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Jan 2021 09:33:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389615AbhASLwd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Jan 2021 06:52:33 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8299FC061574
        for <linux-fsdevel@vger.kernel.org>; Tue, 19 Jan 2021 03:51:52 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id a9so15978676wrt.5
        for <linux-fsdevel@vger.kernel.org>; Tue, 19 Jan 2021 03:51:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=6iDFCX/Z/S1DDiXef9jT5XZ0zdxhee10Uz0yBq4fmLI=;
        b=QqsAM21tvQy240MStC/Wl/85ukbKXUGN12T1rk/U+IBfPIKSbGuQtc99ACPsUVyOMg
         TM9Hn4Tr5OMuohwsIVex/Wt39moLYN56iIhJypZvpGoXf2M/NiqMK6AatMTKeJ+U15ny
         S7l4nw3RqV/yNhKnnj7kzwPpqzsIZWweRIzjkvZCf0Z90Wq/60DaAb6cV4c4rclap5hJ
         SYQFYSlwKeCYz3LJzZyvZWZRa9hxXj0Z9ercJ5SwYPpBHmw/fUIZ1pgHqIqGMBMRWSoB
         MOw7TWlHfbAT27JgvCi6lufI/QTReDK0dQ73jhkbC3t9jW7TtEN4MGd3HFu1v1xm9YeU
         nPew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6iDFCX/Z/S1DDiXef9jT5XZ0zdxhee10Uz0yBq4fmLI=;
        b=PmoAsMjoZeoS/f+Yjq1WUg5NSnfy9kzCXsNx5VQOnC8hDWRJtRMjh2bWEb+65dBzQ1
         z/4/CF3QVnsNJHX2aHTVdwAqFJ0BZNhWL0ADx/gFN0S6dJua33HMMUSf9DSYpY6En7pa
         HW3DDgPqW5VRCWupU2Nr1QVB/WHcgnnU+QuJrANHDstKX/z7CNHTvtMBLYwevtzZRkSp
         hopCJR0wF4P6T+RSoh6jIAQdmDZqtPv77V0hdh1iLfMrwDFPzJfOcIi8n00W5IOuYVVR
         fJ2JxDcN+xRkRaaS/WhAhklx9e5cdnN7EFtMugDz4FDAq42EnvMDdtno37/Ubd/jVWgo
         ho4w==
X-Gm-Message-State: AOAM532POkWEOZtJL6cbkZ4mQ3ItCaNgJlEMwv/53Xwk4J9+Ia6lwOHN
        4srDOxvUvJrfkN9DLy4y+XgaAQ==
X-Google-Smtp-Source: ABdhPJyzJT4CuiBOarxBJeUfrd160m0ck9QZcO6qU8n5MNGyn9JvKHa3WlsD5Hy0FO/d0GbFGCxj1Q==
X-Received: by 2002:a05:6000:1362:: with SMTP id q2mr1103822wrz.341.1611057111289;
        Tue, 19 Jan 2021 03:51:51 -0800 (PST)
Received: from google.com ([2a00:79e0:d:210:41d4:8c90:d38:455d])
        by smtp.gmail.com with ESMTPSA id g184sm4269649wma.16.2021.01.19.03.51.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jan 2021 03:51:50 -0800 (PST)
Date:   Tue, 19 Jan 2021 11:51:49 +0000
From:   Alessio Balsini <balsini@android.com>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Alessio Balsini <balsini@android.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Akilesh Kailash <akailash@google.com>,
        Antonio SJ Musumeci <trapexit@spawn.link>,
        David Anderson <dvander@google.com>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Jann Horn <jannh@google.com>, Jens Axboe <axboe@kernel.dk>,
        Martijn Coenen <maco@android.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Lawrence <paullawrence@google.com>,
        Peng Tao <bergwolf@gmail.com>,
        Stefano Duo <duostefano93@gmail.com>,
        Zimuzo Ezeozue <zezeozue@google.com>, wuyan <wu-yan@tcl.com>,
        fuse-devel <fuse-devel@lists.sourceforge.net>,
        kernel-team <kernel-team@android.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH RESEND V11 3/7] fuse: Definitions and ioctl for
 passthrough
Message-ID: <YAbH1YuffGDXt67h@google.com>
References: <20210118192748.584213-1-balsini@android.com>
 <20210118192748.584213-4-balsini@android.com>
 <CAOQ4uxj-Ncm7nKBZE_homGu_kcF0w1JtYcC9zg2=uWT591Ggbw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxj-Ncm7nKBZE_homGu_kcF0w1JtYcC9zg2=uWT591Ggbw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jan 19, 2021 at 08:33:16AM +0200, Amir Goldstein wrote:
> On Mon, Jan 18, 2021 at 9:28 PM Alessio Balsini <balsini@android.com> wrote:
> >
> > Expose the FUSE_PASSTHROUGH interface to user space and declare all the
> > basic data structures and functions as the skeleton on top of which the
> > FUSE passthrough functionality will be built.
> >
> > As part of this, introduce the new FUSE passthrough ioctl(), which
> > allows the FUSE daemon to specify a direct connection between a FUSE
> > file and a lower file system file. Such ioctl() requires users pace to
> > pass the file descriptor of one of its opened files through the
> > fuse_passthrough_out data structure introduced in this patch. This
> > structure includes extra fields for possible future extensions.
> > Also, add the passthrough functions for the set-up and tear-down of the
> > data structures and locks that will be used both when fuse_conns and
> > fuse_files are created/deleted.
> >
> > Signed-off-by: Alessio Balsini <balsini@android.com>
> > ---
> [...]
> 
> > @@ -699,6 +700,7 @@ void fuse_conn_init(struct fuse_conn *fc, struct fuse_mount *fm,
> >         INIT_LIST_HEAD(&fc->bg_queue);
> >         INIT_LIST_HEAD(&fc->entry);
> >         INIT_LIST_HEAD(&fc->devices);
> > +       idr_init(&fc->passthrough_req);
> >         atomic_set(&fc->num_waiting, 0);
> >         fc->max_background = FUSE_DEFAULT_MAX_BACKGROUND;
> >         fc->congestion_threshold = FUSE_DEFAULT_CONGESTION_THRESHOLD;
> > @@ -1052,6 +1054,12 @@ static void process_init_reply(struct fuse_mount *fm, struct fuse_args *args,
> >                                 fc->handle_killpriv_v2 = 1;
> >                                 fm->sb->s_flags |= SB_NOSEC;
> >                         }
> > +                       if (arg->flags & FUSE_PASSTHROUGH) {
> > +                               fc->passthrough = 1;
> > +                               /* Prevent further stacking */
> > +                               fm->sb->s_stack_depth =
> > +                                       FILESYSTEM_MAX_STACK_DEPTH + 1;
> > +                       }
> 
> Hi Allesio,
> 
> I'm sorry I missed the discussion on v10 patch, but this looks wrong.
> First of all, assigning a value above a declared MAX_ is misleading
> and setting a trap for someone else to trip in the future.
> 
> While this may be just a semantic mistake, the code that checks for
> (passthrough_sb->s_stack_depth > FILESYSTEM_MAX_STACK_DEPTH)
> is just cheating.
> 
> fuse_file_{read,write}_iter are stacked operations, no different in any way
> than overlayfs and ecryptfs stacked file operations.
> 
> Peng Tao mentioned a case of passthrough to overlayfs over ecryptfs [1].
> If anyone really thinks this use case is interesting enough (I doubt it), then
> they may propose to bump up FILESYSTEM_MAX_STACK_DEPTH to 3,
> but not to cheat around the currently defined maximum.
> 
> So please set s_max_depth to FILESYSTEM_MAX_STACK_DEPTH and
> restore your v10 check of
> passthrough_sb->s_stack_depth >= FILESYSTEM_MAX_STACK_DEPTH
> 
> Your commit message sounds as if the only purpose of this check is to
> prevent stacking of FUSE passthrough on top of each other, but that
> is not enough.
> 
> Thanks,
> Amir.
> 
> [1] https://lore.kernel.org/linux-fsdevel/CA+a=Yy6S9spMLr9BqyO1qvU52iAAXU3i9eVtb81SnrzjkCwO5Q@mail.gmail.com/


Hi Amir,

The stacking solution in V10 works for me and, as we agreed last time,
we would still be able to update the stacking policy with FUSE
passthrough as soon as some use cases find it beneficial.

Our use case in Android is somewhat simple and it's difficult for me to
think of how this stacking can be useful or limiting to the different
use cases. It's anyway worth highlighting that if FUSE passthrough is
disabled, as it is by default, the FUSE behavior remains exactly the
same as it was before this series.
For my limited use cases experience here, I have no personal preferences
on the stacking policy I'm just trying to do the right thing based on
the feedback from the community :)

I can change this policy back as this was in V10, but at the same time I
don't want to put extra effort/confusion in the mailing list and to
Miklos with the next patch version. So I'm going to post the diff to
bring back the stacking policy as it was in V10 in reply to "[PATCH
RESEND V11 4/7] fuse: Passthrough initialization and release" and wait
for the community consensus before sending out the V12.

Thanks again for helpful feedback!

Cheers,
Alessio
