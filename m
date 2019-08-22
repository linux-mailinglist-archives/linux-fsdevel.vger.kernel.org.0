Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5A91A99E50
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2019 19:54:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731960AbfHVRxd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 22 Aug 2019 13:53:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59226 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726234AbfHVRxd (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 22 Aug 2019 13:53:33 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id DE11D3082E61;
        Thu, 22 Aug 2019 17:53:32 +0000 (UTC)
Received: from segfault.boston.devel.redhat.com (segfault.boston.devel.redhat.com [10.19.60.26])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id BD21D5D6A7;
        Thu, 22 Aug 2019 17:53:31 +0000 (UTC)
From:   Jeff Moyer <jmoyer@redhat.com>
To:     Guillem Jover <guillem@hadrons.org>
Cc:     linux-aio@kvack.org, Christoph Hellwig <hch@lst.de>,
        Benjamin LaHaise <bcrl@kvack.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] aio: Fix io_pgetevents() struct __compat_aio_sigset layout
References: <20190821033820.14155-1-guillem@hadrons.org>
X-PGP-KeyID: 1F78E1B4
X-PGP-CertKey: F6FE 280D 8293 F72C 65FD  5A58 1FF8 A7CA 1F78 E1B4
Date:   Thu, 22 Aug 2019 13:53:30 -0400
In-Reply-To: <20190821033820.14155-1-guillem@hadrons.org> (Guillem Jover's
        message of "Wed, 21 Aug 2019 05:38:20 +0200")
Message-ID: <x49ef1dozmt.fsf@segfault.boston.devel.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.46]); Thu, 22 Aug 2019 17:53:33 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Guillem Jover <guillem@hadrons.org> writes:

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

Looks good, thanks for finding and fixing this!

Reviewed-by: Jeff Moyer <jmoyer@redhat.com>

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
