Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7867B10A965
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Nov 2019 05:24:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727742AbfK0EYo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 26 Nov 2019 23:24:44 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:46723 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727734AbfK0EYo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 26 Nov 2019 23:24:44 -0500
Received: by mail-pf1-f194.google.com with SMTP id 193so10291169pfc.13
        for <linux-fsdevel@vger.kernel.org>; Tue, 26 Nov 2019 20:24:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=cruZnOIQhNKwaUdTnpxXaRkPPQIJLlnQzi55bfc1FDk=;
        b=Uov/dvVa+NFZre/Pxa63oFagioekbzhykEY9uC1NgQlWTmDe3MrzWWvy9Zt7KnD6nx
         JcVzMDenZzT9Jy1ubkKHf4lG9QRkvegs3efFfrUdj94O6iXMUYwg7qGxuxwubrPMXHLh
         rOgkOXAbP2OWyoEm0pSD8uHT3ho5NZhpHXOX8Hwqi5J+clekJ8dcIy/v6pAwSwpQeoeo
         9O8DofPw1gzKIJN0IpXwOxovlThNUTHxlGD/qdUnnlsoGJhuzCVHEhzFgFdVt3ljBxfV
         Fi4xdxIGx/VCFqVhmJLESMIFOZfA2bfnQmzo0CSx2RT5O7+HSjNXziEKEuP8qo4noLzf
         45/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=cruZnOIQhNKwaUdTnpxXaRkPPQIJLlnQzi55bfc1FDk=;
        b=auzHvqJWoCrwmqCFmXpF+mtMJa8LCTst4z/0AGJpB6LoY/Ksp2Du8jexmEdW/Y9t9Z
         fUv60lQvIpYTvB8/kFnE1QQkbQWOhpMdHUadpJaG5/eVlxa7R4WNAftu+8H2t9sIoM2R
         mobMOpC5ajbnGh4nRid4MfIMRpU2ehbpJMzqezDQatfI6aYQPM8gXfCvKQm1H91sRHnJ
         yy5o0fQQRvuCSsmj90pPomjZyIMjYh8pcePcPDVRlq2kr6Ljavh9vb6nJABAe1t5M8/a
         eidJPkHLxC9BqzlSnXyDocGmwC+l9LJKdbGzxGbvypskf9PQbxz5EevZ1nrTFTUeK39o
         WpDw==
X-Gm-Message-State: APjAAAWZHgxW/irZzy4d2hqJ1Uv9PpLjUxatSvzevDO4Icts0oZmpt6u
        Nj+dvIlud9Wcd3hK1oQw2pqB9g==
X-Google-Smtp-Source: APXvYqwHkLMzMxaDg4TQbnWaBd49ud789eb+LiQCmUKOjrQ+rDCkpU7IIi+KTGXAv9gUQiuoZeUrtw==
X-Received: by 2002:a63:391:: with SMTP id 139mr2597363pgd.40.1574828682962;
        Tue, 26 Nov 2019 20:24:42 -0800 (PST)
Received: from [100.112.92.218] ([104.133.9.106])
        by smtp.gmail.com with ESMTPSA id e10sm4536872pfm.3.2019.11.26.20.24.42
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 26 Nov 2019 20:24:42 -0800 (PST)
Date:   Tue, 26 Nov 2019 20:24:32 -0800 (PST)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     yu kuai <yukuai3@huawei.com>
cc:     hughd@google.com, akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        yi.zhang@huawei.com, zhengbin13@huawei.com
Subject: Re: [PATCH] mm/shmem.c: don't set 'seals' to 'F_SEAL_SEAL' in
 shmem_get_inode
In-Reply-To: <20191127040051.39169-1-yukuai3@huawei.com>
Message-ID: <alpine.LSU.2.11.1911262008330.2204@eggly.anvils>
References: <20191127040051.39169-1-yukuai3@huawei.com>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 27 Nov 2019, yu kuai wrote:

> 'seals' is set to 'F_SEAL_SEAL' in shmem_get_inode, which means "prevent
> further seals from being set", thus sealing API will be useless and many
> code in shmem.c will never be reached. For example:

The sealing API is not useless, and that code can be reached.

> 
> shmem_setattr
> 	if ((newsize < oldsize && (info->seals & F_SEAL_SHRINK)) ||
> 	    (newsize > oldsize && (info->seals & F_SEAL_GROW)))
> 		return -EPERM;
> 
> So, initialize 'seals' to zero is more reasonable.
> 
> Signed-off-by: yu kuai <yukuai3@huawei.com>

NAK.

See memfd_create in mm/memfd.c (code which originated in mm/shmem.c,
then was extended to support hugetlbfs also): sealing is for memfds,
not for tmpfs or hugetlbfs files or SHM.  Without thinking about it too
hard, I believe that to allow sealing on tmpfs files would introduce
surprising new behaviors on them, which might well raise security issues;
and also be incompatible with the guarantees intended by sealing.

> ---
>  mm/shmem.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/mm/shmem.c b/mm/shmem.c
> index 165fa6332993..7b032b347bda 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -2256,7 +2256,6 @@ static struct inode *shmem_get_inode(struct super_block *sb, const struct inode
>  		memset(info, 0, (char *)inode - (char *)info);
>  		spin_lock_init(&info->lock);
>  		atomic_set(&info->stop_eviction, 0);
> -		info->seals = F_SEAL_SEAL;
>  		info->flags = flags & VM_NORESERVE;
>  		INIT_LIST_HEAD(&info->shrinklist);
>  		INIT_LIST_HEAD(&info->swaplist);
> -- 
> 2.17.2
