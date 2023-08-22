Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 677D7783D5F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Aug 2023 11:53:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234518AbjHVJxu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Aug 2023 05:53:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234461AbjHVJxu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Aug 2023 05:53:50 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC4171AD
        for <linux-fsdevel@vger.kernel.org>; Tue, 22 Aug 2023 02:53:46 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-99c353a395cso568210566b.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 22 Aug 2023 02:53:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1692698025; x=1693302825;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ZuTxpNKRETd6la1yRSn4wRav/UuhF/r6prO2tRmYX0k=;
        b=MdHTA02TfH/htz+XYGsk6PK82Rat3nXgHXvPf0Whd7VzeSbEDXQlCouxNwP3vNQq1c
         F4fFmhzGIBQhrwqdQfprmkelVnztr7tEyj9JwZEAzsiqwI9fns7DiHObCr0j69Wzyhow
         oLx6XGIGJXAXGC13pJZZEjw6LX0yRhvXbh8dw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692698025; x=1693302825;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZuTxpNKRETd6la1yRSn4wRav/UuhF/r6prO2tRmYX0k=;
        b=kagnJwd8/Z9vEqu9HVZj3qOCmJJYkdKvUK9Pr4JDZLCRKOnNfn6AN4+dyOlhKvZRkd
         ZX0LB9Xg2znIVzNwsMCwTqgZ81ZRapuoKK6ttHT3FHHXkXPtd8dvIeO4T8LN+0WmHVpx
         oYuGWC7/ceUTu51OpAN0IeJMgvseKhLNMAFhXpR0C0nMC4LCxIQmOwhCC4KPLpR4A+a9
         mSHzWsZgepOGU21SHxfwKodh7ZhI9d2W3ms0G1eVKv9s0fbgSVrUqJj0Z5BlbYTdbHUh
         fm+FVuMRHqYSg6ifTc8Yfvcr9rgjDpDV/CNbllUs3RI24OdtgHWd+R3XcudWvDoPZlcr
         YxDA==
X-Gm-Message-State: AOJu0Yz7YJpUYW+rAcaEfX0iJpdGI8p0OUDerW1gufHuQ1ajjbk7/1Li
        qeXCcZ40dSRMcCvnzjADCSJIoBSpqvXfJZ3LICmwyw==
X-Google-Smtp-Source: AGHT+IGaJHZSeoHzhVEt5QjAYh1OUd/9MglP1YUfEDHTLpuWmvTu9Z81dy2i2ItlzKAlow1sDR6IVa8vYAAo05/1eo0=
X-Received: by 2002:a17:906:105d:b0:992:ab3a:f0d4 with SMTP id
 j29-20020a170906105d00b00992ab3af0d4mr7044354ejj.17.1692698025113; Tue, 22
 Aug 2023 02:53:45 -0700 (PDT)
MIME-Version: 1.0
References: <20230821174753.2736850-1-bschubert@ddn.com> <20230821174753.2736850-2-bschubert@ddn.com>
In-Reply-To: <20230821174753.2736850-2-bschubert@ddn.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Tue, 22 Aug 2023 11:53:33 +0200
Message-ID: <CAJfpegv6Q5O435xSrYUMEQAvvkObV6gWws8Ju7C+PrSKwjmSew@mail.gmail.com>
Subject: Re: [PATCH 1/2] [RFC for fuse-next ] fuse: DIO writes always use the
 same code path
To:     Bernd Schubert <bschubert@ddn.com>
Cc:     linux-fsdevel@vger.kernel.org, bernd.schubert@fastmail.fm,
        fuse-devel@lists.sourceforge.net, Hao Xu <howeyxu@tencent.com>,
        Christoph Hellwig <hch@infradead.org>,
        Dharmendra Singh <dsingh@ddn.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 21 Aug 2023 at 19:48, Bernd Schubert <bschubert@ddn.com> wrote:
>
> There were two code paths direct-io writes could
> take. When daemon/server side did not set FOPEN_DIRECT_IO
>     fuse_cache_write_iter -> direct_write_fallback
> and with FOPEN_DIRECT_IO being set
>     fuse_direct_write_iter
>
> Advantage of fuse_direct_write_iter is that it has optimizations
> for parallel DIO writes - it might only take a shared inode lock,
> instead of the exclusive lock.
>
> With commits b5a2a3a0b776/80e4f25262f9 the fuse_direct_write_iter
> path also handles concurrent page IO (dirty flush and page release),
> just the condition on fc->direct_io_relax had to be removed.
>
> Performance wise this basically gives the same improvements as
> commit 153524053bbb, just O_DIRECT is sufficient, without the need
> that server side sets FOPEN_DIRECT_IO
> (it has to set FOPEN_PARALLEL_DIRECT_WRITES), though.

Consolidating the various direct IO paths would be really nice.

Problem is that fuse_direct_write_iter() lacks some code from
generic_file_direct_write() and also completely lacks
direct_write_fallback().   So more thought needs to go into this.

Thanks,
Miklos
