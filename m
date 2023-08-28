Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02C7278ABC6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Aug 2023 12:35:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231506AbjH1Kec (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 28 Aug 2023 06:34:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231535AbjH1KeE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 28 Aug 2023 06:34:04 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C3281B7
        for <linux-fsdevel@vger.kernel.org>; Mon, 28 Aug 2023 03:33:43 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-99bed101b70so372128966b.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 28 Aug 2023 03:33:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1693218821; x=1693823621;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=22ptF9+OdBflNqC3CG8ILMY9HWSZbV+I/2T7CmbQO3c=;
        b=To1BmKHZB7kG6GNDI5B1m/wCGHr9V+Hkx819UDThqUpH7lDwaaZpQCCsDHGWpGBLRh
         VCJdqkiOYk3mHZOcjoJ+qyd5ZwFo/lxytdNXk9b69Iec1FU6fUu7dw5PaatX8WExB75b
         IWwQjOKgM1E1RoqMPr+WA5VMc9l3Qy+3FczDg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693218821; x=1693823621;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=22ptF9+OdBflNqC3CG8ILMY9HWSZbV+I/2T7CmbQO3c=;
        b=Pjl5YdQ9KAnk7U//iuxOLEDqjetRE52G6Ju5NaxkKKrdiQZSUBwzlWUo5zUv8oZ96R
         W3GidXafaYdztANOtuA1eNBxmWqdhzvXEBoFlvpIpv8mFt5tSvcW0MS38XlVmrDFllYo
         KDwflDqO71QbBF95bcpB/H6MVYJdR1a83ZvP6hUSin86YrfLmuQsM3GfF1NR7CcGQiwO
         zzkcEiUDpghQN3qczBF+6oSIZmX7LWrDACqkToopf1X6R0tB+fXSLnpWfI6oj8Tn1yxA
         nSlm22OZp4MQV5IGl35/N8ueyNsbkyb8JXSNj7ZMg1eZi158LIW3jiIoPXZJ4a0wxGsZ
         eNNg==
X-Gm-Message-State: AOJu0Ywbs2hwUXLyNk9HuV6fWgSHNn4aS5b6OM1LMcWxwKIz92a57AZr
        b0X6pViRH9fX2/XYX+P6lGTL2LkzDfm85aHRFy+xhA==
X-Google-Smtp-Source: AGHT+IE37BQNrHHOXPnVONaGS122iVKRfBaukLLMr8k9fspjz2CnEKrk8m8E4xp4kSjCA6kgHCS0EagRTrnC5s7O8K8=
X-Received: by 2002:a17:906:2253:b0:9a1:d077:b74f with SMTP id
 19-20020a170906225300b009a1d077b74fmr11249679ejr.49.1693218821640; Mon, 28
 Aug 2023 03:33:41 -0700 (PDT)
MIME-Version: 1.0
References: <20230824150533.2788317-1-bschubert@ddn.com> <20230824150533.2788317-3-bschubert@ddn.com>
In-Reply-To: <20230824150533.2788317-3-bschubert@ddn.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Mon, 28 Aug 2023 12:33:30 +0200
Message-ID: <CAJfpegvo3X==3cQYSfCb2TyWq8UT1MikdvDZ-gez1yEb+d8JzQ@mail.gmail.com>
Subject: Re: [PATCH 2/5] fuse: Create helper function if DIO write needs
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

On Thu, 24 Aug 2023 at 17:06, Bernd Schubert <bschubert@ddn.com> wrote:
>
> This is just a preparation to avoid code duplication in the next
> commit.
>
> Cc: Hao Xu <howeyxu@tencent.com>
> Cc: Miklos Szeredi <miklos@szeredi.hu>
> Cc: Dharmendra Singh <dsingh@ddn.com>
> Signed-off-by: Bernd Schubert <bschubert@ddn.com>
> ---
>  fs/fuse/file.c | 36 ++++++++++++++++++++++--------------
>  1 file changed, 22 insertions(+), 14 deletions(-)
>
> diff --git a/fs/fuse/file.c b/fs/fuse/file.c
> index b1b9f2b9a37d..a16f9b6888de 100644
> --- a/fs/fuse/file.c
> +++ b/fs/fuse/file.c
> @@ -1298,6 +1298,27 @@ static ssize_t fuse_perform_write(struct kiocb *iocb, struct iov_iter *ii)
>         return res;
>  }
>
> +static bool fuse_direct_write_extending_i_size(struct kiocb *iocb,
> +                                              struct iov_iter *iter)
> +{
> +       struct inode *inode = file_inode(iocb->ki_filp);
> +
> +       return iocb->ki_pos + iov_iter_count(iter) > i_size_read(inode);
> +}

The name suggests that this helper test for write as well as for
direct IO.  It does neither, instead it just checks whether the I/O
reaches past EOF.  So I'd name it e.g. io_past_eof().

> +/*
> + * @return true if an exclusive lock direct IO writes is needed
> + */
> +static bool fuse_dio_wr_exclusive_lock(struct kiocb *iocb, struct iov_iter *from)
> +{
> +       struct file *file = iocb->ki_filp;
> +       struct fuse_file *ff = file->private_data;
> +
> +       return  !(ff->open_flags & FOPEN_PARALLEL_DIRECT_WRITES) ||
> +               iocb->ki_flags & IOCB_APPEND ||
> +               fuse_direct_write_extending_i_size(iocb, from);
> +}
> +

Now that this is a function it's possible to rewrite it as a series of
single-condition ifs.

Thanks,
Miklos
