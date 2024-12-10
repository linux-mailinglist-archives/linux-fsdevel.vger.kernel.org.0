Return-Path: <linux-fsdevel+bounces-36922-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EC4429EB02B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Dec 2024 12:49:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4FAAE1638EB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Dec 2024 11:49:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8893219E7F9;
	Tue, 10 Dec 2024 11:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GrwdbTu4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BE6F18A6B2
	for <linux-fsdevel@vger.kernel.org>; Tue, 10 Dec 2024 11:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733831348; cv=none; b=tV9/viDxX8tFEn1LB5MAw9Ix28prbYIXGqrOSnTAIfb3InoLp1NA/4lYcvXPx0LtFqwRNE5+nd2fKNqmAwH+xj4QNg4vLSmDxC4OLOYXTeYPoTxu1HA4lN7MSf5nDpC/3FOQYW+lgcWo+7l7EgFYmeqdTuvHtTmAQjyqD54ltz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733831348; c=relaxed/simple;
	bh=it7Kb8/3e71wms3hdTMrUR7YFydDTanJxBm0Bp0Gk0s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qfORx4CuBDW6hPFMdghiYXxcl8aijDeKkVuNx7+0MQvwH6le7f1V0uvscZOi2/glJ5qGew40jVDFu73kFFAJpqG6XVtu6iOOcJWTLGjCtHgDdMSVEF37l64Ta+M9DU8TeTGDsNNllJWupfrQ6uID9KdknzGLCK923luDq3tfKhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GrwdbTu4; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733831345;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=D0ldJZ6083Vw6xYSsT2EyjEH+lYnhvuO2bSh6ydVWUM=;
	b=GrwdbTu4DGgi7fxrcGf9MnlghsjkHapUVjb+XVxVXjWcFIAKaID6tQxjn9M0oCrt+Bvw9H
	rCEr3haagMO4aFTJv7GhQZMqAchPs5DcwUH6PphmxNoF6grEVuupkCRcgNA3jq3GAxlYj+
	xs3OzHtq3U9wkL5Mm/IyCi8VAiHIFU0=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-179-ldDMLe2ANuOIK6M9eIzBTQ-1; Tue,
 10 Dec 2024 06:49:01 -0500
X-MC-Unique: ldDMLe2ANuOIK6M9eIzBTQ-1
X-Mimecast-MFC-AGG-ID: ldDMLe2ANuOIK6M9eIzBTQ
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2BA3519560B9;
	Tue, 10 Dec 2024 11:49:00 +0000 (UTC)
Received: from bfoster (unknown [10.22.90.12])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D31401956089;
	Tue, 10 Dec 2024 11:48:57 +0000 (UTC)
Date: Tue, 10 Dec 2024 06:50:43 -0500
From: Brian Foster <bfoster@redhat.com>
To: Long Li <leo.lilong@huawei.com>
Cc: brauner@kernel.org, djwong@kernel.org, cem@kernel.org,
	linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	yi.zhang@huawei.com, houtao1@huawei.com, yangerkun@huawei.com
Subject: Re: [PATCH v6 1/3] iomap: pass byte granular end position to
 iomap_add_to_ioend
Message-ID: <Z1grE4YXO6kM5ylF@bfoster>
References: <20241209114241.3725722-1-leo.lilong@huawei.com>
 <20241209114241.3725722-2-leo.lilong@huawei.com>
 <Z1b5Vr96Aysa_JCG@bfoster>
 <Z1f3NvI6j0tuIU7a@localhost.localdomain>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z1f3NvI6j0tuIU7a@localhost.localdomain>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

