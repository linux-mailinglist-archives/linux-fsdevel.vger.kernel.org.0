Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7BF8120B65
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 May 2019 17:39:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727008AbfEPPjD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 May 2019 11:39:03 -0400
Received: from mail-yw1-f65.google.com ([209.85.161.65]:37818 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726692AbfEPPjD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 May 2019 11:39:03 -0400
Received: by mail-yw1-f65.google.com with SMTP id 186so1526642ywo.4
        for <linux-fsdevel@vger.kernel.org>; Thu, 16 May 2019 08:39:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cR6Qni/9Oc3GivgXKBHTIdQwdHwrbg6bVvdjrQzG/4I=;
        b=n6TFPZsWKKsH4jSfGYsStr+Uhcet06HXmeCZ8LMe0/iXjR6MQ89yJlztesb5pJ6Arm
         hrQf8m3HQh7Wz7MGxkpizxskutuYJ+CwwC8SM1SLRRhvthkThGY3RI4L6/pgfrw9MDKF
         RzQt19/ttdgVjiHyzqMFTDexMzfiP9KjjHjUY+kCH/zNZ2mTXhm8ro+2pfxm6luiV3dm
         wjZWCvlw42otWFx4kkyebxDx3BQDDOX+f1D/AMZ0lHl9UNzbbtg8FHItr5p5N0M63s0C
         x8iOq0Ajsfkb9XH5+Qu4sUoxOmdWlx5IHFJO4wpwWnBpGiyqZBklAahnAHjMyaiyrOst
         hhdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cR6Qni/9Oc3GivgXKBHTIdQwdHwrbg6bVvdjrQzG/4I=;
        b=WLY0y2X5hlMR1M7yv5DNTzlUhrv3YdrPeYk7XTc4/qF9W85Cq3tvqT14EJWprEAXcp
         /BE9jXJ3U3C4vipCQ6mmDAETtJ+OJsFL5thbmmVfScRVSlP1EafFAov6ZSd3MdgaELFp
         Rz4r1CtmAeO0IlopCEGeKCQg38ArSNtAsT/iWbUvCbQ0QtEtpG5B0Jmque0ThkyciHWw
         nEYx8A8hsAj9/TMOvyughkRrdGTntmPZfUk5MN+SG5Rq3FVzyGYcglOYkziREmQQ0JXl
         DlVVROHedXZwUNocbK5DMsWD7mYoKAhPmIL4+kV2A1RBA9NK6JoXBdBjluZ6AQqIcOam
         j+HQ==
X-Gm-Message-State: APjAAAUGEtFrCez0uT+hZlxai+plwyGjIm9mqgTFiyWcV4fMeHoNpLY1
        js50XZtOaV7mH2TyoloN7ztqEPUKQvZqTZl6CUs=
X-Google-Smtp-Source: APXvYqzJ37abUz8jYfYJD9rOR2hM1GeDpTa0C0XjnwttDiq7XrAdVTjbFtZtKwdcqiu6i29KwxKIIbkrVqLEmZKTyGQ=
X-Received: by 2002:a81:9850:: with SMTP id p77mr24521836ywg.176.1558021142146;
 Thu, 16 May 2019 08:39:02 -0700 (PDT)
MIME-Version: 1.0
References: <20190516102641.6574-1-amir73il@gmail.com> <20190516102641.6574-7-amir73il@gmail.com>
 <20190516103547.GA2125@kroah.com> <CAOQ4uxg9zpwRa9Ei_4M=g+SoXH1-KgYV2TqzsfEsxTKpq-e3Pg@mail.gmail.com>
 <20190516120227.GE13274@quack2.suse.cz> <CAOQ4uxgcY1PHyrz=POFvAFxoe36QqMLObzkewDWmeqBMLmWuMQ@mail.gmail.com>
 <20190516152847.GA612@kroah.com>
In-Reply-To: <20190516152847.GA612@kroah.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Thu, 16 May 2019 18:38:50 +0300
Message-ID: <CAOQ4uxjkN3dWrr3YMaado5uR3LigzeY8CH7HEwGLt3W6n1s7kQ@mail.gmail.com>
Subject: Re: [PATCH v2 06/14] fs: convert debugfs to use simple_remove() helper
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jan Kara <jack@suse.cz>,
        Matthew Bobrowski <mbobrowski@mbobrowski.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, May 16, 2019 at 6:28 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Thu, May 16, 2019 at 03:09:20PM +0300, Amir Goldstein wrote:
> > On Thu, May 16, 2019 at 3:02 PM Jan Kara <jack@suse.cz> wrote:
> > >
> > > On Thu 16-05-19 13:44:51, Amir Goldstein wrote:
> > > > On Thu, May 16, 2019 at 1:35 PM Greg Kroah-Hartman
> > > > <gregkh@linuxfoundation.org> wrote:
> > > > >
> > > > > On Thu, May 16, 2019 at 01:26:33PM +0300, Amir Goldstein wrote:
> > > > > > This will allow generating fsnotify delete events after the
> > > > > > fsnotify_nameremove() hook is removed from d_delete().
> > > > > >
> > > > > > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > > > > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> > > > > > ---
> > > > > >  fs/debugfs/inode.c | 20 ++++----------------
> > > > > >  1 file changed, 4 insertions(+), 16 deletions(-)
> > > > > >
> > > > > > diff --git a/fs/debugfs/inode.c b/fs/debugfs/inode.c
> > > > > > index acef14ad53db..bc96198df1d4 100644
> > > > > > --- a/fs/debugfs/inode.c
> > > > > > +++ b/fs/debugfs/inode.c
> > > > > > @@ -617,13 +617,10 @@ struct dentry *debugfs_create_symlink(const char *name, struct dentry *parent,
> > > > > >  }
> > > > > >  EXPORT_SYMBOL_GPL(debugfs_create_symlink);
> > > > > >
> > > > > > -static void __debugfs_remove_file(struct dentry *dentry, struct dentry *parent)
> > > > > > +static void __debugfs_file_removed(struct dentry *dentry)
> > > > > >  {
> > > > > >       struct debugfs_fsdata *fsd;
> > > > > >
> > > > > > -     simple_unlink(d_inode(parent), dentry);
> > > > > > -     d_delete(dentry);
> > > > >
> > > > > What happened to this call?  Why no unlinking anymore?
> > > > >
> > > > > > -
> > > > > >       /*
> > > > > >        * Paired with the closing smp_mb() implied by a successful
> > > > > >        * cmpxchg() in debugfs_file_get(): either
> > > > > > @@ -643,18 +640,9 @@ static int __debugfs_remove(struct dentry *dentry, struct dentry *parent)
> > > > > >       int ret = 0;
> > > > > >
> > > > > >       if (simple_positive(dentry)) {
> > > > > > -             dget(dentry);
> > > > > > -             if (!d_is_reg(dentry)) {
> > > > > > -                     if (d_is_dir(dentry))
> > > > > > -                             ret = simple_rmdir(d_inode(parent), dentry);
> > > > > > -                     else
> > > > > > -                             simple_unlink(d_inode(parent), dentry);
> > > > > > -                     if (!ret)
> > > > > > -                             d_delete(dentry);
> > > > > > -             } else {
> > > > > > -                     __debugfs_remove_file(dentry, parent);
> > > > > > -             }
> > > > > > -             dput(dentry);
> > > > > > +             ret = simple_remove(d_inode(parent), dentry);
> > > > > > +             if (d_is_reg(dentry))
> > > > >
> > > > > Can't dentry be gone here?  This doesn't seem to match the same pattern
> > > > > as before.
> > > > >
> > > > > What am I missing?
> > > > >
> > > >
> > > > The grammatical change __debugfs_remove_file() => __debugfs_file_removed()
> > > > After change, the helper only does the post delete stuff.
> > > > simple_unlink() is now done inside simple_remove().
> > > > This debugfs patch depends on a patch that adds the simple_remove() helper.
> > > > sorry for not mentioning this explicitly.
> > >
> > > Right. But Greg is right that simple_remove() may have dropped last dentry
> > > reference and thus you now pass freed dentry to d_is_reg() and
> > > __debugfs_file_removed()?
> > >
> >
> > It seem so. Good spotting!
>
> Yes, that's what I was trying to say.  I don't think this conversion is
> correct, so you might either have to rework your simple_rmdir(), or this
> patch, to make it work properly.
>

To fix the correctness issue we will keep dget(dentry)/dput(dentry)
in place both in __debugfs_remove() and in simple_remove(), i.e:

               dget(dentry);
               ret = simple_remove(d_inode(parent), dentry);
               if (d_is_reg(dentry))
                       __debugfs_file_removed(dentry);
               dput(dentry);

Will this have addressed your concern?

BTW, I forwarded you the dependency patch that is needed for the
context of this review.

Thanks,
Amir.
