Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 170FC4432E1
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Nov 2021 17:36:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234992AbhKBQjB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 2 Nov 2021 12:39:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234881AbhKBQir (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 2 Nov 2021 12:38:47 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E670CC0797BA;
        Tue,  2 Nov 2021 09:26:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ZpP/HZLv604vtvae1cO/0WFon0sSJn671oAr7ZIWFxw=; b=UCimNJ3QWb++sHLFKw51gCkQKn
        WWEC2X/M7um3LJKy9tXa7f8JPMslxJ5A40mI4Vct+q0Sv3gcUEgGzPrTFydyq7LDj4xgM8jIgE+YV
        X3uJS07PEiYfQYOrNERQyGwoz4X0qZhFpi7WHnrxKGXUXB6VAT6jwbyJRPrTKcwzCTgUhlBeArX0X
        zO89RZAmitmlNeBzM3i1PuQboNrclSbxS3a89BcNAExHk3J5/aTm3inLRkEvgG8Qe8rIDc2Dp0p5R
        RjMjMh0QsXI8sIp4RfVofx0u3LD67AbwsVH9w4I/TlAdY/7UhPA3WEEHPuDBki1Eo1czIcKWZnbaH
        DvYH7+8w==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mhwbY-002IBJ-2M; Tue, 02 Nov 2021 16:25:44 +0000
Date:   Tue, 2 Nov 2021 09:25:44 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Miroslav Benes <mbenes@suse.cz>, Ming Lei <ming.lei@redhat.com>,
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
Message-ID: <YYFmiAAYIA2X7Uv5@bombadil.infradead.org>
References: <YW6OptglA6UykZg/@T590>
 <alpine.LSU.2.21.2110200835490.26817@pobox.suse.cz>
 <YW/KEsfWJMIPnz76@T590>
 <alpine.LSU.2.21.2110201014400.26817@pobox.suse.cz>
 <YW/q70dLyF+YudyF@T590>
 <YXfA0jfazCPDTEBw@alley>
 <YXgguuAY5iEUIV0u@T590>
 <YXg0dFZ+6qHw7d0g@bombadil.infradead.org>
 <alpine.LSU.2.21.2110271343290.3655@pobox.suse.cz>
 <YYFYFrnhwPiyOtst@alley>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YYFYFrnhwPiyOtst@alley>
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Nov 02, 2021 at 04:24:06PM +0100, Petr Mladek wrote:
> On Wed 2021-10-27 13:57:40, Miroslav Benes wrote:
> > >From my perspective, it is quite easy to get it wrong due to either a lack 
> > of generic support, or missing rules/documentation. So if this thread 
> > leads to "do not share locks between a module removal and a sysfs 
> > operation" strict rule, it would be at least something. In the same 
> > manner as Luis proposed to document try_module_get() expectations.
> 
> The rule "do not share locks between a module removal and a sysfs
> operation" is not clear to me.

That's exactly it. It *is* not. The test_sysfs selftest will hopefully
help with this. But I'll wait to take a final position on whether or not
a generic fix should be merged until the Coccinelle patch which looks
for all uses cases completes.

So I think that once that Coccinelle hunt is done for the deadlock, we
should also remind folks of the potential deadlock and some of the rules
you mentioned below so that if we take a position that we don't support
this, we at least inform developers why and what to avoid. If Coccinelle
finds quite a bit of cases, then perhaps evaluating the generic fix
might be worth evaluating.

> IMHO, there are the following rules:
> 
> 1. rule: kobject_del() or kobject_put() must not be called under a lock that
> 	 is used by store()/show() callbacks.
> 
>    reason: kobject_del() waits until the sysfs interface is destroyed.
> 	 It has to wait until all store()/show() callbacks are finished.

Right, this is what actually started this entire conversation.

Note that as Ming pointed out, the generic kernfs fix I proposed would
only cover the case when kobject_del() ends up being called on module
exit, so it would not cover the cases where perhaps kobject_del() might
be called outside of module exit, and so the cope of the possible
deadlock then increases in scope.

Likewise, the Coccinelle hunt I'm trying would only cover the module
exit case. I'm a bit of afraid of the complexity of a generic hunt
as expresed in rule 1.

> 
> 2. rule: kobject_del()/kobject_put() must not be called from the
> 	related store() callbacks.
> 
>    reason: same as in 1st rule.

Sensible corollary.

Given tha the exact kobjet_del() / kobject_put() which must not be
called from the respective sysfs ops depends on which kobject is
underneath the device for which the sysfs ops is being created,
it would make this hunt in Coccinelle a bit tricky. My current iteration
of a coccinelle hunt cheats and looks at any sysfs looking op and
ensures a module exit exists.

> 3. rule: module_exit() must wait until all release() callbacks are called
> 	 when kobject are static.
> 
>    reason: kobject_put() must be called to clean up internal
> 	dependencies. The clean up might be done asynchronously
> 	and need access to the kobject structure.

This might be an easier rule to implement a respective Coccinelle rule
for.

  Luis
