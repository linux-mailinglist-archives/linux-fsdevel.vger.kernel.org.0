Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5D7ECDE5E3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Oct 2019 10:03:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727555AbfJUIDx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Oct 2019 04:03:53 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:33918 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725972AbfJUIDx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Oct 2019 04:03:53 -0400
Received: by mail-io1-f67.google.com with SMTP id q1so14829103ion.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 21 Oct 2019 01:03:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hfAvAuNrbwm7BBpI2yh2o5/hOFM6ooN8i+aI4cgImbE=;
        b=eNBHBEk+Ds5KG91wCPgmQhRnJHnVUZ6PPNl67IkipXVm0N0/ANIu52fvOFMqpMfkIq
         tn672n4wLOzEitu6rmcAeeK4qPU1mAZAqhz5p2YZX9RsvZYUqUzgCcG4QT+88jhVm5TI
         tdPF53MplgJIV/2TK0C+gpvzKCTZW01EcxjxE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hfAvAuNrbwm7BBpI2yh2o5/hOFM6ooN8i+aI4cgImbE=;
        b=bVBdZrBprj01cP/jc5TWWtyD7a1NT1FaFbNBj5s1DeGF2Qb7AWiQxwTWs/wGP4+k2b
         yK9uZlAYb5tBIPS1M/j5ARqjmoCmbWWLAByt0pnocUycumLQXcZQ3H3HI9uUtnuNuFv2
         F6mcQ1Rn5BdNuER7y825HHt9TtfDJim8r/ohhenBoOX07mbso3a9xp1roJ4XGuWP8Tm/
         V6CBj4VrjGFGXimqh0bAfT7kybLt43hVQloIAXCnNj4Gnd6Z+gtQXCRdSqsB/bKnOf8s
         41RVjiKj2HDuPmBlXSmhxZpcuqCwC63JIVjG8vO4+BwNLWyhrj+5YmSImI/vUFSQaPKc
         M0/w==
X-Gm-Message-State: APjAAAUwF1Of+KVjEv9mST+2sdNaCv5bNee6G5HXItGCxc6vEzu3GbNS
        J+D8RygQHneCSk6S5VzZ4JMiw0WcJYyb65yQ3t9JLw==
X-Google-Smtp-Source: APXvYqyp3KffQhGrFbjDe4AMAA82soxGrnZho55Z70rLgfyikB5KfCxnsFA4djUej96Z2x8HlRFSL50nR1BDO/XSe/0=
X-Received: by 2002:a6b:fa15:: with SMTP id p21mr8927994ioh.212.1571645030566;
 Mon, 21 Oct 2019 01:03:50 -0700 (PDT)
