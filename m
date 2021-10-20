Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D84F14348AB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Oct 2021 12:10:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230158AbhJTKM6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 Oct 2021 06:12:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:23115 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230090AbhJTKM4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 Oct 2021 06:12:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634724641;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=iVYvpCAnj9ExJE6+BU/e/+6ORCn7prDFiQBrCjeMj74=;
        b=TkJM2guU1gLshwYEInWMDrPHylEFgFVKcQIEVqgguC89fTB49/RiQJhLN7sbQmUjGtdJZR
        FcFL7TOVgwgp20/Iwzx+2NqsdI2ht4XejbIFiRX45sDQT1eVqQo7jusUbBWJJzgkSItc8Q
        zSDl43E1Q6ttpv2aUIcSzlzXKFw3D34=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-262-SDebCvAIP7iyuPJjpM4UEw-1; Wed, 20 Oct 2021 06:10:38 -0400
X-MC-Unique: SDebCvAIP7iyuPJjpM4UEw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4EC83802575;
        Wed, 20 Oct 2021 10:10:35 +0000 (UTC)
Received: from T590 (ovpn-8-41.pek2.redhat.com [10.72.8.41])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A511D7621D;
        Wed, 20 Oct 2021 10:09:56 +0000 (UTC)
Date:   Wed, 20 Oct 2021 18:09:51 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Miroslav Benes <mbenes@suse.cz>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
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
Message-ID: <YW/q70dLyF+YudyF@T590>
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
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
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

OK, then it isn't one common usage, in which kobject covers the release
of the external object. What is the exact kobject in livepatching?

But kobject_del() won't release the kobject, you shouldn't need the lock
to delete kobject first. After the kobject is deleted, no any show() and
store() any more, isn't such sync[1] you expected?


Thanks,
Ming

