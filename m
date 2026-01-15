Return-Path: <linux-fsdevel+bounces-73878-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AB8DD2288F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jan 2026 07:20:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7CF96301AE25
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jan 2026 06:20:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5BFD2566D3;
	Thu, 15 Jan 2026 06:20:08 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 223862222C5;
	Thu, 15 Jan 2026 06:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768458008; cv=none; b=QH+9eUXZv7uYbVYOhL1y/ZPyWgllxmjXePCusUfESolppE9KOW/RBl1J9gEHXB3avsym5rP2ADs4ocRQYBdjafQH53acBcN+d6xHl1lwPGapSFrsRrs21pt3vlOlbPEt1nwSWmTHsqEtZ7yXZaMbLSu9F7v2xbHUr4NJ0XVQiUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768458008; c=relaxed/simple;
	bh=1OQcom55KGk4xuXcm5Pm2Wdl7LNp3w3LXyohDI42sOU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZWaBzerzjTaujA3tdXHTkEzO9bh4tQO66K1Nr+wHbEwOIRYFuHK7AxRbMntxpmjT3ncygEDLktSCa6f2QAz75zAbvL+DmYaTj0CXo30jguvaLOtGzzZsD8lE+HHrOlKj3chof4YyyNKlsZPW8gq+KaLRHw4DT4k16pxTVtYpfOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 4CF13227AAD; Thu, 15 Jan 2026 07:20:02 +0100 (CET)
Date: Thu, 15 Jan 2026 07:20:01 +0100
From: Christoph Hellwig <hch@lst.de>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	Christian Brauner <brauner@kernel.org>,
	Carlos Maiolino <cem@kernel.org>, Qu Wenruo <wqu@suse.com>,
	Al Viro <viro@zeniv.linux.org.uk>, linux-block@vger.kernel.org,
	linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 07/14] iomap: simplify iomap_dio_bio_iter
Message-ID: <20260115062001.GE9205@lst.de>
References: <20260114074145.3396036-1-hch@lst.de> <20260114074145.3396036-8-hch@lst.de> <20260114225123.GL15551@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260114225123.GL15551@frogsfrogsfrogs>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, Jan 14, 2026 at 02:51:23PM -0800, Darrick J. Wong wrote:
> On Wed, Jan 14, 2026 at 08:41:05AM +0100, Christoph Hellwig wrote:
> > Use iov_iter_count to check if we need to continue as that just reads
> > a field in the iov_iter, and only use bio_iov_vecs_to_alloc to calculate
> > the actual number of vectors to allocate for the bio.
> > 
> > Signed-off-by: Christoph Hellwig <hch@lst.de>
> 
> Huh, interesting.  bio_iov_vecs_to_alloc returns 0 if the iov_iter is of
> type bvec, so I guess we'd only run the loop body once before, and with
> zero pages?  Hrmm, that doesn't seem right.
> 
> Does that mean that we could always construct a bio for the entire bvec?
> Or does that just mean that directio doesn't get called with a bvec
> iterator?
> 
> Or, basic question: what the heck is a bvec?  A bio_vec?  So perhaps
> iomap_dio_bio_iter can't be called with a bio_vec because we're
> constructing a bio, not dealing with an existing one?
> 
> <have the cold meds kicked in yet?>

bio_iov_iter_get_pages reused the passed in bio_vec (yes, _bvec stands
for an array of bio_vecs) for iov_iter_is_bvec iters.  bios haver no
real size limit, although lower layers can't deal with more than
BIO_MAX_VECS vectors in a bunch of places.

So when bio_iov_iter_get_pages calls bio_iov_bvec_set for bvec iters,
there is an implicit assumption that it has less than BIO_MAX_VECS
vectors.  We should probably make that explicit, but I'll keep that
separate from this series.

