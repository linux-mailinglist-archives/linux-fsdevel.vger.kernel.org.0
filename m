Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F23A41D9BB8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 May 2020 17:52:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729254AbgESPwN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 May 2020 11:52:13 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:33298 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728633AbgESPwN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 May 2020 11:52:13 -0400
Received: by mail-pl1-f194.google.com with SMTP id t7so56808plr.0;
        Tue, 19 May 2020 08:52:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=JpCa2t6RulyAtgA1bVNjkdVy1+wb5zQ5PrYyNnMwAc4=;
        b=rPAVczHSYkCbM9M9diO4TYDP8u7+hnuOACPUWcLJEBFZ49Exc0NFm/qPfDikEIeXkw
         6nSeePDm/ogoczYljakx3LYekZ5SVRzcA0X30b1kXWnsr2o+2XRAb6I3ndyubDcoYRU5
         aezm5SnLHK/2PjQijpMEYkqCYcG65IC0tPt2W73KHJYl0QrCHzkHql/lhBLxywYVG4ne
         qKrUx3NZTfTkOEscjdrXYwiPQ2jjHVlF8Z49QjwC9NOYcZy8EBk5PuuT3Dx/OGRufA/z
         Y1f8Xia2Wx95Do/0g05oDlPAOH0+vJ7xskBflHrSuZXfbrdErrZk1BbCHwdZswmqW7ET
         D9PA==
X-Gm-Message-State: AOAM532tM10yeMdTwUHdFOduASDsXMi7bjKCMg1auaD1JX3EAHPpZI9g
        VH2cbqMNZCAqMVzfTkB95d8=
X-Google-Smtp-Source: ABdhPJwVOGdTvvWSFzif4EYAXBukbhtPusMA3M+eA8fDw72KcTZTt4qR56b8dkvcZvkXEj5+VNUd8A==
X-Received: by 2002:a17:90a:35a7:: with SMTP id r36mr194202pjb.117.1589903532044;
        Tue, 19 May 2020 08:52:12 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id v1sm20073pjs.36.2020.05.19.08.52.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2020 08:52:11 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id 23B1A4088B; Tue, 19 May 2020 15:52:10 +0000 (UTC)
Date:   Tue, 19 May 2020 15:52:10 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Greg KH <gregkh@linuxfoundation.org>
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
Message-ID: <20200519155210.GU11244@42.do-not-panic.com>
References: <20200516031956.2605-1-mcgrof@kernel.org>
 <20200516031956.2605-6-mcgrof@kernel.org>
 <20200519144408.GA737365@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200519144408.GA737365@kroah.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, May 19, 2020 at 04:44:08PM +0200, Greg KH wrote:
> On Sat, May 16, 2020 at 03:19:54AM +0000, Luis Chamberlain wrote:
> >  struct dentry *blk_debugfs_root;
> > +struct dentry *blk_debugfs_bsg = NULL;
> 
> checkpatch didn't complain about "= NULL;"?

Will remove.

