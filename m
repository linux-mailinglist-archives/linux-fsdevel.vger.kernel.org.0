Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 334384113B3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Sep 2021 13:44:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237102AbhITLp2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Sep 2021 07:45:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230349AbhITLp1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Sep 2021 07:45:27 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F361C061574;
        Mon, 20 Sep 2021 04:44:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=73CcxbzrLuRLQC2uzjqV9MUFQBB/nbWPYSvLt6dDtD8=; b=E4HwcLrqx1S70L2dkNRWIqtx/r
        BfRukxgUQXxNxbT4s4RutoZNnEQphu3KCSDk03B9neeEhQoQLGbps0NbSwL1WL1/upXGXYPfurFXn
        ZWgtDQwdVKWWuByTox7JDbS4nn9nAr5WYNvvsk9Ma6DdnkvZ8Jyi0zaKL9LQtWFd3C6O4umApqM7Z
        24WPLVC4v0JjQJogD/aSsYmaka4UX0Vkl3x01zpsBvt5a1uoOYbYpcwf3QCeUMxieb7z1B3Sn8wss
        2Q6hGJDcjqa6Yntg3YNBGcqhVtKZVc1twxEbWJgY5QvR95mAAYHxI0V+QkU7wGieh0rKGCjeUwLOb
        7n60duwg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mSHh6-002ceI-Gb; Mon, 20 Sep 2021 11:42:49 +0000
Date:   Mon, 20 Sep 2021 12:42:44 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Linux-MM <linux-mm@kvack.org>, NeilBrown <neilb@suse.de>,
        Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Michal Hocko <mhocko@suse.com>,
        Dave Chinner <david@fromorbit.com>,
        Rik van Riel <riel@surriel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH 0/5] Remove dependency on congestion_wait in mm/
Message-ID: <YUhztA8TmplTluyQ@casper.infradead.org>
References: <20210920085436.20939-1-mgorman@techsingularity.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210920085436.20939-1-mgorman@techsingularity.net>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Sep 20, 2021 at 09:54:31AM +0100, Mel Gorman wrote:
> This has been lightly tested only and the testing was useless as the
> relevant code was not executed. The workload configurations I had that
> used to trigger these corner cases no longer work (yey?) and I'll need
> to implement a new synthetic workload. If someone is aware of a realistic
> workload that forces reclaim activity to the point where reclaim stalls
> then kindly share the details.

The stereeotypical "stalling on I/O" problem is to plug in one of the
crap USB drives you were given at a trade show and simply
	dd if=/dev/zero of=/dev/sdb
	sync

You can also set up qemu to have extremely slow I/O performance:
https://serverfault.com/questions/675704/extremely-slow-qemu-storage-performance-with-qcow2-images

