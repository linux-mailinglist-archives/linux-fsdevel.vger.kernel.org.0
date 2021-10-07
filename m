Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57CE34251C0
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Oct 2021 13:10:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232791AbhJGLLx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 7 Oct 2021 07:11:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232665AbhJGLLv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 7 Oct 2021 07:11:51 -0400
Received: from mail-vs1-xe2a.google.com (mail-vs1-xe2a.google.com [IPv6:2607:f8b0:4864:20::e2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CC24C061760
        for <linux-fsdevel@vger.kernel.org>; Thu,  7 Oct 2021 04:09:58 -0700 (PDT)
Received: by mail-vs1-xe2a.google.com with SMTP id w13so6366314vsa.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 07 Oct 2021 04:09:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HzsMoRJsH8Sqc/5QUEzazNk9LwUNPwGYQgI6XlOhwdM=;
        b=jjMWBQ2b9mG7NVaxJoDtibQ3OU6rQZ2zpfbaqAgq2HL5qORXLUX1Vi07dspO0J6aAE
         ICBr2srIBsmVhXWLi/2xcHtw0vRKfJqJudBZZkWofSZIHP70MUigU+lFODf0f10lqDtK
         UBD1UJGTDLuVUHTwzgYl9626fOtXaPkl82ihM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HzsMoRJsH8Sqc/5QUEzazNk9LwUNPwGYQgI6XlOhwdM=;
        b=hIOQ7FeovaZ6WaFaKNntU6EPphmRov34vhLhe5iJRupaUzqVIY09m4tIoksNA1fXVX
         WcH4mLNn8Th0qLiDjBFB7lypjIUE7T6FGPthT4O10ALWwttrOtrG1FxQyY+jsbo6V6sY
         xGPb4/tQXBwy0oxSctEV9ZvLSTnez7/a/MoBMdJPCCu+dOOHW5ihuW0SA/hyPL9Io23z
         MZTPXZUmAuXvoURsthl0l1WKIQkTwqtog1l1446f1Ce6z6g1Ej4yYFwsUb506EPb2lPe
         ycTisl05q2vJ7GvHKJxj3j74/YNP7hl265ydQGGLBPeDOpOGXvEPNtpCveg2GpdSqnxd
         uciw==
X-Gm-Message-State: AOAM531VNtnpE5tztvf+JZgMc+RO9XrWxHRifdQExuRyrxNSzOG2o6/Y
        hnNkNxD6kLKiSEFiIZzDsXN/BXMNUZJGE+jS3XK8uQ==
X-Google-Smtp-Source: ABdhPJwwlMDrzL1eRmXK79q/c/bQxWvYBLZtluQeSTQttotP78WIpfO7fpUap6vTe2AKIKk7F7bBMi6PJsRRqyRS7HI=
X-Received: by 2002:a05:6102:3c3:: with SMTP id n3mr3179780vsq.19.1633604997574;
 Thu, 07 Oct 2021 04:09:57 -0700 (PDT)
MIME-Version: 1.0
References: <20210923130814.140814-1-cgxu519@mykernel.net> <20210923130814.140814-8-cgxu519@mykernel.net>
In-Reply-To: <20210923130814.140814-8-cgxu519@mykernel.net>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Thu, 7 Oct 2021 13:09:46 +0200
Message-ID: <CAJfpegtLi1PsfpkohJ-8kTHVazf7cZiX96OSBMn7Q39PY_PXaw@mail.gmail.com>
Subject: Re: [RFC PATCH v5 07/10] ovl: cache dirty overlayfs' inode
To:     Chengguang Xu <cgxu519@mykernel.net>
Cc:     Jan Kara <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>,
        linux-fsdevel@vger.kernel.org,
        overlayfs <linux-unionfs@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 23 Sept 2021 at 15:08, Chengguang Xu <cgxu519@mykernel.net> wrote:
>
> Now drop overlayfs' inode will sync dirty data,
> so we change to only drop clean inode.
>
> The purpose of doing this is to keep compatible
> behavior with before because without this change
> dropping overlayfs inode will not trigger syncing
> of underlying dirty inode.
>
> Signed-off-by: Chengguang Xu <cgxu519@mykernel.net>
> ---
>  fs/overlayfs/super.c | 16 +++++++++++++++-
>  1 file changed, 15 insertions(+), 1 deletion(-)
>
> diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
> index cddae3ca2fa5..bf4000eb9be8 100644
> --- a/fs/overlayfs/super.c
> +++ b/fs/overlayfs/super.c
> @@ -441,11 +441,25 @@ static int ovl_write_inode(struct inode *inode,
>         return ret;
>  }
>
> +/*
> + * In iput_final(), clean inode will drop directly and dirty inode will
> + * keep in the cache until write back to sync dirty data then add to lru
> + * list to wait reclaim.
> + */
> +static int ovl_drop_inode(struct inode *inode)
> +{
> +       struct inode *upper = ovl_inode_upper(inode);
> +
> +       if (!upper || !(inode->i_state & I_DIRTY_ALL))

Could we check upper dirtyness here? That would give a more precise result.

Alternatively don't set .drop_inode (i.e. use generic_drop_inode())
and set I_DONTCACHE on overlay inodes.  That would cause the upper
inode to be always written back before eviction.

The latter would result in simpler logic, and I think performance-wise
it wouldn't matter.   But I may be missing something.

Thanks,
Miklos
