Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F531344F8E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Mar 2021 20:02:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232347AbhCVTCQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 22 Mar 2021 15:02:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:59584 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232156AbhCVTCA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 22 Mar 2021 15:02:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616439719;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qluoECxq2K7G/BfO7M0nYnXwwyId6s6ooDe9jCbuw5I=;
        b=ZFUtGc11OUmgEbFT05tBBfb0qPFS5pJ9a3kO3i3ceZwjwKqm7aT5vwNhPKV7pkXiJ+MOSv
        Iq5rmaZEGoRJeDPfBoQb01THWbv+Cv34B8APJn0U9c2Mcu2ciiU0z2i6xtmj0g544RoyfN
        G7JfcYU2PwA2aCa7Fpv+l2L6U89Cm6U=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-31-XNqlDppeMt6bwi6ecrEHOA-1; Mon, 22 Mar 2021 15:01:57 -0400
X-MC-Unique: XNqlDppeMt6bwi6ecrEHOA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 39EEB8189C7;
        Mon, 22 Mar 2021 19:01:56 +0000 (UTC)
Received: from horse.redhat.com (ovpn-114-132.rdu2.redhat.com [10.10.114.132])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9E0461835B;
        Mon, 22 Mar 2021 19:01:45 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 1F839220BCF; Mon, 22 Mar 2021 15:01:45 -0400 (EDT)
Date:   Mon, 22 Mar 2021 15:01:45 -0400
From:   Vivek Goyal <vgoyal@redhat.com>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Connor Kuehl <ckuehl@redhat.com>, virtio-fs@redhat.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, stefanha@redhat.com,
        jasowang@redhat.com, mst@redhat.com
Subject: Re: [PATCH 2/3] virtiofs: split requests that exceed virtqueue size
Message-ID: <20210322190145.GF446288@redhat.com>
References: <20210318135223.1342795-1-ckuehl@redhat.com>
 <20210318135223.1342795-3-ckuehl@redhat.com>
 <YFNvH8w4l7WyEMyr@miu.piliscsaba.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YFNvH8w4l7WyEMyr@miu.piliscsaba.redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Mar 18, 2021 at 04:17:51PM +0100, Miklos Szeredi wrote:
> On Thu, Mar 18, 2021 at 08:52:22AM -0500, Connor Kuehl wrote:
> > If an incoming FUSE request can't fit on the virtqueue, the request is
> > placed onto a workqueue so a worker can try to resubmit it later where
> > there will (hopefully) be space for it next time.
> > 
> > This is fine for requests that aren't larger than a virtqueue's maximum
> > capacity. However, if a request's size exceeds the maximum capacity of
> > the virtqueue (even if the virtqueue is empty), it will be doomed to a
> > life of being placed on the workqueue, removed, discovered it won't fit,
> > and placed on the workqueue yet again.
> > 
> > Furthermore, from section 2.6.5.3.1 (Driver Requirements: Indirect
> > Descriptors) of the virtio spec:
> > 
> >   "A driver MUST NOT create a descriptor chain longer than the Queue
> >   Size of the device."
> > 
> > To fix this, limit the number of pages FUSE will use for an overall
> > request. This way, each request can realistically fit on the virtqueue
> > when it is decomposed into a scattergather list and avoid violating
> > section 2.6.5.3.1 of the virtio spec.
> 
> I removed the conditional compilation and renamed the limit.  Also made
> virtio_fs_get_tree() bail out if it hit the WARN_ON().  Updated patch below.
> 
> The virtio_ring patch in this series should probably go through the respective
> subsystem tree.
> 
> 
> Thanks,
> Miklos
> 
> ---
> From: Connor Kuehl <ckuehl@redhat.com>
> Subject: virtiofs: split requests that exceed virtqueue size
> Date: Thu, 18 Mar 2021 08:52:22 -0500
> 
> If an incoming FUSE request can't fit on the virtqueue, the request is
> placed onto a workqueue so a worker can try to resubmit it later where
> there will (hopefully) be space for it next time.
> 
> This is fine for requests that aren't larger than a virtqueue's maximum
> capacity.  However, if a request's size exceeds the maximum capacity of the
> virtqueue (even if the virtqueue is empty), it will be doomed to a life of
> being placed on the workqueue, removed, discovered it won't fit, and placed
> on the workqueue yet again.
> 
> Furthermore, from section 2.6.5.3.1 (Driver Requirements: Indirect
> Descriptors) of the virtio spec:
> 
>   "A driver MUST NOT create a descriptor chain longer than the Queue
>   Size of the device."
> 
> To fix this, limit the number of pages FUSE will use for an overall
> request.  This way, each request can realistically fit on the virtqueue
> when it is decomposed into a scattergather list and avoid violating section
> 2.6.5.3.1 of the virtio spec.
> 
> Signed-off-by: Connor Kuehl <ckuehl@redhat.com>
> Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
> ---

