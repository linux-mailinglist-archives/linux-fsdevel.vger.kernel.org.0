Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A3A9420D6E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 May 2019 18:52:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726574AbfEPQwj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 May 2019 12:52:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:41584 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726357AbfEPQwj (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 May 2019 12:52:39 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0196A20815;
        Thu, 16 May 2019 16:52:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558025558;
        bh=qJ3Z8JMOHDKjKO8Lk9hU8PRkDRtv+wJvSmKRY3KuUMw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=1hl5hd+7fSMjNCRuYzP1cQvaPb/peRCEm65qajgW3pegVEAj8aDPu3Kxs1Mdak5CA
         Ub0gCZG8grmiK39aRkzPFr0grkPPJ2Q5tKO53ro3s036UOee9Azdvypy8yHEuo8Sd8
         ftimzJ5ajL5fSdK7leHZeCmiseBqk9bSPBrt3pG0=
Date:   Thu, 16 May 2019 18:52:36 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jan Kara <jack@suse.cz>,
        Matthew Bobrowski <mbobrowski@mbobrowski.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH v2 06/14] fs: convert debugfs to use simple_remove()
 helper
Message-ID: <20190516165236.GA27726@kroah.com>
References: <20190516102641.6574-1-amir73il@gmail.com>
 <20190516102641.6574-7-amir73il@gmail.com>
 <20190516103547.GA2125@kroah.com>
 <CAOQ4uxg9zpwRa9Ei_4M=g+SoXH1-KgYV2TqzsfEsxTKpq-e3Pg@mail.gmail.com>
 <20190516120227.GE13274@quack2.suse.cz>
 <CAOQ4uxgcY1PHyrz=POFvAFxoe36QqMLObzkewDWmeqBMLmWuMQ@mail.gmail.com>
 <20190516152847.GA612@kroah.com>
 <CAOQ4uxjkN3dWrr3YMaado5uR3LigzeY8CH7HEwGLt3W6n1s7kQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxjkN3dWrr3YMaado5uR3LigzeY8CH7HEwGLt3W6n1s7kQ@mail.gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, May 16, 2019 at 06:38:50PM +0300, Amir Goldstein wrote:
> On Thu, May 16, 2019 at 6:28 PM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > On Thu, May 16, 2019 at 03:09:20PM +0300, Amir Goldstein wrote:
> > > On Thu, May 16, 2019 at 3:02 PM Jan Kara <jack@suse.cz> wrote:
> > > >
> > > > On Thu 16-05-19 13:44:51, Amir Goldstein wrote:
> > > > > On Thu, May 16, 2019 at 1:35 PM Greg Kroah-Hartman
> > > > > <gregkh@linuxfoundation.org> wrote:
> > > > > >
> > > > > > On Thu, May 16, 2019 at 01:26:33PM +0300, Amir Goldstein wrote:
> > > > > > > This will allow generating fsnotify delete events after the
> > > > > > > fsnotify_nameremove() hook is removed from d_delete().
> > > > > > >
> > > > > > > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > > > > > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> > > > > > > ---
> > > > > > >  fs/debugfs/inode.c | 20 ++++----------------
> > > > > > >  1 file changed, 4 insertions(+), 16 deletions(-)
> > > > > > >
> > > > > > > diff --git a/fs/debugfs/inode.c b/fs/debugfs/inode.c
> > > > > > > index acef14ad53db..bc96198df1d4 100644
> > > > > > > --- a/fs/debugfs/inode.c
> > > > > > > +++ b/fs/debugfs/inode.c
> > > > > > > @@ -617,13 +617,10 @@ struct dentry *debugfs_create_symlink(const char *name, struct dentry *parent,
> > > > > > >  }
> > > > > > >  EXPORT_SYMBOL_GPL(debugfs_create_symlink);
> > > > > > >
> > > > > > > -static void __debugfs_remove_file(struct dentry *dentry, struct dentry *parent)
> > > > > > > +static void __debugfs_file_removed(struct dentry *dentry)
> > > > > > >  {
> > > > > > >       struct debugfs_fsdata *fsd;
> > > > > > >
> > > > > > > -     simple_unlink(d_inode(parent), dentry);
> > > > > > > -     d_delete(dentry);
> > > > > >
> > > > > > What happened to this call?  Why no unlinking anymore?
> > > > > >
> > > > > > > -
> > > > > > >       /*
> > > > > > >        * Paired with the closing smp_mb() implied by a successful
> > > > > > >        * cmpxchg() in debugfs_file_get(): either
> > > > > > > @@ -643,18 +640,9 @@ static int __debugfs_remove(struct dentry *dentry, struct dentry *parent)
> > > > > > >       int ret = 0;
> > > > > > >
> > > > > > >       if (simple_positive(dentry)) {
> > > > > > > -             dget(dentry);
> > > > > > > -             if (!d_is_reg(dentry)) {
> > > > > > > -                     if (d_is_dir(dentry))
> > > > > > > -                             ret = simple_rmdir(d_inode(parent), dentry);
> > > > > > > -                     else
> > > > > > > -                             simple_unlink(d_inode(parent), dentry);
> > > > > > > -                     if (!ret)
> > > > > > > -                             d_delete(dentry);
> > > > > > > -             } else {
> > > > > > > -                     __debugfs_remove_file(dentry, parent);
> > > > > > > -             }
> > > > > > > -             dput(dentry);
> > > > > > > +             ret = simple_remove(d_inode(parent), dentry);
> > > > > > > +             if (d_is_reg(dentry))
> > > > > >
> > > > > > Can't dentry be gone here?  This doesn't seem to match the same pattern
> > > > > > as before.
> > > > > >
> > > > > > What am I missing?
> > > > > >
> > > > >
> > > > > The grammatical change __debugfs_remove_file() => __debugfs_file_removed()
> > > > > After change, the helper only does the post delete stuff.
> > > > > simple_unlink() is now done inside simple_remove().
> > > > > This debugfs patch depends on a patch that adds the simple_remove() helper.
> > > > > sorry for not mentioning this explicitly.
> > > >
> > > > Right. But Greg is right that simple_remove() may have dropped last dentry
> > > > reference and thus you now pass freed dentry to d_is_reg() and
> > > > __debugfs_file_removed()?
> > > >
> > >
> > > It seem so. Good spotting!
> >
> > Yes, that's what I was trying to say.  I don't think this conversion is
> > correct, so you might either have to rework your simple_rmdir(), or this
> > patch, to make it work properly.
> >
> 
> To fix the correctness issue we will keep dget(dentry)/dput(dentry)
> in place both in __debugfs_remove() and in simple_remove(), i.e:
> 
>                dget(dentry);
>                ret = simple_remove(d_inode(parent), dentry);
>                if (d_is_reg(dentry))
>                        __debugfs_file_removed(dentry);
>                dput(dentry);
> 
> Will this have addressed your concern?

Shouldn't you check for !d_is_reg before calling simple_remove()?
> 
> BTW, I forwarded you the dependency patch that is needed for the
> context of this review.

I had dug it out of the original series when I reviewed this :)

thanks,

greg k-h
