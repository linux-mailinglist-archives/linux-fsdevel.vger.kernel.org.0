Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DF236493CB
	for <lists+linux-fsdevel@lfdr.de>; Sun, 11 Dec 2022 12:01:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230151AbiLKLBP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 11 Dec 2022 06:01:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230144AbiLKLBN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 11 Dec 2022 06:01:13 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 414941005B
        for <linux-fsdevel@vger.kernel.org>; Sun, 11 Dec 2022 03:01:12 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id q17-20020a17090aa01100b002194cba32e9so12695853pjp.1
        for <linux-fsdevel@vger.kernel.org>; Sun, 11 Dec 2022 03:01:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=T9YWp6K3uTj0NW63MVBBW2akr/MvPwicO7toRTwXU04=;
        b=vpkzLBa7VwaKp80Fya+eqmfcALDCBbks/aXLLbpLnwhzKDJxsFwhWDypY61RdNVncM
         FSQwVjbjZgbkbAnE7qIgg//GxasF/WksP9HR46j6esl2tr6T4nguLgbN0ukWx8/0qbxW
         ChMvaYPPjCl5wlatvXNIORsZQvj0WLRkCNZNB7IxEETc+zpsaXiPqTZkUrZPepGMVCkG
         TnAzH8yWHfwFkW8fqxltInUzgxqmKa3BYWpNhHuiQ7hewcSu+V4HxJe1Lo3a4P20vScO
         ZL4YcnGsiDRF/tJAVCU4mvZGnQJMIfoxRgVMsV07YRD+MUtTd3nlK3bETbtTbVX3zdsL
         r0pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=T9YWp6K3uTj0NW63MVBBW2akr/MvPwicO7toRTwXU04=;
        b=fXTnK5VddcvuP2If28Cna4m65Gni4sBnMonoVrs9XN3ahuO9Bo1vxB6tLoHZlI6kJH
         kvZIClEqqG3KHW3st21RPy0zV+e1sDgq7rS3NvbKSaOnI9Q7UY+HDlc/hcILJdEHnJeo
         /iiTuhEd2A9CfcjepD/OjAscM/BaqsyCD3C6Ultfv96ThlBrdNK96UcRb9Bqhn1pH5Ug
         MWM2R0eMee1RryskSIC2efAte9XhlpRfJCX/HSiA3Xfcu8M4TbbCceT9UGKDETEkSU87
         81mfGo8A3pp8XPnPoxp/e56AFN0v84L/W72XbXmjRPovYhY9Ll0aQTSdN4g3W8R2g3Iv
         +RtA==
X-Gm-Message-State: ANoB5plv+LDF4Nq81oTep9OQOzlTV83q0ep+cF9MXhZAmVfTCHAOc5+C
        Qfr/gmpNa40hd0B3/lnnHposDNTTuyCxL9iPPFXJIw==
X-Google-Smtp-Source: AA0mqf7BgSNrqBFAKnAQmO46PdiwH696338bl7b2V+k1Zb1F4TNuObFzHWFsDQB7Km/uqKkDApMmMsXuRmvAiJx9a8I=
X-Received: by 2002:a17:90a:df01:b0:21a:8ca:f73 with SMTP id
 gp1-20020a17090adf0100b0021a08ca0f73mr11373353pjb.82.1670756471710; Sun, 11
 Dec 2022 03:01:11 -0800 (PST)
MIME-Version: 1.0
References: <20221211103857.25805-1-zhangjiachen.jaycee@bytedance.com>
In-Reply-To: <20221211103857.25805-1-zhangjiachen.jaycee@bytedance.com>
From:   Jiachen Zhang <zhangjiachen.jaycee@bytedance.com>
Date:   Sun, 11 Dec 2022 19:01:00 +0800
Message-ID: <CAFQAk7hKTnzyc8Vnnp7UNhjZBqYQC_dukBOEgR255izUNk0_Qw@mail.gmail.com>
Subject: Re: [PATCH] virtiofs: enable multiple request queues
To:     Vivek Goyal <vgoyal@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>
Cc:     virtualization@lists.linux-foundation.org,
        "open list:FUSE: FILESYSTEM IN USERSPACE" 
        <linux-fsdevel@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Connor Kuehl <ckuehl@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Dec 11, 2022 at 6:40 PM Jiachen Zhang
