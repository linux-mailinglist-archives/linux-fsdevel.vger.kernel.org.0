Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E636E52403
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Jun 2019 09:08:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729815AbfFYHIJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 25 Jun 2019 03:08:09 -0400
Received: from mx2.suse.de ([195.135.220.15]:53242 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726397AbfFYHIJ (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 25 Jun 2019 03:08:09 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 05584ADF2;
        Tue, 25 Jun 2019 07:08:05 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id E62D81E2F23; Tue, 25 Jun 2019 09:08:04 +0200 (CEST)
Date:   Tue, 25 Jun 2019 09:08:04 +0200
From:   Jan Kara <jack@suse.cz>
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     Jan Kara <jack@suse.cz>, linux-efi@vger.kernel.org,
        linux-btrfs@vger.kernel.org, yuchao0@huawei.com,
        linux-mm@kvack.org, clm@fb.com, adilger.kernel@dilger.ca,
        matthew.garrett@nebula.com, linux-nilfs@vger.kernel.org,
        linux-ext4@vger.kernel.org, devel@lists.orangefs.org,
        josef@toxicpanda.com, reiserfs-devel@vger.kernel.org,
        viro@zeniv.linux.org.uk, dsterba@suse.com, jaegeuk@kernel.org,
        tytso@mit.edu, ard.biesheuvel@linaro.org,
        linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-xfs@vger.kernel.org,
        jk@ozlabs.org, jack@suse.com, linux-fsdevel@vger.kernel.org,
        linux-mtd@lists.infradead.org, ocfs2-devel@oss.oracle.com
Subject: Re: [Ocfs2-devel] [PATCH 2/7] vfs: flush and wait for io when
 setting the immutable flag via SETFLAGS
Message-ID: <20190625070804.GA31527@quack2.suse.cz>
References: <156116141046.1664939.11424021489724835645.stgit@magnolia>
 <156116142734.1664939.5074567130774423066.stgit@magnolia>
 <20190624113737.GG32376@quack2.suse.cz>
 <20190624215817.GE1611011@magnolia>
 <20190625030439.GA5379@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190625030439.GA5379@magnolia>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon 24-06-19 20:04:39, Darrick J. Wong wrote:
> On Mon, Jun 24, 2019 at 02:58:17PM -0700, Darrick J. Wong wrote:
> > On Mon, Jun 24, 2019 at 01:37:37PM +0200, Jan Kara wrote:
> > > On Fri 21-06-19 16:57:07, Darrick J. Wong wrote:
> > > > From: Darrick J. Wong <darrick.wong@oracle.com>
> > > > 
> > > > When we're using FS_IOC_SETFLAGS to set the immutable flag on a file, we
> > > > need to ensure that userspace can't continue to write the file after the
> > > > file becomes immutable.  To make that happen, we have to flush all the
> > > > dirty pagecache pages to disk to ensure that we can fail a page fault on
> > > > a mmap'd region, wait for pending directio to complete, and hope the
> > > > caller locked out any new writes by holding the inode lock.
> > > > 
> > > > Signed-off-by: Darrick J. Wong <darrick.wong@oracle.com>
> > > 
> > > Seeing the way this worked out, is there a reason to have separate
> > > vfs_ioc_setflags_flush_data() instead of folding the functionality in
> > > vfs_ioc_setflags_check() (possibly renaming it to
> > > vfs_ioc_setflags_prepare() to indicate it does already some changes)? I
> > > don't see any place that would need these two separated...
> > 
> > XFS needs them to be separated.
> > 
> > If we even /think/ that we're going to be setting the immutable flag
> > then we need to grab the IOLOCK and the MMAPLOCK to prevent further
> > writes while we drain all the directio writes and dirty data.  IO
> > completions for the write draining can take the ILOCK, which means that
> > we can't have grabbed it yet.
> > 
> > Next, we grab the ILOCK so we can check the new flags against the inode
> > and then update the inode core.
> > 
> > For most filesystems I think it suffices to inode_lock and then do both,
> > though.
> 
> Heh, lol, that applies to fssetxattr, not to setflags, because xfs
> setflags implementation open-codes the relevant fssetxattr pieces.
> So for setflags we can combine both parts into a single _prepare
> function.

Yeah. Also for fssetxattr we could use the prepare helper at least for
ext4, f2fs, and btrfs where the situation isn't so complex as for xfs to
save some boilerplate code.

								Honza

> > > > +/*
> > > > + * Flush all pending IO and dirty mappings before setting S_IMMUTABLE on an
> > > > + * inode via FS_IOC_SETFLAGS.  If the flush fails we'll clear the flag before
> > > > + * returning error.
> > > > + *
> > > > + * Note: the caller should be holding i_mutex, or else be sure that
> > > > + * they have exclusive access to the inode structure.
> > > > + */
> > > > +static inline int vfs_ioc_setflags_flush_data(struct inode *inode, int flags)
> > > > +{
> > > > +	int ret;
> > > > +
> > > > +	if (!vfs_ioc_setflags_need_flush(inode, flags))
> > > > +		return 0;
> > > > +
> > > > +	inode_set_flags(inode, S_IMMUTABLE, S_IMMUTABLE);
> > > > +	ret = inode_flush_data(inode);
> > > > +	if (ret)
> > > > +		inode_set_flags(inode, 0, S_IMMUTABLE);
> > > > +	return ret;
> > > > +}
> > > 
> > > Also this sets S_IMMUTABLE whenever vfs_ioc_setflags_need_flush() returns
> > > true. That is currently the right thing but seems like a landmine waiting
> > > to trip? So I'd just drop the vfs_ioc_setflags_need_flush() abstraction to
> > > make it clear what's going on.
> > 
> > Ok.
> > 
> > --D
> > 
> > > 
> > > 								Honza
> > > -- 
> > > Jan Kara <jack@suse.com>
> > > SUSE Labs, CR
> > 
> > _______________________________________________
> > Ocfs2-devel mailing list
> > Ocfs2-devel@oss.oracle.com
> > https://oss.oracle.com/mailman/listinfo/ocfs2-devel
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
