Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E6EE51C416
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 May 2022 17:40:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359305AbiEEPoJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 5 May 2022 11:44:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344423AbiEEPoG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 5 May 2022 11:44:06 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36B7B532C0;
        Thu,  5 May 2022 08:40:26 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id E8937219A6;
        Thu,  5 May 2022 15:40:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1651765224; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KpNChwSjUc7RiYYcpVZmbJ+8eaBDtjhqDZRBxEQzGqw=;
        b=VGRIP6k3SOBgUQUF5sUlZXUK09JlAriC3EaR6iT2ovje3lx45O55tdS64bKReMAAoocKmZ
        SLdk9B+uNUEfGXyteQaUPDYeTxySiJa4oM1VNit/XoZ1fcblaE6bnzZODw8t4i2JhXLWtd
        xsznA5Ph7ZC2ZVhxBBPVnLqDtRAtbWk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1651765224;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KpNChwSjUc7RiYYcpVZmbJ+8eaBDtjhqDZRBxEQzGqw=;
        b=I8b3F5BuEeCjbDPbDnUc0SYVNp6vb4Uk4GGAJMzwSIrVAUYDyIxRZlgAbdXYGZbDMQ0kpc
        9/uOUGllUbzFpgDw==
Received: from quack3.suse.cz (unknown [10.100.224.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id AF8AB2C145;
        Thu,  5 May 2022 15:40:24 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 63322A0627; Thu,  5 May 2022 17:40:24 +0200 (CEST)
Date:   Thu, 5 May 2022 17:40:24 +0200
From:   Jan Kara <jack@suse.cz>
To:     Jing Xia <jing.xia@unisoc.com>
Cc:     viro@zeniv.linux.org.uk, jack@suse.cz, jing.xia.mail@gmail.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] writeback: Avoid skipping inode writeback
Message-ID: <20220505154024.onreajr4xmtsswes@quack3.lan>
References: <20220505134731.5295-1-jing.xia@unisoc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220505134731.5295-1-jing.xia@unisoc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 05-05-22 21:47:31, Jing Xia wrote:
> We have run into an issue that a task gets stuck in
> balance_dirty_pages_ratelimited() when perform I/O stress testing.
> The reason we observed is that an I_DIRTY_PAGES inode with lots
> of dirty pages is in b_dirty_time list and standard background
> writeback cannot writeback the inode.
> After studing the relevant code, the following scenario may lead
> to the issue:
> 
> task1                                   task2
> -----                                   -----
> fuse_flush
>  write_inode_now //in b_dirty_time
>   writeback_single_inode
>    __writeback_single_inode
>                                  fuse_write_end
>                                   filemap_dirty_folio
>                                    __xa_set_mark:PAGECACHE_TAG_DIRTY
>     lock inode->i_lock
>     if mapping tagged PAGECACHE_TAG_DIRTY
>     inode->i_state |= I_DIRTY_PAGES
>     unlock inode->i_lock
>                                    __mark_inode_dirty:I_DIRTY_PAGES
>                                       lock inode->i_lock
>                                       -was dirty,inode stays in
>                                       -b_dirty_time
>                                       unlock inode->i_lock
> 
>    if(!(inode->i_state & I_DIRTY_All))
>       -not true,so nothing done
> 
> This patch moves the dirty inode to b_dirty list when the inode
> currently is not queued in b_io or b_more_io list at the end of
> writeback_single_inode.
> 
> Signed-off-by: Jing Xia <jing.xia@unisoc.com>

Thanks for report and the fix! The patch looks good so feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

Also please add tags:

CC: stable@vger.kernel.org
Fixes: 0ae45f63d4ef ("vfs: add support for a lazytime mount option")

Thanks.
								Honza

> diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
> index 591fe9cf1659..d7763feaf14a 100644
> --- a/fs/fs-writeback.c
> +++ b/fs/fs-writeback.c
> @@ -1712,6 +1712,9 @@ static int writeback_single_inode(struct inode *inode,
>  	 */
>  	if (!(inode->i_state & I_DIRTY_ALL))
>  		inode_cgwb_move_to_attached(inode, wb);
> +	else if (!(inode->i_state & I_SYNC_QUEUED) && (inode->i_state & I_DIRTY))
> +		redirty_tail_locked(inode, wb);
> +
>  	spin_unlock(&wb->list_lock);
>  	inode_sync_complete(inode);
>  out:
> -- 
> 2.17.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
