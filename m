Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2254651FA63
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 May 2022 12:50:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229472AbiEIKwN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 May 2022 06:52:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231489AbiEIKvJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 May 2022 06:51:09 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B20A12211F0
        for <linux-fsdevel@vger.kernel.org>; Mon,  9 May 2022 03:46:45 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id D6E7E21ACF;
        Mon,  9 May 2022 10:46:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1652093203; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LIvz56YfSZ5krkFg9w1RPImiai4IT9y7iqPUOcD2m/A=;
        b=K9TdVljH0Zqn+lMKfk8WxaOL3ka58ZXZ9PzO+ytER+y+39Im6DRcXSPqMCNLWjPsFQUH97
        T1kYvigqwC7irdQMnqZ4WAXdP7itvW7WHkAGwC8qtjuMSuLDXV9TflwVbG+ewTcJY14u11
        Y9ERb8b36jmXj1e7oJc8aySgykadlOU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1652093203;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LIvz56YfSZ5krkFg9w1RPImiai4IT9y7iqPUOcD2m/A=;
        b=BkvLXk/8i3902GLaJ3EOk7yrpDBX48H8G39pPedTreJRpP2is+aYARKvg6SZZa6YFrRhCD
        YZl1oPWN5unrFIAQ==
Received: from quack3.suse.cz (unknown [10.163.28.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id B87EF2C141;
        Mon,  9 May 2022 10:46:43 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 646B1A062A; Mon,  9 May 2022 12:46:43 +0200 (CEST)
Date:   Mon, 9 May 2022 12:46:43 +0200
From:   Jan Kara <jack@suse.cz>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jan Kara <jack@suse.cz>,
        Matthew Bobrowski <mbobrowski@mbobrowski.org>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2] fanotify: do not allow setting dirent events in mask
 of non-dir
Message-ID: <20220509104643.yfw3ypxjuhn4ejjg@quack3.lan>
References: <20220507080028.219826-1-amir73il@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220507080028.219826-1-amir73il@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat 07-05-22 11:00:28, Amir Goldstein wrote:
> Dirent events (create/delete/move) are only reported on watched
> directory inodes, but in fanotify as well as in legacy inotify, it was
> always allowed to set them on non-dir inode, which does not result in
> any meaningful outcome.
> 
> Until kernel v5.17, dirent events in fanotify also differed from events
> "on child" (e.g. FAN_OPEN) in the information provided in the event.
> For example, FAN_OPEN could be set in the mask of a non-dir or the mask
> of its parent and event would report the fid of the child regardless of
> the marked object.
> By contrast, FAN_DELETE is not reported if the child is marked and the
> child fid was not reported in the events.
> 
> Since kernel v5.17, with fanotify group flag FAN_REPORT_TARGET_FID, the
> fid of the child is reported with dirent events, like events "on child",
> which may create confusion for users expecting the same behavior as
> events "on child" when setting events in the mask on a child.
> 
> The desired semantics of setting dirent events in the mask of a child
> are not clear, so for now, deny this action for a group initialized
> with flag FAN_REPORT_TARGET_FID and for the new event FAN_RENAME.
> We may relax this restriction in the future if we decide on the
> semantics and implement them.
> 
> Fixes: d61fd650e9d2 ("fanotify: introduce group flag FAN_REPORT_TARGET_FID")
> Fixes: 8cc3b1ccd930 ("fanotify: wire up FAN_RENAME event")
> Link: https://lore.kernel.org/linux-fsdevel/20220505133057.zm5t6vumc4xdcnsg@quack3.lan/
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> ---
> 
> Jan,
> 
> Having slept over it, I think we should apply this stronger fix.
> I could have done this as an extra patch, but since FAN_RENAME was
> merged together with FAN_REPORT_TARGET_FID I did not see the point,
> but you could apply this on top of the FAN_RENAME patch if you prefer.

OK, done and force-pushed everywhere.

								Honza

> Changes since v1:
> - Deny all dirent events on non-dir not only FAN_RENAME
> - Return -ENOTDIR instead of -EINVAL
> 
>  fs/notify/fanotify/fanotify_user.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
> index edad67d674dc..cf587ba2ba92 100644
> --- a/fs/notify/fanotify/fanotify_user.c
> +++ b/fs/notify/fanotify/fanotify_user.c
> @@ -1695,6 +1695,19 @@ static int do_fanotify_mark(int fanotify_fd, unsigned int flags, __u64 mask,
>  	else
>  		mnt = path.mnt;
>  
> +	/*
> +	 * FAN_RENAME is not allowed on non-dir (for now).
> +	 * We shouldn't have allowed setting any dirent events in mask of
> +	 * non-dir, but because we always allowed it, error only if group
> +	 * was initialized with the new flag FAN_REPORT_TARGET_FID.
> +	 */
> +	ret = -ENOTDIR;
> +	if (inode && !S_ISDIR(inode->i_mode) &&
> +	    ((mask & FAN_RENAME) ||
> +	     ((mask & FANOTIFY_DIRENT_EVENTS) &&
> +	      FAN_GROUP_FLAG(group, FAN_REPORT_TARGET_FID))))
> +		goto path_put_and_out;
> +
>  	/* Mask out FAN_EVENT_ON_CHILD flag for sb/mount/non-dir marks */
>  	if (mnt || !S_ISDIR(inode->i_mode)) {
>  		mask &= ~FAN_EVENT_ON_CHILD;
> -- 
> 2.25.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
