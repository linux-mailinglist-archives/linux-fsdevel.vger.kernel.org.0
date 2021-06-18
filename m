Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 624C33AC524
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Jun 2021 09:43:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230433AbhFRHp6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 18 Jun 2021 03:45:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230315AbhFRHp6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 18 Jun 2021 03:45:58 -0400
Received: from mail-vs1-xe2c.google.com (mail-vs1-xe2c.google.com [IPv6:2607:f8b0:4864:20::e2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F77AC061574
        for <linux-fsdevel@vger.kernel.org>; Fri, 18 Jun 2021 00:43:48 -0700 (PDT)
Received: by mail-vs1-xe2c.google.com with SMTP id l25so4473888vsb.9
        for <linux-fsdevel@vger.kernel.org>; Fri, 18 Jun 2021 00:43:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YDAsEaZIbKIIp8KvyivEadpI521aXNzIrVqbLt8a+6M=;
        b=W3Zwe+ggcNPukjrye6QWgmI1jMrYFTknlvmT0PAsk8U2SmfPWr+w11qxKu60+RqRTj
         KTcKD2lYwNKBYJ2JmvyRtcM4pjyvykHPLUZVs+JvkUxfzP1924LxyG+FJ2jlpZ0jrlNC
         SLdnKkoJ3ODP04kxqwymzcbDjIgGR7hib3bfQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YDAsEaZIbKIIp8KvyivEadpI521aXNzIrVqbLt8a+6M=;
        b=ppP2B9StCCxpCMAkyVF50wypu8+YZ13pHxqwVOdHPICHP6iFukgGSPdul8oc+ekDlq
         U0VIsPTB4rNSaxOvTHEmSGbzQ9zMim9v0ft45qGPs7XH2IpjkkvWJIKizmhZ54vfbXL9
         oZxzUSaQAgBnGT2q/VzCuRBxfVtm/c1UjLnG0a1ZYUblMNQDun3btkLCwVwfuPtpQ7s4
         su2sBZv0U2Vle5NANJ14wHu3zIRWP3yEY1hlHeWhZmVVbCwaBMmqTaWfrzDGWdcxYLlt
         +Fni/QB7q25x1gmxrhpTs8L0cODM+oUYeYBAITYoeH/E6LRcF6rrgeKfpweJpl9KDiFD
         gDtA==
X-Gm-Message-State: AOAM530caGR45gKV3jnmH2yrSOq/T8dQW6iskBvPojKWi9brDFAUqfkW
        Z2d8K8IXFX9p5p8ZGORLSXN0aXczbCl9R4h+1HIMNA==
X-Google-Smtp-Source: ABdhPJxDMtPzfgZZrgejEzYrZHIJA8Cui++ABQGGEyMBwS/zDNAhxvF+vAaK2C3+T8rV5lyvw56YpkGr0JIo8Uz35CU=
X-Received: by 2002:a67:cd19:: with SMTP id u25mr1757659vsl.47.1624002227373;
 Fri, 18 Jun 2021 00:43:47 -0700 (PDT)
MIME-Version: 1.0
References: <20210616160836.590206-1-iangelak@redhat.com> <20210616160836.590206-2-iangelak@redhat.com>
In-Reply-To: <20210616160836.590206-2-iangelak@redhat.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Fri, 18 Jun 2021 09:43:36 +0200
Message-ID: <CAJfpeguiZX5zk_JP+h3f_00f5mF0nPqg9QVvmNvQ0TTV__LS-w@mail.gmail.com>
Subject: Re: [PATCH 1/3] virtiofs: Add an index to keep track of first request queue
To:     Ioannis Angelakopoulos <iangelak@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org,
        virtio-fs-list <virtio-fs@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Vivek Goyal <vgoyal@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 16 Jun 2021 at 18:09, Ioannis Angelakopoulos
<iangelak@redhat.com> wrote:
>
> From: Vivek Goyal <vgoyal@redhat.com>
>
> We have many virtqueues and first queue which carries fuse normal requests
> (except forget requests) has index pointed to by enum VQ_REQUEST. This
> works fine as long as number of queues are not dynamic.
>
> I am about to introduce one more virtqueue, called notification queue,
> which will be present only if device on host supports it. That means index
> of request queue will change depending on if notification queue is present
> or not.
>
> So, add a variable to keep track of that index and this will help when
> notification queue is added in next patch.
>
> Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
> Signed-off-by: Ioannis Angelakopoulos <iangelak@redhat.com>
> ---
>  fs/fuse/virtio_fs.c | 22 ++++++++++++++++------
>  1 file changed, 16 insertions(+), 6 deletions(-)
>
> diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
> index bcb8a02e2d8b..a545e31cf1ae 100644
> --- a/fs/fuse/virtio_fs.c
> +++ b/fs/fuse/virtio_fs.c
> @@ -61,6 +61,7 @@ struct virtio_fs {
>         unsigned int nvqs;               /* number of virtqueues */
>         unsigned int num_request_queues; /* number of request queues */
>         struct dax_device *dax_dev;
> +       unsigned int first_reqq_idx;     /* First request queue idx */
>
>         /* DAX memory window where file contents are mapped */
>         void *window_kaddr;
> @@ -681,7 +682,9 @@ static int virtio_fs_setup_vqs(struct virtio_device *vdev,
>         if (fs->num_request_queues == 0)
>                 return -EINVAL;
>
> -       fs->nvqs = VQ_REQUEST + fs->num_request_queues;

Okay, so VQ_REQUEST now completely lost it's meaning as an index into
fs->vqs[] array, but VQ_HIPRIO is still used that way.  This looks
confusing.  Let's just get rid of VQ_REQUEST/VQ_HIPRIO completely, and
add "#define VQ_HIPRIO_IDX 0".

> +       /* One hiprio queue and rest are request queues */
> +       fs->nvqs = 1 + fs->num_request_queues;
> +       fs->first_reqq_idx = 1;
>         fs->vqs = kcalloc(fs->nvqs, sizeof(fs->vqs[VQ_HIPRIO]), GFP_KERNEL);
>         if (!fs->vqs)
>                 return -ENOMEM;
> @@ -701,10 +704,11 @@ static int virtio_fs_setup_vqs(struct virtio_device *vdev,
>         names[VQ_HIPRIO] = fs->vqs[VQ_HIPRIO].name;
>
>         /* Initialize the requests virtqueues */
> -       for (i = VQ_REQUEST; i < fs->nvqs; i++) {
> +       for (i = fs->first_reqq_idx; i < fs->nvqs; i++) {
>                 char vq_name[VQ_NAME_LEN];
>
> -               snprintf(vq_name, VQ_NAME_LEN, "requests.%u", i - VQ_REQUEST);
> +               snprintf(vq_name, VQ_NAME_LEN, "requests.%u",
> +                        i - fs->first_reqq_idx);
>                 virtio_fs_init_vq(&fs->vqs[i], vq_name, VQ_REQUEST);
>                 callbacks[i] = virtio_fs_vq_done;
>                 names[i] = fs->vqs[i].name;
> @@ -1225,7 +1229,7 @@ static int virtio_fs_enqueue_req(struct virtio_fs_vq *fsvq,
>  static void virtio_fs_wake_pending_and_unlock(struct fuse_iqueue *fiq)
>  __releases(fiq->lock)
>  {
> -       unsigned int queue_id = VQ_REQUEST; /* TODO multiqueue */
> +       unsigned int queue_id;
>         struct virtio_fs *fs;
>         struct fuse_req *req;
>         struct virtio_fs_vq *fsvq;
> @@ -1239,6 +1243,7 @@ __releases(fiq->lock)
>         spin_unlock(&fiq->lock);
>
>         fs = fiq->priv;
> +       queue_id = fs->first_reqq_idx;
>
>         pr_debug("%s: opcode %u unique %#llx nodeid %#llx in.len %u out.len %u\n",
>                   __func__, req->in.h.opcode, req->in.h.unique,
> @@ -1316,7 +1321,7 @@ static int virtio_fs_fill_super(struct super_block *sb, struct fs_context *fsc)
>
>         err = -ENOMEM;
>         /* Allocate fuse_dev for hiprio and notification queues */
> -       for (i = 0; i < fs->nvqs; i++) {
> +       for (i = 0; i < fs->first_reqq_idx; i++) {

Previous code didn't seem to do what comment said, while new code
does.  So while the change seems correct, it should go into a separate
patch with explanation.

>                 struct virtio_fs_vq *fsvq = &fs->vqs[i];
>
>                 fsvq->fud = fuse_dev_alloc();
> @@ -1325,7 +1330,7 @@ static int virtio_fs_fill_super(struct super_block *sb, struct fs_context *fsc)
>         }
>
>         /* virtiofs allocates and installs its own fuse devices */
> -       ctx->fudptr = NULL;
> +       ctx->fudptr = (void **)&fs->vqs[fs->first_reqq_idx].fud;

I don't understand this.

>         if (ctx->dax) {
>                 if (!fs->dax_dev) {
>                         err = -EINVAL;
> @@ -1339,9 +1344,14 @@ static int virtio_fs_fill_super(struct super_block *sb, struct fs_context *fsc)
>         if (err < 0)
>                 goto err_free_fuse_devs;
>
> +       fc = fs->vqs[fs->first_reqq_idx].fud->fc;
> +

Nor this.

>         for (i = 0; i < fs->nvqs; i++) {
>                 struct virtio_fs_vq *fsvq = &fs->vqs[i];
>
> +               if (i == fs->first_reqq_idx)
> +                       continue;
> +

Nor this.    There's something subtle going on here, that's not
mentioned in the patch header.

Thanks,
Miklos
