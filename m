Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E6756CB8C6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Mar 2023 09:54:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232329AbjC1Hys (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Mar 2023 03:54:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230325AbjC1Hyr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Mar 2023 03:54:47 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE1EFDB;
        Tue, 28 Mar 2023 00:54:42 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 99D6A1FD81;
        Tue, 28 Mar 2023 07:54:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1679990081; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6iPgbcWLfS4ADF8Ltx8cl7gqwqXWbZdK3uZ1Oe3HsXk=;
        b=qji3cJQxQ2PPraU0cvs1P6hZHNuL3LCIfGNHtd3MiY4M4yeGdsac+9UanEil7qkJYD1Ybi
        8Vj9XQBt2tMyQmCqkKBYfazRUPh7zjtMbubyG0R4QyvzWyZ93daDQjrBLhIa2Hq9sEgXDz
        FsrRLmWOs9jT7G2h7PlsKgjd7J7l4qI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1679990081;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6iPgbcWLfS4ADF8Ltx8cl7gqwqXWbZdK3uZ1Oe3HsXk=;
        b=fXIP9q6BsSFUheXM71xvrTRt8yBigoZGVDl/LEvfKnCcq28RnC9zjucGn6mKr3SnUsLLhW
        ttB7UW7NMw3YbVAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 881631390D;
        Tue, 28 Mar 2023 07:54:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id ULIvIUGdImSzEAAAMHmgww
        (envelope-from <jack@suse.cz>); Tue, 28 Mar 2023 07:54:41 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 06816A071C; Tue, 28 Mar 2023 09:54:41 +0200 (CEST)
Date:   Tue, 28 Mar 2023 09:54:40 +0200
From:   Jan Kara <jack@suse.cz>
To:     Christian Brauner <brauner@kernel.org>
Cc:     linux-fsdevel@vger.kernel.org, Jan Kara <jack@suse.cz>,
        Amir Goldstein <amir73il@gmail.com>,
        Matthew Bobrowski <repnop@google.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] fanotify: use pidfd_prepare()
Message-ID: <20230328075440.ho55dt2xhvbz7yog@quack3>
References: <20230327-pidfd-file-api-v1-0-5c0e9a3158e4@kernel.org>
 <20230327-pidfd-file-api-v1-3-5c0e9a3158e4@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230327-pidfd-file-api-v1-3-5c0e9a3158e4@kernel.org>
X-Spam-Status: No, score=-1.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon 27-03-23 20:22:53, Christian Brauner wrote:
> We generally try to avoid installing a file descriptor into the caller's
> file descriptor table just to close it again via close_fd() in case an
> error occurs. Instead we reserve a file descriptor but don't install it
> into the caller's file descriptor table yet. If we fail for other,
> unrelated reasons we can just close the reserved file descriptor and if
> we make it past all meaningful error paths we just install it. Fanotify
> gets this right already for one fd type but not for pidfds.
> 
> Use the new pidfd_prepare() helper to reserve a pidfd and a pidfd file
> and switch to the more common fd allocation and installation pattern.
> 
> Signed-off-by: Christian Brauner <brauner@kernel.org>

Thanks for the improvement! It looks good to me. Feel free to add:

Acked-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/notify/fanotify/fanotify_user.c | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
> index 8f430bfad487..22fb1cf7e1fc 100644
> --- a/fs/notify/fanotify/fanotify_user.c
> +++ b/fs/notify/fanotify/fanotify_user.c
> @@ -663,7 +663,7 @@ static ssize_t copy_event_to_user(struct fsnotify_group *group,
>  	struct fanotify_info *info = fanotify_event_info(event);
>  	unsigned int info_mode = FAN_GROUP_FLAG(group, FANOTIFY_INFO_MODES);
>  	unsigned int pidfd_mode = info_mode & FAN_REPORT_PIDFD;
> -	struct file *f = NULL;
> +	struct file *f = NULL, *pidfd_file = NULL;
>  	int ret, pidfd = FAN_NOPIDFD, fd = FAN_NOFD;
>  
>  	pr_debug("%s: group=%p event=%p\n", __func__, group, event);
> @@ -718,7 +718,7 @@ static ssize_t copy_event_to_user(struct fsnotify_group *group,
>  		    !pid_has_task(event->pid, PIDTYPE_TGID)) {
>  			pidfd = FAN_NOPIDFD;
>  		} else {
> -			pidfd = pidfd_create(event->pid, 0);
> +			pidfd = pidfd_prepare(event->pid, 0, &pidfd_file);
>  			if (pidfd < 0)
>  				pidfd = FAN_EPIDFD;
>  		}
> @@ -751,6 +751,9 @@ static ssize_t copy_event_to_user(struct fsnotify_group *group,
>  	if (f)
>  		fd_install(fd, f);
>  
> +	if (pidfd_file)
> +		fd_install(pidfd, pidfd_file);
> +
>  	return metadata.event_len;
>  
>  out_close_fd:
> @@ -759,8 +762,10 @@ static ssize_t copy_event_to_user(struct fsnotify_group *group,
>  		fput(f);
>  	}
>  
> -	if (pidfd >= 0)
> -		close_fd(pidfd);
> +	if (pidfd >= 0) {
> +		put_unused_fd(pidfd);
> +		fput(pidfd_file);
> +	}
>  
>  	return ret;
>  }
> 
> -- 
> 2.34.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
