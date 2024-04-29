Return-Path: <linux-fsdevel+bounces-18161-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BD3F8B611F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Apr 2024 20:31:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD82C1C21A58
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Apr 2024 18:31:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E25B12AAF4;
	Mon, 29 Apr 2024 18:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="Uzr9CauI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12A311E529;
	Mon, 29 Apr 2024 18:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714415447; cv=none; b=seJSVnuhmknwoON1jzdOGBmafxf7TObnqTZL9esoerZWqDd1nEooN1u5MKVH2bXX1xNldZ3r2zAFw+s8uoo00PykBDVyT2I50falJcN8LKLc6yR/7HJ8r0dBiDc6y/QLXd/MF2SpzVEwxgmVAvgWHlnC+COJbv2ESpqyGlUydcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714415447; c=relaxed/simple;
	bh=mYQLtJGuyx5yVBiZIaiVgXGjW3gQ2C5ASaLIQlAPwKY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uKdEyXFjYzjAWCoSeSo4x8QcrSO6Gm5aWtn8Y3l0IeDzUNDPD0l4GhN3LRe8hQdFv14hKGTfeOkgqDIRjg2hpJu4eQ1poQZ0bj13o4eb11zfKooC18Lyg3u+11blzqSV42up9g9jEDqQey0wNFhEO0BaQhLpi+vXHI0c3vg1ORM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=Uzr9CauI; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=zkgLd2CqgOGGmF31rKa7MktRCUGJWWKhgi29mOt93qY=; b=Uzr9CauIg39fsbzmTZdAYRDx0V
	imJohmjFEUR+Ofb0v08HEqA8gxznaaqpZi5s9YtSIzjnXlqlimlSLI59sNDy8iLiE3pX497eOMvKM
	oqkbm3m9PCt0fN8cV0jwsIHUzPp7nWexrnNkGo6MxhSHb1nzDpcKDn0+glX2mTW3HZSN6zuvgYpYL
	2suFiIEJpBY6TqsSgu0Sk8xXjyzK/WKn0Myge86AfB5fb3e1f7rFCSnEE3RtB4JbWaCxHCe7jRv1I
	ocweq+I7gsRjxMhO7O9Z2Zqk3BrD96dGl+oqbGOt8atI66x+uMIQRdxGxkqw+cEovXE7IHFPQNiDZ
	RBe6obpw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1s1Vlx-007JYZ-1b;
	Mon, 29 Apr 2024 18:30:41 +0000
Date: Mon, 29 Apr 2024 19:30:41 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-fsdevel@vger.kernel.org, Yu Kuai <yukuai1@huaweicloud.com>,
	linux-block@vger.kernel.org, Christian Brauner <brauner@kernel.org>,
	Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCHES][RFC] packing struct block_device flags
Message-ID: <20240429183041.GC2118490@ZenIV>
References: <20240428051232.GU2118490@ZenIV>
 <20240429052315.GB32688@lst.de>
 <20240429073107.GZ2118490@ZenIV>
 <20240429170209.GA2118490@ZenIV>
 <20240429181300.GB2118490@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240429181300.GB2118490@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Mon, Apr 29, 2024 at 07:13:00PM +0100, Al Viro wrote:
> On Mon, Apr 29, 2024 at 06:02:09PM +0100, Al Viro wrote:
> > On Mon, Apr 29, 2024 at 08:31:07AM +0100, Al Viro wrote:
> > 
> > > FWIW, we could go for atomic_t there and use
> > > 	atomic_read() & 0xff
> > > for partno, with atomic_or()/atomic_and() for set/clear and
> > > atomic_read() & constant for test.  That might slightly optimize
> > > set/clear on some architectures, but setting/clearing flags is
> > > nowhere near hot enough for that to make a difference.
> > 
> > Incremental for that (would be folded into 3/8 if we went that way)
> > is below; again, I'm not at all sure it's idiomatic enough to bother
> > with, but that should at least show what's going on:
> 
> Or this, for that matter:

See #work.bd_flags-2 for carve-up of that variant.

