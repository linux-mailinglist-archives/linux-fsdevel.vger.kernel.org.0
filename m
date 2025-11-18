Return-Path: <linux-fsdevel+bounces-69017-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 96A22C6B875
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Nov 2025 21:09:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2BF6B4E7008
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Nov 2025 20:08:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16BE42F5A06;
	Tue, 18 Nov 2025 20:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TYuePBAR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC2CD2DCBF8
	for <linux-fsdevel@vger.kernel.org>; Tue, 18 Nov 2025 20:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763496526; cv=none; b=e6UJd7eu+JVFQVGD13HEw3m5oU6y8akMGRnP//8Dde4FxtZm3Po0Z+vsJtCCSx04t6Gc+DIC31ULgaMsl9DPz2e6a14rAa7zs4r2p2cuPgaQVQFPTeFvPLRONv23OP+dAFwkXi2PizvCe5f94Kg/VqcfxXtSNAJxLrdDo0o67Hg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763496526; c=relaxed/simple;
	bh=zKyz003uJALUvMNRCDsF88+LaqoAo6S0DQMxbylWp5M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FXkk3SR7XG2H3AbO/r0RYzgAf+w9mLmmbFnEyBv/5nYlF7ELDIEf1jMotpqlVMMTa1bNtKDie8mLa2E06Q9TBVTodmdoIyOh8kE6w3jRBUeQfE1UmxTHflkKOEzKpKkUqopm85wDrRzrikl46ktgyPnaZfE2tZDfT/ysD/QGf0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TYuePBAR; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763496523;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ab7N6fkP8RMKQvUh/0BuymZtJzOzx//JiTSo7GZWmts=;
	b=TYuePBARxcaT+3SDwErG+2Hr5yAdElS0BZz6obdPRf//2zno5G4/dH1ofMWK03yBdQprH3
	5sfQWep54JviXYbh9NviQLyGv7CiGWgtJlsdrv/B9LHYaz6ce7yUVn4QHst4/CeH17c/f+
	LLmnjLZDEs8TZhoIIHSOZH0ybkiQl5o=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-549-YbsAIlmUP_62PIzFvXvlfw-1; Tue,
 18 Nov 2025 15:08:39 -0500
X-MC-Unique: YbsAIlmUP_62PIzFvXvlfw-1
X-Mimecast-MFC-AGG-ID: YbsAIlmUP_62PIzFvXvlfw_1763496518
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C3B471800650;
	Tue, 18 Nov 2025 20:08:38 +0000 (UTC)
Received: from bfoster (unknown [10.22.64.29])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 076D9180047F;
	Tue, 18 Nov 2025 20:08:37 +0000 (UTC)
Date: Tue, 18 Nov 2025 15:08:35 -0500
From: Brian Foster <bfoster@redhat.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH 3/6] xfs: flush eof folio before insert range size update
Message-ID: <aRzSQypQIad3TsBT@bfoster>
References: <20251016190303.53881-1-bfoster@redhat.com>
 <20251016190303.53881-4-bfoster@redhat.com>
 <20251105001445.GW196370@frogsfrogsfrogs>
 <aQtughoBHt6LRTUx@bfoster>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aQtughoBHt6LRTUx@bfoster>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On Wed, Nov 05, 2025 at 10:34:26AM -0500, Brian Foster wrote:
> On Tue, Nov 04, 2025 at 04:14:45PM -0800, Darrick J. Wong wrote:
> > On Thu, Oct 16, 2025 at 03:03:00PM -0400, Brian Foster wrote:
> > > The flush in xfs_buffered_write_iomap_begin() for zero range over a
> > > data fork hole fronted by COW fork prealloc is primarily designed to
> > > provide correct zeroing behavior in particular pagecache conditions.
> > > As it turns out, this also partially masks some odd behavior in
> > > insert range (via zero range via setattr).
> > > 
> > > Insert range bumps i_size the length of the new range, flushes,
> > > unmaps pagecache and cancels COW prealloc, and then right shifts
> > > extents from the end of the file back to the target offset of the
> > > insert. Since the i_size update occurs before the pagecache flush,
> > > this creates a transient situation where writeback around EOF can
> > > behave differently.
> > 
> > Why not flush the file from @offset to EOF, flush the COW
> > preallocations, extend i_size, and only then start shifting extents?
> > That would seem a lot more straightforward to me.
> > 
> 
> I agree. I noted in the cover letter that I started with this approach
> of reordering the existing sequence of operations, but the factoring
> looked ugly enough that I stopped and wanted to solicit input.
> 

