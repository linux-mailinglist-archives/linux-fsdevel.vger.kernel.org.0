Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 088233ACF7A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Jun 2021 17:52:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233791AbhFRPy0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 18 Jun 2021 11:54:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:58384 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233880AbhFRPyZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 18 Jun 2021 11:54:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624031535;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=J0WL+FZk7Yq7sNTCDnuHrQ7U4/u1MoVoo3aB7ASsV6o=;
        b=Lm1TYJ+25/d0+0esYiVkp059+mKIFAPVzwnVOypNAfWSA4V1VxuKXrgPAMIK81/VyeoAp1
        th/CS73cq7rxSVMaWyIHARbvrT+6yhDblVGUeLgr8VHm2IOdLIH4AFdnn0FcBzQh6IQATu
        hKIZFficzBJlyXXAY4bmo8Xv/ag1ZrM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-14-CNALam2nPE2tdxaNLuA81g-1; Fri, 18 Jun 2021 11:52:13 -0400
X-MC-Unique: CNALam2nPE2tdxaNLuA81g-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B812319611A0;
        Fri, 18 Jun 2021 15:52:12 +0000 (UTC)
Received: from horse.redhat.com (ovpn-114-2.rdu2.redhat.com [10.10.114.2])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E8E935DA2D;
        Fri, 18 Jun 2021 15:52:05 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 8B57C22054F; Fri, 18 Jun 2021 11:52:05 -0400 (EDT)
Date:   Fri, 18 Jun 2021 11:52:05 -0400
From:   Vivek Goyal <vgoyal@redhat.com>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Ioannis Angelakopoulos <iangelak@redhat.com>,
        linux-fsdevel@vger.kernel.org,
        virtio-fs-list <virtio-fs@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH 1/3] virtiofs: Add an index to keep track of first
 request queue
Message-ID: <20210618155205.GA1252241@redhat.com>
References: <20210616160836.590206-1-iangelak@redhat.com>
 <20210616160836.590206-2-iangelak@redhat.com>
 <CAJfpeguiZX5zk_JP+h3f_00f5mF0nPqg9QVvmNvQ0TTV__LS-w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJfpeguiZX5zk_JP+h3f_00f5mF0nPqg9QVvmNvQ0TTV__LS-w@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jun 18, 2021 at 09:43:36AM +0200, Miklos Szeredi wrote:
