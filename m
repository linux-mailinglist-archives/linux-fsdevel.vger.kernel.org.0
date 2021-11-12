Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B829C44E6CD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Nov 2021 13:53:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234978AbhKLM4s (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 12 Nov 2021 07:56:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231652AbhKLM4r (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 12 Nov 2021 07:56:47 -0500
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4C4FC061766;
        Fri, 12 Nov 2021 04:53:56 -0800 (PST)
Received: by mail-ot1-x331.google.com with SMTP id z2-20020a9d71c2000000b0055c6a7d08b8so13712762otj.5;
        Fri, 12 Nov 2021 04:53:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zenB0fvF8v9LEnZLKkAsA85Z8KWObb5c13LjpylZxxw=;
        b=cXOZX0K1nhcFmPUEIIXRVUdPfxwyYSr9a6rksmFdq3b6996mc083FolKZJOyVzIFWl
         PmJvouVIirT7VEP+KABPoh3OOesDc7ZEt4yukXC2i0pC84XW7Ly5Nj9ZgFvn4pEdqa7c
         RfIIiLJy2RQS/j8G9wLGMDmW/MCj3l7+YOd4MCNXOvpkxkhym1Lc3HDVaO3QMzz04udp
         JlHGUaU2PDfwVfjLnJfl3NmvhSGuGOpJtuABiSwBuIBjlJCDejRYVpoykpCAz5oc8Atm
         /NtKZREIlmuoPdueGPkBDHmfEeq1f/MaaP9QfRmurz3xlF+CehLOrNTTrFfHx4Q+Jvf+
         7vEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zenB0fvF8v9LEnZLKkAsA85Z8KWObb5c13LjpylZxxw=;
        b=m+2Xf2sohQQDPmhEyuPHUOrZa1AsIsN+/1gIMO5BTzG4PD8FQTZd5ehou85X6IGRee
         bZPah3dO9D4jS83YCcQ1Ttw7/AzVISkcpQTLeV5KymSdBJwNGXFuSIH3j/3oMS8m9HRl
         Uw7VsOHRg+nJ+PtTY2YvWSOk7ZgcTbejMnodj+t2/z/8QQep84lL2ffdAb9FQ+BpSj8O
         CqmE+jbn4PSuemiB3i386BjUnpTx051fs1ByaP0QxZJr5M6Tznw07oWpcdOIeKZO3NaA
         8R6dXZXK9isrosaSHZMF+P9A2N1u3GepsoBW0E8FRz1JykFUIa0DPEOoVcB7ZHuGB07S
         OjCw==
X-Gm-Message-State: AOAM533khJueCQk9YMBMb6zv/9D7vXgTp/VmrZCoKmZzZsq8qf7na+MN
        QVOoPgURWip2gaiBHJCCvHXIc2fG6+OWaW9l4qU=
X-Google-Smtp-Source: ABdhPJzmd7ahakZtPsoVhUgCyvqXEVKmVd83v6byjVJ1cxhIvKY96Q+YLn6q51qSl+n9zl8wS3ZdED4FOFR4xuPqQZY=
X-Received: by 2002:a9d:6f0e:: with SMTP id n14mr12287323otq.173.1636721635955;
 Fri, 12 Nov 2021 04:53:55 -0800 (PST)
MIME-Version: 1.0
References: <20211112124411.1948809-1-roberto.sassu@huawei.com> <20211112124411.1948809-5-roberto.sassu@huawei.com>
In-Reply-To: <20211112124411.1948809-5-roberto.sassu@huawei.com>
From:   Ajay Garg <ajaygargnsit@gmail.com>
Date:   Fri, 12 Nov 2021 18:23:43 +0530
Message-ID: <CAHP4M8V9i7PZvPKwzWRo54u0xjrGwhtPPsHCjxwy9SLQM7HbEg@mail.gmail.com>
Subject: Re: [RFC][PATCH 4/5] shmem: Avoid segfault in shmem_read_mapping_page_gfp()
To:     Roberto Sassu <roberto.sassu@huawei.com>
Cc:     ebiggers@kernel.org, tytso@mit.edu, corbet@lwn.net,
        viro@zeniv.linux.org.uk, hughd@google.com,
        akpm@linux-foundation.org, linux-fscrypt@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Roberto.

Identical patch has been floated earlier via :
https://lore.kernel.org/linux-mm/CAMZfGtUp6dkT4OWzLhL8whqNnXAbfVw5c6AQogHzY3bbM_k2Qw@mail.gmail.com/T/#m2189d135b9293de9b4a11362f0179c17b254d5ab


Thanks and Regards,
Ajay

On Fri, Nov 12, 2021 at 6:15 PM Roberto Sassu <roberto.sassu@huawei.com> wrote:
>
> Check the hwpoison page flag only if the page is valid in
> shmem_read_mapping_page_gfp(). The PageHWPoison() macro tries to access
> the page flags and cannot work on an error pointer.
>
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> ---
>  mm/shmem.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/mm/shmem.c b/mm/shmem.c
> index 23c91a8beb78..427863cbf0dc 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -4222,7 +4222,7 @@ struct page *shmem_read_mapping_page_gfp(struct address_space *mapping,
>         else
>                 unlock_page(page);
>
> -       if (PageHWPoison(page))
> +       if (!IS_ERR(page) && PageHWPoison(page))
>                 page = ERR_PTR(-EIO);
>
>         return page;
> --
> 2.32.0
>
