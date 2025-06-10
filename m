Return-Path: <linux-fsdevel+bounces-51090-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C42BBAD2C2E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Jun 2025 05:39:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 171E218914BA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Jun 2025 03:39:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A60225D1FB;
	Tue, 10 Jun 2025 03:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="rvSCE2k8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9118321883E;
	Tue, 10 Jun 2025 03:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749526768; cv=none; b=hxTS295qtmF3yIIb+ZjbUTZ1Zo0xFR9XKKhOOlr/Rz768DBws6+WyvWJJsbakUtiE4Kba8ltCuOhcpS8xClD0g/QPcX8fxl8lxSU9r0Y+Ftib97UlC9ErRnV91jga0RZvOjyjoYxoQW5FgLDFTpFTYmL/s9FTFqgdwk/QU151XA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749526768; c=relaxed/simple;
	bh=WFlW/++qHGMPwJfahFxJu2UAhr+WVq1zZtHELuxTUb8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GRUB+guL/d98GjgcqrLDjrAMALxnRNuFmttZQZ+IklOlNzlADbi1uPbE+C5hLJEPa+E89y/1aQBIwLQiuv3ExtSSYRXj3woN5ZP3QsP/Sla49VfIRE7QflJdVTInna7IelAtrzZqu5LdW2sSA0T4Bycr2fzqYeD8uO6z8h1W3pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=rvSCE2k8; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=GhStOomvkpU2vBUhXEJJZYGj7m3d8RJgB0w4RTLq+3s=; b=rvSCE2k83MoeULFUBgac25EBFZ
	IOhRpwLdC4unAgoYjuIoNvZqBF8s4WGQbARWf92lJFmZpqLjrGjNrRpRiJZGtzHeLhtyZjYPyyEDQ
	/7qhwrw6opuEfSoRibr+tLb4uhV4NzYBvmhGYMTD/zsVgdl1sq6Fu9CQLIyzNMn3ibmrFZbpVYH0g
	bJ9kB8ZM6q13mA1CB84TvKZ4fufc1q2gmTbyAaI96sb8uY/rbP7F+Av21/l3rv2UYQ4FN2wuWaSm+
	Q/nzTSoI2QvS/W8EVCWENe8PheGmgDVc3DF2QApxnL/hsVk2UbOomSJebtEh/gj9xDDqkStSFLdzL
	4L/9G1BA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uOppd-00000005h1E-3VVJ;
	Tue, 10 Jun 2025 03:39:25 +0000
Date: Mon, 9 Jun 2025 20:39:25 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: Christoph Hellwig <hch@infradead.org>, miklos@szeredi.hu,
	djwong@kernel.org, brauner@kernel.org,
	linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
	bernd.schubert@fastmail.fm, kernel-team@meta.com
Subject: Re: [PATCH v1 2/8] iomap: add IOMAP_IN_MEM iomap type
Message-ID: <aEeo7TbyczIILjml@infradead.org>
References: <20250606233803.1421259-1-joannelkoong@gmail.com>
 <20250606233803.1421259-3-joannelkoong@gmail.com>
 <aEZm-tocHd4ITwvr@infradead.org>
 <CAJnrk1Z-ubwmkpnC79OEWAdgumAS7PDtmGaecr8Fopwt0nW-aw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJnrk1Z-ubwmkpnC79OEWAdgumAS7PDtmGaecr8Fopwt0nW-aw@mail.gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Mon, Jun 09, 2025 at 02:45:34PM -0700, Joanne Koong wrote:
> IOMAP_INLINE is the closest in idea to what I'm looking for in that
> it's completely independent from block io, but it falls short in a few
> ways (described in the reply to Darrick in [1]). In terms of
> implementation logic, IOMAP_MAPPED fits great but that's tied in idea
> to mapped blocks and we'd be unable to make certain assertions (eg if
> the iomap type doesn't use bios, the caller must provide
> ->read_folio_sync() and ->writeback_folio() callbacks).

Well, IFF we end up with both my proposals those two are the clean
abstractions between the generic and block-level code and everyone
is using them.  Let's see how that plays out.  I'd rather have a strong
abstraction like that if we can and not add new types for what is
essentially the same.

Btw, for zoned XFS, IOMAP_MAPPED also doesn't have a block number
assigned yet and only actually does the I/O in the submit_ioend method.


