Return-Path: <linux-fsdevel+bounces-18196-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCFAB8B66E3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Apr 2024 02:31:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8370C2834B2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Apr 2024 00:31:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A0261FB2;
	Tue, 30 Apr 2024 00:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="mZtlK3e2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F15363D;
	Tue, 30 Apr 2024 00:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714437070; cv=none; b=GdsgNgDsZ8HTQm3w/pnnjjGbi22fWsRs3fNx73fLbElXA3bJJXfZ5Ucsl08J0NmZmoSZMo20TL+GTtkuw016T+6Zdqb8bEM74yzv1KTWLdFH3LtL1E6mfQjZLQe+c5+3CetY/OkQipPKKUAw+UoZJ+ItyxBizp6RCSJFBWy4KhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714437070; c=relaxed/simple;
	bh=zbabn4bYczmAMt84G0q9LOhSpRMq5wb3vv9mBqCZXM4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lrWdeZeRGAGOCixTYuLAOLgJg5SxeQ42DbVtVw6o7zXEIT6HgaadVgChFrd/wpxI3yye49SdQUhP7qCNiJQ4v6lA+bXZ79xGPItUQKFFqf8FTmW5s8im2P5xEtx16VGGeIAAYDkYXP/A2P8LBCL+GGyA+piMWnyTCN5TPgnzPrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=mZtlK3e2; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description;
	bh=mVey8R8Zz45QQuqemHBOMxf/98lgRmfH3Sz6ARn8tbY=; b=mZtlK3e2Iyyi/JVP6RhPWslTNs
	nrpbisQN6UwcnWIZPM+fAVz/a0aU76JsntebMl9ZhtVTi2gX8Ftw7S+hkhSDqukPsy0IloJ6qKRAn
	1BlhjG9dF825mzb3IV9lwYpemkcI3kKkFx31jT/bgeW8yanjn8W9irlbBcSeJhmpPe3qmpIQGvEOW
	777nct7/aA0p2533nrT9C3/pTOckaDlsIjNYoFUS3mf2aQiyTY2jm5ePjjoKADD8oOfHxitxO8Jw3
	2oTgBHRwbsTyDHMNIEcBzC5FtwpyTay5gNZQTWsWFkHycMPcY5qyTNPTRm7TkZB4URjxY0FQuq91/
	3gbJhLGA==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s1bOi-00000004ZVy-0u0j;
	Tue, 30 Apr 2024 00:31:04 +0000
Date: Mon, 29 Apr 2024 17:31:04 -0700
From: Luis Chamberlain <mcgrof@kernel.org>
To: Zi Yan <ziy@nvidia.com>
Cc: Vlastimil Babka <vbabka@suse.cz>,
	Sean Christopherson <seanjc@google.com>,
	Matthew Wilcox <willy@infradead.org>,
	"Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>,
	djwong@kernel.org, brauner@kernel.org, david@fromorbit.com,
	chandan.babu@oracle.com, akpm@linux-foundation.org,
	linux-fsdevel@vger.kernel.org, hare@suse.de,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	linux-xfs@vger.kernel.org, gost.dev@samsung.com,
	p.raghav@samsung.com
Subject: Re: [PATCH v4 05/11] mm: do not split a folio if it has minimum
 folio order requirement
Message-ID: <ZjA7yBQjkh52TM_T@bombadil.infradead.org>
References: <20240425113746.335530-1-kernel@pankajraghav.com>
 <20240425113746.335530-6-kernel@pankajraghav.com>
 <Ziq4qAJ_p7P9Smpn@casper.infradead.org>
 <Zir5n6JNiX14VoPm@bombadil.infradead.org>
 <Ziw8w3P9vljrO9JV@bombadil.infradead.org>
 <Zi2e7ecKJK6p6ERu@bombadil.infradead.org>
 <Zi8aYA92pvjDY7d5@bombadil.infradead.org>
 <6799F341-9E37-4F3E-B0D0-B5B2138A5F5F@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <6799F341-9E37-4F3E-B0D0-B5B2138A5F5F@nvidia.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>

