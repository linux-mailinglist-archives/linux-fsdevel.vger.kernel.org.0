Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D5E23BF0AA
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Jul 2021 22:14:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233140AbhGGUQu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 7 Jul 2021 16:16:50 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:57426 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230296AbhGGUQt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 7 Jul 2021 16:16:49 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id C745F20100;
        Wed,  7 Jul 2021 20:14:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1625688847; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=G16r5ZzCDpmdwpyxd+WXlKLidqUdLoyo9jFAMAqRQFQ=;
        b=gKNBEqlHQFaExTrToE1vaGOxpfUIqwsUV03KcqTOIqybBT645xt7ee4LBPsbVMnSKfDxP2
        cy5cy3ux7QQim2kZz1ojLrWuWnIVAn6850QC67lYGpfMEtM87P0F6q4wGoxAwcOQiP//S7
        jbrxPYLRSmkCie1YDDhZjhOYrJYcvgk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1625688847;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=G16r5ZzCDpmdwpyxd+WXlKLidqUdLoyo9jFAMAqRQFQ=;
        b=/yhtbtVaVZF3EgWxabFWzavGzuS7TGqGNBxnlvSPtbo1iPwMAV55Oy5IprmLds0TCYAHx/
        9Rkjuktn0TY4tdBw==
Received: from quack2.suse.cz (unknown [10.163.43.118])
        by relay2.suse.de (Postfix) with ESMTP id B420CA3B87;
        Wed,  7 Jul 2021 20:14:07 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 97E131F2CD7; Wed,  7 Jul 2021 22:14:07 +0200 (CEST)
Date:   Wed, 7 Jul 2021 22:14:07 +0200
From:   Jan Kara <jack@suse.cz>
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     amir73il@gmail.com, djwong@kernel.org, tytso@mit.edu,
        david@fromorbit.com, jack@suse.com, dhowells@redhat.com,
        khazhy@google.com, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, kernel@collabora.com
Subject: Re: [PATCH v3 06/15] fsnotify: Add helper to detect overflow_event
Message-ID: <20210707201407.GH18396@quack2.suse.cz>
References: <20210629191035.681913-1-krisman@collabora.com>
 <20210629191035.681913-7-krisman@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210629191035.681913-7-krisman@collabora.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue 29-06-21 15:10:26, Gabriel Krisman Bertazi wrote:
> Similarly to fanotify_is_perm_event and friends, provide a helper
> predicate to say whether a mask is of an overflow event.
> 
> Suggested-by: Amir Goldstein <amir73il@gmail.com>
> Reviewed-by: Amir Goldstein <amir73il@gmail.com>
> Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
> ---
>  fs/notify/fanotify/fanotify.h    | 3 ++-
>  include/linux/fsnotify_backend.h | 5 +++++
>  2 files changed, 7 insertions(+), 1 deletion(-)

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> 
> diff --git a/fs/notify/fanotify/fanotify.h b/fs/notify/fanotify/fanotify.h
> index fd125a949187..2e005b3a75f2 100644
> --- a/fs/notify/fanotify/fanotify.h
> +++ b/fs/notify/fanotify/fanotify.h
> @@ -328,7 +328,8 @@ static inline struct path *fanotify_event_path(struct fanotify_event *event)
>   */
>  static inline bool fanotify_is_hashed_event(u32 mask)
>  {
> -	return !fanotify_is_perm_event(mask) && !(mask & FS_Q_OVERFLOW);
> +	return !(fanotify_is_perm_event(mask) ||
> +		 fsnotify_is_overflow_event(mask));
>  }
>  
>  static inline unsigned int fanotify_event_hash_bucket(
> diff --git a/include/linux/fsnotify_backend.h b/include/linux/fsnotify_backend.h
> index c4473b467c28..f9e2c6cd0f7d 100644
> --- a/include/linux/fsnotify_backend.h
> +++ b/include/linux/fsnotify_backend.h
> @@ -495,6 +495,11 @@ static inline void fsnotify_queue_overflow(struct fsnotify_group *group)
>  	fsnotify_add_event(group, group->overflow_event, NULL, NULL);
>  }
>  
> +static inline bool fsnotify_is_overflow_event(u32 mask)
> +{
> +	return mask & FS_Q_OVERFLOW;
> +}
> +
>  static inline bool fsnotify_notify_queue_is_empty(struct fsnotify_group *group)
>  {
>  	assert_spin_locked(&group->notification_lock);
> -- 
> 2.32.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
