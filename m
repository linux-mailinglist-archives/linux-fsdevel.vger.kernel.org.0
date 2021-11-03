Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 624F74441D3
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Nov 2021 13:44:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232065AbhKCMrX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 3 Nov 2021 08:47:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231607AbhKCMrW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 3 Nov 2021 08:47:22 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 352DBC061714;
        Wed,  3 Nov 2021 05:44:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=gpy0rb9TMQVhfKqmlvxAKW6M4Lhkal+b7lCoTi8Nt8k=; b=E1cD3yN9thIRR4H2Zt+eObWqVq
        7AE8CKvZsp4k3hBWN+N7pomee5XyqYLM215Op3CzrjFH7WENkN2RPKyy1+fMKotg6zBkqRrDg7YEv
        gL1aXKjsnkwiNlpL8Jk6DHd5iZ+EwQtNIhkJtzb0me8LnSkQq6lc2JolW2/84EGpd8kthuSvJeeUE
        R0LMa6ssO94HE/OFkbjmaB4XU5vXVUIqyd4+vgcxZfDwF8fqj7+Ig1vMD67BdVW7/KKzssqIF43MS
        kzKwv3tLWTgFYWd4aNLNwIqtpSKiupiSXufptm3u2ZtJl86ykpba2tNrktOJdW6TgGs045v4fR1pf
        F0uYZayg==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1miFcz-005EEC-6c; Wed, 03 Nov 2021 12:44:29 +0000
Date:   Wed, 3 Nov 2021 05:44:29 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Ming Lei <ming.lei@redhat.com>
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
        live-patching@vger.kernel.org
Subject: Re: [PATCH v8 11/12] zram: fix crashes with cpu hotplug multistate
Message-ID: <YYKELZsUW1Ko/bVa@bombadil.infradead.org>
References: <YW/KEsfWJMIPnz76@T590>
 <alpine.LSU.2.21.2110201014400.26817@pobox.suse.cz>
 <YW/q70dLyF+YudyF@T590>
 <YXfA0jfazCPDTEBw@alley>
 <YXgguuAY5iEUIV0u@T590>
 <YXg0dFZ+6qHw7d0g@bombadil.infradead.org>
 <alpine.LSU.2.21.2110271343290.3655@pobox.suse.cz>
 <YYFYFrnhwPiyOtst@alley>
 <YYFmiAAYIA2X7Uv5@bombadil.infradead.org>
 <YYHRaYlglX84lxB6@T590>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YYHRaYlglX84lxB6@T590>
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Nov 03, 2021 at 08:01:45AM +0800, Ming Lei wrote:
> On Tue, Nov 02, 2021 at 09:25:44AM -0700, Luis Chamberlain wrote:
> > On Tue, Nov 02, 2021 at 04:24:06PM +0100, Petr Mladek wrote:
> > > On Wed 2021-10-27 13:57:40, Miroslav Benes wrote:
> > > > >From my perspective, it is quite easy to get it wrong due to either a lack 
> > > > of generic support, or missing rules/documentation. So if this thread 
> > > > leads to "do not share locks between a module removal and a sysfs 
> > > > operation" strict rule, it would be at least something. In the same 
> > > > manner as Luis proposed to document try_module_get() expectations.
> > > 
> > > The rule "do not share locks between a module removal and a sysfs
> > > operation" is not clear to me.
> > 
> > That's exactly it. It *is* not. The test_sysfs selftest will hopefully
> > help with this. But I'll wait to take a final position on whether or not
> > a generic fix should be merged until the Coccinelle patch which looks
> > for all uses cases completes.
> > 
> > So I think that once that Coccinelle hunt is done for the deadlock, we
> > should also remind folks of the potential deadlock and some of the rules
> > you mentioned below so that if we take a position that we don't support
> > this, we at least inform developers why and what to avoid. If Coccinelle
> > finds quite a bit of cases, then perhaps evaluating the generic fix
> > might be worth evaluating.
> > 
> > > IMHO, there are the following rules:
> > > 
> > > 1. rule: kobject_del() or kobject_put() must not be called under a lock that
> > > 	 is used by store()/show() callbacks.
> > > 
> > >    reason: kobject_del() waits until the sysfs interface is destroyed.
> > > 	 It has to wait until all store()/show() callbacks are finished.
> > 
> > Right, this is what actually started this entire conversation.
> > 
> > Note that as Ming pointed out, the generic kernfs fix I proposed would
> > only cover the case when kobject_del() ends up being called on module
> > exit, so it would not cover the cases where perhaps kobject_del() might
> > be called outside of module exit, and so the cope of the possible
> > deadlock then increases in scope.
> > 
> > Likewise, the Coccinelle hunt I'm trying would only cover the module
> > exit case. I'm a bit of afraid of the complexity of a generic hunt
> > as expresed in rule 1.
> 
> Question is that why one shared lock is required between kobject_del()
> and its show()/store(), both zram and livepatch needn't that. Is it
> one common usage?

That is the question the coccinelle hunt is aimed at finding. Answering
that in the context of module removal is easier than the generic case.

But also note that I had mentioned before that we have semantics to
check *when* we're in the module removal case, and as such can address
that case. For the other cases we have no possible semantics to be able to
address a generic fix. I tried though, refer to my reply in this
thread and refer to the new kobject_being_removed() I'm adding:

https://lkml.kernel.org/r/YWdMpv8lAFYtc18c@bombadil.infradead.org

So we have semantics for knowing when about to remove a module but,
my attempt with kobject_being_removed() isn't sufficient to address this
generically.

In either case, having a gauge of how common this is either on module
removal of generally would be wonderful. It is easier to answer the
question from a module removal perspective though.

> > > 2. rule: kobject_del()/kobject_put() must not be called from the
> > > 	related store() callbacks.
> > > 
> > >    reason: same as in 1st rule.
> > 
> > Sensible corollary.
> > 
> > Given tha the exact kobjet_del() / kobject_put() which must not be
> > called from the respective sysfs ops depends on which kobject is
> > underneath the device for which the sysfs ops is being created,
> > it would make this hunt in Coccinelle a bit tricky. My current iteration
> > of a coccinelle hunt cheats and looks at any sysfs looking op and
> > ensures a module exit exists.
> 
> Actually kernfs/sysfs provides interface for supporting deleting
> kobject/attr from the attr's show()/store(), see example of
> sdev_store_delete(), and the livepatch example:
> 
> https://lore.kernel.org/lkml/20211102145932.3623108-4-ming.lei@redhat.com/

Imagine that.. is that the suicidal thing?

> > > 3. rule: module_exit() must wait until all release() callbacks are called
> > > 	 when kobject are static.
> > > 
> > >    reason: kobject_put() must be called to clean up internal
> > > 	dependencies. The clean up might be done asynchronously
> > > 	and need access to the kobject structure.
> > 
> > This might be an easier rule to implement a respective Coccinelle rule
> > for.
> 
> If kobject_del() is done in module_exit() or before module_exit(),
> kobject should have been freed in module_exit() via kobject_put().
> 
> But yes, it can be asynchronously because of CONFIG_DEBUG_KOBJECT_RELEASE,
> seems like one real issue.

Alright thanks for confirming.

  Luis
