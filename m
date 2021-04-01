Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 821CC3512CC
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Apr 2021 11:55:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233935AbhDAJyz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 1 Apr 2021 05:54:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:58684 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233859AbhDAJys (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 1 Apr 2021 05:54:48 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3D01161056;
        Thu,  1 Apr 2021 09:54:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1617270887;
        bh=A+v7RHVN3BTewytaTe5S519Sf+9IW7rG+6m4B5mcMco=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LVhSa3E0TWAZzsZ1RYpLMOxqeDg3TSSAZ2lQaIsCNPzgKAGTgIxwZVNIPixHWYSHM
         31BAjWBgMTq9cELrcDgQ5iBq6oEGJTqGG28qlbJcDr/obD/xGc2jnOfpXxuEyxsfIU
         lTz9jYVoNeWcafcGHimuxqtQkcEBxOzs1DV0tepY=
Date:   Thu, 1 Apr 2021 11:54:45 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Xie Yongji <xieyongji@bytedance.com>
Cc:     christian.brauner@ubuntu.com, hch@infradead.org, arve@android.com,
        tkjos@android.com, maco@android.com, joel@joelfernandes.org,
        hridya@google.com, surenb@google.com, viro@zeniv.linux.org.uk,
        sargun@sargun.me, keescook@chromium.org, jasowang@redhat.com,
        devel@driverdev.osuosl.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 2/2] binder: Use receive_fd() to receive file from
 another process
Message-ID: <YGWYZYbBzglUCxB2@kroah.com>
References: <20210401090932.121-1-xieyongji@bytedance.com>
 <20210401090932.121-3-xieyongji@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210401090932.121-3-xieyongji@bytedance.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Apr 01, 2021 at 05:09:32PM +0800, Xie Yongji wrote:
> Use receive_fd() to receive file from another process instead of
> combination of get_unused_fd_flags() and fd_install(). This simplifies
> the logic and also makes sure we don't miss any security stuff.

But no logic is simplified here, and nothing is "missed", so I do not
understand this change at all.

> 
> Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
> ---
>  drivers/android/binder.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/android/binder.c b/drivers/android/binder.c
> index c119736ca56a..080bcab7d632 100644
> --- a/drivers/android/binder.c
> +++ b/drivers/android/binder.c
> @@ -3728,7 +3728,7 @@ static int binder_apply_fd_fixups(struct binder_proc *proc,
>  	int ret = 0;
>  
>  	list_for_each_entry(fixup, &t->fd_fixups, fixup_entry) {
> -		int fd = get_unused_fd_flags(O_CLOEXEC);
> +		int fd  = receive_fd(fixup->file, O_CLOEXEC);

Why 2 spaces?

>  
>  		if (fd < 0) {
>  			binder_debug(BINDER_DEBUG_TRANSACTION,
> @@ -3741,7 +3741,7 @@ static int binder_apply_fd_fixups(struct binder_proc *proc,
>  			     "fd fixup txn %d fd %d\n",
>  			     t->debug_id, fd);
>  		trace_binder_transaction_fd_recv(t, fd, fixup->offset);
> -		fd_install(fd, fixup->file);
> +		fput(fixup->file);

Are you sure this is the same???

I d onot understand the need for this change at all, what is wrong with
the existing code here?

thanks,

greg k-h
