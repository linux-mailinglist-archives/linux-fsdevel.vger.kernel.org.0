Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 47B1F33118
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Jun 2019 15:31:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728369AbfFCNbo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 3 Jun 2019 09:31:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:46568 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726842AbfFCNbo (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 3 Jun 2019 09:31:44 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 12EDD27DBB;
        Mon,  3 Jun 2019 13:31:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559568703;
        bh=EcG4Koio8JYSipmjjaMZpaCLkrZL8Ht3hcsQOwifFSE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=O7gwDT4uJQDmJv0KtTeEw4JsKji2lR7yWwHFCJEsljKzDORRpc/H/JELET6BAcQX8
         oc4yzw6UUwZnPUbQv6rzYE1OvUaMce4Rko8b7Cmk3kqsRNHCCPFX/4f0aM+mO329n4
         pleMH7fTj4RWa6HcLwOZ7kHl6OhXsOXUdcoLr7DI=
Date:   Mon, 3 Jun 2019 15:31:40 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jan Kara <jack@suse.cz>, David Sterba <dsterba@suse.com>,
        Christoph Hellwig <hch@lst.de>,
        Joel Becker <jlbec@evilplan.org>,
        John Johansen <john.johansen@canonical.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v3 07/10] debugfs: call fsnotify_{unlink,rmdir}() hooks
Message-ID: <20190603133140.GB24574@kroah.com>
References: <20190526143411.11244-1-amir73il@gmail.com>
 <20190526143411.11244-8-amir73il@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190526143411.11244-8-amir73il@gmail.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, May 26, 2019 at 05:34:08PM +0300, Amir Goldstein wrote:
> This will allow generating fsnotify delete events after the
> fsnotify_nameremove() hook is removed from d_delete().
> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> ---
>  fs/debugfs/inode.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/fs/debugfs/inode.c b/fs/debugfs/inode.c
> index d89874da9791..1e444fe1f778 100644
> --- a/fs/debugfs/inode.c
> +++ b/fs/debugfs/inode.c
> @@ -643,8 +643,11 @@ static int __debugfs_remove(struct dentry *dentry, struct dentry *parent)
>  		dget(dentry);
>  		if (d_is_dir(dentry)) {
>  			ret = simple_rmdir(d_inode(parent), dentry);
> +			if (!ret)
> +				fsnotify_rmdir(d_inode(parent), dentry);
>  		} else {
>  			simple_unlink(d_inode(parent), dentry);
> +			fsnotify_unlink(d_inode(parent), dentry);
>  		}
>  		if (!ret)
>  			d_delete(dentry);
> -- 
> 2.17.1

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
