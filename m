Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE14878B3FC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Aug 2023 17:06:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231752AbjH1PGU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 28 Aug 2023 11:06:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232171AbjH1PF6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 28 Aug 2023 11:05:58 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 334DA110
        for <linux-fsdevel@vger.kernel.org>; Mon, 28 Aug 2023 08:05:56 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-9936b3d0286so447475266b.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 28 Aug 2023 08:05:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1693235154; x=1693839954;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=jmoSoVpBADpIaZRWWHZQMb+9VN4TpNK/5XwpUmx0hx4=;
        b=Vi67lKr663fUs9ZYVPhzlUK490PA7EMagV5AZO68IS7nEvqZqV2K/Yb+ItQaEdjJsu
         RtWMFHaqs9Vs5a/oWJrpdZ7syxd2cvsZVw0blgRBpO/GylU3ZkV0BNNZMgKQWWrkLL/S
         gAa+xWn26deFiEBRYuBOcR0j/MzCos5EpZrZA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693235154; x=1693839954;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jmoSoVpBADpIaZRWWHZQMb+9VN4TpNK/5XwpUmx0hx4=;
        b=MtU+DsuK9zZdam2+uJQCyDvKRI3qBj8Y7nslQ5ruqRNOfh6b4vJmBzO4wJR2QPQHe+
         hsuAVaucV5WrmfHzfGWAt5vucNzNzrSyV0fcC3GGnFL4T3t0+w5KRVeUOa0XStYNWno1
         ArNdwyAA6Ly5XXsSQ+YO2gxqkMtoNIvFGH78GQ6lh+gYWplTR2NGyk4Ecmc/WBSUTjLI
         XQYNFm963ei2tb97JieroPd0LxFajWRQySg81XYapKVVt9rJeYkBA2X+hVaBlwlAm+X3
         4Fp22Pi8DglNkjb5dNmlHBSzKSqOiDIbbAqYDuOkInMEMSGSIVGVZJq1T/9sXV/lu6Cs
         gtZw==
X-Gm-Message-State: AOJu0YwCiPA5FqLUvNu3esPXWklMpNpdIKkpxIilJUj5ZRTDsY2v741i
        yQmhUnafJyrAnFGL6REEpUXImRPDg2370g0z2Ettxw==
X-Google-Smtp-Source: AGHT+IED30V678O3F8CnKq2g8p9nFCqSqvFXWlVUwqKNKFCMmyWd6shPpkyslKYNgSeTL6dYlzEsIkPt4MnLSQKU+9g=
X-Received: by 2002:a17:907:2718:b0:99c:55ac:3a61 with SMTP id
 w24-20020a170907271800b0099c55ac3a61mr18017446ejk.56.1693235154716; Mon, 28
 Aug 2023 08:05:54 -0700 (PDT)
MIME-Version: 1.0
References: <20230824150533.2788317-1-bschubert@ddn.com> <20230824150533.2788317-5-bschubert@ddn.com>
 <CAJfpegvW=9TCB+-CX0jPBA5KDufSj0hKzU3YfEYojWdHHh57eQ@mail.gmail.com> <d2a7e7a3-6273-475c-8e7c-96de547a5d71@fastmail.fm>
In-Reply-To: <d2a7e7a3-6273-475c-8e7c-96de547a5d71@fastmail.fm>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Mon, 28 Aug 2023 17:05:43 +0200
Message-ID: <CAJfpegu9MDSB-pCmZr_mz64Cc1r-q8TkNmR7BH6TO3SCq2HAVA@mail.gmail.com>
Subject: Re: [PATCH 4/5] [RFC] fuse: Set and use IOCB_DIRECT when
 FOPEN_DIRECT_IO is set
To:     Bernd Schubert <bernd.schubert@fastmail.fm>
Cc:     Bernd Schubert <bschubert@ddn.com>, linux-fsdevel@vger.kernel.org,
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

On Mon, 28 Aug 2023 at 16:48, Bernd Schubert <bernd.schubert@fastmail.fm> wrote:
>
> On 8/28/23 13:59, Miklos Szeredi wrote:
> > On Thu, 24 Aug 2023 at 17:07, Bernd Schubert <bschubert@ddn.com> wrote:

> >> -               if (!is_sync_kiocb(iocb) && iocb->ki_flags & IOCB_DIRECT) {
> >> -                       res = fuse_direct_IO(iocb, from);
> >> -               } else {
> >> -                       res = fuse_direct_io(&io, from, &iocb->ki_pos,
> >> -                                            FUSE_DIO_WRITE);
> >> -                       fuse_write_update_attr(inode, iocb->ki_pos, res);
> >
> > While I think this is correct, I'd really like if the code to be
> > replaced and the replacement are at least somewhat comparable.
>
> Sorry, I have a hard to time to understand "I'd really like if the code
> to be replaced".

What I meant is that generic_file_direct_write() is not an obvious
replacement for the  above lines of code.

The reason is that fuse_direct_IO() is handling the sync and async
cases in one function, while the above splits handling it based on
IOCB_DIRECT (which is now lost) and is_sync_kiocb(iocb).  If it's okay
to lose IOCB_DIRECT then what's the explanation for the above
condition?  It could be historic garbage, but we still need to
understand what is exactly happening.

Thanks,
Miklos
