Return-Path: <linux-fsdevel+bounces-69049-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 744A3C6CD42
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Nov 2025 06:51:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id 2D0032A137
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Nov 2025 05:51:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67A50311946;
	Wed, 19 Nov 2025 05:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Gl1NeohW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 749B62ECD14;
	Wed, 19 Nov 2025 05:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763531462; cv=none; b=Q4J/GotFgE1BoIvH0xbmtDqCeY5jRgsm2RqEGmLEqj/MNlikFn1xblnLdMBGZA8TPztZExLL3VwCqvAQU7mdT51Jv0KThv1XVP3y7oYqvohIJHIwCg/tk088oGQMn3lu9UvI+1PFiK6e0ptZ+xZaBlfaY16JEqkfkebPmcWwjDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763531462; c=relaxed/simple;
	bh=zO8zOpKaiSIXJHk0EPgcQ227CLXzPZYpyzntHJwRjdc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ebJ2+rqQSZbyVPmScXGnxHIQIgPPz54X0KOsjmlkUtECS20t6/u0Db/RZWucJ8mqjCYgcaqBb6dMJ4go6S1S/Mvxm9IMu3lhT75TOXm75+W5FE5mMfWWKxf+M4pgQrhmonFaAhIPHdGEHssAk2wq9JSIQDBGto5q6jCGhsCzzuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Gl1NeohW; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=oSUCW2aTXazbvbtd8t7tT7TQJ2omNwxbKL/AucooRco=; b=Gl1NeohWW4D63QJy037NIx5AwG
	0hK0i3ORimeuhGTfy4ed0DNW3HMXWUDMF9+ZtXM6c3JgtTbWP4TzcT7yfS3Jdru/LulygCgwo9jOb
	MK8+YlbPb6aCLDH269juL/NLJJUPQ+LvPLV1fPDZvftwQ+YSQJ2WqnG0sQqQUqsYb7XQoLgO2UmHG
	nOl9BEtF/T8Xx+M+E+vnEbw+aD5QzBGs2v0+HNJT4P7BLAbSEqXFxvyM0ckeVaZedGV5irsLEkycD
	tJBKEhTWOUPiM6pE1MuNBha9J5v7mjdcyemLxC9o1TWST/i1IGn10uxmGvZ8MYINZVW9h4zPO/81a
	0n9JbTtQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vLb5k-00000002RCL-2l21;
	Wed, 19 Nov 2025 05:50:56 +0000
Date: Tue, 18 Nov 2025 21:50:56 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Matthew Wilcox <willy@infradead.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Christoph Hellwig <hch@infradead.org>,
	"Darrick J. Wong" <djwong@kernel.org>,
	SHAURYA RANE <ssrane_b23@ee.vjti.ac.in>, akpm@linux-foundation.org,
	shakeel.butt@linux.dev, eddyz87@gmail.com, andrii@kernel.org,
	ast@kernel.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, linux-kernel-mentees@lists.linux.dev,
	skhan@linuxfoundation.org, david.hunter.linux@gmail.com,
	khalid@kernel.org,
	syzbot+09b7d050e4806540153d@syzkaller.appspotmail.com,
	bpf <bpf@vger.kernel.org>
Subject: Re: [PATCH] mm/filemap: fix NULL pointer dereference in
 do_read_cache_folio()
Message-ID: <aR1awLOhdOXNMl9c@infradead.org>
References: <20251114193729.251892-1-ssranevjti@gmail.com>
 <aReUv1kVACh3UKv-@casper.infradead.org>
 <CANNWa07Y_GPKuYNQ0ncWHGa4KX91QFosz6WGJ9P6-AJQniD3zw@mail.gmail.com>
 <aRpQ7LTZDP-Xz-Sr@casper.infradead.org>
 <20251117164155.GB196362@frogsfrogsfrogs>
 <aRtjfN7sC6_Bv4bx@casper.infradead.org>
 <CAEf4BzZu+u-F9SjhcY5GN5vumOi6X=3AwUom+KJXeCpvC+-ppQ@mail.gmail.com>
 <aRxunCkc4VomEUdo@infradead.org>
 <aRySpQbNuw3Y5DN-@casper.infradead.org>
 <CAEf4BzY1fu+7pqotaW6DxH_vvwCY8rTuX=+0RO96-baKJDeB_Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4BzY1fu+7pqotaW6DxH_vvwCY8rTuX=+0RO96-baKJDeB_Q@mail.gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Tue, Nov 18, 2025 at 11:27:47AM -0800, Andrii Nakryiko wrote:
> Then please help make it better, give us interfaces you think are
> appropriate. People do use this functionality in production, it's
> important and we are not going to drop it. In non-sleepable mode it's
> best-effort, if the requested part of the file is paged in, we'll
> successfully read data (such as ELF's build ID), and if not, we'll
> report that to the BPF program as -EFAULT. In sleepable mode, we'll
> wait for that part of the file to be paged in before proceeding.
> PROCMAP_QUERY ioctl() is always in sleepable mode, so it will wait for
> file data to be read.

That's pretty demanding:  "If you don't give me the interface that I want
I'll just poke into internals and do broken shit" isn't really the
best way to make friends and win influence.,

> If you don't like the implementation, please help improve it, don't
> just request dropping it "because BPF folks" or anything like that.

Again, you're trying to put a lot of work you should have done on
others.  Everyone here is pretty helpful guiding when asking for help,
but being asked at gunpoint to cleanup the mess your created is not
going to get everyone drop their work and jump onto your project.

