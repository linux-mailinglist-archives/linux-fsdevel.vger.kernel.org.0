Return-Path: <linux-fsdevel+bounces-34516-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CE5E09C6015
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Nov 2024 19:15:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 85D161F254C9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Nov 2024 18:15:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 710AD218598;
	Tue, 12 Nov 2024 18:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G2QRstQb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32A99216DE3
	for <linux-fsdevel@vger.kernel.org>; Tue, 12 Nov 2024 18:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731435274; cv=none; b=Vz7/kduLJyESZ3Pf/56MtaAcTgW8KQVMoIxwlo8OUgkld1AECZgTJp59DicXE5S6I21tlm1+PpW9ebTRuypui+Alj1PJpd2qIvovSFJwUYBscBKMD60o/Nd5N/B5zjTrZvfZkbx3iC38eVpqYAqyi899JtfkkK9CexnHOr2UfeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731435274; c=relaxed/simple;
	bh=cTA/3qBaVbffUGaQQs3FfHcFcnnvR+nC1eIweZ0ALvc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Er5qSQGuZFdjLyIdKkGPHTOe5dGvnS/lE615BqOwkd7kPDlacpAtQAFv0ookRxssiJG5tpkIf2T4IOvh6orrfbTOERGXABYJs/OwpEGVJpd67fBZ6SDmXayIsMxj7j8U6zA7Vs/1WWwc3ApUs9P4iJAT2ieIhpMuljjAwC5P6fk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=G2QRstQb; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731435272;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NmxhVs+P1hJWoZYSTyfdVSHjqXEZNLNo4iVdoO1zihw=;
	b=G2QRstQbkKmfZI5SzmDs22aIIfRJB1+YNX7W1oJn7WircDEChDUlXxDsG7vQrsS5eULwys
	BbkiM93TdnyFPrnoopRFUKwbG+PVpWkfuR4yeWw/C7CECv+ZibG1Z+bAJOls5KMl70b+67
	U3NnKVtRz9FEsx0W3RxjtU4mvNftNJY=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-441-542WbpeqPuywkE7leFyq5g-1; Tue,
 12 Nov 2024 13:14:26 -0500
X-MC-Unique: 542WbpeqPuywkE7leFyq5g-1
X-Mimecast-MFC-AGG-ID: 542WbpeqPuywkE7leFyq5g
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5F77419560B1;
	Tue, 12 Nov 2024 18:14:17 +0000 (UTC)
Received: from bfoster (unknown [10.22.80.120])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 238491956086;
	Tue, 12 Nov 2024 18:14:14 +0000 (UTC)
Date: Tue, 12 Nov 2024 13:15:47 -0500
From: Brian Foster <bfoster@redhat.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, hannes@cmpxchg.org,
	clm@meta.com, linux-kernel@vger.kernel.org, willy@infradead.org,
	kirill@shutemov.name, linux-btrfs@vger.kernel.org,
	linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH 13/16] iomap: make buffered writes work with RWF_UNCACHED
Message-ID: <ZzObU9CkhKEcRgc5@bfoster>
References: <20241111234842.2024180-1-axboe@kernel.dk>
 <20241111234842.2024180-14-axboe@kernel.dk>
 <ZzOEVwWpGEaq6wE7@bfoster>
 <aeb58f3d-67b2-4df3-abc7-49a2e9bb8270@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aeb58f3d-67b2-4df3-abc7-49a2e9bb8270@kernel.dk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

On Tue, Nov 12, 2024 at 10:16:10AM -0700, Jens Axboe wrote:
> On 11/12/24 9:37 AM, Brian Foster wrote:
> > On Mon, Nov 11, 2024 at 04:37:40PM -0700, Jens Axboe wrote:
> >> Add iomap buffered write support for RWF_UNCACHED. If RWF_UNCACHED is
> >> set for a write, mark the folios being written with drop_writeback. Then
> > 
> > s/drop_writeback/uncached/ ?
> 
> Ah indeed, guess that never got changed. Thanks, will fix that in the
> commit message.
> 
> > BTW, this might be getting into wonky "don't care that much" territory,
> > but something else to be aware of is that certain writes can potentially
> > change pagecache state as a side effect outside of the actual buffered
> > write itself.
> > 
> > For example, xfs calls iomap_zero_range() on write extension (i.e. pos >
> > isize), which uses buffered writes and thus could populate a pagecache
> > folio without setting it uncached, even if done on behalf of an uncached
> > write.
> > 
> > I've only made a first pass and could be missing some details, but IIUC
> > I _think_ this means something like writing out a stream of small,
> > sparse and file extending uncached writes could actually end up behaving
> > more like sync I/O. Again, not saying that's something we really care
> > about, just raising it in case it's worth considering or documenting..
> 
> No that's useful info, I'm not really surprised that there would still
> be cases where UNCACHED goes unnoticed. In other words, I'd be surprised
> if the current patches for eg xfs/ext4 cover all the cases where new
> folios are created and should be marked as UNCACHED of IOCB_UNCACHED is
> set in the iocb.
> 
> I think those can be sorted out or documented as we move forward.
> UNCACHED is really just a hint - the kernel should do its best to not
> have permanent folios for this IO, but there are certainly cases where
> it won't be honored if you're racing with regular buffered IO or mmap.
> For the case above, sounds like we could cover that, however, and
> probably should.
> 

Ok. I suppose you could plumb the iocb state through the zero range call
as well, but given the description/semantics I wouldn't blame you if you
wanted to leave that for a followon improvement. Thanks for the
explanation.

Brian

> -- 
> Jens Axboe
> 


