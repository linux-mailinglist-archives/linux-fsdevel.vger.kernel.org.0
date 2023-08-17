Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F13B077F99C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Aug 2023 16:48:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352236AbjHQOsT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Aug 2023 10:48:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352400AbjHQOsR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Aug 2023 10:48:17 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5200535AB
        for <linux-fsdevel@vger.kernel.org>; Thu, 17 Aug 2023 07:47:56 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 3E59B1F37E;
        Thu, 17 Aug 2023 14:47:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1692283653; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7nVpWvK4Wyw4M6Q5ZsxplRUEC+QlgZmOtXOI84haljk=;
        b=wx/Qdm28p6+26DZkXoDTnnWK6IDbPlVNp9CM+8QFxE19xZh/dX5G+6yAJl7UxjJjxUmhrF
        S85YOj4HC2BEBpnhYMCB3wN+qbz6umREmvDOse9iFl2HMA3hMHTQYHVU9y+JAv5tsOlJ+e
        K3mb03Q0z+FJa/RCAZFxLMr6boScW60=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1692283653;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7nVpWvK4Wyw4M6Q5ZsxplRUEC+QlgZmOtXOI84haljk=;
        b=S5wX+0nLYeFUX/hG7nEwaEZfiADr9F+Mc/p6g8d7rJiIKh/Db8WMbJiV1+M8WFI4gdOpr/
        h/8GYViVwoD902DA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 30A071392B;
        Thu, 17 Aug 2023 14:47:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id iMXaCwUz3mRPMAAAMHmgww
        (envelope-from <jack@suse.cz>); Thu, 17 Aug 2023 14:47:33 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id CE9DBA0769; Thu, 17 Aug 2023 16:47:32 +0200 (CEST)
Date:   Thu, 17 Aug 2023 16:47:32 +0200
From:   Jan Kara <jack@suse.cz>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        Jens Axboe <axboe@kernel.dk>,
        Miklos Szeredi <miklos@szeredi.hu>,
        David Howells <dhowells@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v3 3/7] fs: create kiocb_{start,end}_write() helpers
Message-ID: <20230817144732.dyeu6e6c5a2m63fg@quack3>
References: <20230817141337.1025891-1-amir73il@gmail.com>
 <20230817141337.1025891-4-amir73il@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230817141337.1025891-4-amir73il@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 17-08-23 17:13:33, Amir Goldstein wrote:
> aio, io_uring, cachefiles and overlayfs, all open code an ugly variant
> of file_{start,end}_write() to silence lockdep warnings.
> 
> Create helpers for this lockdep dance so we can use the helpers in all
> the callers.
> 
> Suggested-by: Jan Kara <jack@suse.cz>
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  include/linux/fs.h | 36 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 36 insertions(+)
> 
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index ced388aff51f..2548048a6e6c 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -2579,6 +2579,42 @@ static inline void file_end_write(struct file *file)
>  	sb_end_write(file_inode(file)->i_sb);
>  }
>  
> +/**
> + * kiocb_start_write - get write access to a superblock for async file io
> + * @iocb: the io context we want to submit the write with
> + *
> + * This is a variant of sb_start_write() for async io submission.
> + * Should be matched with a call to kiocb_end_write().
> + */
> +static inline void kiocb_start_write(struct kiocb *iocb)
> +{
> +	struct inode *inode = file_inode(iocb->ki_filp);
> +
> +	sb_start_write(inode->i_sb);
> +	/*
> +	 * Fool lockdep by telling it the lock got released so that it
> +	 * doesn't complain about the held lock when we return to userspace.
> +	 */
> +	__sb_writers_release(inode->i_sb, SB_FREEZE_WRITE);
> +}
> +
> +/**
> + * kiocb_end_write - drop write access to a superblock after async file io
> + * @iocb: the io context we sumbitted the write with
> + *
> + * Should be matched with a call to kiocb_start_write().
> + */
> +static inline void kiocb_end_write(struct kiocb *iocb)
> +{
> +	struct inode *inode = file_inode(iocb->ki_filp);
> +
> +	/*
> +	 * Tell lockdep we inherited freeze protection from submission thread.
> +	 */
> +	__sb_writers_acquired(inode->i_sb, SB_FREEZE_WRITE);
> +	sb_end_write(inode->i_sb);
> +}
> +
>  /*
>   * This is used for regular files where some users -- especially the
>   * currently executed binary in a process, previously handled via
> -- 
> 2.34.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
