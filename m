Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 76344665D0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Jul 2019 06:34:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729441AbfGLEeJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 12 Jul 2019 00:34:09 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:60344 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726610AbfGLEeI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 12 Jul 2019 00:34:08 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hlnFe-0003Rz-Ja; Fri, 12 Jul 2019 04:33:42 +0000
Date:   Fri, 12 Jul 2019 05:33:42 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Aleksa Sarai <cyphar@cyphar.com>
Cc:     Jeff Layton <jlayton@kernel.org>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Arnd Bergmann <arnd@arndb.de>,
        David Howells <dhowells@redhat.com>,
        Shuah Khan <shuah@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Christian Brauner <christian@brauner.io>,
        David Drysdale <drysdale@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Eric Biederman <ebiederm@xmission.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Jann Horn <jannh@google.com>, Tycho Andersen <tycho@tycho.ws>,
        Chanho Min <chanho.min@lge.com>,
        Oleg Nesterov <oleg@redhat.com>, Aleksa Sarai <asarai@suse.de>,
        containers@lists.linux-foundation.org, linux-alpha@vger.kernel.org,
        linux-api@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        linux-xtensa@linux-xtensa.org, sparclinux@vger.kernel.org
Subject: Re: [PATCH v9 05/10] namei: O_BENEATH-style path resolution flags
Message-ID: <20190712043341.GI17978@ZenIV.linux.org.uk>
References: <20190706145737.5299-1-cyphar@cyphar.com>
 <20190706145737.5299-6-cyphar@cyphar.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190706145737.5299-6-cyphar@cyphar.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Jul 07, 2019 at 12:57:32AM +1000, Aleksa Sarai wrote:

> @@ -1442,8 +1464,11 @@ static int follow_dotdot_rcu(struct nameidata *nd)
>  	struct inode *inode = nd->inode;
>  
>  	while (1) {
> -		if (path_equal(&nd->path, &nd->root))
> +		if (path_equal(&nd->path, &nd->root)) {
> +			if (unlikely(nd->flags & LOOKUP_BENEATH))
> +				return -EXDEV;

> @@ -1468,6 +1493,8 @@ static int follow_dotdot_rcu(struct nameidata *nd)
>  				return -ECHILD;
>  			if (&mparent->mnt == nd->path.mnt)
>  				break;
> +			if (unlikely(nd->flags & LOOKUP_XDEV))
> +				return -EXDEV;
>  			/* we know that mountpoint was pinned */
>  			nd->path.dentry = mountpoint;
>  			nd->path.mnt = &mparent->mnt;
> @@ -1482,6 +1509,8 @@ static int follow_dotdot_rcu(struct nameidata *nd)
>  			return -ECHILD;
>  		if (!mounted)
>  			break;
> +		if (unlikely(nd->flags & LOOKUP_XDEV))
> +			return -EXDEV;

Are you sure these failure exits in follow_dotdot_rcu() won't give
suprious hard errors?

> +	if (unlikely(nd->flags & LOOKUP_BENEATH)) {
> +		error = dirfd_path_init(nd);
> +		if (unlikely(error))
> +			return ERR_PTR(error);
> +		nd->root = nd->path;
> +		if (!(nd->flags & LOOKUP_RCU))
> +			path_get(&nd->root);
> +	}
>  	if (*s == '/') {
>  		if (likely(!nd->root.mnt))
>  			set_root(nd);
> @@ -2350,9 +2400,11 @@ static const char *path_init(struct nameidata *nd, unsigned flags)
>  			s = ERR_PTR(error);
>  		return s;
>  	}
> -	error = dirfd_path_init(nd);
> -	if (unlikely(error))
> -		return ERR_PTR(error);
> +	if (likely(!nd->path.mnt)) {

Is that a weird way of saying "if we hadn't already called dirfd_path_init()"?
