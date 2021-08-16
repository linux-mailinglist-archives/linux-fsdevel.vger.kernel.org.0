Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DED153ED6FB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Aug 2021 15:28:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240838AbhHPNZp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 16 Aug 2021 09:25:45 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:52334 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238754AbhHPNYF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 16 Aug 2021 09:24:05 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 2109B21DA5;
        Mon, 16 Aug 2021 13:23:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1629120213; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=22mScugL1fLxQzYMhho9jmQhIvvc4nXeZ8bD48Nn3Rw=;
        b=UukOSQOneF2D+37ccVX3RdNLjDGOxLA8XsbfjUTGpmuNCWgWnqv1i933o+EPUnvtDe2Bzs
        XI1uxNFsGfKIYqa/FTtfFFB5DK9iPDuXzKwc3FR05W2UXMcai5ADYqBy/2qkY+jgOSEefz
        oMLqnAmo8NHR6irNhn3z8eDAqvfwbOs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1629120213;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=22mScugL1fLxQzYMhho9jmQhIvvc4nXeZ8bD48Nn3Rw=;
        b=1BnzC6mXJijnrk2+4keyfNEEUCxjzL3/LBKdZumik0bSvMEh+/VCDJyTi8nG5C0pJiOB/L
        qbCb1swfEPiDLTAQ==
Received: from quack2.suse.cz (unknown [10.100.224.230])
        by relay2.suse.de (Postfix) with ESMTP id 01AE5A3B97;
        Mon, 16 Aug 2021 13:23:33 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id B7FC81E0426; Mon, 16 Aug 2021 15:23:32 +0200 (CEST)
Date:   Mon, 16 Aug 2021 15:23:32 +0200
From:   Jan Kara <jack@suse.cz>
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     amir73il@gmail.com, jack@suse.com, linux-api@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        khazhy@google.com, dhowells@redhat.com, david@fromorbit.com,
        tytso@mit.edu, djwong@kernel.org, repnop@google.com,
        kernel@collabora.com
Subject: Re: [PATCH v6 10/21] fsnotify: Support FS_ERROR event type
Message-ID: <20210816132332.GD30215@quack2.suse.cz>
References: <20210812214010.3197279-1-krisman@collabora.com>
 <20210812214010.3197279-11-krisman@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210812214010.3197279-11-krisman@collabora.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 12-08-21 17:39:59, Gabriel Krisman Bertazi wrote:
> Expose a new type of fsnotify event for filesystems to report errors for
> userspace monitoring tools.  fanotify will send this type of
> notification for FAN_FS_ERROR events.  This also introduce a helper for
> generating the new event.
> 
> Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> 
> ---
> Changes since v5:
>   - pass sb inside data field (jan)
> Changes since v3:
>   - Squash patch ("fsnotify: Introduce helpers to send error_events")
>   - Drop reviewed-bys!
> 
> Changes since v2:
>   - FAN_ERROR->FAN_FS_ERROR (Amir)
> 
> Changes since v1:
>   - Overload FS_ERROR with FS_IN_IGNORED
>   - Implement support for this type on fsnotify_data_inode (Amir)
> ---
>  fs/notify/fsnotify.c             |  3 +++
>  include/linux/fsnotify.h         | 13 +++++++++++++
>  include/linux/fsnotify_backend.h | 18 +++++++++++++++++-
>  3 files changed, 33 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/notify/fsnotify.c b/fs/notify/fsnotify.c
> index 536db02cb26e..6d3b3de4f8ee 100644
> --- a/fs/notify/fsnotify.c
> +++ b/fs/notify/fsnotify.c
> @@ -103,6 +103,9 @@ static struct super_block *fsnotify_data_sb(const void *data, int data_type)
>  	struct inode *inode = fsnotify_data_inode(data, data_type);
>  	struct super_block *sb = inode ? inode->i_sb : NULL;
>  
> +	if (!sb && data_type == FSNOTIFY_EVENT_ERROR)
> +		sb = ((struct fs_error_report *) data)->sb;
> +
>  	return sb;
>  }
>  
> diff --git a/include/linux/fsnotify.h b/include/linux/fsnotify.h
> index f8acddcf54fb..521234af1827 100644
> --- a/include/linux/fsnotify.h
> +++ b/include/linux/fsnotify.h
> @@ -317,4 +317,17 @@ static inline void fsnotify_change(struct dentry *dentry, unsigned int ia_valid)
>  		fsnotify_dentry(dentry, mask);
>  }
>  
> +static inline int fsnotify_sb_error(struct super_block *sb, struct inode *inode,
> +				    int error)
> +{
> +	struct fs_error_report report = {
> +		.error = error,
> +		.inode = inode,
> +		.sb = sb,
> +	};
> +
> +	return fsnotify(FS_ERROR, &report, FSNOTIFY_EVENT_ERROR,
> +			NULL, NULL, NULL, 0);
> +}
> +
>  #endif	/* _LINUX_FS_NOTIFY_H */
> diff --git a/include/linux/fsnotify_backend.h b/include/linux/fsnotify_backend.h
> index e027af3cd8dd..277b6f3e0998 100644
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
> @@ -248,6 +255,13 @@ enum fsnotify_data_type {
>  	FSNOTIFY_EVENT_NONE,
>  	FSNOTIFY_EVENT_PATH,
>  	FSNOTIFY_EVENT_INODE,
> +	FSNOTIFY_EVENT_ERROR,
> +};
> +
> +struct fs_error_report {
> +	int error;
> +	struct inode *inode;
> +	struct super_block *sb;
>  };
>  
>  static inline struct inode *fsnotify_data_inode(const void *data, int data_type)
> @@ -257,6 +271,8 @@ static inline struct inode *fsnotify_data_inode(const void *data, int data_type)
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
