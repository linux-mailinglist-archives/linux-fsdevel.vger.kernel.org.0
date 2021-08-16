Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A28283ED65F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Aug 2021 15:22:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239277AbhHPNUj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 16 Aug 2021 09:20:39 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:46248 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240169AbhHPNTZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 16 Aug 2021 09:19:25 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id DE8661FE6F;
        Mon, 16 Aug 2021 13:18:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1629119930; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BoAMWR7Ykja6Ogd0JcusUgpGDWD9ocMKTw5LjQGWy2o=;
        b=U07WEFV5WbFuiBMtzYN+0zbeUCZKPSxQ68FlCXrHaRThrT9psHB+OMHk8kRMQneUfh64X1
        x3ztIrIS5fA668nzwjiJKuCs0btxRr3vBfKCQev8vgV6spN0DdH4xDqgj4bx0ue2b1kWZC
        6UkJ3ZAg3FEohynwKKO9IL0AH9spynI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1629119930;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BoAMWR7Ykja6Ogd0JcusUgpGDWD9ocMKTw5LjQGWy2o=;
        b=5nXqkKhrz+jDwSLrtyizBs8KDrcSNzrLaD/eXVCGsM65+4ugX9H1lmCN9nNRH1pjt0RS7M
        451ECAor4w+l5+DA==
Received: from quack2.suse.cz (unknown [10.100.224.230])
        by relay2.suse.de (Postfix) with ESMTP id CC6E8A3B94;
        Mon, 16 Aug 2021 13:18:50 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id B4FFF1E0426; Mon, 16 Aug 2021 15:18:50 +0200 (CEST)
Date:   Mon, 16 Aug 2021 15:18:50 +0200
From:   Jan Kara <jack@suse.cz>
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     amir73il@gmail.com, jack@suse.com, linux-api@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        khazhy@google.com, dhowells@redhat.com, david@fromorbit.com,
        tytso@mit.edu, djwong@kernel.org, repnop@google.com,
        kernel@collabora.com
Subject: Re: [PATCH v6 05/21] fanotify: Split superblock marks out to a new
 cache
Message-ID: <20210816131850.GC30215@quack2.suse.cz>
References: <20210812214010.3197279-1-krisman@collabora.com>
 <20210812214010.3197279-6-krisman@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210812214010.3197279-6-krisman@collabora.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 12-08-21 17:39:54, Gabriel Krisman Bertazi wrote:
