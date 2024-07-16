Return-Path: <linux-fsdevel+bounces-23733-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 59C3E931FB3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Jul 2024 06:26:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 141C5282590
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Jul 2024 04:26:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 233C815E9B;
	Tue, 16 Jul 2024 04:26:07 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 771C812E55
	for <linux-fsdevel@vger.kernel.org>; Tue, 16 Jul 2024 04:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721103966; cv=none; b=bbOX0AZRZvb2sva97LOsT59xkriGiqNiBahEuqDubUtaAA86YAVaeeOrw4j4MpOh/K3qs54v3388kXv5tuPUPlSUd2bd+Rt7JwQDYZGeYjjz43IkaaMRv5GQPMWMsCfDEur0MIkiu54Gw/20P6qXFeLzRwXjEOxm/H8t/0nBbXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721103966; c=relaxed/simple;
	bh=DvsjvpDXNOth0D//VpZfrWl4jfCnK0FhmBf/7P0hAuc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QUw6OO5QVsEuog6M/JJXyWIDi3LJ20mtxpELiLwoHmYE+r7wcAdNYYrn4f1ThFx5t7jSlZBZI58iJQ0zGZSfZA+8NIRiy3O0UY4Vy4jYxue0VK+Z6vbaDCi7iqgnWMxAehN4KMotF5YcnMbTANRBqFGN+VZHeZ0WsY+JgJfNvgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 52E0D227A87; Tue, 16 Jul 2024 06:25:59 +0200 (CEST)
Date: Tue, 16 Jul 2024 06:25:59 +0200
From: Christoph Hellwig <hch@lst.de>
To: Matthew Wilcox <willy@infradead.org>
Cc: Christoph Hellwig <hch@lst.de>, linux-fsdevel@vger.kernel.org
Subject: Re: Uses of ->write_begin/write_end
Message-ID: <20240716042559.GA25209@lst.de>
References: <ZpVHaILAacPNlfyp@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZpVHaILAacPNlfyp@casper.infradead.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Jul 15, 2024 at 04:59:36PM +0100, Matthew Wilcox wrote:
> I'm looking at ->write_begin() / ->write_end() again.  Here are our
> current callers:
> 
> drivers/gpu/drm/i915/gem/i915_gem_shmem.c:
> [1]	shmem_pwrite()
> [2]	i915_gem_object_create_shmem_from_data()

These really need to use actual shmem exported APIs, probably
shmem_get_folio, instead of abusing the aops.  With that we can
then easily kill ->write_begin() / ->write_end() for shmem.

> fs/affs/file.c:

Most of these fs-specific ones should really hardcode the calls to the
usually once or sometimes few potential instances that could be called
so that we can devirtualize the alls.

> fs/buffer.c:
> [4]	generic_cont_expand_simple()
> [5]	cont_expand_zero()
> [6]	cont_expand_zero()

> fs/namei.c:
> [B]	page_symlink()

> The copy_from_user() / memcpy() users feel like they should all end
> up calling ->write_iter().

> One way they could do this is by calling
> kernel_write() / __kernel_write(), but I'm not sure whether they
> should have the various accounting things (add_wchar(), inc_syscw())
> that happen inside __kernel_write_iter().
> 

They often sit much lower in the stack and/or are used for files that
don't have a ->write_iter.  e.g. page_symlink is obviously used for
symlinks that don't have ->write_iter.

For generic_cont_expand_simple goins through write_iter might be an
option, but instead of going through file ops the better idea might be
to just pass a write_iter-prototyped callback directly to it.

cont_expand_zero is a helper for cont_write_begin, which is used to
implement ->write_begin, so this actually already is a recursion, adding
another indirect to it is probably not helpful.


