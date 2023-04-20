Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F1FF6E9579
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Apr 2023 15:12:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231455AbjDTNMU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 Apr 2023 09:12:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231341AbjDTNMS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 Apr 2023 09:12:18 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 126AB7282;
        Thu, 20 Apr 2023 06:12:09 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id B8BDA1FD82;
        Thu, 20 Apr 2023 13:12:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1681996327; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=sq4vXLjGvNJIh9WF/ieSrWzNeyU6iFQIDxDHXrfF0Ao=;
        b=LSBHR9EvI0HbmH3MrPE8vA2eypg1L8l9jdiI0x+3lE6gYmwS7w5QYiNCuxKPfCvDxG9Ig3
        WP8+iNcICezGBs/7gcIBo91LYalRHCgT2gJiQJHMfZ1quy7KXe6sg2XEBqyGB/gxWe90um
        WABp+aAU0AO/AcHvuawpxJzGj/SySiw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1681996327;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=sq4vXLjGvNJIh9WF/ieSrWzNeyU6iFQIDxDHXrfF0Ao=;
        b=tp1k2eO2tbiYKsj9oA/HFl3WQXNGXe+3NvmFjkHe5N+kHXx1Ln8WGIkoZo3FB6hNxPkaDz
        fETlXTqwDs2sLUCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id AB5381333C;
        Thu, 20 Apr 2023 13:12:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 1andKSc6QWTbEwAAMHmgww
        (envelope-from <jack@suse.cz>); Thu, 20 Apr 2023 13:12:07 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 44F76A0729; Thu, 20 Apr 2023 15:12:07 +0200 (CEST)
Date:   Thu, 20 Apr 2023 15:12:07 +0200
From:   Jan Kara <jack@suse.cz>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jan Kara <jack@suse.cz>, Matthew Bobrowski <repnop@google.com>,
        Christian Brauner <brauner@kernel.org>,
        Lennart Poettering <lennart@poettering.net>,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org
Subject: Re: [RFC][PATCH] fanotify: support watching filesystems and mounts
 inside userns
Message-ID: <20230420131207.dligsga5spbiptje@quack3>
References: <20230416060722.1912831-1-amir73il@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230416060722.1912831-1-amir73il@gmail.com>
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun 16-04-23 09:07:22, Amir Goldstein wrote:
> An unprivileged user is allowed to create an fanotify group and add
> inode marks, but not filesystem and mount marks.
> 
> Add limited support for setting up filesystem and mount marks by an
> unprivileged user under the following conditions:
> 
> 1.   User has CAP_SYS_ADMIN in the user ns where the group was created
> 2.a. User has CAP_SYS_ADMIN in the user ns where the filesystem was
>      mounted (implies FS_USERNS_MOUNT)
>   OR (in case setting up a mark mount)
> 2.b. User has CAP_SYS_ADMIN in the user ns attached to an idmapped mount
> 
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>

The patch looks good to me. Just two comments below. 

> Christian,
> 
> You can find this patch, along with FAN_UNMOUNT patches on my github [3].
> Please confirm that this meets your needs for watching container mounts.
> 
> [3] https://github.com/amir73il/linux/commits/fan_unmount

Yeah, it would be good to get ack from Christian that the model you propose
works for him.

> diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
> index db3b79b8e901..2c3e123aee14 100644
> --- a/fs/notify/fanotify/fanotify_user.c
> +++ b/fs/notify/fanotify/fanotify_user.c
> @@ -1238,6 +1238,7 @@ static struct fsnotify_mark *fanotify_add_new_mark(struct fsnotify_group *group,
>  	 * A group with FAN_UNLIMITED_MARKS does not contribute to mark count
>  	 * in the limited groups account.
>  	 */
> +	BUILD_BUG_ON(!(FANOTIFY_ADMIN_INIT_FLAGS & FAN_UNLIMITED_MARKS));
>  	if (!FAN_GROUP_FLAG(group, FAN_UNLIMITED_MARKS) &&
>  	    !inc_ucount(ucounts->ns, ucounts->uid, UCOUNT_FANOTIFY_MARKS))
>  		return ERR_PTR(-ENOSPC);
...
> @@ -1557,21 +1559,13 @@ SYSCALL_DEFINE2(fanotify_init, unsigned int, flags, unsigned int, event_f_flags)
>  		goto out_destroy_group;
>  	}
>  
> +	BUILD_BUG_ON(!(FANOTIFY_ADMIN_INIT_FLAGS & FAN_UNLIMITED_QUEUE));
>  	if (flags & FAN_UNLIMITED_QUEUE) {
> -		fd = -EPERM;
> -		if (!capable(CAP_SYS_ADMIN))
> -			goto out_destroy_group;
>  		group->max_events = UINT_MAX;
>  	} else {
>  		group->max_events = fanotify_max_queued_events;
>  	}
>  
> -	if (flags & FAN_UNLIMITED_MARKS) {
> -		fd = -EPERM;
> -		if (!capable(CAP_SYS_ADMIN))
> -			goto out_destroy_group;
> -	}
> -

Perhaps this hunk (plus the BUILD_BUG_ON hunk above) should go into a
separate patch with a proper changelog?  I was scratching my head over it
for a while until I've realized it's unrelated cleanup of dead code.

							Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
