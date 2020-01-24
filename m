Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BCE3A14792C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Jan 2020 09:05:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729669AbgAXIFs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Jan 2020 03:05:48 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:37785 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725821AbgAXIFs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Jan 2020 03:05:48 -0500
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1iutyN-00049D-3i; Fri, 24 Jan 2020 09:05:47 +0100
Received: from sha by ptx.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <sha@pengutronix.de>)
        id 1iutyI-0005Sy-Tg; Fri, 24 Jan 2020 09:05:42 +0100
Date:   Fri, 24 Jan 2020 09:05:42 +0100
From:   Sascha Hauer <s.hauer@pengutronix.de>
To:     Richard Weinberger <richard.weinberger@gmail.com>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Richard Weinberger <richard@nod.at>,
        linux-mtd@lists.infradead.org, kernel@pengutronix.de,
        Jan Kara <jack@suse.com>
Subject: Re: [PATCH 5/7] ubifs: Add support for project id
Message-ID: <20200124080542.inus6uk3wtrhdrkg@pengutronix.de>
References: <20191106091537.32480-1-s.hauer@pengutronix.de>
 <20191106091537.32480-6-s.hauer@pengutronix.de>
 <CAFLxGvwfjokR=O+=EiC-6SkEsVSnwaNfxPOS_=7SVdSqHX6A=A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFLxGvwfjokR=O+=EiC-6SkEsVSnwaNfxPOS_=7SVdSqHX6A=A@mail.gmail.com>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 09:01:33 up 200 days, 14:11, 80 users,  load average: 0.86, 0.51,
 0.44
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: sha@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-fsdevel@vger.kernel.org
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Jan 19, 2020 at 09:09:10PM +0100, Richard Weinberger wrote:
> On Wed, Nov 6, 2019 at 10:16 AM Sascha Hauer <s.hauer@pengutronix.de> wrote:
> >
> > The project id is necessary for quota project id support. This adds
> > support for the project id to UBIFS as well as support for the
> > FS_PROJINHERIT_FL flag.
> >
> > This includes a change for the UBIFS on-disk format. struct
> > ubifs_ino_node gains a project id number and a UBIFS_PROJINHERIT_FL
> > flag.
> >
> > Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> > ---
> >  fs/ubifs/dir.c         | 23 +++++++++++++++++++++--
> >  fs/ubifs/ioctl.c       | 34 ++++++++++++++++++++++++++++++++--
> >  fs/ubifs/journal.c     |  2 +-
> >  fs/ubifs/super.c       |  1 +
> >  fs/ubifs/ubifs-media.h |  6 ++++--
> >  fs/ubifs/ubifs.h       |  4 ++++
> >  6 files changed, 63 insertions(+), 7 deletions(-)
> >
> > diff --git a/fs/ubifs/dir.c b/fs/ubifs/dir.c
> > index cfce5fee9262..db2456537e6d 100644
> > --- a/fs/ubifs/dir.c
> > +++ b/fs/ubifs/dir.c
> > @@ -56,7 +56,8 @@ static int inherit_flags(const struct inode *dir, umode_t mode)
> >                  */
> >                 return 0;
> >
> > -       flags = ui->flags & (UBIFS_COMPR_FL | UBIFS_SYNC_FL | UBIFS_DIRSYNC_FL);
> > +       flags = ui->flags & (UBIFS_COMPR_FL | UBIFS_SYNC_FL | UBIFS_DIRSYNC_FL |
> > +                            UBIFS_PROJINHERIT_FL);
> >         if (!S_ISDIR(mode))
> >                 /* The "DIRSYNC" flag only applies to directories */
> >                 flags &= ~UBIFS_DIRSYNC_FL;
> > @@ -112,6 +113,11 @@ struct inode *ubifs_new_inode(struct ubifs_info *c, struct inode *dir,
> >                          current_time(inode);
> >         inode->i_mapping->nrpages = 0;
> >
> > +       if (ubifs_inode(dir)->flags & UBIFS_PROJINHERIT_FL)
> > +               ui->projid = ubifs_inode(dir)->projid;
> > +       else
> > +               ui->projid = make_kprojid(&init_user_ns, UBIFS_DEF_PROJID);
> > +
> >         switch (mode & S_IFMT) {
> >         case S_IFREG:
> >                 inode->i_mapping->a_ops = &ubifs_file_address_operations;
> > @@ -705,6 +711,9 @@ static int ubifs_link(struct dentry *old_dentry, struct inode *dir,
> >         ubifs_assert(c, inode_is_locked(dir));
> >         ubifs_assert(c, inode_is_locked(inode));
> >
> > +       if (!projid_eq(dir_ui->projid, ui->projid))
> > +                return -EXDEV;
> > +
> >         err = fscrypt_prepare_link(old_dentry, dir, dentry);
> >         if (err)
> >                 return err;
> > @@ -1556,8 +1565,18 @@ static int ubifs_rename(struct inode *old_dir, struct dentry *old_dentry,
> >         if (err)
> >                 return err;
> >
> > -       if (flags & RENAME_EXCHANGE)
> > +       if ((ubifs_inode(new_dir)->flags & UBIFS_PROJINHERIT_FL) &&
> > +           (!projid_eq(ubifs_inode(new_dir)->projid,
> > +                       ubifs_inode(old_dentry->d_inode)->projid)))
> > +               return -EXDEV;
> > +
> > +       if (flags & RENAME_EXCHANGE) {
> > +               if ((ubifs_inode(old_dir)->flags & UBIFS_PROJINHERIT_FL) &&
> > +                  (!projid_eq(ubifs_inode(old_dir)->projid,
> > +                       ubifs_inode(new_dentry->d_inode)->projid)))
> > +                       return -EXDEV;
> 
> Can we please have a small helper function for these checks?
> 
> >                 return ubifs_xrename(old_dir, old_dentry, new_dir, new_dentry);
> > +       }
> >
> >         return do_rename(old_dir, old_dentry, new_dir, new_dentry, flags);
> >  }
> > diff --git a/fs/ubifs/ioctl.c b/fs/ubifs/ioctl.c
> > index 533df56beab4..829e71d9c9ae 100644
> > --- a/fs/ubifs/ioctl.c
> > +++ b/fs/ubifs/ioctl.c
> > @@ -19,7 +19,7 @@
> >  /* Need to be kept consistent with checked flags in ioctl2ubifs() */
> >  #define UBIFS_SUPPORTED_IOCTL_FLAGS \
> >         (FS_COMPR_FL | FS_SYNC_FL | FS_APPEND_FL | \
> > -        FS_IMMUTABLE_FL | FS_DIRSYNC_FL)
> > +        FS_IMMUTABLE_FL | FS_DIRSYNC_FL | FS_PROJINHERIT_FL)
> >
> >  /**
> >   * ubifs_set_inode_flags - set VFS inode flags.
> > @@ -66,6 +66,8 @@ static int ioctl2ubifs(int ioctl_flags)
> >                 ubifs_flags |= UBIFS_IMMUTABLE_FL;
> >         if (ioctl_flags & FS_DIRSYNC_FL)
> >                 ubifs_flags |= UBIFS_DIRSYNC_FL;
> > +       if (ioctl_flags & FS_PROJINHERIT_FL)
> > +               ubifs_flags |= UBIFS_PROJINHERIT_FL;
> >
> >         return ubifs_flags;
> >  }
> > @@ -91,6 +93,8 @@ static int ubifs2ioctl(int ubifs_flags)
> >                 ioctl_flags |= FS_IMMUTABLE_FL;
> >         if (ubifs_flags & UBIFS_DIRSYNC_FL)
> >                 ioctl_flags |= FS_DIRSYNC_FL;
> > +       if (ubifs_flags & UBIFS_PROJINHERIT_FL)
> > +               ioctl_flags |= FS_PROJINHERIT_FL;
> >
> >         return ioctl_flags;
> >  }
> > @@ -106,6 +110,8 @@ static inline unsigned long ubifs_xflags_to_iflags(__u32 xflags)
> >                 iflags |= UBIFS_IMMUTABLE_FL;
> >         if (xflags & FS_XFLAG_APPEND)
> >                 iflags |= UBIFS_APPEND_FL;
> > +       if (xflags & FS_XFLAG_PROJINHERIT)
> > +               iflags |= UBIFS_PROJINHERIT_FL;
> >
> >          return iflags;
> >  }
> > @@ -121,15 +127,34 @@ static inline __u32 ubifs_iflags_to_xflags(unsigned long flags)
> >                 xflags |= FS_XFLAG_IMMUTABLE;
> >         if (flags & UBIFS_APPEND_FL)
> >                 xflags |= FS_XFLAG_APPEND;
> > +       if (flags & UBIFS_PROJINHERIT_FL)
> > +               xflags |= FS_XFLAG_PROJINHERIT;
> >
> >          return xflags;
> >  }
> >
> > +static int ubifs_ioc_setproject(struct file *file, __u32 projid)
> > +{
> > +       struct inode *inode = file_inode(file);
> > +       struct ubifs_inode *ui = ubifs_inode(inode);
> > +       kprojid_t kprojid;
> > +
> > +       kprojid = make_kprojid(&init_user_ns, (projid_t)projid);
> > +       if (projid_eq(kprojid, ui->projid))
> > +               return 0;
> > +
> > +       ui->projid = kprojid;
> > +
> > +       return 0;
> > +}
> 
> You return in every case 0, so this function cannot fail? If so,
> please make it of type void.

It can fail in the next patch when quota support is added.

> > @@ -531,7 +533,7 @@ struct ubifs_ino_node {
> >         __le32 data_len;
> >         __le32 xattr_cnt;
> >         __le32 xattr_size;
> > -       __u8 padding1[4]; /* Watch 'zero_ino_node_unused()' if changing! */
> > +       __le32 projid;
> 
> You claim a new field in struct ubifs_ino_inode and add a new inode flag.
> I fear this requires a new feature flag.

When would I set this flag? Lazily once the first project id is set or
explicitly somehow?

Sascha

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
