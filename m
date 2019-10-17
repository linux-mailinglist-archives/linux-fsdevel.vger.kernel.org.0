Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 81333DAEB5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Oct 2019 15:48:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436721AbfJQNsD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Oct 2019 09:48:03 -0400
Received: from mx2.suse.de ([195.135.220.15]:37312 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2394727AbfJQNsC (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Oct 2019 09:48:02 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id DCAF2B46C;
        Thu, 17 Oct 2019 13:48:00 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 2BEA51E485F; Thu, 17 Oct 2019 15:48:00 +0200 (CEST)
Date:   Thu, 17 Oct 2019 15:48:00 +0200
From:   Jan Kara <jack@suse.cz>
To:     Guillem Jover <guillem@hadrons.org>
Cc:     linux-aio@kvack.org, Christoph Hellwig <hch@lst.de>,
        Jeff Moyer <jmoyer@redhat.com>,
        Benjamin LaHaise <bcrl@kvack.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] aio: Fix io_pgetevents() struct __compat_aio_sigset
 layout
Message-ID: <20191017134800.GA27576@quack2.suse.cz>
References: <20190821033820.14155-1-guillem@hadrons.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190821033820.14155-1-guillem@hadrons.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 21-08-19 05:38:20, Guillem Jover wrote:
> This type is used to pass the sigset_t from userland to the kernel,
> but it was using the kernel native pointer type for the member
> representing the compat userland pointer to the userland sigset_t.
> 
> This messes up the layout, and makes the kernel eat up both the
> userland pointer and the size members into the kernel pointer, and
> then reads garbage into the kernel sigsetsize. Which makes the sigset_t
> size consistency check fail, and consequently the syscall always
> returns -EINVAL.
> 
> This breaks both libaio and strace on 32-bit userland running on 64-bit
> kernels. And there are apparently no users in the wild of the current
> broken layout (at least according to codesearch.debian.org and a brief
> check over github.com search). So it looks safe to fix this directly
> in the kernel, instead of either letting userland deal with this
> permanently with the additional overhead or trying to make the syscall
> infer what layout userland used, even though this is also being worked
> around in libaio to temporarily cope with kernels that have not yet
> been fixed.
> 
> We use a proper compat_uptr_t instead of a compat_sigset_t pointer.
> 
> Fixes: 7a074e96 ("aio: implement io_pgetevents")
> Signed-off-by: Guillem Jover <guillem@hadrons.org>

This patch seems to have fallen through the cracks. Al?

								Honza

> ---
>  fs/aio.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/aio.c b/fs/aio.c
> index 01e0fb9ae45a..056f291bc66f 100644
> --- a/fs/aio.c
> +++ b/fs/aio.c
> @@ -2179,7 +2179,7 @@ SYSCALL_DEFINE5(io_getevents_time32, __u32, ctx_id,
>  #ifdef CONFIG_COMPAT
>  
>  struct __compat_aio_sigset {
> -	compat_sigset_t __user	*sigmask;
> +	compat_uptr_t		sigmask;
>  	compat_size_t		sigsetsize;
>  };
>  
> @@ -2204,7 +2204,7 @@ COMPAT_SYSCALL_DEFINE6(io_pgetevents,
>  	if (usig && copy_from_user(&ksig, usig, sizeof(ksig)))
>  		return -EFAULT;
>  
> -	ret = set_compat_user_sigmask(ksig.sigmask, ksig.sigsetsize);
> +	ret = set_compat_user_sigmask(compat_ptr(ksig.sigmask), ksig.sigsetsize);
>  	if (ret)
>  		return ret;
>  
> @@ -2239,7 +2239,7 @@ COMPAT_SYSCALL_DEFINE6(io_pgetevents_time64,
>  	if (usig && copy_from_user(&ksig, usig, sizeof(ksig)))
>  		return -EFAULT;
>  
> -	ret = set_compat_user_sigmask(ksig.sigmask, ksig.sigsetsize);
> +	ret = set_compat_user_sigmask(compat_ptr(ksig.sigmask), ksig.sigsetsize);
>  	if (ret)
>  		return ret;
>  
> -- 
> 2.23.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
