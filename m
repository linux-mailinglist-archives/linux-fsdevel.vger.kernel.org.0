Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0787231E75E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Feb 2021 09:24:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231126AbhBRIUt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 18 Feb 2021 03:20:49 -0500
Received: from mx2.suse.de ([195.135.220.15]:42790 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230505AbhBRISR (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 18 Feb 2021 03:18:17 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1613636225; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Bj/aH3giPAzDAL2y3Ty2YYSPPYbJXATBOZlDn8p3zgk=;
        b=VDHjKwZsViPrHpIlr1FHzb/cMaEynstaEefSnWRDaSgAOFC76HQZs9eXODQ5c4YHQRUOSc
        a1cW3Y5m0Pf2yq6Fr4gGSdz//gs5xy3MfWX63caE+c2ax/hdrv4T3T8wFi2slkFuidkXsM
        Uol9XwgIBzKOiZczO++jWUhchdMjYoI=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 06A05AC6E;
        Thu, 18 Feb 2021 08:17:05 +0000 (UTC)
Date:   Thu, 18 Feb 2021 09:17:02 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Minchan Kim <minchan@kernel.org>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, cgoldswo@codeaurora.org,
        linux-fsdevel@vger.kernel.org, david@redhat.com, vbabka@suse.cz,
        viro@zeniv.linux.org.uk, joaodias@google.com
Subject: Re: [RFC 1/2] mm: disable LRU pagevec during the migration
 temporarily
Message-ID: <YC4ifqXYEeWrj4aF@dhcp22.suse.cz>
References: <20210216170348.1513483-1-minchan@kernel.org>
 <YCzbCg3+upAo1Kdj@dhcp22.suse.cz>
 <YC2Am34Fso5Y5SPC@google.com>
 <20210217211612.GO2858050@casper.infradead.org>
 <YC2LVXO6e2NVsBqz@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YC2LVXO6e2NVsBqz@google.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 17-02-21 13:32:05, Minchan Kim wrote:
> On Wed, Feb 17, 2021 at 09:16:12PM +0000, Matthew Wilcox wrote:
> > On Wed, Feb 17, 2021 at 12:46:19PM -0800, Minchan Kim wrote:
> > > > I suspect you do not want to add atomic_read inside hot paths, right? Is
> > > > this really something that we have to microoptimize for? atomic_read is
> > > > a simple READ_ONCE on many archs.
> > > 
> > > It's also spin_lock_irq_save in some arch. If the new synchonization is
> > > heavily compilcated, atomic would be better for simple start but I thought
> > > this locking scheme is too simple so no need to add atomic operation in
> > > readside.
> > 
> > What arch uses a spinlock for atomic_read()?  I just had a quick grep and
> > didn't see any.
> 
> Ah, my bad. I was confused with update side.
> Okay, let's use atomic op to make it simple.

Thanks. This should make the code much more simple. Before you send
another version for the review I have another thing to consider. You are
kind of wiring this into the migration code but control over lru pcp
caches can be used in other paths as well. Memory offlining would be
another user. We already disable page allocator pcp caches to prevent
regular draining. We could do the same with lru pcp caches.
-- 
Michal Hocko
SUSE Labs
