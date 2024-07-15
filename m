Return-Path: <linux-fsdevel+bounces-23704-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C7C59317FF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Jul 2024 17:59:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD89C1C21E77
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Jul 2024 15:59:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44533F510;
	Mon, 15 Jul 2024 15:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="YOocvnK0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56AEEEEC3
	for <linux-fsdevel@vger.kernel.org>; Mon, 15 Jul 2024 15:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721059180; cv=none; b=U3Je7O8CFGHPFrQS5E1PpJ0o1N5PKiR2AZnzVEojVXTlEFv0BN2eaJR985IhnPef/j4gy1L+1yAVj46v+s+DIPyFXwoitYy7s5xfNE6rEGSm7SaCjMdypt6W92H+Gef++WpUzzeLPNvPG0L9JZjJY5OaZUbF5GV60rHF8QwPwMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721059180; c=relaxed/simple;
	bh=vEaoTAE4lYEoP6dZsl4HMafcgiVUMsGXMRyBkgEe2ZI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=VTfVexSTMC3VM2/d0/Xln8To+0gRSgvWEUaRdNT/Sc7/wJ0mKpd38ZJQkLNtxtw1nD9zhm08vsgxCQdz6RzJP6BxEz91rHZ67N6Aqn9Ev4Msbrte0ziNyhfSX+f9dMYHakGhVi74Nh5I3mzafpjURWqXlndArLqx48B0RXwSs7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=YOocvnK0; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=MCNLHc7ZG9DOcKDibMpuE/hxC25mGD0llYkvNmhtkks=; b=YOocvnK0JaVOGI4y/u9Qf5+wnS
	upJ9LUF0KkVS36KBJAKFidqUCaGOoq1wRd0m1OaS2VGcp44VkX0qbDja+tmiIpl8FjAUUNGEVNLzO
	VJqCw/xNNwZ4MLk73GRoUZRK5oZysRYfsqZxfDgJBe0oF7aaLhOpt7H5QnQGfiPaWlZL1f5GDkuAJ
	AFcBm8iyrZfwbeJTVE9P7Ic76/wmzmaKODYEZp2F3M78eB+CDW5yLZT7XSL90JrcvieClE+SUSLL2
	8Ubag2o6l7oDdKpRt7HFGe/mqHhlNS/lL8IMJAaQbp9kXFBnBJf90oSkClJcnRcs3Kd/SgdbntPvS
	PUlDBpRw==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sTO6y-0000000Fz2a-1V0A;
	Mon, 15 Jul 2024 15:59:36 +0000
Date: Mon, 15 Jul 2024 16:59:36 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-fsdevel@vger.kernel.org
Subject: Uses of ->write_begin/write_end
Message-ID: <ZpVHaILAacPNlfyp@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

I'm looking at ->write_begin() / ->write_end() again.  Here are our
current callers:

drivers/gpu/drm/i915/gem/i915_gem_shmem.c:
[1]	shmem_pwrite()
[2]	i915_gem_object_create_shmem_from_data()
fs/affs/file.c:
[3]	affs_truncate()
fs/buffer.c:
[4]	generic_cont_expand_simple()
[5]	cont_expand_zero()
[6]	cont_expand_zero()
fs/exfat/file.c:
[7]	exfat_file_zeroed_range()
fs/ext4/verity.c:
[8]	pagecache_write()
fs/f2fs/super.c:
[9]	f2fs_quota_write()
fs/f2fs/verity.c:
[A]	pagecache_write()
fs/namei.c:
[B]	page_symlink()
mm/filemap.c:
[C]	generic_perform_write()

There are essentially four things that happen between ->write_begin()
and ->write_end() in these 12 callers:

 - copy_from_user [1]
 - memcpy [289AB]
 - zero [567]
 - nothing [34]
 - copy_from_iter [C]

I suspect that exfat_file_zeroed_range() should be calling
cont_expand_zero(), which means it would need to be exported, but
that seems like an improvement over calling write_begin/write_end
itself.

The copy_from_user() / memcpy() users feel like they should all end
up calling ->write_iter().  One way they could do this is by calling
kernel_write() / __kernel_write(), but I'm not sure whether they
should have the various accounting things (add_wchar(), inc_syscw())
that happen inside __kernel_write_iter().

So should we add:

ssize_t filemap_write_iter(struct file *file, struct iov_iter *from)
{ ... }

which contains the guts of __kernel_write_iter?
ext4's verity code needs a minor refactor to pass down the file
(but note comment about how it's a RO file descriptor)
f2fs_quota_write doesn't have a struct file and looks generally awkward.
page_symlink() is also awkward.

I think that means we need something that _doesn't work_ for iomap-based
filesystems.  All of these callers know the filesystem they're working
on doesn't use iomap, so perhaps filemap_write_iter() just takes a
struct address_space and assumes the existance of
->write_begin/->write_end.

Thoughts?


