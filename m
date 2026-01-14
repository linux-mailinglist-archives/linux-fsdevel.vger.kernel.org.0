Return-Path: <linux-fsdevel+bounces-73616-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E1105D1CB40
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jan 2026 07:44:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E38B6300B93E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jan 2026 06:44:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61C5436C5B5;
	Wed, 14 Jan 2026 06:44:07 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDDD736E462;
	Wed, 14 Jan 2026 06:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768373041; cv=none; b=KCpQvmolYfCO72PIQhEZuQRrVyCQE3udRUcspPd7ynrllzPjcRrW2jOLjHQBP8y5TEBS+TGCQSvMfPwZFLFi1/Wxtf3cipwKV7sbnyaCQK6A2r8zzS+8f8BqnK4WRLbVHdmG7J3a7SeP37K4EFc/5zeMJHAgWxZHI+XdOTPpUU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768373041; c=relaxed/simple;
	bh=gVfsxtXPMoqElrqaq3KzMBvIa7HmILmNT8Z/tcwvqfI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oGFN27hG8ZTvcqSWTYF4LcDM54Syc75M1bJHQ1gPl8piw/4X0O4CYMjP75OYo2PMSv6gOKf/YxY+XcU1oXqzio/OqIFfNgo0Ven52Bt3wG1xucIx0wGr4Sr7NLBuAK6NakXr5Sx6nymFcgBRPv5NEaHb23TLOKhtSmEhAFxgSQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id ACB1D227A8E; Wed, 14 Jan 2026 07:43:50 +0100 (CET)
Date: Wed, 14 Jan 2026 07:43:50 +0100
From: Christoph Hellwig <hch@lst.de>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>,
	Andrey Albershteyn <aalbersh@redhat.com>, fsverity@lists.linux.dev,
	linux-xfs@vger.kernel.org, ebiggers@kernel.org,
	linux-fsdevel@vger.kernel.org, aalbersh@kernel.org,
	david@fromorbit.com
Subject: Re: [PATCH v2 11/22] xfs: add verity info pointer to xfs inode
Message-ID: <20260114064350.GC10876@lst.de>
References: <cover.1768229271.patch-series@thinky> <7s5yzeey3dmnqwz4wkdjp4dwz2bi33c75aiqjjglfdpeh6o656@i32x5x3xfilp> <20260112223938.GM15551@frogsfrogsfrogs> <20260113082158.GF30809@lst.de> <20260113180213.GX15551@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260113180213.GX15551@frogsfrogsfrogs>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, Jan 13, 2026 at 10:02:13AM -0800, Darrick J. Wong wrote:
> > Well, I suggested just making the fsverity_info a standalone object,
> > and looking it up using a rhastable based on the ino.  Eric didn't
> > seem overly existed about that, but I think it would be really helpful
> > to not bloat all the common inodes for fsverity.
> 
> Oh, right, now I remember you asking about using rhashtable to map an
> xfs_inode to a fsverity_info.  I wonder how much of a performance
> overhead that lookup (vs. the pointer deref that's used now) would have
> for loading folios into the pagecache.

If we have to do that on every folio it would suck.  But if we rework
the code to only do it once per operation it should be close to
noise.


