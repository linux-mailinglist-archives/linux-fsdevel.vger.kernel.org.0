Return-Path: <linux-fsdevel+bounces-51746-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 90476ADB031
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Jun 2025 14:29:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 38208166A42
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Jun 2025 12:29:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD97827932E;
	Mon, 16 Jun 2025 12:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="3P88bOlP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 877992E426F;
	Mon, 16 Jun 2025 12:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750076976; cv=none; b=eF0HtzlgVSs5ijXLysyDqIPQWgcDZkMX8qQEJBsuoFs9pAuVu15ccHUWhToTQ0egJKujr5wwV1hIAgfrFhEhcD0sWsUEJg07QcXQdfDSxx8/Y/UcyxLg2y9VtHIqJYfcGoGmrgW12m2IqipDuNjMo5/ABCN+iaWawP3JI77SXWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750076976; c=relaxed/simple;
	bh=n045b6Wwmq/0iA6xfvmGicVfYKpjoHI7wPxHAVBNIFg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kvpajEbEOHDxlPL2lMw0FNiyAWWgEvI8MOIevVgGE6UWJpn/EAV+tY6jqNcNx7X1U++zIpwcPUz1SShAb3OakHaC8gdl6S6ocraCx0loRF08DJv0XpyJVu4QJPyzw2HR54zDPZF2dEO43K2Qp3mgIWuiX7chM6d7V2tRgoI5XYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=3P88bOlP; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=GngkD/7DmmttFCuhZsXj9MnB3Ca7xwbk3vWkMVYWsEw=; b=3P88bOlPsSBtagMZMHgBcpZbIN
	PYwsq+rtdm0dF8kiJjOBXU7mgXbjZqv1malQayI580X4QGgHrlHwzZsBshN6bBXdu4yzM0iK2w6mZ
	1/bC0t9vmPZgLgMFvVWu/ZzGj/EyTpDMIn28fwWJ9+mktHMxVbTDbnIiFbCD3ggzveVGvltDu0ZXt
	ye/TGVJ3m5Igbm+jjZxEWTHYxA8BJtuaZBryN4O+hZ5etRSvmyDQvgXWs6ZvJB+i2AGmZL6KCg4dp
	lu3KQY1zTTOr1IDLOhKnLTwoG4vSIa4JliVUs30chSV0R5bvGq3w7giDxA3iOixFLczLEbMU3A0jr
	wZ3mZxmw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uR8xw-00000004N7Z-1RfG;
	Mon, 16 Jun 2025 12:29:32 +0000
Date: Mon, 16 Jun 2025 05:29:32 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Mike Snitzer <snitzer@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>, Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
	david.flynn@hammerspace.com
Subject: Re: need SUNRPC TCP to receive into aligned pages [was: Re: [PATCH
 1/6] NFSD: add the ability to enable use of RWF_DONTCACHE for all IO]
Message-ID: <aFAOLAOsWngZV_aL@infradead.org>
References: <20250610205737.63343-2-snitzer@kernel.org>
 <4b858fb1-25f6-457f-8908-67339e20318e@oracle.com>
 <aEnWhlXjzOmRfCJf@kernel.org>
 <7c48e17c4b575375069a4bd965f346499e66ac3a.camel@kernel.org>
 <aEn2-mYA3VDv-vB8@kernel.org>
 <110c7644b829ce158680979e6cd358193ea3f52b.camel@kernel.org>
 <d13ef7d6-0040-40ac-9761-922a1ec5d911@oracle.com>
 <f201c16677525288597becfd904d873931092cea.camel@kernel.org>
 <aEu7GSa7HRNNVJVA@infradead.org>
 <aEvuJP7_xhVk5R4S@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aEvuJP7_xhVk5R4S@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Fri, Jun 13, 2025 at 05:23:48AM -0400, Mike Snitzer wrote:
> Which in practice has proven a hard requirement for O_DIRECT in my
> testing

What fails if you don't page align the memory?

> But if you looking at patch 5 in this series:
> https://lore.kernel.org/linux-nfs/20250610205737.63343-6-snitzer@kernel.org/
> 
> I added fs/nfsd/vfs.c:is_dio_aligned(), which is basically a tweaked
> ditto of fs/btrfs/direct-io.c:check_direct_IO():

No idea why btrfs still has this, but it's not a general requirement
from the block layer or other file system.  You just need to be
aligned to the dma alignment in the queue limits, which for most NVMe,
SCSI or ATA devices reports a dword alignment.  Some of the more
obscure drivers might require more alignment, or just report it due to
copy and paste.

> What I found is that unless SUNRPC TPC stored the WRITE payload in a
> page-aligned boundary then iov_iter_alignment() would fail.

iov_iter_alignment would fail, or yout check based on it?  The latter
will fail, but it doesn't check anything that matters :)


