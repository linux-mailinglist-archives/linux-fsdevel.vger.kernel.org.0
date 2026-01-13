Return-Path: <linux-fsdevel+bounces-73409-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 33A8CD181A2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jan 2026 11:41:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C0C0F302E040
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jan 2026 10:39:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2601225783C;
	Tue, 13 Jan 2026 10:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JUlP9QNW";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="gleHpzqr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2BAD288D0
	for <linux-fsdevel@vger.kernel.org>; Tue, 13 Jan 2026 10:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768300786; cv=none; b=dGdPcQMUl3GqaAs5MFCxYQPNo7rsEftFfyy/OtBG1im7dnnrBKp83d944PHgWnthNmsmHryDMT3/PImhLJx5qt0wy/QaxZrbd34WenK/SavKqzau6yQcdfq58lYbdx2fN/Q6eDE0DV+i+ktyeUYtGYjzw8sdVRF2hRxay2Tz9e0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768300786; c=relaxed/simple;
	bh=L1eUBbPokLBPE3y6roA4cFp01J7xKbKvqN8kV2tZYnA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kaNdkGYodhtyAIqfL+tJbOoJrPo3njfp6zIcLXMCSDm0bhG7jyOZLx8qWrMiPUhZctPGUV3Ca01kd+jhJ76dendtOcl1f4MYaZfThZoeM+4cQg1kCdCctbsYZx3MvxSyi2QLLNa48QRgM2h3hgKaKJ9fNRj0sS2Okxfd99uVQ2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JUlP9QNW; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=gleHpzqr; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768300782;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oRY1Papqna+6VteCH2AFvtA5W4GaXMzSIx7WQy0o9ac=;
	b=JUlP9QNWxqe3yhRNKDdoD0p8nSLZRkgiwVe+X3RvEvMOg+Sze7pb4dRcHZWLG/s8zVDoJk
	qsLNt+y2L/ecprabhAfRYR1uerwuvSwqDDqElb86SNvo2n2wsYExbWe39OMSbJ1429yiD6
	+saDoSFgPw1rZIehbx3HcPrkxKoJQvw=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-544-9BCjJr3wOpul1efQ9q4udA-1; Tue, 13 Jan 2026 05:39:41 -0500
X-MC-Unique: 9BCjJr3wOpul1efQ9q4udA-1
X-Mimecast-MFC-AGG-ID: 9BCjJr3wOpul1efQ9q4udA_1768300780
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-47d5bd981c8so50800825e9.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 13 Jan 2026 02:39:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1768300780; x=1768905580; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=oRY1Papqna+6VteCH2AFvtA5W4GaXMzSIx7WQy0o9ac=;
        b=gleHpzqrKklqFQbdr4XWADntS5wlho95AiV9spTVo/fbXlLahxkXVPjrkozfl2E2pY
         oVJV4GwppsQbc9T1xdctgU1LfCj/WRSQrG75TiNoOL6N+SrylIDKi/fW77fu5N+vfYGK
         1T6QbtOUUroYiOBNavoc85paKg7b8LkY5kEmFcGXKMWTla7Ou0dJKU6wlfSduuTS4wq1
         nMuwLILXN4GVuEXZrhnKhfrEqXFZGqADbqO9iYoc0QzAihjPx8ALTUS9UFwhRsYiwnuW
         sM/zP4cNMGiiKJASt3S2I5ryVPBn1NpwnZYpa2xsAyo27DUG3TYFoQt5ksKmgUDAUEjC
         4aHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768300780; x=1768905580;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oRY1Papqna+6VteCH2AFvtA5W4GaXMzSIx7WQy0o9ac=;
        b=Bj5rx0sQ8RRSs0IzypQqkl1ao7bUID4BuDk10wHPCyCpwV0mV2rO4ho2TE3ssfjEmw
         hu2I87Yh3F4gk41pWtNbUlz0g5LAcM33GurZ81hMSDxOJIT2l2AI9U+Id0Cg8YMi9kNf
         FeUVfBrskzSYML9L4scuxAWgs0eMlZlqacoRuOJ/bBpjvsPqBjvEoq61OVt2xdMyUbpo
         iIeQzg7DMxCYmeXb+wRmpx4d2BuhJHv/kXL1gsel6g5ZlvuinS3PK4ohOK6IYdWetn/q
         1TZeT5mJrfOaPygnSLmIMUz4x+UIoi93PRefZaC3h/VRcksyhj1l9xPvNfqGtONUdUjR
         6vsA==
X-Forwarded-Encrypted: i=1; AJvYcCXqEErIETGqAQiCk1b6x7QxFQZx7g8M/YmZZiUi7bjEOhNefPPt9n0SvZ0rkAF9lTZC7vlbpSbByxuEIA7n@vger.kernel.org
X-Gm-Message-State: AOJu0Ywtyv1Qc+6bZhtiOao1uw8sqjaNTqmpq1z7/W0OtsI+k2jrZIA0
	lX17hPfuu9ZQd5NJ0/MHeaF1YwH/w7vP8LyMfdWuytlugD0WN3SdQqoT1SLaVMGUYuQw7fne3N6
	ejgomzJe6bwtAZmvUMoupZBjTOLCggBrTOX/Q+EBTD8+raYh56UYndvWBQLqsF8ik5g==
