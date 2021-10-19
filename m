Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E5DE433804
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Oct 2021 16:06:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235758AbhJSOJD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Oct 2021 10:09:03 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:46154 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231460AbhJSOJC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Oct 2021 10:09:02 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id D31002196D;
        Tue, 19 Oct 2021 14:06:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1634652408; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=sI0lM0Ut7mSt5KENunS+mDmwIIaWrvyS20S9fheYD0o=;
        b=EJ6y3+mM6dfgcIL2bxhqTJJDODQ33YVPRGajrrnRQGjU3C8eqBHkF2Mj+j5fcJP+t9Cvi0
        KNqZjSqos/kpy5Qbb/tuZFj3XWRe/tG1vULAZaMse1a2bQ9b118idZsLJia12Le3XnazIG
        Jarm8HScutrIdQYPh+xW41WMldpWNOk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1634652408;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=sI0lM0Ut7mSt5KENunS+mDmwIIaWrvyS20S9fheYD0o=;
        b=wIZpr006KVjiCr0V2sx80KP6CKY5sjovbr9XfgFxAR7LtMlscHvSs3y+EDfcHwnaddzSDI
        ltmaRt0lSQnPRvCw==
Received: from quack2.suse.cz (unknown [10.100.200.198])
        by relay2.suse.de (Postfix) with ESMTP id BD20BA3B83;
        Tue, 19 Oct 2021 14:06:48 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 9D57F1E0983; Tue, 19 Oct 2021 16:06:48 +0200 (CEST)
Date:   Tue, 19 Oct 2021 16:06:48 +0200
From:   Jan Kara <jack@suse.cz>
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     jack@suse.com, amir73il@gmail.com, djwong@kernel.org,
        tytso@mit.edu, david@fromorbit.com, dhowells@redhat.com,
        khazhy@google.com, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-api@vger.kernel.org,
        kernel@collabora.com
Subject: Re: [PATCH v8 26/32] fanotify: WARN_ON against too large file handles
Message-ID: <20211019140648.GN3255@quack2.suse.cz>
References: <20211019000015.1666608-1-krisman@collabora.com>
 <20211019000015.1666608-27-krisman@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211019000015.1666608-27-krisman@collabora.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon 18-10-21 21:00:09, Gabriel Krisman Bertazi wrote:
> struct fanotify_error_event, at least, is preallocated and isn't able to
> to handle arbitrarily large file handles.  Future-proof the code by
> complaining loudly if a handle larger than MAX_HANDLE_SZ is ever found.
> 
> Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/notify/fanotify/fanotify.c | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotify.c
> index cedcb1546804..45df610debbe 100644
> --- a/fs/notify/fanotify/fanotify.c
> +++ b/fs/notify/fanotify/fanotify.c
> @@ -360,13 +360,23 @@ static u32 fanotify_group_event_mask(struct fsnotify_group *group,
>  static int fanotify_encode_fh_len(struct inode *inode)
>  {
>  	int dwords = 0;
> +	int fh_len;
>  
>  	if (!inode)
>  		return 0;
>  
>  	exportfs_encode_inode_fh(inode, NULL, &dwords, NULL);
> +	fh_len = dwords << 2;
>  
> -	return dwords << 2;
> +	/*
> +	 * struct fanotify_error_event might be preallocated and is
> +	 * limited to MAX_HANDLE_SZ.  This should never happen, but
> +	 * safeguard by forcing an invalid file handle.
> +	 */
> +	if (WARN_ON_ONCE(fh_len > MAX_HANDLE_SZ))
> +		return 0;
> +
> +	return fh_len;
>  }
>  
>  /*
> -- 
> 2.33.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
