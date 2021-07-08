Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A33433BF8A5
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Jul 2021 13:02:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231570AbhGHLFb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 8 Jul 2021 07:05:31 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:48070 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231522AbhGHLFb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 8 Jul 2021 07:05:31 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 91B24201B1;
        Thu,  8 Jul 2021 11:02:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1625742168; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1cU7MfqQgPXdcdbkJHOrtBR7KIptDDDNA1BHdMiw9/Q=;
        b=Pdy+yi6tS0PkX0IcH1fXJyrBoqxuc0JqE3WWHrY7fa5r1iVwBuorJOXKU4k7oIrY4C5B27
        tBbmuLnVoQ28c1y05gRQIZRgV3ECK6pYI5DrMPzUEdPIdsKM4486AriHZDEuZD2xc4RYpO
        aetcp84Xv3jauIVsU3GyTGeQj7t3ZaQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1625742168;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1cU7MfqQgPXdcdbkJHOrtBR7KIptDDDNA1BHdMiw9/Q=;
        b=X+3hVeGrCvYFVJqxPHLaC8p+YiXBR6Ocxh4bhpiUFBlV7TEqeXB9emYN4JNFkOzZXeknUb
        AMZpZhgLqxvyPJCQ==
Received: from quack2.suse.cz (unknown [10.163.43.118])
        by relay2.suse.de (Postfix) with ESMTP id 7A65BA3B87;
        Thu,  8 Jul 2021 11:02:48 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 6A3DF1E62E4; Thu,  8 Jul 2021 13:02:48 +0200 (CEST)
Date:   Thu, 8 Jul 2021 13:02:48 +0200
From:   Jan Kara <jack@suse.cz>
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     amir73il@gmail.com, djwong@kernel.org, tytso@mit.edu,
        david@fromorbit.com, jack@suse.com, dhowells@redhat.com,
        khazhy@google.com, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, kernel@collabora.com
Subject: Re: [PATCH v3 11/15] fsnotify: Introduce helpers to send error_events
Message-ID: <20210708110248.GD1656@quack2.suse.cz>
References: <20210629191035.681913-1-krisman@collabora.com>
 <20210629191035.681913-12-krisman@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210629191035.681913-12-krisman@collabora.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue 29-06-21 15:10:31, Gabriel Krisman Bertazi wrote:
> Introduce helpers for filesystems interested in reporting FS_ERROR
> events.  When notifying errors, the file system might not have an inode
> to report on the error.  To support this, allow the caller to specify
> the superblock to which the error applies.
> 
> Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>

Looks OK. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> 
> ---
> Changes since v2:
>   - Drop reference to s_fnotify_marks and guards (Amir)
> 
> Changes since v1:
>   - Use the inode argument (Amir)
>   - Protect s_fsnotify_marks with ifdef guard
> ---
>  fs/notify/fsnotify.c             |  2 +-
>  include/linux/fsnotify.h         | 13 +++++++++++++
>  include/linux/fsnotify_backend.h |  1 +
>  3 files changed, 15 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/notify/fsnotify.c b/fs/notify/fsnotify.c
> index 36205a769dde..ac05eb3fb368 100644
> --- a/fs/notify/fsnotify.c
> +++ b/fs/notify/fsnotify.c
> @@ -491,7 +491,7 @@ int __fsnotify(__u32 mask, const struct fsnotify_event_info *event_info)
>  		 */
>  		parent = event_info->dir;
>  	}
> -	sb = inode->i_sb;
> +	sb = event_info->sb ?: inode->i_sb;
>  
>  	/*
>  	 * Optimization: srcu_read_lock() has a memory barrier which can
> diff --git a/include/linux/fsnotify.h b/include/linux/fsnotify.h
> index 8c2c681b4495..684c79ca01b2 100644
> --- a/include/linux/fsnotify.h
> +++ b/include/linux/fsnotify.h
> @@ -326,4 +326,17 @@ static inline void fsnotify_change(struct dentry *dentry, unsigned int ia_valid)
>  		fsnotify_dentry(dentry, mask);
>  }
>  
> +static inline int fsnotify_sb_error(struct super_block *sb, struct inode *inode,
> +				    int error)
> +{
> +	struct fs_error_report report = {
> +		.error = error,
> +		.inode = inode,
> +	};
> +
> +	return __fsnotify(FS_ERROR, &(struct fsnotify_event_info) {
> +			.data = &report, .data_type = FSNOTIFY_EVENT_ERROR,
> +			.sb = sb});
> +}
> +
>  #endif	/* _LINUX_FS_NOTIFY_H */
> diff --git a/include/linux/fsnotify_backend.h b/include/linux/fsnotify_backend.h
> index ea5f5c7cc381..5a32c5010f45 100644
> --- a/include/linux/fsnotify_backend.h
> +++ b/include/linux/fsnotify_backend.h
> @@ -138,6 +138,7 @@ struct fsnotify_event_info {
>  	struct inode *dir;
>  	const struct qstr *name;
>  	struct inode *inode;
> +	struct super_block *sb;
>  	u32 cookie;
>  };
>  
> -- 
> 2.32.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
