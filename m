Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3A742DD9AC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Dec 2020 21:10:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729070AbgLQUJk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Dec 2020 15:09:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728203AbgLQUJk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Dec 2020 15:09:40 -0500
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14BFDC061794
        for <linux-fsdevel@vger.kernel.org>; Thu, 17 Dec 2020 12:09:00 -0800 (PST)
Received: by mail-qt1-x82f.google.com with SMTP id c14so21051301qtn.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 17 Dec 2020 12:09:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=poochiereds-net.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=X1/L04rRK1r1xMrcrDJaqbKTKoWzz7Zr0eA57HFr5cM=;
        b=jJL+yjx8YbWWUZPFTC1PKVtMou5mdkUyv3jdwAwVThCEh5AOh4Cbgi6f5FSWR8eC5r
         DeNJK8ViUAxqKzKk8YLPluOphmh7uoBMJ66aq9uUVEBEEornFm9CE+0rnlaJ3oamgZJl
         nVh/ZqPVQYTCzhZZCY1oA+S6ZYPEWrwKeo3DtvN6LHen37g+/EtuaWVIYxXZ46lDZ9xi
         EC1IqzcSmM2CWdObOixhdQG6/b94ptd6Cix6bcnPeuV7gBAj2khupWVSK9HbiPHELRPr
         syJw3Xx2AcdXUDEYV2T1v9Y3WQ/v2TIhVtL+OfJMtYFUtS098zNmfSOosUmQ/CFg+aub
         +QtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=X1/L04rRK1r1xMrcrDJaqbKTKoWzz7Zr0eA57HFr5cM=;
        b=VXF5v0ZENPn6JWADiVi1mQ1otM7Lr1AsHCrKjb26rXO/cr/0hryNhqVFeHcRSA5qQn
         +uCSnLHQrOYtRz3gGt5HckiOYzMzML66agm8uSDbxhzSIT53HKZpVcql9ACTOtFj2nA/
         qRUVMZ0aeHyFLMkdptdcNByCzfhLsEJuNvDUYju66R1/pJzmGKBy3MjVy1a+8jkKF4qm
         pjg4Ak1LRE0TdP5wVZE66A+udU5F/0GwupHihR3Pzgk4xMxKmeFjNhmWzRajYVFvb0Wy
         zjtuX7niqV1hDoUr/N+UX1T/1a9HcY7NFXF5m+MuLt5DOPMlvhDoUSiCwfwy6n9axZdH
         9W8w==
X-Gm-Message-State: AOAM530vUeo7FN/x1zLpMdKWRyJfY+GMGISEVMB9RPi6HJJKtefuuQ94
        lkarGzPG9rP2Ma9ckWzcenaBSA==
X-Google-Smtp-Source: ABdhPJxu4L/8qyzeODf5Urcw5HICzchlDzqWjrqdy5QmrUNwBvVSZIXxNC3Ri776/21NpBENaeGeog==
X-Received: by 2002:ac8:4cc1:: with SMTP id l1mr505404qtv.128.1608235739180;
        Thu, 17 Dec 2020 12:08:59 -0800 (PST)
Received: from tleilax.poochiereds.net (68-20-15-154.lightspeed.rlghnc.sbcglobal.net. [68.20.15.154])
        by smtp.gmail.com with ESMTPSA id p13sm2688454qtp.66.2020.12.17.12.08.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Dec 2020 12:08:58 -0800 (PST)
Date:   Thu, 17 Dec 2020 15:08:56 -0500
From:   Jeffrey Layton <jlayton@poochiereds.net>
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-unionfs@vger.kernel.org, jlayton@kernel.org,
        amir73il@gmail.com, sargun@sargun.me, miklos@szeredi.hu,
        willy@infradead.org, jack@suse.cz, neilb@suse.com,
        viro@zeniv.linux.org.uk
Subject: Re: [PATCH 3/3] overlayfs: Check writeback errors w.r.t upper in
 ->syncfs()
Message-ID: <20201217200856.GA707519@tleilax.poochiereds.net>
References: <20201216233149.39025-1-vgoyal@redhat.com>
 <20201216233149.39025-4-vgoyal@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201216233149.39025-4-vgoyal@redhat.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Dec 16, 2020 at 06:31:49PM -0500, Vivek Goyal wrote:
