Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D37BBB6874
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Sep 2019 18:48:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387732AbfIRQsl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 Sep 2019 12:48:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59392 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387709AbfIRQsl (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 Sep 2019 12:48:41 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 6904A18C4275
        for <linux-fsdevel@vger.kernel.org>; Wed, 18 Sep 2019 16:48:41 +0000 (UTC)
Received: from work-vm (unknown [10.36.118.45])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 505C619C70;
        Wed, 18 Sep 2019 16:48:34 +0000 (UTC)
Date:   Wed, 18 Sep 2019 17:48:32 +0100
From:   "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To:     Stefan Hajnoczi <stefanha@redhat.com>
Cc:     Miklos Szeredi <mszeredi@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>, vgoyal@redhat.com,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] virtio-fs: rename num_queues to num_request_queues
Message-ID: <20190918164832.GH2947@work-vm>
References: <20190917114457.886-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190917114457.886-1-stefanha@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.62]); Wed, 18 Sep 2019 16:48:41 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

* Stefan Hajnoczi (stefanha@redhat.com) wrote:
> The final version of the virtio-fs device specification renamed the
> num_queues field to num_request_queues.  The semantics are unchanged but
> this name is clearer.
> 
> Use the new name in the code.
> 
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>

Consistent with the latest version that's just passed the voting;
(see
https://lists.oasis-open.org/archives/virtio-dev/201908/msg00113.html )
so:


Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

> ---
> Feel free to squash this patch.
> ---
>  include/uapi/linux/virtio_fs.h |  2 +-
>  fs/fuse/virtio_fs.c            | 12 ++++++------
>  2 files changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/include/uapi/linux/virtio_fs.h b/include/uapi/linux/virtio_fs.h
> index b5e99c217c86..b02eb2ac3d99 100644
> --- a/include/uapi/linux/virtio_fs.h
> +++ b/include/uapi/linux/virtio_fs.h
> @@ -13,7 +13,7 @@ struct virtio_fs_config {
>  	__u8 tag[36];
>  
>  	/* Number of request queues */
> -	__u32 num_queues;
> +	__u32 num_request_queues;
>  } __attribute__((packed));
>  
>  #endif /* _UAPI_LINUX_VIRTIO_FS_H */
> diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
> index 392b9e7d9ddf..ccfa4f741f7f 100644
> --- a/fs/fuse/virtio_fs.c
> +++ b/fs/fuse/virtio_fs.c
> @@ -43,8 +43,8 @@ struct virtio_fs {
>  	struct list_head list;    /* on virtio_fs_instances */
>  	char *tag;
>  	struct virtio_fs_vq *vqs;
> -	unsigned int nvqs;            /* number of virtqueues */
> -	unsigned int num_queues;      /* number of request queues */
> +	unsigned int nvqs;               /* number of virtqueues */
> +	unsigned int num_request_queues; /* number of request queues */
>  };
>  
>  struct virtio_fs_forget {
> @@ -477,12 +477,12 @@ static int virtio_fs_setup_vqs(struct virtio_device *vdev,
>  	unsigned int i;
>  	int ret = 0;
>  
> -	virtio_cread(vdev, struct virtio_fs_config, num_queues,
> -		     &fs->num_queues);
> -	if (fs->num_queues == 0)
> +	virtio_cread(vdev, struct virtio_fs_config, num_request_queues,
> +		     &fs->num_request_queues);
> +	if (fs->num_request_queues == 0)
>  		return -EINVAL;
>  
> -	fs->nvqs = 1 + fs->num_queues;
> +	fs->nvqs = 1 + fs->num_request_queues;
>  	fs->vqs = kcalloc(fs->nvqs, sizeof(fs->vqs[VQ_HIPRIO]), GFP_KERNEL);
>  	if (!fs->vqs)
>  		return -ENOMEM;
> -- 
> 2.21.0
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
