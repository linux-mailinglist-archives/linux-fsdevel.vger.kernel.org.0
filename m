Return-Path: <linux-fsdevel+bounces-51234-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 052DBAD4C29
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Jun 2025 08:58:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 694D916F811
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Jun 2025 06:58:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E468C22D4EB;
	Wed, 11 Jun 2025 06:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="adl1+1do"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E73F4086A;
	Wed, 11 Jun 2025 06:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749625107; cv=none; b=RkqbWzOGOynM2UOUr0HTZ/09v5iVt8NVovRYdlC0MbIhDm7EAUOPszNNHEkLwVzirMa+ztkjTNTC7/Nw9yGmwIztonm7z2tls1JnQAsFsBgOJfIk8AhaS38Euq2GJqQUFFknCL7FCKu/LUYTghISiAyLmkvws5A13kAQHywJXw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749625107; c=relaxed/simple;
	bh=wYNsx+eBdMR7yHU7qYyVjUVWiSKjF5WAnbAhQ4Sq+tA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o6haUWmShwrBFWpcq2N69EP9t1FZ+BVcgCMewWXK6JdCFUmUR1HmUZiTc49lV76QrxuoZM6xPZiYygF39diV5HEII+QAmB6BUSHMyhw2cxPxKnNZ4pLFBoTolBKMarVRzJpvBZ6rG2g3qrf7rjXT2Qw35OeAiYFl4wT08WeZIKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=adl1+1do; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=BIqsvCrnxM6nBx0S6LgOzGzXS4n0zOn9CmMfzvpu7I8=; b=adl1+1doXglt/kZ7J5CrwDxoSB
	/a5FWqRFbdFp0ZqnMcY8r17TJ+kAt/75KIH3CmvrP45qNvXeympnpPYfc92sLU8QzS1BvZadCMKN3
	G/wF3B0hchUZo4gIs89oCDgwOCQsW3oJznF89JH+SdPyPSVnJZelZxpbZh/d+u9pe2acf18Eg6MU4
	pJBOgctZ5V6SkaronUcnoROkNEMWvGwHRPEY5p3b713q4oWvOVlKtAfPAXDUVg7Utp0Mzd88uRKrh
	zirLTgzM23LkRhkuKCMcu7L+P16GcBa/EVyPTTDmKq6TTEomADFvAtnBrK4rfC9yF9nz0uTmGgwU6
	MptH+M4Q==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uPFPl-000000093LM-3AV5;
	Wed, 11 Jun 2025 06:58:25 +0000
Date: Tue, 10 Jun 2025 23:58:25 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Mike Snitzer <snitzer@kernel.org>
Cc: Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>,
	linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH 4/6] fs: introduce RWF_DIRECT to allow using O_DIRECT on
 a per-IO basis
Message-ID: <aEkpEXIpr8aYNZ4k@infradead.org>
References: <20250610205737.63343-1-snitzer@kernel.org>
 <20250610205737.63343-5-snitzer@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250610205737.63343-5-snitzer@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Tue, Jun 10, 2025 at 04:57:35PM -0400, Mike Snitzer wrote:
> Avoids the need to open code do_iter_readv_writev() purely to request
> that a sync iocb make use of IOCB_DIRECT.
> 
> Care was taken to preserve the long-established value for IOCB_DIRECT
> (1 << 17) when introducing RWF_DIRECT.

What is the problem with using vfs_iocb_iter_read instead of
vfs_iter_read and passing the iocb directly?


