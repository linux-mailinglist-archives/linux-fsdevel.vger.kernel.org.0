Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 860343E10F2
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Aug 2021 11:14:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238677AbhHEJOY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 5 Aug 2021 05:14:24 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:50922 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236120AbhHEJOX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 5 Aug 2021 05:14:23 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 933481FE39;
        Thu,  5 Aug 2021 09:14:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1628154848; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VsbR3HyVbmX6IZMHVltdbFbiWBsYjbRdgHwKp+iIhfQ=;
        b=2C/qQ4YaE+e556sIlIV4g8jFb2rKAfBbwZmxVBW+FHF9LtkBC4ETy9OvyGSQ5tjt5efsVs
        M5eWu8oxJ6c9Ha046EOksppD6YRGETW2sAJJGDpl1xf7tLMZn6/LtNpqJ4BWvitkltmryP
        9D7wKXPubkUTBvXFQbmmHubcAB9u8Lo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1628154848;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VsbR3HyVbmX6IZMHVltdbFbiWBsYjbRdgHwKp+iIhfQ=;
        b=3MGMyUyEgUSAC+PIshpLX1vMPOlrMC9ZKenDTCu4mfbEaUuZ2ZQ/oXOzFD86i7p2q7RE2n
        9BabRlJRn9q9obBA==
Received: from quack2.suse.cz (unknown [10.163.43.118])
        by relay2.suse.de (Postfix) with ESMTP id 643C9A3B92;
        Thu,  5 Aug 2021 09:14:08 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 96B021E1514; Thu,  5 Aug 2021 11:14:07 +0200 (CEST)
Date:   Thu, 5 Aug 2021 11:14:07 +0200
From:   Jan Kara <jack@suse.cz>
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     jack@suse.com, amir73il@gmail.com, djwong@kernel.org,
        tytso@mit.edu, david@fromorbit.com, dhowells@redhat.com,
        khazhy@google.com, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-api@vger.kernel.org,
        kernel@collabora.com
Subject: Re: [PATCH v5 04/23] fsnotify: Reserve mark bits for backends
Message-ID: <20210805091407.GB14483@quack2.suse.cz>
References: <20210804160612.3575505-1-krisman@collabora.com>
 <20210804160612.3575505-5-krisman@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210804160612.3575505-5-krisman@collabora.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 04-08-21 12:05:53, Gabriel Krisman Bertazi wrote:
> Split out the final bits of struct fsnotify_mark->flags for use by a
> backend.
> 
> Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
> ---
>  include/linux/fsnotify_backend.h | 19 ++++++++++++++++---
>  1 file changed, 16 insertions(+), 3 deletions(-)
> 
> diff --git a/include/linux/fsnotify_backend.h b/include/linux/fsnotify_backend.h
> index 1ce66748a2d2..9d5586445c65 100644
> --- a/include/linux/fsnotify_backend.h
> +++ b/include/linux/fsnotify_backend.h
> @@ -363,6 +363,21 @@ struct fsnotify_mark_connector {
>  	struct hlist_head list;
>  };
>  
> +#define FSNOTIFY_MARK_FLAG(flag)	\
> +static const unsigned int FSNOTIFY_MARK_FLAG_##flag = \
> +	(1 << FSN_MARK_FL_BIT_##flag)

Static variable declaration in a header file makes me a bit uneasy. I know
it is const so a compiler should optimize this to a constant but still
there will likely be some side-effects (see the 0-day warning).

Honestly, given these are just three flags I'd just don't overengineer this
and have:

#define FSNOTIFY_MARK_FLAG_IGNORED_SURV_MODIFY \
			(1 << FSN_MARK_FL_BIT_IGNORED_SURV_MODIFY)
...

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
