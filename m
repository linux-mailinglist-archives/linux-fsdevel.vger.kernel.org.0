Return-Path: <linux-fsdevel+bounces-74379-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 04FC6D39F85
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jan 2026 08:17:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3410A3026BE4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jan 2026 07:17:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 271732DB7AF;
	Mon, 19 Jan 2026 07:17:29 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A111A225760;
	Mon, 19 Jan 2026 07:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768807048; cv=none; b=cY/V71jM6fuMhZWrJiNXYUfEYT/80eRwKapfS6ETwC1czNhbigDxRFTqTZw3SEd9swEEH9/gvmkJaJfocoKN01qYYMWeo7X0v3UoZatSYrVqo9cguCa4c+JmpQEjxJ7Y1+pWGo1z1pgZgjx+Dve+8eHqEyQT9ZJlTMy8a30SOjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768807048; c=relaxed/simple;
	bh=ffkD+aNnhwc6XKwt+sCUA5woWRlh8HPeomOflUON1eA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hMYbqshdVIJL9IQ89Y2ncEpMNoANP3iUREhGUQ4HIALt7GZgoRq0TyaXps95Dx1u4wuEuizF6sDi7N75zb5V/jKY/lBcXMV0iHLru2srK9jm/GAs/D3VsWPcTBFdWZ+ZmwfY35DqK3DddBg7XvajAwMM2uyabpxqd1mq/CmRWf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id AACEB227A88; Mon, 19 Jan 2026 08:17:20 +0100 (CET)
Date: Mon, 19 Jan 2026 08:17:19 +0100
From: Christoph Hellwig <hch@lst.de>
To: Namjae Jeon <linkinjeon@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, viro@zeniv.linux.org.uk,
	brauner@kernel.org, tytso@mit.edu, willy@infradead.org,
	jack@suse.cz, djwong@kernel.org, josef@toxicpanda.com,
	sandeen@sandeen.net, rgoldwyn@suse.com, xiang@kernel.org,
	dsterba@suse.com, pali@kernel.org, ebiggers@kernel.org,
	neil@brown.name, amir73il@gmail.com, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, iamjoonsoo.kim@lge.com,
	cheol.lee@lge.com, jay.sim@lge.com, gunho.lee@lge.com,
	Hyunchul Lee <hyc.lee@gmail.com>
Subject: Re: [PATCH v5 07/14] ntfs: update iomap and address space
 operations
Message-ID: <20260119071719.GD1480@lst.de>
References: <20260111140345.3866-1-linkinjeon@kernel.org> <20260111140345.3866-8-linkinjeon@kernel.org> <20260116091451.GA20873@lst.de> <CAKYAXd9+P6ekYnbXuoG95Nt5-H6bie6cSm4N-9RFDN3E+smJ+g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKYAXd9+P6ekYnbXuoG95Nt5-H6bie6cSm4N-9RFDN3E+smJ+g@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Sun, Jan 18, 2026 at 02:00:09PM +0900, Namjae Jeon wrote:
> > This function confuses me.  In general end_io handlers should not
> > need to drop a folio reference.  For the normal buffered I/O path,
> > the folio is locked for reads, and has the writeback bit set for
> > writes, so this is no needed.  When doing I/O in a private folio,
> > the caller usually has a reference as it needs to do something with
> > it.  What is the reason for the special pattern here? A somewhat
> > more descriptive name and a comment would help to describe why
> > it's done this way.
> The reason for this pattern is to prevent a race condition between
> metadata I/O and inode eviction (e.g., during umount). ni->folio holds
> mft record blocks (e.g., one 4KB folio containing four 1KB mft
> records). When an MFT record is written to disk via submit_bio(), if a
> concurrent umount occurs, the inode could be evicted, and
> ntfs_evict_big_inode() would call folio_put(ni->folio). If this
> happens before the I/O completes, the folio could be released
> prematurely, potentially leading to data corruption or use-after-free.
> To prevent this, I increment the folio reference count with
> folio_get() before submit_bio() and decrement it in ntfs_bio_end_io().
> I will add the comment for this.

Thanks!

Something else I just noticed:  I think the implementation of the wait
flag in ntfs_dev_write is wrong.  folio_wait_stable only waits for the
writeback bit to be cleared when mapping_stable_writes is set, but even
without that I don't think you can even rely on the writeback bit to be
set at this point.  If the data needs to be on-disk when this function
returns, I'd call filemap_write_and_wait_range for the entire range
after the folio write loop instead.  Or maybe even in the caller
that wants it?

