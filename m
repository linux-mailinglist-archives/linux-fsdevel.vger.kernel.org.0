Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 530CE4839ED
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Jan 2022 02:41:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231633AbiADBlV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 3 Jan 2022 20:41:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230341AbiADBlU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 3 Jan 2022 20:41:20 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A584C061761
        for <linux-fsdevel@vger.kernel.org>; Mon,  3 Jan 2022 17:41:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=WOy6BEe8DTUUn2Ogp8WUshPR+7LTWicV3SlwuC7r7OA=; b=AiklbhMFdIQf61bxOL5Uyenywt
        4dxOTeH/PP4vyCwLCS0+3xWYPzYT34vjAPwbeS7ov8A5xnoh9DdcFivHPwWahpvg3am87W4RhngYh
        Q7eNYnvtXpOOSDYsAFEQ7dMscOi4dhm5AOx6WteWk1NeDZPlVLKWayuIdR3rI3mBoSqGi+LCDwK6K
        EG85X5WZ6djaMorx/WGHyKCf67iMqIOIBMRYCH8RQq7NEb2StMLcZpuXvIUqkiIs3Ji86CqJ2SlsU
        OlMsQONw8z4vzdWXXCLw4hq48rojKpz3do1vz1IcigKhS2I8qnydxZEQW/kgisMypuOEvSCPwny6u
        EZ0Dg9kQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n4Yp5-00DJTJ-5X; Tue, 04 Jan 2022 01:41:11 +0000
Date:   Tue, 4 Jan 2022 01:41:11 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Hugh Dickins <hughd@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@infradead.org>, Jan Kara <jack@suse.cz>,
        William Kucharski <william.kucharski@oracle.com>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH next 3/3] shmem: Fix "Unused swap" messages
Message-ID: <YdOlt5FJn9L+3sjM@casper.infradead.org>
References: <49ae72d6-f5f-5cd-e480-e2212cb7af97@google.com>
 <YdMYCFIHA/wtcDVV@casper.infradead.org>
 <2da9d057-8111-5759-a0dc-d9dca9fb8c9f@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2da9d057-8111-5759-a0dc-d9dca9fb8c9f@google.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jan 03, 2022 at 12:10:21PM -0800, Hugh Dickins wrote:
> On Mon, 3 Jan 2022, Matthew Wilcox wrote:
> > On Sun, Jan 02, 2022 at 05:35:50PM -0800, Hugh Dickins wrote:
> > > shmem_swapin_page()'s swap_free() has occasionally been generating
> > > "_swap_info_get: Unused swap offset entry" messages.  Usually that's
> > > no worse than noise; but perhaps it indicates a worse case, when we
> > > might there be freeing swap already reused by others.
> > > 
> > > The multi-index xas_find_conflict() loop in shmem_add_to_page_cache()
> > > did not allow for entry found NULL when expected to be non-NULL, so did
> > > not catch that race when the swap has already been freed.
> > > 
> > > The loop would not actually catch a realistic conflict which the single
> > > check does not catch, so revert it back to the single check.
> > 
> > I think what led to the loop was concern for the xa_state if trying
> > to find a swap entry that's smaller than the size of the folio.
> > So yes, the loop was expected to execute twice, but I didn't consider
> > the case where we were looking for something non-NULL and actually found
> > NULL.
> > 
> > So should we actually call xas_find_conflict() twice (if we're looking
> > for something non-NULL), and check that we get @expected, followed by
> > NULL?
> 
> Sorry, I've no idea.
> 
> You say "twice", and that does not fit the imaginary model I had when I
> said "The loop would not actually catch a realistic conflict which the
> single check does not catch".
> 
> I was imagining it either looking at a single entry, or looking at an
> array of (perhaps sometimes in shmem's case 512) entries, looking for
> conflict with the supplied pointer/value expected there.
> 
> The loop technique was already unable to report on unexpected NULLs,
> and the single test would catch a non-NULL entry different from an
> expected non-NULL entry.  Its only relative weakness appeared to be
> if that array contained (perhaps some NULLs then) a "narrow" instance
> of the same pointer/value that was expected to fill the array; and I
> didn't see any possibility for shmem to be inserting small and large
> folios sharing the same address at the same time.
> 
> That "explanation" may make no sense to you, don't worry about it;
> just as "twice" makes no immediate sense to me - I'd have to go off
> and study multi-index XArray to make sense of it, which I'm not
> about to do.
> 
> I've seen no problems with the proposed patch, but if you see a real
> case that it's failing to cover, yes, please do improve it of course.
> 
> Though now I'm wondering if the "loop" totally misled me; and your
> "twice" just means that we need to test first this and then that and
> we're done - yeah, maybe.

Sorry; I wrote the above in a hurry and early in the morning, so probably
even less coherent than usual.  Also, the multi-index xarray code is
new to everyone (and adds new things to consider), so it's no surprise
we're talking past each other.  It's a bit strange for me to read your
explanations because you're only reading what I actually wrote instead
of what I intended to write.

So let me try again.  My concern was that we might be trying to store
a 2MB entry which had a non-NULL 'expected' entry which was found in a
4k (ie single-index) slot within the 512 entries (as the first non-NULL
entry in that range), and we'd then store the 2MB entry into a
single-entry slot.

Now, maybe that can't happen for higher-level reasons, and I don't need
to worry about it.  But I feel like we should check for that?  Anyway,
I think the right fix is this:

+++ b/mm/shmem.c
@@ -733,11 +733,12 @@ static int shmem_add_to_page_cache(struct page *page,
        cgroup_throttle_swaprate(page, gfp);

        do {
-               void *entry;
                xas_lock_irq(&xas);
-               while ((entry = xas_find_conflict(&xas)) != NULL) {
-                       if (entry == expected)
-                               continue;
+               if (expected != xas_find_conflict(&xas)) {
+                       xas_set_err(&xas, -EEXIST);
+                       goto unlock;
+               }
+               if (expected && xas_find_conflict(&xas)) {
                        xas_set_err(&xas, -EEXIST);
                        goto unlock;
                }

which says what I mean.  I certainly didn't intend to imply that I
was expecting to see 512 consecutive entries which were all identical,
which would be the idiomatic way to read the code that was there before.
I shouldn't've tried to be so concise.

(If you'd rather I write any of this differently, I'm more than happy
to change it)
