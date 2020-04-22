Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDD191B38E9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Apr 2020 09:27:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726398AbgDVH1f (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 Apr 2020 03:27:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725811AbgDVH1e (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 Apr 2020 03:27:34 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53B4FC03C1A6;
        Wed, 22 Apr 2020 00:27:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=w6+W3P29oG0Ik+/xl9IINFqyskOSahJ7kDz6S+fsYqM=; b=QL+0vdM+ILa3iIwSMSJGWUzbQf
        gAEX1JnWUHat8xrpdCTvn9mOaoobYOEUALRqwObqRHNeAHNiZhXUFFfHa/+IiAtVyd/VUwqGlF4a2
        wO3PlXjfdXLKGzhiKgdr86InVPN6myhOWlgnrnYsYjY8swHSyq2RdqeHIjr5Mba8IrcdR95Rjkuda
        jud6XB3f4UI3rAIohXUcdIajL6NPQBb/wvjPtwedec/w4trHOLDfZkOrP+0Wt+h9E9+oanbHj0t0K
        ssUDxXkRlxSxGBhJmjZnSluKEWmWUdvTizpqDhFswh99f3YeNuWH/uyOsrmL5ycF3YM94aCdnNN0x
        5e7KtB5g==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jR9mt-0000BL-6g; Wed, 22 Apr 2020 07:27:15 +0000
Date:   Wed, 22 Apr 2020 00:27:15 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     axboe@kernel.dk, viro@zeniv.linux.org.uk, bvanassche@acm.org,
        gregkh@linuxfoundation.org, rostedt@goodmis.org, mingo@redhat.com,
        jack@suse.cz, ming.lei@redhat.com, nstange@suse.de,
        akpm@linux-foundation.org, mhocko@suse.com, yukuai3@huawei.com,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Omar Sandoval <osandov@fb.com>,
        Hannes Reinecke <hare@suse.com>,
        Michal Hocko <mhocko@kernel.org>,
        syzbot+603294af2d01acfdd6da@syzkaller.appspotmail.com
Subject: Re: [PATCH v2 03/10] blktrace: fix debugfs use after free
Message-ID: <20200422072715.GC19116@infradead.org>
References: <20200419194529.4872-1-mcgrof@kernel.org>
 <20200419194529.4872-4-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200419194529.4872-4-mcgrof@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Apr 19, 2020 at 07:45:22PM +0000, Luis Chamberlain wrote:
> On commit 6ac93117ab00 ("blktrace: use existing disk debugfs directory")
> merged on v4.12 Omar fixed the original blktrace code for request-based
> drivers (multiqueue). This however left in place a possible crash, if you
> happen to abuse blktrace in a way it was not intended, and even more so
> with our current asynchronous request_queue removal.
> 
> Namely, if you loop adding a device, setup the blktrace with BLKTRACESETUP,
> forget to BLKTRACETEARDOWN, and then just remove the device you end up
> with a panic:

FYI, I find all this backtrace garbage not hepful at all.  It requires
me to scroll for so long that I've forgot what was written above by
the time I'm past it.

> This splat happens to be very similar to the one reported via
> kernel.org korg#205713, only that korg#205713 was for v4.19.83
> and the above now includes the simple_recursive_removal() introduced
> via commit a3d1e7eb5abe ("simple_recursive_removal(): kernel-side rm
> -rf for ramfs-style filesystems") merged on v5.6.
> 
> korg#205713 then was used to create CVE-2019-19770 and claims that
> the bug is in a use-after-free in the debugfs core code. The
> implications of this being a generic UAF on debugfs would be
> much more severe, as it would imply parent dentries can sometimes
> not be positive, which we hold by design is just not possible.
> 
> Below is the splat explained with a bit more details, explaining
> what is happening in userspace, kernel, and a print of the CPU on,
> which the code runs on:
> 
> load loopback module
> [   13.603371] == blk_mq_debugfs_register(12) start
> [   13.604040] == blk_mq_debugfs_register(12) q->debugfs_dir created

Same for this..  I think the real valuable changelog only stars below
this 'trace'.

> The root cause to this issue is that debugfs_lookup() can find a
> previous incarnation's dir of the same name which is about to get
> removed from a not yet schedule work. When that happens, the the files
> are taken underneath the nose of the blktrace, and when it comes time to
> cleanup, these dentries are long gone because of a scheduled removal.
> 
> This issue is happening because of two reasons:
> 
>   1) The request_queue is currently removed asynchronously as of commit
>      dc9edc44de6c ("block: Fix a blk_exit_rl() regression") merged on
>      v4.12, this allows races with userspace which were not possible
>      before unless as removal of a block device used to happen
>      synchronously with its request_queue. One could however still
>      parallelize blksetup calls while one loops on device addition and
>      removal.
> 
>   2) There are no errors checks when we create the debugfs directory,
>      be it on init or for blktrace. The concept of when the directory
>      *should* really exist is further complicated by the fact that
>      we have asynchronous request_queue removal. And, we have no
>      real sanity checks to ensure we don't re-create the queue debugfs
>      directory.
> 
> We can fix the UAF by using a debugfs directory which moving forward
> will always be accessible if debugfs is enabled, this way, its allocated
> and avaialble always for both request-based block drivers or
> make_request drivers (multiqueue) block drivers.
> 
> We also put sanity checks in place to ensure that if the directory is
> found with debugfs_lookup() it is the dentry we expect. When doing a
> blktrace against a parition, we will always be creating a temporary
> debugfs directory, so ensure that only exists once as well to avoid
> issues against concurrent blktrace runs.
> 
> Lastly, since we are now always creating the needed request_queue
> debugfs directory upon init, we can also take the initiative to
> proactively check against errors. We currently do not check for
> errors on add_disk() and friends, but we shouldn't make the issue
> any worse.
> 
> This also simplifies the code considerably, with the only penalty now
> being that we're always creating the request queue debugfs directory for
> the request-based block device drivers.
> 
> The UAF then is not a core debugfs issue, but instead a complex misuse
> of debugfs, and this issue can only be triggered if you are root.
> 
> This issue can be reproduced with break-blktrace [2] using:
> 
>   break-blktrace -c 10 -d -s
> 
> This patch fixes this issue. Note that there is also another
> respective UAF but from the ioctl path [3], this should also fix
> that issue.
> 
> This patch then also disputes the severity of CVE-2019-19770 as
> this issue is only possible by being root and using blktrace.
> 
> It is not a core debugfs issue.
> 
> [0] https://bugzilla.kernel.org/show_bug.cgi?id=205713
> [1] https://nvd.nist.gov/vuln/detail/CVE-2019-19770
> [2] https://github.com/mcgrof/break-blktrace
> [3] https://lore.kernel.org/lkml/000000000000ec635b059f752700@google.com/

> +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt

This looks like an unrelated change.

> +
>  #include <linux/kernel.h>
>  #include <linux/blkdev.h>
>  #include <linux/debugfs.h>
> @@ -13,3 +16,30 @@ void blk_debugfs_register(void)
>  {
>  	blk_debugfs_root = debugfs_create_dir("block", NULL);
>  }
> +
> +int __must_check blk_queue_debugfs_register(struct request_queue *q)

__must_check for a function with a single caller looks silly.

> +{
> +	struct dentry *dir = NULL;
> +
> +	/* This can happen if we have a bug in the lower layers */
> +	dir = debugfs_lookup(kobject_name(q->kobj.parent), blk_debugfs_root);
> +	if (dir) {
> +		pr_warn("%s: registering request_queue debugfs directory twice is not allowed\n",
> +			kobject_name(q->kobj.parent));
> +		dput(dir);
> +		return -EALREADY;
> +	}

I don't see why we need this check.  If it is valueable enough we
should have a debugfs_create_dir_exclusive or so that retunrns an error
for an exsting directory, instead of reimplementing it in the caller in
a racy way.  But I'm not really sure we need it to start with.

> +
> +	q->debugfs_dir = debugfs_create_dir(kobject_name(q->kobj.parent),
> +					    blk_debugfs_root);
> +	if (!q->debugfs_dir)
> +		return -ENOMEM;
> +
> +	return 0;
> +}
> +
> +void blk_queue_debugfs_unregister(struct request_queue *q)
> +{
> +	debugfs_remove_recursive(q->debugfs_dir);
> +	q->debugfs_dir = NULL;
> +}

Which to me suggests we can just fold these two into the callers,
with an IS_ENABLED for the creation case given that we check for errors
and the stub will always return an error.

>  	debugfs_create_files(q->debugfs_dir, q, blk_mq_debugfs_queue_attrs);
>  
>  	/*
> @@ -856,9 +853,7 @@ void blk_mq_debugfs_register(struct request_queue *q)
>  
>  void blk_mq_debugfs_unregister(struct request_queue *q)
>  {
> -	debugfs_remove_recursive(q->debugfs_dir);
>  	q->sched_debugfs_dir = NULL;
> -	q->debugfs_dir = NULL;
>  }

This function is weird - the sched dir gets removed by the
debugfs_remove_recursive, so just leaving a function that clears
a pointer is rather odd.  In fact I don't think we need to clear
either sched_debugfs_dir or debugfs_dir anywhere.

>  
> @@ -975,6 +976,14 @@ int blk_register_queue(struct gendisk *disk)
>  		goto unlock;
>  	}
>  
> +	ret = blk_queue_debugfs_register(q);
> +	if (ret) {
> +		blk_trace_remove_sysfs(dev);
> +		kobject_del(&q->kobj);
> +		kobject_put(&dev->kobj);
> +		goto unlock;
> +	}
> +

Please use a goto label to consolidate the common cleanup code.

Also I think these generic debugfs changes probably should be separate
to the blktrace changes.

> +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> +
>  #include <linux/kernel.h>
>  #include <linux/blkdev.h>
>  #include <linux/blktrace_api.h>
> @@ -311,7 +314,15 @@ static void blk_trace_free(struct blk_trace *bt)
>  	debugfs_remove(bt->msg_file);
>  	debugfs_remove(bt->dropped_file);
>  	relay_close(bt->rchan);
> -	debugfs_remove(bt->dir);
> +	/*
> +	 * backing_dir is set when we use the request_queue debugfs directory.
> +	 * Otherwise we are using a temporary directory created only for the
> +	 * purpose of blktrace.
> +	 */
> +	if (bt->backing_dir)
> +		dput(bt->backing_dir);
> +	else
> +		debugfs_remove(bt->dir);
>  	free_percpu(bt->sequence);
>  	free_percpu(bt->msg_data);
>  	kfree(bt);
> @@ -468,16 +479,89 @@ static void blk_trace_setup_lba(struct blk_trace *bt,
>  	}
>  }
>  
> +static bool blk_trace_target_disk(const char *target, const char *diskname)
> +{
> +	if (strlen(target) != strlen(diskname))
> +		return false;
> +
> +	if (!strncmp(target, diskname,
> +		     min_t(size_t, strlen(target), strlen(diskname))))
> +		return true;
> +
> +	return false;
> +}
> +
>  static struct dentry *blk_trace_debugfs_dir(struct blk_user_trace_setup *buts,
> +					    struct request_queue *q,
>  					    struct blk_trace *bt)
>  {
>  	struct dentry *dir = NULL;
>  
> +	/* This can only happen if we have a bug on our lower layers */
> +	if (!q->kobj.parent) {
> +		pr_warn("%s: request_queue parent is gone\n", buts->name);
> +		return NULL;
> +	}

Why is this not simply a WARN_ON_ONCE()?

> +	/*
> +	 * From a sysfs kobject perspective, the request_queue sits on top of
> +	 * the gendisk, which has the name of the disk. We always create a
> +	 * debugfs directory upon init for this gendisk kobject, so we re-use
> +	 * that if blktrace is going to be done for it.
> +	 */

-EPARSE.

> +	if (blk_trace_target_disk(buts->name, kobject_name(q->kobj.parent))) {
> +		if (!q->debugfs_dir) {
> +			pr_warn("%s: expected request_queue debugfs_dir is not set\n",
> +				buts->name);
> +			return NULL;
> +		}
> +		/*
> +		 * debugfs_lookup() is used to ensure the directory is not
> +		 * taken from underneath us. We must dput() it later once
> +		 * done with it within blktrace.
> +		 */
> +		dir = debugfs_lookup(buts->name, blk_debugfs_root);
> +		if (!dir) {
> +			pr_warn("%s: expected request_queue debugfs_dir dentry is gone\n",
> +				buts->name);
> +			return NULL;
> +		}
> +		 /*
> +		 * This is a reaffirmation that debugfs_lookup() shall always
> +		 * return the same dentry if it was already set.
> +		 */
> +		if (dir != q->debugfs_dir) {
> +			dput(dir);
> +			pr_warn("%s: expected dentry dir != q->debugfs_dir\n",
> +				buts->name);
> +			return NULL;
> +		}
> +		bt->backing_dir = q->debugfs_dir;
> +		return bt->backing_dir;
> +	}

Even with the gigantic commit log I don't get the point of this
code.  It looks rather sketchy and I can't find a rationale for it.
