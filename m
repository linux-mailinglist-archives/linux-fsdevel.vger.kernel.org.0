Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB397432BDF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Oct 2021 04:35:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231998AbhJSChd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 Oct 2021 22:37:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:59955 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231627AbhJSChc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 Oct 2021 22:37:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634610920;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7ap2koBbONT9McptTM7UG+aC+LTCrG9BxGpBboEAfoE=;
        b=OGTJi/n+Up5qYToKoBudOe8rzpA28dEyAnBgwP5U7mWzwXYLNUl9MS5mdFpyW3hE1Od/AS
        cX+zAUDJriczY+8KAA4g+NlG/6tXbs7DfCwYfgj1xuAjjNzoAw+5PBvE6776tj7+hkhBEi
        KSwqudDyecs2Bx5yYf5a1p5ZopHQzSA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-355-W4I5Ik5hNae7Y_koi3eeUg-1; Mon, 18 Oct 2021 22:35:15 -0400
X-MC-Unique: W4I5Ik5hNae7Y_koi3eeUg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1FA121922966;
        Tue, 19 Oct 2021 02:35:12 +0000 (UTC)
Received: from T590 (ovpn-8-19.pek2.redhat.com [10.72.8.19])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C248B5C1D0;
        Tue, 19 Oct 2021 02:34:46 +0000 (UTC)
Date:   Tue, 19 Oct 2021 10:34:41 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>, tj@kernel.org,
        gregkh@linuxfoundation.org, akpm@linux-foundation.org,
        minchan@kernel.org, jeyu@kernel.org, shuah@kernel.org,
        bvanassche@acm.org, dan.j.williams@intel.com, joe@perches.com,
        tglx@linutronix.de, keescook@chromium.org, rostedt@goodmis.org,
        linux-spdx@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        ming.lei@redhat.com
Subject: Re: [PATCH v8 11/12] zram: fix crashes with cpu hotplug multistate
Message-ID: <YW4uwep3BCe9Vxq8@T590>
References: <20210927163805.808907-12-mcgrof@kernel.org>
 <YWeOJP2UJWYF94fu@T590>
 <YWeR4moCRh+ZHOmH@T590>
 <YWiSAN6xfYcUDJCb@bombadil.infradead.org>
 <YWjCpLUNPF3s4P2U@T590>
 <YWjJ0O7K+31Iz3ox@bombadil.infradead.org>
 <YWk9e957Hb+I7HvR@T590>
 <YWm68xUnAofop3PZ@bombadil.infradead.org>
 <YWq3Z++uoJ/kcp+3@T590>
 <YW3LuzaPhW96jSBK@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YW3LuzaPhW96jSBK@bombadil.infradead.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Oct 18, 2021 at 12:32:11PM -0700, Luis Chamberlain wrote:
> On Sat, Oct 16, 2021 at 07:28:39PM +0800, Ming Lei wrote:
> > On Fri, Oct 15, 2021 at 10:31:31AM -0700, Luis Chamberlain wrote:
> > > On Fri, Oct 15, 2021 at 04:36:11PM +0800, Ming Lei wrote:
> > > > On Thu, Oct 14, 2021 at 05:22:40PM -0700, Luis Chamberlain wrote:
> > > > > On Fri, Oct 15, 2021 at 07:52:04AM +0800, Ming Lei wrote:
> > > > ...
> > > > > > 
> > > > > > We need to understand the exact reason why there is still cpuhp node
> > > > > > left, can you share us the exact steps for reproducing the issue?
> > > > > > Otherwise we may have to trace and narrow down the reason.
> > > > > 
> > > > > See my commit log for my own fix for this issue.
> > > > 
> > > > OK, thanks!
> > > > 
> > > > I can reproduce the issue, and the reason is that reset_store fails
> > > > zram_remove() when unloading module, then the warning is caused.
> > > > 
> > > > The top 3 patches in the following tree can fix the issue:
> > > > 
> > > > https://github.com/ming1/linux/commits/my_v5.15-blk-dev
> > > 
> > > Thanks for trying an alternative fix! A crash stops yes, however this
> > 
> > I doubt it is alternative since your patchset doesn't mention the exact
> > reason of 'Error: Removing state 63 which has instances left.', that is
> > simply caused by failing to remove zram because ->claim is set during
> > unloading module.
> 
> Well I disagree because it does explain how the race can happen, and it
> also explains how since the sysfs interface is exposed until module
> removal completes, it leaves exposed knobs to allow re-initializing of a
> struct zcomp for a zram device before the exit.
> 
> > Yeah, you mentioned the race between disksize_store() vs. zram_remove(),
> > however I don't think it is reproduced easily in the test because the race
> > window is pretty small, also it can be fixed easily in my 3rd path
> > without any complicated tricks.
> 
> Reproducing for me is... extremely easy.

