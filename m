Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6686B17BFAE
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Mar 2020 14:56:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726490AbgCFN4f (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 6 Mar 2020 08:56:35 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:55246 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726108AbgCFN4f (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 6 Mar 2020 08:56:35 -0500
Received: from b2b-5-147-251-51.unitymedia.biz ([5.147.251.51] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1jADSq-000460-VQ; Fri, 06 Mar 2020 13:56:33 +0000
Date:   Fri, 6 Mar 2020 14:56:32 +0100
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     David Howells <dhowells@redhat.com>
Cc:     linux-api@vger.kernel.org, viro@zeniv.linux.org.uk,
        torvalds@linux-foundation.org, metze@samba.org, cyphar@cyphar.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH] Mark AT_* path flags as deprecated and add missing
 RESOLVE_ flags
Message-ID: <20200306135632.j7kidnqm3edji6cz@wittgenstein>
References: <3774367.1583430213@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3774367.1583430213@warthog.procyon.org.uk>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Mar 05, 2020 at 05:43:33PM +0000, David Howells wrote:
> Do we want to do this?  Or should we duplicate the RESOLVE_* flags to AT_*
> flags so that existing *at() syscalls can make use of them?
> 
> David
> ---
> commit 448731bf3b29f2b1f7c969d7efe1f0673ae13b5e
> Author: David Howells <dhowells@redhat.com>
> Date:   Thu Mar 5 17:40:02 2020 +0000
> 
>     Mark AT_* flags as deprecated and add missing RESOLVE_ flags
>     
>     It has been suggested that new path-using system calls should use RESOLVE_*
>     flags instead of AT_* flags, but the RESOLVE_* flag functions are not a
>     superset of the AT_* flag functions.  So formalise this by:
>     
>      (1) In linux/fcntl.h, add a comment noting that the AT_* flags are
>          deprecated for new system calls and that RESOLVE_* flags should be
>          used instead.
>     
>      (2) Add some missing flags:
>     
>             RESOLVE_NO_TERMINAL_SYMLINKS    for AT_SYMLINK_NOFOLLOW
>             RESOLVE_NO_TERMINAL_AUTOMOUNTS  for AT_NO_AUTOMOUNT
>             RESOLVE_EMPTY_PATH              for AT_EMPTY_PATH
>     
>      (3) Make openat2() support RESOLVE_NO_TERMINAL_SYMLINKS.  LOOKUP_OPEN
>          internally implies LOOKUP_AUTOMOUNT, and AT_EMPTY_PATH is probably not
>          worth supporting (maybe use dup2() instead?).
>     
>     Reported-by: Stefan Metzmacher <metze@samba.org>
>     Signed-off-by: David Howells <dhowells@redhat.com>
>     cc: Aleksa Sarai <cyphar@cyphar.com>
> 
> diff --git a/fs/open.c b/fs/open.c
> index 0788b3715731..6946ad09b42b 100644
> --- a/fs/open.c
> +++ b/fs/open.c
> @@ -977,7 +977,7 @@ inline struct open_how build_open_how(int flags, umode_t mode)
>  inline int build_open_flags(const struct open_how *how, struct open_flags *op)
>  {
>  	int flags = how->flags;
> -	int lookup_flags = 0;
> +	int lookup_flags = LOOKUP_FOLLOW | LOOKUP_AUTOMOUNT;
>  	int acc_mode = ACC_MODE(flags);
>  
>  	/* Must never be set by userspace */
> @@ -1055,8 +1055,8 @@ inline int build_open_flags(const struct open_how *how, struct open_flags *op)
>  
>  	if (flags & O_DIRECTORY)
>  		lookup_flags |= LOOKUP_DIRECTORY;
> -	if (!(flags & O_NOFOLLOW))
> -		lookup_flags |= LOOKUP_FOLLOW;
> +	if (flags & O_NOFOLLOW)
> +		lookup_flags &= ~LOOKUP_FOLLOW;

Odd change. But I guess you're doing it for the sake of consistency
because of how you treat NO_TERMINAL_SYMLINKS below.

>  
>  	if (how->resolve & RESOLVE_NO_XDEV)
>  		lookup_flags |= LOOKUP_NO_XDEV;
> @@ -1068,6 +1068,8 @@ inline int build_open_flags(const struct open_how *how, struct open_flags *op)
>  		lookup_flags |= LOOKUP_BENEATH;
>  	if (how->resolve & RESOLVE_IN_ROOT)
>  		lookup_flags |= LOOKUP_IN_ROOT;
> +	if (how->resolve & RESOLVE_NO_TERMINAL_SYMLINKS)
> +		lookup_flags &= ~LOOKUP_FOLLOW;
>  
>  	op->lookup_flags = lookup_flags;
>  	return 0;
> diff --git a/include/linux/fcntl.h b/include/linux/fcntl.h
> index 7bcdcf4f6ab2..fd6ee34cce0f 100644
> --- a/include/linux/fcntl.h
> +++ b/include/linux/fcntl.h
> @@ -19,7 +19,8 @@
>  /* List of all valid flags for the how->resolve argument: */
>  #define VALID_RESOLVE_FLAGS \
>  	(RESOLVE_NO_XDEV | RESOLVE_NO_MAGICLINKS | RESOLVE_NO_SYMLINKS | \
> -	 RESOLVE_BENEATH | RESOLVE_IN_ROOT)
> +	 RESOLVE_BENEATH | RESOLVE_IN_ROOT | RESOLVE_NO_TERMINAL_SYMLINKS | \
> +	 RESOLVE_NO_TERMINAL_AUTOMOUNTS | RESOLVE_EMPTY_PATH)
>  
>  /* List of all open_how "versions". */
>  #define OPEN_HOW_SIZE_VER0	24 /* sizeof first published struct */
> diff --git a/include/uapi/linux/fcntl.h b/include/uapi/linux/fcntl.h
> index ca88b7bce553..9f5432dbd213 100644
> --- a/include/uapi/linux/fcntl.h
> +++ b/include/uapi/linux/fcntl.h
> @@ -84,9 +84,20 @@
>  #define DN_ATTRIB	0x00000020	/* File changed attibutes */
>  #define DN_MULTISHOT	0x80000000	/* Don't remove notifier */
>  
> -#define AT_FDCWD		-100    /* Special value used to indicate
> -                                           openat should use the current
> -                                           working directory. */
> +
> +/*
> + * Special dfd/dirfd file descriptor value used to indicate that *at() system
> + * calls should use the current working directory for relative paths.
> + */
> +#define AT_FDCWD		-100
> +
> +/*
> + * Pathwalk control flags, used for the *at() syscalls.  These should be
> + * considered deprecated and should not be used for new system calls.  The
> + * RESOLVE_* flags in <linux/openat2.h> should be used instead.

Agreed.
