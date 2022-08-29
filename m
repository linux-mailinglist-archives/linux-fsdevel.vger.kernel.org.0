Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B67DD5A4EF2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Aug 2022 16:15:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230259AbiH2OP0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 29 Aug 2022 10:15:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229980AbiH2OPZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 29 Aug 2022 10:15:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73B7A1A39E;
        Mon, 29 Aug 2022 07:15:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0F36E60F5B;
        Mon, 29 Aug 2022 14:15:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 058FDC433C1;
        Mon, 29 Aug 2022 14:15:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661782522;
        bh=+nyYdh/yy5EHKyi0lpYY9d3e+x1/y1ayeGH6tnploAE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oczrsAAZRB7+HuHkBHmMN1BZNstE3epijQo1SngzYh79jhWGVjXhYhoODnqaZj5rd
         EMofYuKj0e/AkGWSwnUBefQ+SL9FTIXG5O7Ra/XhtTL272P4t44tPus4lBzW/6Pd55
         IBtOa+iVodOoAaKqgVW7tFxJpi6ULCiHjlUISiRayaUU9mwuoRzLAbwEsBqnXFnhDc
         mLjLOGvOfc30vZ50DtGmdmVZumM6y5r9WTQcn1sQwFZnCWhNBKwxQfYvuvgtGfSEU1
         Jt4Tt1ZyfJUaEyDJaeOSLCSJJg90Xxd6hxx4DVhg4IrWilJsmKf5XLeCxEwRcEq114
         sXfWLkU9sFcJg==
Date:   Mon, 29 Aug 2022 16:15:17 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Alexey Khoroshilov <khoroshilov@ispras.ru>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Rustam Subkhankulov <subkhankulov@ispras.ru>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        ldv-project@linuxtesting.org
Subject: Re: [PATCH] fs/inode.c: change the order of initialization in
 inode_init_always()
Message-ID: <20220829141517.bcjbdk5zb74mrhgu@wittgenstein>
References: <1661609366-26144-1-git-send-email-khoroshilov@ispras.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1661609366-26144-1-git-send-email-khoroshilov@ispras.ru>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Aug 27, 2022 at 05:09:26PM +0300, Alexey Khoroshilov wrote:
> From: Rustam Subkhankulov <subkhankulov@ispras.ru>
> 
> If function 'security_inode_alloc()' returns a nonzero value at
> [fs/inode.c: 195] due to an error (e.g. fail to allocate memory),
> then some of the fields, including 'i_private', will not be
> initialized.
> 
> After that, if the fs-specfic free_inode function is called in
> 'i_callback', the nonzero value of 'i_private' field can be interpreted
> as initialized. As a result, this can cause dereferencing of random
> value pointer (e.g. nilfs2).
> 
> In earlier versions, a similar situation could occur with the 'u' union
> in 'inode' structure.
> 
> Found by Linux Verification Center (linuxtesting.org) with syzkaller.
> 
> Signed-off-by: Rustam Subkhankulov <subkhankulov@ispras.ru>
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> ---
>  fs/inode.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/inode.c b/fs/inode.c
> index bd4da9c5207e..08d093737e8c 100644
> --- a/fs/inode.c
> +++ b/fs/inode.c
> @@ -192,8 +192,6 @@ int inode_init_always(struct super_block *sb, struct inode *inode)
>  	inode->i_wb_frn_history = 0;
>  #endif
>  
> -	if (security_inode_alloc(inode))
> -		goto out;
>  	spin_lock_init(&inode->i_lock);
>  	lockdep_set_class(&inode->i_lock, &sb->s_type->i_lock_key);
>  
> @@ -230,9 +228,10 @@ int inode_init_always(struct super_block *sb, struct inode *inode)
>  	inode->i_flctx = NULL;
>  	this_cpu_inc(nr_inodes);
>  
> +	if (security_inode_alloc(inode))
> +		return -ENOMEM;

This should probably be before this_cpu_inc(nr_inodes).
