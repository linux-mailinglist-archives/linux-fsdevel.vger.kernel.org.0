Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E28AD72B8D4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jun 2023 09:41:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234736AbjFLHlZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Jun 2023 03:41:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234745AbjFLHlY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Jun 2023 03:41:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2CBF10E2;
        Mon, 12 Jun 2023 00:40:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 53EBD61267;
        Mon, 12 Jun 2023 07:29:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82824C433EF;
        Mon, 12 Jun 2023 07:29:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686554956;
        bh=SZmIp6ywoNZW/16DvVOxLRUnnE5sFCr7JfjAiFKlPt8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nnK+lUj66rsngdG+yb6or83tS7FL0+uxdX6Liij19G5WnviIBkUtGUL68I9PKmZAX
         LlxL2GkqITNwmBrVfvQpY3y+eU1DIvAoy8X6Vu5+N9MKItgQxTzlrboSZOlpZyKVXm
         EEM0UMPAM02X/RhfOjmqTKETutU52lNvGhsWPk9O+PZZc/5iSTaeSP7TQIW5ETQHO2
         hv8/0PBdyErii1diIobjKY2Lcm03uy7pM3IDEU/qFXnCOAd2p4w1V0n6vO9UMJB85x
         hEYVmgZk/7y+RGefADHBu8nwR3LCeoBzziX7EldfY/f8MNDJh1DFiehCJNcoGvF4JD
         M9FnuSSNpLIEA==
Date:   Mon, 12 Jun 2023 09:29:11 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     wenyang.linux@foxmail.com
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Dylan Yudaken <dylany@fb.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Matthew Wilcox <willy@infradead.org>,
        Eric Biggers <ebiggers@google.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] eventfd: add a uapi header for eventfd userspace APIs
Message-ID: <20230612-erden-geier-f4a73586dc20@brauner>
References: <tencent_F7EEF9B42A817A28086FF22DBD84B9CF2F05@qq.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <tencent_F7EEF9B42A817A28086FF22DBD84B9CF2F05@qq.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jun 12, 2023 at 02:59:20AM +0800, wenyang.linux@foxmail.com wrote:
> From: Wen Yang <wenyang.linux@foxmail.com>
> 
> Create a uapi header include/uapi/linux/eventfd.h, move the associated
> flags to the uapi header, and include it from linux/eventfd.h.
> 
> Signed-off-by: Wen Yang <wenyang.linux@foxmail.com>
> Cc: Alexander Viro <viro@zeniv.linux.org.uk>
> Cc: Jens Axboe <axboe@kernel.dk>
> Cc: Christian Brauner <brauner@kernel.org>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Dylan Yudaken <dylany@fb.com>
> Cc: David Woodhouse <dwmw@amazon.co.uk>
> Cc: Matthew Wilcox <willy@infradead.org>
> Cc: Eric Biggers <ebiggers@google.com>
> Cc: linux-fsdevel@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> ---

I think the change overall makes sense but see below.

>  include/linux/eventfd.h      | 16 +---------------
>  include/uapi/linux/eventfd.h | 27 +++++++++++++++++++++++++++
>  2 files changed, 28 insertions(+), 15 deletions(-)
>  create mode 100644 include/uapi/linux/eventfd.h
> 
> diff --git a/include/linux/eventfd.h b/include/linux/eventfd.h
> index 98d31cdaca40..c8be8fa6795d 100644
> --- a/include/linux/eventfd.h
> +++ b/include/linux/eventfd.h
> @@ -9,26 +9,12 @@
>  #ifndef _LINUX_EVENTFD_H
>  #define _LINUX_EVENTFD_H
>  
> -#include <linux/fcntl.h>
>  #include <linux/wait.h>
>  #include <linux/err.h>
>  #include <linux/percpu-defs.h>
>  #include <linux/percpu.h>
>  #include <linux/sched.h>
> -
> -/*
> - * CAREFUL: Check include/uapi/asm-generic/fcntl.h when defining
> - * new flags, since they might collide with O_* ones. We want
> - * to re-use O_* flags that couldn't possibly have a meaning
> - * from eventfd, in order to leave a free define-space for
> - * shared O_* flags.
> - */
> -#define EFD_SEMAPHORE (1 << 0)
> -#define EFD_CLOEXEC O_CLOEXEC
> -#define EFD_NONBLOCK O_NONBLOCK
> -
> -#define EFD_SHARED_FCNTL_FLAGS (O_CLOEXEC | O_NONBLOCK)
> -#define EFD_FLAGS_SET (EFD_SHARED_FCNTL_FLAGS | EFD_SEMAPHORE)
> +#include <uapi/linux/eventfd.h>
>  
>  struct eventfd_ctx;
>  struct file;
> diff --git a/include/uapi/linux/eventfd.h b/include/uapi/linux/eventfd.h
> new file mode 100644
> index 000000000000..02e9dcdb8d29
> --- /dev/null
> +++ b/include/uapi/linux/eventfd.h
> @@ -0,0 +1,27 @@
> +/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
> +#ifndef _UAPI_LINUX_EVENTFD_H
> +#define _UAPI_LINUX_EVENTFD_H
> +
> +#include <linux/types.h>
> +
> +/* For O_CLOEXEC and O_NONBLOCK */
> +#include <linux/fcntl.h>
> +
> +/* For _IO helpers */
> +#include <linux/ioctl.h>

Why would you want to include that?

> +
> +/*
> + * CAREFUL: Check include/uapi/asm-generic/fcntl.h when defining
> + * new flags, since they might collide with O_* ones. We want
> + * to re-use O_* flags that couldn't possibly have a meaning
> + * from eventfd, in order to leave a free define-space for
> + * shared O_* flags.
> + */

I would leave that comment together with EFD_SHARED_FCNTL_FLAGS and
EFD_FLAGS_SET in the kernel only header.

> +#define EFD_SEMAPHORE (1 << 0)
> +#define EFD_CLOEXEC O_CLOEXEC
> +#define EFD_NONBLOCK O_NONBLOCK
> +
> +#define EFD_SHARED_FCNTL_FLAGS (O_CLOEXEC | O_NONBLOCK)
> +#define EFD_FLAGS_SET (EFD_SHARED_FCNTL_FLAGS | EFD_SEMAPHORE)

I think that doesn't belong into the uapi header and should be left in
the kernel header.

> +
> +#endif /* _UAPI_LINUX_EVENTFD_H */
> -- 
> 2.34.1
> 
