Return-Path: <linux-fsdevel+bounces-58984-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FA74B33AAF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 11:22:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5EBFC1B25A65
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 09:21:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF9782C0F9E;
	Mon, 25 Aug 2025 09:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Y+miYzet"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAED5190664;
	Mon, 25 Aug 2025 09:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756113665; cv=none; b=YhxlNqrFqwaKWLIvBcnIoLTdGc/Hl+w7FGrg1JMeGwoQZcvYDC0GonezybYp75R/YaiqvtKJ9qzJC7JOC/Uq4m3bH4wtTjboyfajvi6YrDVZV2Da19J1skP01vudqX4JMy2kBLGdyW1LwjnFvICejrzMwmy23sJd5QEhgZr9ano=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756113665; c=relaxed/simple;
	bh=lbwwu9GkccV8IALX4pZOCD5WicHbuX6iwVCs1iocpkU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sr4u4ffJbCgYnxgVC2dGt0gMBKetyhGDXAWfB7RdLecpDB4YJ1LMGZChuLT1MERhyIlK2bVuq6a9eb9IPLmw069pGoQMj8EssSrYZV/qUg5+3ET8f3GTdrT09OiK2Y/G0873wqjepLcGTNE8K/xW/PvoZSaIrI1MzGlmOvq4C9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Y+miYzet; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Sc+4JMWsbFGBBm8p/kWO4ggW989b86QDhZeWOOAn3rI=; b=Y+miYzetmddZoPUtzWBaeCZ++j
	gcJOULlYnYuqAoIHehypEMijuD1lpgjTMuqg7+MAkipyyhC/N6SRqQgjM9haj7OTmUHEap5pkutun
	l1/wfld0HBTRJdL1Bt6/ZGyPs6HZ8xGWu1v3Ru+vHSF5mJaUNAY6KVwMHC0/i7Z6sXJIrd5p9bdFQ
	qE0MITL9C/h5nQjh7TFTRsQqY7H0/x7lRfo2MRKlFRtbSgwgdSW5b1K3bumHRV1m0tFkcIW2rZHvr
	9drEcleajm8VQ2k2TrI/xxq6ishDtVUbPUd9yyAK4ScTTHkehWj9q3PUFLDzykIEBZWL1Chedf+Ze
	zIFG2wPw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uqTNt-00000007Tvp-3p1b;
	Mon, 25 Aug 2025 09:21:01 +0000
Date: Mon, 25 Aug 2025 02:21:01 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Fengnan Chang <changfengnan@bytedance.com>
Cc: Ritesh Harjani <ritesh.list@gmail.com>,
	Matthew Wilcox <willy@infradead.org>,
	"Darrick J. Wong" <djwong@kernel.org>, brauner@kernel.org,
	linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: Re: [PATCH] iomap: allow iomap using the per-cpu bio cache
Message-ID: <aKwq_QoiEvtK89vY@infradead.org>
References: <20250822082606.66375-1-changfengnan@bytedance.com>
 <20250822150550.GP7942@frogsfrogsfrogs>
 <aKiP966iRv5gEBwm@casper.infradead.org>
 <877byv9w6z.fsf@gmail.com>
 <aKif_644529sRXhN@casper.infradead.org>
 <874ityad1d.fsf@gmail.com>
 <CAPFOzZufTPCT_56-7LCc6oGHYiaPixix30yFNEsiFfN1s9ySMQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPFOzZufTPCT_56-7LCc6oGHYiaPixix30yFNEsiFfN1s9ySMQ@mail.gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Mon, Aug 25, 2025 at 04:51:27PM +0800, Fengnan Chang wrote:
> No restrictions for now, I think we can enable this by default.
> Maybe better solution is modify in bio.c?  Let me do some test first.

Any kind of numbers you see where this makes a different, including
the workloads would also be very valuable here.


