Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD6B755D586
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Jun 2022 15:15:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344272AbiF1J1a (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Jun 2022 05:27:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344240AbiF1J11 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Jun 2022 05:27:27 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0C271EAC1;
        Tue, 28 Jun 2022 02:27:26 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 77BE121E6D;
        Tue, 28 Jun 2022 09:27:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1656408445; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=otQ3a1B7nG6+1cCnA27bo5lr+i6zKzOzpjv4D9f3kHg=;
        b=bTSROMhfkR7PSFfqPHfHZtY3Cabf3O8LNVol9DVP/j9+jlpG+WNqROMejEl7UpvQsPOGs+
        B8bV0vS2X3IerxMCRzQKX0hd3wCG1pD+pA19Om+0Gnw26AaIqVg+fbVu/9xXE/nceu5uOK
        aT6V4KSnCPv1wuH58T3faldgvhgSzT4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1656408445;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=otQ3a1B7nG6+1cCnA27bo5lr+i6zKzOzpjv4D9f3kHg=;
        b=vRrADVxy8wW7Vif8v8ALxUYQDeQ3ECyu80YIueXcKRKyC1CSGo7IQedApUnqz1zkYK6/5B
        OJzxr2zhoxhNczDw==
Received: from quack3.suse.cz (dhcp194.suse.cz [10.100.51.194])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 6A1442C143;
        Tue, 28 Jun 2022 09:27:25 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 47986A062F; Tue, 28 Jun 2022 11:27:25 +0200 (CEST)
Date:   Tue, 28 Jun 2022 11:27:25 +0200
From:   Jan Kara <jack@suse.cz>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jan Kara <jack@suse.cz>, Matthew Bobrowski <repnop@google.com>,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org
Subject: Re: [PATCH] fanotify: refine the validation checks on non-dir inode
 mask
Message-ID: <20220628092725.mfwvdu4sk72jov5x@quack3>
References: <20220627174719.2838175-1-amir73il@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220627174719.2838175-1-amir73il@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon 27-06-22 20:47:19, Amir Goldstein wrote:
> Commit ceaf69f8eadc ("fanotify: do not allow setting dirent events in
> mask of non-dir") added restrictions about setting dirent events in the
> mask of a non-dir inode mark, which does not make any sense.
> 
> For backward compatibility, these restictions were added only to new
> (v5.17+) APIs.
> 
> It also does not make any sense to set the flags FAN_EVENT_ON_CHILD or
> FAN_ONDIR in the mask of a non-dir inode.  Add these flags to the
> dir-only restriction of the new APIs as well.
> 
> Move the check of the dir-only flags for new APIs into the helper
> fanotify_events_supported(), which is only called for FAN_MARK_ADD,
> because there is no need to error on an attempt to remove the dir-only
> flags from non-dir inode.
> 
> Fixes: ceaf69f8eadc ("fanotify: do not allow setting dirent events in mask of non-dir")
> Link: https://lore.kernel.org/linux-fsdevel/20220627113224.kr2725conevh53u4@quack3.lan/
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>

Thanks! I've taken the patch to my tree.

								Honza

> [1] https://github.com/amir73il/ltp/commits/fan_enotdir
> [2] https://github.com/amir73il/man-pages/commits/fanotify_target_fid
> 
> 
>  fs/notify/fanotify/fanotify_user.c | 34 +++++++++++++++++-------------
>  include/linux/fanotify.h           |  4 ++++
>  2 files changed, 23 insertions(+), 15 deletions(-)
> 
> diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
> index c2255b440df9..b08ce0d821a7 100644
> --- a/fs/notify/fanotify/fanotify_user.c
> +++ b/fs/notify/fanotify/fanotify_user.c
> @@ -1513,8 +1513,15 @@ static int fanotify_test_fid(struct dentry *dentry)
>  	return 0;
>  }
>  
> -static int fanotify_events_supported(struct path *path, __u64 mask)
> +static int fanotify_events_supported(struct fsnotify_group *group,
> +				     struct path *path, __u64 mask,
> +				     unsigned int flags)
>  {
> +	unsigned int mark_type = flags & FANOTIFY_MARK_TYPE_BITS;
> +	/* Strict validation of events in non-dir inode mask with v5.17+ APIs */
> +	bool strict_dir_events = FAN_GROUP_FLAG(group, FAN_REPORT_TARGET_FID) ||
> +				 (mask & FAN_RENAME);
> +
>  	/*
>  	 * Some filesystems such as 'proc' acquire unusual locks when opening
>  	 * files. For them fanotify permission events have high chances of
> @@ -1526,6 +1533,16 @@ static int fanotify_events_supported(struct path *path, __u64 mask)
>  	if (mask & FANOTIFY_PERM_EVENTS &&
>  	    path->mnt->mnt_sb->s_type->fs_flags & FS_DISALLOW_NOTIFY_PERM)
>  		return -EINVAL;
> +
> +	/*
> +	 * We shouldn't have allowed setting dirent events and the directory
> +	 * flags FAN_ONDIR and FAN_EVENT_ON_CHILD in mask of non-dir inode,
> +	 * but because we always allowed it, error only when using new APIs.
> +	 */
> +	if (strict_dir_events && mark_type == FAN_MARK_INODE &&
> +	    !d_is_dir(path->dentry) && (mask & FANOTIFY_DIRONLY_EVENT_BITS))
> +		return -ENOTDIR;
> +
>  	return 0;
>  }
>  
> @@ -1672,7 +1689,7 @@ static int do_fanotify_mark(int fanotify_fd, unsigned int flags, __u64 mask,
>  		goto fput_and_out;
>  
>  	if (flags & FAN_MARK_ADD) {
> -		ret = fanotify_events_supported(&path, mask);
> +		ret = fanotify_events_supported(group, &path, mask, flags);
>  		if (ret)
>  			goto path_put_and_out;
>  	}
> @@ -1695,19 +1712,6 @@ static int do_fanotify_mark(int fanotify_fd, unsigned int flags, __u64 mask,
>  	else
>  		mnt = path.mnt;
>  
> -	/*
> -	 * FAN_RENAME is not allowed on non-dir (for now).
> -	 * We shouldn't have allowed setting any dirent events in mask of
> -	 * non-dir, but because we always allowed it, error only if group
> -	 * was initialized with the new flag FAN_REPORT_TARGET_FID.
> -	 */
> -	ret = -ENOTDIR;
> -	if (inode && !S_ISDIR(inode->i_mode) &&
> -	    ((mask & FAN_RENAME) ||
> -	     ((mask & FANOTIFY_DIRENT_EVENTS) &&
> -	      FAN_GROUP_FLAG(group, FAN_REPORT_TARGET_FID))))
> -		goto path_put_and_out;
> -
>  	/* Mask out FAN_EVENT_ON_CHILD flag for sb/mount/non-dir marks */
>  	if (mnt || !S_ISDIR(inode->i_mode)) {
>  		mask &= ~FAN_EVENT_ON_CHILD;
> diff --git a/include/linux/fanotify.h b/include/linux/fanotify.h
> index edc28555814c..e517dbcf74ed 100644
> --- a/include/linux/fanotify.h
> +++ b/include/linux/fanotify.h
> @@ -111,6 +111,10 @@
>  					 FANOTIFY_PERM_EVENTS | \
>  					 FAN_Q_OVERFLOW | FAN_ONDIR)
>  
> +/* Events and flags relevant only for directories */
> +#define FANOTIFY_DIRONLY_EVENT_BITS	(FANOTIFY_DIRENT_EVENTS | \
> +					 FAN_EVENT_ON_CHILD | FAN_ONDIR)
> +
>  #define ALL_FANOTIFY_EVENT_BITS		(FANOTIFY_OUTGOING_EVENTS | \
>  					 FANOTIFY_EVENT_FLAGS)
>  
> -- 
> 2.25.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
