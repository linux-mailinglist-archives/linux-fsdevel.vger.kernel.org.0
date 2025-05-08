Return-Path: <linux-fsdevel+bounces-48496-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 53BBDAB007D
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 May 2025 18:31:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 789771887BC0
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 May 2025 16:31:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9453327CCCD;
	Thu,  8 May 2025 16:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b27HKyT+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23566433AC
	for <linux-fsdevel@vger.kernel.org>; Thu,  8 May 2025 16:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746721893; cv=none; b=lfOADzuHXeKKekMHkJ/tMcz9nyke9Z9YyFTETZli44VwmmqW2ReK6BVO3JlT1xfqLDj02sPET7zM6Hxw+saRYJTdbDET68z9Wt/gF1XC/kzGm6/83kF3jNkm1z1DU83oN8ZKfFvnseN445mBKIgTYDOzTOS+u7uVKoMlMswWF1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746721893; c=relaxed/simple;
	bh=mE+TFb3GgFFhrv+q72jvlgVS2qFGVqcE2YDTcRO0OT0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eFQZ5lvKaJT23NGQhay7BnBJSZuIqzWASsk9bj6HHKuqULfgytb7ZTIsnjkgVFeJ800rMn7/kEi0y6pH1M00UJIFnod/2dB6nVtoXYknh2gEFevWzfyEQixLtf/0Ryp/+gJxHtgGjd3tbw/txSsB/ZuXyKROFWyJVtmHQm9iNuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=b27HKyT+; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1746721890;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+VyOYkIT9tUSuqOdQpRnvRgM8zWBnKO/rxdW9pVuubs=;
	b=b27HKyT+dhmFlqRuT9iLthSaNp9BzTCzrWp8vBMGPk89MjE1kngSsiJ9CnSBIdz6PRJ+0X
	iHcLL4eoNY1m+kwrYTGf9+jx4D5TqLSbXj0ktFgcQyBo/q9y0SVSuVnbIaPFWZh0+YjG/o
	SjMpjR3FrwYwbx5D1ONkk8cL5IkYPBA=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-617-9XgkZUHzPqiBOQ30oUmzPA-1; Thu,
 08 May 2025 12:31:26 -0400
X-MC-Unique: 9XgkZUHzPqiBOQ30oUmzPA-1
X-Mimecast-MFC-AGG-ID: 9XgkZUHzPqiBOQ30oUmzPA_1746721885
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 72B7A1800876;
	Thu,  8 May 2025 16:31:25 +0000 (UTC)
Received: from bfoster (unknown [10.22.64.112])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C20A71956055;
	Thu,  8 May 2025 16:31:22 +0000 (UTC)
Date: Thu, 8 May 2025 12:34:33 -0400
From: Brian Foster <bfoster@redhat.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Andreas Gruenbacher <agruenba@redhat.com>,
	Christian Brauner <brauner@kernel.org>,
	Christoph Hellwig <hch@infradead.org>,
	Matthew Wilcox <willy@infradead.org>, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, gfs2@lists.linux.dev
Subject: Re: [RFC] gfs2: Do not call iomap_zero_range beyond eof
Message-ID: <aBzdGfHZmx-9j8xi@bfoster>
References: <20250508133427.3799322-1-agruenba@redhat.com>
 <aBzABse9b6vF_LTv@bfoster>
 <20250508150446.GB2701446@frogsfrogsfrogs>
 <aBzLib4tHj351di2@bfoster>
 <20250508160422.GN1035866@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250508160422.GN1035866@frogsfrogsfrogs>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On Thu, May 08, 2025 at 09:04:22AM -0700, Darrick J. Wong wrote:
