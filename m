Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E37AD42EDD0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Oct 2021 11:37:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237503AbhJOJjI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 Oct 2021 05:39:08 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:49824 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237498AbhJOJjI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 Oct 2021 05:39:08 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id C240721969;
        Fri, 15 Oct 2021 09:37:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1634290620; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=onDSwvGTB3TgysESEKqklGfD/ED0jggHJ/HrNAw4tuc=;
        b=FTqikspDerWEMsrzlrHlwQ6G9n2HJe0T2MJBHuPrv32HHiDPMEKWSUP7Asge4kX694j3aJ
        77PG5ggmaPQmbNVjI3OymoDoeICY4FuLYKQvMsx3rxJIyuGY/QinXIl2aEhsWt+R4sFkOT
        NFSszVquYOy+5bsxCcZIfgW6NNyf84A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1634290620;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=onDSwvGTB3TgysESEKqklGfD/ED0jggHJ/HrNAw4tuc=;
        b=mPfxxGjs+sYmlpJauaDnSFa+u7lSxEzQZRtA55szraSjABTJ8OTpONroz2QtT2Nct8npE1
        iNyTa7bXXdLDNwDg==
Received: from quack2.suse.cz (unknown [10.100.200.198])
        by relay2.suse.de (Postfix) with ESMTP id ADDC4A3B87;
        Fri, 15 Oct 2021 09:37:00 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 92F341E0A40; Fri, 15 Oct 2021 11:37:00 +0200 (CEST)
Date:   Fri, 15 Oct 2021 11:37:00 +0200
From:   Jan Kara <jack@suse.cz>
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     jack@suse.com, amir73il@gmail.com, djwong@kernel.org,
        tytso@mit.edu, dhowells@redhat.com, khazhy@google.com,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-api@vger.kernel.org, repnop@google.com, kernel@collabora.com,
        Jan Kara <jack@suse.cz>
Subject: Re: [PATCH v7 17/28] fanotify: Reserve UAPI bits for FAN_FS_ERROR
Message-ID: <20211015093700.GH23102@quack2.suse.cz>
References: <20211014213646.1139469-1-krisman@collabora.com>
 <20211014213646.1139469-18-krisman@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211014213646.1139469-18-krisman@collabora.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 14-10-21 18:36:35, Gabriel Krisman Bertazi wrote:
> FAN_FS_ERROR allows reporting of event type FS_ERROR to userspace, which
									^^
								missing 'is'

> a mechanism to report file system wide problems via fanotify.  This
> commit preallocate userspace visible bits to match the FS_ERROR event.
> 
> Reviewed-by: Jan Kara <jack@suse.cz>
> Reviewed-by: Amir Goldstein <amir73il@gmail.com>
> Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
> ---
>  fs/notify/fanotify/fanotify.c | 1 +
>  include/uapi/linux/fanotify.h | 1 +
>  2 files changed, 2 insertions(+)
> 
> diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotify.c
> index c64d61b673ca..8f152445d75c 100644
> --- a/fs/notify/fanotify/fanotify.c
> +++ b/fs/notify/fanotify/fanotify.c
> @@ -752,6 +752,7 @@ static int fanotify_handle_event(struct fsnotify_group *group, u32 mask,
>  	BUILD_BUG_ON(FAN_ONDIR != FS_ISDIR);
>  	BUILD_BUG_ON(FAN_OPEN_EXEC != FS_OPEN_EXEC);
>  	BUILD_BUG_ON(FAN_OPEN_EXEC_PERM != FS_OPEN_EXEC_PERM);
> +	BUILD_BUG_ON(FAN_FS_ERROR != FS_ERROR);
>  
>  	BUILD_BUG_ON(HWEIGHT32(ALL_FANOTIFY_EVENT_BITS) != 19);
>  
> diff --git a/include/uapi/linux/fanotify.h b/include/uapi/linux/fanotify.h
> index 64553df9d735..2990731ddc8b 100644
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
> 2.33.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
