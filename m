Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 46C542038B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 May 2019 12:35:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726948AbfEPKfu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 May 2019 06:35:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:48626 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726864AbfEPKfu (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 May 2019 06:35:50 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7FE49206BF;
        Thu, 16 May 2019 10:35:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558002950;
        bh=0eo8sI9rv03UK2hDy0Jhg7s2bx/YLgxcOaSorx1Pj+s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fpses0/ZDSEdkVfTBYXMyQB0KH6vmk0PamqzVcv5M67FYlvoi3oFnmNQmxvX0jxuO
         ZsJNd81gTXTtMDw1gVzr5UAdDwBqcyRTCTOHpzd27gqcrmxB+F5lUzbbv5tsmBqnnj
         ljGb9lELkbNyzCzygyotfNRiEMOj3Xjjg2Gd3YeM=
Date:   Thu, 16 May 2019 12:35:47 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jan Kara <jack@suse.cz>,
        Matthew Bobrowski <mbobrowski@mbobrowski.org>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 06/14] fs: convert debugfs to use simple_remove()
 helper
Message-ID: <20190516103547.GA2125@kroah.com>
References: <20190516102641.6574-1-amir73il@gmail.com>
 <20190516102641.6574-7-amir73il@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190516102641.6574-7-amir73il@gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, May 16, 2019 at 01:26:33PM +0300, Amir Goldstein wrote:
> This will allow generating fsnotify delete events after the
> fsnotify_nameremove() hook is removed from d_delete().
> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> ---
>  fs/debugfs/inode.c | 20 ++++----------------
>  1 file changed, 4 insertions(+), 16 deletions(-)
> 
> diff --git a/fs/debugfs/inode.c b/fs/debugfs/inode.c
> index acef14ad53db..bc96198df1d4 100644
> --- a/fs/debugfs/inode.c
> +++ b/fs/debugfs/inode.c
> @@ -617,13 +617,10 @@ struct dentry *debugfs_create_symlink(const char *name, struct dentry *parent,
>  }
>  EXPORT_SYMBOL_GPL(debugfs_create_symlink);
>  
> -static void __debugfs_remove_file(struct dentry *dentry, struct dentry *parent)
> +static void __debugfs_file_removed(struct dentry *dentry)
>  {
>  	struct debugfs_fsdata *fsd;
>  
> -	simple_unlink(d_inode(parent), dentry);
> -	d_delete(dentry);

What happened to this call?  Why no unlinking anymore?

> -
>  	/*
>  	 * Paired with the closing smp_mb() implied by a successful
>  	 * cmpxchg() in debugfs_file_get(): either
> @@ -643,18 +640,9 @@ static int __debugfs_remove(struct dentry *dentry, struct dentry *parent)
>  	int ret = 0;
>  
>  	if (simple_positive(dentry)) {
> -		dget(dentry);
> -		if (!d_is_reg(dentry)) {
> -			if (d_is_dir(dentry))
> -				ret = simple_rmdir(d_inode(parent), dentry);
> -			else
> -				simple_unlink(d_inode(parent), dentry);
> -			if (!ret)
> -				d_delete(dentry);
> -		} else {
> -			__debugfs_remove_file(dentry, parent);
> -		}
> -		dput(dentry);
> +		ret = simple_remove(d_inode(parent), dentry);
> +		if (d_is_reg(dentry))

Can't dentry be gone here?  This doesn't seem to match the same pattern
as before.

What am I missing?

confused,

greg k-h
