Return-Path: <linux-fsdevel+bounces-75934-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oBVjGQZRfGmlLwIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75934-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Jan 2026 07:34:46 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 84887B7A40
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Jan 2026 07:34:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E56C730055E0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Jan 2026 06:34:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1C8533506C;
	Fri, 30 Jan 2026 06:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="nWVtDZWT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dyPa23ED"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9E442DF6E3;
	Fri, 30 Jan 2026 06:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769754874; cv=none; b=N7XMYBtdWFImdzwlSGzTZLe+EZEXcfWSa7GhE1kghxFYrhcEgq36yGzmmsmEmyXJegt4AiXVITsky3vObl3eGWIr66c6IlD/UNy7cPLZ5DR/ZzSYBtIg1Makqo78pLs+wSSeZ9J2qWbpuQNkg736PUHviU3+A+gBAJqn0Eu9QSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769754874; c=relaxed/simple;
	bh=/g6/ZCbMcaJojfrnZaKdyd+h6d01Dh8PyhF5X/+A8dk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H4qAs463oDmR4cGbVBoMTkMqeUEe1r6+U/JEAUYQRbUBjAYDnPeoHRW3BGBZOawPgMT9574STEHxTL/+FN7CjdIhsn4wdwPN7Ub1nJimFBkgmOHC4iTdANV8WWcTHJ15zv+QGGB0S7AIkbMhJca7nAx0aDSYuRgVVPVjSO2wGb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=nWVtDZWT; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dyPa23ED; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id E22F6140016A;
	Fri, 30 Jan 2026 01:34:31 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Fri, 30 Jan 2026 01:34:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1769754871;
	 x=1769841271; bh=1+9nvVVbTjCCcxfbgJ/OBBjj64Rx7miC7RNJM8dlF4U=; b=
	nWVtDZWTc1m4V9Rez0jRewaDzBa2rsZoEnCxdIEtfOIVR1iKygmyfkQqkMnNwCL+
	eeUKpBuhXxzELY7n9BGgdwczFc3+NN1764+x/tRsxSJYEn1h1lODW5lhUNd4RLAQ
	A5XekEvABtJ7stlPIhrb7o4YW/WqRq08VoA/AXmpUix+Ai2azEgRfy2Z1ozQm6ey
	ifKa9nJeVwJZ1QVRyihrMPdzLocDvzFBJr9xVMcgpqLQ/pLtyVSZvCRyHOAzaXz8
	j1EEfxl9YDO9Kt8eArenYqZRqXAwn4mH+XwVr257R0gfB2r96tkZ4/Ia20zoor6L
	pSDjkd+MNIjh966rQ6670A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1769754871; x=
	1769841271; bh=1+9nvVVbTjCCcxfbgJ/OBBjj64Rx7miC7RNJM8dlF4U=; b=d
	yPa23EDniEOKOKDs0YACs8LoldgUykU+GNIPPzoA+vXQ/l3mpRpMQoZ4BiJhhCsh
	1/AMyClFjuNnHGPQ9PcJz0RsyFToIOStfYNzGizgxdEGC3/94Q5T7DeZniTFQkyw
	qxa/x0Dw8B0uRUQ/poyNoHegHk5djFGX4MOp8tDIHDMyTCJrjNFubBTsLJSjMlR8
	3o/7XfINuGEg8OmZxqDCSsDZh2q8XZ2atED7Hgj1k/UPL4Tq3Hpc0MgtjTKtLh8g
	AXu+WAUSak8r4zdfi+crW67hvJjXFh8ckPi2y53SdVABrOQrheG8e5WFsdIPpUqi
	/O2DP6L9l7HiDHpFAdZUA==
X-ME-Sender: <xms:91B8aRUM-HyPQQx_9Ihoni2NihDTGrOa4ebss63Qpt3yU0TuD-aoQQ>
    <xme:91B8adkAjEo7B-yUfF6T6qh_BfQSVz9RSJf1wWFaCXg6NHwaTR20oget5EttwPPHR
    bJ8j8H9JkHI1TMrXADINJrCPhw2s2C9VBW8Y6EymgKtJ5msNFK1QDs>
