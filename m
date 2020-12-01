Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 707342C96A0
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Dec 2020 05:55:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726440AbgLAEx4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 30 Nov 2020 23:53:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725861AbgLAExz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 30 Nov 2020 23:53:55 -0500
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B54BCC0613CF
        for <linux-fsdevel@vger.kernel.org>; Mon, 30 Nov 2020 20:53:09 -0800 (PST)
Received: by mail-ot1-x344.google.com with SMTP id x15so511708otp.4
        for <linux-fsdevel@vger.kernel.org>; Mon, 30 Nov 2020 20:53:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=LTmmyAT2tS3GBloGTkDuOtRyKKKiW/uvYLSGDxmf1H4=;
        b=fSzggWvKRJuZI9CKRsZwJsJB/8i8U6i700N3cbvc4kRcRgXe1TLu1OYpWOikJNXC6b
         oNFugJv+w7+gtShKSpCdDHDF8sMQgtqvrYAyx64Xn+rhtX3AvPbyur26G0f3bldchDvL
         xTwnT9SfqxUFo5ZXI9VBmnaV4sBxGHjcC8v1FX2b2pg70OyAYNgH2xSgg48mAr7cQij6
         fVjGmj9DcAuzU5URXXC3As1jTVimDXvAA7SBFVfOrYEIVkPob9hr8BK2h9l4EonEvt6Q
         bvGQHlENeqS8hrONlStgH0V2dQsE/+JImrYbvzSWr5MPjN8HEO1X8Ies2jdmnNAX4KhU
         I2TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=LTmmyAT2tS3GBloGTkDuOtRyKKKiW/uvYLSGDxmf1H4=;
        b=IodCmeHMfwQvJOivVCOK4Vpr3tt+8L5Q7YJYaoHA5EBV1IZ5J1zpfP/1DUwkDQ3sE3
         N34YAzKsNjEHOdW6mIDYdUmJb1EIemZPEUyZMY4PpHMa0xGPpxxgi8sZmvRGfSpeHr90
         L6Hw3GRDYJIRJ6v05teYqOiX3mAFlepMuv6Y5hQS8FUgZNR1i/2UORQug2LOMVLjOjRY
         1LlFoOvcduVfmFrkffQtR3XD1WY1wxsq8lrB0uA8mQ7DQphO7tvzhaA09+r+b5pC6MGq
         7df3NMbkxT9la6Zn/SsihP3JtgYBSoMO4ifN7s0QhuQ/sK4cRZY8eXup/c311bsby13V
         q75w==
X-Gm-Message-State: AOAM531fRkoscmQx1dtjVOyNsM0Y9bhthPWSilVfdQbsxjlGBJLaI0rN
        2csYE4qYyzoXV4B3IYzWv48OCw==
X-Google-Smtp-Source: ABdhPJwvxgrlDb9woDcZUFOTHzTTS/FMM1Hc4b5QDEWEqVWCczv0nbj0SwdtbAJSxpSMRhtKWBzwFg==
X-Received: by 2002:a05:6830:150b:: with SMTP id k11mr716787otp.234.1606798388706;
        Mon, 30 Nov 2020 20:53:08 -0800 (PST)
Received: from eggly.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id t21sm136827otr.77.2020.11.30.20.53.07
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Mon, 30 Nov 2020 20:53:08 -0800 (PST)
Date:   Mon, 30 Nov 2020 20:52:48 -0800 (PST)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     Matthew Wilcox <willy@infradead.org>
cc:     Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jan Kara <jack@suse.cz>,
        William Kucharski <william.kucharski@oracle.com>,
        Linux-FSDevel <linux-fsdevel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>, Christoph Hellwig <hch@lst.de>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Yang Shi <yang.shi@linux.alibaba.com>, dchinner@redhat.com,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 00/16] Overhaul multi-page lookups for THP
