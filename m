Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DDE3033116
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Jun 2019 15:31:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728724AbfFCNbZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 3 Jun 2019 09:31:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:46296 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726842AbfFCNbZ (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 3 Jun 2019 09:31:25 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 44AA327DB3;
        Mon,  3 Jun 2019 13:31:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559568684;
        bh=/jZ8CPirphc3NTxeejPO2up85CvS1kEsbbkCzDT3jGk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=u3ps8LXR96wG5IJvv4FS5U9GPaSAE7Ze5hPnOM8aVbDnhsxXL0tsuV38WF8RGvKdc
         bN2Nm5CKXvH9xObtTWt57QzBt8FKDuAlX/BnqhJIAB7jiikSFCJBCEQApNhKK/4kwD
         HBvIJN0AXLMt6TN635Jhejqtk300cr2JGVUksZJk=
Date:   Mon, 3 Jun 2019 15:31:22 +0200
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
Subject: Re: [PATCH v3 06/10] debugfs: simplify __debugfs_remove_file()
Message-ID: <20190603133122.GA24574@kroah.com>
References: <20190526143411.11244-1-amir73il@gmail.com>
 <20190526143411.11244-7-amir73il@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190526143411.11244-7-amir73il@gmail.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, May 26, 2019 at 05:34:07PM +0300, Amir Goldstein wrote:
> Move simple_unlink()+d_delete() from __debugfs_remove_file() into
> caller __debugfs_remove() and rename helper for post remove file to
> __debugfs_file_removed().
> 
> This will simplify adding fsnotify_unlink() hook.
> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> ---
>  fs/debugfs/inode.c | 20 ++++++++------------
>  1 file changed, 8 insertions(+), 12 deletions(-)
> 
> diff --git a/fs/debugfs/inode.c b/fs/debugfs/inode.c
> index acef14ad53db..d89874da9791 100644
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
> -
>  	/*
>  	 * Paired with the closing smp_mb() implied by a successful
>  	 * cmpxchg() in debugfs_file_get(): either
> @@ -644,16 +641,15 @@ static int __debugfs_remove(struct dentry *dentry, struct dentry *parent)
>  
>  	if (simple_positive(dentry)) {
>  		dget(dentry);
> -		if (!d_is_reg(dentry)) {
> -			if (d_is_dir(dentry))
> -				ret = simple_rmdir(d_inode(parent), dentry);
> -			else
> -				simple_unlink(d_inode(parent), dentry);
> -			if (!ret)
> -				d_delete(dentry);
> +		if (d_is_dir(dentry)) {
> +			ret = simple_rmdir(d_inode(parent), dentry);
>  		} else {
> -			__debugfs_remove_file(dentry, parent);
> +			simple_unlink(d_inode(parent), dentry);
>  		}
> +		if (!ret)
> +			d_delete(dentry);
> +		if (d_is_reg(dentry))
> +			__debugfs_file_removed(dentry);
>  		dput(dentry);
>  	}
>  	return ret;

Ugh, I had to stare at this for a long time.  I _think_ it all looks
equalivant now, but if this breaks, I know who to blame :)

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

