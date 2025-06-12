Return-Path: <linux-fsdevel+bounces-51411-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B11FAD6883
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Jun 2025 09:13:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BCBCF3AC6B0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Jun 2025 07:13:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A97E20103A;
	Thu, 12 Jun 2025 07:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="qE27VbKm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B762142E73;
	Thu, 12 Jun 2025 07:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749712415; cv=none; b=bUJZZMyQLnr8sgUl9V9Zyoz79BhWHDLUs+LvLdg3+uETfe9wHU8s1Ee0rJ6Q6VBX1pL0b48C4cScIK8ONYJpCGphcZOvpjhCehfKVy4X9rqBVSS//Sv+W5mv9vAvF1ZxgpGtKCZt5cLKn41sQymUXlj1YhALSpjmMVh8vRtKzGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749712415; c=relaxed/simple;
	bh=KX7yFObNkQPwiJAvc4v9t3yn0dEmJ9qdNCzHnpoN24s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oUfCC7344zomNPTOFVgoHnhAh9iJwE6RzpLnTfbH93DnpjsJTvcOt89YwIZSzo7+Gp9yRLEARwNN845SGUzsEsIBTB9523SaQt3CVBxBg93ArBanAtzBZuSfk9OkLu4s2Fp2CxxnGs5KxOjs4wRx4U3qvksVIAn5VlQKt6HxjAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=qE27VbKm; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=2oEFjCSShK9uvDvw6XrUrclAWMENjlRPEowfuyu7U48=; b=qE27VbKmVa9lsjpdmAiQveZVGj
	Gm5UOrFQq9HDpk5R87vhNwMOeYNQgoHCLrpydHyxzP4Og/BY8qb3fyJNguBJMRPmDOQ+nSZV4ZsaC
	pLumFK/RA1xbz+h5W5bNpqSjU3kWmkBm9WRZnNgwJHJKP+nXv89JRuekcwYng+wI16Ef1cKahwytY
	4KpG2sf6kR9ALNaHw2EyzVpyK364Wx3/r4U/CbZDfSWkl/HSHZTHayJQopmdWU1fPg+Z4+WVhb1NS
	npfAVNQtwfYCyKASGA9nGTqIKb3boAUBk5g5Wpifz/TgVaAWSHwTD65lYFEkhF1ZGWdXciL6Bdapt
	qDnX9TXA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uPc7x-0000000CPJp-3VYr;
	Thu, 12 Jun 2025 07:13:33 +0000
Date: Thu, 12 Jun 2025 00:13:33 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Jeff Layton <jlayton@kernel.org>
Cc: Mike Snitzer <snitzer@kernel.org>, Chuck Lever <chuck.lever@oracle.com>,
	linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH 1/6] NFSD: add the ability to enable use of RWF_DONTCACHE
 for all IO
Message-ID: <aEp-HYht82wLT7Vl@infradead.org>
References: <20250610205737.63343-1-snitzer@kernel.org>
 <20250610205737.63343-2-snitzer@kernel.org>
 <4b858fb1-25f6-457f-8908-67339e20318e@oracle.com>
 <aEnWhlXjzOmRfCJf@kernel.org>
 <7c48e17c4b575375069a4bd965f346499e66ac3a.camel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7c48e17c4b575375069a4bd965f346499e66ac3a.camel@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Wed, Jun 11, 2025 at 04:29:58PM -0400, Jeff Layton wrote:
> I think if we can crack the problem of receiving WRITE payloads into an
> already-aligned buffer, then that becomes much more feasible. I think
> that's a solveable problem.

It's called RDMA :)

To place write payloads into page aligned buffer, the NIC needs to split
the various headers from the payload.  The data placement part of RDMA
naturally takes care of that.  If you want to do it without TCP, you need
hardware that is aware of the protocol headers up to the XDR level.  I
know and the days where NFS was a big thing there were NICs that could do
this offload with the right firmware, and I wouldn't be surprised if
that's still the case.


