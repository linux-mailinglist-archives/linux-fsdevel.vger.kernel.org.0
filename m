Return-Path: <linux-fsdevel+bounces-23706-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 819CF931A3C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Jul 2024 20:23:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 35B9A1F21C32
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Jul 2024 18:23:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A2F071B3A;
	Mon, 15 Jul 2024 18:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="FBJ7mGZN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A5F26D1A8
	for <linux-fsdevel@vger.kernel.org>; Mon, 15 Jul 2024 18:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721067809; cv=none; b=PRpAl4DJnIn4Sv5DEdWfpMI0Tr6EKLO34Zlf81EN7OlDuHy7qNoxO78QgJ9D3AaCHvudAP7lceki4GeiK+pG+uD+jRx2Ds62kZQycD5at50iJHe7ackbXsTOx+fKvk3mc3yPq/RCJHRVvQ17K3G9z+3+Eqj7EE7/1GyLsjr4Eb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721067809; c=relaxed/simple;
	bh=kzPBfh2hBlb1oUZ/kANeTr8h5BNCDJsbGSNUutFnJAw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X2AZ1iZMw5TX4Sex0UDqJQ7CmVh5owgMIUev/rSfCTRMPp8wuqh3Vwhh0Cmuokh1knxKj9inUfwkWbruBJmg+Og1r5Gg3poGpbL6WhomAtvSPob5XGd66gWU6FxFXV7+xALiCjqO9enVwttEuOQXcjXLQBNerNMmm5E0/Z7k71s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=FBJ7mGZN; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=NLLDlHbEZTqyQqqt6u36QiPPg82KlWI5nqB3BQ0AiHI=; b=FBJ7mGZNj86rES7kzmNjnq8EMU
	fC3pivrKtQeHTKmFR2G6/EYaM5L4T59YXqaI1l/jLKdmNCD6Vo24v65YoBy8fFpGWu5SJc/kgty0a
	EtX8SrYxCA5kDNneK/GX6O3C2bjonmhQ9w+Z5HDc8RT8QsSUY1mhQrMaHWEjEEm2FSjLgLrCfIVfr
	9PlfteCGX7EVcmB9SmATwViSSoW30RIjh0bR6QroMXaKgOFWplY7nDW1VXlSCkuUahsy4odmBarzJ
	YHvelAKJ/CiKheWmJjf2CsDTcgyGZ7xC5SDDkygvR+jHSFb4Rxh91rNJmQtqh6tUiV1fwIzMheXWu
	ZAc3ZgKg==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sTQM9-0000000G7Z2-147S;
	Mon, 15 Jul 2024 18:23:25 +0000
Date: Mon, 15 Jul 2024 19:23:25 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-fsdevel@vger.kernel.org
Subject: Re: Uses of ->write_begin/write_end
Message-ID: <ZpVpHYsqgPs3hz8o@casper.infradead.org>
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

On Mon, Jul 15, 2024 at 04:59:36PM +0100, Matthew Wilcox wrote:
> I'm looking at ->write_begin() / ->write_end() again.  Here are our
> current callers:
> 
> drivers/gpu/drm/i915/gem/i915_gem_shmem.c:
> [1]	shmem_pwrite()
> [2]	i915_gem_object_create_shmem_from_data()
> fs/affs/file.c:
> [3]	affs_truncate()
> fs/buffer.c:
> [4]	generic_cont_expand_simple()
> [5]	cont_expand_zero()
> [6]	cont_expand_zero()
> fs/exfat/file.c:
> [7]	exfat_file_zeroed_range()
> fs/ext4/verity.c:
> [8]	pagecache_write()
> fs/f2fs/super.c:
> [9]	f2fs_quota_write()
> fs/f2fs/verity.c:
> [A]	pagecache_write()
> fs/namei.c:
> [B]	page_symlink()
> mm/filemap.c:
> [C]	generic_perform_write()

I found a few variants of the same pattern:

fs/hfs/extent.c:
[D]	hfs_file_truncate()
fs/hfsplus/extents.c:
[E]	hfsplus_file_truncate()
fs/ntfs3/file.c:
[F]	ntfs_extend_initialized_size()

> There are essentially four things that happen between ->write_begin()
> and ->write_end() in these 12 callers:
> 
>  - copy_from_user [1]
>  - memcpy [289AB]
>  - zero [567]

 - zero [567F]

>  - nothing [34]

 - nothing [34DE]

>  - copy_from_iter [C]
> 
> I suspect that exfat_file_zeroed_range() should be calling
> cont_expand_zero(), which means it would need to be exported, but
> that seems like an improvement over calling write_begin/write_end
> itself.
> 
> The copy_from_user() / memcpy() users feel like they should all end
> up calling ->write_iter().  One way they could do this is by calling
> kernel_write() / __kernel_write(), but I'm not sure whether they
> should have the various accounting things (add_wchar(), inc_syscw())
> that happen inside __kernel_write_iter().
> 
> So should we add:
> 
> ssize_t filemap_write_iter(struct file *file, struct iov_iter *from)
> { ... }
> 
> which contains the guts of __kernel_write_iter?
> ext4's verity code needs a minor refactor to pass down the file
> (but note comment about how it's a RO file descriptor)
> f2fs_quota_write doesn't have a struct file and looks generally awkward.
> page_symlink() is also awkward.
> 
> I think that means we need something that _doesn't work_ for iomap-based
> filesystems.  All of these callers know the filesystem they're working
> on doesn't use iomap, so perhaps filemap_write_iter() just takes a
> struct address_space and assumes the existance of
> ->write_begin/->write_end.
> 
> Thoughts?
> 
> 