> On Wed, 16 Jun 2021 at 18:09, Ioannis Angelakopoulos
> <iangelak@redhat.com> wrote:
> >
> > From: Vivek Goyal <vgoyal@redhat.com>
> >
> > We have many virtqueues and first queue which carries fuse normal requests
> > (except forget requests) has index pointed to by enum VQ_REQUEST. This
> > works fine as long as number of queues are not dynamic.
> >
> > I am about to introduce one more virtqueue, called notification queue,
> > which will be present only if device on host supports it. That means index
> > of request queue will change depending on if notification queue is present
> > or not.
> >
> > So, add a variable to keep track of that index and this will help when
> > notification queue is added in next patch.
> >
> > Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
> > Signed-off-by: Ioannis Angelakopoulos <iangelak@redhat.com>
> > ---
> >  fs/fuse/virtio_fs.c | 22 ++++++++++++++++------
> >  1 file changed, 16 insertions(+), 6 deletions(-)
> >
> > diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
> > index bcb8a02e2d8b..a545e31cf1ae 100644
> > --- a/fs/fuse/virtio_fs.c
> > +++ b/fs/fuse/virtio_fs.c
> > @@ -61,6 +61,7 @@ struct virtio_fs {
> >         unsigned int nvqs;               /* number of virtqueues */
> >         unsigned int num_request_queues; /* number of request queues */
> >         struct dax_device *dax_dev;
> > +       unsigned int first_reqq_idx;     /* First request queue idx */
> >
> >         /* DAX memory window where file contents are mapped */
> >         void *window_kaddr;
> > @@ -681,7 +682,9 @@ static int virtio_fs_setup_vqs(struct virtio_device *vdev,
> >         if (fs->num_request_queues == 0)
> >                 return -EINVAL;
> >
> > -       fs->nvqs = VQ_REQUEST + fs->num_request_queues;
> 
> Okay, so VQ_REQUEST now completely lost it's meaning as an index into
> fs->vqs[] array, but VQ_HIPRIO is still used that way.  This looks
> confusing.  Let's just get rid of VQ_REQUEST/VQ_HIPRIO completely, and
> add "#define VQ_HIPRIO_IDX 0".

Hi Miklos,

Will do.

> 
> > +       /* One hiprio queue and rest are request queues */
> > +       fs->nvqs = 1 + fs->num_request_queues;
> > +       fs->first_reqq_idx = 1;
> >         fs->vqs = kcalloc(fs->nvqs, sizeof(fs->vqs[VQ_HIPRIO]), GFP_KERNEL);
> >         if (!fs->vqs)
> >                 return -ENOMEM;
> > @@ -701,10 +704,11 @@ static int virtio_fs_setup_vqs(struct virtio_device *vdev,
> >         names[VQ_HIPRIO] = fs->vqs[VQ_HIPRIO].name;
> >
> >         /* Initialize the requests virtqueues */
> > -       for (i = VQ_REQUEST; i < fs->nvqs; i++) {
> > +       for (i = fs->first_reqq_idx; i < fs->nvqs; i++) {
> >                 char vq_name[VQ_NAME_LEN];
> >
> > -               snprintf(vq_name, VQ_NAME_LEN, "requests.%u", i - VQ_REQUEST);
> > +               snprintf(vq_name, VQ_NAME_LEN, "requests.%u",
> > +                        i - fs->first_reqq_idx);
> >                 virtio_fs_init_vq(&fs->vqs[i], vq_name, VQ_REQUEST);
> >                 callbacks[i] = virtio_fs_vq_done;
> >                 names[i] = fs->vqs[i].name;
> > @@ -1225,7 +1229,7 @@ static int virtio_fs_enqueue_req(struct virtio_fs_vq *fsvq,
> >  static void virtio_fs_wake_pending_and_unlock(struct fuse_iqueue *fiq)
> >  __releases(fiq->lock)
> >  {
> > -       unsigned int queue_id = VQ_REQUEST; /* TODO multiqueue */
> > +       unsigned int queue_id;
> >         struct virtio_fs *fs;
> >         struct fuse_req *req;
> >         struct virtio_fs_vq *fsvq;
> > @@ -1239,6 +1243,7 @@ __releases(fiq->lock)
> >         spin_unlock(&fiq->lock);
> >
> >         fs = fiq->priv;
> > +       queue_id = fs->first_reqq_idx;
> >
> >         pr_debug("%s: opcode %u unique %#llx nodeid %#llx in.len %u out.len %u\n",
> >                   __func__, req->in.h.opcode, req->in.h.unique,
> > @@ -1316,7 +1321,7 @@ static int virtio_fs_fill_super(struct super_block *sb, struct fs_context *fsc)
> >
> >         err = -ENOMEM;
> >         /* Allocate fuse_dev for hiprio and notification queues */
> > -       for (i = 0; i < fs->nvqs; i++) {
> > +       for (i = 0; i < fs->first_reqq_idx; i++) {
> 
> Previous code didn't seem to do what comment said, while new code
> does.  So while the change seems correct, it should go into a separate
> patch with explanation.

I think this patch needs to be updated. It was correct when I had posted
it back then. But since then we have changed virtiofs code.

Initially we used to allocate fuse device only for hiprio queue and
for request queue fuse_fill_super_common() used to allocate the device.

It was confusing, so I added one patch so that for all virtiofs queues,
virtiofs will allocate fuse device and fuse common code will not allocate
fuse device.

commit 7fd3abfa8dd7c08ecacd25b2f9f9e1d3fb642440
Author: Vivek Goyal <vgoyal@redhat.com>
Date:   Mon May 4 14:33:15 2020 -0400

    virtiofs: do not use fuse_fill_super_common() for device installation

So this patch now needs to be udpated so that it works with current
code. I will fix it.

> 
> >                 struct virtio_fs_vq *fsvq = &fs->vqs[i];
> >
> >                 fsvq->fud = fuse_dev_alloc();
> > @@ -1325,7 +1330,7 @@ static int virtio_fs_fill_super(struct super_block *sb, struct fs_context *fsc)
> >         }
> >
> >         /* virtiofs allocates and installs its own fuse devices */
> > -       ctx->fudptr = NULL;
> > +       ctx->fudptr = (void **)&fs->vqs[fs->first_reqq_idx].fud;
> 
> I don't understand this.

This is also vestige of old code. We used to pass pointer to the location
where fuse common code should install fuse device.

ctx.fudptr = (void **)&fs->vqs[VQ_REQUEST].fud;

Now this code should not be needed. I will clean this up.

> 
> >         if (ctx->dax) {
> >                 if (!fs->dax_dev) {
> >                         err = -EINVAL;
> > @@ -1339,9 +1344,14 @@ static int virtio_fs_fill_super(struct super_block *sb, struct fs_context *fsc)
> >         if (err < 0)
> >                 goto err_free_fuse_devs;
> >
> > +       fc = fs->vqs[fs->first_reqq_idx].fud->fc;
> > +
> 
> Nor this.
> 
> >         for (i = 0; i < fs->nvqs; i++) {
> >                 struct virtio_fs_vq *fsvq = &fs->vqs[i];
> >
> > +               if (i == fs->first_reqq_idx)
> > +                       continue;
> > +
> 
> Nor this.    There's something subtle going on here, that's not
> mentioned in the patch header.

Will fix all this. I think all this is due to old code we had about
fuse device handling.

Thanks
Vivek

