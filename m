Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4495717009C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Feb 2020 14:59:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727619AbgBZN7M (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 Feb 2020 08:59:12 -0500
Received: from mx2.suse.de ([195.135.220.15]:57306 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726388AbgBZN7M (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 Feb 2020 08:59:12 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 37D66ABEA;
        Wed, 26 Feb 2020 13:59:10 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id D77191E0EA2; Wed, 26 Feb 2020 14:59:09 +0100 (CET)
Date:   Wed, 26 Feb 2020 14:59:09 +0100
From:   Jan Kara <jack@suse.cz>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jan Kara <jack@suse.cz>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Matthew Bobrowski <mbobrowski@mbobrowski.org>
Subject: Re: [PATCH v2 02/16] fsnotify: factor helpers fsnotify_dentry() and
 fsnotify_file()
Message-ID: <20200226135909.GS10728@quack2.suse.cz>
References: <20200217131455.31107-1-amir73il@gmail.com>
 <20200217131455.31107-3-amir73il@gmail.com>
 <20200225134612.GA10728@quack2.suse.cz>
 <CAOQ4uxjRaidKvh=7UBNHZTwfqLne+JXeOkWb0BVsvJep26kFyw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxjRaidKvh=7UBNHZTwfqLne+JXeOkWb0BVsvJep26kFyw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue 25-02-20 16:27:02, Amir Goldstein wrote:
> On Tue, Feb 25, 2020 at 3:46 PM Jan Kara <jack@suse.cz> wrote:
> >
> > On Mon 17-02-20 15:14:41, Amir Goldstein wrote:
> > > Most of the code in fsnotify hooks is boiler plate of one or the other.
> > >
> > > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> > > ---
> > >  include/linux/fsnotify.h | 96 +++++++++++++++-------------------------
> > >  1 file changed, 36 insertions(+), 60 deletions(-)
> >
> > Nice cleanup. Just two comments below.
> >
> > > @@ -58,8 +78,6 @@ static inline int fsnotify_path(struct inode *inode, const struct path *path,
> > >  static inline int fsnotify_perm(struct file *file, int mask)
> > >  {
> > >       int ret;
> > > -     const struct path *path = &file->f_path;
> > > -     struct inode *inode = file_inode(file);
> > >       __u32 fsnotify_mask = 0;
> > >
> > >       if (file->f_mode & FMODE_NONOTIFY)
> >
> > I guess you can drop the NONOTIFY check from here. You've moved it to
> > fsnotify_file() and there's not much done in this function to be worth
> > skipping...
> 
> True.
> 
> >
> > > @@ -70,7 +88,7 @@ static inline int fsnotify_perm(struct file *file, int mask)
> > >               fsnotify_mask = FS_OPEN_PERM;
> > >
> > >               if (file->f_flags & __FMODE_EXEC) {
> > > -                     ret = fsnotify_path(inode, path, FS_OPEN_EXEC_PERM);
> > > +                     ret = fsnotify_file(file, FS_OPEN_EXEC_PERM);
> > >
> > >                       if (ret)
> > >                               return ret;
> >
> > Hum, I think we could simplify fsnotify_perm() even further by having:
> >
> >         if (mask & MAY_OPEN) {
> >                 if (file->f_flags & __FMODE_EXEC)
> >                         fsnotify_mask = FS_OPEN_EXEC_PERM;
> >                 else
> >                         fsnotify_mask = FS_OPEN_PERM;
> >         } ...
> >
> 
> But the current code sends both FS_OPEN_EXEC_PERM and FS_OPEN_PERM
> on an open for exec. I believe that is what was discussed when Matthew wrote
> the OPEN_EXEC patches, so existing receivers of OPEN_PERM event on exec
> will not regress..

Ah, my bad. You're right.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
