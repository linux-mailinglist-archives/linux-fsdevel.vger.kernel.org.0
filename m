Return-Path: <linux-fsdevel+bounces-31221-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 811A499344E
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Oct 2024 19:01:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 37E271F23B71
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Oct 2024 17:01:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 503601DC047;
	Mon,  7 Oct 2024 17:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MJzADLtx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A10801DA626;
	Mon,  7 Oct 2024 17:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728320495; cv=none; b=Qlat04fRPnsLOTCpybLlipeb8+r17gfEXMIF7q4iTUDMEefH+ZXYTGgCmvbBzgkBPsKZIEaxP+HfToe8xmLM0xgUHxZx6L0Y/y8McYXdcOYjhkL5qN4voOQe9iMHNKOd01UftJ8oFGlSQ2cjI57FRVNRnYHYB+4I9q9HXyqb/2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728320495; c=relaxed/simple;
	bh=5NyoUBrP5+P5kR1M0DwdWjMlZxqMLmaKFfkeCUYAPbI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qnImHYJG0DE954Y4W8gcjNNuZ1fWerav0BI8hQfzRc7FW8Oj0p/nQaqECISLr4YN9fLqgSg1CXB55IuL9QmAJmXbt0dWy7hJpZo1tJum3z4i+WTqUvPlQ2lA+EH17TbnOGRsQ+b5y9zxHE+nmfrONJz4xt4CKPKDELEegkL8oy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MJzADLtx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DF95C4CEC6;
	Mon,  7 Oct 2024 17:01:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728320495;
	bh=5NyoUBrP5+P5kR1M0DwdWjMlZxqMLmaKFfkeCUYAPbI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MJzADLtx5QWV93wWj2f9kFZ7lkmNPkR+EiPG76odnlxR963ZKLloAtt5K7HSq6vrA
	 ylhA7zguk8cuw8HY12n7Fnus06/0LlKmjxiLft2+BAuGRvsT879KtNTHjRnpypWNtt
	 Gxc+x0tX2J4Qj7NU8B1FpTS1oXu9smQpP0rOWv2BzX+mFhTgDeWSukblD53BSCZ+Nt
	 +WJX8hXvvznhw074AUN493pqmUhteXZKYRGYZawVPypomdoUQXyRjWk63v/Y3rszhB
	 dE2L27LVm024GKjGLek5ooxaubNPKcuq0g9y54WkyMhhk824JtuOo84Sms7xDVuzqD
	 LNhHw4VOhwjQw==
Date: Mon, 7 Oct 2024 10:01:34 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Matthew Wilcox <willy@infradead.org>
Cc: Goldwyn Rodrigues <rgoldwyn@suse.de>, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: Re: [PATCH 02/12] iomap: Introduce iomap_read_folio_ops
Message-ID: <20241007170134.GC21836@frogsfrogsfrogs>
References: <cover.1728071257.git.rgoldwyn@suse.com>
 <0bb16341dc43aa7102c1d959ebaecbf1b539e993.1728071257.git.rgoldwyn@suse.com>
 <ZwCiVmhWm0O5paG4@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZwCiVmhWm0O5paG4@casper.infradead.org>

On Sat, Oct 05, 2024 at 03:20:06AM +0100, Matthew Wilcox wrote:
> On Fri, Oct 04, 2024 at 04:04:29PM -0400, Goldwyn Rodrigues wrote:
> > iomap_read_folio_ops provide additional functions to allocate or submit
> > the bio. Filesystems such as btrfs have additional operations with bios
> > such as verifying data checksums. Creating a bio submission hook allows
> > the filesystem to process and verify the bio.
> 
> But surely you're going to need something similar for writeback too?
> So why go to all this trouble to add a new kind of ops instead of making
> it part of iomap_ops or iomap_folio_ops?

iomap_folio_ops, and maybe it's time to rename it iomap_pagecache_ops.

I almost wonder if we should have this instead:

struct iomap_pagecache_ops {
	struct iomap_ops ops;

	/* folio management */
	struct folio *(*get_folio)(struct iomap_iter *iter, loff_t pos,
			unsigned len);
	void (*put_folio)(struct inode *inode, loff_t pos, unsigned copied,
			struct folio *folio);

	/* mapping revalidation */
	bool (*iomap_valid)(struct inode *inode, const struct iomap *iomap);

	/* writeback */
	int (*map_blocks)(struct iomap_writepage_ctx *wpc, struct inode *inode,
			  loff_t offset, unsigned len);

	int (*prepare_ioend)(struct iomap_ioend *ioend, int status);
	void (*discard_folio)(struct folio *folio, loff_t pos);
};

and then we change the buffered-io.c functions to take a (const struct
iomap_pagecache_ops*) instead of iomap_ops+iomap_folio_ops, or
iomap_ops+iomap_writeback_ops.

Same embedding suggestion for iomap_dio_ops.

--D

