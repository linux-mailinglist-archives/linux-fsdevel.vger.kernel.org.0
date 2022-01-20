Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C833494E74
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Jan 2022 13:57:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243817AbiATM5r (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 Jan 2022 07:57:47 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:41688 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239164AbiATM5r (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 Jan 2022 07:57:47 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 0C7511F3AA;
        Thu, 20 Jan 2022 12:57:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1642683466; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YMMjYEG0Y0nE2gvxBL0+Nw0acduELSURUuZFPQ/x55Q=;
        b=0ZOKOZKLG2cZ3XSGmfd5Bov7SBFHth7ser4occYtJKOU8MInVtqY8aMgOeoJayAGqhLYwp
        VGRLck5JmDbNmRmnEmELv/N+h8uCCWo55qAVI1A2CXhpuCICGe7xL95pkwrQEgQ3o0CWn8
        Zf6X6gAS3gvcnsHMDa5flPCUwf4etUM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1642683466;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YMMjYEG0Y0nE2gvxBL0+Nw0acduELSURUuZFPQ/x55Q=;
        b=E4SMuZ4WknAmHiuW47w6AUYFkdy/i0QJ6dVlvHOQ2u1/vzdmyqXWaXEr4PiJiliJPqJmZP
        LWGTRCbvLPu8yQAw==
Received: from quack3.suse.cz (unknown [10.100.200.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id D2F36A3B83;
        Thu, 20 Jan 2022 12:57:45 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 886C5A05D9; Thu, 20 Jan 2022 13:57:45 +0100 (CET)
Date:   Thu, 20 Jan 2022 13:57:45 +0100
From:   Jan Kara <jack@suse.cz>
To:     Yang Li <yang.lee@linux.alibaba.com>
Cc:     jack@suse.cz, amir73il@gmail.com, repnop@google.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: Re: [PATCH -next] fanotify: remove variable set but not used
Message-ID: <20220120125745.axdqtnasbivkulsm@quack3.lan>
References: <20220112085403.74670-1-yang.lee@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220112085403.74670-1-yang.lee@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 12-01-22 16:54:03, Yang Li wrote:
> The code that uses the pointer info has been removed in
> 'https://lore.kernel.org/all/20211129201537.1932819-11-amir73il@gmail.com/'
> and fanotify_event_info() doesn't change 'event', so the declaration and 
> assignment of info can be removed.
> 
> Eliminate the following clang warning:
> fs/notify/fanotify/fanotify_user.c:161:24: warning: variable ‘info’ set
> but not used
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>

Thanks! I've added the patch to my tree.

								Honza

> ---
>  fs/notify/fanotify/fanotify_user.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
> index 73b1615f9d96..1026f67b1d1e 100644
> --- a/fs/notify/fanotify/fanotify_user.c
> +++ b/fs/notify/fanotify/fanotify_user.c
> @@ -158,7 +158,6 @@ static size_t fanotify_event_len(unsigned int info_mode,
>  				 struct fanotify_event *event)
>  {
>  	size_t event_len = FAN_EVENT_METADATA_LEN;
> -	struct fanotify_info *info;
>  	int fh_len;
>  	int dot_len = 0;
>  
> @@ -168,8 +167,6 @@ static size_t fanotify_event_len(unsigned int info_mode,
>  	if (fanotify_is_error_event(event->mask))
>  		event_len += FANOTIFY_ERROR_INFO_LEN;
>  
> -	info = fanotify_event_info(event);
> -
>  	if (fanotify_event_has_any_dir_fh(event)) {
>  		event_len += fanotify_dir_name_info_len(event);
>  	} else if ((info_mode & FAN_REPORT_NAME) &&
> -- 
> 2.20.1.7.g153144c
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
