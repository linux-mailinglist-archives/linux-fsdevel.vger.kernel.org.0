Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A3DF43388C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Oct 2021 16:41:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229782AbhJSOna (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Oct 2021 10:43:30 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:35156 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbhJSOn3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Oct 2021 10:43:29 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 0EDA81F782;
        Tue, 19 Oct 2021 14:41:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1634654475; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FOGSHk2VOApH2+KCtBYsFzwzfXmho1mXCw0bshaMDUw=;
        b=Djme+D2Ne9seqbevUDtBReBcYlJAwVN5e1wMmRpp0z0hQ/mkOUV46k/y9e4KMJhTPxfhJy
        iDhokmCjgxLzMTvdC3QkJYUKeyHkA/VPJllgsyY7UaUlbEjTMK/R5A2NrlKDiYYB03/vKB
        zcsFPsE+Zwl/Urj0cVVod4QikhY5Z+0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1634654475;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FOGSHk2VOApH2+KCtBYsFzwzfXmho1mXCw0bshaMDUw=;
        b=cGJhFSNDT0gHqpzVXFZV+szKID6JeNwOxZEFim7TprVkUsP6Nc5bWFGb47hBvBO7YNvzt5
        KI8gUvF2Bl47aHCA==
Received: from quack2.suse.cz (unknown [10.100.200.198])
        by relay2.suse.de (Postfix) with ESMTP id E15BEA3B81;
        Tue, 19 Oct 2021 14:41:14 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id BF9D01E0983; Tue, 19 Oct 2021 16:41:14 +0200 (CEST)
Date:   Tue, 19 Oct 2021 16:41:14 +0200
From:   Jan Kara <jack@suse.cz>
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     jack@suse.com, amir73il@gmail.com, djwong@kernel.org,
        tytso@mit.edu, david@fromorbit.com, dhowells@redhat.com,
        khazhy@google.com, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-api@vger.kernel.org,
        kernel@collabora.com
Subject: Re: [PATCH v8 27/32] fanotify: Report fid info for file related file
 system errors
Message-ID: <20211019144114.GP3255@quack2.suse.cz>
References: <20211019000015.1666608-1-krisman@collabora.com>
 <20211019000015.1666608-28-krisman@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211019000015.1666608-28-krisman@collabora.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon 18-10-21 21:00:10, Gabriel Krisman Bertazi wrote:
> Plumb the pieces to add a FID report to error records.  Since all error
> event memory must be pre-allocated, we pre-allocate the maximum file
> handle size possible, such that it should always fit.
> 
> For errors that don't expose a file handle report it with an invalid
> FID.
> 
> Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>

...

> diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotify.c
> index 45df610debbe..335ce8f88eb8 100644
> --- a/fs/notify/fanotify/fanotify.c
> +++ b/fs/notify/fanotify/fanotify.c
> @@ -609,7 +609,9 @@ static struct fanotify_event *fanotify_alloc_error_event(
>  {
>  	struct fs_error_report *report =
>  			fsnotify_data_error_report(data, data_type);
> +	struct inode *inode = report->inode;
>  	struct fanotify_error_event *fee;
> +	int fh_len;
>  
>  	if (WARN_ON_ONCE(!report))
>  		return NULL;

This WARN_ON_ONCE is now pointless since you dereference report->inode
above... So I guess move the dereference after WARN?

> @@ -267,6 +274,10 @@ static inline int fanotify_event_dir_fh_len(struct fanotify_event *event)
>  
>  static inline bool fanotify_event_has_object_fh(struct fanotify_event *event)
>  {
> +
> +	/* For error events, even zeroed fh are reported. */
> +	if (event->type == FANOTIFY_EVENT_TYPE_FS_ERROR)
> +		return true;
>  	if (fanotify_event_object_fh_len(event) > 0)
>  		return true;

This hunk belongs into patch 25. With these fixed feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
