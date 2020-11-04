Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E5742A6155
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Nov 2020 11:14:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728999AbgKDKOd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Nov 2020 05:14:33 -0500
Received: from mx2.suse.de ([195.135.220.15]:38892 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728523AbgKDKOc (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Nov 2020 05:14:32 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 91879ABDE;
        Wed,  4 Nov 2020 10:14:31 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 2BF141E1305; Wed,  4 Nov 2020 11:14:31 +0100 (CET)
Date:   Wed, 4 Nov 2020 11:14:31 +0100
From:   Jan Kara <jack@suse.cz>
To:     =?utf-8?B?UGF3ZcWC?= Jasiak <pawel@jasiak.xyz>
Cc:     Jan Kara <jack@suse.cz>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Brian Gerst <brgerst@gmail.com>,
        Andy Lutomirski <luto@kernel.org>
Subject: Re: PROBLEM: fanotify_mark EFAULT on x86
Message-ID: <20201104101431.GB5600@quack2.suse.cz>
References: <20201101212738.GA16924@gmail.com>
 <20201102122638.GB23988@quack2.suse.cz>
 <20201103211747.GA3688@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201103211747.GA3688@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue 03-11-20 22:17:47, Paweł Jasiak wrote:
> I have written small patch that fixes problem for me and doesn't break
> x86_64.

Yeah, that looks sensible, thanks for the patch. But I'm waiting for some
explanation from x86 folks when compat handlers are really needed and why
it wasn't needed before syscall wrapper rewrite in 5.7-rc1 and is needed
now. Brian, Andy, Thomas?

								Honza

> 
> diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
> index 3e01d8f2ab90..cf0b97309975 100644
> --- a/fs/notify/fanotify/fanotify_user.c
> +++ b/fs/notify/fanotify/fanotify_user.c
> @@ -1285,12 +1285,27 @@ static int do_fanotify_mark(int fanotify_fd, unsigned int flags, __u64 mask,
>  	return ret;
>  }
>  
> +#if defined(CONFIG_X86) && !defined(CONFIG_64BIT)
> +SYSCALL_DEFINE6(fanotify_mark,
> +			int, fanotify_fd, unsigned int, flags, __u32, mask0,
> +			__u32, mask1, int, dfd, const char  __user *, pathname)
> +{
> +	return do_fanotify_mark(fanotify_fd, flags,
> +#ifdef __BIG_ENDIAN
> +				((__u64)mask0 << 32) | mask1,
> +#else
> +				((__u64)mask1 << 32) | mask0,
> +#endif
> +				 dfd, pathname);
> +}
> +#else
>  SYSCALL_DEFINE5(fanotify_mark, int, fanotify_fd, unsigned int, flags,
>  			      __u64, mask, int, dfd,
>  			      const char  __user *, pathname)
>  {
>  	return do_fanotify_mark(fanotify_fd, flags, mask, dfd, pathname);
>  }
> +#endif
>  
>  #ifdef CONFIG_COMPAT
>  COMPAT_SYSCALL_DEFINE6(fanotify_mark,
> 
> 
> -- 
> 
> Paweł Jasiak
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
