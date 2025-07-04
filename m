Return-Path: <linux-fsdevel+bounces-53884-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F80DAF878B
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Jul 2025 08:03:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EBA6E4A7ED4
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Jul 2025 06:03:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 397BE221736;
	Fri,  4 Jul 2025 06:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l/nBVVGI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 909C9143C69;
	Fri,  4 Jul 2025 06:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751609023; cv=none; b=B927geu8X64r1lZsej8MmcVGCPlTW8txlf3qrBN9ih4tWaG6EmF2bG6yTLQLaDdxKLmMSr1rZRebF1TKSCS1B/bXjWqUjakWAuFai9FD/W4zuz4Ha9yAGx/+gXUaAx/H1ypDjzpvJUEO7BzxKKQAsRCxQAyf5FaHgHR/2wEWVdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751609023; c=relaxed/simple;
	bh=TOAqevWd5ctBWJ93LJwpcNQVBzN27/vAb8SLM1CQQF4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CpRSCfHcTypl8UmqZ67Lo0eQSd330ovuQNdtqkDOrt2SBkW6Uyv15JR78CNx/SV3s1SMQxrP8EJbmNR6/S/3bJT9wvubEQKTXcSzFOICgHEJHYyFiHm/kwFKIQZEmJJF8UrgVPZrMq2hYhp8PSRibH8xGbWYyuIC/ZvWJc+9Jzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l/nBVVGI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC1EEC4CEE3;
	Fri,  4 Jul 2025 06:03:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751609023;
	bh=TOAqevWd5ctBWJ93LJwpcNQVBzN27/vAb8SLM1CQQF4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=l/nBVVGIZV6R2rKe/b6EN6IwJcS5QZtZii8YIAru6zwzSiCc5t34PTnJ43d1gfTg5
	 YMriRqpfzpYsgKj6fhb7GFDQx7Kmy2y3zHaF3EYHiyRsZDdEJTuwwiWbI4z4/LThG1
	 STJ1IccRKGfpVCIOpRZziDMEBhogSYHzjjLkbUiajktff+Lq08EheL9jk+2lecELO5
	 iTH4BWawxZjzZjU1QeBz3OqKjeEkTEY08NhKyDFaqwDE2qt7HnI57TLK7p+kx8qI9R
	 S76OZLOK4S48W4dg3QHYpHp8h54m1Jb3kCaUy+5TUKQC6vTd62OrWLZsNjRRVA8uK7
	 FGKwJ8KU6wG2w==
Date: Thu, 3 Jul 2025 23:02:59 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Yuwen Chen <ywen.chen@foxmail.com>
Cc: hch@infradead.org, brauner@kernel.org, tytso@mit.edu,
	linux-kernel@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net, adilger.kernel@dilger.ca,
	viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
	jaegeuk@kernel.org, linux-ext4@vger.kernel.org
Subject: Re: [PATCH v3 1/2] libfs: reduce the number of memory allocations in
 generic_ci_match
Message-ID: <20250704060259.GB4199@sol>
References: <aGZFtmIxHDLKL6mc@infradead.org>
 <tencent_82716EB4F15F579C738C3CC3AFE62E822207@qq.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_82716EB4F15F579C738C3CC3AFE62E822207@qq.com>

On Fri, Jul 04, 2025 at 10:43:57AM +0800, Yuwen Chen wrote:
> During path traversal, the generic_ci_match function may be called
> multiple times. The number of memory allocations and releases
> in it accounts for a relatively high proportion in the flamegraph.
> This patch significantly reduces the number of memory allocations
> in generic_ci_match through pre - allocation.
> 
> Signed-off-by: Yuwen Chen <ywen.chen@foxmail.com>
> ---
>  fs/ext4/namei.c    |  2 +-
>  fs/f2fs/dir.c      |  2 +-
>  fs/libfs.c         | 33 ++++++++++++++++++++++++++++++---
>  include/linux/fs.h |  8 +++++++-
>  4 files changed, 39 insertions(+), 6 deletions(-)
> 

The reason the allocation is needed at all is because generic_ci_match() has to
decrypt the encrypted on-disk filename from the dentry that it's matching
against.  It can't decrypt in-place, since the source buffer is in the pagecache
which must not be modified.  Hence, a separate destination buffer is needed.

Filenames have a maximum length of NAME_MAX, i.e. 255, bytes.

It would be *much* simpler to just allocate that on the stack.

And we almost can.  255 bytes is on the high end of what can be acceptable to
allocate on the stack in the kernel.  However, here it would give a lot of
benefit and would always occur close to the leaves in the call graph.  So the
size is not a barrier here, IMO.

The real problem is, once again, the legacy crypto_skcipher API, which requires
that the source/destination buffers be provided as scatterlists.  In Linux, the
kernel stack can be in the vmalloc area.  Thus, the buffers passed to
crypto_skcipher cannot be stack buffers unless the caller actually is aware of
how to turn a vmalloc'ed buffer into a scatterlist, which is hard to do.  (See
verity_ahash_update() in drivers/md/dm-verity-target.c for an example.)

Fortunately, I'm currently in the process of introducing library APIs that will
supersede these legacy crypto APIs.  They'll be simpler and faster and won't
have these silly limitations like not working on virtual addresses...  I plan to
make fscrypt use the library APIs instead of the legacy crypto API.

It will take some time to land everything, though.  We can consider this
patchset as a workaround in the mean time.  But it's sad to see the legacy
crypto API continue to cause problems and more time be wasted on these problems.

I do wonder if the "turn a vmalloc'ed buffer into a scatterlist" trick that some
code in the kernel uses is something that would be worth adopting for now in
fname_decrypt().  As I mentioned above, it's hard to do (you have to go page by
page), but it's possible.  That would allow immediately moving
generic_ci_match() to use a stack allocation, which would avoid adding all the
complexity of the preallocation that you have in this patchset.

- Eric

