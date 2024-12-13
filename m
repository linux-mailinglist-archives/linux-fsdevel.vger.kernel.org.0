Return-Path: <linux-fsdevel+bounces-37266-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 95BF79F03EB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Dec 2024 05:53:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D59A283011
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Dec 2024 04:53:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74C5C16EB76;
	Fri, 13 Dec 2024 04:53:10 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9750063D;
	Fri, 13 Dec 2024 04:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734065590; cv=none; b=lqxSYf0HeUUXn5quN3GRKvqaNF+0JrzXXGz0j9V61DHYAgPildAwsoDrS6x+NAI5ga67EbHZdviEj4hM4OYZTH8NWSTyXp1vkH/j5H958/ijBA4ua2m+dj0BqEVB2w1577euE+/fXst71NQ+ndYH2+tg9Fq1RorNt7htUNd/wAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734065590; c=relaxed/simple;
	bh=3ykc8m3z/lQt1IMs/hCuQiFSE4vjD+IveGfUZZSeYdw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FmfodKQgy5vg3qw8ZRHZsGoBHg+tgRYxQ52JdPNdS5HNuFKO5nOF34KeFe+eCqy0y5KLZSudyv5OIMfNQQVwHMvxLb3DEY1CjHId59NhB8/qlb8I+/yTUOcUUDdVoilDZIYXSWfRIsk2pMFZ2oBN9tcwTa4oAMlhIcKjJx1Kb5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id B085668BEB; Fri, 13 Dec 2024 05:53:05 +0100 (CET)
Date: Fri, 13 Dec 2024 05:53:05 +0100
From: Christoph Hellwig <hch@lst.de>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Christian Brauner <brauner@kernel.org>,
	Carlos Maiolino <cem@kernel.org>, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 2/8] iomap: simplify io_flags and io_type in struct
 iomap_ioend
Message-ID: <20241213045305.GF5281@lst.de>
References: <20241211085420.1380396-1-hch@lst.de> <20241211085420.1380396-3-hch@lst.de> <20241212175504.GF6678@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241212175504.GF6678@frogsfrogsfrogs>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Thu, Dec 12, 2024 at 09:55:04AM -0800, Darrick J. Wong wrote:
> > +#define IOMAP_IOEND_NOMERGE_FLAGS \
> > +	(IOMAP_IOEND_SHARED | IOMAP_IOEND_UNWRITTEN)
> 
> Hmm.  At first I wondered "Why wouldn't BOUNDARY be in here too?  It
> also prevents merging of ioends."  Then I remembered that BOUNDARY is an
> explicit nomerge flag, whereas what NOMERGE_FLAGS provides is that we
> always split ioends whenever the ioend work changes.
> 
> How about a comment?
> 
> /* split ioends when the type of completion work changes */
> #define IOMAP_IOEND_NOMERGE_FLAGS \
> 	(IOMAP_IOEND_SHARED | IOMAP_IOEND_UNWRITTEN)
> 
> Otherwise this looks fine to me.

The interesting thing about BOUNDARY is not just that it's explicit, but
also that it's one-way.  We can merge a non-BOUNDARY flag into the end
of a BOUNDARY one, just not a BOUNDARY one into the end of a non-BOUNDARY
one.

> 
> --D
> 
> > +
> >  /*
> >   * Structure for writeback I/O completions.
> >   */
> >  struct iomap_ioend {
> >  	struct list_head	io_list;	/* next ioend in chain */
> > -	u16			io_type;
> > -	u16			io_flags;	/* IOMAP_F_* */
> > +	u16			io_flags;	/* IOMAP_IOEND_* */
> >  	struct inode		*io_inode;	/* file being written to */
> >  	size_t			io_size;	/* size of the extent */
> >  	loff_t			io_offset;	/* offset in the file */
> > -- 
> > 2.45.2
> > 
> > 
---end quoted text---

