Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62A2A78AF61
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Aug 2023 14:00:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232142AbjH1MAS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 28 Aug 2023 08:00:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229807AbjH1L7q (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 28 Aug 2023 07:59:46 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B477123
        for <linux-fsdevel@vger.kernel.org>; Mon, 28 Aug 2023 04:59:42 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-99bdcade7fbso397801266b.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 28 Aug 2023 04:59:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1693223981; x=1693828781;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+v5CLvq4zgd3txBVDJ3AmzaQjVtznzdloQ6S/LzZbYM=;
        b=KLLaUnfCjZEJM4uvVqq/m7qWZ0c43c1g9V1OXdUUIz3F7Ef/IR3XSbIhfhR2d+yM+D
         qBdbif+8b8m0k47kN0ljEqPSJ+WmgSRv1TVdXVumi9bLLt1GTPQ7yOVX1VfBQYwyYsAo
         VJC4NjybZ+M29FmbJxJ2gsOXb/HUfhKiN1Re0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693223981; x=1693828781;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+v5CLvq4zgd3txBVDJ3AmzaQjVtznzdloQ6S/LzZbYM=;
        b=b5LYLDUlKiM4wqxJOx/eL5oQgScyiOzBjSVqeEqvAWiZmSY8sZ3zwthfPIXPuM2o15
         3fOeluKywRkVGZK7Mta6uCwW7qazb5bUc8SP5yHq5inzh6xwBQT8yP1OaK8lp8EtT8dD
         rCc1bXN9qU1t8NzhbrXokpDkWZOO8XAw2TTJDJrzKeC4iKmyv2VVjAEiW4k8bPwVm6hP
         cb0+HK53Ut6ZYTQnXfQATA9iIGM1mZWLuQXp9NtTGQajZwit/tb3X01nQGXs2nYyj/h2
         x7Xg5Vn4VIU7/92AFaZklRsUWwvypFWk54m3w5Uwi7OPfTfDnIOEuhSRgNMtKGqMCJb7
         pViw==
X-Gm-Message-State: AOJu0YzWiqZ3lNFuBgpPEdUeSRWglFslbNvcNYphRq9CsTpHyhV+Nev6
        wwb944kVyK9jws/b2yWgsQ3/R9GfOcpeJJvUXzl7OOXTSyjwfOlmZrE=
X-Google-Smtp-Source: AGHT+IHtwRJ0Way0nV3F2kD/W66X2eiwaw/PKEKjgifbWZY15bx404wYO8i0SzGSbSEHs/Ob87OfR1iADq4zq8AdagM=
X-Received: by 2002:a17:907:b11:b0:9a4:88af:b77 with SMTP id
 h17-20020a1709070b1100b009a488af0b77mr6396368ejl.60.1693223980912; Mon, 28
 Aug 2023 04:59:40 -0700 (PDT)
MIME-Version: 1.0
References: <20230824150533.2788317-1-bschubert@ddn.com> <20230824150533.2788317-5-bschubert@ddn.com>
In-Reply-To: <20230824150533.2788317-5-bschubert@ddn.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Mon, 28 Aug 2023 13:59:29 +0200
Message-ID: <CAJfpegvW=9TCB+-CX0jPBA5KDufSj0hKzU3YfEYojWdHHh57eQ@mail.gmail.com>
Subject: Re: [PATCH 4/5] [RFC] fuse: Set and use IOCB_DIRECT when
 FOPEN_DIRECT_IO is set
To:     Bernd Schubert <bschubert@ddn.com>
Cc:     linux-fsdevel@vger.kernel.org, bernd.schubert@fastmail.fm,
        dsingh@ddn.com, Hao Xu <howeyxu@tencent.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 24 Aug 2023 at 17:07, Bernd Schubert <bschubert@ddn.com> wrote:
>
> fuse_direct_write_iter is basically duplicating what is already
> in fuse_cache_write_iter/generic_file_direct_write. That can be
> avoided by setting IOCB_DIRECT in fuse_file_write_iter, after that
> fuse_cache_write_iter can be used for the FOPEN_DIRECT_IO code path
> and fuse_direct_write_iter can be removed.
>
> Cc: Hao Xu <howeyxu@tencent.com>
> Cc: Miklos Szeredi <miklos@szeredi.hu>
> Cc: Dharmendra Singh <dsingh@ddn.com>
> Cc: linux-fsdevel@vger.kernel.org
> Signed-off-by: Bernd Schubert <bschubert@ddn.com>
> ---
>  fs/fuse/file.c | 54 ++++----------------------------------------------
>  1 file changed, 4 insertions(+), 50 deletions(-)
>
> diff --git a/fs/fuse/file.c b/fs/fuse/file.c
> index 905ce3bb0047..09277a54b711 100644
> --- a/fs/fuse/file.c
> +++ b/fs/fuse/file.c
> @@ -1589,52 +1589,6 @@ static ssize_t fuse_direct_read_iter(struct kiocb *iocb, struct iov_iter *to)
>         return res;
>  }
>
> -static ssize_t fuse_direct_write_iter(struct kiocb *iocb, struct iov_iter *from)
> -{
> -       struct inode *inode = file_inode(iocb->ki_filp);
> -       struct fuse_io_priv io = FUSE_IO_PRIV_SYNC(iocb);
> -       ssize_t res;
> -       bool exclusive_lock = fuse_dio_wr_exclusive_lock(iocb, from);
> -
> -       /*
> -        * Take exclusive lock if
> -        * - Parallel direct writes are disabled - a user space decision
> -        * - Parallel direct writes are enabled and i_size is being extended.
> -        *   This might not be needed at all, but needs further investigation.
> -        */
> -       if (exclusive_lock)
> -               inode_lock(inode);
> -       else {
> -               inode_lock_shared(inode);
> -
> -               /* A race with truncate might have come up as the decision for
> -                * the lock type was done without holding the lock, check again.
> -                */
> -               if (fuse_direct_write_extending_i_size(iocb, from)) {
> -                       inode_unlock_shared(inode);
> -                       inode_lock(inode);
> -                       exclusive_lock = true;
> -               }
> -       }
> -
> -       res = generic_write_checks(iocb, from);
> -       if (res > 0) {
> -               if (!is_sync_kiocb(iocb) && iocb->ki_flags & IOCB_DIRECT) {
> -                       res = fuse_direct_IO(iocb, from);
> -               } else {
> -                       res = fuse_direct_io(&io, from, &iocb->ki_pos,
> -                                            FUSE_DIO_WRITE);
> -                       fuse_write_update_attr(inode, iocb->ki_pos, res);

While I think this is correct, I'd really like if the code to be
replaced and the replacement are at least somewhat comparable.

Currently fuse_direct_IO() handles all cases (of which are many since
the requester can be sync or async and the server can be sync or
async).

Could this mess be cleaned up somehow?

Also could we make the function names of fuse_direct_IO() and
fuse_direct_io() less similar, as this is a very annoying (though
minor) issue.

Thanks,
Miklos
