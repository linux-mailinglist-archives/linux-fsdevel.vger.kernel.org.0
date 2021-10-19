Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6661543380E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Oct 2021 16:08:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232666AbhJSOLA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Oct 2021 10:11:00 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:60056 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232615AbhJSOK7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Oct 2021 10:10:59 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id E49231F782;
        Tue, 19 Oct 2021 14:08:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1634652525; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nzjOyBQvl4mFaSHeEvZB3Ixi5wIxP+tZP4qGDw8BtrM=;
        b=jHeXI5GPzZbX75Vns+swZFfKPw52SfpvhDbMpzO+FE+SCkT6e3x261TuPnw2yeyck75xc5
        t5gv7oPU3oc0EOZorFylhNcSCGNgaLbcKP2doG6dwP9QUNYHiEHkMSgZeDr5Uixuhen1v1
        kSedkaoQBHK+5e+i52UVdKipNGLXQbI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1634652525;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nzjOyBQvl4mFaSHeEvZB3Ixi5wIxP+tZP4qGDw8BtrM=;
        b=UDQaMGrwRnMj6aWHqezTvN0YMBfxCyAiZWXjfJV71V1p+TS8/QMBBNMekmCS2zJsOtqgjw
        GKjTFSBv4FZBkSAw==
Received: from quack2.suse.cz (unknown [10.100.200.198])
        by relay2.suse.de (Postfix) with ESMTP id D5B4CA3B85;
        Tue, 19 Oct 2021 14:08:45 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id BE2971E0983; Tue, 19 Oct 2021 16:08:45 +0200 (CEST)
Date:   Tue, 19 Oct 2021 16:08:45 +0200
From:   Jan Kara <jack@suse.cz>
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     jack@suse.com, amir73il@gmail.com, djwong@kernel.org,
        tytso@mit.edu, david@fromorbit.com, dhowells@redhat.com,
        khazhy@google.com, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-api@vger.kernel.org,
        kernel@collabora.com
Subject: Re: [PATCH v8 25/32] fanotify: Report fid entry even for zero-length
 file_handle
Message-ID: <20211019140845.GO3255@quack2.suse.cz>
References: <20211019000015.1666608-1-krisman@collabora.com>
 <20211019000015.1666608-26-krisman@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211019000015.1666608-26-krisman@collabora.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon 18-10-21 21:00:08, Gabriel Krisman Bertazi wrote:
> Non-inode errors will reported with an empty file_handle.  In
> preparation for that, allow some events to print the FID record even if
> there isn't any file_handle encoded
> 
> Even though FILEID_ROOT is used internally, make zero-length file
> handles be reported as FILEID_INVALID.
> 
> Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>

I suppose you need to move fanotify_has_object_fh() change from patch 27
here. Otherwise the change looks good so feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/notify/fanotify/fanotify_user.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
> index ae848306a017..cd962deefeb7 100644
> --- a/fs/notify/fanotify/fanotify_user.c
> +++ b/fs/notify/fanotify/fanotify_user.c
> @@ -339,9 +339,6 @@ static int copy_fid_info_to_user(__kernel_fsid_t *fsid, struct fanotify_fh *fh,
>  	pr_debug("%s: fh_len=%zu name_len=%zu, info_len=%zu, count=%zu\n",
>  		 __func__, fh_len, name_len, info_len, count);
>  
> -	if (!fh_len)
> -		return 0;
> -
>  	if (WARN_ON_ONCE(len < sizeof(info) || len > count))
>  		return -EFAULT;
>  
> @@ -376,6 +373,11 @@ static int copy_fid_info_to_user(__kernel_fsid_t *fsid, struct fanotify_fh *fh,
>  
>  	handle.handle_type = fh->type;
>  	handle.handle_bytes = fh_len;
> +
> +	/* Mangle handle_type for bad file_handle */
> +	if (!fh_len)
> +		handle.handle_type = FILEID_INVALID;
> +
>  	if (copy_to_user(buf, &handle, sizeof(handle)))
>  		return -EFAULT;
>  
> -- 
> 2.33.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
