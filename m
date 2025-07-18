Return-Path: <linux-fsdevel+bounces-55433-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BD31FB0A57C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Jul 2025 15:45:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E1A83B558E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Jul 2025 13:45:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBCE82BDC1D;
	Fri, 18 Jul 2025 13:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KoqrsqjP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D41C0126C1E
	for <linux-fsdevel@vger.kernel.org>; Fri, 18 Jul 2025 13:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752846326; cv=none; b=rnra9VQ6qY3WEKhrif68tkpREy24vQXqQiOC4uWDDjwsICTBNoo5lc7CLP4PMgk5pPxEXA6AIbfz7IrRS98XumPAp+Yfb3Qecli3cMedTWTGrQcQ7oouqklks3LFHVWThi5DGG8acecXUttSi8U6/W7bUZeQAzZFuRFaWv6sznI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752846326; c=relaxed/simple;
	bh=WipuT1sG80Kqgs4Rio5XVDokJa/1ePvEc66uO9IabRM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kuq7/ULCP+dvNueVrtXYWbXfze9SjUZ5sWiEPivTQ3jdLWbxGI0HnTsFZY6prbecMVsjf0iyZTeKpsNeEEWE/1F3r6PS5CGLeFQZJCXoIZgsa9LO6V4WCObRBjnYs5ZL7pysjZlGGfIPDf1WtLgJk6VtyJa+wFRuUtZGlZ58Mdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KoqrsqjP; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752846322;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3GvvYIuajsxp+kxv/56jCZLacsNZ7W7YUzRAr6tPZH4=;
	b=KoqrsqjPwFTMJ6nf6qDol8UsDmI8juMuwH0Kyc9cuSZUzkTAPcGqtAnUKpvJQM0xxW440+
	GAg42qWJ+VbYtvCM9+z/54t67N7oBC2O8vb3SiPcr6XtXtiCbhHOxR2Qs9UD7VZ7DLOZRU
	xfgtocX5VTwz8SmUwrmgiVBbtfIGDlg=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-614-_cRK0FLWNfu5qDrnabbNTg-1; Fri,
 18 Jul 2025 09:45:17 -0400
X-MC-Unique: _cRK0FLWNfu5qDrnabbNTg-1
X-Mimecast-MFC-AGG-ID: _cRK0FLWNfu5qDrnabbNTg_1752846316
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DE4081956048;
	Fri, 18 Jul 2025 13:45:15 +0000 (UTC)
Received: from bfoster (unknown [10.22.88.128])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 985E3196664F;
	Fri, 18 Jul 2025 13:45:13 +0000 (UTC)
Date: Fri, 18 Jul 2025 09:48:54 -0400
From: Brian Foster <bfoster@redhat.com>
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
	linux-mm@kvack.org, hch@infradead.org, willy@infradead.org,
	"Darrick J. Wong" <djwong@kernel.org>,
	Ext4 Developers List <linux-ext4@vger.kernel.org>
Subject: Re: [PATCH v3 3/7] iomap: optional zero range dirty folio processing
Message-ID: <aHpQxq6mDyLL1Nfj@bfoster>
References: <20250714204122.349582-1-bfoster@redhat.com>
 <20250714204122.349582-4-bfoster@redhat.com>
 <20250715052259.GO2672049@frogsfrogsfrogs>
 <e6333d2d-cc30-44d3-8f23-6a6c5ea0134d@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e6333d2d-cc30-44d3-8f23-6a6c5ea0134d@huaweicloud.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On Fri, Jul 18, 2025 at 07:30:10PM +0800, Zhang Yi wrote:
