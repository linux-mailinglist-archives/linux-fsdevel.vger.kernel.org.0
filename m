Return-Path: <linux-fsdevel+bounces-21469-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BED49045C3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Jun 2024 22:30:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F2311C2346E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Jun 2024 20:30:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77B3915251B;
	Tue, 11 Jun 2024 20:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="uA/KgJ8Y"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A351150992;
	Tue, 11 Jun 2024 20:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718137796; cv=none; b=BWK+jsJ+r44D+mczBahpfzizm7vVcMVfELDwCepmVWSMYtIUbx7u6cedcVBrr/4AbsrAQ+vdBw+b5EGBwWD4xjRAFe1JyLj43Wy14jHW7vcwpgNaILRY3XFxNRuSTGIgiCHz4w4F/cDnPrYtaP/3FHYFGQF4m3ahds4EUDiCMlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718137796; c=relaxed/simple;
	bh=nEolDgKDErGZBB7tKOsfxS/IbFXltUDKzh24roXfRlc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mg0l1CeClyKZhHfU80BxOvuA0cmiIA127kYU9yStItDYN+VAecf7AMr/MTTmqyxkHCHO3+s7TDsxIRtNK2FqNTsH3dRizNhAkO5ApLe21axfnK3r68mEeCZ0ZAIVSpDiwbFF+n7z8AcAaF8y3F1/nz0JkzRms/2xFNnOKXd1Vbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=uA/KgJ8Y; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=HHzIStUOi1BlV4wZTTFPN76eG154vJPSJLDHU9Auc44=; b=uA/KgJ8YREtF6OVuaY9TnG905E
	PDJi0R8oAMwiEe/Dm8lxtKIRVml1NvCqfp4Lfueb7dwt8LKtfCyEwblg/XskJKdlr4KzPec1plzJp
	qMBiHeC3I6lN0ZreVNVi4CWRbhrV50jXkRJiJ3lOA6IOXw9IsO51W8l1sqzAxlQ4WZ4Gsw85LU5xA
	jaIapNkFvtI++2amxryf5Sq1KbXnzNxUXbQYvs9vVk3RlHRXy0IBv7lMXe1rtlUMIlt252WUheX5G
	lN33sZx/Re4m6YLn85oOGyz0VCAnuVTg129NzISLFi6DpTv6ZBG270XmQz/iW1uisYx9ilRHRv0UG
	OvxWTTLQ==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sH87r-0000000AAtM-3xS6;
	Tue, 11 Jun 2024 20:29:51 +0000
Date: Tue, 11 Jun 2024 13:29:51 -0700
From: Luis Chamberlain <mcgrof@kernel.org>
To: "Darrick J. Wong" <djwong@kernel.org>, hughd@google.com
Cc: patches@lists.linux.dev, fstests@vger.kernel.org,
	linux-xfs@vger.kernel.org, linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org, akpm@linux-foundation.org,
	ziy@nvidia.com, vbabka@suse.cz, seanjc@google.com,
	willy@infradead.org, david@redhat.com, hughd@google.com,
	linmiaohe@huawei.com, muchun.song@linux.dev, osalvador@suse.de,
	p.raghav@samsung.com, da.gomez@samsung.com, hare@suse.de,
	john.g.garry@oracle.com
Subject: Re: [PATCH 2/5] fstests: add mmap page boundary tests
Message-ID: <Zmizv_g728OwNFrg@bombadil.infradead.org>
References: <20240611030203.1719072-1-mcgrof@kernel.org>
 <20240611030203.1719072-3-mcgrof@kernel.org>
 <20240611164811.GL52977@frogsfrogsfrogs>
 <ZmiTBZLQ8uOGS5i8@bombadil.infradead.org>
 <20240611184603.GA52987@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240611184603.GA52987@frogsfrogsfrogs>
Sender: Luis Chamberlain <mcgrof@infradead.org>

