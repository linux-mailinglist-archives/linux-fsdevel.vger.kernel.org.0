Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8DC2613B9F8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jan 2020 07:54:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729080AbgAOGyK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Jan 2020 01:54:10 -0500
Received: from verein.lst.de ([213.95.11.211]:49217 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726018AbgAOGyK (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Jan 2020 01:54:10 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 68EA368AFE; Wed, 15 Jan 2020 07:54:06 +0100 (CET)
Date:   Wed, 15 Jan 2020 07:54:06 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Christoph Hellwig <hch@lst.de>, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, Waiman Long <longman@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-ext4@vger.kernel.org, cluster-devel@redhat.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: RFC: hold i_rwsem until aio completes
Message-ID: <20200115065406.GB21219@lst.de>
References: <20200114161225.309792-1-hch@lst.de> <20200114184707.GA10467@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200114184707.GA10467@bombadil.infradead.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jan 14, 2020 at 10:47:07AM -0800, Matthew Wilcox wrote:
> It would be helpful if we could also use the same lockdep logic
> for PageLocked.  Again, it's a case where returning to userspace with
> PageLock held is fine, because we're expecting an interrupt to come in
> and drop the lock for us.

Yes, this is a very typical pattern for I/O.  Besides the page and
buffer head bit locks it also applies to the semaphore in the xfs_buf
structure and probably various other places that currently used hand
crafted or legacy locking primitives to escape lockdep.

> Perhaps the right answer is, from lockdep's point of view, to mark the
> lock as being released at the point where we submit the I/O.  Then
> in the completion path release the lock without telling lockdep we
> released it.

That is similar to what the fsfreeze code does, but I don't think it
is very optimal, as misses to track any dependencies after I/O
submission, and at least some of the completions paths do take
locks.  But it might be a start.
