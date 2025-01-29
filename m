Return-Path: <linux-fsdevel+bounces-40278-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B3D3A217C0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Jan 2025 07:34:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F370A1886F1B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Jan 2025 06:34:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E0A91922DC;
	Wed, 29 Jan 2025 06:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="MKVfEhiv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71355823DE;
	Wed, 29 Jan 2025 06:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738132474; cv=none; b=boc4MLgeVXNq8agLxOPhoxgqVD6A05PQ/IeyQ0hLlbkGN2k3VNVWphwTQ+la5wskqspQrIHapgJRF9O2QU+RJtaYapT2DV6OvDkzcjCmUENJ5eY4jFDiPNjLxg0PmGm3Lg/prBZ7W/9/s7UjRnRU5JctA7QezjVHMQeWIoKRwsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738132474; c=relaxed/simple;
	bh=8uhBbOxmYYNuR8ylrkezxVBOInP91+12/75jYeFoyN8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cGT+dc6MbvemJWS95AXu+DLB7/NhuTVSBwYKbGcmsRr2qmwU5nC4Hrk+ikF1AxshJt8KXmmLPUkk6TEmnwsvg+MXe5haVF5DJKqkJeXKi5U0ucOw/IVh3lfr5/DoiPxfO7ARA096rGCyJ4OeR2+9+kGPfUI6zmTaPq/Crf71fp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=MKVfEhiv; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=YXpVKBN9BiToiy/4lbCAxCym6dJz578L1bf4ji4j82E=; b=MKVfEhivx5BqBS2aXCL/lfNZe0
	uU+VOKAcZQ/DrK5WExHRrp219bexubougm6cYtj5jr4ohco9usyK7jWaIZlYVuJH+2itMnTyR+T+B
	1aUJwWMoZLWH1SleobPofxcniNs7wnaSCQYGfI4T38NwNCayS01iULYYrrVUCABXwechcn6qcRl5P
	oE1q4exyE9NPOdd5ZykIeukr3JONqx4EjtAEcjRpWd70I4+oTVa7nTiaXc0ECbrOkdOupL3JMP4Za
	TvdEsHlGiOp1RK/7rvD7/9vYNgLpwlIL/gnbp8MES+PHYI05p+aPZMhhhfN3OISO3Ni4UmqnuWe63
	/bJ5zcAA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1td1ei-00000006QL5-3nz0;
	Wed, 29 Jan 2025 06:34:32 +0000
Date: Tue, 28 Jan 2025 22:34:32 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] vfs dio
Message-ID: <Z5nL-NOQrAlaWNjy@infradead.org>
References: <20250118-vfs-dio-3ca805947186@brauner>
 <CAHk-=wj+uVo3sJU3TKup0QfftWaEXcaiH4aBqnuM09eUDdo=og@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wj+uVo3sJU3TKup0QfftWaEXcaiH4aBqnuM09eUDdo=og@mail.gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

[Sorry for the delay, I've been distrracted by a fun mix of personal
business and urgend customer work]

On Mon, Jan 20, 2025 at 11:24:56AM -0800, Linus Torvalds wrote:
> On Sat, 18 Jan 2025 at 05:09, Christian Brauner <brauner@kernel.org> wrote:
> >
> > Add a separate dio read align field to statx, as many out of place write
> > file systems can easily do reads aligned to the device sector size, but
> > require bigger alignment for writes.
> 
> I've pulled this, but it needs some fixing.
> 
> You added the 'dio_read_offset_align' field to 'struct kstat', and
> that structure is *critical*, because it's used even for the real
> 'stat()' calls that people actually use (as opposed to the statx side
> that is seldom a real issue).
> 
> And that field was added in a way that causes the struct to grow due
> to alignment issues.  For no good reason, because there were existing
> holes in there.

Indeed, sorry.  I put all attention on the user visible struct statx
and missed optimizing the in-kernel kstat.

> I despise the whole statx thing exactly because it has (approximately)
> five specialized users, while slowing down regular stat/fstat that is
> used widely absolutely *evertwhere*.

Yeah.  I still hate the statx design as it overload the critical
stat information with all the misc based path information that is
useful in some cases but not actually needed for most.  Not much
we can do about that now, though.


