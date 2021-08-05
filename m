Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E3203E113F
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Aug 2021 11:25:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232847AbhHEJZM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 5 Aug 2021 05:25:12 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:56048 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229913AbhHEJZM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 5 Aug 2021 05:25:12 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 807762222C;
        Thu,  5 Aug 2021 09:24:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1628155497; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TGHtlBNYtT3/EIdc/nUnEM5zo++9jfZgmXKW8x3uYPA=;
        b=SgKZY0xFBgH+0dMNb7JFTHQ0faCyKGWLpu3WQd0DGdaVJl5ooTsBJA9hSaU4u61ZR3FwsC
        xUDX1LbN25hTBKuLeaXBHFgyoqjq/vz/gs3lVUsU7jUlY0G6kzpcqUSi8t1YSwE2AUqu2e
        jAO53zwsXC+V76wTHCMn1kWUnUeZYBA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1628155497;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TGHtlBNYtT3/EIdc/nUnEM5zo++9jfZgmXKW8x3uYPA=;
        b=5cTWjrlN0oxetZkiT53nDyUD8xNAWJKYkjMB/ktHCvnS/89iY8UEMOAznxi/W9tsNEv0ki
        08BInzxEi4DPQvDg==
Received: from quack2.suse.cz (unknown [10.163.43.118])
        by relay2.suse.de (Postfix) with ESMTP id 64ACFA3B92;
        Thu,  5 Aug 2021 09:24:57 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 0D2F71E1514; Thu,  5 Aug 2021 11:24:57 +0200 (CEST)
Date:   Thu, 5 Aug 2021 11:24:57 +0200
From:   Jan Kara <jack@suse.cz>
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     jack@suse.com, amir73il@gmail.com, djwong@kernel.org,
        tytso@mit.edu, david@fromorbit.com, dhowells@redhat.com,
        khazhy@google.com, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-api@vger.kernel.org,
        kernel@collabora.com
Subject: Re: [PATCH v5 05/23] fanotify: Split superblock marks out to a new
 cache
Message-ID: <20210805092457.GC14483@quack2.suse.cz>
References: <20210804160612.3575505-1-krisman@collabora.com>
 <20210804160612.3575505-6-krisman@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210804160612.3575505-6-krisman@collabora.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 04-08-21 12:05:54, Gabriel Krisman Bertazi wrote:
> FAN_FS_ERROR will require an error structure to be stored per mark.
> But, since FAN_FS_ERROR doesn't apply to inode/mount marks, it should
> suffice to only expose this information for superblock marks. Therefore,
> wrap this kind of marks into a container and plumb it for the future.
> 
> Reviewed-by: Amir Goldstein <amir73il@gmail.com>
> Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>

Looks mostly good, just one nit below:

> @@ -915,6 +916,38 @@ static __u32 fanotify_mark_add_to_mask(struct fsnotify_mark *fsn_mark,
>  	return mask & ~oldmask;
>  }
>  
> +static struct fsnotify_mark *fanotify_alloc_mark(struct fsnotify_group *group,
> +						 unsigned int type)
> +{
> +	struct fanotify_sb_mark *sb_mark;
> +	struct fsnotify_mark *mark;
> +
> +	switch (type) {
> +	case FSNOTIFY_OBJ_TYPE_SB:
> +		sb_mark = kmem_cache_zalloc(fanotify_sb_mark_cache, GFP_KERNEL);
> +		if (!sb_mark)
> +			return NULL;
> +		mark = &sb_mark->fsn_mark;
> +		break;
> +
> +	case FSNOTIFY_OBJ_TYPE_INODE:
> +	case FSNOTIFY_OBJ_TYPE_PARENT:
> +	case FSNOTIFY_OBJ_TYPE_VFSMOUNT:
> +		mark = kmem_cache_alloc(fanotify_mark_cache, GFP_KERNEL);
> +		break;

It is odd that sb marks are allocated with zalloc while other marks with
alloc. Why is that? It is errorprone to have this different among mark
types as somebody may mistakenly assume a mark is zeroed when it actually is
not. So please either use kmem_cache_alloc() for sb mark as well and zero
out by hand what you need, or do a cleanup patch that uses zalloc across
all of dnotify, inotify, fanotify (I can see kernel/audit_* users already
use zalloc) and drop zeroing from fsnotify_init_mark(). Thanks!

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
