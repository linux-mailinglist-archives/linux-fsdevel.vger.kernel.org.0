Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F619518B84
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 May 2022 19:50:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240690AbiECRxn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 May 2022 13:53:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240680AbiECRxh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 May 2022 13:53:37 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84E3627B14
        for <linux-fsdevel@vger.kernel.org>; Tue,  3 May 2022 10:50:03 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id CDBCD210EE;
        Tue,  3 May 2022 17:50:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1651600201; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QtzZVVWSXLqnV9QgVFPZX5CBfn9z0T7hCbXiY5AUHcw=;
        b=0gL2JciDNFhVF0/c01ooJeIKmnGQI44uFvAqPo/3152Igu+Xv/jdnkP2aqfX4xjcRH8Bch
        +gIKYKMyElDrtL4gf2qPTSTiXip5AI/bxWWyb5I/bh6G4L8gqMjR9k34t/EGaG3hG8ExtH
        b+64YVySzMlxxX6n6vQb1kOyvnl9Ucs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1651600201;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QtzZVVWSXLqnV9QgVFPZX5CBfn9z0T7hCbXiY5AUHcw=;
        b=5nTk3IeaxUSiVFuK2p0rR8uCqorK9fGqPfHqZhXtjvO2NcONHdP0sLCFEverLz7ZIPxgo6
        dJEXZtEliUZiftBQ==
Received: from quack3.suse.cz (unknown [10.100.224.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id B76622C141;
        Tue,  3 May 2022 17:50:01 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 53D39A062A; Tue,  3 May 2022 19:49:58 +0200 (CEST)
Date:   Tue, 3 May 2022 19:49:58 +0200
From:   Jan Kara <jack@suse.cz>
To:     Jchao Sun <sunjunchao2870@gmail.com>
Cc:     linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk,
        jack@suse.cz
Subject: Re: [PATCH] Add assert for inode->i_io_list in
 inode_io_list_move_locked.
Message-ID: <20220503174958.ynxbvt7xsj7v72dg@quack3.lan>
References: <20220503100307.44303-1-sunjunchao2870@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220503100307.44303-1-sunjunchao2870@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue 03-05-22 03:03:07, Jchao Sun wrote:
> Cause of patch b35250c, inode->i_io_list will not only be protected by
> wb->list_lock, but also inode->i_lock. And in that patch, Added some assert
> for inode->i_lock in some functions except inode_io_list_move_locked.
> Should complete it to describe the semantics more clearly. Modified comment
> correspondingly.

I'd slightly rephrase the commit message and reference commit properly. Like:

Commit b35250c0816c ("writeback: Protect inode->i_io_list with inode->i_lock")
made inode->i_io_list not only protected by wb->list_lock but also
inode->i_lock. The commit also added some asserts for inode->i_lock but
inode_io_list_move_locked() was missed. Add assert there and also update
comment describing things protected by inode->i_lock.
                
Also please add

Fixes: b35250c0816c ("writeback: Protect inode->i_io_list with inode->i_lock")

tag.

> Signed-off-by: Jchao Sun <sunjunchao2870@gmail.com>

Otherwise a good catch. Thanks. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/fs-writeback.c | 1 +
>  fs/inode.c        | 2 +-
>  2 files changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
> index 591fe9cf1659..5a761b39f36c 100644
> --- a/fs/fs-writeback.c
> +++ b/fs/fs-writeback.c
> @@ -120,6 +120,7 @@ static bool inode_io_list_move_locked(struct inode *inode,
>  				      struct list_head *head)
>  {
>  	assert_spin_locked(&wb->list_lock);
> +	assert_spin_locked(&inode->i_lock);
>  
>  	list_move(&inode->i_io_list, head);
>  
> diff --git a/fs/inode.c b/fs/inode.c
> index 9d9b422504d1..bd4da9c5207e 100644
> --- a/fs/inode.c
> +++ b/fs/inode.c
> @@ -27,7 +27,7 @@
>   * Inode locking rules:
>   *
>   * inode->i_lock protects:
> - *   inode->i_state, inode->i_hash, __iget()
> + *   inode->i_state, inode->i_hash, __iget(), inode->i_io_list
>   * Inode LRU list locks protect:
>   *   inode->i_sb->s_inode_lru, inode->i_lru
>   * inode->i_sb->s_inode_list_lock protects:
> -- 
> 2.17.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
