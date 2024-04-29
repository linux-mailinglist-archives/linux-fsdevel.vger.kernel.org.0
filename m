Return-Path: <linux-fsdevel+bounces-18184-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D4BB8B626E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Apr 2024 21:38:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3FE731C2148D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Apr 2024 19:38:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C63B613B2BB;
	Mon, 29 Apr 2024 19:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="bF9BfMwu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1436839FD;
	Mon, 29 Apr 2024 19:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714419525; cv=none; b=GcExgvUvyOMagyLtHgfTZLMOU6s01TTiU15OHbNrzOYMkc8xetRasHjVTMv34UCsOG3PTB3EoDQvMxobc7/Zq54Hm+EBnw4jtho0vr6URuDgRBpBiYOtqMLEZAiemDOTV7p0ZFeRKcKrhSQb90ioYZHpewD+UPaL4jiiTDTQLTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714419525; c=relaxed/simple;
	bh=6sOyCYbmudXxqIfu8q2gns5cKCCQS7+LZ0HN4mbWG3E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P8/OIMloDTBk8zR51T6wqWyXSwvsx0KQxu6JzjDHDoCugHXORIR8rTr10pfiZ7QoDSEaEKqLLk/PwEbJwrpVzMNGpAEW/BwO/7VtSz3EI8zdgi68xRZJ3i/4mibpV+ZOEHEzomqdydcus0xdYnTZDOQ5xMU+osdWSIfTIM5Cjbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=bF9BfMwu; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=mhiR8BMDH8TnfXdcMJSpEG42MjSDkV9S8051r036NMU=; b=bF9BfMwuyaFnCeeHNcd0cOmAmf
	q1RgqnXFU2/R6KGuz4/E1f9q4VMiepPinqDu6cjHubiBD04zcEAN4Rni0rDM6hyRrWhIx43uopdH1
	cWk1GjHdPRXGBno/F9VK5h4Z9dnQmK2/Tdf3n6PnjDatZTr0lTEwHZ+GxwLOEtR/63AgCWs7kCXpP
	QE7q9I0Tkw+1XHiKQaA0h6ionXFdrR0OCWD3LVEO49BFTKF1NGIWsNFEJ7zds7iR+zzZLi3s62lJA
	oUJyeb2Yx4ZrJFHOtXh6aZa5ba+pDl/HL45PvoosF6z+RNko6DIL3ZXAqt8HunQcOXOGPU8oIlxcR
	mK5eZJxA==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s1Wpf-0000000DBQI-3MMq;
	Mon, 29 Apr 2024 19:38:35 +0000
Date: Mon, 29 Apr 2024 20:38:35 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Ryusuke Konishi <konishi.ryusuke@gmail.com>
Cc: Kairui Song <ryncsn@gmail.com>, linux-mm@kvack.org,
	Andrew Morton <akpm@linux-foundation.org>,
	"Huang, Ying" <ying.huang@intel.com>, Chris Li <chrisl@kernel.org>,
	Barry Song <v-songbaohua@oppo.com>,
	Ryan Roberts <ryan.roberts@arm.com>, Neil Brown <neilb@suse.de>,
	Minchan Kim <minchan@kernel.org>, Hugh Dickins <hughd@google.com>,
	David Hildenbrand <david@redhat.com>,
	Yosry Ahmed <yosryahmed@google.com>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-nilfs@vger.kernel.org
Subject: Re: [PATCH v3 02/12] nilfs2: drop usage of page_index
Message-ID: <Zi_3OxP6xKjBWBLO@casper.infradead.org>
References: <20240429190500.30979-1-ryncsn@gmail.com>
 <20240429190500.30979-3-ryncsn@gmail.com>
 <Zi_xeKUSD6C8TNYK@casper.infradead.org>
 <CAMgjq7D5zwksHxh5c00U82BCsLxYj-_GevZZtAM8xNZO7p-RQQ@mail.gmail.com>
 <CAKFNMomdPzaF4AL5qHCZovtgdefd3V35D_qFDPoMeXyWCZtzUg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKFNMomdPzaF4AL5qHCZovtgdefd3V35D_qFDPoMeXyWCZtzUg@mail.gmail.com>

On Tue, Apr 30, 2024 at 04:28:41AM +0900, Ryusuke Konishi wrote:
> On Tue, Apr 30, 2024 at 4:22 AM Kairui Song <ryncsn@gmail.com> wrote:
> >
> > On Tue, Apr 30, 2024 at 3:14 AM Matthew Wilcox <willy@infradead.org> wrote:
> > >
> > > On Tue, Apr 30, 2024 at 03:04:50AM +0800, Kairui Song wrote:
> > > > From: Kairui Song <kasong@tencent.com>
> > > >
> > > > page_index is only for mixed usage of page cache and swap cache, for
> > > > pure page cache usage, the caller can just use page->index instead.
> > > >
> > > > It can't be a swap cache page here (being part of buffer head),
> > > > so just drop it, also convert it to use folio.
> > > >
> > > > Signed-off-by: Kairui Song <kasong@tencent.com>
> > > > Cc: Ryusuke Konishi <konishi.ryusuke@gmail.com>
> > > > Cc: linux-nilfs@vger.kernel.org
> > > > ---
> > > >  fs/nilfs2/bmap.c | 5 ++---
> > > >  1 file changed, 2 insertions(+), 3 deletions(-)
> > > >
> > > > diff --git a/fs/nilfs2/bmap.c b/fs/nilfs2/bmap.c
> > > > index 383f0afa2cea..f4e5df0cd720 100644
> > > > --- a/fs/nilfs2/bmap.c
> > > > +++ b/fs/nilfs2/bmap.c
> > > > @@ -453,9 +453,8 @@ __u64 nilfs_bmap_data_get_key(const struct nilfs_bmap *bmap,
> > > >       struct buffer_head *pbh;
> > > >       __u64 key;
> > > >
> > > > -     key = page_index(bh->b_page) << (PAGE_SHIFT -
> > > > -                                      bmap->b_inode->i_blkbits);
> > > > -     for (pbh = page_buffers(bh->b_page); pbh != bh; pbh = pbh->b_this_page)
> > > > +     key = bh->b_folio->index << (PAGE_SHIFT - bmap->b_inode->i_blkbits);
> > > > +     for (pbh = folio_buffers(bh->b_folio); pbh != bh; pbh = pbh->b_this_page)
> > > >               key++;
> > > >
> > > >       return key;
> > >
> > > Why isn't this entire function simply:
> > >
> > >         return bh->b_blocknr;
> > >
> >
> > Nice idea, I didn't plan for extra clean up and test for fs code, but
> > this might be OK to have, will check it.
> 
> Wait a minute.
> 
> This function returns a key that corresponds to the cache offset of
> the data block, not the disk block number.
> 
> Why is returning to bh->b_blocknr an alternative ?
> Am I missing something?

Sorry, I forgot how b_blocknr was used.  What I meant was:

	u64 key = bh->b_folio->index << (PAGE_SHIFT - bmap->b_inode->i_blkbits);

	return key + bh_offset(bh) >> bmap->b_inode->i_blkbits;

The point is to get rid of the loop.  We could simplify this (and make
it ready for bs>PS) by doing:

	loff_t pos = folio_pos(bh->b_folio) + bh_offset(bh);
	return pos >> bmap->b_inode->i_blkbits;

