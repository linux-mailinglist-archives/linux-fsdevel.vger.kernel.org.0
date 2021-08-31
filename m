Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42CAD3FC252
	for <lists+linux-fsdevel@lfdr.de>; Tue, 31 Aug 2021 08:05:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239497AbhHaFz2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 31 Aug 2021 01:55:28 -0400
Received: from zeniv-ca.linux.org.uk ([142.44.231.140]:52378 "EHLO
        zeniv-ca.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238589AbhHaFz1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 31 Aug 2021 01:55:27 -0400
Received: from jlbec by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mKwh3-00HUpc-0L; Tue, 31 Aug 2021 05:52:21 +0000
Date:   Tue, 31 Aug 2021 05:52:20 +0000
From:   Joel Becker <jlbec@evilplan.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Sishuai Gong <sishuai@purdue.edu>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 3/4] configfs: fold configfs_attach_attr into
 configfs_lookup
Message-ID: <YS3DlC0UQ/Wu2v9q@zeniv-ca.linux.org.uk>
Mail-Followup-To: Christoph Hellwig <hch@lst.de>,
        Sishuai Gong <sishuai@purdue.edu>,
        Al Viro <viro@zeniv.linux.org.uk>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
References: <20210825064906.1694233-1-hch@lst.de>
 <20210825064906.1694233-4-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210825064906.1694233-4-hch@lst.de>
X-Burt-Line: Trees are cool.
X-Red-Smith: Ninety feet between bases is perhaps as close as man has ever
 come to perfection.
Sender: Joel Becker <jlbec@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Acked-by: Joel Becker <jlbec@evilplan.org>

On Wed, Aug 25, 2021 at 08:49:05AM +0200, Christoph Hellwig wrote:
> This makes it more clear what gets added to the dcache and prepares
> for an additional locking fix.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  fs/configfs/dir.c | 73 ++++++++++++++++-------------------------------
>  1 file changed, 24 insertions(+), 49 deletions(-)
> 
> diff --git a/fs/configfs/dir.c b/fs/configfs/dir.c
> index 5d58569f0eea..fc20bd8a6337 100644
> --- a/fs/configfs/dir.c
> +++ b/fs/configfs/dir.c
> @@ -45,7 +45,7 @@ static void configfs_d_iput(struct dentry * dentry,
>  		/*
>  		 * Set sd->s_dentry to null only when this dentry is the one
>  		 * that is going to be killed.  Otherwise configfs_d_iput may
> -		 * run just after configfs_attach_attr and set sd->s_dentry to
> +		 * run just after configfs_lookup and set sd->s_dentry to
>  		 * NULL even it's still in use.
>  		 */
>  		if (sd->s_dentry == dentry)
> @@ -417,44 +417,13 @@ static void configfs_remove_dir(struct config_item * item)
>  	dput(dentry);
>  }
>  
> -
> -/* attaches attribute's configfs_dirent to the dentry corresponding to the
> - * attribute file
> - */
> -static int configfs_attach_attr(struct configfs_dirent * sd, struct dentry * dentry)
> -{
> -	struct configfs_attribute * attr = sd->s_element;
> -	struct inode *inode;
> -
> -	spin_lock(&configfs_dirent_lock);
> -	dentry->d_fsdata = configfs_get(sd);
> -	sd->s_dentry = dentry;
> -	spin_unlock(&configfs_dirent_lock);
> -
> -	inode = configfs_create(dentry, (attr->ca_mode & S_IALLUGO) | S_IFREG);
> -	if (IS_ERR(inode)) {
> -		configfs_put(sd);
> -		return PTR_ERR(inode);
> -	}
> -	if (sd->s_type & CONFIGFS_ITEM_BIN_ATTR) {
> -		inode->i_size = 0;
> -		inode->i_fop = &configfs_bin_file_operations;
> -	} else {
> -		inode->i_size = PAGE_SIZE;
> -		inode->i_fop = &configfs_file_operations;
> -	}
> -	d_add(dentry, inode);
> -	return 0;
> -}
> -
>  static struct dentry * configfs_lookup(struct inode *dir,
>  				       struct dentry *dentry,
>  				       unsigned int flags)
>  {
>  	struct configfs_dirent * parent_sd = dentry->d_parent->d_fsdata;
>  	struct configfs_dirent * sd;
> -	int found = 0;
> -	int err;
> +	struct inode *inode = NULL;
>  
>  	if (dentry->d_name.len > NAME_MAX)
>  		return ERR_PTR(-ENAMETOOLONG);
> @@ -471,28 +440,34 @@ static struct dentry * configfs_lookup(struct inode *dir,
>  		return ERR_PTR(-ENOENT);
>  
>  	list_for_each_entry(sd, &parent_sd->s_children, s_sibling) {
> -		if (sd->s_type & CONFIGFS_NOT_PINNED) {
> -			const unsigned char * name = configfs_get_name(sd);
> +		if ((sd->s_type & CONFIGFS_NOT_PINNED) &&
> +		    !strcmp(configfs_get_name(sd), dentry->d_name.name)) {
> +			struct configfs_attribute *attr = sd->s_element;
> +			umode_t mode = (attr->ca_mode & S_IALLUGO) | S_IFREG;
>  
> -			if (strcmp(name, dentry->d_name.name))
> -				continue;
> +			spin_lock(&configfs_dirent_lock);
> +			dentry->d_fsdata = configfs_get(sd);
> +			sd->s_dentry = dentry;
> +			spin_unlock(&configfs_dirent_lock);
>  
> -			found = 1;
> -			err = configfs_attach_attr(sd, dentry);
> +			inode = configfs_create(dentry, mode);
> +			if (IS_ERR(inode)) {
> +				configfs_put(sd);
> +				return ERR_CAST(inode);
> +			}
> +			if (sd->s_type & CONFIGFS_ITEM_BIN_ATTR) {
> +				inode->i_size = 0;
> +				inode->i_fop = &configfs_bin_file_operations;
> +			} else {
> +				inode->i_size = PAGE_SIZE;
> +				inode->i_fop = &configfs_file_operations;
> +			}
>  			break;
>  		}
>  	}
>  
> -	if (!found) {
> -		/*
> -		 * If it doesn't exist and it isn't a NOT_PINNED item,
> -		 * it must be negative.
> -		 */
> -		d_add(dentry, NULL);
> -		return NULL;
> -	}
> -
> -	return ERR_PTR(err);
> +	d_add(dentry, inode);
> +	return NULL;
>  }
>  
>  /*
> -- 
> 2.30.2
> 

-- 
