Return-Path: <linux-fsdevel+bounces-73881-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D55A1D228B0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jan 2026 07:22:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C65E5302035E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jan 2026 06:22:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B4AB238D22;
	Thu, 15 Jan 2026 06:22:00 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF00B227B8E;
	Thu, 15 Jan 2026 06:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768458120; cv=none; b=bAxYz2N9YjSBSjhK+W2CExg2MVV74vePhkCwVDp9L5bzdeeuLGVvjpM4q/91iMp+imWAt6JKRzs+P8EWNOg3KWQ6jwYRy10Thgs1j6R88OXDJceuD2q5rjlYqgDGQEp9ANo9QLdHz9n/VNowfmzlgaJzcYQ+PDduiW/WLks/YLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768458120; c=relaxed/simple;
	bh=LBZnbUCG2n5MKf+sKB3u7RO8l64A7wgB4Y53oG9d8Qs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cGt7o+AbNer1W5DsYuzGDSacsA+6FFxKwi7czmXwRCGO0agWWdDzq3JNAcq5zT8prv+nDNy5+Jz6KK9tU+4J6FHwW/lGGcXdeIseUZE9p6hfq1UFp+IGAkIBZ5qSFmpspw3BDovXRDOVUoXpL8d7JiZahsaQCPkpjDN/D0v+izY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 194BC227AA8; Thu, 15 Jan 2026 07:21:55 +0100 (CET)
Date: Thu, 15 Jan 2026 07:21:55 +0100
From: Christoph Hellwig <hch@lst.de>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	Christian Brauner <brauner@kernel.org>,
	Carlos Maiolino <cem@kernel.org>, Qu Wenruo <wqu@suse.com>,
	Al Viro <viro@zeniv.linux.org.uk>, linux-block@vger.kernel.org,
	linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 13/14] iomap: add a flag to bounce buffer direct I/O
Message-ID: <20260115062155.GH9205@lst.de>
References: <20260114074145.3396036-1-hch@lst.de> <20260114074145.3396036-14-hch@lst.de> <20260114225944.GR15551@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260114225944.GR15551@frogsfrogsfrogs>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, Jan 14, 2026 at 02:59:44PM -0800, Darrick J. Wong wrote:
> On Wed, Jan 14, 2026 at 08:41:11AM +0100, Christoph Hellwig wrote:
> > Add a new flag that request bounce buffering for direct I/O.  This is
> > needed to provide the stable pages requirement requested by devices
> > that need to calculate checksums or parity over the data and allows
> > file systems to properly work with things like T10 protection
> > information.  The implementation just calls out to the new bio bounce
> > buffering helpers.
> > 
> > Signed-off-by: Christoph Hellwig <hch@lst.de>
> 
> This seems pretty sensible, assuming bio_iov_iter_bounce does what I
> think it does (sets up the bio with the bounce buffer pages instead of
> the user-backed pages for a zero-copy IO) right?

Yes.


