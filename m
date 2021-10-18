Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2F2E4327BC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Oct 2021 21:32:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233433AbhJRTen (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 Oct 2021 15:34:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231969AbhJRTem (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 Oct 2021 15:34:42 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7260CC06161C;
        Mon, 18 Oct 2021 12:32:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=B9bByHMOUaNb4hIzLjt6ee5iMVKuoAuSSlDfjNfXcVw=; b=XtN6iHFYDXFCgENpbEdGOr2pmU
        yFFYqYJYUwhdr5Zlp2UsdTC2rL+hCJS1bFB6SdwLPL8YHN2d2igwldOx4aN39GeV7zWYehrfXe2jn
        xPp8Wbs+3g4hxTSveCN7QqtgeFHuYXz8JAy/ZGSgg4zr67ZKFiZkEZvtfzpv+LZY72zafXjqhxeu+
        5Fsq/DwQleE7J00WQFTjv7uxD1NogvR0qdqKtmAPsd2KXSwIcnQ3dqcWurIfkTXkOc6O9SU7pasYf
        Jps0O7g4MB47gCoKXLrVqcnjY2O026y80dKCw6tVa5/wa0aFv5cYUejuIFIsV/jimkvEoP7FdHUzf
        FB3gz3QQ==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mcYMl-00H11w-Tb; Mon, 18 Oct 2021 19:32:11 +0000
Date:   Mon, 18 Oct 2021 12:32:11 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Ming Lei <ming.lei@redhat.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>
Cc:     tj@kernel.org, gregkh@linuxfoundation.org,
        akpm@linux-foundation.org, minchan@kernel.org, jeyu@kernel.org,
        shuah@kernel.org, bvanassche@acm.org, dan.j.williams@intel.com,
        joe@perches.com, tglx@linutronix.de, keescook@chromium.org,
        rostedt@goodmis.org, linux-spdx@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 11/12] zram: fix crashes with cpu hotplug multistate
Message-ID: <YW3LuzaPhW96jSBK@bombadil.infradead.org>
References: <20210927163805.808907-1-mcgrof@kernel.org>
 <20210927163805.808907-12-mcgrof@kernel.org>
 <YWeOJP2UJWYF94fu@T590>
 <YWeR4moCRh+ZHOmH@T590>
 <YWiSAN6xfYcUDJCb@bombadil.infradead.org>
 <YWjCpLUNPF3s4P2U@T590>
 <YWjJ0O7K+31Iz3ox@bombadil.infradead.org>
 <YWk9e957Hb+I7HvR@T590>
 <YWm68xUnAofop3PZ@bombadil.infradead.org>
 <YWq3Z++uoJ/kcp+3@T590>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YWq3Z++uoJ/kcp+3@T590>
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Oct 16, 2021 at 07:28:39PM +0800, Ming Lei wrote:
> On Fri, Oct 15, 2021 at 10:31:31AM -0700, Luis Chamberlain wrote:
> > On Fri, Oct 15, 2021 at 04:36:11PM +0800, Ming Lei wrote:
> > > On Thu, Oct 14, 2021 at 05:22:40PM -0700, Luis Chamberlain wrote:
> > > > On Fri, Oct 15, 2021 at 07:52:04AM +0800, Ming Lei wrote:
> > > ...
> > > > > 
> > > > > We need to understand the exact reason why there is still cpuhp node
> > > > > left, can you share us the exact steps for reproducing the issue?
> > > > > Otherwise we may have to trace and narrow down the reason.
> > > > 
> > > > See my commit log for my own fix for this issue.
> > > 
> > > OK, thanks!
> > > 
> > > I can reproduce the issue, and the reason is that reset_store fails
> > > zram_remove() when unloading module, then the warning is caused.
> > > 
> > > The top 3 patches in the following tree can fix the issue:
> > > 
> > > https://github.com/ming1/linux/commits/my_v5.15-blk-dev
> > 
> > Thanks for trying an alternative fix! A crash stops yes, however this
> 
> I doubt it is alternative since your patchset doesn't mention the exact
> reason of 'Error: Removing state 63 which has instances left.', that is
> simply caused by failing to remove zram because ->claim is set during
> unloading module.

Well I disagree because it does explain how the race can happen, and it
also explains how since the sysfs interface is exposed until module
removal completes, it leaves exposed knobs to allow re-initializing of a
struct zcomp for a zram device before the exit.

> Yeah, you mentioned the race between disksize_store() vs. zram_remove(),
> however I don't think it is reproduced easily in the test because the race
> window is pretty small, also it can be fixed easily in my 3rd path
> without any complicated tricks.

Reproducing for me is... extremely easy.

> Not dig into details of your patchset via grabbing module reference
> count during show/store attribute of kernfs which is done in your patch
> 9, but IMO this way isn't necessary:

That's to address the deadlock only.

> 1) any driver module has to cleanup anything which may refer to symbols
> or data defined in module_exit of this driver

