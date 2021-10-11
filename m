Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6300D42996E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Oct 2021 00:26:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235517AbhJKW2N (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 11 Oct 2021 18:28:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235484AbhJKW2L (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 11 Oct 2021 18:28:11 -0400
Received: from bombadil.infradead.org (unknown [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBE97C061570;
        Mon, 11 Oct 2021 15:26:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=lyPSIok62utLCmQ4XS6IoW1XOT62RU2rbFfpT1HFMT8=; b=RRjvyhwmsM0XNPnlsbJ5OA6ShL
        RGPwyPvsjZ1T4+S1dg08rGnJQHcV3gA8cWbgauzip21rH7GHbMqYXxWamSP8Sb2lxS7p9pwmiXmmL
        FCEYph6e4gt439koJVuoF8F4zaM3ccMwjyl7SHQlrVTYez9s3BNkTCzFPWFaJXGXUI14b+LRKTWmD
        fIjRrEBdri3OqVE/y6KlfRqKom9mWe3SGtgdE6IkIclGP/8ELY6JY27WkB0abRlU4lSai7iJkhfj3
        dvy0aMZ+2LRnaRKZWDrydq0PSOMQddh72peNtkMy++CaAMhWRrltC9Vmw1tfuGKIYYOg0F02It4o2
        ao1ptUwg==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ma3kA-00AtVE-C9; Mon, 11 Oct 2021 22:26:02 +0000
Date:   Mon, 11 Oct 2021 15:26:02 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     tj@kernel.org, gregkh@linuxfoundation.org,
        akpm@linux-foundation.org, minchan@kernel.org, jeyu@kernel.org,
        shuah@kernel.org, bvanassche@acm.org, dan.j.williams@intel.com,
        joe@perches.com, tglx@linutronix.de, rostedt@goodmis.org,
        linux-spdx@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 09/12] sysfs: fix deadlock race with module removal
Message-ID: <YWS5+uyDQ4qklTcT@bombadil.infradead.org>
References: <20210927163805.808907-1-mcgrof@kernel.org>
 <20210927163805.808907-10-mcgrof@kernel.org>
 <202110051315.B2165F455@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202110051315.B2165F455@keescook>
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Oct 05, 2021 at 01:50:31PM -0700, Kees Cook wrote:
> On Mon, Sep 27, 2021 at 09:38:02AM -0700, Luis Chamberlain wrote:
> > A sketch of how this can happen follows, consider foo a local mutex
> > part of a driver, and used on the driver's module exit routine and
> > on one of its sysfs ops:
> > 
> > foo.c:
> > static DEFINE_MUTEX(foo);
> > static ssize_t foo_store(struct device *dev,
> > 			 struct device_attribute *attr,
> > 			 const char *buf, size_t count)
> > {
> > 	...
> > 	mutex_lock(&foo);
> > 	...
> > 	mutex_lock(&foo);
> > 	...
> > }
> > static DEVICE_ATTR_RW(foo);
> > ...
> > void foo_exit(void)
> > {
> > 	mutex_lock(&foo);
> > 	...
> > 	mutex_unlock(&foo);
> > }
> > module_exit(foo_exit);
> > 
> > And this can lead to this condition:
> > 
> > CPU A                              CPU B
> >                                    foo_store()
> > foo_exit()
> >   mutex_lock(&foo)
> >                                    mutex_lock(&foo)
> >    del_gendisk(some_struct->disk);
> >      device_del()
> >        device_remove_groups()
> 
> Please expand this further, where does device_remove_groups() end up
> waiting for that never happens?

Sure. How about:

Furthermore, device_remove_groups() will just go on trying to remove
the sysfs files, which are kernfs entries. The way kernfs deals with
removal is that it will wait until all active references for the files
being removed are done. The active reference is obtained through
kernfs_get_active(). Removal ends up waiting through kernfs_drain()
for the active references to be done, and that only happens if the
kernfs file ops can complete. If these kernfs ops / sysfs files
are waiting for a mutex which taken by the module's exit routine
prior to trying to remove the sysfs files we deadlock.

> > In this situation foo_store() is waiting for the mutex foo to
> > become unlocked, but that won't happen until module removal is complete.
> > But module removal won't complete until the sysfs file being poked at
> > completes which is waiting for a lock already held.
> > 
> > Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
> > ---
> >  arch/x86/kernel/cpu/resctrl/rdtgroup.c |  4 +-
> >  fs/kernfs/dir.c                        | 44 ++++++++++++++++++----
> >  fs/kernfs/file.c                       |  6 ++-
> >  fs/kernfs/kernfs-internal.h            |  3 +-
> >  fs/kernfs/symlink.c                    |  3 +-
> >  fs/sysfs/dir.c                         |  2 +-
> >  fs/sysfs/file.c                        |  6 ++-
> >  fs/sysfs/group.c                       |  3 +-
> >  include/linux/kernfs.h                 | 14 ++++---
> >  include/linux/sysfs.h                  | 52 ++++++++++++++++++++------
> >  kernel/cgroup/cgroup.c                 |  2 +-
> >  11 files changed, 105 insertions(+), 34 deletions(-)
> > 
> > diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> > index b57b3db9a6a7..4edf3b37fd2c 100644
> > --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> > +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> > @@ -209,7 +209,7 @@ static int rdtgroup_add_file(struct kernfs_node *parent_kn, struct rftype *rft)
> >  
> >  	kn = __kernfs_create_file(parent_kn, rft->name, rft->mode,
> >  				  GLOBAL_ROOT_UID, GLOBAL_ROOT_GID,
> > -				  0, rft->kf_ops, rft, NULL, NULL);
> > +				  0, rft->kf_ops, rft, NULL, NULL, NULL);
> >  	if (IS_ERR(kn))
> >  		return PTR_ERR(kn);
> >  
> > @@ -2482,7 +2482,7 @@ static int mon_addfile(struct kernfs_node *parent_kn, const char *name,
> >  
> >  	kn = __kernfs_create_file(parent_kn, name, 0444,
> >  				  GLOBAL_ROOT_UID, GLOBAL_ROOT_GID, 0,
> > -				  &kf_mondata_ops, priv, NULL, NULL);
> > +				  &kf_mondata_ops, priv, NULL, NULL, NULL);
> >  	if (IS_ERR(kn))
> >  		return PTR_ERR(kn);
> >  
> > diff --git a/fs/kernfs/dir.c b/fs/kernfs/dir.c
> > index ba581429bf7b..e841201fd11b 100644
> > --- a/fs/kernfs/dir.c
> > +++ b/fs/kernfs/dir.c
> > @@ -14,6 +14,7 @@
> >  #include <linux/slab.h>
> >  #include <linux/security.h>
> >  #include <linux/hash.h>
> > +#include <linux/module.h>
> >  
> >  #include "kernfs-internal.h"
> >  
> > @@ -414,12 +415,29 @@ static bool kernfs_unlink_sibling(struct kernfs_node *kn)
> >   */
> >  struct kernfs_node *kernfs_get_active(struct kernfs_node *kn)
> >  {
> > +	int v;
> > +
> >  	if (unlikely(!kn))
> >  		return NULL;
> >  
> >  	if (!atomic_inc_unless_negative(&kn->active))
> >  		return NULL;
> >  
> > +	/*
> > +	 * If a module created the kernfs_node, the module cannot possibly be
> > +	 * removed if the above atomic_inc_unless_negative() succeeded. So the
> > +	 * try_module_get() below is not to protect the lifetime of the module
> > +	 * as that is already guaranteed. The try_module_get() below is used
> > +	 * to ensure that we don't deadlock in case a kernfs operation and
> > +	 * module removal used a shared lock.
> > +	 */
> > +	if (!try_module_get(kn->owner)) {
> > +		v = atomic_dec_return(&kn->active);
> > +		if (unlikely(v == KN_DEACTIVATED_BIAS))
> > +			wake_up_all(&kernfs_root(kn)->deactivate_waitq);
> > +		return NULL;
> > +	}
> 
> The special casing in here makes me think this isn't happening the right
> place. (i.e this looks like an open-coded version of kernfs_put_active())

No, well you see, in effect the special care taken in
kernfs_put_active() *is* the right way to inform a waiter that
that the *taken* reference right above *also* is no longer active.

The special casing here is because we took the active reference
before the try_module_get() in the above atomic_inc_unless_negative()
call. Outside callers deal with this through kernfs_put_active().

We are special casing to deal with the deadlock case.

> > +
> >  	if (kernfs_lockdep(kn))
> >  		rwsem_acquire_read(&kn->dep_map, 0, 1, _RET_IP_);
> >  	return kn;
> > @@ -442,6 +460,13 @@ void kernfs_put_active(struct kernfs_node *kn)
> >  	if (kernfs_lockdep(kn))
> >  		rwsem_release(&kn->dep_map, _RET_IP_);
> >  	v = atomic_dec_return(&kn->active);
> > +
> > +	/*
> > +	 * We prevent module exit *until* we know for sure all possible
> > +	 * kernfs ops are done.
> > +	 */
> > +	module_put(kn->owner);
> > +
> >  	if (likely(v != KN_DEACTIVATED_BIAS))
> >  		return;
> 
> What I don't understand, however, is what kernfs_get/put_active() is
> intending to do -- it looks like it's trying to provide an interruption
> point for open kernfs file operations?

It is essentially ensuring that removal does not happen if any ops
are being used.

> This all seems extremely complex for what seems like it should just be a
> global "am I being removed?" bool?

It used to be worse :) And Tejun has cleaned this up over time. Yes,
perhaps we can improve that more but, given how sensible this code
is I think such improvements should be made separately.

> Regardless, while I do see the logic of associating the module get/put
> with get/put of kernfs "active", why is it not better tied to strictly
> kernfs open/close? 

It's not just files, consider kernfs_iop_mkdir() which also calls
kernfs_get_active(). How about kernfs_fop_mmap()? And so, the common
denominator is actually kernfs_get_active().

> That would seem to be much simpler and not require
> any special handling?

Yes true, but it I think this would still leave open some other possible
deadlocks.

> For example, why does this not work?

It does for the write case for sure, but I haven't written tests for the
other odd cases, but suspect that would deadlock as well.

 Luis
