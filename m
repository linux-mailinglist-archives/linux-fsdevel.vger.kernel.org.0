Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87E181D1EA2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 May 2020 21:12:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390492AbgEMTMJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 13 May 2020 15:12:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2390379AbgEMTMI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 13 May 2020 15:12:08 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88AB6C061A0C
        for <linux-fsdevel@vger.kernel.org>; Wed, 13 May 2020 12:12:08 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jYwnW-007htD-RD; Wed, 13 May 2020 19:12:07 +0000
Date:   Wed, 13 May 2020 20:12:06 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Miklos Szeredi <mszeredi@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 01/12] vfs: allow unprivileged whiteout creation
Message-ID: <20200513191206.GW23230@ZenIV.linux.org.uk>
References: <20200505095915.11275-1-mszeredi@redhat.com>
 <20200505095915.11275-2-mszeredi@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200505095915.11275-2-mszeredi@redhat.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, May 05, 2020 at 11:59:04AM +0200, Miklos Szeredi wrote:
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

Humm...  one question:

>  int vfs_whiteout(struct inode *dir, struct dentry *dentry)
>  {
> -	int error = may_create(dir, dentry);
> -	if (error)
> -		return error;
> -
> -	if (!dir->i_op->mknod)
> -		return -EPERM;
> -
> -	return dir->i_op->mknod(dir, dentry,
> -				S_IFCHR | WHITEOUT_MODE, WHITEOUT_DEV);
> +	return vfs_mknod(dir, dentry, S_IFCHR | WHITEOUT_MODE, WHITEOUT_DEV);
>  }

why do we still need to export it?  I mean, it looks like
a static inline fodder.
