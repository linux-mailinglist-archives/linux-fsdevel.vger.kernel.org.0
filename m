Return-Path: <linux-fsdevel+bounces-71182-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CAC5ECB7F0E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Dec 2025 06:23:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 232F13065604
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Dec 2025 05:20:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC7A830DED0;
	Fri, 12 Dec 2025 05:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="XzZ28v2u"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAF132777F9;
	Fri, 12 Dec 2025 05:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765516818; cv=none; b=p7gJogO/V++SVTvL+2VMtjK/9t5RfDhZHGM00Frds1jf+lHtmKTyYtUzMW72KBWnrqHCOkjzZ+2XqoYo3nczcCVePauvkB8wVzCJR5KvQS34gvSmYEwMBxQTZAU7YbYgwuonSssCdRhDfKeN09vL8D/pYPQusquDnn5WpRxUWDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765516818; c=relaxed/simple;
	bh=BHbgECpXGyWYrd3arug7glmivJdfb3Uxvb8E7qUIMVE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sNKofDZKZNFg9cJdFmMXYOVgoA7cFGtiW7ArF9BkZNz+8i1rgE6H5GtfpcuBlbQVViPTHJtaC0Ke7ailZ1RY67RbEL/oyg39zNdoq52pPQBQMl3dM0KeBVcWp8752KUSMnExo6UWM1Kb2ggqquxyyyGiUS2O85X6yaokjqoFexw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=XzZ28v2u; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=BHbgECpXGyWYrd3arug7glmivJdfb3Uxvb8E7qUIMVE=; b=XzZ28v2u1+SmOZEFoB9B1+ohl+
	Gz82ZEI68MrTHqRp/R7q9FV/HaL4wFNHEEiJso40F4o+PYejq+LaTc0Jbbp1aQdR/sU2wamMs9vml
	G33DK4ZsxVgggKz1pudB3/hM0ZKVHzPffqQrvgm2cgPHlsVomq8JQfA+068rNrc5oNu1PJpzuR40M
	SB+AyAfOPbBlVA/jLj0CtxQ0HpZm6rw4lKDh7vy+QgXOL9Jy3t55aLLqvZyWe0/agGVbC/O6lvsQS
	0cwzbEmbWkufuU/GeJdrwiQsiFKy/gJS1qqn4uUMJK7RPTm9Lzirly5cCccu3fh6WMjM8JFTxNnRO
	M8etO/Qw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vTvZZ-000000006ZH-2DmJ;
	Fri, 12 Dec 2025 05:20:09 +0000
Date: Thu, 11 Dec 2025 21:20:09 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Chuck Lever <cel@kernel.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
	linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
	hirofumi@mail.parknet.co.jp,
	almaz.alexandrovich@paragon-software.com, tytso@mit.edu,
	adilger.kernel@dilger.ca, Volker.Lendecke@sernet.de,
	Chuck Lever <chuck.lever@oracle.com>
Subject: Re: [PATCH v2 0/6] Exposing case folding behavior
Message-ID: <aTumCVzHTgoHcd9m@infradead.org>
References: <20251211152116.480799-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251211152116.480799-1-cel@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Thu, Dec 11, 2025 at 10:21:10AM -0500, Chuck Lever wrote:
> - Support NTFS and ext4 in addition to FAT

Still missing at least xfs, hfs, hfsplus and exfat, nfs and cifs.


