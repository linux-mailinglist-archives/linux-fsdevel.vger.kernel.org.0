Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB19450E1EB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Apr 2022 15:34:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237531AbiDYNgR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 25 Apr 2022 09:36:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232664AbiDYNgN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 25 Apr 2022 09:36:13 -0400
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49F56C09
        for <linux-fsdevel@vger.kernel.org>; Mon, 25 Apr 2022 06:33:09 -0700 (PDT)
Received: by mail-il1-x12f.google.com with SMTP id b5so9348186ile.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 25 Apr 2022 06:33:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Gnjzt+1NzH4Eu2LF0ewfanCh28nJVLbVajLnqOyr7so=;
        b=qXgKC+wGX6JUjSmbOLeCpcvFuKT0dg8qOs6PnXS15L5ncoNkRtCqiDgePn75kofNgm
         2tCSFz+93T4dTrz5WENecqA044vqKd79ROI43d4bZZc4lYwpp1E6NtPVnFW/Nr856ujx
         eat6iqRyEdXPWA3l2TbnFnebo8PX4ga3C+QuE80EqcZeEI1lw0U4OhFE2w/O6uododXg
         0rfhGvGLA3PN9blzFmc5i9gJ6FrbEu0nqfBO7cwR94h5AUXuLo4iPSwDjkLR74tBNBdp
         HNPvsRj8bOhtz/3WzQ42aQrJRE5GhZsW+JMGRBDC3ZoVy4CUUMyGjrgHcl6z91GHd5rQ
         32JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Gnjzt+1NzH4Eu2LF0ewfanCh28nJVLbVajLnqOyr7so=;
        b=TSCkmOD4RxKPdj2UMqa/XKeY05aEM1ZsiI/3nJ4CYq/7zdTTTm4+bzxp7lzMhlOOpu
         7v+s/4RDwPBEChYnYXIzrUVD5+Nvrzdk1nME0H51h1BZztsLiteNDuz4OklPwlLSjb/V
         bb4lik2wz1AlwsPz5knsp8XtJSL4tBDGl1E6VlNydAjalkHAIk21Ph1BASGJOngor47j
         cLvnBM3mTEBTfDBGefZmHjHyJLJgHmsq5+owcWo7qgRHj3EANGXgGV5y6hlr1AFpU5LT
         mFylqbIYfQBVTWG4R6soXmJkILbssrXSnLzuw3RuDJbIdEaIreMUm7jtwurO6D4GAAWr
         2JFg==
X-Gm-Message-State: AOAM533bFzfdlJf4ic2Mwr8jrkM3anVYyMWp5jJxNd8arODiVduUbrh/
        udf1uor2zevxUmASxwG8LhgCcZxi+IXQBaQ5GFVmBA==
X-Google-Smtp-Source: ABdhPJwU2Z2Qn+3InewKbrhAehIeUwIOfVw1iC4HFdM8oHuC387OrrzP3I5kpiS4vu2DoaZ4MO/LLBVW0mIyLTs7XjE=
X-Received: by 2002:a05:6e02:f52:b0:2ca:95e4:f4b5 with SMTP id
 y18-20020a056e020f5200b002ca95e4f4b5mr5918655ilj.240.1650893588740; Mon, 25
 Apr 2022 06:33:08 -0700 (PDT)
MIME-Version: 1.0
References: <20220325132126.61949-1-zhangjiachen.jaycee@bytedance.com> <CAJfpeguESQm1KsQLyoMRTevLttV8N8NTGsb2tRbNS1AQ_pNAww@mail.gmail.com>
In-Reply-To: <CAJfpeguESQm1KsQLyoMRTevLttV8N8NTGsb2tRbNS1AQ_pNAww@mail.gmail.com>
From:   Jiachen Zhang <zhangjiachen.jaycee@bytedance.com>
Date:   Mon, 25 Apr 2022 21:32:57 +0800
Message-ID: <CAFQAk7ibzCn8OD84-nfg6_AePsKFTu9m7pXuQwcQP5OBp7ZCag@mail.gmail.com>
Subject: Re: Re: [RFC PATCH] fuse: support cache revalidation in
 writeback_cache mode
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Xie Yongji <xieyongji@bytedance.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Apr 25, 2022 at 8:41 PM Miklos Szeredi <miklos@szeredi.hu> wrote:
>
> On Fri, 25 Mar 2022 at 14:23, Jiachen Zhang
> <zhangjiachen.jaycee@bytedance.com> wrote:
> >
> > Hi all,
> >
> > This RFC patch implements attr cache and data cache revalidation for
> > fuse writeback_cache mode in kernel. Looking forward to any suggestions
> > or comments on this feature.
>
> Quick question before going into the details:  could the cache
> revalidation be done in the userspace filesystem instead, which would
> set/clear FOPEN_KEEP_CACHE based on the result of the revalidation?
>
> Thanks,
> Miklos

Hi, Miklos,

Thanks for replying. Yes, I believe we can also perform the
revalidation in userspace, and we can invalidate the data cache with
FOPEN_KEEP_CACHE cleared. But for now, there is no way we can
invalidate attr cache (c/mtime and size)  in writeback mode.

If it is more concise to implement most of the logic in userspace, do
you think we should add a flag for attr cache just like what
FOPEN_KEEP_CACHE does for data cache?

Thanks,
Jiachen
