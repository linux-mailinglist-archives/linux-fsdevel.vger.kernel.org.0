Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6774978B432
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Aug 2023 17:16:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230074AbjH1PQA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 28 Aug 2023 11:16:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232550AbjH1PPn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 28 Aug 2023 11:15:43 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 002D2191
        for <linux-fsdevel@vger.kernel.org>; Mon, 28 Aug 2023 08:15:35 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-4ffae5bdc9aso5304027e87.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 28 Aug 2023 08:15:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1693235734; x=1693840534;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Mut4lfDDyL1JiIS2J1bKdkP4b9C8GH4gvUWtP5/nuW0=;
        b=hXIv6WCMBaYO0Pb3KzkB5XONvK4qj0SsWV8vso2hvjd8rJkNt+kd0YSP+QEneh59iF
         fSoGcuquNtdFBIYqM2F1FPO6OyaLHIw0co/tZ+0Zd7AL3Fqyel5CLreljoYmd7sPaaUF
         mNCTwdLVCMxcN51KvvCm3KwThct7gw2/7R5+0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693235734; x=1693840534;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Mut4lfDDyL1JiIS2J1bKdkP4b9C8GH4gvUWtP5/nuW0=;
        b=C1kCvhxgYXAgtIK6EUFhLi+jII3wfyExz4vNiwySlgzZoLNVIiizfGCgAgQdjgt5/O
         kIruURRrYMZ6GAIowFzCmqNsKBn+vNySHCUq4+2F9dk2DmwssjmEOJxYj1Al+V7YVZcF
         XjTI7UIzVEaLg+r1gkON4swPutlOayFE43Od56NgD/7HzOUyeI/fLMkogaz6YlkuRQXT
         jfEf/1bUlWlM1/d4Qo3K5czEJfq/ijkNrtqPyyzbddpM3FozmDLIhXFckvN47RYy5k7E
         1xNrBjrEwUPn3hSSs8bE8egzjs3hQmnV9L/6SfPgxntJddrnJXg9aIMvnBphP/qitJh0
         TqHQ==
X-Gm-Message-State: AOJu0YxAdyYb+6sbE1BnEMziBvAl+n2fHmlhftxhbWag8A+PdFSG3hFX
        /NhVchx1qop0qc1Vki4/zA7oZhYZOqbMjx0KPGaZCi1VwUp+Wptx
X-Google-Smtp-Source: AGHT+IFwv/qPq+o7MvSIgXqYU1BqWRQCUm6mh4iQFrqxaz2WKpebE9iRhSWeM4PaJQmwIzBK/8FIdUR6M19dqMZAliE=
X-Received: by 2002:a19:791d:0:b0:4fe:347d:7c4b with SMTP id
 u29-20020a19791d000000b004fe347d7c4bmr16143671lfc.7.1693235734096; Mon, 28
 Aug 2023 08:15:34 -0700 (PDT)
MIME-Version: 1.0
References: <20230824150533.2788317-1-bschubert@ddn.com> <20230824150533.2788317-4-bschubert@ddn.com>
 <CAJfpegveOAgam0Zb+xit9QLfLHpRNyqB=aGRt+JBvhO6g7JYVQ@mail.gmail.com> <daaf4e73-959f-46b7-5e99-e13c70b81d6e@fastmail.fm>
In-Reply-To: <daaf4e73-959f-46b7-5e99-e13c70b81d6e@fastmail.fm>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Mon, 28 Aug 2023 17:15:22 +0200
Message-ID: <CAJfpegvqbJ1jVoJ71EpORRuhfNRvQtGTOUyJiL1qb0mjmkCPwg@mail.gmail.com>
Subject: Re: [PATCH 3/5] fuse: Allow parallel direct writes for O_DIRECT
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

On Mon, 28 Aug 2023 at 16:21, Bernd Schubert <bernd.schubert@fastmail.fm> wrote:
>
>
>
> On 8/28/23 12:42, Miklos Szeredi wrote:
> > On Thu, 24 Aug 2023 at 17:08, Bernd Schubert <bschubert@ddn.com> wrote:
> >>
> >> Take a shared lock in fuse_cache_write_iter.
> >>
> >> Cc: Hao Xu <howeyxu@tencent.com>
> >> Cc: Miklos Szeredi <miklos@szeredi.hu>
> >> Cc: Dharmendra Singh <dsingh@ddn.com>
> >> Cc: linux-fsdevel@vger.kernel.org
> >> Signed-off-by: Bernd Schubert <bschubert@ddn.com>
> >> ---
> >>   fs/fuse/file.c | 21 ++++++++++++++++-----
> >>   1 file changed, 16 insertions(+), 5 deletions(-)
> >>
> >> diff --git a/fs/fuse/file.c b/fs/fuse/file.c
> >> index a16f9b6888de..905ce3bb0047 100644
> >> --- a/fs/fuse/file.c
> >> +++ b/fs/fuse/file.c
> >> @@ -1314,9 +1314,10 @@ static bool fuse_dio_wr_exclusive_lock(struct kiocb *iocb, struct iov_iter *from
> >>          struct file *file = iocb->ki_filp;
> >>          struct fuse_file *ff = file->private_data;
> >>
> >> -       return  !(ff->open_flags & FOPEN_PARALLEL_DIRECT_WRITES) ||
> >> -               iocb->ki_flags & IOCB_APPEND ||
> >> -               fuse_direct_write_extending_i_size(iocb, from);
> >> +       return ((!(iocb->ki_flags & IOCB_DIRECT)) ||
> >> +               (!(ff->open_flags & FOPEN_PARALLEL_DIRECT_WRITES)) ||
> >
> > Why the extra parenthesis around the negation in the above two conditions?
> >
> > So this condition will always be true at this point when called from
> > fuse_cache_write_iter()?  If so, you need to explain in the commit
> > message why are you doing this at this point (e.g. future patches
> > depend on this).
>
> Oh, thanks for spotting, the double parenthesis were accidentally.
> Although I don't think it would have an effect, it just results in
>
> return ((!(condition1)) || ...
>
> I.e. does not change the condition itself?

It doesn't change the condition, but degrades readability.

Thanks,
Miklos
