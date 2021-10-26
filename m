Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF57543B212
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Oct 2021 14:12:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235737AbhJZMPS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 26 Oct 2021 08:15:18 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:53016 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235703AbhJZMPQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 26 Oct 2021 08:15:16 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 48B3F1FD42;
        Tue, 26 Oct 2021 12:12:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1635250370; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5/W9nOOsVTKQPhGN/XxpI9Zuf07W5qKbbBlUiMBNdQw=;
        b=LBfuNmf8ylGMPMayW/ASdhAYLEL8UmFxTpwj5KNKhkqDUe2iaCFCfxp01Ph6l3XDC6/old
        QuWpKdGUJzVoa73P2SUxm/UqiaTNrVpnp/A8L1YkZDkbfW5pM3q9Zf7JvA4EH+RsyfOpYx
        SV4UnxHNvPUw0hExVlhTVPPQ6d4hqVI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1635250370;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5/W9nOOsVTKQPhGN/XxpI9Zuf07W5qKbbBlUiMBNdQw=;
        b=ifSJD/Ziia9owo/XuZOPXsyn6Ee2C3EXCDnY6bdFjcvb+juQd0jQJvpq22qpWV5IcZbMwM
        EtGx7/GVMJWkG7Bg==
Received: from quack2.suse.cz (unknown [10.100.224.230])
        by relay2.suse.de (Postfix) with ESMTP id 32B02A3B81;
        Tue, 26 Oct 2021 12:12:50 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 08BD91F2C66; Tue, 26 Oct 2021 14:12:50 +0200 (CEST)
Date:   Tue, 26 Oct 2021 14:12:50 +0200
From:   Jan Kara <jack@suse.cz>
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     amir73il@gmail.com, jack@suse.com, djwong@kernel.org,
        tytso@mit.edu, david@fromorbit.com, dhowells@redhat.com,
        khazhy@google.com, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org, linux-ext4@vger.kernel.org,
        kernel@collabora.com
Subject: Re: [PATCH v9 29/31] ext4: Send notifications on error
Message-ID: <20211026121250.GF21228@quack2.suse.cz>
References: <20211025192746.66445-1-krisman@collabora.com>
 <20211025192746.66445-30-krisman@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211025192746.66445-30-krisman@collabora.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon 25-10-21 16:27:44, Gabriel Krisman Bertazi wrote:
> Send a FS_ERROR message via fsnotify to a userspace monitoring tool
> whenever a ext4 error condition is triggered.  This follows the existing
> error conditions in ext4, so it is hooked to the ext4_error* functions.
> 
> Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
> Changes since v8:
>   - Report always report non-zero errno (Jan, Amir, Ted)
> Changes since v6:
>   - Report ext4_std_errors agains superblock (jan)
> ---
>  fs/ext4/super.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> index 88d5d274a868..1a766c68a55e 100644
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
> +	fsnotify_sb_error(sb, NULL, error ? error : EFSCORRUPTED);
> +
>  	ext4_handle_error(sb, force_ro, error, 0, block, function, line);
>  }
>  
> @@ -789,6 +792,8 @@ void __ext4_error_inode(struct inode *inode, const char *function,
>  			       current->comm, &vaf);
>  		va_end(args);
>  	}
> +	fsnotify_sb_error(inode->i_sb, inode, error ? error : EFSCORRUPTED);
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
> +	fsnotify_sb_error(sb, NULL, errno ? errno : EFSCORRUPTED);
>  
>  	ext4_handle_error(sb, false, -errno, 0, 0, function, line);
>  }
> -- 
> 2.33.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
