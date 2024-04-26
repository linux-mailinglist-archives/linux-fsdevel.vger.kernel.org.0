Return-Path: <linux-fsdevel+bounces-17862-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BAE138B30CE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Apr 2024 08:53:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EDE8F1C21CF2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Apr 2024 06:53:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E20813AA59;
	Fri, 26 Apr 2024 06:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="KPdTy62P"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5322139D01;
	Fri, 26 Apr 2024 06:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714114387; cv=none; b=Vz88J79x9YGTl1iWiV6qiwlOop8QHsn9QeDkjxvJmqHWiiHsqrQ9N3qamoHMsTcZcdth2yOe4lxfnb0tKA4TGrAVRECCgVxCh95SsRo2fyoSLZtqt/CqG/laeKww0j7sQqXpSzFyzLjRpg/FB6H+Z+RR2DRGnDlNVgiy8vbhX6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714114387; c=relaxed/simple;
	bh=wsWlz+RmAoU/Qolc3CydR+Ewh8fvdZ1OlSpIN8IRCCk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IkZWgli61DKEwvUdu6VaB4fZlhcpW3hHgcEEs+0rn1eVDybmVmwRvXTvKYgyZZQ29BlQvPZcqVvlL2MqgxyUA7mIWzmU1ZNn+ncvD4jF5Kk0XRxJQICENRS5cfIceVWWIrDtMag2wXa49YsC6W3PieCuxa1FU7Yu9YeF1l4XESw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=KPdTy62P; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=h1Rsh4WQDC5/PQLqzzhIICfu1vVrLr3r6tmxSbYMmyA=; b=KPdTy62PIOkzatwKg+33HUpeVS
	LFxqxBvoA4mh413QtLxNtgZxZJM4fz+ZCE5AuwE9WEgkdK80Qi8+g872SiIGMpR1wcbsZjCGp/b0Q
	Aqn4p4MREifwoC3OGKJZZBBSUELSsell8EVoL4V5eroF8j1/VDYQ55lu8XA0jorZviLlgjmSlcg4x
	BGbC91CFY1iNKAoyOjT7bQSkipGX7RqJaUMUDGDr1PKDtZ45c+JSRqmwsEO9fa9EXJiVBtMDLyNVZ
	5tjpNa7xNreJDFOVQXw1y+xCYZirsXMxwCRpcG+PTo1UBxWyCKFp9+WCG5jw1UZRIIfhyYzaOe/5D
	0yioCv3A==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s0FSC-0000000BN6b-3KmP;
	Fri, 26 Apr 2024 06:53:04 +0000
Date: Thu, 25 Apr 2024 23:53:04 -0700
From: Christoph Hellwig <hch@infradead.org>
To: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Cc: linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>,
	"Darrick J . Wong" <djwong@kernel.org>,
	Ojaswin Mujoo <ojaswin@linux.ibm.com>, Jan Kara <jack@suse.cz>
Subject: Re: [RFCv3 6/7] iomap: Optimize iomap_read_folio
Message-ID: <ZitPUH20e-jOb0n-@infradead.org>
References: <cover.1714046808.git.ritesh.list@gmail.com>
 <a01641c22af0856fa2b19ab00a6660706056666d.1714046808.git.ritesh.list@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a01641c22af0856fa2b19ab00a6660706056666d.1714046808.git.ritesh.list@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Thu, Apr 25, 2024 at 06:58:50PM +0530, Ritesh Harjani (IBM) wrote:
> iomap_readpage_iter() handles "uptodate blocks" and "not uptodate blocks"
> within a folio separately. This makes iomap_read_folio() to call into
> ->iomap_begin() to request for extent mapping even though it might already
> have an extent which is not fully processed.
> 
> This happens when we either have a large folio or with bs < ps. In these
> cases we can have sub blocks which can be uptodate (say for e.g. due to
> previous writes). With iomap_read_folio_iter(), this is handled more
> efficiently by not calling ->iomap_begin() call until all the sub blocks
> with the current folio are processed.

Maybe throw in a sentence here that this copies what
iomap_readahead_iter already does?

Otherwise this looks good to me modulo the offset comment from willy.

