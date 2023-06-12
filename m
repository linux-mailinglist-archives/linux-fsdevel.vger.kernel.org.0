Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDA8872B85F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jun 2023 08:58:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232490AbjFLG6D (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Jun 2023 02:58:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjFLG6D (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Jun 2023 02:58:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADDEEB0
        for <linux-fsdevel@vger.kernel.org>; Sun, 11 Jun 2023 23:53:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7031961F9C
        for <linux-fsdevel@vger.kernel.org>; Mon, 12 Jun 2023 06:43:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 906CAC433D2;
        Mon, 12 Jun 2023 06:43:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686552210;
        bh=Dzoy2/JoV5epUVWTnhYK4cPDsisO6UrEotqceIZRiD4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=j7hfsUUASCy2F1nrEXpu3SoKc0lcyWWFqMXot4ozJUIispx5qY7ADKdk3K2GWQUMq
         cbNm7vRz4IJxA8zOJM5Fb9l7fdDFW8FYgx4lIII4EqD3kloijW3Cp53jFVRV6I+HTk
         EkVtoglU7xjtJBqNv9T4L4j9VQ446XPKc5YR1IP6cxVmECRndKeM9MYkR6xowG0MSk
         1zkWU1ci/fGD3YMXn8opCSeLOsrRFYPA6NtIQF+9URtswluCfi+GSDasZq54zoN9Kk
         /8GlXvQzXTPOihyFTOJE8x4i/F1hZewYX5Gr0Zkx4sPfJJxiWapKeXl8xpAHkv4bPx
         exyvZzbKzlBSQ==
Date:   Mon, 12 Jun 2023 08:43:26 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jan Kara <jack@suse.cz>, Miklos Szeredi <miklos@szeredi.hu>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] fsnotify: move fsnotify_open() hook into do_dentry_open()
Message-ID: <20230612-tankwagen-gelistet-d63006c4753f@brauner>
References: <20230611122429.1499617-1-amir73il@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230611122429.1499617-1-amir73il@gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Jun 11, 2023 at 03:24:29PM +0300, Amir Goldstein wrote:
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

s/symetry/symmetry/