MIME-Version: 1.0
References: <20191015174626.11593-1-vgoyal@redhat.com> <20191015174626.11593-2-vgoyal@redhat.com>
In-Reply-To: <20191015174626.11593-2-vgoyal@redhat.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Mon, 21 Oct 2019 10:03:39 +0200
Message-ID: <CAJfpegtrFvuBUuQ7B+ynCLVmgZ8zRjbUYZYg+BzG6HDmt5RyXw@mail.gmail.com>
Subject: Re: [PATCH 1/5] virtiofs: Do not end request in submission context
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
> Submission context can hold some locks which end request code tries to
> hold again and deadlock can occur. For example, fc->bg_lock. If a background
> request is being submitted, it might hold fc->bg_lock and if we could not
> submit request (because device went away) and tried to end request,
> then deadlock happens. During testing, I also got a warning from deadlock
> detection code.
>
> So put requests on a list and end requests from a worker thread.
>
> I got following warning from deadlock detector.
>
> [  603.137138] WARNING: possible recursive locking detected
> [  603.137142] --------------------------------------------
> [  603.137144] blogbench/2036 is trying to acquire lock:
> [  603.137149] 00000000f0f51107 (&(&fc->bg_lock)->rlock){+.+.}, at: fuse_request_end+0xdf/0x1c0 [fuse]
> [  603.140701]
> [  603.140701] but task is already holding lock:
> [  603.140703] 00000000f0f51107 (&(&fc->bg_lock)->rlock){+.+.}, at: fuse_simple_background+0x92/0x1d0 [fuse]
> [  603.140713]
> [  603.140713] other info that might help us debug this:
> [  603.140714]  Possible unsafe locking scenario:
> [  603.140714]
> [  603.140715]        CPU0
> [  603.140716]        ----
> [  603.140716]   lock(&(&fc->bg_lock)->rlock);
> [  603.140718]   lock(&(&fc->bg_lock)->rlock);
> [  603.140719]
> [  603.140719]  *** DEADLOCK ***
>
> Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
> ---
>  fs/fuse/virtio_fs.c | 38 ++++++++++++++++++++++++++++++++++----
>  1 file changed, 34 insertions(+), 4 deletions(-)
>
> diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
> index 6af3f131e468..24ac6f8bf3f7 100644
> --- a/fs/fuse/virtio_fs.c
> +++ b/fs/fuse/virtio_fs.c
> @@ -30,6 +30,7 @@ struct virtio_fs_vq {
>         struct virtqueue *vq;     /* protected by ->lock */
>         struct work_struct done_work;
>         struct list_head queued_reqs;
> +       struct list_head end_reqs;      /* End these requests */
>         struct delayed_work dispatch_work;
>         struct fuse_dev *fud;
>         bool connected;
> @@ -259,8 +260,27 @@ static void virtio_fs_hiprio_done_work(struct work_struct *work)
>         spin_unlock(&fsvq->lock);
>  }
>
> -static void virtio_fs_dummy_dispatch_work(struct work_struct *work)
> +static void virtio_fs_request_dispatch_work(struct work_struct *work)
>  {
> +       struct fuse_req *req;
> +       struct virtio_fs_vq *fsvq = container_of(work, struct virtio_fs_vq,
> +                                                dispatch_work.work);
> +       struct fuse_conn *fc = fsvq->fud->fc;
> +
> +       pr_debug("virtio-fs: worker %s called.\n", __func__);
> +       while (1) {
> +               spin_lock(&fsvq->lock);
> +               req = list_first_entry_or_null(&fsvq->end_reqs, struct fuse_req,
> +                                              list);
> +               if (!req) {
> +                       spin_unlock(&fsvq->lock);
> +                       return;
> +               }
> +
> +               list_del_init(&req->list);
> +               spin_unlock(&fsvq->lock);
> +               fuse_request_end(fc, req);
> +       }
>  }
>
>  static void virtio_fs_hiprio_dispatch_work(struct work_struct *work)
> @@ -502,6 +522,7 @@ static int virtio_fs_setup_vqs(struct virtio_device *vdev,
>         names[VQ_HIPRIO] = fs->vqs[VQ_HIPRIO].name;
>         INIT_WORK(&fs->vqs[VQ_HIPRIO].done_work, virtio_fs_hiprio_done_work);
>         INIT_LIST_HEAD(&fs->vqs[VQ_HIPRIO].queued_reqs);
> +       INIT_LIST_HEAD(&fs->vqs[VQ_HIPRIO].end_reqs);
>         INIT_DELAYED_WORK(&fs->vqs[VQ_HIPRIO].dispatch_work,
>                         virtio_fs_hiprio_dispatch_work);
>         spin_lock_init(&fs->vqs[VQ_HIPRIO].lock);
> @@ -511,8 +532,9 @@ static int virtio_fs_setup_vqs(struct virtio_device *vdev,
>                 spin_lock_init(&fs->vqs[i].lock);
>                 INIT_WORK(&fs->vqs[i].done_work, virtio_fs_requests_done_work);
>                 INIT_DELAYED_WORK(&fs->vqs[i].dispatch_work,
> -                                       virtio_fs_dummy_dispatch_work);
> +                                 virtio_fs_request_dispatch_work);
>                 INIT_LIST_HEAD(&fs->vqs[i].queued_reqs);
> +               INIT_LIST_HEAD(&fs->vqs[i].end_reqs);
>                 snprintf(fs->vqs[i].name, sizeof(fs->vqs[i].name),
>                          "requests.%u", i - VQ_REQUEST);
>                 callbacks[i] = virtio_fs_vq_done;
> @@ -918,6 +940,7 @@ __releases(fiq->lock)
>         struct fuse_conn *fc;
>         struct fuse_req *req;
>         struct fuse_pqueue *fpq;
> +       struct virtio_fs_vq *fsvq;
>         int ret;
>
>         WARN_ON(list_empty(&fiq->pending));
> @@ -951,7 +974,8 @@ __releases(fiq->lock)
>         smp_mb__after_atomic();
>
>  retry:
> -       ret = virtio_fs_enqueue_req(&fs->vqs[queue_id], req);
> +       fsvq = &fs->vqs[queue_id];
> +       ret = virtio_fs_enqueue_req(fsvq, req);
>         if (ret < 0) {
>                 if (ret == -ENOMEM || ret == -ENOSPC) {
>                         /* Virtqueue full. Retry submission */
> @@ -965,7 +989,13 @@ __releases(fiq->lock)
>                 clear_bit(FR_SENT, &req->flags);
>                 list_del_init(&req->list);
>                 spin_unlock(&fpq->lock);
> -               fuse_request_end(fc, req);
> +
> +               /* Can't end request in submission context. Use a worker */
> +               spin_lock(&fsvq->lock);
> +               list_add_tail(&req->list, &fsvq->end_reqs);
> +               schedule_delayed_work(&fsvq->dispatch_work,
> +                                     msecs_to_jiffies(1));

What's the reason to delay by one msec?  If this is purely for
deadlock avoidance, then a zero delay would work better, no?

Thanks,
Miklos
