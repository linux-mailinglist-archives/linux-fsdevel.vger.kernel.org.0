Return-Path: <linux-fsdevel+bounces-66754-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 66205C2B8B4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 03 Nov 2025 12:56:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 79D3E1882D9B
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Nov 2025 11:56:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DD68307486;
	Mon,  3 Nov 2025 11:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="2pRlR/4W"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A83FC30596F;
	Mon,  3 Nov 2025 11:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762170985; cv=none; b=k0qZ9Cg5Y7O2K87Phx+u1sbl6YP/3y+2Uw2ktknHtu/yTsvFiMOquGe7HgSFMgGfwosr5G80Tzf1LhqumWa0A0qWGWEBfT+Jro6OaeskIydgCtrpg3bWqER0YDpo/r2IOC2yvszbQ3zMikhnWTzNDaEN8/I+sV+BienMDR9+WJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762170985; c=relaxed/simple;
	bh=hObovSXmXsHjYYK4s28J0XN6UwvujywWnUkTzNR8aQE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SySLl2TKN7XYCuaSajpfIa4kYLxrdBGRVON4YzqmU0pCaZVI1g1DLLCMxsYgts5vR2dVd2nmhMHtrREb1L24zvP+dGuTE1g6Urqj1mtUuTHTQQA43BA9uKJjQFoQNHFRgT+UwFLu7vlIbsqQTjn8u7Z6dW58zMOxo4CDe9EwBYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=2pRlR/4W; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=LOUuO7p91+/QSffj09Mg+NFgANl2UDN1UByCCAmFW54=; b=2pRlR/4WaKdpb2CLAD3Rm/eyNx
	nBxDcR7u5sYUfx0OzT5qG1nkcQqsINVcTTGfXkvsqC4Rlq+UgC4chRduQZB1L/wXaRUJn+hb18M2D
	b5j/rFg5iy59qocs8vFZC0yu/wealN0WyJ2nwrIzMXhr/JAIDxg3GGpOSr+WHHw79nNvDlo9uyfCB
	AB1kNF1ZTrqd9UEJX6Ac2hQsNpeHEbGUGtHgoc2dNwQKdO4HjNF2+gtLLKgmZae20HEZ4WOyrAFdS
	Hg4b1KNI6M9M93+2n9Kk7gBPkX1T1UZx02jxWNakqEybBuI+5eL36fkGXmwwx3/1jlKo7wUwkgZcb
	VxKVS2tA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vFtAc-00000009nFc-3sTl;
	Mon, 03 Nov 2025 11:56:22 +0000
Date: Mon, 3 Nov 2025 03:56:22 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
	Askar Safin <safinaskar@gmail.com>
Subject: Re: [PATCH RFC 2/2] fs: fully sync all fses even for an emergency
 sync
Message-ID: <aQiYZqX5aGn-FW56@infradead.org>
References: <cover.1762142636.git.wqu@suse.com>
 <7b7fd40c5fe440b633b6c0c741d96ce93eb5a89a.1762142636.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7b7fd40c5fe440b633b6c0c741d96ce93eb5a89a.1762142636.git.wqu@suse.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

The emergency sync being non-blocking goes back to day 1.  I think the
idea behind it is to not lock up a already messed up system by
blocking forever, even if it is in workqueue.  Changing this feels
a bit risky to me.

On Mon, Nov 03, 2025 at 02:37:29PM +1030, Qu Wenruo wrote:
> At this stage, btrfs is only one super block update away to be fully committed.
> I believe it's the more or less the same for other fses too.

Most file systems do not need a superblock update to commit data.

> The problem is the next step, sync_bdevs().
> Normally other fses have their super block already updated in the page
> cache of the block device, but btrfs only updates the super block during
> full transaction commit.
>
> So sync_bdevs() may work for other fses, but not for btrfs, btrfs is
> still using its older super block, all pointing back to the old metadata
> and data.
> 

At least for XFS, no metadata is written through the block device
mapping anyway.


