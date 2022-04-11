Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 670AD4FBB3B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Apr 2022 13:48:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344402AbiDKLuL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 11 Apr 2022 07:50:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244255AbiDKLuJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 11 Apr 2022 07:50:09 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A64445ACB
        for <linux-fsdevel@vger.kernel.org>; Mon, 11 Apr 2022 04:47:54 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id EB8F8210F5;
        Mon, 11 Apr 2022 11:47:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1649677672; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=y/TanPqbtK6UsEqMjUBcEOjp3SdUkq3Q7Exke8GCiGc=;
        b=FPR1x8wLo+5Th0jjnwWHr607XRpe1f+kcWxINQ6S4webjlsHH9srf/Pw9Dj3xUS/dAQhwI
        TwRXy5CHVKYT8erjbMqCPabTAVk91dli0pZDK1zJNn77FTII/SZhRYT+5uSjMzD/ThmkV1
        WSJuJtuEhk5C4sNLxkBBeeRM8kBSiM8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1649677672;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=y/TanPqbtK6UsEqMjUBcEOjp3SdUkq3Q7Exke8GCiGc=;
        b=aeUF67Zcyb5e7860YxjhY/TtqO+MXLIKtaHdQBJAHze4SwTh4ic+H9o4VcYobN1MsSHIkL
        IIY7TE9qNLUOMKBw==
