Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BFD53203D1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 May 2019 12:45:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726870AbfEPKpD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 May 2019 06:45:03 -0400
Received: from mail-yw1-f66.google.com ([209.85.161.66]:42503 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726778AbfEPKpD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 May 2019 06:45:03 -0400
Received: by mail-yw1-f66.google.com with SMTP id s5so1160959ywd.9
        for <linux-fsdevel@vger.kernel.org>; Thu, 16 May 2019 03:45:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=R9bXYwH1E7a3cZBIa00+bFNr4gYRJYUIZglUEzW8tow=;
        b=VtYlaDjbCZMTZzdSrNpz/G5ZSeCyb8o51XBVmucqcvfBd7OEFoj1hHUaZIPMl8Lkm+
         b5Cz4HFr/zi2YRyhg0cjQG8zzJIGZF/l3G3qTbHt/cxhWmmWmLds05OEV/hZocR30Fw9
         C5FGCwrxpAPBcTtfmuJgSGMGWYDRKMFeGK5Hi8WaK+HXt7w/WkVQjhXNHMvCmXZQtla7
         uJxoGUOZtUnq3BFvUiaSJScyOIZdQ2ygiIVg/Rg/cHluJsrRycYExKSKBf1HAyhT6YSV
         a17smt1a+5t8S74kQLlWmEwk5Jq4eimb4CM8YebOzP4JlALnKd3kRhW+oqNsib2fPQI6
         oPCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=R9bXYwH1E7a3cZBIa00+bFNr4gYRJYUIZglUEzW8tow=;
        b=tAfsqaZeM+b9r2qgn+HhiIVFuJnRrEtCmr6z3h6OzIP9bP7AJUdbpb+n2ILwKh7X25
         7kba0lifJS+EoIJ9S3dT5Rv7DE0kOn7Px5s5cc4ZboeLIOLb0GTae5TI3P/vDQZxessw
         sK/SUOCqG1c8HsL+v0yKSgLOOeJ5FgrHoPo9ZAVgiGqSfsfHBTaFV6I/Sr1N4KwjprnE
         qjsW2jWLcim1K/CwGHQOFZUsoQ1xeFlZDNzj9nzTOGVaXHCFokj+j4BUnKDvILTZKByt
         xmMpmC5QswG+day3ds0689k93qR+lS1/+yUE8kB+x54STj+zm+seAmSwhOYQ5FH/I8c5
         WPWA==
X-Gm-Message-State: APjAAAVHJO5/N4jku0I2oHbfoeuriBF3Q2o58cc5MCdQn0LqwpGf3UFf
        MQAh4jwh8o8C3HHAclVMfR1gkpXgV9aue7lHjhZwZgtE
X-Google-Smtp-Source: APXvYqyXGvGYJllACjYbXngqE/diiiNyAI5mNcdQV2c5k7phaFvigbhRh2oqjuL/gYYYbDxVAmhYm0H4oX2Mc2RhDu0=
X-Received: by 2002:a81:63c3:: with SMTP id x186mr22784377ywb.248.1558003502882;
 Thu, 16 May 2019 03:45:02 -0700 (PDT)
MIME-Version: 1.0
References: <20190516102641.6574-1-amir73il@gmail.com> <20190516102641.6574-7-amir73il@gmail.com>
 <20190516103547.GA2125@kroah.com>
In-Reply-To: <20190516103547.GA2125@kroah.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Thu, 16 May 2019 13:44:51 +0300
Message-ID: <CAOQ4uxg9zpwRa9Ei_4M=g+SoXH1-KgYV2TqzsfEsxTKpq-e3Pg@mail.gmail.com>
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

On Thu, May 16, 2019 at 1:35 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Thu, May 16, 2019 at 01:26:33PM +0300, Amir Goldstein wrote:
> > This will allow generating fsnotify delete events after the
> > fsnotify_nameremove() hook is removed from d_delete().
> >
> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> > ---
> >  fs/debugfs/inode.c | 20 ++++----------------
> >  1 file changed, 4 insertions(+), 16 deletions(-)
> >
> > diff --git a/fs/debugfs/inode.c b/fs/debugfs/inode.c
> > index acef14ad53db..bc96198df1d4 100644
> > --- a/fs/debugfs/inode.c
> > +++ b/fs/debugfs/inode.c
> > @@ -617,13 +617,10 @@ struct dentry *debugfs_create_symlink(const char *name, struct dentry *parent,
> >  }
> >  EXPORT_SYMBOL_GPL(debugfs_create_symlink);
> >
> > -static void __debugfs_remove_file(struct dentry *dentry, struct dentry *parent)
> > +static void __debugfs_file_removed(struct dentry *dentry)
> >  {
> >       struct debugfs_fsdata *fsd;
> >
> > -     simple_unlink(d_inode(parent), dentry);
> > -     d_delete(dentry);
>
> What happened to this call?  Why no unlinking anymore?
>
> > -
> >       /*
> >        * Paired with the closing smp_mb() implied by a successful
> >        * cmpxchg() in debugfs_file_get(): either
> > @@ -643,18 +640,9 @@ static int __debugfs_remove(struct dentry *dentry, struct dentry *parent)
> >       int ret = 0;
> >
> >       if (simple_positive(dentry)) {
> > -             dget(dentry);
> > -             if (!d_is_reg(dentry)) {
> > -                     if (d_is_dir(dentry))
> > -                             ret = simple_rmdir(d_inode(parent), dentry);
> > -                     else
> > -                             simple_unlink(d_inode(parent), dentry);
> > -                     if (!ret)
> > -                             d_delete(dentry);
> > -             } else {
> > -                     __debugfs_remove_file(dentry, parent);
> > -             }
> > -             dput(dentry);
> > +             ret = simple_remove(d_inode(parent), dentry);
> > +             if (d_is_reg(dentry))
>
> Can't dentry be gone here?  This doesn't seem to match the same pattern
> as before.
>
> What am I missing?
>

The grammatical change __debugfs_remove_file() => __debugfs_file_removed()
After change, the helper only does the post delete stuff.
simple_unlink() is now done inside simple_remove().
This debugfs patch depends on a patch that adds the simple_remove() helper.
sorry for not mentioning this explicitly.

Thanks,
Amir.
