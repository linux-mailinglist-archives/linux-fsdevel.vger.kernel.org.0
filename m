Return-Path: <linux-fsdevel+bounces-18401-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 913628B85B7
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 May 2024 08:53:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C30481C2224F
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 May 2024 06:53:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4241E4C624;
	Wed,  1 May 2024 06:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="e0bw+T2J"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BDD77F;
	Wed,  1 May 2024 06:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714546382; cv=none; b=Cgw2kHGL35ZFzRDVuYSbUy5Aaq1i0Y630NDNJ0qSWzZIkXTBIp3PfVCPLtpJ59cZ46e9KksKC8C42zbjupKFV88CyZbuZpDsyiWqa4joclxT8/PPT3ct1cBDN4KWjvWF+hMqNWPAM5+d/focpXnOMcdktT6wqPLqp43KEO+rTms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714546382; c=relaxed/simple;
	bh=x4/TCHTQ2CIiEU+IYP0xq4p/5qELX/wuD5aeJRl2faA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eAZitSIpQwSGNCBb2cAtXgVI4kiYdAjzF3hLG9+6GyCRKIFto4ZSxki7zLzmVBjWvKlZ1UF8QQ+zsWtx0G9H0iRfPj0K5mgsO9LhPc6DT4HZhOcCnUaVj5z8BViYYySAqIf34fepfHjtFAfn4c3PQrdIeIsEzS7Hxjlqwm9I/g8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=e0bw+T2J; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=6RPkpPeaalQOMJ0bQq2FXUwHcqT9dx3J+KM+uCCIqJ0=; b=e0bw+T2JiQLo8+byqe+bCNvSYG
	sTnhgNwBQIEYj0I2LmpwGMuv5PLMPlwKPU3qXSRJv4ZLETblw2ieCa76SiTkrlpNBBrwlgY7Ex4DW
	wjCW9UMj5wc+x5qH9CelPuAS4sqjvLNWkGNsDBwqimpWUQ/UKtoDQRKgREScg1IekjvP8jxw0+XIQ
	8jXGs7YYOAHaqGcXizFfyCRFWCMcsO1I50wSouKpjSf9hqlB9T51taO7eexFFY4qFMgjoXGKiVIX3
	ZeflSIwFD25lZ5bWlvf1YtUJ5RRawmPCuAvM70WJU+yY4qpJU2mnKHdiUN5Oj0GKcp4n7p0n4lljf
	cGZZ6Ssw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s23ps-00000008i3q-3D3m;
	Wed, 01 May 2024 06:53:00 +0000
Date: Tue, 30 Apr 2024 23:53:00 -0700
From: Christoph Hellwig <hch@infradead.org>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: aalbersh@redhat.com, ebiggers@kernel.org, linux-xfs@vger.kernel.org,
	alexl@redhat.com, walters@verbum.org, fsverity@lists.linux.dev,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 18/26] xfs: use merkle tree offset as attr hash
Message-ID: <ZjHmzBRVc3HcyX7-@infradead.org>
References: <171444680291.957659.15782417454902691461.stgit@frogsfrogsfrogs>
 <171444680671.957659.2149857258719599236.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <171444680671.957659.2149857258719599236.stgit@frogsfrogsfrogs>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Mon, Apr 29, 2024 at 08:28:48PM -0700, Darrick J. Wong wrote:
> Within just this attr leaf block, there are 76 attr entries, but only 38
> distinct hash values.  There are 415 merkle tree blocks for this file,
> but we already have hash collisions.  This isn't good performance from
> the standard da hash function because we're mostly shifting and rolling
> zeroes around.
> 
> However, we don't even have to do that much work -- the merkle tree
> block keys are themslves u64 values.  Truncate that value to 32 bits
> (the size of xfs_dahash_t) and use that for the hash.  We won't have any
> collisions between merkle tree blocks until that tree grows to 2^32nd
> blocks.  On a 4k block filesystem, we won't hit that unless the file
> contains more than 2^49 bytes, assuming sha256.
> 
> As a side effect, the keys for merkle tree blocks get written out in
> roughly sequential order, though I didn't observe any change in
> performance.

This and the header hacks suggest to me that shoe horning the fsverity
blocks into attrs just feels like the wrong approach.

They don't really behave like attrs, they aren't key/value paris that
are separate, but a large amount of same sized blocks with logical
indexing.  All that is actually nicely solved by the original fsverity
used by ext4/f2fs, while we have to pile workarounds ontop of
workarounds to make attrs work.


