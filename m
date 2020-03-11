Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9FC291818F4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Mar 2020 13:59:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729504AbgCKM7k (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 11 Mar 2020 08:59:40 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:54451 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729370AbgCKM7j (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 11 Mar 2020 08:59:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583931578;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=eRHGawj8EctzUWRxgMWMCKcmyXT/eFQgkAXnHzfcavw=;
        b=H1zjeY9OLBw1Y9kZwvZ3FIV1Jyn/nFI9+w/DHnDwQM8FZi8o2h6qWnpXtHbpwAVO8DRTeo
        im2/n8nQhyUNemPxNOr3BytR2dafGTbp7UIZ/WKqFOhno0ygWVk/HwmUpuO/vEqVvNs6PY
        dobCFMs5gCVk85L67j7gjRVcDYtt158=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-181-k6PJU7nPPLWeiHCzgt1RXQ-1; Wed, 11 Mar 2020 08:59:34 -0400
X-MC-Unique: k6PJU7nPPLWeiHCzgt1RXQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5B2BD100550E;
        Wed, 11 Mar 2020 12:59:32 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.18.25.210])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6C3F660C18;
        Wed, 11 Mar 2020 12:59:24 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id DD31F22021D; Wed, 11 Mar 2020 08:59:23 -0400 (EDT)
Date:   Wed, 11 Mar 2020 08:59:23 -0400
From:   Vivek Goyal <vgoyal@redhat.com>
To:     Liu Bo <bo.liu@linux.alibaba.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvdimm@lists.01.org, virtio-fs@redhat.com, miklos@szeredi.hu,
        stefanha@redhat.com, dgilbert@redhat.com, mst@redhat.com
Subject: Re: [PATCH 20/20] fuse,virtiofs: Add logic to free up a memory range
Message-ID: <20200311125923.GA83257@redhat.com>
References: <20200304165845.3081-1-vgoyal@redhat.com>
 <20200304165845.3081-21-vgoyal@redhat.com>
 <20200311051641.l6gonmmyb4o5rcrb@rsjd01523.et2sqa>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200311051641.l6gonmmyb4o5rcrb@rsjd01523.et2sqa>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Mar 11, 2020 at 01:16:42PM +0800, Liu Bo wrote:

[..]
> > @@ -719,6 +723,7 @@ void fuse_conn_put(struct fuse_conn *fc)
> >  	if (refcount_dec_and_test(&fc->count)) {
> >  		struct fuse_iqueue *fiq = &fc->iq;
> >  
> > +		flush_delayed_work(&fc->dax_free_work);
> 
> Today while debugging another case, I realized that flushing work here
> at the very last fuse_conn_put() is a bit too late, here's my analysis,
> 
>          umount                                                   kthread
> 
> deactivate_locked_super
>   ->virtio_kill_sb                                            try_to_free_dmap_chunks
>     ->generic_shutdown_super                                    ->igrab()
>                                                                 ...
>      ->evict_inodes()  -> check all inodes' count
>      ->fuse_conn_put                                            ->iput
>  ->virtio_fs_free_devs
>    ->fuse_dev_free
>      ->fuse_conn_put // vq1
>    ->fuse_dev_free
>      ->fuse_conn_put // vq2
>        ->flush_delayed_work
> 
> The above can end up with a warning message reported by evict_inodes()
> about stable inodes.

Hi Liu Bo,

Which warning is that? Can you point me to it in code.

> So I think it's necessary to put either
> cancel_delayed_work_sync() or flush_delayed_work() before going to
> generic_shutdown_super().

In general I agree that shutting down memory range freeing worker
earling in unmount/shutdown sequence makes sense. It does not seem
to help to let it run while filesystem is going away. How about following
patch.

---
 fs/fuse/inode.c     |    1 -
 fs/fuse/virtio_fs.c |    5 +++++
 2 files changed, 5 insertions(+), 1 deletion(-)

Index: redhat-linux/fs/fuse/virtio_fs.c
===================================================================
--- redhat-linux.orig/fs/fuse/virtio_fs.c	2020-03-10 14:11:10.970284651 -0400
+++ redhat-linux/fs/fuse/virtio_fs.c	2020-03-11 08:27:08.103330039 -0400
@@ -1295,6 +1295,11 @@ static void virtio_kill_sb(struct super_
 	vfs = fc->iq.priv;
 	fsvq = &vfs->vqs[VQ_HIPRIO];
 
+	/* Stop dax worker. Soon evict_inodes() will be called which will
+	 * free all memory ranges belonging to all inodes.
+	 */
+	flush_delayed_work(&fc->dax_free_work);
+
 	/* Stop forget queue. Soon destroy will be sent */
 	spin_lock(&fsvq->lock);
 	fsvq->connected = false;
Index: redhat-linux/fs/fuse/inode.c
===================================================================
--- redhat-linux.orig/fs/fuse/inode.c	2020-03-10 09:13:35.132565666 -0400
+++ redhat-linux/fs/fuse/inode.c	2020-03-11 08:22:02.685330039 -0400
@@ -723,7 +723,6 @@ void fuse_conn_put(struct fuse_conn *fc)
 	if (refcount_dec_and_test(&fc->count)) {
 		struct fuse_iqueue *fiq = &fc->iq;
 
-		flush_delayed_work(&fc->dax_free_work);
 		if (fc->dax_dev)
 			fuse_free_dax_mem_ranges(&fc->free_ranges);
 		if (fiq->ops->release)