On Tue, Jun 11, 2024 at 11:46:03AM -0700, Darrick J. Wong wrote:
> On Tue, Jun 11, 2024 at 11:10:13AM -0700, Luis Chamberlain wrote:
> > On Tue, Jun 11, 2024 at 09:48:11AM -0700, Darrick J. Wong wrote:
> > > On Mon, Jun 10, 2024 at 08:01:59PM -0700, Luis Chamberlain wrote:
> > > > +# As per POSIX NOTES mmap(2) maps multiples of the system page size, but if the
> > > > +# data mapped is not multiples of the page size the remaining bytes are zeroed
> > > > +# out when mapped and modifications to that region are not written to the file.
> > > > +# On Linux when you write data to such partial page after the end of the
> > > > +# object, the data stays in the page cache even after the file is closed and
> > > > +# unmapped and  even  though  the data  is never written to the file itself,
> > > > +# subsequent mappings may see the modified content. If you go *beyond* this
> > > 
> > > Does this happen (mwrite data beyond eof sticks around) with large
> > > folios as well?
> > 
> > That corner case of checking to see if it stays is not tested by this
> > test, but we could / should extend this test later for that. But then
> > the question becomes, what is right, given we are in grey area, if we
> > don't have any defined standard for it, it seems odd to test for it.
> > 
> > So the test currently only tests for correctness of what we expect for
> > POSIX and what we all have agreed for Linux.
> > 
> > Hurding everyone to follow suit for the other corner cases is something
> > perhaps we should do. Do we have a "strict fail" ? So that perhaps we can
> > later add a test case for it and so that onnce and if we get consensus
> > on what we do we can enable say a "strict-Linux" mode where we are
> > pedantic about a new world order?
> 
> I doubt there's an easy way to guarantee more than "initialized to zero,
> contents may stay around in memory but will not be written to disk".
> You could do asinine things like fault on every access and manually
> inject zero bytes, but ... yuck.

Sure, but I suspect the real issue is if it does something like leak
data which it should not. The test as-is does test to ensure the data
is zeroed.

If we want to add a test to close the mmap and ensure the data beyond
the file content up to PAGE_SIZE is still zeroed out, it's easy to do,
it was just that it seems that *could* end up with different results
depending on the filesystem.

> That said -- let's say you have a 33k file, and a space mapping for
> 0-63k 

What block size filesystem in this example? If the lengh is 33k, whether
or not it was truncated does not matter, the file size is what matters.
The block size is what we use for the minimum order folio, and sincee we
start at offset 0, a 33k sized file on a 64k block size filesystem will
get a 64k folio. On a 32k block size filesystem, it will get two 32k
foios.

> (e.g. it was preallocated).

Do you mean sparse or what? Because if its a sparse file it will still
change the size of the file, so just wanted to check.

> Can the pagecache grab (say) a 64k folio for the EOF part of the pagecache?

It depends on the block size of the filesystem. If 4k, we'd go up to
36k, and 33k-46k would be zereod.

With min order, we'd have a folio of 8k, 32k, or 64k. For 8k we'd have
5 folios of 8k size each, the last one have only 1k of data, and 3k
zeroed out. No PTEs would be assigned for that folio beyond 36k boundary
and so we'd SIGBUS on access beyond it. We test for this in this test.

> And can you mmap that whole region?

No, we test for this too here. You can  only mmap up to the aligned
PAGE_SIZE of the file size.

> And see even more grey area mmapping?

No, we limit up to PAGE_SIZE alignement.

> Or does mmap always cut
> off the mapping at roundup(i_size_read(), PAGE_SIZE) ?

That's right, we do this, without LBS this was implied, but with LBS
we have to be explicit about using the PAGE_SIZE alignment restriction.

This test checks for all that, and checks for both integrity of the contents
and file size even if you muck with the extra fluff allowed by mmap().

> > > What other data?
> > 
> > Beats me, got that from the man page bible on mmap. I think its homework
> > for us to find out who is spewing that out, which gives a bit more value
> > to the idea of that strict-linux thing. How else will we find out?
> 
> Oh, ok.  I couldn't tell if *you* had seen "other" data emerging from
> the murk, or if that was merely what a spec says.  Please cite the
> particular bible you were reading. ;)

From the mmap(2) man page: "subsequent mappings may see the modified content."
so I extended this with the implications of it using *may*.

Speaking of the man page, I see also that huge pages are addressed there
and when a huge page is used it says:

"The system automatically aligns length to be a multiple of the
underlying huge page size"

And so I believes that means we need to check for the huge page on
filemap_map_pages() and also the test and adjust it to align to the
specific huge page size if used...

Or just skip tmpfs / hugetlbfs for now...

  Luis

