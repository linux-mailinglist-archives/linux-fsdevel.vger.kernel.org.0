Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62F48434554
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Oct 2021 08:43:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229822AbhJTGpy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 Oct 2021 02:45:54 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:35098 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbhJTGpx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 Oct 2021 02:45:53 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id E871121A74;
        Wed, 20 Oct 2021 06:43:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1634712217; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rNHGewS1yJSMHeXcGNkiPH4/vSqZ+kkloqucx8CrHpg=;
        b=xaE2gnmQOesLnomNZFvJ0r1pNN1Ha5LABsYOH5p9EvC62iNKUw3U+HkW9BHEOSHWmVkg57
        v3e5QjRkN0kJ1LMa4LOcTq7lEbgvtEmIM7xkdKx+sZpMeGZ9qNOEI0qF8Jua8wWo2GWSXy
        k1c4uaE+0f7BF7q5mqJQHYQ2yrySS/g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1634712217;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rNHGewS1yJSMHeXcGNkiPH4/vSqZ+kkloqucx8CrHpg=;
        b=hQautgroTigJwzFHF1d+IXOU6BywnWwjsMxbnt810LVJ8uC7aXRTFWkw0nwWrh6mRaIT74
        k14k8MQMA7a4pcDQ==
Received: from pobox.suse.cz (pobox.suse.cz [10.100.2.14])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 25BA9A3B81;
        Wed, 20 Oct 2021 06:43:37 +0000 (UTC)
Date:   Wed, 20 Oct 2021 08:43:37 +0200 (CEST)
From:   Miroslav Benes <mbenes@suse.cz>
To:     Ming Lei <ming.lei@redhat.com>
cc:     Luis Chamberlain <mcgrof@kernel.org>,
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
In-Reply-To: <YW6OptglA6UykZg/@T590>
Message-ID: <alpine.LSU.2.21.2110200835490.26817@pobox.suse.cz>
References: <YWeR4moCRh+ZHOmH@T590> <YWiSAN6xfYcUDJCb@bombadil.infradead.org> <YWjCpLUNPF3s4P2U@T590> <YWjJ0O7K+31Iz3ox@bombadil.infradead.org> <YWk9e957Hb+I7HvR@T590> <YWm68xUnAofop3PZ@bombadil.infradead.org> <YWq3Z++uoJ/kcp+3@T590> <YW3LuzaPhW96jSBK@bombadil.infradead.org>
 <YW4uwep3BCe9Vxq8@T590> <alpine.LSU.2.21.2110190820590.15009@pobox.suse.cz> <YW6OptglA6UykZg/@T590>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 19 Oct 2021, Ming Lei wrote:

> On Tue, Oct 19, 2021 at 08:23:51AM +0200, Miroslav Benes wrote:
> > > > By you only addressing the deadlock as a requirement on approach a) you are
> > > > forgetting that there *may* already be present drivers which *do* implement
> > > > such patterns in the kernel. I worked on addressing the deadlock because
> > > > I was informed livepatching *did* have that issue as well and so very
> > > > likely a generic solution to the deadlock could be beneficial to other
> > > > random drivers.
> > > 
> > > In-tree zram doesn't have such deadlock, if livepatching has such AA deadlock,
> > > just fixed it, and seems it has been fixed by 3ec24776bfd0.
> > 
> > I would not call it a fix. It is a kind of ugly workaround because the 
> > generic infrastructure lacked (lacks) the proper support in my opinion. 
> > Luis is trying to fix that.
> 
> What is the proper support of the generic infrastructure? I am not
> familiar with livepatching's model(especially with module unload), you mean
> livepatching have to do the following way from sysfs:
> 
> 1) during module exit:
> 	
> 	mutex_lock(lp_lock);
> 	kobject_put(lp_kobj);
> 	mutex_unlock(lp_lock);
> 	
> 2) show()/store() method of attributes of lp_kobj
> 	
> 	mutex_lock(lp_lock)
> 	...
> 	mutex_unlock(lp_lock)

Yes, this was exactly the case. We then reworked it a lot (see 
958ef1e39d24 ("livepatch: Simplify API by removing registration step"), so 
now the call sequence is different. kobject_put() is basically offloaded 
to a workqueue scheduled right from the store() method. Meaning that 
Luis's work would probably not help us currently, but on the other hand 
the issues with AA deadlock were one of the main drivers of the redesign 
(if I remember correctly). There were other reasons too as the changelog 
of the commit describes.

So, from my perspective, if there was a way to easily synchronize between 
a data cleanup from module_exit callback and sysfs/kernfs operations, it 
could spare people many headaches.
 
> IMO, the above usage simply caused AA deadlock. Even in Luis's patch
> 'zram: fix crashes with cpu hotplug multistate', new/same AA deadlock
> (hot_remove_store() vs. disksize_store() or reset_store()) is added
> because hot_remove_store() isn't called from module_exit().
> 
> Luis tries to delay unloading module until all show()/store() are done. But
> that can be obtained by the following way simply during module_exit():
> 
> 	kobject_del(lp_kobj); //all pending store()/show() from lp_kobj are done,
> 						  //no new store()/show() can come after
> 						  //kobject_del() returns	
> 	mutex_lock(lp_lock);
> 	kobject_put(lp_kobj);
> 	mutex_unlock(lp_lock);

kobject_del() already calls kobject_put(). Did you mean __kobject_del(). 
That one is internal though.
 
> Or can you explain your requirement on kobject/module unload in a bit
> details?

Does the above makes sense?

Thanks

Miroslav
