Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D654068F9EA
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Feb 2023 22:53:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232019AbjBHVxS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Feb 2023 16:53:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjBHVxR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Feb 2023 16:53:17 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18954241C0
        for <linux-fsdevel@vger.kernel.org>; Wed,  8 Feb 2023 13:53:16 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id k13so631504plg.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 08 Feb 2023 13:53:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lEc4WtzG2izsxvPJxTEOSaWfcx0k//3sSxBoy6fqoR8=;
        b=Z/o0f8KGkeSoxV2jrwGuzBOTcXg/r6KzETgO1lNtTYp+XV73lw2e2eqA87U76bWG1o
         MgSh5YHBIYm420h6g+rt6HmTnd+EUAVlANx5sbZxQxVMs0H/Z9XwRxX3h1WCgdvUc+1i
         iynzxGCpPFTbqv4cu4v9RngJ6C8Vlqc8MGncX/oBBYHhHOZ9ExRenVpVcZ/pLvrP/j0A
         /XMc+Y5hE6uscE6eTF/MqahMO5lQBPCrWfpQ6Rk1r5hjyWgThhF12n9lwO5pkYQT2n+l
         fzAdSWx6qdI3lmTwjdDuvUGQCDnH45+3bZCuPIDcmM15zIRn5sB2ZzPGoDFpzdDx9Vbu
         1ByQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lEc4WtzG2izsxvPJxTEOSaWfcx0k//3sSxBoy6fqoR8=;
        b=ZYTm6FVQvT31Dvt6XtzVU/94IqJrGy/S2me6LEtXktKMQep5IMP9sKgv+v2S6tv7Hn
         5/noEtNZIAhTjZkKv9Jz50s3O9uw0HD+gDeWSHeS0X30Yvk3fz4BC9FMivaQf1+PTZso
         Q0Nm6mDh0349XsqEUV3IjlsJhudCp17arhKwhWc55PUVv7tTRhw22wkciqPmgY6vz1Sc
         ej6JzwKP4BfM5O9u2mTyAAEGBYQOqdNsfbvUpvKWNafgpQi4ZM3FPkf/F9gXXSrjw3lZ
         Vt6HV5XDqmVHCvIC0yaQJXUJP6ut//rFGBqiLj0Sg84GxMXNvzwxTMI5YNsdVttazqsb
         dLUA==
X-Gm-Message-State: AO0yUKXszhZPYGB5M6m30yqa0gjRUUMneYoz4VNjqqfPLrPGUz8Hxdyl
        OvXrt/3BDwe0fp/+Us2yotyo8A==
X-Google-Smtp-Source: AK7set9zLElKzUyjZxsY/yzrMl5lduU+qrXZAqdtTQv/EKh4wET5wsSOkIu9NbvqGQ4cxgViQ6cMyA==
X-Received: by 2002:a17:902:c950:b0:196:58ac:6593 with SMTP id i16-20020a170902c95000b0019658ac6593mr10819888pla.61.1675893195448;
        Wed, 08 Feb 2023 13:53:15 -0800 (PST)
Received: from dread.disaster.area (pa49-181-4-128.pa.nsw.optusnet.com.au. [49.181.4.128])
        by smtp.gmail.com with ESMTPSA id a4-20020a1709027e4400b0019942377f0bsm2168861pln.91.2023.02.08.13.53.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Feb 2023 13:53:14 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1pPsNL-00CzS6-Kn; Thu, 09 Feb 2023 08:53:11 +1100
Date:   Thu, 9 Feb 2023 08:53:11 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     "Darrick J. Wong" <djwong@kernel.org>, linux-xfs@vger.kernel.org,
        linux-afs@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, Dave Chinner <dchinner@redhat.com>
Subject: Re: [PATCH 1/3] xfs: Remove xfs_filemap_map_pages() wrapper
Message-ID: <20230208215311.GC360264@dread.disaster.area>
References: <20230208145335.307287-1-willy@infradead.org>
 <20230208145335.307287-2-willy@infradead.org>
 <Y+PQN8cLdOXST20D@magnolia>
 <Y+PX5tPyOP2KQqoD@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y+PX5tPyOP2KQqoD@casper.infradead.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Feb 08, 2023 at 05:12:06PM +0000, Matthew Wilcox wrote:
> On Wed, Feb 08, 2023 at 08:39:19AM -0800, Darrick J. Wong wrote:
> > On Wed, Feb 08, 2023 at 02:53:33PM +0000, Matthew Wilcox (Oracle) wrote:
> > > XFS doesn't actually need to be holding the XFS_MMAPLOCK_SHARED
> > > to do this, any more than it needs the XFS_MMAPLOCK_SHARED for a
> > > read() that hits in the page cache.
> > 
> > Hmm.  From commit cd647d5651c0 ("xfs: use MMAPLOCK around
> > filemap_map_pages()"):
> > 
> >     The page faultround path ->map_pages is implemented in XFS via
> >     filemap_map_pages(). This function checks that pages found in page
> >     cache lookups have not raced with truncate based invalidation by
> >     checking page->mapping is correct and page->index is within EOF.
> > 
> >     However, we've known for a long time that this is not sufficient to
> >     protect against races with invalidations done by operations that do
> >     not change EOF. e.g. hole punching and other fallocate() based
> >     direct extent manipulations. The way we protect against these
> >     races is we wrap the page fault operations in a XFS_MMAPLOCK_SHARED
> >     lock so they serialise against fallocate and truncate before calling
> >     into the filemap function that processes the fault.
> > 
> >     Do the same for XFS's ->map_pages implementation to close this
> >     potential data corruption issue.
> > 
> > How do we prevent faultaround from racing with fallocate and reflink
> > calls that operate below EOF?
> 
> I don't understand the commit message.  It'd be nice to have an example
> of what's insufficient about the protection.

When this change was made, "insufficient protection" was a reference
to the rather well known fact we'd been bugging MM developers about
for well over a decade (i.e. since before ->page_mkwrite existed)
that the unlocked page invalidation detection hack used everywhere
in the page cache code was broken for page invalidation within EOF.
i.e.  that cannot be correctly detected by (page->mapping == NULL &&
page->index > EOF) checks. This was a long standing problem, so
after a decade of being ignored, the MMAPLOCK was added to XFS to
serialise invalidation against page fault based operations.

At the time page faults could instantiate page cache pages whilst
invalidation operations like truncate_pagecache_range() were running
and hence page faults could be instantiating and mapping pages over
the range we are trying to invalidate. We were also finding niche
syscalls that caused data corruption due to invalidation races (e.g.
see xfs_file_fadvise() to avoid readahead vs hole punch races from
fadvise(WILLNEED) and readahead() syscalls), so I did an audit to
look for any potential interfaces that could race with invalidation.
->map_pages() being called from within the page fault code and
having a broken page->index based check for invalidation looked
suspect and potentially broken.  Hence I slapped the MMAPLOCK around
it to stop it from running while a XFS driven page cache
invalidation operation was in progress.

We work on the principle that when it comes to data corruption
vectors, it is far better to err on the side of safety than it is to
play fast and loose. fault-around is a perf optimisation, and taking
a rwsem in shared mode is not a major increase in overhead for that
path, so there was little risk of regressions in adding
serialisation just in case there was an as-yet-unknown data
corruption vector from that path.

Keep in mind this was written before the mm code handled page cache
instantiation serialisation sanely via the
mapping->invalidation_lock. The mapping->invalidation_lock solves
the same issues in a slightly different way, and it may well be that
the different implementation means that we don't need to use it in
all the places we place the MMAPLOCK in XFS originally.

> If XFS really needs it,
> it can trylock the semaphore and return 0 if it fails, falling back to
> the ->fault path.  But I don't think XFS actually needs it.
>
> The ->map_pages path trylocks the folio, checks the folio->mapping,
> checks uptodate, then checks beyond EOF (not relevant to hole punch).
> Then it takes the page table lock and puts the page(s) into the page
> tables, unlocks the folio and moves on to the next folio.
> 
> The hole-punch path, like the truncate path, takes the folio lock,
> unmaps the folio (which will take the page table lock) and removes
> it from the page cache.
> 
> So what's the race?

Hole punch is a multi-folio operation, so while we are operating on
invalidating one folio, another folio in the range we've already
invalidated could be instantiated and mapped, leaving mapped
up-to-date pages over a range we *require* the page cache to empty.

The original MMAPLOCK could not prevent the instantiation of new
page cache pages while an invalidation was running, hence we had to
block any operation from page faults that instantiated pages into
the page cache or operated on the page cache in any way while an
invalidation was being run.

The mapping->invalidation_lock solved this specific aspect of the
problem, so it's entirely possible that we don't have to care about
using MMAPLOCK for filemap_map_pages() any more. But I don't know
that for certain, I haven't had any time to investigate it in any
detail, and when it comes to data corruption vectors I'm not going
to change serialisation mechanisms without a decent amount of
investigation.

I couldn't ever convince myself there wasn't a problem hence the
comment in the commit:

"Do the same for XFS's ->map_pages implementation to close this
 potential data corruption issue."

Hence if you can explain to me how filemap_map_pages() cannot race
against invalidation without holding the mapping->invalidation_lock
without potentially leaving stale data in the page cache over the
invalidated range (this isn't an XFS specific issue!), then I don't
see a problem with removing the MMAPLOCK from this path.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
