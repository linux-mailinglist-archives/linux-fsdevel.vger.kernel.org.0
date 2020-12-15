Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 310952DAFA3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Dec 2020 16:02:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729833AbgLOPCA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Dec 2020 10:02:00 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:44149 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729671AbgLOPBO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Dec 2020 10:01:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1608044387;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yQtL3XL3BRvBs0kbpBbpAXn8f1IOFtkatY9w1sHClRQ=;
        b=U8WsAfOTB6xcKKOzRdgq8veafLEeZVCPz6vh5hipa7mdOlvtITT+OIIJ8R0Xg78DD7Dvy9
        Vg8f82HHOLfoYyZ99OmhVzH2RABDyP6w6KckPhds7y3QFga1hVs6FGaNXmnSSNalzZnEFo
        TDIxIJ3qVVMLH0WIvOWTDgcF+0YyeNQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-34-gBvAMV69OUivIkgJmJCOyQ-1; Tue, 15 Dec 2020 09:59:43 -0500
X-MC-Unique: gBvAMV69OUivIkgJmJCOyQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9891218C8C06;
        Tue, 15 Dec 2020 14:59:41 +0000 (UTC)
Received: from horse.redhat.com (ovpn-117-245.rdu2.redhat.com [10.10.117.245])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2C4F75C6AB;
        Tue, 15 Dec 2020 14:59:41 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id B1A00220BCF; Tue, 15 Dec 2020 09:59:40 -0500 (EST)
Date:   Tue, 15 Dec 2020 09:59:40 -0500
From:   Vivek Goyal <vgoyal@redhat.com>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     Amir Goldstein <amir73il@gmail.com>,
        Sargun Dhillon <sargun@sargun.me>,
        Miklos Szeredi <miklos@szeredi.hu>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        NeilBrown <neilb@suse.com>, Jan Kara <jack@suse.cz>
Subject: Re: [RFC PATCH 2/2] overlayfs: propagate errors from upper to
 overlay sb in sync_fs
Message-ID: <20201215145940.GA63355@redhat.com>
References: <20201213132713.66864-1-jlayton@kernel.org>
 <20201213132713.66864-3-jlayton@kernel.org>
 <20201214213843.GA3453@redhat.com>
 <979d78d04d882744d944f5723ad7a98b14badf8b.camel@kernel.org>
 <73ed2ee27cb21b5879d030f5478839507dc35efd.camel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <73ed2ee27cb21b5879d030f5478839507dc35efd.camel@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Dec 15, 2020 at 08:16:12AM -0500, Jeff Layton wrote:
