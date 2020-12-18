Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12A202DE512
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Dec 2020 15:46:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725932AbgLROpw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 18 Dec 2020 09:45:52 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:53595 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726516AbgLROpv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 18 Dec 2020 09:45:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1608302664;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CthNdoUY/FIFXJCBduT4k2Ir0PRGPQTHNOp+0Jn+7JM=;
        b=iUBRr0wwn5WrnV21fjD6S+VIy/UnNgf+Kn6032G5xBV+mTBEsshB+HpuvEtoBRIXF+Fizv
        SKkI8Is5ykMt2dpRMZG7Fhpa4qEqt7yLPM81lfgn4+m1FnShtsHJ7EEv9+0sFrj6uYcd5h
        YtcTH8DEU9FZRbtsPd+N/ajbcM/WpH0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-169-pEZB78OdMT2Hg7zsV1RQcA-1; Fri, 18 Dec 2020 09:44:21 -0500
X-MC-Unique: pEZB78OdMT2Hg7zsV1RQcA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 43D98800688;
        Fri, 18 Dec 2020 14:44:19 +0000 (UTC)
Received: from horse.redhat.com (ovpn-115-223.rdu2.redhat.com [10.10.115.223])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B815B60CED;
        Fri, 18 Dec 2020 14:44:18 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 3E856220BCF; Fri, 18 Dec 2020 09:44:18 -0500 (EST)
Date:   Fri, 18 Dec 2020 09:44:18 -0500
From:   Vivek Goyal <vgoyal@redhat.com>
To:     Jeffrey Layton <jlayton@poochiereds.net>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-unionfs@vger.kernel.org, jlayton@kernel.org,
        amir73il@gmail.com, sargun@sargun.me, miklos@szeredi.hu,
        willy@infradead.org, jack@suse.cz, neilb@suse.com,
        viro@zeniv.linux.org.uk
Subject: Re: [PATCH 3/3] overlayfs: Check writeback errors w.r.t upper in
 ->syncfs()
Message-ID: <20201218144418.GA3424@redhat.com>
References: <20201216233149.39025-1-vgoyal@redhat.com>
 <20201216233149.39025-4-vgoyal@redhat.com>
 <20201217200856.GA707519@tleilax.poochiereds.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201217200856.GA707519@tleilax.poochiereds.net>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Dec 17, 2020 at 03:08:56PM -0500, Jeffrey Layton wrote:
> On Wed, Dec 16, 2020 at 06:31:49PM -0500, Vivek Goyal wrote:
> > Check for writeback error on overlay super block w.r.t "struct file"
> > passed in ->syncfs().
> > 
> > As of now real error happens on upper sb. So this patch first propagates
> > error from upper sb to overlay sb and then checks error w.r.t struct
> > file passed in.
> > 
> > Jeff, I know you prefer that I should rather file upper file and check
> > error directly on on upper sb w.r.t this real upper file.  While I was
> > implementing that I thought what if file is on lower (and has not been
> > copied up yet). In that case shall we not check writeback errors and
> > return back to user space? That does not sound right though because,
> > we are not checking for writeback errors on this file. Rather we
> > are checking for any error on superblock. Upper might have an error
> > and we should report it to user even if file in question is a lower
> > file. And that's why I fell back to this approach. But I am open to
> > change it if there are issues in this method.
> > 
> > Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
> > ---
> >  fs/overlayfs/ovl_entry.h |  2 ++
> >  fs/overlayfs/super.c     | 15 ++++++++++++---
> >  2 files changed, 14 insertions(+), 3 deletions(-)
> > 
> > diff --git a/fs/overlayfs/ovl_entry.h b/fs/overlayfs/ovl_entry.h
> > index 1b5a2094df8e..a08fd719ee7b 100644
> > --- a/fs/overlayfs/ovl_entry.h
> > +++ b/fs/overlayfs/ovl_entry.h
> > @@ -79,6 +79,8 @@ struct ovl_fs {
> >  	atomic_long_t last_ino;
> >  	/* Whiteout dentry cache */
> >  	struct dentry *whiteout;
> > +	/* Protects multiple sb->s_wb_err update from upper_sb . */
> > +	spinlock_t errseq_lock;
> >  };
> >  
> >  static inline struct vfsmount *ovl_upper_mnt(struct ovl_fs *ofs)
> > diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
> > index b4d92e6fa5ce..e7bc4492205e 100644
> > --- a/fs/overlayfs/super.c
> > +++ b/fs/overlayfs/super.c
> > @@ -291,7 +291,7 @@ int ovl_syncfs(struct file *file)
> >  	struct super_block *sb = file->f_path.dentry->d_sb;
> >  	struct ovl_fs *ofs = sb->s_fs_info;
> >  	struct super_block *upper_sb;
> > -	int ret;
> > +	int ret, ret2;
> >  
> >  	ret = 0;
> >  	down_read(&sb->s_umount);
> > @@ -310,10 +310,18 @@ int ovl_syncfs(struct file *file)
> >  	ret = sync_filesystem(upper_sb);
> >  	up_read(&upper_sb->s_umount);
> >  
> > +	/* Update overlay sb->s_wb_err */
> > +	if (errseq_check(&upper_sb->s_wb_err, sb->s_wb_err)) {
> > +		/* Upper sb has errors since last time */
> > +		spin_lock(&ofs->errseq_lock);
> > +		errseq_check_and_advance(&upper_sb->s_wb_err, &sb->s_wb_err);
> > +		spin_unlock(&ofs->errseq_lock);
> > +	}
> 
> So, the problem here is that the resulting value in sb->s_wb_err is
> going to end up with the REPORTED flag set (using the naming in my
> latest set). So, a later opener of a file on sb->s_wb_err won't see it.
> 
> For instance, suppose you call sync() on the box and does the above
> check and advance. Then, you open the file and call syncfs() and get
> back no error because REPORTED flag was set when you opened. That error
> will then be lost.

