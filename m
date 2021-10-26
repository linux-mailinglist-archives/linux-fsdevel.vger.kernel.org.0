Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63FB843B5BB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Oct 2021 17:37:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236991AbhJZPkR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 26 Oct 2021 11:40:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:42596 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236984AbhJZPkQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 26 Oct 2021 11:40:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635262672;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tYSbJmBjw+oBo0taflTQ22z74lJbbTngjPSIoTNb7do=;
        b=PSDZAPntkXjSPyBxkdH97uWaWyshaB2mZQLcm83NQNMQU97GXVq92QFKWYzyanSinPS+Pc
        F7YjgiaIhGBFfs4SqWEruyY4frIAX9WpcO+klnbi3AeH1BuwLcxOlRHzOaHInbuk4uWYqU
        jwp7QY7HOsVhVeOk7x9TEZAEDo+FLlU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-521-0qABItmvPAOOJhQt3eR43w-1; Tue, 26 Oct 2021 11:37:50 -0400
X-MC-Unique: 0qABItmvPAOOJhQt3eR43w-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 43E358797D3;
        Tue, 26 Oct 2021 15:37:47 +0000 (UTC)
Received: from T590 (ovpn-8-20.pek2.redhat.com [10.72.8.20])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 44D305DF36;
        Tue, 26 Oct 2021 15:37:35 +0000 (UTC)
Date:   Tue, 26 Oct 2021 23:37:30 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Miroslav Benes <mbenes@suse.cz>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>, tj@kernel.org,
        gregkh@linuxfoundation.org, akpm@linux-foundation.org,
        minchan@kernel.org, jeyu@kernel.org, shuah@kernel.org,
        bvanassche@acm.org, dan.j.williams@intel.com, joe@perches.com,
        tglx@linutronix.de, keescook@chromium.org, rostedt@goodmis.org,
        linux-spdx@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        live-patching@vger.kernel.org, ming.lei@redhat.com
Subject: Re: [PATCH v8 11/12] zram: fix crashes with cpu hotplug multistate
Message-ID: <YXgguuAY5iEUIV0u@T590>
References: <YWq3Z++uoJ/kcp+3@T590>
 <YW3LuzaPhW96jSBK@bombadil.infradead.org>
 <YW4uwep3BCe9Vxq8@T590>
 <alpine.LSU.2.21.2110190820590.15009@pobox.suse.cz>
 <YW6OptglA6UykZg/@T590>
 <alpine.LSU.2.21.2110200835490.26817@pobox.suse.cz>
 <YW/KEsfWJMIPnz76@T590>
 <alpine.LSU.2.21.2110201014400.26817@pobox.suse.cz>
 <YW/q70dLyF+YudyF@T590>
 <YXfA0jfazCPDTEBw@alley>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YXfA0jfazCPDTEBw@alley>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Oct 26, 2021 at 10:48:18AM +0200, Petr Mladek wrote:
