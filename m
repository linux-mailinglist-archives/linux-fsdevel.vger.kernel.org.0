Return-Path: <linux-fsdevel+bounces-24091-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB8FB9393DD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Jul 2024 20:49:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DCC7B1C21766
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Jul 2024 18:49:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD2D8171064;
	Mon, 22 Jul 2024 18:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IBms8LWs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CE631EB26;
	Mon, 22 Jul 2024 18:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721674188; cv=none; b=mf6KTMMru+KoBhrdBWLKFKKKfrhWG7JQ2jthrCHnHWipfmnw6uclPvt8KnNaVQZ74GYN01nLxoK86DqJO25kf2Tp5O+x0V6JS7FhzM96I2juqLXw60TbO0v8ti60B14/bAw+j3blzjj3ZzKu5/zGw6pS2GRZQgKysbMgv6AghdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721674188; c=relaxed/simple;
	bh=hn2upQiYP7UVVh8YpM8DoUA/iiPMNNLXkyFWhtd6TGw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K4tftU+MkGRenaTl/3WkfckGvUabqA72JBWLj3Cu4MTT9rIm8OGGnvsK5kgeKaUZ84IRNXtyX/THhvISC8EZSo3a2IidSFnpXIzUg12s/x5/acVKdLZfqgxB0v1DUiBqbBKhy+v4ggav6W6y5mAnILQD+90/rhOqDx3pCooEb2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IBms8LWs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C150FC116B1;
	Mon, 22 Jul 2024 18:49:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721674187;
	bh=hn2upQiYP7UVVh8YpM8DoUA/iiPMNNLXkyFWhtd6TGw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IBms8LWs1INJ8qU8LQbNwfD24Z1JMH2ALkqUiz1+amOducuM+VnOFlLxwg4sSu3U+
	 XAibCPEgvlACgIljS48g6I++6RFK+HTnm32dmMc2SAxs7M7mgMkse7vfyb61ZTX6cr
	 zTAMengMyghWkM8APV0aumjr4Pyom8l/9PmMPZDcxfZ1WLpLAuuhEBRxl2RT4Tz/mt
	 /C+JeFVPa1x/DwJHd110I5P/944BxoevH2giXoQGAfnNGRwi6SvyOhlP8144j1iGb4
	 +Pq44mn9lLHInUC0ZEyG80RDIPJ34u2NNRxB82IV6hTA4NONZN7mp3xxDhxM2y4RPE
	 AjDMvrh0QZirw==
Date: Mon, 22 Jul 2024 11:49:47 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
Cc: david@fromorbit.com, willy@infradead.org, chandan.babu@oracle.com,
	brauner@kernel.org, akpm@linux-foundation.org,
	linux-kernel@vger.kernel.org, yang@os.amperecomputing.com,
	linux-mm@kvack.org, john.g.garry@oracle.com,
	linux-fsdevel@vger.kernel.org, hare@suse.de, p.raghav@samsung.com,
	mcgrof@kernel.org, gost.dev@samsung.com, cl@os.amperecomputing.com,
	linux-xfs@vger.kernel.org, ryan.roberts@arm.com, hch@lst.de,
	Zi Yan <ziy@nvidia.com>
Subject: Re: [PATCH v10 10/10] xfs: enable block size larger than page size
 support
Message-ID: <20240722184947.GJ103014@frogsfrogsfrogs>
References: <20240715094457.452836-1-kernel@pankajraghav.com>
 <20240715094457.452836-11-kernel@pankajraghav.com>
 <20240715164632.GV612460@frogsfrogsfrogs>
 <20240722141220.yfxb7jder7mqwgod@quentin>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240722141220.yfxb7jder7mqwgod@quentin>

On Mon, Jul 22, 2024 at 02:12:20PM +0000, Pankaj Raghav (Samsung) wrote:
> > > +
> > > +		if (mp->m_sb.sb_blocksize > max_folio_size) {
> > > +			xfs_warn(mp,
> > > +"block size (%u bytes) not supported; maximum folio size supported in "\
> > > +"the page cache is (%ld bytes). Check MAX_PAGECACHE_ORDER (%d)",
> > > +			mp->m_sb.sb_blocksize, max_folio_size,
> > > +			MAX_PAGECACHE_ORDER);
> > > +			error = -ENOSYS;
> > > +			goto out_free_sb;
> > 
> > Nit: Continuation lines should be indented, not lined up with the next
> > statement:
> > 
> > 			xfs_warn(mp,
> > "block size (%u bytes) not supported; maximum folio size supported in "\
> > "the page cache is (%ld bytes). Check MAX_PAGECACHE_ORDER (%d)",
> > 					mp->m_sb.sb_blocksize,
> > 					max_folio_size,
> > 					MAX_PAGECACHE_ORDER);
> > 			error = -ENOSYS;
> > 			goto out_free_sb;
> 
> @Darrick: As willy pointed out, the error message is a bit long here.
> Can we make as follows:
> 
> "block size (%u bytes) not supported; Only block size (%ld) or less is supported "\
>                                         mp->m_sb.sb_blocksize,
>                                         max_folio_size);
> 
> This is similar to the previous error and it is more concise IMO.

Ah, ok.  I suppose printing max_folio_size *and* MAX_PAGECACHE_ORDER is
redundant.  The shortened version above is ok by me.

--D

> > 
> > With that fixed,
> > Reviewed-by: Darrick J. Wong <djwong@kernel.org>
> > 
> > --D
> > 
> 