<zhangjiachen.jaycee@bytedance.com> wrote:
>
> Support virtio-fs multiple virtqueues and distribute requests across the
> multiqueue complex automatically based on the IRQ affinity.
>
> This commit is based on Connor's patch in the virtio-fs mailing-list,
> and additionally intergates cpu-to-vq map into struct virtio_fs so that
> this virtio-fs multi-queue feature can fit into multiple virtio-fs mounts.
>
> Link: https://www.mail-archive.com/virtio-fs@redhat.com/msg03320.html
> Suggested-by: Stefan Hajnoczi <stefanha@redhat.com>
> Cc: Connor Kuehl <ckuehl@redhat.com>
> Signed-off-by: Jiachen Zhang <zhangjiachen.jaycee@bytedance.com>
> ---

Hi all,

The corresponding QEMU virtiofsd changes can be found in the
qemu-devel mailing list. The mail link is
https://lore.kernel.org/qemu-devel/20221211104743.27333-1-zhangjiachen.jaycee@bytedance.com/
.

To enable this multi-queue feature with QEMU emulated virtio-fs
devices, you should specify both the qemu-system-x86_64 vhost-user-fs
parameter and the virtiofsd parameter.

For example, to setup 16 virtio-fs request queues, you should apply
the kernel patch in this mail, the QEMU vhost-user-fs device should be
like  '-device vhost-user-fs-pci,chardev=char0,tag=myfs,num-request-queues=16',
and for the virtiofsd you should specify  '-o num_request_queues=16'.

Thanks,
Jiachen

