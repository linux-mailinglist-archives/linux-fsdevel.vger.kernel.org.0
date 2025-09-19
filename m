Return-Path: <linux-fsdevel+bounces-62222-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B7A1B89473
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Sep 2025 13:31:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 03AD5160600
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Sep 2025 11:31:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE3ED3093B8;
	Fri, 19 Sep 2025 11:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HXdZSGtf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABF0E86347
	for <linux-fsdevel@vger.kernel.org>; Fri, 19 Sep 2025 11:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758281482; cv=none; b=LrLoXdVfhb7XwUsACKFBKNMddMFCF81VGHDf/WPgrPcOtO04qKNpkrgyWVUdCwj9+QmoXCG2ISb5sdeEOC0+tx1QgSC1hTmacRRVBR0rskYwwLtc0WY57aasxADlcp98c2McFUmAbNysO7O4CVwuL2PVOIOIsOazO9bHElH8T3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758281482; c=relaxed/simple;
	bh=GmfE/FNNJlFKHbTYC8noAutB4xcJwMCkC20sEGVbr/w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=INbV45XcjgC6MRDUXae0Mhd1MhY/wkIaYihGhEHbNbiD+lWa/xaBATUCAv3bLrdts/lgcZqnkWtF0nJqcSDPkwJThBCxZ5yTkd7Io5PmfHdZt9Xd+q0sidbC33ycuR48tZzkcEAhdaogtfvZ7X4Ul9qsMgH5tUAhrf1oWCI+NOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HXdZSGtf; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758281479;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LlZUCqatW5ZZelCV4qPPTFNxzpdqGUhQhUy+qBGVLgA=;
	b=HXdZSGtfjHIVeaJ/fa19uLwplLR2zv8a9ex8bIYp1WnhYXcsAeWglqDVdcAFvpy7kydvDO
	kelPE7i5oqXxFhvjhV9kMu+Uk0DLYaMeDBoTnwvhSLfV8k/UXBvcfd7x2tpx4ybcOK4sdv
	tF2LCGqAwhR1sgSzdLSmrVjhOCvFLqM=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-632-60NuBychOnKdSEWkbgSp8w-1; Fri,
 19 Sep 2025 07:31:16 -0400
X-MC-Unique: 60NuBychOnKdSEWkbgSp8w-1
X-Mimecast-MFC-AGG-ID: 60NuBychOnKdSEWkbgSp8w_1758281475
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0EA281956089;
	Fri, 19 Sep 2025 11:31:15 +0000 (UTC)
Received: from bfoster (unknown [10.22.64.134])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C90A51955F21;
	Fri, 19 Sep 2025 11:31:13 +0000 (UTC)
Date: Fri, 19 Sep 2025 07:35:17 -0400
From: Brian Foster <bfoster@redhat.com>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: Christoph Hellwig <hch@infradead.org>, brauner@kernel.org,
	djwong@kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v1] iomap: simplify iomap_iter_advance()
Message-ID: <aM0_9f7r5l6U4lHS@bfoster>
References: <20250917004001.2602922-1-joannelkoong@gmail.com>
 <aMqzoK1BAq0ed-pB@bfoster>
 <CAJnrk1ZeYWseb0rpTT7w5S-c1YuVXe-w-qMVCAiwTJRpgm+fbQ@mail.gmail.com>
 <aMvtlfIRvb9dzABh@bfoster>
 <aMwW0Zp2hdXfTGos@infradead.org>
 <aMxpFWnIDOpEWR1U@bfoster>
 <CAJnrk1azO4iZD05atv9VJCG9f1G=8YCW6cyUw2LbW=4_ufi8gw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJnrk1azO4iZD05atv9VJCG9f1G=8YCW6cyUw2LbW=4_ufi8gw@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On Thu, Sep 18, 2025 at 03:10:18PM -0700, Joanne Koong wrote:
> On Thu, Sep 18, 2025 at 1:14 PM Brian Foster <bfoster@redhat.com> wrote:
> >
> > On Thu, Sep 18, 2025 at 07:27:29AM -0700, Christoph Hellwig wrote:
> > > On Thu, Sep 18, 2025 at 07:31:33AM -0400, Brian Foster wrote:
> > > > IME the __iomap_iter_advance() would be the most low level and flexible
> > > > version, whereas the wrappers simplify things. There's also the point
> > > > that the wrapper seems the more common case, so maybe that makes things
> > > > cleaner if that one is used more often.
> > > >
> > > > But TBH I'm not sure there is strong precedent. I'm content if we can
> > > > retain the current variant for the callers that take advantage of it.
> > > > Another idea is you could rename the current function to
> > > > iomap_iter_advance_and_update_length_for_loopy_callers() and see what
> > > > alternative suggestions come up. ;)
> > >
> > > Yeah, __ names are a bit nasty.  I prefer to mostly limit them to
> > > local helpers, or to things with an obvious inline wrapper for the
> > > fast path.  So I your latest suggestions actually aims in the right
> > > directly, but maybe we can shorten the name a little and do something
> > > like:
> > >
> > > iomap_iter_advance_and_update_len
> > >
> > > although even that would probably lead a few lines to spill.
> > > iomap_iter_advance_len would be a shorter, but a little more confusing,
> > > but still better than __-naming, so maybe it should be fine with a good
> > > kerneldoc comment?
> > >
> >
> > Ack, anything like that is fine with me, even something like
> > iomap_iter_advance_and_length() with a comment that just points out it
> > also calls iomap_length().
> >
> > Another thought was to have one helper that returns the remaining length
> > or error and then a wrapper that translates the return (i.e. return ret
> > >= 0 ? 0 : ret). But when I thought more about it seemed like it just
> > created confusion.
> >
> > Brian
> >
> 
> I'm looking at this patch again and wondering if the second helper is
> all that necessary. I feel like if we're adding it because the caller
> could be confused/unclear about needing to update their local length
> variable, then wouldn't they also be confused about having to use
> iomap_iter_advance_and_length() instead of iomap_iter_advance()? I
> feel like if they know enough to know that they need to use
> iomap_iter_advance_and_length() instead of iomap_iter_advance(), then
> they know enough to update their local length variable themsevles
> through iomap_length(). imo it seems cleaner / less cluttery to just
> have iomap_iter_advance(). But I'm happy to add the
> "iomap_advance_and_length()" helper for v2 if you guys disagree and
> prefer having a 2nd helper.
> 

Eh fair point. As mentioned at the top I'm not that worried about it,
just wanted to entertain discussion on a potentially clean way to do
both (thanks). Sounds more like it's not worth it.

Looking back at the patch again, my only followup comment is for the
handful of cases where the newly added iomap_length() is clearly the
tail of a loop, could we instead add the call to the loop iteration
line? I.e.:

	do {
		...
		iomap_iter_advance();
	while ((length = iomap_length(iter)) > 0)

With that tweak I'm good with it:

Reviewed-by: Brian Foster <bfoster@redhat.com>

Brian

> 
> Thanks,
> Joanne
> 


