Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AA26BDEB65
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Oct 2019 13:52:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727959AbfJULwj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Oct 2019 07:52:39 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:27725 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726767AbfJULwi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Oct 2019 07:52:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1571658757;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zZBruv/YszCEqmEKFyYzEfKIpa3aLEsFQ2HYxE8iMIs=;
        b=PN0qZjZSc1kcFyLCACq6z+oA91zDQbLQllkq2345IjU0BWVNSnsFg4GOkluCmQZnzhKSio
        0bno+r1TPMh6YO9bby5Z0YlSf9j51nE4OjPaKs2G0phFcXry1catZEVAtw1Ii/lhxR4xDd
        ezOTEfybUk0AdgBeyOWxFKBymqtPqaQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-290-Hs80mIM2PEaCVtItj_HQzA-1; Mon, 21 Oct 2019 07:52:31 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7E4DF80183E;
        Mon, 21 Oct 2019 11:52:30 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.18.25.35])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 14B511001B11;
        Mon, 21 Oct 2019 11:52:25 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 9CB942202E5; Mon, 21 Oct 2019 07:52:24 -0400 (EDT)
Date:   Mon, 21 Oct 2019 07:52:24 -0400
From:   Vivek Goyal <vgoyal@redhat.com>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     linux-fsdevel@vger.kernel.org, virtio-fs@redhat.com,
        Stefan Hajnoczi <stefanha@redhat.com>,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
        chirantan@chromium.org, virtualization@lists.linux-foundation.org
Subject: Re: [PATCH 1/5] virtiofs: Do not end request in submission context
Message-ID: <20191021115224.GA13573@redhat.com>
References: <20191015174626.11593-1-vgoyal@redhat.com>
 <20191015174626.11593-2-vgoyal@redhat.com>
 <CAJfpegtrFvuBUuQ7B+ynCLVmgZ8zRjbUYZYg+BzG6HDmt5RyXw@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAJfpegtrFvuBUuQ7B+ynCLVmgZ8zRjbUYZYg+BzG6HDmt5RyXw@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: Hs80mIM2PEaCVtItj_HQzA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Oct 21, 2019 at 10:03:39AM +0200, Miklos Szeredi wrote:

[..]
> >  static void virtio_fs_hiprio_dispatch_work(struct work_struct *work)
> > @@ -502,6 +522,7 @@ static int virtio_fs_setup_vqs(struct virtio_device=
 *vdev,
> >         names[VQ_HIPRIO] =3D fs->vqs[VQ_HIPRIO].name;
> >         INIT_WORK(&fs->vqs[VQ_HIPRIO].done_work, virtio_fs_hiprio_done_=
work);
> >         INIT_LIST_HEAD(&fs->vqs[VQ_HIPRIO].queued_reqs);
> > +       INIT_LIST_HEAD(&fs->vqs[VQ_HIPRIO].end_reqs);
> >         INIT_DELAYED_WORK(&fs->vqs[VQ_HIPRIO].dispatch_work,
> >                         virtio_fs_hiprio_dispatch_work);
> >         spin_lock_init(&fs->vqs[VQ_HIPRIO].lock);
> > @@ -511,8 +532,9 @@ static int virtio_fs_setup_vqs(struct virtio_device=
 *vdev,
> >                 spin_lock_init(&fs->vqs[i].lock);
> >                 INIT_WORK(&fs->vqs[i].done_work, virtio_fs_requests_don=
e_work);
> >                 INIT_DELAYED_WORK(&fs->vqs[i].dispatch_work,
> > -                                       virtio_fs_dummy_dispatch_work);
> > +                                 virtio_fs_request_dispatch_work);
> >                 INIT_LIST_HEAD(&fs->vqs[i].queued_reqs);
> > +               INIT_LIST_HEAD(&fs->vqs[i].end_reqs);
> >                 snprintf(fs->vqs[i].name, sizeof(fs->vqs[i].name),
> >                          "requests.%u", i - VQ_REQUEST);
> >                 callbacks[i] =3D virtio_fs_vq_done;
> > @@ -918,6 +940,7 @@ __releases(fiq->lock)
> >         struct fuse_conn *fc;
> >         struct fuse_req *req;
> >         struct fuse_pqueue *fpq;
> > +       struct virtio_fs_vq *fsvq;
> >         int ret;
> >
> >         WARN_ON(list_empty(&fiq->pending));
> > @@ -951,7 +974,8 @@ __releases(fiq->lock)
> >         smp_mb__after_atomic();
> >
> >  retry:
> > -       ret =3D virtio_fs_enqueue_req(&fs->vqs[queue_id], req);
> > +       fsvq =3D &fs->vqs[queue_id];
> > +       ret =3D virtio_fs_enqueue_req(fsvq, req);
> >         if (ret < 0) {
> >                 if (ret =3D=3D -ENOMEM || ret =3D=3D -ENOSPC) {
> >                         /* Virtqueue full. Retry submission */
> > @@ -965,7 +989,13 @@ __releases(fiq->lock)
> >                 clear_bit(FR_SENT, &req->flags);
> >                 list_del_init(&req->list);
> >                 spin_unlock(&fpq->lock);
> > -               fuse_request_end(fc, req);
> > +
> > +               /* Can't end request in submission context. Use a worke=
r */
> > +               spin_lock(&fsvq->lock);
> > +               list_add_tail(&req->list, &fsvq->end_reqs);
> > +               schedule_delayed_work(&fsvq->dispatch_work,
> > +                                     msecs_to_jiffies(1));
>=20
> What's the reason to delay by one msec?  If this is purely for
> deadlock avoidance, then a zero delay would work better, no?

Hi Miklos,

I have no good reason to do that. Will change it to zero delay.

Thanks
Vivek

