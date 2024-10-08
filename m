Return-Path: <linux-fsdevel+bounces-31301-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBB2B99448C
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Oct 2024 11:43:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1BF4B1C249CC
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Oct 2024 09:43:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2C0918C038;
	Tue,  8 Oct 2024 09:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="FuTCWqmF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1240413AA4E;
	Tue,  8 Oct 2024 09:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728380605; cv=none; b=kX5MtnRXyAzn966lWyZ72xVpmS2ZJkLVIMEynR3yUb8BmV0Nhi4PAKR0cdJiwWLFx3iLGo8RU35fQZoKh7Xsn9VhS8rJQG470X1PgmloekosJzqQzwZvVhHKjxfEZv2FltEf0eJyO+TjNsPTOmGR4b3g4KuWIwB04hQzpLAco+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728380605; c=relaxed/simple;
	bh=yb/CDgSFZHWH4VY3TrxpXMY6jXUIkILz+Oq4q0RIpw0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ew0Rl6LbWTgNP4maRBXU2LNzCsJa69hEQotuyqxszKyIt6FzX2aPRMUrJN8OurPn5FGzCP8QAqdP04UoISwlpCx4RBJhz7gbUbBnw6LmOcqz5b1b6wERIqvC82MALWeCBa2iGiaxTdY+oS6xs4+hZA5IPCexcAryGBaq1v37XLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=FuTCWqmF; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=LsjBoeZxSr3K3xp8U1TguMhxMcrcRkzQtb3Ojs1anNU=; b=FuTCWqmFxwW5xZUnqXnpdSz27D
	d3Acw8Zoe4SnG7EyY93MzNh7iNyyKZyLLBcDDqL73R0owrtTxNcpUt5M27lwkAYRXxleg9ZQYCa/w
	MZWpTDAzabn+ZEV7vqSB5/4oGLlu+DnsjhKXjF689N2Wp/aiabmwI7z2hL4pTq2rrtxxB5wDlfpEW
	AZFuJX5ARf01KGVwOPpmX3/2sITcHMCCMJv5WsF+NIavPqDvqZ7wWoWULLy9DA+plEe12BwmRwhUI
	nZideX2v3NNY98t5RqaEu8cVhhS3cT7JM9m46xu0wbi5QqvYza6lYXuBH5n1E0nUu9Y67uoCJjmOv
	UJ7diYiA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1sy6kV-00000005Lfm-2WPT;
	Tue, 08 Oct 2024 09:43:23 +0000
Date: Tue, 8 Oct 2024 02:43:23 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Matthew Wilcox <willy@infradead.org>
Cc: Goldwyn Rodrigues <rgoldwyn@suse.de>, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: Re: [PATCH 02/12] iomap: Introduce iomap_read_folio_ops
Message-ID: <ZwT-u9v1I_gZFuQ1@infradead.org>
References: <cover.1728071257.git.rgoldwyn@suse.com>
 <0bb16341dc43aa7102c1d959ebaecbf1b539e993.1728071257.git.rgoldwyn@suse.com>
 <ZwCiVmhWm0O5paG4@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZwCiVmhWm0O5paG4@casper.infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Sat, Oct 05, 2024 at 03:20:06AM +0100, Matthew Wilcox wrote:
> On Fri, Oct 04, 2024 at 04:04:29PM -0400, Goldwyn Rodrigues wrote:
> > iomap_read_folio_ops provide additional functions to allocate or submit
> > the bio. Filesystems such as btrfs have additional operations with bios
> > such as verifying data checksums. Creating a bio submission hook allows
> > the filesystem to process and verify the bio.
> 
> But surely you're going to need something similar for writeback too?
> So why go to all this trouble to add a new kind of ops instead of making
> it part of iomap_ops or iomap_folio_ops?

We really should not add anything to iomap_ops.  That's just the
iteration that should not even know about pages.  In fact I hope
to eventuall get back and replace it with a single iterator that
could use direct calls for the fast path as per your RFC from years
ago.

iomap_folio_ops is entirely specific to the buffered write path.

I'm honestly not sure what the point is of merging structures specific
to buffered read, buffered write (and suggested later in the thread
buffered writeback) when they have very little overlap.

