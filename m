Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B60C76D41E7
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Apr 2023 12:24:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231925AbjDCKX7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 3 Apr 2023 06:23:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231852AbjDCKX5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 3 Apr 2023 06:23:57 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA91E212B
        for <linux-fsdevel@vger.kernel.org>; Mon,  3 Apr 2023 03:23:56 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id AB28B21AB4;
        Mon,  3 Apr 2023 10:23:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1680517435; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7L4iCu8UDKsr3R80mYIINoq3rDNNc4DxoBUxCYPGwho=;
        b=Y6qnWkatcA4T5d84MhS9mbD+PceKfO5nwiBOv3sC9oqO60kilGP2h0Uk97sFXpEWj2q6+S
        A7ShcbLQUvroC5O7VUyBJ2wgAOq3Ab34y8z4oLnCv8TCzIhUc6z8lL7B0r+VHnZFg9aCy8
        S6guGXHa593ZbNSNspKWkve2XSxYmvY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1680517435;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7L4iCu8UDKsr3R80mYIINoq3rDNNc4DxoBUxCYPGwho=;
        b=II11lOigKOGJf+Miarb2cKhTFRmPSInyNAH/JrfBdJvcnRRksQnpE2fHTvXVZvUh2kotiu
        4tezM4Rn8xDQdlCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 979151331A;
        Mon,  3 Apr 2023 10:23:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 4X/+JDupKmQcBAAAMHmgww
        (envelope-from <jack@suse.cz>); Mon, 03 Apr 2023 10:23:55 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id E16A4A0723; Mon,  3 Apr 2023 12:23:54 +0200 (CEST)
Date:   Mon, 3 Apr 2023 12:23:54 +0200
From:   Jan Kara <jack@suse.cz>
To:     cem@kernel.org
Cc:     hughd@google.com, jack@suse.cz, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, djwong@kernel.org
Subject: Re: [PATCH 2/6] shmem: make shmem_get_inode() return ERR_PTR instead
 of NULL
Message-ID: <20230403102354.jnwrqdbhpysttkxm@quack3>
References: <20230403084759.884681-1-cem@kernel.org>
 <20230403084759.884681-3-cem@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230403084759.884681-3-cem@kernel.org>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon 03-04-23 10:47:55, cem@kernel.org wrote:
> From: Lukas Czerner <lczerner@redhat.com>
> 
> Make shmem_get_inode() return ERR_PTR instead of NULL on error. This will be
> useful later when we introduce quota support.
> 
> There should be no functional change.
> 
> Signed-off-by: Lukas Czerner <lczerner@redhat.com>
> Signed-off-by: Carlos Maiolino <cmaiolino@redhat.com>

One comment below:

> @@ -2958,21 +2967,24 @@ shmem_tmpfile(struct mnt_idmap *idmap, struct inode *dir,
>  	      struct file *file, umode_t mode)
>  {
>  	struct inode *inode;
> -	int error = -ENOSPC;
> +	int error;
>  
>  	inode = shmem_get_inode(idmap, dir->i_sb, dir, mode, 0, VM_NORESERVE);
> -	if (inode) {
> -		error = security_inode_init_security(inode, dir,
> -						     NULL,
> -						     shmem_initxattrs, NULL);
> -		if (error && error != -EOPNOTSUPP)
> -			goto out_iput;
> -		error = simple_acl_create(dir, inode);
> -		if (error)
> -			goto out_iput;
> -		d_tmpfile(file, inode);
> -	}
> +
> +	if (IS_ERR(inode))
> +		return PTR_ERR(inode);

This doesn't look correct. Previously, we've called
finish_open_simple(file, error), now you just return error... Otherwise the
patch looks good to me.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
