Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2500433C92
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Oct 2021 18:40:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234332AbhJSQmS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Oct 2021 12:42:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:30410 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234130AbhJSQmR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Oct 2021 12:42:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634661604;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2rc5ZXQmK9kKYJDi1YzawO6EnOKTupbA3b+o84caZ7c=;
        b=Z+a1GvhFwPUG9uLBixeiX7/3Lp/Ma6XDGWtN6vvmwZayGRX1+c0qLYoJ8//SHEARzDtyTN
        anHCNYHVwQBlQIis0snHpGpOxHNxBjJqLmKg0KLvuTTa+ZBU4VnKbC4yvTnBYiZkZxrqSc
        oN0EkmjxPWP/4T4i93hvwh0MWAFpwno=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-594-PU8UiIgeOeSUr6uAHZ2kHQ-1; Tue, 19 Oct 2021 12:40:02 -0400
X-MC-Unique: PU8UiIgeOeSUr6uAHZ2kHQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 006261023F4D;
        Tue, 19 Oct 2021 16:40:00 +0000 (UTC)
Received: from T590 (ovpn-8-19.pek2.redhat.com [10.72.8.19])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id F3ED599CF;
        Tue, 19 Oct 2021 16:39:27 +0000 (UTC)
Date:   Wed, 20 Oct 2021 00:39:22 +0800
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
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 11/12] zram: fix crashes with cpu hotplug multistate
Message-ID: <YW70uklcBWrmJIn8@T590>
References: <YWeR4moCRh+ZHOmH@T590>
 <YWiSAN6xfYcUDJCb@bombadil.infradead.org>
 <YWjCpLUNPF3s4P2U@T590>
 <YWjJ0O7K+31Iz3ox@bombadil.infradead.org>
 <YWk9e957Hb+I7HvR@T590>
 <YWm68xUnAofop3PZ@bombadil.infradead.org>
 <YWq3Z++uoJ/kcp+3@T590>
 <YW3LuzaPhW96jSBK@bombadil.infradead.org>
 <YW4uwep3BCe9Vxq8@T590>
 <YW7pQKi8AlV+ZemU@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YW7pQKi8AlV+ZemU@bombadil.infradead.org>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Oct 19, 2021 at 08:50:24AM -0700, Luis Chamberlain wrote:
> On Tue, Oct 19, 2021 at 10:34:41AM +0800, Ming Lei wrote:
> > On Mon, Oct 18, 2021 at 12:32:11PM -0700, Luis Chamberlain wrote:
> > > On Sat, Oct 16, 2021 at 07:28:39PM +0800, Ming Lei wrote:
> > > > On Fri, Oct 15, 2021 at 10:31:31AM -0700, Luis Chamberlain wrote:
> > > > > On Fri, Oct 15, 2021 at 04:36:11PM +0800, Ming Lei wrote:
> > > > > > On Thu, Oct 14, 2021 at 05:22:40PM -0700, Luis Chamberlain wrote:
> > > > > > > On Fri, Oct 15, 2021 at 07:52:04AM +0800, Ming Lei wrote:
> > > > > > ...
> > > > > > > > 
> > > > > > > > We need to understand the exact reason why there is still cpuhp node
> > > > > > > > left, can you share us the exact steps for reproducing the issue?
> > > > > > > > Otherwise we may have to trace and narrow down the reason.
> > > > > > > 
> > > > > > > See my commit log for my own fix for this issue.
> > > > > > 
> > > > > > OK, thanks!
> > > > > > 
> > > > > > I can reproduce the issue, and the reason is that reset_store fails
> > > > > > zram_remove() when unloading module, then the warning is caused.
> > > > > > 
> > > > > > The top 3 patches in the following tree can fix the issue:
> > > > > > 
> > > > > > https://github.com/ming1/linux/commits/my_v5.15-blk-dev
> > > > > 
> > > > > Thanks for trying an alternative fix! A crash stops yes, however this
> > > > 
> > > > I doubt it is alternative since your patchset doesn't mention the exact
> > > > reason of 'Error: Removing state 63 which has instances left.', that is
> > > > simply caused by failing to remove zram because ->claim is set during
> > > > unloading module.
> > > 
> > > Well I disagree because it does explain how the race can happen, and it
> > > also explains how since the sysfs interface is exposed until module
> > > removal completes, it leaves exposed knobs to allow re-initializing of a
> > > struct zcomp for a zram device before the exit.
> > > 
> > > > Yeah, you mentioned the race between disksize_store() vs. zram_remove(),
> > > > however I don't think it is reproduced easily in the test because the race
> > > > window is pretty small, also it can be fixed easily in my 3rd path
> > > > without any complicated tricks.
> > > 
> > > Reproducing for me is... extremely easy.
> > 
> > In my observation, failing zram_remove() is extremely easy to trigger, which
> > is caused by reset_store() which sets ->reclaim as true, so
> > zram_remove() is failed and zram_reset_device() is bypassed , then the
> > failure of 'Error: Removing state 63 which has instances left.' is caused.
> > 
> > We are in same page?
> 
> The actual first issue is the CPU hotplug remove callback is long gone and
> in the meantime we allow a race to add a new "instance", in the zram
> driver's case a cpu struct zcomp instance though the sysfs interface.
> 
> Regardless of if zram_remove() can fail or not, the above race needs to
> be addressed.
> 
> > > > Not dig into details of your patchset via grabbing module reference
> > > > count during show/store attribute of kernfs which is done in your patch
> > > > 9, but IMO this way isn't necessary:
> > > 
> > > That's to address the deadlock only.
> > > 
> > > > 1) any driver module has to cleanup anything which may refer to symbols
> > > > or data defined in module_exit of this driver
> > > 
> > > Yes, and as the cpu multistate hotplug documentation warns (although
> > > such documentation is kind of hidden) that driver authors need to be
> > > careful with module removal too, refer to the warning at the end of
> > > __cpuhp_remove_state_cpuslocked() about module removal.
> > 
> > It is zram's bug. zram has to clean everything in module_exit(),
> > unfortunately zram_remove() can be failed when calling from
> > module_exit() because ->claim is set as true by reset_store(), then
> > zram_reset_device()(->zcomp_destroy) isn't called, and this failure should
> > not happen when unloading module, should it?
> 
> You're addressing a possible failig zram_remove() while I address not
> allowing entry to muck with the zram driver at all once we're bailing
> on module removal.
> 
> > > > 2) device_del() is often done in module_exit(), once device_del()
> > > > returns, no any new show/store on the device's kobject attribute
> > > > is possible.
> > > 
> > > Right and if a syfs knob is exposed before device_del() completely
> > > and is allowed to do things, the driver should take care to prevent
> > > races for CPU multistate support. The small state machine I added ensures
> > 
> > What is the race for CPU multistate support? If you mean 'Error: Removing
> > state 63 which has instances left.', it is zram's bug since zram has to
> > cleanup everything in module_exit().
> 
> Yes. And it is what my out of tree yet Acked patch, 'zram: fix     
> crashes with cpu hotplug multistate' does.

