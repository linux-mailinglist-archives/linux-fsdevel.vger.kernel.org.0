Return-Path: <linux-fsdevel+bounces-31864-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AFD399C48E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Oct 2024 11:02:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 184EE2886BE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Oct 2024 09:02:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 817941DDEA;
	Mon, 14 Oct 2024 09:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="2cPGw0JO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8252714D6EB;
	Mon, 14 Oct 2024 09:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728896539; cv=none; b=Y4y3Wa3s6XD74JJzI+U2GVk1pHPvNBgcJ3Z/uIYnwqt568f+8Kt5HMtgpjZ+j1T5pcrrOS6W6D5eAA2XBWDFJcy2O2rtibELnPQbJOdHFE5YYHILmRYCGzEcc/UBP7/A7/Kb4MC/6uq3f/3/f4LY6RYtedQiP3fLriDA/y5jouY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728896539; c=relaxed/simple;
	bh=SC5TVik2Xxca7/VhWdKwosUr9zEWIXPsOrWR/3NySFk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EEKYkovgXzXZ+/VF3G1C6QR/0WgUuRIC/sNjQrlnJYfWIBPiO3I+ygcjzQXDSFtIjsJoi+4I7qOZ6nRhkATkn+yq9xjrIN5LRNjOZy0zUs3ryf0shCguobKN6aF4mA/sTFd02/qK1hMinOR90rUg1I0B1Qx9GIpbepaztpIxCr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=2cPGw0JO; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=I1o3feqvMCIzR4DfO8N4j2JacDyYMM5NCJMg3xk+TCE=; b=2cPGw0JOJr4TdveJLcRiOhb3NK
	RLAXU/H6JVEoI6fC7MOyaY4JalrfkMnYEHZwjqJMHkKe7jCqp0pDQUdp2y6EYTH1iVWGHzOODykjI
	KGfbDMT9oG45coa3kR8w+m2LBHBbp0dUD6/OaDVTG7Gx7aL1zWmUCohtlNe01ET57+hc+lN0q0PCp
	t9DhXptIH67ZMvfsaT1frgxKynIGQ/ok93TOBo7gFJnLFHPjJQH76e6a8HRYCVwPjuhlCT5fZyvs7
	pvmnezun86TUtTgFG7TReWn9NW9s3S3EeZ/aUecf0xlKomVDE0gdY5aGviaYx1MhSq4F20yFqgPW/
	h63yxoig==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1t0Gy1-00000004Pbq-3gqy;
	Mon, 14 Oct 2024 09:02:17 +0000
Date: Mon, 14 Oct 2024 02:02:17 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Burn Alting <burn.alting@iinet.net.au>
Cc: audit@vger.kernel.org, linux-security-module@vger.kernel.org,
	linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [RFC PATCH v1 1/7] fs: Add inode_get_ino() and implement
 get_ino() for NFS
Message-ID: <ZwzeGausiU0IDkFy@infradead.org>
References: <ZwkaVLOFElypvSDX@infradead.org>
 <20241011.ieghie3Aiye4@digikod.net>
 <ZwkgDd1JO2kZBobc@infradead.org>
 <20241011.yai6KiDa7ieg@digikod.net>
 <Zwkm5HADvc5743di@infradead.org>
 <20241011.aetou9haeCah@digikod.net>
 <Zwk4pYzkzydwLRV_@infradead.org>
 <20241011.uu1Bieghaiwu@digikod.net>
 <05cb94c0dda9e1b23fe566c6ecd71b3d1739b95b.camel@kernel.org>
 <0e4e7a6d-09e0-480d-baa9-a2e7522a088a@iinet.net.au>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0e4e7a6d-09e0-480d-baa9-a2e7522a088a@iinet.net.au>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Mon, Oct 14, 2024 at 07:40:37PM +1100, Burn Alting wrote:
> As someone who lives in the analytical user space of Linux audit,  I take it
> that for large (say >200TB) file systems, the inode value reported in audit
> PATH records is no longer forensically defensible and it's use as a
> correlation item is of questionable value now?

What do you mean with forensically defensible?

A 64-bit inode number is supposed to be unique.  Some file systems
(most notably btrfs, but probably also various non-native file system)
break and this, and get away with lots of userspace hacks papering
over it.  If you are on a 32-bit system and not using the LFS APIs
stat will fail with -EOVERFLOW.  Some file systems have options to
never generate > 32bit inode numbers.  None of that is directly
related to file system size, although at least for XFS file system
size is one relevant variable, but 200TB is in no way relevant.


