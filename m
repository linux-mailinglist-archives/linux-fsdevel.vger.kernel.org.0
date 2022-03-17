Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 401A84DCA15
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Mar 2022 16:35:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235759AbiCQPgC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Mar 2022 11:36:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234055AbiCQPgB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Mar 2022 11:36:01 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 425B317ECFF
        for <linux-fsdevel@vger.kernel.org>; Thu, 17 Mar 2022 08:34:45 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id F27991F38D;
        Thu, 17 Mar 2022 15:34:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1647531283; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7RgZfjA58A/Gpo0urw+HucUe1bvmy37GMZuEnJjwAJc=;
        b=W80oqnJOYlVAnqSc4ZPn+i5roHFJtaZsLAtyl7WLne0Xlc/0NuaxysmDDXB6hGetGBnkYw
        /9GdkUg8wiZyZI36M91mFgT1zuTILbh48YZx2iqtf32PAs9gpUia7HzOWWZSZpAP/EVyY0
        UUuB9VgHbvQuKmfl0pSr4BhkwWf7+ZU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1647531284;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7RgZfjA58A/Gpo0urw+HucUe1bvmy37GMZuEnJjwAJc=;
        b=Mhn2DBP0Ek2U/+KYS5cndgVhq5K23wS1Bn0faO3eMECF6Sqv5UxKn6HjGgawMPaPwAw/lI
        Mmp25lXfp6Q/ffDQ==
