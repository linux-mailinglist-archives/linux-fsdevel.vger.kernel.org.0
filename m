Return-Path: <linux-fsdevel+bounces-58112-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A7BCB29890
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Aug 2025 06:43:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6147F205811
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Aug 2025 04:42:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20850265296;
	Mon, 18 Aug 2025 04:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="S2APeri8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E6CB1D9A5D;
	Mon, 18 Aug 2025 04:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755492082; cv=none; b=LBDYIH6ZBtPVDsl76+qAORKDMztLRiS8PbsSUEGaPLPvVAY6zxyF0nXj19hQyZlDYtOrMSv0J0PuIKsMaPop7Wmr/fowPaQCmL34s+qVGjTV10xZv7lMtFFxogqMIQJF7kiF+l2Ga2VtJWs/10iJnzwU3rkBGwRC0C/PpBto3fU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755492082; c=relaxed/simple;
	bh=MhxBcmcwTTIvCni/W0ZkFVIlmHHGJSLtNI6slUFeYdU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mTafkXMQAOKy2AnTC4mPAasWIdBXT7mXHUeJtvf47NaNWcoZtr/fFJyiTOGAbNltNV/4BJTnBtdS/mKc15vT89piuvAtcUkES/jsA2F8THFiRNMCmZ80RmcEiPzq8hAPS1fbezrIS5UmXpz5CbVu5RZtSBe3D+QgoXz7ZpjNAHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=S2APeri8; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=LwZfFx3zI72TTXOQ+bid5aDGuKtlV7fQInlEbY1FrWM=; b=S2APeri8S+OKJNBGkmtJyQZtNv
	aQ6DnMU+2dLF7QGKBPe6DcCaAYhrUyI41aSA94yDCNPPx66JSW/tB51MNBCmRJb9tCBCWNPLC1bPT
	GWgkATcJUByM0fZk8C6O6/sitHfrnIBy/MDCj1vu8yoVTQpWh6VDSvkkdEEfdy3g3OZ100JrX1fiK
	ahkVdjq13M5RzuzkcXw9AWti7CU78n19YeTaDnGJxRp7FJDoUDvVjo52alRK5VTae21GupXnS4oMo
	lieYK0NUHa7bBqu8lj//CHAwxrtHFcYyrW3ywif4xH7lW94VBm+TF580PRDfOCmLKBLgrOO0BK1Hc
	9DXoy/Mg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1unrgM-00000006U6c-2fFU;
	Mon, 18 Aug 2025 04:41:18 +0000
Date: Sun, 17 Aug 2025 21:41:18 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Christian Brauner <brauner@kernel.org>
Cc: "Darrick J . Wong" <djwong@kernel.org>,
	"Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	mcgrof@kernel.org, gost.dev@samsung.com, linux-xfs@vger.kernel.org,
	Pankaj Raghav <p.raghav@samsung.com>
Subject: Re: [PATCH] iomap: use largest_zero_folio() in iomap_dio_zero()
Message-ID: <aKKu7jN6HrcXt3WC@infradead.org>
References: <20250814142137.45469-1-kernel@pankajraghav.com>
 <20250815-gauner-brokkoli-1855864a9dff@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250815-gauner-brokkoli-1855864a9dff@brauner>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Fri, Aug 15, 2025 at 04:02:58PM +0200, Christian Brauner wrote:
> On Thu, 14 Aug 2025 16:21:37 +0200, Pankaj Raghav (Samsung) wrote:
> > iomap_dio_zero() uses a custom allocated memory of zeroes for padding
> > zeroes. This was a temporary solution until there was a way to request a
> > zero folio that was greater than the PAGE_SIZE.
> > 
> > Use largest_zero_folio() function instead of using the custom allocated
> > memory of zeroes. There is no guarantee from largest_zero_folio()
> > function that it will always return a PMD sized folio. Adapt the code so
> > that it can also work if largest_zero_folio() returns a ZERO_PAGE.
> > 
> > [...]
> 
> Applied to the vfs-6.18.iomap branch of the vfs/vfs.git tree.
> Patches in the vfs-6.18.iomap branch should appear in linux-next soon.

Hmm, AFAIK largest_zero_folio just showed up in mm.git a few days ago.
Wouldn't it be better to queue up this change there?


