Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 43ACE13AEE7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Jan 2020 17:13:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726946AbgANQM2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Jan 2020 11:12:28 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:43336 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726053AbgANQM2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Jan 2020 11:12:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=oyX+VCOGiR0VHFHOIdjFAfh8SfeH2y+niob+14o5ARo=; b=Ca224Nnp1IKl1DDDxR7kqrgHd
        Vr1uBgC+EqacfNTkQsMmIumteCicSFmyGYIJCVmnY5UuJ+pwOftZ5c3EpwLG7FFdLhyoEdl2egMYE
        jPzUvSqfe0BCCc6+iyKZJKY6Bt8qxRHIkUVEM5xvn5keUT7XiLhBWQLczmA6yJYrPSg5l4Ofx5AIm
        OGpABtl/mEM+U7MmryzHf2drt6XW/9NYxbupfWcfDeUTgOv3e72or4V54MjH1qFx+XUpwAqrcXw/b
        sedAhE1eK421rV1WDgwP+3Falg/Iisww5WjC6DzcUjq+JaAh6VNeldhXMySGMyzSYqDmNlEmdEdiH
        XO5GP+7Lg==;
Received: from [2001:4bb8:18c:4f54:fcbb:a92b:61e1:719] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1irOnr-000073-FS; Tue, 14 Jan 2020 16:12:28 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Waiman Long <longman@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-ext4@vger.kernel.org, cluster-devel@redhat.com
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: RFC: hold i_rwsem until aio completes
Date:   Tue, 14 Jan 2020 17:12:13 +0100
Message-Id: <20200114161225.309792-1-hch@lst.de>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi all,

Asynchronous read/write operations currently use a rather magic locking
scheme, were access to file data is normally protected using a rw_semaphore,
but if we are doing aio where the syscall returns to userspace before the
I/O has completed we also use an atomic_t to track the outstanding aio
ops.  This scheme has lead to lots of subtle bugs in file systems where
didn't wait to the count to reach zero, and due to its adhoc nature also
means we have to serialize direct I/O writes that are smaller than the
file system block size.

All this is solved by releasing i_rwsem only when the I/O has actually
completed, but doings so is against to mantras of Linux locking primites:

 (1) no unlocking by another process than the one that acquired it
 (2) no return to userspace with locks held

It actually happens we have various places that work around this.  A few
callers do non-owner unlocks of rwsems, which are pretty nasty for
PREEMPT_RT as the owner tracking doesn't work.  OTOH the file system
freeze code has both problems and works around them a little better,
although in a somewhat awkward way, in that it releases the lockdep
object when returning to userspace, and reacquires it when done, and
also clears the rwsem owner when returning to userspace, and then sets
the new onwer before unlocking.

This series tries to follow that scheme, also it doesn't fully work.  The
first issue is that the rwsem code has a bug where it doesn't properly
handle clearing the owner.  This series has a patch to fix that, but it
is ugly and might not be correct so some help is needed.  Second I/O
completions often come from interrupt context, which means the re-acquire
is recorded as from irq context, leading to warnings about incorrect
contexts.  I wonder if we could just have a bit in lockdep that says
returning to userspace is ok for this particular lock?  That would also
clean up the fsfreeze situation a lot.

Let me know what you think of all this.  While I converted all the iomap
using file systems only XFS is actually tested.

Diffstat:

 24 files changed, 144 insertions(+), 180 deletions(-)
