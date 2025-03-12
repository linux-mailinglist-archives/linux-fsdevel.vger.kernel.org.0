Return-Path: <linux-fsdevel+bounces-43802-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 358DEA5DE60
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Mar 2025 14:52:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C7F03B7AD7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Mar 2025 13:52:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FD0E24BBFD;
	Wed, 12 Mar 2025 13:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="iUxOtOzo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2DAF1DBB38;
	Wed, 12 Mar 2025 13:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741787524; cv=none; b=rTOd96APOKjGXb+EtuyC6IkOh2Hx2gmCP+Yk2WZFjspcdTwx54asHDvqlX2fzWR05l06z+oDvk3vcX6o0pDmrVY3D0oOFOaoMo2ImcS3RUCxttEvbW5+ujWcpyh80Y2wW5/SGSe8m4k7NE3Aj88ZIj4OEbrl+4mf5Vy5aEHKZNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741787524; c=relaxed/simple;
	bh=Ji+YB9tqGtkwz2/R8D8F5u4OjI23rB3XCelRkcBfvQ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e6joA1E8F/no2ESH7Gj0U7ylAnUEcpJTUQJVb4slYjG68o8sEEfSE6kg3FLdY72xYMayVDNsPqJ5z7yEAGU4+o0pMlZSVQfBprYBHl4fSxMgz4kIX3/7pDxOmT8TTLkAZqJx6VK5dlp76tXm3alPoFuvxKr1LfpXHESjQQhbMFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=iUxOtOzo; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=mwv9UrpFFoVpPTlFTeLE+h3QVdWnPuF0aLbRYyyb6zU=; b=iUxOtOzo2rwQK4sTGN4qNMmSwA
	33S/QCQ17IGqEbnRFA8Q40QEynzpqOIyS6tQyaDdbIQn+CvIYtkYW9pNRZb5NEFnzb6YoFQI282vl
	puCBk6DohGVKdo10AjVF+6aXkxXcyRm3yd/40S7u9Ifql+dJG3jitnkn1vyJd9dpHQvnc/UWrYVHs
	xKcjy4byk5mrGLm8oPm+TYdAOxY434YyoMPG2IrvlLIOqWHByWak2A2mdmQeVzJN9NwiRiWxdMHZI
	tlRufVtk0B0tbLJyM2n9p4g6by28zQc2ZmkmWn2s0syRYwWHizZJerOZ+zYnWA/sScbBd8qnrHNCg
	QcB1Vinw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tsMV9-00000008ceN-10wY;
	Wed, 12 Mar 2025 13:52:03 +0000
Date: Wed, 12 Mar 2025 06:52:03 -0700
From: Christoph Hellwig <hch@infradead.org>
To: John Garry <john.g.garry@oracle.com>
Cc: Christoph Hellwig <hch@infradead.org>, brauner@kernel.org,
	djwong@kernel.org, cem@kernel.org, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	ojaswin@linux.ibm.com, ritesh.list@gmail.com,
	martin.petersen@oracle.com
Subject: Re: [PATCH v5 05/10] xfs: Iomap SW-based atomic write support
Message-ID: <Z9GRg-X76T-7rshv@infradead.org>
References: <20250310183946.932054-1-john.g.garry@oracle.com>
 <20250310183946.932054-6-john.g.garry@oracle.com>
 <Z9E5nDg3_cred1bH@infradead.org>
 <ea94c5cd-ebba-404f-ba14-d59f1baa6e16@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ea94c5cd-ebba-404f-ba14-d59f1baa6e16@oracle.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Wed, Mar 12, 2025 at 09:00:52AM +0000, John Garry wrote:
> > How is -EAGAIN going to work here given that it is also used to defer
> > non-blocking requests to the caller blocking context?
> 
> You are talking about IOMAP_NOWAIT handling, right?

Yes.

> If so, we handle that in
> xfs_file_dio_write_atomic(), similar to xfs_file_dio_write_unaligned(), i.e.
> if IOMAP_NOWAIT is set and we get -EAGAIN, then we will return -EAGAIN
> directly to the caller.

Can you document this including the interaction between the different
cases of -EAGAIN somewhere?

> > What is the probem with only setting the flag that causes REQ_ATOMIC
> > to be set from the file system instead of forcing it when calling
> > iomap_dio_rw?
> 
> We have this in __iomap_dio_rw():
> 
> 	if (dio_flags & IOMAP_DIO_ATOMIC_SW)
> 		iomi.flags |= IOMAP_ATOMIC_SW;
> 	else if (iocb->ki_flags & IOCB_ATOMIC)
>  		iomi.flags |= IOMAP_ATOMIC_HW;
> 
> I do admit that the checks are a bit uneven, i.e. check vs
> IOMAP_DIO_ATOMIC_SW and IOCB_ATOMIC
> 
> If we want a flag to set REQ_ATOMIC from the FS then we need
> IOMAP_DIO_BIO_ATOMIC, and that would set IOMAP_BIO_ATOMIC. Is that better?

My expectation from a very cursory view is that iomap would be that
there is a IOMAP_F_REQ_ATOMIC that is set in ->iomap_begin and which
would make the core iomap code set REQ_ATOMIC on the bio for that
iteration.

> > Also how you ensure this -EAGAIN only happens on the first extent
> > mapped and you doesn't cause double writes?
> 
> When we find that a mapping does not suit REQ_ATOMIC-based atomic write,
> then we immediately bail and retry with FS-based atomic write. And that
> check should cover all requirements for a REQ_ATOMIC-based atomic write:
> - aligned
> - contiguous blocks, i.e. the mapping covers the full write
> 
> And we also have the check in iomap_dio_bit_iter() to ensure that the
> mapping covers the full write (for REQ_ATOMIC-based atomic write).

Ah, I guess that's the

	if (bio_atomic && length != iter->len)
		return -EINVAL;

So yes, please adda comment there that this is about a single iteration
covering the entire write.


