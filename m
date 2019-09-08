Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B45BCACC66
	for <lists+linux-fsdevel@lfdr.de>; Sun,  8 Sep 2019 13:19:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728840AbfIHLTh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 8 Sep 2019 07:19:37 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:2238 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728753AbfIHLTh (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 8 Sep 2019 07:19:37 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id BD2365A0B3E889342FE2;
        Sun,  8 Sep 2019 19:19:35 +0800 (CST)
Received: from [10.45.2.172] (10.45.2.172) by smtp.huawei.com (10.3.19.211)
 with Microsoft SMTP Server id 14.3.439.0; Sun, 8 Sep 2019 19:19:31 +0800
Subject: Re: [Virtio-fs] [PATCH 16/18] virtiofs: Use virtio_fs_mutex for races
 w.r.t ->remove and mount path
To:     Vivek Goyal <vgoyal@redhat.com>, <linux-fsdevel@vger.kernel.org>,
        <virtualization@lists.linux-foundation.org>, <miklos@szeredi.hu>
CC:     <mst@redhat.com>, <linux-kernel@vger.kernel.org>,
        <virtio-fs@redhat.com>
References: <20190905194859.16219-1-vgoyal@redhat.com>
 <20190905194859.16219-17-vgoyal@redhat.com>
From:   piaojun <piaojun@huawei.com>
Message-ID: <62d8b7fb-9024-a6c9-73b8-727aacfe8544@huawei.com>
Date:   Sun, 8 Sep 2019 19:19:13 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190905194859.16219-17-vgoyal@redhat.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.45.2.172]
X-CFilter-Loop: Reflected
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 2019/9/6 3:48, Vivek Goyal wrote:
> It is possible that a mount is in progress and device is being removed at
> the same time. Use virtio_fs_mutex to avoid races.
> 
> This also takes care of bunch of races and removes some TODO items.
> 
> Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
> ---
>  fs/fuse/virtio_fs.c | 32 ++++++++++++++++++++++----------
>  1 file changed, 22 insertions(+), 10 deletions(-)
> 
> diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
> index 29ec2f5bbbe2..c483482185b6 100644
> --- a/fs/fuse/virtio_fs.c
> +++ b/fs/fuse/virtio_fs.c
> @@ -13,7 +13,9 @@
>  #include <linux/highmem.h>
>  #include "fuse_i.h"
>  
> -/* List of virtio-fs device instances and a lock for the list */
> +/* List of virtio-fs device instances and a lock for the list. Also provides
> + * mutual exclusion in device removal and mounting path
> + */
>  static DEFINE_MUTEX(virtio_fs_mutex);
>  static LIST_HEAD(virtio_fs_instances);
>  
> @@ -72,17 +74,19 @@ static void release_virtiofs_obj(struct kref *ref)
>  	kfree(vfs);
>  }
>  
> +/* Make sure virtiofs_mutex is held */

Typo? virtiofs_mutex->virtio_fs_mutex

Jun

>  static void virtiofs_put(struct virtio_fs *fs)
>  {
> -	mutex_lock(&virtio_fs_mutex);
>  	kref_put(&fs->refcount, release_virtiofs_obj);
> -	mutex_unlock(&virtio_fs_mutex);
>  }
>  
>  static void virtio_fs_put(struct fuse_iqueue *fiq)
>  {
>  	struct virtio_fs *vfs = fiq->priv;
> +
> +	mutex_lock(&virtio_fs_mutex);
>  	virtiofs_put(vfs);
> +	mutex_unlock(&virtio_fs_mutex);
>  }
>  
>  static void virtio_fs_drain_queue(struct virtio_fs_vq *fsvq)
> @@ -596,9 +600,8 @@ static void virtio_fs_remove(struct virtio_device *vdev)
>  	struct virtio_fs *fs = vdev->priv;
>  
>  	mutex_lock(&virtio_fs_mutex);
> +	/* This device is going away. No one should get new reference */
>  	list_del_init(&fs->list);
> -	mutex_unlock(&virtio_fs_mutex);
> -
>  	virtio_fs_stop_all_queues(fs);
>  	virtio_fs_drain_all_queues(fs);
>  	vdev->config->reset(vdev);
> @@ -607,6 +610,7 @@ static void virtio_fs_remove(struct virtio_device *vdev)
>  	vdev->priv = NULL;
>  	/* Put device reference on virtio_fs object */
>  	virtiofs_put(fs);
> +	mutex_unlock(&virtio_fs_mutex);
>  }
>  
>  #ifdef CONFIG_PM_SLEEP
> @@ -978,10 +982,15 @@ static int virtio_fs_fill_super(struct super_block *sb)
>  		.no_force_umount = true,
>  	};
>  
> -	/* TODO lock */
> -	if (fs->vqs[VQ_REQUEST].fud) {
> -		pr_err("virtio-fs: device already in use\n");
> -		err = -EBUSY;
> +	mutex_lock(&virtio_fs_mutex);
> +
> +	/* After holding mutex, make sure virtiofs device is still there.
> +	 * Though we are holding a refernce to it, drive ->remove might
> +	 * still have cleaned up virtual queues. In that case bail out.
> +	 */
> +	err = -EINVAL;
> +	if (list_empty(&fs->list)) {
> +		pr_info("virtio-fs: tag <%s> not found\n", fs->tag);
>  		goto err;
>  	}
>  
> @@ -1007,7 +1016,6 @@ static int virtio_fs_fill_super(struct super_block *sb)
>  
>  	fc = fs->vqs[VQ_REQUEST].fud->fc;
>  
> -	/* TODO take fuse_mutex around this loop? */
>  	for (i = 0; i < fs->nvqs; i++) {
>  		struct virtio_fs_vq *fsvq = &fs->vqs[i];
>  
> @@ -1020,6 +1028,7 @@ static int virtio_fs_fill_super(struct super_block *sb)
>  	/* Previous unmount will stop all queues. Start these again */
>  	virtio_fs_start_all_queues(fs);
>  	fuse_send_init(fc, init_req);
> +	mutex_unlock(&virtio_fs_mutex);
>  	return 0;
>  
>  err_free_init_req:
> @@ -1027,6 +1036,7 @@ static int virtio_fs_fill_super(struct super_block *sb)
>  err_free_fuse_devs:
>  	virtio_fs_free_devs(fs);
>  err:
> +	mutex_unlock(&virtio_fs_mutex);
>  	return err;
>  }
>  
> @@ -1100,7 +1110,9 @@ static int virtio_fs_get_tree(struct fs_context *fsc)
>  
>  	fc = kzalloc(sizeof(struct fuse_conn), GFP_KERNEL);
>  	if (!fc) {
> +		mutex_lock(&virtio_fs_mutex);
>  		virtiofs_put(fs);
> +		mutex_unlock(&virtio_fs_mutex);
>  		return -ENOMEM;
>  	}
>  
> 
