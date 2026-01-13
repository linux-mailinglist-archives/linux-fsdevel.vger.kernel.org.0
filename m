Return-Path: <linux-fsdevel+bounces-73383-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 58C02D1742B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jan 2026 09:23:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AE5CF300E7CE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jan 2026 08:23:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 900A237FF66;
	Tue, 13 Jan 2026 08:23:21 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F4EB325702;
	Tue, 13 Jan 2026 08:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768292601; cv=none; b=bE0/X6RH86XtBdfWgx9VZ34etOC0Vxf99SQPWf08r208Nh/n5dFt5sXqI3nMeeWm+QJFGLcIllP7wxFVzcSZqb0hYYi6lPXIpf1rtA5TTRHeDQRfJ8iDUDTyav0YxQPf/brWZygkAYqdaXxX99CG76Jb14ODHOxln5bkCMeBxR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768292601; c=relaxed/simple;
	bh=GC1CICbQxG9sXox+12DlX0tigudyasXgmlKq5tVLDKA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j7ggZ41hN9wXvQdb1TtzQcEE4T2MgX8teMggv5MP+7UnG63ydPxo7+JjNkNSGfr7kOk7jn5vcUfj/6MV5cmTtq7d9cnql17PRriKXX//i+hX6luzRRH+O4n89Pl2aKTL3a8BEPfaa2YywcU7oW2b8pYdEiVSLxgmTGosWnxiu4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 7BC85227AA8; Tue, 13 Jan 2026 09:23:17 +0100 (CET)
Date: Tue, 13 Jan 2026 09:23:17 +0100
From: Christoph Hellwig <hch@lst.de>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Andrey Albershteyn <aalbersh@redhat.com>, fsverity@lists.linux.dev,
	linux-xfs@vger.kernel.org, ebiggers@kernel.org,
	linux-fsdevel@vger.kernel.org, aalbersh@kernel.org,
	david@fromorbit.com, hch@lst.de
Subject: Re: [PATCH v2 15/22] xfs: add writeback and iomap reading of
 Merkle tree pages
Message-ID: <20260113082317.GG30809@lst.de>
References: <cover.1768229271.patch-series@thinky> <bkwfiiwnqleh3rr3mcge2fx6uucvvj2qzyl3sbzgb4b4sbjm27@nw2i3bz7xvrr> <20260112225121.GQ15551@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260112225121.GQ15551@frogsfrogsfrogs>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Jan 12, 2026 at 02:51:21PM -0800, Darrick J. Wong wrote:
> > +			wpc.ctx.iomap.flags |= IOMAP_F_BEYOND_EOF;
> 
> But won't xfs_map_blocks reset wpc.ctx.iomap.flags?
> 
> /me realizes that you /are/ using writeback for writing the fsverity
> metadata now, so he'll go back and look at the iomap patches a little
> closer.

The real question to me is why we're doing that, instead of doing a
simple direct I/O-style I/O (or even doing actual dio using a bvec
buffer)?


