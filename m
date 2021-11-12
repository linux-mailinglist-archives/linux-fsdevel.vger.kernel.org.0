Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F5F844E257
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Nov 2021 08:23:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233776AbhKLH01 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 12 Nov 2021 02:26:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230510AbhKLH00 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 12 Nov 2021 02:26:26 -0500
Received: from mail-ua1-x92d.google.com (mail-ua1-x92d.google.com [IPv6:2607:f8b0:4864:20::92d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5F3AC061767
        for <linux-fsdevel@vger.kernel.org>; Thu, 11 Nov 2021 23:23:36 -0800 (PST)
Received: by mail-ua1-x92d.google.com with SMTP id n6so456684uak.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 11 Nov 2021 23:23:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=325jIQD91PfQv8e01cBKjuWX0X3uGvDDvQO81AqevsI=;
        b=kLApZWS3ieetfzU/l392vRyp3+K0MXi+OOpXP6lQJP7T8uV53A424twDgLP6xZX/SM
         cOUI+Bzq6P3z+V1LU4cXEfaafNq5ICcwbgz5+qs8vBUKVzypYuex8CFYpoB6UCfPy/2D
         uQUcKsEB+DUrEMY1+pixcU3G8elLgekMz34dY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=325jIQD91PfQv8e01cBKjuWX0X3uGvDDvQO81AqevsI=;
        b=so5Ro45c8xI4QRDOuMAzs4+iCtkufU/LCDM95bfWKBJd4FIZV+5AQIWXcm/rHarjjs
         bg7TO0MK/S73c48JIewtsStK9EpvXhfhOpOX20pcWb46Ppyo5n5JzV33qYEsAzQSGyG/
         O5e44dr2I3Qo9ZO8Nhz6veArZRu0ZUxvXwGrLQW1Yf4voJNkMcVjo6gsDi3ZxVLgYsiA
         bCJhpzduegv+5AFBmhCJ5lOXdDFP8dFwlAXfLAoBx2V99dmrGhGFmHbgqu2sRFT3v3Lk
         BXf9DCns4Xnb78q1W1Tu4wBxzjZbVBc//DhxRgpdkOcIWmP2ikhuRkck3+Cq2LFygIv0
         Qm1Q==
X-Gm-Message-State: AOAM530sEaIgsOaOqDGuA8Jo1IBoSYVusfaKoLnP9aUExLL2q7WrTiPl
        dYoaJIIE5rQukUhE54CnJGj6DSJzwtsLUzy3uilw4g==
X-Google-Smtp-Source: ABdhPJxpCAoaKGMK5xE203li37lxfdntaKgVxTBZHVG0q+YmWoM61nh7/90/b0lcwABVl4FOIQQVdBScTuVuZY3jBwU=
X-Received: by 2002:a67:782:: with SMTP id 124mr6970271vsh.24.1636701815845;
 Thu, 11 Nov 2021 23:23:35 -0800 (PST)
MIME-Version: 1.0
References: <163660195990.22525.6041281669106537689.stgit@mickey.themaw.net>
 <163660197073.22525.11235124150551283676.stgit@mickey.themaw.net> <20211112003249.GL449541@dread.disaster.area>
In-Reply-To: <20211112003249.GL449541@dread.disaster.area>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Fri, 12 Nov 2021 08:23:24 +0100
Message-ID: <CAJfpegvHDM_Mtc8+ASAcmNLd6RiRM+KutjBOoycun_Oq2=+p=w@mail.gmail.com>
Subject: Re: [PATCH 2/2] xfs: make sure link path does not go away at access
To:     Dave Chinner <david@fromorbit.com>
Cc:     Ian Kent <raven@themaw.net>, xfs <linux-xfs@vger.kernel.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Brian Foster <bfoster@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        David Howells <dhowells@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, 12 Nov 2021 at 01:32, Dave Chinner <david@fromorbit.com> wrote:
>
> On Thu, Nov 11, 2021 at 11:39:30AM +0800, Ian Kent wrote:
> > When following a trailing symlink in rcu-walk mode it's possible to
> > succeed in getting the ->get_link() method pointer but the link path
> > string be deallocated while it's being used.
> >
> > Utilize the rcu mechanism to mitigate this risk.
> >
> > Suggested-by: Miklos Szeredi <miklos@szeredi.hu>
> > Signed-off-by: Ian Kent <raven@themaw.net>
> > ---
> >  fs/xfs/kmem.h      |    4 ++++
> >  fs/xfs/xfs_inode.c |    4 ++--
> >  fs/xfs/xfs_iops.c  |   10 ++++++++--
> >  3 files changed, 14 insertions(+), 4 deletions(-)
> >
> > diff --git a/fs/xfs/kmem.h b/fs/xfs/kmem.h
> > index 54da6d717a06..c1bd1103b340 100644
> > --- a/fs/xfs/kmem.h
> > +++ b/fs/xfs/kmem.h
> > @@ -61,6 +61,10 @@ static inline void  kmem_free(const void *ptr)
> >  {
> >       kvfree(ptr);
> >  }
> > +static inline void  kmem_free_rcu(const void *ptr)
> > +{
> > +     kvfree_rcu(ptr);
> > +}
> >
> >
> >  static inline void *
> > diff --git a/fs/xfs/xfs_inode.c b/fs/xfs/xfs_inode.c
> > index a4f6f034fb81..aaa1911e61ed 100644
> > --- a/fs/xfs/xfs_inode.c
> > +++ b/fs/xfs/xfs_inode.c
> > @@ -2650,8 +2650,8 @@ xfs_ifree(
> >        * already been freed by xfs_attr_inactive.
> >        */
> >       if (ip->i_df.if_format == XFS_DINODE_FMT_LOCAL) {
> > -             kmem_free(ip->i_df.if_u1.if_data);
> > -             ip->i_df.if_u1.if_data = NULL;
> > +             kmem_free_rcu(ip->i_df.if_u1.if_data);
> > +             RCU_INIT_POINTER(ip->i_df.if_u1.if_data, NULL);
> >               ip->i_df.if_bytes = 0;
> >       }
>
> How do we get here in a way that the VFS will walk into this inode
> during a lookup?
>
> I mean, the dentry has to be validated and held during the RCU path
> walk, so if we are running a transaction to mark the inode as free
> here it has already been unlinked and the dentry turned
> negative. So anything that is doing a lockless pathwalk onto that
> dentry *should* see that it is a negative dentry at this point and
> hence nothing should be walking any further or trying to access the
> link that was shared from ->get_link().
>
> AFAICT, that's what the sequence check bug you fixed in the previous
> patch guarantees. It makes no difference if the unlinked inode has
> been recycled or not, the lookup race condition is the same in that
> the inode has gone through ->destroy_inode and is now owned by the
> filesystem and not the VFS.

Yes, the concern here is that without locking all the above can
theoretically happen between the sequence number check and  if_data
being dereferenced.

> Otherwise, it might just be best to memset the buffer to zero here
> rather than free it, and leave it to be freed when the inode is
> freed from the RCU callback in xfs_inode_free_callback() as per
> normal.

My suggestion was to use .free_inode instead of .destroy_inode, the
former always being called after an RCU grace period.

Thanks,
Miklos
