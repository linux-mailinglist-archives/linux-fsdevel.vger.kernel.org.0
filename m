Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0C9B67D1BB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Jan 2023 17:35:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231302AbjAZQfz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 26 Jan 2023 11:35:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbjAZQfx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 26 Jan 2023 11:35:53 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EB8D5AA4D
        for <linux-fsdevel@vger.kernel.org>; Thu, 26 Jan 2023 08:35:51 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id jm10so2277207plb.13
        for <linux-fsdevel@vger.kernel.org>; Thu, 26 Jan 2023 08:35:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dCedkZSub4E7G02ozmeTWJLtnbDkNYV9uv5/ypFjcjs=;
        b=eVNsUVSbY9fywISASdJ8vOfw38lV1OqgtvUQe/DYuTvRD66m+Qs3gitiyBx71/B0fx
         biiKsQThZMp1LfHN5EGfeOINKoMSy9g2go3I16WtwwZQpmFQ2IV/8N1oy6n8YhD6UIky
         WkwjrAgO7QyAPO+kq7hvc2L7BT76y6qkh24as=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dCedkZSub4E7G02ozmeTWJLtnbDkNYV9uv5/ypFjcjs=;
        b=SwSXYVRJ7bybbwuMfVUP/4wncbXU9WUeM3/bcH5Ots73EBjXQpGiW1LPyxQLKlls5c
         sSvZbV5RrtNEGYK+BxGq9TxCH+TQMWcsD9CCFmB2uCwHjSyFk1FZpkvunRz56iWKcowK
         +xmQ17yrLhaAi14XKZAwoLzVFArJ0v+3ePrD8YzVSq7kydC2OqzVwsH3wRiZn0VuQ/1O
         1phwH4PI1b7f0H7+60BZaQiuUTer6kqoU25nJTE0HYJybwwDkXSqsGJf3T5ogbTlWgco
         c7cFq6kkXZ1UHDjJK5xBmpQqoH3GZjCz5D2C+8iOT0/E07ZMy7rY8QXNSfadHpR1SXRD
         k/5g==
X-Gm-Message-State: AO0yUKVu8fqdG6TBczOZfbOLt3WrEQZHB0NDKtVB+jy1Yr8AMD48AQOv
        hrxNTHP3jKH+VboRSCyI5kbiDA==
X-Google-Smtp-Source: AK7set+Avp0tanijMNFBCT+FU9xteiB6gbr+IKCgWeSxaIOPWvlfFL0xvNVSPGxExS539i8F/Vvc1g==
X-Received: by 2002:a17:902:9a85:b0:196:1d60:b1b1 with SMTP id w5-20020a1709029a8500b001961d60b1b1mr7396425plp.31.1674750950872;
        Thu, 26 Jan 2023 08:35:50 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id l16-20020a170903245000b00192fc9e8552sm1234544pls.0.2023.01.26.08.35.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jan 2023 08:35:50 -0800 (PST)
Date:   Thu, 26 Jan 2023 08:35:49 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Jann Horn <jannh@google.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org,
        kernel-hardening@lists.openwall.com
Subject: Re: [PATCH] fs: Use CHECK_DATA_CORRUPTION() when kernel bugs are
 detected
Message-ID: <202301260835.61F1C2CA4D@keescook>
References: <20230116191425.458864-1-jannh@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230116191425.458864-1-jannh@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jan 16, 2023 at 08:14:25PM +0100, Jann Horn wrote:
> Currently, filp_close() and generic_shutdown_super() use printk() to log
> messages when bugs are detected. This is problematic because infrastructure
> like syzkaller has no idea that this message indicates a bug.
> In addition, some people explicitly want their kernels to BUG() when kernel
> data corruption has been detected (CONFIG_BUG_ON_DATA_CORRUPTION).
> And finally, when generic_shutdown_super() detects remaining inodes on a
> system without CONFIG_BUG_ON_DATA_CORRUPTION, it would be nice if later
> accesses to a busy inode would at least crash somewhat cleanly rather than
> walking through freed memory.
> 
> To address all three, use CHECK_DATA_CORRUPTION() when kernel bugs are
> detected.

Seems reasonable to me. I'll carry this unless someone else speaks up.
:)

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

> 
> Signed-off-by: Jann Horn <jannh@google.com>
> ---
>  fs/open.c              |  5 +++--
>  fs/super.c             | 21 +++++++++++++++++----
>  include/linux/poison.h |  3 +++
>  3 files changed, 23 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/open.c b/fs/open.c
> index 82c1a28b3308..ceb88ac0ca3b 100644
> --- a/fs/open.c
> +++ b/fs/open.c
> @@ -1411,8 +1411,9 @@ int filp_close(struct file *filp, fl_owner_t id)
>  {
>  	int retval = 0;
>  
> -	if (!file_count(filp)) {
> -		printk(KERN_ERR "VFS: Close: file count is 0\n");
> +	if (CHECK_DATA_CORRUPTION(file_count(filp) == 0,
> +			"VFS: Close: file count is 0 (f_op=%ps)",
> +			filp->f_op)) {
>  		return 0;
>  	}
>  
> diff --git a/fs/super.c b/fs/super.c
> index 12c08cb20405..cf737ec2bd05 100644
> --- a/fs/super.c
> +++ b/fs/super.c
> @@ -491,10 +491,23 @@ void generic_shutdown_super(struct super_block *sb)
>  		if (sop->put_super)
>  			sop->put_super(sb);
>  
> -		if (!list_empty(&sb->s_inodes)) {
> -			printk("VFS: Busy inodes after unmount of %s. "
> -			   "Self-destruct in 5 seconds.  Have a nice day...\n",
> -			   sb->s_id);
> +		if (CHECK_DATA_CORRUPTION(!list_empty(&sb->s_inodes),
> +				"VFS: Busy inodes after unmount of %s (%s)",
> +				sb->s_id, sb->s_type->name)) {
> +			/*
> +			 * Adding a proper bailout path here would be hard, but
> +			 * we can at least make it more likely that a later
> +			 * iput_final() or such crashes cleanly.
> +			 */
> +			struct inode *inode;
> +
> +			spin_lock(&sb->s_inode_list_lock);
> +			list_for_each_entry(inode, &sb->s_inodes, i_sb_list) {
> +				inode->i_op = VFS_PTR_POISON;
> +				inode->i_sb = VFS_PTR_POISON;
> +				inode->i_mapping = VFS_PTR_POISON;
> +			}
> +			spin_unlock(&sb->s_inode_list_lock);
>  		}
>  	}
>  	spin_lock(&sb_lock);
> diff --git a/include/linux/poison.h b/include/linux/poison.h
> index 2d3249eb0e62..0e8a1f2ceb2f 100644
> --- a/include/linux/poison.h
> +++ b/include/linux/poison.h
> @@ -84,4 +84,7 @@
>  /********** kernel/bpf/ **********/
>  #define BPF_PTR_POISON ((void *)(0xeB9FUL + POISON_POINTER_DELTA))
>  
> +/********** VFS **********/
> +#define VFS_PTR_POISON ((void *)(0xF5 + POISON_POINTER_DELTA))
> +
>  #endif
> 
> base-commit: 5dc4c995db9eb45f6373a956eb1f69460e69e6d4
> -- 
> 2.39.0.314.g84b9a713c41-goog
> 

-- 
Kees Cook
