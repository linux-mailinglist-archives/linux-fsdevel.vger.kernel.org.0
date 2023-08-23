Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 526BD785062
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Aug 2023 08:10:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232833AbjHWGK2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Aug 2023 02:10:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbjHWGK2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Aug 2023 02:10:28 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CBD3FB
        for <linux-fsdevel@vger.kernel.org>; Tue, 22 Aug 2023 23:10:24 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-99bcfe28909so659775766b.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 22 Aug 2023 23:10:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1692771023; x=1693375823;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=xfx1JUWpPvILwYwPTDCGXS6A1qeCEsVXWzUHlQoelpI=;
        b=qcrdSbEalRu0Kw0bNJ08trqurudA6POx+a9uqflZpeYBD5LexRFc1KRrgj4a6u19mP
         wKx4MmH9Jp4NgQeOWfiw68/o4/dwTWAdnMz3IUO87739hoMLWm7o46S2zpcMI7QRNpiP
         FkZqR7qZO3T81XKsqOaWA1rV2Gll4ybfe/sbA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692771023; x=1693375823;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xfx1JUWpPvILwYwPTDCGXS6A1qeCEsVXWzUHlQoelpI=;
        b=QlT82CFYORQMDTqLLiBBHRpDPDjlIc3h5nSIZzJM5yQYH8dHS1u0+CjkuHKGHNQo6g
         oKHWer4lzmjB+AGlRwLU1sDbDxD4pmkCC5jOZBLFFFpLUqaY9YjSZe2VXDosZelJoSWm
         Oj+N9U+qh4+DONVz++3jDWel7PmZSkBQcH1bvcu+UgEPjFlU6GAuPP/c27SGaRuOcnM0
         grOkQuhS5zPo7b4ON1t/fxXkZrGbNFizeC5hGPwIsNvPPOMFX5beE4iCVktBGKUUE/lN
         BZeirXiSgyt92xayD3Ig+JLv0j6bqKVxZJGZU4SL8e1M6hwva2z0xUugHt9JD56doOA7
         oOHw==
X-Gm-Message-State: AOJu0YxSSVJceB/Xw2AA+bc8yTnDeVcOr+xp5Ad0/pIh+FlvWK/5FkOD
        iPxRNrINzZJjM/YqsDvSFScUdJJWvSCX6MMkPyT0G3rKIy5ns6G//0A=
X-Google-Smtp-Source: AGHT+IGnmjRUGAMw3KzctMOVaEqTd9V/V5o6vjZe6Ak1NZFtABsnFJMMc3qwHROtI/LdzgKD+RBCBmbBHzOlcFMAgVs=
X-Received: by 2002:a17:906:3147:b0:9a1:de81:ff7a with SMTP id
 e7-20020a170906314700b009a1de81ff7amr522037eje.30.1692771022787; Tue, 22 Aug
 2023 23:10:22 -0700 (PDT)
MIME-Version: 1.0
References: <20230821174753.2736850-1-bschubert@ddn.com> <20230821174753.2736850-2-bschubert@ddn.com>
 <CAJfpegv6Q5O435xSrYUMEQAvvkObV6gWws8Ju7C+PrSKwjmSew@mail.gmail.com> <1d58149e-d21f-e809-6ddc-25045268a0e0@fastmail.fm>
In-Reply-To: <1d58149e-d21f-e809-6ddc-25045268a0e0@fastmail.fm>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Wed, 23 Aug 2023 08:10:11 +0200
Message-ID: <CAJfpegt5RgZtXy5zKFfCAhmWmU=-09_VqHAoqigdtWJ1KS4TbQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] [RFC for fuse-next ] fuse: DIO writes always use the
 same code path
To:     Bernd Schubert <bernd.schubert@fastmail.fm>
Cc:     Bernd Schubert <bschubert@ddn.com>, linux-fsdevel@vger.kernel.org,
        fuse-devel@lists.sourceforge.net, Hao Xu <howeyxu@tencent.com>,
        Christoph Hellwig <hch@infradead.org>,
        Dharmendra Singh <dsingh@ddn.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 22 Aug 2023 at 20:47, Bernd Schubert <bernd.schubert@fastmail.fm> wrote:
>
>
>
> On 8/22/23 11:53, Miklos Szeredi wrote:
> > On Mon, 21 Aug 2023 at 19:48, Bernd Schubert <bschubert@ddn.com> wrote:
> >>
> >> There were two code paths direct-io writes could
> >> take. When daemon/server side did not set FOPEN_DIRECT_IO
> >>      fuse_cache_write_iter -> direct_write_fallback
> >> and with FOPEN_DIRECT_IO being set
> >>      fuse_direct_write_iter
> >>
> >> Advantage of fuse_direct_write_iter is that it has optimizations
> >> for parallel DIO writes - it might only take a shared inode lock,
> >> instead of the exclusive lock.
> >>
> >> With commits b5a2a3a0b776/80e4f25262f9 the fuse_direct_write_iter
> >> path also handles concurrent page IO (dirty flush and page release),
> >> just the condition on fc->direct_io_relax had to be removed.
> >>
> >> Performance wise this basically gives the same improvements as
> >> commit 153524053bbb, just O_DIRECT is sufficient, without the need
> >> that server side sets FOPEN_DIRECT_IO
> >> (it has to set FOPEN_PARALLEL_DIRECT_WRITES), though.
> >
> > Consolidating the various direct IO paths would be really nice.
> >
> > Problem is that fuse_direct_write_iter() lacks some code from
> > generic_file_direct_write() and also completely lacks
> > direct_write_fallback().   So more thought needs to go into this.
>
> Thanks for looking at it! Hmm, right, I see. I guess at least
> direct_write_fallback() should be done for the new relaxed
> mmap mode.
>
> Entirely duplicating generic_file_direct_write()
> to generic_file_direct_write doesn't seem to be nice either.
>
> Regarding the inode lock, it might be easier to
> change fuse_cache_write_iter() to a shared lock, although that
> does not help when fc->writeback_cache is enabled, which has yet
> another code path. Although I'm not sure that is needed
> direct IO. For the start, what do you think about
>
> diff --git a/fs/fuse/file.c b/fs/fuse/file.c
> index 1cdb6327511e..b1b9f2b9a37d 100644
> --- a/fs/fuse/file.c
> +++ b/fs/fuse/file.c
> @@ -1307,7 +1307,7 @@ static ssize_t fuse_cache_write_iter(struct kiocb *iocb, struct iov_iter *from)
>          ssize_t err;
>          struct fuse_conn *fc = get_fuse_conn(inode);
>
> -       if (fc->writeback_cache) {
> +       if (fc->writeback_cache && !(iocb->ki_flags & IOCB_DIRECT)) {

This makes sense.  No point in doing cached write + sync when we can
do write-through.  The fallback thing makes sense only in the case
when the page invalidation fails.  Otherwise the fallback code should
not even be invoked, I think.

Thanks,
Miklos
