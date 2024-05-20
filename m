Return-Path: <linux-fsdevel+bounces-19801-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 50C558C9D88
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 May 2024 14:40:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8231B1C231E4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 May 2024 12:40:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28FD655E53;
	Mon, 20 May 2024 12:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="29ZpxJSn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1934156B95;
	Mon, 20 May 2024 12:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716208809; cv=none; b=tMw26AzFsKhC+r6uVwtgRfWKnSJ2ocrCHhxUGbfdv6sGBUjEaQW2XtXquQCCVlGs6u4IYq8zaSz2rJqiiFaeQEY0UshKhtXBqFZ0YFd9XhgeB1fwTfR2VI4a+nOURQDtOiqMsAtEo2MNSMMqQEHemWSbo+fEI0EpFaWwGnOFta4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716208809; c=relaxed/simple;
	bh=UHuJp186W8hPuQ0ApjYWHKIEpdT5Jpa7PNQ4ZgrHTZA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=itDBK/c4AxnIbjykyAxKRCrGkl8AeD+mKnvgA4Ziys+aOeKnYn67ZQrl7thdxAHznksBHKhtlveSZLj0od/eWxNZGSU+c24cNdblPJ1Oh0nTDIRvhaN4raS4oGth93jlQk85NdPHaMp7ESHYa+M8s7toTPlPg+mXRqD2nu6tLLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=29ZpxJSn; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=qHlixz9bFfcZf4eMGD0ltC5/B7X3PK4eEszEI6XMsCE=; b=29ZpxJSn2kOch3TPgW5Pby4OKP
	IEyDs8e80+nKAbHa8oAKH9HS0roNE+dQV5HgbbcDG9L2RLO/NBP2MLqnxN4tSW/QmFM/oO/Ntl9Pr
	i6hxglgpGYBEMfTVHhzic1zowMPaz/Srbx121DmSk75BhpqeSSim7Qvw7jKANk8YdxUEW2aFOSVHx
	wsKkYBKoe1b/GR1LgBWh8oaqgDJdxRk3s/9Jvxo19FbNkqqrMlpf1zSnM0G818LcRKBSccn+Uo82z
	G5s+7Sfb/cJReyQuxN0WAEmxK0IM09yH3a7IR8i9WuZ8awKr68t/KxXRdGLKlvHdQFGQonEqxvBWS
	W/Zx3QOA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s92J5-0000000ETTm-3J1x;
	Mon, 20 May 2024 12:39:59 +0000
Date: Mon, 20 May 2024 05:39:59 -0700
From: Christoph Hellwig <hch@infradead.org>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>, aalbersh@redhat.com,
	ebiggers@kernel.org, linux-xfs@vger.kernel.org, alexl@redhat.com,
	walters@verbum.org, fsverity@lists.linux.dev,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 18/26] xfs: use merkle tree offset as attr hash
Message-ID: <ZktEn5KOZTiy42c8@infradead.org>
References: <ZjHmzBRVc3HcyX7-@infradead.org>
 <ZjHt1pSy4FqGWAB6@infradead.org>
 <20240507212454.GX360919@frogsfrogsfrogs>
 <ZjtmVIST_ujh_ld6@infradead.org>
 <20240508202603.GC360919@frogsfrogsfrogs>
 <ZjxY_LbTOhv1i24m@infradead.org>
 <20240509200250.GQ360919@frogsfrogsfrogs>
 <Zj2r0Ewrn-MqNKwc@infradead.org>
 <Zj28oXB6leJGem-9@infradead.org>
 <20240517171720.GA360919@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240517171720.GA360919@frogsfrogsfrogs>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Fri, May 17, 2024 at 10:17:20AM -0700, Darrick J. Wong wrote:
> >   Note that the verity metadata *must* be encrypted when the file is,
> >   since it contains hashes of the plaintext data.
> 
> Refresh my memory of fscrypt -- does it encrypt directory names, xattr
> names, and xattr values too?  Or does it only do that to file data?

It does encrypt the file names in the directories, but nothing in
xattrs as far as I can tell.

> And if we copy the ext4 method of putting the merkle data after eof and
> loading it into the pagecache, how much of the generic fs/verity cleanup
> patches do we really need?

We shouldn't need anything.  A bunch of cleanup and the support for not
generating a hash for holes might still be nice to have, though.


