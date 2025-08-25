Return-Path: <linux-fsdevel+bounces-58996-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 40439B33D21
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 12:48:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7930E7AB3AC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 10:46:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E43F62D73A7;
	Mon, 25 Aug 2025 10:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="W4MYaCqi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 468083D984;
	Mon, 25 Aug 2025 10:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756118883; cv=none; b=duwbk7Riqp+noNbHXnBFXIR3jvhgxo+nrPvnbttgdw7PKh1XoJTlLS6tJvtUcB4WUm5qBLl1/17e2tmMiF24aE81hylrReS5nq3OmQLLueuuF9cZtxLUx7DekaGkaIndnbgJ+m0OHdp9nEQHUUf1EdnJFPVOi+1IFB5FZoMnxtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756118883; c=relaxed/simple;
	bh=ezyPflldtQeZ6WB2SgoUntc2JaiwQAyxbr8Jy/e2iu8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LhZoBVARRPwU9DFCMw289CZJVi6tsSiQogkLCufRmFHOLQFxX4bREHPoxkVg7TLLeMnKHQYWc+AYVUbrevqa0yloDt/VUT3RRqBPSr/+Mw6cfGztn8M+yWhDEWPoGDRPEXJaEQTRvLPtEhT1+cCP+7WByZUIAiC8yFyZ24cg9fg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=W4MYaCqi; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=U73jKzl4kj5AoKDUaz/Pj4NkgdmdrxRG+6zh/yOzJ6o=; b=W4MYaCqi+vloOSxcceuXHDqYhb
	KgnCJGJokuVYEqXak+OJ+sqtVBpnvFMobFal72Si6mGgVmJ18aLQPP9LZafL/IGKMzWAEHYVW659m
	DbHsUSi0BBpBszh3ls3mfMOWhMRDYctWuOYDIjckCN/K2XMVHIQa8FL4QWdmgAlHIYQxhuvLZoBP2
	9D/pQYUisHogjTHsl9U+BGd1wwkZV/lUVQsWc8FFq5rFRpQf6sWv5XRKx9Lhrf7DaG9e/KCj/G9Vu
	b1CCrUDrqnQCq5XnZee3iMz0DMHCIUHqZg3gmkBi6CJRhv3FziN/ApAnJq0KZu0oVvHZAIUXoB4dv
	vM4u4wTw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uqUk1-00000007fpg-3qDp;
	Mon, 25 Aug 2025 10:47:57 +0000
Date: Mon, 25 Aug 2025 03:47:57 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Fengnan Chang <changfengnan@bytedance.com>
Cc: Christoph Hellwig <hch@infradead.org>,
	Ritesh Harjani <ritesh.list@gmail.com>,
	Matthew Wilcox <willy@infradead.org>,
	"Darrick J. Wong" <djwong@kernel.org>, brauner@kernel.org,
	linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: Re: [PATCH] iomap: allow iomap using the per-cpu bio cache
Message-ID: <aKw_XSEEFVG4n79_@infradead.org>
References: <20250822082606.66375-1-changfengnan@bytedance.com>
 <20250822150550.GP7942@frogsfrogsfrogs>
 <aKiP966iRv5gEBwm@casper.infradead.org>
 <877byv9w6z.fsf@gmail.com>
 <aKif_644529sRXhN@casper.infradead.org>
 <874ityad1d.fsf@gmail.com>
 <CAPFOzZufTPCT_56-7LCc6oGHYiaPixix30yFNEsiFfN1s9ySMQ@mail.gmail.com>
 <aKwq_QoiEvtK89vY@infradead.org>
 <CAPFOzZvBvHWHUwNLnH+Ss90OMdu91oZsSD0D7_ncjVh0pF29rQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPFOzZvBvHWHUwNLnH+Ss90OMdu91oZsSD0D7_ncjVh0pF29rQ@mail.gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Mon, Aug 25, 2025 at 05:41:57PM +0800, Fengnan Chang wrote:
> I'm test random direct read performance on  io_uring+ext4, and try
> compare to io_uring+ raw blkdev,  io_uring+ext4 is quite poor, I'm try to
> improve this, I found ext4 is quite different with blkdev when run
> bio_alloc_bioset. It's beacuse blkdev ext4  use percpu bio cache, but ext4
> path not. So I make this modify.
> My test command is:
> /fio/t/io_uring -p0 -d128 -b4096 -s1 -c1 -F1 -B1 -R1 -X1 -n1 -P1 -t0
> /data01/testfile
> Without this patch:
> BW is 1950MB
> with this patch
> BW is 2001MB.

Interesting.  This is why the not yet merged ext4 iomap patches I guess?
Do you see similar numbers with XFS?

> 

