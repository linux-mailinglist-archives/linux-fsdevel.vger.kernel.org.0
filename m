Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2D68439338
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Oct 2021 11:58:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232644AbhJYKBR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 25 Oct 2021 06:01:17 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:36442 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230297AbhJYKBQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 25 Oct 2021 06:01:16 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id EF03B2191E;
        Mon, 25 Oct 2021 09:58:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1635155932; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DT/OTBMCYlwriv5HWVIwUqv72OWQWapWNPJDICv0yPg=;
        b=W7Zw/nrZiA4UZbuSr/qogGK+E0KzuQF8C/nNafNbDs454vnam3HWvFibs3P3ppVLB573Pd
        pcjluKXWNEeN0GDQh0V3sb+bLG9doxPr4I5VO9O6qCviitGL7zqC2/IWdaz++RWuDqmEO8
        hPH/V5uiLhBHBPhm3hhY2gU0UrW7PTs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1635155932;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DT/OTBMCYlwriv5HWVIwUqv72OWQWapWNPJDICv0yPg=;
        b=GGtCOE9aHLrFGguQIcVEHQWTiUfWvyUjgN07MJk1AkEGOmaktxaEin5n25sR0a3Nu2OV5T
        gNPSgW4XevCQ0cCw==
Received: from pobox.suse.cz (pobox.suse.cz [10.100.2.14])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 57932A3B81;
        Mon, 25 Oct 2021 09:58:51 +0000 (UTC)
Date:   Mon, 25 Oct 2021 11:58:51 +0200 (CEST)
From:   Miroslav Benes <mbenes@suse.cz>
To:     Greg KH <gregkh@linuxfoundation.org>
cc:     Ming Lei <ming.lei@redhat.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>, tj@kernel.org,
        akpm@linux-foundation.org, minchan@kernel.org, jeyu@kernel.org,
        shuah@kernel.org, bvanassche@acm.org, dan.j.williams@intel.com,
        joe@perches.com, tglx@linutronix.de, keescook@chromium.org,
        rostedt@goodmis.org, linux-spdx@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, live-patching@vger.kernel.org,
        pmladek@suse.com
Subject: Re: [PATCH v8 11/12] zram: fix crashes with cpu hotplug multistate
In-Reply-To: <YW/TRkXth/mbTQ6b@kroah.com>
Message-ID: <alpine.LSU.2.21.2110251144270.7294@pobox.suse.cz>
References: <YWk9e957Hb+I7HvR@T590> <YWm68xUnAofop3PZ@bombadil.infradead.org> <YWq3Z++uoJ/kcp+3@T590> <YW3LuzaPhW96jSBK@bombadil.infradead.org> <YW4uwep3BCe9Vxq8@T590> <alpine.LSU.2.21.2110190820590.15009@pobox.suse.cz> <YW6OptglA6UykZg/@T590>
 <alpine.LSU.2.21.2110200835490.26817@pobox.suse.cz> <YW/KEsfWJMIPnz76@T590> <alpine.LSU.2.21.2110201014400.26817@pobox.suse.cz> <YW/TRkXth/mbTQ6b@kroah.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 20 Oct 2021, Greg KH wrote:

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
> Sounds like this is the real problem that needs to be fixed.  kobjects
> should always control the lifespan of the structure they are embedded
> in.  If not, then that is a design flaw of the user of the kobject :(

Right, and you've already told us. A couple of times.

For example 
here https://lore.kernel.org/all/20190502074230.GA27847@kroah.com/

:)
 
> Where in the kernel is this happening?  And where have been the attempts
> to fix this up?

include/linux/livepatch.h and kernel/livepatch/core.c. See 
klp_{patch,object,func}.

It took some archeology, but I think 
https://lore.kernel.org/all/1464018848-4303-1-git-send-email-pmladek@suse.com/ 
is it. Petr might correct me.

It was long before we added some important features to the code, so it 
might be even more difficult today.

It resurfaced later when Tobin tried to fix some of kobject call sites in 
the kernel...

https://lore.kernel.org/all/20190430001534.26246-1-tobin@kernel.org/
https://lore.kernel.org/all/20190430233803.GB10777@eros.localdomain/
https://lore.kernel.org/all/20190502023142.20139-6-tobin@kernel.org/

There are probably more references.

Anyway, the current code works fine (well, one could argue about that). If 
someone wants to take a (another) stab at this, then why not, but it 
seemed like a rabbit hole without a substantial gain in the past. On the 
other hand, we currently misuse the API to some extent.

/me scratches head

Miroslav
