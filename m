Return-Path: <linux-fsdevel+bounces-79835-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SDUmJfMPr2kYNQIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79835-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 09 Mar 2026 19:22:43 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1165123E8DF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 09 Mar 2026 19:22:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8D46630460B9
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Mar 2026 18:20:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F0B93446C6;
	Mon,  9 Mar 2026 18:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DUSxA+vh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36D0C285CB9
	for <linux-fsdevel@vger.kernel.org>; Mon,  9 Mar 2026 18:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773080406; cv=none; b=auAd5W5FPuLM2w/6TKIjf7XPiLzTWv4ioYwYUsJSPhfuxUM0pIX1L3M0/b02yWdAOWXdt2F3hLWEWwWvCPy1vqTYzprDZMkaqJ/OnXjqKvc6CEdTGGdC7bolf57EJeaojRBqO5jmS2y/Lgc3oO73d9UMtYZbqZqdnTTtkzYSgoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773080406; c=relaxed/simple;
	bh=+JJOLs9qDerDYPbV35nsBiqMzvxV3WL/fRreZlLie9Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BhGeOSslTaitPYFq2lFOJCHTO2Em1t9zfn2OiX7bOX0nKIm+5apt+tJgcra0ua0+Qqy8hvTk4fkvwXOyEPzhfJ4RkXCDrkBCk/dupD3JswdPDEx5f5lc1vTL9qg7pr/Q/U7wLrdVCTnECtLS68t79CmhckIqgbwho+qO3PrwZ5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DUSxA+vh; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773080403;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vEtSB45HNaMQ7Rq91VFvQwtwPNvWDyIYF9OE8dJ20Zg=;
	b=DUSxA+vhv6y27nPioidMVk4iVwiSgK++VdN1a7kivj/nKyXs8/5sGSJCXOg8jW4QUVCM/M
	mzEYtUazVwdpLLFKOIS7dSqk0uvNMgPgevjICKBK9gY7kES3vk9O8OMbQgTf0d7gB/WYfg
	jDixq/oJdeoHp94uEWWGZ9DHv5HPLWg=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-654-I9un7U6XNq-fYltKRpUQNA-1; Mon,
 09 Mar 2026 14:20:01 -0400
X-MC-Unique: I9un7U6XNq-fYltKRpUQNA-1
X-Mimecast-MFC-AGG-ID: I9un7U6XNq-fYltKRpUQNA_1773080401
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D31DC19560B7;
	Mon,  9 Mar 2026 18:20:00 +0000 (UTC)
Received: from bfoster (unknown [10.22.89.107])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3625919560A6;
	Mon,  9 Mar 2026 18:20:00 +0000 (UTC)
Date: Mon, 9 Mar 2026 14:19:58 -0400
From: Brian Foster <bfoster@redhat.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH v3 2/8] xfs: flush dirty pagecache over hole in zoned
 mode zero range
Message-ID: <aa8PTqrFVCllBD0a@bfoster>
References: <20260309134506.167663-1-bfoster@redhat.com>
 <20260309134506.167663-3-bfoster@redhat.com>
 <20260309172219.GM6033@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260309172219.GM6033@frogsfrogsfrogs>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Rspamd-Queue-Id: 1165123E8DF
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-79835-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
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

