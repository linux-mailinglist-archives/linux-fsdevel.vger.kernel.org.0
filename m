Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F0903E117B
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Aug 2021 11:39:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239169AbhHEJjh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 5 Aug 2021 05:39:37 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:58662 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239159AbhHEJjg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 5 Aug 2021 05:39:36 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 5BC5221C4A;
        Thu,  5 Aug 2021 09:39:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1628156360; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=92vr7rofoVVeDOC1niCpwiCkAAOrPk5GM74ycR0NFsk=;
        b=cvoaYSNXDr9BJSVd/YV6UT/Obq6TsHFpaj9JG77HVamsTHqZmvg0HAR3bxeIl1lBOt2E+b
        GWtj6Nd7L/vKUopeUT9vew2BVInPHTnV7xcasUQz6ye4N2Q9X4ljAhQFx9Vq80N87salS4
        vGHFL9PcMYQVXe/oACxThr7ygCTcoZU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1628156360;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=92vr7rofoVVeDOC1niCpwiCkAAOrPk5GM74ycR0NFsk=;
        b=M004NslOdwMY4cqRMHuurR3xvXVKPtvFrJ/LGX39KGGCIa3rGwzjQzXOEg5sV1vvhFYVol
        wzpdL6dpJE1ikQBw==
Received: from quack2.suse.cz (unknown [10.163.43.118])
        by relay2.suse.de (Postfix) with ESMTP id 3ADFDA3B94;
        Thu,  5 Aug 2021 09:39:20 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 1850D1E1511; Thu,  5 Aug 2021 11:39:20 +0200 (CEST)
Date:   Thu, 5 Aug 2021 11:39:20 +0200
From:   Jan Kara <jack@suse.cz>
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     jack@suse.com, amir73il@gmail.com, djwong@kernel.org,
        tytso@mit.edu, david@fromorbit.com, dhowells@redhat.com,
        khazhy@google.com, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-api@vger.kernel.org,
        kernel@collabora.com
Subject: Re: [PATCH v5 13/23] fanotify: Allow file handle encoding for
 unhashed events
Message-ID: <20210805093920.GE14483@quack2.suse.cz>
References: <20210804160612.3575505-1-krisman@collabora.com>
 <20210804160612.3575505-14-krisman@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210804160612.3575505-14-krisman@collabora.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 04-08-21 12:06:02, Gabriel Krisman Bertazi wrote:
> FAN_FS_ERROR will report a file handle, but it is a unhashed event.n
						    ^^ an            ^
spurious 'n'.

> Allow passing a NULL hash to fanotify_encode_fh and avoid calculating
> the hash if not needed.
> 
> Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>

Otherwise looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/notify/fanotify/fanotify.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotify.c
> index a015822e29d8..0d6ba218bc01 100644
> --- a/fs/notify/fanotify/fanotify.c
> +++ b/fs/notify/fanotify/fanotify.c
> @@ -385,8 +385,12 @@ static int fanotify_encode_fh(struct fanotify_fh *fh, struct inode *inode,
>  	fh->type = type;
>  	fh->len = fh_len;
>  
> -	/* Mix fh into event merge key */
> -	*hash ^= fanotify_hash_fh(fh);
> +	/*
> +	 * Mix fh into event merge key.  Hash might be NULL in case of
> +	 * unhashed FID events (i.e. FAN_FS_ERROR).
> +	 */
> +	if (hash)
> +		*hash ^= fanotify_hash_fh(fh);
>  
>  	return FANOTIFY_FH_HDR_LEN + fh_len;
>  
> -- 
> 2.32.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