X-Gm-Gg: AY/fxX7J9kN7YOC6jO5Hm19IlQ+Jok6BquL8yd3o5LMaYtchaY1GdNrXlDm2LuX7Qq4
	D0qv5G7FkO4ZWOfXG0yB74d50ClrMcUqULdnKQxCGfDGtluYkv6chHiNIvwVctlngR3PNZELv2E
	lnupcz3r/dLIYREZ3Vfowbh6+kd5mEDA2Wj0UVBju2qzOpVRh1uM4Y7VFqQ7J5oxM2afX3Q9S1T
	VJ3r3KI0Oel0bk/OYFko7ye8WkcKJYBtfT1L37ha2/vLIv/zB5MbnqjuGBQJbbixdOKcGfROTEq
	IirNXAzrLn0xoQQlu+rUndlTh3N1B7XZf1tsOm4+Ln51bxC3VZlrvsm1qFunzHXr4vzbYEak09k
	=
X-Received: by 2002:a05:600c:4fc6:b0:477:b734:8c41 with SMTP id 5b1f17b1804b1-47d84b0b320mr239515785e9.1.1768300780251;
        Tue, 13 Jan 2026 02:39:40 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGEmQllHcVxm7YMRWnIy0b/NbiM/9edk0sK25a00CV3tkioxyNGlnGyr83KsHze3vdlvpabJw==
X-Received: by 2002:a05:600c:4fc6:b0:477:b734:8c41 with SMTP id 5b1f17b1804b1-47d84b0b320mr239515475e9.1.1768300779721;
        Tue, 13 Jan 2026 02:39:39 -0800 (PST)
Received: from thinky ([217.30.74.39])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47eda5854f4sm11656095e9.20.2026.01.13.02.39.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jan 2026 02:39:39 -0800 (PST)
Date: Tue, 13 Jan 2026 11:39:38 +0100
From: Andrey Albershteyn <aalbersh@redhat.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: fsverity@lists.linux.dev, linux-xfs@vger.kernel.org, 
	ebiggers@kernel.org, linux-fsdevel@vger.kernel.org, aalbersh@kernel.org, 
	david@fromorbit.com, hch@lst.de
Subject: Re: [PATCH v2 3/22] iomap: introduce IOMAP_F_BEYOND_EOF
Message-ID: <lsggncpo3kbgjilvph2wjucrkvrwdggmbtosu6zqbrzs564u7d@nn4iyhq6edtz>
References: <cover.1768229271.patch-series@thinky>
 <d5fc72ldfwyzbgiypzlhn5diiqyijxaicpa3w6obx4iismuko3@kttpcgqjy6i5>
 <20260112221853.GI15551@frogsfrogsfrogs>
 <20260112223158.GK15551@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260112223158.GK15551@frogsfrogsfrogs>

