Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 888EA77F996
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Aug 2023 16:47:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352198AbjHQOrO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Aug 2023 10:47:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352373AbjHQOrK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Aug 2023 10:47:10 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2CD135AD
        for <linux-fsdevel@vger.kernel.org>; Thu, 17 Aug 2023 07:46:51 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id A226D1F37E;
        Thu, 17 Aug 2023 14:46:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1692283582; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UAnk7YqPFDuCCcH2kE5OfZS1xQrvDaKTdV1JaTh32iY=;
        b=vxjKBGfWXAs9Npqi7/VnzyMKEzFZ6nTRKZRQpg7KuYupx6tNtTMkz9pxHgilOoSacb5Wmx
        vIqi4LrgE0d6E/jbQL8PAxAuV/6XHWiq9nbEk+tuBxDg5N9xw0uDJ+sBC06vVYENIZAKlV
        r9TJoWOBS2WdFZ5dAo0IUabVNkd7riw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1692283582;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UAnk7YqPFDuCCcH2kE5OfZS1xQrvDaKTdV1JaTh32iY=;
        b=XcZfGrnZjNuRb4GU6j9XSfFQBAd9AhnQDJzJVPy+xQjsuKNX1Cttmf5P3WSaWZ7Xk/UgED
        RHNVN5x/IxtAdJBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 933D11392B;
        Thu, 17 Aug 2023 14:46:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id r1DfI74y3mSxLwAAMHmgww
        (envelope-from <jack@suse.cz>); Thu, 17 Aug 2023 14:46:22 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 26DF0A0769; Thu, 17 Aug 2023 16:46:22 +0200 (CEST)
Date:   Thu, 17 Aug 2023 16:46:22 +0200
From:   Jan Kara <jack@suse.cz>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        Jens Axboe <axboe@kernel.dk>,
        Miklos Szeredi <miklos@szeredi.hu>,
        David Howells <dhowells@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v3 1/7] io_uring: rename kiocb_end_write() local helper
Message-ID: <20230817144622.bq57x2w4ne6hzce3@quack3>
References: <20230817141337.1025891-1-amir73il@gmail.com>
 <20230817141337.1025891-2-amir73il@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230817141337.1025891-2-amir73il@gmail.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 17-08-23 17:13:31, Amir Goldstein wrote:
> This helper does not take a kiocb as input and we want to create a
> common helper by that name that takes a kiocb as input.
> 
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  io_uring/rw.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/io_uring/rw.c b/io_uring/rw.c
> index 1bce2208b65c..749ebd565839 100644
> --- a/io_uring/rw.c
> +++ b/io_uring/rw.c
> @@ -220,7 +220,7 @@ static bool io_rw_should_reissue(struct io_kiocb *req)
>  }
>  #endif
>  
> -static void kiocb_end_write(struct io_kiocb *req)
> +static void io_req_end_write(struct io_kiocb *req)
>  {
>  	/*
>  	 * Tell lockdep we inherited freeze protection from submission
> @@ -243,7 +243,7 @@ static void io_req_io_end(struct io_kiocb *req)
>  	struct io_rw *rw = io_kiocb_to_cmd(req, struct io_rw);
>  
>  	if (rw->kiocb.ki_flags & IOCB_WRITE) {
> -		kiocb_end_write(req);
> +		io_req_end_write(req);
>  		fsnotify_modify(req->file);
>  	} else {
>  		fsnotify_access(req->file);
> @@ -313,7 +313,7 @@ static void io_complete_rw_iopoll(struct kiocb *kiocb, long res)
>  	struct io_kiocb *req = cmd_to_io_kiocb(rw);
>  
>  	if (kiocb->ki_flags & IOCB_WRITE)
> -		kiocb_end_write(req);
> +		io_req_end_write(req);
>  	if (unlikely(res != req->cqe.res)) {
>  		if (res == -EAGAIN && io_rw_should_reissue(req)) {
>  			req->flags |= REQ_F_REISSUE | REQ_F_PARTIAL_IO;
> @@ -961,7 +961,7 @@ int io_write(struct io_kiocb *req, unsigned int issue_flags)
>  				io->bytes_done += ret2;
>  
>  			if (kiocb->ki_flags & IOCB_WRITE)
> -				kiocb_end_write(req);
> +				io_req_end_write(req);
>  			return ret ? ret : -EAGAIN;
>  		}
>  done:
> @@ -972,7 +972,7 @@ int io_write(struct io_kiocb *req, unsigned int issue_flags)
>  		ret = io_setup_async_rw(req, iovec, s, false);
>  		if (!ret) {
>  			if (kiocb->ki_flags & IOCB_WRITE)
> -				kiocb_end_write(req);
> +				io_req_end_write(req);
>  			return -EAGAIN;
>  		}
>  		return ret;
> -- 
> 2.34.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
