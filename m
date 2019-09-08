Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C472DACC5A
	for <lists+linux-fsdevel@lfdr.de>; Sun,  8 Sep 2019 13:10:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728739AbfIHLKZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 8 Sep 2019 07:10:25 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:2237 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726186AbfIHLKY (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 8 Sep 2019 07:10:24 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 933D21FDA77EC739305C;
        Sun,  8 Sep 2019 19:10:22 +0800 (CST)
Received: from [10.45.2.172] (10.45.2.172) by smtp.huawei.com (10.3.19.210)
 with Microsoft SMTP Server id 14.3.439.0; Sun, 8 Sep 2019 19:10:21 +0800
Subject: Re: [Virtio-fs] [PATCH 15/18] virtiofs: Make virtio_fs object
 refcounted
To:     Vivek Goyal <vgoyal@redhat.com>, <linux-fsdevel@vger.kernel.org>,
        <virtualization@lists.linux-foundation.org>, <miklos@szeredi.hu>
CC:     <mst@redhat.com>, <linux-kernel@vger.kernel.org>,
        <virtio-fs@redhat.com>
References: <20190905194859.16219-1-vgoyal@redhat.com>
 <20190905194859.16219-16-vgoyal@redhat.com>
From:   piaojun <piaojun@huawei.com>
Message-ID: <a8ddb168-5fdb-b35a-5357-3c75e0226049@huawei.com>
Date:   Sun, 8 Sep 2019 19:10:03 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190905194859.16219-16-vgoyal@redhat.com>
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
> This object is used both by fuse_connection as well virt device. So make
> this object reference counted and that makes it easy to define life cycle
> of the object.
> 
> Now deivce can be removed while filesystem is still mounted. This will
> cleanup all the virtqueues but virtio_fs object will still be around and
> will be cleaned when filesystem is unmounted and sb/fc drops its reference.
> 
> Removing a device also stops all virt queues and any new reuqest gets
> error -ENOTCONN. All existing in flight requests are drained before
> ->remove returns.
> 
> Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
> ---
>  fs/fuse/virtio_fs.c | 52 +++++++++++++++++++++++++++++++++++++--------
>  1 file changed, 43 insertions(+), 9 deletions(-)
> 
> diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
> index 01bbf2c0e144..29ec2f5bbbe2 100644
> --- a/fs/fuse/virtio_fs.c
> +++ b/fs/fuse/virtio_fs.c
> @@ -37,6 +37,7 @@ struct virtio_fs_vq {
>  
>  /* A virtio-fs device instance */
>  struct virtio_fs {
> +	struct kref refcount;
>  	struct list_head list;    /* on virtio_fs_instances */
>  	char *tag;
>  	struct virtio_fs_vq *vqs;
> @@ -63,6 +64,27 @@ static inline struct fuse_pqueue *vq_to_fpq(struct virtqueue *vq)
>  	return &vq_to_fsvq(vq)->fud->pq;
>  }
>  
> +static void release_virtiofs_obj(struct kref *ref)
> +{
> +	struct virtio_fs *vfs = container_of(ref, struct virtio_fs, refcount);
> +
> +	kfree(vfs->vqs);
> +	kfree(vfs);
> +}
> +
> +static void virtio_fs_put(struct virtio_fs *fs)
> +{
> +	mutex_lock(&virtio_fs_mutex);
> +	kref_put(&fs->refcount, release_virtiofs_obj);
> +	mutex_unlock(&virtio_fs_mutex);
> +}
> +
> +static void virtio_fs_put(struct fuse_iqueue *fiq)
> +{
> +	struct virtio_fs *vfs = fiq->priv;
> +	virtiofs_put(vfs);
> +}

It's a little confusing that virtiofs_put() looks like virtiofs_put(),
and could we use __virtio_fs_put to replace virtio_fs_put?

Thanks,
Jun
