Return-Path: <linux-fsdevel+bounces-48969-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F193CAB6EFA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 May 2025 17:09:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CFCC43A9526
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 May 2025 15:06:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F9C51C8606;
	Wed, 14 May 2025 15:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="QjI/TLk8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C05CD19341F;
	Wed, 14 May 2025 15:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747235191; cv=none; b=EDHX3a2jEbg0lwghuFPPxnWqR7X4+zvN6kCg/dl4tt4UP7TqBFMDJisBpJszbkuyLcn2aVtXxRTa+kkNT75QewUHIO4aGixgJwLuGY55EOtjUqxkyBnUbSbL6IVM8HSCdtHtsUN3Id96D2FD10+reyeSFDE+pcc9usxTJ+82W8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747235191; c=relaxed/simple;
	bh=49IPILCDFGJoTtGJw6PabOF4qj/kYnh1Lrc/Fqb5kPg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QtfLpkdE5Bz3HQadE4Z8rZjxJ0ACHJ15KWlHsgT/qbMMYVjqaf8SlLqCJPUcHOXYzk4Dbet1Pm7YxoYaovtlKJVeYXX2GE7umbHyNQuPGWPyX6mX8EdnqbxN2qa5pB0wTcxDcR2BNqH5wfEvhfx4pNU9VXFG8AGtDnIMo5KQ230=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=QjI/TLk8; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=RKownVnGZe2UL1ciUHyNBkHcN2TX+C13oImW60hfDsM=; b=QjI/TLk8bAz6m0/ahaZbmakyUt
	x6PoTRckDFJRJ7atnSUukQOhJomjiquCpNi81GTpWflVz30z9/umlbb1jXvT1UdwN7bfgW9LzvCIt
	oqHEpu5SVX9hIxPF75tqWarkJ46AAWqEBBfUnH8KWO0r2hmZZB+hQRDJqEsK8917vjwN/NPP3ZRkN
	hoJC24wE8zcuhSBPrVIUFAStqct9Oj77OKULK0+gK/V9daIMsV05BjaelUZeUBbigJaqHduOjbdqz
	q2Y4kll8asCQZOsNXocWuWvr9SvEDbgThaef+u+LHBdvANyq9ajbdFhfUPQTJixgZJ0kSjLarZoyE
	mbvvM7lQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uFDgh-0000000FWFN-21pV;
	Wed, 14 May 2025 15:06:27 +0000
Date: Wed, 14 May 2025 08:06:27 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Matthew Wilcox <willy@infradead.org>
Cc: Theodore Ts'o <tytso@mit.edu>,
	=?utf-8?B?6ZmI5rab5rab?= Taotao Chen <chentaotao@didiglobal.com>,
	"adilger.kernel@dilger.ca" <adilger.kernel@dilger.ca>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: Re: [PATCH 1/3] mm/filemap: initialize fsdata with iocb->ki_flags
Message-ID: <aCSxc7TnJzP-n2Lk@infradead.org>
References: <20250421105026.19577-1-chentaotao@didiglobal.com>
 <20250421105026.19577-2-chentaotao@didiglobal.com>
 <20250514035125.GB178093@mit.edu>
 <aCScvepl2qxyU40P@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aCScvepl2qxyU40P@casper.infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Wed, May 14, 2025 at 02:38:05PM +0100, Matthew Wilcox wrote:
> On Tue, May 13, 2025 at 11:51:25PM -0400, Theodore Ts'o wrote:
> > I understand that it would be a lot more inconvenient change the
> > function signature of write_begin() to pass through iocb->ki_fags via
> > a new parameter.  But I think that probably is the best way to go.
> 
> I'd suggest that passing in iocb rather than file is the way to go.
> Most callers of ->write_begin already pass NULL as the first argument so
> would not need to change.  i915/gem passes a non-NULL file, but it only
> operates on shmem and shmem does not use the file argument, so they can
> pass NULL instead.

i915/gem needs to stop using write_begin/end and just do an iter_write.
Someone who has the hardware and/or CI setup needs to figure out if
vfs_write and kernel_write is fine, or this is magic enough to skip
checks and protection and go straight to callig ->iter_write.

> fs/buffer.c simply passes through the file passed
> to write_begin and can be changed to pass through the iocb passed in.
> exfat_extend_valid_size() has an iocb in its caller and can pass in the
> iocb instead.  generic_perform_write() has an iocb.

And we really need to stop theading this through the address_space
ops because it's not a generic method but a callback for the file
system..