Well this is annoying.. I looked into lifting the prepare shift bits a
level up and just invoking it before the truncate, but that actually
appears to be incorrect in at least one case. I.e., the truncate up for
insert range invokes zero eof for partial zeroing of the eof block,
which brings a folio back into pagecache (after the lifted flush/unmap)
within the range being shfited. This then creates a post-shift cache
inconsistency. This is resolved by restoring the flush/unmap between the
truncate and extent shift, so we end up just having it in both places.

So atm I'm not really sure if there's a better option than what this
patch is doing. There are probably other ways to implement it, like
perhaps introducing ability to convert blocks that are shifted out from
eof, but that just seems like unnecessary complexity for basically
implementing the same sort of thing.

I dunno.. insert range is odd in this regard. I'll think a bit more
about it while I look into the zero range cow mapping reporting thing.

Brian

> The details of that fell out of my brain since I posted this,
> unfortunately. I suspect it may have been related to layering or
> something wrt the prepare_shift factoring, but I'll take another look in
> that direction for v2 and once I've got some feedback on the rest of the
> series.. Thanks.
> 
> Brian
> 
> > --D
> > 
> > > This appears to be corner case situation, but if happens to be
> > > fronted by COW fork speculative preallocation and a large, dirty
> > > folio that contains at least one full COW block beyond EOF, the
> > > writeback after i_size is bumped may remap that COW fork block into
> > > the data fork within EOF. The block is zeroed and then shifted back
> > > out to post-eof, but this is unexpected in that it leads to a
> > > written post-eof data fork block. This can cause a zero range
> > > warning on a subsequent size extension, because we should never find
> > > blocks that require physical zeroing beyond i_size.
> > > 
> > > To avoid this quirk, flush the EOF folio before the i_size update
> > > during insert range. The entire range will be flushed, unmapped and
> > > invalidated anyways, so this should be relatively unnoticeable.
> > > 
> > > Signed-off-by: Brian Foster <bfoster@redhat.com>
> > > ---
> > >  fs/xfs/xfs_file.c | 17 +++++++++++++++++
> > >  1 file changed, 17 insertions(+)
> > > 
> > > diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
> > > index 5b9864c8582e..cc3a9674ad40 100644
> > > --- a/fs/xfs/xfs_file.c
> > > +++ b/fs/xfs/xfs_file.c
> > > @@ -1226,6 +1226,23 @@ xfs_falloc_insert_range(
> > >  	if (offset >= isize)
> > >  		return -EINVAL;
> > >  
> > > +	/*
> > > +	 * Let writeback clean up EOF folio state before we bump i_size. The
> > > +	 * insert flushes before it starts shifting and under certain
> > > +	 * circumstances we can write back blocks that should technically be
> > > +	 * considered post-eof (and thus should not be submitted for writeback).
> > > +	 *
> > > +	 * For example, a large, dirty folio that spans EOF and is backed by
> > > +	 * post-eof COW fork preallocation can cause block remap into the data
> > > +	 * fork. This shifts back out beyond EOF, but creates an expectedly
> > > +	 * written post-eof block. The insert is going to flush, unmap and
> > > +	 * cancel prealloc across this whole range, so flush EOF now before we
> > > +	 * bump i_size to provide consistent behavior.
> > > +	 */
> > > +	error = filemap_write_and_wait_range(inode->i_mapping, isize, isize);
> > > +	if (error)
> > > +		return error;
> > > +
> > >  	error = xfs_falloc_setsize(file, isize + len);
> > >  	if (error)
> > >  		return error;
> > > -- 
> > > 2.51.0
> > > 
> > > 
> > 
> 
> 