On Tue, Dec 10, 2024 at 04:09:26PM +0800, Long Li wrote:
> On Mon, Dec 09, 2024 at 09:06:14AM -0500, Brian Foster wrote:
> > On Mon, Dec 09, 2024 at 07:42:39PM +0800, Long Li wrote:
> > > This is a preparatory patch for fixing zero padding issues in concurrent
> > > append write scenarios. In the following patches, we need to obtain
> > > byte-granular writeback end position for io_size trimming after EOF
> > > handling.
> > > 
> > > Due to concurrent writeback and truncate operations, inode size may
> > > shrink. Resampling inode size would force writeback code to handle the
> > > newly appeared post-EOF blocks, which is undesirable. As Dave
> > > explained in [1]:
> > > 
> > > "Really, the issue is that writeback mappings have to be able to
> > > handle the range being mapped suddenly appear to be beyond EOF.
> > > This behaviour is a longstanding writeback constraint, and is what
> > > iomap_writepage_handle_eof() is attempting to handle.
> > > 
> > > We handle this by only sampling i_size_read() whilst we have the
> > > folio locked and can determine the action we should take with that
> > > folio (i.e. nothing, partial zeroing, or skip altogether). Once
> > > we've made the decision that the folio is within EOF and taken
> > > action on it (i.e. moved the folio to writeback state), we cannot
> > > then resample the inode size because a truncate may have started
> > > and changed the inode size."
> > > 
> > > To avoid resampling inode size after EOF handling, we convert end_pos
> > > to byte-granular writeback position and return it from EOF handling
> > > function.
> > > 
> > > Since iomap_set_range_dirty() can handle unaligned lengths, this
> > > conversion has no impact on it. However, iomap_find_dirty_range()
> > > requires aligned start and end range to find dirty blocks within the
> > > given range, so the end position needs to be rounded up when passed
> > > to it.
> > > 
> > > LINK [1]: https://lore.kernel.org/linux-xfs/Z1Gg0pAa54MoeYME@localhost.localdomain/
> > > Signed-off-by: Long Li <leo.lilong@huawei.com>
> > > ---
> > >  fs/iomap/buffered-io.c | 21 ++++++++++++---------
> > >  1 file changed, 12 insertions(+), 9 deletions(-)
> > > 
> > > diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> > > index 955f19e27e47..bcc7831d03af 100644
> > > --- a/fs/iomap/buffered-io.c
> > > +++ b/fs/iomap/buffered-io.c
> > ...
> > > @@ -1914,6 +1915,7 @@ static int iomap_writepage_map(struct iomap_writepage_ctx *wpc,
> > >  	struct inode *inode = folio->mapping->host;
> > >  	u64 pos = folio_pos(folio);
> > >  	u64 end_pos = pos + folio_size(folio);
> > > +	u64 end_aligned = 0;
> > >  	unsigned count = 0;
> > >  	int error = 0;
> > >  	u32 rlen;
> > > @@ -1955,9 +1957,10 @@ static int iomap_writepage_map(struct iomap_writepage_ctx *wpc,
> > >  	/*
> > >  	 * Walk through the folio to find dirty areas to write back.
> > >  	 */
> > > -	while ((rlen = iomap_find_dirty_range(folio, &pos, end_pos))) {
> > > +	end_aligned = round_up(end_pos, i_blocksize(inode));
> > 
> > So do I follow correctly that the set_range_dirty() path doesn't need
> > the alignment because it uses inclusive first_blk/last_blk logic,
> > whereas this find_dirty_range() path does the opposite and thus does
> > require the round_up? If so, presumably that means if we fixed up the
> > find path we wouldn't need end_aligned at all anymore?
> > 
> 
> Agreed with you.
> 
> > If I follow the reasoning correctly, then this looks Ok to me:
> > 
> > Reviewed-by: Brian Foster <bfoster@redhat.com>
> >
> > ... but as a followup exercise it might be nice to clean up the
> > iomap_find_dirty_range() path to either do the rounding itself or be
> > more consistent with set_range_dirty().
> > 
> > Brian
> 
> Yes, I think we can handle the cleanup through a separate patch later?                                                                            
> 

Yep, thanks.

Brian

> Thanks,
> Long Li
> 


