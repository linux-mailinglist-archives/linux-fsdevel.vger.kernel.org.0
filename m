Return-Path: <linux-fsdevel+bounces-18546-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 812F18BA449
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 May 2024 02:07:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 219041F23ED3
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 May 2024 00:07:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68D9F1370;
	Fri,  3 May 2024 00:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="P8zlUOs9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4EE0360;
	Fri,  3 May 2024 00:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714694813; cv=none; b=oxcEkpuDmxX6Xzc0hbsQkwXpipn4k2gGmVyY+BwMd9pNbzmRkUP7MO79+iPT6NMPXP6idcDU2CrOqSHKIUQ84NHt++yr8IyINE9INnTm9W8KpnHmo3+EOljf5/ITLf9jZfz0ctzrJnUNIhT5JKMjXWkS0tzNV5Gp2S7SuafJ7eY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714694813; c=relaxed/simple;
	bh=m7i6xFtaE9KtjcrRJZ/q2UWH/JZLrmJdSOaMG/GgDfo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I5DcnUgA6SqcoS10S3SwAOzkJf2lQW6iL6Q3/9IgmadrTl+wTsNqGH901bVqo5OsrpYYNn5WW03u8iNgqv5C2KN6P0uxlRFb1TsZnid2AFsPYvSzQP1Ox2hHN8IheitPetyprIiC+ftXaX/55VaU2CSTrfDqSylfFPsOLUZlcp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=P8zlUOs9; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=rtyj5z9Ei0w4WdAy896jWOuwltsE1ggZPdLZ4GaWbZ4=; b=P8zlUOs9VP9D7c5uuzfKI1DsCD
	Ba4iZk/izSxYQjR1ukUSPzxSlmdf1I9xwX5XSff49+sQy6gqSwcDUiptnYYqcHhYC6b2rAwnx5QnM
	bNoWDQNJ9pPemjn2Q/KAsGf6ezG48dlTUQ2Y9rOJQAEszlzyio551YhH0d6GORDkIEbAsSX69iGxN
	pg6NcagtfAT3g9JJqGt1Lnx2hLrDp8Cd2zgkPZNYilnb0jXLdPqTbbafGmhI42/RHq5UPtIjgIxH7
	XU3jra05Mi0/7SO//FRLr04EJ8Una671s0Pngcvgz5baY84wouKyyAoAkyXiwoKPR+R/bZ+XuL7dP
	URqWEAxQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1s2gRr-009tE5-0n;
	Fri, 03 May 2024 00:06:47 +0000
Date: Fri, 3 May 2024 01:06:47 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-fsdevel@vger.kernel.org, Yu Kuai <yukuai1@huaweicloud.com>,
	linux-block@vger.kernel.org, Christian Brauner <brauner@kernel.org>,
	Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCHES][RFC] packing struct block_device flags
Message-ID: <20240503000647.GQ2118490@ZenIV>
References: <20240428051232.GU2118490@ZenIV>
 <20240429052315.GB32688@lst.de>
 <20240429073107.GZ2118490@ZenIV>
 <20240429170209.GA2118490@ZenIV>
 <20240429181300.GB2118490@ZenIV>
 <20240429183041.GC2118490@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240429183041.GC2118490@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Mon, Apr 29, 2024 at 07:30:41PM +0100, Al Viro wrote:
> On Mon, Apr 29, 2024 at 07:13:00PM +0100, Al Viro wrote:
> > On Mon, Apr 29, 2024 at 06:02:09PM +0100, Al Viro wrote:
> > > On Mon, Apr 29, 2024 at 08:31:07AM +0100, Al Viro wrote:
> > > 
> > > > FWIW, we could go for atomic_t there and use
> > > > 	atomic_read() & 0xff
> > > > for partno, with atomic_or()/atomic_and() for set/clear and
> > > > atomic_read() & constant for test.  That might slightly optimize
> > > > set/clear on some architectures, but setting/clearing flags is
> > > > nowhere near hot enough for that to make a difference.
> > > 
> > > Incremental for that (would be folded into 3/8 if we went that way)
> > > is below; again, I'm not at all sure it's idiomatic enough to bother
> > > with, but that should at least show what's going on:
> > 
> > Or this, for that matter:
> 
> See #work.bd_flags-2 for carve-up of that variant.

Ugh...  Forgot to push it out, sorry.  Branch pushed out now,
individual patches in followups.

Summary of changes compared to posted variant:
	__bd_flags is atomic_t now.
	atomic_{or,andnot} is used instead of cmpxchg().
	the constants (BD_READ_ONLY, etc.) are masks, not flag numbers.