> > +static void queue_debugfs_register_type(struct request_queue *q,
> > +					const char *name,
> > +					enum blk_debugfs_dir_type type)
> > +{
> > +	struct dentry *base_dir = queue_get_base_dir(type);
> 
> And it could be a simple if statement instead.
> 
> Oh well, I don't have to maintain this :)

I'll just use that, but yeah I think its a matter of preference.

> > +/**
> > + * blk_queue_debugfs_register - register the debugfs_dir for the block device
> > + * @q: the associated request_queue of the block device
> > + * @name: the name of the block device exposed
> > + *
> > + * This is used to create the debugfs_dir used by the block layer and blktrace.
> > + * Drivers which use any of the *add_disk*() calls or variants have this called
> > + * automatically for them. This directory is removed automatically on
> > + * blk_release_queue() once the request_queue reference count reaches 0.
> > + */
> > +void blk_queue_debugfs_register(struct request_queue *q, const char *name)
> > +{
> > +	queue_debugfs_register_type(q, name, BLK_DBG_DIR_BASE);
> > +}
> > +EXPORT_SYMBOL_GPL(blk_queue_debugfs_register);
> > +
> > +/**
> > + * blk_queue_debugfs_unregister - remove the debugfs_dir for the block device
> > + * @q: the associated request_queue of the block device
> > + *
> > + * Removes the debugfs_dir for the request_queue on the associated block device.
> > + * This is handled for you on blk_release_queue(), and that should only be
> > + * called once.
> > + *
> > + * Since we don't care where the debugfs_dir was created this is used for all
> > + * types of of enum blk_debugfs_dir_type.
> > + */
> > +void blk_queue_debugfs_unregister(struct request_queue *q)
> > +{
> > +	debugfs_remove_recursive(q->debugfs_dir);
> > +}
> 
> Why is register needed to be exported, but unregister does not?  Does
> some driver not properly clean things up?

Is the comment on blk_queue_debugfs_register() not sufficient?
I thought I was going overboard with how clear this was.  Should I also
add a note here on unregister?

> > +
> > +static struct dentry *queue_debugfs_symlink_type(struct request_queue *q,
> > +						 const char *src,
> > +						 const char *dst,
> > +						 enum blk_debugfs_dir_type type)
> > +{
> > +	struct dentry *dentry = ERR_PTR(-EINVAL);
> > +	char *dir_dst = NULL;
> > +
> > +	switch (type) {
> > +	case BLK_DBG_DIR_BASE:
> > +		if (dst)
> > +			dir_dst = kasprintf(GFP_KERNEL, "%s", dst);
> > +		else if (!IS_ERR_OR_NULL(q->debugfs_dir))
> > +			dir_dst = kasprintf(GFP_KERNEL, "%s",
> > +					    q->debugfs_dir->d_name.name);
> 
> There really is no other way to get the name of the directory other than
> from the dentry?  It's not in the queue itself somewhere?

Nope, beyond that, the problem is that the caller can be scsi-generic
and the queue name instantiation is opaque to what happens below, and
the name of that target directory is only set when the async probe
completes, much after the class_interface sg_add_device(). That is, the
request_queue is shared between scsi-generic device and another driver
which depends on the scsi driver type: TYPE_DISK, TYPE_TAPE, etc. The
sg_add_device() gets called before the debugfs_dir name is even determined
and set. This is why I punted setting the symlink to the ioctl on
scsi-generic.

If we add a post-probe class_interface callback, and make scsi-generic
use it, it would only allow us to set the symlink at a better time
during initialization after the async probe instead of the ioctl, then
if we give the class_interface the now probed device we *could* instead
use device_name().

I thought this would be a welcomed change, but I see this as an
evolution.  In particular older kernels will have to use this format,
unless they want to carry extensions to the class_interface as well.

> Anyway, not a big deal, just trying to not expose debugfs internals
> here.

I'm with you on this, I'd personally prefer to see an extension to the
class_interface as an evolution, that way these fixes can be backported
without much hassle, and the *need* for the new class_interface call is
clearer.

But I'll yield to what folks prefer here.

> > diff --git a/block/partitions/core.c b/block/partitions/core.c
> > index 297004fd2264..4d2a130e6055 100644
> > --- a/block/partitions/core.c
> > +++ b/block/partitions/core.c
> > @@ -10,6 +10,7 @@
> >  #include <linux/vmalloc.h>
> >  #include <linux/blktrace_api.h>
> >  #include <linux/raid/detect.h>
> > +#include <linux/debugfs.h>
> >  #include "check.h"
> >  
> >  static int (*check_part[])(struct parsed_partitions *) = {
> > @@ -320,6 +321,9 @@ void delete_partition(struct gendisk *disk, struct hd_struct *part)
> >  	 *  we have to hold the disk device
> >  	 */
> >  	get_device(disk_to_dev(part_to_disk(part)));
> > +#ifdef CONFIG_DEBUG_FS
> > +	debugfs_remove(part->debugfs_sym);
> > +#endif
> 
> Why is the #ifdef needed?  It shouldn't be.

Because debugfs_sym is a member which is only extended if
CONFIG_DEBUG_FS is defined.

> And why not recursive?

recursive seems odd for a symlink.

> >  	rcu_assign_pointer(ptbl->part[part->partno], NULL);
> >  	kobject_put(part->holder_dir);
> >  	device_del(part_to_dev(part));
> > @@ -460,6 +464,11 @@ static struct hd_struct *add_partition(struct gendisk *disk, int partno,
> >  	/* everything is up and running, commence */
> >  	rcu_assign_pointer(ptbl->part[partno], p);
> >  
> > +#ifdef CONFIG_DEBUG_FS
> > +	p->debugfs_sym = blk_queue_debugfs_symlink(disk->queue, dev_name(pdev),
> > +						   disk->disk_name);
> > +#endif
> 
> Again, no #ifdef should be needed here, just provide the "empty"
> function in the .h file.
> 
> You know this stuff :)

Well it was only *one* function, if we want the boiler plate stuff to
not deal with it, fine, I'll wrap it around and provide a helper for
these. It just seemed overkill.

> > @@ -1644,6 +1716,9 @@ sg_remove_device(struct device *cl_dev, struct class_interface *cl_intf)
> >  
> >  	sysfs_remove_link(&scsidp->sdev_gendev.kobj, "generic");
> >  	device_destroy(sg_sysfs_class, MKDEV(SCSI_GENERIC_MAJOR, sdp->index));
> > +#ifdef CONFIG_DEBUG_FS
> > +	debugfs_remove(sdp->debugfs_sym);
> > +#endif
> 
> Again, no need for the #ifdef.
> 
> If you are worried about the variable not being there, just always put
> it in the structure, it's only a pointer, for something that there are
> not a lot of, right?

Alright, will use wrappers.

  Luis
