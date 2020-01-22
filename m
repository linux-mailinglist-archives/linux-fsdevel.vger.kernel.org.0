Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8296A1459A4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Jan 2020 17:21:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725911AbgAVQVB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 Jan 2020 11:21:01 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:37837 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725836AbgAVQVB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 Jan 2020 11:21:01 -0500
Received: by mail-ot1-f65.google.com with SMTP id k14so6780852otn.4
        for <linux-fsdevel@vger.kernel.org>; Wed, 22 Jan 2020 08:21:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dmI3giScWK0hAcx6XhcuOxJcaxJiTzzztsj6uMOL9UM=;
        b=r78Pgsde9wT9/51gi5zsXtJIYKfaLG9jufzRwXm1JuHe4KJgL+u0UR7RTQCHMD6weo
         ckJouuVwiECPkSwCn1++YpVXaStNTojs1TKydpxSTRvgAqZuS51/O40sh9C8GAEdmjnG
         rvuUtivJ1H/vzyOiPYvY5fMErPoAaI4ZtFtCme7CnmpZrWmrGnntdXEYV1au/GNeeyFD
         jFTKMm5yftmUp6EhdWC9oUh6jx1AMH/stcRVDjB5EmPie/tCTTsAfAeSyhEZsQhnMoe6
         XS8xWU+wQBCNyVRij12u/jxWBIB10tQGc2dpjZ8bpaDJV30hJWI5GJk34aXmd3VGhZCk
         2gXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dmI3giScWK0hAcx6XhcuOxJcaxJiTzzztsj6uMOL9UM=;
        b=LCy2NpA2BCIFDIYKPEVs11atj9SiXi65pl0inMF3g1MOmrnw9J6tKa7V05ejDIFF9d
         h00ojY1YkvmU0wEG2w+OBJLoqBHT7y3ivfERtsev4CjHisToNRHTSs2R1zSJt0SapHXE
         ci02ZE6KPN4ixn5ZZhD9XodxXnpAPAMJh0pF5Z36ldgaU5khJGd/iNgaxlMNP6K+XHI9
         kkKTV0sIv3uaWZTfhz/k9lHNY/skeI/uIxxT5BDv7gxNNGHPqDhXbeGelqEYeBPaVt9M
         3Mg+N5tX83bdCLvc7QBGQa21IpdTFjeAkaS8YX8nJvtRotGdwXcgGlCadimc7JWC6/yq
         vQ2w==
X-Gm-Message-State: APjAAAVBYuPgVYFXMj3Hihamo2aPkAISafZmfOQMW+bg0QiVPpL47rgz
        QTAwMgOg8T+i+n48EkQrPDx072SGJp+gecL1m61u6jV25q8=
X-Google-Smtp-Source: APXvYqyO0iaPZQF/ygonA8LD39Ae2U+2cHHBZaw9cR5/uRsGCUyqUhghuPYgGd875B7ngRFetX2h8wuVdOerOPRAWds=
X-Received: by 2002:a05:6830:44e:: with SMTP id d14mr7597274otc.228.1579710060193;
 Wed, 22 Jan 2020 08:21:00 -0800 (PST)
