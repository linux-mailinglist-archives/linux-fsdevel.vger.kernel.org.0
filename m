Return-Path: <linux-fsdevel+bounces-34515-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ED5D9C62ED
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Nov 2024 21:54:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 28C9EBA6754
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Nov 2024 18:11:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8E3A215C4F;
	Tue, 12 Nov 2024 18:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A2F1VRLl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 513BB20721E
	for <linux-fsdevel@vger.kernel.org>; Tue, 12 Nov 2024 18:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731435031; cv=none; b=IWcwEFIu32Z4Vg69SAe6kU77jlqi07CBd7tMvdTcKmX0fLDxYZrWGMr4xS9QeJ6uGeCn5K794MUKmKTfZnp5lPPZqsFtdsbXBerWrsk3lzzWKUZAC0/9ACGzNxdD3e1d82cnBEy5mhSB+452ELg3K5x8akpdtb7f8j05XuZ/6zI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731435031; c=relaxed/simple;
	bh=auejVTsiysPFBoG1D6SaMyEY/YijY3VjNx6zUFhFCKc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fKid91nDux2bTnhs9BS5DoC6m7XGxZV3BMMnzxHMfa/ihRkZnUA5kYPN4RNyN3nyvBi5ZEPljyk+573BplK/NAIy38m6DFxn676F9L5fTssirS91cl2GDqQSbUbfaILuEb08s10AoMAp+YiJ538h+BFY692KS72mCjZssUJsfSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=A2F1VRLl; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731435028;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qSj0SdB8QSc7Mjd9L/4LWSQMYeFV5iHP2hv8TZtArto=;
	b=A2F1VRLl707lPY90NgwgL5pjdJjLmazJ8s+uY3kWGjn94fAh1u0y9xfbyQDmxVPqEKynRA
	nsvosuBDb15aVUUT2n6ph6c2zmPAgRqXJQhwANXkyU46hePZVkwbuE1shOhcvOe32ChDy1
	YbyAvv3ekZdxbhkjJ/Pswpw2xHvenxE=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-266--KDSIWVmPMGLF4ReAom0aQ-1; Tue,
 12 Nov 2024 13:10:24 -0500
X-MC-Unique: -KDSIWVmPMGLF4ReAom0aQ-1
X-Mimecast-MFC-AGG-ID: -KDSIWVmPMGLF4ReAom0aQ
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 042A91955BCF;
	Tue, 12 Nov 2024 18:10:22 +0000 (UTC)
Received: from bfoster (unknown [10.22.80.120])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 84FA61955F40;
	Tue, 12 Nov 2024 18:10:19 +0000 (UTC)
Date: Tue, 12 Nov 2024 13:11:52 -0500
From: Brian Foster <bfoster@redhat.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, hannes@cmpxchg.org,
	clm@meta.com, linux-kernel@vger.kernel.org, willy@infradead.org,
	kirill@shutemov.name, linux-btrfs@vger.kernel.org,
	linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH 12/16] ext4: add RWF_UNCACHED write support
Message-ID: <ZzOaaInUHOmlAL-o@bfoster>
References: <20241111234842.2024180-1-axboe@kernel.dk>
 <20241111234842.2024180-13-axboe@kernel.dk>
 <ZzOD_qV5tpv9nbw7@bfoster>
 <df2b9a81-3ebd-48fe-a205-2d4007fe73d1@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <df2b9a81-3ebd-48fe-a205-2d4007fe73d1@kernel.dk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On Tue, Nov 12, 2024 at 10:13:12AM -0700, Jens Axboe wrote:
