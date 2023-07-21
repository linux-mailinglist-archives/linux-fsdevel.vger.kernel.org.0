Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B36675BCD7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Jul 2023 05:35:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229605AbjGUDfA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 Jul 2023 23:35:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjGUDe6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 Jul 2023 23:34:58 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F4041726
        for <linux-fsdevel@vger.kernel.org>; Thu, 20 Jul 2023 20:34:32 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-6689430d803so991728b3a.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 20 Jul 2023 20:34:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1689910472; x=1690515272;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jR6wHNjkhuAI8VNtYWEPWDZXPwfmPMcO3jpv83zksZQ=;
        b=epZ8QgVJbKEbdXbS5617BlBqrf0tzl79vs9NwvNXWmIYCJuNC5xVmRQ/Bx5mvcCEyJ
         eeMLStp1nf7CSJYOFQ3HAjMXOVNqigQcFSuXB6UwKwIEdAqc6IVasr3ZJxoiLzY3eo2Z
         87lwoAinYP17sKsXVhnKb8cyjVu8iwH5cmyZaOgG/GcPIKQ877F5ifDbHprTYrErjJPG
         TO8MdvqMMcI1mOMCU5l8bmmL1lpeSxKzmx3NFQyRYvuHsyVm3Wx/W/U2/q0ffGab63oj
         ku533u/uz37/FEdo6iis0tslAAeLsZDrRM4BgHv5B8PioTu0tgsZ95Z86Cej0Y0uSPnK
         I5PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689910472; x=1690515272;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=jR6wHNjkhuAI8VNtYWEPWDZXPwfmPMcO3jpv83zksZQ=;
        b=BoHyvAXr74BlCLQpqCPqbo+1sDXkr0XSQ9yWi8Kv0TjBJTvRc+ntimto9GeHP7XFFF
         7rJRRHKM8hNxNuYGkT7UZH8525girlghN7w6R42wgBwgZLCnFgxFYxjWNIOOboiVD+ln
         y3LpVIslC+B3s2SGXtVqp18siYZzoabwR4BifZFYfQ/sLIWKS6oxPb51u0gbFEguBN2V
         JFup6hrHBB/ZqtdvkWu9B4V24a2w0M8RO71F801kXXkoS/On47bE/+JTspMp77N5Vlyq
         V6DYRPf/QdK4nLC1ji5r/dcLLIGqLd31PJzKhIX3+luU41Jetj8NfZpAsPjaH9A+mLDg
         MT8g==
X-Gm-Message-State: ABy/qLb+Q0WgxAO56KJtH1TtCkskwSrN36nAgzdBbCDUSEbT6YKr7sK/
        oLRGJp36XsQgPCyB0JChdjN+uw==
X-Google-Smtp-Source: APBJJlEwmqKCk30Ril8nrvjc3i/r6fibCDHZNJG4EdR5uenHRqA0CDNgAf38W1xymFiRi7zDjqA4NQ==
X-Received: by 2002:a05:6a20:1d0:b0:12c:518:b8de with SMTP id 16-20020a056a2001d000b0012c0518b8demr690176pzz.17.1689910471838;
        Thu, 20 Jul 2023 20:34:31 -0700 (PDT)
Received: from [10.3.208.155] ([61.213.176.7])
        by smtp.gmail.com with ESMTPSA id k10-20020a170902ba8a00b001b05e96d859sm2196291pls.135.2023.07.20.20.34.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Jul 2023 20:34:31 -0700 (PDT)
Message-ID: <0374eed4-1615-fbf0-37a2-45799611c84d@bytedance.com>
Date:   Fri, 21 Jul 2023 11:34:26 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [fuse-devel] [PATCH 1/3] fuse: invalidate page cache pages before
 direct write
To:     Hao Xu <hao.xu@linux.dev>, fuse-devel@lists.sourceforge.net
Cc:     linux-fsdevel@vger.kernel.org, bernd.schubert@fastmail.fm,
        Wanpeng Li <wanpengli@tencent.com>, cgxu519@mykernel.net,
        miklos@szeredi.hu
References: <20230630094602.230573-1-hao.xu@linux.dev>
 <20230630094602.230573-2-hao.xu@linux.dev>
From:   Jiachen Zhang <zhangjiachen.jaycee@bytedance.com>
In-Reply-To: <20230630094602.230573-2-hao.xu@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 2023/6/30 17:46, Hao Xu wrote:
> From: Hao Xu <howeyxu@tencent.com>
> 
> In FOPEN_DIRECT_IO, page cache may still be there for a file since
> private mmap is allowed. Direct write should respect that and invalidate
> the corresponding pages so that page cache readers don't get stale data.
> 
> Signed-off-by: Hao Xu <howeyxu@tencent.com>
> ---
>   fs/fuse/file.c | 12 +++++++++++-
>   1 file changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/fuse/file.c b/fs/fuse/file.c
> index bc4115288eec..7d6dd0e56b73 100644
> --- a/fs/fuse/file.c
> +++ b/fs/fuse/file.c
> @@ -1465,7 +1465,8 @@ ssize_t fuse_direct_io(struct fuse_io_priv *io, struct iov_iter *iter,
>   	int write = flags & FUSE_DIO_WRITE;
>   	int cuse = flags & FUSE_DIO_CUSE;
>   	struct file *file = io->iocb->ki_filp;
> -	struct inode *inode = file->f_mapping->host;
> +	struct address_space *mapping = file->f_mapping;
> +	struct inode *inode = mapping->host;
>   	struct fuse_file *ff = file->private_data;
>   	struct fuse_conn *fc = ff->fm->fc;
>   	size_t nmax = write ? fc->max_write : fc->max_read;
> @@ -1477,6 +1478,7 @@ ssize_t fuse_direct_io(struct fuse_io_priv *io, struct iov_iter *iter,
>   	int err = 0;
>   	struct fuse_io_args *ia;
>   	unsigned int max_pages;
> +	bool fopen_direct_write = (ff->open_flags & FOPEN_DIRECT_IO) && write;
>   
>   	max_pages = iov_iter_npages(iter, fc->max_pages);
>   	ia = fuse_io_alloc(io, max_pages);
> @@ -1491,6 +1493,14 @@ ssize_t fuse_direct_io(struct fuse_io_priv *io, struct iov_iter *iter,
>   			inode_unlock(inode);
>   	}
>   
> +	if (fopen_direct_write) {
> +		res = invalidate_inode_pages2_range(mapping, idx_from, idx_to);
> +		if (res) {
> +			fuse_io_free(ia);
> +			return res;
> +		}
> +	}
> +
>   	io->should_dirty = !write && user_backed_iter(iter);
>   	while (count) {
>   		ssize_t nres;


Tested-by: Jiachen Zhang <zhangjiachen.jaycee@bytedance.com>

Thanks,
Jiachen
