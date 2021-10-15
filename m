Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 508C342ED6F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Oct 2021 11:18:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237236AbhJOJUm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 Oct 2021 05:20:42 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:58012 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236454AbhJOJUm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 Oct 2021 05:20:42 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id D17221F770;
        Fri, 15 Oct 2021 09:18:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1634289514; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jkqjzEwNHSECoBlQtoTSwpYhMOm5xCv5JA0JJwmOt+4=;
        b=OI4UzSsvSjSmzyeQjJG1a63SVjVuRDWggn21yfu6Svsv+kl1zXLOBs0ni+mStWHTkecTYO
        dTt5XVm1fgUucLT2Lm5sHVB7l0fhPZ464+FqOa50ZqOhsvfXWBzbq+W5r68l/rYAL8scfs
        21R6WykG02lCiuijuZg8ic65Z4SRI08=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1634289514;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jkqjzEwNHSECoBlQtoTSwpYhMOm5xCv5JA0JJwmOt+4=;
        b=poWKAGXgSuT4jetl0EiizaHCY4q9eF7RzDWUIhl6ge7GnjftG2SBDHU3YGlNDNSPWR5k6s
        IH26HWwmbjY0sHDw==
Received: from quack2.suse.cz (unknown [10.100.200.198])
        by relay2.suse.de (Postfix) with ESMTP id C1949A3B84;
        Fri, 15 Oct 2021 09:18:34 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id A40E91E0A40; Fri, 15 Oct 2021 11:18:34 +0200 (CEST)
Date:   Fri, 15 Oct 2021 11:18:34 +0200
From:   Jan Kara <jack@suse.cz>
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     jack@suse.com, amir73il@gmail.com, djwong@kernel.org,
        tytso@mit.edu, dhowells@redhat.com, khazhy@google.com,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-api@vger.kernel.org, repnop@google.com, kernel@collabora.com
Subject: Re: [PATCH v7 01/28] fsnotify: pass data_type to fsnotify_name()
Message-ID: <20211015091834.GB23102@quack2.suse.cz>
References: <20211014213646.1139469-1-krisman@collabora.com>
 <20211014213646.1139469-2-krisman@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211014213646.1139469-2-krisman@collabora.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 14-10-21 18:36:19, Gabriel Krisman Bertazi wrote:
> From: Amir Goldstein <amir73il@gmail.com>
> 
> Align the arguments of fsnotify_name() to those of fsnotify().
> 
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  include/linux/fsnotify.h | 22 +++++++++++++---------
>  1 file changed, 13 insertions(+), 9 deletions(-)
> 
> diff --git a/include/linux/fsnotify.h b/include/linux/fsnotify.h
> index 12d3a7d308ab..d1144d7c3536 100644
> --- a/include/linux/fsnotify.h
> +++ b/include/linux/fsnotify.h
> @@ -26,20 +26,21 @@
>   * FS_EVENT_ON_CHILD mask on the parent inode and will not be reported if only
>   * the child is interested and not the parent.
>   */
> -static inline void fsnotify_name(struct inode *dir, __u32 mask,
> -				 struct inode *child,
> -				 const struct qstr *name, u32 cookie)
> +static inline int fsnotify_name(__u32 mask, const void *data, int data_type,
> +				struct inode *dir, const struct qstr *name,
> +				u32 cookie)
>  {
>  	if (atomic_long_read(&dir->i_sb->s_fsnotify_connectors) == 0)
> -		return;
> +		return 0;
>  
> -	fsnotify(mask, child, FSNOTIFY_EVENT_INODE, dir, name, NULL, cookie);
> +	return fsnotify(mask, data, data_type, dir, name, NULL, cookie);
>  }
>  
>  static inline void fsnotify_dirent(struct inode *dir, struct dentry *dentry,
>  				   __u32 mask)
>  {
> -	fsnotify_name(dir, mask, d_inode(dentry), &dentry->d_name, 0);
> +	fsnotify_name(mask, d_inode(dentry), FSNOTIFY_EVENT_INODE,
> +		      dir, &dentry->d_name, 0);
>  }
>  
>  static inline void fsnotify_inode(struct inode *inode, __u32 mask)
> @@ -154,8 +155,10 @@ static inline void fsnotify_move(struct inode *old_dir, struct inode *new_dir,
>  		new_dir_mask |= FS_ISDIR;
>  	}
>  
> -	fsnotify_name(old_dir, old_dir_mask, source, old_name, fs_cookie);
> -	fsnotify_name(new_dir, new_dir_mask, source, new_name, fs_cookie);
> +	fsnotify_name(old_dir_mask, source, FSNOTIFY_EVENT_INODE,
> +		      old_dir, old_name, fs_cookie);
> +	fsnotify_name(new_dir_mask, source, FSNOTIFY_EVENT_INODE,
> +		      new_dir, new_name, fs_cookie);
>  
>  	if (target)
>  		fsnotify_link_count(target);
> @@ -209,7 +212,8 @@ static inline void fsnotify_link(struct inode *dir, struct inode *inode,
>  	fsnotify_link_count(inode);
>  	audit_inode_child(dir, new_dentry, AUDIT_TYPE_CHILD_CREATE);
>  
> -	fsnotify_name(dir, FS_CREATE, inode, &new_dentry->d_name, 0);
> +	fsnotify_name(FS_CREATE, inode, FSNOTIFY_EVENT_INODE,
> +		      dir, &new_dentry->d_name, 0);
>  }
>  
>  /*
> -- 
> 2.33.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
