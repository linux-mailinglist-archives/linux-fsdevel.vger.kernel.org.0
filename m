Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 096332DC530
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Dec 2020 18:19:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727046AbgLPRSi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Dec 2020 12:18:38 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:51410 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727008AbgLPRSh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Dec 2020 12:18:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1608139030;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8FGLJKguNbMK2gP5Em1yZc1NF7tx47dbxS41Hnm91nE=;
        b=Wlklmu+wxKDOS1wHH2iZH0xg7DFZZ4Bdj6U3XGQTAB5wN7vrwwTQ0Y2E6kt42SPtfBJ+p0
        bnj1gEJweblvgo5oXylr/kqlpYcfvY84NhblML+VpYDBZGQFnVwvU7JV6l2Vchr3VaKbwj
        I40GQkihqz7Cn8ycYwDmsJhn5msYrBA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-301-5d8WtccSMDWQqSS-Qb92aw-1; Wed, 16 Dec 2020 12:17:06 -0500
X-MC-Unique: 5d8WtccSMDWQqSS-Qb92aw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E4B15803F49;
        Wed, 16 Dec 2020 17:16:19 +0000 (UTC)
Received: from horse.redhat.com (ovpn-112-114.rdu2.redhat.com [10.10.112.114])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9207360BF3;
        Wed, 16 Dec 2020 17:16:19 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id DFC74220BCF; Wed, 16 Dec 2020 12:16:18 -0500 (EST)
Date:   Wed, 16 Dec 2020 12:16:18 -0500
From:   Vivek Goyal <vgoyal@redhat.com>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     Linux fsdevel mailing list <linux-fsdevel@vger.kernel.org>,
        linux-unionfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        viro@zeniv.linux.org.uk, miklos@szeredi.hu, amir73il@gmail.com,
        willy@infradead.org, jack@suse.cz, sargun@sargun.me
Subject: Re: [PATCH] vfs, syncfs: Do not ignore return code from ->sync_fs()
Message-ID: <20201216171618.GB3177@redhat.com>
References: <20201216143802.GA10550@redhat.com>
 <132c8c1e1ab82f5a640ff1ede6bb844885d46e68.camel@kernel.org>
 <20201216151409.GA3177@redhat.com>
 <b7ac787b170e18b620bfb6879eaf567831a0ae34.camel@kernel.org>
 <2b48fe655bd1f821cf575028bc6f811934dad847.camel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2b48fe655bd1f821cf575028bc6f811934dad847.camel@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Dec 16, 2020 at 10:53:16AM -0500, Jeff Layton wrote:
