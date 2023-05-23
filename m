Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E24570DC9F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 May 2023 14:32:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236880AbjEWMcV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 May 2023 08:32:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236863AbjEWMcT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 May 2023 08:32:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B279D18E;
        Tue, 23 May 2023 05:32:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3D82C63168;
        Tue, 23 May 2023 12:32:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C644C43442;
        Tue, 23 May 2023 12:32:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684845131;
        bh=lIhkwbsmEFc9E7hGaujlmcd5yC5nfUtCpttTcD1F5eM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gMH854KaECDra+q5gU1RNsEYQQz9204GMZzxs4kEod0Y02NEzW5nh/L1uTbezAY9F
         pHQmmA4Fpd2puQny+XrB7aj7kP9VEFUxPP9gFkzEw9w+bJaS3GgSM1hhFg/TBJLPIp
         xBP9FxG6bZsAbgb+0VhSqf+G8RkYmFm2v9yHr9SxG0izrXH8Jc8sPLYByR3IfPcakQ
         U9GnUu6fKTvDMdE0y5Wkgx7wvHnItOudOCbazWqxK7OpeaerKS29nWGe+cwz4s7lfA
         CIANm1Wj0vYf6LKfRgf5mMWitWu/hUS8ATL06l+1LFSb/fFKMF0z18hqI3zkHMDoib
         JAfGejGY+dqRA==
Date:   Tue, 23 May 2023 14:32:06 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     aloktiagi <aloktiagi@gmail.com>
Cc:     viro@zeniv.linux.org.uk, willy@infradead.org,
        David.Laight@ACULAB.COM, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, keescook@chromium.org,
        hch@infradead.org, tycho@tycho.pizza
Subject: Re: [RFC v6 1/2] epoll: Implement eventpoll_replace_file()
Message-ID: <20230523-unleserlich-impfen-e193df4b4b30@brauner>
References: <20230523065802.2253926-1-aloktiagi@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230523065802.2253926-1-aloktiagi@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, May 23, 2023 at 06:58:01AM +0000, aloktiagi wrote:
> Introduce a mechanism to replace a file linked in the epoll interface with a new
> file.
> 
> eventpoll_replace() finds all instances of the file to be replaced and replaces
> them with the new file and the interested events.
> 
> Signed-off-by: aloktiagi <aloktiagi@gmail.com>
> ---
> Changes in v6:
>   - incorporate latest changes that get rid of the global epmutex lock.
> 
> Changes in v5:
>   - address review comments and move the call to replace old file in each
>     subsystem (epoll, io_uring, etc.) outside the fdtable helpers like
>     replace_fd().
> 
> Changes in v4:
>   - address review comment to remove the redundant eventpoll_replace() function.
>   - removed an extra empty line introduced in include/linux/file.h
> 
> Changes in v3:
>   - address review comment and iterate over the file table while holding the
>     spin_lock(&files->file_lock).
>   - address review comment and call filp_close() outside the
>     spin_lock(&files->file_lock).
> ---
>  fs/eventpoll.c            | 76 +++++++++++++++++++++++++++++++++++++++
>  include/linux/eventpoll.h |  8 +++++
>  2 files changed, 84 insertions(+)
> 
> diff --git a/fs/eventpoll.c b/fs/eventpoll.c
> index 980483455cc0..9c7bffa8401b 100644
> --- a/fs/eventpoll.c
> +++ b/fs/eventpoll.c
> @@ -973,6 +973,82 @@ void eventpoll_release_file(struct file *file)
>  	spin_unlock(&file->f_lock);
>  }
>  
> +static int ep_insert(struct eventpoll *ep, const struct epoll_event *event,
> +			struct file *tfile, int fd, int full_check);
> +
> +/*
> + * This is called from eventpoll_replace() to replace a linked file in the epoll
> + * interface with a new file received from another process. This is useful in
> + * cases where a process is trying to install a new file for an existing one
> + * that is linked in the epoll interface
> + */
> +int eventpoll_replace_file(struct file *toreplace, struct file *file, int tfd)
> +{
> +	struct file *to_remove = toreplace;
> +	struct epoll_event event;
> +	struct hlist_node *next;
> +	struct eventpoll *ep;
> +	struct epitem *epi;
> +	int error = 0;
> +	bool dispose;
> +	int fd;
> +
> +	if (!file_can_poll(file))
> +		return 0;
> +
> +	spin_lock(&toreplace->f_lock);
> +	if (unlikely(!toreplace->f_ep)) {
> +		spin_unlock(&toreplace->f_lock);
> +		return 0;
> +	}
> +	hlist_for_each_entry_safe(epi, next, toreplace->f_ep, fllink) {
> +		ep = epi->ep;
> +		mutex_lock(&ep->mtx);

Afaict, you're under a spinlock and you're acquiring a mutex. The
spinlock can't sleep (on non-rt kernels at least) but the mutex can.

> +		fd = epi->ffd.fd;
> +		if (fd != tfd) {
> +			mutex_unlock(&ep->mtx);
> +			continue;
> +		}
> +		event = epi->event;
> +		error = ep_insert(ep, &event, file, fd, 1);
> +		mutex_unlock(&ep->mtx);
> +		if (error != 0) {
> +			break;
> +		}

nit: we don't do { } around single lines.