Unfortunately that patch adds new deadlock between hot_remove_store() and
disksize_store() & others, see my below comment.

> 
> > > we don't run over any expectations from cpu hotplug multistate support.
> > > 
> > > I've *never* suggested there cannot be alternatives to my solution with
> > > the small state machine, but for you to say it is incorrect is simply
> > > not right either.
> > > 
> > > > 3) it is _not_ a must or pattern for fixing bugs to hold one lock before
> > > > calling device_del(), meantime the lock is required in the device's
> > > > attribute show()/store(), which causes AA deadlock easily. Your approach
> > > > just avoids the issue by not releasing module until all show/store are
> > > > done.
> > > 
> > > Right, there are two approaches here:
> > > 
> > > a) Your approach is to accept the deadlock as a requirement and so
> > > you would prefer to implement an alternative to using a shared lock
> > > on module exit and sysfs op.
> > 
> > wrt. in-tree zram, there is neither any deadlock in linus tree, nor after
> > applying my 3 patches. If you think there is, please share us the code
> > or lockdep warning.
> 
> Right, 'zram: fix crashes with cpu hotplug multistate' is not yet
> merged, my approach to fixing that does add a lock use on module removal
> which does introduce a possible deadlock with syfs, which is later addressed
> generically between sysfs and module removal for all drivers.
> 
> > > b) While I address such a deadlock head on as I think this sort of locking
> > > be allowed for two reasons:
> > >    b1) as we never documented such requirement otherwise.
> > >    b2) There is a possibility that other drivers already exist too
> > >        which *do* use a shared lock on module removal and sysfs ops
> > >        (and I just confirmed this to be true)
> > 
> > The 'deadlock' is actually caused by your out-of-tree patch of 'zram: fix
> > crashes with cpu hotplug multistate' which adds mutex_lock(zram_index_mutex)
> > in destroy_devices().
> 
> Yes yes, but you are completely throwing out the window that other
> possible deadlocks can exist in the kernel *and* that *new* cases of
> the deadlock can easily also be added!
> 
> > We can fix this issue easily without needing the global lock, please see the
> > attached(pre-V2) patch.
> 
> So far your patches do not fix the issues though...
> 
> > > So I *really* don't think it is wise for us to simply accept this new
> > > found deadlock as a *new* requirement, specially if we can fix it easily.
> > > 
> > > A cursory review using Coccinelle potential issues with mutex lock
> > > directly used on module exit (so this doesn't cover drivers like zram
> > > which uses a routine and then grabs the lock through indirection) and a
> > > sysfs op shows these drivers are also affected by this deadlock:
> > > 
> > >   * arch/powerpc/sysdev/fsl_mpic_timer_wakeup.c
> > 
> > In fsl_wakeup_sys_exit(), device_remove_file() is called before
> > acquiring &sysfs_lock, so there shouldn't be such AA deadlock.
> > 
> > >   * lib/test_firmware.c
> > 
> > Yeah, there is the AA deadlock risk, but it should be fixed by moving
> > misc_deregister() out of &test_fw_mutex.
> 
> And just like that you are ignoring other possible uses in the kernel
> which might have similar deadlocks.
> 
> So do you want to take the position:
> 
> Hey driver authors: you cannot use any shared lock on module removal and
> on sysfs ops?

IMO, yes, in your patch of 'zram: fix crashes with cpu hotplug multistate',
when you added mutex_lock(zram_index_mutex) to disksize_store() and
other attribute show() or store() method. You have added new deadlock
between hot_remove_store() and disksize_store() & others, which can't be
addressed by your approach of holding module refcnt.

So far not see ltp tests covers hot add/remove interface yet.


Thanks, 
Ming

