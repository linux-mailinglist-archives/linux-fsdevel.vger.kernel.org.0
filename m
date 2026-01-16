Return-Path: <linux-fsdevel+bounces-74040-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 672EAD2A645
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jan 2026 03:54:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 545F13055759
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jan 2026 02:52:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF75B340A41;
	Fri, 16 Jan 2026 02:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="XJUGRv6i"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 033903358CB
	for <linux-fsdevel@vger.kernel.org>; Fri, 16 Jan 2026 02:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768531935; cv=none; b=S3yaUD8cKE997F/HFq5SGZyuTiulYxAw1EA24i5yZN1ZsyKgciVXflZYO0SBIHutxTc5QEMhuVXiyQ8TKMT+qa9dcO+nkywOMMojM7SyJJAtggQsdOBLQDBuzmoaBgtrOcBuCfX2sX82LLHJzqz1cqmu8n5LjMGpVo+MeikB85g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768531935; c=relaxed/simple;
	bh=cZX+XJGLCH4zhQmhFOlIsxnFESyYnRtYGiFjATIdI1c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IiGhKFYtZC2bLoXf4CG9TJX4xqvWy43ZfHq1UCGeoUSOs8SdryOoEBPHJbJvUQG3VWD8i+fazoLoZFjF17ZsQKT/ROVOHQ/+66GfQqwHP/G90e36+z6R1vXYBD6FkAAsYQvzeOaW6XZUrmHqiutKC361VJmeEeCaipsveahkcrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=XJUGRv6i; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=NcTGbcrUSM8c8mgdfkgNPzv52q+M99/G4wWGJwHpZ1c=; b=XJUGRv6iJ9MNcDCoIwXtnzsqm6
	WdBpB0tmJ+o7xeWzSSqo9VaepbJm14B7GXE9hItSa9C+daiDZL8MU1+AFe0SnPQr2qjGXK07OlYgB
	V1DG32vYjnoK3CYzM4PZsgIUecxvz8d3vJL3G/JQJghDtb03XZH+Kt8f0UEo95h8yCDNvlAVQflwl
	tSskgBMKRRLWWCxmA6dd5rOkQkmwBS3/VANT9whk3oZ3QiyW4o/PKZOxpuPadudmrNSANCAafUPJT
	dpbnodWtHUj5Hg3iiGJWPqazGdBV88aYnVxy4MjtCUIAA20eGABBKuEIth+NMWCbkvhQFPqqP1Dgb
	pkxG7/sA==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vgZwW-00000008mQB-403K;
	Fri, 16 Jan 2026 02:52:09 +0000
Date: Fri, 16 Jan 2026 02:52:08 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: brauner@kernel.org, djwong@kernel.org, hch@infradead.org,
	bfoster@redhat.com, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 1/1] iomap: fix readahead folio refcounting race
Message-ID: <aWmn2FympQXOMst-@casper.infradead.org>
References: <20260116015452.757719-1-joannelkoong@gmail.com>
 <20260116015452.757719-2-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260116015452.757719-2-joannelkoong@gmail.com>

On Thu, Jan 15, 2026 at 05:54:52PM -0800, Joanne Koong wrote:
> readahead_folio() returns the next folio from the readahead control
> (rac) but it also drops the refcount on the folio that had been held by
> the rac. As such, there is only one refcount remaining on the folio
> (which is held by the page cache) after this returns.
> 
> This is problematic because this opens a race where if the folio does
> not have an iomap_folio_state struct attached to it and the folio gets
> read in by the filesystem's IO helper, folio_end_read() may have already
> been called on the folio (which will unlock the folio) which allows the
> page cache to evict the folio (dropping the refcount and leading to the
> folio being freed), which leads to use-after-free issues when
> subsequent logic in iomap_readahead_iter() or iomap_read_end() accesses
> that folio.

This explanation is overly complex to the point of being misleading.
If it reflects your current thinking (as opposed to being copied over
from the previous version), it explains why you're having trouble.

The rule is simple.  Once you call folio_end_read(), the folio is
not yours any more.  You can't touch it again; you can't call
folio_size(), you can't call folio_end_read() again.

This discourse about refcounts and descriptions of how the page cache
currently behaves is unnecessary and confusing; it's something that's
going to change in the future and it's not relevant to filesystem authors.

So let's write something simple:

If the folio does not have an iomap_folio_state struct attached to it and
the folio gets read in by the filesystem's IO helper, folio_end_read()
may have already been called on the folio

Fix this by invalidating ctx->cur_folio when a folio without
iomap_folio_state metadata attached to it has been handed to the
filesystem's IO helper.

Fixes: b2f35ac4146d ("iomap: add caller-provided callbacks for read and readahead")
Signed-off-by: Joanne Koong <joannelkoong@gmail.com>

> +			if (!ifs) {
> +				ctx->cur_folio = NULL;
> +				if (unlikely(plen != folio_len))
> +				    return -EIO;

This should be indented with a tab, not four spaces.  Can it even
happen?  If we didn't attach an ifs, can we do a short read?

