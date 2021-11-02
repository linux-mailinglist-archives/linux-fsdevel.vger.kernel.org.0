Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD5464430FF
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Nov 2021 15:57:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234749AbhKBPAG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 2 Nov 2021 11:00:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:46767 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234789AbhKBO7N (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 2 Nov 2021 10:59:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635864997;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YG2VGNtE+69cPxmqVydtAL5vxJZLZtIYVVth/K03gCo=;
        b=XSEhU5dXP0h3cXByjFo2RLYrWRcMFJRi7FT4KBugkHi0HxNJ7g7WJFcWJ0SThp5FCMk25k
        NS7G1jR/p9SnmhLC0Y7VLaAPdug6/aTfOVJqz1RxeKy5mRKViJaKiVlASjxzL6hUJB9G2T
        Z53cMEGkPIVdST+x2XxaLrKBvDAmCk4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-487-0K9G4ltAMemdXrbZ-quSRA-1; Tue, 02 Nov 2021 10:56:34 -0400
X-MC-Unique: 0K9G4ltAMemdXrbZ-quSRA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C01F810A8E07;
        Tue,  2 Nov 2021 14:56:30 +0000 (UTC)
Received: from T590 (ovpn-8-19.pek2.redhat.com [10.72.8.19])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id F3B2D60657;
        Tue,  2 Nov 2021 14:56:19 +0000 (UTC)
Date:   Tue, 2 Nov 2021 22:56:14 +0800
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
Message-ID: <YYFRjpJcIaZ1AQRS@T590>
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
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Nov 02, 2021 at 03:15:15PM +0100, Petr Mladek wrote:
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

After kobject_del() returns, no one can call run into show()/store(),
and all pending show()/store() are drained meantime. But yes, the release
handler may still be called later, and the kobject has to be freed
during or before module_exit().

https://lore.kernel.org/lkml/20211101112548.3364086-2-ming.lei@redhat.com/

> 
> By other words, anyone could still be using either the sysfs interface
> or the related structures after kobject_del() or kobject_put()
> returns.

No, no one can do that after kobject_del() returns.

> 
> IMHO, kobject API does not support static structures and module
> removal.

But so far klp_patch can only be defined as static instance, and it
depends on the implementation, especially the release handler.


Thanks,
Ming

