Return-Path: <linux-fsdevel+bounces-73603-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 640B7D1C8BB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jan 2026 06:08:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 827A2306B757
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jan 2026 05:01:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DB4630B501;
	Wed, 14 Jan 2026 05:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="rlITGBJo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 109FD33ADA5;
	Wed, 14 Jan 2026 05:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768366863; cv=none; b=kdLJ0cQQJQdS18Qh3//Nuf3WOR3BoBfM6IYiHESxYZCOBQgMlb5qplnfjXLsDUz4ZGyUFgaJAgZoQozkaznytmcy78uyPqehaw4qRxJb8FoH4T4RRy06byLxfG7jBZ3sB5YomcvYdbczrZbSSXPyMBs3t/hJ4GqKhKvcExNhQyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768366863; c=relaxed/simple;
	bh=4BKTaDv2D5YkNA73YpOclK8poiBgtZbrwGXtFc0K6g0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sarABY+W3d95g0+7eD60ZVlPcc0UUFVhp7mzXMdZ7wTpK+bFsSLOq/qw9jyHR7eKKf3Io8TdSqO69uEieCXpyAQHSz30R063N5yKO4d2jq6Oe45auLAWusOBMLWZBUTPsyQOke/DUgf7YhoCbN/lOAd2tpe+jL2AYOwu+RYVLuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=rlITGBJo; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=s7ksIaZ0R9GnpNVGzvI6paWd7X8ijDFbueiXkHm4znU=; b=rlITGBJoLP5VsQV4bw/44oRAHv
	S3C7NE7l4t/4kTcfkul/CK8HL9jMkRgWhsHNSlQ+9btadkR0itSd0nvvdrhdgy/ENSikSItuqnkTn
	eIQeaY302Dh6d0kosIo0gjtyU6DCOD7MyfnNxUe91W5E3ua28WfwRD8fa26Ijtz5U0JuOqeetPCoz
	K66iLLMeJsuidNyO7Jn+5YCZLafqVowhMMwNZ7x8chy3SIpsba9ChfGLTTHhiHar8IrLb+HfwJbTM
	psdfTQQRSHMt8G2YOqEkmucSCQL16vFIehEwgX1d8EeRzy2owtihQH7jcOBVxeWUfUtVZ4VkuSSme
	A3SqvbBQ==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vfszw-00000005iFi-04XG;
	Wed, 14 Jan 2026 05:00:48 +0000
Date: Wed, 14 Jan 2026 05:00:47 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Andrey Albershteyn <aalbersh@redhat.com>
Cc: fsverity@lists.linux.dev, linux-xfs@vger.kernel.org,
	ebiggers@kernel.org, linux-fsdevel@vger.kernel.org,
	aalbersh@kernel.org, djwong@kernel.org, david@fromorbit.com,
	hch@lst.de
Subject: Re: [PATCH v2 0/23] fs-verity support for XFS with post EOF merkle
 tree
Message-ID: <aWci_1Uu5XndYNkG@casper.infradead.org>
References: <cover.1768229271.patch-series@thinky>
 <aWZ0nJNVTnyuFTmM@casper.infradead.org>
 <op5poqkjoachiv2qfwizunoeg7h6w5x2rxdvbs4vhryr3aywbt@cul2yevayijl>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <op5poqkjoachiv2qfwizunoeg7h6w5x2rxdvbs4vhryr3aywbt@cul2yevayijl>

On Tue, Jan 13, 2026 at 07:45:47PM +0100, Andrey Albershteyn wrote:
> On 2026-01-13 16:36:44, Matthew Wilcox wrote:
> > On Mon, Jan 12, 2026 at 03:49:44PM +0100, Andrey Albershteyn wrote:
> > > The tree is read by iomap into page cache at offset 1 << 53. This is far
> > > enough to handle any supported file size.
> > 
> > What happens on 32-bit systems?  (I presume you mean "offset" as
> > "index", so this is 1 << 65 bytes on machines with a 4KiB page size)
> > 
> it's in bytes, yeah I missed 32-bit systems, I think I will try to
> convert this offset to something lower on 32-bit in iomap, as
> Darrick suggested.

Hm, we use all 32 bits of folio->index on 32-bit plaftorms.  That's
MAX_LFS_FILESIZE.  Are you proposing reducing that?

There are some other (performance) penalties to using 1<<53 as the lowest
index for metadata on 64-bit.  The radix tree is going to go quite high;
we use 6 bits at each level, so if you have a folio at 0 and a folio at
1<<53, you'll have a tree of height 9 and use 17 nodes.

That's going to be a lot of extra cache misses when walking the XArray
to find any given folio.  Allowing the filesystem to decide where the
metadata starts for any given file really is an important optimisation.
Even if it starts at index 1<<29, you'll almost halve the number of
nodes needed.

Adding this ability to support RW merkel trees is certainly coming at
a cost.  Is it worth it?  I haven't seen a user need for that articulated,
but I haven't been paying close attention.