>  fs/fuse/virtio_fs.c | 37 +++++++++++++++++++++++++++++--------
>  1 file changed, 29 insertions(+), 8 deletions(-)
>
> diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
> index 4d8d4f16c727..410968dede0c 100644
> --- a/fs/fuse/virtio_fs.c
> +++ b/fs/fuse/virtio_fs.c
> @@ -32,8 +32,9 @@ static DEFINE_MUTEX(virtio_fs_mutex);
>  static LIST_HEAD(virtio_fs_instances);
>
>  enum {
> -       VQ_HIPRIO,
> -       VQ_REQUEST
> +       VQ_HIPRIO = 0,
> +       /* TODO add VQ_NOTIFICATION according to the virtio 1.2 spec. */
> +       VQ_REQUEST = 1,
>  };
>
>  #define VQ_NAME_LEN    24
> @@ -59,6 +60,7 @@ struct virtio_fs {
>         struct list_head list;    /* on virtio_fs_instances */
>         char *tag;
>         struct virtio_fs_vq *vqs;
> +       struct virtio_fs_vq * __percpu *vq_proxy;
>         unsigned int nvqs;               /* number of virtqueues */
>         unsigned int num_request_queues; /* number of request queues */
>         struct dax_device *dax_dev;
> @@ -686,6 +688,7 @@ static int virtio_fs_setup_vqs(struct virtio_device *vdev,
>         struct virtqueue **vqs;
>         vq_callback_t **callbacks;
>         const char **names;
> +       struct irq_affinity desc = { .pre_vectors = 1, .nr_sets = 1, };
>         unsigned int i;
>         int ret = 0;
>
> @@ -694,11 +697,16 @@ static int virtio_fs_setup_vqs(struct virtio_device *vdev,
>         if (fs->num_request_queues == 0)
>                 return -EINVAL;
>
> +       fs->num_request_queues = min_t(unsigned int, nr_cpu_ids,
> +                                      fs->num_request_queues);
> +
>         fs->nvqs = VQ_REQUEST + fs->num_request_queues;
>         fs->vqs = kcalloc(fs->nvqs, sizeof(fs->vqs[VQ_HIPRIO]), GFP_KERNEL);
>         if (!fs->vqs)
>                 return -ENOMEM;
>
> +       pr_debug("virtio-fs: number of vqs: %d\n", fs->nvqs);
> +
>         vqs = kmalloc_array(fs->nvqs, sizeof(vqs[VQ_HIPRIO]), GFP_KERNEL);
>         callbacks = kmalloc_array(fs->nvqs, sizeof(callbacks[VQ_HIPRIO]),
>                                         GFP_KERNEL);
> @@ -723,12 +731,26 @@ static int virtio_fs_setup_vqs(struct virtio_device *vdev,
>                 names[i] = fs->vqs[i].name;
>         }
>
> -       ret = virtio_find_vqs(vdev, fs->nvqs, vqs, callbacks, names, NULL);
> +       ret = virtio_find_vqs(vdev, fs->nvqs, vqs, callbacks, names, &desc);
>         if (ret < 0)
>                 goto out;
>
> -       for (i = 0; i < fs->nvqs; i++)
> +       fs->vq_proxy = alloc_percpu(struct virtio_fs_vq *);
> +       for (i = 0; i < fs->nvqs; i++) {
> +               const struct cpumask *mask;
> +               unsigned int cpu;
> +
>                 fs->vqs[i].vq = vqs[i];
> +               if (i == VQ_HIPRIO)
> +                       continue;
> +
> +               mask = vdev->config->get_vq_affinity(vdev, i);
> +               for_each_cpu(cpu, mask) {
> +                       struct virtio_fs_vq **cpu_vq = per_cpu_ptr(fs->vq_proxy, cpu);
> +                       *cpu_vq = &fs->vqs[i];
> +                       pr_debug("virtio-fs: map cpu %d to vq%d\n", cpu, i);
> +               }
> +       }
>
>         virtio_fs_start_all_queues(fs);
>  out:
> @@ -875,8 +897,6 @@ static int virtio_fs_probe(struct virtio_device *vdev)
>         if (ret < 0)
>                 goto out;
>
> -       /* TODO vq affinity */
> -
>         ret = virtio_fs_setup_dax(vdev, fs);
>         if (ret < 0)
>                 goto out_vqs;
> @@ -926,6 +946,7 @@ static void virtio_fs_remove(struct virtio_device *vdev)
>         virtio_fs_stop_all_queues(fs);
>         virtio_fs_drain_all_queues_locked(fs);
>         virtio_reset_device(vdev);
> +       free_percpu(fs->vq_proxy);
>         virtio_fs_cleanup_vqs(vdev);
>
>         vdev->priv = NULL;
> @@ -1223,7 +1244,6 @@ static int virtio_fs_enqueue_req(struct virtio_fs_vq *fsvq,
>  static void virtio_fs_wake_pending_and_unlock(struct fuse_iqueue *fiq)
>  __releases(fiq->lock)
>  {
> -       unsigned int queue_id = VQ_REQUEST; /* TODO multiqueue */
>         struct virtio_fs *fs;
>         struct fuse_req *req;
>         struct virtio_fs_vq *fsvq;
> @@ -1243,7 +1263,8 @@ __releases(fiq->lock)
>                  req->in.h.nodeid, req->in.h.len,
>                  fuse_len_args(req->args->out_numargs, req->args->out_args));
>
> -       fsvq = &fs->vqs[queue_id];
> +       fsvq = this_cpu_read(*fs->vq_proxy);
> +
>         ret = virtio_fs_enqueue_req(fsvq, req, false);
>         if (ret < 0) {
>                 if (ret == -ENOMEM || ret == -ENOSPC) {
> --
> 2.20.1
>
