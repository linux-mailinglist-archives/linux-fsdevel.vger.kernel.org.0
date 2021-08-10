Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53FC73E52F9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Aug 2021 07:39:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237188AbhHJFkB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Aug 2021 01:40:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236404AbhHJFkA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Aug 2021 01:40:00 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBA22C0613D3
        for <linux-fsdevel@vger.kernel.org>; Mon,  9 Aug 2021 22:39:38 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id d1so19490609pll.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 09 Aug 2021 22:39:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Tf4nmD17+ecVvsbqqOAvrmS3l/yT+Dp/DDxMY8tYrBs=;
        b=jcG5iPNCldLVyLdKOVH9CqtOgETWb7k4LOElnYkWfKJiUR3ZBr1pJ7YPAESQvLIbRd
         xfq7KXl0Dygv5PQkPvEKg/jT6gTZMacljSygDVBPhEDYy1kJiWhSSXtAxBI6XccZE+n4
         LRbX6jDLPbF5fwoCNDE+B0PjfS2LWq7VrFG9v5FB/L46/MyUlY5FQjIrmJT/aoanMc1G
         J9Du3cJPEsBKUL/s1+CltIzv90uGWOYnEQzRu5gYsagAsgqV/UD2cVOuwMvncrJWyJfv
         E1QCMHgcFPoK7cF2oG9Tl0vkLgjTAdL/HnFsPKKsQXJRZlwgX8VszWwwzhuv7ummXuUV
         qS6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Tf4nmD17+ecVvsbqqOAvrmS3l/yT+Dp/DDxMY8tYrBs=;
        b=FhEVfAD4Tmn6K8zyuNgtvN0SdO+BVrtjg1i7Me/E5tx3OCV091xrbK76qwVABd2dT/
         gQZ5W44AXFruiiNylAsip3tQuZc+zMlGn8iksTxlaxTbtE/19DYIVOpz9RoYyk+VlBzC
         cgVWJQ91UZdoL5h50zUP8yMgGP3c+3akyJS0xTnhWo1i4LJ40prX4u3xvmh88xcSfMRb
         d4Do3s1Iunrr80X+F9UipTD3d4s9wjqrGsb9iqO0eS+meZvcv3M8f/4/VKzFkQBnCTZV
         rIq810ar4RlOXOPILzJfhEeSn/3EbEZgnqpId0bLuQZjutsoAgvB557qn5VM/Mp7XJbR
         3gUQ==
X-Gm-Message-State: AOAM531OTPg/33ZKHfGlqnuynVjILQT/NhbpQu1PsvOuSh+k+TOu69x9
        iUr8LnVtZAxYpGj1eeDeLqi1exk3HGm+HA==
X-Google-Smtp-Source: ABdhPJxDQtq0h+Yid5eY760ocpVHHoI9HItzxVvYz0mCstTIWH1jIP0xpx4aW3BlNi+Y28EyuyZyVQ==
X-Received: by 2002:a17:90a:982:: with SMTP id 2mr29919407pjo.198.1628573977973;
        Mon, 09 Aug 2021 22:39:37 -0700 (PDT)
Received: from google.com ([2401:fa00:9:211:46f7:f8ea:5192:59e7])
        by smtp.gmail.com with ESMTPSA id t9sm28345104pgc.81.2021.08.09.22.39.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Aug 2021 22:39:37 -0700 (PDT)
Date:   Tue, 10 Aug 2021 15:39:26 +1000
From:   Matthew Bobrowski <repnop@google.com>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jan Kara <jack@suse.cz>,
        Matthew Bobrowski <mbobrowski@mbobrowski.org>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 1/4] fsnotify: replace igrab() with ihold() on attach
 connector
Message-ID: <YRIRDgAbya4GQ0bc@google.com>
References: <20210803180344.2398374-1-amir73il@gmail.com>
 <20210803180344.2398374-2-amir73il@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210803180344.2398374-2-amir73il@gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Aug 03, 2021 at 09:03:41PM +0300, Amir Goldstein wrote:
> We must have a reference on inode, so ihold is cheaper.
> 
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>

LGTM.

Reviewed-by: Matthew Bobrowski <repnop@google.com>

> ---
>  fs/notify/mark.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/notify/mark.c b/fs/notify/mark.c
> index d32ab349db74..80459db58f63 100644
> --- a/fs/notify/mark.c
> +++ b/fs/notify/mark.c
> @@ -493,8 +493,11 @@ static int fsnotify_attach_connector_to_object(fsnotify_connp_t *connp,
>  		conn->fsid.val[0] = conn->fsid.val[1] = 0;
>  		conn->flags = 0;
>  	}
> -	if (conn->type == FSNOTIFY_OBJ_TYPE_INODE)
> -		inode = igrab(fsnotify_conn_inode(conn));
> +	if (conn->type == FSNOTIFY_OBJ_TYPE_INODE) {
> +		inode = fsnotify_conn_inode(conn);
> +		ihold(inode);
> +	}
> +
>  	/*
>  	 * cmpxchg() provides the barrier so that readers of *connp can see
>  	 * only initialized structure
> -- 
> 2.25.1
> 
/M