MIME-Version: 1.0
References: <20200122160231.11876-1-axboe@kernel.dk> <20200122160231.11876-3-axboe@kernel.dk>
In-Reply-To: <20200122160231.11876-3-axboe@kernel.dk>
From:   Jann Horn <jannh@google.com>
Date:   Wed, 22 Jan 2020 17:20:33 +0100
Message-ID: <CAG48ez0+wiY4i0nFFXpKvqpQDNYQvzHAJhAMVD0rv5cpEicWkw@mail.gmail.com>
Subject: Re: [PATCH 2/3] eventpoll: support non-blocking do_epoll_ctl() calls
To:     Jens Axboe <axboe@kernel.dk>
Cc:     io-uring <io-uring@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jan 22, 2020 at 5:02 PM Jens Axboe <axboe@kernel.dk> wrote:
> Also make it available outside of epoll, along with the helper that
> decides if we need to copy the passed in epoll_event.
[...]
> diff --git a/fs/eventpoll.c b/fs/eventpoll.c
> index cd848e8d08e2..162af749ea50 100644
> --- a/fs/eventpoll.c
> +++ b/fs/eventpoll.c
[...]
> -static int do_epoll_ctl(int epfd, int op, int fd, struct epoll_event *epds)
> +static inline int epoll_mutex_lock(struct mutex *mutex, int depth,
> +                                  bool nonblock)
> +{
> +       if (!nonblock) {
> +               mutex_lock_nested(mutex, depth);
> +               return 0;
> +       }
> +       if (!mutex_trylock(mutex))
> +               return 0;
> +       return -EAGAIN;

The documentation for mutex_trylock() says:

 * Try to acquire the mutex atomically. Returns 1 if the mutex
 * has been acquired successfully, and 0 on contention.

So in the success case, this evaluates to:

    if (!1)
      return 0;
    return -EAGAIN;

which is

    if (0)
      return 0;
    return -EAGAIN;

which is

    return -EAGAIN;

I think you'll have to get rid of the negation.

> +}
> +
> +int do_epoll_ctl(int epfd, int op, int fd, struct epoll_event *epds,
> +                bool nonblock)
>  {
>         int error;
>         int full_check = 0;
> @@ -2145,13 +2152,17 @@ static int do_epoll_ctl(int epfd, int op, int fd, struct epoll_event *epds)
>          * deep wakeup paths from forming in parallel through multiple
>          * EPOLL_CTL_ADD operations.
>          */
> -       mutex_lock_nested(&ep->mtx, 0);
> +       error = epoll_mutex_lock(&ep->mtx, 0, nonblock);
> +       if (error)
> +               goto error_tgt_fput;
>         if (op == EPOLL_CTL_ADD) {
>                 if (!list_empty(&f.file->f_ep_links) ||
>                                                 is_file_epoll(tf.file)) {
>                         full_check = 1;
>                         mutex_unlock(&ep->mtx);
> -                       mutex_lock(&epmutex);
> +                       error = epoll_mutex_lock(&epmutex, 0, nonblock);
> +                       if (error)
> +                               goto error_tgt_fput;

When we reach the "goto", full_check==1 and epmutex is not held. But
at the jump target, this code runs:

error_tgt_fput:
  if (full_check) // true
    mutex_unlock(&epmutex);

So I think we're releasing a lock that we don't hold.

>                         if (is_file_epoll(tf.file)) {
>                                 error = -ELOOP;
>                                 if (ep_loop_check(ep, tf.file) != 0) {
> @@ -2161,10 +2172,17 @@ static int do_epoll_ctl(int epfd, int op, int fd, struct epoll_event *epds)
>                         } else
>                                 list_add(&tf.file->f_tfile_llink,
>                                                         &tfile_check_list);
> -                       mutex_lock_nested(&ep->mtx, 0);
> +                       error = epoll_mutex_lock(&ep->mtx, 0, nonblock);
> +                       if (error) {
> +out_del:
> +                               list_del(&tf.file->f_tfile_llink);
> +                               goto error_tgt_fput;
> +                       }
>                         if (is_file_epoll(tf.file)) {
>                                 tep = tf.file->private_data;
> -                               mutex_lock_nested(&tep->mtx, 1);
> +                               error = epoll_mutex_lock(&tep->mtx, 1, nonblock);
> +                               if (error)
> +                                       goto out_del;

When we reach this "goto", ep->mtx is held and never dropped.

>                         }
>                 }
>         }
> @@ -2233,7 +2251,7 @@ SYSCALL_DEFINE4(epoll_ctl, int, epfd, int, op, int, fd,
>             copy_from_user(&epds, event, sizeof(struct epoll_event)))
>                 return -EFAULT;
>
> -       return do_epoll_ctl(epfd, op, fd, &epds);
> +       return do_epoll_ctl(epfd, op, fd, &epds, false);
>  }
