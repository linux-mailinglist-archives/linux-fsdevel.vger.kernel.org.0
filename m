Return-Path: <linux-fsdevel+bounces-73470-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 48A62D1A334
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jan 2026 17:23:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0A51030123E0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jan 2026 16:23:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4E082EB5A9;
	Tue, 13 Jan 2026 16:23:21 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4775D23C51D;
	Tue, 13 Jan 2026 16:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768321401; cv=none; b=LAIKWwOKHrEYd/YMW4IJIqlg3c/1c8xDJyigmE8mQJVOYsxu0jYDFUj8SJk/spFTF6FU7pBVWwqOeeBxXsyDepfSPl7bZihtuU1eoICkxKARCfCSjWYWU384Vpxokcdy2Ox/1W5J601/1cBoMW3eMHlifPtzVFTho4weeTQO6J0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768321401; c=relaxed/simple;
	bh=EKdDkyhlyLijiT46I+rcfNN+S+4lL5ce4km5513Ve5I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MpOuBFywgkDlKt+RCS2hq0AH2VNNWXwuXCSyQoNO0CRfJVP0GGIMLVXNqBhDToSSbv56a6yk7WOknEI5+pjyc0aQuIvnaS7YUC5hq9yxsA9bfs7Sjhpm3EB9Lbgr8EKKCfW3fA5IHJMqkeq48DhTGYl44pyKaeG3XJ0P3hscfRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 7591767373; Tue, 13 Jan 2026 17:23:16 +0100 (CET)
Date: Tue, 13 Jan 2026 17:23:15 +0100
From: Christoph Hellwig <hch@lst.de>
To: Andrey Albershteyn <aalbersh@redhat.com>
Cc: "Darrick J. Wong" <djwong@kernel.org>, fsverity@lists.linux.dev,
	linux-xfs@vger.kernel.org, ebiggers@kernel.org,
	linux-fsdevel@vger.kernel.org, aalbersh@kernel.org,
	david@fromorbit.com, hch@lst.de
Subject: Re: [PATCH v2 5/22] iomap: integrate fs-verity verification into
 iomap's read path
Message-ID: <20260113162315.GB5287@lst.de>
References: <cover.1768229271.patch-series@thinky> <fm6mhsjqpa4tgpubffqp6rdeinvjkp6ugdmpafzelydx6sxep2@vriwphnloylb> <20260112223555.GL15551@frogsfrogsfrogs> <vwx7hktpfbdbstxloryrfwcbk373pugjeqcozm7nuvl3uykr5z@gdgmpr7pgp34>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <vwx7hktpfbdbstxloryrfwcbk373pugjeqcozm7nuvl3uykr5z@gdgmpr7pgp34>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, Jan 13, 2026 at 12:16:45PM +0100, Andrey Albershteyn wrote:
> > Also, when do we get the combination of BEYOND_EOF && HOLE?  Is that for
> > sparse regions in only the merkle tree?  IIRC (and I could be wrong)
> > fsverity still wants to checksum sparse holes in the regular file data,
> > right?
> 
> The _BEYOUND_EOF is only for fsverity metadata. This case handles
> the merkle tree tail case/end of tree. 1k fs bs 4k page 1k fsverity
> blocks, fsverity requests the page with a tree which is smaller than
> 4 fsverity blocks (e.g. 3072b). The last 1k block in the page will
> be hole. So, just zero out the rest and mark uptodate.

Can you add a comment explaining this?

> > > +#define IOMAP_POOL_SIZE		(4 * (PAGE_SIZE / SECTOR_SIZE))
> > 
> > How do we arrive at this pool size?  How is it important to have a
> > larger bio reserve pool for *larger* base page sizes?
> 
> Well, this is just a one which iomap uses by default for read pool.
> I'm not sure I know enough to optimize pool size here :)

Note that all this would go away when using ioends.


