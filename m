Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CB5C4252FC
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Oct 2021 14:27:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241350AbhJGM32 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 7 Oct 2021 08:29:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241197AbhJGM32 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 7 Oct 2021 08:29:28 -0400
Received: from mail-vs1-xe34.google.com (mail-vs1-xe34.google.com [IPv6:2607:f8b0:4864:20::e34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92837C061760
        for <linux-fsdevel@vger.kernel.org>; Thu,  7 Oct 2021 05:27:34 -0700 (PDT)
Received: by mail-vs1-xe34.google.com with SMTP id x192so4310820vsx.5
        for <linux-fsdevel@vger.kernel.org>; Thu, 07 Oct 2021 05:27:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=JlKsfdmgfXs09taACmDyRZJY8EiHSnNfp8iCZ5IXTlY=;
        b=Pq29b+ECnINLhLjebcICFPMl5kZefTp91ONzUQAF3MiFKcnUY/fr26wFSGnUQLNPtw
         krwpnbduhJfqVIxHXtSreaczjcWiqGEkqBbnV1X8j3IlqHRu4TYSHvWaMnsHzFfS7B/y
         B//L+TWkij04JKEW5cQ3aktGXvFOebgmq9wTQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=JlKsfdmgfXs09taACmDyRZJY8EiHSnNfp8iCZ5IXTlY=;
        b=UUtJQpZiWcSulcuE+2RMiuK1g+BEB70A+vReYHo59AP43bpwSIAZHYQCbJQRBQ/1z4
         944FOM7zGNs/wbOUm3CLXCQz8Ct47Gd1w4xCYeHqPQe7/bZ568Ede7yma/f0P91LR605
         pqrgd98ieH2uVog2NEUhgJJi2RGzQ9w3PzxiGl3RrcCjA53ytwGrYY+WCSjsg/xSfMa2
         B3V1dMrW1e9QG7HgT7HVZowBaqC4ctTqRu4XQUgqjQOuk89zTt04D/cFsHM8MgXJOZXV
         ERI5IdubMIvilML50Ampw/bAsq/DBv9ZgMW1NllLpAZy4pewfRn8zu6FRvJtGK6j61lH
         HUiQ==
X-Gm-Message-State: AOAM530l9/6f+lVIIAPGzfODw1hZvkKFJ+VfqRWMeFc4KOFUoWPQHcE7
        0Y9dvOeAicZnE9AwqeXeGzKuVSR3s7XQfnHEGXibbQ==
X-Google-Smtp-Source: ABdhPJxSHUY84YfC3qTrGfqvnuokf7y4lKDUThEZMrITfoSSdEa2Y1i9F2ps9WjZfFtDnx0KREJl8X7VoIrtlGi7hU8=
X-Received: by 2002:a05:6102:3c3:: with SMTP id n3mr3706923vsq.19.1633609653793;
 Thu, 07 Oct 2021 05:27:33 -0700 (PDT)
MIME-Version: 1.0
References: <20210923130814.140814-1-cgxu519@mykernel.net> <20210923130814.140814-8-cgxu519@mykernel.net>
 <CAJfpegtLi1PsfpkohJ-8kTHVazf7cZiX96OSBMn7Q39PY_PXaw@mail.gmail.com> <3b660f79-9f60-5acd-0b9a-47f9e3e6a04b@139.com>
In-Reply-To: <3b660f79-9f60-5acd-0b9a-47f9e3e6a04b@139.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Thu, 7 Oct 2021 14:27:23 +0200
Message-ID: <CAJfpegujsoyXEQR4CBH3koZdpe+qUVj3R6Okt+3k9AbvUPohJQ@mail.gmail.com>
Subject: Re: [RFC PATCH v5 07/10] ovl: cache dirty overlayfs' inode
To:     Chengguang Xu <cgxu519@139.com>
Cc:     Chengguang Xu <cgxu519@mykernel.net>, Jan Kara <jack@suse.cz>,
        Amir Goldstein <amir73il@gmail.com>,
        linux-fsdevel@vger.kernel.org,
        overlayfs <linux-unionfs@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 7 Oct 2021 at 14:04, Chengguang Xu <cgxu519@139.com> wrote:
>
> =E5=9C=A8 2021/10/7 19:09, Miklos Szeredi =E5=86=99=E9=81=93:
> > On Thu, 23 Sept 2021 at 15:08, Chengguang Xu <cgxu519@mykernel.net> wro=
te:
> >> Now drop overlayfs' inode will sync dirty data,
> >> so we change to only drop clean inode.
> >>
> >> The purpose of doing this is to keep compatible
> >> behavior with before because without this change
> >> dropping overlayfs inode will not trigger syncing
> >> of underlying dirty inode.
> >>
> >> Signed-off-by: Chengguang Xu <cgxu519@mykernel.net>
> >> ---
> >>   fs/overlayfs/super.c | 16 +++++++++++++++-
> >>   1 file changed, 15 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
> >> index cddae3ca2fa5..bf4000eb9be8 100644
> >> --- a/fs/overlayfs/super.c
> >> +++ b/fs/overlayfs/super.c
> >> @@ -441,11 +441,25 @@ static int ovl_write_inode(struct inode *inode,
> >>          return ret;
> >>   }
> >>
> >> +/*
> >> + * In iput_final(), clean inode will drop directly and dirty inode wi=
ll
> >> + * keep in the cache until write back to sync dirty data then add to =
lru
> >> + * list to wait reclaim.
> >> + */
> >> +static int ovl_drop_inode(struct inode *inode)
> >> +{
> >> +       struct inode *upper =3D ovl_inode_upper(inode);
> >> +
> >> +       if (!upper || !(inode->i_state & I_DIRTY_ALL))
> > Could we check upper dirtyness here? That would give a more precise res=
ult.
>
> We keep tracking mmapped-file(shared mode) by explicitely marking
> overlay inode dirty,
>
> so if we drop overlay inode by checking upper dirtyness, we may lose
> control on those mmapped upper inodes.

That's fine, since there are no more mmaps at this point.

> >
> > Alternatively don't set .drop_inode (i.e. use generic_drop_inode())
> > and set I_DONTCACHE on overlay inodes.  That would cause the upper
> > inode to be always written back before eviction.
> >
> > The latter would result in simpler logic, and I think performance-wise
> > it wouldn't matter.  But I may be missing something.
>
> I think we may seperate mmapped-file(shared) inode and other inode by
>
> clear/set I_DONTCACHE flag on overlay inode if you prefer this approach.

Same reasoning here: after upper inode is written out, the dirtyness
in the overlay inode doesn't matter since there cannot be any active
mmaps.

Thanks,
Miklos
