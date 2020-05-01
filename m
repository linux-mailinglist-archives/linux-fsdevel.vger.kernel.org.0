Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E8781C0D22
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 May 2020 06:14:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726452AbgEAEOq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 1 May 2020 00:14:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726153AbgEAEOq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 1 May 2020 00:14:46 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 043F4C035494
        for <linux-fsdevel@vger.kernel.org>; Thu, 30 Apr 2020 21:14:46 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jUN4W-00Fb8s-3Z; Fri, 01 May 2020 04:14:44 +0000
Date:   Fri, 1 May 2020 05:14:44 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] vfs: allow unprivileged whiteout creation
Message-ID: <20200501041444.GJ23230@ZenIV.linux.org.uk>
References: <20200409212859.GH28467@miu.piliscsaba.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200409212859.GH28467@miu.piliscsaba.redhat.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Apr 09, 2020 at 11:28:59PM +0200, Miklos Szeredi wrote:
> From: Miklos Szeredi <mszeredi@redhat.com>
> 
> Whiteouts, unlike real device node should not require privileges to create.
> 
> The general concern with device nodes is that opening them can have side
> effects.  The kernel already avoids zero major (see
> Documentation/admin-guide/devices.txt).  To be on the safe side the patch
> explicitly forbids registering a char device with 0/0 number (see
> cdev_add()).
> 
> This guarantees that a non-O_PATH open on a whiteout will fail with ENODEV;
> i.e. it won't have any side effect.

>  int vfs_mknod(struct inode *dir, struct dentry *dentry, umode_t mode, dev_t dev)
>  {
> +	bool is_whiteout = S_ISCHR(mode) && dev == WHITEOUT_DEV;
>  	int error = may_create(dir, dentry);
>  
>  	if (error)
>  		return error;
>  
> -	if ((S_ISCHR(mode) || S_ISBLK(mode)) && !capable(CAP_MKNOD))
> +	if ((S_ISCHR(mode) || S_ISBLK(mode)) && !capable(CAP_MKNOD) &&
> +	    !is_whiteout)
>  		return -EPERM;

Hmm...  That exposes vfs_whiteout() to LSM; are you sure that you won't
end up with regressions for overlayfs on sufficiently weird setups?
