Return-Path: <linux-fsdevel+bounces-28013-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 639A696611B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Aug 2024 13:56:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D807F1F286E9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Aug 2024 11:56:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E5F419882E;
	Fri, 30 Aug 2024 11:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZbRv3ELP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07FB518F2D5
	for <linux-fsdevel@vger.kernel.org>; Fri, 30 Aug 2024 11:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725019011; cv=none; b=tv7jKaK1hWOdcQ1vFVppJCgNw0FYt28Y4Vs6CR4T9lIvqYWWLk/SnP3L+OyKGi85lO3wvL+pwR+Ad9MnDEUCcI/FhJn9VELwquuqZA3DsjtRZMCf7BvNnKC/v9cuR3TxqXsPKgjj/0WBwz7+wZXqGUrWwuHhr7Ia9Su+qVNISUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725019011; c=relaxed/simple;
	bh=YkDBVGzrOx/VsfwqAbBAe90LgpryVugHR5F8hPKbKQo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m2cJKLw+gYz7hU3qSyodvCvrLYzqR36olwNtm3SpoPRcih4qBIQtcScdADK1JrHFOAn7JZuOEWeWiTVNqDixdzEqCyqP+d1eLjhX0/8fxZHVd4qakEiV8mJmKeupW9R8WH3fungBVP+bAvK0Mw13d0VA9aAqwXqiquJ58SQmFBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZbRv3ELP; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725019009;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zSLc11qhTygt7HmpmpslXVkQOWaRfUSRVX0mYTZEZlg=;
	b=ZbRv3ELPoazUoL3efz4Jma5Wh078lEaAZVqn0dYatRoX/8SL5TYLZFH63IoQuHZkj5lnjq
	2JFxYxuBNPs82fBevNBMvJmG+pb+LHTdVEBPXL2TN2AJj6WOM+hBmyUwrKyWpphydAvoYN
	BZCo8mEecGzD6/USpJ5V5N7hboglbM0=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-312-eB7dIMgTOwST6sWq8n7a_g-1; Fri,
 30 Aug 2024 07:56:45 -0400
X-MC-Unique: eB7dIMgTOwST6sWq8n7a_g-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B5A4E1955D57;
	Fri, 30 Aug 2024 11:56:43 +0000 (UTC)
Received: from bfoster (unknown [10.22.16.95])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 143501955BE3;
	Fri, 30 Aug 2024 11:56:41 +0000 (UTC)
Date: Fri, 30 Aug 2024 07:57:41 -0400
From: Brian Foster <bfoster@redhat.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>, linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org, josef@toxicpanda.com,
	david@fromorbit.com
Subject: Re: [PATCH 2/2] iomap: make zero range flush conditional on
 unwritten mappings
Message-ID: <ZtGztWILZPlU6Gxo@bfoster>
References: <20240822145910.188974-1-bfoster@redhat.com>
 <20240822145910.188974-3-bfoster@redhat.com>
 <Zs1uHoemE7jHQ2bw@infradead.org>
 <Zs3hTiXLtuwXkYgU@bfoster>
 <Zs6oY91eFfaFVrMw@infradead.org>
 <Zs8Zo3V1G3NAQEnK@bfoster>
 <ZtAKJH_NGhjxFQHa@infradead.org>
 <ZtCOVzK4KlPbcnk_@bfoster>
 <20240829214800.GQ6224@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240829214800.GQ6224@frogsfrogsfrogs>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

