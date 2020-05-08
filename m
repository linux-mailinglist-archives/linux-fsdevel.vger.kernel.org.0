Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADAC01CB8A5
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 May 2020 21:53:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727861AbgEHTxC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 8 May 2020 15:53:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727826AbgEHTw6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 8 May 2020 15:52:58 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E069C05BD0C
        for <linux-fsdevel@vger.kernel.org>; Fri,  8 May 2020 12:52:58 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id s186so1131548qkd.4
        for <linux-fsdevel@vger.kernel.org>; Fri, 08 May 2020 12:52:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+PiQ6ckxUTnSDo+AGLRh/Fg+o3k0O3ko3wY06x3JoKE=;
        b=Ts3CIrENqZECosUV9ufuB6NplQ4bZIANry4cTq9ctiFl2W3eKhj5UpDDQOEaY6A2Yd
         mNvqS8MpDNbFmXG47isv0LHHuWhU9DrWeNeUqpMHP3rRP+c5b6gcvtAg+8ZLRMd/gdoD
         1i8v4D54gKF1JaotzplFLT3nMfQ5VKcTVTMjFomlH2d9ykBhs9YeoAV4r0fEyjl3TlPr
         v2KDioACvLG1JOHWROC3jtqtFiE8v+6chVfwhJVwQ6LpHrO+DnmO5kWS3VjbGmk9WNEY
         aeK1VQ7Ix6UqBc9nyw9EdxtaWdyBCOYz2f1ZZWBmiN42UGRN2WCkIjnAj9hWJy7yjUPW
         HsMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+PiQ6ckxUTnSDo+AGLRh/Fg+o3k0O3ko3wY06x3JoKE=;
        b=OR94/NuQosH0JXMbbu1T1t2WV6//IEkDZ8DSh4ssYcPX2x32rcreGmMS0V8IOjKthI
         rBFB3COMWiju1MCiUWq0pB22642OYkXEblNT6q6aD4JdJsXZhAJgFKt8LXGsd+dx0i4/
         IhxGSnGLk+71njI145N/8ihe9KD7/5v1v3ESJ/fWQVdYKH05k45ytdjV6prk5wDnxRZR
         apVmzm9CPkEWyYNHJyfD2fO+WR4wzJUSM4f/ly7P/uWxN3N+PfxurHiKXFZjaqtbgPYS
         jJEDINon9ZjAItbQ/A8NkRDewjKNoSZP+8uEesf7PbniVc08JBU7O8+DRzTb+GGz5ITe
         hnFA==
X-Gm-Message-State: AGi0PuZFLrMJXrO7hHn8gj77AxGRWkK80N2z4lezr1EimxacKrsu28ec
        8F5vvqfWg3ws0Wp+AEQW36bXNg==
X-Google-Smtp-Source: APiQypJ92/0qZ5iunL9hikarn4eDK0RllMv8mjTvIrEJ1zjbLNqAjWeKqDY9cc4vVlZEbqAojJlNqA==
X-Received: by 2002:a37:a4d8:: with SMTP id n207mr4488919qke.354.1588967577470;
        Fri, 08 May 2020 12:52:57 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id c4sm1945896qkf.120.2020.05.08.12.52.56
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 08 May 2020 12:52:56 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1jX93I-0002SQ-9Q; Fri, 08 May 2020 16:52:56 -0300
Date:   Fri, 8 May 2020 16:52:56 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-rdma@vger.kernel.org, kvm@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, io-uring@vger.kernel.org,
        netdev@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH 09/12] rdma: use __anon_inode_getfd
Message-ID: <20200508195256.GA8912@ziepe.ca>
References: <20200508153634.249933-1-hch@lst.de>
 <20200508153634.249933-10-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200508153634.249933-10-hch@lst.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, May 08, 2020 at 05:36:31PM +0200, Christoph Hellwig wrote:
> Use __anon_inode_getfd instead of opencoding the logic using
> get_unused_fd_flags + anon_inode_getfile.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  drivers/infiniband/core/rdma_core.c | 17 ++++-------------
>  1 file changed, 4 insertions(+), 13 deletions(-)

 
> diff --git a/drivers/infiniband/core/rdma_core.c b/drivers/infiniband/core/rdma_core.c
> index 5128cb16bb485..541e5e06347f6 100644
> --- a/drivers/infiniband/core/rdma_core.c
> +++ b/drivers/infiniband/core/rdma_core.c
> @@ -462,30 +462,21 @@ alloc_begin_fd_uobject(const struct uverbs_api_object *obj,
>  	if (WARN_ON(fd_type->fops->release != &uverbs_uobject_fd_release))
>  		return ERR_PTR(-EINVAL);
>  
> -	new_fd = get_unused_fd_flags(O_CLOEXEC);
> -	if (new_fd < 0)
> -		return ERR_PTR(new_fd);
> -
>  	uobj = alloc_uobj(attrs, obj);
>  	if (IS_ERR(uobj))
> -		goto err_fd;
> +		return uobj;
>  
>  	/* Note that uverbs_uobject_fd_release() is called during abort */
> -	filp = anon_inode_getfile(fd_type->name, fd_type->fops, NULL,
> -				  fd_type->flags);
> -	if (IS_ERR(filp)) {
> -		uobj = ERR_CAST(filp);
> +	new_fd = __anon_inode_getfd(fd_type->name, fd_type->fops, NULL,
> +			fd_type->flags | O_CLOEXEC, &filp);
> +	if (new_fd < 0)
>  		goto err_uobj;

This will conflict with a fix (83a267021221 'RDMA/core: Fix
overwriting of uobj in case of error') that is going to go to -rc
soon.

Also the above misses returning an ERR_PTR if __anon_inode_getfd fails, it
returns a uobj that had been freed.. I suppose it should be something
like

if (new_fd < 0) {
   uverbs_uobject_put(uobj);
   return ERR_PTR(new_fd)
}

?

Jason
