Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E9344430D7
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Nov 2021 15:51:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233688AbhKBOyS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 2 Nov 2021 10:54:18 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:54500 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233657AbhKBOyM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 2 Nov 2021 10:54:12 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id C6FDC218DF;
        Tue,  2 Nov 2021 14:51:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1635864695; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UFNoUWc0AZc9WUSca1S+eN9tmYLlYuOWyX2traTgthA=;
        b=REnrQBUIZHLPwnPamGCk1suZ2rJ/dU4SDyZTSsXR9/abMy14g0KAbcxRcodPwYgf3CCebu
        LZhw3EhN8IRUyla4yH4fr7xb0yFWGsQYo30lZZW7uL/XywOIfPaoMdhqTyuZVFVnGvDeDE
        yaa2kF8VchFwSkTFJf3yoOD+VKyZKJ4=
Received: from suse.cz (unknown [10.100.216.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 519D4A3B85;
        Tue,  2 Nov 2021 14:51:35 +0000 (UTC)
Date:   Tue, 2 Nov 2021 15:51:33 +0100
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
Message-ID: <YYFQdWvpXOV4foyS@alley>
References: <YW4uwep3BCe9Vxq8@T590>
 <alpine.LSU.2.21.2110190820590.15009@pobox.suse.cz>
 <YW6OptglA6UykZg/@T590>
 <alpine.LSU.2.21.2110200835490.26817@pobox.suse.cz>
 <YW/KEsfWJMIPnz76@T590>
 <alpine.LSU.2.21.2110201014400.26817@pobox.suse.cz>
 <YW/q70dLyF+YudyF@T590>
 <YXfA0jfazCPDTEBw@alley>
 <YXgguuAY5iEUIV0u@T590>
 <YYFH85CmVOYIMdYh@alley>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YYFH85CmVOYIMdYh@alley>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue 2021-11-02 15:15:19, Petr Mladek wrote:
> On Tue 2021-10-26 23:37:30, Ming Lei wrote:
> > On Tue, Oct 26, 2021 at 10:48:18AM +0200, Petr Mladek wrote:
> > > Below are more details about the livepatch code. I hope that it will
> > > help you to see if zram has similar problems or not.
> > > 
> > > We have kobject in three structures: klp_func, klp_object, and
> > > klp_patch, see include/linux/livepatch.h.
> > > 
> > > These structures have to be statically defined in the module sources
> > > because they define what is livepatched, see
> > > samples/livepatch/livepatch-sample.c
> > > 
> > > The kobject is used there to show information about the patch, patched
> > > objects, and patched functions, in sysfs. And most importantly,
> > > the sysfs interface can be used to disable the livepatch.
> > > 
> > > The problem with static structures is that the module must stay
> > > in the memory as long as the sysfs interface exists. It can be
> > > solved in module_exit() callback. It could wait until the sysfs
> > > interface is destroyed.
> > > 
> > > kobject API does not support this scenario. The relase() callbacks
> > 
> > kobject_delete() is for supporting this scenario, that is why we don't
> > need to grab module refcnt before calling show()/store() of the
> > kobject's attributes.
> > 
> > kobject_delete() can be called in module_exit(), then any show()/store()
> > will be done after kobject_delete() returns.
> 
> I am a bit confused. I do not see kobject_delete() anywhere in kernel
> sources.
> 
> I see only kobject_del() and kobject_put(). AFAIK, they do _not_
> guarantee that either the sysfs interface was destroyed or
> the release callbacks were called. For example, see
> schedule_delayed_work(&kobj->release, delay) in kobject_release().

Grr, I always get confused by the code. kobject_del() actually waits
until the sysfs interface gets destroyed. This is why there is
the deadlock.

But kobject_put() is _not_ synchronous. And the comment above
kobject_add() repeat 3 times that kobject_put() must be called
on success:

 * Return: If this function returns an error, kobject_put() must be
 *         called to properly clean up the memory associated with the
 *         object.  Under no instance should the kobject that is passed
 *         to this function be directly freed with a call to kfree(),
 *         that can leak memory.
 *
 *         If this function returns success, kobject_put() must also be called
 *         in order to properly clean up the memory associated with the object.
 *
 *         In short, once this function is called, kobject_put() MUST be called
 *         when the use of the object is finished in order to properly free
 *         everything.

and similar text in Documentation/core-api/kobject.rst

  After a kobject has been registered with the kobject core successfully, it
  must be cleaned up when the code is finished with it.  To do that, call
  kobject_put().


If I read the code correctly then kobject_put() calls kref_put()
that might call kobject_delayed_cleanup(). This function does a lot
of things and need to access struct kobject.

> IMHO, kobject API does not support static structures and module
> removal.

If kobject_put() has to be called also for static structures then
module_exit() must explicitly wait until the clean up is finished.

Best Regards,
Petr
