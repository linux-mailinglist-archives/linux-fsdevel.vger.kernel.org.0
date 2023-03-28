Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E7BE6CB9FB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Mar 2023 11:00:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232200AbjC1JAb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Mar 2023 05:00:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230093AbjC1JA3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Mar 2023 05:00:29 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE27549E0;
        Tue, 28 Mar 2023 02:00:28 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 6EE34219F1;
        Tue, 28 Mar 2023 09:00:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1679994027; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1vx4N3CbG9cjB0kwkI7LtFA84ddH7Jms/AyyibWUKLE=;
        b=lNQBPf30HLJ0SylN5gwm/rGzgCOg7HvjoRKHW34c6i/6cJWDdnw+ZSaecu+8OorlvpGjbR
        Pbi6MUvzVqjr7MVUxdHoQE42tiiaOY/PI+W048pV+YO/i4YQYECjYxNsx9rVtxCURcUG6u
        qfUEypAHc0igKOfcnrL5Okj9wbe7naA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1679994027;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1vx4N3CbG9cjB0kwkI7LtFA84ddH7Jms/AyyibWUKLE=;
        b=eNssFxBtw0o6F1s/+3Ci0a3j0qwbIRXZBCcHtoasxKrYdwwzxH/fvQcmwd3xCUO2abaVk+
        NQrfqE+5Bn9hi6Cg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5FC1D1390B;
        Tue, 28 Mar 2023 09:00:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 56NQF6usImQROAAAMHmgww
        (envelope-from <jack@suse.cz>); Tue, 28 Mar 2023 09:00:27 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id BB5A7A071C; Tue, 28 Mar 2023 11:00:26 +0200 (CEST)
Date:   Tue, 28 Mar 2023 11:00:26 +0200
From:   Jan Kara <jack@suse.cz>
To:     Christian Brauner <brauner@kernel.org>
Cc:     linux-fsdevel@vger.kernel.org, Jan Kara <jack@suse.cz>,
        Amir Goldstein <amir73il@gmail.com>,
        Matthew Bobrowski <repnop@google.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] pid: add pidfd_prepare()
Message-ID: <20230328090026.b54a4jhccntfraey@quack3>
References: <20230327-pidfd-file-api-v1-0-5c0e9a3158e4@kernel.org>
 <20230327-pidfd-file-api-v1-1-5c0e9a3158e4@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230327-pidfd-file-api-v1-1-5c0e9a3158e4@kernel.org>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon 27-03-23 20:22:51, Christian Brauner wrote:
> Add a new helper that allows to reserve a pidfd and allocates a new
> pidfd file that stashes the provided struct pid. This will allow us to
> remove places that either open code this function or that call
> pidfd_create() but then have to call close_fd() because there are still
> failure points after pidfd_create() has been called.
> 
> Signed-off-by: Christian Brauner <brauner@kernel.org>

Looks good to me. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  include/linux/pid.h |  1 +
>  kernel/pid.c        | 69 +++++++++++++++++++++++++++++++++++++++++++----------
>  2 files changed, 58 insertions(+), 12 deletions(-)
> 
> diff --git a/include/linux/pid.h b/include/linux/pid.h
> index 343abf22092e..b75de288a8c2 100644
> --- a/include/linux/pid.h
> +++ b/include/linux/pid.h
> @@ -80,6 +80,7 @@ extern struct pid *pidfd_pid(const struct file *file);
>  struct pid *pidfd_get_pid(unsigned int fd, unsigned int *flags);
>  struct task_struct *pidfd_get_task(int pidfd, unsigned int *flags);
>  int pidfd_create(struct pid *pid, unsigned int flags);
> +int pidfd_prepare(struct pid *pid, unsigned int flags, struct file **ret);
>  
>  static inline struct pid *get_pid(struct pid *pid)
>  {
> diff --git a/kernel/pid.c b/kernel/pid.c
> index 3fbc5e46b721..95e7e01574c8 100644
> --- a/kernel/pid.c
> +++ b/kernel/pid.c
> @@ -576,6 +576,56 @@ struct task_struct *pidfd_get_task(int pidfd, unsigned int *flags)
>  	return task;
>  }
>  
> +/**
> + * pidfd_prepare - allocate a new pidfd_file and reserve a pidfd
> + * @pid:   the struct pid for which to create a pidfd
> + * @flags: flags of the new @pidfd
> + * @pidfd: the pidfd to return
> + *
> + * Allocate a new file that stashes @pid and reserve a new pidfd number in the
> + * caller's file descriptor table. The pidfd is reserved but not installed yet.
> + *
> + * If this function returns successfully the caller is responsible to either
> + * call fd_install() passing the returned pidfd and pidfd file as arguments in
> + * order to install the pidfd into its file descriptor table or they must use
> + * put_unused_fd() and fput() on the returned pidfd and pidfd file
> + * respectively.
> + *
> + * This function is useful when a pidfd must already be reserved but there
> + * might still be points of failure afterwards and the caller wants to ensure
> + * that no pidfd is leaked into its file descriptor table.
> + *
> + * Return: On success, a reserved pidfd is returned from the function and a new
> + *         pidfd file is returned in the last argument to the function. On
> + *         error, a negative error code is returned from the function and the
> + *         last argument remains unchanged.
> + */
> +int pidfd_prepare(struct pid *pid, unsigned int flags, struct file **ret)
> +{
> +	int pidfd;
> +	struct file *pidfd_file;
> +
> +	if (!pid || !pid_has_task(pid, PIDTYPE_TGID))
> +		return -EINVAL;
> +
> +	if (flags & ~(O_NONBLOCK | O_RDWR | O_CLOEXEC))
> +		return -EINVAL;
> +
> +	pidfd = get_unused_fd_flags(O_RDWR | O_CLOEXEC);
> +	if (pidfd < 0)
> +		return pidfd;
> +
> +	pidfd_file = anon_inode_getfile("[pidfd]", &pidfd_fops, pid,
> +					flags | O_RDWR | O_CLOEXEC);
> +	if (IS_ERR(pidfd_file)) {
> +		put_unused_fd(pidfd);
> +		return PTR_ERR(pidfd_file);
> +	}
> +	get_pid(pid); /* held by pidfd_file now */
> +	*ret = pidfd_file;
> +	return pidfd;
> +}
> +
>  /**
>   * pidfd_create() - Create a new pid file descriptor.
>   *
> @@ -594,20 +644,15 @@ struct task_struct *pidfd_get_task(int pidfd, unsigned int *flags)
>   */
>  int pidfd_create(struct pid *pid, unsigned int flags)
>  {
> -	int fd;
> +	int pidfd;
> +	struct file *pidfd_file;
>  
> -	if (!pid || !pid_has_task(pid, PIDTYPE_TGID))
> -		return -EINVAL;
> -
> -	if (flags & ~(O_NONBLOCK | O_RDWR | O_CLOEXEC))
> -		return -EINVAL;
> -
> -	fd = anon_inode_getfd("[pidfd]", &pidfd_fops, get_pid(pid),
> -			      flags | O_RDWR | O_CLOEXEC);
> -	if (fd < 0)
> -		put_pid(pid);
> +	pidfd = pidfd_prepare(pid, flags, &pidfd_file);
> +	if (pidfd < 0)
> +		return pidfd;
>  
> -	return fd;
> +	fd_install(pidfd, pidfd_file);
> +	return pidfd;
>  }
>  
>  /**
> 
> -- 
> 2.34.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
