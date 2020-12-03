Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C3F52CD3E1
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Dec 2020 11:42:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728638AbgLCKme (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 3 Dec 2020 05:42:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728037AbgLCKme (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 3 Dec 2020 05:42:34 -0500
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7FCBC061A4D
        for <linux-fsdevel@vger.kernel.org>; Thu,  3 Dec 2020 02:41:53 -0800 (PST)
Received: by mail-io1-xd43.google.com with SMTP id t8so1531694iov.8
        for <linux-fsdevel@vger.kernel.org>; Thu, 03 Dec 2020 02:41:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bST/WrBCrtNhIyKCOt2Hn1Tln6kXN4nYVx3/ov5RA6g=;
        b=uRNCjF0C8IIO2NI9qYBLZDiZiO6SzHLhWB6JyxQJ9HxRhpA8CfRl5ZBLTfq5vB3zuX
         z8iqGxR2kd+37uSZKQMgZKvwvBntL8puNFnoq9Zc6xMKtdKW5G1/DC+udZ7O/JM3RqkG
         Ni7Bq4ugIMqMoJvNF9eIoDo/dIqnbeBzHLdWnHdiFTrzUHzSKRyJ6PhKeU1lLauyjLif
         z1i0BuBrv6DBwwJmT5H7qtHBbmDhSnRqNVs1kFy29tQwIfb1dtUJO3dcBZ4uSdqD9PQe
         4+QimzJGGKf5nO+CaWbF6EeU53X9zFU2f63K/WCevd4UGtimKoFr2oB1X4BwW10BZiu1
         GWKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bST/WrBCrtNhIyKCOt2Hn1Tln6kXN4nYVx3/ov5RA6g=;
        b=FmfQtaI5F8ZPBtfGetukXQHNARtVUTw0g8nZGt6AujTLNRp2FQgOulTssWnMwoODBn
         aVcMoWYlbUumkHsodXXD4KgtThSSwyza9+EhghYA/PHyRqJMUinnLSqdYWVyuDDoZau8
         PDjyoNjtWcx/HNF4iMW/LIpEji/Hs41Cwc7N8KFJVfLa073e+5RaMD1FT/qt0d/buzco
         awtE7fBbN6zWfoqfls3BcgJzZhTDuC8cvsfc+ILdo2buZWFfovBrx8pqBndrblVzyggZ
         jYtqBhmKc9wFRXARCdvieT/ZmNdnzMJWSu261VuDwmLcv/d5CaFAcjQdlg6ev4T2G2YC
         0PRg==
X-Gm-Message-State: AOAM531njXDsxc1zIvz04RBjMI4rA36mWIU+e85AkaT/NzPECafzl+jh
        vg9sxi99CXViWnb23isNa6wZknuht+xfr+ns+OGwzv0b
X-Google-Smtp-Source: ABdhPJwyQZHXEfoIRdOTHFAAnogNmG+hvLbDk2QFjlsl1qv30kKFjRoCqJB6M94O2e24a83qU3IqwvYaJpcmgJbe1rs=
X-Received: by 2002:a5d:964a:: with SMTP id d10mr2617866ios.5.1606992112912;
 Thu, 03 Dec 2020 02:41:52 -0800 (PST)
MIME-Version: 1.0
References: <20201202120713.702387-1-amir73il@gmail.com> <20201202120713.702387-2-amir73il@gmail.com>
 <20201203095101.GA11854@quack2.suse.cz>
In-Reply-To: <20201203095101.GA11854@quack2.suse.cz>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Thu, 3 Dec 2020 12:41:41 +0200
Message-ID: <CAOQ4uxj4jX9gy2JdJBoExsxA0nsKN1Z21K+yj=a4rkr5_OTxdQ@mail.gmail.com>
Subject: Re: [PATCH 1/7] fsnotify: generalize handle_inode_event()
To:     Jan Kara <jack@suse.cz>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Dec 3, 2020 at 11:51 AM Jan Kara <jack@suse.cz> wrote:
>
> On Wed 02-12-20 14:07:07, Amir Goldstein wrote:
> > The handle_inode_event() interface was added as (quoting comment):
> > "a simple variant of handle_event() for groups that only have inode
> > marks and don't have ignore mask".
> >
> > In other words, all backends except fanotify.  The inotify backend
> > also falls under this category, but because it required extra arguments
> > it was left out of the initial pass of backends conversion to the
> > simple interface.
> >
> > This results in code duplication between the generic helper
> > fsnotify_handle_event() and the inotify_handle_event() callback
> > which also happen to be buggy code.
> >
> > Generalize the handle_inode_event() arguments and add the check for
> > FS_EXCL_UNLINK flag to the generic helper, so inotify backend could
> > be converted to use the simple interface.
> >
> > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
>
> The patch looks good to me. Just one curious question below.
>
> > +static int fsnotify_handle_inode_event(struct fsnotify_group *group,
> > +                                    struct fsnotify_mark *inode_mark,
> > +                                    u32 mask, const void *data, int data_type,
> > +                                    struct inode *dir, const struct qstr *name,
> > +                                    u32 cookie)
> > +{
> > +     const struct path *path = fsnotify_data_path(data, data_type);
> > +     struct inode *inode = fsnotify_data_inode(data, data_type);
> > +     const struct fsnotify_ops *ops = group->ops;
> > +
> > +     if (WARN_ON_ONCE(!ops->handle_inode_event))
> > +             return 0;
> > +
> > +     if ((inode_mark->mask & FS_EXCL_UNLINK) &&
> > +         path && d_unlinked(path->dentry))
> > +             return 0;
>
> When I was looking at this condition I was wondering why do we check
> d_unlinked() and not inode->i_nlink? When is there a difference?

When a hardlink has been unlinked.
inotify gets the filename and it doesn't want to get events with unlinked
names (although another name could still be linked) I suppose...

Thanks,
Amir.
