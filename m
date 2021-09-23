Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 354B8415EB8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Sep 2021 14:46:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241116AbhIWMrz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 Sep 2021 08:47:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241106AbhIWMrq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 Sep 2021 08:47:46 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40CFDC061764
        for <linux-fsdevel@vger.kernel.org>; Thu, 23 Sep 2021 05:45:03 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id g41so26035928lfv.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 23 Sep 2021 05:45:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=DLm/JPaMIp6sjkaiuRZT1UExfCGgcFfeWo4FyZBtSmY=;
        b=C0MDMxtYtfwEmfvJywxjNgCnSRV1IuOYywW30v5Q3V9tB/M1aIo+IL5+rjhfuO2TN5
         fMvGamX4epVIpdX+CpP8rU6rJNm/tJzqhXDiGoNzoUD9ytFoJAcBIK7l6FCZc1jZYZCe
         ZD4DjQAdQG/JJ0onl/YbliWqsLTG+3CsAkeDyRC3w++Z8+A8Wj+hEvRQvjF7hA/a1/mB
         Q0GA4tbppZBSJzskdVLbtv4tU7ZK8PqWAH9lbnngCzcy8DcGq9eSMFS5/8ENNmtTCCsB
         8e4dS0e5WZ3eJrTXAvSxkUkwFFLtuv+RLMg25F5mXXZrSpuW6L0n75ltFTPCmt2D2Kto
         aPgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=DLm/JPaMIp6sjkaiuRZT1UExfCGgcFfeWo4FyZBtSmY=;
        b=f1nYnfoeV4Dgckx0CYzM4IIR1cesVpbrlAmaUoMA/3QSYFJC8P5Nzm6euFPHI2QZMc
         g4ocxzxX0GYoyIUW9TYYnWWSs3KQ/IX3ohjkaP+jsiLJ5tv6K5ZC5MmzhvZ9i2AZ8pE3
         /N3u+GDgKOqdH217SwCu9SqQWuJ76rRYv9TBczAtPN+9AhSFyv3MDOHBniufNTdjIeFx
         Jq5Zoigqjo4nEg4dN6kZM/whXJ7ZdcLwMSwfPIOUDHCYq8AOMTgjZphaunIrHjhs8s58
         bRfEElRJDOatDZyA74m50zbGAm84ouqIQ7xi6e8IZHw8duuVEotb+w4VJLkBeCcfHOgw
         qLjQ==
X-Gm-Message-State: AOAM531tSZJrVOObCNWr08OjHxHbQmNYqVuxy3lGlmAe/YsJVPugJWNA
        +Ibu4LiA894rcy29I+IbQposhQ==
X-Google-Smtp-Source: ABdhPJzdTnX6YRxAadr+Gz+9xp0mSGCkymfK4VLQjW7SPYXSCbH2S1IIuzR6f1HWLWNlUSX/q3NnaQ==
X-Received: by 2002:a2e:8eda:: with SMTP id e26mr4944190ljl.266.1632401101517;
        Thu, 23 Sep 2021 05:45:01 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id v18sm581717ljg.95.2021.09.23.05.45.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Sep 2021 05:45:00 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id 02E7510306B; Thu, 23 Sep 2021 15:45:02 +0300 (+03)
Date:   Thu, 23 Sep 2021 15:45:02 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Kent Overstreet <kent.overstreet@gmail.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Johannes Weiner <hannes@cmpxchg.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        David Howells <dhowells@redhat.com>,
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: Re: Mapcount of subpages
Message-ID: <20210923124502.nxfdaoiov4sysed4@box.shutemov.name>
References: <YUvWm6G16+ib+Wnb@moria.home.lan>
 <YUvzINep9m7G0ust@casper.infradead.org>
 <YUwNZFPGDj4Pkspx@moria.home.lan>
 <YUxnnq7uFBAtJ3rT@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YUxnnq7uFBAtJ3rT@casper.infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 23, 2021 at 12:40:14PM +0100, Matthew Wilcox wrote:
> On Thu, Sep 23, 2021 at 01:15:16AM -0400, Kent Overstreet wrote:
> > On Thu, Sep 23, 2021 at 04:23:12AM +0100, Matthew Wilcox wrote:
> > > (compiling that list reminds me that we'll need to sort out mapcount
> > > on subpages when it comes time to do this.  ask me if you don't know
> > > what i'm talking about here.)
> > 
> > I am curious why we would ever need a mapcount for just part of a page, tell me
> > more.
> 
> I would say Kirill is the expert here.  My understanding:
> 
> We have three different approaches to allocating 2MB pages today;
> anon THP, shmem THP and hugetlbfs.  Hugetlbfs can only be mapped on a
> 2MB boundary, so it has no special handling of mapcount [1].  Anon THP
> always starts out as being mapped exclusively on a 2MB boundary, but
> then it can be split by, eg, munmap().  If it is, then the mapcount in
> the head page is distributed to the subpages.

One more complication for anon THP is that it can be shared across fork()
and one process may split it while other have it mapped with PMD.

> Shmem THP is the tricky one.  You might have a 2MB page in the page cache,
> but then have processes which only ever map part of it.  Or you might
> have some processes mapping it with a 2MB entry and others mapping part
> or all of it with 4kB entries.  And then someone truncates the file to
> midway through this page; we split it, and now we need to figure out what
> the mapcount should be on each of the subpages.  We handle this by using
> ->mapcount on each subpage to record how many non-2MB mappings there are
> of that specific page and using ->compound_mapcount to record how many 2MB
> mappings there are of the entire 2MB page.  Then, when we split, we just
> need to distribute the compound_mapcount to each page to make it correct.
> We also have the PageDoubleMap flag to tell us whether anybody has this
> 2MB page mapped with 4kB entries, so we can skip all the summing of 4kB
> mapcounts if nobody has done that.

Possible future complication comes from 1G THP effort. With 1G THP we
would have whole hierarchy of mapcounts: 1 PUD mapcount, 512 PMD
mapcounts and 262144 PTE mapcounts. (That's one of the reasons I don't
think 1G THP is viable.)

Note that there are places where exact mapcount accounting is critical:
try_to_unmap() may finish prematurely if we underestimate mapcount and
overestimating mapcount may lead to superfluous CoW that breaks GUP.

> 
> [1] Mike is looking to change this, but I'm not sure where he is with it.
> 

-- 
 Kirill A. Shutemov
