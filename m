Return-Path: <linux-fsdevel+bounces-40277-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3902BA2178E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Jan 2025 06:58:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E3AD18894D5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Jan 2025 05:58:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E50C0191F8C;
	Wed, 29 Jan 2025 05:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="dR0n0Oe9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A8935672;
	Wed, 29 Jan 2025 05:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738130282; cv=none; b=DADDwbDAHroQPgSCcKGRlvMabVIRc0Q+kQqrHY/6DwkbevPsuuc8AaoAjjRmw6lbrZOyIabQ2H1yXhclgZ3OiGSN2FcIaGKpEGck9kTWZtCCvgk3/j+QXijTBi+9fARGendU5grWrdkXD6TiMOIgE5Ff1xrEYB0HisG40rKfVsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738130282; c=relaxed/simple;
	bh=GHNG3adl692Cf6SW4BBKbp5ahd9TK8YGHsz/NZaGyZo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jt1jmuTxYCGpyjwLtY+RT5XgCd5xwz8P7trnsez3ErlIY4WSOrEsPpeHTEkhDKIghWgLbWOk8KdyTh6Nrx9wux2eaGx6JfmiPbhRdY1MSXeLoHkLICIcrCcJdoZ/x2JeekZiuMrKtG3QI550Y8gIoY4N53Hj55YFSr3n/HSSMw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=dR0n0Oe9; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=p0taJwY+HtXBJGJLPETjY7zF7GHiL0ers9a6T8lh+FU=; b=dR0n0Oe9TkxRhjIChyaIeSFseS
	xNavW3VBvt39wQ2UIuH3n3oqFHTMjqxhb1XKOJk8hBqdprQ+BGms+tteVJ/uLfHj6S8pblbPSqJQS
	rHdotVzFKt21jnE1x2aXaCXgFAZDbi9kxuMdYLATTmXV1TyGpFSx23YKMH+mH75K06L8KFM/XUeiA
	JrGmlJNMVX68d1b1t+NVon2clbCf5uDGdR+mY35PMcx2EZduofroh/c7aaGvEtXZEUjV0NCLkPpOc
	FEe25Yf8aoToF+krknNFF8EemkS7SUiQHK90+vAoCDkuucIF7Mk0hayjNR5Px+yTSSvO83faLOJqZ
	6BzFXDeQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1td15M-00000006NVT-27Zt;
	Wed, 29 Jan 2025 05:58:00 +0000
Date: Tue, 28 Jan 2025 21:58:00 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Brian Foster <bfoster@redhat.com>
Cc: Christoph Hellwig <hch@infradead.org>, linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org
Subject: Re: [PATCH v2 6/7] iomap: advance the iter directly on unshare range
Message-ID: <Z5nDaK6OoGnQdoU2@infradead.org>
References: <20250122133434.535192-1-bfoster@redhat.com>
 <20250122133434.535192-7-bfoster@redhat.com>
 <Z5htdTPrS58_QKsc@infradead.org>
 <Z5jiR8vjG7MT3Psv@bfoster>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z5jiR8vjG7MT3Psv@bfoster>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Tue, Jan 28, 2025 at 08:57:27AM -0500, Brian Foster wrote:
> And the analogous change in the next patch for zero range (unwritten &&
> !range_dirty) as well.
> 
> Finally, I'm still working through converting the rest of the ops to use
> iomap_iter_advance(), but I was thinking about renaming iter.processed
> to iter.status as a final step. Thoughts on a rename in general or on
> the actual name?

Yeah, having a processed with either a count or status has proven to
not be the greatest design ever, and once that is gone picking a better
name is a good idea.  status sounds fine.  The variables tend to be
name error or err, maybe that's a little better than status?  I don't
really care strongly either way.