> On Mon, 2020-12-14 at 18:53 -0500, Jeff Layton wrote:
> > On Mon, 2020-12-14 at 16:38 -0500, Vivek Goyal wrote:
> > > On Sun, Dec 13, 2020 at 08:27:13AM -0500, Jeff Layton wrote:
> > > > Peek at the upper layer's errseq_t at mount time for volatile mounts,
> > > > and record it in the per-sb info. In sync_fs, check for an error since
> > > > the recorded point and set it in the overlayfs superblock if there was
> > > > one.
> > > > 
> > > > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > > > ---
> > > 
> > > While we are solving problem for non-volatile overlay mount, I also
> > > started thinking, what about non-volatile overlay syncfs() writeback errors.
> > > Looks like these will not be reported to user space at all as of now
> > > (because we never update overlay_sb->s_wb_err ever).
> > > 
> > > A patch like this might fix it. (compile tested only).
> > > 
> > > overlayfs: Report syncfs() errors to user space
> > > 
> > > Currently, syncfs(), calls filesystem ->sync_fs() method but ignores the
> > > return code. But certain writeback errors can still be reported on 
> > > syncfs() by checking errors on super block.
> > > 
> > > ret2 = errseq_check_and_advance(&sb->s_wb_err, &f.file->f_sb_err);
> > > 
> > > For the case of overlayfs, we never set overlayfs super block s_wb_err. That
> > > means sync() will never report writeback errors on overlayfs uppon syncfs().
> > > 
> > > Fix this by updating overlay sb->sb_wb_err upon ->sync_fs() call. And that
> > > should mean that user space syncfs() call should see writeback errors.
> > > 
> > > ovl_fsync() does not need anything special because if there are writeback
> > > errors underlying filesystem will report it through vfs_fsync_range() return
> > > code and user space will see it.
> > > 
> > > Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
> > > ---
> > >  fs/overlayfs/ovl_entry.h |    1 +
> > >  fs/overlayfs/super.c     |   14 +++++++++++---
> > >  2 files changed, 12 insertions(+), 3 deletions(-)
> > > 
> > > Index: redhat-linux/fs/overlayfs/super.c
> > > ===================================================================
> > > --- redhat-linux.orig/fs/overlayfs/super.c	2020-12-14 15:33:43.934400880 -0500
> > > +++ redhat-linux/fs/overlayfs/super.c	2020-12-14 16:15:07.127400880 -0500
> > > @@ -259,7 +259,7 @@ static int ovl_sync_fs(struct super_bloc
> > >  {
> > >  	struct ovl_fs *ofs = sb->s_fs_info;
> > >  	struct super_block *upper_sb;
> > > -	int ret;
> > > +	int ret, ret2;
> > >  
> > > 
> > > 
> > > 
> > >  	if (!ovl_upper_mnt(ofs))
> > >  		return 0;
> > > @@ -283,7 +283,14 @@ static int ovl_sync_fs(struct super_bloc
> > >  	ret = sync_filesystem(upper_sb);
> > >  	up_read(&upper_sb->s_umount);
> > >  
> > > 
> > > 
> > > 
> > > -	return ret;
> > > +	if (errseq_check(&upper_sb->s_wb_err, sb->s_wb_err)) {
> > > +		/* Upper sb has errors since last time */
> > > +		spin_lock(&ofs->errseq_lock);
> > > +		ret2 = errseq_check_and_advance(&upper_sb->s_wb_err,
> > > +						&sb->s_wb_err);
> > > +		spin_unlock(&ofs->errseq_lock);
> > > +	}
> > > +	return ret ? ret : ret2;
> > 
> > I think this is probably not quite right.
> > 
> > The problem I think is that the SEEN flag is always going to end up
> > being set in sb->s_wb_err, and that is going to violate the desired
> > semantics. If the writeback error occurred after all fd's were closed,
> > then the next opener wouldn't see it and you'd lose the error.
> > 
> > We probably need a function to cleanly propagate the error from one
> > errseq_t to another so that that doesn't occur. I'll have to think about
> > it.
> > 
> 
> So, the problem is that we can't guarantee that we'll have an open file
> when sync_fs is called. So if you do the check_and_advance in the
> context of a sync() syscall, you'll effectively ensure that a later
> opener on the upper layer won't see the error (since the upper_sb's
> errseq_t will be marked SEEN.

Aha.., I assumed that when ->sync_fs() is called, we always have a
valid fd open. But that's only true if ->sync_fs() is being called
through syncfs(fd) syscall. For the case of plain sync() syscall,
this is not true.

So it leads us back to need of passing "struct file" in ->sync_fs().
And fetching the writeback error from upper can be done only
if a file is open on which syncfs() has been called.

> 
> It's not clear to me what semantics you want in the following situation:
> 
> mount upper layer
> mount overlayfs with non-volatile upper layer
> do "stuff" on overlayfs, and close all files on overlayfs
> get a writeback error on upper layer
> call sync() (sync_fs gets run)
> open file on upper layer mount
> call syncfs() on upper-layer fd
> 
> Should that last syncfs error report an error?

Actually, I was thinking of following.
- mount upper layer
- mount overlayfs (non-volatile)
- Do bunch of writes.
- A writeback error happens on upper file and gets recorded in
  upper fs sb.
- overlay application calls syncfs(fd) and gets the error back. IIUC,
  the way currently things are written, syncfs(fd) will not return
  writeback errors on overlayfs.

> 
> Also, suppose if at the end we instead opened a file on overlayfs and
> issued the syncfs() there -- should we see the error in that case? 

I am thinking that behavior should be similar to as if two file
descriptors have been opened on a regular filesystem. So if I open
one fd1 on overlay and one fd2 on upper and they both were opened
before writeback error happend, then syncfs(fd1) and syncfs(fd2),
both should see the error.

And any of syncfs(fd1) and syncfs(fd2) should set the SEEN flag in 
upper_sb so that new errors can continue to be reported.

IOW, so looks like major problem with this patch is that we need
to propagate error from upper_sb to overlaysb only if a valid
file descriptor is open. IOW, do this in syncfs(fd) path and not
sync() path. And to distinguish between two, we probably need to
pass additional parameter in ->sync_fs().

Am I missing somehting. Just trying to make sure that if we are
solving the problem of syncfs error propagation in overlay, lets
solve it both for volatile as well as non-volatile case so that
there is less confusion later.

Vivek

