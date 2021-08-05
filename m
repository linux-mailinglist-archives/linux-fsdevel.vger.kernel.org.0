Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98E6F3E12B8
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Aug 2021 12:34:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240462AbhHEKeO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 5 Aug 2021 06:34:14 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:39316 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240186AbhHEKeN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 5 Aug 2021 06:34:13 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 8CB52222B4;
        Thu,  5 Aug 2021 10:33:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1628159638; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=adROUKq92IsvQSYRmPn/0hXjN4bQ4KFVakONuasT8V4=;
        b=BJ0B3QuCU3jwgaqpIdUCjRNSZlZKmkVMPdOb8eqv6CFy41Xi4QD6d6zv1dYCzj5T373kf2
        mGxRoOjIWeHiqho3h9tcF8XtWRjFlDT/q9KdlyBV11lJyGGdwfnWQwcAAyRIPxdEjahYPO
        +MnTJuADW5xpEUdymx6dEhOp30mOKME=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1628159638;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=adROUKq92IsvQSYRmPn/0hXjN4bQ4KFVakONuasT8V4=;
        b=mDvTkBu7/1KnmjgTBTN50Zz84s3l/MI9154s2zbHxeZRea1GcQq0mcu/SOY/fEz873jYQA
        wGuxr/iYHDywUfDA==
Received: from quack2.suse.cz (unknown [10.163.43.118])
        by relay2.suse.de (Postfix) with ESMTP id 743CDA3B92;
        Thu,  5 Aug 2021 10:33:58 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 4EAEF1E1511; Thu,  5 Aug 2021 12:33:58 +0200 (CEST)
Date:   Thu, 5 Aug 2021 12:33:58 +0200
From:   Jan Kara <jack@suse.cz>
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     jack@suse.com, amir73il@gmail.com, djwong@kernel.org,
        tytso@mit.edu, david@fromorbit.com, dhowells@redhat.com,
        khazhy@google.com, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-api@vger.kernel.org,
        kernel@collabora.com
Subject: Re: [PATCH v5 16/23] fanotify: Reserve UAPI bits for FAN_FS_ERROR
Message-ID: <20210805103358.GI14483@quack2.suse.cz>
References: <20210804160612.3575505-1-krisman@collabora.com>
 <20210804160612.3575505-17-krisman@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210804160612.3575505-17-krisman@collabora.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 04-08-21 12:06:05, Gabriel Krisman Bertazi wrote:
> FAN_FS_ERROR allows reporting of event type FS_ERROR to userspace, which
> a mechanism to report file system wide problems via fanotify.  This
> commit preallocate userspace visible bits to match the FS_ERROR event.
> 
> Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/notify/fanotify/fanotify.c | 1 +
>  include/uapi/linux/fanotify.h | 1 +
>  2 files changed, 2 insertions(+)
> 
> diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotify.c
> index 456c60107d88..ca74199f11e2 100644
> --- a/fs/notify/fanotify/fanotify.c
> +++ b/fs/notify/fanotify/fanotify.c
> @@ -733,6 +733,7 @@ static int fanotify_handle_event(struct fsnotify_group *group, u32 mask,
>  	BUILD_BUG_ON(FAN_ONDIR != FS_ISDIR);
>  	BUILD_BUG_ON(FAN_OPEN_EXEC != FS_OPEN_EXEC);
>  	BUILD_BUG_ON(FAN_OPEN_EXEC_PERM != FS_OPEN_EXEC_PERM);
> +	BUILD_BUG_ON(FAN_FS_ERROR != FS_ERROR);
>  
>  	BUILD_BUG_ON(HWEIGHT32(ALL_FANOTIFY_EVENT_BITS) != 19);
>  
> diff --git a/include/uapi/linux/fanotify.h b/include/uapi/linux/fanotify.h
> index fbf9c5c7dd59..16402037fc7a 100644
> --- a/include/uapi/linux/fanotify.h
> +++ b/include/uapi/linux/fanotify.h
> @@ -20,6 +20,7 @@
>  #define FAN_OPEN_EXEC		0x00001000	/* File was opened for exec */
>  
>  #define FAN_Q_OVERFLOW		0x00004000	/* Event queued overflowed */
> +#define FAN_FS_ERROR		0x00008000	/* Filesystem error */
>  
>  #define FAN_OPEN_PERM		0x00010000	/* File open in perm check */
>  #define FAN_ACCESS_PERM		0x00020000	/* File accessed in perm check */
> -- 
> 2.32.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
