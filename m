Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB1E443B7C6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Oct 2021 19:02:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236309AbhJZREb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 26 Oct 2021 13:04:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231360AbhJZRE0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 26 Oct 2021 13:04:26 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBD49C061745;
        Tue, 26 Oct 2021 10:02:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=rokadze8fRogRPO3TrlkJtrH8Z7jdFewFpbGPuZXCIM=; b=Qu7hbKOTAdEdBAA2y8tI88Y2/9
        fLNwaKezOpXserGMaIVWN2jN15mgeYqvk8M/nMFdvuU5t2HO/FTeOt9d2UnO/Ggl4TZKbTQdsz+G4
        nXL1XP7usNiHTBSnuvt5MSW3VpiWZscPz5mEn0nHDheFG/gaH7XQRVOfMfyO9X9MK1IREmP9s72mA
        QTDix5gCEW/5udqqkrYa156daZNZ2zGDGhygkQ21zCMafu9t/D+JajvGykPFMZdU/SiIGrSpnAD0A
        1UKOvtUSFjhuxsuXZjboMKtwJV73xZGh8YYSz/Tknj3RKEaQ8H8Afu4sGA/11uH8N2/HPJ0IdzpiW
        RZAtoISw==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mfPpV-002Yak-03; Tue, 26 Oct 2021 17:01:41 +0000
Date:   Tue, 26 Oct 2021 10:01:40 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Ming Lei <ming.lei@redhat.com>,
        Julia Lawall <julia.lawall@inria.fr>
Cc:     Petr Mladek <pmladek@suse.com>, Miroslav Benes <mbenes@suse.cz>,
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
Message-ID: <YXg0dFZ+6qHw7d0g@bombadil.infradead.org>
References: <YW3LuzaPhW96jSBK@bombadil.infradead.org>
 <YW4uwep3BCe9Vxq8@T590>
 <alpine.LSU.2.21.2110190820590.15009@pobox.suse.cz>
 <YW6OptglA6UykZg/@T590>
 <alpine.LSU.2.21.2110200835490.26817@pobox.suse.cz>
 <YW/KEsfWJMIPnz76@T590>
 <alpine.LSU.2.21.2110201014400.26817@pobox.suse.cz>
 <YW/q70dLyF+YudyF@T590>
 <YXfA0jfazCPDTEBw@alley>
 <YXgguuAY5iEUIV0u@T590>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YXgguuAY5iEUIV0u@T590>
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Oct 26, 2021 at 11:37:30PM +0800, Ming Lei wrote:
> On Tue, Oct 26, 2021 at 10:48:18AM +0200, Petr Mladek wrote:
> > Livepatch code never called kobject_del() under a lock. It would cause
> > the obvious deadlock.

Never?

> > The historic code only waited in the
> > module_exit() callback until the sysfs interface was removed.
> 
> OK, then Luis shouldn't consider livepatching as one such issue to solve
> with one generic solution.

It's not what I was told when the deadlock was found with zram, so I was
informed quite the contrary.

I'm working on a generic coccinelle patch which hunts for actual cases
using iteration (a feature of coccinelle for complex searches). The
search is pretty involved, so I don't think I'll have an answer to this
soon.

Since the question of how generic this deadlock is remains questionable,
I think it makes sense to put the generic deadlock fix off the table for
now, and we address this once we have a more concrete search with
coccinelle.

But to say we *don't* have drivers which can cause this is obviously
wrong as well, from a cursory search so far. But let's wait and see how
big this list actually is.

I'll drop the deadlock generic fixes and move on with at least a starter
kernfs / sysfs tests.

  Luis
