Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 629F67828F6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Aug 2023 14:27:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234869AbjHUM1i (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Aug 2023 08:27:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230526AbjHUM1h (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Aug 2023 08:27:37 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 270E0BE
        for <linux-fsdevel@vger.kernel.org>; Mon, 21 Aug 2023 05:27:36 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id D78CE21B01;
        Mon, 21 Aug 2023 12:27:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1692620854; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yFzTCnS/GknSpkjUE1WQG9rcaV6AKlIRG4BsX6HKtq0=;
        b=RaoqRTikYLMhB3PA/yCFHLwxnKbRvBbuMw8e4ZdI5VA89yc4J7Sien4MILJUo5/f6tC8Nw
        Ee06N0cuKM6SxdYu6b4WOuanitliq8gBqCv6CcGXi0lPLCtkxGr3W1/fhbRVoynQrdU5Y7
        +pvNUyXuF6LArae7kYDOF1VSpK/7kas=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1692620854;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yFzTCnS/GknSpkjUE1WQG9rcaV6AKlIRG4BsX6HKtq0=;
        b=V8WQrZ2UH6MhMHSNufU1IBY+yloAxZVaoS7qiEp3chR0ZJ/YzEhSaUjWV81++qao2ic2Fz
        8ftA1R0ARQVNGXDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C80F71330D;
        Mon, 21 Aug 2023 12:27:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 94HOMDZY42SuPAAAMHmgww
        (envelope-from <jack@suse.cz>); Mon, 21 Aug 2023 12:27:34 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 5AFACA0774; Mon, 21 Aug 2023 14:27:34 +0200 (CEST)
Date:   Mon, 21 Aug 2023 14:27:34 +0200
From:   Jan Kara <jack@suse.cz>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        Jens Axboe <axboe@kernel.dk>,
        Miklos Szeredi <miklos@szeredi.hu>,
        David Howells <dhowells@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v3 4/7] io_uring: use kiocb_{start,end}_write() helpers
Message-ID: <20230821122734.go56xcn2dm2dho2d@quack3>
References: <20230817141337.1025891-1-amir73il@gmail.com>
 <20230817141337.1025891-5-amir73il@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230817141337.1025891-5-amir73il@gmail.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 17-08-23 17:13:34, Amir Goldstein wrote:
> Use helpers instead of the open coded dance to silence lockdep warnings.
> 
> Suggested-by: Jan Kara <jack@suse.cz>
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>

Looks good to me. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  io_uring/rw.c | 23 ++++-------------------
>  1 file changed, 4 insertions(+), 19 deletions(-)
> 
> diff --git a/io_uring/rw.c b/io_uring/rw.c
> index 749ebd565839..9581b90cb459 100644
> --- a/io_uring/rw.c
> +++ b/io_uring/rw.c
> @@ -222,15 +222,10 @@ static bool io_rw_should_reissue(struct io_kiocb *req)
>  
>  static void io_req_end_write(struct io_kiocb *req)
>  {
> -	/*
> -	 * Tell lockdep we inherited freeze protection from submission
> -	 * thread.
> -	 */
>  	if (req->flags & REQ_F_ISREG) {
> -		struct super_block *sb = file_inode(req->file)->i_sb;
> +		struct io_rw *rw = io_kiocb_to_cmd(req, struct io_rw);
>  
> -		__sb_writers_acquired(sb, SB_FREEZE_WRITE);
> -		sb_end_write(sb);
> +		kiocb_end_write(&rw->kiocb);
>  	}
>  }
>  
> @@ -902,18 +897,8 @@ int io_write(struct io_kiocb *req, unsigned int issue_flags)
>  		return ret;
>  	}
>  
> -	/*
> -	 * Open-code file_start_write here to grab freeze protection,
> -	 * which will be released by another thread in
> -	 * io_complete_rw().  Fool lockdep by telling it the lock got
> -	 * released so that it doesn't complain about the held lock when
> -	 * we return to userspace.
> -	 */
> -	if (req->flags & REQ_F_ISREG) {
> -		sb_start_write(file_inode(req->file)->i_sb);
> -		__sb_writers_release(file_inode(req->file)->i_sb,
> -					SB_FREEZE_WRITE);
> -	}
> +	if (req->flags & REQ_F_ISREG)
> +		kiocb_start_write(kiocb);
>  	kiocb->ki_flags |= IOCB_WRITE;
>  
>  	if (likely(req->file->f_op->write_iter))
> -- 
> 2.34.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