On Thu, Aug 29, 2024 at 02:48:00PM -0700, Darrick J. Wong wrote:
> On Thu, Aug 29, 2024 at 11:05:59AM -0400, Brian Foster wrote:
> > On Wed, Aug 28, 2024 at 10:41:56PM -0700, Christoph Hellwig wrote:
> > > On Wed, Aug 28, 2024 at 08:35:47AM -0400, Brian Foster wrote:
> > > > Yeah, it was buried in a separate review around potentially killing off
> > > > iomap_truncate_page():
> > > > 
> > > > https://lore.kernel.org/linux-fsdevel/ZlxUpYvb9dlOHFR3@bfoster/
> > > > 
> > > > The idea is pretty simple.. use the same kind of check this patch does
> > > > for doing a flush, but instead open code and isolate it to
> > > > iomap_truncate_page() so we can just default to doing the buffered write
> > > > instead.
> > > > 
> > > > Note that I don't think this replaces the need for patch 1, but it might
> > > > arguably make further optimization of the flush kind of pointless
> > > > because I'm not sure zero range would ever be called from somewhere that
> > > > doesn't flush already.
> > > > 
> > > > The tradeoffs I can think of are this might introduce some false
> > > > positives where an EOF folio might be dirty but a sub-folio size block
> > > > backing EOF might be clean, and again that callers like truncate and
> > > > write extension would need to both truncate the eof page and zero the
> > > > broader post-eof range. Neither of those seem all that significant to
> > > > me, but just my .02.
> > > 
> > > Looking at that patch and your current series I kinda like not having
> > > to deal with the dirty caches in the loop, and in fact I'd also prefer
> > > to not do any writeback from the low-level zero helpers if we can.
> > > That is not doing your patch 1 but instead auditing the callers if
> > > any of them needs them and documenting the expectation.
> 
> I looked, and was pretty sure that XFS is the only one that has that
> expectation.
> 
> > I agree this seems better in some ways, but I don't like complicating or
> > putting more responsibility on the callers. I think if we had a high
> > level iomap function that wrapped a combination of this proposed variant
> > of truncate_page() and zero_range() for general inode size changes, that
> > might alleviate that concern.
> > 
> > Otherwise IME even if we audited and fixed all callers today, over time
> > we'll just reintroduce the same sorts of errors if the low level
> > mechanisms aren't made to function correctly.
> 
> Yeah.  What /are/ the criteria for needing the flush and wait?  AFAICT,
> a filesystem only needs the flush if it's possible to have dirty
> pagecache backed either by a hole or an unwritten extent, right?
> 

Yeah, but this flush behavior shouldn't be a caller consideration at
all. It's just an implementation detail. All the caller should care
about is that zero range works As Expected (tm).

The pre-iomap way of doing this in XFS was xfs_zero_eof() ->
xfs_iozero(), which was an internally coded buffered write loop that
wrote zeroes into pagecache. That was ultimately replaced with
iomap_zero_range() with the same sort of usage expectations, but
iomap_zero_range() just didn't work quite correctly in all cases.

> I suppose we could amend the iomap ops so that filesystems could signal
> that they allow either of those things, and then we wouldn't have to
> query the mapping for filesystems that don't, right?  IOWs, one can opt
> out of safety features if there's no risk of a garbage, right?
> 

Not sure I parse.. In general I think we could let ops signal whether
they want certain checks. This is how I used the IOMAP_F_DIRTY_CACHE
flag mentioned in the other thread. If the operation handler is
interested in pagecache state, set an IOMAP_DIRTY_CACHE flag in ops to
trigger a pre iomap_begin() check and then set the corresponding
_F_DIRTY_CACHE flag on the mapping if dirty, but I'm not sure if that's
the same concept you're alluding to here.

> (Also: does xfs allow dirty page cache backed by a hole?  I didn't think
> that was possible.)
> 

It's a corner case. A mapped write can write to any portion of a folio
so long as it starts within eof. So if you have a mapped write that
writes past EOF, there's no guarantee that range of the folio is mapped
by blocks.

That post-eof part of the folio would be zeroed at writeback time, but
that assumes i_size doesn't change before writeback. If it does and the
size change operation doesn't do the zeroing itself (enter zero range
via write extension), then we end up with a dirty folio at least
partially backed by a hole with non-zero data within EOF. There's
nothing written back to disk in this hole backed example, but the
pagecache is still inconsistent with what's on disk and therefore I
suspect data corruption is possible if the folio is redirtied before
reclaimed.

Brian

> > > But please let Dave and Darrick chime in first before investing any
> > > work into this.
> > > 
> > > 
> > 
> > Based on the feedback to v2, it sounds like there's general consensus on
> > the approach modulo some code factoring discussion. Unless there is
> > objection, I think I'll stick with that for now for the sake of progress
> > and keep this option in mind on the back burner. None of this is really
> > that hard to change if we come up with something better.
> > 
> > Brian
> > 
> > 
> 