In my observation, failing zram_remove() is extremely easy to trigger, which
is caused by reset_store() which sets ->reclaim as true, so
zram_remove() is failed and zram_reset_device() is bypassed , then the
failure of 'Error: Removing state 63 which has instances left.' is caused.

We are in same page?

> 
> > Not dig into details of your patchset via grabbing module reference
> > count during show/store attribute of kernfs which is done in your patch
> > 9, but IMO this way isn't necessary:
> 
> That's to address the deadlock only.
> 
> > 1) any driver module has to cleanup anything which may refer to symbols
> > or data defined in module_exit of this driver
> 
> Yes, and as the cpu multistate hotplug documentation warns (although
> such documentation is kind of hidden) that driver authors need to be
> careful with module removal too, refer to the warning at the end of
> __cpuhp_remove_state_cpuslocked() about module removal.

It is zram's bug. zram has to clean everything in module_exit(),
unfortunately zram_remove() can be failed when calling from
module_exit() because ->claim is set as true by reset_store(), then
zram_reset_device()(->zcomp_destroy) isn't called, and this failure should
not happen when unloading module, should it?

> 
> > 2) device_del() is often done in module_exit(), once device_del()
> > returns, no any new show/store on the device's kobject attribute
> > is possible.
> 
> Right and if a syfs knob is exposed before device_del() completely
> and is allowed to do things, the driver should take care to prevent
> races for CPU multistate support. The small state machine I added ensures

What is the race for CPU multistate support? If you mean 'Error: Removing
state 63 which has instances left.', it is zram's bug since zram has to
cleanup everything in module_exit().

> we don't run over any expectations from cpu hotplug multistate support.
> 
> I've *never* suggested there cannot be alternatives to my solution with
> the small state machine, but for you to say it is incorrect is simply
> not right either.
> 
> > 3) it is _not_ a must or pattern for fixing bugs to hold one lock before
> > calling device_del(), meantime the lock is required in the device's
> > attribute show()/store(), which causes AA deadlock easily. Your approach
> > just avoids the issue by not releasing module until all show/store are
> > done.
> 
> Right, there are two approaches here:
> 
> a) Your approach is to accept the deadlock as a requirement and so
> you would prefer to implement an alternative to using a shared lock
> on module exit and sysfs op.

wrt. in-tree zram, there is neither any deadlock in linus tree, nor after
applying my 3 patches. If you think there is, please share us the code
or lockdep warning.

> 
> b) While I address such a deadlock head on as I think this sort of locking
> be allowed for two reasons:
>    b1) as we never documented such requirement otherwise.
>    b2) There is a possibility that other drivers already exist too
>        which *do* use a shared lock on module removal and sysfs ops
>        (and I just confirmed this to be true)

The 'deadlock' is actually caused by your out-of-tree patch of 'zram: fix
crashes with cpu hotplug multistate' which adds mutex_lock(zram_index_mutex)
in destroy_devices().

We can fix this issue easily without needing the global lock, please see the
attached(pre-V2) patch.

> 
> By you only addressing the deadlock as a requirement on approach a) you are
> forgetting that there *may* already be present drivers which *do* implement
> such patterns in the kernel. I worked on addressing the deadlock because
> I was informed livepatching *did* have that issue as well and so very
> likely a generic solution to the deadlock could be beneficial to other
> random drivers.

In-tree zram doesn't have such deadlock, if livepatching has such AA deadlock,
just fixed it, and seems it has been fixed by 3ec24776bfd0.

