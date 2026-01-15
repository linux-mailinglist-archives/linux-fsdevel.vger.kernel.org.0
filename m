Return-Path: <linux-fsdevel+bounces-73879-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 514BCD2289E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jan 2026 07:21:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 40E3430477C2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jan 2026 06:21:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C876E22CBD9;
	Thu, 15 Jan 2026 06:21:30 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10F1F381C4;
	Thu, 15 Jan 2026 06:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768458090; cv=none; b=pLlvvqGhk47W5eq96nbGYHOnTpEQrHLmJES6G4/EsP3cR7OPzttU8H2taEO/c0JpwPjlbXEoFONdP3n4CNYzA5S983xFdHphImEmkM2KYkstUrC+mZvaF1U0LndditgCynQ6L1tLNkVUOyyvJNme5DcgfeuZ7MJX6DoGLhmcEVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768458090; c=relaxed/simple;
	bh=FkZq5f81LMlhCPrvts5b5OZ62IXBXrlbyy5O2vb5GIc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FlZbNLIlEQAgLgceu/yebwDsyMfZVmAMVVjBHYsnoMDv8eYyomP4/kjVa4hVD3jA52Q+Nul6ssW7k5FeIWx0of5QWvdQLNLU4waig4Oj5LdnnCoyZq3Is9PN4PU2ao9Y8zgK1WpMeoiDzHHFl1rsswsGC0Xh65qKQ4I0lx9fFAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 44C09227AA8; Thu, 15 Jan 2026 07:21:26 +0100 (CET)
Date: Thu, 15 Jan 2026 07:21:25 +0100
From: Christoph Hellwig <hch@lst.de>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	Christian Brauner <brauner@kernel.org>,
	Carlos Maiolino <cem@kernel.org>, Qu Wenruo <wqu@suse.com>,
	Al Viro <viro@zeniv.linux.org.uk>, linux-block@vger.kernel.org,
	linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 10/14] iomap: free the bio before completing the dio
Message-ID: <20260115062125.GF9205@lst.de>
References: <20260114074145.3396036-1-hch@lst.de> <20260114074145.3396036-11-hch@lst.de> <20260114225554.GO15551@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260114225554.GO15551@frogsfrogsfrogs>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, Jan 14, 2026 at 02:55:54PM -0800, Darrick J. Wong wrote:
> On Wed, Jan 14, 2026 at 08:41:08AM +0100, Christoph Hellwig wrote:
> > There are good arguments for processing the user completions ASAP vs.
> > freeing resources ASAP, but freeing the bio first here removes potential
> > use after free hazards when checking flags, and will simplify the
> > upcoming bounce buffer support.
> > 
> > Signed-off-by: Christoph Hellwig <hch@lst.de>
> > ---
> >  fs/iomap/direct-io.c | 15 +++++++--------
> >  1 file changed, 7 insertions(+), 8 deletions(-)
> > 
> > diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
> > index bf59241a090b..6f7036e72b23 100644
> > --- a/fs/iomap/direct-io.c
> > +++ b/fs/iomap/direct-io.c
> > @@ -213,7 +213,13 @@ static void iomap_dio_done(struct iomap_dio *dio)
> >  static void __iomap_dio_bio_end_io(struct bio *bio, bool inline_completion)
> >  {
> >  	struct iomap_dio *dio = bio->bi_private;
> > -	bool should_dirty = (dio->flags & IOMAP_DIO_DIRTY);
> > +
> > +	if (dio->flags & IOMAP_DIO_DIRTY) {
> > +		bio_check_pages_dirty(bio);
> > +	} else {
> > +		bio_release_pages(bio, false);
> > +		bio_put(bio);
> > +	}
> 
> /me wonders if we ought to set bio = NULL to make "thou shalt not touch
> bio" here explicit?  Otherwise seems it seems fine to me to make this
> change.

I guess we could do that (and could have done it before for the dio).
The compiler will optimize it away, but maybe that's a hint to the
user.  The compilers with the toned down warnings flags decided on by
the chief pinhead will be useless either way.