X-ME-Received: <xmr:91B8afmiLv9Nu4L4XYpCIuNROF54ozrsMGJdt2gV6D3xrX1CUGXc9xG1oQ1mTjCA5eJnuhFP1U1q2RAN-sST0jYbDHE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduieekfeefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtugfgjgesthekre
    dttddtjeenucfhrhhomhepuehorhhishcuuehurhhkohhvuceosghorhhishessghurhdr
    ihhoqeenucggtffrrghtthgvrhhnpedulefhtdfhteduvdethfeftdeitdethedvtdekvd
    eltddvveegtdeuuddtiedtieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhep
    mhgrihhlfhhrohhmpegsohhrihhssegsuhhrrdhiohdpnhgspghrtghpthhtohepkedpmh
    houggvpehsmhhtphhouhhtpdhrtghpthhtohepqhhufigvnhhruhhordgsthhrfhhssehg
    mhigrdgtohhmpdhrtghpthhtohepihhnfigrrhguvhgvshhsvghlsehgmhgrihhlrdgtoh
    hmpdhrtghpthhtoheptghlmhesfhgsrdgtohhmpdhrtghpthhtohepughsthgvrhgsrges
    shhushgvrdgtohhmpdhrtghpthhtoheplhhinhhugidqsghtrhhfshesvhhgvghrrdhkvg
    hrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhk
    vghrnhgvlhdrohhrghdprhgtphhtthhopehkvghrnhgvlhdqthgvrghmsehmvghtrgdrtg
    homhdprhgtphhtthhopehlihhnuhigqdhfshguvghvvghlsehvghgvrhdrkhgvrhhnvghl
    rdhorhhg
X-ME-Proxy: <xmx:91B8aVb6huuXQOzcqV9YhQpxmBNQt_3KcS3FYy8bqzf5F7CWVdyrSg>
    <xmx:91B8aZSvx28Y3Cg3XZCZytnUIiZMHfFdiOE4w4WUOmPNqElPyE8CaA>
    <xmx:91B8aXtvwUHWQUWmktq4XN4nRcWjsOpFJrhUSZVNXVwFhDYgsmC2-w>
    <xmx:91B8aTEpabqxaDjRtYYs2pjGYkK9FRi6RY8yHpcX6vKjLciyVmx6PQ>
    <xmx:91B8aTGRfCxeEzMgkM2q3_bIy4YHXF84hbeEbgKp1AQ0QiC_c2Ausr0Y>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 30 Jan 2026 01:34:31 -0500 (EST)
Date: Thu, 29 Jan 2026 22:34:03 -0800
From: Boris Burkov <boris@bur.io>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: JP Kobryn <inwardvessel@gmail.com>, clm@fb.com, dsterba@suse.com,
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [RFC PATCH] btrfs: defer freeing of subpage private state to
 free_folio
