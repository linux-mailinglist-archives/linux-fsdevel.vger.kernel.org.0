Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E9CA34AC5C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Mar 2021 17:13:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230204AbhCZQNN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 26 Mar 2021 12:13:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230051AbhCZQMz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 26 Mar 2021 12:12:55 -0400
Received: from zeniv-ca.linux.org.uk (unknown [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DFF8C0613AA;
        Fri, 26 Mar 2021 09:12:54 -0700 (PDT)
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lPp4S-0001TY-0Z; Fri, 26 Mar 2021 16:12:24 +0000
Date:   Fri, 26 Mar 2021 16:12:23 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Christoph Hellwig <hch@lst.de>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Arnd Bergmann <arnd@arndb.de>, Brian Gerst <brgerst@gmail.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        linux-arm-kernel@lists.infradead.org, x86@kernel.org,
        linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] exec: simplify the compat syscall handling
Message-ID: <YF4H58gozyNkoCeO@zeniv-ca.linux.org.uk>
References: <20210326143831.1550030-1-hch@lst.de>
 <20210326143831.1550030-4-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210326143831.1550030-4-hch@lst.de>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Mar 26, 2021 at 03:38:30PM +0100, Christoph Hellwig wrote:

> -static const char __user *get_user_arg_ptr(struct user_arg_ptr argv, int nr)
> +static const char __user *
> +get_user_arg_ptr(const char __user *const __user *argv, int nr)
>  {
> -	const char __user *native;
> -
> -#ifdef CONFIG_COMPAT
> -	if (unlikely(argv.is_compat)) {
> +	if (in_compat_syscall()) {
> +		const compat_uptr_t __user *compat_argv =
> +			compat_ptr((unsigned long)argv);
>  		compat_uptr_t compat;
>  
> -		if (get_user(compat, argv.ptr.compat + nr))
> +		if (get_user(compat, compat_argv + nr))
>  			return ERR_PTR(-EFAULT);
> -
>  		return compat_ptr(compat);
> -	}
> -#endif
> -
> -	if (get_user(native, argv.ptr.native + nr))
> -		return ERR_PTR(-EFAULT);
> +	} else {
> +		const char __user *native;
>  
> -	return native;
> +		if (get_user(native, argv + nr))
> +			return ERR_PTR(-EFAULT);
> +		return native;
> +	}
>  }

Yecchhh....  So you have in_compat_syscall() called again and again, for
each argument in the list?  I agree that current version is fucking ugly,
but I really hate that approach ;-/
