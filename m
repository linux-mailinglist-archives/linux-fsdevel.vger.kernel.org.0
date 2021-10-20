Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0525C4346B0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Oct 2021 10:19:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229823AbhJTIVr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 Oct 2021 04:21:47 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:57584 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbhJTIVo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 Oct 2021 04:21:44 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 349451FD47;
        Wed, 20 Oct 2021 08:19:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1634717968; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fF05nAEyjqTbx+MUMonWp9IUBJlR+Dw6z0QwyteEkTw=;
        b=sQPHPToG2Fvjnup+4BPVwdAuh2cpg/MRibClRF00pE0aOFX5rilYheDOWuia/OCg/V/Zqr
        6REGrweU2AtByO+aaYSQVXNMPeJju96CaKJFs3yacalq0i8KIy1xtdK+k6XVPL8SZYI+Qk
        40JHGxGTsVeLpcQkwUsXUKfJpmik9zY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1634717968;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fF05nAEyjqTbx+MUMonWp9IUBJlR+Dw6z0QwyteEkTw=;
        b=pNe6tBQODotEc2aHu+V64wYMh/dMMgW2yUPDrkGUUEYB33K5zemch5GehR+z1c3tBJETQ5
        z80x/CcyVZDgqDDQ==
Received: from pobox.suse.cz (pobox.suse.cz [10.100.2.14])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 8E7F6A3B84;
        Wed, 20 Oct 2021 08:19:27 +0000 (UTC)
Date:   Wed, 20 Oct 2021 10:19:27 +0200 (CEST)
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
In-Reply-To: <YW/KEsfWJMIPnz76@T590>
Message-ID: <alpine.LSU.2.21.2110201014400.26817@pobox.suse.cz>
References: <YWjCpLUNPF3s4P2U@T590> <YWjJ0O7K+31Iz3ox@bombadil.infradead.org> <YWk9e957Hb+I7HvR@T590> <YWm68xUnAofop3PZ@bombadil.infradead.org> <YWq3Z++uoJ/kcp+3@T590> <YW3LuzaPhW96jSBK@bombadil.infradead.org> <YW4uwep3BCe9Vxq8@T590>
 <alpine.LSU.2.21.2110190820590.15009@pobox.suse.cz> <YW6OptglA6UykZg/@T590> <alpine.LSU.2.21.2110200835490.26817@pobox.suse.cz> <YW/KEsfWJMIPnz76@T590>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 20 Oct 2021, Ming Lei wrote:

> On Wed, Oct 20, 2021 at 08:43:37AM +0200, Miroslav Benes wrote:
> > On Tue, 19 Oct 2021, Ming Lei wrote:
> > 
> > > On Tue, Oct 19, 2021 at 08:23:51AM +0200, Miroslav Benes wrote:
> > > > > > By you only addressing the deadlock as a requirement on approach a) you are
> > > > > > forgetting that there *may* already be present drivers which *do* implement
> > > > > > such patterns in the kernel. I worked on addressing the deadlock because
> > > > > > I was informed livepatching *did* have that issue as well and so very
> > > > > > likely a generic solution to the deadlock could be beneficial to other
> > > > > > random drivers.
> > > > > 
> > > > > In-tree zram doesn't have such deadlock, if livepatching has such AA deadlock,
> > > > > just fixed it, and seems it has been fixed by 3ec24776bfd0.
> > > > 
> > > > I would not call it a fix. It is a kind of ugly workaround because the 
> > > > generic infrastructure lacked (lacks) the proper support in my opinion. 
> > > > Luis is trying to fix that.
> > > 
> > > What is the proper support of the generic infrastructure? I am not
> > > familiar with livepatching's model(especially with module unload), you mean
> > > livepatching have to do the following way from sysfs:
> > > 
> > > 1) during module exit:
> > > 	
> > > 	mutex_lock(lp_lock);
> > > 	kobject_put(lp_kobj);
> > > 	mutex_unlock(lp_lock);
> > > 	
> > > 2) show()/store() method of attributes of lp_kobj
> > > 	
> > > 	mutex_lock(lp_lock)
> > > 	...
> > > 	mutex_unlock(lp_lock)
> > 
> > Yes, this was exactly the case. We then reworked it a lot (see 
> > 958ef1e39d24 ("livepatch: Simplify API by removing registration step"), so 
> > now the call sequence is different. kobject_put() is basically offloaded 
> > to a workqueue scheduled right from the store() method. Meaning that 
> > Luis's work would probably not help us currently, but on the other hand 
> > the issues with AA deadlock were one of the main drivers of the redesign 
> > (if I remember correctly). There were other reasons too as the changelog 
> > of the commit describes.
> > 
> > So, from my perspective, if there was a way to easily synchronize between 
> > a data cleanup from module_exit callback and sysfs/kernfs operations, it 
> > could spare people many headaches.
> 
> kobject_del() is supposed to do so, but you can't hold a shared lock
> which is required in show()/store() method. Once kobject_del() returns,
> no pending show()/store() any more.
> 
> The question is that why one shared lock is required for livepatching to
> delete the kobject. What are you protecting when you delete one kobject?

I think it boils down to the fact that we embed kobject statically to 
structures which livepatch uses to maintain data. That is discouraged 
generally, but all the attempts to implement it correctly were utter 
failures.

Miroslav
