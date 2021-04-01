Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CC2E3512BE
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Apr 2021 11:53:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233553AbhDAJwm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 1 Apr 2021 05:52:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:58266 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233670AbhDAJwg (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 1 Apr 2021 05:52:36 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 87A5961057;
        Thu,  1 Apr 2021 09:52:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1617270756;
        bh=WHuvuLwY5ZJzXTO21PWIte9+S4GwMD6X0OWMiT8SSu8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OlOAJLbasE0ogij9w8e0cFnlQojCi7vbXuC+/FcDVonQf6yP9VunIJGHmpERSZrLS
         YZ614AqK6+kE5rLs4XT0HFZKbxIulRILiCHQMNX7MDEWAcJ72zfYnbHHdQBKuzqMZB
         j2gLEgr4muLRwLsypUVR6ZyQHCCBtWhiUSa8jM6Q=
Date:   Thu, 1 Apr 2021 11:52:33 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Xie Yongji <xieyongji@bytedance.com>
Cc:     christian.brauner@ubuntu.com, hch@infradead.org, arve@android.com,
        tkjos@android.com, maco@android.com, joel@joelfernandes.org,
        hridya@google.com, surenb@google.com, viro@zeniv.linux.org.uk,
        sargun@sargun.me, keescook@chromium.org, jasowang@redhat.com,
        devel@driverdev.osuosl.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 1/2] file: Export receive_fd() to modules
Message-ID: <YGWX4aIE5QNxsJQ9@kroah.com>
References: <20210401090932.121-1-xieyongji@bytedance.com>
 <20210401090932.121-2-xieyongji@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210401090932.121-2-xieyongji@bytedance.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Apr 01, 2021 at 05:09:31PM +0800, Xie Yongji wrote:
> Export receive_fd() so that some modules can use
> it to pass file descriptor across processes without
> missing any security stuffs.
> 
> Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
> ---
>  fs/file.c            | 6 ++++++
>  include/linux/file.h | 7 +++----
>  2 files changed, 9 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/file.c b/fs/file.c
> index 56986e55befa..2a80c6c3e147 100644
> --- a/fs/file.c
> +++ b/fs/file.c
> @@ -1107,6 +1107,12 @@ int receive_fd_replace(int new_fd, struct file *file, unsigned int o_flags)
>  	return new_fd;
>  }
>  
> +int receive_fd(struct file *file, unsigned int o_flags)
> +{
> +	return __receive_fd(file, NULL, o_flags);
> +}
> +EXPORT_SYMBOL(receive_fd);

What module uses this?

And why not EXPORT_SYMBOL_GPL()?

thanks,

greg k-h
