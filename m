Return-Path: <linux-fsdevel+bounces-60989-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C0A6B53FBE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Sep 2025 03:14:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A40A21B26FEC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Sep 2025 01:15:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 376997DA66;
	Fri, 12 Sep 2025 01:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WYBCVkGc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7500D56B81;
	Fri, 12 Sep 2025 01:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757639674; cv=none; b=VTFL3iLMlB6IYk/SPdCbwVbpajsmmWgAVNKudGNio1EYOkOF60Dn0TzOowGdYTuuQcasipIc9PPDtxPF9YeHXGF///pc3Aau/Sr2uiivPPGU4X8n9HiN6NsBRsEAs9xujxxpai1dK5q3lADXjR3602b49NXPLn7j1UsjgfMu2ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757639674; c=relaxed/simple;
	bh=lNzRuycIBl5ufDCs97QnXymPTsFsl8+QvZw+IB29ows=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LWJMQUZT0Q8uG116oRcf8RJ2eTm1htmEKxwlU9OavGajpcJGO1POE+NsUibSS2yI1pIbyZgq7GlNwE9tiGm34BUpulzSlJNUVOELzgNDppCAveO4HvXsxuZU/ZLVR894eLGtCoSgi8FX2nXaBKFlBQ4ec0bgx+r4UMgboiMPZP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WYBCVkGc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D75F6C4CEF0;
	Fri, 12 Sep 2025 01:14:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757639673;
	bh=lNzRuycIBl5ufDCs97QnXymPTsFsl8+QvZw+IB29ows=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WYBCVkGcMuBOGeFURrUK2aIoiHkdKfgj+E9d+UreyD87vxzUg4W30zSrb70fkmkct
	 1tVdyPIL9W5gaI+6xOSaSG58jNfrsEbltfe42xTOlIwdCcaSX/uzr6+HHZDPDKSRla
	 e2e/i2ivwOrneRotXuuazQiPgoqIhxdvmYBmvkFH5vl9Bn/OVUh27Z/bSyEUw18j9j
	 162ywONXZwPB3JqafUzRdP11pPW+xa9RbsiZC4FZKsyk1ko4siBFUtqmA2N3nOxUXA
	 3sOFbn6Xt9XjYn+P72Mf9KiIdY7YoNCzvUROMTv/WBh0fnR0bdL2Fiiw5eR3GzGFdm
	 ZgHffs6+SABeg==
Date: Thu, 11 Sep 2025 18:14:33 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Andrey Albershteyn <aalbersh@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>, fsverity@lists.linux.dev,
	linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
	david@fromorbit.com, ebiggers@kernel.org,
	Andrey Albershteyn <aalbersh@kernel.org>
Subject: Re: [PATCH RFC 02/29] iomap: introduce iomap_read/write_region
 interface
Message-ID: <20250912011433.GH1587915@frogsfrogsfrogs>
References: <20250728-fsverity-v1-0-9e5443af0e34@kernel.org>
 <20250728-fsverity-v1-2-9e5443af0e34@kernel.org>
 <20250729222252.GJ2672049@frogsfrogsfrogs>
 <20250811114337.GA8850@lst.de>
 <pz7g2o6lo6ef5onkgrn7zsdyo2o3ir5lpvo6d6p2ao5egq33tw@dg7vjdsyu5mh>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <pz7g2o6lo6ef5onkgrn7zsdyo2o3ir5lpvo6d6p2ao5egq33tw@dg7vjdsyu5mh>

On Tue, Sep 09, 2025 at 02:30:14PM +0200, Andrey Albershteyn wrote:
> On 2025-08-11 13:43:37, Christoph Hellwig wrote:
> > On Tue, Jul 29, 2025 at 03:22:52PM -0700, Darrick J. Wong wrote:
> > > ...and these sound a lot like filemap_read and iomap_write_iter.
> > > Why not use those?  You'd get readahead for free.  Though I guess
> > > filemap_read cuts off at i_size so maybe that's why this is necessary?
> > > 
> > > (and by extension, is this why the existing fsverity implementations
> > > seem to do their own readahead and reading?)
> > > 
> > > ((and now I guess I see why this isn't done through the regular kiocb
> > > interface, because then we'd be exposing post-EOF data hiding to
> > > everyone in the system))
> > 
> > Same thoughts here.  It seems like we should just have a beyond-EOF or
> > fsverity flag for ->read_iter / ->write_iter and consolidate all this
> > code.  That'll also go along nicely with the flag in the writepage_ctx
> > suggested by Joanne.
> > 
> 
> In addition to being bound by the isize the fiemap_read() copies
> data to the iov_iter, which is not really needed for fsverity. Also,
> even on fsverity systems this function will not be called on the
> fsverity metadata, not sure how much overhead these checks would add
> but this is probably not desired anyway.
> 
> Is adding something like fiemap_fetch or fiemap_read_unbound to just
> call filemap_get_pages() would be better? A filemap_read() without
> isize check and copying basically

TBH I've started wondering if what fsverity wants is filemap_fault(),
but with a special flag that enables faults beyond EOF.  After all, it
creates a folio, reads the data from disk, and returns a locked folio.

> The write path seems to be fine, adding kiocb->ki_flags and
> iomap_iter->flags flag to work beyond EOF to skip inode size updates
> in iomap_write_iter() seems to be enough.

<nod>

--D

> -- 
> - Andrey
> 
> 

