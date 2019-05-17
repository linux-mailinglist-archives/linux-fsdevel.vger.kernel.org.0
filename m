Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7BD1321C89
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 May 2019 19:33:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727599AbfEQRdt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 May 2019 13:33:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:42094 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726092AbfEQRdt (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 May 2019 13:33:49 -0400
Received: from oasis.local.home (unknown [216.9.110.6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C3DCC216C4;
        Fri, 17 May 2019 17:33:48 +0000 (UTC)
Date:   Fri, 17 May 2019 13:33:45 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jan Kara <jack@suse.cz>,
        Matthew Bobrowski <mbobrowski@mbobrowski.org>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 07/14] fs: convert tracefs to use simple_remove()
 helper
Message-ID: <20190517133345.61ba49e1@oasis.local.home>
In-Reply-To: <20190516102641.6574-8-amir73il@gmail.com>
References: <20190516102641.6574-1-amir73il@gmail.com>
        <20190516102641.6574-8-amir73il@gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 16 May 2019 13:26:34 +0300
Amir Goldstein <amir73il@gmail.com> wrote:

> This will allow generating fsnotify delete events after the
> fsnotify_nameremove() hook is removed from d_delete().

I added this and the patch you forwarded to me (thank you for doing
that), and ran some smoke tests against it. It didn't trigger any
regressions in those tests.

Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

-- Steve

> 
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> ---
>  fs/tracefs/inode.c | 23 ++++-------------------
>  1 file changed, 4 insertions(+), 19 deletions(-)
> 
> diff --git a/fs/tracefs/inode.c b/fs/tracefs/inode.c
> index 7098c49f3693..6ac31ea9ad5d 100644
> --- a/fs/tracefs/inode.c
> +++ b/fs/tracefs/inode.c
> @@ -501,25 +501,10 @@ __init struct dentry
> *tracefs_create_instance_dir(const char *name, 
>  static int __tracefs_remove(struct dentry *dentry, struct dentry
> *parent) {
> -	int ret = 0;
> -
> -	if (simple_positive(dentry)) {
> -		if (dentry->d_inode) {
> -			dget(dentry);
> -			switch (dentry->d_inode->i_mode & S_IFMT) {
> -			case S_IFDIR:
> -				ret = simple_rmdir(parent->d_inode,
> dentry);
> -				break;
> -			default:
> -				simple_unlink(parent->d_inode,
> dentry);
> -				break;
> -			}
> -			if (!ret)
> -				d_delete(dentry);
> -			dput(dentry);
> -		}
> -	}
> -	return ret;
> +	if (simple_positive(dentry))
> +		return simple_remove(d_inode(parent), dentry);
> +
> +	return 0;
>  }
>  
>  /**

