Return-Path: <linux-fsdevel+bounces-57302-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D946B20569
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Aug 2025 12:33:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 72C9818A2172
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Aug 2025 10:33:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4CA22309B5;
	Mon, 11 Aug 2025 10:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Z42FQXJZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6FB01F16B;
	Mon, 11 Aug 2025 10:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754908376; cv=none; b=D0WiBpjv0tpbIajF0FrjGvVxJ7EoUiUEhpURBpX9AyNz6ZXEtqDPxuf3ozsgffhJC5WExkXyQE6KeF3qJM4ZphbfZ3caAE9yQOBMGazv+Hrw4DhTU5mU8DqjcucvPo7GLVNgSg8eQKYsI4TiSpF2ipv396MUNJirF+4KPs1b9q4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754908376; c=relaxed/simple;
	bh=fWZBuhCByaZrfX3gSeAzXz6/RAbJoqfRd3mRk8eamwE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uqsBm0VpmXwInMJrSzqqOxTQTpjo7EC3cX0ADMYL9QKxuFE7HwPBp/YeVoLOBUW66KttnIN0wp+MUSaLtf3CUvAbfEFrnAk3MZB3oLmUgGLrp7L6YAjhHNq7LKQijzBuql9j8U832htUOQ/1lh+jtIHiWlsKy+fEEZdRAeu5YdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Z42FQXJZ; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=0Xj76AAJHUlJ1qkjB5mkm0NmtEe4zDSZlXQMIRpqBrw=; b=Z42FQXJZNHojIEfopDWRSQwSn1
	YWcFq6LtQBoyn4YBv1yNMRU8CV5mhVaHxMF8llZYDp19rAetu3ouFPecDYY6cGhUtocXDp5ARRIwx
	4/1edMZvP91kxASaxEZI+UBn7dBDFW/dtinzZqVsSuqkm+3GsNIoaYcXQXWOHXowA2X9WAgLxPdRS
	41nVrmKoxX9e5dJt1oYy4fYFRYN/GDPhG0eDKRbWJ/rPn1yATYHppizBED9ztazj8S/cFZfHJ4BTH
	oKXM1mRiDR7d3nvCXOVZlPGe8Ppbi9Sa4bw3PvVEUKaRpKjdRAkmI1Q0Vp9+WsuK0sbzWxqRqQ5i7
	Sq1ddxIQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ulPpk-00000007KQl-3ytD;
	Mon, 11 Aug 2025 10:32:52 +0000
Date: Mon, 11 Aug 2025 03:32:52 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>, Keith Busch <kbusch@meta.com>,
	linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, snitzer@kernel.org, axboe@kernel.dk,
	dw@davidwei.uk, brauner@kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCHv2 0/7] direct-io: even more flexible io vectors
Message-ID: <aJnG1H4XXL8AXHcS@infradead.org>
References: <20250805141123.332298-1-kbusch@meta.com>
 <aJNr9svJav0DgZ-E@infradead.org>
 <aJU0scj_dR8_37S8@kbusch-mbp>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aJU0scj_dR8_37S8@kbusch-mbp>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Thu, Aug 07, 2025 at 05:20:17PM -0600, Keith Busch wrote:
> Sure. I wrote up some for blktest, and the same test works as-is for
> filesystems too. Potential question: where do such programs go
> (xfstests, blktests, both, or some common place)?

We currently have no good way to share tests between xfstest and
blktests, so I think it would require duplicating the helper programs.

> I tested on loop, nvme, and virtio-blk, both raw block (blktests) and
> xfs (fstests). Seems fine.

Cool.  I'd like the hear from the other XFS folks if the possibility
of easily introducing preallocated space (that's what it looks like on
disk) for writes failed because of wrong alignment is fine.  Given that
the same user could introduce them using fallocate it's definitively not
a security issue, but also rather unusual and unexpected.  And from the
other file system maintainers if they have similar issues.


