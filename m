Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 893C64FBC8C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Apr 2022 14:54:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346277AbiDKM4P (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 11 Apr 2022 08:56:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346253AbiDKM4J (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 11 Apr 2022 08:56:09 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 905A733E2C
        for <linux-fsdevel@vger.kernel.org>; Mon, 11 Apr 2022 05:53:55 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 4BD591F7AC;
        Mon, 11 Apr 2022 12:53:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1649681634; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8JJlGSOBt7ZElNo/nf3IbYOKlDlbapdFtMYgZI9Fk6g=;
        b=HQVW/Uo6Zfe75jOGrow+HBM0ZJZoPL+W6vVHk4kmgma7DEU0XM9nq4u+MiTKYNai9+dBnc
        42+o8fONUFRTtzhDx7KTw/6inLQJxDitq7XYXLI6oDttwCwf6Dccj3VAB68CRt70pbiDIC
        1Fl3Ajhkk2XuMkc/earK1aSM/ejvpnk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1649681634;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8JJlGSOBt7ZElNo/nf3IbYOKlDlbapdFtMYgZI9Fk6g=;
        b=JzNtxtnrIQO3JMjLISHx2I5OyAtqpYf2ZLyb/Ol0jaAtav+lVaw99RNbEXCNYmvU7MQQPM
        9THS+V/v2YbGWZCQ==
Received: from quack3.suse.cz (unknown [10.163.28.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 0EDF9A3B89;
        Mon, 11 Apr 2022 12:53:54 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 94FE4A061B; Mon, 11 Apr 2022 14:53:53 +0200 (CEST)
Date:   Mon, 11 Apr 2022 14:53:53 +0200
From:   Jan Kara <jack@suse.cz>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jan Kara <jack@suse.cz>,
        Matthew Bobrowski <mbobrowski@mbobrowski.org>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 14/16] fanotify: add FAN_IOC_SET_MARK_PAGE_ORDER ioctl
 for testing
Message-ID: <20220411125353.o2psnjccrqwcmhuw@quack3.lan>
References: <20220329074904.2980320-1-amir73il@gmail.com>
 <20220329074904.2980320-15-amir73il@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220329074904.2980320-15-amir73il@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue 29-03-22 10:49:02, Amir Goldstein wrote:
> The ioctl can be used to request allocation of marks with large size
> and attach them to an object, even if another mark already exists for
> the group on the marked object.
> 
> These large marks serve no function other than testing direct reclaim
> in the context of mark allocation.
> 
> Setting the value to 0 restores normal mark allocation.
> 
> FAN_MARK_REMOVE refers to the first mark of the group on an object, so
> the number of FAN_MARK_REMOVE calls need to match the number of large
> marks on the object in order to remove all marks from the object or use
> FAN_MARK_FLUSH to remove all marks of that object type.
> 
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>

I understand this is useful as a debugging patch but I'm not sure we want
this permanently in the kernel. I'm wondering if generally more useful
approach would not be to improve error injection for page allocations to
allow easier stressing of direct reclaim...

								Honza

> ---
>  fs/notify/fanotify/fanotify.c      |  5 +++-
>  fs/notify/fanotify/fanotify_user.c | 42 +++++++++++++++++++++++++++---
>  include/linux/fsnotify_backend.h   |  2 ++
>  include/uapi/linux/fanotify.h      |  4 +++
>  4 files changed, 49 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotify.c
> index 985e995d2a39..02990a6b1b65 100644
> --- a/fs/notify/fanotify/fanotify.c
> +++ b/fs/notify/fanotify/fanotify.c
> @@ -1075,7 +1075,10 @@ static void fanotify_freeing_mark(struct fsnotify_mark *mark,
>  
>  static void fanotify_free_mark(struct fsnotify_mark *fsn_mark)
>  {
> -	kmem_cache_free(fanotify_mark_cache, fsn_mark);
> +	if (fsn_mark->flags & FSNOTIFY_MARK_FLAG_KMALLOC)
> +		kfree(fsn_mark);
> +	else
> +		kmem_cache_free(fanotify_mark_cache, fsn_mark);
>  }
>  
>  const struct fsnotify_ops fanotify_fsnotify_ops = {
> diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
> index 2c65038da4ce..a3539bd8e443 100644
> --- a/fs/notify/fanotify/fanotify_user.c
> +++ b/fs/notify/fanotify/fanotify_user.c
> @@ -928,6 +928,16 @@ static long fanotify_ioctl(struct file *file, unsigned int cmd, unsigned long ar
>  		spin_unlock(&group->notification_lock);
>  		ret = put_user(send_len, (int __user *) p);
>  		break;
> +	case FAN_IOC_SET_MARK_PAGE_ORDER:
> +		if (!capable(CAP_SYS_ADMIN))
> +			return -EPERM;
> +		mutex_lock(&group->mark_mutex);
> +		group->fanotify_data.mark_page_order = (unsigned int)arg;
> +		pr_info("fanotify: set mark size page order to %u",
> +			group->fanotify_data.mark_page_order);
> +		ret = 0;
> +		mutex_unlock(&group->mark_mutex);
> +		break;
>  	}
>  
>  	return ret;
> @@ -1150,6 +1160,7 @@ static struct fsnotify_mark *fanotify_add_new_mark(struct fsnotify_group *group,
>  						   __kernel_fsid_t *fsid)
>  {
>  	struct ucounts *ucounts = group->fanotify_data.ucounts;
> +	unsigned int order = group->fanotify_data.mark_page_order;
>  	struct fsnotify_mark *mark;
>  	int ret;
>  
> @@ -1162,7 +1173,21 @@ static struct fsnotify_mark *fanotify_add_new_mark(struct fsnotify_group *group,
>  	    !inc_ucount(ucounts->ns, ucounts->uid, UCOUNT_FANOTIFY_MARKS))
>  		return ERR_PTR(-ENOSPC);
>  
> -	mark = kmem_cache_alloc(fanotify_mark_cache, GFP_KERNEL);
> +	/*
> +	 * If requested to test direct reclaim in mark allocation context,
> +	 * start by trying to allocate requested page order per mark and
> +	 * fall back to allocation size that is likely to trigger direct
> +	 * reclaim but not too large to trigger compaction.
> +	 */
> +	if (order) {
> +		mark = kmalloc(PAGE_SIZE << order,
> +			       GFP_KERNEL_ACCOUNT | __GFP_NOWARN);
> +		if (!mark && order > PAGE_ALLOC_COSTLY_ORDER)
> +			mark = kmalloc(PAGE_SIZE << PAGE_ALLOC_COSTLY_ORDER,
> +				       GFP_KERNEL_ACCOUNT | __GFP_NOWARN);
> +	} else {
> +		mark = kmem_cache_alloc(fanotify_mark_cache, GFP_KERNEL);
> +	}
>  	if (!mark) {
>  		ret = -ENOMEM;
>  		goto out_dec_ucounts;
> @@ -1171,6 +1196,15 @@ static struct fsnotify_mark *fanotify_add_new_mark(struct fsnotify_group *group,
>  	fsnotify_init_mark(mark, group);
>  	if (fan_flags & FAN_MARK_EVICTABLE)
>  		mark->flags |= FSNOTIFY_MARK_FLAG_NO_IREF;
> +	/*
> +	 * Allow adding multiple large marks per object for testing.
> +	 * FAN_MARK_REMOVE refers to the first mark of the group, so one
> +	 * FAN_MARK_REMOVE is needed for every added large mark (or use
> +	 * FAN_MARK_FLUSH to remove all marks).
> +	 */
> +	if (order)
> +		mark->flags |= FSNOTIFY_MARK_FLAG_KMALLOC |
> +			       FSNOTIFY_MARK_FLAG_ALLOW_DUPS;
>  
>  	ret = fsnotify_add_mark_locked(mark, connp, obj_type, fsid);
>  	if (ret) {
> @@ -1201,11 +1235,13 @@ static int fanotify_add_mark(struct fsnotify_group *group,
>  			     __u32 mask, unsigned int flags,
>  			     __kernel_fsid_t *fsid)
>  {
> -	struct fsnotify_mark *fsn_mark;
> +	struct fsnotify_mark *fsn_mark = NULL;
>  	int ret = 0;
>  
>  	mutex_lock(&group->mark_mutex);
> -	fsn_mark = fsnotify_find_mark(connp, group);
> +	/* Allow adding multiple large marks per object for testing */
> +	if (!group->fanotify_data.mark_page_order)
> +		fsn_mark = fsnotify_find_mark(connp, group);
>  	if (!fsn_mark) {
>  		fsn_mark = fanotify_add_new_mark(group, connp, obj_type, flags,
>  						 fsid);
> diff --git a/include/linux/fsnotify_backend.h b/include/linux/fsnotify_backend.h
> index df58439a86fa..8220cf560c28 100644
> --- a/include/linux/fsnotify_backend.h
> +++ b/include/linux/fsnotify_backend.h
> @@ -250,6 +250,7 @@ struct fsnotify_group {
>  			int f_flags; /* event_f_flags from fanotify_init() */
>  			struct ucounts *ucounts;
>  			mempool_t error_events_pool;
> +			unsigned int mark_page_order; /* for testing only */
>  		} fanotify_data;
>  #endif /* CONFIG_FANOTIFY */
>  	};
> @@ -528,6 +529,7 @@ struct fsnotify_mark {
>  #define FSNOTIFY_MARK_FLAG_ALLOW_DUPS		0x0040
>  #define FSNOTIFY_MARK_FLAG_IGNORED_SURV_MODIFY	0x0100
>  #define FSNOTIFY_MARK_FLAG_NO_IREF		0x0200
> +#define FSNOTIFY_MARK_FLAG_KMALLOC		0x0400
>  	unsigned int flags;		/* flags [mark->lock] */
>  };
>  
> diff --git a/include/uapi/linux/fanotify.h b/include/uapi/linux/fanotify.h
> index f1f89132d60e..49cdc9008bf2 100644
> --- a/include/uapi/linux/fanotify.h
> +++ b/include/uapi/linux/fanotify.h
> @@ -3,6 +3,7 @@
>  #define _UAPI_LINUX_FANOTIFY_H
>  
>  #include <linux/types.h>
> +#include <linux/ioctl.h>
>  
>  /* the following events that user-space can register for */
>  #define FAN_ACCESS		0x00000001	/* File was accessed */
> @@ -206,4 +207,7 @@ struct fanotify_response {
>  				(long)(meta)->event_len >= (long)FAN_EVENT_METADATA_LEN && \
>  				(long)(meta)->event_len <= (long)(len))
>  
> +/* Only for testing. Not useful otherwise */
> +#define	FAN_IOC_SET_MARK_PAGE_ORDER	_IOW(0xfa, 1, long)
> +
>  #endif /* _UAPI_LINUX_FANOTIFY_H */
> -- 
> 2.25.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
