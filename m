Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EE703100F5
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Feb 2021 00:46:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231289AbhBDXpj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 4 Feb 2021 18:45:39 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:42445 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231245AbhBDXoc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 4 Feb 2021 18:44:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612482134;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zIZh/QpswrY1424WeFxeb3hgosOJTtKrRZoe/Rxx33w=;
        b=aQ/X/pKGNXGOJuD5EAGLJcivMRWexegddzEP40V+uDkA1kSOMI2IFw8tqbFbEpVACXfQd2
        FR7hPgpAgyXS4JGvAM3AZeQkBy2RvBXXhpUh+JOUHrhZN/Opfifz9M8fGQYDDAteq7YTLE
        Mz1A+2ZsSQ4vkuQN8wh7mxHZlbg9X8Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-480-7kq0YhApPA6W7_QuzixxYQ-1; Thu, 04 Feb 2021 18:42:13 -0500
X-MC-Unique: 7kq0YhApPA6W7_QuzixxYQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0B3FC107ACC7;
        Thu,  4 Feb 2021 23:42:12 +0000 (UTC)
Received: from horse.redhat.com (ovpn-113-87.rdu2.redhat.com [10.10.113.87])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E56165C3DF;
        Thu,  4 Feb 2021 23:42:11 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 83E5A22054F; Thu,  4 Feb 2021 18:42:11 -0500 (EST)
Date:   Thu, 4 Feb 2021 18:42:11 -0500
From:   Vivek Goyal <vgoyal@redhat.com>
To:     Miklos Szeredi <mszeredi@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 03/18] ovl: stack miscattr
Message-ID: <20210204234211.GB52056@redhat.com>
References: <20210203124112.1182614-1-mszeredi@redhat.com>
 <20210203124112.1182614-4-mszeredi@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210203124112.1182614-4-mszeredi@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Feb 03, 2021 at 01:40:57PM +0100, Miklos Szeredi wrote:
> Add stacking for the miscattr operations.
> 
> Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
> ---
>  fs/overlayfs/dir.c       |  2 ++
>  fs/overlayfs/inode.c     | 43 ++++++++++++++++++++++++++++++++++++++++
>  fs/overlayfs/overlayfs.h |  2 ++
>  3 files changed, 47 insertions(+)
> 
> diff --git a/fs/overlayfs/dir.c b/fs/overlayfs/dir.c
> index 28a075b5f5b2..77c6b44f8d83 100644
> --- a/fs/overlayfs/dir.c
> +++ b/fs/overlayfs/dir.c
> @@ -1300,4 +1300,6 @@ const struct inode_operations ovl_dir_inode_operations = {
>  	.listxattr	= ovl_listxattr,
>  	.get_acl	= ovl_get_acl,
>  	.update_time	= ovl_update_time,
> +	.miscattr_get	= ovl_miscattr_get,
> +	.miscattr_set	= ovl_miscattr_set,
>  };
> diff --git a/fs/overlayfs/inode.c b/fs/overlayfs/inode.c
> index d739e14c6814..97d36d1f28c3 100644
> --- a/fs/overlayfs/inode.c
> +++ b/fs/overlayfs/inode.c
> @@ -11,6 +11,7 @@
>  #include <linux/posix_acl.h>
>  #include <linux/ratelimit.h>
>  #include <linux/fiemap.h>
> +#include <linux/miscattr.h>
>  #include "overlayfs.h"
>  
>  
> @@ -495,6 +496,46 @@ static int ovl_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
>  	return err;
>  }
>  
> +int ovl_miscattr_set(struct dentry *dentry, struct miscattr *ma)
> +{
> +	struct inode *inode = d_inode(dentry);
> +	struct dentry *upperdentry;
> +	const struct cred *old_cred;
> +	int err;
> +
> +	err = ovl_want_write(dentry);
> +	if (err)
> +		goto out;
> +
> +	err = ovl_copy_up(dentry);
> +	if (!err) {
> +		upperdentry = ovl_dentry_upper(dentry);
> +
> +		old_cred = ovl_override_creds(inode->i_sb);
> +		/* err = security_file_ioctl(real.file, cmd, arg); */

Is this an comment intended?

Vivek

> +		err = vfs_miscattr_set(upperdentry, ma);
> +		revert_creds(old_cred);
> +		ovl_copyflags(ovl_inode_real(inode), inode);
> +	}
> +	ovl_drop_write(dentry);
> +out:
> +	return err;
> +}
> +
> +int ovl_miscattr_get(struct dentry *dentry, struct miscattr *ma)
> +{
> +	struct inode *inode = d_inode(dentry);
> +	struct dentry *realdentry = ovl_dentry_real(dentry);
> +	const struct cred *old_cred;
> +	int err;
> +
> +	old_cred = ovl_override_creds(inode->i_sb);
> +	err = vfs_miscattr_get(realdentry, ma);
> +	revert_creds(old_cred);
> +
> +	return err;
> +}
> +
>  static const struct inode_operations ovl_file_inode_operations = {
>  	.setattr	= ovl_setattr,
>  	.permission	= ovl_permission,
> @@ -503,6 +544,8 @@ static const struct inode_operations ovl_file_inode_operations = {
>  	.get_acl	= ovl_get_acl,
>  	.update_time	= ovl_update_time,
>  	.fiemap		= ovl_fiemap,
> +	.miscattr_get	= ovl_miscattr_get,
> +	.miscattr_set	= ovl_miscattr_set,
>  };
>  
>  static const struct inode_operations ovl_symlink_inode_operations = {
> diff --git a/fs/overlayfs/overlayfs.h b/fs/overlayfs/overlayfs.h
> index b487e48c7fd4..d3ad02c34cca 100644
> --- a/fs/overlayfs/overlayfs.h
> +++ b/fs/overlayfs/overlayfs.h
> @@ -509,6 +509,8 @@ int __init ovl_aio_request_cache_init(void);
>  void ovl_aio_request_cache_destroy(void);
>  long ovl_ioctl(struct file *file, unsigned int cmd, unsigned long arg);
>  long ovl_compat_ioctl(struct file *file, unsigned int cmd, unsigned long arg);
> +int ovl_miscattr_get(struct dentry *dentry, struct miscattr *ma);
> +int ovl_miscattr_set(struct dentry *dentry, struct miscattr *ma);
>  
>  /* copy_up.c */
>  int ovl_copy_up(struct dentry *dentry);
> -- 
> 2.26.2
> 

