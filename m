Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD5E42DA313
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Dec 2020 23:14:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439091AbgLNWNU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 14 Dec 2020 17:13:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2408304AbgLNWFD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 Dec 2020 17:05:03 -0500
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 894FBC0613D6
        for <linux-fsdevel@vger.kernel.org>; Mon, 14 Dec 2020 14:04:17 -0800 (PST)
Received: by mail-il1-x142.google.com with SMTP id c18so17289808iln.10
        for <linux-fsdevel@vger.kernel.org>; Mon, 14 Dec 2020 14:04:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sargun.me; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=kJvd7quPasV3EFWoK28s3bS8fHz862MTxZIPJFPaDY4=;
        b=CuLZNTzmpv3Ei/9s1/uRs3/QHXK6zgXwN2xW0wo/ISSbr8XyszFKIM2+sJVjmkV1hQ
         IYr/dr2mjnYTqQeQW0nJkwJ5Q+8eorWhHqyp+n+8bvOPEK4EYDdlPAlcf4zj9JcSj62A
         yXSiD/gug9JWF7FMhdKJVTvzWlEG75765Ly4k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=kJvd7quPasV3EFWoK28s3bS8fHz862MTxZIPJFPaDY4=;
        b=ibXlRX8ONJxiSkmh1thqBsI7VSJ/eLO4zQ6hWsl57iPS9JIzugccz4GK/rb8g3G3l2
         nXFP71ZxjQkg2UMkTNl7rK4yKLWLl04dspC4XpyYTH9IrwaQKPKTP1SSiOBc7FhN5SW0
         IGvYyiue0W383aECoJXRnNihAh7m8r4Mmg1SYsAMVKIobhoNO+AFc5+kcpRGaqwbQzfM
         YT2w0yYQcFOPylmatAGZce4ijn8ZCjTsuosreablFint7QldFL3IpBw4JKxeIY/KDZcU
         iK/6REtN/LbdN2aQATD7w08IPIr1+SD4zOxtQbigLG301wY4lTz1g+Ly0ao+6ZFxRo6/
         SNMA==
X-Gm-Message-State: AOAM530GZU+gKOE5xY/ChoufRb1NeVAn2w8n3xLHlhMtEO0LQO6A0SBn
        azAmx+iLLFekgzKmBJdPGB+JoA==
X-Google-Smtp-Source: ABdhPJwEZgLLRarVmnGGhUKekA6lyS3f/A6En/cCHianNt1hMitHCxc4fgGTARBahHfl6UnFbAgLRg==
X-Received: by 2002:a92:9f59:: with SMTP id u86mr37409988ili.205.1607983456789;
        Mon, 14 Dec 2020 14:04:16 -0800 (PST)
Received: from ircssh-2.c.rugged-nimbus-611.internal (80.60.198.104.bc.googleusercontent.com. [104.198.60.80])
        by smtp.gmail.com with ESMTPSA id s4sm10112385ioc.33.2020.12.14.14.04.15
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 14 Dec 2020 14:04:16 -0800 (PST)
Date:   Mon, 14 Dec 2020 22:04:14 +0000
From:   Sargun Dhillon <sargun@sargun.me>
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     Jeff Layton <jlayton@kernel.org>,
        Amir Goldstein <amir73il@gmail.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        NeilBrown <neilb@suse.com>, Jan Kara <jack@suse.cz>
Subject: Re: [RFC PATCH 2/2] overlayfs: propagate errors from upper to
 overlay sb in sync_fs
Message-ID: <20201214220413.GA6508@ircssh-2.c.rugged-nimbus-611.internal>
References: <20201213132713.66864-1-jlayton@kernel.org>
 <20201213132713.66864-3-jlayton@kernel.org>
 <20201214213843.GA3453@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201214213843.GA3453@redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Dec 14, 2020 at 04:38:43PM -0500, Vivek Goyal wrote:
