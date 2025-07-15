Return-Path: <linux-fsdevel+bounces-55033-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B7493B067D9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Jul 2025 22:41:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E268C561CF6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Jul 2025 20:41:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9979927F183;
	Tue, 15 Jul 2025 20:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="rkI+4BNO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21F4E19ABC3;
	Tue, 15 Jul 2025 20:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752612057; cv=none; b=oys7k8LKnehpDxUSbVpSK+KE7jvu/juWrJzEtpUvAdW7ikbGQolO4jF6lYbFlbTkoCDaT3+DxSPonw9NeVWtEiaZw4q//eewP5HczK88dTjuLBbgehH0J8Fwd3U+qflArKSmw+WPiep/wsBEZvIHWmTrOODH2UrgEAtb/x64FZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752612057; c=relaxed/simple;
	bh=bjgYAM2QLmUopNUDY1m+jMaK0QwGYud5GRBrIM2R+Hc=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=lurG8QA/4vbRPS22aJa6b7hJEGnROOp3htwmsfdMZzj8dFOEv2Zy3eqLJwCnDq9qGX1jSHOD2k2VGmXX0yNd7B3E09U+kff47XiRZhG0wLd08GfN6DS+F9URAZjiq3VisG02eYPOHtNeP/jFksSLnTou5n08ulHE1TYw9GZ/MWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=rkI+4BNO; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:Message-ID:
	Subject:To:From:Date:Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=SYy7+JhvSNYS+NgaNxt53BfDsD6DTcsBMQgVgtXAnMw=; b=rkI+4BNOMXmHOlYzssTyZGMoyL
	aI4+mtJLryNxKiCc4W+ld08C0+bphxREcY/dxe5wfC8vq1Jm/gkORw00fkrVN1wN9ZebXvUZdsASi
	zm/TWcijb+f/QGxCr7JAj8hN/eD1ZF8y8US+BmVKcsXKcioWHpvbobjpz6cJAgAK7CUS1qNhk4uFL
	tjWrM8+Ywd756Z75jpjjjhA98m3aZFKJrVLHToG44C24SvMEzbGkUiMb11sHEeqIF4vneMyjl5vwU
	TzrTkImLRsy3P+dQk+EBbDZjxoBwbifTvRQpCJk58iDMe6EFuJx0uQ/0H2pK8Hk2W4Z21ZbGxiHf4
	6wuu3xaA==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ubmSA-0000000DkmQ-22ck;
	Tue, 15 Jul 2025 20:40:42 +0000
Date: Tue, 15 Jul 2025 21:40:42 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
	Nicolas Pitre <nico@fluxnic.net>, Gao Xiang <xiang@kernel.org>,
	Chao Yu <chao@kernel.org>, linux-erofs@lists.ozlabs.org,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	linux-f2fs-devel@lists.sourceforge.net, Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org,
	David Woodhouse <dwmw2@infradead.org>,
	Richard Weinberger <richard@nod.at>, linux-mtd@lists.infradead.org,
	David Howells <dhowells@redhat.com>, netfs@lists.linux.dev,
	Paulo Alcantara <pc@manguebit.org>,
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
	ntfs3@lists.linux.dev, Steve French <sfrench@samba.org>,
	linux-cifs@vger.kernel.org,
	Phillip Lougher <phillip@squashfs.org.uk>
Subject: Compressed files & the page cache
Message-ID: <aHa8ylTh0DGEQklt@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

I've started looking at how the page cache can help filesystems handle
compressed data better.  Feedback would be appreciated!  I'll probably
say a few things which are obvious to anyone who knows how compressed
files work, but I'm trying to be explicit about my assumptions.

First, I believe that all filesystems work by compressing fixed-size
plaintext into variable-sized compressed blocks.  This would be a good
point to stop reading and tell me about counterexamples.

From what I've been reading in all your filesystems is that you want to
allocate extra pages in the page cache in order to store the excess data
retrieved along with the page that you're actually trying to read.  That's
because compressing in larger chunks leads to better compression.

There's some discrepancy between filesystems whether you need scratch
space for decompression.  Some filesystems read the compressed data into
the pagecache and decompress in-place, while other filesystems read the
compressed data into scratch pages and decompress into the page cache.

There also seems to be some discrepancy between filesystems whether the
decompression involves vmap() of all the memory allocated or whether the
decompression routines can handle doing kmap_local() on individual pages.

So, my proposal is that filesystems tell the page cache that their minimum
folio size is the compression block size.  That seems to be around 64k,
so not an unreasonable minimum allocation size.  That removes all the
extra code in filesystems to allocate extra memory in the page cache.
It means we don't attempt to track dirtiness at a sub-folio granularity
(there's no point, we have to write back the entire compressed bock
at once).  We also get a single virtually contiguous block ... if you're
willing to ditch HIGHMEM support.  Or there's a proposal to introduce a
vmap_file() which would give us a virtually contiguous chunk of memory
(and could be trivially turned into a noop for the case of trying to
vmap a single large folio).


