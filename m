Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12CFC3EDAC5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Aug 2021 18:18:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230490AbhHPQTD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 16 Aug 2021 12:19:03 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:45254 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230107AbhHPQSz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 16 Aug 2021 12:18:55 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id EC5581FF96;
        Mon, 16 Aug 2021 16:18:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1629130701; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dOmpSbGnSUnjg17PYw2j4xFI3oFj7kA15QGM0EW5OKc=;
        b=gws/2yv49yFxSBjlSGJEzRrk7ANXvzsIupS15VGzd5XNQWok20EWE/mUY/nfQ5xksbl9gy
        +4CFz2MPDlUm9TlOTFynqs/EYIi9VIeTZ5EdECL5Ueb/eF0bx3cZfuNWXdPgVQXfwVxON3
        qRUpFT0x/rtLvThmK3Jgz0VAXvB5HBc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1629130701;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dOmpSbGnSUnjg17PYw2j4xFI3oFj7kA15QGM0EW5OKc=;
        b=vzIuPLVIox+HJVKQrBOs0goWSjEYs4iN8iCsDPCnAWltkOFRe5vcLRPiGyX9TNnNgG3SDm
        nLKeh7pQO37G+EBw==
Received: from quack2.suse.cz (unknown [10.100.224.230])
        by relay2.suse.de (Postfix) with ESMTP id D078EA3B8F;
        Mon, 16 Aug 2021 16:18:21 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 8CE3B1E0426; Mon, 16 Aug 2021 18:18:18 +0200 (CEST)
Date:   Mon, 16 Aug 2021 18:18:18 +0200
From:   Jan Kara <jack@suse.cz>
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     amir73il@gmail.com, jack@suse.com, linux-api@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        khazhy@google.com, dhowells@redhat.com, david@fromorbit.com,
        tytso@mit.edu, djwong@kernel.org, repnop@google.com,
        kernel@collabora.com
Subject: Re: [PATCH v6 17/21] fanotify: Report fid info for file related file
 system errors
Message-ID: <20210816161818.GH30215@quack2.suse.cz>
References: <20210812214010.3197279-1-krisman@collabora.com>
 <20210812214010.3197279-18-krisman@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210812214010.3197279-18-krisman@collabora.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 12-08-21 17:40:06, Gabriel Krisman Bertazi wrote:
> Plumb the pieces to add a FID report to error records.  Since all error
> event memory must be pre-allocated, we estimate a file handle size and
> if it is insuficient, we report an invalid FID and increase the
> prediction for the next error slot allocation.

This needs updating. The code now uses MAX_HANDLE_SZ...
 
> For errors that don't expose a file handle report it with an invalid
> FID.
> 
> Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
> 
> ---
> Changes since v5:
>   - Use preallocated MAX_HANDLE_SZ FH buffer
>   - Report superblock errors with a zerolength INVALID FID (jan, amir)
> ---
>  fs/notify/fanotify/fanotify.c      | 15 +++++++++++++++
>  fs/notify/fanotify/fanotify.h      | 11 +++++++++++
>  fs/notify/fanotify/fanotify_user.c |  7 +++++++
>  3 files changed, 33 insertions(+)
> 
> diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotify.c
> index 0c7667d3f5d1..f5c16ac37835 100644
> --- a/fs/notify/fanotify/fanotify.c
> +++ b/fs/notify/fanotify/fanotify.c
> @@ -734,6 +734,8 @@ static int fanotify_handle_error_event(struct fsnotify_iter_info *iter_info,
>  	struct fanotify_sb_mark *sb_mark =
>  		FANOTIFY_SB_MARK(fsnotify_iter_sb_mark(iter_info));
>  	struct fanotify_error_event *fee = sb_mark->fee_slot;
> +	struct inode *inode = report->inode;
> +	int fh_len;
>  
>  	spin_lock(&group->notification_lock);
>  	if (fee->err_count++) {
> @@ -743,6 +745,19 @@ static int fanotify_handle_error_event(struct fsnotify_iter_info *iter_info,
>  	spin_unlock(&group->notification_lock);
>  
>  	fee->fae.type = FANOTIFY_EVENT_TYPE_FS_ERROR;
> +	fee->fsid = fee->sb_mark->fsn_mark.connector->fsid;

Why don't you use sb_mark directly?

Otherwise the patch looks good to me.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
