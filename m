Return-Path: <linux-fsdevel+bounces-35958-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 290E09DA24B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Nov 2024 07:26:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A15DDB22EFB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Nov 2024 06:26:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E6B2148832;
	Wed, 27 Nov 2024 06:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="gSmtkFMG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D61213D89D;
	Wed, 27 Nov 2024 06:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732688770; cv=none; b=kNsmK2/zKmL4YPjIvuJEfl9LtDb2FyTsWfNb79XgGKitNMDa5f+rEMkIB1wwpBznWQZB5I9V3Pe1mBHlPVqowv9ejQAHgbefkUnJrzJD1tu1ok3IhLRshukwEhWTrcC4zz3B5r3hhUFdOrgcM9jzjow03Pn2reTN3TmBkdJVf8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732688770; c=relaxed/simple;
	bh=r1oaQkGAyH/8lQKbLazzknsvywjf44WNEKmpHFiMJCE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y25YheF4T0fhJ/DqnIGcWSW7bn/rJ/iq+iov3+c9hqUh1BXtbMuPt1LQ+8klGnOmp+JuKnISbMhhqFUr3LnKhkfpDh9Ngss8dUSdcNtHJJhXw4V9qT6Nf+y/dzo6ROKoRlVOSG4zPjVI6Z8cGD2Di4LOS/FIgJ14S/adwXaxKq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=gSmtkFMG; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=svFKMDnIpssns1GfQO/ozEz62VHItFor5LMbPjt5/PU=; b=gSmtkFMG3LekA1oRJCL/pMlRR/
	blHE5zUXFIXc3dUe3ILhknUcfniIcelNCziYoQoAmdbxXIgy9rbJNhjWs1ZzCVIq9cpdg+doj7GgS
	8aqEnuKZaOi9gntZjKDnXJzYHw4LG+96EM+ZxgpcIV3NOdtErehV9RRsHIHq11LC2NePj2XNwysUO
	QRSBnXhhPn3CX/HChXPHVAyacVX732l1bQFLq7LsXk191V/RN6qqzUyNrH6tPMxVJo3pt5eTO++ym
	bbKouJRaC5D93wFFB4ctKOHSyXofEK/rwrRbN1ei8359ZAF8LIQ5aQduW1N7ZY+HzlnKx39xAp8CP
	8G0TUrsA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tGBV1-0000000CKH0-27tB;
	Wed, 27 Nov 2024 06:26:07 +0000
Date: Tue, 26 Nov 2024 22:26:07 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Bharata B Rao <bharata@amd.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, nikunj@amd.com,
	willy@infradead.org, vbabka@suse.cz, david@redhat.com,
	akpm@linux-foundation.org, yuzhao@google.com, mjguzik@gmail.com,
	axboe@kernel.dk, viro@zeniv.linux.org.uk, brauner@kernel.org,
	jack@suse.cz, joshdon@google.com, clm@meta.com
Subject: Re: [RFC PATCH 1/1] block/ioctl: Add an ioctl to enable large folios
 for block buffered IO path
Message-ID: <Z0a7f9T5lRPO_sEC@infradead.org>
References: <20241127054737.33351-1-bharata@amd.com>
 <20241127054737.33351-2-bharata@amd.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241127054737.33351-2-bharata@amd.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Wed, Nov 27, 2024 at 11:17:37AM +0530, Bharata B Rao wrote:
> In order to experiment using large folios for block devices read/write
> operations, expose an ioctl that userspace can selectively use on the
> raw block devices.
> 
> For the write path, this forces iomap layer to provision large
> folios (via iomap_file_buffered_write()).

Well, unless CONFIG_BUFFER_HEAD is disabled, the block device uses
the buffer head based write path, which currently doesn't fully
support large folios (although there is series out to do so on
fsdevel right now), so I don't think this will fully work.

But the more important problem, and the reason why we don't use
the non-buffer_head path by default is that the block device mapping
is reused by a lot of file systems, which are not aware of large
folios, and will get utterly confused.  So if we want to do anything
smart on the block device mapping, we'll have to ensure we're back
to state compatible with these file systems before calling into
their mount code, and stick to the old code while file systems are
mounted.

Of course the real question is:  why do you care about buffered
I/O performance on the block device node?


