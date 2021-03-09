Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13CE5332D9E
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Mar 2021 18:55:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231682AbhCIRzX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 9 Mar 2021 12:55:23 -0500
Received: from mx2.suse.de ([195.135.220.15]:56076 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231571AbhCIRyy (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 9 Mar 2021 12:54:54 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1615312493; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=U/QDGXem12Pxb7eLy5qL+FVC4i3Gwof8hgAbnQWzXZQ=;
        b=nJktd1E7kuiWKgLuQn2T5fbjub8/ihZ6F/p8Mpfiybg3fLsbOne/B+4tVBh3QTSanWO0DA
        4iVmn8VLUrAFMgRd6lUhml9bpgAsAgGdbRM72/te9R4gcIvJUFn2lSGAE7nR5YHzytHsoY
        bR4OjzBpc8LpBLW2QuxjMer+5PfTxQE=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id E9813ACC6;
        Tue,  9 Mar 2021 17:54:52 +0000 (UTC)
Date:   Tue, 9 Mar 2021 18:54:52 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Minchan Kim <minchan@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, joaodias@google.com,
        surenb@google.com, cgoldswo@codeaurora.org, willy@infradead.org,
        david@redhat.com, vbabka@suse.cz, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] mm: disable LRU pagevec during the migration
 temporarily
Message-ID: <YEe2bIfYZvmaTMIb@dhcp22.suse.cz>
References: <20210309051628.3105973-1-minchan@kernel.org>
 <YEdV7Leo7MC93PlK@dhcp22.suse.cz>
 <YEeiYbBjefM08h18@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YEeiYbBjefM08h18@google.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue 09-03-21 08:29:21, Minchan Kim wrote:
> On Tue, Mar 09, 2021 at 12:03:08PM +0100, Michal Hocko wrote:
[...]
> > Sorry for nit picking but I think the additional abstraction for
> > migrate_prep is not really needed and we can remove some more code.
> > Maybe we should even get rid of migrate_prep_local which only has a
> > single caller and open coding lru draining with a comment would be
> > better from code reading POV IMO.
> 
> Thanks for the code. I agree with you.
> However, in this moment, let's go with this one until we conclude.
> The removal of migrate_prep could be easily done after that.
> I am happy to work on it.

I will leave that up to you but I find it a bit pointless to add
migrate_finish just to remove it in the next patch.

Btw. you should also move lru_cache_disabled up in swap.c to fix up
compilation issues by 0 day bot. I didn't do that in my version.
-- 
Michal Hocko
SUSE Labs
