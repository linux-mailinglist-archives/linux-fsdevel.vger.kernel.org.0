Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E72583CE9E3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jul 2021 19:54:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350664AbhGSRDV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 19 Jul 2021 13:03:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:53128 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1348868AbhGSRC6 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 19 Jul 2021 13:02:58 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A43A76113A;
        Mon, 19 Jul 2021 17:43:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626716611;
        bh=PXhcDlaLx61W4Eutz/rw2y6GFxByoNy/6Lmnqi+79LI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YoGO71o0VRNV8HAHxizjq5I0p+6P8g3XAilO/8xyJFEyM9hvVNeqO88oPVEQ3ZwmV
         bwQo3srHxYilVTe6K0wC8KbLkSjwtrr/DCQ6V6XZgaLYiFevuqiwFVrn1F3k3frhPb
         bOxaHC98TwpbQ1UjQk2oHgUND6EavtaYZwOsHL3lC4kc7VxPnvZI2VXiWZHDPUfHUZ
         hniyTmsfa/QHsekLdiOsr+9dPT0FgCIGupzSnEFPwgwS3tB8ATjFEUHCJSzpl/7jMw
         Z1TBs+s51khL1jAthagNY80uHDSFh8WozHOFvoZqw6Vm+Qd6NcKv4dL/NkEZ5SopSd
         lqdwfGvxMXfCQ==
Date:   Mon, 19 Jul 2021 10:43:31 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Jeffle Xu <jefflexu@linux.alibaba.com>
Cc:     viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org
Subject: Re: [PATCH v2] vfs: only allow SETFLAGS to set DAX flag on files and
 dirs
Message-ID: <20210719174331.GH22357@magnolia>
References: <20210719023834.104053-1-jefflexu@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210719023834.104053-1-jefflexu@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jul 19, 2021 at 10:38:34AM +0800, Jeffle Xu wrote:
> This is similar to commit dbc77f31e58b ("vfs: only allow FSSETXATTR to
> set DAX flag on files and dirs").
> 
> Though the underlying filesystems may have filtered invalid flags, e.g.,
> ext4_mask_flags() called in ext4_fileattr_set(), also check it in VFS
> layer.
> 
> Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>
> ---
> changes since v1:
> - add separate parentheses surrounding flag tests
> ---
>  fs/ioctl.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/ioctl.c b/fs/ioctl.c
> index 1e2204fa9963..90cfaa4db03a 100644
> --- a/fs/ioctl.c
> +++ b/fs/ioctl.c
> @@ -835,7 +835,7 @@ static int fileattr_set_prepare(struct inode *inode,
>  	 * It is only valid to set the DAX flag on regular files and
>  	 * directories on filesystems.
>  	 */
> -	if ((fa->fsx_xflags & FS_XFLAG_DAX) &&
> +	if (((fa->fsx_xflags & FS_XFLAG_DAX) || (fa->flags & FS_DAX_FL)) &&

Isn't fileattr_fill_flags supposed to fill out fa->fsx_xflags from
fa->flags for a SETFLAGS call?

--D

>  	    !(S_ISREG(inode->i_mode) || S_ISDIR(inode->i_mode)))
>  		return -EINVAL;
>  
> -- 
> 2.27.0
> 
