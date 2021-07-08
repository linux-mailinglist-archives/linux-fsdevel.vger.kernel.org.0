Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E669D3BF895
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Jul 2021 12:53:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231556AbhGHK4S (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 8 Jul 2021 06:56:18 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:50312 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231493AbhGHK4S (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 8 Jul 2021 06:56:18 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id BB6D1220DD;
        Thu,  8 Jul 2021 10:53:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1625741615; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+mquy67D6sfM4ufamIrhfw0Nc9sWsE9LURl98iAYttg=;
        b=vtvIwVBFg1lbnd4n1znfvL3HMm9qhg/P6BH0mm7aZr2E0edtQVs9q6E5QalONecX/epRCU
        lWy8BhVqQuhrStQQEx0G4MWBey6kZ3oev9v2XjdANfZJmIRbFeEdAs+13n2FZD70YL1jc3
        TTFRpyRGJBzXX4W80U3K85Aeg4fjh9I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1625741615;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+mquy67D6sfM4ufamIrhfw0Nc9sWsE9LURl98iAYttg=;
        b=koRC34SOaWckw5M0scomqd5WA+Wid0QlkAH+LIBxp9HmLB5yXwoa1N6zE4704PN30YbJrk
        4et31w4xZiwHHACw==
Received: from quack2.suse.cz (unknown [10.163.43.118])
        by relay2.suse.de (Postfix) with ESMTP id 9BBF2A3B8B;
        Thu,  8 Jul 2021 10:53:35 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 8526A1E62E4; Thu,  8 Jul 2021 12:53:35 +0200 (CEST)
Date:   Thu, 8 Jul 2021 12:53:35 +0200
From:   Jan Kara <jack@suse.cz>
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     amir73il@gmail.com, djwong@kernel.org, tytso@mit.edu,
        david@fromorbit.com, jack@suse.com, dhowells@redhat.com,
        khazhy@google.com, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, kernel@collabora.com
Subject: Re: [PATCH v3 10/15] fsnotify: Support FS_ERROR event type
Message-ID: <20210708105335.GC1656@quack2.suse.cz>
References: <20210629191035.681913-1-krisman@collabora.com>
 <20210629191035.681913-11-krisman@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210629191035.681913-11-krisman@collabora.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue 29-06-21 15:10:30, Gabriel Krisman Bertazi wrote:
> Expose a new type of fsnotify event for filesystems to report errors for
> userspace monitoring tools.  fanotify will send this type of
> notification for FAN_FS_ERROR events.
> 
> Reviewed-by: Amir Goldstein <amir73il@gmail.com>
> Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>

Looks sensible. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> 
> ---
> Changes since v2:
>   - FAN_ERROR->FAN_FS_ERROR (Amir)
> 
> Changes since v1:
>   - Overload FS_ERROR with FS_IN_IGNORED
>   - Implement support for this type on fsnotify_data_inode (Amir)
> ---
>  include/linux/fsnotify_backend.h | 17 ++++++++++++++++-
>  1 file changed, 16 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/fsnotify_backend.h b/include/linux/fsnotify_backend.h
> index 8222fe12a6c9..ea5f5c7cc381 100644
> --- a/include/linux/fsnotify_backend.h
> +++ b/include/linux/fsnotify_backend.h
> @@ -42,6 +42,12 @@
>  
>  #define FS_UNMOUNT		0x00002000	/* inode on umount fs */
>  #define FS_Q_OVERFLOW		0x00004000	/* Event queued overflowed */
> +#define FS_ERROR		0x00008000	/* Filesystem Error (fanotify) */
> +
> +/*
> + * FS_IN_IGNORED overloads FS_ERROR.  It is only used internally by inotify
> + * which does not support FS_ERROR.
> + */
>  #define FS_IN_IGNORED		0x00008000	/* last inotify event here */
>  
>  #define FS_OPEN_PERM		0x00010000	/* open event in an permission hook */
> @@ -95,7 +101,8 @@
>  #define ALL_FSNOTIFY_EVENTS (ALL_FSNOTIFY_DIRENT_EVENTS | \
>  			     FS_EVENTS_POSS_ON_CHILD | \
>  			     FS_DELETE_SELF | FS_MOVE_SELF | FS_DN_RENAME | \
> -			     FS_UNMOUNT | FS_Q_OVERFLOW | FS_IN_IGNORED)
> +			     FS_UNMOUNT | FS_Q_OVERFLOW | FS_IN_IGNORED | \
> +			     FS_ERROR)
>  
>  /* Extra flags that may be reported with event or control handling of events */
>  #define ALL_FSNOTIFY_FLAGS  (FS_EXCL_UNLINK | FS_ISDIR | FS_IN_ONESHOT | \
> @@ -263,6 +270,12 @@ enum fsnotify_data_type {
>  	FSNOTIFY_EVENT_NONE,
>  	FSNOTIFY_EVENT_PATH,
>  	FSNOTIFY_EVENT_INODE,
> +	FSNOTIFY_EVENT_ERROR,
> +};
> +
> +struct fs_error_report {
> +	int error;
> +	struct inode *inode;
>  };
>  
>  static inline struct inode *fsnotify_data_inode(const void *data, int data_type)
> @@ -272,6 +285,8 @@ static inline struct inode *fsnotify_data_inode(const void *data, int data_type)
>  		return (struct inode *)data;
>  	case FSNOTIFY_EVENT_PATH:
>  		return d_inode(((const struct path *)data)->dentry);
> +	case FSNOTIFY_EVENT_ERROR:
> +		return ((struct fs_error_report *)data)->inode;
>  	default:
>  		return NULL;
>  	}
> -- 
> 2.32.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