Received: from quack3.suse.cz (unknown [10.163.28.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id C98FBA3B82;
        Mon, 11 Apr 2022 11:47:52 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 7EBC1A061B; Mon, 11 Apr 2022 13:47:52 +0200 (CEST)
Date:   Mon, 11 Apr 2022 13:47:52 +0200
From:   Jan Kara <jack@suse.cz>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jan Kara <jack@suse.cz>,
        Matthew Bobrowski <mbobrowski@mbobrowski.org>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 13/16] fanotify: implement "evictable" inode marks
Message-ID: <20220411114752.jpn7kkxnqobriep3@quack3.lan>
References: <20220329074904.2980320-1-amir73il@gmail.com>
 <20220329074904.2980320-14-amir73il@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220329074904.2980320-14-amir73il@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue 29-03-22 10:49:01, Amir Goldstein wrote:
> When an inode mark is created with flag FAN_MARK_EVICTABLE, it will not
> pin the marked inode to inode cache, so when inode is evicted from cache
> due to memory pressure, the mark will be lost.
> 
> When an inode mark with flag FAN_MARK_EVICATBLE is updated without using
> this flag, the marked inode is pinned to inode cache.
> 
> When an inode mark is updated with flag FAN_MARK_EVICTABLE but an
> existing mark already has the inode pinned, the mark update fails with
> error EEXIST.

I was thinking about this. FAN_MARK_EVICTABLE is effectively a hint to the
kernel - you can drop this if you wish. So does it make sense to return
error when we cannot follow the hint? Doesn't this just add unnecessary
work (determining whether the mark should be evictable or not) to the
userspace application using FAN_MARK_EVICTABLE?

I'd also note that FSNOTIFY_MARK_FLAG_NO_IREF needs to be stored only
because of this error checking behavior. Otherwise it would be enough to
have a flag on the connector (whether it holds iref or not) and
fsnotify_add_mark() would update the connector as needed given the added
mark. No need to mess with fsnotify_recalc_mask(). But this would be just
a small simplification. The API question in the above paragraph is more
important to me.

								Honza

> ---
>  fs/notify/fanotify/fanotify.h      |  2 ++
>  fs/notify/fanotify/fanotify_user.c | 31 +++++++++++++++++++++++++++++-
>  include/uapi/linux/fanotify.h      |  1 +
>  3 files changed, 33 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/notify/fanotify/fanotify.h b/fs/notify/fanotify/fanotify.h
> index 87142bc0131a..80e0ec95b113 100644
> --- a/fs/notify/fanotify/fanotify.h
> +++ b/fs/notify/fanotify/fanotify.h
> @@ -497,6 +497,8 @@ static inline unsigned int fanotify_mark_user_flags(struct fsnotify_mark *mark)
>  
>  	if (mark->flags & FSNOTIFY_MARK_FLAG_IGNORED_SURV_MODIFY)
>  		mflags |= FAN_MARK_IGNORED_SURV_MODIFY;
> +	if (mark->flags & FSNOTIFY_MARK_FLAG_NO_IREF)
> +		mflags |= FAN_MARK_EVICTABLE;
>  
>  	return mflags;
>  }
> diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
> index 6e78ea12239c..2c65038da4ce 100644
> --- a/fs/notify/fanotify/fanotify_user.c
> +++ b/fs/notify/fanotify/fanotify_user.c
> @@ -1084,6 +1084,8 @@ static int fanotify_remove_inode_mark(struct fsnotify_group *group,
>  static int fanotify_mark_update_flags(struct fsnotify_mark *fsn_mark,
>  				      unsigned int flags, bool *recalc)
>  {
> +	bool want_iref = !(flags & FAN_MARK_EVICTABLE);
> +
>  	/*
>  	 * Setting FAN_MARK_IGNORED_SURV_MODIFY for the first time may lead to
>  	 * the removal of the FS_MODIFY bit in calculated mask if it was set
> @@ -1097,6 +1099,20 @@ static int fanotify_mark_update_flags(struct fsnotify_mark *fsn_mark,
>  			*recalc = true;
>  	}
>  
> +	if (fsn_mark->connector->type != FSNOTIFY_OBJ_TYPE_INODE ||
> +	    want_iref == !(fsn_mark->flags & FSNOTIFY_MARK_FLAG_NO_IREF))
> +		return 0;
> +
> +	/*
> +	 * NO_IREF may be removed from a mark, but not added.
> +	 * When removed, fsnotify_recalc_mask() will take the inode ref.
> +	 */
> +	if (!want_iref)
> +		return -EEXIST;
> +
> +	fsn_mark->flags &= ~FSNOTIFY_MARK_FLAG_NO_IREF;
> +	*recalc = true;
> +
>  	return 0;
>  }
>  
> @@ -1130,6 +1146,7 @@ static int fanotify_mark_add_to_mask(struct fsnotify_mark *fsn_mark,
>  static struct fsnotify_mark *fanotify_add_new_mark(struct fsnotify_group *group,
>  						   fsnotify_connp_t *connp,
>  						   unsigned int obj_type,
> +						   unsigned int fan_flags,
>  						   __kernel_fsid_t *fsid)
>  {
>  	struct ucounts *ucounts = group->fanotify_data.ucounts;
> @@ -1152,6 +1169,9 @@ static struct fsnotify_mark *fanotify_add_new_mark(struct fsnotify_group *group,
>  	}
>  
>  	fsnotify_init_mark(mark, group);
> +	if (fan_flags & FAN_MARK_EVICTABLE)
> +		mark->flags |= FSNOTIFY_MARK_FLAG_NO_IREF;
> +
>  	ret = fsnotify_add_mark_locked(mark, connp, obj_type, fsid);
>  	if (ret) {
>  		fsnotify_put_mark(mark);
> @@ -1187,7 +1207,8 @@ static int fanotify_add_mark(struct fsnotify_group *group,
>  	mutex_lock(&group->mark_mutex);
>  	fsn_mark = fsnotify_find_mark(connp, group);
>  	if (!fsn_mark) {
> -		fsn_mark = fanotify_add_new_mark(group, connp, obj_type, fsid);
> +		fsn_mark = fanotify_add_new_mark(group, connp, obj_type, flags,
> +						 fsid);
>  		if (IS_ERR(fsn_mark)) {
>  			mutex_unlock(&group->mark_mutex);
>  			return PTR_ERR(fsn_mark);
> @@ -1602,6 +1623,14 @@ static int do_fanotify_mark(int fanotify_fd, unsigned int flags, __u64 mask,
>  	    mark_type != FAN_MARK_FILESYSTEM)
>  		goto fput_and_out;
>  
> +	/*
> +	 * Evictable is only relevant for inode marks, because only inode object
> +	 * can be evicted on memory pressure.
> +	 */
> +	if (flags & FAN_MARK_EVICTABLE &&
> +	     mark_type != FAN_MARK_INODE)
> +		goto fput_and_out;
> +
>  	/*
>  	 * Events that do not carry enough information to report
>  	 * event->fd require a group that supports reporting fid.  Those
> diff --git a/include/uapi/linux/fanotify.h b/include/uapi/linux/fanotify.h
> index e8ac38cc2fd6..f1f89132d60e 100644
> --- a/include/uapi/linux/fanotify.h
> +++ b/include/uapi/linux/fanotify.h
> @@ -82,6 +82,7 @@
>  #define FAN_MARK_IGNORED_SURV_MODIFY	0x00000040
>  #define FAN_MARK_FLUSH		0x00000080
>  /* FAN_MARK_FILESYSTEM is	0x00000100 */
> +#define FAN_MARK_EVICTABLE	0x00000200
>  
>  /* These are NOT bitwise flags.  Both bits can be used togther.  */
>  #define FAN_MARK_INODE		0x00000000
> -- 
> 2.25.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
