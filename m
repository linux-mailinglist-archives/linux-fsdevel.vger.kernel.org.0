Return-Path: <linux-fsdevel+bounces-19092-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B58278BFCA4
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 May 2024 13:48:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E68F11C20D13
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 May 2024 11:47:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE9AC82D91;
	Wed,  8 May 2024 11:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="0LpNdWFq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 353A345018;
	Wed,  8 May 2024 11:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715168854; cv=none; b=J+PCrVE+9lP/aQnQe204Kohfp6pAldxIzHKKxId7mJcfF+SErwYJtvuANfbjzdeL0otH6DitUrFtg7ZV0uVWR76YxZok6cRnXKyss0oOQzCyUwI5jxg/QvtKgc5dZHQqA9NQu7FXhlXYIAlnPk3e6cb7dzzGWHxMwFIzQxAUXz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715168854; c=relaxed/simple;
	bh=c7Oy6733SJt51oGd4gC+K4gcfvf+OwASu3LRCiCbVGk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IUC/qPTLL8ruSRnzSj7/o+zgqxyOrrIgvCPn6TP2heMMeIXC22jS3+AaC6wM/M9LYOSI96CTNPBZoMcGTXV2W5+cc+bC/MbGMvyK40Rwvt4mp0JVP/WOgno2aSwVSQolpG9VZPS5Mtw/kEBcmtZOLVbU3o7F6IkEh+HvYAOstVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=0LpNdWFq; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=RhHKULr2bJfNeye9fh2HqXISoVW0A/VhIWMLbtnkpcA=; b=0LpNdWFqCU/SlI5BGzEd9nHFm1
	fP1GzUFAureYCy1SiyTiWp4Aj6xH5TzP5U4OBXvkxdWJq/SQ0t29ift77BE+L+5gwlH8ACT+WOBRw
	Q3uIFpcTSaat1jqfjWqugSXaL7Hemn9ECrRsVN3l9uTtvZF1/7bzpAD90uQ2JJuV9vg+LGgCwsBt2
	YmClkUJR87fHxC0UJgE1jC5BAZIXc+sNHjLJ431CmNzjX34cBTd4FnfxgcCO4EiFIj1fDmjv9MqFy
	RyDZntqQwSHuYv848L9Khnd11DoWQL/F34lLX7m9oiGBjA2TYo/WgSYQsvpJrAtc3LufOeA0oWyC5
	FH1UB15Q==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s4flk-0000000FKiG-2Bvw;
	Wed, 08 May 2024 11:47:32 +0000
Date: Wed, 8 May 2024 04:47:32 -0700
From: Christoph Hellwig <hch@infradead.org>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>, aalbersh@redhat.com,
	ebiggers@kernel.org, linux-xfs@vger.kernel.org, alexl@redhat.com,
	walters@verbum.org, fsverity@lists.linux.dev,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 18/26] xfs: use merkle tree offset as attr hash
Message-ID: <ZjtmVIST_ujh_ld6@infradead.org>
References: <171444680291.957659.15782417454902691461.stgit@frogsfrogsfrogs>
 <171444680671.957659.2149857258719599236.stgit@frogsfrogsfrogs>
 <ZjHmzBRVc3HcyX7-@infradead.org>
 <ZjHt1pSy4FqGWAB6@infradead.org>
 <20240507212454.GX360919@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240507212454.GX360919@frogsfrogsfrogs>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Tue, May 07, 2024 at 02:24:54PM -0700, Darrick J. Wong wrote:
> Since we know the size of the merkle data ahead of time, we could also
> preallocate space in the attr fork and create a remote ATTR_VERITY xattr
> named "merkle" that points to the allocated space.  Then we don't have
> to have magic meanings for the high bit.

Note that high bit was just an example, a random high offset
might be a better choice, sized with some space to spare for the maximum
verify data.

> Will we ever have a merkle tree larger than 2^32-1 bytes in length?  If
> that's possible, then either we shard the merkle tree, or we have to rev
> the ondisk xfs_attr_leaf_name_remote structure.

If we did that would be yet another indicator that they aren't attrs
but something else.  But maybe I should stop banging that drum and
agree that everything is a nail if all you got is a hammer.. :)

> 
> I think we have to rev the format anyway, since with nrext64==1 we can
> have attr fork extents that start above 2^32 blocks, and the codebase
> will blindly truncate the 64-bit quantity returned by
> xfs_bmap_first_unused.

Or we decide the space above 2^32 blocks can't be used by attrs,
and only by other users with other means of discover.  Say the
verify hashes..


