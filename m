Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6342C3E146C
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Aug 2021 14:06:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239551AbhHEMGd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 5 Aug 2021 08:06:33 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:52432 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239490AbhHEMGc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 5 Aug 2021 08:06:32 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 8D8332022E;
        Thu,  5 Aug 2021 12:06:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1628165177; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Abu3sivvRCriLg2uUugS/DDlzql2+fIOMsgRHkY6XEc=;
        b=2gwv6BporHXGnKCHtL+oBTiK3eb0byoDSwI1pBbcZFKha0S8O55ejfWiqB/Yimn/RfKXRz
        Xk2TX2iasrctzYo+QMS1xGKqJJwu4uveqz2jZYmRnW9x4OzESXbYzeZGTlJyAAWsbdMgEB
        RuS5e+ExYRbVuM2U0jQzDgpQxZ0UTfc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1628165177;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Abu3sivvRCriLg2uUugS/DDlzql2+fIOMsgRHkY6XEc=;
        b=5mVwHDIpb+k0V23CZ1LEZSG9peCA6iGnq7hBhh6flTTCQAPqbiesVJe59p0QecuewOwkaE
        fmFVznvaN1Oli/Dw==
Received: from quack2.suse.cz (unknown [10.163.43.118])
        by relay2.suse.de (Postfix) with ESMTP id 6FD96A3B85;
        Thu,  5 Aug 2021 12:06:17 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id B23011E1511; Thu,  5 Aug 2021 14:06:11 +0200 (CEST)
Date:   Thu, 5 Aug 2021 14:06:11 +0200
From:   Jan Kara <jack@suse.cz>
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     jack@suse.com, amir73il@gmail.com, djwong@kernel.org,
        tytso@mit.edu, david@fromorbit.com, dhowells@redhat.com,
        khazhy@google.com, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-api@vger.kernel.org,
        kernel@collabora.com
Subject: Re: [PATCH v5 19/23] fanotify: Report fid info for file related file
 system errors
Message-ID: <20210805120611.GK14483@quack2.suse.cz>
References: <20210804160612.3575505-1-krisman@collabora.com>
 <20210804160612.3575505-20-krisman@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210804160612.3575505-20-krisman@collabora.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 04-08-21 12:06:08, Gabriel Krisman Bertazi wrote:
> Plumb the pieces to add a FID report to error records.  Since all error
> event memory must be pre-allocated, we estimate a file handler size and
> if it is insuficient, we report an invalid FID and increase the
> prediction for the next error slot allocation.
> 
> For errors that don't expose a file handler report it with an invalid
> FID.
> 
> Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>

...

> @@ -715,6 +717,31 @@ static void fanotify_insert_error_event(struct fsnotify_group *group,
>  	fee->fae.type = FANOTIFY_EVENT_TYPE_FS_ERROR;
>  	fee->error = report->error;
>  	fee->err_count = 1;
> +	fee->fsid = fee->sb_mark->fsn_mark.connector->fsid;
> +
> +	/*
> +	 * Error reporting needs to happen in atomic context.  If this
> +	 * inode's file handler length is more than we initially
> +	 * predicted, there is nothing better we can do than report the
> +	 * error with a bad file handler.
> +	 */
> +	fh_len = fanotify_encode_fh_len(inode);
> +	if (fh_len > fee->sb_mark->pred_fh_len) {
> +		pr_warn_ratelimited(
> +			"FH overflows error event. Drop inode information.\n");
> +		/*
> +		 * Update the handler size prediction for the next error
> +		 * event allocation.  This reduces the chance of another
> +		 * overflow.
> +		 */
> +		fee->sb_mark->pred_fh_len = fh_len;
> +
> +		/* For the current error, ignore the inode information. */
> +		inode = NULL;
> +		fh_len = fanotify_encode_fh_len(NULL);
> +	}
> +
> +	fanotify_encode_fh(&fee->object_fh, inode, fh_len, NULL, 0);
>  }

I don't think calling fanotify_encode_fh() from under notification_lock is
a good practice. It calls into a filesystem and god knows which locks it may
need to take to get necessary info... See my reply to patch 18 how we could
handle that better.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
