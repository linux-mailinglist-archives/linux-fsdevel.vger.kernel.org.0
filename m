Return-Path: <linux-fsdevel+bounces-71607-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CCD7DCCA494
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Dec 2025 06:13:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3060230213CB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Dec 2025 05:13:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B88F4301022;
	Thu, 18 Dec 2025 05:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="abw4cd4g"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9C982DECC2;
	Thu, 18 Dec 2025 05:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766034819; cv=none; b=mtaeHNX10r8C32Wc8RgjIRWOAKOixfT0DS9Jzm2iWrRRtoyaW9hP0s8gScsJLVjzYaKZGhKrPuv8UXtA1CzadIDcQpv4nlKLC1tA79X0MytJmrcJcFCk+SVvcdm1sThhiUj66O43upu3ZhVsCt5e5EIlqCuSETsCOhY6uAnNUgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766034819; c=relaxed/simple;
	bh=OvirgRqoOkXLYCuyNK4qy6Yrmx3Fu4zwskutVb0rlvo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qnk3EB8KcTTMYvnFAkUMxOglc+QRUI3bAZv3+sbt62RJb+9Y21Jij521d427uTjQB09nNCJ0tCncs0rDwKoJiQtV0t2P9ABmQ2lx/04jQchpXrfTcymOEsQQgVMyMx6/sd+xEfGJ7twr76fw1zJPYGbVDEC+LhhYsxXPLwhBMX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=abw4cd4g; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=tBPJ4Mb1hzl4Z7frr1TdBSLbB+BZzWahy5/9Vf/Pvhc=; b=abw4cd4gfRFytoBJvxcSsIJHiV
	fTP+kYXIZNvnUjWwqMbMHSsaFhKWbczbKe42esy72v/t3MXfSQ6xXsBjCymYvJp5ZqqPdslnSp3Bb
	3tu8c8YMRWcl2TdxNQvYGAEekcatcBCks3TCFP/neQwiZSJSwpTY79zXS9lT8ro2FbFjt3ac3V1EH
	T87lYoHGc0PNpCz3XXc7ARnHWc2in3/+wNZqrDoI/TnSXvt/SpC9VPlksyNdaiOXAZLsRua30r/aR
	HjowRulhJm54Py/OfUl5mk5QbtfaHdpaCy6vEwEqfqlpuJWY8ab23rYZnqHGWUIkHjKTCGAZonm0d
	N3moyq9A==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vW6KF-00000007om1-3lcr;
	Thu, 18 Dec 2025 05:13:19 +0000
Date: Wed, 17 Dec 2025 21:13:19 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Matthew Wilcox <willy@infradead.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Shaurya Rane <ssrane_b23@ee.vjti.ac.in>,
	"Darrick J . Wong" <djwong@kernel.org>,
	Christoph Hellwig <hch@infradead.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Meta kernel team <kernel-team@meta.com>, bpf@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	syzbot+09b7d050e4806540153d@syzkaller.appspotmail.com
Subject: Re: [PATCH] lib/buildid: use __kernel_read() for sleepable context
Message-ID: <aUONb6wqk7Q-QxC9@infradead.org>
References: <20251218005818.614819-1-shakeel.butt@linux.dev>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251218005818.614819-1-shakeel.butt@linux.dev>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Wed, Dec 17, 2025 at 04:58:18PM -0800, Shakeel Butt wrote:
> For the sleepable context, convert freader to use __kernel_read()
> instead of direct page cache access via read_cache_folio(). This
> simplifies the faultable code path by using the standard kernel file
> reading interface which handles all the complexity of reading file data.
> 
> At the moment we are not changing the code for non-sleepable context
> which uses filemap_get_folio() and only succeeds if the target folios
> are already in memory and up-to-date. The reason is to keep the patch
> simple and easier to backport to stable kernels.
> 
> Syzbot repro does not crash the kernel anymore and the selftests run
> successfully.
> 
> In the follow up we will make __kernel_read() with IOCB_NOWAIT work for
> non-sleepable contexts. In addition, I would like to replace the
> secretmem check with a more generic approach and will add fstest for the
> buildid code.

Getting the code further away from messing with internals is good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

I do not think making IOCB_NOWAIT never wait is feasily, though for the
next step.


