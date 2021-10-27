Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DC9343C906
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Oct 2021 13:57:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240199AbhJ0MAK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 27 Oct 2021 08:00:10 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:53634 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236185AbhJ0MAI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 27 Oct 2021 08:00:08 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id F3553218A9;
        Wed, 27 Oct 2021 11:57:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1635335861; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ucBNwEUgb9vfxRGYPNg2vK2KIsHfBEZtfWM5PBLmWd4=;
        b=ixKOohmvkDm9di9WwT1GMQZWLO+1J5exOJdPzx47qKyKz4qoIdYInX4NfHCljwMY0bJv8a
        abmLoHEox6YYTy8VwN+l0Kqpy1SIaSGJ5Abc9yjjdrV+ff9a/C3OCjakbves78nrZX56Ec
        ywlaS6QGVZ5ZlgYwUNCO6+iqpQLUZu8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1635335861;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ucBNwEUgb9vfxRGYPNg2vK2KIsHfBEZtfWM5PBLmWd4=;
        b=GT8Z/FqWRSbORgwN9CbSBLyNojeiC1sbBLzmQKxC1Cf6eampRug0s4xOjQeTPXUWB+gO3z
        C4lfQOp5KFaopiAQ==
Received: from pobox.suse.cz (pobox.suse.cz [10.100.2.14])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 78673A3B81;
        Wed, 27 Oct 2021 11:57:40 +0000 (UTC)
Date:   Wed, 27 Oct 2021 13:57:40 +0200 (CEST)
From:   Miroslav Benes <mbenes@suse.cz>
To:     Luis Chamberlain <mcgrof@kernel.org>
cc:     Ming Lei <ming.lei@redhat.com>,
        Julia Lawall <julia.lawall@inria.fr>,
        Petr Mladek <pmladek@suse.com>,
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
In-Reply-To: <YXg0dFZ+6qHw7d0g@bombadil.infradead.org>
Message-ID: <alpine.LSU.2.21.2110271343290.3655@pobox.suse.cz>
References: <YW3LuzaPhW96jSBK@bombadil.infradead.org> <YW4uwep3BCe9Vxq8@T590> <alpine.LSU.2.21.2110190820590.15009@pobox.suse.cz> <YW6OptglA6UykZg/@T590> <alpine.LSU.2.21.2110200835490.26817@pobox.suse.cz> <YW/KEsfWJMIPnz76@T590> <alpine.LSU.2.21.2110201014400.26817@pobox.suse.cz>
 <YW/q70dLyF+YudyF@T590> <YXfA0jfazCPDTEBw@alley> <YXgguuAY5iEUIV0u@T590> <YXg0dFZ+6qHw7d0g@bombadil.infradead.org>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 26 Oct 2021, Luis Chamberlain wrote:

> On Tue, Oct 26, 2021 at 11:37:30PM +0800, Ming Lei wrote:
> > On Tue, Oct 26, 2021 at 10:48:18AM +0200, Petr Mladek wrote:
> > > Livepatch code never called kobject_del() under a lock. It would cause
> > > the obvious deadlock.
> 
> Never?

kobject_put() to be precise.

When I started working on the support for module/live patches removal, 
calling kobject_put() under our klp_mutex lock was the obvious first 
choice given how the code was structured, but I ran into problems with 
deadlocks immediately. So it was changed to async approach with the 
workqueue. Thus the mainline code has never suffered from this, but we 
knew about the issues.
 
> > > The historic code only waited in the
> > > module_exit() callback until the sysfs interface was removed.
> > 
> > OK, then Luis shouldn't consider livepatching as one such issue to solve
> > with one generic solution.
> 
> It's not what I was told when the deadlock was found with zram, so I was
> informed quite the contrary.

From my perspective, it is quite easy to get it wrong due to either a lack 
of generic support, or missing rules/documentation. So if this thread 
leads to "do not share locks between a module removal and a sysfs 
operation" strict rule, it would be at least something. In the same 
manner as Luis proposed to document try_module_get() expectations.
 
> I'm working on a generic coccinelle patch which hunts for actual cases
> using iteration (a feature of coccinelle for complex searches). The
> search is pretty involved, so I don't think I'll have an answer to this
> soon.
> 
> Since the question of how generic this deadlock is remains questionable,
> I think it makes sense to put the generic deadlock fix off the table for
> now, and we address this once we have a more concrete search with
> coccinelle.
> 
> But to say we *don't* have drivers which can cause this is obviously
> wrong as well, from a cursory search so far. But let's wait and see how
> big this list actually is.
> 
> I'll drop the deadlock generic fixes and move on with at least a starter
> kernfs / sysfs tests.

It makes sense to me.

Thanks, Luis, for pursuing it.

Miroslav