In-Reply-To: <alpine.LSU.2.11.2011301109230.17996@eggly.anvils>
Message-ID: <alpine.LSU.2.11.2011302050230.5786@eggly.anvils>
References: <alpine.LSU.2.11.2011160128001.1206@eggly.anvils> <20201117153947.GL29991@casper.infradead.org> <alpine.LSU.2.11.2011170820030.1014@eggly.anvils> <20201117191513.GV29991@casper.infradead.org> <20201117234302.GC29991@casper.infradead.org>
 <20201125023234.GH4327@casper.infradead.org> <20201125150859.25adad8ff64db312681184bd@linux-foundation.org> <CANsGZ6a95WK7+2H4Zyg5FwDxhdJQqR8nKND1Cn6r6e3QxWeW4Q@mail.gmail.com> <20201126121546.GN4327@casper.infradead.org> <alpine.LSU.2.11.2011261101230.2851@eggly.anvils>
 <20201126200703.GW4327@casper.infradead.org> <alpine.LSU.2.11.2011301109230.17996@eggly.anvils>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 30 Nov 2020, Hugh Dickins wrote:
> On Thu, 26 Nov 2020, Matthew Wilcox wrote:
> > On Thu, Nov 26, 2020 at 11:24:59AM -0800, Hugh Dickins wrote:
> > 
> > > But right now it's the right fix that's important: ack to yours below.
> > > 
> > > I've not yet worked out the other issues I saw: will report when I have.
> > > Rebooted this laptop, pretty sure it missed freeing a shmem swap entry,
> > > not yet reproduced, will study the change there later, but the non-swap 
> > > hang in generic/476 (later seen also in generic/112) more important.
> 
> It's been a struggle, but I do now have a version of shmem_undo_range()
> that works reliably, no known bugs, with no changes to your last version
> outside of shmem_undo_range().

Here's my version of shmem_undo_range(), working fine,
to replace the shmem_undo_range() resulting from your 
"mm/truncate,shmem: handle truncates that split THPs".

Some comments on the differences:-

The initial shmem_getpage(,,SGP_READ) was problematic and
surprising: the SGP_READ means that it returns NULL in some cases,
which might not be what we want e.g. on a fallocated but not yet
initialized page, and on a page beyond i_size (with i_size being
forced to 0 earlier when evicting): so start was not incremented
when I expected it to be.  And without a "partial" check, it also
risked reading in a page from swap unnecessarily (though not when
evicting, as I had feared, because of the i_size then being 0).

I think it was the unincremented start which was responsible for
shmem_evict_inode()'s WARN_ON(inode->i_blocks) (and subsequent
hang in swapoff) which I sometimes saw: swap entries were
truncated away without being properly accounted.

I found it easier to do it, like the end one, in the later main loop.
But of course there's an important difference between start and end
when splitting: I think you have relied on the tails-to-be-truncated
following on at the end; whereas (after many unsuccessful attempts to
preserve the old "But if truncating, restart to make sure all gone",
what I think of as "pincer" behaviour) I ended up just retrying even
in the hole-punch case, but not retrying indefinitely.  That allows
retrying the split if there was a momentary reason why the first
attempt failed, good, but not getting stuck there forever.  (It's
not obvious, but I think my old shmem_punch_compound() technique
handled failed split by incrementing up the tails one by one:
good to retry, but 510 times was too generous.)

The initial, trylock, pass then depends for correctness (when meeting
a huge page) on the behaviour you document for find_lock_entries():
"Pages which are partially outside the range are not returned".

There were rare cases in the later passes which did "break" from the
inner loop: if those entries were followed by others in the pagevec,
without a pagevec_release() at the end, they would have been leaked.
I ended up restoring the pagevec_release() (with its prior
pagevec_remove_exceptionals()), but hacking in a value entry where
truncate_inode_partial_page() had already done the unlock+put.
Yet (now we have retry pass even for holepunch) also changed those
breaks to continues, to deal with whatever follows in the pagevec.
I didn't really decide whether it's better to pagevec_release()
there or put one by one.

I never did quite absorb the "if (index > end) end = indices[i] - 1"
but it's gone away now.  I misread the "index = indices[i - 1] + 1",
not seeing that i must be non-zero there: I keep a running next_index
instead (though that does beg the comment, pointing out that it's
only used at the end of the pagevec).  I guess next_index is better
in the "unfalloc" case, where we want to skip pre-existing entries.

Somehow I deleted the old VM_BUG_ON_PAGE(PageWriteback(page), page):
it did not seem interesting at all, particularly with your
wait_on_page_writeback() in truncate_inode_partial_page().
And removed the old set_page_dirty() which went with the initial
shmem_getpage(), but was not replicated inside the main loop:
it makes no difference, the only way in which shmem pages can not
be dirty is if they are filled with zeroes, so writing zeroes into
them does not need dirtying (but I am surprised that other filesystems
don't want a set_page_dirty() in truncate_inode_partial_page() -
perhaps they all do it themselves).

