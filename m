Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 967DA394410
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 May 2021 16:19:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233884AbhE1OVP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 28 May 2021 10:21:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:33150 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231366AbhE1OVP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 28 May 2021 10:21:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1622211580;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=27wAvvlsFpDHbI7lMCAvvC3D6eTE94xkraFs68Rg0Ug=;
        b=cwLgWtZq7jiOtzs8G+sJavyLUQet1npSAdNma79/OQIg0uOFftEGCYOnfuB8Wb71CChQ5m
        KGhu4HM1A9IzNHEnv7goOE2VUiH1YXLrZq1wzMNPfg3/qWzEGns1WYThboLozgWpP5Pb2W
        1eMXC04OuaS28JYxvPUYYT8dUkgNE9I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-417-GMHIYcWNOk20l2eMfaUhBQ-1; Fri, 28 May 2021 10:19:38 -0400
X-MC-Unique: GMHIYcWNOk20l2eMfaUhBQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BEBD51007477;
        Fri, 28 May 2021 14:19:36 +0000 (UTC)
Received: from madcap2.tricolour.ca (unknown [10.3.128.13])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 3B2061378E;
        Fri, 28 May 2021 14:19:32 +0000 (UTC)
Date:   Fri, 28 May 2021 10:19:29 -0400
From:   Richard Guy Briggs <rgb@redhat.com>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>, Al Viro <viro@zeniv.linux.org.uk>,
        Aleksa Sarai <cyphar@cyphar.com>,
        linux-fsdevel@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: Re: [PATCH v2 2/3] open: don't silently ignore unknown O-flags in
 openat2()
Message-ID: <20210528141929.GJ2268484@madcap2.tricolour.ca>
References: <20210528092417.3942079-1-brauner@kernel.org>
 <20210528092417.3942079-3-brauner@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210528092417.3942079-3-brauner@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2021-05-28 11:24, Christian Brauner wrote:
> From: Christian Brauner <christian.brauner@ubuntu.com>
> 
> The new openat2() syscall verifies that no unknown O-flag values are
> set and returns an error to userspace if they are while the older open
> syscalls like open() and openat() simply ignore unknown flag values:
> 
>   #define O_FLAG_CURRENTLY_INVALID (1 << 31)
>   struct open_how how = {
>           .flags = O_RDONLY | O_FLAG_CURRENTLY_INVALID,
>           .resolve = 0,
>   };
> 
>   /* fails */
>   fd = openat2(-EBADF, "/dev/null", &how, sizeof(how));
> 
>   /* succeeds */
>   fd = openat(-EBADF, "/dev/null", O_RDONLY | O_FLAG_CURRENTLY_INVALID);
> 
> However, openat2() silently truncates the upper 32 bits meaning:
> 
>   #define O_FLAG_CURRENTLY_INVALID_LOWER32 (1 << 31)
>   #define O_FLAG_CURRENTLY_INVALID_UPPER32 (1 << 40)
> 
>   struct open_how how_lowe32 = {
>           .flags = O_RDONLY | O_FLAG_CURRENTLY_INVALID_LOWER32,
>   };
> 
>   struct open_how how_upper32 = {
>           .flags = O_RDONLY | O_FLAG_CURRENTLY_INVALID_UPPER32,
>   };
> 
>   /* fails */
>   fd = openat2(-EBADF, "/dev/null", &how_lower32, sizeof(how_lower32));
> 
>   /* succeeds */
>   fd = openat2(-EBADF, "/dev/null", &how_upper32, sizeof(how_upper32));
> 
> Fix this by preventing the immediate truncation in build_open_flags().
> 
> There's a snafu here though stripping FMODE_* directly from flags would
> cause the upper 32 bits to be truncated as well due to integer promotion
> rules since FMODE_* is unsigned int, O_* are signed ints (yuck).
> 
> In addition, struct open_flags currently defines flags to be 32 bit
> which is reasonable. If we simply were to bump it to 64 bit we would
> need to change a lot of code preemptively which doesn't seem worth it.
> So simply add a compile-time check verifying that all currently known
> O_* flags are within the 32 bit range and fail to build if they aren't
> anymore.
> 
> This change shouldn't regress old open syscalls since they silently
> truncate any unknown values anyway. It is a tiny semantic change for
> openat2() but it is very unlikely people pass ing > 32 bit unknown flags
> and the syscall is relatively new too.
> 
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Aleksa Sarai <cyphar@cyphar.com>
> Cc: Al Viro <viro@zeniv.linux.org.uk>
> Cc: linux-fsdevel@vger.kernel.org
> Reported-by: Richard Guy Briggs <rgb@redhat.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Aleksa Sarai <cyphar@cyphar.com>
> Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>

Reviewed-by: Richard Guy Briggs <rgb@redhat.com>

> ---
> /* v2 */
> - Richard Guy Briggs <rgb@redhat.com>:
>   - Add an explicit BUILD_BUG_ON() to check when we need to change
>     struct open_flags to account for O_* flags > 32 bits.
> ---
>  fs/open.c | 14 +++++++++++---
>  1 file changed, 11 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/open.c b/fs/open.c
> index e53af13b5835..53bc0573c0ec 100644
> --- a/fs/open.c
> +++ b/fs/open.c
> @@ -1002,12 +1002,20 @@ inline struct open_how build_open_how(int flags, umode_t mode)
>  
>  inline int build_open_flags(const struct open_how *how, struct open_flags *op)
>  {
> -	int flags = how->flags;
> +	u64 flags = how->flags;
> +	u64 strip = FMODE_NONOTIFY | O_CLOEXEC;
>  	int lookup_flags = 0;
>  	int acc_mode = ACC_MODE(flags);
>  
> -	/* Must never be set by userspace */
> -	flags &= ~(FMODE_NONOTIFY | O_CLOEXEC);
> +	BUILD_BUG_ON_MSG(upper_32_bits(VALID_OPEN_FLAGS),
> +			 "struct open_flags doesn't yet handle flags > 32 bits");
> +
> +	/*
> +	 * Strip flags that either shouldn't be set by userspace like
> +	 * FMODE_NONOTIFY or that aren't relevant in determining struct
> +	 * open_flags like O_CLOEXEC.
> +	 */
> +	flags &= ~strip;
>  
>  	/*
>  	 * Older syscalls implicitly clear all of the invalid flags or argument
> -- 
> 2.27.0
> 

- RGB

--
Richard Guy Briggs <rgb@redhat.com>
Sr. S/W Engineer, Kernel Security, Base Operating Systems
Remote, Ottawa, Red Hat Canada
IRC: rgb, SunRaycer
Voice: +1.647.777.2635, Internal: (81) 32635

