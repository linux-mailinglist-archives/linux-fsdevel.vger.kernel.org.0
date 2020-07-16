Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2874E22239E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Jul 2020 15:13:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727044AbgGPNNM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 Jul 2020 09:13:12 -0400
Received: from mx2.suse.de ([195.135.220.15]:53540 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726537AbgGPNNM (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 Jul 2020 09:13:12 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 43E51B942;
        Thu, 16 Jul 2020 13:13:15 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 3CB6F1E12C9; Thu, 16 Jul 2020 15:13:11 +0200 (CEST)
Date:   Thu, 16 Jul 2020 15:13:11 +0200
From:   Jan Kara <jack@suse.cz>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v5 16/22] fsnotify: remove check that source dentry is
 positive
Message-ID: <20200716131311.GC5022@quack2.suse.cz>
References: <20200716084230.30611-1-amir73il@gmail.com>
 <20200716084230.30611-17-amir73il@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200716084230.30611-17-amir73il@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 16-07-20 11:42:24, Amir Goldstein wrote:
> Remove the unneeded check for positive source dentry in
> fsnotify_move().
> 
> fsnotify_move() hook is mostly called from vfs_rename() under
> lock_rename() and vfs_rename() starts with may_delete() test that
> verifies positive source dentry.  The only other caller of
> fsnotify_move() - debugfs_rename() also verifies positive source.
> 
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>

But in vfs_rename() if RENAME_EXCHANGE is set and target is NULL,
new_dentry can be negative when calling fsnotify_move() AFAICT, cannot it?

								Honza

> ---
>  include/linux/fsnotify.h | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/include/linux/fsnotify.h b/include/linux/fsnotify.h
> index 044cae3a0628..fe4f2bc5b4c2 100644
> --- a/include/linux/fsnotify.h
> +++ b/include/linux/fsnotify.h
> @@ -149,8 +149,7 @@ static inline void fsnotify_move(struct inode *old_dir, struct inode *new_dir,
>  	if (target)
>  		fsnotify_link_count(target);
>  
> -	if (source)
> -		fsnotify(source, mask, source, FSNOTIFY_EVENT_INODE, NULL, 0);
> +	fsnotify(source, mask, source, FSNOTIFY_EVENT_INODE, NULL, 0);
>  	audit_inode_child(new_dir, moved, AUDIT_TYPE_CHILD_CREATE);
>  }
>  
> -- 
> 2.17.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
