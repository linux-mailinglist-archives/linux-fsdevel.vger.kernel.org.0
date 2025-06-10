Return-Path: <linux-fsdevel+bounces-51098-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 046E8AD2C68
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Jun 2025 06:06:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24F723A042B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Jun 2025 04:06:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C0D825D52D;
	Tue, 10 Jun 2025 04:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="QKoU657F"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96149184F;
	Tue, 10 Jun 2025 04:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749528397; cv=none; b=j24+gkC+3HdFvWdtGvd4MlqMuPLn+Qz3svv/UVEzfT4Wqo68KAxnsQG81g4p04P+QtxgkHuLRofGKFr+aOXgEYXlRYMk/MjazVTi3j29LJyA3O2+07/ZjPAtfLwo5V481d4tTWdg5sdylZPhR6GzQaAQTCed3lFK+AD9nkdSSBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749528397; c=relaxed/simple;
	bh=2HkZzSetATOCLv+YkYjMvyo0RbCgQOYAJEeIIIUcW40=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZSIO6PqndsM2L02OILEwJ/odocIepzOX5tIZtugSQ9EH66GnKggRpW3ZsX12FZqYbeS1SWDD5e4S+CZ7T+QN/Pmz4wbXZTWRc9vdWai9fOOi5TktoOZV49QNoOjwqJVQu7v7MW+VAPJEA5Qs37vnKMt9YrLuS4mEL5hEsYaS8m0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=QKoU657F; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=AUMRLjrvng95lJXQW/V2UY+YKANow7HWOWLgZomMeVk=; b=QKoU657FBpay/TJo7rSQ7IGJ5O
	9vl/nmBFFZV6jFry29o/GakZx7hr2FtDTSKBF1Ojy0+YBGFrJIEynXwsThCXYPY6WvBE6+6Iahook
	aKSbm0tDsrXGAA7awpDzklL3jyJEPIeI/BgLkgrcViFz+YaatMfNbXKV/nqM5nTnotA9+oPRoS5eV
	0t8eL3EnQbz/IoaTfE63wPPiSqnwhSd0mBLGEyztR4XUi4x2ccPZbGg5azpkVA03nw64sFMplg/R4
	W4r7/PpXwUn4rnDXPF6HstQ5mS/qM7+i3tK9P1Dw0ZCres08BSjl4uw1qxxX6J10Touy+hbnUmhQE
	/Nval7vw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uOqFv-00000005j1V-2JWk;
	Tue, 10 Jun 2025 04:06:35 +0000
Date: Mon, 9 Jun 2025 21:06:35 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Dave Chinner <david@fromorbit.com>
Cc: Joanne Koong <joannelkoong@gmail.com>, miklos@szeredi.hu,
	djwong@kernel.org, brauner@kernel.org,
	linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
	bernd.schubert@fastmail.fm, kernel-team@meta.com
Subject: Re: [PATCH v1 0/8] fuse: use iomap for buffered writes + writeback
Message-ID: <aEevS9OHxZ0YAR74@infradead.org>
References: <20250606233803.1421259-1-joannelkoong@gmail.com>
 <aEeAqxUfFxepmQle@dread.disaster.area>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aEeAqxUfFxepmQle@dread.disaster.area>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Tue, Jun 10, 2025 at 10:47:39AM +1000, Dave Chinner wrote:
> AFAICT, this is just adding a synchronous "read folio" and "write
> folio" hooks into iomapi that bypass the existing "map and pack"
> bio-based infrastructure. i.e. there is no actual "iomapping" being
> done, it's adding special case IO hooks into the IO back end
> iomap bio interfaces.
> 
> Is that a fair summary of what this is doing?
> 
> If so, given that FUSE is actually a request/response protocol,
> why wasn't netfs chosen as the back end infrastructure to support
> large folios in the FUSE pagecache?
> 
> It's specifically designed for request/response IO interfaces that
> are not block IO based, and it has infrastructure such as local file
> caching built into it for optimising performance on high latency/low
> bandwidth network based filesystems.

Has it?  Or was that part of netfs simply written because Dave
didn't listen when I explained him that the iterate over file range
part of iomap is perfectly fine for network file systems?  I'd still
like to see that part of networking file systems moved over to iomap,
and I think it will have to happen if netfs wants to add nfs support.
Because with nfs we can suddently end up in the block I/O path for
a nominal network file system in the block layout, and that could
reuse all the existing iomap code..


