Return-Path: <linux-fsdevel+bounces-43214-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52955A4F728
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Mar 2025 07:33:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A4DC3AB4AB
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Mar 2025 06:33:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8D201DC9BE;
	Wed,  5 Mar 2025 06:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IaNCFNDK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FD931C8623;
	Wed,  5 Mar 2025 06:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741156412; cv=none; b=Z5DQOVaZEit8o+j2Rv2v8lIAFJnPj6/k3YcfWGPTgT+4FzOXk0gd1vZQwm7amy63kuGZIGAZfBkmsg8c/Eb020veNrg6IqjXD+8F0hTer5edLHj+WVWAS7mcHmJ9SQZLpwqekDUSwVp4IWkIWtcbD7UBy7YTJLDpUv44BSErEn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741156412; c=relaxed/simple;
	bh=rGezkjfQL9+iCNwZ5iYwZCzlv2sj94AMOHkJIg357kI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YqfIpCQbVpjYE9VIO7DWunBCyuFkH5qmgCGdT8CfD9cq29fIp9I0HG7VIFMPfCs9Pm2fEkh51vzjj+oL1A44iuXeCPfXe0zZX0oyGITyo2n4ZaU8xO6+beDrDRIZq7MYonkEcFg2MXp3bcysFUPdUZ9kENW2b96nqFbcAT+yoio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IaNCFNDK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9E13C4CEE2;
	Wed,  5 Mar 2025 06:33:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741156411;
	bh=rGezkjfQL9+iCNwZ5iYwZCzlv2sj94AMOHkJIg357kI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IaNCFNDKqFxuXSCYJd/4f1KydSvZ30CnR164WsceqycKsCoewHeT4M/jdUUdE1Q+x
	 tqwTkoe3EwCP1iSjvcsP+gUE/bsQ0y49pjfyo+v9VnpEZZ5iHLIACNE4h9sUdKR8Nh
	 /Hank0zChNpkyN5oj9DPsw1Cca/ZJoQ7wMLoHLuy39svQ+ng+/6T2nbyRRe0J2ix8L
	 QbOntuJewqr5X4X80OLBHACQ0tEMGrcEiNInxrx/9VXmi6f0gGJlh7O04xlIjpgZUv
	 J2DzWBqlymUYwMgLMXoZ2S/wpU41WeDurqqUfVBdfySCS/vT/tuxQgLZtieCpTcXX6
	 ZgMfr4CaFDp2A==
Date: Tue, 4 Mar 2025 22:33:30 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Matthew Wilcox <willy@infradead.org>
Cc: Luis Chamberlain <mcgrof@kernel.org>, brauner@kernel.org, hare@suse.de,
	david@fromorbit.com, kbusch@kernel.org, john.g.garry@oracle.com,
	hch@lst.de, ritesh.list@gmail.com, linux-fsdevel@vger.kernel.org,
	linux-block@vger.kernel.org, gost.dev@samsung.com,
	p.raghav@samsung.com, da.gomez@samsung.com, kernel@pankajraghav.com,
	Kent Overstreet <kent.overstreet@linux.dev>
Subject: Re: [PATCH] bdev: add back PAGE_SIZE block size validation for
 sb_set_blocksize()
Message-ID: <20250305063330.GA2803730@frogsfrogsfrogs>
References: <20250305015301.1610092-1-mcgrof@kernel.org>
 <Z8fpZWHNs8eI5g38@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z8fpZWHNs8eI5g38@casper.infradead.org>

On Wed, Mar 05, 2025 at 06:04:21AM +0000, Matthew Wilcox wrote:
> On Tue, Mar 04, 2025 at 05:53:01PM -0800, Luis Chamberlain wrote:
> > The commit titled "block/bdev: lift block size restrictions to 64k"
> > lifted the block layer's max supported block size to 64k inside the
> > helper blk_validate_block_size() now that we support large folios.
> > However in lifting the block size we also removed the silly use
> > cases many filesystems have to use sb_set_blocksize() to *verify*
> > that the block size < PAGE_SIZE. The call to sb_set_blocksize() can
> > happen in-kernel given mkfs utilities *can* create for example an
> > ext4 32k block size filesystem on x86_64, the issue we want to prevent
> > is mounting it on x86_64 unless the filesystem supports LBS.
> > 
> > While, we could argue that such checks should be filesystem specific,
> > there are much more users of sb_set_blocksize() than LBS enabled
> > filesystem on linux-next, so just do the easier thing and bring back
> > the PAGE_SIZE check for sb_set_blocksize() users.
> > 
> > This will ensure that tests such as generic/466 when run in a loop
> > against say, ext4, won't try to try to actually mount a filesystem with
> > a block size larger than your filesystem supports given your PAGE_SIZE
> > and in the worst case crash.
> 
> So this is expedient because XFS happens to not call sb_set_blocksize()?
> What is the path forward for filesystems which call sb_set_blocksize()
> today and want to support LBS in future?

Well they /could/ set sb_blocksize/sb_blocksize_bits themselves, like
XFS does.

Luis: Is the bsize > PAGE_SIZE constraint in set_blocksize go away?
IOWs, will xfs support sector sizes > 4k in the near future?

--D