> On Wed, 2020-12-16 at 10:44 -0500, Jeff Layton wrote:
> > On Wed, 2020-12-16 at 10:14 -0500, Vivek Goyal wrote:
> > > On Wed, Dec 16, 2020 at 09:57:49AM -0500, Jeff Layton wrote:
> > > > On Wed, 2020-12-16 at 09:38 -0500, Vivek Goyal wrote:
> > > > > I see that current implementation of __sync_filesystem() ignores the
> > > > > return code from ->sync_fs(). I am not sure why that's the case.
> > > > > 
> > > > > Ignoring ->sync_fs() return code is problematic for overlayfs where
> > > > > it can return error if sync_filesystem() on upper super block failed.
> > > > > That error will simply be lost and sycnfs(overlay_fd), will get
> > > > > success (despite the fact it failed).
> > > > > 
> > > > > I am assuming that we want to continue to call __sync_blockdev()
> > > > > despite the fact that there have been errors reported from
> > > > > ->sync_fs(). So I wrote this simple patch which captures the
> > > > > error from ->sync_fs() but continues to call __sync_blockdev()
> > > > > and returns error from sync_fs() if there is one.
> > > > > 
> > > > > There might be some very good reasons to not capture ->sync_fs()
> > > > > return code, I don't know. Hence thought of proposing this patch.
> > > > > Atleast I will get to know the reason. I still need to figure
> > > > > a way out how to propagate overlay sync_fs() errors to user
> > > > > space.
> > > > > 
> > > > > Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
> > > > > ---
> > > > >  fs/sync.c |    8 ++++++--
> > > > >  1 file changed, 6 insertions(+), 2 deletions(-)
> > > > > 
> > > > > Index: redhat-linux/fs/sync.c
> > > > > ===================================================================
> > > > > --- redhat-linux.orig/fs/sync.c	2020-12-16 09:15:49.831565653 -0500
> > > > > +++ redhat-linux/fs/sync.c	2020-12-16 09:23:42.499853207 -0500
> > > > > @@ -30,14 +30,18 @@
> > > > >   */
> > > > >  static int __sync_filesystem(struct super_block *sb, int wait)
> > > > >  {
> > > > > +	int ret, ret2;
> > > > > +
> > > > >  	if (wait)
> > > > >  		sync_inodes_sb(sb);
> > > > >  	else
> > > > >  		writeback_inodes_sb(sb, WB_REASON_SYNC);
> > > > >  
> > > > > 
> > > > >  	if (sb->s_op->sync_fs)
> > > > > -		sb->s_op->sync_fs(sb, wait);
> > > > > -	return __sync_blockdev(sb->s_bdev, wait);
> > > > > +		ret = sb->s_op->sync_fs(sb, wait);
> > > > > +	ret2 = __sync_blockdev(sb->s_bdev, wait);
> > > > > +
> > > > > +	return ret ? ret : ret2;
> > > > >  }
> > > > >  
> > > > > 
> > > > >  /*
> > > > > 
> > > > 
> > > > I posted a patchset that took a similar approach a couple of years ago,
> > > > and we decided not to go with it [1].
> > > > 
> > > > While it's not ideal to ignore the error here, I think this is likely to
> > > > break stuff.
> > > 
> > > So one side affect I see is that syncfs() might start returning errors
> > > in some cases which were not reported at all. I am wondering will that
> > > count as breakage.
> > > 
> > > > What may be better is to just make sync_fs void return, so
> > > > people don't think that returned errors there mean anything.
> > > 
> > > May be. 
> > > 
> > > But then question remains that how do we return error to user space
> > > in syncfs(fd) for overlayfs. I will not be surprised if other
> > > filesystems want to return errors as well.
> > > 
> > > Shall I create new helpers and call these in case of syncfs(). But
> > > that too will start returning new errors on syncfs(). So it does
> > > not solve that problem (if it is a problem).
> > > 
> > > Or we can define a new super block op say ->sync_fs2() and call that
> > > first and in that case capture return code. That way it will not
> > > impact existing cases and overlayfs can possibly make use of
> > > ->sync_fs2() and return error. IOW, impact will be limited to
> > > only file systems which chose to implement ->sync_fs2().
> > > 
> > > Thanks
> > > Vivek
> > > 
> > 
> > Sure, it's possible to add a sb->sync_fs2, but the problem is that
> > sync_fs is a superblock op, and is missing a lot of important context
> > about how it got called.
> > 
> > syncfs(2) syscall takes a file descriptor argument. I'd add a new f_op-
> > > syncfs vector and turn most of the current guts of the syncfs syscall
> > into a generic_syncfs() that gets called when f_op->syncfs isn't
> > defined.
> > 
> > Overlayfs could then add a ->syncfs op that would give it control over
> > what error gets returned. With that, you could basically leave the old
> > sb->sync_fs routine alone.
> > 
> > I think that's probably the safest approach for allowing overlayfs to
> > propagate syncfs errors from the upper layer to the overlay.
> > 
> 
> To be clear, I mean something like this (draft, untested) patch. You'd
> also need to add a new ->syncfs op for overlayfs, and that could just do
> a check_and_advance against the upper layer sb's errseq_t after calling
> sync_filesystem.

Hi Jeff,

This sounds interesting. Should work for overlayfs. Will make overlayfs
changes.

So basically a new file operations ->syncfs() which says sync filesystem
containing this file. Error code will be captured and returned to
user space. Also filesystem is responsible to check for writeback
errors.

Thanks
Vivek

> 
> -----------------------8<-------------------------
> 
> [PATCH] vfs: add new f_op->syncfs vector
> 
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
>  fs/sync.c          | 30 +++++++++++++++++++++---------
>  include/linux/fs.h |  1 +
>  2 files changed, 22 insertions(+), 9 deletions(-)
> 
> diff --git a/fs/sync.c b/fs/sync.c
> index 1373a610dc78..fc7f73762b9e 100644
> --- a/fs/sync.c
> +++ b/fs/sync.c
> @@ -155,27 +155,39 @@ void emergency_sync(void)
>  	}
>  }
>  
> +static int generic_syncfs(struct file *file)
> +{
> +	int ret, ret2;
> +	struct super_block *sb = file->f_path.dentry->d_sb;
> +
> +	down_read(&sb->s_umount);
> +	ret = sync_filesystem(sb);
> +	up_read(&sb->s_umount);
> +
> +	ret2 = errseq_check_and_advance(&sb->s_wb_err, &f.file->f_sb_err);
> +
> +	fdput(f);
> +	return ret ? ret : ret2;
> +}
> +
>  /*
>   * sync a single super
>   */
>  SYSCALL_DEFINE1(syncfs, int, fd)
>  {
>  	struct fd f = fdget(fd);
> -	struct super_block *sb;
> -	int ret, ret2;
> +	int ret;
>  
>  	if (!f.file)
>  		return -EBADF;
> -	sb = f.file->f_path.dentry->d_sb;
>  
> -	down_read(&sb->s_umount);
> -	ret = sync_filesystem(sb);
> -	up_read(&sb->s_umount);
> -
> -	ret2 = errseq_check_and_advance(&sb->s_wb_err, &f.file->f_sb_err);
> +	if (f.file->f_op->syncfs)
> +		ret = f.file->f_op->syncfs(f.file);
> +	else
> +		ret = generic_syncfs(f.file);
>  
>  	fdput(f);
> -	return ret ? ret : ret2;
> +	return ret;
>  }
>  
>  /**
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index 8667d0cdc71e..6710469b7e33 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -1859,6 +1859,7 @@ struct file_operations {
>  				   struct file *file_out, loff_t pos_out,
>  				   loff_t len, unsigned int remap_flags);
>  	int (*fadvise)(struct file *, loff_t, loff_t, int);
> +	int (*syncfs)(struct file *);
>  } __randomize_layout;
>  
>  struct inode_operations {
> -- 
> 2.29.2
> 
> 
> 

