Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A745443A32
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Nov 2021 01:02:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231160AbhKCAE4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 2 Nov 2021 20:04:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:46065 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230076AbhKCAEx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 2 Nov 2021 20:04:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635897737;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cqJQisP1QPS+4wMPSGYJMWn3HlqeTze3DoRoDxtXcVY=;
        b=GyqQRGH4VTnUxI0N5vS1P/FfK1sSF5cXnLuCaqPxyDgMqbU7og0hDIaq+XYlbZ5uWBjkwm
        P0259Oiv0XqGwdZbqfRKq5CqUKG0ThqMIR+DULJ5ATCygK203JpWVa/aFk4o8gMDewLVcb
        sgBzOcwIV5PG6SlObC3ypWYU9n+jNu4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-469-bzhDjEpxNyW8kBJ_BBDKpQ-1; Tue, 02 Nov 2021 20:02:14 -0400
X-MC-Unique: bzhDjEpxNyW8kBJ_BBDKpQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E769A8066EB;
        Wed,  3 Nov 2021 00:02:09 +0000 (UTC)
Received: from T590 (ovpn-8-17.pek2.redhat.com [10.72.8.17])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9128C60C0F;
        Wed,  3 Nov 2021 00:01:49 +0000 (UTC)
Date:   Wed, 3 Nov 2021 08:01:45 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Petr Mladek <pmladek@suse.com>, Miroslav Benes <mbenes@suse.cz>,
        Julia Lawall <julia.lawall@inria.fr>,
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
Message-ID: <YYHRaYlglX84lxB6@T590>
References: <alpine.LSU.2.21.2110200835490.26817@pobox.suse.cz>
 <YW/KEsfWJMIPnz76@T590>
 <alpine.LSU.2.21.2110201014400.26817@pobox.suse.cz>
 <YW/q70dLyF+YudyF@T590>
 <YXfA0jfazCPDTEBw@alley>
 <YXgguuAY5iEUIV0u@T590>
 <YXg0dFZ+6qHw7d0g@bombadil.infradead.org>
 <alpine.LSU.2.21.2110271343290.3655@pobox.suse.cz>
 <YYFYFrnhwPiyOtst@alley>
 <YYFmiAAYIA2X7Uv5@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YYFmiAAYIA2X7Uv5@bombadil.infradead.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Nov 02, 2021 at 09:25:44AM -0700, Luis Chamberlain wrote:
> On Tue, Nov 02, 2021 at 04:24:06PM +0100, Petr Mladek wrote:
> > On Wed 2021-10-27 13:57:40, Miroslav Benes wrote:
> > > >From my perspective, it is quite easy to get it wrong due to either a lack 
> > > of generic support, or missing rules/documentation. So if this thread 
> > > leads to "do not share locks between a module removal and a sysfs 
> > > operation" strict rule, it would be at least something. In the same 
> > > manner as Luis proposed to document try_module_get() expectations.
> > 
> > The rule "do not share locks between a module removal and a sysfs
> > operation" is not clear to me.
> 
> That's exactly it. It *is* not. The test_sysfs selftest will hopefully
> help with this. But I'll wait to take a final position on whether or not
> a generic fix should be merged until the Coccinelle patch which looks
> for all uses cases completes.
> 
> So I think that once that Coccinelle hunt is done for the deadlock, we
> should also remind folks of the potential deadlock and some of the rules
> you mentioned below so that if we take a position that we don't support
> this, we at least inform developers why and what to avoid. If Coccinelle
> finds quite a bit of cases, then perhaps evaluating the generic fix
> might be worth evaluating.
> 
> > IMHO, there are the following rules:
> > 
> > 1. rule: kobject_del() or kobject_put() must not be called under a lock that
> > 	 is used by store()/show() callbacks.
> > 
> >    reason: kobject_del() waits until the sysfs interface is destroyed.
> > 	 It has to wait until all store()/show() callbacks are finished.
> 
> Right, this is what actually started this entire conversation.
> 
> Note that as Ming pointed out, the generic kernfs fix I proposed would
> only cover the case when kobject_del() ends up being called on module
> exit, so it would not cover the cases where perhaps kobject_del() might
> be called outside of module exit, and so the cope of the possible
> deadlock then increases in scope.
> 
> Likewise, the Coccinelle hunt I'm trying would only cover the module
> exit case. I'm a bit of afraid of the complexity of a generic hunt
> as expresed in rule 1.

Question is that why one shared lock is required between kobject_del()
and its show()/store(), both zram and livepatch needn't that. Is it
one common usage?

> 
> > 
> > 2. rule: kobject_del()/kobject_put() must not be called from the
> > 	related store() callbacks.
> > 
> >    reason: same as in 1st rule.
> 
> Sensible corollary.
> 
> Given tha the exact kobjet_del() / kobject_put() which must not be
> called from the respective sysfs ops depends on which kobject is
> underneath the device for which the sysfs ops is being created,
> it would make this hunt in Coccinelle a bit tricky. My current iteration
> of a coccinelle hunt cheats and looks at any sysfs looking op and
> ensures a module exit exists.

Actually kernfs/sysfs provides interface for supporting deleting
kobject/attr from the attr's show()/store(), see example of
sdev_store_delete(), and the livepatch example:

https://lore.kernel.org/lkml/20211102145932.3623108-4-ming.lei@redhat.com/

> 
> > 3. rule: module_exit() must wait until all release() callbacks are called
> > 	 when kobject are static.
> > 
> >    reason: kobject_put() must be called to clean up internal
> > 	dependencies. The clean up might be done asynchronously
> > 	and need access to the kobject structure.
> 
> This might be an easier rule to implement a respective Coccinelle rule
> for.

If kobject_del() is done in module_exit() or before module_exit(),
kobject should have been freed in module_exit() via kobject_put().

But yes, it can be asynchronously because of CONFIG_DEBUG_KOBJECT_RELEASE,
seems like one real issue.


Thanks,
Ming

