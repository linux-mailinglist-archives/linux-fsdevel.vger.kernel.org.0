Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D82C30282F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Jan 2021 17:49:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730873AbhAYQrG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 25 Jan 2021 11:47:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730860AbhAYQqp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 25 Jan 2021 11:46:45 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7EC5C06174A
        for <linux-fsdevel@vger.kernel.org>; Mon, 25 Jan 2021 08:46:04 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id m2so11643539wmm.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 25 Jan 2021 08:46:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=iB3FOTkC0uwThb3VNvB3HWCSTcBSlNU3/HpxGPo/J4I=;
        b=tny51Hq/UYPn60occVED9UjGBfecQ+4oPMD8Ktl/oXyi5U2j6D6eka7CGM/p46QE23
         0hLn4J/os6qIlrb1zZTwJBCsnFjDY4ytl6Xyx5SBAE5DLKhcvRWnugqQcPmWBPuJz2pO
         70PWjg34zgFTmhQZY1sCpKkqAldfxxDxdztLyo9+hsy/PgSVtd7wWam6BzPFwqjxFTWq
         MGdEgbK11tuSkhwBPYXB0ym22etODTWvVvHUiP/dOuq98xFCByAQaZp00ug+K03yoKs4
         Sx0v5z2NXvHhDnwX3qbFR499GxIYr3jdXjeI+w81LZ+2Vry8yzG+7lunggfUDnpVaDy2
         94eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=iB3FOTkC0uwThb3VNvB3HWCSTcBSlNU3/HpxGPo/J4I=;
        b=Ew1+tMsM4yCXn9nF6f2OzAfwnZ3IpCpxYsor6egUkaLcawn4xziASxU9Ylsf+3c6Bm
         wr43aXMvK9YgR6A+/LxjkKTTRMKQeUzXQnjeQwJeDlrr6+2byhXNKDZvd5c47zvw72VG
         MYquZxAqHZLzwgERoXzovwg6pfUiYGecor5XkR7BoKAgFcmV3YJ9WZWVqCaJO11YwUli
         Z9+GvQmNdy3a9ZM9jdMCDTd/REc717fsFs9E/6dtgugthqPx7I2tua0MFR+c4OqSt/qe
         Ag3NIuD8CZmTaWVpkXSuUfq8R8uiK9SbC5iF4t5eBZUj1Sgeboiu2cEX+LF9LOAG/rqI
         l5kg==
X-Gm-Message-State: AOAM532mA0+kADs3sdhOK8NkOj+qlm9Lx0tuzxBMFNlN/EtITQqZfv+R
        LH3qJCE7qm4HFMafV5OMF2Z3GA==
X-Google-Smtp-Source: ABdhPJz+j7zmvBIJ9yFAMv9o6WgMy/Vr5GBwzrfw9xRPAO0mPpb+ZA47/q13Ay057MnBx4yCPchCyg==
X-Received: by 2002:a1c:e486:: with SMTP id b128mr956980wmh.136.1611593163573;
        Mon, 25 Jan 2021 08:46:03 -0800 (PST)
Received: from google.com ([2a00:79e0:d:210:4cd4:5994:40fe:253d])
        by smtp.gmail.com with ESMTPSA id n16sm22856690wrj.26.2021.01.25.08.46.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jan 2021 08:46:03 -0800 (PST)
Date:   Mon, 25 Jan 2021 16:46:01 +0000
From:   Alessio Balsini <balsini@android.com>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Akilesh Kailash <akailash@google.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Antonio SJ Musumeci <trapexit@spawn.link>,
        David Anderson <dvander@google.com>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Jann Horn <jannh@google.com>, Jens Axboe <axboe@kernel.dk>,
        Martijn Coenen <maco@android.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Lawrence <paullawrence@google.com>,
        Peng Tao <bergwolf@gmail.com>,
        Stefano Duo <duostefano93@gmail.com>,
        Zimuzo Ezeozue <zezeozue@google.com>, wuyan <wu-yan@tcl.com>,
        fuse-devel@lists.sourceforge.net, kernel-team@android.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND V12 1/8] fs: Generic function to convert iocb to
 rw flags
