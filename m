Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EC72816F97E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Feb 2020 09:21:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727335AbgBZIVB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 Feb 2020 03:21:01 -0500
Received: from mx2.suse.de ([195.135.220.15]:57058 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727311AbgBZIVA (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 Feb 2020 03:21:00 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id EC3A0B1AB;
        Wed, 26 Feb 2020 08:20:58 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 9C73D1E0EA2; Wed, 26 Feb 2020 09:20:58 +0100 (CET)
Date:   Wed, 26 Feb 2020 09:20:58 +0100
From:   Jan Kara <jack@suse.cz>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 07/16] fsnotify: replace inode pointer with tag
Message-ID: <20200226082058.GB10728@quack2.suse.cz>
References: <20200217131455.31107-1-amir73il@gmail.com>
 <20200217131455.31107-8-amir73il@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200217131455.31107-8-amir73il@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon 17-02-20 15:14:46, Amir Goldstein wrote:
> The event inode field is used only for comparison in queue merges and
> cannot be dereferenced after handle_event(), because it does not hold a
> refcount on the inode.
> 
> Replace it with an abstract tag do to the same thing. We are going to
> set this tag for values other than inode pointer in fanotify.
> 
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>

I like this but can we call it say 'objectid' or something like that? 'tag'
seems too generic to me and it isn't clear why we should merge or not merge
events with different tags...

								Honza

> ---
>  fs/notify/fanotify/fanotify.c        | 2 +-
>  fs/notify/inotify/inotify_fsnotify.c | 2 +-
>  include/linux/fsnotify_backend.h     | 8 +++-----
>  3 files changed, 5 insertions(+), 7 deletions(-)
> 
> diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotify.c
> index 19ec7a4f4d50..98c3cbf29003 100644
> --- a/fs/notify/fanotify/fanotify.c
> +++ b/fs/notify/fanotify/fanotify.c
> @@ -26,7 +26,7 @@ static bool should_merge(struct fsnotify_event *old_fsn,
>  	old = FANOTIFY_E(old_fsn);
>  	new = FANOTIFY_E(new_fsn);
>  
> -	if (old_fsn->inode != new_fsn->inode || old->pid != new->pid ||
> +	if (old_fsn->tag != new_fsn->tag || old->pid != new->pid ||
>  	    old->fh_type != new->fh_type || old->fh_len != new->fh_len)
>  		return false;
>  
> diff --git a/fs/notify/inotify/inotify_fsnotify.c b/fs/notify/inotify/inotify_fsnotify.c
> index 6bb98522bbfd..4f42ea7b7fdd 100644
> --- a/fs/notify/inotify/inotify_fsnotify.c
> +++ b/fs/notify/inotify/inotify_fsnotify.c
> @@ -39,7 +39,7 @@ static bool event_compare(struct fsnotify_event *old_fsn,
>  	if (old->mask & FS_IN_IGNORED)
>  		return false;
>  	if ((old->mask == new->mask) &&
> -	    (old_fsn->inode == new_fsn->inode) &&
> +	    (old_fsn->tag == new_fsn->tag) &&
>  	    (old->name_len == new->name_len) &&
>  	    (!old->name_len || !strcmp(old->name, new->name)))
>  		return true;
> diff --git a/include/linux/fsnotify_backend.h b/include/linux/fsnotify_backend.h
> index bd3f6114a7a9..cd106b5c87a4 100644
> --- a/include/linux/fsnotify_backend.h
> +++ b/include/linux/fsnotify_backend.h
> @@ -132,8 +132,7 @@ struct fsnotify_ops {
>   */
>  struct fsnotify_event {
>  	struct list_head list;
> -	/* inode may ONLY be dereferenced during handle_event(). */
> -	struct inode *inode;	/* either the inode the event happened to or its parent */
> +	unsigned long tag;	/* identifier for queue merges */
>  };
>  
>  /*
> @@ -542,11 +541,10 @@ extern void fsnotify_put_mark(struct fsnotify_mark *mark);
>  extern void fsnotify_finish_user_wait(struct fsnotify_iter_info *iter_info);
>  extern bool fsnotify_prepare_user_wait(struct fsnotify_iter_info *iter_info);
>  
> -static inline void fsnotify_init_event(struct fsnotify_event *event,
> -				       struct inode *inode)
> +static inline void fsnotify_init_event(struct fsnotify_event *event, void *tag)
>  {
>  	INIT_LIST_HEAD(&event->list);
> -	event->inode = inode;
> +	event->tag = (unsigned long)tag;
>  }
>  
>  #else
> -- 
> 2.17.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