Looks good to me.

Reviewed-by: Vivek Goyal <vgoyal@redhat.com>

Vivek

>  fs/fuse/fuse_i.h    |    3 +++
>  fs/fuse/inode.c     |    3 ++-
>  fs/fuse/virtio_fs.c |   19 +++++++++++++++++--
>  3 files changed, 22 insertions(+), 3 deletions(-)
> 
> --- a/fs/fuse/fuse_i.h
> +++ b/fs/fuse/fuse_i.h
> @@ -555,6 +555,9 @@ struct fuse_conn {
>  	/** Maxmum number of pages that can be used in a single request */
>  	unsigned int max_pages;
>  
> +	/** Constrain ->max_pages to this value during feature negotiation */
> +	unsigned int max_pages_limit;
> +
>  	/** Input queue */
>  	struct fuse_iqueue iq;
>  
> --- a/fs/fuse/inode.c
> +++ b/fs/fuse/inode.c
> @@ -712,6 +712,7 @@ void fuse_conn_init(struct fuse_conn *fc
>  	fc->pid_ns = get_pid_ns(task_active_pid_ns(current));
>  	fc->user_ns = get_user_ns(user_ns);
>  	fc->max_pages = FUSE_DEFAULT_MAX_PAGES_PER_REQ;
> +	fc->max_pages_limit = FUSE_MAX_MAX_PAGES;
>  
>  	INIT_LIST_HEAD(&fc->mounts);
>  	list_add(&fm->fc_entry, &fc->mounts);
> @@ -1040,7 +1041,7 @@ static void process_init_reply(struct fu
>  				fc->abort_err = 1;
>  			if (arg->flags & FUSE_MAX_PAGES) {
>  				fc->max_pages =
> -					min_t(unsigned int, FUSE_MAX_MAX_PAGES,
> +					min_t(unsigned int, fc->max_pages_limit,
>  					max_t(unsigned int, arg->max_pages, 1));
>  			}
>  			if (IS_ENABLED(CONFIG_FUSE_DAX) &&
> --- a/fs/fuse/virtio_fs.c
> +++ b/fs/fuse/virtio_fs.c
> @@ -18,6 +18,12 @@
>  #include <linux/uio.h>
>  #include "fuse_i.h"
>  
> +/* Used to help calculate the FUSE connection's max_pages limit for a request's
> + * size. Parts of the struct fuse_req are sliced into scattergather lists in
> + * addition to the pages used, so this can help account for that overhead.
> + */
> +#define FUSE_HEADER_OVERHEAD    4
> +
>  /* List of virtio-fs device instances and a lock for the list. Also provides
>   * mutual exclusion in device removal and mounting path
>   */
> @@ -1413,9 +1419,10 @@ static int virtio_fs_get_tree(struct fs_
>  {
>  	struct virtio_fs *fs;
>  	struct super_block *sb;
> -	struct fuse_conn *fc;
> +	struct fuse_conn *fc = NULL;
>  	struct fuse_mount *fm;
> -	int err;
> +	unsigned int virtqueue_size;
> +	int err = -EIO;
>  
>  	/* This gets a reference on virtio_fs object. This ptr gets installed
>  	 * in fc->iq->priv. Once fuse_conn is going away, it calls ->put()
> @@ -1427,6 +1434,10 @@ static int virtio_fs_get_tree(struct fs_
>  		return -EINVAL;
>  	}
>  
> +	virtqueue_size = virtqueue_get_vring_size(fs->vqs[VQ_REQUEST].vq);
> +	if (WARN_ON(virtqueue_size <= FUSE_HEADER_OVERHEAD))
> +		goto out_err;
> +
>  	err = -ENOMEM;
>  	fc = kzalloc(sizeof(struct fuse_conn), GFP_KERNEL);
>  	if (!fc)
> @@ -1442,6 +1453,10 @@ static int virtio_fs_get_tree(struct fs_
>  	fc->delete_stale = true;
>  	fc->auto_submounts = true;
>  
> +	/* Tell FUSE to split requests that exceed the virtqueue's size */
> +	fc->max_pages_limit = min_t(unsigned int, fc->max_pages_limit,
> +				    virtqueue_size - FUSE_HEADER_OVERHEAD);
> +
>  	fsc->s_fs_info = fm;
>  	sb = sget_fc(fsc, virtio_fs_test_super, set_anon_super_fc);
>  	if (fsc->s_fs_info) {
> 