Message-ID: <YA71ydLBbKmZg5/O@google.com>
References: <20210125153057.3623715-1-balsini@android.com>
 <20210125153057.3623715-2-balsini@android.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210125153057.3623715-2-balsini@android.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jan 25, 2021 at 03:30:50PM +0000, Alessio Balsini wrote:
> OverlayFS implements its own function to translate iocb flags into rw
> flags, so that they can be passed into another vfs call.
> With commit ce71bfea207b4 ("fs: align IOCB_* flags with RWF_* flags")
> Jens created a 1:1 matching between the iocb flags and rw flags,
> simplifying the conversion.
> 
> Reduce the OverlayFS code by making the flag conversion function generic
> and reusable.
> 
> Signed-off-by: Alessio Balsini <balsini@android.com>
> ---
>  fs/overlayfs/file.c | 23 +++++------------------
>  include/linux/fs.h  |  5 +++++
>  2 files changed, 10 insertions(+), 18 deletions(-)
> 
> diff --git a/fs/overlayfs/file.c b/fs/overlayfs/file.c
> index bd9dd38347ae..56be2ffc5a14 100644
> --- a/fs/overlayfs/file.c
> +++ b/fs/overlayfs/file.c
> @@ -15,6 +15,8 @@
>  #include <linux/fs.h>
>  #include "overlayfs.h"
>  
> +#define OVL_IOCB_MASK (IOCB_DSYNC | IOCB_HIPRI | IOCB_NOWAIT | IOCB_SYNC)
> +
>  struct ovl_aio_req {
>  	struct kiocb iocb;
>  	struct kiocb *orig_iocb;
> @@ -236,22 +238,6 @@ static void ovl_file_accessed(struct file *file)
>  	touch_atime(&file->f_path);
>  }
>  
> -static rwf_t ovl_iocb_to_rwf(int ifl)
> -{
> -	rwf_t flags = 0;
> -
> -	if (ifl & IOCB_NOWAIT)
> -		flags |= RWF_NOWAIT;
> -	if (ifl & IOCB_HIPRI)
> -		flags |= RWF_HIPRI;
> -	if (ifl & IOCB_DSYNC)
> -		flags |= RWF_DSYNC;
> -	if (ifl & IOCB_SYNC)
> -		flags |= RWF_SYNC;
> -
> -	return flags;
> -}
> -
>  static void ovl_aio_cleanup_handler(struct ovl_aio_req *aio_req)
>  {
>  	struct kiocb *iocb = &aio_req->iocb;
> @@ -299,7 +285,8 @@ static ssize_t ovl_read_iter(struct kiocb *iocb, struct iov_iter *iter)
>  	old_cred = ovl_override_creds(file_inode(file)->i_sb);
>  	if (is_sync_kiocb(iocb)) {
>  		ret = vfs_iter_read(real.file, iter, &iocb->ki_pos,
> -				    ovl_iocb_to_rwf(iocb->ki_flags));
> +				    iocb_to_rw_flags(iocb->ki_flags,
> +						     OVL_IOCB_MASK));
>  	} else {
>  		struct ovl_aio_req *aio_req;
>  
> @@ -356,7 +343,7 @@ static ssize_t ovl_write_iter(struct kiocb *iocb, struct iov_iter *iter)
>  	if (is_sync_kiocb(iocb)) {
>  		file_start_write(real.file);
>  		ret = vfs_iter_write(real.file, iter, &iocb->ki_pos,
> -				     ovl_iocb_to_rwf(ifl));
> +				     iocb_to_rw_flags(ifl, OVL_IOCB_MASK));
>  		file_end_write(real.file);
>  		/* Update size */
>  		ovl_copyattr(ovl_inode_real(inode), inode);
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index fd47deea7c17..647c35423545 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -3275,6 +3275,11 @@ static inline int kiocb_set_rw_flags(struct kiocb *ki, rwf_t flags)
>  	return 0;
>  }
>  
> +static inline rwf_t iocb_to_rw_flags(int ifl, int iocb_mask)
> +{
> +	return ifl & iocb_mask;
> +}
> +
>  static inline ino_t parent_ino(struct dentry *dentry)
>  {
>  	ino_t res;
> -- 
> 2.30.0.280.ga3ce27912f-goog
> 

For some reason lkml.org and lore.kernel.org are not showing this change
as part of the thread.
Let's see if replying to the email fixes the indexing.

Regards,
Alessio
