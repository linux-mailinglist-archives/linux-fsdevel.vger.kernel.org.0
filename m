Return-Path: <linux-fsdevel+bounces-18409-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A01308B860F
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 May 2024 09:23:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A2C6281586
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 May 2024 07:23:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1952B4CE1F;
	Wed,  1 May 2024 07:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="HqzsJ5hD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2074D7F;
	Wed,  1 May 2024 07:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714548184; cv=none; b=R5fwM8LOhSHHq6CqdrCO9TTk7zMZFqfgsx5VNG8UCvfFxNudXuRuclzg9mmlyn+ZdKpSbYPcshmtNrEIPOjNPwbjdP8tMMQDWiItBMlW3689BgZbMEv4431HBPr1WwKV4Cka9eWJ7MI3jII5xx0hUKxCRg3R1K1NGJSfWka/E2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714548184; c=relaxed/simple;
	bh=1rTYlGk1gYF7E0+O/sXOUUn1aaG02t2wA7Sp9vW6BtI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cUr2LgJoL6cS3XT1NOK0eSAnBlIuPETwyVccU8PASsoOI6jLhqcA7BybPQAHOiT4Mf+gX4DqCD3aRQXE1qWm2IdL0/NSTQQjIqsfi8+aVCY/hn7Mh3LrgAwd6Nj6srI31pN6tuDWhQcDOnZfs3PP4EQoONzcx4GJ41avfDDyiz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=HqzsJ5hD; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=X9CWVtLaqy8gjteyhaFY10pfToaxfnnOA2PXC7j7dcw=; b=HqzsJ5hDrvJGzwg91ZBIYh1MaI
	AfrANl7hYZoNySp90MhVvmdgbsn9hn2lm0v17PXLagv28b2HGQV3RgAN7X6lJd0tEsZEEf1ccPm34
	yDXXRJdgvTaVIj5MCOC1y/N0FNWiIA/lsXPGyj7bsprRl8tRViKe4vGzoPHCgS3qjp+ahfHidG86L
	PPSAk2p6JUZVRuZ6S+x1wA/0bWQveFdWtPs4awlExcl+Ql1dmEy7K92enmpNfRQylFLet8YQ9DxG6
	ORhDWXD509p2a6Y1uYUlB6auy3HM7xVryIA4g+9OTtwkFNSzXvJRexNsTSWtC85juKy2S2xYxUdn4
	oQ2iLMPw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s24Iw-00000008kBh-1WeP;
	Wed, 01 May 2024 07:23:02 +0000
Date: Wed, 1 May 2024 00:23:02 -0700
From: Christoph Hellwig <hch@infradead.org>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: aalbersh@redhat.com, ebiggers@kernel.org, linux-xfs@vger.kernel.org,
	alexl@redhat.com, walters@verbum.org, fsverity@lists.linux.dev,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 18/26] xfs: use merkle tree offset as attr hash
Message-ID: <ZjHt1pSy4FqGWAB6@infradead.org>
References: <171444680291.957659.15782417454902691461.stgit@frogsfrogsfrogs>
 <171444680671.957659.2149857258719599236.stgit@frogsfrogsfrogs>
 <ZjHmzBRVc3HcyX7-@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZjHmzBRVc3HcyX7-@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Tue, Apr 30, 2024 at 11:53:00PM -0700, Christoph Hellwig wrote:
> This and the header hacks suggest to me that shoe horning the fsverity
> blocks into attrs just feels like the wrong approach.
> 
> They don't really behave like attrs, they aren't key/value paris that
> are separate, but a large amount of same sized blocks with logical
> indexing.  All that is actually nicely solved by the original fsverity
> used by ext4/f2fs, while we have to pile workarounds ontop of
> workarounds to make attrs work.

Taking this a bit further:  If we want to avoid the problems associated
with the original scheme, mostly the file size limitation, and the (IMHO
more cosmetic than real) confusion with post-EOF preallocations, we
can still store the data in the attr fork, but not in the traditional
attr format.  The attr fork provides the logical index to physical
translation as the data fork, and while that is current only used for
dabtree blocks and remote attr values, that isn't actually a fundamental
requirement for using it.

All the attr fork placement works through xfs_bmap_first_unused() to
find completely random free space in the logic address space.

Now if we reserved say the high bit for verity blocks in verity enabled
file systems we can simply use the bmap btree to do the mapping from
the verity index to the on-disk verify blocks without any other impact
to the attr code.

