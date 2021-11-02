Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86C50443169
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Nov 2021 16:18:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234298AbhKBPU4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 2 Nov 2021 11:20:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:51806 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234304AbhKBPUx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 2 Nov 2021 11:20:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635866298;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6dODq+TaBd9o3SXxOkqAmjs0L7/fBuFRIhrp2FL47OI=;
        b=F9VS9tmcgCat/hgki00bgMT6zDvGWBADK8fLmTCEbv/Jm3uImiaIcaZk8dOKNZBCjKiavv
        lfGgWObkh4av7RwE+rIeZFjxuERjuS4egLD6lXWaCALYCTYiRa31zqCE8TkV+vFTqN7+Co
        gMTLWWcFSJaC15TDOAN8g8FCnIU6L+A=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-339-AklUD-MXNQ26qIBOPeLekg-1; Tue, 02 Nov 2021 11:18:15 -0400
X-MC-Unique: AklUD-MXNQ26qIBOPeLekg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7AE5A362FC;
        Tue,  2 Nov 2021 15:18:11 +0000 (UTC)
Received: from T590 (ovpn-8-19.pek2.redhat.com [10.72.8.19])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D981F60C82;
        Tue,  2 Nov 2021 15:17:44 +0000 (UTC)
Date:   Tue, 2 Nov 2021 23:17:39 +0800
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
Message-ID: <YYFWkwHSK1Px9cEo@T590>
References: <alpine.LSU.2.21.2110190820590.15009@pobox.suse.cz>
 <YW6OptglA6UykZg/@T590>
 <alpine.LSU.2.21.2110200835490.26817@pobox.suse.cz>
 <YW/KEsfWJMIPnz76@T590>
 <alpine.LSU.2.21.2110201014400.26817@pobox.suse.cz>
 <YW/q70dLyF+YudyF@T590>
 <YXfA0jfazCPDTEBw@alley>
 <YXgguuAY5iEUIV0u@T590>
 <YYFH85CmVOYIMdYh@alley>
 <YYFQdWvpXOV4foyS@alley>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YYFQdWvpXOV4foyS@alley>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Nov 02, 2021 at 03:51:33PM +0100, Petr Mladek wrote:
> On Tue 2021-11-02 15:15:19, Petr Mladek wrote:
> > On Tue 2021-10-26 23:37:30, Ming Lei wrote:
> > > On Tue, Oct 26, 2021 at 10:48:18AM +0200, Petr Mladek wrote:
> > > > Below are more details about the livepatch code. I hope that it will
> > > > help you to see if zram has similar problems or not.
> > > > 
> > > > We have kobject in three structures: klp_func, klp_object, and
> > > > klp_patch, see include/linux/livepatch.h.
> > > > 
> > > > These structures have to be statically defined in the module sources
> > > > because they define what is livepatched, see
> > > > samples/livepatch/livepatch-sample.c
> > > > 
> > > > The kobject is used there to show information about the patch, patched
> > > > objects, and patched functions, in sysfs. And most importantly,
> > > > the sysfs interface can be used to disable the livepatch.
> > > > 
> > > > The problem with static structures is that the module must stay
> > > > in the memory as long as the sysfs interface exists. It can be
> > > > solved in module_exit() callback. It could wait until the sysfs
> > > > interface is destroyed.
> > > > 
> > > > kobject API does not support this scenario. The relase() callbacks
> > > 
> > > kobject_delete() is for supporting this scenario, that is why we don't
> > > need to grab module refcnt before calling show()/store() of the
> > > kobject's attributes.
> > > 
> > > kobject_delete() can be called in module_exit(), then any show()/store()
> > > will be done after kobject_delete() returns.
> > 
> > I am a bit confused. I do not see kobject_delete() anywhere in kernel
> > sources.
> > 
> > I see only kobject_del() and kobject_put(). AFAIK, they do _not_
> > guarantee that either the sysfs interface was destroyed or
> > the release callbacks were called. For example, see
> > schedule_delayed_work(&kobj->release, delay) in kobject_release().
> 
> Grr, I always get confused by the code. kobject_del() actually waits
> until the sysfs interface gets destroyed. This is why there is
> the deadlock.

Right.

> 
> But kobject_put() is _not_ synchronous. And the comment above
> kobject_add() repeat 3 times that kobject_put() must be called
> on success:
> 
>  * Return: If this function returns an error, kobject_put() must be
>  *         called to properly clean up the memory associated with the
>  *         object.  Under no instance should the kobject that is passed
>  *         to this function be directly freed with a call to kfree(),
>  *         that can leak memory.
>  *
>  *         If this function returns success, kobject_put() must also be called
>  *         in order to properly clean up the memory associated with the object.
>  *
>  *         In short, once this function is called, kobject_put() MUST be called
>  *         when the use of the object is finished in order to properly free
>  *         everything.
> 
> and similar text in Documentation/core-api/kobject.rst
> 
>   After a kobject has been registered with the kobject core successfully, it
>   must be cleaned up when the code is finished with it.  To do that, call
>   kobject_put().
> 
> 
> If I read the code correctly then kobject_put() calls kref_put()
> that might call kobject_delayed_cleanup(). This function does a lot
> of things and need to access struct kobject.

Yes, then what is the problem here wrt. kobject_put() which may not be
synchronous?

> 
> > IMHO, kobject API does not support static structures and module
> > removal.
> 
> If kobject_put() has to be called also for static structures then
> module_exit() must explicitly wait until the clean up is finished.

Right, that is exactly how klp_patch kobject is implemented. klp_patch
kobject has to be disabled first, then module refcnt can be dropped after
the klp_patch kobject is released. Then module_exit() is possible.

Thanks,
Ming

