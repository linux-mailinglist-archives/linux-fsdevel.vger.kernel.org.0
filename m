Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD326375BCF
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 May 2021 21:34:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235499AbhEFTfK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 May 2021 15:35:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:51374 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235302AbhEFTfF (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 May 2021 15:35:05 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 375BA6105A;
        Thu,  6 May 2021 19:34:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620329647;
        bh=QlOxTk9ts/QBaKpEn8iiY0o8e6+f/3xqGqxM4NEBkqM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=W1mp3od1NC3b9w89w81uyrQASjmuGWtoqJkbu5gqob0PpjNI/ITLPr+hmqZ19kUEp
         hoAsBGw8mleiCRzayKwjwof1+8Y690Dq7ECu3lDHaPL0y4u7BhL0Ke0i/7cxtU8JuO
         e/+RDD3XTLvFaMAXYGvdSIUpKBxcJFiLK8oEwVTbhnXx8Pjd+TSBHB9pCpV9z6XOu6
         LNoP/wzR0Ph8LQEU25tDy+hEcNmb4D1ALAofRZ8KuWAqkAzBgi1kHXqObGjv8OHwQO
         hWNq1ykUkO5iwPKSsZ8pH/VCgdAIJymQsLXRU7+Y4CXNVbXBvr0rPiyWlIHh8AJeuh
         HIszNCSob7SlQ==
Date:   Thu, 6 May 2021 12:34:06 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     "Darrick J. Wong" <darrick.wong@oracle.com>,
        Brian Foster <bfoster@redhat.com>,
        linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH v2 2/2] xfs: kick extra large ioends to completion
 workqueue
Message-ID: <20210506193406.GE8582@magnolia>
References: <20201002153357.56409-3-bfoster@redhat.com>
 <20201005152102.15797-1-bfoster@redhat.com>
 <20201006035537.GD49524@magnolia>
 <20201006140720.GQ20115@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201006140720.GQ20115@casper.infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Oct 06, 2020 at 03:07:20PM +0100, Matthew Wilcox wrote:
> On Mon, Oct 05, 2020 at 08:55:37PM -0700, Darrick J. Wong wrote:
> > On Mon, Oct 05, 2020 at 11:21:02AM -0400, Brian Foster wrote:
> > > We've had reports of soft lockup warnings in the iomap ioend
> > > completion path due to very large bios and/or bio chains. Divert any
> > > ioends with 256k or more pages to process to the workqueue so
> > > completion occurs in non-atomic context and can reschedule to avoid
> > > soft lockup warnings.
> > 
> > Hmmmm... is there any way we can just make end_page_writeback faster?
> 
> There are ways to make it faster.  I don't know if they're a "just"
> solution ...
> 
> 1. We can use THPs.  That will reduce the number of pages being operated
> on.  I hear somebody might have a patch set for that.  Incidentally,
> this patch set will clash with the THP patchset, so one of us is going to
> have to rebase on the other's work.  Not a complaint, just acknowledging
> that some coordination will be needed for the 5.11 merge window.

How far off is this, anyway?  I assume it's in line behind the folio
series?

> 2. We could create end_writeback_pages(struct pagevec *pvec) which
> calls a new test_clear_writeback_pages(pvec).  That could amortise
> taking the memcg lock and finding the lruvec and taking the mapping
> lock -- assuming these pages are sufficiently virtually contiguous.
> It can definitely amortise all the statistics updates.

/me kinda wonders if THPs arent the better solution for people who want
to run large ios.

> 3. We can make wake_up_page(page, PG_writeback); more efficient.  If
> you can produce this situation on demand, I had a patch for that which
> languished due to lack of interest.

I can (well, someone can) so I'll talk to you internally about their
seeekret reproducer.

> https://lore.kernel.org/linux-fsdevel/20200416220130.13343-1-willy@infradead.org/

--D