> FAN_FS_ERROR will require an error structure to be stored per mark.
> But, since FAN_FS_ERROR doesn't apply to inode/mount marks, it should
> suffice to only expose this information for superblock marks. Therefore,
> wrap this kind of marks into a container and plumb it for the future.
> 
> Reviewed-by: Amir Goldstein <amir73il@gmail.com>
> Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
> Changes since v5:
>   - turn the flag bits into defines (jan)
>   - don't use zalloc for consistency (jan)
> Changes since v2:
>   - Move mark initialization to fanotify_alloc_mark (Amir)
> 
> Changes since v1:
>   - Only extend superblock marks (Amir)
> ---
>  fs/notify/fanotify/fanotify.c      | 10 ++++++--
>  fs/notify/fanotify/fanotify.h      | 20 ++++++++++++++++
>  fs/notify/fanotify/fanotify_user.c | 38 ++++++++++++++++++++++++++++--
>  3 files changed, 64 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotify.c
> index 310246f8d3f1..c3eefe3f6494 100644
> --- a/fs/notify/fanotify/fanotify.c
> +++ b/fs/notify/fanotify/fanotify.c
> @@ -869,9 +869,15 @@ static void fanotify_freeing_mark(struct fsnotify_mark *mark,
>  		dec_ucount(group->fanotify_data.ucounts, UCOUNT_FANOTIFY_MARKS);
>  }
>  
> -static void fanotify_free_mark(struct fsnotify_mark *fsn_mark)
> +static void fanotify_free_mark(struct fsnotify_mark *mark)
>  {
> -	kmem_cache_free(fanotify_mark_cache, fsn_mark);
> +	if (mark->flags & FANOTIFY_MARK_FLAG_SB_MARK) {
> +		struct fanotify_sb_mark *fa_mark = FANOTIFY_SB_MARK(mark);
> +
> +		kmem_cache_free(fanotify_sb_mark_cache, fa_mark);
> +	} else {
> +		kmem_cache_free(fanotify_mark_cache, mark);
> +	}
>  }
>  
>  const struct fsnotify_ops fanotify_fsnotify_ops = {
> diff --git a/fs/notify/fanotify/fanotify.h b/fs/notify/fanotify/fanotify.h
> index 4a5e555dc3d2..3b11dd03df59 100644
> --- a/fs/notify/fanotify/fanotify.h
> +++ b/fs/notify/fanotify/fanotify.h
> @@ -6,6 +6,7 @@
>  #include <linux/hashtable.h>
>  
>  extern struct kmem_cache *fanotify_mark_cache;
> +extern struct kmem_cache *fanotify_sb_mark_cache;
>  extern struct kmem_cache *fanotify_fid_event_cachep;
>  extern struct kmem_cache *fanotify_path_event_cachep;
>  extern struct kmem_cache *fanotify_perm_event_cachep;
> @@ -129,6 +130,25 @@ static inline void fanotify_info_copy_name(struct fanotify_info *info,
>  	       name->name);
>  }
>  
> +enum fanotify_mark_bits {
> +	FANOTIFY_MARK_FLAG_BIT_SB_MARK = FSN_MARK_PRIVATE_FLAGS,
> +};
> +
> +#define FANOTIFY_MARK_FLAG_SB_MARK \
> +	(1 << FANOTIFY_MARK_FLAG_BIT_SB_MARK)
> +
> +struct fanotify_sb_mark {
> +	struct fsnotify_mark fsn_mark;
> +};
> +
> +static inline
> +struct fanotify_sb_mark *FANOTIFY_SB_MARK(struct fsnotify_mark *mark)
> +{
> +	WARN_ON(!(mark->flags & FANOTIFY_MARK_FLAG_SB_MARK));
> +
> +	return container_of(mark, struct fanotify_sb_mark, fsn_mark);
> +}
> +
>  /*
>   * Common structure for fanotify events. Concrete structs are allocated in
>   * fanotify_handle_event() and freed when the information is retrieved by
> diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
> index 67b18dfe0025..c47a5a45c0d3 100644
> --- a/fs/notify/fanotify/fanotify_user.c
> +++ b/fs/notify/fanotify/fanotify_user.c
> @@ -99,6 +99,7 @@ struct ctl_table fanotify_table[] = {
>  extern const struct fsnotify_ops fanotify_fsnotify_ops;
>  
>  struct kmem_cache *fanotify_mark_cache __read_mostly;
> +struct kmem_cache *fanotify_sb_mark_cache __read_mostly;
>  struct kmem_cache *fanotify_fid_event_cachep __read_mostly;
>  struct kmem_cache *fanotify_path_event_cachep __read_mostly;
>  struct kmem_cache *fanotify_perm_event_cachep __read_mostly;
> @@ -915,6 +916,38 @@ static __u32 fanotify_mark_add_to_mask(struct fsnotify_mark *fsn_mark,
>  	return mask & ~oldmask;
>  }
>  
> +static struct fsnotify_mark *fanotify_alloc_mark(struct fsnotify_group *group,
> +						 unsigned int type)
> +{
> +	struct fanotify_sb_mark *sb_mark;
> +	struct fsnotify_mark *mark;
> +
> +	switch (type) {
> +	case FSNOTIFY_OBJ_TYPE_SB:
> +		sb_mark = kmem_cache_alloc(fanotify_sb_mark_cache, GFP_KERNEL);
> +		if (!sb_mark)
> +			return NULL;
> +		mark = &sb_mark->fsn_mark;
> +		break;
> +
> +	case FSNOTIFY_OBJ_TYPE_INODE:
> +	case FSNOTIFY_OBJ_TYPE_PARENT:
> +	case FSNOTIFY_OBJ_TYPE_VFSMOUNT:
> +		mark = kmem_cache_alloc(fanotify_mark_cache, GFP_KERNEL);
> +		break;
> +	default:
> +		WARN_ON(1);
> +		return NULL;
> +	}
> +
> +	fsnotify_init_mark(mark, group);
> +
> +	if (type == FSNOTIFY_OBJ_TYPE_SB)
> +		mark->flags |= FANOTIFY_MARK_FLAG_SB_MARK;
> +
> +	return mark;
> +}
> +
>  static struct fsnotify_mark *fanotify_add_new_mark(struct fsnotify_group *group,
>  						   fsnotify_connp_t *connp,
>  						   unsigned int type,
> @@ -933,13 +966,12 @@ static struct fsnotify_mark *fanotify_add_new_mark(struct fsnotify_group *group,
>  	    !inc_ucount(ucounts->ns, ucounts->uid, UCOUNT_FANOTIFY_MARKS))
>  		return ERR_PTR(-ENOSPC);
>  
> -	mark = kmem_cache_alloc(fanotify_mark_cache, GFP_KERNEL);
> +	mark = fanotify_alloc_mark(group, type);
>  	if (!mark) {
>  		ret = -ENOMEM;
>  		goto out_dec_ucounts;
>  	}
>  
> -	fsnotify_init_mark(mark, group);
>  	ret = fsnotify_add_mark_locked(mark, connp, type, 0, fsid);
>  	if (ret) {
>  		fsnotify_put_mark(mark);
> @@ -1497,6 +1529,8 @@ static int __init fanotify_user_setup(void)
>  
>  	fanotify_mark_cache = KMEM_CACHE(fsnotify_mark,
>  					 SLAB_PANIC|SLAB_ACCOUNT);
> +	fanotify_sb_mark_cache = KMEM_CACHE(fanotify_sb_mark,
> +					    SLAB_PANIC|SLAB_ACCOUNT);
>  	fanotify_fid_event_cachep = KMEM_CACHE(fanotify_fid_event,
>  					       SLAB_PANIC);
>  	fanotify_path_event_cachep = KMEM_CACHE(fanotify_path_event,
> -- 
> 2.32.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