Message-ID: <20260130063403.GB863940@zen.localdomain>
References: <20260129230822.168034-1-inwardvessel@gmail.com>
 <776e54f6-c9b7-4b22-bde5-561dc65c9be7@gmx.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <776e54f6-c9b7-4b22-bde5-561dc65c9be7@gmx.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[bur.io:s=fm1,messagingengine.com:s=fm3];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-75934-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmx.com];
	FREEMAIL_CC(0.00)[gmail.com,fb.com,suse.com,vger.kernel.org,meta.com];
	TO_DN_SOME(0.00)[];
	DMARC_NA(0.00)[bur.io];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	DKIM_TRACE(0.00)[bur.io:+,messagingengine.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[boris@bur.io,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[8];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,messagingengine.com:dkim,zen.localdomain:mid]
X-Rspamd-Queue-Id: 84887B7A40
X-Rspamd-Action: no action

On Fri, Jan 30, 2026 at 01:46:59PM +1030, Qu Wenruo wrote:
> 
> 
> 在 2026/1/30 09:38, JP Kobryn 写道:
> [...]
> > The patch also might have the advantage of being easy to backport to the
> > LTS trees. On that note, it's worth mentioning that we encountered a kernel
> > panic as a result of this sequence on a 6.16-based arm64 host (configured
> > with 64k pages so btrfs is in subpage mode). On our 6.16 kernel, the race
> > window is shown below between points A and B:
> > 
> > [mm] page cache reclaim path        [fs] relocation in subpage mode
> > shrink_folio_list()
> >    folio_trylock() /* lock acquired */
> >    filemap_release_folio()
> >      mapping->a_ops->release_folio()
> >        btrfs_release_folio()
> >          __btrfs_release_folio()
> >            clear_folio_extent_mapped()
> >              btrfs_detach_folio_state()
> >                bfs = folio_detach_private(folio)
> >                btrfs_free_folio_state(folio)
> >                  kfree(bfs) /* point A */
> > 
> >                                     prealloc_file_extent_cluster()
> >                                       filemap_lock_folio()
> 
> Mind to explain which function is calling filemap_lock_folio()?
> 
> I guess it's filemap_invalidate_inode() -> filemap_fdatawrite_range() ->
> filemap_writeback() -> btrfs_writepages() -> extent_write_cache_pages().
> 

I think you may have missed it in the diagram, and some of the function
names may have shifted a bit between kernels, but it is relocation.

On current btrfs/for-next, I think it would be:

relocate_file_extent_cluster()
  relocate_one_folio()
    filemap_lock_folio()

> >                                         folio_try_get() /* inc refcount */
> >                                         folio_lock() /* wait for lock */
> 
> 
> Another question here is, since the folio is already released in the mm
> path, the folio should not have dirty flag set.
> 
> That means inside extent_write_cache_pages(), the folio_test_dirty() should
> return false, and we should just unlock the folio without touching it
> anymore.
> 
> Mind to explain why we still continue the writeback of a non-dirty folio?
> 

I think this question is answered by the above as well: we aren't in
writeback, we are in relocation.

Thanks,
Boris

> > 
> >    __remove_mapping()
> >      if (!folio_ref_freeze(folio, refcount)) /* point B */
> >        goto cannot_free /* folio remains in cache */
> > 
> >    folio_unlock(folio) /* lock released */
> > 
> >                                     /* lock acquired */
> >                                     btrfs_subpage_clear_updodate()
> 
> Mind to provide more context of where the btrfs_subpage_clear_uptodate()
> call is from?
> 
> >                                       bfs = folio->priv /* use-after-free */
> > 
> > This exact race during relocation should not occur in the latest upstream
> > code, but it's an example of a backport opportunity for this patch.
> 
> And mind to explain what is missing in 6.16 kernel that causes the above
> use-after-free?
> 
> > 
> > Signed-off-by: JP Kobryn <inwardvessel@gmail.com>
> > ---
> >   fs/btrfs/extent_io.c |  6 ++++--
> >   fs/btrfs/inode.c     | 18 ++++++++++++++++++
> >   2 files changed, 22 insertions(+), 2 deletions(-)
> > 
> > diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> > index 3df399dc8856..d83d3f9ae3af 100644
> > --- a/fs/btrfs/extent_io.c
> > +++ b/fs/btrfs/extent_io.c
> > @@ -928,8 +928,10 @@ void clear_folio_extent_mapped(struct folio *folio)
> >   		return;
> >   	fs_info = folio_to_fs_info(folio);
> > -	if (btrfs_is_subpage(fs_info, folio))
> > -		return btrfs_detach_folio_state(fs_info, folio, BTRFS_SUBPAGE_DATA);
> > +	if (btrfs_is_subpage(fs_info, folio)) {
> > +		/* freeing of private subpage data is deferred to btrfs_free_folio */
> > +		return;
> > +	}
> 
> Another question is, why only two fses (nfs for dir inode, and orangefs) are
> utilizing the free_folio() callback.
> 
> Iomap is doing the same as btrfs and only calls ifs_free() in
> release_folio() and invalidate_folio().
> 
> Thus it looks like free_folio() callback is not the recommended way to free
> folio->private pointer.
> 
> Cc fsdevel list on whether the free_folio() callback should have new
> callers.
> 
> >   	folio_detach_private(folio);
> 
> This means for regular folio cases, we still remove the private flag of such
> folio.
> 
> It may be fine for most cases as we will not touch folio->private anyway,
> but this still looks like a inconsistent behavior, especially the
> free_folio() callback has handling for both cases.
> 
> Thanks,
> Qu
> 
> >   }
> > diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> > index b8abfe7439a3..7a832ee3b591 100644
> > --- a/fs/btrfs/inode.c
> > +++ b/fs/btrfs/inode.c
> > @@ -7565,6 +7565,23 @@ static bool btrfs_release_folio(struct folio *folio, gfp_t gfp_flags)
> >   	return __btrfs_release_folio(folio, gfp_flags);
> >   }
> > +/* frees subpage private data if present */
> > +static void btrfs_free_folio(struct folio *folio)
> > +{
> > +	struct btrfs_folio_state *bfs;
> > +
> > +	if (!folio_test_private(folio))
> > +		return;
> > +
> > +	bfs = folio_detach_private(folio);
> > +	if (bfs == (void *)EXTENT_FOLIO_PRIVATE) {
> > +		/* extent map flag is detached in btrfs_folio_release */
> > +		return;
> > +	}
> > +
> > +	btrfs_free_folio_state(bfs);
> > +}
> > +
> >   #ifdef CONFIG_MIGRATION
> >   static int btrfs_migrate_folio(struct address_space *mapping,
> >   			     struct folio *dst, struct folio *src,
> > @@ -10651,6 +10668,7 @@ static const struct address_space_operations btrfs_aops = {
> >   	.invalidate_folio = btrfs_invalidate_folio,
> >   	.launder_folio	= btrfs_launder_folio,
> >   	.release_folio	= btrfs_release_folio,
> > +	.free_folio = btrfs_free_folio,
> >   	.migrate_folio	= btrfs_migrate_folio,
> >   	.dirty_folio	= filemap_dirty_folio,
> >   	.error_remove_folio = generic_error_remove_folio,
> 