Hi Jeff,

In this patch, I am doing this only in ->syncfs() path and not in
->sync_fs() path. IOW, errseq_check_and_advance() will take place
only if there is a valid "struct file" passed in. That means there
is a consumer of the error and that means it should be fine to
set the sb->s_wb_err as SEEN/REPORTED, right?

If we end up plumbming "struct file" in existing ->sync_fs() routine,
then I will call this only if a non NULL struct file has been 
passed in. Otherwise skip this step. 

IOW, sync() call will not result in errseq_check_and_advance() instead
a syncfs() call will. 

> 
> >  
> > +	ret2 = errseq_check_and_advance(&sb->s_wb_err, &file->f_sb_err);
> >  out:
> >  	up_read(&sb->s_umount);
> > -	return ret;
> > +	return ret ? ret : ret2;
> >  }
> >  
> >  /**
> > @@ -1903,6 +1911,7 @@ static int ovl_fill_super(struct super_block *sb, void *data, int silent)
> >  	if (!cred)
> >  		goto out_err;
> >  
> > +	spin_lock_init(&ofs->errseq_lock);
> >  	/* Is there a reason anyone would want not to share whiteouts? */
> >  	ofs->share_whiteout = true;
> >  
> > @@ -1975,7 +1984,7 @@ static int ovl_fill_super(struct super_block *sb, void *data, int silent)
> >  
> >  		sb->s_stack_depth = ovl_upper_mnt(ofs)->mnt_sb->s_stack_depth;
> >  		sb->s_time_gran = ovl_upper_mnt(ofs)->mnt_sb->s_time_gran;
> > -
> > +		sb->s_wb_err = errseq_sample(&ovl_upper_mnt(ofs)->mnt_sb->s_wb_err);
> 
> This will mark the error on the upper_sb as REPORTED, and that's not
> really that's the case if you're just using it set s_wb_err in the
> overlay. You might want to use errseq_peek in this situation.

For now I am still looking at existing code and not new code. Because
I belive that new code does not change existing behavior instead
provides additional functionality to allow sampling the error without
marking it seen as well as provide helper to not force seeing an
unseen error.

So current errseq_sample() does not mark error SEEN. And if it is
an unseen error, we will get 0 and be forced to see the error next
time.

One small issue with this is that say upper has unseen error. Now
we mount overlay and save that value in sb->s_wb_err (unseen). Say
a file is opened on upper and error is now seen on upper. But
we still have unseen error cached in overlay and if overlay fd is
now opened, f->f_sb_err will be 0 and it will be forced to see
err on next syncfs().

IOW, despite the fact that overlay fd was opened after upper sb had
been marked seen, it still will see error. I think it probably is
not a big issue.

Vivek

> 
> >  	}
> >  	oe = ovl_get_lowerstack(sb, splitlower, numlower, ofs, layers);
> >  	err = PTR_ERR(oe);
> > -- 
> > 2.25.4
> > 
> 

