Return-Path: <linux-fsdevel+bounces-46516-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E0A3A8A9DA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Apr 2025 23:06:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 752B31901D87
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Apr 2025 21:06:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B70E0256C69;
	Tue, 15 Apr 2025 21:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="undf+jZc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17EE014F9D9;
	Tue, 15 Apr 2025 21:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744751183; cv=none; b=NErzCqCKQy7+0F84qEWPSTFlLwWgUes5NuGVLKBnkqRbga5uKBMd5CDI1TCjOoZ5f5563X1Bs13ajFfzm3dVXgeJOHFXOJpcgkQRVGWyQJpXq6/kRhS7uw9gexTJyKziG9IsHHu1YD4ANFCIzlSfRsUTHfdE9clPteM3d/MjbBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744751183; c=relaxed/simple;
	bh=EU2IYnaeN39G2kJHqb87k5W39AXqIoNMyAG+a9aBwqU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hq4u/JAKrsixVrPuSeJNNohK3hDa6amALiPuQCS3IxF1BKA9rdHltjjsG+nFzVMZkQdsyVG952ZF4KkZhkBBCYlYXqXo1Cf8UjI6AJrEFSwFQ9Ml1fzC4yikRyAXDP6oW5VYeUaTeA7lq0hM77r5vjDYO4C6EkKbxrQdBd4irf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=undf+jZc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00061C4CEE7;
	Tue, 15 Apr 2025 21:06:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744751182;
	bh=EU2IYnaeN39G2kJHqb87k5W39AXqIoNMyAG+a9aBwqU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=undf+jZcbkPvPdy7FelgDomTaoGuUn9+aO7AkU64SM4MUXv3+KvcJ23nXjo7iVwsv
	 YK9zuo9w5ak0x3THwRVWe1EgIngS171uV6lymMfSfvKKzrcp1uEs+7pxohJ3B02fUc
	 AYBE6WIqc3nUeQD6pFrH/zalOBvGYXWpmQbFHWCgf3xsPzgT7lG3pb5T52WbLsw3OX
	 Z08jG0z86D14wlPEN4KNfiP6CkRX637SmpF+09uqRZ+VECWzc2VhsrRMc9BGyj89AO
	 4b2aMMx0lFXH2rdd4GItvYWV/QyvDM9JLKDXUoV1oN+mMvt+fC//Wrylk3ao3GB9io
	 9lov5pXbdQNJw==
Date: Tue, 15 Apr 2025 14:06:20 -0700
From: Luis Chamberlain <mcgrof@kernel.org>
To: Jan Kara <jack@suse.cz>
Cc: Christian Brauner <brauner@kernel.org>, tytso@mit.edu,
	adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
	riel@surriel.com, dave@stgolabs.net, willy@infradead.org,
	hannes@cmpxchg.org, oliver.sang@intel.com, david@redhat.com,
	axboe@kernel.dk, hare@suse.de, david@fromorbit.com,
	djwong@kernel.org, ritesh.list@gmail.com,
	linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
	linux-mm@kvack.org, gost.dev@samsung.com, p.raghav@samsung.com,
	da.gomez@samsung.com,
	syzbot+f3c6fda1297c748a7076@syzkaller.appspotmail.com
Subject: Re: [PATCH v2 1/8] migrate: fix skipping metadata buffer heads on
 migration
Message-ID: <Z_7KTEKEzC9Fh2rn@bombadil.infradead.org>
References: <20250410014945.2140781-1-mcgrof@kernel.org>
 <20250410014945.2140781-2-mcgrof@kernel.org>
 <dpn6pb7hwpmajoh5k5zla6x7fsmh4rlttstj3hkuvunp6tok3j@ikz2fxpikfv4>
 <Z_15mCAv6nsSgRTf@bombadil.infradead.org>
 <Z_2J9bxCqAUPgq42@bombadil.infradead.org>
 <20250415-freihalten-tausend-a9791b9c3a03@brauner>
 <Z_5_p3t_fNUBoG7Y@bombadil.infradead.org>
 <dkjq2c57du34wq7ocvtk37a5gkcondxfedgnbdxse55nhlfioy@v6tx45lkopfm>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dkjq2c57du34wq7ocvtk37a5gkcondxfedgnbdxse55nhlfioy@v6tx45lkopfm>