> On Thu, May 08, 2025 at 11:19:37AM -0400, Brian Foster wrote:
> > On Thu, May 08, 2025 at 08:04:46AM -0700, Darrick J. Wong wrote:
> > > On Thu, May 08, 2025 at 10:30:30AM -0400, Brian Foster wrote:
> > > > On Thu, May 08, 2025 at 03:34:27PM +0200, Andreas Gruenbacher wrote:
> > > > > Since commit eb65540aa9fc ("iomap: warn on zero range of a post-eof
> > > > > folio"), iomap_zero_range() warns when asked to zero a folio beyond eof.
> > > > > The warning triggers on the following code path:
> > > 
> > > Which warning?  This one?
> > > 
> > > 	/* warn about zeroing folios beyond eof that won't write back */
> > > 	WARN_ON_ONCE(folio_pos(folio) > iter->inode->i_size);
> > > 
> > > If so, then why are there folios that start entirely beyond EOF?
> > > 
> > 
> > Yeah.. this gfs2 instance is simply a case of their punch hole mechanism
> > does unconditional partial folio zeroing via iomap zero range, so if a
> > punch hole occurs on some unaligned range of post-eof blocks, it will
> > basically create and perform zeroing of post-eof folios. IIUC the caveat
> > here is that these blocks are all zeroed on alloc (unwritten extents are
> > apparently not a thing in gfs2), so the punch time zeroing and warning
> > are spurious. Andreas can correct me if I have any of that wrong.
> 
> Oh, right, because iomap_zero_iter calls iomap_write_begin, which
> allocates a new folio completely beyond EOF, and then we see that new
> folio and WARN about it before scribbling on the folio and dirtying it.
> Correct?
> 
> If so then yeah, it doesn't seem useful to do that... unless the file
> size immediately gets extended such that at least one byte of the dirty
> folio is within EOF.  Even then, that seems like a stretch...
> 

Yep, agreed. An i_size update after a zero op would come after locks are
dropped and whatnot as well, so seems racy and wrong.

> > > > > 
> > > > >   gfs2_fallocate(FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE)
> > > > >     __gfs2_punch_hole()
> > > > >       gfs2_block_zero_range()
> > > > >         iomap_zero_range()
> > > > > 
> > > > > So far, gfs2 is just zeroing out partial pages at the beginning and end
> > > > > of the range, whether beyond eof or not.  The data beyond eof is already
> > > > > expected to be all zeroes, though.  Truncate the range passed to
> > > > > iomap_zero_range().
> > > > > 
> > > > > As an alternative approach, we could also implicitly truncate the range
> > > > > inside iomap_zero_range() instead of issuing a warning.  Any thoughts?
> > > > > 
> > > > 
> > > > Thanks Andreas. The more I think about this the more it seems like
> > > > lifting this logic into iomap is a reasonable compromise between just
> > > > dropping the warning and forcing individual filesystems to work around
> > > > it. The original intent of the warning was to have something to catch
> > > > subtle bad behavior since zero range did update i_size for so long.
> > > > 
> > > > OTOH I think it's reasonable to argue that we shouldn't need to warn in
> > > > situations where we could just enforce correct behavior. Also, I believe
> > > > we introduced something similar to avoid post-eof weirdness wrt unshare
> > > > range [1], so precedent exists.
> > > > 
> > > > I'm interested if others have opinions on the iomap side.. (though as I
> > > > write this it looks like hch sits on the side of not tweaking iomap).
> > > 
> > > IIRC XFS calls iomap_zero_range during file extending operations to zero
> > > the tail of a folio that spans EOF, so you'd have to allow for that too.
> > > 
> > 
> > Yeah, good point. Perhaps we'd want to bail on a folio that starts
> > beyond EOF with this approach, similar to the warning logic.
> 
> ...because I don't see much use in zeroing and dirtying a folio that
> starts well beyond EOF since iomap_writepage_handle_eof will ignore it
> and there are several gigantic comments in buffered-io.c about clamping
> to EOF.
> 
> <shrug> But maybe I'm missing a usecase?
> 

Not that I'm aware of.

Brian

> --D
> 
> > Brian
> > 
> > > --D
> > > 
> > > > Brian
> > > > 
> > > > [1] a311a08a4237 ("iomap: constrain the file range passed to iomap_file_unshare")
> > > > 
> > > > > Thanks,
> > > > > Andreas
> > > > > 
> > > > > --
> > > > > 
> > > > > Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
> > > > > 
> > > > > diff --git a/fs/gfs2/bmap.c b/fs/gfs2/bmap.c
> > > > > index b81984def58e..d9a4309cd414 100644
> > > > > --- a/fs/gfs2/bmap.c
> > > > > +++ b/fs/gfs2/bmap.c
> > > > > @@ -1301,6 +1301,10 @@ static int gfs2_block_zero_range(struct inode *inode, loff_t from,
> > > > >  				 unsigned int length)
> > > > >  {
> > > > >  	BUG_ON(current->journal_info);
> > > > > +	if (from > inode->i_size)
> > > > > +		return 0;
> > > > > +	if (from + length > inode->i_size)
> > > > > +		length = inode->i_size - from;
> > > > >  	return iomap_zero_range(inode, from, length, NULL, &gfs2_iomap_ops,
> > > > >  			NULL);
> > > > >  }
> > > > > 
> > > > 
> > > > 
> > > 
> > 
> > 
> 


