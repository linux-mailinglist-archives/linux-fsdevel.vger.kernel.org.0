Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C1AB3BF0A7
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Jul 2021 22:13:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232084AbhGGUPw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 7 Jul 2021 16:15:52 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:57272 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230296AbhGGUPv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 7 Jul 2021 16:15:51 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 5343F20100;
        Wed,  7 Jul 2021 20:13:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1625688790; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bMwnEsl4C2ufPU4ty9GwyaABUtNiqe36rXYwHKdmRww=;
        b=IpSW4wAVUg1Z8/zFhouzhGDoGt0vmvnTo4yHVLzyDmiwFWPjfb1B4RHLGXkcqbC0AhgDJq
        93Ez/nFa7MSkfe31R4b1eiBMlkrkQ3y8t4jjHLPXGmQlG/ylYpUQAbd4LV2uK/Eh7J5t/O
        CZ4DeJJXTsUu1umFa7jzyqLm9SlV+eg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1625688790;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bMwnEsl4C2ufPU4ty9GwyaABUtNiqe36rXYwHKdmRww=;
        b=fAXkfcIbl1KfcpIbVDIvauPFcscAvR1vTqodBZjZAAqDyWEetlscxOuhTcnTLosgTL/HnO
        kBJ3nj1M35adHdCA==
Received: from quack2.suse.cz (unknown [10.163.43.118])
        by relay2.suse.de (Postfix) with ESMTP id 3BA52A3BA0;
        Wed,  7 Jul 2021 20:13:10 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 0F9041F2CD7; Wed,  7 Jul 2021 22:13:10 +0200 (CEST)
Date:   Wed, 7 Jul 2021 22:13:10 +0200
From:   Jan Kara <jack@suse.cz>
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     amir73il@gmail.com, djwong@kernel.org, tytso@mit.edu,
        david@fromorbit.com, jack@suse.com, dhowells@redhat.com,
        khazhy@google.com, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, kernel@collabora.com
Subject: Re: [PATCH v3 04/15] fanotify: Split superblock marks out to a new
 cache
Message-ID: <20210707201310.GG18396@quack2.suse.cz>
References: <20210629191035.681913-1-krisman@collabora.com>
 <20210629191035.681913-5-krisman@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210629191035.681913-5-krisman@collabora.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue 29-06-21 15:10:24, Gabriel Krisman Bertazi wrote:
> FAN_ERROR will require an error structure to be stored per mark.  But,
> since FAN_ERROR doesn't apply to inode/mount marks, it should suffice to
> only expose this information for superblock marks. Therefore, wrap this
> kind of marks into a container and plumb it for the future.
> 
> Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>

...

> -static void fanotify_free_mark(struct fsnotify_mark *fsn_mark)
> +static void fanotify_free_mark(struct fsnotify_mark *mark)
>  {
> -	kmem_cache_free(fanotify_mark_cache, fsn_mark);
> +	if (mark->flags & FSNOTIFY_MARK_FLAG_SB) {
> +		struct fanotify_sb_mark *fa_mark = FANOTIFY_SB_MARK(mark);
> +
> +		kmem_cache_free(fanotify_sb_mark_cache, fa_mark);
> +	} else {
> +		kmem_cache_free(fanotify_mark_cache, mark);
> +	}
>  }

Frankly, I find using mark->flags for fanotify internal distinction of mark
type somewhat ugly. Even more so because fsnotify_put_mark() could infer
the mark type information from mark->conn->type and pass it to the freeing
function. But the passing would be somewhat non-trivial so probably we can
leave that for some other day. But the fact that FSNOTIFY_MARK_FLAG_SB is
set inside fsnotify-backend specific code is a landmine waiting just for
another backend to start supporting sb marks, not set
FSNOTIFY_MARK_FLAG_SB, and some generic code depend on checking
FSNOTIFY_MARK_FLAG_SB instead of mark->conn->type.

So I see two sensible solutions:

a) Just admit this is fanotify private flag, carve out some flags from
mark->flags as backend private and have FANOTIFY_MARK_FLAG_SB in that space
(e.g. look how include/linux/buffer_head.h has flags upto BH_PrivateStart,
then e.g. include/linux/jbd2.h starts its flags from BH_PrivateStart
further).

b) Make a rule that mark connector type is also stored in mark->flags. We
have plenty of space there so why not. Then fsnotify_add_mark_locked() has
to store type into the flags.

Pick your poison :)

								Honza

>  const struct fsnotify_ops fanotify_fsnotify_ops = {
> diff --git a/fs/notify/fanotify/fanotify.h b/fs/notify/fanotify/fanotify.h
> index 4a5e555dc3d2..fd125a949187 100644
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
> @@ -129,6 +130,18 @@ static inline void fanotify_info_copy_name(struct fanotify_info *info,
>  	       name->name);
>  }
>  
> +struct fanotify_sb_mark {
> +	struct fsnotify_mark fsn_mark;
> +};
> +
> +static inline
> +struct fanotify_sb_mark *FANOTIFY_SB_MARK(struct fsnotify_mark *mark)
> +{
> +	WARN_ON(!(mark->flags & FSNOTIFY_MARK_FLAG_SB));
> +
> +	return container_of(mark, struct fanotify_sb_mark, fsn_mark);
> +}
> +
>  /*
>   * Common structure for fanotify events. Concrete structs are allocated in
>   * fanotify_handle_event() and freed when the information is retrieved by
> diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
> index 67b18dfe0025..a42521e140e6 100644
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
> +		sb_mark = kmem_cache_zalloc(fanotify_sb_mark_cache, GFP_KERNEL);
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
> +		mark->flags |= FSNOTIFY_MARK_FLAG_SB;
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
> diff --git a/include/linux/fsnotify_backend.h b/include/linux/fsnotify_backend.h
> index 1ce66748a2d2..c4473b467c28 100644
> --- a/include/linux/fsnotify_backend.h
> +++ b/include/linux/fsnotify_backend.h
> @@ -401,6 +401,7 @@ struct fsnotify_mark {
>  #define FSNOTIFY_MARK_FLAG_IGNORED_SURV_MODIFY	0x01
>  #define FSNOTIFY_MARK_FLAG_ALIVE		0x02
>  #define FSNOTIFY_MARK_FLAG_ATTACHED		0x04
> +#define FSNOTIFY_MARK_FLAG_SB			0x08
>  	unsigned int flags;		/* flags [mark->lock] */
>  };
>  
> -- 
> 2.32.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
