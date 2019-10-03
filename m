Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 73E56C997A
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Oct 2019 10:04:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728806AbfJCIEe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 3 Oct 2019 04:04:34 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:40677 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728767AbfJCIEe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 3 Oct 2019 04:04:34 -0400
Received: by mail-io1-f68.google.com with SMTP id h144so3394371iof.7
        for <linux-fsdevel@vger.kernel.org>; Thu, 03 Oct 2019 01:04:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RFLlzP5Js98BS8nkgSfEvrEZLCP/SMDrxOQITXNt3eI=;
        b=T+inIGthBvE2//4VZmd63eyRSLLLrR2dZV3XC6Gze72yu+iWc2TuhC9KAwqW1fcGZq
         V4qnPy9VgsX44Sy3xvd4Qo2blktM9gmPmA0CVDmErzDIOibLMHDVtUXsl8nOoesSbJ0/
         artzBJciGJ5N7rJi9zsfVOYKuofa7muPcE6pU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RFLlzP5Js98BS8nkgSfEvrEZLCP/SMDrxOQITXNt3eI=;
        b=UbNWL25qov6ikhgocjEFR4oMZIrkqMOTHiqhyx6OxRxH0Kpn5VEN0jmCAVqlZ/ShNC
         s42gCEbFWXk2ns653DVygvxEhXee5m1Dn2DA1KP75h834tjjeI4MQU63k3KjTl172uB6
         JWlwo2FI7/kXZv+UkxMrIqYjQYW81lEEzNASVK8Ml4++QenB5VPQeKzC01J8NQoaxd5C
         rf1HwNtziprQfbquXwCPQhoEIgiSG3K6XfSHkd73G7VuY7L23bZxFE5x+wwoirVBACcf
         olkTPJcWJZPAJv3ZrU0Mbo+GvH5qrVANE7UxMvK7vivB4Cynsp4GHAYkhvcUM/OfHQmv
         lvPQ==
X-Gm-Message-State: APjAAAWcLSYPn8Z28nMkfwkkigOjkyEszKhBHP5T5egB1Q8gVYCwscq1
        Aw3rOBSFlXwK8CZ+yNXhB44LlfpK9BSVjceJCdhBq8iH
X-Google-Smtp-Source: APXvYqyTGtMe8CACMxLAYuzPIkQ43lyohUju5qo0yntIo1HDn9G2UOfThJbdazHDgBUxaisYEda00vQaldPsOCX9KfA=
X-Received: by 2002:a05:6e02:4d2:: with SMTP id f18mr8908437ils.174.1570089873408;
 Thu, 03 Oct 2019 01:04:33 -0700 (PDT)
MIME-Version: 1.0
References: <CAJfpegv-EQhvJUB0AUhJ=Xx8moHHQvkDGe-yUXHENyWvboBU3A@mail.gmail.com>
 <1b09a159-bcec-63c9-df42-47d99f44d445@virtuozzo.com>
In-Reply-To: <1b09a159-bcec-63c9-df42-47d99f44d445@virtuozzo.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Thu, 3 Oct 2019 10:04:22 +0200
Message-ID: <CAJfpegvcef_rJ5VHdE91LAU2_=XrorsTZu_7JCPsJFo0aGwZmw@mail.gmail.com>
Subject: Re: [PATCH] fuse: BUG_ON correction in fuse_dev_splice_write()
To:     Vasily Averin <vvs@virtuozzo.com>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Andrey Ryabinin <aryabinin@virtuozzo.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Aug 19, 2019 at 8:53 AM Vasily Averin <vvs@virtuozzo.com> wrote:
>
> commit 963545357202 ("fuse: reduce allocation size for splice_write")
> changed size of bufs array, so BUG_ON which checks the index of the array
> shold also be fixed.
>
> Fixes: 963545357202 ("fuse: reduce allocation size for splice_write")
> Signed-off-by: Vasily Averin <vvs@virtuozzo.com>
> ---
>  fs/fuse/dev.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
> index ea8237513dfa..f4ef6e01642c 100644
> --- a/fs/fuse/dev.c
> +++ b/fs/fuse/dev.c
> @@ -2029,7 +2029,7 @@ static ssize_t fuse_dev_splice_write(struct pipe_inode_info *pipe,
>                                      struct file *out, loff_t *ppos,
>                                      size_t len, unsigned int flags)
>  {
> -       unsigned nbuf;
> +       unsigned nbuf, bsize;
>         unsigned idx;
>         struct pipe_buffer *bufs;
>         struct fuse_copy_state cs;
> @@ -2043,7 +2043,8 @@ static ssize_t fuse_dev_splice_write(struct pipe_inode_info *pipe,
>
>         pipe_lock(pipe);
>
> -       bufs = kvmalloc_array(pipe->nrbufs, sizeof(struct pipe_buffer),
> +       bsize = pipe->nrbufs;
> +       bufs = kvmalloc_array(bsize, sizeof(struct pipe_buffer),
>                               GFP_KERNEL);
>         if (!bufs) {
>                 pipe_unlock(pipe);
> @@ -2064,7 +2065,7 @@ static ssize_t fuse_dev_splice_write(struct pipe_inode_info *pipe,
>                 struct pipe_buffer *ibuf;
>                 struct pipe_buffer *obuf;
>
> -               BUG_ON(nbuf >= pipe->buffers);
> +               BUG_ON(nbuf >= bsize);
>                 BUG_ON(!pipe->nrbufs);

Better turn these into WARN_ON's..  Fixed and applied.

Thanks,
Miklos
