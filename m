Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F278E78DB0D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Aug 2023 20:39:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234075AbjH3Si0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 30 Aug 2023 14:38:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244017AbjH3MOz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 30 Aug 2023 08:14:55 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7673A1B0
        for <linux-fsdevel@vger.kernel.org>; Wed, 30 Aug 2023 05:14:52 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-99c1c66876aso711530866b.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 30 Aug 2023 05:14:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1693397691; x=1694002491; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6pxLXz9WpKF5WM7fCSR8+13AwuJ8TPRJvpKPYiMiK4E=;
        b=XNI7NnV6+P46/0WIDEkdNfuxqyuwN/E46chrS6Ripw84sx4YCjydHo6eEosRyMoPH2
         f8Zyqi8zxMFIjpxe7gBlm64OW5x98sA1nLvUPEhqaqoj2FHeZm1sKyB8HYhFh+XTzeQo
         Bnr2202Bhz2Fo9iV+25OI38TcAp4e7cz/1ulA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693397691; x=1694002491;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6pxLXz9WpKF5WM7fCSR8+13AwuJ8TPRJvpKPYiMiK4E=;
        b=Zpv+9ipPFzflkgRb7AtFZnQq53MRC6nkXFXVzdbtJCOcJ1k6uhDUXBMPZ77vr5dA5i
         1CGZuRFtYLf/AsgO8KM6OeAZ62G8n9TmvKMdTuSk1yj5wQin/iXaC5VWVE+f56M0MJa/
         fzBr1NiWedw02Puuc3KTLJ5ohRCBn4TYGLxIhUkKzuKjkYq8mhx6HeDAShbYuSItRAK9
         vxfNHJaTYxsfuvVXW8M7ErjhdGBl4egO+RnbwIYTm+nfPsIhgGVdfLWCv6jWjipf57uU
         3o1cywavY/YhlwZuU7Cs9TuOUotl5++2G3XdH2220yniyByiq6UpIMVP08Hhhq9WZVJ+
         lUbQ==
X-Gm-Message-State: AOJu0Yw47gWfPOQl9Tz0N08GxZvjG1RB7NaGO1cwO4510wfzDLqzNDBN
        /mCw0gt+cXYxjJsYMhR0RlQFrlmkO/PIk4B2BpTpww==
X-Google-Smtp-Source: AGHT+IG3LXg05B7s81pCeSXgIKCINtHhHADnrYstPy1HktWtg3BYi2ln4ollIV8SLp2A9yoFUNXWktGXCoqNA63Dr8U=
X-Received: by 2002:a17:906:518e:b0:9a1:ab86:5f27 with SMTP id
 y14-20020a170906518e00b009a1ab865f27mr1420645ejk.45.1693397690826; Wed, 30
 Aug 2023 05:14:50 -0700 (PDT)
MIME-Version: 1.0
References: <20230829161116.2914040-1-bschubert@ddn.com> <20230829161116.2914040-3-bschubert@ddn.com>
 <CAJfpegvnxrmU=GgxGxZCh4oyhBk3HrPeWGLqwR7quJ2RPv5JjQ@mail.gmail.com> <efade42b-2c32-2f22-07a4-7541b60d3c32@fastmail.fm>
In-Reply-To: <efade42b-2c32-2f22-07a4-7541b60d3c32@fastmail.fm>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Wed, 30 Aug 2023 14:14:39 +0200
Message-ID: <CAJfpegvm=6Onn5ezgfctknmjh3VRsAajguAWoRGEXVN3upT4sA@mail.gmail.com>
Subject: Re: [PATCH 2/6] fuse: Create helper function if DIO write needs
 exclusive lock
To:     Bernd Schubert <aakef@fastmail.fm>
Cc:     Bernd Schubert <bschubert@ddn.com>, linux-fsdevel@vger.kernel.org,
        bernd.schubert@fastmail.fm, dsingh@ddn.com,
        Hao Xu <howeyxu@tencent.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 30 Aug 2023 at 14:13, Bernd Schubert <aakef@fastmail.fm> wrote:
>
>
>
> On 8/30/23 12:57, Miklos Szeredi wrote:
> > On Tue, 29 Aug 2023 at 18:11, Bernd Schubert <bschubert@ddn.com> wrote:
> >>
> >> This is just a preparation to avoid code duplication in the next
> >> commit.
> >>
> >> Cc: Hao Xu <howeyxu@tencent.com>
> >> Cc: Miklos Szeredi <miklos@szeredi.hu>
> >> Cc: Dharmendra Singh <dsingh@ddn.com>
> >> Signed-off-by: Bernd Schubert <bschubert@ddn.com>
> >> ---
> >>   fs/fuse/file.c | 48 +++++++++++++++++++++++++++++++++---------------
> >>   1 file changed, 33 insertions(+), 15 deletions(-)
> >>
> >> diff --git a/fs/fuse/file.c b/fs/fuse/file.c
> >> index b1b9f2b9a37d..6b8b9512c336 100644
> >> --- a/fs/fuse/file.c
> >> +++ b/fs/fuse/file.c
> >> @@ -1298,6 +1298,37 @@ static ssize_t fuse_perform_write(struct kiocb *iocb, struct iov_iter *ii)
> >>          return res;
> >>   }
> >>
> >> +static bool fuse_io_past_eof(struct kiocb *iocb,
> >> +                                              struct iov_iter *iter)
> >> +{
> >> +       struct inode *inode = file_inode(iocb->ki_filp);
> >> +
> >> +       return iocb->ki_pos + iov_iter_count(iter) > i_size_read(inode);
> >> +}
> >> +
> >> +/*
> >> + * @return true if an exclusive lock direct IO writes is needed
> >> + */
> >> +static bool fuse_dio_wr_exclusive_lock(struct kiocb *iocb, struct iov_iter *from)
> >> +{
> >> +       struct file *file = iocb->ki_filp;
> >> +       struct fuse_file *ff = file->private_data;
> >> +
> >> +       /* server side has to advise that it supports parallel dio writes */
> >> +       if (!(ff->open_flags & FOPEN_PARALLEL_DIRECT_WRITES))
> >> +               return false;
> >
> > You got the return values the wrong way around.  I can fix this, no
> > need to resend.
>
> Ooops, sorry! Do you mind to take this series for next merge round? I
> obviously didn't test the latest series yet and I would like to first
> test performance and do several rounds of xfs tests. That should be done
> by Monday, but might be a bit late for 6.6

Right, this should aim for 6.7.

Thanks,
Miklos
