Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF86843AE55
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Oct 2021 10:48:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233821AbhJZIuq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 26 Oct 2021 04:50:46 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:48794 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234356AbhJZIup (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 26 Oct 2021 04:50:45 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 95A69218F6;
        Tue, 26 Oct 2021 08:48:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1635238099; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Q+98+lPkGDb22QCcyWAKWfGYWjs17jCOmjdrdsgCACM=;
        b=brGyZg1VELqA3lLz8/GxVtAGDO5KLJV+h6TxCRn5ziptc07WGQnvihKlqw0Fi8jRY5zdYo
        7oR4y9Ib1kNhPYt4gIgjqgboaKR/iaC/9646T3WjqNJrrmM/6G0pDjzn/xkQhGjExHGTyV
        dhah+BW2dpu+75lhjQ2C4K/zNgtcMwg=
Received: from suse.cz (unknown [10.100.224.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id DA608A3B84;
        Tue, 26 Oct 2021 08:48:18 +0000 (UTC)
Date:   Tue, 26 Oct 2021 10:48:18 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Ming Lei <ming.lei@redhat.com>
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
        live-patching@vger.kernel.org
Subject: Re: [PATCH v8 11/12] zram: fix crashes with cpu hotplug multistate
Message-ID: <YXfA0jfazCPDTEBw@alley>
References: <YWm68xUnAofop3PZ@bombadil.infradead.org>
 <YWq3Z++uoJ/kcp+3@T590>
 <YW3LuzaPhW96jSBK@bombadil.infradead.org>
 <YW4uwep3BCe9Vxq8@T590>
 <alpine.LSU.2.21.2110190820590.15009@pobox.suse.cz>
 <YW6OptglA6UykZg/@T590>
 <alpine.LSU.2.21.2110200835490.26817@pobox.suse.cz>
 <YW/KEsfWJMIPnz76@T590>
 <alpine.LSU.2.21.2110201014400.26817@pobox.suse.cz>
 <YW/q70dLyF+YudyF@T590>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YW/q70dLyF+YudyF@T590>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 2021-10-20 18:09:51, Ming Lei wrote:
> On Wed, Oct 20, 2021 at 10:19:27AM +0200, Miroslav Benes wrote:
> > On Wed, 20 Oct 2021, Ming Lei wrote:
> > 
> > > On Wed, Oct 20, 2021 at 08:43:37AM +0200, Miroslav Benes wrote:
> > > > On Tue, 19 Oct 2021, Ming Lei wrote:
> > > > 
> > > > > On Tue, Oct 19, 2021 at 08:23:51AM +0200, Miroslav Benes wrote:
> > > > > > > > By you only addressing the deadlock as a requirement on approach a) you are
> > > > > > > > forgetting that there *may* already be present drivers which *do* implement
> > > > > > > > such patterns in the kernel. I worked on addressing the deadlock because
> > > > > > > > I was informed livepatching *did* have that issue as well and so very
> > > > > > > > likely a generic solution to the deadlock could be beneficial to other
> > > > > > > > random drivers.
> > > > > > > 
> > > > > > > In-tree zram doesn't have such deadlock, if livepatching has such AA deadlock,
> > > > > > > just fixed it, and seems it has been fixed by 3ec24776bfd0.
> > > > > > 
> > > > > > I would not call it a fix. It is a kind of ugly workaround because the 
> > > > > > generic infrastructure lacked (lacks) the proper support in my opinion. 
> > > > > > Luis is trying to fix that.
> > > > > 
> > > > > What is the proper support of the generic infrastructure? I am not
> > > > > familiar with livepatching's model(especially with module unload), you mean
> > > > > livepatching have to do the following way from sysfs:
> > > > > 
> > > > > 1) during module exit:
> > > > > 	
> > > > > 	mutex_lock(lp_lock);
> > > > > 	kobject_put(lp_kobj);
> > > > > 	mutex_unlock(lp_lock);
> > > > > 	
> > > > > 2) show()/store() method of attributes of lp_kobj
> > > > > 	
> > > > > 	mutex_lock(lp_lock)
> > > > > 	...
> > > > > 	mutex_unlock(lp_lock)
> > > > 
> > > > Yes, this was exactly the case. We then reworked it a lot (see 
> > > > 958ef1e39d24 ("livepatch: Simplify API by removing registration step"), so 
> > > > now the call sequence is different. kobject_put() is basically offloaded 
> > > > to a workqueue scheduled right from the store() method. Meaning that 
> > > > Luis's work would probably not help us currently, but on the other hand 
> > > > the issues with AA deadlock were one of the main drivers of the redesign 
> > > > (if I remember correctly). There were other reasons too as the changelog 
> > > > of the commit describes.
> > > > 
> > > > So, from my perspective, if there was a way to easily synchronize between 
> > > > a data cleanup from module_exit callback and sysfs/kernfs operations, it 
> > > > could spare people many headaches.
> > > 
> > > kobject_del() is supposed to do so, but you can't hold a shared lock
> > > which is required in show()/store() method. Once kobject_del() returns,
> > > no pending show()/store() any more.
> > > 
> > > The question is that why one shared lock is required for livepatching to
> > > delete the kobject. What are you protecting when you delete one kobject?
> > 
> > I think it boils down to the fact that we embed kobject statically to 
> > structures which livepatch uses to maintain data. That is discouraged 
> > generally, but all the attempts to implement it correctly were utter 
> > failures.
> 
> OK, then it isn't one common usage, in which kobject covers the release
> of the external object. What is the exact kobject in livepatching?

Below are more details about the livepatch code. I hope that it will
help you to see if zram has similar problems or not.

We have kobject in three structures: klp_func, klp_object, and
klp_patch, see include/linux/livepatch.h.

These structures have to be statically defined in the module sources
because they define what is livepatched, see
samples/livepatch/livepatch-sample.c

The kobject is used there to show information about the patch, patched
objects, and patched functions, in sysfs. And most importantly,
the sysfs interface can be used to disable the livepatch.

The problem with static structures is that the module must stay
in the memory as long as the sysfs interface exists. It can be
solved in module_exit() callback. It could wait until the sysfs
interface is destroyed.

kobject API does not support this scenario. The relase() callbacks
are called asynchronously. It expects that the structure is bundled
in a dynamically allocated structure.  As a result, the sysfs
interface can be removed even after the module removal.

The livepatching might create the dynamic structures by duplicating
the structures defined in the module statically. It might safe us
some headaches with kobject release. But it would also need an extra code
that would need to be maintained. The structure constrains strings
than need to be duplicated and later freed...


> But kobject_del() won't release the kobject, you shouldn't need the lock
> to delete kobject first. After the kobject is deleted, no any show() and
> store() any more, isn't such sync[1] you expected?

Livepatch code never called kobject_del() under a lock. It would cause
the obvious deadlock. The historic code only waited in the
module_exit() callback until the sysfs interface was removed.

It has changed in the commit 958ef1e39d24d6cb8bf2a740 ("livepatch:
Simplify API by removing registration step"). The livepatch could
never get enabled again after it was disabled now. The sysfs interface
is removed when the livepatch gets disabled. The module could
be removed only after the sysfs interface is destroyed, see
the module_put() in klp_free_patch_finish().

The livepatch code uses workqueue because the livepatch can be
disabled via sysfs interface. It obviously could not wait until
the sysfs interface is removed in the sysfs write() callback
that triggered the removal.

HTH,
Petr
