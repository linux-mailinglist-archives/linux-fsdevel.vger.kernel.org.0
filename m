Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A59778ACCE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Aug 2023 12:43:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232018AbjH1Kmh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 28 Aug 2023 06:42:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231866AbjH1KmR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 28 Aug 2023 06:42:17 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF41312D
        for <linux-fsdevel@vger.kernel.org>; Mon, 28 Aug 2023 03:42:13 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-52889bc61b6so4197991a12.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 28 Aug 2023 03:42:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1693219332; x=1693824132;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=TEiIl2q/mAXEAg7LokmrWsxbswvKwcTP+hCWc0dcqlQ=;
        b=dDil6g0wecI4ddNK/0+WITpAK1unUwtyQ4gd+RVl/cJflN0BWg7pc9qvXo8t4R+s/o
         SgmphAY8HJtmtKbFsv7+WNsSHYmNX6Qg1sfA4gdOXI0cUkmckZILq9YNMipsfSgo7OxO
         E2Qf3w2i8XQAKN+aqh84/N7VG9UdlEdiqwppE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693219332; x=1693824132;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TEiIl2q/mAXEAg7LokmrWsxbswvKwcTP+hCWc0dcqlQ=;
        b=iJIv9XxWutBjBXQBwjBLGtOXDSqCKZUCu7+VH7a80V8iYtMS3pvmqeqvmTJ2sS7x7s
         sTednQdJZH1v9RFsoWQCM2EE6VxGTDiMxkW53GAVW+LU8MBtmjZ+sIsOlMx2D3mvZUDi
         55zHSDOQ9VZik3847RtEcu5GbHOTFJwruNN4lORtOs9406gxuVpWsfvSSqOFRXjnna+h
         GuCPAwGeBTm+gdR2UGRz9LuFsq738SlXAag1+dVxdrGl3ibjyTXqPL67/lP+WnJvrG7j
         khVP2KgKtWdrrhee+PeDxwdXcoYNoeMMu+C4+XZ/d4wf7cBriKWwsKA1TV3E8rv7+k9Y
         zBfA==
X-Gm-Message-State: AOJu0YzikZw7qzbLvd0k2+ZSsvM9BiVvG7zrFySx3KO263KvPFEgOowR
        wqrfTklMs6pPOReWYzw2Xd7BE71rHDokzLlKrKiP//Hg0qPfTrheTAc=
X-Google-Smtp-Source: AGHT+IHTzmpgxFwaSRUOrMOtm/N9LQxnpGoPqj+fJ89NnsUesyJGNYkAPTURMRecKAclt3oeVr1bz/bKCeCN99lBX0E=
X-Received: by 2002:a17:906:150:b0:9a1:d7cd:602d with SMTP id
 16-20020a170906015000b009a1d7cd602dmr11265049ejh.45.1693219332336; Mon, 28
 Aug 2023 03:42:12 -0700 (PDT)
MIME-Version: 1.0
References: <20230824150533.2788317-1-bschubert@ddn.com> <20230824150533.2788317-4-bschubert@ddn.com>
In-Reply-To: <20230824150533.2788317-4-bschubert@ddn.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Mon, 28 Aug 2023 12:42:01 +0200
Message-ID: <CAJfpegveOAgam0Zb+xit9QLfLHpRNyqB=aGRt+JBvhO6g7JYVQ@mail.gmail.com>
Subject: Re: [PATCH 3/5] fuse: Allow parallel direct writes for O_DIRECT
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

On Thu, 24 Aug 2023 at 17:08, Bernd Schubert <bschubert@ddn.com> wrote:
>
> Take a shared lock in fuse_cache_write_iter.
>
> Cc: Hao Xu <howeyxu@tencent.com>
> Cc: Miklos Szeredi <miklos@szeredi.hu>
> Cc: Dharmendra Singh <dsingh@ddn.com>
> Cc: linux-fsdevel@vger.kernel.org
> Signed-off-by: Bernd Schubert <bschubert@ddn.com>
> ---
>  fs/fuse/file.c | 21 ++++++++++++++++-----
>  1 file changed, 16 insertions(+), 5 deletions(-)
>
> diff --git a/fs/fuse/file.c b/fs/fuse/file.c
> index a16f9b6888de..905ce3bb0047 100644
> --- a/fs/fuse/file.c
> +++ b/fs/fuse/file.c
> @@ -1314,9 +1314,10 @@ static bool fuse_dio_wr_exclusive_lock(struct kiocb *iocb, struct iov_iter *from
>         struct file *file = iocb->ki_filp;
>         struct fuse_file *ff = file->private_data;
>
> -       return  !(ff->open_flags & FOPEN_PARALLEL_DIRECT_WRITES) ||
> -               iocb->ki_flags & IOCB_APPEND ||
> -               fuse_direct_write_extending_i_size(iocb, from);
> +       return ((!(iocb->ki_flags & IOCB_DIRECT)) ||
> +               (!(ff->open_flags & FOPEN_PARALLEL_DIRECT_WRITES)) ||

Why the extra parenthesis around the negation in the above two conditions?

So this condition will always be true at this point when called from
fuse_cache_write_iter()?  If so, you need to explain in the commit
message why are you doing this at this point (e.g. future patches
depend on this).


Thanks,
Miklos
