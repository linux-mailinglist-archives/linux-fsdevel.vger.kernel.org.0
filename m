Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DF9E443185
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Nov 2021 16:24:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234339AbhKBP0t (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 2 Nov 2021 11:26:49 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:56644 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231721AbhKBP0t (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 2 Nov 2021 11:26:49 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 4CF42218B8;
        Tue,  2 Nov 2021 15:24:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1635866650; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=20RoZlkpCStiyYhOpg9TxIwqB6XP6FGIk+CxFOjfgeQ=;
        b=mH/HYqrgUC286FNV17ooHrSpqz0QxJaEA4gqCu8YSuFavlUVjcNclsFdd9vpEcjU4T1EWe
        bCwYUnf+FgIGtgAvlwyq0SvUiSpGIPfWdx0lQnbh1+ec9SrxF+L+fnbM15px/lY04IQ1m3
        VwstO6btwTo9UpMWzrGrsBPlQOpP034=
Received: from suse.cz (unknown [10.100.216.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 3278AA3B83;
        Tue,  2 Nov 2021 15:24:09 +0000 (UTC)
Date:   Tue, 2 Nov 2021 16:24:06 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Miroslav Benes <mbenes@suse.cz>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Ming Lei <ming.lei@redhat.com>,
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
        live-patching@vger.kernel.org
Subject: Re: [PATCH v8 11/12] zram: fix crashes with cpu hotplug multistate
Message-ID: <YYFYFrnhwPiyOtst@alley>
References: <alpine.LSU.2.21.2110190820590.15009@pobox.suse.cz>
 <YW6OptglA6UykZg/@T590>
 <alpine.LSU.2.21.2110200835490.26817@pobox.suse.cz>
 <YW/KEsfWJMIPnz76@T590>
 <alpine.LSU.2.21.2110201014400.26817@pobox.suse.cz>
 <YW/q70dLyF+YudyF@T590>
 <YXfA0jfazCPDTEBw@alley>
 <YXgguuAY5iEUIV0u@T590>
 <YXg0dFZ+6qHw7d0g@bombadil.infradead.org>
 <alpine.LSU.2.21.2110271343290.3655@pobox.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LSU.2.21.2110271343290.3655@pobox.suse.cz>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 2021-10-27 13:57:40, Miroslav Benes wrote:
> On Tue, 26 Oct 2021, Luis Chamberlain wrote:
> 
> > On Tue, Oct 26, 2021 at 11:37:30PM +0800, Ming Lei wrote:
> > > On Tue, Oct 26, 2021 at 10:48:18AM +0200, Petr Mladek wrote:
> > > > Livepatch code never called kobject_del() under a lock. It would cause
> > > > the obvious deadlock.

I have to correct myself. IMHO, the deadlock is far from obvious. I
always get lost in the code and the documentation is not clear.
I always get lost.

> >
> > Never?
> 
> kobject_put() to be precise.

IMHO, the problem is actually with kobject_del() that gets blocked
until the sysfs interface gets removed. kobject_put() will have
the same problem only when the clean up is not delayed.


> When I started working on the support for module/live patches removal, 
> calling kobject_put() under our klp_mutex lock was the obvious first 
> choice given how the code was structured, but I ran into problems with 
> deadlocks immediately. So it was changed to async approach with the 
> workqueue. Thus the mainline code has never suffered from this, but we 
> knew about the issues.
>  
> > > > The historic code only waited in the
> > > > module_exit() callback until the sysfs interface was removed.
> > > 
> > > OK, then Luis shouldn't consider livepatching as one such issue to solve
> > > with one generic solution.
> > 
> > It's not what I was told when the deadlock was found with zram, so I was
> > informed quite the contrary.
> 
> >From my perspective, it is quite easy to get it wrong due to either a lack 
> of generic support, or missing rules/documentation. So if this thread 
> leads to "do not share locks between a module removal and a sysfs 
> operation" strict rule, it would be at least something. In the same 
> manner as Luis proposed to document try_module_get() expectations.

The rule "do not share locks between a module removal and a sysfs
operation" is not clear to me.

IMHO, there are the following rules:

1. rule: kobject_del() or kobject_put() must not be called under a lock that
	 is used by store()/show() callbacks.

   reason: kobject_del() waits until the sysfs interface is destroyed.
	 It has to wait until all store()/show() callbacks are finished.


2. rule: kobject_del()/kobject_put() must not be called from the
	related store() callbacks.

   reason: same as in 1st rule.


3. rule: module_exit() must wait until all release() callbacks are called
	 when kobject are static.

   reason: kobject_put() must be called to clean up internal
	dependencies. The clean up might be done asynchronously
	and need access to the kobject structure.


Best Regards,
Petr

PS: I am sorry if I am messing things. I want to be sure that we are
    all talking about the same and understand it the same way.
    
