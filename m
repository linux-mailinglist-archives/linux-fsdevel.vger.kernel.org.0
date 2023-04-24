Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 655006ED546
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Apr 2023 21:22:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232611AbjDXTWj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Apr 2023 15:22:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231967AbjDXTWi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Apr 2023 15:22:38 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B06C5D1;
        Mon, 24 Apr 2023 12:22:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=nrJOvD5ki07BgC1+m6zA5u3PXXHEIqqCNZygV4WG4uU=; b=jnaw2GVRUGJ3XgLDcnTm28/EGW
        I2c3SbIfk7aZCwr+R62bxYgluHATBsXpKHRc3Kd6eZ7X7q4C2PFIRnKN2s2rlLjl0PYv4/SHsIN/P
        Rj2zV9EqLlkLs/pB1Tdm+dvzQqZ3dxlb0SloO08wS4cUh9bmguHSZK/++Sq79+k4zzVbiIuZ6QX0S
        G/8MCyWL3hZerN11vkKzieKj7slIpAxQGdYJVp+7U764B2QvlYl7+o1DeyOxzKUG+7D0WMFdPQDdQ
        HSq8SrEJKQQidA3dpPqgpftvseREm3IU//74IrRNpeEcmqw1SOz1YOqefNqU0PC23jpEwwctyAAtq
        26XseFOA==;
Received: from [2601:1c2:980:9ec0::2764]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pr1lf-00H3HP-0y;
        Mon, 24 Apr 2023 19:22:31 +0000
Message-ID: <5f30b56e-b46b-1d3f-75fb-7f30ff6ca3e9@infradead.org>
Date:   Mon, 24 Apr 2023 12:22:30 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 02/17] fs: remove the special !CONFIG_BLOCK def_blk_fops
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Howells <dhowells@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        ceph-devel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, cluster-devel@redhat.com,
        linux-xfs@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20230424054926.26927-1-hch@lst.de>
 <20230424054926.26927-3-hch@lst.de>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20230424054926.26927-3-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

On 4/23/23 22:49, Christoph Hellwig wrote:
> def_blk_fops always returns -ENODEV, which dosn't match the return value
> of a non-existing block device with CONFIG_BLOCK, which is -ENXIO.
> Just remove the extra implementation and fall back to the default
> no_open_fops that always returns -ENXIO.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  fs/Makefile   | 10 ++--------
>  fs/inode.c    |  3 ++-
>  fs/no-block.c | 19 -------------------
>  3 files changed, 4 insertions(+), 28 deletions(-)
>  delete mode 100644 fs/no-block.c
> 
> diff --git a/fs/Makefile b/fs/Makefile
> index 05f89b5c962f88..da21e7d0a1cf37 100644
> --- a/fs/Makefile
> +++ b/fs/Makefile
> @@ -18,14 +18,8 @@ obj-y :=	open.o read_write.o file_table.o super.o \
>  		fs_types.o fs_context.o fs_parser.o fsopen.o init.o \
>  		kernel_read_file.o mnt_idmapping.o remap_range.o
>  
> -ifeq ($(CONFIG_BLOCK),y)
> -obj-y +=	buffer.o mpage.o
> -else
> -obj-y +=	no-block.o
> -endif
> -
> -obj-$(CONFIG_PROC_FS) += proc_namespace.o
> -
> +obj-$(CONFIG_BLOCK)		+= buffer.o mpage.o
> +obj-$(CONFIG_PROC_FS)		+= proc_namespace.o
>  obj-$(CONFIG_LEGACY_DIRECT_IO)	+= direct-io.o
>  obj-y				+= notify/
>  obj-$(CONFIG_EPOLL)		+= eventpoll.o
> diff --git a/fs/inode.c b/fs/inode.c
> index 4558dc2f135573..d43f07f146eb73 100644
> --- a/fs/inode.c
> +++ b/fs/inode.c
> @@ -2265,7 +2265,8 @@ void init_special_inode(struct inode *inode, umode_t mode, dev_t rdev)
>  		inode->i_fop = &def_chr_fops;
>  		inode->i_rdev = rdev;
>  	} else if (S_ISBLK(mode)) {
> -		inode->i_fop = &def_blk_fops;
> +		if (IS_ENABLED(CONFIG_BLOCK))
> +			inode->i_fop = &def_blk_fops;

It looks like def_blk_fops is being removed (commit message and patch
fragment below), but here (above line) it is being used.

Am I just confused?

>  		inode->i_rdev = rdev;
>  	} else if (S_ISFIFO(mode))
>  		inode->i_fop = &pipefifo_fops;
> diff --git a/fs/no-block.c b/fs/no-block.c
> deleted file mode 100644
> index 481c0f0ab4bd2c..00000000000000
> --- a/fs/no-block.c
> +++ /dev/null
> @@ -1,19 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0-or-later
> -/* no-block.c: implementation of routines required for non-BLOCK configuration
> - *
> - * Copyright (C) 2006 Red Hat, Inc. All Rights Reserved.
> - * Written by David Howells (dhowells@redhat.com)
> - */
> -
> -#include <linux/kernel.h>
> -#include <linux/fs.h>
> -
> -static int no_blkdev_open(struct inode * inode, struct file * filp)
> -{
> -	return -ENODEV;
> -}
> -
> -const struct file_operations def_blk_fops = {
> -	.open		= no_blkdev_open,
> -	.llseek		= noop_llseek,
> -};

-- 
~Randy
