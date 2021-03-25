Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7ED7134953C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Mar 2021 16:20:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231373AbhCYPUM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 25 Mar 2021 11:20:12 -0400
Received: from zeniv-ca.linux.org.uk ([142.44.231.140]:58720 "EHLO
        zeniv-ca.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230095AbhCYPUD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 25 Mar 2021 11:20:03 -0400
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lPRjt-009CM7-Rc; Thu, 25 Mar 2021 15:17:38 +0000
Date:   Thu, 25 Mar 2021 15:17:37 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Eric Biggers <ebiggers@kernel.org>,
        Miklos Szeredi <mszeredi@redhat.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andreas Dilger <adilger@dilger.ca>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Dave Kleikamp <shaggy@kernel.org>,
        David Sterba <dsterba@suse.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>, Jan Kara <jack@suse.cz>,
        Joel Becker <jlbec@evilplan.org>,
        Matthew Garrett <matthew.garrett@nebula.com>,
        Mike Marshall <hubcap@omnibond.com>,
        Richard Weinberger <richard@nod.at>,
        Ryusuke Konishi <konishi.ryusuke@gmail.com>,
        Theodore Ts'o <tytso@mit.edu>, Tyler Hicks <code@tyhicks.com>
Subject: Re: [PATCH 01/18] vfs: add miscattr ops
Message-ID: <YFypkbAy+BQ3yjME@zeniv-ca.linux.org.uk>
References: <20210203124112.1182614-1-mszeredi@redhat.com>
 <20210203124112.1182614-2-mszeredi@redhat.com>
 <YFk08XPc2oNWoUWT@gmail.com>
 <CAJfpeguhAfLiTi0DdYzU-y98TCJZn2GuHBJhkXGLWRCBU2GfSg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJfpeguhAfLiTi0DdYzU-y98TCJZn2GuHBJhkXGLWRCBU2GfSg@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Mar 25, 2021 at 03:52:28PM +0100, Miklos Szeredi wrote:
> On Tue, Mar 23, 2021 at 1:24 AM Eric Biggers <ebiggers@kernel.org> wrote:
> 
> > > +int vfs_miscattr_set(struct dentry *dentry, struct miscattr *ma)
> > > +{
> > > +     struct inode *inode = d_inode(dentry);
> > > +     struct miscattr old_ma = {};
> > > +     int err;
> > > +
> > > +     if (d_is_special(dentry))
> > > +             return -ENOTTY;
> > > +
> > > +     if (!inode->i_op->miscattr_set)
> > > +             return -ENOIOCTLCMD;
> > > +
> > > +     if (!inode_owner_or_capable(inode))
> > > +             return -EPERM;
> >
> > Shouldn't this be EACCES, not EPERM?
> 
> $ git diff master.. | grep -C1 inode_owner_or_capable | grep
> "^-.*\(EPERM\|EACCES\)" | cut -d- -f3 | sort | uniq -c
>      12 EACCES;
>       4 EPERM;
> 
> So EACCES would win if this was a democracy.  However:
> 
> "[EACCES]
> Permission denied. An attempt was made to access a file in a way
> forbidden by its file access permissions."
> 
> "[EPERM]
> Operation not permitted. An attempt was made to perform an operation
> limited to processes with appropriate privileges or to the owner of a
> file or other resource."
> 
> The EPERM description matches the semantics of
> inode_owner_or_capable() exactly.  It's a pretty clear choice.

Except that existing implementation (e.g. for ext2) gives -EACCES here...
OTOH, EPERM matches the behaviour of chown(2), as well as that of
*BSD chflags(2), which is the best match to functionality (setting and
clearing immutable/append-only/etc.)

So I'd probably go with EPERM, and watched for userland breakage;
if something *does* rely upon the historical EACCES here, we might
have to restore that.