On 2026-01-12 14:31:58, Darrick J. Wong wrote:
> On Mon, Jan 12, 2026 at 02:18:53PM -0800, Darrick J. Wong wrote:
> > On Mon, Jan 12, 2026 at 03:50:05PM +0100, Andrey Albershteyn wrote:
> > > Flag to indicate to iomap that read/write is happening beyond EOF and no
> > > isize checks/update is needed.
> > > 
> > > Signed-off-by: Andrey Albershteyn <aalbersh@kernel.org>
> > > ---
> > >  fs/iomap/buffered-io.c | 13 ++++++++-----
> > >  fs/iomap/trace.h       |  3 ++-
> > >  include/linux/iomap.h  |  5 +++++
> > >  3 files changed, 15 insertions(+), 6 deletions(-)
> > > 
> > > diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> > > index e5c1ca440d..cc1cbf2a4c 100644
> > > --- a/fs/iomap/buffered-io.c
> > > +++ b/fs/iomap/buffered-io.c
> > > @@ -533,7 +533,8 @@
> > 
> > (Does your diff program not set --show-c-function?  That makes reviewing
> > harder because I have to search on the comment text to figure out which
> > function this is)
> > 
> > >  			return 0;
> > >  
> > >  		/* zero post-eof blocks as the page may be mapped */
> > > -		if (iomap_block_needs_zeroing(iter, pos)) {
> > > +		if (iomap_block_needs_zeroing(iter, pos) &&
> > > +		    !(iomap->flags & IOMAP_F_BEYOND_EOF)) {
> > 
> > Hrm.  The last test in iomap_block_needs_zeroing is if pos is at or
> > beyond EOF, and iomap_adjust_read_range takes great pains to reduce plen
> > so that poff/plen never cross EOF.  I think the intent of that code is
> > to ensure that we always zero the post-EOF part of a folio when reading
> > it in from disk.
> > 
> > For verity I can see why you don't want to zero the merkle tree blocks
> > beyond EOF, but I think this code can expose unwritten junk in the
> > post-EOF part of the EOF block on disk.
> 
> Oh wait, is IOMAP_F_BEYOND_EOF only set on mappings that are entirely
> beyond EOF, aka the merkle tree extents?

yes, and only on fsverity files, so no normal read can get
BEYOND_EOF

> 
> --D
> 
> > Would it be more correct to do:
> > 
> > static inline bool
> > iomap_block_needs_zeroing(
> > 	const struct iomap_iter *iter,
> > 	struct folio *folio,
> > 	loff_t pos)
> > {
> > 	const struct iomap *srcmap = iomap_iter_srcmap(iter);
> > 
> > 	if (srcmap->type != IOMAP_MAPPED)
> > 		return true;
> > 	if (srcmap->flags & IOMAP_F_NEW);
> > 		return true;
> > 
> > 	/*
> > 	 * Merkle tree exists in a separate folio beyond EOF, so
> > 	 * only zero if this is the EOF folio.
> > 	 */
> > 	if (iomap->flags & IOMAP_F_BEYOND_EOF)
> > 		return folio_pos(folio) == i_size_read(iter->inode);
> > 
> > 	return pos >= i_size_read(iter->inode);
> > }
> > 
> > >  			folio_zero_range(folio, poff, plen);
> > >  			iomap_set_range_uptodate(folio, poff, plen);
> > >  		} else {
> > > @@ -1130,13 +1131,14 @@
> > >  		 * unlock and release the folio.
> > >  		 */
> > >  		old_size = iter->inode->i_size;
> > > -		if (pos + written > old_size) {
> > > +		if (pos + written > old_size &&
> > > +		    !(iter->flags & IOMAP_F_BEYOND_EOF)) {
> > >  			i_size_write(iter->inode, pos + written);
> > >  			iter->iomap.flags |= IOMAP_F_SIZE_CHANGED;
> > >  		}
> > >  		__iomap_put_folio(iter, write_ops, written, folio);
> > >  
> > > -		if (old_size < pos)
> > > +		if (old_size < pos && !(iter->flags & IOMAP_F_BEYOND_EOF))
> > >  			pagecache_isize_extended(iter->inode, old_size, pos);
> > >  
> > >  		cond_resched();
> > > @@ -1815,8 +1817,9 @@
> > >  
> > >  	trace_iomap_writeback_folio(inode, pos, folio_size(folio));
> > >  
> > > -	if (!iomap_writeback_handle_eof(folio, inode, &end_pos))
> > > -		return 0;
> > > +	if (!(wpc->iomap.flags & IOMAP_F_BEYOND_EOF) &&
> > > +	    !iomap_writeback_handle_eof(folio, inode, &end_pos))
> > 
> > Hrm.  I /think/ this might break post-eof zeroing on writeback if
> > BEYOND_EOF is set.  For verity this isn't a problem because there's no
> > writeback, but it's a bit of a logic bomb if someone ever tries to set
> > BEYOND_EOF on a non-verity file.

I will rename it to IOMAP_F_FSVERITY

> > 
> > --D
> > 
> > > + 		return 0;
> > >  	WARN_ON_ONCE(end_pos <= pos);
> > >  
> > >  	if (i_blocks_per_folio(inode, folio) > 1) {
> > > diff --git a/fs/iomap/trace.h b/fs/iomap/trace.h
> > > index 532787277b..f1895f7ae5 100644
> > > --- a/fs/iomap/trace.h
> > > +++ b/fs/iomap/trace.h
> > > @@ -118,7 +118,8 @@
> > >  	{ IOMAP_F_ATOMIC_BIO,	"ATOMIC_BIO" }, \
> > >  	{ IOMAP_F_PRIVATE,	"PRIVATE" }, \
> > >  	{ IOMAP_F_SIZE_CHANGED,	"SIZE_CHANGED" }, \
> > > -	{ IOMAP_F_STALE,	"STALE" }
> > > +	{ IOMAP_F_STALE,	"STALE" }, \
> > > +	{ IOMAP_F_BEYOND_EOF,	"BEYOND_EOF" }
> > >  
> > >  
> > >  #define IOMAP_DIO_STRINGS \
> > > diff --git a/include/linux/iomap.h b/include/linux/iomap.h
> > > index 520e967cb5..7a7e31c499 100644
> > > --- a/include/linux/iomap.h
> > > +++ b/include/linux/iomap.h
> > > @@ -86,6 +86,11 @@
> > >  #define IOMAP_F_PRIVATE		(1U << 12)
> > >  
> > >  /*
> > > + * IO happens beyound inode EOF
> > 
> > s/beyound/beyond/

will fix

-- 
- Andrey


