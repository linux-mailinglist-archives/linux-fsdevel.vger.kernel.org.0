Return-Path: <linux-fsdevel+bounces-35278-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E2B519D359B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Nov 2024 09:37:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 80249B252D8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Nov 2024 08:37:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F81B185B47;
	Wed, 20 Nov 2024 08:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="n6Ip2e6e"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E23015B547;
	Wed, 20 Nov 2024 08:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732091864; cv=none; b=dAIB+S63XVtf3EGwdPTecMBdtdPcSeHudj0x6D8CIZo4Dk+H9URHP3lxF61mB3CmI+QD+KftA3znkMIyl+0iavhyboI+2pgfYUtbOoPtzVaiLZiuHnkbFtx2WSN1thLkpnC9OYNxw50ru9YoB+e/qCuo7E6oE8t3AxpqRR2QRwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732091864; c=relaxed/simple;
	bh=HuLo+tWp6cDwjyCAP8svgTyytpnPPmSrnmHZ7IlDYvs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pIDj68s+vxJFMiSmurEeGr0lPeOfBpaonAwgvTSVNPFqsY9bdoqHYkqQzxRuuyBODeis2COKxCBKgfb4wyxi8XYibW6CyZQUK2p/p5rlfflFgQHaz+HikB69Z4H/17h6m0lZXTGO27kf5LrJ9en0sgsLSutpHDfji2iiRRpE9/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=n6Ip2e6e; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=voCL6fIJCtX1eS59yHaY0YfCyhGFMvAzbbvpd0EHkJA=; b=n6Ip2e6eN0gTUNGQO4KHd+IK8X
	rEcTyjPizfjFQw+QQbmKud0F84OBG6dn4112E5ZwD3K8WZ86IRPgOHHhjsTYCwJlnhM3fydVN24/Q
	s6hpdcjrgeSIobTJlQtbk11IU2tED/iGpcJOhs5onOAWKq6auCS3sBRYeu0cMS1ubn4PI84+43w3F
	sOsCieWBvQGVSQB5upPD3RcPiWWM9J3NP5gjfuPicHSjmmTwzphmqj8UMt2XUXhxpb23sIWHy/KTX
	GvtBLHHCXsk/DOosefmQhcMjn+PPPFa22E5JDMmtrE/c8ct2V+LhM01oCOTiftIXVvR9ySuLF5GTW
	ac1UGVcQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tDgDV-0000000EmdR-1d4t;
	Wed, 20 Nov 2024 08:37:41 +0000
Date: Wed, 20 Nov 2024 00:37:41 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Brian Foster <bfoster@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH RFC 0/4] iomap: zero range folio batch processing
 prototype
Message-ID: <Zz2f1c4mjR9blfTg@infradead.org>
References: <20241119154656.774395-1-bfoster@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241119154656.774395-1-bfoster@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Tue, Nov 19, 2024 at 10:46:52AM -0500, Brian Foster wrote:
> I thought about using ->private along with a custom ->get_folio(), but I
> don't think that really fits the idea of a built-in mechanism. It might
> be more appropriate to attach to the iter, but that currently isn't
> accessible to ->iomap_begin(). I suppose we could define an
> iomap_to_iter() or some such helper that the fill helper could use to
> populate the batch, but maybe there are other thoughts/ideas?

The iter is the right place, and you can get at it using
container_of as already done by btrfs (and osme of my upcoming code):

	struct iomap_iter *iter = container_of(iomap, struct iomap_iter, iomap);