> Check for writeback error on overlay super block w.r.t "struct file"
> passed in ->syncfs().
> 
> As of now real error happens on upper sb. So this patch first propagates
> error from upper sb to overlay sb and then checks error w.r.t struct
> file passed in.
> 
> Jeff, I know you prefer that I should rather file upper file and check
> error directly on on upper sb w.r.t this real upper file.  While I was
> implementing that I thought what if file is on lower (and has not been
> copied up yet). In that case shall we not check writeback errors and
> return back to user space? That does not sound right though because,
> we are not checking for writeback errors on this file. Rather we
> are checking for any error on superblock. Upper might have an error
> and we should report it to user even if file in question is a lower
> file. And that's why I fell back to this approach. But I am open to
> change it if there are issues in this method.
> 
> Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
> ---
>  fs/overlayfs/ovl_entry.h |  2 ++
>  fs/overlayfs/super.c     | 15 ++++++++++++---
>  2 files changed, 14 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/overlayfs/ovl_entry.h b/fs/overlayfs/ovl_entry.h
> index 1b5a2094df8e..a08fd719ee7b 100644
> --- a/fs/overlayfs/ovl_entry.h
> +++ b/fs/overlayfs/ovl_entry.h
> @@ -79,6 +79,8 @@ struct ovl_fs {
>  	atomic_long_t last_ino;
>  	/* Whiteout dentry cache */
>  	struct dentry *whiteout;
> +	/* Protects multiple sb->s_wb_err update from upper_sb . */
> +	spinlock_t errseq_lock;
>  };
>  
>  static inline struct vfsmount *ovl_upper_mnt(struct ovl_fs *ofs)
> diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
> index b4d92e6fa5ce..e7bc4492205e 100644
> --- a/fs/overlayfs/super.c
> +++ b/fs/overlayfs/super.c
> @@ -291,7 +291,7 @@ int ovl_syncfs(struct file *file)
>  	struct super_block *sb = file->f_path.dentry->d_sb;
>  	struct ovl_fs *ofs = sb->s_fs_info;
>  	struct super_block *upper_sb;
> -	int ret;
> +	int ret, ret2;
>  
>  	ret = 0;
>  	down_read(&sb->s_umount);
> @@ -310,10 +310,18 @@ int ovl_syncfs(struct file *file)
>  	ret = sync_filesystem(upper_sb);
>  	up_read(&upper_sb->s_umount);
>  
> +	/* Update overlay sb->s_wb_err */
> +	if (errseq_check(&upper_sb->s_wb_err, sb->s_wb_err)) {
> +		/* Upper sb has errors since last time */
> +		spin_lock(&ofs->errseq_lock);
> +		errseq_check_and_advance(&upper_sb->s_wb_err, &sb->s_wb_err);
> +		spin_unlock(&ofs->errseq_lock);
> +	}

So, the problem here is that the resulting value in sb->s_wb_err is
going to end up with the REPORTED flag set (using the naming in my
latest set). So, a later opener of a file on sb->s_wb_err won't see it.

For instance, suppose you call sync() on the box and does the above
check and advance. Then, you open the file and call syncfs() and get
back no error because REPORTED flag was set when you opened. That error
will then be lost.

>  
> +	ret2 = errseq_check_and_advance(&sb->s_wb_err, &file->f_sb_err);
>  out:
>  	up_read(&sb->s_umount);
> -	return ret;
> +	return ret ? ret : ret2;
>  }
>  
>  /**
> @@ -1903,6 +1911,7 @@ static int ovl_fill_super(struct super_block *sb, void *data, int silent)
>  	if (!cred)
>  		goto out_err;
>  
> +	spin_lock_init(&ofs->errseq_lock);
>  	/* Is there a reason anyone would want not to share whiteouts? */
>  	ofs->share_whiteout = true;
>  
> @@ -1975,7 +1984,7 @@ static int ovl_fill_super(struct super_block *sb, void *data, int silent)
>  
>  		sb->s_stack_depth = ovl_upper_mnt(ofs)->mnt_sb->s_stack_depth;
>  		sb->s_time_gran = ovl_upper_mnt(ofs)->mnt_sb->s_time_gran;
> -
> +		sb->s_wb_err = errseq_sample(&ovl_upper_mnt(ofs)->mnt_sb->s_wb_err);

This will mark the error on the upper_sb as REPORTED, and that's not
really that's the case if you're just using it set s_wb_err in the
overlay. You might want to use errseq_peek in this situation.

>  	}
>  	oe = ovl_get_lowerstack(sb, splitlower, numlower, ofs, layers);
>  	err = PTR_ERR(oe);
> -- 
> 2.25.4
> 
