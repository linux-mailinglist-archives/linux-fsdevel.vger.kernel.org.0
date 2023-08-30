Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D92678DAA1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Aug 2023 20:37:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237778AbjH3Sgq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 30 Aug 2023 14:36:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243421AbjH3K5m (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 30 Aug 2023 06:57:42 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B81041A1
        for <linux-fsdevel@vger.kernel.org>; Wed, 30 Aug 2023 03:57:38 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-99bcf2de59cso719842266b.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 30 Aug 2023 03:57:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1693393057; x=1693997857; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/L+MYmRv4PKWD0Xf33WOV5Foq2uHuWDUSSf9j3EgBD8=;
        b=an9+cOHl9rRnMl1GBF8Q3QEcYnPuBVnYgEfBhmb73UPp3ogA1z+8i7xc+5Qu7Aw89B
         z/CaHKq/QYDLT0gE7PQqyyeYXigHDDhyk8T7esV/lfNyX97TUJ2yXSR8TeGLx405U/BB
         WD9fgkoar32n4gDITwDXMYgQJHMylHTEAHh/s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693393057; x=1693997857;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/L+MYmRv4PKWD0Xf33WOV5Foq2uHuWDUSSf9j3EgBD8=;
        b=ZJRv2TVAFrppM5OK2C8djYQFICpJu31mhw6sMqpO/t3Htwyf8M+HUkPuqONe6D9ZpW
         NwH/UKUkvsB2xD6NCp6s6FWf3l8k6UngDan2mlz71gSQp5xZif33TOFZzUPDiRcF1+zs
         VnF+e6f99NHGnTGjZM9eQWsqAy5sdP3q7Yitfz2vcCoFcE8hjTAI0UMGdMuqKCKMsT8X
         RIiqA0cHztMuXri8+rjri3CdJbjobrc8Mj8Nqy57JFCNFgX6n87z5sQ28MpwOguBQJRx
         wZPMz9d7w77yclj2pkU7Y69M06paW48TwsnpZult/Ob+dD2wrUW0bnvN+gOF/BI8UNm6
         mYJw==
X-Gm-Message-State: AOJu0YwEm6OorW2UrwDLjtGHNN57MlxoD9raUqOjbLpc51mMGFNLcccS
        RyV6Mdxbq9mxMtPUdVb+62JXbyK65brNzxAJ6Bjt7NWjiXumFfCj
X-Google-Smtp-Source: AGHT+IE0caqx24tMo1luI/7c7MVB83bSLJIR4xpYS0rXDYbh4yFUcrg34SXFrsFsDxIP+MW6e8dgdMvZYorUguFFJV4=
X-Received: by 2002:a17:906:738d:b0:9a5:7ade:b5e9 with SMTP id
 f13-20020a170906738d00b009a57adeb5e9mr1304014ejl.51.1693393057243; Wed, 30
 Aug 2023 03:57:37 -0700 (PDT)
MIME-Version: 1.0
References: <20230829161116.2914040-1-bschubert@ddn.com> <20230829161116.2914040-3-bschubert@ddn.com>
In-Reply-To: <20230829161116.2914040-3-bschubert@ddn.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Wed, 30 Aug 2023 12:57:25 +0200
Message-ID: <CAJfpegvnxrmU=GgxGxZCh4oyhBk3HrPeWGLqwR7quJ2RPv5JjQ@mail.gmail.com>
Subject: Re: [PATCH 2/6] fuse: Create helper function if DIO write needs
 exclusive lock
To:     Bernd Schubert <bschubert@ddn.com>
Cc:     linux-fsdevel@vger.kernel.org, bernd.schubert@fastmail.fm,
        dsingh@ddn.com, Hao Xu <howeyxu@tencent.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 29 Aug 2023 at 18:11, Bernd Schubert <bschubert@ddn.com> wrote:
>
> This is just a preparation to avoid code duplication in the next
> commit.
>
> Cc: Hao Xu <howeyxu@tencent.com>
> Cc: Miklos Szeredi <miklos@szeredi.hu>
> Cc: Dharmendra Singh <dsingh@ddn.com>
> Signed-off-by: Bernd Schubert <bschubert@ddn.com>
> ---
>  fs/fuse/file.c | 48 +++++++++++++++++++++++++++++++++---------------
>  1 file changed, 33 insertions(+), 15 deletions(-)
>
> diff --git a/fs/fuse/file.c b/fs/fuse/file.c
> index b1b9f2b9a37d..6b8b9512c336 100644
> --- a/fs/fuse/file.c
> +++ b/fs/fuse/file.c
> @@ -1298,6 +1298,37 @@ static ssize_t fuse_perform_write(struct kiocb *iocb, struct iov_iter *ii)
>         return res;
>  }
>
> +static bool fuse_io_past_eof(struct kiocb *iocb,
> +                                              struct iov_iter *iter)
> +{
> +       struct inode *inode = file_inode(iocb->ki_filp);
> +
> +       return iocb->ki_pos + iov_iter_count(iter) > i_size_read(inode);
> +}
> +
> +/*
> + * @return true if an exclusive lock direct IO writes is needed
> + */
> +static bool fuse_dio_wr_exclusive_lock(struct kiocb *iocb, struct iov_iter *from)
> +{
> +       struct file *file = iocb->ki_filp;
> +       struct fuse_file *ff = file->private_data;
> +
> +       /* server side has to advise that it supports parallel dio writes */
> +       if (!(ff->open_flags & FOPEN_PARALLEL_DIRECT_WRITES))
> +               return false;

You got the return values the wrong way around.  I can fix this, no
need to resend.

Thanks,
Miklos
