Return-Path: <linux-fsdevel+bounces-31886-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C7F0299C9E8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Oct 2024 14:18:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF3B61C22192
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Oct 2024 12:18:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 577951A4E8A;
	Mon, 14 Oct 2024 12:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="BdjDG8F7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63B281A38D3;
	Mon, 14 Oct 2024 12:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728908276; cv=none; b=Vm9hNqJWWfu/UX6x1/J1ZXL183uEalwWnuJQrsnnA+VQJXK9q3LxjApfsonQgHa7FIbIvveJDb+KRVRjhb4nTsf1/DMUgdUPVxFllTPl6Qmms5CFAywxPc6CEGlLJGY5lUBiAUEhblNvPkU6XKKoCInaAJzYLKFuYMsEsd7LYPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728908276; c=relaxed/simple;
	bh=ZO+CWcCVrEHAYHKo9dOKLgtmCGqGweVlz/AfDIGKwXg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rJRA3Nrpc/2X/2xXuKwAkVHX8Kvfw5sEZMrmqebkYlq+oezaRceYBuvG12O+RGVf51Has9UUYP8lmg/O7qfr+F6XYe1HtlzhcOmgmWP+bMaZX03GL9mk3I2RrmhtG46IeGT0EgDNOhnDfUyezGKqLOGMaW+7G497mBR/vXFIpZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=BdjDG8F7; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=6WGIt7R+XJfPvUXwecwb59cR8MF6Q4lw3DgJ/zWU3hU=; b=BdjDG8F7PNS22xczQwMY0hhWeR
	sSVD0Cnzh/AuvbURievjEXENwhJ+CJeSVHXVUw30ZCA7Mdlnn0qS0ewsl6mXetn/x62oK6nfk75H0
	rBLYunDsxRxGdJLtvWwMyCDLr0d/A8oCKeA1ON6l5Z8FkSnoV3d5TqMBf5u09kTjnP26y9MO+wnvm
	1E+q4OQGPLpt7+AoW5mB5DhlGmN+zvHWDPa7DE+evHGNNmDXzC1Nv8p68GyfackM6yF0xBppaVrJS
	kxrDEWElSHGXAi5QersiMYF3uBRvDMhZ7Do+AjpTn1bcwA4mne5nQijUydCCKdLe8jnNnqcGVSo4J
	x+EMNh8w==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1t0K1J-000000053Se-3P73;
	Mon, 14 Oct 2024 12:17:53 +0000
Date: Mon, 14 Oct 2024 05:17:53 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Burn Alting <burn.alting@iinet.net.au>
Cc: Christoph Hellwig <hch@infradead.org>, audit@vger.kernel.org,
	linux-security-module@vger.kernel.org, linux-nfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [RFC PATCH v1 1/7] fs: Add inode_get_ino() and implement
 get_ino() for NFS
Message-ID: <Zw0L8ZrEani3uWa5@infradead.org>
References: <ZwkgDd1JO2kZBobc@infradead.org>
 <20241011.yai6KiDa7ieg@digikod.net>
 <Zwkm5HADvc5743di@infradead.org>
 <20241011.aetou9haeCah@digikod.net>
 <Zwk4pYzkzydwLRV_@infradead.org>
 <20241011.uu1Bieghaiwu@digikod.net>
 <05cb94c0dda9e1b23fe566c6ecd71b3d1739b95b.camel@kernel.org>
 <0e4e7a6d-09e0-480d-baa9-a2e7522a088a@iinet.net.au>
 <ZwzeGausiU0IDkFy@infradead.org>
 <e0188174-a8ae-461b-b30a-bc7acd545a18@iinet.net.au>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e0188174-a8ae-461b-b30a-bc7acd545a18@iinet.net.au>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Mon, Oct 14, 2024 at 11:12:25PM +1100, Burn Alting wrote:
> > > PATH records is no longer forensically defensible and it's use as a
> > > correlation item is of questionable value now?
> > 
> > What do you mean with forensically defensible?
> 
> If the auditd system only maintains a 32 bit variable for an inode value,
> when it emits an inode number, then how does one categorically state/defend
> that the inode value in the audit event is the actual one on the file
> system. The PATH record will offer one value (32 bits) but the returned
> inode value from a stat will return another (the actual 64 bit value).
> Basically auditd would not be recording the correct value.

Does auditd only track 32-bit inodes?  If yes, it is fundamentally
broken.

> My reference to the filesystem size was a quick and dirty estimate of when
> one may see more than 2^32 inodes on a single filesystem. What I failed to
> state (my apologies) is that this presumed an xfs filesystem with default
> values when creating the file system. (A quick check on an single 240TB xfs
> filesystem advised more than 5000000000 inodes were available).

For XFS inode number encoding is sparse, with part of it encoding the
allocation group it resides in.  For btrfs for example the inode number
is simply a 64-bit monotonically increasing counter per subvolume
where freed inode numbers never get reused.

