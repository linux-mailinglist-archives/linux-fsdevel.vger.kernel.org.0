Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74D7C1D9A41
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 May 2020 16:44:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729000AbgESOoM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 May 2020 10:44:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:43448 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726504AbgESOoL (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 May 2020 10:44:11 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4CA4E2072C;
        Tue, 19 May 2020 14:44:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589899450;
        bh=FyNrucG90k/u+wjGUAus0fd6+/LPZRGT39Lx9ni2HQw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GYUaiMwHDvpfj13IpqHgKaP9URgf4qSXPphSwveLc+X8d0mlcEDUlJ9T2Uml087Hc
         TkwRz9daK84aaH6n1En9/tsGOITBTblNwzzexAsLX4WnwdvWXJ9+qkGEgdWxfANcxB
         z8ggNWRLLZVtf/oFtAF+oxD9dtDqT02+nTtANyTE=
Date:   Tue, 19 May 2020 16:44:08 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     axboe@kernel.dk, viro@zeniv.linux.org.uk, bvanassche@acm.org,
        rostedt@goodmis.org, mingo@redhat.com, jack@suse.cz,
        ming.lei@redhat.com, nstange@suse.de, akpm@linux-foundation.org,
        mhocko@suse.com, yukuai3@huawei.com, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Omar Sandoval <osandov@fb.com>,
        Hannes Reinecke <hare@suse.com>,
        Michal Hocko <mhocko@kernel.org>,
        syzbot+603294af2d01acfdd6da@syzkaller.appspotmail.com
Subject: Re: [PATCH v5 5/7] blktrace: fix debugfs use after free
Message-ID: <20200519144408.GA737365@kroah.com>
References: <20200516031956.2605-1-mcgrof@kernel.org>
 <20200516031956.2605-6-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200516031956.2605-6-mcgrof@kernel.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, May 16, 2020 at 03:19:54AM +0000, Luis Chamberlain wrote:
>  struct dentry *blk_debugfs_root;
> +struct dentry *blk_debugfs_bsg = NULL;

checkpatch didn't complain about "= NULL;"?

> +
> +/**
> + * enum blk_debugfs_dir_type - block device debugfs directory type
> + * @BLK_DBG_DIR_BASE: the block device debugfs_dir exists on the base
> + * 	system <system-debugfs-dir>/block/ debugfs directory.
> + * @BLK_DBG_DIR_BSG: the block device debugfs_dir is under the directory
> + * 	<system-debugfs-dir>/block/bsg/
> + */
> +enum blk_debugfs_dir_type {
> +	BLK_DBG_DIR_BASE = 1,
> +	BLK_DBG_DIR_BSG,
> +};
>  
>  void blk_debugfs_register(void)
>  {
>  	blk_debugfs_root = debugfs_create_dir("block", NULL);
>  }
> +
> +static struct dentry *queue_get_base_dir(enum blk_debugfs_dir_type type)
> +{
> +	switch (type) {
> +	case BLK_DBG_DIR_BASE:
> +		return blk_debugfs_root;
> +	case BLK_DBG_DIR_BSG:
> +		return blk_debugfs_bsg;
> +	}
> +	return NULL;
> +}

This "function" is used once, here:

> +static void queue_debugfs_register_type(struct request_queue *q,
> +					const char *name,
> +					enum blk_debugfs_dir_type type)
> +{
> +	struct dentry *base_dir = queue_get_base_dir(type);

And it could be a simple if statement instead.

Oh well, I don't have to maintain this :)

> +
> +	q->debugfs_dir = debugfs_create_dir(name, base_dir);
> +}
> +
> +/**
> + * blk_queue_debugfs_register - register the debugfs_dir for the block device
> + * @q: the associated request_queue of the block device
> + * @name: the name of the block device exposed
> + *
> + * This is used to create the debugfs_dir used by the block layer and blktrace.
> + * Drivers which use any of the *add_disk*() calls or variants have this called
> + * automatically for them. This directory is removed automatically on
> + * blk_release_queue() once the request_queue reference count reaches 0.
> + */
> +void blk_queue_debugfs_register(struct request_queue *q, const char *name)
> +{
> +	queue_debugfs_register_type(q, name, BLK_DBG_DIR_BASE);
> +}
> +EXPORT_SYMBOL_GPL(blk_queue_debugfs_register);
> +
> +/**
> + * blk_queue_debugfs_unregister - remove the debugfs_dir for the block device
> + * @q: the associated request_queue of the block device
> + *
> + * Removes the debugfs_dir for the request_queue on the associated block device.
> + * This is handled for you on blk_release_queue(), and that should only be
> + * called once.
> + *
> + * Since we don't care where the debugfs_dir was created this is used for all
> + * types of of enum blk_debugfs_dir_type.
> + */
> +void blk_queue_debugfs_unregister(struct request_queue *q)
> +{
> +	debugfs_remove_recursive(q->debugfs_dir);
> +}

Why is register needed to be exported, but unregister does not?  Does
some driver not properly clean things up?

> +
> +static struct dentry *queue_debugfs_symlink_type(struct request_queue *q,
> +						 const char *src,
> +						 const char *dst,
> +						 enum blk_debugfs_dir_type type)
> +{
> +	struct dentry *dentry = ERR_PTR(-EINVAL);
> +	char *dir_dst = NULL;
> +
> +	switch (type) {
> +	case BLK_DBG_DIR_BASE:
> +		if (dst)
> +			dir_dst = kasprintf(GFP_KERNEL, "%s", dst);
> +		else if (!IS_ERR_OR_NULL(q->debugfs_dir))
> +			dir_dst = kasprintf(GFP_KERNEL, "%s",
> +					    q->debugfs_dir->d_name.name);

There really is no other way to get the name of the directory other than
from the dentry?  It's not in the queue itself somewhere?

Anyway, not a big deal, just trying to not expose debugfs internals
here.

> +		else
> +			goto out;
> +		break;
> +	case BLK_DBG_DIR_BSG:
> +		if (dst)
> +			dir_dst = kasprintf(GFP_KERNEL, "bsg/%s", dst);
> +		else
> +			goto out;
> +		break;
> +	}
> +
> +	/*
> +	 * The base block debugfs directory is always used for the symlinks,
> +	 * their target is what changes.
> +	 */
> +	dentry = debugfs_create_symlink(src, blk_debugfs_root, dir_dst);
> +	kfree(dir_dst);
> +out:
> +	return dentry;
> +}
> +
> +/**
> + * blk_queue_debugfs_symlink - symlink to the real block device debugfs_dir
> + * @q: the request queue where we know the debugfs_dir exists or will exist
> + *     eventually. Cannot be NULL.
> + * @src: name of the exposed device we wish to associate to the block device
> + * @dst: the name of the directory to which we want to symlink to, may be NULL
> + *	 if you do not know what this may be, but only if your base block device
> + *	 is not bsg. If you set this to NULL, we will have no other option but
> + *	 to look at the request_queue to infer the name, but you must ensure
> + *	 it is already be set, be mindful of asynchronous probes.
> + *
> + * Some devices don't have a request_queue of their own, however, they have an
> + * association to one and have historically supported using the same
> + * debugfs_dir which has been used to represent the whole disk for blktrace
> + * functionality. Such is the case for partitions and for scsi-generic devices.
> + * They share the same request_queue and debugfs_dir as with the whole disk for
> + * blktrace purposes.  This helper allows such association to be made explicit
> + * and enable blktrace functionality for them. scsi-generic devices representing
> + * scsi device such as block, cdrom, tape, media changer register their own
> + * debug_dir already and share the same request_queue as with scsi-generic, as
> + * such the respective scsi-generic debugfs_dir is just a symlink to these
> + * driver's debugfs_dir.
> + *
> + * To remove use debugfs_remove() on the symlink dentry returned by this
> + * function. The block layer will not clean this up for you, you must remove
> + * it yourself in case of device removal.
> + */
> +struct dentry *blk_queue_debugfs_symlink(struct request_queue *q,
> +					 const char *src,
> +					 const char *dst)
> +{
> +	return queue_debugfs_symlink_type(q, src, dst, BLK_DBG_DIR_BASE);
> +}
> +EXPORT_SYMBOL_GPL(blk_queue_debugfs_symlink);
> +
> +#ifdef CONFIG_BLK_DEV_BSG
> +
> +void blk_debugfs_register_bsg(void)
> +{
> +	blk_debugfs_bsg = debugfs_create_dir("bsg", blk_debugfs_root);
> +}
> +
> +/**
> + * blk_queue_debugfs_register_bsg - create the debugfs_dir for bsg block devices
> + * @q: the associated request_queue of the block device
> + * @name: the name of the block device exposed
> + *
> + * This is used to create the debugfs_dir used by the Block layer SCSI generic
> + * (bsg) driver. This is to be used only by the scsi-generic driver on behalf
> + * of scsi devices which work as scsi controllers or transports.
> + *
> + * This directory is cleaned up for all drivers automatically on
> + * blk_release_queue() once the request_queue reference count reaches 0.
> + */
> +void blk_queue_debugfs_register_bsg(struct request_queue *q, const char *name)
> +{
> +	queue_debugfs_register_type(q, name, BLK_DBG_DIR_BSG);
> +}
> +EXPORT_SYMBOL_GPL(blk_queue_debugfs_register_bsg);
> +
> +/**
> + * blk_queue_debugfs_symlink_bsg - symlink to the bsg debugfs_dir
> + * @q: the request queue where we know the debugfs_dir exists or will exist
> + *     eventually. Cannot be NULL.
> + * @src: name of the scsi-generic device we wish to associate to the bsg
> + * 	request_queue.
> + * @dst: the name of the bsg request_queue debugfs_dir to which we want to
> + *	 symlink to. This cannot be NULL.
> + *
> + * This is used by scsi-generic devices representing raid controllers /
> + * transport drivers.
> + */
> +struct dentry *blk_queue_debugfs_bsg_symlink(struct request_queue *q,
> +					     const char *src,
> +					     const char *dst)
> +{
> +	return queue_debugfs_symlink_type(q, src, dst, BLK_DBG_DIR_BSG);
> +}
> +EXPORT_SYMBOL_GPL(blk_queue_debugfs_bsg_symlink);
> +#endif /* CONFIG_BLK_DEV_BSG */
> diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
> index 96b7a35c898a..08edc3a54114 100644
> --- a/block/blk-mq-debugfs.c
> +++ b/block/blk-mq-debugfs.c
> @@ -822,9 +822,6 @@ void blk_mq_debugfs_register(struct request_queue *q)
>  	struct blk_mq_hw_ctx *hctx;
>  	int i;
>  
> -	q->debugfs_dir = debugfs_create_dir(kobject_name(q->kobj.parent),
> -					    blk_debugfs_root);
> -
>  	debugfs_create_files(q->debugfs_dir, q, blk_mq_debugfs_queue_attrs);
>  
>  	/*
> @@ -855,9 +852,7 @@ void blk_mq_debugfs_register(struct request_queue *q)
>  
>  void blk_mq_debugfs_unregister(struct request_queue *q)
>  {
> -	debugfs_remove_recursive(q->debugfs_dir);
>  	q->sched_debugfs_dir = NULL;
> -	q->debugfs_dir = NULL;
>  }
>  
>  static void blk_mq_debugfs_register_ctx(struct blk_mq_hw_ctx *hctx,
> diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
> index 561624d4cc4e..4e0c00a88c99 100644
> --- a/block/blk-sysfs.c
> +++ b/block/blk-sysfs.c
> @@ -918,6 +918,7 @@ static void blk_release_queue(struct kobject *kobj)
>  
>  	blk_trace_shutdown(q);
>  
> +	blk_queue_debugfs_unregister(q);
>  	if (queue_is_mq(q))
>  		blk_mq_debugfs_unregister(q);
>  
> @@ -989,6 +990,8 @@ int blk_register_queue(struct gendisk *disk)
>  		goto unlock;
>  	}
>  
> +	blk_queue_debugfs_register(q, kobject_name(q->kobj.parent));
> +
>  	if (queue_is_mq(q)) {
>  		__blk_mq_register_dev(dev, q);
>  		blk_mq_debugfs_register(q);
> diff --git a/block/blk.h b/block/blk.h
> index ee309233f95e..300b8526066b 100644
> --- a/block/blk.h
> +++ b/block/blk.h
> @@ -460,10 +460,26 @@ int bio_add_hw_page(struct request_queue *q, struct bio *bio,
>  
>  #ifdef CONFIG_DEBUG_FS
>  void blk_debugfs_register(void);
> +void blk_queue_debugfs_unregister(struct request_queue *q);
> +void blk_part_debugfs_register(struct hd_struct *p, const char *name);
> +void blk_part_debugfs_unregister(struct hd_struct *p);
>  #else
>  static inline void blk_debugfs_register(void)
>  {
>  }
> +
> +static inline void blk_queue_debugfs_unregister(struct request_queue *q)
> +{
> +}
> +
> +static inline void blk_part_debugfs_register(struct hd_struct *p,
> +					     const char *name)
> +{
> +}
> +
> +static inline void blk_part_debugfs_unregister(struct hd_struct *p)
> +{
> +}
>  #endif /* CONFIG_DEBUG_FS */
>  
>  #endif /* BLK_INTERNAL_H */
> diff --git a/block/bsg.c b/block/bsg.c
> index d7bae94b64d9..bfb1036858c4 100644
> --- a/block/bsg.c
> +++ b/block/bsg.c
> @@ -503,6 +503,8 @@ static int __init bsg_init(void)
>  	if (ret)
>  		goto unregister_chrdev;
>  
> +	blk_debugfs_register_bsg();
> +
>  	printk(KERN_INFO BSG_DESCRIPTION " version " BSG_VERSION
>  	       " loaded (major %d)\n", bsg_major);
>  	return 0;
> diff --git a/block/partitions/core.c b/block/partitions/core.c
> index 297004fd2264..4d2a130e6055 100644
> --- a/block/partitions/core.c
> +++ b/block/partitions/core.c
> @@ -10,6 +10,7 @@
>  #include <linux/vmalloc.h>
>  #include <linux/blktrace_api.h>
>  #include <linux/raid/detect.h>
> +#include <linux/debugfs.h>
>  #include "check.h"
>  
>  static int (*check_part[])(struct parsed_partitions *) = {
> @@ -320,6 +321,9 @@ void delete_partition(struct gendisk *disk, struct hd_struct *part)
>  	 *  we have to hold the disk device
>  	 */
>  	get_device(disk_to_dev(part_to_disk(part)));
> +#ifdef CONFIG_DEBUG_FS
> +	debugfs_remove(part->debugfs_sym);
> +#endif

Why is the #ifdef needed?  It shouldn't be.

And why not recursive?

>  	rcu_assign_pointer(ptbl->part[part->partno], NULL);
>  	kobject_put(part->holder_dir);
>  	device_del(part_to_dev(part));
> @@ -460,6 +464,11 @@ static struct hd_struct *add_partition(struct gendisk *disk, int partno,
>  	/* everything is up and running, commence */
>  	rcu_assign_pointer(ptbl->part[partno], p);
>  
> +#ifdef CONFIG_DEBUG_FS
> +	p->debugfs_sym = blk_queue_debugfs_symlink(disk->queue, dev_name(pdev),
> +						   disk->disk_name);
> +#endif

Again, no #ifdef should be needed here, just provide the "empty"
function in the .h file.

You know this stuff :)

> +
>  	/* suppress uevent if the disk suppresses it */
>  	if (!dev_get_uevent_suppress(ddev))
>  		kobject_uevent(&pdev->kobj, KOBJ_ADD);
> diff --git a/drivers/scsi/ch.c b/drivers/scsi/ch.c
> index cb74ab1ae5a4..5dfabc04bfef 100644
> --- a/drivers/scsi/ch.c
> +++ b/drivers/scsi/ch.c
> @@ -971,6 +971,7 @@ static int ch_probe(struct device *dev)
>  
>  	mutex_unlock(&ch->lock);
>  	dev_set_drvdata(dev, ch);
> +	blk_queue_debugfs_register(sd->request_queue, dev_name(class_dev));
>  	sdev_printk(KERN_INFO, sd, "Attached scsi changer %s\n", ch->name);
>  
>  	return 0;
> diff --git a/drivers/scsi/sg.c b/drivers/scsi/sg.c
> index 20472aaaf630..6fa201086e59 100644
> --- a/drivers/scsi/sg.c
> +++ b/drivers/scsi/sg.c
> @@ -47,6 +47,7 @@ static int sg_version_num = 30536;	/* 2 digits for each component */
>  #include <linux/ratelimit.h>
>  #include <linux/uio.h>
>  #include <linux/cred.h> /* for sg_check_file_access() */
> +#include <linux/debugfs.h>
>  
>  #include "scsi.h"
>  #include <scsi/scsi_dbg.h>
> @@ -169,6 +170,10 @@ typedef struct sg_device { /* holds the state of each scsi generic device */
>  	struct gendisk *disk;
>  	struct cdev * cdev;	/* char_dev [sysfs: /sys/cdev/major/sg<n>] */
>  	struct kref d_ref;
> +#ifdef CONFIG_DEBUG_FS
> +	bool debugfs_set;
> +	struct dentry *debugfs_sym;
> +#endif
>  } Sg_device;
>  
>  /* tasklet or soft irq callback */
> @@ -914,6 +919,72 @@ static int put_compat_request_table(struct compat_sg_req_info __user *o,
>  }
>  #endif
>  
> +#ifdef CONFIG_DEBUG_FS
> +/*
> + * For scsi-generic devices like TYPE_DISK will re-use the scsi_device
> + * request_queue on their driver for their disk and later device_add_disk() it,
> + * we want its respective scsi-generic debugfs_dir to just be a symlink to the
> + * one created on the real scsi device probe.
> + *
> + * We use this on the ioctl path instead of sg_add_device() since some driver
> + * probes can run asynchronously. Such is the case for scsi devices of
> + * TYPE_DISK, and the class interface currently has no callbacks once a device
> + * driver probe has completed its probe. We don't use wait_for_device_probe()
> + * on sg_add_device() as that would defeat the purpose of using asynchronous
> + * probe.
> + */
> +static void sg_init_blktrace_setup(Sg_device *sdp)
> +{
> +	struct scsi_device *scsidp = sdp->device;
> +	struct device *scsi_dev = &scsidp->sdev_gendev;
> +	struct gendisk *sg_disk = sdp->disk;
> +	struct request_queue *q = scsidp->request_queue;
> +
> +	/*
> +	 * Although debugfs is used for debugging purposes and we
> +	 * typically don't care about the return value, we do here
> +	 * because we use it for userspace to ensure blktrace works.
> +	 *
> +	 * Instead of always just checking for the return value though,
> +	 * just try setting this once, if the first time failed we don't
> +	 * try again.
> +	 */
> +	if (sdp->debugfs_set)
> +		return;
> +
> +	switch (sdp->device->type) {
> +	case TYPE_RAID:
> +		/*
> +		 * We do the registration for bsg here to keep bsg scsi_device
> +		 * opaque. If bsg is disabled we just create the debugfs_dir on
> +		 * the base block debugfs_dir and scsi-generic symlinks to it.
> +		 */
> +		blk_queue_debugfs_register_bsg(q, dev_name(scsi_dev));
> +		sdp->debugfs_sym =
> +			blk_queue_debugfs_bsg_symlink(q,
> +						      sg_disk->disk_name,
> +						      dev_name(scsi_dev));
> +		break;
> +	default:
> +		/*
> +		 * We don't know scsi_device probed device name (this is
> +		 * different from the scsi_device name). This is opaque to
> +		 * scsi-generic, so we use the request_queue to infer the name
> +		 * based on the set debugfs_dir.
> +		 */
> +		sdp->debugfs_sym = blk_queue_debugfs_symlink(q,
> +							     sg_disk->disk_name,
> +							     NULL);
> +		break;
> +	}
> +	sdp->debugfs_set = true;
> +}
> +#else
> +static void sg_init_blktrace_setup(Sg_device *sdp)
> +{
> +}
> +#endif
> +
>  static long
>  sg_ioctl_common(struct file *filp, Sg_device *sdp, Sg_fd *sfp,
>  		unsigned int cmd_in, void __user *p)
> @@ -1117,6 +1188,7 @@ sg_ioctl_common(struct file *filp, Sg_device *sdp, Sg_fd *sfp,
>  		return put_user(max_sectors_bytes(sdp->device->request_queue),
>  				ip);
>  	case BLKTRACESETUP:
> +		sg_init_blktrace_setup(sdp);
>  		return blk_trace_setup(sdp->device->request_queue,
>  				       sdp->disk->disk_name,
>  				       MKDEV(SCSI_GENERIC_MAJOR, sdp->index),
> @@ -1644,6 +1716,9 @@ sg_remove_device(struct device *cl_dev, struct class_interface *cl_intf)
>  
>  	sysfs_remove_link(&scsidp->sdev_gendev.kobj, "generic");
>  	device_destroy(sg_sysfs_class, MKDEV(SCSI_GENERIC_MAJOR, sdp->index));
> +#ifdef CONFIG_DEBUG_FS
> +	debugfs_remove(sdp->debugfs_sym);
> +#endif

Again, no need for the #ifdef.

If you are worried about the variable not being there, just always put
it in the structure, it's only a pointer, for something that there are
not a lot of, right?

thanks,

greg k-h