On Tue, Apr 15, 2025 at 06:23:54PM +0200, Jan Kara wrote:
> On Tue 15-04-25 08:47:51, Luis Chamberlain wrote:
> > On Tue, Apr 15, 2025 at 11:05:38AM +0200, Christian Brauner wrote:
> > > On Mon, Apr 14, 2025 at 03:19:33PM -0700, Luis Chamberlain wrote:
> > > > On Mon, Apr 14, 2025 at 02:09:46PM -0700, Luis Chamberlain wrote:
> > > > > On Thu, Apr 10, 2025 at 02:05:38PM +0200, Jan Kara wrote:
> > > > > > > @@ -859,12 +862,12 @@ static int __buffer_migrate_folio(struct address_space *mapping,
> > > > > > >  			}
> > > > > > >  			bh = bh->b_this_page;
> > > > > > >  		} while (bh != head);
> > > > > > > +		spin_unlock(&mapping->i_private_lock);
> > > > > > 
> > > > > > No, you've just broken all simple filesystems (like ext2) with this patch.
> > > > > > You can reduce the spinlock critical section only after providing
> > > > > > alternative way to protect them from migration. So this should probably
> > > > > > happen at the end of the series.
> > > > > 
> > > > > So you're OK with this spin lock move with the other series in place?
> > > > > 
> > > > > And so we punt the hard-to-reproduce corruption issue as future work
> > > > > to do? Becuase the other alternative for now is to just disable
> > > > > migration for jbd2:
> > > > > 
> > > > > diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> > > > > index 1dc09ed5d403..ef1c3ef68877 100644
> > > > > --- a/fs/ext4/inode.c
> > > > > +++ b/fs/ext4/inode.c
> > > > > @@ -3631,7 +3631,6 @@ static const struct address_space_operations ext4_journalled_aops = {
> > > > >  	.bmap			= ext4_bmap,
> > > > >  	.invalidate_folio	= ext4_journalled_invalidate_folio,
> > > > >  	.release_folio		= ext4_release_folio,
> > > > > -	.migrate_folio		= buffer_migrate_folio_norefs,
> > > > >  	.is_partially_uptodate  = block_is_partially_uptodate,
> > > > >  	.error_remove_folio	= generic_error_remove_folio,
> > > > >  	.swap_activate		= ext4_iomap_swap_activate,
> > > > 
> > > > BTW I ask because.. are your expectations that the next v3 series also
> > > > be a target for Linus tree as part of a fix for this spinlock
> > > > replacement?
> > > 
> > > Since this is fixing potential filesystem corruption I will upstream
> > > whatever we need to do to fix this. Ideally we have a minimal fix to
> > > upstream now and a comprehensive fix and cleanup for v6.16.
> > 
> > Despite our efforts we don't yet have an agreement on how to fix the
> > ext4 corruption, becuase Jan noted the buffer_meta() check in this patch
> > is too broad and would affect other filesystems (I have yet to
> > understand how, but will review).
> > 
> > And so while we have agreement we can remove the spin lock to fix the
> > sleeping while atomic incurred by large folios for buffer heads by this
> > patch series, the removal of the spin lock would happen at the end of
> > this series.
> > 
> > And so the ext4 corruption is an existing issue as-is today, its
> > separate from the spin lock removal goal to fix the sleeping while
> > atomic..
> 
> I agree. Ext4 corruption problems are separate from sleeping in atomic
> issues.

Glad that's clear.

> > However this series might be quite big for an rc2 or rc3 fix for that spin
> > lock removal issue. It should bring in substantial performance benefits
> > though, so it might be worthy to consider. We can re-run tests with the
> > adjustment to remove the spin lock until the last patch in this series.
> > 
> > The alternative is to revert the spin lock addition commit for Linus'
> > tree, ie commit ebdf4de5642fb6 ("mm: migrate: fix reference check race
> > between __find_get_block() and migration") and note that it in fact does
> > not fix the ext4 corruption as we've noted, and in fact causes an issue
> > with sleeping while atomic with support for large folios for buffer
> > heads. If we do that then we  punt this series for the next development
> > window, and it would just not have the spin lock removal on the last
> > patch.
> 
> Well, the commit ebdf4de5642fb6 is 6 years old. At that time there were no
> large folios (in fact there were no folios at all ;)) in the page cache and
> it does work quite well (I didn't see a corruption report from real users
> since then).

It is still a work around.

> So I don't like removing that commit because it makes a
> "reproducible with a heavy stress test" problem become a "reproduced by
> real world workloads" problem.

So how about just patch 2 and 8 in this series, with the spin lock
removal happening on the last patch for Linus tree?

  Luis

