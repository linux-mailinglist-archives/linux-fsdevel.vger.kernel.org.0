Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DFB92ACBE6
	for <lists+linux-fsdevel@lfdr.de>; Sun,  8 Sep 2019 12:11:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728075AbfIHKLj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 8 Sep 2019 06:11:39 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:2236 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728068AbfIHKLj (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 8 Sep 2019 06:11:39 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 8BE5337150F992917632;
        Sun,  8 Sep 2019 18:11:36 +0800 (CST)
Received: from [10.45.6.3] (10.45.6.3) by smtp.huawei.com (10.3.19.207) with
 Microsoft SMTP Server id 14.3.439.0; Sun, 8 Sep 2019 18:11:32 +0800
Subject: Re: [Virtio-fs] [PATCH 08/18] virtiofs: Drain all pending requests
 during ->remove time
To:     Vivek Goyal <vgoyal@redhat.com>, <linux-fsdevel@vger.kernel.org>,
        <virtualization@lists.linux-foundation.org>, <miklos@szeredi.hu>
CC:     <mst@redhat.com>, <linux-kernel@vger.kernel.org>,
        <virtio-fs@redhat.com>
References: <20190905194859.16219-1-vgoyal@redhat.com>
 <20190905194859.16219-9-vgoyal@redhat.com>
From:   piaojun <piaojun@huawei.com>
Message-ID: <cdcb9860-2088-f92b-e15b-92689deafe80@huawei.com>
Date:   Sun, 8 Sep 2019 18:11:13 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190905194859.16219-9-vgoyal@redhat.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.45.6.3]
X-CFilter-Loop: Reflected
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 2019/9/6 3:48, Vivek Goyal wrote:
> When device is going away, drain all pending requests.
> 
> Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
> ---
>  fs/fuse/virtio_fs.c | 83 ++++++++++++++++++++++++++++-----------------
>  1 file changed, 51 insertions(+), 32 deletions(-)
> 
> diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
> index 90e7b2f345e5..d5730a50b303 100644
> --- a/fs/fuse/virtio_fs.c
> +++ b/fs/fuse/virtio_fs.c
> @@ -63,6 +63,55 @@ static inline struct fuse_pqueue *vq_to_fpq(struct virtqueue *vq)
>  	return &vq_to_fsvq(vq)->fud->pq;
>  }
>  
> +static void virtio_fs_drain_queue(struct virtio_fs_vq *fsvq)
> +{
> +	WARN_ON(fsvq->in_flight < 0);
> +
> +	/* Wait for in flight requests to finish.*/

blank space missed after *finish.*.

> +	while (1) {
> +		spin_lock(&fsvq->lock);
> +		if (!fsvq->in_flight) {
> +			spin_unlock(&fsvq->lock);
> +			break;
> +		}
> +		spin_unlock(&fsvq->lock);
> +		usleep_range(1000, 2000);
> +	}
> +
> +	flush_work(&fsvq->done_work);
> +	flush_delayed_work(&fsvq->dispatch_work);
> +}
> +
> +static inline void drain_hiprio_queued_reqs(struct virtio_fs_vq *fsvq)

Should we add *virtio_fs* prefix for this function? And I wonder if
there are only forget reqs to drain? Maybe we should call it
*virtio_fs_drain_queued_forget_reqs* or someone containing *forget_reqs*.

Thanks,
Jun

> +{
> +	struct virtio_fs_forget *forget;
> +
> +	spin_lock(&fsvq->lock);
> +	while (1) {
> +		forget = list_first_entry_or_null(&fsvq->queued_reqs,
> +						struct virtio_fs_forget, list);
> +		if (!forget)
> +			break;
> +		list_del(&forget->list);
> +		kfree(forget);
> +	}
> +	spin_unlock(&fsvq->lock);
> +}
> +
> +static void virtio_fs_drain_all_queues(struct virtio_fs *fs)
> +{
> +	struct virtio_fs_vq *fsvq;
> +	int i;
> +
> +	for (i = 0; i < fs->nvqs; i++) {
> +		fsvq = &fs->vqs[i];
> +		if (i == VQ_HIPRIO)
> +			drain_hiprio_queued_reqs(fsvq);
> +
> +		virtio_fs_drain_queue(fsvq);
> +	}
> +}
> +
>  /* Add a new instance to the list or return -EEXIST if tag name exists*/
>  static int virtio_fs_add_instance(struct virtio_fs *fs)
>  {
> @@ -511,6 +560,7 @@ static void virtio_fs_remove(struct virtio_device *vdev)
>  	struct virtio_fs *fs = vdev->priv;
>  
>  	virtio_fs_stop_all_queues(fs);
> +	virtio_fs_drain_all_queues(fs);
>  	vdev->config->reset(vdev);
>  	virtio_fs_cleanup_vqs(vdev, fs);
>  
> @@ -865,37 +915,6 @@ __releases(fiq->waitq.lock)
>  	}
>  }
>  
> -static void virtio_fs_flush_hiprio_queue(struct virtio_fs_vq *fsvq)
> -{
> -	struct virtio_fs_forget *forget;
> -
> -	WARN_ON(fsvq->in_flight < 0);
> -
> -	/* Go through pending forget requests and free them */
> -	spin_lock(&fsvq->lock);
> -	while (1) {
> -		forget = list_first_entry_or_null(&fsvq->queued_reqs,
> -					struct virtio_fs_forget, list);
> -		if (!forget)
> -			break;
> -		list_del(&forget->list);
> -		kfree(forget);
> -	}
> -
> -	spin_unlock(&fsvq->lock);
> -
> -	/* Wait for in flight requests to finish.*/
> -	while (1) {
> -		spin_lock(&fsvq->lock);
> -		if (!fsvq->in_flight) {
> -			spin_unlock(&fsvq->lock);
> -			break;
> -		}
> -		spin_unlock(&fsvq->lock);
> -		usleep_range(1000, 2000);
> -	}
> -}
> -
>  const static struct fuse_iqueue_ops virtio_fs_fiq_ops = {
>  	.wake_forget_and_unlock		= virtio_fs_wake_forget_and_unlock,
>  	.wake_interrupt_and_unlock	= virtio_fs_wake_interrupt_and_unlock,
> @@ -988,7 +1007,7 @@ static void virtio_kill_sb(struct super_block *sb)
>  	spin_lock(&fsvq->lock);
>  	fsvq->connected = false;
>  	spin_unlock(&fsvq->lock);
> -	virtio_fs_flush_hiprio_queue(fsvq);
> +	virtio_fs_drain_all_queues(vfs);
>  
>  	fuse_kill_sb_anon(sb);
>  	virtio_fs_free_devs(vfs);
> 
