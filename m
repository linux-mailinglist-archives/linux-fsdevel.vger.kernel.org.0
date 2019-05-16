Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C7E37206B3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 May 2019 14:09:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727459AbfEPMJd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 May 2019 08:09:33 -0400
Received: from mail-yw1-f65.google.com ([209.85.161.65]:37709 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726878AbfEPMJd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 May 2019 08:09:33 -0400
Received: by mail-yw1-f65.google.com with SMTP id 186so1256572ywo.4
        for <linux-fsdevel@vger.kernel.org>; Thu, 16 May 2019 05:09:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bX7MRkBVpNM+72UINUZJ8bpHH6afn+LVRoqGhGfLU18=;
        b=VLEDrNFrBHtBo+fUG6an7lAT4KPm8mJpB2GJ/quUsXbAF67LPg8xq4kUrEk3jmNw98
         WcWm9yEBJlpYfszfDBxCuWouWmuJB9FEpqx57wL/HhDk4GzXUzvUo1CqEHGdSqFvfDSM
         JTculDcn5IS11HIM5FrdZ1fMsS/hPiFCMjSOKDmdXh0X6/+62Cxmr+RWN5dhZyR2fBWI
         ZBXO5N1I23yKhUSKChBFkvkuNy5VbhjKD+qLgcE4mfyapKNg6YlYPk5dliD/ThPF/26r
         G8wMapBOzXKA5H7LZ+T0fTVkairHPMb6Hj85l4ekJbe8EU7vwOFhfR5CyGf3hfRTrB8p
         8VLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bX7MRkBVpNM+72UINUZJ8bpHH6afn+LVRoqGhGfLU18=;
        b=CLU2ft2L+kGrF6lc7adP6ASK5+tUaFs8ZzR9kaWT6HzF+RllAYdkTCpFukOq6CDh0B
         MutfAEgkE/ViOBoHk+PWS0NeQvoP4A/fuDYBhxyVRQR+yIwuXT4VPFT5RH7JHkV/VgUx
         vGgzX8i936IGCHKp6WVIuL+3Ma12JZ+tZqEDCSRiN20ksRAUyToUtGTHZggW6mvMyWgC
         WNlQclSjyXtiRFoSlimBPcQhL6G+avnE0mwNza78aBW42cSq67cudQtOSoA4XX97OF7n
         v997H1Vo/LFXZt2qNtomWtJ2NusI7yDJKhwSLyrPKCkNMauHjr2wwmUGmqJBB5KghSKF
         nQFg==
X-Gm-Message-State: APjAAAXvTQupHVDPZ4to7OqzGfR5T6JxQ+XSDa7Ltm6uN+BuEIGnHrHX
        dQv1bJaaKw8n9l4M771pJrNAuaOjo31l7TjJ6BVDEg==
X-Google-Smtp-Source: APXvYqy2Pqm2zQx2HWJnODG+5F+qm0NMAW1IT7Sz2bscsqALk1LqzYsSuAhbpKGI6V9gDlq++H978ugD4ABpOMfKSKk=
X-Received: by 2002:a81:7003:: with SMTP id l3mr7525578ywc.409.1558008572502;
 Thu, 16 May 2019 05:09:32 -0700 (PDT)
MIME-Version: 1.0
References: <20190516102641.6574-1-amir73il@gmail.com> <20190516102641.6574-7-amir73il@gmail.com>
 <20190516103547.GA2125@kroah.com> <CAOQ4uxg9zpwRa9Ei_4M=g+SoXH1-KgYV2TqzsfEsxTKpq-e3Pg@mail.gmail.com>
 <20190516120227.GE13274@quack2.suse.cz>
In-Reply-To: <20190516120227.GE13274@quack2.suse.cz>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Thu, 16 May 2019 15:09:20 +0300
Message-ID: <CAOQ4uxgcY1PHyrz=POFvAFxoe36QqMLObzkewDWmeqBMLmWuMQ@mail.gmail.com>
Subject: Re: [PATCH v2 06/14] fs: convert debugfs to use simple_remove() helper
To:     Jan Kara <jack@suse.cz>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matthew Bobrowski <mbobrowski@mbobrowski.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, May 16, 2019 at 3:02 PM Jan Kara <jack@suse.cz> wrote:
>
> On Thu 16-05-19 13:44:51, Amir Goldstein wrote:
> > On Thu, May 16, 2019 at 1:35 PM Greg Kroah-Hartman
> > <gregkh@linuxfoundation.org> wrote:
> > >
> > > On Thu, May 16, 2019 at 01:26:33PM +0300, Amir Goldstein wrote:
> > > > This will allow generating fsnotify delete events after the
> > > > fsnotify_nameremove() hook is removed from d_delete().
> > > >
> > > > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> > > > ---
> > > >  fs/debugfs/inode.c | 20 ++++----------------
> > > >  1 file changed, 4 insertions(+), 16 deletions(-)
> > > >
> > > > diff --git a/fs/debugfs/inode.c b/fs/debugfs/inode.c
> > > > index acef14ad53db..bc96198df1d4 100644
> > > > --- a/fs/debugfs/inode.c
> > > > +++ b/fs/debugfs/inode.c
> > > > @@ -617,13 +617,10 @@ struct dentry *debugfs_create_symlink(const char *name, struct dentry *parent,
> > > >  }
> > > >  EXPORT_SYMBOL_GPL(debugfs_create_symlink);
> > > >
> > > > -static void __debugfs_remove_file(struct dentry *dentry, struct dentry *parent)
> > > > +static void __debugfs_file_removed(struct dentry *dentry)
> > > >  {
> > > >       struct debugfs_fsdata *fsd;
> > > >
> > > > -     simple_unlink(d_inode(parent), dentry);
> > > > -     d_delete(dentry);
> > >
> > > What happened to this call?  Why no unlinking anymore?
> > >
> > > > -
> > > >       /*
> > > >        * Paired with the closing smp_mb() implied by a successful
> > > >        * cmpxchg() in debugfs_file_get(): either
> > > > @@ -643,18 +640,9 @@ static int __debugfs_remove(struct dentry *dentry, struct dentry *parent)
> > > >       int ret = 0;
> > > >
> > > >       if (simple_positive(dentry)) {
> > > > -             dget(dentry);
> > > > -             if (!d_is_reg(dentry)) {
> > > > -                     if (d_is_dir(dentry))
> > > > -                             ret = simple_rmdir(d_inode(parent), dentry);
> > > > -                     else
> > > > -                             simple_unlink(d_inode(parent), dentry);
> > > > -                     if (!ret)
> > > > -                             d_delete(dentry);
> > > > -             } else {
> > > > -                     __debugfs_remove_file(dentry, parent);
> > > > -             }
> > > > -             dput(dentry);
> > > > +             ret = simple_remove(d_inode(parent), dentry);
> > > > +             if (d_is_reg(dentry))
> > >
> > > Can't dentry be gone here?  This doesn't seem to match the same pattern
> > > as before.
> > >
> > > What am I missing?
> > >
> >
> > The grammatical change __debugfs_remove_file() => __debugfs_file_removed()
> > After change, the helper only does the post delete stuff.
> > simple_unlink() is now done inside simple_remove().
> > This debugfs patch depends on a patch that adds the simple_remove() helper.
> > sorry for not mentioning this explicitly.
>
> Right. But Greg is right that simple_remove() may have dropped last dentry
> reference and thus you now pass freed dentry to d_is_reg() and
> __debugfs_file_removed()?
>

It seem so. Good spotting!

Thanks,
Amir.
