Return-Path: <linux-fsdevel+bounces-62423-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D64C3B9295D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Sep 2025 20:22:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7BF552A0568
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Sep 2025 18:22:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22BED318146;
	Mon, 22 Sep 2025 18:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="34uMTFVW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CFDB221540
	for <linux-fsdevel@vger.kernel.org>; Mon, 22 Sep 2025 18:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758565321; cv=none; b=mC/W+kv0oFnYgfWhAe7M7DDxSz5zSHxwAmUuDqdd/kOERpTK19YBChfvZetbjgvio5mGLjDZ9BbWumdZ57Yzc+Hh4c+tTGkBFkZmJ4eLdECGIGCswWkjv7B8n8cGV14iDUcK08q+xT4WsAs9bKsmvJ68YCyiEEwdzljGWyrERjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758565321; c=relaxed/simple;
	bh=7gSPPBqImPDR0odY39GChKH9TkQmwsHsvvVkrM/Tkkg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sBNRex4Jim0SmHilfzGys7BmQqZA/ul+dgFG4H/vhREMQ8H0NlCvTSKbD3wATDWU37higcmXg6QrvEo3Z7p/NKLqmrFvqNaRSxeSU8R+hUlhMdXsES3yemLNABazTyWZEeHCJxbieIIubPM6XlG+YAxq/UfSUMGdTGGTre36QBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=34uMTFVW; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=wpKbPg69bTnlf0oMUMUlufYFutJ/JnWhL4XEhxsYqHI=; b=34uMTFVWT83cJviRnXfthe1nOy
	+mRV9UdWlce6gqeK8VlrGs1DnVGyQPqXcg1HPa99X//n2ZPYWG6tShovJGEhQVDWRCFKATMNBZ37n
	CSks70sKYv8AF7xDEAuciGlKqhkEw8tPFnErkHY+VEstg5VIgXBpRepAVE8iSLiNSThLUFSd6hdVC
	NI4FUahsChQnhhpuJURxcd71Rpt33Z0TO3mVd5hMjwTdhe56lnxvj5+QTPfJZCSBN5FheaDrVK91Q
	QeR13k1szRHtedIDB9SpK6mc84GkCg0sFnYHj9HWvtvHn5JapemSc7w6zRDVRNoGkCTgCqkI9I5Rp
	ME0xoCoQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v0lAl-0000000BEks-0fZA;
	Mon, 22 Sep 2025 18:21:59 +0000
Date: Mon, 22 Sep 2025 11:21:59 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: brauner@kernel.org, djwong@kernel.org, hch@infradead.org,
	bfoster@redhat.com, linux-fsdevel@vger.kernel.org,
	syzbot@syzkaller.appspotmail.com
Subject: Re: [PATCH] iomap: adjust read range correctly for non-block-aligned
 positions
Message-ID: <aNGTx1PJksPiG7uV@infradead.org>
References: <20250922180042.1775241-1-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250922180042.1775241-1-joannelkoong@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Mon, Sep 22, 2025 at 11:00:42AM -0700, Joanne Koong wrote:
> iomap_adjust_read_range() assumes that the position and length passed in
> are block-aligned. This is not always the case however, as shown in the
> syzbot generated case for erofs. This causes too many bytes to be
> skipped for uptodate blocks, which results in returning the incorrect
> position and length to read in. If all the blocks are uptodate, this
> underflows length and returns a position beyond the folio.
> 
> Fix the calculation to also take into account the block offset when
> calculating how many bytes can be skipped for uptodate blocks.
> 
> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> Tested-by: syzbot@syzkaller.appspotmail.com

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

