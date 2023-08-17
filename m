Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3161E77F9A8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Aug 2023 16:51:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352292AbjHQOu3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Aug 2023 10:50:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352293AbjHQOuE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Aug 2023 10:50:04 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBB7E2D74
        for <linux-fsdevel@vger.kernel.org>; Thu, 17 Aug 2023 07:50:01 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 8B0DF1F385;
        Thu, 17 Aug 2023 14:50:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1692283800; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kOusFET1pGcwwPhWoAIsQfHULtqFgZZ2BHeeYbbP4LA=;
        b=MRtJmVvz7ipYurTTiw4lM0c3Vh/7VE9j8mmxn9sE4olBgdZ3lirn3HUmIJkwq9H5azkBgx
        jilrd4RGzsIezV2bRJbyR8yETAQbp3CXo4o9hZoxVZDB25lzd6q/UH/hJe+BZ2Fdzpze78
        yaMskQuqI8iIks9U43Qj4HoI+uUffQw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1692283800;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kOusFET1pGcwwPhWoAIsQfHULtqFgZZ2BHeeYbbP4LA=;
        b=PZF0yunzl2pB4VAG3uMWLY9qqykF/IUHthQIcHprB9bPHmrfF7CvNNe042jiYXmqMBCKQn
        zydLGgdM5pJk3KBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7A90A1392B;
        Thu, 17 Aug 2023 14:50:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 8ULpHZgz3mTdMQAAMHmgww
        (envelope-from <jack@suse.cz>); Thu, 17 Aug 2023 14:50:00 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id DCA4AA0769; Thu, 17 Aug 2023 16:49:59 +0200 (CEST)
Date:   Thu, 17 Aug 2023 16:49:59 +0200
From:   Jan Kara <jack@suse.cz>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        Jens Axboe <axboe@kernel.dk>,
        Miklos Szeredi <miklos@szeredi.hu>,
        David Howells <dhowells@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v3 6/7] ovl: use kiocb_{start,end}_write() helpers
Message-ID: <20230817144959.cvmdcstnzuwangi4@quack3>
References: <20230817141337.1025891-1-amir73il@gmail.com>
 <20230817141337.1025891-7-amir73il@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230817141337.1025891-7-amir73il@gmail.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 17-08-23 17:13:36, Amir Goldstein wrote:
> Use helpers instead of the open coded dance to silence lockdep warnings.
> 
> Suggested-by: Jan Kara <jack@suse.cz>
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/overlayfs/file.c | 10 ++--------
>  1 file changed, 2 insertions(+), 8 deletions(-)
> 
> diff --git a/fs/overlayfs/file.c b/fs/overlayfs/file.c
> index 21245b00722a..e4cc401d334d 100644
> --- a/fs/overlayfs/file.c
> +++ b/fs/overlayfs/file.c
> @@ -290,10 +290,7 @@ static void ovl_aio_cleanup_handler(struct ovl_aio_req *aio_req)
>  	if (iocb->ki_flags & IOCB_WRITE) {
>  		struct inode *inode = file_inode(orig_iocb->ki_filp);
>  
> -		/* Actually acquired in ovl_write_iter() */
> -		__sb_writers_acquired(file_inode(iocb->ki_filp)->i_sb,
> -				      SB_FREEZE_WRITE);
> -		file_end_write(iocb->ki_filp);
> +		kiocb_end_write(iocb);
>  		ovl_copyattr(inode);
>  	}
>  
> @@ -409,10 +406,6 @@ static ssize_t ovl_write_iter(struct kiocb *iocb, struct iov_iter *iter)
>  		if (!aio_req)
>  			goto out;
>  
> -		file_start_write(real.file);
> -		/* Pacify lockdep, same trick as done in aio_write() */
> -		__sb_writers_release(file_inode(real.file)->i_sb,
> -				     SB_FREEZE_WRITE);
>  		aio_req->fd = real;
>  		real.flags = 0;
>  		aio_req->orig_iocb = iocb;
> @@ -420,6 +413,7 @@ static ssize_t ovl_write_iter(struct kiocb *iocb, struct iov_iter *iter)
>  		aio_req->iocb.ki_flags = ifl;
>  		aio_req->iocb.ki_complete = ovl_aio_rw_complete;
>  		refcount_set(&aio_req->ref, 2);
> +		kiocb_start_write(&aio_req->iocb);
>  		ret = vfs_iocb_iter_write(real.file, &aio_req->iocb, iter);
>  		ovl_aio_put(aio_req);
>  		if (ret != -EIOCBQUEUED)
> -- 
> 2.34.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
