Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C42F911E0CA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Dec 2019 10:32:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725945AbfLMJcX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 13 Dec 2019 04:32:23 -0500
Received: from mail-il1-f195.google.com ([209.85.166.195]:44580 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725890AbfLMJcX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 13 Dec 2019 04:32:23 -0500
Received: by mail-il1-f195.google.com with SMTP id z12so1501935iln.11
        for <linux-fsdevel@vger.kernel.org>; Fri, 13 Dec 2019 01:32:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0AvYNOmUjKN/K+J3RM99cmU5kMLTjbZGmK2+xRiCOzg=;
        b=YagDYrhYrYXr3l4jNE5K7/WsNmVDTeJfxcSm4lKJK02m+uamqWcyFPqx1/hkY2WVuM
         sDuCXw2jmfYOENTetcw9QMo8dL1gJcvHOuatQNXBCFnImyDu37L2h7ohdL2V3sWxEtNV
         B+tlsigYjEHiaPWEisKxcoV45O4oAmuXS8yEU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0AvYNOmUjKN/K+J3RM99cmU5kMLTjbZGmK2+xRiCOzg=;
        b=tVhWVHN33kTYpJmVWICG8zI2N8e5JpXX5rOWHGwiA1PfCxJkajOXEucRZzxjs0P1qS
         LMtA1YpBXbRNk9Lfbsf0++3dDLlctY5m1QzPgfZjLKflCqFW2V/jhxKYFZeQ7JxMewLu
         C+MB55LYFS4nzbsm30LwBdS0mSSr4s+0u0ezJx1OQwkO8ZCUeZZ54bzxcUpPj+ZzNk6i
         Rj0fHDp1b7NOxAwcA5JKUg3bXSWr3RqfcWW/rizb7KclDcK+OaPsYeW86D8pmVtbuplG
         hTWkTRHWmXXT51nKkX/ItYCvCXEBAkX7hoNtaiiAciKVEip1ky3P922Rkq/cftfndkOT
         yZig==
X-Gm-Message-State: APjAAAW6Bajf+RxzRz+WWJsjCBM3J8bQjHe4Gjpm9SvrcjpQMIg723qy
        J/T3eiSm/LRudGBfvMJylmhdHJ4Ax0xTpUcXUVZOcQ==
X-Google-Smtp-Source: APXvYqz5r6FTCM7lmivj0cg4Vt/roP0xFlvA9sgR88XsGNa7YqItqaDF/MzMdMiiUnUoQev5VbKciP4sJ7pS7oO7x4A=
X-Received: by 2002:a92:8395:: with SMTP id p21mr12047027ilk.285.1576229542313;
 Fri, 13 Dec 2019 01:32:22 -0800 (PST)
MIME-Version: 1.0
References: <20191128155940.17530-1-mszeredi@redhat.com> <20191128155940.17530-2-mszeredi@redhat.com>
In-Reply-To: <20191128155940.17530-2-mszeredi@redhat.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Fri, 13 Dec 2019 10:32:11 +0100
Message-ID: <CAJfpegun6_cX_6udQNrZSPD+Loum8RDTiwh3k6=NgUFbsm=YLw@mail.gmail.com>
Subject: Re: [PATCH 01/12] aio: fix async fsync creds
To:     Miklos Szeredi <mszeredi@redhat.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org,
        Avi Kivity <avi@scylladb.com>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Al,

Could you please review/apply this patch?

Thanks,
Miklos

On Thu, Nov 28, 2019 at 4:59 PM Miklos Szeredi <mszeredi@redhat.com> wrote:
>
> Avi Kivity reports that on fuse filesystems running in a user namespace
> asyncronous fsync fails with EOVERFLOW.
>
> The reason is that f_ops->fsync() is called with the creds of the kthread
> performing aio work instead of the creds of the process originally
> submitting IOCB_CMD_FSYNC.
>
> Fuse sends the creds of the caller in the request header and it needs to
> translate the uid and gid into the server's user namespace.  Since the
> kthread is running in init_user_ns, the translation will fail and the
> operation returns an error.
>
> It can be argued that fsync doesn't actually need any creds, but just
> zeroing out those fields in the header (as with requests that currently
> don't take creds) is a backward compatibility risk.
>
> Instead of working around this issue in fuse, solve the core of the problem
> by calling the filesystem with the proper creds.
>
> Reported-by: Avi Kivity <avi@scylladb.com>
> Tested-by: Giuseppe Scrivano <gscrivan@redhat.com>
> Fixes: c9582eb0ff7d ("fuse: Fail all requests with invalid uids or gids")
> Cc: stable@vger.kernel.org  # 4.18+
> Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
> ---
>  fs/aio.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/fs/aio.c b/fs/aio.c
> index 0d9a559d488c..37828773e2fe 100644
> --- a/fs/aio.c
> +++ b/fs/aio.c
> @@ -176,6 +176,7 @@ struct fsync_iocb {
>         struct file             *file;
>         struct work_struct      work;
>         bool                    datasync;
> +       struct cred             *creds;
>  };
>
>  struct poll_iocb {
> @@ -1589,8 +1590,11 @@ static int aio_write(struct kiocb *req, const struct iocb *iocb,
>  static void aio_fsync_work(struct work_struct *work)
>  {
>         struct aio_kiocb *iocb = container_of(work, struct aio_kiocb, fsync.work);
> +       const struct cred *old_cred = override_creds(iocb->fsync.creds);
>
>         iocb->ki_res.res = vfs_fsync(iocb->fsync.file, iocb->fsync.datasync);
> +       revert_creds(old_cred);
> +       put_cred(iocb->fsync.creds);
>         iocb_put(iocb);
>  }
>
> @@ -1604,6 +1608,10 @@ static int aio_fsync(struct fsync_iocb *req, const struct iocb *iocb,
>         if (unlikely(!req->file->f_op->fsync))
>                 return -EINVAL;
>
> +       req->creds = prepare_creds();
> +       if (!req->creds)
> +               return -ENOMEM;
> +
>         req->datasync = datasync;
>         INIT_WORK(&req->work, aio_fsync_work);
>         schedule_work(&req->work);
> --
> 2.21.0
>