> On Wed 2021-10-20 18:09:51, Ming Lei wrote:
> > On Wed, Oct 20, 2021 at 10:19:27AM +0200, Miroslav Benes wrote:
> > > On Wed, 20 Oct 2021, Ming Lei wrote:
> > > 
> > > > On Wed, Oct 20, 2021 at 08:43:37AM +0200, Miroslav Benes wrote:
> > > > > On Tue, 19 Oct 2021, Ming Lei wrote:
> > > > > 
> > > > > > On Tue, Oct 19, 2021 at 08:23:51AM +0200, Miroslav Benes wrote:
> > > > > > > > > By you only addressing the deadlock as a requirement on approach a) you are
> > > > > > > > > forgetting that there *may* already be present drivers which *do* implement
> > > > > > > > > such patterns in the kernel. I worked on addressing the deadlock because
> > > > > > > > > I was informed livepatching *did* have that issue as well and so very
> > > > > > > > > likely a generic solution to the deadlock could be beneficial to other
> > > > > > > > > random drivers.
> > > > > > > > 
> > > > > > > > In-tree zram doesn't have such deadlock, if livepatching has such AA deadlock,
> > > > > > > > just fixed it, and seems it has been fixed by 3ec24776bfd0.
> > > > > > > 
> > > > > > > I would not call it a fix. It is a kind of ugly workaround because the 
> > > > > > > generic infrastructure lacked (lacks) the proper support in my opinion. 
> > > > > > > Luis is trying to fix that.
> > > > > > 
> > > > > > What is the proper support of the generic infrastructure? I am not
> > > > > > familiar with livepatching's model(especially with module unload), you mean
> > > > > > livepatching have to do the following way from sysfs:
> > > > > > 
> > > > > > 1) during module exit:
> > > > > > 	
> > > > > > 	mutex_lock(lp_lock);
> > > > > > 	kobject_put(lp_kobj);
> > > > > > 	mutex_unlock(lp_lock);
> > > > > > 	
> > > > > > 2) show()/store() method of attributes of lp_kobj
> > > > > > 	
> > > > > > 	mutex_lock(lp_lock)
> > > > > > 	...
> > > > > > 	mutex_unlock(lp_lock)
> > > > > 
> > > > > Yes, this was exactly the case. We then reworked it a lot (see 
> > > > > 958ef1e39d24 ("livepatch: Simplify API by removing registration step"), so 
> > > > > now the call sequence is different. kobject_put() is basically offloaded 
> > > > > to a workqueue scheduled right from the store() method. Meaning that 
> > > > > Luis's work would probably not help us currently, but on the other hand 
> > > > > the issues with AA deadlock were one of the main drivers of the redesign 
> > > > > (if I remember correctly). There were other reasons too as the changelog 
> > > > > of the commit describes.
> > > > > 
> > > > > So, from my perspective, if there was a way to easily synchronize between 
> > > > > a data cleanup from module_exit callback and sysfs/kernfs operations, it 
> > > > > could spare people many headaches.
> > > > 
> > > > kobject_del() is supposed to do so, but you can't hold a shared lock
> > > > which is required in show()/store() method. Once kobject_del() returns,
> > > > no pending show()/store() any more.
> > > > 
> > > > The question is that why one shared lock is required for livepatching to
> > > > delete the kobject. What are you protecting when you delete one kobject?
> > > 
> > > I think it boils down to the fact that we embed kobject statically to 
> > > structures which livepatch uses to maintain data. That is discouraged 
> > > generally, but all the attempts to implement it correctly were utter 
> > > failures.
> > 
> > OK, then it isn't one common usage, in which kobject covers the release
> > of the external object. What is the exact kobject in livepatching?
> 
> Below are more details about the livepatch code. I hope that it will
> help you to see if zram has similar problems or not.
> 
> We have kobject in three structures: klp_func, klp_object, and
> klp_patch, see include/linux/livepatch.h.
> 
> These structures have to be statically defined in the module sources
> because they define what is livepatched, see
> samples/livepatch/livepatch-sample.c
> 
> The kobject is used there to show information about the patch, patched
> objects, and patched functions, in sysfs. And most importantly,
> the sysfs interface can be used to disable the livepatch.
> 
> The problem with static structures is that the module must stay
> in the memory as long as the sysfs interface exists. It can be
> solved in module_exit() callback. It could wait until the sysfs
> interface is destroyed.
> 
> kobject API does not support this scenario. The relase() callbacks

kobject_delete() is for supporting this scenario, that is why we don't
need to grab module refcnt before calling show()/store() of the
kobject's attributes.

kobject_delete() can be called in module_exit(), then any show()/store()
will be done after kobject_delete() returns.

> are called asynchronously. It expects that the structure is bundled
> in a dynamically allocated structure.  As a result, the sysfs
> interface can be removed even after the module removal.

That should be one bug, otherwise store()/show() method could be called
into after the module is unloaded.

> 
> The livepatching might create the dynamic structures by duplicating
> the structures defined in the module statically. It might safe us
> some headaches with kobject release. But it would also need an extra code
> that would need to be maintained. The structure constrains strings
> than need to be duplicated and later freed...
> 
> 
> > But kobject_del() won't release the kobject, you shouldn't need the lock
> > to delete kobject first. After the kobject is deleted, no any show() and
> > store() any more, isn't such sync[1] you expected?
> 
> Livepatch code never called kobject_del() under a lock. It would cause
> the obvious deadlock. The historic code only waited in the
> module_exit() callback until the sysfs interface was removed.

OK, then Luis shouldn't consider livepatching as one such issue to solve
with one generic solution.

> 
> It has changed in the commit 958ef1e39d24d6cb8bf2a740 ("livepatch:
> Simplify API by removing registration step"). The livepatch could
> never get enabled again after it was disabled now. The sysfs interface
> is removed when the livepatch gets disabled. The module could
> be removed only after the sysfs interface is destroyed, see
> the module_put() in klp_free_patch_finish().

OK, that is livepatching's implementation: all the kobjects are deleted &
freed after disabling the livepatch module, that looks one kill-me
operation, instead of disabling, so this way isn't a normal usage,
scsi has similar sysfs interface of delete. Also kobjects can't be
removed in enable's store() directly, since deadlock could be
caused, looks wq has to be used here for avoiding deadlock.

BTW, what is the livepatching module use model? try_module_get() is
called in klp_init_patch_early()<-klp_enable_patch()<-module_init(),
module_put() is called in klp_free_patch_finish() which seems only be
called after 'echo 0 > /sys/kernel/livepatch/$lp_mod/enabled'.

Usually when the module isn't used, module_exit() gets chance to be called
by userspace rmmod, then all kobjects created in this module can be
deleted in module_exit().

> 
> The livepatch code uses workqueue because the livepatch can be
> disabled via sysfs interface. It obviously could not wait until
> the sysfs interface is removed in the sysfs write() callback
> that triggered the removal.

If klp_free_patch_* is moved into module_exit() and not let enable
store() to kill kobjects, all kobjects can be deleted in module_exit(),
then wait_for_completion(patch->finish) may be removed, also wq isn't
required for the async cleanup.



Thanks, 
Ming

