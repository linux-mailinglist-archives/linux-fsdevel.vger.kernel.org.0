Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4959A332D0A
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Mar 2021 18:16:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229790AbhCIRPl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 9 Mar 2021 12:15:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231386AbhCIRPP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 9 Mar 2021 12:15:15 -0500
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9027C06174A;
        Tue,  9 Mar 2021 09:15:15 -0800 (PST)
Received: by mail-pf1-x433.google.com with SMTP id e26so1238836pfd.9;
        Tue, 09 Mar 2021 09:15:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=zNrkVM3opIo4Ct7GIJQvQcLjEK4NZGCkwbt5BqsE3ko=;
        b=LYQJKcZG5pX/aD26EtSnR/DH6zYpdM5UWiWr32Y7SM6Ph8LOV+8yok4Z2edFmt2bIe
         kek8Ufbe5lLonqpuaj30w0JmyZxWK4BhQcGeUVytB2v3G4rKwsJPA2irJOi7OB8UQHgw
         ceuj8wW6AG8b9L2tZrPiQ7+bD2nbD03Axlr1ejnoZzGOXMgdQeSNNt4Vqo08OH2nORwi
         BXaXnZaSGj5e/5984sx7RnwrNe2mqtrwfEDyzGu8gkCz973942t9D1pMyTUseHcDUWBb
         mfC5Pu7Z5KoBiOFuMVRql4Q+NzzE3dTLfK5EDxoqujXm5oMwSo8RvtwvrSqnoRPy9X/1
         oyIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=zNrkVM3opIo4Ct7GIJQvQcLjEK4NZGCkwbt5BqsE3ko=;
        b=EYEQM3lCoPcClH3jHW5JLwRhs5va6EDBhfWaQpmjCl9L2SkwKC6XPAomSXHAnUbVTo
         dm6yhxb84509ySwuNLagCmCjZPf7owjbGDAab38NaDmwAaeDIT5PCOeqYXi01DkdBQbx
         h+E/xQ4t5/Jl0CTtF3oJwr0VqD7suk0EGWvH9jBxHmVQZrayLlWiRbRiG8SFtuGDIvKY
         QkWWDlNzVR3D8rd+EKuwvt6ArkRL9T7Dnatm7GtGz7j/B2QDWex1lrRPxK3/RQ1m06Pf
         aU5MCEyf4kAb7lWhU+Zoe7Qe5TAghdcsQTgdD6ql7VYVIBqR7I4F7gftCZA6K9wn0CMp
         ZEng==
X-Gm-Message-State: AOAM531h3aq3SM3kGsTXhsDXKojvYzCVntAuYmhwD40gh6voXTd1gJZY
        QX4Yhj1NHiIMscR3ueY5uFQ=
X-Google-Smtp-Source: ABdhPJyeBMxGTjHEttE1j3stbXA8OHsaZUshmIOE5BfZOomN2sQc8OZiip7l9yPgljMo6J4zPVE94Q==
X-Received: by 2002:a65:4942:: with SMTP id q2mr25390686pgs.34.1615310115222;
        Tue, 09 Mar 2021 09:15:15 -0800 (PST)
Received: from google.com ([2620:15c:211:201:f896:d6be:86d4:a59b])
        by smtp.gmail.com with ESMTPSA id q15sm13218413pfk.181.2021.03.09.09.15.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Mar 2021 09:15:14 -0800 (PST)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Tue, 9 Mar 2021 09:15:11 -0800
From:   Minchan Kim <minchan@kernel.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, joaodias@google.com,
        surenb@google.com, cgoldswo@codeaurora.org, willy@infradead.org,
        vbabka@suse.cz, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] mm: disable LRU pagevec during the migration
 temporarily
Message-ID: <YEetHx49DPVlC0Ap@google.com>
References: <20210309051628.3105973-1-minchan@kernel.org>
 <YEdV7Leo7MC93PlK@dhcp22.suse.cz>
 <YEeiYbBjefM08h18@google.com>
 <0ae7c7de-f274-c2ec-1b3a-a006ea280f98@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0ae7c7de-f274-c2ec-1b3a-a006ea280f98@redhat.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Mar 09, 2021 at 05:31:09PM +0100, David Hildenbrand wrote:
> 
> > > > Signed-off-by: Minchan Kim <minchan@kernel.org>
> > > > ---
> > > > * from v1 - https://lore.kernel.org/lkml/20210302210949.2440120-1-minchan@kernel.org/
> > > >    * introduce __lru_add_drain_all to minimize changes - mhocko
> > > >    * use lru_cache_disable for memory-hotplug
> > > >    * schedule for every cpu at force_all_cpus
> > > > 
> > > > * from RFC - http://lore.kernel.org/linux-mm/20210216170348.1513483-1-minchan@kernel.org
> > > >    * use atomic and lru_add_drain_all for strict ordering - mhocko
> > > >    * lru_cache_disable/enable - mhocko
> > > > 
> > > >   include/linux/migrate.h |  6 ++-
> > > >   include/linux/swap.h    |  2 +
> > > >   mm/memory_hotplug.c     |  3 +-
> > > >   mm/mempolicy.c          |  6 +++
> > > >   mm/migrate.c            | 13 ++++---
> > > >   mm/page_alloc.c         |  3 ++
> > > >   mm/swap.c               | 82 +++++++++++++++++++++++++++++++++--------
> > > >   7 files changed, 91 insertions(+), 24 deletions(-)
> > > 
> > > Sorry for nit picking but I think the additional abstraction for
> > > migrate_prep is not really needed and we can remove some more code.
> > > Maybe we should even get rid of migrate_prep_local which only has a
> > > single caller and open coding lru draining with a comment would be
> > > better from code reading POV IMO.
> > 
> > Thanks for the code. I agree with you.
> > However, in this moment, let's go with this one until we conclude.
> > The removal of migrate_prep could be easily done after that.
> > I am happy to work on it.
> 
> Can you prepare + send along these cleanups so we can have a look at the end
> result?
> 
> (either cleanups before or after your changes - doing cleanups before might
> be cleaner as we are not dealing with a fix here that we want to backport)

Okay, let me try one more time.
