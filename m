Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5CD7020EEB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 May 2019 20:47:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726733AbfEPSrx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 May 2019 14:47:53 -0400
Received: from mail-yw1-f65.google.com ([209.85.161.65]:44050 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726336AbfEPSrx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 May 2019 14:47:53 -0400
Received: by mail-yw1-f65.google.com with SMTP id e74so1739298ywe.11
        for <linux-fsdevel@vger.kernel.org>; Thu, 16 May 2019 11:47:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=E3tJ1afrXapwwYV1ieQt+NpYeDQ3GQFIeuKwtSQpZiQ=;
        b=aphVSKbAwt/pTsXVqmq/xgpHA8JljyPhp2e9vJsZqqwJPSeF/S83CbB2Y8BIwFvA/U
         MJJV7GhsSxBi9nCi/kOM4omu67zurFXAO7V8pDJ6cTcwS+4zFHQel+JKrT3n2CFtGbm0
         JIp0CmXWQ6a8XbhR/xERDgP/KVwY+fREqmNClXo4iGaB3fC13Z6/H0KUb0grk5u85TuA
         hnbXsRpwOCv7p2S0fZaYPr9T1Jf00RlD34HCA1sKh6pCQnZo/ntOqpdH4ycPusbwoAJM
         QViVqWfDJS1NW0hsSyAcu85Mrdrg4LNInBeFnzlH93nRPl19/B80EqCpEDb3sOrY+VYF
         OWlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=E3tJ1afrXapwwYV1ieQt+NpYeDQ3GQFIeuKwtSQpZiQ=;
        b=VVWpXMruIQ46H7T4WjEU8vg6WnKm9lBQ9yA32KPw0DQGtdtg30vMp94xsDJLfCqM/p
         ju6zqLz8OFLFF84ZGGa/AWD8IfYjJMnsrPY4X7LxXi475ZojeM70f55eyvDRBeLGseR4
         SlVa7ns6ZNT7zssWdPPD0lLijUrPSQJy8239grts63uB/Dwqt4OE8F1j4FSJJR57KfZY
         GO4qnfunqJlH027WOJfIRFEnx9IvuA/BQ6JMxWA0Inmkgfm4BknaazUdPMBkSsceZsH9
         HEmg6Fj2iTqfxG3CsBAJ6QOyq29TNsh1HlavPMUSceLPEIK2AU+d42ssClsQ93pV2k0v
         TjuQ==
X-Gm-Message-State: APjAAAUmFIHWqxr0aOzT0PdYlRrhnaunonhyUuJW7WD83EMpQolzBt3Z
        OPHPkb42Y2iKGrUZqfqxy2BXq5vpUfShAy8MEaI=
X-Google-Smtp-Source: APXvYqwnS7D7CFOoprjyxkEKWdbp5gqghjXvjCWTjQ5wWGHtjiypjYIXEM0Cd6Q2pTYfMYPy/pmg0rlIWivHCQ2cMTk=
X-Received: by 2002:a81:7554:: with SMTP id q81mr24678102ywc.404.1558032472028;
 Thu, 16 May 2019 11:47:52 -0700 (PDT)
MIME-Version: 1.0
References: <20190516102641.6574-1-amir73il@gmail.com> <20190516102641.6574-7-amir73il@gmail.com>
 <20190516103547.GA2125@kroah.com> <CAOQ4uxg9zpwRa9Ei_4M=g+SoXH1-KgYV2TqzsfEsxTKpq-e3Pg@mail.gmail.com>
 <20190516120227.GE13274@quack2.suse.cz> <CAOQ4uxgcY1PHyrz=POFvAFxoe36QqMLObzkewDWmeqBMLmWuMQ@mail.gmail.com>
 <20190516152847.GA612@kroah.com> <CAOQ4uxjkN3dWrr3YMaado5uR3LigzeY8CH7HEwGLt3W6n1s7kQ@mail.gmail.com>
 <20190516165236.GA27726@kroah.com>
In-Reply-To: <20190516165236.GA27726@kroah.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Thu, 16 May 2019 21:47:40 +0300
Message-ID: <CAOQ4uxg4SzV3DCqyehHX1HOiz7s_tGnki3mm21WCYuspJ3+_Jw@mail.gmail.com>
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

On Thu, May 16, 2019 at 7:52 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Thu, May 16, 2019 at 06:38:50PM +0300, Amir Goldstein wrote:
> > On Thu, May 16, 2019 at 6:28 PM Greg Kroah-Hartman
> > <gregkh@linuxfoundation.org> wrote:
> > >
> > > On Thu, May 16, 2019 at 03:09:20PM +0300, Amir Goldstein wrote:
> > > > On Thu, May 16, 2019 at 3:02 PM Jan Kara <jack@suse.cz> wrote:
> > > > >
> > > > > On Thu 16-05-19 13:44:51, Amir Goldstein wrote:
> > > > > > On Thu, May 16, 2019 at 1:35 PM Greg Kroah-Hartman
> > > > > > <gregkh@linuxfoundation.org> wrote:
> > > > > > >
> > > > > > > On Thu, May 16, 2019 at 01:26:33PM +0300, Amir Goldstein wrote:
> > > > > > > > This will allow generating fsnotify delete events after the
> > > > > > > > fsnotify_nameremove() hook is removed from d_delete().
> > > > > > > >
> > > > > > > > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > > > > > > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> > > > > > > > ---
> > > > > > > >  fs/debugfs/inode.c | 20 ++++----------------
> > > > > > > >  1 file changed, 4 insertions(+), 16 deletions(-)
> > > > > > > >
> > > > > > > > diff --git a/fs/debugfs/inode.c b/fs/debugfs/inode.c
> > > > > > > > index acef14ad53db..bc96198df1d4 100644
> > > > > > > > --- a/fs/debugfs/inode.c
> > > > > > > > +++ b/fs/debugfs/inode.c
> > > > > > > > @@ -617,13 +617,10 @@ struct dentry *debugfs_create_symlink(const char *name, struct dentry *parent,
> > > > > > > >  }
> > > > > > > >  EXPORT_SYMBOL_GPL(debugfs_create_symlink);
> > > > > > > >
> > > > > > > > -static void __debugfs_remove_file(struct dentry *dentry, struct dentry *parent)
> > > > > > > > +static void __debugfs_file_removed(struct dentry *dentry)
> > > > > > > >  {
> > > > > > > >       struct debugfs_fsdata *fsd;
> > > > > > > >
> > > > > > > > -     simple_unlink(d_inode(parent), dentry);
> > > > > > > > -     d_delete(dentry);
> > > > > > >
> > > > > > > What happened to this call?  Why no unlinking anymore?
> > > > > > >
> > > > > > > > -
> > > > > > > >       /*
> > > > > > > >        * Paired with the closing smp_mb() implied by a successful
> > > > > > > >        * cmpxchg() in debugfs_file_get(): either
> > > > > > > > @@ -643,18 +640,9 @@ static int __debugfs_remove(struct dentry *dentry, struct dentry *parent)
> > > > > > > >       int ret = 0;
> > > > > > > >
> > > > > > > >       if (simple_positive(dentry)) {
> > > > > > > > -             dget(dentry);
> > > > > > > > -             if (!d_is_reg(dentry)) {
> > > > > > > > -                     if (d_is_dir(dentry))
> > > > > > > > -                             ret = simple_rmdir(d_inode(parent), dentry);
> > > > > > > > -                     else
> > > > > > > > -                             simple_unlink(d_inode(parent), dentry);
> > > > > > > > -                     if (!ret)
> > > > > > > > -                             d_delete(dentry);
> > > > > > > > -             } else {
> > > > > > > > -                     __debugfs_remove_file(dentry, parent);
> > > > > > > > -             }
> > > > > > > > -             dput(dentry);
> > > > > > > > +             ret = simple_remove(d_inode(parent), dentry);
> > > > > > > > +             if (d_is_reg(dentry))
> > > > > > >
> > > > > > > Can't dentry be gone here?  This doesn't seem to match the same pattern
> > > > > > > as before.
> > > > > > >
> > > > > > > What am I missing?
> > > > > > >
> > > > > >
> > > > > > The grammatical change __debugfs_remove_file() => __debugfs_file_removed()
> > > > > > After change, the helper only does the post delete stuff.
> > > > > > simple_unlink() is now done inside simple_remove().
> > > > > > This debugfs patch depends on a patch that adds the simple_remove() helper.
> > > > > > sorry for not mentioning this explicitly.
> > > > >
> > > > > Right. But Greg is right that simple_remove() may have dropped last dentry
> > > > > reference and thus you now pass freed dentry to d_is_reg() and
> > > > > __debugfs_file_removed()?
> > > > >
> > > >
> > > > It seem so. Good spotting!
> > >
> > > Yes, that's what I was trying to say.  I don't think this conversion is
> > > correct, so you might either have to rework your simple_rmdir(), or this
> > > patch, to make it work properly.
> > >
> >
> > To fix the correctness issue we will keep dget(dentry)/dput(dentry)
> > in place both in __debugfs_remove() and in simple_remove(), i.e:
> >
> >                dget(dentry);
> >                ret = simple_remove(d_inode(parent), dentry);
> >                if (d_is_reg(dentry))
> >                        __debugfs_file_removed(dentry);
> >                dput(dentry);
> >
> > Will this have addressed your concern?
>
> Shouldn't you check for !d_is_reg before calling simple_remove()?

Current code does simple_unlink() or simple_rmdir() for !d_is_reg
and simple_unlink() + stuff for d_is_reg.

New helper does simple_unlink() or simple_rmdir() as appropriate
for all cases, so all we are left is with + stuff only for d_is_reg.

But anyway, Al is calling this patch set off.

So will continue this discussion on another thread some other time.

Thanks,
Amir.