On Mon, Mar 09, 2026 at 10:22:19AM -0700, Darrick J. Wong wrote:
> On Mon, Mar 09, 2026 at 09:45:00AM -0400, Brian Foster wrote:
> > For zoned filesystems a window exists between the first write to a
> > sparse range (i.e. data fork hole) and writeback completion where we
> > might spuriously observe holes in both the COW and data forks. This
> > occurs because a buffered write populates the COW fork with
> > delalloc, writeback submission removes the COW fork delalloc blocks
> > and unlocks the inode, and then writeback completion remaps the
> > physically allocated blocks into the data fork. If a zero range
> > operation does a lookup during this window where both forks show a
> > hole, it incorrectly reports a hole mapping for a range that
> > contains data.
> > 
> > This currently works because iomap checks for dirty pagecache over
> > holes and unwritten mappings. If found, it flushes and retries the
> > lookup. We plan to remove the hole flush logic from iomap, however,
> > so lift the flush into xfs_zoned_buffered_write_iomap_begin() to
> > preserve behavior and document the purpose for it. Zoned XFS
> > filesystems don't support unwritten extents, so if zoned mode can
> > come up with a way to close this transient hole window in the
> > future, this flush can likely be removed.
> 
> Why does the mapping disappear out of both data and cow forks between
> writeback setup and completion?  IIRC it is because the writeback ioend
> effectively owns the unwritten mapping.  We want another writer thread
> to see the hole and reserve its own out-of-place write because the write
> mapping that writeback's working on is immutable once the disk actually
> writes it.  Right?
> 

Not sure.. seems plausible, but probably a question for Christoph.

> I wonder if we could stash a delalloc mapping in the cow fork with zero
> indlen during writeback to signal "get a real zoned space reservation"?
> 

I was thinking something like transferring the delalloc to the data fork
when the latter has a hole just to signify that there is data in the
pipeline, but not something to solve for this series anyways..

> > Signed-off-by: Brian Foster <bfoster@redhat.com>
> > ---
> >  fs/xfs/xfs_iomap.c | 19 +++++++++++++++++++
> >  1 file changed, 19 insertions(+)
> > 
> > diff --git a/fs/xfs/xfs_iomap.c b/fs/xfs/xfs_iomap.c
> > index 8c3469d2c73e..0e323e4e304b 100644
> > --- a/fs/xfs/xfs_iomap.c
> > +++ b/fs/xfs/xfs_iomap.c
> > @@ -1590,6 +1590,7 @@ xfs_zoned_buffered_write_iomap_begin(
> >  {
> >  	struct iomap_iter	*iter =
> >  		container_of(iomap, struct iomap_iter, iomap);
> > +	struct address_space	*mapping = inode->i_mapping;
> >  	struct xfs_zone_alloc_ctx *ac = iter->private;
> >  	struct xfs_inode	*ip = XFS_I(inode);
> >  	struct xfs_mount	*mp = ip->i_mount;
> > @@ -1614,6 +1615,7 @@ xfs_zoned_buffered_write_iomap_begin(
> >  	if (error)
> >  		return error;
> >  
> > +restart:
> >  	error = xfs_ilock_for_iomap(ip, flags, &lockmode);
> >  	if (error)
> >  		return error;
> > @@ -1686,8 +1688,25 @@ xfs_zoned_buffered_write_iomap_begin(
> >  	 * When zeroing, don't allocate blocks for holes as they are already
> >  	 * zeroes, but we need to ensure that no extents exist in both the data
> >  	 * and COW fork to ensure this really is a hole.
> > +	 *
> > +	 * A window exists where we might observe a hole in both forks with
> > +	 * valid data in cache. Writeback removes the COW fork blocks on
> > +	 * submission but doesn't remap into the data fork until completion. If
> > +	 * the data fork was previously a hole, we'll fail to zero. Until we
> > +	 * find a way to avoid this transient state, check for dirty pagecache
> > +	 * and flush to wait on blocks to land in the data fork.
> >  	 */
> >  	if ((flags & IOMAP_ZERO) && srcmap->type == IOMAP_HOLE) {
> > +		if (filemap_range_needs_writeback(mapping, offset,
> > +						  offset + count - 1)) {
> > +			xfs_iunlock(ip, lockmode);
> > +			error = filemap_write_and_wait_range(mapping, offset,
> > +							    offset + count - 1);
> 
> Two tab indents, please.
> 

Sure.

Brian

> --D
> 
> > +			if (error)
> > +				return error;
> > +			goto restart;
> > +		}
> > +
> >  		xfs_hole_to_iomap(ip, iomap, offset_fsb, end_fsb);
> >  		goto out_unlock;
> >  	}
> > -- 
> > 2.52.0
> > 
> > 
> 


