Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8C2A2DFC9C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Dec 2020 15:14:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726860AbgLUONk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Dec 2020 09:13:40 -0500
Received: from mx2.suse.de ([195.135.220.15]:38750 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726614AbgLUONk (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Dec 2020 09:13:40 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id E4245AD57;
        Mon, 21 Dec 2020 14:12:57 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 97F8F1E1332; Mon, 21 Dec 2020 15:12:57 +0100 (CET)
Date:   Mon, 21 Dec 2020 15:12:57 +0100
From:   Jan Kara <jack@suse.cz>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        Jan Kara <jack@suse.com>, Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>
Subject: Re: set_page_dirty vs truncate
Message-ID: <20201221141257.GC13601@quack2.suse.cz>
References: <20201218160531.GL15600@casper.infradead.org>
 <20201218220316.GO15600@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201218220316.GO15600@casper.infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri 18-12-20 22:03:16, Matthew Wilcox wrote:
> On Fri, Dec 18, 2020 at 04:05:31PM +0000, Matthew Wilcox wrote:
> > A number of implementations of ->set_page_dirty check whether the page
> > has been truncated (ie page->mapping has become NULL since entering
> > set_page_dirty()).  Several other implementations assume that they can do
> > page->mapping->host to get to the inode.  So either some implementations
> > are doing unnecessary checks or others are vulnerable to a NULL pointer
> > dereference if truncate() races with set_page_dirty().
> > 
> > I'm touching ->set_page_dirty() anyway as part of the page folio
> > conversion.  I'm thinking about passing in the mapping so there's no
> > need to look at page->mapping.
> > 
> > The comments on set_page_dirty() and set_page_dirty_lock() suggests
> > there's no consistency in whether truncation is blocked or not; we're
> > only guaranteed that the inode itself won't go away.  But maybe the
> > comments are stale.
> 
> The comments are, I believe, not stale.  Here's some syzbot
> reports which indicate that ext4 is seeing races between set_page_dirty()
> and truncate():
> 
>  https://groups.google.com/g/syzkaller-lts-bugs/c/s9fHu162zhQ/m/Phnf6ucaAwAJ
> 
> The reproducer includes calls to ftruncate(), so that would suggest
> that's what's going on.
> 
> I would suggest just deleting this line:
> 
>         WARN_ON_ONCE(!page_has_buffers(page));
> 
> I'm not sure what value the other WARN_ON_ONCE adds.  Maybe just replace
> ext4_set_page_dirty with __set_page_dirty_buffers in the aops?  I'd defer
> to an ext4 expert on this ...

Please no. We've added this WARN_ON_ONCE() in 6dcc693bc57 ("ext4: warn when
page is dirtied without buffers") to catch problems with page pinning
earlier so that we get more diagnostic information before we actually BUG_ON()
in the writeback code ;).

To give more context: The question in which states we can see a page in
set_page_dirty() is actually filesystem dependent. Filesystems such as
ext4, xfs, btrfs expect to have full control over page dirtying because for
them it's a question of fs consistency (due to journalling requirements,
delayed allocation accounting etc.). Generally they expect the page can be
dirtied only through ->page_mkwrite() or through ->write_iter() and lock
things accordingly to maintain consistency. Except there's stuff like GUP
which breaks these assumptions - GUP users will trigger ->page_mkwrite()
but page can be writeprotected and cleaned long before GUP user modifies
page data and calls set_page_dirty(). Which is the main point why we came
up with pin_user_pages() so that MM / filesystems can detect there are page
references which can potentially modify & dirty a page and can count with
it (the "count with it" part is still missing, I have some clear ideas how
to do it but didn't get to it yet). And the syzkaller reproducer you
reference above is exactly one of the paths using GUP (actually already
pin_user_pages() these days) that can get fs into inconsistent state.

But overall even with GUP woes fixed up, set_page_dirty() called by a PUP
user could still see already truncated page. So it has to deal with it.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
