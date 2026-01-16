Return-Path: <linux-fsdevel+bounces-74166-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 100B0D33410
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jan 2026 16:40:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EE23A30C2FD6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jan 2026 15:37:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C33E33A010;
	Fri, 16 Jan 2026 15:37:04 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1BD052F88;
	Fri, 16 Jan 2026 15:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768577823; cv=none; b=nOnPHkzN0WID/cpzl1P9ZqodaD7fcAtOlEvdpjTEDqG3Z2yk+juEaAtf2jQA0GknUovuLpBz4meryPk2WYFjVewVrRm8DFXI9OOe4oz+xzdjoNgeOkm+LsS9E7DS3LeI61CM1kvvHelJvA4X+WEbYk0AauPqdNbolXxbx+JHCmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768577823; c=relaxed/simple;
	bh=TCKb6JJp+N0J7BnG9wl5pZttgL6KHiFsTKs2SjEF694=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tsFV/upb7S4JDxnfKmyZq39Yg89TbmhBM61ZkOXoiVT8EVM7Ck1ja9apP7ZPNLh4qP9/iO2zeiOoegG+itj4T6RqMH/rqTLP1llfwwJZb2hryPZSM9tMVsvW0kw7JNDQu1PVuxqt1FRY/RboKJkTbFxS7qL4rDifbbc1E5LBMkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 48E97227AB2; Fri, 16 Jan 2026 16:36:57 +0100 (CET)
Date: Fri, 16 Jan 2026 16:36:56 +0100
From: Christoph Hellwig <hch@lst.de>
To: Hongbo Li <lihongbo22@huawei.com>
Cc: hsiangkao@linux.alibaba.com, chao@kernel.org, brauner@kernel.org,
	djwong@kernel.org, amir73il@gmail.com, hch@lst.de,
	linux-fsdevel@vger.kernel.org, linux-erofs@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v15 0/9] erofs: Introduce page cache sharing feature
Message-ID: <20260116153656.GA21174@lst.de>
References: <20260116095550.627082-1-lihongbo22@huawei.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260116095550.627082-1-lihongbo22@huawei.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

Sorry, just getting to this from my overful inbox by now.

On Fri, Jan 16, 2026 at 09:55:41AM +0000, Hongbo Li wrote:
> 2.1. file open & close
> ----------------------
> When the file is opened, the ->private_data field of file A or file B is
> set to point to an internal deduplicated file. When the actual read
> occurs, the page cache of this deduplicated file will be accessed.

So the first opener wins and others point to it?  That would lead to
some really annoying life time rules.  Or you allocate a hidden backing
file and have everyone point to it (the backing_file related subject
kinda hints at that), which would be much more sensible, but then the
above descriptions would not be correct.

> 
> When the file is opened, if the corresponding erofs inode is newly
> created, then perform the following actions:
> 1. add the erofs inode to the backing list of the deduplicated inode;
> 2. increase the reference count of the deduplicated inode.

This on the other hand suggests the fist opener is used approach again?

> Assuming the deduplication inode's page cache is PGCache_dedup, there

What is PGCache_dedup?

> Iomap and the layers below will involve disk I/O operations. As
> described in 2.1, the deduplicated inode itself is not bound to a
> specific device. The deduplicated inode will select an erofs inode from
> the backing list (by default, the first one) to complete the
> corresponding iomap operation.

What happens for mmap I/O where folio->mapping is kinda important?

Also do you have a git tree for the whole feature?

