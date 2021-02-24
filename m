Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B1A132434C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Feb 2021 18:46:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235838AbhBXRo7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 24 Feb 2021 12:44:59 -0500
Received: from mx2.suse.de ([195.135.220.15]:59436 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234716AbhBXRox (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 24 Feb 2021 12:44:53 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 5142EADDB;
        Wed, 24 Feb 2021 17:44:11 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 19A281E14EE; Wed, 24 Feb 2021 18:44:11 +0100 (CET)
Date:   Wed, 24 Feb 2021 18:44:11 +0100
From:   Jan Kara <jack@suse.cz>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Kent Overstreet <kent.overstreet@gmail.com>
Subject: Re: [RFC] Better page cache error handling
Message-ID: <20210224174411.GH849@quack2.suse.cz>
References: <20210205161142.GI308988@casper.infradead.org>
 <20210224123848.GA27695@quack2.suse.cz>
 <20210224134115.GP2858050@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210224134115.GP2858050@casper.infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 24-02-21 13:41:15, Matthew Wilcox wrote:
> On Wed, Feb 24, 2021 at 01:38:48PM +0100, Jan Kara wrote:
> > > We allocate a page and try to read it.  29 threads pile up waiting
> > > for the page lock in filemap_update_page().  The error returned by the
> > > original I/O is shared between all 29 waiters as well as being returned
> > > to the requesting thread.  The next request for index.html will send
> > > another I/O, and more waiters will pile up trying to get the page lock,
> > > but at no time will more than 30 threads be waiting for the I/O to fail.
> > 
> > Interesting idea. It certainly improves current behavior. I just wonder
> > whether this isn't a partial solution to a problem and a full solution of
> > it would have to go in a different direction? I mean it just seems
> > wrong that each reader (let's assume they just won't overlap) has to retry
> > the failed IO and wait for the HW to figure out it's not going to work.
> > Shouldn't we cache the error state with the page? And I understand that we
> > then also have to deal with the problem how to invalidate the error state
> > when the block might eventually become readable (for stuff like temporary
> > IO failures). That would need some signalling from the driver to the page
> > cache, maybe in a form of some error recovery sequence counter or something
> > like that. For stuff like iSCSI, multipath, or NBD it could be doable I
> > believe...
> 
> That felt like a larger change than I wanted to make.  I already have
> a few big projects on my plate!

I can understand that ;)

> Also, it's not clear to me that the host can necessarily figure out when
> a device has fixed an error -- certainly for the three cases you list
> it can be done.  I think we'd want a timer to indicate that it's worth
> retrying instead of returning the error.
> 
> Anyway, that seems like a lot of data to cram into a struct page.  So I
> think my proposal is still worth pursuing while waiting for someone to
> come up with a perfect solution.

Yes, timer could be a fallback. Or we could just schedule work to discard
all 'error' pages in the fs in an hour or so. Not perfect but more or less
workable I'd say. Also I don't think we need to cram this directly into
struct page - I think it is perfectly fine to kmalloc() structure we need
for caching if we hit error and just don't cache if the allocation fails.
Then we might just reference it from appropriate place... didn't put too
much thought to this...

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
