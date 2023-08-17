Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D41D77F9A2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Aug 2023 16:49:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352255AbjHQOtZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Aug 2023 10:49:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352332AbjHQOtA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Aug 2023 10:49:00 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAC7794
        for <linux-fsdevel@vger.kernel.org>; Thu, 17 Aug 2023 07:48:59 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 94F3A1F385;
        Thu, 17 Aug 2023 14:48:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1692283738; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yTRPgFjE0o7Gc06Hn8Mhf7rez2rE0ckIDKNZDViVbJI=;
        b=o6nfLcbOHmUYt2YbPEQud0bk7491TW5ROSjG5xuqMzOFLWkN3OXEhp8M7JqBcSFVng/+v9
        SdnePN7DhO89Y5Mo2MKsbOvbFtbqa5motyy2I8oZAcgE2I9tspPZNYoifuySx8KvDjRYlE
        xPsUR06xctuqe0pbg4apFsURz9jcecQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1692283738;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yTRPgFjE0o7Gc06Hn8Mhf7rez2rE0ckIDKNZDViVbJI=;
        b=X7dqhlHGryx4/D2a91IHBiaAULMhoe1NG9xRyhSp/sFzJdMu2QZO+jvjAu2pK+GuRnP+8t
        gQ/sNCvf/MpAteBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7C9061392B;
        Thu, 17 Aug 2023 14:48:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id swxnHloz3mQdMQAAMHmgww
        (envelope-from <jack@suse.cz>); Thu, 17 Aug 2023 14:48:58 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 1470BA0769; Thu, 17 Aug 2023 16:48:58 +0200 (CEST)
Date:   Thu, 17 Aug 2023 16:48:58 +0200
From:   Jan Kara <jack@suse.cz>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        Jens Axboe <axboe@kernel.dk>,
        Miklos Szeredi <miklos@szeredi.hu>,
        David Howells <dhowells@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v3 5/7] aio: use kiocb_{start,end}_write() helpers
Message-ID: <20230817144858.tgvrsr6iefeelibf@quack3>
References: <20230817141337.1025891-1-amir73il@gmail.com>
 <20230817141337.1025891-6-amir73il@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230817141337.1025891-6-amir73il@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 17-08-23 17:13:35, Amir Goldstein wrote:
> Use helpers instead of the open coded dance to silence lockdep warnings.
> 
> Suggested-by: Jan Kara <jack@suse.cz>
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/aio.c | 20 +++-----------------
>  1 file changed, 3 insertions(+), 17 deletions(-)
> 
> diff --git a/fs/aio.c b/fs/aio.c
> index 77e33619de40..b3174da80ff6 100644
> --- a/fs/aio.c
> +++ b/fs/aio.c
> @@ -1447,13 +1447,8 @@ static void aio_complete_rw(struct kiocb *kiocb, long res)
>  	if (kiocb->ki_flags & IOCB_WRITE) {
>  		struct inode *inode = file_inode(kiocb->ki_filp);
>  
> -		/*
> -		 * Tell lockdep we inherited freeze protection from submission
> -		 * thread.
> -		 */
>  		if (S_ISREG(inode->i_mode))
> -			__sb_writers_acquired(inode->i_sb, SB_FREEZE_WRITE);
> -		file_end_write(kiocb->ki_filp);
> +			kiocb_end_write(kiocb);
>  	}
>  
>  	iocb->ki_res.res = res;
> @@ -1581,17 +1576,8 @@ static int aio_write(struct kiocb *req, const struct iocb *iocb,
>  		return ret;
>  	ret = rw_verify_area(WRITE, file, &req->ki_pos, iov_iter_count(&iter));
>  	if (!ret) {
> -		/*
> -		 * Open-code file_start_write here to grab freeze protection,
> -		 * which will be released by another thread in
> -		 * aio_complete_rw().  Fool lockdep by telling it the lock got
> -		 * released so that it doesn't complain about the held lock when
> -		 * we return to userspace.
> -		 */
> -		if (S_ISREG(file_inode(file)->i_mode)) {
> -			sb_start_write(file_inode(file)->i_sb);
> -			__sb_writers_release(file_inode(file)->i_sb, SB_FREEZE_WRITE);
> -		}
> +		if (S_ISREG(file_inode(file)->i_mode))
> +			kiocb_start_write(req);
>  		req->ki_flags |= IOCB_WRITE;
>  		aio_rw_done(req, call_write_iter(file, req, &iter));
>  	}
> -- 
> 2.34.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
