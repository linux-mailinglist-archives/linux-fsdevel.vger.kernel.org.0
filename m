Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52A23433AF8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Oct 2021 17:44:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232251AbhJSPqq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Oct 2021 11:46:46 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:57342 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229991AbhJSPqn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Oct 2021 11:46:43 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id E6F8521973;
        Tue, 19 Oct 2021 15:44:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1634658269; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3tZNcR6QrOhRMy1KFcDYAEvnL+dLcBd4uEjJIX0zAXg=;
        b=CB+xTa+Kx5k+ET/K7Yb7sBC1Hb3df4EFzQArsUn5IOVnWqVnqsGCnFq6ki/4KKWqz+NdgL
        k2wgWngbyZrZoXbjsaWqQddY+zO8X/I7sFrv4+92CKIWGvWbGPCYd3XtYmAv8maGQc1U0Y
        E5d9xTWrBlyDKA5ImVAakPfk1iJAboU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1634658269;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3tZNcR6QrOhRMy1KFcDYAEvnL+dLcBd4uEjJIX0zAXg=;
        b=HAtYGK65SwvJxuD5g3I8SwVBbZRMxNOoDLNkvM5D8iZbMX2PitPJzrxurDzlHI0PEevEDY
        +BR0oocSdYAcrgAg==
Received: from quack2.suse.cz (unknown [10.100.200.198])
        by relay2.suse.de (Postfix) with ESMTP id CA6BAA3B93;
        Tue, 19 Oct 2021 15:44:29 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id A6B7E1E0983; Tue, 19 Oct 2021 17:44:26 +0200 (CEST)
Date:   Tue, 19 Oct 2021 17:44:26 +0200
From:   Jan Kara <jack@suse.cz>
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     jack@suse.com, amir73il@gmail.com, djwong@kernel.org,
        tytso@mit.edu, david@fromorbit.com, dhowells@redhat.com,
        khazhy@google.com, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-api@vger.kernel.org,
        kernel@collabora.com
Subject: Re: [PATCH v8 30/32] ext4: Send notifications on error
Message-ID: <20211019154426.GR3255@quack2.suse.cz>
References: <20211019000015.1666608-1-krisman@collabora.com>
 <20211019000015.1666608-31-krisman@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211019000015.1666608-31-krisman@collabora.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon 18-10-21 21:00:13, Gabriel Krisman Bertazi wrote:
> Send a FS_ERROR message via fsnotify to a userspace monitoring tool
> whenever a ext4 error condition is triggered.  This follows the existing
> error conditions in ext4, so it is hooked to the ext4_error* functions.
> 
> It also follows the current dmesg reporting in the format.  The
> filesystem message is composed mostly by the string that would be
> otherwise printed in dmesg.
> 
> A new ext4 specific record format is exposed in the uapi, such that a
> monitoring tool knows what to expect when listening errors of an ext4
> filesystem.
> 
> Reviewed-by: Amir Goldstein <amir73il@gmail.com>
> Reviewed-by: Theodore Ts'o <tytso@mit.edu>
> Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>

Looks good to me. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> 
> ---
> Changes since v6:
>   - Report ext4_std_errors agains superblock (jan)
> ---
>  fs/ext4/super.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> index 88d5d274a868..67183e6b1920 100644
> --- a/fs/ext4/super.c
> +++ b/fs/ext4/super.c
> @@ -46,6 +46,7 @@
>  #include <linux/part_stat.h>
>  #include <linux/kthread.h>
>  #include <linux/freezer.h>
> +#include <linux/fsnotify.h>
>  
>  #include "ext4.h"
>  #include "ext4_extents.h"	/* Needed for trace points definition */
> @@ -759,6 +760,8 @@ void __ext4_error(struct super_block *sb, const char *function,
>  		       sb->s_id, function, line, current->comm, &vaf);
>  		va_end(args);
>  	}
> +	fsnotify_sb_error(sb, NULL, error);
> +
>  	ext4_handle_error(sb, force_ro, error, 0, block, function, line);
>  }
>  
> @@ -789,6 +792,8 @@ void __ext4_error_inode(struct inode *inode, const char *function,
>  			       current->comm, &vaf);
>  		va_end(args);
>  	}
> +	fsnotify_sb_error(inode->i_sb, inode, error);
> +
>  	ext4_handle_error(inode->i_sb, false, error, inode->i_ino, block,
>  			  function, line);
>  }
> @@ -827,6 +832,8 @@ void __ext4_error_file(struct file *file, const char *function,
>  			       current->comm, path, &vaf);
>  		va_end(args);
>  	}
> +	fsnotify_sb_error(inode->i_sb, inode, EFSCORRUPTED);
> +
>  	ext4_handle_error(inode->i_sb, false, EFSCORRUPTED, inode->i_ino, block,
>  			  function, line);
>  }
> @@ -894,6 +901,7 @@ void __ext4_std_error(struct super_block *sb, const char *function,
>  		printk(KERN_CRIT "EXT4-fs error (device %s) in %s:%d: %s\n",
>  		       sb->s_id, function, line, errstr);
>  	}
> +	fsnotify_sb_error(sb, NULL, errno);
>  
>  	ext4_handle_error(sb, false, -errno, 0, 0, function, line);
>  }
> -- 
> 2.33.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
