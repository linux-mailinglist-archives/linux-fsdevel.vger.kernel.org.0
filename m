Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7AF4620694
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 May 2019 14:04:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727450AbfEPMCb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 May 2019 08:02:31 -0400
Received: from mx2.suse.de ([195.135.220.15]:41878 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727015AbfEPMCb (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 May 2019 08:02:31 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 5AC22ACAC;
        Thu, 16 May 2019 12:02:29 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id CFFEC1E3ED6; Thu, 16 May 2019 14:02:27 +0200 (CEST)
Date:   Thu, 16 May 2019 14:02:27 +0200
From:   Jan Kara <jack@suse.cz>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jan Kara <jack@suse.cz>,
        Matthew Bobrowski <mbobrowski@mbobrowski.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH v2 06/14] fs: convert debugfs to use simple_remove()
 helper
Message-ID: <20190516120227.GE13274@quack2.suse.cz>
References: <20190516102641.6574-1-amir73il@gmail.com>
 <20190516102641.6574-7-amir73il@gmail.com>
 <20190516103547.GA2125@kroah.com>
 <CAOQ4uxg9zpwRa9Ei_4M=g+SoXH1-KgYV2TqzsfEsxTKpq-e3Pg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxg9zpwRa9Ei_4M=g+SoXH1-KgYV2TqzsfEsxTKpq-e3Pg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 16-05-19 13:44:51, Amir Goldstein wrote:
> On Thu, May 16, 2019 at 1:35 PM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > On Thu, May 16, 2019 at 01:26:33PM +0300, Amir Goldstein wrote:
> > > This will allow generating fsnotify delete events after the
> > > fsnotify_nameremove() hook is removed from d_delete().
> > >
> > > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> > > ---
> > >  fs/debugfs/inode.c | 20 ++++----------------
> > >  1 file changed, 4 insertions(+), 16 deletions(-)
> > >
> > > diff --git a/fs/debugfs/inode.c b/fs/debugfs/inode.c
> > > index acef14ad53db..bc96198df1d4 100644
> > > --- a/fs/debugfs/inode.c
> > > +++ b/fs/debugfs/inode.c
> > > @@ -617,13 +617,10 @@ struct dentry *debugfs_create_symlink(const char *name, struct dentry *parent,
> > >  }
> > >  EXPORT_SYMBOL_GPL(debugfs_create_symlink);
> > >
> > > -static void __debugfs_remove_file(struct dentry *dentry, struct dentry *parent)
> > > +static void __debugfs_file_removed(struct dentry *dentry)
> > >  {
> > >       struct debugfs_fsdata *fsd;
> > >
> > > -     simple_unlink(d_inode(parent), dentry);
> > > -     d_delete(dentry);
> >
> > What happened to this call?  Why no unlinking anymore?
> >
> > > -
> > >       /*
> > >        * Paired with the closing smp_mb() implied by a successful
> > >        * cmpxchg() in debugfs_file_get(): either
> > > @@ -643,18 +640,9 @@ static int __debugfs_remove(struct dentry *dentry, struct dentry *parent)
> > >       int ret = 0;
> > >
> > >       if (simple_positive(dentry)) {
> > > -             dget(dentry);
> > > -             if (!d_is_reg(dentry)) {
> > > -                     if (d_is_dir(dentry))
> > > -                             ret = simple_rmdir(d_inode(parent), dentry);
> > > -                     else
> > > -                             simple_unlink(d_inode(parent), dentry);
> > > -                     if (!ret)
> > > -                             d_delete(dentry);
> > > -             } else {
> > > -                     __debugfs_remove_file(dentry, parent);
> > > -             }
> > > -             dput(dentry);
> > > +             ret = simple_remove(d_inode(parent), dentry);
> > > +             if (d_is_reg(dentry))
> >
> > Can't dentry be gone here?  This doesn't seem to match the same pattern
> > as before.
> >
> > What am I missing?
> >
> 
> The grammatical change __debugfs_remove_file() => __debugfs_file_removed()
> After change, the helper only does the post delete stuff.
> simple_unlink() is now done inside simple_remove().
> This debugfs patch depends on a patch that adds the simple_remove() helper.
> sorry for not mentioning this explicitly.

Right. But Greg is right that simple_remove() may have dropped last dentry
reference and thus you now pass freed dentry to d_is_reg() and
__debugfs_file_removed()?

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