> On 11/12/24 9:36 AM, Brian Foster wrote:
> > On Mon, Nov 11, 2024 at 04:37:39PM -0700, Jens Axboe wrote:
> >> IOCB_UNCACHED IO needs to prune writeback regions on IO completion,
> >> and hence need the worker punt that ext4 also does for unwritten
> >> extents. Add an io_end flag to manage that.
> >>
> >> If foliop is set to foliop_uncached in ext4_write_begin(), then set
> >> FGP_UNCACHED so that __filemap_get_folio() will mark newly created
> >> folios as uncached. That in turn will make writeback completion drop
> >> these ranges from the page cache.
> >>
> >> Now that ext4 supports both uncached reads and writes, add the fop_flag
> >> FOP_UNCACHED to enable it.
> >>
> >> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> >> ---
> >>  fs/ext4/ext4.h    |  1 +
> >>  fs/ext4/file.c    |  2 +-
> >>  fs/ext4/inline.c  |  7 ++++++-
> >>  fs/ext4/inode.c   | 18 ++++++++++++++++--
> >>  fs/ext4/page-io.c | 28 ++++++++++++++++------------
> >>  5 files changed, 40 insertions(+), 16 deletions(-)
> >>
> > ...
> >> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> >> index 54bdd4884fe6..afae3ab64c9e 100644
> >> --- a/fs/ext4/inode.c
> >> +++ b/fs/ext4/inode.c
> >> @@ -1138,6 +1138,7 @@ static int ext4_write_begin(struct file *file, struct address_space *mapping,
> >>  	int ret, needed_blocks;
> >>  	handle_t *handle;
> >>  	int retries = 0;
> >> +	fgf_t fgp_flags;
> >>  	struct folio *folio;
> >>  	pgoff_t index;
> >>  	unsigned from, to;
> >> @@ -1164,6 +1165,15 @@ static int ext4_write_begin(struct file *file, struct address_space *mapping,
> >>  			return 0;
> >>  	}
> >>  
> >> +	/*
> >> +	 * Set FGP_WRITEBEGIN, and FGP_UNCACHED if foliop contains
> >> +	 * foliop_uncached. That's how generic_perform_write() informs us
> >> +	 * that this is an uncached write.
> >> +	 */
> >> +	fgp_flags = FGP_WRITEBEGIN;
> >> +	if (*foliop == foliop_uncached)
> >> +		fgp_flags |= FGP_UNCACHED;
> >> +
> >>  	/*
> >>  	 * __filemap_get_folio() can take a long time if the
> >>  	 * system is thrashing due to memory pressure, or if the folio
> >> @@ -1172,7 +1182,7 @@ static int ext4_write_begin(struct file *file, struct address_space *mapping,
> >>  	 * the folio (if needed) without using GFP_NOFS.
> >>  	 */
> >>  retry_grab:
> >> -	folio = __filemap_get_folio(mapping, index, FGP_WRITEBEGIN,
> >> +	folio = __filemap_get_folio(mapping, index, fgp_flags,
> >>  					mapping_gfp_mask(mapping));
> >>  	if (IS_ERR(folio))
> >>  		return PTR_ERR(folio);
> > 
> > JFYI, I notice that ext4 cycles the folio lock here in this path and
> > thus follows up with a couple checks presumably to accommodate that. One
> > is whether i_mapping has changed, which I assume means uncached state
> > would have been handled/cleared externally somewhere..? I.e., if an
> > uncached folio is somehow truncated/freed without ever having been
> > written back?
> > 
> > The next is a folio_wait_stable() call "in case writeback began ..."
> > It's not immediately clear to me if that is possible here, but taking
> > that at face value, is it an issue if we were to create an uncached
> > folio, drop the folio lock, then have some other task dirty and
> > writeback the folio (due to a sync write or something), then have
> > writeback completion invalidate the folio before we relock it here?
> 
> I don't either of those are an issue. The UNCACHED flag will only be set
> on a newly created folio, it does not get inherited for folios that
> already exist.
> 

Right.. but what I was wondering for that latter case is if the folio is
created here by ext4, so uncached is set before it is unlocked.

On second look I guess the uncached completion invalidation should clear
mapping and thus trigger the retry logic here. That seems reasonable
enough, but is it still possible to race with writeback?

Maybe this is a better way to ask.. what happens if a write completes to
an uncached folio that is already under writeback? For example, uncached
write 1 completes, submits for writeback and returns to userspace. Then
write 2 begins and redirties the same folio before the uncached
writeback completes.

If I follow correctly, if write 2 is also uncached, it eventually blocks
in writeback submission (folio_prepare_writeback() ->
folio_wait_writeback()). It looks like folio lock is held there, so
presumably that would bypass the completion time invalidation in
folio_end_uncached(). But what if write 2 was not uncached or perhaps
writeback completion won the race for folio lock vs. the write side
(between locking the folio for dirtying and later for writeback
submission)? Does anything prevent invalidation of the folio before the
second write is submitted for writeback?

IOW, I'm wondering if the uncached completion time invalidation also
needs a folio dirty check..?

Brian

> -- 
> Jens Axboe
> 


