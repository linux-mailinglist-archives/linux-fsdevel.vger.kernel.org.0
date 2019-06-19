Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 17C314B928
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Jun 2019 14:53:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731834AbfFSMxs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 19 Jun 2019 08:53:48 -0400
Received: from mx2.suse.de ([195.135.220.15]:55420 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731576AbfFSMxs (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 19 Jun 2019 08:53:48 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 625EBAFAC;
        Wed, 19 Jun 2019 12:53:46 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 031551E434D; Wed, 19 Jun 2019 14:53:46 +0200 (CEST)
Date:   Wed, 19 Jun 2019 14:53:45 +0200
From:   Jan Kara <jack@suse.cz>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jan Kara <jack@suse.cz>,
        Matthew Bobrowski <mbobrowski@mbobrowski.org>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] fanotify: update connector fsid cache on add mark
Message-ID: <20190619125345.GG27954@quack2.suse.cz>
References: <20190619103444.26899-1-amir73il@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190619103444.26899-1-amir73il@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 19-06-19 13:34:44, Amir Goldstein wrote:
> When implementing connector fsid cache, we only initialized the cache
> when the first mark added to object was added by FAN_REPORT_FID group.
> We forgot to update conn->fsid when the second mark is added by
> FAN_REPORT_FID group to an already attached connector without fsid
> cache.
> 
> Reported-and-tested-by: syzbot+c277e8e2f46414645508@syzkaller.appspotmail.com
> Fixes: 77115225acc6 ("fanotify: cache fsid in fsnotify_mark_connector")
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> ---
> 
> Jan,
> 
> This fix has been confirmed by syzbot to fix the issue as well as
> by my modification to Matthew's LTP test:
> https://github.com/amir73il/ltp/commits/fanotify_dirent

Thanks for the fix Amir. I somewhat don't like the additional flags field
(which ends up growing fsnotify_mark_connector by one long) for just that
one special flag. If nothing else, can't we just store the flag inside
'type'? There's plenty of space there...

								Honza
> 
> Thanks,
> Amir.
> 
>  fs/notify/fanotify/fanotify.c    |  4 ++++
>  fs/notify/mark.c                 | 14 +++++++++++---
>  include/linux/fsnotify_backend.h |  2 ++
>  3 files changed, 17 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotify.c
> index e6fde1a5c072..b428c295d13f 100644
> --- a/fs/notify/fanotify/fanotify.c
> +++ b/fs/notify/fanotify/fanotify.c
> @@ -355,6 +355,10 @@ static __kernel_fsid_t fanotify_get_fsid(struct fsnotify_iter_info *iter_info)
>  		/* Mark is just getting destroyed or created? */
>  		if (!conn)
>  			continue;
> +		if (!(conn->flags & FSNOTIFY_CONN_FLAG_HAS_FSID))
> +			continue;
> +		/* Pairs with smp_wmb() in fsnotify_add_mark_list() */
> +		smp_rmb();
>  		fsid = conn->fsid;
>  		if (WARN_ON_ONCE(!fsid.val[0] && !fsid.val[1]))
>  			continue;
> diff --git a/fs/notify/mark.c b/fs/notify/mark.c
> index 25eb247ea85a..99ddd126f6f0 100644
> --- a/fs/notify/mark.c
> +++ b/fs/notify/mark.c
> @@ -482,10 +482,13 @@ static int fsnotify_attach_connector_to_object(fsnotify_connp_t *connp,
>  	conn->type = type;
>  	conn->obj = connp;
>  	/* Cache fsid of filesystem containing the object */
> -	if (fsid)
> +	if (fsid) {
>  		conn->fsid = *fsid;
> -	else
> +		conn->flags = FSNOTIFY_CONN_FLAG_HAS_FSID;
> +	} else {
>  		conn->fsid.val[0] = conn->fsid.val[1] = 0;
> +		conn->flags = 0;
> +	}
>  	if (conn->type == FSNOTIFY_OBJ_TYPE_INODE)
>  		inode = igrab(fsnotify_conn_inode(conn));
>  	/*
> @@ -560,7 +563,12 @@ static int fsnotify_add_mark_list(struct fsnotify_mark *mark,
>  		if (err)
>  			return err;
>  		goto restart;
> -	} else if (fsid && (conn->fsid.val[0] || conn->fsid.val[1]) &&
> +	} else if (fsid && !(conn->flags & FSNOTIFY_CONN_FLAG_HAS_FSID)) {
> +		conn->fsid = *fsid;
> +		/* Pairs with smp_rmb() in fanotify_get_fsid() */
> +		smp_wmb();
> +		conn->flags |= FSNOTIFY_CONN_FLAG_HAS_FSID;
> +	} else if (fsid && (conn->flags & FSNOTIFY_CONN_FLAG_HAS_FSID) &&
>  		   (fsid->val[0] != conn->fsid.val[0] ||
>  		    fsid->val[1] != conn->fsid.val[1])) {
>  		/*
> diff --git a/include/linux/fsnotify_backend.h b/include/linux/fsnotify_backend.h
> index a9f9dcc1e515..da181dc05261 100644
> --- a/include/linux/fsnotify_backend.h
> +++ b/include/linux/fsnotify_backend.h
> @@ -293,6 +293,8 @@ typedef struct fsnotify_mark_connector __rcu *fsnotify_connp_t;
>  struct fsnotify_mark_connector {
>  	spinlock_t lock;
>  	unsigned int type;	/* Type of object [lock] */
> +#define FSNOTIFY_CONN_FLAG_HAS_FSID	0x01
> +	unsigned int flags;	/* flags [lock] */
>  	__kernel_fsid_t fsid;	/* fsid of filesystem containing object */
>  	union {
>  		/* Object pointer [lock] */
> -- 
> 2.17.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
