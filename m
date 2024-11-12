Return-Path: <linux-fsdevel+bounces-34461-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4885C9C59C5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Nov 2024 14:59:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B77361F2200B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Nov 2024 13:59:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F0DF1FBF51;
	Tue, 12 Nov 2024 13:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S/HAkp4T"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F202433CE
	for <linux-fsdevel@vger.kernel.org>; Tue, 12 Nov 2024 13:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731419979; cv=none; b=TAadWRmVM+AhEeiwCwTxrZM4Dbvq1Xux5h0wKMFCY17HVI3fQjd5SncU+707YMHWYZWcHLL0I0i5V9ktheGaUq6/Zwbi9fjG2TnQUYNTEPCoh5oCBrFrrAgE16JH7otfOpYt6fPc8Bk5kMI0hGvW6oOcFvs9R8pGy3off81aob8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731419979; c=relaxed/simple;
	bh=yYTzbHnGfLVpTnkEpFlyAeqXaE/0XXTpSS2dNBvxacE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BmVYeiCweUVrR0nv1V2r8ZWOWP9CMEqkP5KWG8BH9Hd6641W86DPSCJZMzM2DU0EtzKo1FwfG5ZuV9Pl0yh1NfUhasnfeAJ6iph/N4+UK0B7GV7eshh2gl0/+3YhZXhBNrmYpFv9daNawE9GqYPe9VzayAtENdHsYRq8GJqnO4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=S/HAkp4T; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731419976;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=T5lZ2O/raKWNZuvNX/8e7WQjuMExllMVPYx2DxvHThE=;
	b=S/HAkp4TI/gnjEXWVisskk9yRlUJz4ekOGSlZlyCd9WDeskzv5nlF7eAUFmFqLIb8xfrxx
	JbGngxXLEb+CFC9gFau+XV8Z8iA4+wfu8V0zvnyKmGTQPkBrrsRyvphuT3YQr7C/GB0VUW
	nyBKA6HG22ny41oGKSFZGACMGYOccr4=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-80-UkdOJmRjMdGY-kcjVluB8Q-1; Tue,
 12 Nov 2024 08:59:35 -0500
X-MC-Unique: UkdOJmRjMdGY-kcjVluB8Q-1
X-Mimecast-MFC-AGG-ID: UkdOJmRjMdGY-kcjVluB8Q
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2762419560A2;
	Tue, 12 Nov 2024 13:59:34 +0000 (UTC)
Received: from bfoster (unknown [10.22.80.120])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 833D019560A3;
	Tue, 12 Nov 2024 13:59:33 +0000 (UTC)
Date: Tue, 12 Nov 2024 09:01:06 -0500
From: Brian Foster <bfoster@redhat.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v3 4/4] iomap: warn on zero range of a post-eof folio
Message-ID: <ZzNfoodbVtA6Gc1l@bfoster>
References: <20241108124246.198489-1-bfoster@redhat.com>
 <20241108124246.198489-5-bfoster@redhat.com>
 <20241109030623.GD9421@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241109030623.GD9421@frogsfrogsfrogs>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On Fri, Nov 08, 2024 at 07:06:23PM -0800, Darrick J. Wong wrote:
> On Fri, Nov 08, 2024 at 07:42:46AM -0500, Brian Foster wrote:
> > iomap_zero_range() uses buffered writes for manual zeroing, no
> > longer updates i_size for such writes, but is still explicitly
> > called for post-eof ranges. The historical use case for this is
> > zeroing post-eof speculative preallocation on extending writes from
> > XFS. However, XFS also recently changed to convert all post-eof
> > delalloc mappings to unwritten in the iomap_begin() handler, which
> > means it now never expects manual zeroing of post-eof mappings. In
> > other words, all post-eof mappings should be reported as holes or
> > unwritten.
> > 
> > This is a subtle dependency that can be hard to detect if violated
> > because associated codepaths are likely to update i_size after folio
> > locks are dropped, but before writeback happens to occur. For
> > example, if XFS reverts back to some form of manual zeroing of
> > post-eof blocks on write extension, writeback of those zeroed folios
> > will now race with the presumed i_size update from the subsequent
> > buffered write.
> > 
> > Since iomap_zero_range() can't correctly zero post-eof mappings
> > beyond EOF without updating i_size, warn if this ever occurs. This
> > serves as minimal indication that if this use case is reintroduced
> > by a filesystem, iomap_zero_range() might need to reconsider i_size
> > updates for write extending use cases.
> > 
> > Signed-off-by: Brian Foster <bfoster@redhat.com>
> > ---
> >  fs/iomap/buffered-io.c | 3 +++
> >  1 file changed, 3 insertions(+)
> > 
> > diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> > index 7f40234a301e..e18830e4809b 100644
> > --- a/fs/iomap/buffered-io.c
> > +++ b/fs/iomap/buffered-io.c
> > @@ -1354,6 +1354,7 @@ static loff_t iomap_zero_iter(struct iomap_iter *iter, bool *did_zero)
> >  {
> >  	loff_t pos = iter->pos;
> >  	loff_t length = iomap_length(iter);
> > +	loff_t isize = iter->inode->i_size;
> >  	loff_t written = 0;
> >  
> >  	do {
> > @@ -1369,6 +1370,8 @@ static loff_t iomap_zero_iter(struct iomap_iter *iter, bool *did_zero)
> >  		if (iter->iomap.flags & IOMAP_F_STALE)
> >  			break;
> >  
> > +		/* warn about zeroing folios beyond eof that won't write back */
> > +		WARN_ON_ONCE(folio_pos(folio) > isize);
> 
> 		WARN_ON_ONCE(folio_pos(folio) > iter->inode->i_size));?
> 
> No need to have the extra local variable for something that shouldn't
> ever happen.  Do you need i_size_read for correctness here?
> 

Dropped isize. I didn't think we needed i_size_read() since we're
typically in an fs operation path, but I could be wrong. I haven't seen
any spurious warnings in my testing so far, at least.

Brian

> --D
> 
> >  		offset = offset_in_folio(folio, pos);
> >  		if (bytes > folio_size(folio) - offset)
> >  			bytes = folio_size(folio) - offset;
> > -- 
> > 2.47.0
> > 
> > 
> 


