Return-Path: <linux-fsdevel+bounces-79836-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4JhSIGMQr2ldNQIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79836-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 09 Mar 2026 19:24:35 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E0DB23E951
	for <lists+linux-fsdevel@lfdr.de>; Mon, 09 Mar 2026 19:24:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 132E03006B14
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Mar 2026 18:24:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D132C346AE6;
	Mon,  9 Mar 2026 18:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RENwPfRt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ACAD3451CC
	for <linux-fsdevel@vger.kernel.org>; Mon,  9 Mar 2026 18:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773080667; cv=none; b=Oh/anJ8a8l03m/I9JQJs4nrps68LJc6xrcBgLkkE+SVx5n69tPvaH27U4CQA1iLGk0TMZY/vzvJui/3a/IhsvtuNyBqlbAcRpb7Li2DXPAs5oX18Xqa4lnLbROH1IF5pLWDVJmJpbYWIKaI9ogEHVjh17afhSTUBdGgBt/fcTIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773080667; c=relaxed/simple;
	bh=xnu21/y+wnWI6Vzrd8qhlQimPX6M7haSSuOHliK/Ge0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l4ywHod6uncX7CCGt1Kh5WSJKdKfWexEJ4bLG4tGHqZc3SI4w5FwvUl43jmzKRFSz9n3SdWk/QWGVbOfBywmF7EF3Sq0ST8OthzxYGO3ex1T7E1y5qY906g7i3yzZvuRcUKP7fGNK5XWt+ZjYyFQcoqJI8vx2OlejZlRNW10zPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RENwPfRt; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773080665;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KFISL9bUzoidWGCQ+ldMd4uJkYcHOf+3LRR1B4Y7X1Q=;
	b=RENwPfRtL5A6VaetduWnwG1uTLR8T86hANnmnyWlac8IWQdSTRdj7nzA+HfQWj8C+bt2FS
	bra54Dl70bSXG/IcyKbugNldfk4F88jwKr9gRDk2BBNZX47LkaT+CTXrbNS/GKHjBE3XIx
	CHprKVxaZqm7a32qc9nj9AFMVpI/KXQ=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-237-8mAkCaggOuitINS_Wf1OBw-1; Mon,
 09 Mar 2026 14:24:22 -0400
X-MC-Unique: 8mAkCaggOuitINS_Wf1OBw-1
X-Mimecast-MFC-AGG-ID: 8mAkCaggOuitINS_Wf1OBw_1773080661
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 141DD1956095;
	Mon,  9 Mar 2026 18:24:21 +0000 (UTC)
Received: from bfoster (unknown [10.22.89.107])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6CA8A30001A2;
	Mon,  9 Mar 2026 18:24:20 +0000 (UTC)
Date: Mon, 9 Mar 2026 14:24:18 -0400
From: Brian Foster <bfoster@redhat.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH v3 4/8] xfs: flush eof folio before insert range size
 update
Message-ID: <aa8QUlEHNu0C01zF@bfoster>
References: <20260309134506.167663-1-bfoster@redhat.com>
 <20260309134506.167663-5-bfoster@redhat.com>
 <20260309173213.GN6033@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260309173213.GN6033@frogsfrogsfrogs>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Rspamd-Queue-Id: 1E0DB23E951
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-79836-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bfoster@redhat.com,linux-fsdevel@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	NEURAL_HAM(-0.00)[-0.990];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Mon, Mar 09, 2026 at 10:32:13AM -0700, Darrick J. Wong wrote:
> On Mon, Mar 09, 2026 at 09:45:02AM -0400, Brian Foster wrote:
> > The flush in xfs_buffered_write_iomap_begin() for zero range over a
> > data fork hole fronted by COW fork prealloc is primarily designed to
> > provide correct zeroing behavior in particular pagecache conditions.
> > As it turns out, this also partially masks some odd behavior in
> > insert range (via zero range via setattr).
> > 
> > Insert range bumps i_size the length of the new range, flushes,
> > unmaps pagecache and cancels COW prealloc, and then right shifts
> > extents from the end of the file back to the target offset of the
> > insert. Since the i_size update occurs before the pagecache flush,
> > this creates a transient situation where writeback around EOF can
> > behave differently.
> > 
> > This appears to be corner case situation, but if happens to be
> > fronted by COW fork speculative preallocation and a large, dirty
> > folio that contains at least one full COW block beyond EOF, the
> 
> How do we get a large dirty folio with at least one full cow block
> beyond i_size?  If we did a pagecache write to the file, then at least
> the incore isize should have been boosted out far enough that the block
> will now be inside EOF, right?
> 

It's been quite some time since I first reproduced and diagnosed this so
I'm going from memory, but IIRC it was some odd case like a failure to
split a large folio fully within EOF on a truncate down across it due to
being dirty. I originally thought the large folio thing was actually the
issue, but I don't recall seeing anything that prevents it in this
particular situation. So my understanding from that is that it's more
unexpected in that we wouldn't create a large folio directly in this
situation, but it's still technically possible through oddball fsx
sequences.

From there, we can run into the insert situation described above where
the i_size update -> flush -> extent shift behavior creates a transient
situation where a post-eof block is temporarily within eof.

Brian

> --D
> 
> > writeback after i_size is bumped may remap that COW fork block into
> > the data fork within EOF. The block is zeroed and then shifted back
> > out to post-eof, but this is unexpected in that it leads to a
> > written post-eof data fork block. This can cause a zero range
> > warning on a subsequent size extension, because we should never find
> > blocks that require physical zeroing beyond i_size.
> > 
> > To avoid this quirk, flush the EOF folio before the i_size update
> > during insert range. The entire range will be flushed, unmapped and
> > invalidated anyways, so this should be relatively unnoticeable.
> > 
> > Signed-off-by: Brian Foster <bfoster@redhat.com>
> > Reviewed-by: Christoph Hellwig <hch@lst.de>
> > ---
> >  fs/xfs/xfs_file.c | 17 +++++++++++++++++
> >  1 file changed, 17 insertions(+)
> > 
> > diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
> > index 6246f34df9fd..48d812b99282 100644
> > --- a/fs/xfs/xfs_file.c
> > +++ b/fs/xfs/xfs_file.c
> > @@ -1263,6 +1263,23 @@ xfs_falloc_insert_range(
> >  	if (offset >= isize)
> >  		return -EINVAL;
> >  
> > +	/*
> > +	 * Let writeback clean up EOF folio state before we bump i_size. The
> > +	 * insert flushes before it starts shifting and under certain
> > +	 * circumstances we can write back blocks that should technically be
> > +	 * considered post-eof (and thus should not be submitted for writeback).
> > +	 *
> > +	 * For example, a large, dirty folio that spans EOF and is backed by
> > +	 * post-eof COW fork preallocation can cause block remap into the data
> > +	 * fork. This shifts back out beyond EOF, but creates an expectedly
> > +	 * written post-eof block. The insert is going to flush, unmap and
> > +	 * cancel prealloc across this whole range, so flush EOF now before we
> > +	 * bump i_size to provide consistent behavior.
> > +	 */
> > +	error = filemap_write_and_wait_range(inode->i_mapping, isize, isize);
> > +	if (error)
> > +		return error;
> > +
> >  	error = xfs_falloc_setsize(file, isize + len);
> >  	if (error)
> >  		return error;
> > -- 
> > 2.52.0
> > 
> > 
> 


