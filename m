Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C287826DECB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Sep 2020 16:54:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727666AbgIQOw7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Sep 2020 10:52:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727665AbgIQOtY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Sep 2020 10:49:24 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06854C06174A;
        Thu, 17 Sep 2020 07:48:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=r6XGbhkzldwBJ9zbZcUG3CmtGLSS9SRTWvvxIUYsiWw=; b=u5AXJ9qOmy9oveddJWSUS6AkdN
        HTLBxtBBnUbdLyOLCh38/tVeqla5BwBRjLWIJ5YKzeBApwbBZCO/P+YC6CQU9PY0ikP7StLyoFcFq
        6sR8dt4Mw1xym36Oi5bpSPG4r/XLs4CqPHBws1IV48wJwwKrBhOYze8ZYQh+1bn9Aa9ZcgytUgfh4
        r3aoE8tGeEJB4z0qHfgIXkpb4Z9r33qyXkHaD3t+IDsSP/RNBsaYy+yL+klKTn9G/QL0m3DC4yGFZ
        ec1mMgCNkY3VBuDYQN+5vP//SnX7hAVnBGazq2OxvFS43ve6Vdrq1dvz8CAEi+VL4ln5pBXmJ1syi
        zmv8GMXA==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kIvCe-0008CS-42; Thu, 17 Sep 2020 14:48:04 +0000
Date:   Thu, 17 Sep 2020 15:48:04 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Brian Foster <bfoster@redhat.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Dave Chinner <david@fromorbit.com>,
        Ritesh Harjani <riteshh@linux.ibm.com>,
        Anju T Sudhakar <anju@linux.vnet.ibm.com>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, willy@infradead.org,
        minlei@redhat.com
Subject: Re: [PATCH] iomap: Fix the write_count in iomap_add_to_ioend().
Message-ID: <20200917144804.GA31389@infradead.org>
References: <20200824142823.GA295033@bfoster>
 <20200824150417.GA12258@infradead.org>
 <20200824154841.GB295033@bfoster>
 <20200825004203.GJ12131@dread.disaster.area>
 <20200825144917.GA321765@bfoster>
 <20200916001242.GE7955@magnolia>
 <20200916084510.GA30815@infradead.org>
 <20200916130714.GA1681377@bfoster>
 <20200917080455.GY26262@infradead.org>
 <20200917104219.GA1811187@bfoster>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200917104219.GA1811187@bfoster>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 17, 2020 at 06:42:19AM -0400, Brian Foster wrote:
> That wouldn't address the latency concern Dave brought up. That said, I
> have no issue with this as a targeted solution for the softlockup issue.
> iomap_finish_ioend[s]() is common code for both the workqueue and
> ->bi_end_io() contexts so that would require either some kind of context
> detection (and my understanding is in_atomic() is unreliable/frowned
> upon) or a new "atomic" parameter through iomap_finish_ioend[s]() to
> indicate whether it's safe to reschedule. Preference?

True, it would not help with latency.  But then again the latency
should be controlled by the writeback code not doing giant writebacks
to start with, shouldn't it?

Any XFS/iomap specific limit also would not help with the block layer
merging bios.
