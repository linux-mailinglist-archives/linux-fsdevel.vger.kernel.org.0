Return-Path: <linux-fsdevel+bounces-51165-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F0075AD3965
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Jun 2025 15:36:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6890D1893D47
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Jun 2025 13:30:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FCFE29B8CF;
	Tue, 10 Jun 2025 13:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Cl9Bf2kH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F26829B78B;
	Tue, 10 Jun 2025 13:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749562152; cv=none; b=jeGyQRPsVo2GFLPSJUYCZV7P1yXnCYzbZtFWd1/qAnwCCSmwreq6UP9i/p1jI7DlyXVhOuOFsgfp99610l1Ijwdf/Byel0dU2G1yzTyKFPQglXdAGTJga0y6xqXTVoBxpFuQukp+VT5cKJHFrnuQIIPYOiQYGNn+CelB3JOAyMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749562152; c=relaxed/simple;
	bh=domkUHVehPfx76IBEd/l63OBFvXJh517vLAmlk842T0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cPL130Aw6Y8dsGGOQoiM1FmxEgD8y4Termp8tT0P6YY5dF5KBMbkJdE9ujdN55/9inaB8FfyWetiR6IIf+hd5oqezms0KEICXMCrfEfK/DMlDFOfa0jdopCed/dImBLtgC1J+CDySl48m8/VF20bX0/vLl4xa6h5QANVjBAZvT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Cl9Bf2kH; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=domkUHVehPfx76IBEd/l63OBFvXJh517vLAmlk842T0=; b=Cl9Bf2kHC7aUQRw4B05gV6P7R0
	1BXN3hWGUcPJb+K+LzQ5vkM3XY1/s65aVKRlscQMkJRrBlIe6X1PKQu6ObwUYyUGW7wyLFiaDogwf
	q1QbJD8A62XPkw8vcS6cU8+fFu7VIk8ENZNvG/cWxc12DI7QMZHcGyWwTTLW9SaVUgPIuEo7EYIKU
	jWKBZNCrQSv3X6TkBJLOswm0C3QMMxF03XmpsNfXJlnmzoAoAWLp3Ygr2/bsHhqV/8yqS74018x3v
	siZOx/Pkh7PQ+bXiI0xdiDqUdFWGrY3Gwj1OtPEuqj79LkkVbZPW5yR2U5icJYFolMZczuEqS04ep
	SdYtj2Ig==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uOz2M-00000006yAI-2cTh;
	Tue, 10 Jun 2025 13:29:10 +0000
Date: Tue, 10 Jun 2025 06:29:10 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Brian Foster <bfoster@redhat.com>
Cc: "Darrick J. Wong" <djwong@kernel.org>, linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 3/7] iomap: optional zero range dirty folio processing
Message-ID: <aEgzJgwRDsvlfhA1@infradead.org>
References: <20250605173357.579720-1-bfoster@redhat.com>
 <20250605173357.579720-4-bfoster@redhat.com>
 <20250609160420.GC6156@frogsfrogsfrogs>
 <aEgjMtAONSHz6yJT@bfoster>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aEgjMtAONSHz6yJT@bfoster>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Tue, Jun 10, 2025 at 08:21:06AM -0400, Brian Foster wrote:
> Yes.. but I'm not totally sure wrt impact on the fbatch checks quite
> yet. The next thing I wanted to look at is addressing the same unwritten
> mapping vs. dirty folios issue in the seek data/hole path. It's been a
> little while since I last investigated there (and that was also before
> the whole granular advance approach was devised), but IIRC it would look
> rather similar to what this is doing for zero range. That may or may
> not justify just making the batch required for both operations and
> potentially simplifying this logic further. I'll keep that in mind when
> I get to it..

On thing that the batch would be extremely useful for is making
iomap_file_unshare not totally suck by reading in all folios for a
range (not just the dirty ones) similar to the filemap_read path
instead of synchronously reading one block at a time.


