Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 199072CE1F1
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Dec 2020 23:39:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731883AbgLCWi4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 3 Dec 2020 17:38:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731848AbgLCWi4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 3 Dec 2020 17:38:56 -0500
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 435CDC061A4F
        for <linux-fsdevel@vger.kernel.org>; Thu,  3 Dec 2020 14:38:10 -0800 (PST)
Received: by mail-qt1-x841.google.com with SMTP id o1so2653408qtp.5
        for <linux-fsdevel@vger.kernel.org>; Thu, 03 Dec 2020 14:38:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=8hMIirRw/G+8UZ/DmDQ+scNJvEG3e8n2Kq9pVWHYcz0=;
        b=d3o/p/wHA4C3IKiVIV9XegX6HBqZpjyqX1On5/l0/fnIs9rgNVmZ4A2sFIb27WXgZB
         4xfS7im5ICW1192YWX0pnFIazKkD6OuPN1xebbP8+vXxPvw1OEP0iX7c99NJxf+x5ZB+
         GTJxA3Dy7SFC6u6WuV5+QWUnY2Tb3HJyYEqUVcYutU0sWX8KXxEhLh0oB1g423xxkOAa
         JC4VGelctpfQNGrdRsAqTIH3JCgvXpjZuIKFKzttkmAq5c78Wr/3BdP4xmDFxhxFt/L3
         eXcJx5geCkCoYn7WVFzD5g6ov09q7byYpYyxmHyB83AbYePOkp1WEAa1I3WIj34gyLnh
         eh3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8hMIirRw/G+8UZ/DmDQ+scNJvEG3e8n2Kq9pVWHYcz0=;
        b=dNAFRKnFowUu2ox9R/qJ0QXty0hD3K8VQqvKKRbTqfgIXL08Xq/UU3R9L3SDzlpEZU
         Lna84dARfNGrkbiBN9h1RZsNnd5wbOT1e+BEu/n1fL1LzhKt5F9z++nUA7iSO+SFqsUl
         wLmpQ64PCHwiY1Lqrg4PjeWvJ0mn3nXls4ifJ4MleQp9643Y782VMokTJnjkkg4aVgij
         0MOne8I9FGRb2cBbTBs4w+/TDdz85SEqSVdJqV6B92DJlB3fIDuNduTsTXFdMEnFvPLC
         /UNiTlLY3q9FgZ1oWwQwK1jlynJJckk0/Ltb1gPsR1MMD2uL4YDXX34r2gZn1bAXZfGp
         sp1w==
X-Gm-Message-State: AOAM531yUSset8Yczbkdyx1XvlbmoWXAVcv2Qraf+zF/nNKJZ+aZN9of
        D8xL0lDvbly8VDFKnRyLqEKWPw==
X-Google-Smtp-Source: ABdhPJyTLV9IvmkXT4zvjTtrq/pqFKuAYSoXuHGVYLl75r9BRMJTWgPp3nmcQDYlosUbA32lA8Y2eA==
X-Received: by 2002:ac8:3645:: with SMTP id n5mr5667712qtb.225.1607035089530;
        Thu, 03 Dec 2020 14:38:09 -0800 (PST)
Received: from localhost ([2620:10d:c091:480::1:deb1])
        by smtp.gmail.com with ESMTPSA id q123sm2862339qke.28.2020.12.03.14.38.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Dec 2020 14:38:08 -0800 (PST)
Date:   Thu, 3 Dec 2020 17:36:07 -0500
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Pavel Begunkov <asml.silence@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] block: add bio_iov_iter_nvecs for figuring out nr_vecs
Message-ID: <20201203223607.GB53708@cmpxchg.org>
References: <20201201120652.487077-1-ming.lei@redhat.com>
 <20201201125251.GA11935@casper.infradead.org>
 <20201201125936.GA25111@infradead.org>
 <fdbfe981-0251-9641-6ed8-db034c0f0148@gmail.com>
 <20201201133226.GA26472@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201201133226.GA26472@infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Dec 01, 2020 at 01:32:26PM +0000, Christoph Hellwig wrote:
> On Tue, Dec 01, 2020 at 01:17:49PM +0000, Pavel Begunkov wrote:
> > I was thinking about memcpy bvec instead of iterating as a first step,
> > and then try to reuse passed in bvec.
> > 
> > A thing that doesn't play nice with that is setting BIO_WORKINGSET in
> > __bio_add_page(), which requires to iterate all pages anyway. I have no
> > clue what it is, so rather to ask if we can optimise it out somehow?
> > Apart from pre-computing for specific cases...
> > 
> > E.g. can pages of a single bvec segment be both in and out of a working
> > set? (i.e. PageWorkingset(page)).
> 
> Adding Johannes for the PageWorkingset logic, which keeps confusing me
> everytime I look at it.  I think it is intended to deal with pages
> being swapped out and in, and doesn't make much sense to look at in
> any form for direct I/O, but as said I'm rather confused by this code.

Correct, it's only interesting for pages under LRU management - page
cache and swap pages. It should not matter for direct IO.

The VM uses the page flag to tell the difference between cold faults
(empty cache startup e.g.), and thrashing pages which are being read
back not long after they have been reclaimed. This influences reclaim
behavior, but can also indicate a general lack of memory.

The BIO_WORKINGSET flag is for the latter. To calculate the time
wasted by a lack of memory (memory pressure), we measure the total
time processes wait for thrashing pages. Usually that time is
dominated by waiting for in-flight io to complete and pages to become
uptodate. These waits are annotated on the page cache side.

However, in some cases, the IO submission path itself can block for
extended periods - if the device is congested or submissions are
throttled due to cgroup policy. To capture those waits, the bio is
flagged when it's for thrashing pages, and then submit_bio() will
report submission time of that bio as a thrashing-related delay.

[ Obviously, in theory bios could have a mix of thrashing and
  non-thrashing pages, and the submission stall could have occurred
  even without the thrashing pages. But in practice we have locality,
  where groups of pages tend to be accessed/reclaimed/refaulted
  together. The assumption that the whole bio is due to thrashing when
  we see the first thrashing page is a workable simplification. ]

HTH
