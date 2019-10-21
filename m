Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 77EEDDE60D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Oct 2019 10:15:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727479AbfJUIPa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Oct 2019 04:15:30 -0400
Received: from mail-il1-f194.google.com ([209.85.166.194]:38184 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726480AbfJUIPa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Oct 2019 04:15:30 -0400
Received: by mail-il1-f194.google.com with SMTP id y5so11175194ilb.5
        for <linux-fsdevel@vger.kernel.org>; Mon, 21 Oct 2019 01:15:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=s/p0brgLtCKJc4XZUqCU1tU91KmMfXp9mypLm9emXKA=;
        b=nScQrbDVZs3W36gCGh5Hde+pfCvRGvVRoUTTl70IBhLlBViXK2JhGRVexWzJbPfLQb
         rpGga7bJQzM5MNF32iUOa1CGDSKpyzv9oOFB0KhM25aYdUgoX4GTq+SU7zEMIRUpqZ6z
         cT9p81E8Fc4+tWeFdHFsd+lkCKZ7swa5jGYCY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=s/p0brgLtCKJc4XZUqCU1tU91KmMfXp9mypLm9emXKA=;
        b=NJJNA5W8/FJmpuo56MT/JsJX5LSux59S/rIq7BfGBXVZx1/05wAROLi0JI3Dz2A6fI
         qo+IBAp/dNuNsGqEkWZdkmGhWBxv8O0IYdr1vdxi+IEjpXFoEw/J9ow+DmsApw+0Y5g6
         OhCJUU0bNi4PwyD+yZ6Qa1Xi5U+yEpobrSutX8AWkx5o2USanFQQ9ZycvFFTGC0nHDNt
         8gBKpWFN5Z3mJUQ5bozZ0uRLPzprN2zty/N+zTXnMxR4nbeVYYb3RiNRDqAWVr7EActW
         sDc8p/jh9ySdORHUCf6T8ZGs9U8XDp7Rae6NaF7oVNM4RnOEJsGAys0WkilEBT0fvBA0
         Lb/Q==
X-Gm-Message-State: APjAAAXM0uqF197fjxWzIrt31oAeQ3MWfuOMn5Q/Fd9B6vWymxiuxl9S
        x7FF0J3rUG7GCYkI+kh2S1G4M9EaI4myZUwksWSzQw==
X-Google-Smtp-Source: APXvYqwm05vycIxwk1hfY5QO63/kCoC4WS+qTkWQDL68oOouqIHs5trhnac+ihR12l7BJ9hG04YbZGT2YyG+rRLzYuc=
X-Received: by 2002:a92:d1d2:: with SMTP id u18mr376710ilg.174.1571645729363;
 Mon, 21 Oct 2019 01:15:29 -0700 (PDT)
MIME-Version: 1.0
References: <20191015174626.11593-1-vgoyal@redhat.com> <20191015174626.11593-6-vgoyal@redhat.com>
In-Reply-To: <20191015174626.11593-6-vgoyal@redhat.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Mon, 21 Oct 2019 10:15:18 +0200
Message-ID: <CAJfpegvg1ePA7=Fm3499bKsZBv_98j817KCDxOU18j=BdVfHyA@mail.gmail.com>
Subject: Re: [PATCH 5/5] virtiofs: Retry request submission from worker context
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org, virtio-fs@redhat.com,
        Stefan Hajnoczi <stefanha@redhat.com>,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
        chirantan@chromium.org, virtualization@lists.linux-foundation.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Oct 15, 2019 at 7:46 PM Vivek Goyal <vgoyal@redhat.com> wrote:
>
> If regular request queue gets full, currently we sleep for a bit and
> retrying submission in submitter's context. This assumes submitter is
> not holding any spin lock. But this assumption is not true for background
> requests. For background requests, we are called with fc->bg_lock held.
>
> This can lead to deadlock where one thread is trying submission with
> fc->bg_lock held while request completion thread has called fuse_request_end()
> which tries to acquire fc->bg_lock and gets blocked. As request completion
> thread gets blocked, it does not make further progress and that means queue
> does not get empty and submitter can't submit more requests.
>
> To solve this issue, retry submission with the help of a worker, instead of
> retrying in submitter's context. We already do this for hiprio/forget
> requests.
>
> Reported-by: Chirantan Ekbote <chirantan@chromium.org>
> Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
> ---
>  fs/fuse/virtio_fs.c | 59 ++++++++++++++++++++++++++++++++++++++-------
>  1 file changed, 50 insertions(+), 9 deletions(-)
>
> diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
> index 625de45fa471..58e568ef54ef 100644
> --- a/fs/fuse/virtio_fs.c
> +++ b/fs/fuse/virtio_fs.c
> @@ -55,6 +55,9 @@ struct virtio_fs_forget {
>         struct list_head list;
>  };
>
> +static int virtio_fs_enqueue_req(struct virtio_fs_vq *fsvq,
> +                                struct fuse_req *req, bool in_flight);
> +
>  static inline struct virtio_fs_vq *vq_to_fsvq(struct virtqueue *vq)
>  {
>         struct virtio_fs *fs = vq->vdev->priv;
> @@ -260,6 +263,7 @@ static void virtio_fs_request_dispatch_work(struct work_struct *work)
>         struct virtio_fs_vq *fsvq = container_of(work, struct virtio_fs_vq,
>                                                  dispatch_work.work);
>         struct fuse_conn *fc = fsvq->fud->fc;
> +       int ret;
>
>         pr_debug("virtio-fs: worker %s called.\n", __func__);
>         while (1) {
> @@ -268,13 +272,43 @@ static void virtio_fs_request_dispatch_work(struct work_struct *work)
>                                                list);
>                 if (!req) {
>                         spin_unlock(&fsvq->lock);
> -                       return;
> +                       break;
>                 }
>
>                 list_del_init(&req->list);
>                 spin_unlock(&fsvq->lock);
>                 fuse_request_end(fc, req);
>         }
> +
> +       /* Dispatch pending requests */
> +       while (1) {
> +               spin_lock(&fsvq->lock);
> +               req = list_first_entry_or_null(&fsvq->queued_reqs,
> +                                              struct fuse_req, list);
> +               if (!req) {
> +                       spin_unlock(&fsvq->lock);
> +                       return;
> +               }
> +               list_del_init(&req->list);
> +               spin_unlock(&fsvq->lock);
> +
> +               ret = virtio_fs_enqueue_req(fsvq, req, true);
> +               if (ret < 0) {
> +                       if (ret == -ENOMEM || ret == -ENOSPC) {
> +                               spin_lock(&fsvq->lock);
> +                               list_add_tail(&req->list, &fsvq->queued_reqs);
> +                               schedule_delayed_work(&fsvq->dispatch_work,
> +                                                     msecs_to_jiffies(1));
> +                               spin_unlock(&fsvq->lock);
> +                               return;
> +                       }
> +                       req->out.h.error = ret;
> +                       dec_in_flight_req(fsvq);

Missing locking.  Fixed.

Thanks,
Miklos
