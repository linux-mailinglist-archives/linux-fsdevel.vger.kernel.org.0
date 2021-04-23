Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4351C36940A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Apr 2021 15:50:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229794AbhDWNva (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 23 Apr 2021 09:51:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:54983 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229549AbhDWNva (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 23 Apr 2021 09:51:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1619185852;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lFGEqMuKvihT620aUZZA3l97wbM2Xz66qumvv1hW9+Y=;
        b=di+uYPN4y7yhjuUoUjJ10BGELjHvgFqnw59pGmY4tGI1PcTgyDZiGbzYoR1ox6BJHnKEVY
        9uAkL/UeMaCjCW3/B/+adsCmwsx6OhRVGlrA6tnP2X0I1jEIla0gt+NSAb/6ncKQKAhoyL
        iyLP9649172vPnqrq4p8zl6v9r6VBiI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-156-HobBfQnYNN-pJSwISCIfrQ-1; Fri, 23 Apr 2021 09:50:50 -0400
X-MC-Unique: HobBfQnYNN-pJSwISCIfrQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BDD1210054F6;
        Fri, 23 Apr 2021 13:50:49 +0000 (UTC)
Received: from madcap2.tricolour.ca (unknown [10.10.110.24])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C6DAA5C1BB;
        Fri, 23 Apr 2021 13:50:44 +0000 (UTC)
Date:   Fri, 23 Apr 2021 09:50:42 -0400
From:   Richard Guy Briggs <rgb@redhat.com>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>, Aleksa Sarai <cyphar@cyphar.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: Re: [PATCH 2/3] open: don't silently ignore unknown O-flags in
 openat2()
Message-ID: <20210423135042.GM3141668@madcap2.tricolour.ca>
References: <20210423111037.3590242-1-brauner@kernel.org>
 <20210423111037.3590242-2-brauner@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210423111037.3590242-2-brauner@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2021-04-23 13:10, Christian Brauner wrote:
> From: Christian Brauner <christian.brauner@ubuntu.com>
> 
> The new openat2() syscall verifies that no unknown O-flag values are
> set and returns an error to userspace if they are while the older open
> syscalls like open() and openat2() simply ignore unknown flag values:
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
>           .flags = O_RDONLY | O_FLAG_CURRENTLY_INVALID_LOWE32,
>           .resolve = 0,
>   };
> 
>   struct open_how how_upper32 = {
>           .flags = O_RDONLY | O_FLAG_CURRENTLY_INVALID_LOWE32,
>           .resolve = 0,
>   };
> 
>   /* fails */
>   fd = openat2(-EBADF, "/dev/null", &how_lower32, sizeof(how_lower32));
> 
>   /* succeeds */
>   fd = openat2(-EBADF, "/dev/null", &how_upper32, sizeof(how_upper32));
> 
> That seems like a bug. Fix it by preventing the truncation in
> build_open_flags().
> 
> There's a snafu here though stripping FMODE_* directly from flags would
> cause the upper 32 bits to be truncated as well due to integer promotion
> rules since FMODE_* is unsigned int, O_* are signed ints (yuck).
> 
> This change shouldn't regress old open syscalls since they silently
> truncate any unknown values.
> 
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Aleksa Sarai <cyphar@cyphar.com>
> Cc: Al Viro <viro@zeniv.linux.org.uk>
> Cc: linux-fsdevel@vger.kernel.org
> Reported-by: Richard Guy Briggs <rgb@redhat.com>
> Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
> ---
>  fs/open.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/open.c b/fs/open.c
> index e53af13b5835..96644aa325eb 100644
> --- a/fs/open.c
> +++ b/fs/open.c
> @@ -1002,12 +1002,17 @@ inline struct open_how build_open_how(int flags, umode_t mode)
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
> +	/*
> +	 * Strip flags that either shouldn't be set by userspace like
> +	 * FMODE_NONOTIFY or that aren't relevant in determining struct
> +	 * open_flags like O_CLOEXEC.
> +	 */
> +	flags &= ~strip;

Would it not be simpler to only change flags' type (and elaborated
comment) and leave the original strip or will that run afoul of FMODE_*
type clamping to u32?

To guard against this assignment of u64 flags to op->open_flags losing
info in the future further down in this function, it would be necessary
to add something like the following that you suggested to
include/linux/fcntl.h following the definition of VALID_OPEN_FLAGS:

	BUILD_BUG_ON_MSG(upper_32_bits(VALID_OPEN_FLAGS), "will be ignored by open_flags assignment in build_open_flags()");

A similar check could be added for O_ACCMODE for 32 bits in general, and
for 8 bits for Tomoyo.

>  	/*
>  	 * Older syscalls implicitly clear all of the invalid flags or argument
> -- 
> 2.27.0

- RGB

--
Richard Guy Briggs <rgb@redhat.com>
Sr. S/W Engineer, Kernel Security, Base Operating Systems
Remote, Ottawa, Red Hat Canada
IRC: rgb, SunRaycer
Voice: +1.647.777.2635, Internal: (81) 32635