Received: from quack3.suse.cz (unknown [10.100.200.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id DE905A3B88;
        Thu, 17 Mar 2022 15:34:43 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 7134FA0615; Thu, 17 Mar 2022 16:34:43 +0100 (CET)
Date:   Thu, 17 Mar 2022 16:34:43 +0100
From:   Jan Kara <jack@suse.cz>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jan Kara <jack@suse.cz>,
        Matthew Bobrowski <mbobrowski@mbobrowski.org>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 4/5] fanotify: add support for exclusive create of mark
Message-ID: <20220317153443.iy5rvns5nwxlxx43@quack3.lan>
References: <20220307155741.1352405-1-amir73il@gmail.com>
 <20220307155741.1352405-5-amir73il@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220307155741.1352405-5-amir73il@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon 07-03-22 17:57:40, Amir Goldstein wrote:
> Similar to inotify's IN_MARK_CREATE, adding an fanotify mark with flag
> FAN_MARK_CREATE will fail with error EEXIST if an fanotify mark already
> exists on the object.
> 
> Unlike inotify's IN_MARK_CREATE, FAN_MARK_CREATE has to supplied in
> combination with FAN_MARK_ADD (FAN_MARK_ADD is like inotify_add_watch()
> and the behavior of IN_MARK_ADD is the default for fanotify_mark()).
> 
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>

What I'm missing in this changelog is "why". Is it just about feature
parity with inotify? I don't find this feature particularly useful...

								Honza

> ---
>  fs/notify/fanotify/fanotify_user.c | 13 ++++++++++---
>  include/linux/fanotify.h           |  8 +++++---
>  include/uapi/linux/fanotify.h      |  1 +
>  3 files changed, 16 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
> index 9b32b76a9c30..99c5ced6abd8 100644
> --- a/fs/notify/fanotify/fanotify_user.c
> +++ b/fs/notify/fanotify/fanotify_user.c
> @@ -1185,6 +1185,9 @@ static int fanotify_add_mark(struct fsnotify_group *group,
>  			mutex_unlock(&group->mark_mutex);
>  			return PTR_ERR(fsn_mark);
>  		}
> +	} else if (flags & FAN_MARK_CREATE) {
> +		ret = -EEXIST;
> +		goto out;
>  	}
>  
>  	/*
> @@ -1510,6 +1513,7 @@ static int do_fanotify_mark(int fanotify_fd, unsigned int flags, __u64 mask,
>  	__kernel_fsid_t __fsid, *fsid = NULL;
>  	u32 valid_mask = FANOTIFY_EVENTS | FANOTIFY_EVENT_FLAGS;
>  	unsigned int mark_type = flags & FANOTIFY_MARK_TYPE_BITS;
> +	unsigned int mark_cmd = flags & FANOTIFY_MARK_CMD_BITS;
>  	bool ignored = flags & FAN_MARK_IGNORED_MASK;
>  	unsigned int obj_type, fid_mode;
>  	u32 umask = 0;
> @@ -1539,7 +1543,10 @@ static int do_fanotify_mark(int fanotify_fd, unsigned int flags, __u64 mask,
>  		return -EINVAL;
>  	}
>  
> -	switch (flags & (FAN_MARK_ADD | FAN_MARK_REMOVE | FAN_MARK_FLUSH)) {
> +	if (flags & FAN_MARK_CREATE && mark_cmd != FAN_MARK_ADD)
> +		return -EINVAL;
> +
> +	switch (mark_cmd) {
>  	case FAN_MARK_ADD:
>  	case FAN_MARK_REMOVE:
>  		if (!mask)
> @@ -1671,7 +1678,7 @@ static int do_fanotify_mark(int fanotify_fd, unsigned int flags, __u64 mask,
>  	}
>  
>  	/* create/update an inode mark */
> -	switch (flags & (FAN_MARK_ADD | FAN_MARK_REMOVE)) {
> +	switch (mark_cmd) {
>  	case FAN_MARK_ADD:
>  		if (mark_type == FAN_MARK_MOUNT)
>  			ret = fanotify_add_vfsmount_mark(group, mnt, mask,
> @@ -1749,7 +1756,7 @@ static int __init fanotify_user_setup(void)
>  
>  	BUILD_BUG_ON(FANOTIFY_INIT_FLAGS & FANOTIFY_INTERNAL_GROUP_FLAGS);
>  	BUILD_BUG_ON(HWEIGHT32(FANOTIFY_INIT_FLAGS) != 12);
> -	BUILD_BUG_ON(HWEIGHT32(FANOTIFY_MARK_FLAGS) != 9);
> +	BUILD_BUG_ON(HWEIGHT32(FANOTIFY_MARK_FLAGS) != 10);
>  
>  	fanotify_mark_cache = KMEM_CACHE(fsnotify_mark,
>  					 SLAB_PANIC|SLAB_ACCOUNT);
> diff --git a/include/linux/fanotify.h b/include/linux/fanotify.h
> index 419cadcd7ff5..780f4b17d4c9 100644
> --- a/include/linux/fanotify.h
> +++ b/include/linux/fanotify.h
> @@ -59,14 +59,16 @@
>  #define FANOTIFY_MARK_TYPE_BITS	(FAN_MARK_INODE | FAN_MARK_MOUNT | \
>  				 FAN_MARK_FILESYSTEM)
>  
> +#define FANOTIFY_MARK_CMD_BITS	(FAN_MARK_ADD | FAN_MARK_REMOVE | \
> +				 FAN_MARK_FLUSH)
> +
>  #define FANOTIFY_MARK_FLAGS	(FANOTIFY_MARK_TYPE_BITS | \
> -				 FAN_MARK_ADD | \
> -				 FAN_MARK_REMOVE | \
> +				 FANOTIFY_MARK_CMD_BITS | \
>  				 FAN_MARK_DONT_FOLLOW | \
>  				 FAN_MARK_ONLYDIR | \
>  				 FAN_MARK_IGNORED_MASK | \
>  				 FAN_MARK_IGNORED_SURV_MODIFY | \
> -				 FAN_MARK_FLUSH)
> +				 FAN_MARK_CREATE)
>  
>  /*
>   * Events that can be reported with data type FSNOTIFY_EVENT_PATH.
> diff --git a/include/uapi/linux/fanotify.h b/include/uapi/linux/fanotify.h
> index e8ac38cc2fd6..c41feac21fe9 100644
> --- a/include/uapi/linux/fanotify.h
> +++ b/include/uapi/linux/fanotify.h
> @@ -82,6 +82,7 @@
>  #define FAN_MARK_IGNORED_SURV_MODIFY	0x00000040
>  #define FAN_MARK_FLUSH		0x00000080
>  /* FAN_MARK_FILESYSTEM is	0x00000100 */
> +#define FAN_MARK_CREATE		0x00000200
>  
>  /* These are NOT bitwise flags.  Both bits can be used togther.  */
>  #define FAN_MARK_INODE		0x00000000
> -- 
> 2.25.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
