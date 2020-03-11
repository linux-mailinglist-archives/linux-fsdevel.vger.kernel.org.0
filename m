Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D1F31181F4F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Mar 2020 18:24:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730385AbgCKRYl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 11 Mar 2020 13:24:41 -0400
Received: from out30-54.freemail.mail.aliyun.com ([115.124.30.54]:44082 "EHLO
        out30-54.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730195AbgCKRYk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 11 Mar 2020 13:24:40 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04407;MF=bo.liu@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0TsK.c7b_1583947470;
Received: from rsjd01523.et2sqa(mailfrom:bo.liu@linux.alibaba.com fp:SMTPD_---0TsK.c7b_1583947470)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 12 Mar 2020 01:24:36 +0800
Date:   Thu, 12 Mar 2020 01:24:30 +0800
From:   Liu Bo <bo.liu@linux.alibaba.com>
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvdimm@lists.01.org, virtio-fs@redhat.com, miklos@szeredi.hu,
        stefanha@redhat.com, dgilbert@redhat.com, mst@redhat.com
Subject: Re: [PATCH 20/20] fuse,virtiofs: Add logic to free up a memory range
Message-ID: <20200311172429.wmiflrlube3k2rkw@rsjd01523.et2sqa>
Reply-To: bo.liu@linux.alibaba.com
References: <20200304165845.3081-1-vgoyal@redhat.com>
 <20200304165845.3081-21-vgoyal@redhat.com>
 <20200311051641.l6gonmmyb4o5rcrb@rsjd01523.et2sqa>
 <20200311125923.GA83257@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200311125923.GA83257@redhat.com>
User-Agent: NeoMutt/20180223
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Mar 11, 2020 at 08:59:23AM -0400, Vivek Goyal wrote:
> On Wed, Mar 11, 2020 at 01:16:42PM +0800, Liu Bo wrote:
> 
> [..]
> > > @@ -719,6 +723,7 @@ void fuse_conn_put(struct fuse_conn *fc)
> > >  	if (refcount_dec_and_test(&fc->count)) {
> > >  		struct fuse_iqueue *fiq = &fc->iq;
> > >  
> > > +		flush_delayed_work(&fc->dax_free_work);
> > 
> > Today while debugging another case, I realized that flushing work here
> > at the very last fuse_conn_put() is a bit too late, here's my analysis,
> > 
> >          umount                                                   kthread
> > 
> > deactivate_locked_super
> >   ->virtio_kill_sb                                            try_to_free_dmap_chunks
> >     ->generic_shutdown_super                                    ->igrab()
> >                                                                 ...
> >      ->evict_inodes()  -> check all inodes' count
> >      ->fuse_conn_put                                            ->iput
> >  ->virtio_fs_free_devs
> >    ->fuse_dev_free
> >      ->fuse_conn_put // vq1
> >    ->fuse_dev_free
> >      ->fuse_conn_put // vq2
> >        ->flush_delayed_work
> > 
> > The above can end up with a warning message reported by evict_inodes()
> > about stable inodes.
> 
> Hi Liu Bo,
> 
> Which warning is that? Can you point me to it in code.
>

Hmm, it was actually in generic_shutdow_super,
---
              printk("VFS: Busy inodes after unmount of %s. "
                           "Self-destruct in 5 seconds.  Have a nice day...\n",
---

> > So I think it's necessary to put either
> > cancel_delayed_work_sync() or flush_delayed_work() before going to
> > generic_shutdown_super().
> 
> In general I agree that shutting down memory range freeing worker
> earling in unmount/shutdown sequence makes sense. It does not seem
> to help to let it run while filesystem is going away. How about following
> patch.
> 
> ---
>  fs/fuse/inode.c     |    1 -
>  fs/fuse/virtio_fs.c |    5 +++++
>  2 files changed, 5 insertions(+), 1 deletion(-)
> 
> Index: redhat-linux/fs/fuse/virtio_fs.c
> ===================================================================
> --- redhat-linux.orig/fs/fuse/virtio_fs.c	2020-03-10 14:11:10.970284651 -0400
> +++ redhat-linux/fs/fuse/virtio_fs.c	2020-03-11 08:27:08.103330039 -0400
> @@ -1295,6 +1295,11 @@ static void virtio_kill_sb(struct super_
>  	vfs = fc->iq.priv;
>  	fsvq = &vfs->vqs[VQ_HIPRIO];
>  
> +	/* Stop dax worker. Soon evict_inodes() will be called which will
> +	 * free all memory ranges belonging to all inodes.
> +	 */
> +	flush_delayed_work(&fc->dax_free_work);
> +
>  	/* Stop forget queue. Soon destroy will be sent */
>  	spin_lock(&fsvq->lock);
>  	fsvq->connected = false;
> Index: redhat-linux/fs/fuse/inode.c
> ===================================================================
> --- redhat-linux.orig/fs/fuse/inode.c	2020-03-10 09:13:35.132565666 -0400
> +++ redhat-linux/fs/fuse/inode.c	2020-03-11 08:22:02.685330039 -0400
> @@ -723,7 +723,6 @@ void fuse_conn_put(struct fuse_conn *fc)
>  	if (refcount_dec_and_test(&fc->count)) {
>  		struct fuse_iqueue *fiq = &fc->iq;
>  
> -		flush_delayed_work(&fc->dax_free_work);
>  		if (fc->dax_dev)
>  			fuse_free_dax_mem_ranges(&fc->free_ranges);
>  		if (fiq->ops->release)

Looks good, it should be safe now, but I feel like
cancel_delayed_work_sync() would be a good alternative for "stop dax
worker".

Reviewed-by: Liu Bo <bo.liu@linux.alibaba.com>

Fine with either folding directly or a new patch, thanks for fixing it.

thanks,
-liubo