Yes, and as the cpu multistate hotplug documentation warns (although
such documentation is kind of hidden) that driver authors need to be
careful with module removal too, refer to the warning at the end of
__cpuhp_remove_state_cpuslocked() about module removal.

> 2) device_del() is often done in module_exit(), once device_del()
> returns, no any new show/store on the device's kobject attribute
> is possible.

Right and if a syfs knob is exposed before device_del() completely
and is allowed to do things, the driver should take care to prevent
races for CPU multistate support. The small state machine I added ensures
we don't run over any expectations from cpu hotplug multistate support.

I've *never* suggested there cannot be alternatives to my solution with
the small state machine, but for you to say it is incorrect is simply
not right either.

> 3) it is _not_ a must or pattern for fixing bugs to hold one lock before
> calling device_del(), meantime the lock is required in the device's
> attribute show()/store(), which causes AA deadlock easily. Your approach
> just avoids the issue by not releasing module until all show/store are
> done.

Right, there are two approaches here:

a) Your approach is to accept the deadlock as a requirement and so
you would prefer to implement an alternative to using a shared lock
on module exit and sysfs op.

b) While I address such a deadlock head on as I think this sort of locking
be allowed for two reasons:
   b1) as we never documented such requirement otherwise.
   b2) There is a possibility that other drivers already exist too
       which *do* use a shared lock on module removal and sysfs ops
       (and I just confirmed this to be true)

By you only addressing the deadlock as a requirement on approach a) you are
forgetting that there *may* already be present drivers which *do* implement
such patterns in the kernel. I worked on addressing the deadlock because
I was informed livepatching *did* have that issue as well and so very
likely a generic solution to the deadlock could be beneficial to other
random drivers.

So I *really* don't think it is wise for us to simply accept this new
found deadlock as a *new* requirement, specially if we can fix it easily.

A cursory review using Coccinelle potential issues with mutex lock
directly used on module exit (so this doesn't cover drivers like zram
which uses a routine and then grabs the lock through indirection) and a
sysfs op shows these drivers are also affected by this deadlock:

  * arch/powerpc/sysdev/fsl_mpic_timer_wakeup.c
  * lib/test_firmware.c

Note that this cursory review does not cover spin_lock uses, and other
forms locks. Consider the case where a routine is used and then that
routine grabs a lock, so one level indirection. There are many levels
of indirections possible here. And likewise there are different types
of locks.

> > also ends up leaving the driver in an unrecoverable state after a few
> > tries. Ie, you CTRL-C the scripts and try again over and over again and
> > the driver ends up in a situation where it just says:
> > 
> > zram: Can't change algorithm for initialized device
> 
> It means the algorithm can't be changed for one initialized device
> at the exact time. That is understandable because two zram02.sh are
> running concurrently.

Indeed but with your patch it can get stuck and cannot be taken out of this
state.

> Your test script just runs two ./zram02.sh tasks concurrently forever,
> so what is your expected result for the test? Of course, it can't be
> over.
>
> I can't reproduce the 'unrecoverable' state in my test, can you share the
> stack trace log after that happens?

Try a bit harder, cancel the scripts after running for a while randomly
(CTRL C a few times until the script finishes) and have them race again.
Do this a few times.

> > And the zram module can't be removed at that point.
> 
> It is just that systemd opens the zram or the disk is opened as swap
> disk, and once systemd closes it or after you run swapoff, it can be
> unloaded.

With my patch this issues does not happen.

  Luis
