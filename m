Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B6C21DEE85
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Oct 2019 15:58:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728699AbfJUN6M (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Oct 2019 09:58:12 -0400
Received: from mail-il1-f196.google.com ([209.85.166.196]:40865 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728096AbfJUN6M (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Oct 2019 09:58:12 -0400
Received: by mail-il1-f196.google.com with SMTP id d83so3585142ilk.7
        for <linux-fsdevel@vger.kernel.org>; Mon, 21 Oct 2019 06:58:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=03r/9Cb7m0dz39INy4QP2z0kQDNkND9OqZpLu7+5s4A=;
        b=Q+B+d+NZLR+v151wETYlZf6jNjTuXn3iEVv9X/Qq/WaVRp8U1wNea9ikc/QG9BX2wp
         Ix/LBAlKgq6qf4WagB6X/tY3pCZQ8hRPL7iVf1WLP1UMIQlp3igDPxjOJwRK5+RTw97r
         xjlAIDiQF62nuXlSvjlX4no86sxfUm8ksGquY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=03r/9Cb7m0dz39INy4QP2z0kQDNkND9OqZpLu7+5s4A=;
        b=spBIsQwmT5CcupUplgsn7RNaF4S2uUPayTS7hmccHfrF0w2vYtdE2xRtaLt0HRNBw3
         C7fKFZbndXm5/XfJW9pS6Jo1eGCyi1qD3HC50hXUVpW12sUdh9KqLDtsxQYnjHsGA601
         cy43WXBLf8gFOQBcMu0O3aBy23+VAJUy6ODK5L8xYNaZsmUftvD1mpCjRSUj/3xcJ0B3
         KRFO9/sV4w4cz7CUmySy0hDmD8157zy41UPKC6R9bA2Mk+Uo/NXuqXMPppfEcRTUbePP
         iNgtvUN9zhGog0qRukHAZ2P57k1dj3tVUjlgMgHwUqqy5dYUSNwdCY7H0kGHUIC/QPmI
         3FFw==
X-Gm-Message-State: APjAAAXSUtlPRIOeFs8f3SQsAhRy8XXiE+K3XVhTRc/PfaCTL2dagINT
        MQgDKhd3CDmUgGbtRqSkOJytgqaS4o5CVRw8G4F0iQ==
X-Google-Smtp-Source: APXvYqwYKfI4RpZn9TJ222qDG3YNj+eDhaYC+ibNdvWpTJl6CK5aI4B2rPF/h6i6PlEKdkNyuMM+TxbRR0nAinivei8=
X-Received: by 2002:a92:c80b:: with SMTP id v11mr25300114iln.285.1571666291821;
 Mon, 21 Oct 2019 06:58:11 -0700 (PDT)
MIME-Version: 1.0
References: <20191015174626.11593-1-vgoyal@redhat.com> <20191015174626.11593-2-vgoyal@redhat.com>
 <CAJfpegtrFvuBUuQ7B+ynCLVmgZ8zRjbUYZYg+BzG6HDmt5RyXw@mail.gmail.com> <20191021115224.GA13573@redhat.com>
In-Reply-To: <20191021115224.GA13573@redhat.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Mon, 21 Oct 2019 15:58:01 +0200
Message-ID: <CAJfpegvB6gud1Y-rJGD-afx-c02Suagg29RbT8ETDL1C57A1wA@mail.gmail.com>
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

On Mon, Oct 21, 2019 at 1:52 PM Vivek Goyal <vgoyal@redhat.com> wrote:
>
> On Mon, Oct 21, 2019 at 10:03:39AM +0200, Miklos Szeredi wrote:
>
> [..]
> > >  static void virtio_fs_hiprio_dispatch_work(struct work_struct *work)
> > > @@ -502,6 +522,7 @@ static int virtio_fs_setup_vqs(struct virtio_device *vdev,
> > >         names[VQ_HIPRIO] = fs->vqs[VQ_HIPRIO].name;
> > >         INIT_WORK(&fs->vqs[VQ_HIPRIO].done_work, virtio_fs_hiprio_done_work);
> > >         INIT_LIST_HEAD(&fs->vqs[VQ_HIPRIO].queued_reqs);
> > > +       INIT_LIST_HEAD(&fs->vqs[VQ_HIPRIO].end_reqs);
> > >         INIT_DELAYED_WORK(&fs->vqs[VQ_HIPRIO].dispatch_work,
> > >                         virtio_fs_hiprio_dispatch_work);
> > >         spin_lock_init(&fs->vqs[VQ_HIPRIO].lock);
> > > @@ -511,8 +532,9 @@ static int virtio_fs_setup_vqs(struct virtio_device *vdev,
> > >                 spin_lock_init(&fs->vqs[i].lock);
> > >                 INIT_WORK(&fs->vqs[i].done_work, virtio_fs_requests_done_work);
> > >                 INIT_DELAYED_WORK(&fs->vqs[i].dispatch_work,
> > > -                                       virtio_fs_dummy_dispatch_work);
> > > +                                 virtio_fs_request_dispatch_work);
> > >                 INIT_LIST_HEAD(&fs->vqs[i].queued_reqs);
> > > +               INIT_LIST_HEAD(&fs->vqs[i].end_reqs);
> > >                 snprintf(fs->vqs[i].name, sizeof(fs->vqs[i].name),
> > >                          "requests.%u", i - VQ_REQUEST);
> > >                 callbacks[i] = virtio_fs_vq_done;
> > > @@ -918,6 +940,7 @@ __releases(fiq->lock)
> > >         struct fuse_conn *fc;
> > >         struct fuse_req *req;
> > >         struct fuse_pqueue *fpq;
> > > +       struct virtio_fs_vq *fsvq;
> > >         int ret;
> > >
> > >         WARN_ON(list_empty(&fiq->pending));
> > > @@ -951,7 +974,8 @@ __releases(fiq->lock)
> > >         smp_mb__after_atomic();
> > >
> > >  retry:
> > > -       ret = virtio_fs_enqueue_req(&fs->vqs[queue_id], req);
> > > +       fsvq = &fs->vqs[queue_id];
> > > +       ret = virtio_fs_enqueue_req(fsvq, req);
> > >         if (ret < 0) {
> > >                 if (ret == -ENOMEM || ret == -ENOSPC) {
> > >                         /* Virtqueue full. Retry submission */
> > > @@ -965,7 +989,13 @@ __releases(fiq->lock)
> > >                 clear_bit(FR_SENT, &req->flags);
> > >                 list_del_init(&req->list);
> > >                 spin_unlock(&fpq->lock);
> > > -               fuse_request_end(fc, req);
> > > +
> > > +               /* Can't end request in submission context. Use a worker */
> > > +               spin_lock(&fsvq->lock);
> > > +               list_add_tail(&req->list, &fsvq->end_reqs);
> > > +               schedule_delayed_work(&fsvq->dispatch_work,
> > > +                                     msecs_to_jiffies(1));
> >
> > What's the reason to delay by one msec?  If this is purely for
> > deadlock avoidance, then a zero delay would work better, no?
>
> Hi Miklos,
>
> I have no good reason to do that. Will change it to zero delay.

Okay, fixed and pushed out to fuse.git#for-next.

Thanks,
Miklos
