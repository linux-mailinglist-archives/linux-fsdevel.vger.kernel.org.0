Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 342F14346E6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Oct 2021 10:28:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229836AbhJTIbL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 Oct 2021 04:31:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:40668 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229632AbhJTIbK (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 Oct 2021 04:31:10 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3E5CF61183;
        Wed, 20 Oct 2021 08:28:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1634718536;
        bh=8nW1a1YxwhHLkokHLmbAPUvEy8Sro976Y9vnhAQOL7U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=b5OhBK9vzw98Pra6K1wa2zJ0J5EzHVm1XCT+E1fH6mcqn/K9AU7vR477/yH5qRf2Y
         SwAeIQb04+15xwtWK1Tt7kdQGvlEAp4HnJ10Ae/gbnnLHh9ON0GTMtaH9GB8htEXdC
         PEBT4jNWWKAtQNxw7vujFQeR5PU+4RP0ONCEkVl4=
Date:   Wed, 20 Oct 2021 10:28:54 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Miroslav Benes <mbenes@suse.cz>
Cc:     Ming Lei <ming.lei@redhat.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>, tj@kernel.org,
        akpm@linux-foundation.org, minchan@kernel.org, jeyu@kernel.org,
        shuah@kernel.org, bvanassche@acm.org, dan.j.williams@intel.com,
        joe@perches.com, tglx@linutronix.de, keescook@chromium.org,
        rostedt@goodmis.org, linux-spdx@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, live-patching@vger.kernel.org
Subject: Re: [PATCH v8 11/12] zram: fix crashes with cpu hotplug multistate
Message-ID: <YW/TRkXth/mbTQ6b@kroah.com>
References: <YWk9e957Hb+I7HvR@T590>
 <YWm68xUnAofop3PZ@bombadil.infradead.org>
 <YWq3Z++uoJ/kcp+3@T590>
 <YW3LuzaPhW96jSBK@bombadil.infradead.org>
 <YW4uwep3BCe9Vxq8@T590>
 <alpine.LSU.2.21.2110190820590.15009@pobox.suse.cz>
 <YW6OptglA6UykZg/@T590>
 <alpine.LSU.2.21.2110200835490.26817@pobox.suse.cz>
 <YW/KEsfWJMIPnz76@T590>
 <alpine.LSU.2.21.2110201014400.26817@pobox.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LSU.2.21.2110201014400.26817@pobox.suse.cz>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Oct 20, 2021 at 10:19:27AM +0200, Miroslav Benes wrote:
> On Wed, 20 Oct 2021, Ming Lei wrote:
> 
> > On Wed, Oct 20, 2021 at 08:43:37AM +0200, Miroslav Benes wrote:
> > > On Tue, 19 Oct 2021, Ming Lei wrote:
> > > 
> > > > On Tue, Oct 19, 2021 at 08:23:51AM +0200, Miroslav Benes wrote:
> > > > > > > By you only addressing the deadlock as a requirement on approach a) you are
> > > > > > > forgetting that there *may* already be present drivers which *do* implement
> > > > > > > such patterns in the kernel. I worked on addressing the deadlock because
> > > > > > > I was informed livepatching *did* have that issue as well and so very
> > > > > > > likely a generic solution to the deadlock could be beneficial to other
> > > > > > > random drivers.
> > > > > > 
> > > > > > In-tree zram doesn't have such deadlock, if livepatching has such AA deadlock,
> > > > > > just fixed it, and seems it has been fixed by 3ec24776bfd0.
> > > > > 
> > > > > I would not call it a fix. It is a kind of ugly workaround because the 
> > > > > generic infrastructure lacked (lacks) the proper support in my opinion. 
> > > > > Luis is trying to fix that.
> > > > 
> > > > What is the proper support of the generic infrastructure? I am not
> > > > familiar with livepatching's model(especially with module unload), you mean
> > > > livepatching have to do the following way from sysfs:
> > > > 
> > > > 1) during module exit:
> > > > 	
> > > > 	mutex_lock(lp_lock);
> > > > 	kobject_put(lp_kobj);
> > > > 	mutex_unlock(lp_lock);
> > > > 	
> > > > 2) show()/store() method of attributes of lp_kobj
> > > > 	
> > > > 	mutex_lock(lp_lock)
> > > > 	...
> > > > 	mutex_unlock(lp_lock)
> > > 
> > > Yes, this was exactly the case. We then reworked it a lot (see 
> > > 958ef1e39d24 ("livepatch: Simplify API by removing registration step"), so 
> > > now the call sequence is different. kobject_put() is basically offloaded 
> > > to a workqueue scheduled right from the store() method. Meaning that 
> > > Luis's work would probably not help us currently, but on the other hand 
> > > the issues with AA deadlock were one of the main drivers of the redesign 
> > > (if I remember correctly). There were other reasons too as the changelog 
> > > of the commit describes.
> > > 
> > > So, from my perspective, if there was a way to easily synchronize between 
> > > a data cleanup from module_exit callback and sysfs/kernfs operations, it 
> > > could spare people many headaches.
> > 
> > kobject_del() is supposed to do so, but you can't hold a shared lock
> > which is required in show()/store() method. Once kobject_del() returns,
> > no pending show()/store() any more.
> > 
> > The question is that why one shared lock is required for livepatching to
> > delete the kobject. What are you protecting when you delete one kobject?
> 
> I think it boils down to the fact that we embed kobject statically to 
> structures which livepatch uses to maintain data. That is discouraged 
> generally, but all the attempts to implement it correctly were utter 
> failures.

Sounds like this is the real problem that needs to be fixed.  kobjects
should always control the lifespan of the structure they are embedded
in.  If not, then that is a design flaw of the user of the kobject :(

Where in the kernel is this happening?  And where have been the attempts
to fix this up?

thanks,

greg k-h
