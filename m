Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E735034709A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Mar 2021 06:03:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232773AbhCXFC2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 24 Mar 2021 01:02:28 -0400
Received: from zeniv-ca.linux.org.uk ([142.44.231.140]:40672 "EHLO
        zeniv-ca.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232648AbhCXFCN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 24 Mar 2021 01:02:13 -0400
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lOvel-008keX-JS; Wed, 24 Mar 2021 05:02:11 +0000
Date:   Wed, 24 Mar 2021 05:02:11 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Miklos Szeredi <mszeredi@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v2 01/18] vfs: add miscattr ops
Message-ID: <YFrH098Tbbezg2hI@zeniv-ca.linux.org.uk>
References: <20210322144916.137245-1-mszeredi@redhat.com>
 <20210322144916.137245-2-mszeredi@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210322144916.137245-2-mszeredi@redhat.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Mar 22, 2021 at 03:48:59PM +0100, Miklos Szeredi wrote:

minor nit: copy_fsxattr_{to,from}_user() might be better.

> +int fsxattr_copy_to_user(const struct miscattr *ma, struct fsxattr __user *ufa)
> +{
> +	struct fsxattr fa = {
> +		.fsx_xflags	= ma->fsx_xflags,
> +		.fsx_extsize	= ma->fsx_extsize,
> +		.fsx_nextents	= ma->fsx_nextents,
> +		.fsx_projid	= ma->fsx_projid,
> +		.fsx_cowextsize	= ma->fsx_cowextsize,
> +	};

That wants a comment along the lines of "guaranteed to be gap-free",
since otherwise you'd need memset() to avoid an infoleak.

> +static int ioctl_getflags(struct file *file, void __user *argp)
> +{
> +	struct miscattr ma = { .flags_valid = true }; /* hint only */
> +	unsigned int flags;
> +	int err;
> +
> +	err = vfs_miscattr_get(file_dentry(file), &ma);

Umm...  Just to clarify - do we plan to have that ever called via
ovl_real_ioctl()?  IOW, is file_dentry() anything other than a way
to spell ->f_path.dentry here?

> +struct miscattr {
> +	u32	flags;		/* flags (FS_IOC_GETFLAGS/FS_IOC_SETFLAGS) */
> +	/* struct fsxattr: */
> +	u32	fsx_xflags;	/* xflags field value (get/set) */
> +	u32	fsx_extsize;	/* extsize field value (get/set)*/
> +	u32	fsx_nextents;	/* nextents field value (get)	*/
> +	u32	fsx_projid;	/* project identifier (get/set) */
> +	u32	fsx_cowextsize;	/* CoW extsize field value (get/set)*/
> +	/* selectors: */
> +	bool	flags_valid:1;
> +	bool	xattr_valid:1;
> +};

OK as long as it stays kernel-only, but if we ever expose that to userland, we'd
better remember to turn the last two into an u32 with explicit bitmasks.
