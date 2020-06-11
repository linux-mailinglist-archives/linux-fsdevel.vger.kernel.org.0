Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59E691F6003
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Jun 2020 04:30:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726352AbgFKCaD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 10 Jun 2020 22:30:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:46356 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726279AbgFKCaD (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 10 Jun 2020 22:30:03 -0400
Received: from sol.localdomain (c-107-3-166-239.hsd1.ca.comcast.net [107.3.166.239])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1681920747;
        Thu, 11 Jun 2020 02:30:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591842602;
        bh=Sa5NMr2RUauBxi8k2hYytzsM18wq136O0GTDhQJvVWY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iGX6hAO1MmuupwZ/PVysgzk4z6ePQxprM3Jm4GUUXOYF4A6K5lim4X1OFWdGsw18L
         ODaSuTiqyE0A0r+HSYSS4Gk27OPgJdIZy4HdpsF5zWDVsnVhW5IXLmWhAhJBMkqnUW
         EkW6u7wh7YjmIqUePi1yh3Nnc+o6bFBsuJD9KIg0=
Date:   Wed, 10 Jun 2020 19:30:00 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-fsdevel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     Daeho Jeong <daeho43@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vfs: don't unnecessarily clone write access for writable
 fds
Message-ID: <20200611023000.GE1339@sol.localdomain>
References: <20200611014945.237210-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200611014945.237210-1-ebiggers@kernel.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jun 10, 2020 at 06:49:45PM -0700, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> There's no need for mnt_want_write_file() to clone a write reference to
> the mount when the file is already open for writing, provided that
> mnt_drop_write_file() is changed to conditionally drop the reference.
> 
> We seem to have ended up in the current situation because
> mnt_want_write_file() used to be paired with mnt_drop_write(), due to
> mnt_drop_write_file() not having been added yet.  So originally
> mnt_want_write_file() did have to always take a reference.
> 
> But later mnt_drop_write_file() was added, and all callers of
> mnt_want_write_file() were paired with it.  This makes the compatibility
> between mnt_want_write_file() and mnt_drop_write() no longer necessary.
> 
> Therefore, make __mnt_want_write_file() and __mnt_drop_write_file() be
> no-ops on files already open for writing.  This removes the only caller
> of mnt_clone_write(), so remove that too.
> 
> Signed-off-by: Eric Biggers <ebiggers@google.com>
> ---
>  fs/namespace.c        | 43 ++++++++++---------------------------------
>  include/linux/mount.h |  1 -
>  2 files changed, 10 insertions(+), 34 deletions(-)
> 
> diff --git a/fs/namespace.c b/fs/namespace.c
> index 7cd64240916573..7e78c7ae4ab34d 100644
> --- a/fs/namespace.c
> +++ b/fs/namespace.c
> @@ -359,51 +359,27 @@ int mnt_want_write(struct vfsmount *m)
>  }
>  EXPORT_SYMBOL_GPL(mnt_want_write);
>  
> -/**
> - * mnt_clone_write - get write access to a mount
> - * @mnt: the mount on which to take a write
> - *
> - * This is effectively like mnt_want_write, except
> - * it must only be used to take an extra write reference
> - * on a mountpoint that we already know has a write reference
> - * on it. This allows some optimisation.
> - *
> - * After finished, mnt_drop_write must be called as usual to
> - * drop the reference.
> - */
> -int mnt_clone_write(struct vfsmount *mnt)
> -{
> -	/* superblock may be r/o */
> -	if (__mnt_is_readonly(mnt))
> -		return -EROFS;
> -	preempt_disable();
> -	mnt_inc_writers(real_mount(mnt));
> -	preempt_enable();
> -	return 0;
> -}
> -EXPORT_SYMBOL_GPL(mnt_clone_write);

Sorry, I think I missed something -- the __mnt_is_readonly() check should be
kept because there are cases where SB_RDONLY can be set when there are writable
file descriptors.  For example, ext4 with errors=remount-ro.

Interestingly though, sys_write() skips that check because it uses
file_start_write() which only does the freeze protection.

- Eric
