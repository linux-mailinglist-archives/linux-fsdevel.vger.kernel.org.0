Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43D602DB179
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Dec 2020 17:34:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730789AbgLOQcu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Dec 2020 11:32:50 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:59752 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730679AbgLOQck (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Dec 2020 11:32:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1608049869;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=udWFvzQvOxdj41oV5teTq8mWiC5+fQqsrITOoptPui8=;
        b=NyeReEmPdx7bKSPBtL0MRrND2HmXXuTrG5tHBzrGix3+n9nrBMveWaMlRmv9TVK4/lP5oX
        65+4A8lqSUrGg8acJ9PLzlcmNz4j33poeJd0k3KKl1lnifHM9ahM7xTReH1641N7DSW9oO
        bNXC8zV7nJ3fsvahgS5qXv4rqsABKh8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-205-h2wha-MmM4Cz1qNzeXwwSw-1; Tue, 15 Dec 2020 11:31:00 -0500
X-MC-Unique: h2wha-MmM4Cz1qNzeXwwSw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DFF496D520;
        Tue, 15 Dec 2020 16:30:58 +0000 (UTC)
Received: from horse.redhat.com (ovpn-117-245.rdu2.redhat.com [10.10.117.245])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 775CF60854;
        Tue, 15 Dec 2020 16:30:58 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 1277D220BCF; Tue, 15 Dec 2020 11:30:58 -0500 (EST)
Date:   Tue, 15 Dec 2020 11:30:58 -0500
From:   Vivek Goyal <vgoyal@redhat.com>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     Amir Goldstein <amir73il@gmail.com>,
        Sargun Dhillon <sargun@sargun.me>,
        Miklos Szeredi <miklos@szeredi.hu>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        NeilBrown <neilb@suse.com>, Jan Kara <jack@suse.cz>
Subject: Re: [RFC PATCH v2 2/2] overlayfs: propagate errors from upper to
 overlay sb in sync_fs
Message-ID: <20201215163058.GC63355@redhat.com>
References: <20201214221421.1127423-1-jlayton@kernel.org>
 <20201214221421.1127423-3-jlayton@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201214221421.1127423-3-jlayton@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Dec 14, 2020 at 05:14:21PM -0500, Jeff Layton wrote:
> Peek at the upper layer's errseq_t at mount time for volatile mounts,
> and record it in the per-sb info. In sync_fs, check for an error since
> the recorded point and set it in the overlayfs superblock if there was
> one.
> 
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
>  fs/overlayfs/ovl_entry.h |  1 +
>  fs/overlayfs/super.c     | 19 ++++++++++++++-----
>  2 files changed, 15 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/overlayfs/ovl_entry.h b/fs/overlayfs/ovl_entry.h
> index 1b5a2094df8e..f4285da50525 100644
> --- a/fs/overlayfs/ovl_entry.h
> +++ b/fs/overlayfs/ovl_entry.h
> @@ -79,6 +79,7 @@ struct ovl_fs {
>  	atomic_long_t last_ino;
>  	/* Whiteout dentry cache */
>  	struct dentry *whiteout;
> +	errseq_t errseq;
>  };
>  
>  static inline struct vfsmount *ovl_upper_mnt(struct ovl_fs *ofs)
> diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
> index 290983bcfbb3..3f0cb91915ff 100644
> --- a/fs/overlayfs/super.c
> +++ b/fs/overlayfs/super.c
> @@ -264,8 +264,16 @@ static int ovl_sync_fs(struct super_block *sb, int wait)
>  	if (!ovl_upper_mnt(ofs))
>  		return 0;
>  
> -	if (!ovl_should_sync(ofs))
> -		return 0;
> +	upper_sb = ovl_upper_mnt(ofs)->mnt_sb;
> +
> +	if (!ovl_should_sync(ofs)) {
> +		/* Propagate errors from upper to overlayfs */
> +		ret = errseq_check(&upper_sb->s_wb_err, ofs->errseq);
> +		if (ret)
> +			errseq_set(&sb->s_wb_err, ret);
> +		return ret;
> +	}
> +

I have few concerns here. I think ovl_sync_fs() should not be different
for volatile mounts and non-volatile mounts. IOW, if an overlayfs
user calls syncfs(fd), then only difference with non-volatile mount
is that we will not call sync_filesystem() on underlying filesystem. But
if there is an existing writeback error then that should be reported
to syncfs(fd) caller both in case of volatile and non-volatile mounts.

Additional requirement in case of non-volatile mount seems to be that
as soon as we detect first error, we probably should mark whole file
system bad and start returning error for overlay operations so that
upper layer can be thrown away and process restarted.

And final non-volatile mount requirement seems to that we want to detect
writeback errors in non syncfs() paths, for ex. mount(). That's what
Sargun is trying to do. Keep a snapshot of upper_sb errseq on disk
and upon remount of volatile overlay make sure no writeback errors
have happened since then. And that's where I think we should be using
new errseq_peek() and errseq_check(&upper_sb->s_wb_err, ofs->errseq)
infracture. That way we can detect error on upper without consuming
it upon overlay remount.

IOW, IMHO, ovl_sync_fs(), should use same mechanism to report error to
user space both for volatile and non-volatile mounts. And this new
mechanism of peeking at error without consuming it should be used
in other paths like remount and possibly other overlay operations(if need
be). 

But creating a special path in ovl_sync_fs() for volatile mounts
only will create conflicts with error reporting for non-volatile
mounts. And IMHO, these should be same.

Is there a good reason that why we should treat volatile and non-volatile
mounts differently in ovl_sync_fs() from error detection and reporting
point of view.

Thanks
Vivek

>  	/*
>  	 * Not called for sync(2) call or an emergency sync (SB_I_SKIP_SYNC).
>  	 * All the super blocks will be iterated, including upper_sb.
> @@ -277,8 +285,6 @@ static int ovl_sync_fs(struct super_block *sb, int wait)
>  	if (!wait)
>  		return 0;
>  
> -	upper_sb = ovl_upper_mnt(ofs)->mnt_sb;
> -
>  	down_read(&upper_sb->s_umount);
>  	ret = sync_filesystem(upper_sb);
>  	up_read(&upper_sb->s_umount);
> @@ -1945,8 +1951,11 @@ static int ovl_fill_super(struct super_block *sb, void *data, int silent)
>  
>  		sb->s_stack_depth = ovl_upper_mnt(ofs)->mnt_sb->s_stack_depth;
>  		sb->s_time_gran = ovl_upper_mnt(ofs)->mnt_sb->s_time_gran;
> -
>  	}
> +
> +	if (ofs->config.ovl_volatile)
> +		ofs->errseq = errseq_peek(&ovl_upper_mnt(ofs)->mnt_sb->s_wb_err);
> +
>  	oe = ovl_get_lowerstack(sb, splitlower, numlower, ofs, layers);
>  	err = PTR_ERR(oe);
>  	if (IS_ERR(oe))
> -- 
> 2.29.2
> 