> 
> So I *really* don't think it is wise for us to simply accept this new
> found deadlock as a *new* requirement, specially if we can fix it easily.
> 
> A cursory review using Coccinelle potential issues with mutex lock
> directly used on module exit (so this doesn't cover drivers like zram
> which uses a routine and then grabs the lock through indirection) and a
> sysfs op shows these drivers are also affected by this deadlock:
> 
>   * arch/powerpc/sysdev/fsl_mpic_timer_wakeup.c

In fsl_wakeup_sys_exit(), device_remove_file() is called before
acquiring &sysfs_lock, so there shouldn't be such AA deadlock.

>   * lib/test_firmware.c

Yeah, there is the AA deadlock risk, but it should be fixed by moving
misc_deregister() out of &test_fw_mutex.

> 
> Note that this cursory review does not cover spin_lock uses, and other
> forms locks. Consider the case where a routine is used and then that
> routine grabs a lock, so one level indirection. There are many levels
> of indirections possible here. And likewise there are different types
> of locks.
> 
> > > also ends up leaving the driver in an unrecoverable state after a few
> > > tries. Ie, you CTRL-C the scripts and try again over and over again and
> > > the driver ends up in a situation where it just says:
> > > 
> > > zram: Can't change algorithm for initialized device
> > 
> > It means the algorithm can't be changed for one initialized device
> > at the exact time. That is understandable because two zram02.sh are
> > running concurrently.
> 
> Indeed but with your patch it can get stuck and cannot be taken out of this
> state.

OK, I can keep current behavior: fail open() in case of removing or
resetting, meantime not hold open_mutex when sync bdev and reset device,
see attached patch.

> 
> > Your test script just runs two ./zram02.sh tasks concurrently forever,
> > so what is your expected result for the test? Of course, it can't be
> > over.
> >
> > I can't reproduce the 'unrecoverable' state in my test, can you share the
> > stack trace log after that happens?
> 
> Try a bit harder, cancel the scripts after running for a while randomly
> (CTRL C a few times until the script finishes) and have them race again.
> Do this a few times.
> 
> > > And the zram module can't be removed at that point.
> > 
> > It is just that systemd opens the zram or the disk is opened as swap
> > disk, and once systemd closes it or after you run swapoff, it can be
> > unloaded.
> 
> With my patch this issues does not happen.

It is because the patch 2 holds ->open_mutex() for sync bdev and reset
zram, so several 'CTRL-C' is needed for terminating the test script, then
zram02.sh's cleanup handler can be interrupted too. We can keep current
behavior easily.

Please try the following patch against upstream(linus or next) tree(basically
fold revised 2 and 3 of V1, and cover two issues: not fail zram_remove in
module_exit(), race between zram_remove() and disksize_store()), and see if
everything is fine for you:


diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index a68297fb51a2..320822a80b64 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -1967,25 +1967,45 @@ static int zram_add(void)
 static int zram_remove(struct zram *zram)
 {
 	struct block_device *bdev = zram->disk->part0;
+	bool claimed;
 
 	mutex_lock(&bdev->bd_disk->open_mutex);
-	if (bdev->bd_openers || zram->claim) {
+	if (bdev->bd_openers) {
 		mutex_unlock(&bdev->bd_disk->open_mutex);
 		return -EBUSY;
 	}
 
-	zram->claim = true;
+	claimed = zram->claim;
+	if (!claimed)
+		zram->claim = true;
 	mutex_unlock(&bdev->bd_disk->open_mutex);
 
 	zram_debugfs_unregister(zram);
 
-	/* Make sure all the pending I/O are finished */
-	fsync_bdev(bdev);
-	zram_reset_device(zram);
+	if (claimed) {
+		/*
+		 * If we were claimed by reset_store(), del_gendisk() will
+		 * wait until sync & reset is completed, so do nothing here.
+		 */
+		;
+	} else {
+		/* Make sure all the pending I/O are finished */
+		sync_blockdev(bdev);
+		zram_reset_device(zram);
+	}
 
 	pr_info("Removed device: %s\n", zram->disk->disk_name);
 
 	del_gendisk(zram->disk);
+
+	WARN_ON_ONCE(claimed && zram->claim);
+
+	/*
+	 * disksize store may come after the above zram_reset_device
+	 * returns, so run the last reset to avoid the race
+	 */
+	zram_reset_device(zram);
+
 	blk_cleanup_disk(zram->disk);
 	kfree(zram);
 	return 0;


Thanks,
Ming