> On Sun, Dec 13, 2020 at 08:27:13AM -0500, Jeff Layton wrote:
> > Peek at the upper layer's errseq_t at mount time for volatile mounts,
> > and record it in the per-sb info. In sync_fs, check for an error since
> > the recorded point and set it in the overlayfs superblock if there was
> > one.
> > 
> > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > ---
> 
> While we are solving problem for non-volatile overlay mount, I also
> started thinking, what about non-volatile overlay syncfs() writeback errors.
> Looks like these will not be reported to user space at all as of now
> (because we never update overlay_sb->s_wb_err ever).
> 
> A patch like this might fix it. (compile tested only).
> 
> overlayfs: Report syncfs() errors to user space
> 
> Currently, syncfs(), calls filesystem ->sync_fs() method but ignores the
> return code. But certain writeback errors can still be reported on 
> syncfs() by checking errors on super block.
> 
> ret2 = errseq_check_and_advance(&sb->s_wb_err, &f.file->f_sb_err);
> 
> For the case of overlayfs, we never set overlayfs super block s_wb_err. That
> means sync() will never report writeback errors on overlayfs uppon syncfs().
> 
> Fix this by updating overlay sb->sb_wb_err upon ->sync_fs() call. And that
> should mean that user space syncfs() call should see writeback errors.
> 
> ovl_fsync() does not need anything special because if there are writeback
> errors underlying filesystem will report it through vfs_fsync_range() return
> code and user space will see it.
> 
> Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
> ---
>  fs/overlayfs/ovl_entry.h |    1 +
>  fs/overlayfs/super.c     |   14 +++++++++++---
>  2 files changed, 12 insertions(+), 3 deletions(-)
> 
> Index: redhat-linux/fs/overlayfs/super.c
> ===================================================================
> --- redhat-linux.orig/fs/overlayfs/super.c	2020-12-14 15:33:43.934400880 -0500
> +++ redhat-linux/fs/overlayfs/super.c	2020-12-14 16:15:07.127400880 -0500
> @@ -259,7 +259,7 @@ static int ovl_sync_fs(struct super_bloc
>  {
>  	struct ovl_fs *ofs = sb->s_fs_info;
>  	struct super_block *upper_sb;
> -	int ret;
> +	int ret, ret2;
>  
>  	if (!ovl_upper_mnt(ofs))
>  		return 0;
> @@ -283,7 +283,14 @@ static int ovl_sync_fs(struct super_bloc
>  	ret = sync_filesystem(upper_sb);
>  	up_read(&upper_sb->s_umount);
>  
> -	return ret;
> +	if (errseq_check(&upper_sb->s_wb_err, sb->s_wb_err)) {
> +		/* Upper sb has errors since last time */
> +		spin_lock(&ofs->errseq_lock);
> +		ret2 = errseq_check_and_advance(&upper_sb->s_wb_err,
> +						&sb->s_wb_err);
> +		spin_unlock(&ofs->errseq_lock);
> +	}
> +	return ret ? ret : ret2;
>  }
>  
>  /**
> @@ -1873,6 +1880,7 @@ static int ovl_fill_super(struct super_b
>  	if (!cred)
>  		goto out_err;
>  
> +	spin_lock_init(&ofs->errseq_lock);
>  	/* Is there a reason anyone would want not to share whiteouts? */
>  	ofs->share_whiteout = true;
>  
> @@ -1945,7 +1953,7 @@ static int ovl_fill_super(struct super_b
>  
>  		sb->s_stack_depth = ovl_upper_mnt(ofs)->mnt_sb->s_stack_depth;
>  		sb->s_time_gran = ovl_upper_mnt(ofs)->mnt_sb->s_time_gran;
> -
> +		sb->s_wb_err = errseq_sample(&ovl_upper_mnt(ofs)->mnt_sb->s_wb_err);
>  	}
>  	oe = ovl_get_lowerstack(sb, splitlower, numlower, ofs, layers);
>  	err = PTR_ERR(oe);
> Index: redhat-linux/fs/overlayfs/ovl_entry.h
> ===================================================================
> --- redhat-linux.orig/fs/overlayfs/ovl_entry.h	2020-12-14 15:33:43.934400880 -0500
> +++ redhat-linux/fs/overlayfs/ovl_entry.h	2020-12-14 15:34:13.509400880 -0500
> @@ -79,6 +79,7 @@ struct ovl_fs {
>  	atomic_long_t last_ino;
>  	/* Whiteout dentry cache */
>  	struct dentry *whiteout;
> +	spinlock_t errseq_lock;
>  };
>  
>  static inline struct vfsmount *ovl_upper_mnt(struct ovl_fs *ofs)
> 

This was on my list of things to look at. I don't think we can / should use 
errseq_check_and_advance because it will hide errors from userspace. I think we 
need something like:

At startup, call errseq_peek and stash that value somewhere. This sets the 
MUSTINC flag.

At syncfs time: call errseq check, if it says there is an error, call 
errseq_peek again, and store the error in our superblock. Take the error value 
from the differenceb between the previous one and the new one, and copy it up to 
the superblock.

Either way, I think Jeff's work of making it so other kernel subsytems can 
interact with errseq on a superblock bears fruit elsewhere. If the first patch 
gets merged, I can put together the patches to do the standard error bubble
up for normal syncfs, volatile syncfs, and volatile remount.