> On 2025/7/15 13:22, Darrick J. Wong wrote:
> > On Mon, Jul 14, 2025 at 04:41:18PM -0400, Brian Foster wrote:
> >> The only way zero range can currently process unwritten mappings
> >> with dirty pagecache is to check whether the range is dirty before
> >> mapping lookup and then flush when at least one underlying mapping
> >> is unwritten. This ordering is required to prevent iomap lookup from
> >> racing with folio writeback and reclaim.
> >>
> >> Since zero range can skip ranges of unwritten mappings that are
> >> clean in cache, this operation can be improved by allowing the
> >> filesystem to provide a set of dirty folios that require zeroing. In
> >> turn, rather than flush or iterate file offsets, zero range can
> >> iterate on folios in the batch and advance over clean or uncached
> >> ranges in between.
> >>
> >> Add a folio_batch in struct iomap and provide a helper for fs' to
> > 
> > /me confused by the single quote; is this supposed to read:
> > 
> > "...for the fs to populate..."?
> > 
> > Either way the code changes look like a reasonable thing to do for the
> > pagecache (try to grab a bunch of dirty folios while XFS holds the
> > mapping lock) so
> > 
> > Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
> > 
> > --D
> > 
> > 
> >> populate the batch at lookup time. Update the folio lookup path to
> >> return the next folio in the batch, if provided, and advance the
> >> iter if the folio starts beyond the current offset.
> >>
> >> Signed-off-by: Brian Foster <bfoster@redhat.com>
> >> Reviewed-by: Christoph Hellwig <hch@lst.de>
> >> ---
> >>  fs/iomap/buffered-io.c | 89 +++++++++++++++++++++++++++++++++++++++---
> >>  fs/iomap/iter.c        |  6 +++
> >>  include/linux/iomap.h  |  4 ++
> >>  3 files changed, 94 insertions(+), 5 deletions(-)
> >>
> >> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> >> index 38da2fa6e6b0..194e3cc0857f 100644
> >> --- a/fs/iomap/buffered-io.c
> >> +++ b/fs/iomap/buffered-io.c
> [...]
> >> @@ -1398,6 +1452,26 @@ static int iomap_zero_iter(struct iomap_iter *iter, bool *did_zero)
> >>  	return status;
> >>  }
> >>  
> >> +loff_t
> >> +iomap_fill_dirty_folios(
> >> +	struct iomap_iter	*iter,
> >> +	loff_t			offset,
> >> +	loff_t			length)
> >> +{
> >> +	struct address_space	*mapping = iter->inode->i_mapping;
> >> +	pgoff_t			start = offset >> PAGE_SHIFT;
> >> +	pgoff_t			end = (offset + length - 1) >> PAGE_SHIFT;
> >> +
> >> +	iter->fbatch = kmalloc(sizeof(struct folio_batch), GFP_KERNEL);
> >> +	if (!iter->fbatch)
> 
> Hi, Brian!
> 
> I think ext4 needs to be aware of this failure after it converts to use
> iomap infrastructure. It is because if we fail to add dirty folios to the
> fbatch, iomap_zero_range() will flush those unwritten and dirty range.
> This could potentially lead to a deadlock, as most calls to
> ext4_block_zero_page_range() occur under an active journal handle.
> Writeback operations under an active journal handle may result in circular
> waiting within journal transactions. So please return this error code, and
> then ext4 can interrupt zero operations to prevent deadlock.
> 

Hi Yi,

Thanks for looking at this.

Huh.. so the reason for falling back like this here is just that this
was considered an optional optimization, with the flush in
iomap_zero_range() being default fallback behavior. IIUC, what you're
saying means that the current zero range behavior without this series is
problematic for ext4-on-iomap..? If so, have you observed issues you can
share details about?

FWIW, I think your suggestion is reasonable, but I'm also curious what
the error handling would look like in ext4. Do you expect to the fail
the higher level operation, for example? Cycle locks and retry, etc.?

The reason I ask is because the folio_batch handling has come up through
discussions on this series. My position so far has been to keep it as a
separate allocation and to keep things simple since it is currently
isolated to zero range, but that may change if the usage spills over to
other operations (which seems expected at this point). I suspect that if
a filesystem actually depends on this for correct behavior, that is
another data point worth considering on that topic.

So that has me wondering if it would be better/easier here to perhaps
embed the batch in iomap_iter, or maybe as an incremental step put it on
the stack in iomap_zero_range() and initialize the iomap_iter pointer
there instead of doing the dynamic allocation (then the fill helper
would set a flag to indicate the fs did pagecache lookup). Thoughts on
something like that?

Also IIUC ext4-on-iomap is still a WIP and review on this series seems
to have mostly wound down. Any objection if the fix for that comes along
as a followup patch rather than a rework of this series?

Brian

P.S., I'm heading on vacation so it will likely be a week or two before
I follow up from here, JFYI.

> Thanks,
> Yi.
> 
> >> +		return offset + length;
> >> +	folio_batch_init(iter->fbatch);
> >> +
> >> +	filemap_get_folios_dirty(mapping, &start, end, iter->fbatch);
> >> +	return (start << PAGE_SHIFT);
> >> +}
> >> +EXPORT_SYMBOL_GPL(iomap_fill_dirty_folios);
> 


