Return-Path: <linux-fsdevel+bounces-46786-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC7C5A94D8B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Apr 2025 09:58:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F24DB170D50
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Apr 2025 07:58:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D160820E711;
	Mon, 21 Apr 2025 07:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="2izEraiJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E084142A82;
	Mon, 21 Apr 2025 07:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745222290; cv=none; b=kWpKrMBsaSanO4SuwYSbZDcIKhobMkKhNfnf+RykLJeUtB+o4Ngmwhi4kcQs8OQW0NQ8nRvssqKLIBGpfCCD7WXkZRerVZHZlfiH+UWQMf0co43VtUaDBr1bvcHq1B+xdVin2JguhbsB6zJGxVpSVkbHEOPxWoAGD4ljwd3kDEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745222290; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RlYjFTqs7mjhrJxVrgCUjFxuPfoKgSen4A2GgK5akWVE5q9FEiZsyxcf1HFBHrsBfYyShUPzafkUm++YY+P9ANAE/AYzluKXkcpOk/3bO8q9QMb3t77CUkVY1R9z5jnO80EAzaRM73pimDZzZoBAekPi0WsarynQyQ6tX/zRLQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=2izEraiJ; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=2izEraiJKRD4d0JrLx24rh4ahR
	8nJRck9Fnmu6n+QKGdAvKETl1wkVBmMlGGF9zR23VXcs33uCYJxLhNpCo9UDAodnBELSWKQa36Qtl
	fS27KsTAnWIcVBLT6Q7A/OJizOCC3Ab8czDwDFy3WMvlYQRDXzeGrEX7OO6LKIjiZ6V+1fgedfIbF
	rVjocoqYTXqzrkuVzo/1vQNnBes4uAE7LSIM9zoQZcruMJtu0n1BOCz8fiNkzjz9zQ8XJAWP5Llra
	nZf1fULKPuK3ybPjljpQ3Jc2P4x+i2DjccKG6APRbTEC1v232Kvox0chPc1MZgrb/IO1EvDg/X9J9
	fqmgVhqg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u6m2Z-00000003q8H-38hC;
	Mon, 21 Apr 2025 07:58:07 +0000
Date: Mon, 21 Apr 2025 00:58:07 -0700
From: Christoph Hellwig <hch@infradead.org>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@infradead.org>,
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	linux-block <linux-block@vger.kernel.org>,
	linux-fsdevel <linux-fsdevel@vger.kernel.org>,
	xfs <linux-xfs@vger.kernel.org>
Subject: Re: [PATCH 1/2] block: fix race between set_blocksize and read paths
Message-ID: <aAX6jypNa15e2d95@infradead.org>
References: <20250418155458.GR25675@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250418155458.GR25675@frogsfrogsfrogs>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>