Here it is:-
---
static void shmem_undo_range(struct inode *inode, loff_t lstart, loff_t lend,
								 bool unfalloc)
{
	struct address_space *mapping = inode->i_mapping;
	struct shmem_inode_info *info = SHMEM_I(inode);
	pgoff_t start, end, last_full;
	bool start_is_partial, end_is_partial;
	struct pagevec pvec;
	pgoff_t indices[PAGEVEC_SIZE];
	struct page *page;
	long nr_swaps_freed = 0;
	pgoff_t index, next_index;
	int i, pass = 0;

	pagevec_init(&pvec);

	/* start and end are indices of first and last page, perhaps partial */
	start = lstart >> PAGE_SHIFT;
	start_is_partial = !!(lstart & (PAGE_SIZE - 1));
	end = lend >> PAGE_SHIFT;
	end_is_partial = !!((lend + 1) & (PAGE_SIZE - 1));

	if (start >= end) {
		/* we especially want to avoid end 0 and last_full -1UL */
		goto next_pass;
	}

	/*
	 * Quick and easy first pass, using trylocks, hollowing out the middle.
	 */
	index = start + start_is_partial;
	last_full = end - end_is_partial;
	while (index <= last_full &&
	       find_lock_entries(mapping, index, last_full, &pvec, indices)) {
		for (i = 0; i < pagevec_count(&pvec); i++) {
			page = pvec.pages[i];
			index = indices[i];

			if (xa_is_value(page)) {
				if (unfalloc)
					continue;
				nr_swaps_freed += !shmem_free_swap(mapping,
								index, page);
				index++;
				continue;
			}
			if (!unfalloc || !PageUptodate(page))
				truncate_inode_page(mapping, page);
			index += thp_nr_pages(page);
			unlock_page(page);
		}
		pagevec_remove_exceptionals(&pvec);
		pagevec_release(&pvec);
		cond_resched();
	}

next_pass:
	index = start;
	for ( ; ; ) {
		cond_resched();

		if (index > end ||
		    !find_get_entries(mapping, index, end, &pvec, indices)) {
			/* If all gone or unfalloc, we're done */
			if (index == start || unfalloc)
				break;
			/* Otherwise restart to make sure all gone */
			if (++pass == 1) {
				/* The previous pass zeroed partial pages */
				if (start_is_partial) {
					start++;
					start_is_partial = false;
				}
				if (end_is_partial) {
					if (end)
						end--;
					end_is_partial = false;
				}
			}
			/* Repeat to remove residue, but not indefinitely */
			if (pass == 3)
				break;
			index = start;
			continue;
		}

		for (i = 0; i < pagevec_count(&pvec); i++) {
			page = pvec.pages[i];
			index = indices[i];

			if (xa_is_value(page)) {
				next_index = index + 1;
				if (unfalloc)
					continue;
				if ((index == start && start_is_partial) ||
				    (index == end && end_is_partial)) {
					/* Partial page swapped out? */
					page = NULL;
					shmem_getpage(inode, index, &page,
								SGP_READ);
					if (!page)
						continue;
					pvec.pages[i] = page;
				} else {
					if (shmem_free_swap(mapping, index,
								page)) {
						/* Swap replaced: retry */
						next_index = index;
						continue;
					}
					nr_swaps_freed++;
					continue;
				}
			} else {
				lock_page(page);
			}

			if (!unfalloc || !PageUptodate(page)) {
				if (page_mapping(page) != mapping) {
					/* Page was replaced by swap: retry */
					unlock_page(page);
					next_index = index;
					continue;
				}
				page = thp_head(page);
				next_index = truncate_inode_partial_page(
						mapping, page, lstart, lend);
				/* which already unlocked and put the page */
				pvec.pages[i] = xa_mk_value(0);
			} else {
				next_index = index + thp_nr_pages(page);
				unlock_page(page);
			}
		}

		pagevec_remove_exceptionals(&pvec);
		pagevec_release(&pvec);
		/* next_index is effective only when refilling the pagevec */
		index = next_index;
	}

	spin_lock_irq(&info->lock);
	info->swapped -= nr_swaps_freed;
	shmem_recalc_inode(inode);
	spin_unlock_irq(&info->lock);
}
