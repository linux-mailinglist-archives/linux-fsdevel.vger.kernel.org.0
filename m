Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E3A83FC24C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 31 Aug 2021 08:05:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238967AbhHaFyg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 31 Aug 2021 01:54:36 -0400
Received: from zeniv-ca.linux.org.uk ([142.44.231.140]:52350 "EHLO
        zeniv-ca.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238882AbhHaFye (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 31 Aug 2021 01:54:34 -0400
Received: from jlbec by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mKwiG-00HUqS-RW; Tue, 31 Aug 2021 05:53:36 +0000
Date:   Tue, 31 Aug 2021 05:53:36 +0000
From:   Joel Becker <jlbec@evilplan.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Sishuai Gong <sishuai@purdue.edu>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 4/4] configfs: fix a race in configfs_lookup()
Message-ID: <YS3D4PH/OdoE+WQA@zeniv-ca.linux.org.uk>
Mail-Followup-To: Christoph Hellwig <hch@lst.de>,
        Sishuai Gong <sishuai@purdue.edu>,
        Al Viro <viro@zeniv.linux.org.uk>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
References: <20210825064906.1694233-1-hch@lst.de>
 <20210825064906.1694233-5-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210825064906.1694233-5-hch@lst.de>
X-Burt-Line: Trees are cool.
X-Red-Smith: Ninety feet between bases is perhaps as close as man has ever
 come to perfection.
Sender: Joel Becker <jlbec@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Acked-by: Joel Becker <jlbec@evilplan.org>

On Wed, Aug 25, 2021 at 08:49:06AM +0200, Christoph Hellwig wrote:
> From: Sishuai Gong <sishuai@purdue.edu>
> 
> When configfs_lookup() is executing list_for_each_entry(),
> it is possible that configfs_dir_lseek() is calling list_del().
> Some unfortunate interleavings of them can cause a kernel NULL
> pointer dereference error
> 
> Thread 1                  Thread 2
> //configfs_dir_lseek()    //configfs_lookup()
> list_del(&cursor->s_sibling);
>                          list_for_each_entry(sd, ...)
> 
> Fix this by grabbing configfs_dirent_lock in configfs_lookup()
> while iterating ->s_children.
> 
> Signed-off-by: Sishuai Gong <sishuai@purdue.edu>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  fs/configfs/dir.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/configfs/dir.c b/fs/configfs/dir.c
> index fc20bd8a6337..1466b5d01cbb 100644
> --- a/fs/configfs/dir.c
> +++ b/fs/configfs/dir.c
> @@ -439,13 +439,13 @@ static struct dentry * configfs_lookup(struct inode *dir,
>  	if (!configfs_dirent_is_ready(parent_sd))
>  		return ERR_PTR(-ENOENT);
>  
> +	spin_lock(&configfs_dirent_lock);
>  	list_for_each_entry(sd, &parent_sd->s_children, s_sibling) {
>  		if ((sd->s_type & CONFIGFS_NOT_PINNED) &&
>  		    !strcmp(configfs_get_name(sd), dentry->d_name.name)) {
>  			struct configfs_attribute *attr = sd->s_element;
>  			umode_t mode = (attr->ca_mode & S_IALLUGO) | S_IFREG;
>  
> -			spin_lock(&configfs_dirent_lock);
>  			dentry->d_fsdata = configfs_get(sd);
>  			sd->s_dentry = dentry;
>  			spin_unlock(&configfs_dirent_lock);
> @@ -462,10 +462,11 @@ static struct dentry * configfs_lookup(struct inode *dir,
>  				inode->i_size = PAGE_SIZE;
>  				inode->i_fop = &configfs_file_operations;
>  			}
> -			break;
> +			goto done;
>  		}
>  	}
> -
> +	spin_unlock(&configfs_dirent_lock);
> +done:
>  	d_add(dentry, inode);
>  	return NULL;
>  }
> -- 
> 2.30.2
> 

-- 
