Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A4EA77F9AB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Aug 2023 16:51:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352280AbjHQOvB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Aug 2023 10:51:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352361AbjHQOuw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Aug 2023 10:50:52 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B05D6BF
        for <linux-fsdevel@vger.kernel.org>; Thu, 17 Aug 2023 07:50:50 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 717411F37E;
        Thu, 17 Aug 2023 14:50:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1692283849; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UD+LgMEblwafKP/DYOOxCK1O7QF3idHHEf5EI0i68eg=;
        b=EmtqjkAWo4RB0O+0Mg64R4BV1evXDnHRhN8HMp2YEvS/7Q6UuT6WlOJmrcQa0tDNhaoeNF
        HTKlmwkjmqe1h2pTGgMLr1XSrQEK+FtcZwy4pOq/7iigthon2+nRs/gPl3Lm0P1l0bmKOE
        o/VZuyLdetussEPqUcHb91SLIF/gn3Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1692283849;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UD+LgMEblwafKP/DYOOxCK1O7QF3idHHEf5EI0i68eg=;
        b=CuuE/qRpr8uIXCkgmoGmcKcVkyiVtCQ0um/nsyJYuxNKEKgGyReDjp1rpkHlE240MOhpVI
        Qa6u6xNbADzbHNDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 627E51392B;
        Thu, 17 Aug 2023 14:50:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id +wsIGMkz3mSXMgAAMHmgww
        (envelope-from <jack@suse.cz>); Thu, 17 Aug 2023 14:50:49 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id F08E2A0769; Thu, 17 Aug 2023 16:50:48 +0200 (CEST)
Date:   Thu, 17 Aug 2023 16:50:48 +0200
From:   Jan Kara <jack@suse.cz>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        Jens Axboe <axboe@kernel.dk>,
        Miklos Szeredi <miklos@szeredi.hu>,
        David Howells <dhowells@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v3 7/7] cachefiles: use kiocb_{start,end}_write() helpers
Message-ID: <20230817145048.5xyzskrdc2syv5cn@quack3>
References: <20230817141337.1025891-1-amir73il@gmail.com>
 <20230817141337.1025891-8-amir73il@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230817141337.1025891-8-amir73il@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 17-08-23 17:13:37, Amir Goldstein wrote:
> Use helpers instead of the open coded dance to silence lockdep warnings.
> 
> Suggested-by: Jan Kara <jack@suse.cz>
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/cachefiles/io.c | 16 +++-------------
>  1 file changed, 3 insertions(+), 13 deletions(-)
> 
> diff --git a/fs/cachefiles/io.c b/fs/cachefiles/io.c
> index 175a25fcade8..009d23cd435b 100644
> --- a/fs/cachefiles/io.c
> +++ b/fs/cachefiles/io.c
> @@ -259,9 +259,7 @@ static void cachefiles_write_complete(struct kiocb *iocb, long ret)
>  
>  	_enter("%ld", ret);
>  
> -	/* Tell lockdep we inherited freeze protection from submission thread */
> -	__sb_writers_acquired(inode->i_sb, SB_FREEZE_WRITE);
> -	__sb_end_write(inode->i_sb, SB_FREEZE_WRITE);
> +	kiocb_end_write(iocb);
>  
>  	if (ret < 0)
>  		trace_cachefiles_io_error(object, inode, ret,
> @@ -286,7 +284,6 @@ int __cachefiles_write(struct cachefiles_object *object,
>  {
>  	struct cachefiles_cache *cache;
>  	struct cachefiles_kiocb *ki;
> -	struct inode *inode;
>  	unsigned int old_nofs;
>  	ssize_t ret;
>  	size_t len = iov_iter_count(iter);
> @@ -322,19 +319,12 @@ int __cachefiles_write(struct cachefiles_object *object,
>  		ki->iocb.ki_complete = cachefiles_write_complete;
>  	atomic_long_add(ki->b_writing, &cache->b_writing);
>  
> -	/* Open-code file_start_write here to grab freeze protection, which
> -	 * will be released by another thread in aio_complete_rw().  Fool
> -	 * lockdep by telling it the lock got released so that it doesn't
> -	 * complain about the held lock when we return to userspace.
> -	 */
> -	inode = file_inode(file);
> -	__sb_start_write(inode->i_sb, SB_FREEZE_WRITE);
> -	__sb_writers_release(inode->i_sb, SB_FREEZE_WRITE);
> +	kiocb_start_write(&ki->iocb);
>  
>  	get_file(ki->iocb.ki_filp);
>  	cachefiles_grab_object(object, cachefiles_obj_get_ioreq);
>  
> -	trace_cachefiles_write(object, inode, ki->iocb.ki_pos, len);
> +	trace_cachefiles_write(object, file_inode(file), ki->iocb.ki_pos, len);
>  	old_nofs = memalloc_nofs_save();
>  	ret = cachefiles_inject_write_error();
>  	if (ret == 0)
> -- 
> 2.34.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
