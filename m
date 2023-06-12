Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C33B72BB69
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jun 2023 10:58:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234230AbjFLI6F (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Jun 2023 04:58:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232029AbjFLI5l (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Jun 2023 04:57:41 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B7554225
        for <linux-fsdevel@vger.kernel.org>; Mon, 12 Jun 2023 01:55:02 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 342042282D;
        Mon, 12 Jun 2023 08:54:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1686560072; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qDceki86LNVYU5sUtCAYeG3DoPJsBtH8UeV2DRpE6w8=;
        b=e4jtP8FhVEq8YmgjZzClVlffPrgsYlrx+9HcD85lp1SL7MhnM3ZOFhDNIsbefFBzUida8p
        Af+/IL/GYMWLLOshEZ1BJdLenJWj4JilYfq3ctcTXYRCNmlufY7GVDxi/cQjJs7GYWAWYx
        LUAsMKPAK4zuTY2duL3EqmIs0eXSPyw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1686560072;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qDceki86LNVYU5sUtCAYeG3DoPJsBtH8UeV2DRpE6w8=;
        b=pNgQ5cjAFSb8u9kDrQm5cUgehMqRhfPNAJ9BSRdJs4aswFPTCL+7QSRBQyTTHTySG/kvfc
        1b01SzQ+1qeoYqBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 26A7F138EC;
        Mon, 12 Jun 2023 08:54:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Y2xkCUjdhmQnAgAAMHmgww
        (envelope-from <jack@suse.cz>); Mon, 12 Jun 2023 08:54:32 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id AE3D4A0717; Mon, 12 Jun 2023 10:54:31 +0200 (CEST)
Date:   Mon, 12 Jun 2023 10:54:31 +0200
From:   Jan Kara <jack@suse.cz>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jan Kara <jack@suse.cz>, Miklos Szeredi <miklos@szeredi.hu>,
        Christian Brauner <brauner@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] fsnotify: move fsnotify_open() hook into do_dentry_open()
Message-ID: <20230612085431.ycbzjj7wk6qij3qf@quack3>
References: <20230611122429.1499617-1-amir73il@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230611122429.1499617-1-amir73il@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun 11-06-23 15:24:29, Amir Goldstein wrote:
> fsnotify_open() hook is called only from high level system calls
> context and not called for the very many helpers to open files.
> 
> This may makes sense for many of the special file open cases, but it is
> inconsistent with fsnotify_close() hook that is called for every last
> fput() of on a file object with FMODE_OPENED.
> 
> As a result, it is possible to observe ACCESS, MODIFY and CLOSE events
> without ever observing an OPEN event.
> 
> Fix this inconsistency by replacing all the fsnotify_open() hooks with
> a single hook inside do_dentry_open().
> 
> If there are special cases that would like to opt-out of the possible
> overhead of fsnotify() call in fsnotify_open(), they would probably also
> want to avoid the overhead of fsnotify() call in the rest of the fsnotify
> hooks, so they should be opening that file with the __FMODE_NONOTIFY flag.
> 
> However, in the majority of those cases, the s_fsnotify_connectors
> optimization in fsnotify_parent() would be sufficient to avoid the
> overhead of fsnotify() call anyway.
> 
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>

Thanks! The cleanup looks nice so I've applied it with the typo fixup from
Christian. I have a slight worry this might break something subtle
somewhere but after searching for a while I didn't find anything and the
machine boots and ltp tests pass so it's worth a try :)

								Honza

> ---
> 
> Jan,
> 
> I found out about this problem when I tested the work to remove
> FMODE_NONOTIFY from overlayfs internal files - even after I enabled
> notifications on the underlying fs, the LTS tests [2] did not observe
> the OPEN events.
> 
> Because this change is independent of the ovl work and has implications
> on other subsystems as well (e.g. cachefiles), I think it is better
> if the change came through your tree.
> 
> This change has a potential to regress some micro-benchmarks, so if
> you could queue it up for soaking in linux-next that would be great.
> 
> Thanks,
> Amir.
> 
> 
> [1] https://lore.kernel.org/linux-fsdevel/20230609073239.957184-1-amir73il@gmail.com/
> [2] https://github.com/amir73il/ltp/commits/ovl_encode_fid
> 
>  fs/exec.c            | 5 -----
>  fs/fhandle.c         | 1 -
>  fs/open.c            | 6 +++++-
>  io_uring/openclose.c | 1 -
>  4 files changed, 5 insertions(+), 8 deletions(-)
> 
> diff --git a/fs/exec.c b/fs/exec.c
> index a466e797c8e2..238473de1ec5 100644
> --- a/fs/exec.c
> +++ b/fs/exec.c
> @@ -152,8 +152,6 @@ SYSCALL_DEFINE1(uselib, const char __user *, library)
>  			 path_noexec(&file->f_path)))
>  		goto exit;
>  
> -	fsnotify_open(file);
> -
>  	error = -ENOEXEC;
>  
>  	read_lock(&binfmt_lock);
> @@ -934,9 +932,6 @@ static struct file *do_open_execat(int fd, struct filename *name, int flags)
>  	if (err)
>  		goto exit;
>  
> -	if (name->name[0] != '\0')
> -		fsnotify_open(file);
> -
>  out:
>  	return file;
>  
> diff --git a/fs/fhandle.c b/fs/fhandle.c
> index fd0d6a3b3699..6ea8d35a9382 100644
> --- a/fs/fhandle.c
> +++ b/fs/fhandle.c
> @@ -242,7 +242,6 @@ static long do_handle_open(int mountdirfd, struct file_handle __user *ufh,
>  		retval =  PTR_ERR(file);
>  	} else {
>  		retval = fd;
> -		fsnotify_open(file);
>  		fd_install(fd, file);
>  	}
>  	path_put(&path);
> diff --git a/fs/open.c b/fs/open.c
> index 4478adcc4f3a..81444ebf6091 100644
> --- a/fs/open.c
> +++ b/fs/open.c
> @@ -969,6 +969,11 @@ static int do_dentry_open(struct file *f,
>  		}
>  	}
>  
> +	/*
> +	 * Once we return a file with FMODE_OPENED, __fput() will call
> +	 * fsnotify_close(), so we need fsnotify_open() here for symetry.
> +	 */
> +	fsnotify_open(f);
>  	return 0;
>  
>  cleanup_all:
> @@ -1358,7 +1363,6 @@ static long do_sys_openat2(int dfd, const char __user *filename,
>  			put_unused_fd(fd);
>  			fd = PTR_ERR(f);
>  		} else {
> -			fsnotify_open(f);
>  			fd_install(fd, f);
>  		}
>  	}
> diff --git a/io_uring/openclose.c b/io_uring/openclose.c
> index a1b98c81a52d..10ca57f5bd24 100644
> --- a/io_uring/openclose.c
> +++ b/io_uring/openclose.c
> @@ -150,7 +150,6 @@ int io_openat2(struct io_kiocb *req, unsigned int issue_flags)
>  
>  	if ((issue_flags & IO_URING_F_NONBLOCK) && !nonblock_set)
>  		file->f_flags &= ~O_NONBLOCK;
> -	fsnotify_open(file);
>  
>  	if (!fixed)
>  		fd_install(ret, file);
> -- 
> 2.34.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
