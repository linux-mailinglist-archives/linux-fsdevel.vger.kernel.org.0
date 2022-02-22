Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 350BC4BF5C1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Feb 2022 11:27:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230522AbiBVK1z (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Feb 2022 05:27:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229613AbiBVK1y (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Feb 2022 05:27:54 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 633FA148917;
        Tue, 22 Feb 2022 02:27:29 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 1B4551F397;
        Tue, 22 Feb 2022 10:27:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1645525648; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kivNo8O9f0xYdBqHOtHR3oHQM1HkqlcvyLe3qAUWobY=;
        b=OD3gFnKo7vYSPf0M6Q5CNxsfzibqhnX4oBnpSLy2F73DdB4ifZmFeLOHzvIxpCmVmlf4lt
        sUHHaFa+CtBDX6blVzU5QkaXCdpny30+e9IA0d7v+vg5ygQoEStTbM/leiuFymCkWLLUSC
        cco/yI4FRUSM/SAvtCEnRBBQ26TtTzM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1645525648;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kivNo8O9f0xYdBqHOtHR3oHQM1HkqlcvyLe3qAUWobY=;
        b=G9Z0zmq5ir/7qZPyQYVxgNCfrAofxXD+88eqbF9cKeLcTgtSjsn5IOEAIc2P2/I6wThVq9
        Ow06trvVykuB6sDg==
Received: from quack3.suse.cz (unknown [10.100.200.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 0BF51A3B84;
        Tue, 22 Feb 2022 10:27:28 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id C19D0A0606; Tue, 22 Feb 2022 11:27:27 +0100 (CET)
Date:   Tue, 22 Feb 2022 11:27:27 +0100
From:   Jan Kara <jack@suse.cz>
To:     Edward Shishkin <edward.shishkin@gmail.com>
Cc:     willy@infradead.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, reiserfs-devel@vger.kernel.org,
        jack@suse.cz
Subject: Re: [PATCH] reiserfs: get rid of AOP_FLAG_CONT_EXPAND flag
Message-ID: <20220222102727.2sqf4wfdtjaxrqat@quack3.lan>
References: <fbc744c9-e22f-138c-2da3-f76c3edfcc3d@gmail.com>
 <20220220232219.1235-1-edward.shishkin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220220232219.1235-1-edward.shishkin@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon 21-02-22 00:22:19, Edward Shishkin wrote:
> Signed-off-by: Edward Shishkin <edward.shishkin@gmail.com>
> ---
>  fs/reiserfs/inode.c | 16 +++++-----------
>  1 file changed, 5 insertions(+), 11 deletions(-)

Thanks! I have queued this patch into my tree.

								Honza

> 
> diff --git a/fs/reiserfs/inode.c b/fs/reiserfs/inode.c
> index f49b72ccac4c..e943930939f5 100644
> --- a/fs/reiserfs/inode.c
> +++ b/fs/reiserfs/inode.c
> @@ -2763,13 +2763,6 @@ static int reiserfs_write_begin(struct file *file,
>  	int old_ref = 0;
>  
>   	inode = mapping->host;
> -	*fsdata = NULL;
> - 	if (flags & AOP_FLAG_CONT_EXPAND &&
> - 	    (pos & (inode->i_sb->s_blocksize - 1)) == 0) {
> - 		pos ++;
> -		*fsdata = (void *)(unsigned long)flags;
> -	}
> -
>  	index = pos >> PAGE_SHIFT;
>  	page = grab_cache_page_write_begin(mapping, index, flags);
>  	if (!page)
> @@ -2896,9 +2889,6 @@ static int reiserfs_write_end(struct file *file, struct address_space *mapping,
>  	unsigned start;
>  	bool locked = false;
>  
> -	if ((unsigned long)fsdata & AOP_FLAG_CONT_EXPAND)
> -		pos ++;
> -
>  	reiserfs_wait_on_write_block(inode->i_sb);
>  	if (reiserfs_transaction_running(inode->i_sb))
>  		th = current->journal_info;
> @@ -3316,7 +3306,11 @@ int reiserfs_setattr(struct user_namespace *mnt_userns, struct dentry *dentry,
>  
>  		/* fill in hole pointers in the expanding truncate case. */
>  		if (attr->ia_size > inode->i_size) {
> -			error = generic_cont_expand_simple(inode, attr->ia_size);
> +			loff_t pos = attr->ia_size;
> +
> +			if ((pos & (inode->i_sb->s_blocksize - 1)) == 0)
> +				pos++;
> +			error = generic_cont_expand_simple(inode, pos);
>  			if (REISERFS_I(inode)->i_prealloc_count > 0) {
>  				int err;
>  				struct reiserfs_transaction_handle th;
> -- 
> 2.21.3
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