On Mon, Apr 29, 2024 at 10:29:29AM -0400, Zi Yan wrote:
> On 28 Apr 2024, at 23:56, Luis Chamberlain wrote:
>=20
> > On Sat, Apr 27, 2024 at 05:57:17PM -0700, Luis Chamberlain wrote:
> >> On Fri, Apr 26, 2024 at 04:46:11PM -0700, Luis Chamberlain wrote:
> >>> On Thu, Apr 25, 2024 at 05:47:28PM -0700, Luis Chamberlain wrote:
> >>>> On Thu, Apr 25, 2024 at 09:10:16PM +0100, Matthew Wilcox wrote:
> >>>>> On Thu, Apr 25, 2024 at 01:37:40PM +0200, Pankaj Raghav (Samsung) w=
rote:
> >>>>>> From: Pankaj Raghav <p.raghav@samsung.com>
> >>>>>>
> >>>>>> using that API for LBS is resulting in an NULL ptr dereference
> >>>>>> error in the writeback path [1].
> >>>>>>
> >>>>>> [1] https://gist.github.com/mcgrof/d12f586ec6ebe32b2472b5d634c397df
> >>>>>
> >>>>>  How would I go about reproducing this?
> >>
> >> Well so the below fixes this but I am not sure if this is correct.
> >> folio_mark_dirty() at least says that a folio should not be truncated
> >> while its running. I am not sure if we should try to split folios then
> >> even though we check for writeback once. truncate_inode_partial_folio()
> >> will folio_wait_writeback() but it will split_folio() before checking
> >> for claiming to fail to truncate with folio_test_dirty(). But since the
> >> folio is locked its not clear why this should be possible.
> >>
> >> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> >> index 83955362d41c..90195506211a 100644
> >> --- a/mm/huge_memory.c
> >> +++ b/mm/huge_memory.c
> >> @@ -3058,7 +3058,7 @@ int split_huge_page_to_list_to_order(struct page=
 *page, struct list_head *list,
> >>  	if (new_order >=3D folio_order(folio))
> >>  		return -EINVAL;
> >>
> >> -	if (folio_test_writeback(folio))
> >> +	if (folio_test_dirty(folio) || folio_test_writeback(folio))
> >>  		return -EBUSY;
> >>
> >>  	if (!folio_test_anon(folio)) {
> >
> > I wondered what code path is causing this and triggering this null
> > pointer, so I just sprinkled a check here:
> >
> > 	VM_BUG_ON_FOLIO(folio_test_dirty(folio), folio);
> >
> > The answer was:
> >
> > kcompactd() --> migrate_pages_batch()
> >                   --> try_split_folio --> split_folio_to_list() -->
> > 		       split_huge_page_to_list_to_order()
> >
>=20
> There are 3 try_split_folio() in migrate_pages_batch().

This is only true for linux-next, for v6.9-rc5 off of which this testing
is based on there are only two.

> First one is to split anonymous large folios that are on deferred
> split list, so not related;

This is in linux-next and not v6.9-rc5.

> second one is to split THPs when thp migration is not supported, but
> this is compaction, so not related; third one is to split large folios
> when there is no same size free page in the system, and this should be
> the one.

Agreed, the case where migrate_folio_unmap() failed with -ENOMEM. This
also helps us enhance the reproducer further, which I'll do next.

> > And I verified that moving the check only to the migrate_pages_batch()
> > path also fixes the crash:
> >
> > diff --git a/mm/migrate.c b/mm/migrate.c
> > index 73a052a382f1..83b528eb7100 100644
> > --- a/mm/migrate.c
> > +++ b/mm/migrate.c
> > @@ -1484,7 +1484,12 @@ static inline int try_split_folio(struct folio *=
folio, struct list_head *split_f
> >  	int rc;
> >
> >  	folio_lock(folio);
> > +	if (folio_test_dirty(folio)) {
> > +		rc =3D -EBUSY;
> > +		goto out;
> > +	}
> >  	rc =3D split_folio_to_list(folio, split_folios);
> > +out:
> >  	folio_unlock(folio);
> >  	if (!rc)
> >  		list_move_tail(&folio->lru, split_folios);
> >
> > However I'd like compaction folks to review this. I see some indications
> > in the code that migration can race with truncation but we feel fine by
> > it by taking the folio lock. However here we have a case where we see
> > the folio clearly locked and the folio is dirty. Other migraiton code
> > seems to write back the code and can wait, here we just move on. Further
> > reading on commit 0003e2a414687 ("mm: Add AS_UNMOVABLE to mark mapping
> > as completely unmovable") seems to hint that migration is safe if the
> > mapping either does not exist or the mapping does exist but has
> > mapping->a_ops->migrate_folio so I'd like further feedback on this.
>=20
> During migration, all page table entries pointing to this dirty folio
> are invalid, and accesses to this folio will cause page fault and
> wait on the migration entry. I am not sure we need to skip dirty folios.

I see.. thanks!

> > Another thing which requires review is if we we split a folio but not
> > down to order 0 but to the new min order, does the accounting on
> > migrate_pages_batch() require changing?  And most puzzling, why do we
>=20
> What accounting are you referring to? split code should take care of it.

The folio order can change after split, and so I was concerned about the
nr_pages used in migrate_pages_batch(). But I see now that when
migrate_folio_unmap() first failed we try to split the folio, and if
successful I see now we the caller will again call migrate_pages_batch()
with a retry attempt of 1 only to the split folios. I also see the
nr_pages is just local to each list for each loop, first on the from
list to unmap and afte on the unmap list so we move the folios.

> > not see this with regular large folios, but we do see it with minorder ?
>=20
> I wonder if the split code handles folio->mapping->i_pages properly.
> Does the i_pages store just folio pointers or also need all tail page
> pointers? I am no expert in fs, thus need help.

mapping->i_pages stores folio pointers in the page cache or
swap/dax/shadow entries (xa_is_value(folio)). The folios however can be
special and we special-case them with shmem_mapping(mapping) checks.
split_huge_page_to_list_to_order() doens't get called with swap/dax/shadow=
=20
entries, and we also bail out on shmem_mapping(mapping) already.

  Luis

