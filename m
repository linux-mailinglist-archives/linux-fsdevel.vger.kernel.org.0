Return-Path: <linux-fsdevel+bounces-50979-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3FA7AD186D
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Jun 2025 07:57:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 912BF163B88
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Jun 2025 05:57:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1D4328002D;
	Mon,  9 Jun 2025 05:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="zWTufMdY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E9B1610D;
	Mon,  9 Jun 2025 05:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749448658; cv=none; b=TRV7jriqwMzOSQaf8awuPxlBcZGpVti8QEGPWnoC4znkTbvaceQi1SeZWAxbhSBcInbOy7Cfem7/c2ymL9yF2CYAxGmrhKY8dGosV4zLV9DyqS/5t/Fia6uFXU1DY8jeE3AT4/auLZ8zqWkZurQ92+zejTQ3dhWvKqfLH8jgEgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749448658; c=relaxed/simple;
	bh=ROy9DCwKg9WhALCAG0qSyHchSaksQT16L+Zxa66fq7E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mSIJ4M8rAgw6vLZ96toYiJwvW4Wx/tYP4oTjEkskKbf2v68m9jgf2UX22WYki0Wbc91OP6DLcfUDGplWLHOIoVIV5JyD46Nw0/miIkhiFNrP/0nG2t/iFjE1MxJbULJtDyMkOxauU48JyvwBU4DsYRhJunzVuluH8tvcboCvg8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=zWTufMdY; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=QmbCqDTU1vo0+kBXXdLx5eu90d7rZVaJfa2pRpGsQEQ=; b=zWTufMdYXY7x6HSMRg5tfoc+ww
	vozIGpMAjWkIw8MeesRnIEUyh5zY3U4TqgkCNn1tZCWAT03kIhwqtJ3aFRc6o5wDHi3WRCV9+5zCN
	GUM49/rav+JI7kAQXUiPyQXcWv6jf6nWf8h8c9eblF/O7xy28KY9OHGeXKTp2q8SnpYH3O28b/MIy
	1qmBZC+lluhLGXy8ceZqDa/Nz/junIcW1k8+2HsU4kdfUGZwguZnFRYWhRrwyKai2W8Hzfhed5c3s
	mZV9jLzjjq78mcALUW7ymSMjlpqHWKs1aC6sKHG+ZLFoz7B1a+2eIIRTcsuLuluXOJt+BD0cgs3FX
	0LfNXlQg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uOVVn-00000003UDJ-0JdY;
	Mon, 09 Jun 2025 05:57:35 +0000
Date: Sun, 8 Jun 2025 22:57:35 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Chuck Lever <chuck.lever@oracle.com>
Cc: Cedric Blancher <cedric.blancher@gmail.com>,
	Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
	linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: LInux NFSv4.1 client and server- case insensitive filesystems
 supported?
Message-ID: <aEZ3zza0AsDgjUKq@infradead.org>
References: <CALXu0Ufzm66Ors3aBBrua0-8bvwqo-=RCmiK1yof9mMUxyEmCQ@mail.gmail.com>
 <CALXu0Ufgv7RK7gDOK53MJsD+7x4f0+BYYwo2xNXidigxLDeuMg@mail.gmail.com>
 <44250631-2b70-4ce8-b513-a632e70704ed@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44250631-2b70-4ce8-b513-a632e70704ed@oracle.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Sat, Jun 07, 2025 at 02:30:37PM -0400, Chuck Lever wrote:
> Until very recently, the Linux dentry cache supported only case-
> sensitive file name lookups, and all of the file systems that NFSD is
> regularly tested with are case-preserving.

Linux has supported case insensitive file system since 1992 when Werner
added the original msdos FAT support, i.e. it exists much longer than
the dcache or knfsd.

Specific support for dealing with case insensitive in the dcache instead
working around it was added in 2008 for the case insensitive XFS
directories in 2008:

commit 9403540c0653122ca34884a180439ddbfcbcb524
Author: Barry Naujok <bnaujok@sgi.com>
Date:   Wed May 21 16:50:46 2008 +1000

    dcache: Add case-insensitive support d_ci_add() routine

That being said no one ever intended any of these to be exported over
NFS, and I also question the sanity of anyone wanting to use case
insensitive file systems over NFS.

