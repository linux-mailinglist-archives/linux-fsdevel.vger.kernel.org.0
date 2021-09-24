Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CBAE41691D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Sep 2021 02:57:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243697AbhIXA67 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 Sep 2021 20:58:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240863AbhIXA66 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 Sep 2021 20:58:58 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B6E8C061574
        for <linux-fsdevel@vger.kernel.org>; Thu, 23 Sep 2021 17:57:26 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id a13so8013115qtw.10
        for <linux-fsdevel@vger.kernel.org>; Thu, 23 Sep 2021 17:57:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=yOg+nzwKS/Xe9boE1XYCVEvuo4RAHMroRl1PMQiLGaE=;
        b=UdSi8cTqG77oru82hEmJklps5D805r9qSr9pTi5SYcSwhasEbm9rWVspjcCQSnRf8Q
         oX8CtlqZO7VNdTkw/JeNVrL4ZAJDGwNEL54yb43mYHbxLf94ZzRljWHYkVJj6/LZUIw4
         6ZAG6NTAVbHoPcQCdj2m5GcMHAt1TNFWi3i7J0CDS9W39XJDpK3YH7T2NXD7OvWggs8T
         ofMDlCmiLCJT7MWrlO0+jgNkRRgpFqZC5t5cbYoiHrx38fpoY25TgBNELp+8xoLOUpYU
         DzRGKPLbppIUwv3bQZGzMtW+dY4LJxp/H4wNNf7gQFX4cHFxnEH4RP/74F4affCg0oyy
         rEUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=yOg+nzwKS/Xe9boE1XYCVEvuo4RAHMroRl1PMQiLGaE=;
        b=yLaxEGqKGp/51QyO7mAf514lueaOuYt8wgi9kX8NI51UDqV03sThLiRCfMsfpP+gDg
         1VsjNJ2wxwvGYyc6MmmvuRD4nHshvziVWCQIzNtlUuQDmwWWGEgwh1OBrr9ZJGTszoEN
         liJhdLDJ02s+dMoBjZt9j0LnLFoOC6/FsQ78QbH9SF0k2dqp7YzB30mOo2aa7/s/HVl+
         /qBXcTCgesETVAZxTVxM/sCFOaJzoxS7SHjhltrgh/lUGzqikEa87wWMdUnPWG/dgzMK
         R+W4dPWfImfp8HFhPxWBpQ5T1dTU88OcL6TNh75AqAc6j9qZnLLCYYV6gbgE2XGIDj0M
         6PeA==
X-Gm-Message-State: AOAM532LB7r9iDZNJyU43bu31YwksAZ62khMBEI8PV1z8G+bi7oocL6m
        JoCH/hfpmnlQFNW7xLlbif6OZA==
X-Google-Smtp-Source: ABdhPJxKZbP06lKD6aeiNcFdgQv2031ZYnZqb+thvCaZxx9HD9ZRTfzF1jKNdAdawTbHh2lJoH/5Hw==
X-Received: by 2002:ac8:4755:: with SMTP id k21mr1730713qtp.150.1632445045392;
        Thu, 23 Sep 2021 17:57:25 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id g22sm5530005qkk.87.2021.09.23.17.57.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Sep 2021 17:57:24 -0700 (PDT)
Date:   Thu, 23 Sep 2021 17:57:11 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.anvils
To:     Zi Yan <ziy@nvidia.com>
cc:     Hugh Dickins <hughd@google.com>, Yang Shi <shy828301@gmail.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Matthew Wilcox <willy@infradead.org>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        David Howells <dhowells@redhat.com>,
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: Re: Mapcount of subpages
In-Reply-To: <24B432CB-5CBB-4309-A9D0-6E1C4395A013@nvidia.com>
Message-ID: <63e1cfcc-b7dd-ca55-39b2-7a9d2f6ff7eb@google.com>
References: <YUvWm6G16+ib+Wnb@moria.home.lan> <YUvzINep9m7G0ust@casper.infradead.org> <YUwNZFPGDj4Pkspx@moria.home.lan> <YUxnnq7uFBAtJ3rT@casper.infradead.org> <20210923124502.nxfdaoiov4sysed4@box.shutemov.name> <72cc2691-5ebe-8b56-1fe8-eeb4eb4a4c74@google.com>
 <CAHbLzkrELUKR2saOkA9_EeAyZwdboSq0HN6rhmCg2qxwSjdzbg@mail.gmail.com> <2A311B26-8B33-458E-B2C1-8BA2CF3484AA@nvidia.com> <77b59314-5593-1a2e-293c-b66e8235ad@google.com> <24B432CB-5CBB-4309-A9D0-6E1C4395A013@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 23 Sep 2021, Zi Yan wrote:
> On 23 Sep 2021, at 19:48, Hugh Dickins wrote:
> > On Thu, 23 Sep 2021, Zi Yan wrote:
> >> On 23 Sep 2021, at 17:54, Yang Shi wrote:
> >>> On Thu, Sep 23, 2021 at 2:10 PM Hugh Dickins <hughd@google.com> wrote:
> >>>>
> >>>> NR_FILE_MAPPED being used for /proc/meminfo's "Mapped:" and a couple
> >>>> of other such stats files, and for a reclaim heuristic in mm/vmscan.c.
> >>>>
> >>>> Allow ourselves more slack in NR_FILE_MAPPED accounting (either count
> >>>> each pte as if it mapped the whole THP, or don't count a THP's ptes
> >>>> at all - you opted for the latter in the "Mlocked:" accounting),
> >>>> and I suspect subpage _mapcount could be abandoned.
> >>>
> >>> AFAIK, partial THP unmap may need the _mapcount information of every
> >>> subpage otherwise the deferred split can't know what subpages could be
> >>> freed.
> >
> > I believe Yang Shi is right insofar as the decision on whether it's worth
> > queuing for deferred split is being done based on those subpage _mapcounts.
> > That is a use I had not considered, and I've given no thought to how
> > important or not it is.
> >
> >>
> >> Could we just scan page tables of a THP during deferred split process
> >> instead? Deferred split is a slow path already, so maybe it can afford
> >> the extra work.
> >
> > But unless I misunderstand, actually carrying out the deferred split
> > already unmaps, uses migration entries, and remaps the remaining ptes:
> > needing no help from subpage _mapcounts to do those, and free the rest.
> 
> You are right. unmap_page() during THP split is scanning the page tables
> already.
> 
> For deciding whether to queue a THP for deferred split, we probably can
> keep PageDoubleMap bit to indicate if any subpage is PTE mapped.

Maybe, maybe not.

> 
> But without subpage _mapcount, detecting extra pins to a THP before split
> might be not as easy as with it. This means every THP split will need to
> perform unmap_page(), then check the remaining page_count to see if
> THP split is possible. That would also introduce extra system-wide overheads
> from unmapping pages. Am I missing anything?

I did not explain clearly enough: a subpage's ptes must still be counted
in total_mapcount(); but I'm suggesting that perhaps they can be counted
all together (either in the head page's _mapcount, or in a separate field
if that works better), instead of being distributed amongst the separate
subpages' _mapcounts.

And this would lower the system-wide overheads inside total_mapcount()
and page_mapped() (and maybe others).

Hugh
